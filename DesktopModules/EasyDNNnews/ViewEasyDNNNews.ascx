<%@ control language="C#" inherits="EasyDNNSolutions.Modules.EasyDNNNews.ViewEasyDNNNews, App_Web_vieweasydnnnews.ascx.d988a5ac" autoeventwireup="true" enableviewstate="true" %>
<%@ Register TagPrefix="dnnCTRL" Assembly="DotNetNuke" Namespace="DotNetNuke.UI.WebControls" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<script type="text/javascript">
	/*<![CDATA[*/
	<%=includeRegistrationDatePickerJS%>
	<%=includeLightBoxJs%>
	<%=includeGetNewsArticlesJS%>
	<%=includeCommentArticlesJS%>
	<%=includePrintJS%>
	<%=includeRegistrationCusotmFieldsJS%>
	<%=includePaymentCalculationJS%>
	<%=includeContactFormInitJs%>
	<%=includeGoogleRecaptchJs%>

	eds2_2(function ($) {
		if (typeof edn_fluidvids != 'undefined')
			edn_fluidvids.init({
				selector: ['.edn_fluidVideo iframe'],
				players: ['www.youtube.com', 'player.vimeo.com']
			});
		<%=includeedNewsOnePageInit%>
		<%=includeOpenEventRegistrationModalBox%>

	});
	/*]]>*/
</script>
<%=includeAddThisJS%>
<asp:Literal ID="countfacebookJS" runat="server" EnableViewState="false" />

