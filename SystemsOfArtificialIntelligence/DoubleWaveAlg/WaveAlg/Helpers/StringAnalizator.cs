using WaveAlg.Administrating;

namespace WaveAlg.Helpers
{
    public static class StringAnalizator
    {
        /// <summary>
        /// analizator for best way value
        /// </summary>
        /// <param name="checkString">string what we checked</param>
        /// <returns>if this string can be parse</returns>
        public static bool IsThisStringCanConvertToNumber(string checkString)
        {
            if (checkString == null)
            {
                return false;
            }
            if (string.IsNullOrWhiteSpace(checkString))
            {
                return false;
            }
            if (checkString == string.Empty)
            {
                return false;
            }
            if (checkString == Constants.START)
            {
                return false;
            }
            if (checkString == Constants.END)
            {
                return false;
            }
            if (checkString == Constants.DEFAULT_BLOCKER)
            {
                return false;
            }
            return true;
        }
    }
}
