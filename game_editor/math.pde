class Point2D
{
  float x;
  float y;
  Point2D(float _x, float _y)
  {
    x = _x;
    y = _y;
  }
}

public float ToRadians(int degrees)
{
  return (degrees*PI)/180;
}
public float ToRadians(float degrees)
{
  return (degrees*PI)/180;
}
public String ToHex(byte b)
{
  String result = "0x";
  result += b;
  return result;
}
public byte ToByte(int i)
{
  return (byte)i;
}

/*
Most programming languages have some sort of function for converting a string or char that uses the ascii representation of a number to an int.
This sadly does not include Java on which Processing is based upon. This means that I have to make a workaround for that - I called it Atoi, due
to that being the name of the function in C and C++ - As we are only converting txt bytes or txt ints to int, we can just ignore the full atoi table and just use
this simplified version.
*/
public int SimpleAtoi(String txt)
{
    int result = 0;
   if(txt.length() == 3 || txt.length() == 4) // We check for a length of either 3 or 4. This is because a byte that represents a number <= 0xF (unsigned int 15)
   //Only requires 3 letters to write, but a byte > 0xF (unsigned int 15) will need 4 letters. For example the unsigned int 16 would look like this 0x10.
   {
     println("Converting: " + txt);
     char charToProcess; //The char we want to convert.
     int processTimes; //The amount of letters to convert - We use the length of txt to determine this
     if(txt.length() == 4)
     { 
        processTimes = 2;
     }
     else
     {
       processTimes = 1;
     }
     for(int i = 0; i < processTimes;i++)
     {
       charToProcess = txt.charAt(2+i);
      switch(charToProcess)
      {
        case '0':
          result += 0;
        break;
        case '1':
          result += 1;
        break;          
        case '2':
          result += 2;
        break;
        case '3':
          result += 3;
        break;
        case '4':
          result += 4;
        break;
        case '5':
          result += 5;
        break;
        case '6':
          result += 6;
        break;
        case '7':
          result += 7;
        break;
        case '8':
          result += 8;
        break;
        case '9':
          result += 9;
        break;
        case 'A': //Yes - This is letter, In hexadecimal, the letters from A - F are used to express 10 - 15
          result += 10;
        break;
        case 'B':
          result += 11;
        break;
        case 'C':
          result += 12;
        break;
        case 'D':
          result += 13;
        break;
        case 'E':
          result += 14;
        break;
        case 'F':
          result += 15;
        break;
        
         
        default: //Just to make sure, that if something goes wrong, we just return 0 instead of crashing
          result += 0;
        break;
      }
   }
   }
   else
   {
     result = 0;
   }
   println("Converted: " + txt + " To: " + result);
   return result; //Returning our converted Hex
}
public byte ToByte(String txt)
{
  return (byte)SimpleAtoi(txt);
}
