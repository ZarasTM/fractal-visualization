PImage img;
FractalSet fractal;
Button button1, button2, button3;
int width = 800;
int height = 600;
int state = 0; // 0-zoom, 1-constant manipulation
boolean mandelbrot = true;

void setup() {
  size(800, 630);
  img = createImage(width, height, HSB);
  colorMode(HSB);
  button1 = new Button(2, height+2, width/3-1, height+28);
  button1.setText("Zoom");
  button2 = new Button(width/3+1, height+2, (width/3-1)*2, height+28);
  button2.setText("Set constant");
  button3 = new Button((width/3)*2, height+2, width-2, height+28);
  button3.setText("Get mandelbrot");
  
  fractal = new FractalSet(img, 500);
  fractal.calcMandelbrot();
}

void mouseClicked(){
  if(overImg(mouseX, mouseY)){
    if(state == 0){
      fractal.setCenter(mouseX, mouseY);
      if(mouseButton == LEFT){
        fractal.zoom(0.5);
      }else if(mouseButton == RIGHT){
        fractal.zoom(1.5);
      }
    }else if(state == 1){
      if(mouseButton == LEFT){
        fractal.setConstant(mouseX, mouseY);
      }
    }
  }else if(button1.isOver(mouseX, mouseY)){
    System.err.println("Zoom, state = 0");
    state = 0;
  }else if(button2.isOver(mouseX, mouseY)){
    System.err.println("Modify constant, state = 1");
    state = 1;
    mandelbrot = false;
  }else if(button3.isOver(mouseX, mouseY)){
    System.err.println("Getting mandelbrot "+(!mandelbrot));
    mandelbrot = true;
  }
  
  if(mandelbrot){
    fractal.calcMandelbrot();
  }else{
    fractal.calcJuliaSet();
    if(state == 1){fractal.drawConst();}
  }
}

boolean overImg(int x, int y){
  return (x < width && y < height) ? true : false;
}

void draw() {
  background(50);
  image(img, 0, 0);
  button1.display();
  button2.display();
  button3.display();
}
