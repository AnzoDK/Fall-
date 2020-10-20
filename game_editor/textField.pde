class TextRotField extends ObjBase
{
  String fieldText;
  String ghostText;
  color bxClr;
  color txtClr;
  int fontSize;
  boolean enabled;
  Tile workingTile;
  TextRotField(Rect r)
  {
    super(r);
    fieldText = "";
    txtClr = color(0,0,0);
    bxClr = color(255,255,255);
    fontSize = 24;
    ghostText = "Rotation Byte";
  }
  void Update()
  {
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
      if (globalKey == BACKSPACE && fieldText.length() >= 1)
      {  
        fieldText = fieldText.substring(0, fieldText.length()-1);
      } 
      else if (globalKey == ENTER && (typeRead))
      {
        enabled = false;
        if(workingTile != null)
        {
          workingTile.rotationByte = ToByte(fieldText);
          workingTile.rotation = new Rot(new spriteTable().RotationTable(workingTile.rotationByte));
          println("Updating Tile: " + workingTile.x + ", " + workingTile.y);
          println("Resetting Rect to pre-edit tile rect...");
          workingTile.rect = workingTile.origRect;
          println("Updating array");
          mapCopy.map[workingTile.x][workingTile.y] = new Tile(workingTile);
          println("Tile: " + workingTile.x + ", " + workingTile.y + " exists - RotationByte on ArrayTile: " + mapCopy.map[workingTile.x][workingTile.y].rotationByte); //<>// //<>// //<>//
          
          
          
        }
      } 
      else
      {
        fieldText += key;
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
    if(fieldText.length() == 0 && !enabled)
    {
      fill(18,18,18);
      text(ghostText, rect.x, rect.y+rect.h/2+/*This would be the height of the text - here im guessing*/10);
    }
    else
    {
      text(fieldText, rect.x, rect.y+rect.h/2+/*This would be the height of the text - here im guessing*/10);
    }
    line(rect.x+textWidth(fieldText), rect.y+15, rect.x+textWidth(fieldText), rect.y+rect.h-15);
    //println("text is: " + text);
    //println("status: " + enabled);
    pop();
  }
}
class TextSpriteField extends ObjBase
{
  String fieldText;
  boolean enabled;
  color bxClr;
  color txtClr;
  int fontSize;
  Tile workingTile;
  TextSpriteField(Rect r)
  {
    super(r);
    fieldText = "";
    txtClr = color(0,0,0);
    bxClr = color(255,255,255);
    fontSize = 24;
  }
  void Update()
  {
    if ((mouseX > rect.x && mouseX < rect.x+rect.w) && (mouseY > rect.y && mouseY < rect.y+rect.h))
    {
      //println("mouse correct");
      if (mousePressed && (mouseButton == LEFT))
      {
        //println("Enabling");
        enabled = true;
      }
    } 
    else if (mousePressed && (mouseButton == LEFT))
    {
      enabled = false;
    }
    if (enabled && (globalKey != -1) && (typeRead))
    {
      if (globalKey == BACKSPACE && fieldText.length() >= 1)
      {  
        fieldText = fieldText.substring(0, fieldText.length()-1);
      } 
      else if (globalKey == ENTER && (typeRead))
      {
        enabled = false;
        if(workingTile != null)
        {
          workingTile.spriteByte = ToByte(fieldText);
          workingTile.sprite = new spriteTable().SpriteLookUp(workingTile.spriteByte);
          //mapCopy.Draw();
          println("Updating Tile: " + workingTile.x + ", " + workingTile.y);
          println("Resetting Rect to pre-edit tile rect...");
          workingTile.rect = workingTile.origRect;
          println("Updating array");
          mapCopy.map[workingTile.x][workingTile.y] = new Tile(workingTile);
          println("Tile: " + workingTile.x + ", " + workingTile.y + " exists - SpriteByte on ArrayTile: " + mapCopy.map[workingTile.x][workingTile.y].spriteByte);
        }
      } 
      else
      {
        fieldText += key;
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
    text(fieldText, rect.x, rect.y+rect.h/2+/*This would be the height of the text - here im guessing*/10);
    line(rect.x+textWidth(fieldText), rect.y+15, rect.x+textWidth(fieldText), rect.y+rect.h-15);
    //println("text is: " + text);
    //println("status: " + enabled);
    pop();
  }
}
