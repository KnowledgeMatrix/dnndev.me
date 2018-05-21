<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="CommunicationConfigurationPrintControl.ascx.cs" Inherits="Revindex.Dnn.RevindexStorefront.CommunicationConfigurationPrintControl" %>
<%@ Register Src="~/Controls/labelcontrol.ascx" TagName="LabelControl" TagPrefix="dnn1" %>
<%@ Register Src="~/Controls/texteditor.ascx" TagName="TextEditor" TagPrefix="dnn1" %>
<%@ Register Assembly="DotNetNuke.Web.Deprecated" Namespace="DotNetNuke.Web.UI.WebControls" TagPrefix="dnn2" %>
<%@ Register Src="WebUserControls/FormulaEditorControl.ascx" TagName="FormulaEditorControl" TagPrefix="uc1" %>
<div class="dnnFormItem">
	<dnn1:LabelControl ID="RuleTypeLabelControl" runat="server" Text="Print template rule:" HelpText="Select the print template type." />
	<asp:DropDownList ID="RuleTypeDropDownList" runat="server" OnSelectedIndexChanged="RuleTypeDropDownList_SelectedIndexChanged" AutoPostBack="True">
		<asp:ListItem Text="None" Value="" />
		<asp:ListItem Text="Basic" Value="BasicView" />
		<asp:ListItem Text="Custom rule (OBSOLETE: Please create/migrate using Basic type)" Value="CustomRuleView" />
	</asp:DropDownList>
</div>
<asp:MultiView ID="FormulaMultiView" runat="server" ActiveViewIndex="0">
	<asp:View ID="BasicView" runat="server">
        <div class="dnnFormItem">
            <span class="dnnLabel" ></span>
            <asp:LinkButton ID="ResetDefaultBasicLinkButton" runat="server" OnClick="ResetDefaultBasicLinkButton_Click" Text="Reset default template" CssClass="dnnSecondaryAction rvdResetAction" CausesValidation="False" />
        </div>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="TitleBasicLabelControl" runat="server" Text="Title:" HelpText="The print title. This field accepts XSL tokens." CssClass="dnnFormRequired"/>
			<asp:RequiredFieldValidator ID="TitleBasicRequiredFieldValidator" runat="server" ControlToValidate="TitleBasicTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="ConfigurationDetailsViewControl">Title is required.</asp:RequiredFieldValidator>
			<asp:TextBox ID="TitleBasicTextBox" runat="server" CssClass="dnnFormRequired"></asp:TextBox>
		</div>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="HtmlBodyBasicLabelControl" runat="server" Text="HTML body:" HelpText="The print template body. This field accepts XSL tokens." />
			<dnn1:TextEditor ID="HtmlBodyBasicTextEditor" runat="server" ChooseRender="False" ChooseMode="False" DefaultMode="RICH" HtmlEncode="False" Width="100%" Height="400px" Mode="RICH" />
		</div>
	</asp:View>
	<asp:View ID="CustomRuleView" runat="server">
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="PrintRuleLabelControl" runat="server" Text="XSLT rule:" />
			<uc1:FormulaEditorControl ID="PrintRuleFormulaEditor" runat="server" Width="100%" />
		</div>
	</asp:View>
</asp:MultiView>