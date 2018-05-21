<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="USPSShippingAdmin.ascx.cs" Inherits="CartViper.Store.Providers.Shipping.USPSShippingProvider.USPSShippingAdmin" %>
    <%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>

    <table width="100%">
        <tr>
            <td colspan="2" class="infoCaption">
                <asp:Label runat="server" resourcekey="lblInfoMessage" ID="lblInfoMessage"></asp:Label>
            </td>
        </tr>
        <tr>
            <td colspan="2">&nbsp;</td>
        </tr>
        <tr>
            <td style="width:250px">
                <dnn:label resourcekey="lblServiceEndPoint" id="lblServiceEndPoint" runat="server" controlname="txtEndPoint" suffix=":"></dnn:label>
            </td>
            <td>
                <asp:TextBox runat="server" ID="txtEndPoint" Width="300"></asp:TextBox>
                    <asp:RequiredFieldValidator resourcekey="rf" runat="server" ID="rdEndpoint" ControlToValidate="txtEndPoint"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td style="width:250px">
                <dnn:label resourcekey="lblUspsUsername" id="lblUspsUsername" runat="server" controlname="txtUsername" suffix=":"></dnn:label>
            </td>
            <td>
                <asp:TextBox runat="server" ID="txtUsername"></asp:TextBox>
                    <asp:RequiredFieldValidator resourcekey="rf" runat="server" ID="RequiredFieldValidator1" ControlToValidate="txtUsername"></asp:RequiredFieldValidator>
            </td>
        </tr>
         <tr style="vertical-align:text-top">
            <td>
                <dnn:label id="lblMarkup" runat="server" controlname="txtMarkup" suffix=":"></dnn:label>
            </td>
            <td>
                 <asp:TextBox Columns="5" runat="server" ID="txtMarkup"></asp:TextBox><asp:Label CssClass="adminPercentageInfo" runat="server" resourcekey="lblMarkupHelp" ID="lblMarkupHelp"></asp:Label>
            </td>
        </tr>
        <tr>
            <td colspan="2">&nbsp;</td>
        </tr>
         <tr>
            <td valign="top">
                <dnn:label resourcekey="lblSupportedDeliveryMethods" id="lblSupportedDeliveryMethods" runat="server" controlname="chkSupportedDeliveryMethods" suffix=":"></dnn:label>
            </td>
            <td>
                 <h5>Domestic</h5>
                 <asp:CheckBoxList runat="server" ID="chkSupportedDeliveryMethods"></asp:CheckBoxList>
                 <h5 style="margin-top:25px;">International</h5>
                <asp:CheckBoxList runat="server" ID="chkSupportedInternationalDeliveryMethods"></asp:CheckBoxList>
            </td>
        </tr>
        <tr>
            <td colspan="2">&nbsp;</td>
        </tr>
        <tr>
            <td colspan="2" class="infoCaption">
                <asp:Label runat="server" resourcekey="lblDefaultSizes" ID="lblDefaultSizes"></asp:Label> 
            </td>
        </tr>
        <tr>
            <td>
                <dnn:label resourcekey="lblDefaultWidth" id="lblDefaultWidth" runat="server" controlname="txtWidth" suffix=":"></dnn:label>
            </td>
            <td>
                 <asp:TextBox Columns="5" runat="server" ID="txtWidth"></asp:TextBox><asp:Label runat="server" ID="lblWidthUnit"></asp:Label>
                    <asp:RequiredFieldValidator resourcekey="rfPassword" runat="server" ID="RequiredFieldValidator5" ControlToValidate="txtWidth"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td>
                <dnn:label resourcekey="lblDefaultLength" id="lblDefaultLength" runat="server" controlname="txtLength" suffix=":"></dnn:label>
            </td>
            <td>
                 <asp:TextBox Columns="5" runat="server" ID="txtLength"></asp:TextBox><asp:Label runat="server" ID="lblLengthUnit"></asp:Label>
                    <asp:RequiredFieldValidator resourcekey="rfPassword" runat="server" ID="RequiredFieldValidator8" ControlToValidate="txtLength"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td>
                <dnn:label resourcekey="lblDefaultHeight" id="lblDefaultHeight" runat="server" controlname="txtHeight" suffix=":"></dnn:label>
            </td>
            <td>
                 <asp:TextBox Columns="5" runat="server" ID="txtHeight"></asp:TextBox><asp:Label runat="server" ID="lblHeightUnit"></asp:Label>
                    <asp:RequiredFieldValidator resourcekey="rfPassword" runat="server" ID="RequiredFieldValidator9" ControlToValidate="txtHeight"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td>
                <dnn:label resourcekey="lblDefaultWeight" id="lblDefaultWeight" runat="server" controlname="txtHeight" suffix=":"></dnn:label>
            </td>
            <td>
                 <asp:TextBox Columns="5" runat="server" ID="txtWeight"></asp:TextBox><asp:Label runat="server" ID="lblWeightUnit"></asp:Label>
                    <asp:RequiredFieldValidator resourcekey="rfPassword" runat="server" ID="RequiredFieldValidator10" ControlToValidate="txtWeight"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td colspan="2">&nbsp;</td>
        </tr>
        <tr>
            <td>
                <dnn:label resourcekey="lblShippingFromAddress1" id="lblShippingFromAddress1" runat="server" controlname="txtShippingAddress1" suffix=":"></dnn:label>
            </td>
            <td>
                <asp:TextBox runat="server" ID="txtShippingAddress1"></asp:TextBox>
                    <asp:RequiredFieldValidator resourcekey="rf" runat="server" ID="RequiredFieldValidator4" ControlToValidate="txtShippingAddress1"></asp:RequiredFieldValidator>
            </td>
        </tr>        
        <tr>
            <td>
                  <dnn:label resourcekey="lblShippingFromCity" id="lblShippingFromAddressCity" runat="server" controlname="txtShippingCity" suffix=":"></dnn:label>  
            </td>
            <td>
                <asp:TextBox runat="server" ID="txtShippingCity"></asp:TextBox>
                    <asp:RequiredFieldValidator resourcekey="rf" runat="server" ID="RequiredFieldValidator6" ControlToValidate="txtShippingCity"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td>
                <dnn:label resourcekey="lblShippingFromPostcode" id="lblShippingFromPostcode" runat="server" controlname="txtShippingPostcode" suffix=":"></dnn:label>  
            </td>
            <td>
                 <asp:TextBox runat="server" ID="txtShippingPostcode"></asp:TextBox>
                    <asp:RequiredFieldValidator resourcekey="rf" runat="server" ID="RequiredFieldValidator7" ControlToValidate="txtShippingPostcode"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td>
                 <dnn:label resourcekey="lblShippingFromCountry" id="lblShippingFromCountry" runat="server" controlname="ddlCountry" suffix=":"></dnn:label>  
            </td>
            <td>
                <asp:DropDownList runat="server" ID="ddlCountry" DataValueField="Value" DataTextField="Text"></asp:DropDownList>
            </td>
        </tr>
        <tr>
        <td>&nbsp;</td>
            <td>
                <asp:Button runat="server" ID="btnSave" resourcekey="btnSave" 
                    onclick="btnSave_Click" />
            </td>
        </tr>
    </table>