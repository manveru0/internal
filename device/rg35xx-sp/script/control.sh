#!/bin/sh

. /opt/muos/script/var/func.sh
. /opt/muos/script/var/init/system.sh

RMP_LOG="/mnt/mmc/MUOS/log/device.log"
LOG_DATE="$(date +'[%Y-%m-%d]')"

# Move control.ini for ppsspp standalone
CONTROL_INI="$(GET_VAR "device" "storage/rom/mount")/MUOS/emulator/ppsspp/.config/ppsspp/PSP/SYSTEM/controls.ini"
if [ ! -f "$CONTROL_INI" ]; then
	cp "$DEVICE_CONTROL_DIR/controls.ini" "$CONTROL_INI"
fi

# Move mupen64plus-rice.cfg for external mupen64plus
MP64RICE="$(GET_VAR "device" "storage/rom/mount")/MUOS/emulator/mupen64plus/mupen64plus-rice.cfg"
if [ ! -f "$MP64RICE" ]; then
	cp "$DEVICE_CONTROL_DIR/mupen64plus-rice.cfg" "$MP64RICE"
fi

# Move mupen64plus-gl64.cfg for external mupen64plus
MP64GL64="$(GET_VAR "device" "storage/rom/mount")/MUOS/emulator/mupen64plus/mupen64plus-gl64.cfg"
if [ ! -f "$MP64GL64" ]; then
	cp "$DEVICE_CONTROL_DIR/mupen64plus-gl64.cfg" "$MP64GL64"
fi

# Move RetroArch configurations
RA_CONF="$(GET_VAR "device" "storage/rom/mount")/MUOS/retroarch/retroarch.cfg"
if [ ! -f "$RA_CONF" ]; then
	cp "$DEVICE_CONTROL_DIR/retroarch.cfg" "$RA_CONF"
fi

# Move DraStic Steward config
DRSTU_JSON="$(GET_VAR "device" "storage/rom/mount")/MUOS/emulator/drastic-steward/resources/settings.json"
if [ ! -f "$DRSTU_JSON" ]; then
	cp -f "$DEVICE_CONTROL_DIR/drastic-steward.json" "$DRSTU_JSON"
fi

# Move DraStic configuration
cp -f "$DEVICE_CONTROL_DIR/drastic.cfg" "$(GET_VAR "device" "storage/rom/mount")/MUOS/emulator/drastic/config/drastic.cfg"

# Move OpenBOR config
for file in "$DEVICE_CONTROL_DIR/openbor/"*.ini; do
	if [ ! -f "$(GET_VAR "device" "storage/rom/mount")/MUOS/emulator/openbor/userdata/system/configs/openbor/$(basename "$file")" ]; then
		cp "$file" "$(GET_VAR "device" "storage/rom/mount")/MUOS/emulator/openbor/userdata/system/configs/openbor/"
	fi
done

# Set GBA SP Overlay as default in gpSP / mGBA
GP_CFG="/run/muos/storage/info/config/gpSP/gpSP.cfg"
if [ ! -f "$GP_CFG.bak" ]; then
	cp "$GP_CFG" "$GP_CFG.bak"
	cp -f "$DEVICE_CONTROL_DIR/gpSP.cfg" "$GP_CFG"
fi

MG_CFG="/run/muos/storage/info/config/mGBA/mGBA.cfg"
if [ ! -f "$MG_CFG.bak" ]; then
	cp "$MG_CFG" "$MG_CFG.bak"
	cp -f "$DEVICE_CONTROL_DIR/mGBA.cfg" "$MG_CFG"
fi
