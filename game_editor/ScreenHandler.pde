class TileMap extends ObjBase
{
  spriteTable st;
  BackToEditor btn;
  Rect rectArr[];
  TileMap()
  {
    super(new Rect(0,0,width,height));
    st = new spriteTable();
    btn = new BackToEditor(new Rect(width-100,height-50,100,50));
    btn.btnTxt = "Back To Editor";
    btn.btnTxtFntSize = 12;
    enabled = false;
    rectArr = new Rect[st.GetSpriteCount()];
    int len = st.GetSpriteCount();
      PImage spriteArr[] = new PImage[len];
      for(int i = 0; i < len; i++)
      {
        spriteArr[i] = st.SpriteLookUp((byte)(i));
      }
      //image(spriteArr[0],0,0,64,64);
      int u = 0;
       
      for(int z = 0; z < len;/*so that we don't go out of bounds*/z++)
      {
        for(int i = 0; i < 4; i++)
        {
          int index = (u*4+i+1);
          push();
          //image(spriteArr[u*4+i],128*u,i*64,64,64);
          rectArr[z] = new Rect(128*u,i*64,64,64);
          pop();
        }
        u++;
      }
      //rectArr = RevertArray(rectArr);
  }
  void Draw()
  {
    
    if(enabled)
    {
      background(0);
      btn.Draw();
      int len = st.GetSpriteCount();
      PImage spriteArr[] = new PImage[len]; //We do +1, because there is no sprite 0 don't start a zero
      for(int i = 0; i < len; i++)
      {
        spriteArr[i] = st.SpriteLookUp((byte)(i));
      }
      //image(spriteArr[0],0,0,64,64);
      int u = 0;
      for(int z = 0; z < len;z++)
      {
        for(int i = 0; i < 4; i++)
        {
          int index = (u*4+i+1);
          push();
          image(spriteArr[z*4+i],128*z,i*64,64,64);
          fill(255);
          textSize(30);
          text("" + index,(u)*128+64,i*64+32);
          pop();
          len--;
        }
        u++;
      }
      
    
    
    }
}
  void Update()
  {  
    if(enabled)
    {
      btn.Update();
    }
    
  }
}

class SelTileMap extends TileMap
{
  SelTileMap()
  {
    super();
  }
  void Update()
  {  
    if(enabled)
    {
      btn.Update();
      println(rectArr.length);
      for(int i = 0; i < 6;i++)
      {
         if((mouseX >= rectArr[i].x && mouseX <= rectArr[i].x+rectArr[i].w) && (mouseY >= rectArr[i].y && mouseY <= rectArr[i].y+rectArr[i].h)) //<>//
         {
           if (mousePressed && (mouseButton ==  LEFT) && mouseDown) //<>//
           {
             println("Selected a tile: " + (i)); //<>//
             e.drawModeTile = i; //<>//
             e.drawModeTileSelected = true; //<>//
             sm.SetActiveObj(0); //<>//
           }
         }
      }
    }
  }
}

class ScreenManager
{
  ArrayList<ObjBase> objects;
  ScreenManager()
  {
    objects = new ArrayList<ObjBase>();
  }
  void Add(ObjBase b)
  {
    objects.add(b);
  }
  ObjBase GetObjAt(int i)
  {
    return objects.get(i);
  }
  void SetActiveObj(int i)
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
