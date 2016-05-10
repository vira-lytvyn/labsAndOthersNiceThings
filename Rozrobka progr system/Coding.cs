using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Windows.Forms;

namespace Genetic_Algorithm_Complex
{
    class Coding
    {
        //Binary
        //Binary coder
        static public void BinaryCoder(int Number, int LevelCode, out int[] Code)
        {
            int i;
            Code = new int[LevelCode];
            for (i = 0; i < LevelCode; i++)
            {
                Code[i] = 0;
            }
            if (Number >= Math.Pow(2, LevelCode))
            {
                MessageBox.Show("Error");
                return;
            }
            for (i = LevelCode - 1; i >= 0; i--)
            {
                double NumberQ = Number % 2;
                if (NumberQ != 0)
                {
                    Code[i] = 1;
                }
                else
                {
                    Code[i] = 0;
                }
                Number = Number / 2;
            }
            return;
        }
        //Binary-Gray coder
        static public void BinaryGrayCoder(int[] BinaryCode, int LevelCode, out int[] GrayCode)
        {
            int i;
            int k = 0;
            GrayCode = new int[LevelCode];
            bool index = false;
            for (i = 0; i < LevelCode; i++)
            {
                GrayCode[i] = 0;
                if ((BinaryCode[i] == 1) & (index == false))
                {
                    GrayCode[i] = 1;
                    k = i;
                    index = true;
                }
            }
            for (i = k + 1; i < LevelCode; i++)
            {
                GrayCode[i] = XOR(BinaryCode[i - 1], BinaryCode[i]);
            }
            return;
        }
        //Binary-Hexadecimal coder
        //Binary decoder
        static public void BinaryDecoder(int[] BinaryCode, int LevelCode, out int Number)
        {
            Number = 0;
            int i;
            int k = 0;
            for (i = LevelCode - 1; i >= 0; i--)
            {
                if (BinaryCode[i] == 1)
                {
                    Number = Number + Convert.ToInt32(Math.Pow(2, k));
                } 
                k += 1;
            }
        }
        
        //Gray
        static private int XOR(int x, int y)
        {
            if (x == y)
            {
                return 0;
            }
            else
            {
                return 1;
            }
        }
        //Gray coder
        static public void GrayCoder(int Number, int LevelCode, out int[] Code)
        {
            int i;
            int k = 0;
            int[] BCode;
            Code = new int[LevelCode];
            if (Number >= Math.Pow(2, LevelCode))
            {
                MessageBox.Show("Error");
                return;
            }            
            BinaryCoder(Number, LevelCode, out BCode);
            bool index = false;
            for (i = 0; i < LevelCode; i++)
            {
                Code[i] = 0;
                if ((BCode[i] == 1) & (index == false))
                {
                    Code[i] = 1;
                    k = i;
                    index = true;
                }
            }
            for (i = k + 1; i < LevelCode; i++)
            {
                Code[i] = XOR(BCode[i - 1], BCode[i]);
            }
            return;
        }
        //Gray-Binary coder
        static public void GrayBinaryCoder(int[] GrayCode, int LevelCode, out int[] BinaryCode)
        {
            int i;
            int k = 0;
            BinaryCode = new int[LevelCode];
            bool index = false;
            for (i = 0; i < LevelCode; i++)
            {
                BinaryCode[i] = 0;
                if ((GrayCode[i] == 1) & (index == false))
                {
                    BinaryCode[i] = 1;
                    k = i;
                    index = true;
                }
            }
            for (i = k + 1; i < LevelCode; i++)
            {
                BinaryCode[i] = XOR(BinaryCode[i - 1], GrayCode[i]);
            }
        }
        //Gray-Hexadecimal coder
        //Gray decoder
        static public void GrayDecoder(int[] GrayCode, int LevelCode, out int Number)
        {
            int[] BinaryCode;
            GrayBinaryCoder(GrayCode, LevelCode, out BinaryCode);
            BinaryDecoder(BinaryCode, LevelCode, out Number);
        }
        
        //Hexadecimal
        static public string HexadecimalConverter(int HexNumber)
        {
            if (HexNumber == 10)
            {
                return "A";
            }
            else if (HexNumber == 11)
            {
                return "B";
            }
            else if (HexNumber == 12)
            {
                return "C";
            }
            else if (HexNumber == 13)
            {
                return "D";
            }
            else if (HexNumber == 14)
            {
                return "E";
            }
            else if (HexNumber == 15)
            {
                return "F";
            }
            else
            {
                return Convert.ToString(HexNumber);
            }
        }
        static public int HexadecimalDeconverter(string HexSymbol)
        {
            if (HexSymbol == "A")
            {
                return 10;
            }
            else if (HexSymbol == "B")
            {
                return 11;
            }
            else if (HexSymbol == "C")
            {
                return 12;
            }
            else if (HexSymbol == "D")
            {
                return 13;
            }
            else if (HexSymbol == "E")
            {
                return 14;
            }
            else if (HexSymbol == "F")
            {
                return 15;
            }
            else
            {
                try
                {
                    return Convert.ToInt32(HexSymbol);
                }
                catch
                {
                    MessageBox.Show("Error");
                    return 0;
                }
            }
        }
        //Hexadecimal coder
        static public void HexadecimalCoder(int Number, int LevelCode, out int[] Code)
        {
            int i;
            int j;
            int k = LevelCode;
            Code = new int[LevelCode];
            if (Number >= Math.Pow(16, LevelCode))
            {
                MessageBox.Show("Error");
                return;
            }
            for (i = 0; i < LevelCode; i++)
            {
                if (Number < Math.Pow(16, i))
                {
                    k = i;
                    break;
                }
            }
            int z = k;
            for (i = LevelCode - k; i < LevelCode; i++)
            {
                z -= 1;                
                if (Number < 16)
                {
                    Code[i] =  Number;
                    break;
                }
                for (j = 1; j < 16; j++)
                {
                    if (Number < j * Math.Pow(16, z))
                    {
                        Code[i] = j - 1;
                        break;
                    }
                }
                Number -= Convert.ToInt32(Code[i] * Math.Pow(16, z));

            }
            return;
        }
        //Hexadecimal-Binary coder
        //Hexadecimal-Gray coder
        //Hexadecimal decoder
    }
}
