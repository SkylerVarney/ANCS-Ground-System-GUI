PImage img;

void setup() {
  size(2180, 1258, P2D); // Set canvas size
  background(80); // Set background color
  img = loadImage("ANCSGroundSystems 1.png");
}

void draw() {
  background(80); // Clear the canvas
  strokeWeight(3);
  scale(2);
  
  // ANCS logo
  image(img, 415, 8);
  

  // Draw Status Panel
  float statusX = 19;
  float statusY = 20;
  float statusWidth = 311;
  float statusHeight = 159;
  fill(50);
  stroke(186, 91, 76);
  rect(statusX, statusY, statusWidth, statusHeight, 20);
  fill(196);
  textSize(18);
  text("Status", 148, 46);
  text("GPS Coords:", 34, 72);
  text("Connection:", 34, 100);
  text("Voltage:", 34, 127);

  // Draw Fin Control Panel
  float finX = 19;
  float finY = 193;
  float finWidth = 311;
  float finHeight = 270;
  fill(50);
  rect(finX, finY, finWidth, finHeight, 20);
  fill(196);
  textSize(18);
  text("Fin Angles", 33, 238);
  text("0.0°, 0.0°, 0.0°, 0.0°", 165, 238);
  text("Fin #", 33, 275);
  text("Rotate", 33, 322);

  // Draw buttons for fin control
  fill(174, 174, 174);
  strokeWeight(0);
  
  rect(152, 253, 36, 36, 5);
  rect(193, 253, 36, 36, 5);
  rect(234, 253, 36, 36, 5);
  rect(274, 253, 36, 36, 5);
  
  rect(152, 295, 49, 49, 5);
  rect(207, 295, 49, 49, 5);
  rect(262, 295, 49, 49, 5);
  
  rect(152, 349, 49, 49, 5);
  rect(207, 349, 49, 49, 5);
  rect(262, 349, 49, 49, 5);
  
  fill(0);
  text("1", 166, 277); // x is plus 2, y is plus 15 to figma, plus 17 to center
  text("2", 206, 277);
  text("3", 247, 277);
  text("4", 287, 277);
  
  text("+1", 165, 324);
  text("+2", 220, 324);
  text("+3", 276, 324);
  
  text("-1", 167, 380);
  text("-2", 222, 380);
  text("-3", 278, 380);
  
  strokeWeight(3);

  
  /*
  for (int i = 0; i < 4; i++) {
    for (int j = 0; j < 2; j++) {
      float buttonX = finX + 10 + i * 50;
      float buttonY = finY + 60 + j * 50;
      fill(180);
      rect(buttonX, buttonY, 40, 40, 5);
      fill(0);
      textSize(18);
      
      text((j == 0 ? "+" : "-") + (i + 1), buttonX + 20, buttonY + 20);
    }
  }
  */

  // Draw Test buttons
  fill(180);
  strokeWeight(0);
  rect(38, 413, 125, 35, 5);
  rect(186, 413, 125, 35, 5);
  strokeWeight(3);
  fill(0);
  text("Fin Test", 75, 436);
  text("GNC Test", 216, 436);

  // Draw Launch Panel
  float launchX = 20;
  float launchY = 479;
  float launchWidth = 310;
  float launchHeight = 136;
  fill(50);
  stroke(255, 0, 0);
  rect(launchX, launchY, launchWidth, launchHeight, 20);
  fill(255, 100, 100);
  strokeWeight(0);
  rect(114, 561, 125, 35);
  strokeWeight(3);
  fill(255);
  textSize(20);
  text("Launch", 142, 5);

  // Draw Rocket Display
  float rocketX = 343;
  float rocketY = 96;
  float rocketWidth = 389;
  float rocketHeight = 370;
  fill(50);
  stroke(79, 137, 204);
  rect(rocketX, rocketY, rocketWidth, rocketHeight, 20);
  fill(100);
  //rect(rocketX + 110, rocketY + 80, 40, 200); // Rocket body

  // Draw Real-time Data Panels
  float dataPanelX = 742;
  float dataPanelY = 17;
  float dataPanelWidth = 332;
  float dataPanelHeight = 449;
  fill(50);
  stroke(99, 156, 95);
  rect(dataPanelX, dataPanelY, dataPanelWidth, dataPanelHeight, 20);
  fill(255);
  textSize(18);
  text("Des. Angle, Real Angle", dataPanelX + 10, dataPanelY + 20);
  text("Pitch: 0.0°, 0.0°", dataPanelX + 10, dataPanelY + 40);
  text("Yaw: 0.0°, 0.0°", dataPanelX + 10, dataPanelY + 60);
  text("Roll: 0.0°, 0.0°", dataPanelX + 10, dataPanelY + 80);

  // Draw Graphs
  drawGraph(570, 479, "Alt.", color(79, 137, 204));
  drawGraph(742, 479, "Vel.", color(211, 170, 82));
  drawGraph(912, 479, "Acc.", color(186, 91, 76));
}

void drawGraph(float x, int y, String label, color lineColor) {
  fill(50);
  stroke(lineColor);
  rect(x, y, 162, 132, 20);
  fill(255);
  textSize(18);
  text(label + ": ", x + 10, y + 20);

  noFill();
  /* beginShape();
  for (int i = 0; i < 100; i++) {
    vertex(x + i, y + 100 - noise(i * 0.1) * 80);
  }
  endShape();
  */
}
