using System;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Windows.Forms;
using WaveAlg.Administrating;
using WaveAlg.Helpers;
using WaveAlg.Helpers.Getters;

namespace WaveAlg.WayManipulation
{
    public class BestWayFinder
    {
        /// <summary>
        /// Find the best way
        /// </summary>
        /// <param name="app">our main window</param>
        public void FindBestWay(MainApp app)
        {
            var dataMatrix = app.DataMatrix;
            bool existStart;
            bool existEnd;
            var coordOfStartPoint = LiteralFinder.FindThisLiteral(app.DataMatrix, Constants.START, out existStart);
            var coordOfEndPoint = LiteralFinder.FindThisLiteral(app.DataMatrix, Constants.END, out existEnd);
            var firstList = new List<Point>();
            var listCollection = new List<List<Point>>();
            firstList.Add(coordOfEndPoint);
            listCollection.Add(firstList);
            var complete = false;
            var forDraw = new List<Point>();
            var onThisStateList = new List<BestWayPointStruct>();
            for (var i = 0; i < listCollection.Count; i++)
            {
                var newList = new List<Point>();
                //Thread.CurrentThread.Join(1000);
                foreach (var current in listCollection[i].ToList())
                {
                    if (GetNearPoint.IsNearToPoint(current, coordOfStartPoint))
                    {
                        complete = true;
                        break;
                    }
                    try
                    {
                        if (current.X + 1 < dataMatrix.RowCount)
                        {
                            if (StringAnalizator.IsThisStringCanConvertToNumber
                                ((string)dataMatrix[current.X + 1, current.Y].Value))
                            {
                                var newPoint = new Point(current.X + 1, current.Y);
                                var newValue = Convert.ToInt32(dataMatrix[current.X + 1, current.Y].Value);
                                var localStruct = new BestWayPointStruct {Point = newPoint, Value = newValue};
                                onThisStateList.Add(localStruct);
                            }
                        }
                        if (current.X - 1 < dataMatrix.RowCount && current.X - 1 >= 0)
                        {
                            if (StringAnalizator.IsThisStringCanConvertToNumber
                                ((string)dataMatrix[current.X - 1, current.Y].Value))
                            {
                                var newPoint = new Point(current.X - 1, current.Y);
                                var newValue = Convert.ToInt32(dataMatrix[current.X - 1, current.Y].Value);
                                var localStruct = new BestWayPointStruct { Point = newPoint, Value = newValue };
                                onThisStateList.Add(localStruct);
                            }
                        }
                        if (current.Y + 1 < dataMatrix.RowCount)
                        {
                            if (StringAnalizator.IsThisStringCanConvertToNumber
                                ((string)dataMatrix[current.X, current.Y + 1].Value))
                            {
                                var newPoint = new Point(current.X, current.Y + 1);
                                var newValue = Convert.ToInt32(dataMatrix[current.X, current.Y + 1].Value);
                                var localStruct = new BestWayPointStruct { Point = newPoint, Value = newValue };
                                onThisStateList.Add(localStruct);
                            }
                        }
                        if (current.Y - 1 < dataMatrix.RowCount && current.Y - 1 >= 0)
                        {
                            if (StringAnalizator.IsThisStringCanConvertToNumber
                                ((string)dataMatrix[current.X, current.Y - 1].Value))
                            {
                                var newPoint = new Point(current.X, current.Y - 1);
                                var newValue = Convert.ToInt32(dataMatrix[current.X, current.Y - 1].Value);
                                var localStruct = new BestWayPointStruct { Point = newPoint, Value = newValue };
                                onThisStateList.Add(localStruct);
                            }
                        }
                    }
                    catch (Exception)
                    {
                        MessageBox.Show(Constants.FIND_BEST_WAY_ERROR);
                    }
                    var min = onThisStateList.Select(variable => variable.Value).Concat(new[] {1000}).Min();
                    foreach (var variable in onThisStateList.Where(variable => variable.Value == min))
                    {
                        newList.Add(variable.Point);
                        forDraw.Add(variable.Point);
                    }
                    listCollection.Add(newList);
                    break;
                }
                if (complete)
                {
                    break;
                }
            }
            Draw(dataMatrix, app.GetColor, forDraw);
        }

