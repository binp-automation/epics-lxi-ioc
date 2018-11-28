#!../../bin/linux-x86_64/LXI

############################################################################### 
# Set up environment 
< envPaths
epicsEnvSet "STREAM_PROTOCOL_PATH" "$(TOP)/db"

###############################################################################
# Allow PV name prefixes and serial port name to be set from the environment
epicsEnvSet "P" "$(P=VEPP4)"
epicsEnvSet "RF" "$(R=FC)"
epicsEnvSet "RS" "$(R=SCOPE)"

###############################################################################
# Register all support components
cd "${TOP}"
dbLoadDatabase "dbd/LXI.dbd"
LXI_registerRecordDeviceDriver pdbbase

###############################################################################

# Set up ASYN ports

drvAsynIPPortConfigure("P_V3FC","freq-counter-v3:5025",0,0,0)
asynOctetSetInputEos("P_V3FC", -1, "\n")
asynOctetSetOutputEos("P_V3FC", -1, "\n")
asynSetTraceIOMask("P_V3FC",-1,0x2)
asynSetTraceMask("P_V3FC",-1,0x9)

drvAsynIPPortConfigure("P_V4FC","freq-counter-v4:5025",0,0,0)
asynOctetSetInputEos("P_V4FC", -1, "\n")
asynOctetSetOutputEos("P_V4FC", -1, "\n")
asynSetTraceIOMask("P_V4FC",-1,0x2)
asynSetTraceMask("P_V4FC",-1,0x9)

#drvAsynIPPortConfigure("L1","10.0.0.12:5025",0,0,0)
#asynOctetSetInputEos("L1", -1, "\n")
#asynOctetSetOutputEos("L1", -1, "\n")
#asynSetTraceIOMask("L1",-1,0x2)
#asynSetTraceMask("L1",-1,0x9)

###############################################################################
## Load record instances
dbLoadRecords("db/devFC.db","P=VEPP3_,R=FREQ_,PORT=P_V3FC,A=0")
dbLoadRecords("db/devFC.db","P=VEPP4_,R=FREQ_,PORT=P_V4FC,A=0")
#dbLoadRecords("db/devScope.db","P=$(P),R=$(RS),PORT=L1,A=0")

############################################################################### 
## Start EPICS
cd "${TOP}/iocBoot/${IOC}"
iocInit

## Start any sequence programs
#seq sncxxx,"user=alex"
