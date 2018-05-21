<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="FormulaEditorControl.ascx.cs" Inherits="Revindex.Dnn.RevindexStorefront.WebUserControls.FormulaEditorControl" %>
<%@ Register Assembly="DotNetNuke.Web.Deprecated" Namespace="DotNetNuke.Web.UI.WebControls" TagPrefix="dnn2" %>
<%@ Register Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI" TagPrefix="asp" %>
<div>
	<asp:UpdatePanel ID="EditorUpdatePanel" runat="server" UpdateMode="Conditional">
		<ContentTemplate>
			<asp:Panel runat="server" ID="FormulaEditorPanel" CssClass="rvdsfFormFormulaEditor">
				<dnn2:DnnMenu ID="FormulaDnnMenu" runat="server" EnableShadows="true" Skin="Default" Width="100%" OnItemClick="FormulaDnnMenu_ItemClick" Style="z-index: 7" EnableViewState="False">
					<Items>
						<dnn2:DnnMenuItem Text="New from template" Value="New From Template" ImageUrl="~/DesktopModules/Revindex.Dnn.RevindexStorefront/WebUserControls/Media/NewTemplateIcon.gif" />
						<dnn2:DnnMenuItem Text="Run test" Value="Run Test" ImageUrl="~/DesktopModules/Revindex.Dnn.RevindexStorefront/WebUserControls/Media/RunTestIcon.gif" />
						<dnn2:DnnMenuItem Text="Help" Value="Help" ImageUrl="~/DesktopModules/Revindex.Dnn.RevindexStorefront/WebUserControls/Media/HelpIcon.gif">
							<Items>
								<dnn2:DnnMenuItem Text="XML tutorial" NavigateUrl="http://www.w3schools.com/xml/" Target="_blank" />
								<dnn2:DnnMenuItem Text="XSLT tutorial" NavigateUrl="http://www.w3schools.com/xsl/" Target="_blank" />
								<dnn2:DnnMenuItem Text="Revindex forum" NavigateUrl="http://www.revindex.com/Support/Forum/tabid/132/forumid/2/scope/threads/Default.aspx" Target="_blank" />
							</Items>
						</dnn2:DnnMenuItem>
					</Items>
				</dnn2:DnnMenu>
				<asp:Label ID="SummaryLabel" runat="server" CssClass="rvdFormMessage rvdFormWarning" />
				<dnn2:DnnSplitter ID="FormulaDnnSplitter" runat="server" Width="100%" Height="400px" BackColor="White">
					<dnn2:DnnSplitPane ID="SampleInputDnnSplitPane" runat="server" Width="22px" Scrolling="None">
						<dnn2:DnnSplitSlidingZone ID="SampleInputRadSlidingZone" runat="server" Width="22px" SlideDirection="Right">
							<dnn2:DnnSplitSlidingPane ID="SampleInputRadSlidingPane" Title="Sample Input" runat="server" Width="250px" Scrolling="None">
								<dnn2:DnnMultiPage runat="server" ID="SampleInputDnnMultiPage" SelectedIndex="0" Height="345px" Width="100%" Style="margin-bottom: -1px" BorderStyle="Solid" BorderWidth="1px" ScrollBars="Auto" BorderColor="#CCCCCC">
									<dnn2:DnnPageView runat="server" ID="DesignSampleInputDnnPageView">
										<dnn2:DnnTreeView ID="SampleInputDnnTreeView" runat="server" Height="100%" Width="100%" OnClientContextMenuShowing="SampleInputDnnTreeView_ClientContextMenuShowing" OnClientContextMenuItemClicked="SampleInputDnnTreeView_ClientContextMenuClicked" OnClientNodeDropping="SampleInputDnnTreeView_ClientNodeDropping" EnableDragAndDrop="True" EnableDragAndDropBetweenNodes="True" OnClientLoad="SampleInputDnnTreeView_Load" EnableViewState="false">
											<ContextMenus>
												<dnn2:DnnTreeViewContextMenu ID="SampleInputDnnTreeViewContextMenu" runat="server">
													<Items />
													<CollapseAnimation Type="none" />
												</dnn2:DnnTreeViewContextMenu>
											</ContextMenus>
										</dnn2:DnnTreeView>
									</dnn2:DnnPageView>
									<dnn2:DnnPageView runat="server" ID="SourceSampleInputDnnPageView" Style="overflow: hidden">
										<asp:TextBox ID="SampleInputTextBox" runat="server" TextMode="MultiLine" Height="344px" Width="100%" Wrap="False" OnChange="SampleInputTextBox_Change(this)"></asp:TextBox>
									</dnn2:DnnPageView>
								</dnn2:DnnMultiPage>
								<dnn2:DnnTabStrip ID="SampleInputDnnTabStrip" runat="server" Orientation="HorizontalBottom" MultiPageID="SampleInputDnnMultiPage" Skin="Default" SelectedIndex="0">
									<Tabs>
										<dnn2:DnnRadTab Text="Design">
										</dnn2:DnnRadTab>
										<dnn2:DnnRadTab Text="Source">
										</dnn2:DnnRadTab>
									</Tabs>
								</dnn2:DnnTabStrip>
							</dnn2:DnnSplitSlidingPane>
						</dnn2:DnnSplitSlidingZone>
					</dnn2:DnnSplitPane>
					<dnn2:DnnSplitBar ID="SampleInputDnnSplitBar" runat="server" />
					<dnn2:DnnSplitPane ID="RuleDnnSplitPane" runat="server" Width="100%" Scrolling="None">
						<dnn2:DnnMultiPage runat="server" ID="RuleDnnMultiPage" SelectedIndex="0" Height="371px" Width="100%" Style="margin-bottom: -1px" BorderStyle="Solid" BorderWidth="1px" ScrollBars="Auto" BorderColor="#CCCCCC">
							<dnn2:DnnPageView runat="server" ID="DesignRuleDnnPageView">
								<dnn2:DnnTreeView ID="RuleDnnTreeView" runat="server" Height="100%" Width="100%" OnClientContextMenuShowing="RuleDnnTreeView_ClientContextMenuShowing" OnClientContextMenuItemClicked="RuleDnnTreeView_ClientContextMenuClicked" OnClientNodeDropping="RuleDnnTreeView_ClientNodeDropping" EnableDragAndDrop="True" EnableDragAndDropBetweenNodes="True" OnClientLoad="RuleDnnTreeView_Load" EnableViewState="false">
									<ContextMenus>
										<dnn2:DnnTreeViewContextMenu ID="RuleDnnTreeViewContextMenu" runat="server">
											<Items />
											<CollapseAnimation Type="none" />
										</dnn2:DnnTreeViewContextMenu>
									</ContextMenus>
								</dnn2:DnnTreeView>
							</dnn2:DnnPageView>
							<dnn2:DnnPageView runat="server" ID="SourceRuleDnnPageView" Style="overflow: hidden">
								<asp:TextBox ID="RuleTextBox" runat="server" TextMode="MultiLine" Wrap="False" Height="368px" Width="100%" EnableViewState="False" OnChange="RuleTextBox_Change(this)"></asp:TextBox>
							</dnn2:DnnPageView>
						</dnn2:DnnMultiPage>
						<dnn2:DnnTabStrip ID="RuleDnnTabStrip" runat="server" Orientation="HorizontalBottom" MultiPageID="RuleDnnMultiPage" Skin="Default" SelectedIndex="0">
							<Tabs>
								<dnn2:DnnRadTab Text="Design">
								</dnn2:DnnRadTab>
								<dnn2:DnnRadTab Text="Source">
								</dnn2:DnnRadTab>
							</Tabs>
						</dnn2:DnnTabStrip>
					</dnn2:DnnSplitPane>
					<dnn2:DnnSplitBar ID="OutputDnnSplitBar" runat="server" />
					<dnn2:DnnSplitPane ID="OutputDnnSplitPane" runat="server" Width="22px" Scrolling="None">
						<dnn2:DnnSplitSlidingZone ID="OutputRadSlidingZone" runat="server" Width="22px" SlideDirection="Left">
							<dnn2:DnnSplitSlidingPane ID="OutputRadSlidingPane" Title="Output" runat="server" Width="245px" Scrolling="None">
								<dnn2:DnnMultiPage runat="server" ID="OutputDnnMultiPage" SelectedIndex="0" Height="345px" Width="100%" Style="margin-bottom: -1px" BorderStyle="Solid" BorderWidth="1px" ScrollBars="Auto" BorderColor="#CCCCCC">
									<dnn2:DnnPageView runat="server" ID="DesignOutputDnnPageView">
										<dnn2:DnnTreeView ID="OutputDnnTreeView" runat="server" Height="100%" Width="100%" OnClientLoad="OutputDnnTreeView_Load" EnableViewState="false">
										</dnn2:DnnTreeView>
									</dnn2:DnnPageView>
									<dnn2:DnnPageView runat="server" ID="SourceOutputDnnPageView" Style="overflow: hidden">
										<asp:TextBox ID="OutputTextBox" runat="server" ReadOnly="True" TextMode="MultiLine" Height="344px" Width="100%" Wrap="False" EnableViewState="False"></asp:TextBox>
									</dnn2:DnnPageView>
								</dnn2:DnnMultiPage>
								<dnn2:DnnTabStrip ID="OutputDnnTabStrip" runat="server" Orientation="HorizontalBottom" MultiPageID="OutputDnnMultiPage" Skin="Default" SelectedIndex="0">
									<Tabs>
										<dnn2:DnnRadTab Text="Design">
										</dnn2:DnnRadTab>
										<dnn2:DnnRadTab Text="Source">
										</dnn2:DnnRadTab>
									</Tabs>
								</dnn2:DnnTabStrip>
							</dnn2:DnnSplitSlidingPane>
						</dnn2:DnnSplitSlidingZone>
					</dnn2:DnnSplitPane>
				</dnn2:DnnSplitter>
			</asp:Panel>
		</ContentTemplate>
	</asp:UpdatePanel>
</div>
