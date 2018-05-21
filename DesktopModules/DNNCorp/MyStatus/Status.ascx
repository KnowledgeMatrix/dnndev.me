<%@ Control Language="C#" Inherits="DotNetNuke.Professional.MyStatus.Status" AutoEventWireup="false"  Codebehind="Status.ascx.cs" %>

<asp:Panel runat="server" ID="ScopeWrapper" CssClass="status-container dnnClear">
    <asp:PlaceHolder runat="server" ID="plhContent" />
</asp:Panel>

<script type="text/javascript">
    dnn.social.loading('<%= ScopeWrapper.ClientID %>');
    function statusInit(settings) {
        settings.moduleScope = $(settings.moduleScope)[0];
        if (!settings.moduleScope) {
            return;
        }

        try {
            if (settings.template == 'compact') {
                window.dnn.social.applyBindings(new window.dnn.status.CompactView($, ko, settings), settings.moduleScope);
            } else if (settings.template == 'expanded') {
                //if (typeof settings.profileUserId === 'undefined' || settings.profileUserId < 0) {
                    $(settings.moduleScope).hide();
                //} else {
                //    window.dnn.social.applyBindings(new window.dnn.status.ExtendedView($, ko, settings), settings.moduleScope);
                //}
            }
        } catch(ex) {
            window.dnn.social.topLevelExceptionHandler(settings, ex);
        }
    }
</script>