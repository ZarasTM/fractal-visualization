class FractalSet{
  private PImage img;
  
  // Default variable values
  private float[] center = {0.0, 0.0};
  private float[][] range = {{-2.0, 2.0}, {2.0, -2.0}}; // First pair is upper left, second is bottom right
  private float[][] scale = {{-2.0, 2.0}, {2.0, -2.0}};
  private float[] constant = {0.0, 0.0};
  private int[] constPixel;
  private int maxIterations = 200;
  
  public FractalSet(PImage img){
    this.img = img;
    
    this.range[0][1] *= ((float)img.height/img.width);
    this.range[1][1] *= ((float)img.height/img.width);
    
    this.scale[0][1] *= ((float)img.height/img.width);
    this.scale[1][1] *= ((float)img.height/img.width);
    
    constPixel = new int[]{img.width/2, img.height/2};
    
    zoom(1.0);
  }
  
  public FractalSet(PImage img, int maxIter){
    this(img);
    this.maxIterations = maxIter;
  }
   
  public void calcMandelbrot(){
    float minRange, maxRange;
    double a, b, constA, constB, complexA, complexB;
    int n, col;
    for(int x=0; x<img.width; x++){
      for(int y=0; y<img.height; y++){
        minRange = range[0][0];
        maxRange = range[1][0];
        a = map(x, 0, img.width, minRange, maxRange);
        
        minRange = range[1][1];
        maxRange = range[0][1];
        b = map(y, 0, img.height, minRange, maxRange);
        
        constA = a;
        constB = b;
        complexA = a;
        complexB = b;
      
        n = 0;
        while(n < maxIterations){
          complexA = a*a - b*b;
          complexB = 2*a*b;
        
          a = complexA + constA;
          b = complexB + constB;
        
          // If diverges to inf
          if(a*a + b*b > 4) break;

          n++;
        }
      
        // The faster diverges the brighter it gets
        col = 0;
        if(n != maxIterations){
          col = floor(map(n, 0, maxIterations, 0, 255));
        }
      
        img.pixels[x+(y*img.width)] = color(col*col);
      }
    }
    img.updatePixels();
  }
  
  public void calcJuliaSet(){
    float minRange, maxRange;
    double a, b, constA, constB, complexA, complexB;
    int n, col;
    for(int x=0; x<img.width; x++){
      for(int y=0; y<img.height; y++){
        minRange = range[0][0];
        maxRange = range[1][0];
        a = map(x, 0, img.width, minRange, maxRange);
        
        minRange = range[1][1];
        maxRange = range[0][1];
        b = map(y, 0, img.height, minRange, maxRange);
        
        constA = constant[0];
        constB = constant[1];
        complexA = a;
        complexB = b;
      
        n = 0;
        while(n < maxIterations){
          complexA = a*a - b*b;
          complexB = 2*a*b;
        
          a = complexA + constA;
          b = complexB + constB;
        
          // If diverges to inf
          if(a*a + b*b > 4) break;

          n++;
        }
      
        // The faster diverges the brighter it gets
        col = 0;
        if(n != maxIterations){
          col = floor(map(n, 0, maxIterations, 0, 255));
        }
      
        img.pixels[x+(y*img.width)] = color(col*col*col);
      }
    }
    img.updatePixels();
  }
  
  private void drawConst(){
    for(int x=-1; x<=1; x++){
      for(int y=-1; y<=1; y++){
        img.pixels[(constPixel[0]+x)+((constPixel[1]+y)*img.width)] = color(255, 255, 255);
      }
    }
    img.updatePixels();
  }
  
  public void setConstant(int x, int y){
    this.constant[0] = map(x, 0, img.width, range[0][0], range[1][0]);
    this.constant[1] = map(y, 0, img.height, range[1][1], range[0][1]);
    
    this.constPixel[0] = x;
    this.constPixel[1] = y;
  }
  
  public void setMaxIterations(int val) {this.maxIterations = val;}
  
  public void setCenter(float x, float y){
    this.center[0] = map(x, 0, img.width, range[0][0], range[1][0]);
    this.center[1] = map(y, 0, img.height, range[1][1], range[0][1]);
    
    // Recalculate range X
    this.range[0][0] = scale[0][0]+center[0];
    this.range[1][0] = scale[1][0]+center[0];
    // Recalculate range Y
    this.range[0][1] = scale[0][1]+center[1];
    this.range[1][1] = scale[1][1]+center[1];
  }
  
  public void zoom(float mult){    
    // Recalculate range
    float rangeSize = (abs(range[0][0]-range[1][0]))*mult;

    range[0][0] = center[0]-rangeSize/2;
    range[1][0] = center[0]+rangeSize/2;
    scale[0][0] = -rangeSize/2;
    scale[1][0] = rangeSize/2;
    
    rangeSize = (abs(range[1][1]-range[0][1]))*mult;
    range[0][1] = center[1]-rangeSize/2;
    range[1][1] = center[1]+rangeSize/2;
    scale[0][1] = -rangeSize/2;
    scale[1][1] = rangeSize/2;
  }
}
