using System;
using System.Collections.Generic;
using System.Drawing;
using System.Globalization;
using System.Windows.Forms;
using DijkstraAlg.Administrating;
using DijkstraAlg.HelperForms;
using DijkstraAlg.Managers;

namespace DijkstraAlg.Helpers.AddForms
{
    public static class AddWage
    {
        private static int _firstPointId;

        private static int _secondPointId;

        private static int _wage;

        private static DrawBoxManager _currentDrawBoxManager;

        public static Edge GetEdge(int firstPointId, int secondPointId)
        {
            var createWageForm = new Wage();
            createWageForm.ShowDialog();
            var edgeWage = GetWageFromForm.GetWage(createWageForm);
            var newEdge = new Edge { EdgeWage = edgeWage, FirstPointId = firstPointId, SecondPointId = secondPointId };
            return newEdge;
        }

        public static Point AddLabelToWage(LabelCreator creator)
        {
            _firstPointId = creator.FirstPoint.ID;
            _secondPointId = creator.SecondPoint.ID;
            _wage = creator.Wage;
            _currentDrawBoxManager = creator.DrawBoxManager;
            var coordXForNewLabel = (creator.FirstPoint.PointCoordinates.X + creator.SecondPoint.PointCoordinates.X) / 2;
            var coordYForNewLabel = (creator.FirstPoint.PointCoordinates.Y + creator.SecondPoint.PointCoordinates.Y) / 2;
            creator.Graphics.DrawString(creator.Wage.ToString(CultureInfo.InvariantCulture), Constants.FONT_FOR_NUMBERS_IN_ELIPSES, 
                Brushes.Red, coordXForNewLabel, coordYForNewLabel);
            var newPoint = new Point(coordXForNewLabel, coordYForNewLabel);
            return new Point();
        }

        private static void LabelOnClick(object sender, EventArgs eventArgs)
        {
            var updatedEdge = GetEdge(_firstPointId, _secondPointId);
            _wage = updatedEdge.EdgeWage;
            var id = 0;
            foreach (var currentEdge in _currentDrawBoxManager.ListOfEdges)
            {
                if (currentEdge.FirstPointId == updatedEdge.FirstPointId &&
                    currentEdge.SecondPointId == updatedEdge.SecondPointId)
                {
                    id = _currentDrawBoxManager.ListOfEdges.IndexOf(currentEdge);
                    break;
                }
            }
            var newEdge = new Edge {EdgeWage = _wage, FirstPointId = _firstPointId, SecondPointId = _secondPointId};
            _currentDrawBoxManager.ListOfEdges[id] = newEdge;

        }
    }
}
