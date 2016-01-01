using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using System.Windows.Forms.DataVisualization.Charting;


namespace Division
{
    public partial class Form1 : Form
    {
        private int studentNumber;
        public Form1()
        {
            InitializeComponent();

            studentNumber = 7;            

            BernunlliCH.ChartAreas[0].AxisX.MajorGrid.LineDashStyle = System.Windows.Forms.DataVisualization.Charting.ChartDashStyle.NotSet;
            BernunlliCH.ChartAreas[0].AxisY.MajorGrid.LineDashStyle = System.Windows.Forms.DataVisualization.Charting.ChartDashStyle.NotSet;

            BinomialCH.ChartAreas[0].AxisX.MajorGrid.LineDashStyle = System.Windows.Forms.DataVisualization.Charting.ChartDashStyle.NotSet;
            BinomialCH.ChartAreas[0].AxisY.MajorGrid.LineDashStyle = System.Windows.Forms.DataVisualization.Charting.ChartDashStyle.NotSet;

            PuassonCH.ChartAreas[0].AxisX.MajorGrid.LineDashStyle = System.Windows.Forms.DataVisualization.Charting.ChartDashStyle.NotSet;
            PuassonCH.ChartAreas[0].AxisY.MajorGrid.LineDashStyle = System.Windows.Forms.DataVisualization.Charting.ChartDashStyle.NotSet;

            EquivalentCH.ChartAreas[0].AxisX.MajorGrid.LineDashStyle = System.Windows.Forms.DataVisualization.Charting.ChartDashStyle.NotSet;
            EquivalentCH.ChartAreas[0].AxisY.MajorGrid.LineDashStyle = System.Windows.Forms.DataVisualization.Charting.ChartDashStyle.NotSet;

            NormalCH.ChartAreas[0].AxisX.MajorGrid.LineDashStyle = System.Windows.Forms.DataVisualization.Charting.ChartDashStyle.NotSet;
            NormalCH.ChartAreas[0].AxisY.MajorGrid.LineDashStyle = System.Windows.Forms.DataVisualization.Charting.ChartDashStyle.NotSet;

            ParettoCH.ChartAreas[0].AxisX.MajorGrid.LineDashStyle = System.Windows.Forms.DataVisualization.Charting.ChartDashStyle.NotSet;
            ParettoCH.ChartAreas[0].AxisY.MajorGrid.LineDashStyle = System.Windows.Forms.DataVisualization.Charting.ChartDashStyle.NotSet;

            StudentCH.ChartAreas[0].AxisX.MajorGrid.LineDashStyle = System.Windows.Forms.DataVisualization.Charting.ChartDashStyle.NotSet;
            StudentCH.ChartAreas[0].AxisY.MajorGrid.LineDashStyle = System.Windows.Forms.DataVisualization.Charting.ChartDashStyle.NotSet;

            LorentsaCH.ChartAreas[0].AxisX.MajorGrid.LineDashStyle = System.Windows.Forms.DataVisualization.Charting.ChartDashStyle.NotSet;
            LorentsaCH.ChartAreas[0].AxisY.MajorGrid.LineDashStyle = System.Windows.Forms.DataVisualization.Charting.ChartDashStyle.NotSet;
        }

        private void Form1_Load(object sender, EventArgs e)
        {
            MainTC.SelectedIndex = 0;
            int N = 0;
            double p = 0;
            double[][] data = Divisions.initArrayWithSize(0);

            //"Розподіл Бернуллі"
            p = 1 / ((double)studentNumber + 1);
            N = 2;
            data = Divisions.bernulli(p);
           // BernunlliCH.Series[0].Points.Clear();
            for (int i = 0; i < N; i++)
            {
                BernunlliCH.Series[0].Points.AddXY(data[i][0], data[i][1]);
            }

            //"Біноміальний розподіл"

            N = studentNumber + 2;
            p = 1 / ((double)studentNumber + 1);
            data = Divisions.binomial(p, N);
           // BinomialCH.Series[0].Points.Clear();
            for (int i = 0; i < N; i++)
            {
                BinomialCH.Series[0].Points.AddXY(data[i][0], data[i][1]);
            }

            //"Розподіл Пуассона"

            N = studentNumber + 10; // коефіцієнт лямбда; максимальна кількість ітерацій = studentNumber + 5 = 7 + 5 = 12
            data = Divisions.puasson(N, 12);
            //PuassonCH.Series[0].Points.Clear();
            for (int i = 0; i < 12; i++)
            {
                PuassonCH.Series[0].Points.AddXY(data[i][0], data[i][1]);
            }

            //"Рівномірний розподіл"
            N = 10;
            data = Divisions.normal(-7, 7, N);
          //  EquivalentCH.Series[0].Points.Clear();
            for (int i = 0; i < N; i++)
            {
                EquivalentCH.Series[0].Points.AddXY(data[i][0], data[i][1]);
            }

            //"Нормальний розподіл"
            N = 10;
            data = Divisions.normalWithAverage(studentNumber, studentNumber, N);
           // NormalCH.Series[0].Points.Clear();
            for (int i = 0; i < N; i++)
            {
                NormalCH.Series[0].Points.AddXY(data[i][0], data[i][1]);
            }

            //"Розподіл Парето"
            N = 10;
            data = Divisions.parreto(studentNumber, studentNumber, N);
          //  ParettoCH.Series[0].Points.Clear();
            for (int i = 0; i < N; i++)
            {
                ParettoCH.Series[0].Points.AddXY(data[i][0], data[i][1]);
            }

            //"Розподіл Стьюдента"
            N = 10;
            data = Divisions.student(studentNumber, N);
          //  StudentCH.Series[0].Points.Clear();
            for (int i = 0; i < N; i++)
            {
                StudentCH.Series[0].Points.AddXY(data[i][0], data[i][1]);
            }

            //"Розподіл Лоренца"

            N = 5;
            data = Divisions.lorentsa(-2, 1, N);
          //  LorentsaCH.Series[0].Points.Clear();
            for (int i = 0; i < N; i++)
            {
                LorentsaCH.Series[0].Points.AddXY(data[i][0], data[i][1]);
            }
        }                
    }

