

import de.bezier.guido.*;
//Declare and initialize NUM_ROWS and NUM_COLS = 20
public final static int NUM_ROWS = 5;
public final static int NUM_COLS = 5;
public final static int NUM_BOMBS = 5;
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
    System.out.println(bombs);
    System.out.println(buttons[2][2].countBombs(2, 2));

}
public void setBombs()
{ 
    for(int i = 0; i < NUM_BOMBS; i++){
      //need fresh ranR ranC everytime
      int ranR = (int)(Math.random()*NUM_BOMBS); 
      int ranC = (int)(Math.random()*NUM_BOMBS);
      
      if(bombs.contains(buttons[ranR][ranC]) == false)
          bombs.add(buttons[ranR][ranC]);//bombs.add(0,buttons[ranR][ranC]);
      
    }
}

public void draw ()
{
    background( 0 );
    if(isWon())
        displayWinningMessage();
        
    for(int r=0; r<= NUM_ROWS-1; r++)
      for(int c=0; c<=NUM_COLS-1; c++)
         buttons[r][c].countBombs(r,c);
}
public boolean isWon()
{
    //your code here
    return false;
}
public void displayLosingMessage()
{
    text("YOU LOSE!",100,100);
}
public void displayWinningMessage()
{
    //your code here
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
    
        
        if(bombs.contains(this) == true)
          displayLosingMessage();
        else if(countBombs(r,c) > 0)
          setLabel(""+countBombs(r,c));
        
          
        if(mouseButton == RIGHT)
        {
          marked = !marked;
          if(marked == false)
            clicked = false;
        }
        //if(mouseButton == RIGHT && isMarked() == false){
        //  //clicked=false;
        //  marked = true;
        //}else{ 
        //  //clicked=false;
        //  marked =false;
        //}                  //System.out.print(isMarked());//marked = true;
          
        System.out.println(isMarked());
    }
/*public void mousePressed() which:
sets click to true
if mouseButton is RIGHT, toggles marked to either either true or false. If marked is false set click to false
else if bombs contains this button display the losing message
else if countBombs returns a number of neighboring mines greater than zero, set the label to that number. Note that to convert the int that countBombs() 
returns to a String you can add an empty string: ""+countBombs()
else recursively call mousePressed with the valid, unclicked, neighboring buttons in all 8 directions
*/
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
        //your code here
        if( (r >= 0  && r < 5)  &&  (c >= 0  && c < 5))
          return true;
        return false;
    }
    public int countBombs(int row, int col)//shit counts bombs in all 9 squares
    {
        int numBombs = 0;
        
        //if(isValid(row, col) == true) //OUT OF BOUNDS BC WE NEED TO CHECK ROW-1, +1, COL-1 COL+1 IS VALID LOCATION
          for(int r=row-1; r<=row+1; r++)
            for(int c=col-1; c<=col+1; c++)
              if(isValid(r,c) == true)
                if(bombs.contains(buttons[r][c]))
                  numBombs++;
          
        
        return numBombs;
    }
}
