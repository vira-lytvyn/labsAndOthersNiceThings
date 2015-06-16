namespace WaveAlg.Administrating
{
    public class Constants
    {
        public const int DEFAULT_MATRIX_SIZE = 10;
        public const int DEFAULT_MATRIX_PERCENTAGE = 6;
        public const int MIN_MATRIX_SIZE = 5;
        public const int MAX_MATRIX_SIZE = 15;

        #region String Constants
        public const string WRONG_SIZE_MESSAGE = "Некоректний розмір матриці.";
        public const string ABOUT_FIELD = "\tВітаємо Вас у програмі 'Хвильовий алгоритм'. \n" +
                                          "Цей застосунок був розроблений з метою пошуку найкоротшого шляху між " +
                                          "заданими двома вершинами на графі з одиничними ребрами. \n" +
                                          "Програмний засіб було спроектовано в рамках Лабораторної роботи №1 з курсу 'Штучний інтелект'.";
        public const string START = "П";
        public const string END = "К";
        public const string CALCULATING_ERROR = "Вибачте. Виникли проблеми під час обчислень.";
        public const string FIND_BEST_WAY_ERROR = "Вибачте. Виникли проблеми при пошуку найкращого шляху.";
        public const string SOME_ERROR_ACCURD = "Вибачте. Сталась невідома помилка.";
        public const string VALID_ENTER_DATA = "Введено некоректні дані, використовуйте П 0 К";
        public const string RESULT_IS_NOT_VALID = "Немає";
        public const string DUBLICATE_CONTROL_WORDS = "Дублювання контрольних слів";
        public const string DEFAULT_BLOCKER = "0";
        #endregion

        #region Tooltips Constants
        public static string BestWayTooltip = string.Format("Значення за промовчанням: {0}", true);
        public static string AllWaysTooltip = string.Format("Значення за промовчанням: {0}", false);
        public static string ZeroePercentageTooltip =
            string.Format("Значення за промовчанням: {0}", DEFAULT_MATRIX_PERCENTAGE);

        public static string GenerateTooltip = string.Format("Згенерувати вхідні дані автоматично");
        public static string FindWayTooltip = string.Format("Знайти шлях");
        public static string NumSizeTooltip = 
            string.Format("Розмірність матриці має бути від: {0} до {1}", MIN_MATRIX_SIZE, MAX_MATRIX_SIZE);
        public static string BestResultTooltip = string.Format("Довжина шляху");
        public static string ClearTooltip = string.Format("Очистити матрицю");
        public static string DrawBestWay = string.Format("Показати найкращий шлях");
        #endregion
    }
}
