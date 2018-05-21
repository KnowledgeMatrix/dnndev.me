<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="FacebookSharedActivity.ascx.cs" Inherits="DotNetNuke.Professional.SocialShare.FacebookSharedActivity" %>

<asp:Panel runat="server" ID="ScopeWrapper" xmlns:fb="http://ogp.me/ns/fb#">
    <fb:shared-activity></fb:shared-activity>
</asp:Panel>

<div id="fb-root"></div>

<script type="text/javascript">
    function facebookSharedActivityInit(settings) {
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