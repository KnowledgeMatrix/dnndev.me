<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="CategoryConfigurationControl.ascx.cs" Inherits="Revindex.Dnn.RevindexStorefront.CategoryConfigurationControl" %>
<%@ Register Src="~/Controls/labelcontrol.ascx" TagName="LabelControl" TagPrefix="dnn1" %>
<%@ Register Src="DisplayTemplateDropDownListControl.ascx" TagName="DisplayTemplateDropDownListControl" TagPrefix="uc1" %>
<%@ Register Src="WebUserControls/Common/Dnn/BackControl.ascx" TagName="BackControl" TagPrefix="uc1" %>
<h2>Category</h2>
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
			<dnn1:LabelControl ID="CategoryDisplayTemplateLabelControl" runat="server" Text="Display template:" HelpText="The selected display template determines how to display the Category module." />
			<uc1:DisplayTemplateDropDownListControl ID="CategoryDisplayTemplateDropDownListControl" runat="server" />
			<asp:LinkButton ID="CategoryDisplayTemplateLinkButton" runat="server" CssClass="rvdLinkAction" Text="Edit" OnClick="CategoryDisplayTemplateLinkButton_Click" CausesValidation="False" />
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
				<dnn1:LabelControl ID="CategoryAvailabilityActiveLabelControl" runat="server" Text="Availability:" HelpText="Allow configuring when this category should be available based on rules."/>
				<asp:CheckBox ID="CategoryAvailabilityActiveCheckBox" runat="server" />
			</div>
			<div class="dnnFormItem">
				<dnn1:LabelControl ID="CategoryExtensionActiveLabelControl" runat="server" Text="Extensions:" HelpText="Allow storing additional data."/>
				<asp:CheckBox ID="CategoryExtensionActiveCheckBox" runat="server" />
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
