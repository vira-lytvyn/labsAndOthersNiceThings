using System;
using System.Collections.Generic;
using System.Drawing;

namespace WaveAlg.Helpers
{
    public class AddPath
    {
        public static void AddBestPath(MainApp app, List<Point> forDrawing)
        {
            var listOfResult = new List<int>();
            var dataMatrix = app.DataMatrix;
            var lastResult = new List<int>();
            for (var i = 0; i < dataMatrix.ColumnCount; i++)
            {
                for (var j = 0; j < dataMatrix.RowCount; j++)
                {
                    var current = -1;
                    try
                    {
                        current = Convert.ToInt32(dataMatrix.Rows[i].Cells[j].Value);
                        if (current == 0)
                        {
                            throw new Exception();
                        }
                    }
                    catch (Exception)
                    {
                       continue;
                    }
                    var indexOf = listOfResult.IndexOf(current);
                    if (indexOf == -1)
                    {
                        listOfResult.Add(current);
                    }
                }
            }
            lastResult.AddRange(listOfResult);
            for (int i = listOfResult.Count - 1; i > -1; i--)
            {
                var val = listOfResult[i];
                lastResult.Add(val);
            }
            
            foreach (var result in lastResult)
            {
                app.Path.Text += string.Format("{0} - ", result);
            }
        }
    }
}
