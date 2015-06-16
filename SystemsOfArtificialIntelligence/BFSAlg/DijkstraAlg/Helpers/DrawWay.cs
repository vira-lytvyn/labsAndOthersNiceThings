using System;
using System.Collections.Generic;
using System.Drawing;
using System.Globalization;
using System.Linq;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using DijkstraAlg.Administrating;

namespace DijkstraAlg.Helpers
{
    public class DrawWay
    {
        public static void Draw(Graphics graphics, Dictionary<long, Point> ourTree, List<long> result)
        {
            var counter = 1;
            foreach (var resultValue in result)
            {

                foreach (var variable in ourTree)
                {
                    if (resultValue == variable.Key)
                    {
                        Thread.CurrentThread.Join(1000);
                        graphics.DrawEllipse(Pens.Red, variable.Value.X - Constants.STRING_ALLOCATOR,
                            variable.Value.Y - Constants.STRING_ALLOCATOR,
                            Constants.DEFAULT_WIDTH_HEIGHT_SIZE_OF_POINT,
                            Constants.DEFAULT_WIDTH_HEIGHT_SIZE_OF_POINT);
                        graphics.DrawString(variable.Key.ToString(CultureInfo.InvariantCulture),
                            Constants.FONT_FOR_NUMBERS_IN_ELIPSES,
                            Brushes.Black, variable.Value.X, variable.Value.Y);
                        graphics.DrawString(counter.ToString(CultureInfo.InvariantCulture),
                            Constants.FONT_FOR_NUMBERS_IN_ELIPSES,
                            Brushes.Black, variable.Value.X + 40, variable.Value.Y);
                        counter++;
                    }
                }
                if (resultValue == Constants.result)
                {
                    break;
                }
            }
        }
    }
}
