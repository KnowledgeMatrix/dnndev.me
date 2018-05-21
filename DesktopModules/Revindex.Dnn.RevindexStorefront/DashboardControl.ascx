<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="DashboardControl.ascx.cs" Inherits="Revindex.Dnn.RevindexStorefront.DashboardControl" %>
<%@ Register Src="~/Controls/labelcontrol.ascx" TagName="LabelControl" TagPrefix="dnn1" %>
<h2>Dashboard</h2>
<asp:PlaceHolder ID="MessagePlaceHolder" runat="server" />
<div class="rvdsfDashboardLeftAsideContainer">
	<div class="rvdsfDashboardOrderStatusContainer">
		<h3 id="OrderStatusHeaderSection" class="dnnFormSectionHead">
			Order status</h3>
		<table class="rvdsfDashboardOrderStatusGrid">
			<tr>
				<th>
					<asp:Label ID="TotalOrderStatusTotalLabel" runat="server">0</asp:Label>
					<asp:Label ID="OrderSubHeaderLabel" runat="server" Text="Order"></asp:Label>
				</th>
				<th>
					<asp:Label ID="PaymentSubHeaderLabel" runat="server" Text="Payment"></asp:Label>
				</th>
				<th>
					<asp:Label ID="ShipmentSubHeaderLabel" runat="server" Text="Shipment"></asp:Label>
				</th>
				<th>
					<asp:Label ID="TotalRecurringOrderStatusTotalLabel" runat="server">0</asp:Label>
					<asp:Label ID="RecurringOrderSubHeaderLabel" runat="server" Text="Recurring"></asp:Label>
				</th>
			</tr>
			<tr>
				<td style="background-color: Silver">
					<asp:Label ID="IncompleteOrderStatusTotalLabel" runat="server">0</asp:Label>
					<asp:HyperLink ID="IncompleteOrderStatusHyperLink" runat="server" Text="Incomplete" />
				</td>
				<td style="background-color: Silver">
					<asp:Label ID="PaymentIncompleteOrderStatusTotalLabel" runat="server">0</asp:Label>
					<asp:HyperLink ID="PaymentIncompleteOrderStatusHyperLink" runat="server" Text="Incomplete" />
				</td>
				<td style="background-color: LightGreen">
					<asp:Label ID="ShippingNotRequiredOrderStatusTotalLabel" runat="server">0</asp:Label>
					<asp:HyperLink ID="ShippingNotRequiredOrderStatusHyperLink" runat="server" Text="Not required" />
				</td>
				<td style="background-color: SkyBlue">
					<asp:Label ID="RecurringOrderActiveOrderStatusTotalLabel" runat="server">0</asp:Label>
					<asp:HyperLink ID="RecurringOrderActiveOrderStatusHyperLink" runat="server" Text="Active" />
				</td>
			</tr>
			<tr>
				<td style="background-color: HotPink">
					<asp:Label ID="PendingOrderStatusTotalLabel" runat="server">0</asp:Label>
					<asp:HyperLink ID="PendingOrderStatusHyperLink" runat="server" Text="Pending" />
				</td>
				<td style="background-color: HotPink">
					<asp:Label ID="PaymentPendingOrderStatusTotalLabel" runat="server">0</asp:Label>
					<asp:HyperLink ID="PaymentPendingOrderStatusHyperLink" runat="server" Text="Pending" />
				</td>
				<td style="background-color: Gold">
					<asp:Label ID="ShippingNotShippedOrderStatusTotalLabel" runat="server">0</asp:Label>
					<asp:HyperLink ID="ShippingNotShippedOrderStatusHyperLink" runat="server" Text="Not shipped" />
				</td>
				<td style="background-color: HotPink">
					<asp:Label ID="RecurringOrderHoldOrderStatusTotalLabel" runat="server">0</asp:Label>
					<asp:HyperLink ID="RecurringOrderHoldOrderStatusHyperLink" runat="server" Text="Hold" />
				</td>
			</tr>
			<tr>
				<td style="background-color: DeepPink">
					<asp:Label ID="QuotedOrderStatusTotalLabel" runat="server">0</asp:Label>
					<asp:HyperLink ID="QuotedOrderStatusHyperLink" runat="server" Text="Quoted" />
				</td>
				<td style="background-color: YellowGreen">
					<asp:Label ID="PaymentPaidOrderStatusTotalLabel" runat="server">0</asp:Label>
					<asp:HyperLink ID="PaymentPaidOrderStatusHyperLink" runat="server" Text="Paid" />
				</td>
				<td style="background-color: LightBlue">
					<asp:Label ID="ShippingPackingOrderStatusTotalLabel" runat="server">0</asp:Label>
					<asp:HyperLink ID="ShippingPackingOrderStatusHyperLink" runat="server" Text="Packing" />
				</td>
				<td style="background-color: Red">
					<asp:Label ID="RecurringOrderInvalidOrderStatusTotalLabel" runat="server">0</asp:Label>
					<asp:HyperLink ID="RecurringOrderInvalidOrderStatusHyperLink" runat="server" Text="Invalid" />
				</td>
			</tr>
			<tr>
				<td style="background-color: Yellow">
					<asp:Label ID="PreorderedOrderStatusTotalLabel" runat="server">0</asp:Label>
					<asp:HyperLink ID="PreorderedOrderStatusHyperLink" runat="server" Text="Preordered" />
				</td>
				<td style="background-color: Red">
					<asp:Label ID="PaymentDeclinedOrderStatusTotalLabel" runat="server">0</asp:Label>
					<asp:HyperLink ID="PaymentDeclinedOrderStatusHyperLink" runat="server" Text="Declined" />
				</td>
				<td style="background-color: SkyBlue">
					<asp:Label ID="ShippingPackedOrderStatusTotalLabel" runat="server">0</asp:Label>
					<asp:HyperLink ID="ShippingPackedOrderStatusHyperLink" runat="server" Text="Packed" />
				</td>
				<td style="background-color: Khaki">
					<asp:Label ID="RecurringOrderCancelledOrderStatusTotalLabel" runat="server">0</asp:Label>
					<asp:HyperLink ID="RecurringOrderCancelledOrderStatusHyperLink" runat="server" Text="Cancelled" />
				</td>
			</tr>
			<tr>
				<td style="background-color: Gold">
					<asp:Label ID="OrderedOrderStatusTotalLabel" runat="server">0</asp:Label>
					<asp:HyperLink ID="OrderedOrderStatusHyperLink" runat="server" Text="Ordered" />
				</td>
				<td style="background-color: DarkKhaki">
					<asp:Label ID="PaymentRefundedOrderStatusTotalLabel" runat="server">0</asp:Label>
					<asp:HyperLink ID="PaymentRefundedOrderStatusHyperLink" runat="server" Text="Refunded" />
				</td>
				<td style="background-color: SteelBlue">
					<asp:Label ID="ShippingDispatchingOrderStatusTotalLabel" runat="server">0</asp:Label>
					<asp:HyperLink ID="ShippingDispatchingOrderStatusHyperLink" runat="server" Text="Dispatching" />
				</td>
				<td>
					&nbsp;
				</td>
			</tr>
			<tr>
				<td style="background-color: SkyBlue">
					<asp:Label ID="ProcessingOrderStatusTotalLabel" runat="server">0</asp:Label>
					<asp:HyperLink ID="ProcessingOrderStatusHyperLink" runat="server" Text="Processing" />
				</td>
				<td style="background-color: Khaki">
					<asp:Label ID="PaymentCancelledOrderStatusTotalLabel" runat="server">0</asp:Label>
					<asp:HyperLink ID="PaymentCancelledOrderStatusHyperLink" runat="server" Text="Cancelled" />
				</td>
				<td style="background-color: YellowGreen">
					<asp:Label ID="ShippingShippedOrderStatusTotalLabel" runat="server">0</asp:Label>
					<asp:HyperLink ID="ShippingShippedOrderStatusHyperLink" runat="server" Text="Shipped" />
				</td>
				<td>
					&nbsp;
				</td>
			</tr>
			<tr>
				<td style="background-color: YellowGreen">
					<asp:Label ID="CompletedOrderStatusTotalLabel" runat="server">0</asp:Label>
					<asp:HyperLink ID="CompletedOrderStatusHyperLink" runat="server" Text="Completed" />
				</td>
				<td>
					&nbsp;
				</td>
				<td style="background-color: Red">
					<asp:Label ID="ShippingUndeliverableOrderStatusTotalLabel" runat="server">0</asp:Label>
					<asp:HyperLink ID="ShippingUndeliverableOrderStatusHyperLink" runat="server" Text="Undeliverable" />
				</td>
				<td>
					&nbsp;
				</td>
			</tr>
			<tr>
				<td style="background-color: Red">
					<asp:Label ID="DeclinedOrderStatusTotalLabel" runat="server">0</asp:Label>
					<asp:HyperLink ID="DeclinedOrderStatusHyperLink" runat="server" Text="Declined" />
				</td>
				<td>
					&nbsp;
				</td>
				<td>
					&nbsp;
				</td>
				<td>
					&nbsp;
				</td>
			</tr>
			<tr>
				<td style="background-color: Khaki">
					<asp:Label ID="CancelledOrderStatusTotalLabel" runat="server">0</asp:Label>
					<asp:HyperLink ID="CancelledOrderStatusHyperLink" runat="server" Text="Cancelled" />	
				</td>
				<td>
					&nbsp;</td>
				<td>
					&nbsp;</td>
				<td>
					&nbsp;</td>
			</tr>
		</table>
	</div>
	<div class="rvdsfDashboardSalesSnapshotContainer">

		<script type="text/javascript">
			jQuery(function($)
			{
				$('#<%= SalesSnapshotTabPanel.ClientID %>').dnnTabs();
			});
		</script>

		<h3 class="dnnFormSectionHead">
			Sales snapshot</h3>
		<asp:Panel ID="SalesSnapshotTabPanel" runat="server" CssClass="dnnForm">
			<ul class="dnnAdminTabNav dnnClear">
				<li><a href="#<%= DaySalesSnapshotDetailsViewPanel.ClientID %>">
					<asp:Label ID="DaySalesSnapshotDetailsViewTabLabel" runat="server" Text="Day" /></a></li>
				<li><a href="#<%= WeekSalesSnapshotDetailsViewPanel.ClientID %>">
					<asp:Label ID="WeekSalesSnapshotDetailsViewTabLabel" runat="server" Text="Week" /></a></li>
				<li><a href="#<%= MonthSalesSnapshotDetailsViewPanel.ClientID %>">
					<asp:Label ID="MonthSalesSnapshotDetailsViewTabLabel" runat="server" Text="Month" /></a></li>
				<li><a href="#<%= QuarterSalesSnapshotDetailsViewPanel.ClientID %>">
					<asp:Label ID="QuarterSalesSnapshotDetailsViewTabLabel" runat="server" Text="Quarter" /></a></li>
				<li><a href="#<%= YearSalesSnapshotDetailsViewPanel.ClientID %>">
					<asp:Label ID="YearSalesSnapshotDetailsViewTabLabel" runat="server" Text="Year" /></a></li>
			</ul>
			<asp:Panel ID="DaySalesSnapshotDetailsViewPanel" runat="server" CssClass="dnnClear">
				<fieldset>
					<table class="dnnGrid rvdsfDashboardSalesSnapshotGrid">
						<tr class="dnnGridHeader">
							<th>
								&nbsp;
							</th>
							<th>
								<asp:Label ID="YesterdayLabel" runat="server" Text="Yesterday"></asp:Label>
							</th>
							<th>
								<asp:Label ID="TodayLabel" runat="server" Text="Today"></asp:Label>
							</th>
							<th>
								<asp:Label ID="PercentChangeTodayLabel" runat="server" Text="% Change"></asp:Label>
							</th>
						</tr>
						<tr class="dnnGridItem">
							<td>
								<dnn1:LabelControl ID="RevenueByDayLabelControl" runat="server" Text="Revenue" />
							</td>
							<td>
								<asp:Label ID="RevenueYesterdayLabel" runat="server"></asp:Label>
							</td>
							<td>
								<asp:Label ID="RevenueTodayLabel" runat="server"></asp:Label>
							</td>
							<td>
								<asp:Label ID="PercentChangeRevenueTodayLabel" runat="server"></asp:Label>
							</td>
						</tr>
						<tr class="dnnGridAltItem">
							<td>
								<dnn1:LabelControl ID="NumberOfOrdersByDayLabelControl" runat="server" Text="Orders" />
							</td>
							<td>
								<asp:Label ID="NumberOfOrdersYesterdayLabel" runat="server">0</asp:Label>
							</td>
							<td>
								<asp:Label ID="NumberOfOrdersTodayLabel" runat="server">0</asp:Label>
							</td>
							<td>
								<asp:Label ID="PercentChangeNumberOfOrdersTodayLabel" runat="server"></asp:Label>
							</td>
						</tr>
						<tr class="dnnGridItem">
							<td>
								<dnn1:LabelControl ID="AvgOrderValueByDayLabelControl" runat="server" Text="Avg. amount" />
							</td>
							<td>
								<asp:Label ID="AvgOrderValueYesterdayLabel" runat="server"></asp:Label>
							</td>
							<td>
								<asp:Label ID="AvgOrderValueTodayLabel" runat="server"></asp:Label>
							</td>
							<td>
								<asp:Label ID="PercentChangeAvgOrderValueTodayLabel" runat="server"></asp:Label>
							</td>
						</tr>
					</table>
				</fieldset>
			</asp:Panel>
			<asp:Panel ID="WeekSalesSnapshotDetailsViewPanel" runat="server" CssClass="dnnClear">
				<fieldset>
					<table class="dnnGrid rvdsfDashboardSalesSnapshotGrid">
						<tr class="dnnGridHeader">
							<th>
								&nbsp;
							</th>
							<th>
								<asp:Label ID="LastWeekLabel" runat="server" Text="Last week"></asp:Label>
							</th>
							<th>
								<asp:Label ID="ThisWeekLabel" runat="server" Text="This week"></asp:Label>
							</th>
							<th>
								<asp:Label ID="PercentChangeThisWeekLabel" runat="server" Text="% Change"></asp:Label>
							</th>
						</tr>
						<tr class="dnnGridItem">
							<td>
								<dnn1:LabelControl ID="RevenueByWeekLabelControl" runat="server" Text="Revenue" />
							</td>
							<td>
								<asp:Label ID="RevenueLastWeekLabel" runat="server"></asp:Label>
							</td>
							<td>
								<asp:Label ID="RevenueThisWeekLabel" runat="server"></asp:Label>
							</td>
							<td>
								<asp:Label ID="PercentChangeRevenueThisWeekLabel" runat="server"></asp:Label>
							</td>
						</tr>
						<tr class="dnnGridAltItem">
							<td>
								<dnn1:LabelControl ID="NumberOfOrdersByWeekLabelControl" runat="server" Text="Orders" />
							</td>
							<td>
								<asp:Label ID="NumberOfOrdersLastWeekLabel" runat="server">0</asp:Label>
							</td>
							<td>
								<asp:Label ID="NumberOfOrdersThisWeekLabel" runat="server">0</asp:Label>
							</td>
							<td>
								<asp:Label ID="PercentChangeNumberOfOrdersThisWeekLabel" runat="server"></asp:Label>
							</td>
						</tr>
						<tr class="dnnGridItem">
							<td>
								<dnn1:LabelControl ID="AvgOrderValueByWeekLabelControl" runat="server" Text="Avg. amount" />
							</td>
							<td>
								<asp:Label ID="AvgOrderValueLastWeekLabel" runat="server"></asp:Label>
							</td>
							<td>
								<asp:Label ID="AvgOrderValueThisWeekLabel" runat="server"></asp:Label>
							</td>
							<td>
								<asp:Label ID="PercentChangeAvgOrderValueThisWeekLabel" runat="server"></asp:Label>
							</td>
						</tr>
					</table>
				</fieldset>
			</asp:Panel>
			<asp:Panel ID="MonthSalesSnapshotDetailsViewPanel" runat="server" CssClass="dnnClear">
				<fieldset>
					<table class="dnnGrid rvdsfDashboardSalesSnapshotGrid">
						<tr class="dnnGridHeader">
							<th>
								&nbsp;
							</th>
							<th>
								<asp:Label ID="LastMonthLabel" runat="server" Text="Last month"></asp:Label>
							</th>
							<th>
								<asp:Label ID="ThisMonthLabel" runat="server" Text="This month"></asp:Label>
							</th>
							<th>
								<asp:Label ID="PercentChangeThisMonthLabel" runat="server" Text="% Change"></asp:Label>
							</th>
						</tr>
						<tr class="dnnGridItem">
							<td>
								<dnn1:LabelControl ID="RevenueByMonthLabelControl" runat="server" Text="Revenue" />
							</td>
							<td>
								<asp:Label ID="RevenueLastMonthLabel" runat="server"></asp:Label>
							</td>
							<td>
								<asp:Label ID="RevenueThisMonthLabel" runat="server"></asp:Label>
							</td>
							<td>
								<asp:Label ID="PercentChangeRevenueThisMonthLabel" runat="server"></asp:Label>
							</td>
						</tr>
						<tr class="dnnGridAltItem">
							<td>
								<dnn1:LabelControl ID="NumberOfOrdersByMonthLabelControl" runat="server" Text="Orders" />
							</td>
							<td>
								<asp:Label ID="NumberOfOrdersLastMonthLabel" runat="server">0</asp:Label>
							</td>
							<td>
								<asp:Label ID="NumberOfOrdersThisMonthLabel" runat="server">0</asp:Label>
							</td>
							<td>
								<asp:Label ID="PercentChangeNumberOfOrdersThisMonthLabel" runat="server"></asp:Label>
							</td>
						</tr>
						<tr class="dnnGridItem">
							<td>
								<dnn1:LabelControl ID="AvgOrderValueByMonthLabelControl" runat="server" Text="Avg. amount" />
							</td>
							<td>
								<asp:Label ID="AvgOrderValueLastMonthLabel" runat="server"></asp:Label>
							</td>
							<td>
								<asp:Label ID="AvgOrderValueThisMonthLabel" runat="server"></asp:Label>
							</td>
							<td>
								<asp:Label ID="PercentChangeAvgOrderValueThisMonthLabel" runat="server"></asp:Label>
							</td>
						</tr>
					</table>
				</fieldset>
			</asp:Panel>
			<asp:Panel ID="QuarterSalesSnapshotDetailsViewPanel" runat="server" CssClass="dnnClear">
				<fieldset>
					<table class="dnnGrid rvdsfDashboardSalesSnapshotGrid">
						<tr class="dnnGridHeader">
							<th>
								&nbsp;
							</th>
							<th>
								<asp:Label ID="LastQuarterLabel" runat="server" Text="Last quarter"></asp:Label>
							</th>
							<th>
								<asp:Label ID="ThisQuarterLabel" runat="server" Text="This quarter"></asp:Label>
							</th>
							<th>
								<asp:Label ID="PercentChangeThisQuarterLabel" runat="server" Text="% Change"></asp:Label>
							</th>
						</tr>
						<tr class="dnnGridItem">
							<td>
								<dnn1:LabelControl ID="RevenueByQuarterLabelControl" runat="server" Text="Revenue" />
							</td>
							<td>
								<asp:Label ID="RevenueLastQuarterLabel" runat="server"></asp:Label>
							</td>
							<td>
								<asp:Label ID="RevenueThisQuarterLabel" runat="server"></asp:Label>
							</td>
							<td>
								<asp:Label ID="PercentChangeRevenueThisQuarterLabel" runat="server"></asp:Label>
							</td>
						</tr>
						<tr class="dnnGridAltItem">
							<td>
								<dnn1:LabelControl ID="NumberOfOrdersByQuarterLabelControl" runat="server" Text="Orders" />
							</td>
							<td>
								<asp:Label ID="NumberOfOrdersLastQuarterLabel" runat="server">0</asp:Label>
							</td>
							<td>
								<asp:Label ID="NumberOfOrdersThisQuarterLabel" runat="server">0</asp:Label>
							</td>
							<td>
								<asp:Label ID="PercentChangeNumberOfOrdersThisQuarterLabel" runat="server"></asp:Label>
							</td>
						</tr>
						<tr class="dnnGridItem">
							<td>
								<dnn1:LabelControl ID="AvgOrderValueByQuarterLabelControl" runat="server" Text="Avg. amount" />
							</td>
							<td>
								<asp:Label ID="AvgOrderValueLastQuarterLabel" runat="server"></asp:Label>
							</td>
							<td>
								<asp:Label ID="AvgOrderValueThisQuarterLabel" runat="server"></asp:Label>
							</td>
							<td>
								<asp:Label ID="PercentChangeAvgOrderValueThisQuarterLabel" runat="server"></asp:Label>
							</td>
						</tr>
					</table>
				</fieldset>
			</asp:Panel>
			<asp:Panel ID="YearSalesSnapshotDetailsViewPanel" runat="server" CssClass="dnnClear">
				<fieldset>
					<table class="dnnGrid rvdsfDashboardSalesSnapshotGrid">
						<tr class="dnnGridHeader">
							<th>
								&nbsp;
							</th>
							<th>
								<asp:Label ID="LastYearLabel" runat="server" Text="Last year"></asp:Label>
							</th>
							<th>
								<asp:Label ID="ThisYearLabel" runat="server" Text="This year"></asp:Label>
							</th>
							<th>
								<asp:Label ID="PercentChangeThisYearLabel" runat="server" Text="% Change"></asp:Label>
							</th>
						</tr>
						<tr class="dnnGridItem">
							<td>
								<dnn1:LabelControl ID="RevenueByYearLabelControl" runat="server" Text="Revenue" />
							</td>
							<td>
								<asp:Label ID="RevenueLastYearLabel" runat="server"></asp:Label>
							</td>
							<td>
								<asp:Label ID="RevenueThisYearLabel" runat="server"></asp:Label>
							</td>
							<td>
								<asp:Label ID="PercentChangeRevenueThisYearLabel" runat="server"></asp:Label>
							</td>
						</tr>
						<tr class="dnnGridAltItem">
							<td>
								<dnn1:LabelControl ID="NumberOfOrdersByYearLabelControl" runat="server" Text="Orders" />
							</td>
							<td>
								<asp:Label ID="NumberOfOrdersLastYearLabel" runat="server">0</asp:Label>
							</td>
							<td>
								<asp:Label ID="NumberOfOrdersThisYearLabel" runat="server">0</asp:Label>
							</td>
							<td>
								<asp:Label ID="PercentChangeNumberOfOrdersThisYearLabel" runat="server"></asp:Label>
							</td>
						</tr>
						<tr class="dnnGridItem">
							<td>
								<dnn1:LabelControl ID="AvgOrderValueByYearLabelControl" runat="server" Text="Avg. amount" />
							</td>
							<td>
								<asp:Label ID="AvgOrderValueLastYearLabel" runat="server"></asp:Label>
							</td>
							<td>
								<asp:Label ID="AvgOrderValueThisYearLabel" runat="server"></asp:Label>
							</td>
							<td>
								<asp:Label ID="PercentChangeAvgOrderValueThisYearLabel" runat="server"></asp:Label>
							</td>
						</tr>
					</table>
				</fieldset>
			</asp:Panel>
		</asp:Panel>
	</div>
	<div class="rvdsfDashboardRecentSalesActivityContainer">
		<h3 class="dnnFormSectionHead">
			Recent sales activity</h3>
		<div class="rvdsfDashboardRecentSalesActivityChart" id="chart_div">
		</div>
	</div>
