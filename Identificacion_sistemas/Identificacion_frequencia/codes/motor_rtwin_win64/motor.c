/*
 * motor.c
 *
 * Code generation for model "motor".
 *
 * Model version              : 1.22
 * Simulink Coder version : 8.4 (R2013a) 13-Feb-2013
 * C source code generated on : Mon Sep 21 11:19:36 2015
 *
 * Target selection: rtwin.tlc
 * Note: GRT includes extra infrastructure and instrumentation for prototyping
 * Embedded hardware selection: Generic->32-bit x86 compatible
 * Code generation objectives: Unspecified
 * Validation result: Not run
 */
#include "motor.h"
#include "motor_private.h"
#include "motor_dt.h"

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
B_motor_T motor_B;

/* Continuous states */
X_motor_T motor_X;

/* Block states (auto storage) */
DW_motor_T motor_DW;

/* Previous zero-crossings (trigger) states */
PrevZCX_motor_T motor_PrevZCX;

/* Real-time model */
RT_MODEL_motor_T motor_M_;
RT_MODEL_motor_T *const motor_M = &motor_M_;

/*
 * This function updates continuous states using the ODE5 fixed-step
 * solver algorithm
 */
static void rt_ertODEUpdateContinuousStates(RTWSolverInfo *si )
{
  /* Solver Matrices */
  static const real_T rt_ODE5_A[6] = {
    1.0/5.0, 3.0/10.0, 4.0/5.0, 8.0/9.0, 1.0, 1.0
  };

  static const real_T rt_ODE5_B[6][6] = {
    { 1.0/5.0, 0.0, 0.0, 0.0, 0.0, 0.0 },

    { 3.0/40.0, 9.0/40.0, 0.0, 0.0, 0.0, 0.0 },

    { 44.0/45.0, -56.0/15.0, 32.0/9.0, 0.0, 0.0, 0.0 },

    { 19372.0/6561.0, -25360.0/2187.0, 64448.0/6561.0, -212.0/729.0, 0.0, 0.0 },

    { 9017.0/3168.0, -355.0/33.0, 46732.0/5247.0, 49.0/176.0, -5103.0/18656.0,
      0.0 },

    { 35.0/384.0, 0.0, 500.0/1113.0, 125.0/192.0, -2187.0/6784.0, 11.0/84.0 }
  };

  time_T t = rtsiGetT(si);
  time_T tnew = rtsiGetSolverStopTime(si);
  time_T h = rtsiGetStepSize(si);
  real_T *x = rtsiGetContStates(si);
  ODE5_IntgData *id = (ODE5_IntgData *)rtsiGetSolverData(si);
  real_T *y = id->y;
  real_T *f0 = id->f[0];
  real_T *f1 = id->f[1];
  real_T *f2 = id->f[2];
  real_T *f3 = id->f[3];
  real_T *f4 = id->f[4];
  real_T *f5 = id->f[5];
  real_T hB[6];
  int_T i;
  int_T nXc = 2;
  rtsiSetSimTimeStep(si,MINOR_TIME_STEP);

  /* Save the state values at time t in y, we'll use x as ynew. */
  (void) memcpy(y, x,
                (uint_T)nXc*sizeof(real_T));

  /* Assumes that rtsiSetT and ModelOutputs are up-to-date */
  /* f0 = f(t,y) */
  rtsiSetdX(si, f0);
  motor_derivatives();

  /* f(:,2) = feval(odefile, t + hA(1), y + f*hB(:,1), args(:)(*)); */
  hB[0] = h * rt_ODE5_B[0][0];
  for (i = 0; i < nXc; i++) {
    x[i] = y[i] + (f0[i]*hB[0]);
  }

  rtsiSetT(si, t + h*rt_ODE5_A[0]);
  rtsiSetdX(si, f1);
  motor_output();
  motor_derivatives();

  /* f(:,3) = feval(odefile, t + hA(2), y + f*hB(:,2), args(:)(*)); */
  for (i = 0; i <= 1; i++) {
    hB[i] = h * rt_ODE5_B[1][i];
  }

  for (i = 0; i < nXc; i++) {
    x[i] = y[i] + (f0[i]*hB[0] + f1[i]*hB[1]);
  }

  rtsiSetT(si, t + h*rt_ODE5_A[1]);
  rtsiSetdX(si, f2);
  motor_output();
  motor_derivatives();

  /* f(:,4) = feval(odefile, t + hA(3), y + f*hB(:,3), args(:)(*)); */
  for (i = 0; i <= 2; i++) {
    hB[i] = h * rt_ODE5_B[2][i];
  }

  for (i = 0; i < nXc; i++) {
    x[i] = y[i] + (f0[i]*hB[0] + f1[i]*hB[1] + f2[i]*hB[2]);
  }

  rtsiSetT(si, t + h*rt_ODE5_A[2]);
  rtsiSetdX(si, f3);
  motor_output();
  motor_derivatives();

  /* f(:,5) = feval(odefile, t + hA(4), y + f*hB(:,4), args(:)(*)); */
  for (i = 0; i <= 3; i++) {
    hB[i] = h * rt_ODE5_B[3][i];
  }

  for (i = 0; i < nXc; i++) {
    x[i] = y[i] + (f0[i]*hB[0] + f1[i]*hB[1] + f2[i]*hB[2] +
                   f3[i]*hB[3]);
  }

  rtsiSetT(si, t + h*rt_ODE5_A[3]);
  rtsiSetdX(si, f4);
  motor_output();
  motor_derivatives();

  /* f(:,6) = feval(odefile, t + hA(5), y + f*hB(:,5), args(:)(*)); */
  for (i = 0; i <= 4; i++) {
    hB[i] = h * rt_ODE5_B[4][i];
  }

  for (i = 0; i < nXc; i++) {
    x[i] = y[i] + (f0[i]*hB[0] + f1[i]*hB[1] + f2[i]*hB[2] +
                   f3[i]*hB[3] + f4[i]*hB[4]);
  }

  rtsiSetT(si, tnew);
  rtsiSetdX(si, f5);
  motor_output();
  motor_derivatives();

  /* tnew = t + hA(6);
     ynew = y + f*hB(:,6); */
  for (i = 0; i <= 5; i++) {
    hB[i] = h * rt_ODE5_B[5][i];
  }

  for (i = 0; i < nXc; i++) {
    x[i] = y[i] + (f0[i]*hB[0] + f1[i]*hB[1] + f2[i]*hB[2] +
                   f3[i]*hB[3] + f4[i]*hB[4] + f5[i]*hB[5]);
  }

  rtsiSetSimTimeStep(si,MAJOR_TIME_STEP);
}

