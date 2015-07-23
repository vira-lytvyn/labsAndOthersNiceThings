using System;
using System.Collections.Generic;

namespace NeronNetwork
{
    public class Culculation
    {
        double[] weights;           //початкові ваги
        double sgm;                 //параметри сигмоїда
        bool isTrained;             //змінна для перевірки чи навчена мережа
        int iterations;             //кількість ітерацій

        public int Iterations
        {
            get { return iterations; }
        }

        public Culculation()
        {
            sgm = 1;
            isTrained = false;
        }

        public double[] Weights
        {
            get { return weights; }
        }

        public bool IsTrained
        {
            get { return isTrained; }
        }

        public double testWithOnePair(double x1, double x2)
        {
            double sum = weights[0] * x1 + weights[1] * x2 + weights[2];
            return ActivationFunc(sum);
        }

        public void Run(double[][] patterns, double error, double speedEdu, double sgmParam, int maxIterations)
        {
                                                            //patterns - навчаючі пари
            const int N = 3; 
            int countPairs = patterns.Length;               //кількість навчаючих пар
            double[] OUT = new double[countPairs];          //значення виходів мережі
            double[] lError = new double[countPairs];       //похибка викоду мережі на кокретній навчаючій парі
            double dW = 0;                                  //змінна для коректування ваг
            double sum = 0;                                 //значення зважених входів
            double x3 = 1;                                   //додатковий вхід нейрона

            sgm = sgmParam;
            weights = new double[N];

            Random rand = new Random();
            //присвоєння початкових ваг
            for (int i = 0; i < N; i++)
                weights[i] = rand.NextDouble();

            isTrained = false;
            iterations = 0;

            while (true) 
            {
                for (int i = 0; i < countPairs; i++)
                {
                    sum = weights[0] * patterns[i][0] + weights[1] * patterns[i][1] + weights[2] * x3;
                    OUT[i] = ActivationFunc(sum);

                    // output error
                    lError[i] = 0.5 * (OUT[i] - patterns[i][2]) * (OUT[i] - patterns[i][2]);
                }

                bool isAllErrorsMatch = false;
                for (int i = 0; i < lError.Length; i++)
                {
                    if (Math.Abs(lError[i]) <= Math.Abs(error))
                    {
                        isAllErrorsMatch = true;
                    }
                    else
                    {
                        isAllErrorsMatch = false;
                        break;
                    }
                }

                if (isAllErrorsMatch == false)
                {
                    for (int i = 0; i < countPairs; i++)
                    {
                        dW = sgm * (OUT[i] - patterns[i][2]) * OUT[i] * (1 - OUT[i]);

                        //speedEdu - швидкість навчання
                        weights[0] -= speedEdu * dW * patterns[i][0];
                        weights[1] -= speedEdu * dW * patterns[i][1];
                        weights[2] -= speedEdu * dW * x3;
                    }
                }
                else
                {
                    isTrained = true;
                    break;
                }

                iterations++;
                if (iterations >= maxIterations)
                {
                    isTrained = false;
                    break;
                }
            }

            isTrained = true;
        }

        //функція активації
        private double ActivationFunc(double S)
        {
            return 1.0 / (1.0 + Math.Exp(-sgm * S));
        }
    }
}
