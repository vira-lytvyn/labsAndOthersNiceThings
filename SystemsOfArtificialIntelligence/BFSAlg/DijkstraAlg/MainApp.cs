using System;
using System.Drawing;
using System.Windows.Forms;
using DijkstraAlg.Administrating;
using DijkstraAlg.Helpers;
using DijkstraAlg.Managers;

namespace DijkstraAlg
{
    public partial class MainApp : Form
    {
        public MainApp()
        {
            InitializeComponent();
            Initializator();
            _graphics = DrawingBox.CreateGraphics();
            DrawingBox.Enabled = false;
            FindWay.Enabled = false;
        }

        private Graphics _graphics;
        private DrawBoxManager _drawBoxManager = new DrawBoxManager();
        private bool _clearAll;

        private void exitToolStripMenuItem_Click(object sender, EventArgs e)
        {
            Application.Exit();
        }

        private void Clear_Draw_Box_Click(object sender, EventArgs e)
        {
            DrawingBox.BackColor = Color.White;
            DrawingBox.Refresh();
            _clearAll = true;
        }

        private void Initializator()
        {
            AlgType.Items.Add(Constants.BFS);

            AlgType.Items.Add(Constants.DFS);

            AlgType.Text = Constants.DFS;
        }

        private void Generate_Click(object sender, EventArgs e)
        {
            DrawingBox.Refresh();
            GenerateTree.GenerateExampleTree(_graphics);
            FindWay.Enabled = true;
        }

        private void FindWay_Click(object sender, EventArgs e)
        {
            DBFSManager.Manage(this, _graphics);
        }
    }
}
