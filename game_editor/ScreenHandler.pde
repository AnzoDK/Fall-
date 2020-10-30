class TileMap extends ObjBase
{
  spriteTable st; //Due to java being Java - making a static function was way harder than just doing this madness
  BackToEditor btn; //Adding a button for going back to the editor
  Rect rectArr[]; //Array of Rects, that stores the x,y,w,h of the tiles we are displaying on the screen, also used to check if the mouse is clicking on a tile to select it in drawmode
  TileMap()
  {
    super(new Rect(0,0,width,height)); //Init the base class
    
    //Creating and setting settings for objects in the class
    st = new spriteTable();
    btn = new BackToEditor(new Rect(width-100,height-50,100,50));
    btn.btnTxt = "Back To Editor";
    btn.btnTxtFntSize = 12;
    enabled = false;
    
    int len = st.GetSpriteCount();
    rectArr = new Rect[len]; //Making rectArr the size of all sprites in use atm, so that we can display them later
    
    
      PImage spriteArr[] = new PImage[len]; //Creating a sprite array to store the sprites we need to display
      for(int i = 0; i < len; i++)
      {
        spriteArr[i] = st.SpriteLookUp((byte)(i)); //Getting the sprite from a byte (in this case we just interate through the list of sprites)
      }
      
      int u = 0;
      int j = 0; //This is a bad way to count the sprite we are at...
      for(int z = 0; z < len;z++)
      {
          for(int i = 0; i < 4; i++)
          {
            len--;
            if(len >= 0)
            {
              push();
              rectArr[j] = new Rect(128*z,i*64,64,64); //Creating a new rect to show the sprite in
              fill(255);
              textSize(30);
              text("" + j,(u)*128+64,i*64+32); //Writing text that shows the index of the sprite in the spritetable
              pop();
              j++;
            }
          }
          u++;
      }
  }
  void Draw()
  {
    
    if(enabled)
    {
      background(0); //Resetting the background
      btn.Draw();
      int len = st.GetSpriteCount(); // Gets the length of the sprite table
      PImage spriteArr[] = new PImage[len];
      for(int i = 0; i < len; i++)
      {
        spriteArr[i] = st.SpriteLookUp((byte)(i));
      }
      //image(spriteArr[0],0,0,64,64);
      int u = 0;
      int j = 0; //This is a bad way to count the sprite we are at...
      for(int z = 0; z < len;z++)
      {
          for(int i = 0; i < 4; i++)
          {
            len--;
            if(len >= 0)
            {
              push();
              image(spriteArr[j],128*z,i*64,64,64);
              fill(255);
              textSize(30);
              text("" + j,(u)*128+64,i*64+32); //Writing text that shows the index of the sprite in the spritetable
              pop();
              j++;
            }
          }
          u++;
      }
      
    
    
    }
}
  void Update()
  {  
    if(enabled)
    {
      btn.Update(); //update the backtoeditor button
    }
    
  }
}

class SelTileMap extends TileMap
{
  SelTileMap()
  {
    super(); //Init base obj
  }
  void Update()
  {  
    if(enabled)
    {
      btn.Update();
      //if(DEBUG){println(rectArr.length);}
      for(int i = 0; i < rectArr.length;i++)
      {
         if((mouseX >= rectArr[i].x && mouseX <= rectArr[i].x+rectArr[i].w) && (mouseY >= rectArr[i].y && mouseY <= rectArr[i].y+rectArr[i].h)) //Check if we are pointing at a tile in the list
         {
           if(DEBUG){println("Hovering over TileRect " + i);}
           if (mousePressed && (mouseButton ==  LEFT) && useClick()) //If we click to select
           {
             if(DEBUG)
             {
               println("Selected a tile: " + (i));
             }
             e.drawModeTile = i; //Setting editors drawmode index to current index;
             e.drawModeTileSelected = true; //Tell editor that a sprite has been selected
             sm.SetActiveObj(0); //Set editor as active scene
           }
         }
      }
    }
  }
}

class ScreenManager
{
  ArrayList<ObjBase> objects; //Store objects as scenes to display
  ScreenManager()
  {
    objects = new ArrayList<ObjBase>(); //init list
  }
  void Add(ObjBase b)
  {
    objects.add(b); //Adding an object to the list
  }
  ObjBase GetObjAt(int i)
  {
    return objects.get(i); //Accessing an object on the list
  }
  void SetActiveObj(int i) //Setting only the object at index "i" to enabled and disabling the rest
  {
    for(int u = 0; u < objects.size();u++)
    {
      if(i == u)
      {
        objects.get(u).enabled = true;
      }
      else
      {
        objects.get(u).enabled = false;
      }
    }
  }
}
