<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="FulfillmentMethodConfigurationControl.ascx.cs" Inherits="Revindex.Dnn.RevindexStorefront.FulfillmentMethodConfigurationControl" %>
<%@ Register Src="~/Controls/labelcontrol.ascx" TagName="LabelControl" TagPrefix="dnn1" %>
<%@ Register Assembly="DotNetNuke.Web.Deprecated" Namespace="DotNetNuke.Web.UI.WebControls" TagPrefix="dnn2" %>
<h2>
	Fulfillment methods</h2>
<asp:PlaceHolder ID="MessagePlaceHolder" runat="server" />

<script type="text/javascript">
	jQuery(function($)
	{
		$('#<%= DetailsViewPanel.ClientID %>').dnnPanels();
	});
</script>

<asp:Panel ID="SearchPanel" runat="server" CssClass="dnnForm rvdsfSearchContainer">
	<fieldset>
        <div class="dnnFormItem">
			<dnn1:LabelControl runat="server" ID="SellerSearchLabelControl" Text="Seller:" HelpText="View items belonging to a specific seller."></dnn1:LabelControl>
			<dnn2:DnnComboBox ID="SellerSearchDnnComboBox" runat="server" AllowCustomText="True" EnableLoadOnDemand="True" OnItemsRequested="SellerSearchDnnComboBox_ItemsRequested" AutoPostBack="True" CausesValidation="False" MaxHeight="200px" OnSelectedIndexChanged="SellerSearchDnnComboBox_SelectedIndexChanged"></dnn2:DnnComboBox>
		</div>
    </fieldset>
</asp:Panel>
<asp:Panel ID="DetailsViewPanel" runat="server" CssClass="dnnForm">
	<h2 id="ShipWorksFormSectionHead" class="dnnFormSectionHead">
		<a href="#" class="dnnSectionExpanded">ShipWorks</a></h2>
	<fieldset>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="FulfillmentMethodsShipWorksActiveLabelControl" runat="server" Text="Enable:" HelpText="This fulfillment method allows ShipWorks to download orders and fulfill them." />
			<asp:CheckBox ID="FulfillmentMethodsShipWorksActiveCheckBox" runat="server" />
			<asp:HyperLink ID="FulfillmentProviderHyperLink" runat="server" CssClass="rvdLinkAction" Text="Edit"></asp:HyperLink>
		</div>
	</fieldset>
	<ul class="dnnActions">
		<li>
			<asp:LinkButton ID="SaveLinkButton" runat="server" Text="Save" OnClick="SaveLinkButton_Click" ValidationGroup="ConfigurationDetailsViewControl" CssClass="dnnPrimaryAction rvdSaveAction" /></li>
	</ul>
</asp:Panel>
