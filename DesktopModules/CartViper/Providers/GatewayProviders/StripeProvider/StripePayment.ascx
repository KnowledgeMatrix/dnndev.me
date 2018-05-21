<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="StripePayment.ascx.cs" Inherits="CartViper.Store.PaymentProviders.StripeProvider.StripePayment" %>
<asp:Panel id="pnlProceedToAuthorize" runat="server" Visible="true" CssClass="StoreAccountCheckoutAuthorizeProvider cvStoreOnlinePaymentProvider">
    <fieldset>
        <legend>
            <asp:label id="lblPaymentTitle" resourcekey="lblPaymentTitle" runat="server"></asp:label>
        </legend>

        <asp:Panel ID="pnlCreditCardLogo" CssClass="paymentGatewayCCLogosContainer" runat="server" Visible="false">
            <asp:Image runat="server"  ID="imgCreditCardLogo" CssClass="paymentGatewayCCLogos"/>
        </asp:Panel>

        <table class="StoreAccountCheckoutAuthorizeCardInfos">
           <tr>
               <td style="width:390px">
                   <div id="card-element">
                   <!-- a Stripe Element will be inserted here. -->
                   </div>
                                               
                   <div style="padding-top:10px; display:none; width:initial" id="card-errors" class="cvFailInfo" role="alert"></div>
               </td>
           </tr>
        </table>
	</fieldset>
</asp:Panel>

<script src="https://js.stripe.com/v3/"></script>

<input type="hidden" id="inputStripeToken" class="inputStripeToken" runat="server" />

<style type="text/css">
    .hypSubmitStripe{
        display:inline-block !important;
    }
</style>

<script type='text/javascript'>
        /* <![CDATA[ */
            
        var stripe = Stripe('<%= StripeApiKey %>');
        var elements = stripe.elements();
        var style = {
            base: {
                // Add your base input styles here. For example:
                fontSize: '16px',
                lineHeight: '24px'
            }
        };

        // Create an instance of the card Element
        var card = elements.create('card', { style: style });

        function submitStripe() {

            stripe.createToken(card).then(function (result) {
                if (result.error) {

                    // Inform the user if there was an error
                    var errorElement = document.getElementById('card-errors');
                    errorElement.textContent = result.error.message;
                    jQuery("#card-errors").show();

                } else {
                    jQuery("#card-errors").hide();
                    jQuery(".inputStripeToken").val(result.token.id);
                    jQuery(".btnCartViperCheckoutNext")[0].click();
                    jQuery(".hypSubmitStripe").hide();
                }
            });
        }

        
            jQuery(document).ready(function () {
                
                //hide the standard button
                jQuery(".btnCartViperCheckoutNext").hide();
                
                // Add an instance of the card Element into the `card-element` <div>
                card.mount('#card-element');

                card.addEventListener('change', function (event) {
                    var displayError = document.getElementById('card-errors');
                    if (event.error) {
                        displayError.textContent = event.error.message;
                        jQuery("#card-errors").show();
                    } else {
                        displayError.textContent = '';
                        jQuery("#card-errors").hide();
                    }
                });

            });

        /* ]]> */
    </script>