<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="XmlEditorControl.ascx.cs" Inherits="Revindex.Dnn.RevindexStorefront.WebUserControls.XmlEditorControl" %>
<%@ Register Assembly="DotNetNuke.Web.Deprecated" Namespace="DotNetNuke.Web.UI.WebControls" TagPrefix="dnn2" %>
<%@ Register Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI" TagPrefix="asp" %>
<div>
	<asp:UpdatePanel ID="EditorUpdatePanel" runat="server" UpdateMode="Conditional">
		<ContentTemplate>
			<asp:Panel runat="server" ID="XmlEditorPanel" CssClass="rvdsfFormXmlEditor">
				<dnn2:DnnMenu ID="XmlDnnMenu" runat="server" EnableShadows="true" Skin="Default" Width="100%" OnItemClick="XmlDnnMenu_ItemClick" Style="z-index: 7" EnableViewState="False">
					<Items>
						<dnn2:DnnMenuItem Text="New from template" Value="New From Template" ImageUrl="~/DesktopModules/Revindex.Dnn.RevindexStorefront/WebUserControls/Media/NewTemplateIcon.gif" />
						<dnn2:DnnMenuItem Text="Help" Value="Help" ImageUrl="~/DesktopModules/Revindex.Dnn.RevindexStorefront/WebUserControls/Media/HelpIcon.gif">
							<Items>
								<dnn2:DnnMenuItem Text="XML tutorial" NavigateUrl="http://www.w3schools.com/xml/" Target="_blank" />
								<dnn2:DnnMenuItem Text="Revindex forum" NavigateUrl="http://www.revindex.com/Support/Forum/tabid/132/forumid/2/scope/threads/Default.aspx" Target="_blank" />
							</Items>
						</dnn2:DnnMenuItem>
					</Items>
				</dnn2:DnnMenu>
				<asp:Label ID="SummaryLabel" runat="server" CssClass="rvdFormMessage rvdFormWarning" />
				<dnn2:DnnSplitter ID="XmlDnnSplitter" runat="server" Width="100%" Height="400px" BackColor="White">
					<dnn2:DnnSplitPane ID="XmlDnnSplitPane" runat="server" Width="100%" Scrolling="None">
						<dnn2:DnnMultiPage runat="server" ID="XmlDnnMultiPage" SelectedIndex="0" Height="371px" Width="100%" Style="margin-bottom: -1px" BorderStyle="Solid" BorderWidth="1px" ScrollBars="Auto" BorderColor="#CCCCCC">
							<dnn2:DnnPageView runat="server" ID="DesignXmlDnnPageView">
								<dnn2:DnnTreeView ID="XmlDnnTreeView" runat="server" Height="100%" Width="100%" OnClientContextMenuShowing="XmlDnnTreeView_ClientContextMenuShowing" OnClientContextMenuItemClicked="XmlDnnTreeView_ClientContextMenuClicked" OnClientNodeDropping="XmlDnnTreeView_ClientNodeDropping" EnableDragAndDrop="True" EnableDragAndDropBetweenNodes="True" OnClientLoad="XmlDnnTreeView_Load" EnableViewState="false">
									<ContextMenus>
										<dnn2:DnnTreeViewContextMenu ID="XmlDnnTreeViewContextMenu" runat="server">
											<Items />
											<CollapseAnimation Type="none" />
										</dnn2:DnnTreeViewContextMenu>
									</ContextMenus>
								</dnn2:DnnTreeView>
							</dnn2:DnnPageView>
							<dnn2:DnnPageView runat="server" ID="SourceXmlDnnPageView" Style="overflow: hidden">
								<asp:TextBox ID="XmlTextBox" runat="server" TextMode="MultiLine" Height="344px" Width="100%" Wrap="False" EnableViewState="False" OnChange="XmlTextBox_Change(this)"></asp:TextBox>
							</dnn2:DnnPageView>
						</dnn2:DnnMultiPage>
						<dnn2:DnnTabStrip ID="XmlDnnTabStrip" runat="server" Orientation="HorizontalBottom" MultiPageID="XmlDnnMultiPage" Skin="Default" SelectedIndex="0">
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
