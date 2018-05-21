<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ViewRevindexStorefrontManageProductDownload.ascx.cs" Inherits="Revindex.Dnn.RevindexStorefront.ViewRevindexStorefrontManageProductDownload" %>
<div class="rvdsfManageProductDownloadContainer">
	<div class="dnnForm rvdsfListContainer">
		<asp:GridView ID="ProductDownloadGridView" runat="server" AutoGenerateColumns="False" CssClass="dnnGrid" GridLines="None">
			<AlternatingRowStyle CssClass="dnnGridAltItem" />
			<HeaderStyle CssClass="dnnGridHeader" />
			<RowStyle CssClass="dnnGridItem" />
			<SelectedRowStyle CssClass="dnnGridSelectedItem" />
			<FooterStyle CssClass="dnnGridFooter" />
			<PagerStyle CssClass="dnnGridPager" />
			<Columns>
				<asp:HyperLinkField DataNavigateUrlFields="FileUrl" ControlStyle-CssClass="rvdDownloadGridAction" />
				<asp:BoundField DataField="Name" HeaderText="NameHeaderProductDownloadGridView" />
			</Columns>
		</asp:GridView>
	</div>
</div>
