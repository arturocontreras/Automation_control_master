  function targMap = targDataMap(),

  ;%***********************
  ;% Create Parameter Map *
  ;%***********************
      
    nTotData      = 0; %add to this count as we go
    nTotSects     = 2;
    sectIdxOffset = 0;
    
    ;%
    ;% Define dummy sections & preallocate arrays
    ;%
    dumSection.nData = -1;  
    dumSection.data  = [];
    
    dumData.logicalSrcIdx = -1;
    dumData.dtTransOffset = -1;
    
    ;%
    ;% Init/prealloc paramMap
    ;%
    paramMap.nSections           = nTotSects;
    paramMap.sectIdxOffset       = sectIdxOffset;
      paramMap.sections(nTotSects) = dumSection; %prealloc
    paramMap.nTotData            = -1;
    
    ;%
    ;% Auto data (motor_P)
    ;%
      section.nData     = 30;
      section.data(30)  = dumData; %prealloc
      
	  ;% motor_P.AnalogOutput_MaxMissedTicks
	  section.data(1).logicalSrcIdx = 0;
	  section.data(1).dtTransOffset = 0;
	
	  ;% motor_P.AnalogOutput_YieldWhenWaiting
	  section.data(2).logicalSrcIdx = 1;
	  section.data(2).dtTransOffset = 1;
	
	  ;% motor_P.AnalogInput_MaxMissedTicks
	  section.data(3).logicalSrcIdx = 4;
	  section.data(3).dtTransOffset = 2;
	
	  ;% motor_P.AnalogInput_YieldWhenWaiting
	  section.data(4).logicalSrcIdx = 5;
	  section.data(4).dtTransOffset = 3;
	
	  ;% motor_P.Constant_Value
	  section.data(5).logicalSrcIdx = 6;
	  section.data(5).dtTransOffset = 4;
	
	  ;% motor_P.sinwt_Amp
	  section.data(6).logicalSrcIdx = 7;
	  section.data(6).dtTransOffset = 5;
	
	  ;% motor_P.sinwt_Bias
	  section.data(7).logicalSrcIdx = 8;
	  section.data(7).dtTransOffset = 6;
	
	  ;% motor_P.sinwt_Freq
	  section.data(8).logicalSrcIdx = 9;
	  section.data(8).dtTransOffset = 7;
	
	  ;% motor_P.sinwt_Hsin
	  section.data(9).logicalSrcIdx = 10;
	  section.data(9).dtTransOffset = 8;
	
	  ;% motor_P.sinwt_HCos
	  section.data(10).logicalSrcIdx = 11;
	  section.data(10).dtTransOffset = 9;
	
	  ;% motor_P.sinwt_PSin
	  section.data(11).logicalSrcIdx = 12;
	  section.data(11).dtTransOffset = 10;
	
	  ;% motor_P.sinwt_PCos
	  section.data(12).logicalSrcIdx = 13;
	  section.data(12).dtTransOffset = 11;
	
	  ;% motor_P.Amplitude_Gain
	  section.data(13).logicalSrcIdx = 14;
	  section.data(13).dtTransOffset = 12;
	
	  ;% motor_P.DigitalFilter_InitialStates
	  section.data(14).logicalSrcIdx = 15;
	  section.data(14).dtTransOffset = 13;
	
	  ;% motor_P.DigitalFilter_Coefficients
	  section.data(15).logicalSrcIdx = 16;
	  section.data(15).dtTransOffset = 14;
	
	  ;% motor_P.Startintegration_Time
	  section.data(16).logicalSrcIdx = 17;
	  section.data(16).dtTransOffset = 65;
	
	  ;% motor_P.Startintegration_Y0
	  section.data(17).logicalSrcIdx = 18;
	  section.data(17).dtTransOffset = 66;
	
	  ;% motor_P.Startintegration_YFinal
	  section.data(18).logicalSrcIdx = 19;
	  section.data(18).dtTransOffset = 67;
	
	  ;% motor_P.Integrator_IC
	  section.data(19).logicalSrcIdx = 20;
	  section.data(19).dtTransOffset = 68;
	
	  ;% motor_P.Integrator1_IC
	  section.data(20).logicalSrcIdx = 21;
	  section.data(20).dtTransOffset = 69;
	
	  ;% motor_P.coswt_Amp
	  section.data(21).logicalSrcIdx = 22;
	  section.data(21).dtTransOffset = 70;
	
	  ;% motor_P.coswt_Bias
	  section.data(22).logicalSrcIdx = 23;
	  section.data(22).dtTransOffset = 71;
	
	  ;% motor_P.coswt_Freq
	  section.data(23).logicalSrcIdx = 24;
	  section.data(23).dtTransOffset = 72;
	
	  ;% motor_P.coswt_Hsin
	  section.data(24).logicalSrcIdx = 25;
	  section.data(24).dtTransOffset = 73;
	
	  ;% motor_P.coswt_HCos
	  section.data(25).logicalSrcIdx = 26;
	  section.data(25).dtTransOffset = 74;
	
	  ;% motor_P.coswt_PSin
	  section.data(26).logicalSrcIdx = 27;
	  section.data(26).dtTransOffset = 75;
	
	  ;% motor_P.coswt_PCos
	  section.data(27).logicalSrcIdx = 28;
	  section.data(27).dtTransOffset = 76;
	
	  ;% motor_P.Step_Time
	  section.data(28).logicalSrcIdx = 29;
	  section.data(28).dtTransOffset = 77;
	
	  ;% motor_P.Step_Y0
	  section.data(29).logicalSrcIdx = 30;
	  section.data(29).dtTransOffset = 78;
	
	  ;% motor_P.Step_YFinal
	  section.data(30).logicalSrcIdx = 31;
	  section.data(30).dtTransOffset = 79;
	
      nTotData = nTotData + section.nData;
      paramMap.sections(1) = section;
      clear section
      
      section.nData     = 6;
      section.data(6)  = dumData; %prealloc
      
	  ;% motor_P.AnalogOutput_Channels
	  section.data(1).logicalSrcIdx = 32;
	  section.data(1).dtTransOffset = 0;
	
	  ;% motor_P.AnalogOutput_RangeMode
	  section.data(2).logicalSrcIdx = 33;
	  section.data(2).dtTransOffset = 1;
	
	  ;% motor_P.AnalogOutput_VoltRange
	  section.data(3).logicalSrcIdx = 34;
	  section.data(3).dtTransOffset = 2;
	
	  ;% motor_P.AnalogInput_Channels
	  section.data(4).logicalSrcIdx = 35;
	  section.data(4).dtTransOffset = 3;
	
	  ;% motor_P.AnalogInput_RangeMode
	  section.data(5).logicalSrcIdx = 36;
	  section.data(5).dtTransOffset = 4;
	
	  ;% motor_P.AnalogInput_VoltRange
	  section.data(6).logicalSrcIdx = 37;
	  section.data(6).dtTransOffset = 5;
	
      nTotData = nTotData + section.nData;
      paramMap.sections(2) = section;
      clear section
      
    
      ;%
      ;% Non-auto Data (parameter)
      ;%
    

    ;%
    ;% Add final counts to struct.
    ;%
    paramMap.nTotData = nTotData;
    


  ;%**************************
  ;% Create Block Output Map *
  ;%**************************
      
    nTotData      = 0; %add to this count as we go
    nTotSects     = 1;
    sectIdxOffset = 0;
    
    ;%
    ;% Define dummy sections & preallocate arrays
    ;%
    dumSection.nData = -1;  
    dumSection.data  = [];
    
    dumData.logicalSrcIdx = -1;
    dumData.dtTransOffset = -1;
    
    ;%
    ;% Init/prealloc sigMap
    ;%
    sigMap.nSections           = nTotSects;
    sigMap.sectIdxOffset       = sectIdxOffset;
      sigMap.sections(nTotSects) = dumSection; %prealloc
    sigMap.nTotData            = -1;
    
    ;%
    ;% Auto data (motor_B)
    ;%
      section.nData     = 9;
      section.data(9)  = dumData; %prealloc
      
	  ;% motor_B.k
	  section.data(1).logicalSrcIdx = 0;
	  section.data(1).dtTransOffset = 0;
	
	  ;% motor_B.DigitalFilter
	  section.data(2).logicalSrcIdx = 1;
	  section.data(2).dtTransOffset = 1;
	
	  ;% motor_B.Startintegration
	  section.data(3).logicalSrcIdx = 2;
	  section.data(3).dtTransOffset = 2;
	
	  ;% motor_B.Integrator
	  section.data(4).logicalSrcIdx = 3;
	  section.data(4).dtTransOffset = 3;
	
	  ;% motor_B.Integrator1
	  section.data(5).logicalSrcIdx = 4;
	  section.data(5).dtTransOffset = 4;
	
	  ;% motor_B.Product
	  section.data(6).logicalSrcIdx = 5;
	  section.data(6).dtTransOffset = 5;
	
	  ;% motor_B.Product1
	  section.data(7).logicalSrcIdx = 6;
	  section.data(7).dtTransOffset = 6;
	
	  ;% motor_B.Step
	  section.data(8).logicalSrcIdx = 7;
	  section.data(8).dtTransOffset = 7;
	
	  ;% motor_B.AnalogInput
	  section.data(9).logicalSrcIdx = 8;
	  section.data(9).dtTransOffset = 8;
	
      nTotData = nTotData + section.nData;
      sigMap.sections(1) = section;
      clear section
      
    
      ;%
      ;% Non-auto Data (signal)
      ;%
    

    ;%
    ;% Add final counts to struct.
    ;%
    sigMap.nTotData = nTotData;
    


  ;%*******************
  ;% Create DWork Map *
  ;%*******************
      
    nTotData      = 0; %add to this count as we go
    nTotSects     = 3;
    sectIdxOffset = 1;
    
    ;%
    ;% Define dummy sections & preallocate arrays
    ;%
    dumSection.nData = -1;  
    dumSection.data  = [];
    
    dumData.logicalSrcIdx = -1;
    dumData.dtTransOffset = -1;
    
    ;%
    ;% Init/prealloc dworkMap
    ;%
    dworkMap.nSections           = nTotSects;
    dworkMap.sectIdxOffset       = sectIdxOffset;
      dworkMap.sections(nTotSects) = dumSection; %prealloc
    dworkMap.nTotData            = -1;
    
    ;%
    ;% Auto data (motor_DW)
    ;%
      section.nData     = 5;
      section.data(5)  = dumData; %prealloc
      
	  ;% motor_DW.DigitalFilter_states
	  section.data(1).logicalSrcIdx = 0;
	  section.data(1).dtTransOffset = 0;
	
	  ;% motor_DW.lastSin
	  section.data(2).logicalSrcIdx = 1;
	  section.data(2).dtTransOffset = 50;
	
	  ;% motor_DW.lastCos
	  section.data(3).logicalSrcIdx = 2;
	  section.data(3).dtTransOffset = 51;
	
	  ;% motor_DW.lastSin_d
	  section.data(4).logicalSrcIdx = 3;
	  section.data(4).dtTransOffset = 52;
	
	  ;% motor_DW.lastCos_o
	  section.data(5).logicalSrcIdx = 4;
	  section.data(5).dtTransOffset = 53;
	
      nTotData = nTotData + section.nData;
      dworkMap.sections(1) = section;
      clear section
      
      section.nData     = 5;
      section.data(5)  = dumData; %prealloc
      
	  ;% motor_DW.Scope_PWORK.LoggedData
	  section.data(1).logicalSrcIdx = 5;
	  section.data(1).dtTransOffset = 0;
	
	  ;% motor_DW.ToWorkspace1_PWORK.LoggedData
	  section.data(2).logicalSrcIdx = 6;
	  section.data(2).dtTransOffset = 1;
	
	  ;% motor_DW.ToWorkspace2_PWORK.LoggedData
	  section.data(3).logicalSrcIdx = 7;
	  section.data(3).dtTransOffset = 2;
	
	  ;% motor_DW.AnalogOutput_PWORK
	  section.data(4).logicalSrcIdx = 8;
	  section.data(4).dtTransOffset = 3;
	
	  ;% motor_DW.AnalogInput_PWORK
	  section.data(5).logicalSrcIdx = 9;
	  section.data(5).dtTransOffset = 4;
	
      nTotData = nTotData + section.nData;
      dworkMap.sections(2) = section;
      clear section
      
      section.nData     = 3;
      section.data(3)  = dumData; %prealloc
      
	  ;% motor_DW.DigitalFilter_circBuf
	  section.data(1).logicalSrcIdx = 10;
	  section.data(1).dtTransOffset = 0;
	
	  ;% motor_DW.systemEnable
	  section.data(2).logicalSrcIdx = 11;
	  section.data(2).dtTransOffset = 1;
	
	  ;% motor_DW.systemEnable_g
	  section.data(3).logicalSrcIdx = 12;
	  section.data(3).dtTransOffset = 2;
	
      nTotData = nTotData + section.nData;
      dworkMap.sections(3) = section;
      clear section
      
    
      ;%
      ;% Non-auto Data (dwork)
      ;%
    

    ;%
    ;% Add final counts to struct.
    ;%
    dworkMap.nTotData = nTotData;
    


  ;%
  ;% Add individual maps to base struct.
  ;%

  targMap.paramMap  = paramMap;    
  targMap.signalMap = sigMap;
  targMap.dworkMap  = dworkMap;
  
  ;%
  ;% Add checksums to base struct.
  ;%


  targMap.checksum0 = 3885338396;
  targMap.checksum1 = 4099962556;
  targMap.checksum2 = 947956259;
  targMap.checksum3 = 1743207197;

