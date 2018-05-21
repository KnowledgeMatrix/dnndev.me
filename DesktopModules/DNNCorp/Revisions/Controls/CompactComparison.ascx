<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="CompactComparison.ascx.cs" Inherits="DotNetNuke.Social.Revisions.Controls.CompactComparison" %>

<div data-bind="stopBindings: true">
    <asp:Panel runat="server" ID="ScopeWrapper" CssClass="revision-compact-compare-container">
        <div class="revision-id">
            (<%= LocalizeString("CompactRevision") %>&nbsp;<span data-bind="text: $root.rightSequence"></span>)
        </div>
        <div class="revision">
            <div data-bind="html: right"></div>
        </div>
    </asp:Panel>
</div>

<script type="text/javascript">
    function revisions_compactCompareInit(settings) {
        settings.moduleScope = $(settings.moduleScope)[0];
        if (!settings.moduleScope) {
            return;
        }

        try {
            window.dnn.social.applyBindings(new window.dnn.revisions.CompareControl(settings), settings.moduleScope);
        } catch(ex) {
            window.dnn.social.topLevelExceptionHandler(settings, ex);
        }
    }
</script>