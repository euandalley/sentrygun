
PShape rollerColour, fireColour, horizontalServoColour, verticalServoColour;
boolean roller, fire;

void setupUI() {
  
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



void drawGunControlUI() {
  
  shape(rollerColour);
  shape(fireColour);
  shape(horizontalServoColour);
  shape(verticalServoColour);
  
}


void gunControlInstruction(int[] instruction) {
  
  /*
  [0]                    [1]
  1: Roller              1 = On, 0 = Off  (ORANGE, 2)
  2: Fire                1 = On, 0 = Off  (GRAY, 8)
  3: Horizontal Servo    Angle            (YELLOW, 9)
  4: Vertical Servo      Angle            (PURPLE, 11)
  */
  
  if (instruction[0] == 3 || instruction[0] == 4) {
    println(instruction);
  }
  
//  if(instruction.isController()) { If there is data then..


  if (instruction[0] == 1) {
    
    arduinoPort.write(char('r'));
    delay(2);
    
    if (instruction[1] == 1) {
      arduinoPort.write(1);
    } else if (instruction[1] == 0)
      arduinoPort.write(0);
  }
  
  if (instruction[0] == 2) {
    
    arduinoPort.write(char('f'));
    delay(2);
    
    if (instruction[1] == 1) {
      arduinoPort.write(1);
    } else if (instruction[1] == 0)
      arduinoPort.write(0);
  }

  
  if (instruction[0] == 3) {
    delay(50);
    int angle = Math.round(instruction[1]);
    arduinoPort.write(char('h'));
    delay(2);
    arduinoPort.write(angle);
  }

  if (instruction[0] == 4) {
    delay(50);
    int angle = Math.round(instruction[1]);
    arduinoPort.write(char('v'));
    delay(2);
    arduinoPort.write(angle);
  }

}


boolean[] fireStates = {false, false};

//Detects change in trigger state
public void triggerEvent(boolean trigger) {
  
  
  
  fireStates[1] = fireStates[0];
  fireStates[0] = trigger;
  
  if (fireStates[0] != fireStates[1]) {
    
    //if trigger is turned on
    if (fireStates[0] == true || fireStates[1] == false) {
      fire(true);
    } else if (fireStates[0] == false || fireStates[1] == true) {
      fire(false);
    }
    
  }
  
}



void fire(boolean state) {
  
  int[] rollerOn = {1, 1};
  int[] rollerOff = {1, 0};
  int[] fireOn = {2, 1};
  int[] fireOff = {2, 0};
  
  for (int i=1; i<5; i++) {
    if (state == true) {
      gunControlInstruction(rollerOn);
      delay(250);
      gunControlInstruction(fireOn);
   
    } else if (state == false) {
      gunControlInstruction(fireOff);
      gunControlInstruction(rollerOff);
    }
  }
}

//int oldSmoothed = 61;

//int servoExponentialFilter(int newAngle) {
  
//  float weight = 0.5f;
//  int newSmoothed = round(weight * newAngle + (1-weight) * oldSmoothed);
//  oldSmoothed = newSmoothed;
  
//  return newSmoothed;
//}
