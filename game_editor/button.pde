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
      if (mousePressed && (mouseButton == LEFT))
      {
        OnClick();
      }
    }
  }
  
  void Draw()
  {
    push();
    fill(inUseClr);
    rect(rect.x,rect.y,rect.w,rect.h);
    fill(inUseTxtClr);
    textSize(btnTxtFntSize);
    text(btnTxt,rect.x+3,rect.y+rect.h+3);
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
    sm.GetObjAt(0).enabled = false;
    sm.GetObjAt(1).enabled = true;
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
    sm.GetObjAt(1).enabled = false;
    sm.GetObjAt(0).enabled = true;
  }
}
