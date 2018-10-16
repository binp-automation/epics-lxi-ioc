TOP=../..

include $(TOP)/configure/CONFIG
#----------------------------------------
#  ADD MACRO DEFINITIONS AFTER THIS LINE
#=============================

#=============================
# Build the IOC application

PROD_IOC = LXI
# LXI.dbd will be created and installed
DBD += LXI.dbd

# LXI.dbd will be made up from these files:
LXI_DBD += base.dbd

# Include dbd files from all support applications:
LXI_DBD += asyn.dbd stream.dbd drvAsynIPPort.dbd drvVxi11.dbd

# Add all the support libraries needed by this IOC
LXI_LIBS += stream asyn

# LXI_registerRecordDeviceDriver.cpp derives from LXI.dbd
LXI_SRCS += LXI_registerRecordDeviceDriver.cpp

# Build the main IOC entry point on workstation OSs.
LXI_SRCS_DEFAULT += LXIMain.cpp
LXI_SRCS_vxWorks += -nil-

# Add support from base/src/vxWorks if needed
#LXI_OBJS_vxWorks += $(EPICS_BASE_BIN)/vxComLibrary

# Finally link to the EPICS Base libraries
LXI_LIBS += $(EPICS_BASE_IOC_LIBS)

#===========================

include $(TOP)/configure/RULES
#----------------------------------------
#  ADD RULES AFTER THIS LINE


