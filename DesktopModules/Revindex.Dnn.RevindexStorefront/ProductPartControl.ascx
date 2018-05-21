<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ProductPartControl.ascx.cs" Inherits="Revindex.Dnn.RevindexStorefront.ProductPartControl" %>
<%@ Register Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Src="~/Controls/labelcontrol.ascx" TagName="LabelControl" TagPrefix="dnn1" %>
<%@ Register Assembly="DotNetNuke.Web.Deprecated" Namespace="DotNetNuke.Web.UI.WebControls" TagPrefix="dnn2" %>
<%@ Register Assembly="Revindex.Web.UI.WebControls" Namespace="Revindex.Web.UI.WebControls" TagPrefix="rvd1" %>
<%@ Register Src="ProductPartModifierRuleControl.ascx" TagName="ProductPartModifierRuleControl" TagPrefix="uc1" %>
<%@ Register Src="WebUserControls/Common/Dnn/BackControl.ascx" TagName="BackControl" TagPrefix="uc1" %>
<%@ Register Src="WebUserControls/Common/Dnn/BreadcrumbControl.ascx" TagName="BreadcrumbControl" TagPrefix="uc1" %>
<div>
	<asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
		<ContentTemplate>
			<asp:PlaceHolder ID="MessagePlaceHolder" runat="server" />
			<asp:MultiView ID="ContentMultiView" runat="server">
				<asp:View ID="ListView" runat="server">
					<div class="dnnForm rvdsfListContainer">
						<asp:GridView ID="ProductPartGridView" runat="server" AllowSorting="False" AutoGenerateColumns="False" DataKeyNames="ProductPartID" CssClass="dnnGrid" GridLines="None" AllowPaging="False" OnRowDeleting="ProductPartGridView_RowDeleting" OnRowDataBound="ProductPartGridView_RowDataBound">
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
								<asp:BoundField DataField="ProductName" HeaderText="Product" />
								<asp:BoundField DataField="SKU" HeaderText="SKU" />
                                <asp:CheckBoxField DataField="Selected" HeaderText="Selected" />
								<asp:BoundField DataField="DefaultQuantity" HeaderText="Quantity" />
								<asp:BoundField DataField="DisplayOrder" HeaderText="Display order" />
							</Columns>
						</asp:GridView>
						<ul class="dnnActions dnnClear">
							<li>
								<asp:HyperLink ID="AddHyperLink" runat="server" Text="Add new" CssClass="dnnPrimaryAction rvdAddNewAction" />
							</li>
							<li>
								<asp:HyperLink ID="ImportHyperLink" runat="server" Text="Import" CssClass="dnnSecondaryAction rvdImportAction" />
							</li>
							<li>
								<asp:HyperLink ID="ExportViewHyperLink" runat="server" Text="Export view" CssClass="dnnSecondaryAction rvdExportAction" />
							</li>
							<li>
								<asp:HyperLink ID="ExportAllHyperLink" runat="server" Text="Export all" CssClass="dnnSecondaryAction rvdExportAction" />
							</li>
						</ul>
					</div>
				</asp:View>
				<asp:View ID="DetailsView" runat="server">
					<uc1:BackControl ID="QuickBackControl" runat="server" Text="" CssClass="rvdsfBackAction" />
					<h2>Part: <uc1:BreadcrumbControl ID="BreadcrumbControl" runat="server" /></h2>
					<div id="ProductPartDetailsViewTabPanel" class="dnnForm">
							<h2 class="dnnFormSectionHead"><a href="#">General</a></h2>
							<fieldset>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="ProductPartIDLabelControl" runat="server" Text="Product part ID:" />
									<asp:Label ID="ProductPartIDLabel" runat="server"></asp:Label>
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="ProductPartVariantLabelControl" runat="server" Text="Product:" CssClass="dnnFormRequired" />
									<asp:RequiredFieldValidator ID="ProductPartVariantRequiredFieldValidator" runat="server" ControlToValidate="ProductPartVariantDnnComboBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="ProductPartDetailsViewControl" InitialValue="">Required product is required.</asp:RequiredFieldValidator>
									<dnn2:DnnComboBox ID="ProductPartVariantDnnComboBox" runat="server" AllowCustomText="True" CssClass="dnnFormRequired" EnableLoadOnDemand="True" OnItemsRequested="ProductPartVariantDnnComboBox_ItemsRequested" AutoPostBack="True" CausesValidation="False" MaxHeight="200px">
									</dnn2:DnnComboBox>
									<asp:LinkButton ID="ProductPartVariantLinkButton" runat="server" CssClass="rvdLinkAction" Text="Edit" OnClick="ProductPartVariantLinkButton_Click" CausesValidation="False" />
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="SelectedLabelControl" runat="server" Text="Selected:" HelpText="Determine if the product is selected by default. Only selected parts are qualified to be added to the cart." />
									<asp:CheckBox ID="SelectedCheckBox" runat="server" />
								</div>
							</fieldset>
							<h2 class="dnnFormSectionHead"><a href="#">Price</a></h2>
							<fieldset>
								<uc1:ProductPartModifierRuleControl ID="ModifierRuleControl" runat="server" Width="100%" />
							</fieldset>
							<h2 class="dnnFormSectionHead"><a href="#">Inventory</a></h2>
							<fieldset>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="DefaultQuantityLabelControl" runat="server" HelpText="Enter a default quantity value." Text="Default quantity:"></dnn1:LabelControl>
									<asp:RequiredFieldValidator ID="DefaultQuantityRequiredFieldValidator" runat="server" ControlToValidate="DefaultQuantityDnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="ProductPartDetailsViewControl">Default quantity is required.</asp:RequiredFieldValidator>
									<dnn2:DnnNumericTextBox ID="DefaultQuantityDnnNumericTextBox" runat="server" Skin="" Value="1000" NumberFormat-DecimalDigits="0" NumberFormat-GroupSizes="9" EnableSingleInputRendering="False" MinValue="0">
									</dnn2:DnnNumericTextBox>
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="MinOrderQuantityLabelControl" runat="server" HelpText="Empty value indicates no minimum order." Text="Min order quantity:"></dnn1:LabelControl>
									<dnn2:DnnNumericTextBox ID="MinOrderQuantityDnnNumericTextBox" runat="server" Skin="" Value="1000" NumberFormat-DecimalDigits="0" NumberFormat-GroupSizes="9" EnableSingleInputRendering="False" MinValue="1">
									</dnn2:DnnNumericTextBox>
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="MaxOrderQuantityLabelControl" runat="server" HelpText="Empty value indicates unlimited order." Text="Max order quantity:"></dnn1:LabelControl>
									<dnn2:DnnNumericTextBox ID="MaxOrderQuantityDnnNumericTextBox" runat="server" Skin="" Value="1000" NumberFormat-DecimalDigits="0" NumberFormat-GroupSizes="9" EnableSingleInputRendering="False" MinValue="1">
									</dnn2:DnnNumericTextBox>
								</div>
							</fieldset>
							<h2 class="dnnFormSectionHead"><a href="#">Display</a></h2>
							<fieldset>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="DisplayOrderLabelControl" runat="server" HelpText="Sort the item for display by lowest to highest number starting from zero." Text="Display order:" CssClass="dnnFormRequired" />
									<asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="DisplayOrderDnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="ProductPartDetailsViewControl">Display order is required.</asp:RequiredFieldValidator>
									<dnn2:DnnNumericTextBox ID="DisplayOrderDnnNumericTextBox" runat="server" Skin="" Value="1000" NumberFormat-DecimalDigits="0" NumberFormat-GroupSizes="9" EnableSingleInputRendering="False" CssClass="dnnFormRequired">
									</dnn2:DnnNumericTextBox>
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="ShowPriceLabelControl" runat="server" Text="Show price:" />
									<asp:CheckBox ID="ShowPriceCheckBox" runat="server" />
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="ShowQuantityLabelControl" runat="server" Text="Show quantity:" />
									<asp:CheckBox ID="ShowQuantityCheckBox" runat="server" />
								</div>
							</fieldset>
					</div>
					<div class="dnnForm">
						<ul class="dnnActions">
							<li>
								<asp:LinkButton ID="SaveLinkButton" runat="server" Text="Save" OnClick="SaveLinkButton_Click" ValidationGroup="ProductPartDetailsViewControl" CssClass="dnnPrimaryAction rvdSaveAction" />
							</li>
							<li>
								<asp:LinkButton ID="SaveAndBackLinkButton" runat="server" Text="Save & return" OnClick="SaveLinkButton_Click" CommandArgument="Back" CssClass="dnnPrimaryAction rvdSaveAction" ValidationGroup="ProductPartDetailsViewControl" />
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
