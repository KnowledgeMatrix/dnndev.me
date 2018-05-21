<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="HandlingMethodRateRuleControl.ascx.cs" Inherits="Revindex.Dnn.RevindexStorefront.HandlingMethodRateRuleControl" %>
<%@ Register Src="~/Controls/labelcontrol.ascx" TagName="LabelControl" TagPrefix="dnn1" %>
<%@ Register Assembly="DotNetNuke.Web.Deprecated" Namespace="DotNetNuke.Web.UI.WebControls" TagPrefix="dnn2" %>
<%@ Register Src="WebUserControls/FormulaEditorControl.ascx" TagName="FormulaEditorControl" TagPrefix="uc1" %>
<div class="dnnFormItem">
	<dnn1:LabelControl ID="RuleTypeLabelControl" runat="server" Text="Rate rule:" />
	<asp:DropDownList ID="RuleTypeDropDownList" runat="server" OnSelectedIndexChanged="RuleTypeDropDownList_SelectedIndexChanged" AutoPostBack="True">
		<asp:ListItem Text="None - zero amount" Value=""></asp:ListItem>
		<asp:ListItem Text="Flat amount - same amount for every order" Value="FlatAmountView"></asp:ListItem>
		<asp:ListItem Text="Flat rate - based on weight, amount, quantity..." Value="FlatRateView"></asp:ListItem>
		<asp:ListItem Text="Product rate - based on product's handling price" Value="ProductRateView"></asp:ListItem>
		<asp:ListItem Text="Tier rate - vary by range" Value="TierRateView"></asp:ListItem>
		<asp:ListItem Text="Custom rule" Value="CustomRuleView"></asp:ListItem>
	</asp:DropDownList>
