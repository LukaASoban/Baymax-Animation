//my extra instancing item will be a extra head of the baymax lying around 
// using the head() function

import processing.opengl.*;

float time = 0;  // keep track of passing of time
PImage img;
PImage img2;
float scale = 1.0;
float headScale = 0.1;
float headY;
boolean head = false;
boolean look = true;
float x = 0;
float y;
float newY = 0;
float transY = 1;
float count = 0;
float steps = 0;
float walking = 0;
boolean walk = true;


void setup() {
  size(800, 800, P3D);  // must use 3D here !!!
  img = loadImage("wood-floor.jpg");
  img2 = loadImage("wall.jpg");
  noStroke();           // do not draw the edges of polygons
}

// Draw a scene with a cylinder, a sphere and a box
void draw() {
  
  resetMatrix();  // set the transformation matrix to the identity (important!)

  background(0);  // clear the screen to black
  
 
    
  // set up for perspective projection
  perspective (PI * 0.333, 1.0, 0.01, 1000.0);
 
  
  //time++;
  if(time < 45) {
    camera (0.0, -20.0-time*2, 70+time, 0.0, 0.0, -1.0, 0.0, 1.0, 0.0);
  
  } else if(time > 45 && time < 65) {
   
    camera (0.0, 20, 80, 0.0, 0.0, -1.0, 0.0, 1.0, 0.0);
    
  } else if(time > 65 && time < 90) {
    camera(0.0, -20, 0, 0.0, 0.0, -1.0, 0.0, 1.0, 0.0);
    
  } else if(time >=90 && time < 110) {
    //camera (100, -100, 80, 0.0, -30, 120, 0.0, 1.0, 0.0);
    camera (100, -200, 80, 0.0, -30, 50, 0.0, 1.0, 0.0);
     //camera(0.0, -20, 70, 0.0, 0.0, -1.0, 0.0, 1.0, 0.0);
  } else if(time >=110) {
    //camera (30, -30, 130, 0.0, -25, 148, 0.0, 1.0, 0.0);
    camera (8, -30, 149, 0.0, -25, 148, 0.0, 1.0, 0.0);
  }
  
 
 
  // create an ambient light source
  ambientLight (102, 102, 102);
  
  // create two directional light sources
  lightSpecular (204, 204, 204);
  //directionalLight (102, 102, 102, -1, -1, -1);
 //directionalLight (152, 152, 152, 0, 0, -1);
 
 if(time > 50 && time < 115) {
   spotLight(102, 102, 102, 0, -60, 10, 0, 1, 0, PI/6, 1);
   spotLight(102, 102, 102, 0, -60, 10*3, 0, 1, 0, PI/6, 1);
   spotLight(102, 102, 102, 0, -60, 10*6, 0, 1, 0, PI/6, 1);
   spotLight(102, 102, 102, 0, -60, 10*9, 0, 1, 0, PI/6, 1);
   spotLight(102, 102, 102, 0, -60, 10*12, 0, 1, 0, PI/6, 1);
   spotLight(102, 102, 102, 0, -60, 10*14, 0, 1, 0, PI/6, 1);
 }
  
  pushMatrix();
  floor();
  popMatrix();
  
  pushMatrix();
  translate(0,0,150);
  wall();
  popMatrix();
  
  pushMatrix();
  translate(-100,0,50);
  rotateY(PI/2);
  wall();
  popMatrix();
  
  pushMatrix();
  translate(0,0,-30);
  wall();
  popMatrix();
  
  //time = 100;
 
  
 
  
  
  
  
  
  
  //This is where the animation will begin
  if(time < 90) {
    
    // Baymax will first shrink (go to sleep)
    if(!(scale < 0.20) && !head){
     scale *= 0.99;
     x++;
     newY = (-0.0006807*pow(x,2))+0.2360842*x+1.3419117;
    } else if((scale <= 0.20) && !head) {
      head = true; 
      headY = newY;
      headScale = scale;
    }
  
    if(head) {
       
      
      if(headScale < 1.0) {
        headScale /= 0.99;
        headY *= 1.0045;
        
        if(headScale > 1.0) { headScale = 1.0; headY = 46;}
      }
    }
     
     
    if(head == false) {
      
      
       //////////// Draw the Head of Baymax /////////////////////////////
      startShrink();
      translate(0,-33,3);
      pushMatrix();
      
      head();
      
      popMatrix();
      translate(0,33,-3);
      endShrink();
      
    } else {
      
      
      if (time <= 65) {
        //////////// Draw the Head of Baymax /////////////////////////////
        startGrow();
        translate(0,-33,3);
        pushMatrix();
        
        head();
        
        popMatrix();
        translate(0,33,-3);
        endGrow();
        
        
      } else if(time > 65 && time < 90) {
        
        count += 0.01;
        
        translate(0,-33,3);
        translate(0,headY,0);
        lookup();
        pushMatrix();
        head();
        popMatrix();
        endLookup();
        translate(0,-headY,0);
        translate(0,33,-3);
        
          
      }
      
      
      
    }    
    
    // TOP BODY PART /////////////////////////////  
    startShrink();
    translate(0,-10.5,0);
    pushMatrix();
  
    topBody();  
    
    popMatrix();
    translate(0,10.5,0);
    endShrink();
    ///END TOP BODY/////////////////////////////////////////
    
    // PATCH
    startShrink();
    translate(6,-22,10.25);
    pushMatrix();
    patch();
    popMatrix();
    translate(-6,22,-10.25);
    endShrink();
    // END PATCH
  
    
    // RIGHT ARM
    startShrink();
    translate(-15,-20,0);
    pushMatrix();
    
    rightArm();
    
    popMatrix();
    translate(15,20,0);
    endShrink();
    // END RIGHT ARM
    
    // RIGHT FOREARM
    startShrink();
    translate(-22,-10,0);
    pushMatrix();
    rightForearm();
    popMatrix();
    translate(22,10,0);
    endShrink();
    // END RIGHT FOREARM
    
    //RIGHT HAND THUMB
    startShrink();
    translate(-22,-3.5,1.25);
    pushMatrix();
    rightThumb();
    popMatrix();
    translate(22,3.5,-1.25);
    endShrink();
    // END RIGHT HAND THUMB
    
    // RIGHT HAND INDEX FINGER
     startShrink();
    translate(-25,-2,1.5);
    pushMatrix();
    rightIndexFinger();
    popMatrix();
    translate(25,2,-1.5);
    endShrink();
    // END RIGHT HAND INDEX
    
    // RIGHT HAND MIDDLE FINGER
    startShrink();
    translate(-25,-1.75,-0.5);
    pushMatrix();
    rightMiddleFinger();
    popMatrix();
    translate(25,1.75,0.5);
     endShrink();
    // END RIGHT HAND MIDDLE FINGER
    
    // RIGHT HAND PINKY
     startShrink();
    translate(-24.5,-2.5,-2.15);
    pushMatrix();
    rightPinky();
    popMatrix();
    translate(24.5,2.5,2.15);
    endShrink();
    // END RIGHT HAND PINKY
      
    // LEFT ARM
    startShrink();
    translate(15,-20,0);
    pushMatrix();
    leftArm();  
    popMatrix();
    translate(-15,20,0);
     endShrink();
    // END LEFT ARM
    
    // LEFT FOREARM
    startShrink();
    translate(22,-10,0);
    pushMatrix();
    leftForearm();
    popMatrix();
    translate(-22,10,0);
    endShrink();
    // END LEFT FOREARM
    
    // LEFT HAND THUMB
    startShrink();
    translate(22,-3.5,1.25);
    pushMatrix();
    leftThumb();
    popMatrix();
    translate(-22,3.5,-1.25);
    endShrink();
    // END LEFT HAND THUMB
    
    // LEFT INDEX FINGER
    startShrink();
    translate(25,-2,1.5);
    pushMatrix();
    leftIndexFinger();
    popMatrix();
    translate(-25,2,-1.5);
    endShrink();
    //END LEFT INDEX FINGER
    
    // LEFT MIDDLE FINGER
    startShrink();
    translate(25,-1.75,-0.5);
    pushMatrix();
    leftMiddleFinger();
    popMatrix();
    translate(-25,1.75,0.5);
    endShrink();
    // END LEFT MIDDLE FINGER
    
    // LEFT PINKY
    startShrink();
    translate(24.5,-2.5,-2.15);
    pushMatrix();
    leftPinky();
    popMatrix();
    translate(-24.5,2.5,2.15);
    endShrink();
    // END LEFT PINKY
   
    // MAIN BODY
    startShrink();
    pushMatrix();
    body();
    popMatrix();
    endShrink();
    // END MAIN BODY
    
   
    // RIGHT LEG
    startShrink();
    translate (-8, 8, 0); 
    pushMatrix();
    rightLeg();  
    popMatrix();
    translate (8, -8, 0);
    endShrink();
    // END RIGHT LEG
   
    // LEFT LEG
    startShrink();
    translate (8, 8, 0);
    pushMatrix();
    leftLeg();  
    popMatrix();
    translate (-8, -8, 0);
    endShrink();
    //END LEFT LEG
    
    
  } else if(time >= 90 && time < 110) {
    
    translate(0,-25,154);
    pushMatrix();
    base();
    popMatrix();
    translate(0,25, -154);
    
    translate(0,-25,148);
    pushMatrix();
    lightSwh();
    popMatrix();
    translate(0,25,-148);
    
    //translate(-15,-33,0);
    //translate(0,-33,3);
    //pushMatrix();
    //head();
    //popMatrix();
    //translate(0,33,-3);
    //translate(15,-33,0);
    
    ///////////////////////BAYMAX RUNNNING //////////////////////////////////////////////////////////////////////////////
    
    //HEAD
    startWalk();
    translate(0,-33,3);
    pushMatrix();
    head();
    popMatrix();
    translate(0,33,-3);
    endWalk();
    //END HEAD
    
   // TOP BODY
   startWalk();
    translate(0,-10.5,0);
    pushMatrix();
    topBody();  
    popMatrix();
    translate(0,10.5,0);
    endWalk();
    ///END TOP BODY//
    
    
    // PATCH
    startWalk();
    translate(6,-22,10.25);
    pushMatrix();
    patch();
    popMatrix();
    translate(-6,22,-10.25);
    endWalk();
    // END PATCH
  
    
    // RIGHT ARM
    startWalk();
    translate(-15,-20,0);
    pushMatrix();
    rightArm();
    popMatrix();
    translate(15,20,0);
    endWalk();
    // END RIGHT ARM
    
    
    
    // RIGHT FOREARM
     startWalk();
    translate(-22,-10,0);
    pushMatrix();
    rightForearm();
    popMatrix();
    translate(22,10,0);
    endWalk();
    // END RIGHT FOREARM
    
    //RIGHT HAND THUMB
    startWalk();
    translate(-22,-3.5,1.25);
    pushMatrix();
    rightThumb();
    popMatrix();
    translate(22,3.5,-1.25);
    endWalk();
    // END RIGHT HAND THUMB
    
    // RIGHT HAND INDEX FINGER
    startWalk();
    translate(-25,-2,1.5);
    pushMatrix();
    rightIndexFinger();
    popMatrix();
    translate(25,2,-1.5);
    endWalk();
    // END RIGHT HAND INDEX
    
    // RIGHT HAND MIDDLE FINGER
    startWalk();
    translate(-25,-1.75,-0.5);
    pushMatrix();
    rightMiddleFinger();
    popMatrix();
    translate(25,1.75,0.5);
    endWalk();
    // END RIGHT HAND MIDDLE FINGER
    
    // RIGHT HAND PINKY
    startWalk();
    translate(-24.5,-2.5,-2.15);
    pushMatrix();
    rightPinky();
    popMatrix();
    translate(24.5,2.5,2.15);
    endWalk();
    // END RIGHT HAND PINKY
      
    // LEFT ARM
    startWalk();
    translate(15,-20,0);
    pushMatrix();
    leftArm();  
    popMatrix();
    translate(-15,20,0);
     endWalk();
    // END LEFT ARM
    
    // LEFT FOREARM
     startWalk();
    translate(22,-10,0);
    pushMatrix();
    leftForearm();
    popMatrix();
    translate(-22,10,0);
    endWalk();
    // END LEFT FOREARM
    
    // LEFT HAND THUMB
     startWalk();
    translate(22,-3.5,1.25);
    pushMatrix();
    leftThumb();
    popMatrix();
    translate(-22,3.5,-1.25);
    endWalk();
    // END LEFT HAND THUMB
    
    // LEFT INDEX FINGER
    startWalk();
    translate(25,-2,1.5);
    pushMatrix();
    leftIndexFinger();
    popMatrix();
    translate(-25,2,-1.5);
    endWalk();
    //END LEFT INDEX FINGER
    
    // LEFT MIDDLE FINGER
    startWalk();
    translate(25,-1.75,-0.5);
    pushMatrix();
    leftMiddleFinger();
    popMatrix();
    translate(-25,1.75,0.5);
    endWalk();
    // END LEFT MIDDLE FINGER
    
    // LEFT PINKY
    startWalk();
    translate(24.5,-2.5,-2.15);
    pushMatrix();
    leftPinky();
    popMatrix();
    translate(-24.5,2.5,2.15);
     endWalk();
    // END LEFT PINKY
   
    // MAIN BODY
    startWalk();
    pushMatrix();
    body();
    popMatrix();
     endWalk();
    // END MAIN BODY
    
    
    float time2 = Math.round(time * 1.0) / 1.0;
 
    if(walk == true){
      if(time2 % 2.0 == 1.0) {
        steps++;
      }
      
     if(steps >= 3) {
       walk = false;
     }
    }
     
    if(walk == false) {
     if(time2 % 2.0 == 0.0) {
        steps--;
      }
      if(steps <= -3) {
        walk = true;
      }
       
    }
   
    startWalk();
    if(walking<120)
    rotateX(steps * (PI/8));
   
    // RIGHT LEG
    translate (-8, 8, 0); 
    pushMatrix();
    rightLeg();  
    popMatrix();
    translate (8, -8, 0);
    // END RIGHT LEG
    if(walking<120)
    rotateX(-(steps * (PI/8)));
     endWalk();
   
   
   
   startWalk();
   if(walking<120)
   rotateX(-(steps * (PI/8)));
    // LEFT LEG
    translate (8, 8, 0);
    pushMatrix();
    leftLeg();  
    popMatrix();
    translate (-8, -8, 0);
    //END LEFT LEG
    if(walking<120)
    rotateX(steps * (PI/8));
    endWalk();
    /////////////////////////////////////////////////////////END BAYMAX RUNNING/////////////////////////////////// 
  } else if(time >= 110) {
    
    translate(0,-25,154);
    pushMatrix();
    base();
    popMatrix();
    translate(0,25, -154);
    
    translate(0,-25,148);
    if(time > 115)
    rotateX(PI/2);
    pushMatrix();
    lightSwh();
    popMatrix();
    if(time > 115)
    rotateX(-PI/2);
    translate(0,25,-148);
    
    
    /////////////////////// THIS IS WHERE BAYMAX FLIPS THE SWITCH OFF!!!////////////////////////////////////////////////////
    
    
    // LEFT INDEX FINGER
    translate(-24,-28,145);
    translate(25,-2,1.5);
    if(time > 115)
    rotateZ(-PI/4);
    pushMatrix();
    leftIndexFinger();
    popMatrix();
    if(time > 115)
    rotateZ(-PI/4);
    translate(-25,2,-1.5);
    translate(0,-25,-148);
    //END LEFT INDEX FINGER
   
    
    
    
    
  }
 
   
 
  // step forward in time
  time += 0.10;
}












