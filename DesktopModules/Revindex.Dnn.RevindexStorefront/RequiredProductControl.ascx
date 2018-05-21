<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="RequiredProductControl.ascx.cs" Inherits="Revindex.Dnn.RevindexStorefront.RequiredProductControl" %>
<%@ Register Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Src="~/Controls/labelcontrol.ascx" TagName="LabelControl" TagPrefix="dnn1" %>
<%@ Register Assembly="DotNetNuke.Web.Deprecated" Namespace="DotNetNuke.Web.UI.WebControls" TagPrefix="dnn2" %>
<%@ Register Assembly="Revindex.Web.UI.WebControls" Namespace="Revindex.Web.UI.WebControls" TagPrefix="rvd1" %>
<%@ Register Src="WebUserControls/Common/Dnn/BackControl.ascx" TagName="BackControl" TagPrefix="uc1" %>
<%@ Register Src="WebUserControls/Common/Dnn/BreadcrumbControl.ascx" TagName="BreadcrumbControl" TagPrefix="uc1" %>
<asp:PlaceHolder ID="PlaceHolder1" runat="server">

	<script type="text/javascript">
		jQuery(document).ready(function ()
		{
			jQuery('#RequiredProductDetailsViewTabPanel').dnnTabs();
		});
		Sys.WebForms.PageRequestManager.getInstance().add_endRequest(function ()
		{
			jQuery('#RequiredProductDetailsViewTabPanel').dnnTabs();
		});
	</script>

