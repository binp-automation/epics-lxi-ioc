# EPICS LXI IOC

## Build

```sh
cd epics-lxi-ioc

EPICS_BASE=/path/to/epics_base
ASYN=/path/to/AsynDriver
STREAM=/path/to/StreamDevice

./preconf.sh

make
```

## Run

```sh
cd epics-lxi-ioc/iocBoot/iocLXI/
./st.cmd
```
