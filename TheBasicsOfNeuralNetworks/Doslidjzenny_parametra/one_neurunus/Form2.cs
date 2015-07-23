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
    public partial class DependencesForm : Form
    {
        Culculation singleNeuron;

        private const int N = 100;
        private double[][] patterns;
        private double sigma;
        private int maxIterations;
        private double error;
        private double educationSpeed;
        private double firstWeight;

        public DependencesForm()
        {
            InitializeComponent();

            singleNeuron = new Culculation();
        }

        public void loadParameters(double[][] inputPatterns, double inputEducationSpeed, double inputSigma, int intputMaxIterations, double inputError, double firstW)
        {
            patterns = inputPatterns;
            sigma = inputSigma;
            maxIterations = intputMaxIterations;
            error = inputError;
            educationSpeed = inputEducationSpeed;
            firstWeight = firstW;
        }

        private void DependenseBtn_Click(object sender, EventArgs e)
        {
            runTestForError();
            runTestForSigma();
            runTestForEducationSpeed();
            runTestForFirstWeight();
        }

        // analyzing methods
        private void runTestForError()
        {
            double startError = 0.125;
            double endError = 0;
            double h = (startError - endError) / N;
            double[][] result = initArray();

            double x = startError;
            for (int i = 0; i < N; i++)
            {
                singleNeuron.Run(patterns, x, educationSpeed, sigma, maxIterations, firstWeight);
                result[i][0] = x;
                result[i][1] = singleNeuron.Iterations;
                x -= h;
            }

            ErrorCH.Series[0].Points.Clear();
            for (int i = 0; i < N; i++)
            {
                ErrorCH.Series[0].Points.AddXY(Math.Round(result[i][0], 4), result[i][1]);
            }
        }

        private void runTestForSigma()
        {
            double startSigma = 0.1;
            double endSigma = 5.1;
            double h = (endSigma - startSigma) / N;
            double[][] result = initArray();

            double x = startSigma;
            for (int i = 0; i < N; i++)
            {
                singleNeuron.Run(patterns, error, educationSpeed, x, maxIterations, firstWeight);
                result[i][0] = x;
                result[i][1] = singleNeuron.Iterations;
                x += h;
            }

            AlphaCH.Series[0].Points.Clear();
            for (int i = 0; i < N; i++)
            {
                AlphaCH.Series[0].Points.AddXY(Math.Round(result[i][0], 4), result[i][1]);
            }
        }

        private void runTestForEducationSpeed()
        {
            double startEduSpeed = 0.1;
            double endEduSpeed = 4;
            double h = (endEduSpeed - startEduSpeed) / N;
            double[][] result = initArray();

            double x = startEduSpeed;
            for (int i = 0; i < N; i++)
            {
                singleNeuron.Run(patterns, error, x, sigma, maxIterations, firstWeight);
                result[i][0] = x;
                result[i][1] = singleNeuron.Iterations;
                x += h;
            }

            SpeedCH.Series[0].Points.Clear();
            for (int i = 0; i < N; i++)
            {
                SpeedCH.Series[0].Points.AddXY(Math.Round(result[i][0], 4), result[i][1]);
            }
        }

        private void runTestForFirstWeight()
        {
            double startW1 = 0.06;
            double endW1 = 5.5;
            double h = (endW1 - startW1) / N;
            double[][] result = initArray();

            double x = startW1;
            for (int i = 0; i < N; i++)
            {
                singleNeuron.Run(patterns, error, x, sigma, maxIterations, firstWeight);
                result[i][0] = x;
                result[i][1] = singleNeuron.Iterations;
                x += h;
            }

            WeightCH.Series[0].Points.Clear();
            for (int i = 0; i < N; i++)
            {
                WeightCH.Series[0].Points.AddXY(Math.Round(result[i][0], 4), result[i][1]);
            }
        }

        // helper methods
        private double[][] initArray()
        {
            double[][] result = new double[N][];
            for (int i = 0; i < N; i++)
                result[i] = new double[2];
            return result;
        }

        private void DependencesForm_Load(object sender, EventArgs e)
        {
            runTestForError();
            runTestForSigma();
            runTestForEducationSpeed();
            runTestForFirstWeight();
        }
    }        
}
