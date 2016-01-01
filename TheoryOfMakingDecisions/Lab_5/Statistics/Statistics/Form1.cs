using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;

namespace Statistics
{
    public partial class Form1 : Form
    {
        private int StudentNumber;
        private int samlpeSize;
        StatisticOperation statisticOperation;
        public Form1()
        {
            InitializeComponent();
            StudentNumber = 7;
            samlpeSize = 3000;
            statisticOperation = new StatisticOperation();
        }     

        private void GenerateBTN_Click(object sender, EventArgs e)
        {
            int upperRange = 5 * StudentNumber;
            statisticOperation.findSample(samlpeSize, upperRange);
            drawData(statisticOperation.RandDataFrequency, upperRange);
        }

        private void drawData(int[][] data, int N)
        {
            RandomSampleCH.Series[0].Points.Clear();

            for (int i = 0; i < N; i++)
            {
                RandomSampleCH.Series[0].Points.AddXY(data[i][0], data[i][1]);
            }
        }

        private void CalculateBTN_Click(object sender, EventArgs e)
        {
            int size = 5 * StudentNumber;
            statisticOperation.findAvgs(samlpeSize, size);

            MedianTB.Text = Convert.ToString(Math.Round(statisticOperation.Median, 5));
            FashionTB.Text = Convert.ToString(Math.Round(statisticOperation.Fashion, 5));
            AvgArithmeticsTB.Text = Convert.ToString(Math.Round(statisticOperation.ArifmeticAv, 5));
            AvgSquareTB.Text = Convert.ToString(Math.Round(statisticOperation.QuadraticAv, 5));
            AvgGeometricsTB.Text = Convert.ToString(Math.Round(statisticOperation.GeometricAv, 5));
            AvgGarmonicTB.Text = Convert.ToString(Math.Round(statisticOperation.GarmonicAv, 5));
        }
    }

    class StatisticOperation 
    {
        public StatisticOperation() 
        {
        }

        public int[] RandVal
        {
            get { return randomValues; }
        }

        public int[][] RandDataFrequency
        {
            get { return randomDataFrequency; }
        }

        public double ArifmeticAv
        {
            get { return arifmeticAverage; }
        }

        public double QuadraticAv
        {
            get { return quadraticAverage; }
        }

        public double GeometricAv
        {
            get { return geometricAverage; }
        }

        public double GarmonicAv
        {
            get { return garmonicAverage; }
        }

        public double Fashion
        {
            get { return fashion; }
        }

        public double Median
        {
            get { return median; }
        }

        public void findAvgs(int inputSize, int inputMaxValue)
        {
            maxValue = inputMaxValue;
            setSize = inputSize;

            ArifmeticAvg();
            QuadraticAvg();
            GeometricAvg();
            GarmonicAvg();
            FashionVal();
            MedianVal();
        }
        public void findSample(int inputSize, int inputMaxValue) 
        {
            maxValue = inputMaxValue;
            setSize = inputSize;

            generateData();
            DataFrequency();
        }

        private int maxValue;
        private int setSize;
        private int[] randomValues;
        private int[][] randomDataFrequency;
        private double arifmeticAverage;
        private double quadraticAverage;
        private double geometricAverage;
        private double garmonicAverage;
        private double fashion;
        private double median;

        private void ArifmeticAvg()
        {
            int sum = 0;
            for (int i = 0; i < setSize; i++)
            {
                sum += randomValues[i];
            }

            arifmeticAverage = sum / setSize;
        }

        private void QuadraticAvg()
        {
            int sum = 0;
            for (int i = 0; i < setSize; i++)
            {
                sum += (int)Math.Pow((randomValues[i] - arifmeticAverage), 2);
            }

            quadraticAverage = Math.Sqrt(sum / setSize);
        }

        private void GeometricAvg()
        {
            double mlt = 1;
            for (int i = 0; i < setSize; i++)
            {
                if (randomValues[i] != 0)
                {
                    mlt = mlt * Math.Exp(Math.Log(randomValues[i]) * (1 / (double)setSize));
                }
            }

            geometricAverage = mlt;
        }

        private void GarmonicAvg()
        {
            double sum = 0;
            for (int i = 0; i < setSize; i++)
            {
                sum += 1 / (double)randomValues[i];
            }

            garmonicAverage = setSize / sum;
        }

        private void FashionVal()
        {
            int max = -100;
            int index = 0;
            for (int i = 0; i < maxValue; i++)
            {
                if (randomDataFrequency[i][1] > max)
                {
                    max = randomDataFrequency[i][1];
                    index = randomDataFrequency[i][0];
                }
            }

            fashion = index;
        }

        private void MedianVal()
        {
            Array.Sort(randomValues);
            int index = setSize / 2;
            double value = 0;
            if (setSize % 2 != 0)
            {
                value = randomValues[(setSize - 1) / 2 + 1];
            }
            else
            {
                value = (randomValues[index] + randomValues[index + 1]) / (double)2;
            }

            median = value;
        }

        private void generateData()
        {
            randomValues = new int[setSize];
            Random rand = new Random();

            for (int i = 0; i < setSize; i++)
            {
                randomValues[i] = rand.Next(maxValue) + 1;
            }
        }

        private void DataFrequency()
        {
            Dictionary<int, int> dict = new Dictionary<int, int>();

            for (int i = 0; i < setSize; i++)
            {
                int number = randomValues[i];

                if (!dict.ContainsKey(number))
                {
                    int frequency = 0;
                    for (int j = 0; j < setSize; j++)
                    {
                        frequency = randomValues[j] == number ? frequency + 1 : frequency;
                    }

                    dict.Add(number, frequency);
                }
            }

            randomDataFrequency = new int[maxValue][];
            for (int i = 0; i < maxValue; i++)
            {
                randomDataFrequency[i] = new int[2];
            }

            for (int i = 0; i < maxValue; i++)
            {
                randomDataFrequency[i][0] = i + 1;
                randomDataFrequency[i][1] = dict[i + 1];
            }
        }
    }
}
