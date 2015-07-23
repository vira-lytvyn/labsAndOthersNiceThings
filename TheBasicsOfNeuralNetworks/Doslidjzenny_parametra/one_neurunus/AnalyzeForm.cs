using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using System.Windows.Forms.DataVisualization.Charting;
using NeronNetwork;

namespace Neuron
{
    public partial class AnalyzeForm : Form
    {
        // members
        private const int N = 100;
        private NeuronClasifier classifier;
        private double[][] patterns;
        private double sigma;
        private int maxIterations;
        private double error;
        private double educationSpeed;

        public AnalyzeForm()
        {
            InitializeComponent();

            classifier = new NeuronClasifier();
        }

        private void AnalyzeForm_Load(object sender, EventArgs e)
        {
            runTestForError();
            runTestForSigma();
            runTestForEducationSpeed();
        }

        public void loadParameters(double[][] inputPatterns, double inputEducationSpeed, double inputSigma, int intputMaxIterations, double inputError) 
        {
            patterns = inputPatterns;
            sigma = inputSigma;
            maxIterations = intputMaxIterations;
            error = inputError;
            educationSpeed = inputEducationSpeed;
        }

        private void analyzeButton_Click(object sender, EventArgs e)
        {
            runTestForError();
            runTestForSigma();
            runTestForEducationSpeed();
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
                classifier.Run(patterns, x, educationSpeed, sigma, maxIterations);
                result[i][0] = x;
                result[i][1] = classifier.Iterations;
                x -= h;
            }

            buildGraphWithData(errorChart, result);
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
                classifier.Run(patterns, error, educationSpeed, x, maxIterations);
                result[i][0] = x;
                result[i][1] = classifier.Iterations;
                x += h;
            }

            buildGraphWithData(sigmaChart, result);
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
                classifier.Run(patterns, error, x, sigma, maxIterations);
                result[i][0] = x;
                result[i][1] = classifier.Iterations;
                x += h;
            }

            buildGraphWithData(educationSpeedChart, result);
        }

        // building graphs
        private void buildGraphWithData(Chart chart, double[][] data)
        {
            chart.Series[0].Points.Clear();
            for (int i = 0; i < N; i++)
            {
                chart.Series[0].Points.AddXY(Math.Round(data[i][0], 4), data[i][1]);
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
    }
}
