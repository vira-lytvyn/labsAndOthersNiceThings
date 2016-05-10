using System; //Kvadr rivn XIO
namespace kv_r
{
    class Program
    {
        static void Main(string[] args)
        {
            double a = 2, b = -5, c = 3, d, x1, x2;
            d = b * b - 4 * a * c;
            if (d < 0)
            {
                Console.WriteLine("No real answers!!!");
            }
            else
            {
                if (d == 0)
                {
                    x1 = -b / (2 * a);
                    Console.WriteLine("\n X1={0} ", x1);
                }
                else
                {
                    x1 = (-b + Math.Sqrt(d)) / (2 * a);
                    x2 = (-b - Math.Sqrt(d)) / (2 * a);
                    Console.WriteLine("\n X1={0} X2={1}", x1, x2);
                }
            }
            Console.WriteLine("\n\a\a\a\a           Press <ENTER> ");
        }
    }
}
