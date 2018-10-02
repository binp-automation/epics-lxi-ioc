TOP=../..

include $(TOP)/configure/CONFIG
#----------------------------------------
#  ADD MACRO DEFINITIONS AFTER THIS LINE
#=============================

#=============================
# Build the IOC application

PROD_IOC = FC
# FC.dbd will be created and installed
DBD += FC.dbd

# FC.dbd will be made up from these files:
FC_DBD += base.dbd

# Include dbd files from all support applications:
FC_DBD += asyn.dbd stream.dbd drvAsynIPPort.dbd drvVxi11.dbd

# Add all the support libraries needed by this IOC
FC_LIBS += stream asyn

# FC_registerRecordDeviceDriver.cpp derives from FC.dbd
FC_SRCS += FC_registerRecordDeviceDriver.cpp

# Build the main IOC entry point on workstation OSs.
FC_SRCS_DEFAULT += FCMain.cpp
FC_SRCS_vxWorks += -nil-

# Add support from base/src/vxWorks if needed
#FC_OBJS_vxWorks += $(EPICS_BASE_BIN)/vxComLibrary

# Finally link to the EPICS Base libraries
FC_LIBS += $(EPICS_BASE_IOC_LIBS)

#===========================

include $(TOP)/configure/RULES
#----------------------------------------
#  ADD RULES AFTER THIS LINE


