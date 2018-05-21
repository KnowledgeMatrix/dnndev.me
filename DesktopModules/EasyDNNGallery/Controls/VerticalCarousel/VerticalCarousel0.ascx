<%@ control language="C#" autoeventwireup="true" inherits="EasyDNN.Modules.EasyDNNGallery.DesktopModules_EasyDNNGallery_Controls_VerticalCarouselControl, App_Web_verticalcarousel0.ascx.e03001a3" %>
<style type="text/css">
		.image_carousel
		{
			padding: 15px 0px 15px 0px;
			position: relative;
		}
		.image_carousel img
		{
			border: 1px solid #ccc;
			background-color: white;
			padding: 0px;
			margin: 0px;
			display: block;
			float: left;
		}
		a.prev<%=ModulNr%>, a.next<%=ModulNr%> 
		{
			background: url(<%=ModulePath.Replace("Controls/VerticalCarousel/","")%>css/images/miscellaneous_sprite.png) 0 0 no-repeat transparent;
			width: 45px;
			height: 45px;
			display: block;
			position: absolute;
			top: <%=intmiddle%>px;
			z-index: 150;
		}
		a.prev<%=ModulNr%> 
			{
				left: -22px;
			}		
		a.prev<%=ModulNr%>:hover
			{
				background-position: 0 -50px;
			}
		a.next<%=ModulNr%> 
			{
				right: -12px;
				background-position: -50px 0;
			}
		a.next<%=ModulNr%>:hover 
			{
				background-position: -50px -50px;
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
				background: url(<%=ModulePath.Replace("Controls/VerticalCarousel/","")%>css/images/miscellaneous_sprite.png) 0 -100px no-repeat transparent;
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
		.clearfix
			{
				float: none;
				clear: both;
			}
		.html_carousel<%=ModulNr%> 
			 {
				padding: 15px 0 15px 40px;
			 }
			 
		.html_carousel<%=ModulNr%> div.slide 
			{
				width: <%=myappSettings.SSImageWidth%>px;
				height: <%=myappSettings.SSImageHeight%>px;
				position: relative;
			}
		.html_carousel<%=ModulNr%> div.slide div 
			{
				background-color: #000;
				width: <%=myappSettings.SSImageWidth%>px;
				display: none;
				position: absolute;
				bottom: 0;
					filter:alpha(opacity=65);
				opacity:.8;
				-ms-filter: "progid:DXImageTransform.Microsoft.Alpha(Opacity=65)";
			}
		.html_carousel<%=ModulNr%> div.slide h4 
			{
				font-size: 20px!important;
				padding: 20px 0 0 20px;
			}
		.html_carousel<%=ModulNr%> div.slide p 
			{
				font-size: 16px!important;
				padding: 0 0 20px 20px;
			}
		.html_carousel<%=ModulNr%> div.slide h4 
			{
				color: white!important;
				margin: 0;
			}
		.html_carousel<%=ModulNr%> div.slide p 
			{
				color: white!important;
				margin: 0;
			}
		#IC<%=ModulNr%>
			{
				overflow: hidden;
			}
		#IC<%=ModulNr%> .slide
			{
			visibility:hidden;
			}
		.html_carousel<%=ModulNr%>
			{
			height:0px;
			overflow:hidden;
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
		$.each($.browser, function (i) {
		if ($.browser.msie && $.browser.version < "8.0") {
			$('#IC<%=ModulNr%> .slide').css('visibility', 'visible');
			$('.html_carousel<%=ModulNr%>').css('overflow', 'visible');
			$('.html_carousel<%=ModulNr%>').css('height', 'auto');}
			});
			$('#IC<%=ModulNr%>').carouFredSel({  
			direction   : '<%=myappSettings.SliderEffect %>',
			auto : <%=myappSettings.SSAutoSlideRandom%>,			auto : {
					play:<%=myappSettings.SSAutoSlideRandom%>,
					timeoutDuration : <%=myappSettings.SSAutoSlidePause%>,
					pauseOnHover	: true,
					onAfter : function(oldItems, newItems)
					{
						$(oldItems).find("> div").hide();
						$(newItems).find("> div").slideDown();
					}
					},
			responsive: false,
			width: <%=containerWidth%>,
			items	: 1,
			scroll	: {
						items : 1
					  }
			}).find(".slide:first > div").show();
			$('#IC<%=ModulNr%> .slide').css('visibility', 'visible');
			$('.html_carousel<%=ModulNr%>').css('overflow', 'visible');
			$('.html_carousel<%=ModulNr%>').css('height', 'auto');
			if( <%=containerWidth%> != '100%'){
			$("#IC<%=ModulNr%>").trigger("configuration", ["width", function( val ) {
				$("#IC<%=ModulNr%>").parents().eq(1).width(val);
			}]);}
			if('<%=myappSettings.ShowToolTips %>'=='True')
			{
				if('<%=myappSettings.LightboxDescription %>'=='True')
				{
					$('#IC<%=ModulNr%> .slide a[title], #<%=ModulNr%>EasyDNNGallery .EDGvideo a[title], #<%=ModulNr%>EasyDNNGallery .EDGaudio a[title]').each(function() // Select all elements with the "tooltip" attribute
					{
						if($(this).attr("title").length>0)
						{
							$(this).qtip({
									show: {  effect: function(offset) { <%=myappSettings.ShowEffect%> } },
									hide: {  effect: function(offset) { <%=myappSettings.HideEffect%> } },
									position: { at: '<%=myappSettings.TargetPosition%>', my: '<%=myappSettings.TooltipPosition%>'},
									style: { classes: 'qtip-<%=myappSettings.TooltipTheme%> eds_edn_qtip2_style', tip: {corner: true, width: 10, height: 5}} 
									});
						}
					}
					);
			}}
	});
