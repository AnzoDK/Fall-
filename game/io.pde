class IOController
{
  void WriteByte(byte b)
  {
    
  }
  void WriteBytes(byte[] b)
  {
    
  }
  //if amount is set to zero it reads the whole file
  byte[] ReadBytes(String path, int amount)
  {
    
    byte[] bs = loadBytes(path);
    
    if(amount == 0)
    {
      amount = bs.length;
    }
    
    if(amount > bs.length)
    {
      amount = bs.length;
    }
    
    byte[] newBytes = new byte[amount];
    for(int i = 0; i < amount; i++)
    {
      newBytes[i] = bs[i];
    }
    
    return newBytes;
  }
  
}
