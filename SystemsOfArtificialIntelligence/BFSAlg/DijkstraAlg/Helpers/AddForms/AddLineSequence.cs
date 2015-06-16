using System.Drawing;
using DijkstraAlg.Administrating;

namespace DijkstraAlg.Helpers.AddForms
{
    public static class AddLineSequence
    {
        public static void AddLine(Graphics graphics, DrawBoxPoint firstDrawBoxPoint, DrawBoxPoint secondDrawBoxPoint)
        {
            graphics.DrawLine(Pens.Black, firstDrawBoxPoint.PointCoordinates.X, firstDrawBoxPoint.PointCoordinates.Y, 
                secondDrawBoxPoint.PointCoordinates.X, secondDrawBoxPoint.PointCoordinates.Y);
        }
    }
}
