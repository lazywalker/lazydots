#!/usr/bin/env bash
# Screen recording controller: fullscreen, region, or stop
# Usage: screen-record.sh [full|region|stop]

set -e

case "${1:-full}" in
    full)
        outfile="$HOME/Videos/Screen_$(date +%Y%m%d_%H%M%S).mp4"
        notify-send -e -u low -i media-record 'Recording started' 'Full screen'
        env DISPLAY=:0 LIBVA_DRIVER_NAME=i965 wf-recorder --audio -c h264_vaapi \
            -d /dev/dri/renderD128 -f "$outfile"
        notify-send -e -u low -i media-record 'Recording stopped' 'Saved to ~/Videos/'
        ;;
    region)
        geometry=$(slurp)
        if [[ -z "$geometry" ]]; then
            notify-send -e -u critical -i dialog-error 'Recording cancelled' 'No region selected'
            exit 1
        fi
        outfile="$HOME/Videos/Screen_$(date +%Y%m%d_%H%M%S).mp4"
        notify-send -e -u low -i media-record 'Recording started' "Region: $geometry"
        env DISPLAY=:0 LIBVA_DRIVER_NAME=i965 wf-recorder --audio -c h264_vaapi \
            -d /dev/dri/renderD128 -g "$geometry" -f "$outfile"
        notify-send -e -u low -i media-record 'Recording stopped' 'Saved to ~/Videos/'
        ;;
    stop)
        pkill -INT wf-recorder
        notify-send -e -u low -i media-record 'Recording stopped' 'wf-recorder terminated'
        ;;
    *)
        echo "Usage: $(basename "$0") [full|region|stop]" >&2
        exit 1
        ;;
esac
