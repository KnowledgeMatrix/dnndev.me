<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="GalleryControl.ascx.cs" Inherits="Revindex.Dnn.RevindexStorefront.GalleryControl" %>
<%@ Register Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Src="~/Controls/labelcontrol.ascx" TagName="LabelControl" TagPrefix="dnn1" %>
<%@ Register Assembly="DotNetNuke.Web.Deprecated" Namespace="DotNetNuke.Web.UI.WebControls" TagPrefix="dnn2" %>
<%@ Register Assembly="Revindex.Web.UI.WebControls" Namespace="Revindex.Web.UI.WebControls" TagPrefix="rvd1" %>
<%@ Register Src="WebUserControls/Common/Dnn/BackControl.ascx" TagName="BackControl" TagPrefix="uc1" %>
<%@ Register Src="WebUserControls/Common/Dnn/BreadcrumbControl.ascx" TagName="BreadcrumbControl" TagPrefix="uc1" %>
<div>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <Triggers>
            <asp:PostBackTrigger ControlID="SaveLinkButton" />
            <asp:PostBackTrigger ControlID="SaveAndBackLinkButton" />
        </Triggers>
        <ContentTemplate>
            <asp:PlaceHolder ID="MessagePlaceHolder" runat="server" />
            <asp:MultiView ID="ContentMultiView" runat="server">
                <asp:View ID="ListView" runat="server">
                    <div class="dnnForm rvdsfListContainer">
                        <asp:GridView runat="server" AllowPaging="True" CssClass="dnnGrid" GridLines="None" AllowSorting="True" AutoGenerateColumns="False" ID="GalleryGridView" DataKeyNames="GalleryID" OnRowDeleting="GalleryGridView_RowDeleting" OnRowDataBound="GalleryGridView_RowDataBound" OnDataBound="GalleryGridView_DataBound">
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
                                <asp:TemplateField HeaderText="Image">
                                    <ItemTemplate>
                                        <asp:Image ID="ThumbnailImage" runat="server" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Format" SortExpression="Format">
                                    <ItemTemplate>
                                        <asp:Label ID="Label1" runat="server" Text='<%# GetFormatTypeString(Eval("Format")) %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="MediaType" HeaderText="Media type" SortExpression="MediaType"></asp:BoundField>
                                <asp:BoundField DataField="Width" HeaderText="Width" SortExpression="Width"></asp:BoundField>
                                <asp:BoundField DataField="Height" HeaderText="Height" SortExpression="Height"></asp:BoundField>
                                <asp:BoundField DataField="AlternateText" HeaderText="Alternate text" SortExpression="AlternateText"></asp:BoundField>
                                <asp:BoundField DataField="DisplayOrder" HeaderText="Display order" SortExpression="DisplayOrder"></asp:BoundField>
                            </Columns>
                        </asp:GridView>
                        <asp:ObjectDataSource runat="server" EnablePaging="True" SelectCountMethod="GetCountByIdentifier" SelectMethod="GetAllByIdentifier" SortParameterName="sortExpression" TypeName="Revindex.Business.Revindex.Revindex.Storefront.GalleryController" ID="GalleryObjectDataSource" DataObjectTypeName="Revindex.Business.Revindex.Revindex.Storefront.Gallery" DeleteMethod="Delete">
                            <SelectParameters>
                                <asp:Parameter Name="sortExpression" Type="String"></asp:Parameter>
                                <asp:Parameter Name="maximumRows" Type="Int32"></asp:Parameter>
                                <asp:Parameter Name="startRowIndex" Type="Int32"></asp:Parameter>
                                <rvd1:UserControlParameter Name="categoryID" PropertyName="CategoryID" Type="Int32" />
                                <rvd1:UserControlParameter Name="productID" PropertyName="ProductID" Type="Int32" />
                                <rvd1:UserControlParameter Name="productVariantID" PropertyName="ProductVariantID" Type="Int32" />
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
                    <h2>Gallery: <uc1:BreadcrumbControl ID="BreadcrumbControl" runat="server" /></h2>
                    <div class="dnnForm">
                        <fieldset>
                            <div class="dnnFormItem">
                                <dnn1:LabelControl ID="GalleryLabelControl" runat="server" Text="Image:" />
                                <asp:Panel ID="GalleryImagePanel" runat="server" CssClass="rvdsfGalleryPreviewContainer">
                                    <asp:Image ID="GalleryImage" runat="server" />
                                </asp:Panel>
                            </div>
                            <div class="dnnFormItem">
                                <dnn1:LabelControl ID="GalleryIDLabelControl" runat="server" Text="Gallery ID:" />
                                <asp:Label ID="GalleryIDLabel" runat="server" Text=""></asp:Label>
                            </div>
                            <div class="dnnFormItem">
                                <dnn1:LabelControl ID="FormatLabelControl" runat="server" HelpText="&quot;Detailed&quot; is the large size image shown when the customer wants to see a detailed image. &quot;Display&quot; is the medium size image shown on the product detail page. &quot;Thumbnail&quot; is the small size image shown on the product list page. The system will automatically resize the file for the selected format. If you select multiple formats, make sure to upload the file with the largest format to minimize loss of detail." Text="Format:" />
                                <asp:CheckBoxList ID="FormatCheckBoxList" runat="server" RepeatDirection="Horizontal" RepeatLayout="Flow" CssClass="rvdFormCheckBoxes">
                                    <asp:ListItem Value="1">Detailed</asp:ListItem>
                                    <asp:ListItem Value="2">Display</asp:ListItem>
                                    <asp:ListItem Value="3">Thumbnail</asp:ListItem>
                                </asp:CheckBoxList>
                            </div>
                            <div class="dnnFormItem">
                                <dnn1:LabelControl ID="FileUploadLabelControl" runat="server" Text="Upload file:" HelpText="Upload image file (.gif, .jpg, .jpeg, .png)" />
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="GalleryFileUpload" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationExpression=".+\.(gif|GIF|jpg|JPG|jpeg|JPEG|png|PNG)$" ValidationGroup="GalleryDetailsViewControl">File is invalid.</asp:RegularExpressionValidator>
                                <asp:FileUpload ID="GalleryFileUpload" runat="server" />
                            </div>
                            <div class="dnnFormItem">
                                <dnn1:LabelControl ID="AlternateTextLabelControl" runat="server" Text="Alternate text:" HelpText="Provide any alternate text for search engine optimization." />
                                <asp:TextBox ID="AlternateTextTextBox" runat="server" MaxLength="100"></asp:TextBox>
                            </div>
                            <div class="dnnFormItem">
                                <dnn1:LabelControl ID="DisplayOrderLabelControl" runat="server" Text="Display order:" HelpText="Sort the item for display by lowest to highest number starting from zero. The value of the display order must be the same for each related sizes of the same image set for the zoom to reference the correct image." CssClass="dnnFormRequired" />
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="DisplayOrderDnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="GalleryDetailsViewControl">Display order is required.</asp:RequiredFieldValidator>
                                <dnn2:DnnNumericTextBox ID="DisplayOrderDnnNumericTextBox" runat="server" Skin="" Value="1000" NumberFormat-DecimalDigits="0" NumberFormat-GroupSizes="9" EnableSingleInputRendering="False" CssClass="dnnFormRequired">
                                </dnn2:DnnNumericTextBox>
                            </div>
                        </fieldset>
                        <ul class="dnnActions">
                            <li>
                                <asp:LinkButton ID="SaveLinkButton" runat="server" Text="Save" OnClick="SaveLinkButton_Click" CssClass="dnnPrimaryAction rvdSaveAction" ValidationGroup="GalleryDetailsViewControl" />
                            </li>
                            <li>
                                <asp:LinkButton ID="SaveAndBackLinkButton" runat="server" Text="Save & return" OnClick="SaveLinkButton_Click" CommandArgument="Back" CssClass="dnnPrimaryAction rvdSaveAction" ValidationGroup="GalleryDetailsViewControl" />
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
