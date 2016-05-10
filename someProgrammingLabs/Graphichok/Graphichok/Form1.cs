using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;

namespace Graphichok
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }
        Double[] xe = new double[700];
        Double[] ye = new double[700];

        private void button1_Click(object sender, EventArgs e)
        {

            ModelGraphic MGr = new ModelGraphic();
            MGr.tabular(ref xe, ref ye);
            Graphics g;
            g = panel1.CreateGraphics();
            MGr.MalGraphik(ref xe, ref ye, 700, g);
            Invalidate();
            return;
        }
    }
}
