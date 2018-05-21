<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="VoucherControl.ascx.cs" Inherits="Revindex.Dnn.RevindexStorefront.VoucherControl" %>
<%@ Register Src="~/Controls/labelcontrol.ascx" TagName="LabelControl" TagPrefix="dnn1" %>
<%@ Register Assembly="DotNetNuke.Web.Deprecated" Namespace="DotNetNuke.Web.UI.WebControls" TagPrefix="dnn2" %>
<%@ Register Assembly="Revindex.Web.UI.WebControls" Namespace="Revindex.Web.UI.WebControls" TagPrefix="rvd1" %>
<%@ Register Src="VoucherHistoryControl.ascx" TagName="VoucherHistoryControl" TagPrefix="uc1" %>
<%@ Register Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Src="WebUserControls/Common/Dnn/BackControl.ascx" TagName="BackControl" TagPrefix="uc1" %>
<%@ Register Src="WebUserControls/Common/Dnn/BreadcrumbControl.ascx" TagName="BreadcrumbControl" TagPrefix="uc1" %>
<asp:PlaceHolder runat="server">

	<script type="text/javascript">
		jQuery(document).ready(function ()
		{
			jQuery('#<%= SearchPanel.ClientID %>').dnnPanels();
			jQuery('#VoucherDetailsViewTabPanel').dnnTabs();
		});
		Sys.WebForms.PageRequestManager.getInstance().add_endRequest(function ()
		{
			jQuery('#<%= SearchPanel.ClientID %>').dnnPanels();
			jQuery('#VoucherDetailsViewTabPanel').dnnTabs();
		});
	</script>

