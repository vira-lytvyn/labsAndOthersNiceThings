using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
namespace Nuton
{
    class Program
    {
        static double f(double x)
        {
            //return x * x - 4;
            return Math.Log(x) - Math.Tan(x) + 2;
        }
        static double p1(double x, double dx)
        {
            return (f(x + dx / 2) - f(x - dx / 2)) / dx;
        }
        static double p2(double x, double dx)
        {
            return (f(x + dx / 2) + f(x - dx / 2) - 2 * f(x)) / ((dx * dx) / 4);
        }

        static void Main(string[] args)
        {
            double a, b, z, x1, dx, eps, Dx;
            int k, kmax;
            Console.WriteLine("Vvedit korektnu mezu a");
            a = double.Parse(Console.ReadLine());
            Console.WriteLine("Vvedit korektnu mezu b");
            b = double.Parse(Console.ReadLine());
            Console.WriteLine("vvedit tochnist eps= ");
            eps = double.Parse(Console.ReadLine());
            Console.WriteLine("vvedit maksymalnu kilkist podiliv kmax=");
            kmax = int.Parse(Console.ReadLine());
            if ((a < 0) || (b < 0))
            {
                Console.WriteLine("Shanovnuy korustyvach, vvedeni mezi ne korektni");
                Console.ReadLine();
                return;
            }
            if (Math.Abs(b - a) < (2 * eps))
            {
                Console.WriteLine("vedeni mezi nadto mali");
                Console.ReadLine();
                return;
            }
            if (eps <= 0)
            {
                Console.WriteLine("vvedena tochnist je ne korektnojy");
                Console.ReadLine();
                return;
            }
            if (kmax < 0)
            {
                Console.WriteLine("Shanovnuy korustyvach, kilkist podiliv ne moze bytu vidjemna");
                Console.ReadLine();
                return;
            }
           /* if (a > b)
            {
                z = a;
                a = b;
                b = z;
            }*/
            dx = 0.00001;
            x1 = b;
            if (f(b) * p2(b, dx) < 0)
            {
                x1 = a;
                if (f(a) * p2(a, dx) < 0)
                {
                    Console.WriteLine("Dlya zadanoho rivnannya zbiznist ne harantujetsa");
                    Console.ReadLine();
                    return;
                }
            }
            for (k = 0; k < kmax; k++)
            {
                Dx = f(x1) / p1(x1, dx);
                x1 = x1 - Dx;
                if (Math.Abs(Dx) < eps)
                {
                    Console.WriteLine("korin x={0} znajdeno za k= {1} podiliv", x1, k);
                    Console.ReadLine();
                    return;
                }
                if ((k == kmax - 1) && (Math.Abs(Dx) > eps))
                {
                    Console.WriteLine(" Za zadany kilkist podiliv znajty korin ne vdalosya ");
                    Console.ReadLine();
                    return;
                }

            }
        }
    }
}