/* Model output function */
void motor_output(void)
{
  real_T rtb_coswt;
  int32_T cff;
  real_T acc;
  int32_T j;
  if (rtmIsMajorTimeStep(motor_M)) {
    /* set solver stop time */
    if (!(motor_M->Timing.clockTick0+1)) {
      rtsiSetSolverStopTime(&motor_M->solverInfo, ((motor_M->Timing.clockTickH0
        + 1) * motor_M->Timing.stepSize0 * 4294967296.0));
    } else {
      rtsiSetSolverStopTime(&motor_M->solverInfo, ((motor_M->Timing.clockTick0 +
        1) * motor_M->Timing.stepSize0 + motor_M->Timing.clockTickH0 *
        motor_M->Timing.stepSize0 * 4294967296.0));
    }
  }                                    /* end MajorTimeStep */

  /* Update absolute time of base rate at minor time step */
  if (rtmIsMinorTimeStep(motor_M)) {
    motor_M->Timing.t[0] = rtsiGetT(&motor_M->solverInfo);
  }

  if (rtmIsMajorTimeStep(motor_M)) {
    /* Sin: '<Root>/sin(wt)' */
    if (motor_DW.systemEnable != 0) {
      motor_DW.lastSin = sin(motor_P.sinwt_Freq * motor_M->Timing.t[1]);
      motor_DW.lastCos = cos(motor_P.sinwt_Freq * motor_M->Timing.t[1]);
      motor_DW.systemEnable = 0;
    }

    rtb_coswt = ((motor_DW.lastSin * motor_P.sinwt_PCos + motor_DW.lastCos *
                  motor_P.sinwt_PSin) * motor_P.sinwt_HCos + (motor_DW.lastCos *
      motor_P.sinwt_PCos - motor_DW.lastSin * motor_P.sinwt_PSin) *
                 motor_P.sinwt_Hsin) * motor_P.sinwt_Amp + motor_P.sinwt_Bias;

    /* End of Sin: '<Root>/sin(wt)' */

    /* Sum: '<Root>/k' incorporates:
     *  Constant: '<Root>/Constant'
     *  Gain: '<Root>/Amplitude'
     */
    motor_B.k = motor_P.Amplitude_Gain * rtb_coswt + motor_P.Constant_Value;

    /* Outputs for Atomic SubSystem: '<Root>/MOTOR DC ' */

    /* S-Function Block: <S2>/Analog Output */
    {
      {
        ANALOGIOPARM parm;
        parm.mode = (RANGEMODE) motor_P.AnalogOutput_RangeMode;
        parm.rangeidx = motor_P.AnalogOutput_VoltRange;
        RTBIO_DriverIO(0, ANALOGOUTPUT, IOWRITE, 1,
                       &motor_P.AnalogOutput_Channels, &motor_B.k, &parm);
      }
    }

    /* S-Function Block: <S2>/Analog Input */
    {
      ANALOGIOPARM parm;
      parm.mode = (RANGEMODE) motor_P.AnalogInput_RangeMode;
      parm.rangeidx = motor_P.AnalogInput_VoltRange;
      RTBIO_DriverIO(0, ANALOGINPUT, IOREAD, 1, &motor_P.AnalogInput_Channels,
                     &motor_B.AnalogInput, &parm);
    }

    /* End of Outputs for SubSystem: '<Root>/MOTOR DC ' */

    /* DiscreteFir: '<S1>/Digital Filter' */
    acc = motor_B.AnalogInput * motor_P.DigitalFilter_Coefficients[0];
    cff = 1;
    for (j = motor_DW.DigitalFilter_circBuf; j < 50; j++) {
      acc += motor_DW.DigitalFilter_states[j] *
        motor_P.DigitalFilter_Coefficients[cff];
      cff++;
    }

    for (j = 0; j < motor_DW.DigitalFilter_circBuf; j++) {
      acc += motor_DW.DigitalFilter_states[j] *
        motor_P.DigitalFilter_Coefficients[cff];
      cff++;
    }

    motor_B.DigitalFilter = acc;

    /* End of DiscreteFir: '<S1>/Digital Filter' */
  }

  /* Step: '<Root>/Start integration' */
  if (motor_M->Timing.t[0] < motor_P.Startintegration_Time) {
    motor_B.Startintegration = motor_P.Startintegration_Y0;
  } else {
    motor_B.Startintegration = motor_P.Startintegration_YFinal;
  }

  /* End of Step: '<Root>/Start integration' */

  /* Integrator: '<Root>/Integrator' */
  if (rtmIsMajorTimeStep(motor_M)) {
    ZCEventType zcEvent;
    zcEvent = rt_ZCFcn(RISING_ZERO_CROSSING,&motor_PrevZCX.Integrator_Reset_ZCE,
                       motor_B.Startintegration);

    /* evaluate zero-crossings */
    if (zcEvent) {
      motor_X.Integrator_CSTATE = motor_P.Integrator_IC;
    }
  }

  motor_B.Integrator = motor_X.Integrator_CSTATE;
  if (rtmIsMajorTimeStep(motor_M)) {
  }

  /* Integrator: '<Root>/Integrator1' */
  if (rtmIsMajorTimeStep(motor_M)) {
    ZCEventType zcEvent;
    zcEvent = rt_ZCFcn(RISING_ZERO_CROSSING,&motor_PrevZCX.Integrator1_Reset_ZCE,
                       motor_B.Startintegration);

    /* evaluate zero-crossings */
    if (zcEvent) {
      motor_X.Integrator1_CSTATE = motor_P.Integrator1_IC;
    }
  }

  motor_B.Integrator1 = motor_X.Integrator1_CSTATE;
  if (rtmIsMajorTimeStep(motor_M)) {
    /* Product: '<Root>/Product' */
    motor_B.Product = motor_B.DigitalFilter * rtb_coswt;

    /* Sin: '<Root>/cos(wt)' */
    if (motor_DW.systemEnable_g != 0) {
      motor_DW.lastSin_d = sin(motor_P.coswt_Freq * motor_M->Timing.t[1]);
      motor_DW.lastCos_o = cos(motor_P.coswt_Freq * motor_M->Timing.t[1]);
      motor_DW.systemEnable_g = 0;
    }

    /* Product: '<Root>/Product1' incorporates:
     *  Sin: '<Root>/cos(wt)'
     */
    motor_B.Product1 = (((motor_DW.lastSin_d * motor_P.coswt_PCos +
                          motor_DW.lastCos_o * motor_P.coswt_PSin) *
                         motor_P.coswt_HCos + (motor_DW.lastCos_o *
      motor_P.coswt_PCos - motor_DW.lastSin_d * motor_P.coswt_PSin) *
                         motor_P.coswt_Hsin) * motor_P.coswt_Amp +
                        motor_P.coswt_Bias) * motor_B.DigitalFilter;
  }

  /* Step: '<Root>/Step' */
  if (motor_M->Timing.t[0] < motor_P.Step_Time) {
    motor_B.Step = motor_P.Step_Y0;
  } else {
    motor_B.Step = motor_P.Step_YFinal;
  }

  /* End of Step: '<Root>/Step' */

  /* Stop: '<Root>/Stop Simulation' */
  if (rtmIsMajorTimeStep(motor_M) && (motor_B.Step != 0.0)) {
    rtmSetStopRequested(motor_M, 1);
  }

  /* End of Stop: '<Root>/Stop Simulation' */
}

