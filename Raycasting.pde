boolean isLeft, isRight, isUp, isDown, rkey;
Creature player;
Wall[] walls;
int wallAmount = 10;
int height2D = 600;
int width2D = 600;
float speedGlobal = 1;
int rayAmount = 100;
float FieldofView = 90;

void setup() {
    size(1900, 1000);
    player = new Creature(new PVector(width2D/2,height2D/2),rayAmount,FieldofView,speedGlobal);
    walls = new Wall[0];
    for (int i = 0; i < wallAmount; i++) {
      walls = (Wall[])append(walls, new Wall(random(10,width2D-10),random(10,height2D-10),random(10,width2D-10),random(10,height2D-10)));     
    }
    walls = (Wall[])append(walls, new Wall(10,10,width2D-10,10));
    walls = (Wall[])append(walls, new Wall(10,10,10,height2D-10));
    walls = (Wall[])append(walls, new Wall(width2D-10,height2D-10,width2D-10,10));
    walls = (Wall[])append(walls, new Wall(width2D-10,height2D-10,10,height2D-10));
}

void draw() {
  background(0);
  player.update(isUp,isDown,isLeft,isRight,walls);

  for(Wall wall : walls){
    wall.draw();
  }
  player.draw();
  
  if(rkey){
    player = new Creature(new PVector(width2D/2,height2D/2),200,90,speedGlobal);
    walls = new Wall[0];
    for (int i = 0; i < wallAmount; i++) {
      walls = (Wall[])append(walls, new Wall(random(10,width2D-10),random(10,height2D-10),random(10,width2D-10),random(10,height2D-10)));     
    }
    walls = (Wall[])append(walls, new Wall(10,10,width2D-10,10));
    walls = (Wall[])append(walls, new Wall(10,10,10,height2D-10));
    walls = (Wall[])append(walls, new Wall(width2D-10,height2D-10,width2D-10,10));
    walls = (Wall[])append(walls, new Wall(width2D-10,height2D-10,10,height2D-10));
  }
    
}



void keyPressed() {
  setMove(keyCode, true);
}
 
void keyReleased() {
  setMove(keyCode, false);
}

boolean setMove(int k, boolean b) {
  switch (k) {
  case UP:
    return isUp = b;
 
  case DOWN:
    return isDown = b;
 
  case LEFT:
    return isLeft = b;
 
  case RIGHT:
    return isRight = b;
  case ' ':
    return rkey = b;
 
  default:
    return b;
  }
}