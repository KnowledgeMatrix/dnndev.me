<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="CustomerControl.ascx.cs" Inherits="Revindex.Dnn.RevindexStorefront.CustomerControl" %>
<%@ Register Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Src="~/Controls/labelcontrol.ascx" TagName="LabelControl" TagPrefix="dnn1" %>
<%@ Register Assembly="DotNetNuke.Web.Deprecated" Namespace="DotNetNuke.Web.UI.WebControls" TagPrefix="dnn2" %>
<%@ Register Src="UserPaymentControl.ascx" TagName="UserPaymentControl" TagPrefix="uc1" %>
<%@ Register Src="WebUserControls/Common/Dnn/BackControl.ascx" TagName="BackControl" TagPrefix="uc1" %>
<%@ Register Src="WebUserControls/Common/Dnn/BreadcrumbControl.ascx" TagName="BreadcrumbControl" TagPrefix="uc1" %>
<asp:PlaceHolder runat="server">

    <script type="text/javascript">
        jQuery(document).ready(function ()
        {
            jQuery('#CustomerDetailsViewTabPanel').dnnTabs();
            jQuery('#<%= SearchPanel.ClientID %>').dnnPanels();
		});
		Sys.WebForms.PageRequestManager.getInstance().add_endRequest(function ()
		{
		    jQuery('#CustomerDetailsViewTabPanel').dnnTabs();
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
                    <h2>Customers</h2>
                    <asp:Panel ID="SearchPanel" runat="server" DefaultButton="SearchLinkButton" CssClass="dnnForm rvdsfSearchContainer">
                        <h2 id="SearchFormSectionHead" class="dnnFormSectionHead">
		                    <a href="#" class="dnnSectionExpanded">Search</a></h2>
	                    <fieldset>
			                <div class="dnnFormItem">
				                <dnn1:LabelControl runat="server" ID="UsernameSearchLabelControl" Text="Username:" HelpText="Enter username to search."></dnn1:LabelControl>
				                <asp:TextBox ID="UsernameSearchTextBox" runat="server"></asp:TextBox>
			                </div>
			                <div class="rvdActions">
				                <asp:LinkButton ID="SearchLinkButton" runat="server" Text="Search" OnClick="SearchLinkButton_Click" CausesValidation="false" CssClass="dnnPrimaryAction rvdSearchAction" />
			                </div>
                        </fieldset>
		            </asp:Panel>
		            <div class="dnnForm rvdsfListContainer">
			            <asp:GridView ID="CustomerGridView" runat="server" CssClass="dnnGrid" GridLines="None" AllowPaging="True" AllowSorting="False" AutoGenerateColumns="False" DataKeyNames="UserID" OnPageIndexChanging="CustomerGridView_PageIndexChanging" OnRowDataBound="CustomerGridView_RowDataBound">
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
					            <asp:BoundField DataField="Username" HeaderText="Username" />
					            <asp:BoundField DataField="FirstName" HeaderText="First name" />
					            <asp:BoundField DataField="LastName" HeaderText="Last name" />
					            <asp:BoundField DataField="Email" HeaderText="Email" />
				            </Columns>
			            </asp:GridView>
			            <ul class="dnnActions dnnClear">
				            <li>
				            <asp:HyperLink ID="AddHyperLink" runat="server" Text="Add new" CssClass="dnnPrimaryAction rvdAddNewAction"></asp:HyperLink>
			            </li>
			            </ul>
		            </div>
                </asp:View>
                <asp:View ID="DetailsView" runat="server">
                    <uc1:BackControl ID="QuickBackControl" runat="server" Text="" CssClass="rvdsfBackAction"/>
                    <h2>Customer: <uc1:BreadcrumbControl ID="BreadcrumbControl" runat="server" /></h2>
		            <div id="CustomerDetailsViewTabPanel" class="dnnForm">
			            <ul class="dnnAdminTabNav dnnClear">
				            <li><a href="#<%= GeneralDetailsViewPanel.ClientID %>">
					            <asp:Label ID="GeneralDetailsViewTabLabel" runat="server" Text="General" /></a></li>
				            <li><a href="#<%= TaxesDetailsViewPanel.ClientID %>">
					            <asp:Label ID="TaxesDetailsViewTabLabel" runat="server" Text="Taxes" /></a></li>
				            <li><a href="#<%= UserPaymentDetailsViewPanel.ClientID %>">
					            <asp:Label ID="UserPaymentDetailsViewTabLabel" runat="server" Text="User payment" /></a></li>
				            <li><a href="#<%= NotesDetailsViewPanel.ClientID %>">
					            <asp:Label ID="NotesDetailsViewTabLabel" runat="server" Text="Notes" /></a></li>
			            </ul>
			            <asp:Panel ID="GeneralDetailsViewPanel" runat="server" CssClass="dnnClear">
				            <fieldset>
					            <div class="dnnFormItem">
						            <dnn1:LabelControl ID="CustomerIDLabelControl" runat="server" Text="Customer ID:" />
						            <asp:Label runat="server" ID="CustomerIDLabel"></asp:Label>
					            </div>
					            <div class="dnnFormItem">
						            <dnn1:LabelControl ID="UserIDLabelControl" runat="server" Text="User ID:"></dnn1:LabelControl>
						            <asp:Label runat="server" ID="UserIDLabel"></asp:Label>
					            </div>
					            <div class="dnnFormItem">
						            <dnn1:LabelControl ID="UsernameLabelControl1" runat="server" Text="Username:"></dnn1:LabelControl>
						            <asp:Label runat="server" ID="UsernameLabel"></asp:Label>
					            </div>
                                <asp:Panel ID="SellerPanel" runat="server" CssClass="dnnFormItem">
				                    <dnn1:LabelControl ID="SellerLabelControl" runat="server" HelpText="Enter the name if this item belongs to a seller." Text="Seller:" />
				                    <dnn2:DnnComboBox ID="SellerDnnComboBox" runat="server" AllowCustomText="True" EnableLoadOnDemand="True" OnItemsRequested="SellerDnnComboBox_ItemsRequested" AutoPostBack="True" CausesValidation="False" MaxHeight="200px"></dnn2:DnnComboBox>
			                    </asp:Panel>
					            <div class="dnnFormItem">
						            <dnn1:LabelControl ID="FirstNameLabelControl" runat="server" Text="First name:"></dnn1:LabelControl>
						            <asp:Label runat="server" ID="FirstNameLabel"></asp:Label>
					            </div>
					            <div class="dnnFormItem">
						            <dnn1:LabelControl ID="LastNameLabelControl" runat="server" Text="Last name:"></dnn1:LabelControl>
						            <asp:Label runat="server" ID="LastNameLabel"></asp:Label>
					            </div>
					            <div class="dnnFormItem">
						            <dnn1:LabelControl ID="UnitLabelControl" runat="server" Text="Unit:"></dnn1:LabelControl>
						            <asp:Label runat="server" ID="UnitLabel"></asp:Label>
					            </div>
					            <div class="dnnFormItem">
						            <dnn1:LabelControl ID="StreetLabelControl" runat="server" Text="Street:"></dnn1:LabelControl>
						            <asp:Label runat="server" ID="StreetLabel"></asp:Label>
					            </div>
					            <div class="dnnFormItem">
						            <dnn1:LabelControl ID="CityLabelControl" runat="server" Text="City:"></dnn1:LabelControl>
						            <asp:Label runat="server" ID="CityLabel"></asp:Label>
					            </div>
					            <div class="dnnFormItem">
						            <dnn1:LabelControl ID="RegionLabelControl" runat="server" Text="Region:"></dnn1:LabelControl>
						            <asp:Label runat="server" ID="RegionLabel"></asp:Label>
					            </div>
					            <div class="dnnFormItem">
						            <dnn1:LabelControl ID="PostalCodeLabelControl" runat="server" Text="Postal code:"></dnn1:LabelControl>
						            <asp:Label runat="server" ID="PostalCodeLabel"></asp:Label>
					            </div>
					            <div class="dnnFormItem">
						            <dnn1:LabelControl ID="CountryLabelControl" runat="server" Text="Country:"></dnn1:LabelControl>
						            <asp:Label runat="server" ID="CountryLabel"></asp:Label>
					            </div>
					            <div class="dnnFormItem">
						            <dnn1:LabelControl ID="TelephoneLabelControl" runat="server" Text="Telephone:"></dnn1:LabelControl>
						            <asp:Label runat="server" ID="TelephoneLabel"></asp:Label>
					            </div>
					            <div class="dnnFormItem">
						            <dnn1:LabelControl ID="FaxLabelControl" runat="server" Text="Fax:"></dnn1:LabelControl>
						            <asp:Label runat="server" ID="FaxLabel"></asp:Label>
					            </div>
					            <div class="dnnFormItem">
						            <dnn1:LabelControl ID="EmailLabelControl" runat="server" Text="Email:"></dnn1:LabelControl>
						            <asp:Label runat="server" ID="EmailLabel"></asp:Label>
					            </div>
					            <div class="dnnFormItem">
						            <dnn1:LabelControl ID="LastIPAddressLabelControl" runat="server" Text="Last IP address:"></dnn1:LabelControl>
						            <asp:Label runat="server" ID="LastIPAddressLabel"></asp:Label>
					            </div>
				            </fieldset>
			            </asp:Panel>
			            <asp:Panel ID="TaxesDetailsViewPanel" runat="server" CssClass="dnnClear">
				            <fieldset>
					            <div class="dnnFormItem">
						            <dnn1:LabelControl ID="TaxExempt1Control" runat="server" HelpText="User is exempt from tax level 1 (usually country level)." Text="Tax exempt 1:"></dnn1:LabelControl>
						            <asp:CheckBox ID="TaxExempt1CheckBox" runat="server" />
					            </div>
					            <div class="dnnFormItem">
						            <dnn1:LabelControl ID="TaxExemptionNumber1Control" runat="server" HelpText="Enter the tax exemption number for level 1 tax (usually country level). This exemption number may be used by your tax provider to exempt the user from this level of taxation." Text="Tax exemption number 1:"></dnn1:LabelControl>
						            <asp:TextBox ID="TaxExemptionNumber1TextBox" runat="server" />
					            </div>
					            <div class="dnnFormItem">
						            <dnn1:LabelControl ID="TaxExempt2Control" runat="server" HelpText="User is exempt from tax level 2 (usually state level)." Text="Tax exempt 2:"></dnn1:LabelControl>
						            <asp:CheckBox ID="TaxExempt2CheckBox" runat="server" />
					            </div>
					            <div class="dnnFormItem">
						            <dnn1:LabelControl ID="TaxExemptionNumber2Control" runat="server" HelpText="Enter the tax exemption number for level 2 tax (usually state level). This exemption number may be used by your tax provider to exempt the user from this level of taxation." Text="Tax exemption number 2:"></dnn1:LabelControl>
						            <asp:TextBox ID="TaxExemptionNumber2TextBox" runat="server" />
					            </div>
					            <div class="dnnFormItem">
						            <dnn1:LabelControl ID="TaxExempt3Control" runat="server" HelpText="User is exempt from tax level 3 (usually county level)." Text="Tax exempt 3:"></dnn1:LabelControl>
						            <asp:CheckBox ID="TaxExempt3CheckBox" runat="server" />
					            </div>
					            <div class="dnnFormItem">
						            <dnn1:LabelControl ID="TaxExemptionNumber3Control" runat="server" HelpText="Enter the tax exemption number for level 3 tax (usually county level). This exemption number may be used by your tax provider to exempt the user from this level of taxation." Text="Tax exemption number 3:"></dnn1:LabelControl>
						            <asp:TextBox ID="TaxExemptionNumber3TextBox" runat="server" />
					            </div>
					            <div class="dnnFormItem">
						            <dnn1:LabelControl ID="TaxExempt4Control" runat="server" HelpText="User is exempt from tax level 4 (usually city level)." Text="Tax exempt 4:"></dnn1:LabelControl>
						            <asp:CheckBox ID="TaxExempt4CheckBox" runat="server" />
					            </div>
					            <div class="dnnFormItem">
						            <dnn1:LabelControl ID="TaxExemptionNumber4Control" runat="server" HelpText="Enter the tax exemption number for level 4 tax (usually city level). This exemption number may be used by your tax provider to exempt the user from this level of taxation." Text="Tax exemption number 4:"></dnn1:LabelControl>
						            <asp:TextBox ID="TaxExemptionNumber4TextBox" runat="server" />
					            </div>
					            <div class="dnnFormItem">
						            <dnn1:LabelControl ID="TaxExempt5Control" runat="server" HelpText="User is exempt from tax level 5 (usually specialized level)." Text="Tax exempt 5:"></dnn1:LabelControl>
						            <asp:CheckBox ID="TaxExempt5CheckBox" runat="server" />
					            </div>
					            <div class="dnnFormItem">
						            <dnn1:LabelControl ID="TaxExemptionNumber5Control" runat="server" HelpText="Enter the tax exemption number for level 5 tax (usually specialized level). This exemption number may be used by your tax provider to exempt the user from this level of taxation." Text="Tax exemption number 5:"></dnn1:LabelControl>
						            <asp:TextBox ID="TaxExemptionNumber5TextBox" runat="server" />
					            </div>
				            </fieldset>
			            </asp:Panel>
			            <asp:Panel ID="UserPaymentDetailsViewPanel" runat="server" CssClass="dnnClear">
				            <fieldset>
					            <uc1:UserPaymentControl ID="UserPaymentControl1" runat="server"></uc1:UserPaymentControl>
				            </fieldset>
			            </asp:Panel>
			            <asp:Panel ID="NotesDetailsViewPanel" runat="server" CssClass="dnnClear">
				            <fieldset>
					            <div class="dnnFormItem">
						            <dnn1:LabelControl ID="AdminNotesLabelControl" runat="server" HelpText="Notes entered here are not visible to the customer." Text="Admin notes:"></dnn1:LabelControl>
						            <asp:TextBox ID="AdminNotesTextBox" runat="server" MaxLength="4000" Rows="10" TextMode="MultiLine"></asp:TextBox>
					            </div>
				            </fieldset>
			            </asp:Panel>
		            </div>
		            <div class="dnnForm">
			            <ul class="dnnActions">
				            <li>
					            <asp:LinkButton ID="SaveLinkButton" runat="server" Text="Save" OnClick="SaveLinkButton_Click" CssClass="dnnPrimaryAction rvdSaveAction" ValidationGroup="CustomerDetailsViewControl" />
				            </li>
                            <li>
			                    <asp:LinkButton ID="SaveAndBackLinkButton" runat="server" Text="Save & return" OnClick="SaveLinkButton_Click" CommandArgument="Back" CssClass="dnnPrimaryAction rvdSaveAction" ValidationGroup="CustomerDetailsViewControl" />
		                    </li>
                            <li>
                                <uc1:BackControl ID="BackControl1" runat="server" Text="Cancel"/>
                            </li>
				            <li>
					            <asp:HyperLink ID="UsernameHyperLink" runat="server" Text="Manage user" CssClass="dnnSecondaryAction"></asp:HyperLink>
				            </li>
			            </ul>
		            </div>
                </asp:View>
            </asp:MultiView>
	    </ContentTemplate>
    </asp:UpdatePanel>
</div>