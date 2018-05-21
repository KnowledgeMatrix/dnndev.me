<%@ control language="C#" autoeventwireup="true" inherits="EasyDNN.Modules.EasyDNNGallery.RSSImport, App_Web_rssimport.ascx.af09375b" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<script type="text/javascript">
	function ConfirmDelete() {
		return confirm('<%=Localization.GetString("Areyousure.Text", this.LocalResourceFile)%>');
	}
</script>
<asp:Panel ID="pnlMainWrap" runat="server">
	<div id="EDGAdminContent">
		<div class="topBarWrapper">
			<div class="wrapper">
				<ul class="links">
					<li>
						<span><%=strRSSImport%></span>
					</li>
				</ul>
				<ul class="actions">
					<li class="dashboardBtn">
						<asp:HyperLink ID="hlDasboard" runat="server">Dasboard</asp:HyperLink>
					</li>
					<li class="close">
						<asp:HyperLink ID="hlPowerOff" runat="server" ToolTip="Close" resourcekey="lbPowerOffResource1">Exit</asp:HyperLink>
					</li>
				</ul>
			</div>
		</div>
		<div class="mainContentWrapper">
			<div class="contentSectionWrapper">
				<div class="clearfix"></div>
				<asp:Panel ID="pnlRssImport" runat="server">
					<asp:Panel ID="pnlRssImportHeader" runat="server" CssClass="listItems">
							<asp:GridView ID="gvFeeds" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" CellPadding="0" DataSourceID="odsFeeds" EnableModelValidation="True" GridLines="None" ShowFooter="True" DataKeyNames="RSSID" OnRowCommand="gvFeeds_RowCommand" CssClass="listItemsTable">
								<AlternatingRowStyle CssClass="second edgrow" />
								<Columns>
									<asp:TemplateField ShowHeader="False">
										<ItemTemplate>
											<div class="itemActions itemEditActions">
												<asp:LinkButton ID="lbEditRSS" runat="server" CausesValidation="False" CommandArgument='<%# Eval("RSSID") %>' CommandName="EditRSS" ToolTip="<%#EditText%>" CssClass="itemEditUpdate"><%#EditText%></asp:LinkButton>
												<asp:LinkButton ID="lbDeleteRSS" runat="server" CausesValidation="False" CommandName="Delete" OnClientClick="return ConfirmDelete();" ToolTip="<%#Delete%>" CssClass="itemEditRemove"><%#Delete%></asp:LinkButton>
											</div>
											<div class="itemActions itemEditActions paddingTop small">
												<asp:LinkButton ID="lbDeleteAllMediaByFees" runat="server" resourcekey="lbDeleteAllMediaByFees" CausesValidation="False" CommandArgument='<%# Eval("RSSID") %>' CommandName="DeleteMediaByFeed" OnClientClick="return ConfirmDelete();" Text="Delete all media added by this feed" CssClass="itemEditCancel"></asp:LinkButton>
											</div>
										</ItemTemplate>
										<HeaderStyle Width="100px" />
									</asp:TemplateField>
									<asp:BoundField DataField="RSSID" HeaderText="ID">
										<ControlStyle Width="40px" />
										<HeaderStyle Width="40px" />
										<ItemStyle Width="40px" />
									</asp:BoundField>
									<asp:BoundField DataField="RSSURL" HeaderText="RSS URL">
										<ControlStyle Width="190px" />
										<HeaderStyle Width="190px" />
										<ItemStyle Width="190px" />
									</asp:BoundField>
									<asp:TemplateField HeaderText="Author">
										<ItemTemplate>
											<asp:Label ID="lblAuthor" runat="server" resourcekey="lblAuthorResource1" Text='<%# GetUserNameDisplay(Eval("UserID")) %>'></asp:Label>
										</ItemTemplate>
										<ControlStyle Width="70px" />
										<HeaderStyle Width="70px" />
										<ItemStyle Width="70px" />
									</asp:TemplateField>
									<asp:TemplateField HeaderText="Gallery">
										<ItemTemplate>
											<asp:Label ID="lblCategoryName" runat="server" resourcekey="lblCategoryNameResource1" Text='<%# GetGalleryName(Eval("GalleryID")) %>'></asp:Label>
										</ItemTemplate>
										<ControlStyle Width="100px" />
										<HeaderStyle Width="100px" />
										<ItemStyle Width="100px" />
									</asp:TemplateField>
									<asp:TemplateField HeaderText="UseTitle">
										<ItemTemplate>
											<asp:CheckBox ID="cbUseTitle" runat="server" Checked='<%# Bind("UseTitle") %>' Enabled="False" />
										</ItemTemplate>
										<ControlStyle Width="60px" />
										<HeaderStyle Width="60px" />
										<ItemStyle HorizontalAlign="Center" Width="60px" />
									</asp:TemplateField>
									<asp:TemplateField HeaderText="UseDescription">
										<ItemTemplate>
											<asp:CheckBox ID="cbUseDescription" runat="server" Checked='<%# Bind("UseDescription") %>' Enabled="False" />
										</ItemTemplate>
										<ControlStyle Width="60px" />
										<HeaderStyle Width="60px" />
										<ItemStyle HorizontalAlign="Center" Width="60px" />
									</asp:TemplateField>
									<asp:TemplateField HeaderText="Active">
										<ItemTemplate>
											<asp:CheckBox ID="cbActive" runat="server" Checked='<%# Bind("Active") %>' Enabled="False" resourcekey="cbActiveResource1" />
										</ItemTemplate>
										<ControlStyle Width="45px" />
										<HeaderStyle Width="45px" />
										<ItemStyle Width="45px" />
									</asp:TemplateField>
								</Columns>
							</asp:GridView>
					</asp:Panel>
					<asp:Panel ID="pnlSchedulerIfo" runat="server" CssClass="infoMessages info">
						<asp:Label ID="lblSchedulerInfo" runat="server" resourcekey="lblSchedulerInfoResource1"></asp:Label>
					</asp:Panel>
					<asp:Panel ID="pnlAddRSSImport" CssClass="settingsList" runat="server">
						<div class="settingsTable">
							<table>
								<tr class="color2HighLighted">
									<td colspan="2" class="textCenter">
										<asp:Label ID="lblAddEditRSS" runat="server" Text="Import RSS" resourcekey="lblAddEditRSSResource1"></asp:Label>
									</td>
								</tr>
								<tr>
									<td class="label">
										<dnn:Label ID="lblFeedURL" runat="server" Text="Feed URL:" HelpText="Enter the full URL to the RSS or Atom feed:" HelpKey="lblFeedURL.HelpText" ResourceKey="lblFeedURL"></dnn:Label>
									</td>
									<td>
										<asp:TextBox ID="tbFeedURL" runat="server" ValidationGroup="vgRSSImport" CssClass="large"></asp:TextBox>
										<asp:RequiredFieldValidator ID="rfvFeedURL" runat="server" ControlToValidate="tbFeedURL" ErrorMessage="Please enter feed URL." ValidationGroup="vgRSSImport" Display="Dynamic" resourcekey="rfvFeedURLResource1.ErrorMessage" CssClass="smallInfo error"></asp:RequiredFieldValidator>
										<asp:RegularExpressionValidator ID="revFeedURL" runat="server" ControlToValidate="tbFeedURL" Display="Dynamic" ErrorMessage="Please enter valid URL." ValidationExpression="http(s)?://?" ValidationGroup="vgRSSImport" resourcekey="revFeedURLResource1.ErrorMessage" Enabled="False" CssClass="smallInfo error"></asp:RegularExpressionValidator>
									</td>
								</tr>
								<tr>
									<td class="label">
										<dnn:Label ID="lblSelectFeedAuthor" runat="server" Text="Feed author:" HelpText="Select the user which will be added as author of imported feed media:" HelpKey="lblSelectFeedAuthor.HelpText" ResourceKey="lblSelectFeedAuthor"></dnn:Label>
									</td>
									<td>
										<div class="styledSelect">
											<asp:DropDownList ID="ddlRoles" runat="server" AppendDataBoundItems="True" AutoPostBack="True" CssClass="ddlgeneral" OnSelectedIndexChanged="ddlRoles_SelectedIndexChanged">
												<asp:ListItem Value="-1" resourcekey="ListItemResource1">Select role</asp:ListItem>
											</asp:DropDownList>
										</div>
										<div class="styledSelect">
											<asp:DropDownList ID="ddlAuthors" runat="server" AppendDataBoundItems="True" CssClass="ddlgeneral">
												<asp:ListItem Value="0" resourcekey="ListItemResource2">Select author</asp:ListItem>
											</asp:DropDownList>
										</div>
										<asp:CompareValidator ID="CompareValidator1" runat="server" ControlToValidate="ddlAuthors" Display="Dynamic" ErrorMessage="Please select Author" Operator="NotEqual" ValidationGroup="vgRSSImport" ValueToCompare="0" resourcekey="CompareValidator1Resource1.ErrorMessage" CssClass="smallInfo error"></asp:CompareValidator>
									</td>
								</tr>
								<tr>
									<td class="label">
										<dnn:Label ID="lblSelectFeedCategory" runat="server" Text="Category to import feed to:" HelpText="Select the category in which the feed will be imported:" HelpKey="lblSelectFeedCategory.HelpText" ResourceKey="lblSelectFeedCategory"></dnn:Label>
									</td>
									<td>
										<div class="styledSelect">
											<asp:DropDownList ID="ddlFeedCategorySelect" runat="server" AutoPostBack="True" AppendDataBoundItems="True" OnSelectedIndexChanged="ddlFeedCategorySelect_SelectedIndexChanged">
												<asp:ListItem Value="0" resourcekey="ListItemResource3">Select category</asp:ListItem>
											</asp:DropDownList>
										</div>
										<asp:CompareValidator ID="CompareValidator2" runat="server" ControlToValidate="ddlFeedCategorySelect" Display="Dynamic" ErrorMessage="Please select category" Operator="NotEqual" ValidationGroup="vgRSSImport" ValueToCompare="0" resourcekey="CompareValidator2Resource1.ErrorMessage" CssClass="smallInfo error"></asp:CompareValidator>
									</td>
								</tr>
								<tr>
									<td class="label">
										<dnn:Label ID="lblSelectGalleryToImportTo" runat="server" Text="Gallery to import feed to:" HelpText="Select the Gallery in which the feed will be imported:"></dnn:Label>
									</td>
									<td>
										<div class="styledSelect">
											<asp:DropDownList ID="ddlSelectGalleryToImportTo" runat="server" DataSourceID="odsGallery" DataTextField="GalleryName" DataValueField="GalleryID" AppendDataBoundItems="True">
												<asp:ListItem resourcekey="liSelectGallery" Value="0">Select gallery</asp:ListItem>
											</asp:DropDownList>
										</div>
										<asp:CompareValidator ID="CompareValidator3" runat="server" ControlToValidate="ddlSelectGalleryToImportTo" Display="Dynamic" ErrorMessage="Please select gallery" Operator="NotEqual" ValidationGroup="vgRSSImport" ValueToCompare="0" CssClass="smallInfo error"></asp:CompareValidator>
									</td>
								</tr>
								<tr>
									<td class="label">
										<dnn:Label ID="lblUseTitle" runat="server" Text="Use rss item title as media name:" HelpKey="lblUseTitle.HelpText" ResourceKey="lblUseTitle" HelpText="Use rss item title as media name."></dnn:Label>
									</td>
									<td>
										<div class="styledCheckbox noLabel">
											<asp:CheckBox ID="cbUseTitle" runat="server" Checked="True" Text="Use rss item title as media name"/>
										</div>
									</td>
								</tr>
								<tr>
									<td class="label">
										<dnn:Label ID="lblUseDescription" runat="server" Text="Use rss item summary as media description:" HelpText="Use rss item summary as media description."></dnn:Label>
									</td>
									<td>
										<div class="styledCheckbox noLabel">
											<asp:CheckBox ID="cbUseDescription" runat="server" Checked="True" Text="Use rss item summary as media description"/>
										</div>
									</td>
								</tr>
								<tr>
									<td class="label">
										<dnn:Label ID="lblLimitNumberofMedia" runat="server" Text="Limit number of media:" HelpText="Enter the limit of media number to be stored for this feed. If number of media from the feed is greater than entered number older media will be deleted. Enter 0 to store all media." HelpKey="lblLimitNumberofMedia.HelpText" ResourceKey="lblLimitNumberofMedia"></dnn:Label>
									</td>
									<td>
										<asp:TextBox ID="tbLimitNumberofMedia" runat="server" CssClass="small textCenter">0</asp:TextBox>
										<asp:RequiredFieldValidator ID="rfvLimitContent" runat="server" ControlToValidate="tbLimitNumberofMedia" Display="Dynamic" ErrorMessage="Please enter media limit number." ValidationGroup="vgRSSImport" resourcekey="rfvLimitContentResource1.ErrorMessage" CssClass="smallInfo error"></asp:RequiredFieldValidator>
										<asp:CompareValidator ID="cvLimitNumberOfMedia" runat="server" ControlToValidate="tbLimitNumberofMedia" Display="Dynamic" ErrorMessage="Please enter number. " Operator="DataTypeCheck" SetFocusOnError="True" Type="Integer" ValidationGroup="vgRSSImport" CssClass="smallInfo error"></asp:CompareValidator>
									</td>
								</tr>
								<tr>
									<td class="label">
										<dnn:Label ID="lblLimitSummaryCharImport" runat="server" Text="Limit number of characters imported into summary:" HelpText="Limit number of characters imported into summary. Enter 0 for no limit."></dnn:Label>
									</td>
									<td>
										<asp:TextBox ID="tbLimitImportIntoSummary" runat="server" CssClass="small textCenter">500</asp:TextBox>
										<asp:RequiredFieldValidator ID="rfvLimitContent0" runat="server" ControlToValidate="tbLimitImportIntoSummary" Display="Dynamic" ErrorMessage="Please enter media limit number." resourcekey="rfvLimitContentResource1.ErrorMessage" ValidationGroup="vgRSSImport" CssClass="smallInfo error"></asp:RequiredFieldValidator>
										<asp:CompareValidator ID="cvLimitMediaSummary" runat="server" ControlToValidate="tbLimitImportIntoSummary" Display="Dynamic" ErrorMessage="Please enter number. " Operator="DataTypeCheck" SetFocusOnError="True" Type="Integer" ValidationGroup="vgRSSImport" CssClass="smallInfo error"></asp:CompareValidator>
									</td>
								</tr>
								<tr>
									<td class="label">
										<dnn:Label ID="lblFeedActive" runat="server" Text="Active:" HelpText="Active:" HelpKey="lblFeedActive.HelpText" ResourceKey="lblFeedActive"></dnn:Label>
									</td>
									<td>
										<div class="styledCheckbox noLabel">
											<asp:CheckBox ID="cbFeedActive" runat="server" Checked="True" Text="Active"/>
										</div>
									</td>
								</tr>
								<tr>
									<td class="label">
										<dnn:Label ID="lblFeedType" runat="server" HelpText="Feed type:" Text="Feed type:" HelpKey="lblFeedType.HelpText" ResourceKey="lblFeedType" />
									</td>
									<td>
										<div class="styledSelect">
											<asp:DropDownList ID="ddlFeedType" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlFeedType_SelectedIndexChanged">
												<asp:ListItem resourcekey="liStandard" Value="Standard">Standard</asp:ListItem>
												<asp:ListItem resourcekey="liYouTube" Value="YouTube">YouTube feed</asp:ListItem>
												<asp:ListItem resourcekey="liVimeo" Value="Vimeo">Vimeo feed</asp:ListItem>
											</asp:DropDownList>
										</div>
									</td>
								</tr>
								<tr id="trImportYouTubeStats" runat="server" visible="false">
									<td class="label">
										<dnn:Label ID="lblImportYouTubeStats" runat="server" Text="Import YouTube statistic:" HelpText="Import YouTube statistic."></dnn:Label>
									</td>
									<td>
										<div class="styledCheckbox noLabel">
											<asp:CheckBox ID="cbImportYouTubeStats" runat="server" Checked="False" Text="Import YouTube statistic"/>
										</div>
									</td>
								</tr>
								<tr id="trDownloadEnclosureMedia" runat="server" visible="true">
									<td>
										<dnn:Label ID="lblDownloadEnclosureMedia" runat="server" Text="Download video files:" HelpText="Select to download video files if RSS contains them."></dnn:Label>
									</td>
									<td>
										<div class="styledCheckbox noLabel">
											<asp:CheckBox ID="cbDownloadEnclosureMedia" runat="server" Checked="False" Text="Download video files"/>
										</div>
									</td>
								</tr>
								<tr>
									<td colspan="2">
										<asp:Label ID="lblMessage" runat="server"></asp:Label>
									</td>
								</tr>
							</table>
						</div>
					</asp:Panel>
				</asp:Panel>
				<div class="mainActions">
					<asp:LinkButton ID="btnSaveFeedSettings" runat="server" OnClick="btnSaveFeedSettings_Click" Text="Add RSS import" ValidationGroup="vgRSSImport" resourcekey="btnSaveFeedSettingsResource1" CssClass="add"/>
					<asp:LinkButton ID="btnUpdateFeed" runat="server" OnClick="btnUpdateFeed_Click" Text="Update RSS import" ValidationGroup="vgRSSImport" Visible="False" resourcekey="btnUpdateFeedResource1" CssClass="downSave"/>
					<asp:LinkButton ID="btnCancelEditing" runat="server" OnClick="btnCancelEditing_Click" Text="Cancel" resourcekey="btnCancelEditingResource1" CssClass="downClose"/>
				</div>
			</div>
		</div>
	</div>
	<asp:ObjectDataSource ID="odsFeeds" runat="server" SelectMethod="GetAllRSSFeedsInPortal" TypeName="EasyDNN.Modules.EasyDNNGallery.RSSImportController" DeleteMethod="DeleteRSSFeed">
		<DeleteParameters>
			<asp:Parameter Name="RSSID" Type="Int32" />
		</DeleteParameters>
		<SelectParameters>
			<asp:Parameter Name="PortalID" Type="Int32" />
		</SelectParameters>
	</asp:ObjectDataSource>
	<asp:ObjectDataSource ID="odsGallery" TypeName="EasyDNN.Modules.EasyDNNGallery.DataAcess" runat="server" SelectMethod="GetCatGalleries" OldValuesParameterFormatString="{0}">
		<SelectParameters>
			<asp:ControlParameter ControlID="ddlFeedCategorySelect" Name="CategoryID" PropertyName="SelectedValue" Type="Int32" />
		</SelectParameters>
	</asp:ObjectDataSource>
	<asp:HiddenField ID="hfRSSFeedID" runat="server" />
</asp:Panel>
