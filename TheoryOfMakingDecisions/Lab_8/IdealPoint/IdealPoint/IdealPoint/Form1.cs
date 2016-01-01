using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;

namespace IdealPoint
{
    public partial class Form1 : Form
    {
        private int studentNumder;
        private int columns;
        private int rows;

        public Form1()
        {
            studentNumder = 7;
            columns = 8;
            rows = 11;

            InitializeComponent();

            CalculationDGV.RowCount = rows;
            CalculationDGV.ColumnCount = columns;
        }

        private void SolveBTN_Click(object sender, EventArgs e)
        {
            CalculationDGV.Rows.Clear();
            CalculationDGV.Columns.Clear();
            CalculationDGV.RowCount = rows;
            CalculationDGV.ColumnCount = columns;

            CalculationDGV[0, 0].Value = " ";
            CalculationDGV[1, 0].Value = "X1";
            CalculationDGV[2, 0].Value = "X2";

            for (int i = 1; i < rows; i++)
                CalculationDGV[0, i].Value = "A" + Convert.ToString(i);

            // генерація координат в просторі змінних 

            double[][] variable = new double[rows - 1][];
            for (int i = 0; i < rows - 1; i++)
                variable[i] = new double[2];

            Random rand = new Random();
            for (int i = 0; i < rows - 1; i++)
            {
                for (int j = 0; j < 2; j++)
                {
                    int randValue = rand.Next(studentNumder - 3, studentNumder + 6);
                    CalculationDGV[j + 1, i + 1].Value = Convert.ToString(randValue);
                    variable[i][j] = (double)randValue;
                }
            }

            CalculationDGV[3, 0].Value = "Q1";
            CalculationDGV[4, 0].Value = "Q2";

            // генерація координат в просторі критеріїв 

            double[][] criterio = new double[rows - 1][];
            for (int i = 0; i < rows - 1; i++)
                criterio[i] = new double[2];

            for (int i = 0; i < rows - 1; i++)
            {
                criterio[i][0] = (studentNumder/4.0) * variable[i][0] + Math.Pow(variable[i][1], 2);
                criterio[i][1] = -2 * Math.Pow(variable[i][0], 2) + studentNumder * variable[i][1];
                CalculationDGV[3, i + 1].Value = Convert.ToString(criterio[i][0]);
                CalculationDGV[4, i + 1].Value = Convert.ToString(criterio[i][1]);
            }

            // відображення альтернатив на площині критеріїв 
            for (int i = 0; i < rows - 2; i++)
            {
                AlternativesTCH.Series[i].Points.Clear();
            }  
            for (int i = 0; i < rows - 2; i++) 
            {
                AlternativesTCH.Series[i].Points.AddXY(criterio[i][0], criterio[i][1]);
            }
            
            // обчислення Парето-оптимальних множин
            CalculationDGV[5, 0].Value = "Парето";

            List<double[]> listOfSets = new List<double[]>();
            List<double[]> listOfDominated = new List<double[]>();

            for (int i = 0; i < rows - 1; i++)
            {
                double[] item = new double[3];
                item[0] = criterio[i][0];
                item[1] = criterio[i][1];
                item[2] = i;
                listOfSets.Add(item);
            }

            bool shouldContinue = true;
            do
            {
                double[] currentItem = listOfSets[0];
                bool allIsNotCompatible = true;
                for (int i = 1; i < listOfSets.Count; i++)
                {
                    double[] item = listOfSets[i];                    
                    bool isCompatible = (item[0] >= currentItem[0] && item[1] <= currentItem[1]) || 
                                        (item[0] <= currentItem[0] && item[1] >= currentItem[1]);
                    if (!isCompatible)
                    {
                        allIsNotCompatible = false;
                        listOfDominated.Add(item);
                        listOfSets.RemoveAt(i);
                    }
                }

                if (allIsNotCompatible)
                {
                    break;
                }
            } while (shouldContinue);

            for (int i = 0; i < listOfSets.Count; i++)
            {
                double[] item = listOfSets[i];
                CalculationDGV[5, Convert.ToInt32(item[2] + 1)].Value = "П";
            }

            // обчислення значення критерія згортки
            CalculationDGV[6, 0].Value = "Згортка";
            double maxValue = int.MinValue;
            int indexOfMaxValue = -1;
            for (int i = 0; i < rows - 1; i++)
            {
                double value = 0.3 * criterio[i][0] + 0.7 * criterio[i][1];
                if (maxValue < value) {
                    maxValue = value;
                    indexOfMaxValue = i;
                }

                CalculationDGV[6, i + 1].Value = Convert.ToString(value);
            }

            CalculationDGV[6, indexOfMaxValue + 1].Style.BackColor= Color.Red;

            // пошук ідеальної точки
            double xIdeal = int.MinValue;
            double yIdeal = int.MinValue;
            for (int i = 0; i < rows - 1; i++)
            {
                if (criterio[i][0] > xIdeal)
                {
                    xIdeal = criterio[i][0];
                }

                if (criterio[i][1] > yIdeal)
                {
                    yIdeal = criterio[i][1];
                }
            }

            AlternativesTCH.Series[10].Points.Clear();
            AlternativesTCH.Series[10].Points.AddXY(xIdeal, yIdeal);

            // пошук найменшої відстані до ідеальної точки
            CalculationDGV[7, 0].Value = "Мін. відстань";
            int indexOfMinValue = int.MaxValue;
            double minValue = int.MaxValue;

            for (int i = 0; i < rows - 1; i++)
            {
                double distance = Math.Sqrt(Math.Pow(criterio[i][0] - xIdeal, 2) + Math.Pow(criterio[i][1] - yIdeal, 2));
                CalculationDGV[7, i + 1].Value = Convert.ToString(Math.Round(distance, 2));

                if (minValue > distance)
                {
                    minValue = distance;
                    indexOfMinValue = i;
                }
            }

            CalculationDGV[7, indexOfMinValue + 1].Style.BackColor = Color.Green;
        }        
    }
}
