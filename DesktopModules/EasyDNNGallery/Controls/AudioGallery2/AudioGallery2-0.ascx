<%@ control language="C#" autoeventwireup="true" inherits="EasyDNN.Modules.EasyDNNGallery.DesktopModules_EasyDNNGallery_Controls_AudioGallery2Control, App_Web_audiogallery2-0.ascx.c7b91827" %>
<style type="text/css">
	.titleempty
	{
		display: none;
	}
	.goright
	{
		float: right;
		padding-left: 5px;
		padding-right: 5px;
	}
	#<%=pnlAudioGallery.ClientID %>	.audiojs {
		width: <%=myappSettings.SSImageWidth%>px;
	}
</sty
</style>
<script type="text/javascript">
	<%=jQuery%>(document).ready(function ($) {
		audiojs.events.ready(function () {
			var as = audiojs.createAll(null, $('#<%=pnlAudioGallery.ClientID%> audio'));
			as[0].setVolume(<%=myappSettings.AudioVolume%>);
		});
		$('#<%=CssClass%> a.edg_audio_gal_socialsharing_toggle<%=ModulNr%>').click(function () {
			var $click = $(this);
			$click.parent().siblings('.edg_audio_gal_socialsharing<%=ModulNr%>').slideToggle(200);
			return false;
		});

		$('#<%=CssClass%> a.edg_audio_gal_permalink_toggle<%=ModulNr%>').click(function () {
			var $click = $(this);
			$click.parent().parent().siblings('.edg_audio_gal_permalink<%=ModulNr%>').slideToggle(200);
			return false;
		});
		
	});
