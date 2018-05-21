<%@ Control Language="C#" AutoEventWireup="false" CodeBehind="IdeaList.ascx.cs" Inherits="DotNetNuke.Professional.Ideas.Views.IdeaList" %>
<%@ Import Namespace="DotNetNuke.Services.Localization" %>
<%@ Register TagPrefix="ideas" TagName="EditorControl" Src="~/DesktopModules/DNNCorp/Ideas/Controls/EditorControl.ascx" %>
<asp:Panel ID="ScopeWrapper" runat="server" CssClass=" moduleContainer dnnClear">
    <%-- NORMAL VIEW --%>
    <!-- ko ifnot: isMobileView -->
    <div class="moduleContainer-normalView ko-container">
        <div class="list-container dnnClear">
            <div class="status-container dnnClear">
                <div class="status-scroll dnnSocialTabs dnnLeft">
                    <a data-bind="click: function () { return $root.category('all'); }, attr: { 'class': selectedClass('all') }">
                        <span><%= LocalizeString("AllIdeas") %></span>
                    </a>
                    <a data-bind="click: function () { return $root.category('topideas'); }, attr: { 'class': selectedClass('topideas') }">
                        <span><%= LocalizeString("TopIdeas") %></span>
                    </a>
                    <a data-bind="click: function () { return $root.category('myideas'); }, attr: { 'class': selectedClass('myideas') }">
                        <span><%= LocalizeString("MyIdeas") %></span>
                    </a>
                    <a data-bind="click: function () { return $root.category('myvotes'); }, attr: { 'class': selectedClass('myvotes') }">
                        <span><%= LocalizeString("MyVotes") %></span>
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
                    <select style="width: 117px">
                        <option>Any status</option>
                    </select>
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
                    <select data-bind="options: $root.statusList, optionsValue: 'value', optionsText: 'status', value: $root.stateFilter"></select>
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
                        <% foreach (var idea in InitialSet)
                           { %>
                        <tr class="list-row">
                            <td class="idea-list-vote-panel">
                                <div>
                                    <ul class="status">
                                        <li>
                                            <span class="idea-status status-submitted"></span>
                                        </li>
                                        <li class="idea-status-label">
                                            <span><%= idea.StatusName %></span>
                                        </li>
                                    </ul>
                                </div>

                                <div class="dnnClear"></div>

                                <div class="vote-count">
                                    <span><%= idea.Votes %></span>
                                    <br />
                                    <div class="vote-label">
                                        <%= LocalizeString("Votes") %>
                                    </div>
                                </div>

                                <div class="vote-button" style="float: right;">
                                    <a class="<%= idea.UserVotes  > 0 ? "idea-vote-button dnnTertiaryAction activeIndicator" : "idea-vote-button dnnTertiaryAction"%>">
                                        <%= string.Format("{0} {1}", idea.UserVotes, LocalizeString("Votes")) %>
                                    </a>
                                </div>

                            </td>
                            <td class="list-row-summary-container">
                                <a href="<%= idea.DetailsUrl %>#comments" class="dnnSocialLink" style="float: right;">
                                    <span class="list-row-comment-link">&mdash; <%= idea.CommentCount %>
                                        <% if (idea.CommentCount == 1)
                                           { %><%= LocalizeString("CommentSingular") %><% } %>
                                        <% if (idea.CommentCount != 1)
                                           { %><%= LocalizeString("Comments") %><% } %>
                                </span>
                                </a>
                                <a href="<%= idea.DetailsUrl %>" class="dnnSocialLink">
                                    <span class="list-row-title">
                                        <%= idea.ContentTitle %>
                                </span>
                                </a>

                                <div class="dnnClear"></div>

                                <p class="list-row-content">
                                    <%= idea.ContentSummary %>
                                </p>

                                <div class="dnnClear">
                                    <span class="list-row-label"><%= LocalizeString("Author") %></span>
                                    <a href="<%= idea.AuthorUrl %>" class="dnnSocialLink">
                                        <%= idea.CreatedByDisplayName %>
                                </a>

                                    <% if (idea.Tags.Any())
                                       {%>
                                    <div>
                                        <span class="list-row-label">
                                            <%= LocalizeString("Tags") %>
                                    </span>

                                        <ul class="list-row-tags">
                                            <% foreach (var tag in idea.Tags)
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
                            <td class="idea-list-vote-panel">
                                <div>
                                    <ul class="status">
                                        <li>
                                            <span data-bind="attr: { 'class': 'idea-status ' + statusClass() }"></span>
                                        </li>
                                        <li class="idea-status-label">
                                            <span data-bind="text: statusName"></span>
                                        </li>
                                    </ul>
                                </div>

                                <div class="dnnClear"></div>

                                <!-- ko if: $root.votingEnabled -->
                                <div class="vote-count">
                                    <span data-bind="text: votes"></span>
                                    <br />
                                    <div class="vote-label">
                                        <%= LocalizeString("Votes") %>
                                    </div>
                                </div>

                                <!-- ko if: !isClosed() && !protected() -->
                                <div class="vote-button" style="float: right;">
                                    <a data-bind="click: $root.vote, text: userVotesLabel, attr: { 'class': voteStyle }"></a>
                                </div>
                                <!-- /ko -->

                                <div class="dnnClear"></div>

                                <div class="idea-vote-options" data-bind="attr: { id: 'vote-panel-' + ideaId() }">
                                    <div data-bind="with: voteButtons" style="display: inline-block;">
                                        <div class="ie-shadow dnnLeft">
                                            <!-- ko foreach: buttons() -->

                                            <!-- ko if: disabled -->
                                            <a href="javascript:void(0)" data-bind="attr: { 'class': 'button ' + type, 'title': title }">
                                                <span data-bind="text: text"></span>
                                            </a>
                                            <!-- /ko -->

                                            <!-- ko ifnot: disabled -->
                                            <a href="javascript:void(0)" data-bind="click: exec, attr: { 'class': 'button ' + type, 'title': title }">
                                                <span data-bind="text: text"></span>
                                            </a>
                                            <!-- /ko -->


                                            <!-- /ko -->
                                        </div>

                                        <!-- ko if: showRemoveButton() -->
                                        <div class="ie-shadow dnnRight" style="margin-left: 20px;">
                                            <a data-bind="click: removeVotes" class="dnnTertiaryAction idea-remove-button">
                                                <span>
                                                    <%= LocalizeString("RemoveVotes") %>
                                            </span>
                                            </a>
                                        </div>
                                        <!-- /ko -->
                                        <div class="dnnClear"></div>
                                    </div>
                                    <div class="remaining dnnClear">
                                        <%=  LocalizeString("VotesRemaining") %>
                                    </div>
                                </div>
                                <!-- /ko -->
                            </td>
                            <td class="list-row-summary-container">
                                <a data-bind="attr: { href: detailsUrl() + '#comments' }" class="dnnSocialLink" style="float: right;">
                                    <span class="list-row-comment-link">&mdash; <span data-bind="text: commentCount"></span>
                                        <span data-bind="visible: commentSingular"><%= LocalizeString("CommentSingular") %></span>
                                        <span data-bind="visible: commentPlural"><%= LocalizeString("Comments") %></span>
                                    </span>
                                </a>
                                <a data-bind="attr: { href: detailsUrl }" class="dnnSocialLink">
                                    <span data-bind="html: contentTitle" class="list-row-title"></span>
                                </a>

                                <p data-bind="html: contentSummary" class="list-row-content dnnClear"></p>

                                <div class="dnnClear">
                                    <span class="list-row-label">
                                        <%= LocalizeString("Author") %>
                                </span>
                                    <a data-bind="attr: { href: authorUrl }" class="dnnSocialLink">
                                        <span data-bind="text: createdByDisplayName"></span>
                                    </a>

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
                <% if (AllowNewIdeas)
                   { %>
                <div class="bottom-create-btn dnnLeft">
                    <a class="dnnPrimaryAction" data-bind="click: addDialog"><%= Localization.GetString("SearchCreate", "~/DesktopModules/DNNCorp/Ideas/App_LocalResources/Search.ascx.resx") %></a>
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
                    <option value="all"><%= LocalizeString("AllIdeas") %></option>
                    <option value="topideas"><%= LocalizeString("TopIdeas") %></option>
                    <option value="myideas"><%= LocalizeString("MyIdeas") %></option>
                    <option value="myvotes"><%= LocalizeString("MyVotes") %></option>
                    <option value="mycomments"><%= LocalizeString("MyComments") %></option>
                </select>
            </div>
            <div class='dnnMobileListTblContainer'>
                <!-- ko with: $root.componentFactory.resolve('ListController') -->
                <table class='dnnMobileListTbl loading-container'>
                    <tbody>
                        <!-- ko foreach: resultsMobile -->
                        <tr>
                            <td class="dnnMobileIdeaVote">
                                <a data-bind="click: $root.voteMobileView, attr: { 'class': voteStyle }">
                                    <span data-bind="html: userVotesLabelMobileView"></span>
                                </a>
                            </td>
                            <td class="dnnMobileIdeaTitle">
                                <a data-bind="attr: { href: detailsUrl }" class="dnnSocialLink">
                                    <span data-bind="html: contentTitle" class="list-row-title"></span>
                                </a>
                                <div>
                                    <span data-bind="text: votes"></span>
                                    <span><%= LocalizeString("Votes") %></span>
                                    <span>- </span>
                                    <span data-bind="text: statusName"></span>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <div class="dnnMobile-idea-vote-options" data-bind="attr: { id: 'dnnMobile-vote-panel-' + ideaId() }">
                                    <div data-bind="with: voteButtons">
                                        <!-- ko if: showRemoveButton() -->
                                        <a data-bind="click: removeVotes" class="button">
                                            <span>0
                                        </span>
                                        </a>
                                        <!-- /ko -->
                                        <!-- ko foreach: buttons() -->
                                        <!-- ko if: disabled -->
                                        <a href="javascript:void(0)" data-bind="attr: { 'class': 'button ' + type }">
                                            <span data-bind="text: textMobileView"></span>
                                        </a>
                                        <!-- /ko -->
                                        <!-- ko ifnot: disabled -->
                                        <a href="javascript:void(0)" data-bind="click: exec, attr: { 'class': 'button ' + type }">
                                            <span data-bind="text: textMobileView"></span>
                                        </a>
                                        <!-- /ko -->
                                        <!-- /ko -->
                                        <div class="dnnClear"></div>
                                    </div>
                                    <div class="remaining dnnClear">
                                        <%=  LocalizeString("VotesRemaining") %>
                                    </div>
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
                    <span><%= LocalizeString("MoreIdeas") %></span>
                </a>
                <!-- /ko -->
            </div>
            <% if (AllowNewIdeas)
               { %>
            <a class="dnnMobileCreateNewButton" data-bind="click: addDialogMobileView"><%= Localization.GetString("SearchCreate", "~/DesktopModules/DNNCorp/Ideas/App_LocalResources/Search.ascx.resx") %></a>
            <% } %>
        </div>
    </div>
    <!-- /ko -->
    <%-- END MOBILE VIEW --%>
    <div class="editor-dialog" style="display: none">
        <ideas:EditorControl ID="CtlEditor" runat="server" />
    </div>
</asp:Panel>

<input type="hidden" name="evoq_social_tab_id" value="<%= ModuleContext.TabId %>"/>
<input type="hidden" name="evoq_social_module_id" value="<%= ModuleContext.ModuleId %>"/>
<script type='text/javascript'>
    dnn.social.loading('<%= ScopeWrapper.ClientID %>');
    function ideasInit(settings) {
        settings.moduleScope = $(settings.moduleScope)[0];
        if (!settings.moduleScope) {
            return;
        }

        try {
            window.dnn.social.applyBindings(new window.dnn.ideas.ListView(settings), settings.moduleScope);
        } catch (ex) {
            window.dnn.social.topLevelExceptionHandler(settings, ex);
        }
    }
</script>
