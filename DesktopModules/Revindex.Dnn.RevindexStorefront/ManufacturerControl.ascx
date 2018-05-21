<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ManufacturerControl.ascx.cs" Inherits="Revindex.Dnn.RevindexStorefront.ManufacturerControl" %>
<%@ Register Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Src="~/Controls/labelcontrol.ascx" TagName="LabelControl" TagPrefix="dnn1" %>
<%@ Register Src="~/Controls/texteditor.ascx" TagName="TextEditor" TagPrefix="dnn1" %>
<%@ Register Assembly="DotNetNuke.Web.Deprecated" Namespace="DotNetNuke.Web.UI.WebControls" TagPrefix="dnn2" %>
<%@ Register Assembly="Revindex.Web.UI.WebControls" Namespace="Revindex.Web.UI.WebControls" TagPrefix="rvd1" %>
<%@ Register Src="DisplayTemplateDropDownListControl.ascx" TagName="DisplayTemplateDropDownListControl" TagPrefix="uc1" %>
<%@ Register Src="WebUserControls/XmlEditorControl.ascx" TagName="XmlEditorControl" TagPrefix="uc1" %>
<%@ Register Src="WebUserControls/BaseEditorControl.ascx" TagName="BaseEditorControl" TagPrefix="uc1" %>
<%@ Register Src="WebUserControls/Common/Dnn/BackControl.ascx" TagName="BackControl" TagPrefix="uc1" %>
<%@ Register Src="WebUserControls/Common/Dnn/BreadcrumbControl.ascx" TagName="BreadcrumbControl" TagPrefix="uc1" %>
<uc1:BaseEditorControl ID="BaseEditorControl1" runat="server" />
<asp:PlaceHolder ID="PlaceHolder1" runat="server">

    <script type="text/javascript">
        jQuery(document).ready(function ()
        {
            jQuery('#ManufacturerDetailsViewTabPanel').dnnTabs();
        });
        Sys.WebForms.PageRequestManager.getInstance().add_endRequest(function ()
        {
            jQuery('#ManufacturerDetailsViewTabPanel').dnnTabs();
        });
    </script>

