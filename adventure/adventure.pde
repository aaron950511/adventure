import ddf.minim.*;

Minim minim;
AudioPlayer gameRun, gameStart,keytoken;
AudioSample get, die;
int gameStartCounter=0, gameRunCounter,keytokenCounter=0;
PImage start1,start2,lose,win,restart,ghost,taco,arm,white,owl,key1,fly,finish,advice,Rev,title,grass,grass1,grass2;
PFont f;

final int GAME_START = 0, GAME_RUN = 1, GAME_WIN = 2, GAME_LOSE = 3;
int gameState=0;

int ghostX,ghostY,ghostSpeed,flyX,flyY;
int [] bg = new int[14];
int gameBG;

int remainFrames = 6000;
int time;

boolean upPressed = false;
boolean downPressed = false;
boolean leftPressed = false;
boolean rightPressed = false;
int x=0, y=1, w=2, h=3, speedX=4, speedY=5; 

final int level=0, straight=1, slide=2;
Monster[] monsters = new Monster[25];

boolean [] keyToken ={false,false,false};
boolean [] flyToken ={false,false};

void setup(){
  size(1200,1000);
  start1=loadImage("img/start1.jpg");
  start2=loadImage("img/start2.jpg");
  lose=loadImage("img/lose.jpg");
  win=loadImage("img/win.jpg");
  restart=loadImage("img/restart.jpg");
  ghost=loadImage("img/ghost.png");
  key1=loadImage("img/key.png");
  fly=loadImage("img/fly.png");
  finish=loadImage("img/finish.png");
  grass=loadImage("img/grass.png");
  grass1=loadImage("img/grass1.png");
  grass2=loadImage("img/grass2.png");
  advice=loadImage("img/advice.png");
  Rev=loadImage("img/5.0.png");
  title=loadImage("img/title2.png");
  f = createFont("font/word.ttf",48);
  minim = new Minim(this);
 
  gameStart = minim.loadFile("sound/gameStart.wav");
  gameRun = minim.loadFile("sound/gameRun.wav");
  keytoken = minim.loadFile("sound/keyToken.wav");
  get = minim.loadSample("sound/get.wav");
  die = minim.loadSample("sound/die.mp3");
  
  for(int i=0; i<bg.length; i++){
    bg[i] = i;
  }
  gameBG = bg[0];
  ghostX=100;
  ghostY=height/2;
  ghostSpeed=0;
  flyX=width/2-50;
  flyY=height/2-50;
  monsters[0] = new Taco(400, 100, straight);
  monsters[1] = new Taco(750, 100, straight);
  monsters[2] = new Taco(0, 250, level);
  monsters[3] = new Taco(0, 725, level);
  monsters[4] = new Taco(300, 50, straight);
  monsters[5] = new Taco(550, 50, straight);
  monsters[6] = new Taco(800, 50, straight);
  monsters[7] =  new Arm(0, 250, level);
  monsters[8] =  new Arm(0, 725, level);
  monsters[9] =  new Arm(300, 50, straight);
  monsters[10] =new Taco(550, 50, straight);
  monsters[11] = new Arm(800, 50, straight);
  monsters[12] = new Owl(300, 50, straight);
  monsters[13] = new Owl(550, 50, straight);
  monsters[14] = new Owl(800, 50, straight);
  monsters[15] = new Arm(10, 200, level);
  monsters[16] = new Arm(10, 400, level);
  monsters[17] = new Arm(10, 600, level);
  monsters[18] = new Arm(10, 800, level);
  monsters[19] = new Owl(width/2, height/2, slide);
  monsters[20] = new Owl(50, 300, level);
  monsters[21] = new Owl(50, 550, level);
  monsters[22] = new Owl(50, 800, level);
  monsters[23] = new Arm(400, 100, straight);
  monsters[24] = new Arm(750, 100, straight);
  
  
  
  gameState = GAME_START;
}

