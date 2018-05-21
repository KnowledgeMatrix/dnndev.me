<%@ Control language="c#" CodeBehind="RaboOmniKassaPayment.ascx.cs" Inherits="CartViper.Store.Cart.RaboOmniKassaProvider.RaboOmniKassaPayment" AutoEventWireup="True" %>
<asp:Label id="lblError" runat="server" CssClass="NormalRed" Visible="false"></asp:Label>
<asp:Panel id="pnlProceedToPayPal" runat="server" Visible="true" CssClass="StoreAccountCheckoutPayPalProvider cvStoreOnlinePaymentProvider">
    <p>
        <asp:Label id="lblConfirmMessage" runat="server" CssClass="Normal"></asp:Label>        
    </p>
</asp:Panel>
