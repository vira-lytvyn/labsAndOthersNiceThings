using System.Collections.Generic;
using System.Windows.Forms;
using DijkstraAlg.Administrating;

namespace DijkstraAlg.Helpers.Validators
{
    public static class PointManipulation
    {
        public static bool IsMatchSomePoint(MouseEventArgs mouseClick, List<DrawBoxPoint> listOfDrawBoxPoint)
        {
            var isMatchSomePoint = false;
            foreach (var currentPoint in listOfDrawBoxPoint)
            {
                var isCanAddThisPoint = IfCanAddThisPointForDrawLineOnIt(mouseClick, currentPoint);
                if (!isCanAddThisPoint) continue;
                isMatchSomePoint = true;
                break;
            }
            return isMatchSomePoint;
        }

        public static DrawBoxPoint GetMatchPoint(MouseEventArgs mouseClick, List<DrawBoxPoint> listOfDrawBoxPoint)
        {
            var matchPoint = new DrawBoxPoint();
            foreach (var currentPoint in listOfDrawBoxPoint)
            {
                var isCanAddThisPoint = IfCanAddThisPointForDrawLineOnIt(mouseClick, currentPoint);
                if (!isCanAddThisPoint) continue;
                matchPoint = currentPoint;
                break;
            }
            return matchPoint;
        }

        private static bool IfCanAddThisPointForDrawLineOnIt(MouseEventArgs mouseClick, DrawBoxPoint pointToCheck)
        {
            var currentPoint = pointToCheck.PointCoordinates;
            var maxOnX = currentPoint.X + Constants.DEFAULT_WIDTH_HEIGHT_SIZE_OF_POINT - Constants.STRING_ALLOCATOR;
            var minOnX = currentPoint.X - Constants.DEFAULT_WIDTH_HEIGHT_SIZE_OF_POINT - Constants.STRING_ALLOCATOR;
            var maxOnY = currentPoint.Y + Constants.DEFAULT_WIDTH_HEIGHT_SIZE_OF_POINT - Constants.STRING_ALLOCATOR;
            var minOnY = currentPoint.Y - Constants.DEFAULT_WIDTH_HEIGHT_SIZE_OF_POINT - Constants.STRING_ALLOCATOR;
            if (mouseClick.X > minOnX && mouseClick.X < maxOnX && mouseClick.Y > minOnY && mouseClick.Y < maxOnY)
            {
                return true;
            }
            return false;
        }
    }
}
