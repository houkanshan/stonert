class SandBody {
  SandBody() {
  }
  
  void run() {
    update();
    render();
  }

  void update() {
  }

  void render() {
    noStroke();
    if (theme == "black") {
      fill(black, 255);
      ellipse(0, 0, 2, 2);
    } else {
      fill(oxford, 200);
      ellipse(0, 0, 3, 3);
    }
  }
}
