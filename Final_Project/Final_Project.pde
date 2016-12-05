//CSE1341 Final Project
//Grant Potepan
//Snake Game
//reference: https://www.openprocessing.org/sketch/50988# byIan151 -- used key pressed code and naming convention to keep consistency throughout code
// also used source code to help setup arrays but code used different conventions
// reference https://www.openprocessing.org/sketch/27164# to help with setup and collision

color col=color(255,255,192);
color foodColor = color(255,0, 0);
float speed = 200;
int cx, cy;

int moveX = 0;
int moveY = 0;
int snakeX = 0;
int snakeY = 0;
int foodX = -1;
int foodY = -1;
boolean check = true;
int []snakesX;
int []snakesY;
int snakeSize = 1;
boolean gameOver = false;

void setup(){
  size(500,500);
  background(0);
  speed = 100;
  speed= speed/frameRate;
  snakesX = new int[100];
  snakesY = new int[100];
 
  cx = width/2;
  cy = height/2;
  
  snakeX = cx-5;
  snakeY = cy-5;
  foodX = -1;
  foodY = -1;
  gameOver = false;
  check = true;
  snakeSize =1;
}
 
void draw(){
  
  if(speed%10 == 0){
    background(0);
    runGame();
  }
  speed++;
}
void reset(){
  snakeX = cx-5;
  snakeY = cy-5;
  gameOver = false;
  check = true;
  snakeSize =1; 
  moveY = 0;
  moveX = 0;
}
void runGame(){
  if(gameOver== false){
  
    drawfood();
    drawSnake();
    snakeMove();
    ateFood();
    checkHitSelf();
  }else{
      String modelString = "Game Over: Press 'Enter' to Restart";
      textAlign (CENTER);
    
      text(modelString,100,100,40); 
  }
}
void checkHitSelf(){
   for(int i = 1; i < snakeSize; i++){
       if(snakeX == snakesX[i] && snakeY== snakesY[i]){
          gameOver = true; 
      }
   }  
}
void ateFood(){
  if(foodX == snakeX && foodY == snakeY){
     check = true;
     snakeSize++; 
  }
}
void drawfood(){
  fill(foodColor);
  while(check){
    int x = (int)random(1,500/10);
    int y =  (int)random(1,500/10);
    foodX = 5+x*10;
    foodY = 5+y*10;
    
    for(int i = 0; i < snakeSize; i++){
       if(x == snakesX[i] && y == snakesY[i]){
         check = true;
         i = snakeSize;
       }else{
         check = false; 
       }
    }
    
  }
  
  rect(foodX-5, foodY-5, 10, 10);
    
}
void drawSnake(){
  fill(col);

  for(int i = 0; i < snakeSize; i++) {
    int X = snakesX[i];
    int Y = snakesY[i];
    rect(X-5,Y-5,10,10);
  }
  
  for(int i = snakeSize; i > 0; i--){
    snakesX[i] = snakesX[i-1];
    snakesY[i] = snakesY[i-1];
  }
}

void snakeMove(){
  snakeX += moveX;
  snakeY += moveY;
  //collision with wall
  if(snakeX > 500-5 || snakeX < 5||snakeY > 500-5||snakeY < 5){ 
     gameOver = true; 
  }
  snakesX[0] = snakeX;
  snakesY[0] = snakeY;
  
}
 
void keyPressed() {
  if(keyCode == UP) {  if(snakesY[1] != snakesY[0]-10){moveY = -10; moveX = 0;}}
  if(keyCode == DOWN) {  if(snakesY[1] != snakesY[0]+10){moveY = 10; moveX = 0;}}
  if(keyCode == LEFT) { if(snakesX[1] != snakesX[0]-10){moveX = -10; moveY = 0;}}
  if(keyCode == RIGHT) { if(snakesX[1] != snakesX[0]+10){moveX = 10; moveY = 0;}}
  if(keyCode == ENTER) {reset();}
}