<div class="<%=MainDivClass%>">
	<p id="themeDeveloperModeActive" runat="server" enableviewstate="false" visible="false" class="eds_themeDeveloperModeActive"><span id="themeDeveloperModeActiveText" runat="server"></span></p>

	<asp:Panel ID="pnlUserDashBoard" runat="server" Visible="false" CssClass="user_dashboard" EnableViewState="false">
		<asp:HyperLink ID="lbAddArticles" runat="server" Visible="false" EnableViewState="false" CssClass="add_article"><%=Localization.GetString("lbAddArticles.Text", this.LocalResourceFile + "ViewEasyDNNNews.ascx.resx")%></asp:HyperLink>
		<asp:HyperLink ID="lbArticleEditor" runat="server" Visible="false" EnableViewState="false" CssClass="article_manager"><%=Localization.GetString("lbArticleEditor.Text", this.LocalResourceFile + "ViewEasyDNNNews.ascx.resx")%></asp:HyperLink>
		<asp:HyperLink ID="lbEventsManager" runat="server" Visible="false" EnableViewState="false" CssClass="event_manager"><%=Localization.GetString("lbEventsManager.Text", this.LocalResourceFile + "ViewEasyDNNNews.ascx.resx")%></asp:HyperLink>
		<asp:HyperLink ID="lbApproveComments" runat="server" Visible="false" EnableViewState="false" CssClass="approve_comments"><%=Localization.GetString("lbApproveComments.Text", this.LocalResourceFile + "ViewEasyDNNNews.ascx.resx")%></asp:HyperLink>
		<asp:HyperLink ID="lbCategoryEdit" runat="server" Visible="false" EnableViewState="false" CssClass="category_manager"><%=Localization.GetString("lbCategoryEdit.Text", this.LocalResourceFile + "ViewEasyDNNNews.ascx.resx")%></asp:HyperLink>
		<asp:HyperLink ID="lbApproveRoles" runat="server" Visible="false" EnableViewState="false" CssClass="approve_articles"><%=Localization.GetString("lbApproveRoles.Text", this.LocalResourceFile + "ViewEasyDNNNews.ascx.resx")%></asp:HyperLink>
		<asp:HyperLink ID="lbDashboard" runat="server" Visible="false" EnableViewState="false" CssClass="dashboard"><%=Localization.GetString("lbDashboard.Text", this.LocalResourceFile + "ViewEasyDNNNews.ascx.resx")%></asp:HyperLink>
		<asp:HyperLink ID="lbModuleSettings" runat="server" Visible="false" EnableViewState="false" CssClass="settings"><%=Localization.GetString("lbDBSettings.Text", this.LocalResourceFile + "ViewEasyDNNNews.ascx.resx")%></asp:HyperLink>
		<asp:HyperLink ID="lbAboutMe" runat="server" Visible="false" EnableViewState="false" CssClass="author_profile"><%=Localization.GetString("lbAboutMe.Text", this.LocalResourceFile + "ViewEasyDNNNews.ascx.resx")%></asp:HyperLink>
	</asp:Panel>

	<asp:Panel ID="pnlListArticles" runat="server" EnableViewState="false">
		<asp:Literal ID="litSearchInfo" runat="server" EnableViewState="false" />
		<asp:Literal ID="litListContent" runat="server" EnableViewState="false" />
		<asp:Literal ID="litPaging" runat="server" EnableViewState="false" />
	</asp:Panel>

	<asp:Literal ID="liDynamicScrollingMarkup" runat="server" Visible="false" />

	<asp:Panel ID="pnlViewArticle" runat="server">
		<p runat="server" id="BreadCrumbs" class="bread_crumbs" visible="false">
			<%=GenerateArticleBreadCrumbs()%>
		</p>
		<%=editLink("admin_action edit")%>
		<asp:LinkButton ID="lbPublishArticle" CssClass="admin_action publish_article" OnClick="lbPublishArticle_Click" Visible="false" runat="server"><%=Localization.GetString("Publish.Text", this.LocalResourceFile + "ViewEasyDNNNews.ascx.resx")%></asp:LinkButton>
		<asp:LinkButton ID="lbApproveArticle" CssClass="admin_action publish_article" OnClick="lbApproveArticle_Click" Visible="false" runat="server"><%=Localization.GetString("Approve.Text", this.LocalResourceFile + "ViewEasyDNNNews.ascx.resx")%></asp:LinkButton>
		<%=generateArticleHtml("EDNHeader")%>
		<asp:UpdatePanel ID="upHeader" runat="server" UpdateMode="Conditional" OnUnload="UpdatePanel_Unload">
			<ContentTemplate>
				<asp:GridView ID="gvHeaderArtPagging" runat="server" EnableModelValidation="True" AutoGenerateColumns="False" AllowPaging="True" PageSize="1" BorderStyle="None" BorderWidth="0px" CellPadding="0" GridLines="None" ShowHeader="False" OnPageIndexChanging="gvHeaderArtPagging_PageIndexChanging"
					EnableViewState="false">
					<Columns>
						<asp:TemplateField HeaderText="Article" ShowHeader="False">
							<ItemTemplate>
								<%# Eval("Article") %>
							</ItemTemplate>
						</asp:TemplateField>
					</Columns>
					<PagerStyle HorizontalAlign="Center" />
				</asp:GridView>
			</ContentTemplate>
		</asp:UpdatePanel>
		<asp:PlaceHolder ID="plTopGallery" runat="server" />
		<%=generateArticleHtml("EDNContentTop")%>
		<%=generateArticleHtml("EDNContent")%>
		<asp:UpdatePanel ID="upArticle" runat="server" UpdateMode="Conditional" OnUnload="UpdatePanel_Unload">
			<ContentTemplate>
				<%=generateArticleHtml("EDNContent")%>
				<asp:GridView CssClass="gvContentTable" ID="gvArticlePagging" runat="server" EnableModelValidation="true" AutoGenerateColumns="false" AllowPaging="true" PageSize="1" BorderStyle="None" BorderWidth="0px" CellPadding="0" GridLines="None" OnPageIndexChanging="gvArticlePagging_PageIndexChanging"
					ShowHeader="false" EnableViewState="false">
					<Columns>
						<asp:TemplateField HeaderText="Article" ShowHeader="False">
							<ItemTemplate>
								<%# Eval("Article") %>
							</ItemTemplate>
						</asp:TemplateField>
					</Columns>
					<PagerSettings Mode="NumericFirstLast" />
					<PagerStyle HorizontalAlign="Center" CssClass="article_pagination" />
				</asp:GridView>
			</ContentTemplate>
		</asp:UpdatePanel>
		<%=generateArticleHtml("EDNContentBottom")%>
		<asp:PlaceHolder ID="plBottomGallery" runat="server" />
		<%=generateArticleHtml("EDNFooter")%>
		<asp:Panel ID="pnlArticelImagesGallery" runat="server" CssClass="edn_article_gallery">
			<ul>
				<asp:Repeater ID="repArticleImages" runat="server" EnableViewState="false">
					<ItemTemplate>
						<li>
							<a href='<%#Eval("FileName")%>' rel="ednSmbLight" data-smbdata='<%#Eval("SmbData")%>'>
								<asp:Image alt='<%#Eval("Title")%>' ID="imgArticleGalleryImage" ImageUrl='<%#Eval("Thumburl")%>' runat="server" /></a>
						</li>
					</ItemTemplate>
				</asp:Repeater>
			</ul>
		</asp:Panel>
		<%=editLink("admin_action edit")%>
		<asp:HiddenField ID="hfRate" runat="server" />
		<script type="text/javascript">
			// <![CDATA[
			eds2_2(function ($) {
				var $rate_it = $(".EDN_article_rateit.M<%=ModuleId%>");
				$rate_it.bind('rated reset', function (e) {
					var ri = $(this);
					var value = ri.rateit('value');
					var articleid = <%=publicOpenArticleID%>;
					$rate_it.rateit('readonly', true);
					ri.rateit('readonly', true);
					$.cookie("<%=EDNViewArticleID%>", "true");
					document.getElementById("<%=hfRate.ClientID %>").value= value;
					$.ajax(
					{
						url: "<%=_ControlPath%>Rater.aspx",
						type: "POST",
						data: {artid: articleid, rating: value},
						success: function (data)
						{
							ri.siblings('.current_rating').text(data);
						}
					});
				})
					.rateit('value', document.getElementById("<%=hfRate.ClientID %>").value)
					.rateit('readonly',$.cookie("<%=EDNViewArticleID%>"))
					.rateit('step',1);

				$('#<%=upPanelComments.ClientID %>').on('click', '#<%=lbAddComment.ClientID %>', function () {
					var $lbAddComment = $('#<%=lbAddComment.ClientID %>'),
						noErrors = true,

						$authorNameInput = $('#<%=tbAddCommentName.ClientID %>'),
						$authorEmailInput = $('#<%=tbAddCommentEmail.ClientID %>'),

						authorName,
						authorEmail,
						comment = $('#<%=tbAddComment.ClientID %>').val(),

						$noAuthorName = $('#<%=lblAddCommentNameError.ClientID %>'),
						$noAuthorEmail = $('#<%=lblAddCommentEmailError.ClientID %>'),
						$authorEmailNotValid = $('#<%=lblAddCommentEmailValid.ClientID %>'),
						$noComment = $('#<%=lblAddCommentError.ClientID %>'),
						$notValidCaptcha = $('#<%=lblCaptchaError.ClientID %>'),

						emailRegex = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
						

					if ($lbAddComment.data('disable'))
						return false;

					if ($authorNameInput.length > 0) {
						authorName = $authorNameInput.val();

						$noAuthorName.css('display', 'none');

						if (authorName == '') {
							$noAuthorName.css('display', 'block');
							noErrors = false;
						}
					}

					if ($authorEmailInput.length > 0) {
						authorEmail = $authorEmailInput.val();

						$noAuthorEmail.css('display', 'none');
						$authorEmailNotValid.css('display', 'none');

						if (authorEmail == '') {
							$noAuthorEmail.css('display', 'block');
							noErrors = false;
						} else if (!emailRegex.test(authorEmail)) {
							$authorEmailNotValid.css('display', 'block');
							noErrors = false;
						}
					}

					if($('#<%=pnlCommentsCaptcha.ClientID%>').length>0)
					{
						var commentsCaptchaResponse = grecaptcha.getResponse(window.eds_commentsform_captchaId);
						if (commentsCaptchaResponse.length == 0) {
							$('#<%=hfCommentsFormCaptchaResponse.ClientID%>').val('');
							$notValidCaptcha.css('display', 'block');
							noErrors = false;
						}
						else
						{
							$('#<%=hfCommentsFormCaptchaResponse.ClientID%>').val(commentsCaptchaResponse);
							$notValidCaptcha.css('display', 'none');
						}
					}

					if (comment == '') {
						$noComment.css('display', 'block');
						noErrors = false;
					} else
						$noComment.css('display', 'none');

					if (noErrors)
						$lbAddComment.data('disable', true);
					else
						return false;
				});
			});
			//*/ ]]>
		</script>
		<asp:UpdatePanel ID="upPanelComments" runat="server" OnUnload="UpdatePanel_Unload">
			<ContentTemplate>
				<asp:Panel ID="pnlComments" runat="server" CssClass="article_comments" Visible="false">
					<span id='<%=Localization.GetString("CommentsAnchor.Text", this.LocalResourceFile)%>'></span>
					<asp:Literal ID="numberOfCommentsHTML" runat="server" />
					<asp:DataList ID="dlComments" runat="server" DataKeyField="CommentID" OnItemCommand="dlComments_ItemCommand" CssClass="comment_list" RepeatLayout="Flow" EnableViewState="false">
						<ItemTemplate>
							<div id="c<%#Eval("CommentID")%>" class="comment level<%#NestedCommentClass(Eval("ReplayLevel"))%>">
								<asp:Panel ID="pnlCommentRating" runat="server" CssClass="votes" Visible='<%#ShowCommentsRatingascx%>'>
									<div>
										<asp:ImageButton ID="imgBGoodVotes" runat="server" ImageUrl='~/DesktopModules/EasyDNNNews/images/upvote.png' CommandArgument="<%# ((DataListItem) Container).ItemIndex %>" CommandName="GoodVote" />
										<asp:Label ID="lblGoodVotes" runat="server" Text='<%#Eval("GoodVotes")%>' />
									</div>
									<div>
										<asp:ImageButton ID="imgBBadVotes" runat="server" ImageUrl="~/DesktopModules/EasyDNNNews/images/downvote.png" CommandArgument="<%# ((DataListItem) Container).ItemIndex %>" CommandName="BadVote" />
										<asp:Label ID="lblBadVotes" runat="server" Text='<%#Eval("BadVotes")%>' />
									</div>
								</asp:Panel>
								<div class="right_side">
									<%#DisplayComments(Eval("CommentID"),Eval("CommentersEmail"),Eval("ArticleID"),Eval("UserID"),Eval("AnonymName"),Eval("Comment"),Eval("DateAdded"), Eval("GoodVotes"),Eval("BadVotes"),Eval("Approved"),Eval("CommentersEmail"),Eval("PortalID")) %>
									<div class="actions">
										<asp:LinkButton ID="lbReplayToComment" CssClass="reply" runat="server" OnClientClick="setFocusComment();" Text='<%#lbReplayToCommentloc%>' CommandName="ReplayToCommet" CommandArgument='<%#Eval("CommentID")%>' Visible='<%#DisplayReplayTo%>' />
										<asp:LinkButton ID="lbDeleteComment" CssClass="delete" OnClientClick='<%#CommentDeleteConfirm%>' runat="server" Text='<%#lbDeleteCommentLoc%>' CommandName="DeleteComment" CommandArgument='<%#Eval("CommentID")%>' Visible="<%#IsComentModerator()%>" />
										<asp:LinkButton ID="lbEditComment" CssClass="edit" runat="server" Text='<%#lbEditCommentLoc%>' CommandName="EditComment" CommandArgument='<%#Eval("CommentID")%>' Visible="<%#IsComentModerator()%>" />
									</div>
									<asp:HiddenField ID="hfCommentID" Value='<%#Eval("CommentID")%>' runat="server" />
								</div>
								<asp:Panel ID="pnlEditComments" runat="server" Visible="false" CssClass="edit_comment">
									<asp:TextBox ID="tbEditComment" Text='<%#Eval("Comment")%>' runat="server" TextMode="MultiLine" />
									<div class="actions">
										<asp:LinkButton ID="lbUpdateComment" runat="server" CommandArgument='<%#Eval("CommentID")%>' CommandName="UpdateComment" Text='<%#lbUpdateCommentLoc%>' />
										<asp:LinkButton ID="lbCancelUpdateComment" runat="server" CommandArgument='<%#Eval("CommentID")%>' CommandName="CancelEdit" Text='<%#lbCancelUpdateCommentLoc%>' />
									</div>
								</asp:Panel>
							</div>
						</ItemTemplate>
					</asp:DataList>
					<asp:Panel ID="pnlAddComments" runat="server" CssClass="add_comment">
						<h3>
							<%=LeaveAComment%></h3>
						<div class="add_article_box">
							<asp:Panel ID="pnlReplayToComment" runat="server" CssClass="comment_info" Visible="false">
								<asp:Label ID="lblReplayToComment" runat="server" Text="" />
							</asp:Panel>
							<asp:Panel ID="pnlCommentsNameEmail" runat="server">
								<table cellspacing="0" cellpadding="0">
									<tr>
										<td class="left">
											<asp:Label ID="lblAddCommentName" runat="server" />
										</td>
										<td class="right">
											<asp:TextBox ID="tbAddCommentName" runat="server" CssClass="text" MaxLength="50" ValidationGroup="vgAddArtComment" />
											<asp:Label ID="lblAddCommentNameError" runat="server" Text="Please enter your name." Style="color: red; display: none;" />
										</td>
									</tr>
									<tr>
										<td class="left">
											<asp:Label ID="lblAddCommentEmail" runat="server" />
										</td>
										<td class="right">
											<asp:TextBox ID="tbAddCommentEmail" runat="server" CssClass="text" MaxLength="50" ValidationGroup="vgAddArtComment" />
											<asp:Label ID="lblAddCommentEmailError" runat="server" Text="Please enter email." Style="color: red; display: none;" />
											<asp:Label ID="lblAddCommentEmailValid" runat="server" Text="Please enter valid email." Style="color: red; display: none;" />
										</td>
									</tr>
								</table>
							</asp:Panel>
							<table cellspacing="0" cellpadding="0">
								<tr>
									<td class="left">
										<asp:Label ID="lblAddComment" runat="server" />
									</td>
									<td class="right">
										<asp:TextBox ID="tbAddComment" runat="server" TextMode="MultiLine" MaxLength="10000" ValidationGroup="vgAddArtComment" />
										<asp:Label ID="lblAddCommentError" runat="server" Text="Please enter comment." Style="color: red; display: none;" />
									</td>
								</tr>
							</table>
							<asp:Panel ID="pnlCommentsCaptcha" runat="server" Visible="False">
								<table cellspacing="0" cellpadding="0">
									<tr>
										<td class="left"></td>
										<td class="right">
											<div class="g-comments-recaptcha"></div>
											<asp:Label ID="lblCaptchaError" runat="server" ForeColor="Red" Style="color: red; display: none;" />
											<asp:HiddenField ID="hfCommentsFormCaptchaResponse" runat="server" />
										</td>
									</tr>
								</table>
							</asp:Panel>
							<table cellspacing="0" cellpadding="0">
								<tr>
									<td class="left"></td>
									<td class="right bottom">
										<asp:LinkButton ID="lbAddComment" runat="server" OnClick="lbAddComment_Click" CssClass="submit" ValidationGroup="vgAddArtComment"><span><%=AddComment%></span></asp:LinkButton>
									</td>
								</tr>
							</table>
						</div>
					</asp:Panel>
				</asp:Panel>
				<asp:Panel ID="pnlCommentInfo" runat="server" CssClass="article_comments" Visible="false" EnableViewState="false" />
				<asp:HiddenField ID="hfReplayToComment" runat="server" />
			</ContentTemplate>
		</asp:UpdatePanel>
		<asp:Literal ID="socComments" runat="server" EnableViewState="False" Visible="False" />
		<%=generateArticleHtml("EDNBottom")%>
	</asp:Panel>
	<asp:Label ID="lblInfoMassage" runat="server" Style="font-weight: bold" EnableViewState="false" Visible="false" />