void lookup() {
  
  if(count < 1.5 && look == true)
    rotateX((PI/12) + count);
   else {
    look = false;
   }
   
   if(look == false) {
     
     count -= 0.02;
     
     if(count > 0){
      rotateX((PI/12) + count);
     }
   }
    
}

void endLookup() {
  
    if(count < 1.5 && look == true)
      rotateX((-PI/12) - count);
      
     if(look == false) {
       if(count > 0){
        rotateX((-PI/12) - count);
       }
   }
    
    
}




void startWalk() {
  
    if(walking < 120)
    walking += 0.05;
    translate(0,0,walking);
  
}

void endWalk() {
   translate(0,0,-walking);
  
}



void startGrow() {
  translate(0,headY,0);
  scale(headScale); //make Baymax go to sleep
}

void endGrow() {
   scale(1/headScale); //make Baymax go to sleep
   translate(0,-headY,0);
}


void startShrink() {
   translate(0,newY,0);
   scale(scale); //make Baymax go to sleep
   
}

void endShrink(){
   scale(1/scale); //make Baymax go to sleep
   translate(0,-newY,0);
}


void base() {
   
  fill (255, 255, 255);       // "fill" sets both diffuse and ambient color (yuck!)
  ambient (50, 50, 50);      // set ambient color
  specular (150, 150, 150);   // set specular color
  shininess (5.0);            // set specular exponent
  box(10);
  
}

