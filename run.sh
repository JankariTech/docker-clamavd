#!/bin/bash
set -m

freshclam
clamd &

pids=`jobs -p`

exitcode=0

function terminate() {
    trap "" CHLD

    for pid in $pids; do
        if ! kill -0 $pid 2>/dev/null; then
            wait $pid
            exitcode=$?
        fi
    done

    kill $pids 2>/dev/null
}

trap terminate CHLD SIGINT SIGTERM
wait

exit $exitcode
