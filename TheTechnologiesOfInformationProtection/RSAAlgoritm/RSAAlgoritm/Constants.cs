using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace RSAAlgoritm
{
    class Constants
    {
        public const string CryptOperation = "CryptOperation";

        public const string SomethingWrongWithDecryption = "Something Wrong with Decryption";

        public const string SomethingWrongWithEncryption = "Something Wrong with Encryption";

        public const int KeySize = 1024;

        public const int MinValue = 20;

        public const int MaxValue = 99;

        public static int[] PrimeNumbers = { 2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67, 71, 73, 79, 83, 89, 97, 101 };
    }
}
