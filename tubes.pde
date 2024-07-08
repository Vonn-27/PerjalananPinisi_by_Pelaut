import ddf.minim.*;

Minim minim;
AudioPlayer sceneSound;

int t = 1;
int scene1Duration = 25 * 30; // 25 detik * 30 FPS
float shipX = -300; // Posisi awal kapal di luar layar
float shipY = 400;
float shipX3 = -300;
float shipX1 = -300;
float shipY1 = 400;
float shipX2 = -300;
float shipY2 = 400;
float shipX4 = -300;
float shipX5 = -300;
float sunX = 800; // Posisi awal matahari
float sunY = 200;
float sunSize = 100; // Ukuran matahari
float waveHeight = 10; // Tinggi gelombang laut
float waveSpeed = 0.02; // Kecepatan gelombang laut
int frameDuration = 45 * 30; // Durasi animasi (45 detik * 30 FPS)
int numBirds = 5; // Jumlah burung laut
boolean hasDocked = false;
float waveOffset = 0; // Offset untuk animasi ombak

// Array untuk menyimpan posisi burung laut
float[] birdX = new float[numBirds];
float[] birdY = new float[numBirds];
float[] birdAngle = new float[numBirds];
float birdSpeed = 1.5; // Kecepatan burung laut

int trunkColor;
int leafColor;
int coconutColor;

float ikanX1, ikanX2, ikanX3, ikanX4;
int kapalX; 
float angle1, angle2, angle3;

int numStars = 100; // Jumlah bintang
float[][] stars = new float[numStars][2]; // Array untuk menyimpan koordinat bintang
float kapalX7 = -300; // Posisi awal kapal di luar layar sebelah kiri
float gelombangOffset = 0; // Offset untuk animasi gelombang laut
float kapalX8 = -300; // Posisi awal kapal di luar layar sebelah kiri untuk scene8
float kapalSpeed = 2; // Kecepatan kapal
boolean kapalBerhenti = false; // Status kapal apakah berhenti atau tidak

void setup() {
  size(1280, 720); // Ukuran layar diubah menjadi 1280x720
  frameRate(30); // Set frame rate ke 30 FPS
  
  minim = new Minim(this);
  sceneSound = minim.loadFile("Water.mp3");
  
  sceneSound.loop();
  
  // Inisialisasi posisi awal burung laut secara acak
  for (int i = 0; i < numBirds; i++) {
    birdX[i] = random(width);
    birdY[i] = random(height / 2);
    birdAngle[i] = random(TWO_PI); // Arah awal burung laut
  }
  
  trunkColor = color(139, 69, 19); // Warna batang pohon
  leafColor = color(34, 139, 34); // Warna daun pohon
  coconutColor = color(165, 42, 42); // Warna kelapa

  kapalX = 0;
  angle1 = 0;
  angle2 = 0;
  angle3 = 0;
  
  // Inisialisasi posisi bintang
  for (int i = 0; i < numStars; i++) {
    stars[i][0] = random(width); // Koordinat x bintang
    stars[i][1] = random(height / 2); // Koordinat y bintang (hanya di bagian atas layar)
  }
}

void draw() {
  if (t <= scene1Duration) {
    scene1();
  } else if ((t > scene1Duration) && (t <= scene1Duration * 2)) {
    scene2();
  } else if ((t > scene1Duration * 2) && (t <= scene1Duration * 3)) {
    scene3();
  } else if ((t > scene1Duration * 3) && (t <= scene1Duration * 4)) {
    scene4();
  } else if ((t > scene1Duration * 4) && (t <= scene1Duration * 5)) {
    scene5();
  } else if ((t > scene1Duration * 5) && (t <= scene1Duration * 6)) {
    scene6();
  } else if ((t > scene1Duration * 6) && (t <= scene1Duration * 7)) {
    scene7();
  } else if ((t > scene1Duration * 7) && (t <= scene1Duration * 8)) {
    scene8();
  }
  t++;
  if (t > scene1Duration * 8) { 
    exit();
  }
}

void scene1() {
  if (!sceneSound.isPlaying()) {
    sceneSound.rewind();
    sceneSound.play();
  }
  drawSkyAndSeaScene1();
  drawSunScene1();
  kapalScene1(shipX, shipY);
  shipX += 2;
  if (sunY > 100) {
    sunY -= 1;
  }
  drawClouds();
}

