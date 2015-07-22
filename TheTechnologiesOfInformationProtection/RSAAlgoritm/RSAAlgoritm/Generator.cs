using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace RSAAlgoritm
{
    public class Generator
    {
        public int GeneratePAndQ(int cantBe = 0)
        {
            var randomizer = new Random();
            if (cantBe != 0)
            {
                var generatedCCantBe = randomizer.Next(0, Constants.PrimeNumbers.Length - 2);
                return Constants.PrimeNumbers[generatedCCantBe + 1];
            }
            var generated =  randomizer.Next(0, Constants.PrimeNumbers.Length - 1);
            return Constants.PrimeNumbers[generated];
        }
    }
}
