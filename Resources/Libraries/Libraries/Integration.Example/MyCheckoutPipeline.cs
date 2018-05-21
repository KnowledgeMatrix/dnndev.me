using System;
using System.IO;
using System.Text;
using System.Web;
using System.Net;
using System.Linq;
using System.Collections.Generic;
using System.Web.Script.Serialization;

using RazorCart.Core.ActionPipeline;

namespace Integration.Example
{
    class MyOnCheckoutComplete : OnCheckoutComplete
    {
        public override PipelineAction Clone() { return new MyOnCheckoutComplete(); }
        public override int ActionID() { return 4; }
        public override string ActionName() { return "Custom.MyOnCheckoutComplete()"; }
        public override bool IsDisposable() { return true; }
        public override ActionEndResult Execute(CheckoutContext context)
        {
            #region Example to call web service that handles my successful orders

            Uri uri = new Uri("https://myservice.com/orders-handler.json");

            HttpWebRequest request = (HttpWebRequest)WebRequest.Create(uri);
            request.Method = "POST";
            request.ContentType = "application/json";

            using (StreamWriter writer = new StreamWriter(request.GetRequestStream()))
            {
                JavaScriptSerializer serializer = new JavaScriptSerializer();
                writer.Write(serializer.Serialize(context.OrderInfo));
                writer.Flush();
                writer.Close();
            }
            using (WebResponse response = request.GetResponse())
            {
                using (Stream stream = response.GetResponseStream())
                {
                    string responseString = new StreamReader(stream).ReadToEnd();
                }
            }

            #endregion

            return new ActionEndResult() { Success = true, FailureMessage = string.Empty };
        }
    }
}
