<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="DynamicFormCodeEditorControl.ascx.cs" Inherits="Revindex.Dnn.RevindexStorefront.WebUserControls.DynamicFormCodeEditorControl" %>
<%@ Register Assembly="DotNetNuke.Web.Deprecated" Namespace="DotNetNuke.Web.UI.WebControls" TagPrefix="dnn2" %>
<%@ Register Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI" TagPrefix="asp" %>
<div>
	<asp:UpdatePanel ID="EditorUpdatePanel" runat="server" UpdateMode="Conditional">
		<ContentTemplate>
			<asp:Panel runat="server" ID="DynamicFormCodeEditorPanel" CssClass="rvdsfFormDynamicFormCodeEditor">
				<dnn2:DnnMenu ID="DynamicFormCodeDnnMenu" runat="server" EnableShadows="true" Skin="Default" Width="100%" OnItemClick="DynamicFormCodeDnnMenu_ItemClick" Style="z-index: 7" EnableViewState="false">
					<Items>
						<dnn2:DnnMenuItem Text="New from template" Value="New From Template" ImageUrl="~/DesktopModules/Revindex.Dnn.RevindexStorefront/WebUserControls/Media/NewTemplateIcon.gif" />
						<dnn2:DnnMenuItem Text="Help" Value="Help" ImageUrl="~/DesktopModules/Revindex.Dnn.RevindexStorefront/WebUserControls/Media/HelpIcon.gif">
							<Items>
								<dnn2:DnnMenuItem Text="HTML tutorial" NavigateUrl="http://www.w3schools.com/html/" Target="_blank" />
								<dnn2:DnnMenuItem Text="CSS tutorial" NavigateUrl="http://www.w3schools.com/css/" Target="_blank" />
								<dnn2:DnnMenuItem Text="Javascript tutorial" NavigateUrl="http://www.w3schools.com/js/" Target="_blank" />
								<dnn2:DnnMenuItem Text="JQuery tutorial" NavigateUrl="http://www.w3schools.com/jquery/" Target="_blank" />
								<dnn2:DnnMenuItem Text="ASP.NET control reference" NavigateUrl="http://www.w3schools.com/aspnet/aspnet_refwebcontrols.asp" Target="_blank" />
								<dnn2:DnnMenuItem Text="Revindex forum" NavigateUrl="http://www.revindex.com/Support/Forum/tabid/132/forumid/2/scope/threads/Default.aspx" Target="_blank" />
							</Items>
						</dnn2:DnnMenuItem>
					</Items>
				</dnn2:DnnMenu>
				<asp:Label ID="SummaryLabel" runat="server" CssClass="rvdFormMessage rvdFormWarning" />
				<dnn2:DnnSplitter ID="CodeDnnSplitter" runat="server" Width="100%" Height="400px" BackColor="White">
					<dnn2:DnnSplitPane ID="CodeDnnSplitPane" runat="server" Width="100%" Scrolling="None">
						<dnn2:DnnMultiPage runat="server" ID="CodeDnnMultiPage" SelectedIndex="0" Height="371px" Width="100%" Style="margin-bottom: -1px" BorderStyle="Solid" BorderWidth="1px" ScrollBars="Auto" BorderColor="#CCCCCC">
							<dnn2:DnnPageView runat="server" ID="DesignCodeDnnPageView">
								<dnn2:DnnTreeView ID="CodeDnnTreeView" runat="server" Height="100%" Width="100%" OnClientContextMenuShowing="CodeDnnTreeView_ClientContextMenuShowing" OnClientContextMenuItemClicked="CodeDnnTreeView_ClientContextMenuClicked" OnClientNodeDropping="CodeDnnTreeView_ClientNodeDropping" EnableDragAndDrop="True" EnableDragAndDropBetweenNodes="True" OnClientLoad="CodeDnnTreeView_Load" EnableViewState="false">
									<ContextMenus>
										<dnn2:DnnTreeViewContextMenu ID="CodeDnnTreeViewContextMenu" runat="server">
											<Items />
											<CollapseAnimation Type="none" />
										</dnn2:DnnTreeViewContextMenu>
									</ContextMenus>
								</dnn2:DnnTreeView>
							</dnn2:DnnPageView>
							<dnn2:DnnPageView runat="server" ID="SourceCodeDnnPageView" Style="overflow: hidden">
								<asp:TextBox ID="CodeTextBox" runat="server" TextMode="MultiLine" Wrap="False" Height="368px" Width="100%" EnableViewState="False" OnChange="CodeTextBox_Change(this)"></asp:TextBox>
							</dnn2:DnnPageView>
						</dnn2:DnnMultiPage>
						<dnn2:DnnTabStrip ID="CodeDnnTabStrip" runat="server" Orientation="HorizontalBottom" MultiPageID="CodeDnnMultiPage" Skin="Default" SelectedIndex="0">
							<Tabs>
								<dnn2:DnnRadTab Text="Design">
								</dnn2:DnnRadTab>
								<dnn2:DnnRadTab Text="Source">
								</dnn2:DnnRadTab>
							</Tabs>
						</dnn2:DnnTabStrip>
					</dnn2:DnnSplitPane>
				</dnn2:DnnSplitter>
			</asp:Panel>
		</ContentTemplate>
	</asp:UpdatePanel>
</div>
