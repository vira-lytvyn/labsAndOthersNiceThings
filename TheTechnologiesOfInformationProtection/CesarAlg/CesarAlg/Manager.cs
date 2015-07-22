using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CesarAlg
{
    class Manager
    {
        public static void Manage(int whatOperationSelect)
        {
            if (whatOperationSelect == Constants.CeaserOperation)
            {
                CeaserManage();
            }
            else if (whatOperationSelect == Constants.VigenereOperation)
            {
                VigenerManage();
            }
            else
            {
                Console.ForegroundColor = ConsoleColor.Red;
                Console.WriteLine(Constants.SomethingWrong);
            }
        }

        private static void CeaserManage()
        {
            Console.WriteLine("Please enter Cesar Key: ");
            try
            {
                var cesarKey = Convert.ToInt32(Console.ReadLine());
                Console.WriteLine("Please enter string to encrypt: ");
                var stringToEncrypt = Console.ReadLine();
                var encryptedString = CesarAlgoritm.Crypt(stringToEncrypt, cesarKey);
                Console.WriteLine("Crypted: {0}", encryptedString);
                Console.WriteLine("Do you want decrypt? if yes enter Y");
                var answer = Console.ReadLine();
                if (answer == "Y")
                {
                    var decryptedString = CesarAlgoritm.Decrypt(encryptedString, cesarKey);
                    Console.WriteLine("Dectypted: {0}", decryptedString);
                }
                else
                {
                    Environment.Exit(0);
                }
            }
            catch (Exception)
            {
                Console.ForegroundColor = ConsoleColor.Red;
                Console.WriteLine(Constants.SomethingWrong);
            }
            finally
            {
                Console.ReadKey();
            }
        }

        private static void VigenerManage()
        {
            try
            {
                Console.WriteLine("Please enter open string: ");
                var openString = Console.ReadLine();
                Console.WriteLine("Please enter code string: ");
                var codeString = Console.ReadLine();
                var cryptedString = VigenerAlgoritm.Crypt(openString, codeString);
                Console.WriteLine("Crypted: {0}", cryptedString);
                Console.WriteLine("Do you want decrypt? if yes enter Y");
                var answer = Console.ReadLine();
                if (answer == "Y")
                {
                    var decryptedString = VigenerAlgoritm.Decrypt(cryptedString, codeString);
                    Console.WriteLine("Decrypted: {0}", decryptedString);
                }
                else
                {
                    Environment.Exit(0);
                }
            }
            catch (Exception)
            {
                Console.ForegroundColor = ConsoleColor.Red;
                Console.WriteLine(Constants.SomethingWrong);
            }
            finally
            {
                Console.ReadKey();
            }
        }
    }
}
