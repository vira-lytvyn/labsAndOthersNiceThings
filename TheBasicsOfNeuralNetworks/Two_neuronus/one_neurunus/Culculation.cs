﻿using System;
using System.Collections.Generic;
using Generator;

namespace NeronNetwork
{
    public class Culculation
    {
        double[][] weights;         //початкові ваги
        double[] weightsRes;        //початкові ваги другого шару
        double sgm;                 //параметри сигмоїда
        bool isTrained;             //змінна для перевірки чи навчена мережа
        int iterations;             //кількість ітерацій
        int devCount;               //кількість нейронів другого шару

        public int Iterations
        {
            get { return iterations; }
        }

        public Culculation()
        {
            sgm = 1;
            isTrained = false;
        }

        public double[][] Weights
        {
            get { return weights; }
        }

        public bool IsTrained
        {
            get { return isTrained; }
        }

        public void Run(double[][] patterns, double error, double speedEdu, double sgmParam, int maxIterations, int devidersCount)
        {
                                                            //patterns - навчаючі пари
            const int N = 3;
            int N2 = devidersCount;
            int countPairs = patterns.Length;               //кількість навчаючих пар
            double[] OUT = new double[countPairs];          //значення виходів мережі 
            double[][] OUTFirst;
            double[] lError = new double[countPairs];       //похибка викоду мережі на кокретній навчаючій парі
            double dError;
            double gError = 0;                              //загальна похибка мережі
            double dW = 0;                                  //змінна для коректування ваг
            double[] sumFirst = new double[N2];                                 //значення зважених входів першого шару
            double sum = 0;                                 //значення зважених входів
            double x = 1;                                   //додатковий вхід нейрона
            OUTFirst = new double[countPairs][];
            for (int i = 0; i < countPairs; i++)
                OUTFirst[i] = new double[N2];

            sgm = sgmParam;

            weights = new double[N][];
            for (int i = 0; i < N; i++)
                weights[i] = new double[N2];

            weightsRes = new double[N2];
            
            //занулення початкових сум першого шару
            for (int i = 0; i < N2; i++)
                sumFirst[i] = 0;

            //присвоєння початкових ваг
            for (int i = 0; i < N; i++)
                for (int j = 0; j<N2; j++)
                    weights[i][j] = 0.5;

            isTrained = false;
            iterations = 0;
            
            do
            {
                gError = 0;
                for (int i = 0; i < countPairs; i++)
                {
                    for (int j = 0; j < devidersCount; j++ )
                    {
                        sumFirst[j] = weights[0][j] * patterns[i][0] + weights[1][j] * patterns[i][1] + weights[2][j] * x;
                        OUTFirst[i][j] = ActivationFunc(sumFirst[j]);
                    }
                    
                    //похибка виходу
                    lError[i] = 0.5 * (OUT[i] - patterns[i][2]) * (OUT[i] - patterns[i][2]);
                    gError += lError[i];
                }

                //загальна похибка мережі
                gError = gError / countPairs;
                if (gError > error)
                {
                    //коректування ваг
                    iterations++;
                    for (int i = 0; i < countPairs; i++)
                    {
                        dW = -sgm * (OUT[i] - patterns[i][2]) * OUT[i] * (1 - OUT[i]);
                        dError = dW * lError[i];
                        weights[0] += speedEdu * dError * patterns[i][1];
                        weights[1] += speedEdu * dError * patterns[i][0];
                        weights[2] += speedEdu * dError * x;
                    }
                }
                else break;

                //заврешення, якщо перевищено ліміт ітерацій
                if (iterations == maxIterations)
                {
                    isTrained = true;
                    break;
                }




                //проходження по всіх навчаючих парах
                gError = 0;
                for (int i = 0; i < countPairs; i++)
                {
                    sum = weights[0] * patterns[i][0] + weights[1] * patterns[i][1] + weights[2] * x;
                    OUT[i] = ActivationFunc(sum);
                    //похибка виходу
                    lError[i] = 0.5 * (OUT[i] - patterns[i][2]) * (OUT[i] - patterns[i][2]);
                    gError += lError[i];
                }

                //загальна похибка мережі
                gError = gError / countPairs;
                if (gError > error)
                {
                    //коректування ваг
                    iterations++;
                    for (int i = 0; i < countPairs; i++)
                    {
                        dW = -sgm * (OUT[i] - patterns[i][2]) * OUT[i] * (1 - OUT[i]);
                        dError = dW * lError[i];                        
                        weights[0] += speedEdu * dError * patterns[i][1];
                        weights[1] += speedEdu * dError * patterns[i][0];
                        weights[2] += speedEdu * dError * x;
                    }
                }
                else break;

                //заврешення, якщо перевищено ліміт ітерацій
                if (iterations == maxIterations)
                {
                    isTrained = true;
                    break;
                }
            }
            while (gError > error);

            isTrained = true;
        }

        //функція активації
        private double ActivationFunc(double S)
        {
            return 1.0 / (1.0 + Math.Exp(-sgm * S));
        }
    }
}
