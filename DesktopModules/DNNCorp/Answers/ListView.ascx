<%@ Control Language="C#" AutoEventWireup="false" CodeBehind="ListView.ascx.cs" Inherits="DotNetNuke.Professional.Answers.ListView" %>
<%@ Import Namespace="DotNetNuke.Services.Localization" %>
<%@ Register TagPrefix="answer" TagName="AskQuestion" Src="~/DesktopModules/DNNCorp/Answers/Controls/AskQuestion.ascx" %>
<asp:Panel runat="server" ID="ScopeWrapper" CssClass="moduleContainer dnnClear">
    <%-- NORMAL VIEW --%>
    <!-- ko ifnot: isMobileView -->
    <div class="moduleContainer-normalView ko-container">
        <div class="list-container dnnClear">
            <div class="status-container dnnClear">
                <div class="status-scroll dnnSocialTabs dnnLeft">
                    <a data-bind="click: function () { return $root.category('all'); }, attr: { 'class': selectedClass('all') }">
                        <span><%= LocalizeString("AllQuestions") %></span>
                    </a>
                    <a data-bind="click: function () { return $root.category('answered'); }, attr: { 'class': selectedClass('answered') }">
                        <span><%= LocalizeString("Questions") %></span>
                    </a>
                    <a data-bind="click: function () { return $root.category('unanswered'); }, attr: { 'class': selectedClass('unanswered') }">
                        <span><%= LocalizeString("Unanswered") %></span>
                    </a>
                    <a data-bind="click: function () { return $root.category('myquestions'); }, attr: { 'class': selectedClass('myquestions') }">
                        <span><%= LocalizeString("MyQuestions") %></span>
                    </a>
                    <a data-bind="click: function () { return $root.category('myanswers'); }, attr: { 'class': selectedClass('myanswers') }">
                        <span><%= LocalizeString("MyAnswers") %></span>
                    </a>
                </div>
            </div>
            <div class="sort-filter-container moduleTopInsetShadowBox dnnClear static-row">
                <div class="dnnLeft">
                    <input type="text" placeholder="Filter by tag" class="dnnTagsInput" style="width: 190px" />
                </div>
                <div class="dnnLeft">
                    <select>
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
                        <!-- Static data -->
                        <% foreach (var question in InitialSet)
                            { %>
                        <tr class="list-row">
                            <td style="width: 85px;">
                                <div class="answer-answer-score">
                                    <span class="answer-score"><%= question.Score %></span>
                                    <span><%= LocalizeString("Votes") %></span>
                                </div>
                                <div class="<%= question.AnswerId > 0 ? "answer-answer-count answer-accepted" : "answer-answer-count" %>">
                                    <% if (question.TotalAnswers == 0)
                                        { %>
                                    <span class="no-answer">
                                        <span>0</span>
                                        <img src='<%= ResolveUrl("~/DesktopModules/DNNCorp/Answers/images/noanswer.png") %>' alt='<%= LocalizeString("NoAnswers") %>' title='<%= LocalizeString("NoAnswers") %>'>
                                    </span>
                                    <% }
                                        else
                                        { %>
                                    <span class="answer-count"><%= question.TotalAnswers %></span>
                                    <span><%= LocalizeString("Answers") %></span>

                                    <% } %>
                                </div>
                            </td>
                            <td>
                                <a href="<%= question.DetailsUrl %>" class="dnnSocialLink">
                                    <span class="list-row-title">
                                        <%= question.ContentTitle %>
                                    </span>
                                </a>
                                <p class="list-row-content">
                                    <%= question.ContentSummary %>
                                </p>
                                <div>
                                    <span class="list-row-label"><%= LocalizeString("Author") %></span>
                                    <a href="<%= question.AuthorUrl %>" class="dnnSocialLink">
                                        <%= question.AuthorDisplayName %>
                                    </a>
                                </div>
                                <% if (question.Tags.Any())
                                    {%>
                                <div>
                                    <span class="list-row-label">
                                        <%= LocalizeString("Tags") %>
                                    </span>
                                    <ul class="list-row-tags">
                                        <% foreach (var tag in question.Tags)
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
                            </td>
                        </tr>
                        <% } %>
                    </tbody>
                    <tbody class="ko-container">
                        <!-- ko with: $root.componentFactory.resolve('ListController') -->
                        <!-- ko foreach: results -->
                        <tr class="list-row">
                            <td style="width: 85px;">
                                <div class="answer-answer-score">
                                    <span class="answer-score" data-bind="text: score"></span>
                                    <span><%= LocalizeString("Votes") %></span>
                                </div>
                                <div data-bind="attr: { 'class': hasAcceptedAnswer }">
                                    <!-- ko if: showNoAnswer -->
                                    <span class="no-answer">
                                        <span>0</span>
                                        <img src='<%= ResolveUrl("~/DesktopModules/DNNCorp/Answers/images/noanswer.png") %>' alt='<%= LocalizeString("NoAnswers") %>' title='<%= LocalizeString("NoAnswers") %>'>
                                    </span>
                                    <!-- /ko -->
                                    <!-- ko ifnot: showNoAnswer -->
                                    <span class="answer-count" data-bind="text: totalAnswers"></span>
                                    <span><%= LocalizeString("Answers") %></span>
                                    <!-- /ko -->
                                </div>
                            </td>
                            <td>
                                <a data-bind="attr: { href: detailsUrl }" class="dnnSocialLink">
                                    <span data-bind="html: contentTitle" class="list-row-title"></span>
                                </a>
                                <p class="list-row-content" data-bind="html: contentSummary">
                                </p>
                                <div>
                                    <span class="list-row-label"><%= LocalizeString("Author") %></span>
                                    <a data-bind="attr: { href: authorUrl }" class="dnnSocialLink"><span data-bind="text: authorDisplayName"></span></a>
                                </div>
                                <!-- ko if: tags().length > 0 -->
                                <div>
                                    <span class="list-row-label"><%= LocalizeString("Tags") %></span>
                                    <ul class="list-row-tags">
                                        <!-- ko foreach: tags -->
                                        <li>
                                            <a data-bind="click: function(){ $root.searchTag(this) }">
                                                <span data-bind="text: name"></span>
                                            </a>
                                        </li>
                                        <!-- /ko -->
                                    </ul>
                                </div>
                                <!-- /ko -->
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
                    <a id="askQuestion"class="dnnPrimaryAction" data-bind="click: addDialog"><%= Localization.GetString("SearchCreate","~/DesktopModules/DNNCorp/Answers/App_LocalResources/Search.ascx.resx") %></a>
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
                    <option value="all"><%= LocalizeString("AllQuestions") %></option>
                    <option value="answered"><%= LocalizeString("Questions") %></option>
                    <option value="unanswered"><%= LocalizeString("Unanswered") %></option>
                    <option value="myquestions"><%= LocalizeString("MyQuestions") %></option>
                    <option value="myanswers"><%= LocalizeString("MyAnswers") %></option>
                </select>
            </div>
            <div class='dnnMobileListTblContainer'>
                <!-- ko with: $root.componentFactory.resolve('ListController') -->
                <table class='dnnMobileListTbl loading-container'>
                    <tbody>
                        <!-- ko foreach: resultsMobile -->
                        <tr>
                            <td data-bind="attr: { 'class': answerCountListViewMobile }">
                                <span class="answer-count" data-bind="text: totalAnswers"></span>
                                <span data-bind="text: totalAnswers() === 1? '<%= LocalizeString("Answer") %>    ':'<%= LocalizeString("Answers") %>    '"></span>
                            </td>
                            <td class="dnnMobileIdeaTitle">
                                <a data-bind="attr: { href: detailsUrl }" class="dnnSocialLink">
                                    <span data-bind="html: contentTitle" class="list-row-title"></span>
                                </a>
                                <div>
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
                    <span><%= LocalizeString("MoreQuestions") %></span>
                </a>
                <!-- /ko -->
            </div>
            <a class="dnnMobileCreateNewButton" data-bind="click: addDialogMobileView"><%= Localization.GetString("SearchCreate","~/DesktopModules/DNNCorp/Answers/App_LocalResources/Search.ascx.resx") %></a>
        </div>
    </div>
    <!-- /ko -->
    <%-- END MOBILE VIEW --%>
    <div data-bind="stopBindings: true" class="editor-dialog" style="display: none;">
        <answer:AskQuestion ID="CtlEditor" runat="server" />
    </div>
</asp:Panel>

<input type="hidden" name="evoq_social_tab_id" value="<%= ModuleContext.TabId %>"/>
<input type="hidden" name="evoq_social_module_id" value="<%= ModuleContext.ModuleId %>"/>
<script type='text/javascript'>
    dnn.social.loading('<%= ScopeWrapper.ClientID %>');
    function answersInit(settings) {
        settings.moduleScope = $(settings.moduleScope)[0];
        if (!settings.moduleScope) {
            return;
        }

        try {
            window.dnn.social.applyBindings(new window.dnn.answers.ListView(settings), settings.moduleScope);
        } catch (ex) {
            window.dnn.social.topLevelExceptionHandler(settings, ex);
        }
    }
</script>
