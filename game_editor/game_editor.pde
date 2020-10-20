int globalKey;
boolean typeRead;
Editor e;
ScreenManager sm;
TileMap tm;

void setup()
{
  size(1000,1000);
  e = new Editor();
  tm = new TileMap();
  sm = new ScreenManager();
  sm.Add(e);
  sm.Add(tm);
  sm.GetObjAt(0).enabled = false;
  sm.GetObjAt(1).enabled = true;
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
