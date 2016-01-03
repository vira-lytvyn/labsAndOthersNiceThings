using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace NeuroWeb_KSI_Lab_6
{
    public class RandomGenerator
    {
        private static Random random;

        public static void Init()
        {
            random = new Random(Convert.ToInt32(DateTime.Now.Millisecond));
        }

        public static double Gauss(double m, double sigma)
        {
            double sumTemp = 0;
            for (int i = 0; i < 5; i++)
            {
                sumTemp += random.NextDouble();
            }
            double ksiTemp = Math.Sqrt(12.0 / 5.0) * (sumTemp - 2.5);
            double ksi = m + sigma * (0.01 * ksiTemp * (97.0 + Math.Pow(ksiTemp, 2.0)));

            return ksi;
        }

        public static bool Boolean()
        {
            return (random.Next(2) == 1) ? true : false;
        }
    }
}