</div>
<div class="rvdsfDashboardRightAsideContainer">
	<div class="rvdsfManageResourcesContainer">
		<asp:HyperLink ID="AddFeaturesHyperLink" runat="server" Text="+ Enable more features" CssClass="dnnTertiaryAction"/>
	</div>
	<div class="rvdsfDashboardNewsContainer">
		<h3 id="NewsHeaderSection" class="dnnFormSectionHead">News</h3>
		<asp:BulletedList ID="NewsBulletedList" runat="server" DisplayMode="HyperLink" Target="_blank"></asp:BulletedList>
	</div>
	<div class="rvdsfDashboardResourcesContainer">
		<h3 id="ResourcesHeaderSection" class="dnnFormSectionHead">Resources</h3>
		<ul>
			<li><a href="http://www.revindex.com/Support/Forum" target="_blank">Forum</a></li>
			<li><a href="http://www.revindex.com/Resources/Knowledge-Base/Revindex-Storefront" target="_blank">Knowledge base</a></li>
			<li><a href="http://www.revindex.com/Product-Detail/revindex-priority-support" target="_blank">Priority support</a></li>
			<li><a href="http://www.revindex.com/Resources/Knowledge-Base/Revindex-Storefront/release-notes" target="_blank">Release notes</a></li>
			<li><a href="http://www.revindex.com/My-Account/My-Downloads" target="_blank">Downloads</a></li>
		</ul>
	</div>
	<div class="rvdsfDashboardLearnContainer">
		<h3 id="LearnHeaderSection" class="dnnFormSectionHead">Learn</h3>
		<ul>
			<li><a href="http://www.revindex.com/Resources/Knowledge-Base/Revindex-Storefront/how-to-create-a-simple-product" target="_blank">How to create a simple product</a></li>
			<li><a href="http://www.revindex.com/Resources/Knowledge-Base/Revindex-Storefront/how-to-create-a-recurring-product" target="_blank">How to create a recurring product</a></li>
			<li><a href="http://www.revindex.com/Resources/Knowledge-Base/Revindex-Storefront/how-to-create-a-configurable-price-product" target="_blank">How to create a configurable product</a></li>
			<li><a href="http://www.revindex.com/Resources/Knowledge-Base/Revindex-Storefront/how-to-create-downloadable-products" target="_blank">How to create downloadable products</a></li>
			<li><a href="http://www.revindex.com/Resources/Knowledge-Base/Revindex-Storefront/how-to-offer-free-products-without-payment" target="_blank">How to offer free products</a></li>
			<li><a href="http://www.revindex.com/Resources/Knowledge-Base/Revindex-Storefront/variants" target="_blank">What are product variants?</a></li>
			<li><a href="http://www.revindex.com/Resources/Knowledge-Base/Revindex-Storefront/how-to-accept-offline-orders" target="_blank">How to accept offline orders</a></li>
			<li><a href="http://www.revindex.com/Resources/Knowledge-Base/Revindex-Storefront/how-to-hide-unwanted-country" target="_blank">How to hide unwanted countries</a></li>
			<li><a href="http://www.revindex.com/Resources/Knowledge-Base/Revindex-Storefront/how-to-force-order-and-payment-status" target="_blank">How to force order and payment status</a></li>
			<li><a href="http://www.revindex.com/Resources/Knowledge-Base/Revindex-Storefront/adding-module-controls" target="_blank">How to add modules</a></li>
			<li><a href="http://www.revindex.com/Resources/Knowledge-Base/Revindex-Storefront/configuration-general" target="_blank">How to add more features</a></li>
			<li><a href="http://www.revindex.com/Resources/Knowledge-Base/Revindex-Storefront/how-to-improve-performance" target="_blank">How to improve performance</a></li>
			<li><a href="http://www.revindex.com/Resources/Knowledge-Base/Revindex-Storefront" target="_blank">Learn more</a></li>
		</ul>
	</div>
	<div class="rvdsfDashboardEnhancementsContainer">
		<h3 id="EnhancementsHeaderSection" class="dnnFormSectionHead">Enhancements</h3>
		<ul>
			<li><a href="http://www.revindex.com/Product-Detail/revindex-generic-skin" target="_blank">Generic Skin</a></li>
			<li><a href="http://www.revindex.com/Product-Detail/revindex-impersonator" target="_blank">Impersonator</a></li>
			<li><a href="http://www.revindex.com/Product-Detail/revindex-omni-skin" target="_blank">Omni Skin</a></li>
			<li><a href="http://www.revindex.com/Product-Detail/revindex-optimizer" target="_blank">Optimizer (Free)</a></li>
			<li><a href="http://www.revindex.com/Product-Detail/rapidssl-certificate" target="_blank">SSL Certificate</a></li>
			<li><a href="http://www.revindex.com/Product-Detail/revindex-task-scheduler" target="_blank">Task Scheduler</a></li>
			<li><a href="http://www.revindex.com/Product-Detail/revindex-wiki" target="_blank">Wiki</a></li>
		</ul>
	</div>
</div>
<div class="rvdsfDashboardVersionContainer">
	<asp:Literal ID="VersionLiteral" runat="server"></asp:Literal>
</div>

