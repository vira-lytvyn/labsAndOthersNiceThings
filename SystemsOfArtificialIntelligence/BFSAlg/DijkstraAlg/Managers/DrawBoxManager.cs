using System.Collections.Generic;
using System.Drawing;
using System.Globalization;
using System.Windows.Forms;
using DijkstraAlg.Administrating;
using DijkstraAlg.Helpers.AddForms;
using DijkstraAlg.Helpers.Validators;

namespace DijkstraAlg.Managers
{
    public class DrawBoxManager
    {
        private int CurrentPointCount { get; set; }

        private List<DrawBoxPoint> ListOfDrawBoxPoint = new List<DrawBoxPoint>();

        public List<Edge> ListOfEdges = new List<Edge>(); 

        private int CreatePointPair { get; set; }

        private DrawBoxPoint _firstPoint;

        private DrawBoxPoint _secondPoint;

        public void MainManager(MainDrawBoxManager mainDrawBoxManager)
        {
            if (mainDrawBoxManager.IfClear)
            {
                CurrentPointCount = 0;
            }

            if (mainDrawBoxManager.DrawPointChecked)
            {

                ManagePoint(mainDrawBoxManager.Graphics, mainDrawBoxManager.MouseClick);

            }
            else
            {
                if (ListOfDrawBoxPoint.Count == 0)
                {
                    MessageBox.Show(Constants.ERROR_WE_HAVE_NO_POINTS);
                }
                else
                {
                    ManageLines(mainDrawBoxManager.MainApp, mainDrawBoxManager.Graphics, mainDrawBoxManager.MouseClick);
                }
            }
        }

        private void ManagePoint(Graphics graphics, MouseEventArgs mouseClick)
        {
            CurrentPointCount++;
            var newDrawBoxPoint = AddNewPoint.AddNewPointToDrawBox(graphics, mouseClick, CurrentPointCount);
            ListOfDrawBoxPoint.Add(newDrawBoxPoint);
        }

        private void ManageLines(MainApp app, Graphics graphics, MouseEventArgs mouseClick)
        {
            var isMatchSomePoint = PointManipulation.IsMatchSomePoint(mouseClick, ListOfDrawBoxPoint);
            var matchPoint = new DrawBoxPoint();
            if (isMatchSomePoint)
            {
                matchPoint = PointManipulation.GetMatchPoint(mouseClick, ListOfDrawBoxPoint);
                CreatePointPair++;
                if (CreatePointPair == 1)
                {
                    _firstPoint = matchPoint;
                }
                else if (CreatePointPair == 2)
                {
                    _secondPoint = matchPoint;
                }
            }
            if (CreatePointPair == 1)
            {
                //app.CurrentPoint.Text = isMatchSomePoint ? matchPoint.ID.ToString(CultureInfo.InvariantCulture)
                //    : Constants.CURRENT_POINT_DEFAULT;
            }
            if (CreatePointPair == 2)
            {
                AddLineSequence.AddLine(graphics, _firstPoint, _secondPoint);
                //app.CurrentPoint.Text = Constants.CURRENT_POINT_DEFAULT;
                var newEdge = AddWage.GetEdge(_firstPoint.ID, _secondPoint.ID);
                ListOfEdges.Add(newEdge);
                var creator = new LabelCreator
                {
                    DrawBoxManager = this,
                    FirstPoint = _firstPoint,
                    SecondPoint = _secondPoint,
                    MainApp = app,
                    Wage = newEdge.EdgeWage,
                    Graphics = graphics
                };
                AddWage.AddLabelToWage(creator);
                CreatePointPair = 0;
            }

        }
    }
}
