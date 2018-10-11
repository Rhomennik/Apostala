#!/bin/bash

## Set login wallpaper

# strip new line char passed by Nautilus
FILENAME=$(echo $NAUTILUS_SCRIPT_SELECTED_FILE_PATHS | sed -e 's/\r//g')

# Multiple files can't be selected.
LINE_COUNT=$(wc -l <<< "$NAUTILUS_SCRIPT_SELECTED_FILE_PATHS")
LINE_COUNT=$((LINE_COUNT-1))

if [[ $LINE_COUNT > 1 ]] ; then
    zenity --error --text "Ony one file can be selected at a time! "
    exit 1
fi

# Object type must be "file..." (ie no directories, etc.)
if [ -d "${FILENAME}" ] ; then
    zenity --error --text "$FILENAME is a directory!";
    exit 1
else
    if [ -f "${FILENAME}" ]; then
        : # Bash noop
    else
        zenity --error --text "${FILENAME} is not a file!";
        exit 2
    fi
fi

# Build working file in /tmp
echo "[com.canonical.unity-greeter]" > /tmp/set-login-wallpaper.tmp
echo "draw-user-backgrounds=false" >> /tmp/set-login-wallpaper.tmp
echo "background='$FILENAME'" >> /tmp/set-login-wallpaper.tmp

# Must run as sudo
if [ "$EUID" -ne 0 ] ; then

    # Get sudo password
    PASSWORD=$(zenity --password --title="Set Login Wallpaper" --timeout=20)

    # copy working file to real file using sudo
    echo $PASSWORD | sudo -S cp /tmp/set-login-wallpaper.tmp \
/usr/share/glib-2.0/schemas/10_unity_greeter_background.gschema.override

    # compile using sudo
    echo $PASSWORD | sudo -S glib-compile-schemas /usr/share/glib-2.0/schemas

else
    # Already sudo so simply copy and compile
    # copy working file to real file
    cp /tmp/set-login-wallpaper.tmp \
/usr/share/glib-2.0/schemas/10_unity_greeter_background.gschema.override

    # compile
    glib-compile-schemas /usr/share/glib-2.0/schemas
fi

exit 0
