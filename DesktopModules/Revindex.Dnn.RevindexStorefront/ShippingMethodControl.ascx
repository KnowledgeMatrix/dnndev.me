<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ShippingMethodControl.ascx.cs" Inherits="Revindex.Dnn.RevindexStorefront.ShippingMethodControl" %>
<%@ Register Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Src="~/Controls/labelcontrol.ascx" TagName="LabelControl" TagPrefix="dnn1" %>
<%@ Register Assembly="DotNetNuke.Web.Deprecated" Namespace="DotNetNuke.Web.UI.WebControls" TagPrefix="dnn2" %>
<%@ Register Assembly="Revindex.Web.UI.WebControls" Namespace="Revindex.Web.UI.WebControls" TagPrefix="rvd1" %>
<%@ Register Src="TaxClassDropDownListControl.ascx" TagName="TaxClassDropDownListControl" TagPrefix="uc1" %>
<%@ Register Src="ShippingMethodRateRuleControl.ascx" TagName="ShippingMethodRateRuleControl" TagPrefix="uc1" %>
<%@ Register Src="ShippingMethodSurchargeRuleControl.ascx" TagName="ShippingMethodSurchargeRuleControl" TagPrefix="uc1" %>
<%@ Register Src="ShippingMethodAvailabilityRuleControl.ascx" TagName="ShippingMethodAvailabilityRuleControl" TagPrefix="uc1" %>
<%@ Register Src="WebUserControls/BaseEditorControl.ascx" TagName="BaseEditorControl" TagPrefix="uc1" %>
<%@ Register Src="WebUserControls/Common/Dnn/BackControl.ascx" TagName="BackControl" TagPrefix="uc1" %>
<%@ Register Src="WebUserControls/Common/Dnn/BreadcrumbControl.ascx" TagName="BreadcrumbControl" TagPrefix="uc1" %>
<uc1:BaseEditorControl ID="BaseEditorControl1" runat="server" />
<asp:PlaceHolder runat="server">

	<script type="text/javascript">
		jQuery(document).ready(function()
		{
		    jQuery('#ShippingMethodDetailsViewTabPanel').dnnTabs();
		    jQuery('#<%= SearchPanel.ClientID %>').dnnPanels();
		});
		Sys.WebForms.PageRequestManager.getInstance().add_endRequest(function()
		{
		    jQuery('#ShippingMethodDetailsViewTabPanel').dnnTabs();
		    jQuery('#<%= SearchPanel.ClientID %>').dnnPanels();
		});
	</script>

