<%@ Control Language="C#" AutoEventWireup="false" CodeBehind="Tags.ascx.cs" Inherits="DotNetNuke.Professional.RelatedContent.Controls.Tags" %>
<%@ Import Namespace="DotNetNuke.Services.Localization" %>
<asp:Panel runat="server" ID="ScopeWrapper" CssClass="dnnClear status-container">
    <div class="relatedcontent-detail-container" id="tagContainer">
        <h6><%= Localization.GetString("TagsTitle", LocalResourceFile) %></h6>
        <!-- ko if: results().length < 1 -->
        <div class="dnnClear">
            <span><%= Localization.GetString("NoTags", LocalResourceFile) %></span>
        </div>
        <!-- /ko -->
        <!-- ko if: results().length > 0 -->
        <div class='dnnClear primary-collections'>
            <ul class="tagCollections">
                <!-- ko foreach: results -->
                    <li>
                        <span data-bind="html: totalTermUsage"></span>
                        <a data-bind="html: name, attr: { href: '?tags=' + encodeURIComponent(name) }" ></a>
                    </li>
                <!-- /ko -->
            </ul>
        </div>
        <!-- /ko -->
    </div>
</asp:Panel>
<script type="text/javascript">
    function relatedTagsInit(settings) {
        settings.moduleScope = $(settings.moduleScope)[0];
        if (!settings.moduleScope) {
            return;
        }

        try {
            window.dnn.social.applyBindings(new window.dnn.related.Tags($, ko, settings), settings.moduleScope);
        } catch (ex) {
           window.dnn.social.topLevelExceptionHandler(settings, ex);
        }
    }
</script>