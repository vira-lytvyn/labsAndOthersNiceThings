using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace RSAAlgoritm
{
    public class KeyManager
    {
        public static int CreateN(int q, int p)
        {
            return q * p;
        }

        public static int ComputePhaser(int q, int p)
        {
            return (p - 1) * (q - 1);
        }

        public static int GetCoPrimeNumber(int phaserNumber)
        {
            for (var i = 10; i < phaserNumber; i++)
            {
                if (CheckIfNumberCoprime(i, phaserNumber) == 1)
                {
                    return i;
                }
            }
            return 0;
        }

        private static int CheckIfNumberCoprime(int value1, int value2)
        {
            while (value1 != 0 && value2 != 0)
            {
                if (value1 > value2)
                    value1 %= value2;
                else
                    value2 %= value1;
            }
            return Math.Max(value1, value2);
        }

        public static int ModInverse(int coprimeNumber, int phaserNumber)
        {
            int i = phaserNumber, result = 0, d = 1;
            while (coprimeNumber > 0)
            {
                int t = i / coprimeNumber, x = coprimeNumber;
                coprimeNumber = i % x;
                i = x;
                x = d;
                d = result - t * x;
                result = x;
            }
            result %= phaserNumber;
            if (result < 0) result = (result + phaserNumber) % phaserNumber;
            return result;
        }
    }
}
