<%@ Control language="c#" CodeBehind="InnovativeMerchantPayment.ascx.cs" Inherits="CartViper.Modules.Store.Cart.InnovativeMerchantPayment" AutoEventWireup="True" %>

<asp:Panel id="pnlProceedToInnovativeMerchant" runat="server" Visible="true" CssClass="StoreAccountCheckoutInnovativeMerchantProvider cvStoreOnlinePaymentProvider">
    <fieldset>
        <legend>
            <asp:label id="lblPaymentTitle" resourcekey="lblPaymentTitle" runat="server"></asp:label>
        </legend>

        <asp:Panel ID="pnlCreditCardLogo" CssClass="paymentGatewayCCLogosContainer" runat="server" Visible="false">
            <asp:Image runat="server"  ID="imgCreditCardLogo" CssClass="paymentGatewayCCLogos"/>
        </asp:Panel>

        <table class="StoreAccountCheckoutAuthorizeCardInfos">
            <tr id="trCardType" runat="server" visible="false">
                <td class="StoreAccountCheckoutAuthorizeCardLabel">
                    <asp:Label id="lblCard" CssClass="SubHead" runat="server">Card Type:</asp:Label>
                </td>
                <td class="StoreAccountCheckoutAuthorizeCardValue">
                    <asp:RadioButtonList id="rbCard" CssClass="Normal" runat="server" Width="160px" RepeatDirection="Horizontal">
                        <asp:ListItem Value="Visa" Selected="true">Visa</asp:ListItem>
                        <asp:ListItem Value="MasterCard">MasterCard</asp:ListItem>
                    </asp:RadioButtonList>
				    <asp:RequiredFieldValidator ValidationGroup="cvCheckout" id="rfvCard" runat="server" ControlToValidate="rbCard" CssClass="NormalRed">* Required</asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr id="trNameOnCard" runat="server" visible="false">
                <td class="StoreAccountCheckoutAuthorizeCardLabel">
			        <asp:Label id="lblName" runat="server" CssClass="SubHead">Name on Card:</asp:Label>
                </td>
                <td class="StoreAccountCheckoutAuthorizeCardValue">
			        <asp:TextBox id="txtName" runat="server" CssClass="NormalTextBox" Width="200px" MaxLength="255"></asp:TextBox>
			        <asp:RequiredFieldValidator ValidationGroup="cvCheckout" id="rfvName" Display="Dynamic" runat="server" ControlToValidate="txtName" CssClass="NormalRed">* Required</asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td class="StoreAccountCheckoutAuthorizeCardLabel">
			       <asp:Label ID="lblCardNumber" runat="server" resourcekey="lblCardNumber"></asp:Label>
                </td>
                <td class="StoreAccountCheckoutAuthorizeCardValue">                    
			        <asp:TextBox id="txtNumber" runat="server" CssClass="NormalTextBox" Width="150px" MaxLength="100"></asp:TextBox>
			        <asp:RequiredFieldValidator ValidationGroup="cvCheckout" ID="rfvNumber" Display="Dynamic" runat="server" ControlToValidate="txtNumber" CssClass="NormalRed" resourcekey="rfvNumber.ErrorMessage" ErrorMessage="* Required"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td class="StoreAccountCheckoutAuthorizeCardLabel">
			        <asp:Label id="lblExpiryDate" runat="server" resourcekey="lblExpiryDate"></asp:Label>
                </td>
                <td class="StoreAccountCheckoutAuthorizeCardValue">
			        <asp:DropDownList id="ddlMonth" runat="server" CssClass="NormalTextBox">
				        <asp:ListItem Value="01">01</asp:ListItem>
				        <asp:ListItem Value="02">02</asp:ListItem>
				        <asp:ListItem Value="03">03</asp:ListItem>
				        <asp:ListItem Value="04">04</asp:ListItem>
				        <asp:ListItem Value="05">05</asp:ListItem>
				        <asp:ListItem Value="06">06</asp:ListItem>
				        <asp:ListItem Value="07">07</asp:ListItem>
				        <asp:ListItem Value="08">08</asp:ListItem>
				        <asp:ListItem Value="09">09</asp:ListItem>
				        <asp:ListItem Value="10">10</asp:ListItem>
				        <asp:ListItem Value="11">11</asp:ListItem>
				        <asp:ListItem Value="12">12</asp:ListItem>
			        </asp:DropDownList>
			        <asp:Label id="lblSlash" runat="server" CssClass="Normal">&nbsp;/&nbsp;</asp:Label>
			        <asp:DropDownList id="ddlYear" runat="server" CssClass="NormalTextBox"></asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td class="StoreAccountCheckoutAuthorizeCardLabel">
			        <asp:label id="lblCSC" runat="server" resourcekey="lblCSC"></asp:label>
                </td>
                <td class="StoreAccountCheckoutAuthorizeCardValue">
			        <asp:TextBox id="txtVer" runat="server" CssClass="NormalTextBox" Width="60px" MaxLength="4"></asp:TextBox>
                    <a href="#" id="hypCvvHelp" >
                        <asp:Label runat="server" ID="lblCvvHelpLink" resourcekey="lblCvvHelpLink" />
                    </a>
			        <asp:RequiredFieldValidator ValidationGroup="cvCheckout" id="rfvVer" Display="Dynamic" runat="server" ControlToValidate="txtVer" CssClass="NormalRed" resourcekey="rfvVer.ErrorMessage" ErrorMessage="* Required"></asp:RequiredFieldValidator>

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
