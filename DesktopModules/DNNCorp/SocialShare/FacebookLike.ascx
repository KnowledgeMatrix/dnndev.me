<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="FacebookLike.ascx.cs" Inherits="DotNetNuke.Professional.SocialShare.FacebookLike" %>

<asp:Panel runat="server" ID="ScopeWrapper" xmlns:fb="http://ogp.me/ns/fb#">
    <fb:like-box href="<%= Request.Url.ToString() %>"
        width="<%= Width %>"
        show_faces="<%= ShowFaces.ToString().ToLowerInvariant() %>"
        stream="<%= Stream.ToString().ToLowerInvariant() %>"
        header="<%= Header.ToString().ToLowerInvariant() %>">
    </fb:like-box>
</asp:Panel>

<div id="fb-root"></div>

<script type="text/javascript">
    function facebookLikeInit(settings) {
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