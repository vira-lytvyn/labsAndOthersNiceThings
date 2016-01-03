using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using System.Globalization;
using NeurowebLibrary;

namespace NeuroWeb_KSI_Lab_6
{
    public partial class MainForm : Form
    {
        private int educationPairsCount;
        private double[][] testArray;
        private NeuroWeb neuroWeb;
        private Color[] colors;

        public MainForm()
        {
            InitializeComponent();
        }

        private double[][] GenerateSets(double mx1, double my1, double dx1, double dy1, double mx2, double my2, double dx2, double dy2, int pairsCount)
        {
            double[][] array = new double[pairsCount][];
            for (int i = 0; i < pairsCount; i++)
            {
                array[i] = new double[2];
            }
            double x, y;
            for (int i = 0; i < pairsCount; i++)
            {
                if (RandomGenerator.Boolean())
                {
                    x = RandomGenerator.Gauss(mx1, dx1);
                    y = RandomGenerator.Gauss(my1, dy1);
                }
                else
                {
                    x = RandomGenerator.Gauss(mx2, dx2);
                    y = RandomGenerator.Gauss(my2, dy2);
                }
                array[i][0] = x;
                array[i][1] = y;
            }
            return array;
        }

        private void startButton_Click(object sender, EventArgs e)
        {
            try
            {
                // Read input data
                double mx1 = Convert.ToDouble(mx1TextBox.Text, CultureInfo.InvariantCulture);
                double my1 = Convert.ToDouble(my1TextBox.Text, CultureInfo.InvariantCulture);
                double dx1 = Convert.ToDouble(dx1TextBox.Text, CultureInfo.InvariantCulture);
                double dy1 = Convert.ToDouble(dy1TextBox.Text, CultureInfo.InvariantCulture);
                double mx2 = Convert.ToDouble(mx2TextBox.Text, CultureInfo.InvariantCulture);
                double my2 = Convert.ToDouble(my2TextBox.Text, CultureInfo.InvariantCulture);
                double dx2 = Convert.ToDouble(dx2TextBox.Text, CultureInfo.InvariantCulture);
                double dy2 = Convert.ToDouble(dy2TextBox.Text, CultureInfo.InvariantCulture);
                double eta = Convert.ToDouble(etaTextBox.Text, CultureInfo.InvariantCulture);
                int maxN = Convert.ToInt32(maxNTextBox.Text, CultureInfo.InvariantCulture);
                int maxClusters = Convert.ToInt32(maxClustersTextBox.Text, CultureInfo.InvariantCulture);
                double entropyBound = Convert.ToDouble(entropyBoundTextBox.Text, CultureInfo.InvariantCulture);
                educationPairsCount = Convert.ToInt32(pointsCountTextBox.Text, CultureInfo.InvariantCulture);

                int clustersCount = 1;
                int inputVectorLength = 2;
                //double fi = Math.PI / 36.0; // 5 градусів

                // Create education pairs
                testArray = GenerateSets(mx1, my1, dx1, dy1, mx2, my2, dx2, dy2, educationPairsCount);

                Education education = new Education(clustersCount, inputVectorLength, eta, testArray, educationPairsCount);
                education.StartEducation(maxN);
                while ((education.GetBadVectorsCount(entropyBound) != 0) && (clustersCount < maxClusters))
                {
                    // Формуємо нову матрицю ваг
                    List<double[]> newOmegaArray = new List<double[]>();
                    int newClustersCount = clustersCount;
                    double[] entropies = education.GetEntropies();
                    for (int i = 0; i < clustersCount; i++)
                    {
                        double[] omegaVector = education.NeuroWeb.OmegaArray[i];
                        newOmegaArray.Add(omegaVector);
                        if (entropies[i] > entropyBound)
                        {
                            double[] omegaVectorNew = new double[inputVectorLength];
                            for (int j = 0; j < inputVectorLength; j++) omegaVectorNew[j] = omegaVector[j];
                            newOmegaArray.Add(omegaVectorNew);
                            newClustersCount++;
                        }
                    }

                    // Створюємо мережу з іншою кількістю нейронів
                    clustersCount = newClustersCount;
                    education = new Education(clustersCount, inputVectorLength, eta, testArray, educationPairsCount);

                    // Ініціалізуємо ваги
                    for (int i = 0; i < clustersCount; i++)
                    {
                        education.NeuroWeb.OmegaArray[i] = newOmegaArray[i];
                    }

                    // Вчимо мережу
                    education.StartEducation(maxN);
                }
                clustersCountLabel.Text = "clustersCount = " + clustersCount.ToString();

                neuroWeb = education.NeuroWeb;
                RefreshGraphic(panel.CreateGraphics());
            }
            catch (Exception)
            {
                MessageBox.Show("Введіть коректні вхідні дані");
            }
        }

