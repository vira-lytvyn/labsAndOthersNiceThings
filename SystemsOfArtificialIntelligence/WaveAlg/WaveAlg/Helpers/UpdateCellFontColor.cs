using System.Drawing;
using System.Windows.Forms;

namespace WaveAlg.Helpers
{
    public static class UpdateCellFontColor
    {
        /// <summary>
        /// Update all our Cell font Color
        /// </summary>
        /// <param name="color">color in what we want change fonr</param>
        /// <param name="dataMatrix">our DataGridView</param>  ForeColor
        public static void UpdateFontColor(Color color, DataGridView dataMatrix)
        {
            for (var i = 0; i < dataMatrix.ColumnCount; i++)
            {
                for (var j = 0; j < dataMatrix.RowCount; j++)
                {
                    dataMatrix.Rows[i].Cells[j].Style.ForeColor = color;
                }
            }
        }
    }
}
