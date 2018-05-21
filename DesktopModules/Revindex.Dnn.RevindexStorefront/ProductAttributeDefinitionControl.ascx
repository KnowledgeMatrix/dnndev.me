<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ProductAttributeDefinitionControl.ascx.cs" Inherits="Revindex.Dnn.RevindexStorefront.ProductAttributeDefinitionControl" %>
<%@ Register Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Src="~/Controls/labelcontrol.ascx" TagName="LabelControl" TagPrefix="dnn1" %>
<%@ Register Assembly="DotNetNuke.Web.Deprecated" Namespace="DotNetNuke.Web.UI.WebControls" TagPrefix="dnn2" %>
<%@ Register Assembly="Revindex.Web.UI.WebControls" Namespace="Revindex.Web.UI.WebControls" TagPrefix="rvd1" %>
<%@ Register Src="ProductAttributeDefinitionSelectionControl.ascx" TagName="ProductAttributeDefinitionSelectionControl" TagPrefix="uc1" %>
<%@ Register Assembly="Revindex.Web.UI.WebControls" Namespace="Revindex.Web.UI.WebControls" TagPrefix="rvd1" %>
<%@ Register Src="WebUserControls/Common/Dnn/BackControl.ascx" TagName="BackControl" TagPrefix="uc1" %>
<%@ Register Src="WebUserControls/Common/Dnn/BreadcrumbControl.ascx" TagName="BreadcrumbControl" TagPrefix="uc1" %>
<div>
	<asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
		<ContentTemplate>
			<asp:PlaceHolder ID="MessagePlaceHolder" runat="server" />
			<asp:MultiView ID="ContentMultiView" runat="server">
				<asp:View ID="ListView" runat="server">
					<h2>Product attribute definitions</h2>
					<div class="dnnForm rvdsfListContainer">
						<asp:GridView ID="ProductAttributeDefinitionGridView" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" OnRowDeleting="ProductAttributeDefinitionGridView_RowDeleting" CssClass="dnnGrid" GridLines="None" DataKeyNames="ProductAttributeDefinitionID" OnRowDataBound="ProductAttributeDefinitionGridView_RowDataBound">
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
						<asp:ObjectDataSource ID="ProductAttributeDefinitionObjectDataSource" runat="server" EnablePaging="True" SelectCountMethod="GetCount" SelectMethod="GetAll" SortParameterName="sortExpression" TypeName="Revindex.Business.Revindex.Revindex.Storefront.ProductAttributeDefinitionController">
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
					<h2>Product attribute definition: <uc1:BreadcrumbControl ID="BreadcrumbControl" runat="server" /></h2>
					<div class="dnnForm">
						<fieldset>
							<div class="dnnFormItem">
								<dnn1:LabelControl ID="ProductAttributeDefinitionIDLabelControl" runat="server" Text="Product Attribute Definition ID:" />
								<asp:Label ID="ProductAttributeDefinitionIDLabel" runat="server"></asp:Label>
							</div>
							<asp:Panel ID="ProductAttributeDefinitionKeyPanel" runat="server" CssClass="dnnFormItem">
								<dnn1:LabelControl ID="ProductAttributeDefinitionKeyLabelControl" runat="server" Text="Product Attribute Definition key:" CssClass="dnnFormRequired" HelpText="Enter a key that uniquely identifies this item throughout the system. The key could be your item name, SKU, any short meaningful text or simply a GUID value as long as the value is unique. The key is useful for bulk import and programming automation to help refer back to this item." />
								<asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="ProductAttributeDefinitionKeyTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationExpression="[^;|\[\]&lt;&gt;{}^\\]+" ValidationGroup="ProductAttributeDefinitionDetailsViewControl">Key is invalid.</asp:RegularExpressionValidator>
								<asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="ProductAttributeDefinitionKeyTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="ProductAttributeDefinitionDetailsViewControl">Key is required.</asp:RequiredFieldValidator>
								<asp:TextBox ID="ProductAttributeDefinitionKeyTextBox" runat="server" MaxLength="100" CssClass="dnnFormRequired"></asp:TextBox>
							</asp:Panel>
							<div class="dnnFormItem">
								<dnn1:LabelControl ID="ProductAttributeGroupIDLabelControl" runat="server" HelpText="Select the classification group for this attribute definition." Text="Group:" />
								<asp:DropDownList ID="ProductAttributeGroupDropDownList" runat="server">
								</asp:DropDownList>
							</div>
							<div class="dnnFormItem">
								<dnn1:LabelControl ID="NameLabelControl" runat="server" HelpText="This is the label that will appear on screen for the attribute." Text="Name:" CssClass="dnnFormRequired" />
								<asp:RequiredFieldValidator ID="NameRequiredFieldValidator" runat="server" ControlToValidate="NameTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="ProductAttributeDefinitionDetailsViewControl">Name is required.</asp:RequiredFieldValidator>
								<asp:RegularExpressionValidator ID="NameRegularExpressionValidator" runat="server" ControlToValidate="NameTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationExpression="[^;|\[\]&lt;&gt;{}^\\]+" ValidationGroup="ProductAttributeDefinitionDetailsViewControl">Name is invalid.</asp:RegularExpressionValidator>
								<asp:TextBox ID="NameTextBox" runat="server" CssClass="dnnFormRequired"></asp:TextBox>
							</div>
							<div class="dnnFormItem">
								<dnn1:LabelControl ID="DescriptionLabelControl" runat="server" Text="Description:" />
								<asp:TextBox ID="DescriptionTextBox" runat="server" Rows="4" TextMode="MultiLine"></asp:TextBox>
							</div>
							<div class="dnnFormItem">
								<dnn1:LabelControl ID="HelpTextLabelControl" runat="server" Text="Help text:" />
								<asp:TextBox ID="HelpTextTextBox" runat="server" Rows="4"></asp:TextBox>
							</div>
							<div class="dnnFormItem">
								<dnn1:LabelControl ID="ProductAttributeTypeLabelControl" runat="server" Text="Attribute type:" HelpText="The attribute type determines the acceptable data type for this attribute. Changing attribute type will reset values of affected product attributes." />
								<asp:DropDownList ID="ProductAttributeTypeDropDownList" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ProductAttributeTypeDropDownList_SelectedIndexChanged">
									<asp:ListItem Value="1">Boolean</asp:ListItem>
									<asp:ListItem Value="3">Decimal</asp:ListItem>
									<asp:ListItem Value="2">Integer</asp:ListItem>
									<asp:ListItem Value="5">Selection</asp:ListItem>
									<asp:ListItem Value="4">Text</asp:ListItem>
								</asp:DropDownList>
							</div>
							<asp:MultiView ID="ProductAttributeTypeDetailMultiView" runat="server">
								<asp:View ID="DecimalProductAttributeTypeView" runat="server">
									<div class="dnnFormItem">
										<dnn1:LabelControl ID="StepSizeProductAttributeTypeLabelControl" runat="server" Text="Step size:" HelpText="The step size determines the incremental amount of value that will change when moving between the numeric range." />
										<asp:RequiredFieldValidator ID="StepSizeProductAttributeTypeRequiredFieldValidator" runat="server" ControlToValidate="StepSizeProductAttributeTypeDnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="ProductAttributeDefinitionDetailsViewControl">Step size is required.</asp:RequiredFieldValidator>
										<dnn2:DnnNumericTextBox ID="StepSizeProductAttributeTypeDnnNumericTextBox" runat="server" Skin="" NumberFormat-DecimalDigits="1" NumberFormat-GroupSizes="9" MinValue="0.1" EnableSingleInputRendering="False" Value="1.0" CssClass="dnnFormRequired">
										</dnn2:DnnNumericTextBox>
									</div>
								</asp:View>
								<asp:View ID="SelectionProductAttributeTypeView" runat="server">
									<div class="dnnFormItem">
										<dnn1:LabelControl ID="SelectionProductAttributeTypeLabelControl" runat="server" HelpText="Configure the allowable selections." Text="Selections:" />
										<uc1:ProductAttributeDefinitionSelectionControl ID="ProductAttributeDefinitionSelectionControl1" runat="server" Height="120px" />
									</div>
								</asp:View>
							</asp:MultiView>
							<div class="dnnFormItem">
								<dnn1:LabelControl ID="PublishedLabelControl" runat="server" HelpText="Publish this item to customers." Text="Published:" />
								<asp:CheckBox ID="PublishedCheckBox" runat="server" />
							</div>
							<div class="dnnFormItem">
								<dnn1:LabelControl ID="SearchableLabelControl" runat="server" HelpText="Product listing can be searched by this attribute." Text="Searchable:" />
								<asp:CheckBox ID="SearchableCheckBox" runat="server" />
							</div>
							<div class="dnnFormItem">
								<dnn1:LabelControl ID="FilterableLabelControl" runat="server" HelpText="Product listing can be filtered by this attribute." Text="Filterable:" />
								<asp:CheckBox ID="FilterableCheckBox" runat="server" />
							</div>
							<div class="dnnFormItem">
								<dnn1:LabelControl ID="ComparableLabelControl" runat="server" HelpText="Products can be compared with one another by this attribute." Text="Comparable:" />
								<asp:CheckBox ID="ComparableCheckBox" runat="server" />
							</div>
							<div class="dnnFormItem">
								<dnn1:LabelControl ID="DisplayOrderLabelControl" runat="server" HelpText="Sort the item for display by lowest to highest number starting from zero." Text="Display order:" CssClass="dnnFormRequired" />
								<asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="DisplayOrderDnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="ProductAttributeDefinitionDetailsViewControl">Display order is required.</asp:RequiredFieldValidator>
								<dnn2:DnnNumericTextBox ID="DisplayOrderDnnNumericTextBox" runat="server" Skin="" Value="1000" NumberFormat-DecimalDigits="0" NumberFormat-GroupSizes="9" EnableSingleInputRendering="False" CssClass="dnnFormRequired">
								</dnn2:DnnNumericTextBox>
							</div>
						</fieldset>
						<ul class="dnnActions">
							<li>
								<asp:LinkButton ID="SaveLinkButton" runat="server" Text="Save" OnClick="SaveLinkButton_Click" CssClass="dnnPrimaryAction rvdSaveAction" ValidationGroup="ProductAttributeDefinitionDetailsViewControl" />
							</li>
							<li>
								<asp:LinkButton ID="SaveAndBackLinkButton" runat="server" Text="Save & return" OnClick="SaveLinkButton_Click" CommandArgument="Back" CssClass="dnnPrimaryAction rvdSaveAction" ValidationGroup="ProductAttributeDefinitionDetailsViewControl" />
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
