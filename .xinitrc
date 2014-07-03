#!/bin/bash

export PATH=$PATH:$HOME/bin
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"
export GTK_PATH="/usr/lib/gtk-3.0:/usr/lib/gtk-2.0"
export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel'
export _JAVA_AWT_WM_NONREPARENTING=1

# fonts
xset +fp /usr/share/fonts/aquafont/
xset +fp /usr/share/fonts/corefonts/
xset +fp /usr/share/fonts/dejavu/
xset +fp /usr/share/fonts/freefonts/
xset +fp /usr/share/fonts/inconsolata/
xset +fp /usr/share/fonts/ja-ipafonts/
xset +fp /usr/share/fonts/liberation-fonts/
xset +fp /usr/share/fonts/libertine-ttf/
xset +fp /usr/share/fonts/misc/
xset +fp /usr/share/fonts/sil-gentium/
xset +fp /usr/share/fonts/terminus/
xset +fp /usr/share/fonts/unifont/
xset +fp /usr/share/fonts/urw-fonts/
xset fp rehash

ulimit -c unlimited

# custom X settings
xrdb $HOME/.Xresources

# set cursor
xsetroot -cursor_name left_ptr

# keyboard
setxkbmap -layout fr -variant bepo
numlockx

# background
hsetroot -fill /data/photos/Chats/flamme+fusae/IMG_7180.JPG

# thunderbird
thunderbird &

# irssi
urxvt -name irssi -e cubox-irc &

wmname LG3D  &

# redshift
gtk-redshift -l 48.52:2.13 -t 6500:4500 -m randr &

# sound volume tray icon
pulseaudio &
volumeicon &
mpd &

# term daemon
# urxvtd -q -f -o

# compositor
compton --paint-on-overlay &

# screensaver
xscreensaver -no-splash &

# keychain
eval `keychain --noask --nogui`

# file browser
# thunar --daemon &

# start wm
ck-launch-session dbus-launch --sh-syntax --exit-with-session awesome

pkill redshift
