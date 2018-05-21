using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using RazorCart.Core.ActionPipeline;
using RazorCart.Service.Data;
using RazorCart.Service.Data.ModelDataContext;

using DotNetNuke.Entities.Portals;
using DotNetNuke.Entities.Controllers;
using DotNetNuke.Common.Utilities;
using DotNetNuke.Services.Mail;

namespace Integration.Example
{
    class MyPreAddToCart : PreAddToCart
    {
        public override PipelineAction Clone() { return new MyPreAddToCart(); }
        public override int ActionID() { return 1; }
        public override string ActionName() { return "Custom.MyPreAddToCart()"; }
        public override bool IsDisposable() { return false; }
        public override ActionEndResult Execute(CartContext context)
        {
            #region Example to reject adding new items if the shopping cart contains items of $100 subtotal

            decimal subTotal = 0M;
            string persistBehavior = context.StoreConfig.ContainsKey("PersistCartBehavior") ? context.StoreConfig["PersistCartBehavior"] : "PersistCartByPC";
            if (persistBehavior == "PersistCartByPC")
                persistBehavior = "Machine";
            else if (persistBehavior == "PersistCartByUser")
                persistBehavior = "User";
            PersistBehavior persistent;
            Enum.TryParse(persistBehavior, out persistent);
            ICollection<CartItem> cartList = Repository.Instance.ListShoppingCartByUser(persistent, context.RequestGUID, PortalSettings.Current.UserInfo.Username ?? string.Empty, context.StoreID, PortalSettings.Current.PortalId);
            foreach (CartItem cartItem in cartList)
                subTotal += cartItem.UnitCost * cartItem.Quantity;
            if (subTotal >= 100)
                return new ActionEndResult() { Success = false, FailureMessage = "Your shopping cart cannot contains more than $100, please checkout before adding new items!" };

            #endregion

            #region Example to reject adding special item for not logged in user

            if (context.CartRequestList.Where(cr => cr.ModelNumber == "RC-Reg-01").Count() > 0)
            {
                if (PortalSettings.Current.UserInfo.UserID < 1)
                    return new ActionEndResult() { Success = false, FailureMessage = "This item require login, please login first!" };
            }

            #endregion

            return new ActionEndResult() { Success = true, FailureMessage = string.Empty };
        }
    }

    class MyOnAddToCartComplete : OnAddToCartComplete
    {
        public override PipelineAction Clone() { return new MyOnAddToCartComplete(); }
        public override int ActionID() { return 2; }
        public override string ActionName() { return "Custom.MyOnAddToCartComplete()"; }
        public override bool IsDisposable() { return true; }
        public override ActionEndResult Execute(CartContext context)
        {
            #region Example to send an email after adding an item to the shopping cart

            if (!string.IsNullOrWhiteSpace(PortalSettings.Current.UserInfo.Email))
            {
                CartItem cartItem = context.CartList.FirstOrDefault();
                if (cartItem != default(CartItem))
                {
                    string emailBody = string.Empty;
                    emailBody += "You have added a new item to your cart:<br />";
                    emailBody += "Item: " + cartItem.ProductName;

                    Dictionary<string, string> hostSettings = HostController.Instance.GetSettingsDictionary();

                    Mail.SendMail(
                        context.StoreConfig["SendFromEmail"],
                        PortalSettings.Current.UserInfo.Email,
                        string.Empty,
                        string.Empty,
                        MailPriority.Normal,
                        "Thank you",
                        MailFormat.Html,
                        Encoding.UTF8,
                        emailBody,
                        string.Empty,
                        hostSettings["SMTPServer"],
                        hostSettings["SMTPAuthentication"],
                        hostSettings["SMTPUsername"],
                        HostController.Instance.GetEncryptedString("SMTPPassword", Config.GetDecryptionkey()),
                        hostSettings["SMTPEnableSSL"] == "Y");
                }
            }

            #endregion

            return new ActionEndResult() { Success = true, FailureMessage = string.Empty };
        }
    }
}
