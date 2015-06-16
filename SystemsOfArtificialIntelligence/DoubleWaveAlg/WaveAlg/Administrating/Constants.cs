namespace WaveAlg.Administrating
{
    public class Constants
    {
        public const int DEFAULT_MATRIX_SIZE = 10;

        public const int DEFAULT_MATRIX_PERCENTAGE = 10;

        public const int MIN_MATRIX_SIZE = 5;

        public const int MAX_MATRIX_SIZE = 15;

        #region String Constants

        public const string WRONG_SIZE_MESSAGE = "Wrong Size";

        public const string ABOUT_FIELD = "Hello guys. This is program wich can find the best way for wave algoritm. " +
                                          "It uses left - rifgt pallete cell method." +
                                          "LAB Number 4";

        public const string START = "S";

        public const string END = "E";

        public const string CALCULATING_ERROR = "Problem while calculating";

        public const string FIND_BEST_WAY_ERROR = "We have some troubles while we find best way";

        public const string SOME_ERROR_ACCURD = "Some error accurd";

        public const string VALID_ENTER_DATA = "You must Set valid enter Data youse: S 0 E";

        public const string RESULT_IS_NOT_VALID = "RESULT NOT VALID";

        public const string DUBLICATE_CONTROL_WORDS = "Dublicate control words";

        public const string DEFAULT_BLOCKER = "0";

        #endregion

        #region Tooltips Constants

        public static string BestWayTooltip = string.Format("Default value is: {0}", true);

        public static string AllWaysTooltip = string.Format("Default value is: {0}", false);

        public static string ZeroePercentageTooltip = 
            string.Format("Default value is: {0}", DEFAULT_MATRIX_PERCENTAGE);

        public static string GenerateTooltip = string.Format("Generate matrix automaticly");

        public static string FindWayTooltip = string.Format("Find Way");

        public static string NumSizeTooltip = 
            string.Format("Size of matrix, must be: from: {0} to {1}", MIN_MATRIX_SIZE, MAX_MATRIX_SIZE);

        public static string BestResultTooltip = string.Format("Best result");

        public static string ClearTooltip = string.Format("Clear our matrix Field");

        public static string DrawBestWay = string.Format("Draw best Way");

        #endregion
    }
}