</asp:PlaceHolder>
<div>
	<asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
		<ContentTemplate>
			<asp:PlaceHolder ID="MessagePlaceHolder" runat="server" />
			<asp:MultiView ID="ContentMultiView" runat="server">
				<asp:View ID="ListView" runat="server">
					<h2>Vouchers</h2>
					<asp:Panel ID="SearchPanel" runat="server" DefaultButton="SearchLinkButton" CssClass="dnnForm rvdsfSearchContainer">
						<h2 id="SearchFormSectionHead" class="dnnFormSectionHead">
							<a href="#" class="dnnSectionExpanded">Search</a></h2>
						<fieldset class="rvdSplit2">
							<div class="dnnFormItem">
								<dnn1:LabelControl runat="server" ID="CodeSearchLabelControl" Text="Voucher code:" HelpText="Enter voucher code to search."></dnn1:LabelControl>
								<asp:TextBox ID="CodeSearchTextBox" runat="server"></asp:TextBox>
							</div>
							<div class="dnnFormItem">
								<dnn1:LabelControl runat="server" ID="VoucherDefinitionSearchLabelControl" Text="Voucher definition:" />
								<asp:DropDownList ID="VoucherDefinitionSearchDropDownList" runat="server" />
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
						<asp:GridView ID="VoucherGridView" runat="server" CssClass="dnnGrid" GridLines="None" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="VoucherID" OnRowDeleting="VoucherGridView_RowDeleting" OnRowDataBound="VoucherGridView_RowDataBound">
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
								<asp:BoundField DataField="Amount" HeaderText="Amount" SortExpression="Amount" />
								<asp:BoundField DataField="Status" HeaderText="Status" SortExpression="Status" />
								<asp:BoundField DataField="IssueDate" HeaderText="Issue date" SortExpression="IssueDate" DataFormatString="{0:yyyy-MM-dd}" />
							</Columns>
						</asp:GridView>
						<asp:ObjectDataSource ID="VoucherObjectDataSource" runat="server" EnablePaging="True" SelectCountMethod="GetCount" SelectMethod="GetAll" SortParameterName="sortExpression" TypeName="Revindex.Dnn.RevindexStorefront.VoucherControl">
							<SelectParameters>
								<asp:Parameter Name="sortExpression" Type="String" />
								<asp:Parameter Name="maximumRows" Type="Int32" />
								<asp:Parameter Name="startRowIndex" Type="Int32" />
								<asp:Parameter Name="deleted" Type="Boolean" DefaultValue="false"></asp:Parameter>
								<rvd1:UserControlParameter Name="portalID" PropertyName="PortalId" Type="Int32" />
								<asp:ControlParameter ControlID="CodeSearchTextBox" Name="code" PropertyName="Text" Type="String" />
								<asp:ControlParameter ControlID="UsernameSearchTextBox" Name="username" PropertyName="Text" Type="String" />
								<asp:ControlParameter ControlID="VoucherDefinitionSearchDropDownList" Name="voucherDefinitionID" PropertyName="SelectedValue" Type="Int32" />
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
					<h2>Voucher: <uc1:BreadcrumbControl ID="BreadcrumbControl" runat="server" /></h2>
					<div id="VoucherDetailsViewTabPanel" class="dnnForm">
						<ul class="dnnAdminTabNav dnnClear">
							<li><a href="#<%= GeneralDetailsViewPanel.ClientID %>">
								<asp:Label ID="GeneralDetailsViewTabLabel" runat="server" Text="General" /></a></li>
							<li><a href="#<%= NotesDetailsViewPanel.ClientID %>">
								<asp:Label ID="NotesDetailsViewTabLabel" runat="server" Text="Notes" /></a></li>
							<li><a href="#<%= HistoryDetailsViewPanel.ClientID %>">
								<asp:Label ID="HistoryDetailsViewTabLabel" runat="server" Text="History" /></a></li>
						</ul>
						<asp:Panel ID="GeneralDetailsViewPanel" runat="server" CssClass="dnnClear">
							<fieldset>
								<asp:Panel ID="QuantityPanel" runat="server" CssClass="dnnFormItem">
									<dnn1:LabelControl ID="QuantityLabelControl" runat="server" Text="Quantity:" HelpText="Enter the number of vouchers to generate at once." />
									<asp:RequiredFieldValidator ID="QuantityRequiredFieldValidator" runat="server" ControlToValidate="QuantityDnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="VoucherDetailsViewControl">Quantity is required.</asp:RequiredFieldValidator>
									<dnn2:DnnNumericTextBox ID="QuantityDnnNumericTextBox" runat="server" Skin="" NumberFormat-DecimalDigits="0" NumberFormat-GroupSizes="9" MinValue="1" EnableSingleInputRendering="False" CssClass="rvdQuantityInput" Value="1" />
								</asp:Panel>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="VoucherIDLabelControl" runat="server" Text="Voucher ID:" />
									<asp:Label runat="server" ID="VoucherIDLabel"></asp:Label>
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="CodeLabelControl" runat="server" Text="Code:" />
									<asp:Label runat="server" ID="CodeLabel"></asp:Label>
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="VoucherDefinitionLabelControl" runat="server" Text="Voucher definition:" />
									<asp:DropDownList ID="VoucherDefinitionDropDownList" runat="server" OnSelectedIndexChanged="VoucherDefinitionDropDownList_SelectedIndexChanged" AutoPostBack="True">
									</asp:DropDownList>
									<asp:Label ID="VoucherDefinitionLabel" runat="server" Text=""></asp:Label>
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="StatusLabelControl" runat="server" Text="Status:" />
									<asp:DropDownList ID="StatusDropDownList" runat="server">
										<asp:ListItem Text="Active" Value="2" />
										<asp:ListItem Text="Inactive" Value="1" />
										<asp:ListItem Text="Hold" Value="3" />
										<asp:ListItem Text="Cancelled" Value="4" />
									</asp:DropDownList>
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="AssignedUserIDLabelControl" runat="server" HelpText="The username assigned to this voucher. Only the assigned user can redeem the voucher if the associated voucher definition is marked as non-transferable. Leave blank if you don't want to associate the voucher to a user." Text="Assigned user:"></dnn1:LabelControl>
									<asp:TextBox ID="AssignedUserIDTextBox" runat="server"></asp:TextBox>
									<asp:HyperLink ID="AssignedUserIDHyperLink" runat="server" CssClass="rvdLinkAction" Text="Edit"></asp:HyperLink>
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="InitialAmountLabelControl" runat="server" HelpText="The voucher starting balance amount." Text="Initial amount:"></dnn1:LabelControl>
									<asp:Label ID="InitialAmountLabel" runat="server" Text=""></asp:Label>
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="AmountLabelControl" runat="server" HelpText="Enter the voucher balance amount without the money symbol. (e.g. 10.50)" Text="Amount:" CssClass="dnnFormRequired"></dnn1:LabelControl>
									<asp:RequiredFieldValidator ID="AmountRequiredFieldValidator" runat="server" ControlToValidate="AmountDnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="VoucherDetailsViewControl">Amount is required.</asp:RequiredFieldValidator>
									<dnn2:DnnNumericTextBox ID="AmountDnnNumericTextBox" runat="server" Skin="" NumberFormat-DecimalDigits="4" NumberFormat-GroupSizes="9" EnableSingleInputRendering="False" Value="0.00" CssClass="dnnFormRequired">
									</dnn2:DnnNumericTextBox>
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="PromotionAmountLabelControl" runat="server" HelpText="The actual amount available for this voucher if voucher promotion is applied." Text="Promotion amount:" />
									<asp:Label ID="PromotionAmountLabel" runat="server" Text=""></asp:Label>
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="IssueDateLabelControl" runat="server" HelpText="Date when voucher was issued." Text="Issue date:" />
									<asp:Label ID="IssueDateLabel" runat="server" Text=""></asp:Label>
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="ExpiryDateLabelControl" runat="server" HelpText="The expiry date." Text="Expire:"></dnn1:LabelControl>
									<asp:Label ID="ExpiryDateLabel" runat="server" Text=""></asp:Label>
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="SalesOrderDetailIDLabelControl" runat="server" HelpText="The associated sales order detail that created this voucher." Text="Sales order detail ID:"></dnn1:LabelControl>
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
						<asp:Panel ID="HistoryDetailsViewPanel" runat="server" CssClass="dnnClear">
							<fieldset>
								<uc1:VoucherHistoryControl ID="VoucherHistoryControl1" runat="server"></uc1:VoucherHistoryControl>
							</fieldset>
						</asp:Panel>
					</div>
					<div class="dnnForm">
						<ul class="dnnActions">
							<li>
								<asp:LinkButton ID="SaveLinkButton" runat="server" Text="Save" OnClick="SaveLinkButton_Click" CssClass="dnnPrimaryAction rvdSaveAction" ValidationGroup="VoucherDetailsViewControl" />
							</li>
							<li>
								<asp:LinkButton ID="SaveAndBackLinkButton" runat="server" Text="Save & return" OnClick="SaveLinkButton_Click" CommandArgument="Back" CssClass="dnnPrimaryAction rvdSaveAction" ValidationGroup="VoucherDetailsViewControl" />
							</li>
							<li>
								<uc1:BackControl ID="BackControl1" runat="server" Text="Cancel" />
							</li>
							<li>
								<asp:LinkButton ID="EmailVoucherReceiptLinkButton" runat="server" Text="Email voucher receipt" OnClick="EmailVoucherReceiptLinkButton_Click" CssClass="dnnSecondaryAction rvdEmailAction" ValidationGroup="VoucherDetailsViewControl" />
							</li>
						</ul>
					</div>
				</asp:View>
			</asp:MultiView>
		</ContentTemplate>
	</asp:UpdatePanel>
</div>
