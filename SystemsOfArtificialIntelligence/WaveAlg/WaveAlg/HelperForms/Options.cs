using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using WaveAlg.Administrating;
using WaveAlg.Helpers;

namespace WaveAlg.HelperForms
{
    public partial class Options : Form
    {
        private MainApp _app;

        public Options(MainApp app)
        {
            InitializeComponent();
            _app = app;
            BestWayEnabled.Checked = true;
            //AllWaysEnabled.Checked = false;
            ZeroesPercent.Value = Constants.DEFAULT_MATRIX_PERCENTAGE;
            ColorPallete.Color = Color.Red;
            DownloadToolTips();
        }

        private void ZeroesPercent_ValueChanged(object sender, EventArgs e)
        {
            if (ZeroesPercent.Value >= 3) return;
            MessageBox.Show(Constants.WRONG_SIZE_MESSAGE);
            ZeroesPercent.Value = Constants.DEFAULT_MATRIX_PERCENTAGE;
        }

        private void DownloadToolTips()
        {
            TooltipManager.SetToolTip(BestWayEnabled, Constants.BestWayTooltip);
            //TooltipManager.SetToolTip(AllWaysEnabled, Constants.AllWaysTooltip);
            TooltipManager.SetToolTip(ZeroesPercent, Constants.ZeroePercentageTooltip);
        }

        private void BestWayEnabled_CheckedChanged(object sender, EventArgs e)
        {
            _app.DrawBestWay.Enabled = BestWayEnabled.Checked;
        }

        private void ColorSet_Click(object sender, EventArgs e)
        {
            ColorPallete.ShowDialog();
        }

    }
}
