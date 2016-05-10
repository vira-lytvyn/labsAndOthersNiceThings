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
    public partial class FServ : Form
    {
        public FServ()
        {
            InitializeComponent();
            FservTB.Text = Form1.GlStringParameter;     // якщо фільтр уже був, то запишем його відразу у вікно вводу
        }

        private void FservBOk_Click(object sender, EventArgs e)
        {
            Form1.GlStringParameter = FservTB.Text;     // Записати введений критерій у основну форму
            Close();    //Закрити форму FServ щоб далі продовжувалось виконання програми
        }
    }
}
