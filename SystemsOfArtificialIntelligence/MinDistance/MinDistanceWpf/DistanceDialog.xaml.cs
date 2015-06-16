using System.Windows;

namespace MinDistanceWpf
{
    /// <summary>
    /// Interaction logic for DistanceDialog.xaml
    /// </summary>
    public partial class DistanceDialog : Window
    {
        private double _distance;
        public DistanceDialog()
        {
            InitializeComponent();
            _distance = 0.0;
        }

        private void okBtn_Click(object sender, RoutedEventArgs e)
        {
            if (!string.IsNullOrEmpty(distanceTextBox.Text) && double.TryParse(distanceTextBox.Text, out _distance) &&
                _distance > 0.0)
                this.DialogResult = true;
            else
            {
                _distance = 10;
                MessageBox.Show("Wrong Value, we will put constant 10 if you will " +
                                "not change your dessison", "Error", MessageBoxButton.OK, 
                                MessageBoxImage.Exclamation);
            }
        }

        public double Distance
        {
            get { return _distance; }
        }

        private void Window_Closing(object sender, System.ComponentModel.CancelEventArgs e)
        {
            if (_distance == 0.0)
                this.DialogResult = false;
        }

        private void Window_Loaded(object sender, RoutedEventArgs e)
        {
            distanceTextBox.Focus();
        }
    }
}
