<%@ Control language="c#" CodeBehind="DefaultAddressCheckout.ascx.cs" Inherits="CartViper.Modules.Store.WebControls.Address.DefaultAddressProvider.DefaultAddressCheckout" AutoEventWireup="True" %>
<%@ Register TagPrefix="dnn" TagName="SectionHead" Src="~/controls/SectionHeadControl.ascx" %>
<%@ Register TagPrefix="dnnstore" TagName="address" Src="~/DesktopModules/cartviper/Address/StoreAddress.ascx" %>
<fieldset class="StoreAccountCheckoutBillingAddress">
	<legend>
	    <asp:Label CssClass="genericColour" id="lblBillingAddressTitle" runat="server" resourcekey="lblBillingAddressTitle"></asp:Label>
	</legend>

    <asp:Label ID="lblCheckoutCaption" CssClass="cvCheckoutCaption" resourcekey="lblCheckoutCaption" runat="server"></asp:Label>

	<dnnstore:address id="addressBilling" runat="server" StartTabIndex="3" Enabled="false"></dnnstore:address>

        <table runat="server" id="tblShippingAddressRadioButtons" class="StoreAccountAddress" style="margin-top:30px;margin-bottom:30px" width="100%">
		    <tr>
			    <td class="StoreAddressLabel">
				    <asp:label id="lblShipAddressOptions" resourcekey="lblShipAddressOptions" runat="server"></asp:label>
			    </td>
			    <td>
				    <asp:radiobutton id="radBilling" tabIndex="21" runat="server"  groupname="radShipAddress" Checked="True"></asp:radiobutton>
				    <asp:label id="lblUseBillingAddress" resourcekey="lblUseBillingAddress" runat="server"></asp:label>
				    <asp:radiobutton id="radShipping" tabIndex="22" runat="server" groupname="radShipAddress"></asp:radiobutton>
				    <asp:label id="lblUseShippingAddress" resourcekey="lblUseShippingAddress" runat="server"></asp:label>
			    </td>
		    </tr>
         </table>
</fieldset>

<script type="text/javascript">
    /* <![CDATA[ */
    <% if(StoreSettings.EnableGoogleAnalyticsTracking && StoreSettings.GoogleAnalyticsTrackingMode == CartViper.Modules.Store.Admin.GoogleAnalyticsMode.Synchronous){ %>
                    
    pageTracker._trackEvent('Checkout', 'ViewBillingAddress');

    <% } else if(StoreSettings.EnableGoogleAnalyticsTracking && StoreSettings.GoogleAnalyticsTrackingMode == CartViper.Modules.Store.Admin.GoogleAnalyticsMode.Asynchronous){ %>
                   
    _gaq.push(['_trackEvent', 'Checkout', 'ViewBillingAddress']);

    <% } %>

    /* ]]> */
</script>