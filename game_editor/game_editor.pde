int globalKey;
boolean typeRead;
Editor e;

void setup()
{
  size(1000,1000);
  e = new Editor();
  //frameRate(5);
}
void draw()
{
  //background(0);
  e.Update();
  e.Draw();
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
