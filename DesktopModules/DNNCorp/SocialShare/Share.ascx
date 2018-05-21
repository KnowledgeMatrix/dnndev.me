<%@ Control Language="C#" AutoEventWireup="false" CodeBehind="Share.ascx.cs" Inherits="DotNetNuke.Professional.SocialShare.Share" %>

<asp:Panel runat="server" ID="ScopeWrapper" CssClass="social-share-container" xmlns:fb="https://www.facebook.com/2008/fbml">
    <ul class="socialConnect" id="dnnConnect">
        <% if (ShareLabel)
           { %>
        <!-- ko if: controls().length > 0 -->
        <li>
            <%= LocalizeString("lblShare") %>
        </li>
        <!-- /ko -->
        <% } %>
        <!-- ko foreach: controls -->
        <li>
            <a data-bind="click: share, attr: { 'class': settings.style }"></a>
        </li>
        <!-- /ko -->
        <% if (FacebookLabel)
           { %>
        <!-- ko if: $root.facebook -->
        <li>
            <div class="social-share-facebook-like-container">
                <div class="fb-like" data-send="false" data-layout="<%= FacebookLikeStyle %>"
                    data-width="400" data-show-faces="false" data-font="segoe ui"></div>
            </div>
        </li>
        <!-- /ko -->
        <% } %>
        <div class="dnnClear"></div>
    </ul>
    <div class="social-share-transforming">
        <%= LocalizeString("TransformingUrl") %>
    </div>
    <div class="dnnClear"></div>
</asp:Panel>

<div id="fb-root"></div>

<script type="text/javascript">
    function shareInit(settings) {
        settings.moduleScope = $(settings.moduleScope)[0];
        if (!settings.moduleScope) {
            return;
        }

        try {
            window.dnn.social.applyBindings(new window.dnn.share.View($, window.ko, settings), settings.moduleScope);
        } catch(ex) {
            window.dnn.social.topLevelExceptionHandler(settings, ex);
        }
    }
</script>