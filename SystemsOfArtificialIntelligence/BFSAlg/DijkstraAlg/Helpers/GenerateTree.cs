using System.Collections.Generic;
using System.Drawing;
using System.Globalization;
using DijkstraAlg.Administrating;

namespace DijkstraAlg.Helpers
{
    public class GenerateTree
    {
        public static Dictionary<long, Point> OurTree = new Dictionary<long, Point>();

        private const int Point50 = 40;
        private static Point _point50Coord = new Point(334, 30);

        private const int Point25 = 15;
        private static Point _point25Coord = new Point(80, 120);

        private const int Point35 = 25;
        private static Point _point35 = new Point(160, 210);

        private const int Point20 = 10;
        private static Point _point20 = new Point(30, 240);

        private const int Point10 = 5;
        private static Point _point10 = new Point(20, 400);

        private const int Point22 = 12;
        private static Point _point22 = new Point(200, 400);

        private const int Point80 = 70;
        private static Point _point80 = new Point(550, 120);

        private const int Point60 = 50;
        private static Point _point60 = new Point(370, 270);

        private const int Point90 = 80;
        private static Point _point90 = new Point(620, 240);

        private const int Point70 = 60;
        private static Point _point70 = new Point(500, 400);

        public static void GenerateExampleTree(Graphics graphics)
        {
            if (OurTree.Count == 0)
            {
                OurTree.Add(Point50, _point50Coord);
                OurTree.Add(Point25, _point25Coord);
                OurTree.Add(Point35, _point35);
                OurTree.Add(Point20, _point20);
                OurTree.Add(Point10, _point10);
                OurTree.Add(Point22, _point22);
                OurTree.Add(Point80, _point80);
                OurTree.Add(Point60, _point60);
                OurTree.Add(Point90, _point90);
                OurTree.Add(Point70, _point70);
            }
            //50
            graphics.DrawEllipse(Pens.Black, _point50Coord.X - Constants.STRING_ALLOCATOR,
                _point50Coord.Y - Constants.STRING_ALLOCATOR,
                Constants.DEFAULT_WIDTH_HEIGHT_SIZE_OF_POINT, Constants.DEFAULT_WIDTH_HEIGHT_SIZE_OF_POINT);
            graphics.DrawString(Point50.ToString(CultureInfo.InvariantCulture), Constants.FONT_FOR_NUMBERS_IN_ELIPSES,
                Brushes.Black, _point50Coord.X, _point50Coord.Y);

            //25
            graphics.DrawEllipse(Pens.Black, _point25Coord.X - Constants.STRING_ALLOCATOR,
                _point25Coord.Y - Constants.STRING_ALLOCATOR,
                Constants.DEFAULT_WIDTH_HEIGHT_SIZE_OF_POINT, Constants.DEFAULT_WIDTH_HEIGHT_SIZE_OF_POINT);
            graphics.DrawString(Point25.ToString(CultureInfo.InvariantCulture), Constants.FONT_FOR_NUMBERS_IN_ELIPSES,
                Brushes.Black, _point25Coord.X, _point25Coord.Y);

            //35
            graphics.DrawEllipse(Pens.Black, _point35.X - Constants.STRING_ALLOCATOR,
                _point35.Y - Constants.STRING_ALLOCATOR,
                Constants.DEFAULT_WIDTH_HEIGHT_SIZE_OF_POINT, Constants.DEFAULT_WIDTH_HEIGHT_SIZE_OF_POINT);
            graphics.DrawString(Point35.ToString(CultureInfo.InvariantCulture), Constants.FONT_FOR_NUMBERS_IN_ELIPSES,
                Brushes.Black, _point35.X, _point35.Y);

            //20
            graphics.DrawEllipse(Pens.Black, _point20.X - Constants.STRING_ALLOCATOR,
                _point20.Y - Constants.STRING_ALLOCATOR,
                Constants.DEFAULT_WIDTH_HEIGHT_SIZE_OF_POINT, Constants.DEFAULT_WIDTH_HEIGHT_SIZE_OF_POINT);
            graphics.DrawString(Point20.ToString(CultureInfo.InvariantCulture), Constants.FONT_FOR_NUMBERS_IN_ELIPSES,
                Brushes.Black, _point20.X, _point20.Y);

            //10
            graphics.DrawEllipse(Pens.Black, _point10.X - Constants.STRING_ALLOCATOR,
                _point10.Y - Constants.STRING_ALLOCATOR,
                Constants.DEFAULT_WIDTH_HEIGHT_SIZE_OF_POINT, Constants.DEFAULT_WIDTH_HEIGHT_SIZE_OF_POINT);
            graphics.DrawString(Point10.ToString(CultureInfo.InvariantCulture), Constants.FONT_FOR_NUMBERS_IN_ELIPSES,
                Brushes.Black, _point10.X, _point10.Y);

            //22
            graphics.DrawEllipse(Pens.Black, _point22.X - Constants.STRING_ALLOCATOR,
                _point22.Y - Constants.STRING_ALLOCATOR,
                Constants.DEFAULT_WIDTH_HEIGHT_SIZE_OF_POINT, Constants.DEFAULT_WIDTH_HEIGHT_SIZE_OF_POINT);
            graphics.DrawString(Point22.ToString(CultureInfo.InvariantCulture), Constants.FONT_FOR_NUMBERS_IN_ELIPSES,
                Brushes.Black, _point22.X, _point22.Y);


            //80
            graphics.DrawEllipse(Pens.Black, _point80.X - Constants.STRING_ALLOCATOR,
                _point80.Y - Constants.STRING_ALLOCATOR,
                Constants.DEFAULT_WIDTH_HEIGHT_SIZE_OF_POINT, Constants.DEFAULT_WIDTH_HEIGHT_SIZE_OF_POINT);
            graphics.DrawString(Point80.ToString(CultureInfo.InvariantCulture), Constants.FONT_FOR_NUMBERS_IN_ELIPSES,
                Brushes.Black, _point80.X, _point80.Y);


            //60
            graphics.DrawEllipse(Pens.Black, _point60.X - Constants.STRING_ALLOCATOR,
                _point60.Y - Constants.STRING_ALLOCATOR,
                Constants.DEFAULT_WIDTH_HEIGHT_SIZE_OF_POINT, Constants.DEFAULT_WIDTH_HEIGHT_SIZE_OF_POINT);
            graphics.DrawString(Point60.ToString(CultureInfo.InvariantCulture), Constants.FONT_FOR_NUMBERS_IN_ELIPSES,
                Brushes.Black, _point60.X, _point60.Y);


            //90
            graphics.DrawEllipse(Pens.Black, _point90.X - Constants.STRING_ALLOCATOR,
                _point90.Y - Constants.STRING_ALLOCATOR,
                Constants.DEFAULT_WIDTH_HEIGHT_SIZE_OF_POINT, Constants.DEFAULT_WIDTH_HEIGHT_SIZE_OF_POINT);
            graphics.DrawString(Point90.ToString(CultureInfo.InvariantCulture), Constants.FONT_FOR_NUMBERS_IN_ELIPSES,
                Brushes.Black, _point90.X, _point90.Y);


            //70
            graphics.DrawEllipse(Pens.Black, _point70.X - Constants.STRING_ALLOCATOR,
                _point70.Y - Constants.STRING_ALLOCATOR,
                Constants.DEFAULT_WIDTH_HEIGHT_SIZE_OF_POINT, Constants.DEFAULT_WIDTH_HEIGHT_SIZE_OF_POINT);
            graphics.DrawString(Point70.ToString(CultureInfo.InvariantCulture), Constants.FONT_FOR_NUMBERS_IN_ELIPSES,
                Brushes.Black, _point70.X, _point70.Y);

            GenerateLines(graphics);


        }
        private static void GenerateLines(Graphics graphics)
        {
            graphics.DrawLine(Pens.Black, _point50Coord, _point25Coord);

            graphics.DrawLine(Pens.Black, _point50Coord, _point80);

            graphics.DrawLine(Pens.Black, _point25Coord, _point20);

            graphics.DrawLine(Pens.Black, _point25Coord, _point35);

            graphics.DrawLine(Pens.Black, _point20, _point10);

            graphics.DrawLine(Pens.Black, _point20, _point22);

            graphics.DrawLine(Pens.Black, _point80, _point60);

            graphics.DrawLine(Pens.Black, _point80, _point90);

            graphics.DrawLine(Pens.Black, _point60, _point70);
        }
    }
}
