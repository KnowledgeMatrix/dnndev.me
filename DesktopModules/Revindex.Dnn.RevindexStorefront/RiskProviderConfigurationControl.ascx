<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="RiskProviderConfigurationControl.ascx.cs" Inherits="Revindex.Dnn.RevindexStorefront.RiskProviderConfigurationControl" %>
<%@ Register Src="~/Controls/labelcontrol.ascx" TagName="LabelControl" TagPrefix="dnn1" %>
<%@ Register Assembly="DotNetNuke.Web.Deprecated" Namespace="DotNetNuke.Web.UI.WebControls" TagPrefix="dnn2" %>
<%@ Register Src="WebUserControls/Common/Dnn/BackControl.ascx" TagName="BackControl" TagPrefix="uc1" %>
<uc1:BackControl ID="QuickBackControl" runat="server" Text="" CssClass="rvdsfBackAction" />
<h2>Risk providers</h2>
<asp:PlaceHolder ID="MessagePlaceHolder" runat="server" />

<script type="text/javascript">
	jQuery(function($)
	{
		$('#<%= DetailsViewPanel.ClientID %>').dnnPanels();
	});
</script>

<asp:Panel ID="DetailsViewPanel" runat="server" CssClass="dnnForm">
    <h2 id="FraudLabsProFormSectionHead" class="dnnFormSectionHead">
		<a href="#" class="dnnSectionExpanded">FraudLabs Pro</a></h2>
	<fieldset>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="RiskProvidersFraudLabsProAPIKeyLabelControl" runat="server" Text="API key:" />
			<asp:TextBox ID="RiskProvidersFraudLabsProAPIKeyTextBox" runat="server" MaxLength="256"></asp:TextBox>
		</div>
	</fieldset>
    <h2 id="SiftScienceFormSectionHead" class="dnnFormSectionHead">
		<a href="#" class="dnnSectionExpanded">Sift Science</a></h2>
	<fieldset>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="RiskProvidersSiftScienceAPIKeyLabelControl" runat="server" Text="API key:" />
			<asp:TextBox ID="RiskProvidersSiftScienceAPIKeyTextBox" runat="server" MaxLength="256"></asp:TextBox>
		</div>
        <div class="dnnFormItem">
			<dnn1:LabelControl ID="RiskProvidersSiftScienceJavascriptSnippetKeyLabelControl" runat="server" Text="Javascript snippet key:" />
			<asp:TextBox ID="RiskProvidersSiftScienceJavascriptSnippetKeyTextBox" runat="server" MaxLength="256"></asp:TextBox>
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