void scene2() {
  if (!sceneSound.isPlaying()) {
    sceneSound.rewind();
    sceneSound.play();
  }
  drawSkyAndSeaScene2();
  drawSunScene2();
  drawClouds();
  drawShip();
  shipX1 += 2;
  for (int i = 0; i < numBirds; i++) {
    moveBird(i);
    drawBird(birdX[i], birdY[i], birdAngle[i]);
  }
}

void scene3() {
  if (!sceneSound.isPlaying()) {
    sceneSound.rewind();
    sceneSound.play();
  }
  background(135, 206, 250); // Warna langit biru muda
  drawSun();
  drawClouds();
  drawSea();
  drawLand();
  kapal(shipX2, shipY2);
  shipX2 += 2;
  waveOffset += 0.05;
}

void scene4() {
  if (!sceneSound.isPlaying()) {
    sceneSound.rewind();
    sceneSound.play();
  }
  background(135, 206, 235);
  fill(0, 105, 148);
  noStroke();
  rect(0, height/2, width, height/2);
  drawClouds();
  penyu(1200,650);
  pushMatrix();
  translate(200, 630);
  rotate(angle1);
  fill(255, 192, 203);
  star(0, 0, 10, 20, 5); 
  popMatrix();
  pushMatrix();
  translate(100, 650);
  rotate(angle2);
  fill(255, 192, 203);
  star(0, 0, 30, 60, 5); 
  popMatrix();
  pushMatrix();
  translate(150, 700);
  rotate(angle3);
  fill(255, 192, 203);
  star(0, 0, 10, 20, 5); 
  popMatrix();
  angle1 += 0.02;
  angle2 += 0.015;
  angle3 += 0.01;
  ikan(ikanX1, height - 100, 30, color(255, 165, 0));
  ikan(ikanX2, height - 150, 40, color(255, 0, 0));
  ikan(ikanX3, height - 200, 35, color(0, 255, 0));
  ikan(ikanX4, height - 250, 35, color(0, 255, 0));
  ikanX1 += 2;
  ikanX2 += 2.5;
  ikanX3 += 1.5;
  ikanX4 += 1;
  if (ikanX1 > width) ikanX1 = -50;
  if (ikanX2 > width) ikanX2 = -50;
  if (ikanX3 > width) ikanX3 = -50;
  if (ikanX4 > width) ikanX4 = -50;
  kapal(shipX3, 400);
  if (shipX3 < width / 2 - 135) {
    shipX3 += 2;
  }
}

void scene5() {
  if (!sceneSound.isPlaying()) {
    sceneSound.rewind();
    sceneSound.play();
  }
  background(135, 206, 235);
  drawClouds();
  fill(0, 105, 148);
  noStroke();
  rect(0, height/2, width, height/2);
  kapal(shipX4, 400);
  shipX4 += 2;
  ikan(ikanX1, height - 100, 30, color(255, 165, 0));
  ikan(ikanX2, height - 150, 40, color(255, 0, 0));
  ikan(ikanX3, height - 200, 35, color(0, 255, 0));
  ikan(ikanX4, height - 250, 35, color(0, 255, 0));
  ikanX1 += 2;
  ikanX2 += 2.5;
  ikanX3 += 1.5;
  ikanX4 += 1;
  if (ikanX1 > width) ikanX1 = -50;
  if (ikanX2 > width) ikanX2 = -50;
  if (ikanX3 > width) ikanX3 = -50;
  if (ikanX4 > width) ikanX3 = -50;
}

void scene6() {
  if (!sceneSound.isPlaying()) {
    sceneSound.rewind();
    sceneSound.play();
  }
  background(135, 206, 235); 
  fill(0, 105, 148);
  noStroke();
  rect(0, height/2, width, height/2);
  fill(105, 105, 105);
  noStroke();
  ellipse(200, 100, 150, 80);
  ellipse(250, 100, 180, 90);
  ellipse(220, 130, 170, 90);
  ellipse(600, 80, 200, 100);
  ellipse(650, 100, 220, 110);
  ellipse(620, 130, 200, 100);
  kapal(shipX5, 400);
  shipX5 += 2; 
  stroke(173, 216, 230);
  strokeWeight(2);
  for (int i = 0; i < 100; i++) {
    int rainX = (int) random(width);
    int rainY = (int) random(height);
    line(rainX, rainY, rainX + 5, rainY + 10);
  }
  if (random(1) < 0.01) { // Kemungkinan petir
    drawLightning();
  }
}

