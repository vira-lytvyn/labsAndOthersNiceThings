using System;
using System.Collections.Generic;
using System.Drawing;
using System.Globalization;
using System.Linq;
using System.Windows.Forms;
using WaveAlg.Administrating;
using WaveAlg.Helpers;
using WaveAlg.Helpers.Getters;
using WaveAlg.Helpers.Validator;

namespace WaveAlg.WayManipulation
{
    public class FindWay
    {
        /// <summary>
        /// Find all ways to End point
        /// </summary>
        /// <param name="app">our app</param>
        /// <returns>best way</returns>
        public int FindWayFromStoEWithCross(MainApp app)
        {
            var firstList = new List<Point>();
            var validator = new Validator();
            var listCollection = new List<List<Point>>();
            bool existStart;
            bool existEnd;
            var coordOfStartPoint = LiteralFinder.FindThisLiteral(app.DataMatrix, Constants.START, out existStart);
            var coordOfEndPoint = LiteralFinder.FindThisLiteral(app.DataMatrix, Constants.END, out existEnd);
            var dataMatrix = app.DataMatrix;
            firstList.Add(coordOfStartPoint);
            listCollection.Add(firstList);
            var complete = false;
            var counter = 1;
            try
            {
                if (existStart == false || existEnd == false || validator.IsNearOnlyZeroes(app, coordOfStartPoint))
                {
                    throw new WaveBaseException();
                }
            }
            catch (WaveBaseException)
            {

            }

            for (var i = 0; i < listCollection.Count; i++)
            {
                var newList = new List<Point>();
                //Thread.CurrentThread.Join(1000);
                foreach (var current in listCollection[i].ToList())
                {
                    if (GetNearPoint.IsNearToPoint(current, coordOfEndPoint))
                    {
                        complete = true;
                        break;
                    }
                    try
                    {
                        if (current.X + 1 < dataMatrix.RowCount)
                        {
                            if ((string) dataMatrix[current.X + 1, current.Y].Value == string.Empty)
                            {
                                dataMatrix[current.X + 1, current.Y].Value =
                                    counter.ToString(CultureInfo.InvariantCulture);
                                var newPoint = new Point(current.X + 1, current.Y);
                                newList.Add(newPoint);
                            }
                        }
                        if (current.X - 1 < dataMatrix.RowCount && current.X - 1 >= 0)
                        {
                            if ((string) dataMatrix[current.X - 1, current.Y].Value == string.Empty)
                            {
                                dataMatrix[current.X - 1, current.Y].Value =
                                    counter.ToString(CultureInfo.InvariantCulture);
                                var newPoint = new Point(current.X - 1, current.Y);
                                newList.Add(newPoint);
                            }
                        }
                        if (current.Y + 1 < dataMatrix.RowCount)
                        {
                            if ((string) dataMatrix[current.X, current.Y + 1].Value == string.Empty)
                            {
                                dataMatrix[current.X, current.Y + 1].Value =
                                    counter.ToString(CultureInfo.InvariantCulture);
                                var newPoint = new Point(current.X, current.Y + 1);
                                newList.Add(newPoint);
                            }
                        }
                        if (current.Y - 1 < dataMatrix.RowCount && current.Y - 1 >= 0)
                        {
                            if ((string) dataMatrix[current.X, current.Y - 1].Value == string.Empty)
                            {
                                dataMatrix[current.X, current.Y - 1].Value =
                                    counter.ToString(CultureInfo.InvariantCulture);
                                var newPoint = new Point(current.X, current.Y - 1);
                                newList.Add(newPoint);
                            }
                        }
                    }
                    catch (Exception)
                    {
                        MessageBox.Show(Constants.CALCULATING_ERROR);
                    }
                    var lastIndex = listCollection[i].Count - 1;
                    if (listCollection[i][lastIndex] != current) continue;
                    listCollection.Add(newList);
                    break;
                }
                if (complete)
                {
                    break;
                }
                counter++;
            }
            return counter;
        }

