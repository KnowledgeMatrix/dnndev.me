<%@ control language="C#" autoeventwireup="true" inherits="EasyDNN.Modules.EasyDNNGallery.DesktopModules_EasyDNNGallery_Controls_SlideShow, App_Web_slideshow.ascx.dc9a219e" %>
<style type="text/css">
	.SlideshowThumbDescription
	{
		font-family: Verdana, Arial, Helvetica, sans-serif;
		font-size: 12px;
		font-weight: normal;
		text-align: center;
		margin-top: 10px;
		margin-bottom: 10px;
		color: #333333;
	}
	.SlideshowThumbTitle
	{
		text-align: center;
		font-family: Times new roman, Helvetica, sans-serif;
		font-size: 24px;
		color: #333333;
		font-weight: normal;
		font-style: normal;
		font-variant: normal;
		text-transform: uppercase;
	}
	.eds_edn_qtip2_style
	{
		-moz-border-radius: <%=myappSettings.TooltipRadius %>px;
		-webkit-border-radius: <%=myappSettings.TooltipRadius %>px;
		border-radius: <%=myappSettings.TooltipRadius %>px;
		border-width: <%=myappSettings.TooltipBorder %>px;
	}
</style>
<script type="text/javascript">

<%=jQuery%>(document).ready(function($)
{
	var showtips= '<%=myappSettings.ShowToolTips %>';
	$('#<%=ModulNr%>SlideShow .EDGimage a').each(function(){
		if($(this).attr("title").length){
		$(this).attr("pptitle", $(this).attr("title"));
		if (showtips =='False')
		{
		$('#<%=ModulNr%>SlideShow .EDGimage a').each(function(){
		if($(this).attr("title").length){
		$(this).attr("title","");
		}
		});
	}  
	}
	});

	if('<%=myappSettings.ShowToolTips%>'=='True')
   {
   if('<%=myappSettings.LightboxDescription %>'=='True')
   {
	$('#<%=ModulNr%>EasyDNNGallery .EDGimage a[title], #<%=ModulNr%>EasyDNNGallery .EDGvideo a[title], #<%=ModulNr%>EasyDNNGallery .EDGaudio a[title]').each(function() 
	{
		$(this).qtip({
					show: {  effect: function(offset) { <%=myappSettings.ShowEffect%> } },
					hide: {  effect: function(offset) { <%=myappSettings.HideEffect%> } },
					position: { at: '<%=TargetPosition%>', my: '<%=TooltipPosition%>'},
					style: { classes: 'qtip-<%=myappSettings.TooltipTheme%> eds_edn_qtip2_style', tip: {corner: true, width: 10, height: 5}} 
					});
		});
	}}
});

