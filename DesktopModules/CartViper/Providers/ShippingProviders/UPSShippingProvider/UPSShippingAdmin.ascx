<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="UPSShippingAdmin.ascx.cs" Inherits="CartViper.Store.Providers.Shipping.UPSShippingProvider.UPSShippingAdmin" %>
      <%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>

    <table width="100%">
        <tr>
            <td colspan="2" class="infoCaption">
                <asp:Label runat="server" resourcekey="lblProviderInfo" ID="lblProviderInfo"></asp:Label>
            </td>
        </tr>
        <tr>
            <td colspan="2">&nbsp;</td>
        </tr>
        <tr>
            <td style="width:150px">
                <dnn:label resourcekey="lblUsername" id="lblUsername" runat="server" controlname="txtUsername" suffix=":"></dnn:label>
            </td>
            <td>
                <asp:TextBox runat="server" ID="txtUsername"></asp:TextBox>
                    <asp:RequiredFieldValidator resourcekey="rf" runat="server" ID="rdUsername" ControlToValidate="txtUsername"></asp:RequiredFieldValidator>
            </td>
        </tr>
         <tr>
            <td style="width:150px">
                <dnn:label resourcekey="lblPassword" id="lblPassword" runat="server" controlname="txtPassword" suffix=":"></dnn:label>
            </td>
            <td>
                <asp:TextBox runat="server" ID="txtPassword"></asp:TextBox>
                    <asp:RequiredFieldValidator resourcekey="rf" runat="server" ID="RequiredFieldValidator1" ControlToValidate="txtPassword"></asp:RequiredFieldValidator>
            </td>
        </tr>

        <tr>
            <td>
                 <dnn:label resourcekey="lblAccessLicenseNumber" id="lblAccessLicenseNumber" runat="server" controlname="txtAccessLicenseNumber" suffix=":"></dnn:label>
            </td>
            <td>
                <asp:TextBox runat="server" ID="txtAccessLicenseNumber"></asp:TextBox>
                    <asp:RequiredFieldValidator resourcekey="rf" runat="server" ID="RequiredFieldValidator2" ControlToValidate="txtAccessLicenseNumber"></asp:RequiredFieldValidator>
            </td>
        </tr>

        <tr>
            <td>
                 <dnn:label resourcekey="lblUpsAccount" id="lblUpsAccount" runat="server" controlname="txtUpsAccount" suffix=":"></dnn:label>
            </td>
            <td>
                <asp:TextBox runat="server" ID="txtUpsAccount"></asp:TextBox>
            </td>
        </tr>

        <tr>
            <td colspan="2">&nbsp;</td>
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
            <td>
                <dnn:label resourcekey="lblSendCartAsSinglePackage" id="lblSendCartAsSinglePackage" runat="server" controlname="chkSendCartAsSinglePackage" suffix=":"></dnn:label>
            </td>
            <td>
                 <asp:checkbox Columns="5" runat="server" ID="chkSendCartAsSinglePackage"></asp:checkbox>
            </td>
        </tr>
        <tr>
            <td>
                <dnn:label id="lblMarkup" runat="server" controlname="txtMarkup" suffix=":"></dnn:label>
            </td>
            <td>
                 <asp:TextBox Columns="5" runat="server" ID="txtMarkup"></asp:TextBox><asp:Label runat="server" CssClass="adminPercentageInfo" resourcekey="lblMarkupHelp" ID="lblMarkupHelp"></asp:Label>
            </td>
        </tr>

        <tr>
            <td valign="top">
                <dnn:label resourcekey="lblSupportedDeliveryMethods" id="lblSupportedDeliveryMethods" runat="server" controlname="chkSupportedDeliveryMethods" suffix=":"></dnn:label>
            </td>
            <td>
                 <asp:CheckBoxList runat="server" ID="chkSupportedDeliveryMethods"></asp:CheckBoxList>
            </td>
        </tr>
        <tr>
            <td class="NormalBold" style="vertical-align:top;">
                <dnn:label id="lblFreeShippingRoles" runat="server" controlname="cltDnnRole" suffix=":"></dnn:label>
            </td>
            <td>
                <div class="cvRoleSelectorPanel">
                    <asp:CheckBoxList runat="server" ID="cltDnnRole"></asp:CheckBoxList>
                </div>
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
                    onclick="btnSave_Click"/>
            </td>
        </tr>
    </table>