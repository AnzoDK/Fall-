class Game
{
  Map m;
  MainMenu mm;
  void SetUp()
  {
   m = new Map(); 
   mm = new MainMenu();
   m.defaultRect = new Rect(0,0,32,32);
   m.map = m.LoadMap("default.txt");
  }
  void Update()
  {
   mm.Update();
   //m.Update();
  }
  void Draw()
  {
    mm.Draw();
    //m.Draw();
  }
}


Game g;
void setup()
{
  size(1000,1000);
  g = new Game();
  g.SetUp();
  
  
}

void draw()
{
  g.Update();
  g.Draw();
  
}
