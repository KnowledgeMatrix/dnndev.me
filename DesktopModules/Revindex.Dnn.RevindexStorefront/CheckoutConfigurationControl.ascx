<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="CheckoutConfigurationControl.ascx.cs" Inherits="Revindex.Dnn.RevindexStorefront.CheckoutConfigurationControl" %>
<%@ Register Src="~/Controls/labelcontrol.ascx" TagName="LabelControl" TagPrefix="dnn1" %>
<%@ Register Src="DisplayTemplateDropDownListControl.ascx" TagName="DisplayTemplateDropDownListControl" TagPrefix="uc1" %>
<%@ Register Src="CheckoutConfigurationAvailabilityRuleControl.ascx" TagName="CheckoutConfigurationAvailabilityRuleControl" TagPrefix="uc1" %>
<%@ Register Src="CheckoutConfigurationPlaceOrderActionRuleControl.ascx" TagName="CheckoutConfigurationPlaceOrderActionRuleControl" TagPrefix="uc1" %>
<%@ Register Src="CheckoutConfigurationDynamicFormCodeControl.ascx" TagName="CheckoutConfigurationDynamicFormCodeControl" TagPrefix="uc1" %>
<%@ Register Src="WebUserControls/BaseEditorControl.ascx" TagName="BaseEditorControl" TagPrefix="uc1" %>
<h2>Checkout</h2>
<uc1:BaseEditorControl ID="BaseEditorControl1" runat="server" />
<asp:PlaceHolder ID="MessagePlaceHolder" runat="server" />

<script type="text/javascript">
    jQuery(document).ready(function()
    {
        jQuery('#CheckoutDetailsViewTabPanel').dnnTabs();
	});
</script>

<div id="CheckoutDetailsViewTabPanel" class="dnnForm">
    <ul class="dnnAdminTabNav dnnClear">
        <li><a href="#<%= GeneralDetailsViewPanel.ClientID %>">
            <asp:Label ID="GeneralDetailsViewTabLabel" runat="server" Text="General" /></a></li>
        <li><a href="#<%= AvailabilityDetailsViewPanel.ClientID %>">
            <asp:Label ID="AvailabilityDetailsViewTabLabel" runat="server" Text="Availability" /></a></li>
        <li><a href="#<%= CustomFieldDetailsViewPanel.ClientID %>">
            <asp:Label ID="CustomFieldDetailsViewTabLabel" runat="server" Text="Custom field" /></a></li>
        <li><a href="#<%= ActionDetailsViewPanel.ClientID %>">
            <asp:Label ID="ActionDetailsViewTabLabel" runat="server" Text="Action" /></a></li>
    </ul>
    <asp:Panel ID="GeneralDetailsViewPanel" runat="server" CssClass="dnnClear">
        <fieldset>
            <div class="dnnFormItem">
                <dnn1:LabelControl ID="CheckoutAnonymousAccountActiveLabelControl" runat="server" Text="Enable anonymous checkout:" HelpText="Allow customers to complete purchase without registering an account. The Storefront will automatically create a guest account upon placing order." />
                <asp:CheckBox ID="CheckoutAnonymousAccountActiveCheckBox" runat="server" />
            </div>
            <div class="dnnFormItem">
                <dnn1:LabelControl ID="CheckoutAnonymousAccountReuseLabelControl" runat="server" Text="Reuse anonymous account:" HelpText="Allow reusing an existing guest account by matching the email address will reduce the number of redundant accounts created in the system provided that you consider the email address to be a unique identifier." />
                <asp:CheckBox ID="CheckoutAnonymousAccountReuseCheckBox" runat="server" />
            </div>
            <div class="dnnFormItem">
                <dnn1:LabelControl ID="CheckoutDisplayTemplateLabelControl" runat="server" Text="Display template:" HelpText="The selected display template determines how to display the Checkout module." />
                <uc1:DisplayTemplateDropDownListControl ID="CheckoutDisplayTemplateDropDownListControl" runat="server" />
				<asp:LinkButton ID="CheckoutDisplayTemplateLinkButton" runat="server" CssClass="rvdLinkAction" Text="Edit" OnClick="CheckoutDisplayTemplateLinkButton_Click" CausesValidation="False" />
            </div>
            <div class="dnnFormItem">
                <dnn1:LabelControl ID="CheckoutPageViewModeLabelControl" runat="server" Text="View mode:" HelpText="Determine if the customer is presented with a single or multiple step checkout page." />
                <asp:DropDownList ID="CheckoutPageViewModeDropDownList" runat="server">
                    <asp:ListItem Text="Single step" Value="1" />
                    <asp:ListItem Text="Multiple step" Value="2" />
                </asp:DropDownList>
            </div>
            <div class="dnnFormItem">
                <dnn1:LabelControl ID="CheckoutShowBusinessTaxNumberLabelControl" runat="server" Text="Show business tax number:" HelpText="Allow customer to enter their business state sales tax number or VAT number usually used for tax exemption." />
                <asp:CheckBox ID="CheckoutShowBusinessTaxNumberCheckBox" runat="server" />
            </div>
            <div class="dnnFormItem">
                <dnn1:LabelControl ID="CheckoutShowPurchaseOrderNumberLabelControl" runat="server" Text="Show purchase order number:" HelpText="Allow customers to enter the purchase order number usually intended for corporate purchases." />
                <asp:CheckBox ID="CheckoutShowPurchaseOrderNumberCheckBox" runat="server" />
            </div>
        </fieldset>
    </asp:Panel>
    <asp:Panel ID="AvailabilityDetailsViewPanel" runat="server" CssClass="dnnClear">
        <fieldset>
            <uc1:CheckoutConfigurationAvailabilityRuleControl ID="CheckoutConfigurationAvailabilityRuleControl" runat="server" Width="100%" />
        </fieldset>
    </asp:Panel>
    <asp:Panel ID="CustomFieldDetailsViewPanel" runat="server" CssClass="dnnClear">
        <fieldset>
            <uc1:CheckoutConfigurationDynamicFormCodeControl ID="CheckoutConfigurationDynamicFormCodeControl" runat="server" Width="100%" />
        </fieldset>
    </asp:Panel>
    <asp:Panel ID="ActionDetailsViewPanel" runat="server" CssClass="dnnClear">
        <fieldset>
            <div class="dnnFormItem">
                <dnn1:LabelControl ID="CheckoutRunPlaceOrderActionRuleLabelControl" runat="server" Text="Run action on checkout:" />
                <asp:CheckBox ID="CheckoutRunPlaceOrderActionRuleCheckBox" runat="server" />
            </div>
            <uc1:CheckoutConfigurationPlaceOrderActionRuleControl ID="CheckoutConfigurationPlaceOrderActionRuleControl" runat="server" Width="100%" />
        </fieldset>
    </asp:Panel>
</div>
<div class="dnnForm">
    <fieldset>
    </fieldset>
    <ul class="dnnActions">
        <li>
            <asp:LinkButton ID="SaveLinkButton" runat="server" Text="Save" OnClick="SaveLinkButton_Click" ValidationGroup="ConfigurationDetailsViewControl" CssClass="dnnPrimaryAction rvdSaveAction" /></li>
    </ul>
</div>
