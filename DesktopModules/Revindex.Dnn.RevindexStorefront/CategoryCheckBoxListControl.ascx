<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="CategoryCheckBoxListControl.ascx.cs" Inherits="Revindex.Dnn.RevindexStorefront.CategoryCheckBoxListControl" %>
<asp:Panel ID="CategoryPanel" runat="server" Height="250px" ScrollBars="Auto" style="border: solid 10px transparent;">
	<asp:CheckBoxList ID="CategoryCheckBoxList" runat="server" OnSelectedIndexChanged="CategoryCheckBoxList_SelectedIndexChanged" CssClass="rvdFormCheckBoxes">
	</asp:CheckBoxList>
</asp:Panel>
