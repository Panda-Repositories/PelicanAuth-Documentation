using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using Panda_Pelican_Libraries___CSharp_Version__;
namespace PelicanConsole_Example
{
    internal class Program
    {


        static void Main(string[] args)
        {
            string keyBox; //Key 
            string HardwarID = "test_NoHardwareID"; //Replace this to your own method of Hardware ID or IP-based
            string ServiceID = "pandadevkit"; //Replace this to your identifier
            do
            {
                Console.Write("Enter Key, Type 'key' to generate a key url: ");
                keyBox = Console.ReadLine();

                if (keyBox == "key")
                {
                    new PelicanAuthLib().LaunchSecureBrowser(ServiceID, HardwarID);
                    return;
                }

                if (new PelicanAuthLib().VerifyKey(ServiceID, keyBox, HardwarID))
                {
                    Console.WriteLine("Key Accepted!");
                    if (new PelicanAuthLib().VerifyPremiumKey(ServiceID, keyBox, HardwarID))
                    {
                        Console.WriteLine("Key is Premium Generated");
                    }
                    else
                    {
                        Console.WriteLine("Key is not Premium Generated");
                    }
                }
                else
                {
                    Console.WriteLine("Key Invalid. Please try again");
                }
            } while (true); // This loop will continue until a valid key is entered or until you explicitly break out of it.

        }
    }
}
