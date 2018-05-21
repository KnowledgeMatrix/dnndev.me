<%@ control language="C#" autoeventwireup="true" inherits="EasyDNN.Modules.EasyDNNGallery.DesktopModules_EasyDNNGallery_Controls_SSThumbnails3Control, App_Web_ssthumbnails30_1.ascx.b927f30d" %>
<style type="text/css">
	.contentgalleria
	{
		color: #eee;
		font: 14px/1.4 "helvetica neue" , arial,sans-serif;
		width: <%=contentWidth%>
		margin: 20px auto;
	}
	.galleria-container
	{
		position: relative;
		overflow: hidden;
		background: #<%=myappSettings.BorderColor%>;
	}
	.fullscreenLink
	{
		background: #<%=myappSettings.BorderColor%>;
	}
	h1
	{
		line-height: 1.1;
		letter-spacing: -1px;
	}
	a
	{
		color: #fff;
	}
	#galleria
	{
		<%=galleriaDim%>
	}
</style>
<asp:Literal ID="ltOpenImage" runat="server" EnableViewState="False"></asp:Literal>
<table cellpadding="0" cellspacing="0" align="center" style="<%=cssStyle%>">
	<tr>
		<td>
			<div id="SlideShowThumbnails" runat="server" style="<%=cssStyle%>">
				<div class="contentgalleria">
					<div id="galleria">
						<asp:Repeater ID="repImageSlider" runat="server" DataSourceID="odsGetOnlyImages" EnableTheming="True" EnableViewState="False">
							<ItemTemplate>
								<img id="imgImageSlider" style="width:100%" runat="server" alt='' src='<%#GetThumbPath(DataBinder.Eval(Container.DataItem, "ViewerThumb")) %>' title='<%#ImageSliderTD(Eval("Title"),Eval("Description"),Eval("PictureID")) %>' />
							</ItemTemplate>
						</asp:Repeater>
					</div>
					<div id="GalleriaFullscreen" runat="server" class="fullscreenLink" style="padding: 5px;">
						<asp:Panel ID="pnlFullscreen" runat="server">
							<img id="imgFullScreen" alt='<%#Eval("Title")%>' src='<%=ModulePath.Replace("Controls/SSThumbnails3/","images/")%>fullscreen.png' />
							<a id="g_fullscreen" href="#">
								<%=strFullScreen%></a>
						</asp:Panel>
					</div>
				</div>
			</div>
		</td>
	</tr>
</table>
<script type="text/javascript">
					<%=jQuery%>(document).ready(function($) {
						Galleria.loadTheme('<%=ModulePath.Replace("Controls/SSThumbnails3/","")%>js/galleria.<%=myappSettings.StartPhoto%>.js');
						$('#galleria').galleria({
							transition: '<%=myappSettings.SliderEffect%>',
							transition_speed: <%=myappSettings.SSAutoSlidePause%>,
							image_crop: '<%=myappSettings.SmartCrop.ToLower()%>',
							autoplay: <%=myappSettings.SSAutoSlide.ToLower()%>,
							height: <%=galHeight%>,
							width:'<%=galWidth%>',
							keepSource: true,
							responsive: true,
							extend: function() { 
								var mygallery = this;
								$('#g_fullscreen').click(function()
										{
											mygallery.enterFullscreen();
										});
								}
						});
					});
</script>
<asp:ObjectDataSource ID="odsIntegrate" TypeName="EasyDNN.Modules.EasyDNNGallery.DataAcess" runat="server" SelectMethod="GetIntegration">
	<SelectParameters>
		<asp:Parameter Name="PortalID" Type="Int32" />
		<asp:Parameter Name="ModuleID" Type="Int32" />
		<asp:Parameter Name="ArticleID" Type="Int32" />
	</SelectParameters>
</asp:ObjectDataSource>
<asp:ObjectDataSource ID="odsGetOnlyImages" runat="server" SelectMethod="GetOnlyRandomImagesFromGallerySortingLocalized" TypeName="EasyDNN.Modules.EasyDNNGallery.DataAcess">
	<SelectParameters>
		<asp:Parameter Name="PortalID" Type="Int32" />
		<asp:Parameter Name="GalleryID" Type="Int32" />
		<asp:Parameter Name="isRandom" Type="Boolean" />
		<asp:Parameter Name="SortMethod" Type="String" />
		<asp:Parameter Name="SortType" Type="String" />
		<asp:Parameter Name="localCode" Type="String" />
	</SelectParameters>
</asp:ObjectDataSource>
