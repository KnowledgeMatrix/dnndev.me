<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ShippingMethodRateRuleControl.ascx.cs" Inherits="Revindex.Dnn.RevindexStorefront.ShippingMethodRateRuleControl" %>
<%@ Register Src="~/Controls/labelcontrol.ascx" TagName="LabelControl" TagPrefix="dnn1" %>
<%@ Register Assembly="DotNetNuke.Web.Deprecated" Namespace="DotNetNuke.Web.UI.WebControls" TagPrefix="dnn2" %>
<%@ Register Src="WebUserControls/FormulaEditorControl.ascx" TagName="FormulaEditorControl" TagPrefix="uc1" %>
<div class="dnnFormItem">
	<dnn1:LabelControl ID="RuleTypeLabelControl" runat="server" Text="Rate rule:" />
	<asp:DropDownList ID="RuleTypeDropDownList" runat="server" OnSelectedIndexChanged="RuleTypeDropDownList_SelectedIndexChanged" AutoPostBack="True" >
		<asp:ListItem Text="None - zero amount" Value=""></asp:ListItem>
		<asp:ListItem Text="Flat amount - same amount for every order" Value="FlatAmountView"></asp:ListItem>
		<asp:ListItem Text="Flat rate - based on weight, amount, quantity..." Value="FlatRateView"></asp:ListItem>
		<asp:ListItem Text="Product rate - based on product's shipping price" Value="ProductRateView"></asp:ListItem>
		<asp:ListItem Text="Tier rate - vary by range" Value="TierRateView"></asp:ListItem>
		<asp:ListItem Text="Custom rule" Value="CustomRuleView"></asp:ListItem>
	</asp:DropDownList>