</asp:PlaceHolder>
<div>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
        <ContentTemplate>
            <asp:PlaceHolder ID="MessagePlaceHolder" runat="server" />
            <asp:MultiView ID="ContentMultiView" runat="server">
                <asp:View ID="ListView" runat="server">
                    <h2>Manufacturers</h2>
                    <div class="dnnForm rvdsfListContainer">
                        <asp:GridView ID="ManufacturerGridView" runat="server" CssClass="dnnGrid" GridLines="None" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="ManufacturerID" Width="100%" AllowPaging="True" OnRowDeleting="ManufacturerGridView_RowDeleting" OnRowDataBound="ManufacturerGridView_RowDataBound">
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
                                        <asp:LinkButton ID="DeleteLinkButton" runat="server" CommandName="Delete" OnClientClick="return confirm('Are you sure you want to delete this item?')" CausesValidation="False" CssClass="rvdDeleteGridAction"></asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
                                <asp:CheckBoxField DataField="Published" HeaderText="Published" SortExpression="Published" />
                                <asp:BoundField DataField="DisplayOrder" HeaderText="Display order" SortExpression="DisplayOrder" />
                            </Columns>
                        </asp:GridView>
                        <asp:ObjectDataSource ID="ManufacturerObjectDataSource" runat="server" EnablePaging="True" SelectCountMethod="GetCount" SelectMethod="GetAll" TypeName="Revindex.Business.Revindex.Revindex.Storefront.ManufacturerController" SortParameterName="sortExpression" DataObjectTypeName="Revindex.Business.Revindex.Revindex.Storefront.Manufacturer" DeleteMethod="Delete">
                            <SelectParameters>
                                <asp:Parameter DefaultValue="" Name="sortExpression" Type="String" />
                                <asp:Parameter DefaultValue="" Name="maximumRows" Type="Int32" />
                                <asp:Parameter Name="startRowIndex" Type="Int32" />
                                <rvd1:UserControlParameter Name="portalID" PropertyName="PortalId" Type="Int32" />
                            </SelectParameters>
                        </asp:ObjectDataSource>
                        <ul class="dnnActions dnnClear">
                            <li>
                                <asp:HyperLink ID="AddHyperLink" runat="server" Text="Add new" CssClass="dnnPrimaryAction rvdAddNewAction" />
                            </li>
							<li>
                                <asp:HyperLink ID="ImportHyperLink" runat="server" Text="Import" CssClass="dnnSecondaryAction rvdImportAction" />
                            </li>
							<li>
                                <asp:HyperLink ID="ExportHyperLink" runat="server" Text="Export" CssClass="dnnSecondaryAction rvdExportAction" />
                            </li>
                        </ul>
                    </div>
                </asp:View>
                <asp:View ID="DetailsView" runat="server">
                    <uc1:BackControl ID="QuickBackControl" runat="server" Text="" CssClass="rvdsfBackAction" />
                    <h2>Manufacturer: <uc1:BreadcrumbControl ID="BreadcrumbControl" runat="server" /></h2>
                    <div id="ManufacturerDetailsViewTabPanel" class="dnnForm">
                        <ul class="dnnAdminTabNav dnnClear">
                            <li><a href="#<%= GeneralDetailsViewPanel.ClientID %>">
                                <asp:Label ID="GeneralDetailsViewTabLabel" runat="server" Text="General" /></a></li>
                            <li><a href="#<%= DescriptionDetailsViewPanel.ClientID %>">
                                <asp:Label ID="DescriptionDetailsViewTabLabel" runat="server" Text="Description" /></a></li>
                            <li><a href="#<%= DisplayDetailsViewPanel.ClientID %>">
                                <asp:Label ID="DisplayDetailsViewTabLabel" runat="server" Text="Display" /></a></li>
                            <li><a href="#<%= SEODetailsViewPanel.ClientID %>">
                                <asp:Label ID="SEODetailsViewTabLabel" runat="server" Text="SEO" /></a></li>
                            <li ID="ExtensionDetailsViewListItem" runat="server"><a href="#<%= ExtensionDetailsViewPanel.ClientID %>">
                                <asp:Label ID="ExtensionDetailsViewTabLabel" runat="server" Text="Extension" /></a></li>
                        </ul>
                        <asp:Panel ID="GeneralDetailsViewPanel" runat="server" CssClass="dnnClear">
                            <fieldset>
                                <div class="dnnFormItem">
                                    <dnn1:LabelControl ID="ManufacturerIDLabelControl" runat="server" Text="Manufacturer ID:" />
                                    <asp:Label ID="ManufacturerIDLabel" runat="server"></asp:Label>
                                </div>
								<asp:Panel ID="ManufacturerKeyPanel" runat="server" CssClass="dnnFormItem">
									<dnn1:LabelControl ID="ManufacturerKeyLabelControl" runat="server" Text="Manufacturer key:" CssClass="dnnFormRequired" HelpText="Enter a key that uniquely identifies this item throughout the system. The key could be your item name, SKU, any short meaningful text or simply a GUID value as long as the value is unique. The key is useful for bulk import and programming automation to help refer back to this item." />
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="ManufacturerKeyTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationExpression="[^;|\[\]&lt;&gt;{}^\\]+" ValidationGroup="ManufacturerDetailsViewControl">Key is invalid.</asp:RegularExpressionValidator>
                                    <asp:TextBox ID="ManufacturerKeyTextBox" runat="server" MaxLength="100" CssClass="dnnFormRequired"></asp:TextBox>
								</asp:Panel>
                                <div class="dnnFormItem">
                                    <dnn1:LabelControl ID="NameLabelControl" runat="server" Text="Name:" CssClass="dnnFormRequired" />
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="NameTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="ManufacturerDetailsViewControl">Name is required.</asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="NameTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationExpression="[^;|\[\]&lt;&gt;{}^\\]+" ValidationGroup="ManufacturerDetailsViewControl">Name is invalid.</asp:RegularExpressionValidator>
                                    <asp:TextBox ID="NameTextBox" runat="server" CssClass="dnnFormRequired" MaxLength="100" ></asp:TextBox>
                                </div>
                                <div class="dnnFormItem">
                                    <dnn1:LabelControl ID="PhoneLabelControl" runat="server" Text="Phone:" />
                                    <asp:TextBox ID="PhoneTextBox" runat="server" MaxLength="50"></asp:TextBox>
                                </div>
                                <div class="dnnFormItem">
                                    <dnn1:LabelControl ID="EmailLabelControl" runat="server" Text="Email:" />
                                    <asp:RegularExpressionValidator ID="EmailRegularExpressionValidator" runat="server" ControlToValidate="EmailTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationExpression="^(\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*|(&quot;*[\w ]*&quot;*\s*)&lt;\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*&gt;)$" ValidationGroup="ManufacturerDetailsViewControl">Email is invalid.</asp:RegularExpressionValidator>
                                    <asp:TextBox ID="EmailTextBox" runat="server" MaxLength="256"></asp:TextBox>
                                </div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="LabelControl1" runat="server" />
									<asp:HyperLink ID="AddFeaturesHyperLink" runat="server" Text="+ Enable more features" CssClass="dnnTertiaryAction" />
								</div>
                            </fieldset>
                        </asp:Panel>
                        <asp:Panel ID="DescriptionDetailsViewPanel" runat="server" CssClass="dnnClear">
                            <fieldset>
                                <div class="dnnFormItem">
                                    <dnn1:LabelControl ID="DescriptionLabelControl" runat="server" Text="Description:" />
                                    <dnn1:TextEditor ID="DescriptionTextEditor" runat="server" ChooseRender="False" ChooseMode="False" DefaultMode="RICH" Mode="RICH" HtmlEncode="False" Width="100%" Height="250px" />
                                </div>
                            </fieldset>
                        </asp:Panel>
                        <asp:Panel ID="DisplayDetailsViewPanel" runat="server" CssClass="dnnClear">
                            <fieldset>
                                <div class="dnnFormItem">
                                    <dnn1:LabelControl ID="PublishedLabelControl" runat="server" Text="Published:" HelpText="Publish this item to customers." />
                                    <asp:CheckBox ID="PublishedCheckBox" runat="server" Checked="True" />
                                </div>
                                <div class="dnnFormItem">
                                    <dnn1:LabelControl ID="DisplayTemplateLabelControl" runat="server" Text="Display template:" HelpText="The selected display template determines how to display the Product List module when this manufacturer is selected. Select a custom display template to associate to this manufacturer." />
                                    <uc1:DisplayTemplateDropDownListControl ID="DisplayTemplateDropDownList" runat="server" />
									<asp:LinkButton ID="DisplayTemplateLinkButton" runat="server" CssClass="rvdLinkAction" Text="Edit" OnClick="DisplayTemplateLinkButton_Click" CausesValidation="False" />
                                </div>
                                <div class="dnnFormItem">
                                    <dnn1:LabelControl ID="DisplayOrderExtensionLabelControl" runat="server" HelpText="Sort the item for display by lowest to highest number starting from zero." Text="Display order:" CssClass="dnnFormRequired" />
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="DisplayOrderDnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="ManufacturerDetailsViewControl">Display order is required.</asp:RequiredFieldValidator>
                                    <dnn2:DnnNumericTextBox ID="DisplayOrderDnnNumericTextBox" runat="server" Skin="" Value="1000" NumberFormat-DecimalDigits="0" NumberFormat-GroupSizes="9" EnableSingleInputRendering="False" CssClass="dnnFormRequired">
                                    </dnn2:DnnNumericTextBox>
                                </div>
                            </fieldset>
                        </asp:Panel>
                        <asp:Panel ID="SEODetailsViewPanel" runat="server" CssClass="dnnClear">
                            <fieldset>
								<div class="dnnFormItem">
                                    <dnn1:LabelControl ID="UrlNameLabelControl" runat="server" HelpText="Specify a unique name that will appear in the URL slug for the product list page. The name should contain meaningful keywords in lowercase. The manufacturer name will be used if this value is empty. A good set of keywords can help your page ranking in search results." Text="URL name:" />
                                    <asp:TextBox ID="UrlNameTextBox" runat="server" MaxLength="400"></asp:TextBox>
                                </div>
                                <div class="dnnFormItem">
                                    <dnn1:LabelControl ID="PageTitleLabelControl" runat="server" Text="Page title:" HelpText="Specify a custom page title for the product list page. A good title can help your page ranking in search results." />
                                    <asp:TextBox ID="PageTitleTextBox" runat="server" MaxLength="400"></asp:TextBox>
                                </div>
                                <div class="dnnFormItem">
                                    <dnn1:LabelControl ID="MetaKeywordsLabelControl" runat="server" Text="Meta keywords:" HelpText="Specify META keywords for the product list page." />
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator5" runat="server" ControlToValidate="MetaKeywordsTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationExpression="^[\s\S]{0,400}$" ValidationGroup="ManufacturerDetailsViewControl">Meta keywords is invalid.</asp:RegularExpressionValidator>
                                    <asp:TextBox ID="MetaKeywordsTextBox" runat="server" Rows="3" TextMode="MultiLine" MaxLength="400"></asp:TextBox>
                                </div>
                                <div class="dnnFormItem">
                                    <dnn1:LabelControl ID="MetaDescriptionLabelControl" runat="server" Text="Meta description:" HelpText="Specify META description for the product list page." />
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator6" runat="server" ControlToValidate="MetaDescriptionTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationExpression="^[\s\S]{0,400}$" ValidationGroup="ManufacturerDetailsViewControl">Meta description is invalid.</asp:RegularExpressionValidator>
                                    <asp:TextBox ID="MetaDescriptionTextBox" runat="server" Rows="3" TextMode="MultiLine" MaxLength="400"></asp:TextBox>
                                </div>
                            </fieldset>
                        </asp:Panel>
                        <asp:Panel ID="ExtensionDetailsViewPanel" runat="server" CssClass="dnnClear">
                            <fieldset>
                                <div class="dnnFormItem">
                                    <dnn1:LabelControl ID="ExtensionLabelControl" runat="server" Text="Extension:" HelpText="Provide any custom data associated with this item using XML." />
                                    <uc1:XmlEditorControl ID="ExtensionXmlEditor" runat="server" Width="100%" ModuleControl="ManufacturerExtension" />
                                </div>
                            </fieldset>
                        </asp:Panel>
                    </div>
                    <div class="dnnForm">
                        <ul class="dnnActions">
                            <li>
                                <asp:LinkButton ID="SaveLinkButton" runat="server" Text="Save" OnClick="SaveLinkButton_Click" CssClass="dnnPrimaryAction rvdSaveAction" ValidationGroup="ManufacturerDetailsViewControl" />
                            </li>
                            <li>
                                <asp:LinkButton ID="SaveAndBackLinkButton" runat="server" Text="Save & return" OnClick="SaveLinkButton_Click" CommandArgument="Back" CssClass="dnnPrimaryAction rvdSaveAction" ValidationGroup="ManufacturerDetailsViewControl" />
                            </li>
                            <li>
                                <uc1:BackControl ID="BackControl1" runat="server" Text="Cancel" />
                            </li>
                            <li>
                                <asp:HyperLink ID="PreviewHyperLink" runat="server" Text="Preview" CssClass="dnnSecondaryAction rvdPreviewAction" Target="_blank" />
                            </li>
                        </ul>
                    </div>
                </asp:View>
            </asp:MultiView>
        </ContentTemplate>
    </asp:UpdatePanel>
</div>
