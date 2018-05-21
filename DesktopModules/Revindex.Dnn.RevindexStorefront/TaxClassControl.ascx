<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="TaxClassControl.ascx.cs" Inherits="Revindex.Dnn.RevindexStorefront.TaxClassControl" %>
<%@ Register Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Src="~/Controls/labelcontrol.ascx" TagName="LabelControl" TagPrefix="dnn1" %>
<%@ Register Assembly="DotNetNuke.Web.Deprecated" Namespace="DotNetNuke.Web.UI.WebControls" TagPrefix="dnn2" %>
<%@ Register Assembly="Revindex.Web.UI.WebControls" Namespace="Revindex.Web.UI.WebControls" TagPrefix="rvd1" %>
<%@ Register Src="TaxClassExemptionRuleControl.ascx" TagName="TaxClassExemptionRuleControl" TagPrefix="uc1" %>
<%@ Register Src="TaxClassRateRuleControl.ascx" TagName="TaxClassRateRuleControl" TagPrefix="uc1" %>
<%@ Register Src="WebUserControls/BaseEditorControl.ascx" TagName="BaseEditorControl" TagPrefix="uc1" %>
<%@ Register Src="WebUserControls/Common/Dnn/BackControl.ascx" TagName="BackControl" TagPrefix="uc1" %>
<%@ Register Src="WebUserControls/Common/Dnn/BreadcrumbControl.ascx" TagName="BreadcrumbControl" TagPrefix="uc1" %>
<uc1:BaseEditorControl ID="BaseEditorControl1" runat="server" />
<asp:PlaceHolder runat="server">

	<script type="text/javascript">
		jQuery(document).ready(function()
		{
		    jQuery('#TaxClassDetailsViewTabPanel').dnnTabs();
		    jQuery('#<%= SearchPanel.ClientID %>').dnnPanels();
		});
		Sys.WebForms.PageRequestManager.getInstance().add_endRequest(function()
		{
		    jQuery('#TaxClassDetailsViewTabPanel').dnnTabs();
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
                    <h2>Tax methods</h2>
					<p>Tell us how you collect taxes. Once configured, you'll be able to assign your products to any of these new tax methods (e.g. Clothing products can be assigned to the "Goods" tax method, while shipping can be assigned to the "Services" tax method and taxed at a different rate).</p>
                    <asp:Panel ID="SearchPanel" runat="server" CssClass="dnnForm rvdsfSearchContainer">
	                    <fieldset>
                            <div class="dnnFormItem">
				                <dnn1:LabelControl runat="server" ID="SellerSearchLabelControl" Text="Seller:" HelpText="View items belonging to a specific seller."></dnn1:LabelControl>
				                <dnn2:DnnComboBox ID="SellerSearchDnnComboBox" runat="server" AllowCustomText="True" EnableLoadOnDemand="True" OnItemsRequested="SellerSearchDnnComboBox_ItemsRequested" AutoPostBack="True" CausesValidation="False" MaxHeight="200px" OnSelectedIndexChanged="SellerSearchDnnComboBox_SelectedIndexChanged"></dnn2:DnnComboBox>
			                </div>
                        </fieldset>
		            </asp:Panel>
		            <div class="dnnForm rvdsfListContainer">
			            <asp:GridView ID="TaxClassGridView" runat="server" AllowPaging="True" AutoGenerateColumns="False" CssClass="dnnGrid" GridLines="None" OnRowDeleting="TaxClassGridView_RowDeleting" DataKeyNames="TaxClassID" OnRowDataBound="TaxClassGridView_RowDataBound" AllowSorting="True" >
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
                                <asp:CheckBoxField DataField="DefaultTax" HeaderText="Default" SortExpression="DefaultTax" />
				            </Columns>
			            </asp:GridView>
			            <asp:ObjectDataSource ID="TaxClassObjectDataSource" runat="server" DataObjectTypeName="Revindex.Business.Revindex.Revindex.Storefront.TaxClass" DeleteMethod="Delete" SelectMethod="GetAll" TypeName="Revindex.Business.Revindex.Revindex.Storefront.TaxClassController" UpdateMethod="Update" EnablePaging="True" SelectCountMethod="GetCount" SortParameterName="sortExpression">
				            <SelectParameters>
                                <asp:Parameter Name="sortExpression" Type="String" />
					            <asp:Parameter Name="maximumRows" Type="Int32" />
					            <asp:Parameter Name="startRowIndex" Type="Int32" />
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
                    <h2>Tax method: <uc1:BreadcrumbControl ID="BreadcrumbControl" runat="server" /></h2>
			        <div id="TaxClassDetailsViewTabPanel" class="dnnForm">
				        <ul class="dnnAdminTabNav dnnClear">
					        <li><a href="#<%= GeneralDetailsViewPanel.ClientID %>">
						        <asp:Label ID="GeneralDetailsViewTabLabel" runat="server" Text="General" /></a></li>
					        <li><a href="#<%= RateDetailsViewPanel.ClientID %>">
						        <asp:Label ID="RateDetailsViewTabLabel" runat="server" Text="Rate" /></a></li>
					        <li><a href="#<%= ExemptionDetailsViewPanel.ClientID %>">
						        <asp:Label ID="ExemptionDetailsViewTabLabel" runat="server" Text="Exemption" /></a></li>
				        </ul>
				        <asp:Panel ID="GeneralDetailsViewPanel" runat="server" CssClass="dnnClear">
					        <fieldset>
						        <div class="dnnFormItem">
							        <dnn1:LabelControl ID="TaxClassIDLabelControl" runat="server" Text="Tax class ID:" />
							        <asp:Label ID="TaxClassIDLabel" runat="server"></asp:Label>
						        </div>
                                <asp:Panel ID="SellerPanel" runat="server" CssClass="dnnFormItem">
							        <dnn1:LabelControl ID="SellerLabelControl" runat="server" HelpText="Enter the name if this item belongs to a seller." Text="Seller:" />
							        <dnn2:DnnComboBox ID="SellerDnnComboBox" runat="server" AllowCustomText="True" EnableLoadOnDemand="True" OnItemsRequested="SellerDnnComboBox_ItemsRequested" AutoPostBack="True" CausesValidation="False" MaxHeight="200px"></dnn2:DnnComboBox>
						        </asp:Panel>
						        <div class="dnnFormItem">
							        <dnn1:LabelControl ID="NameLabelControl" runat="server" Text="Name:" CssClass="dnnFormRequired" HelpText="Enter a name (e.g. &quot;Goods&quot;)" />
							        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="NameTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="TaxClassDetailsViewControl">Name is required.</asp:RequiredFieldValidator>
							        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="NameTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationExpression="[^;|\[\]&lt;&gt;{}^\\]+" ValidationGroup="TaxClassDetailsViewControl">Name is invalid.</asp:RegularExpressionValidator>
							        <asp:TextBox ID="NameTextBox" runat="server" CssClass="dnnFormRequired" MaxLength="100"></asp:TextBox>
						        </div>
						        <div class="dnnFormItem">
							        <dnn1:LabelControl ID="TaxCodeLabelControl" runat="server" HelpText="Optionally provide a tax code to specify a particular taxability category that may be used by your real-time tax provider for tax calculation. Leave this value blank to use the default tax category from your tax provider. E.g. The Avalara tax code D000000 places all items associated to this tax method under the Digital Goods category. Please consult your tax provider for the list of tax codes if needed." Text="Tax code:" />
							        <asp:TextBox ID="TaxCodeTextBox" runat="server" MaxLength="50"></asp:TextBox>
						        </div>
                                <div class="dnnFormItem">
							        <dnn1:LabelControl ID="DefaultTaxLabelControl" runat="server" Text="Default:" />
							        <asp:CheckBox ID="DefaultTaxCheckBox" runat="server" />
						        </div>
					        </fieldset>
				        </asp:Panel>
				        <asp:Panel ID="RateDetailsViewPanel" runat="server" CssClass="dnnClear">
					        <fieldset>
                                <div class="dnnFormItem">
							        <dnn1:LabelControl ID="TaxClassTypeLabelControl" runat="server" Text="Type:" HelpText="Provide your custom tax rate calculation or choose from the available integrated tax providers." />
							        <asp:DropDownList ID="TaxProviderDropDownList" runat="server" AutoPostBack="True" OnSelectedIndexChanged="TaxProviderDropDownList_SelectedIndexChanged">
								        <asp:ListItem Text="Custom Rate" Value="" />
								        <asp:ListItem Text="AvaTax" Value="AvaTax" />
								        <asp:ListItem Text="Zip2Tax" Value="Zip2Tax" />
							        </asp:DropDownList>
									<asp:HyperLink ID="TaxProviderHyperLink" runat="server" CssClass="rvdLinkAction" Text="Edit"></asp:HyperLink>
						        </div>
						        <uc1:TaxClassRateRuleControl ID="TaxClassRateRuleControl" runat="server" Width="100%" />
								<asp:Label ID="IntegratedTaxRuleLabel" runat="server" CssClass="dnnFormMessage dnnFormInfo" Text="This tax method uses the integrated tax rule. Please click the edit icon to configure your provider." ></asp:Label>
					        </fieldset>
				        </asp:Panel>
				        <asp:Panel ID="ExemptionDetailsViewPanel" runat="server" CssClass="dnnClear">
					        <fieldset>
						        <uc1:TaxClassExemptionRuleControl ID="TaxClassExemptionRuleControl" runat="server" Width="100%" />
					        </fieldset>
				        </asp:Panel>
			        </div>
			        <div class="dnnForm">
				        <ul class="dnnActions">
					        <li>
						        <asp:LinkButton ID="SaveLinkButton" runat="server" Text="Save" OnClick="SaveLinkButton_Click" CssClass="dnnPrimaryAction rvdSaveAction" ValidationGroup="TaxClassDetailsViewControl" />
					        </li>
                            <li>
			                    <asp:LinkButton ID="SaveAndBackLinkButton" runat="server" Text="Save & return" OnClick="SaveLinkButton_Click" CommandArgument="Back" CssClass="dnnPrimaryAction rvdSaveAction" ValidationGroup="TaxClassDetailsViewControl" />
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