class Button extends ObjBase
{
  color bgBtnClr;
  color btnTxtClr;
  color btnHoverClr;
  color btnTxtHoverClr;
  String btnTxt;
  int btnTxtFntSize;
  private color inUseClr;
  private color inUseTxtClr;
  Button(Rect r)
  {
    super(r);
    btnTxtFntSize = 30;
    bgBtnClr = 0;
    btnTxtClr = 255;
    btnHoverClr = 255;
    btnTxtHoverClr = 0;
    btnTxt = "New Btn";
    
    
  }
  
  void OnClick()
  {
    
  }
  
  void Hover()
  {
    inUseClr = btnHoverClr;
    inUseTxtClr = btnTxtHoverClr;
  }
  
  void Update()
  {
    inUseClr = bgBtnClr;
    inUseTxtClr = btnTxtClr;
    if((mouseX >= rect.x && mouseX <= rect.x+rect.w) && (mouseY >= rect.y && mouseY <= rect.y+rect.h))
    {
      Hover();
      if (mousePressed && (mouseButton ==  LEFT) && mouseDown)
      {
        OnClick();
      }
    }
  }
  
  void Draw()
  {
    push();
    fill(inUseClr);
    rect(rect.x-5,rect.y-5,rect.w,rect.h);
    fill(inUseTxtClr);
    textSize(btnTxtFntSize);
    text(btnTxt,rect.x+3,rect.y+rect.h-10);
    pop();
  }
  
}
class TileMapButton extends Button
{
  TileMapButton(Rect r)
  {
    super(r);
  }
  void OnClick()
  {
    background(0);
    sm.SetActiveObj(0);
  }
}

class BackToEditor extends Button
{
  BackToEditor(Rect r)
  {
    super(r);
  }
  void OnClick()
  {
    background(255);
    sm.SetActiveObj(0);
  }
}
class SaveButton extends Button
{
  SaveButton(Rect r)
  {
    super(r);
  }
    void OnClick()
  {
    println("Overwriting map");
    String path = e.tb.text;
    byte mapBytes[] = new byte[((mapCopy.w*mapCopy.h)*2)+4];
    mapBytes[0] = (byte)(mapCopy.w >> 8);
    mapBytes[1] = (byte)(mapCopy.w);
    mapBytes[2] = (byte)(mapCopy.h >> 8);
    mapBytes[3] = (byte)(mapCopy.h);
    int offset = 4;
    
    //This function collapses the 2D array into a 1D array, with a data offset of 4 - this is due to the first 4 bytes being used to store the size
    //Of the map
    for(int i = 0+offset; i < mapCopy.h+offset;i++) //<>//
    {
       int tileindex = 0;
       for(int u = 0; u < mapCopy.w*2;u++)
       {
         println("Tile: " + (i-4) + ", " + u + " on MapBytes index: " + (offset+((i-4)*mapCopy.w)+u));
         mapBytes[offset+((i-4)*mapCopy.w)+u] = mapCopy.map[i-4][tileindex].spriteByte;
         println("SpriteByte: " + mapCopy.map[i-4][tileindex].spriteByte + ", " + mapBytes[offset+((i-4)*mapCopy.w)+u]);
         mapBytes[offset+((i-4)*mapCopy.w)+u+1] = mapCopy.map[i-4][tileindex].rotationByte;//This had some problems, but should be fine now
         u++;
         tileindex++;
       }
    }
    
    
    
    
    saveBytes(path,mapBytes);
  }
}
class DrawModeToggleButton extends Button
{
  boolean toggled;
  DrawModeToggleButton(Rect r)
  {
    super(r);
    
  }
  void OnClick()
  {
    toggled = !toggled;
  }
  void Draw()
  {
    if(toggled)
    {
      push();
      stroke(124,252,0);
      super.Draw();
      pop();
    }
    else
    {
      super.Draw();
    }
    
    
  }
  
}
