class Monster {
  int speedX,speedY;
  int x,y;
  int way;
  PImage img;
  
  Monster(String filename,int x,int y,int way){
    img=loadImage("img/"+filename+".png");
    this.x = x;
    this.y = y;
    this.way = way;
  }
  
  void move(){
    if(way==level){
      x+=speedX;
    } else if(way==straight){
      y+=speedY;
    } else {
      x+=speedX;
      y+=speedY;
    }

    if (x<0 || x>width-img.width){
      speedX *=-1;
    }
    if (y<0 || y>height-img.height){
      speedY *=-1;
    }
  }
  
  void display(){
    image(img,x,y);
  }
  
  int isCollision(int ghostX,int ghostY,int ghostW,int ghostH){
    if (ghostY+ghostH > y && ghostY < y+img.height){
      if (ghostX+ghostW> x && ghostX < x+img.width){
        return GAME_LOSE;
      } 
    }     
    return GAME_RUN;
  }
  
}
