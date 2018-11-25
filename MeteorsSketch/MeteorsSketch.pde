import processing.pdf.*;

PShape map;
String csv[];
String mData[][];
PFont f;

void setup() {
  background(21);
  size(1800,900);
  noLoop();
  f = createFont("Avenir-Light", 12);
  map = loadShape("data/WorldMap12.svg");
  csv = loadStrings("data/MeteorStrikes.csv");
  mData = new String[csv.length][6]; //[row][column];
  for(int i=0; i<csv.length; i++) {
     mData[i] = csv[i].split(",");
  }
}

void draw() {
  beginRecord(PDF, "meteroSketch.pdf");
  background(21);
  shape(map, 0, 0, width, height);
  noStroke();
  
  for(int i=0; i<mData.length; i++) {
      float markerColor = map(float(mData[i][1]), 1000, 2010, 210, 0);
      colorMode(HSB, 360, 100, 100, 50);
      //fill(220, 20, 10, 50);
      fill(markerColor, 100, 100, 20);
      textMode(MODEL);
      noStroke();
      float lon = map(float(mData[i][3]), -180, 180, 0, width);
      float lat = map(float(mData[i][4]), -90, 90, 0, height);
      float marker_size = 0.05*sqrt(float(mData[i][2]))/PI;
      ellipse(lon, lat, marker_size, marker_size);
      
      if(i < 10) {
        fill(240);
        textFont(f);
        text(mData[i][0], lon + marker_size + 5, lat + 4);
        noFill();
        stroke(240);
        line(lon + marker_size/2, lat, lon + marker_size, lat);
      }
  }
  save("meteroSketch.png");
  endRecord();
  println("PDF has been saved!");
}