</asp:PlaceHolder>
<div>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
	    <ContentTemplate>
            <asp:PlaceHolder ID="MessagePlaceHolder" runat="server" />
            <asp:MultiView ID="ContentMultiView" runat="server">
                <asp:View ID="ListView" runat="server">
                    <h2>Shipping methods</h2>
					<p>Tell us what shipping services you like to offer during checkout. Make sure to enter the shipping credentials if you're using a 3rd party shipping provider. Only product variants marked as require shipping will be subjected to shipping charges.</p>
                    <asp:Panel ID="SearchPanel" runat="server" CssClass="dnnForm rvdsfSearchContainer">
	                    <fieldset>
                            <div class="dnnFormItem">
				                <dnn1:LabelControl runat="server" ID="SellerSearchLabelControl" Text="Seller:" HelpText="View items belonging to a specific seller."></dnn1:LabelControl>
				                <dnn2:DnnComboBox ID="SellerSearchDnnComboBox" runat="server" AllowCustomText="True" EnableLoadOnDemand="True" OnItemsRequested="SellerSearchDnnComboBox_ItemsRequested" AutoPostBack="True" CausesValidation="False" MaxHeight="200px" OnSelectedIndexChanged="SellerSearchDnnComboBox_SelectedIndexChanged"></dnn2:DnnComboBox>
			                </div>
                        </fieldset>
		            </asp:Panel>
                    <div class="dnnForm rvdsfListContainer">
			            <asp:GridView ID="ShippingMethodGridView" runat="server" CssClass="dnnGrid" GridLines="None" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="ShippingMethodID" OnRowDeleting="ShippingMethodGridView_RowDeleting" OnRowDataBound="ShippingMethodGridView_RowDataBound">
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
					            <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
					            <asp:BoundField DataField="UniversalServiceName" HeaderText="Type" SortExpression="UniversalServiceName" />
				            </Columns>
			            </asp:GridView>
			            <asp:ObjectDataSource ID="ShippingMethodObjectDataSource" runat="server" EnablePaging="True" SelectCountMethod="GetCount" SelectMethod="GetAll" SortParameterName="sortExpression" TypeName="Revindex.Business.Revindex.Revindex.Storefront.ShippingMethodController">
				            <SelectParameters>
					            <asp:Parameter Name="sortExpression" Type="String" />
					            <asp:Parameter Name="maximumRows" Type="Int32" />
					            <asp:Parameter Name="startRowIndex" Type="Int32" />
								<asp:Parameter Name="deleted" Type="Boolean" DefaultValue="false"></asp:Parameter>
					            <rvd1:UserControlParameter Name="portalID" PropertyName="PortalId" Type="Int32" />
                                <asp:ControlParameter ControlID="SellerSearchDnnComboBox" Name="sellerID" PropertyName="SelectedValue" Type="Int32" />
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
                    <uc1:BackControl ID="QuickBackControl" runat="server" Text="" CssClass="rvdsfBackAction"/>
                    <h2>Shipping method: <uc1:BreadcrumbControl ID="BreadcrumbControl" runat="server" /></h2>
			        <div id="ShippingMethodDetailsViewTabPanel" class="dnnForm">
				        <ul class="dnnAdminTabNav dnnClear">
					        <li><a href="#<%= GeneralDetailsViewPanel.ClientID %>">
						        <asp:Label ID="GeneralDetailsViewTabLabel" runat="server" Text="General" /></a></li>
					        <li><a href="#<%= AvailabilityDetailsViewPanel.ClientID %>">
						        <asp:Label ID="AvailabilityDetailsViewTabLabel" runat="server" Text="Availability" /></a></li>
					        <li><a href="#<%= RateDetailsViewPanel.ClientID %>">
						        <asp:Label ID="RateDetailsViewTabLabel" runat="server" Text="Rate" /></a></li>
					        <li><a href="#<%= SurchargeDetailsViewPanel.ClientID %>">
						        <asp:Label ID="SurchargeDetailsViewTabLabel" runat="server" Text="Surcharge" /></a></li>
				        </ul>
				        <asp:Panel ID="GeneralDetailsViewPanel" runat="server" CssClass="dnnClear">
					        <fieldset>
						        <div class="dnnFormItem">
							        <dnn1:LabelControl ID="ShippingMethodIDLabelControl" runat="server" Text="Shipping method ID:" />
							        <asp:Label ID="ShippingMethodIDLabel" runat="server"></asp:Label>
						        </div>
                                <asp:Panel ID="SellerPanel" runat="server" CssClass="dnnFormItem">
							        <dnn1:LabelControl ID="SellerLabelControl" runat="server" HelpText="Enter the name if this item belongs to a seller." Text="Seller:" />
							        <dnn2:DnnComboBox ID="SellerDnnComboBox" runat="server" AllowCustomText="True" EnableLoadOnDemand="True" OnItemsRequested="SellerDnnComboBox_ItemsRequested" AutoPostBack="True" CausesValidation="False" MaxHeight="200px" OnSelectedIndexChanged="SellerDnnComboBox_SelectedIndexChanged"></dnn2:DnnComboBox>
						        </asp:Panel>
								<div class="dnnFormItem">
							        <dnn1:LabelControl ID="ShippingMethodTypeLabelControl" runat="server" Text="Type:" HelpText="Provide your custom shipping rate calculation or choose from the available integrated carrier services (real-time shipping calculation)." />
							        <asp:DropDownList ID="UniversalServiceNameDropDownList" runat="server" AutoPostBack="True" OnSelectedIndexChanged="UniversalServiceNameDropDownList_SelectedIndexChanged">
							        </asp:DropDownList>
									<asp:HyperLink ID="ShippingProviderHyperLink" runat="server" CssClass="rvdLinkAction" Text="Edit"></asp:HyperLink>
						        </div>
						        <div class="dnnFormItem">
							        <dnn1:LabelControl ID="NameLabelControl" runat="server" HelpText="Provide a name for this shipping method (e.g. &quot;Ground shipping&quot;)" Text="Name:" CssClass="dnnFormRequired" />
							        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="NameTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="ShippingMethodDetailsViewControl">Name is required.</asp:RequiredFieldValidator>
							        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="NameTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationExpression="[^;|\[\]&lt;&gt;{}^\\]+" ValidationGroup="ShippingMethodDetailsViewControl">Name is invalid.</asp:RegularExpressionValidator>
							        <asp:TextBox ID="NameTextBox" runat="server" MaxLength="100" CssClass="dnnFormRequired"></asp:TextBox>
						        </div>
						        <div class="dnnFormItem">
							        <dnn1:LabelControl ID="TaxClassLabelControl" runat="server" Text="Tax class:" HelpText="If this shipping  method is taxable, select the appropriate tax class." />
							        <uc1:TaxClassDropDownListControl ID="TaxClassDropDownList" runat="server" />
						        </div>
						        <div class="dnnFormItem">
							        <dnn1:LabelControl ID="DisplayOrderLabelControl" runat="server" Text="Display order:" HelpText="Sort the item for display by lowest to highest number starting from zero." CssClass="dnnFormRequired" />
							        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="DisplayOrderTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="ShippingMethodDetailsViewControl">Display order is required.</asp:RequiredFieldValidator>
							        <asp:RangeValidator ID="RangeValidator1" runat="server" ControlToValidate="DisplayOrderTextBox" Display="Dynamic" MaximumValue="99999" MinimumValue="0" Type="Integer" ValidationGroup="ShippingMethodDetailsViewControl">Display order is invalid.</asp:RangeValidator>
							        <asp:TextBox ID="DisplayOrderTextBox" runat="server" Columns="5" MaxLength="5" CssClass="dnnFormRequired">1000</asp:TextBox>
						        </div>
					        </fieldset>
				        </asp:Panel>
				        <asp:Panel ID="AvailabilityDetailsViewPanel" runat="server" CssClass="dnnClear">
					        <fieldset>
						        <uc1:ShippingMethodAvailabilityRuleControl ID="ShippingMethodAvailabilityRuleControl" runat="server" Width="100%" />
					        </fieldset>
				        </asp:Panel>
				        <asp:Panel ID="RateDetailsViewPanel" runat="server" CssClass="dnnClear">
					        <fieldset>
						        <uc1:ShippingMethodRateRuleControl ID="ShippingMethodRateRuleControl" runat="server" Width="100%" />
						        <asp:Label ID="IntegratedShippingRuleLabel" runat="server" Text="This shipping method uses the integrated shipping rule." CssClass="dnnFormMessage dnnFormInfo"></asp:Label>
					        </fieldset>
				        </asp:Panel>
				        <asp:Panel ID="SurchargeDetailsViewPanel" runat="server" CssClass="dnnClear">
					        <fieldset>
						        <uc1:ShippingMethodSurchargeRuleControl ID="ShippingMethodSurchargeRuleControl" runat="server" Width="100%" />
					        </fieldset>
				        </asp:Panel>
			        </div>
			        <div class="dnnForm">
				        <ul class="dnnActions">
					        <li>
						        <asp:LinkButton ID="SaveLinkButton" runat="server" Text="Save" OnClick="SaveLinkButton_Click" CssClass="dnnPrimaryAction rvdSaveAction" ValidationGroup="ShippingMethodDetailsViewControl" />
					        </li>
                            <li>
			                    <asp:LinkButton ID="SaveAndBackLinkButton" runat="server" Text="Save & return" OnClick="SaveLinkButton_Click" CommandArgument="Back" CssClass="dnnPrimaryAction rvdSaveAction" ValidationGroup="ShippingMethodDetailsViewControl" />
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
