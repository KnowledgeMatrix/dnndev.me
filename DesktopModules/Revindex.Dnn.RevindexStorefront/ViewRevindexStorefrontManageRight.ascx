<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ViewRevindexStorefrontManageRight.ascx.cs" Inherits="Revindex.Dnn.RevindexStorefront.ViewRevindexStorefrontManageRight" %>
<div class="rvdsfManageRightContainer">
	<div class="dnnForm rvdsfListContainer">
		<asp:GridView ID="RightGridView" runat="server" AutoGenerateColumns="False" CssClass="dnnGrid" GridLines="None">
			<AlternatingRowStyle CssClass="dnnGridAltItem" />
			<HeaderStyle CssClass="dnnGridHeader" />
			<RowStyle CssClass="dnnGridItem" />
			<SelectedRowStyle CssClass="dnnGridSelectedItem" />
			<FooterStyle CssClass="dnnGridFooter" />
			<PagerStyle CssClass="dnnGridPager" />
			<Columns>
				<asp:BoundField DataField="Name" HeaderText="NameHeaderRightGridView" />
				<asp:BoundField DataField="Code" HeaderText="CodeHeaderRightGridView" />
			</Columns>
		</asp:GridView>
	</div>
</div>
