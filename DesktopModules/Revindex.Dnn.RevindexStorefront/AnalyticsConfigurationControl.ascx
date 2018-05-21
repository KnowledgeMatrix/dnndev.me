<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="AnalyticsConfigurationControl.ascx.cs" Inherits="Revindex.Dnn.RevindexStorefront.AnalyticsConfigurationControl" %>
<%@ Register Src="~/Controls/labelcontrol.ascx" TagName="LabelControl" TagPrefix="dnn1" %>
<h2>
	Analytics</h2>
<asp:PlaceHolder ID="MessagePlaceHolder" runat="server" />
<div class="dnnForm">
	<fieldset>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="AnalyticsGoogleActiveLabelControl" runat="server" Text="Enable Google analytics:" />
			<asp:CheckBox ID="AnalyticsGoogleActiveCheckBox" runat="server" />
			<asp:HyperLink ID="AnalyticsGoogleHyperLink" runat="server" CssClass="rvdLinkAction" Text="Edit"></asp:HyperLink>
		</div>
	</fieldset>
	<ul class="dnnActions">
		<li>
			<asp:LinkButton ID="SaveLinkButton" runat="server" Text="Save" OnClick="SaveLinkButton_Click" ValidationGroup="ConfigurationDetailsViewControl" CssClass="dnnPrimaryAction rvdSaveAction" /></li>
	</ul>
</div>
