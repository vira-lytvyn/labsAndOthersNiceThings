using System;
using System.Windows.Forms;

namespace Qschema
{
    public partial class MainApp : Form
    {
        public MainApp()
        {
            InitializeComponent();
        }

        public bool Started = true;

        public DateTime StartedDateTime;

        private void Find_Click(object sender, EventArgs e)
        {
            StartedDateTime = DateTime.Now;
            Manager.Manage(this);
        }

        private void Stopper_Click(object sender, EventArgs e)
        {
            Started = false;
        }
    }
}
