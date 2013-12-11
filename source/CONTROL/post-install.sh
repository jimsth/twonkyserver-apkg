#!/bin/sh

export PKG_NAME="Twonky Server"
export PKG_ETC_DIR="$APKG_PKG_DIR/etc"
export PKG_TMP_DIR="$APKG_PKG_DIR/tmp"
export DB_PATH="/volume1/.@twonkymedia"

case "$APKG_PKG_STATUS" in
		install)
				# create Twonky DB directory if not already existing
				if [ ! -d $DB_PATH ]; then
					applog --level 0 --package "$PKG_NAME" --event "Twonky DB directory doesn't exist, it will created"
					mkdir -p $DB_PATH/twonkyserver
					chown -R admin:administrators $DB_PATH
				else
					applog --level 0 --package "$PKG_NAME" --event "Twonky DB directory does already exist"
				fi
				;;
		upgrade)
				cp -af $APKG_TEMP_DIR/* $PKG_ETC_DIR
				;;
		*)
				;;
esac

mkdir -p $PKG_TMP_DIR

exit 0
