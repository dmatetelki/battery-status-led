#!/bin/bash

# Copyright 2018 Denes Matetelki

# This file is part of battery_status_led.

# battery_status_led is free software: you can redistribute it and/or modify it 
# under the terms of the GNU General Public License v3 as published by the Free 
# Software Foundation.

# battery_status_led is distributed in the hope that it will be useful, but 
# WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or 
# FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License v3 for 
# more details.

# You should have received a copy of the GNU General Public License v3 along 
# with battery_status_led. If not, see 
# https://www.gnu.org/licenses/gpl-3.0.html.

# limits in percentages
LOW=10 # flip LED every 2s
CRIT=5 # flip led every 0.5s

BAT_FULL=`cat /sys/class/power_supply/BAT0/energy_full_design`
CAPSLOCK_LED=`cat /sys/class/leds/input4\:\:capslock/brightness`

LED_DEV=/sys/class/leds/input4\:\:capslock/brightness


CNT=0
while :
do
	# If charging, sleep 1m, then restart the cycle
	STATUS=`cat /sys/class/power_supply/BAT0/status`
	if [ $STATUS == "Charging" ] ; then
		echo 0 > $LED_DEV
		sleep 1m
		continue
	fi

	BAT_NOW=`cat /sys/class/power_supply/BAT0/energy_now`
	BAT_PCT=$(($BAT_NOW * 100 / $BAT_FULL))

	# If battery has more than >10% left, sleep 1m then restart the cycle
	if (($BAT_PCT > $LOW )) ; then
		sleep 1m
		continue
	fi

	sleep 0.5s
	CNT=$((CNT+1))

	# If battery <5% (crytical) flip capslock LED every 0.5s
	if (( $BAT_PCT <= $CRIT )) ; then
		CAPSLOCK_LED=$((1 ^ $CAPSLOCK_LED))
		echo $CAPSLOCK_LED > $LED_DEV 
	# If battery is on low, but not crytical, flip LED every 4th 0.5s (2s)
	elif (( $BAT_PCT <= $LOW )) && (( $CNT % 4 == 1 )) ; then
		CAPSLOCK_LED=$((1 ^ $CAPSLOCK_LED))
		echo $CAPSLOCK_LED > $LED_DEV 
	fi

	# not sure if i need this:
	if (( $CNT > 100000 )) ; then
		CNT=1
	fi
done

