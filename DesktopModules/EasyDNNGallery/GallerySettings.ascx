<%@ control language="C#" inherits="EasyDNN.Modules.EasyDNNGallery.GallerySettings, App_Web_gallerysettings.ascx.af09375b" autoeventwireup="true" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<%@ Register TagPrefix="eds" Namespace="EasyDNN.Modules.EasyDNNGallery" Assembly="App_SubCode_EasyDNNGallery, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null" %>
<script type="text/javascript">
	function ValidateCheckBoxList(sender, args) {
		args.IsValid = false;
		eds1_10("#<%=cblLBMediaSelect.ClientID%>").find(":checkbox").each(function ($) {
			if ($(this).attr("checked")) {
				args.IsValid = true;
				return;
			}
		});
	}
	function cbAction(elem1, elem2) {
		var chk = document.getElementById(elem1);
		var chk2 = document.getElementById(elem2);

		if (chk.checked) {
			chk2.checked = false;
		}
	}

	function cbswitch(elem1, elem2) {
		var chk = document.getElementById(elem1);
		var chk2 = document.getElementById(elem2);

		if (chk.checked == false && chk2.checked == false) {
			chk.checked = true;
		}
	}

	function cbEnable2(melem1, melem2, melem3) {
		var mchk = document.getElementById(melem1);
		var mchk2 = document.getElementById(melem2);
		var mchk3 = document.getElementById(melem3);

		if (mchk.checked) {

			mchk3.disabled = false;
			mchk2.disabled = false;
		}
		else {

			mchk3.disabled = true;
			mchk2.disabled = true;

		}
	}
	eds1_10().ready(function ($) {
		$('#<%=cbSocialMediaBoxShowSocialSharing.ClientID%>, #<%=cbSocialMediaBoxShowDetails.ClientID%>').change(function () {
			var $target = $('.collapsable_container.' + this.id);
			if (this.checked)
				$target.slideDown(200);
			else
				$target.slideUp(200);
		});
	});
</script>
<asp:ObjectDataSource ID="odsGallery" TypeName="EasyDNN.Modules.EasyDNNGallery.DataAcess" runat="server" SelectMethod="GetCatGalleries" OldValuesParameterFormatString="{0}">
	<SelectParameters>
		<asp:ControlParameter ControlID="ddlMainCatSelect" Name="CategoryID" PropertyName="SelectedValue" Type="Int32" />
	</SelectParameters>
</asp:ObjectDataSource>
<div id="mainGallerySettings" runat="server">
	<div id="EDGAdminContent">
		<div class="flashMessages"></div>
		<div class="topBarWrapper">
			<div class="wrapper">
				<ul class="links">
					<li>
						<asp:Label runat="server" ID="lblManagmentSectionTitle" ResourceKey="lblManagmentSectionTitle" Text="Gallery settings"></asp:Label></li>
				</ul>
				<ul class="actions">
					<li class="close">
						<asp:LinkButton ID="btnClose" runat="server" OnClick="btnGSCLose_Click" Text="Close" resourcekey="btncloseResource1" />
					</li>
				</ul>
			</div>
		</div>
		<div class="mainContentWrapper">
			<div class="contentSectionWrapper color1">
				<div class="sectionHeader">
					<div class="titleAndNumber settingsTitle">
						<h4>
							<asp:Label ID="lblGallerySettingsTitle" runat="server" resourcekey="lblGallerySettingsTitle" CssClass="gallerysettings" Text="&lt;b&gt;Gallery&lt;/b&gt; Settings"></asp:Label>
						</h4>
						<p>
							<asp:Label ID="lblGallerySettingsTitleAdjust" resourcekey="lblGallerySettingsTitleAdjust" runat="server" CssClass="adjustview" Text="Adjust your gallery for perfect view"></asp:Label>
						</p>
					</div>
				</div>
				<div class="contentSection gallerySettings">
					<div class="specialOptions">
						<h2>
							<dnn:Label ID="lblSelectDisplayType" ResourceKey="lblSelectDisplayType" runat="server" Text="Select type of display" HelpText="Select the type of display to display gallery media:" HelpKey="lblSelectDisplayType.HelpText"></dnn:Label>
						</h2>
					</div>
					<div class="content noTopPadding">
						<eds:EdsRadioButtonList ID="rblDisplaySelect" runat="server" AutoPostBack="True" OnSelectedIndexChanged="rblDisplaySelect_SelectedIndexChanged" CssClass="styledRadio displayType" RepeatLayout="Flow" RepeatColumns="25" RepeatDirection="Vertical">
							<asp:ListItem Value="mostPopular" CssClass="displaySettingsTitle normalRadioButton" resourcekey="MostPopular">Most Popular</asp:ListItem>
							<asp:ListItem Value="gravityGallery" CssClass="displayTypeThumbnail fourInRow gravityGallery normalRadioButton" resourcekey="GravityGallery"><span class="presetName">Gravity Gallery</span><span>(Images, Video, Audio)</span><span class="aditional">responsive</span></asp:ListItem>
							<asp:ListItem Value="gravityPortfolio" CssClass="displayTypeThumbnail fourInRow gravityPortfolio normalRadioButton"><span class="presetName">Gravity Portfolio</span><span>(Images, Video, Audio)</span><span class="aditional">responsive</span></asp:ListItem>
							<asp:ListItem Value="Chameleon" CssClass="displayTypeThumbnail fourInRow chameleonGallery normalRadioButton" resourcekey="ListItemResourceChameleon"><span class="presetName">Chameleon gallery</span><span>(Images, Video, Audio)</span><span class="aditional">responsive</span></asp:ListItem>
							<asp:ListItem Value="PortfolioPro" CssClass="displayTypeThumbnail fourInRow portfolioPro normalRadioButton" resourcekey="PortfolioPro"><span class="presetName">Portfolio Pro</span><span>(Images, video)</span><span class="aditional">responsive</span></asp:ListItem>
							<asp:ListItem Value="tablegallery" CssClass="displayTypeThumbnail fourInRow lightBoxGallery normalRadioButton" resourcekey="ListItemResource3"><span class="presetName">Lightbox Gallery</span><span>(Images, Video, Audio)</span><span class="aditional">responsive</span></asp:ListItem>
							<asp:ListItem Value="portfolio" CssClass="displayTypeThumbnail fourInRow lightBoxPortfolioGallery normalRadioButton" resourcekey="ListItemPortfolio"><span class="presetName">Lightbox portfolio gallery</span><span>(Images, Video, Audio)</span><span class="aditional">responsive</span></asp:ListItem>
							<asp:ListItem Value="ImageSlider" CssClass="displayTypeThumbnail fourInRow imageSlider1 normalRadioButton" resourcekey="ListItemResource9"><span class="presetName">Image Slider 1</span><span>(Images)</span><span class="aditional">responsive</span></asp:ListItem>
							<asp:ListItem Value="ImageCarousel" CssClass="displayTypeThumbnail fourInRow imageCarousel normalRadioButton" resourcekey="ListItemResource10"><span class="presetName">Image Carousel</span><span>(Images)</span><span class="aditional">responsive</span></asp:ListItem>
							<asp:ListItem Value="ssthumbs3" CssClass="displayTypeThumbnail fourInRow slideshowWithThumbnails3 normalRadioButton" resourcekey="ListItemResourceSS3"><span class="presetName">Slideshow with thumbnails 3</span><span>(Images)</span><span class="aditional">responsive</span></asp:ListItem>
							<asp:ListItem Value="other" CssClass="displaySettingsTitle normalRadioButton" resourcekey="Other">Other</asp:ListItem>
							<asp:ListItem Value="lightbox2" CssClass="twoInRow normalRadioButton" resourcekey="lightbox2Resource">LightBox Caption Slider (images, video, audio)</asp:ListItem>
							<asp:ListItem Value="slideshow" CssClass="twoInRow normalRadioButton" resourcekey="ListItemResource4">Slide Show (Images)</asp:ListItem>
							<asp:ListItem Value="ssthumbs" CssClass="twoInRow normalRadioButton" resourcekey="ListItemResource5">Slideshow with thumbnails (Images)</asp:ListItem>
							<asp:ListItem Value="ssthumbs2" CssClass="twoInRow normalRadioButton" resourcekey="ListItemResourceSS2">Slideshow with thumbnails 2 (Images)</asp:ListItem>
							<asp:ListItem Value="AdvancedSlideShow" CssClass="twoInRow normalRadioButton" resourcekey="ASSListItem">Advanced Slide Show</asp:ListItem>
							<asp:ListItem Value="VideoGallery" CssClass="twoInRow normalRadioButton" resourcekey="ListItemResource7">Video Gallery (Video)</asp:ListItem>
							<asp:ListItem Value="videogallery2" CssClass="twoInRow normalRadioButton" resourcekey="VideoGallery2">Video Gallery 2 (Video)</asp:ListItem>
							<asp:ListItem Value="videogallery3" CssClass="twoInRow normalRadioButton" resourcekey="VideoGallery3">Video Gallery 3 (Video)</asp:ListItem>
							<asp:ListItem Value="audiogallery" CssClass="twoInRow normalRadioButton" resourcekey="ListItemResource8">Audio Gallery (Audio)</asp:ListItem>
							<asp:ListItem Value="audiogallery2" CssClass="twoInRow normalRadioButton" resourcekey="audiogallery2">Audio Gallery 2 (Audio)</asp:ListItem>
							<asp:ListItem Value="verticalcarousel" CssClass="twoInRow normalRadioButton" resourcekey="ListItemResourceVC">Vertical Carousel (Images, Video, Audio)</asp:ListItem>
							<asp:ListItem Value="streaming" CssClass="twoInRow normalRadioButton" resourcekey="ListItemResourceStreaming">Streaming Video</asp:ListItem>
							<asp:ListItem Value="smbJournal" CssClass="twoInRow normalRadioButton" resourcekey="liSmbForJournal"><span style="color: #0070b1; font-weight: bold;">SocialMediaBox for DNN Journal</span></asp:ListItem>
							<asp:ListItem Value="FlashGallery" CssClass="twoInRow normalRadioButton" style="visibility: hidden" resourcekey="ListItemResource6">Flash Tab Gallery (Images, FLV video)</asp:ListItem>
						</eds:EdsRadioButtonList>
						<asp:PlaceHolder runat="server" ID="phGallerySettingsControl"></asp:PlaceHolder>
						<asp:Panel ID="pnlGalleryOptions" runat="server">
							<asp:ObjectDataSource ID="odsLastModifiedGals" TypeName="EasyDNN.Modules.EasyDNNGallery.DataAcess" runat="server" SelectMethod="GetTop10Galeries" OldValuesParameterFormatString="original_{0}">
								<SelectParameters>
									<asp:Parameter Name="PortalID" Type="Int32" />
								</SelectParameters>
							</asp:ObjectDataSource>
							<div class="paddingTopBottom">
								<div class="styledCheckbox">
									<asp:CheckBox ID="cbShowUserImages" runat="server" AutoPostBack="True" OnCheckedChanged="cbShowUserImages_CheckedChanged" Text="Show user Images" Visible="False" />
								</div>
								<asp:Panel ID="pnlUserGallerySettings" runat="server" Visible="false" CssClass="optionsPanel separator">
									<table>
										<tr>
											<td class="labels">
												<asp:Label ID="lblUserGalleriesShowAll" resourcekey="lblUserGalleriesShowAll" runat="server" Text="Select galleries to show images from:"></asp:Label>
											</td>
											<td>
												<asp:RadioButtonList ID="rblUserGalleryDisplay" runat="server" AutoPostBack="True" RepeatDirection="Horizontal" OnSelectedIndexChanged="rblUserGalleryDisplay_SelectedIndexChanged" CssClass="styledRadio small">
													<asp:ListItem resourcekey="liShowAll" Value="ShowAll" Selected="True">Show all</asp:ListItem>
													<asp:ListItem resourcekey="liShowCategories" Value="select">Select categories to show galleries from</asp:ListItem>
												</asp:RadioButtonList>
											</td>
										</tr>
										<tr>
											<td></td>
											<td>
												<div class="styledCheckbox">
													<asp:CheckBoxList ID="cblUserCategoriesSelect" runat="server" DataTextField="CategoryName" DataValueField="CategoryID" RepeatColumns="3" RepeatDirection="Horizontal" Visible="False"></asp:CheckBoxList>
												</div>
											</td>
										</tr>
										<tr>
											<td class="labels">
												<asp:Label ID="lblUserGalleriesDisplayType" resourcekey="lblUserGalleriesDisplayType" runat="server" Text="Select meida display mode:"></asp:Label>
											</td>
											<td>
												<asp:RadioButtonList ID="rblUserGalleriesDisplayMode" runat="server" RepeatDirection="Horizontal" AutoPostBack="True" OnSelectedIndexChanged="rblUserGalleriesDisplayMode_SelectedIndexChanged" CssClass="styledRadio small">
													<asp:ListItem resourcekey="liDisplayAsNested" Selected="True" Value="nested">Display as nested galleries</asp:ListItem>
													<asp:ListItem resourcekey="liDisplayAllInOne" Value="one">Display all user images in one gallery</asp:ListItem>
												</asp:RadioButtonList>
											</td>
										</tr>
									</table>
								</asp:Panel>
							</div>
							<div class="optionsPanel separator" id="pnlCatGalSelection" runat="server">
								<table class="halfWidthTd">
									<tr>
										<td>
											<asp:Panel ID="pnlPortalSharing" runat="server" CssClass="optionsBox color5 portalSharing">
												<h4>
													<asp:Label ID="lblPortalSharing" runat="server" resourcekey="lblPortalSharing" Text="Select portal:"></asp:Label>
												</h4>
												<div class="styledSelect fullWidth">
													<asp:DropDownList ID="ddlPortalSharing" runat="server" AppendDataBoundItems="True" AutoPostBack="True" DataTextField="PortalName" DataValueField="PortalIDFrom" OnSelectedIndexChanged="ddlPortalSharing_SelectedIndexChanged">
														<asp:ListItem resourcekey="liCurrentPortal" Value="-1">Current portal</asp:ListItem>
													</asp:DropDownList>
												</div>
											</asp:Panel>
											<div class="optionsBox color3 categorySelect">
												<h4>
													<asp:Label ID="lblCategorySelect" runat="server" Text="Select category:" resourcekey="lblCategorySelectResource1"></asp:Label>
												</h4>
												<div class="styledSelect fullWidth">
													<asp:DropDownList ID="ddlMainCatSelect" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlMainCatSelect_SelectedIndexChanged" DataTextField="CategoryName" DataValueField="CategoryID" AppendDataBoundItems="True"></asp:DropDownList>
												</div>
												<asp:RequiredFieldValidator CssClass="smallInfo error" ID="rfvMainCatSelect" InitialValue="-1" runat="server" ControlToValidate="ddlMainCatSelect" ErrorMessage="Please select category." SetFocusOnError="True" ValidationGroup="vvNema" Display="Dynamic"></asp:RequiredFieldValidator>
												<asp:Label CssClass="infoMessages error static" runat="server" ID="lblSelectMainCat" Text="Please select category." Visible="False"></asp:Label>
											</div>
											<div class="optionsBox color2 gallerySelect">
												<h4>
													<asp:Label ID="lblGallerySelect" runat="server" Text="Select gallery: " resourcekey="lblGallerySelectResource1"></asp:Label>
												</h4>
												<div class="styledSelect fullWidth">
													<asp:DropDownList ID="ddlGallerySelect" runat="server" AutoPostBack="True" CausesValidation="True" DataSourceID="odsGallery" DataTextField="GalleryName" DataValueField="GalleryID" OnDataBound="ddlGallerySelect_DataBound" OnSelectedIndexChanged="ddlGallerySelect_SelectedIndexChanged">
														<asp:ListItem resourcekey="ListItemResource2"></asp:ListItem>
													</asp:DropDownList>
												</div>
												<asp:RequiredFieldValidator CssClass="smallInfo error" ID="rfvGallerySelect" runat="server" ControlToValidate="ddlGallerySelect" ErrorMessage="Please select gallery." SetFocusOnError="True" ValidationGroup="vvNema" resourcekey="rfvGallerySelectResource1.ErrorMessage" Display="Dynamic"></asp:RequiredFieldValidator>
												<asp:Label CssClass="infoMessages error static" ID="lblSelectMainGallery" runat="server" Text="Please select gallery." Visible="False"></asp:Label>
											</div>
										</td>
										<td>
											<div class="optionsBox color2 selectLastModifiedGallery">
												<h4>
													<asp:Label ID="lblSelectLastModifiedGallery" resourcekey="lblSelectLastModifiedGallery" runat="server" Text="Select last modified gallery:"></asp:Label>
												</h4>
												<div class="styledSelect fullWidth">
													<asp:DropDownList ID="ddlLastModifiedGalleries" runat="server" AutoPostBack="True" DataSourceID="odsLastModifiedGals" DataTextField="GalleryName" DataValueField="GalleryID" OnSelectedIndexChanged="ddlLastModifiedGalleries_SelectedIndexChanged" AppendDataBoundItems="True" CausesValidation="True" CssClass="ddlcategorysettings">
														<asp:ListItem Value="select" resourcekey="ListItemResource1">Select gallery</asp:ListItem>
													</asp:DropDownList>
												</div>
											</div>
										</td>
									</tr>
								</table>
							</div>
							<div class="contentSection lightBoxSelect negativeMargins40" id="pnlMainLbOptions" runat="server">
								<div class="specialOptions">
									<h2>
										<dnn:Label ID="lblLightBoxTypeSelection" runat="server" Text="Select the type of Ligtbox:" HelpText="Select the type of Ligtbox:" ResourceKey="lblLightBoxTypeSelection" HelpKey="lblLightBoxTypeSelection.HelpText"></dnn:Label>
									</h2>
									<div class="optionsList">
										<asp:RadioButtonList ID="rblSelectLightBoxType" runat="server" AutoPostBack="True" CssClass="styledRadio" OnSelectedIndexChanged="rblSelectLightBoxType_SelectedIndexChanged" RepeatDirection="Horizontal">
											<asp:ListItem resourcekey="liSocialMediaBoxLite" Value="smblite">SocialMediaBox Lite</asp:ListItem>
											<asp:ListItem resourcekey="liSocialMediaBoxPlus" Value="smbplus">SocialMediaBox Plus</asp:ListItem>
											<asp:ListItem resourcekey="lisocialmediabox" Value="socialmediabox"><b>SocialMediaBox </b><span>(Allows comments, ratings, social sharing and more)</span></asp:ListItem>
											<asp:ListItem resourcekey="liprettyphoto" Selected="True" Value="prettyphoto">prettyPhoto</asp:ListItem>
										</asp:RadioButtonList>
									</div>
								</div>
							</div>
							<div class="optionsPanel paddingTopBottom" id="trSmblite" runat="server" visible="false">
								<table>
									<tr>
										<td class="labels">
											<dnn:Label ID="lblSmbLiteShowTitle" ResourceKey="lblSmbLiteShowTitle" runat="server" Text="Show title:" HelpText="Show title."></dnn:Label>
										</td>
										<td>
											<div class="styledCheckbox noLabel big">
												<asp:CheckBox ID="cbSmbLiteShowTitle" runat="server" Checked="True" Text="Show title" />
											</div>
										</td>
									</tr>
									<tr>
										<td class="labels">
											<dnn:Label ID="lblSmbLitewrapperResizeDuration" ResourceKey="lblSmbLitewrapperResizeDuration" runat="server" Text="Transition effect:" HelpText="Transition effect."></dnn:Label>
										</td>
										<td>
											<asp:RadioButtonList ID="rblSmbLitewrapperResizeDuration" runat="server" RepeatDirection="Horizontal" CssClass="styledRadio">
												<asp:ListItem resourcekey="liNone" Value="0">None</asp:ListItem>
												<asp:ListItem resourcekey="liFast" Value="1" Selected="True">Fast</asp:ListItem>
												<asp:ListItem resourcekey="liSlow" Value="2" Selected="False">Slow</asp:ListItem>
											</asp:RadioButtonList>
										</td>
									</tr>
									<tr>
										<td class="labels">
											<dnn:Label ID="lblSmbLiteShowSocialSharing" ResourceKey="lblSmbLiteShowSocialSharing" runat="server" Text="Show social sharing buttons:" HelpText="Show social sharing buttons."></dnn:Label>
										</td>
										<td>
											<asp:Panel ID="pnlSmbLiteSocialSharingButons" runat="server" CssClass="styledCheckbox big">
												<asp:CheckBox ID="cbSmbLiteShowFacebook" resourcekey="cbSmbLiteShowFacebook" runat="server" Text="Facebook" Checked="True" />
												<asp:CheckBox ID="cbSmbLiteShowGooglePlus" resourcekey="cbSmbLiteShowGooglePlus" runat="server" Text="Google+" Checked="True" />
												<asp:CheckBox ID="cbSmbLiteShowTwitter" resourcekey="cbSmbLiteShowTwitter" runat="server" Text="Twitter" Checked="True" />
												<asp:CheckBox ID="cbSmbLiteShowPintrest" resourcekey="cbSmbLiteShowPintrest" runat="server" Text="Pinterest" Checked="True" />
												<asp:CheckBox ID="cbSmbLiteShowLinkedIn" resourcekey="cbSmbLiteShowLinkedIn" runat="server" Text="LinkedIn" Checked="True" />
											</asp:Panel>
										</td>
									</tr>
								</table>
							</div>
							<div class="optionsPanel paddingTopBottom" id="tredsLightboxOptions" runat="server" visible="false">
								<table>
									<tr>
										<td class="labels">
											<dnn:Label ID="lblsmbShowThumbnails" runat="server" Text="Show thumbnails panel:" HelpText="Show thumbnails panel:" ResourceKey="lblsmbShowThumbnails" HelpKey="lblsmbShowThumbnails.HelpText"></dnn:Label>
										</td>
										<td>
											<div class="styledCheckbox noLabel">
												<asp:CheckBox ID="cbSmbShowThumbnails" runat="server" Text="Show thumbnails panel" />
											</div>
										</td>
									</tr>
									<tr id="trSmbShowdetails" runat="server">
										<td class="labels">
											<dnn:Label ID="lblsmbShowDetailsPanel" runat="server" Text="Show Item details panel:" HelpText="Show Item details panel:" HelpKey="lblsmbShowDetailsPanel.HelpText" ResourceKey="lblsmbShowDetailsPanel"></dnn:Label>
										</td>
										<td>
											<div class="styledCheckbox noLabel">
												<asp:CheckBox ID="cbSocialMediaBoxShowDetails" runat="server" Text="Show Item details panel" />
											</div>
										</td>
									</tr>
								</table>
								<div class="optionsPanel paddingTopBottom" id="tblSmbOPtions" runat="server">
									<table>
										<tr>
											<td class="labels">
												<dnn:Label ID="lblSmbShowTitle" runat="server" Text="Show title:" HelpText="Show title:" ResourceKey="lblSmbShowTitle" HelpKey="lblSmbShowTitle.HelpText"></dnn:Label>
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbSmbShowTitle" runat="server" Text="Show title" />
												</div>
											</td>
										</tr>
										<tr>
											<td class="labels">
												<dnn:Label ID="lblSmbShowDescription" runat="server" Text="Show description:" HelpText="Show description:" ResourceKey="lblSmbShowDescription" HelpKey="lblSmbShowDescription.HelpText"></dnn:Label>
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbSmbShowDescription" runat="server" Text="Show description" />
												</div>
											</td>
										</tr>
										<tr id="trsmbSocialSharing" runat="server">
											<td class="labels">
												<dnn:Label ID="lblSocialMediaBoxShowSocialSharing" runat="server" Text="Show social sharing buttons:" HelpText="Show social sharing buttons" ResourceKey="lblSocialMediaBoxShowSocialSharing" HelpKey="lblSocialMediaBoxShowSocialSharing.HelpText"></dnn:Label>
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbSocialMediaBoxShowSocialSharing" runat="server" Text="Show social sharing buttons" />
												</div>
											</td>
										</tr>
										<tr id="trsmbSocialSharingButons" runat="server">
											<td class="labels">
												<dnn:Label ID="lblSmbSelectSocIalButtons" runat="server" Text="Select sharing buttons:" HelpText="Select sharing buttons" ResourceKey="lblSmbSelectSocIalButtons" HelpKey="lblSmbSelectSocIalButtons.HelpText"></dnn:Label>
											</td>
											<td>
												<div class="styledCheckbox">
													<asp:CheckBox ID="cbSmbShowFacebook" runat="server" Text="Facebook" resourcekey="cbSmbShowFacebook" />
													<asp:CheckBox ID="cbSmbShowTwitter" runat="server" Text="Twitter" resourcekey="cbSmbShowTwitter" />
													<asp:CheckBox ID="cbSmbShowGooglePlus" runat="server" Text="Google Plus" resourcekey="cbSmbShowGooglePlus" />
													<asp:CheckBox ID="cbSmbShowLinkedIn" runat="server" Text="LinkedIn" resourcekey="cbSmbShowLinkedIn" />
													<asp:CheckBox ID="cbSmbShowPintrest" runat="server" Text="Pinterest" resourcekey="cbSmbShowPintrest" />
												</div>
											</td>
										</tr>
										<tr>
											<td class="labels">
												<dnn:Label ID="lblsmbShowEmail" runat="server" Text="Show email link:" HelpKey="lblsmbShowEmail.HelpText" HelpText="Show email link:" ResourceKey="lblsmbShowEmail"></dnn:Label>
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbsmbShowEmailLink" runat="server" Text="Show email link" />
												</div>
											</td>
										</tr>
										<tr>
											<td class="labels">
												<dnn:Label ID="lblsmbShowUploaderInfo" runat="server" Text="Show user info:" HelpText="Show information about the user who added the image or other media." HelpKey="lblsmbShowUploaderInfo.HelpText" ResourceKey="lblsmbShowUploaderInfo"></dnn:Label>
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbSmbShowUploaderInfo" runat="server" Text="Show user info" />
												</div>
											</td>
										</tr>
										<tr>
											<td class="labels">
												<dnn:Label ID="lblSmbAvatarProvider" runat="server" Text="Select avatar provider:" HelpKey="lblSmbAvatarProvider.HelpText" ResourceKey="lblSmbAvatarProvider" HelpText="Select avatar provider:"></dnn:Label>
											</td>
											<td>
												<asp:RadioButtonList ID="rblSmbAvatarProvider" runat="server" RepeatDirection="Horizontal" CssClass="styledRadio small">
													<asp:ListItem resourcekey="liGravatar" Selected="True" Value="1">Gravatar</asp:ListItem>
													<asp:ListItem resourcekey="liDNNProfile" Value="2">DNN profile</asp:ListItem>
													<asp:ListItem resourcekey="liNoAvatars" Value="0">No avatars</asp:ListItem>
												</asp:RadioButtonList>
											</td>
										</tr>
										<tr>
											<td class="labels">
												<dnn:Label ID="lblSmbPostCommentTojournal" runat="server" Text="Post comment notification to Journal:" HelpKey="lblSmbPostCommentTojournal.HelpText" ResourceKey="lblSmbPostCommentTojournal" HelpText="When someone adds a comment, the notice of added comment will be posted on Journal."></dnn:Label>
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbSmbPostCommentToJournal" runat="server" Text="Post comment notification to Journal" />
												</div>
											</td>
										</tr>
									</table>
									<div id="trSmbPermissions" runat="server" class="listItems additionalOptions color1">
										<div id="pnlAllSettings" runat="server">
											<div id="pnlPermissions" runat="server">
												<asp:GridView ID="gvRolePermisionSettings" runat="server" CssClass="additionalOptionsList fullWidthTable" AutoGenerateColumns="False" DataKeyNames="RoleID" CellPadding="0" OnRowDataBound="gvRolePermisionSettings_RowDataBound">
													<Columns>
														<asp:TemplateField HeaderText="Roles">
															<ItemTemplate>
																<strong>
																	<asp:Label ID="lblRoleName" runat="server" Text='<%#Eval("RoleName")%>' resourcekey="lblRoleNameResource1"></asp:Label>
																</strong>
															</ItemTemplate>
															<HeaderStyle />
															<ItemStyle />
														</asp:TemplateField>
														<asp:TemplateField HeaderText="Show comments">
															<ItemTemplate>
																<asp:HiddenField ID="hfRoleID" runat="server" Value='<%# GetRoleID(Eval("RoleID"))%>' />
																<asp:HiddenField ID="hfRoleName" runat="server" Value='<%# Eval("RoleName") %>' />
																<asp:CheckBox ID="cbShowComments" runat="server" Checked='<%#Convert.ToBoolean(Eval("ShowComments"))%>' />
															</ItemTemplate>
															<ItemStyle HorizontalAlign="Center" />
														</asp:TemplateField>
														<asp:TemplateField HeaderText="Enable commenting">
															<ItemTemplate>
																<asp:CheckBox ID="cbAllowToComment" runat="server" Checked='<%#Convert.ToBoolean(Eval("AllowToComment"))%>' />
															</ItemTemplate>
															<ItemStyle HorizontalAlign="Center" />
														</asp:TemplateField>
														<asp:TemplateField HeaderText="Enable comment editing">
															<ItemTemplate>
																<asp:CheckBox ID="cbCommentEditing" runat="server" Checked='<%#Convert.ToBoolean(Eval("CommentEditing"))%>' />
															</ItemTemplate>
															<ItemStyle HorizontalAlign="Center" />
														</asp:TemplateField>
														<asp:TemplateField HeaderText="Enable comment deleting">
															<ItemTemplate>
																<asp:CheckBox ID="cbCommentDeleting" runat="server" Checked='<%#Convert.ToBoolean(Eval("CommentDeleting"))%>' />
															</ItemTemplate>
															<ItemStyle HorizontalAlign="Center" />
														</asp:TemplateField>
														<asp:TemplateField HeaderText="Show rating">
															<ItemTemplate>
																<asp:CheckBox ID="cbShowrating" runat="server" Checked='<%#Convert.ToBoolean(Eval("Showrating"))%>' />
															</ItemTemplate>
															<ItemStyle HorizontalAlign="Center" />
														</asp:TemplateField>
														<asp:TemplateField HeaderText="Enable rating">
															<ItemTemplate>
																<asp:CheckBox ID="cbAllowToRate" runat="server" Checked='<%#Convert.ToBoolean(Eval("AllowToRate"))%>' />
															</ItemTemplate>
															<ItemStyle HorizontalAlign="Center" />
														</asp:TemplateField>
														<asp:TemplateField HeaderText="Enable Liking">
															<ItemTemplate>
																<asp:CheckBox ID="cbAllowToLike" runat="server" Checked='<%#Convert.ToBoolean(Eval("AllowToLike"))%>' />
															</ItemTemplate>
															<ItemStyle HorizontalAlign="Center" />
														</asp:TemplateField>
														<asp:TemplateField HeaderText="Enable download">
															<ItemTemplate>
																<asp:CheckBox ID="cbAllowToDownload" runat="server" Checked='<%#Convert.ToBoolean(Eval("AllowToDownload"))%>' />
															</ItemTemplate>
															<ItemStyle HorizontalAlign="Center" />
														</asp:TemplateField>
													</Columns>
												</asp:GridView>
												<asp:GridView ID="gvUserPermisionSettings" runat="server" CssClass="additionalOptionsList fullWidthTable marginTop30" AutoGenerateColumns="False" DataKeyNames="UserID" CellPadding="0" OnRowCommand="gvUserNotificationSettings_RowCommand">
													<Columns>
														<asp:TemplateField HeaderText="Users">
															<ItemTemplate>
																<strong>
																	<asp:Label ID="lblUserName" runat="server" Text='<%#Eval("UserName")%>' resourcekey="lblRoleNameResource1"></asp:Label>
																</strong>
															</ItemTemplate>
															<HeaderStyle />
															<ItemStyle />
														</asp:TemplateField>
														<asp:TemplateField HeaderText="Show comments">
															<ItemTemplate>
																<asp:HiddenField ID="hfUserID" runat="server" Value='<%# Eval("UserID") %>' />
																<asp:HiddenField ID="hfUsername" runat="server" Value='<%# Eval("Username") %>' />
																<asp:CheckBox ID="cbShowComments" runat="server" Checked='<%#Convert.ToBoolean(Eval("ShowComments"))%>' />
															</ItemTemplate>
															<ItemStyle HorizontalAlign="Center" />
														</asp:TemplateField>
														<asp:TemplateField HeaderText="Enable commenting">
															<ItemTemplate>
																<asp:CheckBox ID="cbAllowToComment" runat="server" Checked='<%#Convert.ToBoolean(Eval("AllowToComment"))%>' />
															</ItemTemplate>
															<ItemStyle HorizontalAlign="Center" />
														</asp:TemplateField>
														<asp:TemplateField HeaderText="Enable comment editing">
															<ItemTemplate>
																<asp:CheckBox ID="cbCommentEditing" runat="server" Checked='<%#Convert.ToBoolean(Eval("CommentEditing"))%>' />
															</ItemTemplate>
															<ItemStyle HorizontalAlign="Center" />
														</asp:TemplateField>
														<asp:TemplateField HeaderText="Enable comment deleting">
															<ItemTemplate>
																<asp:CheckBox ID="cbCommentDeleting" runat="server" Checked='<%#Convert.ToBoolean(Eval("CommentDeleting"))%>' />
															</ItemTemplate>
															<ItemStyle HorizontalAlign="Center" />
														</asp:TemplateField>
														<asp:TemplateField HeaderText="Show rating">
															<ItemTemplate>
																<asp:CheckBox ID="cbShowrating" runat="server" Checked='<%#Convert.ToBoolean(Eval("Showrating"))%>' />
															</ItemTemplate>
															<ItemStyle HorizontalAlign="Center" />
														</asp:TemplateField>
														<asp:TemplateField HeaderText="Enable rating">
															<ItemTemplate>
																<asp:CheckBox ID="cbAllowToRate" runat="server" Checked='<%#Convert.ToBoolean(Eval("AllowToRate"))%>' />
															</ItemTemplate>
															<ItemStyle HorizontalAlign="Center" />
														</asp:TemplateField>
														<asp:TemplateField HeaderText="Enable Liking">
															<ItemTemplate>
																<asp:CheckBox ID="cbAllowToLike" runat="server" Checked='<%#Convert.ToBoolean(Eval("AllowToLike"))%>' />
															</ItemTemplate>
															<ItemStyle HorizontalAlign="Center" />
														</asp:TemplateField>
														<asp:TemplateField HeaderText="Enable download">
															<ItemTemplate>
																<asp:CheckBox ID="cbAllowToDownload" runat="server" Checked='<%#Convert.ToBoolean(Eval("AllowToDownload"))%>' />
															</ItemTemplate>
															<ItemStyle HorizontalAlign="Center" />
														</asp:TemplateField>
														<asp:TemplateField HeaderText="">
															<ItemTemplate>
																<div class="itemActions itemEditActions">
																	<asp:LinkButton ID="lbUserPermissionsRemove" resourcekey="lbUserPermissionsRemove" runat="server" CausesValidation="False" CommandArgument='<%#Eval("UserID")%>' CommandName="Remove" OnClientClick="return confirm('Are you sure you want to remove this user notifications?');" Text="Remove" CssClass="itemEditRemove"></asp:LinkButton>
																</div>
															</ItemTemplate>
														</asp:TemplateField>
													</Columns>
												</asp:GridView>
											</div>
										</div>
										<div class="optionsPanel">
											<table cssclass="marginTop30">
												<tr>
													<td>
														<asp:Label ID="lblAdduserMessage" runat="server" EnableViewState="False" />
													</td>
												</tr>
												<tr>
													<td>
														<asp:Label ID="lblUsernameToAdd" resourcekey="lblUsernameToAdd" runat="server" Text="Add user by username:" Font-Bold="True" />
														<asp:TextBox ID="tbUserNameToAdd" runat="server" CssClass="large" />
														<div class="itemActions itemEditActions">
															<asp:LinkButton ID="lbUsernameAddPermissions" runat="server" resourcekey="lbUsernameAddPermissions" Text="Add" OnClick="lbUsernameAddPermissions_Click" CssClass="itemEditAdd" />
														</div>
													</td>
												</tr>
											</table>
										</div>
									</div>
								</div>
							</div>
							<div class="optionsPanel paddingTopBottom">
								<table>
									<tr id="trppOptions" runat="server">
										<td class="labels textTop">
											<dnn:Label ID="lblLightBoxThemeSelect" ResourceKey="lblLightBoxThemeSelect" runat="server" Text="Select lightbox theme:" HelpText="Select the theme for lightbox:" HelpKey="lblLightBoxThemeSelect.HelpText"></dnn:Label>
										</td>
										<td>
											<asp:RadioButtonList ID="rblLightboxType" runat="server" CssClass="styledRadio small">
												<asp:ListItem Value="pp_default" resourcekey="ListItemResourceBlackAndWhite" Selected="True">Black and white modern</asp:ListItem>
												<asp:ListItem Value="light_rounded" resourcekey="ListItemResource11">Light rounded</asp:ListItem>
												<asp:ListItem Value=" light_square" resourcekey="ListItemResource12"> Light square</asp:ListItem>
												<asp:ListItem Value="dark_rounded" resourcekey="ListItemResource13">Dark rounded</asp:ListItem>
												<asp:ListItem Value="dark_square" resourcekey="ListItemResource14">Dark square</asp:ListItem>
												<asp:ListItem Value="facebook" resourcekey="ListItemResource15">Black and white rounded</asp:ListItem>
											</asp:RadioButtonList>
										</td>
									</tr>
									<tr id="trppOptionsSocialSharing" runat="server">
										<td class="labels textTop">
											<dnn:Label ID="lblLightBoxImageOptions" runat="server" Text="Lightbox image options:" HelpText="Lightbox image options:" HelpKey="lblLightBoxImageOptions.HelpText" ResourceKey="lblLightBoxImageOptions"></dnn:Label>
										</td>
										<td>
											<div class="styledCheckbox">
												<asp:CheckBox ID="cbShowPrintButton" resourcekey="cbShowPrintButton" runat="server" Text="Show print button" />
											</div>
											<div class="styledCheckbox">
												<asp:CheckBox ID="cbShowEmailButton" resourcekey="cbShowEmailButton" runat="server" Text="Show email button" />
											</div>
											<div class="styledCheckbox">
												<asp:CheckBox ID="cbEnableSocialSharing" resourcekey="cbEnableSocialSharing" runat="server" Text="Enable social sharing" />
											</div>
										</td>
									</tr>
									<tr id="trCustomJquery" runat="server">
										<td class="labels textTop">
											<dnn:Label ID="lblLightBoxJquerySelect" runat="server" Text="Include jQuery:" HelpText="Include jQuery:" HelpKey="lblLightBoxJquerySelect.HelpText" ResourceKey="lblLightBoxJquerySelect"></dnn:Label>
										</td>
										<td>
											<asp:RadioButtonList ID="rblIncludejQuery" runat="server" AutoPostBack="True" OnSelectedIndexChanged="rblIncludejQuery_SelectedIndexChanged" RepeatDirection="Horizontal" CssClass="styledRadio small">
												<asp:ListItem resourcekey="liUseDafultSettings" Selected="True" Value="default">Use default settings</asp:ListItem>
												<asp:ListItem resourcekey="liCustomizeForThisModuleSettings" Value="custom">Customize for this module</asp:ListItem>
											</asp:RadioButtonList>
											<div class="styledCheckbox paddingTop">
												<asp:CheckBox ID="cbIncludeJquery" runat="server" Checked="True" Visible="False" Text="Include jQuery" ResourceKey="lblLightBoxJquerySelect2" />
											</div>
										</td>
									</tr>
								</table>
							</div>
							<div class="optionsPanel separator">
								<table>
									<tr id="trJpegQuality" runat="server">
										<td class="labels">
											<dnn:Label ID="lblJpegQuality" ResourceKey="lblJpegQuality" runat="server" Text="Jpeg quality:" HelpText="Jpeg quality."></dnn:Label>
										</td>
										<td>
											<asp:TextBox ID="tbJpegQuality" runat="server" Visible="True" CssClass="small textCenter">97</asp:TextBox>
											<asp:RangeValidator ID="rvJpegQuality" runat="server" ControlToValidate="tbJpegQuality" Display="Dynamic" ErrorMessage="Enter value between 0-100." MaximumValue="100" MinimumValue="0" resourcekey="rvAGVolume0Resource1.ErrorMessage" SetFocusOnError="True" Type="Integer" CssClass="smallInfo warning"></asp:RangeValidator>
										</td>
									</tr>
								</table>
							</div>
							<div class="contentSection blogIntegration paddingTopBottom">
								<div class="specialOptions negativeMargins40">
									<h2>
										<asp:Label ID="lblEditIntegration" runat="server" CssClass="settingsinttitle" Text="Edit Integration" resourcekey="lblEditIntegrationResource1"></asp:Label>
									</h2>
									<div class="optionsList paddingTopBottom" id="tblIntegrate" runat="server">
										<div class="styledCheckbox">
											<asp:CheckBox ID="cbIntegrateGalleryWithBlog" runat="server" OnCheckedChanged="cbIntegrate_CheckedChanged" Text="Integrate this gallery display with news or blog module" AutoPostBack="True" Font-Bold="True" resourcekey="cbIntegrateGalleryWithBlogResource1" />
										</div>
									</div>
								</div>
								<asp:Panel ID="pnlBlogIntegrate" runat="server" Visible="False" CssClass="optionsPanel paddingTopBottom">
									<table>
										<tr>
											<td class="labels">
												<dnn:Label ID="lblQueryString" ResourceKey="lblQueryString" runat="server" Text="Enter query string:" ControlName="tbQueryString" HelpText="Enter the query string of blog module:" HelpKey="lblQueryString.HelpText"></dnn:Label>
											</td>
											<td>
												<asp:TextBox ID="tbQueryString" runat="server" Style="margin-left: 0px" Width="100px"></asp:TextBox>
												<asp:RequiredFieldValidator ID="rfvIntegrationQueryString" runat="server" ControlToValidate="tbQueryString" Display="Dynamic" ErrorMessage="This field is required." resourcekey="rfvIntegrationQueryStringResource1.ErrorMessage" CssClass="smallInfo warning"></asp:RequiredFieldValidator>
											</td>
										</tr>
										<tr>
											<td class="labels">
												<dnn:Label ID="lblArticleID" ResourceKey="lblArticleID" runat="server" ControlName="tbIntegArtID" HelpText="Enter the ID of blog article:" Text="Enter ArticleID:" HelpKey="lblArticleID.HelpText" />
											</td>
											<td>
												<asp:TextBox ID="tbIntegArtID" runat="server" Style="margin-left: 0px" Width="100px"></asp:TextBox>
												<asp:RequiredFieldValidator ID="rfvIntegrationArticleID" runat="server" ControlToValidate="tbIntegArtID" Display="Dynamic" ErrorMessage="This field is required." resourcekey="rfvIntegrationArticleIDResource1.ErrorMessage"></asp:RequiredFieldValidator>
											</td>
										</tr>
										<tr>
											<td class="labels">
												<dnn:Label ID="lblIntegratedGalllerySelection" ResourceKey="lblIntegratedGalllerySelection" runat="server" ControlName="ddlIntegGalSel" HelpText="Select the gallery to integrate with blog:" Text="Select gallery to display:" HelpKey="lblIntegratedGalllerySelection.HelpText" />
											</td>
											<td>
												<div class="styledSelect">
													<asp:DropDownList ID="ddlIntegGalSel" runat="server" DataSourceID="odsGallery" DataTextField="GalleryName" DataValueField="GalleryID"></asp:DropDownList>
												</div>
											</td>
										</tr>
										<tr>
											<td></td>
											<td>
												<div class="itemActions itemEditActions">
													<asp:LinkButton ID="btnAddList" runat="server" OnClick="btnAddList_Click" Text="Add" resourcekey="btnAddListResource1" CssClass="itemEditAdd" />
												</div>
											</td>
										</tr>
									</table>
									<div class="listItems">
										<asp:GridView ID="gvIntegration" runat="server" AllowPaging="True" AutoGenerateColumns="False" CssClass="listItemsTable" DataKeyNames="EntryID" DataSourceID="odsIntegration" ForeColor="Black" GridLines="Horizontal" OnSelectedIndexChanged="gvIntegration_SelectedIndexChanged" PageSize="30">
											<Columns>
												<asp:TemplateField HeaderText="Actions" ShowHeader="False">
													<EditItemTemplate>
														<div class="itemActions itemEditActions">
															<asp:LinkButton ID="lblgvIntegrateUpdate" runat="server" CausesValidation="True" CommandName="Update" Text="Update" resourcekey="lblgvIntegrateUpdate" CssClass="itemEditUpdate"></asp:LinkButton>
															<asp:LinkButton ID="lblgvIntegrateCancel" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" resourcekey="lblgvIntegrateCancel" CssClass="itemEditCancel"></asp:LinkButton>
														</div>
													</EditItemTemplate>
													<ItemTemplate>
														<div class="itemActions itemEditActions">
															<asp:LinkButton ID="lblGVIntegrateEdit" runat="server" CausesValidation="False" CommandName="Edit" Text="Edit" resourcekey="lblGVIntegrateEdit" CssClass="itemEditUpdate"></asp:LinkButton>
															<asp:LinkButton ID="lblGVIntegrateDelete" runat="server" CausesValidation="False" CommandName="Delete" Text="Delete" resourcekey="lblGVIntegrateDelete" CssClass="itemEditRemove"></asp:LinkButton>
														</div>
													</ItemTemplate>
													<ControlStyle />
													<HeaderStyle VerticalAlign="Middle" />
													<ItemStyle />
												</asp:TemplateField>
												<asp:BoundField DataField="ArticleID" HeaderText="ArticleID">
													<HeaderStyle />
													<ItemStyle />
												</asp:BoundField>
												<asp:BoundField DataField="GalleryID" HeaderText="GalleryID">
													<HeaderStyle />
													<ItemStyle />
												</asp:BoundField>
												<asp:BoundField DataField="GalleryName" HeaderText="Galleryname" ReadOnly="True">
													<ItemStyle />
												</asp:BoundField>
											</Columns>
											<PagerStyle CssClass="contentPagination" />
											<SelectedRowStyle CssClass="editItemState" />
										</asp:GridView>
										<asp:ObjectDataSource ID="odsIntegration" TypeName="EasyDNN.Modules.EasyDNNGallery.DataAcess" runat="server" SelectMethod="GetAllIntegration" DeleteMethod="DeleteIntegration" UpdateMethod="UpdateIntegration" OnSelecting="odsIntegration_Selecting">
											<DeleteParameters>
												<asp:Parameter Name="EntryID" Type="Int32" />
											</DeleteParameters>
											<SelectParameters>
												<asp:Parameter Name="PortalID" Type="Int32" />
												<asp:Parameter Name="ModuleID" Type="Int32" />
											</SelectParameters>
											<UpdateParameters>
												<asp:Parameter Name="EntryID" Type="Int32" />
												<asp:Parameter Name="ArticleID" Type="Int32" />
												<asp:Parameter Name="GalleryID" Type="Int32" />
											</UpdateParameters>
										</asp:ObjectDataSource>
									</div>
								</asp:Panel>
							</div>
							<asp:Panel ID="pnlUserUpload" runat="server" CssClass="contentSection userUpload">
								<div class="specialOptions negativeMargins40">
									<h2>
										<asp:Label ID="lblUUserUploadTitle" runat="server" resourcekey="lblEnableUserUpload" Text="Enable user upload into this gallery"></asp:Label><span>&nbsp;</span>
									</h2>
									<div class="optionsList" runat="server">
										<div class="styledCheckbox noLabel">
											<asp:CheckBox ID="cbEnableUserUpload" runat="server" AutoPostBack="True" OnCheckedChanged="cbEnableUserUpload_CheckedChanged" Text="Enable user upload into this gallery" resourcekey="lblEnableUserUpload" />
										</div>
									</div>
								</div>
								<asp:Panel ID="pnlUserUpladSettings" runat="server" Visible="False" CssClass="additionalOptions listItems color1">
									<dnn:Label ID="lblUserUploadRoles" runat="server" Text="Select roles:" HelpText="Select security roles that can upload or approve media." HelpKey="lblUserUploadRoles.HelpText" ResourceKey="lblUserUploadRoles"></dnn:Label>
									<asp:GridView ID="gvUploadRoles" runat="server" AutoGenerateColumns="False" CssClass="additionalOptionsList fullWidthTable" GridLines="None" OnRowDataBound="gvUploadRoles_RowDataBound">
										<Columns>
											<asp:TemplateField HeaderText="Role">
												<ItemTemplate>
													<asp:Label ID="lblRoleName" runat="server" Text='<%# Bind("Role") %>'></asp:Label>
												</ItemTemplate>
											</asp:TemplateField>
											<asp:TemplateField HeaderText="Images">
												<ItemTemplate>
													<asp:CheckBox ID="cbImage" runat="server" Checked='<%# Bind("Image") %>' />
												</ItemTemplate>
												<ItemStyle HorizontalAlign="Center" />
											</asp:TemplateField>
											<asp:TemplateField HeaderText="Video files">
												<ItemTemplate>
													<asp:CheckBox ID="cbVideoFiles" runat="server" Checked='<%# Bind("[Video files]") %>' />
												</ItemTemplate>
												<ItemStyle HorizontalAlign="Center" />
											</asp:TemplateField>
											<asp:TemplateField HeaderText="Embed Video">
												<ItemTemplate>
													<asp:CheckBox ID="cbVideo" runat="server" Checked='<%# Bind("Video") %>' />
												</ItemTemplate>
												<ItemStyle HorizontalAlign="Center" />
											</asp:TemplateField>
											<asp:TemplateField HeaderText="Audio">
												<ItemTemplate>
													<asp:CheckBox ID="cbAudio" runat="server" Checked='<%# Bind("Audio") %>' />
												</ItemTemplate>
												<ItemStyle HorizontalAlign="Center" />
											</asp:TemplateField>
											<asp:TemplateField HeaderText="Approve">
												<ItemTemplate>
													<asp:CheckBox ID="cbApproved" runat="server" Checked='<%# Bind("Approved") %>' />
												</ItemTemplate>
												<ItemStyle HorizontalAlign="Center" />
											</asp:TemplateField>
										</Columns>
										<FooterStyle />
										<PagerStyle CssClass="contentPagination" />
										<SelectedRowStyle />
										<HeaderStyle />
										<EditRowStyle />
									</asp:GridView>
									<div class="optionsPanel paddingTopBottom">
										<table>
											<tr>
												<td class="labels">
													<dnn:Label ID="lblEnableApproval" runat="server" Text="Aprove Media:" HelpText="Uploaded media needs approval." HelpKey="lblEnableApproval.HelpText" ResourceKey="lblEnableApproval"></dnn:Label>
												</td>
												<td>
													<asp:CheckBox ID="cbApproveMedia" runat="server" />
												</td>
											</tr>
											<tr>
												<td class="labels">
													<dnn:Label ID="lblEnterUrl" runat="server" Text="Show enter url:" HelpText="Show field for image link on upload form." HelpKey="lblEnterUrl.HelpText" ResourceKey="lblEnterUrl"></dnn:Label>
												</td>
												<td>
													<asp:CheckBox ID="cbShowEnterUrl" runat="server" />
												</td>
											</tr>
											<tr>
												<td class="labels">
													<dnn:Label ID="lblResizeImages" runat="server" Text="Resize images:" HelpText="Resize uploaded images:" HelpKey="lblResizeImages.HelpText" ResourceKey="lblResizeImages"></dnn:Label>
												</td>
												<td>
													<asp:CheckBox ID="cbResizeImages" runat="server" />
													<asp:Panel ID="pnlImageUploadResize" runat="server" CssClass="optionsPanel paddingTop">
														<table>
															<tr>
																<td>
																	<asp:Label ID="lblImageUploadResizeWidth" runat="server" resourcekey="lblImageUploadResizeWidthResource1" Text="Max width:"></asp:Label>
																</td>
																<td>
																	<asp:TextBox ID="tbImageUploadResizeWidth" runat="server" Text="800" Width="50px">
																	</asp:TextBox>
																	<asp:CompareValidator ID="cvImagerResize" runat="server" ControlToValidate="tbImageUploadResizeWidth" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" resourcekey="cvImagerResizeResource1.ErrorMessage" Type="Integer"
																		ValidationGroup="vgImageUpload">
																	</asp:CompareValidator>
																	<asp:RequiredFieldValidator ID="rfvImageUpload" runat="server" ControlToValidate="tbImageUploadResizeWidth" ErrorMessage="This filed is required." resourcekey="rfvImageUploadResource1.ErrorMessage" ValidationGroup="vgImageUpload">
																	</asp:RequiredFieldValidator>
																</td>
															</tr>
															<tr>
																<td>
																	<asp:Label ID="lblImageUploadResizeHeight" runat="server" resourcekey="lblImageUploadResizeHeightResource1" Text="Max height:"></asp:Label>
																</td>
																<td>
																	<asp:TextBox ID="tbImageUploadResizeHeight" runat="server" Text="600" Width="50px">
																	</asp:TextBox>
																	<asp:CompareValidator ID="cvImagerResizeHeight" runat="server" ControlToValidate="tbImageUploadResizeHeight" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" resourcekey="cvImagerResizeHeightResource1.ErrorMessage" Type="Integer"
																		ValidationGroup="vgImageUpload">
																	</asp:CompareValidator>
																	<asp:RequiredFieldValidator ID="rfvImageUploadHeight" runat="server" ControlToValidate="tbImageUploadResizeHeight" ErrorMessage="This filed is required." resourcekey="rfvImageUploadHeightResource1.ErrorMessage" ValidationGroup="vgImageUpload">
																	</asp:RequiredFieldValidator>
																</td>
															</tr>
														</table>
													</asp:Panel>
												</td>
											</tr>
										</table>
									</div>
								</asp:Panel>
							</asp:Panel>
							<asp:Panel ID="pnlChameleonGallery" runat="server" Visible="False" CssClass="settingsList negativeMargins40">
								<h3>
									<asp:Label ID="lblChameleonGallery" runat="server" CssClass="settingsdetailtitle" Text="Chameleon Gallery"></asp:Label>
								</h3>
								<div class="settingsTable">
									<table>
										<tr class="color3HighLighted">
											<td>
												<dnn:Label ID="lblChameleonSelectLayoutType" runat="server" HelpText="Select the layout type:" Text="Select the layout type:" HelpKey="lblChameleonSelectLayoutType.HelpText" ResourceKey="lblChameleonSelectLayoutType" />
											</td>
											<td>
												<asp:RadioButtonList ID="rblChameleonLayoutTypeSelect" runat="server" RepeatDirection="Horizontal" AutoPostBack="True" OnSelectedIndexChanged="rblChameleonLayoutTypeSelect_SelectedIndexChanged" CssClass="styledRadio">
													<asp:ListItem resourcekey="liResponsive" Value="responsive">Responsive Layout</asp:ListItem>
													<asp:ListItem resourcekey="liFixed" Selected="True" Value="fixed">Fixed Layout</asp:ListItem>
												</asp:RadioButtonList>
											</td>
										</tr>
										<tr class="color2HighLighted">
											<td colspan="2" class="textCenter">Predefined settings</td>
										</tr>
										<tr>
											<td colspan="2">
												<asp:HiddenField ID="hfChameleonPreset" runat="server" Value="0" />
												<asp:DataList ID="dlChameleonPresets" runat="server" RepeatColumns="4" OnItemCommand="dlChameleonPresets_ItemCommand" RepeatDirection="Horizontal" CssClass="predefinedThumbnails fourInRow" ItemStyle-HorizontalAlign="Center" ItemStyle-VerticalAlign="Top">
													<ItemTemplate>
														<div class="thumbnail">
															<asp:Image ID="imgThumbPreSet" runat="server" ImageUrl='<%# DataBinder.Eval(Container.DataItem, "ImageURL") %>' CssClass="presetImage" />
															<h5 class="presetName">
																<asp:HiddenField ID="hfPresetFileName" runat="server" Value='<%#DataBinder.Eval(Container.DataItem, "FileName")%>' />
																<asp:Label ID="lblPresetName" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "Name") %>'></asp:Label>
															</h5>
															<asp:LinkButton ID="lbLoadXmlPreSet" runat="server" CommandArgument='<%# DataBinder.Eval(Container.DataItem, "FileName") %>' CommandName="Load" CssClass="selectPreSettings"><span>Load</span></asp:LinkButton>
														</div>
													</ItemTemplate>
												</asp:DataList>
											</td>
										</tr>
										<tr>
											<td colspan="2">
												<asp:Label ID="lblChameleonGalleryTemplateInfo" runat="server"></asp:Label>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblLightboxTemplateSelect2" runat="server" ControlName="ddlSSThemeSelect" HelpKey="lblLightboxTemplateSelect.HelpText" HelpText="Select the control viewer template:" Text="Select template:" ResourceKey="lblVerticalCarouselTemplateSelect" />
											</td>
											<td>
												<div class="styledSelect">
													<asp:DropDownList ID="ddlChameleonGalleryTemplateSelect" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlLightboxTemplateSelect_SelectedIndexChanged"></asp:DropDownList>
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblChameleonGalleryThemeSelect" runat="server" HelpText="Select the CSS theme file:" Text="Select CSS:" HelpKey="lblImageCarouselThemeSelect.HelpText" ResourceKey="lblImageCarouselThemeSelect" />
											</td>
											<td>
												<div class="styledSelect">
													<asp:DropDownList ID="ddlChameleonGalleryThemeSelect" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlChameleonGalleryThemeSelect_SelectedIndexChanged1"></asp:DropDownList>
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblChameleonGalleryThemeDisplayStyle" runat="server" HelpText="Select the CSS theme styling:" Text="Select the CSS theme styling:" HelpKey="lblChameleonGalleryThemeDisplayStyle.HelpText" ResourceKey="lblChameleonGalleryThemeDisplayStyle" />
											</td>
											<td>
												<div class="styledSelect">
													<asp:DropDownList ID="ddlChameleonGalleryThemeSelectStyling" runat="server"></asp:DropDownList>
												</div>
											</td>
										</tr>
										<tr>
											<td colspan="2"></td>
										</tr>
										<tr class="color6HighLighted">
											<td colspan="2" class="noLeftRightPadding">
												<table>
													<tr>
														<td>
															<dnn:Label ID="lblChameleonGalleryDispplayNestedGalleries" runat="server" HelpKey="lblLightboxGalleryDispplayNestedGalleries.HelpText" HelpText="Display nested galleries:" ResourceKey="lblLightboxGalleryDispplayNestedGalleries" Text="Display nested galleries:" />
														</td>
														<td>
															<div class="styledCheckbox noLabel">
																<asp:CheckBox ID="cbChameleonGalleryDisplayNestedGalleries" runat="server" AutoPostBack="True" OnCheckedChanged="cbChameleonGalleryDisplayNestedGalleries_CheckedChanged" resourcekey="cbLightboxGalleryDisplayNestedGalleriesResource1" Text="Display nested galleries" />
															</div>
														</td>
													</tr>
												</table>
												<asp:Panel ID="pnlChameleonGalleryNestedGalleriesOptions" runat="server" Visible="False">
													<asp:Panel ID="pnlChameleonGalleryNGGallerySettings" runat="server">
														<table>
															<tr class="color1HighLighted">
																<td class="textCenter">
																	<asp:Label ID="lblLightboxGalleryNestedGallerySettings2" runat="server" CssClass="settingsdetailtitle" resourcekey="lblLightboxGalleryNestedGallerySettingsResource1" Text="Nested galleries settings"></asp:Label>
																</td>
															</tr>
															<tr>
																<td>
																	<table class="settingsTable">
																		<tr>
																			<td class="textTop">
																				<asp:Label ID="lblChameleonGalleryNestedGallerySelection" runat="server" resourcekey="lblLightboxGalleryNestedGallerySelectionResource1" Text="Gallery selection:"></asp:Label>
																			</td>
																			<td>
																				<div class="styledCheckbox">
																					<asp:CheckBoxList ID="cblChameleonGalleryNestedGallerySelection" runat="server" CellPadding="2" CellSpacing="5" DataSourceID="odsGallery" DataTextField="GalleryName" DataValueField="GalleryID" OnDataBound="cblTGNGGallerySelection_DataBound" OnSelectedIndexChanged="cblChameleonGalleryNestedGallerySelection_SelectedIndexChanged" RepeatColumns="2" CssClass="clearWidth textLeft textTop"></asp:CheckBoxList>
																				</div>
																				<asp:Label ID="lblChameleonGalleryNoNestedGalleryError" runat="server" resourcekey="lblLightboxGalleryNoNestedGalleryErrorResource1" Text="Please add an select some galleries." Visible="False" CssClass="infoMessages warning static"></asp:Label>
																			</td>
																		</tr>
																		<tr>
																			<td></td>
																			<td>
																				<div class="styledCheckbox">
																					<asp:CheckBox ID="cbChameleonGalleryNestedShowAllGalleries" runat="server" AutoPostBack="True" OnCheckedChanged="cbChameleonGalleryNestedShowAllGalleries_CheckedChanged" resourcekey="cbLightboxGalleryNestedShowAllGalleriesResource1" Text="Show all galleries" />
																				</div>
																			</td>
																		</tr>
																		<tr>
																			<td colspan="2"></td>
																		</tr>
																		<tr class="color2HighLighted">
																			<td colspan="2" class="textCenter">
																				<asp:Label ID="lblChameleonGalleryCategory" runat="server" resourcekey="lblChameleonGalleryCategory" Text="Category options"></asp:Label>
																			</td>
																		</tr>
																		<tr id="trChamcNestedWidth" runat="server">
																			<td>
																				<dnn:Label ID="lblChameleonGalleryNGThumbWidth" runat="server" HelpText="Category item width:" Text="Category item width:" />
																			</td>
																			<td>
																				<asp:TextBox ID="tbChameleonGalleryNGImageWidth" runat="server" ValidationGroup="vgChameleonSettings" CssClass="small textCenter">100</asp:TextBox>
																				<asp:RequiredFieldValidator ID="rfvLightBoxGalleryImageHeight3" runat="server" ControlToValidate="tbChameleonGalleryNGImageHeight" Display="Dynamic" ErrorMessage="This field is required." resourcekey="rfvLightBoxGalleryImageHeightResource1.ErrorMessage" ValidationGroup="vgChameleonSettings" CssClass="smallInfo error"></asp:RequiredFieldValidator>
																				<asp:CompareValidator ID="cvLightboxGalleryNestedImageHeight3" runat="server" ControlToValidate="tbChameleonGalleryNGImageHeight" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" resourcekey="cvLightboxGalleryNestedImageHeightResource1.ErrorMessage" SetFocusOnError="True" Type="Integer" ValidationGroup="vgChameleonSettings" CssClass="smallInfo error"></asp:CompareValidator>
																			</td>
																		</tr>
																		<tr id="trChamcNestedHeight" runat="server">
																			<td>
																				<dnn:Label ID="lblChameleonGalleryNGThumbHeight" runat="server" HelpKey="lblChameleonGalleryNGThumbHeight.HelpText" HelpText="Category item height:" ResourceKey="lblChameleonGalleryNGThumbHeight.Text" Text="Category item height:" />
																			</td>
																			<td>
																				<asp:TextBox ID="tbChameleonGalleryNGImageHeight" runat="server" ValidationGroup="vgChameleonSettings" CssClass="small textCenter">45</asp:TextBox>
																				<asp:RequiredFieldValidator ID="rfvLightBoxGalleryImageWidth5" runat="server" ControlToValidate="tbChameleonGalleryNGImageWidth" Display="Dynamic" ErrorMessage="This field is required." resourcekey="rfvLightBoxGalleryImageWidthResource1.ErrorMessage" ValidationGroup="vgChameleonSettings" CssClass="smallInfo error"></asp:RequiredFieldValidator>
																				<asp:CompareValidator ID="cvLightBoxGalleryImageWidth3" runat="server" ControlToValidate="tbChameleonGalleryNGImageWidth" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" resourcekey="cvLightBoxGalleryImageWidthResource1.ErrorMessage" Type="Integer" ValidationGroup="vgChameleonSettings" CssClass="smallInfo error"></asp:CompareValidator>
																			</td>
																		</tr>
																		<tr id="trChamcNestedThumbPosition" runat="server">
																			<td>
																				<dnn:Label ID="lblChameleonGalleryNGThumbPosition" runat="server" HelpKey="lblChameleonGalleryNGThumbPosition.HelpText" HelpText="Category items position:" ResourceKey="lblChameleonGalleryNGThumbPosition.Text" Text="Category items position:" />
																			</td>
																			<td>
																				<asp:RadioButtonList ID="rblChameleonGalleryNGThumbPositionInOut" runat="server" RepeatDirection="Horizontal" CssClass="styledRadio clearWidth small">
																					<asp:ListItem resourcekey="rblChameleonGalleryThumbnailPositionInOutIN" Value="Inside">Inside image panel</asp:ListItem>
																					<asp:ListItem resourcekey="rblChameleonGalleryThumbnailPositionInOutOUT" Selected="True" Value="Outside">Outside image panel</asp:ListItem>
																				</asp:RadioButtonList>
																			</td>
																		</tr>
																		<tr id="trChamcNestedThumbPosition2" runat="server">
																			<td>
																				<dnn:Label ID="lblChameleonGalleryNGThumbPosition1" runat="server" HelpKey="lblChameleonGalleryNGThumbPosition1.HelpText" HelpText="Category items position:" ResourceKey="lblChameleonGalleryNGThumbPosition1.Text" Text="Category items position:" />
																			</td>
																			<td>
																				<asp:RadioButtonList ID="rblChameleonGalleryNGThumbPositionLRTB" runat="server" AutoPostBack="True" OnSelectedIndexChanged="rblChameleonGalleryNGThumbPositionLRTB_SelectedIndexChanged" RepeatDirection="Horizontal" CssClass="styledRadio clearWidth small">
																					<asp:ListItem resourcekey="rblChameleonGalleryThumbnailPositionLRTBTop">Top</asp:ListItem>
																					<asp:ListItem resourcekey="rblChameleonGalleryThumbnailPositionLRTBBottom" Selected="True">Bottom</asp:ListItem>
																					<asp:ListItem resourcekey="rblChameleonGalleryThumbnailPositionLRTBLeft">Left</asp:ListItem>
																					<asp:ListItem resourcekey="rblChameleonGalleryThumbnailPositionLRTBRight">Right</asp:ListItem>
																				</asp:RadioButtonList>
																			</td>
																		</tr>
																		<tr id="trChamcNestedGalContainer" runat="server">
																			<td>
																				<dnn:Label ID="lblChameleonGalleryNGContainer" runat="server" HelpKey="lblChameleonGalleryNGContainer.HelpText" HelpText="Category containter width:" ResourceKey="lblChameleonGalleryNGContainer.Text" Text="Category containter width:" />
																			</td>
																			<td>
																				<asp:TextBox ID="tbChameleonGalleryCategoryWitdh" runat="server" CssClass="small textCenter">580</asp:TextBox>
																				<asp:RequiredFieldValidator ID="rfvLightBoxGalleryImageWidth6" runat="server" ControlToValidate="tbChameleonGalleryCategoryWitdh" Display="Dynamic" ErrorMessage="This field is required." resourcekey="rfvLightBoxGalleryImageWidthResource1.ErrorMessage" ValidationGroup="vgChameleonSettings" CssClass="smallInfo error"></asp:RequiredFieldValidator>
																				<asp:CompareValidator ID="cvLightBoxGalleryImageHeight5" runat="server" ControlToValidate="tbChameleonGalleryCategoryWitdh" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" resourcekey="cvLightBoxGalleryImageHeightResource1.ErrorMessage" Type="Integer" ValidationGroup="vgChameleonSettings" CssClass="smallInfo error"></asp:CompareValidator>
																			</td>
																		</tr>
																		<tr id="trChamcNestedGalContainerHeight" runat="server">
																			<td>
																				<dnn:Label ID="lblChameleonGalleryNGContainerHeight" runat="server" HelpKey="lblChameleonGalleryNGContainerHeight.HelpText" HelpText="Category containter height:" ResourceKey="lblChameleonGalleryNGContainerHeight.Text" Text="Category containter height:" />
																			</td>
																			<td>
																				<asp:TextBox ID="tbChameleonGalleryCategoryHeight" runat="server" CssClass="small textCenter">60</asp:TextBox>
																				<asp:RequiredFieldValidator ID="rfvLightBoxGalleryImageWidth7" runat="server" ControlToValidate="tbChameleonGalleryCategoryHeight" Display="Dynamic" ErrorMessage="This field is required." resourcekey="rfvLightBoxGalleryImageWidthResource1.ErrorMessage" ValidationGroup="vgChameleonSettings" CssClass="smallInfo error"></asp:RequiredFieldValidator>
																				<asp:CompareValidator ID="cvLightBoxGalleryImageHeight6" runat="server" ControlToValidate="tbChameleonGalleryCategoryHeight" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" resourcekey="cvLightBoxGalleryImageHeightResource1.ErrorMessage" Type="Integer" ValidationGroup="vgChameleonSettings" CssClass="smallInfo error"></asp:CompareValidator>
																			</td>
																		</tr>
																		<tr id="trChamcNestedGalContainerPosition" runat="server">
																			<td>
																				<dnn:Label ID="lblChameleonGalleryNGContainerPosition" runat="server" HelpKey="lblChameleonGalleryNGContainerPosition.HelpText" HelpText="Position:" ResourceKey="lblChameleonGalleryNGContainerPosition.Text" Text="Position:" />
																			</td>
																			<td>
																				<asp:TextBox ID="tbChameleonGalleryCategoryPriority" runat="server" CssClass="small textCenter">1</asp:TextBox>
																				<asp:RequiredFieldValidator ID="rfvLightBoxGalleryImageWidth8" runat="server" ControlToValidate="tbChameleonGalleryCategoryPriority" Display="Dynamic" ErrorMessage="This field is required." resourcekey="rfvLightBoxGalleryImageWidthResource1.ErrorMessage" ValidationGroup="vgChameleonSettings" CssClass="smallInfo error"></asp:RequiredFieldValidator>
																				<asp:CompareValidator ID="cvLightBoxGalleryImageHeight7" runat="server" ControlToValidate="tbChameleonGalleryCategoryPriority" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" resourcekey="cvLightBoxGalleryImageHeightResource1.ErrorMessage" Type="Integer" ValidationGroup="vgChameleonSettings" CssClass="smallInfo error"></asp:CompareValidator>
																			</td>
																		</tr>
																		<tr id="trChamcNestedGalContainerExpand" runat="server">
																			<td>
																				<dnn:Label ID="lblChameleonGalleryNGContainerExpand" runat="server" HelpKey="lblChameleonGalleryNGContainerExpand.HelpText" HelpText="Expand to 100% width:" ResourceKey="lblChameleonGalleryNGContainerExpand.Text" Text="Expand to 100% width:" />
																			</td>
																			<td>
																				<div class="styledCheckbox noLabel">
																					<asp:CheckBox ID="cbChameleonGalleryNestedExpand" runat="server" Text="Expand to 100% width" />
																				</div>
																			</td>
																		</tr>
																		<tr>
																			<td>
																				<dnn:Label ID="lblChameleonGalleryNGSorting" runat="server" HelpKey="lblChameleonGalleryNGSorting.HelpText" HelpText="Nested category sorting:" ResourceKey="lblChameleonGalleryNGSorting" Text="Nested category sorting:" />
																			</td>
																			<td>
																				<table class="clearWidth textLeft">
																					<tr>
																						<td>
																							<div class="styledSelect">
																								<asp:DropDownList ID="ddlChameleonGalleryNestedSorting" runat="server">
																									<asp:ListItem resourcekey="liPosition" Value="Position">Position</asp:ListItem>
																									<asp:ListItem resourcekey="liTitle" Value="GalleryName">Title</asp:ListItem>
																									<asp:ListItem resourcekey="liDateCreated" Value="DateCreated">Date created</asp:ListItem>
																									<asp:ListItem resourcekey="liLAstModified" Value="DateLastModified">Date last modified</asp:ListItem>
																								</asp:DropDownList>
																							</div>
																						</td>
																						<td>
																							<div class="styledRadio small">
																								<asp:RadioButtonList ID="rblChameleonGalleryNestedSortingAscDesc" runat="server" RepeatDirection="Horizontal">
																									<asp:ListItem resourcekey="liAscending" Selected="True" Value="ASC">Ascending</asp:ListItem>
																									<asp:ListItem resourcekey="liDescending" Value="DESC">Descending</asp:ListItem>
																								</asp:RadioButtonList>
																							</div>
																						</td>
																					</tr>
																				</table>
																			</td>
																		</tr>
																	</table>
																</td>
															</tr>
														</table>
													</asp:Panel>
												</asp:Panel>
											</td>
										</tr>
										<tr>
											<td colspan="2"></td>
										</tr>
										<tr class="color2HighLighted">
											<td class="textCenter" colspan="2">
												<asp:Label ID="lblChameleonGalleryMainPanel" runat="server" resourcekey="lblChameleonGalleryMainPanel" Text="Main panel"></asp:Label>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblChameleonGalleryMainPanelWidth" runat="server" HelpKey="lblChameleonGalleryMainPanelWidth.HelpText" HelpText="Set the maximum image width for resizing:" ResourceKey="lblChameleonGalleryMainPanelWidth" Text="Maximum panel width:" />
											</td>
											<td>
												<asp:TextBox ID="tbChameleonGalleryMainPanelWidth" runat="server" ValidationGroup="vgChameleonSettings" CssClass="small textCenter">700</asp:TextBox>
												<asp:Label ID="lblChamMainPanelWidthType" runat="server" Text="%" Visible="False"></asp:Label>
												<asp:RequiredFieldValidator ID="rfvLightboxGalleryNestedImageWidth2" runat="server" ControlToValidate="tbChameleonGalleryMainPanelWidth" Display="Dynamic" ErrorMessage="This field is required." resourcekey="rfvLightboxGalleryNestedImageWidthResource1.ErrorMessage" SetFocusOnError="True" ValidationGroup="vgChameleonSettings" CssClass="smallInfo warning"></asp:RequiredFieldValidator>
												<asp:CompareValidator ID="cvLightboxGalleryNestedImageWidth2" runat="server" ControlToValidate="tbChameleonGalleryMainPanelWidth" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" resourcekey="cvLightboxGalleryNestedImageWidthResource1.ErrorMessage" SetFocusOnError="True" Type="Integer" ValidationGroup="vgChameleonSettings" CssClass="smallInfo warning"></asp:CompareValidator>
												<asp:RangeValidator ID="rvChameleonWidthPerct" runat="server" ControlToValidate="tbChameleonGalleryMainPanelWidth" Display="Dynamic" Enabled="False" ErrorMessage="Enter value between 0-100." MaximumValue="100" MinimumValue="0" resourcekey="rvAGVolume0Resource1.ErrorMessage" SetFocusOnError="True" Type="Integer" ValidationGroup="vgChameleonSettings" Visible="False" CssClass="smallInfo warning"></asp:RangeValidator>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblChameleonGalleryMainPanelHeight" runat="server" ControlName="tbTGImageHeight" HelpKey="lblChameleonGalleryMainPanelHeight.HelpText" HelpText="Set the maximum image height for resizing:" ResourceKey="lblChameleonGalleryMainPanelHeight" Text="Maximum panel height: " />
											</td>
											<td>
												<table class="clearWidth textLeft">
													<tr>
														<td>
															<asp:TextBox ID="tbChameleonGalleryMainPanelHeight" runat="server" ValidationGroup="vgChameleonSettings" CssClass="small textCenter">600</asp:TextBox>
															<asp:Label ID="lblChamMainPanelHeightType" runat="server" Text="px" Visible="False"></asp:Label>
															<asp:RequiredFieldValidator ID="rfvLightboxGalleryNestedImageHeight2" runat="server" ControlToValidate="tbChameleonGalleryMainPanelHeight" Display="Dynamic" ErrorMessage="This field is required." resourcekey="rfvLightboxGalleryNestedImageHeightResource1.ErrorMessage" SetFocusOnError="True" ValidationGroup="vgChameleonSettings" CssClass="smallInfo warning"></asp:RequiredFieldValidator>
															<asp:CompareValidator ID="cvLightboxGalleryNestedImageHeight2" runat="server" ControlToValidate="tbChameleonGalleryMainPanelHeight" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" resourcekey="cvLightboxGalleryNestedImageHeightResource1.ErrorMessage" SetFocusOnError="True" Type="Integer" ValidationGroup="vgChameleonSettings" CssClass="smallInfo warning"></asp:CompareValidator>
															<asp:RangeValidator ID="rvChameleonHeightPerct" runat="server" ControlToValidate="tbChameleonGalleryMainPanelHeight" Display="Dynamic" Enabled="False" ErrorMessage="Enter value between 0-100." MaximumValue="100" MinimumValue="0" resourcekey="rvAGVolume0Resource1.ErrorMessage" SetFocusOnError="True" Type="Integer" ValidationGroup="vgChameleonSettings" Visible="False" CssClass="smallInfo warning"></asp:RangeValidator>
														</td>
														<td>&nbsp;</td>
														<td>
															<div class="styledSelect">
																<asp:DropDownList ID="ddlChameleonGalleryHeightType" runat="server" Visible="False" AutoPostBack="True" OnSelectedIndexChanged="ddlChameleonGalleryHeightType_SelectedIndexChanged">
																	<asp:ListItem Value="pixel">px</asp:ListItem>
																	<asp:ListItem Value="percent">%</asp:ListItem>
																</asp:DropDownList>
															</div>
														</td>
													</tr>
												</table>
											</td>
										</tr>
										<tr id="trChameleonResponsiveMainImageWidth" runat="server" visible="false">
											<td>
												<dnn:Label ID="lblChameleonResponsiveMainImageWidth" runat="server" HelpText="Max width used to generate main responsive image." Text="Main image width:" />
											</td>
											<td>
												<asp:TextBox ID="tbxChameleonResponsiveMainImageWidth" runat="server" CssClass="small textCenter">900</asp:TextBox>
												px
												<asp:RequiredFieldValidator ID="rfvtbxChameleonResponsiveMainImageWidth" runat="server" ControlToValidate="tbxChameleonResponsiveMainImageWidth" Display="Dynamic" ErrorMessage="This filed is required." SetFocusOnError="True" ValidationGroup="vgChameleonSettings" CssClass="smallInfo warning" />
												<asp:CompareValidator ID="cvChameleonResponsiveMainImageWidth" runat="server" ControlToValidate="tbxChameleonResponsiveMainImageWidth" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" Type="Integer" ValidationGroup="vgChameleonSettings" CssClass="smallInfo warning" />
											</td>
										</tr>
										<tr id="trChameleonResponsiveMainImageHeight" runat="server" visible="false">
											<td>
												<dnn:Label ID="lblChameleonResponsiveMainImageHeight" runat="server" HelpText="Max height used to generate main responsive image." Text="Main image height:" />
											</td>
											<td>
												<asp:TextBox ID="tbxChameleonResponsiveMainImageHeight" runat="server" CssClass="small textCenter">600</asp:TextBox>
												px
												<asp:RequiredFieldValidator ID="rfvtbxChameleonResponsiveMainImageHeight" runat="server" ControlToValidate="tbxChameleonResponsiveMainImageHeight" Display="Dynamic" ErrorMessage="This filed is required." SetFocusOnError="True" ValidationGroup="vgChameleonSettings" CssClass="smallInfo warning" />
												<asp:CompareValidator ID="cvChameleonResponsiveMainImageHeight" runat="server" ControlToValidate="tbxChameleonResponsiveMainImageHeight" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" Type="Integer" ValidationGroup="vgChameleonSettings" CssClass="smallInfo warning" />
											</td>
										</tr>
										<tr class="color2HighLighted">
											<td id="trChamThumbMain" runat="server" colspan="2" class="textCenter">
												<asp:Label ID="lblChameleonGalleryThumbnailsPanel" runat="server" Font-Bold="True" resourcekey="lblChameleonGalleryThumbnailsPanel" Text="Thumbnails"></asp:Label>
											</td>
										</tr>
										<tr id="trChamThumbWidth" runat="server">
											<td>
												<dnn:Label ID="lblChameleonGalleryThumbWidth" runat="server" HelpKey="lblASSThumbWidth.HelpKey" HelpText="Thumb width:" ResourceKey="lblASSThumbWidth" Text="Thumb width:" />
											</td>
											<td>
												<asp:TextBox ID="tbChameleonGalleryImageWidth" runat="server" ValidationGroup="vgChameleonSettings" CssClass="small textCenter">80</asp:TextBox>
												<asp:RequiredFieldValidator ID="rfvLightBoxGalleryImageWidth2" runat="server" ControlToValidate="tbChameleonGalleryImageWidth" Display="Dynamic" ErrorMessage="This field is required." resourcekey="rfvLightBoxGalleryImageWidthResource1.ErrorMessage" ValidationGroup="vgChameleonSettings" CssClass="smallInfo warning"></asp:RequiredFieldValidator>
												<asp:CompareValidator ID="cvLightBoxGalleryImageWidth2" runat="server" ControlToValidate="tbChameleonGalleryImageWidth" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" resourcekey="cvLightBoxGalleryImageWidthResource1.ErrorMessage" Type="Integer" ValidationGroup="vgChameleonSettings" CssClass="smallInfo warning"></asp:CompareValidator>
											</td>
										</tr>
										<tr id="trChamThumbHeight" runat="server">
											<td>
												<dnn:Label ID="lblChameleonGalleryThumbHeight" runat="server" HelpKey="lblASSThumbHeight.HelpKey" HelpText="Thumb height:" ResourceKey="lblASSThumbHeight" Text="Thumb height:" />
											</td>
											<td>
												<asp:TextBox ID="tbChameleonGalleryImageHeight" runat="server" ValidationGroup="vgChameleonSettings" CssClass="small textCenter">60</asp:TextBox>
												<asp:RequiredFieldValidator ID="rfvLightBoxGalleryImageHeight2" runat="server" ControlToValidate="tbChameleonGalleryImageHeight" Display="Dynamic" ErrorMessage="This field is required." resourcekey="rfvLightBoxGalleryImageHeightResource1.ErrorMessage" ValidationGroup="vgChameleonSettings" CssClass="smallInfo warning"></asp:RequiredFieldValidator>
												<asp:CompareValidator ID="cvLightBoxGalleryImageHeight2" runat="server" ControlToValidate="tbChameleonGalleryImageHeight" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" resourcekey="cvLightBoxGalleryImageHeightResource1.ErrorMessage" Type="Integer" ValidationGroup="vgChameleonSettings" CssClass="smallInfo warning"></asp:CompareValidator>
											</td>
										</tr>
										<tr id="trChamThumbPosition" runat="server">
											<td>
												<dnn:Label ID="lblChameleonGalleryThumbPosition" runat="server" HelpKey="lblChameleonGalleryThumbPosition.HelpText" HelpText="Thumbnails position:" ResourceKey="lblChameleonGalleryThumbPosition.Text" Text="Thumbnails position:" />
											</td>
											<td>
												<asp:RadioButtonList ID="rblChameleonGalleryThumbnailPositionInOut" runat="server" RepeatDirection="Horizontal" CssClass="styledRadio small">
													<asp:ListItem resourcekey="rblChameleonGalleryThumbnailPositionInOutIN" Value="Inside">Inside image panel</asp:ListItem>
													<asp:ListItem resourcekey="rblChameleonGalleryThumbnailPositionInOutOUT" Selected="True" Value="Outside">Outside image panel</asp:ListItem>
												</asp:RadioButtonList>
											</td>
										</tr>
										<tr id="trChamThumbPosition2" runat="server">
											<td>
												<dnn:Label ID="lblChameleonGalleryThumbPosition0" runat="server" HelpKey="lblChameleonGalleryThumbPosition.HelpText" HelpText="Thumbnails position:" ResourceKey="lblChameleonGalleryThumbPosition.Text" Text="Thumbnails position:" />
											</td>
											<td>
												<asp:RadioButtonList ID="rblChameleonGalleryThumbnailPositionLRTB" runat="server" AutoPostBack="True" OnSelectedIndexChanged="rblChameleonGalleryThumbnailPositionLRTB_SelectedIndexChanged" RepeatDirection="Horizontal" CssClass="styledRadio small">
													<asp:ListItem resourcekey="rblChameleonGalleryThumbnailPositionLRTBTop">Top</asp:ListItem>
													<asp:ListItem resourcekey="rblChameleonGalleryThumbnailPositionLRTBBottom" Selected="True">Bottom</asp:ListItem>
													<asp:ListItem resourcekey="rblChameleonGalleryThumbnailPositionLRTBLeft">Left</asp:ListItem>
													<asp:ListItem resourcekey="rblChameleonGalleryThumbnailPositionLRTBRight">Right</asp:ListItem>
												</asp:RadioButtonList>
											</td>
										</tr>
										<tr id="trChamThumbStrinpSize" runat="server">
											<td>
												<dnn:Label ID="lblChameleonGalleryThumbStripSize" runat="server" HelpKey="lblChameleonGalleryThumbStripSize.HelpText" HelpText="Thumbnail strip width:" ResourceKey="lblChameleonGalleryThumbStripSize.Text" Text="Thumbnail strip width:" />
											</td>
											<td>
												<asp:TextBox ID="tbChameleonGalleryThumbStripWitdh" runat="server" AutoPostBack="True" CssClass="small textCenter">700</asp:TextBox>
												<asp:RequiredFieldValidator ID="rfvLightBoxGalleryImageWidth3" runat="server" ControlToValidate="tbChameleonGalleryThumbStripWitdh" Display="Dynamic" ErrorMessage="This field is required." resourcekey="rfvLightBoxGalleryImageWidthResource1.ErrorMessage" ValidationGroup="vgChameleonSettings" CssClass="smallInfo warning"></asp:RequiredFieldValidator>
												<asp:CompareValidator ID="cvLightBoxGalleryImageHeight3" runat="server" ControlToValidate="tbChameleonGalleryThumbStripWitdh" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" resourcekey="cvLightBoxGalleryImageHeightResource1.ErrorMessage" Type="Integer" ValidationGroup="vgChameleonSettings" CssClass="smallInfo warning"></asp:CompareValidator>
											</td>
										</tr>
										<tr id="trChamThumbStrinpHeight" runat="server">
											<td>
												<dnn:Label ID="lblChameleonGalleryThumbStripHeight" runat="server" HelpKey="lblChameleonGalleryThumbStripHeight.HelpText" HelpText="Thumbnail strip height:" ResourceKey="lblChameleonGalleryThumbStripHeight.Text" Text="Thumbnail strip height:" />
											</td>
											<td>
												<asp:TextBox ID="tbChameleonGalleryThumbStripHeight" runat="server" CssClass="small textCenter">100</asp:TextBox>
												<asp:RequiredFieldValidator ID="rfvLightBoxGalleryImageWidth4" runat="server" ControlToValidate="tbChameleonGalleryThumbStripHeight" Display="Dynamic" ErrorMessage="This field is required." resourcekey="rfvLightBoxGalleryImageWidthResource1.ErrorMessage" ValidationGroup="vgChameleonSettings" CssClass="smallInfo warning"></asp:RequiredFieldValidator>
												<asp:CompareValidator ID="cvLightBoxGalleryImageHeight4" runat="server" ControlToValidate="tbChameleonGalleryThumbStripHeight" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" resourcekey="cvLightBoxGalleryImageHeightResource1.ErrorMessage" Type="Integer" ValidationGroup="vgChameleonSettings" CssClass="smallInfo warning"></asp:CompareValidator>
											</td>
										</tr>
										<tr id="trChamThumbShowTitle" runat="server">
											<td>
												<dnn:Label ID="lblChameleonGalleryThumbShowTitle" runat="server" HelpKey="lblChameleonGalleryThumbShowTitle.HelpText" HelpText="Show title in thumbnail:" ResourceKey="lblChameleonGalleryThumbShowTitle.Text" Text="Show title in thumbnail:" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbChameleonGalleryShowThumbCaption" runat="server" Text="Show title in thumbnail" />
												</div>
											</td>
										</tr>
										<tr id="trChamThumbPorition3" runat="server">
											<td>
												<dnn:Label ID="lblChameleonGalleryThumbnailPosition" runat="server" HelpKey="lblChameleonGalleryThumbnailPosition.HelpText" HelpText="Position:" ResourceKey="lblChameleonGalleryThumbnailPosition.Text" Text="Position:" />
											</td>
											<td>
												<asp:TextBox ID="tbChameleonGalleryThumbPriority" runat="server" CssClass="small textCenter">2</asp:TextBox>
												<asp:RequiredFieldValidator ID="rfvLightBoxGalleryImageWidth9" runat="server" ControlToValidate="tbChameleonGalleryCategoryHeight" Display="Dynamic" ErrorMessage="This field is required." resourcekey="rfvLightBoxGalleryImageWidthResource1.ErrorMessage" ValidationGroup="vgChameleonSettings" CssClass="smallInfo warning"></asp:RequiredFieldValidator>
												<asp:CompareValidator ID="cvLightBoxGalleryImageHeight8" runat="server" ControlToValidate="tbChameleonGalleryCategoryHeight" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" resourcekey="cvLightBoxGalleryImageHeightResource1.ErrorMessage" Type="Integer" ValidationGroup="vgChameleonSettings" CssClass="smallInfo warning"></asp:CompareValidator>
											</td>
										</tr>
										<tr id="trChamThumbExpand" runat="server">
											<td>
												<dnn:Label ID="lblChameleonGalleryThumbnailsExpand" runat="server" HelpKey="lblChameleonGalleryThumbnailsExpand.HelpText" HelpText="Expand to 100% width:" ResourceKey="lblChameleonGalleryThumbnailsExpand.Text" Text="Expand to 100% width:" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbChameleonGalleryThumbnailsExpand" runat="server" Text="Expand to 100% width" />
												</div>
											</td>
										</tr>
										<tr class="color2HighLighted">
											<td colspan="2" class="textCenter">
												<asp:Label ID="lblChameleonGalleryGaleryTitle" runat="server" resourcekey="lblChameleonGalleryGaleryTitle" Text="Gallery title and description"></asp:Label>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblChameleonGalleryShowGalleryTitle" runat="server" HelpKey="lblChameleonGalleryShowGalleryTitle.HelpText" HelpText="Show gallery title:" ResourceKey="lblChameleonGalleryShowGalleryTitle.Text" Text="Show gallery title:" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbChameleonGalleryShowGalleyTitle" runat="server" Checked="False" resourcekey="cbLightboxGalleryShowMediaTitleResource1" Text="Show gallery title" />
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblChameleonGalleryShowGalleryDescription" runat="server" HelpKey="lblChameleonGalleryShowGalleryDescription.HelpText" HelpText="Show gallery description:" ResourceKey="lblChameleonGalleryShowGalleryDescription.Text" Text="Show gallery description:" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbChameleonGalleryShowGalleryDescription" runat="server" resourcekey="cbLightboxGalleryShowMediaDescriptionResource1" Text="Show gallery description" />
												</div>
											</td>
										</tr>
										<tr id="trChamGalerreyINout" runat="server">
											<td>
												<dnn:Label ID="lblChameleonGalleryGalleryCaptionPositionInOut" runat="server" HelpKey="lblChameleonGalleryGalleryCaptionPositionInOut.HelpText" HelpText="Gallery title and description position:" ResourceKey="lblChameleonGalleryGalleryCaptionPositionInOut.Text" Text="Gallery title and description position:" />
											</td>
											<td>
												<asp:RadioButtonList ID="rblChameleonGalleryGalleryTitleDescPositionInOut" runat="server" RepeatDirection="Horizontal" CssClass="styledRadio small">
													<asp:ListItem resourcekey="rblChameleonGalleryThumbnailPositionInOutIN" Selected="True" Value="Inside">Inside image panel</asp:ListItem>
													<asp:ListItem resourcekey="rblChameleonGalleryThumbnailPositionInOutOUT" Value="Outside">Outside image panel</asp:ListItem>
												</asp:RadioButtonList>
											</td>
										</tr>
										<tr id="trChamGalerreyTopBotom" runat="server">
											<td>
												<dnn:Label ID="lblChameleonGalleryTitleDescriptionPositionTBLR" runat="server" HelpKey="lblChameleonGalleryTitleDescriptionPositionTBLR.HelpText" HelpText="Gallery title and description position:" ResourceKey="lblChameleonGalleryTitleDescriptionPositionTBLR.Text" Text="Gallery title and description position:" />
											</td>
											<td>
												<asp:RadioButtonList ID="rblChameleonGalleryGalleryCaptionPositionLRTB" runat="server" RepeatDirection="Horizontal" CssClass="styledRadio small">
													<asp:ListItem resourcekey="rblChameleonGalleryThumbnailPositionLRTBTop" Selected="True">Top</asp:ListItem>
													<asp:ListItem resourcekey="rblChameleonGalleryThumbnailPositionLRTBBottom">Bottom</asp:ListItem>
												</asp:RadioButtonList>
											</td>
										</tr>
										<tr id="trChamcaptionHeitgh" runat="server">
											<td>
												<dnn:Label ID="lblChameleonGalleryGalleryCaptionHeight" runat="server" HelpKey="lblChameleonGalleryGalleryCaptionHeight.HelpText" HelpText="Gallery title and description height:" ResourceKey="lblChameleonGalleryGalleryCaptionHeight.Text" Text="Gallery title and description height:" />
											</td>
											<td>
												<asp:TextBox ID="tbChameleonGalleryGalleryCaptionHeight" runat="server" CssClass="small textCenter">100</asp:TextBox>
											</td>
										</tr>
										<tr id="trChamGalleryPosition" runat="server">
											<td>
												<dnn:Label ID="lblChameleonGalleryNGContainer3" runat="server" HelpKey="lblChameleonGalleryThumbnailPosition.HelpText" HelpText="Position:" ResourceKey="lblChameleonGalleryThumbnailPosition.Text" Text="Position:" />
											</td>
											<td>
												<asp:TextBox ID="tbChameleonGalleryGalleryCaptionPriority" runat="server" CssClass="small textCenter">3</asp:TextBox>
												<asp:RequiredFieldValidator ID="rfvLightBoxGalleryImageWidth10" runat="server" ControlToValidate="tbChameleonGalleryGalleryCaptionPriority" Display="Dynamic" ErrorMessage="This field is required." resourcekey="rfvLightBoxGalleryImageWidthResource1.ErrorMessage" ValidationGroup="vgChameleonSettings" CssClass="smallInfo warning"></asp:RequiredFieldValidator>
												<asp:CompareValidator ID="cvLightBoxGalleryImageHeight9" runat="server" ControlToValidate="tbChameleonGalleryGalleryCaptionPriority" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" resourcekey="cvLightBoxGalleryImageHeightResource1.ErrorMessage" Type="Integer" ValidationGroup="vgChameleonSettings" CssClass="smallInfo warning"></asp:CompareValidator>
											</td>
										</tr>
										<tr id="trChamGalleryExpand" runat="server">
											<td>
												<dnn:Label ID="lblChameleonGalleryNGContainer7" runat="server" HelpKey="lblChameleonGalleryThumbnailsExpand.HelpText" HelpText="Expand to 100% width:" ResourceKey="lblChameleonGalleryThumbnailsExpand.Text" Text="Expand to 100% width:" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbChameleonGalleryGalleryCaptionExpand" runat="server" Text="Expand to 100% width" />
												</div>
											</td>
										</tr>
										<tr class="color2HighLighted">
											<td colspan="2" class="textCenter">
												<asp:Label ID="lblChameleonGalleryGaleryTitleDescription" runat="server" resourcekey="lblChameleonGalleryGaleryTitleDescription" Text="Title and description"></asp:Label>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblChameleonGalleryShowMediaTitle" runat="server" HelpKey="lblLightboxGalleryShowMediaTitle.HelpText" HelpText="Show media title:" ResourceKey="lblLightboxGalleryShowMediaTitle" Text="Show media title:" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbChameleonGalleryShowMediaTitle" runat="server" Checked="True" resourcekey="cbLightboxGalleryShowMediaTitleResource1" Text="Show media title" />
												</div>
											</td>
										</tr>
										<tr>
											<td class="style113">
												<dnn:Label ID="lblChameleonGalleryShowMediaDescription" runat="server" HelpKey="lblLightboxGalleryShowMediaDescription.HelpText" HelpText="Show media description:" ResourceKey="lblLightboxGalleryShowMediaDescription" Text="Show media description:" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbChameleonGalleryShowMediaDescription" runat="server" Checked="True" resourcekey="cbLightboxGalleryShowMediaDescriptionResource1" Text="Show media description" />
												</div>
											</td>
										</tr>
										<tr id="trChamcTitleDescPosition" runat="server">
											<td>
												<dnn:Label ID="lblChameleonGalleryCaptionPositionInOut" runat="server" HelpKey="lblChameleonGalleryCaptionPositionInOut.HelpText" HelpText="Title and description position:" ResourceKey="lblChameleonGalleryCaptionPositionInOut.Text" Text="Title and description position:" />
											</td>
											<td>
												<asp:RadioButtonList ID="rblChameleonGalleryTitleDescPositionInOut" runat="server" RepeatDirection="Horizontal" CssClass="styledRadio small">
													<asp:ListItem resourcekey="rblChameleonGalleryThumbnailPositionInOutIN" Selected="True" Value="Inside">Inside image panel</asp:ListItem>
													<asp:ListItem resourcekey="rblChameleonGalleryThumbnailPositionInOutOUT" Value="Outside">Outside image panel</asp:ListItem>
												</asp:RadioButtonList>
											</td>
										</tr>
										<tr id="trChamcTitleDescPosition2" runat="server">
											<td>
												<dnn:Label ID="lblChameleonGalleryCaptionPositionTBLR" runat="server" HelpKey="lblChameleonGalleryCaptionPositionTBLR.HelpText" HelpText="Title and description position:" ResourceKey="lblChameleonGalleryCaptionPositionTBLR.Text" Text="Title and description position:" />
											</td>
											<td>
												<asp:RadioButtonList ID="rblChameleonGalleryCaptionPositionLRTB" runat="server" RepeatDirection="Horizontal" CssClass="styledRadio small">
													<asp:ListItem resourcekey="rblChameleonGalleryThumbnailPositionLRTBTop">Top</asp:ListItem>
													<asp:ListItem resourcekey="rblChameleonGalleryThumbnailPositionLRTBBottom" Selected="True">Bottom</asp:ListItem>
												</asp:RadioButtonList>
											</td>
										</tr>
										<tr id="trChamcTitleDescHeight" runat="server">
											<td>
												<dnn:Label ID="lblChameleonGalleryCaptionHeight" runat="server" HelpKey="lblChameleonGalleryCaptionHeight.HelpText" HelpText="Title and description height:" ResourceKey="lblChameleonGalleryCaptionHeight.Text" Text="Title and description height:" />
											</td>
											<td>
												<asp:TextBox ID="tbChameleonGalleryCaptionHeight" runat="server" CssClass="small textCenter">100</asp:TextBox>
											</td>
										</tr>
										<tr id="trChamcTitleDescPosition3" runat="server">
											<td>
												<dnn:Label ID="lblChameleonGalleryTitleDescriptionPosition" runat="server" HelpKey="lblChameleonGalleryTitleDescriptionPosition.HelpText" HelpText="Position:" ResourceKey="lblChameleonGalleryTitleDescriptionPosition.Text" Text="Position:" />
											</td>
											<td>
												<asp:TextBox ID="tbChameleonGalleryCaptionPriority" runat="server" CssClass="small textCenter">4</asp:TextBox>
												<asp:RequiredFieldValidator ID="rfvLightBoxGalleryImageWidth11" runat="server" ControlToValidate="tbChameleonGalleryCaptionPriority" Display="Dynamic" ErrorMessage="This field is required." resourcekey="rfvLightBoxGalleryImageWidthResource1.ErrorMessage" ValidationGroup="vgChameleonSettings" CssClass="smallInfo warning"></asp:RequiredFieldValidator>
												<asp:CompareValidator ID="cvLightBoxGalleryImageHeight10" runat="server" ControlToValidate="tbChameleonGalleryCaptionPriority" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" resourcekey="cvLightBoxGalleryImageHeightResource1.ErrorMessage" Type="Integer" ValidationGroup="vgChameleonSettings" CssClass="smallInfo warning"></asp:CompareValidator>
											</td>
										</tr>
										<tr id="trChamcTitleDescExpand" runat="server">
											<td>
												<dnn:Label ID="lblChameleonGalleryTitleDescriptionExpand" runat="server" HelpKey="lblChameleonGalleryTitleDescriptionExpand.HelpText" HelpText="Expand to 100% width:" ResourceKey="lblChameleonGalleryTitleDescriptionExpand.Text" Text="Expand to 100% width:" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbChameleonGalleryCaptionExpand" runat="server" Text="Expand to 100% width" />
												</div>
											</td>
										</tr>
										<tr class="color2HighLighted">
											<td colspan="2" class="textCenter">
												<asp:Label ID="lblChameleonGalleryNavigation" runat="server" resourcekey="lblChameleonGalleryNavigation" Text="Navigation"></asp:Label>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblChameleonGalleryShowNavigation" runat="server" HelpKey="lblChameleonGalleryShowNavigation.HelpText" HelpText="Show navigation arrows:" ResourceKey="lblChameleonGalleryShowNavigation.HelpText" Text="Show navigation arrows:" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbChameleonGalleryShowNavigation" runat="server" Checked="True" resourcekey="cbTGShowDescriptionResource1" Text="Show navigation arrows:" />
												</div>
											</td>
										</tr>
										<tr class="color2HighLighted">
											<td colspan="2" class="textCenter">
												<asp:Label ID="lblChameleonGalleryButtons" runat="server" resourcekey="lblChameleonGalleryButtons" Text="Buttons"></asp:Label>
											</td>
										</tr>
										<tr>
											<td class="textTop">
												<dnn:Label ID="lblChameleonGalleryShowSharingButtons" runat="server" CssClass="styleBolded" HelpKey="lblChameleonGalleryShowSharingButtons.HelpText" HelpText="Show social sharing buttons inside Image:" ResourceKey="lblChameleonGalleryShowSharingButtons.Text" Text="Show sharing buttons:" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbChameleonGalleryShowSocialSharing" runat="server" AutoPostBack="True" Checked="True" OnCheckedChanged="cbChameleonGalleryShowSocialSharing_CheckedChanged" Text="Show sharing buttons" />
												</div>
												<asp:Panel ID="pnlChameleonGalleryShowSharing" runat="server" BackColor="#CBEEF8" BorderColor="#65CDEB" BorderStyle="Solid" BorderWidth="2px">
													<table>
														<tr>
															<td>
																<dnn:Label ID="lblChameleonGalleryShowSharingButtonsFacebook" runat="server" HelpKey="lblChameleonGalleryShowSharingButtonsFacebook.HelpText" HelpText="Show Facebook button:" ResourceKey="lblChameleonGalleryShowSharingButtonsFacebook.Text" Text="Show Facebook button:" />
															</td>
															<td>
																<asp:CheckBox ID="cbChameleonGalleryShowSocialFacebook" runat="server" AutoPostBack="True" Checked="True" />
															</td>
														</tr>
														<tr>
															<td>
																<dnn:Label ID="lblChameleonGalleryShowSharingButtonsGoogle" runat="server" HelpKey="lblChameleonGalleryShowSharingButtonsGoogle.HelpText" HelpText="Show Google Plus button:" ResourceKey="lblChameleonGalleryShowSharingButtonsGoogle.Text" Text="Show Google Plus button:" />
															</td>
															<td>
																<asp:CheckBox ID="cbChameleonGalleryShowSocialGoogle" runat="server" AutoPostBack="True" Checked="True" />
															</td>
														</tr>
														<tr>
															<td>
																<dnn:Label ID="lblChameleonGalleryShowSharingButtonsTwitter" runat="server" HelpKey="lblChameleonGalleryShowSharingButtonsTwitter.HelpText" HelpText="Show Twitter button:" ResourceKey="lblChameleonGalleryShowSharingButtonsTwitter.Text" Text="Show Twitter button:" />
															</td>
															<td>
																<asp:CheckBox ID="cbChameleonGalleryShowSocialTwitter" runat="server" AutoPostBack="True" Checked="True" />
															</td>
														</tr>
													</table>
												</asp:Panel>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblChameleonGalleryDisplayEmailButton" runat="server" HelpKey="lblChameleonGalleryDisplayEmailButton.HelpText" HelpText="Display email button:" ResourceKey="lblChameleonGalleryDisplayEmailButton.Text" Text="Display email button:" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbChameleonGalleryDisplayEmailButton" runat="server" Checked="True" Text="Display email button" />
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblChameleonGalleryDisplayDownloadButton" runat="server" HelpKey="lblASSDisplayDownloadButton.HelpKey" HelpText="Display download button:" ResourceKey="lblASSDisplayDownloadButton" Text="Display download button:" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbChameleonGalleryDisplayDownloadButton" runat="server" Checked="True" Text="Display download button" />
												</div>
											</td>
										</tr>
										<tr class="color2HighLighted">
											<td colspan="2" class="textCenter">
												<asp:Label ID="lblChameleonGalleryEffects" runat="server" Font-Bold="True" resourcekey="lblChameleonGalleryEffects" Text="Effects"></asp:Label>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblChameleonGallerySlideEffect" runat="server" HelpKey="lblASSSlideEffect.HelpKey" HelpText="Image transition effect:" ResourceKey="lblASSSlideEffect" Text="Image transition effect:" />
											</td>
											<td>
												<div class="styledSelect">
													<asp:DropDownList ID="ddlChameleonGalleryTransitionEffect" runat="server">
														<asp:ListItem resourcekey="ddlChameleonGalleryTransitionEffectFade" Value="fade">Fade</asp:ListItem>
														<asp:ListItem resourcekey="ddlChameleonGalleryTransitionEffectSlide" Selected="True" Value="slide">Slide</asp:ListItem>
														<asp:ListItem resourcekey="ddlChameleonGalleryTransitionEffectShow" Value="show">Show</asp:ListItem>
													</asp:DropDownList>
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblChameleonGalleryTransitionSpeed0" runat="server" HelpKey="lblASStransitionSpeed.HelpKey" HelpText="Transition speed:" ResourceKey="lblASStransitionSpeed" Text="Transition speed:" />
											</td>
											<td>
												<asp:TextBox ID="tbChameleonGalleryIntervalSpeed" runat="server" ValidationGroup="vgChameleonSettings" CssClass="small textCenter">1000</asp:TextBox>
												<asp:RequiredFieldValidator ID="rfvLightBoxGalleryNumberOfColumns24" runat="server" ControlToValidate="tbChameleonGalleryIntervalSpeed" Display="Dynamic" ErrorMessage="This field is required." resourcekey="rfvLightBoxGalleryNumberOfColumnsResource1.ErrorMessage" ValidationGroup="vgChameleonSettings" CssClass="smallInfo warning"></asp:RequiredFieldValidator>
												<asp:CompareValidator ID="cvLightBoxGalleryNumberOfColumns24" runat="server" ControlToValidate="tbChameleonGalleryIntervalSpeed" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" resourcekey="cvLightBoxGalleryNumberOfColumnsResource1.ErrorMessage" Type="Integer" ValidationGroup="vgChameleonSettings" CssClass="smallInfo warning"></asp:CompareValidator>
											</td>
										</tr>
										<tr class="color2HighLighted">
											<td colspan="2" class="textCenter">
												<asp:Label ID="lblChameleonGalleryAutoPLAy" runat="server" resourcekey="lblChameleonGalleryAutoPLAy" Text="Autoplay"></asp:Label>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblChameleonGalleryDisplayPlayButton" runat="server" HelpText="Autoplay:" Text="Autoplay:" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbChameleonGalleryAutoPlay" runat="server" Checked="True" resourcekey="cbTGShowDescriptionResource1" Text="Autoplay" />
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblChameleonGalleryAutoPlayInterval" runat="server" HelpKey="lblChameleonGalleryAutoPlayInterval.HelpText" HelpText="Autoplay interval:" ResourceKey="lblChameleonGalleryAutoPlayInterval.Text" Text="Autoplay interval:" />
											</td>
											<td>
												<asp:TextBox ID="tbChameleonGalleryAutoPlayInterval" runat="server" CssClass="small textCenter">5000</asp:TextBox>
												<asp:RequiredFieldValidator ID="rfvLightBoxGalleryNumberOfColumns25" runat="server" ControlToValidate="tbChameleonGalleryAutoPlayInterval" Display="Dynamic" ErrorMessage="This field is required." resourcekey="rfvLightBoxGalleryNumberOfColumnsResource1.ErrorMessage" ValidationGroup="vgChameleonSettings" CssClass="smallInfo warning"></asp:RequiredFieldValidator>
												<asp:CompareValidator ID="cvLightBoxGalleryNumberOfColumns25" runat="server" ControlToValidate="tbChameleonGalleryAutoPlayInterval" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" resourcekey="cvLightBoxGalleryNumberOfColumnsResource1.ErrorMessage" Type="Integer" ValidationGroup="vgChameleonSettings" CssClass="smallInfo warning"></asp:CompareValidator>
											</td>
										</tr>
										<tr class="color2HighLighted">
											<td colspan="2" class="textCenter">
												<asp:Label ID="lblChameleonGalleryVideoOptions" runat="server" resourcekey="lblChameleonGalleryVideoOptions" Text="Video options"></asp:Label>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblChameleonGalleryVideoPlayPlace" runat="server" HelpKey="lblChameleonGalleryVideoPlayPlace.HelpText" HelpText="Play video embedded in page or play video in lightbox:" ResourceKey="lblChameleonGalleryVideoPlayPlace.Text" Text="Video play place:" />
											</td>
											<td>
												<asp:RadioButtonList ID="rblChameleonGalleryVideoPlayPlace" runat="server" RepeatDirection="Horizontal" CssClass="styledRadio small">
													<asp:ListItem resourcekey="rblChameleonGalleryVideoPlayPlaceLB" Value="videolightbox">Play video in lightbox</asp:ListItem>
													<asp:ListItem resourcekey="rblChameleonGalleryVideoPlayPlaceEM" Selected="True" Value="videoembed">Play video embedded in page</asp:ListItem>
												</asp:RadioButtonList>
											</td>
										</tr>
										<tr>
											<td class="textTop">
												<dnn:Label ID="lblLightBoxGalleryVideoPlayerSelect2" runat="server" HelpKey="SelectVideoPlayer.HelpText" HelpText="Select player:" ResourceKey="SelectVideoPlayer.Text" Text="Select player:" />
											</td>
											<td>
												<div class="styledSelect">
													<asp:DropDownList ID="ddlChameleonGalleryVPSelectPlayer" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlChameleonGalleryVPSelectPlayer_SelectedIndexChanged">
														<asp:ListItem Selected="True" Value="True">Flow player</asp:ListItem>
														<asp:ListItem Value="False">Standard</asp:ListItem>
													</asp:DropDownList>
												</div>
												<asp:Panel ID="pnlFlowPlayerOptionsChameleon" runat="server" Visible="False">
													<table class="clearWidth textLeft">
														<tr>
															<td class="nowrap">
																<asp:Label ID="lblFlowVideoScalingChameleon" runat="server" resourcekey="lblFlowVideoScaling" Text="Video scaling:"></asp:Label>
															</td>
															<td>&nbsp;</td>
															<td>
																<div class="styledSelect">
																	<asp:DropDownList ID="ddlFlowPlayerScalingChameleon" runat="server" AutoPostBack="True">
																		<asp:ListItem resourcekey="liScale" Value="scale">Scale</asp:ListItem>
																		<asp:ListItem resourcekey="liorig" Value="orig">Original</asp:ListItem>
																		<asp:ListItem resourcekey="lihalf" Value="half">Half</asp:ListItem>
																		<asp:ListItem resourcekey="lifit" Value="fit">Fit to window</asp:ListItem>
																	</asp:DropDownList>
																</div>
															</td>
														</tr>
													</table>
												</asp:Panel>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblChameleonGalleryVideoPlayerSelectSkin" runat="server" HelpKey="lblLightBoxGalleryVideoPlayerSelectSkin.HelpText" HelpText="Select video player skin:" ResourceKey="lblLightBoxGalleryVideoPlayerSelectSkin" Text="Select video player skin:" />
											</td>
											<td>
												<div class="styledSelect">
													<asp:DropDownList ID="ddlChameleonGalleryVPSelectTheme" runat="server">
														<asp:ListItem resourcekey="ListItemResource28" Selected="True" Value="black">Black</asp:ListItem>
														<asp:ListItem resourcekey="ListItemResource29" Value="white">White</asp:ListItem>
													</asp:DropDownList>
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblLightBoxGalleryVideoPlayerPlayOnLoad1" runat="server" HelpKey="lblLightBoxGalleryVideoPlayerPlayOnLoad.HelpText" HelpText="Start to play video on page load:" ResourceKey="lblLightBoxGalleryVideoPlayerPlayOnLoad" Text="Play on load:" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbChameleonGalleryPlayOnLoad" runat="server" resourcekey="cbTGVPPlayOnLoadResource1" Text="Play on load" />
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblChameleonGalleryInitialVolume" ResourceKey="lblChameleonGalleryInitialVolume" runat="server" HelpText="Initial video volume:" Text="Initial video volume:" HelpKey="lblChameleonGalleryInitialVolume.HelpText" />
											</td>
											<td>
												<asp:TextBox ID="tbChameleonGalleryInitialVolume" runat="server" ValidationGroup="vgVGSettings" CssClass="small textCenter">100</asp:TextBox>
												<asp:RequiredFieldValidator ID="rfvChameleonGalleryInitialVolume" runat="server" ControlToValidate="tbChameleonGalleryInitialVolume" Display="Dynamic" ErrorMessage="This field is required." ValidationGroup="vgChameleonSettings" CssClass="smallInfo warning"></asp:RequiredFieldValidator>
												<asp:RangeValidator ID="rvChameleonGalleryInitialVolume" runat="server" ControlToValidate="tbChameleonGalleryInitialVolume" Display="Dynamic" ErrorMessage="Enter value between 0-100." MaximumValue="100" MinimumValue="0" Type="Integer" ValidationGroup="vgChameleonSettings" CssClass="smallInfo warning"></asp:RangeValidator>
											</td>
										</tr>
										<tr class="color2HighLighted">
											<td colspan="2" class="textCenter">
												<asp:Label ID="lblChameleonGalleryAudioOptions" runat="server" resourcekey="lblChameleonGalleryAudioOptions" Text="Audio options"></asp:Label>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblChameleonGalleryAudioDisplay" runat="server" HelpKey="lblChameleonGalleryAudioDisplay.HelpText" HelpText="Play audio embedded in page or play audio in lightbox:" ResourceKey="lblChameleonGalleryAudioDisplay.Text" Text="Audio play place:" />
											</td>
											<td>
												<asp:RadioButtonList ID="rblChameleonGalleryAudioPlayPlace" runat="server" RepeatDirection="Horizontal" CssClass="styledRadio small">
													<asp:ListItem resourcekey="rblChameleonGalleryAudioPlayPlaceLB" Value="audiolightbox">Play audio in lightbox</asp:ListItem>
													<asp:ListItem resourcekey="rblChameleonGalleryAudioPlayPlaceEM" Selected="True" Value="audioembed">Play audio embedded in page</asp:ListItem>
												</asp:RadioButtonList>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblChameleonGalleryAudioPlayerPlayOnLoad" runat="server" HelpKey="lblLightBoxGalleryAudioPlayerPlayOnLoad.HelpText" HelpText="Start to play audio on page load:" ResourceKey="lblLightBoxGalleryAudioPlayerPlayOnLoad" Text="Play on load:" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbChameleonGalleryAudioPlayOnLoad" runat="server" resourcekey="cbTGAPPlayOnLoadResource1" Text="Play on load" />
												</div>
											</td>
										</tr>
										<tr class="color2HighLighted">
											<td colspan="2" class="textCenter">
												<asp:Label ID="lblChameleonGalleryFullscreen" runat="server" resourcekey="lblChameleonGalleryFullscreen" Text="Fullscreen"></asp:Label>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblChameleonGalleryEnableFullscreen" runat="server" HelpKey="lblChameleonGalleryEnableFullscreen.HelpText" HelpText="Enable fullscreen:" ResourceKey="lblChameleonGalleryEnableFullscreen" Text="Enable fullscreen:" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbChameleonGalleryEnableFullscreen" runat="server" AutoPostBack="True" OnCheckedChanged="cbChameleonGalleryEnableFullscreen_CheckedChanged" Text="Enable fullscreen" />
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblChameleonGalleryFullscreenAutohide" runat="server" HelpKey="lblChameleonGalleryFullscreenAutohide.HelpText" HelpText="Enable thumbnail and category auto hide:" ResourceKey="lblChameleonGalleryFullscreenAutohide" Text="Enable thumbnail and category auto hide:" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbChameleonGalleryFullscreenAutohide" runat="server" Text="Enable thumbnail and category auto hide" />
												</div>
											</td>
										</tr>
										<tr class="color2HighLighted">
											<td colspan="2" class="textCenter">
												<asp:Label ID="lblChameleonGalleryToolTips" runat="server" resourcekey="lblChameleonGalleryToolTipsTitle" Text="Tooltips"></asp:Label>
											</td>
										</tr>
										<tr>
											<td class="textTop">
												<dnn:Label ID="lblChameleonGalleryShowTooltips" runat="server" HelpKey="lblChameleonGalleryToolTips.HelpText" HelpText="Show tooltips on thumbnail mouse over:" ResourceKey="lblChameleonGalleryToolTips" Text="Show tooltips:" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbChameleonGalleryShowTooltips" runat="server" AutoPostBack="True" OnCheckedChanged="cbChameleonGalleryShowTooltips_CheckedChanged" Text="Show tooltips" />
												</div>
												<asp:Panel ID="pnlChameleonGalleryQtipOptions" runat="server" BackColor="#CBEEF8" BorderColor="#65CDEB" BorderStyle="Solid" BorderWidth="2px" Visible="False" CssClass="paddingTopBottom">
													<table class="clearWidth textLeft">
														<tr>
															<td class="nowrap">
																<dnn:Label ID="lblChameleonGalleryShowTooltipsTitle" runat="server" HelpKey="lblChameleonGalleryShowTooltipsTitle.HelpText" HelpText="Show title in tooltips:" ResourceKey="lblChameleonGalleryShowTooltipsTitle" Text="Show title in tooltips:" />
															</td>
															<td>&nbsp;</td>
															<td>
																<asp:CheckBox ID="cbChameleonGalleryShowTooltipTitle" runat="server" Checked="True" />
															</td>
														</tr>
														<tr>
															<td class="nowrap">
																<dnn:Label ID="lblChameleonGalleryShowTooltipsDescription" runat="server" HelpKey="cbChameleonGalleryShowTooltipDescription.HelpText" HelpText="Show description in tooltips:" ResourceKey="cbChameleonGalleryShowTooltipDescription" Text="Show description in tooltips:" />
															</td>
															<td>&nbsp;</td>
															<td>
																<asp:CheckBox ID="cbChameleonGalleryShowTooltipDescription" runat="server" />
															</td>
														</tr>
														<tr>
															<td class="nowrap">
																<dnn:Label ID="lblChameleonGalleryShowTooltipsPosition" runat="server" HelpKey="lblChameleonGalleryShowTooltipsPosition.HelpText" HelpText="Tooltips position:" ResourceKey="lblChameleonGalleryShowTooltipsPosition" Text="Tooltips position:" />
															</td>
															<td>&nbsp;</td>
															<td>
																<asp:DropDownList ID="ddlChameleonGalleryToolTipPosition" runat="server">
																	<asp:ListItem Value="top">Top</asp:ListItem>
																	<asp:ListItem Value="bottom">Bottom</asp:ListItem>
																	<asp:ListItem Value="left">Left</asp:ListItem>
																	<asp:ListItem Value="right">Right</asp:ListItem>
																</asp:DropDownList>
															</td>
														</tr>
														<tr>
															<td class="nowrap">
																<dnn:Label ID="lblChameleonGalleryShowTooltipsStyle" runat="server" HelpKey="lblChameleonGalleryShowTooltipsStyle.HelpText" HelpText="Tooltips style:" ResourceKey="lblChameleonGalleryShowTooltipsStyle" Text="Tooltips style:" />
															</td>
															<td>&nbsp;</td>
															<td>
																<asp:DropDownList ID="ddlChameleonGalleryToolTipClasss" runat="server">
																	<asp:ListItem Text="grey" Value="grey" />
																	<asp:ListItem Text="red" Value="red" />
																	<asp:ListItem Text="green" Value="green" />
																	<asp:ListItem Text="blue" Value="blue" />
																</asp:DropDownList>
															</td>
														</tr>
													</table>
												</asp:Panel>
											</td>
										</tr>
										<tr>
											<td colspan="2"></td>
										</tr>
										<tr id="trChameleonShowThumbsInLightbox" runat="server">
											<td>
												<dnn:Label ID="Label20" runat="server" HelpKey="lblLightboxGalleryLightboxThumbnails.HelpText" HelpText="Show thumbnails inside lightbox:" ResourceKey="lblLightboxGalleryLightboxThumbnails" Text="Show thumbnails inside lightbox:" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbChameleonGalleryGalleryShowThumbnailsInLightbox" runat="server" resourcekey="cbLightboxGalleryLightboxThumbnailsResource1" Text="Show thumbnails inside lightbox" />
												</div>
											</td>
										</tr>
										<tr id="trChameleonShowTitleInLightbox" runat="server">
											<td>
												<dnn:Label ID="lblLightboxGalleryShowLightboxTitle1" runat="server" HelpKey="lblLightboxGalleryShowLightboxTitle.HelpText" HelpText="Show media title in lightbox:" ResourceKey="lblLightboxGalleryShowLightboxTitle" Text="Show media title in lightbox:" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbChameleonGalleryShowLightboxTitle" runat="server" resourcekey="cbLightboxGalleryShowLightboxTitleResource1" Text="Show media title in lightbox" />
												</div>
											</td>
										</tr>
										<tr id="trChameleonShowDescriptionInLightbox" runat="server">
											<td>
												<dnn:Label ID="lblLightboxGalleryLightboxDescription1" runat="server" HelpKey="lblLightboxGalleryLightboxDescription.HelpText" HelpText="Show media description in lightbox:" ResourceKey="lblLightboxGalleryLightboxDescription" Text="Show media description in lightbox:" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbChameleonGalleryShowLightboxDescription" runat="server" AutoPostBack="True" OnCheckedChanged="cbTGShowLightboxDescription_CheckedChanged" resourcekey="cbTGShowLightboxDescriptionResource1" Text="Show media description in lightbox" />
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblChameleonGalleryOpenMediaUrl" runat="server" HelpKey="lblLightBoxGalleryOpenMediaUrl.HelpText" HelpText="On image click dont open image in lightbox, but open Media Url link." ResourceKey="lblLightBoxGalleryOpenMediaUrl" Text="On click go to Media Url:" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbChameleonGalleryGalleryOpenMediaUrl" runat="server" AutoPostBack="True" OnCheckedChanged="cbChameleonGalleryGalleryOpenMediaUrl_CheckedChanged" resourcekey="cbLightBoxGalleryOpenMediaUrlResource1" Text="On click go to Media Url" />
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblChameleonGalleryOpenMediaUrlNewWindow" runat="server" HelpKey="lblLightBoxGalleryOpenMediaUrlNewWindow.HelpText" HelpText="Open link in new window:" ResourceKey="lblLightBoxGalleryOpenMediaUrlNewWindow" Text="Open link in new window:" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbChameleonGalleryOpenMediaUrlNewWindow" runat="server" Enabled="False" resourcekey="cbLightBoxGalleryOpenMediaUrlNewWindowResource1" Text="Open link in new window" />
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblChameleonGalleryOnClickNothing" runat="server" HelpKey="lblChameleonGalleryOnClickNothing.HelpText" HelpText="No action on mouse click no main image panel:" ResourceKey="lblChameleonGalleryOnClickNothing" Text="Open media in lightbox:" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbChameleonGalleryOpenInLightbox" runat="server" AutoPostBack="True" Checked="True" OnCheckedChanged="cbChameleonGalleryNothigOnclick_CheckedChanged" resourcekey="cbLightBoxGalleryOpenMediaUrlNewWindowResource1" Text="Open media in lightbox" />
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblChameleonGalleryRandomizeMedia" runat="server" HelpKey="lblLightBoxRandomizeMedia.HelpText" HelpText="Randomize media positions on every page load:" ResourceKey="lblLightBoxRandomizeMedia" Text="Randomize media positions:" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbChameleonGalleryRandomizeMedia" runat="server" AutoPostBack="True" OnCheckedChanged="cbChameleonGalleryRandomizeMedia_CheckedChanged" resourcekey="cbLightBoxGallerySmartCropVerticalResource1" Text="Randomize media positions" />
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblChameleonGalleryGrayscaleThumbnails" runat="server" HelpKey="lblChameleonGalleryGrayscaleThumbnails.HelpText" HelpText="Thumbnails will be desaturated." ResourceKey="lblChameleonGalleryGrayscaleThumbnails" Text="Create grayscale thumbnails:" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbChameleonGalleryCreateGrayScaleImages" runat="server" Text="Create grayscale thumbnails" />
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblChameleonGalleryEnableDragging" runat="server" HelpKey="lblChameleonGalleryEnableDragging" HelpText="Enable item dragging:" ResourceKey="lblChameleonGalleryEnableDragging" Text="Touch &amp; swipe:" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbChameleonGalleryEnableItemDragging" runat="server" Checked="True" Text="Touch &amp; swipe" />
												</div>
											</td>
										</tr>
										<tr>
											<td class="textTop">
												<dnn:Label ID="lblMainImageResize" runat="server" HelpKey="lblMainImageResize.HelpText" HelpText="Main image resize:" ResourceKey="lblMainImageResize" Text="Main image resize:" />
											</td>
											<td>
												<asp:RadioButtonList ID="rblChameleonGalleryMainImageRsize" runat="server" RepeatDirection="vertical" AutoPostBack="True" OnSelectedIndexChanged="rblChameleonGalleryMainImageRsize_SelectedIndexChanged" CssClass="styledRadio small">
													<asp:ListItem resourcekey="liResCrop" Selected="True" Value="default">Resize and crop</asp:ListItem>
													<asp:ListItem resourcekey="liProportionally" Value="proportionally">Proportionally resize</asp:ListItem>
													<asp:ListItem resourcekey="liProportionallyVertical" Value="proportionallyVertical">Proportionally resize vertical images</asp:ListItem>
												</asp:RadioButtonList>
											</td>
										</tr>
										<tr id="trChameleonGalleryFillColor" runat="server" visible="false">
											<td>
												<dnn:Label ID="lblChameleonGalleryFillColor" runat="server" ControlName="tbChameleonGalleryFillColor" HelpText="Set the color of added space in rgb format with hex values:" Text="Added space color (hex value RRGGBB):" />
											</td>
											<td>
												<asp:TextBox ID="tbChameleonGalleryFillColor" runat="server" MaxLength="6" ValidationGroup="vgChameleonSettings" CssClass="small textCenter">FFFFFF</asp:TextBox>
												<asp:RegularExpressionValidator ID="revChameleonGalleryFillColor" runat="server" ControlToValidate="tbChameleonGalleryFillColor" ErrorMessage="Please eneter hexadecimal color value." resourcekey="revSlideShowThumbnailsOverlayTextColorResource1.ErrorMessage" ValidationExpression="^#?([a-f]|[A-F]|[0-9]){3}(([a-f]|[A-F]|[0-9]){3})?$" ValidationGroup="vgChameleonSettings" Display="Dynamic" SetFocusOnError="True" CssClass="smallInfo warning"></asp:RegularExpressionValidator>
												<asp:RequiredFieldValidator ID="rfvChameleonGalleryFillColor" runat="server" ControlToValidate="tbChameleonGalleryFillColor" Display="Dynamic" ErrorMessage="This field is required." resourcekey="rfvLightBoxGalleryNumberOfColumnsResource1.ErrorMessage" SetFocusOnError="True" ValidationGroup="vgChameleonSettings" CssClass="smallInfo warning"></asp:RequiredFieldValidator>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblChamaleonAlignTopLeft" runat="server" HelpKey="lblChamaleonAlignTopLeft.HelpText" HelpText="Align image in main panel:" ResourceKey="lblChamaleonAlignTopLeft" Text="Align image in main panel:" />
											</td>
											<td>
												<div class="styledSelect">
													<asp:DropDownList ID="ddlChameleonGalleryAlignimageinmainpanel" runat="server">
														<asp:ListItem resourcekey="liCenterCenter" Value="false">Center center</asp:ListItem>
														<asp:ListItem resourcekey="liTopLeft" Value="true">Top left</asp:ListItem>
													</asp:DropDownList>
												</div>
											</td>
										</tr>
										<tr>
											<td colspan="2"></td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblChameleonGalleryMediaSorting" runat="server" HelpKey="lblLightBoxMediaSorting.HelpText" HelpText="Select media sorting options:" ResourceKey="lblLightBoxMediaSorting" Text="Media sorting:" />
											</td>
											<td>
												<table class="clearWidth textLeft">
													<tr>
														<td>
															<div class="styledSelect">
																<asp:DropDownList ID="ddlChameleonGalleryMediaSort" runat="server">
																	<asp:ListItem resourcekey="liPosition" Value="Position">Position</asp:ListItem>
																	<asp:ListItem resourcekey="liDateUploaded" Value="DateUploaded">Date uploaded</asp:ListItem>
																	<asp:ListItem resourcekey="liFileName" Value="FileName">Filename</asp:ListItem>
																	<asp:ListItem resourcekey="liTitle">Title</asp:ListItem>
																</asp:DropDownList>
															</div>
														</td>
														<td>&nbsp;</td>
														<td>
															<asp:RadioButtonList ID="rblChameleonGalleryMediaSortType" runat="server" RepeatDirection="Horizontal" CssClass="styledRadio small">
																<asp:ListItem resourcekey="liAscending" Selected="True" Value="ASC">Ascending</asp:ListItem>
																<asp:ListItem resourcekey="liDescending" Value="DESC">Descending</asp:ListItem>
															</asp:RadioButtonList>
														</td>
													</tr>
												</table>
											</td>
										</tr>
									</table>
									<asp:Label ID="lblChameleonGalleryStatus" runat="server" EnableViewState="False"></asp:Label>
									<div class="mainActions">
										<asp:LinkButton ID="btnChameleonGallerySave" runat="server" OnClick="btnChameleonGallerySave_Click" resourcekey="btnLightBoxGallerySaveResource1" Text="Save settings" ValidationGroup="vgChameleonSettings" CssClass="downSave" />
										<asp:LinkButton ID="btnChameleonGallerySaveClose" runat="server" OnClick="btnChameleonGallerySaveClose_Click" resourcekey="btnLightBoxGallerySaveCloseResource1" Text="Save &amp; Close" ValidationGroup="vgChameleonSettings" CssClass="downSaveClose" />
									</div>
								</div>
							</asp:Panel>
							<asp:Panel ID="pnlPortfolioPro" runat="server" Visible="False" CssClass="settingsList negativeMargins40">
								<h3>
									<asp:Label ID="lblPortfolioPro" resourcekey="lblPortfolioPro" runat="server" CssClass="settingsdetailtitle" Text="PortfolioPro"></asp:Label>
								</h3>
								<div class="settingsTable">
									<table>
										<tr class="color2HighLighted">
											<td colspan="2" class="textCenter">Predefined settings</td>
										</tr>
										<tr>
											<td colspan="2">
												<asp:HiddenField ID="hfPortfolioProTemplate" runat="server" Value="0" />
												<asp:DataList ID="dlPortfolioProPresets" runat="server" RepeatColumns="4" RepeatDirection="Horizontal" CssClass="predefinedThumbnails fourInRow" ItemStyle-HorizontalAlign="Center" ItemStyle-VerticalAlign="Top" OnItemCommand="dlPortfolioProPresets_ItemCommand" OnPreRender="dlPortfolioProPresets_PreRender">
													<ItemTemplate>
														<div class="thumbnail">
															<asp:Image ID="imgThumbPreSet" runat="server" ImageUrl='<%# DataBinder.Eval(Container.DataItem, "ImageURL") %>' CssClass="presetImage" />
															<h5 class="presetName">
																<asp:HiddenField ID="hfPresetFileName" runat="server" Value='<%#DataBinder.Eval(Container.DataItem, "FileName")%>' />
																<asp:Label ID="lblPresetName" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "Name") %>'></asp:Label>
															</h5>
															<asp:LinkButton ID="lbLoadXmlPreSet" runat="server" CommandArgument='<%# DataBinder.Eval(Container.DataItem, "FileName") %>' CommandName="Load" CssClass="selectPreSettings"><span>Load</span></asp:LinkButton>
														</div>
													</ItemTemplate>
												</asp:DataList>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblPortfolioProGridAdjustment" runat="server" Text="Layout grid adjustment:" HelpText="Layout grid adjustment:" />
											</td>
											<td>
												<div class="styledSelect">
													<asp:DropDownList ID="ddlPortfolioProGridAdjustment" runat="server">
														<asp:ListItem resourceky="liResponsive" Value="0" Selected="True">Responsive</asp:ListItem>
														<asp:ListItem resourceky="liAlignCenter" Value="1">Align Center</asp:ListItem>
														<asp:ListItem resourceky="liNoadjustment" Value="2">No adjustment</asp:ListItem>
													</asp:DropDownList>
												</div>
											</td>
										</tr>
										<tr>
											<td colspan="2"></td>
										</tr>
										<tr class="color6HighLighted">
											<td colspan="2" class="noLeftRightPadding">
												<table>
													<tr>
														<td>
															<dnn:Label ID="lblPortfolioProDisplayNestedGalleries" runat="server" HelpText="Display nested galleries:" Text="Display nested galleries:" />
														</td>
														<td>
															<div class="styledCheckbox noLabel">
																<asp:CheckBox ID="cbPortfolioProDisplayNestedGalleries" runat="server" AutoPostBack="True" Text="Display nested galleries" OnCheckedChanged="cbPortfolioProDisplayNestedGalleries_CheckedChanged" />
															</div>
														</td>
													</tr>
												</table>
												<asp:Panel ID="pnlPortfolioProNestedGalleries" runat="server" Visible="False">
													<asp:Panel ID="Panel2" runat="server">
														<table>
															<tr class="color1HighLighted">
																<td class="textCenter">
																	<asp:Label ID="Label17" runat="server" CssClass="settingsdetailtitle" resourcekey="lblLightboxGalleryNestedGallerySettingsResource1" Text="Nested galleries settings"></asp:Label>
																</td>
															</tr>
															<tr>
																<td>
																	<table class="settingsTable">
																		<tr>
																			<td class="textTop">
																				<asp:Label ID="Label18" runat="server" Font-Bold="True" resourcekey="lblLightboxGalleryNestedGallerySelectionResource1" Text="Gallery selection:"></asp:Label>
																			</td>
																			<td>
																				<asp:CheckBoxList ID="cblPortfolioProNestedGaleries" runat="server" DataSourceID="odsGallery" DataTextField="GalleryName" DataValueField="GalleryID" OnDataBound="cblTGNGGallerySelection_DataBound" OnSelectedIndexChanged="cblChameleonGalleryNestedGallerySelection_SelectedIndexChanged" RepeatColumns="2" CssClass="nestedGalleryList styledCheckbox"></asp:CheckBoxList>
																				<asp:Label ID="lblPortfolioProSelectOneNestedGallery" runat="server" Text="Please add an select some galleries." Visible="False" CssClass="infoMessages warning static"></asp:Label>
																			</td>
																		</tr>
																		<tr>
																			<td colspan="2"></td>
																		</tr>
																		<tr>
																			<td></td>
																			<td>
																				<div class="styledCheckbox">
																					<asp:CheckBox ID="cbPortfolioProSelectAllNestedGaleries" runat="server" AutoPostBack="True" OnCheckedChanged="cbPortfolioProSelectAllNestedGaleries_CheckedChanged" Text="Show all galleries" />
																				</div>
																			</td>
																		</tr>
																		<tr>
																			<td></td>
																			<td>
																				<div class="styledCheckbox">
																					<asp:CheckBox ID="cbPortfolioProShowGalleryMediaCounter" runat="server" Checked="True" Text="Show gallery media counter" />
																				</div>
																			</td>
																		</tr>
																		<tr>
																			<td></td>
																			<td>
																				<div class="styledCheckbox">
																					<asp:CheckBox ID="cbPortfolioProShowAllButton" runat="server" Checked="True" Text="Show all button" AutoPostBack="True" OnCheckedChanged="cbPortfolioProShowAllButton_CheckedChanged" />
																				</div>
																			</td>
																		</tr>
																		<tr runat="server" id="trPortfolioProAllButtonPosition" visible="False">
																			<td>
																				<dnn:Label ID="lblPortfolioProAllButtonPosition" runat="server" HelpText="All button position." Text="All button position:" />
																			</td>
																			<td>
																				<div class="styledSelect">
																					<asp:DropDownList ID="ddlPortfolioProAllButtonPosition" runat="server">
																						<asp:ListItem Value="0">First</asp:ListItem>
																						<asp:ListItem Value="1">Last</asp:ListItem>
																					</asp:DropDownList>
																				</div>
																			</td>
																		</tr>
																		<tr>
																			<td>
																				<dnn:Label ID="lblPortfolioProNestedAnimationType" runat="server" HelpText="Nested animation type:" Text="Nested animation type:" />
																			</td>
																			<td>
																				<div class="styledSelect">
																					<asp:DropDownList ID="ddlPortfolioProNestedAnimationType" runat="server">
																						<asp:ListItem Value="0">fadeOut</asp:ListItem>
																						<asp:ListItem Value="1">quicksand</asp:ListItem>
																						<asp:ListItem Value="2">boxShadow</asp:ListItem>
																						<asp:ListItem Value="3">bounceLeft</asp:ListItem>
																						<asp:ListItem Value="4">bounceTop</asp:ListItem>
																						<asp:ListItem Value="5">bounceBottom</asp:ListItem>
																						<asp:ListItem Value="6">moveLeft</asp:ListItem>
																						<asp:ListItem Value="7">slideLeft</asp:ListItem>
																						<asp:ListItem Value="8">fadeOutTop</asp:ListItem>
																						<asp:ListItem Value="9"> sequentially</asp:ListItem>
																						<asp:ListItem Value="11">skew</asp:ListItem>
																						<asp:ListItem Value="10">slideDelay</asp:ListItem>
																						<asp:ListItem Value="12">rotateSides</asp:ListItem>
																						<asp:ListItem Value="13">flipOutDelay</asp:ListItem>
																						<asp:ListItem Value="14">flipOut</asp:ListItem>
																						<asp:ListItem Value="15">unfold</asp:ListItem>
																						<asp:ListItem Value="16">foldLeft</asp:ListItem>
																						<asp:ListItem Value="17">scaleDown</asp:ListItem>
																						<asp:ListItem Value="18">scaleSides</asp:ListItem>
																						<asp:ListItem Value="19">frontRow</asp:ListItem>
																						<asp:ListItem Value="20">flipBottom</asp:ListItem>
																						<asp:ListItem Value="21">rotateRoom</asp:ListItem>
																					</asp:DropDownList>
																					<div>
																					</div>
																				</div>
																			</td>
																		</tr>
																		<tr>
																			<td>
																				<dnn:Label ID="lblPortfolioProNestedNavigationType" runat="server" HelpText="Nested menu type:" Text="Nested menu type:" />
																			</td>
																			<td>
																				<div class="styledSelect">
																					<asp:DropDownList ID="ddlPortfolioProNestedNavigationType" runat="server">
																						<asp:ListItem Value="0">Dropdown list</asp:ListItem>
																						<asp:ListItem Value="1">Menu bar</asp:ListItem>
																					</asp:DropDownList>
																				</div>
																			</td>
																		</tr>
																	</table>
																</td>
															</tr>
														</table>
													</asp:Panel>
												</asp:Panel>
											</td>
										</tr>
										<tr>
											<td colspan="2"></td>
										</tr>
										<tr class="color2HighLighted">
											<td colspan="2" class="textCenter">
												<asp:Label ID="lblPortfolioProThemeSelectionTitle" resourcekey="lblPortfolioProThemeSelectionTitle" runat="server" Text="Theme selection"></asp:Label>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblPortfolioProThemeSelection" runat="server" Text="Select theme:" HelpText="Select theme." />
											</td>
											<td>
												<div class="styledSelect">
													<asp:DropDownList ID="ddlPortfolioProThemeSelection" runat="server"></asp:DropDownList>
													<div>
											</td>
										</tr>
										<tr>
											<td colspan="2"></td>
										</tr>
										<tr class="color2HighLighted">
											<td colspan="2" class="textCenter">
												<asp:Label ID="lblPortfolioProTitleAndDescription" resourcekey="lblPortfolioProTitleAndDescription" runat="server" Text="Title and description"></asp:Label>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblPortfolioProShowMediaTitle" runat="server" HelpText="Show media title:" Text="Show media title:" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbPortfolioProShowMediaTitle" runat="server" Checked="True" Text="Show media title" />
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblPortfolioProShowMediaDescription" runat="server" HelpText="Show media description:" Text="Show media description:" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbPortfolioProShowMediaDescription" runat="server" Checked="True" Text="Show media description" />
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblPortfolioProShowSubtitle" runat="server" HelpText="Show media subtitle:" Text="Show media subtitle:" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbPortfolioProShowSubtitle" runat="server" Checked="True" Text="Show media subtitle" />
												</div>
											</td>
										</tr>
										<tr>
											<td class="textTop">
												<dnn:Label ID="lblPortfolioProCaptionAnimationType" runat="server" Text="Caption animation type:" HelpText="Caption animation type:" />
											</td>
											<td>
												<div class="styledSelect">
													<asp:DropDownList ID="ddlPortfolioProCaptionAnimationType" runat="server">
														<asp:ListItem Value="0">pushTop</asp:ListItem>
														<asp:ListItem Value="1">pushDown</asp:ListItem>
														<asp:ListItem Value="2">revealBottom</asp:ListItem>
														<asp:ListItem Value="3">revealTop</asp:ListItem>
														<asp:ListItem Value="4">revealRight</asp:ListItem>
														<asp:ListItem Value="5">revealLeft</asp:ListItem>
														<asp:ListItem Value="6">overlayBottomPush</asp:ListItem>
														<asp:ListItem Value="7">overlayBottom</asp:ListItem>
														<asp:ListItem Value="8">overlayBottomReveal</asp:ListItem>
														<asp:ListItem Value="9">overlayBottomAlong</asp:ListItem>
														<asp:ListItem Value="10">overlayRightAlong</asp:ListItem>
														<asp:ListItem Value="11">minimal</asp:ListItem>
														<asp:ListItem Value="12">fadeIn</asp:ListItem>
														<asp:ListItem Value="13">zoom</asp:ListItem>
													</asp:DropDownList>
												</div>
											</td>
										</tr>
										<tr>
											<td colspan="2"></td>
										</tr>
										<tr class="color2HighLighted">
											<td colspan="2" class="textCenter">
												<asp:Label ID="lblPortfolioProThumbnails" resourcekey="lblPortfolioProThumbnails" runat="server" Text="Thumbnails"></asp:Label>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblPortfolioProThumbnailWidth" runat="server" HelpText="Thumb width:" Text="Thumb width:" />
											</td>
											<td>
												<asp:TextBox ID="tbPortfolioProThumbnailWidth" runat="server" ValidationGroup="vgPortfolioProSettings" CssClass="small textCenter">80</asp:TextBox>
												<asp:RequiredFieldValidator ID="rfvPortfolioProThumbnailWidth" runat="server" ControlToValidate="tbPortfolioProThumbnailWidth" Display="Dynamic" ErrorMessage="This field is required." resourcekey="rfvLightBoxGalleryImageWidthResource1.ErrorMessage" ValidationGroup="vgPortfolioProSettings" CssClass="smallInfo error" />
												<asp:CompareValidator ID="cvPortfolioProThumbnailWidth" runat="server" ControlToValidate="tbPortfolioProThumbnailWidth" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" resourcekey="cvLightBoxGalleryImageWidthResource1.ErrorMessage" Type="Integer" ValidationGroup="vgPortfolioProSettings" CssClass="smallInfo error" />
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblPortfolioProThumbnailHeight" runat="server" HelpText="Thumb Height:" Text="Thumb Height:" />
											</td>
											<td>
												<asp:TextBox ID="tbPortfolioProThumbnailHeight" runat="server" ValidationGroup="vgPortfolioProSettings" CssClass="small textCenter">80</asp:TextBox>
												<asp:RequiredFieldValidator ID="rfvPortfolioProThumbnailHeight" runat="server" ControlToValidate="tbPortfolioProThumbnailHeight" Display="Dynamic" ErrorMessage="This field is required." resourcekey="rfvLightBoxGalleryImageHeightResource1.ErrorMessage" ValidationGroup="vgPortfolioProSettings" CssClass="smallInfo error" />
												<asp:CompareValidator ID="cvPortfolioProThumbnailHeight" runat="server" ControlToValidate="tbPortfolioProThumbnailHeight" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" resourcekey="cvLightBoxGalleryImageHeightResource1.ErrorMessage" Type="Integer" ValidationGroup="vgPortfolioProSettings" CssClass="smallInfo error" />
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblPortfolioProItemsperPage" runat="server" Text="Number of items per page:" HelpText="Number of items per page:"></dnn:Label>
											</td>
											<td>
												<asp:TextBox ID="tbPortfolioProItemsperPage" runat="server" ValidationGroup="vgPortfolioProSettings" CssClass="small textCenter">9</asp:TextBox>
												<asp:RequiredFieldValidator ID="rfvPortfolioProItemsperPage" runat="server" ControlToValidate="tbPortfolioProItemsperPage" ErrorMessage="This field is required." ValidationGroup="vgPortfolioProSettings" Display="Dynamic" resourcekey="rfvLightBoxGalleryNumberOfItemsResource1.ErrorMessage" CssClass="smallInfo error"></asp:RequiredFieldValidator>
												<asp:CompareValidator ID="cvPortfolioProItemsperPage" runat="server" ControlToValidate="tbPortfolioProItemsperPage" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" Type="Integer" ValidationGroup="vgPortfolioProSettings" resourcekey="cvLightBoxGalleryNumberOfItemsResource1.ErrorMessage" CssClass="smallInfo error"></asp:CompareValidator>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblPortfolioProGapHorizontal" runat="server" HelpText="Thumb width:" Text="Items gap horizontal:" />
											</td>
											<td>
												<asp:TextBox ID="tbPortfolioProGapHorizontal" runat="server" ValidationGroup="vgPortfolioProSettings" CssClass="small textCenter">10</asp:TextBox>
												<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="tbPortfolioProGapHorizontal" Display="Dynamic" ErrorMessage="This field is required." resourcekey="rfvLightBoxGalleryImageWidthResource1.ErrorMessage" ValidationGroup="vgPortfolioProSettings" CssClass="smallInfo error" />
												<asp:CompareValidator ID="CompareValidator1" runat="server" ControlToValidate="tbPortfolioProGapHorizontal" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" resourcekey="cvLightBoxGalleryImageWidthResource1.ErrorMessage" Type="Integer" ValidationGroup="vgPortfolioProSettings" CssClass="smallInfo error" />
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblPortfolioProGapVertical" runat="server" HelpText="Thumb vertical." Text="Items gap vertical:" />
											</td>
											<td>
												<asp:TextBox ID="tbPortfolioProGapVertical" runat="server" ValidationGroup="vgPortfolioProSettings" CssClass="small textCenter">10</asp:TextBox>
												<asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="tbPortfolioProGapVertical" Display="Dynamic" ErrorMessage="This field is required." resourcekey="rfvLightBoxGalleryImageWidthResource1.ErrorMessage" ValidationGroup="vgPortfolioProSettings" CssClass="smallInfo error" />
												<asp:CompareValidator ID="CompareValidator2" runat="server" ControlToValidate="tbPortfolioProGapVertical" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" resourcekey="cvLightBoxGalleryImageWidthResource1.ErrorMessage" Type="Integer" ValidationGroup="vgPortfolioProSettings" CssClass="smallInfo error" />
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblPortfolioProImagesDisplaySpeed" runat="server" HelpText="Images display speed." Text="Images display speed:" />
											</td>
											<td>
												<asp:TextBox ID="tbPortfolioProImagesDisplaySpeed" runat="server" ValidationGroup="vgPortfolioProSettings" CssClass="small textCenter">100</asp:TextBox>
												<asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="tbPortfolioProImagesDisplaySpeed" Display="Dynamic" ErrorMessage="This field is required." resourcekey="rfvLightBoxGalleryImageWidthResource1.ErrorMessage" ValidationGroup="vgPortfolioProSettings" CssClass="smallInfo error" />
												<asp:CompareValidator ID="CompareValidator3" runat="server" ControlToValidate="tbPortfolioProImagesDisplaySpeed" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" resourcekey="cvLightBoxGalleryImageWidthResource1.ErrorMessage" Type="Integer" ValidationGroup="vgPortfolioProSettings" CssClass="smallInfo error" />
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblPortfolioProImagesDisplayType" runat="server" Text="Images display type:" HelpText="Images display type:" />
											</td>
											<td>
												<div class="styledSelect">
													<asp:DropDownList ID="ddlPortfolioProImagesDisplayType" runat="server">
														<asp:ListItem Value="0">Default</asp:ListItem>
														<asp:ListItem Value="1">fadeIn</asp:ListItem>
														<asp:ListItem Value="2">lazyLoading</asp:ListItem>
														<asp:ListItem Value="3">fadeInToTop</asp:ListItem>
														<asp:ListItem Value="4">sequentially</asp:ListItem>
														<asp:ListItem Value="5">bottomToTop</asp:ListItem>
													</asp:DropDownList>
												</div>
											</td>
										</tr>
										<tr>
											<td colspan="2"></td>
										</tr>
										<tr class="color2HighLighted">
											<td colspan="2" class="textCenter">
												<asp:Label ID="lblPortfolioProLightboxOptions" resourcekey="lblPortfolioProLightboxOptions" runat="server" Text="Lightbox options" />
											</td>
										</tr>
										<tr id="trPortfolioProOpenInLightbox" runat="server" visible="false">
											<td>
												<dnn:Label ID="lblPortfolioProOpenInLightbox" runat="server" HelpText="Open media in lightbox:" Text="Open media in lightbox:" />
											</td>
											<td>
												<asp:RadioButtonList ID="rblPortfolioProOpenInLightbox" runat="server" RepeatDirection="Horizontal" CssClass="styledRadio">
													<asp:ListItem Selected="True" Value="0">Open in Lightbox</asp:ListItem>
													<asp:ListItem Selected="False" Value="1">Full page</asp:ListItem>
													<asp:ListItem Value="2">Inline</asp:ListItem>
													<asp:ListItem Value="3">Open image file</asp:ListItem>
												</asp:RadioButtonList>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblPortfolioProShowImageCounter" runat="server" HelpText="Show image counter in lightbox:" Text="Show image counter in lightbox" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbPortfolioProShowImageCounter" runat="server" Checked="True" Text="Show image counter in lightbox" />
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblPortfolioProShowTitleInLightbox" runat="server" HelpText="Show title in lightbox:" Text="Show title in lightbox" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbPortfolioProShowTitleInLightbox" runat="server" Checked="True" Text="Show title in lightbox" />
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblPortfolioProShowDescriptionInLightbox" runat="server" HelpText="Show description in lightbox:" Text="Show description in lightbox" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbPortfolioProShowDescriptionInLightbox" runat="server" Checked="False" Text="Show description in lightbox" />
												</div>
											</td>
										</tr>
										<tr id="trPortfolioProInlinePostion" runat="server" visible="false">
											<td>
												<dnn:Label ID="lblPortfolioProInlinePostion" runat="server" HelpText="Inline lightbox position." Text="Inline lightbox position." />
											</td>
											<td>
												<div class="styledSelect">
													<asp:DropDownList ID="ddlPortfolioProInlinePosition" runat="server">
														<asp:ListItem Value="0">above</asp:ListItem>
														<asp:ListItem Value="1">below</asp:ListItem>
														<asp:ListItem Value="2">top</asp:ListItem>
													</asp:DropDownList>
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblPortfolioProDetailTarget" runat="server" HelpText="Media Url target." Text="Media Url target:" />
											</td>
											<td>
												<div class="styledSelect">
													<asp:DropDownList ID="ddlPortfolioProDetailTarget" runat="server">
														<asp:ListItem ResourceKey="liself" Value="_self" Text="_self" />
														<asp:ListItem ResourceKey="liblank" Value="_blank" Text="_blank" />
														<asp:ListItem ResourceKey="liparent" Value="_parent" Text="_parent" />
														<asp:ListItem ResourceKey="Top" Value="_top" Text="_top" />
													</asp:DropDownList>
												</div>
											</td>
										</tr>
										<tr>
											<td colspan="2"></td>
										</tr>
										<tr class="color2HighLighted">
											<td colspan="2" class="textCenter">
												<asp:Label ID="lblPortfolioProSortingTitle" resourcekey="lblPortfolioProSortingTitle" runat="server" Text="Sorting options" />
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblPortfolioProSorting" runat="server" HelpText="Select media sorting options:" Text="Media sorting:" HelpKey="lblLightBoxMediaSorting.HelpText" ResourceKey="lblLightBoxMediaSorting" />
											</td>
											<td>
												<table class="clearWidth textLeft">
													<tr>
														<td>
															<div class="styledSelect">
																<asp:DropDownList ID="ddlPortfolioProSorting" runat="server">
																	<asp:ListItem resourcekey="liPosition" Value="Position">Position</asp:ListItem>
																	<asp:ListItem resourcekey="liDateUploaded" Value="DateUploaded">Date uploaded</asp:ListItem>
																	<asp:ListItem resourcekey="liFileName" Value="FileName">Filename</asp:ListItem>
																	<asp:ListItem resourcekey="liTitle">Title</asp:ListItem>
																</asp:DropDownList>
															</div>
														</td>
														<td>
															<div class="styledRadio small">
																<asp:RadioButtonList ID="rblPortfolioProSorting" runat="server" RepeatDirection="Horizontal">
																	<asp:ListItem resourcekey="liAscending" Selected="True" Value="ASC">Ascending</asp:ListItem>
																	<asp:ListItem resourcekey="liDescending" Value="DESC">Descending</asp:ListItem>
																</asp:RadioButtonList>
															</div>
														</td>
													</tr>
												</table>
											</td>
										</tr>
									</table>
									<asp:Label ID="lblPortfolioProSettingsStatus" runat="server" EnableViewState="False"></asp:Label>
									<div class="mainActions">
										<asp:LinkButton ID="btnSatvePortfolioProSettings" runat="server" OnClick="btnPortfolioPro_Click" Text="Save settings" ValidationGroup="vgPortfolioProSettings" CssClass="downSave" />
										<asp:LinkButton ID="btnPortfolioProSaveClose" runat="server" OnClick="btnPortfolioProSaveClose_Click" Text="Save &amp; Close" ValidationGroup="vgPortfolioProSettings" CssClass="downSaveClose" />
									</div>
								</div>
							</asp:Panel>
							<asp:Panel ID="pnlTableGallery" runat="server" Visible="False" CssClass="settingsList negativeMargins40">
								<h3>
									<asp:Label ID="lblLightboxGalleryDisplaySettings" runat="server" Text="Lightbox gallery display settings" resourcekey="lblLightboxGalleryDisplaySettingsResource1"></asp:Label>
									<asp:Label ID="lblLightboxCaptionSliderSettings" runat="server" resourcekey="lblLightboxCaptionSlider" Text="Lightbox caption slider display settings" Visible="False"></asp:Label>
								</h3>
								<div class="settingsTable">
									<table>
										<tr>
											<td>
												<dnn:Label ID="lblLightboxTemplateSelect" runat="server" ControlName="ddlSSThemeSelect" HelpKey="lblLightboxTemplateSelect.HelpText" HelpText="Select the control viewer template:" ResourceKey="lblLightboxTemplateSelect" Text="Select template:" />
											</td>
											<td>
												<div class="styledSelect">
													<asp:DropDownList ID="ddlLightboxTemplateSelect" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlLightboxTemplateSelect_SelectedIndexChanged"></asp:DropDownList>
												</div>
												<asp:Label ID="lblLightboxTemplateInfo" runat="server"></asp:Label>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblLightBoxGalleryThemeSelect" runat="server" ControlName="ddlTGThemeSelect" HelpKey="lblLightBoxGalleryThemeSelect.HelpText" HelpText="Select the CSS theme file:" ResourceKey="lblLightBoxGalleryThemeSelect" Text="Select CSS:" />
											</td>
											<td>
												<div class="styledSelect">
													<asp:DropDownList ID="ddlTGThemeSelect" runat="server"></asp:DropDownList>
												</div>
											</td>
										</tr>
										<tr runat="server" id="trLBResFixedSelect" class="highLighted">
											<td>
												<dnn:Label ID="lblLightboxSelectLayoutType" runat="server" HelpKey="lblChameleonSelectLayoutType.HelpText" HelpText="Select the layout type:" ResourceKey="lblChameleonSelectLayoutType" Text="Select the layout type:" />
											</td>
											<td>
												<asp:RadioButtonList ID="rblLightBoxLayoutTypeSelect" runat="server" RepeatDirection="Horizontal" CssClass="styledRadio">
													<asp:ListItem resourcekey="liResponsive" Selected="True" Value="responsive">Responsive Layout</asp:ListItem>
													<asp:ListItem resourcekey="liFixed" Value="fixed">Fixed Layout</asp:ListItem>
												</asp:RadioButtonList>
											</td>
										</tr>
										<tr id="trLBMediaTypeSelect" runat="server" visible="false">
											<td>
												<dnn:Label ID="lblLBMediaSelect" runat="server" HelpText="Select the media type to display:" Text="Select the media type to display:" ResourceKey="lblLBMediaSelect" HelpKey="lblLBMediaSelect.HelpText" />
											</td>
											<td>
												<div class="styledCheckbox">
													<asp:CheckBoxList ID="cblLBMediaSelect" runat="server" RepeatDirection="Horizontal" ValidationGroup="vgTGSettings">
														<asp:ListItem resourcekey="liImage" Selected="True" Value="Image">Image</asp:ListItem>
														<asp:ListItem resourcekey="liVideo" Selected="True" Value="Video">Video</asp:ListItem>
														<asp:ListItem resourcekey="liAudio" Selected="True" Value="Audio">Audio</asp:ListItem>
													</asp:CheckBoxList>
												</div>
												<asp:CustomValidator ID="cvEventsValidator" Display="Dynamic" ValidationGroup="vgTGSettings" runat="server" ClientValidationFunction="ValidateCheckBoxList" CssClass="smallInfo warning">Please select at least one media type.</asp:CustomValidator>
											</td>
										</tr>
										<tr class="color6HighLighted">
											<td colspan="2" class="noLeftRightPadding">
												<table>
													<tr>
														<td>
															<dnn:Label ID="lblLightboxGalleryDispplayNestedGalleries" runat="server" HelpKey="lblLightboxGalleryDispplayNestedGalleries.HelpText" HelpText="Display nested galleries:" ResourceKey="lblLightboxGalleryDispplayNestedGalleries" Text="Display nested galleries:" />
														</td>
														<td>
															<div class="styledCheckbox noLabel">
																<asp:CheckBox ID="cbLightboxGalleryDisplayNestedGalleries" runat="server" AutoPostBack="True" OnCheckedChanged="cbTGDisplayNestedGalleries_CheckedChanged" resourcekey="cbLightboxGalleryDisplayNestedGalleriesResource1" Text="Display nested galleries" />
															</div>
														</td>
													</tr>
												</table>
												<asp:Panel ID="pnlNestedGalleriesOptions" runat="server" Visible="False">
													<asp:Panel ID="pnlTGNGGallerySettings" runat="server" CssClass="settingsList">
														<table>
															<tr class="color1HighLighted">
																<td class="textCenter">
																	<asp:Label ID="lblLightboxGalleryNestedGallerySettings" runat="server" Text="Nested galleries settings" resourcekey="lblLightboxGalleryNestedGallerySettingsResource1"></asp:Label>
																</td>
															</tr>
															<tr>
																<td>
																	<table class="settingsTable">
																		<tr>
																			<td class="textTop">
																				<asp:Label ID="lblLightboxGalleryNestedGallerySelection" runat="server" Font-Bold="True" Text="Gallery selection:" resourcekey="lblLightboxGalleryNestedGallerySelectionResource1"></asp:Label>
																			</td>
																			<td>
																				<asp:CheckBoxList ID="cblLightboxGalleryNestedGallerySelection" runat="server" CellPadding="2" CellSpacing="5" DataSourceID="odsGallery" DataTextField="GalleryName" DataValueField="GalleryID" OnDataBound="cblTGNGGallerySelection_DataBound" OnSelectedIndexChanged="cblTGNGGallerySelection_SelectedIndexChanged" RepeatColumns="2" CssClass="nestedGalleryList styledCheckbox"></asp:CheckBoxList>
																				<asp:Label ID="lblLightboxGalleryNoNestedGalleryError" runat="server" Text="Please add an select some galleries." Visible="False" resourcekey="lblLightboxGalleryNoNestedGalleryErrorResource1" CssClass="infoMessages warning static"></asp:Label>
																			</td>
																		</tr>
																		<tr>
																			<td colspan="2"></td>
																		</tr>
																		<tr>
																			<td></td>
																			<td>
																				<div class="styledCheckbox">
																					<asp:CheckBox ID="cbLightboxGalleryNestedShowAllGalleries" runat="server" AutoPostBack="True" OnCheckedChanged="cbTGNGShowAllGalleries_CheckedChanged" Text="Show all galleries" resourcekey="cbLightboxGalleryNestedShowAllGalleriesResource1" />
																				</div>
																			</td>
																		</tr>
																		<tr>
																			<td></td>
																			<td>
																				<div class="styledCheckbox">
																					<asp:CheckBox ID="cbLightboxGalleryNestedShowGalleryName" runat="server" Text="Show gallery name" resourcekey="cbLightboxGalleryNestedShowGalleryNameResource1" />
																				</div>
																			</td>
																		</tr>
																		<tr>
																			<td></td>
																			<td>
																				<div class="styledCheckbox">
																					<asp:CheckBox ID="cbLightboxGalleryNestedShowGalleryDescription" runat="server" Text="Show gallery description" resourcekey="cbLightboxGalleryNestedShowGalleryDescriptionResource1" />
																					<div>
																			</td>
																		</tr>
																		<tr id="trShowGalleryOwner" runat="server" visible="False">
																			<td></td>
																			<td>
																				<div class="styledCheckbox">
																					<asp:CheckBox ID="cbLightboxGalleryNestedShowGalleryOwner" runat="server" Text="Show gallery owner" />
																				</div>
																			</td>
																		</tr>
																		<tr>
																			<td colspan="2"></td>
																		</tr>
																		<tr>
																			<td>
																				<asp:Label ID="lblLightboxGalleryNestedImageWidth" runat="server" Text="Nested gallery thumbnail width." resourcekey="lblLightboxGalleryNestedImageWidthResource1"></asp:Label>
																			</td>
																			<td>
																				<asp:TextBox ID="tbTGNGImageWidth" runat="server" CssClass="small textCenter">200</asp:TextBox>
																				<asp:RequiredFieldValidator ID="rfvLightboxGalleryNestedImageWidth" runat="server" ControlToValidate="tbTGNGImageWidth" Display="Dynamic" ErrorMessage="This field is required." SetFocusOnError="True" ValidationGroup="vgTGSettings" resourcekey="rfvLightboxGalleryNestedImageWidthResource1.ErrorMessage" CssClass="smallInfo error"></asp:RequiredFieldValidator>
																				<asp:CompareValidator ID="cvLightboxGalleryNestedImageWidth" runat="server" ControlToValidate="tbTGNGImageWidth" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" SetFocusOnError="True" Type="Integer" ValidationGroup="vgTGSettings" resourcekey="cvLightboxGalleryNestedImageWidthResource1.ErrorMessage" CssClass="smallInfo error"></asp:CompareValidator>
																			</td>
																		</tr>
																		<tr>
																			<td>
																				<asp:Label ID="lblLightboxGalleryImageHeight" runat="server" Text="Nested gallery thumbnail height." resourcekey="lblLightboxGalleryImageHeightResource1"></asp:Label>
																			</td>
																			<td>
																				<asp:TextBox ID="tbTGNGImageHeight" runat="server" CssClass="small textCenter">200</asp:TextBox>
																				<asp:RequiredFieldValidator ID="rfvLightboxGalleryNestedImageHeight" runat="server" ControlToValidate="tbTGNGImageHeight" Display="Dynamic" ErrorMessage="This field is required." SetFocusOnError="True" ValidationGroup="vgTGSettings" resourcekey="rfvLightboxGalleryNestedImageHeightResource1.ErrorMessage" CssClass="smallInfo error"></asp:RequiredFieldValidator>
																				<asp:CompareValidator ID="cvLightboxGalleryNestedImageHeight" runat="server" ControlToValidate="tbTGNGImageHeight" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" SetFocusOnError="True" Type="Integer" ValidationGroup="vgTGSettings" resourcekey="cvLightboxGalleryNestedImageHeightResource1.ErrorMessage" CssClass="smallInfo error"></asp:CompareValidator>
																			</td>
																		</tr>
																		<tr>
																			<td>
																				<asp:Label ID="lblLightboxGalleryNestedNumberOfColumns" runat="server" Text="Number of columns." resourcekey="lblLightboxGalleryNestedNumberOfColumnsResource1"></asp:Label>
																			</td>
																			<td>
																				<asp:TextBox ID="tbTGNGColumns" runat="server" ValidationGroup="vgTGSettings" CssClass="small textCenter">2</asp:TextBox>
																				<asp:RequiredFieldValidator ID="rfvLightboxGalleryNestedNumberOfColumns" runat="server" ControlToValidate="tbTGNGColumns" Display="Dynamic" ErrorMessage="This field is required." SetFocusOnError="True" ValidationGroup="vgTGSettings" resourcekey="rfvLightboxGalleryNestedNumberOfColumnsResource1.ErrorMessage" CssClass="smallInfo error"></asp:RequiredFieldValidator>
																				<asp:CompareValidator ID="cvLightboxGalleryNestedNumberOfColumns" runat="server" ControlToValidate="tbTGNGColumns" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" SetFocusOnError="True" Type="Integer" ValidationGroup="vgTGSettings" resourcekey="cvLightboxGalleryNestedNumberOfColumnsResource1.ErrorMessage" CssClass="smallInfo error"></asp:CompareValidator>
																			</td>
																		</tr>
																		<tr>
																			<td>
																				<asp:Label ID="lblLightboxGalleryNestedNumberOfItems" runat="server" resourcekey="lblLightboxGalleryNestedNumberOfItems" Text="Number of items."></asp:Label>
																			</td>
																			<td>
																				<asp:TextBox ID="tbTGNGItems" runat="server" ValidationGroup="vgTGSettings" CssClass="small textCenter">4</asp:TextBox>
																				<asp:RequiredFieldValidator ID="rfvLightboxGalleryNestedNumberOfColumns0" runat="server" ControlToValidate="tbTGNGItems" Display="Dynamic" ErrorMessage="This field is required." resourcekey="rfvLightboxGalleryNestedNumberOfColumnsResource1.ErrorMessage" SetFocusOnError="True" ValidationGroup="vgTGSettings" CssClass="smallInfo error"></asp:RequiredFieldValidator>
																				<asp:CompareValidator ID="cvLightboxGalleryNestedNumberOfColumns0" runat="server" ControlToValidate="tbTGNGItems" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" resourcekey="cvLightboxGalleryNestedNumberOfColumnsResource1.ErrorMessage" SetFocusOnError="True" Type="Integer" ValidationGroup="vgTGSettings" CssClass="smallInfo error"></asp:CompareValidator>
																			</td>
																		</tr>
																		<tr>
																			<td></td>
																			<td>
																				<div class="styledCheckbox">
																					<asp:CheckBox ID="cbLightboxGalleryNestedProportionalyResize" runat="server" AutoPostBack="True" OnCheckedChanged="cbTGNGGalResize_CheckedChanged" Text="Proportionally resize gallery thumbnails" resourcekey="cbLightboxGalleryNestedProportionalyResizeResource1" />
																				</div>
																			</td>
																		</tr>
																		<tr>
																			<td></td>
																			<td>
																				<div class="styledCheckbox">
																					<asp:CheckBox ID="cbLightboxGalleryNestedResizeCrop" runat="server" Text="Resize and crop gallery thumbnails" resourcekey="cbLightboxGalleryNestedResizeCropResource1" AutoPostBack="True" Checked="True" OnCheckedChanged="cbTGNGGalResizeCrop_CheckedChanged" />
																				</div>
																			</td>
																		</tr>
																		<tr>
																			<td></td>
																			<td>
																				<div class="styledCheckbox">
																					<asp:CheckBox ID="cbLightboxGalleryNestedShowBreadcrumbs" runat="server" Text="Show breadcrumbs" resourcekey="cbLightboxGalleryNestedShowBreadcrumbsResource1" />
																				</div>
																			</td>
																		</tr>
																		<tr>
																			<td></td>
																			<td>
																				<div class="styledCheckbox">
																					<asp:CheckBox ID="cbLightboxGalleryNestedShowGalleryInfo" runat="server" resourcekey="cbLightboxGalleryNestedShowGalleryInfoResource1" Text="Show gallery info" />
																				</div>
																			</td>
																		</tr>
																		<tr>
																			<td>
																				<dnn:Label ID="lblLightboxNestGalleryButtonPos" runat="server" HelpText="Back button position:" Text="Back button position:" HelpKey="lblLightboxNestGalleryButtonPos.HelpText" ResourceKey="lblLightboxNestGalleryButtonPos" />
																			</td>
																			<td>
																				<asp:RadioButtonList ID="rblLBNestedButtonPos" runat="server" RepeatDirection="Horizontal" CssClass="styledRadio small">
																					<asp:ListItem resourcekey="liTop">Top</asp:ListItem>
																					<asp:ListItem resourcekey="liBottom" Selected="True">Bottom</asp:ListItem>
																					<asp:ListItem resourcekey="liTopBottom" Value="Topandbottom">Top and bottom</asp:ListItem>
																				</asp:RadioButtonList>
																			</td>
																		</tr>
																		<tr>
																			<td>
																				<dnn:Label ID="lblLightboxNestGallerySorting" runat="server" HelpText="Nested galleries sorting:" Text="Nested galleries sorting:" HelpKey="lblChameleonGalleryNGSorting.HelpText" ResourceKey="lblChameleonGalleryNGSorting" />
																			</td>
																			<td>
																				<table>
																					<tr>
																						<td class="textLeft" style="width: auto;">
																							<div class="styledSelect">
																								<asp:DropDownList ID="ddlLBNestedSorting" runat="server">
																									<asp:ListItem resourcekey="liPosition" Value="Position">Position</asp:ListItem>
																									<asp:ListItem resourcekey="liTitle" Value="GalleryName">Title</asp:ListItem>
																									<asp:ListItem resourcekey="liDateCreated" Value="DateCreated">Date created</asp:ListItem>
																									<asp:ListItem resourcekey="liLAstModified" Value="DateLastModified">Date last modified</asp:ListItem>
																								</asp:DropDownList>
																							</div>
																						</td>
																						<td style="width: auto;">
																							<asp:RadioButtonList ID="rblLightboxNestedSortingAscDesc" runat="server" RepeatDirection="Horizontal" CssClass="styledRadio small">
																								<asp:ListItem resourcekey="liAscending" Selected="True" Value="ASC">Ascending</asp:ListItem>
																								<asp:ListItem resourcekey="liDescending" Value="DESC">Descending</asp:ListItem>
																							</asp:RadioButtonList>
																						</td>
																					</tr>
																				</table>
																			</td>
																		</tr>
																		<tr>
																			<td colspan="2"></td>
																		</tr>
																		<tr>
																			<td></td>
																			<td>
																				<div class="styledCheckbox">
																					<asp:CheckBox ID="cbLightboxGalleryNestedRegenerateThumbnails" runat="server" resourcekey="cbLightboxGalleryNestedRegeterateThumbnails" Text="Regenerate thumbnails" Font-Bold="True" />
																				</div>
																			</td>
																		</tr>
																	</table>
																</td>
															</tr>
														</table>
													</asp:Panel>
												</asp:Panel>
											</td>
										</tr>
										<tr>
											<td colspan="2"></td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblLightboxGalleryShowTitle" runat="server" HelpKey="lblLightboxGalleryShowTitle.HelpText" HelpText="Show gallery title:" ResourceKey="lblLightboxGalleryShowTitle" Text="Show gallery title:" />
											</td>
											<td>
												<div class="styledCheckbox nolabel">
													<asp:CheckBox ID="cbTGShowTitle" runat="server" resourcekey="cbTGShowTitleResource1" Text="Show gallery title" />
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblLightboxGalleryShowDescription" ResourceKey="lblLightboxGalleryShowDescription" runat="server" HelpText="Show gallery description:" Text="Show gallery description:" HelpKey="lblLightboxGalleryShowDescription.HelpText" />
											</td>
											<td>
												<div class="styledCheckbox nolabel">
													<asp:CheckBox ID="cbTGShowDescription" runat="server" resourcekey="cbTGShowDescriptionResource1" Text="Show gallery description" />
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblLightboxGalleryShowMediaTitle" ResourceKey="lblLightboxGalleryShowMediaTitle" runat="server" HelpText="Show media title:" Text="Show media title:" HelpKey="lblLightboxGalleryShowMediaTitle.HelpText" />
											</td>
											<td>
												<div class="styledCheckbox nolabel">
													<asp:CheckBox ID="cbLightboxGalleryShowMediaTitle" runat="server" resourcekey="cbLightboxGalleryShowMediaTitleResource1" Text="Show media title" />
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblLightboxGalleryShowMediaDescription" ResourceKey="lblLightboxGalleryShowMediaDescription" runat="server" HelpText="Show media description:" Text="Show media description:" HelpKey="lblLightboxGalleryShowMediaDescription.HelpText" />
											</td>
											<td>
												<div class="styledCheckbox nolabel">
													<asp:CheckBox ID="cbLightboxGalleryShowMediaDescription" runat="server" resourcekey="cbLightboxGalleryShowMediaDescriptionResource1" Text="Show media description" />
												</div>
											</td>
										</tr>
										<tr id="trLBShowLightboxTitle" runat="server">
											<td>
												<dnn:Label ID="lblLightboxGalleryShowLightboxTitle" ResourceKey="lblLightboxGalleryShowLightboxTitle" runat="server" HelpText="Show image title in lightbox:" Text="Show image title in lightbox:" HelpKey="lblLightboxGalleryShowLightboxTitle.HelpText" />
											</td>
											<td>
												<div class="styledCheckbox nolabel">
													<asp:CheckBox ID="cbLightboxGalleryShowLightboxTitle" runat="server" resourcekey="cbLightboxGalleryShowLightboxTitleResource1" Text="Show image title in lightbox" />
												</div>
											</td>
										</tr>
										<tr id="trLBShowLightboxDescription" runat="server">
											<td class="textTop">
												<dnn:Label ID="lblLightboxGalleryLightboxDescription" ResourceKey="lblLightboxGalleryLightboxDescription" runat="server" HelpText="Show media description in lightbox:" Text="Show media description in lightbox:" HelpKey="lblLightboxGalleryLightboxDescription.HelpText" />
											</td>
											<td>
												<div class="styledCheckbox nolabel">
													<asp:CheckBox ID="cbTGShowLightboxDescription" runat="server" resourcekey="cbTGShowLightboxDescriptionResource1" AutoPostBack="True" OnCheckedChanged="cbTGShowLightboxDescription_CheckedChanged" Text="Show media description in lightbox:" />
												</div>
												<asp:Panel ID="pnlLightboxToolTipOptions" runat="server" BackColor="#CBEEF8" BorderColor="#65CDEB" BorderStyle="Solid" BorderWidth="2px" Visible="False">
													<table>
														<tr>
															<td></td>
															<td>
																<asp:Label ID="lblLightBoxToolTipOptions" resourcekey="lblLightBoxToolTipOptions" runat="server" Text="Tooltip options" Font-Bold="True"></asp:Label>
															</td>
														</tr>
														<tr>
															<td>
																<asp:Label ID="lblLightboxShowTooltips" runat="server" resourcekey="lblLightboxShowToolTips" Text="Show Tooltips:"></asp:Label>
															</td>
															<td>
																<asp:CheckBox ID="cbShowToolTips" runat="server" Checked="True" />
															</td>
														</tr>
														<tr>
															<td>
																<asp:Label ID="lblLightboxTargetPosition" resourcekey="lblLightboxTargetPosition" runat="server" Text="Target position:"></asp:Label>
															</td>
															<td>
																<asp:DropDownList ID="ddlLightboxTargetPosition" runat="server">
																	<asp:ListItem resourcekey="topLeft" Value="topLeft">Top left</asp:ListItem>
																	<asp:ListItem resourcekey="topMiddle" Value="topMiddle" Selected="True">Top middle</asp:ListItem>
																	<asp:ListItem resourcekey="topRight" Value="topRight">Top right</asp:ListItem>
																	<asp:ListItem resourcekey="leftTop" Value="leftTop">Left top</asp:ListItem>
																	<asp:ListItem resourcekey="leftMiddle" Value="leftMiddle">Left middle</asp:ListItem>
																	<asp:ListItem resourcekey="leftBottom" Value="leftBottom">Left bottom</asp:ListItem>
																	<asp:ListItem resourcekey="center" Value="center">Center</asp:ListItem>
																	<asp:ListItem resourcekey="rightTop" Value="rightTop">Right top</asp:ListItem>
																	<asp:ListItem resourcekey="rightMiddle" Value="rightMiddle">Right middle</asp:ListItem>
																	<asp:ListItem resourcekey="rightBottom" Value="rightBottom">Right bottom</asp:ListItem>
																	<asp:ListItem resourcekey="bottomLeft" Value="bottomLeft">Bottom left</asp:ListItem>
																	<asp:ListItem resourcekey="bottomMiddle" Value="bottomMiddle">Bottom middle</asp:ListItem>
																	<asp:ListItem resourcekey="bottomRight" Value="bottomRight">Bottom right</asp:ListItem>
																</asp:DropDownList>
															</td>
														</tr>
														<tr>
															<td>
																<asp:Label ID="lblLightboxTooltipPosition" resourcekey="lblLightboxTooltipPosition" runat="server" Text="Tooltip position:"></asp:Label>
															</td>
															<td>
																<asp:DropDownList ID="ddlLightboxTooltipPosition" runat="server">
																	<asp:ListItem resourcekey="topLeft" Value="topLeft">Top left</asp:ListItem>
																	<asp:ListItem resourcekey="topMiddle" Value="topMiddle">Top middle</asp:ListItem>
																	<asp:ListItem resourcekey="topRight" Value="topRight">Top right</asp:ListItem>
																	<asp:ListItem resourcekey="leftTop" Value="leftTop">Left top</asp:ListItem>
																	<asp:ListItem resourcekey="leftMiddle" Value="leftMiddle">Left middle</asp:ListItem>
																	<asp:ListItem resourcekey="leftBottom" Value="leftBottom">Left bottom</asp:ListItem>
																	<asp:ListItem resourcekey="center" Value="center">Center</asp:ListItem>
																	<asp:ListItem resourcekey="rightTop" Value="rightTop">Right top</asp:ListItem>
																	<asp:ListItem resourcekey="rightMiddle" Value="rightMiddle">Right middle</asp:ListItem>
																	<asp:ListItem resourcekey="rightBottom" Value="rightBottom">Right bottom</asp:ListItem>
																	<asp:ListItem resourcekey="bottomLeft" Value="bottomLeft">Bottom left</asp:ListItem>
																	<asp:ListItem resourcekey="bottomMiddle" Selected="True" Value="bottomMiddle">Bottom middle</asp:ListItem>
																	<asp:ListItem resourcekey="bottomRight" Value="bottomRight">Bottom right</asp:ListItem>
																</asp:DropDownList>
															</td>
														</tr>
														<tr>
															<td>
																<asp:Label ID="lblLightboxShowEffect" resourcekey="lblLightboxShowEffect" runat="server" Text="Show effect:"></asp:Label>
															</td>
															<td>
																<asp:DropDownList ID="ddlLightboxShoweffect" runat="server">
																	<asp:ListItem resourcekey="fade" Value="fade">Fade</asp:ListItem>
																	<asp:ListItem resourcekey="slide" Value="slide">Slide</asp:ListItem>
																	<asp:ListItem resourcekey="grow" Value="grow">Grow</asp:ListItem>
																</asp:DropDownList>
															</td>
														</tr>
														<tr>
															<td>
																<asp:Label ID="lblLightboxShowEffectDuration" resourcekey="lblLightboxShowEffectDuration" runat="server" Text="Show effect duration (ms):"></asp:Label>
															</td>
															<td>
																<asp:TextBox ID="tbLightboxTooltipShowDuration" runat="server" Width="53px">500</asp:TextBox>
																<asp:RequiredFieldValidator ID="rfvLightBoxGalleryNumberOfColumns1" runat="server" ControlToValidate="tbLightboxTooltipShowDuration" Display="Dynamic" ErrorMessage="This field is required." resourcekey="rfvLightBoxGalleryNumberOfColumnsResource1.ErrorMessage"
																	SetFocusOnError="True" ValidationGroup="vgTGSettings">
																</asp:RequiredFieldValidator>
																<asp:CompareValidator ID="cvLightBoxGalleryNumberOfColumns1" runat="server" ControlToValidate="tbLightboxTooltipShowDuration" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" resourcekey="cvLightBoxGalleryNumberOfColumnsResource1.ErrorMessage"
																	SetFocusOnError="True" Type="Integer" ValidationGroup="vgTGSettings">
																</asp:CompareValidator>
															</td>
														</tr>
														<tr>
															<td>
																<asp:Label ID="lblLightboxShowHideEffect" resourcekey="lblLightboxShowHideEffect" runat="server" Text="Hide effect:"></asp:Label>
															</td>
															<td>
																<asp:DropDownList ID="ddlLightboxHideEffect" runat="server">
																	<asp:ListItem resourcekey="fade" Value="fade">Fade</asp:ListItem>
																	<asp:ListItem resourcekey="slide" Value="slide">Slide</asp:ListItem>
																	<asp:ListItem resourcekey="grow" Value="grow">Grow</asp:ListItem>
																</asp:DropDownList>
															</td>
														</tr>
														<tr>
															<td>
																<asp:Label ID="lblLightboxHideEffectDuration" resourcekey="lblLightboxHideEffectDuration" runat="server" Text="Hide effect duration (ms):"></asp:Label>
															</td>
															<td>
																<asp:TextBox ID="tbLightboxTooltipHideDuration" runat="server" Width="53px">500</asp:TextBox>
																<asp:RequiredFieldValidator ID="rfvLightBoxGalleryNumberOfColumns2" runat="server" ControlToValidate="tbLightboxTooltipHideDuration" Display="Dynamic" ErrorMessage="This field is required." resourcekey="rfvLightBoxGalleryNumberOfColumnsResource1.ErrorMessage"
																	SetFocusOnError="True" ValidationGroup="vgTGSettings">
																</asp:RequiredFieldValidator>
																<asp:CompareValidator ID="cvLightBoxGalleryNumberOfColumns2" runat="server" ControlToValidate="tbLightboxTooltipHideDuration" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" resourcekey="cvLightBoxGalleryNumberOfColumnsResource1.ErrorMessage"
																	SetFocusOnError="True" Type="Integer" ValidationGroup="vgTGSettings">
																</asp:CompareValidator>
															</td>
														</tr>
														<tr>
															<td>
																<asp:Label ID="lblLightboxTooltipBorder" resourcekey="lblLightboxTooltipBorder" runat="server" Text="Border:"></asp:Label>
															</td>
															<td>
																<asp:TextBox ID="tbLightboxTooltipBorder" runat="server" Width="53px">5</asp:TextBox>
																<asp:RequiredFieldValidator ID="rfvLightBoxGalleryNumberOfColumns3" runat="server" ControlToValidate="tbLightboxTooltipBorder" Display="Dynamic" ErrorMessage="This field is required." resourcekey="rfvLightBoxGalleryNumberOfColumnsResource1.ErrorMessage"
																	SetFocusOnError="True" ValidationGroup="vgTGSettings">
																</asp:RequiredFieldValidator>
																<asp:CompareValidator ID="cvLightBoxGalleryNumberOfColumns3" runat="server" ControlToValidate="tbLightboxTooltipBorder" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" resourcekey="cvLightBoxGalleryNumberOfColumnsResource1.ErrorMessage"
																	SetFocusOnError="True" Type="Integer" ValidationGroup="vgTGSettings">
																</asp:CompareValidator>
															</td>
														</tr>
														<tr>
															<td>
																<asp:Label ID="lblLightboxTooltipCornerRadius" runat="server" resourcekey="lblLightboxTooltipCornerRadius" Text="Corner radius:"></asp:Label>
															</td>
															<td>
																<asp:TextBox ID="tbLightboxTooltipCornerRadius" runat="server" Width="53px">5</asp:TextBox>
																<asp:RequiredFieldValidator ID="rfvLightBoxGalleryNumberOfColumns4" runat="server" ControlToValidate="tbLightboxTooltipCornerRadius" Display="Dynamic" ErrorMessage="This field is required." resourcekey="rfvLightBoxGalleryNumberOfColumnsResource1.ErrorMessage"
																	SetFocusOnError="True" ValidationGroup="vgTGSettings">
																</asp:RequiredFieldValidator>
																<asp:CompareValidator ID="cvLightBoxGalleryNumberOfColumns4" runat="server" ControlToValidate="tbLightboxTooltipCornerRadius" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" resourcekey="cvLightBoxGalleryNumberOfColumnsResource1.ErrorMessage"
																	SetFocusOnError="True" Type="Integer" ValidationGroup="vgTGSettings">
																</asp:CompareValidator>
															</td>
														</tr>
														<tr>
															<td>
																<asp:Label ID="lblLightboxTooltipTheme" runat="server" resourcekey="lblLightboxTooltipTheme" Text="Select theme:"></asp:Label>
															</td>
															<td>
																<asp:DropDownList ID="ddlLightboxTooltipTheme" runat="server">
																	<asp:ListItem resourcekey="cream" Value="cream">Yellow</asp:ListItem>
																	<asp:ListItem resourcekey="dark" Value="dark">Dark</asp:ListItem>
																	<asp:ListItem resourcekey="green" Value="green">Green</asp:ListItem>
																	<asp:ListItem resourcekey="light" Value="light">Light</asp:ListItem>
																	<asp:ListItem resourcekey="red" Value="red">Red</asp:ListItem>
																	<asp:ListItem resourcekey="blue" Value="blue">Blue</asp:ListItem>
																</asp:DropDownList>
															</td>
														</tr>
													</table>
												</asp:Panel>
											</td>
										</tr>
										<tr id="trLBShowLightboxThumbnails" runat="server">
											<td>
												<dnn:Label ID="lblLightboxGalleryLightboxThumbnails" ResourceKey="lblLightboxGalleryLightboxThumbnails" runat="server" HelpText="Show thumbnails inside lightbox:" Text="Show thumbnails inside lightbox:" HelpKey="lblLightboxGalleryLightboxThumbnails.HelpText" />
											</td>
											<td>
												<div class="styledCheckbox nolabel">
													<asp:CheckBox ID="cbLightboxGalleryLightboxThumbnails" runat="server" resourcekey="cbLightboxGalleryLightboxThumbnailsResource1" Text="Show thumbnails inside lightbox" />
													<div>
											</td>
										</tr>
										<tr id="trLBShowLightboxSlideshow" runat="server">
											<td>
												<dnn:Label ID="lblLightboxGalleryLightboxSlideShow" ResourceKey="lblLightboxGalleryLightboxSlideShow" runat="server" HelpText="Slide show inside lightbox:" Text="Slide show inside lightbox:" HelpKey="lblLightboxGalleryLightboxSlideShow.HelpText" />
											</td>
											<td>
												<div class="styledCheckbox nolabel">
													<asp:CheckBox ID="cbLightBoxSlideShow" runat="server" AutoPostBack="True" OnCheckedChanged="cbLightBoxSlideShow_CheckedChanged" resourcekey="cbLightBoxSlideShowResource1" />
												</div>
											</td>
										</tr>
										<tr id="trLBShowLightboxSlideshowPause" runat="server">
											<td>
												<dnn:Label ID="lblLightBoxGallerySlideShowPause" ResourceKey="lblLightBoxGallerySlideShowPause" runat="server" HelpText="Slide show inside lightbox interval in miliseconds:" Text="Slide show inside lightbox (ms):" HelpKey="lblLightBoxGallerySlideShowPause.HelpText" />
											</td>
											<td>
												<asp:TextBox ID="tbLightboxSSDuration" runat="server" CssClass="small textCenter" Enabled="False">5000</asp:TextBox>
												<asp:RequiredFieldValidator ID="rfvLightBoxGalleryNumberOfColumns9" runat="server" ControlToValidate="tbLightboxSSDuration" Display="Dynamic" ErrorMessage="This field is required." resourcekey="rfvLightBoxGalleryNumberOfColumnsResource1.ErrorMessage" ValidationGroup="vgTGSettings" CssClass="smallInfo error"></asp:RequiredFieldValidator>
												<asp:CompareValidator ID="cvLightBoxGalleryNumberOfColumns9" runat="server" ControlToValidate="tbLightboxSSDuration" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" resourcekey="cvLightBoxGalleryNumberOfColumnsResource1.ErrorMessage" Type="Integer" ValidationGroup="vgTGSettings" CssClass="smallInfo error"></asp:CompareValidator>
											</td>
										</tr>
										<tr id="trLBShowLightboxSlideshowAutoplay" runat="server">
											<td>
												<dnn:Label ID="lblLightBoxGallerySlideShowAutoPlay" ResourceKey="lblLightBoxGallerySlideShowAutoPlay" runat="server" HelpText="Slide show inside lightbox autoplay:" Text="Slide show inside lightbox autoplay:" HelpKey="lblLightBoxGallerySlideShowAutoPlay.HelpText" />
											</td>
											<td>
												<div class="styledCheckbox nolabel">
													<asp:CheckBox ID="cbTBLightBoxSSAP" runat="server" Enabled="False" resourcekey="cbTBLightBoxSSAPResource1" Text="Slide show inside lightbox autoplay" />
												</div>
											</td>
										</tr>
										<tr id="trLBShowLightboxAnimSpeed" runat="server">
											<td>
												<dnn:Label ID="lblLightBoxGalleryAnimationSpeed" ResourceKey="lblLightBoxGalleryAnimationSpeed" runat="server" HelpText="Lightbox animation speed:" Text="Lightbox animation speed:" HelpKey="lblLightBoxGalleryAnimationSpeed.HelpText" />
											</td>
											<td>
												<div class="styledSelect">
													<asp:DropDownList ID="ddlTGLightboxAnimationSpeed" runat="server">
														<asp:ListItem Value="fast" resourcekey="ListItemResource25">Fast</asp:ListItem>
														<asp:ListItem Value="normal" resourcekey="ListItemResource26">Normal</asp:ListItem>
														<asp:ListItem Value="slow" resourcekey="ListItemResource27">Slow</asp:ListItem>
													</asp:DropDownList>
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblLightBoxGalleryOpenMediaUrl" ResourceKey="lblLightBoxGalleryOpenMediaUrl" runat="server" HelpText="On image click dont open image in lightbox, but open Media Url link." Text="On click go to Media Url:" HelpKey="lblLightBoxGalleryOpenMediaUrl.HelpText" />
											</td>
											<td>
												<div class="styledCheckbox nolabel">
													<asp:CheckBox ID="cbLightBoxGalleryOpenMediaUrl" runat="server" AutoPostBack="True" OnCheckedChanged="cbTGOpenMediaUrl_CheckedChanged" resourcekey="cbLightBoxGalleryOpenMediaUrlResource1" Text="On click go to Media Url" />
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblLightBoxGalleryOpenMediaUrlNewWindow" ResourceKey="lblLightBoxGalleryOpenMediaUrlNewWindow" runat="server" HelpText="Open link in new window:" Text="Open link in new window:" HelpKey="lblLightBoxGalleryOpenMediaUrlNewWindow.HelpText" />
											</td>
											<td>
												<div class="styledCheckbox nolabel">
													<asp:CheckBox ID="cbLightBoxGalleryOpenMediaUrlNewWindow" runat="server" Enabled="False" resourcekey="cbLightBoxGalleryOpenMediaUrlNewWindowResource1" Text="Open link in new window" />
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblLightBoxGalleryNumberOfColumns" ResourceKey="lblLightBoxGalleryNumberOfColumns" runat="server" ControlName="tbTGNumberOfColumns" HelpText="Set the number of columns:" Text="Number of columns:" HelpKey="lblLightBoxGalleryNumberOfColumns.HelpText" />
											</td>
											<td>
												<asp:TextBox ID="tbTGNumberOfColumns" runat="server" ValidationGroup="vgTGSettings" CssClass="small textCenter">4</asp:TextBox>
												<asp:RequiredFieldValidator ID="rfvLightBoxGalleryNumberOfColumns" runat="server" ControlToValidate="tbTGNumberOfColumns" Display="Dynamic" ErrorMessage="This field is required." ValidationGroup="vgTGSettings" resourcekey="rfvLightBoxGalleryNumberOfColumnsResource1.ErrorMessage" CssClass="smallInfo error"></asp:RequiredFieldValidator>
												<asp:CompareValidator ID="cvLightBoxGalleryNumberOfColumns" runat="server" ControlToValidate="tbTGNumberOfColumns" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" Type="Integer" ValidationGroup="vgTGSettings" resourcekey="cvLightBoxGalleryNumberOfColumnsResource1.ErrorMessage" CssClass="smallInfo error"></asp:CompareValidator>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblLightBoxGalleryImageWidth" ResourceKey="lblLightBoxGalleryImageWidth" runat="server" Text="Maximum image width:" ControlName="tbTGImageWidth" HelpText="Set the maximum image width for resizing:" HelpKey="lblLightBoxGalleryImageWidth.HelpText"></dnn:Label>
											</td>
											<td>
												<asp:TextBox ID="tbTGImageWidth" runat="server" ValidationGroup="vgTGSettings" CssClass="small textCenter">150</asp:TextBox>
												<asp:RequiredFieldValidator ID="rfvLightBoxGalleryImageWidth" runat="server" ControlToValidate="tbTGImageWidth" ErrorMessage="This field is required." ValidationGroup="vgTGSettings" Display="Dynamic" resourcekey="rfvLightBoxGalleryImageWidthResource1.ErrorMessage" CssClass="smallInfo error"></asp:RequiredFieldValidator>
												<asp:CompareValidator ID="cvLightBoxGalleryImageWidth" runat="server" ControlToValidate="tbTGImageWidth" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" Type="Integer" ValidationGroup="vgTGSettings" resourcekey="cvLightBoxGalleryImageWidthResource1.ErrorMessage" CssClass="smallInfo error"></asp:CompareValidator>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblLightBoxGallerySetImageHeight" runat="server" Text="Maximum image height: " ControlName="tbTGImageHeight" HelpText="Set the maximum image height for resizing:" HelpKey="lblLightBoxGallerySetImageHeight.HelpText"></dnn:Label>
											</td>
											<td>
												<asp:TextBox ID="tbTGImageHeight" runat="server" ValidationGroup="vgTGSettings" CssClass="small textCenter">150</asp:TextBox>
												<asp:RequiredFieldValidator ID="rfvLightBoxGalleryImageHeight" runat="server" ControlToValidate="tbTGImageHeight" ErrorMessage="This field is required." ValidationGroup="vgTGSettings" Display="Dynamic" resourcekey="rfvLightBoxGalleryImageHeightResource1.ErrorMessage" CssClass="smallInfo error"></asp:RequiredFieldValidator>
												<asp:CompareValidator ID="cvLightBoxGalleryImageHeight" runat="server" ControlToValidate="tbTGImageHeight" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" Type="Integer" ValidationGroup="vgTGSettings" resourcekey="cvLightBoxGalleryImageHeightResource1.ErrorMessage" CssClass="smallInfo error"></asp:CompareValidator>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblLightBoxGalleryNumberOfItems" ResourceKey="lblLightBoxGalleryNumberOfItems" runat="server" Text="Number of items per page:" ControlName="tbTGItems" HelpText="Set the maximum number of items on one page:" HelpKey="lblLightBoxGalleryNumberOfItems.HelpText"></dnn:Label>
											</td>
											<td>
												<asp:TextBox ID="tbTGItems" runat="server" ValidationGroup="vgTGSettings" CssClass="small textCenter">5</asp:TextBox>
												<asp:RequiredFieldValidator ID="rfvLightBoxGalleryNumberOfItems" runat="server" ControlToValidate="tbTGItems" ErrorMessage="This field is required." ValidationGroup="vgTGSettings" Display="Dynamic" resourcekey="rfvLightBoxGalleryNumberOfItemsResource1.ErrorMessage" CssClass="smallInfo error"></asp:RequiredFieldValidator>
												<asp:CompareValidator ID="cvLightBoxGalleryNumberOfItems" runat="server" ControlToValidate="tbTGItems" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" Type="Integer" ValidationGroup="vgTGSettings" resourcekey="cvLightBoxGalleryNumberOfItemsResource1.ErrorMessage" CssClass="smallInfo error"></asp:CompareValidator>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblLightBoxGalleryCropImages" ResourceKey="lblLightBoxGalleryCropImages" runat="server" Text="Resize and crop vertical images:" ControlName="cbSmartCropVertical" HelpText="Set this to crop vertical images:" HelpKey="lblLightBoxGalleryCropImages.HelpText"></dnn:Label>
											</td>
											<td>
												<div class="styledCheckbox nolabel">
													<asp:CheckBox ID="cbLightBoxGallerySmartCropVertical" runat="server" OnCheckedChanged="cbSmartCropVertical_CheckedChanged" resourcekey="cbLightBoxGallerySmartCropVerticalResource1" Text="Resize and crop vertical images" />
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblLightBoxGalleryResizeCrop" ResourceKey="lblLightBoxGalleryResizeCrop" runat="server" Text="Resize and crop all images:" ControlName="cbTGSmartResizeAndCrop" HelpText="Set this this to resize all images to same width and height:" HelpKey="lblLightBoxGalleryResizeCrop.HelpText"></dnn:Label>
											</td>
											<td>
												<div class="styledCheckbox nolabel">
													<asp:CheckBox ID="cbLightBoxGalleryResizeAndCrop" runat="server" OnCheckedChanged="cbTGSmartResizeAndCrop_CheckedChanged" Checked="True" resourcekey="cbLightBoxGalleryResizeAndCropResource1" Text="Resize and crop all images" />
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblLightBoxRandomizeMedia" runat="server" HelpKey="lblLightBoxRandomizeMedia.HelpText" HelpText="Randomize media positions on every page load:" ResourceKey="lblLightBoxRandomizeMedia" Text="Randomize media positions:" />
											</td>
											<td>
												<div class="styledCheckbox nolabel">
													<asp:CheckBox ID="cbLightBoxRandomizeMedia" runat="server" OnCheckedChanged="cbLightBoxRandomizeMedia_CheckedChanged" resourcekey="cbLightBoxGallerySmartCropVerticalResource1" AutoPostBack="True" Text="Randomize media positions" />
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblLightBoxMediaSorting" runat="server" HelpText="Select media sorting options:" Text="Media sorting:" HelpKey="lblLightBoxMediaSorting.HelpText" ResourceKey="lblLightBoxMediaSorting" />
											</td>
											<td>
												<table class="clearWidth textLeft">
													<tr>
														<td>
															<div class="styledSelect">
																<asp:DropDownList ID="ddlLBMediaSorting" runat="server">
																	<asp:ListItem resourcekey="liPosition" Value="Position">Position</asp:ListItem>
																	<asp:ListItem resourcekey="liDateUploaded" Value="DateUploaded">Date uploaded</asp:ListItem>
																	<asp:ListItem resourcekey="liFileName" Value="FileName">Filename</asp:ListItem>
																	<asp:ListItem resourcekey="liTitle">Title</asp:ListItem>
																</asp:DropDownList>
															</div>
														</td>
														<td>
															<asp:RadioButtonList ID="rblLightboxSortingAscending" runat="server" RepeatDirection="Horizontal" CssClass="styledRadio small">
																<asp:ListItem resourcekey="liAscending" Selected="True" Value="ASC">Ascending</asp:ListItem>
																<asp:ListItem resourcekey="liDescending" Value="DESC">Descending</asp:ListItem>
															</asp:RadioButtonList>
														</td>
													</tr>
												</table>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblLightBoxAjaxPreloader" runat="server" HelpKey="lblLightBoxAjaxPreloader.HelpText" HelpText="Select Ajax preloader type:" ResourceKey="lblLightBoxAjaxPreloader" Text="Select Ajax preloader type:" />
											</td>
											<td>
												<asp:RadioButtonList ID="rblLighboxPreloaderType" runat="server" RepeatDirection="Horizontal" CssClass="styledRadio small">
													<asp:ListItem resourcekey="LighboxPreloaderFullscreen" Selected="True">Fullscreen</asp:ListItem>
													<asp:ListItem Value="Belowimages" resourcekey="LighboxPreloaderBellowImages">Below images</asp:ListItem>
												</asp:RadioButtonList>
											</td>
										</tr>
										<tr>
											<td class="textTop">
												<dnn:Label ID="lblLightBoxShowDownload" runat="server" HelpText="Show image download link:" Text="Show image download link:" HelpKey="lblLightBoxShowDownload.HelpText" ResourceKey="lblLightBoxShowDownload" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbLightBoxShowDownloadLink" runat="server" AutoPostBack="True" OnCheckedChanged="cbLightBoxShowDownloadLink_CheckedChanged" resourcekey="cbLightBoxGallerySmartCropVerticalResource1" Text="Show image download link" />
												</div>
												<asp:Panel ID="pnlLightboxDownloadOptions" runat="server" BackColor="#CBEEF8" BorderColor="#65CDEB" BorderStyle="Solid" BorderWidth="2px" Visible="False">
													<table class="clearWidth">
														<tr>
															<td class="textTop">
																<asp:Label ID="lblLighboxSelectDownloadRoles" resourcekey="lblLighboxSelectDownloadRoles" runat="server" Text="Select download roles:"></asp:Label>
															</td>
															<td>
																<asp:GridView ID="gvLightboxDownloadRoles" runat="server" CssClass="clearWidth" AutoGenerateColumns="False" CellPadding="4" ForeColor="#333333" GridLines="None" OnRowDataBound="gvLightboxDownloadRoles_RowDataBound" BorderColor="#65CDEB" BorderStyle="Solid" BorderWidth="1px">
																	<RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
																	<Columns>
																		<asp:TemplateField HeaderText="Role">
																			<ItemTemplate>
																				<asp:Label ID="lblRoleName0" runat="server" Text='<%# Bind("Role") %>'></asp:Label>
																			</ItemTemplate>
																			<ItemStyle CssClass="textLeft" />
																		</asp:TemplateField>
																		<asp:TemplateField HeaderText="Enable download">
																			<ItemTemplate>
																				<asp:CheckBox ID="cbLBEnableDownload" runat="server" Checked='<%# Bind("EnableDownload") %>' />
																			</ItemTemplate>
																			<ItemStyle CssClass="textCenter" />
																		</asp:TemplateField>
																	</Columns>
																	<FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
																	<PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
																	<SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
																	<HeaderStyle BackColor="#0BA2CE" Font-Bold="True" ForeColor="#FFFFFF" CssClass="textCenter" />
																	<EditRowStyle BackColor="#999999" />
																	<AlternatingRowStyle BackColor="White" ForeColor="#284775" />
																</asp:GridView>
															</td>
														</tr>
														<tr>
															<td colspan="2">
																<div class="styledCheckbox displayInline">
																	<asp:CheckBox ID="cbLightboxUseViewAsDownload" resourcekey="lblUseViewVersionAsDownload" runat="server" Text="Use view version as download version if there is no download verison" />
																</div>
															</td>
														</tr>
													</table>
												</asp:Panel>
											</td>
										</tr>
										<tr>
											<td class="textTop">
												<dnn:Label ID="lblLightBoxEnableFullscreen" runat="server" HelpText="Enable fullscreen:" Text="Enable fullscreen:" HelpKey="lblLightBoxEnableFullscreen.HelpText" ResourceKey="lblLightBoxEnableFullscreen" CssClass="styleBolded" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbLightboxEnableFullscreen" runat="server" AutoPostBack="True" OnCheckedChanged="cbLightboxEnableFullscreen_CheckedChanged" Text="Enable fullscreen" />
												</div>
												<asp:Panel ID="pnlLightboxFullscreenOptions" runat="server" BackColor="#CBEEF8" BorderColor="#65CDEB" BorderStyle="Solid" BorderWidth="2px" Visible="False">
													<table class="clearWidth">
														<tr>
															<td>
																<dnn:Label ID="lblLightboxFullscreenThemeSelect" runat="server" HelpText="Select fullscreen theme:" Text="Select fullscreen theme:" HelpKey="lblLightboxFullscreenThemeSelect.HelpText" ResourceKey="lblLightboxFullscreenThemeSelect" />
															</td>
															<td>
																<asp:DropDownList ID="ddlTGFullscreenThemeSelect" runat="server"></asp:DropDownList>
															</td>
														</tr>
														<tr>
															<td>
																<dnn:Label ID="lblLightboxFullscreenNavbar" runat="server" HelpText="Show navigation:" Text="Show navigation:" HelpKey="lblLightboxFullscreenNavbar.HelpText" ResourceKey="lblLightboxFullscreenNavbar" />
															</td>
															<td>
																<asp:CheckBox ID="cbLightBoxShowNavigationBar" runat="server" Checked="True" />
															</td>
														</tr>
														<tr>
															<td>
																<dnn:Label ID="lblLightboxFullscreenMenuType" runat="server" HelpText="Select navigation menu type:" Text="Navigation menu type:" HelpKey="lblLightboxFullscreenMenuType.HelpText" ResourceKey="lblLightboxFullscreenMenuType" />
															</td>
															<td>
																<asp:DropDownList ID="ddlLightboxFullscreenMenuStyle" runat="server" AutoPostBack="True">
																	<asp:ListItem resourcekey="liNavBar" Value="classic">Navigation bar</asp:ListItem>
																	<asp:ListItem resourcekey="liDropDownList" Value="dropdown">Dropdown list</asp:ListItem>
																</asp:DropDownList>
															</td>
														</tr>
														<tr>
															<td>
																<dnn:Label ID="lblLightboxFullscreenDropDownImages" runat="server" HelpText="Dropdown menu style:" Text="Dropdown menu style:" HelpKey="lblLightboxFullscreenDropDownImages.HelpText" ResourceKey="lblLightboxFullscreenDropDownImages.Text" />
															</td>
															<td>
																<asp:DropDownList ID="ddlLightboxFullscreenDropDownStyle" runat="server"></asp:DropDownList>
															</td>
														</tr>
														<tr>
															<td>
																<dnn:Label ID="lblLightboxFullscreenShowArrows" runat="server" HelpText="Show navigation arrows:" Text="Show navigation arrows:" HelpKey="lblLightboxFullscreenShowArrows.HelpText" ResourceKey="lblLightboxFullscreenShowArrows" />
															</td>
															<td>
																<asp:CheckBox ID="cbLightboxFullscreenShowArrows" runat="server" AutoPostBack="True" />
															</td>
														</tr>
														<tr>
															<td>
																<dnn:Label ID="lblLightboxFullscreenAutoHideNavigationArrows" runat="server" HelpText="Auto hide navigation arrows on mouse out:" Text="Auto hide navigation arrows:" HelpKey="lblLightboxFullscreenAutoHideNavigationArrows.HelpText" ResourceKey="lblLightboxFullscreenAutoHideNavigationArrows.Text" />
															</td>
															<td>
																<asp:CheckBox ID="cbLightboxFullscreenAutoHideArrows" runat="server" />
															</td>
														</tr>
														<tr>
															<td>
																<dnn:Label ID="lblLightboxFullscreenArrows" runat="server" HelpText="Navigation arrows:" Text="Navigation arrows:" HelpKey="lblLightboxFullscreenArrows.HelpText" ResourceKey="lblLightboxFullscreenArrows.Text" />
															</td>
															<td>
																<asp:DropDownList ID="ddlLightboxFullscreenArrows" runat="server"></asp:DropDownList>
															</td>
														</tr>
														<tr>
															<td>
																<dnn:Label ID="lblLightboxFullscreenGalleryTitle" runat="server" HelpText="Please enter title to display:" Text="Title to display:" HelpKey="lblLightboxFullscreenGalleryTitle.HelpText" ResourceKey="lblLightboxFullscreenGalleryTitle.Text" />
															</td>
															<td>
																<asp:TextBox ID="tbLightboxFullscreenTitle" runat="server"></asp:TextBox>
															</td>
														</tr>
													</table>
												</asp:Panel>
											</td>
										</tr>
										<tr>
											<td class="textTop">
												<dnn:Label ID="lblLightBoxShowSocialSharingButtons" runat="server" CssClass="styleBolded" HelpText="Show social sharing buttons inside thumbnail:" Text="Show sharing buttons:" HelpKey="lblLightBoxShowSocialSharingButtons.HelpText" ResourceKey="lblLightBoxShowSocialSharingButtons" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbLighboxShowSharingButtons" runat="server" AutoPostBack="True" OnCheckedChanged="cbLighboxShowSharingButtons_CheckedChanged" Text="Show sharing buttons:" />
												</div>
												<asp:Panel ID="pnlLightboxSharingButtonsOptions" runat="server" BackColor="#CBEEF8" BorderColor="#65CDEB" BorderStyle="Solid" BorderWidth="2px" Visible="False">
													<table>
														<tr>
															<td>
																<dnn:Label ID="lblLightboxSharingButtonFacebook" runat="server" HelpText="Show Facebook button:" Text="Show Facebook button:" HelpKey="lblLightboxSharingButtonFacebook.HelpText" ResourceKey="lblLightboxSharingButtonFacebook" />
															</td>
															<td>
																<asp:CheckBox ID="cbLightboxSharingButtonFacebook" runat="server" />
															</td>
														</tr>
														<tr>
															<td>
																<dnn:Label ID="lblLightboxSharingButtonGooglePlus" runat="server" HelpText="Show Googple Plus button:" Text="Show Googple Plus button:" HelpKey="lblLightboxSharingButtonGooglePlus.HelpText" ResourceKey="lblLightboxSharingButtonGooglePlus" />
															</td>
															<td>
																<asp:CheckBox ID="cbLightboxSharingButtonGooglePlus" runat="server" />
															</td>
														</tr>
														<tr>
															<td>
																<dnn:Label ID="lblLightboxSharingButtonTwitter" runat="server" HelpText="Show Twitter button:" Text="Show Twitter button:" HelpKey="lblLightboxSharingButtonTwitter.HelpText" ResourceKey="lblLightboxSharingButtonTwitter" />
															</td>
															<td>
																<asp:CheckBox ID="cbLightboxSharingButtonTwitter" runat="server" />
															</td>
														</tr>
														<tr>
															<td>
																<dnn:Label ID="lblLightboxSharingButtonPinterest" runat="server" HelpText="Show Pinterest button." Text="Show Pinterest  button:" HelpKey="lblLightboxSharingButtonPinterest.HelpText" ResourceKey="lblLightboxSharingButtonPinterest" />
															</td>
															<td>
																<asp:CheckBox ID="cbLightboxSharingButtonPinterest" runat="server" />
															</td>
														</tr>
													</table>
												</asp:Panel>
											</td>
										</tr>
										<tr>
											<td colspan="2"></td>
										</tr>
										<tr class="color2HighLighted">
											<td colspan="2" class="textCenter">
												<asp:Label ID="lblLightBoxGalleryViseoPlayerSettings" runat="server" Text="Video player in lightbox settings:" resourcekey="lblLightBoxGalleryViseoPlayerSettingsResource1"></asp:Label>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblLightBoxGalleryVideoPlayerSelect" runat="server" HelpKey="SelectVideoPlayer.HelpText" Text="Select player:" HelpText="Select player:" ResourceKey="SelectVideoPlayer.Text" />
											</td>
											<td>
												<div class="styledSelect">
													<asp:DropDownList ID="ddlTGVPSelectPlayer" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlTGVPSelectPlayer_SelectedIndexChanged">
														<asp:ListItem Selected="True" Value="False">Standard</asp:ListItem>
														<asp:ListItem Value="True">Flow player</asp:ListItem>
													</asp:DropDownList>
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblLightBoxGalleryVideoPlayerSelectSkin" ResourceKey="lblLightBoxGalleryVideoPlayerSelectSkin" runat="server" HelpText="Select video player skin:" Text="Select video player skin:" HelpKey="lblLightBoxGalleryVideoPlayerSelectSkin.HelpText" />
											</td>
											<td>
												<div class="styledSelect">
													<asp:DropDownList ID="ddlTGVPSelectTheme" runat="server">
														<asp:ListItem resourcekey="ListItemResource28" Selected="True" Value="black">Black</asp:ListItem>
														<asp:ListItem resourcekey="ListItemResource29" Value="white">White</asp:ListItem>
													</asp:DropDownList>
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblLightBoxGalleryVideoPlayerPlayOnLoad" ResourceKey="lblLightBoxGalleryVideoPlayerPlayOnLoad" runat="server" HelpText="Start to play video on page load:" Text="Play on load:" HelpKey="lblLightBoxGalleryVideoPlayerPlayOnLoad.HelpText" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbTGVPPlayOnLoad" runat="server" resourcekey="cbTGVPPlayOnLoadResource1" Text="Play on load" />
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblLightBoxGalleryViseoPlayerPlayOnLoad" ResourceKey="lblLightBoxGalleryViseoPlayerPlayOnLoad" runat="server" HelpText="Show description inside video player:" Text="Show description:" HelpKey="lblLightBoxGalleryViseoPlayerPlayOnLoad.HelpText" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbTGVPShowDescription" runat="server" resourcekey="cbTGVPShowDescriptionResource1" Text="Show description" />
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblTGVPAllowFullscreen" ResourceKey="lblTGVPAllowFullscreen" runat="server" HelpText="Allow video to be played in fullscreen:" Text="Allow fullscreen:" HelpKey="lblTGVPAllowFullscreen.HelpText" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbTGVPAllowFullscreen" runat="server" resourcekey="cbTGVPAllowFullscreenResource1" Text="Show description" />
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblLightBoxGalleryVideoPlayerPlayQTInFlash" runat="server" HelpKey="lblLightBoxGalleryVideoPlayerPlayQTInFlash.HelpText" Text="Play QuickTime videos in flash player:" HelpText="Play QuickTime videos in flash player:" ResourceKey="lblLightBoxGalleryVideoPlayerPlayQTInFlash" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbTGVPPlayQTinFlash" runat="server" resourcekey="cbTGVPPlayQTinFlashResource1" Text="Play QuickTime videos in flash player" />
												</div>
											</td>
										</tr>
										<tr class="color2HighLighted">
											<td colspan="2" class="textCenter">
												<asp:Label ID="lblLightBoxGalleryAudioPlayerSettings" runat="server" resourcekey="lblLightBoxGalleryAudioPlayerSettingsResource1" Text="Audio player in lightbox settings:"></asp:Label>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblLightBoxGalleryAudioPlayerPlayOnLoad" runat="server" HelpKey="lblLightBoxGalleryAudioPlayerPlayOnLoad.HelpText" HelpText="Start to play audio on page load:" ResourceKey="lblLightBoxGalleryAudioPlayerPlayOnLoad" Text="Play on load:" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbTGAPPlayOnLoad" runat="server" resourcekey="cbTGAPPlayOnLoadResource1" Text="Play on load" />
												</div>
											</td>
										</tr>
									</table>
									<asp:Label ID="lblLightBoxGalleryStatus" runat="server" EnableViewState="False"></asp:Label>
									<div class="mainActions">
										<asp:LinkButton ID="btnLightBoxGallerySave" runat="server" OnClick="btnTableGallerySave_Click" resourcekey="btnLightBoxGallerySaveResource1" Text="Save settings" ValidationGroup="vgTGSettings" CssClass="downSave" />
										<asp:LinkButton ID="btnASSGallerySaveClose" runat="server" OnClick="btnTGSaveClose_Click" resourcekey="btnLightBoxGallerySaveCloseResource1" Text="Save &amp; Close" ValidationGroup="vgTGSettings" CssClass="downSaveClose" />
									</div>
								</div>
							</asp:Panel>
							<asp:Panel ID="pnlPortfolioGalery" runat="server" Visible="False" CssClass="settingsList negativeMargins40">
								<h3>
									<asp:Label ID="lblPortfolioGalleryDisplaySettings" resourcekey="lblPortfolioGalleryDisplaySettings" runat="server" Text="Lightbox portfolio gallery display settings"></asp:Label>
								</h3>
								<div class="settingsTable">
									<table>
										<tr>
											<td>
												<dnn:Label ID="lblLightboxTemplateSelect0" runat="server" ControlName="ddlSSThemeSelect" HelpKey="lblLightboxTemplateSelect.HelpText" HelpText="Select the control viewer template:" ResourceKey="lblLightboxTemplateSelect" Text="Select template:" />
											</td>
											<td>
												<div class="styledSelect">
													<asp:DropDownList ID="ddlPortfolioTemplateSelect" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlPortfolioTemplateSelect_SelectedIndexChanged"></asp:DropDownList>
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblLightBoxGalleryThemeSelect0" runat="server" ControlName="ddlTGThemeSelect" HelpKey="lblLightBoxGalleryThemeSelect.HelpText" HelpText="Select the CSS theme file:" ResourceKey="lblLightBoxGalleryThemeSelect" Text="Select CSS:" />
											</td>
											<td>
												<div class="styledSelect">
													<asp:DropDownList ID="ddlPortThemeSelect" runat="server"></asp:DropDownList>
												</div>
												<asp:Label ID="lblPortfolioTemplateInfo" runat="server"></asp:Label>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblPortfolioResponsive" runat="server" HelpText="Select the layout type:" Text="Select the layout type:" HelpKey="lblChameleonSelectLayoutType.HelpText" ResourceKey="lblChameleonSelectLayoutType" />
											</td>
											<td>
												<asp:RadioButtonList ID="rblPortfolioResponsive" runat="server" RepeatDirection="Horizontal" AutoPostBack="True" OnSelectedIndexChanged="rblPortfolioResponsive_SelectedIndexChanged" CssClass="styledRadio">
													<asp:ListItem resourcekey="liResponsive" Value="responsive">Responsive Layout</asp:ListItem>
													<asp:ListItem resourcekey="liFixed" Selected="True" Value="fixed">Fixed Layout</asp:ListItem>
												</asp:RadioButtonList>
											</td>
										</tr>
										<tr class="color6HighLighted">
											<td colspan="2" class="noLeftRightPadding">
												<table>
													<tr>
														<td>
															<dnn:Label ID="lblLightboxGalleryDispplayNestedGalleries0" runat="server" HelpKey="lblLightboxGalleryDispplayNestedGalleries.HelpText" HelpText="Display nested galleries:" ResourceKey="lblLightboxGalleryDispplayNestedGalleries" Text="Display nested galleries:" />
														</td>
														<td>
															<div class="styledCheckbox noLabel">
																<asp:CheckBox ID="cbPortfolioGalleryDisplayNestedGalleries" runat="server" AutoPostBack="True" OnCheckedChanged="cbPortfolioGalleryDisplayNestedGalleries_CheckedChanged" resourcekey="cbLightboxGalleryDisplayNestedGalleriesResource1" Text="Display nested galleries" />
															</div>
														</td>
													</tr>
												</table>
												<asp:Panel ID="pnlPortfolioNestedGalleriesOptions" runat="server" Visible="False">
													<asp:Panel ID="pnlPortfolioGallerySettings" runat="server">
														<table>
															<tr class="color1HighLighted">
																<td class="textCenter">
																	<asp:Label ID="lblLightboxGalleryNestedGallerySettings0" runat="server" Text="Nested galleries settings" resourcekey="lblLightboxGalleryNestedGallerySettingsResource1"></asp:Label>
																</td>
															</tr>
															<tr>
																<td>
																	<table class="settingsTable">
																		<tr>
																			<td>
																				<asp:Label ID="lblPortfolioGalleryNestedGallerySelection" runat="server" Font-Bold="True" Text="Gallery selection:" resourcekey="lblLightboxGalleryNestedGallerySelectionResource1"></asp:Label>
																			</td>
																			<td>
																				<asp:CheckBoxList ID="cblPortfolioGalleryNestedGallerySelection" runat="server" CellPadding="2" CellSpacing="5" DataSourceID="odsGallery" DataTextField="GalleryName" DataValueField="GalleryID" OnDataBound="cblPortfolioGalleryNestedGallerySelection_DataBound" OnSelectedIndexChanged="cblPortfolioGalleryNestedGallerySelection_SelectedIndexChanged" RepeatColumns="2" CssClass="nestedGalleryList styledCheckbox"></asp:CheckBoxList>
																				<asp:Label ID="lblPortfolioGalleryNoNestedGalleryError" runat="server" ForeColor="Red" Text="Please add an select some galleries." Visible="False" resourcekey="lblLightboxGalleryNoNestedGalleryErrorResource1" CssClass="infoMessages warning static"></asp:Label>
																			</td>
																		</tr>
																		<tr>
																			<td></td>
																			<td>
																				<asp:CheckBox ID="cbPortfolioShowAllButton" runat="server" Text="Show all button" Checked="True" />
																			</td>
																		</tr>
																		<tr>
																			<td></td>
																			<td>
																				<asp:CheckBox ID="cbPortfolioGalleryNestedShowAllGalleries" runat="server" AutoPostBack="True" OnCheckedChanged="cbPortfolioGalleryNestedShowAllGalleries_CheckedChanged" resourcekey="cbLightboxGalleryNestedShowAllGalleriesResource1" Text="Show all galleries" />
																			</td>
																		</tr>
																		<tr>
																			<td></td>
																			<td>
																				<table align="center" border="0" cellpadding="2" cellspacing="2" width="80%" style="display: none">
																					<tr>
																						<td>
																							<asp:CheckBox ID="cbPortfolioGalleryNestedShowGalleryDescription" runat="server" resourcekey="cbLightboxGalleryNestedShowGalleryDescriptionResource1" Text="Show gallery description" />
																						</td>
																					</tr>
																					<tr>
																						<td>
																							<asp:TextBox ID="tbPortfolioImageWidth" runat="server" Width="35px">200</asp:TextBox>
																							&nbsp;<asp:Label ID="lblLightboxGalleryNestedImageWidth0" runat="server" resourcekey="lblLightboxGalleryNestedImageWidthResource1" Text="Nested gallery thumbnail width."></asp:Label>
																							&nbsp;<asp:RequiredFieldValidator ID="rfvLightboxGalleryNestedImageWidth0" runat="server" ControlToValidate="tbPortfolioImageWidth" Display="Dynamic" ErrorMessage="This field is required." resourcekey="rfvLightboxGalleryNestedImageWidthResource1.ErrorMessage"
																								SetFocusOnError="True" ValidationGroup="vgTGSettings"></asp:RequiredFieldValidator>
																							<asp:CompareValidator ID="cvLightboxGalleryNestedImageWidth0" runat="server" ControlToValidate="tbPortfolioImageWidth" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" resourcekey="cvLightboxGalleryNestedImageWidthResource1.ErrorMessage"
																								SetFocusOnError="True" Type="Integer" ValidationGroup="vgTGSettings">
																							</asp:CompareValidator>
																						</td>
																					</tr>
																					<tr>
																						<td>
																							<asp:TextBox ID="tbPortfolioImageHeight" runat="server" Width="35px">200</asp:TextBox>
																							&nbsp;<asp:Label ID="lblLightboxGalleryImageHeight0" runat="server" resourcekey="lblLightboxGalleryImageHeightResource1" Text="Nested gallery thumbnail height."></asp:Label>
																							&nbsp;<asp:RequiredFieldValidator ID="rfvLightboxGalleryNestedImageHeight0" runat="server" ControlToValidate="tbPortfolioImageHeight" Display="Dynamic" ErrorMessage="This field is required." resourcekey="rfvLightboxGalleryNestedImageHeightResource1.ErrorMessage"
																								SetFocusOnError="True" ValidationGroup="vgTGSettings"></asp:RequiredFieldValidator>
																							<asp:CompareValidator ID="cvLightboxGalleryNestedImageHeight0" runat="server" ControlToValidate="tbPortfolioImageHeight" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" resourcekey="cvLightboxGalleryNestedImageHeightResource1.ErrorMessage"
																								SetFocusOnError="True" Type="Integer" ValidationGroup="vgTGSettings">
																							</asp:CompareValidator>
																						</td>
																					</tr>
																					<tr>
																						<td>
																							<asp:TextBox ID="tbPortfolioColumns" runat="server" ValidationGroup="vgTGSettings" Width="35px">2</asp:TextBox>
																							&nbsp;<asp:Label ID="lblLightboxGalleryNestedNumberOfColumns0" runat="server" resourcekey="lblLightboxGalleryNestedNumberOfColumnsResource1" Text="Number of columns."></asp:Label>
																							&nbsp;<asp:RequiredFieldValidator ID="rfvLightboxGalleryNestedNumberOfColumns1" runat="server" ControlToValidate="tbPortfolioColumns" Display="Dynamic" ErrorMessage="This field is required." resourcekey="rfvLightboxGalleryNestedNumberOfColumnsResource1.ErrorMessage"
																								SetFocusOnError="True" ValidationGroup="vgTGSettings"></asp:RequiredFieldValidator>
																							<asp:CompareValidator ID="cvLightboxGalleryNestedNumberOfColumns1" runat="server" ControlToValidate="tbPortfolioColumns" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" resourcekey="cvLightboxGalleryNestedNumberOfColumnsResource1.ErrorMessage"
																								SetFocusOnError="True" Type="Integer" ValidationGroup="vgTGSettings">
																							</asp:CompareValidator>
																						</td>
																					</tr>
																					<tr>
																						<td>
																							<asp:TextBox ID="tbPortfolioItems" runat="server" ValidationGroup="vgTGSettings" Width="35px">4</asp:TextBox>
																							<asp:Label ID="lblLightboxGalleryNestedNumberOfItems0" runat="server" resourcekey="lblLightboxGalleryNestedNumberOfItems" Text="Number of items."></asp:Label>
																							<asp:RequiredFieldValidator ID="rfvLightboxGalleryNestedNumberOfColumns2" runat="server" ControlToValidate="tbPortfolioItems" Display="Dynamic" ErrorMessage="This field is required." resourcekey="rfvLightboxGalleryNestedNumberOfColumnsResource1.ErrorMessage"
																								SetFocusOnError="True" ValidationGroup="vgTGSettings">
																							</asp:RequiredFieldValidator>
																							<asp:CompareValidator ID="cvLightboxGalleryNestedNumberOfColumns2" runat="server" ControlToValidate="tbPortfolioItems" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" resourcekey="cvLightboxGalleryNestedNumberOfColumnsResource1.ErrorMessage"
																								SetFocusOnError="True" Type="Integer" ValidationGroup="vgTGSettings">
																							</asp:CompareValidator>
																						</td>
																					</tr>
																					<tr>
																						<td>
																							<asp:CheckBox ID="cbPortfolioGalleryNestedProportionalyResize" runat="server" AutoPostBack="True" OnCheckedChanged="cbTGNGGalResize_CheckedChanged" resourcekey="cbLightboxGalleryNestedProportionalyResizeResource1" Text="Proportionally resize gallery thumbnails" />
																						</td>
																					</tr>
																					<tr>
																						<td>
																							<asp:CheckBox ID="cbPortfolioGalleryNestedResizeCrop" runat="server" AutoPostBack="True" Checked="True" OnCheckedChanged="cbTGNGGalResizeCrop_CheckedChanged" resourcekey="cbLightboxGalleryNestedResizeCropResource1" Text="Resize and crop gallery thumbnails" />
																						</td>
																					</tr>
																					<tr>
																						<td>
																							<asp:CheckBox ID="cbPortfolioGalleryNestedShowBreadcrumbs" runat="server" resourcekey="cbLightboxGalleryNestedShowBreadcrumbsResource1" Text="Show breadcrumbs" />
																						</td>
																					</tr>
																					<tr>
																						<td>
																							<asp:CheckBox ID="cbPortfolioGalleryNestedShowGalleryInfo" runat="server" resourcekey="cbLightboxGalleryNestedShowGalleryInfoResource1" Text="Show gallery info" />
																						</td>
																					</tr>
																				</table>
																			</td>
																		</tr>
																	</table>
																</td>
															</tr>
														</table>
													</asp:Panel>
												</asp:Panel>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblPortfolioGalleryShowMediaTitle" ResourceKey="lblLightboxGalleryShowMediaTitle" runat="server" HelpText="Show media title:" Text="Show media title:" HelpKey="lblLightboxGalleryShowMediaTitle.HelpText" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbPortfolioGalleryShowMediaTitle" runat="server" resourcekey="cbLightboxGalleryShowMediaTitleResource1" Text="Show media title" />
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblPortfolioGalleryShowMediaDescription" ResourceKey="lblLightboxGalleryShowMediaDescription" runat="server" HelpText="Show media description:" Text="Show media description:" HelpKey="lblLightboxGalleryShowMediaDescription.HelpText" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbPortfolioGalleryShowMediaDescription" runat="server" resourcekey="cbLightboxGalleryShowMediaDescriptionResource1" Text="Show media description" />
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblPortfolioGalleryShowLightboxTitle" ResourceKey="lblLightboxGalleryShowLightboxTitle" runat="server" HelpText="Show image title in lightbox:" Text="Show image title in lightbox:" HelpKey="lblLightboxGalleryShowLightboxTitle.HelpText" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbPortfolioGalleryShowLightboxTitle" runat="server" resourcekey="cbLightboxGalleryShowLightboxTitleResource1" Text="Show image title in lightbox" />
												</div>
											</td>
										</tr>
										<tr>
											<td class="textTop">
												<dnn:Label ID="lblPortfolioGalleryLightboxDescription" ResourceKey="lblLightboxGalleryLightboxDescription" runat="server" HelpText="Show media description in lightbox:" Text="Show media description in lightbox:" HelpKey="lblLightboxGalleryLightboxDescription.HelpText" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbPortfolioShowLightboxDescription" runat="server" resourcekey="cbTGShowLightboxDescriptionResource1" AutoPostBack="True" OnCheckedChanged="cbPortfolioShowLightboxDescription_CheckedChanged" Text="Show media description in lightbox" />
												</div>
												<asp:Panel ID="pnlPortfolioToolTipOptions" runat="server" BackColor="#CBEEF8" BorderColor="#65CDEB" BorderStyle="Solid" BorderWidth="2px" Visible="False">
													<table>
														<tr>
															<td colspan="2">
																<asp:Label ID="lblPortfolioToolTipOptions" runat="server" Font-Bold="True" resourcekey="lblLightBoxToolTipOptions" Text="Tooltip options"></asp:Label>
															</td>
														</tr>
														<tr>
															<td>
																<asp:Label ID="lblPortfolioShowTooltips" runat="server" resourcekey="lblLightboxShowToolTips" Text="Show Tooltips:"></asp:Label>
															</td>
															<td>
																<asp:CheckBox ID="cbPortfolioShowToolTips" runat="server" Checked="True" />
															</td>
														</tr>
														<tr>
															<td>
																<asp:Label ID="lblPortfolioTargetPosition" runat="server" resourcekey="lblLightboxTargetPosition" Text="Target position:"></asp:Label>
															</td>
															<td>
																<asp:DropDownList ID="ddlPortfolioTargetPosition" runat="server">
																	<asp:ListItem resourcekey="topLeft" Value="topLeft">Top left</asp:ListItem>
																	<asp:ListItem resourcekey="topMiddle" Value="topMiddle" Selected="True">Top middle</asp:ListItem>
																	<asp:ListItem resourcekey="topRight" Value="topRight">Top right</asp:ListItem>
																	<asp:ListItem resourcekey="leftTop" Value="leftTop">Left top</asp:ListItem>
																	<asp:ListItem resourcekey="leftMiddle" Value="leftMiddle">Left middle</asp:ListItem>
																	<asp:ListItem resourcekey="leftBottom" Value="leftBottom">Left bottom</asp:ListItem>
																	<asp:ListItem resourcekey="center" Value="center">Center</asp:ListItem>
																	<asp:ListItem resourcekey="rightTop" Value="rightTop">Right top</asp:ListItem>
																	<asp:ListItem resourcekey="rightMiddle" Value="rightMiddle">Right middle</asp:ListItem>
																	<asp:ListItem resourcekey="rightBottom" Value="rightBottom">Right bottom</asp:ListItem>
																	<asp:ListItem resourcekey="bottomLeft" Value="bottomLeft">Bottom left</asp:ListItem>
																	<asp:ListItem resourcekey="bottomMiddle" Value="bottomMiddle">Bottom middle</asp:ListItem>
																	<asp:ListItem resourcekey="bottomRight" Value="bottomRight">Bottom right</asp:ListItem>
																</asp:DropDownList>
															</td>
														</tr>
														<tr>
															<td>
																<asp:Label ID="lblPortfolioTooltipPosition" runat="server" resourcekey="lblLightboxTooltipPosition" Text="Tooltip position:"></asp:Label>
															</td>
															<td>
																<asp:DropDownList ID="ddlPortfolioTooltipPosition" runat="server">
																	<asp:ListItem resourcekey="topLeft" Value="topLeft">Top left</asp:ListItem>
																	<asp:ListItem resourcekey="topMiddle" Value="topMiddle">Top middle</asp:ListItem>
																	<asp:ListItem resourcekey="topRight" Value="topRight">Top right</asp:ListItem>
																	<asp:ListItem resourcekey="leftTop" Value="leftTop">Left top</asp:ListItem>
																	<asp:ListItem resourcekey="leftMiddle" Value="leftMiddle">Left middle</asp:ListItem>
																	<asp:ListItem resourcekey="leftBottom" Value="leftBottom">Left bottom</asp:ListItem>
																	<asp:ListItem resourcekey="center" Value="center">Center</asp:ListItem>
																	<asp:ListItem resourcekey="rightTop" Value="rightTop">Right top</asp:ListItem>
																	<asp:ListItem resourcekey="rightMiddle" Value="rightMiddle">Right middle</asp:ListItem>
																	<asp:ListItem resourcekey="rightBottom" Value="rightBottom">Right bottom</asp:ListItem>
																	<asp:ListItem resourcekey="bottomLeft" Value="bottomLeft">Bottom left</asp:ListItem>
																	<asp:ListItem resourcekey="bottomMiddle" Selected="True" Value="bottomMiddle">Bottom middle</asp:ListItem>
																	<asp:ListItem resourcekey="bottomRight" Value="bottomRight">Bottom right</asp:ListItem>
																</asp:DropDownList>
															</td>
														</tr>
														<tr>
															<td>
																<asp:Label ID="lblPortfolioShowEffect" runat="server" resourcekey="lblLightboxShowEffect" Text="Show effect:"></asp:Label>
															</td>
															<td>
																<asp:DropDownList ID="ddlPortfolioShoweffect" runat="server">
																	<asp:ListItem resourcekey="fade" Value="fade">Fade</asp:ListItem>
																	<asp:ListItem resourcekey="slide" Value="slide">Slide</asp:ListItem>
																	<asp:ListItem resourcekey="grow" Value="grow">Grow</asp:ListItem>
																</asp:DropDownList>
															</td>
														</tr>
														<tr>
															<td>
																<asp:Label ID="lblPortfolioShowEffectDuration" runat="server" resourcekey="lblLightboxShowEffectDuration" Text="Show effect duration (ms):"></asp:Label>
															</td>
															<td>
																<asp:TextBox ID="tbPortfolioTooltipShowDuration" runat="server" Width="53px">500</asp:TextBox>
																<asp:RequiredFieldValidator ID="rfvLightBoxGalleryNumberOfColumns5" runat="server" ControlToValidate="tbPortfolioTooltipShowDuration" Display="Dynamic" ErrorMessage="This field is required." resourcekey="rfvLightBoxGalleryNumberOfColumnsResource1.ErrorMessage"
																	SetFocusOnError="True" ValidationGroup="vgPortfolioSettings">
																</asp:RequiredFieldValidator>
																<asp:CompareValidator ID="cvLightBoxGalleryNumberOfColumns5" runat="server" ControlToValidate="tbPortfolioTooltipShowDuration" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" resourcekey="cvLightBoxGalleryNumberOfColumnsResource1.ErrorMessage"
																	SetFocusOnError="True" Type="Integer" ValidationGroup="vgPortfolioSettings">
																</asp:CompareValidator>
															</td>
														</tr>
														<tr>
															<td>
																<asp:Label ID="lblPortfolioShowHideEffect" runat="server" resourcekey="lblLightboxShowHideEffect" Text="Hide effect:"></asp:Label>
															</td>
															<td>
																<asp:DropDownList ID="ddlPortfolioHideEffect" runat="server">
																	<asp:ListItem resourcekey="fade" Value="fade">Fade</asp:ListItem>
																	<asp:ListItem resourcekey="slide" Value="slide">Slide</asp:ListItem>
																	<asp:ListItem resourcekey="grow" Value="grow">Grow</asp:ListItem>
																</asp:DropDownList>
															</td>
														</tr>
														<tr>
															<td>
																<asp:Label ID="lblPortfolioHideEffectDuration" runat="server" resourcekey="lblLightboxHideEffectDuration" Text="Hide effect duration (ms):"></asp:Label>
															</td>
															<td>
																<asp:TextBox ID="tbPortfolioTooltipHideDuration" runat="server" Width="53px">500</asp:TextBox>
																<asp:RequiredFieldValidator ID="rfvLightBoxGalleryNumberOfColumns6" runat="server" ControlToValidate="tbPortfolioTooltipHideDuration" Display="Dynamic" ErrorMessage="This field is required." resourcekey="rfvLightBoxGalleryNumberOfColumnsResource1.ErrorMessage"
																	SetFocusOnError="True" ValidationGroup="vgPortfolioSettings">
																</asp:RequiredFieldValidator>
																<asp:CompareValidator ID="cvLightBoxGalleryNumberOfColumns6" runat="server" ControlToValidate="tbLightboxTooltipHideDuration" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" resourcekey="cvLightBoxGalleryNumberOfColumnsResource1.ErrorMessage"
																	SetFocusOnError="True" Type="Integer" ValidationGroup="vgPortfolioSettings">
																</asp:CompareValidator>
															</td>
														</tr>
														<tr>
															<td>
																<asp:Label ID="lblPortfolioTooltipBorder" runat="server" resourcekey="lblLightboxTooltipBorder" Text="Border:"></asp:Label>
															</td>
															<td>
																<asp:TextBox ID="tbPortfolioTooltipBorder" runat="server" Width="53px">5</asp:TextBox>
																<asp:RequiredFieldValidator ID="rfvLightBoxGalleryNumberOfColumns7" runat="server" ControlToValidate="tbPortfolioTooltipBorder" Display="Dynamic" ErrorMessage="This field is required." resourcekey="rfvLightBoxGalleryNumberOfColumnsResource1.ErrorMessage"
																	SetFocusOnError="True" ValidationGroup="vgPortfolioSettings">
																</asp:RequiredFieldValidator>
																<asp:CompareValidator ID="cvLightBoxGalleryNumberOfColumns7" runat="server" ControlToValidate="tbPortfolioTooltipBorder" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" resourcekey="cvLightBoxGalleryNumberOfColumnsResource1.ErrorMessage"
																	SetFocusOnError="True" Type="Integer" ValidationGroup="vgPortfolioSettings">
																</asp:CompareValidator>
															</td>
														</tr>
														<tr>
															<td>
																<asp:Label ID="lblPortfolioTooltipCornerRadius" runat="server" resourcekey="lblLightboxTooltipCornerRadius" Text="Corner radius:"></asp:Label>
															</td>
															<td>
																<asp:TextBox ID="tbPortfolioTooltipCornerRadius" runat="server" Width="53px">5</asp:TextBox>
																<asp:RequiredFieldValidator ID="rfvLightBoxGalleryNumberOfColumns8" runat="server" ControlToValidate="tbPortfolioTooltipCornerRadius" Display="Dynamic" ErrorMessage="This field is required." resourcekey="rfvLightBoxGalleryNumberOfColumnsResource1.ErrorMessage"
																	SetFocusOnError="True" ValidationGroup="vgPortfolioSettings">
																</asp:RequiredFieldValidator>
																<asp:CompareValidator ID="cvLightBoxGalleryNumberOfColumns8" runat="server" ControlToValidate="tbPortfolioTooltipCornerRadius" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" resourcekey="cvLightBoxGalleryNumberOfColumnsResource1.ErrorMessage"
																	SetFocusOnError="True" Type="Integer" ValidationGroup="vgPortfolioSettings">
																</asp:CompareValidator>
															</td>
														</tr>
														<tr>
															<td>
																<asp:Label ID="lblPortfolioTooltipTheme" runat="server" resourcekey="lblLightboxTooltipTheme" Text="Select theme:"></asp:Label>
															</td>
															<td>
																<asp:DropDownList ID="ddlPortfolioTooltipTheme" runat="server">
																	<asp:ListItem resourcekey="cream" Value="cream">Yellow</asp:ListItem>
																	<asp:ListItem resourcekey="dark" Value="dark">Dark</asp:ListItem>
																	<asp:ListItem resourcekey="green" Value="green">Green</asp:ListItem>
																	<asp:ListItem resourcekey="light" Value="light">Light</asp:ListItem>
																	<asp:ListItem resourcekey="red" Value="red">Red</asp:ListItem>
																	<asp:ListItem resourcekey="blue" Value="blue">Blue</asp:ListItem>
																</asp:DropDownList>
															</td>
														</tr>
													</table>
												</asp:Panel>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblPortfolioGalleryLightboxThumbnails" ResourceKey="lblLightboxGalleryLightboxThumbnails" runat="server" HelpText="Show thumbnails inside lightbox:" Text="Show thumbnails inside lightbox:" HelpKey="lblLightboxGalleryLightboxThumbnails.HelpText" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbPortfolioGalleryLightboxThumbnails" runat="server" resourcekey="cbLightboxGalleryLightboxThumbnailsResource1" Text="Show thumbnails inside lightbox" />
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblPortfolioGalleryLightboxSlideShow" ResourceKey="lblLightboxGalleryLightboxSlideShow" runat="server" HelpText="Slide show inside lightbox:" Text="Slide show inside lightbox:" HelpKey="lblLightboxGalleryLightboxSlideShow.HelpText" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbPortfolioSlideShow" runat="server" AutoPostBack="True" OnCheckedChanged="cbPortfolioSlideShow_CheckedChanged" resourcekey="cbLightBoxSlideShowResource1" Text="Slide show inside lightbox" />
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblPortfolioGallerySlideShowPause" ResourceKey="lblLightBoxGallerySlideShowPause" runat="server" HelpText="Slide show inside lightbox interval in miliseconds:" Text="Slide show inside lightbox (ms):" HelpKey="lblLightBoxGallerySlideShowPause.HelpText" />
											</td>
											<td>
												<asp:TextBox ID="tbPortfolioSSDuration" runat="server" CssClass="small textCenter" Enabled="False">5000</asp:TextBox>
												<asp:RequiredFieldValidator ID="rfvPortfolioGalleryWidth0" runat="server" ControlToValidate="tbPortfolioSSDuration" Display="Dynamic" ErrorMessage="This field is required." resourcekey="rfvLightBoxGalleryNumberOfColumnsResource1.ErrorMessage" ValidationGroup="vgPortfolioSettings" CssClass="smallInfo warning"></asp:RequiredFieldValidator>
												<asp:CompareValidator ID="cvPortfolioGalleryWidth0" runat="server" ControlToValidate="tbPortfolioSSDuration" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" resourcekey="cvLightBoxGalleryNumberOfColumnsResource1.ErrorMessage" Type="Integer" ValidationGroup="vgPortfolioSettings" CssClass="smallInfo warning"></asp:CompareValidator>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblPortfolioSlideShowAutoPlay" ResourceKey="lblLightBoxGallerySlideShowAutoPlay" runat="server" HelpText="Slide show inside lightbox autoplay:" Text="Slide show inside lightbox autoplay:" HelpKey="lblLightBoxGallerySlideShowAutoPlay.HelpText" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbPortfolioLightBoxSSAP" runat="server" Enabled="False" resourcekey="cbTBLightBoxSSAPResource1" Text="Slide show inside lightbox autoplay" />
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblPortfolioGalleryAnimationSpeed" ResourceKey="lblLightBoxGalleryAnimationSpeed" runat="server" HelpText="Lightbox animation speed:" Text="Lightbox animation speed:" HelpKey="lblLightBoxGalleryAnimationSpeed.HelpText" />
											</td>
											<td>
												<div class="styledSelect">
													<asp:DropDownList ID="ddlPortfolioLightboxAnimationSpeed" runat="server">
														<asp:ListItem Value="fast" resourcekey="ListItemResource25">Fast</asp:ListItem>
														<asp:ListItem Value="normal" resourcekey="ListItemResource26">Normal</asp:ListItem>
														<asp:ListItem Value="slow" resourcekey="ListItemResource27">Slow</asp:ListItem>
													</asp:DropDownList>
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblPortfolioGalleryOpenMediaUrl" runat="server" HelpKey="lblLightBoxGalleryOpenMediaUrl.HelpText" HelpText="On image click dont open image in lightbox, but open Media Url link." ResourceKey="lblLightBoxGalleryOpenMediaUrl" Text="On click go to Media Url:" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbPortfolioGalleryOpenMediaUrl" runat="server" AutoPostBack="True" OnCheckedChanged="cbPortfolioGalleryOpenMediaUrl_CheckedChanged" resourcekey="cbLightBoxGalleryOpenMediaUrlResource1" Text="On click go to Media Url" />
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblPortfolioGalleryOpenMediaUrlNewWindow" runat="server" HelpKey="lblLightBoxGalleryOpenMediaUrlNewWindow.HelpText" HelpText="Open link in new window:" ResourceKey="lblLightBoxGalleryOpenMediaUrlNewWindow" Text="Open link in new window:" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbPortfolioGalleryOpenMediaUrlNewWindow" runat="server" Enabled="False" resourcekey="cbLightBoxGalleryOpenMediaUrlNewWindowResource1" Text="Open link in new window" />
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblPortfolioGalleryWidth" runat="server" HelpText="Set the maximum gallery width:" Text="Maximum gallery width:" HelpKey="lblPortfolioGalleryWidth.HelpText" ResourceKey="lblPortfolioGalleryWidth" />
											</td>
											<td>
												<asp:TextBox ID="tbPortfolioGalleryImageWidth" runat="server" ValidationGroup="vgPortfolioSettings" CssClass="small textCenter">740</asp:TextBox>
												<asp:Label ID="lblPortfolioGalleryImageWidthType" runat="server" Text="%" Visible="False"></asp:Label>
												<asp:RequiredFieldValidator ID="rfvPortfolioGalleryWidth" runat="server" ControlToValidate="tbPortfolioGalleryImageWidth" Display="Dynamic" ErrorMessage="This field is required." resourcekey="rfvLightBoxGalleryNumberOfColumnsResource1.ErrorMessage" ValidationGroup="vgPortfolioSettings" CssClass="smallInfo warning"></asp:RequiredFieldValidator>
												<asp:CompareValidator ID="cvPortfolioGalleryWidth" runat="server" ControlToValidate="tbPortfolioGalleryImageWidth" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" resourcekey="cvLightBoxGalleryNumberOfColumnsResource1.ErrorMessage" Type="Integer" ValidationGroup="vgPortfolioSettings" CssClass="smallInfo warning"></asp:CompareValidator>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblPortfolioGalleryImageHeight" runat="server" HelpText="Set the maximum gallery height:" Text="Maximum gallery height:" HelpKey="lblPortfolioGalleryImageHeight.HelpText" ResourceKey="lblPortfolioGalleryImageHeight" Visible="True" />
											</td>
											<td>
												<asp:TextBox ID="tbPortfolioGalleryImageHeight" runat="server" ValidationGroup="vgPortfolioSettings" CssClass="small textCenter">550</asp:TextBox>
												<asp:RequiredFieldValidator ID="rfvPortfolioGalleryHeight" runat="server" ControlToValidate="tbPortfolioGalleryImageHeight" Display="Dynamic" ErrorMessage="This field is required." resourcekey="rfvLightBoxGalleryNumberOfColumnsResource1.ErrorMessage" ValidationGroup="vgPortfolioSettings" CssClass="smallInfo warning"></asp:RequiredFieldValidator>
												<asp:CompareValidator ID="cvPortfolioGalleryHeight" runat="server" ControlToValidate="tbPortfolioGalleryImageHeight" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" resourcekey="cvLightBoxGalleryNumberOfColumnsResource1.ErrorMessage" Type="Integer" ValidationGroup="vgPortfolioSettings" CssClass="smallInfo warning"></asp:CompareValidator>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblPortfolioGalleryImageWidth" ResourceKey="lblLightBoxGalleryImageWidth" runat="server" Text="Maximum image width:" ControlName="tbTGImageWidth" HelpText="Set the maximum image width for resizing:" HelpKey="lblLightBoxGalleryImageWidth.HelpText"></dnn:Label>
											</td>
											<td>
												<asp:TextBox ID="tbPortfolioThumbImageWidth" runat="server" ValidationGroup="vgPortfolioSettings" CssClass="small textCenter">150</asp:TextBox>
												<asp:RequiredFieldValidator ID="rfvLightBoxGalleryImageWidth0" runat="server" ControlToValidate="tbPortfolioThumbImageWidth" ErrorMessage="This field is required." ValidationGroup="vgPortfolioSettings" Display="Dynamic" resourcekey="rfvLightBoxGalleryImageWidthResource1.ErrorMessage" CssClass="smallInfo warning"></asp:RequiredFieldValidator>
												<asp:CompareValidator ID="cvLightBoxGalleryImageWidth0" runat="server" ControlToValidate="tbPortfolioThumbImageWidth" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" Type="Integer" ValidationGroup="vgPortfolioSettings" resourcekey="cvLightBoxGalleryImageWidthResource1.ErrorMessage" CssClass="smallInfo warning"></asp:CompareValidator>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblPortfolioGallerySetImageHeight" runat="server" Text="Maximum image height: " ControlName="tbTGImageHeight" HelpText="Set the maximum image height for resizing:" HelpKey="lblLightBoxGallerySetImageHeight.HelpText" ResourceKey="lblLightBoxGallerySetImageHeight"></dnn:Label>
											</td>
											<td>
												<asp:TextBox ID="tbPortfolioThumbImageHeight" runat="server" ValidationGroup="vgPortfolioSettings" CssClass="small textCenter">150</asp:TextBox>
												<asp:RequiredFieldValidator ID="rfvLightBoxGalleryImageHeight0" runat="server" ControlToValidate="tbPortfolioThumbImageHeight" ErrorMessage="This field is required." ValidationGroup="vgPortfolioSettings" Display="Dynamic" resourcekey="rfvLightBoxGalleryImageHeightResource1.ErrorMessage" CssClass="smallInfo warning"></asp:RequiredFieldValidator>
												<asp:CompareValidator ID="cvLightBoxGalleryImageHeight0" runat="server" ControlToValidate="tbPortfolioThumbImageHeight" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" Type="Integer" ValidationGroup="vgPortfolioSettings" resourcekey="cvLightBoxGalleryImageHeightResource1.ErrorMessage" CssClass="smallInfo warning"></asp:CompareValidator>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblPotfolioGalleryNumberOfItems" ResourceKey="lblLightBoxGalleryNumberOfItems" runat="server" Text="Number of items per page:" HelpText="Set the maximum number of items on one page:" HelpKey="lblPotfolioGalleryNumberOfItems.HelpText"></dnn:Label>
											</td>
											<td>
												<asp:TextBox ID="tbPortfolioNumOfItems" runat="server" ValidationGroup="vgPortfolioSettings" CssClass="small textCenter">12</asp:TextBox>
												<asp:RequiredFieldValidator ID="rfvLightBoxGalleryNumberOfItems0" runat="server" ControlToValidate="tbPortfolioNumOfItems" ErrorMessage="This field is required." ValidationGroup="vgPortfolioSettings" Display="Dynamic" resourcekey="rfvLightBoxGalleryNumberOfItemsResource1.ErrorMessage" CssClass="smallInfo warning"></asp:RequiredFieldValidator>
												<asp:CompareValidator ID="cvLightBoxGalleryNumberOfItems0" runat="server" ControlToValidate="tbPortfolioNumOfItems" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" Type="Integer" ValidationGroup="vgPortfolioSettings" resourcekey="cvLightBoxGalleryNumberOfItemsResource1.ErrorMessage" CssClass="smallInfo warning"></asp:CompareValidator>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblPortfolioSlideEasing" runat="server" HelpText="Slide animation effect:" Text="Slide animation effect:" HelpKey="lblPortfolioSlideEasing.HelpText" ResourceKey="lblPortfolioSlideEasing" />
											</td>
											<td>
												<div class="styledSelect">
													<asp:DropDownList ID="dllPortfoliosSlideEasing" runat="server">
														<asp:ListItem>easeOutQuad</asp:ListItem>
														<asp:ListItem>easeInQuad</asp:ListItem>
														<asp:ListItem>easeInOutQuad</asp:ListItem>
														<asp:ListItem>easeInCubic</asp:ListItem>
														<asp:ListItem>easeOutCubic</asp:ListItem>
														<asp:ListItem>easeInOutCubic</asp:ListItem>
														<asp:ListItem>easeInQuart</asp:ListItem>
														<asp:ListItem>easeOutQuart</asp:ListItem>
														<asp:ListItem>easeInOutQuart</asp:ListItem>
														<asp:ListItem>easeInQuint</asp:ListItem>
														<asp:ListItem>easeOutQuint</asp:ListItem>
														<asp:ListItem>easeInOutQuint</asp:ListItem>
														<asp:ListItem>easeInSine</asp:ListItem>
														<asp:ListItem>easeOutSine</asp:ListItem>
														<asp:ListItem>easeInOutSine</asp:ListItem>
														<asp:ListItem>easeInExpo</asp:ListItem>
														<asp:ListItem>easeOutExpo</asp:ListItem>
														<asp:ListItem>easeInOutExpo</asp:ListItem>
														<asp:ListItem>easeInCirc</asp:ListItem>
														<asp:ListItem>easeOutCirc</asp:ListItem>
														<asp:ListItem>easeInOutCirc</asp:ListItem>
														<asp:ListItem>easeInElastic</asp:ListItem>
														<asp:ListItem>easeOutElastic</asp:ListItem>
														<asp:ListItem>easeInOutElastic</asp:ListItem>
														<asp:ListItem>easeInBack</asp:ListItem>
														<asp:ListItem>easeOutBack</asp:ListItem>
														<asp:ListItem>easeInOutBack</asp:ListItem>
														<asp:ListItem>easeInBounce</asp:ListItem>
														<asp:ListItem>easeOutBounce</asp:ListItem>
														<asp:ListItem>easeInOutBounce</asp:ListItem>
													</asp:DropDownList>
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblPortfolioSlideAnimationDuration" runat="server" HelpText="Slide animation duration in miliseconds:" Text="Slide animation effect (ms):" HelpKey="lblPortfolioSlideAnimationDuration.HelpText" ResourceKey="lblPortfolioSlideAnimationDuration" />
											</td>
											<td>
												<asp:TextBox ID="tbPortfolioSlideAimationDuration" runat="server" ValidationGroup="vgPortfolioSettings" Width="50px">1500</asp:TextBox>
												<asp:RequiredFieldValidator ID="rfvPortfolioSLideAnimationDuration" runat="server" ControlToValidate="tbPortfolioSlideAimationDuration" Display="Dynamic" ErrorMessage="This field is required." resourcekey="rfvLightBoxGalleryNumberOfColumnsResource1.ErrorMessage" ValidationGroup="vgPortfolioSettings" CssClass="smallInfo warning"></asp:RequiredFieldValidator>
												<asp:CompareValidator ID="cvSlideAnimationDuration" runat="server" ControlToValidate="tbPortfolioSlideAimationDuration" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" resourcekey="cvLightBoxGalleryNumberOfColumnsResource1.ErrorMessage" Type="Integer" ValidationGroup="vgPortfolioSettings" CssClass="smallInfo warning"></asp:CompareValidator>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblPortfolioGalleryCropImages" ResourceKey="lblLightBoxGalleryCropImages" runat="server" Text="Resize and crop vertical images:" ControlName="cbSmartCropVertical" HelpText="Set this to crop vertical images:" HelpKey="lblLightBoxGalleryCropImages.HelpText"></dnn:Label>
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbPortfolioGallerySmartCropVertical" runat="server" OnCheckedChanged="cbPortfolioGallerySmartCropVertical_CheckedChanged" resourcekey="cbLightBoxGallerySmartCropVerticalResource1" AutoPostBack="True" Text="Resize and crop vertical images" />
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblPortfolioGalleryResizeCrop" ResourceKey="lblLightBoxGalleryResizeCrop" runat="server" Text="Resize and crop all images:" ControlName="cbTGSmartResizeAndCrop" HelpText="Set this this to resize all images to same width and height:" HelpKey="lblLightBoxGalleryResizeCrop.HelpText"></dnn:Label>
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbPortfolioGalleryResizeAndCrop" runat="server" OnCheckedChanged="cbPortfolioGalleryResizeAndCrop_CheckedChanged" Checked="True" resourcekey="cbLightBoxGalleryResizeAndCropResource1" AutoPostBack="True" Text="Resize and crop all images" />
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="Label1" runat="server" HelpText="Select media sorting options:" Text="Media sorting:" HelpKey="lblLightBoxMediaSorting.HelpText" ResourceKey="lblLightBoxMediaSorting" />
											</td>
											<td>
												<table class="clearWidth textLeft">
													<tr>
														<td>
															<div class="styledSelect">
																<asp:DropDownList ID="ddlPortfolioMediaSorting" runat="server">
																	<asp:ListItem resourcekey="liPosition" Value="Position">Position</asp:ListItem>
																	<asp:ListItem resourcekey="liDateUploaded" Value="DateUploaded">Date uploaded</asp:ListItem>
																	<asp:ListItem resourcekey="liFileName" Value="FileName">Filename</asp:ListItem>
																	<asp:ListItem resourcekey="liTitle">Title</asp:ListItem>
																</asp:DropDownList>
															</div>
														</td>
														<td>&nbsp;</td>
														<td>
															<asp:RadioButtonList ID="rblPortfolioSortType" runat="server" CssClass="styledRadio small" RepeatDirection="Horizontal">
																<asp:ListItem resourcekey="liAscending" Selected="True" Value="ASC">Ascending</asp:ListItem>
																<asp:ListItem resourcekey="liDescending" Value="DESC">Descending</asp:ListItem>
															</asp:RadioButtonList>
														</td>
													</tr>
												</table>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblLightboxPortfolioGalleryTitle" runat="server" HelpKey="lblLightboxPortfolioGalleryTitle.HelpText" HelpText="Please enter title to display:" ResourceKey="lblLightboxPortfolioGalleryTitle" Text="Title to display:" />
											</td>
											<td>
												<asp:TextBox ID="tbLightboxPortoflioTitle" runat="server" CssClass="large"></asp:TextBox>
											</td>
										</tr>
										<tr class="color6HighLighted">
											<td>
												<dnn:Label ID="lblLightboxPortfolioEnableFullscreen" runat="server" HelpKey="lblLightboxPortfolioEnableFullscreen.HelpText" HelpText="Enable fullscreen:" ResourceKey="lblLightboxPortfolioEnableFullscreen.Text" Text="Enable fullscreen:" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbPortfolioEnableFullscreen" runat="server" Text="Enable fullscreen" />
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblLightboxPortfolioFullscreenTheme" runat="server" HelpKey="lblLightboxPortfolioFullscreenTheme.HelpText" HelpText="Select fullscreen theme:" ResourceKey="lblLightboxPortfolioFullscreenTheme.Text" Text="Select fullscreen theme:" />
											</td>
											<td>
												<div class="styledSelect">
													<asp:DropDownList ID="ddlPortfolioFullscreenThemeSelect" runat="server"></asp:DropDownList>
												</div>
											</td>
										</tr>
										<tr>
											<td class="textTop">
												<dnn:Label ID="lblLightBoxShowDownload0" runat="server" HelpKey="lblLightBoxShowDownload.HelpText" HelpText="Show image download link:" ResourceKey="lblLightBoxShowDownload" Text="Show image download link:" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbPortfolioShowDownloadLink" runat="server" AutoPostBack="True" OnCheckedChanged="cbPortfolioShowDownloadLink_CheckedChanged" resourcekey="cbLightBoxGallerySmartCropVerticalResource1" Text="Show image download link" />
												</div>
												<asp:Panel ID="pnlPortfolioDownloadOptions" runat="server" BackColor="#CBEEF8" BorderColor="#65CDEB" BorderStyle="Solid" BorderWidth="2px" Visible="False">
													<table class="clearWidth">
														<tr>
															<td class="textTop">
																<asp:Label ID="lblLighboxSelectDownloadRoles0" runat="server" resourcekey="lblLighboxSelectDownloadRoles" Text="Select download roles:"></asp:Label>
															</td>
															<td>
																<asp:GridView ID="gvPortfolioDownloadRoles" runat="server" AutoGenerateColumns="False" BorderColor="#65CDEB" BorderStyle="Solid" BorderWidth="1px" CellPadding="4" CssClass="intliststylebox" ForeColor="#333333" GridLines="None" OnRowDataBound="gvPortfolioDownloadRoles_RowDataBound">
																	<RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
																	<Columns>
																		<asp:TemplateField HeaderText="Role">
																			<ItemTemplate>
																				<asp:Label ID="lblRoleName1" runat="server" Text='<%# Bind("Role") %>'></asp:Label>
																			</ItemTemplate>
																			<ItemStyle CssClass="textLeft" />
																		</asp:TemplateField>
																		<asp:TemplateField HeaderText="Enable download">
																			<ItemTemplate>
																				<asp:CheckBox ID="cbPortEnableDownload" runat="server" Checked='<%# Bind("EnableDownload") %>' />
																			</ItemTemplate>
																			<ItemStyle CssClass="textCenter" />
																		</asp:TemplateField>
																	</Columns>
																	<FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
																	<PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
																	<SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
																	<HeaderStyle BackColor="#0BA2CE" Font-Bold="True" ForeColor="#FFFFFF" CssClass="textCenter" />
																	<EditRowStyle BackColor="#999999" />
																	<AlternatingRowStyle BackColor="White" ForeColor="#284775" />
																</asp:GridView>
															</td>
														</tr>
														<tr>
															<td colspan="2">
																<div class="styledCheckbox displayInline">
																	<asp:CheckBox ID="cbPortfolioUseViewAsDownload" runat="server" resourcekey="lblUseViewVersionAsDownload" Text="Use view version as download version if there is no download verison" />
																</div>
															</td>
														</tr>
													</table>
												</asp:Panel>
											</td>
										</tr>
										<tr>
											<td class="textTop">
												<dnn:Label ID="lblPortfolioShowSocialSharingButtons" runat="server" CssClass="styleBolded" HelpText="Show social sharing buttons inside thumbnail:" Text="Show sharing buttons:" HelpKey="lblLightBoxShowSocialSharingButtons.HelpText" ResourceKey="lblLightBoxShowSocialSharingButtons" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbPortfolioShowSharingButtons" runat="server" AutoPostBack="True" OnCheckedChanged="cbPortfolioShowSharingButtons_CheckedChanged" Text="Show sharing buttons" />
												</div>
												<asp:Panel ID="pnlPortfolioSharingButtonsOptions" runat="server" BackColor="#CBEEF8" BorderColor="#65CDEB" BorderStyle="Solid" BorderWidth="2px" Visible="False">
													<table>
														<tr>
															<td>
																<dnn:Label ID="lblLightboxSharingButtonFacebook0" runat="server" HelpText="Show Facebook button:" Text="Show Facebook button:" HelpKey="lblLightboxSharingButtonFacebook.HelpText" ResourceKey="lblLightboxSharingButtonFacebook" />
															</td>
															<td>
																<asp:CheckBox ID="cbPortfolioSharingButtonFacebook" runat="server" />
															</td>
														</tr>
														<tr>
															<td>
																<dnn:Label ID="lblLightboxSharingButtonGooglePlus0" runat="server" HelpText="Show Googple Plus button:" Text="Show Googple Plus button:" HelpKey="lblLightboxSharingButtonGooglePlus.HelpText" ResourceKey="lblLightboxSharingButtonGooglePlus" />
															</td>
															<td>
																<asp:CheckBox ID="cbPortfolioSharingButtonGooglePlus" runat="server" />
															</td>
														</tr>
														<tr>
															<td>
																<dnn:Label ID="lblLightboxSharingButtonTwitter0" runat="server" HelpText="Show Twitter button:" Text="Show Twitter button:" HelpKey="lblLightboxSharingButtonTwitter.HelpText" ResourceKey="lblLightboxSharingButtonTwitter" />
															</td>
															<td>
																<asp:CheckBox ID="cbPortfolioSharingButtonTwitter" runat="server" />
															</td>
														</tr>
													</table>
												</asp:Panel>
											</td>
										</tr>
										<tr>
											<td colspan="2"></td>
										</tr>
										<tr class="color2HighLighted">
											<td colspan="2" class="textCenter">
												<asp:Label ID="lblPortfolioNavigationSettings" runat="server" resourcekey="lblPortfolioNavigationSettings" Text="Navigation settings:"></asp:Label>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblNavbarOptions" runat="server" HelpText="Show navigation:" Text="Show navigation:" HelpKey="lblNavbarOptions.HelpText" ResourceKey="lblNavbarOptions" />
											</td>
											<td>
												<div class="styledCheckbox nolabel">
													<asp:CheckBox ID="cbPortfolioGalleryNestedShowNavigationBar" runat="server" AutoPostBack="True" Checked="True" OnCheckedChanged="cbPortfolioGalleryNestedShowNavigationBar_CheckedChanged" Text="Show navigation" />
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblLightboxPortfolioMenuType" runat="server" HelpText="Select navigation menu type:" Text="Navigation menu type:" HelpKey="lblLightboxPortfolioMenuType.HelpText" ResourceKey="lblLightboxPortfolioMenuType" />
											</td>
											<td>
												<div class="styledSelect">
													<asp:DropDownList ID="ddlLightboxPortfolioMenuStyle" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlLightboxPortfolioMenuStyle_SelectedIndexChanged">
														<asp:ListItem resourcekey="liNavBar" Value="classic">Navigation bar</asp:ListItem>
														<asp:ListItem resourcekey="liDropDownList" Value="dropdown">Dropdown list</asp:ListItem>
														<asp:ListItem resourcekey="liLeftMenu" Value="left">Left menu</asp:ListItem>
														<asp:ListItem resourcekey="liRightMenu" Value="right">Right menu</asp:ListItem>
													</asp:DropDownList>
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblLightboxPortfolioMenuSlidableNames" runat="server" HelpText="Slidable titles:" Text="Slidable titles:" HelpKey="lblLightboxPortfolioMenuSlidableNames.HelpText" ResourceKey="lblLightboxPortfolioMenuSlidableNames" />
											</td>
											<td>
												<div class="styledCheckbox nolabel">
													<asp:CheckBox ID="cbLightboxPortfolioSlidableTitles" runat="server" AutoPostBack="True" Text="Slidable titles" />
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblLightboxPortfolioMenuWidth" runat="server" HelpText="Menu width:" Text="Menu width:" HelpKey="lblLightboxPortfolioMenuWidth.HelpText" ResourceKey="lblLightboxPortfolioMenuWidth" />
											</td>
											<td>
												<asp:TextBox ID="tbPortfolioMenuWidth" runat="server" Enabled="False" ValidationGroup="vgPortfolioSettings" Width="50px">200</asp:TextBox>
												<asp:RequiredFieldValidator ID="rfvLightBoxGalleryNumberOfItems3" runat="server" ControlToValidate="tbPortfolioMenuWidth" Display="Dynamic" ErrorMessage="This field is required." resourcekey="rfvLightBoxGalleryNumberOfItemsResource1.ErrorMessage" ValidationGroup="vgPortfolioSettings" CssClass="smallInfo warning"></asp:RequiredFieldValidator>
												<asp:CompareValidator ID="cvLightBoxGalleryNumberOfItems3" runat="server" ControlToValidate="tbPortfolioMenuWidth" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" resourcekey="cvLightBoxGalleryNumberOfItemsResource1.ErrorMessage" Type="Integer" ValidationGroup="vgPortfolioSettings" CssClass="smallInfo warning"></asp:CompareValidator>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblLightboxShowNavigationArrows" runat="server" HelpText="Show navigation arrows:" Text="Show navigation arrows:" HelpKey="lblLightboxShowNavigationArrows.HelpText" ResourceKey="lblLightboxShowNavigationArrows" Visible="True" />
											</td>
											<td>
												<div class="styledCheckbox nolabel">
													<asp:CheckBox ID="cbLightboxPortfolioShowArrows" runat="server" AutoPostBack="True" OnCheckedChanged="cbLightboxPortfolioShowArrows_CheckedChanged" Text="Show navigation arrows" />
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblLightboxPortfolioAutoHideNavigationArrows" runat="server" HelpText="Auto hide navigation arrows on mouse out:" Text="Auto hide navigation arrows:" HelpKey="lblLightboxPortfolioAutoHideNavigationArrows.HelpText" ResourceKey="lblLightboxPortfolioAutoHideNavigationArrows" />
											</td>
											<td>
												<div class="styledCheckbox nolabel">
													<asp:CheckBox ID="cbLightboxPortfolioAutoHideArrows" runat="server" Enabled="False" Text="Auto hide navigation arrows" />
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblLightboxPortfolioDropDownImages" runat="server" HelpText="Dropdown menu style:" Text="Dropdown menu style:" HelpKey="lblLightboxPortfolioDropDownImages.HelpText" ResourceKey="lblLightboxPortfolioDropDownImages" />
											</td>
											<td>
												<div class="styledSelect">
													<asp:DropDownList ID="ddlLightboxPortfolioDropDownStyle" runat="server" Enabled="False"></asp:DropDownList>
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblLightboxPortfolioArrows" runat="server" HelpText="Navigation arrows:" Text="Navigation arrows:" HelpKey="lblLightboxPortfolioArrows.HelpText" ResourceKey="lblLightboxPortfolioArrows" />
											</td>
											<td>
												<div class="styledSelect">
													<asp:DropDownList ID="ddlLightboxPortfolioArrows" runat="server" Enabled="False"></asp:DropDownList>
													<div>
											</td>
										</tr>
										<tr>
											<td colspan="2"></td>
										</tr>
										<tr class="color2HighLighted">
											<td colspan="2" class="textCenter">
												<asp:Label ID="lblLightBoxGalleryViseoPlayerSettings0" runat="server" resourcekey="lblLightBoxGalleryViseoPlayerSettingsResource1" Text="Video player in lightbox settings:"></asp:Label>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblPortfolioVPSelectPlayer" runat="server" HelpKey="SelectVideoPlayer.HelpText" HelpText="Select player:" ResourceKey="SelectVideoPlayer.Text" Text="Select player:" />
											</td>
											<td>
												<div class="styledSelect">
													<asp:DropDownList ID="ddlPortfolioVPSelectPlayer" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlPortfolioVPSelectPlayer_SelectedIndexChanged">
														<asp:ListItem Selected="False" Value="False">Standard</asp:ListItem>
														<asp:ListItem Value="True">Flow player</asp:ListItem>
													</asp:DropDownList>
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblPortfolioGalleryVideoPlayerSelectSkin0" runat="server" HelpKey="lblLightBoxGalleryVideoPlayerSelectSkin.HelpText" HelpText="Select video player skin:" ResourceKey="lblLightBoxGalleryVideoPlayerSelectSkin" Text="Select video player skin:" />
											</td>
											<td>
												<div class="styledSelect">
													<asp:DropDownList ID="ddlPortfolioVPSelectTheme" runat="server">
														<asp:ListItem resourcekey="ListItemResource28" Selected="True" Value="black">Black</asp:ListItem>
														<asp:ListItem resourcekey="ListItemResource29" Value="white">White</asp:ListItem>
													</asp:DropDownList>
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblPortfolioGalleryVideoPlayerPlayOnLoad0" runat="server" HelpKey="lblLightBoxGalleryVideoPlayerPlayOnLoad.HelpText" HelpText="Start to play video on page load:" ResourceKey="lblLightBoxGalleryVideoPlayerPlayOnLoad" Text="Play on load:" />
											</td>
											<td>
												<div class="styledCheckbox nolabel">
													<asp:CheckBox ID="cbPortfolioVPPlayOnLoad" runat="server" resourcekey="cbTGVPPlayOnLoadResource1" Text="Play on load" />
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblPortfolioGalleryViseoPlayerPlayOnLoad0" runat="server" HelpKey="lblLightBoxGalleryViseoPlayerPlayOnLoad.HelpText" HelpText="Show description inside video player:" ResourceKey="lblLightBoxGalleryViseoPlayerPlayOnLoad" Text="Show description:" />
											</td>
											<td>
												<div class="styledCheckbox nolabel">
													<asp:CheckBox ID="cbPortfolioVPShowDescription" runat="server" resourcekey="cbTGVPShowDescriptionResource1" Text="Show description" />
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblPortfolioVPAllowFullscreen" runat="server" HelpKey="lblTGVPAllowFullscreen.HelpText" HelpText="Allow video to be played in fullscreen:" ResourceKey="lblTGVPAllowFullscreen" Text="Allow fullscreen:" />
											</td>
											<td>
												<div class="styledCheckbox nolabel">
													<asp:CheckBox ID="cbPortfolioVPAllowFullscreen" runat="server" resourcekey="cbTGVPAllowFullscreenResource1" Text="Allow fullscreen" />
												</div>
											</td>
										</tr>
										<tr>
											<td colspan="2"></td>
										</tr>
										<tr class="color2HighLighted">
											<td colspan="2" class="textCenter">
												<asp:Label ID="lblLightBoxGalleryAudioPlayerSettings0" runat="server" resourcekey="lblLightBoxGalleryAudioPlayerSettingsResource1" Text="Audio player in lightbox settings:"></asp:Label>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblLightBoxGalleryAudioPlayerPlayOnLoad0" runat="server" HelpKey="lblLightBoxGalleryAudioPlayerPlayOnLoad.HelpText" HelpText="Start to play audio on page load:" ResourceKey="lblLightBoxGalleryAudioPlayerPlayOnLoad" Text="Play on load:" />
											</td>
											<td>
												<div class="styledCheckbox nolabel">
													<asp:CheckBox ID="cbPortfolioAPPlayOnLoad" runat="server" resourcekey="cbTGAPPlayOnLoadResource1" Text="Play on load" />
												</div>
											</td>
										</tr>
										<tr>
											<td>&nbsp;
											</td>
											<td>
												<asp:TextBox ID="tbLightboxPortfolioFullscreen" runat="server" Enabled="False" Visible="False" Width="50px"></asp:TextBox></td>
										</tr>
									</table>
									<asp:Label ID="lblPortfolioGalleryStatus" runat="server" EnableViewState="False"></asp:Label>
									<div class="mainActions">
										<asp:LinkButton ID="btnPortfolioGallerySaveSettings" runat="server" OnClick="btnPortfolioGallerySaveSettings_Click" resourcekey="btnLightBoxGallerySaveResource1" Text="Save settings" ValidationGroup="vgPortfolioSettings" CssClass="downSave" />
										<asp:LinkButton ID="btnLightBoxGallerySaveClose0" runat="server" OnClick="btnLightBoxGallerySaveClose0_Click" resourcekey="btnLightBoxGallerySaveCloseResource1" Text="Save &amp; Close" ValidationGroup="vgPortfolioSettings" CssClass="downSaveClose" />
									</div>
								</div>
							</asp:Panel>
							<asp:Panel ID="pnlImageSlider" runat="server" Visible="False" CssClass="settingsList negativeMargins40">
								<h3>
									<asp:Label ID="lblImageSliderDisplaySettings" runat="server" CssClass="settingsdetailtitle" Text="Image slider display settings" resourcekey="lblImageSliderDisplaySettingsResource1"></asp:Label>
								</h3>
								<div class="settingsTable">
									<table>
										<tr>
											<td>
												<dnn:Label ID="lblImageSliderTemplateSelect" runat="server" ControlName="ddlSSThemeSelect" HelpKey="lblImageSliderTemplateSelect.HelpText" HelpText="Select the control viewer template:" ResourceKey="lblImageSliderTemplateSelect" Text="Select template:" />
											</td>
											<td>
												<div class="styledSelect">
													<asp:DropDownList ID="ddlImageSliderTemplateSelect" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlImageSliderTemplateSelect_SelectedIndexChanged"></asp:DropDownList>
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblImageSliderTheme" runat="server" ControlName="ddlImageSliderTheme" Text="Select theme:" HelpText="Select theme." ResourceKey="lblImageSliderTheme" />
											</td>
											<td>
												<div class="styledSelect">
													<asp:DropDownList ID="ddlImageSliderTheme" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlImageSliderTemplateSelect_SelectedIndexChanged">
														<asp:ListItem Value="Modern">Modern</asp:ListItem>
														<asp:ListItem Value="Classic">Classic</asp:ListItem>
														<asp:ListItem Value="Dark">Dark</asp:ListItem>
														<asp:ListItem Value="Light">Light</asp:ListItem>
													</asp:DropDownList>
												</div>
												<asp:Label ID="lblImageSliderTemplateInfo" runat="server"></asp:Label>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="dnnImageSliderRsponsive" runat="server" HelpText="Select the layout type:" Text="Select the layout type:" HelpKey="lblChameleonSelectLayoutType.HelpText" ResourceKey="lblChameleonSelectLayoutType" />
											</td>
											<td>
												<asp:RadioButtonList ID="rblImageSliderRsponsive" runat="server" RepeatDirection="Horizontal" CssClass="styledRadio">
													<asp:ListItem resourcekey="liResponsive" Value="responsive">Responsive Layout</asp:ListItem>
													<asp:ListItem resourcekey="liFixed" Selected="True" Value="fixed">Fixed Layout</asp:ListItem>
												</asp:RadioButtonList>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblImageSliderShowMeidaTitle" ResourceKey="lblImageSliderShowMeidaTitle" runat="server" HelpText="Show image title:" Text="Show image title:" HelpKey="lblImageSliderShowMeidaTitle.HelpText" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbImageSliderShowMediaTitle" runat="server" resourcekey="cbImageSliderShowMediaTitleResource1" Text="Show image title" />
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblImageSliderShowMediaDescription" ResourceKey="lblImageSliderShowMediaDescription" runat="server" HelpText="Show image description:" Text="Show image description:" HelpKey="lblImageSliderShowMediaDescription.HelpText" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbImageSliderShowMediaDescription" runat="server" resourcekey="cbImageSliderShowMediaDescriptionResource1" Text="Show image description" />
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblImageSliderShowLightboxTitle" ResourceKey="lblImageSliderShowLightboxTitle" runat="server" HelpText="Show image title in lightbox:" Text="Show image title in lightbox:" HelpKey="lblImageSliderShowLightboxTitle.HelpText" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbImageSliderShowLightboxTitle" runat="server" resourcekey="cbImageSliderShowLightboxTitleResource1" Text="Show image title in lightbox" />
												</div>
											</td>
										</tr>
										<tr>
											<td class="textTop">
												<dnn:Label ID="lblImageSliderShowLightboxDescription" ResourceKey="lblImageSliderShowLightboxDescription" runat="server" HelpText="Show image description in lightbox:" Text="Show image description in lightbox:" HelpKey="lblImageSliderShowLightboxDescription.HelpText" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbImageSliderShowLightboxDescription" runat="server" resourcekey="cbImageSliderShowLightboxDescriptionResource1" AutoPostBack="True" OnCheckedChanged="cbImageSliderShowLightboxDescription_CheckedChanged" Text="Show image description in lightbox" />
												</div>
												<asp:Panel ID="pnlImageSliderTipOptions" runat="server" BackColor="#CBEEF8" BorderColor="#65CDEB" BorderStyle="Solid" BorderWidth="2px" Visible="False">
													<table>
														<tr>
															<td colspan="2">
																<asp:Label ID="lblImageSliderToolTipOptions" runat="server" Font-Bold="True" resourcekey="lblLightBoxToolTipOptions" Text="Tooltip options"></asp:Label>
															</td>
														</tr>
														<tr>
															<td>
																<asp:Label ID="lblImageSliderLightboxShowTooltips" runat="server" resourcekey="lblLightboxShowToolTips" Text="Show Tooltips:"></asp:Label>
															</td>
															<td>
																<asp:CheckBox ID="cbImageSliderShowToolTips" runat="server" Checked="True" />
															</td>
														</tr>
														<tr>
															<td>
																<asp:Label ID="lblImageSliderTargetPosition" runat="server" resourcekey="lblLightboxTargetPosition" Text="Target position:"></asp:Label>
															</td>
															<td>
																<asp:DropDownList ID="ddlImageSliderTargetPosition" runat="server">
																	<asp:ListItem resourcekey="topLeft" Value="topLeft">Top left</asp:ListItem>
																	<asp:ListItem resourcekey="topMiddle" Value="topMiddle" Selected="True">Top middle</asp:ListItem>
																	<asp:ListItem resourcekey="topRight" Value="topRight">Top right</asp:ListItem>
																	<asp:ListItem resourcekey="leftTop" Value="leftTop">Left top</asp:ListItem>
																	<asp:ListItem resourcekey="leftMiddle" Value="leftMiddle">Left middle</asp:ListItem>
																	<asp:ListItem resourcekey="leftBottom" Value="leftBottom">Left bottom</asp:ListItem>
																	<asp:ListItem resourcekey="center" Value="center">Center</asp:ListItem>
																	<asp:ListItem resourcekey="rightTop" Value="rightTop">Right top</asp:ListItem>
																	<asp:ListItem resourcekey="rightMiddle" Value="rightMiddle">Right middle</asp:ListItem>
																	<asp:ListItem resourcekey="rightBottom" Value="rightBottom">Right bottom</asp:ListItem>
																	<asp:ListItem resourcekey="bottomLeft" Value="bottomLeft">Bottom left</asp:ListItem>
																	<asp:ListItem resourcekey="bottomMiddle" Value="bottomMiddle">Bottom middle</asp:ListItem>
																	<asp:ListItem resourcekey="bottomRight" Value="bottomRight">Bottom right</asp:ListItem>
																</asp:DropDownList>
															</td>
														</tr>
														<tr>
															<td>
																<asp:Label ID="lblImageSliderTooltipPosition" runat="server" resourcekey="lblLightboxTooltipPosition" Text="Tooltip position:"></asp:Label>
															</td>
															<td>
																<asp:DropDownList ID="ddlImageSliderTooltipPosition" runat="server">
																	<asp:ListItem resourcekey="topLeft" Value="topLeft">Top left</asp:ListItem>
																	<asp:ListItem resourcekey="topMiddle" Value="topMiddle">Top middle</asp:ListItem>
																	<asp:ListItem resourcekey="topRight" Value="topRight">Top right</asp:ListItem>
																	<asp:ListItem resourcekey="leftTop" Value="leftTop">Left top</asp:ListItem>
																	<asp:ListItem resourcekey="leftMiddle" Value="leftMiddle">Left middle</asp:ListItem>
																	<asp:ListItem resourcekey="leftBottom" Value="leftBottom">Left bottom</asp:ListItem>
																	<asp:ListItem resourcekey="center" Value="center">Center</asp:ListItem>
																	<asp:ListItem resourcekey="rightTop" Value="rightTop">Right top</asp:ListItem>
																	<asp:ListItem resourcekey="rightMiddle" Value="rightMiddle">Right middle</asp:ListItem>
																	<asp:ListItem resourcekey="rightBottom" Value="rightBottom">Right bottom</asp:ListItem>
																	<asp:ListItem resourcekey="bottomLeft" Value="bottomLeft">Bottom left</asp:ListItem>
																	<asp:ListItem resourcekey="bottomMiddle" Selected="True" Value="bottomMiddle">Bottom middle</asp:ListItem>
																	<asp:ListItem resourcekey="bottomRight" Value="bottomRight">Bottom right</asp:ListItem>
																</asp:DropDownList>
															</td>
														</tr>
														<tr>
															<td>
																<asp:Label ID="lblImageSliderShowEffect" runat="server" resourcekey="lblLightboxShowEffect" Text="Show effect:"></asp:Label>
															</td>
															<td>
																<asp:DropDownList ID="ddlImageSliderShoweffect" runat="server">
																	<asp:ListItem resourcekey="fade" Value="fade">Fade</asp:ListItem>
																	<asp:ListItem resourcekey="slide" Value="slide">Slide</asp:ListItem>
																	<asp:ListItem resourcekey="grow" Value="grow">Grow</asp:ListItem>
																</asp:DropDownList>
															</td>
														</tr>
														<tr>
															<td>
																<asp:Label ID="lblImageSliderShowEffectDuration" runat="server" resourcekey="lblLightboxShowEffectDuration" Text="Show effect duration (ms):"></asp:Label>
															</td>
															<td>
																<asp:TextBox ID="tbImageSliderTooltipShowDuration" runat="server" Width="53px">500</asp:TextBox>
																&nbsp;<asp:RequiredFieldValidator ID="rfvImageCarouselImageWidth8" runat="server" ControlToValidate="tbImageSliderTooltipShowDuration" Display="Dynamic" ErrorMessage="This field is required." resourcekey="rfvImageCarouselImageWidthResource1.ErrorMessage"
																	SetFocusOnError="True" ValidationGroup="vgVerticalCarouselSettings"></asp:RequiredFieldValidator>
																<asp:CompareValidator ID="cvImageCarouselImageWidth8" runat="server" ControlToValidate="tbImageSliderTooltipShowDuration" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" resourcekey="cvImageCarouselImageWidthResource1.ErrorMessage"
																	SetFocusOnError="True" Type="Integer" ValidationGroup="vgVerticalCarouselSettings">
																</asp:CompareValidator>
															</td>
														</tr>
														<tr>
															<td>
																<asp:Label ID="lblImageSliderShowHideEffect" runat="server" resourcekey="lblLightboxShowHideEffect" Text="Hide effect:"></asp:Label>
															</td>
															<td>
																<asp:DropDownList ID="ddlImageSliderHideEffect" runat="server">
																	<asp:ListItem resourcekey="fade" Value="fade">Fade</asp:ListItem>
																	<asp:ListItem resourcekey="slide" Value="slide">Slide</asp:ListItem>
																	<asp:ListItem resourcekey="grow" Value="grow">Grow</asp:ListItem>
																</asp:DropDownList>
															</td>
														</tr>
														<tr>
															<td>
																<asp:Label ID="lblImageSliderHideEffectDuration" runat="server" resourcekey="lblLightboxHideEffectDuration" Text="Hide effect duration (ms):"></asp:Label>
															</td>
															<td>
																<asp:TextBox ID="tbImageSliderTooltipHideDuration" runat="server" Width="53px">500</asp:TextBox>
																&nbsp;<asp:RequiredFieldValidator ID="rfvImageCarouselImageWidth9" runat="server" ControlToValidate="tbImageSliderTooltipHideDuration" Display="Dynamic" ErrorMessage="This field is required." resourcekey="rfvImageCarouselImageWidthResource1.ErrorMessage"
																	SetFocusOnError="True" ValidationGroup="vgVerticalCarouselSettings"></asp:RequiredFieldValidator>
																<asp:CompareValidator ID="cvImageCarouselImageWidth9" runat="server" ControlToValidate="tbImageSliderTooltipHideDuration" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" resourcekey="cvImageCarouselImageWidthResource1.ErrorMessage"
																	SetFocusOnError="True" Type="Integer" ValidationGroup="vgVerticalCarouselSettings">
																</asp:CompareValidator>
															</td>
														</tr>
														<tr>
															<td>
																<asp:Label ID="lblImageSliderTooltipBorder" runat="server" resourcekey="lblLightboxTooltipBorder" Text="Border:"></asp:Label>
															</td>
															<td>
																<asp:TextBox ID="tbImageSliderTooltipBorder" runat="server" Width="53px">5</asp:TextBox>
																&nbsp;<asp:RequiredFieldValidator ID="rfvImageCarouselImageWidth10" runat="server" ControlToValidate="tbImageSliderTooltipBorder" Display="Dynamic" ErrorMessage="This field is required." resourcekey="rfvImageCarouselImageWidthResource1.ErrorMessage" SetFocusOnError="True"
																	ValidationGroup="vgVerticalCarouselSettings"></asp:RequiredFieldValidator>
																<asp:CompareValidator ID="cvImageCarouselImageWidth10" runat="server" ControlToValidate="tbImageSliderTooltipBorder" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" resourcekey="cvImageCarouselImageWidthResource1.ErrorMessage"
																	SetFocusOnError="True" Type="Integer" ValidationGroup="vgVerticalCarouselSettings">
																</asp:CompareValidator>
															</td>
														</tr>
														<tr>
															<td>
																<asp:Label ID="lblImageSliderTooltipCornerRadius" runat="server" resourcekey="lblLightboxTooltipCornerRadius" Text="Corner radius:"></asp:Label>
															</td>
															<td>
																<asp:TextBox ID="tbImageSliderTooltipCornerRadius" runat="server" Width="53px">5</asp:TextBox>
																&nbsp;<asp:RequiredFieldValidator ID="rfvImageCarouselImageWidth11" runat="server" ControlToValidate="tbImageSliderTooltipCornerRadius" Display="Dynamic" ErrorMessage="This field is required." resourcekey="rfvImageCarouselImageWidthResource1.ErrorMessage"
																	SetFocusOnError="True" ValidationGroup="vgVerticalCarouselSettings"></asp:RequiredFieldValidator>
																<asp:CompareValidator ID="cvImageCarouselImageWidth11" runat="server" ControlToValidate="tbImageSliderTooltipCornerRadius" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" resourcekey="cvImageCarouselImageWidthResource1.ErrorMessage"
																	SetFocusOnError="True" Type="Integer" ValidationGroup="vgVerticalCarouselSettings">
																</asp:CompareValidator>
															</td>
														</tr>
														<tr>
															<td>
																<asp:Label ID="lblImageSliderTooltipTheme" runat="server" resourcekey="lblLightboxTooltipTheme" Text="Select theme:"></asp:Label>
															</td>
															<td>
																<asp:DropDownList ID="ddlImageSliderTooltipTheme" runat="server">
																	<asp:ListItem resourcekey="cream" Value="cream">Yellow</asp:ListItem>
																	<asp:ListItem resourcekey="dark" Value="dark">Dark</asp:ListItem>
																	<asp:ListItem resourcekey="green" Value="green">Green</asp:ListItem>
																	<asp:ListItem resourcekey="light" Value="light">Light</asp:ListItem>
																	<asp:ListItem resourcekey="red" Value="red">Red</asp:ListItem>
																	<asp:ListItem resourcekey="blue" Value="blue">Blue</asp:ListItem>
																</asp:DropDownList>
															</td>
														</tr>
													</table>
												</asp:Panel>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblImageSliderOpenMediaUrl" ResourceKey="lblImageSliderOpenMediaUrl" runat="server" HelpText="On image click dont open image in lightbox, but open Media Url link." Text="On click go to Media Url:" HelpKey="lblImageSliderOpenMediaUrl.HelpText" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbImageSliderOpenMediaUrl" runat="server" AutoPostBack="True" OnCheckedChanged="cbImageSliderOpenMediaUrl_CheckedChanged" resourcekey="cbImageSliderOpenMediaUrlResource1" Text="On click go to Media Url" />
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblImageSliderOpenMediaUrlNewWindow" ResourceKey="lblImageSliderOpenMediaUrlNewWindow" runat="server" HelpText="Open link in new window:" Text="Open link in new window:" HelpKey="lblImageSliderOpenMediaUrlNewWindow.HelpText" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbImageSliderOpenMediaUrlNewWindow" runat="server" Enabled="False" resourcekey="cbImageSliderOpenMediaUrlNewWindowResource1" Text="Open link in new window" />
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblImageSliderMaxImageWidth" ResourceKey="lblImageSliderMaxImageWidth" runat="server" ControlName="tbMaxImageWidth" HelpText="Maximum  image width for proportional resizing:" Text="Maximum image width:" HelpKey="lblImageSliderMaxImageWidth.HelpText" />
											</td>
											<td>
												<asp:TextBox ID="tbImageSliderMaxImageWidth" runat="server" ValidationGroup="vgImageSliderSettings" CssClass="small textCenter">600</asp:TextBox>
												<asp:Label ID="lblImageSliderPercentageW" runat="server" Text="px"></asp:Label>
												<asp:RequiredFieldValidator ID="rfvImageSliderImageWidth" runat="server" ControlToValidate="tbImageSliderMaxImageWidth" Display="Dynamic" ErrorMessage="This field is required." ValidationGroup="vgImageSliderSettings" resourcekey="rfvImageSliderImageWidthResource1.ErrorMessage" CssClass="smallInfo warning"></asp:RequiredFieldValidator>
												<asp:CompareValidator ID="cvImageSliderImageWidth" runat="server" ControlToValidate="tbImageSliderMaxImageWidth" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" Type="Integer" ValidationGroup="vgImageSliderSettings" resourcekey="cvImageSliderImageWidthResource1" CssClass="smallInfo warning"></asp:CompareValidator>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblImageSliderMaxImageHeight" ResourceKey="lblImageSliderMaxImageHeight" runat="server" ControlName="tbMaxImageHeight" HelpText="Maximum  image width for proportional resizing:" Text="Maximum image height:" HelpKey="lblImageSliderMaxImageHeight.HelpText" />
											</td>
											<td>
												<asp:TextBox ID="tbImageSliderMaxImageHeight" runat="server" ValidationGroup="vgImageSliderSettings" CssClass="small textCenter">400</asp:TextBox>
												<asp:RequiredFieldValidator ID="rfvImageSliderImageHeight" runat="server" ControlToValidate="tbImageSliderMaxImageHeight" Display="Dynamic" ErrorMessage="This field is required." ValidationGroup="vgImageSliderSettings" resourcekey="rfvImageSliderImageHeightResource1.ErrorMessage" CssClass="smallInfo warning"></asp:RequiredFieldValidator>
												<asp:CompareValidator ID="cvImageSliderImageHeight" runat="server" ControlToValidate="tbImageSliderMaxImageHeight" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" Type="Integer" ValidationGroup="vgImageSliderSettings" resourcekey="cvImageSliderImageHeightResource1.ErrorMessage" CssClass="smallInfo warning"></asp:CompareValidator>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblImageSliderTransitionEffect" ResourceKey="lblImageSliderTransitionEffect" runat="server" ControlName="tbMaxImageHeight" HelpText="Select transition effect:" Text="Select transition effect:" HelpKey="lblImageSliderTransitionEffect.HelpText" />
											</td>
											<td>
												<div class="styledSelect">
													<asp:DropDownList ID="ddlImageSliderTransitionEffect" runat="server">
														<asp:ListItem Value="random" resourcekey="ListItemResource16">Random</asp:ListItem>
														<asp:ListItem Value="sliceDown" resourcekey="ListItemResource17">Slice down</asp:ListItem>
														<asp:ListItem Value="sliceDownLeft" resourcekey="ListItemResource18">Slice down left</asp:ListItem>
														<asp:ListItem Value="sliceUp" resourcekey="ListItemResource19">Slice up</asp:ListItem>
														<asp:ListItem Value="sliceUpLeft" resourcekey="ListItemResource20">Slice up left</asp:ListItem>
														<asp:ListItem Value="sliceUpDown" resourcekey="ListItemResource21">Slice up down</asp:ListItem>
														<asp:ListItem Value="sliceUpDownLeft" resourcekey="ListItemResource22">Slice up down left</asp:ListItem>
														<asp:ListItem Value="fold" resourcekey="ListItemResource23">Fold</asp:ListItem>
														<asp:ListItem Value="fade" resourcekey="ListItemResource24">Fade</asp:ListItem>
														<asp:ListItem Value="sliceDownRight" resourcekey="sliceDownRight">Slice down right</asp:ListItem>
														<asp:ListItem Value="sliceUpRight" resourcekey="sliceUpRight">Slice up right</asp:ListItem>
														<asp:ListItem Value="boxRandom" resourcekey="boxRandom">Random box</asp:ListItem>
														<asp:ListItem Value="boxRain" resourcekey="boxRain">Rain box</asp:ListItem>
														<asp:ListItem Value="boxRainReverse" resourcekey="boxRainReverse">Rain box reverse</asp:ListItem>
														<asp:ListItem Value="boxRainGrow" resourcekey="boxRainGrow">Rain box grow</asp:ListItem>
														<asp:ListItem Value="boxRainGrowReverse" resourcekey="boxRainGrowReverse">Rain box grow reverse</asp:ListItem>
													</asp:DropDownList>
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblImageSliderAutoSlidePause" ResourceKey="lblImageSliderAutoSlidePause" runat="server" HelpText="Set the pause between images when in auto slide mode:" Text="Auto slide pause between imags (ms): " HelpKey="lblImageSliderAutoSlidePause.HelpText" />
											</td>
											<td>
												<asp:Panel ID="pnlSlideOpt0" runat="server">
													<asp:TextBox ID="tbImageSliderAutoSlidePause" runat="server" ValidationGroup="vgImageSliderSettings" CssClass="small textCenter">5000</asp:TextBox>
													<asp:RequiredFieldValidator ID="rfvSSWidth1" runat="server" ControlToValidate="tbImageSliderAutoSlidePause" Display="Dynamic" ErrorMessage="This field is required." ValidationGroup="vgImageSliderSettings" resourcekey="rfvSSWidth1Resource1.ErrorMessage" CssClass="smallInfo warning"></asp:RequiredFieldValidator>
													<asp:CompareValidator ID="cvImageSliderImageHeight0" runat="server" ControlToValidate="tbImageSliderAutoSlidePause" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" resourcekey="cvImageSliderImageHeightResource1.ErrorMessage" Type="Integer" ValidationGroup="vgImageSliderSettings" CssClass="smallInfo warning"></asp:CompareValidator>
												</asp:Panel>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblImageSliderTransitionSpeed" ResourceKey="lblImageSliderTransitionSpeed" runat="server" HelpText="Slide transition speed (ms):" Text="Slide transition speed (ms):" HelpKey="lblImageSliderTransitionSpeed.HelpText" />
											</td>
											<td>
												<asp:TextBox ID="tbImageSliderAutoSlideTransition" runat="server" ValidationGroup="vgImageSliderSettings" CssClass="small textCenter">500</asp:TextBox>
												<asp:RequiredFieldValidator ID="rfvImageSliderTransitionSpeed" runat="server" ControlToValidate="tbImageSliderAutoSlideTransition" Display="Dynamic" ErrorMessage="This field is required." ValidationGroup="vgImageSliderSettings" resourcekey="rfvImageSliderTransitionSpeedResource1.ErrorMessage" CssClass="smallInfo warning"></asp:RequiredFieldValidator>
												<asp:CompareValidator ID="cvImageSliderImageHeight1" runat="server" ControlToValidate="tbImageSliderAutoSlideTransition" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" resourcekey="cvImageSliderImageHeightResource1.ErrorMessage" Type="Integer" ValidationGroup="vgImageSliderSettings" CssClass="smallInfo warning"></asp:CompareValidator>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblImageSliderStartRandom" ResourceKey="lblImageSliderStartRandom" runat="server" ControlName="cbSSStartRandom" HelpText="Set this if you want the auto slide mode to start with random image:" Text="Start slide show with random image:" HelpKey="lblImageSliderStartRandom.HelpText" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbImageSliderStartRandom" runat="server" resourcekey="cbImageSliderStartRandomResource1" Text="Start slide show with random image" />
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblImageSliderShowPaging" ResourceKey="lblImageSliderShowPaging" runat="server" HelpText="Show paging:" Text="Show paging:" HelpKey="lblImageSliderShowPaging.HelpText" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbImageSliderShowPaging" runat="server" resourcekey="cbImageSliderShowPagingResource1" Text="Show paging" />
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblImageSliderRandomizeMedia" runat="server" HelpText="Randomize media positions at every page load:" Text="Randomize media positions:" HelpKey="lblImageSliderRandomizeMedia.HelpText" ResourceKey="lblImageSliderRandomizeMedia" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbImageSliderRandomizeMedia" runat="server" resourcekey="cbImageSliderShowPagingResource1" AutoPostBack="True" OnCheckedChanged="cbImageSliderRandomizeMedia_CheckedChanged" Text="Randomize media positions" />
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="Label7" runat="server" HelpText="Select media sorting options:" Text="Media sorting:" HelpKey="lblLightBoxMediaSorting.HelpText" ResourceKey="lblLightBoxMediaSorting" />
											</td>
											<td>
												<table class="clearWidth textLeft">
													<tr>
														<td>
															<div class="styledSelect">
																<asp:DropDownList ID="ddlImageSliderMediaSort" runat="server">
																	<asp:ListItem resourcekey="liPosition" Value="Position">Position</asp:ListItem>
																	<asp:ListItem resourcekey="liDateUploaded" Value="DateUploaded">Date uploaded</asp:ListItem>
																	<asp:ListItem resourcekey="liFileName" Value="FileName">Filename</asp:ListItem>
																	<asp:ListItem resourcekey="liTitle">Title</asp:ListItem>
																</asp:DropDownList>
															</div>
														</td>
														<td>&nbsp;</td>
														<td>
															<asp:RadioButtonList ID="rblImageSliderMediaSortType" runat="server" RepeatDirection="Horizontal" CssClass="styledRadio small">
																<asp:ListItem resourcekey="liAscending" Selected="True" Value="ASC">Ascending</asp:ListItem>
																<asp:ListItem resourcekey="liDescending" Value="DESC">Descending</asp:ListItem>
															</asp:RadioButtonList>
														</td>
													</tr>
												</table>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblImageSliderSelectTheme" runat="server" HelpKey="lblImageSliderSelectTheme.HelpText" HelpText="Select the CSS theme file:" ResourceKey="lblImageSliderSelectTheme" Text="Select the CSS theme file:" Visible="False" />
											</td>
											<td>
												<div class="styledSelect">
													<asp:DropDownList ID="ddlImageSliderThemeSelect" runat="server" Visible="False"></asp:DropDownList>
												</div>
											</td>
										</tr>
									</table>
									<asp:Label ID="lblImageSliderStatus" runat="server" EnableViewState="False"></asp:Label>
									<div class="mainActions">
										<asp:LinkButton ID="btnImageSliderSaveSettings" runat="server" OnClick="btnImageSliderSaveSettings_Click" Text="Save settings" ValidationGroup="vgImageSliderSettings" resourcekey="btnImageSliderSaveSettingsResource1" CssClass="downSave" />
										<asp:LinkButton ID="btnImageSliderSaveClose" runat="server" OnClick="btnImageSliderSaveClose_Click" Text="Save &amp; Close" ValidationGroup="vgImageSliderSettings" resourcekey="btnImageSliderSaveCloseResource1" CssClass="downSaveClose" />
									</div>
								</div>
							</asp:Panel>
							<asp:Panel ID="pnlImageCarousel" runat="server" Visible="False" CssClass="settingsList negativeMargins40">
								<h3>
									<asp:Label ID="lblImageCarouselDisplaySettings" runat="server" CssClass="settingsdetailtitle" Text="Image carousel display settings" resourcekey="lblImageCarouselDisplaySettingsResource1"></asp:Label>
								</h3>
								<div class="settingsTable">
									<table>
										<tr>
											<td>
												<dnn:Label ID="lblImageCarouselTemplateSelect" runat="server" ControlName="ddlSSThemeSelect" HelpKey="lblImageCarouselTemplateSelect.HelpText" HelpText="Select the control viewer template:" ResourceKey="lblImageCarouselTemplateSelect" Text="Select template:" />
											</td>
											<td>
												<div class="styledSelect">
													<asp:DropDownList ID="ddlICTemplateSelect" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlICTemplateSelect_SelectedIndexChanged"></asp:DropDownList>
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblImageCarouselThemeSelect" runat="server" ControlName="ddlSSThemeSelect" HelpKey="lblImageCarouselThemeSelect.HelpText" HelpText="Select the CSS theme file:" ResourceKey="lblImageCarouselThemeSelect" Text="Select CSS:" />
											</td>
											<td>
												<div class="styledSelect">
													<asp:DropDownList ID="ddlICThemeSelect" runat="server"></asp:DropDownList>
												</div>
												<asp:Label ID="lblImageCarouselTemplateInfo" runat="server"></asp:Label>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblImageCarouselResponsive" runat="server" HelpText="Select the layout type:" Text="Select the layout type:" HelpKey="lblChameleonSelectLayoutType.HelpText" ResourceKey="lblChameleonSelectLayoutType" />
											</td>
											<td>
												<asp:RadioButtonList ID="rblImageCarouselResponsive" runat="server" RepeatDirection="Horizontal" CssClass="styledRadio">
													<asp:ListItem resourcekey="liResponsive" Value="responsive">Responsive Layout</asp:ListItem>
													<asp:ListItem resourcekey="liFixed" Selected="True" Value="fixed">Fixed Layout</asp:ListItem>
												</asp:RadioButtonList>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblImageCarouselShowTitle" runat="server" HelpKey="lblImageCarouselShowTitle.HelpText" HelpText="Show gallery title:" ResourceKey="lblImageCarouselShowTitle" Text="Show gallery title:" Visible="True" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbImageCarouselShowTitle" runat="server" resourcekey="cbImageCarouselShowTitleResource1" Text="Show gallery title" />
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblImageCarouselShowDescription" runat="server" HelpKey="lblImageCarouselShowDescription.HelpText" HelpText="Show gallery description:" ResourceKey="lblImageCarouselShowDescription" Text="Show gallery description:" Visible="True" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbImageCarouselShowDescription" runat="server" resourcekey="cbImageCarouselShowDescriptionResource1" Text="Show gallery description" />
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblImageCarouselShowMediaTitle" ResourceKey="lblImageCarouselShowMediaTitle" runat="server" HelpText="Show image title:" Text="Show image title:" HelpKey="lblImageCarouselShowMediaTitle.HelpText" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbImageCarouselShowMediaTitle" runat="server" resourcekey="cbImageCarouselShowMediaTitleResource1" Text="Show image title" />
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblImageCarouselShowMediaDescription" ResourceKey="lblImageCarouselShowMediaDescription" runat="server" HelpText="Show image description:" Text="Show image description:" HelpKey="lblImageCarouselShowMediaDescription.HelpText" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbImageCarouselShowMediaDescription" runat="server" resourcekey="cbImageCarouselShowMediaDescriptionResource1" Text="Show image description" />
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblImageCarouselShowLightboxTitle" ResourceKey="lblImageCarouselShowLightboxTitle" runat="server" HelpText="Show image title in lightbox:" Text="Show image title in lightbox:" HelpKey="lblImageCarouselShowLightboxTitle.HelpText" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbImageCarouselShowLightboxTitle" runat="server" resourcekey="cbImageCarouselShowLightboxTitleResource1" Text="Show image title in lightbox" />
												</div>
											</td>
										</tr>
										<tr>
											<td valign="top">
												<dnn:Label ID="lblImageCarouselShowLightBoxDescription" ResourceKey="lblImageCarouselShowLightBoxDescription" runat="server" HelpText="Show image description in lightbox:" Text="Show image description in lightbox:" HelpKey="lblImageCarouselShowLightBoxDescription.HelpText" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbImageCarouselShowLightboxDescription" runat="server" resourcekey="cbImageCarouselShowLightboxDescriptionResource1" AutoPostBack="True" OnCheckedChanged="cbImageCarouselShowLightboxDescription_CheckedChanged1" Text="Show image description in lightbox" />
												</div>
												<asp:Panel ID="pnlImageCarouselTipOptions" runat="server" BackColor="#CBEEF8" BorderColor="#65CDEB" BorderStyle="Solid" BorderWidth="2px" Visible="False">
													<table>
														<tr>
															<td colspan="2">
																<asp:Label ID="lblImageCarouselToolTipOptions" runat="server" Font-Bold="True" resourcekey="lblLightBoxToolTipOptions" Text="Tooltip options"></asp:Label>
															</td>
														</tr>
														<tr>
															<td>
																<asp:Label ID="lblImageSliderShowToolTips" runat="server" resourcekey="lblLightboxShowToolTips" Text="Show Tooltips:"></asp:Label>
															</td>
															<td>
																<asp:CheckBox ID="cbImageCarouselShowTooltips" runat="server" />
															</td>
														</tr>
														<tr>
															<td>
																<asp:Label ID="lblImageCarouselTargetPosition" runat="server" resourcekey="lblLightboxTargetPosition" Text="Target position:"></asp:Label>
															</td>
															<td>
																<asp:DropDownList ID="ddlImageCarouselTargetPosition" runat="server">
																	<asp:ListItem resourcekey="topLeft" Value="topLeft">Top left</asp:ListItem>
																	<asp:ListItem resourcekey="topMiddle" Value="topMiddle" Selected="True">Top middle</asp:ListItem>
																	<asp:ListItem resourcekey="topRight" Value="topRight">Top right</asp:ListItem>
																	<asp:ListItem resourcekey="leftTop" Value="leftTop">Left top</asp:ListItem>
																	<asp:ListItem resourcekey="leftMiddle" Value="leftMiddle">Left middle</asp:ListItem>
																	<asp:ListItem resourcekey="leftBottom" Value="leftBottom">Left bottom</asp:ListItem>
																	<asp:ListItem resourcekey="center" Value="center">Center</asp:ListItem>
																	<asp:ListItem resourcekey="rightTop" Value="rightTop">Right top</asp:ListItem>
																	<asp:ListItem resourcekey="rightMiddle" Value="rightMiddle">Right middle</asp:ListItem>
																	<asp:ListItem resourcekey="rightBottom" Value="rightBottom">Right bottom</asp:ListItem>
																	<asp:ListItem resourcekey="bottomLeft" Value="bottomLeft">Bottom left</asp:ListItem>
																	<asp:ListItem resourcekey="bottomMiddle" Value="bottomMiddle">Bottom middle</asp:ListItem>
																	<asp:ListItem resourcekey="bottomRight" Value="bottomRight">Bottom right</asp:ListItem>
																</asp:DropDownList>
															</td>
														</tr>
														<tr>
															<td>
																<asp:Label ID="lblImageCarouselTooltipPosition" runat="server" resourcekey="lblLightboxTooltipPosition" Text="Tooltip position:"></asp:Label>
															</td>
															<td>
																<asp:DropDownList ID="ddlImageCarouselTooltipPosition" runat="server">
																	<asp:ListItem resourcekey="topLeft" Value="topLeft">Top left</asp:ListItem>
																	<asp:ListItem resourcekey="topMiddle" Value="topMiddle">Top middle</asp:ListItem>
																	<asp:ListItem resourcekey="topRight" Value="topRight">Top right</asp:ListItem>
																	<asp:ListItem resourcekey="leftTop" Value="leftTop">Left top</asp:ListItem>
																	<asp:ListItem resourcekey="leftMiddle" Value="leftMiddle">Left middle</asp:ListItem>
																	<asp:ListItem resourcekey="leftBottom" Value="leftBottom">Left bottom</asp:ListItem>
																	<asp:ListItem resourcekey="center" Value="center">Center</asp:ListItem>
																	<asp:ListItem resourcekey="rightTop" Value="rightTop">Right top</asp:ListItem>
																	<asp:ListItem resourcekey="rightMiddle" Value="rightMiddle">Right middle</asp:ListItem>
																	<asp:ListItem resourcekey="rightBottom" Value="rightBottom">Right bottom</asp:ListItem>
																	<asp:ListItem resourcekey="bottomLeft" Value="bottomLeft">Bottom left</asp:ListItem>
																	<asp:ListItem resourcekey="bottomMiddle" Selected="True" Value="bottomMiddle">Bottom
															middle</asp:ListItem>
																	<asp:ListItem resourcekey="bottomRight" Value="bottomRight">Bottom right</asp:ListItem>
																</asp:DropDownList>
															</td>
														</tr>
														<tr>
															<td>
																<asp:Label ID="lblImageCarouselShowEffect" runat="server" resourcekey="lblLightboxShowEffect" Text="Show effect:"></asp:Label>
															</td>
															<td>
																<asp:DropDownList ID="ddlImageCarouselShoweffect" runat="server">
																	<asp:ListItem resourcekey="fade" Value="fade">Fade</asp:ListItem>
																	<asp:ListItem resourcekey="slide" Value="slide">Slide</asp:ListItem>
																	<asp:ListItem resourcekey="grow" Value="grow">Grow</asp:ListItem>
																</asp:DropDownList>
															</td>
														</tr>
														<tr>
															<td>
																<asp:Label ID="lblImageCarouselShowEffectDuration" runat="server" resourcekey="lblLightboxShowEffectDuration" Text="Show effect duration (ms):"></asp:Label>
															</td>
															<td>
																<asp:TextBox ID="tbImageCarouselTooltipShowDuration" runat="server" Width="53px">500</asp:TextBox>
																<asp:RequiredFieldValidator ID="rfvImageCarouselImageWidth0" runat="server" ControlToValidate="tbImageCarouselTooltipShowDuration" Display="Dynamic" ErrorMessage="This field is required." resourcekey="rfvImageCarouselImageWidthResource1.ErrorMessage"
																	SetFocusOnError="True" ValidationGroup="vgImageCarouselSettings">
																</asp:RequiredFieldValidator>
																<asp:CompareValidator ID="cvImageCarouselImageWidth0" runat="server" ControlToValidate="tbImageCarouselTooltipShowDuration" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" resourcekey="cvImageCarouselImageWidthResource1.ErrorMessage"
																	SetFocusOnError="True" Type="Integer" ValidationGroup="vgImageCarouselSettings">
																</asp:CompareValidator>
															</td>
														</tr>
														<tr>
															<td>
																<asp:Label ID="lblImageCarouselShowHideEffect" runat="server" resourcekey="lblLightboxShowHideEffect" Text="Hide effect:"></asp:Label>
															</td>
															<td>
																<asp:DropDownList ID="ddlImageCarouselHideEffect" runat="server">
																	<asp:ListItem resourcekey="fade" Value="fade">Fade</asp:ListItem>
																	<asp:ListItem resourcekey="slide" Value="slide">Slide</asp:ListItem>
																	<asp:ListItem resourcekey="grow" Value="grow">Grow</asp:ListItem>
																</asp:DropDownList>
															</td>
														</tr>
														<tr>
															<td>
																<asp:Label ID="lblImageCarouselHideEffectDuration" runat="server" resourcekey="lblLightboxHideEffectDuration" Text="Hide effect duration (ms):"></asp:Label>
															</td>
															<td>
																<asp:TextBox ID="tbImageCarouselTooltipHideDuration" runat="server" Width="53px">500</asp:TextBox>
																<asp:RequiredFieldValidator ID="rfvImageCarouselImageWidth1" runat="server" ControlToValidate="tbImageCarouselTooltipHideDuration" Display="Dynamic" ErrorMessage="This field is required." resourcekey="rfvImageCarouselImageWidthResource1.ErrorMessage"
																	SetFocusOnError="True" ValidationGroup="vgImageCarouselSettings">
																</asp:RequiredFieldValidator>
																<asp:CompareValidator ID="cvImageCarouselImageWidth1" runat="server" ControlToValidate="tbImageCarouselTooltipHideDuration" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" resourcekey="cvImageCarouselImageWidthResource1.ErrorMessage"
																	SetFocusOnError="True" Type="Integer" ValidationGroup="vgImageCarouselSettings">
																</asp:CompareValidator>
															</td>
														</tr>
														<tr>
															<td>
																<asp:Label ID="lblImageCarouselTooltipBorder" runat="server" resourcekey="lblLightboxTooltipBorder" Text="Border:"></asp:Label>
															</td>
															<td>
																<asp:TextBox ID="tbImageCarouselTooltipBorder" runat="server" Width="53px">5</asp:TextBox>
																<asp:RequiredFieldValidator ID="rfvImageCarouselImageWidth2" runat="server" ControlToValidate="tbImageCarouselTooltipBorder" Display="Dynamic" ErrorMessage="This field is required." resourcekey="rfvImageCarouselImageWidthResource1.ErrorMessage" SetFocusOnError="True"
																	ValidationGroup="vgImageCarouselSettings">
																</asp:RequiredFieldValidator>
																<asp:CompareValidator ID="cvImageCarouselImageWidth2" runat="server" ControlToValidate="tbImageCarouselTooltipBorder" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" resourcekey="cvImageCarouselImageWidthResource1.ErrorMessage"
																	SetFocusOnError="True" Type="Integer" ValidationGroup="vgImageCarouselSettings">
																</asp:CompareValidator>
															</td>
														</tr>
														<tr>
															<td>
																<asp:Label ID="lblImageCarouselTooltipCornerRadius" runat="server" resourcekey="lblLightboxTooltipCornerRadius" Text="Corner radius:"></asp:Label>
															</td>
															<td>
																<asp:TextBox ID="tbImageCarouselTooltipCornerRadius" runat="server" Width="53px">5</asp:TextBox>
																<asp:RequiredFieldValidator ID="rfvImageCarouselImageWidth3" runat="server" ControlToValidate="tbImageCarouselTooltipCornerRadius" Display="Dynamic" ErrorMessage="This field is required." resourcekey="rfvImageCarouselImageWidthResource1.ErrorMessage"
																	SetFocusOnError="True" ValidationGroup="vgImageCarouselSettings">
																</asp:RequiredFieldValidator>
																<asp:CompareValidator ID="cvImageCarouselImageWidth3" runat="server" ControlToValidate="tbImageCarouselTooltipCornerRadius" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" resourcekey="cvImageCarouselImageWidthResource1.ErrorMessage"
																	SetFocusOnError="True" Type="Integer" ValidationGroup="vgImageCarouselSettings">
																</asp:CompareValidator>
															</td>
														</tr>
														<tr>
															<td>
																<asp:Label ID="lblImageCarouselTooltipTheme" runat="server" resourcekey="lblLightboxTooltipTheme" Text="Select theme:"></asp:Label>
															</td>
															<td>
																<asp:DropDownList ID="ddlImageCarouselTooltipTheme" runat="server">
																	<asp:ListItem resourcekey="cream" Value="cream">Yellow</asp:ListItem>
																	<asp:ListItem resourcekey="dark" Value="dark">Dark</asp:ListItem>
																	<asp:ListItem resourcekey="green" Value="green">Green</asp:ListItem>
																	<asp:ListItem resourcekey="light" Value="light">Light</asp:ListItem>
																	<asp:ListItem resourcekey="red" Value="red">Red</asp:ListItem>
																	<asp:ListItem resourcekey="blue" Value="blue">Blue</asp:ListItem>
																</asp:DropDownList>
															</td>
														</tr>
													</table>
												</asp:Panel>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblImageCarouselOpenMediaUrl" ResourceKey="lblImageCarouselOpenMediaUrl" runat="server" HelpText="On image click dont open image in lightbox, but open Media Url link." Text="On click go to Media Url:" HelpKey="lblImageCarouselOpenMediaUrl.HelpText" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbImageCarouselOpenMediaUrl" runat="server" AutoPostBack="True" OnCheckedChanged="cbImageCarouselOpenMediaUrl_CheckedChanged" resourcekey="cbImageCarouselOpenMediaUrlResource1" Text="On click go to Media Url" />
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblImageCarouselOpenMediaUrlNewWindow" ResourceKey="lblImageCarouselOpenMediaUrlNewWindow" runat="server" HelpText="Open link in new window:" Text="Open link in new window:" HelpKey="lblImageCarouselOpenMediaUrlNewWindow.HelpText" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbImageCarouselOpenMediaUrlNewWindow" runat="server" Enabled="False" resourcekey="cbImageCarouselOpenMediaUrlNewWindowResource1" Text="Open link in new window" />
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblImageCarouselMaxImageWidth" ResourceKey="lblImageCarouselMaxImageWidth" runat="server" ControlName="tbMaxImageWidth" HelpText="Maximum  image width for proportional resizing:" Text="Maximum image width:" HelpKey="lblImageCarouselMaxImageWidth.HelpText" />
											</td>
											<td>
												<asp:TextBox ID="tbImageCarouselMaxImageWidth" runat="server" ValidationGroup="vgImageSliderSettings" CssClass="small textCenter">150</asp:TextBox>
												<asp:RequiredFieldValidator ID="rfvImageCarouselImageWidth" runat="server" ControlToValidate="tbImageCarouselMaxImageWidth" Display="Dynamic" ErrorMessage="This field is required." ValidationGroup="vgImageCarouselSettings" resourcekey="rfvImageCarouselImageWidthResource1.ErrorMessage" CssClass="smallInfo warning"></asp:RequiredFieldValidator>
												<asp:CompareValidator ID="cvImageCarouselImageWidth" runat="server" ControlToValidate="tbImageCarouselMaxImageWidth" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" Type="Integer" ValidationGroup="vgImageCarouselSettings" resourcekey="cvImageCarouselImageWidthResource1.ErrorMessage" CssClass="smallInfo warning"></asp:CompareValidator>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblImageCarouselMaxImageHeight" ResourceKey="lblImageCarouselMaxImageHeight" runat="server" ControlName="tbMaxImageHeight" HelpText="Maximum  image width for proportional resizing:" Text="Maximum image height:" HelpKey="lblImageCarouselMaxImageHeight.HelpText" />
											</td>
											<td>
												<asp:TextBox ID="tbImageCaruselMaxImageHeight" runat="server" ValidationGroup="vgImageSliderSettings" CssClass="small textCenter">150</asp:TextBox>
												<asp:RequiredFieldValidator ID="rfvImageCarouselImageHeight" runat="server" ControlToValidate="tbImageCaruselMaxImageHeight" Display="Dynamic" ErrorMessage="This field is required." ValidationGroup="vgImageCarouselSettings" resourcekey="rfvImageCarouselImageHeightResource1.ErrorMessage" CssClass="smallInfo warning"></asp:RequiredFieldValidator>
												<asp:CompareValidator ID="cvImageCarouselImageHeight" runat="server" ControlToValidate="tbImageCaruselMaxImageHeight" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" Type="Integer" ValidationGroup="vgImageCarouselSettings" resourcekey="cvImageCarouselImageHeightResource1.ErrorMessage" CssClass="smallInfo warning"></asp:CompareValidator>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblImageCarouselAutoSlideImages" ResourceKey="lblImageCarouselAutoSlideImages" runat="server" HelpText="Auto slide images:" Text="Auto slide images:" HelpKey="lblImageCarouselAutoSlideImages.HelpText" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbImageCarouselAuoSlideImages" runat="server" resourcekey="cbImageCarouselAuoSlideImagesResource1" Text="Auto slide images" />
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblImageCarouselAutoSlidePause" ResourceKey="lblImageCarouselAutoSlidePause" runat="server" ControlName="tbAutoSlidePause" HelpText="Set the pause between images when in auto slide mode:" Text="Auto slide pause between imags (ms): " HelpKey="lblImageCarouselAutoSlidePause.HelpText" />
											</td>
											<td>
												<asp:Panel ID="pnlSlideOpt1" runat="server">
													<asp:TextBox ID="tbImageCarouselAutoSlidePause" runat="server" ValidationGroup="vgImageCarouselSettings" CssClass="small textCenter">5000</asp:TextBox>
													<asp:RequiredFieldValidator ID="rfvImageCarouselAutoSlidePause" runat="server" ControlToValidate="tbImageCarouselAutoSlidePause" Display="Dynamic" ErrorMessage="This field is required." ValidationGroup="vgImageCarouselSettings" resourcekey="rfvImageCarouselAutoSlidePauseResource1.ErrorMessage" CssClass="smallInfo warning"></asp:RequiredFieldValidator>
													<asp:CompareValidator ID="cvImageCarouselAutoSlidePause" runat="server" ControlToValidate="tbImageCarouselAutoSlidePause" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" Type="Integer" ValidationGroup="vgImageCarouselSettings" resourcekey="cvImageCarouselAutoSlidePauseResource1.ErrorMessage" CssClass="smallInfo warning"></asp:CompareValidator>
												</asp:Panel>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblImageCarouselNumberOfImages" ResourceKey="lblImageCarouselNumberOfImages" runat="server" ControlName="tbAutoSlidePause" HelpText="Number of images to show:" Text="Number of images to show:" HelpKey="lblImageCarouselNumberOfImages.HelpText" />
											</td>
											<td>
												<asp:TextBox ID="tbImageCarouselNumberOfImages" runat="server" ValidationGroup="vgImageCarouselSettings" CssClass="small textCenter">4</asp:TextBox>
												<asp:RequiredFieldValidator ID="rfvImageCarouselNumberOfImages" runat="server" ControlToValidate="tbImageCarouselNumberOfImages" Display="Dynamic" ErrorMessage="This field is required." ValidationGroup="vgImageCarouselSettings" resourcekey="rfvImageCarouselNumberOfImagesResource1.ErrorMessage" CssClass="smallInfo warning"></asp:RequiredFieldValidator>
												<asp:CompareValidator ID="cvImageCarouselNumberOfImages" runat="server" ControlToValidate="tbImageCarouselNumberOfImages" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" Type="Integer" ValidationGroup="vgImageCarouselSettings" resourcekey="cvImageCarouselNumberOfImagesResource1.ErrorMessage" CssClass="smallInfo warning"></asp:CompareValidator>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblImageCarouselNumberOfImagesToSlide" ResourceKey="lblImageCarouselNumberOfImagesToSlide" runat="server" ControlName="tbAutoSlidePause" HelpText="Number of images to slide:" Text="Number of images to slide:" HelpKey="lblImageCarouselNumberOfImagesToSlide.HelpText" />
											</td>
											<td>
												<asp:TextBox ID="tbImageCarouselNumberOfImagesSlide" runat="server" ValidationGroup="vgImageCarouselSettings" CssClass="small textCenter">1</asp:TextBox>
												<asp:RequiredFieldValidator ID="rfvImageCarouselNumberOfImagesToSlide" runat="server" ControlToValidate="tbImageCarouselNumberOfImagesSlide" Display="Dynamic" ErrorMessage="This field is required." ValidationGroup="vgImageCarouselSettings" resourcekey="rfvImageCarouselNumberOfImagesToSlideResource1.ErrorMessage" CssClass="smallInfo warning"></asp:RequiredFieldValidator>
												<asp:CompareValidator ID="cvImageCarouselNumberOfImagesToSlide" runat="server" ControlToValidate="tbImageCarouselNumberOfImagesSlide" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" Type="Integer" ValidationGroup="vgImageCarouselSettings" resourcekey="cvImageCarouselNumberOfImagesToSlideResource1.ErrorMessage" CssClass="smallInfo warning"></asp:CompareValidator>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblImageCarouselShowNavigation" ResourceKey="lblImageCarouselShowNavigation" runat="server" HelpText="Show navigation:" Text="Show navigation:" HelpKey="lblImageCarouselShowNavigation.HelpText" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbImageCarouselShowNavigation" runat="server" Checked="True" resourcekey="cbImageCarouselShowNavigationResource1" Text="Show navigation" />
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblImageCarouselShowPaging" ResourceKey="lblImageCarouselShowPaging" runat="server" HelpText="Show paging:" Text="Show paging:" HelpKey="lblImageCarouselShowPaging.HelpText" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbImageCarouselShowPaging" runat="server" resourcekey="cbImageCarouselShowPagingResource1" Text="Show paging" />
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblImageCarouselRandomizeMedia" runat="server" HelpText="Randomize media positions at every page load:" Text="Randomize media positions:" HelpKey="lblImageCarouselRandomizeMedia.HelpText" ResourceKey="lblImageCarouselRandomizeMedia" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbImageCarouselRandomizeMedia" runat="server" resourcekey="cbImageCarouselShowPagingResource1" AutoPostBack="True" OnCheckedChanged="cbImageCarouselRandomizeMedia_CheckedChanged" Text="Randomize media positions" />
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="Label8" runat="server" HelpText="Select media sorting options:" Text="Media sorting:" HelpKey="lblLightBoxMediaSorting.HelpText" ResourceKey="lblLightBoxMediaSorting" />
											</td>
											<td>
												<table class="clearWidth textLeft">
													<tr>
														<td>
															<div class="styledSelect">
																<asp:DropDownList ID="ddlImageCarouselMediaSort" runat="server">
																	<asp:ListItem resourcekey="liPosition" Value="Position">Position</asp:ListItem>
																	<asp:ListItem resourcekey="liDateUploaded" Value="DateUploaded">Date uploaded</asp:ListItem>
																	<asp:ListItem resourcekey="liFileName" Value="FileName">Filename</asp:ListItem>
																	<asp:ListItem resourcekey="liTitle">Title</asp:ListItem>
																</asp:DropDownList>
															</div>
														</td>
														<td>&nbsp;</td>
														<td>
															<asp:RadioButtonList ID="rblImageCarouselMediaSortType" runat="server" RepeatDirection="Horizontal" CssClass="styledRadio small">
																<asp:ListItem resourcekey="liAscending" Selected="True" Value="ASC">Ascending</asp:ListItem>
																<asp:ListItem resourcekey="liDescending" Value="DESC">Descending</asp:ListItem>
															</asp:RadioButtonList>
														</td>
													</tr>
												</table>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblImageCarouselArrowTypes" runat="server" HelpText="Select navigation arrow style:" Text="Select navigation arrow style:" HelpKey="lblImageCarouselArrowTypes.HelpText" ResourceKey="lblImageCarouselArrowTypes.Text" />
											</td>
											<td>
												<div class="styledSelect">
													<asp:DropDownList ID="ddlImageCarouselArrows" runat="server">
														<asp:ListItem>Default</asp:ListItem>
													</asp:DropDownList>
												</div>
											</td>
										</tr>
										<tr>
											<td class="textTop">
												<dnn:Label ID="lblImageCarouselEnableFullscreen" runat="server" CssClass="styleBolded" HelpKey="lblLightBoxEnableFullscreen.HelpText" HelpText="Enable fullscreen:" ResourceKey="lblLightBoxEnableFullscreen" Text="Enable fullscreen:" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbImageCarouselEnableFullscreen" runat="server" AutoPostBack="True" OnCheckedChanged="cbImageCarouselEnableFullscreen_CheckedChanged" Text="Enable fullscreen" />
												</div>
												<asp:Panel ID="pnlImageCarouselFullscreenOptions" runat="server" BackColor="#CBEEF8" BorderColor="#65CDEB" BorderStyle="Solid" BorderWidth="2px" Visible="False">
													<table>
														<tr>
															<td>
																<dnn:Label ID="lblImageCarouselFullscreenThemeSelect" runat="server" HelpKey="lblLightboxFullscreenThemeSelect.HelpText" HelpText="Select fullscreen theme:" ResourceKey="lblLightboxFullscreenThemeSelect" Text="Select fullscreen theme:" />
															</td>
															<td>
																<asp:DropDownList ID="ddlImageCarouselFullScreenThemeSelect" runat="server">
																</asp:DropDownList>
															</td>
														</tr>
														<tr>
															<td>
																<dnn:Label ID="lblImageCarouselFullscreenShowArrows" runat="server" HelpKey="lblLightboxFullscreenShowArrows.HelpText" HelpText="Show navigation arrows:" ResourceKey="lblLightboxFullscreenShowArrows" Text="Show navigation arrows:" />
															</td>
															<td>
																<asp:CheckBox ID="cbImageCarouselFullscreenShowArrows" runat="server" />
															</td>
														</tr>
														<tr>
															<td>
																<dnn:Label ID="lblImageCarouselFullscreenAutoHideNavigationArrows" runat="server" HelpKey="lblLightboxFullscreenAutoHideNavigationArrows.HelpText" HelpText="Auto hide navigation arrows on mouse out:" ResourceKey="lblLightboxFullscreenAutoHideNavigationArrows.Text" Text="Auto hide navigation arrows:" />
															</td>
															<td>
																<asp:CheckBox ID="cbImageCarouselFullscreenAutoHideArrows" runat="server" />
															</td>
														</tr>
														<tr>
															<td>
																<dnn:Label ID="lblImageCarouselFullscreenArrows" runat="server" HelpKey="lblLightboxFullscreenArrows.HelpText" HelpText="Navigation arrows:" ResourceKey="lblLightboxFullscreenArrows.Text" Text="Navigation arrows:" />
															</td>
															<td>
																<asp:DropDownList ID="ddlImageCarouselFullscreenArrows" runat="server"></asp:DropDownList>
															</td>
														</tr>
														<tr>
															<td>
																<dnn:Label ID="lblImageCarouselFullscreenGalleryTitle" runat="server" HelpKey="lblLightboxFullscreenGalleryTitle.HelpText" HelpText="Please enter title to display:" ResourceKey="lblLightboxFullscreenGalleryTitle.Text" Text="Title to display:" />
															</td>
															<td>
																<asp:TextBox ID="tbImageCarouselFullscreenTitle" runat="server"></asp:TextBox>
															</td>
														</tr>
													</table>
												</asp:Panel>
											</td>
										</tr>
										<tr>
											<td class="textTop">
												<dnn:Label ID="lblLightBoxShowDownload1" runat="server" HelpKey="lblLightBoxShowDownload.HelpText" HelpText="Show image download link:" ResourceKey="lblLightBoxShowDownload" Text="Show image download link:" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbImageCarouselDownloadLink" runat="server" AutoPostBack="True" OnCheckedChanged="cbImageCarouselDownloadLink_CheckedChanged" resourcekey="cbLightBoxGallerySmartCropVerticalResource1" Text="Show image download link" />
												</div>
												<asp:Panel ID="pnlImageCarouselDownloadOptions" runat="server" BackColor="#CBEEF8" BorderColor="#65CDEB" BorderStyle="Solid" BorderWidth="2px" Visible="False">
													<table class="clearWidth">
														<tr>
															<td class="textTop">
																<asp:Label ID="lblLighboxSelectDownloadRoles1" runat="server" resourcekey="lblLighboxSelectDownloadRoles" Text="Select download roles:"></asp:Label>
															</td>
															<td>
																<asp:GridView ID="gvImageCarouselDownloadRoles" runat="server" AutoGenerateColumns="False" BorderColor="#65CDEB" BorderStyle="Solid" BorderWidth="1px" CellPadding="4" CssClass="intliststylebox" ForeColor="#333333" GridLines="None" OnRowDataBound="gvImageCarouselDownloadRoles_RowDataBound">
																	<RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
																	<Columns>
																		<asp:TemplateField HeaderText="Role">
																			<EditItemTemplate>
																				<asp:TextBox ID="TextBox11" runat="server" Text='<%# Bind("Role") %>'></asp:TextBox>
																			</EditItemTemplate>
																			<ItemTemplate>
																				<asp:Label ID="lblRoleName2" runat="server" Text='<%# Bind("Role") %>'></asp:Label>
																			</ItemTemplate>
																		</asp:TemplateField>
																		<asp:TemplateField HeaderText="Enable download">
																			<EditItemTemplate>
																				<asp:TextBox ID="TextBox12" runat="server" Text='<%# Bind("EnableDownload") %>'></asp:TextBox>
																			</EditItemTemplate>
																			<ItemTemplate>
																				<asp:CheckBox ID="cbICEnableDownload" runat="server" Checked='<%# Bind("EnableDownload") %>' />
																			</ItemTemplate>
																			<ItemStyle HorizontalAlign="Center" />
																		</asp:TemplateField>
																	</Columns>
																	<FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
																	<PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
																	<SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
																	<HeaderStyle BackColor="#0BA2CE" Font-Bold="True" ForeColor="#FFFFFF" />
																	<EditRowStyle BackColor="#999999" />
																	<AlternatingRowStyle BackColor="White" ForeColor="#284775" />
																</asp:GridView>
															</td>
														</tr>
														<tr>
															<td colspan="2">
																<asp:CheckBox ID="cbImageCarouselUseViewAsDownload" runat="server" resourcekey="lblUseViewVersionAsDownload" Text="Use view version as download version if there is no download verison:" />
															</td>
														</tr>
													</table>
												</asp:Panel>
											</td>
										</tr>
										<tr>
											<td colspan="2"></td>
										</tr>
										<tr class="color2HighLighted">
											<td colspan="2" class="textCenter">
												<asp:Label ID="lblImageCarouselVideoinLighTitle" runat="server" Text="Video player in lightbox settings:" resourcekey="lblLightBoxGalleryViseoPlayerSettingsResource1"></asp:Label>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblImageCarouselVPSelectPLayer" runat="server" HelpText="Select player:" Text="Select player:" HelpKey="SelectVideoPlayer.HelpText" ResourceKey="SelectVideoPlayer.Text" />
											</td>
											<td>
												<div class="styledSelect">
													<asp:DropDownList ID="ddlImageCarouselVPSelectPlayer" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlImageCarouselVPSelectPlayer_SelectedIndexChanged">
														<asp:ListItem Selected="True" Value="False">Standard</asp:ListItem>
														<asp:ListItem Value="True">Flow player</asp:ListItem>
													</asp:DropDownList>
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblImageCarouselVPSkin" runat="server" HelpKey="lblLightBoxGalleryVideoPlayerSelectSkin.HelpText" HelpText="Select video player skin:" ResourceKey="lblLightBoxGalleryVideoPlayerSelectSkin" Text="Select video player skin:" />
											</td>
											<td>
												<div class="styledSelect">
													<asp:DropDownList ID="ddlImageCarouselVPTheme" runat="server">
														<asp:ListItem resourcekey="ListItemResource28" Selected="True" Value="black">Black</asp:ListItem>
														<asp:ListItem resourcekey="ListItemResource29" Value="white">White</asp:ListItem>
													</asp:DropDownList>
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblImageCarouselVPPlayOnLoad" ResourceKey="lblLightBoxGalleryVideoPlayerPlayOnLoad" runat="server" HelpText="Start to play video on page load:" Text="Play on load:" HelpKey="lblLightBoxGalleryVideoPlayerPlayOnLoad.HelpText" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbImageCarouselVPPlayOnLOad" runat="server" resourcekey="cbTGVPPlayOnLoadResource1" Text="Play on load" />
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblImageCarouselVPShowDescription" ResourceKey="lblLightBoxGalleryViseoPlayerPlayOnLoad" runat="server" HelpText="Show description inside video player:" Text="Show description:" HelpKey="lblLightBoxGalleryViseoPlayerPlayOnLoad.HelpText" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbImageCarouselVPShowDescription" runat="server" resourcekey="cbTGVPShowDescriptionResource1" Text="Show description" />
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblImageCarouselVPAllowFullscreen" ResourceKey="lblTGVPAllowFullscreen" runat="server" HelpText="Allow video to be played in fullscreen:" Text="Allow fullscreen:" HelpKey="lblTGVPAllowFullscreen.HelpText" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbImageCarouselVPAllowFullscreen" runat="server" resourcekey="cbTGVPAllowFullscreenResource1" Text="Allow fullscreen" />
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblImageCarouselPlayQTinFlash" ResourceKey="lblLightBoxGalleryVideoPlayerPlayQTInFlash" runat="server" HelpText="Play QuickTime videos in flash player:" Text="Play QuickTime videos in flash player:" HelpKey="lblLightBoxGalleryVideoPlayerPlayQTInFlash.HelpText" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbImageCarouselVPPlayQTInFlash" runat="server" resourcekey="cbTGVPPlayQTinFlashResource1" Text="Play QuickTime videos in flash player" />
												</div>
											</td>
										</tr>
										<tr>
											<td colspan="2"></td>
										</tr>
										<tr class="color2HighLighted">
											<td colspan="2" class="textCenter">
												<asp:Label ID="lblLightBoxGalleryAudioPlayerSettings1" runat="server" resourcekey="lblLightBoxGalleryAudioPlayerSettingsResource1" Text="Audio player in lightbox settings:"></asp:Label>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblImageCarouselAPAutoStart" ResourceKey="lblLightBoxGalleryAudioPlayerPlayOnLoad" runat="server" HelpText="Start to play audio on page load:" Text="Play on load:" HelpKey="lblLightBoxGalleryAudioPlayerPlayOnLoad.HelpText" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbImageCarouselAPAutostart" runat="server" resourcekey="cbTGAPPlayOnLoadResource1" Text="Play on load" />
												</div>
											</td>
										</tr>
									</table>
									<asp:Label ID="lblImageCarouselSstatus" runat="server" EnableViewState="False"></asp:Label>
									<div class="mainActions">
										<asp:LinkButton ID="btnImageCarouselSaveSettings" runat="server" OnClick="btnImageCarouselSaveSettings_Click" Text="Save settings" ValidationGroup="vgImageCarouselSettings" resourcekey="btnImageCarouselSaveSettingsResource1" CssClass="downSave" />
										<asp:LinkButton ID="btnImageCaouselSaveClose" runat="server" OnClick="btnImageCaouselSaveClose_Click" Text="Save &amp; Close" ValidationGroup="vgImageCarouselSettings" resourcekey="btnImageCaouselSaveCloseResource1" CssClass="downSaveClose" />
									</div>
								</div>
							</asp:Panel>
							<asp:Panel ID="pnlSlideShowThumbnails3" runat="server" Visible="False" CssClass="settingsList negativeMargins40">
								<h3>
									<asp:Label ID="lblSlideshowWithThumbnails3" runat="server" Text="Slideshow With Thumbnails 3 display settings" CssClass="settingsdetailtitle" resourcekey="lblSlideshowWithThumbnails3"></asp:Label>
								</h3>
								<div class="settingsTable">
									<table>
										<tr>
											<td>
												<dnn:Label ID="lblSlideshowWithThumbnails3TemplateSelect" runat="server" ControlName="ddlSSThemeSelect" HelpKey="lblSlideshowWithThumbnails3TemplateSelect.HelpText" HelpText="Select the control viewer template:" ResourceKey="lblSlideshowWithThumbnails3TemplateSelect" Text="Select template:" />
											</td>
											<td>
												<div class="styledSelect">
													<asp:DropDownList ID="ddlSlideshowWithThumbnails3TemplateSelect" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlImageSliderTemplateSelect_SelectedIndexChanged"></asp:DropDownList>
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblSlideshowWithThumbnails3ThemeSelect" runat="server" ControlName="ddlSSThemeSelect" HelpKey="lblSlideshowWithThumbnails3ThemeSelect.HelpText" HelpText="Select theme:" ResourceKey="lblSlideshowWithThumbnails3ThemeSelect" Text="Select theme:" />
											</td>
											<td>
												<div class="styledSelect">
													<asp:DropDownList ID="ddlSlideshowWithThumbnails3ThemeSelect" runat="server">
														<asp:ListItem Value="classic">Slideshow with thumbnails</asp:ListItem>
														<asp:ListItem Value="dots">Slideshow without thumbnails</asp:ListItem>
													</asp:DropDownList>
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblSlideshowWithThumbnails3ResponsiveSelect" runat="server" HelpText="Select the layout type:" Text="Select the layout type:" HelpKey="lblChameleonSelectLayoutType.HelpText" ResourceKey="lblChameleonSelectLayoutType" />
											</td>
											<td>
												<asp:RadioButtonList ID="rblSlideshowWithThumbnails3ResponsiveSelect" runat="server" RepeatDirection="Horizontal" AutoPostBack="True" OnSelectedIndexChanged="rblSlideshowWithThumbnails3ResponsiveSelect_SelectedIndexChanged" CssClass="styledRadio">
													<asp:ListItem resourcekey="liResponsive" Value="responsive">Responsive Layout</asp:ListItem>
													<asp:ListItem resourcekey="liFixed" Selected="True" Value="fixed">Fixed Layout</asp:ListItem>
												</asp:RadioButtonList>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblSlideshowWithThumbnails3MediaTitle" runat="server" HelpText="Show image title:" Text="Show image title:" HelpKey="lblSlideshowWithThumbnails3MediaTitle.HelpText" ResourceKey="lblSlideshowWithThumbnails3MediaTitle" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbSlideshowWithThumbnails3ShowMediaTitle" runat="server" resourcekey="cbSlideShowShowMediaTitleResource1" Text="Show image title" />
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblSlideshowWithThumbnails3ShowMediaDescription" ResourceKey="lblSlideshowWithThumbnails3ShowMediaDescription" runat="server" HelpText="Show image description:" Text="Show image description:" HelpKey="lblSlideshowWithThumbnails3ShowMediaDescription.HelpText" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbSlideshowWithThumbnails3ShowMediaDescription" runat="server" resourcekey="cbSlideShowShowMediaDescriptionResource1" Text="Show image description" />
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblSlideshowWithThumbnails3ShowFullscreen" ResourceKey="lblSlideshowWithThumbnails3ShowFullscreen" runat="server" HelpText="Enable fullscreen:" Text="Enable fullscreen:" HelpKey="lblSlideshowWithThumbnails3ShowFullscreen.HelpText" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbSlideshowWithThumbnails3ShowFullscreenOption" runat="server" resourcekey="cbSlideShowShowLightboxDescriptionResource1" Text="Enable fullscreen" />
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblSlideshowWithThumbnails3MaxImageWidth" runat="server" HelpText="Maximum  image width for proportional resizing:" Text="Maximum image width:" HelpKey="lblSlideshowWithThumbnails3MaxImageWidth.HelpText" ResourceKey="lblSlideshowWithThumbnails3MaxImageWidth" ControlName="tbMaxImageWidth" />
											</td>
											<td>
												<asp:TextBox ID="tbSlideshowWithThumbnails3MaxImageWidth" runat="server" ValidationGroup="vgSSTN3Settings" CssClass="small textCenter">600</asp:TextBox>
												<asp:Label ID="lblSlideshowWithThumbnails3ImageWidthPercentage" runat="server" Text="px"></asp:Label>
												<asp:RequiredFieldValidator ID="rfvSlideshowWithThumbnails3ImageWidth" runat="server" ControlToValidate="tbSlideshowWithThumbnails3MaxImageWidth" Display="Dynamic" ErrorMessage="This field is required." resourcekey="rfvSlideShowImageWidthResource1.ErrorMessage" SetFocusOnError="True" ValidationGroup="vgSSTN3Settings" CssClass="smallInfo warning"></asp:RequiredFieldValidator>
												<asp:CompareValidator ID="cvSlideshowWithThumbnails3ImageWidth" runat="server" ControlToValidate="tbSlideshowWithThumbnails3MaxImageWidth" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" resourcekey="cvSlideShowImageWidthResource1.ErrorMessage" SetFocusOnError="True" Type="Integer" ValidationGroup="vgSSTN3Settings" CssClass="smallInfo warning"></asp:CompareValidator>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblSlideshowWithThumbnails3MaxImageHeight" ResourceKey="lblSlideshowWithThumbnails3MaxImageHeight" runat="server" ControlName="tbMaxImageHeight" HelpText="Maximum  image width for proportional resizing:" Text="Maximum image height:" HelpKey="lblSlideshowWithThumbnails3MaxImageHeight.HelpText" />
											</td>
											<td>
												<asp:TextBox ID="tbSlideshowWithThumbnails3MaxImageHeight" runat="server" ValidationGroup="vgSSTN3Settings" CssClass="small textCenter">400</asp:TextBox>
												<asp:Label ID="lblSlideshowWithThumbnails3ImageHeightPercentage" runat="server" Text="px"></asp:Label>
												<asp:RequiredFieldValidator ID="rfvSlideshowWithThumbnails3ImageHeight" runat="server" ControlToValidate="tbSlideshowWithThumbnails3MaxImageHeight" Display="Dynamic" ErrorMessage="This field is required." ValidationGroup="vgSSTN3Settings" SetFocusOnError="True" resourcekey="rfvSlideShowImageHeightResource1.ErrorMessage" CssClass="smallInfo warning"></asp:RequiredFieldValidator>
												<asp:CompareValidator ID="cvSlideshowWithThumbnails3ImageHeight" runat="server" ControlToValidate="tbSlideshowWithThumbnails3MaxImageHeight" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" Type="Integer" ValidationGroup="vgSSTN3Settings" SetFocusOnError="True" resourcekey="cvSlideShowImageHeightResource1.ErrorMessage" CssClass="smallInfo warning"></asp:CompareValidator>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblSlideshowWithThumbnails3AutoSlidePause" ResourceKey="lblSlideshowWithThumbnails3AutoSlidePause" runat="server" Text="Transition duration (ms): " HelpText="Transition duration in miliseconds: " ControlName="tbAutoSlidePause" HelpKey="lblSlideshowWithThumbnails3AutoSlidePause.HelpText" EnableViewState="True"></dnn:Label>
											</td>
											<td>
												<asp:Panel ID="pnlSlideOpt3" runat="server">
													<asp:TextBox ID="tbSlideshowWithThumbnails3AutoSlidePause" runat="server" ValidationGroup="vgSSTN3Settings" CssClass="small textCenter">1500</asp:TextBox>
													<asp:RequiredFieldValidator ID="rfvSlideshowWithThumbnails3Pause" runat="server" ControlToValidate="tbSlideshowWithThumbnails3AutoSlidePause" Display="Dynamic" ErrorMessage="This field is required." resourcekey="rfvSlideShowImageWidthResource1.ErrorMessage" SetFocusOnError="True" ValidationGroup="vgSSTN3Settings" CssClass="smallInfo warning"></asp:RequiredFieldValidator>
													<asp:CompareValidator ID="cvSlideshowWithThumbnails3Pause" runat="server" ControlToValidate="tbSlideshowWithThumbnails3AutoSlidePause" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" resourcekey="cvSlideShowImageWidthResource1.ErrorMessage" SetFocusOnError="True" Type="Integer" ValidationGroup="vgSSTN3Settings" CssClass="smallInfo warning"></asp:CompareValidator>
												</asp:Panel>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblSSlideshowWithThumbnails3AutoSlide" runat="server" Text="Enable auto slide:" ControlName="cbAutoSlide" HelpText="Enable auto slide of images." HelpKey="lblSSlideshowWithThumbnails3AutoSlide.HelpText" ResourceKey="lblSSlideshowWithThumbnails3AutoSlide"></dnn:Label>
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbSlideshowWithThumbnails3AutoSlide" runat="server" AutoPostBack="True" Checked="True" OnCheckedChanged="cbAutoSlide_CheckedChanged1" resourcekey="cbSlideShowAutoSlideResource1" Text="Enable auto slide" />
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblSlideshowWithThumbnails3AutoSlideDelay" runat="server" ControlName="tbAutoSlidePause" HelpKey="lblSlideshowWithThumbnails3AutoSlideDelay.HelpText" HelpText="Delay between transitions in miliseconds: " ResourceKey="lblSlideshowWithThumbnails3AutoSlideDelay" Text="Delay between transitions (ms): " EnableViewState="True" />
											</td>
											<td>
												<asp:Panel ID="pnlSlideOpt4" runat="server">
													<asp:TextBox ID="tbSlideshowWithThumbnails3AutoSlideDelay" runat="server" ValidationGroup="vgSSTN3Settings" CssClass="small textCenter">5000</asp:TextBox>
													<asp:RequiredFieldValidator ID="rfvSlideshowWithThumbnails3Delay" runat="server" ControlToValidate="tbSlideshowWithThumbnails3AutoSlideDelay" Display="Dynamic" ErrorMessage="This field is required." resourcekey="rfvSlideShowImageWidthResource1.ErrorMessage" SetFocusOnError="True" ValidationGroup="vgSSTN3Settings" CssClass="smallInfo warning"></asp:RequiredFieldValidator>
													<asp:CompareValidator ID="cvSlideshowWithThumbnails3AutoSlideDelay" runat="server" ControlToValidate="tbSlideshowWithThumbnails3AutoSlideDelay" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" resourcekey="cvSlideShowImageWidthResource1.ErrorMessage" SetFocusOnError="True" Type="Integer" ValidationGroup="vgSSTN3Settings" CssClass="smallInfo warning"></asp:CompareValidator>
												</asp:Panel>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblSlideshowWithThumbnails3TransitionEffect" runat="server" ControlName="tbAutoSlidePause" EnableViewState="True" HelpText="Transition effect: " Text="Transition effect: " HelpKey="lblSlideshowWithThumbnails3TransitionEffect.HelpText" ResourceKey="lblSlideshowWithThumbnails3TransitionEffect" />
											</td>
											<td>
												<div class="styledSelect">
													<asp:DropDownList ID="ddlSlideshowWithThumbnails3TransitionEffect" runat="server">
														<asp:ListItem resourcekey="SST3Fade" Value="fade">Fade</asp:ListItem>
														<asp:ListItem resourcekey="SST3Flash" Value="flash">Flash</asp:ListItem>
														<asp:ListItem resourcekey="SST3Pulse" Value="pulse">&gt;Pulse</asp:ListItem>
														<asp:ListItem resourcekey="SST3Slide" Value="slide">Slide</asp:ListItem>
														<asp:ListItem resourcekey="SST3FadeSlide" Value="fadeslide">Fade and slide</asp:ListItem>
													</asp:DropDownList>
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblSlideshowWithThumbnails3SmartCrop" runat="server" ControlName="cbSSSmartCrop" HelpText="Use this if you want all images to have same width and height. Otherwise images will be resized proportionaly." Text="Smart resize and crop images:" HelpKey="lblSlideshowWithThumbnails3SmartCrop.HelpText" ResourceKey="lblSlideshowWithThumbnails3SmartCrop" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbSlideshowWithThumbnails3SmartCrop" runat="server" resourcekey="cbSlideShowSmartCropResource1" Text="Smart resize and crop images" />
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblSlideshowWithThumbnails3BackgroundColor" ResourceKey="lblSlideshowWithThumbnails3BackgroundColor" runat="server" HelpText="Background color:" Text="Background color:" HelpKey="lblSlideshowWithThumbnails3BackgroundColor.HelpText" />
											</td>
											<td>
												<asp:TextBox ID="tbSlideshowWithThumbnails3BackgroundColor" runat="server" MaxLength="6" ValidationGroup="vgSSTN3Settings" CssClass="small textCenter">000000</asp:TextBox>
												<asp:RequiredFieldValidator ID="rfvSlideshowWithThumbnails3ThumbnailsOverlayColor" runat="server" ControlToValidate="tbSlideshowWithThumbnails3BackgroundColor" Display="Dynamic" ErrorMessage="This field is required." resourcekey="rfvSlideShowThumbnailsOverlayColorResource1.ErrorMessage" ValidationGroup="vgSSTN3Settings" CssClass="smallInfo warning"></asp:RequiredFieldValidator>
												<asp:RegularExpressionValidator ID="revSlideshowWithThumbnails3ThumbnailsOverlayColor" runat="server" ControlToValidate="tbSlideshowWithThumbnails3BackgroundColor" ErrorMessage="Please eneter hexadecimal color value." resourcekey="revSlideShowThumbnailsOverlayColorResource1.ErrorMessage" ValidationExpression="^#?([a-f]|[A-F]|[0-9]){3}(([a-f]|[A-F]|[0-9]){3})?$" ValidationGroup="vgSSTN3Settings" CssClass="smallInfo warning"></asp:RegularExpressionValidator>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblSlideshowWithThumbnails3RandomizeMedia" runat="server" HelpText="Randomize media positions at every page load:" Text="Randomize media positions:" HelpKey="lblImageSliderRandomizeMedia.HelpText" ResourceKey="lblImageSliderRandomizeMedia" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbSlideshowWithThumbnails3RandomizeMedia" runat="server" resourcekey="cbImageSliderShowPagingResource1" AutoPostBack="True" OnCheckedChanged="cbSlideshowWithThumbnails3RandomizeMedia_CheckedChanged" Text="Randomize media positions" />
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="Label5" runat="server" HelpText="Select media sorting options:" Text="Media sorting:" HelpKey="lblLightBoxMediaSorting.HelpText" ResourceKey="lblLightBoxMediaSorting" />
											</td>
											<td>
												<table class="clearWidth textLeft">
													<tr>
														<td>
															<div class="styledSelect">
																<asp:DropDownList ID="ddlSSTN3MediaSort" runat="server">
																	<asp:ListItem resourcekey="liPosition" Value="Position">Position</asp:ListItem>
																	<asp:ListItem resourcekey="liDateUploaded" Value="DateUploaded">Date uploaded</asp:ListItem>
																	<asp:ListItem resourcekey="liFileName" Value="FileName">Filename</asp:ListItem>
																	<asp:ListItem resourcekey="liTitle">Title</asp:ListItem>
																</asp:DropDownList>
															</div>
														</td>
														<td>&nbsp;</td>
														<td>
															<asp:RadioButtonList ID="rblSSTN3MediaSortType" runat="server" RepeatDirection="Horizontal" CssClass="styledRadio small">
																<asp:ListItem resourcekey="liAscending" Selected="True" Value="ASC">Ascending</asp:ListItem>
																<asp:ListItem resourcekey="liDescending" Value="DESC">Descending</asp:ListItem>
															</asp:RadioButtonList>
														</td>
													</tr>
												</table>
											</td>
										</tr>
									</table>
									<asp:Label ID="lblSlideshowWithThumbnails3Sstatus" runat="server" EnableViewState="False"></asp:Label>
									<div class="mainActions">
										<asp:LinkButton ID="btnSlideshowWithThumbnails3SaveSettings" runat="server" OnClick="btnSlideshowWithThumbnails3SaveSettings_Click" resourcekey="btnSlideShowSaveSettingsResource1" Text="Save settings" ValidationGroup="vgSSTN3Settings" CssClass="downSave" />
										<asp:LinkButton ID="btnSlideshowWithThumbnails3SaveClose" runat="server" OnClick="btnSlideshowWithThumbnails3SaveClose_Click" resourcekey="btnSlideShowSaveCloseResource1" Text="Save &amp; Close" ValidationGroup="vgSSTN3Settings" CssClass="downSaveClose" />
									</div>
								</div>
							</asp:Panel>
							<asp:Panel ID="pnlAdvancedSlideShow" runat="server" Visible="False" CssClass="settingsList negativeMargins40">
								<h3>
									<asp:Label ID="lblAdvancedSlideShow" resourcekey="lblAdvancedSlideShow" runat="server" CssClass="settingsdetailtitle" Text="Advanced Slide Show"></asp:Label>
								</h3>
								<div class="settingsTable">
									<table>
										<tr>
											<td>
												<dnn:Label ID="lblLightboxTemplateSelect1" runat="server" ControlName="ddlSSThemeSelect" HelpKey="lblLightboxTemplateSelect.HelpText" HelpText="Select the control viewer template:" ResourceKey="lblLightboxTemplateSelect" Text="Select template:" />
											</td>
											<td>
												<div class="styledSelect">
													<asp:DropDownList ID="ddlASSTemplateSelect" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlLightboxTemplateSelect_SelectedIndexChanged"></asp:DropDownList>
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblLightBoxGalleryThemeSelect1" runat="server" ControlName="ddlTGThemeSelect" HelpKey="lblLightBoxGalleryThemeSelect.HelpText" HelpText="Select the CSS theme file:" ResourceKey="lblLightBoxGalleryThemeSelect" Text="Select CSS:" />
											</td>
											<td>
												<div class="styledSelect">
													<asp:DropDownList ID="ddlASSThemeSelect" runat="server"></asp:DropDownList>
												</div>
												<asp:Label ID="lblASSTemplateInfo" runat="server"></asp:Label>
											</td>
										</tr>
										<tr>
											<td colspan="2"></td>
										</tr>
										<tr class="color6HighLighted">
											<td colspan="2" class="noLeftRightPadding">
												<table>
													<tr>
														<td>
															<dnn:Label ID="lblLightboxGalleryDispplayNestedGalleries1" runat="server" HelpKey="lblLightboxGalleryDispplayNestedGalleries.HelpText" HelpText="Display nested galleries:" ResourceKey="lblLightboxGalleryDispplayNestedGalleries" Text="Display nested galleries:" />
														</td>
														<td>
															<div class="styledCheckbox noLabel">
																<asp:CheckBox ID="cbASSDisplayNestedGalleries" runat="server" AutoPostBack="True" OnCheckedChanged="cbASSDisplayNestedGalleries_CheckedChanged" resourcekey="cbLightboxGalleryDisplayNestedGalleriesResource1" Text="Display nested galleries" />
															</div>
														</td>
													</tr>
												</table>
												<asp:Panel ID="pnlASSNestedGalleriesOptions" runat="server" Visible="False">
													<asp:Panel ID="pnlASSNGGallerySettings" runat="server">
														<table>
															<tr class="color1HighLighted">
																<td class="textCenter">
																	<asp:Label ID="lblLightboxGalleryNestedGallerySettings1" runat="server" Text="Nested galleries settings" resourcekey="lblLightboxGalleryNestedGallerySettingsResource1"></asp:Label>
																</td>
															</tr>
															<tr>
																<td>
																	<table class="settingsTable">
																		<tr>
																			<td class="textTop">
																				<asp:Label ID="lblLightboxGalleryNestedGallerySelection0" runat="server" Text="Gallery selection:" resourcekey="lblLightboxGalleryNestedGallerySelectionResource1"></asp:Label>
																			</td>
																			<td>
																				<asp:CheckBoxList ID="cblASSNestedGallerySelection" runat="server" CellPadding="2" CellSpacing="5" DataSourceID="odsGallery" DataTextField="GalleryName" DataValueField="GalleryID" OnDataBound="cblTGNGGallerySelection_DataBound" OnSelectedIndexChanged="cblTGNGGallerySelection_SelectedIndexChanged" RepeatColumns="2" CssClass="nestedGalleryList styledCheckbox"></asp:CheckBoxList>
																				<asp:Label ID="lblASSNoNestedGalleryError" runat="server" Text="Please add an select some galleries." Visible="False" resourcekey="lblLightboxGalleryNoNestedGalleryErrorResource1" CssClass="infoMessages warning static"></asp:Label>
																			</td>
																		</tr>
																		<tr>
																			<td></td>
																			<td>
																				<div class="styledCheckbox">
																					<asp:CheckBox ID="cbASSNestedShowAllGalleries" runat="server" AutoPostBack="True" OnCheckedChanged="cbASSNestedShowAllGalleries_CheckedChanged" Text="Show all galleries" resourcekey="cbLightboxGalleryNestedShowAllGalleriesResource1" />
																				</div>
																			</td>
																		</tr>
																	</table>
																</td>
															</tr>
														</table>
													</asp:Panel>
												</asp:Panel>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblLightboxGalleryShowMediaTitle0" ResourceKey="lblLightboxGalleryShowMediaTitle" runat="server" HelpText="Show media title:" Text="Show media title:" HelpKey="lblLightboxGalleryShowMediaTitle.HelpText" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbASSShowMediaTitle" runat="server" resourcekey="cbLightboxGalleryShowMediaTitleResource1" Checked="True" Text="Show media title" />
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblLightboxGalleryShowMediaDescription0" ResourceKey="lblLightboxGalleryShowMediaDescription" runat="server" HelpText="Show media description:" Text="Show media description:" HelpKey="lblLightboxGalleryShowMediaDescription.HelpText" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbASSShowMediaDescription" runat="server" resourcekey="cbLightboxGalleryShowMediaDescriptionResource1" Checked="True" Text="Show media description" />
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblASSDisplayNumber" runat="server" HelpText="Display image number:" Text="Display image number:" HelpKey="lblASSDisplayNumber.HelpKey" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbASSShowTitle" runat="server" resourcekey="cbTGShowTitleResource1" Checked="True" Text="Display image number" />
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblASSDisplayPlayButton" runat="server" HelpText="Display play button:" Text="Display play button:" HelpKey="lblASSDisplayPlayButton.HelpKey" ResourceKey="lblASSDisplayPlayButton" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbASSShowDescription" runat="server" resourcekey="cbTGShowDescriptionResource1" Checked="True" Text="Display play button" />
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblASSDisplayDownloadButton" runat="server" HelpText="Display download button:" Text="Display download button:" HelpKey="lblASSDisplayDownloadButton.HelpKey" ResourceKey="lblASSDisplayDownloadButton" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbASSNestedShowGalleryName" runat="server" Checked="True" Text="Display download button" />
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblASSDisplayInfoButton" runat="server" HelpText="Display info button:" Text="Display info button:" HelpKey="lblASSDisplayInfoButton.HelpKey" ResourceKey="lblASSDisplayInfoButton" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbASSNestedShowGalleryDescription" runat="server" Checked="True" Text="Display info button" />
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblASSDisplayTimer" runat="server" HelpText="Display timer:" Text="Display timer:" HelpKey="lblASSDisplayTimer.HelpKey" ResourceKey="lblASSDisplayTimer" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbASSNestedShowGalleryInfo" runat="server" Checked="True" Text="Display timer" />
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblASSFLoatingCpanel" runat="server" HelpText="Floating navigation bar:" Text="Floating navigation bar:" HelpKey="lblASSFLoatingCpanel.HelpKey" ResourceKey="lblASSFLoatingCpanel" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbASSNestedShowBreadcrumbs" runat="server" Text="Floating navigation bar" />
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblASSShowOnMouseOver" runat="server" HelpText="Show navigation bar on mouse over:" Text="Show navigation bar on mouse over:" HelpKey="lblASSShowOnMouseOver.HelpKey" ResourceKey="lblASSShowOnMouseOver" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbASSNestedProportionalyResize" runat="server" AutoPostBack="True" OnCheckedChanged="cbASSNestedProportionalyResize_CheckedChanged" Text="Show navigation bar on mouse over" />
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblASSInitialOpen" runat="server" HelpKey="lblASSInitialOpen.HelpText" HelpText="Show image selection on open:" ResourceKey="lblASSInitialOpen.Text" Text="Show image selection on open:" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbASSInitialOpen" runat="server" Text="Show image selection on open" />
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblASSSlideEffect" runat="server" HelpText="Image transition effect:" Text="Image transition effect:" HelpKey="lblASSSlideEffect.HelpKey" ResourceKey="lblASSSlideEffect" />
											</td>
											<td>
												<div class="styledSelect">
													<asp:DropDownList ID="ddlASSTransitionEffect" runat="server">
														<asp:ListItem resourcekey="lifade" Value="fade">Fade</asp:ListItem>
														<asp:ListItem resourcekey="lihorizontal" Value="h_slide">Horizontal slide</asp:ListItem>
														<asp:ListItem resourcekey="livertical" Value="v_slide">Vertical slide</asp:ListItem>
														<asp:ListItem resourcekey="lihwipe" Value="h_wipe">Horizontal wipe</asp:ListItem>
														<asp:ListItem resourcekey="livwipe" Value="v_wipe">Vertical wipe</asp:ListItem>
													</asp:DropDownList>
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblASSTextSlideEffect" runat="server" HelpText="Text transition effect:" Text="Text transition effect:" HelpKey="lblASSTextSlideEffect.HelpKey" ResourceKey="lblASSTextSlideEffect" />
											</td>
											<td>
												<div class="styledSelect">
													<asp:DropDownList ID="ddlASSTextTransitionEffect" runat="server">
														<asp:ListItem resourcekey="lifade" Value="fade">Fade</asp:ListItem>
														<asp:ListItem resourcekey="liUp" Value="up">Up</asp:ListItem>
														<asp:ListItem resourcekey="liDown" Value="down">Down</asp:ListItem>
														<asp:ListItem resourcekey="liLeft" Value="left">Left</asp:ListItem>
														<asp:ListItem resourcekey="LiRight" Value="right">Right</asp:ListItem>
													</asp:DropDownList>
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblASSSyncEffect" runat="server" HelpText="Sync image and text transition effect:" Text="Sync effects:" HelpKey="lblASSSyncEffect.HelpKey" ResourceKey="lblASSSyncEffect" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbASSSyncEffects" runat="server" OnCheckedChanged="cbASSNestedResizeCrop_CheckedChanged" Text="Sync effects:" />
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblASSPAuse" runat="server" HelpText="Pause between transitions:" Text="Pause between transitions:" HelpKey="lblASSPAuse.HelpKey" ResourceKey="lblASSPAuse" />
											</td>
											<td>
												<asp:TextBox ID="tbASSSSDuration" runat="server" CssClass="small textCenter">5000</asp:TextBox>
												<asp:RequiredFieldValidator ID="rfvLightBoxGalleryNumberOfColumns14" runat="server" ControlToValidate="tbASSSSDuration" Display="Dynamic" ErrorMessage="This field is required." resourcekey="rfvLightBoxGalleryNumberOfColumnsResource1.ErrorMessage" ValidationGroup="vgADVSSSettings" CssClass="smallInfo warning"></asp:RequiredFieldValidator>
												<asp:CompareValidator ID="cvLightBoxGalleryNumberOfColumns14" runat="server" ControlToValidate="tbASSSSDuration" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" resourcekey="cvLightBoxGalleryNumberOfColumnsResource1.ErrorMessage" Type="Integer" ValidationGroup="vgADVSSSettings" CssClass="smallInfo warning"></asp:CompareValidator>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblASStransitionSpeed" runat="server" HelpText="Transition speed:" Text="Transition speed:" HelpKey="lblASStransitionSpeed.HelpKey" ResourceKey="lblASStransitionSpeed" />
											</td>
											<td>
												<asp:TextBox ID="tbASSIntervalSpeed" runat="server" CssClass="small textCenter">1000</asp:TextBox>
												<asp:RequiredFieldValidator ID="rfvLightBoxGalleryNumberOfColumns16" runat="server" ControlToValidate="tbASSIntervalSpeed" Display="Dynamic" ErrorMessage="This field is required." resourcekey="rfvLightBoxGalleryNumberOfColumnsResource1.ErrorMessage" ValidationGroup="vgADVSSSettings" CssClass="smallInfo warning"></asp:RequiredFieldValidator>
												<asp:CompareValidator ID="cvLightBoxGalleryNumberOfColumns16" runat="server" ControlToValidate="tbASSIntervalSpeed" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" resourcekey="cvLightBoxGalleryNumberOfColumnsResource1.ErrorMessage" Type="Integer" ValidationGroup="vgADVSSSettings" CssClass="smallInfo warning"></asp:CompareValidator>
											</td>
										</tr>
										<tr>
											<td class="textTop">
												<dnn:Label ID="lblASSTolltipPosition" runat="server" HelpText="Enter toltip position corditanes::" Text="Tolltip position:" HelpKey="lblASSTolltipPosition.HelpKey" ResourceKey="lblASSTolltipPosition" />
											</td>
											<td>
												<table class="clearWidth textLeft">
													<tr>
														<td>
															<asp:Label ID="lblASSTTTop" runat="server" resourcekey="lblASSTTTop" Text="Top:"></asp:Label>
														</td>
														<td>
															<asp:TextBox ID="tbASSTooltipTop" runat="server" ValidationGroup="vgADVSSSettings" CssClass="small textCenter">15</asp:TextBox>
															<asp:RequiredFieldValidator ID="rfvLightBoxGalleryNumberOfColumns10" runat="server" ControlToValidate="tbASSTooltipTop" Display="Dynamic" ErrorMessage="This field is required." resourcekey="rfvLightBoxGalleryNumberOfColumnsResource1.ErrorMessage" SetFocusOnError="True" ValidationGroup="vgADVSSSettings" CssClass="smallInfo warning"></asp:RequiredFieldValidator>
															<asp:CompareValidator ID="cvLightBoxGalleryNumberOfColumns10" runat="server" ControlToValidate="tbASSTooltipTop" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" resourcekey="cvLightBoxGalleryNumberOfColumnsResource1.ErrorMessage" SetFocusOnError="True" Type="Integer" ValidationGroup="vgADVSSSettings" CssClass="smallInfo warning"></asp:CompareValidator>
														</td>
														<td>&nbsp;</td>
														<td>
															<asp:Label ID="lblASSTTLeft" runat="server" resourcekey="lblASSTTLeft" Text="Left:"></asp:Label>
														</td>
														<td>
															<asp:TextBox ID="tbASSToltipLeft" runat="server" ValidationGroup="vgADVSSSettings" CssClass="small textCenter">15</asp:TextBox>
															<asp:RequiredFieldValidator ID="rfvLightBoxGalleryNumberOfColumns11" runat="server" ControlToValidate="tbASSToltipLeft" Display="Dynamic" ErrorMessage="This field is required." resourcekey="rfvLightBoxGalleryNumberOfColumnsResource1.ErrorMessage" SetFocusOnError="True" ValidationGroup="vgADVSSSettings" CssClass="smallInfo warning"></asp:RequiredFieldValidator>
															<asp:CompareValidator ID="cvLightBoxGalleryNumberOfColumns11" runat="server" ControlToValidate="tbASSToltipLeft" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" resourcekey="cvLightBoxGalleryNumberOfColumnsResource1.ErrorMessage" SetFocusOnError="True" Type="Integer" ValidationGroup="vgADVSSSettings" CssClass="smallInfo warning"></asp:CompareValidator>
														</td>
													</tr>
													<tr>
														<td>
															<asp:Label ID="lblASSTTWidth" runat="server" resourcekey="lblASSTTWidth" Text="Width:"></asp:Label>
														</td>
														<td>
															<asp:TextBox ID="tbASSTooltipWidth" runat="server" ValidationGroup="vgADVSSSettings" CssClass="small textCenter">340</asp:TextBox>
															<asp:RequiredFieldValidator ID="rfvLightBoxGalleryNumberOfColumns12" runat="server" ControlToValidate="tbASSTooltipWidth" Display="Dynamic" ErrorMessage="This field is required." resourcekey="rfvLightBoxGalleryNumberOfColumnsResource1.ErrorMessage" SetFocusOnError="True" ValidationGroup="vgADVSSSettings" CssClass="smallInfo warning"></asp:RequiredFieldValidator>
															<asp:CompareValidator ID="cvLightBoxGalleryNumberOfColumns12" runat="server" ControlToValidate="tbASSTooltipWidth" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" resourcekey="cvLightBoxGalleryNumberOfColumnsResource1.ErrorMessage" SetFocusOnError="True" Type="Integer" ValidationGroup="vgADVSSSettings" CssClass="smallInfo warning"></asp:CompareValidator>
														</td>
														<td>&nbsp;</td>
														<td>
															<asp:Label ID="lblASSTTHeight" runat="server" resourcekey="lblASSTTHeight" Text="Height:"></asp:Label>
														</td>
														<td>
															<asp:TextBox ID="tbASSTooltipHeight" runat="server" ValidationGroup="vgADVSSSettings" CssClass="small textCenter">100</asp:TextBox>
															<asp:RequiredFieldValidator ID="rfvLightBoxGalleryNumberOfColumns13" runat="server" ControlToValidate="tbASSTooltipHeight" Display="Dynamic" ErrorMessage="This field is required." resourcekey="rfvLightBoxGalleryNumberOfColumnsResource1.ErrorMessage" SetFocusOnError="True" ValidationGroup="vgADVSSSettings" CssClass="smallInfo warning"></asp:RequiredFieldValidator>
															<asp:CompareValidator ID="cvLightBoxGalleryNumberOfColumns13" runat="server" ControlToValidate="tbASSTooltipHeight" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" resourcekey="cvLightBoxGalleryNumberOfColumnsResource1.ErrorMessage" SetFocusOnError="True" Type="Integer" ValidationGroup="vgADVSSSettings" CssClass="smallInfo warning"></asp:CompareValidator>
														</td>
													</tr>
												</table>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblLightBoxGalleryOpenMediaUrl0" ResourceKey="lblLightBoxGalleryOpenMediaUrl" runat="server" HelpText="On image click dont open image in lightbox, but open Media Url link." Text="On click go to Media Url:" HelpKey="lblLightBoxGalleryOpenMediaUrl.HelpText" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbASSGalleryOpenMediaUrl" runat="server" AutoPostBack="True" OnCheckedChanged="cbASSGalleryOpenMediaUrl_CheckedChanged" resourcekey="cbLightBoxGalleryOpenMediaUrlResource1" Text="On click go to Media Url" />
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblLightBoxGalleryOpenMediaUrlNewWindow0" ResourceKey="lblLightBoxGalleryOpenMediaUrlNewWindow" runat="server" HelpText="Open link in new window:" Text="Open link in new window:" HelpKey="lblLightBoxGalleryOpenMediaUrlNewWindow.HelpText" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbASSOpenMediaUrlNewWindow" runat="server" Enabled="False" resourcekey="cbLightBoxGalleryOpenMediaUrlNewWindowResource1" Text="Open link in new window" />
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblASSThumbWidth" runat="server" HelpText="Thumb width:" Text="Thumb width:" HelpKey="lblASSThumbWidth.HelpKey" ResourceKey="lblASSThumbWidth" />
											</td>
											<td>
												<asp:TextBox ID="tbASSImageWidth" runat="server" ValidationGroup="vgADVSSSettings" CssClass="small textCenter">75</asp:TextBox>
												<asp:RequiredFieldValidator ID="rfvLightBoxGalleryImageWidth1" runat="server" ControlToValidate="tbASSImageWidth" ErrorMessage="This field is required." ValidationGroup="vgADVSSSettings" Display="Dynamic" resourcekey="rfvLightBoxGalleryImageWidthResource1.ErrorMessage" CssClass="smallInfo warning"></asp:RequiredFieldValidator>
												<asp:CompareValidator ID="cvLightBoxGalleryImageWidth1" runat="server" ControlToValidate="tbASSImageWidth" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" Type="Integer" ValidationGroup="vgADVSSSettings" resourcekey="cvLightBoxGalleryImageWidthResource1.ErrorMessage" CssClass="smallInfo warning"></asp:CompareValidator>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblASSThumbHeight" runat="server" HelpText="Thumb height:" Text="Thumb height:" HelpKey="lblASSThumbHeight.HelpKey" ResourceKey="lblASSThumbHeight" />
											</td>
											<td>
												<asp:TextBox ID="tbASSImageHeight" runat="server" ValidationGroup="vgADVSSSettings" CssClass="small textCenter">75</asp:TextBox>
												<asp:RequiredFieldValidator ID="rfvLightBoxGalleryImageHeight1" runat="server" ControlToValidate="tbASSImageHeight" ErrorMessage="This field is required." ValidationGroup="vgADVSSSettings" Display="Dynamic" resourcekey="rfvLightBoxGalleryImageHeightResource1.ErrorMessage" CssClass="smallInfo warning"></asp:RequiredFieldValidator>
												<asp:CompareValidator ID="cvLightBoxGalleryImageHeight1" runat="server" ControlToValidate="tbASSImageHeight" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" Type="Integer" ValidationGroup="vgADVSSSettings" resourcekey="cvLightBoxGalleryImageHeightResource1.ErrorMessage" CssClass="smallInfo warning"></asp:CompareValidator>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblLightBoxGalleryImageWidth0" runat="server" ControlName="tbTGImageWidth" HelpKey="lblLightBoxGalleryImageWidth.HelpText" HelpText="Set the maximum image width for resizing:" ResourceKey="lblLightBoxGalleryImageWidth" Text="Maximum image width:" />
											</td>
											<td>
												<asp:TextBox ID="tbASSNGImageWidth" runat="server" CssClass="small textCenter" ValidationGroup="vgADVSSSettings">700</asp:TextBox>
												<asp:RequiredFieldValidator ID="rfvLightboxGalleryNestedImageWidth1" runat="server" ControlToValidate="tbASSNGImageWidth" Display="Dynamic" ErrorMessage="This field is required." resourcekey="rfvLightboxGalleryNestedImageWidthResource1.ErrorMessage" SetFocusOnError="True" ValidationGroup="vgADVSSSettings" CssClass="smallInfo warning"></asp:RequiredFieldValidator>
												<asp:CompareValidator ID="cvLightboxGalleryNestedImageWidth1" runat="server" ControlToValidate="tbASSNGImageWidth" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" resourcekey="cvLightboxGalleryNestedImageWidthResource1.ErrorMessage" SetFocusOnError="True" Type="Integer" ValidationGroup="vgADVSSSettings" CssClass="smallInfo warning"></asp:CompareValidator>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblLightBoxGallerySetImageHeight0" runat="server" ControlName="tbTGImageHeight" HelpKey="lblLightBoxGallerySetImageHeight.HelpText" HelpText="Set the maximum image height for resizing:" Text="Maximum image height: " ResourceKey="lblLightBoxGallerySetImageHeight" />
											</td>
											<td>
												<asp:TextBox ID="tbASSNGImageHeight" runat="server" CssClass="small textCenter" ValidationGroup="vgADVSSSettings">500</asp:TextBox>
												<asp:RequiredFieldValidator ID="rfvLightboxGalleryNestedImageHeight1" runat="server" ControlToValidate="tbASSNGImageHeight" Display="Dynamic" ErrorMessage="This field is required." resourcekey="rfvLightboxGalleryNestedImageHeightResource1.ErrorMessage" SetFocusOnError="True" ValidationGroup="vgADVSSSettings" CssClass="smallInfo warning"></asp:RequiredFieldValidator>
												<asp:CompareValidator ID="cvLightboxGalleryNestedImageHeight1" runat="server" ControlToValidate="tbASSNGImageHeight" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" resourcekey="cvLightboxGalleryNestedImageHeightResource1.ErrorMessage" SetFocusOnError="True" Type="Integer" ValidationGroup="vgADVSSSettings" CssClass="smallInfo warning"></asp:CompareValidator>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblASSNumberOfColumns" runat="server" HelpText="Set the number of thumbnail columns:" Text="Number of thumbnail columns:" HelpKey="lblASSNumberOfColumns.HelpKey" ResourceKey="lblASSNumberOfColumns" />
											</td>
											<td>
												<asp:TextBox ID="tbASSNumberOfColumns" runat="server" ValidationGroup="vgADVSSSettings" CssClass="small textCenter">4</asp:TextBox>
												<asp:RequiredFieldValidator ID="rfvLightBoxGalleryNumberOfColumns15" runat="server" ControlToValidate="tbASSNumberOfColumns" Display="Dynamic" ErrorMessage="This field is required." resourcekey="rfvLightBoxGalleryNumberOfColumnsResource1.ErrorMessage" ValidationGroup="vgADVSSSettings" CssClass="smallInfo warning"></asp:RequiredFieldValidator>
												<asp:CompareValidator ID="cvLightBoxGalleryNumberOfColumns15" runat="server" ControlToValidate="tbASSNumberOfColumns" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" resourcekey="cvLightBoxGalleryNumberOfColumnsResource1.ErrorMessage" Type="Integer" ValidationGroup="vgADVSSSettings" CssClass="smallInfo warning"></asp:CompareValidator>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblASSThumbnailRows" runat="server" Text="Number of thumbnail rows:" HelpText="Set the number of thumbnail rows:" HelpKey="lblASSThumbnailRows.HelpKey" ResourceKey="lblASSThumbnailRows"></dnn:Label>
											</td>
											<td>
												<asp:TextBox ID="tbASSItems" runat="server" ValidationGroup="vgADVSSSettings" CssClass="small textCenter">2</asp:TextBox>
												<asp:RequiredFieldValidator ID="rfvLightBoxGalleryNumberOfItems1" runat="server" ControlToValidate="tbASSItems" ErrorMessage="This field is required." ValidationGroup="vgADVSSSettings" Display="Dynamic" resourcekey="rfvLightBoxGalleryNumberOfItemsResource1.ErrorMessage" CssClass="smallInfo warning"></asp:RequiredFieldValidator>
												<asp:CompareValidator ID="cvLightBoxGalleryNumberOfItems1" runat="server" ControlToValidate="tbASSItems" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" Type="Integer" ValidationGroup="vgADVSSSettings" resourcekey="cvLightBoxGalleryNumberOfItemsResource1.ErrorMessage" CssClass="smallInfo warning"></asp:CompareValidator>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblLightBoxGalleryCropImages0" ResourceKey="lblLightBoxGalleryCropImages" runat="server" Text="Resize and crop vertical images:" ControlName="cbSmartCropVertical" HelpText="Set this to crop vertical images:" HelpKey="lblLightBoxGalleryCropImages.HelpText"></dnn:Label>
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbASSSmartCropVertical" runat="server" OnCheckedChanged="cbSmartCropVertical_CheckedChanged" resourcekey="cbLightBoxGallerySmartCropVerticalResource1" Text="Resize and crop vertical images" />
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblLightBoxGalleryResizeCrop0" ResourceKey="lblLightBoxGalleryResizeCrop" runat="server" Text="Resize and crop all images:" ControlName="cbTGSmartResizeAndCrop" HelpText="Set this this to resize all images to same width and height:" HelpKey="lblLightBoxGalleryResizeCrop.HelpText"></dnn:Label>
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbASSResizeAndCrop" runat="server" OnCheckedChanged="cbTGSmartResizeAndCrop_CheckedChanged" Checked="True" resourcekey="cbLightBoxGalleryResizeAndCropResource1" Text="Resize and crop all images" />
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblLightBoxRandomizeMedia0" runat="server" HelpKey="lblLightBoxRandomizeMedia.HelpText" HelpText="Randomize media positions on every page load:" ResourceKey="lblLightBoxRandomizeMedia" Text="Randomize media positions:" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbASSRandomizeMedia" runat="server" OnCheckedChanged="cbASSRandomizeMedia_CheckedChanged" resourcekey="cbLightBoxGallerySmartCropVerticalResource1" AutoPostBack="True" Text="Randomize media positions" />
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="Label6" runat="server" HelpText="Select media sorting options:" Text="Media sorting:" HelpKey="lblLightBoxMediaSorting.HelpText" ResourceKey="lblLightBoxMediaSorting" />
											</td>
											<td>
												<table class="clearWidth textLeft">
													<tr>
														<td>
															<div class="styledSelect">
																<asp:DropDownList ID="ddlASSMediaSort" runat="server">
																	<asp:ListItem resourcekey="liPosition" Value="Position">Position</asp:ListItem>
																	<asp:ListItem resourcekey="liDateUploaded" Value="DateUploaded">Date uploaded</asp:ListItem>
																	<asp:ListItem resourcekey="liFileName" Value="FileName">Filename</asp:ListItem>
																	<asp:ListItem resourcekey="liTitle">Title</asp:ListItem>
																</asp:DropDownList>
															</div>
														</td>
														<td>&nbsp;</td>
														<td>
															<asp:RadioButtonList ID="rblASSMediaSortType" runat="server" RepeatDirection="Horizontal" CssClass="styledRadio small">
																<asp:ListItem resourcekey="liAscending" Selected="True" Value="ASC">Ascending</asp:ListItem>
																<asp:ListItem resourcekey="liDescending" Value="DESC">Descending</asp:ListItem>
															</asp:RadioButtonList>
														</td>
													</tr>
												</table>
											</td>
										</tr>
									</table>
									<asp:Label ID="lblASSGalleryStatus" runat="server" EnableViewState="False"></asp:Label>
									<div class="mainActions">
										<asp:LinkButton ID="btnAdvancedSlideShowSaveSettings" runat="server" OnClick="btnAdvancedSlideShowSaveSettings_Click" resourcekey="btnLightBoxGallerySaveResource1" Text="Save settings" ValidationGroup="vgADVSSSettings" CssClass="downSave" />
										<asp:LinkButton ID="btnAdvancedSlideShowSaveClose" runat="server" OnClick="btnAdvancedSlideShowSaveClose_Click" resourcekey="btnLightBoxGallerySaveCloseResource1" Text="Save &amp; Close" ValidationGroup="vgADVSSSettings" CssClass="downSaveClose" />
									</div>
								</div>
							</asp:Panel>
							<asp:Panel ID="pnlVerticalCarousel" runat="server" Visible="False" CssClass="settingsList negativeMargins40">
								<h3>
									<asp:Label ID="lblVerticalCarousel" resourcekey="lblVerticalCarousel" runat="server" CssClass="settingsdetailtitle" Text="Vertical carousel display settings"></asp:Label>
								</h3>
								<div class="settingsTable">
									<table>
										<tr>
											<td>
												<dnn:Label ID="lblVerticalCarouselTemplateSelect" runat="server" ControlName="ddlSSThemeSelect" HelpKey="lblVerticalCarouselTemplateSelect.HelpText" HelpText="Select the control viewer template:" ResourceKey="lblVerticalCarouselTemplateSelect" Text="Select template:" />
											</td>
											<td>
												<div class="styledSelect">
													<asp:DropDownList ID="ddlVerticalTemplateSelect" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlVerticalTemplateSelect_SelectedIndexChanged"></asp:DropDownList>
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblVerticalCarouselThemeSelect" runat="server" ControlName="ddlSSThemeSelect" HelpKey="lblImageCarouselThemeSelect.HelpText" HelpText="Select the CSS theme file:" ResourceKey="lblImageCarouselThemeSelect" Text="Select CSS:" />
											</td>
											<td>
												<div class="styledSelect">
													<asp:DropDownList ID="ddlVerticalThemeSelect" runat="server"></asp:DropDownList>
												</div>
												<div>
													<asp:Label ID="lblVerticalCarouselTemplateInfo" runat="server"></asp:Label>
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblVerticalCarouselShowMediaTitle" ResourceKey="lblVerticalCarouselShowMediaTitle" runat="server" HelpText="Show image title:" Text="Show image title:" HelpKey="lblVerticalCarouselShowMediaTitle.HelpText" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbVerticalCarouselShowMediaTitle" runat="server" resourcekey="cbImageCarouselShowMediaTitleResource1" Checked="True" Text="Show image title" />
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblVerticalCarouselShowMediaDescription" ResourceKey="lblVerticalCarouselShowMediaDescription" runat="server" HelpText="Show image description:" Text="Show image description:" HelpKey="lblVerticalCarouselShowMediaDescription.HelpText" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbVerticalCarouselShowMediaDescription" runat="server" resourcekey="cbImageCarouselShowMediaDescriptionResource1" Checked="True" Text="Show image description" />
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblVerticalCarouselShowLightboxTitle" ResourceKey="lblVerticalCarouselShowLightboxTitle" runat="server" HelpText="Show image title in lightbox:" Text="Show image title in lightbox:" HelpKey="lblVerticalCarouselShowLightboxTitle.HelpText" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbVerticalCarouselShowLightboxTitle" runat="server" resourcekey="cbImageCarouselShowLightboxTitleResource1" Text="Show image title in lightbox" />
												</div>
											</td>
										</tr>
										<tr>
											<td class="textTop">
												<dnn:Label ID="lblVerticalCarouselShowLightBoxDescription" ResourceKey="lblVerticalCarouselShowLightBoxDescription" runat="server" HelpText="Show image description in lightbox:" Text="Show image description in lightbox:" HelpKey="lblVerticalCarouselShowLightBoxDescription.HelpText" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbVerticalCarouselShowLightboxDescription" runat="server" resourcekey="cbImageCarouselShowLightboxDescriptionResource1" AutoPostBack="True" OnCheckedChanged="cbVerticalCarouselShowLightboxDescription_CheckedChanged" Text="Show image description in lightbox" />
												</div>
												<asp:Panel ID="pnlVerticalCarouselTipOptions" runat="server" BackColor="#CBEEF8" BorderColor="#65CDEB" BorderStyle="Solid" BorderWidth="2px" Visible="False">
													<table>
														<tr>
															<td colspan="2">
																<asp:Label ID="lblVerticalCarouselToolTipOptions0" runat="server" Font-Bold="True" resourcekey="lblLightBoxToolTipOptions" Text="Tooltip options"></asp:Label>
															</td>
														</tr>
														<tr>
															<td>
																<asp:Label ID="lblImageSliderLightboxShowTooltips0" runat="server" resourcekey="lblLightboxShowToolTips" Text="Show Tooltips:"></asp:Label>
															</td>
															<td>
																<asp:CheckBox ID="cbVerticalCarouselShowToolTips" runat="server" Checked="True" />
															</td>
														</tr>
														<tr>
															<td>
																<asp:Label ID="lblVerticalCarouselTargetPosition" runat="server" resourcekey="lblLightboxTargetPosition" Text="Target position:"></asp:Label>
															</td>
															<td>
																<asp:DropDownList ID="ddlVerticalCarouselTargetPosition" runat="server">
																	<asp:ListItem resourcekey="topLeft" Value="topLeft">Top left</asp:ListItem>
																	<asp:ListItem resourcekey="topMiddle" Value="topMiddle" Selected="True">Top middle</asp:ListItem>
																	<asp:ListItem resourcekey="topRight" Value="topRight">Top right</asp:ListItem>
																	<asp:ListItem resourcekey="leftTop" Value="leftTop">Left top</asp:ListItem>
																	<asp:ListItem resourcekey="leftMiddle" Value="leftMiddle">Left middle</asp:ListItem>
																	<asp:ListItem resourcekey="leftBottom" Value="leftBottom">Left bottom</asp:ListItem>
																	<asp:ListItem resourcekey="center" Value="center">Center</asp:ListItem>
																	<asp:ListItem resourcekey="rightTop" Value="rightTop">Right top</asp:ListItem>
																	<asp:ListItem resourcekey="rightMiddle" Value="rightMiddle">Right middle</asp:ListItem>
																	<asp:ListItem resourcekey="rightBottom" Value="rightBottom">Right bottom</asp:ListItem>
																	<asp:ListItem resourcekey="bottomLeft" Value="bottomLeft">Bottom left</asp:ListItem>
																	<asp:ListItem resourcekey="bottomMiddle" Value="bottomMiddle">Bottom middle</asp:ListItem>
																	<asp:ListItem resourcekey="bottomRight" Value="bottomRight">Bottom right</asp:ListItem>
																</asp:DropDownList>
															</td>
														</tr>
														<tr>
															<td>
																<asp:Label ID="lblVerticalCarouselTooltipPosition" runat="server" resourcekey="lblLightboxTooltipPosition" Text="Tooltip position:"></asp:Label>
															</td>
															<td>
																<asp:DropDownList ID="ddlVerticalCarouselTooltipPosition" runat="server">
																	<asp:ListItem resourcekey="topLeft" Value="topLeft">Top left</asp:ListItem>
																	<asp:ListItem resourcekey="topMiddle" Value="topMiddle">Top middle</asp:ListItem>
																	<asp:ListItem resourcekey="topRight" Value="topRight">Top right</asp:ListItem>
																	<asp:ListItem resourcekey="leftTop" Value="leftTop">Left top</asp:ListItem>
																	<asp:ListItem resourcekey="leftMiddle" Value="leftMiddle">Left middle</asp:ListItem>
																	<asp:ListItem resourcekey="leftBottom" Value="leftBottom">Left bottom</asp:ListItem>
																	<asp:ListItem resourcekey="center" Value="center">Center</asp:ListItem>
																	<asp:ListItem resourcekey="rightTop" Value="rightTop">Right top</asp:ListItem>
																	<asp:ListItem resourcekey="rightMiddle" Value="rightMiddle">Right middle</asp:ListItem>
																	<asp:ListItem resourcekey="rightBottom" Value="rightBottom">Right bottom</asp:ListItem>
																	<asp:ListItem resourcekey="bottomLeft" Value="bottomLeft">Bottom left</asp:ListItem>
																	<asp:ListItem resourcekey="bottomMiddle" Selected="True" Value="bottomMiddle">Bottom
															middle</asp:ListItem>
																	<asp:ListItem resourcekey="bottomRight" Value="bottomRight">Bottom right</asp:ListItem>
																</asp:DropDownList>
															</td>
														</tr>
														<tr>
															<td>
																<asp:Label ID="lblVerticalCarouselShowEffect" runat="server" resourcekey="lblLightboxShowEffect" Text="Show effect:"></asp:Label>
															</td>
															<td>
																<asp:DropDownList ID="ddlVerticalCarouselShoweffect" runat="server">
																	<asp:ListItem resourcekey="fade" Value="fade">Fade</asp:ListItem>
																	<asp:ListItem resourcekey="slide" Value="slide">Slide</asp:ListItem>
																	<asp:ListItem resourcekey="grow" Value="grow">Grow</asp:ListItem>
																</asp:DropDownList>
															</td>
														</tr>
														<tr>
															<td>
																<asp:Label ID="lblVerticalCarouselShowEffectDuration" runat="server" resourcekey="lblLightboxShowEffectDuration" Text="Show effect duration (ms):"></asp:Label>
															</td>
															<td>
																<asp:TextBox ID="tbVerticalCarouselTooltipShowDuration" runat="server" Width="53px">500</asp:TextBox>
																<asp:RequiredFieldValidator ID="rfvImageCarouselImageWidth4" runat="server" ControlToValidate="tbVerticalCarouselTooltipShowDuration" Display="Dynamic" ErrorMessage="This field is required." resourcekey="rfvImageCarouselImageWidthResource1.ErrorMessage"
																	SetFocusOnError="True" ValidationGroup="vgVerticalCarouselSettings">
																</asp:RequiredFieldValidator>
																<asp:CompareValidator ID="cvImageCarouselImageWidth4" runat="server" ControlToValidate="tbVerticalCarouselTooltipShowDuration" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" resourcekey="cvImageCarouselImageWidthResource1.ErrorMessage"
																	SetFocusOnError="True" Type="Integer" ValidationGroup="vgVerticalCarouselSettings">
																</asp:CompareValidator>
															</td>
														</tr>
														<tr>
															<td>
																<asp:Label ID="lblVerticalCarouselShowHideEffect" runat="server" resourcekey="lblLightboxShowHideEffect" Text="Hide effect:"></asp:Label>
															</td>
															<td>
																<asp:DropDownList ID="ddlVerticalCarouselHideEffect" runat="server">
																	<asp:ListItem resourcekey="fade" Value="fade">Fade</asp:ListItem>
																	<asp:ListItem resourcekey="slide" Value="slide">Slide</asp:ListItem>
																	<asp:ListItem resourcekey="grow" Value="grow">Grow</asp:ListItem>
																</asp:DropDownList>
															</td>
														</tr>
														<tr>
															<td>
																<asp:Label ID="lblVerticalCarouselHideEffectDuration" runat="server" resourcekey="lblLightboxHideEffectDuration" Text="Hide effect duration (ms):"></asp:Label>
															</td>
															<td>
																<asp:TextBox ID="tbVerticalCarouselTooltipHideDuration" runat="server" Width="53px">500</asp:TextBox>
																<asp:RequiredFieldValidator ID="rfvImageCarouselImageWidth5" runat="server" ControlToValidate="tbVerticalCarouselTooltipHideDuration" Display="Dynamic" ErrorMessage="This field is required." resourcekey="rfvImageCarouselImageWidthResource1.ErrorMessage"
																	SetFocusOnError="True" ValidationGroup="vgVerticalCarouselSettings">
																</asp:RequiredFieldValidator>
																<asp:CompareValidator ID="cvImageCarouselImageWidth5" runat="server" ControlToValidate="tbVerticalCarouselTooltipHideDuration" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" resourcekey="cvImageCarouselImageWidthResource1.ErrorMessage"
																	SetFocusOnError="True" Type="Integer" ValidationGroup="vgVerticalCarouselSettings">
																</asp:CompareValidator>
															</td>
														</tr>
														<tr>
															<td>
																<asp:Label ID="lblVerticalCarouselTooltipBorder" runat="server" resourcekey="lblLightboxTooltipBorder" Text="Border:"></asp:Label>
															</td>
															<td>
																<asp:TextBox ID="tbVerticalCarouselTooltipBorder" runat="server" Width="53px">5</asp:TextBox>
																<asp:RequiredFieldValidator ID="rfvImageCarouselImageWidth6" runat="server" ControlToValidate="tbVerticalCarouselTooltipBorder" Display="Dynamic" ErrorMessage="This field is required." resourcekey="rfvImageCarouselImageWidthResource1.ErrorMessage" SetFocusOnError="True"
																	ValidationGroup="vgVerticalCarouselSettings">
																</asp:RequiredFieldValidator>
																<asp:CompareValidator ID="cvImageCarouselImageWidth6" runat="server" ControlToValidate="tbVerticalCarouselTooltipBorder" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" resourcekey="cvImageCarouselImageWidthResource1.ErrorMessage"
																	SetFocusOnError="True" Type="Integer" ValidationGroup="vgVerticalCarouselSettings">
																</asp:CompareValidator>
															</td>
														</tr>
														<tr>
															<td>
																<asp:Label ID="lblVerticalCarouselTooltipCornerRadius" runat="server" resourcekey="lblLightboxTooltipCornerRadius" Text="Corner radius:"></asp:Label>
															</td>
															<td>
																<asp:TextBox ID="tbVerticalCarouselTooltipCornerRadius" runat="server" Width="53px">5</asp:TextBox>
																<asp:RequiredFieldValidator ID="rfvImageCarouselImageWidth7" runat="server" ControlToValidate="tbVerticalCarouselTooltipCornerRadius" Display="Dynamic" ErrorMessage="This field is required." resourcekey="rfvImageCarouselImageWidthResource1.ErrorMessage"
																	SetFocusOnError="True" ValidationGroup="vgVerticalCarouselSettings">
																</asp:RequiredFieldValidator>
																<asp:CompareValidator ID="cvImageCarouselImageWidth7" runat="server" ControlToValidate="tbVerticalCarouselTooltipCornerRadius" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" resourcekey="cvImageCarouselImageWidthResource1.ErrorMessage"
																	SetFocusOnError="True" Type="Integer" ValidationGroup="vgVerticalCarouselSettings">
																</asp:CompareValidator>
															</td>
														</tr>
														<tr>
															<td>
																<asp:Label ID="lblVerticalCarouselTooltipTheme" runat="server" resourcekey="lblLightboxTooltipTheme" Text="Select theme:"></asp:Label>
															</td>
															<td>
																<asp:DropDownList ID="ddlVerticalCarouselTooltipTheme" runat="server">
																	<asp:ListItem resourcekey="cream" Value="cream">Yellow</asp:ListItem>
																	<asp:ListItem resourcekey="dark" Value="dark">Dark</asp:ListItem>
																	<asp:ListItem resourcekey="green" Value="green">Green</asp:ListItem>
																	<asp:ListItem resourcekey="light" Value="light">Light</asp:ListItem>
																	<asp:ListItem resourcekey="red" Value="red">Red</asp:ListItem>
																	<asp:ListItem resourcekey="blue" Value="blue">Blue</asp:ListItem>
																</asp:DropDownList>
															</td>
														</tr>
													</table>
												</asp:Panel>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblVerticalCarouselOpenMediaUrl" ResourceKey="lblVerticalCarouselOpenMediaUrl" runat="server" HelpText="On image click dont open image in lightbox, but open Media Url link." Text="On click go to Media Url:" HelpKey="lblVerticalCarouselOpenMediaUrl.HelpText" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbVerticalCarouselOpenMediaUrl" runat="server" AutoPostBack="True" OnCheckedChanged="cbVerticalCarouselOpenMediaUrl_CheckedChanged" resourcekey="cbImageCarouselOpenMediaUrlResource1" Text="On click go to Media Url" />
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblVerticalCarouselOpenMediaUrlNewWindow" ResourceKey="lblVerticalCarouselOpenMediaUrlNewWindow" runat="server" HelpText="Open link in new window:" Text="Open link in new window:" HelpKey="lblVerticalCarouselOpenMediaUrlNewWindow.HelpText" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbVerticalCarouselOpenMediaUrlNewWindow" runat="server" Enabled="False" resourcekey="cbImageCarouselOpenMediaUrlNewWindowResource1" Text="Open link in new window" />
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblVerticalCarouselMaxImageWidth" ResourceKey="lblVerticalCarouselMaxImageWidth" runat="server" ControlName="tbMaxImageWidth" HelpText="Maximum  image width for proportional resizing:" Text="Maximum image width:" HelpKey="lblVerticalCarouselMaxImageWidth.HelpText" />
											</td>
											<td>
												<asp:TextBox ID="tbVerticalCarouselMaxImageWidth" runat="server" ValidationGroup="vgVerticalCarouselSettings" CssClass="small textCenter">600</asp:TextBox>
												<asp:RequiredFieldValidator ID="rfvVerticalCarouselImageWidth" runat="server" ControlToValidate="tbVerticalCarouselMaxImageWidth" Display="Dynamic" ErrorMessage="This field is required." ValidationGroup="vgVerticalCarouselSettings" resourcekey="rfvVerticalCarouselImageWidth.ErrorMessage" CssClass="smallInfo warning"></asp:RequiredFieldValidator>
												<asp:CompareValidator ID="cvVerticalCarouselImageWidth" runat="server" ControlToValidate="tbVerticalCarouselMaxImageWidth" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" Type="Integer" ValidationGroup="vgVerticalCarouselSettings" resourcekey="cvVerticalCarouselImageWidth.ErrorMessage" CssClass="smallInfo warning"></asp:CompareValidator>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblVerticalCarouselMaxImageHeight" ResourceKey="lblVerticalCarouselMaxImageHeight" runat="server" ControlName="tbMaxImageHeight" HelpText="Maximum  image width for proportional resizing:" Text="Maximum image height:" HelpKey="lblVerticalCarouselMaxImageHeight.HelpText" />
											</td>
											<td>
												<asp:TextBox ID="tbVerticalCaruselMaxImageHeight" runat="server" ValidationGroup="vgVerticalCarouselSettings" CssClass="small textCenter">400</asp:TextBox>
												<asp:RequiredFieldValidator ID="rfvVerticalCarouselImageHeight" runat="server" ControlToValidate="tbVerticalCaruselMaxImageHeight" Display="Dynamic" ErrorMessage="This field is required." ValidationGroup="vgVerticalCarouselSettings" resourcekey="rfvVerticalCarouselImageHeight.ErrorMessage" CssClass="smallInfo warning"></asp:RequiredFieldValidator>
												<asp:CompareValidator ID="cvVerticalCarouselImageHeight" runat="server" ControlToValidate="tbVerticalCaruselMaxImageHeight" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" Type="Integer" ValidationGroup="vgVerticalCarouselSettings" resourcekey="cvVerticalCarouselImageHeight.ErrorMessage" CssClass="smallInfo warning"></asp:CompareValidator>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblVerticalCarouselAutoSlidePause" ResourceKey="lblVerticalCarouselAutoSlidePause" runat="server" ControlName="tbAutoSlidePause" HelpText="Set the pause between images when in auto slide mode:" Text="Auto slide pause between imags (ms): " HelpKey="lblVerticalCarouselAutoSlidePause.HelpText" />
											</td>
											<td>
												<asp:Panel ID="pnlSlideOpt2" runat="server">
													<asp:TextBox ID="tbVerticalCarouselAutoSlidePause" runat="server" ValidationGroup="vgVerticalCarouselSettings" CssClass="small textCenter">5000</asp:TextBox>
													<asp:RequiredFieldValidator ID="rfvVerticalCarouselAutoSlidePause" runat="server" ControlToValidate="tbVerticalCarouselAutoSlidePause" Display="Dynamic" ErrorMessage="This field is required." ValidationGroup="vgVerticalCarouselSettings" resourcekey="rfvVerticalCarouselAutoSlidePause.ErrorMessage" CssClass="smallInfo warning"></asp:RequiredFieldValidator>
													<asp:CompareValidator ID="cvVerticalCarouselAutoSlidePause" runat="server" ControlToValidate="tbVerticalCarouselAutoSlidePause" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" Type="Integer" ValidationGroup="vgVerticalCarouselSettings" resourcekey="cvVerticalCarouselAutoSlidePause.ErrorMessage" CssClass="smallInfo warning"></asp:CompareValidator>
												</asp:Panel>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblVerticalCarouselNumberOfImagesToSlide" runat="server" HelpKey="lblVerticalCarouselNumberOfImagesToSlide.HelpText" HelpText="Number of images to slide:" ResourceKey="lblVerticalCarouselNumberOfImagesToSlide" Text="Number of images to slide:" />
											</td>
											<td>
												<asp:TextBox ID="tbVerticalCarouselNumberOfImagesSlide" runat="server" ValidationGroup="vgVerticalCarouselSettings" CssClass="small textCenter">1</asp:TextBox>
												<asp:RequiredFieldValidator ID="rfvVerticalCarouselNumberOfImagesToSlide" runat="server" ControlToValidate="tbVerticalCarouselNumberOfImagesSlide" Display="Dynamic" ErrorMessage="This field is required." resourcekey="rfvVerticalCarouselNumberOfImagesToSlide.ErrorMessage" ValidationGroup="vgVerticalCarouselSettings" CssClass="smallInfo warning"></asp:RequiredFieldValidator>
												<asp:CompareValidator ID="cvVerticalCarouselNumberOfImagesToSlide" runat="server" ControlToValidate="tbVerticalCarouselNumberOfImagesSlide" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" resourcekey="cvVerticalCarouselNumberOfImagesToSlide.ErrorMessage" Type="Integer" ValidationGroup="vgVerticalCarouselSettings" CssClass="smallInfo warning"></asp:CompareValidator>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblVerticalCarouselNumberOfImages" runat="server" HelpKey="lblVerticalCarouselNumberOfImages.HelpText" HelpText="Number of images to show:" ResourceKey="lblVerticalCarouselNumberOfImages" Text="Number of images to show:" />
											</td>
											<td>
												<asp:TextBox ID="tbVerticalCarouselNumberOfImages" runat="server" ValidationGroup="vgVerticalCarouselSettings" CssClass="small textCenter">1</asp:TextBox>
												<asp:RequiredFieldValidator ID="rfvVerticalCarouselNumberOfImages" runat="server" ControlToValidate="tbVerticalCarouselNumberOfImages" Display="Dynamic" ErrorMessage="This field is required." resourcekey="rfvVerticalCarouselNumberOfImages.ErrorMessage" ValidationGroup="vgVerticalCarouselSettings" CssClass="smallInfo warning"></asp:RequiredFieldValidator>
												<asp:CompareValidator ID="cvVerticalCarouselNumberOfImages" runat="server" ControlToValidate="tbVerticalCarouselNumberOfImages" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" resourcekey="cvVerticalCarouselNumberOfImages.ErrorMessage" Type="Integer" ValidationGroup="vgVerticalCarouselSettings" CssClass="smallInfo warning"></asp:CompareValidator>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblVerticalCarouselScrollingDirection" runat="server" HelpText="Scrolling direction:" Text="Scrolling direction:" HelpKey="lblVerticalCarouselScrollingDirection.HelpText" ResourceKey="lblVerticalCarouselScrollingDirection" />
											</td>
											<td>
												<div class="styledSelect">
													<asp:DropDownList ID="ddlVerticalCarouselScrollingDirection" runat="server">
														<asp:ListItem resourcekey="liUp" Value="up">Up</asp:ListItem>
														<asp:ListItem resourcekey="liDown" Value="down">Down</asp:ListItem>
													</asp:DropDownList>
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblVerticalCarouselRandomizeMedia" runat="server" HelpKey="lblImageCarouselRandomizeMedia.HelpText" HelpText="Randomize media positions at every page load:" ResourceKey="lblImageCarouselRandomizeMedia" Text="Randomize media positions:" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbVerticalCarouselRandomizeMedia" runat="server" resourcekey="cbImageCarouselShowPagingResource1" AutoPostBack="True" OnCheckedChanged="cbVerticalCarouselRandomizeMedia_CheckedChanged" Text="Randomize media positions" />
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="Label9" runat="server" HelpText="Select media sorting options:" Text="Media sorting:" HelpKey="lblLightBoxMediaSorting.HelpText" ResourceKey="lblLightBoxMediaSorting" />
											</td>
											<td>
												<table class="clearWidth textLeft">
													<tr>
														<td>
															<div class="styledSelect">
																<asp:DropDownList ID="ddlVerticalCarouselMediaSort" runat="server">
																	<asp:ListItem resourcekey="liPosition" Value="Position">Position</asp:ListItem>
																	<asp:ListItem resourcekey="liDateUploaded" Value="DateUploaded">Date uploaded</asp:ListItem>
																	<asp:ListItem resourcekey="liFileName" Value="FileName">Filename</asp:ListItem>
																	<asp:ListItem resourcekey="liTitle">Title</asp:ListItem>
																</asp:DropDownList>
															</div>
														</td>
														<td>&nbsp;</td>
														<td>
															<asp:RadioButtonList ID="rblVerticalCarouselMediasortType" runat="server" RepeatDirection="Horizontal" CssClass="styledRadio small">
																<asp:ListItem resourcekey="liAscending" Selected="True" Value="ASC">Ascending</asp:ListItem>
																<asp:ListItem resourcekey="liDescending" Value="DESC">Descending</asp:ListItem>
															</asp:RadioButtonList>
														</td>
													</tr>
												</table>
											</td>
										</tr>
										<tr>
											<td colspan="2">&nbsp;</td>
										</tr>
										<tr class="color2HighLighted">
											<td colspan="2" class="textCenter">
												<asp:Label ID="lblVerticaCarouselVPTitle" runat="server" Text="Video player in lightbox settings:" resourcekey="lblLightBoxGalleryViseoPlayerSettingsResource1"></asp:Label>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblVerticaCarouselSelectVideoPlayer" runat="server" HelpText="Select video player:" Text="Select video player:" HelpKey="SelectVideoPlayer.HelpText" ResourceKey="SelectVideoPlayer.Text" />
											</td>
											<td>
												<div class="styledSelect">
													<asp:DropDownList ID="ddlVerticalCarouselVPSelection" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlVerticalCarouselVPSelection_SelectedIndexChanged">
														<asp:ListItem Selected="True" Value="False">Standard player</asp:ListItem>
														<asp:ListItem Value="True">Flow player</asp:ListItem>
													</asp:DropDownList>
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblVerticaCarouselVideoPlayer" runat="server" HelpKey="lblLightBoxGalleryVideoPlayerSelectSkin.HelpText" HelpText="Select video player skin:" ResourceKey="lblLightBoxGalleryVideoPlayerSelectSkin" Text="Select video player skin:" />
											</td>
											<td>
												<div class="styledSelect">
													<asp:DropDownList ID="ddlVerticalCarouselVPTheme" runat="server">
														<asp:ListItem resourcekey="ListItemResource28" Selected="True" Value="black">Black</asp:ListItem>
														<asp:ListItem resourcekey="ListItemResource29" Value="white">White</asp:ListItem>
													</asp:DropDownList>
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblVerticaCarouselVPPlayOnLoad" ResourceKey="lblLightBoxGalleryVideoPlayerPlayOnLoad" runat="server" HelpText="Start to play video on page load:" Text="Play on load:" HelpKey="lblLightBoxGalleryVideoPlayerPlayOnLoad.HelpText" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbVeticalCarouselVPPlayOnload" runat="server" resourcekey="cbTGVPPlayOnLoadResource1" Text="Play on load" />
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblVerticaCarouselVPShowDescription" ResourceKey="lblLightBoxGalleryViseoPlayerPlayOnLoad" runat="server" HelpText="Show description inside video player:" Text="Show description:" HelpKey="lblLightBoxGalleryViseoPlayerPlayOnLoad.HelpText" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbVeticalCarouselVPShowDescription" runat="server" resourcekey="cbTGVPShowDescriptionResource1" Text="Show description" />
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblVerticaCarouselVPAllowFullscreen" ResourceKey="lblTGVPAllowFullscreen" runat="server" HelpText="Allow video to be played in fullscreen:" Text="Allow fullscreen:" HelpKey="lblTGVPAllowFullscreen.HelpText" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbVeticalCarouselVPAllowFullscreen" runat="server" resourcekey="cbTGVPAllowFullscreenResource1" Text="Allow fullscreen" />
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblVerticaCarouselVPPlayQtInFlash" ResourceKey="lblLightBoxGalleryVideoPlayerPlayQTInFlash" runat="server" HelpText="Play QuickTime videos in flash player:" Text="Play QuickTime videos in flash player:" HelpKey="lblLightBoxGalleryVideoPlayerPlayQTInFlash.HelpText" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbVeticalCarouselVPPlayQtInFlash" runat="server" resourcekey="cbTGVPPlayQTinFlashResource1" Text="Play QuickTime videos in flash player" />
												</div>
											</td>
										</tr>
										<tr>
											<td colspan="2">&nbsp;</td>
										</tr>
										<tr class="color2HighLighted">
											<td colspan="2" class="textCenter">
												<asp:Label ID="lblVerticalCarouselAPLightTitle" runat="server" resourcekey="lblLightBoxGalleryAudioPlayerSettingsResource1" Text="Audio player in lightbox settings:"></asp:Label>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblVerticalCarouselAPPlayOnLoad" ResourceKey="lblLightBoxGalleryAudioPlayerPlayOnLoad" runat="server" HelpText="Start to play audio on page load:" Text="Play on load:" HelpKey="lblLightBoxGalleryAudioPlayerPlayOnLoad.HelpText" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbVerticalCarouselAPPlayONLoad" runat="server" resourcekey="cbTGAPPlayOnLoadResource1" Text="Play on load" />
												</div>
											</td>
										</tr>
									</table>
									<asp:Label ID="lblVerticalCarouselSstatus" runat="server" EnableViewState="False"></asp:Label>
									<div class="mainActions">
										<asp:LinkButton ID="btnVerticalCarouselSaveSettings" runat="server" OnClick="btnVerticalCarouselSaveSettings_Click" resourcekey="btnVerticalCarouselSaveSettings" Text="Save settings" ValidationGroup="vgVerticalCarouselSettings" CssClass="downSave" />
										<asp:LinkButton ID="btnVerticalCaouselSaveClose" runat="server" OnClick="btnVerticalCaouselSaveClose_Click" resourcekey="btnVerticalCaouselSaveClose" Text="Save &amp; Close" ValidationGroup="vgVerticalCarouselSettings" CssClass="downSaveClose" />
									</div>
								</div>
							</asp:Panel>
							<asp:Panel ID="pnlSlideShowDisplay" runat="server" Visible="False" CssClass="settingsList negativeMargins40">
								<h3>
									<asp:Label ID="lblSlideShowDisplaySettings" runat="server" Text="Slide show display settings" CssClass="settingsdetailtitle" resourcekey="lblSlideShowDisplaySettingsResource1"></asp:Label>
								</h3>
								<div class="settingsTable">
									<table>
										<tr>
											<td>
												<dnn:Label ID="lblSlideShowThemeSelect" runat="server" ControlName="ddlSSThemeSelect" HelpKey="lblSlideShowThemeSelect.HelpText" HelpText="Select the CSS theme file:" ResourceKey="lblSlideShowThemeSelect" Text="Select CSS:" />
											</td>
											<td>
												<div class="styledSelect">
													<asp:DropDownList ID="ddlSSThemeSelect" runat="server"></asp:DropDownList>
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblSlideShowShowTitle" ResourceKey="lblSlideShowShowTitle" runat="server" HelpText="Show gallery title:" Text="Show gallery title:" HelpKey="lblSlideShowShowTitle.HelpText" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbSlideShowShowTitle" runat="server" resourcekey="cbSlideShowShowTitleResource1" Text="Show gallery title" />
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblSlideShowShowDescription" ResourceKey="lblSlideShowShowDescription" runat="server" HelpText="Show gallery description:" Text="Show gallery description:" HelpKey="lblSlideShowShowDescription.HelpText" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbSlideShowShowDescription" runat="server" resourcekey="cbSlideShowShowDescriptionResource1" Text="Show gallery description" />
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblSlideShowMediaTitle" ResourceKey="lblSlideShowMediaTitle" runat="server" HelpText="Show image title:" Text="Show image title:" HelpKey="lblSlideShowMediaTitle.HelpText" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbSlideShowShowMediaTitle" runat="server" resourcekey="cbSlideShowShowMediaTitleResource1" Text="Show image title" />
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblSlideShowShowMediaDescription" ResourceKey="lblSlideShowShowMediaDescription" runat="server" HelpText="Show image description:" Text="Show image description:" HelpKey="lblSlideShowShowMediaDescription.HelpText" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbSlideShowShowMediaDescription" runat="server" resourcekey="cbSlideShowShowMediaDescriptionResource1" Text="Show image description" />
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblSlideShowShowLightboxTitle" ResourceKey="lblSlideShowShowLightboxTitle" runat="server" HelpText="Show image title in lightbox:" Text="Show image title in lightbox:" HelpKey="lblSlideShowShowLightboxTitle.HelpText" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbSlideShowShowLightboxTitle" runat="server" resourcekey="cbSlideShowShowLightboxTitleResource1" Text="Show image title in lightbox" />
												</div>
											</td>
										</tr>
										<tr>
											<td class="textTop">
												<dnn:Label ID="lblSlideShowShowLightboxDescription" ResourceKey="lblSlideShowShowLightboxDescription" runat="server" HelpText="Show image description in lightbox:" Text="Show image description in lightbox:" HelpKey="lblSlideShowShowLightboxDescription.HelpText" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbSlideShowShowLightboxDescription" runat="server" resourcekey="cbSlideShowShowLightboxDescriptionResource1" AutoPostBack="True" OnCheckedChanged="cbSlideShowShowLightboxDescription_CheckedChanged" Text="Show image description in lightbox" />
												</div>
												<asp:Panel ID="pnlSlideShowTipOptions" runat="server" BackColor="#CBEEF8" BorderColor="#65CDEB" BorderStyle="Solid" BorderWidth="2px" Visible="False">
													<table>
														<tr>
															<td colspan="2">
																<asp:Label ID="lblSlideShowToolTipOptions" runat="server" Font-Bold="True" resourcekey="lblLightBoxToolTipOptions" Text="Tooltip options"></asp:Label>
															</td>
														</tr>
														<tr>
															<td>
																<asp:Label ID="lblSlideShowLightboxShowTooltips" runat="server" resourcekey="lblLightboxShowToolTips" Text="Show Tooltips:"></asp:Label>
															</td>
															<td>
																<asp:CheckBox ID="cbSSSHowToolTips" runat="server" Checked="True" />
															</td>
														</tr>
														<tr>
															<td>
																<asp:Label ID="lblSlideShowTargetPosition" runat="server" resourcekey="lblLightboxTargetPosition" Text="Target position:"></asp:Label>
															</td>
															<td>
																<asp:DropDownList ID="ddlSlideShowTargetPosition" runat="server">
																	<asp:ListItem resourcekey="topLeft" Value="topLeft">Top left</asp:ListItem>
																	<asp:ListItem resourcekey="topMiddle" Value="topMiddle" Selected="True">Top middle</asp:ListItem>
																	<asp:ListItem resourcekey="topRight" Value="topRight">Top right</asp:ListItem>
																	<asp:ListItem resourcekey="leftTop" Value="leftTop">Left top</asp:ListItem>
																	<asp:ListItem resourcekey="leftMiddle" Value="leftMiddle">Left middle</asp:ListItem>
																	<asp:ListItem resourcekey="leftBottom" Value="leftBottom">Left bottom</asp:ListItem>
																	<asp:ListItem resourcekey="center" Value="center">Center</asp:ListItem>
																	<asp:ListItem resourcekey="rightTop" Value="rightTop">Right top</asp:ListItem>
																	<asp:ListItem resourcekey="rightMiddle" Value="rightMiddle">Right middle</asp:ListItem>
																	<asp:ListItem resourcekey="rightBottom" Value="rightBottom">Right bottom</asp:ListItem>
																	<asp:ListItem resourcekey="bottomLeft" Value="bottomLeft">Bottom left</asp:ListItem>
																	<asp:ListItem resourcekey="bottomMiddle" Value="bottomMiddle">Bottom middle</asp:ListItem>
																	<asp:ListItem resourcekey="bottomRight" Value="bottomRight">Bottom right</asp:ListItem>
																</asp:DropDownList>
															</td>
														</tr>
														<tr>
															<td>
																<asp:Label ID="lblSlideShowTooltipPosition" runat="server" resourcekey="lblLightboxTooltipPosition" Text="Tooltip position:"></asp:Label>
															</td>
															<td>
																<asp:DropDownList ID="ddlSlideShowTooltipPosition" runat="server">
																	<asp:ListItem resourcekey="topLeft" Value="topLeft">Top left</asp:ListItem>
																	<asp:ListItem resourcekey="topMiddle" Value="topMiddle">Top middle</asp:ListItem>
																	<asp:ListItem resourcekey="topRight" Value="topRight">Top right</asp:ListItem>
																	<asp:ListItem resourcekey="leftTop" Value="leftTop">Left top</asp:ListItem>
																	<asp:ListItem resourcekey="leftMiddle" Value="leftMiddle">Left middle</asp:ListItem>
																	<asp:ListItem resourcekey="leftBottom" Value="leftBottom">Left bottom</asp:ListItem>
																	<asp:ListItem resourcekey="center" Value="center">Center</asp:ListItem>
																	<asp:ListItem resourcekey="rightTop" Value="rightTop">Right top</asp:ListItem>
																	<asp:ListItem resourcekey="rightMiddle" Value="rightMiddle">Right middle</asp:ListItem>
																	<asp:ListItem resourcekey="rightBottom" Value="rightBottom">Right bottom</asp:ListItem>
																	<asp:ListItem resourcekey="bottomLeft" Value="bottomLeft">Bottom left</asp:ListItem>
																	<asp:ListItem resourcekey="bottomMiddle" Selected="True" Value="bottomMiddle">Bottom middle</asp:ListItem>
																	<asp:ListItem resourcekey="bottomRight" Value="bottomRight">Bottom right</asp:ListItem>
																</asp:DropDownList>
															</td>
														</tr>
														<tr>
															<td>
																<asp:Label ID="lblSlideShowShowEffect" runat="server" resourcekey="lblLightboxShowEffect" Text="Show effect:"></asp:Label>
															</td>
															<td>
																<asp:DropDownList ID="ddlSlideShowShoweffect" runat="server">
																	<asp:ListItem resourcekey="fade" Value="fade">Fade</asp:ListItem>
																	<asp:ListItem resourcekey="slide" Value="slide">Slide</asp:ListItem>
																	<asp:ListItem resourcekey="grow" Value="grow">Grow</asp:ListItem>
																</asp:DropDownList>
															</td>
														</tr>
														<tr>
															<td>
																<asp:Label ID="lblSlideShowShowEffectDuration" runat="server" resourcekey="lblLightboxShowEffectDuration" Text="Show effect duration (ms):"></asp:Label>
															</td>
															<td>
																<asp:TextBox ID="tbSlideShowTooltipShowDuration" runat="server" Width="53px">500</asp:TextBox>
																&nbsp;<asp:RequiredFieldValidator ID="rfvImageCarouselImageWidth12" runat="server" ControlToValidate="tbSlideShowTooltipShowDuration" Display="Dynamic" ErrorMessage="This field is required." resourcekey="rfvImageCarouselImageWidthResource1.ErrorMessage"
																	SetFocusOnError="True" ValidationGroup="vgSSSettings"></asp:RequiredFieldValidator>
																<asp:CompareValidator ID="cvImageCarouselImageWidth12" runat="server" ControlToValidate="tbSlideShowTooltipShowDuration" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" resourcekey="cvImageCarouselImageWidthResource1.ErrorMessage"
																	SetFocusOnError="True" Type="Integer" ValidationGroup="vgSSSettings">
																</asp:CompareValidator>
															</td>
														</tr>
														<tr>
															<td>
																<asp:Label ID="lblSlideShowShowHideEffect" runat="server" resourcekey="lblLightboxShowHideEffect" Text="Hide effect:"></asp:Label>
															</td>
															<td>
																<asp:DropDownList ID="ddlSlideShowHideEffect" runat="server">
																	<asp:ListItem resourcekey="fade" Value="fade">Fade</asp:ListItem>
																	<asp:ListItem resourcekey="slide" Value="slide">Slide</asp:ListItem>
																	<asp:ListItem resourcekey="grow" Value="grow">Grow</asp:ListItem>
																</asp:DropDownList>
															</td>
														</tr>
														<tr>
															<td>
																<asp:Label ID="lblSlideShowHideEffectDuration" runat="server" resourcekey="lblLightboxHideEffectDuration" Text="Hide effect duration (ms):"></asp:Label>
															</td>
															<td>
																<asp:TextBox ID="tbSlideShowTooltipHideDuration" runat="server" Width="53px">500</asp:TextBox>
																&nbsp;<asp:RequiredFieldValidator ID="rfvImageCarouselImageWidth13" runat="server" ControlToValidate="tbSlideShowTooltipHideDuration" Display="Dynamic" ErrorMessage="This field is required." resourcekey="rfvImageCarouselImageWidthResource1.ErrorMessage"
																	SetFocusOnError="True" ValidationGroup="vgSSSettings"></asp:RequiredFieldValidator>
																<asp:CompareValidator ID="cvImageCarouselImageWidth13" runat="server" ControlToValidate="tbSlideShowTooltipHideDuration" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" resourcekey="cvImageCarouselImageWidthResource1.ErrorMessage"
																	SetFocusOnError="True" Type="Integer" ValidationGroup="vgSSSettings">
																</asp:CompareValidator>
															</td>
														</tr>
														<tr>
															<td>
																<asp:Label ID="lblSlideShowTooltipBorder" runat="server" resourcekey="lblLightboxTooltipBorder" Text="Border:"></asp:Label>
															</td>
															<td>
																<asp:TextBox ID="tbSlideShowTooltipBorder" runat="server" Width="53px">5</asp:TextBox>
																&nbsp;<asp:RequiredFieldValidator ID="rfvImageCarouselImageWidth14" runat="server" ControlToValidate="tbSlideShowTooltipBorder" Display="Dynamic" ErrorMessage="This field is required." resourcekey="rfvImageCarouselImageWidthResource1.ErrorMessage" SetFocusOnError="True"
																	ValidationGroup="vgSSSettings"></asp:RequiredFieldValidator>
																<asp:CompareValidator ID="cvImageCarouselImageWidth14" runat="server" ControlToValidate="tbSlideShowTooltipBorder" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" resourcekey="cvImageCarouselImageWidthResource1.ErrorMessage"
																	SetFocusOnError="True" Type="Integer" ValidationGroup="vgSSSettings">
																</asp:CompareValidator>
															</td>
														</tr>
														<tr>
															<td>
																<asp:Label ID="lblSlideShowTooltipCornerRadius" runat="server" resourcekey="lblLightboxTooltipCornerRadius" Text="Corner radius:"></asp:Label>
															</td>
															<td>
																<asp:TextBox ID="tbSlideShowTooltipCornerRadius" runat="server" Width="53px">5</asp:TextBox>
																&nbsp;<asp:RequiredFieldValidator ID="rfvImageCarouselImageWidth15" runat="server" ControlToValidate="tbSlideShowTooltipCornerRadius" Display="Dynamic" ErrorMessage="This field is required." resourcekey="rfvImageCarouselImageWidthResource1.ErrorMessage"
																	SetFocusOnError="True" ValidationGroup="vgSSSettings"></asp:RequiredFieldValidator>
																<asp:CompareValidator ID="cvImageCarouselImageWidth15" runat="server" ControlToValidate="tbSlideShowTooltipCornerRadius" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" resourcekey="cvImageCarouselImageWidthResource1.ErrorMessage"
																	SetFocusOnError="True" Type="Integer" ValidationGroup="vgSSSettings">
																</asp:CompareValidator>
															</td>
														</tr>
														<tr>
															<td>
																<asp:Label ID="lblSlideShowTooltipTheme" runat="server" resourcekey="lblLightboxTooltipTheme" Text="Select theme:"></asp:Label>
															</td>
															<td>
																<asp:DropDownList ID="ddlSlideShowTooltipTheme" runat="server">
																	<asp:ListItem resourcekey="cream" Value="cream">Yellow</asp:ListItem>
																	<asp:ListItem resourcekey="dark" Value="dark">Dark</asp:ListItem>
																	<asp:ListItem resourcekey="green" Value="green">Green</asp:ListItem>
																	<asp:ListItem resourcekey="light" Value="light">Light</asp:ListItem>
																	<asp:ListItem resourcekey="red" Value="red">Red</asp:ListItem>
																	<asp:ListItem resourcekey="blue" Value="blue">Blue</asp:ListItem>
																</asp:DropDownList>
															</td>
														</tr>
													</table>
												</asp:Panel>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblSlideShowOpenMediaUrl" ResourceKey="lblSlideShowOpenMediaUrl" runat="server" HelpText="On image click dont open image in lightbox, but open Media Url link." Text="On click go to Media Url:" HelpKey="lblSlideShowOpenMediaUrl.HelpText" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbSlideShowOpenMediaUrl" runat="server" AutoPostBack="True" OnCheckedChanged="cbSSOpenMediaUrl_CheckedChanged" resourcekey="cbSlideShowOpenMediaUrlResource1" Text="On click go to Media Url" />
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblSlideShowOpenMediaUrlNewWindow" ResourceKey="lblSlideShowOpenMediaUrlNewWindow" runat="server" HelpText="Open link in new window:" Text="Open link in new window:" HelpKey="lblSlideShowOpenMediaUrlNewWindow.HelpText" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbSlideShowOpenMediaUrlNewWindow" runat="server" Enabled="False" resourcekey="cbSlideShowOpenMediaUrlNewWindowResource1" Text="Open link in new window" />
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblSlideShowMaxImageWidth" ResourceKey="lblSlideShowMaxImageWidth" runat="server" ControlName="tbMaxImageWidth" HelpText="Maximum  image width for proportional resizing:" Text="Maximum image width:" HelpKey="lblSlideShowMaxImageWidth.HelpText" />
											</td>
											<td>
												<asp:TextBox ID="tbMaxImageWidth" runat="server" ValidationGroup="vgSSSettings" CssClass="small textCenter">600</asp:TextBox>
												<asp:RequiredFieldValidator ID="rfvSlideShowImageWidth" runat="server" ControlToValidate="tbMaxImageWidth" Display="Dynamic" ErrorMessage="This field is required." ValidationGroup="vgSSSettings" SetFocusOnError="True" resourcekey="rfvSlideShowImageWidthResource1.ErrorMessage" CssClass="smallInfo warning"></asp:RequiredFieldValidator>
												<asp:CompareValidator ID="cvSlideShowImageWidth" runat="server" ControlToValidate="tbMaxImageWidth" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" Type="Integer" ValidationGroup="vgSSSettings" SetFocusOnError="True" resourcekey="cvSlideShowImageWidthResource1.ErrorMessage" CssClass="smallInfo warning"></asp:CompareValidator>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblSlideShowMaxImageHeight" ResourceKey="lblSlideShowMaxImageHeight" runat="server" Text="Maximum image height:" HelpText="Maximum  image width for proportional resizing:" ControlName="tbMaxImageHeight" HelpKey="lblSlideShowMaxImageHeight.HelpText"></dnn:Label>
											</td>
											<td>
												<asp:TextBox ID="tbMaxImageHeight" runat="server" ValidationGroup="vgSSSettings" CssClass="small textCenter">300</asp:TextBox>
												<asp:RequiredFieldValidator ID="rfvSlideShowImageHeight" runat="server" ControlToValidate="tbMaxImageHeight" Display="Dynamic" ErrorMessage="This field is required." ValidationGroup="vgSSSettings" SetFocusOnError="True" resourcekey="rfvSlideShowImageHeightResource1.ErrorMessage" CssClass="smallInfo warning"></asp:RequiredFieldValidator>
												<asp:CompareValidator ID="cvSlideShowImageHeight" runat="server" ControlToValidate="tbMaxImageHeight" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" Type="Integer" ValidationGroup="vgSSSettings" SetFocusOnError="True" resourcekey="cvSlideShowImageHeightResource1.ErrorMessage" CssClass="smallInfo warning"></asp:CompareValidator>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblSlideShowAutoSlide" ResourceKey="lblSlideShowAutoSlide" runat="server" Text="Enable auto slide: " HelpText="Enable auto slide of images." ControlName="cbAutoSlide" HelpKey="lblSlideShowAutoSlide.HelpText"></dnn:Label>
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbSlideShowAutoSlide" runat="server" AutoPostBack="True" OnCheckedChanged="cbAutoSlide_CheckedChanged1" Checked="True" resourcekey="cbSlideShowAutoSlideResource1" Text="Enable auto slide" />
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblSlideShowSlideRandom" ResourceKey="lblSlideShowSlideRandom" runat="server" ControlName="cbSlideRandom" HelpText="Auto slide random images." Text="Random:" HelpKey="lblSlideShowSlideRandom.HelpText" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbSlideShowSlideRandom" runat="server" resourcekey="cbSlideShowSlideRandomResource1" Text="Random" />
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblSlideShowAutoSlidePause" ResourceKey="lblSlideShowAutoSlidePause" runat="server" Text="Auto slide pause between imags (ms): " HelpText="Set the pause between images when in auto slide mode:" HelpKey="lblSlideShowAutoSlidePause.HelpText"></dnn:Label>
											</td>
											<td>
												<asp:Panel ID="pnlSlideOpt" runat="server">
													<asp:TextBox ID="tbAutoSlidePause" runat="server" CssClass="small textCenter">5000</asp:TextBox>
													<asp:RequiredFieldValidator ID="rfvSlideShowImageWidth0" runat="server" ControlToValidate="tbAutoSlidePause" Display="Dynamic" ErrorMessage="This field is required." resourcekey="rfvSlideShowImageWidthResource1.ErrorMessage" SetFocusOnError="True" ValidationGroup="vgSSSettings" CssClass="smallInfo warning"></asp:RequiredFieldValidator>
													<asp:CompareValidator ID="cvSlideShowImageHeight0" runat="server" ControlToValidate="tbAutoSlidePause" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" resourcekey="cvSlideShowImageHeightResource1.ErrorMessage" SetFocusOnError="True" Type="Integer" ValidationGroup="vgSSSettings" CssClass="smallInfo warning"></asp:CompareValidator>
												</asp:Panel>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblSlideShowStartRandom" ResourceKey="lblSlideShowStartRandom" runat="server" Text="Start slide show with random image:" ControlName="cbSSStartRandom" HelpText="Set this if you want the auto slide mode to start with random image:" HelpKey="lblSlideShowStartRandom.HelpText"></dnn:Label>
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbSlideShowStartRandom" runat="server" resourcekey="cbSlideShowStartRandomResource1" Text="Start slide show with random image" />
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblSlideShowSmartCrop" ResourceKey="lblSlideShowSmartCrop" runat="server" ControlName="cbSSSmartCrop" HelpText="Use this if you want all images to have same width and height. Otherwise images will be resized proportionaly." Text="Smart resize and crop images:" HelpKey="lblSlideShowSmartCrop.HelpText" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbSlideShowSmartCrop" runat="server" resourcekey="cbSlideShowSmartCropResource1" Text="Smart resize and crop images" />
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblSlideShowPagingVisible" ResourceKey="lblSlideShowPagingVisible" runat="server" HelpText="Show paging:" Text="Show paging:" HelpKey="lblSlideShowPagingVisible.HelpText" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbSlideShowShowPaging" runat="server" resourcekey="cbSlideShowShowPagingResource1" Text="Show paging" />
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblSlideShowRandomizeMedia" runat="server" HelpKey="lblImageSliderRandomizeMedia.HelpText" HelpText="Randomize media positions at every page load:" ResourceKey="lblImageSliderRandomizeMedia" Text="Randomize media positions:" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbSlideShowRandomizeMedia" runat="server" resourcekey="cbImageSliderShowPagingResource1" AutoPostBack="True" OnCheckedChanged="cbSlideShowRandomizeMedia_CheckedChanged" Text="Randomize media positions" />
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="Label2" runat="server" HelpText="Select media sorting options:" Text="Media sorting:" HelpKey="lblLightBoxMediaSorting.HelpText" ResourceKey="lblLightBoxMediaSorting" />
											</td>
											<td>
												<table class="clearWidth textLeft">
													<tr>
														<td>
															<div class="styledSelect">
																<asp:DropDownList ID="ddlSlideShowMediaSort" runat="server">
																	<asp:ListItem resourcekey="liPosition" Value="Position">Position</asp:ListItem>
																	<asp:ListItem resourcekey="liDateUploaded" Value="DateUploaded">Date uploaded</asp:ListItem>
																	<asp:ListItem resourcekey="liFileName" Value="FileName">Filename</asp:ListItem>
																	<asp:ListItem resourcekey="liTitle">Title</asp:ListItem>
																</asp:DropDownList>
															</div>
														</td>
														<td>&nbsp;</td>
														<td>
															<asp:RadioButtonList ID="rblSlideShowMediaSortType" runat="server" RepeatDirection="Horizontal" CssClass="styledRadio small">
																<asp:ListItem resourcekey="liAscending" Selected="True" Value="ASC">Ascending</asp:ListItem>
																<asp:ListItem resourcekey="liDescending" Value="DESC">Descending</asp:ListItem>
															</asp:RadioButtonList>
														</td>
													</tr>
												</table>
											</td>
										</tr>
									</table>
									<asp:Label ID="lblSlideShowSstatus" runat="server" EnableViewState="False"></asp:Label>
									<div class="mainActions">
										<asp:LinkButton ID="btnSlideShowSaveSettings" runat="server" OnClick="btnSaveSettings_Click" Text="Save settings" ValidationGroup="vgSSSettings" resourcekey="btnSlideShowSaveSettingsResource1" CssClass="downSave" />
										<asp:LinkButton ID="btnSlideShowSaveClose" runat="server" OnClick="btnSSSave_Click" Text="Save &amp; Close" ValidationGroup="vgSSSettings" resourcekey="btnSlideShowSaveCloseResource1" CssClass="downSaveClose" />
									</div>
								</div>
							</asp:Panel>
							<asp:Panel ID="pnlVideoGallerySettings" runat="server" Visible="False" CssClass="settingsList negativeMargins40">
								<h3>
									<asp:Label ID="lblVideoGalleryDisplaySettings" runat="server" CssClass="settingsdetailtitle" Text="Video gallery display settings" resourcekey="lblVideoGalleryDisplaySettingsResource1"></asp:Label>
								</h3>
								<div class="settingsTable">
									<table>
										<tr>
											<td>
												<dnn:Label ID="lblVideoGallerySelectCSS" runat="server" HelpText="Select the CSS theme file:" Text="SelectCSS:" HelpKey="lblVideoGallerySelectCSS.HelpText" ResourceKey="lblVideoGallerySelectCSS" ControlName="ddlVGSelectCSS" />
											</td>
											<td>
												<div class="styledSelect">
													<asp:DropDownList ID="ddlVGSelectCSS" runat="server"></asp:DropDownList>
												</div>
											</td>
										</tr>
										<tr>
											<td class="textTop">
												<dnn:Label ID="lblVideoGalelrySelectPLayer" runat="server" HelpKey="SelectVideoPlayer.HelpText" HelpText="Use flow player:" ResourceKey="SelectVideoPlayer.Text" Text="Use flow player:" />
											</td>
											<td>
												<div class="styledSelect">
													<asp:DropDownList ID="ddlSelectVideoPlayer" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlSelectVideoPlayer_SelectedIndexChanged">
														<asp:ListItem Value="False">Standard</asp:ListItem>
														<asp:ListItem Value="True">Flow player</asp:ListItem>
													</asp:DropDownList>
												</div>
												<asp:Panel ID="pnlFlowPlayerOptions" runat="server" Visible="False">
													<div class="styledCheckbox paddingTop">
														<asp:CheckBox ID="cbFlowPlayerLoop" runat="server" resourcekey="lblFlowVideoLoop" Text="Video loop:" />
													</div>
												</asp:Panel>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblVideoGalleryShowTitle" ResourceKey="lblVideoGalleryShowTitle" runat="server" HelpText="Show gallery title:" Text="Show gallery title:" HelpKey="lblVideoGalleryShowTitle.HelpText" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbVideoGalleryShowTitle" runat="server" resourcekey="cbVideoGalleryShowTitleResource1" Text="Show gallery title" />
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblVideoGalleryShowDescription" ResourceKey="lblVideoGalleryShowDescription" runat="server" HelpText="Show gallery description:" Text="Show gallery description:" HelpKey="lblVideoGalleryShowDescription.HelpText" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbVideoGalleryShowDescription" runat="server" resourcekey="cbVideoGalleryShowDescriptionResource1" Text="Show gallery description" />
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblVideoGalleryShowMediaTitle" ResourceKey="lblVideoGalleryShowMediaTitle" runat="server" HelpText="Show video title:" Text="Show video title:" HelpKey="lblVideoGalleryShowMediaTitle.HelpText" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbVideoGalleryShowMediaTitle" runat="server" resourcekey="cbVideoGalleryShowMediaTitleResource1" Text="Show video title" />
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblVideoGalleryShowMediaDescription" ResourceKey="lblVideoGalleryShowMediaDescription" runat="server" HelpText="Show video description:" Text="Show video description:" HelpKey="lblVideoGalleryShowMediaDescription.HelpText" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbVideoGalleryShowMediaDescription" runat="server" resourcekey="cbVideoGalleryShowMediaDescriptionResource1" Text="Show video description" />
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblVideoGalleryShowMediaDescriptionInVideo" ResourceKey="lblVideoGalleryShowMediaDescriptionInVideo" runat="server" HelpText="Show description inside video:" Text="Show description inside video:" HelpKey="lblVideoGalleryShowMediaDescriptionInVideo.HelpText" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbVideoGalleryShowMediaDescriptionInVideo" runat="server" resourcekey="cbVideoGalleryShowMediaDescriptionInVideoResource1" Text="Show description inside video" />
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblVideoGalleryUseThumbnailAsStartPhoto" ResourceKey="lblVideoGalleryUseThumbnailAsStartPhoto" runat="server" HelpText="Use thumbnail as start image:" Text="Use thumbnail as start image:" HelpKey="lblVideoGalleryUseThumbnailAsStartPhoto.HelpText" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbVideoGalleryUseThumbnailAsStartPhoto" runat="server" resourcekey="cbVideoGalleryUseThumbnailAsStartPhotoResource1" Text="Use thumbnail as start image" />
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblVideoGalleryPlayOnLoad" runat="server" HelpText="Start to play video on page load:" Text="Play on load:" HelpKey="lblVideoGalleryPlayOnLoad.HelpText" ResourceKey="lblVideoGalleryPlayOnLoad" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbVideoGalleryPlayOnLoad" runat="server" resourcekey="cbVideoGalleryPlayOnLoadResource1" Text="Play on load" />
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblVideoGalleryAllowFullscreen" runat="server" HelpText="Allow video to be played fullscreen:" Text="Allow fullscreen:" HelpKey="lblVideoGalleryAllowFullscreen.HelpText" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbVideoGalleryAllowFullscreen" runat="server" resourcekey="cbVideoGalleryAllowFullscreenResource1" Text="Allow fullscreen" />
												</div>
											</td>
										</tr>
										<tr id="trVideoGallerySelectSkin" runat="server">
											<td>
												<dnn:Label ID="lblVideoGallerySelectSkin" ResourceKey="lblVideoGallerySelectSkin" runat="server" HelpText="Select video player skin:" Text="Select video player skin:" HelpKey="lblVideoGallerySelectSkin.HelpText" />
											</td>
											<td>
												<div class="styledSelect">
													<asp:DropDownList ID="ddlVGSelectTheme" runat="server">
														<asp:ListItem resourcekey="ListItemResource30" Selected="True" Value="black">Black</asp:ListItem>
														<asp:ListItem resourcekey="ListItemResource31" Value="white">White</asp:ListItem>
													</asp:DropDownList>
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblVideoGalleryInitialVolume" ResourceKey="lblVideoGalleryInitialVolume" runat="server" HelpText="Initial video volume:" Text="Initial video volume:" HelpKey="lblVideoGalleryInitialVolume.HelpText" />
											</td>
											<td>
												<asp:TextBox ID="tbVGInitialVolume" runat="server" ValidationGroup="vgVGSettings" CssClass="small textCenter">250</asp:TextBox>
												<asp:RequiredFieldValidator ID="rfvSSTNOverOpacity0" runat="server" ControlToValidate="tbVGInitialVolume" Display="Dynamic" ErrorMessage="This field is required." ValidationGroup="vgVGSettings" resourcekey="rfvSSTNOverOpacity0Resource1.ErrorMessage" CssClass="smallInfo warning"></asp:RequiredFieldValidator>
												<asp:RangeValidator ID="rvVGTBInitialVolume" runat="server" ControlToValidate="tbVGInitialVolume" Display="Dynamic" ErrorMessage="Enter value between 0-300." MaximumValue="300" MinimumValue="0" resourcekey="rvVGTBInitialVolumeResource1.ErrorMessage" Type="Integer" ValidationGroup="vgVGSettings" CssClass="smallInfo warning"></asp:RangeValidator>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblVideoGalleryItemsPerPage" ResourceKey="lblVideoGalleryItemsPerPage" runat="server" ControlName="tbVGItemsPerPage" HelpText="Set the number if items on one page:" Text="Items per page:" HelpKey="lblVideoGalleryItemsPerPage.HelpText" />
											</td>
											<td>
												<asp:TextBox ID="tbVGItemsPerPage" runat="server" CssClass="small textCenter"></asp:TextBox>
												<asp:RequiredFieldValidator ID="rfvVGHeight0" runat="server" ControlToValidate="tbVGItemsPerPage" Display="Dynamic" ErrorMessage="This field is required." ValidationGroup="vgVGSettings" resourcekey="rfvVGHeight0Resource1.ErrorMessage" CssClass="smallInfo warning"></asp:RequiredFieldValidator>
												<asp:CompareValidator ID="cvVGSettings1" runat="server" ControlToValidate="tbVGItemsPerPage" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" Type="Integer" ValidationGroup="vgVGSettings" resourcekey="cvVGSettings1Resource1.ErrorMessage" CssClass="smallInfo warning"></asp:CompareValidator>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblVideoGalleryColomunPerPage" ResourceKey="lblVideoGalleryColomunPerPage" runat="server" ControlName="tbVGNumberOfCols" HelpText="Set the number of columns:" Text="Number of columns:" HelpKey="lblVideoGalleryColomunPerPage.HelpText" />
											</td>
											<td>
												<asp:TextBox ID="tbVGNumberOfCols" runat="server" CssClass="small textCenter">1</asp:TextBox>
												<asp:RequiredFieldValidator ID="rfvVGHeight1" runat="server" ControlToValidate="tbVGNumberOfCols" Display="Dynamic" ErrorMessage="This field is required." resourcekey="rfvVGHeight1Resource1.ErrorMessage" ValidationGroup="vgVGSettings" CssClass="smallInfo warning"></asp:RequiredFieldValidator>
												<asp:CompareValidator ID="cvVGSettings2" runat="server" ControlToValidate="tbVGNumberOfCols" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" resourcekey="cvVGSettings2Resource1.ErrorMessage" Type="Integer" ValidationGroup="vgVGSettings" CssClass="smallInfo warning"></asp:CompareValidator>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblVideoGalelryRandomizeMedia" runat="server" HelpText="Randomize media positions on every page load:" Text="Randomize media positions:" HelpKey="lblLightBoxRandomizeMedia.HelpText" ResourceKey="lblLightBoxRandomizeMedia" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbVideoGalleryRandomizeMedia" runat="server" OnCheckedChanged="cbVideoGalleryRandomizeMedia_CheckedChanged" resourcekey="cbLightBoxGallerySmartCropVerticalResource1" AutoPostBack="True" Text="Randomize media positions" />
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="Label10" runat="server" HelpText="Select media sorting options:" Text="Media sorting:" HelpKey="lblLightBoxMediaSorting.HelpText" ResourceKey="lblLightBoxMediaSorting" />
											</td>
											<td>
												<table class="clearWidth textLeft">
													<tr>
														<td>
															<div class="styledSelect">
																<asp:DropDownList ID="ddlVideoGalleryMediaSort" runat="server">
																	<asp:ListItem resourcekey="liPosition" Value="Position">Position</asp:ListItem>
																	<asp:ListItem resourcekey="liDateUploaded" Value="DateUploaded">Date uploaded</asp:ListItem>
																	<asp:ListItem resourcekey="liFileName" Value="FileName">Filename</asp:ListItem>
																	<asp:ListItem resourcekey="liTitle">Title</asp:ListItem>
																</asp:DropDownList>
																<div>
														</td>
														<td>&nbsp;</td>
														<td>
															<asp:RadioButtonList ID="rblVideoGalleryMediaSortType" runat="server" RepeatDirection="Horizontal" CssClass="styledRadio small">
																<asp:ListItem resourcekey="liAscending" Selected="True" Value="ASC">Ascending</asp:ListItem>
																<asp:ListItem resourcekey="liDescending" Value="DESC">Descending</asp:ListItem>
															</asp:RadioButtonList>
														</td>
													</tr>
												</table>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblVideoGalleryShowPaging" runat="server" HelpText="Show paging:" Text="Show paging:" HelpKey="lblVideoGalleryShowPaging.HelpText" ResourceKey="lblVideoGalleryShowPaging" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbVideoGalleryShowPaging" runat="server" Checked="True" Text="Show paging" />
												</div>
											</td>
										</tr>
										<tr>
											<td class="textTop">
												<dnn:Label ID="lblVideoGalleryShowSocialSharing3" runat="server" HelpText="Show social sharing:" Text="Show social sharing:" HelpKey="lblVideoGalleryShowSocialSharing.HelpText" ResourceKey="lblVideoGalleryShowSocialSharing" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbVideoGalleryShowSocialSharing" runat="server" AutoPostBack="True" OnCheckedChanged="cbVideoGalleryShowSocialSharing_CheckedChanged" Text="Show social sharing" />
												</div>
												<asp:Panel ID="pnlVideoGallerySocialSharingOptions" runat="server" Visible="False">
													<table class="clearWidth textLeft nowrap">
														<tr>
															<td>
																<dnn:Label ID="lblVideoGallerySSOptions1" runat="server" HelpText="Open/Close sharing on button click:" Text="Open on button click:" HelpKey="lblVideoGallerySSOptions.HelpText" ResourceKey="lblVideoGallerySSOptions" />
															</td>
															<td>&nbsp;</td>
															<td>
																<div class="styledCheckbox noLabel">
																	<asp:CheckBox ID="cbVGSSOpenOnButton" runat="server" Text="Open on button click:" />
																	<div>
															</td>
														</tr>
													</table>
												</asp:Panel>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblVideoGallery2ShowSocialSharing3" runat="server" HelpText="Show textbox that contains media link:" Text="Show media link:" HelpKey="lblVideoGalleryShowBackLink.HelpText" ResourceKey="lblVideoGalleryShowBackLink" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbVideoGalleryShowMediaLink" runat="server" Text="Show media link:" />
												</div>
											</td>
										</tr>
									</table>
									<asp:Label ID="lblVideoGalleryStatus" runat="server" EnableViewState="False"></asp:Label>
									<div class="mainActions">
										<asp:LinkButton ID="btnVideoGallerySaveSettings" runat="server" OnClick="btnVideoGallerySaveSettings_Click" resourcekey="btnVideoGallerySaveSettingsResource1" Text="Save settings" ValidationGroup="vgVGSettings" CssClass="downSave" />
										<asp:LinkButton ID="btnVideoGallerySaveClose" runat="server" OnClick="btnVGSaveClose_Click" resourcekey="btnVideoGallerySaveCloseResource1" Text="Save &amp; Close" ValidationGroup="vgVGSettings" CssClass="downSaveClose" />
									</div>
								</div>
							</asp:Panel>
							<asp:Panel ID="pnlVideoGallery2Settings" runat="server" Visible="False" CssClass="settingsList negativeMargins40">
								<h3>
									<asp:Label ID="lblVideoGalleryDisplay2Settings" resourcekey="lblVideoGalleryDisplay2Settings" runat="server" CssClass="settingsdetailtitle" Text="Video gallery 2 display settings"></asp:Label>
								</h3>
								<div class="settingsTable">
									<table>
										<tr>
											<td>
												<dnn:Label ID="lblVideoGallery2TemplateSelect" runat="server" HelpKey="lblVideoGallery2TemplateSelect.HelpText" HelpText="Select the control viewer template:" ResourceKey="lblVideoGallery2TemplateSelect" Text="Select template:" />
											</td>
											<td>
												<div class="styledSelect">
													<asp:DropDownList ID="ddlVideoGallery2TemplateSelect" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlVideoGallery2TemplateSelect_SelectedIndexChanged"></asp:DropDownList>
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblVideoGallery2SelectCSS" runat="server" HelpKey="lblVideoGallery2SelectCSS.HelpText" HelpText="Select the CSS theme file:" ResourceKey="lblVideoGallery2SelectCSS" Text="Select CSS:" />
											</td>
											<td>
												<div class="styledSelect">
													<asp:DropDownList ID="ddlVG2SelectCSS" runat="server"></asp:DropDownList>
												</div>
												<asp:Label ID="lblVG2TemplateInfo" runat="server"></asp:Label>
											</td>
										</tr>
										<tr>
											<td class="textTop">
												<dnn:Label ID="lblVideoGalelry2UseFlowPlayer" runat="server" HelpText="Use Flow player:" Text="Use Flow player:" HelpKey="SelectVideoPlayer.Text" ResourceKey="SelectVideoPlayer.HelpText" />
											</td>
											<td>
												<div class="styledSelect">
													<asp:DropDownList ID="ddlVG2SelectPlayer" runat="server" OnSelectedIndexChanged="ddlVG2SelectPlayer_SelectedIndexChanged" AutoPostBack="True">
														<asp:ListItem Value="False">Standard</asp:ListItem>
														<asp:ListItem Value="True">Flow player</asp:ListItem>
													</asp:DropDownList>
												</div>
												<asp:Panel ID="pnlFlowPlayerOptionsVG2" runat="server" Visible="False">
													<div class="styledCheckBox paddingTop">
														<asp:CheckBox ID="cbFlowLoopVG2" runat="server" resourcekey="lblFlowVideoLoop" Text="Video loop" />
													</div>
												</asp:Panel>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblVideoGallery2ShowTitle" ResourceKey="lblVideoGallery2ShowTitle" runat="server" HelpText="Show gallery title:" Text="Show gallery title:" HelpKey="lblVideoGallery2ShowTitle.HelpText" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbVideoGallery2ShowTitle" runat="server" resourcekey="cbVideoGalleryShowTitleResource1" Text="Show gallery title" />
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblVideoGallery2ShowDescription" ResourceKey="lblVideoGallery2ShowDescription" runat="server" HelpText="Show gallery description:" Text="Show gallery description:" HelpKey="lblVideoGallery2ShowDescription.HelpText" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbVideoGallery2ShowDescription" runat="server" resourcekey="cbVideoGalleryShowDescriptionResource1" Text="Show gallery description" />
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblVideoGallery2ShowMediaTitle" ResourceKey="lblVideoGallery2ShowMediaTitle" runat="server" HelpText="Show video title:" Text="Show video title:" HelpKey="lblVideoGallery2ShowMediaTitle.HelpText" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbVideoGallery2ShowMediaTitle" runat="server" resourcekey="cbVideoGalleryShowMediaTitleResource1" Text="Show video title" />
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblVideoGallery2ShowMediaDescription" runat="server" HelpText="Show video description:" Text="Show video description:" HelpKey="lblVideoGallery2ShowMediaDescription.HelpText" ResourceKey="lblVideoGallery2ShowMediaDescription" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbVideoGallery2ShowMediaDescription" runat="server" resourcekey="cbVideoGalleryShowMediaDescriptionResource1" Text="Show video description" />
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblVideoGallery2ShowMediaTitleThumbnail" runat="server" HelpText="Show video title in thumbnail:" Text="Show video title in thumbnail:" HelpKey="lblVideoGallery2ShowMediaTitleThumbnail.HelpText" ResourceKey="lblVideoGallery2ShowMediaTitleThumbnail" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbVideoGallery2ShowMediaTitleThumbnail" runat="server" resourcekey="cbVideoGalleryShowMediaTitleResource1" Text="Show video title in thumbnail" />
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblVideoGallery2ShowMediaDescriptionThumbnail" ResourceKey="lblVideoGallery2ShowMediaDescriptionThumbnail" runat="server" HelpText="Show video description in thumbnail:" Text="Show video description in thumbnail:" HelpKey="lblVideoGallery2ShowMediaDescriptionThumbnail.HelpText" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbVideoGallery2ShowMediaDescriptionThumbnail" runat="server" resourcekey="cbVideoGalleryShowMediaDescriptionResource1" Text="Show video description in thumbnail" />
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblVideoGallery2ShowMediaDescriptionInVideo" ResourceKey="lblVideoGallery2ShowMediaDescriptionInVideo" runat="server" HelpText="Show description inside video:" Text="Show description inside video:" HelpKey="lblVideoGallery2ShowMediaDescriptionInVideo.HelpText" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbVideoGallery2ShowMediaDescriptionInVideo" runat="server" resourcekey="cbVideoGalleryShowMediaDescriptionInVideoResource1" Text="Show description inside video" />
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblVideoGallery2UseThumbnailAsStartPhoto" ResourceKey="lblVideoGallery2UseThumbnailAsStartPhoto" runat="server" HelpText="Use thumbnail as start image:" Text="Use thumbnail as start image:" HelpKey="lblVideoGallery2UseThumbnailAsStartPhoto.HelpText" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbVideoGallery2UseThumbnailAsStartPhoto" runat="server" resourcekey="cbVideoGalleryUseThumbnailAsStartPhotoResource1" Text="Use thumbnail as start image" />
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblVideoGallery2PlayOnLoad" runat="server" HelpText="Start to play video on page load:" Text="Play on load:" HelpKey="lblVideoGallery2PlayOnLoad.HelpText" ResourceKey="lblVideoGallery2PlayOnLoad" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbVideoGallery2PlayOnLoad" runat="server" resourcekey="cbVideoGalleryPlayOnLoadResource1" Text="Play on load" />
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblVideoGallery2AllowFullscreen" ResourceKey="lblVideoGallery2AllowFullscreen" runat="server" HelpText="Allow video to be played fullscreen:" Text="Allow fullscreen:" HelpKey="lblVideoGallery2AllowFullscreen.HelpText" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbVideoGallery2AllowFullscreen" runat="server" resourcekey="cbVideoGalleryAllowFullscreenResource1" Text="Allow fullscreen" />
												</div>
											</td>
										</tr>
										<tr id="trVideoGallery2SkinSelect" runat="server">
											<td>
												<dnn:Label ID="lblVideoGallery2SelectSkin" ResourceKey="lblVideoGallery2SelectSkin" runat="server" HelpText="Select video player skin:" Text="Select video player skin:" HelpKey="lblVideoGallery2SelectSkin.HelpText" />
											</td>
											<td>
												<div class="styledSelect">
													<asp:DropDownList ID="ddlVG2SelectTheme" runat="server">
														<asp:ListItem resourcekey="ListItemResource30" Selected="True" Value="black">Black</asp:ListItem>
														<asp:ListItem resourcekey="ListItemResource31" Value="white">White</asp:ListItem>
													</asp:DropDownList>
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblVideoGallery2InitialVolume" runat="server" Text="Initial video volume:" HelpKey="lblVideoGallery2InitialVolume.HelpText" HelpText="Initial video volume:" ResourceKey="lblVideoGallery2InitialVolume" />
											</td>
											<td>
												<asp:TextBox ID="tbVG2InitialVolume" runat="server" ValidationGroup="vgVG2Settings" CssClass="small textCenter">250</asp:TextBox>
												<asp:RequiredFieldValidator ID="rfvSSTNOverOpacity1" runat="server" ControlToValidate="tbVG2InitialVolume" Display="Dynamic" ErrorMessage="This field is required." ValidationGroup="vgVG2Settings" resourcekey="rfvSSTNOverOpacity0Resource1.ErrorMessage" CssClass="smallInfo warning"></asp:RequiredFieldValidator>
												<asp:RangeValidator ID="rvVGTBInitialVolume0" runat="server" ControlToValidate="tbVG2InitialVolume" Display="Dynamic" ErrorMessage="Enter value between 0-300." MaximumValue="300" MinimumValue="0" resourcekey="rvVGTBInitialVolumeResource1.ErrorMessage" Type="Integer" ValidationGroup="vgVG2Settings" CssClass="smallInfo warning"></asp:RangeValidator>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblVideoGallery2Width" runat="server" Text="Thumbnail width:" Visible="True" HelpKey="lblVideoGallery2Width.HelpText" HelpText="Thumbnail width:" ResourceKey="lblVideoGallery2Width"></dnn:Label>
											</td>
											<td>
												<asp:TextBox ID="tbVG2VideoWidth" runat="server" ValidationGroup="vgVG2Settings" CssClass="small textCenter">100</asp:TextBox>
												<asp:RequiredFieldValidator ID="rfvVGWidth0" runat="server" ControlToValidate="tbVG2VideoWidth" ErrorMessage="This field is required." ValidationGroup="vgVG2Settings" Display="Dynamic" resourcekey="rfvVGWidthResource1.ErrorMessage" CssClass="smallInfo warning"></asp:RequiredFieldValidator>
												<asp:CompareValidator ID="cvVGSettings3" runat="server" ControlToValidate="tbVG2VideoWidth" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" Type="Integer" ValidationGroup="vgVG2Settings" resourcekey="cvVGSettingsResource1.ErrorMessage" CssClass="smallInfo warning"></asp:CompareValidator>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblVideoGallery2Height" ResourceKey="lblVideoGallery2Height" runat="server" Text="Thumbnail height:" ControlName="tbVGVideoHeight" HelpText="Thumbnail height:" HelpKey="lblVideoGallery2Height.HelpText" Visible="True"></dnn:Label>
											</td>
											<td>
												<asp:TextBox ID="tbVG2VideoHeight" runat="server" CssClass="small textCenter" ValidationGroup="vgVG2Settings">100</asp:TextBox>
												<asp:RequiredFieldValidator ID="rfvVGHeight2" runat="server" ControlToValidate="tbVG2VideoHeight" ErrorMessage="This field is required." ValidationGroup="vgVG2Settings" Display="Dynamic" resourcekey="rfvVGHeightResource1.ErrorMessage" CssClass="smallInfo warning"></asp:RequiredFieldValidator>
												<asp:CompareValidator ID="cvVGSettings4" runat="server" ControlToValidate="tbVG2VideoHeight" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" Type="Integer" ValidationGroup="vgVG2Settings" resourcekey="cvVGSettings0Resource1.ErrorMessage" CssClass="smallInfo warning"></asp:CompareValidator>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblVideoGallery2ItemsPerPage" ResourceKey="lblVideoGallery2ItemsPerPage" runat="server" ControlName="tbVGItemsPerPage" HelpText="Set the number if items on one page:" Text="Items per page:" HelpKey="lblVideoGallery2ItemsPerPage.HelpText" />
											</td>
											<td>
												<asp:TextBox ID="tbVG2ItemsPerPage" runat="server" CssClass="small textCenter" ValidationGroup="vgVG2Settings">5</asp:TextBox>
												<asp:RequiredFieldValidator ID="rfvVGHeight3" runat="server" ControlToValidate="tbVG2ItemsPerPage" Display="Dynamic" ErrorMessage="This field is required." ValidationGroup="vgVG2Settings" resourcekey="rfvVGHeight0Resource1.ErrorMessage" CssClass="smallInfo warning"></asp:RequiredFieldValidator>
												<asp:CompareValidator ID="cvVGSettings5" runat="server" ControlToValidate="tbVG2ItemsPerPage" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" Type="Integer" ValidationGroup="vgVG2Settings" resourcekey="cvVGSettings1Resource1.ErrorMessage" CssClass="smallInfo warning"></asp:CompareValidator>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblVideoGallery2ColomunPerPage" runat="server" HelpKey="lblVideoGallery2ColomunPerPage.HelpText" HelpText="Set the number of columns:" ResourceKey="lblVideoGallery2ColomunPerPage" Text="Number of columns:" ControlName="tbVGNumberOfCols" />
											</td>
											<td>
												<asp:TextBox ID="tbVG2NumberOfCols" runat="server" ValidationGroup="vgVG2Settings" CssClass="small textCenter">5</asp:TextBox>
												<asp:RequiredFieldValidator ID="rfvVGHeight4" runat="server" ControlToValidate="tbVG2NumberOfCols" Display="Dynamic" ErrorMessage="This field is required." resourcekey="rfvVGHeight1Resource1.ErrorMessage" ValidationGroup="vgVG2Settings" CssClass="smallInfo warning"></asp:RequiredFieldValidator>
												<asp:CompareValidator ID="cvVGSettings6" runat="server" ControlToValidate="tbVG2NumberOfCols" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" resourcekey="cvVGSettings2Resource1.ErrorMessage" Type="Integer" ValidationGroup="vgVG2Settings" CssClass="smallInfo warning"></asp:CompareValidator>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblVideoGallery2ThumbnailRepeat" runat="server" HelpText="Thumbnail repeat direction:" Text="Thumbnail repeat direction:" HelpKey="lblVideoGallery2ThumbnailRepeat.HelpText" ResourceKey="lblVideoGallery2ThumbnailRepeat" />
											</td>
											<td>
												<div class="styledSelect">
													<asp:DropDownList ID="ddlVideoGallery2ThumbnailRepeat" runat="server">
														<asp:ListItem resourcekey="liHorizontalDir" Selected="True" Value="Horizontal">Horizontal</asp:ListItem>
														<asp:ListItem resourcekey="liVerticalDir" Value="Vertical">Vertical</asp:ListItem>
													</asp:DropDownList>
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblVideoGalelry2RandomizeMedia" runat="server" HelpText="Randomize media positions on every page load:" Text="Randomize media positions:" HelpKey="lblLightBoxRandomizeMedia.HelpText" ResourceKey="lblLightBoxRandomizeMedia" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbVideoGallery2RandomizeMedia" runat="server" OnCheckedChanged="cbVideoGallery2RandomizeMedia_CheckedChanged" resourcekey="cbLightBoxGallerySmartCropVerticalResource1" AutoPostBack="True" Text="Randomize media positions" />
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="Label11" runat="server" HelpText="Select media sorting options:" Text="Media sorting:" HelpKey="lblLightBoxMediaSorting.HelpText" ResourceKey="lblLightBoxMediaSorting" />
											</td>
											<td>
												<table class="clearWidth textLeft">
													<tr>
														<td>
															<div class="styledSelect">
																<asp:DropDownList ID="ddlVideoGallery2MediaSort" runat="server">
																	<asp:ListItem resourcekey="liPosition" Value="Position">Position</asp:ListItem>
																	<asp:ListItem resourcekey="liDateUploaded" Value="DateUploaded">Date uploaded</asp:ListItem>
																	<asp:ListItem resourcekey="liFileName" Value="FileName">Filename</asp:ListItem>
																	<asp:ListItem resourcekey="liTitle">Title</asp:ListItem>
																</asp:DropDownList>
															</div>
														</td>
														<td>&nbsp;</td>
														<td>
															<asp:RadioButtonList ID="rblVideoGallery2MediaSortType" runat="server" RepeatDirection="Horizontal" CssClass="styledRadio small">
																<asp:ListItem resourcekey="liAscending" Selected="True" Value="ASC">Ascending</asp:ListItem>
																<asp:ListItem resourcekey="liDescending" Value="DESC">Descending</asp:ListItem>
															</asp:RadioButtonList>
														</td>
													</tr>
												</table>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblVideoGallery2ShowImages" runat="server" HelpText="Show also images from this gallery:" Text="Show images:" HelpKey="lblVideoGallery2ShowImages.HelpText" ResourceKey="lblVideoGallery2ShowImages" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbVideoGallery2ShowImages" runat="server" Text="Show images" />
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblVideoGallery2ImageWidth" runat="server" HelpText="Image width:" Text="Image width:" HelpKey="lblVideoGallery2ImageWidth.HelpText" ResourceKey="lblVideoGallery2ImageWidth" />
											</td>
											<td>
												<asp:TextBox ID="tbVG2ImageWidth" runat="server" ValidationGroup="vgVG2Settings" CssClass="small textCenter">600</asp:TextBox>
												<asp:RequiredFieldValidator ID="rfvVGWidth2" runat="server" ControlToValidate="tbVG2ImageWidth" Display="Dynamic" ErrorMessage="This field is required." resourcekey="rfvVGWidthResource1.ErrorMessage" ValidationGroup="vgVG2Settings" CssClass="smallInfo warning"></asp:RequiredFieldValidator>
												<asp:CompareValidator ID="cvVGSettings12" runat="server" ControlToValidate="tbVG2ImageWidth" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" resourcekey="cvVGSettingsResource1.ErrorMessage" Type="Integer" ValidationGroup="vgVG2Settings" CssClass="smallInfo warning"></asp:CompareValidator>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblVideoGallery2ImageHeight" runat="server" HelpText="Image height:" Text="Image height:" HelpKey="lblVideoGallery2ImageHeight.HelpText" ResourceKey="lblVideoGallery2ImageHeight" />
											</td>
											<td>
												<asp:TextBox ID="tbVG2ImageHeight" runat="server" ValidationGroup="vgVG2Settings" CssClass="small textCenter">400</asp:TextBox>
												<asp:RequiredFieldValidator ID="rfvVGWidth3" runat="server" ControlToValidate="tbVG2ImageHeight" Display="Dynamic" ErrorMessage="This field is required." resourcekey="rfvVGWidthResource1.ErrorMessage" ValidationGroup="vgVG2Settings" CssClass="smallInfo warning"></asp:RequiredFieldValidator>
												<asp:CompareValidator ID="cvVGSettings13" runat="server" ControlToValidate="tbVG2ImageHeight" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" resourcekey="cvVGSettingsResource1.ErrorMessage" Type="Integer" ValidationGroup="vgVG2Settings"></asp:CompareValidator>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblVideoGalleryShowPaging0" runat="server" HelpText="Show paging:" Text="Show paging:" HelpKey="lblVideoGalleryShowPaging.HelpText" ResourceKey="lblVideoGalleryShowPaging" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbVideoGallery2ShowPaging" runat="server" Checked="True" Text="Show paging" />
												</div>
											</td>
										</tr>
										<tr>
											<td class="textTop">
												<dnn:Label ID="lblVideoGallery2ShowSocialSharing" runat="server" HelpText="Show social sharing:" Text="Show social sharing:" HelpKey="lblVideoGalleryShowSocialSharing.HelpText" ResourceKey="lblVideoGalleryShowSocialSharing" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbVideoGallery2ShowSocialSharing" runat="server" AutoPostBack="True" OnCheckedChanged="cbVideoGallery2ShowSocialSharing_CheckedChanged" Text="Show social sharing" />
												</div>
												<asp:Panel ID="pnlVideoGallery2SocialSharingOptions" runat="server">
													<table class="clearWidth textLeft nowrap">
														<tr>
															<td>
																<dnn:Label ID="lblVG2Opn" runat="server" HelpText="Open/Close sharing on button click:" Text="Open on button click:" HelpKey="lblVideoGallerySSOptions.HelpText" ResourceKey="lblVideoGallerySSOptions" />
															</td>
															<td>&nbsp;</td>
															<td>
																<div class="styledCheckbox noLabel">
																	<asp:CheckBox ID="cbVG2SSOpenOnButton" runat="server" Text="Open on button click:" />
																</div>
															</td>
														</tr>
													</table>
												</asp:Panel>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblVideoGallery2ShowSocialSharing0" runat="server" HelpText="Show textbox that contains media link:" Text="Show media link:" HelpKey="lblVideoGalleryShowBackLink.HelpText" ResourceKey="lblVideoGalleryShowBackLink" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbVideoGallery2ShowMediaLink" runat="server" Text="Show media link" />
												</div>
											</td>
										</tr>
									</table>
									<asp:Label ID="lblVideoGallery2Status" runat="server" EnableViewState="False"></asp:Label>
									<div class="mainActions">
										<asp:LinkButton ID="btnVideoGallery2SaveSettings" runat="server" OnClick="btnVideoGallery2SaveSettings_Click" resourcekey="btnVideoGallerySaveSettingsResource1" Text="Save settings" ValidationGroup="vgVG2Settings" CssClass="downSave" />
										<asp:LinkButton ID="btnVideoGallery2SaveClose" runat="server" OnClick="btnVideoGallery2SaveClose_Click" resourcekey="btnVideoGallerySaveCloseResource1" Text="Save &amp; Close" ValidationGroup="vgVG2Settings" CssClass="downSaveClose" />
									</div>
								</div>
							</asp:Panel>
							<asp:Panel ID="pnlVideoGallery3Settings" runat="server" Visible="False" CssClass="settingsList negativeMargins40">
								<h3>
									<asp:Label ID="lblVideoGalleryDisplay3Settings" runat="server" CssClass="settingsdetailtitle" resourcekey="lblVideoGalleryDisplay3Settings" Text="Video gallery 3 display settings"></asp:Label>
								</h3>
								<div class="settingsTable">
									<table>
										<tr>
											<td>
												<dnn:Label ID="lblVideoGallery3TemplateSelect" runat="server" HelpKey="lblVideoGallery2TemplateSelect.HelpText" HelpText="Select the control viewer template:" ResourceKey="lblVideoGallery2TemplateSelect" Text="Select template:" />
											</td>
											<td>
												<div class="styledSelect">
													<asp:DropDownList ID="ddlVideoGallery3TemplateSelect" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlVideoGallery3TemplateSelect_SelectedIndexChanged"></asp:DropDownList>
												</div>
												<div>
													<asp:Label ID="lblVG3TemplateInfo" runat="server"></asp:Label>
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblVideoGallery3SelectCSS" runat="server" HelpKey="lblVideoGallery2SelectCSS.HelpText" HelpText="Select the CSS theme file:" ResourceKey="lblVideoGallery2SelectCSS" Text="Select CSS:" />
											</td>
											<td>
												<div class="styledSelect">
													<asp:DropDownList ID="ddlVG3SelectCSS" runat="server"></asp:DropDownList>
												</div>
											</td>
										</tr>
										<tr>
											<td class="textTop">
												<dnn:Label ID="lblVideoGalelry3UseFlowPlayer" runat="server" HelpText="Select player:" Text="Select player:" HelpKey="SelectVideoPlayer.HelpText" ResourceKey="SelectVideoPlayer.Text" />
											</td>
											<td>
												<div class="styledSelect">
													<asp:DropDownList ID="ddlVG3SelectPlayer" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlVG3SelectPlayer_SelectedIndexChanged">
														<asp:ListItem Value="False">Standard</asp:ListItem>
														<asp:ListItem Value="True">Flow player</asp:ListItem>
													</asp:DropDownList>
												</div>
												<asp:Panel ID="pnlFlowPlayerOptionsVG3" runat="server" Visible="False">
													<div class="styledCheckbox paddingTop">
														<asp:CheckBox ID="cbFlowLoopVG3" runat="server" resourcekey="lblFlowVideoLoop" Text="Video loop:" />
													</div>
												</asp:Panel>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblVideoGallery3ShowTitle" runat="server" HelpKey="lblVideoGallery2ShowTitle.HelpText" HelpText="Show gallery title:" ResourceKey="lblVideoGallery2ShowTitle" Text="Show gallery title:" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbVideoGallery3ShowTitle" runat="server" resourcekey="cbVideoGalleryShowTitleResource1" Text="Show gallery title" />
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblVideoGallery3ShowDescription" runat="server" HelpKey="lblVideoGallery2ShowDescription.HelpText" HelpText="Show gallery description:" ResourceKey="lblVideoGallery2ShowDescription" Text="Show gallery description:" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbVideoGallery3ShowDescription" runat="server" resourcekey="cbVideoGalleryShowDescriptionResource1" Text="Show gallery description" />
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblVideoGallery3ShowMediaTitle" runat="server" HelpKey="lblVideoGallery2ShowMediaTitle.HelpText" HelpText="Show video title:" ResourceKey="lblVideoGallery2ShowMediaTitle" Text="Show video title:" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbVideoGallery3ShowMediaTitle" runat="server" resourcekey="cbVideoGalleryShowMediaTitleResource1" Text="Show video title" />
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblVideoGallery3ShowMediaDescription" runat="server" HelpKey="lblVideoGallery2ShowMediaDescription.HelpText" HelpText="Show video description:" ResourceKey="lblVideoGallery2ShowMediaDescription" Text="Show video description:" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbVideoGallery3ShowMediaDescription" runat="server" resourcekey="cbVideoGalleryShowMediaDescriptionResource1" Text="Show video description" />
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblVideoGallery3ShowMediaTitleThumbnail" runat="server" HelpKey="lblVideoGallery2ShowMediaTitleThumbnail.HelpText" HelpText="Show video title in thumbnail:" ResourceKey="lblVideoGallery2ShowMediaTitleThumbnail" Text="Show video title in thumbnail:" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbVideoGallery3ShowMediaTitleThumbnail" runat="server" resourcekey="cbVideoGalleryShowMediaTitleResource1" Text="Show video title in thumbnail" />
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblVideoGallery3ShowMediaDescriptionThumbnail" runat="server" HelpKey="lblVideoGallery2ShowMediaDescriptionThumbnail.HelpText" HelpText="Show video description in thumbnail:" ResourceKey="lblVideoGallery2ShowMediaDescriptionThumbnail" Text="Show video description in thumbnail:" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbVideoGallery3ShowMediaDescriptionThumbnail" runat="server" resourcekey="cbVideoGalleryShowMediaDescriptionResource1" Text="Show video description in thumbnail" />
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblVideoGallery3ShowMediaDescriptionInVideo" runat="server" HelpKey="lblVideoGallery2ShowMediaDescriptionInVideo.HelpText" HelpText="Show description inside video:" ResourceKey="lblVideoGallery2ShowMediaDescriptionInVideo" Text="Show description inside video:" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbVideoGallery3ShowMediaDescriptionInVideo" runat="server" resourcekey="cbVideoGalleryShowMediaDescriptionInVideoResource1" Text="Show description inside video" />
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblVideoGallery3UseThumbnailAsStartPhoto" runat="server" HelpKey="lblVideoGallery2UseThumbnailAsStartPhoto.HelpText" HelpText="Use thumbnail as start image:" ResourceKey="lblVideoGallery2UseThumbnailAsStartPhoto" Text="Use thumbnail as start image:" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbVideoGallery3UseThumbnailAsStartPhoto" runat="server" resourcekey="cbVideoGalleryUseThumbnailAsStartPhotoResource1" Text="Use thumbnail as start image" />
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblVideoGallery3PlayOnLoad" runat="server" HelpKey="lblVideoGallery2PlayOnLoad.HelpText" HelpText="Start to play video on page load:" ResourceKey="lblVideoGallery2PlayOnLoad" Text="Play on load:" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbVideoGallery3PlayOnLoad" runat="server" resourcekey="cbVideoGalleryPlayOnLoadResource1" Text="Play on load" />
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblVideoGallery3AllowFullscreen" runat="server" HelpKey="lblVideoGallery2AllowFullscreen.HelpText" HelpText="Allow video to be played fullscreen:" ResourceKey="lblVideoGallery2AllowFullscreen" Text="Allow fullscreen:" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbVideoGallery3AllowFullscreen" runat="server" resourcekey="cbVideoGalleryAllowFullscreenResource1" Text="Allow fullscreen" />
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblVideoGallery3PaggingVisible" runat="server" HelpKey="lblVideoGallery3PaggingVisible.HelpText" HelpText="Show pagging:" ResourceKey="lblVideoGallery3PaggingVisible" Text="Show pagging:" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbVideoGallery3ShowPagging" runat="server" resourcekey="cbVideoGalleryAllowFullscreenResource1" Text="Show pagging" />
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblVideoGallery3SelectSkin" runat="server" HelpKey="lblVideoGallery2SelectSkin.HelpText" HelpText="Select video player skin:" ResourceKey="lblVideoGallery2SelectSkin" Text="Select video player skin:" />
											</td>
											<td>
												<div class="styledSelect">
													<asp:DropDownList ID="ddlVG3SelectTheme" runat="server">
														<asp:ListItem resourcekey="ListItemResource30" Selected="True" Value="black">Black</asp:ListItem>
														<asp:ListItem resourcekey="ListItemResource31" Value="white">White</asp:ListItem>
													</asp:DropDownList>
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblVideoGallery3InitialVolume" runat="server" HelpKey="lblVideoGallery2InitialVolume.HelpText" HelpText="Initial video volume:" ResourceKey="lblVideoGallery2InitialVolume" Text="Initial video volume:" />
											</td>
											<td>
												<asp:TextBox ID="tbVG3InitialVolume" runat="server" ValidationGroup="vgVG3Settings" CssClass="small textCenter">250</asp:TextBox>
												<asp:RequiredFieldValidator ID="rfvSSTNOverOpacity2" runat="server" ControlToValidate="tbVG3InitialVolume" Display="Dynamic" ErrorMessage="This field is required." resourcekey="rfvSSTNOverOpacity0Resource1.ErrorMessage" ValidationGroup="vgVG3Settings" CssClass="smallInfo warning"></asp:RequiredFieldValidator>
												<asp:RangeValidator ID="rvVGTBInitialVolume1" runat="server" ControlToValidate="tbVG3InitialVolume" Display="Dynamic" ErrorMessage="Enter value between 0-300." MaximumValue="300" MinimumValue="0" resourcekey="rvVGTBInitialVolumeResource1.ErrorMessage" Type="Integer" ValidationGroup="vgVG3Settings" CssClass="smallInfo warning"></asp:RangeValidator>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblVideoGallery3Width" runat="server" HelpKey="lblVideoGallery2Width.HelpText" HelpText="Thumbnail width:" ResourceKey="lblVideoGallery2Width" Text="Thumbnail width:" Visible="True" />
											</td>
											<td>
												<asp:TextBox ID="tbVG3VideoWidth" runat="server" ValidationGroup="vgVG3Settings" CssClass="small textCenter">100</asp:TextBox>
												<asp:RequiredFieldValidator ID="rfvVGWidth1" runat="server" ControlToValidate="tbVG3VideoWidth" Display="Dynamic" ErrorMessage="This field is required." resourcekey="rfvVGWidthResource1.ErrorMessage" ValidationGroup="vgVG3Settings" CssClass="smallInfo warning"></asp:RequiredFieldValidator>
												<asp:CompareValidator ID="cvVGSettings7" runat="server" ControlToValidate="tbVG3VideoWidth" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" resourcekey="cvVGSettingsResource1.ErrorMessage" Type="Integer" ValidationGroup="vgVG3Settings" CssClass="smallInfo warning"></asp:CompareValidator>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblVideoGallery3Height" runat="server" ControlName="tbVGVideoHeight" HelpKey="lblVideoGallery2Height.HelpText" HelpText="Thumbnail height:" ResourceKey="lblVideoGallery2Height" Text="Thumbnail height:" Visible="True" />
											</td>
											<td>
												<asp:TextBox ID="tbVG3VideoHeight" runat="server" ValidationGroup="vgVG3Settings" CssClass="small textCenter">100</asp:TextBox>
												<asp:RequiredFieldValidator ID="rfvVGHeight5" runat="server" ControlToValidate="tbVG3VideoHeight" Display="Dynamic" ErrorMessage="This field is required." resourcekey="rfvVGHeightResource1.ErrorMessage" ValidationGroup="vgVG3Settings" CssClass="smallInfo warning"></asp:RequiredFieldValidator>
												<asp:CompareValidator ID="cvVGSettings8" runat="server" ControlToValidate="tbVG3VideoHeight" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" resourcekey="cvVGSettings0Resource1.ErrorMessage" Type="Integer" ValidationGroup="vgVG3Settings" CssClass="smallInfo warning"></asp:CompareValidator>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblVideoGallery3ItemstoShow" runat="server" ControlName="tbVGItemsPerPage" HelpKey="lblVideoGallery3ItemstoShow.HelpText" HelpText="Items to show:" ResourceKey="lblVideoGallery3ItemstoShow" Text="Items to show:" />
											</td>
											<td>
												<asp:TextBox ID="tbVG3ItemsPerPage" runat="server" ValidationGroup="vgVG3Settings" CssClass="small textCenter">5</asp:TextBox>
												<asp:RequiredFieldValidator ID="rfvVGHeight6" runat="server" ControlToValidate="tbVG3ItemsPerPage" Display="Dynamic" ErrorMessage="This field is required." resourcekey="rfvVGHeight0Resource1.ErrorMessage" ValidationGroup="vgVG3Settings" CssClass="smallInfo warning"></asp:RequiredFieldValidator>
												<asp:CompareValidator ID="cvVGSettings9" runat="server" ControlToValidate="tbVG3ItemsPerPage" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" resourcekey="cvVGSettings1Resource1.ErrorMessage" Type="Integer" ValidationGroup="vgVG3Settings" CssClass="smallInfo warning"></asp:CompareValidator>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblVideoGallery3ItemsToScroll" runat="server" ControlName="tbVGNumberOfCols" HelpKey="lblVideoGallery3ItemsToScroll.HelpText" HelpText="Items to scroll:" ResourceKey="lblVideoGallery3ItemsToScroll" Text="Items to scroll:" />
											</td>
											<td>
												<asp:TextBox ID="tbVG3NumberOfCols" runat="server" ValidationGroup="vgVG3Settings" CssClass="small textCenter">5</asp:TextBox>
												<asp:RequiredFieldValidator ID="rfvVGHeight7" runat="server" ControlToValidate="tbVG3NumberOfCols" Display="Dynamic" ErrorMessage="This field is required." resourcekey="rfvVGHeight1Resource1.ErrorMessage" ValidationGroup="vgVG3Settings" CssClass="smallInfo warning"></asp:RequiredFieldValidator>
												<asp:CompareValidator ID="cvVGSettings10" runat="server" ControlToValidate="tbVG3NumberOfCols" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" resourcekey="cvVGSettings2Resource1.ErrorMessage" Type="Integer" ValidationGroup="vgVG3Settings" CssClass="smallInfo warning"></asp:CompareValidator>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblVideoGallery3AutoSlide" runat="server" ControlName="tbVGNumberOfCols" HelpKey="lblVideoGallery3AutoSlide.HelpText" HelpText="Auto slide:" ResourceKey="lblVideoGallery3AutoSlide" Text="Auto slide:" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbVideoGallery3AutoSlide" runat="server" resourcekey="cbVideoGalleryAllowFullscreenResource1" Text="Auto slide" />
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblVideoGallery3AutoSlidePause" runat="server" HelpKey="lblVideoGallery3AutoSlidePause.HelpText" HelpText="Auto slide items pause:" ResourceKey="lblVideoGallery3AutoSlidePause" Text="Auto slide items pause:" ControlName="tbVGNumberOfCols" />
											</td>
											<td>
												<asp:TextBox ID="tbVG3AutoSlidePause" runat="server" ValidationGroup="vgVG3Settings" CssClass="small textCenter">5000</asp:TextBox>
												<asp:RequiredFieldValidator ID="rfvVGHeight8" runat="server" ControlToValidate="tbVG3AutoSlidePause" Display="Dynamic" ErrorMessage="This field is required." resourcekey="rfvVGHeight1Resource1.ErrorMessage" ValidationGroup="vgVG3Settings" CssClass="smallInfo warning"></asp:RequiredFieldValidator>
												<asp:CompareValidator ID="cvVGSettings11" runat="server" ControlToValidate="tbVG3AutoSlidePause" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" resourcekey="cvVGSettings2Resource1.ErrorMessage" Type="Integer" ValidationGroup="vgVG3Settings" CssClass="smallInfo warning"></asp:CompareValidator>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblVideoGalelry3RandomizeMedia" runat="server" HelpText="Randomize media positions on every page load:" Text="Randomize media positions:" HelpKey="lblLightBoxRandomizeMedia.HelpText" ResourceKey="lblLightBoxRandomizeMedia" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbVideoGallery3RandomizeMedia" runat="server" OnCheckedChanged="cbVideoGallery3RandomizeMedia_CheckedChanged" resourcekey="cbLightBoxGallerySmartCropVerticalResource1" AutoPostBack="True" Text="Randomize media positions" />
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="Label12" runat="server" HelpText="Select media sorting options:" Text="Media sorting:" HelpKey="lblLightBoxMediaSorting.HelpText" ResourceKey="lblLightBoxMediaSorting" />
											</td>
											<td>
												<table class="clearWidth textLeft">
													<tr>
														<td>
															<div class="styledSelect">
																<asp:DropDownList ID="ddlVideoGallery3MediaSort" runat="server">
																	<asp:ListItem resourcekey="liPosition" Value="Position">Position</asp:ListItem>
																	<asp:ListItem resourcekey="liDateUploaded" Value="DateUploaded">Date uploaded</asp:ListItem>
																	<asp:ListItem resourcekey="liFileName" Value="FileName">Filename</asp:ListItem>
																	<asp:ListItem resourcekey="liTitle">Title</asp:ListItem>
																</asp:DropDownList>
															</div>
														</td>
														<td>&nbsp;</td>
														<td>
															<asp:RadioButtonList ID="rblVideoGallery3MediaSortType" runat="server" RepeatDirection="Horizontal" CssClass="styledRadio small">
																<asp:ListItem resourcekey="liAscending" Selected="True" Value="ASC">Ascending</asp:ListItem>
																<asp:ListItem resourcekey="liDescending" Value="DESC">Descending</asp:ListItem>
															</asp:RadioButtonList>
														</td>
													</tr>
												</table>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblVideoGallery2ShowImages0" runat="server" HelpKey="lblVideoGallery2ShowImages.HelpText" HelpText="Show also images from this gallery:" ResourceKey="lblVideoGallery2ShowImages" Text="Show images:" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbVideoGallery3ShowImages" runat="server" Text="Show images:" />
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblVideoGallery2ImageWidth0" runat="server" HelpKey="lblVideoGallery2ImageWidth.HelpText" HelpText="Image width:" ResourceKey="lblVideoGallery2ImageWidth" Text="Image width:" />
											</td>
											<td>
												<asp:TextBox ID="tbVG3ImageWidth" runat="server" ValidationGroup="vgVG3Settings" CssClass="small textCenter">600</asp:TextBox>
												<asp:RequiredFieldValidator ID="rfvVGWidth4" runat="server" ControlToValidate="tbVG3ImageWidth" Display="Dynamic" ErrorMessage="This field is required." resourcekey="rfvVGWidthResource1.ErrorMessage" ValidationGroup="vgVG3Settings" CssClass="smallInfo warning"></asp:RequiredFieldValidator>
												<asp:CompareValidator ID="cvVGSettings14" runat="server" ControlToValidate="tbVG3ImageWidth" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" resourcekey="cvVGSettingsResource1.ErrorMessage" Type="Integer" ValidationGroup="vgVG3Settings" CssClass="smallInfo warning"></asp:CompareValidator>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblVideoGallery2ImageHeight0" runat="server" HelpKey="lblVideoGallery2ImageHeight.HelpText" HelpText="Image height:" ResourceKey="lblVideoGallery2ImageHeight" Text="Image height:" />
											</td>
											<td>
												<asp:TextBox ID="tbVG3ImageHeight" runat="server" ValidationGroup="vgVG3Settings" CssClass="small textCenter">400</asp:TextBox>
												<asp:RequiredFieldValidator ID="rfvVGWidth5" runat="server" ControlToValidate="tbVG3ImageHeight" Display="Dynamic" ErrorMessage="This field is required." resourcekey="rfvVGWidthResource1.ErrorMessage" ValidationGroup="vgVG3Settings" CssClass="smallInfo warning"></asp:RequiredFieldValidator>
												<asp:CompareValidator ID="cvVGSettings15" runat="server" ControlToValidate="tbVG3ImageHeight" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" resourcekey="cvVGSettingsResource1.ErrorMessage" Type="Integer" ValidationGroup="vgVG3Settings" CssClass="smallInfo warning"></asp:CompareValidator>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblVideoGallery2Arrows" runat="server" HelpText="Navigation arrows:" Text="Navigation arrows:" HelpKey="lblVideoGallery2Arrows.HelpText" ResourceKey="lblVideoGallery2Arrows" />
											</td>
											<td>
												<div class="styledSelect">
													<asp:DropDownList ID="ddlVG3Arrows" runat="server">
														<asp:ListItem resourcekey="liDefault">Default</asp:ListItem>
													</asp:DropDownList>
												</div>
											</td>
										</tr>
										<tr>
											<td class="textTop">
												<dnn:Label ID="lblVideoGallery2ShowSocialSharing2" runat="server" HelpText="Show social sharing:" Text="Show social sharing:" HelpKey="lblVideoGalleryShowSocialSharing.HelpText" ResourceKey="lblVideoGalleryShowSocialSharing" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbVideoGallery3ShowSocialSharing" runat="server" AutoPostBack="True" OnCheckedChanged="cbVideoGallery3ShowSocialSharing_CheckedChanged" Text="Show social sharing:" />
												</div>
												<asp:Panel ID="pnlVideoGallery3SocialSharingOptions" runat="server">
													<table class="clearWidth textLeft nowrap">
														<tr>
															<td>
																<dnn:Label ID="lblVideoGallery2SSOptions0" runat="server" HelpText="Open/Close sharing on button click:" Text="Open on button click:" HelpKey="lblVideoGallerySSOptions.HelpText" ResourceKey="lblVideoGallerySSOptions" />
															</td>
															<td>&nbsp;</td>
															<td>
																<div class="styledCheckbox noLabel">
																	<asp:CheckBox ID="cbVG3SSOpenOnButton" runat="server" Text="Open on button click" />
																</div>
															</td>
														</tr>
													</table>
												</asp:Panel>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblVideoGallery2ShowSocialSharing1" runat="server" HelpText="Show textbox that contains media link:" Text="Show media link:" HelpKey="lblVideoGalleryShowBackLink.HelpText" ResourceKey="lblVideoGalleryShowBackLink" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbVideoGallery3ShowMediaLink" runat="server" Text="Show media link:" />
												</div>
											</td>
										</tr>
									</table>
									<asp:Label ID="lblVideoGallery3Status" runat="server" EnableViewState="False"></asp:Label>
									<div class="mainActions">
										<asp:LinkButton ID="btnVideoGallery3SaveSettings" runat="server" OnClick="btnVideoGallery3SaveSettings_Click" resourcekey="btnVideoGallerySaveSettingsResource1" Text="Save settings" ValidationGroup="vgVG3Settings" CssClass="downSave" />
										<asp:LinkButton ID="btnVideoGallery3SaveClose" runat="server" OnClick="btnVideoGallery3SaveClose_Click" resourcekey="btnVideoGallerySaveCloseResource1" Text="Save &amp; Close" ValidationGroup="vgVG3Settings" CssClass="downSaveClose" />
									</div>
								</div>
							</asp:Panel>
							<asp:Panel ID="pnlSSthumbs" runat="server" Visible="False" CssClass="settingsList negativeMargins40">
								<h3>
									<asp:Label ID="lblSlideShowThumbnailsDisplaySettings" runat="server" CssClass="settingsdetailtitle" Text="Slideshow with thumbnails display settings" resourcekey="lblSlideShowThumbnailsDisplaySettingsResource1"></asp:Label>
								</h3>
								<div class="settingsTable">
									<table>
										<tr>
											<td class="textTop">
												<dnn:Label ID="lblSSthumbnailsTemplateSelect" runat="server" ControlName="ddlSSThemeSelect" HelpKey="lblLightboxTemplateSelect.HelpText" HelpText="Select the control viewer template:" ResourceKey="lblLightboxTemplateSelect" Text="Select template:" />
											</td>
											<td>
												<div class="styledSelect">
													<asp:DropDownList ID="ddlSSThumbnailsTemplateSelect" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlSSThumbnailsTemplateSelect_SelectedIndexChanged"></asp:DropDownList>
												</div>
												<asp:Label ID="lblSSthumbnailsTemplateInfo" runat="server"></asp:Label>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblSlideShowThumbnailsShowTitle" ResourceKey="lblSlideShowThumbnailsShowTitle" runat="server" HelpText="Show gallery title:" Text="Show gallery title:" HelpKey="lblSlideShowThumbnailsShowTitle.HelpText" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbSlideShowThumbnailsShowTitle" runat="server" resourcekey="cbSlideShowThumbnailsShowTitleResource1" Text="Show gallery title:" />
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblSlideShowThumbnailsShowDescription" ResourceKey="lblSlideShowThumbnailsShowDescription" runat="server" HelpText="Show gallery description:" Text="Show gallery description:" HelpKey="lblSlideShowThumbnailsShowDescription.HelpText" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbSlideShowThumbnailsShowDescription" runat="server" resourcekey="cbSlideShowThumbnailsShowDescriptionResource1" Text="Show gallery description" />
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblSlideShowThumbnailsShowMediaTitle" ResourceKey="lblSlideShowThumbnailsShowMediaTitle" runat="server" HelpText="Show media title:" Text="Show media title:" HelpKey="lblSlideShowThumbnailsShowMediaTitle.HelpText" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbSlideShowThumbnailsShowMediaTitle" runat="server" resourcekey="cbSlideShowThumbnailsShowMediaTitleResource1" Text="Show media title" />
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblSlideShowThumbnailsShowMediaDescription" ResourceKey="lblSlideShowThumbnailsShowMediaDescription" runat="server" HelpText="Show media description:" Text="Show media description:" HelpKey="lblSlideShowThumbnailsShowMediaDescription.HelpText" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbSlideShowThumbnailsShowMediaDescription" runat="server" resourcekey="cbSlideShowThumbnailsShowMediaDescriptionResource1" Text="Show media description" />
												</div>
											</td>
										</tr>
										<tr>
											<td class="textTop">
												<dnn:Label ID="lblSlideShowThumbnailsShowLightboxDescription" ResourceKey="lblSlideShowThumbnailsShowLightboxDescription" runat="server" HelpText="Show media description in lightbox:" Text="Show media description in lightbox:" HelpKey="lblSlideShowThumbnailsShowLightboxDescription.HelpText" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbSlideShowThumbnailsShowLightBoxDescription" runat="server" resourcekey="cbSlideShowThumbnailsShowLightBoxDescriptionResource1" AutoPostBack="True" OnCheckedChanged="cbSlideShowThumbnailsShowLightBoxDescription_CheckedChanged" Text="Show media description in lightbox" />
												</div>
												<asp:Panel ID="pnlSlideShowTNTipOptions" runat="server" BackColor="#CBEEF8" BorderColor="#65CDEB" BorderStyle="Solid" BorderWidth="2px" Visible="False">
													<table>
														<tr>
															<td colspan="2">
																<asp:Label ID="lblSlideShowTNToolTipOptions" runat="server" Font-Bold="True" resourcekey="lblLightBoxToolTipOptions" Text="Tooltip options"></asp:Label>
															</td>
														</tr>
														<tr>
															<td>
																<asp:Label ID="lblSlideShowLightboxShowTooltips0" runat="server" resourcekey="lblLightboxShowToolTips" Text="Show Tooltips:"></asp:Label>
															</td>
															<td>
																<asp:CheckBox ID="cbSSTNShowToolTips" runat="server" />
															</td>
														</tr>
														<tr>
															<td>
																<asp:Label ID="lblSlideShowTNTargetPosition" runat="server" resourcekey="lblLightboxTargetPosition" Text="Target position:"></asp:Label>
															</td>
															<td>
																<asp:DropDownList ID="ddlSlideShowTNTargetPosition" runat="server">
																	<asp:ListItem resourcekey="topLeft" Value="topLeft">Top left</asp:ListItem>
																	<asp:ListItem resourcekey="topMiddle" Value="topMiddle" Selected="True">Top middle</asp:ListItem>
																	<asp:ListItem resourcekey="topRight" Value="topRight">Top right</asp:ListItem>
																	<asp:ListItem resourcekey="leftTop" Value="leftTop">Left top</asp:ListItem>
																	<asp:ListItem resourcekey="leftMiddle" Value="leftMiddle">Left middle</asp:ListItem>
																	<asp:ListItem resourcekey="leftBottom" Value="leftBottom">Left bottom</asp:ListItem>
																	<asp:ListItem resourcekey="center" Value="center">Center</asp:ListItem>
																	<asp:ListItem resourcekey="rightTop" Value="rightTop">Right top</asp:ListItem>
																	<asp:ListItem resourcekey="rightMiddle" Value="rightMiddle">Right middle</asp:ListItem>
																	<asp:ListItem resourcekey="rightBottom" Value="rightBottom">Right bottom</asp:ListItem>
																	<asp:ListItem resourcekey="bottomLeft" Value="bottomLeft">Bottom left</asp:ListItem>
																	<asp:ListItem resourcekey="bottomMiddle" Value="bottomMiddle">Bottom middle</asp:ListItem>
																	<asp:ListItem resourcekey="bottomRight" Value="bottomRight">Bottom right</asp:ListItem>
																</asp:DropDownList>
															</td>
														</tr>
														<tr>
															<td>
																<asp:Label ID="lblSlideShowTNTooltipPosition" runat="server" resourcekey="lblLightboxTooltipPosition" Text="Tooltip position:"></asp:Label>
															</td>
															<td>
																<asp:DropDownList ID="ddlSlideShowTNTooltipPosition" runat="server">
																	<asp:ListItem resourcekey="topLeft" Value="topLeft">Top left</asp:ListItem>
																	<asp:ListItem resourcekey="topMiddle" Value="topMiddle">Top middle</asp:ListItem>
																	<asp:ListItem resourcekey="topRight" Value="topRight">Top right</asp:ListItem>
																	<asp:ListItem resourcekey="leftTop" Value="leftTop">Left top</asp:ListItem>
																	<asp:ListItem resourcekey="leftMiddle" Value="leftMiddle">Left middle</asp:ListItem>
																	<asp:ListItem resourcekey="leftBottom" Value="leftBottom">Left bottom</asp:ListItem>
																	<asp:ListItem resourcekey="center" Value="center">Center</asp:ListItem>
																	<asp:ListItem resourcekey="rightTop" Value="rightTop">Right top</asp:ListItem>
																	<asp:ListItem resourcekey="rightMiddle" Value="rightMiddle">Right middle</asp:ListItem>
																	<asp:ListItem resourcekey="rightBottom" Value="rightBottom">Right bottom</asp:ListItem>
																	<asp:ListItem resourcekey="bottomLeft" Value="bottomLeft">Bottom left</asp:ListItem>
																	<asp:ListItem resourcekey="bottomMiddle" Selected="True" Value="bottomMiddle">Bottom middle</asp:ListItem>
																	<asp:ListItem resourcekey="bottomRight" Value="bottomRight">Bottom right</asp:ListItem>
																</asp:DropDownList>
															</td>
														</tr>
														<tr>
															<td>
																<asp:Label ID="lblSlideShowTNShowEffect" runat="server" resourcekey="lblLightboxShowEffect" Text="Show effect:"></asp:Label>
															</td>
															<td>
																<asp:DropDownList ID="ddlSlideShowTNShoweffect" runat="server">
																	<asp:ListItem resourcekey="fade" Value="fade">Fade</asp:ListItem>
																	<asp:ListItem resourcekey="slide" Value="slide">Slide</asp:ListItem>
																	<asp:ListItem resourcekey="grow" Value="grow">Grow</asp:ListItem>
																</asp:DropDownList>
															</td>
														</tr>
														<tr>
															<td>
																<asp:Label ID="lblSlideShowTNShowEffectDuration" runat="server" resourcekey="lblLightboxShowEffectDuration" Text="Show effect duration (ms):"></asp:Label>
															</td>
															<td>
																<asp:TextBox ID="tbSlideShowTNTooltipShowDuration" runat="server" Width="53px">500</asp:TextBox>
																&nbsp;<asp:RequiredFieldValidator ID="rfvImageCarouselImageWidth16" runat="server" ControlToValidate="tbSlideShowTNTooltipShowDuration" Display="Dynamic" ErrorMessage="This field is required." resourcekey="rfvImageCarouselImageWidthResource1.ErrorMessage"
																	SetFocusOnError="True" ValidationGroup="vgSSTNSettings"></asp:RequiredFieldValidator>
																<asp:CompareValidator ID="cvImageCarouselImageWidth16" runat="server" ControlToValidate="tbSlideShowTNTooltipShowDuration" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" resourcekey="cvImageCarouselImageWidthResource1.ErrorMessage"
																	SetFocusOnError="True" Type="Integer" ValidationGroup="vgSSTNSettings">
																</asp:CompareValidator>
															</td>
														</tr>
														<tr>
															<td>
																<asp:Label ID="lblSlideShowTNShowHideEffect" runat="server" resourcekey="lblLightboxShowHideEffect" Text="Hide effect:"></asp:Label>
															</td>
															<td>
																<asp:DropDownList ID="ddlSlideShowTNHideEffect" runat="server">
																	<asp:ListItem resourcekey="fade" Value="fade">Fade</asp:ListItem>
																	<asp:ListItem resourcekey="slide" Value="slide">Slide</asp:ListItem>
																	<asp:ListItem resourcekey="grow" Value="grow">Grow</asp:ListItem>
																</asp:DropDownList>
															</td>
														</tr>
														<tr>
															<td>
																<asp:Label ID="lblSlideShowTNHideEffectDuration" runat="server" resourcekey="lblLightboxHideEffectDuration" Text="Hide effect duration (ms):"></asp:Label>
															</td>
															<td>
																<asp:TextBox ID="tbSlideShowTNTooltipHideDuration" runat="server" Width="53px">500</asp:TextBox>
																&nbsp;<asp:RequiredFieldValidator ID="rfvImageCarouselImageWidth17" runat="server" ControlToValidate="tbSlideShowTNTooltipHideDuration" Display="Dynamic" ErrorMessage="This field is required." resourcekey="rfvImageCarouselImageWidthResource1.ErrorMessage"
																	SetFocusOnError="True" ValidationGroup="vgSSTNSettings"></asp:RequiredFieldValidator>
																<asp:CompareValidator ID="cvImageCarouselImageWidth17" runat="server" ControlToValidate="tbSlideShowTNTooltipHideDuration" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" resourcekey="cvImageCarouselImageWidthResource1.ErrorMessage"
																	SetFocusOnError="True" Type="Integer" ValidationGroup="vgSSTNSettings">
																</asp:CompareValidator>
															</td>
														</tr>
														<tr>
															<td>
																<asp:Label ID="lblSlideShowTNTooltipBorder" runat="server" resourcekey="lblLightboxTooltipBorder" Text="Border:"></asp:Label>
															</td>
															<td>
																<asp:TextBox ID="tbSlideShowTNTooltipBorder" runat="server" Width="53px">5</asp:TextBox>
																&nbsp;<asp:RequiredFieldValidator ID="rfvImageCarouselImageWidth18" runat="server" ControlToValidate="tbSlideShowTNTooltipBorder" Display="Dynamic" ErrorMessage="This field is required." resourcekey="rfvImageCarouselImageWidthResource1.ErrorMessage" SetFocusOnError="True"
																	ValidationGroup="vgSSSettings"></asp:RequiredFieldValidator>
																<asp:CompareValidator ID="cvImageCarouselImageWidth18" runat="server" ControlToValidate="tbSlideShowTNTooltipCornerRadius" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" resourcekey="cvImageCarouselImageWidthResource1.ErrorMessage"
																	SetFocusOnError="True" Type="Integer" ValidationGroup="vgSSTNSettings">
																</asp:CompareValidator>
															</td>
														</tr>
														<tr>
															<td>
																<asp:Label ID="lblSlideShowTNTooltipCornerRadius" runat="server" resourcekey="lblLightboxTooltipCornerRadius" Text="Corner radius:"></asp:Label>
															</td>
															<td>
																<asp:TextBox ID="tbSlideShowTNTooltipCornerRadius" runat="server" Width="53px">5</asp:TextBox>
																&nbsp;<asp:RequiredFieldValidator ID="rfvImageCarouselImageWidth19" runat="server" ControlToValidate="tbSlideShowTNTooltipCornerRadius" Display="Dynamic" ErrorMessage="This field is required." resourcekey="rfvImageCarouselImageWidthResource1.ErrorMessage"
																	SetFocusOnError="True" ValidationGroup="vgSSTNSettings"></asp:RequiredFieldValidator>
																<asp:CompareValidator ID="cvImageCarouselImageWidth19" runat="server" ControlToValidate="tbSlideShowTNTooltipCornerRadius" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" resourcekey="cvImageCarouselImageWidthResource1.ErrorMessage"
																	SetFocusOnError="True" Type="Integer" ValidationGroup="vgSSSettings">
																</asp:CompareValidator>
															</td>
														</tr>
														<tr>
															<td>
																<asp:Label ID="lblSlideShowTNTooltipTheme" runat="server" resourcekey="lblLightboxTooltipTheme" Text="Select theme:"></asp:Label>
															</td>
															<td>
																<asp:DropDownList ID="ddlSlideShowTNTooltipTheme" runat="server">
																	<asp:ListItem resourcekey="cream" Value="cream">Yellow</asp:ListItem>
																	<asp:ListItem resourcekey="dark" Value="dark">Dark</asp:ListItem>
																	<asp:ListItem resourcekey="green" Value="green">Green</asp:ListItem>
																	<asp:ListItem resourcekey="light" Value="light">Light</asp:ListItem>
																	<asp:ListItem resourcekey="red" Value="red">Red</asp:ListItem>
																	<asp:ListItem resourcekey="blue" Value="blue">Blue</asp:ListItem>
																</asp:DropDownList>
															</td>
														</tr>
													</table>
												</asp:Panel>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblSlideShowThumbnailsOpenMediaUrl" ResourceKey="lblSlideShowThumbnailsOpenMediaUrl" runat="server" HelpText="On image click dont open image in lightbox, but open Media Url link." Text="On click go to Media Url:" HelpKey="lblSlideShowThumbnailsOpenMediaUrl.HelpText" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbSlideShowThumbnailsOpenMediaUrl" runat="server" AutoPostBack="True" OnCheckedChanged="cbSSTNOpenMediaUrl_CheckedChanged" resourcekey="cbSlideShowThumbnailsOpenMediaUrlResource1" Text="On click go to Media Url" />
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblSlideShowThumbnailsOpenMediaUrlNewWindow" ResourceKey="lblSlideShowThumbnailsOpenMediaUrlNewWindow" runat="server" HelpText="Open link in new window:" Text="Open link in new window:" HelpKey="lblSlideShowThumbnailsOpenMediaUrlNewWindow.HelpText" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbSSTNOpenMediaUrlNewWindow" runat="server" Enabled="False" resourcekey="cbSSTNOpenMediaUrlNewWindowResource1" Text="Open link in new window" />
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblSlideShowThumbnailsImageWidth" ResourceKey="lblSlideShowThumbnailsImageWidth" runat="server" ControlName="tbSSTBWidth" HelpText="Set the width of main image panel:" Text="Image width:" HelpKey="lblSlideShowThumbnailsImageWidth.HelpText" />
											</td>
											<td>
												<asp:TextBox ID="tbSSTBWidth" runat="server" ValidationGroup="vgSSTNSettings" CssClass="small textCenter"></asp:TextBox>
												<asp:RequiredFieldValidator ID="rfvSlideShowThumbnailsImageWidth" runat="server" ControlToValidate="tbSSTBWidth" Display="Dynamic" ErrorMessage="This field is required." ValidationGroup="vgSSTNSettings" resourcekey="rfvSSTNWidthResource1.ErrorMessage" CssClass="smallInfo warning"></asp:RequiredFieldValidator>
												<asp:CompareValidator ID="cvSlideShowThumbnailsImageWidth" runat="server" ControlToValidate="tbSSTBWidth" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" Type="Integer" ValidationGroup="vgSSTNSettings" resourcekey="cvSlideShowThumbnailsImageWidthResource1.ErrorMessage" CssClass="smallInfo warning"></asp:CompareValidator>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblSlideShowThumbnailsImageHeight" ResourceKey="lblSlideShowThumbnailsImageHeight" runat="server" Text="Image height:" ControlName="tbSSTHHeight" HelpText="Set the height of main image panel:" HelpKey="lblSlideShowThumbnailsImageHeight.HelpText"></dnn:Label>
											</td>
											<td>
												<asp:TextBox ID="tbSSTHHeight" runat="server" ValidationGroup="vgSSTNSettings" CssClass="small textCenter"></asp:TextBox>
												<asp:RequiredFieldValidator ID="rfvSlideShowThumbnailsImageHeight" runat="server" ControlToValidate="tbSSTHHeight" ErrorMessage="This field is required." ValidationGroup="vgSSTNSettings" Display="Dynamic" resourcekey="rfvSSTNHeightResource1.ErrorMessage" CssClass="smallInfo warning"></asp:RequiredFieldValidator>
												<asp:CompareValidator ID="cvSlideShowThumbnailsImageHeight" runat="server" ControlToValidate="tbSSTHHeight" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" Type="Integer" ValidationGroup="vgSSTNSettings" resourcekey="cvSlideShowThumbnailsImageHeightResource1.ErrorMessage" CssClass="smallInfo warning"></asp:CompareValidator>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblSlideShowThumbnailsThumbWidth" ResourceKey="lblSlideShowThumbnailsThumbWidth" runat="server" Text="Thumbnail width:" HelpText="Set the width of thumbnail image in filmstrip:" ControlName="tbSSTHumbwidth" HelpKey="lblSlideShowThumbnailsThumbWidth.HelpText"></dnn:Label>
											</td>
											<td>
												<asp:TextBox ID="tbSSTHumbwidth" runat="server" ValidationGroup="vgSSTNSettings" CssClass="small textCenter"></asp:TextBox>
												<asp:RequiredFieldValidator ID="rfvSlideShowThumbnailsThumbWidth" runat="server" ControlToValidate="tbSSTHumbwidth" ErrorMessage="This field is required." ValidationGroup="vgSSTNSettings" Display="Dynamic" resourcekey="rfvSlideShowThumbnailsThumbWidthResource1.ErrorMessage" CssClass="smallInfo warning"></asp:RequiredFieldValidator>
												<asp:CompareValidator ID="cvSlideShowThumbnailsThumbWidth" runat="server" ControlToValidate="tbSSTHumbwidth" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" Type="Integer" ValidationGroup="vgSSTNSettings" resourcekey="cvSlideShowThumbnailsThumbWidthResource1.ErrorMessage" CssClass="smallInfo warning"></asp:CompareValidator>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblSlideShowThumbnailsThumbHeight" ResourceKey="lblSlideShowThumbnailsThumbHeight" runat="server" Text="Thumbnail height:" ControlName="tbSSTHumbHeight" HelpText="Set the height of thumbnail image in filmstrip:" HelpKey="lblSlideShowThumbnailsThumbHeight.HelpText"></dnn:Label>
											</td>
											<td>
												<asp:TextBox ID="tbSSTHumbHeight" runat="server" ValidationGroup="vgSSTNSettings" CssClass="small textCenter"></asp:TextBox>
												<asp:RequiredFieldValidator ID="rfvSlideShowThumbnailsThumnHeight" runat="server" ControlToValidate="tbSSTHumbHeight" Display="Dynamic" ErrorMessage="This field is required." ValidationGroup="vgSSTNSettings" resourcekey="rfvSlideShowThumbnailsThumnHeightResource1.ErrorMessage" CssClass="smallInfo warning"></asp:RequiredFieldValidator>
												<asp:CompareValidator ID="cvSlideShowThumbnailsThumbHeight" runat="server" ControlToValidate="tbSSTHumbHeight" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" Type="Integer" ValidationGroup="vgSSTNSettings" resourcekey="cvSlideShowThumbnailsThumbHeightResource1.ErrorMessage" CssClass="smallInfo warning"></asp:CompareValidator>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblSlideShowThumbnailsProportionalImages" ResourceKey="lblSlideShowThumbnailsProportionalImages" runat="server" ControlName="tbSSTHumbHeight" HelpText="Proportionally resize images:" Text="Proportionally resize images:" HelpKey="lblSlideShowThumbnailsProportionalImages.HelpText" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbSlideShowThumbnailsProportionalImages" runat="server" resourcekey="cbSlideShowThumbnailsProportionalImagesResource1" Text="Proportionally resize images" />
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblSlideShowThumbnailsOvlerlayPosition" ResourceKey="lblSlideShowThumbnailsOvlerlayPosition" runat="server" Text="Overlay position:" ControlName="rblSSTBOverlayPosition" HelpText="Set the position of overlay for title and description:" HelpKey="lblSlideShowThumbnailsOvlerlayPosition.HelpText"></dnn:Label>
											</td>
											<td>
												<asp:RadioButtonList ID="rblSlideShowThumbnailsOverlayPosition" runat="server" RepeatDirection="Horizontal" CssClass="styledRadio small">
													<asp:ListItem Selected="True" Value="top" resourcekey="ListItemResource32">Top</asp:ListItem>
													<asp:ListItem Value="bottom" resourcekey="ListItemResource33">Bottom</asp:ListItem>
												</asp:RadioButtonList>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblSlideShowThumbnailsOverlaySize" ResourceKey="lblSlideShowThumbnailsOverlaySize" runat="server" Text="Overlay size (px):" ControlName="tbSSTBOverlaySize" HelpText="Set the size of overlay in pixels:" HelpKey="lblSlideShowThumbnailsOverlaySize.HelpText"></dnn:Label>
											</td>
											<td>
												<asp:TextBox ID="tbSSTBOverlaySize" runat="server" CssClass="small textCenter" ValidationGroup="vgSSTNSettings"></asp:TextBox>
												<asp:RequiredFieldValidator ID="rfvSlideShowThumbnailsOverlaySize" runat="server" ControlToValidate="tbSSTBOverlaySize" Display="Dynamic" ErrorMessage="This field is required." ValidationGroup="vgSSTNSettings" resourcekey="rfvSlideShowThumbnailsOverlaySizeResource1.ErrorMessage" CssClass="smallInfo warning"></asp:RequiredFieldValidator>
												<asp:CompareValidator ID="cvSlideShowThumbnailsOverlaySize" runat="server" ControlToValidate="tbSSTBOverlaySize" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" Type="Integer" ValidationGroup="vgSSTNSettings" resourcekey="cvSlideShowThumbnailsOverlaySizeResource1.ErrorMessage" CssClass="smallInfo warning"></asp:CompareValidator>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblSlideShowThumbnailsOverlayOpacity" ResourceKey="lblSlideShowThumbnailsOverlayOpacity" runat="server" Text="Overlay opacity (0-100):" ControlName="tbSSTBOveryOpacity" HelpText="Set the percentage of overlay opacity. Values between 0 and 100." HelpKey="lblSlideShowThumbnailsOverlayOpacity.HelpText"></dnn:Label>
											</td>
											<td>
												<asp:TextBox ID="tbSSTBOveryOpacity" runat="server" CssClass="small textCenter" ValidationGroup="vgSSTNSettings"></asp:TextBox>
												<asp:RequiredFieldValidator ID="rfvSlideShowThumbnailsOverlayOpacity" runat="server" ControlToValidate="tbSSTBOveryOpacity" Display="Dynamic" ErrorMessage="This field is required." ValidationGroup="vgSSTNSettings" resourcekey="rfvSlideShowThumbnailsOverlayOpacityResource1.ErrorMessage" CssClass="smallInfo warning"></asp:RequiredFieldValidator>
												<asp:RangeValidator ID="rvSlideShowThumbnailsOverlayOpacity" runat="server" ControlToValidate="tbSSTBOveryOpacity" Display="Dynamic" ErrorMessage="Enter value between 0-100." MaximumValue="100" MinimumValue="0" Type="Integer" ValidationGroup="vgSSTNSettings" resourcekey="rvSlideShowThumbnailsOverlayOpacityResource1.ErrorMessage" CssClass="smallInfo warning"></asp:RangeValidator>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblSlideShowThumbnailsOverlayTextColor" ResourceKey="lblSlideShowThumbnailsOverlayTextColor" runat="server" Text="Overlay text color (hex value RRGGBB):" ControlName="tbSSTBOverlayTextColor" HelpText="Set the color of ovarlay text in rgb format with hex values:" HelpKey="lblSlideShowThumbnailsOverlayTextColor.HelpText"></dnn:Label>
											</td>
											<td>
												<asp:TextBox ID="tbSSTBOverlayTextColor" runat="server" MaxLength="6" CssClass="small textCenter" ValidationGroup="vgSSTNSettings"></asp:TextBox>
												<asp:RequiredFieldValidator ID="rfvSlideShowThumbnailsOverlayTextColor" runat="server" ControlToValidate="tbSSTBOverlayTextColor" Display="Dynamic" ErrorMessage="This field is required." ValidationGroup="vgSSTNSettings" resourcekey="rfvSlideShowThumbnailsOverlayTextColorResource1.ErrorMessage" CssClass="smallInfo warning"></asp:RequiredFieldValidator>
												<asp:RegularExpressionValidator ID="revSlideShowThumbnailsOverlayTextColor" Display="Dynamic" runat="server" ControlToValidate="tbSSTBOverlayTextColor" ErrorMessage="Please eneter hexadecimal color value." ValidationExpression="^#?([a-f]|[A-F]|[0-9]){3}(([a-f]|[A-F]|[0-9]){3})?$" ValidationGroup="vgSSTNSettings" resourcekey="revSlideShowThumbnailsOverlayTextColorResource1.ErrorMessage" CssClass="smallInfo warning"></asp:RegularExpressionValidator>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblSlideShowThumbnailsOverlayColor" ResourceKey="lblSlideShowThumbnailsOverlayColor" runat="server" ControlName="tbSSTBOverlayColor" HelpText="Set the color of overlay in rgb format with hex values:" Text="Overlay color (hex value RRGGBB):" HelpKey="lblSlideShowThumbnailsOverlayColor.HelpText" />
											</td>
											<td>
												<asp:TextBox ID="tbSSTBOverlayColor" runat="server" MaxLength="6" CssClass="small textCenter">eeeeee</asp:TextBox>
												<asp:RequiredFieldValidator ID="rfvSlideShowThumbnailsOverlayColor" runat="server" ControlToValidate="tbSSTBOverlayColor" Display="Dynamic" ErrorMessage="This field is required." ValidationGroup="vgSSTNSettings" resourcekey="rfvSlideShowThumbnailsOverlayColorResource1.ErrorMessage" CssClass="smallInfo warning"></asp:RequiredFieldValidator>
												<asp:RegularExpressionValidator ID="revSlideShowThumbnailsOverlayColor" runat="server" Display="Dynamic" ControlToValidate="tbSSTBOverlayColor" ErrorMessage="Please eneter hexadecimal color value." ValidationExpression="^#?([a-f]|[A-F]|[0-9]){3}(([a-f]|[A-F]|[0-9]){3})?$" ValidationGroup="vgSSTNSettings" resourcekey="revSlideShowThumbnailsOverlayColorResource1.ErrorMessage" CssClass="smallInfo warning"></asp:RegularExpressionValidator>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblSlideShowThumbnailsThumbPosition" ResourceKey="lblSlideShowThumbnailsThumbPosition" runat="server" Text="Thumbnail position:" ControlName="rblSSTBThumbNailPosition" HelpText="Set the position of filmstrip with thumbnails:" HelpKey="lblSlideShowThumbnailsThumbPosition.HelpText"></dnn:Label>
											</td>
											<td>
												<asp:RadioButtonList ID="rblSlideShowThumbnailsThumbnailPosition" runat="server" RepeatDirection="Horizontal" CssClass="styledRadio small">
													<asp:ListItem Selected="True" Value="top" resourcekey="ListItemResource34">Top</asp:ListItem>
													<asp:ListItem Value="bottom" resourcekey="ListItemResource35">Bottom</asp:ListItem>
												</asp:RadioButtonList>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblSlideShowThumbnailsTransparentThumbnails" ResourceKey="lblSlideShowThumbnailsTransparentThumbnails" runat="server" ControlName="rblSSTBThumbNailPosition" HelpText="Transparent thumbnail navigation:" Text="Transparent thumbnail navigation:" HelpKey="lblSlideShowThumbnailsTransparentThumbnails.HelpText" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbSlideShowThumbnailsTransparentThumbnails" runat="server" AutoPostBack="True" OnCheckedChanged="cbSSTBTransparentThumbnails_CheckedChanged" resourcekey="cbSlideShowThumbnailsTransparentThumbnailsResource1" Text="Transparent thumbnail navigation" />
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblSlideShowThumbnailsTransitionTime" ResourceKey="lblSlideShowThumbnailsTransitionTime" runat="server" Text="Transition interval (ms):" ControlName="tbSSTBTransition" HelpText="Set the pause time between image transition in miliseconds:" HelpKey="lblSlideShowThumbnailsTransitionTime.HelpText"></dnn:Label>
											</td>
											<td>
												<asp:TextBox ID="tbSSTBTransition" runat="server" CssClass="small textCenter" ValidationGroup="vgSSTNSettings"></asp:TextBox>
												<asp:RequiredFieldValidator ID="rfvSlideShowThumbnailsTransitionTime" runat="server" ControlToValidate="tbSSTBTransition" Display="Dynamic" ErrorMessage="This field is required." ValidationGroup="vgSSTNSettings" resourcekey="rfvSlideShowThumbnailsTransitionTimeResource1.ErrorMessage" CssClass="smallInfo warning"></asp:RequiredFieldValidator>
												<asp:CompareValidator ID="cvSlideShowThumbnailsTransitionTime" runat="server" ControlToValidate="tbSSTBTransition" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" Type="Integer" ValidationGroup="vgSSTNSettings" resourcekey="cvSlideShowThumbnailsTransitionTimeResource1.ErrorMessage" CssClass="smallInfo warning"></asp:CompareValidator>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblSlideShowThumbnailsTransitionSpeed" ResourceKey="lblSlideShowThumbnailsTransitionSpeed" runat="server" ControlName="tbSSTBTransitionSpeed" HelpText="Set the transition time in miliseconds:" Text="Transition speed (ms):" HelpKey="lblSlideShowThumbnailsTransitionSpeed.HelpText" />
											</td>
											<td>
												<asp:TextBox ID="tbSSTBTransitionSpeed" runat="server" CssClass="small textCenter">800</asp:TextBox>
												<asp:RequiredFieldValidator ID="rfvSlideShowThumbnailsTransitionSpeed" runat="server" ControlToValidate="tbSSTBTransitionSpeed" Display="Dynamic" ErrorMessage="This field is required." ValidationGroup="vgSSTNSettings" resourcekey="rfvSlideShowThumbnailsTransitionSpeedResource1.ErrorMessage" CssClass="smallInfo warning"></asp:RequiredFieldValidator>
												<asp:CompareValidator ID="cvSlideShowThumbnailsTransitionSpeed" runat="server" ControlToValidate="tbSSTBTransitionSpeed" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" Type="Integer" ValidationGroup="vgSSTNSettings" resourcekey="cvSlideShowThumbnailsTransitionSpeedResource1.ErrorMessage" CssClass="smallInfo warning"></asp:CompareValidator>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblSlideShowThumbnailsShowPanel" ResourceKey="lblSlideShowThumbnailsShowPanel" runat="server" Text="Show main panel:" ControlName="cbSSTNMainPanel" HelpText="Set to show or hide main image panel:" HelpKey="lblSlideShowThumbnailsShowPanel.HelpText"></dnn:Label>
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbSlideShowThumbnailsMainPanel" runat="server" OnCheckedChanged="cbSSTNMainPanel_CheckedChanged" AutoPostBack="True" resourcekey="cbSlideShowThumbnailsMainPanelResource1" Text="Show main panel" />
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblSlideShowThumbnailsFilmstrip" ResourceKey="lblSlideShowThumbnailsFilmstrip" runat="server" Text="Show filmstrip:" ControlName="cbSSTNFilmStrip" HelpText="Set to show or hide filmstrip:" HelpKey="lblSlideShowThumbnailsFilmstrip.HelpText"></dnn:Label>
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbSlideShowThumbnailsFilmStrip" runat="server" OnCheckedChanged="cbSSTNFilmStrip_CheckedChanged" resourcekey="cbSlideShowThumbnailsFilmStripResource1" Text="Show filmstrip" />
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblSlideShowThumbnailsFilmStripSize" ResourceKey="lblSlideShowThumbnailsFilmStripSize" runat="server" ControlName="tbSSTNFilmStripSize" HelpText="Set the number of images in filmstrip:" Text="Number of images in filmstrip:" HelpKey="lblSlideShowThumbnailsFilmStripSize.HelpText" />
											</td>
											<td>
												<asp:TextBox ID="tbSSTNFilmStripSize" runat="server" Enabled="False" CssClass="small textCenter" ValidationGroup="vgSSTNSettings">4</asp:TextBox>
												<asp:RequiredFieldValidator ID="rfvSlideShowThumbnailsFilmStripSize" runat="server" ControlToValidate="tbSSTNFilmStripSize" Display="Dynamic" ErrorMessage="This field is required." ValidationGroup="vgSSTNSettings" resourcekey="rfvSlideShowThumbnailsFilmStripSizeResource1.ErrorMessage" CssClass="smallInfo warning"></asp:RequiredFieldValidator>
												<asp:CompareValidator ID="cvSlideShowThumbnailsFilmStripSize" runat="server" ControlToValidate="tbSSTNFilmStripSize" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" Type="Integer" ValidationGroup="vgSSTNSettings" resourcekey="cvSlideShowThumbnailsFilmStripSizeResource1.ErrorMessage" CssClass="smallInfo warning"></asp:CompareValidator>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblSlideShowThumbnailsDisplayBorder" ResourceKey="lblSlideShowThumbnailsDisplayBorder" runat="server" ControlName="tbSSTNBorderSize" HelpText="Display border:" Text="Display border:" HelpKey="lblSlideShowThumbnailsDisplayBorder.HelpText" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbSlideShowThumbnailsDisplayBorder" runat="server" resourcekey="cbSlideShowThumbnailsDisplayBorderResource1" Text="Display border" />
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblSlideShowThumbnailsBorderColor" ResourceKey="lblSlideShowThumbnailsBorderColor" runat="server" ControlName="tbSSTNBorderSize" HelpText="Set the border color in rgb format with hex values:" Text="Border color (hex value RRGGBB):" HelpKey="lblSlideShowThumbnailsBorderColor.HelpText" />
											</td>
											<td>
												<asp:TextBox ID="tbSSTBBorderColor" runat="server" MaxLength="6" ValidationGroup="vgSSTNSettings" CssClass="small textCenter">222222</asp:TextBox>
												<asp:RequiredFieldValidator ID="rfvSlideShowThumbnailsBorderColor" runat="server" ControlToValidate="tbSSTBBorderColor" Display="Dynamic" ErrorMessage="This field is required." ValidationGroup="vgSSTNSettings" resourcekey="rfvSlideShowThumbnailsBorderColorResource1.ErrorMessage" CssClass="smallInfo warning"></asp:RequiredFieldValidator>
												<asp:RegularExpressionValidator ID="revSlideShowThumbnailsBorderColor" Display="Dynamic" runat="server" ControlToValidate="tbSSTBBorderColor" ErrorMessage="Please eneter hexadecimal color value." ValidationExpression="^#?([a-f]|[A-F]|[0-9]){3}(([a-f]|[A-F]|[0-9]){3})?$" ValidationGroup="vgSSTNSettings" resourcekey="revSlideShowThumbnailsBorderColorResource1.ErrorMessage" CssClass="smallInfo warning"></asp:RegularExpressionValidator>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblSlideShowThumbnailsRandomizeMedia" runat="server" HelpKey="lblLightBoxRandomizeMedia.HelpText" HelpText="Randomize media positions on every page load:" ResourceKey="lblLightBoxRandomizeMedia" Text="Randomize media positions:" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbSlideShowThumbnailsRandomizeMedia" runat="server" OnCheckedChanged="cbSlideShowThumbnailsRandomizeMedia_CheckedChanged" resourcekey="cbLightBoxGallerySmartCropVerticalResource1" AutoPostBack="True" Text="Randomize media positions" />
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="Label3" runat="server" HelpText="Select media sorting options:" Text="Media sorting:" HelpKey="lblLightBoxMediaSorting.HelpText" ResourceKey="lblLightBoxMediaSorting" />
											</td>
											<td>
												<table class="clearWidth textLeft">
													<tr>
														<td>
															<div class="styledSelect">
																<asp:DropDownList ID="ddlSSTNMediaSort" runat="server">
																	<asp:ListItem resourcekey="liPosition" Value="Position">Position</asp:ListItem>
																	<asp:ListItem resourcekey="liDateUploaded" Value="DateUploaded">Date uploaded</asp:ListItem>
																	<asp:ListItem resourcekey="liFileName" Value="FileName">Filename</asp:ListItem>
																	<asp:ListItem resourcekey="liTitle">Title</asp:ListItem>
																</asp:DropDownList>
															</div>
														</td>
														<td>&nbsp;</td>
														<td>
															<asp:RadioButtonList ID="rblSSTNMediaSort" runat="server" RepeatDirection="Horizontal" CssClass="styledRadio small">
																<asp:ListItem resourcekey="liAscending" Selected="True" Value="ASC">Ascending</asp:ListItem>
																<asp:ListItem resourcekey="liDescending" Value="DESC">Descending</asp:ListItem>
															</asp:RadioButtonList>
														</td>
													</tr>
												</table>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblSlideShowThumbnailsFilmstripColor" runat="server" ControlName="tbSSTNBorderSize" HelpText="Set the filmstrip background color in rgb format with hex values:" Text="Filmstrip background color (hex value RRGGBB):" HelpKey="lblSlideShowThumbnailsFilmstripColor.HelpText" ResourceKey="lblSlideShowThumbnailsFilmstripColor" />
											</td>
											<td>
												<asp:TextBox ID="tbSSTBFilmstripBackColor" runat="server" MaxLength="6" ValidationGroup="vgSSTNSettings" CssClass="small textCenter">000000</asp:TextBox>
												<asp:RequiredFieldValidator ID="rfvSlideShowThumbnailsBorderColor1" runat="server" ControlToValidate="tbSSTBFilmstripBackColor" Display="Dynamic" ErrorMessage="This field is required." resourcekey="rfvSlideShowThumbnailsBorderColorResource1.ErrorMessage" ValidationGroup="vgSSTNSettings" CssClass="smallInfo warning"></asp:RequiredFieldValidator>
												<asp:RegularExpressionValidator ID="revSlideShowThumbnailsBorderColor1" runat="server" ControlToValidate="tbSSTBFilmstripBackColor" Display="Dynamic" ErrorMessage="Please eneter hexadecimal color value." resourcekey="revSlideShowThumbnailsBorderColorResource1.ErrorMessage" ValidationExpression="^#?([a-f]|[A-F]|[0-9]){3}(([a-f]|[A-F]|[0-9]){3})?$" ValidationGroup="vgSSTNSettings" CssClass="smallInfo warning"></asp:RegularExpressionValidator>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblSlideShowMainPAnelBackColor" runat="server" ControlName="tbSSTNBorderSize" HelpText="Set the main panel background color in rgb format with hex values:" Text="Main panel background color (hex value RRGGBB):" HelpKey="lblSlideShowMainPAnelBackColor.HelpText" ResourceKey="lblSlideShowMainPAnelBackColor" />
											</td>
											<td>
												<asp:TextBox ID="tbSSTBMainPAnelBackColor" runat="server" MaxLength="6" ValidationGroup="vgSSTNSettings" CssClass="small textCenter">FFFFFF</asp:TextBox>
												<asp:RequiredFieldValidator ID="rfvSlideShowThumbnailsBorderColor2" runat="server" ControlToValidate="tbSSTBMainPAnelBackColor" Display="Dynamic" ErrorMessage="This field is required." resourcekey="rfvSlideShowThumbnailsBorderColorResource1.ErrorMessage" ValidationGroup="vgSSTNSettings" CssClass="smallInfo warning"></asp:RequiredFieldValidator>
												<asp:RegularExpressionValidator ID="revSlideShowThumbnailsBorderColor2" runat="server" Display="Dynamic" ControlToValidate="tbSSTBMainPAnelBackColor" ErrorMessage="Please eneter hexadecimal color value." resourcekey="revSlideShowThumbnailsBorderColorResource1.ErrorMessage" ValidationExpression="^#?([a-f]|[A-F]|[0-9]){3}(([a-f]|[A-F]|[0-9]){3})?$" ValidationGroup="vgSSTNSettings" CssClass="smallInfo warning"></asp:RegularExpressionValidator>
											</td>
										</tr>
									</table>
									<asp:Label ID="lblSlideShowThumbnailsStatus" runat="server" EnableViewState="False"></asp:Label>
									<div class="mainActions">
										<asp:LinkButton ID="btnSlideShowThumbnailsSave" runat="server" OnClick="btnSaveSSthumbSet_Click" Text="Save settings" ValidationGroup="vgSSTNSettings" resourcekey="btnSlideShowThumbnailsSaveResource1" CssClass="downSave" />
										<asp:LinkButton ID="btnSlideShowThumbnailsSaveClose" runat="server" OnClick="btnSSTNSaveClose_Click" Text="Save &amp; Close" ValidationGroup="vgSSTNSettings" resourcekey="btnSlideShowThumbnailsSaveCloseResource1" CssClass="downSaveClose" />
									</div>
								</div>
							</asp:Panel>
							<asp:Panel ID="pnlSSthumbs2" runat="server" Visible="False" CssClass="settingsList negativeMargins40">
								<h3>
									<asp:Label ID="lblSlideshowWithThumbnails2" resourcekey="lblSlideshowWithThumbnails2" runat="server" CssClass="settingsdetailtitle" Text="Slideshow with thumbnails 2"></asp:Label>
								</h3>
								<div class="settingsTable">
									<table>
										<tr>
											<td class="textTop">
												<dnn:Label ID="lblSSthumbnails2TemplateSelect" runat="server" ResourceKey="lblSSthumbnails2TemplateSelect" HelpText="Select the control viewer template:" Text="Select template:" HelpKey="lblSSthumbnails2TemplateSelect.HelpText" />
											</td>
											<td>
												<div class="styledSelect">
													<asp:DropDownList ID="ddlSSThumbnails2TemplateSelect" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlSSThumbnails2TemplateSelect_SelectedIndexChanged"></asp:DropDownList>
												</div>
												<div>
													<asp:Label ID="lblSSthumbnails2TemplateInfo" runat="server"></asp:Label>
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblSSthumbnails2ThemeSelect" runat="server" HelpKey="lblSSthumbnails2ThemeSelect.HelpText" HelpText="Select CSS theme:" ResourceKey="lblSSthumbnails2ThemeSelect" Text="Sleect theme:" />
											</td>
											<td>
												<div class="styledSelect">
													<asp:DropDownList ID="ddlSSTN2ThemeSelect" runat="server"></asp:DropDownList>
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblSlideShowThumbnails2ShowTitle" ResourceKey="lblSlideShowThumbnails2ShowTitle" runat="server" HelpText="Show gallery title:" Text="Show gallery title:" HelpKey="lblSlideShowThumbnails2ShowTitle.HelpText" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbSlideShowThumbnails2ShowTitle" runat="server" resourcekey="cbSlideShowThumbnailsShowTitleResource1" Text="Show gallery title" />
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblSlideShowThumbnails2ShowDescription" ResourceKey="lblSlideShowThumbnails2ShowDescription" runat="server" HelpText="Show gallery description:" Text="Show gallery description:" HelpKey="lblSlideShowThumbnails2ShowDescription.HelpText" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbSlideShowThumbnails2ShowDescription" runat="server" resourcekey="cbSlideShowThumbnailsShowDescriptionResource1" Text="Show gallery description" />
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblSlideShowThumbnails2ShowMediaTitle" ResourceKey="lblSlideShowThumbnails2ShowMediaTitle" runat="server" HelpText="Show media title:" Text="Show media title:" HelpKey="lblSlideShowThumbnails2ShowMediaTitle.HelpText" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbSlideShowThumbnails2ShowMediaTitle" runat="server" resourcekey="cbSlideShowThumbnailsShowMediaTitleResource1" Text="Show media title" />
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblSlideShowThumbnails2ShowMediaDescription" ResourceKey="lblSlideShowThumbnails2ShowMediaDescription" runat="server" HelpText="Show media description:" Text="Show media description:" HelpKey="lblSlideShowThumbnails2ShowMediaDescription.HelpText" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbSlideShowThumbnails2ShowMediaDescription" runat="server" resourcekey="cbSlideShowThumbnailsShowMediaDescriptionResource1" Text="Show media description" />
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblSlideShowThumbnails2ImageWidth" ResourceKey="lblSlideShowThumbnails2ImageWidth" runat="server" Text="Image width:" ControlName="tbSSTBWidth" HelpText="Set the width of main image panel:" HelpKey="lblSlideShowThumbnails2ImageWidth.HelpText"></dnn:Label>
											</td>
											<td>
												<asp:TextBox ID="tbSSTB2Width" runat="server" ValidationGroup="vgSSTN2Settings" CssClass="small textCenter">500</asp:TextBox>
												<asp:RequiredFieldValidator ID="rfvSlideShowThumbnails2ImageWidth" runat="server" ControlToValidate="tbSSTB2Width" ErrorMessage="This field is required." ValidationGroup="vgSSTN2Settings" Display="Dynamic" resourcekey="rfvSSTNWidthResource1.ErrorMessage" CssClass="smallInfo warning"></asp:RequiredFieldValidator>
												<asp:CompareValidator ID="cvSlideShowThumbnails2ImageWidth" runat="server" ControlToValidate="tbSSTB2Width" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" Type="Integer" ValidationGroup="vgSSTN2Settings" resourcekey="cvSlideShowThumbnailsImageWidthResource1.ErrorMessage" CssClass="smallInfo warning"></asp:CompareValidator>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblSlideShowThumbnails2ImageHeight" ResourceKey="lblSlideShowThumbnails2ImageHeight" runat="server" Text="Image height:" HelpText="Set the height of main image panel:" ControlName="tbSSTHHeight" HelpKey="lblSlideShowThumbnails2ImageHeight.HelpText"></dnn:Label>
											</td>
											<td>
												<asp:TextBox ID="tbSSTH2Height" runat="server" ValidationGroup="vgSSTN2Settings" CssClass="small textCenter">500</asp:TextBox>
												<asp:RequiredFieldValidator ID="rfvSlideShowThumbnails2ImageHeight" runat="server" ControlToValidate="tbSSTH2Height" ErrorMessage="This field is required." ValidationGroup="vgSSTN2Settings" Display="Dynamic" resourcekey="rfvSSTNHeightResource1.ErrorMessage" CssClass="smallInfo warning"></asp:RequiredFieldValidator>
												<asp:CompareValidator ID="cvSlideShowThumbnails2ImageHeight" runat="server" ControlToValidate="tbSSTH2Height" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" Type="Integer" ValidationGroup="vgSSTN2Settings" resourcekey="cvSlideShowThumbnailsImageHeightResource1.ErrorMessage" CssClass="smallInfo warning"></asp:CompareValidator>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblSlideShowThumbnails2ThumbWidth" ResourceKey="lblSlideShowThumbnails2ThumbWidth" runat="server" Text="Thumbnail width:" ControlName="tbSSTHumbwidth" HelpText="Set the width of thumbnail image in filmstrip:" HelpKey="lblSlideShowThumbnails2ThumbWidth.HelpText"></dnn:Label>
											</td>
											<td>
												<asp:TextBox ID="tbSS2THumbwidth" runat="server" ValidationGroup="vgSSTN2Settings" CssClass="small textCenter">75</asp:TextBox>
												<asp:RequiredFieldValidator ID="rfvSlideShowThumbnails2ThumbWidth" runat="server" ControlToValidate="tbSS2THumbwidth" Display="Dynamic" ErrorMessage="This field is required." ValidationGroup="vgSSTN2Settings" resourcekey="rfvSlideShowThumbnailsThumbWidthResource1.ErrorMessage" CssClass="smallInfo warning"></asp:RequiredFieldValidator>
												<asp:CompareValidator ID="cvSlideShowThumbnails2ThumbWidth" runat="server" ControlToValidate="tbSS2THumbwidth" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" Type="Integer" ValidationGroup="vgSSTN2Settings" resourcekey="cvSlideShowThumbnailsThumbWidthResource1.ErrorMessage" CssClass="smallInfo warning"></asp:CompareValidator>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblSlideShowThumbnails2ThumbHeight" ResourceKey="lblSlideShowThumbnails2ThumbHeight" runat="server" ControlName="tbSSTHumbHeight" HelpText="Set the height of thumbnail image:" Text="Thumbnail height:" HelpKey="lblSlideShowThumbnails2ThumbHeight.HelpText" />
											</td>
											<td>
												<asp:TextBox ID="tbSS2THumbHeight" runat="server" ValidationGroup="vgSSTN2Settings" CssClass="small textCenter">75</asp:TextBox>
												<asp:RequiredFieldValidator ID="rfvSlideShowThumbnails2ThumnHeight" runat="server" ControlToValidate="tbSS2THumbHeight" Display="Dynamic" ErrorMessage="This field is required." resourcekey="rfvSlideShowThumbnailsThumnHeightResource1.ErrorMessage" ValidationGroup="vgSSTN2Settings" CssClass="smallInfo warning"></asp:RequiredFieldValidator>
												<asp:CompareValidator ID="cvSlideShowThumbnails2ThumbHeight" runat="server" ControlToValidate="tbSS2THumbHeight" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" resourcekey="cvSlideShowThumbnailsThumbHeightResource1.ErrorMessage" Type="Integer" ValidationGroup="vgSSTN2Settings" CssClass="smallInfo warning"></asp:CompareValidator>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblSlideShowThumbnails2ProportionalImages" runat="server" ControlName="tbSSTHumbHeight" HelpKey="lblSlideShowThumbnails2ProportionalImages.HelpText" HelpText="Proportionally resize images:" ResourceKey="lblSlideShowThumbnails2ProportionalImages" Text="Proportionally resize images:" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbSlideShowThumbnails2ProportionalImages" runat="server" resourcekey="cbSlideShowThumbnailsProportionalImagesResource1" Text="Proportionally resize images" />
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblSlideShowThumbnails2FilmStripSize" runat="server" HelpKey="lblSlideShowThumbnails2FilmStripSize.HelpText" HelpText="Set the number of thumbnails per page:" ResourceKey="lblSlideShowThumbnails2FilmStripSize" Text="Number of thumbnails:" ControlName="tbSSTNFilmStripSize" />
											</td>
											<td>
												<asp:TextBox ID="tbSSTN2FilmStripSize" runat="server" ValidationGroup="vgSSTN2Settings" CssClass="small textCenter">9</asp:TextBox>
												<asp:RequiredFieldValidator ID="rfvSlideShowThumbnails2FilmStripSize" runat="server" ControlToValidate="tbSSTNFilmStripSize" Display="Dynamic" ErrorMessage="This field is required." resourcekey="rfvSlideShowThumbnailsFilmStripSizeResource1.ErrorMessage" ValidationGroup="vgSSTN2Settings" CssClass="smallInfo warning"></asp:RequiredFieldValidator>
												<asp:CompareValidator ID="cvSlideShowThumbnails2FilmStripSize" runat="server" ControlToValidate="tbSSTNFilmStripSize" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" resourcekey="cvSlideShowThumbnailsFilmStripSizeResource1.ErrorMessage" Type="Integer" ValidationGroup="vgSSTN2Settings" CssClass="smallInfo warning"></asp:CompareValidator>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblSlideShowThumbnails2TransitionTime" runat="server" HelpKey="lblSlideShowThumbnailsTransitionTime.HelpText" HelpText="Set the pause time between image transition in miliseconds:" ResourceKey="lblSlideShowThumbnailsTransitionTime" Text="Transition interval (ms):" />
											</td>
											<td>
												<asp:TextBox ID="tbSSTB2Transition" runat="server" ValidationGroup="vgSSTN2Settings" CssClass="small textCenter">2000</asp:TextBox>
												<asp:RequiredFieldValidator ID="rfvSlideShowThumbnails2TransitionTime" runat="server" ControlToValidate="tbSSTB2Transition" Display="Dynamic" ErrorMessage="This field is required." resourcekey="rfvSlideShowThumbnailsTransitionTimeResource1.ErrorMessage" ValidationGroup="vgSSTN2Settings" CssClass="smallInfo warning"></asp:RequiredFieldValidator>
												<asp:CompareValidator ID="cvSlideShowThumbnails2TransitionTime" runat="server" ControlToValidate="tbSSTB2Transition" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" resourcekey="cvSlideShowThumbnailsTransitionTimeResource1.ErrorMessage" Type="Integer" ValidationGroup="vgSSTN2Settings" CssClass="smallInfo warning"></asp:CompareValidator>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblSlideShowThumbnails2TransitionSpeed" runat="server" ControlName="tbSSTBTransitionSpeed" HelpKey="lblSlideShowThumbnails2TransitionSpeed.HelpText" HelpText="Set the transition time in miliseconds:" ResourceKey="lblSlideShowThumbnails2TransitionSpeed" Text="Transition speed (ms):" />
											</td>
											<td>
												<asp:TextBox ID="tbSSTB2TransitionSpeed" runat="server" ValidationGroup="vgSSTN2Settings" CssClass="small textCenter">800</asp:TextBox>
												<asp:RequiredFieldValidator ID="rfvSlideShowThumbnails2TransitionSpeed" runat="server" ControlToValidate="tbSSTB2TransitionSpeed" Display="Dynamic" ErrorMessage="This field is required." resourcekey="rfvSlideShowThumbnailsTransitionSpeedResource1.ErrorMessage" ValidationGroup="vgSSTN2Settings" CssClass="smallInfo warning"></asp:RequiredFieldValidator>
												<asp:CompareValidator ID="cvSlideShowThumbnails2TransitionSpeed" runat="server" ControlToValidate="tbSSTB2TransitionSpeed" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" resourcekey="cvSlideShowThumbnailsTransitionSpeedResource1.ErrorMessage" Type="Integer" ValidationGroup="vgSSTN2Settings" CssClass="smallInfo warning"></asp:CompareValidator>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblSlideShowThumbnails2ThumbPosition" runat="server" ControlName="rblSSTBThumbNailPosition" HelpKey="lblSlideShowThumbnails2ThumbPosition.HelpText" HelpText="Set the position of thumbnail paging:" Text="Thumbnail paging position:" ResourceKey="lblSlideShowThumbnails2ThumbPosition" />
											</td>
											<td>
												<asp:RadioButtonList ID="rblSlideShowThumbnails2ThumbnailPosition" runat="server" RepeatDirection="Horizontal" CssClass="styledRadio small">
													<asp:ListItem resourcekey="ListItemResource34" Selected="True" Value="top">Top</asp:ListItem>
													<asp:ListItem resourcekey="ListItemResource35" Value="bottom">Bottom</asp:ListItem>
													<asp:ListItem resourcekey="ListItemResourceTaB" Value="tab">Top and bottom</asp:ListItem>
												</asp:RadioButtonList>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblSlideShowThumbnails2RandomizeMedia" runat="server" HelpKey="lblLightBoxRandomizeMedia.HelpText" HelpText="Randomize media positions on every page load:" ResourceKey="lblLightBoxRandomizeMedia" Text="Randomize media positions:" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbSlideShowThumbnails2RandomizeMedia" runat="server" OnCheckedChanged="cbSlideShowThumbnails2RandomizeMedia_CheckedChanged" resourcekey="cbLightBoxGallerySmartCropVerticalResource1" AutoPostBack="True" Text="Randomize media positions" />
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="Label4" runat="server" HelpText="Select media sorting options:" Text="Media sorting:" HelpKey="lblLightBoxMediaSorting.HelpText" ResourceKey="lblLightBoxMediaSorting" />
											</td>
											<td>
												<table class="clearWidth textLeft">
													<tr>
														<td>
															<div class="styledSelect">
																<asp:DropDownList ID="ddlSSTN2MediaSort" runat="server">
																	<asp:ListItem resourcekey="liPosition" Value="Position">Position</asp:ListItem>
																	<asp:ListItem resourcekey="liDateUploaded" Value="DateUploaded">Date uploaded</asp:ListItem>
																	<asp:ListItem resourcekey="liFileName" Value="FileName">Filename</asp:ListItem>
																	<asp:ListItem resourcekey="liTitle">Title</asp:ListItem>
																</asp:DropDownList>
															</div>
														</td>
														<td>&nbsp;</td>
														<td>
															<asp:RadioButtonList ID="rblSSTN2MediaSortType" runat="server" RepeatDirection="Horizontal" CssClass="styledRadio small">
																<asp:ListItem resourcekey="liAscending" Selected="True" Value="ASC">Ascending</asp:ListItem>
																<asp:ListItem resourcekey="liDescending" Value="DESC">Descending</asp:ListItem>
															</asp:RadioButtonList>
														</td>
													</tr>
												</table>
											</td>
										</tr>
									</table>
									<asp:Label ID="lblSlideShowThumbnails2Status" runat="server" EnableViewState="False"></asp:Label>
									<div class="mainActions">
										<asp:LinkButton ID="btnSlideShowThumbnails2Save" runat="server" OnClick="btnSlideShowThumbnails2Save_Click" resourcekey="btnSlideShowThumbnailsSaveResource1" Text="Save settings" ValidationGroup="vgSSTN2Settings" CssClass="downSave" />
										<asp:LinkButton ID="btnSlideShowThumbnails2SaveClose" runat="server" OnClick="btnSlideShowThumbnails2SaveClose_Click" resourcekey="btnSlideShowThumbnailsSaveCloseResource1" Text="Save &amp; Close" ValidationGroup="vgSSTN2Settings" CssClass="downSaveClose" />
									</div>
								</div>
							</asp:Panel>
							<asp:Panel ID="pnlAudioGallerySettings" runat="server" Visible="False" CssClass="settingsList negativeMargins40">
								<h3>
									<asp:Label ID="lblAudioGalleryDisplaySettins" resourcekey="AudioGalleryTitle" runat="server" Text="Audio gallery display settings" CssClass="settingsdetailtitle"></asp:Label>
								</h3>
								<div class="settingsTable">
									<table>
										<tr>
											<td>
												<dnn:Label ID="lblAudioGalleryThemeSelect" runat="server" ControlName="ddlTGThemeSelect" HelpKey="lblAudioGalleryThemeSelect.HelpText" HelpText="Select the CSS theme file:" ResourceKey="lblAudioGalleryThemeSelect" Text="Select CSS:" />
											</td>
											<td>
												<div class="styledSelect">
													<asp:DropDownList ID="ddlAGThemeSelect" runat="server"></asp:DropDownList>
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblAudioGalleryShowTitle" runat="server" HelpKey="lblAudioGalleryShowTitle.HelpText" HelpText="Show gallery title:" ResourceKey="lblAudioGalleryShowTitle" Text="Show gallery title:" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbAudioGalleryShowTitle" runat="server" resourcekey="cbAudioGalleryShowTitleResource1" Text="Show gallery title" />
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblAudioGalleryShowDescription" ResourceKey="lblAudioGalleryShowDescription" runat="server" HelpText="Show gallery description:" Text="Show gallery description:" HelpKey="lblAudioGalleryShowDescription.HelpText" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbAudioGalleryShowDescrition" runat="server" resourcekey="cbAudioGalleryShowDescritionResource1" Text="Show gallery description" />
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblAudioGalleryShowMediaTitle" ResourceKey="lblAudioGalleryShowMediaTitle" runat="server" HelpText="Show media title:" Text="Show media title:" HelpKey="lblAudioGalleryShowMediaTitle.HelpText" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbAudioGalleryShowMediaTitle" runat="server" resourcekey="cbAudioGalleryShowMediaTitleResource1" Text="Show media title" />
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblAudioGalleryShowMediaDescription" ResourceKey="lblAudioGalleryShowMediaDescription" runat="server" HelpText="Show media description:" Text="Show media description:" HelpKey="lblAudioGalleryShowMediaDescription.HelpText" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbAudioGalleryShowMediaDescrition" runat="server" resourcekey="cbAudioGalleryShowMediaDescritionResource1" Text="Show media description" />
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblAudioGalleryPlayOnLoad" ResourceKey="lblAudioGalleryPlayOnLoad" runat="server" HelpText="Start playing audio file on page load:" Text="Play on load:" HelpKey="lblAudioGalleryPlayOnLoad.HelpText" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbAudioGalleryPlayOnLoad" runat="server" resourcekey="cbAudioGalleryPlayOnLoadResource1" Text="Play on load" />
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblAudioGalleryItemsPrePage" ResourceKey="lblAudioGalleryItemsPrePage" runat="server" ControlName="tbAGSNumberOfItems" HelpText="Set the number of items per page:" Text="Number of items per page:" HelpKey="lblAudioGalleryItemsPrePage.HelpText" />
											</td>
											<td>
												<asp:TextBox ID="tbAGSNumberOfItems" runat="server" ValidationGroup="vgAGS" CssClass="small textCenter"></asp:TextBox>
												<asp:RequiredFieldValidator ID="rfvAudioGalleryItemsPerPage" runat="server" ControlToValidate="tbAGSNumberOfItems" Display="Dynamic" ErrorMessage="This field is required." ValidationGroup="vgAGS" resourcekey="rfvAudioGalleryItemsPerPageResource1.ErrorMessage"></asp:RequiredFieldValidator>
												<asp:CompareValidator ID="cvAudioGalleryItemsPerPage" runat="server" ControlToValidate="tbAGSNumberOfItems" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" Type="Integer" ValidationGroup="vgAGS" resourcekey="cvAudioGalleryItemsPerPageResource1.ErrorMessage"></asp:CompareValidator>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblAudioGalleryColumns" ResourceKey="lblAudioGalleryColumns" runat="server" ControlName="tbAGSNumberOfItems" HelpText="Set the number of columns:" Text="Number of columns:" HelpKey="lblAudioGalleryColumns.HelpText" />
											</td>
											<td>
												<asp:TextBox ID="tbAGSNumberOfColumns" runat="server" ValidationGroup="vgAGS" CssClass="small textCenter">1</asp:TextBox>
												<asp:RequiredFieldValidator ID="rfvAudioGalleryColumns" runat="server" ControlToValidate="tbAGSNumberOfColumns" Display="Dynamic" ErrorMessage="This field is required." ValidationGroup="vgAGS" resourcekey="rfvAudioGalleryColumnsResource1.ErrorMessage"></asp:RequiredFieldValidator>
												<asp:CompareValidator ID="cvAudioGalleryColumns" runat="server" ControlToValidate="tbAGSNumberOfColumns" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" Type="Integer" ValidationGroup="vgAGS" resourcekey="cvAudioGalleryColumnsResource1.ErrorMessage"></asp:CompareValidator>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblAudioGalleryPlayerWidth" ResourceKey="lblAudioGalleryPlayerWidth" runat="server" ControlName="tbAGSPlayerWidth" HelpText="Set the width of audio player in pixels. Minimum value is 300." Text="Player width (px):" HelpKey="lblAudioGalleryPlayerWidth.HelpText" />
											</td>
											<td>
												<asp:TextBox ID="tbAGSPlayerWidth" runat="server" ValidationGroup="vgAGS" CssClass="small textCenter"></asp:TextBox>
												<asp:RequiredFieldValidator ID="rfvAudioGalleryPlayerWidth" runat="server" ControlToValidate="tbAGSPlayerWidth" Display="Dynamic" ErrorMessage="This field is required." ValidationGroup="vgAGS" resourcekey="rfvAudioGalleryPlayerWidthResource1.ErrorMessage"></asp:RequiredFieldValidator>
												<asp:RangeValidator ID="rvAudioGalleryPlayerWidth" runat="server" ControlToValidate="tbAGSPlayerWidth" Display="Dynamic" ErrorMessage="Minimum player width is 90px." MaximumValue="10000" MinimumValue="90" Type="Integer" ValidationGroup="vgAGS" resourcekey="rvAudioGalleryPlayerWidthResource1.ErrorMessage"></asp:RangeValidator>
												<asp:CompareValidator ID="cvAudioGalleryPlayerWidth" runat="server" ControlToValidate="tbAGSPlayerWidth" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" Type="Integer" ValidationGroup="vgAGS" resourcekey="cvAudioGalleryPlayerWidthResource1.ErrorMessage"></asp:CompareValidator>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblAudioGalleryVolume" ResourceKey="lblAudioGalleryVolume" runat="server" ControlName="tbAudioGalleryPlayerVolume" HelpText="Audio volume:" Text="Audio volume:" HelpKey="lblAudioGalleryVolume.HelpText" />
											</td>
											<td>
												<asp:TextBox ID="tbAudioGalleryPlayerVolume" runat="server" ValidationGroup="vgAGS" CssClass="small textCenter">100</asp:TextBox>
												<asp:RequiredFieldValidator ID="rfvAudioGalleryPlayerVolume" runat="server" ControlToValidate="tbAudioGalleryPlayerVolume" Display="Dynamic" ErrorMessage="This field is required." ValidationGroup="vgAGS" resourcekey="rfvAudioGalleryPlayerVolumeResource1.ErrorMessage"></asp:RequiredFieldValidator>
												<asp:RangeValidator ID="rvAudioGalleryVolume" runat="server" ControlToValidate="tbAudioGalleryPlayerVolume" Display="Dynamic" ErrorMessage="Enter value between 0-100." MaximumValue="100" MinimumValue="0" Type="Integer" ValidationGroup="vgAGS" resourcekey="rvAudioGalleryVolumeResource1.ErrorMessage"></asp:RangeValidator>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblAudioGalleryRandomizeMedia" runat="server" HelpKey="lblLightBoxRandomizeMedia.HelpText" HelpText="Randomize media positions on every page load:" ResourceKey="lblLightBoxRandomizeMedia" Text="Randomize media positions:" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbAudioGalleryRandomizeMedia" runat="server" OnCheckedChanged="cbAudioGalleryRandomizeMedia_CheckedChanged" resourcekey="cbLightBoxGallerySmartCropVerticalResource1" AutoPostBack="True" Text="Randomize media positions:" />
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="Label13" runat="server" HelpText="Select media sorting options:" Text="Media sorting:" HelpKey="lblLightBoxMediaSorting.HelpText" ResourceKey="lblLightBoxMediaSorting" />
											</td>
											<td>
												<table class="clearWidth textLeft">
													<tr>
														<td>
															<div class="styledSelect">
																<asp:DropDownList ID="ddlAudioGalleryMediaSort" runat="server">
																	<asp:ListItem resourcekey="liPosition" Value="Position">Position</asp:ListItem>
																	<asp:ListItem resourcekey="liDateUploaded" Value="DateUploaded">Date uploaded</asp:ListItem>
																	<asp:ListItem resourcekey="liFileName" Value="FileName">Filename</asp:ListItem>
																	<asp:ListItem resourcekey="liTitle">Title</asp:ListItem>
																</asp:DropDownList>
															</div>
														</td>
														<td>&nbsp;</td>
														<td>
															<asp:RadioButtonList ID="rblAudioGalleryMediaSortType" runat="server" RepeatDirection="Horizontal" CssClass="styledRadio small">
																<asp:ListItem resourcekey="liAscending" Selected="True" Value="ASC">Ascending</asp:ListItem>
																<asp:ListItem resourcekey="liDescending" Value="DESC">Descending</asp:ListItem>
															</asp:RadioButtonList>
														</td>
													</tr>
												</table>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblAudioShowDownloadLink" ResourceKey="lblAudioShowDownloadLink" runat="server" HelpText="Show download link:" Text="Show download link:" HelpKey="lblAudioShowDownloadLink.HelpText" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbAudioShowDownloadLink" runat="server" Text="Show download link" />
												</div>
											</td>
										</tr>
										<tr>
											<td class="textTop">
												<dnn:Label ID="lblAudioGalleryShowSocialSharing" runat="server" HelpText="Show social sharing:" Text="Show social sharing:" HelpKey="lblVideoGalleryShowSocialSharing.HelpText" ResourceKey="lblVideoGalleryShowSocialSharing" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbAudioGalleryShowSocialSharing" runat="server" AutoPostBack="True" OnCheckedChanged="cbAudioGalleryShowSocialSharing_CheckedChanged" Text="Show social sharing" />
												</div>
												<asp:Panel ID="pnlAudioGallerySocialSharingOptions" runat="server">
													<table class="clearWidth textLeft nowrap">
														<tr>
															<td>
																<dnn:Label ID="lblVideoGallery2SSOptions1" runat="server" HelpText="Open/Close sharing on button click:" Text="Open on button click:" HelpKey="lblVideoGallerySSOptions.HelpText" ResourceKey="lblVideoGallerySSOptions" />
															</td>
															<td>&nbsp;</td>
															<td>
																<div class="styledCheckbox noLabel">
																	<asp:CheckBox ID="cbAGSSOpenOnButton" runat="server" Text="Open on button click" />
																</div>
															</td>
														</tr>
													</table>
												</asp:Panel>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblAudioGalleryShowSocialSharing4" runat="server" HelpText="Show textbox that contains media link:" Text="Show media link:" HelpKey="lblVideoGalleryShowBackLink.HelpText" ResourceKey="lblVideoGalleryShowBackLink" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbAudioGalleryShowMediaLink" runat="server" Text="Show media link:" />
												</div>
											</td>
										</tr>
									</table>
									<asp:Label ID="lblAudioGalleryStatus" runat="server" EnableViewState="False"></asp:Label>
									<div class="mainActions">
										<asp:LinkButton ID="btnAudioGallerySave" runat="server" OnClick="btnAudioGallerySave_Click" Text="Save settings" ValidationGroup="vgAGS" resourcekey="btnAudioGallerySaveResource1" CssClass="downSave" />
										<asp:LinkButton ID="btnAudioGallerySaveClose" runat="server" OnClick="btnAudioGallerySaveClose_Click" Text="Save &amp; Close" ValidationGroup="vgAGS" resourcekey="btnAudioGallerySaveCloseResource1" CssClass="downSaveClose" />
									</div>
								</div>
							</asp:Panel>
							<asp:Panel ID="pnlStremingGallerySettings" runat="server" Visible="False" CssClass="settingsList negativeMargins40">
								<h3>
									<asp:Label ID="lblStremingGalleryDisplaySettins" resourcekey="lblStremingGalleryDisplaySettins" runat="server" Text="Streaming gallery display settings" CssClass="settingsdetailtitle"></asp:Label>
								</h3>
								<div class="settingsTable">
									<table>
										<tr>
											<td>
												<dnn:Label ID="lblStreamingTemplateSelect" runat="server" HelpKey="lblSSthumbnails2TemplateSelect.HelpText" HelpText="Select the control viewer template:" ResourceKey="lblSSthumbnails2TemplateSelect" Text="Select template:" />
											</td>
											<td>
												<div class="styledSelect">
													<asp:DropDownList ID="ddlSTreamingTemplateSelect" runat="server" OnSelectedIndexChanged="ddlSSThumbnailsTemplateSelect_SelectedIndexChanged"></asp:DropDownList>
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblAudioGalleryThemeSelect0" runat="server" ControlName="ddlTGThemeSelect" HelpKey="lblAudioGalleryThemeSelect.HelpText" HelpText="Select the CSS theme file:" ResourceKey="lblAudioGalleryThemeSelect" Text="Select CSS:" />
											</td>
											<td>
												<div class="styledSelect">
													<asp:DropDownList ID="ddlStreamingThemeSelect" runat="server"></asp:DropDownList>
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblStreamingServerURL" runat="server" HelpText="Streaming RTMP server url:" Text="Streaming RTMP server url:" HelpKey="lblStreamingServerURL.HelpText" ResourceKey="lblStreamingServerURL" />
											</td>
											<td>
												<asp:TextBox ID="tbStreanigVideoRTMPurl" runat="server" CssClass="large"></asp:TextBox>
												<asp:RequiredFieldValidator ID="rfvAudioGalleryItemsPerPage1" runat="server" ControlToValidate="tbStreanigVideoRTMPurl" Display="Dynamic" ErrorMessage="This field is required." resourcekey="rfvAudioGalleryItemsPerPageResource1.ErrorMessage" ValidationGroup="vgstreamingSettings" CssClass="smallInfo warning"></asp:RequiredFieldValidator>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblStreamingServerVideo" runat="server" HelpText="Streaming video:" Text="Streaming video:" HelpKey="lblStreamingServerVideo.HelpText" ResourceKey="lblStreamingServerVideo" />
											</td>
											<td>
												<asp:TextBox ID="tbStreanigVideoURL" runat="server" CssClass="large"></asp:TextBox>
												<asp:RequiredFieldValidator ID="rfvAudioGalleryItemsPerPage2" runat="server" ControlToValidate="tbStreanigVideoURL" Display="Dynamic" ErrorMessage="This field is required." resourcekey="rfvAudioGalleryItemsPerPageResource1.ErrorMessage" ValidationGroup="vgstreamingSettings" CssClass="smallInfo warning"></asp:RequiredFieldValidator>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblVideoStreamingEnterTitle" runat="server" HelpKey="lblVideoStreamingEnterTitle.HelpText" HelpText="Enter title:" Text="Enter title:" ResourceKey="lblVideoStreamingEnterTitle" />
											</td>
											<td>
												<asp:TextBox ID="tbRTMPTitle" runat="server" CssClass="large"></asp:TextBox>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblStreamingEnterDescription" runat="server" HelpText="Enter description:" Text="Enter description:" HelpKey="lblStreamingEnterDescription.HelpText" ResourceKey="lblStreamingEnterDescription" />
											</td>
											<td>
												<asp:TextBox ID="tbRTMPtDescription" runat="server" CssClass="large"></asp:TextBox>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblStreamingShowTitle" ResourceKey="lblAudioGalleryShowMediaTitle" runat="server" HelpText="Show media title:" Text="Show media title:" HelpKey="lblAudioGalleryShowMediaTitle.HelpText" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbStreamingShowMediaTitle" runat="server" resourcekey="cbAudioGalleryShowMediaTitleResource1" Text="Show media title:" />
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblStremingShowDescription" ResourceKey="lblAudioGalleryShowMediaDescription" runat="server" HelpText="Show media description:" Text="Show media description:" HelpKey="lblAudioGalleryShowMediaDescription.HelpText" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbStreamingShowMediaDescrition" runat="server" resourcekey="cbAudioGalleryShowMediaDescritionResource1" Text="Show media description" />
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblStreamigVideoWidth" runat="server" HelpText="Streaming video width:" Text="Streaming video width:" HelpKey="lblStreamigVideoWidth.HelpText" ResourceKey="lblStreamigVideoWidth" />
											</td>
											<td>
												<asp:TextBox ID="tbStreamingWith" runat="server" ValidationGroup="vgstreamingSettings" CssClass="small textCenter">600</asp:TextBox>
												<asp:RequiredFieldValidator ID="rfvAudioGalleryItemsPerPage0" runat="server" ControlToValidate="tbStreamingWith" Display="Dynamic" ErrorMessage="This field is required." ValidationGroup="vgstreamingSettings" resourcekey="rfvAudioGalleryItemsPerPageResource1.ErrorMessage" CssClass="smallInfo warning"></asp:RequiredFieldValidator>
												<asp:CompareValidator ID="cvAudioGalleryItemsPerPage0" runat="server" ControlToValidate="tbStreamingWith" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" Type="Integer" ValidationGroup="vgstreamingSettings" resourcekey="cvAudioGalleryItemsPerPageResource1.ErrorMessage" CssClass="smallInfo warning"></asp:CompareValidator>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblStreamingHeight" runat="server" ControlName="tbAGSNumberOfItems" HelpText="Streaming video height:" Text="Streaming video height:" HelpKey="lblStreamingHeight.HelpText" ResourceKey="lblStreamingHeight" />
											</td>
											<td>
												<asp:TextBox ID="tbStreamingHeight" runat="server" ValidationGroup="vgstreamingSettings" CssClass="small textCenter">400</asp:TextBox>
												<asp:RequiredFieldValidator ID="rfvAudioGalleryColumns0" runat="server" ControlToValidate="tbStreamingHeight" Display="Dynamic" ErrorMessage="This field is required." ValidationGroup="vgstreamingSettings" resourcekey="rfvAudioGalleryColumnsResource1.ErrorMessage" CssClass="smallInfo warning"></asp:RequiredFieldValidator>
												<asp:CompareValidator ID="cvAudioGalleryColumns0" runat="server" ControlToValidate="tbStreamingHeight" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" Type="Integer" ValidationGroup="vgstreamingSettings" resourcekey="cvAudioGalleryColumnsResource1.ErrorMessage" CssClass="smallInfo warning"></asp:CompareValidator>
											</td>
										</tr>
										<tr>
											<td class="textTop">
												<dnn:Label ID="lblStremingShowSocialSharing" runat="server" HelpKey="lblVideoGalleryShowSocialSharing.HelpText" HelpText="Show social sharing:" ResourceKey="lblVideoGalleryShowSocialSharing" Text="Show social sharing:" Visible="False" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbStreamingShowSocialSharing" runat="server" OnCheckedChanged="cbStreamingShowSocialSharing_CheckedChanged" AutoPostBack="True" Visible="False" Text="Show social sharing:" />
												</div>
												<asp:Panel ID="pnlStreamigSocialSharingOptions" runat="server" Visible="False">
													<table class="clearWidth textLeft nowrap">
														<tr>
															<td>
																<dnn:Label ID="lblVideoGallery2SSOptions3" runat="server" HelpKey="lblVideoGallerySSOptions.HelpText" HelpText="Open/Close sharing on button click:" ResourceKey="lblVideoGallerySSOptions" Text="Open on button click:" />
															</td>
															<td>&nbsp;</td>
															<td>
																<div class="styledCheckbox noLabel">
																	<asp:CheckBox ID="cbStreamigSSOpenOnButton" runat="server" Text="Open on button click:" />
																</div>
															</td>
														</tr>
													</table>
												</asp:Panel>
											</td>
										</tr>
									</table>
									<asp:Label ID="lblStreamingVideoStatus" runat="server" EnableViewState="False"></asp:Label>
									<div class="mainActions">
										<asp:LinkButton ID="btnStreamingGallerySave" runat="server" OnClick="btnStreamingGallerySave_Click" resourcekey="btnAudioGallerySaveResource1" Text="Save settings" ValidationGroup="vgstreamingSettings" CssClass="downSave" />
										<asp:LinkButton ID="btnStreamingGallerySaveClose" runat="server" OnClick="btnStreamingGallerySaveClose_Click" resourcekey="btnAudioGallerySaveCloseResource1" Text="Save &amp; Close" ValidationGroup="vgstreamingSettings" CssClass="downSaveClose" />
									</div>
								</div>
							</asp:Panel>
							<asp:Panel ID="pnlAudioGallery2Settings" runat="server" Visible="False" CssClass="settingsList negativeMargins40">
								<h3>
									<asp:Label ID="lblAudioGallery2DisplaySettins" runat="server" Text="Audio gallery 2 display settings" CssClass="settingsdetailtitle" resourcekey="lblAudioGallery2DisplaySettins"></asp:Label>
								</h3>
								<div class="settingsTable">
									<table>
										<tr>
											<td>
												<dnn:Label ID="lblAudioGallery2TemplateSelect" runat="server" HelpText="Select control template:" Text="Select control template:" HelpKey="lblAudioGallery2TemplateSelect.Text" ResourceKey="lblAudioGallery2TemplateSelect" />
											</td>
											<td>
												<div class="styledSelect">
													<asp:DropDownList ID="ddlAudioGallery2TemplateSelect" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlAudioGallery2TemplateSelect_SelectedIndexChanged"></asp:DropDownList>
												</div>
												<div>
													<asp:Label ID="lblAudioGallery2TemplateInfo" runat="server"></asp:Label>
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblAudioGallery2ThemeSelect" runat="server" ControlName="ddlTGThemeSelect" HelpKey="lblAudioGalleryThemeSelect.HelpText" HelpText="Select the CSS theme file:" ResourceKey="lblAudioGalleryThemeSelect" Text="Select CSS:" />
											</td>
											<td>
												<div class="styledSelect">
													<asp:DropDownList ID="ddlAG2ThemeSelect" runat="server"></asp:DropDownList>
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblAudioGallery2ShowTitle" ResourceKey="lblAudioGalleryShowTitle" runat="server" HelpText="Show gallery title:" Text="Show gallery title:" HelpKey="lblAudioGalleryShowTitle.HelpText" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbAudioGallery2ShowTitle" runat="server" resourcekey="cbAudioGalleryShowTitleResource1" Text="Show gallery title" />
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblAudioGallery2ShowDescription" ResourceKey="lblAudioGalleryShowDescription" runat="server" HelpText="Show gallery description:" Text="Show gallery description:" HelpKey="lblAudioGalleryShowDescription.HelpText" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbAudioGallery2ShowDescrition" runat="server" resourcekey="cbAudioGalleryShowDescritionResource1" Text="Show gallery description" />
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblAudioGallery2ShowMediaTitle" ResourceKey="lblAudioGalleryShowMediaTitle" runat="server" HelpText="Show media title:" Text="Show media title:" HelpKey="lblAudioGalleryShowMediaTitle.HelpText" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbAudioGallery2ShowMediaTitle" runat="server" resourcekey="cbAudioGalleryShowMediaTitleResource1" Text="Show media title" />
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblAudioGallery2ShowMediaDescription" ResourceKey="lblAudioGalleryShowMediaDescription" runat="server" HelpText="Show media description:" Text="Show media description:" HelpKey="lblAudioGalleryShowMediaDescription.HelpText" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbAudioGallery2ShowMediaDescrition" runat="server" resourcekey="cbAudioGalleryShowMediaDescritionResource1" Text="Show media description" />
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblAudioGallery2ShowMediaTitleThumnbail" runat="server" HelpText="Show media title in thumbnail:" Text="Show media title in thumbnail:" HelpKey="lblAudioGallery2ShowMediaTitleThumnbail.HelpText" ResourceKey="lblAudioGallery2ShowMediaTitleThumnbail" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbAudioGallery2ShowMediaTitleThumbnail" runat="server" resourcekey="cbAudioGalleryShowMediaTitleResource1" Text="Show media title in thumbnail" />
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblAudioGallery2ShowMediaDescriptionThumbnail" runat="server" HelpText="Show media description in thumbnail:" Text="Show media description in thumbnail:" HelpKey="lblAudioGallery2ShowMediaDescriptionThumbnail.HelpText" ResourceKey="lblAudioGallery2ShowMediaDescriptionThumbnail" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbAudioGallery2ShowMediaDescritionThumbnail" runat="server" resourcekey="cbAudioGalleryShowMediaDescritionResource1" Text="Show media description in thumbnail" />
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblAudioGallery2PlayOnLoad" ResourceKey="lblAudioGalleryPlayOnLoad" runat="server" HelpText="Start playing audio file on page load:" Text="Play on load:" HelpKey="lblAudioGalleryPlayOnLoad.HelpText" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbAudioGallery2PlayOnLoad" runat="server" resourcekey="cbAudioGalleryPlayOnLoadResource1" Text="Play on load" />
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblAudioGallery2ItemsPrePage" ResourceKey="lblAudioGalleryItemsPrePage" runat="server" ControlName="tbAGSNumberOfItems" HelpText="Set the number of items per page:" Text="Number of items per page:" HelpKey="lblAudioGalleryItemsPrePage.HelpText" />
											</td>
											<td>
												<asp:TextBox ID="tbAG2SNumberOfItems" runat="server" ValidationGroup="vgAG2S" CssClass="small textCenter">5</asp:TextBox>
												<asp:RequiredFieldValidator ID="rfvAudioGallery2ItemsPerPage" runat="server" ControlToValidate="tbAG2SNumberOfItems" Display="Dynamic" ErrorMessage="This field is required." ValidationGroup="vgAG2S" resourcekey="rfvAudioGalleryItemsPerPageResource1.ErrorMessage" CssClass="smallInfo warning"></asp:RequiredFieldValidator>
												<asp:CompareValidator ID="cvAudioGallery2ItemsPerPage" runat="server" ControlToValidate="tbAG2SNumberOfItems" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" Type="Integer" ValidationGroup="vgAG2S" resourcekey="cvAudioGalleryItemsPerPageResource1.ErrorMessage" CssClass="smallInfo warning"></asp:CompareValidator>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblAudioGallery2Columns" ResourceKey="lblAudioGalleryColumns" runat="server" ControlName="tbAGSNumberOfItems" HelpText="Set the number of columns:" Text="Number of columns:" HelpKey="lblAudioGalleryColumns.HelpText" />
											</td>
											<td>
												<asp:TextBox ID="tbAG2SNumberOfColumns" runat="server" ValidationGroup="vgAG2S" CssClass="small textCenter">5</asp:TextBox>
												<asp:RequiredFieldValidator ID="rfvAudioGallery2Columns" runat="server" ControlToValidate="tbAG2SNumberOfColumns" Display="Dynamic" ErrorMessage="This field is required." ValidationGroup="vgAG2S" resourcekey="rfvAudioGalleryColumnsResource1.ErrorMessage" CssClass="smallInfo warning"></asp:RequiredFieldValidator>
												<asp:CompareValidator ID="cvAudioGallery2Columns" runat="server" ControlToValidate="tbAG2SNumberOfColumns" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" Type="Integer" ValidationGroup="vgAG2S" resourcekey="cvAudioGalleryColumnsResource1.ErrorMessage" CssClass="smallInfo warning"></asp:CompareValidator>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblAudioGallery2PlayerWidth" ResourceKey="lblAudioGalleryPlayerWidth" runat="server" ControlName="tbAGSPlayerWidth" HelpText="Set the width of audio player in pixels. Minimum value is 300." Text="Player width (px):" HelpKey="lblAudioGalleryPlayerWidth.HelpText" />
											</td>
											<td>
												<asp:TextBox ID="tbAG2SPlayerWidth" runat="server" ValidationGroup="vgAG2S" CssClass="small textCenter">400</asp:TextBox>
												<asp:RequiredFieldValidator ID="rfvAudioGallery2PlayerWidth" runat="server" ControlToValidate="tbAG2SPlayerWidth" Display="Dynamic" ErrorMessage="This field is required." ValidationGroup="vgAG2S" resourcekey="rfvAudioGalleryPlayerWidthResource1.ErrorMessage" CssClass="smallInfo warning"></asp:RequiredFieldValidator>
												<asp:RangeValidator ID="rvAudioGallery2PlayerWidth" runat="server" ControlToValidate="tbAG2SPlayerWidth" Display="Dynamic" ErrorMessage="Minimum player width is 90px." MaximumValue="10000" MinimumValue="90" Type="Integer" ValidationGroup="vgAG2S" resourcekey="rvAudioGalleryPlayerWidthResource1.ErrorMessage" CssClass="smallInfo warning"></asp:RangeValidator>
												<asp:CompareValidator ID="cvAudioGallery2PlayerWidth" runat="server" ControlToValidate="tbAG2SPlayerWidth" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" Type="Integer" ValidationGroup="vgAG2S" resourcekey="cvAudioGalleryPlayerWidthResource1.ErrorMessage" CssClass="smallInfo warning"></asp:CompareValidator>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblAudioGallery2Volume" ResourceKey="lblAudioGalleryVolume" runat="server" ControlName="tbAudioGalleryPlayerVolume" HelpText="Audio volume:" Text="Audio volume:" HelpKey="lblAudioGalleryVolume.HelpText" />
											</td>
											<td>
												<asp:TextBox ID="tbAudioGallery2PlayerVolume" runat="server" ValidationGroup="vgAG2S" CssClass="small textCenter">100</asp:TextBox>
												<asp:RequiredFieldValidator ID="rfvAudioGallery2PlayerVolume" runat="server" ControlToValidate="tbAudioGallery2PlayerVolume" Display="Dynamic" ErrorMessage="This field is required." ValidationGroup="vgAG2S" resourcekey="rfvAudioGalleryPlayerVolumeResource1.ErrorMessage" CssClass="smallInfo warning"></asp:RequiredFieldValidator>
												<asp:RangeValidator ID="rvAudioGallery2Volume" runat="server" ControlToValidate="tbAudioGallery2PlayerVolume" Display="Dynamic" ErrorMessage="Enter value between 0-100." MaximumValue="100" MinimumValue="0" Type="Integer" ValidationGroup="vgAG2S" resourcekey="rvAudioGalleryVolumeResource1.ErrorMessage" CssClass="smallInfo warning"></asp:RangeValidator>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblAudioGallery2ThumbWidth" runat="server" HelpText="Thumb width:" Text="Thumb width:" HelpKey="lblAudioGallery2ThumbWidth.HelpText" ResourceKey="lblAudioGallery2ThumbWidth" />
											</td>
											<td>
												<asp:TextBox ID="tbAG2SThumbWidth" runat="server" ValidationGroup="vgAGS" CssClass="small textCenter">100</asp:TextBox>
												<asp:RequiredFieldValidator ID="rfvAudioGallery2ThumbsWidth" runat="server" ControlToValidate="tbAG2SThumbWidth" Display="Dynamic" ErrorMessage="This field is required." resourcekey="rfvAudioGalleryItemsPerPageResource1.ErrorMessage" ValidationGroup="vgAG2S" CssClass="smallInfo warning"></asp:RequiredFieldValidator>
												<asp:CompareValidator ID="cvAudioGallery2ThumbsWidth" runat="server" ControlToValidate="tbAG2SThumbWidth" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" resourcekey="cvAudioGalleryItemsPerPageResource1.ErrorMessage" Type="Integer" ValidationGroup="vgAG2S" CssClass="smallInfo warning"></asp:CompareValidator>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblAudioGallery2ThumbHeight" runat="server" HelpText="Thumb height:" Text="Thumb height:" HelpKey="lblAudioGallery2ThumbHeight.HelpText" ResourceKey="lblAudioGallery2ThumbHeight" />
											</td>
											<td>
												<asp:TextBox ID="tbAG2SThumbHeight" runat="server" ValidationGroup="vgAG2S" CssClass="small textCenter">100</asp:TextBox>
												<asp:RequiredFieldValidator ID="rfvAudioGallery2ThumbsHeight" runat="server" ControlToValidate="tbAG2SThumbHeight" Display="Dynamic" ErrorMessage="This field is required." resourcekey="rfvAudioGalleryItemsPerPageResource1.ErrorMessage" ValidationGroup="vgAG2S" CssClass="smallInfo warning"></asp:RequiredFieldValidator>
												<asp:CompareValidator ID="cvAudioGallery2ThumbsHeight" runat="server" ControlToValidate="tbAG2SThumbHeight" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" resourcekey="cvAudioGalleryItemsPerPageResource1.ErrorMessage" Type="Integer" ValidationGroup="vgAG2S" CssClass="smallInfo warning"></asp:CompareValidator>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblAudioGallery2RandomizeMedia" runat="server" HelpKey="lblLightBoxRandomizeMedia.HelpText" HelpText="Randomize media positions on every page load:" ResourceKey="lblLightBoxRandomizeMedia" Text="Randomize media positions:" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbAudioGallery2RandomizeMedia" runat="server" OnCheckedChanged="cbAudioGallery2RandomizeMedia_CheckedChanged" resourcekey="cbLightBoxGallerySmartCropVerticalResource1" AutoPostBack="True" Text="Randomize media positions" />
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="Label14" runat="server" HelpText="Select media sorting options:" Text="Media sorting:" HelpKey="lblLightBoxMediaSorting.HelpText" ResourceKey="lblLightBoxMediaSorting" />
											</td>
											<td>
												<table class="clearWidth textLeft">
													<tr>
														<td>
															<div class="styledSelect">
																<asp:DropDownList ID="ddlAudioGallery2MediaSort" runat="server">
																	<asp:ListItem resourcekey="liPosition" Value="Position">Position</asp:ListItem>
																	<asp:ListItem resourcekey="liDateUploaded" Value="DateUploaded">Date uploaded</asp:ListItem>
																	<asp:ListItem resourcekey="liFileName" Value="FileName">Filename</asp:ListItem>
																	<asp:ListItem resourcekey="liTitle">Title</asp:ListItem>
																</asp:DropDownList>
															</div>
														</td>
														<td>&nbsp;</td>
														<td>
															<asp:RadioButtonList ID="rblAudioGallery2MediaSortType" runat="server" RepeatDirection="Horizontal" CssClass="styledRadio small">
																<asp:ListItem resourcekey="liAscending" Selected="True" Value="ASC">Ascending</asp:ListItem>
																<asp:ListItem resourcekey="liDescending" Value="DESC">Descending</asp:ListItem>
															</asp:RadioButtonList>
														</td>
													</tr>
												</table>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblAudio2ShowDownloadLink" runat="server" HelpText="Show download link:" Text="Show download link:" HelpKey="lblAudio2ShowDownloadLink.HelpText" ResourceKey="lblAudio2ShowDownloadLink" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbAudio2ShowDownloadLink" runat="server" Text="Show download link" />
												</div>
											</td>
										</tr>
										<tr>
											<td class="textTop">
												<dnn:Label ID="lblAudioGalleryShowSocialSharing5" runat="server" HelpText="Show social sharing:" Text="Show social sharing:" HelpKey="lblVideoGalleryShowSocialSharing.HelpText" ResourceKey="lblVideoGalleryShowSocialSharing" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbAudioGallery2ShowSocialSharing" runat="server" AutoPostBack="True" OnCheckedChanged="cbAudioGallery2ShowSocialSharing_CheckedChanged" Text="Show social sharing" />
												</div>
												<asp:Panel ID="pnlAudioGallery2SocialSharingOptions" runat="server">
													<table class="clearWidth textLeft nowrap">
														<tr>
															<td>
																<dnn:Label ID="lblVideoGallery2SSOptions2" runat="server" HelpText="Open/Close sharing on button click:" Text="Open on button click:" HelpKey="lblVideoGallerySSOptions.HelpText" ResourceKey="lblVideoGallerySSOptions" />
															</td>
															<td>&nbsp;</td>
															<td>
																<div class="styledCheckbox noLabel">
																	<asp:CheckBox ID="cbAG2SSOpenOnButton" runat="server" Text="Open on button click" />
																</div>
															</td>
														</tr>
													</table>
												</asp:Panel>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblAudioGalleryShowSocialSharing6" runat="server" HelpText="Show textbox that contains media link:" Text="Show media link:" HelpKey="lblVideoGalleryShowBackLink.HelpText" ResourceKey="lblVideoGalleryShowBackLink" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbAudioGallery2ShowMediaLink" runat="server" Text="Show media link" />
												</div>
											</td>
										</tr>
									</table>
									<asp:Label ID="lblAudioGallery2Status" runat="server" Enabled="True" EnableViewState="False"></asp:Label>
									<div class="mainActions">
										<asp:LinkButton ID="btnAudioGallery2Save" runat="server" OnClick="btnAudioGallery2Save_Click" Text="Save settings" ValidationGroup="vgAG2S" resourcekey="btnAudioGallerySaveResource1" CssClass="downSave" />
										<asp:LinkButton ID="btnAudioGallery2SaveClose" runat="server" OnClick="btnAudioGallery2SaveClose_Click" Text="Save &amp; Close" ValidationGroup="vgAG2S" resourcekey="btnAudioGallerySaveCloseResource1" CssClass="downSaveClose" />
									</div>
								</div>
							</asp:Panel>
							<asp:Panel ID="pnlSocialMediaBoxForJournal" runat="server" Visible="False" CssClass="settingsList negativeMargins40">
								<h3>
									<asp:Label ID="lblSmbJournalDisplaySettins" runat="server" Text="SocialMediaBox For DNN Journal" CssClass="settingsdetailtitle"></asp:Label>
								</h3>
								<div class="settingsTable">
									<table>
										<tr>
											<td>
												<asp:Label ID="lblSmbJOurnalInstructions" runat="server" Text="Use this view type on the page where DNN Journal module is present."></asp:Label>
											</td>
										</tr>
										<tr>
											<td>
												<asp:Label ID="lblSmbJournalStatus" runat="server"></asp:Label>
											</td>
										</tr>
									</table>
									<div class="mainActions">
										<asp:LinkButton ID="btnSmbJournalGallerySave" runat="server" Text="Save settings" ValidationGroup="vgSmbJournalSettings" OnClick="btnSmbJournalGallerySave_Click" CssClass="downSave" />
										<asp:LinkButton ID="btnSmbJournalGallerySaveClose" runat="server" Text="Save &amp; Close" ValidationGroup="vgSmbJournalSettings" OnClick="btnSmbJournalGallerySaveClose_Click" CssClass="downSaveClose" />
									</div>
								</div>
							</asp:Panel>
							<asp:Panel ID="pnlFlashGalSettings" runat="server" Visible="False" CssClass="settingsList negativeMargins40">
								<table cellpadding="0" cellspacing="0" align="center">
									<tr>
										<td>
											<div class="settingsdetailleft">
											</div>
										</td>
										<td style="background-color: #0ba2ce">
											<asp:Label ID="lblFlashTabGallerySettings" runat="server" CssClass="settingsdetailtitle" Text="Flash Tab Gallery display settings" resourcekey="lblFlashTabGallerySettingsResource1"></asp:Label>
										</td>
										<td>
											<div class="settingsdetailright">
											</div>
										</td>
									</tr>
								</table>
								<div class="settingsdetailbgrd">
								</div>
								<div class="settingsdetailtable">
									<table cellpadding="2" cellspacing="2" align="center" width="80%">
										<tr>
											<td>&nbsp;
											</td>
											<td colspan="2">&nbsp;
											</td>
										</tr>
										<tr>
											<td>&nbsp;
											</td>
											<td colspan="2">
												<asp:DropDownList ID="ddlCategorySelect" runat="server" AutoPostBack="True" DataSourceID="odsGetCategories" DataTextField="CategoryName" DataValueField="CategoryID" Visible="False">
												</asp:DropDownList>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblFlashTabSelectCategory" ResourceKey="lblFlashTabSelectCategory" runat="server" Text="Display category:" ControlName="ddlCategorySelect" HelpText="Select to display category or to display just one gallery:" HelpKey="lblFlashTabSelectCategory.HelpText"></dnn:Label>
											</td>
											<td colspan="2">
												<asp:CheckBox ID="cbFlashTabSelectCategory" runat="server" resourcekey="cbFlashTabSelectCategoryResource1" />
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblFlashTabGalleryWidth" ResourceKey="lblFlashTabGalleryWidth" runat="server" Text="Gallery width:" ControlName="tbPanelImageWidth" HelpText="Set the width of flash gallery. Recommended width is 800 px:" HelpKey="lblFlashTabGalleryWidth.HelpText"></dnn:Label>
											</td>
											<td colspan="2">
												<asp:TextBox ID="tbPanelImageWidth" runat="server" ValidationGroup="vgFlashGallery" Width="50px">
												</asp:TextBox>
												&nbsp;
											<asp:RequiredFieldValidator ID="rfvFlashTabGalleryWidth" runat="server" ControlToValidate="tbPanelImageWidth" ErrorMessage="This filed is required." ValidationGroup="vgFlashGallery" Display="Dynamic" resourcekey="rfvFlashTabGalleryWidthResource1.ErrorMessage">
											</asp:RequiredFieldValidator>
												<asp:CompareValidator ID="cvFlashTabGalleryWidth" runat="server" ControlToValidate="tbPanelImageWidth" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" Type="Integer" ValidationGroup="vgSlider" resourcekey="cvFlashTabGalleryWidthResource1.ErrorMessage">
												</asp:CompareValidator>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblFlashTabGalleryHeight" ResourceKey="lblFlashTabGalleryHeight" runat="server" Text="Gallery height:" ControlName="tbPanelImageHeight" HelpText="Set the height of flash gallery:" HelpKey="lblFlashTabGalleryHeight.HelpText"></dnn:Label>
											</td>
											<td colspan="2">
												<asp:TextBox ID="tbPanelImageHeight" runat="server" Width="50px" ValidationGroup="vgFlashGallery">
												</asp:TextBox>
												&nbsp;<asp:RequiredFieldValidator ID="rfvFlashTabGalleryHeight" runat="server" ControlToValidate="tbPanelImageHeight" Display="Dynamic" ErrorMessage="This filed is required." ValidationGroup="vgFlashGallery" resourcekey="rfvFlashTabGalleryHeightResource1.ErrorMessage"></asp:RequiredFieldValidator>
												<asp:CompareValidator ID="cvFlashTabGalleryHeight" runat="server" ControlToValidate="tbPanelImageHeight" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" Type="Integer" ValidationGroup="vgSlider" resourcekey="cvFlashTabGalleryHeightResource1.ErrorMessage">
												</asp:CompareValidator>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblFlashTabGalleryTheme" ResourceKey="lblFlashTabGalleryTheme" runat="server" HelpText="Select Flash Tab Gallery theme:" Text="Select theme:" HelpKey="lblFlashTabGalleryTheme.HelpText" />
											</td>
											<td colspan="2">
												<asp:DropDownList ID="ddlFlashGalTheme" runat="server">
													<asp:ListItem Value="gallery_black.swf" resourcekey="ListItemResource36">Black</asp:ListItem>
													<asp:ListItem Value="gallery_white.swf" resourcekey="ListItemResource37">White</asp:ListItem>
												</asp:DropDownList>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblFlashTabLinkText" ResourceKey="lblFlashTabLinkText" runat="server" Text="Flash link text:" ControlName="tbFlashLinkText" HelpText="Set the text for link to open flash gallery:" HelpKey="lblFlashTabLinkText.HelpText"></dnn:Label>
											</td>
											<td colspan="2">
												<asp:TextBox ID="tbFlashLinkText" runat="server" Width="400px">
												</asp:TextBox>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblFlashTabEmbedFlash" ResourceKey="lblFlashTabEmbedFlash" runat="server" Text="Embed flash:" ControlName="cbFlashEmbedInPage" HelpText="Set this if you want the flash gallery to be embeded in page:" HelpKey="lblFlashTabEmbedFlash.HelpText"></dnn:Label>
											</td>
											<td colspan="2">
												<asp:CheckBox ID="cbFlashTabEmbedInPage" runat="server" Checked="True" resourcekey="cbFlashTabEmbedInPageResource1" />
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblFlashTabGeteranteLink" ResourceKey="lblFlashTabGeteranteLink" runat="server" ControlName="cbFlashGenerateLinkCode" HelpText="Set this if you want link generated to be embeded in html:" Text="Generate link code:" HelpKey="lblFlashTabGeteranteLink.HelpText" />
											</td>
											<td colspan="2">
												<asp:CheckBox ID="cbFlashTabGenerateLinkCode" runat="server" resourcekey="cbFlashTabGenerateLinkCodeResource1" />
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblFlashTabDontShow" ResourceKey="lblFlashTabDontShow" runat="server" ControlName="cbFlashDontShowGallery" HelpText="This will not show main gallery. Use this if you have link embeded in html:" Text="Do not show main gallery: " HelpKey="lblFlashTabDontShow.HelpText" />
											</td>
											<td colspan="2">
												<asp:CheckBox ID="cbFlashTabDontShowGallery" runat="server" resourcekey="cbFlashTabDontShowGalleryResource1" />
											</td>
										</tr>
										<tr>
											<td class="style24"></td>
											<td class="style25" colspan="2"></td>
										</tr>
										<tr>
											<td>&nbsp;
											</td>
											<td colspan="2">
												<asp:TextBox ID="tbFlashGenereteLink" runat="server" Height="150px" TextMode="MultiLine" Width="400px">
												</asp:TextBox>
											</td>
										</tr>
										<tr>
											<td>&nbsp;
											</td>
											<td colspan="2">&nbsp;
											</td>
										</tr>
										<tr>
											<td>&nbsp;
											</td>
											<td class="style54">
												<asp:Button ID="btnFlashTabSaveSettings" runat="server" OnClick="btnFlashSettings_Click" Text="Save settings" ValidationGroup="vgFlashGallery" Width="140px" resourcekey="btnFlashTabSaveSettingsResource1" />
												&nbsp;&nbsp;&nbsp;&nbsp;
											<asp:Button ID="btnFlashTabSaveClose" runat="server" OnClick="btnFGSaveClose_Click" Text="Save &amp; Close" Width="140px" ValidationGroup="vgFlashGallery" resourcekey="btnFlashTabSaveCloseResource1" />
											</td>
											<td>
												<asp:Label ID="lblFlashTabStatus" runat="server" Width="120px" resourcekey="lblFlashTabStatusResource1"></asp:Label>
											</td>
										</tr>
										<tr>
											<td>&nbsp;
											</td>
											<td colspan="2">&nbsp;
											</td>
										</tr>
									</table>
								</div>
							</asp:Panel>
							<asp:Panel ID="pnlLoadSaveSettings" runat="server" CssClass="contentSection exportSettings negativeMargins40">
								<div class="specialOptions">
									<h2>
										<asp:Label ID="lblSaveLoadSettingsToFile" runat="server" Text="Save or load settings to another file or module" resourcekey="cbSaveLoadSettingsToFileResource1"></asp:Label>
									</h2>
									<div class="optionsList paddingTopBottom">
										<div class="styledCheckbox big noLabel">
											<asp:CheckBox ID="cbSaveLoadSettingsToFile" runat="server" AutoPostBack="True" Font-Bold="True" OnCheckedChanged="cbSettingsToFile_CheckedChanged" Text="Save or load settings to another file or module" resourcekey="cbSaveLoadSettingsToFileResource1" />
										</div>
									</div>
								</div>
								<asp:Panel ID="pnlSaveLoadSettings" runat="server" Visible="False" CssClass="saveLoadSettings">
									<table>
										<tr>
											<td>
												<dnn:Label ID="lblSaveSettingstoFile" ResourceKey="lblSaveSettingstoFile" runat="server" HelpText="Enter filename to save settings to:" Text="Filename:" HelpKey="lblSaveSettingstoFile.HelpText" />
											</td>
											<td>
												<asp:Label ID="lblExportSettingsMessage" runat="server" EnableViewState="False"></asp:Label>
												<asp:TextBox ID="tbSettingsFile" runat="server" Enabled="False" CssClass="large"></asp:TextBox>
												<div class="itemActions itemEditActions">
													<asp:LinkButton ID="btnSaveSettingsToFile" runat="server" Enabled="False" OnClick="btnSaveSettingsToFile_Click" resourcekey="btnSaveSettingsToFileResource1" Text="Save settings" CssClass="itemEditAdd" />
												</div>
												<asp:Label ID="lblSettingsFilenameError" runat="server" ForeColor="Red" Text="Please enter filename." Visible="False" resourcekey="lblSettingsFilenameErrorResource1"></asp:Label>
											</td>
										</tr>
										<tr>
											<td>
												<dnn:Label ID="lblLoadSettingsFromFile" ResourceKey="lblLoadSettingsFromFile" runat="server" HelpText="Select module number or settings file to load settings from:" Text="Select settings:" HelpKey="lblLoadSettingsFromFile.HelpText" />
											</td>
											<td>
												<div class="styledSelect large">
													<asp:DropDownList ID="ddlSettingsList" runat="server"></asp:DropDownList>
												</div>
												<div class="itemActions itemEditActions">
													<asp:LinkButton ID="btnLoadSettingsFromFile" runat="server" OnClick="btnLoadSettings_Click" Text="Load settings" ValidationGroup="vvNema" resourcekey="btnLoadSettingsFromFileResource1" CssClass="itemEditMove" />
												</div>
											</td>
										</tr>
									</table>
								</asp:Panel>
							</asp:Panel>
						</asp:Panel>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<asp:Panel ID="pnlMainInfo" runat="server" Visible="False" />
<asp:Panel ID="pnlInvisible" runat="server" Visible="False">
	<table>
		<tr>
			<td>&nbsp;
			</td>
		</tr>
		<tr>
			<td>&nbsp;
			</td>
		</tr>
		<tr>
			<td>
				<asp:TextBox ID="tbASSNGColumns" runat="server" ValidationGroup="vgTGSettings" Width="35px">2</asp:TextBox>
				<asp:Label ID="lblLightboxGalleryNestedNumberOfColumns1" runat="server" resourcekey="lblLightboxGalleryNestedNumberOfColumnsResource1" Text="Number of columns."></asp:Label>
				<asp:RequiredFieldValidator ID="rfvLightboxGalleryNestedNumberOfColumns3" runat="server" ControlToValidate="tbASSNGColumns" Display="Dynamic" ErrorMessage="This field is required." resourcekey="rfvLightboxGalleryNestedNumberOfColumnsResource1.ErrorMessage"
					SetFocusOnError="True" ValidationGroup="vgTGSettings">
				</asp:RequiredFieldValidator>
				<asp:CompareValidator ID="cvLightboxGalleryNestedNumberOfColumns3" runat="server" ControlToValidate="tbASSNGColumns" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" resourcekey="cvLightboxGalleryNestedNumberOfColumnsResource1.ErrorMessage"
					SetFocusOnError="True" Type="Integer" ValidationGroup="vgTGSettings">
				</asp:CompareValidator>
			</td>
		</tr>
		<tr>
			<td>
				<asp:TextBox ID="tbASSNGItems" runat="server" ValidationGroup="vgTGSettings" Width="35px">4</asp:TextBox>
				<asp:Label ID="lblLightboxGalleryNestedNumberOfItems1" runat="server" resourcekey="lblLightboxGalleryNestedNumberOfItems" Text="Number of items."></asp:Label>
				<asp:RequiredFieldValidator ID="rfvLightboxGalleryNestedNumberOfColumns4" runat="server" ControlToValidate="tbASSNGItems" Display="Dynamic" ErrorMessage="This field is required." resourcekey="rfvLightboxGalleryNestedNumberOfColumnsResource1.ErrorMessage"
					SetFocusOnError="True" ValidationGroup="vgTGSettings">
				</asp:RequiredFieldValidator>
				<asp:CompareValidator ID="cvLightboxGalleryNestedNumberOfColumns4" runat="server" ControlToValidate="tbASSNGItems" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" resourcekey="cvLightboxGalleryNestedNumberOfColumnsResource1.ErrorMessage"
					SetFocusOnError="True" Type="Integer" ValidationGroup="vgTGSettings">
				</asp:CompareValidator>
			</td>
		</tr>
	</table>
</asp:Panel>
<asp:HiddenField ID="hfSelectedGravity" runat="server" Value="gravityGallery" />
<asp:ObjectDataSource ID="odsGetCategories" runat="server" TypeName="EasyDNN.Modules.EasyDNNGallery.DataAcess" SelectMethod="GetCategories" OldValuesParameterFormatString="{0}">
	<SelectParameters>
		<asp:Parameter Name="PortalID" Type="Int32" />
	</SelectParameters>
</asp:ObjectDataSource>
