using System;

namespace CesarAlg
{
    class Program
    {
        static void Main()
        {
            try
            {
                Console.WriteLine("Please choose algoritm 1 - Ceasar, 2 - Vigener");
                var whatAlgoritmChoose = Convert.ToInt32(Console.ReadLine());
                Manager.Manage(whatAlgoritmChoose);
            }
            catch (Exception)
            {
                Console.ForegroundColor = ConsoleColor.Red;
                Console.WriteLine(Constants.SomethingWrong);
            }

        }
    }
}
