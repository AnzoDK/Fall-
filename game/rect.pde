class Rect
{
  int x;
  int y;
  int w;
  int h;
  Rect(int _x,int _y, int _w, int _h)
  {
    x = _x;
    y = _y;
    h = _h;
    w = _w;
  }
  Rect()
  {
    x = 0;
    y = 0;
    h = 0;
    w = 0;
  }
  
}

class Rot
{
  int rotation = 0;  
  Rot()
  {
   rotation = 0; 
  }
  Rot(int newRot)
  {
    rotation = newRot;
  }
}
