class Tile extends ObjBase
{
   PImage sprite; //tilesprite
   byte rotationByte; //the bytes for finding sprites and rotation
   byte spriteByte;
   int x; //coordinates
   int y;
   Rect origRect; //the original rect that was used to create the tile - in case something goes wrong
   Tile(Rect r, Rot rot,PImage _sprite)
   {
     super(r,rot);
     sprite = _sprite;
     origRect = r;
     
   }
   Tile(Rect r, Rot rot, String spritePath)
   {
     super(r,rot);
     sprite = loadImage(spritePath); // load the image/sprite
     origRect = r;
   }
   Tile(Rect r, Rot rot, byte b)
   {
     super(r,rot);
     sprite = new spriteTable().SpriteLookUp(b); //Find the sprite in the table
     origRect = rect;
   }
   Tile(Rect r, byte b, byte rotByte)
   {
     super(r,new Rot(new spriteTable().RotationTable(rotByte)));
     rotationByte = rotByte;
     spriteByte = b;
     sprite = new spriteTable().SpriteLookUp(b); //Find the sprite in the table
     origRect = rect;
   }
   Tile(Tile t)
   {
     //Copy another tiles properties
     super(t.rect,t.rotation);
     sprite = t.sprite;
     spriteByte = t.spriteByte;
     rotationByte = t.rotationByte;
     origRect = t.origRect;
   }
   
    void Update()//Wasn't really needed for this project, but a game using the same tile code would properbly use it
    {
      
    }
   
   void Draw()
   {
      push();
      imageMode(CENTER);
      translate(rect.x+(rect.w/2),rect.y+(rect.h/2));
      rotate(ToRadians(rotation.rotation));
      image(sprite, 0, 0,rect.w,rect.h);
      pop();
   }
  
  
}
