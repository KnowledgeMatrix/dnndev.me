<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="CrosssellProductConfigurationControl.ascx.cs" Inherits="Revindex.Dnn.RevindexStorefront.CrosssellProductConfigurationControl" %>
<%@ Register Src="~/Controls/labelcontrol.ascx" TagName="LabelControl" TagPrefix="dnn1" %>
<%@ Register Assembly="DotNetNuke.Web.Deprecated" Namespace="DotNetNuke.Web.UI.WebControls" TagPrefix="dnn2" %>
<%@ Register Src="CrosssellProductControl.ascx" TagName="CrosssellProductControl" TagPrefix="uc1" %>
<%@ Register Src="WebUserControls/BaseEditorControl.ascx" TagName="BaseEditorControl" TagPrefix="uc1" %>
<h2>
	Cross-sell product</h2>
<uc1:BaseEditorControl ID="BaseEditorControl1" runat="server" />
<asp:PlaceHolder ID="MessagePlaceHolder" runat="server" />

<asp:PlaceHolder ID="PlaceHolder1" runat="server">
    <script type="text/javascript">
        jQuery(document).ready(function ()
        {
            jQuery('#CrosssellProductDetailsViewTabPanel').dnnTabs();
        });
        Sys.WebForms.PageRequestManager.getInstance().add_endRequest(function ()
        {
            jQuery('#CrosssellProductDetailsViewTabPanel').dnnTabs();
        });
    </script>
</asp:PlaceHolder>

<asp:UpdatePanel ID="UpdatePanel1" runat="server">
    <ContentTemplate>
        <div id="CrosssellProductDetailsViewTabPanel" class="dnnForm">
            <ul class="dnnAdminTabNav dnnClear">
                <li><a href="#<%= GeneralDetailsViewPanel.ClientID %>">
                    <asp:Label ID="GeneralDetailsViewTabLabel" runat="server" Text="General" /></a></li>
                <li><a href="#<%= OfferDetailsViewPanel.ClientID %>">
                    <asp:Label ID="AvailabilityDetailsViewTabLabel" runat="server" Text="Offer" /></a></li>
            </ul>
            <asp:Panel ID="GeneralDetailsViewPanel" runat="server" CssClass="dnnClear">
	            <fieldset>
		            <div class="dnnFormItem">
			            <dnn1:LabelControl ID="CrosssellProductMaxItemsLabelControl" runat="server" Text="Max items:" HelpText="The maximum number of products to show to the customer."/>
			            <asp:RegularExpressionValidator ID="CrosssellProductMaxItemsRegularExpressionValidator" runat="server" ControlToValidate="CrosssellProductMaxItemsTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationExpression="^[\d\|]+(px|%){0,1}$" ValidationGroup="ConfigurationDetailsViewControl">Max items is invalid.</asp:RegularExpressionValidator>
			            <asp:TextBox ID="CrosssellProductMaxItemsTextBox" runat="server"></asp:TextBox>
		            </div>
                    <div class="dnnFormItem">
			            <dnn1:LabelControl ID="CrosssellProductPriceShowLabelControl" runat="server" Text="Show price:" HelpText="Show price on cross-sell product." />
			            <asp:CheckBox ID="CrosssellProductPriceShowCheckBox" runat="server" />
		            </div>
		            <div class="dnnFormItem">
			            <dnn1:LabelControl ID="CrosssellProductQuantityShowLabelControl" runat="server" Text="Show quantity:" HelpText="Show quantity on cross-sell product." />
			            <asp:CheckBox ID="CrosssellProductQuantityShowCheckBox" runat="server" />
		            </div>
		            <div class="dnnFormItem">
			            <dnn1:LabelControl ID="CrosssellProductAddToCartShowLabelControl" runat="server" Text="Show Add to Cart button:" HelpText="Show Add to Cart button on cross-sell product." />
			            <asp:CheckBox ID="CrosssellProductAddToCartShowCheckBox" runat="server" />
		            </div>
		            <div class="dnnFormItem">
			            <dnn1:LabelControl ID="CrosssellProductBuyNowShowLabelControl" runat="server" Text="Show Buy Now button:" HelpText="Show Buy Now button on cross-sell product." />
			            <asp:CheckBox ID="CrosssellProductBuyNowShowCheckBox" runat="server" />
		            </div>
                    <div class="dnnFormItem">
			            <dnn1:LabelControl ID="CrosssellProductSeeDetailsShowLabelControl" runat="server" Text="Show See Details button:" HelpText="Show See Details button on cross-sell product." />
			            <asp:CheckBox ID="CrosssellProductSeeDetailsShowCheckBox" runat="server" />
		            </div>
	            </fieldset>
            </asp:Panel>
            <asp:Panel ID="OfferDetailsViewPanel" runat="server" CssClass="dnnClear">
                <fieldset>
                    <div class="dnnFormItem">
                        <uc1:CrosssellProductControl ID="CrosssellProductControl1" runat="server"></uc1:CrosssellProductControl>
                    </div>
                </fieldset>
            </asp:Panel>
        </div>
        <div class="dnnForm">
	        <ul class="dnnActions">
		        <li>
			        <asp:LinkButton ID="SaveLinkButton" runat="server" Text="Save" OnClick="SaveLinkButton_Click" ValidationGroup="ConfigurationDetailsViewControl" CssClass="dnnPrimaryAction rvdSaveAction" /></li>
	        </ul>
        </div>
    </ContentTemplate>
</asp:UpdatePanel>

