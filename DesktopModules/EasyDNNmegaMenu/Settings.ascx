<%@ control language="C#" inherits="EasyDNNSolutions.Modules.EasyDNNmegaMenu.Controls.Settings, App_Web_settings.ascx.ceb191fd" enableviewstate="true" %>
<%@ Register TagPrefix="dnn" TagName="TextEditor" Src="~/controls/TextEditor.ascx" %>
<%@ Register TagPrefix="Portal" TagName="URL" Src="~/controls/URLControl.ascx" %>

<div class="topBarWrapper">
	<div class="wrapper">
		<ul class="links">
			<li><span>Mega menu settings</span></li>
		</ul>
		<ul class="actions">
			<li class="close"><asp:LinkButton ID="btnClose" runat="server" Text="Close" OnClick="Close" /></li>
		</ul>
		<asp:Literal ID="literalFlashMessage" runat="server" EnableViewState="false" />
	</div>
</div>
<asp:Panel ID="pnlSettingsWrapper" runat="server" CssClass="edMegaMenu_adminWrapper mainContentWrapper bottomPadded pure-g" DefaultButton="btnDefaultButton">
	<asp:Button ID="btnDefaultButton" runat="server" style="display: none;" />
	<script>
		eds1_11(function ($) {
			$('#<%=ddlTabs.ClientID %>_cboTabs').on('change', function () {
				__doPostBack('btnTabsUpdate', 'updateTabModuleList');
			});

			$('#<%=btnDefaultButton.ClientID %>').on('click', function () {
				return false;
			});
		});
	</script>
	<asp:Literal ID="mainJs" runat="server" EnableViewState="false" />
	<div class="pure-u-1 centerSection">
		<div class="contentSection">
			<div class="titleWrapper">
				<span>Settings</span>
			</div>
			<div class="contentWrapper pure-form pure-form-aligned">
				<asp:DropDownList ID="ddlSkinSelection" runat="server" EnableViewState="true" AutoPostBack="True" CssClass="edMegaMenu_skinSelectionDropdown" OnSelectedIndexChanged="ddlSkinSelection_SelectedIndexChanged" />
				<p id="pNotValidSkin" runat="server" Visible="false" class="edMegaMenu_skinNotValidMessage">Please activate this Skin package trough Style Wizard to enable Mega Menu editing.</p>
				<asp:Literal ID="menuReplicaContainer" runat="server" EnableViewState="false" />
				<asp:Panel ID="pnlSubmenuTypeSelection" runat="server" Visible="false" CssClass="edMegaMenu_submenuTypeSelection" EnableViewState="false">
					<asp:LinkButton ID="lbMenuTypeNormal" runat="server" CssClass="edMegaMenu_normal" OnClick="SwitchPageToNormal" EnableViewState="false"><span>Normal menu</span><span class="icon"></span></asp:LinkButton>
					<asp:LinkButton ID="lbMenuTypeMega" runat="server" CssClass="edMegaMenu_megaMenu" OnClick="SwitchPageToMegaMenu" EnableViewState="false"><span>MegaMenu</span><span class="icon"></span></asp:LinkButton>
				</asp:Panel>
				<asp:Panel ID="pnlSubmenuSettings" runat="server" Visible="false" CssClass="edMegaMenu_megaMenuSettings" EnableViewState="true">
					<div class="pure-control-group">
						<div class="numOfColumnsSlider"></div>
						<asp:TextBox ID="tbNumOfCulumns" runat="server" Text="3" CssClass="numberOfColumns" EnableViewState="false" AutoPostBack="false" />
						<asp:Button ID="btnSaveNumOfCollumns" runat="server" CssClass="edMegaMenu_button" OnClick="SaveNumOfCollumns" Text="Update column number" EnableViewState="false" />
					</div>
					<div class="pure-control-group">
						<label class="highlighted widthTypeSelectionMessage">The desired width for this submenu:</label>
						<asp:RadioButtonList ID="rblMenuWidthSelection" runat="server" RepeatLayout="OrderedList" CssClass="widthTypeSelection" AutoPostBack="true" OnSelectedIndexChanged="rblMenuWidthSelection_SelectedIndexChanged">
							<asp:ListItem Text="Normal" Value="normal" Selected="True" />
							<asp:ListItem Text="Page" Value="page" />
							<asp:ListItem Text="Full" Value="full" />
						</asp:RadioButtonList>
					</div>
					<asp:Panel ID="pnlMenuVisualizerContainer" runat="server" EnableViewState="false">
						<div id="divTopHtmlColumn" runat="server" visible="false" class="edMegaMenu_verticalHtml edMegaMenu_htmlTop" EnableViewState="false">
							<span>Top content</span>
							<asp:LinkButton ID="lbEditExistingTopHtml" runat="server" CssClass="edMegaMenu_editHtml" OnClick="editTopHtml" ToolTip="Edit content" EnableViewState="false">Edit content</asp:LinkButton>
							<asp:LinkButton ID="lbDeleteExistingTopHtml" runat="server" CssClass="edMegaMenu_deleteHtml" OnClick="deleteTopHtml" ToolTip="Remove content" EnableViewState="false">Delete content</asp:LinkButton>
							<asp:HyperLink ID="hlExistingTopContent" runat="server" Visible="false" CssClass="edMegaMenu_editHtml" EnableViewState="false">Edit content</asp:HyperLink>
						</div>
						<div id="divLeftHtmlColumn" runat="server" visible="false" class="edMegaMenu_column edMegaMenu_htmlContent edMegaMenu_column1" EnableViewState="false">
							<span>Left content</span>
							<asp:LinkButton ID="lbEditExistingLeftHtml" runat="server" CssClass="edMegaMenu_editHtml" OnClick="editLeftHtml" ToolTip="Edit content" EnableViewState="false">Edit content</asp:LinkButton>
							<asp:LinkButton ID="lbDeleteExistingLeftHtml" runat="server" CssClass="edMegaMenu_deleteHtml" OnClick="deleteLeftHtml" ToolTip="Remove content" EnableViewState="false">Delete content</asp:LinkButton>
							<asp:HyperLink ID="hlExistingLeftContent" runat="server" Visible="false" CssClass="edMegaMenu_editHtml" EnableViewState="false">Edit content</asp:HyperLink>
						</div>
						<asp:Literal ID="menuVisualizerColumns" runat="server" EnableViewState="false" />
						<div id="divRightHtmlColumn" runat="server" visible="false" class="edMegaMenu_column edMegaMenu_htmlContent edMegaMenu_column8" EnableViewState="false">
							<span>Right content</span>
							<asp:LinkButton ID="lbEditExistingRightHtml" runat="server" CssClass="edMegaMenu_editHtml" OnClick="editRightHtml" ToolTip="Edit content" EnableViewState="false">Edit content</asp:LinkButton>
							<asp:LinkButton ID="lbDeleteExistingRightHtml" runat="server" CssClass="edMegaMenu_deleteHtml" OnClick="deleteRightHtml" ToolTip="Remove content" EnableViewState="false">Delete content</asp:LinkButton>
							<asp:HyperLink ID="hlExistingRightContent" runat="server" Visible="false" CssClass="edMegaMenu_editHtml" EnableViewState="false">Edit content</asp:HyperLink>
						</div>
						<div id="divBottomHtmlColumn" runat="server" visible="false" class="edMegaMenu_verticalHtml edMegaMenu_htmlBottom" EnableViewState="false">
							<span>Bottom content</span>
							<asp:LinkButton ID="lbEditExistingBottomHtml" runat="server" CssClass="edMegaMenu_editHtml" OnClick="editBottomHtml" ToolTip="Edit content" EnableViewState="false">Edit content</asp:LinkButton>
							<asp:LinkButton ID="lbDeleteExistingBottomHtml" runat="server" CssClass="edMegaMenu_deleteHtml" OnClick="deleteBottomHtml" ToolTip="Remove content" EnableViewState="false">Delete content</asp:LinkButton>
							<asp:HyperLink ID="hlExistingBottomContent" runat="server" Visible="false" CssClass="edMegaMenu_editHtml" EnableViewState="false">Edit content</asp:HyperLink>
						</div>
						<div class="edMegaMenu_clear"></div>
						<asp:LinkButton ID="lbEditTopHtmlTrigger" runat="server" Visible="false" CssClass="edMegaMenu_addHtmlTriggers edMegaMenu_addTopHtml" OnClick="editTopHtml" EnableViewState="false">Top HTML</asp:LinkButton>
						<asp:LinkButton ID="lbEditBottomHtmlTrigger" runat="server" Visible="false" CssClass="edMegaMenu_addHtmlTriggers edMegaMenu_addBottomHtml" OnClick="editBottomHtml" EnableViewState="false">Bottom HTML</asp:LinkButton>
						<asp:LinkButton ID="lbEditLeftHtmlTrigger" runat="server" Visible="false" CssClass="edMegaMenu_addHtmlTriggers edMegaMenu_addLeftHtml" OnClick="editLeftHtml" EnableViewState="false">Left HTML</asp:LinkButton>
						<asp:LinkButton ID="lbEditRightHtmlTrigger" runat="server" Visible="false" CssClass="edMegaMenu_addHtmlTriggers edMegaMenu_addRightHtml" OnClick="editRightHtml" EnableViewState="false">Right HTML</asp:LinkButton>
						<asp:HyperLink ID="hlEditTopContent" runat="server" Visible="false" CssClass="edMegaMenu_addHtmlTriggers edMegaMenu_addTopHtml" EnableViewState="false">Top content</asp:HyperLink>
						<asp:HyperLink ID="hlEditBottomContent" runat="server" Visible="false" CssClass="edMegaMenu_addHtmlTriggers edMegaMenu_addBottomHtml" EnableViewState="false">Bottom content</asp:HyperLink>
						<asp:HyperLink ID="hlEditLeftContent" runat="server" Visible="false" CssClass="edMegaMenu_addHtmlTriggers edMegaMenu_addLeftHtml" EnableViewState="false">Left content</asp:HyperLink>
						<asp:HyperLink ID="hlEditRightContent" runat="server" Visible="false" CssClass="edMegaMenu_addHtmlTriggers edMegaMenu_addRightHtml" EnableViewState="false">Right content</asp:HyperLink>
					</asp:Panel>
				</asp:Panel>
				<asp:Panel ID="pnlMixedContent" runat="server" Visible="false" CssClass="edMegaMenu_mixedContent" EnableViewState="true">
					<div class="pure-control-group">
						<h3 id="h3ContentListSide" runat="server" EnableViewState="true" />
						<asp:Literal ID="contentList" runat="server" />
					</div>
					<div class="pure-control-group edMegaMenu_addModuleWrapper">
						<asp:Button ID="btnTabsUpdate" runat="server" style="display: none;" />
						<Portal:URL ID="ddlTabs" runat="server" EnableViewState="true" Width="250" ShowNewWindow="false" ShowUsers="false" ShowFiles="false" ShowLog="false" ShowSecure="false" IncludeActiveTab="true" ShowTabs="true" ShowTrack="false" ShowUpLoad="false" ShowUrls="false" ShowDatabase="false" UrlType="U" /><asp:DropDownList ID="ddlTabModules" runat="server" EnableViewState="true" /><asp:Button ID="btnAddModule" runat="server" CssClass="edMegaMenu_button" OnClick="AddModule" Text="Add module" EnableViewState="false" />
					</div>
					<div class="pure-control-group edMegaMenu_addHtmlWrapper">
						<asp:Button ID="btnAddHtml" runat="server" CssClass="edMegaMenu_button edMegaMenu_addHtml" OnClick="AddHtml" Text="Add html" EnableViewState="false" />
					</div>
				</asp:Panel>
				<asp:Panel ID="pnlHtmlEditor" runat="server" Visible="false" CssClass="edMegaMenu_htmlEditor" EnableViewState="true">
					<asp:LinkButton ID="lbSaveHtml" runat="server" OnClick="lbSaveHtml_Click" CssClass="edMegaMenu_button" EnableViewState="true">Save html</asp:LinkButton>
					<h3 id="h3HtmlEditorTitle" runat="server" EnableViewState="true" />
					<dnn:TextEditor ID="htmlEditor" runat="server" Width="800" Height="500" EnableViewState="true" HtmlEncode="false" />
					<asp:HiddenField ID="hfHtmlEditorSide" runat="server" EnableViewState="true" Value="" />
				</asp:Panel>
				<asp:Label ID="lblTemplateNotUpToDate" runat="server" CssClass="edMegaMenu_tempateNotUpToDateMsg" EnableViewState="false" Text="The settings have been changed. Regenerate the template to view the changes to the menu." Visible="false" />
				<asp:Button ID="btnRegenerateTemplate" runat="server" CssClass="edMegaMenu_button green" OnClick="generateMenuTemplate" Text="Generate template" Visible="false" EnableViewState="false" />
			</div>
		</div>
	</div>
</asp:Panel>