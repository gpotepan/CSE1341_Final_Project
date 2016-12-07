//CSE1341 Final Project
//Grant Potepan
//Snake Game
//reference: https://www.openprocessing.org/sketch/50988# byIan151 -- used key pressed code and naming convention to keep consistency throughout code
// also used source code to help setup arrays but code used different conventions
// reference https://www.openprocessing.org/sketch/27164# to help with setup, keyPressed, and checkCollision (also viewed bouncing square hw)
//October 31st class notes

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
boolean alive = true;
int []snakeLengthX;
int []snakeLengthY;
int snakeLength = 1;
boolean gameOver = false;

void setup() {
  size(500, 500);
  speed = 200;
  snakeLengthX = new int[500];
  snakeLengthY = new int[500];
  //used bouncing square homework source code as template
  x = width/2;
  y = height/2;
  snakeX = x-5;
  snakeY = y-5;
  foodX = -1;
  foodY = -1;
  gameOver = false;
  alive = true;
  snakeLength =1;
}

void draw() {
  // **NEED TO MAKE TEXT DISAPPEAR WHEN GAME BEGINS**
  /*if (speed = 0){
   String startString = "Snake. Use the arrow keys to navigate the field and 'eat' the apple";
   textAlign (CENTER);
   text(startString, width/2, height/2);
   }
   */
  if (snakeLength < 10) {
    difficulty = 7;
  } else if (snakeLength > 10 && snakeLength < 20) {
    difficulty = 5;
  } else if (snakeLength >= 20){
    difficulty = 3;
  }
  
  if (speed%(difficulty) == 0) {
    background(131, 132, 137);
    runGame();
  }
  speed++;
}
void drawFood() {
  fill(foodColor);
  rect(foodX-5, foodY-5, 10, 10);
  while (alive) {
    int x = (int)round(random(1, 500/10));
    int y =  (int)round(random(1, 500/10));
    //used from source code (why doesnt foodX = random(0,500); work?)
    foodX = 5+x*10;
    foodY = 5+y*10;

    for (int i = 0; i < snakeLength; i++) {
      if (x == snakeLengthX[i] && y == snakeLengthY[i]) {
        alive = true;
        i = snakeLength;
      } else {
        alive = false;
      }
    }
  }
}

void drawSnake() {
  fill(snakeColor);
  for (int i = 0; i < snakeLength; i++) {
    int X = snakeLengthX[i];
    int Y = snakeLengthY[i];
    rect(X-5, Y-5, 10, 10);
  }
  for (int i = snakeLength; i > 0; i--) {
    snakeLengthX[i] = snakeLengthX[i-1];
    snakeLengthY[i] = snakeLengthY[i-1];
  }
}

//if the snake hits itself then the game is over
void checkCollision() {
  for (int i = 1; i < snakeLength; i++) {
    if (snakeX == snakeLengthX[i] && snakeY== snakeLengthY[i]) {
      gameOver = true;
    }
  }
}
void ateFood() {
  //if the location of the food is = to the location of the head of the snake
  if (foodX == snakeX && foodY == snakeY) {
    alive = true;
    //size increase due to each apple consumed 
    snakeLength=snakeLength+3;
  }
}


void moveSnake() {
  snakeX += moveX;
  snakeY += moveY;
  //if snake goes off the board, game is over
  if (snakeX > 500 || snakeX < 0||snakeY > 500||snakeY < 0) { 
    gameOver = true;
  }
  snakeLengthX[0] = snakeX;
  snakeLengthY[0] = snakeY;
}

//worked with britany in lab to develop working code 
//! reverses the boolean
void keyPressed() {
  int directionSpeed = 10;
  if (keyCode == UP) {  
    if (snakeLengthY[1] != snakeLengthY[0]-directionSpeed) {
      moveY = -directionSpeed; 
      moveX = 0;
    }
  }
  if (keyCode == DOWN) {  
    if (snakeLengthY[1] != snakeLengthY[0]+directionSpeed) {
      moveY = directionSpeed; 
      moveX = 0;
    }
  }
  if (keyCode == LEFT) { 
    if (snakeLengthX[1] != snakeLengthX[0]-directionSpeed) {
      moveX = -directionSpeed; 
      moveY = 0;
    }
  }
  if (keyCode == RIGHT) { 
    if (snakeLengthX[1] != snakeLengthX[0]+directionSpeed) {
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
    drawFood();
    drawSnake();
    moveSnake();
    ateFood();
    checkCollision();
  } else {
    //the game is over then display the restart instructions
    String endGameString = "Game Over: Press 'Enter' to Restart. Game Will Begin Immediately";
    textAlign (CENTER);
    text(endGameString, width/2, height/2);
  }
}

void reset() {
  setup();
}