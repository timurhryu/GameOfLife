import de.bezier.guido.*;
final int NUM_ROWS = 20;
final int NUM_COLS = 20;
private Life[][] buttons; //2d array of Life buttons each representing one cell
private boolean[][] buffer; //2d array of booleans to store state of buttons array
private boolean running = true; //used to start and stop program

public void setup () {
  size(400, 400);
  frameRate(6);
  buttons = new Life[NUM_ROWS][NUM_COLS];
  buffer = new boolean[NUM_ROWS][NUM_COLS];
  // make the manager
  Interactive.make( this );

  //your code to initialize buttons goes here
  for ( int row  = 0; row < NUM_ROWS; row++) {
    for (int col = 0; col < NUM_COLS; col++) {
      buttons[row][col]= new Life(row, col);
    }
  }



  //your code to initialize buffer goes here
  for ( int row  = 0; row < NUM_ROWS; row++) {
    for (int col = 0; col < NUM_COLS; col++) {
      buffer[row][col]= new Boolean(false);
    }
  }
}

public void draw () {
  background( 0 );
  if (running == false) //pause the program
    return;

  //store current state of buttons into a buffer
  copyFromButtonsToBuffer();

  //use nested loops to 
  //  First draw the buttons here
  for ( int row  = 0; row < NUM_ROWS; row++) {
    for (int col = 0; col < NUM_COLS; col++) {
      buttons[row][col].draw();
    }
  }
  copyFromButtonsToBuffer();
  for ( int row  = 0; row < NUM_ROWS; row++) {
    for (int col = 0; col < NUM_COLS; col++) {
      if (isValid5by5 (row, col)) {
        if (buttons[row][col].getLife() && (countNeighbors( row, col) < 2 || countNeighbors( row, col) > 3) ) {
          buffer[row][col] = false;
        } else if (!buttons[row][col].getLife() && countNeighbors( row, col) == 3) {
          buffer[row][col] = true;
        }
      }
    }
  }
  copyFromBufferToButtons();
 
}

public void keyPressed() {
  //your code here
}

public void copyFromBufferToButtons() {
  for (int r = 0; r <NUM_ROWS; r++) {
    for (int c = 0; c <NUM_COLS; c++) {
      buttons[r][c].setLife(buffer[r][c]);
    }
  }
}

public void copyFromButtonsToBuffer() {
  for (int r = 0; r <NUM_ROWS; r++) {
    for (int c = 0; c <NUM_COLS; c++) {
      buffer[r][c] = buttons[r][c].getLife();
    }
  }
}

public boolean isValid5by5(int r, int c) {
  return (r < 5 && r >= 0 && c < 5 && c >= 0);
}

public int countNeighbors(int row, int col) {
  int x = 0;

  boolean[][] grid  ={{true, false, false, true, false}, 
    {false, false, false, false, true}, 
    {false, true, true, false, false}, 
    {false, false, false, false, false}, 
    {true, false, false, true, false}};
  if (!isValid5by5(row, col)) {
    return -1;
  }


  for (int r = Math.max(0, row - 1); r <= Math.min(4, row + 1); r++) {
    for (int c = Math.max(0, col - 1); c <= Math.min(4, col + 1); c++) {
      if (c != col || r != row) {
        if (grid[r][c]) {
          x++;
        }
      }
    }
  }

  return x;
}
