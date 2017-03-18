/*
 * motor_data.c
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

/* Block parameters (auto storage) */
P_motor_T motor_P = {
  10.0,                                /* Expression: MaxMissedTicks
                                        * Referenced by: '<S2>/Analog Output'
                                        */
  0.0,                                 /* Expression: YieldWhenWaiting
                                        * Referenced by: '<S2>/Analog Output'
                                        */
  10.0,                                /* Expression: MaxMissedTicks
                                        * Referenced by: '<S2>/Analog Input'
                                        */
  0.0,                                 /* Expression: YieldWhenWaiting
                                        * Referenced by: '<S2>/Analog Input'
                                        */
  0.0,                                 /* Expression: id_motor.bias
                                        * Referenced by: '<Root>/Constant'
                                        */
  1.0,                                 /* Expression: 1
                                        * Referenced by: '<Root>/sin(wt)'
                                        */
  0.0,                                 /* Expression: 0
                                        * Referenced by: '<Root>/sin(wt)'
                                        */
  1.0,                                 /* Expression: id_motor.w
                                        * Referenced by: '<Root>/sin(wt)'
                                        */
  0.0099998333341666645,               /* Computed Parameter: sinwt_Hsin
                                        * Referenced by: '<Root>/sin(wt)'
                                        */
  0.99995000041666526,                 /* Computed Parameter: sinwt_HCos
                                        * Referenced by: '<Root>/sin(wt)'
                                        */
  -0.0099998333341666645,              /* Computed Parameter: sinwt_PSin
                                        * Referenced by: '<Root>/sin(wt)'
                                        */
  0.99995000041666526,                 /* Computed Parameter: sinwt_PCos
                                        * Referenced by: '<Root>/sin(wt)'
                                        */
  2.0,                                 /* Expression: id_motor.u0
                                        * Referenced by: '<Root>/Amplitude'
                                        */
  0.0,                                 /* Expression: 0
                                        * Referenced by: '<S1>/Digital Filter'
                                        */

  /*  Expression: [-0.000922175232821972 -0.0027395813331783222 -0.0025503655598835707 0.0035562145771413532 0.013549367545009367 0.01731581678436514 0.0077083830653165266 -0.0064930705905215406 -0.0076804514662222158 0.0060856594458359205 0.013878139826113351 0.00039682797426910922 -0.016872825891287954 -0.0089193939572765613 0.017411950302970741 0.020754592750063871 -0.012260449604470498 -0.034235068878228941 -0.0010657411785084522 0.04777792059929456 0.027396089433145636 -0.059349762472735872 -0.082325989049231066 0.067152220451342684 0.31002347933304503 0.43008758517821305 0.31002347933304503 0.067152220451342684 -0.082325989049231066 -0.059349762472735872 0.027396089433145636 0.04777792059929456 -0.0010657411785084522 -0.034235068878228941 -0.012260449604470498 0.020754592750063871 0.017411950302970741 -0.0089193939572765613 -0.016872825891287954 0.00039682797426910922 0.013878139826113351 0.0060856594458359205 -0.0076804514662222158 -0.0064930705905215406 0.0077083830653165266 0.01731581678436514 0.01354936 */
  { -0.000922175232821972, -0.0027395813331783222, -0.0025503655598835707,
    0.0035562145771413532, 0.013549367545009367, 0.01731581678436514,
    0.0077083830653165266, -0.0064930705905215406, -0.0076804514662222158,
    0.0060856594458359205, 0.013878139826113351, 0.00039682797426910922,
    -0.016872825891287954, -0.0089193939572765613, 0.017411950302970741,
    0.020754592750063871, -0.012260449604470498, -0.034235068878228941,
    -0.0010657411785084522, 0.04777792059929456, 0.027396089433145636,
    -0.059349762472735872, -0.082325989049231066, 0.067152220451342684,
    0.310023479333045, 0.43008758517821305, 0.310023479333045,
    0.067152220451342684, -0.082325989049231066, -0.059349762472735872,
    0.027396089433145636, 0.04777792059929456, -0.0010657411785084522,
    -0.034235068878228941, -0.012260449604470498, 0.020754592750063871,
    0.017411950302970741, -0.0089193939572765613, -0.016872825891287954,
    0.00039682797426910922, 0.013878139826113351, 0.0060856594458359205,
    -0.0076804514662222158, -0.0064930705905215406, 0.0077083830653165266,
    0.01731581678436514, 0.013549367545009367, 0.0035562145771413532,
    -0.0025503655598835707, -0.0027395813331783222, -0.000922175232821972 },
  12.566370614359172,                  /* Expression: id_motor.Tstart
                                        * Referenced by: '<Root>/Start integration'
                                        */
  0.0,                                 /* Expression: 0
                                        * Referenced by: '<Root>/Start integration'
                                        */
  1.0,                                 /* Expression: 1
                                        * Referenced by: '<Root>/Start integration'
                                        */
  0.0,                                 /* Expression: 0
                                        * Referenced by: '<Root>/Integrator'
                                        */
  0.0,                                 /* Expression: 0
                                        * Referenced by: '<Root>/Integrator1'
                                        */
  1.0,                                 /* Expression: 1
                                        * Referenced by: '<Root>/cos(wt)'
                                        */
  0.0,                                 /* Expression: 0
                                        * Referenced by: '<Root>/cos(wt)'
                                        */
  1.0,                                 /* Expression: id_motor.w
                                        * Referenced by: '<Root>/cos(wt)'
                                        */
  0.0099998333341666645,               /* Computed Parameter: coswt_Hsin
                                        * Referenced by: '<Root>/cos(wt)'
                                        */
  0.99995000041666526,                 /* Computed Parameter: coswt_HCos
                                        * Referenced by: '<Root>/cos(wt)'
                                        */
  0.99995000041666526,                 /* Computed Parameter: coswt_PSin
                                        * Referenced by: '<Root>/cos(wt)'
                                        */
  0.0099998333341667356,               /* Computed Parameter: coswt_PCos
                                        * Referenced by: '<Root>/cos(wt)'
                                        */
  75.398223686155035,                  /* Expression: id_motor.Tstop
                                        * Referenced by: '<Root>/Step'
                                        */
  0.0,                                 /* Expression: 0
                                        * Referenced by: '<Root>/Step'
                                        */
  1.0,                                 /* Expression: 1
                                        * Referenced by: '<Root>/Step'
                                        */
  0,                                   /* Expression: Channels
                                        * Referenced by: '<S2>/Analog Output'
                                        */
  0,                                   /* Expression: RangeMode
                                        * Referenced by: '<S2>/Analog Output'
                                        */
  0,                                   /* Expression: VoltRange
                                        * Referenced by: '<S2>/Analog Output'
                                        */
  1,                                   /* Expression: Channels
                                        * Referenced by: '<S2>/Analog Input'
                                        */
  0,                                   /* Expression: RangeMode
                                        * Referenced by: '<S2>/Analog Input'
                                        */
  0                                    /* Expression: VoltRange
                                        * Referenced by: '<S2>/Analog Input'
                                        */
};
