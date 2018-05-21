<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ApiConfigurationControl.ascx.cs" Inherits="Revindex.Dnn.RevindexStorefront.ApiConfigurationControl" %>
<%@ Register Src="~/Controls/labelcontrol.ascx" TagName="LabelControl" TagPrefix="dnn1" %>
<h2>API</h2>
<asp:PlaceHolder ID="MessagePlaceHolder" runat="server" />
<div class="dnnFormMessage dnnFormWarning">
	The API provides programmatic access to manage your data. Always take a full backup before using the API and never share credential with untrusted users.</div>
<div class="dnnForm">
	<fieldset>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="ApiUrlLabelControl" runat="server" Text="URL:" />
			<asp:HyperLink ID="ApiUrlHyperLink" runat="server" Target="_blank"></asp:HyperLink>
		</div>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="UsernameLabelControl" runat="server" Text="Username:" />
			<asp:Label ID="UsernameLabel" runat="server" Text="Label"></asp:Label>
		</div>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="ApiKeyLabelControl" runat="server" Text="API Key:" />
			<asp:Label ID="ApiKeyLabel" runat="server"></asp:Label> <asp:LinkButton ID="ResetLinkButton" runat="server" OnClick="ResetLinkButton_Click" CssClass="dnnSecondaryAction">Generate new key</asp:LinkButton>
		</div>
	</fieldset>
	<ul class="dnnActions">
		<li>
			<asp:LinkButton ID="SaveLinkButton" runat="server" Text="Save" OnClick="SaveLinkButton_Click" CssClass="dnnPrimaryAction rvdSaveAction" ValidationGroup="ConfigurationDetailsViewControl" />
		</li>
	</ul>
</div>
