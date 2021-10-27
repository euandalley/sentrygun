#include <Servo.h>

int ledPin = 13;

int rollerPin = 2;
int firePin = 8;
int vServoPin = 11;
int hServoPin = 9;

int rollerState, fireState, horizontalServoState, verticalServoState = 0;
boolean roller, fire, horizontalServo, verticalServo;

char outputName;
int outputInstruction;

Servo hServo, vServo;
int servoPos = 0;

void setup() {

  hServo.attach(hServoPin, 556, 2420);
  vServo.attach(vServoPin, 556, 2420);
  
  pinMode(ledPin, OUTPUT);
  pinMode(rollerPin, OUTPUT);
  pinMode(firePin, OUTPUT);
  //pinMode(horizontalServoPin, OUTPUT);
  //pinMode(verticalServoPin, OUTPUT);
  Serial.begin(9600); //Data transfer rate over USB (bits)
 
}



void loop() {

  if (Serial.available() > 0) {
    outputName = Serial.read();
    delay(50);
    
    if (Serial.available() > 0) {
      outputInstruction = Serial.read();
  

    if (outputName == 'r') {
      digitalWrite(ledPin, HIGH);
      if (outputInstruction == 1) {
        roller = true;
        //Serial.println("[ARDUINO] Roller TRUE");
      } else if (outputInstruction == 0) {
        roller = false;
        //Serial.println("[ARDUINO] Roller FALSE");
      }
    } else if (outputName == 'f') {
        if (outputInstruction == 1) {
          fire = true;
        } else if (outputInstruction == 0) {
          fire = false;
        }
    } else if (outputName == 'h') {
        hServo.write(outputInstruction);
        //Serial.print(outputInstruction)
        delay(15);        
    } else if (outputName == 'v') {
        vServo.write(outputInstruction);
        //Serial.print(outputInstruction)
        delay(15);        
    }

    digitalWrite(ledPin, LOW);

    }
  }


  if (roller == true) {
    //Serial.println("[ARDUNIO] Roller Activated");
    digitalWrite(rollerPin, LOW);
  } else if (roller == false) {
    digitalWrite(rollerPin, HIGH);
  }

  if (fire == true) {
    digitalWrite(firePin, LOW);
  } else if (fire == false) {
    digitalWrite(firePin, HIGH);
  }

  Serial.println(roller, fire);
  

//  if (horizontalServo == true) {
//    hServo.write(servoPos);
//    delay(15);
//  } else if (horizontalServo == false) {
//    hServo.write(90);
//    delay(15);
//  }
//
//  if (verticalServo == true) {
//    vServo.write(servoPos);
//  } else if (verticalServo == false) {
//    vServo.write(90);
//  }
    
    
  
  
}


  
  
