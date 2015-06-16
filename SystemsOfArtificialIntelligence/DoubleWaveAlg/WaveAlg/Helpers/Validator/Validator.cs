using System.Drawing;
using System.Windows.Forms;
using WaveAlg.Administrating;
using WaveAlg.Interfaces;

namespace WaveAlg.Helpers.Validator
{
    public class Validator : IValidator
    {
        public bool IsValidForFindBestWay(MainApp app)
        {
            var isValid = false;
            bool existStart;
            bool existEnd;
            var coordOfStartPoint = LiteralFinder.FindThisLiteral(app.DataMatrix, Constants.START, out existStart);
            var coordOfEndPoint = LiteralFinder.FindThisLiteral(app.DataMatrix, Constants.END, out existEnd);
            if (existStart && existEnd)
            {
                isValid = true;
            }
            return isValid;
        }

        public bool IsValidForDrawing(MainApp app)
        {
            var isValid = false;
            bool existStart;
            bool existEnd;
            var coordOfStartPoint = LiteralFinder.FindThisLiteral(app.DataMatrix, Constants.START, out existStart);
            var coordOfEndPoint = LiteralFinder.FindThisLiteral(app.DataMatrix, Constants.END, out existEnd);
            var haveWeSomeNumbersNearStart = IsNearSomeNumbers(app.DataMatrix, coordOfStartPoint);
            var haveWeSomeNumbersNearEnd = IsNearSomeNumbers(app.DataMatrix, coordOfEndPoint);
            if (haveWeSomeNumbersNearStart && haveWeSomeNumbersNearEnd)
            {
                isValid = true;
            }
            return isValid;
        }

        public bool IsNearOnlyZeroes(MainApp app, Point pointTocheck)
        {
            var dataMatrix = app.DataMatrix;
            if (pointTocheck.X + 1 < dataMatrix.RowCount)
            {
                if ((string)dataMatrix[pointTocheck.X + 1, pointTocheck.Y].Value != "0")
                {
                    return false;
                }
            }
            if (pointTocheck.X - 1 < dataMatrix.RowCount && pointTocheck.X - 1 >= 0)
            {
                if ((string)dataMatrix[pointTocheck.X - 1, pointTocheck.Y].Value != "0")
                {
                    return false;
                }
            }
            if (pointTocheck.Y + 1 < dataMatrix.RowCount)
            {
                if ((string)dataMatrix[pointTocheck.X, pointTocheck.Y + 1].Value != "0")
                {
                    return false;
                }
            }
            if (pointTocheck.Y - 1 < dataMatrix.RowCount && pointTocheck.Y - 1 >= 0)
            {
                if ((string)dataMatrix[pointTocheck.X, pointTocheck.Y - 1].Value != "0")
                {
                    return false;
                }
            }
            return true;
        }

        public bool ExistDublicatesControlWords(MainApp app)
        {
            var dataMatrix = app.DataMatrix;
            var sCounter = 0;
            var eCounter = 0;
            for (var i = 0; i < dataMatrix.ColumnCount; i++)
            {
                for (var j = 0; j < dataMatrix.RowCount; j++)
                {
                    if ((string) dataMatrix.Rows[i].Cells[j].Value == Constants.START)
                    {
                        sCounter++;
                    }
                    if ((string)dataMatrix.Rows[i].Cells[j].Value == Constants.END)
                    {
                        eCounter++;
                    }
                    if (sCounter > 1 || eCounter > 1)
                    {
                        return true;
                    }
                }
            }
            return false;
        }

        private bool IsNearSomeNumbers(DataGridView dataMatrix, Point pointTocheck)
        {
            if (pointTocheck.X + 1 < dataMatrix.RowCount)
            {
                if (StringAnalizator.IsThisStringCanConvertToNumber
                    ((string)dataMatrix[pointTocheck.X + 1, pointTocheck.Y].Value))
                {
                    return true;
                }
            }
            if (pointTocheck.X - 1 < dataMatrix.RowCount && pointTocheck.X - 1 >= 0)
            {
                if (StringAnalizator.IsThisStringCanConvertToNumber
                    ((string)dataMatrix[pointTocheck.X - 1, pointTocheck.Y].Value))
                {
                    return true;
                }
            }
            if (pointTocheck.Y + 1 < dataMatrix.RowCount)
            {
                if (StringAnalizator.IsThisStringCanConvertToNumber
                    ((string)dataMatrix[pointTocheck.X, pointTocheck.Y + 1].Value))
                {
                    return true;
                }
            }
            if (pointTocheck.Y - 1 < dataMatrix.RowCount && pointTocheck.Y - 1 >= 0)
            {
                if (StringAnalizator.IsThisStringCanConvertToNumber
                    ((string)dataMatrix[pointTocheck.X, pointTocheck.Y - 1].Value))
                {
                    return true;
                }
            }
            return false;
        }
    }
}