void lightSwh() {

  fill (255, 0, 0);       // "fill" sets both diffuse and ambient color (yuck!)
  ambient (50, 50, 50);      // set ambient color
  specular (150, 150, 150);   // set specular color
  shininess (5.0);            // set specular exponent
  
  rotateY(PI/2);
  rotateZ(-PI/4);
  scale(4,1,1);
  box(2);
  scale(1/4,1,1);
  rotateZ(PI/4);
  rotateY(-PI/2);
  
}




void topBody() {
    // diffuse (fill), ambient and specular material properties
  fill (255, 255, 255);       // "fill" sets both diffuse and ambient color (yuck!)
  ambient (50, 50, 50);      // set ambient color
  specular (150, 150, 150);   // set specular color
  shininess (5.0);            // set specular exponent
  
  scale(1.15,1.5,1);
  sphere (14);
   
  
}
void head() {
  fill (255, 255, 255);       // "fill" sets both diffuse and ambient color (yuck!)
  ambient (50, 50, 50);      // set ambient color
  specular (150, 150, 150);   // set specular color
  shininess (5.0);            // set specular exponent
  
  
  scale(1.5,1.0,1.5);
  sphere(4);
  
  translate(-1.75,0,3.75);
  rightEye();
  translate(1.75, 0, -3.75);
  
  translate(1.75, 0, 3.75);
  leftEye();
  translate(-1.75,0,-3.75);
  
  translate(0,0,3.75);
  scale(-3.25,0.25,0.75);
  box(1);
  scale(1/-3.25, 1/0.25, 1/0.75);
  translate(0,0,-3.75);
 
}

