using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using NeronNetwork;

namespace one_neurunus
{
    public partial class Form1 : Form
    {
        Culculation singleNeuron;

        public Form1()
        {
            InitializeComponent();

            singleNeuron = new Culculation();

            studyPairsGV.RowCount = 4;
            studyPairsGV.ColumnCount = 3;

            for (int i = 0; i < studyPairsGV.RowCount; i++) { 
                for (int j = 0; j < studyPairsGV.ColumnCount; j++) {
                    studyPairsGV[j, i].Value = "0";
                }
            }
        }

        private void studyBtn_Click(object sender, EventArgs e)
        {
            try
            {
                double stSpeed = Convert.ToDouble(speedTB.Text);
                double sygma = Convert.ToDouble(sygmaTB.Text);
                double stError = Convert.ToDouble(errorTB.Text);
                int maxIter = Convert.ToInt32(maxIterTB.Text);

                double[][] stPairs = new double[studyPairsGV.RowCount][];
                for (int i = 0; i < studyPairsGV.RowCount; i++)
                    stPairs[i] = new double[3];

                for (int i = 0; i < studyPairsGV.RowCount; i++)
                {
                    for (int j = 0; j < studyPairsGV.ColumnCount; j++)
                    {
                        stPairs[i][j] = Convert.ToDouble(studyPairsGV[j, i].Value);
                    }
                }

                singleNeuron.Run(stPairs, stError, stSpeed, sygma, maxIter);

                viNM.Series[0].Points.Clear();
                viNM.Series[1].Points.Clear();

                for (int i = 0; i < studyPairsGV.RowCount; i++)
                {
                    double xL = -singleNeuron.Weights[0] / singleNeuron.Weights[1] * stPairs[i][0] - singleNeuron.Weights[2] / singleNeuron.Weights[1];
                    double yL = -singleNeuron.Weights[1] / singleNeuron.Weights[0] * stPairs[i][1] - singleNeuron.Weights[2] / singleNeuron.Weights[0];
                    
                    viNM.Series[0].Points.AddXY(stPairs[i][1], stPairs[i][0]);
                    viNM.Series[1].Points.AddXY(xL, stPairs[i][0]);
                    viNM.Series[1].Points.AddXY(stPairs[i][1], yL);
                }                
            }
            catch (FormatException) { }
        }

        private void testBtn_Click(object sender, EventArgs e)
        {
            try
            {
                double testX1 = Convert.ToDouble(testX1TB.Text);
                double testX2 = Convert.ToDouble(testX2TB.Text);
                
                double testOut = singleNeuron.testWithOnePair(testX1, testX2);
                testOutTB.Text = Convert.ToString(testOut);
            }
            catch (FormatException) { }
        }
    }
}
