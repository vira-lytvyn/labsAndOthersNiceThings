using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;

namespace LM_MPP
{
    public partial class Form1 : Form
    {
        private int studentNumder;
        private int qCount;
        private int aCount;
        private int[][] marks;

        public Form1()
        {
            studentNumder = 7;
            qCount = 4;
            aCount = studentNumder+3;
            InitializeComponent();
            marks = new int[qCount][];
            for (int i = 0; i < 4; i++)
                marks[i] = new int[aCount];
            DataGV.RowCount = qCount + 1;
            DataGV.ColumnCount = aCount + 1;
        }

        private void SolveBtn_Click(object sender, EventArgs e)
        {
            generateData();
            int[] indexesOrder = new int[4] { 1, 0, 2, 3 };
            List<int> indexes = LexicographicalMethod(indexesOrder, aCount);
            for (int i = 0; i < indexes.Count; i++)
            {
                DataGV[indexes[i] + 1, 0].Style.BackColor = Color.Yellow;
            }
            indexesOrder = new int[4] { 3, 0, 1, 2 };
            indexes = LexicographicalMethod(indexesOrder, aCount);
            for (int i = 0; i < indexes.Count; i++)
            {
                DataGV[indexes[i] + 1, 0].Style.BackColor = Color.Fuchsia;
            }
            indexesOrder = new int[4] { 0, 1, 2, 3 };
            int[] postup = new int[3] { 1, 2, 3 };
            indexes = RebateMethod(indexesOrder, postup, aCount);
            for (int i = 0; i < indexes.Count; i++)
            {
                DataGV[indexes[i] + 1, 0].Style.BackColor = Color.Blue;
            }
        }
        //метод лексикографічної оптимізації
        private List<int> LexicographicalMethod(int[] indexesOrder, int colCount)
        {
            List<int> optIndex = new List<int>();
            for (int j = 0; j < colCount; j++)
                optIndex.Add(j);
            for (int i = 0; i < indexesOrder.Length; i++)
            {
                int index = indexesOrder[i];
                int max = int.MinValue;
                for (int j = 0; j < optIndex.Count; j++)
                {
                    if (max < marks[index][optIndex[j]])
                        max = marks[index][optIndex[j]];
                }
                List<int> copied = new List<int>(optIndex);
                optIndex.Clear();
                for (int j = 0; j < copied.Count; j++)
                    if (max == marks[index][copied[j]])
                        optIndex.Add(copied[j]);
                if (optIndex.Count == 1)
                    break;
            }
            return optIndex;
        }
        // метод послідовних поступок
        private List<int> RebateMethod(int[] indexesOrder, int[] postup, int colCount)
        {
            List<int> optIndex = new List<int>();
            for (int j = 0; j < colCount; j++)
                optIndex.Add(j);
            for (int i = 0; i < indexesOrder.Length; i++)
            {
                int index = indexesOrder[i];
                int max = int.MinValue;
                List<int> indexesToRemove = new List<int>();
                for (int j = 0; j < optIndex.Count; j++)
                {
                    if (max < marks[index][optIndex[j]])
                        max = marks[index][optIndex[j]];
                }
                List<int> copied = new List<int>(optIndex);
                optIndex.Clear();
                for (int j = 0; j < copied.Count; j++)
                    if (max == marks[index][copied[j]])
                        optIndex.Add(copied[j]);
                if (i < 3)
                {
                    for (int j = 0; j < colCount; j++)
                        if (max - postup[i] == marks[index][j])
                            optIndex.Add(j);
                }
                else
                {   break;   }
            }
            return optIndex;
        }
        // генерація і відображення оцінок 
        private void generateData()
        {
            DataGV.Rows.Clear();
            DataGV.Columns.Clear();
            DataGV.RowCount = qCount + 1;
            DataGV.ColumnCount = aCount + 1;
            DataGV[0, 0].Value = "";
            for (int i = 1; i <= qCount; i++)
                DataGV[0, i].Value = "Q" + Convert.ToString(i);
            for (int i = 1; i <= aCount; i++)
                DataGV[i, 0].Value = "A" + Convert.ToString(i);

            Random rand = new Random();
            for (int i = 1; i <= qCount; i++)
                for (int j = 1; j <= aCount; j++)
                {
                    int value = rand.Next(5) + 1;
                    marks[i - 1][j - 1] = value;
                    DataGV[j, i].Value = Convert.ToString(value);
                }
        }
    }
}
