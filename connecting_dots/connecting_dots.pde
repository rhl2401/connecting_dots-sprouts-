int canvasSizeX = 1000;
int canvasSizeY = 1000;

int countDots = 6;
int maxDots = 500;
int dotSize = 20;
int [][] dotsArray = new int[maxDots][3];  // Array to hold dots. 0 is x, 1 is y and 2 is how many lines connected
int xPos=0, yPos=1, countConnections=2, workingDotIndex=3;

int [][] workingDots = new int[2][4];   // Array to hold the two dots to draw the line between
boolean isDrawingLine = false;
boolean gameOver = false;


void setup() {
  size(1000, 1000);
  
  fill(0,0,0);
  
  for (int i=0; i<countDots; i++) {
    int xCoord = (int)random(10+dotSize, canvasSizeX-10-dotSize);
    int yCoord = (int)random(10+dotSize, canvasSizeY-10-dotSize);
    
    dotsArray[i][0] = xCoord;
    dotsArray[i][1] = yCoord;
    
    circle(xCoord, yCoord, dotSize);
  }
}


void draw() {
  
}


void mousePressed() {
  if (!gameOver) {
    
    int mouseClickedX = mouseX;
    int mouseClickedY = mouseY;
    
    for (int i=0; i<countDots; i++) {
      
      if (mouseClickedX >= dotsArray[i][0]-dotSize/2 && 
          mouseClickedX <= dotsArray[i][0]+dotSize/2 && 
          mouseClickedY >= dotsArray[i][1]-dotSize/2 && 
          mouseClickedY <= dotsArray[i][1]+dotSize/2) 
      {
        println("Ramte prik " + i);
        
        
        if (isDrawingLine) {
          workingDots[1][xPos] = dotsArray[i][xPos];
          workingDots[1][yPos] = dotsArray[i][yPos]; 
          workingDots[1][countConnections] = dotsArray[i][countConnections];
          workingDots[1][workingDotIndex] = i;
          
          println(workingDots[0]);
          println(workingDots[1]);
          
          // countCOnnections == 2 is equal to 3 actual connections as we start from 0
          if (workingDots[0][countConnections] >= 3 || workingDots[1][countConnections] >= 3) {
            //background(255,0,0);    // Indicate game over
            gameOver = true;
            textSize(130);
            textAlign(CENTER, CENTER);
            text("Game Over",500,450);
          } else {
            fill(0,0,0);
            circle(workingDots[0][xPos], workingDots[0][yPos], dotSize);
            
            line(workingDots[0][xPos], workingDots[0][yPos], workingDots[1][xPos], workingDots[1][yPos]);
            
            
            // Calculate coordinates for new dot
            int newDotX, newDotY;
            if (workingDots[0][xPos] > workingDots[1][xPos]) {
              newDotX = workingDots[0][xPos] - abs(workingDots[0][xPos]-workingDots[1][xPos])/2;
            } else {
              newDotX = workingDots[1][xPos] - abs(workingDots[0][0]-workingDots[1][xPos])/2;
            }
            
            if (workingDots[0][yPos] > workingDots[1][yPos]) {
              newDotY = workingDots[0][yPos] - abs(workingDots[0][yPos]-workingDots[1][yPos])/2;
            } else {
              newDotY = workingDots[1][yPos] - abs(workingDots[0][yPos]-workingDots[1][yPos])/2;
            }
            
            
            // Insert new dot into array
            dotsArray[countDots][xPos] = newDotX;
            dotsArray[countDots][yPos] = newDotY;
            dotsArray[countDots][countConnections] = 2;
            countDots++;
            
            // Add one connection to the dots that the line is drawn between
            dotsArray[workingDots[0][workingDotIndex]][countConnections]++;
            dotsArray[workingDots[1][workingDotIndex]][countConnections]++;
            
            circle(newDotX, newDotY, dotSize);
            isDrawingLine = false;
          }
          
        } else {
          // Store information in workingDots array for use when next dot is pressed
          workingDots[0][xPos] = dotsArray[i][xPos];
          workingDots[0][yPos] = dotsArray[i][yPos]; 
          workingDots[0][countConnections] = dotsArray[i][countConnections];
          workingDots[0][workingDotIndex] = i;
          isDrawingLine = true;
          
          // Make dot red to indicate active state
          fill(255,0,0);
          circle(workingDots[0][xPos], workingDots[0][yPos], dotSize);
        }
       
        break; 
      }  // if a dot is actually hit
    }  // for
  }  // if (!gameOVer)
}  // void mousePressed
