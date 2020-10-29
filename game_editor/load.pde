class TextBox
{
  String text;
  color bxClr;
  color txtClr;
  boolean enabled;
  Rect mapRect;
  int fontSize;
  boolean locked;
  Map m;
  Rect rect;
  Tile selectedTile;
  TextBox(Rect r)
  {
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
    if (mapCopy != null && m.nullCounts == 0)
    {
      if (mapCopy.map != null)
      {
        for (int i = 0; i < mapCopy.map.length; i++)
        {
          for (int u = 0; u < mapCopy.map[i].length; u++)
          {
            if ((mouseX > mapCopy.map[i][u].rect.x && mouseX < mapCopy.map[i][u].rect.x+mapCopy.map[i][u].rect.w) && (mouseY > mapCopy.map[i][u].rect.y && mouseY < mapCopy.map[i][u].rect.y+mapCopy.map[i][u].rect.h))
            {
              if (!locked)
              {
                selectedTile = new Tile(mapCopy.map[i][u]);
                selectedTile.x = i;
                selectedTile.y = u;
              }
              if ((mousePressed && (mouseButton == LEFT)))
              {
                if(!e.dmBtn.toggled)
                {
                  locked = true;
                  selectedTile = new Tile(mapCopy.map[i][u]);
                  selectedTile.x = i;
                  selectedTile.y = u;
                }
                else
                {
                  //mapCopy.map[i][u] = new Tile(mapCopy.map[i][u]);
                  selectedTile = new Tile(mapCopy.map[i][u]);
                  mapCopy.map[i][u] = new Tile(selectedTile.rect,selectedTile.rotationByte,(byte)e.drawModeTile);
                }
                
              }
            }
          }
        }
      }
    }

    //println("mouse is at: " + mouseX + ", " + mouseY + "\nShould be: X(min,max) " + rect.x + ", " + rect.x+rect.w + " Y(min,max) " + rect.y + ", " + rect.y+rect.h);
    if ((mouseX > rect.x && mouseX < rect.x+rect.w) && (mouseY > rect.y && mouseY < rect.y+rect.h))
    {
      //println("mouse correct");
      if (mousePressed && (mouseButton == LEFT))
      {
        //println("Enabling");
        enabled = true;
      }
    } else if (mousePressed && (mouseButton == LEFT))
    {
      enabled = false;
    }
    if (enabled && (globalKey != -1) && (typeRead))
    {
      if (globalKey == BACKSPACE && text.length() >= 1)
      {  
        text = text.substring(0, text.length()-1);
      } 
      else if (globalKey == ENTER)
      {
        m = new Map();
        m.defaultRect = mapRect;
        if (m.TestLoadMap(text))
        {
          m.map = m.LoadMap(text);
          mapCopy = m;
        } 
        else
        {
          if(DEBUG){println("Map could not be loaded - File may not exist");}
        }
        enabled = false;
      } 
      else
      {
        text += key;
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
    //println("text is: " + text);
    //println("status: " + enabled);
    pop();
  }
}
