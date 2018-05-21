<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ShippingMethodSurchargeRuleControl.ascx.cs" Inherits="Revindex.Dnn.RevindexStorefront.ShippingMethodSurchargeRuleControl" %>
<%@ Register Src="~/Controls/labelcontrol.ascx" TagName="LabelControl" TagPrefix="dnn1" %>
<%@ Register Assembly="DotNetNuke.Web.Deprecated" Namespace="DotNetNuke.Web.UI.WebControls" TagPrefix="dnn2" %>
<%@ Register Src="WebUserControls/FormulaEditorControl.ascx" TagName="FormulaEditorControl" TagPrefix="uc1" %>
<div class="dnnFormItem">
	<dnn1:LabelControl ID="RuleTypeLabelControl" runat="server" Text="Surcharge rule:" />
	<asp:DropDownList ID="RuleTypeDropDownList" runat="server" OnSelectedIndexChanged="RuleTypeDropDownList_SelectedIndexChanged" AutoPostBack="True">
		<asp:ListItem Text="None - zero amount" Value=""></asp:ListItem>
		<asp:ListItem Text="Flat amount - same amount for every order" Value="FlatAmountView"></asp:ListItem>
		<asp:ListItem Text="Flat rate - based on weight, amount, quantity..." Value="FlatRateView"></asp:ListItem>
		<asp:ListItem Text="Tier rate - vary by range" Value="TierRateView"></asp:ListItem>
		<asp:ListItem Text="Custom rule" Value="CustomRuleView"></asp:ListItem>
	</asp:DropDownList>
