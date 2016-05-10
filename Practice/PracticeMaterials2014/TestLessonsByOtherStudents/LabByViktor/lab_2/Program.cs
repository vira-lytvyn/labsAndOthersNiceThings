using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace lab_2
{
    class Program
    {
        static string inp_number;      //вхідне число
        static string out_number;      // вихідне число
        static public bool isContainSymbol(char symbol, char[] alphabet)
        {
            bool result = false;
            for (int i = 0; i < alphabet.Length; i++)
            {
                if (alphabet[i] == symbol)
                {
                    result = true;
                    break;
                }
            }

            return result;
        }

        static void Main(string[] args)
        {
            Console.WriteLine("Вас вiтає програма 'Encoder'! ");
                //    string HEX_ALPHABET = "";
                char[] Hex_Alfabet = { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F' };
                char[] Number_Alfabet = { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9' };
            Choose:
            try
            {               
                // оберіть тип вхідного кодування
                Console.WriteLine("Зазначте тип кодування вхiдного числа: ");
                Console.WriteLine("1 - Двiйковий код; 2 - Шiстнадцятковий код; 3 - Десятковий код; ");
                string inp_type = Console.ReadLine();
                if ((inp_type != "1") && (inp_type != "2") && (inp_type != "3"))
                {
                    Console.WriteLine("Неправильний ввiд! Будь ласка, введiть 1, 2, або 3.");
                    goto Choose;
                }
            // оберіть тип вихідного кодування
            Choose1:
                Console.WriteLine("Зазначте тип кодування вихiдного числа: ");
                Console.WriteLine("1 - Двiйковий код; 2 - Шiстнадцятковий код; 3 - Десятковий код; ");
                string out_type = Console.ReadLine();
                if ((out_type != "1") && (out_type != "2") && (out_type != "3"))
                {
                    Console.WriteLine("Неправильний ввiд! Будь ласка, введiть 1, 2, або 3.");
                    goto Choose1;
                }
                // визначення напрямку кодування з перевіркою
                if (inp_type == out_type)
                {
                    string same_type_coding;
                    Console.WriteLine("Тип вхiдного та вихiдного кодування спiвпадають.");
                    Console.WriteLine("Продовжити : 1 - Так. 2 - Нi.");
                    same_type_coding = Console.ReadLine();
                    switch (same_type_coding)
                    {
                        case "1":
                            {
                                break;
                            }
                        case "2":
                            {
                                goto Choose;
                            }
                        default:
                            {
                                Console.WriteLine("Неправильний ввiд! Будь ласка, введiть 1 або 2.");
                                break;
                            }
                    }
                }
            Choose2:
                // введіть число, яке бажаєте перекодувати
                Console.WriteLine("Введiть число, яке бажаєте перекодувати.");
                inp_number = Console.ReadLine();
                //перевірка правильності вводу; !!!!!!!!!!пункт 2.1.5.!!!!!!!!!!!!
                string uncorrect_action;
                if (inp_type == "1")// binary
                {
                    for (int i = 0; i < inp_number.Length; i++)
                    {
                        if ((inp_number[i] != '0') && (inp_number[i] != '1'))
                        {
                            Console.WriteLine("Число введено некоректно!");
                            Console.WriteLine(" Оберіть одну з наступних оперцій: ");
                            Console.WriteLine("1 - Ввести iнше число; 2 - Змiнити типи кодувань; 3 - Вийти з програми;");
                            uncorrect_action = Console.ReadLine();
                            switch (uncorrect_action)
                            {
                                case "1":
                                    {
                                        goto Choose2;
                                        //    break;
                                    }
                                case "2":
                                    {
                                        goto Choose;
                                        //break;
                                    }
                                case "3":
                                    {
                                        Environment.Exit(0);
                                        break;
                                    }
                                default:
                                    {
                                        Console.WriteLine("Неправильний ввiд! Будь ласка, введiть 1, 2 або 3.");
                                        break;
                                    }
                            }
                        }
                    }
                }
                if (inp_type == "2")// hex
                {
                    inp_number = inp_number.ToUpper();
                    for (int i = 0; i < inp_number.Length; i++)
                    {
                         if (!isContainSymbol(inp_number[i], Hex_Alfabet))
                        {
                            Console.WriteLine("Число введено некоректно!");
                            Console.WriteLine(" Оберіть одну з наступних оперцій: ");
                            Console.WriteLine("1 - Ввести iнше число; 2 - Змiнити типи кодувань; 3 - Вийти з програми;");
                            uncorrect_action = Console.ReadLine();
                            switch (uncorrect_action)
                            {
                                case "1":
                                    {
                                        goto Choose2;
                                        //break;
                                    }
                                case "2":
                                    {
                                        goto Choose;
                                        //break;
                                    }
                                case "3":
                                    {
                                        Environment.Exit(0);
                                        break;
                                    }
                                default:
                                    {
                                        Console.WriteLine("Неправильний ввiд! Будь ласка, введiть 1, 2 або 3.");
                                        break;
                                    }
                            }
                            //        }
                        }
                    }
                }
                if (inp_type == "3")// int
                {
                    for (int i = 0; i < inp_number.Length; i++)
                    {
                         if (!isContainSymbol(inp_number[i], Number_Alfabet))
                        {
                            Console.WriteLine("Число введено некоректно!");
                            Console.WriteLine(" Оберіть одну з наступних оперцій: ");
                            Console.WriteLine("1 - Ввести iнше число; 2 - Змiнити типи кодувань; 3 - Вийти з програми;");
                            uncorrect_action = Console.ReadLine();
                            switch (uncorrect_action)
                            {
                                case "1":
                                    {
                                        goto Choose2;
                                        // break;
                                    }
                                case "2":
                                    {
                                        goto Choose;
                                        // break;
                                    }
                                case "3":
                                    {
                                        Environment.Exit(0);
                                        break;
                                    }
                                default:
                                    {
                                        Console.WriteLine("Неправильний ввiд! Будь ласка, введiть 1, 2 або 3.");
                                        break;
                                    }
                            }
                        }
                    }
                }
                //   кодування         
                if (inp_type == "1")// binary
                {
                    if (out_type == "1") // hex 
                    {
                        Console.WriteLine(inp_number);
                        Console.ReadKey();
                        goto Choose;
                    }
                     if (out_type == "2") // hex 
                    {
                        int prom = Coder.BinaryToInteger(inp_number);    //binary to int           
                        out_number = Coder.HexFromID(prom); // int to hex
                        Console.WriteLine(out_number);
                        Console.ReadKey();
                        goto Choose;
                    }
                    if (out_type == "3") // integer 
                    {
                        Console.WriteLine(Coder.BinaryToInteger(inp_number)); // binary to int
                        Console.ReadKey();
                        goto Choose;
                    }
                }
                if (inp_type == "2") // hex
                {
                    if (out_type == "1") // binary 
                    {
                        int prom = Coder.IDFromHex(inp_number); // hex to int                       
                        Console.WriteLine(Coder.IntegerToBinary(prom));// int to binary 
                        Console.ReadKey();
                        goto Choose;
                    }
                   if (out_type == "2") // hex 
                    {
                        Console.WriteLine(inp_number);
                        Console.ReadKey();
                        goto Choose;
                    }
                     if (out_type == "3")// int
                    {
                        out_number = Coder.IDFromHex(inp_number).ToString();// hex to int
                        Console.WriteLine(out_number);
                        Console.ReadKey();
                        goto Choose;
                    }
                }
                if (inp_type == "3")// int
                {
                    int num = int.Parse(inp_number);
                    if (out_type == "1") // binary
                    {
                        Console.WriteLine(Coder.IntegerToBinary(num)); // int to binary
                        Console.ReadKey();
                        goto Choose;
                    }
                    if (out_type == "2") // hex
                    {
                        out_number = Coder.HexFromID(num);
                        Console.WriteLine(out_number);
                        Console.ReadKey();
                        goto Choose;
                    }
                    if (out_type == "3") // hex 
                    {
                        Console.WriteLine(inp_number);
                        Console.ReadKey();
                        goto Choose;
                    }
                }
            }  catch (Exception e)
            {
                Console.WriteLine(e.Message);
                Console.ReadKey();
                goto Choose;
            }
        }
    }
}