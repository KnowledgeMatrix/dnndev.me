<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ChannelConfigurationControl.ascx.cs" Inherits="Revindex.Dnn.RevindexStorefront.ChannelConfigurationControl" %>
<%@ Register Src="~/Controls/labelcontrol.ascx" TagName="LabelControl" TagPrefix="dnn1" %>
<%@ Register Assembly="DotNetNuke.Web.Deprecated" Namespace="DotNetNuke.Web.UI.WebControls" TagPrefix="dnn2" %>
<h2>Channels</h2>
<asp:PlaceHolder ID="MessagePlaceHolder" runat="server" />

<script type="text/javascript">
	jQuery(function($)
	{
		$('#<%= DetailsViewPanel.ClientID %>').dnnPanels();
	});
</script>

<asp:Panel ID="DetailsViewPanel" runat="server" CssClass="dnnForm">
	<h2 id="eBayFormSectionHead" class="dnnFormSectionHead">
		<a href="#" class="dnnSectionExpanded">eBay</a></h2>
	<fieldset>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="ChannelSaleseBayActiveLabelControl" runat="server" Text="Enable:" />
			<asp:CheckBox ID="ChannelSaleseBayActiveCheckBox" runat="server" />
			<asp:HyperLink ID="ChannelProviderHyperLink" runat="server" CssClass="rvdLinkAction" Text="Edit"></asp:HyperLink>
		</div>
	</fieldset>
	<ul class="dnnActions">
		<li>
			<asp:LinkButton ID="SaveLinkButton" runat="server" Text="Save" OnClick="SaveLinkButton_Click" ValidationGroup="ConfigurationDetailsViewControl" CssClass="dnnPrimaryAction rvdSaveAction" /></li>
	</ul>
</asp:Panel>
