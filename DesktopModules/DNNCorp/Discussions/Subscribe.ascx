<%@ Control Language="C#" AutoEventWireup="false" CodeBehind="Subscribe.ascx.cs" Inherits="DotNetNuke.Professional.Discussions.Subscribe" %>
<%@ Import Namespace="DotNetNuke.Services.Localization" %>
<asp:Panel runat="server" ID="ScopeWrapper" CssClass="dnnClear">   
	<div class="dnnClear moduleSubscribe status-compact-container status-container" id="discussionsSubscribe">
        <h6><%= LocalizeString("Subscribe") %></h6>
        <div class="static-row">
            <a href="javascript:void(0)" class="dnnSocialLink" title="<%= Localization.GetString("SubscribeAll", LocalResourceFile) %>"><%= Localization.GetString("SubscribeAll", LocalResourceFile) %></a>
        </div>
        <div class="loading-container ko-container">
            <!-- ko ifnot: subscribed -->
            <a href="javascript:void(0)" data-bind="click: subscribe" class="dnnSocialLink" title="<%= Localization.GetString("SubscribeAll", LocalResourceFile) %>"><%= Localization.GetString("SubscribeAll", LocalResourceFile) %></a>
            <!-- /ko -->
            <!-- ko if: subscribed -->
            <a href="javascript:void(0)" data-bind="click: unsubscribe" class="dnnSocialLink dnnUnsubscribeModule" title="<%= Localization.GetString("UnsubscribeAll", LocalResourceFile) %>"><%= Localization.GetString("UnsubscribeAll", LocalResourceFile) %></a>
            <!-- /ko -->
        </div>
    </div>
</asp:Panel>
<script type='text/javascript'>
    function discussionsSubscribeView(settings) {
        settings.moduleScope = $(settings.moduleScope)[0];
        if (!settings.moduleScope) {
            return;
        }

        try {
            window.dnn.social.applyBindings(new window.dnn.discussions.Subscribe($, ko, settings), settings.moduleScope);
            dnn.social.loaded(settings.moduleScope.id);
        } catch(ex) {
            window.dnn.social.topLevelExceptionHandler(settings, ex);
        }
    }
</script>