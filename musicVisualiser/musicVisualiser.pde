//Here I am declaring the variables for the 'bars' or rectangles. I declare the variable
//for the volume and declare the font. Finally, I import the necessary minim components
//in order to use sound.

float x, y, w, h;
float volume;
PFont digital;
import ddf.minim.*;
Minim minim;
AudioPlayer modjo;

//I set up my document with size and background colour and set the colour mode to HSB so
//I can more easily change the hue. I also load in the song I am using for the visualiser
//and set it to play.

void setup() {
  size(640, 480);
  background(0);
  colorMode(HSB);
  digital = loadFont("DS-Digital-Bold-48.vlw");
  minim = new Minim(this);
  modjo = minim.loadFile("Modjo.mp3", 1024);
  modjo.play();
  frameRate(40);
  smooth();
}

//In the first part of the draw function I set up my text and position it where I want it to be.
//I also create some lines to act as the underlines for the left and right channel titles.
void draw() {
  background(0);
  fill(frameCount % 400, 255, 255);
  textFont(digital);
  textSize(40);
  text("Left Channel", 40, 50);
  stroke(frameCount % 400, 255, 255);
  strokeWeight(3);
  line(40, 53, 269, 53);
  text("Right Channel", width/2 + 40, 50);
  stroke(frameCount % 400, 255, 255);
  strokeWeight(3);
  line(width/2 + 40, 53, 600, 53);
  textSize(20);
  text("Instructions:", 10, 90);
  stroke(frameCount % 400, 255, 255);
  strokeWeight(2);
  line(10, 93, 127, 93);
  textSize(11);
  text("- Press enter to pause and play the track.", 10, 110);
  text("- Move the mouse across the screen to change the volume.", 10, 125);
  
//Here I am setting the volume variable and using the map function to change the values -50 to 0 to be
//0 to 100 so it is more intuitive for the user.

  float dB = map(mouseX, 0, width, 0, 100);
  text("- Volume: " + dB + ".", 10, 140);
  modjo.setGain(map(mouseX, 0, width, -50, 0));
  int multi = 0;
  int multi1= 0;
  
//This is the first for loop that is responsible for creating the bars on the left hand side (left channel). 
//I call the variables I initialised at the beggining for the size of the rectangle so everything
//is the same apart from the height, which is attributed to the left.get() function.

  for (int i = 0; i < width/2; i += 20) {
    multi += 10;
    if (multi > 160) {
      multi -= 10;
    } else if (multi <= 0) {
      multi += 10;
    }
    float y = 480;
    float w = 20;
    float h = -abs(modjo.left.get(multi)) * 500;
    stroke(0);
    rect(i, y, w, h);
  }
  
//This is the second for loop that is reposible for the bars on the right hand side (right channel). Everything
//is the same apart from the fact that the height of these bars is attributed to right.get().

  for (int j = width/2; j < width; j += 20) {
    if (multi1 > 160) {
      multi1 -= 10;
    } else if (multi1 <= 0) {
      multi1 += 10;
    }
    float y = 480;
    float w = 20;
    float h = -abs(modjo.right.get(multi1 += 10)) * 500;
    stroke(0);
    rect(j, y, w, h);
  }
  
//Here I am just creating a simple line in order to neatly seperate the two channels.

  stroke(255);
  strokeWeight(0.75);
  line(width/2, 0, width/2, height);
}

//Finally, I add a way for the user to pause and play the track by using an if statement to establish whether
//or not the song is playing. This is so it can be paused with the push of a button, in this case the button
//is the return or enter ket.

void keyPressed() {
  if (!modjo.isPlaying() && key == ENTER)
    modjo.play();
  else if (key == ENTER)
    modjo.pause();
}