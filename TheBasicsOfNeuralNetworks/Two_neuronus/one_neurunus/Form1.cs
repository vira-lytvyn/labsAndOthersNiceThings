using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using NeronNetwork;
using Generator;

namespace one_neurunus
{
    public partial class Form1 : Form
    {
        NeronNetwork.Culculation Clasification;
        List<Values> classFirst;
        List<Values> classSecond;
        List<Values> divider;

        public Form1()
        {
            InitializeComponent();            

            classFirst = new List<Values>();
            classSecond = new List<Values>();
            divider = new List<Values>();
                       
        }

        private void studyBtn_Click(object sender, EventArgs e)
        {
            try
            {
                int stPairsCount = Convert.ToInt32(stPairsTB.Text);
                double mx1 = Convert.ToDouble(MX1TB.Text);
                double mx2 = Convert.ToDouble(MX2TB.Text);
                double dx1 = Convert.ToDouble(DX1TB.Text);
                double dx2 = Convert.ToDouble(DX2TB.Text);
                double stSpeed = Convert.ToDouble(speedTB.Text);
                double sygma = Convert.ToDouble(sygmaTB.Text);
                double stError = Convert.ToDouble(errorTB.Text);
                int maxIter = Convert.ToInt32(maxIterTB.Text);
                int secondLayers = Convert.ToInt32(Num2TB.Text);
                double[][] patterns;

                patterns = RandomGenerator.GenerateSets(mx1, dx1, mx2, dx2, stPairsCount, secondLayers);

                Clasification = new NeronNetwork.Culculation();
                Clasification.Run(patterns, stError, stSpeed, sygma, maxIter, secondLayers);

                classFirst.Clear();
                classSecond.Clear();
                divider.Clear();
                
                /// зробити кнопку тестування доступною
                for (int i = 0; i < stPairsCount; i++)
                {
                    double value = (-Clasification.Weights[1] * patterns[i][1] - Clasification.Weights[2]) / Clasification.Weights[0];
                    divider.Add(new Values() { X = value, Y = patterns[i][1] });
                }

                for (int i = 0; i < patterns.Length; i++)
                {
                    if (patterns[i][2] == 1) classFirst.Add(new Values() { X = patterns[i][0], Y = patterns[i][1] });
                    else classSecond.Add(new Values() { X = patterns[i][0], Y = patterns[i][1] });
                }

                if (Clasification.IsTrained)
                {
                    testBtn.Enabled = true;
                    IterationsTB.Text = Convert.ToString(Clasification.Iterations);
                }

                viNM.Series[0].Points.Clear();
                viNM.Series[1].Points.Clear();
                viNM.Series[2].Points.Clear();

                for (int i = 0; i < classFirst.Count; i++)
                {
                    viNM.Series[0].Points.AddXY(Math.Round(classFirst[i].X, 3), classFirst[i].Y);
                }
                for (int i = 0; i < classSecond.Count; i++)
                {
                    viNM.Series[2].Points.AddXY(Math.Round(classSecond[i].X, 3), classSecond[i].Y);
                }
                for (int i = 0; i < divider.Count; i++)
                {
                    viNM.Series[1].Points.AddXY(Math.Round(divider[i].X, 3), divider[i].Y);
                }
            }
            catch (FormatException) {
                MessageBox.Show("Exeption");
            }
        }

        private void testBtn_Click(object sender, EventArgs e)
        {
            int stPairsCount = Convert.ToInt32(stPairsTB.Text);
            double mx1 = Convert.ToDouble(MX1TB.Text);
            double mx2 = Convert.ToDouble(MX2TB.Text);
            double dx1 = Convert.ToDouble(DX1TB.Text);
            double dx2 = Convert.ToDouble(DX2TB.Text);
            int secondLayers = Convert.ToInt32(Num2TB.Text);
            double[][] testPairs = RandomGenerator.GenerateSets(mx1, dx1, mx2, dx2, stPairsCount, secondLayers);

            classFirst.Clear();
            classSecond.Clear();
            divider.Clear();

            for (int i = 0; i < stPairsCount; i++)
            {
                double value = (-Clasification.Weights[1] * testPairs[i][1] - Clasification.Weights[2]) / Clasification.Weights[0];
                divider.Add(new Values() { X = value, Y = testPairs[i][1] });
            }

            for (int i = 0; i < testPairs.Length; i++)
            {
                if (testPairs[i][2] == 0) classSecond.Add(new Values() { X = testPairs[i][0], Y = testPairs[i][1] });
                else classFirst.Add(new Values() { X = testPairs[i][0], Y = testPairs[i][1] });
            }

            viNM.Series[0].Points.Clear();
            viNM.Series[1].Points.Clear();
            viNM.Series[2].Points.Clear();

            for (int i = 0; i < classFirst.Count; i++)
            {
                viNM.Series[0].Points.AddXY(Math.Round(classFirst[i].X, 3), classFirst[i].Y);
            }
            for (int i = 0; i < classSecond.Count; i++)
            {
                viNM.Series[2].Points.AddXY(Math.Round(classSecond[i].X, 3), classSecond[i].Y);
            }
            for (int i = 0; i < divider.Count; i++)
            {
                viNM.Series[1].Points.AddXY(Math.Round(divider[i].X, 3), divider[i].Y);
            }
        }
    }
    public class Values
    {
        public double X { set; get; }
        public double Y { set; get; }
    }
}
