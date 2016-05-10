using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;

namespace SNARNuton
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        public byte n = 3;
        public double[] F = new double[3];
        public double[] XP = new double[3] { 0.75, 1.5, 4.0 };
        public double[] X = new double[3];
        public double[,] JA = new double[3, 3];
        public double Q;
        public double[] Dx = new double[3];               
        public double Dxm;
        public double h;
        public double eps = 0.001;

        public void Gauss(double[,] A, double[] B, byte n)  //метод Гауса для розв"язування систем лінійних р-нянь
        {
            int i, j, k;
            double R;
            if (n == 1)
            {
                if (Math.Abs(A[0, 0]) < eps)
                {
                    MessageBox.Show("Система вироджена");
                    return;
                }
                else
                {
                    Dx[0] = B[0] / A[0, 0];
                    return;
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
                    MessageBox.Show("Система вироджена");
                    return;
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
                MessageBox.Show("Система вироджена");
                return;
            }
            //зворотній хід
            Dx[n - 1] = B[n - 1] / A[n - 1, n - 1];
            for (i = n - 2; i >= 0; i--)
            {
                R = B[i];
                for (j = i + 1; j < n; j++)
                    R -= A[i, j] * Dx[j];
                Dx[i] = R;
            }
        }


        public void Newt_Iter(double t)
        {
            byte i;
            double[] FI = new double[3]; //вектор для зберігання поточних значень с-ми нелінійних алгебричних р-нянь
            FM(t, XP);
            Jacob(XP, t);
            for (i = 0; i < n; i++)
                FI[i] = XP[i] - X[i] - h * F[i];
            Gauss(JA, FI, n);
            Dxm = 0;
            for (i = 0; i < n; i++)
            {
                XP[i] -= Dx[i];
                if (Dxm < Math.Abs(Dx[i]))
                    Dxm = Math.Abs(Dx[i]);
            }
        }

        public void Jacob(double[] XP, double t)
        {
            byte i, j;
            Jac(XP, t);
            for (i = 0; i < n; i++)
            {
                for (j = 0; j < n; j++)
                    JA[i, j] = -h * JA[i, j];
                JA[i, i] = 1 + JA[i, i];
            }
        }

        public void FM(double t, double[] X)
        {
            F[0] = X[0] + Math.Exp(X[0] - 1) + (X[1] + X[2]) * (X[1] + X[2]) - 27;
            F[1] = X[0] + Math.Exp(X[1] - 2) + X[2] * X[2]  - 10;
            F[2] = X[2] + Math.Sin(X[1] - 2) + X[1] * X[1] - 7;
        }

        public void Jac(double[] X, double t)
        {
            byte i, j;
            double[] F1 = new double[3];
            FM(t, X);
            for (i = 0; i < n; i++)
                F1[i] = F[i];                               //вектор ф-ції від незбуреного вектора Х
            for (j = 0; j < n; j++)
            {
                X[j] = X[j] + Q;
                FM(t, X);
                for (i = 1; i < n; i++)
                    JA[i, j] = (F[i] - F1[i]) / Q;          //обчислення [i, j] компоненти матриці Якобі                        
                X[j] -= Q;                                  //зняття збурення компоненти вектора Х
            }
        }

        private void button1_Click(object sender, EventArgs e)
        {
            //n=0.223;
            //E=1.629e10;

            //AWs=1.385;
            //Ass=1.6;
            
            //Wv=5.0e28;
            //e0=8.85e-12;
            //zB=3.7e-11;

            ////t=1.83597e10

            //px=-1e5;
            //py = -1e5;
            Q = eps / 1000;
            Newt_Iter(0);
            label1.Text = Dx[0] + "   " + Dx[1] + "   " + Dx[2];
        }
    }
}
