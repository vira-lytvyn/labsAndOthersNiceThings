using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace MPD
{
    class Program
    {
        static double f(double x)
        {
            //return 4 - x * x;
            return Math.Sqrt(Math.Abs(x)) - Math.Sin(Math.Abs(x)) - 1;
        }

        static void Main(string[] args)
        {
            double a, b, c, z, eps;
            int k, kmax;
            Console.WriteLine("Vvedit korektnu mezu a");
            a = double.Parse(Console.ReadLine());
            Console.WriteLine("Vvedit korektnu mezu b");
            b = double.Parse(Console.ReadLine());
            Console.WriteLine("vvedit tochnist eps= ");
            eps = double.Parse(Console.ReadLine());
            Console.WriteLine("vvedit maksymalnu kilkist podiliv kmax=");
            kmax = int.Parse(Console.ReadLine());
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
            if (a == b)
            {
                if (Math.Abs(f(a)) < eps)
                {
                    Console.WriteLine("Vvedena vamu tochka je korenem rivnaynnay");
                    Console.ReadLine();
                    return;
                }
                else
                {
                    Console.WriteLine("vvedeni mezi je nekorektni");
                    Console.ReadLine();
                    return;
                }
            }
            k = 0;
            if (Math.Abs(f(a)) < eps)
            {
                Console.WriteLine("korenem je meza a= ", a);
                Console.ReadLine();
                return;
            }
            else if (Math.Abs(f(b)) < eps)
            {
                Console.WriteLine("korenem je meza b= ", b);
                Console.ReadLine();
                return;
            }
            for (k = 0; k < kmax; k++)
            {
                c = (a + (0.5 * (b - a)));
                k = k + 1;
                if (f(a) * f(c) > 0)
                {
                    a = c;
                }
                else
                {
                    b = c;
                }
                if (Math.Abs(f(c)) < eps)
                {
                    Console.WriteLine("korin x={0} znajdeno za k= {1} podiliv", c, k);
                    Console.ReadLine();
                    return;
                }
                if ((k == kmax - 1) && (Math.Abs(f(c)) < eps))
                {
                    Console.WriteLine(" Za zadany kilkist podiliv znajty korin ne vdalosya ");
                    Console.ReadLine();
                    return;
                }
            }
        }
    }
}
