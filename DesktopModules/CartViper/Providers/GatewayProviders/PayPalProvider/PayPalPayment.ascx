<%@ Control language="c#" CodeBehind="PayPalPayment.ascx.cs" Inherits="CartViper.Store.PaymentProviders.PaypalProvider.PayPalPayment" AutoEventWireup="True" %>
<asp:Label id="lblError" runat="server" CssClass="NormalRed" Visible="false"></asp:Label>
<asp:Panel id="pnlProceedToPayPal" runat="server" Visible="true" CssClass="StoreAccountCheckoutPayPalProvider cvStoreOnlinePaymentProvider">
    <p>
        <asp:Label id="lblConfirmMessage" runat="server" CssClass="Normal"></asp:Label>        
	    <br />
        <asp:Image ID="paypalimage" runat="server" AlternateText="Click here to pay by PayPal using your credit/debit card or PayPal account" />
        <p><asp:Label runat="server" CssClass="paypalSurchargeMessage" ID="lblSurcharge"></asp:Label></p>
    </p>
</asp:Panel>
