final float a = 8f;

float noisePos = 0f;
PVector[][] dust;
PVector temp = new PVector();

void setup() {
  jProcessingJS(this, {fullscreen:true});
  colorMode(RGB, 1.0);
  dust = new PVector[10000][2];
  for (int i = 0; i < dust.length; ++i) {
    dust[i][0] = new PVector(random(width), random(height));
    dust[i][1] = new PVector(0, 0);
  }
  fill(0, 0.05);
  noStroke();
}

void draw() {
  rect(0, 0, width, height);
  noisePos += 0.008;
  loadPixels();
  for (PVector[] mote : dust) {
    // temp = acc
    temp.x = noise(mote[0].x/60, mote[0].y/60, noisePos) - 0.5f;
    temp.y = noise(mote[0].x/60, mote[0].y/60, noisePos + 1f) - 0.5f;
    mote[1].mult(0.99f).add(temp.mult(a/frameRate));
    
    // temp = Δr
    mote[0].add(PVector.mult(mote[1], a/frameRate, temp));
    mote[0].x = (mote[0].x + width) % width;
    mote[0].y = (mote[0].y + height) % height;
    pixels[floor(mote[0].x) + width*floor(mote[0].y)] = mote.hashCode();
  }
  updatePixels();
}