</div>
<asp:MultiView ID="FormulaMultiView" runat="server" ActiveViewIndex="0">
	<asp:View ID="FlatAmountView" runat="server">
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="ShippingSurchargeAmountFlatAmountLabelControl" runat="server" Text="Surcharge amount:" HelpText="The fixed shipping amount to surcharge." CssClass="dnnFormRequired"/>
			<asp:RequiredFieldValidator ID="ShippingSurchargeAmountFlatAmountRequiredFieldValidator" runat="server" ControlToValidate="ShippingSurchargeAmountFlatAmountDnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="ShippingMethodDetailsViewControl">Shipping surcharge amount is required.</asp:RequiredFieldValidator>
			<dnn2:DnnNumericTextBox ID="ShippingSurchargeAmountFlatAmountDnnNumericTextBox" runat="server" EnableSingleInputRendering="False" CssClass="dnnFormRequired" Skin="" NumberFormat-DecimalDigits="4" NumberFormat-GroupSizes="9" MinValue="0">
			</dnn2:DnnNumericTextBox>
		</div>
	</asp:View>
	<asp:View ID="FlatRateView" runat="server">
		<div class="dnnFormMessage dnnFormInfo">
		<p>This rule calculates the surcharge amount according to the following formula where Measure is either a weight, amount or quantity. The final surcharge amount is either the calculated amount or the Minimum amount, whichever is higher:</p>
		<p><strong>Calculated amount = Base + (Rate x Measure)</strong></p>
		<p>For example, if your Base is $5.00, your chosen Measure is Weight for a package weighing 1000 grams and your rate is 1%, the calculated amount is 5 + 0.01 x 1000 = $15.00</p>
		</div>
        <div class="dnnFormItem">
			<dnn1:LabelControl ID="MinShippingSurchargeAmountFlatRateLabelControl" runat="server" Text="Minimum surcharge amount:" CssClass="dnnFormRequired" HelpText="The shipping amount that will be charged if the calculated surcharge amount is less than this minimum amount." />
			<asp:RequiredFieldValidator ID="MinShippingSurchargeAmountFlatRateRequiredFieldValidator" runat="server" ControlToValidate="MinShippingSurchargeAmountFlatRateDnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="ShippingMethodDetailsViewControl">Min shipping surcharge amount is required.</asp:RequiredFieldValidator>
			<dnn2:DnnNumericTextBox ID="MinShippingSurchargeAmountFlatRateDnnNumericTextBox" runat="server" Skin="" EnableSingleInputRendering="False" CssClass="dnnFormRequired" NumberFormat-DecimalDigits="4" NumberFormat-GroupSizes="9" MinValue="0">
			</dnn2:DnnNumericTextBox>
		</div>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="BaseShippingSurchargeAmountFlatRateLabelControl" runat="server" Text="Base surcharge amount:" CssClass="dnnFormRequired" HelpText="The base amount to add to the total calculated shipping surcharge amount." />
			<asp:RequiredFieldValidator ID="BaseShippingSurchargeAmountFlatRateRequiredFieldValidator" runat="server" ControlToValidate="BaseShippingSurchargeAmountFlatRateDnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="ShippingMethodDetailsViewControl">Base amount is required.</asp:RequiredFieldValidator>
			<dnn2:DnnNumericTextBox ID="BaseShippingSurchargeAmountFlatRateDnnNumericTextBox" runat="server" Skin="" EnableSingleInputRendering="False" CssClass="dnnFormRequired" NumberFormat-DecimalDigits="4" NumberFormat-GroupSizes="9" MinValue="0">
			</dnn2:DnnNumericTextBox>
		</div>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="ShippingSurchargeRateFlatRateLabelControl" runat="server" Text="Shipping surcharge rate (%):" HelpText="Enter the rate in percentage." CssClass="dnnFormRequired"/>
			<asp:RequiredFieldValidator ID="ShippingSurchargeRateFlatRateRequiredFieldValidator" runat="server" ControlToValidate="ShippingSurchargeRateFlatRateDnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="ShippingMethodDetailsViewControl">Shipping surcharge rate is required.</asp:RequiredFieldValidator>
			<dnn2:DnnNumericTextBox ID="ShippingSurchargeRateFlatRateDnnNumericTextBox" runat="server" EnableSingleInputRendering="False" CssClass="dnnFormRequired" Skin="" NumberFormat-DecimalDigits="4" NumberFormat-GroupSizes="9" MinValue="0">
			</dnn2:DnnNumericTextBox>
		</div>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="MeasurementTypeFlatRateLabelControl" runat="server" Text="Measure:" />
			<asp:DropDownList ID="MeasurementTypeFlatRateDropDownList" runat="server">
				<asp:ListItem Text="Shipping amount" Value="shippingAmount" />
				<asp:ListItem Text="Total amount" Value="amount" />
				<asp:ListItem Text="Total quantity" Value="quantity" />
				<asp:ListItem Text="Total weight (g)" Value="weight" />
			</asp:DropDownList>
		</div>
	</asp:View>
	<asp:View ID="TierRateView" runat="server">
		<div class="dnnFormMessage dnnFormInfo">
		<p>This rule calculates the surcharge amount according to the following formula where Measure is either a weight, amount or quantity. The final surcharge amount is either the calculated amount or the Minimum amount, whichever is higher:</p>
		<p><strong>Calculated amount = Base + (Rate x Measure + Amount)</strong></p>
		<p>For example, if your Base is $5.00, your chosen Measure is Weight for a package weighing 1000 grams, your tier Amount is $2.00 and your rate is 1% for that range, the calculated amount is 5 + (0.01 x 1000 + 2) = $17.00</p>
		</div>
        <div class="dnnFormItem">
			<dnn1:LabelControl ID="MinShippingSurchargeAmountTierRateLabelControl" runat="server" Text="Minimum surcharge amount:" CssClass="dnnFormRequired" HelpText="The shipping amount that will be charged if the calculated surcharge amount is less than this minimum amount." />
			<asp:RequiredFieldValidator ID="MinShippingSurchargeAmountTierRateRequiredFieldValidator" runat="server" ControlToValidate="MinShippingSurchargeAmountTierRateDnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="ShippingMethodDetailsViewControl">Min shipping surcharge amount is required.</asp:RequiredFieldValidator>
			<dnn2:DnnNumericTextBox ID="MinShippingSurchargeAmountTierRateDnnNumericTextBox" runat="server" Skin="" EnableSingleInputRendering="False" CssClass="dnnFormRequired" NumberFormat-DecimalDigits="4" NumberFormat-GroupSizes="9" MinValue="0">
			</dnn2:DnnNumericTextBox>
		</div>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="BaseShippingSurchargeAmountTierRateLabelControl" runat="server" Text="Base surcharge amount:" CssClass="dnnFormRequired" HelpText="The base amount to add to the total calculated shipping surcharge amount." />
			<asp:RequiredFieldValidator ID="BaseShippingSurchargeAmountTierRateRequiredFieldValidator" runat="server" ControlToValidate="BaseShippingSurchargeAmountTierRateDnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="ShippingMethodDetailsViewControl">Base surcharge amount is required.</asp:RequiredFieldValidator>
			<dnn2:DnnNumericTextBox ID="BaseShippingSurchargeAmountTierRateDnnNumericTextBox" runat="server" Skin="" EnableSingleInputRendering="False" CssClass="dnnFormRequired" NumberFormat-DecimalDigits="4" NumberFormat-GroupSizes="9" MinValue="0">
			</dnn2:DnnNumericTextBox>
		</div>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="MeasurementTypeTierRateLabelControl" runat="server" Text="Measure:" />
			<asp:DropDownList ID="MeasurementTypeTierRateDropDownList" runat="server">
				<asp:ListItem Text="Shipping amount" Value="shippingAmount" />
				<asp:ListItem Text="Total amount" Value="amount" />
				<asp:ListItem Text="Total quantity" Value="quantity" />
				<asp:ListItem Text="Total weight (g)" Value="weight" />
			</asp:DropDownList>
		</div>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="RangeTierRateLabelControl" runat="server" Text="Range:" HelpText="Surcharge is calculated by finding the closest matching range to apply the shipping surcharge rate." />
			<div class="rvdFormSubContainer">
				<asp:PlaceHolder ID="MessagePlaceHolder" runat="server" />
				<asp:GridView ID="RangeTierRateGridView" runat="server" CssClass="dnnGrid" GridLines="None" AutoGenerateColumns="False" DataKeyNames="Begin,End" OnRowDeleting="RangeTierRateGridView_RowDeleting" OnSelectedIndexChanged="RangeTierRateGridView_SelectedIndexChanged">
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
						<asp:BoundField DataField="Begin" HeaderText="Begin" />
						<asp:BoundField DataField="End" HeaderText="End" />
                        <asp:BoundField DataField="ShippingSurchargeAmount" HeaderText="Amount" />
						<asp:BoundField DataField="ShippingSurchargeRate" HeaderText="Rate" />
					</Columns>
				</asp:GridView>
				<div class="rvdActions">
					<asp:LinkButton ID="AddRangeTierRateLinkButton" runat="server" Text="Add new" OnClick="AddRangeTierRateLinkButton_Click" CausesValidation="false" CssClass="dnnPrimaryAction rvdAddNewAction" />
				</div>
				<asp:Panel ID="RangeTierRateDetailsViewPanel" runat="server">
					<div class="dnnFormItem">
						<dnn1:LabelControl ID="BeginRangeTierRateDetailsViewLabelControl" runat="server" Text="Begin range:" CssClass="dnnFormRequired"/>
						<asp:RequiredFieldValidator ID="BeginRangeTierRateDetailsViewRequiredFieldValidator" runat="server" ControlToValidate="BeginRangeTierRateDetailsViewDnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="RangeTierRateDetailsViewControl">Begin range is required.</asp:RequiredFieldValidator>
						<dnn2:DnnNumericTextBox ID="BeginRangeTierRateDetailsViewDnnNumericTextBox" runat="server" EnableSingleInputRendering="False" CssClass="dnnFormRequired" Skin="" NumberFormat-DecimalDigits="4" NumberFormat-GroupSizes="9" MinValue="0">
						</dnn2:DnnNumericTextBox>
					</div>
					<div class="dnnFormItem">
						<dnn1:LabelControl ID="EndRangeTierRateDetailsViewLabelControl" runat="server" Text="End range:" CssClass="dnnFormRequired"/>
						<asp:RequiredFieldValidator ID="EndRangeTierRateDetailsViewRequiredFieldValidator" runat="server" ControlToValidate="EndRangeTierRateDetailsViewDnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="RangeTierRateDetailsViewControl">End range is required.</asp:RequiredFieldValidator>
						<dnn2:DnnNumericTextBox ID="EndRangeTierRateDetailsViewDnnNumericTextBox" runat="server" EnableSingleInputRendering="False" CssClass="dnnFormRequired" Skin="" NumberFormat-DecimalDigits="4" NumberFormat-GroupSizes="9" MinValue="0">
						</dnn2:DnnNumericTextBox>
					</div>
                    <div class="dnnFormItem">
						<dnn1:LabelControl ID="ShippingSurchargeAmountTierRateDetailsViewLabelControl" runat="server" Text="Amount:" HelpText="Enter the tier amount." CssClass="dnnFormRequired"/>
						<asp:RequiredFieldValidator ID="ShippingSurchargeAmountTierRateDetailsViewRequiredFieldValidator" runat="server" ControlToValidate="ShippingSurchargeAmountTierRateDetailsViewDnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="RangeTierRateDetailsViewControl">Amount is required.</asp:RequiredFieldValidator>
						<dnn2:DnnNumericTextBox ID="ShippingSurchargeAmountTierRateDetailsViewDnnNumericTextBox" runat="server" EnableSingleInputRendering="False" CssClass="dnnFormRequired" Skin="" NumberFormat-DecimalDigits="4" NumberFormat-GroupSizes="9" MinValue="0">
						</dnn2:DnnNumericTextBox>
					</div>
					<div class="dnnFormItem">
						<dnn1:LabelControl ID="ShippingSurchargeRateTierRateDetailsViewLabelControl" runat="server" Text="Rate (%):" HelpText="Enter the percentage rate based on the selected measure." CssClass="dnnFormRequired"/>
						<asp:RequiredFieldValidator ID="ShippingSurchargeRateTierRateDetailsViewRequiredFieldValidator" runat="server" ControlToValidate="ShippingSurchargeRateTierRateDetailsViewDnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="RangeTierRateDetailsViewControl">Rate is required.</asp:RequiredFieldValidator>
						<dnn2:DnnNumericTextBox ID="ShippingSurchargeRateTierRateDetailsViewDnnNumericTextBox" runat="server" EnableSingleInputRendering="False" CssClass="dnnFormRequired" Skin="" NumberFormat-DecimalDigits="4" NumberFormat-GroupSizes="9" MinValue="0">
						</dnn2:DnnNumericTextBox>
					</div>
					<div class="rvdActions">
						<asp:LinkButton ID="SaveRangeTierRateLinkButton" runat="server" Text="OK" OnClick="SaveRangeTierRateLinkButton_Click" ValidationGroup="RangeTierRateDetailsViewControl" CssClass="dnnPrimaryAction rvdOKAction" />
					</div>
				</asp:Panel>
			</div>
		</div>
	</asp:View>
	<asp:View ID="CustomRuleView" runat="server">
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="SurchargeRuleLabelControl" runat="server" Text="XSLT rule:" />
			<uc1:FormulaEditorControl ID="SurchargeRuleFormulaEditor" runat="server" Width="100%" ModuleControl="ShippingMethodSurcharge" />
		</div>
	</asp:View>
</asp:MultiView>