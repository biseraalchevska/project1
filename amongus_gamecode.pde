// www.runwayml.com
// PoseNet Demo:
// Receive OSC messages from Runway
// Running PoseNet model
// original example by Anastasis Germanidis, adapted by George Profenza

import com.runwayml.*;
RunwayHTTP runway;
PImage img;
PImage red;
PImage yellow;
PImage dead;

JSONObject data;

void setup(){
  size(512,288);

  img = loadImage("among.jpg");
  red = loadImage("1_red.png");
  yellow = loadImage("yellow.png");
  dead = loadImage("dead.png");
  runway = new RunwayHTTP(this);

}

void draw(){
  background(img);
  image(yellow,360,140);
  image(yellow,260,50);
  image(yellow,60,150);
  draw_poses();
  keyPressed();
  
}

void runwayDataEvent(JSONObject runwayData){
  data = runwayData;
}

void draw_poses(){
  if (data != null){
    JSONArray poses = data.getJSONArray("poses");
    print(poses);
    
   for (int i =0; i<poses.size(); i++){
     JSONArray the_pose = poses.getJSONArray(i);
     
     JSONArray point = the_pose.getJSONArray(10);
     float x = point.getFloat(0)*width;
     float y = point.getFloat(1)*height;
     image(red, x, y, 40, 40);
     //if red touches yellow
     if (340<x&&x>380 && 120<y&&y>160 ){
       image(dead,330,120);      
     }
     if (240<x&&x>280 && 30<y&&y>70  ){
       image(dead,230,35);      
     }
     if (40<x&&x>80 && 130<y&&y>170 ){
       image(dead,40,130);      
     }
   }
  }
}


void keyPressed(){
  //print(data);
  draw_poses();
  //just for visualization 
  if(key==CODED){
    if(keyCode==RIGHT){
      image(dead,330,120);      
    }
    if(keyCode==UP){
      image(dead,230,35);      
    }
    if(keyCode==LEFT){
      image(dead,40,130);
    }
  }
}
