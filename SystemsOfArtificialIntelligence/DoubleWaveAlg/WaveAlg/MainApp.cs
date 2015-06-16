using System;
using System.Drawing;
using System.Windows.Forms;
using WaveAlg.Administrating;
using WaveAlg.HelperForms;
using WaveAlg.Helpers;
using WaveAlg.Helpers.Getters;
using WaveAlg.Helpers.Validator;

namespace WaveAlg
{
    public partial class MainApp : Form
    {
        public MainApp()
        {
            InitializeComponent();
            GetFirstValues();
        }

        private Options _optionalWindow;
        private readonly Validator _validator = new Validator();

        public bool GetBestWayEnabled { get; set; }

        public bool GetAllWaysEnabled { get; set; }

        public int GetZeroesPercentage { get; set; }

        public Color GetColor { get; set; }

        private void Size_ValueChanged(object sender, EventArgs e)
        {
            if (NumSize.Value < Constants.MIN_MATRIX_SIZE || NumSize.Value > Constants.MAX_MATRIX_SIZE)
            {
                MessageBox.Show(Constants.WRONG_SIZE_MESSAGE);
                NumSize.Value = Constants.DEFAULT_MATRIX_SIZE;
            }
            else
            {
                DataMatrix.RowCount = (int)NumSize.Value;
                DataMatrix.ColumnCount = (int)NumSize.Value;
            }
        }

        private void Generator_Click(object sender, EventArgs e)
        {
            Intializator();
            Manager.StartGenerate(this);
        }

        private void FindWay_Click(object sender, EventArgs e)
        {
            Intializator();
            if (_validator.IsValidForFindBestWay(this))
            {
                Manager.StartFindWay(this);
            }
            else
            {
                MessageBox.Show(Constants.VALID_ENTER_DATA);
            }
        }

        private void exitToolStripMenuItem_Click(object sender, EventArgs e)
        {
            Application.Exit();
        }

        private void optionsToolStripMenuItem1_Click(object sender, EventArgs e)
        {
            Intializator();
            _optionalWindow = new Options(this)
            {
                BestWayEnabled = {Checked = GetBestWayEnabled},
                ZeroesPercent = {Value = GetZeroesPercentage}
            };
            _optionalWindow.Show();
            //DrawBestWay.Enabled = GetBestWayEnabled;
        }

        #region not control methods

        private void GetFirstValues()
        {
            NumSize.Value = Constants.DEFAULT_MATRIX_SIZE;
            CrossMethod.Checked = true;
            DownloadTooltips();
        }

        private void Intializator()
        {
            var dataFromOptionalWindow = GettingFromOptions.Get(_optionalWindow);
            GetBestWayEnabled = dataFromOptionalWindow.BestWayEnabled;
            GetAllWaysEnabled = dataFromOptionalWindow.AllWaysEnabled;
            GetZeroesPercentage = dataFromOptionalWindow.ZeroesPercentage;
            GetColor = dataFromOptionalWindow.BestWayColor;
            UpdateCellFontColor.UpdateFontColor(Color.Black, DataMatrix);
            BestResult.Text = string.Empty;
            Path.Text = string.Empty;
        }

        private void DownloadTooltips()
        {
            TooltipManager.SetToolTip(Generator, Constants.GenerateTooltip);
            TooltipManager.SetToolTip(FindWay, Constants.FindWayTooltip);
            TooltipManager.SetToolTip(BestResult, Constants.BestResultTooltip);
            TooltipManager.SetToolTip(NumSize, Constants.NumSizeTooltip);
            TooltipManager.SetToolTip(Clear, Constants.ClearTooltip);
            //TooltipManager.SetToolTip(DrawBestWay, Constants.DrawBestWay);
        }

        #endregion

        private void aboutWaveAlgToolStripMenuItem_Click(object sender, EventArgs e)
        {
            var aboutWindow = new About();
            aboutWindow.Show();
        }

        private void DrawBestWay_Click(object sender, EventArgs e)
        {
            Intializator();
            var isValid = _validator.IsValidForDrawing(this);
            if (isValid)
            {
                Manager.DrawBestWay(this);
            }
            else
            {
                MessageBox.Show(Constants.VALID_ENTER_DATA);
            }
        }

        private void Clear_Click(object sender, EventArgs e)
        {
            Manager.ClearField(this);
        }

        private void DrawBestWay_Click_1(object sender, EventArgs e)
        {
            Manager.DrawBestWay(this);
        }

    }
}
