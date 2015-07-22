using System;
using System.Numerics;
using System.Windows.Forms;

namespace RSAAlgoritm
{
    public class Manager
    {
        private int _privateKey = 0;

        private int secretN = 0;

        public void CryptManager(MainApp app)
        {
            if (app.PPrime.Text == string.Empty)
            {
                MessageBox.Show(Constants.SomethingWrongWithEncryption);
            }
            if (app.QPrime.Text == string.Empty)
            {
                MessageBox.Show(Constants.SomethingWrongWithEncryption);
            }

            var pPrime = Convert.ToInt32(app.PPrime.Text);

            var qPrime = Convert.ToInt32(app.QPrime.Text);

            var N = KeyManager.CreateN(pPrime, qPrime);

            secretN = N;

            var phaserNumber = KeyManager.ComputePhaser(pPrime, qPrime);

            var encryptkey = KeyManager.GetCoPrimeNumber(phaserNumber);

            _privateKey = KeyManager.ModInverse(encryptkey, phaserNumber);

            app.CryptedText.Text = BigInteger.ModPow
                (Convert.ToInt64(app.EnterText.Text), encryptkey, N).ToString();
            app.Decrypt.Enabled = true;
        }

        public void DecryptManager(MainApp app)
        {
            if (_privateKey == 0)
            {
                throw new Exception();
            }

            var cryptedText = Convert.ToInt32(app.CryptedText.Text);

            app.DecryptedText.Text = BigInteger.ModPow(cryptedText, _privateKey, secretN).ToString();

        }
    }
}
