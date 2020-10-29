int globalKey;

int clicks;

boolean DEBUG = true;

int buttonClickDelay = 15; //The amount of frames we wait before registering a new click

boolean typeRead;
boolean mouseDown;
Editor e;
ScreenManager sm;
TileMap tm;
SelTileMap selTm;

void setup()
{
  size(1000,800);
  e = new Editor();
  tm = new TileMap();
  selTm = new SelTileMap();
  sm = new ScreenManager();
  sm.Add(e);
  sm.Add(tm);
  sm.Add(selTm);
  sm.SetActiveObj(0);
  //frameRate(5);
}
void draw()
{
  //background(0);
  for(int i = 0; i < sm.objects.size();i++)
  {
    sm.GetObjAt(i).Update();
    sm.GetObjAt(i).Draw();
    
  }
  typeRead = false;
  mouseDown = false;

}
void keyTyped()
{
  globalKey = key;
  typeRead = true;
}
void keyReleased()
{
  globalKey = -1;
}
void keyPressed()
{
  if(key == ENTER)
  {
    globalKey = key;
  }
}
void mouseClicked()
{
 mouseDown = true;
 if(clicks == 0)
 {
   clicks++;
 }
 
}
 void mousePressed()
 {

 }
 //this must be the worst idea ever
 boolean useClick()
 {
   if(clicks <= 0)
   {
     return false;
   }
   else
   {
     clicks--;//Consumes a click
     return true;
   }
 }