void scene7() {
  if (!sceneSound.isPlaying()) {
    sceneSound.rewind();
    sceneSound.play();
  }
  background(0); // Latar belakang hitam untuk langit
  // Gambar bintang-bintang
  fill(255);
  noStroke();
  for (int i = 0; i < numStars; i++) {
    ellipse(stars[i][0], stars[i][1], 3, 3); // Bintang-bintang kecil
  }
  // Bulan
  fill(255);
  noStroke();
  ellipse(width / 2, height / 2, 400, 400);
  drawWaves();
  kapal(kapalX7, height / 2 + 20 * sin((kapalX7 + gelombangOffset) * 0.05)); // Kapal mengikuti gelombang
  kapalX7 += 2; // Kapal bergerak dari kiri ke kanan
  gelombangOffset -= 1; // Gerakkan gelombang ke kiri untuk ilusi pergerakan
  if (kapalX7 > width) { // Ulangi posisi kapal dari kiri jika sudah di luar layar sebelah kanan
    kapalX7 = -300;
  }
}

void scene8() {
  if (!sceneSound.isPlaying()) {
    sceneSound.rewind();
    sceneSound.play();
  }
  background(0, 0, 51); // Latar belakang biru tua untuk malam hari
  drawMoon();
  drawStars();
  drawHarbor();
  drawWaves1();
  kapal(kapalX8, height / 2 + 70 + 20 * sin((kapalX8 + gelombangOffset) * 0.05)); // Kapal mengikuti gelombang
  
  if (!kapalBerhenti) {
    kapalX8 += kapalSpeed; // Kapal bergerak ke kanan
    gelombangOffset -= kapalSpeed; // Gerakkan gelombang ke kiri untuk ilusi pergerakan

    if (kapalX8 >= 700) { // Kapal berhenti saat mencapai pelabuhan
      kapalBerhenti = true;
    }
  }
}

void drawMoon() {
  // Gambar bulan
  fill(255);
  noStroke();
  ellipse(width / 2, height / 3, 200, 200);
}

void drawStars() {
  // Gambar bintang-bintang
  fill(255);
  noStroke();
  for (int i = 0; i < numStars; i++) {
    ellipse(stars[i][0], stars[i][1], 3, 3);
  }
}

void drawWaves1() {
  // Gelombang air
  fill(0, 0, 205);
  beginShape();
  for (int x = 0; x <= width; x++) {
    float y = height / 2 + 70 + 20 * sin((x + gelombangOffset) * 0.05);
    vertex(x, y);
  }
  vertex(width, height);
  vertex(0, height);
  endShape(CLOSE);
}

void drawHarbor() {
  // Gambar pelabuhan
  fill(139, 69, 19); // Warna coklat untuk pelabuhan
  beginShape();
  vertex(700, height / 2 + 70);
  vertex(1000, height / 2 + 70);
  vertex(1000, height);
  vertex(700, height);
  endShape(CLOSE);
  
  // Gambar garis pelabuhan
  stroke(0);
  strokeWeight(2);
  for (int i = 0; i < 5; i++) {
    line(700 + i * 50, height / 2 + 70, 700 + i * 50, height);
  }
  
  // Gambar tiang-tiang pelabuhan
  fill(160, 82, 45); // Warna lebih terang untuk tiang
  for (int i = 0; i < 5; i++) {
    rect(700 + i * 50 - 5, height / 2 + 50, 10, 30);
  }
}

void kapal(float x, float y) {
  stroke(0);
  
  // Badan kapal
  fill(139, 69, 19);
  beginShape();
  vertex(x, y);
  vertex(x, y + 15);
  vertex(x + 10, y + 30);
  vertex(x + 200, y + 30);
  vertex(x + 220, y + 8);
  vertex(x + 270, y - 2);
  vertex(x + 230, y);
  vertex(x, y);
  endShape();
  
  // Ruang kapal
  fill(160, 82, 45);
  quad(x, y, x, y - 30, x + 110, y - 30, x + 110, y);
  
  // Tiang kapal
  strokeWeight(1.5);
  line(x + 180, y, x + 180, y - 170);
  line(x + 90, y - 30, x + 90, y - 190);
  
  // Layar kapal
  fill(255, 255, 255); 
  triangle(x + 182, y - 20, x + 182, y - 100, x + 270, y - 17);
  quad(x + 115, y - 30, x + 120, y - 110, x + 178, y - 95, x + 178, y - 20);
  triangle(x + 122, y - 115, x + 155, y - 150, x + 178, y - 100);
  quad(x + 20, y - 50, x + 30, y - 130, x + 88, y - 115, x + 88, y - 40);
  triangle(x + 32, y - 135, x + 66, y - 170, x + 88, y - 120);
  
  // Bendera
  triangle(x + 150, y - 165, x + 178, y - 160, x + 178, y - 170);
  triangle(x + 60, y - 185, x + 88, y - 190, x + 88, y - 180);
}

