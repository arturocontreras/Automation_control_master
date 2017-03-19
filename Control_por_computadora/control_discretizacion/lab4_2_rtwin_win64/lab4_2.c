/*
 * lab4_2.c
 *
 * Code generation for model "lab4_2".
 *
 * Model version              : 1.13
 * Simulink Coder version : 8.4 (R2013a) 13-Feb-2013
 * C source code generated on : Wed Jun 15 11:53:12 2016
 *
 * Target selection: rtwin.tlc
 * Note: GRT includes extra infrastructure and instrumentation for prototyping
 * Embedded hardware selection: Generic->32-bit x86 compatible
 * Code generation objectives: Unspecified
 * Validation result: Not run
 */
#include "lab4_2.h"
#include "lab4_2_private.h"
#include "lab4_2_dt.h"

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
B_lab4_2_T lab4_2_B;

/* Block states (auto storage) */
DW_lab4_2_T lab4_2_DW;

/* Real-time model */
RT_MODEL_lab4_2_T lab4_2_M_;
RT_MODEL_lab4_2_T *const lab4_2_M = &lab4_2_M_;

/* Model output function */
void lab4_2_output(void)
{
  /* local block i/o variables */
  real_T rtb_Fcn;
  real_T e_act;
  real_T Int;

  /* Step: '<Root>/r' */
  if (lab4_2_M->Timing.t[0] < lab4_2_P.r_Time) {
    lab4_2_B.r = lab4_2_P.r_Y0;
  } else {
    lab4_2_B.r = lab4_2_P.r_YFinal;
  }

  /* End of Step: '<Root>/r' */
  /* S-Function Block: <S2>/Analog Input */
  {
    ANALOGIOPARM parm;
    parm.mode = (RANGEMODE) lab4_2_P.AnalogInput_RangeMode;
    parm.rangeidx = lab4_2_P.AnalogInput_VoltRange;
    RTBIO_DriverIO(0, ANALOGINPUT, IOREAD, 1, &lab4_2_P.AnalogInput_Channels,
                   &rtb_Fcn, &parm);
  }

  /* Fcn: '<S2>/Fcn1' */
  lab4_2_B.Fcn1 = 40.683482506102521 * rtb_Fcn - 24.41;

  /* MATLAB Function: '<Root>/MATLAB Function' incorporates:
   *  Constant: '<Root>/Ki'
   *  Constant: '<Root>/Kp'
   */
  /* MATLAB Function 'MATLAB Function': '<S1>:1' */
  /* '<S1>:1:15' */
  e_act = lab4_2_B.r - lab4_2_B.Fcn1;

  /*  Diferencias en retroceso */
  /*  Prop = (e_act - e_ant)*Kp; */
  /*  Int = e_act*Ki*T; */
  /*  u_act = u_ant + Prop + Int; */
  /*  Kp = 0.9, Ki = 1.2 */
  /*  Aproximacion de Tustin */
  /* '<S1>:1:24' */
  /* Der = Kd/T*(e_act - e_ant); */
  /* '<S1>:1:26' */
  Int = e_act * 0.01 * lab4_2_P.Ki_Value + lab4_2_DW.Int_ant;

  /* '<S1>:1:27' */
  lab4_2_DW.Int_ant = Int;

  /* '<S1>:1:28' */
  e_act = e_act * lab4_2_P.Kp_Value + Int;

  /*  Kp = 0.9, Ki = 1.2 */
  if (e_act < 0.0) {
    /* '<S1>:1:33' */
    /* '<S1>:1:34' */
    e_act = 0.0;
  } else {
    if (e_act > 100.0) {
      /* '<S1>:1:35' */
      /* '<S1>:1:36' */
      e_act = 100.0;
    }
  }

  /* '<S1>:1:39' */
  /* '<S1>:1:40' */
  /* '<S1>:1:41' */
  lab4_2_B.u = e_act;

  /* End of MATLAB Function: '<Root>/MATLAB Function' */

  /* Fcn: '<S2>/Fcn' */
  rtb_Fcn = 0.033 * lab4_2_B.u;

  /* S-Function Block: <S2>/Analog Output */
  {
    {
      ANALOGIOPARM parm;
      parm.mode = (RANGEMODE) lab4_2_P.AnalogOutput_RangeMode;
      parm.rangeidx = lab4_2_P.AnalogOutput_VoltRange;
      RTBIO_DriverIO(0, ANALOGOUTPUT, IOWRITE, 1,
                     &lab4_2_P.AnalogOutput_Channels, &rtb_Fcn, &parm);
    }
  }
}

/* Model update function */
void lab4_2_update(void)
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
  if (!(++lab4_2_M->Timing.clockTick0)) {
    ++lab4_2_M->Timing.clockTickH0;
  }

  lab4_2_M->Timing.t[0] = lab4_2_M->Timing.clockTick0 *
    lab4_2_M->Timing.stepSize0 + lab4_2_M->Timing.clockTickH0 *
    lab4_2_M->Timing.stepSize0 * 4294967296.0;
}

/* Model initialize function */
void lab4_2_initialize(void)
{
  /* S-Function Block: <S2>/Analog Output */

  /* no initial value should be set */

  /* InitializeConditions for MATLAB Function: '<Root>/MATLAB Function' */
  lab4_2_DW.Int_ant = 0.0;
}

/* Model terminate function */
void lab4_2_terminate(void)
{
  /* S-Function Block: <S2>/Analog Output */

  /* no final value should be set */
}

/*========================================================================*
 * Start of Classic call interface                                        *
 *========================================================================*/