void patch() {
  
  if(frameCount % 40 > 10) {
    fill(255,0,0);
  } else {
    fill(0,255,0);
  }
  
  scale(0.85,0.5,0.5);
  rotateX(PI/1.45);
  rotateZ(-PI/5.5);  
  cylinder(2, 0.5,32);
}

void rightEye() {
 /* RIGHT SUB PART*/
  fill(0,0,0);
  
  rotateY(-PI/8);
  scale(-1.2,1.2,0.3);
  sphere(0.75);
  scale(1/-1.2, 1/1.2, 1/0.3);
  rotateY(PI/8);
}

void leftEye() {
  /* LEFT SUB PART*/
  fill(0,0,0);
  
  rotateY(PI/8);
  scale(-1.2,1.2,0.3);
  sphere(0.75);
  scale(1/-1.2, 1/1.2, 1/0.3);
  rotateY(-PI/8);
}

void mouth() {
  /* Mouth SUB PART*/
  fill(0,0,0);
  scale(-5,0.25,0.75);
  box(1);
}

void rightArm() {
  fill(255,255,255);
  ambient (50, 50, 50);      // set ambient color
  specular (150, 150, 150);   // set specular color
  shininess (5.0);            // set specular exponent
  
  rotateZ(-PI/4);
  scale(2,1,1);
  sphere(5); 
}

