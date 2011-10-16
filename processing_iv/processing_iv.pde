import processing.serial.*;
import cc.arduino.*;

import eeml.*;

Arduino arduino;
float myValue;
float lastUpdate;

DataOut dOut;


PShape bot;/////
//int sensorData = myValue;/////


void setup()
{
  
   size(700, 700);////
    frameRate(0.5);////
rectMode(CENTER);////
  noStroke();
  
println(Arduino.list());
arduino = new Arduino(this, Arduino.list()[2], 9600);

  dOut = new DataOut(this, "http://www.pachube.com/api/37388.xml", "Q1jtuBeoic5RjEE28lWRowg1lg3xvUx86BV9u1fbm0w"); 

  dOut.addData(0,"lED sensor1, volt, light level");

 }

void draw()
{
   // myValue = 0;
    myValue = arduino.analogRead(0);
      //println(myValue);
    if ((millis() - lastUpdate) > 1000){
        println(myValue);
        println("ready to PUT: ");
        dOut.update(0, myValue);
        int response = dOut.updatePachube();
        println(response);
        lastUpdate = millis();
    }
      background(102);
      
           
      fill(177,255,0);
      ellipse(350, 350, myValue/3+1, myValue/3+1); 
      fill(227,255,0);
      ellipse(350, 350, myValue/3.4, myValue/3.4);
      fill(255,255,0);
      ellipse(350, 350, myValue/4, myValue/4);
      fill(255,197,0);
      ellipse(350, 350, myValue/5, myValue/5);
      fill(255,137,0);
      ellipse(350, 350, myValue/7.5, myValue/7.5);
      fill(255,97,0);
      ellipse(350, 350, myValue/10, myValue/10);
      fill(255,67,0);
      ellipse(350, 350, myValue/13, myValue/13);
      fill(255,17,0);
      ellipse(350, 350, myValue/17, myValue/17);  // sensor 1
   
              //sensorData = sensorData + 1; 
     
}
