class IOController //Not really used as writing and reading bytes was waaaaaaaay easier than I expected
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
    
    if(amount == 0 && bs != null)
    {
      amount = bs.length;
    }
    else
    {
      return null;
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
