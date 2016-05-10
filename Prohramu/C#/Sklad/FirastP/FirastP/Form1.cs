using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;

namespace FirastP
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private CSklad MySklad;

        private void Form1_Load(object sender, EventArgs e)
        {
            MySklad = new CSklad();
            DGSklad.DataSource = MySklad.TabSklad;
        }

        private void AddBut_Click(object sender, EventArgs e)
        {
            Decimal zPrice;
            Int32 zNum;
            if (TBGroup.Text== "" )
            {
                MessageBox.Show("Цей товар не належатиме до жодної групи ");
            }
            if (TBName.Text == "")
            {
                MessageBox.Show("Вкажіть назву товару");
                return;
            }
            if (TBAutor.Text == "")
            {
                MessageBox.Show("Виробник цієї продукції не вказаний");
            }

            try
            {
                zPrice = Convert.ToDecimal(TBPrice.Text);
            }
            catch
            {
                MessageBox.Show("Введіть числове значення ціни");
                return;
            }
            try
            {
                zNum = Convert.ToInt32(TBNum.Text);
            }
            catch 
            {
                MessageBox.Show("Введіть числове значення кількості");
                return;
            }
            MySklad.CAddRow(TBGroup.Text, TBName.Text, TBAutor.Text, zNum, zPrice );
        }
    }
}
