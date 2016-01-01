using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;

namespace ResoursesManager
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private void SolveBtn_Click(object sender, EventArgs e)
        {
            double pdCount = Convert.ToDouble(PDCountTB.Text);// K1
            double pdSavePerYear = Convert.ToDouble(PDSaveTB.Text); // H1
            double orderPey = Convert.ToDouble(OrderPayTB.Text); // K
            int workingDays = Convert.ToInt16(WorkingDaysTB.Text); // N1
            int orderTime = Convert.ToInt16(OrderTermTB.Text); // T
            int dailyCount = Convert.ToInt16(pdPerDay.Text); // D = K1/N1

            double optimalSize = Math.Round(Math.Sqrt((2 * dailyCount * orderPey * workingDays) / pdSavePerYear), 2);
            double orderExpenses = Math.Round(((orderPey * dailyCount) / optimalSize) * workingDays, 2);
            double savingExpenses = Math.Round((optimalSize * pdSavePerYear) / 2, 2);
            double generalExpenses = Math.Round(orderExpenses + savingExpenses, 2);
            double dumpPoint = dailyCount * orderTime;
            double orderDistanse = optimalSize / dailyCount;
            if (orderTime > orderDistanse) 
            {
                dumpPoint = Math.Round(dailyCount * (orderTime - 1 * orderDistanse), 0);
            }

            OrderSizeTB.Text = Convert.ToString(optimalSize);
            SpendPreYearTB.Text = Convert.ToString(orderExpenses);
            RPointTB.Text = Convert.ToString(dumpPoint);
            SaveSpendTB.Text = Convert.ToString(savingExpenses);
            MoneyPerYearTB.Text = Convert.ToString(generalExpenses);
        }
    }
}
