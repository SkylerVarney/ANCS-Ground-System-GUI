PImage img;
PShape obj;

//variables for graph
ArrayList<Float> pitchDataPoints;// Store the graph's data points
ArrayList<Float> yawDataPoints;
ArrayList<Float> rollDataPoints;
ArrayList<Float> accelDataPoints;
ArrayList<Float> velDataPoints;
ArrayList<Float> altDataPoints;
int graphWidth = 200; // Width of the graph in pixels
int maxPoints = 300;  // Number of data points to display, controls speed of graph
float newPitchValue = 0;   // New value to add to the graph
float newYawValue = 0;
float newRollValue = 0;
float newAccelValue = 0;
float newVelValue = 0;
float newAltValue = 0;
ArrayList<Float> pitchVerticalLines; 
ArrayList<Float> yawVerticalLines;
ArrayList<Float> rollVerticalLines;
ArrayList<Float> accelVerticalLines;
ArrayList<Float> velVerticalLines;
ArrayList<Float> altVerticalLines;

float truezAccel = 0; // acceleration after gravity correction
float r, g, b;

float previousAcceleration = 0; // Store last acceleration value
float previousVelocity = 0;
float lastTime = 0; // Last timestamp in milliseconds


import processing.serial.*;
Serial myPort; // Declare Serial object
String data; // Variable to store incoming data
float roll, pitch, yaw, zAccel, alt, vel; // Variables to store parsed values

void setup() {
  size(1400, 800, P3D); // Set canvas size
  background(80); // Set background color
  img = loadImage("ANCSGroundSystems 1.png");
  
  // obj file
  obj = loadShape("ANCS rocket model.mtl.obj"); // Load the .obj file
  obj.scale(0.2); // Optional: Scale the object for visibility
  
  // Open the serial port (change the index to match your Arduino port)
  String portName = "/dev/cu.usbserial-130";
  myPort = new Serial(this, portName, 115200);
  delay(2000);
  myPort.clear();
  myPort.bufferUntil('\n'); // Read data until a newline character

  // list for data points to be plotted
  pitchDataPoints = new ArrayList<Float>(); // Initialize the data points list
  yawDataPoints = new ArrayList<Float>();
  rollDataPoints = new ArrayList<Float>();
  accelDataPoints = new ArrayList<Float>();
  velDataPoints = new ArrayList<Float>();
  altDataPoints = new ArrayList<Float>();
  // list for vertical lines in graph
  pitchVerticalLines = new ArrayList<Float>(); // list for vertical lines in graph
  yawVerticalLines = new ArrayList<Float>();
  rollVerticalLines = new ArrayList<Float>();
  accelVerticalLines = new ArrayList<Float>();
  velVerticalLines = new ArrayList<Float>();
  altVerticalLines = new ArrayList<Float>();


  // Fill the graph with initial values (e.g., zeros)
  for (int i = 0; i < maxPoints; i++) {
    pitchDataPoints.add(null);
  }
  for (int i = 0; i < maxPoints; i++) {
    yawDataPoints.add(null);
  }
  for (int i = 0; i < maxPoints; i++) {
    rollDataPoints.add(null);
  }
  for (int i = 0; i < maxPoints; i++) {
    accelDataPoints.add(null);
  }
  for (int i = 0; i < maxPoints; i++) {
    velDataPoints.add(null);
  }
  for (int i = 0; i < maxPoints; i++) {
    altDataPoints.add(null);
  }
  
  
}

void serialEvent(Serial myPort) {
  // Called whenever data is available on the serial port
  data = myPort.readStringUntil('\n'); // Read the data until newline
  if (data != null) {
    // Remove whitespace and split the string into parts
    data = trim(data);
    String[] values = split(data, ',');

    // Parse the values if they match the expected format
    if (values.length == 5) {
      yaw = float(values[0]);
      pitch = float(values[1]);
      roll = float(values[2]);
      //zAccel = float(values[3]);
      alt = float(values[3]);
      vel = float(values[4]);
      
    }
  }
}


