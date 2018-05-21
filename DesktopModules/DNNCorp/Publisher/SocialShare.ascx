<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="SocialShare.ascx.cs" Inherits="DotNetNuke.Enterprise.Publisher.SocialShare" %>
<%@ Import Namespace="DotNetNuke.Enterprise.Publisher.Components.Common" %>
<%@ Import Namespace="DotNetNuke.Common.Utilities" %>

<asp:Panel ID="ScopeWrapper" runat="server" CssClass="social-share" >
    
    <% if (ViewMode == ViewMode.Detail) { %>
        <div class="label">
            <%= LocalizeString("ShareThisPost") %>        
        </div>
    <% } %>
    
    <% if (SharePublisherSettings.TwitterEnabled) { %> 
        <a href="javascript:void(0)" class="twitter" data-bind="click: share" title="<%= string.Format(LocalizeString("ShareOn"), "Twitter") %>" aria-label="Twitter"></a>
    <% } %>
    
    <% if (SharePublisherSettings.FacebookEnabled) { %> 
        <a href="javascript:void(0)" class="facebook" data-bind="click: share" title="<%= string.Format(LocalizeString("ShareOn"), "Facebook") %>" aria-label="Facebook"></a>
    <% } %>

    <% if (SharePublisherSettings.LinkedInEnabled) { %> 
        <a href="javascript:void(0)" class="linkedin" data-bind="click: share" title="<%= string.Format(LocalizeString("ShareOn"), "Linked In") %>" aria-label="Linked In"></a>
    <% } %>

    <% if (SharePublisherSettings.PinterestEnabled) { %> 
        <a href="javascript:void(0)" class="pinterest" data-bind="click: share" title="<%= string.Format(LocalizeString("ShareOn"), "Pinterest") %>" aria-label="Pinterest"></a>
    <% } %>
    
    <% if (SharePublisherSettings.RssEnabled) { %> 
        <a href="<%= RssUrl %>" class="rss" title="<%= LocalizeString("RssFeed") %>"></a>
    <% } %>

    <script type="text/javascript">
        jQuery(function () {
            dnn.modules.publisher.RequestUtils.init(<%= ModuleId %>);

            dnn.modules.publisher.SocialShareManager.init({
                bindingElementSelector: '#<%= ScopeWrapper.ClientID %>',
                contentItemId: <%= Json.Serialize(ContentItemId) %>,
                userId: <%= UserInfo.UserID %>
            });
        });
    </script>
</asp:Panel>