using System;
using System.Drawing;
using System.Globalization;
using WaveAlg.Administrating;

namespace WaveAlg.Helpers
{
    public class LengthFromSPointToEPoint
    {
        public static int ClosestLengthForCircle(MainApp app)
        {
            bool noWories;
            var coordOfStartPoint = LiteralFinder.FindThisLiteral(app.DataMatrix, Constants.START, out noWories);
            var coordOfEndPoint = LiteralFinder.FindThisLiteral(app.DataMatrix, Constants.END, out noWories);
            var lengthX = Math.Abs(coordOfStartPoint.X - coordOfEndPoint.X);
            var lengthY = Math.Abs(coordOfStartPoint.Y - coordOfEndPoint.Y);
            var normalizer = WageHelper(coordOfStartPoint, coordOfEndPoint, app);
            var lengthXPow = Math.Pow(lengthX, 2);
            var lengthYPow = Math.Pow(lengthY, 2);
            var sumOfLength = lengthXPow + lengthYPow;
            var result = Convert.ToInt32(Math.Sqrt(sumOfLength/2));
            return result;
        }

        public static int ClosestLengthForCross(MainApp app)
        {
            bool noWories;
            var coordOfStartPoint = LiteralFinder.FindThisLiteral(app.DataMatrix, Constants.START, out noWories);
            var coordOfEndPoint = LiteralFinder.FindThisLiteral(app.DataMatrix, Constants.END, out noWories);
            var lengthX = Math.Abs(coordOfStartPoint.X - coordOfEndPoint.X);
            var lengthY = Math.Abs(coordOfStartPoint.Y - coordOfEndPoint.Y);
            var normalizer = WageHelper(coordOfStartPoint, coordOfEndPoint, app);
            var lengthXPow = Math.Pow(lengthX, 2);
            var lengthYPow = Math.Pow(lengthY, 2);
            var sumOfLength = lengthXPow + lengthYPow;
            var result = Convert.ToInt32(Math.Sqrt(sumOfLength / 2));
            return result;
        }

        private static int WageHelper(Point coordOfStartPoint, Point coordOfEndPoint, MainApp app)
        {
            var dataMatrix = app.DataMatrix;
            var lengthX = coordOfStartPoint.X - coordOfEndPoint.X;
            var lengthY = coordOfStartPoint.Y - coordOfEndPoint.Y;
            var normalizer = 0;
            if (Math.Abs(lengthX) >= Math.Abs(lengthY) && Math.Abs(lengthX-lengthY) > 3)
            {
                if (coordOfStartPoint.X + 1 < dataMatrix.RowCount)
                {
                    if ((string) dataMatrix[coordOfStartPoint.X + 1, coordOfStartPoint.Y].Value
                        == Constants.DEFAULT_BLOCKER)
                    {
                        if (lengthX < 0)
                        {
                            normalizer++;
                        }
                    }
                }
                if (coordOfStartPoint.X - 1 < dataMatrix.RowCount && coordOfStartPoint.X - 1 >= 0)
                {
                    if ((string) dataMatrix[coordOfStartPoint.X - 1, coordOfStartPoint.Y].Value
                        == Constants.DEFAULT_BLOCKER)
                    {
                        if (lengthX >= 0)
                        {
                            normalizer++;
                        }
                    }
                }
                if (coordOfEndPoint.X + 1 < dataMatrix.RowCount)
                {
                    if ((string) dataMatrix[coordOfEndPoint.X + 1, coordOfEndPoint.Y].Value
                        == Constants.DEFAULT_BLOCKER)
                    {
                        if (lengthX >= 0)
                        {
                            normalizer++;
                        }
                    }
                }
                if (coordOfEndPoint.X - 1 < dataMatrix.RowCount && coordOfEndPoint.X - 1 >= 0)
                {
                    if ((string) dataMatrix[coordOfEndPoint.X - 1, coordOfEndPoint.Y].Value
                        == Constants.DEFAULT_BLOCKER)
                    {
                        if (lengthX < 0)
                        {
                            normalizer++;
                        }
                    }
                }
            }
            if (Math.Abs(lengthX) < Math.Abs(lengthY) && Math.Abs(lengthX - lengthY) > 3)
            {
                if (coordOfStartPoint.Y + 1 < dataMatrix.RowCount)
                {
                    if ((string) dataMatrix[coordOfStartPoint.X, coordOfStartPoint.Y + 1].Value ==
                        Constants.DEFAULT_BLOCKER)
                    {
                        if (lengthY < 0)
                        {
                            normalizer++;
                        }
                    }
                }
                if (coordOfStartPoint.Y - 1 < dataMatrix.RowCount && coordOfStartPoint.Y - 1 >= 0)
                {
                    if ((string) dataMatrix[coordOfStartPoint.X, coordOfStartPoint.Y - 1].Value ==
                        Constants.DEFAULT_BLOCKER)
                    {
                        if (lengthY >= 0)
                        {
                            normalizer++;
                        }
                    }
                }
                if (coordOfStartPoint.Y + 1 < dataMatrix.RowCount)
                {
                    if ((string) dataMatrix[coordOfStartPoint.X, coordOfStartPoint.Y + 1].Value ==
                        Constants.DEFAULT_BLOCKER)
                    {
                        if (lengthY >= 0)
                        {
                            normalizer++;
                        }
                    }
                }
                if (coordOfStartPoint.Y - 1 < dataMatrix.RowCount && coordOfStartPoint.Y - 1 >= 0)
                {
                    if ((string) dataMatrix[coordOfStartPoint.X, coordOfStartPoint.Y - 1].Value ==
                        Constants.DEFAULT_BLOCKER)
                    {
                        if (lengthY < 0)
                        {
                            normalizer++;
                        }
                    }
                }
            }

            return normalizer;
        }
    }
}