function pageLoad(sender, args) {
		if (args.get_isPartialLoad()) {
$(document).ready(function() 
{ 
var showtips= '<%=myappSettings.ShowToolTips %>';
	 
	$('#<%=ModulNr%>SlideShow .EDGimage a').each(function(){
	if($(this).attr("title").length){
	$(this).attr("pptitle", $(this).attr("title"));
	if (showtips =='False')
	{
	if($(this).attr("title").length){
	$(this).attr("title","");
	}
}
}
});
	
$("a[rel^='prettyPhoto']").prettyPhoto({
			animationSpeed: '<%=AnimSpeed%>',
			slideshow: <%=LightBoxSlideShow%>,
			autoplay_slideshow: <%=LightBoxSlideShowAP%>, 
			padding: 40, 
			opacity: 0.8,
			showTitle: true, 
			allowresize: true,
			hideflash: true, 
			wmode: 'opaque',
			autoplay: <%=PlayOnLoadLB%>, 
			modal: false,    
			overlay_gallery: <%=OverlayGallery%>,
			counter_separator_label: '/',
			print_image_text: '<%=PrintImageText%>',
			item_emailing_text: '<%=EmailText%>',
			item_emailing_subject: '<%=EmailTextSubject%>',
			allow_image_printing:<%=myappSettings.LightboxShowPrint.ToLower()%>,
			enable_item_emailing:<%=myappSettings.LightboxShowEmail.ToLower()%>,
			show_social_sharing:<%=myappSettings.LightboxSocialSharing.ToLower()%>,
			download_handler_url:'<%=ShowDownloadLinkLightbox %>', 
			theme: '<%=LightboxType %>', 
			callback: function() { }
				});

	if('<%=myappSettings.ShowToolTips%>'=='True')
   {
   if('<%=myappSettings.LightboxDescription %>'=='True')
   {
	$('#<%=ModulNr%>EasyDNNGallery .EDGimage a[title], #<%=ModulNr%>EasyDNNGallery .EDGvideo a[title], #<%=ModulNr%>EasyDNNGallery .EDGaudio a[title]').each(function() 
	{
		$(this).qtip({
					show: {  effect: function(offset) { <%=myappSettings.ShowEffect%> } },
					hide: {  effect: function(offset) { <%=myappSettings.HideEffect%> } },
					position: { at: '<%=TargetPosition%>', my: '<%=TooltipPosition%>'},
					style: { classes: 'qtip-<%=myappSettings.TooltipTheme%> eds_edn_qtip2_style', tip: {corner: true, width: 10, height: 5}} 
					});
		});
	}}
});
}
}
</script>
<asp:Literal ID="ltOpenImage" runat="server" EnableViewState="False"></asp:Literal>
<div id="<%=ModulNr%>SlideShow">
	<asp:UpdatePanel ID="upSlideShow" runat="server">
		<ContentTemplate>
			<div id="<%=CssClass%>">
				<div class="EDGbackground">
					<div class="EDGcontentbgrd">
						<div class="EDGcornerbotleft">
							<div class="EDGcornerbotright">
								<div class="EDGcornertopleft">
									<div class="EDGcornertopright">
										<div class="EDGcontent">
											<div class="EDGTitle">
												<asp:Label ID="lblSSTitle" runat="server" CssClass="EDGTitleText"></asp:Label>
												<br />
												<asp:Label ID="lblSSTDescription" runat="server" CssClass="SlideshowDescription"></asp:Label></div>
											<asp:DetailsView ID="dvImageSlideShow" runat="server" AllowPaging="True" AutoGenerateRows="False" DataKeyNames="PictureID" DataSourceID="odsGetOnlyImages" GridLines="None" OnDataBound="dvImageSlideShow_DataBound" OnItemCreated="dvImageSlideShow_ItemCreated"
												PagerStyle-CssClass="EDGpager" RowStyle-HorizontalAlign="Center" HorizontalAlign="Center" PagerStyle-HorizontalAlign="Center">
												<RowStyle HorizontalAlign="Center" />
												<PagerStyle CssClass="EDGpager" HorizontalAlign="Center" />
												<Fields>
													<asp:TemplateField ItemStyle-HorizontalAlign="Center">
														<ItemTemplate>
															<table cellpadding="0" cellspacing="0" align="center">
																<tr>
																	<td>
																		<div class="EDGSlide">
																			<div class="EDGimage">
																				<a edgpid='<%#Eval("PictureID")%>' edgmid='<%=ModuleIDNR%>' href='<%#LinkOrLightbox(Eval("FileName"),Eval("ImageUrl"),Eval("PictureID")) %>' target="<%#TargetWin()%>" title='<%#GetDescription3(DataBinder.Eval(Container.DataItem, "Description"),DataBinder.Eval(Container.DataItem, "PictureID"))%>'
																					rel="<%=RelLink()%>">
																					<img id="Image1" runat="server" alt='<%#GetAlt(Eval("Title"),Eval("PictureID"))%>' src='<%#GetThumbPath(DataBinder.Eval(Container.DataItem, "ViewerThumb")) %>' />
																					<span class="leftsh"></span><span class="rightsh"></span><span class="botsh"></span><span class="topsh"></span><span class="round1"></span><span class="round2"></span><span class="round3"></span><span class="round4"></span><span class='<%#TitleClass(DataBinder.Eval(Container.DataItem, "Title"),DataBinder.Eval(Container.DataItem, "Description"))%>'>
																						<asp:Label ID="lblSSMediaTitle" runat="server" Text='<%#ShowTitle(DataBinder.Eval(Container.DataItem, "Title"),DataBinder.Eval(Container.DataItem, "PictureID"))%>'></asp:Label>
																						<asp:Label ID="lblSSMediaDescription" runat="server" Text='<%# ShowDescription(DataBinder.Eval(Container.DataItem, "Description"),DataBinder.Eval(Container.DataItem, "PictureID"))%>' CssClass="Description" Style="display: block"></asp:Label>
																					</span></a>
																			</div>
																		</div>
																	</td>
																</tr>
															</table>
														</ItemTemplate>
														<ItemStyle HorizontalAlign="Center" />
													</asp:TemplateField>
												</Fields>
											</asp:DetailsView>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<asp:Timer ID="Timer1" runat="server" Interval="3000" OnTick="Timer1_Tick" Enabled="False">
			</asp:Timer>
		</ContentTemplate>
	</asp:UpdatePanel>
</div>
<asp:ObjectDataSource ID="odsGetOnlyImages" runat="server" TypeName="EasyDNN.Modules.EasyDNNGallery.DataAcess" SelectMethod="GetOnlyRandomImagesFromGallerySortingLocalized">
	<SelectParameters>
		<asp:Parameter Name="PortalID" Type="Int32" />
		<asp:Parameter Name="GalleryID" Type="Int32" />
		<asp:Parameter Name="isRandom" Type="Boolean" />
		<asp:Parameter Name="SortMethod" Type="String" />
		<asp:Parameter Name="SortType" Type="String" />
		<asp:Parameter Name="localCode" Type="String" />
	</SelectParameters>
</asp:ObjectDataSource>
<asp:ObjectDataSource ID="odsIntegrate" TypeName="EasyDNN.Modules.EasyDNNGallery.DataAcess" runat="server" SelectMethod="GetIntegration">
	<SelectParameters>
		<asp:Parameter Name="PortalID" Type="Int32" />
		<asp:Parameter Name="ModuleID" Type="Int32" />
		<asp:Parameter Name="ArticleID" Type="Int32" />
	</SelectParameters>
</asp:ObjectDataSource>
