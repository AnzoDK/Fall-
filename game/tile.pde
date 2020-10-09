class Tile extends ObjBase
{
   PImage sprite;
   byte rotationByte;
   byte spriteByte;
   Tile(Rect r, Rot rot,PImage _sprite)
   {
     super(r,rot);
     sprite = _sprite;
     
   }
   Tile(Rect r, Rot rot, String spritePath)
   {
     super(r,rot);
     sprite = loadImage(spritePath);
   }
   Tile(Rect r, Rot rot, byte b)
   {
     super(r,rot);
     sprite = new spriteTable().SpriteLookUp(b);
   }
   Tile(Rect r, byte rotByte, byte b)
   {
     super(r,new Rot(new spriteTable().RotationTable(rotByte)));
     rotationByte = rotByte;
     spriteByte = b;
     sprite = new spriteTable().SpriteLookUp(b);
   }
   
    void Update()
    {
      
    }
   
   void Draw()
   {
     
   }
  
  
}
