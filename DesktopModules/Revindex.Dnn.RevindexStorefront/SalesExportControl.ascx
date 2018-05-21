<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="SalesExportControl.ascx.cs" Inherits="Revindex.Dnn.RevindexStorefront.SalesExportControl" %>
<%@ Register Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Src="~/Controls/labelcontrol.ascx" TagName="LabelControl" TagPrefix="dnn1" %>
<%@ Register Assembly="DotNetNuke.Web.Deprecated" Namespace="DotNetNuke.Web.UI.WebControls" TagPrefix="dnn2" %>
<%@ Register Src="WebUserControls/Common/Dnn/BackControl.ascx" TagName="BackControl" TagPrefix="uc1" %>
<asp:PlaceHolder ID="PlaceHolder1" runat="server">

	<script type="text/javascript">
		jQuery(document).ready(function ()
		{
			jQuery('#SalesExportDetailsViewTabPanel').dnnTabs();
		});
		Sys.WebForms.PageRequestManager.getInstance().add_endRequest(function ()
		{
			jQuery('#SalesExportDetailsViewTabPanel').dnnTabs();
		});
	</script>

</asp:PlaceHolder>
<div>
	<asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
		<Triggers>
			<asp:PostBackTrigger ControlID="ExportLinkButton" />
		</Triggers>
		<ContentTemplate>
			<asp:PlaceHolder ID="MessagePlaceHolder" runat="server" />
			<uc1:BackControl ID="QuickBackControl" runat="server" Text="" CssClass="rvdsfBackAction" />
			<h2>Export sales</h2>
			<div id="SalesExportDetailsViewTabPanel" class="dnnForm">
				<ul class="dnnAdminTabNav dnnClear">
					<li><a href="#<%= GeneralDetailsViewPanel.ClientID %>">
						<asp:Label ID="GeneralDetailsViewTabLabel" runat="server" Text="General" /></a></li>
				</ul>
				<asp:Panel ID="GeneralDetailsViewPanel" runat="server" CssClass="dnnClear">
					<fieldset>
						<div class="dnnFormItem">
							<dnn1:LabelControl ID="EntityTypeLabelControl" runat="server" Text="Export from:" />
							<asp:DropDownList ID="EntityTypeDropDownList" runat="server" AutoPostBack="True" OnSelectedIndexChanged="EntityTypeDropDownList_SelectedIndexChanged">
								<asp:ListItem Text="Recurring sales order" Value="RecurringSalesOrder" />
								<asp:ListItem Text="Right" Value="Right" />
								<asp:ListItem Text="Sales order" Value="SalesOrder" />
								<asp:ListItem Text="Sales order detail" Value="SalesOrderDetail" />
								<asp:ListItem Text="Voucher" Value="Voucher" />
							</asp:DropDownList>
						</div>
						<div class="dnnFormItem">
							<dnn1:LabelControl ID="OutputLabelControl" runat="server" Text="Output:" />
							<asp:RadioButtonList ID="OutputRadioButtonList" runat="server" RepeatLayout="Flow" CssClass="dnnFormRadioButtons" AutoPostBack="True" OnSelectedIndexChanged="OutputRadioButtonList_SelectedIndexChanged">
								<asp:ListItem Text="Download" Value="download" Selected="True" />
								<asp:ListItem Text="Server" Value="server" />
							</asp:RadioButtonList>
						</div>
						<asp:Panel ID="FolderPanel" runat="server" CssClass="dnnFormItem" Visible="false">
							<dnn1:LabelControl ID="FolderLabelControl" runat="server" Text="File location:" CssClass="dnnFormRequired" />
							<asp:DropDownList ID="FolderDropDownList" runat="server"></asp:DropDownList>
						</asp:Panel>
						<div class="dnnFormItem">
							<dnn1:LabelControl ID="FileLabelControl" runat="server" Text="Filename:" CssClass="dnnFormRequired"/>
							<asp:RequiredFieldValidator ID="FileRequiredFieldValidator" runat="server" ControlToValidate="FileTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="CatalogExportDetailsViewControl" Text="Filename is required."></asp:RequiredFieldValidator>
							<asp:RegularExpressionValidator ID="FileRegularExpressionValidator" runat="server" ControlToValidate="FileTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationExpression="^[\w\-.]+$" ValidationGroup="CatalogExportDetailsViewControl" Text="Invalid filename."></asp:RegularExpressionValidator>
							<asp:TextBox ID="FileTextBox" runat="server" Text=""></asp:TextBox>
						</div>
						<div class="dnnFormItem">
							<dnn1:LabelControl ID="ColumnDelimiterLabelControl" runat="server" Text="Column delimiter:" />
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
						<asp:LinkButton ID="ExportLinkButton" runat="server" Text="Export" OnClick="ExportLinkButton_Click" CssClass="dnnPrimaryAction rvdExportAction" ValidationGroup="CatalogExportDetailsViewControl" />
					</li>
					<li>
						<uc1:BackControl ID="BackControl1" runat="server" Text="Cancel" />
					</li>
				</ul>
			</div>
		</ContentTemplate>
	</asp:UpdatePanel>
</div>