    class Divisions
    {
        public Divisions() 
        { 
        }

        public static double[][] bernulli(double p)
        {
            int N = 1000;
            double a = 0;
            double b = 1;
            double h = (b - a) / N;
            double[][] result = initArrayWithSize(2);

            result[0][0] = 0;
            result[0][1] = Math.Pow(p, 0) * Math.Pow(1 - p, 1);

            result[1][0] = 0;
            result[1][1] = Math.Pow(p, 1) * Math.Pow(1 - p, 0);

            return result;
        }

        public static double[][] binomial(double p, int n)
        {
            double[][] result = initArrayWithSize(n);

            for (int i = 0; i < n; i++)
            {
                result[i][0] = i;
                result[i][1] = combinations(n, i) * Math.Pow(p, i) * Math.Pow(1 - p, 1 - i);
            }

            return result;
        }

        public static double[][] puasson(double l, int N)
        {
            double[][] result = initArrayWithSize(N);

            for (int i = 0; i < N; i++)
            {
                result[i][0] = i;
                result[i][1] = Math.Pow(l, i) * Math.Exp(-l) / factorial(i);
                Console.WriteLine(Math.Pow(l, i) * Math.Exp(-l));
            }

            return result;
        }

        public static double[][] normal(int a, int b, int N)
        {
            double[][] result = initArrayWithSize(b - a + 1);

            for (int idx = 0, i = a; i <= b; i++, idx++)
            {
                result[idx][0] = i;
                result[idx][1] = 1 / (double)(b - a);
            }

            return result;
        }

        public static double[][] normalWithAverage(double a, double disp, int N)
        {
            double[][] result = initArrayWithSize(N);
            double constVal = Math.Sqrt(2 * Math.PI);

            double ax = -5;
            double bx = 15;
            double h = (bx - ax) / N;

            double x = ax;
            for (int i = 0; i < N; i++)
            {
                result[i][0] = ax;
                result[i][1] = 1 / (constVal * disp) * Math.Exp(-Math.Pow((ax - a), 2) / (2 * disp * disp));
                ax += h;
            }

            return result;
        }

        public static double[][] parreto(int alpha, double x0, int N)
        {
            double[][] result = initArrayWithSize(N);

            double ax = 6;
            double bx = x0;
            double h = (bx - ax) / N;

            double x = ax;
            for (int i = 0; i < N; i++)
            {
                result[i][0] = ax;
                result[i][1] = (double)alpha * Math.Pow(x0, alpha) / Math.Pow(ax - 10, alpha + 1);
                ax += h;
            }

            return result;
        }

        public static double[][] student(int alpha, int N)
        {
            double[][] result = initArrayWithSize(N);
            Chart chart = new Chart();

            double ax = -10;
            double bx = 10;
            double h = (bx - ax) / N;

            double x = ax;
            for (int i = 0; i < N; i++)
            {
                result[i][0] = x;
                result[i][1] = chart.DataManipulator.Statistics.TDistribution(x, alpha, true);
                x += h;
            }

            return result;
        }

        public static double[][] lorentsa(int x0, int hamma, int N) 
        { 
            double[][] result = initArrayWithSize(N);

            double ax = 6;
            double bx = x0;
            double h = (bx - ax) / N;

            double x = ax;
            for (int i = 0; i < N; i++)
            {
                result[i][0] = ax;
                result[i][1] = ((double)1 / Math.PI) * (hamma / (Math.Pow(ax - x0, 2) + Math.Pow(hamma, 2)));
                ax += h;
            }

            return result;
        }

        // helper methods
        public static double[][] initArrayWithSize(int size)
        {
            double[][] result = new double[size][];
            for (int i = 0; i < size; i++)
                result[i] = new double[2];

            return result;
        }

        private static int factorial(int n)
        {
            int result = 1;

            if (n == 0)
            {
                result = 1;
            }
            else
            {
                for (int i = 1; i <= n; i++)
                {
                    result *= i;
                }
            }

            return result;
        }

        private static int combinations(int n, int k)
        {
            int result = factorial(n) / (factorial(k) * factorial(n - k));

            return result;
        }

    }
}
