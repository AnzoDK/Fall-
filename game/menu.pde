class Text extends ObjBase
{
  color currClr;
  color clr;
  String text;
  int fontSize;
  Text(Rect r)
  {
    super(r);
    text = "";
    clr = color(0,0,0);
    fontSize = 12;
    
  }
  void Update()
  {
    
  }
  void Draw()
  {
    push();
    fill(clr);
    textSize(fontSize);
    text(text,rect.x+(rect.w/2)-(textWidth(text)/2),rect.y+(rect.h/2));
    pop();
  }
  
}


class Button extends ObjBase
{
  color bgmColor;
  color hoverClr;
  color currColor;
  Text btnTxt;
  Button(Rect r)
  {
    super(r, new Rot());
    bgmColor = color(0,0,0);
    btnTxt = new Text(r);
    btnTxt.text = "new Btn";
    btnTxt.clr = color(255,255,255);
    hoverClr = color(80,82,80);
  }
  void onClick()
  {
    
  }
  void onHover()
  {
    btnTxt.clr = color(255,255,255);;
  }
  void Update()
  {
    btnTxt.clr = 0x0;
    bgmColor = color(255,255,255);
    if((mouseX > rect.x && mouseX < rect.x+rect.w) && (mouseY > rect.y && mouseY < rect.y+rect.h))
    {
       onHover();
       if(mousePressed && (mouseButton == LEFT))
       {
         //println("clicking");
         onClick();
       }
    }
    btnTxt.Update();
  }
  void Draw()
  {
    push();
    fill(bgmColor);
    rect(rect.x,rect.y,rect.w,rect.h,30);
    pop();
    btnTxt.Draw();
  }
}
class MainMenu extends ObjBase
{
  class StartButton extends Button
  {
    StartButton(Rect r)
    {
      super(r);
      btnTxt.text = "Start Game";
      
    }
    void onClick()
    {
      StartGame();
    }
  }
  class ExitButton extends Button
  {
    ExitButton(Rect r)
    {
      super(r);
      btnTxt.text = "Exit Game";
    }
    void onClick()
    {
      ExitGame();
    }
  }
  boolean enabled;
  StartButton startBtn;
  ExitButton exitBtn;
  MainMenu()
  {
    super(new Rect(0,0,width,height),new Rot());
    startBtn = new StartButton(new Rect((width/2)-((width/3)/2),(height/2)-(height/4),width/3,height/8));
    exitBtn = new ExitButton(new Rect((width/2)-((width/3)/2),(height/2)+(height/4),width/3,height/8));
    enabled = true;
    
  }
  void Draw()
  {
    if(enabled)
    {
      startBtn.Draw();
      exitBtn.Draw();
    }
  }
  void Update()
  {
    if(enabled)
    {
      exitBtn.Update();
      startBtn.Update();
    }
  }
  public void StartGame()
  {
    println("Starting?");
  }
  public void ExitGame()
  {
    println("Dying!");
    exit();
  }
}
