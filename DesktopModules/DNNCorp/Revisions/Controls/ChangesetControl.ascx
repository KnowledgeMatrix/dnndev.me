<%@ Control Language="C#" AutoEventWireup="false" CodeBehind="ChangesetControl.ascx.cs" Inherits="DotNetNuke.Social.Revisions.Controls.ChangesetControl" %>

<%@ Register tagPrefix="revisions" tagName="Compare" src="CompareRevisions.ascx" %>
<%@ Register tagPrefix="revisions" tagName="CompactCompare" src="CompactComparison.ascx" %>

<asp:Panel runat="server" ID="ScopeWrapper" CssClass="revisions-changesets">
    <revisions:Compare runat="server" ID="ctlCompare" />
    <revisions:CompactCompare runat="server" ID="ctlCompactCompare" />
    
    <div class="dnnClear">
        <table class="revision-changesets-table dnnTableDisplay">
            <thead>
                <tr class="dnnGridHeader">
                    <th></th>
                    <th class="version-cell"><span><%= LocalizeString("Version") %></span></th>
                    <th><span><%= LocalizeString("Date") %></span></th>
                    <th><span><%= LocalizeString("User") %></span></th>
                    <th><span><%= LocalizeString("Type") %></span></th>
                    <th><span><%= LocalizeString("State") %></span></th>
                    <th><span><%= LocalizeString("Actions") %></span></th>
                </tr>
            </thead>
            <tbody data-bind="foreach: revisions">
                <tr data-bind="attr: { 'class': $root.getRevisionStyle($data) }, event: { mouseover: $root.hoverIn, mouseout: $root.hoverOut }">
                    <td>
                        <input type="checkbox" data-bind="checked: selected"/>
                    </td>
                    <td class="version-cell">
                        <span data-bind="text: sequence"></span>
                    </td>
                    <td>
                        <span data-bind="text: dateString"></span>
                    </td>
                    <td>
                        <span data-bind="text: displayName"></span>
                    </td>
                    <td>
                        <span data-bind="text: typeString"></span>
                    </td>
                    <td>
                        <span data-bind="text: stateString"></span>
                    </td>
                    <td>
                        <!-- ko if: $root.isLatest($data.revisionId()) -->
                        <!-- ko if: state() == 2 && revisionType() != 1 -->
                        <a data-bind="click: function() { $root.rollback($data); }" class="revision-rollback-link" title="<%= LocalizeString("Rollback") %>"></a>
                        <a data-bind="click: function() { $root['delete']($data); }" class="revision-delete-link" title="<%= LocalizeString("Delete") %>"></a>
                        <!-- /ko -->
                        <!-- ko if: state() == 1 -->
                        <a data-bind="click: function() { $root.undoReject($data); }" class="revision-rollback-link" title="<%= LocalizeString("UndoRejection") %>"></a>
                        <!-- /ko -->
                        <!-- ko if: state() != 3 && revisionType() == 1 -->
                        <a data-bind="click: function() { $root['delete']($data); }" class="revision-delete-link" title="<%= LocalizeString("Delete") %>"></a>
                        <!-- /ko -->
                        <!-- /ko -->
                        <!-- ko if: state() == 0 -->
                        <a data-bind="click: function() { $root.reject($data); }" class="revision-reject-link" title="<%= LocalizeString("Reject") %>"></a>
                        <a data-bind="click: function() { $root.publish($data); }" class="revision-publish-link" title="<%= LocalizeString("Approve") %>"></a>
                        <!-- /ko -->
                        <!-- ko if: state() == 3 && $root.moderator() -->
                        <a data-bind="click: function() { $root.undoDelete($data); }" class="revision-rollback-link" title="<%= LocalizeString("UndoDelete") %>"></a>
                        <!-- /ko -->
                    </td>
                </tr>
            </tbody>
        </table>
    </div>
    <ul class="dnnPagination" data-bind="html: pager.markup()"></ul>
    <div class="dnnClear">
        <ul class="dnnActions dnnRight">
            <!-- ko ifnot: modal -->           
            <li><a data-bind="click: read" class="dnnSecondaryAction"><%= LocalizeString("Read") %></a></li>
            <!-- /ko -->
            <li><a data-bind="click: compare" class="dnnPrimaryAction revisions-compare-button" disabled="disabled"><%= LocalizeString("Compare") %></a></li>
        </ul>
    </div>
</asp:Panel>

<script type="text/javascript">
function revisions_changesetInit(settings) {
    settings.moduleScope = $(settings.moduleScope)[0];
    if (typeof settings.moduleScope !== 'undefined') {
        try {
            window.dnn.social.applyBindings(new window.dnn.revisions.ChangesetControl(settings), settings.moduleScope);
        } catch(ex) {
            window.dnn.social.topLevelExceptionHandler(settings, ex);
        }
    }
}
</script>