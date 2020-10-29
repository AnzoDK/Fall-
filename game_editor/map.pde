//Guess im doing a 2D array...
class Map
{
  Tile[][] map;
  int w;
  int h;
  int nullCounts;
  Rect defaultRect;
  

  Map()
  {
    defaultRect = new Rect();
    map = null;
    nullCounts = 0;
  }
  
  boolean TestLoadMap(String mapPath)
  {
    IOController ioc = new IOController();
    if(ioc.ReadBytes(mapPath,0) == null)
    {
      return false;
    }
    else
    {
      return true;
    }
  }
  
  Tile[][] LoadMap(String mapPath)
  {
    IOController ioc = new IOController();
    
    byte[] mapBytes = ioc.ReadBytes(mapPath,0);
    if(mapBytes == null)
    {
      return null;
    }
    w = (mapBytes[0] << 8) | mapBytes[1];
    h = (mapBytes[2] << 8) | mapBytes[3];
    
    if(DEBUG){println("Creating map of size: " + w + ", " + h);}
    
    
    //In here you'll see a few values multiplied by 2. This is because the way that the map is layed out.
    //The map is build up like this
    /*
    First we startup with 2 x 2 bytes. Totalling 32 bits.
    The first 16 bits(2 bytes) describe the width of the map as an unsigned int.
    The next 16 bits(2 bytes) describe the height of the map as an unsigned int.
    
    But after that comes the map data itself. This data is build up of blocks of 2 bytes.
    The first 8 bits (1 byte) is mostly wasted, as we only require 2 of them. This byte is used to describe
    an unsigned int between 0 and 4. Should it be set to any other value it will fallback to 0x0.
    This byte is used to tell the rotation of a sprite in intervals of 90 degrees.
    The next byte (8 bits) contain an unsigned int between 0 and the amount of sprites in the game (max 0xFF or 256)
    If this value is higher than the current amount of sprites, it will default to 0x0.
    This byte is compared to a lookup table of all sprites in the game, and the corresponding sprite will
    be loaded.
    
    This means that every tile requires a 4 byte section of memory - This is utterly stupid, and wastes soooooooo much space (and not just on the disk)
    A better way to solve it would be to assign the upper 3 bits of a byte for rotation and the lower 5 for sprite data, but that would make the lookup time
    many times longer.
    
    */
    int mapDataOffset = 4;
    Tile[][] tiles = new Tile[h][];
    for(int cH = 0; cH < h; cH++)
    {
      tiles[cH] = new Tile[w];
      int tileI = 0;
      for(int i = mapDataOffset; i < w*2+mapDataOffset;i++)
      {
        Rect spawnRect = new Rect();
        spawnRect.x = (tileI)*defaultRect.w;
        spawnRect.y = (cH)*defaultRect.h;
        spawnRect.w = defaultRect.w;
        spawnRect.h = defaultRect.h;
        //The second argument passed here is the rotation byte, whos use is explained in the tile.pde file
        tiles[cH][tileI] = new Tile(spawnRect,mapBytes[i+(cH*h)+1],mapBytes[i+(cH*h)]);
        i++;
        tileI++;
        
      }
    }
    return tiles;
  }
  void Draw()
  {
    nullCounts = 0;
   if(map != null){
   for(int i = 0; i < map.length; i++)
   {
    for(int u = 0; u < map[i].length; u++)
    {
      //map[i][u].Draw();
      //println("Drawing tile: " + i + ", " + u + " with rect: " + map[i][u].rect.RectString());
      push();
      imageMode(CENTER);
      if(map[i][u].rect != null)
      {
        translate(map[i][u].rect.x+(map[i][u].rect.w/2),map[i][u].rect.y+(map[i][u].rect.h/2));
        rotate(ToRadians(map[i][u].rotation.rotation));
        //image(map[i][u].sprite, map[i][u].rect.x, map[i][u].rect.y,map[i][u].rect.w,map[i][u].rect.h);
        image(map[i][u].sprite, 0, 0,map[i][u].rect.w,map[i][u].rect.h);
      }
      else
      {
        nullCounts++;
      }
      pop();
      
    }
   }
  }
  }
  
}
