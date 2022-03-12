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
    ui_print "services.cn.google.xml Not found!"
fi

