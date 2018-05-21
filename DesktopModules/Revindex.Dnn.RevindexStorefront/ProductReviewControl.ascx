<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ProductReviewControl.ascx.cs" Inherits="Revindex.Dnn.RevindexStorefront.ProductReviewControl" %>
<%@ Register Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Src="~/Controls/labelcontrol.ascx" TagName="LabelControl" TagPrefix="dnn1" %>
<%@ Register Assembly="DotNetNuke.Web.Deprecated" Namespace="DotNetNuke.Web.UI.WebControls" TagPrefix="dnn2" %>
<%@ Register Assembly="Revindex.Web.UI.WebControls" Namespace="Revindex.Web.UI.WebControls" TagPrefix="rvd1" %>
<%@ Register Src="WebUserControls/Common/Dnn/BackControl.ascx" TagName="BackControl" TagPrefix="uc1" %>
<%@ Register Src="WebUserControls/Common/Dnn/BreadcrumbControl.ascx" TagName="BreadcrumbControl" TagPrefix="uc1" %>
<asp:PlaceHolder ID="PlaceHolder1" runat="server">

	<script type="text/javascript">
		jQuery(document).ready(function ()
		{
			jQuery('#ProductReviewDetailsViewTabPanel').dnnTabs();
		});
		Sys.WebForms.PageRequestManager.getInstance().add_endRequest(function ()
		{
			jQuery('#ProductReviewDetailsViewTabPanel').dnnTabs();
		});
	</script>

