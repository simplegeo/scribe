#! /bin/sh
#
# skeleton	example file to build /etc/init.d/ scripts.
#		This file should be used to construct scripts for /etc/init.d.
#
#		Written by Miquel van Smoorenburg <miquels@cistron.nl>.
#		Modified for Debian 
#		by Ian Murdock <imurdock@gnu.ai.mit.edu>.
#
# Version:	@(#)skeleton  1.9  26-Feb-2001  miquels@cistron.nl
#

PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
DAEMON=/usr/bin/scribed
NAME=scribe
DESC=scribe
DAEMON_OPTS="-c /etc/scribe/scribe.conf"
SCRIBE_CTRL=/usr/bin/scribe_ctrl

test -x $DAEMON || exit 0

# Include scribe defaults if available
if [ -f /etc/default/scribe ] ; then
	. /etc/default/scribe
fi

set -e

case "$1" in
  start)
	echo -n "Starting $DESC: "
	start-stop-daemon --start --quiet --background --exec $DAEMON -- $DAEMON_OPTS
	echo "$NAME."
	;;
  stop)
	echo -n "Stopping $DESC: "
	$SCRIBE_CTRL stop
	echo "$NAME."
	;;
  reload)
	echo "Reloading $DESC configuration files."
	$SCRIBE_CTRL reload
  	;;
  restart)
    echo -n "Restarting $DESC: "
	$SCRIBE_CTRL stop
	sleep 1
	start-stop-daemon --start --quiet --background --exec $DAEMON -- $DAEMON_OPTS
	echo "$NAME."
	;;
  *)
	N=/etc/init.d/$NAME
	echo "Usage: $N {start|stop|restart|reload}" >&2
	exit 1
	;;
esac

exit 0