/* Model update function */
void motor_update(void)
{
  real_T HoldSine;
  if (rtmIsMajorTimeStep(motor_M)) {
    /* Update for Sin: '<Root>/sin(wt)' */
    HoldSine = motor_DW.lastSin;
    motor_DW.lastSin = motor_DW.lastSin * motor_P.sinwt_HCos + motor_DW.lastCos *
      motor_P.sinwt_Hsin;
    motor_DW.lastCos = motor_DW.lastCos * motor_P.sinwt_HCos - HoldSine *
      motor_P.sinwt_Hsin;

    /* Update for DiscreteFir: '<S1>/Digital Filter' */
    motor_DW.DigitalFilter_circBuf--;
    if (motor_DW.DigitalFilter_circBuf < 0) {
      motor_DW.DigitalFilter_circBuf = 49;
    }

    motor_DW.DigitalFilter_states[motor_DW.DigitalFilter_circBuf] =
      motor_B.AnalogInput;

    /* End of Update for DiscreteFir: '<S1>/Digital Filter' */
  }

  if (rtmIsMajorTimeStep(motor_M)) {
    /* Update for Sin: '<Root>/cos(wt)' */
    HoldSine = motor_DW.lastSin_d;
    motor_DW.lastSin_d = motor_DW.lastSin_d * motor_P.coswt_HCos +
      motor_DW.lastCos_o * motor_P.coswt_Hsin;
    motor_DW.lastCos_o = motor_DW.lastCos_o * motor_P.coswt_HCos - HoldSine *
      motor_P.coswt_Hsin;
  }

  if (rtmIsMajorTimeStep(motor_M)) {
    rt_ertODEUpdateContinuousStates(&motor_M->solverInfo);
  }

  /* Update absolute time for base rate */
  /* The "clockTick0" counts the number of times the code of this task has
   * been executed. The absolute time is the multiplication of "clockTick0"
   * and "Timing.stepSize0". Size of "clockTick0" ensures timer will not
   * overflow during the application lifespan selected.
   * Timer of this task consists of two 32 bit unsigned integers.
   * The two integers represent the low bits Timing.clockTick0 and the high bits
   * Timing.clockTickH0. When the low bit overflows to 0, the high bits increment.
   */
  if (!(++motor_M->Timing.clockTick0)) {
    ++motor_M->Timing.clockTickH0;
  }

  motor_M->Timing.t[0] = rtsiGetSolverStopTime(&motor_M->solverInfo);

  {
    /* Update absolute timer for sample time: [0.01s, 0.0s] */
    /* The "clockTick1" counts the number of times the code of this task has
     * been executed. The absolute time is the multiplication of "clockTick1"
     * and "Timing.stepSize1". Size of "clockTick1" ensures timer will not
     * overflow during the application lifespan selected.
     * Timer of this task consists of two 32 bit unsigned integers.
     * The two integers represent the low bits Timing.clockTick1 and the high bits
     * Timing.clockTickH1. When the low bit overflows to 0, the high bits increment.
     */
    if (!(++motor_M->Timing.clockTick1)) {
      ++motor_M->Timing.clockTickH1;
    }

    motor_M->Timing.t[1] = motor_M->Timing.clockTick1 *
      motor_M->Timing.stepSize1 + motor_M->Timing.clockTickH1 *
      motor_M->Timing.stepSize1 * 4294967296.0;
  }
}

