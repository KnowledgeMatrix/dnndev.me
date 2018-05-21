<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="MetaDataControl.ascx.cs" Inherits="DotNetNuke.Professional.Wiki.MetaDataControl" %>

<%@ Register tagPrefix="wiki" tagName="MetaDataEditor" src="Controls/MetaDataEditor.ascx" %>

<wiki:MetaDataEditor runat="server" ID="ctlEditor" />

<asp:Panel runat="server" ID="ScopeWrapper" CssClass="dnnClear moduleContainer status-compact-container status-container wiki-meta">
    <% if (CanEdit)
       { %>
    <div class="dnnRight">
        <a data-bind="click: function() { return dnn.wiki.editMeta(); }">
            <%= LocalizeString("Edit") %>
        </a>
    </div>
    <% } %>

    <!-- ko if: metadata() != null -->
    <h6>
        <%= LocalizeString("Overview") %>
    </h6>
    <!-- /ko -->
    
    <!-- ko if: !String.isEmpty(image()) -->
    <div class="dnnClear">
        <img data-bind="attr: { src: image, title: caption }" class="wiki-meta-image" />
    </div>
    <!-- /ko -->

    <!-- ko if: metadata() != null -->
    <table class="wiki-meta-table">
        <tbody>
            <!-- ko foreach: { data: Object.keys($root.metadata().dataTable()), as: 'key' } -->
            <tr>
                <td>
                    <span data-bind="text: key"></span>
                </td>
                <td>
                    <span data-bind="html: $root.metaValue($root.metadata().dataTable()[key])"></span>
                </td>
            </tr>
            <!-- /ko -->
        </tbody>
    </table>
    <!-- /ko -->    
</asp:Panel>
<script type="text/javascript">
    function wiki_metadataInit(settings) {
        settings.moduleScope = $(settings.moduleScope)[0];
        if (typeof settings.moduleScope === 'undefined') {
            return;
        }
        try {
            window.dnn.social.applyBindings(new window.dnn.wiki.MetaData(settings), settings.moduleScope);
        } catch (ex) {
            window.dnn.social.topLevelExceptionHandler(settings, ex);
        }
    }
</script>