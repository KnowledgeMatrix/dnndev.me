<%@ Control Language="C#" AutoEventWireup="false" CodeBehind="ListView.ascx.cs" Inherits="DotNetNuke.Professional.Discussions.ListView" %>
<%@ Register TagPrefix="discussions" TagName="AddContent" Src="~/DesktopModules/DNNCorp/Discussions/Controls/EditView.ascx" %>
<%@ Import Namespace="DotNetNuke.Services.Localization" %>
<asp:Panel runat="server" ID="ScopeWrapper" CssClass="moduleContainer dnnClear">
    <%-- NORMAL VIEW --%>
    <!-- ko ifnot: isMobileView -->
    <div class="moduleContainer-normalView ko-container">
        <div class="list-container dnnClear">
            <div class="status-container dnnClear">
                <div class="status-scroll dnnSocialTabs dnnLeft">
                    <a data-bind="click: function () { return $root.category('all'); }, attr: { 'class': selectedClass('all') }">
                        <span><%= LocalizeString("All") %></span>
                    </a>
                    <a data-bind="click: function () { return $root.category('top'); }, attr: { 'class': selectedClass('top') }">
                        <span><%= LocalizeString("Top") %></span>
                    </a>
                    <a data-bind="click: function () { return $root.category('nocomments'); }, attr: { 'class': selectedClass('nocomments') }">
                        <span><%= LocalizeString("NoComments") %></span>
                    </a>
                    <a data-bind="click: function () { return $root.category('mycontentitems'); }, attr: { 'class': selectedClass('mycontentitems') }">
                        <span><%= LocalizeString("MyContentItems") %></span>
                    </a>
                    <a data-bind="click: function () { return $root.category('mycomments'); }, attr: { 'class': selectedClass('mycomments') }">
                        <span><%= LocalizeString("MyComments") %></span>
                    </a>
                </div>
            </div>
            <div class="sort-filter-container moduleTopInsetShadowBox dnnClear static-row">
                <div class="dnnLeft">
                    <input type="text" placeholder="Filter by tag" class="dnnTagsInput" style="width: 190px" />
                </div>
                <div class="dnnLeft">
                    <select>
                        <option><%= LocalizeString("SortByActivity") %></option>
                    </select>
                </div>
            </div>
            <div class="sort-filter-container moduleTopInsetShadowBox dnnClear ko-container">
                <div class="dnnLeft">
                    <input type="text" class="sort-tags-input" />
                </div>
                <div class="dnnLeft" data-bind="with: componentFactory.resolve('ListController')">
                    <select data-bind="options: $root.sortOptions, optionsValue: 'value', optionsText: 'text', value: $root.sort"></select>
                </div>
                <div class="dnnRight">
                    <div class="dnnPagingCount dnnLeft">
                        <span data-bind="html: totalResults"></span>
                    </div>
                    <!-- ko if: $root.pager().totalPages() > 1 -->
                    <div class="dnnPagingButtons dnnRight">
                        <a href="javascript:void(0)" data-bind="click: prev, attr: { 'class': 'pager-prev ' + prevClass() }"></a>
                        <a href="javascript:void(0)" data-bind="click: next, attr: { 'class': 'pager-next ' + nextClass() }"></a>
                    </div>
                    <!-- /ko -->
                </div>
            </div>

            <div class='dnnClear list-tbl-container'>
                <table class='list-tbl loading-container'>
                    <thead class="ko-container" data-bind="visible: $root.listController().totalResults() > 0">
                        <tr>
                            <td style="width: 50%"><%= Localization.GetString("Title", LocalResourceFile) %></td>
                            <td style="width: 10%"><%= Localization.GetString("Comments", LocalResourceFile) %></td>
                            <td style="width: 10%"><%= Localization.GetString("Views", LocalResourceFile) %></td>
                            <td style="width: 10%"><%= Localization.GetString("Likes", LocalResourceFile) %></td>
                            <td style="width: 20%"><%= Localization.GetString("LastActive", LocalResourceFile) %></td>
                        </tr>
                    </thead>
                    <tbody class="static-row">
                        <% if (InitialSet.Count > 0)
                           { %>
                        <tr>
                            <td style="width: 50%"><%= Localization.GetString("Title", LocalResourceFile) %></td>
                            <td style="width: 10%"><%= Localization.GetString("Comments", LocalResourceFile) %></td>
                            <td style="width: 10%"><%= Localization.GetString("Views", LocalResourceFile) %></td>
                            <td style="width: 10%"><%= Localization.GetString("Likes", LocalResourceFile) %></td>
                            <td style="width: 20%"><%= Localization.GetString("LastActive", LocalResourceFile) %></td>
                        </tr>

                        <% } %>
                        <% foreach (var topic in InitialSet)
                           { %>
                        <tr class="list-row">
                            <td>
                                <a href="<%= topic.DetailsUrl %>" class="dnnSocialLink">
                                    <span class="list-row-title">
                                        <%= topic.ContentTitle %>
                                    </span>
                                </a>
                                <div>
                                    <span class="list-row-label"><%= LocalizeString("Author") %></span>
                                    <a href="<%= topic.AuthorUrl %>" class="dnnSocialLink"><span><%= topic.AuthorDisplayName %></span></a>
                                    <% if (topic.Tags.Any())
                                       { %>
                                    <div>
                                        <span class="list-row-label"><%= LocalizeString("Tags") %></span>
                                        <ul class="list-row-tags">
                                            <% foreach (var tag in topic.Tags)
                                               { %>
                                            <li>
                                                <a><span><%: tag.Name %></span></a>
                                            </li>
                                            <%} %>
                                        </ul>
                                    </div>
                                    <%} %>
                                </div>
                            </td>
                            <td>
                                <p>
                                    <span><%= topic.CommentCount %></span>
                                </p>
                                <!-- /ko -->
                            </td>
                            <td>
                                <span><%= topic.ViewCount %></span>
                            </td>
                            <td>
                                <span><%= topic.Likes %></span>
                            </td>
                            <td>
                                <span><%= topic.LastActiveRelativeDate %></span>
                            </td>
                        </tr>

                        <%} %>
                    </tbody>
                    <tbody class="ko-container">
                        <!-- ko with: $root.componentFactory.resolve('ListController') -->
                        <!-- ko foreach: results -->
                        <tr class="list-row">
                            <td>
                                <a data-bind="attr: { href: detailsUrl }" class="dnnSocialLink">
                                    <span data-bind="html: contentTitle" class="list-row-title"></span>
                                </a>
                                <div>
                                    <span class="list-row-label"><%= LocalizeString("Author") %></span>
                                    <a data-bind="attr: { href: authorUrl }" class="dnnSocialLink"><span data-bind="text: authorDisplayName"></span></a>
                                    <!-- ko if: tags().length > 0 -->
                                    <div>
                                        <span class="list-row-label"><%= LocalizeString("Tags") %></span>
                                        <ul class="list-row-tags">
                                            <!-- ko foreach: tags -->
                                            <li>
                                                <a data-bind="click: function() { $root.searchTag(this) }">
                                                    <span data-bind="text: name"></span>
                                                </a>
                                            </li>
                                            <!-- /ko -->
                                        </ul>
                                    </div>
                                    <!-- /ko -->
                                </div>
                            </td>
                            <td>
                                <p>
                                    <span data-bind="text: commentCount"></span>
                                </p>
                                <!-- /ko -->
                            </td>
                            <td>
                                <span data-bind="text: viewCount"></span>
                            </td>
                            <td>
                                <span data-bind="text: likes"></span>
                            </td>
                            <td>
                                <span data-bind="text: lastActiveRelativeDate"></span>
                            </td>
                        </tr>
                        <!-- /ko -->
                        <!-- /ko -->
                    </tbody>
                </table>
                <div class="list-noresult ko-container" data-bind="visible: $root.componentFactory.resolve('ListController').results().length == 0">
                    <%= LocalizeString("NoRecords") %>
                </div>
            </div>
            <div class="pager-bottom moduleTopInsetShadowBox dnnClear">
                <div class="bottom-create-btn dnnLeft">
                    <a class="dnnPrimaryAction" data-bind="click: addDialog"><%= Localization.GetString("SearchCreate", "~/DesktopModules/DNNCorp/Discussions/App_LocalResources/Search.ascx.resx") %></a>
                </div>
                <div class="dnnLeft">
                    <ul class="pager-ul" data-bind="html: pagingControl"></ul>
                </div>
                <div class="dnnRight">
                    <div class="dnnPagingCount dnnLeft">
                        <span data-bind="html: totalResults"></span>
                    </div>
                    <!-- ko if: $root.pager().totalPages() > 1 -->
                    <div class="dnnPagingButtons dnnRight">
                        <a href="javascript:void(0)" data-bind="click: prev, attr: { 'class': 'pager-prev ' + prevClass() }"></a>
                        <a href="javascript:void(0)" data-bind="click: next, attr: { 'class': 'pager-next ' + nextClass() }"></a>
                    </div>
                    <!-- /ko -->
                </div>
            </div>
        </div>
    </div>
    <!-- /ko -->
    <%-- END NORMAL VIEW --%>

    <%-- MOBILE VIEW --%>
    <!-- ko if: isMobileView -->
    <div class="moduleContainer-mobileView ko-container">
        <div class="dnnMobileListContainer dnnClear">
            <div class="dnnMobileStatusContainer dnnClear">
                <select data-bind="value: selectedMobileViewCategory">
                    <option value="all"><%= LocalizeString("All") %></option>
                    <option value="top"><%= LocalizeString("Top") %></option>
                    <option value="nocomments"><%= LocalizeString("NoComments") %></option>
                    <option value="mycontentitems"><%= LocalizeString("MyContentItems") %></option>
                    <option value="mycomments"><%= LocalizeString("MyComments") %></option>
                </select>
            </div>
            <div class='dnnMobileListTblContainer loading-container'>
                <!-- ko with: $root.componentFactory.resolve('ListController') -->
                <table class='dnnMobileListTbl'>
                    <tbody>
                        <!-- ko foreach: resultsMobile -->
                        <tr>
                            <td class="dnnMobileIdeaTitle">
                                <a data-bind="attr: { href: detailsUrl }" class="dnnSocialLink">
                                    <span data-bind="html: contentTitle" class="list-row-title"></span>
                                </a>
                                <div>
                                    <span data-bind="text: commentCount"></span>
                                    <span data-bind="text: commentCount() === 1 ? '<%= LocalizeString("Reply") %>    ' : '<%= LocalizeString("Replies") %>    '"></span>
                                    <span data-bind="html: '<%= LocalizeString("LastActive") %>    ' + lastActiveRelativeDate()"></span>
                                </div>
                            </td>
                        </tr>
                        <!-- /ko -->
                    </tbody>
                </table>
                <!-- ko if: resultsMobile().length === 0 -->
                <div class="list-noresult">
                    <%= LocalizeString("NoRecords") %>
                </div>
                <!-- /ko -->
                <!-- /ko -->
                <!-- ko if: $root.pager().totalPages() - 1 > $root.pager().page() -->
                <a data-bind="click: loadMore" class="dnnMobileLoadMoreLink">
                    <span><%= LocalizeString("MoreTopics") %></span>
                </a>
                <!-- /ko -->
            </div>
            <a class="dnnMobileCreateNewButton" data-bind="click: addDialogMobileView"><%= Localization.GetString("SearchCreate","~/DesktopModules/DNNCorp/Discussions/App_LocalResources/Search.ascx.resx") %></a>
        </div>
    </div>
    <!-- /ko -->
    <%-- END MOBILE VIEW --%>
    <div data-bind="stopBindings: true" class="editor-dialog" style="display: none;" runat="server" ID="CtlEditorWrapper">
        <discussions:AddContent ID="CtlEditor" runat="server" />
    </div>
</asp:Panel>

<input type="hidden" name="evoq_social_tab_id" value="<%= ModuleContext.TabId %>"/>
<input type="hidden" name="evoq_social_module_id" value="<%= ModuleContext.ModuleId %>"/>
<script type='text/javascript'>
    dnn.social.loading('<%= ScopeWrapper.ClientID %>');
    function discussionsListInit(settings) {
        settings.moduleScope = $(settings.moduleScope)[0];
        if (!settings.moduleScope) {
            return;
        }

        try {
            window.dnn.social.applyBindings(new window.dnn.discussions.ListView(settings), settings.moduleScope);
        } catch (ex) {
            window.dnn.social.topLevelExceptionHandler(settings, ex);
        }
    }
</script>
