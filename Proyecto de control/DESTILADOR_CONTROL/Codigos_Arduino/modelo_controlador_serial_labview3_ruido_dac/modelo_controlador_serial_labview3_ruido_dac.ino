#define pi 3.14159
#define umax 24 //24Voltios
#define ymax 1 //1
#define u_amin 161 //121 //DAC out minimo
#define u_amax 855//606 //DAC out minimo

//Valores del analógico
//Entradas
long u_L_analog = 0;
long u_V_analog = 0;

//Salidas
long Xd_analog = 0;
long Xb_analog = 0;

//tiempo
long tiempo = 0;

//*********Parámetros del modelo
//int datas[10];
//char data[400];
float A[3]= {1.0, -1.9702, 0.9704};
float B[3]= {0, 0.0004950, 0.0004901};

float Xd_3, Xd_2, Xd_1, Xd;
float F_8, F_7, F_6, F_5, F_4, F_3, F_2, F_1, F;
float L_7, L_6, L_5, L_4, L_3, L_2, L_1, L;
float V_5, V_4, V_3, V_2, V_1, V;
float Xb_3, Xb_2 , Xb_1,  Xb ;
float u_L , u_V;

float L_lab , V_lab;

//Variables del controlador
float rd , rb;

float xd = 0 , xb = 0; //medida del sensor
float error_xb = 0 , error_xd = 0;
float int_e_xb = 0 , int_e_xd = 0; //integral del error

//*********Parámetros del controlador
float kpb,kib,kpd,kid;
long Tm = 2000; //2s
float dt = 2;

//
long readNumber = 1;
String sensorstringEC = "               ";

//Variables del modelo;
void setup() {

  Serial.begin(9600); // speed is irrelevant for native port
  SerialUSB.begin(9600);

  analogWriteResolution(12);  // set the analog output resolution to 12 bit (4096 levels)
  analogReadResolution(12);   // set the analog input resolution to 10 bit

  F = 0.1;
  
  Xb_3 = 0;
  Xb_2 = 0;
  Xb_1 = 0;
  Xb = 0;

  Xd_3=0;
  Xd_2=0;
  Xd_1=0;
  Xd = 0; 
  F_8=0;
  F_7=0;
  F_6=0;
  F_5=0;
  F_4=0;
  F_3=0;
  F_2=0;
  F_1=0;
  F=0;
  L_7=0;
  L_6=0;
  L_5=0;
  L_4=0;
  L_3=0;
  L_2=0;
  L_1=0;
  L=0;
  V_5=0;
  V_4=0;
  V_3=0;
  V_2=0;
  V_1=0;
  V=0;

  //Constantes y referencia

  kpd = 0.375;
  kid = 0.375/8.29;

  kpb = -0.075;
  kib = -0.075/23.6;

  rd = 0.8;
  rb = 0.5;

  String sensorstringEC = "5000,32800,32.7"; //FORMATO DE STRING QUE RECIBE SERIAL


}