void rightForearm() {
  fill(255,255,255);
  ambient (50, 50, 50);      // set ambient color
  specular (150, 150, 150);   // set specular color
  shininess (5.0);            // set specular exponent
  
  rotateZ(-PI/2.5);
  scale(2,1,1);
  sphere(5);
}

void rightThumb() {
  fill(0,255,255);
  ambient (50, 50, 50);      // set ambient color
  specular (150, 150, 150);   // set specular color
  shininess (5.0);            // set specular exponent
  
  sphere(2);
  translate(0.5,0.5,0.75);
  rotateZ(-PI/12);
  rotateX(PI/32);
  cylinder(1,1,32);
  translate(0,1,0);
  sphere(1);
  rotateZ(PI/12);
  cylinder(1,1,32);
  translate(0,1,0);
  sphere(1);
}

void rightIndexFinger() {
  fill(0,255,255);
  ambient (50, 50, 50);      // set ambient color
  specular (150, 150, 150);   // set specular color
  shininess (5.0);            // set specular exponent
  
  rotateZ(-PI/12);
  rotateX(PI/12);
  cylinder(1,1,32);
  translate(0,1,0);
  sphere(1);
  rotateZ(-PI/12);
  cylinder(1,1,32);
  translate(0,1,0);
  sphere(1);
  rotateZ(-PI/12);
  cylinder(1,1,32);
  translate(0,1,0);
  sphere(1);
}