        public void FindCrossBestWay(MainApp app)
        {
            var dataMatrix = app.DataMatrix;
            bool existStart;
            bool existEnd;
            var coordOfStartPoint = LiteralFinder.FindThisLiteral(app.DataMatrix, Constants.START, out existStart);
            var coordOfEndPoint = LiteralFinder.FindThisLiteral(app.DataMatrix, Constants.END, out existEnd);
            var firstList = new List<Point>();
            var listCollection = new List<List<Point>>();
            firstList.Add(coordOfEndPoint);
            listCollection.Add(firstList);
            var complete = false;
            var forDraw = new List<Point>();
            var onThisStateList = new List<BestWayPointStruct>();
            for (var i = 0; i < listCollection.Count; i++)
            {
                var newList = new List<Point>();
                //Thread.CurrentThread.Join(1000);
                foreach (var current in listCollection[i].ToList())
                {
                    if (GetNearPoint.IsNearToPoint(current, coordOfStartPoint))
                    {
                        complete = true;
                        break;
                    }
                    try
                    {
                        if (current.X + 1 < dataMatrix.RowCount)
                        {
                            if (StringAnalizator.IsThisStringCanConvertToNumber
                                ((string)dataMatrix[current.X + 1, current.Y].Value))
                            {
                                var newPoint = new Point(current.X + 1, current.Y);
                                var newValue = Convert.ToInt32(dataMatrix[current.X + 1, current.Y].Value);
                                var localStruct = new BestWayPointStruct { Point = newPoint, Value = newValue };
                                onThisStateList.Add(localStruct);
                            }
                        }
                        if (current.X - 1 < dataMatrix.RowCount && current.X - 1 >= 0)
                        {
                            if (StringAnalizator.IsThisStringCanConvertToNumber
                                ((string)dataMatrix[current.X - 1, current.Y].Value))
                            {
                                var newPoint = new Point(current.X - 1, current.Y);
                                var newValue = Convert.ToInt32(dataMatrix[current.X - 1, current.Y].Value);
                                var localStruct = new BestWayPointStruct { Point = newPoint, Value = newValue };
                                onThisStateList.Add(localStruct);
                            }
                        }
                        if (current.Y + 1 < dataMatrix.RowCount)
                        {
                            if (StringAnalizator.IsThisStringCanConvertToNumber
                                ((string)dataMatrix[current.X, current.Y + 1].Value))
                            {
                                var newPoint = new Point(current.X, current.Y + 1);
                                var newValue = Convert.ToInt32(dataMatrix[current.X, current.Y + 1].Value);
                                var localStruct = new BestWayPointStruct { Point = newPoint, Value = newValue };
                                onThisStateList.Add(localStruct);
                            }
                        }
                        if (current.Y - 1 < dataMatrix.RowCount && current.Y - 1 >= 0)
                        {
                            if (StringAnalizator.IsThisStringCanConvertToNumber
                                ((string)dataMatrix[current.X, current.Y - 1].Value))
                            {
                                var newPoint = new Point(current.X, current.Y - 1);
                                var newValue = Convert.ToInt32(dataMatrix[current.X, current.Y - 1].Value);
                                var localStruct = new BestWayPointStruct { Point = newPoint, Value = newValue };
                                onThisStateList.Add(localStruct);
                            }
                        }
                    }
                    catch (Exception)
                    {
                        MessageBox.Show(Constants.FIND_BEST_WAY_ERROR);
                    }
                    var min = onThisStateList.Select(variable => variable.Value).Concat(new[] { 1000 }).Min();
                    foreach (var variable in onThisStateList.Where(variable => variable.Value == min))
                    {
                        newList.Add(variable.Point);
                        forDraw.Add(variable.Point);
                    }
                    listCollection.Add(newList);
                    break;
                }
                if (complete)
                {
                    break;
                }
            }
            Draw(dataMatrix, app.GetColor, forDraw);
        }


