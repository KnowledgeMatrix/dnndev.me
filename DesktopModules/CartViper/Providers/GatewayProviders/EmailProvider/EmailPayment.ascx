<%@ Control language="c#" CodeBehind="EmailPayment.ascx.cs" Inherits="CartViper.Modules.Store.Cart.EmailPayment" AutoEventWireup="True" %>
<asp:Label id="lblError" runat="server" CssClass="NormalRed"></asp:Label>
<asp:Panel id="pnlProceedToEmail" runat="server" CssClass="StoreAccountCheckoutEmailProvider">
    <p>
        <asp:Label id="lblConfirmMessage" runat="server" CssClass="Normal"></asp:Label>        
    </p>
</asp:Panel>