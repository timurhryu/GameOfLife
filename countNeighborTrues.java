public boolean isValid5by5(int row, int col){
 return (row < 5 && row >= 0 && col < 5 && col >= 0);
}

public int countNeighborTrues(int row, int col){
   boolean[][] grid  ={{true,false,false,true,false},
                      {false,false,false,false,true},
                      {false,true, true,false, false},
                      {false,false,false,false,false},
                      {true,false,false,true,false}};
  if (!isValid5by5(row, col)) {
    return -1;
  }
  
  int x = 0;
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
