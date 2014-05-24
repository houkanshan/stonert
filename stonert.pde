import processing.opengl.*;
import toxi.geom.*;

Boolean debug = false;

Flock flock;
SongAnalyzer songAnalyzer;
StageDirector stageDirector;
Sandstorm sandstorm;
String theme = "black";
color backgroundColor;
Boolean fullscreen = true;
Vec3D center;

Boolean recordMovie = false;

void setup() {
  //size(1024, 640, "processing.core.PGraphicsRetina2D");
  size(1024, 640, OPENGL);
  center = new Vec3D(width/2, height/2, 0);
  //size(displayWidth, displayHeight, OPENGL);
  //hint(ENABLE_RETINA_PIXELS); // useless..

  flock = new Flock();
  songAnalyzer = new SongAnalyzer(this, "song.mp3");
  sandstorm = new Sandstorm();
  stageDirector = new StageDirector(songAnalyzer, flock, sandstorm);

  if (theme == "black") {
    backgroundColor = mineShaft;
  } else {
    backgroundColor = white;
  }

  smooth();
}
boolean sketchFullScreen() {
  return fullscreen;
}

void draw() {
  background(backgroundColor);

  //openCamera();
  openLight();
  stageDirector.run();

  if (recordMovie) {
    saveFrame("dist/####.tif");
  }

}

void mousePressed() {
  songAnalyzer.toggle();
}

void keyPressed() {
  debug = !debug;
}

void openCamera() {
  float camZ = (height/2.0) / tan(PI*60.0 / 360.0);
  camera(mouseX, mouseY, camZ,
      width/2.0, height/2.0, 0,
      0, 1, 0); 
}

void openLight() {
  // TODO
  directionalLight(126, 126, 126, 0, 0, -1);
  ambientLight(102, 102, 102);
}
