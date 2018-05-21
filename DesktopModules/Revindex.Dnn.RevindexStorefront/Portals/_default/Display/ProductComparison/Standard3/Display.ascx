<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Display.ascx.cs" Inherits="Revindex.Dnn.RevindexStorefront.Portals._default.Display.ProductComparison.Standard3.Display" %>
<%@ Register Src="~/Controls/labelcontrol.ascx" TagName="LabelControl" TagPrefix="dnn1" %>
<%@ Register Assembly="DotNetNuke.Web.Deprecated" Namespace="DotNetNuke.Web.UI.WebControls" TagPrefix="dnn2" %>
<div class="rvdsfProductComparisonContainer">
	<asp:Label ID="MissingProductComparisonLabel" runat="server" CssClass="dnnFormMessage dnnFormWarning" resourcekey="MissingProductComparisonLabel.Text" />

	<script type="text/javascript">
		function RemoveProductComparison(id)
		{
			dnn.xmlhttp.callControlMethod('Revindex.Dnn.RevindexStorefront.Portals._default.Display.ProductComparison.Standard.Display', 'RemoveProductComparison', { productVariantID: id }, RemoveProductComparison_Callback, RemoveProductComparison_Callback);
		}

		function RemoveProductComparison_Callback()
		{
			location.reload();
		}
	</script>

	<dnn2:DnnGrid ID="ProductComparisonDnnGrid" runat="server" ItemStyle-CssClass="dnnGridItem" Width="100%" AlternatingItemStyle-CssClass="dnnGridAltItem" SelectedItemStyle-CssClass="dnnGridSelectedItem" CssClass="dnnGrid rvdsfProductComparisonGrid" GridLines="None" ShowHeader="true" ShowFooter="false" OnItemDataBound="ProductComparisonDnnGrid_ItemDataBound" Skin="">
		<HeaderStyle CssClass="dnnGridHeader" />
		<FooterStyle CssClass="dnnGridFooter" />
		<PagerStyle CssClass="dnnGridPager" />
		<MasterTableView AutoGenerateColumns="False" GroupLoadMode="Client" HeaderStyle-Wrap="False">
			<Columns>
				<dnn2:DnnGridTemplateColumn UniqueName="ComparisonFieldColumn" >
					<ItemTemplate>
						<dnn1:LabelControl ID="ComparisonFieldLabelControl" runat="server" Text='<%# Eval("ComparisonFieldLabelControl_Text") %>' HelpText='<%# Eval("ComparisonFieldLabelControl_HelpText") %>' />
					</ItemTemplate>
				</dnn2:DnnGridTemplateColumn>
				<dnn2:DnnGridTemplateColumn UniqueName="ComparisonValueColumn1">
					<ItemTemplate>
						<asp:Literal ID="ComparisonValueLiteral1" runat="server" Text='<%# Eval("ComparisonValueLiteral1_Text") %>' />
					</ItemTemplate>
					<HeaderTemplate>
						<asp:LinkButton ID="RemoveProductLinkButton1" runat="server" resourcekey="RemoveProductLinkButton" CssClass="dnnPrimaryAction rvdDeleteAction" >
						</asp:LinkButton>
					</HeaderTemplate>
				</dnn2:DnnGridTemplateColumn>
				<dnn2:DnnGridTemplateColumn UniqueName="ComparisonValueColumn2">
					<ItemTemplate>
						<asp:Literal ID="ComparisonValueLiteral2" runat="server" Text='<%# Eval("ComparisonValueLiteral2_Text") %>' />
					</ItemTemplate>
					<HeaderTemplate>
						<asp:LinkButton ID="RemoveProductLinkButton2" runat="server" resourcekey="RemoveProductLinkButton" CssClass="dnnPrimaryAction rvdDeleteAction" >
						</asp:LinkButton>
					</HeaderTemplate>
				</dnn2:DnnGridTemplateColumn>
				<dnn2:DnnGridTemplateColumn UniqueName="ComparisonValueColumn3">
					<ItemTemplate>
						<asp:Literal ID="ComparisonValueLiteral3" runat="server" Text='<%# Eval("ComparisonValueLiteral3_Text") %>' />
					</ItemTemplate>
					<HeaderTemplate>
						<asp:LinkButton ID="RemoveProductLinkButton3" runat="server" resourcekey="RemoveProductLinkButton" CssClass="dnnPrimaryAction rvdDeleteAction" >
						</asp:LinkButton>
					</HeaderTemplate>
				</dnn2:DnnGridTemplateColumn>
				<dnn2:DnnGridTemplateColumn UniqueName="ComparisonValueColumn4">
					<ItemTemplate>
						<asp:Literal ID="ComparisonValueLiteral4" runat="server" Text='<%# Eval("ComparisonValueLiteral4_Text") %>' />
					</ItemTemplate>
					<HeaderTemplate>
						<asp:LinkButton ID="RemoveProductLinkButton4" runat="server" resourcekey="RemoveProductLinkButton" CssClass="dnnPrimaryAction rvdDeleteAction" >
						</asp:LinkButton>
					</HeaderTemplate>
				</dnn2:DnnGridTemplateColumn>
				<dnn2:DnnGridTemplateColumn UniqueName="ComparisonValueColumn5">
					<ItemTemplate>
						<asp:Literal ID="ComparisonValueLiteral5" runat="server" Text='<%# Eval("ComparisonValueLiteral5_Text") %>' />
					</ItemTemplate>
					<HeaderTemplate>
						<asp:LinkButton ID="RemoveProductLinkButton5" runat="server" resourcekey="RemoveProductLinkButton" CssClass="dnnPrimaryAction rvdDeleteAction" >
						</asp:LinkButton>
					</HeaderTemplate>
				</dnn2:DnnGridTemplateColumn>
				<dnn2:DnnGridTemplateColumn UniqueName="ComparisonValueColumn6">
					<ItemTemplate>
						<asp:Literal ID="ComparisonValueLiteral6" runat="server" Text='<%# Eval("ComparisonValueLiteral6_Text") %>' />
					</ItemTemplate>
					<HeaderTemplate>
						<asp:LinkButton ID="RemoveProductLinkButton6" runat="server" resourcekey="RemoveProductLinkButton" CssClass="dnnPrimaryAction rvdDeleteAction" >
						</asp:LinkButton>
					</HeaderTemplate>
				</dnn2:DnnGridTemplateColumn>
				<dnn2:DnnGridTemplateColumn UniqueName="ComparisonValueColumn7">
					<ItemTemplate>
						<asp:Literal ID="ComparisonValueLiteral7" runat="server" Text='<%# Eval("ComparisonValueLiteral7_Text") %>' />
					</ItemTemplate>
					<HeaderTemplate>
						<asp:LinkButton ID="RemoveProductLinkButton7" runat="server" resourcekey="RemoveProductLinkButton" CssClass="dnnPrimaryAction rvdDeleteAction" >
						</asp:LinkButton>
					</HeaderTemplate>
				</dnn2:DnnGridTemplateColumn>
				<dnn2:DnnGridTemplateColumn UniqueName="ComparisonValueColumn8">
					<ItemTemplate>
						<asp:Literal ID="ComparisonValueLiteral8" runat="server" Text='<%# Eval("ComparisonValueLiteral8_Text") %>' />
					</ItemTemplate>
					<HeaderTemplate>
						<asp:LinkButton ID="RemoveProductLinkButton8" runat="server" resourcekey="RemoveProductLinkButton" CssClass="dnnPrimaryAction rvdDeleteAction" >
						</asp:LinkButton>
					</HeaderTemplate>
				</dnn2:DnnGridTemplateColumn>
			</Columns>
		</MasterTableView>
		<ClientSettings>
			<Scrolling AllowScroll="False" UseStaticHeaders="false" SaveScrollPosition="true" FrozenColumnsCount="0"></Scrolling>
		</ClientSettings>
	</dnn2:DnnGrid>
</div>