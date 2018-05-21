<%@ control language="C#" autoeventwireup="true" inherits="EasyDNN.Modules.EasyDNNGallery.DesktopModules_EasyDNNGallery_Controls_LightboxUserGalleries, App_Web_lightboxusergalleries.ascx.c5ff317f" %>
<style type="text/css">
	#<%=ModuleNBR%>EasyDNNGallery .user_dashboard
	{
		background: url("/DesktopModules/EasyDnnGallery/images/silver_gradient_bg_dash.png") repeat-x scroll 0 0 #EBEBEB;
		border: 1px solid #EBEBEB;
		box-shadow: 1px 1px 1px 0;
		display: inline-block;
		margin: 0 0 20px;
		overflow: hidden;
		padding: 4px 6px;
	}
	#<%=ModuleNBR%>EasyDNNGallery .user_dashboard:hover
	{
		background: none repeat scroll 0 0 #EBEBEB;
	}
	#<%=ModuleNBR%>EasyDNNGallery .user_dashboard a
	{
		display: block;
		float: left;
		color: #363636;
		font: 11px Arial, Helvetica, sans-serif;
		font-weight: bold;
		padding: 5px 0 0 35px;
		height: 18px;
		margin: 0 10px 0 0;
	}
	#<%=ModuleNBR%>EasyDNNGallery .user_dashboard a.my_gallery
	{
		background: url(<%=ModulePath.Replace("Controls/Lightbox/","")%>images/gallery_edit.png) no-repeat;
		padding-left: 25px;
	}
	#<%=ModuleNBR%>EasyDNNGallery table.EDGlightbox.EDGresponsive
	{
		width: 100%;
		max-width: <%=maxWidth%>px;
	}
	#<%=ModuleNBR%>EasyDNNGallery table.EDGlightboxNested.EDGresponsive
	{
		width: 100%;
		max-width: <%=nestedMaxWdth%>px;
	}
	#<%=ModuleNBR%>EasyDNNGallery .EDGlightbox.EDGresponsive td
	{
		display: inline-block;
		width: <%=percentWidth%>%;
	}
	
	#<%=ModuleNBR%>EasyDNNGallery .EDGlightboxNested.EDGresponsive td
	{
		display: inline-block;
		width: <%=NGThumbWidthPercent%>%;
	}
	#<%=ModuleNBR%>EasyDNNGallery .EDGresponsive a, #<%=ModuleNBR%>EasyDNNGallery .EDGresponsive .titleempty
	{
		width: 100%;
	}
	#<%=ModuleNBR%>EasyDNNGallery .EDGresponsive .EDGmain .EDGimage a .title, #<%=ModuleNBR%>EasyDNNGallery .EDGresponsive .EDGmain .EDGimage a .title span
	{
		width: 100%;
		max-width: 100%;
		padding: 2px 0;
	}
	#<%=ModuleNBR%>EasyDNNGallery .EDGresponsive .EDGmain .EDGimage a .Description
	{
		max-width: 100%;
	}
	#<%=ModuleNBR%>EasyDNNGallery .EDGresponsive .EDGmain
	{
		max-width: <%=myappSettings.TGImageWidth%>px;
	}
	#<%=ModuleNBR%>EasyDNNGallery .EDGlightboxNested.EDGresponsive .EDGmain
	{
		max-width: <%=myappSettings.NGThumbWidth%>px;
	}
	#<%=ModuleNBR%>EasyDNNGallery .EDGresponsive .EDGimage, #<%=ModuleNBR%>EasyDNNGallery .EDGresponsive .EDGvideo, #<%=ModuleNBR%>EasyDNNGallery .EDGresponsive .EDGaudio
	{
		max-width: 100%;
	}
	#<%=ModuleNBR%>EasyDNNGallery .EDGresponsive img
	{
		max-width: <%=myappSettings.TGImageWidth%>px;
		width: 100%;
	}
	#<%=ModuleNBR%>EasyDNNGallery .EDGresponsive input
	{
		width: 100%;
		max-width: <%=myappSettings.NGThumbWidth%>px;
	}
	#<%=ModuleNBR%>EasyDNNGallery .EDGresponsive .EDGimage a img, #<%=ModuleNBR%>EasyDNNGallery .EDGresponsive .EDGimage a, #<%=ModuleNBR%>EasyDNNGallery .EDGresponsive .EDGimage a input, #<%=ModuleNBR%>EasyDNNGallery .EDGresponsive .EDGmain
	{
		float: none;
	}
	#<%=ModuleNBR%>EasyDNNGallery .EDGresponsive .EDGvideo a img, #<%=ModuleNBR%>EasyDNNGallery .EDGresponsive .EDGvideo a, #<%=ModuleNBR%>EasyDNNGallery .EDGresponsive .EDGmain
	{
		float: none;
	}
	#<%=ModuleNBR%>EasyDNNGallery .EDGresponsive .EDGaudio a img, #<%=ModuleNBR%>EasyDNNGallery .EDGresponsive .EDGaudio a, #<%=ModuleNBR%>EasyDNNGallery .EDGresponsive .EDGmain
	{
		float: none;
	}
	#<%=ModuleNBR%>EasyDNNGallery .EDGresponsive .EDGimage a:hover img, #<%=ModuleNBR%>EasyDNNGallery .EDGresponsive .EDGvideo a:hover img, #<%=ModuleNBR%>EasyDNNGallery .EDGresponsive .EDGaudio a:hover img, #<%=ModuleNBR%>EasyDNNGallery .EDGresponsive .EDGimage a:hover input
	{
		float: none;
	}
	.eds_edn_qtip2_style
	{
		-moz-border-radius: <%=myappSettings.TooltipRadius%>px;
		-webkit-border-radius: <%=myappSettings.TooltipRadius%>px;
		border-radius: <%=myappSettings.TooltipRadius%>px;
		border-width: <%=myappSettings.TooltipBorder%>px;
	}
