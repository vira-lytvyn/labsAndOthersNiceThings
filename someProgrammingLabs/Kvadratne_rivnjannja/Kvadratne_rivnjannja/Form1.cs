using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;

namespace Kvadratne_rivnjannja
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            double a, b, c, d, x1, x2;
            a = Convert.ToDouble(textBox1.Text);
            b = Convert.ToDouble(textBox2.Text);
            c = Convert.ToDouble(textBox3.Text);
            d = b * b - 4 * a * c;
            if (d < 0)
            {
                MessageBox.Show("Рівняння не має коренів");
                textBox4.Visible = false;
                textBox5.Visible = false;
            }
            if (d == 0)
            {
                x1 = -b / (2 * a);
                textBox4.Visible = true;
                textBox4.Text = Convert.ToString(x1);
            }
            else
            {
                x1 = (- b - Math.Sqrt(d)) / (2 * a);
                x2 = (-b + Math.Sqrt(d)) / (2 * a);
                textBox4.Visible = true;
                textBox4.Text = Convert.ToString(x1);
                textBox5.Visible = true;
                textBox5.Text = Convert.ToString(x2);
            }
        }
    }
}
