#!/usr/bin/env bash
#
# For example, if you're measuring your bashrc, put this at the top:
#
#   if [[ $BASHRC_TRACE = 1  && -f /path/to/stopwatch.sh ]] ; then
#       . /path/to/stopwatch.sh
#   else
#     trace() { : $@; }
#   fi
#   trace "source trace"

datecmd="date +%s%3N" # millis
prevtime=0
curtime=$(eval $datecmd)

trace() {
    local message=""
    [[ $# > 0 ]] && message="$1"
    prevtime=$curtime
    curtime=$(eval $datecmd)
    echo -e ">>>> Time since last: $(($curtime - $prevtime)) ms \t:: $message"
}
