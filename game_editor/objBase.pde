class ObjBase
{
  Rect rect;
  Rot rotation;
  ObjBase(Rect r, Rot rot)
  {
    rect = r;
    rotation = rot;
  }
   ObjBase(Rect r)
  {
    rect = r;
    rotation = new Rot();
  }
   void Update()
   {
     
   }
   void Draw()
   {
     
   }
  
  
  
}
