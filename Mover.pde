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
