<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Revisions.ascx.cs" Inherits="DotNetNuke.Professional.Wiki.Controls.Revisions" %>

<%@ Register tagPrefix="revisions" tagName="ChangesetControl" src="~/DesktopModules/DNNCorp/Revisions/Controls/ChangesetControl.ascx" %>

<asp:Panel runat="server" ID="ScopeWrapper" CssClass="dnnClear wiki-tab-content wiki-revisions-container">
    <div class="wiki-editor-form" style="display: none;">
        <revisions:ChangesetControl runat="server" ID="ctlChangesets" ContentItemType="Content" />
    </div>
</asp:Panel>

<script type="text/javascript">
    function wiki_revisionsInit(settings) {
        settings.moduleScope = $(settings.moduleScope)[0];

        if (typeof settings.moduleScope === 'undefined') {
            return;
        }

        try {
            window.dnn.social.applyBindings(new window.dnn.wiki.Revisions(settings), settings.moduleScope);
        } catch(ex) {
            window.dnn.social.topLevelExceptionHandler(settings, ex);
        }
        $('.wiki-revisions-container .wiki-editor-form').show();
    }
</script>