void draw(){
  switch(gameState){
    
    case GAME_START:
    background(255);


    if(gameStartCounter%gameStart.bufferSize()==0){
      gameStart.loop();
    }
    gameStartCounter++;
        
    image(start1,width/4,height/4);
    if (mouseX>300&&mouseX<900&&mouseY>420&&mouseY<570){
      image(start2,width/4,height/4);
      if(mousePressed==true){
        time = remainFrames;
        gameState=GAME_RUN;
        gameStart.pause();
        gameRun.loop();
      }
    }
    image(advice,width/4-50,height/4+start1.height+20);
    image(Rev,0,height-50,75,50);
    image(title,245,25,700,200);
    
    break;
    
    case GAME_RUN:
    
    if (keyToken[0]==true&&keyToken[1]==true&&keyToken[2]==true){
      
      gameRun.pause();
      
      if(keytokenCounter%keytoken.bufferSize()==0){
        keytoken.loop();
      }
      keytokenCounter++;
      
    }
    
    switch(gameBG){
     
      case 0:
          image(grass,0,0,width,height);
          fill(0);
          stroke(5);
          rightPassage(1);
          upWall();
          buttomWall();
          
          if (keyToken[0]==true&&keyToken[1]==true&&keyToken[2]==true){
            leftPassage(13);
          }
        
      break;
      
      case 1: //<>//
          image(grass1,0,0,width,height);
          fill(0);
          stroke(5);
          leftPassage(0);
          rightPassage(2);
          topPassage(10);
          bottomPassage(6);
        
          for(int i=0; i<2; i++){
            monsters[i].move();
            monsters[i].display();
            gameState = monsters[i].isCollision(ghostX, ghostY, ghost.width, ghost.height);
            if(gameState==GAME_LOSE){ break; }
          }
      break;
    
    case 2:
    
        image(grass,0,0,width,height);
        fill(0);
        stroke(5);
        leftPassage(1);
        rightPassage(3);
        upWall();
        buttomWall();
        
        for(int i=2; i<7; i++){
            monsters[i].move();
            monsters[i].display();
            gameState = monsters[i].isCollision(ghostX, ghostY, ghost.width, ghost.height);
            if(gameState==GAME_LOSE){ break; }
        }
      
    break;
    
    case 3:
    
        image(grass2,0,0,width,height);
        fill(0);
        stroke(5);
        leftPassage(2);
        bottomPassage(9);
        rightPassage(4);
        upWall();
        
        for(int i=7; i<12; i++){
            monsters[i].move();
            monsters[i].display();
            gameState = monsters[i].isCollision(ghostX, ghostY, ghost.width, ghost.height);
            if(gameState==GAME_LOSE){ break; }
        }
        
        
    break;
    
    case 4:
    
        image(grass,0,0,width,height);
        fill(0);
        stroke(5);
        leftPassage(3);
        rightPassage(5);
        upWall();
        buttomWall();
        
        for(int i=12; i<15; i++){
            monsters[i].move();
            monsters[i].display();
            gameState = monsters[i].isCollision(ghostX, ghostY, ghost.width, ghost.height);
            if(gameState==GAME_LOSE){ break; }
        }
      
      
    break;
    
    case 5:
    
        image(grass2,0,0,width,height);
        fill(0);
        stroke(5);
        leftPassage(4);
        upWall();
        buttomWall();
        rightWall();
        
        if(keyToken[2]==false){
        image(key1,width/2-50,height/2-50,100,100);
        }
        
        if(collision(width/2-50,height/2-50,100,100)){
          if(keyToken[2]==false){
            get.trigger();
          }
          keyToken[2]=true;  
        }
      
      
    break;
    
    case 6:
    
        image(grass1,0,0,width,height);
        fill(0);
        stroke(5);
        topPassage(1);
        bottomPassage(7);
        leftWall();
        rightWall();
        
        for(int i=15; i<19; i++){
            monsters[i].move();
            monsters[i].display();
            gameState = monsters[i].isCollision(ghostX, ghostY, ghost.width, ghost.height);
            if(gameState==GAME_LOSE){ break; }
        }
        
       
    break;
    
    case 7:
    
        image(grass2,0,0,width,height);
        fill(0);
        stroke(5);
        topPassage(6);
        rightPassage(8);
        leftWall();
        buttomWall();
        
        for(int i=19; i<20; i++){
            monsters[i].move();
            monsters[i].display();
            gameState = monsters[i].isCollision(ghostX, ghostY, ghost.width, ghost.height);
            if(gameState==GAME_LOSE){ break; }
        }
        
        
      
    break;
    
    case 8:
    
        image(grass,0,0,width,height);
        fill(0);
        stroke(5);
        leftPassage(7);
        upWall();
        buttomWall();
        rightWall();
        
        if(keyToken[1]==false){
        image(key1,width/2-50,height/2-50,100,100);
        }
        
        if(collision(width/2-50,height/2-50,100,100)){
          if(keyToken[1]==false){
            get.trigger();
          }
          keyToken[1]=true;  
        }
      
    break;
    
    case 9:
    
        image(grass2,0,0,width,height);
        fill(0);
        stroke(5);
        topPassage(3);
        leftWall();
        rightWall();
        buttomWall();
        
        if(flyToken[0]==false){
           image(fly,flyX,flyY,100,100);
        }
        
        if(collision(flyX, flyY, 100, 100)){
          if(flyToken[0]==false){
            ghostSpeed+=25;
            get.trigger();
          }
          flyToken[0]=true;
        }
                
        
      
    break;
    
    case 10:
    
        image(grass,0,0,width,height);
        fill(0);
        stroke(5);
        topPassage(11);
        bottomPassage(1);
        rightPassage(12);
        leftWall();
        
        for(int i=20; i<25; i++){
            monsters[i].move();
            monsters[i].display();
            gameState = monsters[i].isCollision(ghostX, ghostY, ghost.width, ghost.height);
            if(gameState==GAME_LOSE){ break; }
        }
        
    break;
    
    case 11:
    
        image(grass1,0,0,width,height);
        fill(0);
        stroke(5);
        bottomPassage(10);
        leftWall();
        rightWall();
        upWall();
        
        if(flyToken[1]==false){
          image(fly,flyX,flyY,100,100);
        }
        
        if(collision(flyX, flyY, 100, 100)){
          if(flyToken[1]==false){
            ghostSpeed+=25;
            get.trigger();
          }
          flyToken[1]=true;
        }
 
    break;
    
    case 12:
    
        image(grass1,0,0,width,height);
        fill(0);
        stroke(5);
        leftPassage(10);
        upWall();
        rightWall();
        buttomWall();
        
        if(keyToken[0]==false){
          image(key1,width/2-50,height/2-50,100,100);
        }
        
        if(collision(width/2-50,height/2-50,100,100)){
          if(keyToken[0]==false){
            get.trigger();
          }
          keyToken[0]=true;  
        }
 
      
    break;
    
    case 13:
    
        image(grass2,0,0,width,height);
        fill(0);
        stroke(5);
        image(finish,width/2-125,height/2-125,250,250);
        rightPassage(0);
        leftWall();
        upWall();
        buttomWall();
        
        if(collision(width/2-125,height/2-125,250,250)){
          gameState=GAME_WIN;
        }
        
 
    break;
    }
    
    
    if(keyToken[0]==true){
     image(key1,25,25,60,60);
    }
    if(keyToken[1]==true){
      image(key1,85,25,60,60);
    }
    if(keyToken[2]==true){
      image(key1,145,25,60,60);
    }
    
    image(ghost,ghostX,ghostY,50,50);
    textFont(f, 48);
    time = time-1;
    if(time==0){
      gameState=GAME_LOSE;
    }
    text(time/20+"sec", width-200, height-25);
    //println(time/23+"sec");
    break;
    
    case GAME_WIN:
    
    keytokenCounter=0;
    for(int i=0; i<keyToken.length; i++) {
      keyToken[i] = false;
    }
            
    for(int i=0; i<flyToken.length; i++) {
      flyToken[i] = false;
    }

    ghostSpeed=0;
    image(win,width/4,height/4);
    if (mouseX>300&&mouseX<900&&mouseY>420&&mouseY<570){
      image(restart,width/4,height/4);
      if(mousePressed==true){
        gameState=GAME_RUN;
        time = remainFrames;
        ghostX=100;
        ghostY=height/2;
        gameBG=bg[0];
        gameRun.loop();
        keytoken.pause();
      }
    }
    
    break;
    
    case GAME_LOSE:
    
    keytoken.pause();
    keytokenCounter=0;
    for(int i=0; i<keyToken.length; i++) {
      keyToken[i] = false;
    }
    for(int i=0; i<flyToken.length; i++) {
      flyToken[i] = false;
    }
    ghostSpeed=0;
    image(lose,width/4,height/4);
    if (mouseX>300&&mouseX<900&&mouseY>420&&mouseY<570){
      image(restart,width/4,height/4);
      if(mousePressed==true){
        gameState=GAME_RUN;
        time = remainFrames;
        ghostX=100;
        ghostY=height/2;
        gameBG=bg[0];
        gameRun.loop();
        keytoken.pause();
      }
    }
  }
}