</div>

<div id="pnlEventRegistrationForm" runat="server" class="eds_modalWrapper eds_resizable">
	<div class="eds_modalContent eds_animated">
		<asp:Literal runat="server" ID="liUserProfileLink" />
		<h3><%=Localization.GetString("RegistrationForm.Text", LocalResourceFile + "EventRegistration.resx")%></h3>
		<div>
			<div runat="server" id="pnlRegistrationForm">
				<asp:Panel ID="pnlEventRegistrationLogedInUser" runat="server" Visible="false">
					<div class="eds_labelAndInput">
						<dnn:Label ID="lblFirstNameLogedIn" runat="server" />
						<asp:TextBox ID="lblFirstNameLogedInValue" runat="server" CausesValidation="false" Enabled="false"></asp:TextBox>
					</div>
					<div class="eds_labelAndInput">
						<dnn:Label ID="lblLastNameLogedIn" runat="server" />
						<asp:TextBox ID="lblLastNameLogedInValue" runat="server" CausesValidation="false" Enabled="false"></asp:TextBox>
					</div>
					<div class="eds_labelAndInput">
						<dnn:Label ID="lblEmailLogedIn" runat="server" />
						<asp:TextBox ID="lblEmailLogedInValue" runat="server" CausesValidation="false" Enabled="false"></asp:TextBox>
					</div>
				</asp:Panel>
				<asp:Panel ID="pnlEventRegistrationUnVerified" runat="server">
					<div class="eds_labelAndInput">
						<asp:Label ID="lblFirstName" runat="server"><%=Localization.GetString("lbRegFirstName.Text", LocalResourceFile + "EventRegistration.resx")%></asp:Label>
						<asp:TextBox ID="tbxFirstName" runat="server" ValidationGroup="vgEventRegistration" MaxLength="50" CausesValidation="true"></asp:TextBox>
						<asp:RequiredFieldValidator ID="rfvFirstName" runat="server" ControlToValidate="tbxFirstName" ErrorMessage="Required!" ValidationGroup="vgEventRegistration" Display="Dynamic" SetFocusOnError="True" />
					</div>
					<div class="eds_labelAndInput">
						<asp:Label ID="lblLastName" runat="server"><%=Localization.GetString("lbRegLastName.Text", LocalResourceFile + "EventRegistration.resx")%></asp:Label>
						<asp:TextBox ID="tbxLastName" runat="server" ValidationGroup="vgEventRegistration" MaxLength="50"></asp:TextBox>
						<asp:RequiredFieldValidator ID="rfvLastName" runat="server" ControlToValidate="tbxLastName" ErrorMessage="Required!" ValidationGroup="vgEventRegistration" Display="Dynamic" SetFocusOnError="True" />
					</div>
					<div class="eds_labelAndInput">
						<asp:Label ID="lblEmail" runat="server"><%=Localization.GetString("lbRegEmail.Text", this.LocalResourceFile + "EventRegistration.resx")%></asp:Label>
						<asp:TextBox ID="tbxEmail" runat="server" ValidationGroup="vgEventRegistration" MaxLength="256"></asp:TextBox>
						<asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="tbxEmail" ErrorMessage="Required!" ValidationGroup="vgEventRegistration" Display="Dynamic" SetFocusOnError="True" />
						<asp:RegularExpressionValidator ID="revEmail" runat="server" ControlToValidate="tbxEmail" Display="Dynamic" ErrorMessage="Please enter a valid email address." ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ValidationGroup="vgEventRegistration" SetFocusOnError="True" />
					</div>
				</asp:Panel>

				<asp:Panel ID="pnlExtendedUserData" runat="server" Visible="false">
					<div class="eds_labelAndInput">
						<dnn:Label ID="lblStreet" runat="server" />
						<asp:TextBox ID="tbxStreet" runat="server" CausesValidation="false" Enabled="false"></asp:TextBox>
					</div>
					<div class="eds_labelAndInput">
						<dnn:Label ID="lblCity" runat="server" />
						<asp:TextBox ID="tbxCity" runat="server" CausesValidation="false" Enabled="false"></asp:TextBox>
					</div>
					<div class="eds_labelAndInput">
						<dnn:Label ID="lblRegion" runat="server" />
						<asp:TextBox ID="tbxRegion" runat="server" CausesValidation="false" Enabled="false"></asp:TextBox>
					</div>
					<div class="eds_labelAndInput">
						<dnn:Label ID="lblCountry" runat="server" />
						<asp:TextBox ID="tbxCountry" runat="server" CausesValidation="false" Enabled="false"></asp:TextBox>
					</div>
					<div class="eds_labelAndInput">
						<dnn:Label ID="lblPostalCode" runat="server" />
						<asp:TextBox ID="tbxPostalCode" runat="server" CausesValidation="false" Enabled="false"></asp:TextBox>
					</div>
					<div class="eds_labelAndInput">
						<dnn:Label ID="lblTelephone" runat="server" />
						<asp:TextBox ID="tbxTelephone" runat="server" CausesValidation="false" Enabled="false"></asp:TextBox>
					</div>
				</asp:Panel>

				<div class="eds_labelAndInput" runat="server" id="sectionNumberOfTickets">
					<asp:Label ID="lblNumberOfTickets" runat="server"><%=Localization.GetString("lbRegNumberOfSeats.Text", LocalResourceFile + "EventRegistration.resx")%></asp:Label>
					<asp:TextBox ID="tbxNumberOfTickets" runat="server" MaxLength="4" Text="1" CausesValidation="True" ValidationGroup="vgEventRegistration" CssClass="eds_numberOfTickets"></asp:TextBox>
					<asp:RequiredFieldValidator ID="rfvNumberOfTickets" runat="server" ControlToValidate="tbxNumberOfTickets" ValidationGroup="vgEventRegistration" ErrorMessage="Required!" Display="Dynamic" SetFocusOnError="True" CssClass="edn_errorMessage" />
					<asp:CompareValidator ID="cvNumberOfTickets" runat="server" ControlToValidate="tbxNumberOfTickets" ValidationGroup="vgEventRegistration" ErrorMessage="Must be a number!" Operator="DataTypeCheck" Type="Integer" Display="Dynamic" SetFocusOnError="True" CssClass="edn_errorMessage" />
				</div>
				<asp:UpdatePanel ID="upEventRegistration" runat="server" UpdateMode="Always" OnUnload="UpdatePanel_Unload">
					<ContentTemplate>
						<asp:PlaceHolder ID="phCustomFields" runat="server" Visible="false">
							<asp:HiddenField runat="server" ID="hfParenSelectedValue" />
							<asp:HiddenField runat="server" ID="hfLastSelectedIndexChanged" />
							<asp:HiddenField runat="server" ID="hfCFLastTriggerdByList" />
							<asp:HiddenField runat="server" ID="hfPreviousCFTemplateID" />
							<asp:HiddenField runat="server" ID="hfUploadFieldState" />
						</asp:PlaceHolder>
					</ContentTemplate>
				</asp:UpdatePanel>
				<div class="eds_labelAndInput" runat="server" id="sectionMessage">
					<asp:Label ID="lblMessage" runat="server"><%=Localization.GetString("lbRegAdditionalInformation.Text", LocalResourceFile + "EventRegistration.resx")%></asp:Label>
					<asp:TextBox ID="tbxMessage" runat="server" MaxLength="1024" TextMode="MultiLine" Rows="5"></asp:TextBox>
				</div>

				<asp:Literal ID="ltPriceData" runat="server"></asp:Literal>

				<asp:HiddenField ID="hfSelectedPayment" runat="server" />

				<div runat="server" id="divEventRegistrationCaptcha" class="eds_labelAndInput">
					<asp:Label ID="lblEventRegistrationCaptcha" runat="server"><%=Localization.GetString("lblEventRegistrationCaptcha.Text", LocalResourceFile + "EventRegistration.resx")%></asp:Label>
					<div class="g-eventregistration-recaptcha"></div>
					<asp:CustomValidator ID="cvEventRegistrationCaptcha" runat="server" ClientValidationFunction="eds_ValidateEventRegistrationCaptcha" Display="Dynamic" ErrorMessage="Please solve captcha." ValidationGroup="vgEventRegistration" />
					<asp:HiddenField ID="hfEventRegistrationCaptchaResponse" runat="server" />
				</div>

				<div class="edn_bottomButtonWrapper">
					<asp:Literal ID="liPayPalIcons" runat="server"></asp:Literal>
					<asp:ImageButton runat="server" CausesValidation="true" ID="imgBtnPayPal" ImageUrl="https://www.paypal.com/en_US/i/btn/btn_xpressCheckout.gif" OnClick="btnRegisterEvent_Click" ValidationGroup="vgEventRegistration" />
					<asp:Button runat="server" CausesValidation="true" ID="btnRegisterEvent" Text="Register" OnClick="btnRegisterEvent_Click" ValidationGroup="vgEventRegistration" />
				</div>
			</div>
			<asp:Label ID="lblRegistrationInfo" runat="server" EnableViewState="false" CssClass="eds_infoMessages eds_info" Visible="false" />
			<asp:UpdateProgress ID="uppEventRegistration" runat="server" AssociatedUpdatePanelID="upEventRegistration" DisplayAfter="100" DynamicLayout="true">
				<ProgressTemplate>
					<div class="eds_eventRegistrationLoading">
					</div>
				</ProgressTemplate>
			</asp:UpdateProgress>
		</div>
		<span class="eds_modalClose eds_closeWindowButtonOuter" data-target-id='<%=pnlEventRegistrationForm.ClientID%>'>x</span>
	</div>
