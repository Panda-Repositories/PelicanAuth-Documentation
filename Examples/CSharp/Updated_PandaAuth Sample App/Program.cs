using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PandaAuth_Sample_App
{
    internal class Program
    {
        static void Main(string[] args)
        {
            bool exit = false;

            string Identifier = "pandadevkit"; //Your Identifier
            string hwid = new PandaAuthAPI().GetHardwareId();
            while (!exit)
            {
                Console.WriteLine("Service ID: " + Identifier);
                Console.WriteLine("Hardware ID: " + hwid);
                Console.WriteLine("---------------------------------------");
                Console.WriteLine("[ 1. ] Generate Key URL");
                Console.WriteLine("[ 2. ] Validate Key");
                Console.WriteLine("[ 3. ] Exit");

                Console.Write("Enter your choice: ");
                string choice = Console.ReadLine();

                switch (choice)
                {
                    case "1":
                        Console.WriteLine("Generating Key URL for option 1...");
                        new PandaAuthAPI().LaunchSecureBrowser(Identifier, hwid);
                        break;
                    case "2":
                        Console.WriteLine("---------------------------------------");
                        Console.Write("Key: ");
                        string KeyBox = Console.ReadLine();
                        if (new PandaAuthAPI().IsAuthenticated(Identifier, KeyBox, hwid))
                        {
                            Console.WriteLine("---------------------------------------");
                            Console.WriteLine("[    Key Succefully Authenticated      ]");
                            Console.WriteLine("[    Premium: " + new PandaAuthAPI().IsAuthenticated_Premium(Identifier, KeyBox, hwid).ToString());
                            Console.WriteLine("---------------------------------------");
                        }
                        else
                        {
                            Console.WriteLine("---------------------------------------");
                            Console.WriteLine("[    Key Failed to Authenticate       ]");
                            Console.WriteLine("---------------------------------------");
                        }
                        break;
                    case "3":
                        Console.WriteLine("Exiting the program...");
                        exit = true;
                        break;
                    default:
                        Console.WriteLine("Invalid choice. Please select again.");
                        break;
                }
                Console.WriteLine(); // Add a newline for clarity
            }

        }
    }
}