</asp:PlaceHolder>
<div>
	<asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
		<ContentTemplate>
			<asp:PlaceHolder ID="MessagePlaceHolder" runat="server" />
			<asp:MultiView ID="ContentMultiView" runat="server">
				<asp:View ID="ListView" runat="server">
					<div class="dnnForm rvdsfListContainer">
						<asp:GridView ID="ProductReviewGridView" runat="server" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="ProductReviewID" CssClass="dnnGrid" GridLines="None" AllowPaging="True" OnRowDeleting="ProductReviewGridView_RowDeleting" OnRowDataBound="ProductReviewGridView_RowDataBound">
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
								<asp:BoundField DataField="CreateDate" HeaderText="Date" SortExpression="CreateDate" DataFormatString="{0:yyyy-MM-dd}" />
								<asp:BoundField DataField="UserID" HeaderText="User" />
								<asp:BoundField DataFormatString="{0}/5" DataField="OverallRating" HeaderText="Rating" SortExpression="OverallRating" />
								<asp:TemplateField HeaderText="Review">
									<ItemTemplate>
										<strong><asp:Label ID="TitleLabel" runat="server"></asp:Label></strong>
										<p>
											<asp:Label ID="CommentLabel" runat="server"></asp:Label>
										</p>
									</ItemTemplate>
								</asp:TemplateField>
								<asp:CheckBoxField DataField="Approved" HeaderText="Approved" SortExpression="Approved" ReadOnly="true" />
							</Columns>
						</asp:GridView>
						<asp:ObjectDataSource ID="ProductReviewObjectDataSource" runat="server" SelectCountMethod="GetProductReviewsCountByProduct" SelectMethod="GetProductReviewsByProduct" TypeName="Revindex.Business.Revindex.Revindex.Storefront.ProductReviewController" EnablePaging="True" SortParameterName="sortExpression">
							<SelectParameters>
								<rvd1:UserControlParameter Name="productID" PropertyName="ProductID" Type="Int32" />
								<asp:Parameter Name="sortExpression" Type="String" />
								<asp:Parameter Name="maximumRows" Type="Int32" />
								<asp:Parameter Name="startRowIndex" Type="Int32" />
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
					<h2>Review: <uc1:BreadcrumbControl ID="BreadcrumbControl" runat="server" /></h2>
					<div id="ProductReviewDetailsViewTabPanel" class="dnnForm">
						<ul class="dnnAdminTabNav dnnClear">
							<li><a href="#<%= GeneralDetailsViewPanel.ClientID %>">
								<asp:Label ID="GeneralDetailsViewTabLabel" runat="server" Text="General" /></a></li>
						</ul>
						<asp:Panel ID="GeneralDetailsViewPanel" runat="server" CssClass="dnnClear">
							<fieldset>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="ProductReviewIDLabelControl" runat="server" Text="Product review ID:" />
									<asp:Label ID="ProductReviewIDLabel" runat="server"></asp:Label>
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="UserHostAddressLabelControl" runat="server" Text="User host address:" />
									<asp:Label ID="UserHostAddressLabel" runat="server"></asp:Label>
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="ApprovedLabelControl" runat="server" Text="Approved:" />
									<asp:CheckBox ID="ApprovedCheckBox" runat="server" />
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="OverallRatingLabelControl" runat="server" Text="Overall rating:" />
									<dnn2:DnnRating ID="OverallRatingDnnRating" CssClass="rvdsfProductDisplayRating" runat="server" Value="0">
									</dnn2:DnnRating>
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="TitleLabelControl" runat="server" Text="Title:" CssClass="dnnFormRequired" />
									<asp:RequiredFieldValidator ID="TitleRequiredFieldValidator" runat="server" ControlToValidate="TitleTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="ProductReviewDetailsViewControl">Title is required.</asp:RequiredFieldValidator>
									<asp:TextBox ID="TitleTextBox" runat="server" MaxLength="50" CssClass="dnnFormRequired"></asp:TextBox>
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="CommentLabelControl" runat="server" Text="Comment:" />
									<asp:TextBox ID="CommentTextBox" runat="server" Rows="8" TextMode="MultiLine"></asp:TextBox>
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="UserTypeLabelControl" runat="server" Text="User type:"></dnn1:LabelControl>
									<asp:RadioButtonList ID="UserTypeRadioButtonList" runat="server" RepeatLayout="Flow" CssClass="dnnFormRadioButtons" AutoPostBack="True" OnSelectedIndexChanged="UserTypeRadioButtonList_SelectedIndexChanged">
										<asp:ListItem Text="Registered user" Value="RegisteredUser" Selected="True" />
										<asp:ListItem Text="Anonymous user" Value="AnonymousUser" />
									</asp:RadioButtonList>
								</div>
								<asp:MultiView ID="UserMultiView" runat="server" ActiveViewIndex="0">
									<asp:View ID="RegisteredUserView" runat="server">
										<div class="dnnFormItem">
											<dnn1:LabelControl ID="UsernameLabelControl" runat="server" Text="User:" CssClass="dnnFormRequired"/>
											<asp:RequiredFieldValidator ID="UsernameRequiredFieldValidator" runat="server" ControlToValidate="UsernameTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="ProductReviewDetailsViewControl">Username is required.</asp:RequiredFieldValidator>
											<asp:TextBox ID="UsernameTextBox" runat="server" CssClass="dnnFormRequired"></asp:TextBox>
										</div>
									</asp:View>
									<asp:View ID="AnonymousUserView" runat="server">
										<div class="dnnFormItem">
											<dnn1:LabelControl ID="EmailLabelControl" runat="server" Text="Email:" />
											<asp:RegularExpressionValidator ID="EmailRegularExpressionValidator" runat="server" ControlToValidate="EmailTextBox" CssClass="dnnFormMessage dnnFormError" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ValidationGroup="ProductReviewDetailsViewControl">Email is invalid.</asp:RegularExpressionValidator>
											<asp:TextBox ID="EmailTextBox" runat="server" MaxLength="256"></asp:TextBox>
										</div>
										<div class="dnnFormItem">
											<dnn1:LabelControl ID="FirstNameLabelControl" runat="server" Text="First name:" />
											<asp:TextBox ID="FirstNameTextBox" runat="server" MaxLength="50"></asp:TextBox>
										</div>
										<div class="dnnFormItem">
											<dnn1:LabelControl ID="LastNameLabelControl" runat="server" Text="Last name:" />
											<asp:TextBox ID="LastNameTextBox" runat="server" MaxLength="50"></asp:TextBox>
										</div>
									</asp:View>
								</asp:MultiView>
							</fieldset>
						</asp:Panel>
					</div>
					<div class="dnnForm">
						<ul class="dnnActions">
							<li>
								<asp:LinkButton ID="SaveLinkButton" runat="server" Text="Save" OnClick="SaveLinkButton_Click" CssClass="dnnPrimaryAction rvdSaveAction" ValidationGroup="ProductReviewDetailsViewControl" />
							</li>
							<li>
								<asp:LinkButton ID="SaveAndBackLinkButton" runat="server" Text="Save & return" OnClick="SaveLinkButton_Click" CommandArgument="Back" CssClass="dnnPrimaryAction rvdSaveAction" ValidationGroup="ProductReviewDetailsViewControl" />
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
