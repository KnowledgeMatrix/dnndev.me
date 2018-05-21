<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="FacebookComments.ascx.cs" Inherits="DotNetNuke.Professional.SocialShare.FacebookComments" %>

<asp:Panel runat="server" ID="ScopeWrapper" xmlns:fb="http://ogp.me/ns/fb#">
    <fb:comments data-href="<%= Request.Url.ToString() %>"
        data-width="<%= Width %>"
        data-num-posts="<%= PostMax %>"
        data-colorscheme="<%= ColorScheme %>"></fb:comments>
</asp:Panel>

<div id="fb-root"></div>

<script type="text/javascript">
    function facebookCommentsInit(settings) {
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