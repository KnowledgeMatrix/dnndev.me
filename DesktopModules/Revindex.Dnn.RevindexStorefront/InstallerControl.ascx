<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="InstallerControl.ascx.cs" Inherits="Revindex.Dnn.RevindexStorefront.InstallerControl" %>
<%@ Register Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Src="~/Controls/labelcontrol.ascx" TagName="LabelControl" TagPrefix="dnn1" %>
<%@ Register Src="~/Controls/urlcontrol.ascx" TagName="UrlControl" TagPrefix="dnn1" %>
<%@ Register Assembly="DotNetNuke.Web.Deprecated" Namespace="DotNetNuke.Web.UI.WebControls" TagPrefix="dnn2" %>
<div>
	<h2>Installer</h2>
	<asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
		<ContentTemplate>
			<asp:PlaceHolder ID="MessagePlaceHolder" runat="server"></asp:PlaceHolder>
			<asp:MultiView ID="InstallerMultiView" runat="server">
				<asp:View ID="InstallView" runat="server">
					<asp:Panel ID="InstallListViewPanel" runat="server" CssClass="dnnForm">
						<p>Revindex Storefront is composed of multiple modules that should reside on different pages for a rich shopping cart experience. We recommend adding the selected modules to the suggested pages below to get started quickly. You can always rename, move or add more modules later.</p>
						<asp:GridView ID="InstallModuleControlGridView" runat="server" CssClass="dnnGrid rvdsfInstallerGrid" GridLines="None" AutoGenerateColumns="False" Width="100%" OnSelectedIndexChanged="InstallModuleControlGridView_SelectedIndexChanged" DataKeyNames="ID">
							<AlternatingRowStyle CssClass="dnnGridAltItem" />
							<HeaderStyle CssClass="dnnGridHeader" />
							<RowStyle CssClass="dnnGridItem" />
							<SelectedRowStyle CssClass="dnnGridSelectedItem" />
							<FooterStyle CssClass="dnnGridFooter" />
							<PagerStyle CssClass="dnnGridPager" />
							<Columns>
								<asp:TemplateField>
									<HeaderTemplate>
										<input onclick="if ($(this).is(':checked')) { $('.rvdsfInstallerGrid :checkbox').each(function () { this.checked = true; }) } else { $('.rvdsfInstallerGrid :checkbox').each(function () { this.checked = false; }) }" runat="server" type="checkbox" />
									</HeaderTemplate>
									<ItemTemplate>
										<asp:CheckBox ID="IncludeCheckBox" runat="server" Checked='<%# Eval("Include") %>' />
									</ItemTemplate>
								</asp:TemplateField>
								<asp:CommandField ShowSelectButton="True" SelectText="" ControlStyle-CssClass="rvdEditGridAction" />
								<asp:TemplateField HeaderText="Module">
									<ItemTemplate>
										<strong>
											<asp:Label runat="server" Text='<%# Eval("FriendlyName") %>'></asp:Label></strong><asp:Label runat="server" Visible='<%# Eval("Required") %>'> <em style="color: red">(required)</em></asp:Label>
									</ItemTemplate>
								</asp:TemplateField>
								<asp:BoundField DataField="Description" HeaderText="Description" />
								<asp:BoundField DataField="TargetPageName" HeaderText="Page" />
							</Columns>
						</asp:GridView>
						<ul class="dnnActions dnnClear">
							<li>
								<asp:LinkButton ID="InstallLinkButton" runat="server" Text="Add selected modules" OnClick="InstallLinkButton_Click" CssClass="dnnPrimaryAction">
								</asp:LinkButton>
							</li>
							<li>
								<asp:LinkButton ID="CancelLinkButton" runat="server" Text="No, thanks. I will manually add modules later" OnClick="CancelLinkButton_Click" CssClass="dnnSecondaryAction rvdCancelAction" ValidationGroup="InstallerControl" CausesValidation="False">
								</asp:LinkButton>
							</li>
							<li>
								<asp:LinkButton CssClass="dnnSecondaryAction" ID="UninstallLinkButton" runat="server" Text="Uninstall Revindex Storefront" OnClick="UninstallLinkButton_Click" OnClientClick="return confirm('Are you sure you want to completely uninstall this software? Uninstalling will delete all the Storefront data permanently.')" CausesValidation="False">
								</asp:LinkButton>
							</li>
						</ul>
					</asp:Panel>
					<asp:Panel ID="InstallDetailsViewPanel" runat="server" CssClass="dnnForm">
						<fieldset>
							<div class="dnnFormItem">
								<dnn1:LabelControl ID="InstallModuleTitleLabelControl" runat="server" Text="Module title:" HelpText="Enter a friendly title for the module control." CssClass="dnnFormRequired" />
								<asp:RequiredFieldValidator ID="InstallModuleTitleRequiredFieldValidator" runat="server" ControlToValidate="InstallModuleTitleTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic">Module title is required.</asp:RequiredFieldValidator>
								<asp:TextBox ID="InstallModuleTitleTextBox" runat="server" CssClass="dnnFormRequired"></asp:TextBox>
							</div>
							<div class="dnnFormItem">
								<dnn1:LabelControl ID="TargetPageModeLabelControl" runat="server" Text="Page mode:" />
								<asp:RadioButtonList ID="InstallUrlModeRadioButtonList" runat="server" CssClass="dnnFormRadioButtons" OnSelectedIndexChanged="InstallUrlModeRadioButtonList_SelectedIndexChanged" AutoPostBack="True" RepeatLayout="Flow" RepeatDirection="Horizontal">
									<asp:ListItem Text="Create a new page if not exist" Value="New" />
									<asp:ListItem Text="Choose from existing page" Value="Existing" />
								</asp:RadioButtonList>
							</div>
							<div class="dnnFormItem">
								<dnn1:LabelControl ID="InstallTargetPageLabelControl" runat="server" Text="Target page:" CssClass="dnnFormRequired" />
								<asp:MultiView ID="InstallUrlMultiView" runat="server">
									<asp:View ID="InstallUrlNewTabView" runat="server">
										<asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="InstallUrlNewTabTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="InstallerControl"></asp:RequiredFieldValidator>
										<asp:TextBox ID="InstallUrlNewTabTextBox" runat="server" CssClass="dnnFormRequired"></asp:TextBox>
									</asp:View>
									<asp:View ID="InstallUrlExistingTabView" runat="server">
										<dnn1:UrlControl ID="InstallTargetPageUrlControl" runat="server" IncludeActiveTab="False" ShowDatabase="False" ShowFiles="False" ShowImages="False" ShowLog="false" ShowNewWindow="False" ShowNone="False" ShowSecure="False" ShowTabs="True" ShowTrack="false" ShowUpLoad="False" ShowUrls="False" ShowUsers="false" />
									</asp:View>
								</asp:MultiView>
							</div>
							<div class="dnnFormItem">
								<dnn1:LabelControl ID="InstallTargetPaneLabelControl" runat="server" Text="Target pane:" CssClass="dnnFormRequired" />
								<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="InstallTargetPaneTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="InstallerControl">Target pane is required.</asp:RequiredFieldValidator>
								<asp:TextBox ID="InstallTargetPaneTextBox" runat="server" CssClass="dnnFormRequired"></asp:TextBox>
							</div>
						</fieldset>
						<ul class="dnnActions dnnClear">
							<li>
								<asp:LinkButton ID="SaveInstallDetailsViewLinkButton" runat="server" Text="Save" OnClick="SaveInstallDetailsViewLinkButton_Click" CssClass="dnnPrimaryAction rvdSaveAction" ValidationGroup="InstallerControl">
								</asp:LinkButton>
							</li>
							<li>
								<asp:LinkButton ID="CancelInstallDetailsViewLinkButton" runat="server" Text="Cancel" OnClick="CancelInstallDetailsViewLinkButton_Click" CssClass="dnnSecondaryAction rvdCancelAction" ValidationGroup="InstallerControl" CausesValidation="False">
								</asp:LinkButton>
							</li>
						</ul>
					</asp:Panel>
				</asp:View>
				<asp:View ID="ConfirmationView" runat="server">
					<div class="dnnForm">
						<span class="dnnFormMessage dnnFormSuccess">Installation completed. Please review log below for any errors.</span>
						<hr />
						<div style="width: 100%; padding: 10px; margin: 10px; overflow: auto; height: 200px;">
							<asp:Label ID="ConfirmationLogLabel" runat="server"></asp:Label>
						</div>
						<ul class="dnnActions dnnClear">
							<li>
								<asp:HyperLink ID="ReturnHyperLink" runat="server" Text="Return" CssClass="dnnPrimaryAction rvdReturnAction"></asp:HyperLink>
							</li>
						</ul>
					</div>
				</asp:View>
			</asp:MultiView>
		</ContentTemplate>
	</asp:UpdatePanel>
</div>
