<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="MolliePayment.ascx.cs" Inherits="CartViper.Store.Cart.MollieProvider.MolliePayment" %>

    <table class="StoreAccountCheckoutMollieProvider cvStoreOnlinePaymentProvider">
        <tr>
            <td>
                <asp:Label runat="server" ID="lblSelectBank" resourcekey="lblSelectBank"></asp:Label>
            </td>
            <td>
                <asp:DropDownList runat="server" ID="ddlBank"></asp:DropDownList>
            </td>
        </tr>
    </table>