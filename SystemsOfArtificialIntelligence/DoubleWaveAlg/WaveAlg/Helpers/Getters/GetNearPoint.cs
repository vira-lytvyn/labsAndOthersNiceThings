using System;
using System.Drawing;

namespace WaveAlg.Helpers.Getters
{
    public static class GetNearPoint
    {
        /// <summary>
        /// Find if we near some Value
        /// </summary>
        /// <param name="current">current point what we send</param>
        /// <param name="coordOfPoint">ideal point</param>
        /// <returns>value true if we near ideal point</returns>
        public static bool IsNearToPoint(Point current, Point coordOfPoint)
        {
            if (current.X + 1 == coordOfPoint.X && current.Y == coordOfPoint.Y)
            {
                return true;
            }
            if (current.X - 1 == coordOfPoint.X && current.Y == coordOfPoint.Y)
            {
                return true;
            }
            if (current.X == coordOfPoint.X && current.Y - 1 == coordOfPoint.Y)
            {
                return true;
            }
            if (current.X == coordOfPoint.X && current.Y + 1 == coordOfPoint.Y)
            {
                return true;
            }
            return false;
        }


        /// <summary>
        /// Find if we near some Value
        /// </summary>
        /// <param name="current">current point what we send</param>
        /// <param name="coordOfPoint">ideal point</param>
        /// <returns>value true if we near ideal point</returns>
        public static bool IsNearToPointWithCircleMethod(Point current, Point coordOfPoint)
        {
            if (current.X + 1 == coordOfPoint.X && current.Y == coordOfPoint.Y)
            {
                return true;
            }
            if (current.X - 1 == coordOfPoint.X && current.Y == coordOfPoint.Y)
            {
                return true;
            }
            if (current.X == coordOfPoint.X && current.Y - 1 == coordOfPoint.Y)
            {
                return true;
            }
            if (current.X == coordOfPoint.X && current.Y + 1 == coordOfPoint.Y)
            {
                return true;
            }
            if (current.X + 1 == coordOfPoint.X && current.Y + 1 == coordOfPoint.Y)
            {
                return true;
            }
            if (current.X + 1 == coordOfPoint.X && current.Y - 1 == coordOfPoint.Y)
            {
                return true;
            }
            if (current.X - 1 == coordOfPoint.X && current.Y - 1 == coordOfPoint.Y)
            {
                return true;
            }
            if (current.X - 1 == coordOfPoint.X && current.Y + 1 == coordOfPoint.Y)
            {
                return true;
            }

            return false;
        }

        public static bool IsNearNumber(Point current, Point coordOfPoint, MainApp app)
        {
            var matrix = app.DataMatrix;

            if (current.X + 1 == coordOfPoint.X && current.Y == coordOfPoint.Y)
            {
                try
                {
                    var currentValue = Convert.ToInt32(matrix.Rows[current.X + 1].Cells[current.Y].Value);
                    if(currentValue != 0)
                    return true;
                }
                catch (Exception)
                {
                    return false;
                }
            }
            if (current.X - 1 == coordOfPoint.X && current.Y == coordOfPoint.Y)
            {
                try
                {
                    var currentValue = Convert.ToInt32(matrix.Rows[current.X + 1].Cells[current.Y].Value);
                    if (currentValue != 0)
                        return true;
                }
                catch (Exception)
                {
                    return false;
                }
            }
            if (current.X == coordOfPoint.X && current.Y - 1 == coordOfPoint.Y)
            {
                try
                {
                    var currentValue = Convert.ToInt32(matrix.Rows[current.X + 1].Cells[current.Y].Value);
                    if (currentValue != 0)
                        return true;
                }
                catch (Exception)
                {
                    return false;
                }
            }
            if (current.X == coordOfPoint.X && current.Y + 1 == coordOfPoint.Y)
            {
                try
                {
                    var currentValue = Convert.ToInt32(matrix.Rows[current.X + 1].Cells[current.Y].Value);
                    if (currentValue != 0)
                        return true;
                }
                catch (Exception)
                {
                    return false;
                }
            }
            return false;
        }
    }
}
