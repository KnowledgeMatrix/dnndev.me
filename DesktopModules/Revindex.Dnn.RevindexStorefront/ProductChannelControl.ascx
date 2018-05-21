<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ProductChannelControl.ascx.cs" Inherits="Revindex.Dnn.RevindexStorefront.ProductChannelControl" %>
<%@ Register Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Src="~/Controls/labelcontrol.ascx" TagName="LabelControl" TagPrefix="dnn1" %>
<%@ Register Src="~/Controls/texteditor.ascx" TagName="TextEditor" TagPrefix="dnn1" %>
<%@ Register Assembly="DotNetNuke.Web.Deprecated" Namespace="DotNetNuke.Web.UI.WebControls" TagPrefix="dnn2" %>
<%@ Register Assembly="Revindex.Web.UI.WebControls" Namespace="Revindex.Web.UI.WebControls" TagPrefix="rvd1" %>
<%@ Register Src="WebUserControls/Common/Dnn/BackControl.ascx" TagName="BackControl" TagPrefix="uc1" %>
<%@ Register Src="WebUserControls/Common/Dnn/BreadcrumbControl.ascx" TagName="BreadcrumbControl" TagPrefix="uc1" %>
<asp:PlaceHolder ID="PlaceHolder1" runat="server">

	<script type="text/javascript">
		jQuery(document).ready(function () {
			jQuery('#ProductChannelDetailsViewPanel').dnnPanels();
		});
		Sys.WebForms.PageRequestManager.getInstance().add_endRequest(function () {
			jQuery('#ProductChannelDetailsViewPanel').dnnPanels();
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
						<asp:GridView ID="ProductChannelGridView" runat="server" AllowSorting="True" DataKeyNames="ProductChannelID" AutoGenerateColumns="False" CssClass="dnnGrid" GridLines="None" AllowPaging="True" OnRowDeleting="ProductChannelGridView_RowDeleting" OnRowDataBound="ProductChannelGridView_RowDataBound">
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
								<asp:BoundField DataField="ChannelProvider" HeaderText="Provider" SortExpression="ChannelProvider" />
								<asp:BoundField DataField="ExternalID" HeaderText="External ID" SortExpression="ExternalID" />
								<asp:BoundField DataField="ProductVariantID" HeaderText="Variant" SortExpression="ProductVariantID" />
								<asp:BoundField DataField="CreateDate" HeaderText="Date" SortExpression="CreateDate" />
							</Columns>
						</asp:GridView>
						<asp:ObjectDataSource ID="ProductChannelObjectDataSource" runat="server" EnablePaging="True" SelectCountMethod="GetCount" SelectMethod="GetAll" SortParameterName="sortExpression" TypeName="Revindex.Business.Revindex.Revindex.Storefront.ProductChannelController">
							<SelectParameters>
								<asp:Parameter Name="sortExpression" Type="String" />
								<asp:Parameter Name="maximumRows" Type="Int32" />
								<asp:Parameter Name="startRowIndex" Type="Int32" />
								<rvd1:UserControlParameter Name="portalID" PropertyName="PortalId" Type="Int32" />
								<rvd1:UserControlParameter Name="productID" PropertyName="ProductID" Type="Int32" />
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
					<h2>Channel:
						<uc1:BreadcrumbControl ID="BreadcrumbControl" runat="server" />
					</h2>
					<div id="ProductChannelDetailsViewPanel" class="dnnForm">
						<h2 id="GeneralSectionHead" class="dnnFormSectionHead">
							<a href="#" class="dnnSectionExpanded">General</a>
						</h2>
						<fieldset>
							<div class="dnnFormItem">
								<dnn1:LabelControl ID="ProductChannelIDLabelControl" runat="server" Text="Product channel ID:" />
								<asp:Label ID="ProductChannelIDLabel" runat="server"></asp:Label>
							</div>
							<div class="dnnFormItem">
								<dnn1:LabelControl ID="ProductChannelGUIDLabelControl" runat="server" Text="Product channel GUID:" />
								<asp:Label ID="ProductChannelGUIDLabel" runat="server"></asp:Label>
							</div>
							<div class="dnnFormItem">
								<dnn1:LabelControl ID="ExternalIDLabelControl1" runat="server" Text="External ID:" />
								<asp:Label ID="ExternalIDLabel" runat="server"></asp:Label>
							</div>
							<div class="dnnFormItem">
								<dnn1:LabelControl ID="CreateDateLabelControl" runat="server" Text="Create date:" />
								<asp:Label ID="CreateDateLabel" runat="server"></asp:Label>
							</div>
							<div class="dnnFormItem">
								<dnn1:LabelControl ID="ChannelProviderLabelControl" runat="server" Text="Provider:" />
								<asp:DropDownList ID="ChannelProviderDropDownList" runat="server">
									<asp:ListItem Text="eBay Canada" Value="eBayCA" />
									<asp:ListItem Text="eBay U.S" Value="eBayUS" Selected="True"/>
								</asp:DropDownList>
							</div>
							<div class="dnnFormItem">
								<dnn1:LabelControl ID="ListingTypeLabelControl" runat="server" Text="Listing type:" />
								<asp:DropDownList ID="ListingTypeDropDownList" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ListingTypeDropDownList_SelectedIndexChanged">
									<asp:ListItem Text="Auction" Value="2" />
									<asp:ListItem Text="Fixed" Value="1" Selected="true" />
								</asp:DropDownList>
							</div>
							<div class="dnnFormItem">
								<dnn1:LabelControl ID="CategoryLabelControl" runat="server" Text="Categories:" CssClass="dnnFormRequired" HelpText="You must select at least one category and no more than 2 categories. Additional fees may apply for 2nd category." />
								<div style="overflow: scroll; height: 300px">
									<dnn2:DnnTreeView ID="CategoryDnnTreeView" runat="server" OnNodeExpand="CategoryDnnTreeView_NodeExpand" CheckBoxes="true" />
								</div>
							</div>
							<div class="dnnFormItem">
								<dnn1:LabelControl ID="ProductVariantLabelControl" runat="server" Text="Product variant:" HelpText="eBay only allows one variant per product, therefore if you have multiple variants, you must list them separately." />
								<asp:DropDownList ID="ProductVariantDropDownList" runat="server">
								</asp:DropDownList>
							</div>
							<div class="dnnFormItem">
								<dnn1:LabelControl ID="TitleLabelControl" runat="server" Text="Title:" CssClass="dnnFormRequired" />
								<asp:RequiredFieldValidator ID="TitleRequiredFieldValidator" runat="server" ControlToValidate="TitleTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="ProductChannelDetailsViewControl">Title is required.</asp:RequiredFieldValidator>
								<asp:TextBox ID="TitleTextBox" runat="server"></asp:TextBox>
							</div>
							<div class="dnnFormItem">
								<dnn1:LabelControl ID="DescriptionLabelControl" runat="server" Text="Description:" />
								<dnn1:TextEditor ID="DescriptionTextEditor" runat="server" ChooseRender="False" ChooseMode="False" DefaultMode="RICH" HtmlEncode="False" Width="100%" Height="400px" Mode="RICH" />
							</div>
							<div class="dnnFormItem">
								<dnn1:LabelControl ID="QuantityLabelControl1" runat="server" Text="Quantity:" CssClass="dnnFormRequired" />
								<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="QuantityDnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="ProductChannelDetailsViewControl">Quantity is required.</asp:RequiredFieldValidator>
								<dnn2:DnnNumericTextBox ID="QuantityDnnNumericTextBox" runat="server" Skin="" Value="1" NumberFormat-DecimalDigits="0" NumberFormat-GroupSizes="9" EnableSingleInputRendering="False" MinValue="1">
								</dnn2:DnnNumericTextBox>
							</div>
							<div class="dnnFormItem">
								<dnn1:LabelControl ID="PriceLabelControl" runat="server" HelpText="Enter the product price without the money symbol. (e.g. 10.50). This is often known as the buy it now price in auctions." Text="Price:" CssClass="dnnFormRequired"></dnn1:LabelControl>
								<asp:RequiredFieldValidator ID="PriceRequiredFieldValidator" runat="server" ControlToValidate="PriceDnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="ProductChannelDetailsViewControl">Price is required.</asp:RequiredFieldValidator>
								<dnn2:DnnNumericTextBox ID="PriceDnnNumericTextBox" runat="server" Skin="" NumberFormat-DecimalDigits="2" NumberFormat-GroupSizes="9" MinValue="0" EnableSingleInputRendering="False" Value="0.00" CssClass="dnnFormRequired">
								</dnn2:DnnNumericTextBox>
							</div>
							<asp:Panel ID="AuctionPricePanel" runat="server">
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="StartPriceLabelControl" runat="server" HelpText="Enter the auction start price without the money symbol. (e.g. 10.50)" Text="Start price:" CssClass="dnnFormRequired"></dnn1:LabelControl>
									<asp:RequiredFieldValidator ID="StartPriceRequiredFieldValidator" runat="server" ControlToValidate="StartPriceDnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="ProductChannelDetailsViewControl">Start price is required.</asp:RequiredFieldValidator>
									<dnn2:DnnNumericTextBox ID="StartPriceDnnNumericTextBox" runat="server" Skin="" NumberFormat-DecimalDigits="2" NumberFormat-GroupSizes="9" MinValue="0" EnableSingleInputRendering="False" Value="0.00" CssClass="dnnFormRequired">
									</dnn2:DnnNumericTextBox>
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="ReservePriceLabelControl" runat="server" HelpText="Enter the auction reserve price without the money symbol. (e.g. 10.50)" Text="Reserve price:"></dnn1:LabelControl>
									<dnn2:DnnNumericTextBox ID="ReservePriceDnnNumericTextBox" runat="server" Skin="" NumberFormat-DecimalDigits="2" NumberFormat-GroupSizes="9" MinValue="0" EnableSingleInputRendering="False" Value="0.00" CssClass="dnnFormRequired">
									</dnn2:DnnNumericTextBox>
								</div>
							</asp:Panel>
							<div class="dnnFormItem">
								<dnn1:LabelControl ID="ConditionLabelControl" runat="server" Text="Condition:" HelpText="Certain conditions may not be applicable depending on the selected categories." />
								<asp:DropDownList ID="ConditionDropDownList" runat="server">
									<asp:ListItem Text="New" Value="1" Selected="true" />
									<asp:ListItem Text="Refurbished" Value="2" />
									<asp:ListItem Text="Used" Value="3" />
									<asp:ListItem Text="VeryGood" Value="4" />
									<asp:ListItem Text="Good" Value="5" />
									<asp:ListItem Text="Acceptable" Value="6" />
									<asp:ListItem Text="Defective" Value="7" />
								</asp:DropDownList>
							</div>
							<div class="dnnFormItem">
								<dnn1:LabelControl ID="StartDateLabelControl" runat="server" HelpText="Enter a start date (yyyy-mm-dd) to begin displaying product. Leave blank if product is available immediately." Text="Start date:" />
								<dnn2:DnnDateTimePicker ID="StartDateDnnDateTimePicker" runat="server" ShowPopupOnFocus="True" DatePopupButton-Visible="False" DateInput-DateFormat="yyyy-MM-dd HH:mm" DateInput-EmptyMessage="YYYY-MM-DD HH:mm" CssClass="rvdDateTimeInput">
								</dnn2:DnnDateTimePicker>
							</div>
							<div class="dnnFormItem">
								<dnn1:LabelControl ID="StopDateLabelControl" runat="server" HelpText="Enter a stop date (yyyy-mm-dd) to end displaying product. Leave blank if product is available perpetually. eBay requires the duration calculated from the listing date or the start date, if provided, to be intervals of 1, 3, 5, 7, 10, 14, 21, 30, 60, 90 or 120 days." Text="Stop date:" />
								<dnn2:DnnDateTimePicker ID="StopDateDnnDateTimePicker" runat="server" ShowPopupOnFocus="True" DatePopupButton-Visible="False" DateInput-DateFormat="yyyy-MM-dd HH:mm" DateInput-EmptyMessage="YYYY-MM-DD HH:mm" CssClass="rvdDateTimeInput">
								</dnn2:DnnDateTimePicker>
							</div>
						</fieldset>
						<h2 id="ShippingSectionHead" class="dnnFormSectionHead">
							<a href="#" class="dnnSectionExpanded">Shipping</a>
						</h2>
						<fieldset>
							<p>For eBay, all domestic or international shipping services must use the same rate type (either calculated or flat, but not mixed). You must also provide at least one domestic shipping service.</p>
							<asp:GridView ID="ShippingGridView" runat="server" AllowSorting="True" DataKeyNames="ShippingMethodID" AutoGenerateColumns="False" CssClass="dnnGrid" GridLines="None" AllowPaging="True" OnSelectedIndexChanged="ShippingGridView_SelectedIndexChanged" OnRowDeleting="ShippingGridView_RowDeleting">
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
											<asp:LinkButton ID="DeleteLinkButton" runat="server" CommandName="Delete" CausesValidation="false" OnClientClick="return confirm('Are you sure you want to delete this item?')" CssClass="rvdDeleteGridAction"></asp:LinkButton>
										</ItemTemplate>
									</asp:TemplateField>
									<asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
									<asp:BoundField DataField="ServiceType" HeaderText="Service type" SortExpression="ServiceType" />
									<asp:BoundField DataField="Rate" HeaderText="Rate" SortExpression="Rate" />
								</Columns>
							</asp:GridView>
							<div class="rvdActions">
								<asp:LinkButton ID="AddShippingLinkButton" runat="server" Text="Add new" OnClick="AddShippingLinkButton_Click" CssClass="dnnPrimaryAction rvdAddNewAction" CausesValidation="false" />
							</div>
							<asp:Panel ID="ShippingDetailsViewPanel" runat="server">
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="ShippingNameLabelControl" runat="server" Text="Name:" />
									<asp:DropDownList ID="ShippingNameDropDownList" runat="server" OnSelectedIndexChanged="ShippingNameDropDownList_SelectedIndexChanged" AutoPostBack="True"></asp:DropDownList>
								</div>
								<asp:Panel ID="ShippingRatePanel" runat="server" CssClass="dnnFormItem">
									<dnn1:LabelControl ID="ShippingRateLabelControl" runat="server" Text="Rate:" HelpText="For flat rate shipping, enter a fixed rate (e.g. 10.00). Leave value blank for calculated rate." CssClass="dnnFormRequired" />
									<asp:RequiredFieldValidator ID="ShippingRateRequiredFieldValidator" runat="server" ControlToValidate="ShippingRateDnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="ProductChannelDetailsViewControl">Rate is required.</asp:RequiredFieldValidator>
									<dnn2:DnnNumericTextBox ID="ShippingRateDnnNumericTextBox" runat="server" Skin="" NumberFormat-DecimalDigits="4" NumberFormat-GroupSizes="9" MinValue="0" EnableSingleInputRendering="False" Value="0.00">
									</dnn2:DnnNumericTextBox>
								</asp:Panel>
								<asp:Panel ID="ShippingRegionPanel" runat="server" CssClass="dnnFormItem">
									<dnn1:LabelControl ID="ShippingRegionLabelControl" runat="server" Text="Allowed regions:" HelpText="You must specify at least one region that this service ships to." CssClass="dnnFormRequired" />
									<asp:CheckBoxList ID="ShippingRegionCheckBoxList" runat="server" RepeatLayout="Flow">
										<asp:ListItem Text="Worldwide" Value="Worldwide" />
										<asp:ListItem Text="Africa" Value="Africa" />
										<asp:ListItem Text="Americas" Value="Americas" />
										<asp:ListItem Text="Asia" Value="Asia" />
										<asp:ListItem Text="Europe" Value="Europe" />
										<asp:ListItem Text="Middle East" Value="MiddleEast" />
										<asp:ListItem Text="North America" Value="NorthAmerica" />
										<asp:ListItem Text="Oceania" Value="Oceania" />
										<asp:ListItem Text="South America" Value="SouthAmerica" />
										<asp:ListItem Text="Australia" Value="AU" />
										<asp:ListItem Text="Canada" Value="CA" />
										<asp:ListItem Text="France" Value="FR" />
										<asp:ListItem Text="Germany" Value="DE" />
										<asp:ListItem Text="Italy" Value="IT" />
										<asp:ListItem Text="Japan" Value="JP" />
										<asp:ListItem Text="Spain" Value="ES" />
										<asp:ListItem Text="United Kingdom" Value="GB" />
										<asp:ListItem Text="United States" Value="US" />
									</asp:CheckBoxList>
								</asp:Panel>
								<ul class="dnnActions">
									<li>
										<asp:LinkButton ID="SaveShippingLinkButton" runat="server" Text="OK" CssClass="dnnPrimaryAction rvdOKAction" OnClick="SaveShippingLinkButton_Click"></asp:LinkButton></li>
									<li>
										<asp:LinkButton ID="CancelShippingLinkButton" runat="server" Text="Cancel" CssClass="dnnSecondaryAction rvdCancelAction" OnClick="CancelShippingLinkButton_Click"></asp:LinkButton></li>
								</ul>
							</asp:Panel>
						</fieldset>
						<h2 id="PaymentSectionHead" class="dnnFormSectionHead">
							<a href="#" class="dnnSectionExpanded">Payment</a>
						</h2>
						<fieldset>
							<div class="dnnFormItem">
								<dnn1:LabelControl ID="PaymentMethodLabelControl" runat="server" Text="Payment methods:" CssClass="dnnFormRequired" HelpText="You must select at least one payment method."/>
								<asp:CheckBoxList ID="PaymentMethodCheckBoxList" runat="server" RepeatLayout="Flow">
									<asp:ListItem Text="Amex" Value="AmEx" Selected="true"/>
									<asp:ListItem Text="Check" Value="PersonalCheck" />
									<asp:ListItem Text="Discover" Value="Discover" Selected="True"/>
									<asp:ListItem Text="PayPal" Value="PayPal" Selected="True"/>
									<asp:ListItem Text="Visa/MasterCard" Value="VisaMC" Selected="True" />
								</asp:CheckBoxList>
							</div>							
						</fieldset>
						<h2 id="ReturnSectionHead" class="dnnFormSectionHead">
							<a href="#" class="dnnSectionExpanded">Return</a>
						</h2>
						<fieldset>
							<div class="dnnFormItem">
								<dnn1:LabelControl ID="AllowCreditLabelControl" runat="server" Text="Allow store credit:" HelpText="Determine how the customer will be compensated if you accept returns." />
								<asp:CheckBox ID="AllowCreditCheckBox" runat="server" />
							</div>
							<div class="dnnFormItem">
								<dnn1:LabelControl ID="AllowExchangeLabelControl" runat="server" Text="Allow exchange:" HelpText="Determine how the customer will be compensated if you accept returns." />
								<asp:CheckBox ID="AllowExchangeCheckBox" runat="server" />
							</div>
							<div class="dnnFormItem">
								<dnn1:LabelControl ID="AllowRefundLabelControl" runat="server" Text="Allow refund:" HelpText="Determine how the customer will be compensated if you accept returns." />
								<asp:CheckBox ID="AllowRefundCheckBox" runat="server" />
							</div>
							<div class="dnnFormItem">
								<dnn1:LabelControl ID="ReturnPeriodLabelControl" runat="server" Text="Return period:" />
								<asp:DropDownList ID="ReturnPeriodDropDownList" runat="server">
									<asp:ListItem Text="14 days" Value="14" />
									<asp:ListItem Text="30 days" Value="30" Selected="True" />
									<asp:ListItem Text="60 days" Value="60" />
								</asp:DropDownList>
							</div>
							<div class="dnnFormItem">
								<dnn1:LabelControl ID="ReturnDescriptionLabelControl" runat="server" Text="Return description:" />
								<asp:TextBox ID="ReturnDescriptionTextBox" runat="server" TextMode="MultiLine" Rows="4"></asp:TextBox>
							</div>
						</fieldset>
					</div>
					<div class="dnnForm">
						<ul class="dnnActions">
							<li>
								<asp:LinkButton ID="SaveLinkButton" runat="server" CssClass="dnnPrimaryAction rvdSaveAction" OnClick="SaveLinkButton_Click" Text="Save" ValidationGroup="ProductChannelDetailsViewControl" />
							</li>
							<li>
								<asp:LinkButton ID="SaveAndBackLinkButton" runat="server" CommandArgument="Back" CssClass="dnnPrimaryAction rvdSaveAction" OnClick="SaveLinkButton_Click" Text="Save &amp; return" ValidationGroup="ProductChannelDetailsViewControl" />
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
