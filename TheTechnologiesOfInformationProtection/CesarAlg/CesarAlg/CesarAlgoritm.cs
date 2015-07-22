using System.Linq;
using System.Text;

namespace CesarAlg
{
    class CesarAlgoritm
    {
        public static string Crypt(string stringToEncrypt, int cesarKey)
        {
            var stringBuilder = new StringBuilder();
            foreach (var litteral in stringToEncrypt)
            {
                var ifIsHigh = false;
                var indexInAlphabet = 0;
                foreach (var litteralInAlphabetHigh in Constants.AlphabetHigh)
                {
                    if (litteralInAlphabetHigh == litteral)
                    {
                        ifIsHigh = true;
                        break;
                    }
                    indexInAlphabet++;
                }
                if (ifIsHigh == false)
                {
                    indexInAlphabet = Constants.AlphabetLow.TakeWhile(litteralInAlphabetLow => litteralInAlphabetLow != litteral).Count();
                }
                var newIndex = indexInAlphabet + cesarKey;
                if (newIndex > Constants.AlphabetHigh.Length - 1)
                {
                    var howMuchBigger = newIndex - Constants.AlphabetHigh.Length;
                    newIndex = howMuchBigger;
                }
                var newValue = ifIsHigh ? Constants.AlphabetHigh[newIndex] : Constants.AlphabetLow[newIndex];
                stringBuilder.Append(newValue);
            }
            return stringBuilder.ToString();
        }

        public static string Decrypt(string encryptString, int cesarKey)
        {
            var stringBuilder = new StringBuilder();
            foreach (var litteral in encryptString)
            {
                var ifIsHigh = false;
                var indexInAlphabet = 0;
                foreach (var litteralInAlphabetHigh in Constants.AlphabetHigh)
                {
                    if (litteralInAlphabetHigh == litteral)
                    {
                        ifIsHigh = true;
                        break;
                    }
                    indexInAlphabet++;
                }
                if (ifIsHigh == false)
                {
                    indexInAlphabet = Constants.AlphabetLow.TakeWhile(litteralInAlphabetLow => litteralInAlphabetLow != litteral).Count();
                }
                var newIndex = indexInAlphabet - cesarKey;
                if (newIndex < 0)
                {
                    var howMuchBigger = newIndex + Constants.AlphabetLow.Length;
                    newIndex = howMuchBigger;
                }
                var newValue = ifIsHigh ? Constants.AlphabetHigh[newIndex] : Constants.AlphabetLow[newIndex];
                stringBuilder.Append(newValue);
            }
            return stringBuilder.ToString();
        }
    }
}
