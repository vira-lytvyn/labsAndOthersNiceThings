using System;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using DijkstraAlg.Managers;

namespace DijkstraAlg.Administrating
{
    public struct DrawBoxPoint
    {
        public int ID;
        public Point PointCoordinates;
    }
    public class MainDrawBoxManager
    {
        public MainApp MainApp { get; set; }
        public Graphics Graphics { get; set; }
        public MouseEventArgs MouseClick { get; set; }
        public bool IfClear { get; set; }
        public bool DrawPointChecked { get; set; }
    }
    public struct Edge
    {
        public int FirstPointId { get; set; }
        public int SecondPointId { get; set; }
        public int EdgeWage { get; set; }
    }
    public struct LabelCreator
    {
        public MainApp MainApp { get; set; }
        public DrawBoxPoint FirstPoint { get; set; }
        public DrawBoxPoint SecondPoint { get; set; }
        public int Wage { get; set; }
        public DrawBoxManager DrawBoxManager { get; set; }
        public Graphics Graphics { get; set; }
    }
}
