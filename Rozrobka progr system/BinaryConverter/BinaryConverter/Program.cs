using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace BinaryConverter
{
    class Program
    {
        static void Main(string[] args)
        {
            int a = -15; 
            //можна створити безрозмірний масив - функція сама підбере необхідний розмір
            int[] binary = new int[0];
            IntegerToBinary(a, ref binary);

            for (int i = 0; i < binary.Length; i++)
            {
                Console.Write(binary[i]);
            }

            Console.WriteLine();
            Console.WriteLine(BinaryToInteger(binary));
            Console.ReadKey();
        }

        //converting functions 
        
        //convert integer to binary
         private static int Invert(int a)
        {
            if (a == 1)
                a = 0;
            else
                a = 1;
            return a;
        }

        #region З цілого до двійкового
        private static void IntegerToBinary(int number, ref int[] binary)
        {
            int bin;
            Stack<int> stack = new Stack<int>();
            int sign = Math.Sign(number);

            number = Math.Abs(number);

            while (number >= 1)
            {
                //остача від ділення
                bin = number % 2;
                number = number / 2;
                if (bin != 0)
                    stack.Push(1);
                else stack.Push(0);
            }
            stack.Push(0);

            //формування нового розміру масиву на основі розміру стеку
            binary = new int[stack.Count + 1];

            if (sign < 0) binary[0] = 1;
            else binary[0] = 0;

            for (int i = 1; i < binary.Length; i++)
                binary[i] = stack.Pop();
        }
        #endregion

        #region З двійкового до цілого
        private static int BinaryToInteger(int[] binaryCode)
        {
            int sum = 0;
            int i = 1;
            int j = binaryCode.Length - 2; 

            while (i < binaryCode.Length)
                //сумування множників, де j - степінь числа 2, а елемент масиву - 0 чи 1
                sum += binaryCode[i++] * (int)Math.Pow(2, j--);

            if (binaryCode[0] == 1) sum *= -1;

            return sum;
        }
        #endregion
    }
}
