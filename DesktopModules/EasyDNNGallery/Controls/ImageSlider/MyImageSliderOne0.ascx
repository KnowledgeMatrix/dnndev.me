<%@ control language="C#" autoeventwireup="true" inherits="EasyDNN.Modules.EasyDNNGallery.DesktopModules_EasyDNNGallery_Controls_ImageSliderOneControl, App_Web_imagesliderone0.ascx.57dab40b" %>
<style type="text/css">
	#<%=ModulNr%>
	{
		background:#202834 url(<%=ModulePath.Replace("Controls/ImageSlider/","")%>css/images/loading.gif) no-repeat scroll 50% 50%;
		<%=classicStyleMargin%>
		position:relative;
	}
	#<%=ModulNr%> img 
	{
		display:none;
		left:0;
		position:absolute;
		top:0;
	}
	#<%=ModulNr%> a 
	{
		border:0 none;
		display:block;
	}
	.eds_edn_qtip2_style
	{
		-moz-border-radius: <%=myappSettings.TooltipRadius%>px;
		-webkit-border-radius: <%=myappSettings.TooltipRadius%>px;
		border-radius: <%=myappSettings.TooltipRadius%>px;
		border-width: <%=myappSettings.TooltipBorder%>px;
	}
</style>
<div id="ImageSliderOne" runat="server">
	<script type="text/javascript">
<%=jQuery%>(document).ready(function($) 
{
	$('#<%=ModulNr%>').nivoSlider({
		effect:'<%=myappSettings.SliderEffect%>', 
		animSpeed:<%=myappSettings.SliderTransition%>,
		pauseTime:<%=myappSettings.SSAutoSlidePause%>,
		startSlide:<%=SliderStart%>, 
		directionNav:true, 
		directionNavHide:true, 
		controlNav:<%=myappSettings.PagingVisible%>, 
		controlNavThumbs:false, 
		controlNavThumbsFromRel:false,
		keyboardNav:true, 
		pauseOnHover:true, 
		manualAdvance:false, 
		captionOpacity:0.8 
	});
	if('<%=myappSettings.ShowToolTips.ToString().ToLower()%>'=='true') {
	if('<%=myappSettings.LightboxDescription.ToLower() %>'=='true') {
				$('#<%=ModulNr%> a, #<%=ModulNr%>EasyDNNGallery .EDGvideo a[title], #<%=ModulNr%>EasyDNNGallery .EDGaudio a[title]').qtip({
					show: {  effect: function(offset) { <%=myappSettings.ShowEffect%> } },
					hide: {  effect: function(offset) { <%=myappSettings.HideEffect%> } },
					position: { at: '<%=myappSettings.TargetPosition%>', my: '<%=myappSettings.TooltipPosition%>'},
					style: { classes: 'qtip-<%=myappSettings.TooltipTheme%> eds_edn_qtip2_style', tip: {corner: true, width: 10, height: 5}} 
		});
		}
	}
});

	</script>
	<%=classicOpenDiv%>
	<div class="<%=slideBorder%>">
		<div class="<%=slideBorder2%>" style="<%=nivoTheme%>">
			<div id="<%=ModulNr%>" style="<%=imageItemstyle%>">
				<asp:Repeater ID="repImageSlider" runat="server" DataSourceID="odsGetOnlyImages" EnableTheming="True">
					<ItemTemplate>
						<a edgpid='<%#Eval("PictureID")%>' href='<%#LinkOrLightbox(Eval("FileName"),Eval("ImageUrl"),Eval("PictureID")) %>' rel="<%#RelLink()%>" target="<%#TargetWin()%>" title='<%#GetDescription3(DataBinder.Eval(Container.DataItem, "Description"),DataBinder.Eval(Container.DataItem, "PictureID"))%>'>
							<img id="imgImageSlider" class="img-responsive" title='<%#ImageSliderTD(Eval("Title"),Eval("Description"),Eval("PictureID")) %>' runat="server" alt='<%#GetAlt(Eval("Title"),Eval("PictureID"))%>' src='<%#GetThumbPath(DataBinder.Eval(Container.DataItem, "ViewerThumb")) %>' />
						</a>
					</ItemTemplate>
				</asp:Repeater>
			</div>
		</div>
	</div>
	<%=classicCloseDiv%>
	<div style="clear: left">
	</div>
</div>
<asp:Literal ID="ltOpenImage" runat="server" EnableViewState="False" />
<asp:ObjectDataSource ID="odsIntegrate" TypeName="EasyDNN.Modules.EasyDNNGallery.DataAcess" runat="server" SelectMethod="GetIntegration">
	<SelectParameters>
		<asp:Parameter Name="PortalID" Type="Int32" />
		<asp:Parameter Name="ModuleID" Type="Int32" />
		<asp:Parameter Name="ArticleID" Type="Int32" />
	</SelectParameters>
</asp:ObjectDataSource>
<asp:ObjectDataSource ID="odsGetOnlyImages" runat="server" SelectMethod="GetOnlyRandomImagesFromGallerySortingLocalized" TypeName="EasyDNN.Modules.EasyDNNGallery.DataAcess" OldValuesParameterFormatString="original_{0}">
	<SelectParameters>
		<asp:Parameter Name="PortalID" Type="Int32" />
		<asp:Parameter Name="GalleryID" Type="Int32" />
		<asp:Parameter Name="isRandom" Type="Boolean" />
		<asp:Parameter Name="SortMethod" Type="String" />
		<asp:Parameter Name="SortType" Type="String" />
		<asp:Parameter Name="localCode" Type="String" />
	</SelectParameters>
</asp:ObjectDataSource>
