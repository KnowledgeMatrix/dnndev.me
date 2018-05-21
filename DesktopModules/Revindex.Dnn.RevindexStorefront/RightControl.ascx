<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="RightControl.ascx.cs" Inherits="Revindex.Dnn.RevindexStorefront.RightControl" %>
<%@ Register Src="~/Controls/labelcontrol.ascx" TagName="LabelControl" TagPrefix="dnn1" %>
<%@ Register Assembly="DotNetNuke.Web.Deprecated" Namespace="DotNetNuke.Web.UI.WebControls" TagPrefix="dnn2" %>
<%@ Register Assembly="Revindex.Web.UI.WebControls" Namespace="Revindex.Web.UI.WebControls" TagPrefix="rvd1" %>
<%@ Register Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Src="WebUserControls/Common/Dnn/BackControl.ascx" TagName="BackControl" TagPrefix="uc1" %>
<%@ Register Src="WebUserControls/Common/Dnn/BreadcrumbControl.ascx" TagName="BreadcrumbControl" TagPrefix="uc1" %>
<asp:PlaceHolder runat="server">

	<script type="text/javascript">
		jQuery(document).ready(function ()
		{
			jQuery('#<%= SearchPanel.ClientID %>').dnnPanels();
			jQuery('#RightDetailsViewTabPanel').dnnTabs();
		});
		Sys.WebForms.PageRequestManager.getInstance().add_endRequest(function ()
		{
			jQuery('#<%= SearchPanel.ClientID %>').dnnPanels();
			jQuery('#RightDetailsViewTabPanel').dnnTabs();
		});
	</script>

