<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="FacebookLikeSettings.ascx.cs" Inherits="DotNetNuke.Professional.SocialShare.FacebookLikeSettings" %>

<%@ Register TagName="label" TagPrefix="dnn" Src="~/controls/labelcontrol.ascx" %>

<div class="dnnClear social-share-settings">
    <h2 class="dnnFormSectionHead">
        <a href="#" class="dnnSectionExpanded">
            <%= LocalizeString("FacebookComments") %>
        </a>
    </h2>
    <div>
        <fieldset>
            <div class="dnnFormItem">
                <dnn:label runat="server" ResourceKey="ControlWidth" />
                <asp:TextBox runat="server" ID="txtControlWidth" TextMode="SingleLine"></asp:TextBox>
            </div>
            <div class="dnnFormItem">
                <dnn:label runat="server" ResourceKey="ShowFaces" />
                <asp:CheckBox runat="server" ID="chkShowFaces"/>
            </div>
            <div class="dnnFormItem">
                <dnn:label runat="server" ResourceKey="Stream" />
                <asp:CheckBox runat="server" ID="chkStream"/>
            </div>
            <div class="dnnFormItem">
                <dnn:label runat="server" ResourceKey="Header" />
                <asp:CheckBox runat="server" ID="chkHeader"/>
            </div>
        </fieldset>
    </div>
</div>