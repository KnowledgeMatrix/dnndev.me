<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="SquareEcommercePayment.ascx.cs" Inherits="CartViper.Store.PaymentProviders.SquareEcommerceProvider.SquareEcommercePayment" %>
<asp:Panel id="pnlProceedToAuthorize" runat="server" Visible="true" CssClass="StoreAccountCheckoutAuthorizeProvider cvStoreOnlinePaymentProvider">
    <fieldset>
        <legend>
            <asp:label id="lblPaymentTitle" resourcekey="lblPaymentTitle" runat="server"></asp:label>
        </legend>

        <asp:Panel ID="pnlCreditCardLogo" CssClass="paymentGatewayCCLogosContainer" runat="server" Visible="false">
            <asp:Image runat="server"  ID="imgCreditCardLogo" CssClass="paymentGatewayCCLogos"/>
        </asp:Panel>

        <div class="squareEcommercePayment">
            <label>Credit Card Number</label>
            <div id="sq-card-number"></div>
            <label>Card CVV</label>
            <div id="sq-cvv"></div>
            <label>Card Expiration Date</label>
            <div id="sq-expiration-date"></div>
            <label>Zipcode</label>
            <div id="sq-postal-code"></div>
            <input runat="server" type="hidden" class="cardNonce" id="cardNonce" name="nonce"/>

            <a class="squarePrevious CvStandardButton" href="javascript:SquarePrevious()" style="display:none; margin-right:10px">Previous</a>
            <input class="CvStandardButton squarePlaceOrder" value="Place Order" type="submit" onclick="submitButtonClick(event)" id="btnSubmit"/>

         
        </div>
        <div class="cvFailInfo" style="display:none; max-width:300px" id="errors"></div>  
	</fieldset>
</asp:Panel>

<script type="text/javascript" src="https://js.squareup.com/v2/paymentform"></script>
    <script type="text/javascript">

        function SquarePrevious() {
            jQuery(".threeStepPrevious")[0].click();
        }

        var sqPaymentForm = new SqPaymentForm({
           
            applicationId: '<%= ApplicationId %>',
            inputClass: 'sq-input',
            cardNumber: {
                elementId: 'sq-card-number',
                placeholder: "0000 0000 0000 0000"
            },
            cvv: {
                elementId: 'sq-cvv',
                placeholder: 'CVV'
            },
            expirationDate: {
                elementId: 'sq-expiration-date',
                placeholder: 'MM/YY'
            },
            postalCode: {
                elementId: 'sq-postal-code',
                placeholder: 'Zipcode'
            },
            inputStyles: [
              // Because this object provides no value for mediaMaxWidth or mediaMinWidth,
              // these styles apply for screens of all sizes, unless overridden by another
              // input style below.
              {
                  fontSize: '14px',
                  padding: '3px'
              },
              // These styles are applied to inputs ONLY when the screen width is 400px
              // or smaller. Note that because it doesn't specify a value for padding,
              // the padding value in the previous object is preserved.
              {
                  mediaMaxWidth: '400px',
                  fontSize: '18px',
              }
            ],
            callbacks: {
                cardNonceResponseReceived: function (errors, nonce, cardData) {
                    if (errors) {
                        jQuery("#errors").show();
                        var errorDiv = document.getElementById('errors');
                        errorDiv.innerHTML = "";
                        errors.forEach(function (error) {
                            var p = document.createElement('p');
                            p.innerHTML = error.message.replace("Postal code", "Zipcode");
                            errorDiv.appendChild(p);
                        });
                    } else {
                        jQuery("#errors").hide();
                        // Assign the value of the nonce to a hidden form element
                        jQuery(".cardNonce").val(nonce);

                        if ('<%= CheckoutMode %>' == "FourStep") {
                            // click our submit button
                            jQuery(".btnCartViperCheckoutNext")[0].click();
                        }
                        else {
                            jQuery(".threeStepNext")[0].click();
                        }
                        jQuery(".squarePlaceOrder").hide();
                    }
                },
                unsupportedBrowserDetected: function () {
                    // Alert the buyer that their browser is not supported
                }
            }
        });
        function submitButtonClick(event) {
            event.preventDefault();
            sqPaymentForm.requestCardNonce();
        }
       
        jQuery(document).ready(function () {
            //hide these as this gateway is effectively an iframe

            if ('<%= CheckoutMode %>' == "FourStep") {
                jQuery(".btnCartViperCheckoutNext").hide();
                jQuery(".btnCartViperCheckoutBack").hide();
            }
            else {
                jQuery(".threeStepPrevious").hide();
                jQuery(".threeStepNext").hide();
                jQuery(".squarePlaceOrder").val("Next");
                jQuery(".squarePrevious").show();
            }
        });

    </script>
    <style type="text/css" runat="server">
        .sq-input {
            border: 1px solid #CCCCCC;
            margin-bottom: 10px;
            padding: 1px;
        }

        .sq-input--focus {
            outline-width: 5px;
            outline-color: #70ACE9;
            outline-offset: -1px;
            outline-style: auto;
        }

        .sq-input--error {
            outline-width: 5px;
            outline-color: #FF9393;
            outline-offset: 0px;
            outline-style: auto;
        }
    </style>

