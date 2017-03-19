#include "__cf_modelo2.h"
#include <math.h>
#include "modelo2_acc.h"
#include "modelo2_acc_private.h"
#include <stdio.h>
#include "simstruc.h"
#include "fixedpoint.h"
#define CodeFormat S-Function
#define AccDefine1 Accelerator_S-Function
static void mdlOutputs ( SimStruct * S , int_T tid ) { real_T npms24cqkh ;
real_T currentTime ; kmhhjzqfbm * _rtB ; l21rrylqge * _rtP ; ikuld4euqw *
_rtX ; nux2byiznh * _rtDW ; _rtDW = ( ( nux2byiznh * ) ssGetRootDWork ( S ) )
; _rtX = ( ( ikuld4euqw * ) ssGetContStates ( S ) ) ; _rtP = ( ( l21rrylqge *
) ssGetDefaultParam ( S ) ) ; _rtB = ( ( kmhhjzqfbm * ) _ssGetBlockIO ( S ) )
; _rtB -> dm1bxojz14 = ssGetT ( S ) ; ssCallAccelRunBlock ( S , 2 , 1 ,
SS_CALL_MDL_OUTPUTS ) ; npms24cqkh = ssGetT ( S ) ; _rtB -> dm1bxojz14 = ( (
real_T ) ( npms24cqkh >= 1.0 ) * 2.5 * ( real_T ) ( npms24cqkh < 2.0 ) + 2.5
* npms24cqkh * ( real_T ) ( npms24cqkh < 1.0 ) ) + ( 7.5 - 2.5 * npms24cqkh )
* ( real_T ) ( npms24cqkh >= 2.0 ) * ( real_T ) ( npms24cqkh <= 3.0 ) ;
ssCallAccelRunBlock ( S , 2 , 4 , SS_CALL_MDL_OUTPUTS ) ; _rtB -> ktfhlllpi3
= ( ( ikuld4euqw * ) ssGetContStates ( S ) ) -> grvvkv5mvd ;
ssCallAccelRunBlock ( S , 1 , 0 , SS_CALL_MDL_OUTPUTS ) ; ssCallAccelRunBlock
( S , 2 , 7 , SS_CALL_MDL_OUTPUTS ) ; ssCallAccelRunBlock ( S , 2 , 8 ,
SS_CALL_MDL_OUTPUTS ) ; _rtB -> auoifpacsl = 0.0 ; _rtB -> auoifpacsl += _rtP
-> P_2 * _rtX -> ir05uuvloc ; ssCallAccelRunBlock ( S , 2 , 10 ,
SS_CALL_MDL_OUTPUTS ) ; _rtB -> ixqd3wol5u = ssGetT ( S ) ;
ssCallAccelRunBlock ( S , 0 , 0 , SS_CALL_MDL_OUTPUTS ) ; ssCallAccelRunBlock
( S , 2 , 13 , SS_CALL_MDL_OUTPUTS ) ; if ( ssIsSampleHit ( S , 2 , 0 ) ) {
_rtB -> o4xrzpkae3 = _rtB -> auoifpacsl * _rtP -> P_3 ; _rtB -> o4xrzpkae3 /=
_rtP -> P_4 ; } _rtB -> fdjtghdyn2 = _rtB -> imls4wedwn - _rtB -> o4xrzpkae3
; if ( ssIsSampleHit ( S , 2 , 0 ) ) { _rtB -> jefdvvitpt = _rtP -> P_7 *
_rtB -> fdjtghdyn2 ; _rtB -> ojmh3ke252 = _rtP -> P_8 * _rtB -> jefdvvitpt +
_rtDW -> l0qebwqc5v ; _rtB -> ay4njklodt = _rtP -> P_6 * _rtB -> fdjtghdyn2 +
_rtB -> ojmh3ke252 ; ssCallAccelRunBlock ( S , 2 , 20 , SS_CALL_MDL_OUTPUTS )
; } _rtB -> pxbzfgybal = 0.0 ; _rtB -> pxbzfgybal += _rtP -> P_11 * _rtX ->
lpottnwk54 ; if ( ssIsSampleHit ( S , 1 , 0 ) ) { currentTime = ssGetTaskTime
( S , 1 ) ; _rtDW -> ozy1cysopb = ( currentTime >= _rtP -> P_12 ) ; }
UNUSED_PARAMETER ( tid ) ; }
#define MDL_UPDATE
static void mdlUpdate ( SimStruct * S , int_T tid ) { kmhhjzqfbm * _rtB ;
l21rrylqge * _rtP ; nux2byiznh * _rtDW ; _rtDW = ( ( nux2byiznh * )
ssGetRootDWork ( S ) ) ; _rtP = ( ( l21rrylqge * ) ssGetDefaultParam ( S ) )
; _rtB = ( ( kmhhjzqfbm * ) _ssGetBlockIO ( S ) ) ; if ( ssIsSampleHit ( S ,
2 , 0 ) ) { _rtDW -> l0qebwqc5v = _rtP -> P_8 * _rtB -> jefdvvitpt + _rtB ->
ojmh3ke252 ; } UNUSED_PARAMETER ( tid ) ; }
#define MDL_DERIVATIVES
static void mdlDerivatives ( SimStruct * S ) { kmhhjzqfbm * _rtB ; l21rrylqge
* _rtP ; ikuld4euqw * _rtX ; l5cyxqzaiu * _rtXdot ; _rtXdot = ( ( l5cyxqzaiu
* ) ssGetdX ( S ) ) ; _rtX = ( ( ikuld4euqw * ) ssGetContStates ( S ) ) ;
_rtP = ( ( l21rrylqge * ) ssGetDefaultParam ( S ) ) ; _rtB = ( ( kmhhjzqfbm *
) _ssGetBlockIO ( S ) ) ; { ( ( l5cyxqzaiu * ) ssGetdX ( S ) ) -> grvvkv5mvd
= _rtB -> auoifpacsl ; } _rtXdot -> ir05uuvloc = 0.0 ; _rtXdot -> ir05uuvloc
+= _rtP -> P_1 * _rtX -> ir05uuvloc ; _rtXdot -> ir05uuvloc += _rtB ->
pxbzfgybal ; _rtXdot -> lpottnwk54 = 0.0 ; _rtXdot -> lpottnwk54 += _rtP ->
P_10 * _rtX -> lpottnwk54 ; _rtXdot -> lpottnwk54 += _rtB -> ay4njklodt ; }
#define MDL_ZERO_CROSSINGS
static void mdlZeroCrossings ( SimStruct * S ) { l21rrylqge * _rtP ;
j2qqiiedcs * _rtZCSV ; _rtZCSV = ( ( j2qqiiedcs * ) ssGetSolverZcSignalVector
( S ) ) ; _rtP = ( ( l21rrylqge * ) ssGetDefaultParam ( S ) ) ; _rtZCSV ->
o2je0u5hc1 = ssGetT ( S ) - _rtP -> P_12 ; } static void mdlInitializeSizes (
SimStruct * S ) { ssSetChecksumVal ( S , 0 , 3298043486U ) ; ssSetChecksumVal
( S , 1 , 3337386773U ) ; ssSetChecksumVal ( S , 2 , 723292688U ) ;
ssSetChecksumVal ( S , 3 , 3490064736U ) ; { mxArray * slVerStructMat = NULL
; mxArray * slStrMat = mxCreateString ( "simulink" ) ; char slVerChar [ 10 ]
; int status = mexCallMATLAB ( 1 , & slVerStructMat , 1 , & slStrMat , "ver"
) ; if ( status == 0 ) { mxArray * slVerMat = mxGetField ( slVerStructMat , 0
, "Version" ) ; if ( slVerMat == NULL ) { status = 1 ; } else { status =
mxGetString ( slVerMat , slVerChar , 10 ) ; } } mxDestroyArray ( slStrMat ) ;
mxDestroyArray ( slVerStructMat ) ; if ( ( status == 1 ) || ( strcmp (
slVerChar , "8.5" ) != 0 ) ) { return ; } } ssSetOptions ( S ,
SS_OPTION_EXCEPTION_FREE_CODE ) ; if ( ssGetSizeofDWork ( S ) != sizeof (
nux2byiznh ) ) { ssSetErrorStatus ( S ,
"Unexpected error: Internal DWork sizes do "
"not match for accelerator mex file." ) ; } if ( ssGetSizeofGlobalBlockIO ( S
) != sizeof ( kmhhjzqfbm ) ) { ssSetErrorStatus ( S ,
"Unexpected error: Internal BlockIO sizes do "
"not match for accelerator mex file." ) ; } { int ssSizeofParams ;
ssGetSizeofParams ( S , & ssSizeofParams ) ; if ( ssSizeofParams != sizeof (
l21rrylqge ) ) { static char msg [ 256 ] ; sprintf ( msg ,
"Unexpected error: Internal Parameters sizes do "
"not match for accelerator mex file." ) ; } } _ssSetDefaultParam ( S , (
real_T * ) & eqd5cty1uo ) ; rt_InitInfAndNaN ( sizeof ( real_T ) ) ; } static
void mdlInitializeSampleTimes ( SimStruct * S ) { { SimStruct * childS ;
SysOutputFcn * callSysFcns ; childS = ssGetSFunction ( S , 0 ) ; callSysFcns
= ssGetCallSystemOutputFcnList ( childS ) ; callSysFcns [ 3 + 0 ] = (
SysOutputFcn ) ( NULL ) ; childS = ssGetSFunction ( S , 1 ) ; callSysFcns =
ssGetCallSystemOutputFcnList ( childS ) ; callSysFcns [ 3 + 0 ] = (
SysOutputFcn ) ( NULL ) ; } } static void mdlTerminate ( SimStruct * S ) { }
#include "simulink.c"
