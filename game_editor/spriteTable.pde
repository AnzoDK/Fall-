public PImage GetImg(String path)
{
 return loadImage(path); 
}



class spriteTable
{
  int spritesInUse = 7;
  PImage SpriteLookUp(byte b)
  {
    //This is a table we use to find the sprite we need to based on a byte
    switch(b)
    {
        case 0x0:
        //
        return GetImg("rpg-pack/tiles/generic-rpg-Slice.png");
      case 0x1:
        //default water tile - not pretty and should be replaced
        return GetImg("rpg-pack/tiles/generic-rpg-tile-waterfall01.png");
      
      case 0x2:
        //Water with land side variant 1
        return GetImg("rpg-pack/tiles/generic-rpg-tile65.png");
        
      case 0x3:
        //Water with land side variant 2       
        return GetImg("rpg-pack/tiles/generic-rpg-tile66.png");

      case 0x4:
        //Water with land side variant 2       
        return GetImg("rpg-pack/tiles/generic-rpg-tile67.png");
      case 0x5:
        return GetImg("rpg-pack/tiles/generic-rpg-tile69.png");
      
      case 0x6:
        return GetImg("rpg-pack/tiles/generic-rpg-tile-water.png");

      default:
        return GetImg("rpg-pack/tiles/generic-rpg-Slice.png");
    }
  }
  //A table for looking up what rotation should be applied to the tile in incriments of 90 degrees
  int RotationTable(byte rotationByte)
  {
    switch(rotationByte)
    {
      case 0x0:
        return 0;
      case 0x1:
        return 90;
      case 0x2:
        return 180;
      case 0x3:
        return 270;
      case 0x4:
        return 360;
        
        //just in case we try to parse a bad byte
       default:
         return 0;
    }
  }
   int GetSpriteCount()
   {
     return spritesInUse;
   }
}
