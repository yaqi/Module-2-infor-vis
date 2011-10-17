
#include <Firmata.h>

int analogPin = 0;

int p0[4] = {
  2,3,4,5};
int p1[4] = {
  6,7,8,9};
int light[4]={
  0,0,0,0};
long standardADC[4]={650,795,880,1020};
void setup()
{
    Firmata.setFirmwareVersion(0, 1);
    Firmata.begin(9600);
}

void loop()
{
  int sensorValue;
  for(int l=0;l<4 ;l++)
  {
    light[l]=0;
  }
 
  // Apply reverse voltage, charge up the pin and led capacitance
  for(int i=0;i<4;i++)
  {
    pinMode(p1[i],OUTPUT);
    pinMode(p0[i],OUTPUT);
    digitalWrite(p1[i],HIGH);
    digitalWrite(p0[i],LOW);

    //delay(50);
    // Isolate the pin 2 end of the diode
    pinMode(p1[i],INPUT);
    digitalWrite(p1[i],LOW);  // turn off internal pull-up resistor
    sensorValue = 0;
    delay(40);
    for(int h=0;h<10;h++)
    {
      sensorValue = sensorValue+analogRead(i);//read the sensor value 
    }
    sensorValue =sensorValue/10.0;
    
    Firmata.sendAnalog(analogPin, analogRead(analogPin)); 
    analogPin = analogPin + 1;
    if (analogPin >= 3) analogPin = 0;
    
    //sensorValue = analogRead(LED_ANALOG_0);//read the sensor value 
    if(sensorValue>=standardADC[i]) 
    {
      light[i]=1;
    }
    else
      light[i]=0;
  }

  for(int j=0;j<4;j++)
  {
    if(light[j] == 1)
    {
      digitalWrite(p0[j],HIGH);
      digitalWrite(p1[j],LOW);
      pinMode(p0[j],OUTPUT);
      pinMode(p1[j],OUTPUT);
      //delayMicroseconds(10000);
      delay(1000);
    }
    else
    {
      digitalWrite(p0[j],LOW);
      digitalWrite(p1[j],LOW);
      pinMode(p0[j],OUTPUT);
      pinMode(p1[j],OUTPUT);
      delayMicroseconds(100);
    }
  }
 
}






