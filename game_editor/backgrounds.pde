class Background extends ObjBase //Not my best code...
{
  int profile = 0; //Storing the background profile, so we can add more types of backgrounds in the future
  
  float rota = 0; //stores current rotation of the square
  
  float rotaSpeed = 1.2; //Stores the current rotationSpeed of the square
  
  int rotCounter; //Storing the times the squre did a full 2*PI rotation
  
  int circCounter; //Storing the amount of circles to draw
  
  color currFill; //Storing the squares fill color
  
  color currCircFill; //Storing the circle color - this is never used a fill, but as stroke, so the name is kinda wrong
  
  boolean direction; //Stores rotation direction
  
  boolean directionToggle; //stores if we should even be able to toggle rotation - to not lock the square at any 5 rotCounter intevals
  
  Background()
  {
    super(new Rect()); //init base obj
    //Initting values
    currFill = 255; 
    currCircFill = 255;
    rotCounter = 0;
    circCounter = 0;
    direction = true;
    directionToggle = false;
  }
  void Update()
  {
     switch(profile)
    {
      case 0: //cases were meant to be used so you could have many types of backgrounds, but I ran out of time
        if(direction)
        {
          rota += (PI*2)*((1/frameRate)*rotaSpeed); // Add a bit of rotation each frame based on rotation speed and the framerate
        }
        else
        {
          rota -= (PI*2)*((1/frameRate)*rotaSpeed); // Remove a bit of rotation each frame based on rotation speed and the framerate - When the square is rotating counter-clockwise
        }
        if(rota > PI*2 || rota < -PI*2) //Checking if we made any full turns
        {
          rota = 0; //Resetting rota at -PI*2 and PI*2, due to this being unnoticeable and makes sure that we don't over or underflow the rota value
          rotCounter++;
        }
        if(rotCounter%5 == 0) //Runs every 5 rotations
        {
          if(directionToggle) //if allowed to change direction
          {
            direction = !direction; //Change direction
            directionToggle = false; //Not allowed to change direction until at least 1 full rotation later
          }
        }
        else //If we are not on a rotation that is mutiple of 5
        {
          directionToggle = true; //Allow rotation toggle
        }
        
        if(rotCounter >= 20) //Checks of the counter is more than 20, to not overflow it, if it runs for hours
        {
          rotCounter = 0; //Resetting
          circCounter++; //adding a new ring
          
        }
        if(circCounter > 15) //Prevent circles taking up the whole screen
        {
          circCounter = 0; //Resetting
        }
        
      break;
      
      default:
      break;
       
    }
  }
  
  void Draw()
  {
    switch(profile) //same as the switch statement in the Update Function
    {
      case 0:
        if(rota%PI*2 == 0) //If we did a full rotation
        {
          //Randomize colors
          currFill = color(random(0,265),random(0,265),random(0,265));
          currCircFill = color(random(0,265),random(0,265),random(0,265));
        }
        push();
        fill(currFill); //Set square color
        translate(width/2,height/2); //Translate to the middle of the screen
        rotate(rota); //rotate
        rectMode(CENTER);
        rect(0,0,width/4,height/4); //Draw square
        pop();
        CircDraw(); //Draw circles
        
      break;
      
      default:
      break;
       
    }
  }
  
  void CircDraw()
  {
    for(int i = 0; i < circCounter;i++) //draw a circle circCounter times
    {
      push();
      smooth(); //removes blocky artifacts in the circles
      stroke(currCircFill); //change color
      noFill(); // Dont fill the circle
      circle(width/2,height/2,250+(i*14));
      pop();
    }
  }
  
  void ChangeType(int t) //Not used as I ran out of time
  {
    profile = t;
  }
  
}
