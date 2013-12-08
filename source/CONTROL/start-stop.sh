#!/bin/sh -e
HOST_ARCH=$(uname -m)
NAME="Twonky Server"
PKG_PATH=/usr/local/AppCentral/twonkyserver
PKG_DAEMON="$PKG_PATH/twonkyserver/twonkystarter"
USER=root
STOP_TIMEOUT=10
DB_PATH=/volume1/.@twonkymedia
CONFIG_FILE="$PKG_PATH/etc/twonkyserver7.ini"
LOG_FILE="$DB_PATH/log/twonkyserver7.log"
VAR_TWONKY=/var/twonky

# Default options for daemon
OPTIONS="-inifile $CONFIG_FILE -enableweb 2 -powersavemode 1 -logfile $LOG_FILE"

# export PATH="${PATH:+$PATH:}/sbin"
export LD_LIBRARY_PATH="$PKG_PATH/lib"

. /lib/lsb/init-functions

check_db () {
    if [ ! -d $VAR_TWONKY ]; then
        ln -s $DB_PATH $VAR_TWONKY
    fi
}

start_daemon () {
    check_db
    start-stop-daemon --start \
    --chuid $USER \
    --exec $PKG_DAEMON -- $OPTIONS
}

wait_pid () {
    DAEMON=`basename $1`
    TIME=0
    TIMEOUT=$2

    while [ $TIME -lt $TIMEOUT ]; do
        pidof $DAEMON > /dev/null 2>&1
        STATUS=`echo $?`

        if [ $STATUS -eq 1 ]; then
            return 1
        fi

        TIME=$((TIME+1))
        sleep 1
    done
}

case "$1" in
    start)
        echo "Starting $NAME"

        start_daemon
        ;;
    stop)
        echo "Stopping $NAME"

        start-stop-daemon --stop --quiet \
            --exec $PKG_DAEMON --retry $STOP_TIMEOUT \
            --oknodo

        wait_pid $PKG_DAEMON $STOP_TIMEOUT
        
        # remove the symbolic link
        if [ -h $VAR_TWONKY ]; then
            rm $VAR_TWONKY
        fi
        ;;
    reload)
        echo "Reloading $NAME"
        start-stop-daemon --stop --quiet \
            --exec $PKG_DAEMON \
            --oknodo --signal 1
        ;;
    restart|force-reload)
        echo "Restarting $NAME"
        start-stop-daemon --stop --quiet \
            --exec $PKG_DAEMON --retry $STOP_TIMEOUT \
            --oknodo

        wait_pid $PKG_DAEMON $STOP_TIMEOUT

        start_daemon
        ;;
    *)
        echo "Usage: $0 {start|stop|reload|force-reload|restart}"
        exit 2
        ;;
esac

exit 0
