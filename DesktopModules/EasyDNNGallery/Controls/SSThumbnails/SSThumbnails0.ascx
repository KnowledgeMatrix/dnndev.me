<%@ control language="C#" autoeventwireup="true" inherits="EasyDNN.Modules.EasyDNNGallery.DesktopModules_EasyDNNGallery_Controls_SSThumbnailsControl, App_Web_ssthumbnails0.ascx.b91af30d" %>
<style type="text/css">
	.eds_edn_qtip2_style
	{
		-moz-border-radius: <%=myappSettings.TooltipRadius%>px;
		-webkit-border-radius: <%=myappSettings.TooltipRadius%>px;
		border-radius: <%=myappSettings.TooltipRadius%>px;
		border-width: <%=myappSettings.TooltipBorder%>px;
	}
</style>
<asp:Literal ID="ltOpenImage" runat="server" EnableViewState="False"></asp:Literal>
<div id="SSThumbnails">
	<asp:Panel ID="pnlSSthumbs" runat="server">
		<script type="text/javascript">
		<%=jQuery%>(document).ready(function($) {
			$('#<%=ModulNr %>').galleryView({
				panel_width: <%=myappSettings.SSImageWidth%>,
				panel_height: <%=myappSettings.SSImageHeight%>,
				frame_width: <%=myappSettings.SSThumbImageWidth%>,
				frame_height: <%=myappSettings.SSThumbImageHeight%>,
				overlay_height: <%=myappSettings.OverlaySize%>,
				overlay_position: '<%=myappSettings.OverlayPosition%>',
				overlay_opacity: <%=myappSettings.OverlayOpacity%>,
				overlay_text_color: '#<%=myappSettings.OverlayTextColor%>',
				overlay_color:'#<%=OverlayColor%>',
				transition_speed: <%=myappSettings.TransitionSpeed%>,
				transition_interval: <%=myappSettings.TransitionInterval%>,
				border: '<%=BorderSize%>px solid #<%=BorderColor%>',
				nav_theme: 'light',
				filmstrip_size: <%=myappSettings.FilmStripSize%>,
				filmstrip_position: '<%=myappSettings.ThumbnailPosition%>',
				panels_background:'#<%=myappSettings.SSTNMainPanelBackColor%>',
				background_color:'#<%=myappSettings.SSTNFimStripBackColor%>',
				ttn: <%=myappSettings.FlashGalTheme%>,
				pause_on_hover: true
			});

			if('<%=myappSettings.ShowToolTips %>'=='True')
				{
				if('<%=myappSettings.LightboxDescription %>'=='True')
				{
					$('#<%=ModulNr%>EasyDNNGallery .panel a[title], #<%=ModulNr%>EasyDNNGallery .EDGvideo a[title], #<%=ModulNr%>EasyDNNGallery .EDGaudio a[title]').each(function()
					{
					$(this).qtip({
					show: {  effect: function(offset) { <%=myappSettings.ShowEffect%> } },
					hide: {  effect: function(offset) { <%=myappSettings.HideEffect%> } },
					position: { at: '<%=myappSettings.TargetPosition%>', my: '<%=myappSettings.TooltipPosition%>'},
					style: { classes: 'qtip-<%=myappSettings.TooltipTheme%> eds_edn_qtip2_style', tip: {corner: true, width: 10, height: 5}} 
					});
				}
				);
				}
				}
		});
		</script>
		<table align="center" cellpadding="0" cellspacing="0">
			<tr>
				<td align="center">
					<div style="text-align: center;">
						<asp:Label ID="lblSSTBGalleryTitle" runat="server" Visible="False" Style="display: block; font-weight: bold; margin-bottom: 5px; font-size: large;"></asp:Label>
						<asp:Label ID="lblSSTBGalleryDescription" runat="server" Style="margin-bottom: 10px; display: block; font-size: medium;"></asp:Label>
					</div>
					<div id='<%=ModulNr %>' align="center" class="galleryview">
						<asp:Repeater ID="Repeater2" runat="server" OnItemCreated="Repeater2_ItemCreated" Visible="<%# ToDisplaySSBN() %>">
							<ItemTemplate>
								<div class="panel" style="background-color: #000000">
									<a edgpid='<%#Eval("PictureID")%>' href='<%#LinkOrLightbox(Eval("FileName"),Eval("ImageUrl"),Eval("PictureID"))%>' rel="<%#RelLink()%>" target="<%#TargetWin()%>" title='<%#GetDescription3(DataBinder.Eval(Container.DataItem, "Description"),DataBinder.Eval(Container.DataItem, "PictureID"))%>'>
										<asp:Image ID="imgSlideImage" alt='<%#GetAlt(Eval("Title"),Eval("PictureID"))%>' runat="server" ImageUrl='<%#GetThumbPath(DataBinder.Eval(Container.DataItem, "ShortEmbedUrl")) %>' />
									</a>
									<div class="panel-overlay" style="display: <%#IsOverlayVisible(Eval("Title"),Eval("Description"))%>">
										<b>
											<asp:Label ID="lblSSTNMediaTitle" runat="server" Text='<%#ShowTitle(DataBinder.Eval(Container.DataItem, "Title"),DataBinder.Eval(Container.DataItem, "PictureID"))%>'></asp:Label>
										</b>
										<br />
										<asp:Label ID="lblSSTNMediaDescription" runat="server" Text='<%# ShowDescription(DataBinder.Eval(Container.DataItem, "Description"),DataBinder.Eval(Container.DataItem, "PictureID"))%>'></asp:Label>
									</div>
								</div>
							</ItemTemplate>
						</asp:Repeater>
						<ul id='FS<%=ModulNr%>' class="filmstrip">
							<asp:Repeater ID="repThumbs" runat="server" Visible="<%# ToDisplayFilmStrip() %>">
								<ItemTemplate>
									<li>
										<asp:Image ID="imgThumbImage" runat="server" alt='<%#Eval("Title")%>' ImageUrl='<%#GetThumbPath(DataBinder.Eval(Container.DataItem, "ViewerThumb")) %>' />
									</li>
								</ItemTemplate>
							</asp:Repeater>
						</ul>
					</div>
				</td>
			</tr>
		</table>
	</asp:Panel>
</div>
<asp:ObjectDataSource ID="odsIntegrate" TypeName="EasyDNN.Modules.EasyDNNGallery.DataAcess" runat="server" SelectMethod="GetIntegration">
	<SelectParameters>
		<asp:Parameter Name="PortalID" Type="Int32" />
		<asp:Parameter Name="ModuleID" Type="Int32" />
		<asp:Parameter Name="ArticleID" Type="Int32" />
	</SelectParameters>
</asp:ObjectDataSource>
