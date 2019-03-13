

import de.bezier.guido.*;
//Declare and initialize NUM_ROWS and NUM_COLS = 20
public final static int NUM_ROWS = 5;
public final static int NUM_COLS = 5;
public final static int NUM_BOMBS = 3;
public int unOpened = NUM_ROWS * NUM_COLS;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> bombs; //ArrayList of just the minesweeper buttons that are mined

void setup ()
{
    size(400, 400);
    textAlign(CENTER,CENTER);
    
    // make the manager
    Interactive.make( this );
    
    //your code to initialize buttons goes here
    buttons = new MSButton[NUM_ROWS][NUM_COLS];
    bombs = new ArrayList<MSButton>(); 

    for(int r=0; r<= NUM_ROWS-1; r++)
      for(int c=0; c<=NUM_COLS-1; c++)
        buttons[r][c] = new MSButton(r,c);
       
    
    setBombs();
    //System.out.println(bombs);
    //System.out.println(buttons[2][2].countBombs(2, 2));

}
public void setBombs()
{ 
    for(int i = 0; i < NUM_BOMBS; i++){
      //need fresh ranR ranC everytime
      int ranR = (int)(Math.random()*NUM_ROWS); 
      int ranC = (int)(Math.random()*NUM_COLS);
      
      if(bombs.contains(buttons[ranR][ranC]) == false)
          bombs.add(buttons[ranR][ranC]);//bombs.add(0,buttons[ranR][ranC]);
      
    }
}

public void draw ()
{
    background( 0 );
    if(isWon() == true)
        displayWinningMessage();
        
    for(int r=0; r<= NUM_ROWS-1; r++)
      for(int c=0; c<=NUM_COLS-1; c++)
         buttons[r][c].countBombs(r,c);
         
    if(isWon() == true)
      displayWinningMessage();
}
public boolean isWon()
{
      
  /*for(int r = 0; r<NUM_ROWS; r++){
      for(int c =0 ; c<NUM_COLS; c++){
        if(buttons[r][c].isClicked() && bombs.contains(buttons[r][c]) == true){ //lose
          return false;
        }
        if(
      }
    }
    */
    return false;
}
public void displayLosingMessage()
{
    
  text("YOU LOSE!",100,100);
  System.out.print("YOU LOSE");
    //this.setLabel("bob");
    //System.out.print("bob");
}
public void displayWinningMessage()
{
  text("YOU WIN!",100,100);
  System.out.print("We Won");
 
}
public class MSButton
{
    private int r, c;
    private float x,y, width, height;
    private boolean clicked, marked;
    private String label;
    
    public MSButton ( int rr, int cc )
    {
         width = 400/NUM_COLS;
         height = 400/NUM_ROWS;
        r = rr;
        c = cc; 
        x = c*width;
        y = r*height;
        label = "";
        marked = clicked = false;
        Interactive.add( this ); // register it with the manager
    }
    public boolean isMarked()
    {
        return marked;
    }
    public boolean isClicked()
    {
        return clicked;
    }
    // called by manager
    
    public void mousePressed () 
    {
        clicked = true;
      
        if(mouseButton == RIGHT){
          marked = !marked;
          if(marked == false)
            clicked = false;
        }
        else if(bombs.contains(this) == true)
          displayLosingMessage();
        else if(countBombs(r,c) > 0)
          setLabel(""+countBombs(r,c));
        else {
          for(int R=r-1; R<=r+1; R++)
            for(int C=c-1; C<=c+1; C++)
              if(isValid(R,C) == true) //if valid
                if(bombs.contains(buttons[R][C]) == false) //and not a bomb
                  if(buttons[R][C].isClicked() != true) //and not clicked
                    buttons[R][C].mousePressed(); //press all 9 cubes
        }

        System.out.println(isMarked());
    }
    public void draw () 
    {    
        if (marked)
            fill(0); //black
         else if( clicked && bombs.contains(this) ) 
             fill(255,0,0); //red
        else if(clicked)
            fill( 200 ); //white
        else 
            fill( 100 ); //grey

        rect(x, y, width, height);
        fill(0); //black
        text(label,x+width/2,y+height/2);
    }
    public void setLabel(String newLabel)
    {
        label = newLabel;
    }
    public boolean isValid(int r, int c)
    {
        if( (r >= 0  && r < NUM_ROWS)  &&  (c >= 0  && c < NUM_COLS))
          return true;
        return false;
    }
    public int countBombs(int row, int col)//shit counts bombs in all 9 squares
    {
        int numBombs = 0;
       
          for(int r=row-1; r<=row+1; r++)
            for(int c=col-1; c<=col+1; c++)
              if(isValid(r,c) == true)
                if(bombs.contains(buttons[r][c]))
                  numBombs++;
          
        return numBombs;
    }
}