</div>
<asp:MultiView ID="FormulaMultiView" runat="server" ActiveViewIndex="0">
	<asp:View ID="FlatAmountView" runat="server">
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="HandlingAmountFlatAmountLabelControl" runat="server" Text="Amount:" HelpText="The fixed handling amount to charge." CssClass="dnnFormRequired"/>
			<asp:RequiredFieldValidator ID="HandlingAmountFlatAmountRequiredFieldValidator" runat="server" ControlToValidate="HandlingAmountFlatAmountDnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="HandlingMethodDetailsViewControl">Handling amount is required.</asp:RequiredFieldValidator>
			<dnn2:DnnNumericTextBox ID="HandlingAmountFlatAmountDnnNumericTextBox" runat="server" EnableSingleInputRendering="False" CssClass="dnnFormRequired" Skin="" NumberFormat-DecimalDigits="4" NumberFormat-GroupSizes="9" MinValue="0">
			</dnn2:DnnNumericTextBox>
		</div>
	</asp:View>
	<asp:View ID="FlatRateView" runat="server">
		<div class="dnnFormMessage dnnFormInfo">
		<p>This rule calculates the handling amount according to the following formula where Measure is either a weight, amount or quantity. The final handling amount is either the calculated amount or the Minimum amount, whichever is higher:</p>
		<p><strong>Calculated amount = Base + (Rate x Measure)</strong></p>
		<p>For example, if your Base is $5.00, your chosen Measure is Weight for a package weighing 1000 grams and your rate is 1%, the calculated amount is 5 + 0.01 x 1000 = $15.00</p>
		</div>
        <div class="dnnFormItem">
			<dnn1:LabelControl ID="MinHandlingAmountFlatRateLabelControl" runat="server" Text="Minimum amount:" HelpText="The handling amount that will be charged if the calculated amount is less than this minimum amount." CssClass="dnnFormRequired"/>
			<asp:RequiredFieldValidator ID="MinHandlingAmountFlatRateRequiredFieldValidator" runat="server" ControlToValidate="MinHandlingAmountFlatRateDnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="HandlingMethodDetailsViewControl">Minimum handling amount is required.</asp:RequiredFieldValidator>
			<dnn2:DnnNumericTextBox ID="MinHandlingAmountFlatRateDnnNumericTextBox" runat="server" Skin="" EnableSingleInputRendering="False" CssClass="dnnFormRequired" NumberFormat-DecimalDigits="4" NumberFormat-GroupSizes="9" MinValue="0">
			</dnn2:DnnNumericTextBox>
		</div>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="BaseHandlingAmountFlatRateLabelControl" runat="server" Text="Base amount:" HelpText="The base amount to add to the total calculated handling amount." CssClass="dnnFormRequired"/>
			<asp:RequiredFieldValidator ID="BaseHandlingAmountFlatRateRequiredFieldValidator" runat="server" ControlToValidate="BaseHandlingAmountFlatRateDnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="HandlingMethodDetailsViewControl">Base amount is required.</asp:RequiredFieldValidator>
			<dnn2:DnnNumericTextBox ID="BaseHandlingAmountFlatRateDnnNumericTextBox" runat="server" Skin="" EnableSingleInputRendering="False" CssClass="dnnFormRequired" NumberFormat-DecimalDigits="4" NumberFormat-GroupSizes="9" MinValue="0">
			</dnn2:DnnNumericTextBox>
		</div>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="HandlingRateFlatRateLabelControl" runat="server" Text="Handling rate (%):" HelpText="Enter the percentage rate." CssClass="dnnFormRequired"/>
			<asp:RequiredFieldValidator ID="HandlingRateFlatRateRequiredFieldValidator" runat="server" ControlToValidate="HandlingRateFlatRateDnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="HandlingMethodDetailsViewControl">Handling rate is required.</asp:RequiredFieldValidator>
			<dnn2:DnnNumericTextBox ID="HandlingRateFlatRateDnnNumericTextBox" runat="server" EnableSingleInputRendering="False" CssClass="dnnFormRequired" Skin="" NumberFormat-DecimalDigits="4" NumberFormat-GroupSizes="9" MinValue="0">
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
			<dnn1:LabelControl ID="BaseHandlingAmountProductRateLabelControl" runat="server" Text="Base amount:" HelpText="The base amount to add to the total calculated handling amount." CssClass="dnnFormRequired"/>
			<asp:RequiredFieldValidator ID="BaseHandlingAmountProductRateRequiredFieldValidator" runat="server" ControlToValidate="BaseHandlingAmountProductRateDnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="HandlingMethodDetailsViewControl">Base amount is required.</asp:RequiredFieldValidator>
			<dnn2:DnnNumericTextBox ID="BaseHandlingAmountProductRateDnnNumericTextBox" runat="server" Skin="" EnableSingleInputRendering="False" CssClass="dnnFormRequired" NumberFormat-DecimalDigits="4" NumberFormat-GroupSizes="9" MinValue="0">
			</dnn2:DnnNumericTextBox>
		</div>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="MinHandlingAmountProductRateLabelControl" runat="server" Text="Minimum amount:" HelpText="The handling amount that will be charged if the calculated amount is less than this minimum amount." CssClass="dnnFormRequired"/>
			<asp:RequiredFieldValidator ID="MinHandlingAmountProductRateRequiredFieldValidator" runat="server" ControlToValidate="MinHandlingAmountProductRateDnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="HandlingMethodDetailsViewControl">Minimum handling amount is required.</asp:RequiredFieldValidator>
			<dnn2:DnnNumericTextBox ID="MinHandlingAmountProductRateDnnNumericTextBox" runat="server" Skin="" EnableSingleInputRendering="False" CssClass="dnnFormRequired" NumberFormat-DecimalDigits="4" NumberFormat-GroupSizes="9" MinValue="0">
			</dnn2:DnnNumericTextBox>
		</div>
	</asp:View>
	<asp:View ID="TierRateView" runat="server">
		<div class="dnnFormMessage dnnFormInfo">
		<p>This rule calculates the handling amount according to the following formula where Measure is either a weight, amount or quantity. The final handling amount is either the calculated amount or the Minimum amount, whichever is higher:</p>
		<p><strong>Calculated amount = Base + (Rate x Measure + Amount)</strong></p>
		<p>For example, if your Base is $5.00, your chosen Measure is Weight for a package weighing 1000 grams, your tier Amount is $2.00 and your rate is 1% for that range, the calculated amount is 5 + (0.01 x 1000 + 2) = $17.00</p>
		</div>
        <div class="dnnFormItem">
			<dnn1:LabelControl ID="MinHandlingAmountTierRateLabelControl" runat="server" Text="Minimum amount:" HelpText="The handling amount that will be charged if the calculated amount is less than this minimum amount." CssClass="dnnFormRequired"/>
			<asp:RequiredFieldValidator ID="MinHandlingAmountTierRateRequiredFieldValidator" runat="server" ControlToValidate="MinHandlingAmountTierRateDnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="HandlingMethodDetailsViewControl">Min handling amount is required.</asp:RequiredFieldValidator>
			<dnn2:DnnNumericTextBox ID="MinHandlingAmountTierRateDnnNumericTextBox" runat="server" Skin="" EnableSingleInputRendering="False" CssClass="dnnFormRequired" NumberFormat-DecimalDigits="4" NumberFormat-GroupSizes="9" MinValue="0">
			</dnn2:DnnNumericTextBox>
		</div>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="BaseHandlingAmountTierRateLabelControl" runat="server" Text="Base amount:" HelpText="The base amount to add to the total calculated handling amount." CssClass="dnnFormRequired"/>
			<asp:RequiredFieldValidator ID="BaseHandlingAmountTierRateRequiredFieldValidator" runat="server" ControlToValidate="BaseHandlingAmountTierRateDnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="HandlingMethodDetailsViewControl">Base amount is required.</asp:RequiredFieldValidator>
			<dnn2:DnnNumericTextBox ID="BaseHandlingAmountTierRateDnnNumericTextBox" runat="server" Skin="" EnableSingleInputRendering="False" CssClass="dnnFormRequired" NumberFormat-DecimalDigits="4" NumberFormat-GroupSizes="9" MinValue="0">
			</dnn2:DnnNumericTextBox>
		</div>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="MeasurementTypeTierRateLabelControl" runat="server" Text="Measure:" />
			<asp:DropDownList ID="MeasurementTypeTierRateDropDownList" runat="server">
				<asp:ListItem Text="Total amount" Value="amount" />
				<asp:ListItem Text="Total quantity" Value="quantity" />
				<asp:ListItem Text="Total weight (g)" Value="weight" />
			</asp:DropDownList>
		</div>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="RangeTierRateLabelControl" runat="server" Text="Range:" HelpText="Handling is calculated by finding the closest matching range to apply the handling rate." />
			<div class="rvdFormSubContainer">
				<asp:PlaceHolder ID="MessagePlaceHolder" runat="server" />
				<asp:GridView ID="RangeTierRateGridView" runat="server" CssClass="dnnGrid" GridLines="None" AutoGenerateColumns="False" DataKeyNames="Begin,End" OnRowDeleting="RangeTierRateGridView_RowDeleting" OnSelectedIndexChanged="RangeTierRateGridView_SelectedIndexChanged" >
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
                        <asp:BoundField DataField="HandlingAmount" HeaderText="Amount" />
						<asp:BoundField DataField="HandlingRate" HeaderText="Rate" />
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
						<dnn1:LabelControl ID="HandlingAmountTierRateDetailsViewLabelControl" runat="server" Text="Amount:" HelpText="Enter the tier amount." CssClass="dnnFormRequired"/>
						<asp:RequiredFieldValidator ID="HandlingAmountTierRateDetailsViewRequiredFieldValidator" runat="server" ControlToValidate="HandlingAmountTierRateDetailsViewDnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="RangeTierRateDetailsViewControl">Amount is required.</asp:RequiredFieldValidator>
						<dnn2:DnnNumericTextBox ID="HandlingAmountTierRateDetailsViewDnnNumericTextBox" runat="server" EnableSingleInputRendering="False" CssClass="dnnFormRequired" Skin="" NumberFormat-DecimalDigits="4" NumberFormat-GroupSizes="9" MinValue="0">
						</dnn2:DnnNumericTextBox>
					</div>
					<div class="dnnFormItem">
						<dnn1:LabelControl ID="HandlingRateTierRateDetailsViewLabelControl" runat="server" Text="Rate (%):" HelpText="Enter the percentage rate." CssClass="dnnFormRequired"/>
						<asp:RequiredFieldValidator ID="HandlingRateTierRateDetailsViewRequiredFieldValidator" runat="server" ControlToValidate="HandlingRateTierRateDetailsViewDnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="RangeTierRateDetailsViewControl">Rate is required.</asp:RequiredFieldValidator>
						<dnn2:DnnNumericTextBox ID="HandlingRateTierRateDetailsViewDnnNumericTextBox" runat="server" EnableSingleInputRendering="False" CssClass="dnnFormRequired" Skin="" NumberFormat-DecimalDigits="4" NumberFormat-GroupSizes="9" MinValue="0">
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
			<uc1:FormulaEditorControl ID="RateRuleFormulaEditor" runat="server" Width="100%" ModuleControl="HandlingMethodRate" />
		</div>
	</asp:View>
</asp:MultiView>