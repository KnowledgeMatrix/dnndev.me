<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ProfileSubscriptions.ascx.cs" Inherits="DotNetNuke.Professional.Dashboard.ProfileSubscriptions" %>

<asp:Panel runat="server" class="dnnClear moduleContainer dashboard-container dashboard-container-subscriptions evoq-loading moduleSubscribe" ID="ScopeWrapper" data-bind="css:{'evoq-loading': loading}">
    <span class="dashboard-profile-header strong-header" id="profileScore">
        <%= LocalizeString("Subscriptions") %>
    </span>
    <div>
       <a class="dnnSocialLink" data-bind="click: toggleUserMentionsSubscription, css: { dnnUnsubscribeModule: isSubscribedToUserMentions }, html: userMentionSubscriptionLabel"></a>
    </div>
    <div class="dnnFormMessage " data-bind="css: { dnnFormSuccess: !isError(), dnnFormError: isError }, text: message, visible: showMessage" style="display: none"></div>
  
</asp:Panel>
<script type="text/javascript">
    function dashboard_subscriptionsInit(settings) {
        settings.moduleScope = $(settings.moduleScope)[0];
        try {
            dnn.social.applyBindings(new dnn.dashboard.Subscriptions(settings), settings.moduleScope);
        } catch (ex) {
            dnn.social.topLevelExceptionHandler(settings, ex);
        }
    }
</script>
