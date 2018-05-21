<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ArticleContent.ascx.cs" Inherits="DotNetNuke.Professional.Wiki.Controls.ArticleContent" %>
<asp:Panel runat="server" ID="ScopeWrapper">
    <% if (!Locked && CanModerate && ShowEditor)
        { %>
    <div class="dnnRight">
        <a class="wiki-edit-button" data-bind="click: edit">
            <%= LocalizeString("Edit") %>
        </a>
    </div>
    <% } %>
    <div id="detailview-content-common">
        <%= ProcessedContent %>
    </div>
</asp:Panel>

<script type="text/javascript">
    function wiki_articleContentInit(settings) {
        settings.moduleScope = $(settings.moduleScope)[0];
        if (typeof settings.moduleScope === 'undefined') return; 
        try {
            window.dnn.social.applyBindings(new window.dnn.wiki.ArticleContent(settings), settings.moduleScope);
        } catch (ex) {
            window.dnn.social.topLevelExceptionHandler(settings, ex);
        }
	    $(".wiki-tab-content").hide();
    }
</script>
