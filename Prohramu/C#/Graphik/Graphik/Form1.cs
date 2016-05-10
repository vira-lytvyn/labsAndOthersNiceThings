using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;

namespace Graphik
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }
        double[] xe = new double[800];
        double[] ye = new double[800];

        double f(double x)
        {
            return Math.Sin(x);
        }

        public void button1_Click(object sender, EventArgs e)
        {
            double t0, tk, h;
            int N, i;
            t0 = Convert.ToDouble(textBox1.Text);
            tk = Convert.ToDouble(textBox2.Text);
            N = Convert.ToInt32(textBox3.Text);
            if (N >= 799)
            {
                N = 799;
            }
            h = (tk - t0) / N;
            xe[0] = t0;
            //запис значень у масиви для виводу на графік 
            for (i = 0; i < N; i++)
            {
                ye[i] = f(xe[i]);
                xe[i + 1] = xe[i] + h;
            }

            Grafik Gr = new Grafik();       
            Graphics g = panel2.CreateGraphics();       //створення об'єкту класу Graphics           
            Gr.ModelGrafik(ref xe, ref ye, N, g);
            Invalidate();                               //перемальовування графічних об'єктів
            g.Dispose();                                //вивільнення зайнятих під малювання ресурсів
        }
    }
}
