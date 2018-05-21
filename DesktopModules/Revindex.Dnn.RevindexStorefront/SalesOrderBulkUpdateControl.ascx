<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="SalesOrderBulkUpdateControl.ascx.cs" Inherits="Revindex.Dnn.RevindexStorefront.SalesOrderBulkUpdateControl" %>
<%@ Register Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Src="~/Controls/labelcontrol.ascx" TagName="LabelControl" TagPrefix="dnn1" %>
<%@ Register Src="~/Controls/urlcontrol.ascx" TagName="UrlControl" TagPrefix="dnn1" %>
<%@ Register Assembly="DotNetNuke.Web.Deprecated" Namespace="DotNetNuke.Web.UI.WebControls" TagPrefix="dnn2" %>
<%@ Register Src="WebUserControls/Common/Dnn/BackControl.ascx" TagName="BackControl" TagPrefix="uc1" %>
<asp:PlaceHolder ID="PlaceHolder1" runat="server">

	<script type="text/javascript">
		$(document).ready(function ()
		{
			$('#SalesOrderBulkDetailsViewTabPanel').dnnTabs();
			$('#<%= ResultPanel.ClientID %>').dnnPanels();
		});
		Sys.WebForms.PageRequestManager.getInstance().add_endRequest(function ()
		{
			$('#SalesOrderBulkDetailsViewTabPanel').dnnTabs();
			$('#<%= ResultPanel.ClientID %>').dnnPanels();
		});
	</script>

