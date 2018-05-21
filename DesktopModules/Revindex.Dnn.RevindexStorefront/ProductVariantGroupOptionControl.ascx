<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ProductVariantGroupOptionControl.ascx.cs" Inherits="Revindex.Dnn.RevindexStorefront.ProductVariantGroupOptionControl" %>
<%@ Register Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Src="~/Controls/labelcontrol.ascx" TagName="LabelControl" TagPrefix="dnn1" %>
<%@ Register Assembly="DotNetNuke.Web.Deprecated" Namespace="DotNetNuke.Web.UI.WebControls" TagPrefix="dnn2" %>
<%@ Register Assembly="Revindex.Web.UI.WebControls" Namespace="Revindex.Web.UI.WebControls" TagPrefix="rvd1" %>
<%@ Register Src="WebUserControls/Common/Dnn/BackControl.ascx" TagName="BackControl" TagPrefix="uc1" %>
<%@ Register Src="WebUserControls/Common/Dnn/BreadcrumbControl.ascx" TagName="BreadcrumbControl" TagPrefix="uc1" %>
<div>
	<asp:UpdatePanel ID="UpdatePanel1" UpdateMode="Conditional" runat="server">
        <Triggers>
            <asp:PostBackTrigger ControlID="SaveLinkButton" />
            <asp:PostBackTrigger ControlID="SaveAndBackLinkButton" />
        </Triggers>
		<ContentTemplate>
			<asp:PlaceHolder ID="MessagePlaceHolder" runat="server" />
			<asp:MultiView ID="ContentMultiView" runat="server">
				<asp:View ID="ListView" runat="server">
					<div class="dnnForm rvdsfListContainer">
						<asp:GridView ID="ProductVariantGroupOptionGridView" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" OnRowDeleting="ProductVariantGroupOptionGridView_RowDeleting" CssClass="dnnGrid" GridLines="None" DataKeyNames="ProductVariantGroupOptionID" OnRowDataBound="ProductVariantGroupOptionGridView_RowDataBound">
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
								<asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
								<asp:BoundField DataField="DisplayOrder" HeaderText="Display Order" SortExpression="DisplayOrder" />
							</Columns>
						</asp:GridView>
						<asp:ObjectDataSource ID="ProductVariantGroupOptionObjectDataSource" runat="server" EnablePaging="True" SelectCountMethod="GetCount" SelectMethod="GetAll" SortParameterName="sortExpression" TypeName="Revindex.Business.Revindex.Revindex.Storefront.ProductVariantGroupOptionController">
							<SelectParameters>
								<asp:Parameter Name="sortExpression" Type="String" />
								<asp:Parameter Name="maximumRows" Type="Int32" />
								<asp:Parameter Name="startRowIndex" Type="Int32" />
								<rvd1:UserControlParameter Name="productVariantGroupID" PropertyName="ProductVariantGroupID" Type="Int32" />
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
					<h2>Variant group option: <uc1:BreadcrumbControl ID="BreadcrumbControl" runat="server" /></h2>
					<div class="dnnForm">
						<fieldset>
							<div class="dnnFormItem">
								<dnn1:LabelControl ID="ProductVariantGroupOptionIDLabelControl" runat="server" Text="Product variant group option ID:" />
								<asp:Label ID="ProductVariantGroupOptionIDLabel" runat="server"></asp:Label>
							</div>
							<asp:Panel ID="ProductVariantGroupOptionKeyPanel" runat="server" CssClass="dnnFormItem">
								<dnn1:LabelControl ID="ProductVariantGroupOptionKeyLabelControl" runat="server" Text="ProductVariantGroupOption key:" CssClass="dnnFormRequired" HelpText="Enter a key that uniquely identifies this item throughout the system. The key could be your item name, SKU, any short meaningful text or simply a GUID value as long as the value is unique. The key is useful for bulk import and programming automation to help refer back to this item." />
								<asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="ProductVariantGroupOptionKeyTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationExpression="[^;|\[\]&lt;&gt;{}^\\]+" ValidationGroup="ProductVariantGroupOptionDetailsViewControl">Key is invalid.</asp:RegularExpressionValidator>
								<asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="ProductVariantGroupOptionKeyTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="ProductVariantGroupOptionDetailsViewControl">Key is required.</asp:RequiredFieldValidator>
								<asp:TextBox ID="ProductVariantGroupOptionKeyTextBox" runat="server" MaxLength="100" CssClass="dnnFormRequired"></asp:TextBox>
							</asp:Panel>
							<div class="dnnFormItem">
								<dnn1:LabelControl ID="NameLabelControl" runat="server" HelpText="The option name (e.g. Small, Medium, Large)." Text="Name:" CssClass="dnnFormRequired" />
								<asp:RequiredFieldValidator ID="NameRequiredFieldValidator" runat="server" ControlToValidate="NameTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="ProductVariantGroupOptionDetailsViewControl">Name is required.</asp:RequiredFieldValidator>
								<asp:RegularExpressionValidator ID="NameRegularExpressionValidator" runat="server" ControlToValidate="NameTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationExpression="[^;|\[\]&lt;&gt;{}^\\]+" ValidationGroup="ProductVariantGroupOptionDetailsViewControl">Name is invalid.</asp:RegularExpressionValidator>
								<asp:TextBox ID="NameTextBox" runat="server" CssClass="dnnFormRequired"></asp:TextBox>
							</div>
							<asp:Panel ID="ColorCodePanel" runat="server" CssClass="dnnFormItem">
								<dnn1:LabelControl ID="ColorCodeLabelControl" runat="server" HelpText="Enter a Web color name or HTML color code (e.g. Blue, Red, #FFCC00)." Text="Color code:" CssClass="dnnFormRequired" />
								<asp:RequiredFieldValidator ID="ColorCodeRequiredFieldValidator" runat="server" ControlToValidate="ColorCodeTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="ProductVariantGroupOptionDetailsViewControl">ColorCode is required.</asp:RequiredFieldValidator>
								<asp:RegularExpressionValidator ID="ColorCodeRegularExpressionValidator" runat="server" ControlToValidate="ColorCodeTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationExpression="[^;|\[\]&lt;&gt;{}^\\]+" ValidationGroup="ProductVariantGroupOptionDetailsViewControl">ColorCode is invalid.</asp:RegularExpressionValidator>
								<asp:TextBox ID="ColorCodeTextBox" runat="server" CssClass="dnnFormRequired" ></asp:TextBox>
							</asp:Panel>
                            <asp:Panel ID="ImageSwatchPanel" runat="server">
                                <div class="dnnFormItem">
                                    <dnn1:LabelControl ID="ImageSwatchLabelControl" runat="server" HelpText="Upload a small image (gif, jpg, png) for the swatch." Text="Upload image:" />
                                    <asp:Image ID="ImageSwatchImage" runat="server" style="margin: 0 20px"/>
								    <asp:RegularExpressionValidator ID="ImageSwatchRegularExpressionValidator" runat="server" ControlToValidate="ImageSwatchFileUpload" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationExpression=".+\.(gif|GIF|jpg|JPG|jpeg|JPEG|png|PNG)$" ValidationGroup="ProductVariantGroupOptionDetailsViewControl">ImageSwatch is invalid.</asp:RegularExpressionValidator>
                                    <asp:FileUpload ID="ImageSwatchFileUpload" runat="server" />
                                </div>
							</asp:Panel>
							<div class="dnnFormItem">
								<dnn1:LabelControl ID="DisplayOrderLabelControl" runat="server" HelpText="Sort the item for display by lowest to highest number starting from zero." Text="Display order:" CssClass="dnnFormRequired" />
								<asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="DisplayOrderDnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="ProductVariantGroupOptionDetailsViewControl">Display order is required.</asp:RequiredFieldValidator>
								<dnn2:DnnNumericTextBox ID="DisplayOrderDnnNumericTextBox" runat="server" Skin="" Value="1000" NumberFormat-DecimalDigits="0" NumberFormat-GroupSizes="9" EnableSingleInputRendering="False" CssClass="dnnFormRequired">
								</dnn2:DnnNumericTextBox>
							</div>
						</fieldset>
						<ul class="dnnActions">
							<li>
								<asp:LinkButton ID="SaveLinkButton" runat="server" Text="Save" OnClick="SaveLinkButton_Click" CssClass="dnnPrimaryAction rvdSaveAction" ValidationGroup="ProductVariantGroupOptionDetailsViewControl" />
							</li>
							<li>
								<asp:LinkButton ID="SaveAndBackLinkButton" runat="server" Text="Save & return" OnClick="SaveLinkButton_Click" CommandArgument="Back" CssClass="dnnPrimaryAction rvdSaveAction" ValidationGroup="ProductVariantGroupOptionDetailsViewControl" />
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
