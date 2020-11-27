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



class Compressor
{
  boolean DEBUG = true;
  byte[] SimpleByteCompress(byte[] byteArr)
  {
    int passes = 0;
    int zeroCount = 0;
    ArrayList<Byte> bytes = new ArrayList<Byte>();
    ArrayList<Byte> tmpArr = new ArrayList<Byte>();
    for(int i = 0; i < byteArr.length-1;i++)
    {
      tmpArr.add(byteArr[i]);
    }
    int size = byteArr.length;
    if(DEBUG){println("Starting size: " + size);}
    //We'll do some strange compression on it - designed to take advantage of the large amount of zeroes in the map
    byte currB = 0x0;
    do{ 
      zeroCount = 0;
    for(int i = 0; i < size-1;i++)
    {
      
      if((tmpArr.get(i) >> 4) == 0)
      {
        zeroCount++;
        currB = tmpArr.get(i);
        currB = (byte)(currB << 4 | tmpArr.get(i));
        println(currB);
        i++;
      }
      else
      {
        currB = tmpArr.get(i);
        println(currB);
      }
      bytes.add(currB);
      
    }
      tmpArr.clear();
      for(int c = 0; c < bytes.size()-1;c++)
      {
         tmpArr.add(bytes.get(c));
      }
      bytes.clear();
      size = tmpArr.size();
      passes++;
      String path = "Pass_"+passes+".txt";
      byte[] tmpBytes = new byte[tmpArr.size()];
      for(int c = 0; c < tmpArr.size();c++)
      {
        tmpBytes[c] = tmpArr.get(c);
      }
      
      saveBytes(path,tmpBytes);
    }
    while(zeroCount != 0);
    byte[] returnArr = new byte[tmpArr.size()];
    for(int i = 0; i < tmpArr.size();i++)
    {
      returnArr[i] = tmpArr.get(i);
    }
    //if(DEBUG){println("Compressed into size: " + returnArr.length + " That is a compression ratio of: (" + byteArr.length + "/" + returnArr.length + ") = " + size/returnArr.length);}
    println("Passed: " + passes + " times");
    return returnArr; //<>//
  }
  byte[] MapCompress(byte[] decompressed_map)
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
  byte[] MapDecompress(byte[] compressed_map)
  {
   return compressed_map; 
  }
  
  byte[] SimpleByteDecompress(byte[] byteArr)
  {
    int size = byteArr.length;
    if(DEBUG){println("Starting size: " + size);}
    return byteArr;
  }
}