</div>

<asp:Panel ID="pnlContactForm" runat="server" Visible="False">
	<asp:HiddenField ID="hfContactFormID" runat="server" />
	<div class="eds_modalContent eds_animated">
		<h3>
			<asp:Label ID="lblContactFormTitle" runat="server" /></h3>
		<div>
			<asp:UpdatePanel ID="upContactForm" runat="server" UpdateMode="Always" OnUnload="UpdatePanel_Unload">
				<ContentTemplate>
					<asp:Panel ID="pnlContactFormMessageSent" runat="server" CssClass="eds_formStatus" Style="display: none">
						<asp:Label ID="lblMessageSent" runat="server" Text="Message sent." />
					</asp:Panel>
					<asp:Panel ID="pnlContactInputForm" runat="server">
						<div class="eds_labelAndInput eds_labelWidth100">
							<asp:Label ID="lblContactFormYourName" runat="server"></asp:Label>
							<asp:TextBox ID="tbContactFormYourName" runat="server" CssClass="text" Text="" />
							<asp:RequiredFieldValidator ID="rfvPleaseName" runat="server" ControlToValidate="tbContactFormYourName" ErrorMessage="Please enter your name." ValidationGroup="vgContactForm" Display="Dynamic" />
							<asp:CompareValidator ID="cvYourName" runat="server" ControlToValidate="tbContactFormYourName" Display="Dynamic" ErrorMessage="Please enter your name." Operator="NotEqual" ValidationGroup="vgContactForm" ValueToCompare="TEST"></asp:CompareValidator>
						</div>
						<div class="eds_labelAndInput eds_labelWidth100">
							<asp:Label ID="lblContactFormYourEmail" runat="server"></asp:Label>
							<asp:TextBox ID="tbContactFormYourEmail" CssClass="text" Text="" runat="server" />
							<asp:RequiredFieldValidator ID="rfvPleaseEmail" runat="server" ControlToValidate="tbContactFormYourEmail" Display="Dynamic" ErrorMessage="Please enter a valid email address." ValidationGroup="vgContactForm" />
							<asp:RegularExpressionValidator ID="revValidEmail" runat="server" ControlToValidate="tbContactFormYourEmail" Display="Dynamic" ErrorMessage="Please enter a valid email address." ValidationGroup="vgContactForm" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" />
							<asp:CompareValidator ID="cvYourEmail" runat="server" ControlToValidate="tbContactFormYourEmail" Display="Dynamic" ErrorMessage="Please enter your email." Operator="NotEqual" ValidationGroup="vgContactForm" ValueToCompare="TEST"></asp:CompareValidator>
						</div>
						<div class="eds_labelAndInput eds_labelWidth100 eds_bigInput">
							<asp:Label ID="lblContactFormSubject" runat="server"></asp:Label>
							<asp:TextBox ID="tbContactFormSubject" runat="server" Text="" CssClass="text" />
							<asp:RequiredFieldValidator ID="rfvPleaseSubject" runat="server" ControlToValidate="tbContactFormSubject" Display="Dynamic" ErrorMessage="Please enter a subject." ValidationGroup="vgContactForm" />
							<asp:CompareValidator ID="cvEmailSubject" runat="server" ControlToValidate="tbContactFormSubject" Display="Dynamic" ErrorMessage="Please enter a subject." Operator="NotEqual" ValidationGroup="vgContactForm" ValueToCompare="TEST"></asp:CompareValidator>
						</div>
						<div runat="server" id="divContactFormCompany" visible="false" class="eds_labelAndInput eds_labelWidth100">
							<asp:Label ID="lblContactFormCompany" runat="server"></asp:Label>
							<asp:TextBox ID="tbContactFormCompany" CssClass="text" Text="" runat="server" />
							<asp:RequiredFieldValidator ID="rfvContactFormCompany" runat="server" ControlToValidate="tbContactFormCompany" Display="Dynamic" ErrorMessage="Please enter company name." ValidationGroup="vgContactForm" />
						</div>
						<div runat="server" id="divContactFormStreet" visible="false" class="eds_labelAndInput eds_labelWidth100">
							<asp:Label ID="lblContactFormStreet" runat="server"></asp:Label>
							<asp:TextBox ID="tbContactFormStreet" CssClass="text" Text="" runat="server" />
							<asp:RequiredFieldValidator ID="rfvContactFormStreet" runat="server" ControlToValidate="tbContactFormStreet" Display="Dynamic" ErrorMessage="Please enter street name." ValidationGroup="vgContactForm" />
						</div>
						<div runat="server" id="divContactFormCity" visible="false" class="eds_labelAndInput eds_labelWidth100">
							<asp:Label ID="lblContactFormCity" runat="server"></asp:Label>
							<asp:TextBox ID="tbContactFormCity" CssClass="text" Text="" runat="server" />
							<asp:RequiredFieldValidator ID="rfvContactFormCity" runat="server" ControlToValidate="tbContactFormCity" Display="Dynamic" ErrorMessage="Please enter City name." ValidationGroup="vgContactForm" />
						</div>
						<div runat="server" id="divContactFormRegion" visible="false" class="eds_labelAndInput eds_labelWidth100">
							<asp:Label ID="lblContactFormRegion" runat="server"></asp:Label>
							<asp:TextBox ID="tbContactFormRegion" CssClass="text" Text="" runat="server" />
							<asp:RequiredFieldValidator ID="rfvContactFormRegion" runat="server" ControlToValidate="tbContactFormRegion" Display="Dynamic" ErrorMessage="Please enter Region name." ValidationGroup="vgContactForm" />
						</div>
						<div runat="server" id="divContactFormCountry" visible="false" class="eds_labelAndInput eds_labelWidth100">
							<asp:Label ID="lblContactFormCountry" runat="server"></asp:Label>
							<asp:TextBox ID="tbContactFormCountry" CssClass="text" Text="" runat="server" />
							<asp:RequiredFieldValidator ID="rfvContactFormCountry" runat="server" ControlToValidate="tbContactFormCountry" Display="Dynamic" ErrorMessage="Please enter Country name." ValidationGroup="vgContactForm" />
						</div>
						<div runat="server" id="divContactFormPostalCode" visible="false" class="eds_labelAndInput eds_labelWidth100">
							<asp:Label ID="lblContactFormPostalCode" runat="server"></asp:Label>
							<asp:TextBox ID="tbContactFormPostalCode" CssClass="text" Text="" runat="server" />
							<asp:RequiredFieldValidator ID="rfvContactFormPostalCode" runat="server" ControlToValidate="tbContactFormPostalCode" Display="Dynamic" ErrorMessage="Please enter postal code." ValidationGroup="vgContactForm" />
						</div>
						<div runat="server" id="divContactFormTelephone" visible="false" class="eds_labelAndInput eds_labelWidth100">
							<asp:Label ID="lblContactFormTelephone" runat="server"></asp:Label>
							<asp:TextBox ID="tbContactFormTelephone" CssClass="text" Text="" runat="server" />
							<asp:RequiredFieldValidator ID="rfvContactFormTelephone" runat="server" ControlToValidate="tbContactFormTelephone" Display="Dynamic" ErrorMessage="Please enter telephone." ValidationGroup="vgContactForm" />
						</div>
						<div runat="server" id="divContactFormMobile" visible="false" class="eds_labelAndInput eds_labelWidth100">
							<asp:Label ID="lblContactFormMobile" runat="server"></asp:Label>
							<asp:TextBox ID="tbContactFormMobile" CssClass="text" Text="" runat="server" />
							<asp:RequiredFieldValidator ID="rfvContactFormMobile" runat="server" ControlToValidate="tbContactFormMobile" Display="Dynamic" ErrorMessage="Please enter mobile number." ValidationGroup="vgContactForm" />
						</div>
						<div runat="server" id="divContactFormWebsite" visible="false" class="eds_labelAndInput eds_labelWidth100">
							<asp:Label ID="lblContactFormWebsite" runat="server"></asp:Label>
							<asp:TextBox ID="tbContactFormWebsite" CssClass="text" Text="" runat="server" />
							<asp:RequiredFieldValidator ID="rfvContactFormWebsite" runat="server" ControlToValidate="tbContactFormWebsite" Display="Dynamic" ErrorMessage="Please enter website url." ValidationGroup="vgContactForm" />
						</div>
						<div class="eds_labelAndInput eds_labelWidth100 eds_bigInput">
							<asp:Label ID="lblContactFormMessage" runat="server"></asp:Label>
							<asp:TextBox ID="tbContactFormMessage" runat="server" CssClass="eds_bigerInput" TextMode="MultiLine" ValidationGroup="vgContactForm" />
							<asp:RequiredFieldValidator ID="rfvPleaseMessage" runat="server" ControlToValidate="tbContactFormMessage" Display="Dynamic" ErrorMessage="Please enter the message." ValidationGroup="vgContactForm" />
						</div>
						<div runat="server" id="divContactFormCaptcha" visible="false" class="eds_labelAndInput eds_labelWidth100">
							<asp:Label ID="lblContactFormCaptcha" runat="server"></asp:Label>
							<div class="g-contactform-recaptcha"></div>
							<asp:CustomValidator ID="cvContactFormCaptcha" runat="server" ClientValidationFunction="eds_ValidateContactFormCaptcha" Display="Dynamic" ErrorMessage="Please solve captcha." ValidationGroup="vgContactForm" />
							<asp:HiddenField ID="hfContactFormCaptchaResponse" runat="server" />
						</div>
						<div class="edn_bottomButtonWrapper">
							<asp:Button ID="btnSendContactEmail" runat="server" Text="Send" ValidationGroup="vgContactForm" CssClass="submit" OnClick="btnSendContactEmail_Click" />
						</div>
					</asp:Panel>
				</ContentTemplate>
			</asp:UpdatePanel>
			<asp:UpdateProgress ID="uppContactForm" runat="server" AssociatedUpdatePanelID="upContactForm" DisplayAfter="100" DynamicLayout="true">
				<ProgressTemplate>
					<div class="eds_eventRegistrationLoading">
					</div>
				</ProgressTemplate>
			</asp:UpdateProgress>
		</div>
		<span class="eds_modalClose eds_closeWindowButtonOuter" data-target-id='<%=pnlContactForm.ClientID%>'>x</span>
	</div>
</asp:Panel>

<asp:Literal ID="countdisqusJS" runat="server" EnableViewState="false" />