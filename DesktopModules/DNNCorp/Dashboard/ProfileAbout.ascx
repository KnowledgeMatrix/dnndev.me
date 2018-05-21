<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ProfileAbout.ascx.cs" Inherits="DotNetNuke.Professional.Dashboard.ProfileAbout" %>
<%@ Import Namespace="DotNetNuke.Services.Localization" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/Controls/LabelControl.ascx" %>
<div class="dnnClear moduleContainer dashboard-container">
    <div id="profileAbout">
         <span class="dashboard-profile-header strong-header" style="display: block"><%= Localization.GetString("AboutMe", LocalResourceFile) %></span>
        <% if (HasBiography)
           { %>
        <div class="dashboard-biography">
            <%= HttpUtility.HtmlDecode(Biography) %>
        </div>
        <% } %>
    </div>
    <div>
        <% if (HasRealName)
           { %>
        <div class="dashboard-about-property">
            <dnn:Label runat="server" ResourceKey="RealName" />
            <div class="value">
                <%= DotNetNuke.SocialLibrary.Components.Common.Utilities.RemoveHtmlTags(RealName) %>
            </div>
            <div class="dnnClear"></div>
        </div>
        <% } %>
        <% if (HasAge)
           { %>
        <div class="dashboard-about-property">
            <dnn:Label runat="server" ResourceKey="Age" />
            <div class="value">
                <%= Age %>
            </div>
            <div class="dnnClear"></div>
        </div>
        <% } %>
        <% if (HasLocation)
           { %>
        <div class="dashboard-about-property">
            <dnn:Label runat="server" ResourceKey="Location" />
            <div class="value">
                <%= LocationMarkup %>
            </div>
            <div class="dnnClear"></div>
        </div>
        <% } %>
        <% if (HasTelephone)
           { %>
        <div class="dashboard-about-property">
            <dnn:Label runat="server" ResourceKey="Telephone" />
            <div class="value">
                <a href="<%= PhoneFormatLink(Telephone) %>">
                    <%= Telephone %>
                </a>
            </div>
            <div class="dnnClear"></div>
        </div>
        <% } %>
        <% if (HasMobile)
           { %>
        <div class="dashboard-about-property">
            <dnn:Label runat="server" ResourceKey="Mobile" />
            <div class="value">
                <a href="<%= PhoneFormatLink(Mobile) %>">
                    <%= Mobile %>
                </a>
            </div>
            <div class="dnnClear"></div>
        </div>
        <% } %>
        <% if (HasFax)
           { %>
        <div class="dashboard-about-property">
            <dnn:Label runat="server" ResourceKey="Fax" />
            <div class="value">
                <a href="<%= PhoneFormatLink(Fax) %>">
                    <%= Fax %>
                </a>
            </div>
            <div class="dnnClear"></div>
        </div>
        <% } %>
        <% if (HasWebsite)
           { %>
        <div class="dashboard-about-property">
            <dnn:Label runat="server" ResourceKey="Website" />
            <div class="value">
                <a href="<%= Website %>">
                    <%= Website %>
                </a>
            </div>
            <div class="dnnClear"></div>
        </div>
        <% } %>
        <% if (HasCustomProperties)
           { %>
        <asp:Repeater ID="rptCustom" runat="server">
            <ItemTemplate>
                <div class="dashboard-about-property">
                    <dnn:Label runat="server" text='<%# Eval("PropertyName").ToString() %>' />
                    <div class="value">
                        <%# Eval("PropertyValue") %>
                    </div>
                    <div class="dnnClear"></div>
                </div>
            </ItemTemplate>
        </asp:Repeater>
        <% } %>
        <div class="dashboard-about-property">
            <dnn:Label runat="server" ResourceKey="MemberSince" />
            <div class="value">
                <%= MemberSince %>
            </div>
            <div class="dnnClear"></div>
        </div>
        <div class="dashboard-about-property">
            <dnn:Label runat="server" ResourceKey="LastVisited" />
            <div class="value">
                <%= LastVisited %>
            </div>
            <div class="dnnClear"></div>
        </div>
        <div class="dashboard-about-property">
            <dnn:Label runat="server" ResourceKey="TimeSpentOnSite" />
            <div class="value">
                <%= TimeSpentOnSite %>
            </div>
            <div class="dnnClear"></div>
        </div>
    </div>
</div>
