<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ViewRevindexStorefrontManagePayment.ascx.cs" Inherits="Revindex.Dnn.RevindexStorefront.ViewRevindexStorefrontManagePayment" %>
<%@ Register Src="~/Controls/labelcontrol.ascx" TagName="LabelControl" TagPrefix="dnn1" %>
<%@ Register Assembly="DotNetNuke.Web.Deprecated" Namespace="DotNetNuke.Web.UI.WebControls" TagPrefix="dnn2" %>
<%@ Register Src="UserAddressDropDownListControl.ascx" TagName="UserAddressDropDownListControl" TagPrefix="uc1" %>
<%@ Register Src="WebUserControls/Common/Dnn/BackControl.ascx" TagName="BackControl" TagPrefix="uc1" %>
<asp:PlaceHolder runat="server">

	<script type="text/javascript">
		jQuery(function ($)
		{
			jQuery('#UserPaymentDetailsViewTabPanel').dnnTabs();
		});
	</script>

</asp:PlaceHolder>
<div class="rvdsfManagePaymentContainer">
	<asp:PlaceHolder ID="MessagePlaceHolder" runat="server" />
	<asp:MultiView ID="ContentMultiView" runat="server">
		<asp:View ID="ListView" runat="server">
			<div class="dnnForm rvdsfListContainer">
				<asp:GridView ID="UserPaymentGridView" runat="server" AutoGenerateColumns="False" CssClass="dnnGrid" GridLines="None" OnRowDataBound="UserPaymentGridView_RowDataBound" DataKeyNames="UserPaymentID" OnRowDeleting="UserPaymentGridView_RowDeleting">
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
						<asp:BoundField DataField="PaymentMethod" HeaderText="PaymentMethodHeaderUserPaymentGridView" SortExpression="PaymentMethod" />
						<asp:BoundField DataField="BillingAddress" HeaderText="BillingAddressHeaderUserPaymentGridView" />
					</Columns>
				</asp:GridView>
				<ul class="dnnActions dnnClear">
					<li>
						<asp:HyperLink ID="AddHyperLink" runat="server" Text="Add new" CssClass="dnnPrimaryAction rvdAddNewAction" resourcekey="AddHyperLink"/>
					</li>
				</ul>
			</div>
		</asp:View>
		<asp:View ID="DetailsView" runat="server">
			<div id="UserPaymentDetailsViewTabPanel" class="dnnForm">
				<ul class="dnnAdminTabNav dnnClear">
					<li><a href="#<%= GeneralDetailsViewPanel.ClientID %>">
						<asp:Label ID="GeneralDetailsViewTabLabel" runat="server" resourcekey="GeneralDetailsViewTabLabel" /></a></li>
				</ul>
				<asp:Panel ID="GeneralDetailsViewPanel" runat="server" CssClass="dnnClear">
					<fieldset>
						<div class="dnnFormItem">
							<dnn1:LabelControl ID="PaymentMethodLabelControl" runat="server" />
							<asp:DropDownList ID="PaymentMethodDropDownList" runat="server" AutoPostBack="True" OnSelectedIndexChanged="PaymentMethodDropDownList_SelectedIndexChanged">
                                <asp:ListItem resourcekey="ACHPaymentMethodListItem" Value="23">ACH</asp:ListItem>
								<asp:ListItem resourcekey="AuthorizeNetCIMPaymentMethodListItem" Value="18">Authorize.Net CIM</asp:ListItem>
								<asp:ListItem resourcekey="AuthorizeNetSIMPaymentMethodListItem" Value="13">Authorize.Net SIM</asp:ListItem>
								<asp:ListItem resourcekey="CashPaymentMethodListItem" Value="1">Cash</asp:ListItem>
								<asp:ListItem resourcekey="CheckPaymentMethodListItem" Value="2">Check</asp:ListItem>
								<asp:ListItem resourcekey="CreditCardPaymentMethodListItem" Value="3">Credit Card</asp:ListItem>
								<asp:ListItem resourcekey="DotpayPaymentMethodListItem" Value="21">Dotpay</asp:ListItem>
								<asp:ListItem resourcekey="MasterCardIGSHostedPaymentMethodListItem" Value="14">MasterCard virtual payment</asp:ListItem>
								<asp:ListItem resourcekey="MolliePaymentMethodListItem" Value="11">Mollie</asp:ListItem>
								<asp:ListItem resourcekey="MoneyOrderPaymentMethodListItem" Value="4">Money Order</asp:ListItem>
								<asp:ListItem resourcekey="NonePaymentMethodListItem" Value="7">None</asp:ListItem>
								<asp:ListItem resourcekey="PaymentExpressPaymentMethodListItem" Value="22">Payment Express</asp:ListItem>
								<asp:ListItem resourcekey="PayFastPaymentMethodListItem" Value="8">PayFast</asp:ListItem>
								<asp:ListItem resourcekey="PayPalPaymentMethodListItem" Value="6">PayPal</asp:ListItem>
								<asp:ListItem resourcekey="Paystation3PartyPaymentMethodListItem" Value="15">Paystation</asp:ListItem>
								<asp:ListItem resourcekey="PayUBusinessPaymentMethodListItem" Value="19">PayU Business</asp:ListItem>
								<asp:ListItem resourcekey="SagePayFormPaymentMethodListItem" Value="17">Sage Pay</asp:ListItem>
								<asp:ListItem resourcekey="SuomenVerkkomaksutPaymentMethodListItem" Value="12">Suomen Verkkomaksut</asp:ListItem>
								<asp:ListItem resourcekey="TowahPaymentMethodListItem" Value="9">Towah</asp:ListItem>
								<asp:ListItem resourcekey="VirtualCardServicesPayPaymentMethodListItem" Value="20">Virtual Card Services Pay</asp:ListItem>
								<asp:ListItem resourcekey="VoucherPaymentMethodListItem" Value="10">Voucher</asp:ListItem>
								<asp:ListItem resourcekey="WireTransferPaymentMethodListItem" Value="5">Wire Transfer</asp:ListItem>
							</asp:DropDownList>
						</div>
                        <asp:Panel ID="ACHPanel" runat="server">
                            <div class="dnnFormItem">
                                <dnn1:LabelControl ID="InstitutionNameLabelControl" Text="Bank name:" runat="server" CssClass="dnnFormRequired" />
                                <asp:RequiredFieldValidator ID="InstitutionNameRequiredFieldValidator" resourcekey="InstitutionNameRequiredFieldValidator" runat="server" ControlToValidate="InstitutionNameTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="UserPaymentDetailsViewControl">Bank name is required.</asp:RequiredFieldValidator>
                                <asp:TextBox ID="InstitutionNameTextBox" runat="server" CssClass="dnnFormRequired" />
                            </div>
                            <div class="dnnFormItem">
                                <dnn1:LabelControl ID="InstitutionNumberLabelControl" Text="Routing Number:" runat="server" CssClass="dnnFormRequired" />
                                <asp:RequiredFieldValidator ID="InstitutionNumberRequiredFieldValidator" resourcekey="InstitutionNumberRequiredFieldValidator" runat="server" ControlToValidate="InstitutionNumberTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="UserPaymentDetailsViewControl">Routing number is required.</asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="InstitutionNumberRegularExpressionValidator" runat="server" ControlToValidate="InstitutionNumberTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationExpression="[\d]{6,20}" ValidationGroup="UserPaymentDetailsViewControl">Routing number is invalid.</asp:RegularExpressionValidator>
                                <asp:TextBox ID="InstitutionNumberTextBox" runat="server" CssClass="dnnFormRequired" />
                            </div>
                            <div class="dnnFormItem">
                                <dnn1:LabelControl ID="AccountTypeLabelControl" Text="Account type:" runat="server" CssClass="dnnFormRequired" />
                                <asp:DropDownList ID="AccountTypeDropDownList" runat="server">
						            <asp:ListItem Text="Checking" Value="1" />
						            <asp:ListItem Text="Savings" Value="2" />
					            </asp:DropDownList>
                            </div>
                            <div class="dnnFormItem">
                                <dnn1:LabelControl ID="AccountNumberLabelControl" runat="server" Text="Account Number:" CssClass="dnnFormRequired" />
                                <asp:RequiredFieldValidator ID="AccountNumberRequiredFieldValidator" runat="server" ControlToValidate="AccountNumberTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="UserPaymentDetailsViewControl">Account number is required.</asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="AccountNumberRegularExpressionValidator" runat="server" ControlToValidate="AccountNumberTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationExpression="[\*\d]{6,20}" ValidationGroup="UserPaymentDetailsViewControl">Account number is invalid.</asp:RegularExpressionValidator>
                                <asp:TextBox ID="AccountNumberTextBox" runat="server" MaxLength="24" CssClass="dnnFormRequired" AutoCompleteType="Disabled"></asp:TextBox>
                            </div>
                        </asp:Panel>
						<asp:Panel ID="CreditCardPanel" runat="server">
							<div class="dnnFormItem">
								<dnn1:LabelControl ID="CreditCardNumberLabelControl" runat="server" CssClass="dnnFormRequired" />
								<asp:RequiredFieldValidator ID="CreditCardNumberRequiredFieldValidator" resourcekey="CreditCardNumberRequiredFieldValidator" runat="server" ControlToValidate="CreditCardNumberTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="UserPaymentDetailsViewControl"></asp:RequiredFieldValidator>
								<asp:RegularExpressionValidator ID="CreditCardNumberRegularExpressionValidator" resourcekey="CreditCardNumberRegularExpressionValidator" runat="server" ControlToValidate="CreditCardNumberTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationExpression="[\*\d ]{13,24}" ValidationGroup="UserPaymentDetailsViewControl"></asp:RegularExpressionValidator>
								<asp:TextBox ID="CreditCardNumberTextBox" runat="server" MaxLength="24" AutoCompleteType="Disabled" CssClass="dnnFormRequired"></asp:TextBox>
							</div>
							<div class="dnnFormItem">
								<dnn1:LabelControl ID="CreditCardExpiryLabelControl" runat="server" CssClass="dnnFormRequired" />
								<asp:RequiredFieldValidator ID="CreditCardExpiryYearRequiredFieldValidator" runat="server" ControlToValidate="CreditCardExpiryYearTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" resourcekey="CreditCardExpiryYearRequiredFieldValidator" ValidationGroup="UserPaymentDetailsViewControl"></asp:RequiredFieldValidator>
								<asp:RegularExpressionValidator ID="CreditCardExpiryYearRegularExpressionValidator" runat="server" ControlToValidate="CreditCardExpiryYearTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" resourcekey="CreditCardExpiryYearRegularExpressionValidator" ValidationExpression="^\d{4}$" ValidationGroup="UserPaymentDetailsViewControl"></asp:RegularExpressionValidator>
								<asp:DropDownList ID="CreditCardExpiryMonthDropDownList" runat="server" CssClass="dnnFormRequired rvdsfCreditCardExpiryMonthInput">
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
								<asp:TextBox ID="CreditCardExpiryYearTextBox" runat="server" Columns="4" MaxLength="4" CssClass="dnnFormRequired rvdsfCreditCardExpiryYearInput" AutoCompleteType="Disabled"></asp:TextBox>
							</div>
							<div class="dnnFormItem">
								<dnn1:LabelControl ID="CreditCardVerificationNumberLabelControl" runat="server" />
								<asp:TextBox ID="CreditCardVerificationNumberTextBox" runat="server" MaxLength="5" CssClass="rvdsfCreditCardVerificationNumberInput"></asp:TextBox>
							</div>
						</asp:Panel>
						<asp:Panel ID="TokenPanel" runat="server">
							<div class="dnnFormItem">
								<dnn1:LabelControl ID="ProfileNumberLabelControl" runat="server" />
								<asp:Label ID="ProfileNumberLabel" runat="server"></asp:Label>
							</div>
							<div class="dnnFormItem">
								<dnn1:LabelControl ID="PaymentNumberLabelControl" runat="server" />
								<asp:Label ID="PaymentNumberLabel" runat="server"></asp:Label>
							</div>
						</asp:Panel>
						<asp:Panel ID="PaymentProfilePanel" runat="server" CssClass="dnnFormItem">
							<dnn1:LabelControl ID="PaymentProfileLabelControl" runat="server" CssClass="dnnFormRequired" />
							<asp:RequiredFieldValidator ID="PaymentProfileRequiredFieldValidator" resourcekey="PaymentProfileRequiredFieldValidator" runat="server" ControlToValidate="PaymentProfileRadioButtonList" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="UserPaymentDetailsViewControl">Payment profile is required.</asp:RequiredFieldValidator>
							<div class="rvdFormSubContainer">
								<asp:RadioButtonList ID="PaymentProfileRadioButtonList" runat="server" CssClass="dnnFormRadioButtons dnnFormRequired" RepeatLayout="Flow" ValidationGroup="UserPaymentDetailsViewControl"></asp:RadioButtonList>
								<div class="rvdActions">
									<asp:LinkButton ID="CreatePaymentLinkButton" runat="server" OnClick="CreatePaymentLinkButton_Click" CausesValidation="False" resourcekey="CreatePaymentLinkButton" CssClass="dnnPrimaryAction rvdAddNewAction" />
									<asp:LinkButton ID="EditPaymentLinkButton" runat="server" OnClick="EditPaymentLinkButton_Click" CausesValidation="False" resourcekey="EditPaymentLinkButton" CssClass="dnnPrimaryAction rvdEditAction" />
									<asp:LinkButton ID="DeletePaymentLinkButton" runat="server" OnClick="DeletePaymentLinkButton_Click" CausesValidation="False" resourcekey="DeletePaymentLinkButton" CssClass="dnnSecondaryAction rvdDeleteAction" />
									<asp:LinkButton ID="UpdatePaymentLinkButton" runat="server" OnClick="UpdatePaymentLinkButton_Click" CausesValidation="False" resourcekey="UpdatePaymentLinkButton" CssClass="dnnSecondaryAction" Style="display: none" />
								</div>
							</div>
						</asp:Panel>
						<asp:Panel ID="VoucherPanel" runat="server">
							<div class="dnnFormItem">
								<dnn1:LabelControl ID="VoucherCodeLabelControl" runat="server" CssClass="dnnFormRequired" />
								<asp:RequiredFieldValidator ID="VoucherCodeRequiredFieldValidator" resourcekey="VoucherCodeRequiredFieldValidator" runat="server" ControlToValidate="VoucherCodeTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="UserPaymentDetailsViewControl"></asp:RequiredFieldValidator>
								<asp:TextBox ID="VoucherCodeTextBox" runat="server" MaxLength="255" AutoCompleteType="Disabled" CssClass="dnnFormRequired"></asp:TextBox>
							</div>
						</asp:Panel>
						<div class="dnnFormItem">
							<dnn1:LabelControl ID="UserAddressLabelControl" runat="server" />
							<uc1:UserAddressDropDownListControl ID="UserAddressDropDownListControl" runat="server" AutoPostBack="True" />
						</div>
						<div class="dnnFormItem">
							<dnn1:LabelControl ID="FirstNameLabelControl" runat="server" CssClass="dnnFormRequired" />
							<asp:RequiredFieldValidator ID="FirstNameRequiredFieldValidator" runat="server" resourcekey="FirstNameRequiredFieldValidator" ControlToValidate="FirstNameTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="UserPaymentDetailsViewControl"></asp:RequiredFieldValidator>
							<asp:TextBox ID="FirstNameTextBox" runat="server" MaxLength="50" CssClass="dnnFormRequired"></asp:TextBox>
						</div>
						<div class="dnnFormItem">
							<dnn1:LabelControl ID="LastNameLabelControl" runat="server" CssClass="dnnFormRequired" />
							<asp:RequiredFieldValidator ID="LastNameRequiredFieldValidator" runat="server" ControlToValidate="LastNameTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" resourcekey="LastNameRequiredFieldValidator" ValidationGroup="UserPaymentDetailsViewControl"></asp:RequiredFieldValidator>
							<asp:TextBox ID="LastNameTextBox" runat="server" MaxLength="50" CssClass="dnnFormRequired"></asp:TextBox>
						</div>
						<div class="dnnFormItem">
							<dnn1:LabelControl ID="CompanyLabelControl" runat="server" />
							<asp:TextBox ID="CompanyTextBox" runat="server" MaxLength="100"></asp:TextBox>
						</div>
						<div class="dnnFormItem">
							<dnn1:LabelControl ID="CountryLabelControl" runat="server" CssClass="dnnFormRequired"/>
							<asp:RequiredFieldValidator ID="CountryRequiredFieldValidator" resourcekey="CountryRequiredFieldValidator" runat="server" ControlToValidate="CountryDropDownList" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="UserPaymentDetailsViewControl"></asp:RequiredFieldValidator>
							<asp:DropDownList ID="CountryDropDownList" runat="server" AutoPostBack="True" OnSelectedIndexChanged="CountryDropDownList_SelectedIndexChanged">
							</asp:DropDownList>
						</div>
						<div class="dnnFormItem">
							<dnn1:LabelControl ID="StreetLabelControl" runat="server" CssClass="dnnFormRequired" />
							<asp:RequiredFieldValidator ID="StreetRequiredFieldValidator" runat="server" ControlToValidate="StreetTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" resourcekey="StreetRequiredFieldValidator" ValidationGroup="UserPaymentDetailsViewControl"></asp:RequiredFieldValidator>
							<asp:RegularExpressionValidator ID="StreetRegularExpressionValidator" resourcekey="StreetRegularExpressionValidator" runat="server" ControlToValidate="StreetTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationExpression="^[\s\S]{0,200}$" ValidationGroup="UserPaymentDetailsViewControl"></asp:RegularExpressionValidator>
							<asp:TextBox ID="StreetTextBox" runat="server" Rows="2" TextMode="MultiLine" MaxLength="200" CssClass="dnnFormRequired"></asp:TextBox>
						</div>
						<div class="dnnFormItem">
							<dnn1:LabelControl ID="CityLabelControl" runat="server" CssClass="dnnFormRequired" />
							<asp:RequiredFieldValidator ID="CityRequiredFieldValidator" runat="server" resourcekey="CityRequiredFieldValidator" ControlToValidate="CityTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="UserPaymentDetailsViewControl"></asp:RequiredFieldValidator>
							<asp:TextBox ID="CityTextBox" runat="server" MaxLength="20" CssClass="dnnFormRequired"></asp:TextBox>
						</div>
						<div class="dnnFormItem">
							<dnn1:LabelControl ID="SubdivisionLabelControl" runat="server" />
							<asp:DropDownList ID="SubdivisionDropDownList" runat="server">
							</asp:DropDownList>
						</div>
						<div class="dnnFormItem">
							<dnn1:LabelControl ID="PostalCodeLabelControl" runat="server" CssClass="dnnFormRequired" />
							<asp:RequiredFieldValidator ID="PostalCodeRequiredFieldValidator" resourcekey="PostalCodeRequiredFieldValidator" runat="server" ControlToValidate="PostalCodeTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="UserPaymentDetailsViewControl"></asp:RequiredFieldValidator>
							<asp:TextBox ID="PostalCodeTextBox" runat="server" MaxLength="10" CssClass="dnnFormRequired"></asp:TextBox>
						</div>
						<div class="dnnFormItem">
							<dnn1:LabelControl ID="PhoneLabelControl" runat="server" CssClass="dnnFormRequired" />
							<asp:RequiredFieldValidator ID="PhoneRequiredFieldValidator" runat="server" resourcekey="PhoneRequiredFieldValidator" ControlToValidate="PhoneTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="UserPaymentDetailsViewControl"></asp:RequiredFieldValidator>
							<asp:TextBox ID="PhoneTextBox" runat="server" MaxLength="50" CssClass="dnnFormRequired"></asp:TextBox>
						</div>
						<div class="dnnFormItem">
							<dnn1:LabelControl ID="EmailLabelControl" runat="server" />
							<asp:RegularExpressionValidator ID="EmailRegularExpressionValidator" runat="server" ControlToValidate="EmailTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" resourcekey="EmailRegularExpressionValidator" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ValidationGroup="UserPaymentDetailsViewControl"></asp:RegularExpressionValidator>
							<asp:TextBox ID="EmailTextBox" runat="server" MaxLength="256"></asp:TextBox>
						</div>
					</fieldset>
				</asp:Panel>
			</div>
			<div class="dnnForm">
				<ul class="dnnActions">
					<li>
						<asp:LinkButton ID="SaveLinkButton" runat="server" resourcekey="SaveLinkButton" OnClick="SaveLinkButton_Click" CssClass="dnnPrimaryAction rvdSaveAction" ValidationGroup="UserPaymentDetailsViewControl" CommandArgument="Back"/>
					</li>
					<li>
                        <uc1:BackControl ID="BackControl" runat="server" Text="Cancel" ResourceKey="BackControl"/>
                    </li>
				</ul>
			</div>
		</asp:View>
	</asp:MultiView>
</div>
