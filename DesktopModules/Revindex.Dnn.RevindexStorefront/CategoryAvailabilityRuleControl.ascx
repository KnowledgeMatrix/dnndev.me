﻿<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="CategoryAvailabilityRuleControl.ascx.cs" Inherits="Revindex.Dnn.RevindexStorefront.CategoryAvailabilityRuleControl" %>
<%@ Register Src="~/Controls/labelcontrol.ascx" TagName="LabelControl" TagPrefix="dnn1" %>
<%@ Register Assembly="DotNetNuke.Web.Deprecated" Namespace="DotNetNuke.Web.UI.WebControls" TagPrefix="dnn2" %>
<%@ Register Src="WebUserControls/FormulaEditorControl.ascx" TagName="FormulaEditorControl" TagPrefix="uc1" %>
<div class="dnnFormItem">
	<dnn1:LabelControl ID="RuleTypeLabelControl" runat="server" Text="Availability rule:" HelpText="Provide any condition that determines when this category should be available." />
	<asp:DropDownList ID="RuleTypeDropDownList" runat="server" OnSelectedIndexChanged="RuleTypeDropDownList_SelectedIndexChanged" AutoPostBack="True">
		<asp:ListItem Text="None - always allow" Value=""></asp:ListItem>
		<asp:ListItem Text="Basic" Value="BasicAvailabilityView"></asp:ListItem>
		<asp:ListItem Text="Custom rule" Value="CustomRuleView"></asp:ListItem>
	</asp:DropDownList>
</div>
<asp:MultiView ID="FormulaMultiView" runat="server" ActiveViewIndex="0">
	<asp:View ID="BasicAvailabilityView" runat="server">
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="RoleBehaviorBasicAvailabilityLabelControl" runat="server" Text="Role match:" HelpText="Determine if rule is allowed or disallowed." />
			<asp:RadioButtonList ID="RoleBehaviorBasicAvailabilityRadioButtonList" runat="server" RepeatLayout="Flow" CssClass="dnnFormRadioButtons">
				<asp:ListItem Text="Allow all except selected below" Value="exclusion" Selected="True" />
				<asp:ListItem Text="Allow only those selected below" Value="inclusion" />
			</asp:RadioButtonList>
		</div>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="RoleBasicAvailabilityLabelControl" runat="server" Text="Roles:" HelpText="Select the roles that should match. Use CTRL + mouse click to select multiple items." />
			<asp:ListBox ID="RoleBasicAvailabilityListBox" runat="server" SelectionMode="Multiple" CssClass="rvdFormListBox">
			</asp:ListBox>
		</div>
	</asp:View>
	<asp:View ID="CustomRuleView" runat="server">
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="AvailabilityRuleLabelControl" runat="server" Text="XSLT rule:" />
			<uc1:FormulaEditorControl ID="AvailabilityRuleFormulaEditor" runat="server" Width="100%" ModuleControl="CategoryAvailability" />
		</div>
	</asp:View>
</asp:MultiView>