<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ViewRevindexStorefrontManageRewardsPoint.ascx.cs" Inherits="Revindex.Dnn.RevindexStorefront.ViewRevindexStorefrontManageRewardsPoint" %>
<div class="rvdsfManageRewardsPointContainer">
	<div class="dnnForm rvdsfListContainer">
		<asp:GridView ID="RewardsPointGridView" runat="server" AutoGenerateColumns="False" CssClass="dnnGrid" GridLines="None">
			<AlternatingRowStyle CssClass="dnnGridAltItem" />
			<HeaderStyle CssClass="dnnGridHeader" />
			<RowStyle CssClass="dnnGridItem" />
			<SelectedRowStyle CssClass="dnnGridSelectedItem" />
			<FooterStyle CssClass="dnnGridFooter" />
			<PagerStyle CssClass="dnnGridPager" />
			<Columns>
				<asp:BoundField DataField="Status" HeaderText="StatusHeaderRewardsPointGridView" />
				<asp:BoundField DataField="Points" HeaderText="PointsHeaderRewardsPointGridView" />
				<asp:BoundField DataField="QualifiedPoints" HeaderText="QualifiedPointsHeaderRewardsPointGridView" />
				<asp:BoundField DataField="StopDate" HeaderText="StopDateHeaderRewardsPointGridView" />
			</Columns>
		</asp:GridView>
	</div>
</div>
