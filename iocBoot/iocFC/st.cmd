#!../../bin/linux-x86_64/FC

############################################################################### 
# Set up environment 
< envPaths
epicsEnvSet "STREAM_PROTOCOL_PATH" "$(TOP)/db"

###############################################################################
# Allow PV name prefixes and serial port name to be set from the environment
epicsEnvSet "P" "$(P=TEST)"
epicsEnvSet "R" "$(R=FC)"

###############################################################################
## Register all support components
cd "${TOP}"
dbLoadDatabase "dbd/FC.dbd"
FC_registerRecordDeviceDriver pdbbase

###############################################################################
# Set up ASYN ports
drvAsynIPPortConfigure("L0","10.0.0.12:5025",0,0,0) 
#vxi11Configure("L0","10.0.0.12",0,0.0,"inst0",0,0) 
asynOctetSetInputEos("L0", -1, "\n") 
asynOctetSetOutputEos("L0", -1, "\n") 
asynSetTraceIOMask("L0",-1,0x2) 
asynSetTraceMask("L0",-1,0x9) 

###############################################################################
## Load record instances
#dbLoadRecords("db/devFC.db","P=$(P),R=$(R),PORT=L0,A=0")
dbLoadRecords("db/testAsynPortDriver.db","P=$(P),R=$(R),PORT=L0,ADDR=0,TIMEOUT=1")

############################################################################### 
## Start EPICS
cd "${TOP}/iocBoot/${IOC}"
iocInit

## Start any sequence programs
#seq sncxxx,"user=alex"
