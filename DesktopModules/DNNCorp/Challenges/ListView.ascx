<%@ Control Language="C#" AutoEventWireup="false" CodeBehind="ListView.ascx.cs" Inherits="DotNetNuke.Professional.Challenges.ListView" %>
<%@ Import Namespace="DotNetNuke.Services.Localization" %>
<%@ Register TagPrefix="challenges" TagName="EditView" Src="~/DesktopModules/DNNCorp/Challenges/Controls/EditView.ascx" %>
<asp:Panel ID="ScopeWrapper" runat="server" CssClass=" moduleContainer dnnClear">
    <%-- NORMAL VIEW --%>
    <!-- ko ifnot: isMobileView -->
    <div class="moduleContainer-normalView ko-container">
        <div class="list-container dnnClear">
            <div class="status-container dnnClear">
                <div class="status-scroll dnnSocialTabs dnnLeft">
                    <a data-bind="click: function () { return $root.category('all'); }, attr: { 'class': selectedClass('all') }">
                        <span><%= LocalizeString("AllChallenges") %></span>
                    </a>
                    <a data-bind="click: function () { return $root.category('activechallenges'); }, attr: { 'class': selectedClass('activechallenges') }">
                        <span><%= LocalizeString("ActiveChallenges") %></span>
                    </a>
                    <a data-bind="click: function () { return $root.category('mychallenges'); }, attr: { 'class': selectedClass('mychallenges') }">
                        <span><%= LocalizeString("MyChallenges") %></span>
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
                    <select style="width: 164px">
                        <option><%= LocalizeString("SortByRecentActivity") %></option>
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
                    <tbody class="static-row">
                        <% foreach (var challenge in InitialSet)
                           { %>
                        <tr class="list-row">
                            <td class="challenge-list-accept">
                                <div class="accept-button">
                                    <span class="points"></span>
                                </div>
                            </td>
                            <td class="list-row-summary-container">
                                <a href="<%= challenge.DetailsUrl %>" class="dnnSocialLink"><span class="list-row-title"><%= challenge.ContentTitle %></span></a>
                                <div class="dnnClear"></div>
                                <p class="list-row-content">
                                    <%= challenge.ContentSummary %>
                                </p>
                                <div class="dnnClear">
                                    <% if (challenge.Tags.Any())
                                       {%>
                                    <div>
                                        <span class="list-row-label">
                                            <%= LocalizeString("Tags") %>
                                        </span>
                                        <ul class="list-row-tags">
                                            <% foreach (var tag in challenge.Tags)
                                               { %>
                                            <li>
                                                <a href="<%= tag.TagUrl %>">
                                                    <%: tag.Name %>
                                            </a>
                                            </li>
                                            <% } %>
                                        </ul>
                                    </div>
                                    <% } %>
                                </div>
                            </td>
                        </tr>
                        <% } %>
                    </tbody>
                    <tbody class="ko-container">
                        <!-- ko with: $root.componentFactory.resolve('ListController') -->
                        <!-- ko foreach: results -->
                        <tr class="list-row">
                            <td class="challenge-list-accept">
                                <div class="accept-button">
                                    <span data-bind="text: repPoints" class="points"></span>
                                </div>
                            </td>
                            <td class="list-row-summary-container">
                                <a data-bind="attr: { href: detailsUrl }" class="dnnSocialLink">
                                    <span data-bind="html: contentTitle" class="list-row-title"></span>
                                </a>
                                <p data-bind="html: contentSummary" class="list-row-content dnnClear"></p>
                                <div class="dnnClear">
                                    <!-- ko if: tags().length > 0 -->
                                    <div>
                                        <span class="list-row-label">
                                            <%= LocalizeString("Tags") %>
                                        </span>
                                        <ul class="list-row-tags">
                                            <!-- ko foreach: tags -->
                                            <li>
                                                <a data-bind="click: function () { $root.searchTag(this) }">
                                                    <span data-bind="text: name"></span>
                                                </a>
                                            </li>
                                            <!-- /ko -->
                                        </ul>
                                    </div>
                                    <!-- /ko -->
                                </div>
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
                <% if (CanModerate)
                   { %>
                <div class="bottom-create-btn dnnLeft">
                    <a class="dnnPrimaryAction" data-bind="click: addDialog"><%= Localization.GetString("SearchCreate", "~/DesktopModules/DNNCorp/Challenges/App_LocalResources/Search.ascx.resx") %></a>
                </div>
                <% } %>
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
                    <option value="all"><%= LocalizeString("AllChallenges") %></option>
                    <option value="activechallenges"><%= LocalizeString("ActiveChallenges") %></option>
                    <option value="mychallenges"><%= LocalizeString("MyChallenges") %></option>
                    <option value="mycomments"><%= LocalizeString("MyComments") %></option>
                </select>
            </div>
            <div class='dnnMobileListTblContainer'>
                <!-- ko with: $root.componentFactory.resolve('ListController') -->
                <table class='dnnMobileListTbl loading-container'>
                    <tbody>
                        <!-- ko foreach: resultsMobile -->
                        <tr>
                            <td class="dnnMobileIdeaTitle">
                                <a data-bind="attr: { href: detailsUrl }" class="dnnSocialLink">
                                    <span data-bind="html: contentTitle" class="list-row-title"></span>
                                </a>
                                <div>
                                    <span data-bind="html: contentSummary" class="list-row-title"></span>
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
                    <span><%= LocalizeString("MoreChallenges") %></span>
                </a>
                <!-- /ko -->
            </div>
            <% if (CanModerate)
               { %>
            <a class="dnnMobileCreateNewButton" data-bind="click: addDialogMobileView"><%= Localization.GetString("SearchCreate", "~/DesktopModules/DNNCorp/Challenges/App_LocalResources/Search.ascx.resx") %></a>
            <% } %>
        </div>
    </div>
    <!-- /ko -->
    <%-- END MOBILE VIEW --%>
    <div class="editor-dialog" style="display: none" data-bind="stopBindings: true" >
        <challenges:EditView id="CtlEditor" runat="server" />
    </div>
</asp:Panel>
<script type='text/javascript'>
    dnn.social.loading('<%= ScopeWrapper.ClientID %>');
    function challengeListInit(settings) {
        settings.moduleScope = $(settings.moduleScope)[0];
        if (!settings.moduleScope) {
            return;
        }

        try {
            window.dnn.social.applyBindings(new window.dnn.challenges.ListView(settings), settings.moduleScope);
        } catch (ex) {
            window.dnn.social.topLevelExceptionHandler(settings, ex);
        }
    }
</script>
