<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ViewRevindexStorefrontManageRecurringOrder.ascx.cs" Inherits="Revindex.Dnn.RevindexStorefront.ViewRevindexStorefrontManageRecurringOrder" %>
<%@ Register Src="~/Controls/labelcontrol.ascx" TagName="LabelControl" TagPrefix="dnn1" %>
<%@ Register Assembly="DotNetNuke.Web.Deprecated" Namespace="DotNetNuke.Web.UI.WebControls" TagPrefix="dnn2" %>
<%@ Register Assembly="Revindex.Web.UI.WebControls" Namespace="Revindex.Web.UI.WebControls" TagPrefix="rvd1" %>
<%@ Register Src="UserAddressDropDownListControl.ascx" TagName="UserAddressDropDownListControl" TagPrefix="uc1" %>
<%@ Register Src="UserPaymentDropDownListControl.ascx" TagName="UserPaymentDropDownListControl" TagPrefix="uc1" %>
<%@ Register Src="WebUserControls/Common/Dnn/BackControl.ascx" TagName="BackControl" TagPrefix="uc1" %>
<asp:PlaceHolder runat="server">

	<script type="text/javascript">
		jQuery(function ($)
		{
			jQuery('#RecurringSalesOrderDetailsViewTabPanel').dnnTabs();
		});
	</script>

