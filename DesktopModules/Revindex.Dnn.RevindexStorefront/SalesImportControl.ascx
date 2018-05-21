<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="SalesImportControl.ascx.cs" Inherits="Revindex.Dnn.RevindexStorefront.SalesImportControl" %>
<%@ Register Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Src="~/Controls/labelcontrol.ascx" TagName="LabelControl" TagPrefix="dnn1" %>
<%@ Register Src="~/Controls/urlcontrol.ascx" TagName="UrlControl" TagPrefix="dnn1" %>
<%@ Register Assembly="DotNetNuke.Web.Deprecated" Namespace="DotNetNuke.Web.UI.WebControls" TagPrefix="dnn2" %>
<%@ Register Src="WebUserControls/Common/Dnn/BackControl.ascx" TagName="BackControl" TagPrefix="uc1" %>
<asp:PlaceHolder ID="PlaceHolder1" runat="server">

	<script type="text/javascript">
		jQuery(document).ready(function ()
		{
			jQuery('#CatalogDetailsViewTabPanel').dnnTabs();
		});
		Sys.WebForms.PageRequestManager.getInstance().add_endRequest(function ()
		{
			jQuery('#CatalogDetailsViewTabPanel').dnnTabs();
		});
	</script>

</asp:PlaceHolder>
<div>
	<asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
		<Triggers>
			<asp:PostBackTrigger ControlID="ImportLinkButton" />
		</Triggers>
		<ContentTemplate>
			<asp:PlaceHolder ID="MessagePlaceHolder" runat="server" />
			<uc1:BackControl ID="QuickBackControl" runat="server" Text="" CssClass="rvdsfBackAction" />
			<h2>Import sales</h2>
			<div class="dnnFormMessage dnnFormWarning">
			Import is a bulk operation that can overwrite a large amount of data permanently. Please ensure you have taken a full backup before importing.</div>
			<div class="dnnForm">
			<div id="CatalogDetailsViewTabPanel" class="dnnForm">
				<ul class="dnnAdminTabNav dnnClear">
					<li><a href="#<%= GeneralDetailsViewPanel.ClientID %>">
						<asp:Label ID="GeneralDetailsViewTabLabel" runat="server" Text="General" /></a></li>
				</ul>
				<asp:Panel ID="GeneralDetailsViewPanel" runat="server" CssClass="dnnClear">
					<fieldset>
						<div class="dnnFormItem">
							<dnn1:LabelControl ID="EntityTypeLabelControl" runat="server" Text="Import to:" />
							<asp:DropDownList ID="EntityTypeDropDownList" runat="server" >
								<asp:ListItem Text="Right" Value="Right" />
								<asp:ListItem Text="Voucher" Value="Voucher" />
							</asp:DropDownList>
						</div>
						<div class="dnnFormItem">
							<dnn1:LabelControl ID="InputLabelControl" runat="server" Text="Input:" CssClass="dnnFormRequired" />
							<asp:RadioButtonList ID="InputRadioButtonList" runat="server" RepeatLayout="Flow" CssClass="dnnFormRadioButtons" AutoPostBack="True" OnSelectedIndexChanged="InputRadioButtonList_SelectedIndexChanged">
								<asp:ListItem Text="Upload" Value="upload" Selected="True" />
								<asp:ListItem Text="Server" Value="server" />
							</asp:RadioButtonList>
						</div>
						<div class="dnnFormItem">
							<dnn1:LabelControl ID="FileLabelControl" runat="server" Text="File:" CssClass="dnnFormRequired" HelpText="Select the CSV file to import (*.csv, *.txt)" />
							<asp:MultiView ID="FileMultiView" runat="server" ActiveViewIndex="0">
								<asp:View ID="UploadFileView" runat="server">
									<asp:RequiredFieldValidator ID="FileRequiredFieldValidator" runat="server" ControlToValidate="FileUpload" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="CatalogImportDetailsViewControl" Text="File is required."></asp:RequiredFieldValidator>
									<asp:RegularExpressionValidator ID="FileRegularExpressionValidator" runat="server" ControlToValidate="FileUpload" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationExpression=".+\.(csv|txt)$" ValidationGroup="CatalogImportDetailsViewControl" Text="Invalid file. File must be *.csv or *.txt."></asp:RegularExpressionValidator>
									<asp:FileUpload ID="FileUpload" runat="server" CssClass="dnnFormRequired"/>
								</asp:View>
								<asp:View ID="ServerFileView" runat="server">
									<dnn1:UrlControl ID="FileUrlControl" runat="server" ShowDatabase="false" ShowFiles="true" ShowImages="False" ShowLog="false" ShowNewWindow="False" ShowNone="false" ShowSecure="true" ShowTabs="false" ShowTrack="false" ShowUpLoad="True" ShowUrls="false" ShowUsers="false" FileFilter="csv,txt" Required="True"></dnn1:UrlControl>
								</asp:View>
							</asp:MultiView>
						</div>
						<div class="dnnFormItem">
							<dnn1:LabelControl ID="ColumnDelimiterLabelControl" runat="server" Text="Column delimiter:" CssClass="dnnFormRequired" />
							<asp:DropDownList ID="ColumnDelimiterDropDownList" runat="server">
								<asp:ListItem Text="Comma" Value="," />
								<asp:ListItem Text="Pipe" Value="|" />
								<asp:ListItem Text="Semicolon" Value=";" />
								<asp:ListItem Text="Tab" Value="&#9;" />
							</asp:DropDownList>
						</div>
					</fieldset>
				</asp:Panel>
			</div>
			<div class="dnnForm">
				<ul class="dnnActions">
					<li>
						<asp:LinkButton ID="ImportLinkButton" runat="server" Text="Import" OnClick="ImportLinkButton_Click" CssClass="dnnPrimaryAction rvdImportAction" ValidationGroup="CatalogImportDetailsViewControl" />
					</li>
					<li>
						<uc1:BackControl ID="BackControl1" runat="server" Text="Cancel" />
					</li>
				</ul>
			</div>
		</ContentTemplate>
	</asp:UpdatePanel>
</div>
