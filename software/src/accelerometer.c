/* accelerometer-bricklet
 * Copyright (C) 2015 Olaf Lüke <olaf@tinkerforge.com>
 *
 * accelerometer.c: Implementation of Accelerometer Bricklet messages
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the
 * Free Software Foundation, Inc., 59 Temple Place - Suite 330,
 * Boston, MA 02111-1307, USA.
 */

#include "accelerometer.h"

#include "brickletlib/bricklet_entry.h"
#include "brickletlib/bricklet_simple_x3.h"
#include "bricklib/bricklet/bricklet_communication.h"
#include "config.h"

#define I2C_EEPROM_ADDRESS_HIGH 84
#define I2C_ADDRESS_HIGH        0b0011101
#define I2C_ADDRESS_LOW         0b0011110

#define SIMPLE_UNIT_ACCELERATION 0

#define VALUE_TO_MG(value) ((value)*1000/((1 << 15)/full_scale_div[BC->full_scale]))

const uint8_t full_scale_div[5] = {2, 4, 6, 8, 16};

const SimpleMessageProperty smp[] = {
	{SIMPLE_UNIT_ACCELERATION, SIMPLE_TRANSFER_VALUE, SIMPLE_DIRECTION_GET}, // TYPE_GET_ACCELERATION
	{SIMPLE_UNIT_ACCELERATION, SIMPLE_TRANSFER_PERIOD, SIMPLE_DIRECTION_SET}, // TYPE_SET_ACCELERATION_CALLBACK_PERIOD
	{SIMPLE_UNIT_ACCELERATION, SIMPLE_TRANSFER_PERIOD, SIMPLE_DIRECTION_GET}, // TYPE_GET_ACCELERATION_CALLBACK_PERIOD
	{SIMPLE_UNIT_ACCELERATION, SIMPLE_TRANSFER_THRESHOLD, SIMPLE_DIRECTION_SET}, // TYPE_SET_ACCELERATION_CALLBACK_THRESHOLD
	{SIMPLE_UNIT_ACCELERATION, SIMPLE_TRANSFER_THRESHOLD, SIMPLE_DIRECTION_GET}, // TYPE_GET_ACCELERATION_CALLBACK_THRESHOLD
	{0, SIMPLE_TRANSFER_DEBOUNCE, SIMPLE_DIRECTION_SET}, // TYPE_SET_DEBOUNCE_PERIOD
	{0, SIMPLE_TRANSFER_DEBOUNCE, SIMPLE_DIRECTION_GET}, // TYPE_GET_DEBOUNCE_PERIOD
};

const SimpleUnitProperty sup[] = {
	{SIMPLE_SIGNEDNESS_UINT, FID_ACCELERATION, FID_ACCELERATION_REACHED, SIMPLE_UNIT_ACCELERATION} // acceleration
};

const uint8_t smp_length = sizeof(smp);

void invocation(const ComType com, const uint8_t *data) {
	switch(((MessageHeader*)data)->fid) {
		case FID_GET_ACCELERATION:
		case FID_SET_ACCELERATION_CALLBACK_PERIOD:
		case FID_GET_ACCELERATION_CALLBACK_PERIOD:
		case FID_SET_ACCELERATION_CALLBACK_THRESHOLD:
		case FID_GET_ACCELERATION_CALLBACK_THRESHOLD:
		case FID_SET_DEBOUNCE_PERIOD:
		case FID_GET_DEBOUNCE_PERIOD: {
			simple_invocation(com, data);
			break;
		}

		case FID_GET_TEMPERATURE: {
			get_temperature(com, (GetTemperature*)data);
			break;
		}

		case FID_SET_CONFIGURATION: {
			set_configuration(com, (SetConfiguration*)data);
			break;
		}

		case FID_GET_CONFIGURATION: {
			get_configuration(com, (GetConfiguration*)data);
			break;
		}

		case FID_LED_ON: {
			led_on(com, (LEDOn*)data);
			break;
		}

		case FID_LED_OFF: {
			led_off(com, (LEDOff*)data);
			break;
		}

		case FID_IS_LED_ON: {
			is_led_on(com, (IsLEDOn*)data);
			break;
		}

		default: {
			BA->com_return_error(data, sizeof(MessageHeader), MESSAGE_ERROR_CODE_NOT_SUPPORTED, com);
			break;
		}
	}
}

void constructor(void) {
	_Static_assert(sizeof(BrickContext) <= BRICKLET_CONTEXT_MAX_SIZE, "BrickContext too big");

	PIN_INT1.type = PIO_INPUT;
	PIN_INT1.attribute = PIO_DEFAULT;
	BA->PIO_Configure(&PIN_INT1, 1);

	PIN_INT2.type = PIO_INPUT;
	PIN_INT2.attribute = PIO_DEFAULT;
	BA->PIO_Configure(&PIN_INT2, 1);

	PIN_LED.type = PIO_OUTPUT_1;
	PIN_LED.attribute = PIO_DEFAULT;
	BA->PIO_Configure(&PIN_LED, 1);

	// Set default values
	BC->data_rate = 0b0110; // 100Hz
	BC->full_scale = 0b001; // 4G
	BC->filter_bandwidth = 0b10; // 200Hz
	BC->temperature_counter = 0;
	BC->led_value = false;

	uint8_t data = (1 << 3); // Enable on INT1
	lis3dsh_write_register(REG_CTRL_REG3, 1, &data);
	data = (1 << 6) | (1 << 4) | (1 << 3); // Use FIFO empty interrupt
	lis3dsh_write_register(REG_CTRL_REG6, 1, &data);
	data = (0b010 << 5); // Use FIFO stream mode
	lis3dsh_write_register(REG_FIFO_CTRL, 1, &data);

	apply_configuration();

	simple_constructor();
}

