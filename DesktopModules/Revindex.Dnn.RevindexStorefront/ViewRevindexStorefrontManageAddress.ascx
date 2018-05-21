<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ViewRevindexStorefrontManageAddress.ascx.cs" Inherits="Revindex.Dnn.RevindexStorefront.ViewRevindexStorefrontManageAddress" %>
<%@ Register Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI.WebControls" TagPrefix="asp" %>
<%@ Register Src="~/Controls/labelcontrol.ascx" TagName="LabelControl" TagPrefix="dnn1" %>
<%@ Register Assembly="DotNetNuke.Web.Deprecated" Namespace="DotNetNuke.Web.UI.WebControls" TagPrefix="dnn2" %>
<%@ Register Assembly="Revindex.Web.UI.WebControls" Namespace="Revindex.Web.UI.WebControls" TagPrefix="rvd1" %>
<%@ Register Src="WebUserControls/Common/Dnn/BackControl.ascx" TagName="BackControl" TagPrefix="uc1" %>
<asp:PlaceHolder runat="server">

	<script type="text/javascript">
		jQuery(function ($)
		{
			jQuery('#UserAddressDetailsViewTabPanel').dnnTabs();
		});
	</script>

</asp:PlaceHolder>
<div class="rvdsfManageAddressContainer">
	<asp:PlaceHolder ID="MessagePlaceHolder" runat="server" />
	<asp:MultiView ID="ContentMultiView" runat="server">
		<asp:View ID="ListView" runat="server">
			<div class="dnnForm rvdsfListContainer">
				<asp:GridView ID="UserAddressGridView" runat="server" AllowSorting="True" AutoGenerateColumns="False" CssClass="dnnGrid" GridLines="None" AllowPaging="True" OnRowDataBound="UserAddressGridView_RowDataBound" DataKeyNames="UserAddressID" OnRowDeleting="UserAddressGridView_RowDeleting">
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
						<asp:BoundField HeaderText="NameHeaderUserAddressGridView" />
						<asp:BoundField HeaderText="AddressHeaderUserAddressGridView" />
						<asp:BoundField DataField="Phone" HeaderText="PhoneHeaderUserAddressGridView" SortExpression="Phone" />
						<asp:CheckBoxField DataField="PrimaryBilling" HeaderText="PrimaryBillingHeaderUserAddressGridView" SortExpression="PrimaryBilling" />
						<asp:CheckBoxField DataField="PrimaryShipping" HeaderText="PrimaryShippingHeaderUserAddressGridView" SortExpression="PrimaryShipping" />
					</Columns>
				</asp:GridView>
				<asp:ObjectDataSource ID="UserAddressObjectDataSource" runat="server" EnablePaging="True" SelectCountMethod="GetCountByUser" SelectMethod="GetAllByUser" SortParameterName="sortExpression" TypeName="Revindex.Business.Revindex.Revindex.Storefront.UserAddressController">
					<SelectParameters>
						<asp:Parameter Name="sortExpression" Type="String" />
						<asp:Parameter Name="maximumRows" Type="Int32" />
						<asp:Parameter Name="startRowIndex" Type="Int32" />
						<rvd1:UserControlParameter Name="userID" PropertyName="UserId" Type="Int32" />
					</SelectParameters>
				</asp:ObjectDataSource>
				<ul class="dnnActions dnnClear">
					<li>
						<asp:HyperLink ID="AddHyperLink" runat="server" resourcekey="AddHyperLink" CssClass="dnnPrimaryAction rvdAddNewAction" />
					</li>
				</ul>
			</div>
		</asp:View>
		<asp:View ID="DetailsView" runat="server">
			<div id="UserAddressDetailsViewTabPanel" class="dnnForm">
				<ul class="dnnAdminTabNav dnnClear">
					<li><a href="#<%= GeneralDetailsViewPanel.ClientID %>">
						<asp:Label ID="GeneralDetailsViewTabLabel" runat="server" resourcekey="GeneralDetailsViewTabLabel" /></a></li>
				</ul>
				<asp:Panel ID="GeneralDetailsViewPanel" runat="server" CssClass="dnnClear">
					<fieldset>
						<div class="dnnFormItem">
							<dnn1:LabelControl ID="PrimaryLabelControl" runat="server" />
							<div class="rvdFormCheckBoxes">
								<asp:CheckBox ID="PrimaryBillingCheckBox" runat="server" resourcekey="PrimaryBillingCheckBox" />
								<asp:CheckBox ID="PrimaryShippingCheckBox" runat="server" resourcekey="PrimaryShippingCheckBox" />
							</div>
						</div>
						<div class="dnnFormItem">
							<dnn1:LabelControl ID="FirstNameLabelControl" runat="server" CssClass="dnnFormRequired" />
							<asp:RequiredFieldValidator ID="FirstNameRequiredFieldValidator" runat="server" ControlToValidate="FirstNameTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" resourcekey="FirstNameRequiredFieldValidator" ValidationGroup="UserAddressDetailsViewControl"></asp:RequiredFieldValidator>
							<asp:TextBox ID="FirstNameTextBox" runat="server" CssClass="dnnFormRequired" MaxLength="50"></asp:TextBox>
						</div>
						<div class="dnnFormItem">
							<dnn1:LabelControl ID="LastNameLabelControl" runat="server" CssClass="dnnFormRequired" />
							<asp:RequiredFieldValidator ID="LastNameRequiredFieldValidator" runat="server" resourcekey="LastNameRequiredFieldValidator" ControlToValidate="LastNameTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="UserAddressDetailsViewControl"></asp:RequiredFieldValidator>
							<asp:TextBox CssClass="dnnFormRequired" ID="LastNameTextBox" runat="server" MaxLength="50"></asp:TextBox>
						</div>
						<div class="dnnFormItem">
							<dnn1:LabelControl ID="CompanyLabelControl" runat="server" />
							<asp:TextBox ID="CompanyTextBox" runat="server" MaxLength="100"></asp:TextBox>
						</div>
						<div class="dnnFormItem">
							<dnn1:LabelControl ID="CountryLabelControl" runat="server" CssClass="dnnFormRequired"/>
							<asp:RequiredFieldValidator ID="CountryRequiredFieldValidator" resourcekey="CountryRequiredFieldValidator" runat="server" ControlToValidate="CountryDropDownList" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="UserAddressDetailsViewControl"></asp:RequiredFieldValidator>
							<asp:DropDownList ID="CountryDropDownList" runat="server" AutoPostBack="True" OnSelectedIndexChanged="CountryDropDownList_SelectedIndexChanged">
							</asp:DropDownList>
						</div>
						<div class="dnnFormItem">
							<dnn1:LabelControl ID="StreetLabelControl" runat="server" CssClass="dnnFormRequired" />
							<asp:RequiredFieldValidator ID="StreetRequiredFieldValidator" runat="server" resourcekey="StreetRequiredFieldValidator" ControlToValidate="StreetTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="UserAddressDetailsViewControl"></asp:RequiredFieldValidator>
							<asp:RegularExpressionValidator ID="StreetRegularExpressionValidator" resourcekey="StreetRegularExpressionValidator" runat="server" ControlToValidate="StreetTextBox" ValidationExpression="^[\s\S]{0,200}$" ValidationGroup="UserAddressDetailsViewControl" CssClass="dnnFormMessage dnnFormError" Display="Dynamic"></asp:RegularExpressionValidator>
							<asp:TextBox ID="StreetTextBox" runat="server" Rows="2" TextMode="MultiLine" MaxLength="200" CssClass="dnnFormRequired"></asp:TextBox>
						</div>
						<div class="dnnFormItem">
							<dnn1:LabelControl ID="CityLabelControl" runat="server" CssClass="dnnFormRequired" />
							<asp:RequiredFieldValidator ID="CityRequiredFieldValidator" runat="server" ControlToValidate="CityTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" resourcekey="CityRequiredFieldValidator" ValidationGroup="UserAddressDetailsViewControl"></asp:RequiredFieldValidator>
							<asp:TextBox ID="CityTextBox" runat="server" MaxLength="50" CssClass="dnnFormRequired"></asp:TextBox>
						</div>
						<div class="dnnFormItem">
							<dnn1:LabelControl ID="SubdivisionLabelControl" runat="server" />
							<asp:DropDownList ID="SubdivisionDropDownList" runat="server">
							</asp:DropDownList>
						</div>
						<div class="dnnFormItem">
							<dnn1:LabelControl ID="PostalCodeLabelControl" runat="server" CssClass="dnnFormRequired" />
							<asp:RequiredFieldValidator ID="PostalCodeRequiredFieldValidator" resourcekey="PostalCodeRequiredFieldValidator" runat="server" ControlToValidate="PostalCodeTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="UserAddressDetailsViewControl"></asp:RequiredFieldValidator>
							<asp:TextBox ID="PostalCodeTextBox" runat="server" MaxLength="10" CssClass="dnnFormRequired"></asp:TextBox>
						</div>
						<div class="dnnFormItem">
							<dnn1:LabelControl ID="PhoneLabelControl" runat="server" CssClass="dnnFormRequired" />
							<asp:RequiredFieldValidator ID="PhoneRequiredFieldValidator" runat="server" resourcekey="PhoneRequiredFieldValidator" ControlToValidate="PhoneTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="UserAddressDetailsViewControl"></asp:RequiredFieldValidator>
							<asp:TextBox ID="PhoneTextBox" runat="server" MaxLength="50" CssClass="dnnFormRequired"></asp:TextBox>
						</div>
						<div class="dnnFormItem">
							<dnn1:LabelControl ID="EmailLabelControl" runat="server" />
							<asp:RegularExpressionValidator ID="EmailRegularExpressionValidator" resourcekey="EmailRegularExpressionValidator" runat="server" ControlToValidate="EmailTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ValidationGroup="UserAddressDetailsViewControl"></asp:RegularExpressionValidator>
							<asp:TextBox ID="EmailTextBox" runat="server" MaxLength="256"></asp:TextBox>
						</div>
					</fieldset>
				</asp:Panel>
			</div>
			<div class="dnnForm">
				<ul class="dnnActions">
					<li>
						<asp:LinkButton ID="SaveLinkButton" runat="server" Text="Save" OnClick="SaveLinkButton_Click" CssClass="dnnPrimaryAction rvdSaveAction" ValidationGroup="UserAddressDetailsViewControl" resourcekey="SaveLinkButton" CommandArgument="Back"/>
					</li>
					<li>
                        <uc1:BackControl ID="BackControl" runat="server" Text="Cancel" ResourceKey="BackControl"/>
                    </li>
				</ul>
			</div>
		</asp:View>
	</asp:MultiView>
</div>
