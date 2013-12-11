#!/bin/sh

export PKG_ETC_DIR="$APKG_PKG_DIR/etc"
export PKG_TMP_DIR="$APKG_PKG_DIR/tmp"
export DB_PATH="/volume1/.@twonkymedia"
export APP_INFO_MSG="applog --level 0 --package \"$APKG_PKG_NAME\" --event"

case "$APKG_PKG_STATUS" in
        install)
                # create Twonky DB directory if not already existing
                if [ ! -d $DB_PATH ]; then
					$APP_INFO_MSG "Twonky DB directory doesn't exist create, it will created"
                    mkdir $DB_PATH
				else
					$APP_INFO_MSG "Twonky DB directory does already exist"
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