boolean collision(int monsterX,int monsterY,int monsterW,int monsterH){
  if (ghostY+ghost.height > monsterY && ghostY < monsterY+monsterH){
    if (ghostX+ghost.width>monsterX && ghostX<monsterX+monsterW){
      return true;
    } 
  }       
  return false;
}


void topPassage(int gameBG){
  rect(0,0,450,5);
  rect(750,0,450,5);
  
  if(ghostY<0){
    if(ghostX>=450 && ghostX<=750){
      ghostY = height - ghost.height;
      this.gameBG = gameBG;
    }else{
      ghostY=0;
    }
  }
}
void bottomPassage(int gameBG){
  rect(0,height-5,450,5);
  rect(750,height-5,450,5);
  if(ghostY>height-ghost.height){
    if(ghostX>=450 && ghostX<=750){
      ghostY=0;
      this.gameBG = gameBG;
    }else{
      ghostY=height-ghost.height;
    }
  }
}
void rightPassage(int gameBG){
  rect(width-5,0,5,350);
  rect(width-5,650,5,350);
  if(ghostX>width-ghost.width){
    if(ghostY>=350 && ghostY<=650){
      ghostX=0;
      this.gameBG = gameBG;
    }else{
      ghostX=width-ghost.width;
    }
  } 
}
void leftPassage(int gameBG){
  rect(0,0,5,350);
  rect(0,650,5,350);
  if(ghostX<0){
    if(ghostY>=350 && ghostY<=650){
      ghostX=width-ghost.width;
      this.gameBG = gameBG;
    }else{
      ghostX=0;
    }
  }
}

void upWall(){
  if (ghostY<0){
    ghostY=0;
  }
}

void buttomWall(){
  if (ghostY+ghost.height>height){
    ghostY=height-ghost.height;
  }
}

void leftWall(){
  if (ghostX<0){
    ghostX=0;
  }
}

void rightWall(){
  if (ghostX+ghost.width>width){
    ghostX=width-ghost.width;
  }
}

void keyPressed() {
  if (key == CODED) { 
    switch (keyCode) {
      case UP:
        upPressed = true;
        if (keyCode==UP ){
          ghostY-=(25+ghostSpeed);
        }
        
        break;
      case DOWN:
        downPressed = true;
        if (keyCode==DOWN){
          ghostY+=25+ghostSpeed;
          }
          
        break;
      case LEFT:
        leftPressed = true;
        if (keyCode==LEFT ){
          ghostX-=(25+ghostSpeed);
          }
          
        break;
      case RIGHT:
        rightPressed = true;
        if (keyCode==RIGHT ){
          ghostX+=25+ghostSpeed;
          }
          
        break;
    }
  }
}
