using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CesarAlg
{
    class VigenerAlgoritm
    {
        public static string Crypt(string openString, string codeString)
        {
            if (openString.Length != codeString.Length)
            {
                Console.ForegroundColor = ConsoleColor.Red;
                Console.WriteLine(Constants.StringMustBeEquivalentOnLength);
                throw new Exception();
            }
            var result = new StringBuilder();
            var lowerOpenString = openString.ToLower();
            var lowerCodeString = codeString.ToLower();
            var vigenerMatrixLow = CreateVigenerMatrix(Constants.AlphabetLow);
            for (var literalIndex = 0; literalIndex < codeString.Length; literalIndex++)
            {
                if (lowerOpenString[literalIndex] == ' ' && lowerCodeString[literalIndex] == ' ')
                {
                    result.Append(" ");
                    continue;
                }
                var openStringChar = lowerOpenString[literalIndex];
                var codeStringChar = lowerCodeString[literalIndex];
                var openStringIndex = GetIndexInAlphabet(openStringChar);
                var codeStringIndex = GetIndexInAlphabet(codeStringChar);
                result.Append(vigenerMatrixLow[openStringIndex, codeStringIndex]);
            }
            return result.ToString();
        }

        public static string Decrypt(string encryptedString, string codeString)
        {
            if (encryptedString.Length != codeString.Length)
            {
                Console.ForegroundColor = ConsoleColor.Red;
                Console.WriteLine(Constants.StringMustBeEquivalentOnLength);
                throw new Exception();
            }
            var result = new StringBuilder();
            var lowerEncryptedString = encryptedString.ToLower();
            var lowerCodeString = codeString.ToLower();
            var vigenerMatrixLow = CreateVigenerMatrix(Constants.AlphabetLow);
            for (var literalIndex = 0; literalIndex < codeString.Length; literalIndex++)
            {
                if (lowerEncryptedString[literalIndex] == ' ' && lowerCodeString[literalIndex] == ' ')
                {
                    result.Append(" ");
                    continue;
                }
                var encryptedStringChar = lowerEncryptedString[literalIndex];
                var codeStringChar = lowerCodeString[literalIndex];
                var codeStringIndex = GetIndexInAlphabet(codeStringChar);
                result.Append(FindOpenStrinLitteralFromCode(encryptedStringChar, codeStringIndex, vigenerMatrixLow));
            }
            return result.ToString();
        }

        private static char[,] CreateVigenerMatrix(IList<char> alphabet)
        {
            var vigenerMatrix = new char[alphabet.Count, alphabet.Count];
            for (var i = 0; i < alphabet.Count; i++)
            {
                for (var j = 0; j < alphabet.Count; j++)
                {
                    var index = j + i;
                    if (index > alphabet.Count - 1)
                    {
                        index = index - alphabet.Count;
                    }
                    vigenerMatrix[i, j] = alphabet[index];
                    //Console.Write(vigenerMatrix[i, j] + " ");
                }
                //Console.WriteLine();
            }
            return vigenerMatrix;
        }

        private static int GetIndexInAlphabet(char litteral)
        {
            var index = 0;
            foreach (var alphabetLitteral in Constants.AlphabetLow)
            {
                if (alphabetLitteral == litteral)
                {
                    return index;
                }
                index++;
            }
            throw new Exception();
        }

        private static char FindOpenStrinLitteralFromCode(char codedLitteral, int codeIndex, char[,] vigenerMatrix)
        {
            var result = '\0';
            for (var i = 0; i < Constants.AlphabetLow.Length; i++)
            {
                if (vigenerMatrix[i, codeIndex] == codedLitteral)
                {
                    result = vigenerMatrix[i, 0];
                }
            }
            return result;
        }
    }
}
