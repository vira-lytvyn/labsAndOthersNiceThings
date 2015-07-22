using System.Windows.Forms;

namespace RSAAlgoritm
{
    public partial class MainApp : Form
    {
        public MainApp()
        {
            InitializeComponent();

            Decrypt.Enabled = false;
        }

        private readonly Manager _manager = new Manager();

        private void Crypt_Click(object sender, System.EventArgs e)
        {

            _manager.CryptManager(this);
        }

        private void Decrypt_Click(object sender, System.EventArgs e)
        {
            _manager.DecryptManager(this);
        }

        private void EnterText_TextChanged(object sender, System.EventArgs e)
        {
            CryptedText.Text = string.Empty;
            DecryptedText.Text = string.Empty;
            Decrypt.Enabled = false;
        }

        private void generateKeysToolStripMenuItem_Click(object sender, System.EventArgs e)
        {
            var generator = new Generator();
            var genereted = generator.GeneratePAndQ();
            PPrime.Text = genereted.ToString();
            QPrime.Text = generator.GeneratePAndQ(genereted).ToString();
        }
    }
}
