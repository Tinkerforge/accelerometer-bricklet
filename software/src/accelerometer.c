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

		default: {
			BA->com_return_error(data, sizeof(MessageHeader), MESSAGE_ERROR_CODE_NOT_SUPPORTED, com);
			break;
		}
	}
}

void constructor(void) {
	_Static_assert(sizeof(BrickContext) <= BRICKLET_CONTEXT_MAX_SIZE, "BrickContext too big");
	simple_constructor();
}

void destructor(void) {
	simple_destructor();
}

void tick(const uint8_t tick_type) {
	if(tick_type & TICK_TASK_TYPE_CALCULATION) {
		update_acceleration_values();
	}

	simple_tick(tick_type);
}

void get_temperature(const ComType com, const GetTemperature *data) {
	GetTemperatureReturn gtr;

	gtr.header         = data->header;
	gtr.header.length  = sizeof(GetTemperatureReturn);
	lis3dsh_read_register(REG_OUT_T, 1, (uint8_t*)(&gtr.temperature));

	BA->send_blocking_with_timeout(&gtr, sizeof(GetTemperatureReturn), com);
}

void update_acceleration_values(void) {
	int16_t values[3] = {0, 0, 0};
	lis3dsh_read_register(REG_OUT_X_L, 3*2, (uint8_t*)values);
	BC->last_value1[0] = BC->value1[0];
	BC->last_value2[0] = BC->value2[0];
	BC->last_value3[0] = BC->value3[0];
	BC->value1[0] = values[0];
	BC->value2[0] = values[1];
	BC->value3[0] = values[2];
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
