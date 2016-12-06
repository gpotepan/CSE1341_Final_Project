//CSE1341 Final Project
//Grant Potepan
//Snake Game
//reference: https://www.openprocessing.org/sketch/50988# byIan151 -- used key pressed code and naming convention to keep consistency throughout code
// also used source code to help setup arrays but code used different conventions
// reference https://www.openprocessing.org/sketch/27164# to help with setup, keyPressed, and checkCollision (also viewed bouncing square hw)

color snakeColor = color(15, 93, 55);
color foodColor = color(255, 0, 0);
float speed = 2000;
int x, y;

int moveX = 0;
int moveY = 0;
int snakeX = 0;
int snakeY = 0;
int foodX = round(random(0, 10));
int foodY = round(random(0, 10));
int difficulty = 0;
boolean check = true;
int []snakesX;
int []snakesY;
int snakeSize = 1;
boolean gameOver = false;

void setup() {
  size(500, 500);
  speed = 200;
  snakesX = new int[500];
  snakesY = new int[500];
  //used bouncing square homework source code as template
  x = width/2;
  y = height/2;
  snakeX = x-5;
  snakeY = y-5;
  foodX = -1;
  foodY = -1;
  gameOver = false;
  check = true;
  snakeSize =1;
}

void draw() {
  // **NEED TO MAKE TEXT DISAPPEAR WHEN GAME BEGINS**
  /*if (speed = 0){
   String startString = "Snake. Use the arrow keys to navigate the field and 'eat' the apple";
   textAlign (CENTER);
   text(startString, width/2, height/2);
   }
   */
  if (snakeSize < 10) {
    difficulty = 7;
  } else if (snakeSize >= 10) {
    difficulty = 5;
  } 
  if (speed%(difficulty) == 0) {
    background(131, 132, 137);
    runGame();
  }
  speed++;
}


//if the snake hits itself then the game is over
void checkCollision() {
  for (int i = 1; i < snakeSize; i++) {
    if (snakeX == snakesX[i] && snakeY== snakesY[i]) {
      gameOver = true;
    }
  }
}
void ateFood() {
  //if the location of the food is = to the location of the head of the snake
  if (foodX == snakeX && foodY == snakeY) {
    check = true;
    //size increase due to each apple consumed 
    snakeSize=snakeSize+3;
  }
}
void drawfood() {
  fill(foodColor);
  while (check) {
    int x = (int)round(random(1, 500/10));
    int y =  (int)round(random(1, 500/10));
    //used from source code (why doesnt foodX = random(0,500); work?)
    foodX = 5+x*10;
    foodY = 5+y*10;

    for (int i = 0; i < snakeSize; i++) {
      if (x == snakesX[i] && y == snakesY[i]) {
        check = true;
        i = snakeSize;
      } else {
        check = false;
      }
    }
  }

  rect(foodX-5, foodY-5, 10, 10);
}
void drawSnake() {
  fill(snakeColor);

  for (int i = 0; i < snakeSize; i++) {
    int X = snakesX[i];
    int Y = snakesY[i];
    rect(X-5, Y-5, 10, 10);
  }

  for (int i = snakeSize; i > 0; i--) {
    snakesX[i] = snakesX[i-1];
    snakesY[i] = snakesY[i-1];
  }
}

void snakeMove() {
  snakeX += moveX;
  snakeY += moveY;
  //if snake goes off the board, game is over
  if (snakeX > 500-5 || snakeX < 5||snakeY > 500-5||snakeY < 5) { 
    gameOver = true;
  }
  snakesX[0] = snakeX;
  snakesY[0] = snakeY;
}

//worked with britany in lab to develop working code (code from source one used trig which I couldnt follow) 
void keyPressed() {
  int directionSpeed = 10;
  if (keyCode == UP) {  
    if (snakesY[1] != snakesY[0]-directionSpeed) {
      moveY = -directionSpeed; 
      moveX = 0;
    }
  }
  if (keyCode == DOWN) {  
    if (snakesY[1] != snakesY[0]+directionSpeed) {
      moveY = directionSpeed; 
      moveX = 0;
    }
  }
  if (keyCode == LEFT) { 
    if (snakesX[1] != snakesX[0]-directionSpeed) {
      moveX = -directionSpeed; 
      moveY = 0;
    }
  }
  if (keyCode == RIGHT) { 
    if (snakesX[1] != snakesX[0]+directionSpeed) {
      moveX = directionSpeed; 
      moveY = 0;
    }
  }
  if (keyCode == ENTER) {
    reset();
  }
}

void runGame() {
  if (gameOver== false) {
    //if the game is not over, call these functions
    drawfood();
    drawSnake();
    snakeMove();
    ateFood();
    checkCollision();
  } else {
    //the game is over then display the restart instructions
    String modelString = "Game Over: Press 'Enter' to Restart. Game Will Begin Immediately";
    textAlign (CENTER);
    text(modelString, width/2, height/2);
  }
}

void reset() {
  setup();
}