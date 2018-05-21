<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="RecurringSalesOrderControl.ascx.cs" Inherits="Revindex.Dnn.RevindexStorefront.RecurringSalesOrderControl" %>
<%@ Register Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Src="~/Controls/labelcontrol.ascx" TagName="LabelControl" TagPrefix="dnn1" %>
<%@ Register Src="~/Controls/texteditor.ascx" TagName="TextEditor" TagPrefix="dnn1" %>
<%@ Register Assembly="DotNetNuke.Web.Deprecated" Namespace="DotNetNuke.Web.UI.WebControls" TagPrefix="dnn2" %>
<%@ Register Assembly="Revindex.Web.UI.WebControls" Namespace="Revindex.Web.UI.WebControls" TagPrefix="rvd1" %>
<%@ Register Src="UserAddressDropDownListControl.ascx" TagName="UserAddressDropDownListControl" TagPrefix="uc1" %>
<%@ Register Src="UserPaymentDropDownListControl.ascx" TagName="UserPaymentDropDownListControl" TagPrefix="uc1" %>
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
        	jQuery('#RecurringSalesOrderDetailsViewTabPanel').dnnTabs();
        });
        Sys.WebForms.PageRequestManager.getInstance().add_endRequest(function ()
        {
        	jQuery('#<%= SearchPanel.ClientID %>').dnnPanels();
        	jQuery('#RecurringSalesOrderDetailsViewTabPanel').dnnTabs();
        });
	</script>