/* Derivatives for root system: '<Root>' */
void motor_derivatives(void)
{
  /* Derivatives for Integrator: '<Root>/Integrator' */
  {
    ((XDot_motor_T *) motor_M->ModelData.derivs)->Integrator_CSTATE =
      motor_B.Product1;
  }

  /* Derivatives for Integrator: '<Root>/Integrator1' */
  {
    ((XDot_motor_T *) motor_M->ModelData.derivs)->Integrator1_CSTATE =
      motor_B.Product;
  }
}

/* Model initialize function */
void motor_initialize(void)
{
  /* Start for Atomic SubSystem: '<Root>/MOTOR DC ' */

  /* S-Function Block: <S2>/Analog Output */

  /* no initial value should be set */

  /* End of Start for SubSystem: '<Root>/MOTOR DC ' */
  motor_PrevZCX.Integrator_Reset_ZCE = UNINITIALIZED_ZCSIG;
  motor_PrevZCX.Integrator1_Reset_ZCE = UNINITIALIZED_ZCSIG;

  {
    int32_T i;

    /* InitializeConditions for DiscreteFir: '<S1>/Digital Filter' */
    motor_DW.DigitalFilter_circBuf = 0;
    for (i = 0; i < 50; i++) {
      motor_DW.DigitalFilter_states[i] = motor_P.DigitalFilter_InitialStates;
    }

    /* End of InitializeConditions for DiscreteFir: '<S1>/Digital Filter' */
    /* InitializeConditions for Integrator: '<Root>/Integrator' */
    motor_X.Integrator_CSTATE = motor_P.Integrator_IC;

    /* InitializeConditions for Integrator: '<Root>/Integrator1' */
    motor_X.Integrator1_CSTATE = motor_P.Integrator1_IC;
  }

  /* Enable for Sin: '<Root>/sin(wt)' */
  motor_DW.systemEnable = 1;

  /* Enable for Sin: '<Root>/cos(wt)' */
  motor_DW.systemEnable_g = 1;
}