</script>
<asp:Literal ID="ltOpenImage" runat="server" EnableViewState="False" />
<div id="VerticalCarousel" runat="server">
	<asp:Panel ID="pnlVerticalCarousel" runat="server">
		<div class="html_carousel<%=ModulNr%>" style="margin: 0 auto;">
			<div id='IC<%=ModulNr%>'>
				<asp:Repeater ID="repImageCarousel" runat="server" DataSourceID="odsGetOnlyImages" EnableViewState="False">
					<ItemTemplate>
						<div class="slide">
							<asp:PlaceHolder ID="plImage" runat="server" Visible='<%# ToDisplay("Image",DataBinder.Eval(Container.DataItem, "MediaType"))%>'><a edgpid='<%#Eval("PictureID")%>' href='<%#LinkOrLightbox(Eval("FileName"),Eval("ImageUrl"),Eval("PictureID")) %>' rel="<%#RelLink()%>"
								target="<%#TargetWin()%>" title='<%#GetDescription3(DataBinder.Eval(Container.DataItem, "Description"),DataBinder.Eval(Container.DataItem, "PictureID"))%>'>
								<img id="imgImageSlider" runat="server" alt='<%# GetAlt(Eval("Title"),Eval("PictureID")) %>' width="<%#GetImageWidthInt()%>" height="<%#GetImageHeightInt()%>" src='<%#GetThumbPath(DataBinder.Eval(Container.DataItem, "ViewerThumb")) %>' border="0" /></a>
								<div>
									<h4>
										<asp:Label ID="lblTGNGTitle" runat="server" Text='<%#ShowTitle(DataBinder.Eval(Container.DataItem, "Title"),DataBinder.Eval(Container.DataItem, "PictureID"))%>' Visible='<%#TitleToDisplay(Eval("Title"))%>'></asp:Label>
									</h4>
									<p>
										<asp:Label ID="lblTGNGDescription" runat="server" CssClass="Description" Text='<%# ShowDescription(DataBinder.Eval(Container.DataItem, "Description"),DataBinder.Eval(Container.DataItem, "PictureID"))%>' Visible='<%#DescriptionToDisplay(Eval("Description"))%>'></asp:Label>
									</p>
								</div>
							</asp:PlaceHolder>
							<asp:PlaceHolder ID="plEmbed" runat="server" Visible='<%# ToDisplay("Embeded Video",DataBinder.Eval(Container.DataItem, "MediaType"))%>'><a edgpid='<%#Eval("PictureID")%>' href='<%#FixVimeo(Eval("ShortEmbedUrl"),GetLightBoxSize(DataBinder.Eval(Container.DataItem, "Info"),DataBinder.Eval(Container.DataItem, "Filename")))%>'
								rel="<%#RelLink()%>" target="<%#TargetWin()%>" title='<%#GetDescription3(DataBinder.Eval(Container.DataItem, "Description"),DataBinder.Eval(Container.DataItem, "PictureID"))%>'>
								<img id="img1" runat="server" alt='<%# GetAlt(Eval("Title"),Eval("PictureID")) %>' width="<%#GetImageWidthInt()%>" height="<%#GetImageHeightInt()%>" src='<%#GetThumbPath(DataBinder.Eval(Container.DataItem, "ViewerThumb"),DataBinder.Eval(Container.DataItem, "PictureID"))%>'
									border="0" />
							</a>
								<div>
									<h4>
										<asp:Label ID="Label1" runat="server" Text='<%#ShowTitle(DataBinder.Eval(Container.DataItem, "Title"),DataBinder.Eval(Container.DataItem, "PictureID"))%>' Visible='<%#TitleToDisplay(Eval("Title"))%>'></asp:Label>
									</h4>
									<p>
										<asp:Label ID="Label2" runat="server" CssClass="Description" Text='<%# ShowDescription(DataBinder.Eval(Container.DataItem, "Description"),DataBinder.Eval(Container.DataItem, "PictureID"))%>' Visible='<%#DescriptionToDisplay(Eval("Description"))%>'></asp:Label>
									</p>
								</div>
							</asp:PlaceHolder>
							<asp:PlaceHolder ID="plFlash" runat="server" Visible='<%# ToDisplayVideoFlow("Video",DataBinder.Eval(Container.DataItem, "Info"),DataBinder.Eval(Container.DataItem, "FileExtension"),"Normal")%>'><a edgpid='<%#Eval("PictureID")%>' href='<%=ModulePath.Replace("Controls/VerticalCarousel/","")%>video.html?videourl=<%#RepVidNames(Eval("MediaType"),Eval("FileName"))%>&playerskin=<%=myappSettings.VGSkin%>&playonload=<%=PlayOnLoad%>&info=<%=Info%>&description=<%#GetDescription2(DataBinder.Eval(Container.DataItem, "Description"))%>&fullscreen=<%=AllowFullscren%>&iframe=true<%# RepNames(Eval("MediaType"),Eval("ShortEmbedUrl"))%>'
								rel="<%#RelLink()%>" target="<%#TargetWin()%>" title='<%#GetDescription3(DataBinder.Eval(Container.DataItem, "Description"),DataBinder.Eval(Container.DataItem, "PictureID"))%>'>
								<img id="img2" runat="server" alt='<%# GetAlt(Eval("Title"),Eval("PictureID")) %>' width="<%#GetImageWidthInt()%>" height="<%#GetImageHeightInt()%>" src='<%#GetThumbPath(DataBinder.Eval(Container.DataItem, "ViewerThumb"),DataBinder.Eval(Container.DataItem, "PictureID"))%>'
									border="0" />
							</a>
								<div>
									<h4>
										<asp:Label ID="Label3" runat="server" Text='<%#ShowTitle(DataBinder.Eval(Container.DataItem, "Title"),DataBinder.Eval(Container.DataItem, "PictureID"))%>' Visible='<%#TitleToDisplay(Eval("Title"))%>'></asp:Label>
									</h4>
									<p>
										<asp:Label ID="Label4" runat="server" CssClass="Description" Text='<%# ShowDescription(DataBinder.Eval(Container.DataItem, "Description"),DataBinder.Eval(Container.DataItem, "PictureID"))%>' Visible='<%#DescriptionToDisplay(Eval("Description"))%>'></asp:Label>
									</p>
								</div>
							</asp:PlaceHolder>
							<asp:PlaceHolder ID="plFlashFlow" runat="server" Visible='<%# ToDisplayVideoFlow("Video",DataBinder.Eval(Container.DataItem, "Info"),DataBinder.Eval(Container.DataItem, "FileExtension"),"Flow")%>'><a edgpid='<%#Eval("PictureID")%>' href='<%=ModulePath.Replace("Controls/VerticalCarousel/","")%>videoFlow.html?videourl=<%#RepVidNames(Eval("MediaType"),Eval("FileName"))%>&playerskin=<%=myappSettings.VGSkin%>&playonload=<%=PlayOnLoad%>&info=<%=Info%>&description=<%#GetDescription2(DataBinder.Eval(Container.DataItem, "Description"))%>&fullscreen=<%=AllowFullscren%>&iframe=true<%# RepNamesFlow(Eval("MediaType"),Eval("ShortEmbedUrl"))%>'
								rel="<%#RelLink()%>" target="<%#TargetWin()%>" title='<%#GetDescription3(DataBinder.Eval(Container.DataItem, "Description"),DataBinder.Eval(Container.DataItem, "PictureID"))%>'>
								<img id="img7" runat="server" alt='<%# GetAlt(Eval("Title"),Eval("PictureID")) %>' width="<%#GetImageWidthInt()%>" height="<%#GetImageHeightInt()%>" src='<%#GetThumbPath(DataBinder.Eval(Container.DataItem, "ViewerThumb"),DataBinder.Eval(Container.DataItem, "PictureID"))%>'
									border="0" />
							</a>
								<div>
									<h4>
										<asp:Label ID="Label13" runat="server" Text='<%#ShowTitle(DataBinder.Eval(Container.DataItem, "Title"),DataBinder.Eval(Container.DataItem, "PictureID"))%>' Visible='<%#TitleToDisplay(Eval("Title"))%>'></asp:Label>
									</h4>
									<p>
										<asp:Label ID="Label14" runat="server" CssClass="Description" Text='<%# ShowDescription(DataBinder.Eval(Container.DataItem, "Description"),DataBinder.Eval(Container.DataItem, "PictureID"))%>' Visible='<%#DescriptionToDisplay(Eval("Description"))%>'></asp:Label>
									</p>
								</div>
							</asp:PlaceHolder>
							<asp:PlaceHolder ID="plFlashMov" runat="server" Visible='<%# ToDisplayVideoFlashMov("flashmov",DataBinder.Eval(Container.DataItem, "Info"),DataBinder.Eval(Container.DataItem, "FileExtension"))%>'><a edgpid='<%#Eval("PictureID")%>' href='<%#Eval("Filename") %>'
								rel="<%#RelLink()%>" target="<%#TargetWin()%>" title='<%#GetDescription3(DataBinder.Eval(Container.DataItem, "Description"),DataBinder.Eval(Container.DataItem, "PictureID"))%>'>
								<img id="img3" runat="server" alt='<%# GetAlt(Eval("Title"),Eval("PictureID")) %>' width="<%#GetImageWidthInt()%>" height="<%#GetImageHeightInt()%>" src='<%#GetThumbPath(DataBinder.Eval(Container.DataItem, "ViewerThumb"),DataBinder.Eval(Container.DataItem, "PictureID"))%>'
									border="0" />
							</a>
								<div>
									<h4>
										<asp:Label ID="Label5" runat="server" Text='<%#ShowTitle(DataBinder.Eval(Container.DataItem, "Title"),DataBinder.Eval(Container.DataItem, "PictureID"))%>' Visible='<%#TitleToDisplay(Eval("Title"))%>'></asp:Label>
									</h4>
									<p>
										<asp:Label ID="Label6" runat="server" CssClass="Description" Text='<%# ShowDescription(DataBinder.Eval(Container.DataItem, "Description"),DataBinder.Eval(Container.DataItem, "PictureID"))%>' Visible='<%#DescriptionToDisplay(Eval("Description"))%>'></asp:Label>
									</p>
								</div>
							</asp:PlaceHolder>
							<asp:PlaceHolder ID="plAudio" runat="server" Visible='<%# ToDisplay("Audio",DataBinder.Eval(Container.DataItem, "MediaType"))%>'><a edgpid='<%#Eval("PictureID")%>' href='<%=ModulePath.Replace("Controls/VerticalCarousel/","")%>audio.html?audiourl=<%#hostPath%><%#Eval("Filename")%>&autoplay=<%=myappSettings.AudioPlayOnLoad%>&iframe=true&width=500&height=37&width=500&height=37'
								rel="<%#RelLink()%>" target="<%#TargetWin()%>" title='<%#GetDescription3(DataBinder.Eval(Container.DataItem, "Description"),DataBinder.Eval(Container.DataItem, "PictureID"))%>'>
								<img id="img4" runat="server" alt='<%# GetAlt(Eval("Title"),Eval("PictureID")) %>' width="<%#GetImageWidthInt()%>" height="<%#GetImageHeightInt()%>" src='<%#GetThumbPath(DataBinder.Eval(Container.DataItem, "ViewerThumb"),DataBinder.Eval(Container.DataItem, "PictureID"))%>'
									border="0" />
							</a>
								<div>
									<h4>
										<asp:Label ID="Label7" runat="server" Text='<%#ShowTitle(DataBinder.Eval(Container.DataItem, "Title"),DataBinder.Eval(Container.DataItem, "PictureID"))%>' Visible='<%#TitleToDisplay(Eval("Title"))%>'></asp:Label>
									</h4>
									<p>
										<asp:Label ID="Label8" runat="server" CssClass="Description" Text='<%# ShowDescription(DataBinder.Eval(Container.DataItem, "Description"),DataBinder.Eval(Container.DataItem, "PictureID"))%>' Visible='<%#DescriptionToDisplay(Eval("Description"))%>'></asp:Label>
									</p>
								</div>
							</asp:PlaceHolder>
							<asp:PlaceHolder ID="plHtml5Video" runat="server" Visible='<%#ToDisplayHtml5Video("Video",DataBinder.Eval(Container.DataItem, "Info"),DataBinder.Eval(Container.DataItem, "FileExtension"))%>'><a edgpid='<%#Eval("PictureID")%>' href='<%#Eval("Filename") %>'
								title='<%#GetDescription3(DataBinder.Eval(Container.DataItem, "Description"),DataBinder.Eval(Container.DataItem, "PictureID"))%>'>
								<img id="img5" runat="server" alt='<%# GetAlt(Eval("Title"),Eval("PictureID")) %>' width="<%#GetImageWidthInt()%>" height="<%#GetImageHeightInt()%>" src='<%#GetThumbPath(DataBinder.Eval(Container.DataItem, "ViewerThumb")) %>' border="0" /></a>
								<div>
									<h4>
										<asp:Label ID="Label9" runat="server" Text='<%#ShowTitle(DataBinder.Eval(Container.DataItem, "Title"),DataBinder.Eval(Container.DataItem, "PictureID"))%>' Visible='<%#TitleToDisplay(Eval("Title"))%>'></asp:Label>
									</h4>
									<p>
										<asp:Label ID="Label10" runat="server" CssClass="Description" Text='<%# ShowDescription(DataBinder.Eval(Container.DataItem, "Description"),DataBinder.Eval(Container.DataItem, "PictureID"))%>' Visible='<%#DescriptionToDisplay(Eval("Description"))%>'></asp:Label>
									</p>
								</div>
							</asp:PlaceHolder>
							<asp:PlaceHolder ID="plMovHtml5" runat="server" Visible='<%# ToDisplayVideoFlashMovHtml5("flashmov",DataBinder.Eval(Container.DataItem, "Info"),DataBinder.Eval(Container.DataItem, "FileExtension"))%>'><a edgpid='<%#Eval("PictureID")%>' href='<%#Eval("Filename") %>'
								title='<%#GetDescription3(DataBinder.Eval(Container.DataItem, "Description"),DataBinder.Eval(Container.DataItem, "PictureID"))%>'>
								<img id="img6" runat="server" alt='<%# GetAlt(Eval("Title"),Eval("PictureID")) %>' width="<%#GetImageWidthInt()%>" height="<%#GetImageHeightInt()%>" src='<%#GetThumbPath(DataBinder.Eval(Container.DataItem, "ViewerThumb")) %>' border="0" /></a>
								<div>
									<h4>
										<asp:Label ID="Label11" runat="server" Text='<%#ShowTitle(DataBinder.Eval(Container.DataItem, "Title"),DataBinder.Eval(Container.DataItem, "PictureID"))%>' Visible='<%#TitleToDisplay(Eval("Title"))%>'></asp:Label>
									</h4>
									<p>
										<asp:Label ID="Label12" runat="server" CssClass="Description" Text='<%# ShowDescription(DataBinder.Eval(Container.DataItem, "Description"),DataBinder.Eval(Container.DataItem, "PictureID"))%>' Visible='<%#DescriptionToDisplay(Eval("Description"))%>'></asp:Label>
									</p>
								</div>
							</asp:PlaceHolder>
						</div>
					</ItemTemplate>
				</asp:Repeater>
			</div>
			<div class="clearfix">
			</div>
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
