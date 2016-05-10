using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;

namespace NutonF
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        static double f(double x, int i)
        {
            //return x * x - 4;
            switch (i) { 
                case 0:
                    return Math.Sqrt(Math.Abs(x)) - Math.Sin(Math.Abs(x)) - 1;
                case 1:
                    return Math.Log(x) - Math.Tan(x) + 2;
                   // return ((x * 11e10 * (-4.5810291) / 3 / 1.47398e10) - (8.85e-12 * 0.34 * 1.47398e10 * Math.Sqrt(-4.5810291) / 4)) / (1 - 0.34) - 2.042;
            }
            return x * x - 4;
        }
        static double p1(double x, double dx, int i)
        {
            return (f(x + dx / 2, i) - f(x - dx / 2, i)) / dx;
        }
        static double p2(double x, double dx, int i)
        {
            return (f(x + dx / 2, i) + f(x - dx / 2, i) - 2 * f(x, i)) / ((dx * dx) / 4);
        }

        private void button1_Click(object sender, EventArgs e)
        {
            double a, b, c, x1, dx, eps, Dx;
            int k, kmax;
            a = double.Parse(Atb.Text);
            b = double.Parse(Btb.Text);
            eps = double.Parse(epstb.Text);
            kmax = int.Parse(kmaxtb.Text);
            if (Math.Abs(b - a) < (2 * eps))
            {
                MessageBox.Show("boundaries are too small", "", MessageBoxButtons.OK);
                return;
            }
            int ind = comboBox2.SelectedIndex;
            switch (comboBox1.SelectedIndex)
            {
                case 0:  //MPD
                    {
                        if (comboBox2.SelectedIndex == 1)
                        {
                            MessageBox.Show("This method is incorrect", "", MessageBoxButtons.OK);
                            return; 
                        }
                        if (a == b)
                        {
                            if (Math.Abs(f(a,ind)) < eps)
                            {
                                MessageBox.Show("the point represent result", "", MessageBoxButtons.OK);
                                return;
                            }
                            else
                            {
                                MessageBox.Show("boundaries are incorrect", "", MessageBoxButtons.OK);
                                return;
                            }
                        }
                        k = 0;
                        if (Math.Abs(f(a, ind)) < eps)
                        {
                            MessageBox.Show("result is similar with boundary a ", "", MessageBoxButtons.OK);
                            xtb.Text = a.ToString();
                            ktb.Text = "0";
                            return;
                        }
                        else if (Math.Abs(f(b, ind)) < eps)
                        {
                            MessageBox.Show("result is similar with boundary b ", "", MessageBoxButtons.OK);
                            xtb.Text = b.ToString();
                            ktb.Text = "0";
                            return;
                        }
                        for (k = 0; k < kmax; k++)
                        {
                            c = (a + (0.5 * (b - a)));
                            k = k + 1;
                            if (f(a, ind) * f(c, ind) > 0)
                            {
                                a = c;
                            }
                            else
                            {
                                b = c;
                            }
                            if (Math.Abs(f(c, ind)) < eps)
                            {
                                xtb.Text = c.ToString();
                                ktb.Text = k.ToString();
                                return; 
                            }
                            if ((k == kmax - 1) && (Math.Abs(f(c, ind)) < eps))
                            {
                                MessageBox.Show("It is impossible too find result", "", MessageBoxButtons.OK);
                                return;
                            }
                        }
                    }
                    break; 
                case 1:   // Nyton
                    {
                        if (comboBox2.SelectedIndex == 0)
                        {
                            MessageBox.Show("This method is incorrect", "", MessageBoxButtons.OK);
                            return;
                        }
                        dx = 0.00001;
                        x1 = b;
                        if (f(b, ind) * p2(b, dx, ind) < 0)
                        {
                            x1 = a;
                            if (f(a, ind) * p2(a, dx, ind) < 0)
                            {
                                MessageBox.Show("For this equation convergence is not garanted", "", MessageBoxButtons.OK);
                            }
                        }
                        for (k = 0; k < kmax; k++)
                        {
                            Dx = f(x1, ind) / p1(x1, dx, ind);
                            x1 = x1 - Dx;
                            if (Math.Abs(Dx) < eps)
                            {
                                xtb.Text = x1.ToString();
                                ktb.Text = k.ToString();
                                return;
                            }
                            if ((k == kmax - 1) && (Math.Abs(Dx) > eps))
                            {
                                MessageBox.Show("It is impossible too find result", "", MessageBoxButtons.OK);
                                return;
                            }

                        }
                    }
                    break; 
            }     
        }

        private void clean_Click(object sender, EventArgs e)
        {
            Atb.Text = "";
            Btb.Text = "";
            epstb.Text = "";
            kmaxtb.Text = "";
            xtb.Text = "";
            ktb.Text = "";
        }       
    }
}