/* Model terminate function */
void motor_terminate(void)
{
  /* Terminate for Atomic SubSystem: '<Root>/MOTOR DC ' */

  /* S-Function Block: <S2>/Analog Output */

  /* no final value should be set */

  /* End of Terminate for SubSystem: '<Root>/MOTOR DC ' */
}

/*========================================================================*
 * Start of Classic call interface                                        *
 *========================================================================*/

/* Solver interface called by GRT_Main */
#ifndef USE_GENERATED_SOLVER

void rt_ODECreateIntegrationData(RTWSolverInfo *si)
{
  UNUSED_PARAMETER(si);
  return;
}                                      /* do nothing */

void rt_ODEDestroyIntegrationData(RTWSolverInfo *si)
{
  UNUSED_PARAMETER(si);
  return;
}                                      /* do nothing */

void rt_ODEUpdateContinuousStates(RTWSolverInfo *si)
{
  UNUSED_PARAMETER(si);
  return;
}                                      /* do nothing */

#endif

void MdlOutputs(int_T tid)
{
  motor_output();

  /* tid is required for a uniform function interface.
   * Argument tid is not used in the function. */
  UNUSED_PARAMETER(tid);
}

void MdlUpdate(int_T tid)
{
  motor_update();

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
  motor_initialize();
}

