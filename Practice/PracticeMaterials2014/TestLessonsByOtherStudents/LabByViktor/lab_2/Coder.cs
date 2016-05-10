using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace lab_2
{
    public class Coder
    {
        static public string HexFromID(int ID)// перекодовування з десяткової в шістнадцяткову
        {
            return ID.ToString("X");
        }
        static public int IDFromHex(string HexID) // перекодовування з шістнадцяткової в десяткову
        {
            return int.Parse(HexID, System.Globalization.NumberStyles.HexNumber);
        }
        static public string IntegerToBinary(int number)
        {
            string binary = Convert.ToString(number, 2);
            return binary;
        }
        static public int BinaryToInteger(string binaryCode)
        {
            int result = Convert.ToInt32(binaryCode, 2);
            return result;
        }
    }
}