void drawSkyAndSeaScene1() {
  color skyColor = lerpColor(color(0, 0, 128), color(135, 206, 250), map(sunY, 720, 100, 0, 1));
  background(skyColor);
  color seaColor = lerpColor(color(0, 0, 255), color(70, 130, 180), map(sunY, 720, 100, 0, 1));
  fill(seaColor);
  rect(0, height / 2, width, height / 2);
}

void drawSunScene1() {
  fill(255, 215, 0); 
  ellipse(sunX, sunY, sunSize, sunSize);
}

void kapalScene1(float x, float y) {
  stroke(0);
  fill(139, 69, 19);
  beginShape();
  vertex(x, y);
  vertex(x, y + 15);
  vertex(x + 10, y + 30);
  vertex(x + 200, y + 30);
  vertex(x + 220, y + 8);
  vertex(x + 270, y - 2);
  vertex(x + 230, y);
  vertex(x, y);
  endShape();
  fill(160, 82, 45);
  quad(x, y, x, y - 30, x + 110, y - 30, x + 110, y);
  strokeWeight(1.5);
  line(x + 180, y, x + 180, y - 170);
  line(x + 90, y - 30, x + 90, y - 190);
  fill(255);
  triangle(x + 182, y - 20, x + 182, y - 100, x + 270, y - 17);
  quad(x + 115, y - 30, x + 120, y - 110, x + 178, y - 95, x + 178, y - 20);
  triangle(x + 122, y - 115, x + 155, y - 150, x + 178, y - 100);
  quad(x + 20, y - 50, x + 30, y - 130, x + 88, y - 115, x + 88, y - 40);
  triangle(x + 32, y - 135, x + 66, y - 170, x + 88, y - 120);
  fill(255, 0, 0);
  triangle(x + 150, y - 165, x + 178, y - 160, x + 178, y - 170);
  triangle(x + 60, y - 185, x + 88, y - 190, x + 88, y - 180);
}

void drawSkyAndSeaScene2() {
  color skyColor = lerpColor(color(41, 179, 241), color(255), map(sunY, 200, height, 0, 1));
  background(skyColor);
  color seaColor = lerpColor(color(0, 0, 255), color(255, 165, 0), map(sunY, 200, height, 0, 1));
  fill(seaColor);
  rect(0, height / 2, width, height / 2);
  drawWaves();
}

void drawWaves() {
  noStroke();
  fill(0, 0, 255);
  for (int x = 0; x < width; x += 10) {
    float waveOffset = sin(x * waveSpeed + frameCount * 0.05) * waveHeight;
    rect(x, height / 2 + waveOffset, 10, height / 2);
  }
}

void drawSunScene2() {
  fill(255, 165, 0); 
  ellipse(sunX, sunY, sunSize, sunSize);
}

void drawShip() {
  stroke(0);
  float x = shipX1;
  float y = shipY1;
  fill(139, 69, 19);
  beginShape();
  vertex(x, y);
  vertex(x, y + 15);
  vertex(x + 10, y + 30);
  vertex(x + 200, y + 30);
  vertex(x + 220, y + 8);
  vertex(x + 270, y - 2);
  vertex(x + 230, y);
  vertex(x, y);
  endShape();
  fill(160, 82, 45);
  quad(x, y, x, y - 30, x + 110, y - 30, x + 110, y);
  strokeWeight(1.5);
  line(x + 180, y, x + 180, y - 170);
  line(x + 90, y - 30, x + 90, y - 190);
  fill(255);
  triangle(x + 182, y - 20, x + 182, y - 100, x + 270, y - 17);
  quad(x + 115, y - 30, x + 120, y - 110, x + 178, y - 95, x + 178, y - 20);
  triangle(x + 122, y - 115, x + 155, y - 150, x + 178, y - 100);
  quad(x + 20, y - 50, x + 30, y - 130, x + 88, y - 115, x + 88, y - 40);
  triangle(x + 32, y - 135, x + 66, y - 170, x + 88, y - 120);
  fill(255, 0, 0);
  triangle(x + 150, y - 165, x + 178, y - 160, x + 178, y - 170);
  triangle(x + 60, y - 185, x + 88, y - 190, x + 88, y - 180);
}

