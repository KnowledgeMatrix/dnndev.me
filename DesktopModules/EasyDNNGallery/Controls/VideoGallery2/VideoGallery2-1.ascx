<%@ control language="C#" autoeventwireup="true" inherits="EasyDNN.Modules.EasyDNNGallery.DesktopModules_EasyDNNGallery_Controls_VideoGallery2Control, App_Web_videogallery2-1.ascx.e652496d" %>

<style type="text/css">
.titleempty
{
	display:none;
}
</style>
<script type="text/javascript">
	var edsVideoGalleryIsEmedVideo=false;
	function scrollToElement(selector, time) {
		<%=jQuery%>(document).ready(function($){
			verticalOffset= 50;
			verticalOffset = typeof(verticalOffset) != 'undefined' ? verticalOffset : 0;
			element = $(selector);
			var poffset = element.offset();
			if(poffset != null)
			{
				poffsetTop = poffset.top - verticalOffset;
				$('html, body').animate({
					scrollTop: poffset
				}, 1);
			setTimeout(function () {
				poffsetTop = poffset.top - verticalOffset;
				$('html, body').animate({
					scrollTop: poffset
				}, 500);
			}, 900);
			setTimeout(function () {
				poffsetTop = poffset.top - verticalOffset;
				$('html, body').animate({
					scrollTop: poffset
				}, 500);
			}, 1500);
			}
		});
	}

	<%=jQuery%>(document).ready(function($){
		$('#<%=CssClass%> a.edg_video_gal_socialsharing_toggle<%=ModulNr%>').click(function() {
			var $click = $(this);
			$click.parent().siblings('.edg_video_gal_socialsharing<%=ModulNr%>').slideToggle(200);
			return false;
		});
		
		$('#<%=CssClass%> a.edg_video_gal_permalink_toggle<%=ModulNr%>').click(function() {
			var $click = $(this);
			$click.parent().parent().siblings('.edg_video_gal_permalink<%=ModulNr%>').slideToggle(200);
			return false;
		});
		$('.flowplayer .VideoBodyPlayer').flowplayer({
		});
	});
