using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;

namespace Sklad_SQL
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private TSklad MySklad;

        private void Form1_Load(object sender, EventArgs e)
        {
            // Створимо екземпляр класу TSklad
            MySklad = new TSklad();
            // Прив'яжемо DataGridView, що на формі Form1 до SkladView, який поставлений на таблицю TabSklad:
            DGSklad.DataSource = MySklad.TabSklad;
        }

        private void BAddRowToTable_Click(object sender, EventArgs e)
        {
            // Значення ціни і кількості слід перетворити із текстового формату у формат Decimal та int32
            // Оскільки користувач може ввести невідповідну інформацію, то слід використати механізм try
            Decimal pPcina; Int32 pKilkist; 
            try
            {
                pPcina = Convert.ToDecimal(TBCina.Text);
            }
            catch
            {
                MessageBox.Show("Введіть у поле ціни числове значення");
                return;
            }
            try
            {
                pKilkist = Convert.ToInt32(TBKilkist.Text);
            }
            catch
            {
                MessageBox.Show("Введіть у поле кількості числове значення");
                return;
            }      
            MySklad.TSkladAddRow(TBGrupa.Text, TBNazva.Text, TBVyrobnyk.Text, pKilkist, pPcina);
        }
    }
}