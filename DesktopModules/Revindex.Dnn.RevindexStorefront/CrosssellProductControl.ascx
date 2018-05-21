<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="CrosssellProductControl.ascx.cs" Inherits="Revindex.Dnn.RevindexStorefront.CrosssellProductControl" %>
<%@ Register Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Src="~/Controls/labelcontrol.ascx" TagName="LabelControl" TagPrefix="dnn1" %>
<%@ Register Assembly="DotNetNuke.Web.Deprecated" Namespace="DotNetNuke.Web.UI.WebControls" TagPrefix="dnn2" %>
<%@ Register Src="CrosssellProductAvailabilityRuleControl.ascx" TagName="CrosssellProductAvailabilityRuleControl" TagPrefix="uc1" %>
<%@ Register Src="WebUserControls/Common/Dnn/BackControl.ascx" TagName="BackControl" TagPrefix="uc1" %>
<%@ Register Src="WebUserControls/BaseEditorControl.ascx" TagName="BaseEditorControl" TagPrefix="uc1" %>
<%@ Register Src="WebUserControls/Common/Dnn/BreadcrumbControl.ascx" TagName="BreadcrumbControl" TagPrefix="uc1" %>
<uc1:BaseEditorControl ID="BaseEditorControl1" runat="server" />
<asp:PlaceHolder ID="PlaceHolder1" runat="server">

	<script type="text/javascript">
	    jQuery(document).ready(function ()
	    {
	        jQuery('#CrossellProductDetailsViewTabPanel').dnnTabs();
	    });
	    Sys.WebForms.PageRequestManager.getInstance().add_endRequest(function ()
	    {
	        jQuery('#CrossellProductDetailsViewTabPanel').dnnTabs();
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
                        <asp:GridView ID="CrosssellProductGridView" runat="server" AllowSorting="False" AutoGenerateColumns="False" DataKeyNames="CrosssellProductID" CssClass="dnnGrid" GridLines="None" AllowPaging="False" OnRowDataBound="CrosssellProductGridView_RowDataBound" OnRowDeleting="CrosssellProductGridView_RowDeleting">
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
                                <asp:BoundField DataField="ProductName" HeaderText="Product" SortExpression="ProductName" />
                                <asp:CheckBoxField DataField="Active" HeaderText="Active" SortExpression="Active" />
                                <asp:BoundField DataField="StartDate" HeaderText="Start date" SortExpression="StartDate" />
                                <asp:BoundField DataField="StopDate" HeaderText="Stop date" SortExpression="StopDate"  />
                            </Columns>
                        </asp:GridView>
                        <ul class="dnnActions dnnClear">
                            <li>
                                <asp:HyperLink ID="AddHyperLink" runat="server" Text="Add new" CssClass="dnnPrimaryAction rvdAddNewAction" />
                            </li>
                        </ul>
                    </div>
                </asp:View>
                <asp:View ID="DetailsView" runat="server">
                    <uc1:BackControl ID="QuickBackControl" runat="server" Text="" CssClass="rvdsfBackAction"/>
                    <h2>Cross-sell product: <uc1:BreadcrumbControl ID="BreadcrumbControl" runat="server" /></h2>
                    <div id="CrossellProductDetailsViewTabPanel" class="dnnForm">
                        <ul class="dnnAdminTabNav dnnClear">
                            <li><a href="#<%= GeneralDetailsViewPanel.ClientID %>">
                                <asp:Label ID="GeneralDetailsViewTabLabel" runat="server" Text="General" /></a></li>
                            <li><a href="#<%= AvailabilityDetailsViewPanel.ClientID %>">
                                <asp:Label ID="AvailabilityDetailsViewTabLabel" runat="server" Text="Availability" /></a></li>
                        </ul>
                        <asp:Panel ID="GeneralDetailsViewPanel" runat="server" CssClass="dnnClear">
                            <fieldset>
                                <div class="dnnFormItem">
                                    <dnn1:LabelControl ID="CrosssellProductIDLabelControl" runat="server" Text="Cross-sell product ID:" />
                                    <asp:Label ID="CrosssellProductIDLabel" runat="server"></asp:Label>
                                </div>
                                <div class="dnnFormItem">
                                    <dnn1:LabelControl ID="OfferProductLabelControl" runat="server" Text="Offer product:" CssClass="dnnFormRequired" />
                                    <asp:RequiredFieldValidator ID="OfferProductRequiredFieldValidator" runat="server" ControlToValidate="OfferProductDnnComboBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="CrosssellProductDetailsViewControl" InitialValue="">Offer product is required.</asp:RequiredFieldValidator>
                                    <dnn2:DnnComboBox ID="OfferProductDnnComboBox" runat="server" AllowCustomText="True" CssClass="dnnFormRequired" EnableLoadOnDemand="True" OnItemsRequested="OfferProductDnnComboBox_ItemsRequested" AutoPostBack="False" CausesValidation="False" MaxHeight="200px">
                                    </dnn2:DnnComboBox>
									<asp:LinkButton ID="OfferProductLinkButton" runat="server" CssClass="rvdLinkAction" Text="Edit" OnClick="OfferProductLinkButton_Click" CausesValidation="False" />
                                </div>
                                <div class="dnnFormItem">
                                    <dnn1:LabelControl ID="DisplayOrderLabelControl" runat="server" HelpText="Sort the item for display by lowest to highest number starting from zero." Text="Display order:" CssClass="dnnFormRequired" />
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="DisplayOrderDnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="CrosssellProductDetailsViewControl">Display order is required.</asp:RequiredFieldValidator>
                                    <dnn2:DnnNumericTextBox ID="DisplayOrderDnnNumericTextBox" runat="server" Skin="" Value="1000" NumberFormat-DecimalDigits="0" NumberFormat-GroupSizes="9" EnableSingleInputRendering="False" CssClass="dnnFormRequired">
                                    </dnn2:DnnNumericTextBox>
                                </div>
                                <div class="dnnFormItem">
                                    <dnn1:LabelControl ID="ActiveLabelControl" runat="server" Text="Active:" HelpText="Enable or disable the cross-sell product." />
                                    <asp:CheckBox ID="ActiveCheckBox" runat="server" />
                                </div>
                                <div class="dnnFormItem">
                                    <dnn1:LabelControl ID="StartDateLabelControl" runat="server" HelpText="Enter a start date (yyyy-mm-dd) to begin cross-selling this product. Leave blank if cross-sell product is available immediately." Text="Start date:" />
                                    <dnn2:DnnDateTimePicker ID="StartDateDnnDateTimePicker" runat="server" ShowPopupOnFocus="True" DatePopupButton-Visible="False" DateInput-DateFormat="yyyy-MM-dd HH:mm" DateInput-EmptyMessage="YYYY-MM-DD HH:mm" CssClass="rvdDateTimeInput">
                                    </dnn2:DnnDateTimePicker>
                                </div>
                                <div class="dnnFormItem">
                                    <dnn1:LabelControl ID="StopDateLabelControl" runat="server" EnableViewState="False" HelpText="Enter a stop date (yyyy-mm-dd) to end cross-selling this product. Leave blank if cross-sell product is available perpetually." Text="Stop date:" />
                                    <dnn2:DnnDateTimePicker ID="StopDateDnnDateTimePicker" runat="server" ShowPopupOnFocus="True" DatePopupButton-Visible="False" DateInput-DateFormat="yyyy-MM-dd HH:mm" DateInput-EmptyMessage="YYYY-MM-DD HH:mm" CssClass="rvdDateTimeInput">
                                    </dnn2:DnnDateTimePicker>
                                </div>
                                <div class="dnnFormItem">
                                    <dnn1:LabelControl ID="TitleLabelControl" runat="server" Text="Title:" HelpText="This is the offer title to grab the customer's attention. Use phrases like &quot;Don't forget batteries!&quot;" />
                                    <asp:TextBox ID="TitleTextBox" runat="server"></asp:TextBox>
                                </div>
                                <div class="dnnFormItem">
                                    <dnn1:LabelControl ID="DescriptionLabelControl" runat="server" Text="Description:" HelpText="Use this field to provide a catchy explanation why this product is being offered. E.g. &quot;Because you're spending over $100, we would like to offer you this product at a fantastic discount&quot;" />
                                    <asp:TextBox ID="DescriptionTextBox" runat="server" Rows="8" TextMode="MultiLine" MaxLength="4000"></asp:TextBox>
                                </div>
                            </fieldset>
                        </asp:Panel>
                        <asp:Panel ID="AvailabilityDetailsViewPanel" runat="server" CssClass="dnnClear">
                            <fieldset>
                                <uc1:CrosssellProductAvailabilityRuleControl ID="CrosssellProductAvailabilityRuleControl" runat="server" Width="100%" />
                            </fieldset>
                        </asp:Panel>
                    </div>
                    <div class="dnnForm">
                        <ul class="dnnActions">
                            <li>
                                <asp:LinkButton ID="SaveLinkButton" runat="server" Text="Save" OnClick="SaveLinkButton_Click" ValidationGroup="CrosssellProductDetailsViewControl" CssClass="dnnPrimaryAction rvdSaveAction" />
                            </li>
                            <li>
			                    <asp:LinkButton ID="SaveAndBackLinkButton" runat="server" Text="Save & return" OnClick="SaveLinkButton_Click" CommandArgument="Back" CssClass="dnnPrimaryAction rvdSaveAction" ValidationGroup="CrosssellProductDetailsViewControl" />
		                    </li>
                            <li>
                                <uc1:BackControl ID="BackControl1" runat="server" Text="Cancel"/>
                            </li>

                        </ul>
                    </div>
                </asp:View>
            </asp:MultiView>
        </ContentTemplate>
    </asp:UpdatePanel>
</div>