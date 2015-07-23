using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Generator
{
    public class RandomGenerator
    {
        private static Random random = new Random();

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


        public static double[][] GenerateSets(double mx1, double dx1, double mx2, double dx2, int count, int devidersCount)
        {
            double[][] results = new double[count][];
            for (int i = 0; i < count; i++)
                results[i] = new double[3];

            //генерування координат і бажаного значення на виході нейрона
            for (int i = 0; i < count; i++)
                if (i % 2 == 0)
                {
                    results[i][0] = Math.Abs(RandomGenerator.Gauss(mx1, dx1));
                    results[i][1] = Math.Abs(RandomGenerator.Gauss(mx1, dx1));

                    //бажане значення виходу
                    results[i][2] = 1;
                }
                else
                {
                    results[i][0] = Math.Abs(RandomGenerator.Gauss(mx2, dx2));
                    results[i][1] = Math.Abs(RandomGenerator.Gauss(mx2, dx2));
                    results[i][2] = 0;
                }

            return results;
        }
    }
}
