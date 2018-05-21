<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="NABDirectPostPayment.ascx.cs" Inherits="CartViper.Store.NABDirectPostProvider.NABDirectPostPayment" %>


<asp:Panel id="pnlProceedToNAB" runat="server" Visible="true" CssClass="cvStoreOnlinePaymentProvider">
    <fieldset>
        <legend>
            <asp:label id="lblPaymentTitle" resourcekey="lblPaymentTitle" runat="server"></asp:label>
        </legend>

        <asp:Panel ID="pnlCreditCardLogo" CssClass="paymentGatewayCCLogosContainer" runat="server" Visible="false">
            <asp:Image runat="server"  ID="imgCreditCardLogo" CssClass="paymentGatewayCCLogos"/>
        </asp:Panel>

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