using System;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace WaveAlg.Helpers
{
    public static class ClearFieldMatrix
    {
        public static void Clear(MainApp app)
        {
            var dataMatrix = app.DataMatrix;
            for (var i = 0; i < dataMatrix.ColumnCount; i++)
            {
                for (var j = 0; j < dataMatrix.RowCount; j++)
                {
                    dataMatrix.Rows[i].Cells[j].Value = "";
                    dataMatrix.Rows[i].Cells[j].Style.BackColor = Color.White;
                }
            }
        }
    }
}
