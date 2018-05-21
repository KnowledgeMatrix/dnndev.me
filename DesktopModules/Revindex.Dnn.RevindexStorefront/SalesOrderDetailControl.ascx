<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="SalesOrderDetailControl.ascx.cs" Inherits="Revindex.Dnn.RevindexStorefront.SalesOrderDetailControl" %>
<%@ Register Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Src="~/Controls/labelcontrol.ascx" TagName="LabelControl" TagPrefix="dnn1" %>
<%@ Register Src="~/Controls/texteditor.ascx" TagName="TextEditor" TagPrefix="dnn1" %>
<%@ Register Assembly="DotNetNuke.Web.Deprecated" Namespace="DotNetNuke.Web.UI.WebControls" TagPrefix="dnn2" %>
<%@ Register Assembly="Revindex.Web.UI.WebControls" Namespace="Revindex.Web.UI.WebControls" TagPrefix="rvd1" %>
<%@ Register Src="WebUserControls/Common/Dnn/BackControl.ascx" TagName="BackControl" TagPrefix="uc1" %>
<%@ Register Src="WebUserControls/DynamicFormResultEditorControl.ascx" TagName="DynamicFormResultEditorControl" TagPrefix="uc1" %>
<%@ Register Src="WebUserControls/BaseEditorControl.ascx" TagName="BaseEditorControl" TagPrefix="uc1" %>
<%@ Register Src="WebUserControls/Common/Dnn/BreadcrumbControl.ascx" TagName="BreadcrumbControl" TagPrefix="uc1" %>
<uc1:BaseEditorControl ID="BaseEditorControl1" runat="server" />
<asp:PlaceHolder ID="PlaceHolder1" runat="server">

	<script type="text/javascript">
		jQuery(document).ready(function ()
		{
			jQuery('#SalesOrderDetailDetailsViewTabPanel').dnnTabs();
		});
		Sys.WebForms.PageRequestManager.getInstance().add_endRequest(function ()
		{
			jQuery('#SalesOrderDetailDetailsViewTabPanel').dnnTabs();
		});
	</script>

