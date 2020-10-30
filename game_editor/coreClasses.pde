class Rect //A small class used for storing x,y,w,h of any object
{
  float x,y,w,h;
  Rect(float _x, float _y, float _w, float _h)
  {
    x = _x;
    y  = _y;
    w = _w;
    h = _h;
  }
  Rect()
  {
    x = 0;
    y = 0;
    w = 0;
    h = 0;
  }
  Rect Add(Rect r2)
  {
    return new Rect(x+r2.x,y+r2.y,w+r2.w,h+r2.h);
  }
  Rect Subtract(Rect r2)
  {
    return new Rect(x-r2.x,y-r2.y,w-r2.w,h-r2.h);
  }
  void PrintRect()
  {
    println("Rect: " + x + ", " + y + ", " + w + ", " + h);
  }
  String RectString()
  {
    String s = "Rect: " + x + ", " + y + ", " + w + ", " + h;
    return s;
  }
  
}
class Rot // just stores rotation in radians
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
