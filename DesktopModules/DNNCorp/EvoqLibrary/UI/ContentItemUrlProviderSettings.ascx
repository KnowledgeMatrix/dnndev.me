<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ContentItemUrlProviderSettings.ascx.cs" Inherits="Evoq.UI.ContentItemUrlProviderSettings" %>
<%@ Register TagPrefix="dnn" TagName="label" Src="~/controls/LabelControl.ascx" %>
<div class="dnnClear dnnForm">
    <div class="dnnFormItem">
        <dnn:label id="lblReservedWordList" runat="server" suffix=":" ControlName="tbReservedWordList" />
        <asp:TextBox runat="server" ID="tbReservedWordList">
        </asp:TextBox>
    </div>
</div>