<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="FacebookSendButton.ascx.cs" Inherits="DotNetNuke.Professional.SocialShare.FacebookSendButton" %>

<asp:Panel runat="server" ID="ScopeWrapper" xmlns:fb="http://ogp.me/ns/fb#">
    <fb:send></fb:send>
</asp:Panel>

<div id="fb-root"></div>

<script type="text/javascript">
    function facebookSendButtonInit(settings) {
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