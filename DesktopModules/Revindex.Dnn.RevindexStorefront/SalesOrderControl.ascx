<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="SalesOrderControl.ascx.cs" Inherits="Revindex.Dnn.RevindexStorefront.SalesOrderControl" %>
<%@ Register Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Src="~/Controls/labelcontrol.ascx" TagName="LabelControl" TagPrefix="dnn1" %>
<%@ Register Src="~/Controls/texteditor.ascx" TagName="TextEditor" TagPrefix="dnn1" %>
<%@ Register Assembly="DotNetNuke.Web.Deprecated" Namespace="DotNetNuke.Web.UI.WebControls" TagPrefix="dnn2" %>
<%@ Register Assembly="Revindex.Web.UI.WebControls" Namespace="Revindex.Web.UI.WebControls" TagPrefix="rvd1" %>
<%@ Register Src="ShippingPackageControl.ascx" TagName="ShippingPackageControl" TagPrefix="uc1" %>
<%@ Register Src="SalesOrderDetailControl.ascx" TagName="SalesOrderDetailControl" TagPrefix="uc1" %>
<%@ Register Src="SalesPaymentControl.ascx" TagName="SalesPaymentControl" TagPrefix="uc1" %>
<%@ Register Src="UserPaymentDropDownListControl.ascx" TagName="UserPaymentDropDownListControl" TagPrefix="uc1" %>
<%@ Register Src="UserAddressDropDownListControl.ascx" TagName="UserAddressDropDownListControl" TagPrefix="uc1" %>
<%@ Register Src="WebUserControls/DynamicFormResultEditorControl.ascx" TagName="DynamicFormResultEditorControl" TagPrefix="uc1" %>
<%@ Register Src="WebUserControls/BaseEditorControl.ascx" TagName="BaseEditorControl" TagPrefix="uc1" %>
<%@ Register Src="WebUserControls/Common/Dnn/BackControl.ascx" TagName="BackControl" TagPrefix="uc1" %>
<%@ Register Src="WebUserControls/Common/Dnn/BreadcrumbControl.ascx" TagName="BreadcrumbControl" TagPrefix="uc1" %>
<uc1:BaseEditorControl ID="BaseEditorControl1" runat="server" />
<asp:PlaceHolder runat="server">

	<script type="text/javascript">
		jQuery(document).ready(function ()
		{
			jQuery('#<%= SearchPanel.ClientID %>').dnnPanels();
			jQuery('#SalesOrderDetailsViewTabPanel').dnnTabs();
			jQuery("#NotesSalesOrderDetailsViewPanel").dnnPanels();
		});
		Sys.WebForms.PageRequestManager.getInstance().add_endRequest(function ()
		{
			jQuery('#<%= SearchPanel.ClientID %>').dnnPanels();
			jQuery('#SalesOrderDetailsViewTabPanel').dnnTabs();
			jQuery("#NotesSalesOrderDetailsViewPanel").dnnPanels();
		});
	</script>