void MdlOutputs(int_T tid)
{
  lab4_2_output();

  /* tid is required for a uniform function interface.
   * Argument tid is not used in the function. */
  UNUSED_PARAMETER(tid);
}

void MdlUpdate(int_T tid)
{
  lab4_2_update();

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
  lab4_2_initialize();
}

void MdlTerminate(void)
{
  lab4_2_terminate();
}

/* Registration function */
RT_MODEL_lab4_2_T *lab4_2(void)
{
  /* Registration code */

  /* initialize non-finites */
  rt_InitInfAndNaN(sizeof(real_T));

  /* initialize real-time model */
  (void) memset((void *)lab4_2_M, 0,
                sizeof(RT_MODEL_lab4_2_T));

  /* Initialize timing info */
  {
    int_T *mdlTsMap = lab4_2_M->Timing.sampleTimeTaskIDArray;
    mdlTsMap[0] = 0;
    lab4_2_M->Timing.sampleTimeTaskIDPtr = (&mdlTsMap[0]);
    lab4_2_M->Timing.sampleTimes = (&lab4_2_M->Timing.sampleTimesArray[0]);
    lab4_2_M->Timing.offsetTimes = (&lab4_2_M->Timing.offsetTimesArray[0]);

    /* task periods */
    lab4_2_M->Timing.sampleTimes[0] = (0.01);

    /* task offsets */
    lab4_2_M->Timing.offsetTimes[0] = (0.0);
  }

  rtmSetTPtr(lab4_2_M, &lab4_2_M->Timing.tArray[0]);

  {
    int_T *mdlSampleHits = lab4_2_M->Timing.sampleHitArray;
    mdlSampleHits[0] = 1;
    lab4_2_M->Timing.sampleHits = (&mdlSampleHits[0]);
  }

  rtmSetTFinal(lab4_2_M, -1);
  lab4_2_M->Timing.stepSize0 = 0.01;

  /* External mode info */
  lab4_2_M->Sizes.checksums[0] = (3931554395U);
  lab4_2_M->Sizes.checksums[1] = (1019231422U);
  lab4_2_M->Sizes.checksums[2] = (3618099013U);
  lab4_2_M->Sizes.checksums[3] = (2612197751U);

  {
    static const sysRanDType rtAlwaysEnabled = SUBSYS_RAN_BC_ENABLE;
    static RTWExtModeInfo rt_ExtModeInfo;
    static const sysRanDType *systemRan[2];
    lab4_2_M->extModeInfo = (&rt_ExtModeInfo);
    rteiSetSubSystemActiveVectorAddresses(&rt_ExtModeInfo, systemRan);
    systemRan[0] = &rtAlwaysEnabled;
    systemRan[1] = &rtAlwaysEnabled;
    rteiSetModelMappingInfoPtr(lab4_2_M->extModeInfo,
      &lab4_2_M->SpecialInfo.mappingInfo);
    rteiSetChecksumsPtr(lab4_2_M->extModeInfo, lab4_2_M->Sizes.checksums);
    rteiSetTPtr(lab4_2_M->extModeInfo, rtmGetTPtr(lab4_2_M));
  }

  lab4_2_M->solverInfoPtr = (&lab4_2_M->solverInfo);
  lab4_2_M->Timing.stepSize = (0.01);
  rtsiSetFixedStepSize(&lab4_2_M->solverInfo, 0.01);
  rtsiSetSolverMode(&lab4_2_M->solverInfo, SOLVER_MODE_SINGLETASKING);

  /* block I/O */
  lab4_2_M->ModelData.blockIO = ((void *) &lab4_2_B);
  (void) memset(((void *) &lab4_2_B), 0,
                sizeof(B_lab4_2_T));

  /* parameters */
  lab4_2_M->ModelData.defaultParam = ((real_T *)&lab4_2_P);

  /* states (dwork) */
  lab4_2_M->ModelData.dwork = ((void *) &lab4_2_DW);
  (void) memset((void *)&lab4_2_DW, 0,
                sizeof(DW_lab4_2_T));

  /* data type transition information */
  {
    static DataTypeTransInfo dtInfo;
    (void) memset((char_T *) &dtInfo, 0,
                  sizeof(dtInfo));
    lab4_2_M->SpecialInfo.mappingInfo = (&dtInfo);
    dtInfo.numDataTypes = 14;
    dtInfo.dataTypeSizes = &rtDataTypeSizes[0];
    dtInfo.dataTypeNames = &rtDataTypeNames[0];

    /* Block I/O transition table */
    dtInfo.B = &rtBTransTable;

    /* Parameters transition table */
    dtInfo.P = &rtPTransTable;
  }

  /* Initialize Sizes */
  lab4_2_M->Sizes.numContStates = (0); /* Number of continuous states */
  lab4_2_M->Sizes.numY = (0);          /* Number of model outputs */
  lab4_2_M->Sizes.numU = (0);          /* Number of model inputs */
  lab4_2_M->Sizes.sysDirFeedThru = (0);/* The model is not direct feedthrough */
  lab4_2_M->Sizes.numSampTimes = (1);  /* Number of sample times */
  lab4_2_M->Sizes.numBlocks = (12);    /* Number of blocks */
  lab4_2_M->Sizes.numBlockIO = (3);    /* Number of block outputs */
  lab4_2_M->Sizes.numBlockPrms = (15); /* Sum of parameter "widths" */
  return lab4_2_M;
}

/*========================================================================*
 * End of Classic call interface                                          *
 *========================================================================*/
