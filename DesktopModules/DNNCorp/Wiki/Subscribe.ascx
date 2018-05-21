<%@ Control Language="C#" AutoEventWireup="false" CodeBehind="Subscribe.ascx.cs" Inherits="DotNetNuke.Professional.Wiki.Subscribe" %>
<%@ Import Namespace="DotNetNuke.Services.Localization" %>
<asp:Panel runat="server" ID="ScopeWrapper" CssClass="dnnClear">   
	<div class="dnnClear moduleSubscribe status-compact-container status-container" id="wikiSubscribe">
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
    function wiki_subscribeInit(settings) {
        settings.moduleScope = $(settings.moduleScope)[0];
        if (typeof settings.moduleScope === 'undefined') {
            return;
        }
        try {
            window.dnn.social.applyBindings(new window.dnn.wiki.Subscribe(settings), settings.moduleScope);
            dnn.social.loaded(settings.moduleScope.id);
        } catch(ex) {
            window.dnn.social.topLevelExceptionHandler(settings, ex);
        }
    }
</script>