using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;

namespace Perevantajzennya
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }
        static double Ploshcha(double a, double b) // Прямокутник  
        {
            return a * b; 
        }
        static double Ploshcha(double a) // Квадрат
        {
            return a * a;
        }
        static double Ploshcha(double a, double b, double c) // Трикутник
        {
            double p = (a + b + c) / 2;
            return Math.Sqrt(p * (p - a) * (p - b) * (p - c));
        }
        static double Ploshcha(double a, double b, double c, double d) // Трапеція за чотирма сторонами 
        {
            return (1 / 4) * ((b + a) / (b - a)) * Math.Sqrt((-a + b + c + d) * (a - b + c + d) * (a - b + c - d) * (a - b - c + d));
        }
        /*  static double Ploshcha(double a, double b, double h) // Трапеція за висотою
          {
              double S = ((a+ b)/2)*h;
          }
          static double Ploshcha(double a, double l) // Трапеція за середньою лінією 
          {
              double S = l*h;
          }*/
        private void Rah_Click(object sender, EventArgs e)
        {
            double a, b, c, d, S;
            switch (comboBox1.SelectedIndex) 
            {
                case 0: 
                    {
                        a = double.Parse(First.Text);
                        S = Ploshcha(a, b);
                        Stb.Text = S.ToString();
                    }
                break; 
                case 1: 
                    {
                        a = double.Parse(First.Text);
                        b = double.Parse(Second.Text);
                        S = Ploshcha(a);
                        Stb.Text = S.ToString(); 
                    }
                break; 
                case 2: 
                    {
                        a = double.Parse(First.Text);
                        b = double.Parse(Second.Text);
                        c = double.Parse(Third.Text);
                        S = Ploshcha(a, b, c);
                        Stb.Text = S.ToString(); 
                    }
                break; 
                case 3: 
                    {
                        a = double.Parse(First.Text);
                        b = double.Parse(Second.Text);
                        c = double.Parse(Third.Text);
                        d = double.Parse(Fourth.Text);
                        S = Ploshcha(a, b, c, d);
                        Stb.Text = S.ToString();
                    }
                break; 
            }

        }

        private void comboBox1_SelectedIndexChanged(object sender, EventArgs e)
        {
            L1.Visible = false;
            First.Visible = false;
            L2.Visible = false;
            Second.Visible = false;
            L3.Visible = false;
            Third.Visible = false;
            L4.Visible = false;
            Fourth.Visible = false;
            figurname.Text = "";
            switch (comboBox1.SelectedIndex)
            {
                case 0:
                    {
                        L1.Visible = true;
                        First.Visible = true;
                        L2.Visible = true;
                        Second.Visible = true;
                        figurname.Text = "rectangle"; 
                    }
                break;
                case 1:
                    {
                        L1.Visible = true;
                        First.Visible = true;
                        figurname.Text = "square"; 
                    }
                break;
                case 2:
                    {
                        L1.Visible = true;
                        First.Visible = true;
                        L2.Visible = true;
                        Second.Visible = true;
                        L3.Visible = true;
                        Third.Visible = true;
                        figurname.Text = "triangle";
                    }
                break;
                case 3:
                    {
                        L1.Visible = true;
                        First.Visible = true;
                        L2.Visible = true;
                        Second.Visible = true;
                        L3.Visible = true;
                        Third.Visible = true;
                        L4.Visible = true;
                        Fourth.Visible = true;
                        figurname.Text = "trapeze";
                    }
                break; 
            }
        }
    }
}
