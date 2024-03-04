#!/usr/bin/env bash

# sets volume to 25% on headphone plugin and 50% on unplug

set -eu -o pipefail

# this user should be main user running pulse
PULSE_USER="$(ps -o user= -p $(pidof pulseaudio) | head -n1)"

if [[ -z "$PULSE_USER" ]]; then
    logger "no user running pulseaudio, aborting"
    exit
fi

PULSE_UID="$(id -u ${PULSE_USER})"
PULSE_COOKIE="$(eval echo ~${PULSE_USER})/.config/pulse/cookie"
PULSE_SERVER="/var/run/user/${PULSE_UID}/pulse/native"

if ! [[ -S "$PULSE_SERVER" ]]; then
    logger "pulseaudio server socket not found at ${PULSE_SERVER}, aborting"
    exit
fi

if ! [[ -f "$PULSE_COOKIE" ]]; then
    logger "pulseaudio cookie not found at ${PULSE_COOKIE}, aborting"
    exit
fi

case "$(echo "$@" | cut -d" " -f3)" in
    plug)
        PULSE_COOKIE=$PULSE_COOKIE PULSE_SERVER="unix:${PULSE_SERVER}" amixer -D pulse set Master 25%
        ;;
    unplug)
        PULSE_COOKIE=$PULSE_COOKIE PULSE_SERVER="unix:${PULSE_SERVER}" amixer -D pulse set Master 50%
        ;;
esac
