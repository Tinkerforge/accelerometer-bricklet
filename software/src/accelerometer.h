/* accelerometer-bricklet
 * Copyright (C) 2015 Olaf Lüke <olaf@tinkerforge.com>
 *
 * accelerometer.h: Implementation of Accelerometer Bricklet messages
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

#ifndef ACCELEROMETER_H
#define ACCELEROMETER_H

#include <stdint.h>
#include "bricklib/com/com_common.h"

#define FID_GET_ACCELERATION 1
#define FID_SET_ACCELERATION_CALLBACK_PERIOD 2
#define FID_GET_ACCELERATION_CALLBACK_PERIOD 3
#define FID_SET_ACCELERATION_CALLBACK_THRESHOLD 4
#define FID_GET_ACCELERATION_CALLBACK_THRESHOLD 5
#define FID_SET_DEBOUNCE_PERIOD 6
#define FID_GET_DEBOUNCE_PERIOD 7
#define FID_GET_TEMPERATURE 8
#define FID_ACCELERATION 9
#define FID_ACCELERATION_REACHED 10

typedef struct {
	MessageHeader header;
} __attribute__((__packed__)) GetTemperature;

typedef struct {
	MessageHeader header;
	int8_t temperature;
} __attribute__((__packed__)) GetTemperatureReturn;

void get_temperature(const ComType com, const GetTemperature *data);

void invocation(const ComType com, const uint8_t *data);
void constructor(void);
void destructor(void);
void tick(const uint8_t tick_type);

void update_acceleration_values(void);
void lis3dsh_read_register(const uint8_t reg, const uint8_t length, uint8_t *data);
void lis3dsh_write_register(const uint8_t reg, const uint8_t length, const uint8_t *data);

#define REG_INFO1       0x0D
#define REG_INFO2       0x0E
#define REG_WHO_AM_I    0x0F
#define REG_CTRL_REG3   0x23
#define REG_CTRL_REG4   0x20
#define REG_CTRL_REG5   0x24
#define REG_CTRL_REG6   0x25
#define REG_STATUS      0x27
#define REG_OUT_T       0x0C
#define REG_OFF_X       0x10
#define REG_OFF_Y       0x11
#define REG_OFF_Z       0x12
#define REG_CS_X        0x13
#define REG_CS_Y        0x14
#define REG_CS_Z        0x15
#define REG_LC_L        0x16
#define REG_LC_H        0x17
#define REG_STAT        0x18
#define REG_VFC_1       0x1B
#define REG_VFC_2       0x1C
#define REG_VFC_3       0x1D
#define REG_VFC_4       0x1E
#define REG_THRS3       0x1F
#define REG_OUT_X_L     0x28
#define REG_OUT_X_H     0x29
#define REG_OUT_Y_L     0x2A
#define REG_OUT_Y_H     0x2B
#define REG_OUT_Z_L     0x2C
#define REG_OUT_Z_H     0x2D
#define REG_FIFO_CTRL   0x2E
#define REG_FIFO_SRC    0x2F
#define REG_CTRL_REG1   0x21
#define REG_ST1_X       0x40
#define REG_TIM4_1      0x50
#define REG_TIM3_1      0x51
#define REG_TIM2_1      0x52
#define REG_TIM1_1      0x54
#define REG_THRS2_1     0x56
#define REG_THRS1_1     0x57
#define REG_MASK1_B     0x59
#define REG_MASK1_A     0x5A
#define REG_SETT1       0x5B
#define REG_PR1         0x5C
#define REG_TC1         0x5D
#define REG_OUTS1       0x5F
#define REG_PEAK1       0x19
#define REG_CTRL_REG2   0x22
#define REG_ST2_X       0x60
#define REG_TIM4_2      0x70
#define REG_TIM3_2      0x71
#define REG_TIM2_2      0x72
#define REG_TIM1_2      0x74
#define REG_THRS2_2     0x76
#define REG_THRS1_2     0x77
#define REG_MASK2_B     0x79
#define REG_MASK2_A     0x7A
#define REG_SETT2       0x7B
#define REG_PR2         0x7C
#define REG_TC2         0x7D
#define REG_OUTS2       0x7F
#define REG_PEAK2       0x1A
#define REG_DES2        0x78


#endif
