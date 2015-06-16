using System.Drawing;
using WaveAlg.Administrating;
using WaveAlg.HelperForms;

namespace WaveAlg.Helpers.Getters
{
    public class GettingFromOptions
    {
        /// <summary>
        /// Gets value from option form
        /// </summary>
        /// <param name="optionalWindow">our form</param>
        /// <returns>struct wich represents field of Option form</returns>
        public static OptionStruct Get(Options optionalWindow)
        {
            var optionStruct = new OptionStruct();
            if (optionalWindow != null)
            {
                optionStruct.BestWayEnabled = optionalWindow.BestWayEnabled.Checked;
                //optionStruct.AllWaysEnabled = optionalWindow.AllWaysEnabled.Checked;
                optionStruct.ZeroesPercentage = (int) optionalWindow.ZeroesPercent.Value;
                optionStruct.BestWayColor = optionalWindow.ColorPallete.Color;
            }
            else
            {
                optionStruct.BestWayEnabled = true;
                optionStruct.AllWaysEnabled = false;
                optionStruct.ZeroesPercentage = Constants.DEFAULT_MATRIX_PERCENTAGE;
                optionStruct.BestWayColor = Color.Red;
            }
            return optionStruct;
        }
    }
}
