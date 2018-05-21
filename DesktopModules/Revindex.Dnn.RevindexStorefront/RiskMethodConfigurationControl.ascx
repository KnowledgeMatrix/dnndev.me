<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="RiskMethodConfigurationControl.ascx.cs" Inherits="Revindex.Dnn.RevindexStorefront.RiskMethodConfigurationControl" %>
<%@ Register Src="~/Controls/labelcontrol.ascx" TagName="LabelControl" TagPrefix="dnn1" %>
<%@ Register Assembly="DotNetNuke.Web.Deprecated" Namespace="DotNetNuke.Web.UI.WebControls" TagPrefix="dnn2" %>
<h2>
	Risk methods</h2>
<asp:PlaceHolder ID="MessagePlaceHolder" runat="server" />

<script type="text/javascript">
	jQuery(function($)
	{
		$('#<%= DetailsViewPanel.ClientID %>').dnnPanels();
	});
</script>

<asp:Panel ID="DetailsViewPanel" runat="server" CssClass="dnnForm">
	<h2 id="FraudFormSectionHead" class="dnnFormSectionHead">
		<a href="#" class="dnnSectionExpanded">Fraud</a></h2>
	<fieldset>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="RiskMethodsFraudActiveLabelControl" runat="server" Text="Enable:" HelpText="Enable fraud protection to reduce business risk." />
			<asp:CheckBox ID="RiskMethodsFraudActiveCheckBox" runat="server" />
		</div>
        <div class="dnnFormItem">
			<dnn1:LabelControl ID="RiskMethodsFraudRiskGatewayLabelControl" runat="server" Text="Fraud risk provider:" />
			<asp:DropDownList ID="RiskMethodsFraudRiskGatewayDropDownList" runat="server">
				<asp:ListItem Text="Manual" Value="" />
                <asp:ListItem Text="FraudLabs Pro" Value="FraudLabsPro" />
				<asp:ListItem Text="Sift Science" Value="SiftScience" />
			</asp:DropDownList>
			<asp:HyperLink ID="RiskMethodsFraudRiskGatewayHyperLink" runat="server" CssClass="rvdLinkAction" Text="Edit"></asp:HyperLink>
		</div>
	</fieldset>
	<ul class="dnnActions">
		<li>
			<asp:LinkButton ID="SaveLinkButton" runat="server" Text="Save" OnClick="SaveLinkButton_Click" ValidationGroup="ConfigurationDetailsViewControl" CssClass="dnnPrimaryAction rvdSaveAction" /></li>
	</ul>
</asp:Panel>