void MdlTerminate(void)
{
  motor_terminate();
}

/* Registration function */
RT_MODEL_motor_T *motor(void)
{
  /* Registration code */

  /* initialize non-finites */
  rt_InitInfAndNaN(sizeof(real_T));

  /* initialize real-time model */
  (void) memset((void *)motor_M, 0,
                sizeof(RT_MODEL_motor_T));

  {
    /* Setup solver object */
    rtsiSetSimTimeStepPtr(&motor_M->solverInfo, &motor_M->Timing.simTimeStep);
    rtsiSetTPtr(&motor_M->solverInfo, &rtmGetTPtr(motor_M));
    rtsiSetStepSizePtr(&motor_M->solverInfo, &motor_M->Timing.stepSize0);
    rtsiSetdXPtr(&motor_M->solverInfo, &motor_M->ModelData.derivs);
    rtsiSetContStatesPtr(&motor_M->solverInfo, &motor_M->ModelData.contStates);
    rtsiSetNumContStatesPtr(&motor_M->solverInfo, &motor_M->Sizes.numContStates);
    rtsiSetErrorStatusPtr(&motor_M->solverInfo, (&rtmGetErrorStatus(motor_M)));
    rtsiSetRTModelPtr(&motor_M->solverInfo, motor_M);
  }

  rtsiSetSimTimeStep(&motor_M->solverInfo, MAJOR_TIME_STEP);
  motor_M->ModelData.intgData.y = motor_M->ModelData.odeY;
  motor_M->ModelData.intgData.f[0] = motor_M->ModelData.odeF[0];
  motor_M->ModelData.intgData.f[1] = motor_M->ModelData.odeF[1];
  motor_M->ModelData.intgData.f[2] = motor_M->ModelData.odeF[2];
  motor_M->ModelData.intgData.f[3] = motor_M->ModelData.odeF[3];
  motor_M->ModelData.intgData.f[4] = motor_M->ModelData.odeF[4];
  motor_M->ModelData.intgData.f[5] = motor_M->ModelData.odeF[5];
  motor_M->ModelData.contStates = ((real_T *) &motor_X);
  rtsiSetSolverData(&motor_M->solverInfo, (void *)&motor_M->ModelData.intgData);
  rtsiSetSolverName(&motor_M->solverInfo,"ode5");

  /* Initialize timing info */
  {
    int_T *mdlTsMap = motor_M->Timing.sampleTimeTaskIDArray;
    mdlTsMap[0] = 0;
    mdlTsMap[1] = 1;
    motor_M->Timing.sampleTimeTaskIDPtr = (&mdlTsMap[0]);
    motor_M->Timing.sampleTimes = (&motor_M->Timing.sampleTimesArray[0]);
    motor_M->Timing.offsetTimes = (&motor_M->Timing.offsetTimesArray[0]);

    /* task periods */
    motor_M->Timing.sampleTimes[0] = (0.0);
    motor_M->Timing.sampleTimes[1] = (0.01);

    /* task offsets */
    motor_M->Timing.offsetTimes[0] = (0.0);
    motor_M->Timing.offsetTimes[1] = (0.0);
  }

  rtmSetTPtr(motor_M, &motor_M->Timing.tArray[0]);

  {
    int_T *mdlSampleHits = motor_M->Timing.sampleHitArray;
    mdlSampleHits[0] = 1;
    mdlSampleHits[1] = 1;
    motor_M->Timing.sampleHits = (&mdlSampleHits[0]);
  }

  rtmSetTFinal(motor_M, -1);
  motor_M->Timing.stepSize0 = 0.01;
  motor_M->Timing.stepSize1 = 0.01;

  /* External mode info */
  motor_M->Sizes.checksums[0] = (3885338396U);
  motor_M->Sizes.checksums[1] = (4099962556U);
  motor_M->Sizes.checksums[2] = (947956259U);
  motor_M->Sizes.checksums[3] = (1743207197U);

  {
    static const sysRanDType rtAlwaysEnabled = SUBSYS_RAN_BC_ENABLE;
    static RTWExtModeInfo rt_ExtModeInfo;
    static const sysRanDType *systemRan[2];
    motor_M->extModeInfo = (&rt_ExtModeInfo);
    rteiSetSubSystemActiveVectorAddresses(&rt_ExtModeInfo, systemRan);
    systemRan[0] = &rtAlwaysEnabled;
    systemRan[1] = &rtAlwaysEnabled;
    rteiSetModelMappingInfoPtr(motor_M->extModeInfo,
      &motor_M->SpecialInfo.mappingInfo);
    rteiSetChecksumsPtr(motor_M->extModeInfo, motor_M->Sizes.checksums);
    rteiSetTPtr(motor_M->extModeInfo, rtmGetTPtr(motor_M));
  }

  motor_M->solverInfoPtr = (&motor_M->solverInfo);
  motor_M->Timing.stepSize = (0.01);
  rtsiSetFixedStepSize(&motor_M->solverInfo, 0.01);
  rtsiSetSolverMode(&motor_M->solverInfo, SOLVER_MODE_SINGLETASKING);

  /* block I/O */
  motor_M->ModelData.blockIO = ((void *) &motor_B);
  (void) memset(((void *) &motor_B), 0,
                sizeof(B_motor_T));

  /* parameters */
  motor_M->ModelData.defaultParam = ((real_T *)&motor_P);

  /* states (continuous) */
  {
    real_T *x = (real_T *) &motor_X;
    motor_M->ModelData.contStates = (x);
    (void) memset((void *)&motor_X, 0,
                  sizeof(X_motor_T));
  }

  /* states (dwork) */
  motor_M->ModelData.dwork = ((void *) &motor_DW);
  (void) memset((void *)&motor_DW, 0,
                sizeof(DW_motor_T));

  /* data type transition information */
  {
    static DataTypeTransInfo dtInfo;
    (void) memset((char_T *) &dtInfo, 0,
                  sizeof(dtInfo));
    motor_M->SpecialInfo.mappingInfo = (&dtInfo);
    dtInfo.numDataTypes = 14;
    dtInfo.dataTypeSizes = &rtDataTypeSizes[0];
    dtInfo.dataTypeNames = &rtDataTypeNames[0];

    /* Block I/O transition table */
    dtInfo.B = &rtBTransTable;

    /* Parameters transition table */
    dtInfo.P = &rtPTransTable;
  }

  /* Initialize Sizes */
  motor_M->Sizes.numContStates = (2);  /* Number of continuous states */
  motor_M->Sizes.numY = (0);           /* Number of model outputs */
  motor_M->Sizes.numU = (0);           /* Number of model inputs */
  motor_M->Sizes.sysDirFeedThru = (0); /* The model is not direct feedthrough */
  motor_M->Sizes.numSampTimes = (2);   /* Number of sample times */
  motor_M->Sizes.numBlocks = (19);     /* Number of blocks */
  motor_M->Sizes.numBlockIO = (9);     /* Number of block outputs */
  motor_M->Sizes.numBlockPrms = (86);  /* Sum of parameter "widths" */
  return motor_M;
}

/*========================================================================*
 * End of Classic call interface                                          *
 *========================================================================*/
