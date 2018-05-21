<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ManagementView.ascx.cs" Inherits="DotNetNuke.Professional.RelatedContent.ManagementView" %>

<% if (ContentItemId >= 0)
   { %>
    <asp:Panel runat="server" ID="ScopeWrapper">
        <div class="related-content-container dnn_AdminWrapper dnnClear">
            <!-- ko with: componentFactory.resolve('SearchController') -->
            <div class="dnnTableFilter">
                <div class="dnnFilterSet">
                    <label class="related-filter-label">
                        <%= LocalizeString("Filter") %>
                    </label>

                    <input type="text" class="related-search-text" placeholder="<%= LocalizeString("SearchFilter") %>"
                           data-bind="value: searchText, valueUpdate: 'afterkeydown'"/>
                
                    <span class="related-content-types">
                        <table>
                            <tbody>
                                <tr>
                                    <td>
                                        <label class="related-content-types-label">
                                            <%= LocalizeString("ContentTypes") %>
                                        </label>
                                    </td>
                                    <td>
                                        <input type="text" class="related-content-types-input" placeholder="<%= LocalizeString("TypeFilter") %>" />
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </span>
                </div>
            </div>
            <table class="related-content-item dnnTableDisplay">
                <thead>
                    <tr>
                        <th><span class="related-table-header"><%= LocalizeString("Title") %></span></th>
                        <th><span class="related-table-header"><%= LocalizeString("Preview") %></span></th>
                        <th><span class="related-table-header"><%= LocalizeString("Type") %></span></th>
                        <th><span class="related-table-header"><%= LocalizeString("Author") %></span></th>
                        <th><span class="related-table-header"><%= LocalizeString("Created") %></span></th>
                    </tr>
                </thead>
                <tfoot>
                    <tr>
                        <td colspan="5">
                            <p class="dnnResults">
                                <%= LocalizeString("Showing") %>
                                <span data-bind="text: startPosition()"></span>-<span data-bind="text: endPosition()"></span>
                                <%= LocalizeString("Of") %>
                                <span data-bind="text: totalResults"></span>
                                <%= LocalizeString("Results") %>
                            </p>
                            <ul class="dnnPagination" id="scoringPages" data-bind="html: $root.pagingControl"></ul>
                        </td>
                    </tr>
                </tfoot>
                <tbody>
                    <!-- ko foreach: results -->
                    <tr data-bind="with: item, click: toggleSelection, attr: { 'class': rowStyle() }">
                        <td class="related-content-title">
                            <a class='dnnSocialLink' data-bind="attr: { href: contentItemUrl }, html: contentTitle"></a>
                        </td>
                        <td class="related-content-preview">
                            <span data-bind="html: previewDocument"></span>
                        </td>
                        <td class="related-content-type">
                            <span data-bind="text: contentTypeDescription"></span>
                        </td>
                        <td class="related-content-author">
                            <a data-bind="attr: { href: createdByProfileUrl }, text: createdByDisplayName"></a>
                        </td>
                        <td class="related-content-creation-date">
                            <span data-bind="text: relativeDate"></span>
                        </td>
                    </tr>
                    <!-- /ko -->
                </tbody>
            </table>
            <!-- /ko -->
        </div>
    </asp:Panel>
    <script type="text/javascript">
        function relatedContentInit(settings) {
            settings.moduleScope = $(settings.moduleScope)[0];
            if (!settings.moduleScope) {
                return;
            }

            try {
                window.dnn.social.applyBindings(new window.dnn.related.ManagementView($, ko, settings), settings.moduleScope);
            } catch(ex) {
                window.dnn.social.topLevelExceptionHandler(settings, ex);
            }
        }
    </script>
<% } %>