</asp:PlaceHolder>
<div>
	<asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
		<ContentTemplate>
			<asp:PlaceHolder ID="MessagePlaceHolder" runat="server" />
			<asp:MultiView ID="ContentMultiView" runat="server">
				<asp:View ID="ListView" runat="server">
					<div class="dnnForm rvdsfListContainer">
						<asp:GridView ID="SalesOrderDetailGridView" runat="server" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="SalesOrderDetailID" CssClass="dnnGrid rvdsfSalesOrderDetailGrid" GridLines="None" AllowPaging="True" OnRowDataBound="SalesOrderDetailGridView_RowDataBound" OnRowDeleting="SalesOrderDetailGridView_RowDeleting">
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
								<asp:TemplateField>
									<ItemTemplate>
										<asp:LinkButton ID="DeleteLinkButton" runat="server" CausesValidation="false" CommandName="Delete" OnClientClick="return confirm('Are you sure you want to delete this item?')" CssClass="rvdDeleteGridAction"></asp:LinkButton>
									</ItemTemplate>
								</asp:TemplateField>
								<asp:BoundField DataField="SalesOrderDetailID" HeaderText="ID" SortExpression="SalesOrderDetailID" />
								<asp:TemplateField HeaderText="Image">
									<ItemTemplate>
										<asp:Image ID="ThumbnailImage" runat="server" />
									</ItemTemplate>
								</asp:TemplateField>
								<asp:BoundField DataField="ProductName" HeaderText="Product" SortExpression="ProductName" />
								<asp:BoundField DataField="SKU" HeaderText="SKU" SortExpression="SKU" />
								<asp:BoundField DataField="Status" HeaderText="Order" SortExpression="Status" />
								<asp:BoundField DataField="ShippingStatus" HeaderText="Shipping" SortExpression="ShippingStatus" />
								<asp:BoundField DataField="Quantity" HeaderText="Qty" SortExpression="Quantity" />
								<asp:BoundField DataField="TotalAmount" HeaderText="Amount" SortExpression="TotalAmount" />
							</Columns>
						</asp:GridView>
						<asp:ObjectDataSource ID="SalesOrderDetailObjectDataSource" runat="server" SelectCountMethod="GetCount" SelectMethod="GetAll" SortParameterName="sortExpression" TypeName="Revindex.Dnn.RevindexStorefront.SalesOrderDetailControl" EnablePaging="True">
							<SelectParameters>
								<asp:Parameter Name="sortExpression" Type="String" />
								<asp:Parameter Name="maximumRows" Type="Int32" />
								<asp:Parameter Name="startRowIndex" Type="Int32" />
								<rvd1:UserControlParameter Name="salesOrderID" PropertyName="SalesOrderID" Type="Int32" />
							</SelectParameters>
						</asp:ObjectDataSource>
						<ul class="dnnActions dnnClear">
							<li>
								<asp:HyperLink ID="AddHyperLink" runat="server" Text="Add new" CssClass="dnnPrimaryAction rvdAddNewAction" />
							</li>
							<li>
								<asp:HyperLink ID="ExportViewHyperLink" runat="server" Text="Export view" CssClass="dnnSecondaryAction rvdExportAction" />
							</li>
							<li>
								<asp:HyperLink ID="ExportAllHyperLink" runat="server" Text="Export all" CssClass="dnnSecondaryAction rvdExportAction" />
							</li>
						</ul>
					</div>
				</asp:View>
				<asp:View ID="DetailsView" runat="server">
					<uc1:BackControl ID="QuickBackControl" runat="server" Text="" CssClass="rvdsfBackAction" />
					<h2>Sales order detail:
						<uc1:BreadcrumbControl ID="BreadcrumbControl" runat="server" />
					</h2>
					<div id="SalesOrderDetailDetailsViewTabPanel" class="dnnForm">
						<ul class="dnnAdminTabNav dnnClear">
							<li><a href="#<%= GeneralDetailsViewPanel.ClientID %>">
								<asp:Label ID="GeneralDetailsViewTabLabel" runat="server" Text="General" /></a></li>
							<li id="RecurringDetailsViewListItem" runat="server"><a href="#<%= RecurringDetailsViewPanel.ClientID %>">
								<asp:Label ID="RecurringDetailsViewTabLabel" runat="server" Text="Recurring" /></a></li>
							<li id="CustomFieldDetailsViewListItem" runat="server"><a href="#<%= CustomFieldDetailsViewPanel.ClientID %>">
								<asp:Label ID="CustomFieldDetailsViewTabLabel" runat="server" Text="Custom field" /></a></li>
							<li id="ShippingDetailsViewListItem" runat="server"><a href="#<%= ShippingDetailsViewPanel.ClientID %>">
								<asp:Label ID="ShippingDetailsViewTabLabel" runat="server" Text="Shipping" /></a></li>
							<li id="HandlingDetailsViewListItem" runat="server"><a href="#<%= HandlingDetailsViewPanel.ClientID %>">
								<asp:Label ID="HandlingDetailsViewTabLabel" runat="server" Text="Handling" /></a></li>
							<li id="ResourceDetailsViewListItem" runat="server"><a href="#<%= ResourceDetailsViewPanel.ClientID %>">
								<asp:Label ID="ResourceDetailsViewTabLabel" runat="server" Text="Resource" /></a></li>
							<li id="NotesDetailsViewListItem" runat="server"><a href="#<%= NotesDetailsViewPanel.ClientID %>">
								<asp:Label ID="NotesDetailsViewTabLabel" runat="server" Text="Notes" /></a></li>
						</ul>
						<asp:Panel ID="GeneralDetailsViewPanel" runat="server" CssClass="dnnClear">
							<fieldset>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="SalesOrderDetailIDLabelControl" runat="server" Text="Sales Order Detail ID:" />
									<asp:Label ID="SalesOrderDetailIDLabel" runat="server"></asp:Label>
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="ParentSalesOrderDetailIDLabelControl" runat="server" Text="Parent:" HelpText="The parent sales order detail is only intended to contain child product parts belonging to a bundled product." />
									<asp:DropDownList ID="ParentSalesOrderDetailDropDownList" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ParentSalesOrderDetailDropDownList_SelectedIndexChanged" />
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="StatusLabelControl" runat="server" Text="Order status:" />
									<asp:DropDownList ID="StatusDropDownList" runat="server">
										<asp:ListItem Value="1" style="background-color: HotPink">Pending</asp:ListItem>
										<asp:ListItem Value="9" style="background-color: DeepPink">Quoted</asp:ListItem>
										<asp:ListItem Value="2" style="background-color: Gold">Ordered</asp:ListItem>
										<asp:ListItem Value="3" style="background-color: SkyBlue">Processing</asp:ListItem>
										<asp:ListItem Value="4" style="background-color: YellowGreen">Completed</asp:ListItem>
									</asp:DropDownList>
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="ProductNameLabelControl" runat="server" Text="Product:" CssClass="dnnFormRequired" />
									<asp:RequiredFieldValidator ID="ProductVariantRequiredFieldValidator" runat="server" ControlToValidate="ProductVariantDnnComboBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="SalesOrderDetailDetailsViewControl" InitialValue="">Product is required.</asp:RequiredFieldValidator>
									<asp:RequiredFieldValidator ID="ProductPartRequiredFieldValidator" runat="server" ControlToValidate="ProductPartDropDownList" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="SalesOrderDetailDetailsViewControl" InitialValue="">Product is required.</asp:RequiredFieldValidator>
									<dnn2:DnnComboBox ID="ProductVariantDnnComboBox" runat="server" AllowCustomText="True" CssClass="dnnFormRequired" EnableLoadOnDemand="True" OnItemsRequested="ProductVariantDnnComboBox_ItemsRequested" OnSelectedIndexChanged="ProductVariantDnnComboBox_SelectedIndexChanged" AutoPostBack="True" CausesValidation="False" MaxHeight="200px">
									</dnn2:DnnComboBox>
									<asp:DropDownList ID="ProductPartDropDownList" runat="server" OnSelectedIndexChanged="ProductPartDropDownList_SelectedIndexChanged" AutoPostBack="True"></asp:DropDownList>
									<asp:LinkButton ID="ProductVariantLinkButton" runat="server" CssClass="rvdLinkAction" Text="Edit" OnClick="ProductVariantLinkButton_Click" CausesValidation="False" />
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="SKULabelControl" runat="server" Text="SKU:" />
									<asp:Label ID="SKULabel" runat="server"></asp:Label>
								</div>
								<asp:Panel runat="server" ID="BookingPanel" >
									<div class="dnnFormItem">
										<dnn1:LabelControl ID="BookingStartDateLabelControl" runat="server" Text="Booking start date:" CssClass="dnnFormRequired"/>
										<asp:RequiredFieldValidator ID="BookingStartDateRequiredFieldValidator" runat="server" ControlToValidate="BookingStartDateDnnDateTimePicker" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="SalesOrderDetailDetailsViewControl">Date is required.</asp:RequiredFieldValidator>
										<asp:CustomValidator ID="BookingStartDateCustomValidator" runat="server" Text="The selected date is unavailable." Display="Dynamic" CssClass="dnnFormMessage dnnFormError" ValidationGroup="SalesOrderDetailDetailsViewControl" ControlToValidate="BookingStartDateDnnDateTimePicker" OnServerValidate="BookingStartDateCustomValidator_ServerValidate"></asp:CustomValidator>
										<dnn2:DnnDateTimePicker ID="BookingStartDateDnnDateTimePicker" runat="server" ShowPopupOnFocus="True" DatePopupButton-Visible="False" DateInput-DateFormat="yyyy-MM-dd HH:00" DateInput-EmptyMessage="YYYY-MM-DD HH:00" CssClass="rvdDateTimeInput" OnSelectedDateChanged="BookingStartDateDnnDateTimePicker_SelectedDateChanged" AutoPostBackControl="Both">
										</dnn2:DnnDateTimePicker>
									</div>
									<div class="dnnFormItem">
										<dnn1:LabelControl ID="BookingStopDateLabelControl" runat="server" Text="Booking stop date:" CssClass="dnnFormRequired"/>
										<asp:RequiredFieldValidator ID="BookingStopDateRequiredFieldValidator" runat="server" ControlToValidate="BookingStopDateDnnDateTimePicker" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="SalesOrderDetailDetailsViewControl">Date is required.</asp:RequiredFieldValidator>
										<dnn2:DnnDateTimePicker ID="BookingStopDateDnnDateTimePicker" runat="server" ShowPopupOnFocus="True" DatePopupButton-Visible="False" DateInput-DateFormat="yyyy-MM-dd HH:00" DateInput-EmptyMessage="YYYY-MM-DD HH:00" CssClass="rvdDateTimeInput" OnSelectedDateChanged="BookingStopDateDnnDateTimePicker_SelectedDateChanged" AutoPostBackControl="Both">
										</dnn2:DnnDateTimePicker>
									</div>
								</asp:Panel>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="ProductCostControl" runat="server" Text="Product cost:" />
									<asp:Label ID="ProductCostPriceLabel" runat="server"></asp:Label>
								</div>
								<asp:Panel ID="WarehousePanel" runat="server" CssClass="dnnFormItem">
									<dnn1:LabelControl ID="WarehouseLabelControl" runat="server" Text="Warehouse:" />
									<asp:Label ID="WarehouseLabel" runat="server"></asp:Label>
								</asp:Panel>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="InventoryLabelControl" runat="server" Text="Inventory:" />
									<asp:Label ID="InventoryLabel" runat="server"></asp:Label>
								</div>
							</fieldset>
							<fieldset>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="TotalLabelControl" runat="server" Text="Total amount:" />
									<asp:Label ID="TotalAmountLabel" runat="server"></asp:Label>
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="QuantityLabelControl" runat="server" Text="Quantity:" CssClass="dnnFormRequired" />
									<asp:RequiredFieldValidator ID="QuantityRequiredFieldValidator" runat="server" ControlToValidate="QuantityDnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="SalesOrderDetailDetailsViewControl">Quantity is required.</asp:RequiredFieldValidator>
									<dnn2:DnnNumericTextBox ID="QuantityDnnNumericTextBox" runat="server" Skin="" Value="1" NumberFormat-DecimalDigits="0" NumberFormat-GroupSizes="9" EnableSingleInputRendering="False" CssClass="dnnFormRequired" MinValue="1">
									</dnn2:DnnNumericTextBox>
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="PriceLabelControl" runat="server" Text="Price:" CssClass="dnnFormRequired" HelpText="The unit price for one item." />
									<asp:RequiredFieldValidator ID="PriceRequiredFieldValidator" runat="server" ControlToValidate="PriceDnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="SalesOrderDetailDetailsViewControl">Price is required.</asp:RequiredFieldValidator>
									<dnn2:DnnNumericTextBox ID="PriceDnnNumericTextBox" runat="server" Skin="" Value="1" NumberFormat-DecimalDigits="4" NumberFormat-GroupSizes="9" EnableSingleInputRendering="False" CssClass="dnnFormRequired" MinValue="0">
									</dnn2:DnnNumericTextBox>
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="DiscountAmountLabelControl" runat="server" Text="Discount amount:" HelpText="The discount applied to this sales order detail item. For example, to give a discount of $10.00, you would enter -10.00." CssClass="dnnFormRequired" />
									<asp:RequiredFieldValidator ID="DiscountAmountRequiredFieldValidator" runat="server" ControlToValidate="DiscountAmountDnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="SalesOrderDetailDetailsViewControl">DiscountAmount is required.</asp:RequiredFieldValidator>
									<dnn2:DnnNumericTextBox ID="DiscountAmountDnnNumericTextBox" runat="server" Skin="" Value="0.00" NumberFormat-DecimalDigits="4" NumberFormat-GroupSizes="9" EnableSingleInputRendering="False" CssClass="dnnFormRequired">
									</dnn2:DnnNumericTextBox>
								</div>
							</fieldset>
						</asp:Panel>
						<asp:Panel ID="RecurringDetailsViewPanel" runat="server" CssClass="dnnClear">
							<fieldset>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="RecurringSalesOrderIDLabelControl" runat="server" Text="Recurring sales order ID:" />
									<asp:HyperLink ID="RecurringSalesOrderIDHyperLink" runat="server"></asp:HyperLink>
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="RecurringLabelControl" runat="server" Text="Recurring:" />
									<asp:Label ID="RecurringLabel" runat="server"></asp:Label>
								</div>
							</fieldset>
						</asp:Panel>
						<asp:Panel ID="CustomFieldDetailsViewPanel" runat="server" CssClass="dnnClear">
							<fieldset>
								<uc1:DynamicFormResultEditorControl ID="DynamicFormResultEditor" runat="server" />
							</fieldset>
						</asp:Panel>
						<asp:Panel ID="ShippingDetailsViewPanel" runat="server" CssClass="dnnClear">
							<fieldset>
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
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="RequireShippingLabelControl" runat="server" Text="Require shipping:" />
									<asp:CheckBox ID="RequireShippingCheckBox" runat="server" Enabled="False" />
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="WeightLabelControl" runat="server" Text="Weight ({0}):" />
									<asp:Label ID="WeightLabel" runat="server"></asp:Label>
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="DepthLabelControl" runat="server" Text="Depth ({0}):" />
									<asp:Label ID="DepthLabel" runat="server"></asp:Label>
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="WidthLabelControl" runat="server" Text="Width ({0}):" />
									<asp:Label ID="WidthLabel" runat="server"></asp:Label>
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="HeightLabelControl" runat="server" Text="Height ({0}):" />
									<asp:Label ID="HeightLabel" runat="server"></asp:Label>
								</div>
							</fieldset>
						</asp:Panel>
						<asp:Panel ID="HandlingDetailsViewPanel" runat="server" CssClass="dnnClear">
							<fieldset>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="RequireHandlingLabelControl" runat="server" Text="Require handling:" />
									<asp:CheckBox ID="RequireHandlingCheckBox" runat="server" Enabled="False" />
								</div>
							</fieldset>
						</asp:Panel>
						<asp:Panel ID="ResourceDetailsViewPanel" runat="server" CssClass="dnnClear">
							<fieldset>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="VoucherIssuedLabelControl" runat="server" Text="Vouchers issued:" HelpText="The number of vouchers that have been issued associated with this order detail." />
									<asp:Label ID="VoucherIssuedLabel" runat="server"></asp:Label>
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="RightIssuedLabelControl" runat="server" Text="Rights issued:" HelpText="The number of rights that have been issued associated with this order detail." />
									<asp:Label ID="RightIssuedLabel" runat="server"></asp:Label>
								</div>
							</fieldset>
						</asp:Panel>
						<asp:Panel ID="NotesDetailsViewPanel" runat="server" CssClass="dnnClear">
							<fieldset>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="AdminNotesLabelControl" runat="server" Text="Admin notes:" HelpText="Notes entered here are not visible to the customer." />
									<dnn1:TextEditor ID="AdminNotesTextEditor" runat="server" ChooseRender="False" ChooseMode="False" DefaultMode="RICH" Mode="RICH" HtmlEncode="False" Width="100%" Height="400px" />
								</div>
							</fieldset>
						</asp:Panel>
					</div>
					<div class="dnnForm">
						<ul class="dnnActions">
							<li>
								<asp:LinkButton ID="SaveLinkButton" runat="server" Text="Save" OnClick="SaveLinkButton_Click" ValidationGroup="SalesOrderDetailDetailsViewControl" CssClass="dnnPrimaryAction rvdSaveAction" />
							</li>
							<li>
								<asp:LinkButton ID="SaveAndBackLinkButton" runat="server" Text="Save & return" OnClick="SaveLinkButton_Click" CommandArgument="Back" CssClass="dnnPrimaryAction rvdSaveAction" ValidationGroup="SalesOrderDetailDetailsViewControl" />
							</li>
							<li>
								<uc1:BackControl ID="BackControl1" runat="server" Text="Cancel" />
							</li>
							<li>
								<asp:LinkButton ID="IssueRightLinkButton" runat="server" Text="Issue rights" OnClick="IssueRightLinkButton_Click" ValidationGroup="SalesOrderDetailDetailsViewControl" CssClass="dnnSecondaryAction" />
							</li>
							<li>
								<asp:LinkButton ID="EmailRightReceiptLinkButton" runat="server" Text="Email rights receipt" OnClick="EmailRightReceiptLinkButton_Click" ValidationGroup="SalesOrderDetailDetailsViewControl" CssClass="dnnSecondaryAction rvdEmailAction" />
							</li>
							<li>
								<asp:LinkButton ID="IssueVoucherLinkButton" runat="server" Text="Issue voucher" OnClick="IssueVoucherLinkButton_Click" ValidationGroup="SalesOrderDetailDetailsViewControl" CssClass="dnnSecondaryAction" />
							</li>
							<li>
								<asp:LinkButton ID="EmailVoucherReceiptLinkButton" runat="server" Text="Email voucher receipt" OnClick="EmailVoucherReceiptLinkButton_Click" ValidationGroup="SalesOrderDetailDetailsViewControl" CssClass="dnnSecondaryAction rvdEmailAction" />
							</li>
						</ul>
					</div>
				</asp:View>
			</asp:MultiView>
		</ContentTemplate>
	</asp:UpdatePanel>
</div>
