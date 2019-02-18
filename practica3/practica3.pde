Estrella estrella;
Nave nave;
PImage fondo;

final int FLECHA_ABAJO = 40;
final int FLECHA_ARRIBA = 38;
String texturaPlaneta1 = "img/texturaPlaneta.jpg";
String texturaPlaneta2 = "img/texturaPlaneta2.jpg";
String texturaPlaneta3 = "img/texturaPlaneta3.jpg";
String texturaPlaneta4 = "img/texturaPlaneta4.jpg";
String texturaPlaneta5 = "img/texturaPlaneta5.jpg";
String texturaSatelite = "img/texturaLuna.jpg";
void setup(){
	size(1024,768, P3D);
  imageMode (CENTER) ;
//Carga de l a imagen
  fondo=loadImage ("img/fondo2.jpg" );
  estrella = new Estrella(width/2, height/2, 0, 100);
  nave = new Nave(-250,0, 0, 20);
}

void pintaControles(){
  textSize(12);
  fill(255);
  text("Mouse para moverte en el eje X e Y", 40, 50);
  text("Flecha Arriba / Flecha Abajo para moverte en el eje Z", 40, 80);
}
void draw(){
  background(fondo) ;
  pintaControles();
	estrella.display();
  estrella.update();
  nave.display();
}
void mouseMoved(){
  nave.x = mouseX - width/2 + 20;
  nave.y = mouseY - height/2;
}
void keyPressed() {
    if(keyCode == FLECHA_ARRIBA){ nave.z +=10; } 
    if(keyCode == FLECHA_ABAJO ){ nave.z -=10; }
}

class Estrella{
    PShape sol;
    PImage textura; 
    float ang;
    float velocidadRot;
    int radio;
    int x;
    int y;
    int z;
    ArrayList<Planeta> planetas;
    
    Estrella(int xTemp, int yTemp, int zTemp, int radi){
      planetas = new ArrayList<Planeta>();
      x = xTemp;
      y = yTemp;
      z = zTemp;
      radio = radi;
      ang = 0;
      velocidadRot = 0.25;
      textura = loadImage("img/texturaEstrella.jpg");
      sol = createShape(SPHERE, radio); 
      sol.setTexture(textura);
      sol.setStroke(0);
      aniadePlanetas();
    }
    void display(){
      translate(x, y, z);
      rotateX(radians(-45));
      pintarEstrella();
      pintarPlanetas();
    }
    void update(){
      ang += velocidadRot;
      if(ang >= 360){ ang = 0; }
    }
    void aniadePlanetas(){
      planetas.add(new Planeta(x*0.5,-y*0.5,0,radio /(int)random(5, 10),texturaPlaneta1));
      planetas.add(new Planeta(x*0.5,y,0,radio /(int)random(5, 10),texturaPlaneta2));
      planetas.add(new Planeta(x*0.75,y*0.75,0,radio /(int)random(5, 10),texturaPlaneta3));
      planetas.add(new Planeta(x*0.25,y*0.75,0,radio /(int)random(5, 10),texturaPlaneta4));
      planetas.add(new Planeta(-x*0.45,-y*0.75,0,radio /(int)random(5, 10),texturaPlaneta5));
    }
    void pintarEstrella(){
      pushMatrix();
      rotateY(radians(ang));
      shape(sol);
      popMatrix();
    }
    void pintarPlanetas(){
      for (Planeta planeta : planetas) {
        pushMatrix();
        planeta.display();
        popMatrix();
        planeta.update();
      }
    }
}

class Planeta{
    PShape planeta;
    PImage textura;
    float ang;
    float velocidadRot;
    int radio;
    float x;
    float y;
    float z;
    Satelite luna;
    boolean lunaBool;
    Planeta(float xTemp, float yTemp, float zTemp, int radi, String path){
      x = xTemp;
      y = yTemp;
      z = zTemp;
      radio = radi;
      ang = 0;
      velocidadRot = 0.5;
      int radioLuna = radio / (int) random(5, 10);
      luna = new Satelite(x*0.35,y*0.25,0,radioLuna, texturaSatelite);
      lunaBool = random(1) > .5;
      planeta = createShape(SPHERE, radio);
      textura = loadImage(path);
      planeta.setTexture(textura);
      planeta.setStroke(0);
      //lunaBool = true;
    }
    
    void display(){
      rotateY(radians(ang));
      translate(x, y, z);
      shape(planeta);
     if(lunaBool){ pintaLuna(); }
    }
    void update(){
      ang += velocidadRot;
      if(ang >= 360){ ang = 0; }
    }
    void pintaLuna(){
        pushMatrix();
        luna.display();
        popMatrix();
        luna.update();
    }
}

class Satelite{
    PShape luna;
    PImage textura;
    float ang;
    float velocidadRot;
    int radio;
    float x;
    float y;
    float z;
    Satelite(float xTemp, float yTemp, float zTemp, int radi, String path){
      x = xTemp;
      y = yTemp;
      z = zTemp;
      radio = radi;
      ang = 0;
      velocidadRot = 0.5;
      luna = createShape(SPHERE, radio);
      textura = loadImage(path);
      luna.setTexture(textura);
      luna.setStroke(0);
    }
    void display(){
      rotar();
      translate(x, y, z);
      shape(luna);
    }
    void rotar(){
       rotateZ(radians(ang));
    }
    void update(){
      ang += velocidadRot;
      if(ang >= 360){ ang = 0; }
    }
}
class Nave{
  float x;
  float y;
  float z;
  float radio;
      Nave(float xTemp, float yTemp, float zTemp, int radi){
      x = xTemp;
      y = yTemp;
      z = zTemp;
      radio = radi;
    }
    void display(){
      translate(x, y, z);
      fill(0,200,100);
      box(radio);
    }
}
