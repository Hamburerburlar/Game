  float w=width;
  float h=height;
  float r=w/20;
  float xpos;
  float ypos;
  float xspeed;
  float yspeed;
  int points;
  int health = 40;
  boolean play= false;



Rock [] rock= new Rock[5];    //array of 5 objects

void setup(){
  size(1000,800);
  
 
 rock[0]=new Rock(#F77823,random((3*width/8)+r,(5*width/8)-r),.6*height,random(-7,7),random(-7,-3)-points);    //instantiation of all objects  
 rock[1]=new Rock(#F77823,random((3*width/8)+r,(5*width/8)-r),.6*height,random(-7,7),random(-7,-3)-points);
 rock[2]=new Rock(#F77823,random((3*width/8)+r,(5*width/8)-r),.6*height,random(-7,7),random(-7,-3)-points);
 rock[3]=new Rock(#F77823,random((3*width/8)+r,(5*width/8)-r),.6*height,random(-7,7),random(-7,-3)-points);
 rock[4]=new Rock(#F77823,random((3*width/8)+r,(5*width/8)-r),.6*height,random(-7,7),random(-7,-3)-points);


}

void mouseClicked(){      //if mouse clicked within these boundaries for each respective button, play = true or game exits
  float x = width/2 ;        
  float qY = height/1.1;
  float pY = height/1.3;
  float W = width/10;
  float H = height/10;
  
    if(mouseX<x + W/2 && mouseX>x - W/2 && mouseY<pY + H/2 && mouseY>pY - H/2)  //play
   {
   play=true;
   }
    if (play==true){                                                        //gets exit button off screen
    qY=-100;
  }
  if(mouseX>x-.5*W && mouseX<x+.5*W && mouseY>qY-.5*H && mouseY<qY+.5*H)  //exit
   {
  exit();   
   }

}
void draw(){
 
  
  background(100);       //starting menu  
  if (play==false){
  float x = width/2 ;        
  float qY = height/1.3;
  float pY = height/1.1;
  float W = width/10;
  float H = height/10;
  textSize(width/16);
  fill(35,240,250);
  text("Spaceship Defender", width/5, 7*height/24);
  textSize(width/28);
  text("Your spaceship has stalled over a live volcano!", width/9, 10*height/24);
  text("Block molten lava to gain points.", width/4, 12*height/24);
  text("Get hit, and you'll lose health.", width/4, 14*height/24);
  text("Once your health bar reaches 0, game over.", width/8,16*height/24);
  
  rectMode(CENTER);                 
  stroke(0);
  strokeWeight(3);
  fill(0, 255, 0);    //play
  rect(x, qY, W, H);
  fill(255, 0, 0);
  rect(x, pY, W, H);   //quit
  
  fill(0);
  textSize(width/36);
  text("  Defend ", width/2-width/15, height/1.28);
  textSize(width/36);
  text("   Cower", width/2-width/15, height/1.08);

  }
  if (play==true){
    

  for(int xx=0; xx<width+10; xx=xx+10){      //background loop, bad attempt at trying to make the ocean appear as if it was boiling from the heat of the volcano
  for(int yy=0; yy<3*height/4; yy+=10){

   float rc=random(200,250);
   fill (50,70,rc);
   rect(xx,yy,10,10);

    }
  }

   displayVolcano();
   displayShip();
   

 
  rock[0].display();
  rock[0].speed();
  rock[0].collision();

  rock[1].display();
  rock[1].speed();
  rock[1].collision();

  rock[2].display();
  rock[2].speed();
  rock[2].collision();

  rock[3].display();
  rock[3].speed();
  rock[3].collision();  

  rock[4].display();
  rock[4].speed();
  rock[4].collision(); 

      textSize(w/3);                              //score keeper
      fill(0);
      text("Points:"+points, w/10, 2*height/9);

if (health>0){
  rectMode(CORNER);
  stroke(0);
  strokeWeight(5);
  fill(255,0,0);
  rect(3.5*width/4,height/2,w/5,-5*health);
  noStroke();
  rectMode(CENTER);
}

                                              //damage screen appears at half health
if (health<21){
  fill(255,0,0,100);
  rect(width/2,height/2,width,height);
  fill(0);
  textSize(width/10);
  textMode(CENTER);
  text("CRITICAL DAMAGE",width/18, 4*height/5);
}

if (health<1){                             //Game loss function 
  fill(0);
  rect(width/2,height/2,width,height);
  fill(255,0,0);
    textSize(width/15);
    text("Your ship blew up, sorry!",width/10,height/2.5);
    
    fill(0);
    stroke(255);
    rect(width/2,2*height/3,width/5,height/8);
    textSize(width/15);
    fill(255,0,0);
    text("QUIT",width/2.4,2.2*height/3.15);
}

if(mousePressed && mouseX>width/2-width/10 && mouseX<width/2+width/10 && mouseY<2*height/3+height/16 && mouseY>2*height/3-height/16){        //Exit game function
  exit();
}
}
}


class Rock{
  float w=width;
  float h=height;
  float r=w/20;
  float xpos;
  float ypos;
  float xspeed;
  float yspeed;
  color c;
  
Rock(color c, float xpos,float ypos,float xspeed,float yspeed){
  this.xpos=xpos;
  this.ypos= ypos;
  this.xspeed= xspeed;
  this.yspeed = yspeed;
  this.c = c;
}
  void display (){
    fill (c);
    ellipse (xpos,ypos,r,r);
}

  void speed(){
    xpos=xpos+xspeed;
    ypos=ypos+yspeed;
  }
  
  void collision(){
    //pulsar shield
  
    stroke(#F218EF);
    line(w/2,100,mouseX,h/5-h/60);
    noStroke();
   
    fill(#F218EF);
    beginShape();
      vertex(w/2,100);
      vertex(mouseX+w/12,h/5-h/60);
      vertex(mouseX-w/12,h/5-h/60);
     endShape(CLOSE);
    
    rect(mouseX,h/5,w/6,h/30);
     
    //bounce
    if (ypos-r<h/10){
     yspeed=-1*yspeed;
     c=0;
    }
    
    //health system
    if (ypos-r<h/10){      
      health--;        //if hit ship, lose health

    }
      if (xpos>mouseX-w/12 && xpos<mouseX+w/12 && ypos<h/5+h/60){            //point system, if hit pulsar shield, gain point
     points++;
     yspeed = random(-7,-3)-.1*points; //speed gets faster as score increases
     
   
    }
    
    
    if (ypos>height || xpos<0 || xpos>width || (xpos>mouseX-w/12 && xpos<mouseX+w/12 && ypos<h/5+h/60)){      //respawn system
      xpos = random((3*width/8)+r,(5*width/8)-r);
      ypos = .6*height;
      c=#F77823;
      xspeed=random(-7,7);
      yspeed = random(-7,-3)-.1*points; //speed gets faster as score increases
       
    }
  
  }
 
}


int i=0;

void displayShip(){            //ship
      float w=width;
      float h=height;
      
 rectMode(CENTER);
 
 //body
 fill(150);
 rect(w/2,0,w/2,h/4);
 
 //window
 fill(130);
 rect(w/2,h/20,w/4,h/10);
 
 //person
 fill(0,255,0);
 ellipse(w/2,h/20,w/40,w/40);
 stroke(0,255,0);
 strokeWeight(3);
 line(w/2,(h/20),w/2,h/10);
 line((w/2-w/50),h/13,(w/2+w/50),h/13);
 
 noStroke();
 //right wing
 fill(180);
  beginShape();
  vertex(3*w/4,0);
  vertex(3*w/4,h/8);
  vertex(w,h/8);
 endShape(CLOSE);
 
 //left wing
 fill(180);
  beginShape();
  vertex(w/4,0);
  vertex(w/4,h/8);
  vertex(0,h/8);
 endShape(CLOSE);


//boost
//flicker funtion on boost
i=i+1;
if (i<5){

 //left boost
   fill(35,240,250);
  rect(w/8,h/7,w/4,h/30);
  
 //right boost
   fill(35,240,250);
  rect(7*w/8,h/7,w/4,h/30);
  
}
if(i>5 && i<10){
 
  fill(255);
  rect(w/8,h/7,w/4,h/30);
  rect(7*w/8,h/7,w/4,h/30);
  i=0;
}
}

void displayVolcano(){          //Volcano
    float w=width;
    float h=height;
 //background
 rectMode(CENTER);
 fill(0,200,0);
 rect(w/2,h/1.5+h/4,w,h/2);
    
    
  //base
  fill(#744E28);
  beginShape();
    vertex(w/4,h);
    vertex(3*w/8,.6*h);
    vertex(5*w/8,.6*h);
    vertex(3*w/4,h);
  endShape(CLOSE);
  
  //tip
  beginShape();
  fill(#F77823);
    vertex(3*w/8,.6*h);
    vertex(5*w/8,.6*h);
    vertex(w/2,.65*h);
  endShape(CLOSE);
   
    beginShape();
  fill(#744E28);
    vertex(3*w/8,.6*h);
    vertex(5*w/8,.6*h);
    vertex(w/2,h/1.75);
 
  endShape(CLOSE);
  
}
  
   
