class Button extends ObjBase
{
  color bgBtnClr; //color of button background
  color btnTxtClr; //Color of text on button
  color btnHoverClr; // color used when hovering over the button
  color btnTxtHoverClr; // color used for the text when hovering
  String btnTxt; // text on the button
  int btnTxtFntSize; // font size
  private color inUseClr; //The color that we actually use - copies values from either hover or normal background color
  private color inUseTxtClr; //same but for the text
  private int debugCounter = 0; // just debug
  Button(Rect r)
  {
    super(r); // init the ObjBase
    
    //Setting default values to variables
    btnTxtFntSize = 30;
    bgBtnClr = 0;
    btnTxtClr = 255;
    btnHoverClr = 255;
    btnTxtHoverClr = 0;
    btnTxt = "New Btn";
    
    
  }
  
  void OnClick() //meant to be overriden
  {
    
  }
  
  void Hover()
  {
    inUseClr = btnHoverClr;
    inUseTxtClr = btnTxtHoverClr;
  }
  
  void Update()
  {
    if(enabled)
    {
      inUseClr = bgBtnClr; //use background color normal
      inUseTxtClr = btnTxtClr; //use normal text color
      if((mouseX >= rect.x && mouseX <= rect.x+rect.w) && (mouseY >= rect.y && mouseY <= rect.y+rect.h)) //check for hovering
      {
        Hover(); //switch colors on hover
        //if(DEBUG){println("HOVERING " + debugCounter);debugCounter++;}
        if (mousePressed && (mouseButton ==  LEFT) && useClick()) //check for clicking while hovering
        {
          OnClick(); //clicks
          if(DEBUG){println("Clicked");} //debug
        }
      }
    }
  }
  
  void Draw()
  {
    if(enabled)
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
  
}
class TileMapButton extends Button 
{
  TileMapButton(Rect r)
  {
    super(r); //inits a base button
  }
  void OnClick()//overrides the OnClick function
  {
    background(0); //resetting the background
    sm.SetActiveObj(1); //setting the tilemap to be the scene in use
  }
}

class BackToEditor extends Button
{
  BackToEditor(Rect r)
  {
    super(r); //inits a base button
  }
  void OnClick() //override
  {
    background(255); //resetting the background
    sm.SetActiveObj(0); //setting the the editor to be the scene in use
  }
}
class SaveButton extends Button
{
  SaveButton(Rect r)
  {
    super(r); //inits a base button
  }
    void OnClick() //override
  {
    //This is the waaaaay to complicated way to save the map
    if(DEBUG){println("Overwriting map");} //debug
    String path = e.tb.text; //grap the text of the editors textbox to use as path for the save
    byte mapBytes[] = new byte[((mapCopy.w*mapCopy.h)*2)+4]; //Create a 1D array to store the bytes at the size of (map_width * map map_height)*bytes_per_tile+offeset
    
    //Set the first 4 bytes to represent the size of the map
    mapBytes[0] = (byte)(mapCopy.w >> 8); /*There is no reason to do this but it works so I won't touch it - a better way would be to just assign mapBytes[1] = w and mapBytes[3] = h but that would only work for numbers less then 255, so this code is only usefull if
    You for some reason wants a map that takes your whole RAM module*/
    mapBytes[1] = (byte)(mapCopy.w);
    mapBytes[2] = (byte)(mapCopy.h >> 8); //same goes for this
    mapBytes[3] = (byte)(mapCopy.h);
    int offset = 4;
    
    //This function collapses the 2D array into a 1D array, with a data offset of 4 - this is due to the first 4 bytes being used to store the size
    //Of the map
    int totalTileCounter = 0;
    for(int i = 0+offset; i < mapCopy.h+offset;i++)
    {
       int tileindex = 0;
       for(int u = 0; u < mapCopy.w*2;u++)
       {
         
         mapBytes[offset+((i-4)*mapCopy.w*2)+u] = mapCopy.map[i-4][tileindex].spriteByte; //Store the sprite byte every other tile
         if(DEBUG){println("SpriteByte: " + mapCopy.map[i-4][tileindex].spriteByte + ", " + mapBytes[offset+((i-4)*mapCopy.w)+u]);}
         mapBytes[offset+((i-4)*mapCopy.w*2)+u+1] = mapCopy.map[i-4][tileindex].rotationByte; //Store the rotation byte on the same index as spritebyte +1
         u++;
         tileindex++;
         totalTileCounter++;
         if(DEBUG){println("Tile: " + (i-4) + ", " + u + " on MapBytes index: " + (offset+((i-4)*mapCopy.w*2)+u));}
         if(DEBUG){println("Total tiles processed: " + totalTileCounter + " - Tile index: " + tileindex);}
       }
    }
    
    
    
    
    saveBytes(path,mapBytes); //Write bytes to file
  }
}
class DrawModeToggleButton extends Button //this is a toggle button
{
  boolean toggled;
  DrawModeToggleButton(Rect r)
  {
    super(r); //init base button
    toggled = false;
    
  }
  void OnClick()
  {
    if(enabled)
    {
      toggled = !toggled; //reverse the togglestate
      if(DEBUG){println("Toggled to: " + toggled);}
    }
  }
  void Draw()
  {
    if(enabled)
    {
      if(toggled)
      {
        push();
        stroke(124,252,0); //set a color around the button
        super.Draw(); //Draw as any other button
        pop();
      }
      else
      {
        super.Draw(); //Draw as any other button
      }
    }
    
    
  }
  
}
