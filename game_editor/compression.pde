class Bit
{
  private boolean state = false;
  Bit(boolean _state)
  {
    state = _state;
  }
  Bit()
  {
    
  }
  void Set(boolean b)
  {
   state = b; 
  }
  boolean Get()
  {
    return state;
  }
}



static class Compressor
{
  static boolean DEBUG = true;
  static byte[] SimpleByteCompress(byte[] byteArr)
  {
    ArrayList<Byte> bytes = new ArrayList<Byte>(); //<>//
    int size = byteArr.length;
    if(DEBUG){println("Starting size: " + size);}
    //We'll do some strange compression on it
    byte currB = 0x0;
    for(int i = 0; i < byteArr.length-1;i++)
    {
      if((byteArr[i] >> 4) == 0)
      {
        currB = byteArr[i];
        currB = (byte)(currB << 4 | byteArr[i+1]);
        println(currB);
        i++;
      }
      else
      {
        currB = byteArr[i];
        println(currB);
      }
      bytes.add(currB);
      
    }
    byte[] returnArr = new byte[bytes.size()];
    for(int i = 0; i < bytes.size();i++)
    {
      returnArr[i] = bytes.get(i);
    }
    if(DEBUG){println("Compressed into size: " + returnArr.length + " That is a compression ratio of: (" + size + "/" + returnArr.length + ") = " + size/returnArr.length);}
    return returnArr;
  }
  static byte[] MapCompress(byte[] decompressed_map)
  {
    byte[] withoutSize = new byte[decompressed_map.length-4];
    for(int i = 4; i < decompressed_map.length-4;i++)
    {
      withoutSize[i-4] = decompressed_map[i];
    }
    withoutSize = SimpleByteCompress(withoutSize);
    byte[] withSize = new byte[withoutSize.length+4];
    for(int i = 0; i < withoutSize.length;i++)
    {
      if(i < 4)
      {
        withSize[i] = decompressed_map[i];
      }
      else
      {
        withSize[i] = withoutSize[i-4]; //<>//
      }
    }
    return withSize;
  }
  static byte[] MapDecompress(byte[] compressed_map)
  {
   return compressed_map; 
  }
  
  static byte[] SimpleByteDecompress(byte[] byteArr)
  {
    int size = byteArr.length;
    if(DEBUG){println("Starting size: " + size);}
    return byteArr;
  }
}
