<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="FacebookRecommendations.ascx.cs" Inherits="DotNetNuke.Professional.SocialShare.FacebookRecommendations" %>

<asp:Panel runat="server" ID="ScopeWrapper" xmlns:fb="http://ogp.me/ns/fb#">
    <fb:recommendations></fb:recommendations>
</asp:Panel>

<div id="fb-root"></div>

<script type="text/javascript">
    function facebookRecommendationsInit(settings) {
        dnn.social.EventQueue.push(
            function() {
                try {
                    dnn.share.facebookInitialize(settings.applicationId);
                } catch(ex) {
                    dnn.social.topLevelExceptionHandler(settings, ex);
                }
            });
    }
</script>