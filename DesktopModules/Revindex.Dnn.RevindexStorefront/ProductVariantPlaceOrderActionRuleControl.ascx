<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ProductVariantPlaceOrderActionRuleControl.ascx.cs" Inherits="Revindex.Dnn.RevindexStorefront.ProductVariantPlaceOrderActionRuleControl" %>
<%@ Register Src="~/Controls/labelcontrol.ascx" TagName="LabelControl" TagPrefix="dnn1" %>
<%@ Register Assembly="DotNetNuke.Web.Deprecated" Namespace="DotNetNuke.Web.UI.WebControls" TagPrefix="dnn2" %>
<%@ Register Src="WebUserControls/FormulaEditorControl.ascx" TagName="FormulaEditorControl" TagPrefix="uc1" %>
<asp:Panel ID="MainPanel" runat="server">
	<div class="dnnFormItem">
		<dnn1:LabelControl ID="RuleTypeLabelControl" runat="server" Text="Place order action rule:" />
		<asp:DropDownList ID="RuleTypeDropDownList" runat="server" OnSelectedIndexChanged="RuleTypeDropDownList_SelectedIndexChanged" AutoPostBack="True">
			<asp:ListItem Text="None" Value=""></asp:ListItem>
			<asp:ListItem Text="Basic" Value="BasicActionView"></asp:ListItem>
			<asp:ListItem Text="Custom rule" Value="CustomRuleView"></asp:ListItem>
		</asp:DropDownList>
	</div>
	<asp:MultiView ID="FormulaMultiView" runat="server" ActiveViewIndex="0">
		<asp:View ID="BasicActionView" runat="server">
			<div class="dnnFormItem">
				<dnn1:LabelControl ID="ActionBasicActionLabelControl" runat="server" Text="Actions:" HelpText="Actions to perform during checkout." />
				<div class="rvdFormSubContainer">
					<asp:PlaceHolder ID="ActionBasicActionMessagePlaceHolder" runat="server" />
					<asp:GridView ID="ActionBasicActionGridView" runat="server" CssClass="dnnGrid" GridLines="None" AutoGenerateColumns="False" DataKeyNames="ID" OnRowDeleting="ActionBasicActionGridView_RowDeleting" OnSelectedIndexChanged="ActionBasicActionGridView_SelectedIndexChanged" OnRowCommand="ActionBasicActionGridView_RowCommand" OnRowCreated="ActionBasicActionGridView_RowCreated">
						<AlternatingRowStyle CssClass="dnnGridAltItem" />
						<HeaderStyle CssClass="dnnGridHeader" />
						<RowStyle CssClass="dnnGridItem" />
						<SelectedRowStyle CssClass="dnnGridSelectedItem" />
						<FooterStyle CssClass="dnnGridFooter" />
						<PagerStyle CssClass="dnnGridPager" />
						<Columns>
							<asp:CommandField ShowSelectButton="True" SelectText="" ControlStyle-CssClass="rvdEditGridAction" />
							<asp:TemplateField>
								<ItemTemplate>
									<asp:LinkButton ID="DeleteLinkButton" runat="server" CausesValidation="false" CommandName="Delete" OnClientClick="return confirm('Are you sure you want to delete this item?')" CssClass="rvdDeleteGridAction"></asp:LinkButton>
								</ItemTemplate>
							</asp:TemplateField>
							<asp:TemplateField>
								<ItemTemplate>
									<asp:LinkButton ID="MoveUpLinkButton" runat="server" CausesValidation="false" CommandName="MoveUp" CssClass="rvdUpGridAction" />
									<asp:LinkButton ID="MoveDownLinkButton" runat="server" CausesValidation="false" CommandName="MoveDown" CssClass="rvdDownGridAction" />
								</ItemTemplate>
							</asp:TemplateField>
							<asp:BoundField DataField="Type" HeaderText="Type" />
							<asp:BoundField DataField="Description" HeaderText="Description" />
						</Columns>
					</asp:GridView>
					<div class="rvdActions">
						<asp:LinkButton ID="AddActionBasicActionLinkButton" runat="server" Text="Add new" OnClick="AddActionBasicActionLinkButton_Click" CausesValidation="false" CssClass="dnnPrimaryAction rvdAddNewAction" />
					</div>
					<asp:Panel ID="ActionBasicActionDetailsViewPanel" runat="server">
						<fieldset>
							<div class="dnnFormItem">
								<dnn1:LabelControl ID="ActionTypeLabelControl" runat="server" Text="Action type:" />
								<asp:RadioButtonList ID="ActionTypeRadioButtonList" runat="server" OnSelectedIndexChanged="ActionTypeRadioButtonList_SelectedIndexChanged" AutoPostBack="True" RepeatLayout="Flow" CssClass="dnnFormRadioButtons">
									<asp:ListItem Text="Grant role" Value="GrantRoleActionTypeView" Selected="True" />
									<asp:ListItem Text="Revoke role" Value="RevokeRoleActionTypeView" />
									<asp:ListItem Text="Set data" Value="SetDataActionTypeView" />
									<asp:ListItem Text="Web request" Value="WebRequestActionTypeView" />
								</asp:RadioButtonList>
							</div>
							<asp:MultiView ID="ActionTypeDetailsViewMultiView" runat="server" ActiveViewIndex="0">
								<asp:View ID="GrantRoleActionTypeView" runat="server">
									<div class="dnnFormItem">
										<dnn1:LabelControl ID="RoleIDGrantRoleActionTypeLabelControl" runat="server" Text="Role:" HelpText="For security reasons, only roles that have a Role Group listed under your configuration's security setting can be granted." />
										<asp:RequiredFieldValidator ID="RoleIDGrantRoleActionTypeRequiredFieldValidator" runat="server" ValidationGroup="ActionBasicActionDetailsViewControl" Display="Dynamic" CssClass="dnnFormMessage dnnFormError" ControlToValidate="RoleIDGrantRoleActionTypeDropDownList" Text="Role is required."></asp:RequiredFieldValidator>
										<asp:DropDownList ID="RoleIDGrantRoleActionTypeDropDownList" runat="server">
										</asp:DropDownList>
									</div>
									<div class="dnnFormItem">
										<dnn1:LabelControl ID="RoleExpireIntervalGrantRoleActionTypeLabelControl" runat="server" Text="Expire:" HelpText="Set the amount of time before expiring the role or leave blank to permanently grant role." />
										<dnn2:DnnNumericTextBox ID="RoleExpireIntervalGrantRoleActionTypeDnnNumericTextBox" runat="server" Skin="" NumberFormat-DecimalDigits="0" NumberFormat-GroupSizes="9" MinValue="0" EnableSingleInputRendering="False" CssClass="rvdQuantityInput">
										</dnn2:DnnNumericTextBox>
										<asp:DropDownList ID="RoleExpireIntervalTypeGrantRoleActionTypeDropDownList" runat="server" CssClass="rvdUnitInput">
											<asp:ListItem Text="Day" Value="1" />
											<asp:ListItem Text="Week" Value="2" />
											<asp:ListItem Text="Month" Value="3" />
											<asp:ListItem Text="Year" Value="4" />
										</asp:DropDownList>
									</div>
								</asp:View>
								<asp:View ID="RevokeRoleActionTypeView" runat="server">
									<div class="dnnFormItem">
										<dnn1:LabelControl ID="RoleIDRevokeRoleActionTypeLabelControl" runat="server" Text="Role:" HelpText="For security reasons, only roles that have a Role Group listed under your configuration's security setting can be revoked." />
										<asp:RequiredFieldValidator ID="RoleIDRevokeRoleActionTypeRequiredFieldValidator" runat="server" ValidationGroup="ActionBasicActionDetailsViewControl" Display="Dynamic" CssClass="dnnFormMessage dnnFormError" ControlToValidate="RoleIDRevokeRoleActionTypeDropDownList" Text="Role is required."></asp:RequiredFieldValidator>
										<asp:DropDownList ID="RoleIDRevokeRoleActionTypeDropDownList" runat="server">
										</asp:DropDownList>
									</div>
								</asp:View>
								<asp:View ID="SetDataActionTypeView" runat="server">
									<div class="dnnFormItem">
										<dnn1:LabelControl ID="OrderStatusSetDataActionTypeLabelControl" runat="server" Text="Order status:" />
										<asp:DropDownList ID="OrderStatusSetDataActionTypeDropDownList" runat="server">
											<asp:ListItem Value="">No change</asp:ListItem>
											<asp:ListItem Value="7" style="background-color: Silver">Incomplete</asp:ListItem>
											<asp:ListItem Value="1" style="background-color: HotPink">Pending</asp:ListItem>
											<asp:ListItem Value="2" style="background-color: Gold">Ordered</asp:ListItem>
											<asp:ListItem Value="3" style="background-color: SkyBlue">Processing</asp:ListItem>
											<asp:ListItem Value="4" style="background-color: YellowGreen">Completed</asp:ListItem>
											<asp:ListItem Value="5" style="background-color: Khaki">Cancelled</asp:ListItem>
											<asp:ListItem Value="6" style="background-color: Red">Declined</asp:ListItem>
										</asp:DropDownList>
									</div>
									<div class="dnnFormItem">
										<dnn1:LabelControl ID="OrderPaymentStatusSetDataActionTypeLabelControl" runat="server" Text="Order payment status:" />
										<asp:DropDownList ID="OrderPaymentStatusSetDataActionTypeDropDownList" runat="server">
											<asp:ListItem Value="">No change</asp:ListItem>
											<asp:ListItem Value="1" style="background-color: HotPink">Pending</asp:ListItem>
											<asp:ListItem Value="2" style="background-color: YellowGreen">Paid</asp:ListItem>
											<asp:ListItem Value="3" style="background-color: Khaki">Cancelled</asp:ListItem>
											<asp:ListItem Value="4" style="background-color: DarkKhaki">Refunded</asp:ListItem>
											<asp:ListItem Value="5" style="background-color: Red">Declined</asp:ListItem>
										</asp:DropDownList>
									</div>
									<div class="dnnFormItem">
										<dnn1:LabelControl ID="OrderShippingStatusSetDataActionTypeLabelControl" runat="server" Text="Order shipping status:" />
										<asp:DropDownList ID="OrderShippingStatusSetDataActionTypeDropDownList" runat="server">
											<asp:ListItem Value="">No change</asp:ListItem>
											<asp:ListItem Value="1" style="background-color: LightGreen">Not Required</asp:ListItem>
											<asp:ListItem Value="2" style="background-color: Gold">Not Shipped</asp:ListItem>
											<asp:ListItem Value="3" style="background-color: YellowGreen">Shipped</asp:ListItem>
											<asp:ListItem Value="4" style="background-color: Red">Undeliverable</asp:ListItem>
										</asp:DropDownList>
									</div>
									<div class="dnnFormItem">
										<dnn1:LabelControl ID="OrderDetailStatusSetDataActionTypeLabelControl" runat="server" Text="Order detail status:" />
										<asp:DropDownList ID="OrderDetailStatusSetDataActionTypeDropDownList" runat="server">
											<asp:ListItem Value="">No change</asp:ListItem>
											<asp:ListItem Value="7" style="background-color: Silver">Incomplete</asp:ListItem>
											<asp:ListItem Value="1" style="background-color: HotPink">Pending</asp:ListItem>
											<asp:ListItem Value="2" style="background-color: Gold">Ordered</asp:ListItem>
											<asp:ListItem Value="3" style="background-color: SkyBlue">Processing</asp:ListItem>
											<asp:ListItem Value="4" style="background-color: YellowGreen">Completed</asp:ListItem>
										</asp:DropDownList>
									</div>
									<div class="dnnFormItem">
										<dnn1:LabelControl ID="OrderDetailShippingStatusSetDataActionTypeLabelControl" runat="server" Text="Order detail shipping status:" />
										<asp:DropDownList ID="OrderDetailShippingStatusSetDataActionTypeDropDownList" runat="server">
											<asp:ListItem Value="">No change</asp:ListItem>
											<asp:ListItem Value="1" style="background-color: LightGreen">Not Required</asp:ListItem>
											<asp:ListItem Value="2" style="background-color: Gold">Not Shipped</asp:ListItem>
											<asp:ListItem Value="3" style="background-color: YellowGreen">Shipped</asp:ListItem>
											<asp:ListItem Value="4" style="background-color: Red">Undeliverable</asp:ListItem>
										</asp:DropDownList>
									</div>
								</asp:View>
								<asp:View ID="WebRequestActionTypeView" runat="server">
									<div class="dnnFormItem">
										<dnn1:LabelControl ID="UrlWebRequestActionTypeLabelControl" runat="server" Text="URL:" CssClass="dnnFormRequired" />
										<asp:RequiredFieldValidator ID="UrlWebRequestActionTypeRequiredFieldValidator" runat="server" ValidationGroup="ActionBasicActionDetailsViewControl" Display="Dynamic" CssClass="dnnFormMessage dnnFormError" ControlToValidate="UrlWebRequestActionTypeTextBox" Text="URL is required."></asp:RequiredFieldValidator>
										<asp:RegularExpressionValidator ID="UrlWebRequestActionTypeRegularExpressionValidator" runat="server" ValidationGroup="ActionBasicActionDetailsViewControl" Display="Dynamic" CssClass="dnnFormMessage dnnFormError" ControlToValidate="UrlWebRequestActionTypeTextBox" Text="URL is invalid." ValidationExpression="http(s)?://([\w-]+\.)+[\w-]+(/[\w- ./?%&amp;=]*)?"></asp:RegularExpressionValidator>
										<asp:TextBox ID="UrlWebRequestActionTypeTextBox" runat="server" CssClass="dnnFormRequired"></asp:TextBox>
									</div>
									<div class="dnnFormItem">
										<dnn1:LabelControl ID="MethodWebRequestActionTypeLabelControl" runat="server" Text="Method:" />
										<asp:RadioButtonList ID="MethodWebRequestActionTypeRadioButtonList" runat="server" RepeatDirection="Horizontal" RepeatLayout="Flow" CssClass="dnnFormRadioButtons">
											<asp:ListItem Text="POST" Value="POST" />
											<asp:ListItem Text="GET" Value="GET" />
										</asp:RadioButtonList>
									</div>
									<div class="dnnFormItem">
										<dnn1:LabelControl ID="TimeoutWebRequestActionTypeLabelControl" runat="server" Text="Timeout (ms):" CssClass="dnnFormRequired" />
										<asp:RequiredFieldValidator ID="TimeoutWebRequestActionTypeRequiredFieldValidator1" runat="server" ValidationGroup="ActionBasicActionDetailsViewControl" Display="Dynamic" CssClass="dnnFormMessage dnnFormError" ControlToValidate="TimeoutWebRequestActionTypeDnnNumericTextBox" Text="Timeout is required."></asp:RequiredFieldValidator>
										<dnn2:DnnNumericTextBox ID="TimeoutWebRequestActionTypeDnnNumericTextBox" runat="server" Skin="" NumberFormat-DecimalDigits="0" NumberFormat-GroupSizes="9" MinValue="0" Value="30000" EnableSingleInputRendering="False" CssClass="dnnFormRequired" />
									</div>
								</asp:View>
							</asp:MultiView>
						</fieldset>
						<div class="rvdActions">
							<asp:LinkButton ID="SaveActionBasicActionLinkButton" runat="server" Text="OK" OnClick="SaveActionBasicActionLinkButton_Click" ValidationGroup="ActionBasicActionDetailsViewControl" CssClass="dnnPrimaryAction rvdOKAction" />
						</div>
					</asp:Panel>
				</div>
			</div>
		</asp:View>
		<asp:View ID="CustomRuleView" runat="server">
			<div class="dnnFormItem">
				<dnn1:LabelControl ID="ActionRuleLabelControl" runat="server" Text="XSLT rule:" />
				<uc1:FormulaEditorControl ID="ActionRuleFormulaEditor" runat="server" Width="100%" ModuleControl="ProductVariantPlaceOrderAction" />
			</div>
		</asp:View>
	</asp:MultiView>
</asp:Panel>
