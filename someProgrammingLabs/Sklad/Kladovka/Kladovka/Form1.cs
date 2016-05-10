using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;

namespace Kladovka
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }
        private TSklad MySklad;
        public static string GlStringParameter;

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

        private void записатиТаблицюToolStripMenuItem_Click(object sender, EventArgs e)
        {
            MySklad.ZapTabFile();
            MessageBox.Show("Таблиця записана");
        }

        private void зчитатиТаблицюToolStripMenuItem_Click(object sender, EventArgs e)
        {
            MySklad.ReadTabFile(DGSkladSum);
        }

        private void DGSklad_CellValueChanged(object sender, DataGridViewCellEventArgs e)
        {
            int i, j;
            decimal vart, kilk, cin;
            i = e.RowIndex;
            j = e.ColumnIndex;
            if (i < 0)     // якщо i<0 або j<0 то це заголовок стовпця або рядка
                return;
            if (j < 0)
                return;
            if ((DGSklad.Columns[j].Name == "Кількість") ^ (DGSklad.Columns[j].Name == "Ціна")) // якщо змінювалась ціна або кількість
            {
                try // Спробуємо, бо можливо ввели не числа у поле ціни або кількості
                {
                    cin = (decimal)DGSklad.Rows[i].Cells["Ціна"].Value; // Ціна
                    kilk = Convert.ToDecimal((Int32)DGSklad.Rows[i].Cells["Кількість"].Value); // Кількість
                    vart = kilk * cin;                                 //  Вартість
                    DGSklad.Rows[i].Cells["Вартість"].Value = vart; // Запишем вартість у чарунку гріда
                }
                catch { }
            }
            MySklad.SetSumy(DGSkladSum); // Обновимо підсумки
        }

        private void встановитиФільтрToolStripMenuItem_Click(object sender, EventArgs e)
        {
            Form FiltrDialog = new FServ();     // Створюєм екземпляр форми FServ і називаємо його FiltrDialog            
            // Встановимо текст заголовку форми FServ
            FiltrDialog.Text = "Введіть критерій фільтрування. Наприклад, Група='Книги' & Ціна<70";
            GlStringParameter = MySklad.FiltrCriteria;
            FiltrDialog.ShowDialog();   // Відкриєм форму у режимі діалогу. Це означає, що наступний оператор,
            // що слідує за оператором FiltrDialog.ShowDialog(); буде виконуватись лише після того,коли буде 
            // закрита форма, яку викликали, тут - FiltrDialog
            MySklad.TSkladValFiltr(GlStringParameter, DGSklad); //Виклик методу встановлення фільтру
        }

        private void знятиФільтрToolStripMenuItem_Click(object sender, EventArgs e)
        {
            GlStringParameter = "";
            MySklad.TSkladValFiltr(GlStringParameter, DGSklad);
        }

        private void встановитиКритерійСортуванняToolStripMenuItem_Click(object sender, EventArgs e)
        {
            Form SortDialog = new FServ();      // Створюєм екземпляр форми FServ і називаємо його SortDialog            
            // Встановимо текст заголовку форми FServ
            SortDialog.Text = "едіть критерій сортування. Наприклад, Виробник, Ціна Desc";
            GlStringParameter = MySklad.SortCriteria;
            SortDialog.ShowDialog();
            MySklad.TSkladValSort(GlStringParameter, DGSklad, DGSkladSum);
        }

        private void сортуватиПоГрупіToolStripMenuItem_Click(object sender, EventArgs e)
        {
            GlStringParameter = "Група, Назва";
            MySklad.TSkladValSort(GlStringParameter, DGSklad, DGSkladSum);
        }

        private void пошукПоНазвіToolStripMenuItem_Click(object sender, EventArgs e)
        {
            string sNazva;
            Form SeekDialog = new FServ();
            SeekDialog.Text = "Введіть назву";
            SeekDialog.ShowDialog();
            MySklad.SeekNazva(GlStringParameter, DGSklad);
        }
    }
}