void rightMiddleFinger() {
  fill(0,255,255);
  ambient (50, 50, 50);      // set ambient color
  specular (150, 150, 150);   // set specular color
  shininess (5.0);            // set specular exponent
  
  rotateZ(-PI/12);
  cylinder(1,1,32);
  translate(0,1,0);
  sphere(1);
  rotateZ(-PI/12);
  cylinder(1,1,32);
  translate(0,1,0);
  sphere(1);
  rotateZ(-PI/12);
  cylinder(1,1,32);
  translate(0,1,0);
  sphere(1);
}

void rightPinky() {
  fill(0,255,255);
  ambient (50, 50, 50);      // set ambient color
  specular (150, 150, 150);   // set specular color
  shininess (5.0);            // set specular exponent
  
  rotateZ(-PI/12);
  rotateX(-PI/8);
  cylinder(1,1,32);
  translate(0,1,0);
  sphere(1);
  rotateZ(-PI/12);
  cylinder(1,1,32);
  translate(0,1,0);
  sphere(1);
  rotateZ(-PI/12);
  cylinder(1,1,32);
  translate(0,1,0);
  sphere(1);
}

void leftArm() {
  fill(255,255,255);
  ambient (50, 50, 50);      // set ambient color
  specular (150, 150, 150);   // set specular color
  shininess (5.0);            // set specular exponent
  
  rotateZ(PI/4);
  scale(2,1,1);
  sphere(5);
}

void leftForearm() {
  fill(255,255,255);
  ambient (50, 50, 50);      // set ambient color
  specular (150, 150, 150);   // set specular color
  shininess (5.0);            // set specular exponent
  
  rotateZ(PI/2.5);
  scale(2,1,1);
  sphere(5);
}

void leftThumb() {
  fill(0,255,255);
  ambient (50, 50, 50);      // set ambient color
  specular (150, 150, 150);   // set specular color
  shininess (5.0);            // set specular exponent
  
  sphere(2);
  translate(-0.5,0.5,0.75);
  rotateZ(PI/12);
  rotateX(PI/32);
  cylinder(1,1,32);
  translate(0,1,0);
  sphere(1);
  rotateZ(-PI/12);
  cylinder(1,1,32);
  translate(0,1,0);
  sphere(1);
}

void leftIndexFinger() {
  fill(0,255,255);
  ambient (50, 50, 50);      // set ambient color
  specular (150, 150, 150);   // set specular color
  shininess (5.0);            // set specular exponent
  
  rotateZ(PI/12);
  rotateX(PI/12);
  cylinder(1,1,32);
  translate(0,1,0);
  sphere(1);
  rotateZ(PI/12);
  cylinder(1,1,32);
  translate(0,1,0);
  sphere(1);
  rotateZ(PI/12);
  cylinder(1,1,32);
  translate(0,1,0);
  sphere(1);
}

void leftMiddleFinger(){
  fill(0,255,255);
  ambient (50, 50, 50);      // set ambient color
  specular (150, 150, 150);   // set specular color
  shininess (5.0);            // set specular exponent
  
  rotateZ(PI/12);
  cylinder(1,1,32);
  translate(0,1,0);
  sphere(1);
  rotateZ(PI/12);
  cylinder(1,1,32);
  translate(0,1,0);
  sphere(1);
  rotateZ(PI/12);
  cylinder(1,1,32);
  translate(0,1,0);
  sphere(1);
}