</asp:PlaceHolder>
<div>
	<asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
		<ContentTemplate>
			<asp:PlaceHolder ID="MessagePlaceHolder" runat="server" />
			<asp:MultiView ID="ContentMultiView" runat="server">
				<asp:View ID="ListView" runat="server">
					<h2>Sales orders</h2>
					<asp:Panel ID="SearchPanel" runat="server" DefaultButton="SearchLinkButton" CssClass="dnnForm rvdsfSearchContainer">
						<h2 id="SearchFormSectionHead" class="dnnFormSectionHead"><a href="#" class="dnnSectionExpanded">Search</a></h2>
						<fieldset class="rvdSplit2">
							<div class="dnnFormItem">
								<dnn1:LabelControl ID="SalesOrderSearchOrderStartDateLabelControl" runat="server" Text="Start date:" />
								<dnn2:DnnDatePicker ID="SalesOrderSearchStartDateDnnDatePicker" runat="server" ShowPopupOnFocus="True" DatePopupButton-Visible="False" DateInput-DateFormat="yyyy-MM-dd" DateInput-EmptyMessage="YYYY-MM-DD">
								</dnn2:DnnDatePicker>
							</div>
							<div class="dnnFormItem">
								<dnn1:LabelControl ID="SalesOrderSearchOrderStopDateLabelControl" runat="server" Text="Stop date:" />
								<dnn2:DnnDatePicker ID="SalesOrderSearchStopDateDnnDatePicker" runat="server" ShowPopupOnFocus="True" DatePopupButton-Visible="False" DateInput-DateFormat="yyyy-MM-dd" DateInput-EmptyMessage="YYYY-MM-DD">
								</dnn2:DnnDatePicker>
							</div>
							<div class="dnnFormItem">
								<dnn1:LabelControl ID="SalesOrderSearchSalesOrderIDLabelControl" runat="server" Text="Order number:" />
								<asp:TextBox ID="SalesOrderSearchSalesOrderIDTextBox" runat="server"></asp:TextBox>
							</div>
							<div class="dnnFormItem">
								<dnn1:LabelControl ID="SalesOrderSearchUsernameLabelControl" runat="server" Text="Username:" />
								<asp:TextBox ID="SalesOrderSearchUsernameTextBox" runat="server"></asp:TextBox>
							</div>
							<div class="dnnFormItem">
								<dnn1:LabelControl ID="SalesOrderSearchNameLabelControl" runat="server" Text="Name:" />
								<asp:TextBox ID="SalesOrderSearchNameTextBox" runat="server"></asp:TextBox>
							</div>
							<div class="dnnFormItem">
								<dnn1:LabelControl ID="SalesOrderSearchEmailLabelControl" runat="server" Text="Email:" />
								<asp:TextBox ID="SalesOrderSearchEmailTextBox" runat="server"></asp:TextBox>
							</div>
							<div class="dnnFormItem">
								<dnn1:LabelControl ID="SalesOrderSearchStatusLabelControl" runat="server" Text="Order status:" />
								<asp:DropDownList ID="SalesOrderSearchStatusDropDownList" runat="server">
									<asp:ListItem Value="-1">Any except Incomplete</asp:ListItem>
									<asp:ListItem Value="0">Any</asp:ListItem>
									<asp:ListItem Value="7" style="background-color: Silver">Incomplete</asp:ListItem>
									<asp:ListItem Value="1" style="background-color: HotPink">Pending</asp:ListItem>
									<asp:ListItem Value="9" style="background-color: DeepPink">Quoted</asp:ListItem>
									<asp:ListItem Value="8" style="background-color: Yellow">Preordered</asp:ListItem>
									<asp:ListItem Value="2" style="background-color: Gold">Ordered</asp:ListItem>
									<asp:ListItem Value="3" style="background-color: SkyBlue">Processing</asp:ListItem>
									<asp:ListItem Value="4" style="background-color: YellowGreen">Completed</asp:ListItem>
									<asp:ListItem Value="5" style="background-color: Khaki">Cancelled</asp:ListItem>
									<asp:ListItem Value="6" style="background-color: Red">Declined</asp:ListItem>
								</asp:DropDownList>
							</div>
							<div class="dnnFormItem">
								<dnn1:LabelControl ID="SalesOrderSearchSalesPaymentStatusLabelControl" runat="server" Text="Payment status:" />
								<asp:DropDownList ID="SalesOrderSearchSalesPaymentStatusDropDownList" runat="server">
									<asp:ListItem Value="0">Any</asp:ListItem>
									<asp:ListItem Value="6" style="background-color: Silver">Incomplete</asp:ListItem>
									<asp:ListItem Value="1" style="background-color: HotPink">Pending</asp:ListItem>
									<asp:ListItem Value="2" style="background-color: YellowGreen">Paid</asp:ListItem>
									<asp:ListItem Value="3" style="background-color: Khaki">Cancelled</asp:ListItem>
									<asp:ListItem Value="4" style="background-color: DarkKhaki">Refunded</asp:ListItem>
									<asp:ListItem Value="5" style="background-color: Red">Declined</asp:ListItem>
								</asp:DropDownList>
							</div>
							<div class="dnnFormItem">
								<dnn1:LabelControl ID="SalesOrderSearchShippingStatusLabelControl" runat="server" Text="Shipping status:" />
								<asp:DropDownList ID="SalesOrderSearchShippingStatusDropDownList" runat="server">
									<asp:ListItem Value="0">Any</asp:ListItem>
									<asp:ListItem Value="1" style="background-color: LightGreen">Not Required</asp:ListItem>
									<asp:ListItem Value="2" style="background-color: Gold">Not Shipped</asp:ListItem>
									<asp:ListItem Value="5" style="background-color: LightBlue">Packing</asp:ListItem>
									<asp:ListItem Value="6" style="background-color: SkyBlue">Packed</asp:ListItem>
									<asp:ListItem Value="7" style="background-color: SteelBlue">Dispatching</asp:ListItem>
									<asp:ListItem Value="3" style="background-color: YellowGreen">Shipped</asp:ListItem>
									<asp:ListItem Value="4" style="background-color: Red">Undeliverable</asp:ListItem>
								</asp:DropDownList>
							</div>
							<asp:Panel ID="SalesOrderSearchSellerPanel" runat="server" CssClass="dnnFormItem">
								<dnn1:LabelControl ID="SalesOrderSearchSellerLabelControl" runat="server" Text="Seller:" />
								<dnn2:DnnComboBox ID="SalesOrderSearchSellerDnnComboBox" runat="server" AllowCustomText="True" EnableLoadOnDemand="True" OnItemsRequested="SalesOrderSearchSellerDnnComboBox_ItemsRequested" AutoPostBack="True" CausesValidation="False" MaxHeight="200px"></dnn2:DnnComboBox>
							</asp:Panel>
							<div class="rvdActions">
								<asp:LinkButton ID="SearchLinkButton" runat="server" Text="Search" OnClick="SearchLinkButton_Click" CausesValidation="false" CssClass="dnnPrimaryAction rvdSearchAction" />
								<asp:LinkButton ID="ResetLinkButton" runat="server" Text="Reset" OnClick="ResetLinkButton_Click" CausesValidation="false" CssClass="dnnSecondaryAction rvdResetAction" />
							</div>
						</fieldset>
					</asp:Panel>
					<div class="dnnForm rvdsfListContainer">
						<asp:GridView ID="SalesOrderGridView" runat="server" AllowSorting="True" AutoGenerateColumns="False" CssClass="dnnGrid rvdsfSalesOrderSalesOrderGrid" GridLines="None" AllowPaging="True" DataKeyNames="SalesOrderID" OnRowDataBound="SalesOrderGridView_RowDataBound" OnDataBound="SalesOrderGridView_DataBound">
							<AlternatingRowStyle CssClass="dnnGridAltItem" />
							<HeaderStyle CssClass="dnnGridHeader" />
							<RowStyle CssClass="dnnGridItem" />
							<SelectedRowStyle CssClass="dnnGridSelectedItem" />
							<FooterStyle CssClass="dnnGridFooter" />
							<PagerStyle CssClass="dnnGridPager" />
							<Columns>
								<asp:TemplateField>
									<HeaderTemplate>
										<input onclick="if ($(this).is(':checked')) { $('.rvdsfSalesOrderSalesOrderGrid :checkbox').each(function () { this.checked = true; }) } else { $('.rvdsfSalesOrderSalesOrderGrid :checkbox').each(function () { this.checked = false; }) }" runat="server" type="checkbox" />
									</HeaderTemplate>
									<ItemTemplate>
										<asp:CheckBox ID="SelectCheckBox" runat="server" />
									</ItemTemplate>
								</asp:TemplateField>
								<asp:TemplateField>
									<ItemTemplate>
										<asp:HyperLink ID="SelectHyperLink" runat="server" CssClass="rvdEditGridAction" />
									</ItemTemplate>
								</asp:TemplateField>
								<asp:BoundField DataField="SalesOrderNumber" HeaderText="Number" SortExpression="SalesOrderNumber" />
								<asp:BoundField DataField="OrderDate" HeaderText="Order date" SortExpression="OrderDate"  />
								<asp:BoundField DataField="Origin" HeaderText="Origin" SortExpression="Origin" />
								<asp:BoundField DataField="Status" HeaderText="Order" SortExpression="Status" />
								<asp:BoundField DataField="SalesPaymentStatus" HeaderText="Payment" SortExpression="SalesPaymentStatus" />
								<asp:BoundField DataField="ShippingStatus" HeaderText="Shipping" SortExpression="ShippingStatus" />
								<asp:BoundField DataField="FraudScore" HeaderText="Fraud" SortExpression="FraudScore" />
								<asp:BoundField DataField="TotalAmount" HeaderText="Total" SortExpression="TotalAmount" />
							</Columns>
							<PagerTemplate>
								<table style="width: 100%">
									<tr>
										<td>
											<table>
												<tr>
													<td>
														<asp:LinkButton ID="PagePreviousLinkButton" runat="server" CommandName="Page" CommandArgument="Prev" Text="..." /></td>
													<td>
														<asp:LinkButton ID="Page1LinkButton" runat="server" CommandName="Page" CommandArgument="1" Text="1" /></td>
													<td>
														<asp:LinkButton ID="Page2LinkButton" runat="server" CommandName="Page" CommandArgument="1" Text="2" /></td>
													<td>
														<asp:LinkButton ID="Page3LinkButton" runat="server" CommandName="Page" CommandArgument="1" Text="3" /></td>
													<td>
														<asp:LinkButton ID="Page4LinkButton" runat="server" CommandName="Page" CommandArgument="1" Text="4" /></td>
													<td>
														<asp:LinkButton ID="Page5LinkButton" runat="server" CommandName="Page" CommandArgument="1" Text="5" /></td>
													<td>
														<asp:LinkButton ID="Page6LinkButton" runat="server" CommandName="Page" CommandArgument="1" Text="6" /></td>
													<td>
														<asp:LinkButton ID="Page7LinkButton" runat="server" CommandName="Page" CommandArgument="1" Text="7" /></td>
													<td>
														<asp:LinkButton ID="Page8LinkButton" runat="server" CommandName="Page" CommandArgument="1" Text="8" /></td>
													<td>
														<asp:LinkButton ID="Page9LinkButton" runat="server" CommandName="Page" CommandArgument="1" Text="9" /></td>
													<td>
														<asp:LinkButton ID="Page10LinkButton" runat="server" CommandName="Page" CommandArgument="1" Text="10" /></td>
													<td>
														<asp:LinkButton ID="PageNextLinkButton" runat="server" CommandName="Page" CommandArgument="Next" Text="..." /></td>
												</tr>
											</table>
										</td>
										<td style="text-align: right">Page items:
											<asp:DropDownList ID="PageViewSizeDropDownList" runat="server" AutoPostBack="True" OnSelectedIndexChanged="PageViewSizeDropDownList_SelectedIndexChanged">
												<asp:ListItem Value="10">10</asp:ListItem>
												<asp:ListItem Value="20">20</asp:ListItem>
												<asp:ListItem Value="50">50</asp:ListItem>
												<asp:ListItem Value="100">100</asp:ListItem>
											</asp:DropDownList>
										</td>
									</tr>
								</table>
							</PagerTemplate>
						</asp:GridView>
						<asp:ObjectDataSource ID="SalesOrderObjectDataSource" runat="server" SelectMethod="GetAll" TypeName="Revindex.Business.Revindex.Revindex.Storefront.SalesOrderController" EnablePaging="True" SelectCountMethod="GetCount" SortParameterName="sortExpression">
							<SelectParameters>
								<asp:Parameter Name="sortExpression" Type="String" />
								<asp:Parameter Name="maximumRows" Type="Int32" />
								<asp:Parameter Name="startRowIndex" Type="Int32" />
								<rvd1:UserControlParameter Name="portalID" PropertyName="PortalId" Type="Int32" />
								<asp:ControlParameter ControlID="SalesOrderSearchStartDateDnnDatePicker" Name="startDate" PropertyName="SelectedDate" Type="DateTime" />
								<asp:ControlParameter ControlID="SalesOrderSearchStopDateDnnDatePicker" Name="stopDate" PropertyName="SelectedDate" Type="DateTime" />
								<asp:ControlParameter ControlID="SalesOrderSearchSalesOrderIDTextBox" Name="salesOrderNumber" PropertyName="Text" Type="String" />
								<asp:ControlParameter ControlID="SalesOrderSearchUsernameTextBox" Name="username" PropertyName="Text" Type="String" />
								<asp:ControlParameter ControlID="SalesOrderSearchNameTextBox" Name="name" PropertyName="Text" Type="String" />
								<asp:ControlParameter ControlID="SalesOrderSearchEmailTextBox" Name="email" PropertyName="Text" Type="String" />
								<asp:ControlParameter ControlID="SalesOrderSearchStatusDropDownList" Name="status" PropertyName="SelectedValue" />
								<asp:ControlParameter ControlID="SalesOrderSearchShippingStatusDropDownList" Name="shippingStatus" PropertyName="SelectedValue" />
								<asp:ControlParameter ControlID="SalesOrderSearchSalesPaymentStatusDropDownList" Name="salesPaymentStatus" PropertyName="SelectedValue" />
								<asp:ControlParameter ControlID="SalesOrderSearchSellerDnnComboBox" Name="sellerID" PropertyName="SelectedValue" Type="Int32" />
							</SelectParameters>
						</asp:ObjectDataSource>
						<ul class="dnnActions dnnClear">
							<li>
								<asp:HyperLink ID="AddHyperLink" runat="server" Text="Add new" CssClass="dnnPrimaryAction rvdAddNewAction" />
							</li>
							<li>
								<asp:HyperLink ID="ExportHyperLink" runat="server" Text="Export" CssClass="dnnSecondaryAction rvdExportAction" />
							</li>
							<li>
								<asp:LinkButton ID="EditSelectedLinkButton" runat="server" Text="Edit selected" CssClass="dnnSecondaryAction rvdBulkAction" OnClick="EditSelectedLinkButton_Click" OnClientClick="if (!$('.rvdsfSalesOrderSalesOrderGrid :checkbox').is(':checked')) { alert('You must select at least one item first.'); return false; }" />
							</li>
						</ul>
					</div>
				</asp:View>
				<asp:View ID="DetailsView" runat="server">
					<uc1:BackControl ID="QuickBackControl" runat="server" Text="" CssClass="rvdsfBackAction" />
					<h2>Sales order:
						<uc1:BreadcrumbControl ID="BreadcrumbControl" runat="server" /> &nbsp;&nbsp;&nbsp;Total: <asp:Label ID="HeaderTotalAmountLabel" runat="server" /> &nbsp;&nbsp;&nbsp;Balance due: <asp:Label ID="HeaderBalanceDueLabel" runat="server" />
					</h2>
					<div id="SalesOrderDetailsViewTabPanel" class="dnnForm rvdsfSalesOrderContainer">
						<ul class="dnnAdminTabNav dnnClear">
							<li><a href="#<%= GeneralDetailsViewPanel.ClientID %>">
								<asp:Label ID="GeneralDetailsViewTabLabel" runat="server" Text="General" /></a></li>
							<li><a href="#<%= CustomFieldDetailsViewPanel.ClientID %>">
								<asp:Label ID="CustomFieldDetailsViewTabLabel" runat="server" Text="Custom field" /></a></li>
							<li><a href="#<%= BillingDetailsViewPanel.ClientID %>">
								<asp:Label ID="BillingDetailsViewTabLabel" runat="server" Text="Billing" /></a></li>
							<li id="PackingDetailsViewListItem" runat="server"><a href="#<%= PackingDetailsViewPanel.ClientID %>">
								<asp:Label ID="PackingDetailsViewTabLabel" runat="server" Text="Packing" /></a></li>
							<li id="ShippingDetailsViewListItem" runat="server"><a href="#<%= ShippingDetailsViewPanel.ClientID %>">
								<asp:Label ID="ShippingDetailsViewTabLabel" runat="server" Text="Shipping" /></a></li>
							<li id="HandlingDetailsViewListItem" runat="server"><a href="#<%= HandlingDetailsViewPanel.ClientID %>">
								<asp:Label ID="HandlingDetailsViewTabLabel" runat="server" Text="Handling" /></a></li>
							<li><a href="#<%= TaxDetailsViewPanel.ClientID %>">
								<asp:Label ID="TaxDetailsViewTabLabel" runat="server" Text="Tax" /></a></li>
							<li><a href="#<%= PaymentDetailsViewPanel.ClientID %>">
								<asp:Label ID="PaymentDetailsViewTabLabel" runat="server" Text="Payment" /></a></li>
							<li><a href="#<%= CouponDetailsViewPanel.ClientID %>">
								<asp:Label ID="CouponDetailsViewTabLabel" runat="server" Text="Coupon" /></a></li>
							<li id="RewardsPointDetailsViewListItem" runat="server"><a href="#<%= RewardsPointDetailsViewPanel.ClientID %>">
								<asp:Label ID="RewardsPointDetailsViewTabLabel" runat="server" Text="Reward" /></a></li>
							<li><a href="#<%= NotesDetailsViewPanel.ClientID %>">
								<asp:Label ID="NotesDetailsViewTabLabel" runat="server" Text="Notes" /></a></li>
							<li><a href="#<%= OtherDetailsViewPanel.ClientID %>">
								<asp:Label ID="OtherDetailsViewTabLabel" runat="server" Text="Other" /></a></li>
							<li id="RelatedDetailsViewListItem" runat="server"><a href="#<%= RelatedDetailsViewPanel.ClientID %>">
								<asp:Label ID="RelatedDetailsViewTabLabel" runat="server" Text="Related" /></a></li>
						</ul>
						<asp:Panel ID="GeneralDetailsViewPanel" runat="server" CssClass="dnnClear">
							<fieldset class="rvdSplit2">
								<div class="dnnFormGroup">
									<h2 class="dnnFormSectionHead"><a href="#">Order #<asp:Label ID="SalesOrderNumberLabel" runat="server" CssClass="rvdsfSalesOrderNumber"></asp:Label></a></h2>
									<fieldset>
										<div class="dnnFormItem">
											<dnn1:LabelControl ID="OrderDateLabelControl" runat="server" Text="Order date:" CssClass="dnnFormRequired" />
											<asp:RequiredFieldValidator ID="OrderDateRequiredFieldValidator" runat="server" ControlToValidate="OrderDateDnnDateTimePicker" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="SalesOrderDetailsViewControl">Order date is required.</asp:RequiredFieldValidator>
											<dnn2:DnnDateTimePicker ID="OrderDateDnnDateTimePicker" runat="server" ShowPopupOnFocus="True" DatePopupButton-Visible="False" DateInput-DateFormat="yyyy-MM-dd HH:mm" DateInput-EmptyMessage="YYYY-MM-DD HH:mm" CssClass="dnnFormRequired rvdDateTimeInput">
											</dnn2:DnnDateTimePicker>
										</div>
										<div class="dnnFormItem">
											<dnn1:LabelControl ID="StatusLabelControl" runat="server" Text="Order status:" />
											<asp:DropDownList ID="StatusDropDownList" runat="server">
												<asp:ListItem Value="7" style="background-color: Silver">Incomplete</asp:ListItem>
												<asp:ListItem Value="1" style="background-color: HotPink">Pending</asp:ListItem>
												<asp:ListItem Value="9" style="background-color: DeepPink">Quoted</asp:ListItem>
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
										<asp:Panel ID="SellerPanel" runat="server" CssClass="dnnFormItem">
											<dnn1:LabelControl ID="SellerLabelControl" runat="server" Text="Seller:" HelpText="Enter the name if this item belongs to a seller." />
											<dnn2:DnnComboBox ID="SellerDnnComboBox" runat="server" AllowCustomText="True" EnableLoadOnDemand="True" OnItemsRequested="SellerDnnComboBox_ItemsRequested" AutoPostBack="True" CausesValidation="False" MaxHeight="200px" OnSelectedIndexChanged="SellerDnnComboBox_SelectedIndexChanged"></dnn2:DnnComboBox>
										</asp:Panel>
										<asp:Panel ID="WarehousePanel" runat="server" CssClass="dnnFormItem">
											<dnn1:LabelControl ID="WarehouseLabelControl" runat="server" HelpText="Associate this order with the warehouse where all the products will be shipped from. If you leave blank, the products are assumed to be shipped from your business address." Text="Warehouse:" />
											<asp:DropDownList ID="WarehouseDropDownList" runat="server">
											</asp:DropDownList>
										</asp:Panel>
									</fieldset>
								</div>
								<div class="dnnFormGroup">
									<h2 class="dnnFormSectionHead"><a href="#">Customer</a></h2>
									<fieldset>
										<asp:Panel ID="FraudScorePanel" runat="server" CssClass="dnnFormItem">
											<dnn1:LabelControl ID="FraudScoreLabelControl" runat="server" Text="Fraud score:" HelpText="Score level ranges from (high fraud risk) 0 to 100 (low fraud risk)." />
											<asp:Label ID="FraudScoreLabel" runat="server" />
										</asp:Panel>
										<div class="dnnFormItem">
											<dnn1:LabelControl ID="UsernameLabelControl" runat="server" Text="Username:" />
											<asp:TextBox ID="UsernameTextBox" runat="server" AutoPostBack="True" OnTextChanged="UsernameTextBox_TextChanged"></asp:TextBox>
											<asp:HyperLink ID="UsernameHyperLink" runat="server" CssClass="rvdEditGridAction"></asp:HyperLink>
										</div>
										<div class="dnnFormItem">
											<dnn1:LabelControl ID="UserDisplayNameLabelControl" runat="server" Text="Name:" />
											<asp:Label ID="UserDisplayNameLabel" runat="server"></asp:Label>
										</div>
										<div class="dnnFormItem">
											<dnn1:LabelControl ID="UserPhoneLabelControl" runat="server" Text="Phone:" />
											<asp:Label ID="UserPhoneLabel" runat="server" />
										</div>
										<div class="dnnFormItem">
											<dnn1:LabelControl ID="UserEmailLabelControl" runat="server" Text="Email:" />
											<asp:HyperLink ID="UserEmailHyperLink" runat="server" />
										</div>
									</fieldset>
								</div>
								<div class="dnnFormGroup">
									<h2 class="dnnFormSectionHead"><a href="#">Billing</a></h2>
									<fieldset>
										<div class="dnnFormItem">
											<dnn1:LabelControl ID="BillToLabelControl" runat="server" Text="Bill to:" />
											<asp:Label ID="BillToLabel" runat="server" />
										</div>
									</fieldset>
								</div>
								<asp:Panel ID="ShippingPanel" runat="server" CssClass="dnnFormGroup">
									<h2 class="dnnFormSectionHead"><a href="#">Shipping</a></h2>
									<fieldset>
										<div class="dnnFormItem">
											<dnn1:LabelControl ID="ShipToLabelControl" runat="server" Text="Ship to:" />
											<asp:Label ID="ShipToLabel" runat="server" />
										</div>
										<div class="dnnFormItem">
											<dnn1:LabelControl ID="ShippingMethodNameLabelControl" runat="server" Text="Method:" />
											<asp:Label ID="ShippingMethodLabel" runat="server" />
										</div>
									</fieldset>
								</asp:Panel>
							</fieldset>
							<div class="dnnFormGroup">
								<h2 class="dnnFormSectionHead"><a href="#">Order detail</a></h2>
								<fieldset>
									<asp:Label ID="SalesOrderDetailUnavailableLabel" runat="server" Text="Please save your order first before adding an order detail item." CssClass="dnnFormMessage dnnFormInfo"></asp:Label>
									<uc1:SalesOrderDetailControl ID="SalesOrderDetailControl1" runat="server"></uc1:SalesOrderDetailControl>
								</fieldset>
							</div>
							<fieldset class="rvdSplit2">
								<div class="dnnFormGroup">
									<h2 class="dnnFormSectionHead"><a href="#">Totals</a></h2>
									<fieldset>
										<div class="dnnFormItem rvdsfSubTotalAmount">
											<dnn1:LabelControl ID="SubTotalAmountLabelControl" runat="server" Text="Sub total:" />
											<asp:Label ID="SubTotalAmountLabel" runat="server"></asp:Label>
										</div>
										<div class="dnnFormItem rvdsfTotalShippingAmount">
											<dnn1:LabelControl ID="TotalShippingLabelControl" runat="server" Text="Shipping:" />
											<asp:Label ID="TotalShippingAmountLabel" runat="server"></asp:Label>
										</div>
										<div class="dnnFormItem rvdsfTotalHandlingAmount">
											<dnn1:LabelControl ID="TotalHandlingAmountLabelControl" runat="server" Text="Handling:" />
											<asp:Label ID="TotalHandlingAmountLabel" runat="server"></asp:Label>
										</div>
										<div class="dnnFormItem rvdsfTotalTaxesAmount">
											<dnn1:LabelControl ID="TotalTaxAmountLabelControl" runat="server" Text="Taxes:" />
											<asp:Label ID="TotalTaxAmountLabel" runat="server"></asp:Label>
										</div>
										<div class="dnnFormItem rvdsfTotalAmount">
											<dnn1:LabelControl ID="TotalAmountLabelControl" runat="server" Text="Total:" />
											<asp:Label ID="TotalAmountLabel" runat="server"></asp:Label>
										</div>
									</fieldset>
									<fieldset>
										<asp:Panel ID="GroupTotalAmountPanel" runat="server" CssClass="dnnFormItem rvdsfTotalAmount">
											<dnn1:LabelControl ID="GroupTotalAmountLabelControl" runat="server" Text="Group total:" />
											<asp:Label ID="GroupTotalAmountLabel" runat="server"></asp:Label>
										</asp:Panel>
									</fieldset>
								</div>
								<div class="dnnFormGroup">
									<h2 class="dnnFormSectionHead"><a href="#">Payment</a></h2>
									<fieldset>
										<div class="dnnFormItem rvdsfTotalPaymentAmount">
											<dnn1:LabelControl ID="TotalPaymentReceivedLabelControl" runat="server" Text="Authorized:" />
											<asp:Label ID="TotalPaymentReceivedLabel" runat="server"></asp:Label>
										</div>
                                        <div class="dnnFormItem rvdsfTotalPaymentAmount">
											<dnn1:LabelControl ID="TotalPaymentCommittedLabelControl" runat="server" Text="Captured:" />
											<asp:Label ID="TotalPaymentCommittedLabel" runat="server"></asp:Label>
										</div>
										<asp:Panel ID="BalanceDuePanel" runat="server" CssClass="dnnFormItem rvdsfBalanceDueAmount">
											<dnn1:LabelControl ID="BalanceDueLabelControl" runat="server" Text="Balance due:" />
											<asp:Label ID="BalanceDueLabel" runat="server"></asp:Label>
										</asp:Panel>
									</fieldset>
									<fieldset>
										<asp:Panel ID="GroupTotalPaymentReceivedPanel" runat="server" CssClass="dnnFormItem rvdsfTotalPaymentAmount">
											<dnn1:LabelControl ID="GroupTotalPaymentReceivedLabelControl" runat="server" Text="Group authorized:" />
											<asp:Label ID="GroupTotalPaymentReceivedLabel" runat="server"></asp:Label>
										</asp:Panel>
                                        <asp:Panel ID="GroupTotalPaymentCommittedPanel" runat="server" CssClass="dnnFormItem rvdsfTotalPaymentAmount">
											<dnn1:LabelControl ID="GroupTotalPaymentCommittedLabelControl" runat="server" Text="Group captured:" />
											<asp:Label ID="GroupTotalPaymentCommittedLabel" runat="server"></asp:Label>
										</asp:Panel>
										<asp:Panel ID="GroupBalanceDuePanel" runat="server" CssClass="dnnFormItem rvdsfBalanceDueAmount">
											<dnn1:LabelControl ID="GroupBalanceDueLabelControl" runat="server" Text="Group balance due:" />
											<asp:Label ID="GroupBalanceDueLabel" runat="server"></asp:Label>
										</asp:Panel>
									</fieldset>
									<fieldset>
										<div class="dnnFormItem">
											<dnn1:LabelControl ID="SalesPaymentMethodNameLabelControl" runat="server" Text="Method:" />
											<asp:Label ID="SalesPaymentMethodNameLabel" runat="server"></asp:Label>
										</div>
									</fieldset>
								</div>
							</fieldset>
							<div class="dnnFormGroup">
								<h2 class="dnnFormSectionHead"><a href="#">Notes</a></h2>
								<fieldset>
									<div>
										<asp:Label ID="AdminNotesLabel" runat="server"></asp:Label>
									</div>
								</fieldset>
							</div>
						</asp:Panel>
						<asp:Panel ID="CustomFieldDetailsViewPanel" runat="server" CssClass="dnnClear">
							<fieldset>
								<uc1:DynamicFormResultEditorControl ID="DynamicFormResultEditor" runat="server" />
							</fieldset>
						</asp:Panel>
						<asp:Panel ID="BillingDetailsViewPanel" runat="server" CssClass="dnnClear">
							<fieldset>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="BillingUserAddressLabelControl" runat="server" Text="Use address book:" />
									<uc1:UserAddressDropDownListControl ID="BillingUserAddressDropDownListControl" runat="server" AutoPostBack="True" />
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="BillingFirstNameLabelControl" runat="server" Text="First name:" CssClass="dnnFormRequired" />
									<asp:TextBox ID="BillingFirstNameTextBox" runat="server" MaxLength="50" CssClass="dnnFormRequired"></asp:TextBox>
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="BillingLastNameLabelControl" runat="server" Text="Last name:" CssClass="dnnFormRequired" />
									<asp:TextBox CssClass="dnnFormRequired" ID="BillingLastNameTextBox" runat="server" MaxLength="50"></asp:TextBox>
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="BillingCompanyLabelControl" runat="server" Text="Company:" />
									<asp:TextBox ID="BillingCompanyTextBox" runat="server" MaxLength="100"></asp:TextBox>
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="BillingCountryLabelControl" runat="server" Text="Country:" />
									<asp:DropDownList ID="BillingCountryDropDownList" runat="server" AutoPostBack="True" OnSelectedIndexChanged="BillingCountryDropDownList_SelectedIndexChanged">
									</asp:DropDownList>
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="BillingStreetLabelControl" runat="server" Text="Street:" CssClass="dnnFormRequired" />
									<asp:RegularExpressionValidator ID="RegularExpressionValidator5" runat="server" ControlToValidate="BillingStreetTextBox" ValidationExpression="^[\s\S]{0,200}$" ValidationGroup="SalesOrderDetailsViewControl" Display="Dynamic">Street is invalid.</asp:RegularExpressionValidator>
									<asp:TextBox CssClass="dnnFormRequired" ID="BillingStreetTextBox" runat="server" Rows="2" TextMode="MultiLine" MaxLength="200"></asp:TextBox>
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="BillingCityLabelControl" runat="server" Text="City:" CssClass="dnnFormRequired" />
									<asp:TextBox CssClass="dnnFormRequired" ID="BillingCityTextBox" runat="server" MaxLength="50"></asp:TextBox>
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="BillingSubdivisionLabelControl" runat="server" Text="State/Province:" />
									<asp:DropDownList ID="BillingSubdivisionDropDownList" runat="server" DataTextField="Name" DataValueField="IsoCode">
									</asp:DropDownList>
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="BillingPostalCodeLabelControl" runat="server" Text="Postal code:" CssClass="dnnFormRequired" />
									<asp:TextBox CssClass="dnnFormRequired" ID="BillingPostalCodeTextBox" runat="server" MaxLength="10"></asp:TextBox>
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="BillingPhoneLabelControl" runat="server" Text="Phone:" CssClass="dnnFormRequired" />
									<asp:TextBox CssClass="dnnFormRequired" ID="BillingPhoneTextBox" runat="server" MaxLength="50"></asp:TextBox>
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="BillingEmailLabelControl" runat="server" Text="Email:" />
									<asp:TextBox ID="BillingEmailTextBox" runat="server" MaxLength="256"></asp:TextBox>
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="BusinessTaxNumberLabelControl" runat="server" Text="Business tax number:" />
									<asp:TextBox ID="BusinessTaxNumberTextBox" runat="server"></asp:TextBox>
								</div>
							</fieldset>
						</asp:Panel>
						<asp:Panel ID="PackingDetailsViewPanel" runat="server" CssClass="dnnClear">
							<fieldset>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="PackingMethodNameLabelControl" runat="server" Text="Packing method:" />
									<asp:DropDownList ID="PackingMethodDropDownList" runat="server">
									</asp:DropDownList>
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="ShippingPackageLabelControl" runat="server" Text="" />
									<uc1:ShippingPackageControl ID="ShippingPackageControl" runat="server" />
								</div>
							</fieldset>
						</asp:Panel>
						<asp:Panel ID="ShippingDetailsViewPanel" runat="server" CssClass="dnnClear">
							<fieldset>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="ShippingAmountLabelControl" runat="server" Text="Shipping amount:" CssClass="dnnFormRequired" />
									<asp:RequiredFieldValidator ID="ShippingAmountRequiredFieldValidator" runat="server" ControlToValidate="ShippingAmountDnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="SalesOrderDetailsViewControl">Shipping amount is required.</asp:RequiredFieldValidator>
									<dnn2:DnnNumericTextBox ID="ShippingAmountDnnNumericTextBox" runat="server" Skin="" Value="0.00" NumberFormat-DecimalDigits="4" NumberFormat-GroupSizes="9" EnableSingleInputRendering="False" CssClass="dnnFormRequired">
									</dnn2:DnnNumericTextBox>
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="ShippingDiscountAmountLabelControl" runat="server" Text="Shipping discount amount:" CssClass="dnnFormRequired" HelpText="The discount applied to the shipping amount. For example, to give a discount of $10.00, you would enter -10.00." />
									<asp:RequiredFieldValidator ID="ShippingDiscountAmountRequiredFieldValidator" runat="server" ControlToValidate="ShippingDiscountAmountDnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="SalesOrderDetailsViewControl">Shipping discount amount is required.</asp:RequiredFieldValidator>
									<dnn2:DnnNumericTextBox ID="ShippingDiscountAmountDnnNumericTextBox" runat="server" Skin="" Value="0.00" NumberFormat-DecimalDigits="4" NumberFormat-GroupSizes="9" EnableSingleInputRendering="False" CssClass="dnnFormRequired">
									</dnn2:DnnNumericTextBox>
								</div>
							</fieldset>
							<fieldset>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="ShippingMethodLabelControl" runat="server" Text="Shipping method:" />
									<asp:DropDownList ID="ShippingMethodDropDownList" runat="server">
									</asp:DropDownList>
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="ShippingTrackingCodeLabelControl" runat="server" Text="Tracking code:" />
									<asp:TextBox ID="ShippingTrackingCodeTextBox" runat="server"></asp:TextBox>
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="ShippedDateLabelControl" runat="server" Text="Shipped date:" />
									<dnn2:DnnDatePicker ID="ShippedDateDnnDatePicker" runat="server" ShowPopupOnFocus="True" DatePopupButton-Visible="False" DateInput-DateFormat="yyyy-MM-dd" DateInput-EmptyMessage="YYYY-MM-DD">
									</dnn2:DnnDatePicker>
								</div>
							</fieldset>
							<fieldset>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="ShippingUserAddressLabelControl" runat="server" Text="Use address book:" />
									<uc1:UserAddressDropDownListControl ID="ShippingUserAddressDropDownListControl" runat="server" AutoPostBack="True" />
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="CopyFromBillingAddressLabelControl" runat="server" Text="" />
									<asp:LinkButton ID="CopyFromBillingAddressLinkButton" runat="server" CausesValidation="False" OnClick="CopyFromBillingAddressLinkButton_Click" CssClass="dnnSecondaryAction">Copy from billing address</asp:LinkButton>
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="ShippingFirstNameLabelControl" runat="server" Text="First name:" CssClass="dnnFormRequired" />
									<asp:TextBox ID="ShippingFirstNameTextBox" runat="server" MaxLength="50" CssClass="dnnFormRequired"></asp:TextBox>
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="ShippingLastNameLabelControl" runat="server" Text="Last name:" CssClass="dnnFormRequired" />
									<asp:TextBox ID="ShippingLastNameTextBox" runat="server" MaxLength="50" CssClass="dnnFormRequired"></asp:TextBox>
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="ShippingCompanyLabelControl" runat="server" Text="Company:" />
									<asp:TextBox ID="ShippingCompanyTextBox" runat="server" MaxLength="100"></asp:TextBox>
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="ShippingCountryLabelControl" runat="server" Text="Country:" />
									<asp:DropDownList ID="ShippingCountryDropDownList" runat="server" AutoPostBack="True" DataTextField="Name" DataValueField="IsoAlpha2Code" OnSelectedIndexChanged="ShippingCountryDropDownList_SelectedIndexChanged">
									</asp:DropDownList>
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="ShippingStreetLabelControl" runat="server" Text="Street:" CssClass="dnnFormRequired" />
									<asp:RegularExpressionValidator ID="RegularExpressionValidator6" runat="server" ControlToValidate="ShippingStreetTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationExpression="^[\s\S]{0,200}$" ValidationGroup="SalesOrderDetailsViewControl">Street is invalid.</asp:RegularExpressionValidator>
									<asp:TextBox ID="ShippingStreetTextBox" runat="server" MaxLength="200" Rows="2" TextMode="MultiLine" CssClass="dnnFormRequired"></asp:TextBox>
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="ShippingCityLabelControl" runat="server" Text="City:" CssClass="dnnFormRequired" />
									<asp:TextBox ID="ShippingCityTextBox" runat="server" MaxLength="50" CssClass="dnnFormRequired"></asp:TextBox>
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="ShippingSubdivisionLabelControl" runat="server" Text="State/Province:" />
									<asp:DropDownList ID="ShippingSubdivisionDropDownList" runat="server" DataTextField="Name" DataValueField="IsoCode">
									</asp:DropDownList>
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="ShippingPostalCodeLabelControl" runat="server" Text="Postal code:" CssClass="dnnFormRequired" />
									<asp:TextBox ID="ShippingPostalCodeTextBox" runat="server" MaxLength="10" CssClass="dnnFormRequired"></asp:TextBox>
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="ShippingPhoneLabelControl" runat="server" Text="Phone:" CssClass="dnnFormRequired" />
									<asp:TextBox ID="ShippingPhoneTextBox" runat="server" MaxLength="50" CssClass="dnnFormRequired"></asp:TextBox>
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="ShippingEmailLabelControl" runat="server" Text="Email:" />
									<asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ControlToValidate="ShippingEmailTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ValidationGroup="SalesOrderDetailsViewControl">Email is required.</asp:RegularExpressionValidator>
									<asp:TextBox ID="ShippingEmailTextBox" runat="server" MaxLength="256"></asp:TextBox>
								</div>
							</fieldset>
						</asp:Panel>
						<asp:Panel ID="HandlingDetailsViewPanel" runat="server" CssClass="dnnClear">
							<fieldset>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="HandlingAmountLabelControl" runat="server" Text="Handling amount:" CssClass="dnnFormRequired" />
									<asp:RequiredFieldValidator ID="HandlingAmountRequiredFieldValidator" runat="server" ControlToValidate="HandlingAmountDnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="SalesOrderDetailsViewControl">Handling amount is required.</asp:RequiredFieldValidator>
									<dnn2:DnnNumericTextBox ID="HandlingAmountDnnNumericTextBox" runat="server" Skin="" Value="0.00" NumberFormat-DecimalDigits="4" NumberFormat-GroupSizes="9" EnableSingleInputRendering="False" CssClass="dnnFormRequired">
									</dnn2:DnnNumericTextBox>
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="HandlingDiscountAmountLabelControl" runat="server" Text="Handling discount amount:" CssClass="dnnFormRequired" HelpText="The discount applied to the handling amount. For example, to give a discount of $10.00, you would enter -10.00." />
									<asp:RequiredFieldValidator ID="HandlingDiscountAmountRequiredFieldValidator" runat="server" ControlToValidate="HandlingDiscountAmountDnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="SalesOrderDetailsViewControl">Handling discount amount is required.</asp:RequiredFieldValidator>
									<dnn2:DnnNumericTextBox ID="HandlingDiscountAmountDnnNumericTextBox" runat="server" Skin="" Value="0.00" NumberFormat-DecimalDigits="4" NumberFormat-GroupSizes="9" EnableSingleInputRendering="False" CssClass="dnnFormRequired">
									</dnn2:DnnNumericTextBox>
								</div>
							</fieldset>
							<fieldset>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="HandlingMethodNameLabelControl" runat="server" Text="Handling method:" />
									<asp:DropDownList ID="HandlingMethodDropDownList" runat="server">
									</asp:DropDownList>
								</div>
							</fieldset>
						</asp:Panel>
						<asp:Panel ID="TaxDetailsViewPanel" runat="server" CssClass="dnnClear">
							<fieldset>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="TaxAmount1LabelControl" runat="server" Text="Tax amount 1:" CssClass="dnnFormRequired" />
									<asp:RequiredFieldValidator ID="TaxAmount1RequiredFieldValidator" runat="server" ControlToValidate="TaxAmount1DnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="SalesOrderDetailsViewControl">Tax amount is required.</asp:RequiredFieldValidator>
									<dnn2:DnnNumericTextBox ID="TaxAmount1DnnNumericTextBox" runat="server" Skin="" Value="0.00" NumberFormat-DecimalDigits="4" NumberFormat-GroupSizes="9" EnableSingleInputRendering="False" CssClass="dnnFormRequired">
									</dnn2:DnnNumericTextBox>
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="TaxAmount2LabelControl" runat="server" Text="Tax amount 2:" CssClass="dnnFormRequired" />
									<asp:RequiredFieldValidator ID="TaxAmount2RequiredFieldValidator" runat="server" ControlToValidate="TaxAmount2DnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="SalesOrderDetailsViewControl">Tax amount is required.</asp:RequiredFieldValidator>
									<dnn2:DnnNumericTextBox ID="TaxAmount2DnnNumericTextBox" runat="server" Skin="" Value="0.00" NumberFormat-DecimalDigits="4" NumberFormat-GroupSizes="9" EnableSingleInputRendering="False" CssClass="dnnFormRequired">
									</dnn2:DnnNumericTextBox>
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="TaxAmount3LabelControl" runat="server" Text="Tax amount 3:" CssClass="dnnFormRequired" />
									<asp:RequiredFieldValidator ID="TaxAmount3RequiredFieldValidator" runat="server" ControlToValidate="TaxAmount3DnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="SalesOrderDetailsViewControl">Tax amount is required.</asp:RequiredFieldValidator>
									<dnn2:DnnNumericTextBox ID="TaxAmount3DnnNumericTextBox" runat="server" Skin="" Value="0.00" NumberFormat-DecimalDigits="4" NumberFormat-GroupSizes="9" EnableSingleInputRendering="False" CssClass="dnnFormRequired">
									</dnn2:DnnNumericTextBox>
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="TaxAmount4LabelControl" runat="server" Text="Tax amount 4:" CssClass="dnnFormRequired" />
									<asp:RequiredFieldValidator ID="TaxAmount4RequiredFieldValidator" runat="server" ControlToValidate="TaxAmount4DnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="SalesOrderDetailsViewControl">Tax amount is required.</asp:RequiredFieldValidator>
									<dnn2:DnnNumericTextBox ID="TaxAmount4DnnNumericTextBox" runat="server" Skin="" Value="0.00" NumberFormat-DecimalDigits="4" NumberFormat-GroupSizes="9" EnableSingleInputRendering="False" CssClass="dnnFormRequired">
									</dnn2:DnnNumericTextBox>
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="TaxAmount5LabelControl" runat="server" Text="Tax amount 5:" CssClass="dnnFormRequired" />
									<asp:RequiredFieldValidator ID="TaxAmount5RequiredFieldValidator" runat="server" ControlToValidate="TaxAmount5DnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="SalesOrderDetailsViewControl">Tax amount is required.</asp:RequiredFieldValidator>
									<dnn2:DnnNumericTextBox ID="TaxAmount5DnnNumericTextBox" runat="server" Skin="" Value="0.00" NumberFormat-DecimalDigits="4" NumberFormat-GroupSizes="9" EnableSingleInputRendering="False" CssClass="dnnFormRequired">
									</dnn2:DnnNumericTextBox>
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="TaxDiscountAmountLabelControl" runat="server" Text="Tax discount amount:" CssClass="dnnFormRequired" HelpText="The discount applied to the tax amount. For example, to give a discount of $10.00, you would enter -10.00." />
									<asp:RequiredFieldValidator ID="TaxDiscountAmountRequiredFieldValidator" runat="server" ControlToValidate="TaxDiscountAmountDnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="SalesOrderDetailsViewControl">Tax discount amount is required.</asp:RequiredFieldValidator>
									<dnn2:DnnNumericTextBox ID="TaxDiscountAmountDnnNumericTextBox" runat="server" Skin="" Value="0.00" NumberFormat-DecimalDigits="4" NumberFormat-GroupSizes="9" EnableSingleInputRendering="False" CssClass="dnnFormRequired">
									</dnn2:DnnNumericTextBox>
								</div>
							</fieldset>
						</asp:Panel>
						<asp:Panel ID="PaymentDetailsViewPanel" runat="server" CssClass="dnnClear">
							<fieldset>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="PreferredUserPaymentLabelControl" runat="server" Text="Preferred user payment:" HelpText="Customer prefers to pay with this payment method when possible." />
									<uc1:UserPaymentDropDownListControl ID="PreferredUserPaymentDropDownListControl" runat="server" />
								</div>
							</fieldset>
							<fieldset>
								<asp:Label ID="SalesPaymentUnavailableLabel" runat="server" Text="Please save your order first before adding sales payment." CssClass="dnnFormMessage dnnFormInfo"></asp:Label>
								<uc1:SalesPaymentControl ID="SalesPaymentControl1" runat="server"></uc1:SalesPaymentControl>
							</fieldset>
						</asp:Panel>
						<asp:Panel ID="RewardsPointDetailsViewPanel" runat="server" CssClass="dnnClear">
							<fieldset>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="RewardsPointsQualifiedLabelControl" runat="server" Text="Rewards points qualified:" HelpText="The number of rewards points the customer would earn from this order." CssClass="dnnFormRequired" />
									<asp:RequiredFieldValidator ID="RewardsPointsQualifiedRequiredFieldValidator" runat="server" ControlToValidate="RewardsPointsQualifiedDnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="SalesOrderDetailsViewControl">Rewards points qualified is required.</asp:RequiredFieldValidator>
									<dnn2:DnnNumericTextBox ID="RewardsPointsQualifiedDnnNumericTextBox" runat="server" Skin="" Value="0" NumberFormat-DecimalDigits="0" NumberFormat-GroupSizes="9" EnableSingleInputRendering="False" CssClass="dnnFormRequired">
									</dnn2:DnnNumericTextBox>
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="RewardsPointsRewardedLabelControl" runat="server" Text="Rewards points awarded:" HelpText="The number of rewards points the customer has been rewarded for this order." />
									<asp:Label ID="RewardsPointsRewardedLabel" runat="server"></asp:Label>
								</div>
							</fieldset>
						</asp:Panel>
						<asp:Panel ID="NotesDetailsViewPanel" runat="server" CssClass="dnnClear">
							<fieldset>
								<div id="NotesSalesOrderDetailsViewPanel" class="dnnForm">
									<h2 id="AdminNotesSectionHead" class="dnnFormSectionHead">
										<a href="#" class="dnnSectionExpanded">Admin notes</a>
									</h2>
									<fieldset>
										<div class="dnnFormItem">
											<dnn1:LabelControl ID="AdminNotesLabelControl" runat="server" Text="Admin notes:" HelpText="Notes entered here are not visible to the customer." />
											<dnn1:TextEditor ID="AdminNotesTextEditor" runat="server" ChooseRender="False" ChooseMode="False" DefaultMode="RICH" Mode="RICH" HtmlEncode="False" Width="100%" Height="400px" />
										</div>
									</fieldset>
									<h2 id="CustomerNotesSectionHead" class="dnnFormSectionHead">
										<a href="#" class="dnnSectionExpanded">Customer notes</a>
									</h2>
									<fieldset>
										<div class="dnnFormItem">
											<dnn1:LabelControl ID="CustomerNotesLabelControl" runat="server" Text="Customer notes:" HelpText="Notes entered here are visible to the customer." />
											<dnn1:TextEditor ID="CustomerNotesTextEditor" runat="server" ChooseRender="False" ChooseMode="False" DefaultMode="RICH" Mode="RICH" HtmlEncode="False" Width="100%" Height="400px" />
										</div>
									</fieldset>
								</div>
							</fieldset>
						</asp:Panel>
						<asp:Panel ID="CouponDetailsViewPanel" runat="server" CssClass="dnnClear">
							<fieldset>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="CouponCodesLabelControl" runat="server" Text="Coupon codes:" />
									<div class="rvdFormSubContainer">
										<asp:TextBox ID="CouponCodeTextBox" runat="server" MaxLength="100"></asp:TextBox>
										<asp:LinkButton ID="AddCouponLinkButton" runat="server" OnClick="AddCouponLinkButton_Click" CausesValidation="False" CssClass="rvdAddNewGridAction" />
										<asp:DataList ID="CouponDataList" CssClass="rvdsfCheckoutCouponList" runat="server" RepeatColumns="4" RepeatDirection="Horizontal" RepeatLayout="Flow">
											<ItemTemplate>
												<asp:LinkButton ID="DeleteCouponLinkButton" runat="server" CommandArgument='<%# Eval("Code") %>' OnClick="DeleteCouponLinkButton_Click" CausesValidation="False" CssClass="rvdDeleteGridAction" resourcekey="DeleteCouponLinkButton" />
												<asp:Label ID="CouponLabel" runat="server" Text='<%# Eval("Code") %>' />
											</ItemTemplate>
										</asp:DataList>
									</div>
								</div>
							</fieldset>
						</asp:Panel>
						<asp:Panel ID="OtherDetailsViewPanel" runat="server" CssClass="dnnClear">
							<fieldset>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="SalesOrderIDLabelControl" runat="server" Text="Order ID:" />
									<asp:Label ID="SalesOrderIDLabel" runat="server"></asp:Label>
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="SalesOrderGUIDLabelControl" runat="server" Text="Order GUID:" HelpText="This is the internal globally unique identifier that may be used by third party providers such as payment gateways to reference this order." />
									<asp:Label ID="SalesOrderGUIDLabel" runat="server"></asp:Label>
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="CreateDateLabelControl" runat="server" Text="Create date:" />
									<asp:Label ID="CreateDateLabel" runat="server"></asp:Label>
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="UpdateDateLabelControl" runat="server" Text="Last modified:" />
									<asp:Label ID="UpdateDateLabel" runat="server"></asp:Label>
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="OriginLabelControl" runat="server" Text="Origin:" />
									<asp:Label ID="OriginLabel" runat="server"></asp:Label>
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="UserHostAddressLabelControl" runat="server" Text="IP address:" />
									<asp:Label ID="UserHostAddressLabel" runat="server"></asp:Label>
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="CultureCodeLabelControl" runat="server" Text="Culture code:" HelpText="The culture seen by the customer at the moment of purchasing the product." />
									<asp:Label ID="CultureCodeLabel" runat="server"></asp:Label>
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="CurrencyCultureCodeLabelControl" runat="server" Text="Currency culture:" HelpText="The monetary currency of the order." />
									<asp:Label ID="CurrencyCultureCodeLabel" runat="server"></asp:Label>
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="ExchangeRateLabelControl" runat="server" Text="Exchange rate:" HelpText="The exchange rate for the culture at the moment of purchasing the product." CssClass="dnnFormRequired" />
									<asp:RequiredFieldValidator ID="ExchangeRateRequiredFieldValidator" runat="server" ControlToValidate="ExchangeRateDnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="SalesOrderDetailsViewControl">Exchange rate is required.</asp:RequiredFieldValidator>
									<dnn2:DnnNumericTextBox ID="ExchangeRateDnnNumericTextBox" runat="server" Skin="" Value="1.000" NumberFormat-DecimalDigits="4" NumberFormat-GroupSizes="9" EnableSingleInputRendering="False" CssClass="dnnFormRequired" MinValue="0">
									</dnn2:DnnNumericTextBox>
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="PurchaseOrderNumberLabelControl" runat="server" Text="PO number:" />
									<asp:TextBox ID="PurchaseOrderNumberTextBox" runat="server"></asp:TextBox>
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="WishListIDLabelControl" runat="server" Text="Wish list ID:" />
									<asp:Label ID="WishListIDLabel" runat="server"></asp:Label>
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="AffiliateLabelControl" runat="server" Text="Affiliate:" HelpText="Indicates if this order was referred by an affiliate vendor." />
									<asp:DropDownList ID="AffiliateDropDownList" runat="server" />
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="CartAbandonNotifiedLabelControl" runat="server" Text="Cart abandon notified:" HelpText="Indicates if the system has already automatically sent a cart abandon email." />
									<asp:CheckBox ID="CartAbandonNotifiedCheckBox" runat="server" />
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="OrderLockedLabelControl" runat="server" Text="Locked:" HelpText="Lock the order from customer changes. The customer will not be allowed to modify the order details when the customer is resuming an incomplete order." />
									<asp:CheckBox ID="OrderLockedCheckBox" runat="server" />
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="SessionLabelControl" runat="server" Text="Session link:" HelpText="This link may be sent to a customer to resume an incomplete cart session for this order." />
									<asp:HyperLink ID="CartSessionHyperLink" runat="server" Text="Cart" />
									<asp:HyperLink ID="CheckoutSessionHyperLink" runat="server" Text="Checkout" />
									<asp:HyperLink ID="PaymentSessionHyperLink" runat="server" Text="Payment" />
								</div>
							</fieldset>
						</asp:Panel>
						<asp:Panel ID="RelatedDetailsViewPanel" runat="server" CssClass="dnnClear">
							<fieldset>
								<asp:GridView ID="RelatedSalesOrderGridView" runat="server" AutoGenerateColumns="False" DataKeyNames="SalesOrderID" CssClass="dnnGrid" GridLines="None" OnRowDataBound="RelatedSalesOrderGridView_RowDataBound">
									<AlternatingRowStyle CssClass="dnnGridAltItem" />
									<HeaderStyle CssClass="dnnGridHeader" />
									<RowStyle CssClass="dnnGridItem" />
									<SelectedRowStyle CssClass="dnnGridSelectedItem" />
									<FooterStyle CssClass="dnnGridFooter" />
									<PagerStyle CssClass="dnnGridPager" />
									<Columns>
										<asp:TemplateField>
											<ItemTemplate>
												<asp:HyperLink ID="SelectHyperLink" runat="server" CssClass="rvdEditGridAction" />
											</ItemTemplate>
										</asp:TemplateField>
										<asp:BoundField DataField="SalesOrderNumber" HeaderText="Order" SortExpression="SalesOrderNumber" />
										<asp:BoundField DataField="Status" HeaderText="Order status" SortExpression="Status" />
										<asp:BoundField DataField="SalesPaymentStatus" HeaderText="Payment status" SortExpression="SalesPaymentStatus" />
										<asp:BoundField DataField="ShippingStatus" HeaderText="Shipping status" SortExpression="ShippingStatus" />
										<asp:BoundField DataField="FraudScore" HeaderText="Fraud" SortExpression="FraudScore" />
										<asp:BoundField DataField="TotalAmount" HeaderText="Total" SortExpression="TotalAmount" />
										<asp:TemplateField HeaderText="Parent">
											<ItemTemplate>
												<asp:CheckBox ID="ParentCheckBox" runat="server" Enabled="false" />
											</ItemTemplate>
										</asp:TemplateField>
									</Columns>
								</asp:GridView>
							</fieldset>
						</asp:Panel>
					</div>
					<div class="dnnForm">
						<ul class="dnnButtonGroup">
							<li>
								<asp:LinkButton ID="RecalculateOrderLinkButton" runat="server" Text="Recalculate: Order" OnClick="RecalculateOrderLinkButton_Click" CausesValidation="false" OnClientClick="return confirm('Are you sure you want to recalculate the order? Recalculate order will reset the rewards points due, shipping, handling and tax amounts to the newly calculated values.')" ToolTip="Recalculate the sales order including rewards points, shipping, handling and taxes, but without recalculating the sales order detail items." />
							</li>
							<li>
								<asp:LinkButton ID="RecalculateAllLinkButton" runat="server" Text="All" OnClick="RecalculateAllLinkButton_Click" CausesValidation="false" OnClientClick="return confirm('Are you sure you want to recalculate all? Recalculate all will reset the rewards points due, shipping, handling and tax amounts including all sales order detail items to the newly calculated values.')" ToolTip="Recalculate the entire sales order including sales order details, rewards points, shipping, handling and taxes." />
							</li>
						</ul>
						<ul class="dnnButtonGroup">
							<li>
								<asp:LinkButton ID="EmailSalesOrderReceiptLinkButton" runat="server" Text="Email: Receipt" OnClick="EmailSalesOrderReceiptLinkButton_Click" CausesValidation="false" CssClass="rvdEmailAction" />
							</li>
							<li>
								<asp:LinkButton ID="EmailSalesOrderInvoiceLinkButton" runat="server" Text="Invoice" OnClick="EmailSalesOrderInvoiceLinkButton_Click" CausesValidation="false" CssClass="rvdEmailAction" />
							</li>
							<li>
								<asp:LinkButton ID="EmailCartAbandonLinkButton" runat="server" Text="Cart abandon" OnClick="EmailCartAbandonLinkButton_Click" CausesValidation="false" CssClass="rvdEmailAction" />
							</li>
						</ul>
						<ul class="dnnButtonGroup">
							<li>
								<asp:HyperLink ID="PrintSalesOrderReceiptHyperLink" runat="server" Text="Print: Receipt" Target="_blank" CssClass="rvdPrintAction"></asp:HyperLink>
							</li>
							<li>
								<asp:HyperLink ID="PrintSalesOrderInvoiceHyperLink" runat="server" Text="Invoice" Target="_blank" CssClass="rvdPrintAction"></asp:HyperLink>
							</li>
							<li>
								<asp:HyperLink ID="PrintPackingSlipHyperLink" runat="server" Text="Packing" Target="_blank" CssClass="rvdPrintAction"></asp:HyperLink>
							</li>
						</ul>
						<ul class="dnnButtonGroup">
							<li>
								<asp:LinkButton ID="IncrementInventoryLinkButton" runat="server" Text="Inventory: Increment" OnClick="IncrementInventoryLinkButton_Click" CausesValidation="false" />
							</li>
							<li>
								<asp:LinkButton ID="DecrementInventoryLinkButton" runat="server" Text="Decrement" OnClick="DecrementInventoryLinkButton_Click" CausesValidation="false" />
							</li>
						</ul>
						<ul class="dnnButtonGroup">
							<li>
								<asp:LinkButton ID="RewardPointsLinkButton" runat="server" Text="Reward points" OnClick="RewardPointsLinkButton_Click" CausesValidation="false" ToolTip="Reward any missing qualified points that are not yet rewarded to the user for this order." />
							</li>
							<li>
								<asp:LinkButton ID="RunPlaceOrderActionLinkButton" runat="server" Text="Run place order action" OnClick="RunPlaceOrderActionLinkButton_Click" CausesValidation="false" />
							</li>
						</ul>
					</div>
					<div class="dnnForm">
						<ul class="dnnActions">
							<li>
								<asp:LinkButton ID="SaveLinkButton" runat="server" Text="Save" OnClick="SaveLinkButton_Click" ValidationGroup="SalesOrderDetailsViewControl" CssClass="dnnPrimaryAction rvdSaveAction" />
							</li>
							<li>
								<asp:LinkButton ID="SaveAndBackLinkButton" runat="server" Text="Save & return" OnClick="SaveLinkButton_Click" CommandArgument="Back" CssClass="dnnPrimaryAction rvdSaveAction" ValidationGroup="SalesOrderDetailsViewControl" />
							</li>
							<li>
								<uc1:BackControl ID="BackControl1" runat="server" Text="Cancel" />
							</li>
						</ul>
					</div>
				</asp:View>
			</asp:MultiView>
		</ContentTemplate>
	</asp:UpdatePanel>
</div>
