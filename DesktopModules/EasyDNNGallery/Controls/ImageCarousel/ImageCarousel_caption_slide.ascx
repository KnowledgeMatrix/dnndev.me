<%@ control language="C#" autoeventwireup="true" inherits="EasyDNN.Modules.EasyDNNGallery.DesktopModules_EasyDNNGallery_Controls_ImageCarouselControl, App_Web_imagecarousel_caption_slide.ascx.ae0fbc37" %>
<style type="text/css">
		.image_carousel
		 {
			padding: 15px 0px 15px 0px;
			position: relative;
		}
		.image_carousel img {
			border: 1px solid #ccc;
			background-color: white;
			padding: 0px;
			margin: 0px;
			display: block;
			float: left;
		}
		a.prev<%=ModulNr%>, a.next<%=ModulNr%> {
			background: url(<%=ModulePath.Replace("Controls/ImageCarousel/","")%><%=ICASpriteURL%>) 0 0 no-repeat transparent;
			width: <%=ICAPrevNextWidth%>px;
			height: <%=ICAPrevNextHeight%>px;
			display: block;
			position: absolute;
			top: <%=intmiddle%>px;
			z-index: 150;
		}
		a.prev<%=ModulNr%> 
			{
				left: -25px;
			}
		a.prev<%=ModulNr%>:hover
			{
				background-position: <%=ICAPrevBackgroundPositionHover%>;
			}
		a.next<%=ModulNr%> 
			{
				right: -22px;
				background-position: <%=ICANextBackgroundPosition%>;
			}
		a.next<%=ModulNr%>:hover 
			{
				background-position: <%=ICANextBackgroundPositionHover%>;
			}
		a.prev<%=ModulNr%> span, a.next<%=ModulNr%> span
			{
				display: none;
			}
		.pagination<%=ModulNr%> 
			{
				text-align: center;
			}
		.pagination<%=ModulNr%> a 
			{
				background: url(<%=ModulePath.Replace("Controls/ImageCarousel/","")%>css/images/miscellaneous_sprite.png) 0 -100px no-repeat transparent;
				width: 15px;
				height: 15px;
				margin: 0 5px 0 0;
				display: inline-block;
			}
		.pagination<%=ModulNr%> a.selected 
			{
				background-position: -25px -100px;
				cursor: default;
			}
		.pagination<%=ModulNr%> a span 
			{
				display: none;
			}
		#<%=ModulNr%>EasyDNNGallery .clearfix
			{
				float: none;
				clear: both;
			}
		#IC<%=ModulNr%>
			{
				overflow: hidden;
			}
		#<%=imageCarouselCssClass%> #IC<%=ModulNr%> .EDGmain
			{
			visibility:hidden;
			}
		.image_carousel
		 {
		height:0px;
		overflow:hidden;
		}
		.titleempty
		{
			display:none;
		}
		#<%=imageCarouselCssClass%> .<%=ModulNr%> .EDGboxslide
		{ 
			width: <%=myappSettings.SSImageWidth%>px;
			height: <%=myappSettings.SSImageHeight%>px;
		}

		#<%=imageCarouselCssClass%> .<%=ModulNr%> .EDGboxcaption{ 
			height: <%=myappSettings.SSImageHeight%>px; 
			width: <%=myappSettings.SSImageWidth%>px;
		}
	
		#<%=imageCarouselCssClass%> .<%=ModulNr%> .EDGdesccaption .EDGboxcaption 
		{
			top: <%=TGImageHeight30%>px;
			left: 0;
			white-space:normal;
		}
		#<%=imageCarouselCssClass%> .<%=ModulNr%> .EDGboxcaption .EDGbgrdtext
		{
			width: <%=myappSettings.SSImageWidth%>px;
			height: <%=myappSettings.SSImageHeight%>px; 
		}
		.eds_edn_qtip2_style
	{
		-moz-border-radius: <%=myappSettings.TooltipRadius%>px;
		-webkit-border-radius: <%=myappSettings.TooltipRadius%>px;
		border-radius: <%=myappSettings.TooltipRadius%>px;
		border-width: <%=myappSettings.TooltipBorder%>px;
	}
	</style>
