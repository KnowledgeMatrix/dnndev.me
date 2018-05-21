<%@ Control Language="C#" AutoEventWireup="false" CodeBehind="Relationships.ascx.cs" Inherits="DotNetNuke.Professional.RelatedContent.Controls.Relationships" %>
<%@ Import Namespace="DotNetNuke.Services.Localization" %>
<%@ Register TagPrefix="related" TagName="ManagementView" Src="~/DesktopModules/DNNCorp/RelatedContent/ManagementView.ascx" %>
<asp:Panel runat="server" ID="ScopeWrapper" CssClass="dnnClear moduleContainer">
    <div class="relatedcontent-detail-container">
        <h6><%= Localization.GetString("RelatedContentTitle", LocalResourceFile) %></h6>
        <div id="relatedContent moduleTopInsetShadowBox dnnClear">
            <%= Evaluator.GetHeader(Summary) %>
            <% foreach (var related in Related)
               { %>
                <%= Evaluator.GetItem(related) %>
            <% } %>
            <%= Evaluator.GetFooter(Summary) %>
        </div>
    
        <% if (CanEdit)
           { %>
            <div class="related-content-edit" data-bind="stopBindings: true">
                <related:ManagementView ID="ctlManagement" runat="server"></related:ManagementView>
            </div>
    
            <div class="related-content-edit-container">
                <a data-bind="click: manage">
                    <%= Localization.GetString("Manage", LocalResourceFile)%>
                </a>
            </div>
        <% } %>
        <div class="dnnClear"></div>
    </div>
    <div class="dnnClear"></div>
</asp:Panel>
<% if (CanEdit)
   { %>
    <script type="text/javascript">
        function relatedEditInit(settings) {
            settings.moduleScope = $(settings.moduleScope)[0];
            if (!settings.moduleScope) {
                return;
            }

            try {
                window.dnn.social.applyBindings(new window.dnn.related.EditorView($, ko, settings), settings.moduleScope);
            } catch(ex) {
                window.dnn.social.topLevelExceptionHandler(settings, ex);
            }
        }
    </script>
<% } %>