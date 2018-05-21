<%@ Control Language="C#" CodeBehind="Settings.ascx.cs" Inherits="DotNetNuke.Enterprise.FolderProviders.BoxFolderProvider.Settings, DotNetNuke.Enterprise.FolderProviders" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<%@ Register TagPrefix="dnn" assembly="DotNetNuke.Web" namespace="DotNetNuke.Web.UI.WebControls" %>

<asp:Panel runat="server" ID="panelAll">
<div class="dnnFormItem">
    <dnn:Label ID="plClientId" runat="server" controlname="tbAccessKeyId" />
    <asp:TextBox ID="tbClientId" runat="server" CssClass="dnnFormRequired" />
    <asp:RequiredFieldValidator ID="valClientId" runat="server" ControlToValidate="tbClientId" Display="Dynamic" CssClass="dnnFormMessage dnnFormError" resourcekey="valClientId.ErrorMessage" />
</div>
<div class="dnnFormItem">
    <dnn:Label ID="plClientSecret" runat="server" controlname="tbClientSecret"/>
    <asp:TextBox ID="tbClientSecret" runat="server" CssClass="dnnFormRequired" />
    <asp:RequiredFieldValidator ID="valClientSecret" runat="server" ControlToValidate="tbClientSecret" Display="Dynamic" CssClass="dnnFormMessage dnnFormError" resourcekey="valClientSecret.ErrorMessage" />
</div>
<div class="dnnFormItem">
    <dnn:Label ID="plCallbackUri" runat="server" controlName="tbCallbackUri"/>
    <asp:TextBox ID="tbCallbackUri" runat="server" CssClass="aspNetDisabled dnnFormRequired" ReadOnly="True" />
</div>
<div class="dnnFormItem">
    <dnn:Label ID="plParentFolder" runat="server" />
    <asp:TextBox ID="tbParentFolder" runat="server" CssClass="dnnFormRequired" />
</div>
<div class="dnnFormItem">
    <dnn:Label ID="plDirectLink" runat="server" ControlName="chkDirectLink" />
    <asp:CheckBox runat="server" ID="chkDirectLink" Checked="False"/>
</div>
</asp:Panel>
