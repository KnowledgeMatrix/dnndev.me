<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="FacebookFacepile.ascx.cs" Inherits="DotNetNuke.Professional.SocialShare.FacebookFacepile" %>

<asp:Panel runat="server" ID="ScopeWrapper" xmlns:fb="http://ogp.me/ns/fb#">
    <fb:facepile data-href="<%= Request.Url.ToString() %>" data-size="large" data-max-rows="6" data-width="400"></fb:facepile>
</asp:Panel>

<div id="fb-root"></div>

<script type="text/javascript">
    function facebookFacepileInit(settings) {
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