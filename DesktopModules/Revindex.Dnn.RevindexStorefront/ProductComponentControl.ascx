<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ProductComponentControl.ascx.cs" Inherits="Revindex.Dnn.RevindexStorefront.ProductComponentControl" %>
<%@ Register Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Src="~/Controls/labelcontrol.ascx" TagName="LabelControl" TagPrefix="dnn1" %>
<%@ Register Assembly="DotNetNuke.Web.Deprecated" Namespace="DotNetNuke.Web.UI.WebControls" TagPrefix="dnn2" %>
<%@ Register Assembly="Revindex.Web.UI.WebControls" Namespace="Revindex.Web.UI.WebControls" TagPrefix="rvd1" %>
<%@ Register Src="ProductPartControl.ascx" TagName="ProductPartControl" TagPrefix="uc1" %>
<%@ Register Src="WebUserControls/Common/Dnn/BackControl.ascx" TagName="BackControl" TagPrefix="uc1" %>
<%@ Register Src="WebUserControls/Common/Dnn/BreadcrumbControl.ascx" TagName="BreadcrumbControl" TagPrefix="uc1" %>
<div>
	<asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
		<ContentTemplate>
			<asp:PlaceHolder ID="MessagePlaceHolder" runat="server" />
			<asp:MultiView ID="ContentMultiView" runat="server">
				<asp:View ID="ListView" runat="server">
					<div class="dnnForm rvdsfListContainer">
						<asp:GridView ID="ProductComponentGridView" runat="server" AllowSorting="False" AutoGenerateColumns="False" DataKeyNames="ProductComponentID" CssClass="dnnGrid" GridLines="None" AllowPaging="False" OnRowDeleting="ProductComponentGridView_RowDeleting" OnRowDataBound="ProductComponentGridView_RowDataBound">
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
								<asp:BoundField DataField="Name" HeaderText="Name" />
								<asp:BoundField DataField="DisplayOrder" HeaderText="Display order" />
							</Columns>
						</asp:GridView>
						<asp:ObjectDataSource runat="server" EnablePaging="True" SelectCountMethod="GetCount" SelectMethod="GetAll" SortParameterName="sortExpression" TypeName="Revindex.Business.Revindex.Revindex.Storefront.ProductComponentController" ID="ProductComponentObjectDataSource" DataObjectTypeName="Revindex.Business.Revindex.Revindex.Storefront.ProductComponent" DeleteMethod="Delete">
							<SelectParameters>
								<asp:Parameter Name="sortExpression" Type="String"></asp:Parameter>
								<asp:Parameter Name="maximumRows" Type="Int32"></asp:Parameter>
								<asp:Parameter Name="startRowIndex" Type="Int32"></asp:Parameter>
								<asp:Parameter Name="deleted" Type="Boolean" DefaultValue="false"></asp:Parameter>
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
					<h2>Component:
						<uc1:BreadcrumbControl ID="BreadcrumbControl" runat="server" />
					</h2>
					<div id="ProductComponentDetailsViewTabPanel" class="dnnForm">
						<h2 class="dnnFormSectionHead"><a href="#">General</a></h2>
						<fieldset>
							<div class="dnnFormItem">
								<dnn1:LabelControl ID="ProductComponentIDLabelControl" runat="server" Text="Product component ID:" />
								<asp:Label ID="ProductComponentIDLabel" runat="server"></asp:Label>
							</div>
							<asp:Panel ID="ProductComponentKeyPanel" runat="server" CssClass="dnnFormItem">
								<dnn1:LabelControl ID="ProductComponentKeyLabelControl" runat="server" Text="Product component key:" CssClass="dnnFormRequired" HelpText="Enter a key that uniquely identifies this item throughout the system. The key could be any short meaningful text or simply a GUID value as long as the value is unique. The key is useful for bulk import and programming automation to help refer back to this item." />
								<asp:RegularExpressionValidator ID="RegularExpressionValidator8" runat="server" ControlToValidate="ProductComponentKeyTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationExpression="[^;|\[\]&lt;&gt;{}^\\]+" ValidationGroup="ProductComponentDetailsViewControl">Key is invalid.</asp:RegularExpressionValidator>
								<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="ProductComponentKeyTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="ProductComponentDetailsViewControl">Key is required.</asp:RequiredFieldValidator>
								<asp:TextBox ID="ProductComponentKeyTextBox" runat="server" MaxLength="100" CssClass="dnnFormRequired"></asp:TextBox>
							</asp:Panel>
							<div class="dnnFormItem">
								<dnn1:LabelControl ID="NameLabelControl" runat="server" Text="Name:" CssClass="dnnFormRequired" />
								<asp:RequiredFieldValidator ID="NameRequiredFieldValidator" runat="server" ControlToValidate="NameTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="ProductComponentDetailsViewControl">Name is required.</asp:RequiredFieldValidator>
								<asp:TextBox ID="NameTextBox" runat="server"></asp:TextBox>
							</div>
							<div class="dnnFormItem">
								<dnn1:LabelControl ID="DisplayOrderLabelControl" runat="server" HelpText="Sort the item for display by lowest to highest number starting from zero." Text="Display order:" CssClass="dnnFormRequired" />
								<asp:RequiredFieldValidator ID="DisplayOrderRequiredFieldValidator" runat="server" ControlToValidate="DisplayOrderDnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="ProductComponentDetailsViewControl">Display order is required.</asp:RequiredFieldValidator>
								<dnn2:DnnNumericTextBox ID="DisplayOrderDnnNumericTextBox" runat="server" Skin="" Value="1000" NumberFormat-DecimalDigits="0" NumberFormat-GroupSizes="9" EnableSingleInputRendering="False" CssClass="dnnFormRequired">
								</dnn2:DnnNumericTextBox>
							</div>
							<div class="dnnFormItem">
								<dnn1:LabelControl ID="ComponentTypeLabelControl" runat="server" Text="Type:" CssClass="dnnFormRequired" />
								<asp:DropDownList ID="ComponentTypeDropDownList" runat="server">
									<asp:ListItem Text="Implicit (hidden)" Value="1" />
									<asp:ListItem Text="Explicit (visible)" Value="2" />
									<asp:ListItem Text="Multiple selection" Value="3" />
									<asp:ListItem Text="Single selection" Value="4" />
								</asp:DropDownList>
							</div>
						</fieldset>
						<h2 class="dnnFormSectionHead"><a href="#">Parts</a></h2>
						<fieldset>
							<asp:Label ID="ProductPartUnavailableLabel" runat="server" Text="Please save your component first before adding a product part item." CssClass="dnnFormMessage dnnFormInfo"></asp:Label>
							<uc1:ProductPartControl ID="ProductPartControl1" runat="server"></uc1:ProductPartControl>
						</fieldset>
					</div>
					<div class="dnnForm">
						<ul class="dnnActions">
							<li>
								<asp:LinkButton ID="SaveLinkButton" runat="server" Text="Save" OnClick="SaveLinkButton_Click" ValidationGroup="ProductComponentDetailsViewControl" CssClass="dnnPrimaryAction rvdSaveAction" />
							</li>
							<li>
								<asp:LinkButton ID="SaveAndBackLinkButton" runat="server" Text="Save & return" OnClick="SaveLinkButton_Click" CommandArgument="Back" CssClass="dnnPrimaryAction rvdSaveAction" ValidationGroup="ProductComponentDetailsViewControl" />
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