</asp:PlaceHolder>
<div>
	<asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
		<ContentTemplate>
			<asp:PlaceHolder ID="MessagePlaceHolder" runat="server" />
			<asp:MultiView ID="ContentMultiView" runat="server">
				<asp:View ID="ListView" runat="server">
					<h2>Recurring sales orders</h2>
					<asp:Panel ID="SearchPanel" runat="server" DefaultButton="SearchLinkButton" CssClass="dnnForm rvdsfSearchContainer">
						<h2 id="SearchFormSectionHead" class="dnnFormSectionHead">
							<a href="#" class="dnnSectionExpanded">Search</a></h2>
						<fieldset class="rvdSplit2">
							<div class="dnnFormItem">
								<dnn1:LabelControl ID="RecurringSalesOrderSearchNextRecurringStartDateLabelControl" runat="server" Text="Next recurring start date:" />
								<dnn2:DnnDatePicker ID="RecurringSalesOrderSearchNextRecurringStartDateDnnDatePicker" runat="server" ShowPopupOnFocus="True" DatePopupButton-Visible="False" DateInput-DateFormat="yyyy-MM-dd" DateInput-EmptyMessage="YYYY-MM-DD">
								</dnn2:DnnDatePicker>
							</div>
							<div class="dnnFormItem">
								<dnn1:LabelControl ID="RecurringSalesOrderSearchNextRecurringStopDateLabelControl" runat="server" Text="Next recurring stop date:" />
								<dnn2:DnnDatePicker ID="RecurringSalesOrderSearchNextRecurringStopDateDnnDatePicker" runat="server" ShowPopupOnFocus="True" DatePopupButton-Visible="False" DateInput-DateFormat="yyyy-MM-dd" DateInput-EmptyMessage="YYYY-MM-DD">
								</dnn2:DnnDatePicker>
							</div>
							<div class="dnnFormItem">
								<dnn1:LabelControl ID="RecurringSalesOrderSearchOriginalSalesOrderIDLabelControl0" runat="server" Text="Original order number:" />
								<asp:TextBox ID="RecurringSalesOrderSearchOriginalSalesOrderIDTextBox" runat="server"></asp:TextBox>
							</div>
							<div class="dnnFormItem">
								<dnn1:LabelControl ID="RecurringSalesOrderSearchUsernameLabelControl" runat="server" Text="Username:" />
								<asp:TextBox ID="RecurringSalesOrderSearchUsernameTextBox" runat="server"></asp:TextBox>
							</div>
							<div class="dnnFormItem">
								<dnn1:LabelControl ID="RecurringSalesOrderSearchStatusLabelControl" runat="server" Text="Status:" />
								<asp:DropDownList ID="RecurringSalesOrderSearchStatusDropDownList" runat="server">
									<asp:ListItem Value="0">Any</asp:ListItem>
									<asp:ListItem Value="1" style="background-color: SkyBlue">Active</asp:ListItem>
									<asp:ListItem Value="2" style="background-color: HotPink">Hold</asp:ListItem>
									<asp:ListItem Value="3" style="background-color: Red">Invalid</asp:ListItem>
									<asp:ListItem Value="4" style="background-color: Khaki">Cancelled</asp:ListItem>
								</asp:DropDownList>
							</div>
							<asp:Panel ID="RecurringSalesOrderSearchSellerPanel" runat="server" CssClass="dnnFormItem">
								<dnn1:LabelControl ID="RecurringSalesOrderSearchSellerLabelControl" runat="server" Text="Seller:" />
								<dnn2:DnnComboBox ID="RecurringSalesOrderSearchSellerDnnComboBox" runat="server" AllowCustomText="True" EnableLoadOnDemand="True" OnItemsRequested="RecurringSalesOrderSearchSellerDnnComboBox_ItemsRequested" AutoPostBack="True" CausesValidation="False" MaxHeight="200px"></dnn2:DnnComboBox>
							</asp:Panel>
							<div class="rvdActions">
								<asp:LinkButton ID="SearchLinkButton" runat="server" Text="Search" OnClick="SearchLinkButton_Click" CausesValidation="false" CssClass="dnnPrimaryAction rvdSearchAction" />
							</div>
						</fieldset>
					</asp:Panel>
					<div class="dnnForm rvdsfListContainer">
						<asp:GridView ID="RecurringSalesOrderGridView" runat="server" AllowSorting="True" AutoGenerateColumns="False" CssClass="dnnGrid" GridLines="None" AllowPaging="True" DataKeyNames="RecurringSalesOrderID" OnRowDataBound="RecurringSalesOrderGridView_RowDataBound" OnRowDeleting="RecurringSalesOrderGridView_RowDeleting">
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
										<asp:LinkButton ID="DeleteLinkButton" runat="server" CommandName="Delete" CausesValidation="false" OnClientClick="return confirm('Are you sure you want to delete this item?')" CssClass="rvdDeleteGridAction"></asp:LinkButton>
									</ItemTemplate>
								</asp:TemplateField>
								<asp:BoundField DataField="NextRecurringDate" HeaderText="Next Recurring Date" SortExpression="NextRecurringDate" />
								<asp:BoundField DataField="Status" HeaderText="Status" SortExpression="Status" />
								<asp:BoundField HeaderText="Product" />
								<asp:BoundField HeaderText="Payment" />
							</Columns>
						</asp:GridView>
						<asp:ObjectDataSource ID="RecurringSalesOrderObjectDataSource" runat="server" EnablePaging="True" SelectCountMethod="GetCount" SelectMethod="GetAll" SortParameterName="sortExpression" TypeName="Revindex.Business.Revindex.Revindex.Storefront.RecurringSalesOrderController" DataObjectTypeName="Revindex.Business.Revindex.Revindex.Storefront.RecurringSalesOrder">
							<SelectParameters>
								<asp:Parameter Name="sortExpression" Type="String" />
								<asp:Parameter Name="maximumRows" Type="Int32" />
								<asp:Parameter Name="startRowIndex" Type="Int32" />
								<rvd1:UserControlParameter Name="portalID" PropertyName="PortalId" Type="Int32" />
								<asp:ControlParameter ControlID="RecurringSalesOrderSearchNextRecurringStartDateDnnDatePicker" Name="nextRecurringStartDate" PropertyName="SelectedDate" Type="DateTime" />
								<asp:ControlParameter ControlID="RecurringSalesOrderSearchNextRecurringStopDateDnnDatePicker" Name="nextRecurringStopDate" PropertyName="SelectedDate" Type="DateTime" />
								<asp:ControlParameter ControlID="RecurringSalesOrderSearchOriginalSalesOrderIDTextBox" Name="salesOrderNumber" PropertyName="Text" Type="String" />
								<asp:ControlParameter ControlID="RecurringSalesOrderSearchUsernameTextBox" Name="username" PropertyName="Text" Type="String" />
								<asp:ControlParameter ControlID="RecurringSalesOrderSearchStatusDropDownList" Name="status" PropertyName="SelectedValue" Type="Int32" />
								<asp:ControlParameter ControlID="RecurringSalesOrderSearchSellerDnnComboBox" Name="sellerID" PropertyName="SelectedValue" Type="Int32" />
							</SelectParameters>
						</asp:ObjectDataSource>
						<ul class="dnnActions dnnClear">
							<li>
								<asp:HyperLink ID="AddHyperLink" runat="server" Text="Add new" CssClass="dnnPrimaryAction rvdAddNewAction" />
							</li>
							<li>
								<asp:HyperLink ID="ExportHyperLink" runat="server" Text="Export" CssClass="dnnSecondaryAction rvdExportAction" />
							</li>
						</ul>
					</div>
				</asp:View>
				<asp:View ID="DetailsView" runat="server">
					<uc1:BackControl ID="QuickBackControl" runat="server" Text="" CssClass="rvdsfBackAction" />
					<h2>Recurring sales order: <uc1:BreadcrumbControl ID="BreadcrumbControl" runat="server" /></h2>
					<div id="RecurringSalesOrderDetailsViewTabPanel" class="dnnForm">
						<ul class="dnnAdminTabNav dnnClear">
							<li><a href="#<%= GeneralDetailsViewPanel.ClientID %>">
								<asp:Label ID="GeneralDetailsViewTabLabel" runat="server" Text="General" /></a></li>
							<li><a href="#<%= ProductDetailsViewPanel.ClientID %>">
								<asp:Label ID="ProductDetailsViewTabLabel" runat="server" Text="Product" /></a></li>
							<li><a href="#<%= CustomFieldDetailsViewPanel.ClientID %>">
								<asp:Label ID="CustomFieldDetailsViewTabLabel" runat="server" Text="Custom field" /></a></li>
							<li><a href="#<%= PaymentDetailsViewPanel.ClientID %>">
								<asp:Label ID="PaymentDetailsViewTabLabel" runat="server" Text="Payment" /></a></li>
							<li><a href="#<%= ShippingDetailsViewPanel.ClientID %>">
								<asp:Label ID="ShippingDetailsViewTabLabel" runat="server" Text="Shipping" /></a></li>
							<li id="NotesDetailsViewListItem" runat="server"><a href="#<%= NotesDetailsViewPanel.ClientID %>">
								<asp:Label ID="NotesDetailsViewTabLabel" runat="server" Text="Notes" /></a></li>
						</ul>
						<asp:Panel ID="GeneralDetailsViewPanel" runat="server" CssClass="dnnClear">
							<fieldset>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="RecurringSalesOrderIDLabelControl" runat="server" Text="Recurring Sales Order ID:" />
									<asp:Label ID="RecurringSalesOrderIDLabel" runat="server"></asp:Label>
								</div>
								<asp:Panel ID="SellerPanel" runat="server" CssClass="dnnFormItem">
									<dnn1:LabelControl ID="SellerLabelControl" runat="server" Text="Seller:" />
									<dnn2:DnnComboBox ID="SellerDnnComboBox" runat="server" AllowCustomText="True" EnableLoadOnDemand="True" OnItemsRequested="SellerDnnComboBox_ItemsRequested" AutoPostBack="True" CausesValidation="False" MaxHeight="200px" OnSelectedIndexChanged="SellerDnnComboBox_SelectedIndexChanged"></dnn2:DnnComboBox>
								</asp:Panel>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="StatusLabelControl" runat="server" Text="Status:" />
									<asp:DropDownList ID="StatusDropDownList" runat="server">
										<asp:ListItem Value="1" style="background-color: SkyBlue">Active</asp:ListItem>
										<asp:ListItem Value="2" style="background-color: HotPink">Hold</asp:ListItem>
										<asp:ListItem Value="3" style="background-color: Red">Invalid</asp:ListItem>
										<asp:ListItem Value="4" style="background-color: Khaki">Cancelled</asp:ListItem>
									</asp:DropDownList>
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="NextRecurringDateLabelControl" runat="server" Text="Next recurring date:" HelpText="Re-order when the date matches the next recurring date." CssClass="dnnFormRequired" />
									<asp:RequiredFieldValidator ID="RequiredFieldValidator11" runat="server" ControlToValidate="NextRecurringDateDnnDatePicker" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="RecurringSalesOrderDetailsViewControl">Next recurring date is required.</asp:RequiredFieldValidator>
									<dnn2:DnnDatePicker ID="NextRecurringDateDnnDatePicker" runat="server" ShowPopupOnFocus="True" DatePopupButton-Visible="False" DateInput-DateFormat="yyyy-MM-dd" DateInput-EmptyMessage="YYYY-MM-DD" CssClass="dnnFormRequired">
									</dnn2:DnnDatePicker>
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="MaxRepeatLabelControl" runat="server" Text="Max repeat:" HelpText="Enter the maximum number of times to repeat or leave field blank to repeat perpetually. E.g. If this is a 12-month program, you should enter 11 to repeat for the remaining 11 times excluding the initial order." />
									<dnn2:DnnNumericTextBox ID="MaxRepeatDnnNumericTextBox" runat="server" Skin="" NumberFormat-DecimalDigits="0" NumberFormat-GroupSizes="9" MinValue="0" EnableSingleInputRendering="False">
									</dnn2:DnnNumericTextBox>
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="RepeatCountLabelControl" runat="server" Text="Repeat count:" HelpText="The number of times this recurring order has repeated so far excluding the initial order." />
									<asp:Label ID="RepeatCountLabel" runat="server" Text=""></asp:Label>
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="UsernameLabelControl" runat="server" Text="Username:" CssClass="dnnFormRequired" />
									<asp:RequiredFieldValidator ID="UsernameRequiredFieldValidator" runat="server" Text="Username is required." ControlToValidate="UsernameTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="RecurringSalesOrderDetailsViewControl"></asp:RequiredFieldValidator>
									<asp:TextBox ID="UsernameTextBox" runat="server" CssClass="dnnFormRequired" OnTextChanged="UsernameTextBox_TextChanged" AutoPostBack="True"></asp:TextBox>
									<asp:HyperLink ID="UsernameHyperLink" runat="server" CssClass="rvdLinkAction" Text="Edit"></asp:HyperLink>
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="UserFirstNameLabelControl" runat="server" Text="User first name:" />
									<asp:Label ID="UserFirstNameLabel" runat="server"></asp:Label>
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="UserLastNameLabelControl" runat="server" Text="User last name:" />
									<asp:Label ID="UserLastNameLabel" runat="server"></asp:Label>
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="UserEmailLabelControl" runat="server" Text="User email:" />
									<asp:HyperLink ID="UserEmailHyperLink" runat="server" />
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="CreateDateLabelControl" runat="server" Text="Create date:" />
									<asp:Label ID="CreateDateLabel" runat="server"></asp:Label>
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="UpdateDateLabelControl" runat="server" Text="Update date:" />
									<asp:Label ID="UpdateDateLabel" runat="server"></asp:Label>
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="OriginalSalesOrderNumberLabelControl" runat="server" Text="Original sales order number:" HelpText="The originating sales order purchased by the customer that lead to the creation of this recurring order." />
									<asp:TextBox ID="OriginalSalesOrderNumberTextBox" runat="server"></asp:TextBox>
									<asp:LinkButton ID="OriginalSalesOrderNumberLinkButton" runat="server" CssClass="rvdLinkAction" Text="Edit" OnClick="OriginalSalesOrderNumberLinkButton_Click" CausesValidation="False" />
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="CultureCodeLabelControl" runat="server" Text="Culture code:" />
									<asp:Label ID="CultureCodeLabel" runat="server"></asp:Label>
								</div>
							</fieldset>
						</asp:Panel>
						<asp:Panel ID="ProductDetailsViewPanel" runat="server" CssClass="dnnClear">
							<fieldset>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="ProductVariantLabelControl" runat="server" Text="Product:" CssClass="dnnFormRequired" />
									<asp:RequiredFieldValidator ID="ProductVariantRequiredFieldValidator" runat="server" ControlToValidate="ProductVariantDnnComboBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="RecurringSalesOrderDetailsViewControl" InitialValue="">Product is required.</asp:RequiredFieldValidator>
									<dnn2:DnnComboBox ID="ProductVariantDnnComboBox" runat="server" AllowCustomText="True" CssClass="dnnFormRequired" EnableLoadOnDemand="True" OnItemsRequested="ProductVariantDnnComboBox_ItemsRequested" OnSelectedIndexChanged="ProductVariantDnnComboBox_SelectedIndexChanged" AutoPostBack="True" CausesValidation="False" MaxHeight="200px">
									</dnn2:DnnComboBox>
									<asp:LinkButton ID="ProductVariantLinkButton" runat="server" CssClass="rvdLinkAction" Text="Edit" OnClick="ProductVariantLinkButton_Click" CausesValidation="False" />
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="RecurringIntervalLabelControl" runat="server" Text="Recurring interval:" />
									<asp:Label ID="RecurringIntervalLabel" runat="server"></asp:Label>
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="QuantityLabelControl" runat="server" Text="Quantity:" CssClass="dnnFormRequired" />
									<asp:RequiredFieldValidator ID="RequiredFieldValidator12" runat="server" ControlToValidate="QuantityDnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="RecurringSalesOrderDetailsViewControl">Quantity is required.</asp:RequiredFieldValidator>
									<asp:RangeValidator ID="RangeValidator4" runat="server" ControlToValidate="QuantityDnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" MaximumValue="2000000000" MinimumValue="1" Type="Integer" ValidationGroup="RecurringSalesOrderDetailsViewControl">Quantity is invalid.</asp:RangeValidator>
									<dnn2:DnnNumericTextBox ID="QuantityDnnNumericTextBox" runat="server" Skin="" EnableSingleInputRendering="False" CssClass="dnnFormRequired" Style="margin-right: 5px" MinValue="1" Value="1" NumberFormat-DecimalDigits="0" NumberFormat-GroupSizes="9">
									</dnn2:DnnNumericTextBox>
								</div>
							</fieldset>
						</asp:Panel>
						<asp:Panel ID="CustomFieldDetailsViewPanel" runat="server" CssClass="dnnClear">
							<fieldset>
								<uc1:DynamicFormResultEditorControl ID="DynamicFormResultEditor" runat="server" />
							</fieldset>
						</asp:Panel>
						<asp:Panel ID="PaymentDetailsViewPanel" runat="server" CssClass="dnnClear">
							<fieldset>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="UserPaymentLabelControl" runat="server" Text="Use payment:" HelpText="Charge against this payment method." />
									<uc1:UserPaymentDropDownListControl ID="UserPaymentDropDownListControl" runat="server" AutoPostBack="True" />
								</div>
							</fieldset>
						</asp:Panel>
						<asp:Panel ID="ShippingDetailsViewPanel" runat="server" CssClass="dnnClear">
							<fieldset>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="ShippingMethodLabelControl" runat="server" Text="Shipping method:" HelpText="Ship recurring order using this shipping method." />
									<asp:DropDownList ID="ShippingMethodDropDownList" runat="server">
									</asp:DropDownList>
								</div>
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
									<asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="ShippingFirstNameTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="ManageRecurringOrderDetailsViewControl">First name is required.</asp:RequiredFieldValidator>
									<asp:TextBox ID="ShippingFirstNameTextBox" runat="server" CssClass="dnnFormRequired" MaxLength="50"></asp:TextBox>
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="ShippingLastNameLabelControl" runat="server" Text="Last name:" CssClass="dnnFormRequired" />
									<asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ControlToValidate="ShippingLastNameTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="ManageRecurringOrderDetailsViewControl">Last name is required.</asp:RequiredFieldValidator>
									<asp:TextBox ID="ShippingLastNameTextBox" runat="server" CssClass="dnnFormRequired" MaxLength="50"></asp:TextBox>
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="ShippingCompanyLabelControl" runat="server" Text="Company:" />
									<asp:TextBox ID="ShippingCompanyTextBox" runat="server" MaxLength="100"></asp:TextBox>
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="ShippingCountryLabelControl" runat="server" Text="Country:" CssClass="dnnFormRequired"/>
									<asp:RequiredFieldValidator ID="CountryRequiredFieldValidator" runat="server" ControlToValidate="ShippingCountryDropDownList" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="ManageRecurringOrderDetailsViewControl">Shipping country is required.</asp:RequiredFieldValidator>
									<asp:DropDownList ID="ShippingCountryDropDownList" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ShippingCountryDropDownList_SelectedIndexChanged">
									</asp:DropDownList>
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="ShippingStreetLabelControl" runat="server" Text="Street:" CssClass="dnnFormRequired" />
									<asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ControlToValidate="ShippingStreetTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="ManageRecurringOrderDetailsViewControl">Street is required.</asp:RequiredFieldValidator>
									<asp:RegularExpressionValidator ID="RegularExpressionValidator5" runat="server" ControlToValidate="ShippingStreetTextBox" ValidationExpression="^[\s\S]{0,200}$" ValidationGroup="ManageRecurringOrderDetailsViewControl" Display="Dynamic">Street is invalid.</asp:RegularExpressionValidator>
									<asp:TextBox ID="ShippingStreetTextBox" runat="server" Rows="2" TextMode="MultiLine" CssClass="dnnFormRequired" MaxLength="200"></asp:TextBox>
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="ShippingCityLabelControl" runat="server" Text="City:" CssClass="dnnFormRequired" />
									<asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ControlToValidate="ShippingCityTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="ManageRecurringOrderDetailsViewControl">City is required.</asp:RequiredFieldValidator>
									<asp:TextBox ID="ShippingCityTextBox" runat="server" CssClass="dnnFormRequired" MaxLength="50"></asp:TextBox>
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="ShippingSubdivisionLabelControl" runat="server" Text="State/Province:" />
									<asp:DropDownList ID="ShippingSubdivisionDropDownList" runat="server" DataTextField="Name" DataValueField="IsoCode">
									</asp:DropDownList>
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="ShippingPostalCodeLabelControl" runat="server" Text="Postal code:" CssClass="dnnFormRequired" />
									<asp:RequiredFieldValidator ID="ShippingPostalCodeRequiredFieldValidator" runat="server" ControlToValidate="ShippingPostalCodeTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="ManageRecurringOrderDetailsViewControl">Postal code is required.</asp:RequiredFieldValidator>
									<asp:TextBox ID="ShippingPostalCodeTextBox" runat="server" MaxLength="10" CssClass="dnnFormRequired"></asp:TextBox>
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="ShippingPhoneLabelControl" runat="server" Text="Phone:" CssClass="dnnFormRequired" />
									<asp:RequiredFieldValidator ID="RequiredFieldValidator10" runat="server" ControlToValidate="ShippingPhoneTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="ManageRecurringOrderDetailsViewControl">Phone is required.</asp:RequiredFieldValidator>
									<asp:TextBox ID="ShippingPhoneTextBox" runat="server" CssClass="dnnFormRequired" MaxLength="50"></asp:TextBox>
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="ShippingEmailLabelControl" runat="server" Text="Email:" />
									<asp:RegularExpressionValidator ID="RegularExpressionValidator4" runat="server" ControlToValidate="ShippingEmailTextBox" CssClass="dnnFormMessage dnnFormError" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ValidationGroup="ManageRecurringOrderDetailsViewControl">Email is invalid.</asp:RegularExpressionValidator>
									<asp:TextBox ID="ShippingEmailTextBox" runat="server" MaxLength="256"></asp:TextBox>
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
								<asp:LinkButton ID="SaveLinkButton" runat="server" Text="Save" OnClick="SaveLinkButton_Click" CssClass="dnnPrimaryAction rvdSaveAction" ValidationGroup="RecurringSalesOrderDetailsViewControl" />
							</li>
							<li>
								<asp:LinkButton ID="SaveAndBackLinkButton" runat="server" Text="Save & return" OnClick="SaveLinkButton_Click" CommandArgument="Back" CssClass="dnnPrimaryAction rvdSaveAction" ValidationGroup="RecurringSalesOrderDetailsViewControl" />
							</li>
							<li>
								<uc1:BackControl ID="BackControl1" runat="server" Text="Cancel" />
							</li>
							<li>
								<asp:LinkButton ID="EmailRecurringSalesOrderReminderLinkButton" runat="server" Text="Email reminder" OnClick="EmailRecurringSalesOrderReminderLinkButton_Click" CssClass="dnnSecondaryAction rvdEmailAction" CausesValidation="false" ValidationGroup="RecurringSalesOrderDetailsViewControl" />
							</li>
						</ul>
					</div>
				</asp:View>
			</asp:MultiView>
		</ContentTemplate>
	</asp:UpdatePanel>
</div>
