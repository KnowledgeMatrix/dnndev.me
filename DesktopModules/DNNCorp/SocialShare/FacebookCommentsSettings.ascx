<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="FacebookCommentsSettings.ascx.cs" Inherits="DotNetNuke.Professional.SocialShare.FacebookCommentsSettings" %>

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
                <dnn:label runat="server" ResourceKey="MaximumComments" />
                 <asp:DropDownList runat="server" ID="ddlMaximumComments">
                    <Items>
                        <asp:ListItem Value="5"></asp:ListItem>
                        <asp:ListItem Value="10"></asp:ListItem>
                        <asp:ListItem Value="15"></asp:ListItem>
                        <asp:ListItem Value="25"></asp:ListItem>
                        <asp:ListItem Value="30"></asp:ListItem>
                        <asp:ListItem Value="50"></asp:ListItem>
                        <asp:ListItem Value="75"></asp:ListItem>
                        <asp:ListItem Value="100"></asp:ListItem>
                    </Items>
                </asp:DropDownList>
            </div>
            <div class="dnnFormItem">
                <dnn:label runat="server" ResourceKey="ColorScheme" />
                 <asp:DropDownList runat="server" ID="ddlColorScheme">
                    <Items>
                        <asp:ListItem Value="light" Text="Light"></asp:ListItem>
                        <asp:ListItem Value="dark" Text="Dark"></asp:ListItem>
                    </Items>
                </asp:DropDownList>
            </div>
        </fieldset>
    </div>
</div>