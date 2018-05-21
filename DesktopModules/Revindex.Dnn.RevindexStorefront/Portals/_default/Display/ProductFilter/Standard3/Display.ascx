<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Display.ascx.cs" Inherits="Revindex.Dnn.RevindexStorefront.Portals._default.Display.ProductFilter.Standard3.Display" %>
<%@ Register Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI.WebControls" TagPrefix="asp" %>
<%@ Register Src="~/Controls/labelcontrol.ascx" TagName="LabelControl" TagPrefix="dnn1" %>
<%@ Register Assembly="DotNetNuke.Web.Deprecated" Namespace="DotNetNuke.Web.UI.WebControls" TagPrefix="dnn2" %>
<div class="rvdsfProductFilterContainer">
	<div class="rvdsfProductFilterActions">
		<asp:LinkButton ID="ResetProductFilterLinkButton" runat="server" resourcekey="ResetProductFilterLinkButton" AutoPostBack="False" OnClientClick="Revindex.Dnn.RevindexStorefront.ProductFilter.ResetProductFilter(); return false;" CausesValidation="False" CssClass="dnnPrimaryAction rvdResetAction"/>
	</div>
	<asp:ListView ID="FilterListView" runat="server" DataKeyNames="ProductAttributeDefinitionID">
		<LayoutTemplate>
			<div class="dnnForm rvdsfProductFilterList">
				<div runat="server" id="groupPlaceholder" />
			</div>
		</LayoutTemplate>
		<GroupTemplate>
			<div class="rvdsfProductFilterGroup">
				<div runat="server" id="itemPlaceholder" />
			</div>
		</GroupTemplate>
		<ItemTemplate>
			<div class="dnnFormItem rvdsfProductFilterItem">
				<dnn1:LabelControl ID="AttributeNameLabelControl" runat="server" Text='<%# Eval("AttributeNameLabelControl_Text") %>' HelpText='<%# Eval("AttributeNameLabelControl_HelpText") %>' />
				<asp:Literal ID="AttributeControlLiteral" runat="server" Text='<%# Eval("AttributeControlLiteral_Text") %>'></asp:Literal>
			</div>
		</ItemTemplate>
	</asp:ListView>
	<dnn2:DnnSlider ID="HiddenDnnSlider" runat="server" Style="display: none">
	</dnn2:DnnSlider>  
</div>
