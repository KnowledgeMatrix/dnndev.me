<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="UserPaymentControl.ascx.cs" Inherits="Revindex.Dnn.RevindexStorefront.UserPaymentControl" %>
<%@ Register Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Src="~/Controls/labelcontrol.ascx" TagName="LabelControl" TagPrefix="dnn1" %>
<%@ Register Assembly="DotNetNuke.Web.Deprecated" Namespace="DotNetNuke.Web.UI.WebControls" TagPrefix="dnn2" %>
<%@ Register Assembly="Revindex.Web.UI.WebControls" Namespace="Revindex.Web.UI.WebControls" TagPrefix="rvd1" %>
<%@ Register Src="UserAddressDropDownListControl.ascx" TagName="UserAddressDropDownListControl" TagPrefix="uc1" %>
<%@ Register Src="WebUserControls/Common/Dnn/BackControl.ascx" TagName="BackControl" TagPrefix="uc1" %>
<%@ Register Src="WebUserControls/Common/Dnn/BreadcrumbControl.ascx" TagName="BreadcrumbControl" TagPrefix="uc1" %>
<asp:PlaceHolder ID="PlaceHolder1" runat="server">

    <script type="text/javascript">
        jQuery(document).ready(function ()
        {
            jQuery('#UserPaymentDetailsViewTabPanel').dnnTabs();
        });
        Sys.WebForms.PageRequestManager.getInstance().add_endRequest(function ()
        {
            jQuery('#UserPaymentDetailsViewTabPanel').dnnTabs();
        });
    </script>

