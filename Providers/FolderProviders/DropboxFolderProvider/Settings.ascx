<%@ Control Language="C#" CodeBehind="Settings.ascx.cs" Inherits="DotNetNuke.Enterprise.FolderProviders.DropboxFolderProvider.Settings, DotNetNuke.Enterprise.FolderProviders" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<%@ Register TagPrefix="dnn" Namespace="DotNetNuke.Web.UI.WebControls" Assembly="DotNetNuke.Web" %>
<div class="dnnFormItem">
    <dnn:Label ID="plAccessKeyId" runat="server" controlname="tbAccessKeyId" />
    <asp:TextBox ID="tbAccessKeyId" runat="server" CssClass="dnnFormRequired" />
    <asp:RequiredFieldValidator id="valAccessKeyId" runat="server" ControlToValidate="tbAccessKeyId" Display="Dynamic" CssClass="dnnFormMessage dnnFormError" resourcekey="valAccessKeyId.ErrorMessage" />
</div>
<div class="dnnFormItem">
    <dnn:Label ID="plSecretAccessKey" runat="server" />
    <asp:TextBox ID="tbSecretAccessKey" runat="server" CssClass="dnnFormRequired" />
    <asp:RequiredFieldValidator ID="valSecretAccessKey" runat="server" ControlToValidate="tbSecretAccessKey" Display="Dynamic" CssClass="dnnFormMessage dnnFormError" resourcekey="valSecretAccessKey.ErrorMessage" />
</div>
<div class="dnnFormItem">
    <dnn:Label ID="plParentFolder" runat="server" />
    <asp:TextBox ID="tbParentFolder" runat="server" CssClass="dnnFormRequired" />
</div>
<div class="dnnFormItem">
    <dnn:Label ID="plDirectLink" runat="server" ControlName="chkDirectLink" />
    <asp:CheckBox runat="server" ID="chkDirectLink" Checked="True"/>
</div>