using System.Collections.Generic;
using System.Drawing;
using System.Globalization;
using System.Windows.Forms;
using WaveAlg.Administrating;
using WaveAlg.Helpers;
using WaveAlg.Helpers.Validator;
using WaveAlg.WayManipulation;

namespace WaveAlg
{
    public static class Manager
    {
        private static List<Point> forDrawCircleMethod;

        private static List<Point> forDrawCrossMethod;
        /// <summary>
        /// Generate our matrix
        /// </summary>
        /// <param name="app">our main form</param>
        public static void StartGenerate(MainApp app)
        {
            var generator = new MatrixValueGenerator();
            ClearField(app);
            generator.Generate(app.DataMatrix, app.GetZeroesPercentage);
        }

        /// <summary>
        /// Find All ways
        /// </summary>
        /// <param name="app">our main form</param>
        public static void StartFindWay(MainApp app)
        {
            var finder = new FindWay();
            var result = 0;
            if (app.CrossMethod.Checked)
            {
                result = finder.FindWayFromStoEWithCross(app);
            }
            if (app.CircleMethod.Checked)
            {
                result = finder.FindWayFromStoEWithCircle(app);
            }

            var validator = new Validator();
            var isValidForDrawing = validator.IsValidForDrawing(app);
            var isExistDublicates = validator.ExistDublicatesControlWords(app);
            if (isExistDublicates)
            {
                MessageBox.Show(Constants.DUBLICATE_CONTROL_WORDS);
            }
            else
            {
                app.BestResult.Text = isValidForDrawing
                    ? result.ToString(CultureInfo.InvariantCulture)
                    : Constants.RESULT_IS_NOT_VALID;

                if (app.CircleMethod.Checked)
                {
                    forDrawCircleMethod = GetBestWayForFurther.FindCircleBestWay(app);
                    DoubleWaveAlgUpdater.UpdateCells(app, result);
                }

                if (app.CrossMethod.Checked)
                {
                    forDrawCrossMethod = GetBestWayForFurther.FindCrossBestWay(app);
                    DoubleWaveAlgUpdater.UpdateCells(app, result);
                }
            }
        }

        /// <summary>
        /// Draw the best Way
        /// </summary>
        /// <param name="app">our main form</param>
        public static void DrawBestWay(MainApp app)
        {
            var bestWayFinder = new BestWayFinder();
            //bestWayFinder.FindBestWay(app);
            if (app.CrossMethod.Checked)
            {
                bestWayFinder.Draw(app.DataMatrix, Color.Red, forDrawCrossMethod);
                AddPath.AddBestPath(app, forDrawCrossMethod);
            }
            else
            {
                bestWayFinder.Draw(app.DataMatrix, Color.Red, forDrawCircleMethod);
                AddPath.AddBestPath(app, forDrawCircleMethod);
            }
        }

        public static void ClearField(MainApp app)
        {
            ClearFieldMatrix.Clear(app);
        }
    }
}
