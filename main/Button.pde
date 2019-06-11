class Button{
  private int x1, x2, y1, y2;
  private int width, height;
  private int[] buttonCol, textCol; // HSB mode
  private int textSize = 16;
  private String text = "Button";
  
  // CONSTRUCTORS
  public Button(int x1, int y1, int x2, int y2){
    this.x1 = x1;
    this.x2 = x2;
    this.y1 = y1;
    this.y2 = y2;
    this.width = x2 - x1;
    this.height = y2 - y1;
    this.buttonCol = new int[] {0, 0, 255};
    this.textCol = new int[] {0, 0, 0};
  }

  public Button(int x1, int y1, int x2, int y2, String text){
    this(x1, y1, x2, y2);
    this.text = text;
  }
  
  
  // METHODS
  public boolean isOver(int x, int y){
     return ((x < x2 && x > x1) && (y < y2 && y > y1)) ? true : false;
  }  
  
  public void display(){
    noStroke();
    colorMode(HSB);
    // Paint button
    if(isOver(mouseX, mouseY)){
      fill(buttonCol[0], buttonCol[1], buttonCol[2]-50); 
    }else{
      fill(buttonCol[0], buttonCol[1], buttonCol[2]); 
    }
    rect(x1, y1, width, height);
    
    // Paint text
    fill(textCol[0], textCol[1], textCol[2]);
    textAlign(CENTER, CENTER);
    textSize(textSize);
    text(text, x1+(width/2), y1+(height/2)-(textSize/8));
  }
  
  // GETTERS AND SETTERS
  public void setCoordinates(int x1, int y1, int x2, int y2){
    this.x1 = x1;
    this.x2 = x2;
    this.y1 = y1;
    this.y2 = y2;
    this.width = x2 - x1;
    this.height = y2 - y1;
  }
  public int[] getCoordinates(){return new int[] {x1, y1, x2, y2};}
  
  public void setButtonColor(int hue, int sat, int bright) {    
    this.buttonCol[0] = hue;
    this.buttonCol[1] = sat;
    this.buttonCol[2] = bright;
  }
  public int[] getButtonColor() {return this.buttonCol;}
  
  public void setTextColor(int hue, int sat, int bright) {
    this.textCol[0] = hue;
    this.textCol[1] = sat;
    this.textCol[2] = bright;
  }
  public int[] getTextColor() {return this.textCol;}
  
  public void setText(String text){this.text = text;}
  public String getText(){return this.text;}
  
  public void setTextSize(int size){this.textSize = size;}
  public int getTextSize(){return this.textSize;}
}
