#!/bin/sh

export PKG_ETC_DIR="$APKG_PKG_DIR/etc"
export PKG_TMP_DIR="$APKG_PKG_DIR/tmp"
export DB_PATH="/volume1/.@twonkmedia"

case "$APKG_PKG_STATUS" in
        install)
                # create Twonky DB directory if not already existing
                if [! -d $DB_PATH ]; then
                    mkdir $DB_PATH
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
