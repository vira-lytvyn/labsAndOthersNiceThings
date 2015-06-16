using System;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace WaveAlg.Helpers
{
    public static class LiteralFinder
    {
        /// <summary>
        /// Find literal in DataGridView
        /// </summary>
        /// <param name="dataMatrix"> our DataGridView</param>
        /// <param name="findLiteral">literal what we must find</param>
        /// <param name="exist">check if point exist</param>
        /// <returns>point coordinates of this literal if it exist</returns>
        public static Point FindThisLiteral(DataGridView dataMatrix, string findLiteral, out bool exist)
        {
            var resultPoint = new Point();
            exist = false;
            for (var i = 0; i < dataMatrix.ColumnCount; i++)
            {
                for (var j = 0; j < dataMatrix.RowCount; j++)
                {
                    var currentValue = dataMatrix.Rows[i].Cells[j].Value;
                    try
                    {
                        if ((string)currentValue == findLiteral)
                        {
                            resultPoint.X = j;
                            resultPoint.Y = i;
                            exist = true;
                        }
                    }
                    catch (Exception)
                    {
                        continue;
                    }

                }
            }
            return resultPoint;
        }
    }
}
