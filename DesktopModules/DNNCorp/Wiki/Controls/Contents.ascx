<%@ Control Language="C#" AutoEventWireup="false" CodeBehind="Contents.ascx.cs" Inherits="DotNetNuke.Professional.Wiki.Controls.Contents" %>
<asp:Panel runat="server" ID="ScopeWrapper" CssClass="dnnClear wiki-toc-container status-compact-container status-container">
    <h6><%= LocalizeString("Contents") %></h6>
    <!-- ko if: tree() == null -->
    <div class="wiki-toc-no-sections">
        <%= LocalizeString("NoContents") %>
    </div>
    <!-- /ko -->
    <!-- ko ifnot: tree() == null -->
    <div class="wiki-toc-tree" data-bind="html: tree"></div>
    <!-- /ko -->
</asp:Panel>
<script type="text/javascript">
    function wiki_contentsInit(settings) {
        settings.moduleScope = $(settings.moduleScope)[0];
        if (typeof settings.moduleScope === 'undefined') {
            return;
        }
        try {
            window.dnn.social.applyBindings(new window.dnn.wiki.Contents(settings), settings.moduleScope);
        } catch (ex) {
            window.dnn.social.topLevelExceptionHandler(settings, ex);
        }
    }
</script>