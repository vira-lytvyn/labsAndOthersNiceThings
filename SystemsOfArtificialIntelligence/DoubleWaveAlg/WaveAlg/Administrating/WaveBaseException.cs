using System;
using System.Windows.Forms;

namespace WaveAlg.Administrating
{
    public class WaveBaseException : Exception
    {
        public WaveBaseException()
        {
            MessageBox.Show(Constants.SOME_ERROR_ACCURD);
        }
    }

}