</asp:PlaceHolder>
<div class="rvdsfManageRecurringOrderContainer">
	<asp:PlaceHolder ID="MessagePlaceHolder" runat="server" />
	<asp:MultiView ID="ContentMultiView" runat="server">
		<asp:View ID="ListView" runat="server">
			<div class="dnnForm rvdsfListContainer">
				<asp:GridView ID="RecurringSalesOrderGridView" runat="server" AllowSorting="True" AutoGenerateColumns="False" CssClass="dnnGrid" GridLines="None" AllowPaging="True" DataKeyNames="RecurringSalesOrderID" OnRowDataBound="RecurringSalesOrderGridView_RowDataBound">
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
						<asp:BoundField DataField="NextRecurringDate" HeaderText="NextRecurringDateHeaderRecurringSalesOrderGridView" SortExpression="NextRecurringDate" DataFormatString="{0:yyyy-MM-dd}" />
						<asp:BoundField DataField="Status" HeaderText="StatusHeaderRecurringSalesOrderGridView" SortExpression="Status" />
						<asp:HyperLinkField HeaderText="ProductHeaderRecurringSalesOrderGridView" Target="_blank" />
						<asp:BoundField HeaderText="PaymentHeaderRecurringSalesOrderGridView" />
					</Columns>
				</asp:GridView>
				<asp:ObjectDataSource ID="RecurringSalesOrderObjectDataSource" runat="server" EnablePaging="True" SelectCountMethod="GetCountByUser" SelectMethod="GetAllByUser" SortParameterName="sortExpression" TypeName="Revindex.Business.Revindex.Revindex.Storefront.RecurringSalesOrderController">
					<SelectParameters>
						<asp:Parameter Name="sortExpression" Type="String" />
						<asp:Parameter Name="maximumRows" Type="Int32" />
						<asp:Parameter Name="startRowIndex" Type="Int32" />
						<rvd1:UserControlParameter Name="userID" PropertyName="UserId" Type="Int32" />
					</SelectParameters>
				</asp:ObjectDataSource>
			</div>
		</asp:View>
		<asp:View ID="DetailsView" runat="server">
			<div id="RecurringSalesOrderDetailsViewTabPanel" class="dnnForm">
				<ul class="dnnAdminTabNav dnnClear">
					<li><a href="#<%= GeneralDetailsViewPanel.ClientID %>">
						<asp:Label ID="GeneralDetailsViewTabLabel" runat="server" resourcekey="GeneralDetailsViewTabLabel" /></a></li>
					<li><a href="#<%= ShippingDetailsViewPanel.ClientID %>">
						<asp:Label ID="ShippingDetailsViewTabLabel" runat="server" resourcekey="ShippingDetailsViewTabLabel" /></a></li>
					<li><a href="#<%= PaymentDetailsViewPanel.ClientID %>">
						<asp:Label ID="PaymentDetailsViewTabLabel" runat="server" resourcekey="PaymentDetailsViewTabLabel" /></a></li>
				</ul>
				<asp:Panel ID="GeneralDetailsViewPanel" runat="server" CssClass="dnnClear">
					<fieldset>
						<div class="dnnFormItem">
							<dnn1:LabelControl ID="StatusLabelControl" runat="server" />
							<asp:DropDownList ID="StatusDropDownList" runat="server">
								<asp:ListItem Value="1" style="background-color: SkyBlue">Active</asp:ListItem>
								<asp:ListItem Value="2" style="background-color: HotPink">Hold</asp:ListItem>
								<asp:ListItem Value="3" style="background-color: Red">Invalid</asp:ListItem>
								<asp:ListItem Value="4" style="background-color: Khaki">Cancelled</asp:ListItem>
							</asp:DropDownList>
						</div>
						<div class="dnnFormItem">
							<dnn1:LabelControl ID="NextRecurringDateLabelControl" runat="server" />
							<asp:Label ID="NextRecurringDateLabel" runat="server"></asp:Label>
						</div>
						<div class="dnnFormItem">
							<dnn1:LabelControl ID="CreateDateLabelControl" runat="server" />
							<asp:Label ID="CreateDateLabel" runat="server"></asp:Label>
						</div>
						<div class="dnnFormItem">
							<dnn1:LabelControl ID="OriginalSalesOrderNumberLabelControl" runat="server" />
							<asp:Label ID="OriginalSalesOrderNumberLabel" runat="server"></asp:Label>
						</div>
						<div class="dnnFormItem">
							<dnn1:LabelControl ID="ProductVariantIDLabelControl" runat="server" />
							<asp:HyperLink ID="ProductVariantIDHyperLink" runat="server" Target="_blank"></asp:HyperLink>
						</div>
						<div class="dnnFormItem">
							<dnn1:LabelControl ID="QuantityLabelControl" runat="server" />
							<asp:Label ID="QuantityLabel" runat="server"></asp:Label>
						</div>
					</fieldset>
				</asp:Panel>
				<asp:Panel ID="ShippingDetailsViewPanel" runat="server" CssClass="dnnClear">
					<fieldset>
						<div class="dnnFormItem">
							<dnn1:LabelControl ID="ShippingMethodIDLabelControl" runat="server" />
							<asp:Label ID="ShippingMethodIDLabel" runat="server"></asp:Label>
						</div>
						<div class="dnnFormItem">
							<dnn1:LabelControl ID="UserAddressLabelControl" runat="server" />
							<uc1:UserAddressDropDownListControl ID="UserAddressDropDownListControl" runat="server" AutoPostBack="True" />
						</div>
						<div class="dnnFormItem">
							<dnn1:LabelControl ID="ShippingFirstNameLabelControl" runat="server" CssClass="dnnFormRequired" />
							<asp:RequiredFieldValidator ID="ShippingFirstNameRequiredFieldValidator" resourcekey="ShippingFirstNameRequiredFieldValidator" runat="server" ControlToValidate="ShippingFirstNameTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="ManageRecurringOrderDetailsViewControl"></asp:RequiredFieldValidator>
							<asp:TextBox ID="ShippingFirstNameTextBox" runat="server" MaxLength="50" CssClass="dnnFormRequired"></asp:TextBox>
						</div>
						<div class="dnnFormItem">
							<dnn1:LabelControl ID="ShippingLastNameLabelControl" runat="server" CssClass="dnnFormRequired" />
							<asp:RequiredFieldValidator ID="ShippingLastNameRequiredFieldValidator" runat="server" ControlToValidate="ShippingLastNameTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" resourcekey="ShippingLastNameRequiredFieldValidator" ValidationGroup="ManageRecurringOrderDetailsViewControl"></asp:RequiredFieldValidator>
							<asp:TextBox ID="ShippingLastNameTextBox" runat="server" MaxLength="50" CssClass="dnnFormRequired"></asp:TextBox>
						</div>
						<div class="dnnFormItem">
							<dnn1:LabelControl ID="ShippingCompanyLabelControl" runat="server" />
							<asp:TextBox ID="ShippingCompanyTextBox" runat="server" MaxLength="100"></asp:TextBox>
						</div>
						<div class="dnnFormItem">
							<dnn1:LabelControl ID="ShippingCountryLabelControl" runat="server" />
							<asp:DropDownList ID="ShippingCountryDropDownList" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ShippingCountryDropDownList_SelectedIndexChanged">
							</asp:DropDownList>
						</div>
						<div class="dnnFormItem">
							<dnn1:LabelControl ID="ShippingStreetLabelControl" runat="server" CssClass="dnnFormRequired" />
							<asp:RequiredFieldValidator ID="ShippingStreetRequiredFieldValidator" runat="server" ControlToValidate="ShippingStreetTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" resourcekey="ShippingStreetRequiredFieldValidator" ValidationGroup="ManageRecurringOrderDetailsViewControl"></asp:RequiredFieldValidator>
							<asp:RegularExpressionValidator ID="ShippingStreetRegularExpressionValidator" runat="server" ControlToValidate="ShippingStreetTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" resourcekey="ShippingStreetRegularExpressionValidator" ValidationExpression="^[\s\S]{0,200}$" ValidationGroup="ManageRecurringOrderDetailsViewControl"></asp:RegularExpressionValidator>
							<asp:TextBox ID="ShippingStreetTextBox" runat="server" Rows="2" TextMode="MultiLine" MaxLength="200" CssClass="dnnFormRequired"></asp:TextBox>
						</div>
						<div class="dnnFormItem">
							<dnn1:LabelControl ID="ShippingCityLabelControl" runat="server" CssClass="dnnFormRequired" />
							<asp:RequiredFieldValidator ID="ShippingCityRequiredFieldValidator" runat="server" ControlToValidate="ShippingCityTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" resourcekey="ShippingCityRequiredFieldValidator" ValidationGroup="ManageRecurringOrderDetailsViewControl"></asp:RequiredFieldValidator>
							<asp:TextBox ID="ShippingCityTextBox" runat="server" MaxLength="50" CssClass="dnnFormRequired"></asp:TextBox>
						</div>
						<div class="dnnFormItem">
							<dnn1:LabelControl ID="ShippingSubdivisionLabelControl" runat="server" />
							<asp:DropDownList ID="ShippingSubdivisionDropDownList" runat="server">
							</asp:DropDownList>
						</div>
						<div class="dnnFormItem">
							<dnn1:LabelControl ID="ShippingPostalCodeLabelControl" runat="server" CssClass="dnnFormRequired" />
							<asp:RequiredFieldValidator ID="ShippingPostalCodeRequiredFieldValidator" resourcekey="ShippingPostalCodeRequiredFieldValidator" runat="server" ControlToValidate="ShippingPostalCodeTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="ManageRecurringOrderDetailsViewControl"></asp:RequiredFieldValidator>
							<asp:TextBox ID="ShippingPostalCodeTextBox" runat="server" MaxLength="10" CssClass="dnnFormRequired"></asp:TextBox>
						</div>
						<div class="dnnFormItem">
							<dnn1:LabelControl ID="ShippingPhoneLabelControl" runat="server" CssClass="dnnFormRequired" />
							<asp:RequiredFieldValidator ID="ShippingPhoneRequiredFieldValidator" runat="server" ControlToValidate="ShippingPhoneTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" resourcekey="ShippingPhoneRequiredFieldValidator" ValidationGroup="ManageRecurringOrderDetailsViewControl"></asp:RequiredFieldValidator>
							<asp:TextBox ID="ShippingPhoneTextBox" runat="server" MaxLength="50" CssClass="dnnFormRequired"></asp:TextBox>
						</div>
						<div class="dnnFormItem">
							<dnn1:LabelControl ID="ShippingEmailLabelControl" runat="server" />
							<asp:RegularExpressionValidator ID="ShippingEmailRegularExpressionValidator" resourcekey="ShippingEmailRegularExpressionValidator" runat="server" ControlToValidate="ShippingEmailTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ValidationGroup="ManageRecurringOrderDetailsViewControl"></asp:RegularExpressionValidator>
							<asp:TextBox ID="ShippingEmailTextBox" runat="server" MaxLength="256"></asp:TextBox>
						</div>
					</fieldset>
				</asp:Panel>
				<asp:Panel ID="PaymentDetailsViewPanel" runat="server" CssClass="dnnClear">
					<fieldset>
						<div class="dnnFormItem">
							<dnn1:LabelControl ID="UserPaymentLabelControl" runat="server" />
							<uc1:UserPaymentDropDownListControl ID="UserPaymentDropDownListControl" runat="server" AutoPostBack="False" />
						</div>
					</fieldset>
				</asp:Panel>
			</div>
			<div class="dnnForm">
				<ul class="dnnActions">
					<li>
						<asp:LinkButton ID="SaveLinkButton" runat="server" resourcekey="SaveLinkButton" OnClick="SaveLinkButton_Click" CssClass="dnnPrimaryAction rvdSaveAction" ValidationGroup="ManageRecurringOrderDetailsViewControl" CommandArgument="Back" />
					</li>
					<li>
						<uc1:BackControl ID="BackControl" runat="server" Text="Cancel" ResourceKey="BackControl"/>
					</li>
				</ul>
			</div>
		</asp:View>
	</asp:MultiView>
</div>
