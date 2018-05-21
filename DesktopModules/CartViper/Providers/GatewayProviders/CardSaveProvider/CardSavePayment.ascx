<%@ Control language="c#" CodeBehind="CardSavePayment.ascx.cs" Inherits="CartViper.Store.PaymentProviders.CardSaveProvider.CardSavePayment" AutoEventWireup="True" %>


<asp:Panel runat="server" ID="pnlSslError" Visible="false" CssClass="warningCaption">
    <asp:Label runat="server" ID="lblSslError" resourcekey="lblSslError" />
</asp:Panel>

<asp:Panel id="pnlCardSave" runat="server" Visible="true" CssClass="StoreAccountCheckoutAuthorizeProvider cvStoreOnlinePaymentProvider">
    <fieldset>
        <legend>
            <asp:label id="lblPaymentTitle" resourcekey="lblPaymentTitle" runat="server"></asp:label>
        </legend>

        <asp:Panel ID="pnlCreditCardLogo" CssClass="paymentGatewayCCLogosContainer" runat="server" Visible="false">
            <asp:Image runat="server"  ID="imgCreditCardLogo" CssClass="paymentGatewayCCLogos"/>
        </asp:Panel>

        <table class="StoreAccountCheckoutAuthorizeCardInfos">

            <tr id="trNameOnCard" runat="server" visible="true">
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
			        <asp:DropDownList id="ddlExpiryMonth" runat="server" CssClass="NormalTextBox">
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
			        <asp:DropDownList id="ddlExpiryYear" runat="server" CssClass="NormalTextBox"></asp:DropDownList>
                </td>
            </tr>

            <tr>
                <td class="StoreAccountCheckoutAuthorizeCardLabel">
			        <asp:Label id="Label1" runat="server" resourcekey="lblStartDate"></asp:Label>
                </td>
                <td class="StoreAccountCheckoutAuthorizeCardValue">
			        <asp:DropDownList id="ddlStartMonth" runat="server" CssClass="NormalTextBox">
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
			        <asp:Label id="Label2" runat="server" CssClass="Normal">&nbsp;/&nbsp;</asp:Label>
			        <asp:DropDownList id="ddlStartYear" runat="server" CssClass="NormalTextBox"></asp:DropDownList>
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
