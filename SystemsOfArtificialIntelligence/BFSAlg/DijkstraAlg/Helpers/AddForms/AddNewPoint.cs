using System.Drawing;
using System.Globalization;
using System.Windows.Forms;
using DijkstraAlg.Administrating;

namespace DijkstraAlg.Helpers.AddForms
{
    public class AddNewPoint
    {
        public static DrawBoxPoint AddNewPointToDrawBox(Graphics graphics, MouseEventArgs mouseClick, int currentPointCount)
        {
            graphics.DrawEllipse(Pens.Black, mouseClick.X - Constants.STRING_ALLOCATOR,
                mouseClick.Y - Constants.STRING_ALLOCATOR, 
                Constants.DEFAULT_WIDTH_HEIGHT_SIZE_OF_POINT, Constants.DEFAULT_WIDTH_HEIGHT_SIZE_OF_POINT);
            graphics.DrawString(currentPointCount.ToString(CultureInfo.InvariantCulture), Constants.FONT_FOR_NUMBERS_IN_ELIPSES,
                Brushes.Black, mouseClick.X, mouseClick.Y);
            var drawBoxPoint = new DrawBoxPoint
            {
                ID = currentPointCount,
                PointCoordinates = new Point(mouseClick.X , mouseClick.Y)
            };
            return drawBoxPoint;
        }
    }
}
