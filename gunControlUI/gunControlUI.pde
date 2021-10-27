import controlP5.*;
import processing.serial.*;
import java.lang.reflect.Array;

Serial myPort;
String val;

ControlP5 cp5;
boolean roller = false;
boolean fire = false;
boolean horizontalServo = false;
boolean verticalServo = false;

PShape rollerColour, fireColour, horizontalServoColour, verticalServoColour;

void setup() {
  
  size(400,400);
  
  printArray(Serial.list());
  String portName = Serial.list()[2]; 
  myPort = new Serial(this, portName, 9600);
  
  
  
  cp5 = new ControlP5(this);
  
  cp5.addToggle("roller")
     .setPosition(15, 0.075*height)
     .setSize(100,40);
  
  rollerColour = createShape(RECT, 0, 0, 5, height/4);
  rollerColour.setFill(color(252,174,5));
  rollerColour.setStroke(false);
  
  
  cp5.addToggle("fire")
     .setPosition(15, (height/4)+(0.075*height))
     .setSize(100,40)
     .setValue(false);
  
  fireColour = createShape(RECT, 0, height/4, 5, height/4);
  fireColour.setFill(color(153,153,153));
  fireColour.setStroke(false);
  
  
  cp5.addSlider("horizontalServo")
     .setPosition(15, (height/2)+(0.075*height))
     .setSize(200,30)
     .setRange(0,180)
     .setValue(0);
  
  horizontalServoColour = createShape(RECT, 0, height/2, 5, height/4);
  horizontalServoColour.setFill(color(249,233,0));
  horizontalServoColour.setStroke(false);
  
  
  cp5.addSlider("verticalServo")
     .setPosition(15, (height/4*3)+(0.075*height))
     .setSize(200,30)
     .setRange(0,180)
     .setValue(0);
  
  verticalServoColour = createShape(RECT, 0, height/4*3, 5, height/4);
  verticalServoColour.setFill(color(174,0,249));
  verticalServoColour.setStroke(false);
  
  delay(1000);
  
}



void draw() {
  
  //background(0);
  
  shape(rollerColour);
  shape(fireColour);
  shape(horizontalServoColour);
  shape(verticalServoColour);
  
  if (myPort.available() > 0) {
    //println(myPort.readString());
  }
  
}

//void serialEvent(Serial get) {
// 
//  println(get.readStringUntil('\n'));
//  
//}


void controlEvent(ControlEvent theEvent) {
  
  if(theEvent.isController()) { 
  
    if(theEvent.getController().getName()=="roller") {    
      myPort.write(char('r'));
      delay(2);
      if(theEvent.getController().getValue()==1) { 
        myPort.write(1);
        println("Roller Activated");
      } else {
        myPort.write(0);
        println("Roller Deactivated");
      }
    }
    
        
    if(theEvent.getController().getName()=="fire") {
      myPort.write(char('f'));
      delay(2);
      if(theEvent.getController().getValue()== 1) { 
        myPort.write(1);
        println("Fire Activated");
      } else {
        myPort.write(0);
        println("Fire Deactivated");
      }
    }
    
    if (theEvent.getController().getName() == "horizontalServo") {
      int angle = Math.round(theEvent.getController().getValue());
      myPort.write(char('h'));
      delay(2);
      myPort.write(angle);
    }
    
    if (theEvent.getController().getName() == "verticalServo") {
      int angle = Math.round(theEvent.getController().getValue());
      myPort.write(char('v'));
      delay(2);
      myPort.write(angle);
    }
  }
}