        private void panel_Paint(object sender, PaintEventArgs e)
        {
            RefreshGraphic(panel.CreateGraphics());
        }

        private void RefreshGraphic(Graphics g)
        {
            // Init
            g.Clear(Color.FromArgb(0xEC, 0xE9, 0xD8));
            int space = 50;
            int spaceArrows = 20;
            double maxValue = 10;
            double step = 2.0;
            int maxHeight = panel.Height;
            int maxWidth = panel.Width;
            int gHeight = maxHeight - 2 * space - spaceArrows;
            int gWidth = maxWidth - 2 * space - spaceArrows;
            double kx = gWidth / maxValue;
            double ky = gHeight / maxValue;

            // Draw points
            Pen pen;
            for (int i = 0; i < educationPairsCount; i++)
            {
                int neuronIndex = neuroWeb.Run(testArray[i]);
                if (neuroWeb.NeuronsCount <= 6)
                {
                    pen = new Pen(colors[neuronIndex]);
                }
                else
                {
                    pen = new Pen(Color.Green);
                }
                g.FillEllipse(pen.Brush, Convert.ToInt32(space + kx * testArray[i][0] - 3), Convert.ToInt32(maxHeight - space - ky * testArray[i][1] - 3), 6, 6);
            }

            // Draw lines
            for (int i = 0; i < neuroWeb.NeuronsCount; i++)
            {
                if (neuroWeb.NeuronsCount <= 6)
                {
                    pen = new Pen(colors[i]);
                }
                else
                {
                    pen = new Pen(Color.Green);
                }
                int x = Convert.ToInt32(space + kx * neuroWeb.OmegaArray[i][0]);
                int y = Convert.ToInt32(maxHeight - space - ky * neuroWeb.OmegaArray[i][1]);
                g.DrawLine(pen, Convert.ToInt32(space), Convert.ToInt32(maxHeight - space), x, y);
            }

            // Draw axis
            Pen axisPen = new Pen(Color.Black);
            g.DrawLine(axisPen, space, space, space, maxHeight - space);
            g.DrawLine(axisPen, space, space, space - 3, space + 7);
            g.DrawLine(axisPen, space, space, space + 3, space + 7);
            g.DrawLine(axisPen, space, maxHeight - space, maxWidth - space, maxHeight - space);
            g.DrawLine(axisPen, maxWidth - space, maxHeight - space, maxWidth - space - 7, maxHeight - space - 3);
            g.DrawLine(axisPen, maxWidth - space, maxHeight - space, maxWidth - space - 7, maxHeight - space + 3);
            Font axisFont = new Font("Arial", 8, FontStyle.Regular);
            g.DrawString("x", axisFont, SystemBrushes.WindowText, maxWidth - space - 5, maxHeight - space + 5);
            g.DrawString("y", axisFont, SystemBrushes.WindowText, space - 25, space - 10);

            // Draw scores & grid
            Pen gridPen = new Pen(Color.Blue);
            gridPen.DashStyle = System.Drawing.Drawing2D.DashStyle.Dash;
            for (double i = 0; i <= maxValue; i += step)
            {
                // Draw scores
                g.DrawLine(axisPen, Convert.ToInt32(space + i * kx), maxHeight - space, Convert.ToInt32(space + i * kx), maxHeight - space + 3);
                g.DrawString(i.ToString(), axisFont, SystemBrushes.WindowText, Convert.ToInt32(space + i * kx - 8), maxHeight - space + 8);
                g.DrawLine(axisPen, space, Convert.ToInt32(maxHeight - space - i * ky), space - 3, Convert.ToInt32(maxHeight - space - i * ky));
                if (i != 0)
                {
                    g.DrawString(i.ToString(), axisFont, SystemBrushes.WindowText, space - 25, Convert.ToInt32(maxHeight - space - i * ky - 8));

                    // Draw grid
                    g.DrawLine(gridPen, Convert.ToInt32(space + i * kx), maxHeight - space, Convert.ToInt32(space + i * kx), space);
                    g.DrawLine(gridPen, space, Convert.ToInt32(maxHeight - space - i * ky), maxWidth - space, Convert.ToInt32(maxHeight - space - i * ky));
                }
            }
        }

        private void MainForm_Load(object sender, EventArgs e)
        {
            RandomGenerator.Init();
            colors = new Color[5];
            colors[0] = Color.Red;
            colors[1] = Color.Green;
            colors[2] = Color.Magenta;
            colors[3] = Color.Blue;
            colors[4] = Color.Orange;
            startButton_Click(sender, e);
        }
    }
}
