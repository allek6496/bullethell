import java.util.Random;

public class WhiteCircle {
  int x, y, r, h, counter;
  float velX, velY;
  boolean up = true, active = true;
  
  public WhiteCircle (int x, int y, int r, int h) {
    this.x = x;
    print(x, "\n");
    this.y = y;
    this.h = h;
    this.r = r;
    if (x == 0) {
      velX = 0.5;
    } else {
      velX = -0.5;
    }
  }
  
  private boolean collision(Box box) {
    int endY = y;
    int endX = x + r*int(velX/abs(velX));

    return (endX > box.x1 && endY > box.y1 && endX < box.x4 && endY < box.y4);
  }
  
  private boolean OOB() {
    return (0 <= x && x < width +1 && 0 < y && y < height);
  }
  
  public void update (Box box) {
    if (active && !collision(box) && OOB()) {
      counter += 1;
      
      if (counter == h){
        counter = 0;
        velY = 0;
        up = !up;
      }
      if (!up) {
        if (velX/abs(velX) == -1) {
          velY -= 0.06;
        } else {
          velY -= 0.03;
        }
      } else {
        if (velX/abs(velX) == 1) {
          velY += 0.06;
        } else {
          velY += 0.03;
        }
      }
      
      float speed = abs((mouseX-width/2) * speedScaling) + defaultSpeed;      
      x += velX*speed;
      y += velY*speed;
      
      pushMatrix();
      fill(255);
      noStroke();
      translate(x, y);
      
      circle(0, 0, r);
      popMatrix();

      
    } else if (collision(box)) {
      print("White circle collided with box");
      active = false;
      box.active = false;
    } else if (!OOB()) {
      print("Circle OOB at ", x, "\n");
      active = false;
    }
  }
}
