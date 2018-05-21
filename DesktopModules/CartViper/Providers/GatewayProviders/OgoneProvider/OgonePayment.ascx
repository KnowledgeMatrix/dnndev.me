<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="OgonePayment.ascx.cs" Inherits="CartViper.Store.Cart.OgoneProvider.OgonePayment" %>
    
    <asp:Panel ID="pnlCreditCardLogo" CssClass="paymentGatewayCCLogosContainer StoreAccountWrapper" runat="server" Visible="false">
        <asp:Image runat="server"  ID="imgCreditCardLogo" CssClass="paymentGatewayCCLogos"/>   

    <p><asp:Label runat="server" CssClass="ogoneSurchargeMessage" ID="lblSurcharge"></asp:Label></p>
    <div class="rdOgoneOptions">
         <asp:RadioButton runat="server" ID="rdOgoneIdeal" GroupName="ogonePaymentOptions" resourcekey="rdOgoneIdeal" />&nbsp;&nbsp;
        <asp:RadioButton runat="server" CssClass="rdOgoneCreditCard" ID="rdOgoneCreditCard" GroupName="ogonePaymentOptions" resourcekey="rdOgoneCreditCard" />
       <br /><br />
    </div>
 </asp:Panel>

    <script type="text/javascript">
        /* <![CDATA[ */

         jQuery(document).ready(function(){
            ShowHideSurcharge();

	        jQuery(".rdOgoneOptions").find(":radio").change(function(){
		        ShowHideSurcharge();
	        });
         });

         function ShowHideSurcharge(){
            if(jQuery(".rdOgoneCreditCard").find(":checked").size() == 1){
		        jQuery(".ogoneSurchargeMessage").show("fast");
		    }
            else
            {
		        jQuery(".ogoneSurchargeMessage").hide("fast");   
		    }
         }

        /* ]]> */
    </script>