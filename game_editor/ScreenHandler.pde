class TileMap extends ObjBase
{
  spriteTable st;
  BackToEditor btn;
  TileMap()
  {
    super(new Rect(0,0,width,height));
    st = new spriteTable();
    btn = new BackToEditor(new Rect(width-100,height-50,100,50));
    btn.btnTxt = "Back To Editor";
    enabled = false;
  }
  void Draw()
  {
    
    if(enabled)
    {
      btn.Draw();
      int len = st.GetSpriteCount();
      PImage spriteArr[] = new PImage[len]; //We do +1, because we don't start a zero
      for(int i = 0; i < len; i++)
      {
        spriteArr[i] = st.SpriteLookUp((byte)(i+1));
      }
      //image(spriteArr[0],0,0,64,64);
      int u = 0;
      while(len > 0)
      {
        for(int i = 0; i < 4; i++)
        {
          int index = (u*4+i+1);
          push();
          image(spriteArr[u*4+i],128*u,i*64,64,64);
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
}
