import ddf.minim.analysis.*;

class FFTWave {
  float maxLoudLess = 3500;
  AudioPlayer song;
  FFT L;
  FFT R;
  FFT M;
  float amp = width/2;
  float loudLess;
  int averages = 60;
  ArrayList<Vec3D> vecs;
  
  FFTWave(AudioPlayer _song) {
    song = _song;
    L = new FFT(song.bufferSize(), song.sampleRate());
    L.linAverages(100);
    R = new FFT(song.bufferSize(), song.sampleRate());
    M = new FFT(song.bufferSize(), song.sampleRate());
    M.linAverages(averages); // maybe should not use.


    initVecs();
  }

  void run() {
    update();
    render();
  }

  void update() {
    L.forward(song.left);
    R.forward(song.right);
    M.forward(song.mix);

    loudLess = min(getLoudLess(), maxLoudLess);
  }

  void render() {
    int ilen;

    ilen = L.avgSize();
    for(int i = 0; i < ilen; i++) {
      if (i % 2 != 0) { continue; }
      float y = height/2 + i * 20 + 50;
      float x = min(log(L.getAvg(i) + 1) * 300, 500);
      if (x < 20) { continue; }
      renderSignal(x, i);
    }
  }

  void initVecs() {
    vecs = new ArrayList<Vec3D>();
    int ilen = L.avgSize();
    for(int i = 0; i < ilen; i++) {
      vecs.add(Vec3D.randomVector());
      vecs.add(Vec3D.randomVector());
    }
  }

  float getLoudLess() {
    float loudLess = 0;
    int ilen = M.avgSize();
    for(int i = 0; i < ilen; i++) {
      loudLess += M.getAvg(i);
    }
    return loudLess;
  }

  void renderSignal(float x, int i) {
    Vec3D v1 = vecs.get(i).normalizeTo(x);
    Vec3D v2 = vecs.get(i+1).normalizeTo(x);
    beginShape();

    stroke(black, map(x, 0, 500, 100, 255));
    lineV(center, v1.add(center));
    lineV(center, v2.add(center));

    endShape(CLOSE);
  }
}