</asp:PlaceHolder>
<div>
	<asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
		<ContentTemplate>
			<asp:PlaceHolder ID="MessagePlaceHolder" runat="server" />
			<asp:MultiView ID="ContentMultiView" runat="server">
				<asp:View ID="ListView" runat="server">
					<h2>Rights</h2>
					<asp:Panel ID="SearchPanel" runat="server" DefaultButton="SearchLinkButton" CssClass="dnnForm rvdsfSearchContainer">
						<h2 id="SearchFormSectionHead" class="dnnFormSectionHead">
							<a href="#" class="dnnSectionExpanded">Search</a></h2>
						<fieldset class="rvdSplit2">
							<div class="dnnFormItem">
                                <dnn1:LabelControl runat="server" ID="SellerSearchLabelControl" Text="Seller:" HelpText="View items belonging to a specific seller."></dnn1:LabelControl>
                                <dnn2:DnnComboBox ID="SellerSearchDnnComboBox" runat="server" AllowCustomText="True" EnableLoadOnDemand="True" OnItemsRequested="SellerSearchDnnComboBox_ItemsRequested" AutoPostBack="True" CausesValidation="False" MaxHeight="200px" OnSelectedIndexChanged="SellerSearchDnnComboBox_SelectedIndexChanged"></dnn2:DnnComboBox>
                            </div>
							<div class="dnnFormItem">
								<dnn1:LabelControl runat="server" ID="RightDefinitionSearchLabelControl" Text="Right definition:" />
								<asp:DropDownList ID="RightDefinitionSearchDropDownList" runat="server" />
							</div>
							<div class="dnnFormItem">
								<dnn1:LabelControl runat="server" ID="CodeSearchLabelControl" Text="Code:" HelpText="Enter code to search."></dnn1:LabelControl>
								<asp:TextBox ID="CodeSearchTextBox" runat="server"></asp:TextBox>
							</div>
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
						<asp:GridView ID="RightGridView" runat="server" CssClass="dnnGrid" GridLines="None" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="RightID" OnRowDeleting="RightGridView_RowDeleting" OnRowDataBound="RightGridView_RowDataBound">
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
								<asp:BoundField DataField="Code" HeaderText="Code" SortExpression="Code" />
								<asp:BoundField DataField="IssueDate" HeaderText="Issue date" SortExpression="IssueDate" DataFormatString="{0:yyyy-MM-dd}" />
							</Columns>
						</asp:GridView>
						<asp:ObjectDataSource ID="RightObjectDataSource" runat="server" EnablePaging="True" SelectCountMethod="GetCount" SelectMethod="GetAll" SortParameterName="sortExpression" TypeName="Revindex.Business.Revindex.Revindex.Storefront.RightController">
							<SelectParameters>
								<asp:Parameter Name="sortExpression" Type="String" />
								<asp:Parameter Name="maximumRows" Type="Int32" />
								<asp:Parameter Name="startRowIndex" Type="Int32" />
								<rvd1:UserControlParameter Name="portalID" PropertyName="PortalId" Type="Int32" />
								<asp:ControlParameter ControlID="SellerSearchDnnComboBox" Name="sellerID" PropertyName="SelectedValue" Type="Int32" />
								<asp:ControlParameter ControlID="RightDefinitionSearchDropDownList" Name="rightDefinitionID" PropertyName="SelectedValue" Type="Int32" />
								<asp:ControlParameter ControlID="UsernameSearchTextBox" Name="username" PropertyName="Text" Type="String" />
								<asp:ControlParameter ControlID="CodeSearchTextBox" Name="code" PropertyName="Text" Type="String" />
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
					<h2>Right: <uc1:BreadcrumbControl ID="BreadcrumbControl" runat="server" /></h2>
					<div id="RightDetailsViewTabPanel" class="dnnForm">
						<ul class="dnnAdminTabNav dnnClear">
							<li><a href="#<%= GeneralDetailsViewPanel.ClientID %>">
								<asp:Label ID="GeneralDetailsViewTabLabel" runat="server" Text="General" /></a></li>
							<li><a href="#<%= NotesDetailsViewPanel.ClientID %>">
								<asp:Label ID="NotesDetailsViewTabLabel" runat="server" Text="Notes" /></a></li>
						</ul>
						<asp:Panel ID="GeneralDetailsViewPanel" runat="server" CssClass="dnnClear">
							<fieldset>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="RightIDLabelControl" runat="server" Text="Right ID:" />
									<asp:Label runat="server" ID="RightIDLabel"></asp:Label>
								</div>
								<asp:Panel ID="SellerPanel" runat="server" CssClass="dnnFormItem">
                                    <dnn1:LabelControl ID="SellerLabelControl" runat="server" HelpText="Enter the name if this item belongs to a seller." Text="Seller:" />
                                    <dnn2:DnnComboBox ID="SellerDnnComboBox" runat="server" AllowCustomText="True" EnableLoadOnDemand="True" OnItemsRequested="SellerDnnComboBox_ItemsRequested" AutoPostBack="True" CausesValidation="False" MaxHeight="200px" OnSelectedIndexChanged="SellerDnnComboBox_SelectedIndexChanged"></dnn2:DnnComboBox>
                                </asp:Panel>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="CodeLabelControl" runat="server" Text="Code:" CssClass="dnnFormRequired"/>
									<asp:RequiredFieldValidator ID="CodeRequiredFieldValidator" runat="server" ControlToValidate="CodeTextBox" Display="Dynamic" CssClass="dnnFormMessage dnnFormError" ValidationGroup="RightDetailsViewControl" >Code is required.</asp:RequiredFieldValidator>
									<asp:TextBox ID="CodeTextBox" runat="server" TextMode="MultiLine" Rows="10" MaxLength="450"></asp:TextBox>
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="RightDefinitionLabelControl" runat="server" Text="Right definition:" CssClass="dnnFormRequired"/>
									<asp:RequiredFieldValidator ID="RightDefinitionRequiredFieldValidator" runat="server" ControlToValidate="RightDefinitionDropDownList" Display="Dynamic" CssClass="dnnFormMessage dnnFormError" ValidationGroup="RightDetailsViewControl" >Right definition is required.</asp:RequiredFieldValidator>
									<asp:DropDownList ID="RightDefinitionDropDownList" runat="server">
									</asp:DropDownList>
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="AssignedUserIDLabelControl" runat="server" HelpText="The username assigned to this right." Text="Assigned user:"></dnn1:LabelControl>
									<asp:TextBox ID="AssignedUserIDTextBox" runat="server"></asp:TextBox>
									<asp:HyperLink ID="AssignedUserIDHyperLink" runat="server" CssClass="rvdLinkAction" Text="Edit"></asp:HyperLink>
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="IssueDateLabelControl" runat="server" HelpText="Date when right was issued." Text="Issue date:" />
									<asp:Label ID="IssueDateLabel" runat="server" Text=""></asp:Label>
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="SalesOrderDetailIDLabelControl" runat="server" HelpText="The associated sales order detail that created this right." Text="Sales order detail ID:"></dnn1:LabelControl>
									<asp:HyperLink ID="SalesOrderDetailIDHyperLink" runat="server" Text=""></asp:HyperLink>
								</div>
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
								<asp:LinkButton ID="SaveLinkButton" runat="server" Text="Save" OnClick="SaveLinkButton_Click" CssClass="dnnPrimaryAction rvdSaveAction" ValidationGroup="RightDetailsViewControl" />
							</li>
							<li>
								<asp:LinkButton ID="SaveAndBackLinkButton" runat="server" Text="Save & return" OnClick="SaveLinkButton_Click" CommandArgument="Back" CssClass="dnnPrimaryAction rvdSaveAction" ValidationGroup="RightDetailsViewControl" />
							</li>
							<li>
								<uc1:BackControl ID="BackControl1" runat="server" Text="Cancel" />
							</li>
							<li>
								<asp:LinkButton ID="EmailRightReceiptLinkButton" runat="server" Text="Email right receipt" OnClick="EmailRightReceiptLinkButton_Click" CssClass="dnnSecondaryAction rvdEmailAction" ValidationGroup="RightDetailsViewControl" />
							</li>
						</ul>
					</div>
				</asp:View>
			</asp:MultiView>
		</ContentTemplate>
	</asp:UpdatePanel>
</div>