<script type="text/javascript">
				<%=jQuery%>(document).ready(function($) {
				$('#IC<%=ModulNr%>').carouFredSel({
					auto : <%=myappSettings.SSAutoSlideRandom%>,
					auto : {
					play:<%=myappSettings.SSAutoSlideRandom%>,
							timeoutDuration	: <%=myappSettings.SSAutoSlidePause%>,
							pauseOnHover	: true
						   },
					responsive: false,
					width: <%=containerWidth%>,
					items	: <%=myappSettings.SliderTransition%>,
					scroll	: {
								 items 		: <%=myappSettings.SSAutoStartRandom%>
							},

					prev : {	
						button	: '#foo2_prev<%=ModulNr%>',
						key		: "left"
					},
					next : { 
						button	: '#foo2_next<%=ModulNr%>',
						key		: "right"
					},
					swipe	: {
					onMouse: true,
					onTouch: true
			},
					pagination	: '#<%=PagingVisible%>'
				});
				$('#<%=imageCarouselCssClass%> #IC<%=ModulNr%> .EDGmain').css('visibility', 'visible');
				$('.image_carousel').css('overflow', 'visible');
				$('.image_carousel').css('height', 'auto');
				if( <%=containerWidth%> != '100%'){
					$("#IC<%=ModulNr%>").trigger("configuration", ["width", function( val ) {
					$("#IC<%=ModulNr%>").parents().eq(1).width(val);
				}]);}

				$('.<%=ModulNr%>.EDGboxslide.EDGdesccaption').hover(function () {
					$(".EDGslide", this).stop().animate({ top: '0px' }, { queue: false, duration: 360 });
				}, function () {
					$(".EDGslide", this).stop().animate({ top: '<%=TGImageHeight30%>px' }, { queue: false, duration: 360 });
				});

			if('<%=myappSettings.ShowToolTips %>'=='True'){
			if('<%=myappSettings.LightboxDescription %>'=='True'){
				$('#<%=ModulNr%>EasyDNNGallery .EDGimage a[title], #<%=ModulNr%>EasyDNNGallery .EDGvideo a[title], #<%=ModulNr%>EasyDNNGallery .EDGaudio a[title]').each(function(){
						$(this).qtip({
							show: {  effect: function(offset) { <%=myappSettings.ShowEffect%> } },
							hide: {  effect: function(offset) { <%=myappSettings.HideEffect%> } },
							position: { at: '<%=myappSettings.TargetPosition%>', my: '<%=myappSettings.TooltipPosition%>'},
							style: { classes: 'qtip-<%=myappSettings.TooltipTheme%> eds_edn_qtip2_style', tip: {corner: true, width: 10, height: 5}}
						});
					});
				}
			}
			});
