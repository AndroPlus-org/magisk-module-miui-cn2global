REPLACE="
"

remove_limitation() {
mkdir -p "$1"

cat >"$1/services.cn.google.xml" <<EOF
<?xml version="1.0" encoding="utf-8"?>
<!-- This is the standard set of features for devices that support the CN GMSCore. -->
EOF
}

if [ -f "/system/product/etc/permissions/services.cn.google.xml" ]; then
    PERMISSION_PATH="${MODPATH}/system/product/etc/permissions"
	remove_limitation "${PERMISSION_PATH}"
elif [ -f "/system/etc/permissions/services.cn.google.xml" ]; then
    PERMISSION_PATH="${MODPATH}/system/etc/permissions"
	remove_limitation "${PERMISSION_PATH}"
else
    ui_print "services.cn.google.xml はありませんでした"
fi

DEF_DIALER=`pm list packages|grep com.google.android.dialer`
if [ -n "$DEF_DIALER" ]; then
    cp -a ${MODPATH}/cn2g-optional/GmsConfigOverlayComms.apk ${MODPATH}/system/product/overlay
    ui_print ""
    ui_print "******⚠注意⚠******"
    ui_print "Google 電話アプリを必ずデフォルトの電話アプリに設定してください。"
    ui_print "設定していないと受話できなくなります。"
    ui_print "******⚠注意⚠******"
    ui_print ""
fi

rm -rf ${MODPATH}/cn2g-optional