</asp:PlaceHolder>
<div>
	<asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
		<ContentTemplate>
			<asp:PlaceHolder ID="MessagePlaceHolder" runat="server" />
			<asp:MultiView ID="ContentMultiView" runat="server">
				<asp:View ID="ListView" runat="server">
					<div class="dnnForm rvdsfListContainer">
						<asp:GridView ID="RequiredProductGridView" runat="server" AllowSorting="False" AutoGenerateColumns="False" DataKeyNames="RequiredProductID" CssClass="dnnGrid" GridLines="None" AllowPaging="False" OnRowDeleting="RequiredProductGridView_RowDeleting" OnRowDataBound="RequiredProductGridView_RowDataBound">
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
								<asp:CheckBoxField DataField="Published" HeaderText="Published" />
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
					<h2>Required product: <uc1:BreadcrumbControl ID="BreadcrumbControl" runat="server" /></h2>
					<div id="RequiredProductDetailsViewTabPanel" class="dnnForm">
						<ul class="dnnAdminTabNav dnnClear">
							<li><a href="#<%= GeneralDetailsViewPanel.ClientID %>">
								<asp:Label ID="GeneralDetailsViewTabLabel" runat="server" Text="General" /></a></li>
						</ul>
						<asp:Panel ID="GeneralDetailsViewPanel" runat="server" CssClass="dnnClear">
							<fieldset>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="RequiredProductIDLabelControl" runat="server" Text="Required product ID:" />
									<asp:Label ID="RequiredProductIDLabel" runat="server"></asp:Label>
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="RequiredProductVariantLabelControl" runat="server" Text="Required product:" CssClass="dnnFormRequired" />
									<asp:RequiredFieldValidator ID="RequiredProductVariantRequiredFieldValidator" runat="server" ControlToValidate="RequiredProductVariantDnnComboBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="RequiredProductDetailsViewControl" InitialValue="">Required product is required.</asp:RequiredFieldValidator>
									<dnn2:DnnComboBox ID="RequiredProductVariantDnnComboBox" runat="server" AllowCustomText="True" CssClass="dnnFormRequired" EnableLoadOnDemand="True" OnItemsRequested="RequiredProductVariantDnnComboBox_ItemsRequested" AutoPostBack="True" CausesValidation="False" MaxHeight="200px">
									</dnn2:DnnComboBox>
									<asp:LinkButton ID="RequiredProductVariantLinkButton" runat="server" CssClass="rvdLinkAction" Text="Edit" OnClick="RequiredProductVariantLinkButton_Click" CausesValidation="False" />
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="QuantityLabelControl" runat="server" HelpText="Enter a non-zero value that should match the quantity ordered (e.g. if you set a value of 2 and the customers places an order for 2 items, the total required products will equal 4). Enter a value of 1 if you want to have a one to one match. If you want a single required product regardless of any number of items purchased, enter a value of 0." Text="Quantity:"></dnn1:LabelControl>
									<asp:RequiredFieldValidator ID="QuantityRequiredFieldValidator" runat="server" ControlToValidate="QuantityDnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="RequiredProductDetailsViewControl">Quantity is required.</asp:RequiredFieldValidator>
									<dnn2:DnnNumericTextBox ID="QuantityDnnNumericTextBox" runat="server" Skin="" Value="1000" NumberFormat-DecimalDigits="0" NumberFormat-GroupSizes="9" EnableSingleInputRendering="False" MinValue="0">
									</dnn2:DnnNumericTextBox>
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="PublishedLabelControl" runat="server" Text="Published:" HelpText="Determine if the required product is disclosed to the customer." />
									<asp:CheckBox ID="PublishedCheckBox" runat="server" />
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="DeferDateTypeLabelControl" runat="server" EnableViewState="False" HelpText="Defer from adding this required product to the customer's order until the time is reached (e.g. if you sell a regular product that should cause another recurring product to start at a later time). Enter a fixed deferral date or calculated interval from the order date." Text="Defer date:" />
									<asp:RadioButtonList ID="DeferDateTypeRadioButtonList" runat="server" RepeatDirection="Horizontal" AutoPostBack="True" OnSelectedIndexChanged="DeferDateTypeRadioButtonList_SelectedIndexChanged" RepeatLayout="Flow" CssClass="dnnFormRadioButtons">
										<asp:ListItem Text="Fixed date" Value="Fixed date" Selected="True"></asp:ListItem>
										<asp:ListItem Text="Interval" Value="Interval"></asp:ListItem>
									</asp:RadioButtonList>
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="DeferDateLabelControl" runat="server" EnableViewState="False" HelpText="Leave date blank or a zero interval value if product is required immediately." Text="" />
									<asp:MultiView ID="DeferDateTypeMultiView" runat="server" ActiveViewIndex="0">
										<asp:View ID="FixedDeferDateView" runat="server">
											<dnn2:DnnDatePicker ID="DeferDateDnnDatePicker" runat="server" ShowPopupOnFocus="True" DatePopupButton-Visible="False" DateInput-DateFormat="yyyy-MM-dd" DateInput-EmptyMessage="YYYY-MM-DD">
											</dnn2:DnnDatePicker>
										</asp:View>
										<asp:View ID="DeferIntervalView" runat="server">
											<asp:RequiredFieldValidator ID="DeferRequiredFieldValidator" runat="server" ControlToValidate="DeferIntervalDnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="RequiredProductDetailsViewControl">Defer interval is required.</asp:RequiredFieldValidator>
											<dnn2:DnnNumericTextBox ID="DeferIntervalDnnNumericTextBox" runat="server" Skin="" NumberFormat-DecimalDigits="0" NumberFormat-GroupSizes="9" MinValue="0" EnableSingleInputRendering="False" CssClass="dnnFormRequired rvdQuantityInput" Value="0">
											</dnn2:DnnNumericTextBox>
											<asp:DropDownList ID="DeferIntervalTypeDropDownList" runat="server" CssClass="rvdUnitInput">
												<asp:ListItem Value="1">Day</asp:ListItem>
												<asp:ListItem Value="2">Week</asp:ListItem>
												<asp:ListItem Value="3">Month</asp:ListItem>
												<asp:ListItem Value="4">Year</asp:ListItem>
											</asp:DropDownList>
										</asp:View>
									</asp:MultiView>
								</div>
							</fieldset>
						</asp:Panel>
					</div>
					<div class="dnnForm">
						<ul class="dnnActions">
							<li>
								<asp:LinkButton ID="SaveLinkButton" runat="server" Text="Save" OnClick="SaveLinkButton_Click" ValidationGroup="RequiredProductDetailsViewControl" CssClass="dnnPrimaryAction rvdSaveAction" />
							</li>
							<li>
								<asp:LinkButton ID="SaveAndBackLinkButton" runat="server" Text="Save & return" OnClick="SaveLinkButton_Click" CommandArgument="Back" CssClass="dnnPrimaryAction rvdSaveAction" ValidationGroup="RequiredProductDetailsViewControl" />
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
