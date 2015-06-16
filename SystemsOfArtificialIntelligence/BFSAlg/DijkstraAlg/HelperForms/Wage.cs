using System;
using System.Windows.Forms;
using DijkstraAlg.Administrating;

namespace DijkstraAlg.HelperForms
{
    public partial class Wage : Form
    {
        public Wage()
        {
            InitializeComponent();
            IsOver = false;
            SetWage.Text = Constants.EDGE_WAGE_DEFAULT;
        }

        public bool IsOver = false;

        private void SetWage_button_Click(object sender, EventArgs e)
        {
            try
            {
                var currentValue = Convert.ToInt32(SetWage.Text);
                if (currentValue < 1)
                {
                    throw new Exception();
                }
                IsOver = true;
                Close();
            }
            catch (Exception)
            {
                var dialogResult = MessageBox.Show(Constants.WRONG_EDGE_WAGE, Constants.WRONG_EDGE_WAGE_CAPTION, 
                    MessageBoxButtons.OKCancel);
                if (dialogResult == DialogResult.Cancel)
                {
                    SetWage.Text = Constants.EDGE_WAGE_DEFAULT;
                    IsOver = true;
                    Close();
                }
            }
        }
    }
}
