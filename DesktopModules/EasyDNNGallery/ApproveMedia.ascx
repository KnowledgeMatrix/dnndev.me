<%@ control language="C#" inherits="EasyDNN.Modules.EasyDNNGallery.ApproveMedia, App_Web_approvemedia.ascx.af09375b" autoeventwireup="true" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>

<script type="text/javascript">
	function SelectAllMedia() {
		eds1_10('#<%=gvGalleryImages.ClientID%> span.EGMediaSelect > input').each(function () {
			this.checked = true;
		});
	}
	function ConfirmApprove() {
		var result = confirm('Are you sure?');
		if (!result) {
			eds1_10('#<%=lblMedidaManagerMessage.ClientID%>').removeClass().text('');
		}
		return result;
	};
</script>
<div>
	<asp:ObjectDataSource ID="odsCategories" runat="server" SelectMethod="GetCategories"
		TypeName="EasyDNN.Modules.EasyDNNGallery.DataAcess">
		<SelectParameters>
			<asp:Parameter Name="PortalID" Type="Int32" />
		</SelectParameters>
	</asp:ObjectDataSource>
	<asp:ObjectDataSource ID="odsGalleries" runat="server" SelectMethod="GetCatGalleries"
		TypeName="EasyDNN.Modules.EasyDNNGallery.DataAcess" DeleteMethod="DeleteImage" OldValuesParameterFormatString="original_{0}">
		<DeleteParameters>
			<asp:Parameter Name="PictureID" Type="Int32" />
		</DeleteParameters>
		<SelectParameters>
			<asp:ControlParameter ControlID="ddlSelectCategory" Name="CategoryID" PropertyName="SelectedValue" Type="Int32" />
		</SelectParameters>
	</asp:ObjectDataSource>
	<asp:ObjectDataSource ID="odsGetAllUnapprovedImages" TypeName="EasyDNN.Modules.EasyDNNGallery.DataAcess" runat="server"
		SelectMethod="GetAllUnapprovedImagesFromPortal" UpdateMethod="UpdateImageApprove" DeleteMethod="DeleteImage">
		<DeleteParameters>
			<asp:Parameter Name="PictureID" Type="Int32" />
		</DeleteParameters>
		<SelectParameters>
			<asp:Parameter Name="PortalID" Type="Int32" />
		</SelectParameters>
		<UpdateParameters>
			<asp:Parameter Name="PictureID" Type="Int32" />
			<asp:Parameter Name="Category" Type="String" />
			<asp:Parameter Name="Title" Type="String" />
			<asp:Parameter Name="Description" Type="String" />
			<asp:Parameter Name="FileName" Type="String" />
			<asp:Parameter Name="Position" Type="Int32" />
			<asp:Parameter Name="ImageUrl" Type="String" />
		</UpdateParameters>
	</asp:ObjectDataSource>
	<asp:ObjectDataSource ID="odsGetUsersAllUnapprovedImages" runat="server" DeleteMethod="DeleteImage"
		SelectMethod="GetUsersForAllUnapprovedImagesFromPortal" TypeName="EasyDNN.Modules.EasyDNNGallery.DataAcess"
		UpdateMethod="UpdateImageApprove">
		<DeleteParameters>
			<asp:Parameter Name="PictureID" Type="Int32" />
		</DeleteParameters>
		<SelectParameters>
			<asp:Parameter Name="PortalID" Type="Int32" />
		</SelectParameters>
		<UpdateParameters>
			<asp:Parameter Name="PictureID" Type="Int32" />
			<asp:Parameter Name="Category" Type="String" />
			<asp:Parameter Name="Title" Type="String" />
			<asp:Parameter Name="Description" Type="String" />
			<asp:Parameter Name="FileName" Type="String" />
			<asp:Parameter Name="Position" Type="Int32" />
			<asp:Parameter Name="ImageUrl" Type="String" />
		</UpdateParameters>
	</asp:ObjectDataSource>
	<asp:HiddenField ID="hfListAllGalleries" runat="server" Value="False" />
	<asp:HiddenField ID="hfGravityMode" runat="server" Value="False" />
	<asp:HiddenField ID="hfReportedImages" runat="server" Value="False" />
	<asp:ObjectDataSource ID="odsGalleryImages" TypeName="EasyDNN.Modules.EasyDNNGallery.DataAcess" runat="server" SelectMethod="GetAllUnapprovedImagesFromGallery"
		UpdateMethod="UpdateImageApprove" DeleteMethod="DeleteImage">
		<DeleteParameters>
			<asp:Parameter Name="PictureID" Type="Int32" />
		</DeleteParameters>
		<SelectParameters>
			<asp:ControlParameter ControlID="ddlSelectGallery" Name="GalleryID" PropertyName="SelectedValue"
				Type="Int32" />
		</SelectParameters>
		<UpdateParameters>
			<asp:Parameter Name="PictureID" Type="Int32" />
			<asp:Parameter Name="Category" Type="String" />
			<asp:Parameter Name="Title" Type="String" />
			<asp:Parameter Name="Description" Type="String" />
			<asp:Parameter Name="FileName" Type="String" />
			<asp:Parameter Name="Position" Type="Int32" />
			<asp:Parameter Name="ImageUrl" Type="String" />
		</UpdateParameters>
	</asp:ObjectDataSource>
	<asp:ObjectDataSource ID="odsMediaReports" TypeName="EasyDNN.Modules.EasyDNNGallery.DataAcess" runat="server" SelectMethod="GetMediaReports" EnablePaging="True" SelectCountMethod="SelectNumberOfMediaReports">
		<SelectParameters>
			<asp:Parameter Name="PictureID" Type="Int32" />
			<asp:Parameter Name="maximumRows" Type="Int32" DefaultValue="1" />
			<asp:Parameter Name="startRowIndex" Type="Int32" DefaultValue="0" />
		</SelectParameters>
	</asp:ObjectDataSource>
