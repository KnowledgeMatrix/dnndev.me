<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ManufacturerConfigurationControl.ascx.cs" Inherits="Revindex.Dnn.RevindexStorefront.ManufacturerConfigurationControl" %>
<%@ Register Src="~/Controls/labelcontrol.ascx" TagName="LabelControl" TagPrefix="dnn1" %>
<%@ Register Assembly="DotNetNuke.Web.Deprecated" Namespace="DotNetNuke.Web.UI.WebControls" TagPrefix="dnn2" %>
<%@ Register Src="DisplayTemplateDropDownListControl.ascx" TagName="DisplayTemplateDropDownListControl" TagPrefix="uc1" %>
<%@ Register Src="WebUserControls/Common/Dnn/BackControl.ascx" TagName="BackControl" TagPrefix="uc1" %>
<h2>Manufacturer</h2>
<asp:PlaceHolder ID="MessagePlaceHolder" runat="server" />
<script type="text/javascript">
	jQuery(function ($)
	{
		$('#<%= DetailsViewPanel.ClientID %>').dnnPanels();
	});
</script>
<asp:Panel ID="DetailsViewPanel" runat="server" CssClass="dnnForm">
	<h2 id="GeneralFormSectionHead" class="dnnFormSectionHead">
		<a href="#" class="dnnSectionExpanded">General</a></h2>
	<fieldset>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="ManufacturerDisplayTemplateLabelControl" runat="server" Text="Display template:"  HelpText="The selected display template determines how to display the Manufacturer module." />
			<uc1:DisplayTemplateDropDownListControl ID="ManufacturerDisplayTemplateDropDownListControl" runat="server" />
			<asp:LinkButton ID="ManufacturerDisplayTemplateLinkButton" runat="server" CssClass="rvdLinkAction" Text="Edit" OnClick="ManufacturerDisplayTemplateLinkButton_Click" CausesValidation="False" />
		</div>
	</fieldset>
	<script type="text/javascript">
		$(document).ready(function ()
		{
			// Expand features section by default
			if (document.cookie.indexOf("FeaturesFormSectionHead") < 0)
				$("#FeaturesFormSectionHead > a").click();
		});
	</script>
	<h2 id="FeaturesFormSectionHead" class="dnnFormSectionHead">
		<a href="#" class="dnnSectionExpanded">Features</a></h2>
	<fieldset>
		<p>
			The Storefront has many powerful features to help you sell more. Enable just the right features you need to keep your site fast and streamlined.
		</p>
		<div class="dnnFormItem">
			<dnn1:LabelControl runat="server" Text="" />
			<asp:HyperLink ID="AddFeaturesHyperLink" runat="server" Text="+ Enable other features" CssClass="dnnTertiaryAction" />
		</div>
		<div class="rvdsfFeaturesContainer">
			<div class="dnnFormItem">
				<dnn1:LabelControl ID="ManufacturerExtensionActiveLabelControl" runat="server" Text="Extensions:" HelpText="Allow storing additional data."/>
				<asp:CheckBox ID="ManufacturerExtensionActiveCheckBox" runat="server" />
			</div>
		</div>
	</fieldset>
	<ul class="dnnActions">
		<li>
			<asp:LinkButton ID="SaveLinkButton" runat="server" Text="Save" OnClick="SaveLinkButton_Click" ValidationGroup="ConfigurationDetailsViewControl" CssClass="dnnPrimaryAction rvdSaveAction" /></li>
		<li>
			<asp:LinkButton ID="SaveAndBackLinkButton" runat="server" Text="Save & return" OnClick="SaveLinkButton_Click" CommandArgument="Back" CssClass="dnnPrimaryAction rvdSaveAction" ValidationGroup="ConfigurationDetailsViewControl" />
		</li>
		<li>
			<uc1:BackControl ID="BackControl1" runat="server" Text="Cancel" />
		</li>
	</ul>
</asp:Panel>
