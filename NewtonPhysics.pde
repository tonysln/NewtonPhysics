ArrayList<Mover> movers;

public double distance(float x1, float y1, float x2, float y2) {
    double xDistance = x2 - x1;
    double yDistance = y2 - y1;
    return Math.sqrt((xDistance * xDistance) + (yDistance * yDistance));
}

void setup() {
    size(640,460);
    movers = new ArrayList<Mover>();
    for (int i = 0; i < 55; i++) {
        float mass = random(0.4, 1);
        float radius = (mass * 40)/2;
        int x = Math.round(random(radius, width - radius));
        int y = Math.round(random(radius, height - radius));     
        if (i != 0) {
            for (int j = 0; j < movers.size(); j++) {
                if (distance(x, y, movers.get(j).location.x, movers.get(j).location.y) 
                - (radius + movers.get(j).radius) < 0) {
                    mass = random(0.4, 1);
                    radius = (mass * 40)/2;
                    x = Math.round(random(radius, width - radius));
                    y = Math.round(random(radius, height - radius));  
                    j = -1;
                }
            }
        }  
        movers.add(new Mover(x, y, mass));
    }
}

void keyPressed() {
    if (keyCode == ' ') {
        float mass = random(0.4, 1);
        movers.add(new Mover(mouseX, mouseY, mass));
    }
}

void draw() {
    background(255);
    
    for (Mover m : movers) {
        PVector gravity = new PVector(0, 0.5);
        gravity.mult(m.mass);
        m.applyForce(gravity);
        
        PVector wind = new PVector(0.9, 0);
        if (mousePressed) {
            m.applyForce(wind);
        }
    
        PVector friction = m.velocity.copy();
        friction.normalize();
        friction.mult(-1);
        float c = 0.09;
        friction.mult(c);
        m.applyForce(friction);
        
        PVector drag = m.velocity.copy();
        drag.normalize();
        drag.mult(-1);
        float c_drag = 0.00001;
        float speed = m.velocity.magSq();
        drag.mult(c_drag*speed);
        m.applyForce(drag); 
    
        m.update(movers);
        m.checkEdges();
        m.display();
    }
}
