int canvasSizeX = 1000;
int canvasSizeY = 1000;

int countDots = 6;
int maxDots = 500;
int dotSize = 20;
int [][] dotsArray = new int[maxDots][2];  // Array to hold dots. 0 is x and 1 is y

int [][] workingDots = new int[2][2];   // Array to hold the two dots to draw the line between
boolean isDrawingLine = false;


void setup() {
  size(1000, 1000);
  
  fill(0,0,0);
  circle(0,0,10);
  
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
        workingDots[1][0] = dotsArray[i][0];
        workingDots[1][1] = dotsArray[i][1]; 
        
        fill(0,0,0);
        circle(workingDots[0][0], workingDots[0][1], dotSize);
        
        line(workingDots[0][0], workingDots[0][1], workingDots[1][0], workingDots[1][1]);
        isDrawingLine = false;        
        
      } else {
        workingDots[0][0] = dotsArray[i][0];
        workingDots[0][1] = dotsArray[i][1]; 
        isDrawingLine = true;
        
        fill(255,0,0);
        circle(workingDots[0][0], workingDots[0][1], dotSize);
      }
     
      break; 
    }
  }
}