</script>
<asp:Literal ID="ltOpenImage" runat="server" EnableViewState="False"></asp:Literal>
<div id="VideoGallery2">
	<asp:Panel ID="pnlVideoGallery" runat="server" Visible="False" 
		HorizontalAlign="Left">
		<div id="<%=CssClass%>" >
			<div class="EDGbackground">
				<div class="EDGcontentbgrd">
					<div class="EDGcornerbotleft">
						<div class="EDGcornerbotright">
							<div class="EDGcornertopleft">
								<div class="EDGcornertopright">
									<div class="EDGcontent" style="text-align: center;">
										<div class="EDGTitle">
											<asp:Label ID="lblVGTitle" runat="server" CssClass="EDGTitleText" Visible="False"></asp:Label>
											<br />
											<asp:Label ID="lblVGDescription" runat="server" CssClass="GalleryDescription" Visible="False"></asp:Label>
										</div>
										<asp:DataList ID="dlVideos" runat="server" Font-Bold="False" Font-Italic="False"
											Font-Overline="False" Font-Strikeout="False" Font-Underline="False" HorizontalAlign="Center"
											OnItemCreated="dlVideos_ItemCreated" RepeatColumns="1" onitemdatabound="dlVideos_ItemDataBound" >
											<EditItemStyle HorizontalAlign="Center" />
											<ItemTemplate>
												<asp:PlaceHolder ID="plImage" runat="server" Visible='<%# ToDisplayImage("Image",DataBinder.Eval(Container.DataItem, "MediaType"),DataBinder.Eval(Container.DataItem, "Info")) %>'>
													<div id="Div2" style="z-index: 0">
														<div class="VideoTitle">
															<asp:Label ID="Label5" runat="server" Text='<%#ShowTitle(DataBinder.Eval(Container.DataItem, "Title"))%>'
																CssClass="EDGTitleText"></asp:Label>
														</div>
														<div class="VideoBodyEmbed">
															<asp:Image ID="imgSlideImage" alt='<%#GetAlt(Eval("Title"),Eval("PictureID"))%>'
																runat="server" ImageUrl='<%#GetThumbPath(DataBinder.Eval(Container.DataItem, "ShortEmbedUrl")) %>' />
														</div>
														<div class="VideoDescription">
															<asp:Label ID="Label6" CssClass="EDGTitleText" runat="server" Text='<%# ShowDescription(DataBinder.Eval(Container.DataItem, "Description"))%>'></asp:Label>
														</div>
													</div>
												</asp:PlaceHolder>
												<asp:PlaceHolder ID="plhBitsOnTheRun" runat="server" Visible='<%# ToDisplayBits("Embeded Video",DataBinder.Eval(Container.DataItem, "MediaType"),DataBinder.Eval(Container.DataItem, "Info")) %>'>
													<div id="Div1" style="z-index: 0">
														<div class="VideoTitle">
															<asp:Label ID="Label2" runat="server" Text='<%#ShowTitle(DataBinder.Eval(Container.DataItem, "Title"))%>'
																CssClass="EDGTitleText"></asp:Label>
														</div>
														<div class="VideoBodyEmbed">
														<script src="<%#(Eval("ShortEmbedUrl")).ToString()%>" type="text/javascript"></script>
														</div>
														<div class="VideoDescription">
															<asp:Label ID="Label3" CssClass="EDGTitleText" runat="server" Text='<%# ShowDescription(DataBinder.Eval(Container.DataItem, "Description"))%>'></asp:Label>
														</div>
													</div>
												</asp:PlaceHolder>
												<asp:PlaceHolder ID="phVGEmbed" runat="server" Visible='<%# ToDisplay("Embeded Video",DataBinder.Eval(Container.DataItem, "MediaType"),DataBinder.Eval(Container.DataItem, "Info")) %>'>
													<div id="embedvideo" style="z-index: 0">
														<div class="VideoTitle">
															<asp:Label ID="lblVGEVMediaTitle" runat="server" Text='<%#ShowTitle(DataBinder.Eval(Container.DataItem, "Title"))%>'
																CssClass="EDGTitleText"></asp:Label>
														</div>
														<div class="VideoBodyEmbed">
															<%#FixProtocol(Eval("FileName"))%>
														</div>
														<div class="VideoDescription">
															<asp:Label ID="lblVGEVMediaDescription" CssClass="EDGTitleText" runat="server" Text='<%# ShowDescription(DataBinder.Eval(Container.DataItem, "Description"))%>'></asp:Label>
														</div>
													</div>
													<script type="text/javascript">
														edsVideoGalleryIsEmedVideo=true;
																	</script>
												</asp:PlaceHolder>
												<asp:PlaceHolder ID="phSWfFlash" runat="server" Visible='<%# ToDisplayVideo("Video",DataBinder.Eval(Container.DataItem, "MediaType"),DataBinder.Eval(Container.DataItem, "Info"),DataBinder.Eval(Container.DataItem, "FileName")) %>'>
													<div class="VideoTitle">
														<asp:Label ID="lblVGEVMediaTitle3" runat="server" Text='<%#ShowTitle(DataBinder.Eval(Container.DataItem, "Title"))%>'
															CssClass="EDGTitleText"></asp:Label>
													</div>
													<div class="VideoBodySwf">
														<div id="<%# Getidname() %>">
															You need to upgrade your flash player.
														</div>
													</div>
													<div class="VideoDescription">
														<asp:Label ID="lblVGEVMediaDescription3" runat="server" Text='<%# ShowDescription(DataBinder.Eval(Container.DataItem, "Description"))%>'>
														</asp:Label>
													</div>
													<script type="text/javascript">
															<%=jQuery%>(document).ready(function() {
															var flashvars = {};
															var params = {};
															params.wmode='transparent';
															var attributes = {};
															swfobject.embedSWF('<%#DataBinder.Eval(Container.DataItem, "FileName")%>', '<%#Getidname() %>', '<%# GetVideoWidth(DataBinder.Eval(Container.DataItem, "MediaType"),DataBinder.Eval(Container.DataItem, "FileName"))%>', '<%# GetVideoHeight(DataBinder.Eval(Container.DataItem, "MediaType"),DataBinder.Eval(Container.DataItem, "FileName"))%>', "9.0.0",'<%=ModulePath.Replace("Controls/VideoGallery2/","")%>js/expressInstall.swf', flashvars, params, attributes);
														}); 
													</script>
												</asp:PlaceHolder>
												<asp:PlaceHolder ID="phEVVideo" runat="server" Visible='<%# ToDisplayVideo2Flow("Video",DataBinder.Eval(Container.DataItem, "MediaType"),DataBinder.Eval(Container.DataItem, "Info"),DataBinder.Eval(Container.DataItem, "FileName"),"Normal")%>'>
													<div class="VideoTitle">
														<asp:Label ID="lblVGEVMediaTitle2" runat="server" CssClass="EDGTitleText" Text='<%#ShowTitle(DataBinder.Eval(Container.DataItem, "Title"))%>'></asp:Label>
													</div>
													<div class="VideoBodyPlayer">
														<div id="<%# Getidname() %>">
															You need to upgrade your flash player.
														</div>
													</div>
													<div class="VideoDescription">
														<asp:Label ID="lblVGEVMediaDescription2" runat="server" Text='<%# ShowDescription(DataBinder.Eval(Container.DataItem, "Description"))%>'></asp:Label>
													</div>
													<script type='text/javascript'>
														<%=jQuery%>(document).ready(function() {                    
														var flashvars = {};
														var params = {};
														var attributes = {};
														params.codebase='http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=8,0,0,0';
														//params.width='300';
														//params.height='200';
														params.quality='high';
														params.align='middle';
														params.play='true';
														params.loop='true';
														params.scale='showall';
														// params.wmode='window';
														params.devicefont='false';
														params.bgcolor='#2e2e2e',
														params.allowFullScreen='<%=AllowFullscren2%>';
														params.allowScriptAccess='sameDomain';
														params.salign = 'middle';
														params.wmode='transparent';
														
														flashvars.forcewidth='<%#GetVideoWidth(DataBinder.Eval(Container.DataItem, "MediaType"),DataBinder.Eval(Container.DataItem, "FileName"))%>'
														flashvars.forceheight='<%#GetVideoHeight2(DataBinder.Eval(Container.DataItem, "MediaType"),DataBinder.Eval(Container.DataItem, "FileName"))%>'
														flashvars.skin= '<% =myappSettings.VGSkin%>'
														flashvars.fullscreenbutton='<%=AllowFullscren%>'
														flashvars.infobutton='<%=InfoButton%>'
														if ('<%=myappSettings.StartPhoto%>' == 'True') 
														{
														flashvars.startphoto='<%#DataBinder.Eval(Container.DataItem, "ThumbUrl")%>';
														} 
														else
														{
														flashvars.startphoto='';
														}
														flashvars.videopath='<%#DataBinder.Eval(Container.DataItem, "FileName")%>'
														flashvars.playonload='<%=PlayOnLoad%>'
														flashvars.initialvolume='<%=myappSettings.InitialVolume%>'
														flashvars.startbufferonload='<%=PlayOnLoad%>'
														flashvars.defaultstretch = 'zoom to fit'
														flashvars.buffersize='3'
														flashvars.infotext='<%# ShowDescriptionInFlash(DataBinder.Eval(Container.DataItem, "Description"),DataBinder.Eval(Container.DataItem, "PictureID"))%>'
														attributes.id = 'pp'												
														swfobject.embedSWF('<%=ModulePath.Replace("Controls/VideoGallery2/","")%>preview.swf', '<%#Getidname() %>', '<%#GetVideoWidth(DataBinder.Eval(Container.DataItem, "MediaType"),DataBinder.Eval(Container.DataItem, "FileName"))%>', '<%# GetVideoHeight(DataBinder.Eval(Container.DataItem, "MediaType"),DataBinder.Eval(Container.DataItem, "FileName"))%>', '9.0.0', '<%=ModulePath.Replace("Controls/VideoGallery2/","")%>js/expressInstall.swf', flashvars, params, attributes);
														scrollToElement('#<%=dlVideos.ClientID%>', 10, 50);
														});
													</script>
												</asp:PlaceHolder>
												<asp:PlaceHolder ID="phEVVideoFlow" runat="server" Visible='<%# ToDisplayVideo2Flow("Video",DataBinder.Eval(Container.DataItem, "MediaType"),DataBinder.Eval(Container.DataItem, "Info"),DataBinder.Eval(Container.DataItem, "FileName"),"Flow") %>'>
													<div class="VideoTitle">
															<asp:Label ID="lblVideoFlowTitle" runat="server" CssClass="EDGTitleText" Text='<%#ShowTitle(DataBinder.Eval(Container.DataItem, "Title"))%>' Visible="<%#Convert.ToBoolean(myappSettings.ShowMediaTitle)%>"></asp:Label>
														</div>
														<div class="VideoBodyPlayer">
															<div style='display: block; width: <%#GetFlowVideoWidth(DataBinder.Eval(Container.DataItem, "MediaType"),DataBinder.Eval(Container.DataItem, "FileName"))%>px; height: <%# GetFlowVideoHeight(DataBinder.Eval(Container.DataItem, "MediaType"),DataBinder.Eval(Container.DataItem, "FileName"))%>px' class="flowplayer" fullscreen="<%= myappSettings.AllowFullscren.ToLower()%>" data-tooltip="false" data-flashfit="true" data-native_fullscreen="true" data-adaptiveratio="false" controls="controls" preload="metadata" data-volume="<%=myappSettings.InitialVolume%>">
																<video <%=(myappSettings.PlayOnLoad=="True"?"autoplay":"") %> <%=loopFlow%> <%# GetFlowPoster(DataBinder.Eval(Container.DataItem, "ThumbUrl"))%>>
																	<source type="video/mp4" src="<%#GetFlowFileName(DataBinder.Eval(Container.DataItem, "FileName"))%>">
																</video>
															</div>
														</div>
														<div class="VideoDescription">
															<asp:Label ID="lblVGEVMediaDescription2Flow" runat="server" Text='<%# ShowDescription(DataBinder.Eval(Container.DataItem, "Description"))%>' Visible="<%#Convert.ToBoolean(myappSettings.ShowMediaDescription)%>"></asp:Label>
														</div>
													<div ><br /></div>
												</asp:PlaceHolder>
												<asp:PlaceHolder ID="phHtml5Video" runat="server" Visible='<%# ToDisplayVideoHtml5("Video",DataBinder.Eval(Container.DataItem, "MediaType"),DataBinder.Eval(Container.DataItem, "Info"),DataBinder.Eval(Container.DataItem, "FileName")) %>'>
													<div class="VideoTitle">
														<asp:Label ID="Label1" runat="server" CssClass="EDGTitleText" Text='<%#ShowTitle(DataBinder.Eval(Container.DataItem, "Title"))%>'></asp:Label>
													</div>
													<div class="VideoDescription">
														<asp:Label ID="lblVGEVMediaDescription5" runat="server" Text='<%# ShowDescription(DataBinder.Eval(Container.DataItem, "Description"))%>'></asp:Label>
													</div>
													<style type="text/css">
														#Divvideo_player
														{
															width: <%#GetVideoWidth(DataBinder.Eval(Container.DataItem, "MediaType"),DataBinder.Eval(Container.DataItem, "FileName"))%>px;
															height: <%#GetVideoHeight2(DataBinder.Eval(Container.DataItem, "MediaType"),DataBinder.Eval(Container.DataItem, "FileName"))%>px;
															background: #000;
														}
													</style>
													<div id="Divvideo_player">
													</div>
													<script type="text/javascript">
														<%=jQuery%>(document).ready(function(){
														<%=jQuery%>("#Divvideo_player").H5Video({
														events : {
														pause : function()
														{
														writeMessage("Paused video");
														},

														play : function()
														{
														writeMessage("Playing video");
														},

														end : function()
														{
														writeMessage("End of video");
														}
														},
														animationDuration : 350,
														source : {
														"video/mp4"  : '<%#DataBinder.Eval(Container.DataItem, "FileName")%>',
														},
														loop : false,			
														preload: true,
														autoPlay : false,
														poster : '<%#getStartPhoto(DataBinder.Eval(Container.DataItem, "ThumbUrl"))%>',
														supportMessage : "This browser cannot playback HTML5 videos. We encourage you to upgrade your internet browser to one of the following modern browsers:"
														});
														});
														function writeMessage(msg)
														{}
													</script>
												</asp:PlaceHolder>
												
												<div class="edg_share_link_wrapper">
												<asp:Panel ID="pnlMediaUrl" runat="server" Visible="False" CssClass="edn_link_and_share_container">
													<a href="#" class="EasyDNNGallery_silver_button edg_video_gal_permalink_toggle<%=ModulNr%>"><span><img alt="" class="icon" src="<%=ModulePath.Replace("Controls/VideoGallery2","")%>images/icons/grey_link.png"><%=LinkThis%></span></a>
												</asp:Panel>
												<asp:Panel ID="pnlSocialSharing" runat="server" Visible="False" CssClass="edn_link_and_share_container">
													<a href="#" class="EasyDNNGallery_silver_button edg_video_gal_socialsharing_toggle<%=ModulNr%>"><span><img alt="" class="icon" src="<%=ModulePath.Replace("Controls/VideoGallery2","")%>images/icons/grey_plus.png"><%=ShareThis%></span></a>
												</asp:Panel>
												<div class="edg_video_gal_socialsharing<%=ModulNr%>" style='<%=ShowSharingStyle%>'>
													<%#GetTwitterButton(Eval("PictureID"))%>
													<%#GetGooglePlusButton(Eval("PictureID"))%>
													<%#GetFacbookIframeLikeButton(Eval("PictureID"))%>
												</div>
												</div>
												<div class="edg_link_container edg_video_gal_permalink<%=ModulNr%>" style="display: none;">
													<asp:TextBox ID="tbMediaURL" runat="server" Text='<%#GetMediaURLBackLink(Eval("PictureID"))%>'
														></asp:TextBox>
												</div>
											</ItemTemplate>
										</asp:DataList>
										<br />
										<div class="playList">
											<asp:DataList ID="repVideoList" runat="server" ShowFooter="False" ShowHeader="False"
												DataKeyField="PictureID" OnItemCommand="repVideoList_ItemCommand1" HorizontalAlign="Center"
												RepeatColumns="1" Width="95%">
												<ItemStyle HorizontalAlign="Left" />
												<ItemTemplate>
													<div class="playListItem">
														<asp:LinkButton ID="lbVideoThumb2" runat="server" CommandArgument='<%#Eval("PictureID")%>'
															CommandName="OpenVideo">
															<%# (objPageSource.CurrentPageIndex * objPageSource.PageSize) + (Container.ItemIndex + 1) %>.
															<asp:Label ID="lblItemTitle2" runat="server" Text='<%#ShowTitle(DataBinder.Eval(Container.DataItem, "Title"))%>'
																Visible='<%#TitleToDisplayThumbnail(Eval("Title"),Eval("PictureID"))%>'></asp:Label>
															-
															<asp:Label ID="lblTGDescription2" runat="server" CssClass="Description" Text='<%# ShowDescription(DataBinder.Eval(Container.DataItem, "Description"))%>'
																Visible='<%#DescriptionToDisplayThumbnail(Eval("Description"),Eval("PictureID"))%>'></asp:Label>
														</asp:LinkButton>
													</div>
												</ItemTemplate>
											</asp:DataList>
										</div>
										<br />
										<asp:GridView ID="gvVGalPagination" runat="server" AllowPaging="True" AutoGenerateColumns="False"
											DataKeyNames="PictureID" DataSourceID="odsGetVideos" HorizontalAlign="Center"
											OnPageIndexChanged="gvVGalPagination_PageIndexChanged" 
											PageSize="1" ShowFooter="True" ShowHeader="False" Width="28px" BorderWidth="0px"
											BorderStyle="None" GridLines="None">
											<Columns>
												<asp:BoundField DataField="FileName" Visible="False" />
											</Columns>
											<PagerStyle HorizontalAlign="Center" CssClass="EDGpager" BorderWidth="0px" />
										</asp:GridView>
										<table cellpadding="0" cellspacing="0" border="0" align="center">
											<tr>
												<td>
													<asp:LinkButton ID="btnVGPrev" runat="server" OnClick="btnVGPrev_Click" CssClass="buttonPrev" />
													<asp:LinkButton ID="btnVGNext" runat="server" OnClick="btnVGNext_Click" CssClass="buttonNext" />
												</td>
											</tr>
										</table>
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
	</asp:Panel>
