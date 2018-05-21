<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Display.ascx.cs" Inherits="Revindex.Dnn.RevindexStorefront.Portals._default.Display.Checkout.Standard15.Display" %>
<%@ Register Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI.WebControls" TagPrefix="asp" %>
<%@ Register Src="~/Controls/labelcontrol.ascx" TagName="LabelControl" TagPrefix="dnn1" %>
<%@ Register Assembly="DotNetNuke.Web.Deprecated" Namespace="DotNetNuke.Web.UI.WebControls" TagPrefix="dnn2" %>
<%@ Register Src="../../../../../UserAddressDropDownListControl.ascx" TagName="UserAddressDropDownListControl" TagPrefix="uc1" %>
<div class="rvdsfCheckoutBreadcrumb">
	<asp:LinkButton ID="ViewCartNavigationLinkButton" runat="server" CausesValidation="False" OnClick="ViewCartNavigationLinkButton_Click" resourcekey="ViewCartNavigationLinkButton"></asp:LinkButton>
	<span class="rvdsfCheckoutBreadcrumbSeparator"></span>
	<asp:LinkButton ID="BillingAndShippingNavigationLinkButton" runat="server" CausesValidation="False" OnClick="BillingAndShippingNavigationLinkButton_Click" Enabled="False" resourcekey="BillingAndShippingNavigationLinkButton"></asp:LinkButton>
	<span class="rvdsfCheckoutBreadcrumbSeparator"></span>
	<asp:LinkButton ID="PlaceOrderNavigationLinkButton" runat="server" CausesValidation="False" Enabled="False" resourcekey="PlaceOrderNavigationLinkButton"></asp:LinkButton>
	<span class="rvdsfCheckoutBreadcrumbSeparator"></span>
	<asp:LinkButton ID="ConfirmationNavigationLinkButton" runat="server" CausesValidation="False" Enabled="False" resourcekey="ConfirmationNavigationLinkButton"></asp:LinkButton>
</div>
<dnn2:DnnAjaxLoadingPanel ID="UpdateProgressDnnAjaxLoadingPanel" runat="server" Transparency="5">
	<asp:Image ID="UpdateProgressImage" runat="server" ImageUrl="~/Images/Loading.gif" />
