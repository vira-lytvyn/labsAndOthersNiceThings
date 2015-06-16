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

namespace WaveAlg.HelperForms
{
    public partial class About : Form
    {
        public About()
        {
            InitializeComponent();
            AboutField.Text = Constants.ABOUT_FIELD;
        }
    }
}
