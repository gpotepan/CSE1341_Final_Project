//CSE1341 Final Project
//Grant Potepan
//Snake Game
//reference: https://www.openprocessing.org/sketch/50988# byIan151 -- used key pressed code and naming convention to keep consistency throughout code

int angle=0;
int snakesize=3;
int time=0;
int[] headx= new int[round(random(0, 2500))];
int[] heady= new int[round(random(0, 2500))];
int foodx=(round(random(0, 500)));
int foody=(round(random(0, 500)));
boolean redo=true;
boolean stopgame=false;

void setup()
{
  restart();
  size(500, 500);
  textAlign(CENTER);
}

void draw() {
  if (stopgame) {
  } else {
    time+=1;
    fill(255, 0, 255);
    stroke(3);
    rect(foodx, foody, 10, 10);
    fill(0);
    stroke(0);
    rect(0, 0, width, 10);
    rect(0, height-10, width, 10);
    rect(0, 0, 10, height);
    rect(width-10, 0, 10, height);
    //difficulty (lower number is harder)
    if ((time % 4)==0)
    {
      travel();
      display();
      checkdead();
    }
  }
}
Snake(){
  
  
// board navigation
void keyPressed() {
  if (key == CODED)
  {
    //what angle am I moving in? do not turn back on myself
    //naviage screen using direction keys
    if (keyCode == UP && angle!=270 && (heady[1]-8)!=heady[2])
    {
      angle=90;
    }
    if (keyCode == DOWN && angle!=90 && (heady[1]+8)!=heady[2])
    {
      angle=270;
    }
    if (keyCode == LEFT && angle!=0 && (headx[1]-8)!=headx[2])
    {
      angle=180;
    }
    if (keyCode == RIGHT && angle!=180 && (headx[1]+8)!=headx[2])
    {
      angle=0;
    }
    if (keyCode == ENTER)
    {
      restart();
    }
  }
}

void move(){
  for(int i=snakesize; i>0; i++){
    if(i!= 1) {
      headx[i]=headx[i+1];
      heady[i]=heayy[i+1];
    }
    else(