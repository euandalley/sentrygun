void setupKinect() {
  
  //kinect.enableColorImg(true);
  kinect.enableDepthMaskImg(true);
  kinect.enableSkeletonDepthMap(true);
  kinect.enableDepthImg(true);
  kinect.enableInfraredImg(true);
  //kinect.enableInfraredLongExposureImg(true);
  
  kinect.init();
  frameRate(15);
  
  println("Kinect Set");
  
}


boolean detectPerson = false;


float[] getKinectData() {
  //scale(2);
  background(0);
  
  float xPixel = 216.0f;
  float yPixel = 0.0f;
  
  //image(kinect.getBodyTrackImage(), 0, 0, 320, 240);
  //PImage colorImg = kinect.getColorImage();
  //PImage depthImg = kinect.getDepthMaskImage();
  
  image(kinect.getDepth256Image(), 0, 0);
  //image(kinect.getInfraredLongExposureImage(), 512, 0);
  image(kinect.getInfraredImage(), 512, 0);


  //ArrayList<PImage> bodyTrackList = kinect.getBodyTrackUser();
  ArrayList<KSkeleton> skeletonArray = kinect.getSkeletonDepthMap();
  
  if (skeletonArray.size() > 0) {
    for (int i = 0; i < skeletonArray.size(); i++) {
      KSkeleton skeleton = (KSkeleton) skeletonArray.get(i);
      if (skeleton.isTracked()) {
        KJoint[] joints = skeleton.getJoints();
        detectPerson = true;
        
        color col = skeleton.getIndexColor();
        //color col = #ffffff;
        fill(col);
        stroke(col);
        
  
        noStroke();
        KJoint midSpine = joints[KinectPV2.JointType_SpineMid];
        
        //float midSpineX = midSpine.getX() * (width/1920);
        //float midSpineY = midSpine.getY() * (height/1080);
        
        //println(midSpine.getX(), midSpine.getY(), midSpine.getZ());
        
        pushMatrix();
        translate(midSpine.getX(), midSpine.getY(), midSpine.getZ());
        ellipse(0, 0, 20, 20);
        popMatrix();
        
        int[] pixelDepth = kinect.getRawDepthData();
        int trackedPixel = (round(midSpine.getY()) * width) + round(midSpine.getX());
        
        //println(pixelDepth.length, trackedPixel, pixelDepth[trackedPixel]);
        
        String detectPersonText = String.format("Detected Person: %s \n"
                                               +"Pixel: %s \n"
                                               +"Depth: %smm \n"
                                               , detectPerson, trackedPixel, null);
        
        xPixel = midSpine.getX();
        yPixel = midSpine.getY();

        
      } else {
        
        detectPerson = false;
        String detectPersonText = String.format("Detected Person: %s \n"
                                               +"Pixel: %s \n"
                                               +"Depth: %smm \n"
                                               , detectPerson, null, null);
          
        fill(#ffffff);
        textSize(20);
        text(detectPersonText, 1054, 40);
        
      }
      
    } 
    
  } else {
      detectPerson = false;
  }
  
  float[] pixelPos = {xPixel, yPixel};
  
  return pixelPos;
  
}
