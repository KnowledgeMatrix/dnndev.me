<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Display.ascx.cs" Inherits="Revindex.Dnn.RevindexStorefront.Portals._default.Display.Checkout.Standard22.Display" %>
<%@ Register Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI.WebControls" TagPrefix="asp" %>
<%@ Register Src="~/Controls/labelcontrol.ascx" TagName="LabelControl" TagPrefix="dnn1" %>
<%@ Register Assembly="DotNetNuke.Web.Deprecated" Namespace="DotNetNuke.Web.UI.WebControls" TagPrefix="dnn2" %>
<%@ Register Src="../../../../../UserAddressDropDownListControl.ascx" TagName="UserAddressDropDownListControl" TagPrefix="uc1" %>
<asp:Panel ID="CheckoutPanel" runat="server" CssClass="rvdsfCheckoutContainer">
	<asp:UpdateProgress ID="UpdateProgress" runat="server">
		<ProgressTemplate>
			<div class="rvdUpdateProgressContainer">
				<asp:Image ID="UpdateProgressImage" runat="server" ImageUrl="~/Images/Loading.gif" CssClass="rvdUpdateProgress" />
			</div>
		</ProgressTemplate>
	</asp:UpdateProgress>
	<asp:UpdatePanel ID="UpdatePanel1" runat="server">
		<Triggers>
			<asp:PostBackTrigger ControlID="ReviewOrderLinkButton" />
			<asp:PostBackTrigger ControlID="ViewBillingLinkButton" />
			<asp:PostBackTrigger ControlID="PlaceOrderLinkButton" />
		</Triggers>
		<ContentTemplate>
			<asp:PlaceHolder ID="MessagePlaceHolder" runat="server"></asp:PlaceHolder>
			<div class="rvdsfCheckoutBreadcrumb">
				<asp:LinkButton ID="ViewCartNavigationLinkButton" runat="server" CausesValidation="False" OnClick="ViewCartNavigationLinkButton_Click" resourcekey="ViewCartNavigationLinkButton"></asp:LinkButton>
				<span class="rvdsfCheckoutBreadcrumbSeparator"></span>
				<asp:LinkButton ID="BillingAndShippingNavigationLinkButton" runat="server" CausesValidation="False" OnClick="BillingAndShippingNavigationLinkButton_Click" Enabled="False" resourcekey="BillingAndShippingNavigationLinkButton"></asp:LinkButton>
				<span class="rvdsfCheckoutBreadcrumbSeparator"></span>
				<asp:LinkButton ID="PlaceOrderNavigationLinkButton" runat="server" CausesValidation="False" Enabled="False" resourcekey="PlaceOrderNavigationLinkButton"></asp:LinkButton>
				<span class="rvdsfCheckoutBreadcrumbSeparator"></span>
				<asp:LinkButton ID="ConfirmationNavigationLinkButton" runat="server" CausesValidation="False" Enabled="False" resourcekey="ConfirmationNavigationLinkButton"></asp:LinkButton>
			</div>
			<asp:Panel ID="BillingAndShippingPanel" runat="server" CssClass="dnnForm">
				<div class="rvdsfCheckoutBillingAndShippingContainer">
					<asp:Panel ID="AccountSectionPanel" runat="server">
						<h2 class="dnnFormSectionHead">
							<asp:Label ID="AccountSectionLabel" runat="server" resourcekey="AccountSectionLabel"></asp:Label>
						</h2>
						<p>
							<asp:Label ID="AccountAnonymousWarningLabel" runat="server" resourcekey="AccountAnonymousWarningLabel"></asp:Label>
						</p>
						<div class="rvdsfCheckoutAccountActions">
							<asp:HyperLink ID="AccountRegistrationHyperLink" runat="server" resourcekey="AccountRegistrationHyperLink" CssClass="dnnPrimaryAction rvdRegisterAction" />
							<asp:HyperLink ID="AccountLoginHyperLink" runat="server" resourcekey="AccountLoginHyperLink" CssClass="dnnPrimaryAction rvdLoginAction" />
						</div>
					</asp:Panel>
					<asp:Panel ID="BillingSectionPanel" runat="server">
						<h2 class="dnnFormSectionHead">
							<asp:Label ID="BillingSectionLabel" runat="server" resourcekey="BillingSectionLabel"></asp:Label>
						</h2>
						<fieldset>
							<asp:Panel ID="BilingUserAddressBookPanel" runat="server" CssClass="dnnFormItem">
								<dnn1:LabelControl ID="BillingUserAddressLabelControl" runat="server" />
								<uc1:UserAddressDropDownListControl ID="BillingUserAddressDropDownListControl" runat="server" AutoPostBack="True" />
							</asp:Panel>
							<div class="dnnFormItem">
								<dnn1:LabelControl ID="BillingFirstNameLabelControl" runat="server" CssClass="dnnFormRequired" />
								<asp:RequiredFieldValidator ID="BillingFirstNameRequiredFieldValidator" runat="server" ControlToValidate="BillingFirstNameTextBox" Display="Dynamic" CssClass="dnnFormMessage dnnFormError" resourcekey="BillingFirstNameRequiredFieldValidator" ValidationGroup="CheckoutDisplayTemplate"></asp:RequiredFieldValidator>
								<asp:TextBox ID="BillingFirstNameTextBox" runat="server" MaxLength="50" CssClass="dnnFormRequired"></asp:TextBox>
							</div>
							<div class="dnnFormItem">
								<dnn1:LabelControl ID="BillingLastNameLabelControl" runat="server" CssClass="dnnFormRequired" />
								<asp:RequiredFieldValidator ID="BillingLastNameRequiredFieldValidator" resourcekey="BillingLastNameRequiredFieldValidator" runat="server" ControlToValidate="BillingLastNameTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="CheckoutDisplayTemplate"></asp:RequiredFieldValidator>
								<asp:TextBox ID="BillingLastNameTextBox" runat="server" MaxLength="50" CssClass="dnnFormRequired"></asp:TextBox>
							</div>
							<div class="dnnFormItem">
								<dnn1:LabelControl ID="BillingCompanyLabelControl" runat="server" />
								<asp:TextBox ID="BillingCompanyTextBox" runat="server" MaxLength="100"></asp:TextBox>
							</div>
							<div class="dnnFormItem">
								<dnn1:LabelControl ID="BillingCountryLabelControl" runat="server" CssClass="dnnFormRequired" />
								<asp:RequiredFieldValidator ID="BillingCountryRequiredFieldValidator" resourcekey="BillingCountryRequiredFieldValidator" runat="server" ControlToValidate="BillingCountryDropDownList" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="CheckoutDisplayTemplate"></asp:RequiredFieldValidator>
								<asp:DropDownList ID="BillingCountryDropDownList" runat="server" AutoPostBack="True" OnSelectedIndexChanged="BillingCountryDropDownList_SelectedIndexChanged" CssClass="dnnFormRequired">
								</asp:DropDownList>
							</div>
							<div class="dnnFormItem">
								<dnn1:LabelControl ID="BillingStreetLabelControl" runat="server" CssClass="dnnFormRequired" />
								<asp:RequiredFieldValidator ID="BillingStreetRequiredFieldValidator" resourcekey="BillingStreetRequiredFieldValidator" runat="server" ControlToValidate="BillingStreetTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="CheckoutDisplayTemplate"></asp:RequiredFieldValidator>
								<asp:RegularExpressionValidator ID="BillingStreetRegularExpressionValidator" resourcekey="BillingStreetRegularExpressionValidator" runat="server" ControlToValidate="BillingStreetTextBox" ValidationExpression="^[\s\S]{0,200}$" ValidationGroup="CheckoutDisplayTemplate" CssClass="dnnFormMessage dnnFormError" Display="Dynamic"></asp:RegularExpressionValidator>
								<asp:TextBox ID="BillingStreetTextBox" runat="server" Rows="2" TextMode="MultiLine" Wrap="False" MaxLength="200" CssClass="dnnFormRequired"></asp:TextBox>
							</div>
							<div class="dnnFormItem">
								<dnn1:LabelControl ID="BillingCityLabelControl" runat="server" CssClass="dnnFormRequired" />
								<asp:RequiredFieldValidator ID="BillingCityRequiredFieldValidator" resourcekey="BillingCityRequiredFieldValidator" runat="server" ControlToValidate="BillingCityTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="CheckoutDisplayTemplate"></asp:RequiredFieldValidator>
								<asp:TextBox ID="BillingCityTextBox" runat="server" MaxLength="50" CssClass="dnnFormRequired"></asp:TextBox>
							</div>
							<div class="dnnFormItem">
								<dnn1:LabelControl ID="BillingSubdivisionLabelControl" runat="server" />
								<asp:DropDownList ID="BillingSubdivisionDropDownList" runat="server" OnSelectedIndexChanged="BillingSubdivisionDropDownList_SelectedIndexChanged" AutoPostBack="True">
								</asp:DropDownList>
							</div>
							<div class="dnnFormItem">
								<dnn1:LabelControl ID="BillingPostalCodeLabelControl" runat="server" CssClass="dnnFormRequired" />
								<asp:RequiredFieldValidator ID="BillingPostalCodeRequiredFieldValidator" resourcekey="BillingPostalCodeRequiredFieldValidator" runat="server" ControlToValidate="BillingPostalCodeTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="CheckoutDisplayTemplate"></asp:RequiredFieldValidator>
								<asp:TextBox ID="BillingPostalCodeTextBox" runat="server" MaxLength="10" AutoPostBack="True" OnTextChanged="BillingPostalCodeTextBox_TextChanged" CssClass="dnnFormRequired"></asp:TextBox>
							</div>
							<div class="dnnFormItem">
								<dnn1:LabelControl ID="BillingPhoneLabelControl" runat="server" CssClass="dnnFormRequired" />
								<asp:RequiredFieldValidator ID="BillingPhoneRequiredFieldValidator" resourcekey="BillingPhoneRequiredFieldValidator" runat="server" ControlToValidate="BillingPhoneTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="CheckoutDisplayTemplate"></asp:RequiredFieldValidator>
								<asp:TextBox ID="BillingPhoneTextBox" runat="server" MaxLength="50" CssClass="dnnFormRequired"></asp:TextBox>
							</div>
							<div class="dnnFormItem">
								<dnn1:LabelControl ID="BillingEmailLabelControl" runat="server" CssClass="dnnFormRequired" />
								<asp:RequiredFieldValidator ID="BillingEmailRequiredFieldValidator" runat="server" ControlToValidate="BillingEmailTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" resourcekey="BillingEmailRequiredFieldValidator" ValidationGroup="CheckoutDisplayTemplate"></asp:RequiredFieldValidator>
								<asp:RegularExpressionValidator ID="BillingEmailRegularExpressionValidator" runat="server" ControlToValidate="BillingEmailTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" resourcekey="BillingEmailRegularExpressionValidator" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ValidationGroup="CheckoutDisplayTemplate"></asp:RegularExpressionValidator>
								<asp:TextBox ID="BillingEmailTextBox" runat="server" MaxLength="256" CssClass="dnnFormRequired"></asp:TextBox>
							</div>
							<asp:Panel ID="BusinessTaxNumberPanel" runat="server" CssClass="dnnFormItem">
								<dnn1:LabelControl ID="BusinessTaxNumberLabelControl" runat="server" />
								<asp:TextBox ID="BusinessTaxNumberTextBox" runat="server"></asp:TextBox>
							</asp:Panel>
							<asp:Panel ID="SaveBillingUserAddressPanel" runat="server" CssClass="dnnFormItem">
								<dnn1:LabelControl ID="SaveBillingUserAddressLabelControl" runat="server" />
								<asp:CheckBox ID="SaveBillingUserAddressCheckBox" runat="server" Checked="True" />
							</asp:Panel>
							<asp:Panel ID="UpdateUserProfilePanel" runat="server" CssClass="dnnFormItem">
								<dnn1:LabelControl ID="UpdateUserProfileLabelControl" runat="server" />
								<asp:CheckBox ID="UpdateUserProfileCheckBox" runat="server" Checked="True" />
							</asp:Panel>
						</fieldset>
					</asp:Panel>
					<asp:Panel ID="ShippingSectionPanel" runat="server">
						<h2 class="dnnFormSectionHead">
							<asp:Label ID="ShippingSectionLabel" runat="server" resourcekey="ShippingSectionLabel"></asp:Label>
						</h2>
						<fieldset>
							<div class="dnnFormItem">
								<dnn1:LabelControl ID="SameAsBillingLabelControl" runat="server" />
								<asp:CheckBox ID="SameAsBillingCheckBox" runat="server" AutoPostBack="True" Checked="True" OnCheckedChanged="SameAsBillingCheckBox_CheckedChanged" />
							</div>
							<asp:Panel ID="ShippingAddressPanel" runat="server" Visible="False">
								<asp:Panel ID="ShippingUserAddressBookPanel" runat="server" CssClass="dnnFormItem">
									<dnn1:LabelControl ID="ShippingUserAddressLabelControl" runat="server" />
									<uc1:UserAddressDropDownListControl ID="ShippingUserAddressDropDownListControl" runat="server" AutoPostBack="True" />
								</asp:Panel>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="ShippingFirstNameLabelControl" runat="server" CssClass="dnnFormRequired" />
									<asp:RequiredFieldValidator ID="ShippingFirstNameRequiredFieldValidator" runat="server" ControlToValidate="ShippingFirstNameTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" resourcekey="ShippingFirstNameRequiredFieldValidator" ValidationGroup="CheckoutDisplayTemplate"></asp:RequiredFieldValidator>
									<asp:TextBox ID="ShippingFirstNameTextBox" runat="server" MaxLength="50" CssClass="dnnFormRequired"></asp:TextBox>
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="ShippingLastNameLabelControl" runat="server" CssClass="dnnFormRequired" />
									<asp:RequiredFieldValidator ID="ShippingLastNameRequiredFieldValidator" resourcekey="ShippingLastNameRequiredFieldValidator" runat="server" ControlToValidate="ShippingLastNameTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="CheckoutDisplayTemplate"></asp:RequiredFieldValidator>
									<asp:TextBox ID="ShippingLastNameTextBox" runat="server" MaxLength="50" CssClass="dnnFormRequired"></asp:TextBox>
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="ShippingCompanyLabelControl" runat="server" />
									<asp:TextBox ID="ShippingCompanyTextBox" runat="server" MaxLength="100"></asp:TextBox>
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="ShippingCountryLabelControl" runat="server" CssClass="dnnFormRequired" />
									<asp:RequiredFieldValidator ID="ShippingCountryRequiredFieldValidator" resourcekey="ShippingCountryRequiredFieldValidator" runat="server" ControlToValidate="ShippingCountryDropDownList" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="CheckoutDisplayTemplate"></asp:RequiredFieldValidator>
									<asp:DropDownList ID="ShippingCountryDropDownList" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ShippingCountryDropDownList_SelectedIndexChanged" CssClass="dnnFormRequired">
									</asp:DropDownList>
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="ShippingStreetLabelControl" runat="server" CssClass="dnnFormRequired" />
									<asp:RequiredFieldValidator ID="ShippingStreetRequiredFieldValidator" resourcekey="ShippingStreetRequiredFieldValidator" runat="server" ControlToValidate="ShippingStreetTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="CheckoutDisplayTemplate"></asp:RequiredFieldValidator><asp:RegularExpressionValidator ID="ShippingStreetRegularExpressionValidator" resourcekey="ShippingStreetRegularExpressionValidator" runat="server" ControlToValidate="ShippingStreetTextBox" ValidationExpression="^[\s\S]{0,200}$" ValidationGroup="CheckoutDisplayTemplate" CssClass="dnnFormMessage dnnFormError" Display="Dynamic"></asp:RegularExpressionValidator>
									<asp:TextBox ID="ShippingStreetTextBox" runat="server" MaxLength="200" Rows="2" TextMode="MultiLine" Wrap="False" CssClass="dnnFormRequired"></asp:TextBox>
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="ShippingCityLabelControl" runat="server" CssClass="dnnFormRequired" />
									<asp:RequiredFieldValidator ID="ShippingCityRequiredFieldValidator" resourcekey="ShippingCityRequiredFieldValidator" runat="server" ControlToValidate="ShippingCityTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="CheckoutDisplayTemplate"></asp:RequiredFieldValidator>
									<asp:TextBox ID="ShippingCityTextBox" runat="server" MaxLength="50" CssClass="dnnFormRequired"></asp:TextBox>
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="ShippingSubdivisionLabelControl" runat="server" />
									<asp:DropDownList ID="ShippingSubdivisionDropDownList" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ShippingSubdivisionDropDownList_SelectedIndexChanged">
									</asp:DropDownList>
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="ShippingPostalCodeLabelControl" runat="server" CssClass="dnnFormRequired" />
									<asp:RequiredFieldValidator ID="ShippingPostalCodeRequiredFieldValidator" runat="server" resourcekey="ShippingPostalCodeRequiredFieldValidator" ControlToValidate="ShippingPostalCodeTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="CheckoutDisplayTemplate"></asp:RequiredFieldValidator>
									<asp:TextBox ID="ShippingPostalCodeTextBox" runat="server" MaxLength="10" AutoPostBack="True" OnTextChanged="ShippingPostalCodeTextBox_TextChanged" CssClass="dnnFormRequired"></asp:TextBox>
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="ShippingPhoneLabelControl" runat="server" CssClass="dnnFormRequired" />
									<asp:RequiredFieldValidator ID="ShippingPhoneRequiredFieldValidator" resourcekey="ShippingPhoneRequiredFieldValidator" runat="server" ControlToValidate="ShippingPhoneTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="CheckoutDisplayTemplate"></asp:RequiredFieldValidator>
									<asp:TextBox ID="ShippingPhoneTextBox" runat="server" MaxLength="50" CssClass="dnnFormRequired"></asp:TextBox>
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="ShippingEmailLabelControl" runat="server" CssClass="dnnFormRequired" />
									<asp:RegularExpressionValidator ID="ShippingEmailRegularExpressionValidator" resourcekey="ShippingEmailRegularExpressionValidator" runat="server" ControlToValidate="ShippingEmailTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ValidationGroup="CheckoutDisplayTemplate"></asp:RegularExpressionValidator>
									<asp:TextBox ID="ShippingEmailTextBox" runat="server" MaxLength="256" CssClass="dnnFormRequired"></asp:TextBox>
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="SaveShippingUserAddressLabelControl" runat="server" />
									<asp:CheckBox ID="SaveShippingUserAddressCheckBox" runat="server" Checked="True" />
								</div>
							</asp:Panel>
							<asp:Panel ID="ShippingMethodSelectionPanel" runat="server" CssClass="dnnFormItem rvdsfShippingMethodSelectionContainer">
								<dnn1:LabelControl ID="ShippingMethodLabelControl" runat="server" />
								<div class="rvdFormSubContainer">
									<asp:Repeater ID="ShippingMethodRepeater" runat="server">
										<ItemTemplate>
											<div>
												<% if (ShippingMethodRepeater.Items.Count > 1)
			   { %>
												<h3 class="dnnFormSectionHead"><%# Eval("SellerName") %></h3>
												<asp:BulletedList ID="ShippingMethodProductBulletedList" runat="server" DataSource='<%# Eval("SalesOrderDetails") %>' DataTextField="ProductName" CssClass="rvdsfShippingMethodProductList"></asp:BulletedList>
												<% } %>
												<asp:RadioButtonList ID="ShippingMethodRadioButtonList" runat="server" AutoPostBack="True" RepeatLayout="Flow" CssClass="dnnFormRadioButtons" DataSource='<%# Eval("ShippingMethods") %>' DataTextField="Name" DataValueField="ShippingMethodID" OnDataBound="ShippingMethodRadioButtonList_DataBound"></asp:RadioButtonList>
											</div>
										</ItemTemplate>
									</asp:Repeater>
								</div>
							</asp:Panel>
						</fieldset>
					</asp:Panel>
					<asp:Panel ID="OtherInformationPanel" runat="server">
						<h2 class="dnnFormSectionHead">
							<asp:Label ID="OtherSectionLabel" runat="server" resourcekey="OtherSectionLabel"></asp:Label>
						</h2>
						<fieldset>
							<asp:Panel ID="CouponPanel" runat="server" CssClass="dnnFormItem">
								<dnn1:LabelControl ID="CouponLabelControl" runat="server" />
								<asp:CustomValidator ID="CouponCodeCustomValidator" runat="server" OnServerValidate="CouponCodeCustomValidator_ServerValidate" ControlToValidate="CouponCodeTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="CouponCheckoutDisplayTemplate" />
								<asp:TextBox ID="CouponCodeTextBox" runat="server" MaxLength="100"></asp:TextBox>
								<asp:LinkButton ID="AddCouponLinkButton" runat="server" OnClick="AddCouponLinkButton_Click" ValidationGroup="CouponCheckoutDisplayTemplate" CssClass="rvdAddNewGridAction" CausesValidation="True" />
								<asp:DataList ID="CouponDataList" CssClass="rvdsfCheckoutCouponList" runat="server" RepeatDirection="Horizontal" RepeatLayout="Flow">
									<ItemTemplate>
										<asp:LinkButton ID="DeleteCouponLinkButton" runat="server" CommandArgument='<%# Eval("Code") %>' OnClick="DeleteCouponLinkButton_Click" CausesValidation="False" CssClass="rvdDeleteGridAction" resourcekey="DeleteCouponLinkButton" />
										<asp:Label ID="CouponLabel" runat="server" Text='<%# Eval("Code") %>' />
									</ItemTemplate>
								</asp:DataList>
							</asp:Panel>
							<asp:ListView ID="DynamicFormListView" runat="server" GroupItemCount="1" OnItemCreated="DynamicFormListView_ItemCreated">
								<LayoutTemplate>
									<div runat="server" id="groupPlaceholder" />
								</LayoutTemplate>
								<GroupTemplate>
									<div runat="server" id="itemPlaceholder" />
								</GroupTemplate>
								<ItemTemplate>
									<div class="dnnFormItem rvdsfDynamicFormItem">
										<asp:PlaceHolder ID="LabelDynamicFormPlaceHolder" runat="server"></asp:PlaceHolder>
										<asp:PlaceHolder ID="ValidatorDynamicFormPlaceHolder" runat="server"></asp:PlaceHolder>
										<asp:PlaceHolder ID="InputControlDynamicFormPlaceHolder" runat="server"></asp:PlaceHolder>
									</div>
								</ItemTemplate>
							</asp:ListView>
							<asp:PlaceHolder ID="DynamicFormPlaceHolder" runat="server"></asp:PlaceHolder>
						</fieldset>
					</asp:Panel>
				</div>
				<div class="rvdsfCheckoutActions">
					<asp:LinkButton ID="ViewCartLinkButton" runat="server" OnClick="ViewCartLinkButton_Click" resourcekey="ViewCartLinkButton" CausesValidation="False" CssClass="dnnPrimaryAction rvdsfViewCartAction" />
					<asp:LinkButton ID="ReviewOrderLinkButton" runat="server" OnClick="ReviewOrderLinkButton_Click" ValidationGroup="CheckoutDisplayTemplate" resourcekey="ReviewOrderLinkButton" CssClass="dnnPrimaryAction rvdsfReviewOrderAction" />
				</div>
			</asp:Panel>
			<asp:Panel ID="PlaceOrderPanel" runat="server" CssClass="dnnForm dnnClear">

				<script type="text/javascript">
					// Move review order panel to aside in single page checkout mode
					Sys.Application.add_load(function pageLoad(sender, args)
					{
						var checkoutPanel = $("div[id$='CheckoutPanel']");
						var reviewOrderPanel = $("div[id$='ReviewOrderPanel']");

						if (checkoutPanel.hasClass("rvdsfCheckoutPageViewModeSingle"))
						{
							reviewOrderPanel.insertAfter(".rvdsfCheckoutBillingAndShippingContainer");

							// Lock review order panel on scroll if floated and if content fits within browser window
							if (reviewOrderPanel.height() < $(window).height() && reviewOrderPanel.css("position") == "relative" && (reviewOrderPanel.css("float") == "right" || reviewOrderPanel.css("float") == "left"))
								Revindex.Web.ScrollLock(reviewOrderPanel, checkoutPanel);
						}
					});
				</script>
				<asp:Panel ID="ReviewOrderPanel" runat="server" CssClass="rvdsfCheckoutReviewOrderContainer">
					<h2 class="dnnFormSectionHead">
						<asp:Label ID="ReviewOrderSectionLabel" runat="server" resourcekey="ReviewOrderSectionLabel"></asp:Label>
					</h2>
					<asp:GridView ID="SalesOrderDetailGridView" CssClass="dnnGrid rvdsfSalesOrderDetailGrid" GridLines="None" runat="server" AutoGenerateColumns="False" DataKeyNames="SalesOrderDetailID">
						<HeaderStyle CssClass="dnnGridHeader" />
						<RowStyle CssClass="dnnGridItem" />
						<AlternatingRowStyle CssClass="dnnGridAltItem" />
						<SelectedRowStyle CssClass="dnnGridSelectedItem" />
						<FooterStyle CssClass="dnnGridFooter" />
						<PagerStyle CssClass="dnnGridPager" />
						<Columns>
							<asp:TemplateField HeaderText="ItemHeaderSalesOrderDetailGridView">
								<ItemTemplate>
									<asp:HyperLink ID="GalleryHyperLink" runat="server" NavigateUrl='<%# Eval("ProductUrl") %>' CssClass="rvdsfCartGalleryThumbnail">
										<asp:Image ID="GalleryImage" AlternateText='<%# Eval("GalleryImage_AlternateText") %>' ImageUrl='<%# Eval("GalleryImage_ImageUrl") %>' Visible='<%# Convert.ToBoolean(Eval("GalleryImage_Visible")) %>' runat="server" />
									</asp:HyperLink>
									<div class="rvdsfCartProduct">
										<asp:HyperLink ID="ProductNameHyperLink" runat="server" NavigateUrl='<%# Eval("ProductUrl") %>' Text='<%# Eval("ProductName") %>'></asp:HyperLink>
										<dl id="BookingDescriptionList" class="rvdsfBookingDates" runat="server" visible='<%# Convert.ToBoolean(Eval("Booking_Visible")) %>'>
											<dt><asp:Label ID="BookingStartDateLabel" runat="server" resourcekey="BookingStartDateLabel" /></dt>
											<dd><%# Eval("BookingStartDate") %></dd>
											<dt><asp:Label ID="BookingStopDateLabel" runat="server" resourcekey="BookingStopDateLabel" /></dt>
											<dd><%# Eval("BookingStopDate") %></dd>
										</dl>
										<dl class="rvdsfProductParts">
											<asp:Literal ID="ProductPartLiteral" runat="server" Text='<%# Eval("ProductPart") %>' />
										</dl>
										<dl class="rvdsfDynamicFormResults">
											<asp:Literal ID="DynamicFormResultLiteral" runat="server" Text='<%# Eval("DynamicFormResult") %>' />
										</dl>
									</div>
								</ItemTemplate>
							</asp:TemplateField>
							<asp:BoundField DataField="Price" HeaderText="PriceHeaderSalesOrderDetailGridView" />
							<asp:BoundField DataField="Quantity" HeaderText="QuantityHeaderSalesOrderDetailGridView" />
							<asp:BoundField DataField="Amount" HeaderText="AmountHeaderSalesOrderDetailGridView" />
						</Columns>
					</asp:GridView>
					<dl class="rvdsfDynamicFormResults">
						<asp:Literal ID="CheckoutDynamicFormResultLiteral" runat="server" />
					</dl>
					<asp:Panel ID="TotalAmountPanel" runat="server" CssClass="rvdsfCartTotalAmountContainer">
						<div class="dnnFormItem rvdsfTotalSalesOrderDetailDiscountAmount">
							<dnn1:LabelControl ID="TotalSalesOrderDetailDiscountLabelControl" runat="server" />
							<asp:Label ID="TotalSalesOrderDetailDiscountLabel" runat="server"></asp:Label>
						</div>
						<div class="dnnFormItem rvdsfSubTotalAmount">
							<dnn1:LabelControl ID="SubTotalLabelControl" runat="server" />
							<asp:Label ID="SubTotalLabel" runat="server"></asp:Label>
						</div>
						<div class="dnnFormItem rvdsfTotalShippingAmount">
							<dnn1:LabelControl ID="ShippingLabelControl" runat="server" />
							<asp:Label ID="ShippingLabel" runat="server"></asp:Label>
						</div>
						<div class="dnnFormItem rvdsfTotalHandlingAmount">
							<dnn1:LabelControl ID="HandlingLabelControl" runat="server" />
							<asp:Label ID="HandlingLabel" runat="server"></asp:Label>
						</div>
						<div class="dnnFormItem rvdsfTotalTaxesAmount">
							<dnn1:LabelControl ID="TaxesLabelControl" runat="server" />
							<asp:Label ID="TaxesLabel" runat="server"></asp:Label>
						</div>
						<div class="dnnFormItem rvdsfTotalAmount">
							<dnn1:LabelControl ID="TotalLabelControl" runat="server" />
							<asp:Label ID="TotalLabel" runat="server"></asp:Label>
						</div>
						<div class="dnnFormItem rvdsfTotalPaymentAmount">
							<dnn1:LabelControl ID="TotalPaymentLabelControl" runat="server" />
							<asp:Label ID="TotalPaymentLabel" runat="server"></asp:Label>
						</div>
						<div class="dnnFormItem rvdsfBalanceDueAmount">
							<dnn1:LabelControl ID="BalanceDueLabelControl" runat="server" />
							<asp:Label ID="BalanceDueLabel" runat="server"></asp:Label>
						</div>
						<asp:Panel ID="TotalDiscountPanel" runat="server" CssClass="dnnFormItem rvdsfTotalDiscountAmount">
							<dnn1:LabelControl ID="TotalDiscountLabelControl" runat="server" />
							<asp:Label ID="TotalDiscountLabel" runat="server"></asp:Label>
						</asp:Panel>
						<asp:Panel ID="RewardsPointQualifiedPanel" runat="server" CssClass="dnnFormItem rvdsfRewardsPointAmount">
							<dnn1:LabelControl ID="RewardsPointQualifiedLabelControl" runat="server" />
							<asp:Label ID="RewardsPointQualifiedLabel" runat="server"></asp:Label>
						</asp:Panel>
					</asp:Panel>
					<div class="rvdsfCheckoutActions">
						<asp:LinkButton ID="EditCartLinkButton" runat="server" OnClick="EditCartLinkButton_Click" resourcekey="EditCartLinkButton" CausesValidation="False" CssClass="dnnSecondaryAction rvdsfEditCartAction" />
					</div>
				</asp:Panel>
				<asp:Panel ID="PaymentPanel" runat="server" CssClass="rvdsfCheckoutPaymentContainer">
					<h2 class="dnnFormSectionHead">
						<asp:Label ID="PaymentSectionLabel" runat="server" resourcekey="PaymentSectionLabel"></asp:Label>
					</h2>
					<asp:Panel ID="SalesOrderMethodsPanel" runat="server">
						<div class="dnnFormItem">
							<dnn1:LabelControl ID="SalesOrderMethodsLabelControl" runat="server" />
							<asp:RadioButtonList ID="SalesOrderMethodsRadioButtonList" runat="server" AutoPostBack="True" OnSelectedIndexChanged="SalesOrderMethodsRadioButtonList_SelectedIndexChanged" RepeatDirection="Horizontal" RepeatLayout="Flow" CssClass="dnnFormRadioButtons">
								<asp:ListItem Selected="True" Value="Regular Purchase" resourcekey="RegularPurchaseSalesOrderMethodsListItem">Regular Purchase</asp:ListItem>
								<asp:ListItem Value="Purchase Order" resourcekey="PurchaseOrderSalesOrderMethodsListItem">Purchase Order</asp:ListItem>
							</asp:RadioButtonList>
						</div>
					</asp:Panel>
					<asp:Panel ID="PurchaseOrderPanel" runat="server">
						<div class="dnnFormItem">
							<dnn1:LabelControl ID="PurchaseOrderNumberLabelControl" runat="server" />
							<asp:TextBox ID="PurchaseOrderNumberTextBox" runat="server"></asp:TextBox>
						</div>
					</asp:Panel>
					<asp:Panel ID="PaymentMethodsPanel" runat="server">
						<asp:Panel ID="RewardsPointPanel" runat="server">
							<div class="dnnFormItem">
								<dnn1:LabelControl ID="AvailableRewardsPointsLabelControl" runat="server" />
								<asp:Label ID="AvailableRewardsPointsLabel" runat="server" />
							</div>
							<div class="dnnFormItem">
								<dnn1:LabelControl ID="RedeemRewardsPointLabelControl" runat="server" />
								<asp:CustomValidator ID="RedeemRewardsPointCustomValidator" runat="server" OnServerValidate="RedeemRewardsPointCustomValidator_ServerValidate" ControlToValidate="RedeemRewardsPointDnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="RewardsPointCheckoutDisplayTemplate" />
								<dnn2:DnnNumericTextBox ID="RedeemRewardsPointDnnNumericTextBox" runat="server" Skin="" NumberFormat-DecimalDigits="0" NumberFormat-GroupSizes="9" EnableSingleInputRendering="False" MinValue="1">
								</dnn2:DnnNumericTextBox>
								<asp:LinkButton ID="AddRewardsPointLinkButton" runat="server" OnClick="AddRewardsPointLinkButton_Click" ValidationGroup="RewardsPointCheckoutDisplayTemplate" CausesValidation="True" CssClass="rvdAddNewGridAction" />
								<asp:DataList ID="RewardsPointDataList" CssClass="rvdsfCheckoutRewardsPointList" runat="server" RepeatDirection="Horizontal" RepeatLayout="Flow">
									<ItemTemplate>
										<asp:LinkButton ID="DeleteRewardsPointLinkButton" runat="server" CommandArgument='<%# Eval("Points") %>' OnClick="DeleteRewardsPointLinkButton_Click" CausesValidation="False" CssClass="rvdDeleteGridAction" resourcekey="DeleteRewardsPointLinkButton" />
										<asp:Label ID="RewardsPointPointsLabel" runat="server" Text='<%# String.Format("{0} - {1}", Eval("Points"), Eval("Amount")) %>' />
									</ItemTemplate>
								</asp:DataList>
							</div>
						</asp:Panel>
						<asp:Panel ID="VoucherPanel" runat="server">
							<div class="dnnFormItem">
								<dnn1:LabelControl ID="VoucherLabelControl" runat="server" />
								<asp:CustomValidator ID="VoucherCodeCustomValidator" runat="server" OnServerValidate="VoucherCodeCustomValidator_ServerValidate" ControlToValidate="VoucherCodeTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="VoucherCheckoutDisplayTemplate" />
								<asp:TextBox ID="VoucherCodeTextBox" runat="server" MaxLength="100" AutoCompleteType="Disabled" />
								<asp:LinkButton ID="AddVoucherLinkButton" runat="server" OnClick="AddVoucherLinkButton_Click" ValidationGroup="VoucherCheckoutDisplayTemplate" CausesValidation="True" CssClass="rvdAddNewGridAction" />
								<asp:DataList ID="VoucherDataList" CssClass="rvdsfCheckoutVoucherList" runat="server" RepeatDirection="Horizontal" RepeatLayout="Flow">
									<ItemTemplate>
										<asp:LinkButton ID="DeleteVoucherLinkButton" runat="server" CommandArgument='<%# Eval("Code") %>' OnClick="DeleteVoucherLinkButton_Click" CausesValidation="False" CssClass="rvdDeleteGridAction" resourcekey="DeleteVoucherLinkButton" />
										<asp:Label ID="VoucherCodeLabel" runat="server" Text='<%# String.Format("{0} - {1}", Eval("Code"), Eval("Amount")) %>' />
									</ItemTemplate>
								</asp:DataList>
							</div>
						</asp:Panel>
						<div class="dnnFormItem">
							<dnn1:LabelControl ID="PaymentMethodLabelControl" runat="server" />
							<asp:RadioButtonList ID="PaymentMethodRadioButtonList" runat="server" AutoPostBack="True" OnSelectedIndexChanged="PaymentMethodRadioButtonList_SelectedIndexChanged" CssClass="dnnFormRadioButtons" RepeatLayout="Flow">
								<asp:ListItem resourcekey="NonePaymentMethodListItem" Value="7">None</asp:ListItem>
								<asp:ListItem resourcekey="AuthorizeNetCIMPaymentMethodListItem" Value="18">Authorize.Net CIM</asp:ListItem>
								<asp:ListItem resourcekey="AuthorizeNetSIMPaymentMethodListItem" Value="13">Authorize.Net SIM</asp:ListItem>
								<asp:ListItem resourcekey="CashPaymentMethodListItem" Value="1">Cash</asp:ListItem>
								<asp:ListItem resourcekey="CheckPaymentMethodListItem" Value="2">Check</asp:ListItem>
								<asp:ListItem resourcekey="CreditCardPaymentMethodListItem" Value="3">Credit Card</asp:ListItem>
								<asp:ListItem resourcekey="DotpayPaymentMethodListItem" Value="21">Dotpay</asp:ListItem>
								<asp:ListItem resourcekey="MasterCardIGSHostedPaymentMethodListItem" Value="14">MasterCard virtual payment</asp:ListItem>
								<asp:ListItem resourcekey="MolliePaymentMethodListItem" Value="11">Mollie</asp:ListItem>
								<asp:ListItem resourcekey="MoneyOrderPaymentMethodListItem" Value="4">Money Order</asp:ListItem>
								<asp:ListItem resourcekey="PayFastPaymentMethodListItem" Value="8">PayFast</asp:ListItem>
								<asp:ListItem resourcekey="PayPalPaymentMethodListItem" Value="6">PayPal</asp:ListItem>
								<asp:ListItem resourcekey="Paystation3PartyPaymentMethodListItem" Value="15">Paystation</asp:ListItem>
								<asp:ListItem resourcekey="PayUBusinessPaymentMethodListItem" Value="19">PayU Business</asp:ListItem>
								<asp:ListItem resourcekey="SagePayFormPaymentMethodListItem" Value="17">Sage Pay</asp:ListItem>
								<asp:ListItem resourcekey="SuomenVerkkomaksutPaymentMethodListItem" Value="12">Suomen Verkkomaksut</asp:ListItem>
								<asp:ListItem resourcekey="TowahPaymentMethodListItem" Value="9">Towah</asp:ListItem>
								<asp:ListItem resourcekey="VirtualCardServicesPayPaymentMethodListItem" Value="20">Virtual Card Services Pay</asp:ListItem>
								<asp:ListItem resourcekey="WireTransferPaymentMethodListItem" Value="5">Wire Transfer</asp:ListItem>
							</asp:RadioButtonList>
						</div>
						<asp:Panel ID="CreditCardPanel" runat="server">
							<div class="dnnFormItem">
								<dnn1:LabelControl ID="CreditCardNumberLabelControl" runat="server" CssClass="dnnFormRequired" />
								<asp:RequiredFieldValidator ID="CreditCardNumberRequiredFieldValidator" resourcekey="CreditCardNumberRequiredFieldValidator" runat="server" ControlToValidate="CreditCardNumberTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="CheckoutDisplayTemplate"></asp:RequiredFieldValidator>
								<asp:RegularExpressionValidator ID="CreditCardRegularExpressionValidator" resourcekey="CreditCardRegularExpressionValidator" runat="server" ControlToValidate="CreditCardNumberTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationExpression="[\d ]{13,24}" ValidationGroup="CheckoutDisplayTemplate"></asp:RegularExpressionValidator>
								<asp:TextBox ID="CreditCardNumberTextBox" runat="server" MaxLength="24" AutoCompleteType="Disabled" autocomplete="off" CssClass="dnnFormRequired"></asp:TextBox>
							</div>
							<div class="dnnFormItem">
								<dnn1:LabelControl ID="CreditCardExpiryLabelControl" runat="server" CssClass="dnnFormRequired" />
								<asp:DropDownList ID="ExpirationMonthDropDownList" runat="server" CssClass="dnnFormRequired rvdsfCreditCardExpiryMonthInput">
									<asp:ListItem>01</asp:ListItem>
									<asp:ListItem>02</asp:ListItem>
									<asp:ListItem>03</asp:ListItem>
									<asp:ListItem>04</asp:ListItem>
									<asp:ListItem>05</asp:ListItem>
									<asp:ListItem>06</asp:ListItem>
									<asp:ListItem>07</asp:ListItem>
									<asp:ListItem>08</asp:ListItem>
									<asp:ListItem>09</asp:ListItem>
									<asp:ListItem>10</asp:ListItem>
									<asp:ListItem>11</asp:ListItem>
									<asp:ListItem>12</asp:ListItem>
								</asp:DropDownList>
								<asp:DropDownList ID="ExpirationYearDropDownList" runat="server" CssClass="dnnFormRequired rvdsfCreditCardExpiryYearInput">
								</asp:DropDownList>
							</div>
							<div class="dnnFormItem">
								<dnn1:LabelControl ID="CreditCardVerificationNumberLabelControl" runat="server" CssClass="dnnFormRequired" />
								<asp:RequiredFieldValidator ID="CreditCardVerificationNumberRequiredFieldValidator" resourcekey="CreditCardVerificationNumberRequiredFieldValidator" runat="server" ControlToValidate="CreditCardVerificationNumberTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="CheckoutDisplayTemplate"></asp:RequiredFieldValidator>
								<asp:RegularExpressionValidator ID="CreditCardVerificationNumberRegularExpressionValidator" resourcekey="CreditCardVerificationNumberRegularExpressionValidator" runat="server" ControlToValidate="CreditCardVerificationNumberTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationExpression="\d+" ValidationGroup="CheckoutDisplayTemplate"></asp:RegularExpressionValidator>
								<asp:TextBox ID="CreditCardVerificationNumberTextBox" runat="server" MaxLength="5" AutoCompleteType="Disabled" autocomplete="off" CssClass="dnnFormRequired rvdsfCreditCardVerificationNumberInput"></asp:TextBox>
							</div>
						</asp:Panel>
						<asp:Panel ID="PaymentProfilePanel" runat="server" CssClass="dnnFormItem">
							<dnn1:LabelControl ID="PaymentProfileLabelControl" runat="server" CssClass="dnnFormRequired" />
							<asp:RequiredFieldValidator ID="PaymentProfileRequiredFieldValidator" resourcekey="PaymentProfileRequiredFieldValidator" runat="server" ControlToValidate="PaymentProfileRadioButtonList" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="CheckoutDisplayTemplate">Payment profile is required.</asp:RequiredFieldValidator>
							<div class="rvdFormSubContainer">
								<asp:RadioButtonList ID="PaymentProfileRadioButtonList" runat="server" CssClass="dnnFormRadioButtons dnnFormRequired" RepeatLayout="Flow" ValidationGroup="CheckoutDisplayTemplate"></asp:RadioButtonList>
								<div class="rvdActions">
									<asp:LinkButton ID="CreatePaymentLinkButton" runat="server" OnClick="CreatePaymentLinkButton_Click" CausesValidation="False" resourcekey="CreatePaymentLinkButton" CssClass="dnnPrimaryAction rvdAddNewAction" />
									<asp:LinkButton ID="EditPaymentLinkButton" runat="server" OnClick="EditPaymentLinkButton_Click" CausesValidation="False" resourcekey="EditPaymentLinkButton" CssClass="dnnPrimaryAction rvdEditAction" />
									<asp:LinkButton ID="DeletePaymentLinkButton" runat="server" OnClick="DeletePaymentLinkButton_Click" CausesValidation="False" resourcekey="DeletePaymentLinkButton" CssClass="dnnSecondaryAction rvdDeleteAction" />
									<asp:LinkButton ID="UpdatePaymentLinkButton" runat="server" OnClick="UpdatePaymentLinkButton_Click" CausesValidation="False" resourcekey="UpdatePaymentLinkButton" CssClass="dnnSecondaryAction" Style="display: none" />
								</div>
							</div>
						</asp:Panel>
						<asp:Panel ID="MolliePanel" runat="server" CssClass="dnnFormItem">
							<dnn1:LabelControl ID="InstitutionNumberLabelControl" runat="server" />
							<asp:DropDownList ID="InstitutionNumberDropDownList" runat="server">
								<asp:ListItem Text="ABN AMRO" Value="0031" Selected="true" />
								<asp:ListItem Text="ASN Bank" Value="0761" />
								<asp:ListItem Text="Friesland Bank" Value="0091" />
								<asp:ListItem Text="ING" Value="0721" />
								<asp:ListItem Text="Rabobank" Value="0021" />
								<asp:ListItem Text="RegioBank" Value="0771" />
								<asp:ListItem Text="SNS Bank" Value="0751" />
								<asp:ListItem Text="Triodos Bank" Value="0511" />
								<asp:ListItem Text="Van Lanschot" Value="0161" />
							</asp:DropDownList>
						</asp:Panel>
					</asp:Panel>
				</asp:Panel>
				<div class="rvdsfCheckoutActions">
					<asp:LinkButton ID="ViewBillingLinkButton" runat="server" OnClick="ViewBillingLinkButton_Click" ValidationGroup="CheckoutDisplayTemplate" resourcekey="ViewBillingLinkButton" CausesValidation="False" CssClass="dnnPrimaryAction rvdsfViewBillingAction" />
					<asp:LinkButton ID="PlaceOrderLinkButton" runat="server" OnClick="PlaceOrderLinkButton_Click" ValidationGroup="CheckoutDisplayTemplate" resourcekey="PlaceOrderLinkButton" OnClientClick="PlaceOrderLinkButton_ClientClick(this)" CssClass="dnnPrimaryAction rvdsfPlaceOrderAction" />
					<asp:LinkButton ID="RequestQuoteLinkButton" runat="server" OnClick="RequestQuoteLinkButton_Click" ValidationGroup="CheckoutDisplayTemplate" resourcekey="RequestQuoteLinkButton" OnClientClick="PlaceOrderLinkButton_ClientClick(this)" CssClass="dnnPrimaryAction rvdsfRequestQuoteAction" />

					<script type="text/javascript">
						function PlaceOrderLinkButton_ClientClick(sender)
						{
							// Disable double click with check for IE8. This only works for IE9+, FF, Chrome.
							if (jQuery.support.leadingWhitespace && (typeof (Page_ClientValidate) != 'function' || Page_ClientValidate("CheckoutDisplayTemplate")))
							{
								jQuery(sender).click(function (e)
								{
									e.preventDefault();
								});
							}
						}
					</script>

				</div>
			</asp:Panel>
		</ContentTemplate>
	</asp:UpdatePanel>
</asp:Panel>