void leftPinky() {
   fill(0,255,255);
  ambient (50, 50, 50);      // set ambient color
  specular (150, 150, 150);   // set specular color
  shininess (5.0);            // set specular exponent
 
  rotateZ(PI/12);
  rotateX(-PI/8);
  cylinder(1,1,32);
  translate(0,1,0);
  sphere(1);
  rotateZ(PI/12);
  cylinder(1,1,32);
  translate(0,1,0);
  sphere(1);
  rotateZ(PI/12);
  cylinder(1,1,32);
  translate(0,1,0);
  sphere(1);
}

void body() {
  fill (255, 255, 255);
  ambient (50, 50, 50);
  specular (155, 155, 155);
  shininess (15.0);
  
  sphereDetail (40);
  sphere (18); 
}

void rightLeg() {
  fill (255, 255, 255);
  ambient (50, 50, 50);      // set ambient color
  specular (150, 150, 150);   // set specular color
  shininess (5.0);            // set specular exponent
  
  sphereDetail (40);
  rotateZ(-PI/24);
  cylinder (7.0, 12.0, 32); //leg
  translate(0,12,0);
  sphere(7.0);

}

void leftLeg() {
  fill (255, 255, 255);
  ambient (50, 50, 50);      // set ambient color
  specular (150, 150, 150);   // set specular color
  shininess (5.0);            // set specular exponent
  
  sphereDetail (40);
  rotateZ(PI/24);
  cylinder (7.0, 12.0, 32);
  translate(0,12,0);
  sphere(7.0);
}

void floor() {
  translate(0,27,60);
  rotateX(PI/2);
  beginShape();
  texture(img);
  vertex(-100, -100, 0, 0, 0);
  vertex(100, -100, 0, img.width, 0);
  vertex(100, 100, 0, img.width, img.height);
  vertex(-100, 100, 0, 0, img.height);
  endShape();
  
}

void wall() {
  
  beginShape();
  texture(img2);
  vertex(-100, -100, 0, 0, 0);
  vertex(100, -100, 0, img.width, 0);
  vertex(100, 100, 0, img.width, img.height);
  vertex(-100, 100, 0, 0, img.height);
  endShape();
  
}

// Draw a cylinder of a given radius, height and number of sides.
// The base is on the y=0 plane, and it extends vertically in the y direction.
void cylinder (float radius, float height, int sides) {
  int i,ii;
  float []c = new float[sides];
  float []s = new float[sides];

  for (i = 0; i < sides; i++) {
    float theta = TWO_PI * i / (float) sides;
    c[i] = cos(theta);
    s[i] = sin(theta);
  }
  
  // bottom end cap
  
  normal (0.0, -1.0, 0.0);
  for (i = 0; i < sides; i++) {
    ii = (i+1) % sides;
    beginShape(TRIANGLES);
    vertex (c[ii] * radius, 0.0, s[ii] * radius);
    vertex (c[i] * radius, 0.0, s[i] * radius);
    vertex (0.0, 0.0, 0.0);
    endShape();
  }
  
  // top end cap

  normal (0.0, 1.0, 0.0);
  for (i = 0; i < sides; i++) {
    ii = (i+1) % sides;
    beginShape(TRIANGLES);
    vertex (c[ii] * radius, height, s[ii] * radius);
    vertex (c[i] * radius, height, s[i] * radius);
    vertex (0.0, height, 0.0);
    endShape();
  }
  
  // main body of cylinder
  for (i = 0; i < sides; i++) {
    ii = (i+1) % sides;
    beginShape();
    normal (c[i], 0.0, s[i]);
    vertex (c[i] * radius, 0.0, s[i] * radius);
    vertex (c[i] * radius, height, s[i] * radius);
    normal (c[ii], 0.0, s[ii]);
    vertex (c[ii] * radius, height, s[ii] * radius);
    vertex (c[ii] * radius, 0.0, s[ii] * radius);
    endShape(CLOSE);
  }
}