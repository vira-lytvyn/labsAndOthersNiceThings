using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;

namespace MaxMinQ
{
    public partial class MaxMinForm : Form
    {
        private int qCount;
        private int aCount;
        public MaxMinForm()
        {
            qCount = 5;
            aCount = 10;
            InitializeComponent();

            MaxMinDataGV.ColumnCount = aCount + 1;
            MaxMinDataGV.RowCount = qCount + 3;
            
        }

        private void Solve_Click(object sender, EventArgs e)
        {
            MaxMinDataGV[0, 0].Value = "Критерій/Альтернатива";
            for (int i = 1; i <= qCount; i++)
                MaxMinDataGV[0, i].Value = "Q" + Convert.ToString(i);
            for (int i = 1; i <= aCount; i++)
                MaxMinDataGV[i, 0].Value = "A" + Convert.ToString(i);
            MaxMinDataGV[0, qCount + 1].Value = "min";

            double[][] data = new double[qCount][];
            for (int i = 0; i < qCount; i++)
                data[i] = new double[aCount];

            Random rand = new Random();
            for (int i = 0; i < qCount; i++)
            {
                int randValue = rand.Next(7) + 1;
                for (int j = 0; j < aCount; j++)
                {
                    int randValue2 = rand.Next(7) + 1;
                    MaxMinDataGV[j + 1, i + 1].Value = Convert.ToString(randValue2) + "/" + Convert.ToString(randValue);
                    data[i][j] = ((double)randValue2) / (double)randValue;
                }
            }

            double minForColumn = int.MaxValue; ;
            double maxAmongFindedMins = int.MinValue;
            int maxColumntIndex = 0;
            for (int i = 0; i < aCount; i++)
            {
                minForColumn = int.MaxValue;
                for (int j = 0; j < qCount; j++)
                {
                    if (minForColumn > data[j][i])
                    {
                        minForColumn = data[j][i];
                        MaxMinDataGV[i + 1, qCount + 1].Value = MaxMinDataGV[i + 1, j + 1].Value;
                    }
                }

                if (maxAmongFindedMins < minForColumn)
                {
                    maxAmongFindedMins = minForColumn;
                    maxColumntIndex = i;
                }

                MaxMinDataGV[i+1, qCount + 2].Value = "";
            }

            MaxMinDataGV[maxColumntIndex + 1, qCount + 2].Value = "max";
        }
    }
}