</script>
<asp:Literal ID="ltOpenImage" runat="server" EnableViewState="False"></asp:Literal>
<div id="ImageCarousel" runat="server">
	<asp:Panel ID="pnlImageCarousel" runat="server">
		<div id="<%=imageCarouselCssClass%>">
			<div class="EDGbackground">
				<div class="EDGcontentbgrd">
					<div class="EDGcornerbotleft">
						<div class="EDGcornerbotright">
							<div class="EDGcornertopleft">
								<div class="EDGcornertopright">
									<div class="EDGcontent">
										<div class="EDGTitle">
											<asp:Label ID="lblTGTitle" runat="server" CssClass="EDGTitleText" Visible="False"></asp:Label>
											<asp:Label ID="lblTGDescription" runat="server" CssClass="GalleryDescription" Visible="False"></asp:Label>
										</div>
										<div class="image_carousel" style="margin: 0 auto;">
											<div id='IC<%=ModulNr%>'>
												<asp:Repeater ID="repImageCarousel" runat="server" DataSourceID="odsGetOnlyImages" EnableViewState="False">
													<ItemTemplate>
														<div class="EDGmain">
															<div class="<%=ModulNr%>">
																<asp:PlaceHolder ID="plImage" runat="server" Visible='<%# ToDisplay("Image",DataBinder.Eval(Container.DataItem, "MediaType"))%>'>
																	<div class="EDGimage">
																		<span class="leftsh"></span><span class="rightsh"></span><span class="botsh"></span><span class="topsh"></span><span class="round1"></span><span class="round2"></span><span class="round3"></span><span class="round4"></span>
																		<div class="shadowborder">
																			<div class="<%=ModulNr%> EDGboxslide EDGdesccaption">
																				<img id="imgImageSlider" runat="server" alt='<%# GetAlt(Eval("Title"),Eval("PictureID")) %>' src='<%#GetThumbPath(DataBinder.Eval(Container.DataItem, "ViewerThumb")) %>' width="<%#GetImageWidthInt()%>" height="<%#GetImageHeightInt()%>" /><span class="zborder"></span>
																				<div class="<%=ModulNr%> EDGslide EDGboxcaption">
																					<div class="EDGbgrdtext">
																					</div>
																					<div class="EDGslidetext">
																						<h3>
																							<a edgpid='<%#Eval("PictureID")%>' href='<%#LinkOrLightbox(Eval("FileName"),Eval("ImageUrl"),Eval("PictureID")) %>' rel="<%#RelLink()%>" target="<%#TargetWin()%>" title='<%#GetDescription3(DataBinder.Eval(Container.DataItem, "Description"),DataBinder.Eval(Container.DataItem, "PictureID"))%>'>
																								<asp:Label ID="lblTGNGTitle" runat="server" Text='<%#ShowTitle(DataBinder.Eval(Container.DataItem, "Title"),DataBinder.Eval(Container.DataItem, "PictureID"))%>' Visible='<%#TitleToDisplay(Eval("Title"))%>'></asp:Label></a></h3>
																						<p>
																							<asp:Label ID="lblTGNGDescription" runat="server" Text='<%# ShowDescription(DataBinder.Eval(Container.DataItem, "Description"),DataBinder.Eval(Container.DataItem, "PictureID"))%>' Visible='<%#DescriptionToDisplay(Eval("Description"))%>'></asp:Label></p>
																						<a class="btnslide" href='<%#LinkOrLightbox(Eval("FileName"),Eval("ImageUrl"),Eval("PictureID")) %>' rel="<%#RelLink()%>" target="<%#TargetWin()%>" title='<%#GetDescription3(DataBinder.Eval(Container.DataItem, "Description"),DataBinder.Eval(Container.DataItem, "PictureID"))%>'>
																							<%=strOpenMedia%></a></div>
																				</div>
																			</div>
																		</div>
																	</div>
																</asp:PlaceHolder>
																<asp:PlaceHolder ID="plEmbed" runat="server" Visible='<%# ToDisplay("Embeded Video",DataBinder.Eval(Container.DataItem, "MediaType"))%>'>
																	<div class="EDGvideo">
																		<span class="leftsh"></span><span class="rightsh"></span><span class="botsh"></span><span class="topsh"></span><span class="round1"></span><span class="round2"></span><span class="round3"></span><span class="round4"></span>
																		<div class="shadowborder">
																			<div class="<%=ModulNr%> EDGboxslide EDGdesccaption">
																				<img id="img1" runat="server" alt='<%# GetAlt(Eval("Title"),Eval("PictureID")) %>' src='<%#GetThumbPath(DataBinder.Eval(Container.DataItem, "ViewerThumb")) %>' width="<%#GetImageWidthInt()%>" height="<%#GetImageHeightInt()%>" /><span class="zborder"></span>
																				<div class="<%=ModulNr%> EDGslide EDGboxcaption">
																					<div class="EDGbgrdtext">
																					</div>
																					<div class="EDGslidetext">
																						<h3>
																							<a edgpid='<%#Eval("PictureID")%>' href='<%#FixVimeo(Eval("ShortEmbedUrl"),GetLightBoxSize(DataBinder.Eval(Container.DataItem, "Info"),DataBinder.Eval(Container.DataItem, "Filename")))%>' rel="<%#RelLink()%>" target="<%#TargetWin()%>" title='<%#GetDescription3(DataBinder.Eval(Container.DataItem, "Description"),DataBinder.Eval(Container.DataItem, "PictureID"))%>'>
																								<asp:Label ID="Label1" runat="server" Text='<%#ShowTitle(DataBinder.Eval(Container.DataItem, "Title"),DataBinder.Eval(Container.DataItem, "PictureID"))%>' Visible='<%#TitleToDisplay(Eval("Title"))%>'></asp:Label></a></h3>
																						<p>
																							<asp:Label ID="Label2" runat="server" Text='<%# ShowDescription(DataBinder.Eval(Container.DataItem, "Description"),DataBinder.Eval(Container.DataItem, "PictureID"))%>' Visible='<%#DescriptionToDisplay(Eval("Description"))%>'></asp:Label></p>
																						<a class="btnslide" href='<%#FixVimeo(Eval("ShortEmbedUrl"),GetLightBoxSize(DataBinder.Eval(Container.DataItem, "Info"),DataBinder.Eval(Container.DataItem, "Filename")))%>' rel="<%#RelLink()%>" target="<%#TargetWin()%>" title='<%#GetDescription3(DataBinder.Eval(Container.DataItem, "Description"),DataBinder.Eval(Container.DataItem, "PictureID"))%>'>
																							<%=strOpenMedia%></a></div>
																				</div>
																			</div>
																		</div>
																	</div>
																</asp:PlaceHolder>
																<asp:PlaceHolder ID="plFlash" runat="server" Visible='<%# ToDisplayVideoFlow("Video",DataBinder.Eval(Container.DataItem, "Info"),DataBinder.Eval(Container.DataItem, "FileExtension"),"Normal")%>'>
																	<div class="EDGvideo">
																		<span class="leftsh"></span><span class="rightsh"></span><span class="botsh"></span><span class="topsh"></span><span class="round1"></span><span class="round2"></span><span class="round3"></span><span class="round4"></span>
																		<div class="shadowborder">
																			<div class="<%=ModulNr%> EDGboxslide EDGdesccaption">
																				<img id="img2" runat="server" alt='<%# GetAlt(Eval("Title"),Eval("PictureID")) %>' src='<%#GetThumbPath(DataBinder.Eval(Container.DataItem, "ViewerThumb")) %>' width="<%#GetImageWidthInt()%>" height="<%#GetImageHeightInt()%>" /><span class="zborder"></span>
																				<div class="<%=ModulNr%> EDGslide EDGboxcaption">
																					<div class="EDGbgrdtext">
																					</div>
																					<div class="EDGslidetext">
																						<h3>
																							<a edgpid='<%#Eval("PictureID")%>' href='<%=ModulePath.Replace("Controls/ImageCarousel/","")%>video.html?videourl=<%#RepVidNames(Eval("MediaType"),Eval("FileName"))%>&playerskin=<%=myappSettings.VGSkin%>&playonload=<%=myappSettings.PlayOnLoad%>&info=<%=myappSettings.InfoButton%>&description=<%#GetDescription2(DataBinder.Eval(Container.DataItem, "Description"))%>&fullscreen=<%=myappSettings.AllowFullscren%>&iframe=true<%# RepNames(Eval("MediaType"),Eval("ShortEmbedUrl"))%>'
																								rel="<%#RelLink()%>" target="<%#TargetWin()%>" title='<%#GetDescription3(DataBinder.Eval(Container.DataItem, "Description"),DataBinder.Eval(Container.DataItem, "PictureID"))%>'>
																								<asp:Label ID="Label3" runat="server" Text='<%#ShowTitle(DataBinder.Eval(Container.DataItem, "Title"),DataBinder.Eval(Container.DataItem, "PictureID"))%>' Visible='<%#TitleToDisplay(Eval("Title"))%>'></asp:Label></a></h3>
																						<p>
																							<asp:Label ID="Label4" runat="server" Text='<%# ShowDescription(DataBinder.Eval(Container.DataItem, "Description"),DataBinder.Eval(Container.DataItem, "PictureID"))%>' Visible='<%#DescriptionToDisplay(Eval("Description"))%>'></asp:Label></p>
																						<a class="btnslide" href='<%=ModulePath.Replace("Controls/ImageCarousel/","")%>video.html?videourl=<%#RepVidNames(Eval("MediaType"),Eval("FileName"))%>&playerskin=<%=myappSettings.VGSkin%>&playonload=<%=myappSettings.PlayOnLoad%>&info=<%=myappSettings.InfoButton%>&description=<%#GetDescription2(DataBinder.Eval(Container.DataItem, "Description"))%>&fullscreen=<%=myappSettings.AllowFullscren%>&iframe=true<%# RepNames(Eval("MediaType"),Eval("ShortEmbedUrl"))%>'
																							rel="<%#RelLink()%>" target="<%#TargetWin()%>" title='<%#GetDescription3(DataBinder.Eval(Container.DataItem, "Description"),DataBinder.Eval(Container.DataItem, "PictureID"))%>'>
																							<%=strOpenMedia%></a></div>
																				</div>
																			</div>
																		</div>
																	</div>
																</asp:PlaceHolder>
																<asp:PlaceHolder ID="plFlashFlow" runat="server" Visible='<%# ToDisplayVideoFlow("Video",DataBinder.Eval(Container.DataItem, "Info"),DataBinder.Eval(Container.DataItem, "FileExtension"),"Flow")%>'>
																	<div class="EDGvideo">
																		<span class="leftsh"></span><span class="rightsh"></span><span class="botsh"></span><span class="topsh"></span><span class="round1"></span><span class="round2"></span><span class="round3"></span><span class="round4"></span>
																		<div class="shadowborder">
																			<div class="<%=ModulNr%> EDGboxslide EDGdesccaption">
																				<img id="img7" runat="server" alt='<%# GetAlt(Eval("Title"),Eval("PictureID")) %>' src='<%#GetThumbPath(DataBinder.Eval(Container.DataItem, "ViewerThumb")) %>' width="<%#GetImageWidthInt()%>" height="<%#GetImageHeightInt()%>" /><span class="zborder"></span>
																				<div class="<%=ModulNr%> EDGslide EDGboxcaption">
																					<div class="EDGbgrdtext">
																					</div>
																					<div class="EDGslidetext">
																						<h3>
																							<a edgpid='<%#Eval("PictureID")%>' href='<%=ModulePath.Replace("Controls/ImageCarousel/","")%>videoFlow.html?videourl=<%#RepVidNames(Eval("MediaType"),Eval("FileName"))%>&playerskin=<%=myappSettings.VGSkin%>&playonload=<%=myappSettings.PlayOnLoad%>&info=<%=myappSettings.InfoButton%>&description=<%#GetDescription2(DataBinder.Eval(Container.DataItem, "Description"))%>&fullscreen=<%=myappSettings.AllowFullscren%>&iframe=true<%# RepNamesFlow(Eval("MediaType"),Eval("ShortEmbedUrl"))%>'
																								rel="<%#RelLink()%>" target="<%#TargetWin()%>" title='<%#GetDescription3(DataBinder.Eval(Container.DataItem, "Description"),DataBinder.Eval(Container.DataItem, "PictureID"))%>'>
																								<asp:Label ID="Label13" runat="server" Text='<%#ShowTitle(DataBinder.Eval(Container.DataItem, "Title"),DataBinder.Eval(Container.DataItem, "PictureID"))%>' Visible='<%#TitleToDisplay(Eval("Title"))%>'></asp:Label></a></h3>
																						<p>
																							<asp:Label ID="Label14" runat="server" Text='<%# ShowDescription(DataBinder.Eval(Container.DataItem, "Description"),DataBinder.Eval(Container.DataItem, "PictureID"))%>' Visible='<%#DescriptionToDisplay(Eval("Description"))%>'></asp:Label></p>
																						<a class="btnslide" href='<%=ModulePath.Replace("Controls/ImageCarousel/","")%>videoFlow.html?videourl=<%#RepVidNames(Eval("MediaType"),Eval("FileName"))%>&playerskin=<%=myappSettings.VGSkin%>&playonload=<%=myappSettings.PlayOnLoad%>&info=<%=myappSettings.InfoButton%>&description=<%#GetDescription2(DataBinder.Eval(Container.DataItem, "Description"))%>&fullscreen=<%=myappSettings.AllowFullscren%>&iframe=true<%# RepNamesFlow(Eval("MediaType"),Eval("ShortEmbedUrl"))%>'
																							rel="<%#RelLink()%>" target="<%#TargetWin()%>" title='<%#GetDescription3(DataBinder.Eval(Container.DataItem, "Description"),DataBinder.Eval(Container.DataItem, "PictureID"))%>'>
																							<%=strOpenMedia%></a></div>
																				</div>
																			</div>
																		</div>
																	</div>
																</asp:PlaceHolder>
																<asp:PlaceHolder ID="plFlashMov" runat="server" Visible='<%# ToDisplayVideoFlashMov("flashmov",DataBinder.Eval(Container.DataItem, "Info"),DataBinder.Eval(Container.DataItem, "FileExtension"))%>'>
																	<div class="EDGvideo">
																		<span class="leftsh"></span><span class="rightsh"></span><span class="botsh"></span><span class="topsh"></span><span class="round1"></span><span class="round2"></span><span class="round3"></span><span class="round4"></span>
																		<div class="shadowborder">
																			<div class="<%=ModulNr%> EDGboxslide EDGdesccaption">
																				<img id="img3" runat="server" alt='<%# GetAlt(Eval("Title"),Eval("PictureID")) %>' src='<%#GetThumbPath(DataBinder.Eval(Container.DataItem, "ViewerThumb")) %>' width="<%#GetImageWidthInt()%>" height="<%#GetImageHeightInt()%>" /><span class="zborder"></span>
																				<div class="<%=ModulNr%> EDGslide EDGboxcaption">
																					<div class="EDGbgrdtext">
																					</div>
																					<div class="EDGslidetext">
																						<h3>
																							<a edgpid='<%#Eval("PictureID")%>' href='<%#Eval("Filename") %>' rel="<%#RelLink()%>" target="<%#TargetWin()%>" title='<%#GetDescription3(DataBinder.Eval(Container.DataItem, "Description"),DataBinder.Eval(Container.DataItem, "PictureID"))%>'>
																								<asp:Label ID="Label5" runat="server" Text='<%#ShowTitle(DataBinder.Eval(Container.DataItem, "Title"),DataBinder.Eval(Container.DataItem, "PictureID"))%>' Visible='<%#TitleToDisplay(Eval("Title"))%>'></asp:Label></a></h3>
																						<p>
																							<asp:Label ID="Label6" runat="server" Text='<%# ShowDescription(DataBinder.Eval(Container.DataItem, "Description"),DataBinder.Eval(Container.DataItem, "PictureID"))%>' Visible='<%#DescriptionToDisplay(Eval("Description"))%>'></asp:Label></p>
																						<a class="btnslide" href='<%#Eval("Filename") %>' rel="<%#RelLink()%>" target="<%#TargetWin()%>" title='<%#GetDescription3(DataBinder.Eval(Container.DataItem, "Description"),DataBinder.Eval(Container.DataItem, "PictureID"))%>'>
																							<%=strOpenMedia%></a></div>
																				</div>
																			</div>
																		</div>
																	</div>
																</asp:PlaceHolder>
																<asp:PlaceHolder ID="plAudio" runat="server" Visible='<%# ToDisplay("Audio",DataBinder.Eval(Container.DataItem, "MediaType"))%>'>
																	<div class="EDGaudio">
																		<span class="leftsh"></span><span class="rightsh"></span><span class="botsh"></span><span class="topsh"></span><span class="round1"></span><span class="round2"></span><span class="round3"></span><span class="round4"></span>
																		<div class="shadowborder">
																			<div class="<%=ModulNr%> EDGboxslide EDGdesccaption">
																				<img id="img4" runat="server" alt='<%# GetAlt(Eval("Title"),Eval("PictureID")) %>' src='<%#GetThumbPath(DataBinder.Eval(Container.DataItem, "ViewerThumb")) %>' width="<%#GetImageWidthInt()%>" height="<%#GetImageHeightInt()%>" /><span class="zborder"></span>
																				<div class="<%=ModulNr%> EDGslide EDGboxcaption">
																					<div class="EDGbgrdtext">
																					</div>
																					<div class="EDGslidetext">
																						<h3>
																							<a edgpid='<%#Eval("PictureID")%>' href='<%=ModulePath.Replace("Controls/ImageCarousel/","")%>audio.html?audiourl=<%#hostPath%><%#Eval("Filename")%>&autoplay=<%=myappSettings.AudioPlayOnLoad%>&iframe=true&width=500&height=37&width=500&height=37'
																								rel="<%#RelLink()%>" target="<%#TargetWin()%>" title='<%#GetDescription3(DataBinder.Eval(Container.DataItem, "Description"),DataBinder.Eval(Container.DataItem, "PictureID"))%>'>
																								<asp:Label ID="Label7" runat="server" Text='<%#ShowTitle(DataBinder.Eval(Container.DataItem, "Title"),DataBinder.Eval(Container.DataItem, "PictureID"))%>' Visible='<%#TitleToDisplay(Eval("Title"))%>'></asp:Label></a></h3>
																						<p>
																							<asp:Label ID="Label8" runat="server" Text='<%# ShowDescription(DataBinder.Eval(Container.DataItem, "Description"),DataBinder.Eval(Container.DataItem, "PictureID"))%>' Visible='<%#DescriptionToDisplay(Eval("Description"))%>'></asp:Label></p>
																						<a class="btnslide" href='<%=ModulePath.Replace("Controls/ImageCarousel/","")%>audio.html?audiourl=<%#hostPath%><%#Eval("Filename")%>&autoplay=<%=myappSettings.AudioPlayOnLoad%>&iframe=true&width=500&height=37&width=500&height=37'
																							rel="<%#RelLink()%>" target="<%#TargetWin()%>" title='<%#GetDescription3(DataBinder.Eval(Container.DataItem, "Description"),DataBinder.Eval(Container.DataItem, "PictureID"))%>'>
																							<%=strOpenMedia%></a></div>
																				</div>
																			</div>
																		</div>
																	</div>
																</asp:PlaceHolder>
																<asp:PlaceHolder ID="plHtml5Video" runat="server" Visible='<%#ToDisplayHtml5Video("Video",DataBinder.Eval(Container.DataItem, "Info"),DataBinder.Eval(Container.DataItem, "FileExtension"))%>'>
																	<div class="EDGvideo">
																		<span class="leftsh"></span><span class="rightsh"></span><span class="botsh"></span><span class="topsh"></span><span class="round1"></span><span class="round2"></span><span class="round3"></span><span class="round4"></span>
																		<div class="shadowborder">
																			<div class="<%=ModulNr%> EDGboxslide EDGdesccaption">
																				<img id="img5" runat="server" alt='<%# GetAlt(Eval("Title"),Eval("PictureID")) %>' src='<%#GetThumbPath(DataBinder.Eval(Container.DataItem, "ViewerThumb")) %>' width="<%#GetImageWidthInt()%>" height="<%#GetImageHeightInt()%>" /><span class="zborder"></span>
																				<div class="<%=ModulNr%> EDGslide EDGboxcaption">
																					<div class="EDGbgrdtext">
																					</div>
																					<div class="EDGslidetext">
																						<h3>
																							<a edgpid='<%#Eval("PictureID")%>' href='<%#Eval("Filename") %>' title='<%#GetDescription3(DataBinder.Eval(Container.DataItem, "Description"),DataBinder.Eval(Container.DataItem, "PictureID"))%>'>
																								<asp:Label ID="Label9" runat="server" Text='<%#ShowTitle(DataBinder.Eval(Container.DataItem, "Title"),DataBinder.Eval(Container.DataItem, "PictureID"))%>' Visible='<%#TitleToDisplay(Eval("Title"))%>'></asp:Label></a></h3>
																						<p>
																							<asp:Label ID="Label10" runat="server" Text='<%# ShowDescription(DataBinder.Eval(Container.DataItem, "Description"),DataBinder.Eval(Container.DataItem, "PictureID"))%>' Visible='<%#DescriptionToDisplay(Eval("Description"))%>'></asp:Label></p>
																						<a class="btnslide" href='<%#Eval("Filename") %>' title='<%#GetDescription3(DataBinder.Eval(Container.DataItem, "Description"),DataBinder.Eval(Container.DataItem, "PictureID"))%>'>
																							<%=strOpenMedia%></a></div>
																				</div>
																			</div>
																		</div>
																	</div>
																</asp:PlaceHolder>
																<asp:PlaceHolder ID="plMovHtml5" runat="server" Visible='<%# ToDisplayVideoFlashMovHtml5("flashmov",DataBinder.Eval(Container.DataItem, "Info"),DataBinder.Eval(Container.DataItem, "FileExtension"))%>'>
																	<div class="EDGvideo">
																		<span class="leftsh"></span><span class="rightsh"></span><span class="botsh"></span><span class="topsh"></span><span class="round1"></span><span class="round2"></span><span class="round3"></span><span class="round4"></span>
																		<div class="shadowborder">
																			<div class="<%=ModulNr%> EDGboxslide EDGdesccaption">
																				<img id="img6" runat="server" alt='<%# GetAlt(Eval("Title"),Eval("PictureID")) %>' src='<%#GetThumbPath(DataBinder.Eval(Container.DataItem, "ViewerThumb")) %>' width="<%#GetImageWidthInt()%>" height="<%#GetImageHeightInt()%>" /><span class="zborder"></span>
																				<div class="<%=ModulNr%> EDGslide EDGboxcaption">
																					<div class="EDGbgrdtext">
																					</div>
																					<div class="EDGslidetext">
																						<h3>
																							<a edgpid='<%#Eval("PictureID")%>' href='<%#Eval("Filename") %>' title='<%#GetDescription3(DataBinder.Eval(Container.DataItem, "Description"),DataBinder.Eval(Container.DataItem, "PictureID"))%>'>
																								<asp:Label ID="Label11" runat="server" Text='<%#ShowTitle(DataBinder.Eval(Container.DataItem, "Title"),DataBinder.Eval(Container.DataItem, "PictureID"))%>' Visible='<%#TitleToDisplay(Eval("Title"))%>'></asp:Label></a></h3>
																						<p>
																							<asp:Label ID="Label12" runat="server" Text='<%# ShowDescription(DataBinder.Eval(Container.DataItem, "Description"),DataBinder.Eval(Container.DataItem, "PictureID"))%>' Visible='<%#DescriptionToDisplay(Eval("Description"))%>'></asp:Label></p>
																						<a class="btnslide" href='<%#Eval("Filename") %>' title='<%#GetDescription3(DataBinder.Eval(Container.DataItem, "Description"),DataBinder.Eval(Container.DataItem, "PictureID"))%>'>
																							<%=strOpenMedia%></a></div>
																				</div>
																			</div>
																		</div>
																	</div>
																</asp:PlaceHolder>
															</div>
														</div>
													</ItemTemplate>
												</asp:Repeater>
											</div>
											<div class="clearfix">
											</div>
											<a class="prev<%=ModulNr%>" id='foo2_prev<%=ModulNr%>' href="#" style='visibility: <%=ShowNavigation%>'><span>prev</span></a> <a class="next<%=ModulNr%>" id='foo2_next<%=ModulNr%>' href="#" style='visibility: <%=ShowNavigation%>'><span>next</span></a>
											<div class="pagination<%=ModulNr%>" id='foo2_pag<%=ModulNr%>'>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<asp:Panel ID="pnlFullscreenlink" runat="server">
				<script type="text/javascript">
												<%=jQuery%>(document).ready(function($) 
												{
													$('#lnkFS<%=ModulNr%>').click(function() {
														$(this).fullscreenPortfolioGallery({
															ppgroup: '<%=ModulNr%>',
															pptheme: '<%=LightboxType %>',
															ppanimationSpeed: '<%=AnimSpeed%>',
															ppoverlay_gallery: <%=OverlayGallery2%>,
															ppslideshow: <%=LightBoxSlideShow%>,
															ppautoplay_slideshow: <%=LightBoxSlideShowAP%>,
															showCategories: false,
															ppLightboxTitle: '<%=myappSettings.LightboxTitle%>',
															ppLightboxDescription: '<%=myappSettings.LightboxDescription%>',
															ppMediaTitle: '<%=myappSettings.ShowMediaTitle%>',
															ppMediaDescription: '<%=myappSettings.ShowMediaDescription%>',
															pfqtip: '<%=myappSettings.LightboxDescription%>',
															pfShowQtip: '<%=myappSettings.ShowToolTips%>',
															pfdiv: '<%=ModulNr%>EasyDNNGallery',
															pfShowEffect: '<%=myappSettings.ShowEffect%>',
															pfHideEffect: '<%=myappSettings.HideEffect%>',
															pfShowDuration: '<%=myappSettings.ShowEffectDuration%>',
															pfHideDuration: '<%=myappSettings.HideEffectDuration%>',
															pfTargetPos: '<%=myappSettings.TargetPosition%>',
															pfTooltipPos: '<%=myappSettings.TooltipPosition%>',
															pfTheme: '<%=myappSettings.TooltipTheme%>',
															pfcorner: <%=myappSettings.TooltipBorder%>,
															pfradius: <%=myappSettings.TooltipRadius%>,
															pfOpenMediaUrl: '<%=myappSettings.OpenMediaUrl%>',
															pfOpenMediaTarget: '<%=myappSettings.NewWindow%>',
															itemMargin: 11,
															allText: '<%=strAll%>',
															easing: 'easeOutExpo',
															animationSpeed: 1500,
															itemsPerPage: 0,
															wavyAnimation: false,
															myshowCategories: false,
															navButtonWidth: 21,
															categorySelector: '<%=PortfolioMenuType%>',
															showNavigationArrows: <%=PortfolioShowArrows%>,
															hidableNavigationArrows: <%=PortfolioAutoHideArrows%>,
															customTitle: '<%=myappSettings.PortfolioDisplayTitle%>',
															navigationId: 'EDG_portfolio_pagination<%=ModulNr%>',
															categoriesId: 'EDG_portfolio_categories<%=ModulNr%>',
															navArrowsFile: '<%=PortfolioArrowFile%>',
															navDDMFile: '<%=ProtfolioDDMFile%>',
															xmlRequestParams: {
																GalleryType: 'ImageCarousel',
																ModuleID: '<%=ModuleId%>',
																ModulePath: '<%=baseModulePath%>',
																PortalHome: '<%=PortalHome%>',
																PortalID: '<%=PortalId %>',
																LocaleCode: '<%=localecode %>',
																SettingCheck: '4535793'
															},
															maxImgWidth: <%=myappSettings.SSImageWidth%>,
															maxImgHeight: <%=myappSettings.SSImageHeight%>,
															smartResize: true,
															fullscreenCssId: '<%=LightboxFullscreenTheme%>',
															fullscreenable: true,
															xmlSource: '<%=ModulePath.Replace("Controls/ImageCarousel/","")%>PortfolioHandler.ashx?tabid=<%=TabId%>'

														});
														return false;
													});
												});
	
				</script>
				<div style="padding: 3px 3px 0; overflow: hidden; display: inline; float: left; margin-left: 20px;">
					<a id='lnkFS<%=ModulNr%>' class="EasyDNNGallery_fullscreen_btn" href="#"><span class="icon"></span><span class="text">
						<%=ShowFullscreen%></span></a>
				</div>
			</asp:Panel>
		</div>
	</asp:Panel>
</div>
<asp:ObjectDataSource ID="odsIntegrate" TypeName="EasyDNN.Modules.EasyDNNGallery.DataAcess" runat="server" SelectMethod="GetIntegration">
	<SelectParameters>
		<asp:Parameter Name="PortalID" Type="Int32" />
		<asp:Parameter Name="ModuleID" Type="Int32" />
		<asp:Parameter Name="ArticleID" Type="Int32" />
	</SelectParameters>
</asp:ObjectDataSource>
<asp:ObjectDataSource ID="odsGetOnlyImages" runat="server" SelectMethod="GetRandomImagesFromGallerySortingLocalized" TypeName="EasyDNN.Modules.EasyDNNGallery.DataAcess" OldValuesParameterFormatString="original_{0}">
	<SelectParameters>
		<asp:Parameter Name="PortalID" Type="Int32" />
		<asp:Parameter Name="GalleryID" Type="Int32" />
		<asp:Parameter Name="isRandom" Type="Boolean" />
		<asp:Parameter Name="SortMethod" Type="String" />
		<asp:Parameter Name="SortType" Type="String" />
		<asp:Parameter Name="localeCode" Type="String" />
	</SelectParameters>
</asp:ObjectDataSource>
