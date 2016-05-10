using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace GaussConsole
{
    class Program
    {
        public static double[] X = new double[20];
        public const double eps = 0.00001;

        public static void Gauss(double[,] A, double[] B, int n)  //метод Гауса для розв"язування систем лінійних р-нянь
        {
            int i, j, k;
            double R;
            if (n == 1)
            {
                if (Math.Abs(A[0, 0]) < eps)
                {
                    Console.WriteLine("Система вироджена");
                    Console.ReadLine();
                    //return;
                }
                else
                {
                    X[0] = B[0] / A[0, 0];
                    Console.ReadLine();
                   // return;
                }
            }
            for (i = 0; i < n - 1; i++)
            {
                k = i;
                R = Math.Abs(A[i, i]);
                for (j = i + 1; j < n; j++)
                    if (Math.Abs(A[j, i]) >= R)
                    {
                        k = j;
                        R = Math.Abs(A[j, i]);
                    }
                if (R <= eps)
                {
                    Console.WriteLine("Система вироджена");
                    Console.ReadLine();
                    //return;
                }
                //якщо діагональний елемент не найбільший, переставляємо рядки
                if (k != i)
                {
                    R = B[k];
                    B[k] = B[i];
                    B[i] = R;
                    for (j = i; j < n; j++)
                    {
                        R = A[k, j];
                        A[k, j] = A[i, j];
                        A[i, j] = R;
                    }
                }
                R = A[i, i];
                B[i] = B[i] / R;
                for (j = 0; j < n; j++)
                    A[i, j] = A[i, j] / R;
                for (k = i + 1; k < n; k++)
                {
                    R = A[k, i];
                    B[k] -= R * B[i];
                    A[k, i] = 0;
                    for (j = i + 1; j < n; j++)
                        A[k, j] -= R * A[i, j];
                }
            }
            if (Math.Abs(A[n - 1, n - 1]) <= eps)
            {
                Console.WriteLine("Система вироджена");
                Console.ReadLine();
                //return;
            }
            //зворотній хід
            X[n - 1] = B[n - 1] / A[n - 1, n - 1];
            for (i = n - 2; i >= 0; i--)
            {
                R = B[i];
                for (j = i + 1; j < n; j++)
                    R -= A[i, j] * X[j];
                X[i] = R;
            }
        }

        static void Main(string[] args)
        {
            int N, i, j, m;

            Console.WriteLine("Vvedit rozmiry matrytsi:");
            Console.WriteLine("N=");
            N = Convert.ToInt32(Console.ReadLine());
            Console.WriteLine("M=");
            m = Convert.ToInt32(Console.ReadLine());

            double[,] A = new double[m, N];
            double[] B = new double[m];

            Console.WriteLine("Vvedit matrytsju A[{0},{1}]", m, N);
            for (i = 0; i < m; i++)
            {
                for (j = 0; j < N; j++)
                {
                    Console.Write("a[{0},{1}]=", i + 1, j + 1);
                    A[i, j] = Convert.ToInt32(Console.ReadLine());
                }
                Console.WriteLine();
            }
            Console.WriteLine("Vvedit vector B[{0}]", m);
            for (i = 0; i < m; i++)
            {
                Console.Write("b[{0}]=", i + 1);
                B[i] = Convert.ToInt32(Console.ReadLine());

            }
            Gauss(A, B, N);

            Console.WriteLine("Rezultat X[{0}]", N);
            for (i = 0; i < N; i++)
            {
                Console.Write("x[{0}]={1}\t", i + 1, X[i]);
                Console.ReadLine();
            }
        }
    }
}
