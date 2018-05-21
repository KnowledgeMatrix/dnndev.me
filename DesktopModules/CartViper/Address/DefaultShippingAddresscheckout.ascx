<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="DefaultShippingAddresscheckout.ascx.cs" Inherits="CartViper.Modules.Store.WebControls.Address.DefaultShippingAddresscheckout" %>
<%@ Register TagPrefix="dnn" TagName="SectionHead" Src="~/controls/SectionHeadControl.ascx" %>
<%@ Register TagPrefix="dnnstore" TagName="address" Src="~/DesktopModules/cartviper/Address/StoreAddress.ascx" %>

<fieldset class="StoreAccountCheckoutShippingAddress">
	<legend>
	    <asp:Label CssClass="genericColour" id="lblShippingAddressTitle" runat="server" resourcekey="lblShippingAddressTitle"></asp:Label>
	</legend>

    <asp:Label ID="lblCheckoutCaption" CssClass="cvCheckoutCaption" runat="server"></asp:Label>

	<dnnstore:address id="addressShipping" runat="server" StartTabIndex="3" Enabled="false"></dnnstore:address>
    
    <asp:Label ID="lblShowBillingAddress" runat="server"></asp:Label>

</fieldset>

<script type="text/javascript">
    /* <![CDATA[ */
    <% if(StoreSettings.EnableGoogleAnalyticsTracking && StoreSettings.GoogleAnalyticsTrackingMode == CartViper.Modules.Store.Admin.GoogleAnalyticsMode.Synchronous){ %>
                    
    pageTracker._trackEvent('Checkout', 'ViewShippingAddress');

    <% } else if(StoreSettings.EnableGoogleAnalyticsTracking && StoreSettings.GoogleAnalyticsTrackingMode == CartViper.Modules.Store.Admin.GoogleAnalyticsMode.Asynchronous){ %>
                   
    _gaq.push(['_trackEvent', 'Checkout', 'ViewShippingAddress']);

    <% } %>

    /* ]]> */
</script>