#!/bin/sh

if [ -z "$EPICS_BASE" ]
then
    echo "\$EPICS_BASE is empty"
    exit 1
fi

if [ -z "$ASYN" ]
then
    echo "\$ASYN is empty"
    exit 1
fi

if [ -z "$STREAM" ]
then
    echo "\$STREAM is empty"
    exit 1
fi

cat configure/RELEASE.local.pre \
| sed -s "/EPICS_BASE =/c\EPICS_BASE = $EPICS_BASE" \
| sed -s "/ASYN =/c\ASYN = $ASYN" \
| sed -s "/STREAM =/c\STREAM = $STREAM" \
> configure/RELEASE.local
