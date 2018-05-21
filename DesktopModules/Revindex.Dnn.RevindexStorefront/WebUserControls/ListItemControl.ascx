<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ListItemControl.ascx.cs" Inherits="Revindex.Dnn.RevindexStorefront.WebUserControls.ListItemControl" %>
<%@ Register Src="~/Controls/labelcontrol.ascx" TagName="LabelControl" TagPrefix="dnn1" %>
<%@ Register Assembly="DotNetNuke.Web.Deprecated" Namespace="DotNetNuke.Web.UI.WebControls" TagPrefix="dnn2" %>
<div class="rvdFormListBox">
	<dnn2:DnnListBox ID="SelectionDnnListBox" runat="server" AutoPostBack="True" CausesValidation="False" OnSelectedIndexChanged="SelectionDnnListBox_SelectedIndexChanged" OnDeleted="SelectionDnnListBox_Deleted" AutoPostBackOnDelete="True" CheckBoxes="True" />
	<div class="rvdActions">
		<asp:LinkButton ID="AddSelectionDnnRadButton" runat="server" CausesValidation="False" Text="Add item" OnClick="AddSelectionLinkButton_Click" CssClass="dnnPrimaryAction rvdAddNewAction" />
	</div>
	<asp:Panel ID="EditSelectionPanel" runat="server">
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="NameLabelControl" runat="server" Text="Name:" />
			<asp:TextBox ID="SelectionNameTextBox" runat="server"></asp:TextBox>
		</div>
		<asp:Panel runat="server" ID="SelectionValuePanel" CssClass="dnnFormItem">
			<dnn1:LabelControl ID="SelectionValueLabelControl" runat="server" Text="Value:" />
			<asp:TextBox ID="SelectionValueTextBox" runat="server"></asp:TextBox>
		</asp:Panel>
		<div class="rvdActions">
			<asp:LinkButton ID="SaveSelectionLinkButton" runat="server" Text="OK" OnClick="SaveSelectionLinkButton_Click" CssClass="dnnPrimaryAction rvdOKAction" />
		</div>
	</asp:Panel>
</div>
