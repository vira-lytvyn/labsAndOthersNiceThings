using System;
using System.Collections.Generic;
using WaveAlg.Administrating;

namespace WaveAlg.Helpers
{
    public class DoubleWaveAlgUpdater
    {
        public static void UpdateCells(MainApp app, int result)
        {
            var dataMatrix = app.DataMatrix;
            DeleteUnusedValues(app, result);
            var listOurValues = new List<int>();
            var lowList = new List<int>();
            var bigList = new List<int>();
            var medianValue = result/2;
            for (var counter = 1; counter < result; counter++)
            {
                if (counter <= medianValue)
                {
                    lowList.Add(counter);
                }
                else
                {
                    bigList.Add(counter);
                }
            }
            bigList.Reverse();
            for (var i = 0; i < dataMatrix.ColumnCount; i++)
            {
                for (var j = 0; j < dataMatrix.RowCount; j++)
                {
                    var currentValue = 0;
                    try
                    {
                        currentValue = Convert.ToInt32(dataMatrix.Rows[i].Cells[j].Value);
                        if (currentValue == 0)
                        {
                            throw new Exception();
                        }
                    }
                    catch (Exception)
                    {
                        continue;
                    }
                    if (currentValue > medianValue)
                    {
                        var getIndex = bigList.IndexOf(currentValue);
                        dataMatrix.Rows[i].Cells[j].Value = lowList[getIndex];
                    }
                }
            }
            if (result%2 == 0)
            {
                app.BestResult.Text = (result/2).ToString();
            }
            else
            {
                var bestResult = (result/2) + 1;
                app.BestResult.Text = bestResult.ToString();
            }

        }

        private static void DeleteUnusedValues(MainApp app, int result)
        {
            var dataMatrix = app.DataMatrix;
            for (var i = 0; i < dataMatrix.ColumnCount; i++)
            {
                for (var j = 0; j < dataMatrix.RowCount; j++)
                {
                    var currentValue = 0;
                    try
                    {
                        currentValue = Convert.ToInt32(dataMatrix.Rows[i].Cells[j].Value);
                        if (currentValue == result)
                        {
                            dataMatrix.Rows[i].Cells[j].Value = string.Empty;

                        }
                    }
                    catch (Exception)
                    {
                        continue;
                    }
                }
            }
        }
    }
}