void addRotatingObject(float roll, float pitch, float yaw) {
  pushMatrix(); // Save the current transformation state

  // Position the 3D object in the center of the canvas
  translate(540, 190, 100);
  
  float cx = 0; // Example X offset of the object's center
  float cy = -50; // Example Y offset
  float cz = 0; // Example Z offset
  
  translate(-cx, -cy, -cz);
  
  rotateX(PI);
  
  rotateZ(radians(yaw)); // Roll: Rotate around Z-axis
  rotateX(radians(pitch)); // Pitch: Rotate around X-axis
  rotateY(radians(roll)); // Yaw: Rotate around Y-axis
  
  translate(cx, cy, cz);
  
  // Render the 3D object
  shape(obj);

  popMatrix(); // Restore the previous transformation state
}



void drawGraph(float graphX, float graphY, float graphHeight, float graphWidth, float lineSpacing, ArrayList<Float> dataPoints, ArrayList<Float> verticalLines, float lowerBound, float upperBound) {
  
  // Draw a rectangle for the graph area
  
  //stroke(255);
  //noFill();
  //rect(graphX, graphY, graphWidth, graphHeight);
  
  
  stroke(103); // graph lines
  strokeWeight(1);
  line(graphX, graphY + graphHeight / 2, graphX + graphWidth, graphY + graphHeight / 2); // middle line
  line(graphX, graphY + graphHeight / 2 - graphHeight / 4 , graphX + graphWidth, graphY + graphHeight / 2 - graphHeight / 4); // 1st from middle up
  line(graphX, graphY + graphHeight / 2 + graphHeight / 4 , graphX + graphWidth, graphY + graphHeight / 2 + graphHeight / 4); // 1st from middle down 
  line(graphX, graphY, graphX + graphWidth, graphY); // outer line top
  line(graphX, graphY + graphHeight, graphX + graphWidth, graphY + graphHeight); // outer line bottom
  
    // Draw vertical lines and update their positions
  float pointSpacing = (graphWidth - 20) / maxPoints; // Spacing for data points
  stroke(150); // Vertical line color

  for (int i = verticalLines.size() - 1; i >= 0; i--) {
    float x = verticalLines.get(i);

    // Draw the vertical line within the graph area
    if (x >= graphX && x <= graphX + graphWidth) {
      line(x, graphY - 10, x, graphY + graphHeight + 10);
    }

    // Move the line to the left
    verticalLines.set(i, x - pointSpacing);

    // Remove the line if it moves off-screen
    if (x < graphX) {
      verticalLines.remove(i);
    }
  }

  // Add a new vertical line at the right edge if spacing allows
  if (verticalLines.isEmpty() || verticalLines.get(verticalLines.size() - 1) < graphX + graphWidth - lineSpacing) {
    verticalLines.add(graphX + graphWidth);
  }

  // Draw the graph line
  strokeWeight(3);
  stroke(r, g, b);
  noFill();
  beginShape();
  for (int i = 0; i < dataPoints.size(); i++) {
    if (dataPoints.get(i) == null) {
      continue; 
    }
    float x = map(i, 0, maxPoints - 1, graphX, graphX + graphWidth - 20);
    float y = map(dataPoints.get(i), lowerBound, upperBound, graphY + graphHeight, graphY);
    vertex(x, y);
  }
  endShape();
  
}


