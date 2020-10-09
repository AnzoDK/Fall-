

public PImage GetImg(String s)
{
  return loadImage(s);
}
class Point2D
{
  float x;
  float y;
  Point2D(float _x, float _y)
  {
    x = _x;
    y = _y;
  }
}

public float ToRadians(int degrees)
{
  return (degrees*PI)/180;
}
public float ToRadians(float degrees)
{
  return (degrees*PI)/180;
}
