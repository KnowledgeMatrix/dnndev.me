<%@ Control Language="C#" AutoEventWireup="false" Inherits="DotNetNuke.Professional.ActivityStream.ActivityFilterSettings" CodeBehind="ActivityFilterSettings.ascx.cs" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
    <style>
        .dnnFormItem td label{white-space:nowrap;text-align:left;}
    </style>

    <div class="dnnFormItem">
        <dnn:label  resourcekey="ActivityFilters" Suffix=":" runat="server" />
        <asp:CheckBoxList ID="chkActivityFilters" runat="server" />
    </div>