</div>
<asp:MultiView ID="FormulaMultiView" runat="server" ActiveViewIndex="0">
	<asp:View ID="FlatAmountView" runat="server">
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="ShippingAmountFlatAmountLabelControl" runat="server" Text="Amount:" HelpText="The fixed shipping amount to charge." CssClass="dnnFormRequired"/>
			<asp:RequiredFieldValidator ID="ShippingAmountFlatAmountRequiredFieldValidator" runat="server" ControlToValidate="ShippingAmountFlatAmountDnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="ShippingMethodDetailsViewControl">Shipping amount is required.</asp:RequiredFieldValidator>
			<dnn2:DnnNumericTextBox ID="ShippingAmountFlatAmountDnnNumericTextBox" runat="server" EnableSingleInputRendering="False" CssClass="dnnFormRequired" Skin="" NumberFormat-DecimalDigits="4" NumberFormat-GroupSizes="9" MinValue="0">
			</dnn2:DnnNumericTextBox>
		</div>
	</asp:View>
	<asp:View ID="FlatRateView" runat="server">
		<div class="dnnFormMessage dnnFormInfo">
		<p>This rule calculates the shipping amount according to the following formula where Measure is either a weight, amount or quantity. The final shipping amount is either the calculated amount or the Minimum amount, whichever is higher:</p>
		<p><strong>Calculated amount = Base + (Rate x Measure)</strong></p>
		<p>For example, if your Base is $5.00, your chosen Measure is Weight for a package weighing 1000 grams and your rate is 1%, the calculated amount is 5 + 0.01 x 1000 = $15.00</p>
		</div>
        <div class="dnnFormItem">
			<dnn1:LabelControl ID="MinShippingAmountFlatRateLabelControl" runat="server" Text="Minimum amount:" CssClass="dnnFormRequired" HelpText="The shipping amount that will be charged if the calculated amount is less than this minimum amount." />
			<asp:RequiredFieldValidator ID="MinShippingAmountFlatRateRequiredFieldValidator" runat="server" ControlToValidate="MinShippingAmountFlatRateDnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="ShippingMethodDetailsViewControl">Min shipping amount is required.</asp:RequiredFieldValidator>
			<dnn2:DnnNumericTextBox ID="MinShippingAmountFlatRateDnnNumericTextBox" runat="server" Skin="" EnableSingleInputRendering="False" CssClass="dnnFormRequired" NumberFormat-DecimalDigits="4" NumberFormat-GroupSizes="9" MinValue="0">
			</dnn2:DnnNumericTextBox>
		</div>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="BaseShippingAmountFlatRateLabelControl" runat="server" Text="Base amount:" HelpText="The base amount to add to the total calculated shipping amount." CssClass="dnnFormRequired"/>
			<asp:RequiredFieldValidator ID="BaseShippingAmountFlatRateRequiredFieldValidator" runat="server" ControlToValidate="BaseShippingAmountFlatRateDnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="ShippingMethodDetailsViewControl">Base amount is required.</asp:RequiredFieldValidator>
			<dnn2:DnnNumericTextBox ID="BaseShippingAmountFlatRateDnnNumericTextBox" runat="server" Skin="" EnableSingleInputRendering="False" CssClass="dnnFormRequired" NumberFormat-DecimalDigits="4" NumberFormat-GroupSizes="9" MinValue="0">
			</dnn2:DnnNumericTextBox>
		</div>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="ShippingRateFlatRateLabelControl" runat="server" Text="Shipping rate (%):" HelpText="Enter the rate in percentage." CssClass="dnnFormRequired"/>
			<asp:RequiredFieldValidator ID="ShippingRateFlatRateRequiredFieldValidator" runat="server" ControlToValidate="ShippingRateFlatRateDnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="ShippingMethodDetailsViewControl">Shipping rate is required.</asp:RequiredFieldValidator>
			<dnn2:DnnNumericTextBox ID="ShippingRateFlatRateDnnNumericTextBox" runat="server" EnableSingleInputRendering="False" CssClass="dnnFormRequired" Skin="" NumberFormat-DecimalDigits="4" NumberFormat-GroupSizes="9" MinValue="0">
			</dnn2:DnnNumericTextBox>
		</div>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="MeasurementTypeFlatRateLabelControl" runat="server" Text="Measure:" />
			<asp:DropDownList ID="MeasurementTypeFlatRateDropDownList" runat="server">
				<asp:ListItem Text="Total amount" Value="amount" />
				<asp:ListItem Text="Total quantity" Value="quantity" />
				<asp:ListItem Text="Total weight (g)" Value="weight" />
			</asp:DropDownList>
		</div>
	</asp:View>
	<asp:View ID="ProductRateView" runat="server">
        <div class="dnnFormItem">
			<dnn1:LabelControl ID="MinShippingAmountProductRateLabelControl" runat="server" Text="Minimum amount:" CssClass="dnnFormRequired" HelpText="The shipping amount that will be charged if the calculated amount is less than this minimum amount." />
			<asp:RequiredFieldValidator ID="MinShippingAmountProductRateRequiredFieldValidator" runat="server" ControlToValidate="MinShippingAmountProductRateDnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="ShippingMethodDetailsViewControl">Min shipping amount is required.</asp:RequiredFieldValidator>
			<dnn2:DnnNumericTextBox ID="MinShippingAmountProductRateDnnNumericTextBox" runat="server" Skin="" EnableSingleInputRendering="False" CssClass="dnnFormRequired" NumberFormat-DecimalDigits="4" NumberFormat-GroupSizes="9" MinValue="0">
			</dnn2:DnnNumericTextBox>
		</div>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="BaseShippingAmountProductRateLabelControl" runat="server" Text="Base amount:" CssClass="dnnFormRequired" HelpText="The base amount to add to the total calculated shipping amount." />
			<asp:RequiredFieldValidator ID="BaseShippingAmountProductRateRequiredFieldValidator" runat="server" ControlToValidate="BaseShippingAmountProductRateDnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="ShippingMethodDetailsViewControl">Base amount is required.</asp:RequiredFieldValidator>
			<dnn2:DnnNumericTextBox ID="BaseShippingAmountProductRateDnnNumericTextBox" runat="server" Skin="" EnableSingleInputRendering="False" CssClass="dnnFormRequired" NumberFormat-DecimalDigits="4" NumberFormat-GroupSizes="9" MinValue="0">
			</dnn2:DnnNumericTextBox>
		</div>
	</asp:View>
	<asp:View ID="TierRateView" runat="server">
		<div class="dnnFormMessage dnnFormInfo">
		<p>This rule calculates the shipping amount according to the following formula where Measure is either a weight, amount or quantity. The final shipping amount is either the calculated amount or the Minimum amount, whichever is higher:</p>
		<p><strong>Calculated amount = Base + (Rate x Measure + Amount)</strong></p>
		<p>For example, if your Base is $5.00, your chosen Measure is Weight for a package weighing 1000 grams, your tier Amount is $2.00 and your rate is 1% for that range, the calculated amount is 5 + (0.01 x 1000 + 2) = $17.00</p>
		</div>
        <div class="dnnFormItem">
			<dnn1:LabelControl ID="MinShippingAmountTierRateLabelControl" runat="server" Text="Minimum amount:" CssClass="dnnFormRequired" HelpText="The shipping amount that will be charged if the calculated amount is less than this minimum amount." />
			<asp:RequiredFieldValidator ID="MinShippingAmountTierRateRequiredFieldValidator" runat="server" ControlToValidate="MinShippingAmountTierRateDnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="ShippingMethodDetailsViewControl">Min shipping amount is required.</asp:RequiredFieldValidator>
			<dnn2:DnnNumericTextBox ID="MinShippingAmountTierRateDnnNumericTextBox" runat="server" Skin="" EnableSingleInputRendering="False" CssClass="dnnFormRequired" NumberFormat-DecimalDigits="4" NumberFormat-GroupSizes="9" MinValue="0">
			</dnn2:DnnNumericTextBox>
		</div>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="BaseShippingAmountTierRateLabelControl" runat="server" Text="Base amount:" CssClass="dnnFormRequired" HelpText="The base amount to add to the total calculated shipping amount." />
			<asp:RequiredFieldValidator ID="BaseShippingAmountTierRateRequiredFieldValidator" runat="server" ControlToValidate="BaseShippingAmountTierRateDnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="ShippingMethodDetailsViewControl">Base amount is required.</asp:RequiredFieldValidator>
			<dnn2:DnnNumericTextBox ID="BaseShippingAmountTierRateDnnNumericTextBox" runat="server" Skin="" EnableSingleInputRendering="False" CssClass="dnnFormRequired" NumberFormat-DecimalDigits="4" NumberFormat-GroupSizes="9" MinValue="0">
			</dnn2:DnnNumericTextBox>
		</div>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="MeasurementTypeTierRateLabelControl" runat="server" Text="Measure:" HelpText="The rate is based on this measure."/>
			<asp:DropDownList ID="MeasurementTypeTierRateDropDownList" runat="server">
				<asp:ListItem Text="Total amount" Value="amount" />
				<asp:ListItem Text="Total quantity" Value="quantity" />
				<asp:ListItem Text="Total weight (g)" Value="weight" />
			</asp:DropDownList>
		</div>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="RangeTierRateLabelControl" runat="server" Text="Range:" HelpText="Shipping is calculated by finding the closest matching range to apply the shipping rate." />
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
                        <asp:BoundField DataField="ShippingAmount" HeaderText="Amount" />
						<asp:BoundField DataField="ShippingRate" HeaderText="Rate" />
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
						<dnn1:LabelControl ID="ShippingAmountTierRateDetailsViewLabelControl" runat="server" Text="Amount:" HelpText="Enter the tier amount." CssClass="dnnFormRequired"/>
						<asp:RequiredFieldValidator ID="RequiredFieldValidator" runat="server" ControlToValidate="ShippingAmountTierRateDetailsViewDnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="RangeTierRateDetailsViewControl">Amount is required.</asp:RequiredFieldValidator>
						<dnn2:DnnNumericTextBox ID="ShippingAmountTierRateDetailsViewDnnNumericTextBox" runat="server" EnableSingleInputRendering="False" CssClass="dnnFormRequired" Skin="" NumberFormat-DecimalDigits="4" NumberFormat-GroupSizes="9" MinValue="0">
						</dnn2:DnnNumericTextBox>
					</div>
					<div class="dnnFormItem">
						<dnn1:LabelControl ID="ShippingRateTierRateDetailsViewLabelControl" runat="server" Text="Rate (%):" HelpText="Enter the percentage rate that will be multiplied with the selected measure." CssClass="dnnFormRequired"/>
						<asp:RequiredFieldValidator ID="ShippingRateTierRateDetailsViewRequiredFieldValidator" runat="server" ControlToValidate="ShippingRateTierRateDetailsViewDnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="RangeTierRateDetailsViewControl">Rate is required.</asp:RequiredFieldValidator>
						<dnn2:DnnNumericTextBox ID="ShippingRateTierRateDetailsViewDnnNumericTextBox" runat="server" EnableSingleInputRendering="False" CssClass="dnnFormRequired" Skin="" NumberFormat-DecimalDigits="4" NumberFormat-GroupSizes="9" MinValue="0">
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
			<dnn1:LabelControl ID="RateRuleLabelControl" runat="server" Text="XSLT rule:" />
			<uc1:FormulaEditorControl ID="RateRuleFormulaEditor" runat="server" Width="100%" ModuleControl="ShippingMethodRate" />
		</div>
	</asp:View>
</asp:MultiView>