void drawClouds() {
  drawCloud(300, 200, 80);
  drawCloud(600, 250, 100);
  drawCloud(800, 150, 70);
}

void drawCloud(float x, float y, float size) {
  fill(255, 255, 255, map(sunY, 720, 100, 0, 255));
  noStroke();
  ellipse(x, y, size, size / 2);
  ellipse(x + size / 2, y - size / 4, size, size / 2);
  ellipse(x - size / 2, y - size / 4, size, size / 2);
  ellipse(x + size, y, size, size / 2);
  ellipse(x - size, y, size, size / 2);
}

void moveBird(int index) {
  birdX[index] += birdSpeed;
  if (birdX[index] > width) {
    birdX[index] = 0;
  }
}

void drawBird(float x, float y, float angle) {
  pushMatrix();
  translate(x, y);
  rotate(angle);
  fill(255);
  noStroke();
  ellipse(0, 0, 30, 15);
  fill(97, 69, 60);
  beginShape();
  vertex(-25, 0);
  vertex(0, -30);
  vertex(5, 0);
  vertex(0, 10);
  endShape(CLOSE);
  fill(200);
  triangle(-15, 0, -20, -5, -20, 5);
  popMatrix();
}

void drawSun() {
  fill(255, 223, 0); 
  ellipse(850, 150, 100, 100); 
}

void drawSea() {
  fill(70, 130, 180); 
  rect(0, height / 2, width, height / 2);
}

void drawLand() {
  fill(210, 180, 140); 
  beginShape();
  vertex(0, height / 2 + 100);
  vertex(width, height / 2 + 100);
  vertex(width, height);
  vertex(0, height);
  endShape(CLOSE);
  for (int i = 0; i < 1000; i++) {
    float x = random(width);
    float y = random(height / 2 + 100, height);
    fill(222, 184, 135); 
    noStroke();
    ellipse(x, y, 2, 2);
  }
  drawPalmTree(70, height / 2 + 230);
  drawPalmTree(100, height / 2 + 300);
  drawPalmTree(120, height / 2 + 400);
}

void drawPalmTree(int x, int y) {
  fill(trunkColor); 
  noStroke();
  rect(x - 5, y - 100, 10, 100);
  fill(leafColor); 
  for (int i = 0; i < 5; i++) {
    pushMatrix();
    translate(x, y - 100);
    rotate(radians(72 * i));
    ellipse(0, -30, 80, 20);
    popMatrix();
  }
  fill(coconutColor); 
  ellipse(x - 10, y - 130, 20, 20);
}

void ikan(float x, float y, float bdn, color warna) {
  fill(warna);
  noStroke();
  ellipse(x, y, bdn * 2, bdn);
  triangle(x - bdn, y, x - bdn * 1.5, y - bdn / 2, x - bdn * 1.5, y + bdn / 2);
  fill(0);
  ellipse(x + bdn / 2, y - bdn / 4, bdn / 5, bdn / 5);
}

void penyu(int x, int y) {
  fill(34, 139, 34); 
  ellipse(x, y, 60, 85);
  fill(0, 128, 0); 
  ellipse(x, y - 45, 16, 16);
  fill(0, 100, 0); 
  ellipse(x + 35, y - 10, 20, 35);
  ellipse(x - 35, y - 10, 20, 35);
  fill(0, 100, 0);
  ellipse(x + 25, y + 40, 12, 20);
  ellipse(x - 25, y + 40, 12, 20);
}

void star(float x, float y, float radius1, float radius2, int npoints) {
  float angle = TWO_PI / npoints;
  float halfAngle = angle / 2.0;
  beginShape();
  for (float a = 0; a < TWO_PI; a += angle) {
    float sx = x + cos(a) * radius2;
    float sy = y + sin(a) * radius2;
    vertex(sx, sy);
    sx = x + cos(a + halfAngle) * radius1;
    sy = y + sin(a + halfAngle) * radius1;
    vertex(sx, sy);
  }
  endShape(CLOSE);
}

void drawLightning() {
  stroke(255, 255, 0);
  strokeWeight(4);
  int startX = (int) random(width);
  int startY = (int) random(height / 2);
  int endX = startX + (int) random(-30, 30);
  int endY = startY + (int) random(20, 60);
  line(startX, startY, endX, endY);
  for (int i = 0; i < 4; i++) {
    startX = endX;
    startY = endY;
    endX = startX + (int) random(-30, 30);
    endY = startY + (int) random(20, 60);
    line(startX, startY, endX, endY);
  }
}
