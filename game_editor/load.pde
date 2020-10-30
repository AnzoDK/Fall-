class TextBox
{
  //these should be selfexplainatory
  String text;
  color bxClr;
  color txtClr;
  boolean enabled;
  Rect mapRect;
  int fontSize;
  boolean locked;
  Map m; 
  Rect rect;
  Tile selectedTile; //holds the tile we are currently working on
  TextBox(Rect r)
  {
    //initting values
    enabled = false;
    rect = r;
    text = "";
    bxClr = color(255, 255, 255);
    txtClr = color(0, 0, 0);
    fontSize = 24;
    mapRect = new Rect();
    m = null;
    locked = false;
    if(DEBUG){println("New TextBox Intilized");}
  }
  void Update()
  {

    //Check if we hit the map
    if (mapCopy != null && m.nullCounts == 0) /*Nullcounts is a special property of the map, that is used to track missing non-loaded tiles in the map, 
    It is used to prevent the map from getting confused when updating a tile at the same time as it is being drawn to the screen and when nullCounts is greater than 0, we just skip a frame to make sure that we don't cause issues
    this doesn't happen much anymore, but was a huge problem earlier, but there is really no reason to remove it, as it still acts like a guard for something that only happens extremely rarely*/
    {
      if (mapCopy.map != null) //Make sure the map even exists
      {
        for (int i = 0; i < mapCopy.map.length; i++) //iterate through the 2D array
        {
          for (int u = 0; u < mapCopy.map[i].length; u++)
          {
            if ((mouseX > mapCopy.map[i][u].rect.x && mouseX < mapCopy.map[i][u].rect.x+mapCopy.map[i][u].rect.w) && (mouseY > mapCopy.map[i][u].rect.y && mouseY < mapCopy.map[i][u].rect.y+mapCopy.map[i][u].rect.h)) //if we hover over a tile
            {
              if (!locked) //Check if we already locked a tile - so we don't select a new tile just by hovering
              {
                selectedTile = new Tile(mapCopy.map[i][u]); //Instead of taking the tile out of the map, we just make a copy to not confuse the map's draw function
                selectedTile.x = i;
                selectedTile.y = u;
              }
              if ((mousePressed && (mouseButton == LEFT))) //if we click on a tile - select it, no matter the state of locked
              {
                if(!e.dmBtn.toggled)//Check if drawmode is disabled
                {
                  locked = true;
                  selectedTile = new Tile(mapCopy.map[i][u]); //Instead of taking the tile out of the map, we just make a copy to not confuse the map's draw function
                  selectedTile.x = i;
                  selectedTile.y = u;
                }
                else
                {
                  //Drawmode
                  selectedTile = new Tile(mapCopy.map[i][u]);
                  mapCopy.map[i][u] = new Tile(selectedTile.rect,(byte)e.drawModeTile,(byte)0x0); //Setting rotation to 0x0 because otherwise it would inherit the sprite ID as a rotation byte...
                }
                
              }
            }
          }
        }
      }
    }
    
    if ((mouseX > rect.x && mouseX < rect.x+rect.w) && (mouseY > rect.y && mouseY < rect.y+rect.h))//If we are hovering over the textbox for file name
    {
      if (mousePressed && (mouseButton == LEFT))//If we click it
      {
        enabled = true; //enabled means that we read the keyboard for this box
      }
    } else if (mousePressed && (mouseButton == LEFT)) //if we click anywhere else
    {
      enabled = false;//stop reading the keyboard
    }
    if (enabled && (globalKey != -1) && (typeRead)) // If we are supposed to read the keyboard and there is a key to read and if we are allowed to
    {
      if (globalKey == BACKSPACE && text.length() >= 1) //Delete if we press backspace
      {  
        text = text.substring(0, text.length()-1);
      } 
      else if (globalKey == ENTER)//if we press enter
      {
        m = new Map(); //Load a new map
        m.defaultRect = mapRect;
        if (m.TestLoadMap(text)) //If the file exists
        {
          m.map = m.LoadMap(text);
          mapCopy = m;
        } 
        else //if the file does not exist - DONT CRASH
        {
          if(DEBUG){println("Map could not be loaded - File may not exist - Creating new file");}
          // create a new 0'red file with the default size
          byte[] zeroByteArr = new byte[20*20*2+4];//default size of 20*20 tiles, and due to the map needing 2 bytes per tile and us needing 4 bytes for size data, we create a zero array with the size of (20*20)*2+4
          //we actually have to modify the 2 and 4'th bytes to tell the load program about the size of the map
          zeroByteArr[1] = 0x14; //the hack I talked about ealier, and it works because we know the size always will be 20*20
          zeroByteArr[3] = 0x14;
          saveBytes(text,zeroByteArr);
          if(DEBUG){println("Added new mapFile - try reloading the file!");} //Auto reloading wound't work
        }
        enabled = false;//stop reading the keyboard
      } 
      else
      {
        text += key; //Add key as a char to the string
      }
    }
  }
  void Draw()
  {
    push();
    fill(bxClr);
    rect(rect.x, rect.y, rect.w, rect.h);
    fill(txtClr);
    textSize(fontSize);
    text(text, rect.x, rect.y+rect.h/2+/*This would be the height of the text - here im guessing*/10);
    line(rect.x+textWidth(text), rect.y+15, rect.x+textWidth(text), rect.y+rect.h-15);
    pop();
  }
}