        /// <summary>
        /// Find all ways to End point
        /// </summary>
        /// <param name="app">our app</param>
        /// <returns>best way</returns>
        public int FindWayFromStoEWithCircle(MainApp app)
        {
            var firstList = new List<Point>();
            var validator = new Validator();
            var listCollection = new List<List<Point>>();
            bool existStart;
            bool existEnd;
            var coordOfStartPoint = LiteralFinder.FindThisLiteral(app.DataMatrix, Constants.START, out existStart);
            var coordOfEndPoint = LiteralFinder.FindThisLiteral(app.DataMatrix, Constants.END, out existEnd);
            var dataMatrix = app.DataMatrix;
            firstList.Add(coordOfStartPoint);
            listCollection.Add(firstList);
            var complete = false;
            var counter = 1;
            try
            {
                if (existStart == false || existEnd == false || validator.IsNearOnlyZeroes(app, coordOfStartPoint))
                {
                    throw new WaveBaseException();
                }
            }
            catch (WaveBaseException)
            {

            }

            for (var i = 0; i < listCollection.Count; i++)
            {
                var newList = new List<Point>();
                //Thread.CurrentThread.Join(1000);
                foreach (var current in listCollection[i].ToList())
                {
                    if (GetNearPoint.IsNearToPoint(current, coordOfEndPoint))
                    {
                        complete = true;
                        break;
                    }
                    try
                    {
                        if (current.X + 1 < dataMatrix.RowCount)
                        {
                            if ((string)dataMatrix[current.X + 1, current.Y].Value == string.Empty)
                            {
                                dataMatrix[current.X + 1, current.Y].Value =
                                    counter.ToString(CultureInfo.InvariantCulture);
                                var newPoint = new Point(current.X + 1, current.Y);
                                newList.Add(newPoint);
                            }
                        }

                        if (current.X - 1 < dataMatrix.RowCount && current.X - 1 >= 0)
                        {
                            if ((string)dataMatrix[current.X - 1, current.Y].Value == string.Empty)
                            {
                                dataMatrix[current.X - 1, current.Y].Value =
                                    counter.ToString(CultureInfo.InvariantCulture);
                                var newPoint = new Point(current.X - 1, current.Y);
                                newList.Add(newPoint);
                            }
                        }
                        if (current.Y + 1 < dataMatrix.RowCount)
                        {
                            if ((string)dataMatrix[current.X, current.Y + 1].Value == string.Empty)
                            {
                                dataMatrix[current.X, current.Y + 1].Value =
                                    counter.ToString(CultureInfo.InvariantCulture);
                                var newPoint = new Point(current.X, current.Y + 1);
                                newList.Add(newPoint);
                            }
                        }
                        if (current.Y - 1 < dataMatrix.RowCount && current.Y - 1 >= 0)
                        {
                            if ((string)dataMatrix[current.X, current.Y - 1].Value == string.Empty)
                            {
                                dataMatrix[current.X, current.Y - 1].Value =
                                    counter.ToString(CultureInfo.InvariantCulture);
                                var newPoint = new Point(current.X, current.Y - 1);
                                newList.Add(newPoint);
                            }
                        }

                        if (current.X + 1 < dataMatrix.RowCount && current.Y + 1 < dataMatrix.RowCount)
                        {
                            if ((string)dataMatrix[current.X + 1, current.Y + 1].Value == string.Empty)
                            {
                                dataMatrix[current.X + 1, current.Y + 1].Value =
                                    counter.ToString(CultureInfo.InvariantCulture);
                                var newPoint = new Point(current.X + 1, current.Y + 1);
                                newList.Add(newPoint);
                            }
                        }

                        if (current.X + 1 < dataMatrix.RowCount &&
                            current.Y - 1 < dataMatrix.RowCount && current.Y - 1 >= 0)
                        {
                            if ((string)dataMatrix[current.X + 1, current.Y - 1].Value == string.Empty)
                            {
                                dataMatrix[current.X + 1, current.Y - 1].Value =
                                    counter.ToString(CultureInfo.InvariantCulture);
                                var newPoint = new Point(current.X + 1, current.Y - 1);
                                newList.Add(newPoint);
                            }
                        }

                        if (current.X - 1 < dataMatrix.RowCount &&
                           current.Y + 1 < dataMatrix.RowCount && current.X - 1 >= 0)
                        {
                            if ((string)dataMatrix[current.X - 1, current.Y + 1].Value == string.Empty)
                            {
                                dataMatrix[current.X - 1, current.Y + 1].Value =
                                    counter.ToString(CultureInfo.InvariantCulture);
                                var newPoint = new Point(current.X - 1, current.Y + 1);
                                newList.Add(newPoint);
                            }
                        }



                        if (current.X - 1 < dataMatrix.RowCount && current.X - 1 >= 0 &&
                            current.Y - 1 < dataMatrix.RowCount && current.Y - 1 >= 0)
                        {
                            if ((string)dataMatrix[current.X - 1, current.Y - 1].Value == string.Empty)
                            {
                                dataMatrix[current.X - 1, current.Y - 1].Value =
                                    counter.ToString(CultureInfo.InvariantCulture);
                                var newPoint = new Point(current.X - 1, current.Y - 1);
                                newList.Add(newPoint);
                            }
                        }
                    }
                    catch (Exception)
                    {
                        MessageBox.Show(Constants.CALCULATING_ERROR);
                    }
                    var lastIndex = listCollection[i].Count - 1;
                    if (listCollection[i][lastIndex] != current) continue;
                    listCollection.Add(newList);
                    break;
                }
                if (complete)
                {
                    break;
                }
                counter++;
            }
            return counter;
        }
    }
}


