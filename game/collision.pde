class Collider2D
{
  
  boolean isCollided()
  {
   return false; 
  }
}
class BoxCollider2D extends Collider2D
{
  Rect collRect;
  BoxCollider2D(Rect r)
  {
    collRect = r;
  }
  boolean isCollided()
  {
    return true;
  }
  
}
