#!/system/bin/sh
# Do NOT assume where your module will be located.
# ALWAYS use $MODDIR if you need to know where this script
# and module is placed.
# This will make sure your module will still work
# if Magisk change its mount point in the future
MODDIR=${0%/*}
# This script will be executed in post-fs-data mode

#resetprop ro.boot.hwc GLOBAL
#resetprop ro.boot.hwcountry GLOBAL

maybe_set_prop() {
    local prop="$1"
    local contains="$2"
    local value="$3"

    if [[ "$(getprop "$prop")" == *"$contains"* ]]; then
        resetprop "$prop" "$value"
    fi
}

maybe_set_prop gsm.sim.operator.numeric "," "44011,44011"
maybe_set_prop gsm.sim.operator.iso-country "," "jp,jp"

# Change to MIUI Global (but less features)
# resetprop ro.product.mod_device "$(getprop "ro.product.mod_device")_global"

# Fix NFC on Xiaomi MIUI 14 (Android 13)
lastVersion=$(getprop ro.build.version.incremental)
lastVersionFilePath=$MODDIR/lastVersion
productDirPath=$MODDIR/system/product
if [ -d "/system/product/pangu/system" ] ; then
	if [ ! -f $lastVersionFilePath ] || [ ! -d "$productDirPath"  ] || [ $(cat $lastVersionFilePath) != $lastVersion ] ; then
	mkdir -p ${productDirPath}
	cp -p -a -R /system/product/pangu/system/* ${productDirPath}
	echo "$lastVersion" >$lastVersionFilePath
	fi
fi