void destructor(void) {
	simple_destructor();
}

void tick(const uint8_t tick_type) {
	if(tick_type & TICK_TASK_TYPE_CALCULATION) {
		if(PIN_INT1.pio->PIO_PDSR & PIN_INT1.mask) {
			update_acceleration_values();
		}

		BC->temperature_counter++;
		if(BC->temperature_counter >= 1000) {
			BC->temperature_counter = 0;
			int8_t t;
			lis3dsh_read_register(REG_OUT_T, 1, (uint8_t*)&t);
			BC->temperature = t + 25;
		}
	}

	simple_tick(tick_type);
}

void apply_configuration(void) {
	// Enable all axis and use block data update
	uint8_t data = (1 << 0) | (1 << 1) | (1 << 2) | (1 << 3) | (BC->data_rate << 4);
	lis3dsh_write_register(REG_CTRL_REG4, 1, &data);
	data = (BC->full_scale << 3) | (BC->filter_bandwidth << 6);
	lis3dsh_write_register(REG_CTRL_REG5, 1, &data);
}

void set_configuration(const ComType com, const SetConfiguration *data) {
	if((BC->full_scale > 4) || (BC->data_rate > 9) || (BC->filter_bandwidth > 3)) {
		BA->com_return_error(data, sizeof(MessageHeader), MESSAGE_ERROR_CODE_INVALID_PARAMETER, com);
		return;
	}

	BC->full_scale       = data->full_scale;
	BC->filter_bandwidth = data->filter_bandwidth;
	BC->data_rate        = data->data_rate;
	apply_configuration();

	BA->com_return_setter(com, data);
}

void get_configuration(const ComType com, const GetConfiguration *data) {
	GetConfigurationReturn gcr;

	gcr.header           = data->header;
	gcr.header.length    = sizeof(GetConfigurationReturn);
	gcr.full_scale       = BC->full_scale;
	gcr.filter_bandwidth = BC->filter_bandwidth;
	gcr.data_rate        = BC->data_rate;

	BA->send_blocking_with_timeout(&gcr, sizeof(GetConfigurationReturn), com);
}

void get_temperature(const ComType com, const GetTemperature *data) {
	GetTemperatureReturn gtr;

	gtr.header        = data->header;
	gtr.header.length = sizeof(GetTemperatureReturn);
	gtr.temperature   = BC->temperature;

	BA->send_blocking_with_timeout(&gtr, sizeof(GetTemperatureReturn), com);
}

void led_on(const ComType com, const LEDOn *data) {
	BC->led_value = true;
	PIN_LED.type = PIO_OUTPUT_0;
	BA->PIO_Configure(&PIN_LED, 1);

	BA->com_return_setter(com, data);
}

void led_off(const ComType com, const LEDOff *data) {
	BC->led_value = false;
	PIN_LED.type = PIO_OUTPUT_1;
	BA->PIO_Configure(&PIN_LED, 1);

	BA->com_return_setter(com, data);
}

void is_led_on(const ComType com, const IsLEDOn *data) {
	IsLEDOnReturn iledor;
	iledor.header        = data->header;
	iledor.header.length = sizeof(IsLEDOnReturn);
	iledor.value         = BC->led_value;

	BA->send_blocking_with_timeout(&iledor, sizeof(IsLEDOnReturn), com);
}

void update_acceleration_values(void) {
	int16_t values[3] = {0, 0, 0};
	lis3dsh_read_register(REG_OUT_X_L, 3*2, (uint8_t*)values);
	BC->value1[0] = VALUE_TO_MG(values[0]);
	BC->value2[0] = VALUE_TO_MG(values[1]);
	BC->value3[0] = VALUE_TO_MG(values[2]);
}

uint8_t lis3dsh_get_address(void) {
	if(BS->address == I2C_EEPROM_ADDRESS_HIGH) {
		return I2C_ADDRESS_HIGH;
	} else {
		return I2C_ADDRESS_LOW;
	}
}

void lis3dsh_read_register(const uint8_t reg, const uint8_t length, uint8_t *data) {
	const uint8_t port = BS->port - 'a';
	BA->bricklet_select(port);

	BA->TWID_Read(BA->twid,
	              lis3dsh_get_address(),
	              reg,
	              1,
	              data,
	              length,
	              NULL);

	BA->bricklet_deselect(port);
}

void lis3dsh_write_register(const uint8_t reg, const uint8_t length, const uint8_t *data) {
	const uint8_t port = BS->port - 'a';
	BA->bricklet_select(port);

	BA->TWID_Write(BA->twid,
	               lis3dsh_get_address(),
	               reg,
	               1,
	               (uint8_t*)data,
	               length,
	               NULL);

	BA->bricklet_deselect(port);
}
