<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="PointsAdmin.ascx.cs" Inherits="CartViper.Store.Cart.PaymentPointsProvider.PointsAdmin" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>

<table>
    <tr>
        <td class="NormalBold"><dnn:Label suffix=":" controlname="FileUpload1" runat="server" ID="lblUploadCaption" resourcekey="lblUploadCaption" /></td>
        <td><asp:FileUpload ID="FileUpload1" runat="server" /></td>
    </tr>
    <tr>
        <td>&nbsp;</td>
        <td valign="top"><asp:Button ID="btnUpload" runat="server" resourcekey="btnUpload" onclick="btnUpload_Click" /></td>
    </tr>

</table>
<asp:Panel ID="pnlResult" Visible="false" runat="server"></asp:Panel>
