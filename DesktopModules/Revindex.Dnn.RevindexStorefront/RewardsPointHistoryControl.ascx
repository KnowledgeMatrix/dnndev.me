<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="RewardsPointHistoryControl.ascx.cs" Inherits="Revindex.Dnn.RevindexStorefront.RewardsPointHistoryControl" %>
<%@ Register Assembly="DotNetNuke.Web.Deprecated" Namespace="DotNetNuke.Web.UI.WebControls" TagPrefix="cc2" %>
<%@ Register Assembly="Revindex.Web.UI.WebControls" Namespace="Revindex.Web.UI.WebControls" TagPrefix="rvd1" %>
<%@ Register Src="~/Controls/labelcontrol.ascx" TagName="LabelControl" TagPrefix="uc3" %>
<%@ Register Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI" TagPrefix="asp" %>
<div>
	<asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
		<ContentTemplate>
			<div class="dnnForm">
				<asp:GridView ID="RewardsPointHistoryGridView" runat="server" CssClass="dnnGrid" GridLines="None" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="RewardsPointHistoryID" OnRowDataBound="RewardsPointHistoryGridView_RowDataBound">
					<AlternatingRowStyle CssClass="dnnGridAltItem" />
					<HeaderStyle CssClass="dnnGridHeader" />
					<RowStyle CssClass="dnnGridItem" />
					<SelectedRowStyle CssClass="dnnGridSelectedItem" />
					<FooterStyle CssClass="dnnGridFooter" />
					<PagerStyle CssClass="dnnGridPager" />
					<Columns>
						<asp:BoundField DataField="HistoryDate" HeaderText="Date" SortExpression="HistoryDate" DataFormatString="{0:yyyy-MM-dd}" />
						<asp:BoundField DataField="Operation" HeaderText="Operation" SortExpression="Operation" />
						<asp:BoundField DataField="PointsAdjustment" HeaderText="Points adjusted" SortExpression="PointsAdjustment" />
						<asp:BoundField DataField="SalesOrderID" HeaderText="Sales order" SortExpression="SalesOrderID" />
					</Columns>
				</asp:GridView>
				<asp:ObjectDataSource ID="RewardsPointHistoryObjectDataSource" runat="server" EnablePaging="True" SelectCountMethod="GetCount" SelectMethod="GetAll" SortParameterName="sortExpression" TypeName="Revindex.Business.Revindex.Revindex.Storefront.RewardsPointHistoryController">
					<SelectParameters>
						<asp:Parameter Name="sortExpression" Type="String" />
						<asp:Parameter Name="maximumRows" Type="Int32" />
						<asp:Parameter Name="startRowIndex" Type="Int32" />
						<rvd1:UserControlParameter Name="rewardsPointID" PropertyName="RewardsPointID" Type="Int32" />
					</SelectParameters>
				</asp:ObjectDataSource>
			</div>
		</ContentTemplate>
	</asp:UpdatePanel>
</div>