</dnn2:DnnAjaxLoadingPanel>
<asp:Panel ID="BillingAndShippingPanel" runat="server">
	<asp:UpdatePanel ID="UpdatePanel1" runat="server">
		<ContentTemplate>
			<asp:Panel ID="AccountSectionPanel" runat="server">
				<h1>
					<asp:Label ID="AccountSectionLabel" runat="server" resourcekey="AccountSectionLabel"></asp:Label></h1>
				<asp:Label ID="AccountAnonymousWarningLabel" runat="server" resourcekey="AccountAnonymousWarningLabel"></asp:Label>
				<br />
				<br />
				<dnn2:DnnRadButton ID="AccountRegistrationDnnRadButton" runat="server" Text="AccountRegistrationDnnRadButton" Icon-PrimaryIconUrl="~/DesktopModules/Revindex.Dnn.RevindexStorefront/Media/RegisterIcon.gif" AutoPostBack="false" OnClientClicking="function(sender, args) { window.location = sender.get_navigateUrl(); args.set_cancel(true); }">
				</dnn2:DnnRadButton>
				&nbsp;<dnn2:DnnRadButton ID="AccountLoginDnnRadButton" runat="server" Text="AccountLoginDnnRadButton" Icon-PrimaryIconUrl="~/DesktopModules/Revindex.Dnn.RevindexStorefront/Media/LoginIcon.gif" AutoPostBack="false" OnClientClicking="function(sender, args) { window.location = sender.get_navigateUrl(); args.set_cancel(true); }">
				</dnn2:DnnRadButton>
				<br />
				<br />
				<br />
			</asp:Panel>
			<h1>
				<asp:Label ID="BillingSectionLabel" runat="server" resourcekey="BillingSectionLabel"></asp:Label></h1>
			<asp:Panel ID="BilingUserAddressBookPanel" runat="server">
				<table cellpadding="3" cellspacing="0" style="width: 100%">
					<tr>
						<td style="width: 150px">
							<dnn1:LabelControl ID="BillingUserAddressLabelControl" runat="server" />
						</td>
						<td>
							<uc1:UserAddressDropDownListControl ID="BillingUserAddressDropDownListControl" runat="server" Width="300" AutoPostBack="True" />
						</td>
					</tr>
				</table>
			</asp:Panel>
			<table cellpadding="3" cellspacing="0" style="width: 100%">
				<tr>
					<td style="width: 150px">
						<dnn1:LabelControl ID="BillingFirstNameLabelControl" runat="server" CssClass="NormalBold" />
						<asp:RequiredFieldValidator ID="BillingFirstNameRequiredFieldValidator" runat="server" ControlToValidate="BillingFirstNameTextBox" CssClass="NormalRed" Display="Dynamic" resourcekey="BillingFirstNameRequiredFieldValidator" ValidationGroup="CheckoutDisplayTemplate"></asp:RequiredFieldValidator>
					</td>
					<td>
						<asp:TextBox ID="BillingFirstNameTextBox" runat="server" Width="300px" MaxLength="50"></asp:TextBox>
					</td>
				</tr>
				<tr>
					<td style="width: 150px">
						<dnn1:LabelControl ID="BillingLastNameLabelControl" runat="server" CssClass="NormalBold" />
						<asp:RequiredFieldValidator ID="BillingLastNameRequiredFieldValidator" resourcekey="BillingLastNameRequiredFieldValidator" runat="server" ControlToValidate="BillingLastNameTextBox" CssClass="NormalRed" Display="Dynamic" ValidationGroup="CheckoutDisplayTemplate"></asp:RequiredFieldValidator>
					</td>
					<td>
						<asp:TextBox ID="BillingLastNameTextBox" runat="server" Width="300px" MaxLength="50"></asp:TextBox>
					</td>
				</tr>
				<tr>
					<td style="width: 150px">
						<dnn1:LabelControl ID="BillingCompanyLabelControl" runat="server" />
					</td>
					<td>
						<asp:TextBox ID="BillingCompanyTextBox" runat="server" Width="300px" MaxLength="100"></asp:TextBox>
					</td>
				</tr>
				<tr>
					<td style="vertical-align: top; width: 150px">
						<dnn1:LabelControl ID="BillingCountryLabelControl" runat="server" CssClass="NormalBold" />
					</td>
					<td>
						<asp:DropDownList ID="BillingCountryDropDownList" runat="server" AutoPostBack="True" OnSelectedIndexChanged="BillingCountryDropDownList_SelectedIndexChanged" Width="300px">
						</asp:DropDownList>
					</td>
				</tr>
				<tr>
					<td style="vertical-align: top; width: 150px">
						<dnn1:LabelControl ID="BillingStreetLabelControl" runat="server" CssClass="NormalBold" />
						<asp:RequiredFieldValidator ID="BillingStreetRequiredFieldValidator" resourcekey="BillingStreetRequiredFieldValidator" runat="server" ControlToValidate="BillingStreetTextBox" CssClass="NormalRed" Display="Dynamic" ValidationGroup="CheckoutDisplayTemplate"></asp:RequiredFieldValidator>
						<asp:RegularExpressionValidator ID="BillingStreetRegularExpressionValidator" resourcekey="BillingStreetRegularExpressionValidator" runat="server" ControlToValidate="BillingStreetTextBox" ValidationExpression="^[\s\S]{0,200}$" ValidationGroup="CheckoutDisplayTemplate" CssClass="NormalRed" Display="Dynamic"></asp:RegularExpressionValidator>
					</td>
					<td>
						<asp:TextBox ID="BillingStreetTextBox" runat="server" Rows="2" TextMode="MultiLine" Width="300px" Wrap="False" MaxLength="200"></asp:TextBox>
					</td>
				</tr>
				<tr>
					<td style="width: 150px">
						<dnn1:LabelControl ID="BillingCityLabelControl" runat="server" CssClass="NormalBold" />
						<asp:RequiredFieldValidator ID="BillingCityRequiredFieldValidator" resourcekey="BillingCityRequiredFieldValidator" runat="server" ControlToValidate="BillingCityTextBox" CssClass="NormalRed" Display="Dynamic" ValidationGroup="CheckoutDisplayTemplate"></asp:RequiredFieldValidator>
					</td>
					<td>
						<asp:TextBox ID="BillingCityTextBox" runat="server" Width="300px" MaxLength="50"></asp:TextBox>
					</td>
				</tr>
				<tr>
					<td style="width: 150px">
						<dnn1:LabelControl ID="BillingSubdivisionLabelControl" runat="server" CssClass="NormalBold" />
					</td>
					<td>
						<asp:DropDownList ID="BillingSubdivisionDropDownList" runat="server" Width="300px" OnSelectedIndexChanged="BillingSubdivisionDropDownList_SelectedIndexChanged" AutoPostBack="True">
						</asp:DropDownList>
					</td>
				</tr>
				<tr>
					<td style="width: 150px">
						<dnn1:LabelControl ID="BillingPostalCodeLabelControl" runat="server" CssClass="NormalBold" />
						<asp:RequiredFieldValidator ID="BillingPostalCodeRequiredFieldValidator" resourcekey="BillingPostalCodeRequiredFieldValidator" runat="server" ControlToValidate="BillingPostalCodeTextBox" CssClass="NormalRed" Display="Dynamic" ValidationGroup="CheckoutDisplayTemplate"></asp:RequiredFieldValidator>
					</td>
					<td>
						<asp:TextBox ID="BillingPostalCodeTextBox" runat="server" MaxLength="10" AutoPostBack="True" OnTextChanged="BillingPostalCodeTextBox_TextChanged" Width="150px"></asp:TextBox>
					</td>
				</tr>
				<tr>
					<td style="width: 150px">
						<dnn1:LabelControl ID="BillingPhoneLabelControl" runat="server" CssClass="NormalBold" />
						<asp:RequiredFieldValidator ID="BillingPhoneRequiredFieldValidator" resourcekey="BillingPhoneRequiredFieldValidator" runat="server" ControlToValidate="BillingPhoneTextBox" CssClass="NormalRed" Display="Dynamic" ValidationGroup="CheckoutDisplayTemplate"></asp:RequiredFieldValidator>
					</td>
					<td>
						<asp:TextBox ID="BillingPhoneTextBox" runat="server" MaxLength="50" Width="150px"></asp:TextBox>
					</td>
				</tr>
				<tr>
					<td style="width: 150px">
						<dnn1:LabelControl ID="BillingEmailLabelControl" runat="server" CssClass="NormalBold" />
						<asp:RequiredFieldValidator ID="BillingEmailRequiredFieldValidator" runat="server" ControlToValidate="BillingEmailTextBox" CssClass="NormalRed" Display="Dynamic" resourcekey="BillingEmailRequiredFieldValidator" ValidationGroup="CheckoutDisplayTemplate"></asp:RequiredFieldValidator>
						<asp:RegularExpressionValidator ID="BillingEmailRegularExpressionValidator" runat="server" ControlToValidate="BillingEmailTextBox" CssClass="NormalRed" Display="Dynamic" resourcekey="BillingEmailRegularExpressionValidator" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ValidationGroup="CheckoutDisplayTemplate"></asp:RegularExpressionValidator>
					</td>
					<td>
						<asp:TextBox ID="BillingEmailTextBox" runat="server" Width="300px" MaxLength="256"></asp:TextBox>
					</td>
				</tr>
			</table>
			<asp:Panel ID="BusinessTaxNumberPanel" runat="server">
				<table cellpadding="3" cellspacing="0" style="width: 100%">
					<tr>
						<td style="width: 150px">
							<dnn1:LabelControl ID="BusinessTaxNumberLabelControl" runat="server" CssClass="NormalBold" />
						</td>
						<td>
							<asp:TextBox ID="BusinessTaxNumberTextBox" runat="server" Width="300px"></asp:TextBox>
						</td>
					</tr>
				</table>
			</asp:Panel>
			<table cellpadding="3" cellspacing="0" style="width: 100%">
				<tr>
					<td style="width: 150px"></td>
					<td>
						<asp:CheckBox ID="SaveBillingUserAddressCheckBox" runat="server" Checked="True" resourcekey="SaveBillingUserAddressCheckBox" />
					</td>
				</tr>
				<tr>
					<td style="width: 150px"></td>
					<td>
						<asp:CheckBox ID="UpdateUserProfileCheckBox" runat="server" Checked="True" resourcekey="UpdateUserProfileCheckBox" />
					</td>
				</tr>
			</table>
			<br />
			<asp:Panel ID="ShippingAddressPanel" runat="server">
				<h1>
					<asp:Label ID="ShippingSectionLabel" runat="server" resourcekey="ShippingSectionLabel"></asp:Label></h1>
				<asp:CheckBox ID="SameAsBillingCheckBox" runat="server" AutoPostBack="True" Checked="True" Font-Bold="True" OnCheckedChanged="SameAsBillingCheckBox_CheckedChanged" resourcekey="SameAsBillingCheckBox" />
				<br />
				<br />
				<asp:Panel ID="ShippingAddressDetailsViewPanel" runat="server" Visible="False">
					<asp:Panel ID="ShippingUserAddressBookPanel" runat="server">
						<table cellpadding="3" cellspacing="0" style="width: 100%">
							<tr>
								<td style="width: 150px">
									<dnn1:LabelControl ID="ShippingUserAddressLabelControl" runat="server" />
								</td>
								<td>
									<uc1:UserAddressDropDownListControl ID="ShippingUserAddressDropDownListControl" runat="server" AutoPostBack="True" Width="300" />
								</td>
							</tr>
						</table>
					</asp:Panel>
					<table cellpadding="3" cellspacing="0" style="width: 100%">
						<tr>
							<td style="width: 150px">
								<dnn1:LabelControl ID="ShippingFirstNameLabelControl" runat="server" CssClass="NormalBold" />
								<asp:RequiredFieldValidator ID="ShippingFirstNameRequiredFieldValidator" runat="server" ControlToValidate="ShippingFirstNameTextBox" CssClass="NormalRed" Display="Dynamic" resourcekey="ShippingFirstNameRequiredFieldValidator" ValidationGroup="CheckoutDisplayTemplate"></asp:RequiredFieldValidator>
							</td>
							<td>
								<asp:TextBox ID="ShippingFirstNameTextBox" runat="server" MaxLength="50" Width="300px"></asp:TextBox>
							</td>
						</tr>
						<tr>
							<td style="width: 150px">
								<dnn1:LabelControl ID="ShippingLastNameLabelControl" runat="server" CssClass="NormalBold" />
								<asp:RequiredFieldValidator ID="ShippingLastNameRequiredFieldValidator" resourcekey="ShippingLastNameRequiredFieldValidator" runat="server" ControlToValidate="ShippingLastNameTextBox" CssClass="NormalRed" Display="Dynamic" ValidationGroup="CheckoutDisplayTemplate"></asp:RequiredFieldValidator>
							</td>
							<td>
								<asp:TextBox ID="ShippingLastNameTextBox" runat="server" MaxLength="50" Width="300px"></asp:TextBox>
							</td>
						</tr>
						<tr>
							<td style="width: 150px">
								<dnn1:LabelControl ID="ShippingCompanyLabelControl" runat="server" />
							</td>
							<td>
								<asp:TextBox ID="ShippingCompanyTextBox" runat="server" MaxLength="100" Width="300px"></asp:TextBox>
							</td>
						</tr>
						<tr>
							<td style="vertical-align: top; width: 150px">
								<dnn1:LabelControl ID="ShippingCountryLabelControl" runat="server" CssClass="NormalBold" />
							</td>
							<td>
								<asp:DropDownList ID="ShippingCountryDropDownList" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ShippingCountryDropDownList_SelectedIndexChanged" Width="300px">
								</asp:DropDownList>
							</td>
						</tr>
						<tr>
							<td style="vertical-align: top; width: 150px">
								<dnn1:LabelControl ID="ShippingStreetLabelControl" runat="server" CssClass="NormalBold" />
								<asp:RequiredFieldValidator ID="ShippingStreetRequiredFieldValidator" resourcekey="ShippingStreetRequiredFieldValidator" runat="server" ControlToValidate="ShippingStreetTextBox" CssClass="NormalRed" Display="Dynamic" ValidationGroup="CheckoutDisplayTemplate"></asp:RequiredFieldValidator><asp:RegularExpressionValidator ID="ShippingStreetRegularExpressionValidator" resourcekey="ShippingStreetRegularExpressionValidator" runat="server" ControlToValidate="ShippingStreetTextBox" ValidationExpression="^[\s\S]{0,200}$" ValidationGroup="CheckoutDisplayTemplate" CssClass="NormalRed" Display="Dynamic"></asp:RegularExpressionValidator>
							</td>
							<td>
								<asp:TextBox ID="ShippingStreetTextBox" runat="server" MaxLength="200" Rows="2" TextMode="MultiLine" Width="300px" Wrap="False"></asp:TextBox>
							</td>
						</tr>
						<tr>
							<td style="vertical-align: top; width: 150px">
								<dnn1:LabelControl ID="ShippingCityLabelControl" runat="server" CssClass="NormalBold" />
								<asp:RequiredFieldValidator ID="ShippingCityRequiredFieldValidator" resourcekey="ShippingCityRequiredFieldValidator" runat="server" ControlToValidate="ShippingCityTextBox" CssClass="NormalRed" Display="Dynamic" ValidationGroup="CheckoutDisplayTemplate"></asp:RequiredFieldValidator>
							</td>
							<td>
								<asp:TextBox ID="ShippingCityTextBox" runat="server" MaxLength="50" Width="300px"></asp:TextBox>
							</td>
						</tr>
						<tr>
							<td style="width: 150px">
								<dnn1:LabelControl ID="ShippingSubdivisionLabelControl" runat="server" CssClass="NormalBold" />
							</td>
							<td>
								<asp:DropDownList ID="ShippingSubdivisionDropDownList" runat="server" AutoPostBack="True" Width="300px" OnSelectedIndexChanged="ShippingSubdivisionDropDownList_SelectedIndexChanged">
								</asp:DropDownList>
							</td>
						</tr>
						<tr>
							<td style="width: 150px">
								<dnn1:LabelControl ID="ShippingPostalCodeLabelControl" runat="server" CssClass="NormalBold" />
								<asp:RequiredFieldValidator ID="ShippingPostalCodeRequiredFieldValidator" runat="server" resourcekey="ShippingPostalCodeRequiredFieldValidator" ControlToValidate="ShippingPostalCodeTextBox" CssClass="NormalRed" Display="Dynamic" ValidationGroup="CheckoutDisplayTemplate"></asp:RequiredFieldValidator>
							</td>
							<td>
								<asp:TextBox ID="ShippingPostalCodeTextBox" runat="server" MaxLength="10" AutoPostBack="True" OnTextChanged="ShippingPostalCodeTextBox_TextChanged" Width="150px"></asp:TextBox>
							</td>
						</tr>
						<tr>
							<td style="width: 150px">
								<dnn1:LabelControl ID="ShippingPhoneLabelControl" runat="server" CssClass="NormalBold" />
								<asp:RequiredFieldValidator ID="ShippingPhoneRequiredFieldValidator" resourcekey="ShippingPhoneRequiredFieldValidator" runat="server" ControlToValidate="ShippingPhoneTextBox" CssClass="NormalRed" Display="Dynamic" ValidationGroup="CheckoutDisplayTemplate"></asp:RequiredFieldValidator>
							</td>
							<td>
								<asp:TextBox ID="ShippingPhoneTextBox" runat="server" MaxLength="50" Width="150px"></asp:TextBox>
							</td>
						</tr>
						<tr>
							<td style="width: 150px">
								<dnn1:LabelControl ID="ShippingEmailLabelControl" runat="server" />
								<asp:RegularExpressionValidator ID="ShippingEmailRegularExpressionValidator" resourcekey="ShippingEmailRegularExpressionValidator" runat="server" ControlToValidate="ShippingEmailTextBox" CssClass="NormalRed" Display="Dynamic" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ValidationGroup="CheckoutDisplayTemplate"></asp:RegularExpressionValidator>
							</td>
							<td>
								<asp:TextBox ID="ShippingEmailTextBox" runat="server" MaxLength="256" Width="300px"></asp:TextBox>
							</td>
						</tr>
						<tr>
							<td style="width: 150px"></td>
							<td>
								<asp:CheckBox ID="SaveShippingUserAddressCheckBox" runat="server" Checked="True" resourcekey="SaveShippingUserAddressCheckBox" />
							</td>
						</tr>
					</table>
				</asp:Panel>
			</asp:Panel>
			<br />
			<asp:Panel ID="ShippingMethodPanel" runat="server">
				<table cellpadding="3" cellspacing="0" style="width: 100%">
					<tr>
						<td style="width: 150px">
							<dnn1:LabelControl ID="ShippingMethodLabelControl" runat="server" CssClass="NormalBold" />
						</td>
						<td>
							<asp:DropDownList ID="ShippingMethodDropDownList" runat="server" Width="300px">
							</asp:DropDownList>
						</td>
					</tr>
				</table>
			</asp:Panel>
			<asp:Panel ID="OtherInformationPanel" runat="server">
				<h1>
					<asp:Label ID="OtherSectionLabel" runat="server" resourcekey="OtherSectionLabel"></asp:Label></h1>
				<asp:Panel ID="CouponPanel" runat="server">
					<table cellpadding="3" cellspacing="0" style="width: 100%">
						<tr>
							<td style="width: 150px; vertical-align: top">
								<dnn1:LabelControl ID="CouponLabelControl" runat="server" />
							</td>
							<td>
								<asp:TextBox ID="CouponCodeTextBox" runat="server" MaxLength="100" Width="150px"></asp:TextBox>
								<dnn2:DnnRadButton ID="AddCouponDnnRadButton" runat="server" ButtonType="LinkButton" Text="AddCouponDnnRadButton" Skin="" OnClick="AddCouponDnnRadButton_Click" ValidationGroup="CheckoutDisplayTemplate" Icon-PrimaryIconUrl="~/DesktopModules/Revindex.Dnn.RevindexStorefront/Media/AddIcon.gif">
								</dnn2:DnnRadButton>
								<asp:DataList ID="CouponDataList" runat="server" HorizontalAlign="Left" RepeatColumns="4" RepeatDirection="Horizontal" Width="100%" CellSpacing="5">
									<ItemTemplate>
										<asp:ImageButton ID="RemoveCouponImageButton" runat="server" CommandArgument='<%# Eval("Code") %>' ImageAlign="AbsMiddle" ImageUrl="../../../../../Media/DeleteIcon.gif" OnClick="RemoveCouponImageButton_Click" CausesValidation="False" />
										&nbsp;<asp:Label ID="CouponLabel" runat="server" CssClass="NormalBold" Text='<%# Eval("Code") %>'></asp:Label>
										&nbsp;
									</ItemTemplate>
								</asp:DataList>
							</td>
						</tr>
					</table>
				</asp:Panel>
				<asp:ListView ID="DynamicFormListView" runat="server" GroupItemCount="1" OnItemCreated="DynamicFormListView_ItemCreated">
					<LayoutTemplate>
						<div style="display: table; width: 100%">
							<div runat="server" id="groupPlaceholder" />
						</div>
					</LayoutTemplate>
					<GroupTemplate>
						<div style="display: table-row">
							<div runat="server" id="itemPlaceholder" />
						</div>
					</GroupTemplate>
					<ItemTemplate>
						<div style="width: 150px; vertical-align: top; display: table-cell; padding: 3px">
							<asp:PlaceHolder ID="LabelDynamicFormPlaceHolder" runat="server"></asp:PlaceHolder>
							<asp:PlaceHolder ID="ValidatorDynamicFormPlaceHolder" runat="server"></asp:PlaceHolder>
						</div>
						<div style="display: table-cell; padding: 3px">
							<asp:PlaceHolder ID="InputControlDynamicFormPlaceHolder" runat="server"></asp:PlaceHolder>
						</div>
					</ItemTemplate>
				</asp:ListView>
				<asp:PlaceHolder ID="DynamicFormPlaceHolder" runat="server"></asp:PlaceHolder>
			</asp:Panel>
		</ContentTemplate>
	</asp:UpdatePanel>
	<br />
	<br />
	<table cellspacing="1" style="width: 100%">
		<tr>
			<td>
				<dnn2:DnnRadButton ID="ViewCartDnnRadButton" runat="server" OnClick="ViewCartDnnRadButton_Click" Text="ViewCartDnnRadButton" Icon-PrimaryIconUrl="~/DesktopModules/Revindex.Dnn.RevindexStorefront/Media/BackIcon.gif" CausesValidation="False">
				</dnn2:DnnRadButton>
			</td>
			<td style="text-align: right">
				<dnn2:DnnRadButton ID="ReviewOrderDnnRadButton" runat="server" OnClick="ReviewOrderDnnRadButton_Click" ValidationGroup="CheckoutDisplayTemplate" Text="ReviewOrderDnnRadButton" Icon-SecondaryIconUrl="~/DesktopModules/Revindex.Dnn.RevindexStorefront/Media/ForwardIcon.gif">
				</dnn2:DnnRadButton>
			</td>
		</tr>
	</table>
