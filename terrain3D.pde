int rows, cols;
int gridSize = 10;
int planeWidth = 1000;
int planeHeight = 700;
float terrainSmooth = 10.0;
float terrainHeight = 100;
float yoff = 0.0;
float xoff = 0.0;
float offsetStep = -1/terrainSmooth;
float dyoff = offsetStep;
float dxoff = 0.0;
float eyeZ = 0;
float deyeZ = 0;

void setup() {
  size(640, 480, P3D);
  rows = planeHeight / gridSize;
  cols = planeWidth / gridSize + 1;
  colorMode(HSB);
  frameRate(15);
}

void draw() {
  background(0);
  translate(width/2, height/2);
  rotateX(PI/3);
  translate(-planeWidth/2, -planeHeight/2, eyeZ);
  stroke(0);
  for(int y=0; y<rows; y++) {
    float b = map(y, 0, rows, 0, 255);
    beginShape(TRIANGLE_STRIP);
    for(int x=0; x<cols; x++) {
      float noise1 = noise(xoff + x/terrainSmooth, yoff + y/terrainSmooth);
      float noise2 = noise(xoff + x/terrainSmooth, yoff + (y+1)/terrainSmooth);
      float h1 = map(noise1, 0, 1, -terrainHeight, terrainHeight);
      float h2 = map(noise2, 0, 1, -terrainHeight, terrainHeight);
      fill(map(h1, -terrainHeight, terrainHeight, 180, -50), 255, b);
      vertex(x * gridSize, y * gridSize, h1);
      vertex(x * gridSize, (y + 1) * gridSize, h2);
    }
    endShape();
  }

  yoff += dyoff;
  xoff += dxoff;
  eyeZ += deyeZ;
}

void keyPressed() {
  switch(keyCode) {
  case 32: // spacebar
    dyoff = dyoff == 0 ? offsetStep : 0;
    break;
  case 37: // left
    dxoff = offsetStep;
    break;
  case 38: // up
    deyeZ = -5;
    break;
  case 39: // right
    dxoff = -offsetStep;
    break;
  case 40: // down
    deyeZ = 5;
    break;
  case 87: // w
    frameRate(frameRate + 5);
    break;
  case 83: // s
    frameRate(frameRate - 5);
    break;
  default:
    break;
  }
}

void keyReleased() {
  dxoff = 0;
  deyeZ = 0;
}