</div>
<div id="divUpload">
	<div id="EDGAdminContent">
		<asp:Panel ID="pnlApproveMedia" runat="server">
			<div class="topBarWrapper">
				<div class="wrapper">
					<ul class="links">
						<li id="liMainSectiontext">
							<asp:Label runat="server" ID="lblMainSectionTitle" Text="Approve media"></asp:Label></li>
					</ul>
					<ul class="actions">
						<li class="back">
							<asp:LinkButton ID="btnBackManagment" runat="server" Text="Back" Visible="False" OnClick="btnBackManagment_Click" />
						</li>
						<li class="close">
							<asp:LinkButton ID="btnTopCloseApprove" runat="server" OnClick="btnCloseApprove_Click" Text="Close media approval" resourcekey="btnclosemediaResource1" />
						</li>
					</ul>
				</div>
			</div>
			<div class="mainContentWrapper">
				<div class="contentSectionWrapper color3 ">
					<div class="sectionHeader onlyTitleAndNumber">
						<div class="titleAndNumber mediaManagerTitleAndNumber">
							<h4>
								<asp:Label ID="lblApproveMediaTitle" runat="server" Text="Approve media"></asp:Label>
							</h4>
							<p>
								<asp:Label ID="lblMainTagline" ResourceKey="lblMainTagline" runat="server" Text="Manage unaproved and reported media."></asp:Label>
							</p>
						</div>
					</div>
					<div class="listItems">
						<asp:Panel runat="server" ID="pnlMediaList">
							<div class="listItemsTableTabs">
								<asp:LinkButton ID="lbApproveImagesMode" ResourceKey="lbApproveImagesMode" runat="server" Visible="False" OnClick="lbApproveImagesMode_Click" CssClass="approveTab">Approve images</asp:LinkButton>
								<asp:LinkButton ID="lbReportedImagesMode" ResourceKey="lbReportedImagesMode" runat="server" Visible="False" OnClick="lbReportedImagesMode_Click" CssClass="reportedTab">Reported images</asp:LinkButton>
							</div>
							<asp:Panel ID="pnlSelectCategoryGallery" runat="server" Visible="False">
								<table>
									<tr>
										<td class="labels">
											<asp:Label ID="lblSelectedCatName" runat="server" resourcekey="lblSelectedCatNameResource1"
												Text="Select category:"></asp:Label>
										</td>
										<td class="textLeft">
											<div class="styledSelect">
												<asp:DropDownList ID="ddlSelectCategory" runat="server" DataSourceID="odsCategories"
													DataTextField="CategoryName" DataValueField="CategoryID"
													AutoPostBack="True" OnSelectedIndexChanged="ddlSelectCategory_SelectedIndexChanged">
												</asp:DropDownList>
											</div>
										</td>
									</tr>
									<tr>
										<td class="labels">
											<asp:Label ID="lblSelectedGalleryNameTitle" runat="server"
												resourcekey="lblSelectedGalleryNameTitleResource1" Text="Select gallery:"></asp:Label>
										</td>
										<td class="textLeft">
											<div class="styledSelect">
												<asp:DropDownList ID="ddlSelectGallery" runat="server" AutoPostBack="True"
													DataSourceID="odsGalleries" DataTextField="GalleryName" DataValueField="GalleryID"
													OnSelectedIndexChanged="ddlSelectGallery_SelectedIndexChanged">
												</asp:DropDownList>
											</div>
										</td>
									</tr>
								</table>
							</asp:Panel>
							<asp:Panel ID="pnlShowAllMedia" runat="server" Visible="False">
								<table>
									<tr>
										<td>
											<asp:LinkButton ID="lbShowMediaByGallery" runat="server"
												OnClick="lbShowMediaByCategory_Click" Visible="False" Font-Bold="True" resourcekey="lbShowMediaByGalleryResource1">Show media by category &amp; gallery</asp:LinkButton>
											<asp:LinkButton ID="lbShowAllMedia" runat="server" OnClick="lb_Click"
												Font-Bold="True" resourcekey="lbShowAllMediaResource1">Show all unapproved media</asp:LinkButton>
										</td>
									</tr>
									<tr>
										<td>
											<asp:Panel ID="pnlFilterUsers" runat="server" Visible="False">
												<asp:CheckBox ID="cbFilterByUser" runat="server" AutoPostBack="True" OnCheckedChanged="cbFilterByUser_CheckedChanged"
													Text="Filter by user." resourceKey="cbFilterByUserResource1" ForeColor="#ffffff" />
												<asp:DropDownList ID="ddlUserList" runat="server" AutoPostBack="True" DataSourceID="odsGetUsersAllUnapprovedImages"
													DataTextField="DisplayName" DataValueField="UserID" OnSelectedIndexChanged="ddlUserList_SelectedIndexChanged">
												</asp:DropDownList>
											</asp:Panel>
										</td>
									</tr>
								</table>
							</asp:Panel>
							<asp:Label ID="lblMedidaManagerMessage" runat="server" EnableViewState="False"></asp:Label>
							<asp:Label ID="lblNoItems" CssClass="infoMessages info" runat="server" Visible="False"></asp:Label>
							<asp:GridView ID="gvGalleryImages" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="PictureID" DataSourceID="odsGalleryImages" OnDataBound="gvGalleryImages_DataBound" OnRowCancelingEdit="gvGalleryImages_RowCancelingEdit" OnRowCommand="gvGalleryImages_RowCommand" CssClass="listItemsTable" OnRowDeleted="gvGalleryImages_RowDeleted" OnRowEditing="gvGalleryImages_RowEditing" GridLines="Horizontal" ShowFooter="True" EnableModelValidation="True" OnPreRender="gvGalleryImages_PreRender">
								<Columns>
									<asp:TemplateField ShowHeader="False">
										<ItemTemplate>
											<div class="styledCheckbox noLabel">
												<asp:CheckBox ID="cbMediaSelected" CssClass="EGMediaSelect" resourcekey="cbSelected" runat="server" Text="Select" />
											</div>
										</ItemTemplate>
										<FooterTemplate>
											<div class="itemActions footerActions">
												<asp:LinkButton ID="lbSelectAll" CssClass="btnsaveposition" resourcekey="lbSelectAll" OnClientClick="SelectAllMedia(); return false;" runat="server" Text="Select all" Visible="<%#!Convert.ToBoolean(hfReportedImages.Value)%>"></asp:LinkButton>
											</div>
											<div class="positionItems">
												<asp:LinkButton ID="btnBulkApprove" runat="server" OnClick="btnBulkApprove_Click" Text="Approve" resourcekey="btnBulkApproveResource1" CssClass="savePositions" Visible="<%#!Convert.ToBoolean(hfReportedImages.Value)%>" />
											</div>
										</FooterTemplate>
									</asp:TemplateField>
									<asp:TemplateField HeaderText="Action" ShowHeader="False">
										<EditItemTemplate>
											<div class="itemActions itemEditActions">
												<asp:LinkButton ID="lbMediaUpdate" runat="server" CommandName="Update" CssClass="itemEditUpdate" Text="Update" resourcekey="lbMediaUpdateResource1"></asp:LinkButton>
												<asp:LinkButton ID="lbMediaCancel" runat="server" CausesValidation="False" CommandName="Cancel" CssClass="itemEditCancel" Text="Cancel" resourcekey="lbMediaCancelResource1"></asp:LinkButton>
											</div>
										</EditItemTemplate>
										<ItemTemplate>
											<div class="itemActions itemSecondaryActions">
												<asp:LinkButton ID="lbMediaEdit" runat="server" CausesValidation="False" CommandName="Edit" Text="Quick Edit" resourcekey="lbMediaEditResource1"></asp:LinkButton>
											</div>
											<div class="itemActions itemPrimaryActions">
												<asp:LinkButton ID="lbMediaDelete" runat="server" CommandName="Delete" CssClass="deleteAction" OnClientClick="return confirm('Are you sure you want to delete this media?');" Text="Delete" resourcekey="lbMediaDeleteResource1"></asp:LinkButton>
											</div>
											<asp:HiddenField ID="hfMediaID" runat="server" Value='<%#((DataRowView)Container.DataItem)["PictureID"]%>' />
										</ItemTemplate>
										<ItemStyle CssClass="actionsCell" />
									</asp:TemplateField>
									<asp:BoundField DataField="PictureID" HeaderText="ID" ReadOnly="True"></asp:BoundField>
									<asp:BoundField DataField="GalleryID" HeaderText="GalleryID" ReadOnly="True" Visible="False" />
									<asp:TemplateField HeaderText="Title" SortExpression="Title">
										<EditItemTemplate>
											<asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("Title") %>'></asp:TextBox>
										</EditItemTemplate>
										<ItemTemplate>
											<asp:LinkButton ID="lbMediaTitleOpen" runat="server" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>" CommandName="Open" CssClass="gallerycontrollinklight" Text='<%# Eval("Title") %>' resourcekey="lbMediaTitleOpenResource1"></asp:LinkButton>
										</ItemTemplate>
									</asp:TemplateField>
									<asp:TemplateField HeaderText="Description">
										<EditItemTemplate>
											<asp:TextBox ID="tbMediaEditDescription" runat="server" Height="150px" Text='<%# Bind("Description") %>' TextMode="MultiLine" Width="120px" resourcekey="tbMediaEditDescriptionResource1"></asp:TextBox>
										</EditItemTemplate>
										<ItemTemplate>
											<asp:Label ID="lblMediaDescription" runat="server" Text='<%# Bind("Description") %>' resourcekey="lblMediaDescriptionResource1"></asp:Label>
										</ItemTemplate>
									</asp:TemplateField>
									<asp:TemplateField HeaderText="Thumbnail">
										<ItemTemplate>
											<asp:HyperLink ID="hlMediaThumbnailOpen" runat="server" NavigateUrl='<%# Eval("FileName") %>' Target="_blank" resourcekey="hlMediaThumbnailOpenResource1" CssClass="thumbnail">
												<asp:Image ID="Image1" runat="server" CssClass="imagethumbbrd" ImageUrl='<%# Eval("ThumbUrl") %>' resourcekey="Image1Resource1" />
											</asp:HyperLink>
											<asp:Label ID="lblMediaImageUrl" runat="server" Text='<%# Bind("ImageUrl") %>' resourcekey="lblMediaImageUrlResource1"></asp:Label>
											<asp:Label ID="lblGalleryTitle" runat="server" Text='<%#String.Format("Gallery name: {0}", Eval("GalleryName"))%>'></asp:Label>
										</ItemTemplate>
										<ItemStyle CssClass="thumbnailCell" />
									</asp:TemplateField>
									<asp:TemplateField HeaderText="Type" SortExpression="MediaType">
										<ItemTemplate>
											<asp:Label ID="lblMediaType" runat="server" Text='<%#((DataRowView)Container.DataItem)["MediaType"]%>' CssClass='<%# String.Format("mediaType type{0}", (((DataRowView)Container.DataItem)["MediaType"]).ToString().Replace(" ",""))%>'></asp:Label>
										</ItemTemplate>
									</asp:TemplateField>
									<asp:BoundField DataField="DateUploaded" HeaderText="DateUploaded" ReadOnly="True" SortExpression="DateUploaded">
										<ItemStyle Width="80px" />
									</asp:BoundField>
									<asp:TemplateField HeaderText="User" SortExpression="UserID">
										<ItemTemplate>
											<asp:Label ID="lblUserName" runat="server" Text='<%# GetUserName(Eval("UserID")) %>'></asp:Label>
										</ItemTemplate>
									</asp:TemplateField>
									<asp:TemplateField HeaderText="Approved">
										<EditItemTemplate>
										</EditItemTemplate>
										<ItemTemplate>
											<asp:Label ID="lblApproved" runat="server" Text="Approved" Visible='<%#Convert.ToBoolean(Eval("MediaApproved"))%>' CssClass="approveState approved" />
											<asp:Label ID="lblUnapproved" runat="server" Text="Unapproved" Visible='<%#!Convert.ToBoolean(Eval("MediaApproved"))%>' CssClass="approveState unapproved" />
											<div>
												<asp:LinkButton ID="lbApprove" CssClass="approveLink approve" runat="server" OnClientClick="return ConfirmApprove();" CommandName="Approve" CommandArgument='<%#((DataRowView)Container.DataItem)["PictureID"]%>' Visible='<%#!Convert.ToBoolean(Eval("MediaApproved"))%>' Text="Approve" resourcekey="lbApproveResource1" CausesValidation="False"></asp:LinkButton>
												<asp:LinkButton ID="lbUnApprove" CssClass="approveLink unApprove" runat="server" OnClientClick="return ConfirmApprove();" CommandName="Unapprove" CommandArgument='<%#((DataRowView)Container.DataItem)["PictureID"]%>' Visible='<%#Convert.ToBoolean(Eval("MediaApproved"))%>' Text="Unapprove" resourcekey="lbUnApproveResource1" CausesValidation="False"></asp:LinkButton>
											</div>
											<div>
												<asp:LinkButton ID="lbClearUserReports" runat="server" CausesValidation="False" CommandArgument='<%# Eval("PictureID") %>'
													CommandName="ClearReport" CssClass="approveLink unApprove" resourcekey="ClearUserReports" Text="Clear user reports" Visible="<%#Convert.ToBoolean(hfReportedImages.Value)%>"></asp:LinkButton>
											</div>
											<asp:LinkButton ID="lbViewReports" runat="server" CausesValidation="False" CommandArgument='<%# Eval("PictureID") %>'
												CommandName="ViewReports" CssClass="approveLink unApprove" resourcekey="lbViewReports" Text="View reports" Visible="<%#Convert.ToBoolean(hfReportedImages.Value)%>"></asp:LinkButton>
										</ItemTemplate>
										<ItemStyle CssClass="approveCell" />
										<HeaderStyle HorizontalAlign="Center" />
									</asp:TemplateField>
								</Columns>
								<FooterStyle CssClass="itemsListFooter" />
								<HeaderStyle CssClass="itemsListheader" />
								<PagerStyle CssClass="contentPagination" />
								<EditRowStyle CssClass="editItemState" />
							</asp:GridView>
							<div runat="server" id="numberOfItemsPerPage" class="numberOfItemsPerPage">
								<dnn:Label ID="lblNumberOfMediaPerPage" runat="server" Text="Items per page:" HelpText="Select the number of items to display on one page." ResourceKey="lblNumberOfMediaPerPage" CssClass="labeltext" HelpKey="lblNumberOfMediaPerPage.HelpText"></dnn:Label>
								<div class="styledSelect">
									<asp:DropDownList ID="ddlImagesPerPage" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlImagesPerPage_SelectedIndexChanged" CssClass="ddlpageitems">
										<asp:ListItem Text="10" Value="10" resourcekey="ListItemResource12">
										</asp:ListItem>
										<asp:ListItem Text="30" Value="30" resourcekey="ListItemResource13">
										</asp:ListItem>
										<asp:ListItem Text="50" Value="50" resourcekey="ListItemResource14">
										</asp:ListItem>
									</asp:DropDownList>
								</div>
							</div>
						</asp:Panel>
						<asp:Panel runat="server" ID="pnlMediaReports" Visible="False">
							<div class="additionalOptions color3 mediaReports">
								<h2>
									<asp:Label ID="lblMediaReports" runat="server" Visible="True" Text="Media reports"></asp:Label>
								</h2>
							</div>
							<asp:Label ID="lblMediaReportsMessage" runat="server" EnableViewState="False"></asp:Label>
							<asp:GridView ID="gvReports" EnableViewState="False" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="PictureID" DataSourceID="odsMediaReports" CssClass="listItemsTable reported" GridLines="Horizontal" ShowFooter="True" EnableModelValidation="True" PageSize="15" OnRowDataBound="gvReports_RowDataBound">
								<Columns>
									<asp:BoundField DataField="DisplayName" HeaderText="Reportedbyuser" />
									<asp:BoundField DataField="DateReported" HeaderText="Reportdate" />
									<asp:TemplateField HeaderText="Reportreason">
										<ItemTemplate>
											<asp:Label ID="lblReportReason" runat="server" Text='<%# Localization.GetString(Enum.GetName(typeof(EasyDNN.Modules.EasyDNNGallery.ReportMediaReasons), ((DataRowView)Container.DataItem)["ReportReason"])+".Text", LocalResourceFile)%>'></asp:Label>
										</ItemTemplate>
									</asp:TemplateField>
									<asp:TemplateField HeaderText="Reporttype">
										<ItemTemplate>
											<asp:Label ID="lblReportTypeNew" runat="server" Visible='<%#!Convert.ToBoolean(Eval("ReportDismissed"))%>' Text="New report"></asp:Label>
											<asp:Label ID="lblReportTypeDismissed" runat="server" Visible='<%#Convert.ToBoolean(Eval("ReportDismissed"))%>' Text="Dismissed report"></asp:Label>
										</ItemTemplate>
									</asp:TemplateField>
								</Columns>
								<FooterStyle CssClass="itemsListFooter" />
								<HeaderStyle CssClass="itemsListheader" />
								<PagerStyle CssClass="contentPagination" />
								<EditRowStyle CssClass="editItemState" />
							</asp:GridView>
							<div class="mainActions">
								<asp:LinkButton ID="btnDismissReports" runat="server" Text="Dismiss new reports" OnClick="btnDismissReports_Click" CssClass="downClose" />
							</div>
							<asp:HiddenField ID="hfMediaReports" runat="server" Value="0" />
						</asp:Panel>
					</div>
				</div>
			</div>
		</asp:Panel>
	</div>
</div>
