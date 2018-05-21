<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="BillingShippingAddressCheckout.ascx.cs" Inherits="CartViper.Modules.Store.WebControls.Address.BillingShippingAddressCheckout" %>
    
    <%@ Register TagPrefix="dnnstore" TagName="address" Src="~/DesktopModules/cartviper/Address/StoreAddress.ascx" %>
    <%@ Register TagPrefix="cv" Namespace="CartViper.Modules.Store.WebControls" Assembly="CartViper.Modules.Store" %>

    <cv:CvNotificationControl runat="server" ID="cvNotification" />

   <div class="threeStepCheckoutLeft">
        <h2><asp:Label runat="server" ID="lblBillingAddress" resourcekey="lblBillingAddress"></asp:Label></h2>
        <div class="cvBillingDetails">
            <dnnstore:address id="addressBilling" runat="server" StartTabIndex="3" Enabled="false"></dnnstore:address>
        </div>
        <input type="checkbox" class="chkSameBilling normalCheckBox" runat="server" id="chkUseSameBillingAddress" />
        <asp:Label runat="server" ID="lblUseSameAddress" resourcekey="chkUseSameBillingAddress"></asp:Label>
   </div>

   <div runat="server" id="shippingColumn" class="threeStepCheckoutRight">
        <h2><asp:Label runat="server" ID="Label1" resourcekey="lblShippingAddress"></asp:Label></h2>
        <div class="cvShippingDetails" runat="server" id="cvShippingPanel">
            <dnnstore:address id="addressShipping" runat="server" StartTabIndex="3" Enabled="false"></dnnstore:address>
        </div>            
   </div>

   <div style="clear:both"></div>


   <script type="text/javascript">
        /* <![CDATA[ */
                   
             ShowHideShipping();

             jQuery(document).ready(function(){
                 jQuery(".chkSameBilling").change(function(){
                    ShowHideShipping();
                    ValidateBillingAddress();
                 });

                 jQuery(".cvBillingDetails").find(".StoreAccountAddress").change(function() {
                    ShowHideShipping();
                 });
             });

             //validate we have not copied the billing to shipping and cant 
             //ship to the billing state.
             function ValidateBillingAddress(){

                //check if we need to display the county textbox.   
                if(jQuery(".chkSameBilling:checked").size() == 1){
                
                      var shippingState =  jQuery(".cvShippingDetails").find(".cvAddressState").val();
                      var country = jQuery(".cvBillingDetails").find(".cvAddressCountry").val();          
                      var billingState = jQuery(".cvBillingDetails").find(".cvAddressState").val();       

                      if(country == "US")
                      {
                        if(shippingState!=billingState)
                        {
                            //we are restricting the shipping states so inform the user.
                            jQuery("#notificationCaption").html("<%= ErrorShipToStateMessage  %>");
                            jQuery("#notificationCaption").show().delay(4000).fadeOut('slow');
                            jQuery(".cvShippingDetails").show();
                        }                 
                      }                                   
                }
             }
             
             //if we shipping to the billing address copy the billing
             //to the shipping address.           
             function ShowHideShipping(){
                if(jQuery(".chkSameBilling:checked").size() == 1){
                    jQuery(".cvShippingDetails").hide();
                                      
                    jQuery(".cvShippingDetails").find(".cvAddressFirstName").val(jQuery(".cvBillingDetails").find(".cvAddressFirstName").val());
                    jQuery(".cvShippingDetails").find(".cvAddressSurname").val(jQuery(".cvBillingDetails").find(".cvAddressSurname").val());
                    jQuery(".cvShippingDetails").find(".cvAddress1").val(jQuery(".cvBillingDetails").find(".cvAddress1").val());
                    jQuery(".cvShippingDetails").find(".cvAddress2").val(jQuery(".cvBillingDetails").find(".cvAddress2").val());
                    jQuery(".cvShippingDetails").find(".cvAddressCity").val(jQuery(".cvBillingDetails").find(".cvAddressCity").val());
                    jQuery(".cvShippingDetails").find(".cvAddressRegion").val(jQuery(".cvBillingDetails").find(".cvAddressRegion").val());
                    jQuery(".cvShippingDetails").find(".cvAddressZip").val(jQuery(".cvBillingDetails").find(".cvAddressZip").val());
                    jQuery(".cvShippingDetails").find(".cvAddressTelephone").val(jQuery(".cvBillingDetails").find(".cvAddressTelephone").val());
                    jQuery(".cvShippingDetails").find(".cvAddressState").val(jQuery(".cvBillingDetails").find(".cvAddressState").val());
                    jQuery(".cvShippingDetails").find(".cvAddressCountry").val(jQuery(".cvBillingDetails").find(".cvAddressCountry").val());
                    jQuery(".cvShippingDetails").find(".cvAddressCounty").val(jQuery(".cvBillingDetails").find(".cvAddressCounty").val());
                }
                else
                {
                    jQuery(".cvShippingDetails").show();
                }

                ShowOrHideNYCountryRow();
                ValidateBillingAddress();
             }

             //based on whether or not we in NY show the county row.
             function ShowOrHideNYCountryRow()
             {
                //show for the billing details
                var billingState = jQuery(".cvBillingDetails").find(".cvAddressState").val();
                var country = jQuery(".cvBillingDetails").find(".cvAddressCountry").val();
                if(billingState== "NY" && country == "US" && "<%= TaxMode %>" == "New_York_County_Tax"){

                        jQuery(".cvBillingDetails").find(".cvAddressCountyRow").show();
                }
                else{
                      jQuery(".cvBillingDetails").find(".cvAddressCountyRow").hide();
                }  

                //now show for the shipping
                var shippingState = jQuery(".cvShippingDetails").find(".cvAddressState").val();
                var shippingcountry = jQuery(".cvShippingDetails").find(".cvAddressCountry").val();
                if(shippingState== "NY" && shippingcountry == "US" && "<%= TaxMode %>" == "New_York_County_Tax"){
                        jQuery(".cvShippingDetails").find(".cvAddressCountyRow").show();
                }
                else{
                  jQuery(".cvShippingDetails").find(".cvAddressCountyRow").hide();
                }  

             }

        /* ]]> */
   </script>