</style>
<div id="edsUserDisplayMain" runat="server">
	<script type="text/javascript">

function sGoogle()
{
	var po = document.createElement('script'); po.type = 'text/javascript'; po.async = true;
	po.src = 'https://apis.google.com/js/plusone.js';
	var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(po, s);
	
	var potw = document.createElement('script'); potw.type = 'text/javascript';
	potw.src = 'https://platform.twitter.com/widgets.js';
	var stw = document.getElementsByTagName('script')[0]; stw.parentNode.insertBefore(potw, stw);
}

<%=jQuery%>(document).ready(function ($) {
 if('<%=myappSettings.ShowToolTips.ToLower()%>'=='true') {
	if('<%=myappSettings.LightboxDescription.ToLower() %>'=='true') {
		$('#<%=ModulNr%>EasyDNNGallery .EDGimage a[title], #<%=ModulNr%>EasyDNNGallery .EDGvideo a[title], #<%=ModulNr%>EasyDNNGallery .EDGaudio a[title]').each(function() {
			if($(this).attr("title").length>0){
				$(this).qtip({
					show: {  effect: function(offset) { <%=myappSettings.ShowEffect%> } },
					hide: {  effect: function(offset) { <%=myappSettings.HideEffect%> } },
					position: { at: '<%=myappSettings.TargetPosition%>', my: '<%=myappSettings.TooltipPosition%>'},
					style: { classes: 'qtip-<%=myappSettings.TooltipTheme%> eds_edn_qtip2_style', tip: {corner: true, width: 10, height: 5}} 
					});
				}
			});
		}
	}
});
	</script>
	<asp:Literal ID="ltOpenImage" runat="server" EnableViewState="False"></asp:Literal>
	<div id="LightBoxGallery">
		<asp:Panel ID="pnlUserDashBoard" runat="server" Visible="False" CssClass="user_dashboard">
			<asp:LinkButton ID="lbMyGalleries" runat="server" CssClass="my_gallery" OnClick="lbMyGalleries_Click">
				<%=UserGalleries%>
			</asp:LinkButton>
		</asp:Panel>
		<asp:HiddenField ID="hfISnestedOpen" runat="server" Value="None" />
		<div id="<%=cssClass%>">
			<div class="EDGbackground">
				<div class="EDGcontentbgrd">
					<div class="EDGcornerbotleft">
						<div class="EDGcornerbotright">
							<div class="EDGcornertopleft">
								<div class="EDGcornertopright">
									<div class="EDGcontent">
										<asp:Literal ID="ltedsLightBoxData" runat="server" EnableViewState="False"></asp:Literal>
										<asp:Panel ID="pnlBreadCrumb" runat="server" Visible="False" CssClass="nestedBreadCrumb">
											<asp:LinkButton ID="lbBCTOPGallery" runat="server" OnClick="lbBCTOPGallery_Click">
											</asp:LinkButton>
											>
											<asp:HyperLink ID="lblBCGallery" runat="server">
											</asp:HyperLink>
										</asp:Panel>
										<asp:Panel ID="pnlNestedGalleries" runat="server" HorizontalAlign="Center">
											<asp:DataList ID="dlNestedCategory" runat="server" role="presentation"  DataKeyField="GalleryID" OnItemCommand="dlNestedCategory_ItemCommand" CellPadding="0" RepeatDirection="Horizontal" RepeatColumns="4" Font-Bold="False" Font-Italic="False" Font-Overline="False" RepeatLayout="Table"
												HorizontalAlign="Center" EnableViewState="False" ItemStyle-VerticalAlign="Top" ItemStyle-HorizontalAlign="Center" ItemStyle-Wrap="False" CssClass="<%#layoutNestedClass%>">
												<AlternatingItemStyle HorizontalAlign="Center" />
												<EditItemStyle HorizontalAlign="Center" />
												<ItemTemplate>
													<div class="EDGmain">
														<div class="EDGimage">
															<asp:HiddenField ID="hfGallID" runat="server" Value='<%#Eval("GalleryID")%>' />
															<a href="" runat="server">
																<asp:ImageButton ID="ibNestedGallery" runat="server" CommandName="OpenNestedGallery" CommandArgument='<%#Eval("GalleryID")%>' ImageUrl='<%#GetGalleryThumbPath(DataBinder.Eval(Container.DataItem, "GalleryID")) %>' AlternateText='<%#EasyDNN.Modules.EasyDNNGallery.Common.MediaMethods.GetAlt(Eval("GalleryName").ToString(),"gallery")%>' />
																<span class="flagObject"></span><span class="flag"></span><span class="leftsh"></span><span class="rightsh"></span><span class="botsh"></span><span class="topsh"></span><span class="round1"></span><span class="round2"></span><span class="round3"></span>
																<span class="round4"></span><span class='<%#NGTitleClass(DataBinder.Eval(Container.DataItem, "GalleryName"),DataBinder.Eval(Container.DataItem, "GalleryDescription"))%>'>
																	<asp:Label ID="lblTGNGTitle" runat="server" Text='<%#Server.HtmlDecode(ShowNestedGalleryTitle(DataBinder.Eval(Container.DataItem, "GalleryName"),DataBinder.Eval(Container.DataItem, "GalleryID")))%>' Visible='<%#NGTitleToDisplay(Eval("GalleryName"))%>'></asp:Label>
																	<asp:Label ID="lblTGNGDescription" runat="server" CssClass="Description" Text='<%#Server.HtmlDecode(ShowNestedGalleryDescription(DataBinder.Eval(Container.DataItem, "GalleryDescription"),DataBinder.Eval(Container.DataItem, "GalleryID")))%>' Visible='<%#NGDescriptionToDisplay(Eval("GalleryDescription"))%>'></asp:Label>
																	<asp:Label ID="lblTGNGalleryOwner" runat="server" CssClass="Description" Text='<%#Server.HtmlDecode(ShowNestedGalleryOwner(DataBinder.Eval(Container.DataItem, "UserID")))%>' Visible='<%#Convert.ToBoolean(myappSettings.ShowGalleryOwner)%>'></asp:Label>
																	<asp:Label ID="lbGalleryLink" runat="server" CssClass="Description" Text='<%#GetMediaInfo(Eval("GalleryID"))%>' Visible='<%#Convert.ToBoolean(myappSettings.SSAutoSlide)%>'></asp:Label>
																</span></a>
														</div>
													</div>
												</ItemTemplate>
												<FooterStyle HorizontalAlign="Center" />
												<HeaderStyle HorizontalAlign="Center" />
												<ItemStyle HorizontalAlign="Center" VerticalAlign="Top" Wrap="True" />
												<SelectedItemStyle HorizontalAlign="Center" />
												<SeparatorStyle HorizontalAlign="Center" />
											</asp:DataList>
											<asp:GridView ID="gvNestedPaging" runat="server" role="presentation" AllowPaging="True" AutoGenerateColumns="False" BorderStyle="None" BorderWidth="0px" CssClass="pagerbox" HorizontalAlign="Center" DataKeyNames="GalleryID" GridLines="None" OnPageIndexChanging="gvNestedPaging_PageIndexChanging"
												ShowHeader="False" Visible="False" ShowFooter="True">
												<Columns>
													<asp:BoundField DataField="GalleryID" Visible="false" />
												</Columns>
												<PagerStyle HorizontalAlign="Center" CssClass="EDGpager" BorderWidth="0px" BorderStyle="None" />
											</asp:GridView>
										</asp:Panel>
										<asp:Panel ID="pnlTGDisplay" runat="server" HorizontalAlign="Center">
											<div class="EDGTitle">
												<asp:Label ID="lblTGTitle" runat="server" CssClass="EDGTitleText"></asp:Label>
												<asp:Label ID="lblTGDescription" runat="server" CssClass="GalleryDescription"></asp:Label>
											</div>
											<asp:Panel ID="pnlTopButton" runat="server">
												<asp:Panel ID="pnlNestedGalleryBackTop" runat="server" Visible="False">
													<div style="overflow: hidden; margin-bottom: 10px;">
														<asp:LinkButton ID="btnBackButtonTop" runat="server" OnClick="btnBack_Click" CssClass="btnGalleryBack">
														</asp:LinkButton>
													</div>
												</asp:Panel>
											</asp:Panel>
											<asp:DataList ID="dlTableGallery" runat="server" role="presentation"  CellPadding="0" RepeatDirection="Horizontal" RepeatColumns="4" Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" DataKeyField="PictureID" OnPreRender="dlTableGallery_PreRender"
												RepeatLayout="Table" HorizontalAlign="Center" OnItemCreated="dlTableGallery_ItemCreated" ItemStyle-HorizontalAlign="Center" OnItemCommand="dlTableGallery_ItemCommand" ItemStyle-VerticalAlign="Top" EnableViewState="False" CssClass="<%#layoutClass%>">
												<AlternatingItemStyle HorizontalAlign="Center" />
												<EditItemStyle HorizontalAlign="Center" />
												<ItemTemplate>
													<asp:PlaceHolder ID="plImage" runat="server" Visible='<%# ToDisplay("Image",DataBinder.Eval(Container.DataItem, "MediaType"))%>'>
														<div class="EDGmain">
															<div class="EDGimage">
																<a data-item-index='<%#Eval("MediaItemIndex")%>' href='<%#Eval("LinkOrLightbox")%>' downhref='<%#Eval("GetLighboxImageDownURL")%>' target="<%#Eval("TargetWin")%>" lbnestedurl='<%#Eval("GetLighboxNestedURL")%>' edgpid='<%#Eval("PictureID")%>' edgmid='<%=ModuleId.ToString()%>'
																	title='<%#Eval("GetDescription3")%>' rel='<%#Eval("RelLink")%>'>
																	<asp:Image ID="DataListImage" runat="server" ImageUrl='<%#Eval("GetThumbPath")%>' EnableTheming="True" alt='<%#Eval("GetAlt")%>' ImageAlign="Middle" />
																	<span class="flagObject"></span><span class="flag"></span><span class="leftsh"></span><span class="rightsh"></span><span class="botsh"></span><span class="topsh"></span><span class="round1"></span><span class="round2"></span><span class="round3"></span>
																	<span class="round4"></span><span class='<%#Eval("TitleClass")%>'>
																		<asp:Label ID="lblItemTitle" runat="server" Text='<%#Eval("ShowTitle")%>' Visible='<%#Eval("TitleToDisplay")%>'></asp:Label><br />
																		<asp:Label ID="lblTGDescription6" runat="server" CssClass="Description" Text='<%#Eval("ShowDescription")%>' Visible='<%#Eval("DescriptionToDisplay")%>'></asp:Label>
																	</span></a>
																<div class="socialSharingContainer" style='<%=SocialSharingButtonsClass%>'>
																	<div class="buttons">
																		<%#Eval("GetFacbookIframeLikeButton")%>
																		<%#Eval("GetGooglePlusButton")%>
																		<%#Eval("GetTwitterButton")%>
																		<%#Eval("GetPinterestButton")%>
																	</div>
																</div>
															</div>
														</div>
														<div style="clear: both; display: block; text-align: center;">
															<asp:HyperLink ID="hlDownloadImage" runat="server" NavigateUrl='<%#Eval("GetImageDownURL")%>' Visible='<%#Eval("GetDownloadVisible")%>' CssClass="downloadlink"><%=downloadText%></asp:HyperLink></div>
													</asp:PlaceHolder>
													<asp:PlaceHolder ID="plEmbed" runat="server" Visible='<%# ToDisplay("Embeded Video",DataBinder.Eval(Container.DataItem, "MediaType"))%>'>
														<div class="EDGmain">
															<div class="EDGvideo">
																<a data-item-index='<%#Eval("MediaItemIndex")%>' href='<%#FixVimeo(Eval("ShortEmbedUrl"),GetLightBoxSize(DataBinder.Eval(Container.DataItem, "Info"),DataBinder.Eval(Container.DataItem, "Filename")))%>' lbnestedurl='<%#Eval("GetLighboxNestedURL")%>' rel="<%#Eval("RelLink")%>"
																	edgmid='<%=ModuleId.ToString()%>' edgpid='<%#Eval("PictureID")%>' title='<%#Eval("GetDescription3")%>'>
																	<asp:Image ID="EmbedImageThumb" runat="server" ImageUrl='<%#Eval("GetThumbPath")%>' alt='<%#Eval("GetAlt")%>' />
																	<span class="flagObject"></span><span class="flag"></span><span class="leftsh"></span><span class="rightsh"></span><span class="botsh"></span><span class="topsh"></span><span class="round1"></span><span class="round2"></span><span class="round3"></span>
																	<span class="round4"></span><span class='<%#Eval("TitleClass")%>'>
																		<asp:Label ID="EmbedTitleLabel" runat="server" Text='<%#Eval("ShowTitle")%>' Visible='<%#Eval("TitleToDisplay")%>'></asp:Label><br />
																		<asp:Label ID="lblTGDescription2" CssClass="Description" runat="server" Text='<%#Eval("ShowDescription")%>' Visible='<%#Eval("DescriptionToDisplay")%>'></asp:Label></span> </a>
																<div class="socialSharingContainer" style='<%=SocialSharingButtonsClass%>'>
																	<div class="buttons">
																		<%#Eval("GetFacbookIframeLikeButton")%>
																		<%#Eval("GetGooglePlusButton")%>
																		<%#Eval("GetTwitterButton")%>
																		<%#Eval("GetPinterestButton")%>
																	</div>
																</div>
															</div>
														</div>
													</asp:PlaceHolder>
													<asp:PlaceHolder ID="plHtml5Video" runat="server" Visible='<%#ToDisplayHtml5Video("Video",DataBinder.Eval(Container.DataItem, "Info"),DataBinder.Eval(Container.DataItem, "FileExtension"))%>'>
														<div class="EDGmain">
															<div class="EDGvideo">
																<video controls="true" src='<%#Eval("Filename") %>' poster='<%#Eval("GetThumbPath") %>' width='<%=myappSettings.TGImageWidth%>' height='<%=myappSettings.TGImageHeight%>'>
																		Your browser doesn't support the video tag. You can <a href='<%#Eval("Filename") %>'>
																			download the video here.</a>
																		</video>
																<span class="flagObject"></span><span class="flag"></span><span class="leftsh"></span><span class="rightsh"></span><span class="botsh"></span><span class="topsh"></span><span class="round1"></span><span class="round2"></span><span class="round3"></span>
																<span class="round4"></span><span class='<%#Eval("TitleClass")%>'>
																	<asp:Label ID="Label1" runat="server" Text='<%#Eval("ShowTitle")%>' Visible='<%#Eval("TitleToDisplay")%>'></asp:Label><br />
																	<asp:Label ID="Label3" CssClass="Description" runat="server" Text='<%#Eval("ShowDescription")%>' Visible='<%#Eval("DescriptionToDisplay")%>'></asp:Label></span> </a>
																<div class="socialSharingContainer" style='<%=SocialSharingButtonsClass%>'>
																	<div class="buttons">
																		<%#Eval("GetFacbookIframeLikeButton")%>
																		<%#Eval("GetGooglePlusButton")%>
																		<%#Eval("GetTwitterButton")%>
																		<%#Eval("GetPinterestButton")%>
																	</div>
																</div>
															</div>
														</div>
													</asp:PlaceHolder>
													<asp:PlaceHolder ID="plFlash" runat="server" Visible='<%# ToDisplayVideoFlow("Video",DataBinder.Eval(Container.DataItem, "Info"),DataBinder.Eval(Container.DataItem, "FileExtension"),"Normal")%>'>
														<div class="EDGmain">
															<div class="EDGvideo">
																<a data-item-index='<%#Eval("MediaItemIndex")%>' href='<%=ModulePath.Replace("Controls/Lightbox/","")%>video.html?videourl=<%#RepVidNames(Eval("MediaType"),Eval("FileName"))%>&playerskin=<%=myappSettings.VGSkin%>&playonload=<%=myappSettings.PlayOnLoad %>&info=<%=myappSettings.InfoButton%>&description=<%#GetDescription2(DataBinder.Eval(Container.DataItem, "Description"))%>&fullscreen=<%=myappSettings.AllowFullscren%>&iframe=true<%# RepNames(Eval("MediaType"),Eval("ShortEmbedUrl"))%>'
																	lbnestedurl='<%#Eval("GetLighboxNestedURL")%>' rel="<%#Eval("RelLink")%>" edgpid='<%#Eval("PictureID")%>' edgmid='<%=ModuleId.ToString()%>' title='<%#Eval("GetDescription3")%>'>
																	<asp:Image ID="FlashImageThumb" runat="server" ImageUrl='<%#Eval("GetThumbPath")%>' alt='<%#Eval("GetAlt")%>' />
																	<span class="flagObject"></span><span class="flag"></span><span class="leftsh"></span><span class="rightsh"></span><span class="botsh"></span><span class="topsh"></span><span class="round1"></span><span class="round2"></span><span class="round3"></span>
																	<span class="round4"></span><span class='<%#Eval("TitleClass")%>'>
																		<asp:Label ID="FlashTitle" runat="server" Text='<%#Eval("ShowTitle")%>' Visible='<%#Eval("TitleToDisplay")%>'></asp:Label><br />
																		<asp:Label ID="lblTGDescription3" CssClass="Description" runat="server" Text='<%#Eval("ShowDescription")%>' Visible='<%#Eval("DescriptionToDisplay")%>'></asp:Label></span> </a>
																<div class="socialSharingContainer" style='<%=SocialSharingButtonsClass%>'>
																	<div class="buttons">
																		<%#Eval("GetFacbookIframeLikeButton")%>
																		<%#Eval("GetGooglePlusButton")%>
																		<%#Eval("GetTwitterButton")%>
																		<%#Eval("GetPinterestButton")%>
																	</div>
																</div>
															</div>
														</div>
													</asp:PlaceHolder>
													<asp:PlaceHolder ID="plFlashFlow" runat="server" Visible='<%# ToDisplayVideoFlow("Video",DataBinder.Eval(Container.DataItem, "Info"),DataBinder.Eval(Container.DataItem, "FileExtension"),"Flow")%>'>
														<div class="EDGmain">
															<div class="EDGvideo">
																<a data-item-index='<%#Eval("MediaItemIndex")%>' href='<%=ModulePath.Replace("Controls/Lightbox/","")%>videoFlow.html?videourl=<%#RepVidNames(Eval("MediaType"),Eval("FileName"))%>&playerskin=<%=myappSettings.VGSkin%>&playonload=<%=myappSettings.PlayOnLoad %>&info=<%=myappSettings.InfoButton%>&description=<%#GetDescription2(DataBinder.Eval(Container.DataItem, "Description"))%>&fullscreen=<%=myappSettings.AllowFullscren%>&iframe=true<%# RepNamesFlow(Eval("MediaType"),Eval("ShortEmbedUrl"))%>'
																	lbnestedurl='<%#Eval("GetLighboxNestedURL")%>' rel="<%#Eval("RelLink")%>" edgpid='<%#Eval("PictureID")%>' edgmid='<%=ModuleId.ToString()%>' title='<%#Eval("GetDescription3")%>'>
																	<asp:Image ID="Image3" runat="server" ImageUrl='<%#Eval("GetThumbPath")%>' alt='<%#Eval("GetAlt")%>' />
																	<span class="flagObject"></span><span class="flag"></span><span class="leftsh"></span><span class="rightsh"></span><span class="botsh"></span><span class="topsh"></span><span class="round1"></span><span class="round2"></span><span class="round3"></span>
																	<span class="round4"></span><span class='<%#Eval("TitleClass")%>'>
																		<asp:Label ID="Label6" runat="server" Text='<%#Eval("ShowTitle")%>' Visible='<%#Eval("TitleToDisplay")%>'></asp:Label><br />
																		<asp:Label ID="Label7" CssClass="Description" runat="server" Text='<%#Eval("ShowDescription")%>' Visible='<%#Eval("DescriptionToDisplay")%>'></asp:Label></span> </a>
																<div class="socialSharingContainer" style='<%=SocialSharingButtonsClass%>'>
																	<div class="buttons">
																		<%#Eval("GetFacbookIframeLikeButton")%>
																		<%#Eval("GetGooglePlusButton")%>
																		<%#Eval("GetTwitterButton")%>
																		<%#Eval("GetPinterestButton")%>
																	</div>
																</div>
															</div>
														</div>
													</asp:PlaceHolder>
													<asp:PlaceHolder ID="plMovHtml5" runat="server" Visible='<%# ToDisplayVideoFlashMovHtml5("flashmov",DataBinder.Eval(Container.DataItem, "Info"),DataBinder.Eval(Container.DataItem, "FileExtension"))%>'>
														<div class="EDGmain">
															<div class="EDGvideo">
																<video controls="true" src='<%#Eval("Filename") %>' poster='<%#Eval("GetThumbPath") %>' width='<%=myappSettings.TGImageWidth%>' height='<%=myappSettings.TGImageHeight%>'>
																		Your browser doesn't support the video tag. You can <a href='<%#Eval("Filename") %>'>
																			download the video here.</a>
																	</video>
																<span class="flagObject"></span><span class="flag"></span><span class="leftsh"></span><span class="rightsh"></span><span class="botsh"></span><span class="topsh"></span><span class="round1"></span><span class="round2"></span><span class="round3"></span>
																<span class="round4"></span><span class='<%#Eval("TitleClass")%>'>
																	<asp:Label ID="Label4" runat="server" Text='<%#Eval("ShowTitle")%>' Visible='<%#Eval("TitleToDisplay")%>'></asp:Label><br />
																	<asp:Label ID="Label5" CssClass="Description" runat="server" Text='<%#Eval("ShowDescription")%>' Visible='<%#Eval("DescriptionToDisplay")%>'></asp:Label></span> </a>
																<div class="socialSharingContainer" style='<%=SocialSharingButtonsClass%>'>
																	<div class="buttons">
																		<%#Eval("GetFacbookIframeLikeButton")%>
																		<%#Eval("GetGooglePlusButton")%>
																		<%#Eval("GetTwitterButton")%>
																		<%#Eval("GetPinterestButton")%>
																	</div>
																</div>
															</div>
														</div>
													</asp:PlaceHolder>
													<asp:PlaceHolder ID="plFlashMov" runat="server" Visible='<%# ToDisplayVideoFlashMov("flashmov",DataBinder.Eval(Container.DataItem, "Info"),DataBinder.Eval(Container.DataItem, "FileExtension"))%>'>
														<div class="EDGmain">
															<div class="EDGvideo">
																<a data-item-index='<%#Eval("MediaItemIndex")%>' href='<%#Eval("Filename") %>' edgmid='<%=ModuleId.ToString()%>' lbnestedurl='<%#Eval("GetLighboxNestedURL")%>' edgpid='<%#Eval("PictureID")%>' rel="<%#Eval("RelLink")%>" title='<%#Eval("GetDescription3")%>'>
																	<asp:Image ID="imgflasmovthumb" runat="server" ImageUrl='<%#Eval("GetThumbPath") %>' alt='<%#Eval("GetAlt")%>' />
																	<span class="flagObject"></span><span class="flag"></span><span class="leftsh"></span><span class="rightsh"></span><span class="botsh"></span><span class="topsh"></span><span class="round1"></span><span class="round2"></span><span class="round3"></span>
																	<span class="round4"></span><span class='<%#Eval("TitleClass")%>'>
																		<asp:Label ID="Label2" runat="server" Text='<%#Eval("ShowTitle")%>' Visible='<%#Eval("TitleToDisplay")%>'></asp:Label><br />
																		<asp:Label ID="lblTGDescription4" CssClass="Description" runat="server" Text='<%#Eval("ShowDescription")%>' Visible='<%#Eval("DescriptionToDisplay")%>'></asp:Label></span> </a>
																<div class="socialSharingContainer" style='<%=SocialSharingButtonsClass%>'>
																	<div class="buttons">
																		<%#Eval("GetFacbookIframeLikeButton")%>
																		<%#Eval("GetGooglePlusButton")%>
																		<%#Eval("GetTwitterButton")%>
																		<%#Eval("GetPinterestButton")%>
																	</div>
																</div>
															</div>
														</div>
													</asp:PlaceHolder>
													<asp:PlaceHolder ID="plAudio" runat="server" Visible='<%# ToDisplay("Audio",DataBinder.Eval(Container.DataItem, "MediaType"))%>'>
														<div class="EDGmain">
															<div class="EDGaudio">
																<a data-item-index='<%#Eval("MediaItemIndex")%>' href='<%=HostPath%><%=ModulePath.Replace("Controls/Lightbox/","")%>audio.html?audiourl=<%#HostPath%><%#Eval("Filename")%>&iframe=true&width=500&height=37&width=500&height=37'
																	lbnestedurl='<%#Eval("GetLighboxNestedURL")%>' rel="<%#Eval("RelLink")%>" edgmid='<%=ModuleId.ToString()%>' edgpid='<%#Eval("PictureID")%>' title='<%#Eval("GetDescription3")%>'>
																	<asp:Image ID="imgTGAudio" runat="server" ImageUrl='<%#Eval("GetThumbPath") %>' alt='<%#Eval("GetAlt")%>' />
																	<span class="flagObject"></span><span class="flag"></span><span class="leftsh"></span><span class="rightsh"></span><span class="botsh"></span><span class="topsh"></span><span class="round1"></span><span class="round2"></span><span class="round3"></span>
																	<span class="round4"></span><span class='<%#Eval("TitleClass")%>'>
																		<asp:Label ID="lblAudioTitle" runat="server" Text='<%#Eval("ShowTitle")%>' Visible='<%#Eval("TitleToDisplay")%>'></asp:Label><br />
																		<asp:Label ID="lblTGDescription5" CssClass="Description" runat="server" Text='<%# Eval("ShowDescription")%>' Visible='<%#Eval("DescriptionToDisplay")%>'></asp:Label></span> </a>
																<div class="socialSharingContainer" style='<%=SocialSharingButtonsClass%>'>
																	<div class="buttons">
																		<%#Eval("GetFacbookIframeLikeButton")%>
																		<%#Eval("GetGooglePlusButton")%>
																		<%#Eval("GetTwitterButton")%>
																		<%#Eval("GetPinterestButton")%>
																	</div>
																</div>
															</div>
														</div>
													</asp:PlaceHolder>
													<asp:PlaceHolder ID="plHTML5Audio" runat="server" Visible='<%# ShowHTML5Player("Audio",DataBinder.Eval(Container.DataItem, "MediaType"))%>'>
														<div class="EDGmain">
															<div class="EDGaudio">
																<a data-item-index='<%#Eval("MediaItemIndex")%>' href='<%#Eval("Filename")%>' lbnestedurl='<%#Eval("GetLighboxNestedURL")%>' edgmid='<%=ModuleId.ToString()%>' edgpid='<%#Eval("PictureID")%>' title='<%#Eval("GetDescription3")%>'>
																	<asp:Image ID="Image4" runat="server" ImageUrl='<%#Eval("GetThumbPath") %>' alt='<%#Eval("GetAlt")%>' />
																	<span class="flagObject"></span><span class="flag"></span><span class="leftsh"></span><span class="rightsh"></span><span class="botsh"></span><span class="topsh"></span><span class="round1"></span><span class="round2"></span><span class="round3"></span>
																	<span class="round4"></span><span class='<%#Eval("TitleClass")%>'>
																		<asp:Label ID="Label8" runat="server" Text='<%#Eval("ShowTitle")%>' Visible='<%#Eval("TitleToDisplay")%>'></asp:Label><br />
																		<asp:Label ID="Label9" CssClass="Description" runat="server" Text='<%# Eval("ShowDescription")%>' Visible='<%#Eval("DescriptionToDisplay")%>'></asp:Label></span> </a>
																<div class="socialSharingContainer" style='<%=SocialSharingButtonsClass%>'>
																	<div class="buttons">
																		<%#Eval("GetFacbookIframeLikeButton")%>
																		<%#Eval("GetGooglePlusButton")%>
																		<%#Eval("GetTwitterButton")%>
																		<%#Eval("GetPinterestButton")%>
																	</div>
																</div>
															</div>
														</div>
													</asp:PlaceHolder>
												</ItemTemplate>
												<FooterStyle HorizontalAlign="Center" />
												<HeaderStyle HorizontalAlign="Center" />
												<ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Wrap="False" />
												<SelectedItemStyle HorizontalAlign="Center" />
												<SeparatorStyle HorizontalAlign="Center" />
											</asp:DataList>
											<%=SetupSSValues()%>
											<asp:GridView ID="gvTGPagination" runat="server" role="presentation" AllowPaging="True" DataKeyNames="PictureID" OnPageIndexChanged="gvTGPagination_PageIndexChanged" OnPreRender="gvTGPagination_PreRender" Width="28px" HorizontalAlign="Center" ShowFooter="True" AutoGenerateColumns="False"
												PageSize="1" ShowHeader="False" BorderWidth="0px" BorderStyle="None" border="0" GridLines="None" CssClass="pagerbox" EnableViewState="False" OnPageIndexChanging="gvTGPagination_PageIndexChanging">
												<Columns>
													<asp:BoundField DataField="PictureID" Visible="False" />
												</Columns>
												<PagerStyle HorizontalAlign="Center" CssClass="EDGpager" BorderWidth="0px" BorderStyle="None" />
											</asp:GridView>
											<table role="presentation" cellpadding="0" cellspacing="0" border="0" align="center">
												<tr>
													<td>
														<asp:LinkButton ID="btnPrev" runat="server" OnClick="btnPrev_Click" CssClass="buttonPrev" Style="margin-top: 15px;" />
														<asp:LinkButton ID="btnNext" runat="server" OnClick="btnNext_Click" CssClass="buttonNext" Style="margin-top: 15px;" />
													</td>
												</tr>
											</table>
											<a id="hlUploadQuerstr" runat="server" visible="false">
												<asp:Image ID="Image1" runat="server" ImageUrl="~/DesktopModules/EasyDNNgallery/images/image_add.png" />
												<%=UserUpload%>
											</a><a id="hlApproveMedia" runat="server" visible="false">
												<asp:Image ID="Image2" runat="server" ImageUrl="~/DesktopModules/EasyDNNgallery/images/note_accept.png" />
												<%=strApprove%>
											</a>
										</asp:Panel>
										<div>
											<asp:Panel ID="pnlNestedGalleryBackBottom" runat="server">
												<asp:Panel ID="pnlNestedGalleryBack" runat="server" Visible="False">
													<div style="float: left;">
														<asp:LinkButton ID="btnBack" runat="server" OnClick="btnBack_Click" CssClass="btnGalleryBack">
														</asp:LinkButton>
													</div>
												</asp:Panel>
											</asp:Panel>
										</div>
										<asp:Literal ID="ltSmbScript" runat="server" EnableViewState="False"></asp:Literal>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="EDGclear">
					&nbsp;</div>
			</div>
		</div>
	</div>
</div>
