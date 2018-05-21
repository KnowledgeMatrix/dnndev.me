<%@ Control Language="C#" AutoEventWireup="false" CodeBehind="Activities.ascx.cs" Inherits="DotNetNuke.Professional.Activities.Activities" %>
<div class="dnnActivities" id="dnnActivities">

<asp:Panel runat="server" ID="ScopeWrapper" CssClass="dnnClear">

    <div class="idea-list-container">
        <div class="dnnTableFilter">
            <div class="dnnFilterSet">
                <label class="filter" for="priviledge-filter-content" ><%= LocalizeString("SearchFilter") %></label>
                <input id="priviledge-filter-content" type="text" class="filter-content" data-bind="value: searchText, valueUpdate: 'afterkeydown'" placeholder="<%= LocalizeString("Search") %>" />
            </div>
        </div>
        <!-- ko with: $root.componentFactory.resolve('SearchController') -->
        <table class="dnnTableDisplay fixed" id="activity-table">
            <colgroup>
                <col class="activities-col-action-name"/>
                <col class="activities-col-module"/>
                <col class="activities-col-points"/>
            </colgroup>
            <thead>
                <tr>
                    <th class="activities-col-action-name"><a href="#ActionDisplayName" id="activities-table-action-name" data-bind="click: sort"><%= LocalizeString("Activity") %></a></th>
                    <th class="activities-col-module"><a href="#ModuleName" id="activities-table-module-name" data-bind="click: sort"><%= LocalizeString("Module") %></a></th>
                    <th class="activities-col-points"><a href="#ReputationPoints" id="activities-table-point" data-bind="click: sort"><%= LocalizeString("Points") %></a></th>
                </tr>
            </thead>
            <tfoot>
                <tr>
                    <td colspan="3">
                        <span class="dnnResults">
                            <%= LocalizeString("Showing") %>
                            <span data-bind="text: startPosition()"></span>-<span data-bind="text: endPosition()"></span>
                            <%= LocalizeString("Of") %>
                            <span data-bind="text: totalResults"></span><%= "&#160;" + LocalizeString("Results") %>
                        </span>
                        <ul class="dnnPagination" id="activitiesPages" data-bind="html: $root.pagingControl">
                        </ul>
                    </td>
                </tr>
            </tfoot>
            <tbody>
                <!-- ko foreach: results -->
                <tr>
                    <td>
                        <div class="qaTooltip">
                            <em data-bind="text: actionName"></em>
                            <div class="tag-menu" style="display: none;">
                                <p data-bind="text: actionDescription"></p>
                            </div>
                        </div>
                    </td>
                    <td data-bind="text: areaOfSite"></td>
                    <td class="number-cell" data-bind="text: reputationPoints"></td>
                </tr>
                <!-- /ko -->
            </tbody>
        </table>
        <!-- /ko -->
    </div>
</asp:Panel>
</div>

<script type="text/javascript">
    function initActivitiesView(settings) {
        settings.moduleScope = $(settings.moduleScope)[0];
        if (!settings.moduleScope) {
            return;
        }

        try {
            dnn.social.applyBindings(new dnn.activities.ActivitiesView($, ko, settings), settings.moduleScope);
        } catch(ex) {
            dnn.social.topLevelExceptionHandler(settings, ex);
        } 
    }
</script>
