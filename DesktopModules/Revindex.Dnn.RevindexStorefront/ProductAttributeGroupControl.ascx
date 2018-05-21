<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ProductAttributeGroupControl.ascx.cs" Inherits="Revindex.Dnn.RevindexStorefront.ProductAttributeGroupControl" %>
<%@ Register Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Src="~/Controls/labelcontrol.ascx" TagName="LabelControl" TagPrefix="dnn1" %>
<%@ Register Assembly="DotNetNuke.Web.Deprecated" Namespace="DotNetNuke.Web.UI.WebControls" TagPrefix="dnn2" %>
<%@ Register Assembly="Revindex.Web.UI.WebControls" Namespace="Revindex.Web.UI.WebControls" TagPrefix="rvd1" %>
<%@ Register Src="WebUserControls/Common/Dnn/BackControl.ascx" TagName="BackControl" TagPrefix="uc1" %>
<%@ Register Src="WebUserControls/Common/Dnn/BreadcrumbControl.ascx" TagName="BreadcrumbControl" TagPrefix="uc1" %>
<div>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
        <ContentTemplate>
            <asp:PlaceHolder ID="MessagePlaceHolder" runat="server" />
            <asp:MultiView ID="ContentMultiView" runat="server">
                <asp:View ID="ListView" runat="server">
                    <h2>Product attribute groups</h2>
                    <div class="dnnForm rvdsfListContainer">
                        <asp:GridView ID="ProductAttributeGroupGridView" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" OnRowDeleting="ProductAttributeGroupGridView_RowDeleting" CssClass="dnnGrid" GridLines="None" DataKeyNames="ProductAttributeGroupID" OnRowDataBound="ProductAttributeGroupGridView_RowDataBound">
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
                                <asp:BoundField DataField="DisplayOrder" HeaderText="Display Order" SortExpression="DisplayOrder" />
                            </Columns>
                        </asp:GridView>
                        <asp:ObjectDataSource ID="ProductAttributeGroupObjectDataSource" runat="server" EnablePaging="True" SelectCountMethod="GetCount" SelectMethod="GetAll" SortParameterName="sortExpression" TypeName="Revindex.Business.Revindex.Revindex.Storefront.ProductAttributeGroupController">
                            <SelectParameters>
                                <asp:Parameter Name="sortExpression" Type="String" />
                                <asp:Parameter Name="maximumRows" Type="Int32" />
                                <asp:Parameter Name="startRowIndex" Type="Int32" />
                                <rvd1:UserControlParameter Name="portalID" PropertyName="PortalId" Type="Int32" />
                            </SelectParameters>
                        </asp:ObjectDataSource>
                        <ul class="dnnActions dnnClear">
                            <li>
                                <asp:HyperLink ID="AddHyperLink" runat="server" Text="Add new" CssClass="dnnPrimaryAction rvdAddNewAction" />
                            </li>
							<li>
								<asp:HyperLink ID="ExportHyperLink" runat="server" Text="Export" CssClass="dnnSecondaryAction rvdExportAction" />
							</li>
                        </ul>
                    </div>
                </asp:View>
                <asp:View ID="DetailsView" runat="server">
                    <uc1:BackControl ID="QuickBackControl" runat="server" Text="" CssClass="rvdsfBackAction" />
                    <h2>Product attribute group: <uc1:BreadcrumbControl ID="BreadcrumbControl" runat="server" /></h2>
                    <div class="dnnForm">
                        <fieldset>
                            <div class="dnnFormItem">
                                <dnn1:LabelControl ID="ProductAttributeGroupIDLabelControl" runat="server" Text="Product Attribute Group ID:" />
                                <asp:Label ID="ProductAttributeGroupIDLabel" runat="server"></asp:Label>
                            </div>
                            <div class="dnnFormItem">
                                <dnn1:LabelControl ID="NameLabelControl" runat="server" HelpText="This is the group header name that will appear on screen for the attributes." Text="Name:" CssClass="dnnFormRequired" />
                                <asp:RequiredFieldValidator ID="NameRequiredFieldValidator" runat="server" ControlToValidate="NameTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="ProductAttributeGroupDetailsViewControl">Name is required.</asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="NameRegularExpressionValidator" runat="server" ControlToValidate="NameTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationExpression="[^;|\[\]&lt;&gt;{}^\\]+" ValidationGroup="ProductAttributeGroupDetailsViewControl">Name is invalid.</asp:RegularExpressionValidator>
                                <asp:TextBox ID="NameTextBox" runat="server" CssClass="dnnFormRequired"></asp:TextBox>
                            </div>
                            <div class="dnnFormItem">
                                <dnn1:LabelControl ID="DescriptionLabelControl" runat="server" Text="Description:" />
                                <asp:TextBox ID="DescriptionTextBox" runat="server" Rows="4" TextMode="MultiLine"></asp:TextBox>
                            </div>
                            <div class="dnnFormItem">
                                <dnn1:LabelControl ID="DisplayOrderLabelControl" runat="server" HelpText="Sort the item for display by lowest to highest number starting from zero." Text="Display order:" CssClass="dnnFormRequired" />
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="DisplayOrderDnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="ProductAttributeGroupDetailsViewControl">Display order is required.</asp:RequiredFieldValidator>
                                <dnn2:DnnNumericTextBox ID="DisplayOrderDnnNumericTextBox" runat="server" Skin="" Value="1000" NumberFormat-DecimalDigits="0" NumberFormat-GroupSizes="9" EnableSingleInputRendering="False" CssClass="dnnFormRequired">
                                </dnn2:DnnNumericTextBox>
                            </div>
                        </fieldset>
                        <ul class="dnnActions">
                            <li>
                                <asp:LinkButton ID="SaveLinkButton" runat="server" Text="Save" OnClick="SaveLinkButton_Click" CssClass="dnnPrimaryAction rvdSaveAction" ValidationGroup="ProductAttributeGroupDetailsViewControl" />
                            </li>
                            <li>
                                <asp:LinkButton ID="SaveAndBackLinkButton" runat="server" Text="Save & return" OnClick="SaveLinkButton_Click" CommandArgument="Back" CssClass="dnnPrimaryAction rvdSaveAction" ValidationGroup="ProductAttributeGroupDetailsViewControl" />
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
