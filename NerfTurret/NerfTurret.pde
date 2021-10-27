import KinectPV2.*;
import KinectPV2.KJoint;
import java.awt.*;
import blobDetection.*;

//import net.java.games.input.*;
//import org.gamecontrolplus.*;
//import org.gamecontrolplus.gui.*;

import controlP5.*;
import processing.serial.*;
import java.lang.reflect.Array;

import java.util.*;

KinectPV2 kinect;
ControlP5 cp5;
Serial arduinoPort;
BlobDetection blobDetection;


void setup() {
  size(1024, 600, P3D);
  
  String port = Serial.list()[0];
  //println(Serial.list());
  arduinoPort = new Serial(this, port, 9600);
  
  kinect = new KinectPV2(this);
  cp5 = new ControlP5(this);

  setupKinect();
  //setupUI();

}



void draw() {
  
  //drawGunControlUI();
   //Get target position in image
  float[] pixelPos = getKinectData();
  
  //Convert position in image to servo angles
  int xAngle = xAxisPixeltoAngle(pixelPos[0]);
  //int smoothedAngle = servoExponentialFilter(xAngle);
  
  //Setup servo instructions
  int[] xAngleServo = {3, xAngle};
  int[] yAngleServo = {4, 85};
  
  printData(xAngleServo[0], yAngleServo[0], pixelPos);
  
  //Send servo instructions
  gunControlInstruction(xAngleServo);
  //gunControlInstruction(yAngleServo);
  
  //Get gun aim and draw crosshair
  int gunAimX = xAxisAngletoPixel(xAngle);
  
  int[] gunAim = {gunAimX, 212};
  
  drawCrosshair(gunAim);
  
  //println(detectPerson);
  
  if (detectPerson == true) {
    //Calls triggerEvent on a new thread
    thread("detectPersonEvent");
  } else {
    triggerEvent(false);
  }
  
  

}


void detectPersonEvent() {
  triggerEvent(true);
}


void printData(int xAngleServo, int yAngleServo, float[] pixelPos) {
  
 String gunAngle = String.format("Angle: %s, %s", xAngleServo, yAngleServo, pixelPos);
 String crosshairPos = String.format("Crosshair: %s, %s", pixelPos[0], pixelPos[1]);
 
 color(255);
 text(gunAngle, 20, 460);
 text(crosshairPos, 20, 490);
  
}
