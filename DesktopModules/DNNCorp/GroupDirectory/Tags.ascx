<%@ Control Language="C#" AutoEventWireup="false" CodeBehind="Tags.ascx.cs" Inherits="DotNetNuke.Professional.GroupDirectory.Tags" %>

<asp:Panel ID="ScopeWrapper" runat="server" CssClass="dnnClear scopeWrapper">
    <div id="tagsContainer" class="tags-container dnnClear">
        <h6><%= LocalizeString("TagsTitle") %></h6>
        <!-- ko if: results().length < 1 -->
        <div class="dnnClear">
            <span><%= LocalizeString("NoTags") %></span>
        </div>
        <!-- /ko -->
        <div class='dnnClear primary-collections'>
            <ul class="tagCollections">
                <!-- ko foreach: results -->
                <li>
                    <span data-bind="html: totalTermUsage"></span>
                    <a data-bind="html: name, attr: { href: '?tags=' + name }"></a>
                </li>
                <!-- /ko -->
            </ul>
        </div>
    </div>
</asp:Panel>

<script type="text/javascript">
    function tagsInit(settings) {
        settings.moduleScope = $(settings.moduleScope)[0];
        if (!settings.moduleScope) {
            return;
        }

        try {
            window.dnn.social.applyBindings(new window.dnn.groupDirectory.Tags($, ko, settings), settings.moduleScope);
        } catch (ex) {
           window.dnn.social.topLevelExceptionHandler(settings, ex);
        }
    }
</script>