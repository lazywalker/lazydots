##
## pacman -S swayidle
##

#!/bin/sh
killall swayidle 2>/dev/null

# 启动临时监听：给 "*" 加上双引号，彻底防止 Shell 通配符展开
swayidle -w \
    timeout 1 'swaymsg output "*" power off' \
    resume 'swaymsg output "*" power on && killall swayidle' \
    before-sleep 'swaymsg output "*" power on'