</asp:PlaceHolder>
<div>
    <asp:UpdatePanel ID="UpdatePanel1" UpdateMode="Conditional" runat="server">
        <ContentTemplate>
            <asp:PlaceHolder ID="MessagePlaceHolder" runat="server" />
            <asp:MultiView ID="ContentMultiView" runat="server">
                <asp:View ID="ListView" runat="server">
                    <div class="dnnForm rvdsfListContainer">
                        <asp:GridView ID="UserPaymentGridView" runat="server" AllowSorting="True" AutoGenerateColumns="False" CssClass="dnnGrid" GridLines="None" AllowPaging="True" DataKeyNames="UserPaymentID" OnRowDataBound="UserPaymentGridView_RowDataBound" OnRowDeleting="UserPaymentGridView_RowDeleting">
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
                                <asp:BoundField DataField="PaymentMethod" HeaderText="Payment method" SortExpression="PaymentMethod" />
                                <asp:BoundField DataField="Street" HeaderText="Address" />
                            </Columns>
                        </asp:GridView>
                        <asp:ObjectDataSource ID="UserPaymentObjectDataSource" runat="server" EnablePaging="True" SelectCountMethod="GetCountByUser" SelectMethod="GetAllByUser" SortParameterName="sortExpression" TypeName="Revindex.Business.Revindex.Revindex.Storefront.UserPaymentController">
                            <SelectParameters>
                                <asp:Parameter Name="sortExpression" Type="String" />
                                <asp:Parameter Name="maximumRows" Type="Int32" />
                                <asp:Parameter Name="startRowIndex" Type="Int32" />
                                <rvd1:UserControlParameter Name="userID" PropertyName="UserID" Type="Int32" />
                            </SelectParameters>
                        </asp:ObjectDataSource>
                        <ul class="dnnActions dnnClear">
                            <li>
                                <asp:HyperLink ID="AddHyperLink" runat="server" Text="Add new" CssClass="dnnPrimaryAction rvdAddNewAction" />
                            </li>
                        </ul>
                    </div>
                </asp:View>
                <asp:View ID="DetailsView" runat="server">
                    <uc1:BackControl ID="QuickBackControl" runat="server" Text="" CssClass="rvdsfBackAction" />
                    <h2>User payment: <uc1:BreadcrumbControl ID="BreadcrumbControl" runat="server" /></h2>
                    <div id="UserPaymentDetailsViewTabPanel" class="dnnForm">
                        <ul class="dnnAdminTabNav dnnClear">
                            <li><a href="#<%= GeneralDetailsViewPanel.ClientID %>">
                                <asp:Label ID="GeneralDetailsViewTabLabel" runat="server" Text="General" /></a></li>
                        </ul>
                        <asp:Panel ID="GeneralDetailsViewPanel" runat="server" CssClass="dnnClear">
                            <fieldset>
                                <div class="dnnFormItem">
                                    <dnn1:LabelControl ID="UserPaymentIDLabelControl" runat="server" Text="User payment ID:" />
                                    <asp:Label ID="UserPaymentIDLabel" runat="server"></asp:Label>
                                </div>
                                <div class="dnnFormItem">
                                    <dnn1:LabelControl ID="PaymentMethodLabelControl" runat="server" Text="Payment method:" />
                                    <asp:DropDownList ID="PaymentMethodDropDownList" runat="server" AutoPostBack="True" OnSelectedIndexChanged="PaymentMethodDropDownList_SelectedIndexChanged">
                                        <asp:ListItem Value="23">ACH</asp:ListItem>
                                        <asp:ListItem Value="18">Authorize.Net CIM</asp:ListItem>
                                        <asp:ListItem Value="13">Authorize.Net SIM</asp:ListItem>
                                        <asp:ListItem Value="1">Cash</asp:ListItem>
                                        <asp:ListItem Value="2">Check</asp:ListItem>
                                        <asp:ListItem Value="3">Credit Card</asp:ListItem>
                                        <asp:ListItem Value="21">Dotpay</asp:ListItem>
                                        <asp:ListItem Value="14">MasterCard virtual payment</asp:ListItem>
                                        <asp:ListItem Value="11">Mollie</asp:ListItem>
                                        <asp:ListItem Value="4">Money Order</asp:ListItem>
                                        <asp:ListItem Value="7">None</asp:ListItem>
										<asp:ListItem Value="22">Payment Express</asp:ListItem>
                                        <asp:ListItem Value="8">PayFast</asp:ListItem>
                                        <asp:ListItem Value="6">PayPal</asp:ListItem>
                                        <asp:ListItem Value="15">Paystation</asp:ListItem>
                                        <asp:ListItem Value="19">PayUBusiness</asp:ListItem>
                                        <asp:ListItem Value="17">Sage Pay</asp:ListItem>
                                        <asp:ListItem Value="12">Suomen Verkkomaksut</asp:ListItem>
                                        <asp:ListItem Value="9">Towah</asp:ListItem>
                                        <asp:ListItem Value="20">Virtual Card Services Pay</asp:ListItem>
                                        <asp:ListItem Value="10">Voucher</asp:ListItem>
                                        <asp:ListItem Value="5">Wire Transfer</asp:ListItem>
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
                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator4" runat="server" ControlToValidate="InstitutionNumberTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationExpression="[\d]{6,20}" ValidationGroup="UserPaymentDetailsViewControl">Routing number is invalid.</asp:RegularExpressionValidator>
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
                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="AccountNumberTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationExpression="[\d]{6,20}" ValidationGroup="UserPaymentDetailsViewControl">Account number is invalid.</asp:RegularExpressionValidator>
                                        <asp:TextBox ID="AccountNumberTextBox" runat="server" MaxLength="24" CssClass="dnnFormRequired" AutoCompleteType="Disabled"></asp:TextBox>
                                    </div>
                                </asp:Panel>
                                <asp:Panel ID="CreditCardPanel" runat="server">
                                    <div class="dnnFormItem">
                                        <dnn1:LabelControl ID="CreditCardNumberLabelControl" runat="server" Text="Credit Card Number:" CssClass="dnnFormRequired" />
                                        <asp:RequiredFieldValidator ID="CreditCardNumberRequiredFieldValidator" runat="server" ControlToValidate="CreditCardNumberTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="UserPaymentDetailsViewControl">Credit card number is required.</asp:RequiredFieldValidator>
                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="CreditCardNumberTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationExpression="[\d ]{13,24}" ValidationGroup="UserPaymentDetailsViewControl">Credit card number is invalid.</asp:RegularExpressionValidator>
                                        <asp:TextBox ID="CreditCardNumberTextBox" runat="server" MaxLength="24" CssClass="dnnFormRequired" AutoCompleteType="Disabled"></asp:TextBox>
                                    </div>
                                    <div class="dnnFormItem">
                                        <dnn1:LabelControl ID="CreditCardExpiryLabelControl" runat="server" Text="Expiry:" CssClass="dnnFormRequired" />
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator16" runat="server" ControlToValidate="CreditCardExpiryYearTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="UserPaymentDetailsViewControl">Expiration date is required.</asp:RequiredFieldValidator>
                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator10" runat="server" ControlToValidate="CreditCardExpiryYearTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationExpression="^\d{4}$" ValidationGroup="UserPaymentDetailsViewControl">Expiration date is invalid.</asp:RegularExpressionValidator>
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
                                        <asp:TextBox ID="CreditCardExpiryYearTextBox" runat="server" Columns="4" MaxLength="4" CssClass="dnnFormRequired rvdsfCreditCardExpiryYearInput" AutoCompleteType="Disabled">2010</asp:TextBox>
                                    </div>
                                    <div class="dnnFormItem">
                                        <dnn1:LabelControl ID="CreditCardVerificationNumberLabelControl" runat="server" Text="Security #:" />
                                        <asp:TextBox ID="CreditCardVerificationNumberTextBox" runat="server" MaxLength="5" CssClass="rvdsfCreditCardVerificationNumberInput"></asp:TextBox>
                                    </div>
                                </asp:Panel>
                                <asp:Panel ID="TokenPanel" runat="server">
                                    <div class="dnnFormItem">
                                        <dnn1:LabelControl ID="ProfileNumberLabelControl" runat="server" Text="Profile number:" />
                                        <asp:Label ID="ProfileNumberLabel" runat="server"></asp:Label>
                                    </div>
                                    <div class="dnnFormItem">
                                        <dnn1:LabelControl ID="PaymentNumberLabelControl" runat="server" Text="Payment number:" />
                                        <asp:Label ID="PaymentNumberLabel" runat="server"></asp:Label>
                                    </div>
                                </asp:Panel>
                                <asp:Panel ID="PaymentProfilePanel" runat="server" CssClass="dnnFormItem">
                                    <dnn1:LabelControl ID="PaymentProfileLabelControl" Text="Payment profile:" runat="server" CssClass="dnnFormRequired" />
                                    <asp:RequiredFieldValidator ID="PaymentProfileRequiredFieldValidator" runat="server" ControlToValidate="PaymentProfileRadioButtonList" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="UserPaymentDetailsViewControl">Payment profile is required.</asp:RequiredFieldValidator>
                                    <div class="rvdFormSubContainer">
                                        <asp:RadioButtonList ID="PaymentProfileRadioButtonList" runat="server" CssClass="dnnFormRadioButtons dnnFormRequired" RepeatLayout="Flow" ValidationGroup="UserPaymentDetailsViewControl"></asp:RadioButtonList>
                                        <div class="rvdActions">
                                            <asp:LinkButton ID="CreatePaymentLinkButton" runat="server" OnClick="CreatePaymentLinkButton_Click" CausesValidation="False" Text="Add new" CssClass="dnnPrimaryAction rvdAddNewAction" />
                                            <asp:LinkButton ID="EditPaymentLinkButton" runat="server" OnClick="EditPaymentLinkButton_Click" CausesValidation="False" Text="Edit" CssClass="dnnPrimaryAction rvdEditAction" />
                                            <asp:LinkButton ID="DeletePaymentLinkButton" runat="server" OnClick="DeletePaymentLinkButton_Click" CausesValidation="False" Text="Delete" CssClass="dnnSecondaryAction rvdDeleteAction" />
                                            <asp:LinkButton ID="UpdatePaymentLinkButton" runat="server" OnClick="UpdatePaymentLinkButton_Click" CausesValidation="False" Text="Update" CssClass="dnnSecondaryAction" Style="display: none" />
                                        </div>
                                    </div>
                                </asp:Panel>
                                <asp:Panel ID="VoucherPanel" runat="server">
                                    <div class="dnnFormItem">
                                        <dnn1:LabelControl ID="VoucherCodeLabelControl" runat="server" Text="Voucher code:" CssClass="dnnFormRequired" />
                                        <asp:RequiredFieldValidator ID="VoucherCodeRequiredFieldValidator" runat="server" ControlToValidate="VoucherCodeTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="UserPaymentDetailsViewControl">Voucher code is required.</asp:RequiredFieldValidator>
                                        <asp:TextBox ID="VoucherCodeTextBox" runat="server" MaxLength="255" CssClass="dnnFormRequired" AutoCompleteType="Disabled"></asp:TextBox>
                                    </div>
                                </asp:Panel>
                                <div class="dnnFormItem">
                                    <dnn1:LabelControl ID="UserAddressLabelControl" runat="server" Text="Use address book:" />
                                    <uc1:UserAddressDropDownListControl ID="UserAddressDropDownListControl" runat="server" AutoPostBack="True" />
                                </div>
                                <div class="dnnFormItem">
                                    <dnn1:LabelControl ID="FirstNameLabelControl" runat="server" Text="First name:" CssClass="dnnFormRequired" />
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="FirstNameTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="UserPaymentDetailsViewControl">First name is required.</asp:RequiredFieldValidator>
                                    <asp:TextBox ID="FirstNameTextBox" runat="server" MaxLength="50" CssClass="dnnFormRequired"></asp:TextBox>
                                </div>
                                <div class="dnnFormItem">
                                    <dnn1:LabelControl ID="LastNameLabelControl" runat="server" Text="Last name:" CssClass="dnnFormRequired" />
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="LastNameTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="UserPaymentDetailsViewControl">Last name is required.</asp:RequiredFieldValidator>
                                    <asp:TextBox ID="LastNameTextBox" runat="server" CssClass="dnnFormRequired" MaxLength="50"></asp:TextBox>
                                </div>
                                <div class="dnnFormItem">
                                    <dnn1:LabelControl ID="CompanyLabelControl" runat="server" Text="Company:" />
                                    <asp:TextBox ID="CompanyTextBox" runat="server" MaxLength="100"></asp:TextBox>
                                </div>
                                <div class="dnnFormItem">
                                    <dnn1:LabelControl ID="CountryLabelControl" runat="server" Text="Country:" />
                                    <asp:DropDownList ID="CountryDropDownList" runat="server" AutoPostBack="True" OnSelectedIndexChanged="CountryDropDownList_SelectedIndexChanged">
                                    </asp:DropDownList>
                                </div>
                                <div class="dnnFormItem">
                                    <dnn1:LabelControl ID="StreetLabelControl" runat="server" Text="Street:" CssClass="dnnFormRequired" />
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="StreetTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="UserPaymentDetailsViewControl">Street is required.</asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator5" runat="server" ControlToValidate="StreetTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationExpression="^[\s\S]{0,200}$" ValidationGroup="UserPaymentDetailsViewControl">Street is invalid.</asp:RegularExpressionValidator>
                                    <asp:TextBox ID="StreetTextBox" runat="server" MaxLength="200" Rows="2" TextMode="MultiLine" CssClass="dnnFormRequired"></asp:TextBox>
                                </div>
                                <div class="dnnFormItem">
                                    <dnn1:LabelControl ID="CityLabelControl" runat="server" Text="City:" CssClass="dnnFormRequired" />
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="CityTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="UserPaymentDetailsViewControl">City is required.</asp:RequiredFieldValidator>
                                    <asp:TextBox ID="CityTextBox" runat="server" MaxLength="50" CssClass="dnnFormRequired"></asp:TextBox>
                                </div>
                                <div class="dnnFormItem">
                                    <dnn1:LabelControl ID="SubdivisionLabelControl" runat="server" Text="State/Province:" />
                                    <asp:DropDownList ID="SubdivisionDropDownList" runat="server">
                                    </asp:DropDownList>
                                </div>
                                <div class="dnnFormItem">
                                    <dnn1:LabelControl ID="PostalCodeLabelControl" runat="server" Text="Postal code:" CssClass="dnnFormRequired" />
                                    <asp:RequiredFieldValidator ID="PostalCodeRequiredFieldValidator" runat="server" ControlToValidate="PostalCodeTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="UserPaymentDetailsViewControl">Postal code is required.</asp:RequiredFieldValidator>
                                    <asp:TextBox ID="PostalCodeTextBox" runat="server" MaxLength="10" CssClass="dnnFormRequired"></asp:TextBox>
                                </div>
                                <div class="dnnFormItem">
                                    <dnn1:LabelControl ID="PhoneLabelControl" runat="server" Text="Phone:" CssClass="dnnFormRequired" />
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="PhoneTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="UserPaymentDetailsViewControl">Phone is required.</asp:RequiredFieldValidator>
                                    <asp:TextBox ID="PhoneTextBox" runat="server" MaxLength="50" CssClass="dnnFormRequired"></asp:TextBox>
                                </div>
                                <div class="dnnFormItem">
                                    <dnn1:LabelControl ID="EmailLabelControl" runat="server" Text="Email:" />
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ControlToValidate="EmailTextBox" CssClass="dnnFormMessage dnnFormError" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ValidationGroup="UserPaymentDetailsViewControl">Email is required.</asp:RegularExpressionValidator>
                                    <asp:TextBox ID="EmailTextBox" runat="server" MaxLength="256"></asp:TextBox>
                                </div>
                                <div class="dnnFormItem">
                                    <dnn1:LabelControl ID="BusinessTaxNumberLabelControl" runat="server" Text="Business tax number:" />
                                    <asp:TextBox ID="BusinessTaxNumberTextBox" runat="server"></asp:TextBox>
                                </div>
                            </fieldset>
                        </asp:Panel>
                    </div>
                    <div class="dnnForm">
                        <ul class="dnnActions">
                            <li>
                                <asp:LinkButton ID="SaveLinkButton" runat="server" Text="Save" OnClick="SaveLinkButton_Click" ValidationGroup="UserPaymentDetailsViewControl" CssClass="dnnPrimaryAction rvdSaveAction" />
                            </li>
                            <li>
                                <asp:LinkButton ID="SaveAndBackLinkButton" runat="server" Text="Save & return" OnClick="SaveLinkButton_Click" CommandArgument="Back" CssClass="dnnPrimaryAction rvdSaveAction" ValidationGroup="UserPaymentDetailsViewControl" />
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