void draw() {
  background(80); // Clear the canvas
  strokeWeight(3);
  scale(1);
  
  // ANCS logo
  image(img, 415, 8);
  
  lights(); // Add lighting for 3D objects
  addRotatingObject(roll, pitch, yaw); // obj rocket file
    

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
  
  rect(152, 253, 36, 36, 5); // 1
  rect(193, 253, 36, 36, 5); // 2
  rect(234, 253, 36, 36, 5); // 3
  rect(274, 253, 36, 36, 5); // 4
  
  rect(152, 295, 49, 49, 5); // +1
  rect(207, 295, 49, 49, 5); // +2
  rect(262, 295, 49, 49, 5); // +3
  
  rect(152, 349, 49, 49, 5); // -1
  rect(207, 349, 49, 49, 5); // -2
  rect(262, 349, 49, 49, 5); // -3
  
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
  rect(114, 561, 125, 35, 3);
  strokeWeight(3);
  fill(0);
  textSize(20);
  text("Launch", 146, 585, 5);

  // Draw Rocket Display Box
  float rocketX = 343;
  float rocketY = 96;
  float rocketWidth = 389;
  float rocketHeight = 370;
  fill(50);
  stroke(79, 137, 204);
  rect(rocketX, rocketY, rocketWidth, rocketHeight, 20);
  fill(100);
  
  // ==========================================================
  // ----------- Orientation Data Panel Container -------------
  // ==========================================================

  fill(50);
  stroke(99, 156, 95);
  
  float attBoxContainerX = 742;
  float attBoxContainerY = 17;
  float attBoxContainerWidth = 332;
  float attBoxContainerHeight = 449;
 
  rect(attBoxContainerX, attBoxContainerY, attBoxContainerWidth, attBoxContainerHeight, 20);
  fill(99, 156, 95);
  textSize(18);
  text("Des. Angle", 885, 40);
  fill(255);
  text(", Real Angle", 965, 40);
  
  // ============================================================
  // ------------ Accel, Velocity, Altitude boxes ---------------
  // ============================================================

  fill(50);
  stroke(211, 170, 82);
  
  float accelBoxX = 912; float accelBoxY = 481;
  float velBoxX = 742; float velBoxY = 481;
  float altBoxX = 570; float altBoxY = 481 ;
  
  float accelBoxWidth = 162; float accelBoxHeight = 132;
  float velBoxWidth = 162; float velBoxHeight = 132;
  float altBoxWidth = 162; float altBoxHeight = 132;
  
  rect(accelBoxX, accelBoxY, accelBoxWidth, accelBoxHeight, 20);
  rect(velBoxX, velBoxY, velBoxWidth, velBoxHeight, 20);
  rect(altBoxX, altBoxY, altBoxWidth, altBoxHeight, 20);
  
  // ====================================================
  // ------------- Roll, Pitch, Yaw boxes ---------------
  // ====================================================

  fill(37);
  strokeWeight(2);
  stroke(0);
  
  float rollBoxX = 757; float rollBoxY = 50;
  float pitchBoxX = 757; float pitchBoxY = 182;
  float yawBoxX = 757; float yawBoxY = 314;
  
  float rollBoxWidth = 300; float rollBoxHeight = 132;
  float pitchBoxWidth = 300; float pitchBoxHeight = 132;
  float yawBoxWidth = 300; float yawBoxHeight = 132;
  
  rect(rollBoxX, rollBoxY, rollBoxWidth, rollBoxHeight, 10);
  rect(pitchBoxX, pitchBoxY, pitchBoxWidth, pitchBoxHeight, 10);
  rect(yawBoxX, yawBoxY, yawBoxWidth, yawBoxHeight, 10);
  
  
  fill(255);
  textSize(14);
  text("Roll", rollBoxX + 10, rollBoxY + 20);
  text("Pitch", pitchBoxX + 10, pitchBoxY + 20);
  text("Yaw", yawBoxX + 10, yawBoxY + 20);
  text("Accel.", accelBoxX + 10, accelBoxY + 20);
  text("Vel.", velBoxX + 10, velBoxY + 20);
  text("Alt.", altBoxX + 10, altBoxY + 20);
  text(", " + nf(pitch, 1, 2), pitchBoxX + 257, pitchBoxY + 20);
  text(", " + nf(yaw, 1, 2), yawBoxX + 257, yawBoxY + 20);
  text(", " + nf(roll, 1, 2), rollBoxX + 257, rollBoxY + 20);
  text(nf(truezAccel, 1, 2), accelBoxX + 125, accelBoxY + 20);
  text(nf(vel, 1, 2), velBoxX + 125, velBoxY + 20);
  text(nf(alt, 1, 2), altBoxX + 125, altBoxY + 20);
  text("0.00", rollBoxX + 228, rollBoxY + 20);
  text("0.00", pitchBoxX + 228, pitchBoxY + 20);
  text("0.00", yawBoxX + 228, yawBoxY + 20);

  
  // =========================================================
  // --------------- Roll, Pitch, Yaw graphs -----------------
  // =========================================================

  float rollGraphX = rollBoxX + 18; float rollGraphY = rollBoxY + 35; 
  float pitchGraphX = pitchBoxX + 18; float pitchGraphY = pitchBoxY + 35; 
  float yawGraphX = yawBoxX + 18; float yawGraphY = yawBoxY + 35; 
  
  float rollGraphWidth = 264; float rollGraphHeight = 80; 
  float pitchGraphWidth = 264; float pitchGraphHeight = 80; 
  float yawGraphWidth = 264; float yawGraphHeight = 80; 

  float lineSpacing = 55;
  r = 99; g = 156; b = 95;
  
  if (roll > 90) roll = 90;
  else if (roll < -90) roll = -90;

  // Pitch Graph
  newPitchValue = pitch; 
  updateGraph(newPitchValue, pitchDataPoints); 
  drawGraph(pitchGraphX, pitchGraphY, pitchGraphHeight, pitchGraphWidth, lineSpacing, pitchDataPoints, pitchVerticalLines, -90, 90); // Draw the graph
  
  // Yaw Graph
  newYawValue = yaw; 
  updateGraph(newYawValue, yawDataPoints);
  drawGraph(yawGraphX, yawGraphY, yawGraphHeight, yawGraphWidth, lineSpacing, yawDataPoints, yawVerticalLines, -90, 90); // Draw the graph
  
  // Roll Graph
  newRollValue = roll; 
  updateGraph(newRollValue, rollDataPoints); 
  drawGraph(rollGraphX, rollGraphY, rollGraphHeight, rollGraphWidth, lineSpacing, rollDataPoints, rollVerticalLines, -90, 90); // Draw the graph

  print(roll);
  print(" ");
  print(pitch);
  print(" ");
  println(yaw);
  
  // ==================================================================
  // ------------------ Accel, Velocity, Alt graphs -------------------
  // ==================================================================

  lineSpacing = 55;
  // yellow
  r = 211; g = 170; b = 82;
  
  float accelGraphX = accelBoxX + 10; float accelGraphY = accelBoxY + 35; 
  float velGraphX = velBoxX + 10; float velGraphY = velBoxY + 35; 
  float altGraphX = altBoxX + 10; float altGraphY = altBoxY + 35; 
  
  float accelGraphWidth = 140; float accelGraphHeight = 80; 
  float velGraphWidth = 140; float velGraphHeight = 80; 
  float altGraphWidth = 140; float altGraphHeight = 80; 
  
  // Acceleration Graph
  newAccelValue = truezAccel; 
  if (newAccelValue > 15) newAccelValue = 15;
  else if (newVelValue < -15) newVelValue = -15;
  updateGraph(newAccelValue, accelDataPoints); 
  drawGraph(accelGraphX, accelGraphY, accelGraphHeight, accelGraphWidth, lineSpacing, accelDataPoints, accelVerticalLines, -15, 15); // Draw the graph

  // Velocity Graph
  newVelValue = vel; 
  if (newVelValue > 100) newVelValue = 100;
  else if (newVelValue < 0) newVelValue = 1;
  updateGraph(newVelValue, velDataPoints); 
  drawGraph(velGraphX, velGraphY, velGraphHeight, velGraphWidth, lineSpacing, velDataPoints, velVerticalLines, 0, 100); // Draw the graph

  // Altitude Graph
  newAltValue = alt; 
  if (newAltValue > 2000) newAltValue = 2000;
  else if (newAltValue < 0) newAltValue = 1;
  updateGraph(newAltValue, altDataPoints); 
  drawGraph(altGraphX, altGraphY, altGraphHeight, altGraphWidth, lineSpacing, altDataPoints, altVerticalLines, 0, 2000); // Draw the graph
}

void updateGraph(float value, ArrayList<Float> dataPoints) {
  // Add the new value to the end of the list
  dataPoints.add(value);

  // Remove the oldest value if the list exceeds the maximum number of points
  if (dataPoints.size() > maxPoints) {
    dataPoints.remove(0);
  }
}
