using Newtonsoft.Json;
using System;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Management;
using System.Net;
using System.Text;
using System.Windows;
using System.Windows.Forms;
using MessageBox = System.Windows.Forms.MessageBox;

namespace PandaAuth_Sample_App
{
    public class ValidationResponse
    {
        public string dev_id { get; set; }
        public string service { get; set; }
        public DateTime expiresAt { get; set; }
        public string status { get; set; }
        public bool isPremium { get; set; }
    }

    public class PandaAuthAPI
    {
        private static string Endpoint_v2 = "https://pandadevelopment.net";

        public bool IsAuthenticated(string service_ID, string Key, string hardwareID)
        {
            string url = Endpoint_v2 + "/failsafeValidation?service=" + service_ID + "&hwid=" + hardwareID + "&key=" + Key;
            try
            {
                var validationResponse = GetValidationResponse(url);
                if (validationResponse != null && validationResponse.status == "success")
                    return true;
                else
                    return false;
            }
            catch (Exception ex)
            {
                MessageBox.Show("Failed to Authenticate your Key due to Certain Issue. A Error Details has been saved as (Authentication_Error.txt). Please Report that Error to the Developers, Thank you", "Panda Auth", MessageBoxButtons.OK, MessageBoxIcon.Error);
                File.WriteAllText("Authentication_Error.txt", "Exception: " + ex.Message);
                return false;
            }
        }

        public void LaunchSecureBrowser(string service, string hardware_id)
        {
            Process process = new Process();
            process.StartInfo.FileName = "msedge.exe";
            process.StartInfo.Arguments = "--guest \"" + Endpoint_v2 + "/getkey?service=" + service + "&hwid=" + hardware_id + "\"";
            try
            {
                process.Start();
            }
            catch
            {
                process.StartInfo.FileName = Endpoint_v2 + "/getkey?service=" + service + "&hwid=" + hardware_id;
                process.Start();
            }
        }

        public bool IsAuthenticated_Premium(string service_ID, string Key, string hardwareID)
        {
            string url = Endpoint_v2 + "/failsafeValidation?service=" + service_ID + "&hwid=" + hardwareID + "&key=" + Key;
            try
            {
                var validationResponse = GetValidationResponse(url);
                if (validationResponse != null && validationResponse.status == "success" && validationResponse.isPremium == true)
                    return true;
                else
                    return false;
            }
            catch (Exception ex)
            {
                MessageBox.Show("Failed to Authenticate your Key due to Certain Issue. A Error Details has been saved as (Authentication_Error.txt). Please Report that Error to the Developers, Thank you", "Panda Auth", MessageBoxButtons.OK, MessageBoxIcon.Error);
                File.WriteAllText("Authentication_Error.txt", "Exception: " + ex.Message);
                return false;
            }
        }

        public string GetHardwareId()
        {
            string hardwareId = string.Empty;

            try
            {
                // Query WMI for baseboard serial number
                ManagementObjectSearcher searcher = new ManagementObjectSearcher("SELECT SerialNumber FROM Win32_BaseBoard");
                ManagementObjectCollection managementObjects = searcher.Get();

                foreach (ManagementObject obj in managementObjects)
                {
                    hardwareId += obj["SerialNumber"].ToString();
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine("Error: " + ex.Message);
            }

            return hardwareId;
        }

        private ValidationResponse GetValidationResponse(string url)
        {
            using (WebClient client = new WebClient())
            {
                try
                {
                    string jsonContent = client.DownloadString(url);
                    // Deserialize JSON
                    return JsonConvert.DeserializeObject<ValidationResponse>(jsonContent);
                }
                catch (WebException ex)
                {
                    throw new Exception("Failed to retrieve JSON: " + ex.Message);
                }
            }
        }
    }
}
