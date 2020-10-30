int globalKey; //The global variable holding the currently pressed key

int clicks; //Makes sure we don't doubble click items by only allowing one click at a time

boolean DEBUG = true; //Debug info, and trust me there is a lot

int buttonClickDelay = 15; //The amount of frames we wait before registering a new click

boolean typeRead; //Does the same as "int clicks" just for keyboard keys, making sure that keys aren't spamme
boolean mouseDown; //Not really used anymore except for a few strange places - does the same as "int clicks"
Editor e; //Our editor "scene"
ScreenManager sm; //Our screenmanager that keep tracks of what "scene" we are showing
TileMap tm; //Our tilemap "screen" or "scene"
SelTileMap selTm; //Same as TileMap and has the same functions, but allows picking a tile for DrawMode

void setup()
{
  size(800,800); //Setting size of the screen - This is the recommended setting, and some items will scale with size, but some won't
  e = new Editor(); //Create editor
  tm = new TileMap(); //Create Tilemap
  selTm = new SelTileMap(); //Create Selection Tilemap
  sm = new ScreenManager(); //Create ScreenManager
  sm.Add(e); //Add editor to list of "scenes" we want to be able to load
  sm.Add(tm); //Same but for the Tilemap
  sm.Add(selTm); //Same but for selectionTilemap
  sm.SetActiveObj(0); //Setting the editor as the active scene
  //frameRate(5);
}
void draw()
{
  //background(0);
  for(int i = 0; i < sm.objects.size();i++)
  {
    sm.GetObjAt(i).Update();//Update the active "scene"
    sm.GetObjAt(i).Draw(); //Draw the active "scene"
    
  }
  //Resetting variables each frame to not lock the keyboard
  typeRead = false;
  mouseDown = false; 
}
void keyTyped()
{
  globalKey = key; // store the key typed in a global varaiable
  typeRead = true; //Allow textfields to read the global variable
}
void keyReleased()
{
  globalKey = -1; // setting the key to -1 meaning no key
}
void keyPressed()
{
  if(key == ENTER)
  {
    globalKey = key; //Special keys like "ENTER" and "ESCAPE" can't be used with keyTyped() so we use keyPressed
  }
}
void mouseClicked()
{
 mouseDown = true; //Sets mouseDown to not break that piece of code that still relys on this
 if(clicks == 0)
 {
   clicks++; // adding 1 to clicks meaning we can click 1 time on any object, that supports clicks
 }
 
}
 void mousePressed()
 {

 }
 //this must be the worst idea ever
 boolean useClick() //Checks if we can consume a click
 {
   if(clicks <= 0) 
   {
     return false; //We don't have any clicks to consume, so we return false
   }
   else
   {
     clicks--;//Consumes a click
     return true; //and returns success
   }
 }
