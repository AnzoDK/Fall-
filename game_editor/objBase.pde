class ObjBase
{
  Rect rect;
  Rot rotation;
  boolean enabled;
  ObjBase(Rect r, Rot rot)
  {
    rect = r;
    rotation = rot;
    enabled = true;
  }
   ObjBase(Rect r)
  {
    rect = r;
    rotation = new Rot();
    enabled = true;
  }
   void Update()
   {
     
   }
   void Draw()
   {
     
   }
  
  
  
}