</script>
<asp:Literal ID="ltOpenImage" runat="server" EnableViewState="False"></asp:Literal>
<div id="AudioGallery">
	<asp:Panel ID="pnlAudioGallery" runat="server">
		<div id="<%=CssClass%>">
			<div class="EDGbackground">
				<div class="EDGcontentbgrd">
					<div class="EDGcornerbotleft">
						<div class="EDGcornerbotright">
							<div class="EDGcornertopleft">
								<div class="EDGcornertopright">
									<div class="EDGcontent" style="text-align: center;">
										<div class="EDGTitle">
											<asp:Label ID="lblAGTitle" runat="server" CssClass="EDGTitleText" Visible="False"></asp:Label>
											<br />
											<asp:Label ID="lblAGDescription" runat="server" CssClass="GalleryDescription" Visible="False"></asp:Label>
										</div>
										<asp:DataList ID="dlAudioGallery" runat="server" Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" HorizontalAlign="Center" ItemStyle-VerticalAlign="Top" OnItemCreated="dlAudioGallery_ItemCreated"
											OnItemDataBound="dlAudioGallery_ItemDataBound">
											<EditItemStyle HorizontalAlign="Center" />
											<ItemTemplate>
												<div class="AudioTitle">
													<asp:Label ID="lblAGMediaTitle" runat="server" CssClass="EDGTitleText" Text='<%#ShowTitle(DataBinder.Eval(Container.DataItem, "Title"))%>' Visible="True"></asp:Label>
												</div>
												<asp:PlaceHolder ID="plAudioinFlash" runat="server" Visible='<%#!Html5%>'>
													<div id='pid<%=ModulNr%><%#Eval("PictureID")%>' class="AudioBody">
														<audio src="<%#Eval("Filename")%>" preload="none" <%=myappSettings.AudioPlayOnLoad%>></audio>
													</div>
												</asp:PlaceHolder>
												<asp:PlaceHolder ID="plHTML5Audio" runat="server" Visible='<%#Html5%>'>
													<audio controls preload="none" <%=ViewState["AudioPlayOnLoadHTML5"]%>> 
														<source src='<%#Eval("Filename")%>'>
													</audio>
												</asp:PlaceHolder>
												<div class="AudioDescription">
													<asp:Label ID="lblAGMediaDescription" runat="server" CssClass="EDGTitleText" Text='<%# ShowDescription(DataBinder.Eval(Container.DataItem, "Description"))%>' Visible="True"></asp:Label>
												</div>
												<div style="clear: both; display: block; text-align: center;">
													<asp:HyperLink ID="hlDownloadImage" runat="server" NavigateUrl='<%#GetImageDownURL(Eval("FileName"))%>' Visible='<%#GetDownloadVisible(Eval("HiResVersion"))%>' CssClass="downloadlink"><%=strDownloadAudio%></asp:HyperLink>
												</div>
												<div class="edg_share_link_wrapper">
													<asp:Panel ID="pnlMediaUrl" runat="server" Visible="False" CssClass="edn_link_and_share_container">
														<a href="#" class="EasyDNNGallery_silver_button edg_audio_gal_permalink_toggle<%=ModulNr%>"><span>
															<img alt="" class="icon" src="<%=ModulePath.Replace("Controls/AudioGallery2","")%>images/icons/grey_link.png"><%=LinkThis%></span></a>
													</asp:Panel>
													<asp:Panel ID="pnlSocialSharing" runat="server" Visible="False" CssClass="edn_link_and_share_container">
														<a href="#" class="EasyDNNGallery_silver_button edg_audio_gal_socialsharing_toggle<%=ModulNr%>"><span>
															<img alt="" class="icon" src="<%=ModulePath.Replace("Controls/AudioGallery2","")%>images/icons/grey_plus.png"><%=ShareThis%></span></a>
													</asp:Panel>
													<div class="edg_audio_gal_socialsharing<%=ModulNr%>" style='<%=ShowSharingStyle%>'>
														<%#GetTwitterButton(Eval("PictureID"))%>
														<%#GetGooglePlusButton(Eval("PictureID"))%>
														<%#GetFacbookIframeLikeButton(Eval("PictureID"))%>
													</div>
												</div>
												<div class="edg_link_container edg_audio_gal_permalink<%=ModulNr%>" style="display: none;">
													<asp:TextBox ID="tbMediaURL" runat="server" Text='<%#GetMediaURLBackLink(Eval("PictureID"))%>'></asp:TextBox>
												</div>
											</ItemTemplate>
										</asp:DataList>
										<br />
										<asp:DataList ID="repAudioList" runat="server" ShowFooter="False" ShowHeader="False" DataKeyField="PictureID" HorizontalAlign="Center" OnItemCommand="repAudioList_ItemCommand">
											<ItemTemplate>
												<div class="EDGmain">
													<div class="EDGimage">
														<asp:LinkButton ID="lbVideoThumb2" runat="server" CommandArgument='<%#Eval("PictureID")%>' CommandName="OpenVideo">
															<asp:Image ID="imgVideoThumb" runat="server" ImageUrl='<%#GetThumbPath(DataBinder.Eval(Container.DataItem, "ViewerThumb"),DataBinder.Eval(Container.DataItem, "PictureID"))  %>' EnableTheming="True" alt='' ImageAlign="Middle" />
															<span class="flagObject"></span><span class="flag"></span><span class="leftsh"></span><span class="rightsh"></span><span class="botsh"></span><span class="topsh"></span><span class="round1"></span><span class="round2"></span><span class="round3"></span>
															<span class="round4"></span><span class='<%#TitleClass(DataBinder.Eval(Container.DataItem, "Title"),DataBinder.Eval(Container.DataItem, "Description"),DataBinder.Eval(Container.DataItem, "PictureID"))%>'>
																<asp:Label ID="lblItemTitle2" runat="server" Text='<%#ShowTitle(DataBinder.Eval(Container.DataItem, "Title"))%>' Visible='<%#TitleToDisplayThumbnail(Eval("Title"),Eval("PictureID"))%>'></asp:Label><br />
																<asp:Label ID="lblTGDescription2" runat="server" CssClass="Description" Text='<%# ShowDescription(DataBinder.Eval(Container.DataItem, "Description"))%>' Visible='<%#DescriptionToDisplayThumbnail(Eval("Description"),Eval("PictureID"))%>'></asp:Label></span>
														</asp:LinkButton>
													</div>
												</div>
											</ItemTemplate>
										</asp:DataList>
										<asp:GridView ID="gvAudioGalPagination" runat="server" AllowPaging="True" AutoGenerateColumns="False" BorderStyle="None" BorderWidth="0px" DataKeyNames="PictureID" DataSourceID="odsGetAudio" GridLines="None" HorizontalAlign="Center" OnPageIndexChanged="gvAudioGalPagination_PageIndexChanged"
											OnSelectedIndexChanged="gvAudioGalPagination_PageIndexChanged" PageSize="1" ShowFooter="True" ShowHeader="False" Width="28px">
											<Columns>
												<asp:BoundField DataField="FileName" Visible="False" />
											</Columns>
											<PagerStyle BorderWidth="0px" CssClass="EDGpager" HorizontalAlign="Center" />
										</asp:GridView>
										<table cellpadding="0" cellspacing="0" border="0" align="center">
											<tr>
												<td>
													<asp:LinkButton ID="btnAGPrev" runat="server" CssClass="buttonPrev" OnClick="btnAGPrev_Click" />
													<asp:LinkButton ID="btnAGNext" runat="server" CssClass="buttonNext" OnClick="btnAGNext_Click" />
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
					&nbsp;
				</div>
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
<asp:ObjectDataSource ID="odsGetAudio" TypeName="EasyDNN.Modules.EasyDNNGallery.DataAcess" runat="server" SelectMethod="GetRandomAudioFromGallery" OldValuesParameterFormatString="original_{0}">
	<SelectParameters>
		<asp:Parameter Name="PortalID" Type="Int32" />
		<asp:Parameter Name="GalleryID" Type="Int32" />
		<asp:Parameter Name="isRandom" Type="Boolean" DefaultValue="True" />
	</SelectParameters>
</asp:ObjectDataSource>
