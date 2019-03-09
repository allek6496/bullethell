import java.util.Random;

public class Enemy {
  int x, y, h, w;
  final float r, velX, velY;
  boolean active = true;
  
  public Enemy(int x, int y, int h, int w, float a) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.r = a;
    
    this.velX = sin(r);
    this.velY = -cos(r);
  }
  
  private boolean collision(Box box) {
    int endY = y;
    int endX = x + w/2;

    return (endX > box.x1 && endY > box.y1 && endX < box.x4 && endY < box.y4);
  }
  
  public void update(Box box){
    if (active){
      if (collision(box)) {
        active = false;
        
        box.active = false;
      }
            
      if ((x > width || x < 0)) {
        active = false;
      } else {
        float speed = abs((mouseX-width/2) * speedScaling) + defaultSpeed;

        x += velX*speed;
        y += velY*speed;
        
        pushMatrix();
        rectMode(CENTER);
        fill(255, 0, 0);
        noStroke();
        translate(x, y);
        rotate(r);
        
        rect(0, 0, w, h);
        popMatrix();
      }
    } else {
      
    }
  }
}
