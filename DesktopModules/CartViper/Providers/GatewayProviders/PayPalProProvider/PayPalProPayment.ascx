<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="PayPalProPayment.ascx.cs" Inherits="CartViper.Store.Cart.PayPalProProvider.PayPalProPayment" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/labelcontrol.ascx" %>

<asp:Label runat="server" ID="lblError" Visible="false" CssClass="NormalRed" resourcekey=""></asp:Label>
<asp:Panel runat="server" ID="pnlPaypal" CssClass="StoreAccountCheckoutPayProprovider cvStoreOnlinePaymentProvider">
<fieldset>
        <legend>
            <asp:label id="lblPaymentTitle" resourcekey="lblPaymentTitle" runat="server"></asp:label>
        </legend>

        <asp:Panel ID="pnlCreditCardLogo" CssClass="paymentGatewayCCLogosContainer" runat="server" Visible="false">
            <asp:Image runat="server"  ID="imgCreditCardLogo" CssClass="paymentGatewayCCLogos"/>
        </asp:Panel>

    <table style="text-align:left">
        <tr>
            <td style="width:130px">
                <asp:Label ID="lblCardType" resourcekey="lblCardType" runat="server"></asp:Label>
            </td>
            <td>
                <asp:DropDownList runat="server" ID="ddlCardType"></asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td style="width:130px">
                <asp:Label ID="lblCardNumber" resourcekey="lblCardNumber" runat="server"></asp:Label>
            </td>
            <td>
                <asp:TextBox runat="server" ID="txtCardNumber"></asp:TextBox>
                    <asp:RequiredFieldValidator ValidationGroup="cvCheckout" runat="server" ID="RequiredFieldValidator1" ControlToValidate="txtCardNumber" Display="Dynamic" ErrorMessage="Required field"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <asp:Panel runat="server" ID="pnlUkDetails">
          <tr>
            <td style="width:130px">
                <asp:Label ID="lblIssueNumber" resourcekey="lblIssueNumber" runat="server"></asp:Label>
            </td>
            <td>
                <asp:TextBox runat="server" ID="txtIssueNumber" Columns="3"></asp:TextBox> 
                    <asp:Label runat="server" ID="lblIssueError" Visible="false" CssClass="NormalRed" resourcekey="lblIssueNumberError"></asp:Label>                   
            </td>
        </tr>
          <tr>
            <td style="width:130px">
                <asp:Label ID="lblStartMonth" resourcekey="lblStartMonth" runat="server"></asp:Label>
            </td>
            <td>
                 <asp:DropDownList runat="server" ID="ddlStartMonth"></asp:DropDownList>
                    <asp:DropDownList runat="server" ID="ddlStartYear"></asp:DropDownList>
                    
            </td>
        </tr>
    </asp:Panel>
        <tr>
            <td style="width:130px">
                <asp:Label ID="lblEndMonth" resourcekey="lblExpiryDate" runat="server"></asp:Label>
            </td>
            <td>
                 <asp:DropDownList runat="server" ID="ddlEndMonth"></asp:DropDownList>
                    <asp:DropDownList runat="server" ID="ddlEndYear"></asp:DropDownList>
                    
            </td>
        </tr>
        <tr>
            <td style="width:130px;vertical-align:top;">
                <asp:Label ID="lblCV2" resourcekey="lblCV2" runat="server"></asp:Label>
            </td>
            <td>
                 <asp:TextBox runat="server" ID="txtCardVerficationNumber" Columns="4"></asp:TextBox>
                    <a href="#" id="hypCvvHelp" >
                        <asp:Label runat="server" ID="lblCvvHelpLink" resourcekey="lblCvvHelpLink" />
                    </a>
                 <asp:RequiredFieldValidator ValidationGroup="cvCheckout" runat="server" ID="RequiredFieldValidator9" ControlToValidate="txtCardVerficationNumber" Display="Dynamic" ErrorMessage="Required field"></asp:RequiredFieldValidator>
                 <asp:RegularExpressionValidator ValidationGroup="cvCheckout" ID="RegularExpressionValidator5" runat="server" ControlToValidate="txtCardVerficationNumber" Display="Dynamic" ErrorMessage="Invalid card verification number" ValidationExpression="([0-9]{3,4})"></asp:RegularExpressionValidator>

                 <div id="divCvvHelp" class="infoCaption" style="display:none;">
                    <asp:Label runat="server" ID="lblCvvHelp" />
                 </div>

            </td>
        </tr>
    </table>
    </fieldset>
</asp:Panel>

<script type="text/javascript">
/* <![CDATA[ */
    jQuery(document).ready(function(){

        jQuery("#hypCvvHelp").toggle(
        function(){
            jQuery("#divCvvHelp").show('fast');
            return false;
        }, 
        function(){
            jQuery("#divCvvHelp").hide('fast');
            return false;
        }
        );

    });
/* ]]> */
</script>
