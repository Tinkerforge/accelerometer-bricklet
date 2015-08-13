/* accelerometer-bricklet
 * Copyright (C) 2015 Olaf Lüke <olaf@tinkerforge.com>
 *
 * config.h: Accelerometer Bricklet specific configuration
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

#ifndef CONFIG_H
#define CONFIG_H

#include <stdint.h>
#include <stdbool.h>

#include "bricklib/drivers/board/sam3s/SAM3S.h"

#include "accelerometer.h"

#define BRICKLET_FIRMWARE_VERSION_MAJOR 2
#define BRICKLET_FIRMWARE_VERSION_MINOR 0
#define BRICKLET_FIRMWARE_VERSION_REVISION 1

#define BRICKLET_HARDWARE_VERSION_MAJOR 1
#define BRICKLET_HARDWARE_VERSION_MINOR 0
#define BRICKLET_HARDWARE_VERSION_REVISION 0

#define BRICKLET_DEVICE_IDENTIFIER 250

#define PIN_INT2 (BS->pin2_da)
#define PIN_INT1 (BS->pin3_pwm)
#define PIN_LED  (BS->pin4_io)

#define LOGGING_LEVEL LOGGING_DEBUG
#define DEBUG_BRICKLET 0

#define BRICKLET_VALUE_APPLIED_OUTSIDE
#define BRICKLET_HAS_SIMPLE_X3
#define NUM_SIMPLE_VALUES 1
#define INVOCATION_IN_BRICKLET_CODE

typedef struct {
	int32_t value1[NUM_SIMPLE_VALUES];
	int32_t value2[NUM_SIMPLE_VALUES];
	int32_t value3[NUM_SIMPLE_VALUES];
	int32_t last_value1[NUM_SIMPLE_VALUES];
	int32_t last_value2[NUM_SIMPLE_VALUES];
    int32_t last_value3[NUM_SIMPLE_VALUES];

	uint32_t signal_period[NUM_SIMPLE_VALUES];
	uint32_t signal_period_counter[NUM_SIMPLE_VALUES];

	uint32_t threshold_debounce;
	uint32_t threshold_period_current[NUM_SIMPLE_VALUES];
	int32_t  threshold_min1[NUM_SIMPLE_VALUES];
	int32_t  threshold_max1[NUM_SIMPLE_VALUES];
	int32_t  threshold_min2[NUM_SIMPLE_VALUES];
	int32_t  threshold_max2[NUM_SIMPLE_VALUES];
	int32_t  threshold_min3[NUM_SIMPLE_VALUES];
	int32_t  threshold_max3[NUM_SIMPLE_VALUES];
	char     threshold_option[NUM_SIMPLE_VALUES];

	int32_t  threshold_min_save1[NUM_SIMPLE_VALUES];
	int32_t  threshold_max_save1[NUM_SIMPLE_VALUES];
	int32_t  threshold_min_save2[NUM_SIMPLE_VALUES];
	int32_t  threshold_max_save2[NUM_SIMPLE_VALUES];
	int32_t  threshold_min_save3[NUM_SIMPLE_VALUES];
	int32_t  threshold_max_save3[NUM_SIMPLE_VALUES];
	char     threshold_option_save[NUM_SIMPLE_VALUES];

	uint32_t tick;

	uint8_t data_rate;
	uint8_t filter_bandwidth;
	uint8_t full_scale;

	int8_t temperature;
	uint16_t temperature_counter;
	bool led_value;
} BrickContext;

#endif
