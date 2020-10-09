class Tile extends ObjBase
{
   PImage sprite;
   byte rotationByte;
   byte spriteByte;
   int x;
   int y;
   Rect origRect;
   Tile(Rect r, Rot rot,PImage _sprite)
   {
     super(r,rot);
     sprite = _sprite;
     origRect = r;
     
   }
   Tile(Rect r, Rot rot, String spritePath)
   {
     super(r,rot);
     sprite = loadImage(spritePath);
     origRect = r;
   }
   Tile(Rect r, Rot rot, byte b)
   {
     super(r,rot);
     sprite = new spriteTable().SpriteLookUp(b);
     origRect = rect;
   }
   Tile(Rect r, byte rotByte, byte b)
   {
     super(r,new Rot(new spriteTable().RotationTable(rotByte)));
     rotationByte = rotByte;
     spriteByte = b;
     sprite = new spriteTable().SpriteLookUp(b);
     origRect = rect;
   }
   Tile(Tile t)
   {
     super(t.rect,t.rotation);
     sprite = t.sprite;
     spriteByte = t.spriteByte;
     rotationByte = t.rotationByte;
     origRect = t.origRect;
   }
   
    void Update()
    {
      
    }
   
   void Draw()
   {
      push();
      imageMode(CENTER);
      translate(rect.x+(rect.w/2),rect.y+(rect.h/2));
      rotate(ToRadians(rotation.rotation));
      //image(map[i][u].sprite, map[i][u].rect.x, map[i][u].rect.y,map[i][u].rect.w,map[i][u].rect.h);
      image(sprite, 0, 0,rect.w,rect.h);
      pop();
   }
  
  
}
