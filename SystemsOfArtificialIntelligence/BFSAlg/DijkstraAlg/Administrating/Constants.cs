using System;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DijkstraAlg.Administrating
{
    public class Constants
    {
        public const int DEFAULT_WIDTH_HEIGHT_SIZE_OF_POINT = 30;
        public const int STRING_ALLOCATOR = 10;
        public static int result = 25;
        public static readonly Font FONT_FOR_NUMBERS_IN_ELIPSES = new Font("Arial", 8.0f);
        public const string CURRENT_POINT_DEFAULT = "";
        public const string ERROR_WE_HAVE_NO_POINTS = "Немає точок";
        public const string EDGE_WAGE_DEFAULT = "1";
        public const string WRONG_EDGE_WAGE = "Некоректна вага, будь ласка, використовуйте числа більші за 1 " +
                                              "або ж залиште значення за промовчанням - 1";
        public const string WRONG_EDGE_WAGE_CAPTION = "Неправильне значення";
        public const string DFS = "Пошук вглиб";
        public const string BFS = "Пошук вшир";
    }
}
