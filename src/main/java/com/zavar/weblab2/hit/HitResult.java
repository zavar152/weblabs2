package com.zavar.weblab2.hit;

public class HitResult {
    private final float r;
    private final Point point;
    private boolean result = false;

    public HitResult(Point point, float r) {
        this.point = point;
        this.r = r;

        float x = point.getX();
        float y = point.getY();
        if (x >= 0 && y >= 0 && y <= r && x <= r/2) {
            result = true;
        } else if (x <= 0 && y >= 0 && y <= x+r/2) {
            result = true;
        } else if (x >= 0 && y <= 0 && y <= Math.sqrt(r*r/4 - x*x)) {
            result = true;
        }
    }

    public float getX() {
        return point.getX();
    }

    public float getY() {
        return point.getY();
    }

    public float getR() {
        return r;
    }

    public boolean getResult() {
        return result;
    }
}