</div>
<script type="text/javascript">
	var loadFunc = function() {
		<%=jQuery%>(document).ready(function($) {
			if(edsVideoGalleryIsEmedVideo)
			{
				scrollToElement('<%=dlVideos.ClientID%>',10);
			}
		})
	};
	window.onload = loadFunc;
</script>
<asp:ObjectDataSource ID="odsIntegrate" TypeName="EasyDNN.Modules.EasyDNNGallery.DataAcess" runat="server" SelectMethod="GetIntegration">
	<SelectParameters>
		<asp:Parameter Name="PortalID" Type="Int32" />
		<asp:Parameter Name="ModuleID" Type="Int32" />
		<asp:Parameter Name="ArticleID" Type="Int32" />
	</SelectParameters>
</asp:ObjectDataSource>
<asp:ObjectDataSource ID="odsGetVideos" TypeName="EasyDNN.Modules.EasyDNNGallery.DataAcess" runat="server" 
	SelectMethod="GetRandomVideosFromGallery" 
	OldValuesParameterFormatString="original_{0}">
	<SelectParameters>
		<asp:Parameter Name="PortalID" Type="Int32" />
		<asp:Parameter Name="GalleryID" Type="Int32" />
		<asp:Parameter Name="isRandom" Type="Boolean" />
	</SelectParameters>
</asp:ObjectDataSource>