void loop() {

  //Simulando la señal de entrada u con el mismo microcontrolador DUE
  //analogWrite(DAC1, analogRead(A1)*4);  // write the selected waveform on DAC1

  if ( Serial.available() ){
    // cast the string read in an integer 
//    readNumber = Serial.parseInt();
//    rd = readNumber/100.0;

    sensorstringEC = Serial.readString() ;

    int firstComma1 = sensorstringEC.indexOf(',');
    //Serial.println("The index of ',' in the string " + sensorstringEC + " is " + firstComma1);
    String EC1 = sensorstringEC.substring(0,firstComma1);
  
    sensorstringEC.remove(0,firstComma1+1);
    int firstComma2 = sensorstringEC.indexOf(',');
  
    //Serial.println("The index of ',' in the string " + sensorstringEC + " is " + firstComma2);
    String EC2 = sensorstringEC.substring(0,firstComma2);
  
    String EC3 = sensorstringEC.substring(firstComma2 + 1,sensorstringEC.length());
  
    //float EC1int = EC1.toInt();
    float EC1int = EC1.toFloat();
    float EC2int = EC2.toFloat();
    float EC3int = EC3.toFloat();
  
  
    SerialUSB.print(EC1int,2);
    SerialUSB.print("  ");
    SerialUSB.print(EC2int,2);
    SerialUSB.print("  ");
    SerialUSB.print(EC3int,2);
    SerialUSB.print("  ");
    SerialUSB.println(EC1int+EC2int+EC3int,2);

    rd = EC1int/100.0;

    rb = EC2int/100.0;
  }
  
  //**************Leer ADC y escalar u *******************************

  if((millis()-tiempo) > Tm){

    //**************Ecuaciones de la planta*******************************
    
    Xd = 0.0002*random(10) + 2.6707*Xd_1 - 2.3773*Xd_2 + 0.7053*Xd_3 + 0.744*L_1 -0.6263*L_2 - 0.6583*L_3 + 0.5571*L_4 - 0.8789*V_2 + 0.7102*V_3 + 0.7945*V_4 - 0.64995*V_5 + 0.4549*F_5 -0.7948*F_6 + 0.3267*F_7 + 0.01804*F_8; 
  
    Xb = -0.0001*random(10) + 2.5621*Xb_1 - 2.1877*Xb_2 + 0.6225*Xb_3 + 0.5786*L_4 - 0.473*L_5 - 0.4749*L_6 + 0.3947*L_7 - 1.302*V_2 + 0.9887*V_3 + 1.1224*V_4 - 0.8685*V_5 + 0.2177*F_2 + 0.1005*F_3 - 0.6446*F_4 + 0.3413*F_5;

   //********************************************
    //añadiendo ruido
//    Xd = Xd + 0.001*random(10);
//    Xb = Xb + 0.001*random(10);
//   Serial.print(analogRead(A0));
//   Serial.print("  ");
//   Serial.println(analogRead(A1));

   if( analogRead(A0) < 3000){
    Xd = 0;  // write the selected waveform on DAC0
   }

   if( analogRead(A1) < 3000){
    Xb = 0;  // write the selected waveform on DAC0
   }

    //calcular controlador:
    //CONTROLADOR 1
    error_xd = rd-Xd;
    int_e_xd = int_e_xd + error_xd*dt;
    
    //if(int_e_xd > 1000) int_e_xd = 1000;
    
    L = kpd*error_xd + kid*int_e_xd; 
  
    //CONTROLADOR 2
    error_xb = rb-Xb;
    int_e_xb = int_e_xb + error_xb*dt;
    
    //if(int_e_xb > 1000) int_e_xb = 1000;
    
    V = kpb*error_xb + kib*int_e_xb; 
  
    //Saturación salidas:
//    if(L<0)  L=0;
//    if(L>1)  L=1;
//  
//    if(V<0)  V=0;
//    if(V>1)  V=1;

    u_L = L;
    u_V = V;
    
    
    //Guardando los datos anteriores
    L_7 = L_6;  
    L_6 = L_5; 
    L_5 = L_4;
    L_4 = L_3;
    L_3 = L_2;
    L_2 = L_1;
    L_1 = u_L;
    
    V_5 = V_4;
    V_4 = V_3;
    V_3 = V_2;
    V_2 = V_1;
    V_1 = u_V;
    
    F_8 = F_7;
    F_7 = F_6;
    F_6 = F_5;
    F_5 = F_4;
    F_4 = F_3;
    F_3 = F_2;
    F_2 = F_1;
    F_1 = F;
    
    Xd_3 = Xd_2;
    Xd_2 = Xd_1;
    Xd_1 = Xd;
    
    Xb_3 = Xb_2;
    Xb_2 = Xb_1;
    Xb_1 = Xb;

    //Saturación de salidas:
    if(Xd<0) Xd=0;
    else if(Xd>1) Xd =1;

    if(Xb<0) Xb=0;
    else if(Xb>1) Xb =1;

    L_lab = abs(u_L);
    V_lab = abs(u_V);
 
    Serial.print(Xd,2);
    Serial.print("     ");
    Serial.print(Xb,2);
    Serial.print("     ");
    Serial.print(L_lab,2);
    Serial.print("     ");
    Serial.print(V_lab,2);
    Serial.println("");

    //DACs(test)

    analogWrite(DAC0, 4095);  // write the selected waveform on DAC0
    analogWrite(DAC1, 4095);  // write the selected waveform on DAC0

    tiempo = millis();


  }

  
}



