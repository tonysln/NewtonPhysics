class Mover {
    PVector location;
    PVector velocity;
    PVector acceleration;
    float mass;
    float radius;
    int x, y;

    Mover(int x, int y, float mass) {
        this.x = x;
        this.y = y;
        this.mass = mass;
        radius = (mass * 40)/2;
        location = new PVector(x, y);
        velocity = new PVector(0, 0);
        acceleration = new PVector(0, 0);
    }

    void applyForce(PVector force) {
        PVector f = PVector.div(force, mass);
        acceleration.add(f);
    }

    void update(ArrayList<Mover> movers) {
        velocity.add(acceleration);
        location.add(velocity);
        acceleration.mult(0);
        for (int i = 0; i < movers.size(); i++) {
            if (this == movers.get(i)) {
                continue;
            }
            if (distance(location.x, location.y, movers.get(i).location.x, movers.get(i).location.y) 
                - (radius + movers.get(i).radius) < 0) {
                
                PVector velDiff = PVector.sub(velocity, movers.get(i).velocity); 
                PVector locDiff = PVector.sub(location, movers.get(i).location);
                
                if (velDiff.x * locDiff.x + velDiff.y * locDiff.y <= 0) {
                    float angle = (float)-Math.atan2(movers.get(i).location.y - location.y, movers.get(i).location.x - location.x);
                    float m1 = mass;
                    float m2 = movers.get(i).mass;
                    
                    PVector u1 = new PVector((float)(velocity.x * Math.cos(angle) - velocity.y * Math.sin(angle)), (float)(velocity.x * Math.sin(angle) + velocity.y * Math.cos(angle)));
                    PVector u2 = new PVector((float)(movers.get(i).velocity.x * Math.cos(angle) - movers.get(i).velocity.y * Math.sin(angle)), (float)(movers.get(i).velocity.x * Math.sin(angle) + movers.get(i).velocity.y * Math.cos(angle)));
                    
                    PVector v1 = new PVector((u1.x * (m1-m2)/(m1+m2) + u2.x * 2 * m2 / (m1+m2)), (u1.y));
                    PVector v2 = new PVector((u2.x * (m2-m1)/(m1+m2) + u1.x * 2 * m1 / (m1+m2)), (u2.y));
                    
                    PVector vFinal1 = new PVector((float)(v1.x * Math.cos(-angle) - v1.y * Math.sin(-angle)), (float)(v1.x * Math.sin(-angle) + v1.y * Math.cos(-angle)));
                    PVector vFinal2 = new PVector((float)(v2.x * Math.cos(-angle) - v2.y * Math.sin(-angle)), (float)(v2.x * Math.sin(-angle) + v2.y * Math.cos(-angle)));
                    
                    velocity.x = vFinal1.x;
                    velocity.x = vFinal1.y;
                    movers.get(i).velocity.x = vFinal2.x;
                    movers.get(i).velocity.y = vFinal2.y;
                    
                }
                    
            }
        }
    }

    void display() {
        stroke(0);
        fill(175);
        ellipse(location.x, location.y, radius*2, radius*2);
    }

    void checkEdges() {
        if (location.x + radius > width) {
            location.x = width - radius;
            velocity.x = -velocity.x;
        } else if (location.x - radius < 0) {
            velocity.x = -velocity.x;
            location.x = 0 + radius;
        }
        
        if (location.y + radius > height) {
            velocity.y = -velocity.y;
            location.y = height - radius;
        } else if (location.y - radius < 0) {
            location.y = 0 + radius;
            velocity.y = -velocity.y;
        }
    }
}
