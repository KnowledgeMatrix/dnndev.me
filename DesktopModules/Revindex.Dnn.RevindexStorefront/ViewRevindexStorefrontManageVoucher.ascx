<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ViewRevindexStorefrontManageVoucher.ascx.cs" Inherits="Revindex.Dnn.RevindexStorefront.ViewRevindexStorefrontManageVoucher" %>
<div class="rvdsfManageVoucherContainer">
	<div class="dnnForm rvdsfListContainer">
		<asp:GridView ID="VoucherGridView" runat="server" AutoGenerateColumns="False" CssClass="dnnGrid" GridLines="None">
			<AlternatingRowStyle CssClass="dnnGridAltItem" />
			<HeaderStyle CssClass="dnnGridHeader" />
			<RowStyle CssClass="dnnGridItem" />
			<SelectedRowStyle CssClass="dnnGridSelectedItem" />
			<FooterStyle CssClass="dnnGridFooter" />
			<PagerStyle CssClass="dnnGridPager" />
			<Columns>
				<asp:BoundField DataField="Name" HeaderText="NameHeaderVoucherGridView" />
				<asp:BoundField DataField="Code" HeaderText="CodeHeaderVoucherGridView" />
				<asp:BoundField DataField="Status" HeaderText="StatusHeaderVoucherGridView" />
				<asp:BoundField DataField="Amount" HeaderText="AmountHeaderVoucherGridView" />
				<asp:BoundField DataField="StartDate" HeaderText="StartDateHeaderVoucherGridView" />
				<asp:BoundField DataField="StopDate" HeaderText="StopDateHeaderVoucherGridView" />
			</Columns>
		</asp:GridView>
	</div>
</div>
