<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Display.ascx.cs" Inherits="Revindex.Dnn.RevindexStorefront.Portals._default.Display.QuickOrder.Standard3.Display" %>
<%@ Register Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI.WebControls" TagPrefix="asp" %>
<%@ Register Src="~/Controls/labelcontrol.ascx" TagName="LabelControl" TagPrefix="dnn1" %>
<%@ Register Assembly="DotNetNuke.Web.Deprecated" Namespace="DotNetNuke.Web.UI.WebControls" TagPrefix="dnn2" %>
<div class="rvdsfQuickOrderContainer">
	<asp:UpdateProgress ID="UpdateProgress" runat="server">
		<ProgressTemplate>
			<div class="rvdUpdateProgressContainer">
				<asp:Image ID="UpdateProgressImage" runat="server" ImageUrl="~/Images/Loading.gif" CssClass="rvdUpdateProgress" />
			</div>
		</ProgressTemplate>
	</asp:UpdateProgress>

	<script type="text/javascript">
		// For IE and Chrome, we need to override the RadComboBox' default behavior the enter key
		// otherwise it doesn't respect the panel's DefaultButton action.
		if (!$telerik.isFirefox)
		{
			var $p = Telerik.Web.UI.RadComboBox.prototype;
			var keyDownHandler = $p._onKeyDown;
			$p._onKeyDown = function(e)
			{
				var oReturnValue = e.returnValue;
				var oPreventDefault = e.preventDefault;
				var keyCode = e.keyCode || e.which;

				if (keyCode === 13)
					e.preventDefault = null;

				keyDownHandler.call(this, e);

				if (keyCode === 13)
				{
					e.returnValue = oReturnValue;
					e.preventDefault = oPreventDefault;
				}
			}
		}
	</script>

	<asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
		<ContentTemplate>
			<asp:PlaceHolder ID="MessagePlaceHolder" runat="server"></asp:PlaceHolder>
			<asp:Panel ID="SearchPanel" runat="server" CssClass="dnnForm" DefaultButton="AddToCartLinkButton">
				<fieldset>
					<div class="dnnFormItem">
						<dnn1:LabelControl runat="server" ID="ProductSearchLabelControl" CssClass="dnnFormRequired"></dnn1:LabelControl>
						<dnn2:DnnComboBox ID="ProductSearchDnnComboBox" CssClass="dnnFormRequired" runat="server" AllowCustomText="True" EnableLoadOnDemand="True" OnItemsRequested="ProductSearchDnnComboBox_ItemsRequested" AutoPostBack="True" OnSelectedIndexChanged="ProductSearchDnnComboBox_SelectedIndexChanged" CausesValidation="False" ValidationGroup="QuickOrderSearchControl" MaxHeight="200">
						</dnn2:DnnComboBox>
					</div>
					<div class="dnnFormItem">
						<dnn1:LabelControl runat="server" ID="ProductVariantSearchLabelControl" CssClass="dnnFormRequired"></dnn1:LabelControl>
						<asp:DropDownList ID="ProductVariantSearchDropDownList" runat="server" CssClass="dnnFormRequired" AutoPostBack="True" OnSelectedIndexChanged="ProductVariantSearchDropDownList_SelectedIndexChanged">
						</asp:DropDownList>
					</div>
					<div class="dnnFormItem">
						<dnn1:LabelControl runat="server" ID="QuantitySearchLabelControl" CssClass="dnnFormRequired"></dnn1:LabelControl>
						<dnn2:DnnNumericTextBox ID="QuantitySearchDnnNumericTextBox" CssClass="rvdQuantityInput dnnFormRequired" runat="server" Skin="" EnableSingleInputRendering="False" MinValue="1" NumberFormat-DecimalDigits="0" NumberFormat-GroupSizes="9" Value="1" />
						<asp:RequiredFieldValidator ID="QuantitySearchRequiredFieldValidator" runat="server" ControlToValidate="QuantitySearchDnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" resourcekey="QuantitySearchRequiredFieldValidator" ValidationGroup="QuickOrderSearchControl" />
						<asp:RangeValidator ID="QuantitySearchRangeValidator" runat="server" resourcekey="QuantitySearchRangeValidator" ControlToValidate="QuantitySearchDnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" MaximumValue="2000000000" MinimumValue="1" Type="Integer" ValidationGroup="QuickOrderSearchControl"></asp:RangeValidator>
					</div>
					<asp:Panel ID="SalePricePanel" runat="server" CssClass="dnnFormItem rvdsfSalePriceAmount">
						<dnn1:LabelControl runat="server" ID="SalePriceLabelControl"></dnn1:LabelControl>
						<asp:Label ID="SalePriceValueLabel" runat="server" /><asp:Label ID="SaleRecurringLabel" runat="server" />
					</asp:Panel>
					<asp:Panel ID="PricePanel" CssClass="dnnFormItem rvdsfPriceAmount" runat="server">
						<dnn1:LabelControl runat="server" ID="PriceLabelControl"></dnn1:LabelControl>
						<asp:Label ID="PriceValueLabel" runat="server" /><asp:Label ID="RecurringLabel" runat="server" />
					</asp:Panel>
					<asp:Panel ID="RewardsPointRewardPanel" runat="server" CssClass="dnnFormItem rvdsfRewardsPointAmount">
						<dnn1:LabelControl ID="RewardsPointRewardLabelControl" runat="server" />
						<asp:Label ID="RewardsPointRewardLabel" runat="server"></asp:Label>
					</asp:Panel>
				</fieldset>
				<ul class="dnnActions dnnClear">
					<li>
						<asp:LinkButton ID="AddToCartLinkButton" runat="server" CssClass="dnnPrimaryAction rvdsfAddToCartAction" resourcekey="AddToCartLinkButton" ValidationGroup="QuickOrderSearchControl" OnClick="AddToCartLinkButton_Click" /></li>
					<li>
						<asp:HyperLink ID="SeeDetailsHyperLink" runat="server" CssClass="dnnSecondaryAction" NavigateUrl="#" Target="_blank" resourcekey="SeeDetailsHyperLink" /></li>
				</ul>
			</asp:Panel>
			<asp:Panel ID="CartPanel" runat="server" CssClass="dnnForm" DefaultButton="CheckoutLinkButton">
				<asp:GridView ID="SalesOrderDetailGridView" CssClass="dnnGrid rvdsfSalesOrderDetailGrid" GridLines="None" runat="server" AutoGenerateColumns="False" DataKeyNames="SalesOrderDetailID" OnSelectedIndexChanged="SalesOrderDetailGridView_SelectedIndexChanged" OnRowDeleting="SalesOrderDetailGridView_RowDeleting">
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
									<dl class="rvdsfProductParts">
								        <asp:Literal ID="ProductPartLiteral" runat="server" Text='<%# Eval("ProductPart") %>' />
							        </dl>
									<dl class="rvdsfDynamicFormResults">
										<asp:Literal ID="DynamicFormResultLiteral" runat="server" Text='<%# Eval("DynamicFormResult") %>' />
									</dl>
								</div>
							</ItemTemplate>
						</asp:TemplateField>
						<asp:BoundField DataField="SKU" HeaderText="SKUHeaderSalesOrderDetailGridView" />
						<asp:BoundField DataField="Price" HeaderText="PriceHeaderSalesOrderDetailGridView" />
						<asp:TemplateField HeaderText="QuantityHeaderSalesOrderDetailGridView">
							<ItemTemplate>
								<dnn2:DnnNumericTextBox ID="QuantityDnnNumericTextBox" runat="server" Skin="" EnableSingleInputRendering="False" Width="50px" MinValue="1" NumberFormat-DecimalDigits="0" NumberFormat-GroupSizes="9" Value='<%# Eval("Quantity_Value") %>' ReadOnly='<%# Convert.ToBoolean(Eval("Quantity_ReadOnly")) %>' CssClass="dnnFormRequired">
								</dnn2:DnnNumericTextBox>
								<asp:RangeValidator ID="QuantityRangeValidator" runat="server" resourcekey="QuantityRangeValidator" ControlToValidate="QuantityDnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" MaximumValue="2000000000" MinimumValue="1" Type="Integer" ValidationGroup="QuickOrderCartControl"></asp:RangeValidator>
								<asp:RequiredFieldValidator ID="QuantityRequiredFieldValidator" runat="server" resourcekey="QuantityRequiredFieldValidator" ControlToValidate="QuantityDnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="QuickOrderCartControl"></asp:RequiredFieldValidator>
							</ItemTemplate>
						</asp:TemplateField>
						<asp:CommandField ShowSelectButton="True" ButtonType="Link" SelectText="" ValidationGroup="QuickOrderCartControl" ControlStyle-CssClass="rvdUpdateGridAction" />
						<asp:CommandField ButtonType="Link" ShowDeleteButton="True" DeleteText="" CausesValidation="False" ControlStyle-CssClass="rvdDeleteGridAction" />
						<asp:BoundField DataField="Amount" HeaderText="AmountHeaderSalesOrderDetailGridView" />
					</Columns>
				</asp:GridView>
				<div class="rvdsfCartTotalAmountContainer">
					<div class="dnnFormItem rvdsfSubTotalAmount">
						<dnn1:LabelControl ID="SubTotalLabelControl" runat="server" />
						<asp:Label ID="SubTotalLabel" runat="server" />
					</div>
					<div class="dnnFormItem rvdsfTotalTaxesAmount">
						<dnn1:LabelControl ID="TaxesLabelControl" runat="server" />
						<asp:Label ID="TaxesLabel" runat="server" />
					</div>
					<div class="dnnFormItem rvdsfTotalAmount">
						<dnn1:LabelControl ID="TotalLabelControl" runat="server" />
						<asp:Label ID="TotalLabel" runat="server" />
					</div>
					<asp:Panel ID="RewardsPointQualifiedPanel" runat="server" CssClass="dnnFormItem rvdsfRewardsPointAmount">
						<dnn1:LabelControl ID="RewardsPointQualifiedLabelControl" runat="server" />
						<asp:Label ID="RewardsPointQualifiedLabel" runat="server"></asp:Label>
					</asp:Panel>
				</div>
				<ul class="dnnActions dnnClear">
					<li>
						<asp:LinkButton ID="CheckoutLinkButton" runat="server" CssClass="dnnPrimaryAction rvdsfCheckoutAction" resourcekey="CheckoutLinkButton" OnClick="CheckoutLinkButton_Click" CausesValidation="False" /></li>
				</ul>
			</asp:Panel>
		</ContentTemplate>
	</asp:UpdatePanel>
</div>
