/*
 * testAsynPortDriver.h
 * 
 * Asyn driver that inherits from the asynPortDriver class to demonstrate its use.
 * It simulates a digital scope looking at a 1kHz 1000-point noisy sine wave.  Controls are
 * provided for time/division, volts/division, volt offset, trigger delay, noise amplitude, update time,
 * and run/stop.
 * Readbacks are provides for the waveform data, min, max and mean values.
 *
 * Author: Mark Rivers
 *
 * Created Feb. 5, 2009
 */

#include "asynPortDriver.h"


/* These are the drvInfo strings that are used to identify the parameters.
 * They are used by asyn clients, including standard asyn device support */
#define P_XString "X" /* asynOctet, r/w */

/** Class that demonstrates the use of the asynPortDriver base class to greatly simplify the task
  * of writing an asyn port driver.
  * This class does a simple simulation of a digital oscilloscope.  It computes a waveform, computes
  * statistics on the waveform, and does callbacks with the statistics and the waveform data itself. 
  * I have made the methods of this class public in order to generate doxygen documentation for them,
  * but they should really all be private. */
class testAsynPortDriver : public asynPortDriver {
public:
    testAsynPortDriver(const char *portName);
                 
    /* These are the methods that we override from asynPortDriver */
    //virtual asynStatus readInt32(asynUser *pasynUser, epicsInt32 *value);
    //virtual asynStatus writeInt32(asynUser *pasynUser, epicsInt32 value);
    virtual asynStatus readOctet(asynUser *pasynUser, char *value, size_t maxChars, size_t *nActual, int *eomReason);
    virtual asynStatus writeOctet(asynUser *pasynUser, const char *value, size_t maxChars, size_t *nActual);

    /* These are the methods that are new to this class */
    void simTask(void);

protected:
    /** Values used for pasynUser->reason, and indexes into the parameter library. */
    int P_X;
};
