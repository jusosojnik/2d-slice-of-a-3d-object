import peasy.*;
import java.util.*;
import java.lang.Math;

PeasyCam cam;

int size = 20;
int wSize = 600;
int scl = 100;

void setup() {
  size(600, 600);
  //frameRate(10);
}

PVector[] points = {new PVector(-1, -1, 1),
                    new PVector(1, -1, 1),
                    new PVector(1, 1, 1),
                    new PVector(-1, 1, 1),
                    new PVector(-1, -1, -1),
                    new PVector(1, -1, -1),
                    new PVector(1, 1, -1),
                    new PVector(-1, 1, -1)
                    };
int[][] faces = {
  {0, 1, 2, 3},
  {4, 5, 6, 7},
  {3, 2, 6, 7},
  {0, 1, 5, 4},
  {0, 3, 7, 4},
  {1, 2, 6, 5},
};

int[][] conections = {{0, 1},
                        {1, 2},
                        {2, 3},
                        {3, 0},
                        {4, 5},
                        {5, 6},
                        {6, 7},
                        {7, 4},
                        {0, 4},
                        {1, 5},
                        {2, 6},
                        {3, 7}
                        };

List<PVector> shapePoints = new ArrayList<>();

void rotateeX(float angle, PVector[] points) {
  float[][] rotationX = {
    {1, 0, 0},
    {0, cos(angle), -sin(angle)},
    {0, sin(angle), cos(angle)}
  };
  for (int i = 0; i < 8; i++) {
    float oldPoint = points[i].y;
     points[i].y = points[i].y * cos(angle) - points[i].z * sin(angle);
     points[i].z = oldPoint * sin(angle) + points[i].z * cos(angle);
  }
}

void rotateeY(float angle, PVector[] points) {
  float[][] rotationY = {
    {cos(angle), 0, sin(angle)},
    {0, 1, 0},
    {-sin(angle), 0, cos(angle)}
  };
  for (int i = 0; i < 8; i++) {
    float oldPoint = points[i].x;
     points[i].x = points[i].x * cos(angle) + points[i].z * sin(angle);
     points[i].z = -oldPoint * sin(angle) + points[i].z * cos(angle);
  }
}

void rotateeZ(float angle, PVector[] points) {
  float[][] rotationZ = {
    {cos(angle), -sin(angle), 0},
    {sin(angle), cos(angle), 0},
    {0, 0, 1}
  };
  for (int i = 0; i < 8; i++) {
    float oldPoint = points[i].x;
     points[i].x = points[i].x * cos(angle) - points[i].y * sin(angle);
     points[i].y = oldPoint * sin(angle) + points[i].y * cos(angle);
  }
}

void draw() {
  rotateeX(PI/180, points);
  //rotateeY(PI/180, points);
  rotateeZ(PI/180, points);
  background(0);
  stroke(255);
  translate(width/2, height/2);
  //translate(-size/2, - size/2);
  //line(0,-height/2,0,height/2);
  //line(-width/2,0,width/2, 0);
  //circle(0,200,size);
  fill(255);
  for (int i = 0; i < 8; i++) {
    if (i == 0) {
      fill(0,255,0);
    } else if (i == 1) {
      fill(0,0,255);
    } else {
      fill(255);
    }
    if (points[i].z >= 0) {
      //circle(points[i].x * scl, points[i].y * scl, size);
    }
  }
  lights();
  fill(255);
  noStroke();
  for (int i = 0; i < 6; i++) {
    beginShape();
    for (int j = 0; j < 4; j++) {
      vertex(points[faces[i][j]].x * scl, points[faces[i][j]].y * scl);
    }
    endShape();
  }
  stroke(0, 255, 0);
  for (int i = 0; i < 12; i ++) {
    //line(points[conections[i][0]].x * scl, points[conections[i][0]].y * scl,
    //     points[conections[i][1]].x * scl, points[conections[i][1]].y * scl);
  }
  //noLoop();
}

void mousePressed() {
  float angle = PI/180;
  rotateeX(angle, points);
  rotateeY(angle, points);
  rotateeZ(angle, points);
  //crox(points, conections);
}
