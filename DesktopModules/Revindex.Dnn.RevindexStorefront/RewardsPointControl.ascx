<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="RewardsPointControl.ascx.cs" Inherits="Revindex.Dnn.RevindexStorefront.RewardsPointControl" %>
<%@ Register Src="~/Controls/labelcontrol.ascx" TagName="LabelControl" TagPrefix="dnn1" %>
<%@ Register Assembly="DotNetNuke.Web.Deprecated" Namespace="DotNetNuke.Web.UI.WebControls" TagPrefix="dnn2" %>
<%@ Register Assembly="Revindex.Web.UI.WebControls" Namespace="Revindex.Web.UI.WebControls" TagPrefix="rvd1" %>
<%@ Register Src="RewardsPointHistoryControl.ascx" TagName="RewardsPointHistoryControl" TagPrefix="uc1" %>
<%@ Register Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Src="WebUserControls/Common/Dnn/BackControl.ascx" TagName="BackControl" TagPrefix="uc1" %>
<%@ Register Src="WebUserControls/Common/Dnn/BreadcrumbControl.ascx" TagName="BreadcrumbControl" TagPrefix="uc1" %>
<asp:PlaceHolder runat="server">

	<script type="text/javascript">
		jQuery(document).ready(function ()
		{
			jQuery('#<%= SearchPanel.ClientID %>').dnnPanels();
			jQuery('#RewardsPointDetailsViewTabPanel').dnnTabs();
		});
		Sys.WebForms.PageRequestManager.getInstance().add_endRequest(function ()
		{
			jQuery('#<%= SearchPanel.ClientID %>').dnnPanels();
			jQuery('#RewardsPointDetailsViewTabPanel').dnnTabs();
		});
	</script>

</asp:PlaceHolder>
<div>
	<asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
		<ContentTemplate>
			<asp:PlaceHolder ID="MessagePlaceHolder" runat="server" />
			<asp:MultiView ID="ContentMultiView" runat="server">
				<asp:View ID="ListView" runat="server">
					<h2>Rewards points</h2>
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
						<asp:GridView ID="RewardsPointGridView" runat="server" CssClass="dnnGrid" GridLines="None" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="RewardsPointID" OnRowDeleting="RewardsPointGridView_RowDeleting" OnRowDataBound="RewardsPointGridView_RowDataBound">
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
								<asp:BoundField DataField="UserID" HeaderText="User" />
								<asp:BoundField DataField="Points" HeaderText="Points" SortExpression="Points" />
								<asp:BoundField DataField="Status" HeaderText="Status" SortExpression="Status" />
							</Columns>
						</asp:GridView>
						<asp:ObjectDataSource ID="RewardsPointObjectDataSource" runat="server" EnablePaging="True" SelectCountMethod="GetCount" SelectMethod="GetAll" SortParameterName="sortExpression" TypeName="Revindex.Business.Revindex.Revindex.Storefront.RewardsPointController">
							<SelectParameters>
								<asp:Parameter Name="sortExpression" Type="String" />
								<asp:Parameter Name="maximumRows" Type="Int32" />
								<asp:Parameter Name="startRowIndex" Type="Int32" />
								<rvd1:UserControlParameter Name="portalID" PropertyName="PortalId" Type="Int32" />
								<asp:ControlParameter ControlID="UsernameSearchTextBox" Name="username" PropertyName="Text" Type="String" />
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
					<uc1:BackControl ID="QuickBackControl" runat="server" Text="" CssClass="rvdsfBackAction" />
					<h2>Rewards point: <uc1:BreadcrumbControl ID="BreadcrumbControl" runat="server" /></h2>
					<div id="RewardsPointDetailsViewTabPanel" class="dnnForm">
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
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="RewardsPointIDLabelControl" runat="server" Text="Rewards Point ID:" />
									<asp:Label runat="server" ID="RewardsPointIDLabel"></asp:Label>
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
									<dnn1:LabelControl ID="UserIDLabelControl" runat="server" HelpText="The username assigned to this reward. Only the assigned user can redeem the reward." Text="User:"></dnn1:LabelControl>
									<asp:RequiredFieldValidator ID="UserIDRequiredFieldValidator" runat="server" ControlToValidate="UserIDTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="RewardsPointDetailsViewControl">Username is required.</asp:RequiredFieldValidator>
									<asp:TextBox ID="UserIDTextBox" runat="server"></asp:TextBox>
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="PointsLabelControl" runat="server" HelpText="Enter the current number of points accumulated" Text="Points:" CssClass="dnnFormRequired"></dnn1:LabelControl>
									<asp:RequiredFieldValidator ID="PointsRequiredFieldValidator" runat="server" ControlToValidate="PointsDnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="RewardsPointDetailsViewControl">Value is required.</asp:RequiredFieldValidator>
									<dnn2:DnnNumericTextBox ID="PointsDnnNumericTextBox" runat="server" Skin="" NumberFormat-DecimalDigits="0" NumberFormat-GroupSizes="9" EnableSingleInputRendering="False" Value="0" MinValue="0" CssClass="dnnFormRequired">
									</dnn2:DnnNumericTextBox>
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="ExpiryDateLabelControl" runat="server" HelpText="The expiry date." Text="Expire:"></dnn1:LabelControl>
									<asp:Label ID="ExpiryDateLabel" runat="server" Text=""></asp:Label>
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
								<uc1:RewardsPointHistoryControl ID="RewardsPointHistoryControl1" runat="server"></uc1:RewardsPointHistoryControl>
							</fieldset>
						</asp:Panel>
					</div>
					<div class="dnnForm">
						<ul class="dnnActions">
							<li>
								<asp:LinkButton ID="SaveLinkButton" runat="server" Text="Save" OnClick="SaveLinkButton_Click" CssClass="dnnPrimaryAction rvdSaveAction" ValidationGroup="RewardsPointDetailsViewControl" />
							</li>
							<li>
								<asp:LinkButton ID="SaveAndBackLinkButton" runat="server" Text="Save & return" OnClick="SaveLinkButton_Click" CommandArgument="Back" CssClass="dnnPrimaryAction rvdSaveAction" ValidationGroup="RewardsPointDetailsViewControl" />
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
