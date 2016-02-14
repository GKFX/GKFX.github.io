final float a = 8f;

float noisePos = 0f;
PVector[][] dust;
PVector temp = new PVector();
PVector mouseVec = new PVector();

void setup() {
  jProcessingJS(this, {fullscreen: true} );
  colorMode(RGB, 1.0);
  dust = new PVector[10000][2];
  for (int i = 0; i < dust.length; ++i) {
    dust[i][0] = new PVector(random(width), random(height));
    dust[i][1] = new PVector(0, 0);
  }
  fill(0, 0.11);
  noStroke();
}

void draw() {
  rect(0, 0, width, height);
  noisePos += 0.008;
  mouseVec.x = mouseX;
  mouseVec.y = mouseY;
  loadPixels();

  for (PVector[] mote : dust) {
    // temp = acc
    if (mousePressed) {
      PVector.sub(mouseVec, mote[0], temp);
      if (temp.magSq() < 400) {
        mote[0].set(mouseX, mouseY);
        PVector.fromAngle(random(TWO_PI), temp).setMag(random(15, 20));
        mote[0].add(temp);
        mote[1].set(0, 0);
      }
      temp.setMag(10000 / (temp.magSq()*frameRate));
      mote[1].add(temp);
    } else {
      temp.x = (noise(mote[0].x/60, mote[0].y/60, noisePos)      - 0.5f) * (a/frameRate);
      temp.y = (noise(mote[0].x/60, mote[0].y/60, noisePos + 1f) - 0.5f) * (a/frameRate);
      float multFactor = pow(0.773922481, 1/frameRate);
      mote[1].x *= multFactor;
      mote[1].y *= multFactor;
      mote[1].add(temp);
    }

    // temp = Δr
    mote[0].add(PVector.mult(mote[1], a/frameRate, temp));
    mote[0].x = ((mote[0].x % width)  + width)  % width;
    mote[0].y = ((mote[0].y % height) + height) % height;
    pixels[floor(mote[0].x) + width*floor(mote[0].y)] = mote.hashCode();
  }
  updatePixels();
}
