final float xPpAngle = 7.314;


int xAxisPixeltoAngle(float xPixel) {
  
  /*
  Kinect FOV = 70.6x60
  H.Servo Angle: 61 == xPixel: 212
  
  xPixel/Angle (xPpA) = 3.475409836 pixels/angle
  
  Facing Turret: Left  x -> +∞
                 Right x -> -∞
  */
  
  int changeInAngle = (round(xPixel / xPpAngle)-55);
  int xAngle = 78-changeInAngle;

  //println("xPixel-xAngle: ", xPixel, xAngle);
  
  return xAngle;
  
}


int xAxisAngletoPixel(int xAngle) {
  
  int changeInPixel = -round((xAngle+9) * xPpAngle);
  int xPixel = changeInPixel+889;
  
  
  //println("xAngle-xPixel: ", xAngle, xPixel);
  
  return xPixel;
  
}

//NEXT TO DO: ADD CROSSHAIR TO IMAGE REFLECTING GUN POINTING, WORKOUT WHY xPpAngle MEANS THAT THERE IS OVER/UNDER ROTATION UNLESS AT 0

void drawCrosshair(int[] xPixel) {
  
  //loadImage("images/crosshair", "png");
  fill(color(255,0,0));
  rect(xPixel[0], 212, 12, 12);
  
  fill(255, 0, 0, 0);
  rect(xPixel[0], 212, 4, 4);
  rect(xPixel[0]+8, 212, 4, 4);
  rect(xPixel[0], 212+8, 4, 4);
  rect(xPixel[0]+8, 212+8, 4, 4);
  
}
