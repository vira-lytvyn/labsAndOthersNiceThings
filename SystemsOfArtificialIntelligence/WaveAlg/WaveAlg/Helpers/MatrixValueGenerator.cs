using System;
using System.Drawing;
using System.Windows.Forms;
using WaveAlg.Administrating;

namespace WaveAlg.Helpers
{
    public class MatrixValueGenerator
    {
        private readonly Random _randomizer = new Random();

        /// <summary>
        /// Generate our enter values for DataGridView
        /// </summary>
        /// <param name="dataMatrix">our DataGridView</param>
        /// <param name="optionalZeroRandomizer">optional zero randomizer from option form</param>
        /// <returns>new generated array of values</returns>
        public string[,] Generate(DataGridView dataMatrix, int optionalZeroRandomizer)
        {
            var result = new string[dataMatrix.ColumnCount,dataMatrix.RowCount];
            for (var i = 0; i < dataMatrix.ColumnCount; i++)
            {
                for (var j = 0; j < dataMatrix.RowCount; j++)
                {
                    var randomValue = _randomizer.Next(0, optionalZeroRandomizer);
                    if (randomValue > 0)
                    {
                        result[i, j] = string.Empty;
                        dataMatrix.Rows[i].Cells[j].Value = string.Empty;
                    }
                    else
                    {
                        result[i, j] = Constants.DEFAULT_BLOCKER;
                        dataMatrix.Rows[i].Cells[j].Value = result[i, j];
                    }
                }
            }
            result = SetStartAndEndPoint(result, dataMatrix);
            return result;
        }

        private Point GetStartEndPoint(int upperBound)
        {
            var point = new Point();
            var firstCoord = _randomizer.Next(0, upperBound);
            var secondCoord = _randomizer.Next(0, upperBound);
            point.X = firstCoord;
            point.Y = secondCoord;
            return point;
        }

        private string[,] SetStartAndEndPoint(string[,] result, DataGridView dataMatrix)
        {
            var firstPoint = GetStartEndPoint(dataMatrix.RowCount - 1);
            var secondPoint = GetStartEndPoint(dataMatrix.RowCount - 1);
            while (firstPoint.X == secondPoint.X && firstPoint.Y == secondPoint.Y)
            {
                firstPoint = GetStartEndPoint(dataMatrix.RowCount - 1);
                secondPoint = GetStartEndPoint(dataMatrix.RowCount - 1);
            }
            result[firstPoint.X, firstPoint.Y] = Constants.START;
            result[secondPoint.X, secondPoint.Y] = Constants.END;
            dataMatrix.Rows[firstPoint.X].Cells[firstPoint.Y].Value = Constants.START;
            dataMatrix.Rows[secondPoint.X].Cells[secondPoint.Y].Value = Constants.END;
            return result;
        }
    }
}
