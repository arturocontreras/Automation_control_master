/*
 * escalamiento.c
 *
 * Code generation for model "escalamiento".
 *
 * Model version              : 1.5
 * Simulink Coder version : 8.4 (R2013a) 13-Feb-2013
 * C source code generated on : Wed Jun 15 10:25:29 2016
 *
 * Target selection: rtwin.tlc
 * Note: GRT includes extra infrastructure and instrumentation for prototyping
 * Embedded hardware selection: Generic->32-bit x86 compatible
 * Code generation objectives: Unspecified
 * Validation result: Not run
 */
#include "escalamiento.h"
#include "escalamiento_private.h"
#include "escalamiento_dt.h"

/* options for Real-Time Windows Target board 0 */
static double RTWinBoardOptions0[] = {
  0.0,
  0.0,
  0.0,
  0.0,
  0.0,
};

/* list of Real-Time Windows Target timers */
const int RTWinTimerCount = 1;
const double RTWinTimers[2] = {
  0.01, 0.0,
};

/* list of Real-Time Windows Target boards */
const int RTWinBoardCount = 1;
RTWINBOARD RTWinBoards[1] = {
  { "National_Instruments/PCI-6229", 4294967295U, 5, RTWinBoardOptions0 },
};

/* Block signals (auto storage) */
B_escalamiento_T escalamiento_B;

/* Block states (auto storage) */
DW_escalamiento_T escalamiento_DW;

/* Real-time model */
RT_MODEL_escalamiento_T escalamiento_M_;
RT_MODEL_escalamiento_T *const escalamiento_M = &escalamiento_M_;

/* Model output function */
void escalamiento_output(void)
{
  /* local block i/o variables */
  real_T rtb_AnalogInput;

  /* Fcn: '<S1>/Fcn' incorporates:
   *  Constant: '<Root>/input'
   */
  rtb_AnalogInput = 0.033 * escalamiento_P.input_Value;

  /* S-Function Block: <S1>/Analog Output */
  {
    {
      ANALOGIOPARM parm;
      parm.mode = (RANGEMODE) escalamiento_P.AnalogOutput_RangeMode;
      parm.rangeidx = escalamiento_P.AnalogOutput_VoltRange;
      RTBIO_DriverIO(0, ANALOGOUTPUT, IOWRITE, 1,
                     &escalamiento_P.AnalogOutput_Channels, &rtb_AnalogInput,
                     &parm);
    }
  }

  /* S-Function Block: <S1>/Analog Input */
  {
    ANALOGIOPARM parm;
    parm.mode = (RANGEMODE) escalamiento_P.AnalogInput_RangeMode;
    parm.rangeidx = escalamiento_P.AnalogInput_VoltRange;
    RTBIO_DriverIO(0, ANALOGINPUT, IOREAD, 1,
                   &escalamiento_P.AnalogInput_Channels, &rtb_AnalogInput, &parm);
  }

  /* Fcn: '<S1>/Fcn1' */
  escalamiento_B.Fcn1 = 40.683482506102521 * rtb_AnalogInput - 24.414;
}

/* Model update function */
void escalamiento_update(void)
{
  /* Update absolute time for base rate */
  /* The "clockTick0" counts the number of times the code of this task has
   * been executed. The absolute time is the multiplication of "clockTick0"
   * and "Timing.stepSize0". Size of "clockTick0" ensures timer will not
   * overflow during the application lifespan selected.
   * Timer of this task consists of two 32 bit unsigned integers.
   * The two integers represent the low bits Timing.clockTick0 and the high bits
   * Timing.clockTickH0. When the low bit overflows to 0, the high bits increment.
   */
  if (!(++escalamiento_M->Timing.clockTick0)) {
    ++escalamiento_M->Timing.clockTickH0;
  }

  escalamiento_M->Timing.t[0] = escalamiento_M->Timing.clockTick0 *
    escalamiento_M->Timing.stepSize0 + escalamiento_M->Timing.clockTickH0 *
    escalamiento_M->Timing.stepSize0 * 4294967296.0;
}

/* Model initialize function */
void escalamiento_initialize(void)
{
  /* S-Function Block: <S1>/Analog Output */

  /* no initial value should be set */
}

/* Model terminate function */
void escalamiento_terminate(void)
{
  /* S-Function Block: <S1>/Analog Output */

  /* no final value should be set */
}

/*========================================================================*
 * Start of Classic call interface                                        *
 *========================================================================*/
void MdlOutputs(int_T tid)
{
  escalamiento_output();

  /* tid is required for a uniform function interface.
   * Argument tid is not used in the function. */
  UNUSED_PARAMETER(tid);
}

void MdlUpdate(int_T tid)
{
  escalamiento_update();

  /* tid is required for a uniform function interface.
   * Argument tid is not used in the function. */
  UNUSED_PARAMETER(tid);
}

void MdlInitializeSizes(void)
{
}

void MdlInitializeSampleTimes(void)
{
}

void MdlInitialize(void)
{
}

void MdlStart(void)
{
  escalamiento_initialize();
}

void MdlTerminate(void)
{
  escalamiento_terminate();
}

