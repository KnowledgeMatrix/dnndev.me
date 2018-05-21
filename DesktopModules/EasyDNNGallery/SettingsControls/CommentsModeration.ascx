<%@ control language="C#" autoeventwireup="true" inherits="EasyDNN.Modules.EasyDNNGallery.CommentsModeration, App_Web_commentsmoderation.ascx.d6cf3db9" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<script type="text/javascript">
	function SelectAllMedia() {
		eds1_10('#<%=gvComments.ClientID%> span.EGMediaSelect > input').each(function () {
			this.checked = true;
		});
	}
	function DeselectAllMedia() {
		eds1_10('#<%=gvComments.ClientID%> span.EGMediaSelect > input').each(function () {
			this.checked = false;
		});
	}
	function ConfirmApprove() {
		var result = confirm('<%=Localization.GetString("AreYouSure", this.LocalResourceFile)%>');
		if (!result) {
			eds1_10('#<%=lblCommentsModertionMessage.ClientID%>').removeClass().text('');
		}
		return result;
	};
</script>
<div id="divMainContainer" runat="server">
	<div id="EDGAdminContent">
		<div class="flashMessages"></div>
		<div class="topBarWrapper">
			<div class="wrapper">
				<ul class="links">
					<li>
						<span><%=strCommentsModeration%></span>
					</li>
				</ul>
				<ul class="actions">
					<li class="close">
						<asp:HyperLink ID="hlPowerOff" runat="server" ToolTip="Close" resourcekey="lbExit">Exit</asp:HyperLink>
					</li>
				</ul>
			</div>
		</div>
		<div class="mainContentWrapper">
			<div class="contentSectionWrapper color3">
				<div class="sectionHeader onlyTitleAndNumber">
					<div class="titleAndNumber mediaManagerTitleAndNumber">
						<h4>
							<asp:Label ID="lblCommentsModerationTitle" resourcekey="lblCommentsModerationTitle" runat="server" Text="Comments Moderation"></asp:Label>
						</h4>
						<p>
							<asp:Label ID="lblMainTagline" ResourceKey="lblMainTagline" runat="server" Text="Manage comments."></asp:Label>
						</p>
					</div>
				</div>
				<div class="listItems">
					<asp:Panel ID="pnlFilterMedia" runat="server">
						<table style="margin:10px;">
							<tr>
								<td style="width:25%;height:45px;">
									<asp:Label ID="lblFilterByGallery" ResourceKey="lblFilterByGallery" runat="server" Text="Filter by gallery:" />
								</td>
								<td>
									<div class="styledSelect">
										<asp:DropDownList ID="ddlGalleryList" runat="server" AutoPostBack="True" DataTextField="Title" DataValueField="GalleryID" AppendDataBoundItems="True" OnSelectedIndexChanged="ddlGalleryList_SelectedIndexChanged">
										</asp:DropDownList>
									</div>
								</td>
							</tr>
							<tr runat="server" id="trFilterByMedia" visible="false" style="border-top:solid 1px #E9E9E9;border-bottom:solid 1px #E9E9E9;">
								<td>
									<asp:Label ID="lblFilteringBy" ResourceKey="lblFilteringBy" runat="server" Text="Filtering by:" />
								</td>
								<td style="padding:10px">
									<asp:HyperLink ID="hlFilteringMediaOpen" runat="server" Target="_blank" CssClass="thumbnail">
										<asp:Image ID="imgFilteringMediaThumbnail" runat="server" Width="100" Height="100" />
									</asp:HyperLink>
								</td>
							</tr>
							<tr>
								<td style="height:45px;">
									<asp:Label ID="lblShowOnlyUnapprovedComment" ResourceKey="lblShowOnlyUnapprovedComment" runat="server" Text="Show only unapproved comments:" />
								</td>
								<td>
									<div class="styledCheckbox noLabel">
										<asp:CheckBox ID="cbShowOnlyUnapprovedComment" runat="server" AutoPostBack="True" OnCheckedChanged="cbShowOnlyUnapprovedComment_CheckedChanged" Text="Show only unapproved comments" />
									</div>
								</td>
							</tr>
						</table>
					</asp:Panel>
					<asp:Label ID="lblCommentsModertionMessage" runat="server" AssociatedControlID="gvComments" EnableViewState="False"></asp:Label>
					<asp:GridView ID="gvComments" CssClass="listItemsTable" runat="server" AllowPaging="True" AutoGenerateColumns="False" border="0" CellPadding="0" DataKeyNames="CommentID" DataSourceID="odsGetComments" GridLines="None" ShowFooter="True" EnableModelValidation="True" OnRowDeleted="gvComments_RowDeleted" OnRowUpdated="gvComments_RowUpdated" OnPreRender="gvComments_PreRender" OnRowCommand="gvComments_RowCommand">
						<Columns>
							<asp:TemplateField ShowHeader="False">
								<ItemTemplate>
									<div class="styledCheckbox noLabel">
										<asp:CheckBox ID="cbMediaSelected" CssClass="EGMediaSelect" runat="server" Text="Select" />
									</div>
								</ItemTemplate>
								<FooterTemplate>
									<div class="itemActions footerActions">
										<asp:LinkButton ID="lbSelectAll" CssClass="btnsaveposition" resourcekey="lbSelectAll" OnClientClick="SelectAllMedia(); return false;" runat="server" Text="Select all"></asp:LinkButton>
										<asp:LinkButton ID="lbDeSelectAll" CssClass="btnsaveposition" resourcekey="lbDeSelectAll" OnClientClick="DeselectAllMedia(); return false;" runat="server" Text="Deselect all"></asp:LinkButton>
									</div>
									<div class="itemActions bulkActions">
										<asp:LinkButton ID="btnBulkApprove" runat="server" resourcekey="btnBulkApprove" OnClick="btnBulkApprove_Click" OnClientClick="return ConfirmApprove();" Text="Approve" CssClass="bulkApprove" />
										<asp:LinkButton ID="btnBulkUnapprove" runat="server" resourcekey="btnBulkUnapprove" OnClick="btnBulkUnapprove_Click" OnClientClick="return ConfirmApprove();" Text="Approve" CssClass="bulkUnapprove" />
										<asp:LinkButton ID="btnBulkDelete" runat="server" resourcekey="btnBulkDelete" OnClick="btnBulkDelete_Click" OnClientClick="return ConfirmApprove();" Text="Delete" CssClass="bulkDelete" />
									</div>
								</FooterTemplate>
							</asp:TemplateField>
							<asp:TemplateField HeaderText="Actions" InsertVisible="False" ShowHeader="False">
								<EditItemTemplate>
									<div class="itemActions itemEditActions">
										<asp:LinkButton ID="lbCommentUpdate" runat="server" resourcekey="lbCommentUpdate" CommandName="Update" Text="Update" CssClass="itemEditUpdate"></asp:LinkButton>
										<asp:LinkButton ID="lbCommentCancel" runat="server" resourcekey="lbCommentCancel" CausesValidation="False" CommandName="Cancel" Text="Cancel" CssClass="itemEditCancel"></asp:LinkButton>
									</div>
								</EditItemTemplate>
								<ItemTemplate>
									<asp:HiddenField ID="hfCommentID" runat="server" Value='<%#((DataRowView)Container.DataItem)["CommentID"]%>' />
									<div class="itemActions itemPrimaryActions paddingBottom">
										<asp:LinkButton ID="lbCommentApprove" runat="server" resourcekey="lbCommentApprove" CausesValidation="False" CommandName="Approve" CommandArgument='<%#((DataRowView)Container.DataItem)["CommentID"]%>' Text="Approve" CssClass="approveAction" Visible='<%#!Convert.ToBoolean(Eval("Approved"))%>'></asp:LinkButton>
										<asp:LinkButton ID="lbCommentUnApprove" runat="server" resourcekey="lbCommentUnApprove" CausesValidation="False" CommandName="Unapprove" CommandArgument='<%#((DataRowView)Container.DataItem)["CommentID"]%>' Text="Approve" CssClass="unApproveAction" Visible='<%#Convert.ToBoolean(Eval("Approved"))%>'></asp:LinkButton>
									</div>
									<div class="itemActions itemPrimaryActions">
										<asp:LinkButton ID="lbCommentEdit" runat="server" resourcekey="lbCommentEdit" CausesValidation="False" CommandName="Edit" Text="Edit" CssClass="editAction" Visible="<%#permissions.CommentEditing%>"></asp:LinkButton>
										<asp:LinkButton ID="lbCommentDelete" runat="server" resourcekey="lbCommentDelete" CommandName="Delete" OnClientClick="return confirm('Are you sure you want to delete this comment?');" Text="Delete" CssClass="deleteAction" Visible="<%#permissions.CommentDeleting%>"></asp:LinkButton>
									</div>
								</ItemTemplate>
								<ItemStyle CssClass="actionsCell" />
							</asp:TemplateField>
							<asp:TemplateField HeaderText="Thumbnail">
								<ItemTemplate>
									<asp:HyperLink ID="hlMediaThumbnailOpen" runat="server" NavigateUrl='<%#EditUrl("","","CommentsModeration", new string[] {SocialParams, Request.QueryString["unapproved"] != null && Request.QueryString["unapproved"] == "true" ? "unapproved=true":"","galleryid=" + Eval("GalleryID"), "pictureid=" + Eval("PictureID"), "mid=" + ModuleId }) + EasyDNN.Modules.EasyDNNGallery.Common.General.GetNoSkinQueryString()%>' Target="_self" CssClass="thumbnail">
										<asp:Image ID="imgMediaThumbnail" runat="server" Width='<%#GetWidth(Eval("Info"))%>' Height='<%#GetHeight(Eval("Info"))%>' ImageUrl='<%# GetThumbnailURL(Eval("ThumbUrl"),Eval("Info"),Eval("FileName")) %>' />
									</asp:HyperLink>
									<div class="itemActions itemSecondaryActions">
										<asp:HyperLink ID="hlFilterByThisImage" runat="server" resourcekey="hlFilterByThisImage" NavigateUrl='<%#EditUrl("","", "CommentsModeration", new string[] {SocialParams, Request.QueryString["unapproved"] != null && Request.QueryString["unapproved"] == "true" ? "unapproved=true":"","galleryid=" + Eval("GalleryID"), "pictureid=" + Eval("PictureID"), "mid=" + ModuleId }) + EasyDNN.Modules.EasyDNNGallery.Common.General.GetNoSkinQueryString()%>' Target="_self" Text="Filter comments"></asp:HyperLink>
										<asp:HyperLink ID="hlViewMedia" runat="server" resourcekey="hlViewMedia" NavigateUrl='<%#GetMediaUrl(((DataRowView)Container.DataItem)["PictureID"])%>' Target="_blank" Text="View media"></asp:HyperLink>
									</div>
								</ItemTemplate>
								<ItemStyle CssClass="thumbnailCell" />
							</asp:TemplateField>
							<asp:TemplateField HeaderText="Author">
								<ItemTemplate>
									<asp:LinkButton ID="lbCategoriesOpenCategoryName" runat="server" CssClass="categorycontrollinklight" Text='<%# String.Format("<a href=\"mailto:{0}\" >{1}</a>",Eval("CommentersEmail"),Eval("CommentersName"))%>'></asp:LinkButton>
								</ItemTemplate>
								<HeaderStyle Width="150" />
							</asp:TemplateField>
							<asp:TemplateField HeaderText="Comment">
								<EditItemTemplate>
									<asp:TextBox ID="tbCommentnEdit" runat="server" Text='<%# Bind("RawComment") %>' TextMode="MultiLine" MaxLength="2000" Height="85" Width="350"></asp:TextBox>
								</EditItemTemplate>
								<ItemTemplate>
									<asp:Label ID="lblComment" runat="server" Text='<%# ((DataRowView)Container.DataItem)["FormatedComment"] %>'></asp:Label>
								</ItemTemplate>
								<HeaderStyle Width="490" />
							</asp:TemplateField>
							<asp:TemplateField HeaderText="Stats">
								<ItemTemplate>
									<p>
										<strong><%=created%></strong>
										<%# EasyDNN.Modules.EasyDNNGallery.DateTimeHelpers.GetTimeFromUtc(Convert.ToDateTime(Eval("DateAdded")), PortalSettings)%>
									</p>
									<p>
										<strong><%=upVotes%></strong>
										<%# Eval("GoodVotes") %>
									</p>
									<p>
										<strong><%=downVotes%></strong>
										<%# Eval("BadVotes") %>
									</p>
									<p>
										<strong><%=numberOfReplayCommetns%></strong>
										<%# Eval("ReplayCommentsCount") %>
									</p>
								</ItemTemplate>
								<ItemStyle CssClass="lastModified" />
							</asp:TemplateField>
						</Columns>
						<FooterStyle CssClass="itemsListFooter" />
						<HeaderStyle CssClass="itemsListheader" />
						<PagerStyle CssClass="contentPagination" />
						<EditRowStyle CssClass="editItemState" />
					</asp:GridView>
					<div runat="server" id="numberOfItemsPerPage" class="numberOfItemsPerPage">
						<dnn:Label ID="lblNumberOfMediaPerPage" runat="server" Text="Items per page:" HelpText="Select the number of items to display on one page." ResourceKey="lblNumberOfMediaPerPage" CssClass="labeltext"></dnn:Label>
						<div class="styledSelect">
							<asp:DropDownList ID="ddlImagesPerPage" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlImagesPerPage_SelectedIndexChanged" CssClass="ddlpageitems">
								<asp:ListItem Text="10" Value="10">
								</asp:ListItem>
								<asp:ListItem Text="30" Value="30">
								</asp:ListItem>
								<asp:ListItem Text="50" Value="50">
								</asp:ListItem>
							</asp:DropDownList>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<asp:ObjectDataSource ID="odsGetComments" TypeName="EasyDNN.Modules.EasyDNNGallery.CommentsDataDB" runat="server" SelectMethod="GetAllComments" EnablePaging="True" SelectCountMethod="SelectTotalNumberOfComments" DeleteMethod="Delete" UpdateMethod="UpdateCommentText">
		<DeleteParameters>
			<asp:Parameter Name="CommentID" Type="Int32" />
		</DeleteParameters>
		<SelectParameters>
			<asp:Parameter Name="PortalID" Type="Int32" />
			<asp:Parameter Name="galleryList" Type="String" DefaultValue="0" />
			<asp:Parameter Name="PictureID" Type="Int32" DefaultValue="0" />
			<asp:ControlParameter ControlID="cbShowOnlyUnapprovedComment" Name="showOnlyUnapproved" PropertyName="Checked" Type="Boolean" />
			<asp:Parameter Name="maximumRows" Type="Int32" DefaultValue="1" />
			<asp:Parameter Name="startRowIndex" Type="Int32" DefaultValue="10" />
		</SelectParameters>
		<UpdateParameters>
			<asp:Parameter Name="commentId" Type="Int32" />
			<asp:Parameter Name="rawComment" Type="String" />
		</UpdateParameters>
	</asp:ObjectDataSource>
</div>
