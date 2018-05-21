<%@ control language="C#" inherits="EasyDNN.Modules.EasyDNNGallery.GeneralSettings, App_Web_generalsettings.ascx.af09375b" autoeventwireup="true" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>

<div id="EDGAdminContent">
	<div class="topBarWrapper">
		<div class="wrapper">
			<ul class="links">
				<li>
					<asp:Label ID="lblGenSettingsTitle" runat="server" Text="General Settings" resourcekey="lblGenSettingsTitleResource1"></asp:Label>
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
			<div class="sectionBox noShadow noBorder settingsList paddingTop">
				<div class="settingsTable paddingTop clearWidth">
					<table class="fullWidthTable">
						<tr>
							<td class="label textTop">
								<asp:Label ID="lblIncludeJquery" runat="server" Text="Include jQuery:" resourcekey="lblIncludeJqueryResource1"></asp:Label>
							</td>
							<td>
								<div class="styledCheckbox noLabel">
									<asp:CheckBox ID="cbIncludeJquery" runat="server" resourcekey="cbIncludeJqueryResource1" Text="Include jQuery" />
								</div>
								<asp:Label ID="lblJqueryWarning" runat="server" Text="Please do NOT include jQuery if you are using DotNetNuke version 6 and above." resourcekey="lblJqueryWarningResource1" CssClass="smallInfo warning"></asp:Label>
							</td>
						</tr>
						<tr>
							<td class="label textTop">
								<asp:Label ID="lbljQueryNoConflict" runat="server" Text="Run jQuery in no conflict mode:" resourcekey="lbljQueryNoConflictResource1"></asp:Label>
							</td>
							<td>
								<div class="styledCheckbox noLabel">
									<asp:CheckBox ID="cbjQueryNoConflictMode" runat="server" resourcekey="cbjQueryNoConflictModeResource1" Text="Run jQuery in no conflict mode:" />
								</div>
								<asp:Label ID="lblJqueryWarning0" runat="server" Text="Please do NOT run jQuery in conflict mode if you are using DotNetNuke version 6 and above." resourcekey="lblJqueryWarning0Resource1" CssClass="smallInfo warning"></asp:Label>
							</td>
						</tr>
						<tr class="color2HighLighted">
							<td colspan="2" class="textCenter" style="width:100%">
								<asp:Label ID="lblControlsAccess" runat="server" Text="Manage content and Gallery settings control access" resourcekey="lblControlsAccessResource1"></asp:Label>
							</td>
						</tr>
						<tr>
							<td colspan="2">
								<div class="additionalOptions color1">
									<asp:GridView ID="gvControlPremissions" runat="server" AutoGenerateColumns="False" CellPadding="4" GridLines="None" CssClass="additionalOptionsList textCenter clearWidth">
										<RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
										<Columns>
											<asp:TemplateField HeaderText="Role" SortExpression="Role">
												<EditItemTemplate>
													<asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("Role") %>'></asp:TextBox>
												</EditItemTemplate>
												<ItemTemplate>
													<asp:Label ID="lblRoleName" runat="server" Text='<%# Bind("Role") %>'
														resourcekey="lblRoleNameResource1"></asp:Label>
												</ItemTemplate>
												<ItemStyle CssClass="roleName" />
											</asp:TemplateField>
											<asp:TemplateField HeaderText="Managecontent">
												<EditItemTemplate>
													<asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("ManageContent") %>'></asp:TextBox>
												</EditItemTemplate>
												<ItemTemplate>
													<asp:CheckBox ID="cbManageContent" runat="server" Checked='<%# Bind("ManageContent") %>' resourcekey="cbManageContentResource1" />
												</ItemTemplate>
												<ItemStyle />
											</asp:TemplateField>
											<asp:TemplateField HeaderText="Gallerysettings">
												<EditItemTemplate>
													<asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("GallerySettings") %>'></asp:TextBox>
												</EditItemTemplate>
												<ItemTemplate>
													<asp:CheckBox ID="cbGallerySettings" runat="server" Checked='<%# Bind("GallerySettings") %>' />
												</ItemTemplate>
												<ItemStyle />
											</asp:TemplateField>
										</Columns>
										<FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
										<PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
										<SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
										<HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
										<EditRowStyle BackColor="#999999" />
										<AlternatingRowStyle BackColor="White" ForeColor="#284775" />
									</asp:GridView>
								</div>
							</td>
						</tr>
						<tr>
							<td colspan="2"></td>
						</tr>
						<tr class="color2HighLighted">
							<td colspan="2" class="textCenter" style="width:100%">
								<asp:Label ID="lblSchedulerSettingsTitle" runat="server" Text="Scheduler settings" resourcekey="lblSchedulerSettingsTitleResource1"></asp:Label>
							</td>
						</tr>
						<tr>
							<td class="label textTop">
								<dnn:Label ID="lblSchedulerEnabled" runat="server" Text="Enable scheduler:" ResourceKey="lblSchedulerEnabledResource1" HelpKey="lblSchedulerEnabledResource1.HelpText" HelpText="Enable scheduler:"></dnn:Label>
							</td>
							<td>
								<div class="styledCheckbox noLabel">
									<asp:CheckBox ID="cbSchedulerEnabled" runat="server" resourcekey="cbSchedulerEnabledResource1" Text="Enable scheduler" />
								</div>
								<asp:Label ID="lblSchedulerInfo" runat="server" resourcekey="lblSchedulerInfo" Text="This will enable images published in the Journal posts by a user to be added into user's Journal Post gallery." CssClass="smallInfo info"></asp:Label>
							</td>
						</tr>
						<tr>
							<td colspan="2"></td>
							<td>
								<asp:Label ID="lblInfo" runat="server" EnableViewState="False" ForeColor="Red" resourcekey="lblInfoResource1" />
							</td>
						</tr>
					</table>
				</div>
			</div>
			<div class="mainActions">
				<asp:LinkButton ID="btnSaveSettings" runat="server" OnClick="btnSaveSettings_Click" Text="Save settings" resourcekey="btnSaveSettingsResource1" CssClass="downSave" />
				<asp:LinkButton ID="btnSaveClose" runat="server" OnClick="btnSaveClose_Click" Text="Save &amp; Close" resourcekey="btnSaveCloseResource1" CssClass="downSaveClose" />
				<asp:LinkButton ID="btnClose" runat="server" Text="Close" OnClick="btnClose_Click" CssClass="downClose" />
			</div>

		</div>
	</div>
</div>
<asp:ObjectDataSource ID="odPortalSharing" runat="server"
	DeleteMethod="DeletePortalSharing" SelectMethod="GetPortalSharing"
	TypeName="EasyDNN.Modules.EasyDNNGallery.DataAcess">
	<DeleteParameters>
		<asp:Parameter Name="PortalIDFrom" Type="Int32" />
	</DeleteParameters>
</asp:ObjectDataSource>

