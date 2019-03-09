public class Box {
  int x, y, w, h, m;
  int tl, bl, tr, br;
  float r = 0f;
  boolean active = true;
  int x1, y1, x4, y4;
  
  public Box(int x, int y, int w, int h){
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }
  
  public void update(){
    rectMode(CENTER);
    noStroke();
    fill(0);
    
    if (active){
      float opp = abs(cos(r) * w);
      float adj = abs(sin(r) * w);
      
      float w_temp = opp + adj;
      
      x1 = x - int(w_temp)/2;
      y1 = y - int(w_temp)/2;
      x4 = x + int(w_temp)/2;
      y4 = y + int(w_temp)/2;
            
      //Show the bounding box
      //rectMode(CORNERS);
      //fill(255, 0, 0);
      //rect(x1, y1, x4, y4);
      
      
      x = mouseX;
      y = mouseY;
      if (r >= TWO_PI || r <= -TWO_PI) {
        r = 0;
      }
      r += (mouseX-width/2)*0.001;
      
      pushMatrix();
      fill(0);
      rectMode(CENTER);
      translate(x, y);
      rotate(r);

      rect(0, 0, w, h);
      popMatrix();
    }
  }
  
  //public boolean isPressed() {
  //  boolean pressed = false;
    
  //  if (mousePressed){
  //    if ((x - w/2 < mouseX && mouseX < x + w/2) && (y - h/2 < mouseY && mouseY < y + h/2)) {
        
  //    }
  //  }
    
  //  return pressed;
  //}
}
