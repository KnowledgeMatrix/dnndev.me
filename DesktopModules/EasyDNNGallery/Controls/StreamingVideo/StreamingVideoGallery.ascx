<%@ control language="C#" autoeventwireup="true" inherits="EasyDNN.Modules.EasyDNNGallery.DesktopModules_EasyDNNGallery_Controls_StreamingVideoGallery, App_Web_streamingvideogallery.ascx.625e4e3a" %>

<asp:Literal ID="ltOpenImage" runat="server" EnableViewState="False"></asp:Literal>
<asp:Panel ID="pnlVideoGallery" runat="server" Visible="False">
	<div id="<%=CSSFile%>">
		<div class="EDGbackground">
			<div class="EDGcontentbgrd">
				<div class="EDGcornerbotleft">
					<div class="EDGcornerbotright">
						<div class="EDGcornertopleft">
							<div class="EDGcornertopright">
								<div class="EDGcontent edg_streaming_video">
									<asp:Panel ID="pnlSGTitle" CssClass="video_title" runat="server" Visible="false">
										<asp:Literal ID="literalVideoTitle" runat="server" />
									</asp:Panel>
									<div class="video_player_wrapper" style="width: <%=gallerySettings.SSImageWidth%>px; height: <%=gallerySettings.SSImageHeight%>px;">
										<div class="video_player_container" id="EDGStreamingVideo_M<%=ModuleId%>" style="width: <%=gallerySettings.SSImageWidth%>px; height: <%=gallerySettings.SSImageHeight%>px;" href="<%=gallerySettings.RTMPFileURL%>">&nbsp;</div>
										<script type="text/javascript">
											$f('EDGStreamingVideo_M<%=ModuleId%>', '<%=ModulePath.Replace("Controls/StreamingVideo/","")%>static/flashflowplayer/flowplayer.swf', {
												clip: {
													provider: 'rtmp'
												},
												plugins: {
													rtmp: {
														url: '<%=ModulePath.Replace("Controls/StreamingVideo/","")%>static/flashflowplayer/flowplayer.rtmp-3.2.3.swf',
															netConnectionUrl: '<%=gallerySettings.RTMPServer%>'
														}
													}
												});
										</script>
									</div>
									<asp:Panel ID="pnlSGDescription" CssClass="video_description" runat="server" Visible="false">
										<asp:Literal ID="literalVideoDescription" runat="server" />
									</asp:Panel>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div style="clear: both;"></div>
		</div>
	</div>
</asp:Panel>