</asp:Panel>
<asp:Panel ID="PlaceOrderPanel" runat="server">
	<h1>
		<asp:Label ID="ReviewOrderSectionLabel" runat="server" resourcekey="ReviewOrderSectionLabel"></asp:Label></h1>
	<asp:UpdatePanel ID="UpdatePanel2" runat="server">
		<ContentTemplate>
			<asp:GridView ID="SalesOrderDetailGridView" CssClass="dnnGrid" GridLines="None" runat="server" AutoGenerateColumns="False" Width="100%" DataKeyNames="ProductVariantID" CellPadding="3">
				<HeaderStyle CssClass="dnnGridHeader" />
				<RowStyle CssClass="dnnGridItem" />
				<AlternatingRowStyle CssClass="dnnGridAltItem" />
				<SelectedRowStyle BackColor="#FFFF66" />
				<Columns>
					<asp:TemplateField HeaderText="ItemHeaderSalesOrderDetailGridView" HeaderStyle-HorizontalAlign="Left">
						<ItemTemplate>
							<asp:HyperLink ID="GalleryHyperLink" BorderStyle="None" runat="server" NavigateUrl='<%# Eval("ProductUrl") %>' CssClass="rvdsfCartGalleryThumbnail">
								<asp:Image ID="GalleryImage" Width='<%# Eval("GalleryImage_Width") %>' AlternateText='<%# Eval("GalleryImage_AlternateText") %>' ImageUrl='<%# Eval("GalleryImage_ImageUrl") %>' Visible='<%# Convert.ToBoolean(Eval("GalleryImage_Visible")) %>' runat="server" BorderStyle="None" />
							</asp:HyperLink>
							<div class="rvdsfCartProduct">
								<asp:HyperLink ID="ProductNameHyperLink" runat="server" NavigateUrl='<%# Eval("ProductUrl") %>' Text='<%# Eval("ProductName") %>'></asp:HyperLink>
								<dl class="rvdsfProductParts">
									<asp:Literal ID="ProductPartLiteral" runat="server" Text='<%# Eval("ProductPart") %>' />
								</dl>
								<dl class="rvdsfDynamicFormResults">
									<asp:Literal ID="DynamicFormResultLiteral" runat="server" Text='<%# Eval("DynamicFormResult") %>' />
								</dl>
							</div>
						</ItemTemplate>
					</asp:TemplateField>
					<asp:BoundField DataField="Price" HeaderText="PriceHeaderSalesOrderDetailGridView" HeaderStyle-HorizontalAlign="Left" ItemStyle-Width="150px" />
					<asp:BoundField DataField="Quantity" HeaderText="QuantityHeaderSalesOrderDetailGridView" HeaderStyle-HorizontalAlign="Left" ItemStyle-Width="100px" />
					<asp:BoundField DataField="Amount" HeaderText="AmountHeaderSalesOrderDetailGridView" HeaderStyle-HorizontalAlign="Left" ItemStyle-Width="100px" />
				</Columns>
			</asp:GridView>
			<br />
			<dl class="rvdsfDynamicFormResults">
				<asp:Literal ID="CheckoutDynamicFormResultLiteral" runat="server" />
			</dl>
			<br />
			<br />
			<table cellspacing="1" style="width: 100%" cellpadding="0">
				<tr>
					<td style="vertical-align: top">
						<asp:Panel ID="SalesOrderMethodsPanel" runat="server">
							<table border="0" cellpadding="3" cellspacing="0" style="width: 100%">
								<tr>
									<td style="width: 150px">
										<dnn1:LabelControl ID="SalesOrderMethodsLabelControl" runat="server" CssClass="NormalBold" />
									</td>
									<td>
										<asp:RadioButtonList ID="SalesOrderMethodsRadioButtonList" runat="server" AutoPostBack="True" OnSelectedIndexChanged="SalesOrderMethodsRadioButtonList_SelectedIndexChanged" RepeatDirection="Horizontal">
											<asp:ListItem Selected="True" Value="Regular Purchase" resourcekey="RegularPurchaseSalesOrderMethodsListItem">Regular Purchase</asp:ListItem>
											<asp:ListItem Value="Purchase Order" resourcekey="PurchaseOrderSalesOrderMethodsListItem">Purchase Order</asp:ListItem>
										</asp:RadioButtonList>
									</td>
								</tr>
							</table>
							<asp:Panel ID="PurchaseOrderPanel" runat="server">
								<table cellpadding="3" cellspacing="0" style="width: 100%">
									<tr>
										<td style="width: 150px">
											<dnn1:LabelControl ID="PurchaseOrderNumberLabelControl" runat="server" />
										</td>
										<td>
											<asp:TextBox ID="PurchaseOrderNumberTextBox" runat="server" Width="300px"></asp:TextBox>
										</td>
									</tr>
								</table>
							</asp:Panel>
						</asp:Panel>
						<br />
						<asp:Panel ID="PaymentMethodsPanel" runat="server">
							<asp:Panel ID="VoucherPanel" runat="server">
								<table cellpadding="3" cellspacing="0" style="width: 100%">
									<tr>
										<td style="width: 150px; vertical-align: top">
											<dnn1:LabelControl ID="VoucherLabelControl" runat="server" />
										</td>
										<td>
											<asp:TextBox ID="VoucherCodeTextBox" runat="server" MaxLength="100" Width="150px" AutoCompleteType="Disabled"></asp:TextBox>
											<dnn2:DnnRadButton ID="AddVoucherDnnRadButton" runat="server" ButtonType="LinkButton" Text="AddVoucherDnnRadButton" Skin="" OnClick="AddVoucherDnnRadButton_Click" ValidationGroup="CheckoutDisplayTemplate" Icon-PrimaryIconUrl="~/DesktopModules/Revindex.Dnn.RevindexStorefront/Media/AddIcon.gif" CausesValidation="False">
											</dnn2:DnnRadButton>
											<asp:DataList ID="VoucherDataList" runat="server" HorizontalAlign="Left" RepeatColumns="2" RepeatDirection="Horizontal" Width="100%" CellSpacing="5">
												<ItemTemplate>
													<asp:ImageButton ID="RemoveVoucherImageButton" runat="server" CommandArgument='<%# Eval("Code") %>' ImageAlign="AbsMiddle" ImageUrl="../../../../../Media/DeleteIcon.gif" OnClick="RemoveVoucherImageButton_Click" CausesValidation="False" />
													&nbsp;<asp:Label ID="VoucherCodeLabel" runat="server" CssClass="NormalBold" Text='<%# Eval("Code") %>'></asp:Label>
													(<asp:Label ID="VoucherAmountLabel" runat="server" CssClass="NormalBold" Text='<%# Eval("Amount") %>'></asp:Label>) &nbsp;
												</ItemTemplate>
											</asp:DataList>
										</td>
									</tr>
								</table>
							</asp:Panel>
							<table cellpadding="3" cellspacing="0" width="100%">
								<tr>
									<td style="width: 150px; vertical-align: top;">
										<dnn1:LabelControl ID="PaymentMethodLabelControl" runat="server" CssClass="NormalBold" />
									</td>
									<td>
										<asp:RadioButtonList ID="PaymentMethodRadioButtonList" runat="server" AutoPostBack="True" OnSelectedIndexChanged="PaymentMethodRadioButtonList_SelectedIndexChanged" RepeatColumns="2">
											<asp:ListItem resourcekey="NonePaymentMethodListItem" Value="7">None</asp:ListItem>
											<asp:ListItem resourcekey="AuthorizeNetSIMPaymentMethodListItem" Value="13">Authorize.Net SIM</asp:ListItem>
											<asp:ListItem resourcekey="CashPaymentMethodListItem" Value="1">Cash</asp:ListItem>
											<asp:ListItem resourcekey="CheckPaymentMethodListItem" Value="2">Check</asp:ListItem>
											<asp:ListItem resourcekey="CreditCardPaymentMethodListItem" Value="3">Credit Card</asp:ListItem>
											<asp:ListItem resourcekey="MasterCardIGSHostedPaymentMethodListItem" Value="14">MasterCard virtual payment</asp:ListItem>
											<asp:ListItem resourcekey="MolliePaymentMethodListItem" Value="11">Mollie</asp:ListItem>
											<asp:ListItem resourcekey="MoneyOrderPaymentMethodListItem" Value="4">Money Order</asp:ListItem>
											<asp:ListItem resourcekey="PayFastPaymentMethodListItem" Value="8">PayFast</asp:ListItem>
											<asp:ListItem resourcekey="PayPalPaymentMethodListItem" Value="6">PayPal</asp:ListItem>
											<asp:ListItem resourcekey="Paystation3PartyPaymentMethodListItem" Value="15">Paystation</asp:ListItem>
											<asp:ListItem resourcekey="SuomenVerkkomaksutPaymentMethodListItem" Value="12">Suomen Verkkomaksut</asp:ListItem>
											<asp:ListItem resourcekey="TowahPaymentMethodListItem" Value="9">Towah</asp:ListItem>
											<asp:ListItem resourcekey="WireTransferPaymentMethodListItem" Value="5">Wire Transfer</asp:ListItem>
										</asp:RadioButtonList>
									</td>
								</tr>
							</table>
							<asp:Panel ID="CreditCardPanel" runat="server">
								<table cellpadding="3" cellspacing="0" style="width: 100%">
									<tr>
										<td style="width: 150px">
											<dnn1:LabelControl ID="CreditCardNumberLabelControl" runat="server" CssClass="NormalBold" />
											<asp:RequiredFieldValidator ID="CreditCardNumberRequiredFieldValidator" resourcekey="CreditCardNumberRequiredFieldValidator" runat="server" ControlToValidate="CreditCardNumberTextBox" CssClass="NormalRed" Display="Dynamic" ValidationGroup="CheckoutDisplayTemplate"></asp:RequiredFieldValidator>
											<asp:RegularExpressionValidator ID="CreditCardRegularExpressionValidator" resourcekey="CreditCardRegularExpressionValidator" runat="server" ControlToValidate="CreditCardNumberTextBox" CssClass="NormalRed" Display="Dynamic" ValidationExpression="[\d ]{13,24}" ValidationGroup="CheckoutDisplayTemplate"></asp:RegularExpressionValidator>
										</td>
										<td>
											<asp:TextBox ID="CreditCardNumberTextBox" runat="server" MaxLength="24" Width="300px" AutoCompleteType="Disabled" autocomplete="off"></asp:TextBox>
										</td>
									</tr>
									<tr>
										<td>
											<dnn1:LabelControl ID="CreditCardExpiryLabelControl" runat="server" CssClass="NormalBold" />
											<asp:RequiredFieldValidator ID="ExpirationYearRequiredFieldValidator" resourcekey="ExpirationYearRequiredFieldValidator" runat="server" ControlToValidate="ExpirationYearTextBox" CssClass="NormalRed" Display="Dynamic" ValidationGroup="CheckoutDisplayTemplate"></asp:RequiredFieldValidator><asp:RegularExpressionValidator ID="ExpirationYearRegularExpressionValidator" runat="server" resourcekey="ExpirationYearRegularExpressionValidator" ControlToValidate="ExpirationYearTextBox" CssClass="NormalRed" Display="Dynamic" ValidationExpression="^\d{4}$" ValidationGroup="CheckoutDisplayTemplate"></asp:RegularExpressionValidator>
										</td>
										<td>
											<table cellpadding="0" cellspacing="0" style="width: 300px">
												<tr>
													<td style="white-space: nowrap">
														<asp:DropDownList ID="ExpirationMonthDropDownList" runat="server">
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
														&nbsp;<asp:TextBox ID="ExpirationYearTextBox" runat="server" Columns="4" MaxLength="4" Width="50px" AutoCompleteType="Disabled" autocomplete="off"></asp:TextBox>
													</td>
													<td>
														<dnn1:LabelControl ID="CreditCardVerificationNumberLabelControl" runat="server" CssClass="NormalBold" />
														<asp:RequiredFieldValidator ID="CreditCardVerificationNumberRequiredFieldValidator" resourcekey="CreditCardVerificationNumberRequiredFieldValidator" runat="server" ControlToValidate="CreditCardVerificationNumberTextBox" CssClass="NormalRed" Display="Dynamic" ValidationGroup="CheckoutDisplayTemplate"></asp:RequiredFieldValidator>
														<asp:RegularExpressionValidator ID="CreditCardVerificationNumberRegularExpressionValidator" resourcekey="CreditCardVerificationNumberRegularExpressionValidator" runat="server" ControlToValidate="CreditCardVerificationNumberTextBox" CssClass="NormalRed" Display="Dynamic" ValidationExpression="\d+" ValidationGroup="CheckoutDisplayTemplate"></asp:RegularExpressionValidator>
													</td>
													<td style="text-align: right">
														<asp:TextBox ID="CreditCardVerificationNumberTextBox" runat="server" MaxLength="5" Width="50px" AutoCompleteType="Disabled" autocomplete="off"></asp:TextBox>
													</td>
												</tr>
											</table>
										</td>
									</tr>
								</table>
							</asp:Panel>
							<asp:Panel ID="MolliePanel" runat="server">
								<table cellpadding="3" cellspacing="0" style="width: 100%">
									<tr>
										<td style="width: 150px">
											<dnn1:LabelControl ID="InstitutionNumberLabelControl" runat="server" CssClass="NormalBold" />
										</td>
										<td>
											<asp:DropDownList ID="InstitutionNumberDropDownList" runat="server" Width="300px">
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
										</td>
									</tr>
								</table>
							</asp:Panel>
						</asp:Panel>
					</td>
					<td style="width: 250px; vertical-align: top">
						<table cellpadding="3" cellspacing="0" style="width: 100%">
							<tr>
								<td style="text-align: right">
									<dnn1:LabelControl ID="TotalSalesOrderDetailDiscountLabelControl" runat="server" />
								</td>
								<td style="width: 100px; text-align: right">
									<asp:Label ID="TotalSalesOrderDetailDiscountLabel" runat="server"></asp:Label>
								</td>
							</tr>
							<tr>
								<td style="text-align: right">
									<dnn1:LabelControl ID="SubTotalLabelControl" runat="server" CssClass="NormalBold" />
								</td>
								<td style="width: 100px; text-align: right">
									<asp:Label ID="SubTotalLabel" runat="server" Font-Bold="True"></asp:Label>
								</td>
							</tr>
							<tr>
								<td style="text-align: right">
									<dnn1:LabelControl ID="ShippingLabelControl" runat="server" />
								</td>
								<td style="width: 100px; text-align: right">
									<asp:Label ID="ShippingLabel" runat="server"></asp:Label>
								</td>
							</tr>
							<tr>
								<td style="text-align: right">
									<dnn1:LabelControl ID="HandlingLabelControl" runat="server" />
								</td>
								<td style="width: 100px; text-align: right">
									<asp:Label ID="HandlingLabel" runat="server"></asp:Label>
								</td>
							</tr>
							<tr>
								<td style="text-align: right">
									<dnn1:LabelControl ID="TaxesLabelControl" runat="server" />
								</td>
								<td style="width: 100px; text-align: right">
									<asp:Label ID="TaxesLabel" runat="server"></asp:Label>
								</td>
							</tr>
							<tr>
								<td style="text-align: right">
									<dnn1:LabelControl ID="TotalLabelControl" runat="server" CssClass="NormalBold" />
								</td>
								<td style="width: 100px; text-align: right; border-top-style: solid; border-top-width: 1px; border-top-color: #000000;">
									<asp:Label ID="TotalLabel" runat="server" Font-Bold="True"></asp:Label>
								</td>
							</tr>
							<tr>
								<td style="text-align: right">
									<dnn1:LabelControl ID="TotalDiscountLabelControl" runat="server" CssClass="NormalBold" />
								</td>
								<td style="width: 100px; text-align: right">
									<asp:Label ID="TotalDiscountLabel" runat="server" CssClass="NormalRed"></asp:Label>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</ContentTemplate>
	</asp:UpdatePanel>
	<br />
	<table cellspacing="1" style="width: 100%">
		<tr>
			<td>
				<dnn2:DnnRadButton ID="ViewBillingDnnRadButton" runat="server" OnClick="ViewBillingDnnRadButton_Click" ValidationGroup="CheckoutDisplayTemplate" Text="ViewBillingDnnRadButton" Icon-PrimaryIconUrl="~/DesktopModules/Revindex.Dnn.RevindexStorefront/Media/BackIcon.gif" CausesValidation="False">
				</dnn2:DnnRadButton>
			</td>
			<td style="text-align: right">
				<dnn2:DnnRadButton ID="PlaceOrderDnnRadButton" runat="server" OnClick="PlaceOrderDnnRadButton_Click" ValidationGroup="CheckoutDisplayTemplate" Text="PlaceOrderDnnRadButton" Icon-PrimaryIconUrl="~/DesktopModules/Revindex.Dnn.RevindexStorefront/Media/OKIcon.gif" OnClientClicked="PlaceOrderDnnRadButton_ClientClicked" UseSubmitBehavior="False">
				</dnn2:DnnRadButton>

				<script type="text/javascript">
					function PlaceOrderDnnRadButton_ClientClicked(sender, eventArgs) {
						if (typeof (Page_ClientValidate) != 'function' || Page_ClientValidate("CheckoutDisplayTemplate"))
							sender.set_enabled(false);
					}
				</script>

			</td>
		</tr>
	</table>
	<br />
</asp:Panel>
<table cellpadding="3" cellspacing="0" style="width: 100%">
	<tr>
		<td>
			<asp:Label ID="SummaryLabel" runat="server" CssClass="NormalRed"></asp:Label>
		</td>
	</tr>
</table>