/* Registration function */
RT_MODEL_escalamiento_T *escalamiento(void)
{
  /* Registration code */

  /* initialize non-finites */
  rt_InitInfAndNaN(sizeof(real_T));

  /* initialize real-time model */
  (void) memset((void *)escalamiento_M, 0,
                sizeof(RT_MODEL_escalamiento_T));

  /* Initialize timing info */
  {
    int_T *mdlTsMap = escalamiento_M->Timing.sampleTimeTaskIDArray;
    mdlTsMap[0] = 0;
    escalamiento_M->Timing.sampleTimeTaskIDPtr = (&mdlTsMap[0]);
    escalamiento_M->Timing.sampleTimes =
      (&escalamiento_M->Timing.sampleTimesArray[0]);
    escalamiento_M->Timing.offsetTimes =
      (&escalamiento_M->Timing.offsetTimesArray[0]);

    /* task periods */
    escalamiento_M->Timing.sampleTimes[0] = (0.01);

    /* task offsets */
    escalamiento_M->Timing.offsetTimes[0] = (0.0);
  }

  rtmSetTPtr(escalamiento_M, &escalamiento_M->Timing.tArray[0]);

  {
    int_T *mdlSampleHits = escalamiento_M->Timing.sampleHitArray;
    mdlSampleHits[0] = 1;
    escalamiento_M->Timing.sampleHits = (&mdlSampleHits[0]);
  }

  rtmSetTFinal(escalamiento_M, 10.0);
  escalamiento_M->Timing.stepSize0 = 0.01;

  /* External mode info */
  escalamiento_M->Sizes.checksums[0] = (902870829U);
  escalamiento_M->Sizes.checksums[1] = (1696282983U);
  escalamiento_M->Sizes.checksums[2] = (1259522379U);
  escalamiento_M->Sizes.checksums[3] = (1023939939U);

  {
    static const sysRanDType rtAlwaysEnabled = SUBSYS_RAN_BC_ENABLE;
    static RTWExtModeInfo rt_ExtModeInfo;
    static const sysRanDType *systemRan[1];
    escalamiento_M->extModeInfo = (&rt_ExtModeInfo);
    rteiSetSubSystemActiveVectorAddresses(&rt_ExtModeInfo, systemRan);
    systemRan[0] = &rtAlwaysEnabled;
    rteiSetModelMappingInfoPtr(escalamiento_M->extModeInfo,
      &escalamiento_M->SpecialInfo.mappingInfo);
    rteiSetChecksumsPtr(escalamiento_M->extModeInfo,
                        escalamiento_M->Sizes.checksums);
    rteiSetTPtr(escalamiento_M->extModeInfo, rtmGetTPtr(escalamiento_M));
  }

  escalamiento_M->solverInfoPtr = (&escalamiento_M->solverInfo);
  escalamiento_M->Timing.stepSize = (0.01);
  rtsiSetFixedStepSize(&escalamiento_M->solverInfo, 0.01);
  rtsiSetSolverMode(&escalamiento_M->solverInfo, SOLVER_MODE_SINGLETASKING);

  /* block I/O */
  escalamiento_M->ModelData.blockIO = ((void *) &escalamiento_B);
  (void) memset(((void *) &escalamiento_B), 0,
                sizeof(B_escalamiento_T));

  /* parameters */
  escalamiento_M->ModelData.defaultParam = ((real_T *)&escalamiento_P);

  /* states (dwork) */
  escalamiento_M->ModelData.dwork = ((void *) &escalamiento_DW);
  (void) memset((void *)&escalamiento_DW, 0,
                sizeof(DW_escalamiento_T));

  /* data type transition information */
  {
    static DataTypeTransInfo dtInfo;
    (void) memset((char_T *) &dtInfo, 0,
                  sizeof(dtInfo));
    escalamiento_M->SpecialInfo.mappingInfo = (&dtInfo);
    dtInfo.numDataTypes = 14;
    dtInfo.dataTypeSizes = &rtDataTypeSizes[0];
    dtInfo.dataTypeNames = &rtDataTypeNames[0];

    /* Block I/O transition table */
    dtInfo.B = &rtBTransTable;

    /* Parameters transition table */
    dtInfo.P = &rtPTransTable;
  }

  /* Initialize Sizes */
  escalamiento_M->Sizes.numContStates = (0);/* Number of continuous states */
  escalamiento_M->Sizes.numY = (0);    /* Number of model outputs */
  escalamiento_M->Sizes.numU = (0);    /* Number of model inputs */
  escalamiento_M->Sizes.sysDirFeedThru = (0);/* The model is not direct feedthrough */
  escalamiento_M->Sizes.numSampTimes = (1);/* Number of sample times */
  escalamiento_M->Sizes.numBlocks = (6);/* Number of blocks */
  escalamiento_M->Sizes.numBlockIO = (1);/* Number of block outputs */
  escalamiento_M->Sizes.numBlockPrms = (11);/* Sum of parameter "widths" */
  return escalamiento_M;
}

/*========================================================================*
 * End of Classic call interface                                          *
 *========================================================================*/
