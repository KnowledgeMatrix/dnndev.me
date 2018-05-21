<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ProductAttributeDefinitionSelectionControl.ascx.cs" Inherits="Revindex.Dnn.RevindexStorefront.ProductAttributeDefinitionSelectionControl" %>
<%@ Register Src="~/Controls/labelcontrol.ascx" TagName="LabelControl" TagPrefix="dnn1" %>
<%@ Register Assembly="DotNetNuke.Web.Deprecated" Namespace="DotNetNuke.Web.UI.WebControls" TagPrefix="dnn2" %>
<div class="rvdFormListBox">
	<dnn2:DnnListBox ID="SelectionDnnListBox" runat="server" AllowReorder="True" AllowDelete="True" OnSelectedIndexChanged="SelectionDnnListBox_SelectedIndexChanged" OnDeleted="SelectionDnnListBox_Deleted" AutoPostBackOnDelete="True" AutoPostBack="True" CausesValidation="False" />
	<div class="rvdActions">
		<asp:LinkButton ID="AddSelectionLinkButton" runat="server" CausesValidation="False" Text="Add item" Localize="false" OnClick="AddSelectionLinkButton_Click" CssClass="dnnPrimaryAction rvdAddNewAction" />
	</div>
	<asp:Panel ID="EditSelectionPanel" runat="server">
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="ItemLabelControl" runat="server" Text="Item:" />
			<asp:TextBox ID="AddSelectionTextBox" runat="server" ></asp:TextBox>
		</div>
		<div class="rvdActions">
			<asp:LinkButton ID="SaveSelectionLinkButton" runat="server" Text="OK" OnClick="SaveSelectionLinkButton_Click" CssClass="dnnPrimaryAction rvdOKAction" />
		</div>
	</asp:Panel>
</div>
