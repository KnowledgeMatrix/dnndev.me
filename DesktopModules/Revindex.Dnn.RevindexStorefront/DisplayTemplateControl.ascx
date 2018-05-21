<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="DisplayTemplateControl.ascx.cs" Inherits="Revindex.Dnn.RevindexStorefront.DisplayTemplateControl" %>
<%@ Register Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Src="~/Controls/labelcontrol.ascx" TagName="LabelControl" TagPrefix="dnn1" %>
<%@ Register Assembly="DotNetNuke.Web.Deprecated" Namespace="DotNetNuke.Web.UI.WebControls" TagPrefix="dnn2" %>
<%@ Register Assembly="DotNetNuke.Web.Client" Namespace="DotNetNuke.Web.Client.ClientResourceManagement" TagPrefix="dnn2" %>
<%@ Register Src="DisplayTemplateDropDownListControl.ascx" TagName="DisplayTemplateDropDownListControl" TagPrefix="uc1" %>
<%@ Register Src="WebUserControls/Common/Dnn/BackControl.ascx" TagName="BackControl" TagPrefix="uc1" %>
<%@ Register Src="WebUserControls/Common/Dnn/BreadcrumbControl.ascx" TagName="BreadcrumbControl" TagPrefix="uc1" %>
<dnn2:DnnCssInclude runat="server" FilePath="~/Resources/Shared/components/CodeEditor/lib/codemirror.css" />
<dnn2:DnnCssInclude runat="server" FilePath="~/Resources/Shared/components/CodeEditor/addon/merge/merge.css" />
<dnn2:DnnJsInclude runat="server" FilePath="~/Resources/Shared/components/CodeEditor/lib/codemirror.js" Priority="1" />
<dnn2:DnnJsInclude runat="server" FilePath="~/Resources/Shared/components/CodeEditor/mode/javascript/javascript.js" Priority="2" />
<dnn2:DnnJsInclude runat="server" FilePath="~/Resources/Shared/components/CodeEditor/mode/css/css.js" Priority="3" />
<dnn2:DnnJsInclude runat="server" FilePath="~/Resources/Shared/components/CodeEditor/mode/htmlmixed/htmlmixed.js" Priority="4" />
<dnn2:DnnJsInclude runat="server" FilePath="~/Resources/Shared/components/CodeEditor/mode/xml/xml.js" Priority="5" />
<dnn2:DnnJsInclude runat="server" FilePath="https://cdnjs.cloudflare.com/ajax/libs/diff_match_patch/20121119/diff_match_patch.js" Priority="6" />
<dnn2:DnnJsInclude runat="server" FilePath="~/Resources/Shared/components/CodeEditor/addon/merge/merge.js" Priority="7" />
<div>
	<asp:PlaceHolder ID="MessagePlaceHolder" runat="server" />
	<asp:MultiView ID="ContentMultiView" runat="server">
		<asp:View ID="ListView" runat="server">
			<uc1:BackControl ID="BackControl2" runat="server" Text="" CssClass="rvdsfBackAction" />
			<h2>Display templates</h2>
			<div class="dnnForm rvdsfListContainer">
				<asp:GridView ID="DisplayTemplateGridView" runat="server" CssClass="dnnGrid" GridLines="None" AutoGenerateColumns="False" DataKeyNames="DisplayTemplatePath,DisplayTemplateName,ModuleControl" OnRowDeleting="DisplayTemplateGridView_RowDeleting" OnRowDataBound="DisplayTemplateGridView_RowDataBound" AllowSorting="True" OnRowCommand="DisplayTemplateGridView_RowCommand">
					<AlternatingRowStyle CssClass="dnnGridAltItem" />
					<HeaderStyle CssClass="dnnGridHeader" />
					<RowStyle CssClass="dnnGridItem" />
					<SelectedRowStyle CssClass="dnnGridSelectedItem" />
					<FooterStyle CssClass="dnnGridFooter" />
					<PagerStyle CssClass="dnnGridPager" />
					<Columns>
						<asp:TemplateField>
							<ItemTemplate>
								<asp:HyperLink ID="SelectHyperLink" runat="server" CssClass="rvdEditGridAction" />
							</ItemTemplate>
						</asp:TemplateField>
						<asp:TemplateField>
							<ItemTemplate>
								<asp:LinkButton ID="CloneLinkButton" runat="server" CommandName="Clone" CausesValidation="false" CssClass="rvdCopyGridAction" ToolTip="Clone" CommandArgument='<%# Eval("DisplayTemplatePath") %>'></asp:LinkButton>
							</ItemTemplate>
						</asp:TemplateField>
						<asp:TemplateField>
							<ItemTemplate>
								<asp:LinkButton ID="DeleteLinkButton" runat="server" CausesValidation="False" CommandName="Delete" OnClientClick="return confirm('Are you sure you want to delete this item?')" CssClass="rvdDeleteGridAction"></asp:LinkButton>
							</ItemTemplate>
						</asp:TemplateField>
						<asp:BoundField DataField="ModuleControl" HeaderText="Module control" />
						<asp:BoundField DataField="DisplayTemplateName" HeaderText="Name" />
					</Columns>
				</asp:GridView>
				<ul class="dnnActions dnnClear">
					<li>
						<asp:HyperLink ID="AddHyperLink" runat="server" Text="Add new" CssClass="dnnPrimaryAction rvdAddNewAction" />
					</li>
				</ul>
			</div>
		</asp:View>
		<asp:View ID="DetailsView" runat="server">
			<uc1:BackControl ID="QuickBackControl" runat="server" Text="" CssClass="rvdsfBackAction" />
			<h2>Display template: <uc1:BreadcrumbControl ID="BreadcrumbControl" runat="server" /></h2>
			<div class="dnnForm">
				<fieldset>
					<div class="dnnFormItem">
						<dnn1:LabelControl ID="ModuleControlLabelControl" runat="server" Text="Module control:" CssClass="dnnFormRequired" />
						<asp:DropDownList ID="ModuleControlDropDownList" runat="server" OnSelectedIndexChanged="ModuleControlDropDownList_SelectedIndexChanged" AutoPostBack="True">
							<asp:ListItem Value="Cart">Cart</asp:ListItem>
							<asp:ListItem Value="CartSummary">Cart Summary</asp:ListItem>
							<asp:ListItem Value="Category">Category</asp:ListItem>
							<asp:ListItem Value="Checkout">Checkout</asp:ListItem>
							<asp:ListItem Value="Confirmation">Confirmation</asp:ListItem>
							<asp:ListItem Value="Distributor">Distributor</asp:ListItem>
							<asp:ListItem Value="Manufacturer">Manufacturer</asp:ListItem>
							<asp:ListItem Value="ProductComparison">Product Comparison</asp:ListItem>
							<asp:ListItem Value="ProductDetail">Product Detail</asp:ListItem>
							<asp:ListItem Value="ProductFilter">Product Filter</asp:ListItem>
							<asp:ListItem Value="ProductList">Product List</asp:ListItem>
							<asp:ListItem Value="ProductSearch">Product Search</asp:ListItem>
							<asp:ListItem Value="ProductShowcase">Product Showcase</asp:ListItem>
							<asp:ListItem Value="QuickOrder">Quick Order</asp:ListItem>
							<asp:ListItem Value="WishList">WishList</asp:ListItem>
						</asp:DropDownList>
					</div>
					<div class="dnnFormItem">
						<dnn1:LabelControl ID="NameLabelControl" runat="server" HelpText="Enter a name for this custom template (e.g. &quot;Featured1&quot;)" Text="Name:" CssClass="dnnFormRequired" />
						<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="NameTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="DisplayTemplateDetailsViewControl">Name is required.</asp:RequiredFieldValidator>
						<asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="NameTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationExpression="^\w+$" ValidationGroup="DisplayTemplateDetailsViewControl">Name is invalid.</asp:RegularExpressionValidator>
						<asp:TextBox ID="NameTextBox" runat="server" MaxLength="30" CssClass="dnnFormRequired"></asp:TextBox>
					</div>
					<div class="dnnFormItem">
						<dnn1:LabelControl ID="BaseDisplayTemplateLabelControl" runat="server" HelpText="This template will derive the logic from the base template. It's recommended to use the latest base template with the highest suffix number." Text="Base display template:" />
						<uc1:DisplayTemplateDropDownListControl ID="BaseDisplayTemplateDropDownList" runat="server" AutoPostBack="True" CausesValidation="False" />
						<asp:Label ID="BaseDisplayTemplateLabel" runat="server" Text=""></asp:Label>
					</div>
					<asp:Label ID="ObsoleteWarningLabel" runat="server" CssClass="rvdFormMessage rvdFormWarning" Text="This base template is obsolete & may be removed in future versions. Please create a new template from the latest base template to gain new features."></asp:Label>
					<asp:Label ID="UnsupportedWarningLabel" runat="server" CssClass="rvdFormMessage rvdFormWarning" Text="This base template is obsolete & have been removed. Please create a new template from the latest base template to gain new features."></asp:Label>
                    <div class="dnnFormItem">
						<dnn1:LabelControl ID="TypeLabelControl" runat="server" Text="Type:" />
						<asp:Label ID="TypeLabel" runat="server"></asp:Label>
					</div>
					<div class="dnnFormItem">
						<div class="rvdsfFormCodeEditor">
							<script type="text/javascript">
								function rvdsfWrapTextArea(wrap)
								{
									if (wrap)
									{
										if (rvdsfFormCodeEditor)
										{
											// Only change wrap mode if not in mergeview mode
											if (!rvdsfFormCodeEditor.editor)
												rvdsfFormCodeEditor.setOption("lineWrapping", true);
										}
										else
											$('#<%= CodeTextBox.ClientID %>').attr("wrap", "soft");
											}
											else
											{
												if (rvdsfFormCodeEditor)
												{
													// Only change wrap mode if not in mergeview mode
													if (!rvdsfFormCodeEditor.editor)
														rvdsfFormCodeEditor.setOption("lineWrapping", false);
												}
												else
													$('#<%= CodeTextBox.ClientID %>').attr("wrap", "off");
											}
										}
							</script>
							<dnn2:DnnMenu ID="CodeDnnMenu" runat="server" EnableShadows="true" Skin="Default" Width="100%" Style="z-index: 7">
								<Items>
									<dnn2:DnnMenuItem Text="Help" Value="Help" ImageUrl="~/DesktopModules/Revindex.Dnn.RevindexStorefront/WebUserControls/Media/HelpIcon.gif">
										<Items>
											<dnn2:DnnMenuItem Text="HTML tutorial" NavigateUrl="http://www.w3schools.com/html/" Target="_blank" />
											<dnn2:DnnMenuItem Text="CSS tutorial" NavigateUrl="http://www.w3schools.com/css/" Target="_blank" />
											<dnn2:DnnMenuItem Text="Javascript tutorial" NavigateUrl="http://www.w3schools.com/js/" Target="_blank" />
											<dnn2:DnnMenuItem Text="JQuery tutorial" NavigateUrl="http://www.w3schools.com/jquery/" Target="_blank" />
											<dnn2:DnnMenuItem Text="ASP.NET Control reference" NavigateUrl="http://www.w3schools.com/aspnet/aspnet_refwebcontrols.asp" Target="_blank" />
                                            <dnn2:DnnMenuItem Text="ASP.NET Razor reference" NavigateUrl="http://www.w3schools.com/asp/razor_intro.asp" Target="_blank" />
											<dnn2:DnnMenuItem Text="Revindex forum" NavigateUrl="http://www.revindex.com/Support/Forum/tabid/132/forumid/2/scope/threads/Default.aspx" Target="_blank" />
										</Items>
									</dnn2:DnnMenuItem>
								</Items>
							</dnn2:DnnMenu>
							<div>
								<div style="float: left; width: 50%">
									<asp:CheckBox ID="WrapCodeCheckBox" runat="server" Checked="true" OnClick="rvdsfWrapTextArea(this.checked)" Text="Word wrap" />
								</div>
								<div style="float: right; width: 50%; text-align: right">
									Compare with:
									<uc1:DisplayTemplateDropDownListControl ID="CompareDisplayTemplateDropDownList" runat="server" AutoPostBack="True" CausesValidation="False" />
								</div>
							</div>
							<div id="CodeTextPanel" style="clear: both">
								<asp:TextBox ID="CodeTextBox" runat="server" Rows="26" TextMode="MultiLine" Width="100%" Wrap="True" />
								<asp:TextBox ID="CompareTextBox" runat="server" TextMode="MultiLine" EnableViewState="false" Style="display: none" />
							</div>
						</div>
					</div>
				</fieldset>
				<ul class="dnnActions">
					<li>
						<asp:LinkButton ID="SaveLinkButton" runat="server" Text="Save" OnClick="SaveLinkButton_Click" CssClass="dnnPrimaryAction rvdSaveAction" ValidationGroup="DisplayTemplateDetailsViewControl" />
					</li>
					<li>
						<asp:LinkButton ID="SaveAndBackLinkButton" runat="server" Text="Save & return" OnClick="SaveLinkButton_Click" CommandArgument="Back" CssClass="dnnPrimaryAction rvdSaveAction" ValidationGroup="DisplayTemplateDetailsViewControl" />
					</li>
					<li>
						<uc1:BackControl ID="BackControl1" runat="server" Text="Cancel" />
					</li>
				</ul>
			</div>
		</asp:View>
	</asp:MultiView>
</div>
