<%@ Control language="c#" CodeBehind="AuthorizeNetPayment.ascx.cs" Inherits="CartViper.Store.AuthorizeNetSIMProvider.AuthorizeNetPayment" AutoEventWireup="True" %>

<asp:Panel id="pnlProceedToAIM" runat="server" Visible="true" CssClass="StoreAccountCheckoutPayPalProvider cvStoreOnlinePaymentProvider">
    <p>
        <asp:Label id="lblConfirmMessage" runat="server" CssClass="Normal"></asp:Label>        
    </p>
</asp:Panel>