<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="CommunicationConfigurationEmailControl.ascx.cs" Inherits="Revindex.Dnn.RevindexStorefront.CommunicationConfigurationEmailControl" %>
<%@ Register Src="~/Controls/labelcontrol.ascx" TagName="LabelControl" TagPrefix="dnn1" %>
<%@ Register Src="~/Controls/texteditor.ascx" TagName="TextEditor" TagPrefix="dnn1" %>
<%@ Register Assembly="DotNetNuke.Web.Deprecated" Namespace="DotNetNuke.Web.UI.WebControls" TagPrefix="dnn2" %>
<%@ Register Src="WebUserControls/FormulaEditorControl.ascx" TagName="FormulaEditorControl" TagPrefix="uc1" %>
<div class="dnnFormItem">
	<dnn1:LabelControl ID="RuleTypeLabelControl" runat="server" Text="Email template rule:" HelpText="Select the email template type." />
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
			<dnn1:LabelControl ID="MailFromBasicLabelControl" runat="server" Text="Mail from:" HelpText="The email address of the sender. If not specified, the system will use your general sender address. This field accepts XSL tokens." />
			<asp:RegularExpressionValidator ID="MailFromBasicRegularExpressionValidator" runat="server" ControlToValidate="MailFromBasicTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationExpression="^(\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*|(&quot;*[\w ]*&quot;*\s*)&lt;\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*&gt;)$" ValidationGroup="ConfigurationDetailsViewControl">Email is invalid.</asp:RegularExpressionValidator>
			<asp:TextBox ID="MailFromBasicTextBox" runat="server"></asp:TextBox>
		</div>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="MailToBasicLabelControl" runat="server" Text="Mail to:" HelpText="The email address of the recipient. If not specified, the system will send to the default recipient email addresses according to the type of email. You can email multiple recipients by separating each email address with a comma. This field accepts XSL tokens." />
			<asp:TextBox ID="MailToBasicTextBox" runat="server"></asp:TextBox>
		</div>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="MailBccBasicLabelControl" runat="server" Text="Mail BCC:" HelpText="The email address of the recipient. You can email multiple recipients by separating each email address with a comma. This field accepts XSL tokens." />
			<asp:TextBox ID="MailBccBasicTextBox" runat="server"></asp:TextBox>
		</div>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="SubjectBasicLabelControl" runat="server" Text="Subject:" HelpText="The email subject. This field accepts XSL tokens." CssClass="dnnFormRequired"/>
			<asp:RequiredFieldValidator ID="SubjectBasicRequiredFieldValidator" runat="server" ControlToValidate="SubjectBasicTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="ConfigurationDetailsViewControl">Subject is required.</asp:RequiredFieldValidator>
			<asp:TextBox ID="SubjectBasicTextBox" runat="server" CssClass="dnnFormRequired"></asp:TextBox>
		</div>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="HtmlBodyBasicLabelControl" runat="server" Text="HTML body:" HelpText="The email template body. This field accepts XSL tokens." />
			<dnn1:TextEditor ID="HtmlBodyBasicTextEditor" runat="server" ChooseRender="False" ChooseMode="False" DefaultMode="RICH" HtmlEncode="False" Width="100%" Height="400px" Mode="RICH" />
		</div>
	</asp:View>
	<asp:View ID="CustomRuleView" runat="server">
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="EmailRuleLabelControl" runat="server" Text="XSLT rule:" />
			<uc1:FormulaEditorControl ID="EmailRuleFormulaEditor" runat="server" Width="100%" />
		</div>
	</asp:View>
</asp:MultiView>