        /// <summary>
        /// Find the best way
        /// </summary>
        /// <param name="app">our main window</param>
        public void FindCircleBestWay(MainApp app)
        {
            var dataMatrix = app.DataMatrix;
            bool existStart;
            bool existEnd;
            var coordOfStartPoint = LiteralFinder.FindThisLiteral(app.DataMatrix, Constants.START, out existStart);
            var coordOfEndPoint = LiteralFinder.FindThisLiteral(app.DataMatrix, Constants.END, out existEnd);
            var firstList = new List<Point>();
            var listCollection = new List<List<Point>>();
            firstList.Add(coordOfEndPoint);
            listCollection.Add(firstList);
            var complete = false;
            var forDraw = new List<Point>();
            var onThisStateList = new List<BestWayPointStruct>();
            for (var i = 0; i < listCollection.Count; i++)
            {
                var newList = new List<Point>();
                //Thread.CurrentThread.Join(1000);
                foreach (var current in listCollection[i].ToList())
                {
                    if (GetNearPoint.IsNearToPointWithCircleMethod(current, coordOfStartPoint))
                    {
                        complete = true;
                        break;
                    }
                    try
                    {
                        if (current.X + 1 < dataMatrix.RowCount)
                        {
                            if (StringAnalizator.IsThisStringCanConvertToNumber
                                ((string)dataMatrix[current.X + 1, current.Y].Value))
                            {
                                var newPoint = new Point(current.X + 1, current.Y);
                                var newValue = Convert.ToInt32(dataMatrix[current.X + 1, current.Y].Value);
                                var localStruct = new BestWayPointStruct { Point = newPoint, Value = newValue };
                                onThisStateList.Add(localStruct);
                            }
                        }
                        if (current.X - 1 < dataMatrix.RowCount && current.X - 1 >= 0)
                        {
                            if (StringAnalizator.IsThisStringCanConvertToNumber
                                ((string)dataMatrix[current.X - 1, current.Y].Value))
                            {
                                var newPoint = new Point(current.X - 1, current.Y);
                                var newValue = Convert.ToInt32(dataMatrix[current.X - 1, current.Y].Value);
                                var localStruct = new BestWayPointStruct { Point = newPoint, Value = newValue };
                                onThisStateList.Add(localStruct);
                            }
                        }
                        if (current.Y + 1 < dataMatrix.RowCount)
                        {
                            if (StringAnalizator.IsThisStringCanConvertToNumber
                                ((string)dataMatrix[current.X, current.Y + 1].Value))
                            {
                                var newPoint = new Point(current.X, current.Y + 1);
                                var newValue = Convert.ToInt32(dataMatrix[current.X, current.Y + 1].Value);
                                var localStruct = new BestWayPointStruct { Point = newPoint, Value = newValue };
                                onThisStateList.Add(localStruct);
                            }
                        }
                        if (current.Y - 1 < dataMatrix.RowCount && current.Y - 1 >= 0)
                        {
                            if (StringAnalizator.IsThisStringCanConvertToNumber
                                ((string)dataMatrix[current.X, current.Y - 1].Value))
                            {
                                var newPoint = new Point(current.X, current.Y - 1);
                                var newValue = Convert.ToInt32(dataMatrix[current.X, current.Y - 1].Value);
                                var localStruct = new BestWayPointStruct { Point = newPoint, Value = newValue };
                                onThisStateList.Add(localStruct);
                            }
                        }

                        if (current.X + 1 < dataMatrix.RowCount && current.Y + 1 < dataMatrix.RowCount)
                        {
                            if (StringAnalizator.IsThisStringCanConvertToNumber
                                 ((string)dataMatrix[current.X + 1, current.Y + 1].Value))
                            {
                                var newPoint = new Point(current.X + 1, current.Y + 1);
                                var newValue = Convert.ToInt32(dataMatrix[current.X + 1, current.Y + 1].Value);
                                var localStruct = new BestWayPointStruct { Point = newPoint, Value = newValue };
                                onThisStateList.Add(localStruct);
                            }
                        }

                        if (current.X + 1 < dataMatrix.RowCount &&
                            current.Y - 1 < dataMatrix.RowCount && current.Y - 1 >= 0)
                        {
                            if (StringAnalizator.IsThisStringCanConvertToNumber
                                ((string)dataMatrix[current.X + 1, current.Y - 1].Value))
                            {
                                var newPoint = new Point(current.X + 1, current.Y - 1);
                                var newValue = Convert.ToInt32(dataMatrix[current.X + 1, current.Y - 1].Value);
                                var localStruct = new BestWayPointStruct { Point = newPoint, Value = newValue };
                                onThisStateList.Add(localStruct);
                            }
                        }

                        if (current.X - 1 < dataMatrix.RowCount &&
                           current.Y + 1 < dataMatrix.RowCount && current.X - 1 >= 0)
                        {
                            if (StringAnalizator.IsThisStringCanConvertToNumber
                                   ((string)dataMatrix[current.X - 1, current.Y + 1].Value))
                            {
                                var newPoint = new Point(current.X - 1, current.Y + 1);
                                var newValue = Convert.ToInt32(dataMatrix[current.X - 1, current.Y + 1].Value);
                                var localStruct = new BestWayPointStruct { Point = newPoint, Value = newValue };
                                onThisStateList.Add(localStruct);
                            }
                        }



                        if (current.X - 1 < dataMatrix.RowCount && current.X - 1 >= 0 &&
                            current.Y - 1 < dataMatrix.RowCount && current.Y - 1 >= 0)
                        {
                            if (StringAnalizator.IsThisStringCanConvertToNumber
                                ((string)dataMatrix[current.X - 1, current.Y - 1].Value))
                            {
                                var newPoint = new Point(current.X - 1, current.Y - 1);
                                var newValue = Convert.ToInt32(dataMatrix[current.X - 1, current.Y - 1].Value);
                                var localStruct = new BestWayPointStruct { Point = newPoint, Value = newValue };
                                onThisStateList.Add(localStruct);
                            }
                        }
                    }
                    catch (Exception)
                    {
                        MessageBox.Show(Constants.FIND_BEST_WAY_ERROR);
                    }
                    var min = onThisStateList.Select(variable => variable.Value).Concat(new[] { 1000 }).Min();
                    foreach (var variable in onThisStateList.Where(variable => variable.Value == min))
                    {
                        newList.Add(variable.Point);
                        forDraw.Add(variable.Point);
                    }
                    listCollection.Add(newList);
                    break;
                }
                if (complete)
                {
                    break;
                }
            }
            Draw(dataMatrix, app.GetColor, forDraw);
        }
        /// <summary>
        /// Draw our best way
        /// </summary>
        /// <param name="dataMatrix">our DataGridView</param>
        /// <param name="color">color in what we want draw</param> (ForeColor)
        /// <param name="forDraw">list of point what we want Draw</param> 
        private void Draw(DataGridView dataMatrix, Color color, IEnumerable<Point> forDraw)
        {
            foreach (var point in forDraw)
            {
                dataMatrix[point.X, point.Y].Style.BackColor = color;
            }
        }
    }
}
