import java.util.*;

int points = 0;
float difficultyMod = 0.25;
float speedScaling = 0.02;
int defaultSpeed = 2;
float timer = 0;
Random rand = new Random();
float spawnRate = 2*difficultyMod;
float reSpawnRate = spawnRate;
int delay = rand.nextInt(int(spawnRate * 60));
List<Enemy> enemies = new ArrayList<Enemy>();
List<WhiteCircle>  circles = new ArrayList<WhiteCircle>();

Box box = new Box(width/2, height/2, 25, 25);

public void setup() {
  //size(500, 500, P2D);
  fullScreen(P2D);
  rectMode(CENTER);
  textAlign(CORNER);
  //smooth();
}

public void draw() {
  background(100, 181, 246);
  
  if (box.active) {
    if (mouseX > width*3/4 || mouseX < width/4) {
        timer += 1.5;
      } else {
        timer += 1;
      }
    
    if (timer >= 60 && box.active) {
      points += 1;
      timer = 0;
    }
    
    if (delay == 0) {
      delay = rand.nextInt(int(spawnRate*60));
      
      if (rand.nextInt(max((45 - int(points)), 1)) == 0 && points > 20) {
        int x = rand.nextInt(2);
        int y = rand.nextInt(height-10) + 5;
        circles.add(new WhiteCircle(x*width, y, 10, 30));
        print("New Circle, " + circles.size() + " \n");
      } else {
        int x = rand.nextInt(2);
        int y = rand.nextInt(height-10) + 5;
        enemies.add(new Enemy(x*(width), y, 30, 10, HALF_PI*(x*-2+1)));
        print("New Enemy, " + enemies.size() + " \n");
        //enemies.add(new Enemy());
      }
    } else {
      delay -= 1;
    }
    
    if (points > 10 && spawnRate > 1) {
      spawnRate = 1*difficultyMod;
    } else if (points > 20 && spawnRate == 1) {
      spawnRate = 0.6*difficultyMod;
    } else if (points > 30 && spawnRate == 0.6) {
      spawnRate = 0.3*difficultyMod;
    } else if (points > 40 && spawnRate == 0.3) {
      spawnRate = 0.6*difficultyMod;
    } else if (points > 50 && spawnRate == 0.6) {
      spawnRate = 0.3*difficultyMod;
    } else if (points > 60 && spawnRate == 0.3) {
      spawnRate = 0.15*difficultyMod;
    } else if (points > 75 && spawnRate == 0.15) {
      spawnRate = 0.05*difficultyMod;
    } else if (points > 100 && spawnRate == 0.05) {
      spawnRate = 0.001*difficultyMod;
    }
    
    
    fill(255);
    text(points, 10, 20);
  
    box.update(); 
    Iterator<WhiteCircle> n = circles.iterator();
    while (n.hasNext()) {
      WhiteCircle current = n.next();
      
      if (current.active) {
        current.update(box);
      } else {
        n.remove();
      }
    }
    
    Iterator<Enemy> i = enemies.iterator();
    while (i.hasNext()) {
      Enemy current = i.next();
      
      if (current.active) {
        current.update(box);
      } else {
        i.remove();
      }
    }
  } else {
    print("You scored ", points, " points!");
    points = 0;
    box.active = true;
    spawnRate = reSpawnRate;
    Iterator<Enemy> i = enemies.iterator();
    while (i.hasNext()) {
      i.next();
      i.remove();
    }
    Iterator<WhiteCircle> n = circles.iterator();
    while (n.hasNext()) {
      n.next();
      n.remove();
    }
  }
}