</asp:PlaceHolder>
<div>
	<asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
		<ContentTemplate>
			<asp:PlaceHolder ID="MessagePlaceHolder" runat="server" />
			<uc1:BackControl ID="QuickBackControl" runat="server" Text="" CssClass="rvdsfBackAction" />
			<h2>Bulk operation</h2>
			<p>The bulk update allows you to execute common operations on a large number of items in a batch.</p>
			<div class="dnnForm">
				<div id="SalesOrderBulkDetailsViewTabPanel" class="dnnForm">
					<ul class="dnnAdminTabNav dnnClear">
						<li><a href="#<%= GeneralDetailsViewPanel.ClientID %>">
							<asp:Label ID="GeneralDetailsViewTabLabel" runat="server" Text="General" /></a></li>
					</ul>
					<asp:Panel ID="GeneralDetailsViewPanel" runat="server" CssClass="dnnClear">
						<fieldset>
							<div class="dnnFormItem">
								<dnn1:LabelControl ID="CountLabelControl" runat="server" Text="Number of items:" />
								<asp:Label ID="CountLabel" runat="server" />
							</div>
							<div class="dnnFormItem">
								<dnn1:LabelControl ID="OperationLabelControl" runat="server" Text="Operation:" />
								<asp:DropDownList ID="OperationDropDownList" runat="server" AutoPostBack="True" OnSelectedIndexChanged="OperationDropDownList_SelectedIndexChanged">
									<asp:ListItem Text="Capture payment - capture previously authorized payments" Value="capturepayment" />
									<asp:ListItem Text="Update sales order" Value="updatesalesorder" Selected="True" />
								</asp:DropDownList>
							</div>
							<asp:MultiView ID="OperationMultiView" runat="server" ActiveViewIndex="1">
								<asp:View ID="CapturePaymentView" runat="server">
									<div class="dnnFormItem">
									</div>
								</asp:View>
								<asp:View ID="UpdateSalesOrderView" runat="server">
									<div class="dnnFormItem">
										<dnn1:LabelControl ID="StatusLabelControl" runat="server" Text="Order status:" />
										<asp:CheckBox ID="UpdateStatusCheckBox" runat="server" />
										<asp:DropDownList ID="StatusDropDownList" runat="server">
											<asp:ListItem Value="7" style="background-color: Silver">Incomplete</asp:ListItem>
											<asp:ListItem Value="1" style="background-color: HotPink">Pending</asp:ListItem>
											<asp:ListItem Value="8" style="background-color: Yellow">Preordered</asp:ListItem>
											<asp:ListItem Value="2" style="background-color: Gold">Ordered</asp:ListItem>
											<asp:ListItem Value="3" style="background-color: SkyBlue">Processing</asp:ListItem>
											<asp:ListItem Value="4" style="background-color: YellowGreen">Completed</asp:ListItem>
											<asp:ListItem Value="5" style="background-color: Khaki">Cancelled</asp:ListItem>
											<asp:ListItem Value="6" style="background-color: Red">Declined</asp:ListItem>
										</asp:DropDownList>
									</div>
									<div class="dnnFormItem">
										<dnn1:LabelControl ID="SalesPaymentStatusLabelControl" runat="server" Text="Payment status:" />
										<asp:CheckBox ID="UpdateSalesPaymentStatusCheckBox" runat="server" />
										<asp:DropDownList ID="SalesPaymentStatusDropDownList" runat="server">
											<asp:ListItem Value="6" style="background-color: Silver">Incomplete</asp:ListItem>
											<asp:ListItem Value="1" style="background-color: HotPink">Pending</asp:ListItem>
											<asp:ListItem Value="2" style="background-color: YellowGreen">Paid</asp:ListItem>
											<asp:ListItem Value="3" style="background-color: Khaki">Cancelled</asp:ListItem>
											<asp:ListItem Value="4" style="background-color: DarkKhaki">Refunded</asp:ListItem>
											<asp:ListItem Value="5" style="background-color: Red">Declined</asp:ListItem>
										</asp:DropDownList>
									</div>
									<div class="dnnFormItem">
										<dnn1:LabelControl ID="ShippingStatusLabelControl" runat="server" Text="Shipping status:" />
										<asp:CheckBox ID="UpdateShippingStatusCheckBox" runat="server" />
										<asp:DropDownList ID="ShippingStatusDropDownList" runat="server">
											<asp:ListItem Value="1" style="background-color: LightGreen">Not Required</asp:ListItem>
											<asp:ListItem Value="2" style="background-color: Gold">Not Shipped</asp:ListItem>
											<asp:ListItem Value="5" style="background-color: LightBlue">Packing</asp:ListItem>
											<asp:ListItem Value="6" style="background-color: SkyBlue">Packed</asp:ListItem>
											<asp:ListItem Value="7" style="background-color: SteelBlue">Dispatching</asp:ListItem>
											<asp:ListItem Value="3" style="background-color: YellowGreen">Shipped</asp:ListItem>
											<asp:ListItem Value="4" style="background-color: Red">Undeliverable</asp:ListItem>
										</asp:DropDownList>
									</div>
								</asp:View>
							</asp:MultiView>
						</fieldset>
					</asp:Panel>
				</div>
				<div class="dnnForm">
					<ul class="dnnActions">
						<li>
							<asp:LinkButton ID="ExecuteLinkButton" runat="server" Text="Execute" OnClick="ExecuteLinkButton_Click" CssClass="dnnPrimaryAction rvdSaveAction" ValidationGroup="SalesOrderBulkDetailsViewControl" />
						</li>
						<li>
							<uc1:BackControl ID="BackControl1" runat="server" Text="Cancel" />
						</li>
					</ul>
				</div>
				<asp:Panel ID="ResultPanel" runat="server" CssClass="dnnForm" >
					<h2 id="ResultSectionHead" class="dnnFormSectionHead">
						<a href="#" class="dnnSectionExpanded">Result</a></h2>
					<fieldset>
						<asp:PlaceHolder ID="ResultPlaceHolder" runat="server" />
						<asp:GridView ID="ResultGridView" runat="server" AutoGenerateColumns="False" CssClass="dnnGrid" GridLines="None" EnableViewState="False">
							<AlternatingRowStyle CssClass="dnnGridAltItem" />
							<HeaderStyle CssClass="dnnGridHeader" />
							<RowStyle CssClass="dnnGridItem" />
							<SelectedRowStyle CssClass="dnnGridSelectedItem" />
							<FooterStyle CssClass="dnnGridFooter" />
							<PagerStyle CssClass="dnnGridPager" />
							<Columns>
								<asp:HyperLinkField DataTextField="Name" DataNavigateUrlFields="Url" Target="_blank" HeaderText="Item" />
								<asp:BoundField DataField="Success" HeaderText="Success" />
								<asp:BoundField DataField="Message" HeaderText="Message" />
							</Columns>
						</asp:GridView>
					</fieldset>
				</asp:Panel>
		</ContentTemplate>
	</asp:UpdatePanel>
</div>
