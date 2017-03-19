#define pi 3.14159

#define ymax 1.0 //1

//Se consideran los valores extremos
#define Lmax 1.0 
#define Lmin -1.0 

#define Vmax 1.0 
#define Vmin -1.0 

#define u_amin 680.0 //121 //DAC out minimo
#define u_amax 3100.0//606 //DAC out minimo

int i = 0;
int Tm = 2000; //cada 2 segundos

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
float   Xb_3, Xb_2 , Xb_1,  Xb ;
float u_L , u_V;

//Variables del modelo;
void setup() {

  //SerialUSB.begin(115200); // speed is irrelevant for native port
  Serial.begin(9600); // speed is irrelevant for native port

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

}

void loop() {

  //Simulando la señal de entrada u con el mismo microcontrolador DUE
  //analogWrite(DAC1, analogRead(A1)*4);  // write the selected waveform on DAC1
  
  //**************Leer ADC y escalar u *******************************
  u_L_analog = analogRead(A0); 
  u_V_analog = analogRead(A1); 

  if((millis()-tiempo) > Tm){
    
    //**************Ecuaciones de la planta*******************************
    
    Xd = 2.6707*Xd_1 - 2.3773*Xd_2 + 0.7053*Xd_3 + 0.744*L_1 -0.6263*L_2 - 0.6583*L_3 + 0.5571*L_4 - 0.8789*V_2 + 0.7102*V_3 + 0.7945*V_4 - 0.64995*V_5 + 0.4549*F_5 -0.7948*F_6 + 0.3267*F_7 + 0.01804*F_8; 
  
    Xb = 2.5621*Xb_1 - 2.1877*Xb_2 + 0.6225*Xb_3 + 0.5786*L_4 - 0.473*L_5 - 0.4749*L_6 + 0.3947*L_7 - 1.302*V_2 + 0.9887*V_3 + 1.1224*V_4 - 0.8685*V_5 + 0.2177*F_2 + 0.1005*F_3 - 0.6446*F_4 + 0.3413*F_5;
    
    u_L = (u_L_analog-u_amin)*4095.0/(u_amax-u_amin); //Escalamiento de u_L
    u_V = (u_V_analog-u_amin)*4095.0/(u_amax-u_amin); //Escalamiento de u_V

    u_L = u_L*(Lmax-Lmin)/4095.0 + Lmin;
    u_V = u_V*(Vmax-Vmin)/4095.0 + Vmin;
    
    
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

    //Envío de salidos

    //**************Escalar salida "y" - enviar DAC  *******************************
  
    Xd_analog= Xd*4095/ymax;  
    analogWrite(DAC0, Xd_analog);  // write the selected waveform on DAC0
  
    Xb_analog= Xb*4095/ymax;  
    analogWrite(DAC1, Xb_analog);  // write the selected waveform on DAC1

    Serial.print("modelo :  ");
//    Serial.print(analogRead(A0));
//    Serial.print(" ");
//    Serial.println(analogRead(A1));
    Serial.print(u_L,6);
    Serial.print(" ");
    Serial.print(u_V,6);
    Serial.print(" ");
    Serial.print(Xd,6);
    Serial.print(" ");
    Serial.println(Xb,6);

    tiempo = millis();
    
  }

//    analogWrite(DAC0, 4095);  // write the selected waveform on DAC0
//    analogWrite(DAC1, 4095);  // write the selected waveform on DAC1

//
//    Serial.print(analogRead(A0));
//    Serial.print("x");
//    Serial.print(analogRead(A1));
//    Serial.print("y");
//    Serial.print(50);
//    Serial.println("z");
    
    delay(10);
  
}



