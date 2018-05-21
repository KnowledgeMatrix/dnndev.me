<%@ Control Language="C#" AutoEventWireup="false" CodeBehind="ListContainer.ascx.cs" Inherits="DotNetNuke.Professional.Wiki.Controls.ListContainer" %>
<%@ Import Namespace="DotNetNuke.Services.Localization" %>
<%@ Register TagPrefix="wiki" TagName="ContentEditor" Src="ContentEditor.ascx" %>
<%@ Register TagPrefix="wiki" TagName="ArticleContent" Src="ArticleContent.ascx" %>
<div runat="server">
    <wiki:ContentEditor runat="server" ID="CtlEditor" />
</div>
<asp:Panel runat="server" ID="ScopeWrapper" CssClass="moduleContainer dnnClear">
    <%-- NORMAL VIEW --%>
    <!-- ko ifnot: isMobileView -->
    <div class="moduleContainer-normalView ko-container">
    <% if (PrimaryArticle != null)
       { %>
    <div class="dnnClear wiki-primary-article">
    </div>
    <% }
       else if (CanModerate)
       { %>
    <a data-bind="click: function () { $root.create(true); }" style="display: inline-block; margin: 20px 0 0 0">
        <%= LocalizeString("CreateFrontArticle") %>
    </a>
    <% } %>

    <div class="dnnClear list-container">
        <div class="status-container dnnClear">
            <div class="status-scroll dnnSocialTabs dnnLeft">
                <a data-bind="click: function () { return $root.category('all'); }, attr: { 'class': selectedClass('all') }">
                    <span><%= LocalizeString("All") %></span>
                </a>
                <a data-bind="click: function () { return $root.category('myarticles'); }, attr: { 'class': selectedClass('myarticles') }">
                    <span><%= LocalizeString("MyArticles") %></span>
                </a>
            </div>
        </div>
        <div class="sort-filter-container moduleTopInsetShadowBox dnnClear static-row">
            <div class="dnnLeft">
                <input type="text" placeholder="Filter by tag" class="dnnTagsInput" style="width: 190px" />
            </div>
            <div class="dnnLeft">
                <select style="width: 143px">
                    <option>Sort by last active</option>
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
                    <% foreach (var article in InitialSet)
                        { %>
                        <tr class="list-row">
                            <td>
                                <a class="dnnSocialLink">
                                    <span class="list-row-title"><%= article.ContentTitle %></span>
                                </a>
                                <span class="wiki-lastupdated">Last updated: <%= article.LastActiveRelativeDate %></span>
                                <p class="list-row-content">
                                    <span><%= article.TransformedSummary %></span>
                                    <a class="dnnSocialLink" href="<%= article.DetailsUrl %>">
                                       <%= LocalizeString("ViewFullPage") %>
                                    </a>
                                </p>
                                <% if (article.Tags.Any())
                                   { %>
                                <div>
                                    <span class="list-row-label"><%= LocalizeString("Tags") %></span>
                                    <ul class="list-row-tags">
                                        <% foreach (var tag in article.Tags)
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
                        <td>
                            <a data-bind="attr: { href: detailsUrl }" class="dnnSocialLink">
                                <span data-bind="html: contentTitle" class="list-row-title"></span>
                            </a>
                            <span class="wiki-lastupdated" data-bind="html: 'Last updated: ' + lastActiveRelativeDate() "></span>
                            <p class="list-row-content">
                                <span data-bind="html: transformedSummary"></span>
                                <a data-bind="attr: { href: detailsUrl }" class="dnnSocialLink">
                                   <%= LocalizeString("ViewFullPage") %>
                                </a>
                            </p>
                         
                            <!-- ko if: tags().length > 0 -->
                            <div>
                                <span class="list-row-label"><%= LocalizeString("Tags") %></span>
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
            <% if (CanCreate){ %>
            <div class="bottom-create-btn dnnLeft">
                <a class="dnnPrimaryAction" data-bind="click: addDialog"><%= Localization.GetString("SearchCreate","~/DesktopModules/DNNCorp/Wiki/App_LocalResources/Search.ascx.resx") %></a>
            </div>
            <%} %>
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
     <% if (PrimaryArticle != null)
       { %>
    <div class="dnnClear wiki-primary-article-mobile">
    </div>
    <% } %>

    <div class="dnnMobileListContainer dnnClear">
        <div class="dnnMobileStatusContainer dnnClear">
            <select data-bind="value: selectedMobileViewCategory">
                <option value="all"><%= LocalizeString("All") %></option>
                <option value="myarticles"><%= LocalizeString("MyArticles") %></option>
                    <% if (CanModerate)
                    { %>
                <option value="draftonly"><%= LocalizeString("DraftOnly") %></option>
                <% } %>
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
                                <span><%= LocalizeString("LastActive") %> </span><span data-bind="html: lastActiveRelativeDate()"></span>
                            </div>
                            <p class="list-row-content" data-bind="html: transformedSummary">
                            </p>
                            <a data-bind="attr: { href: detailsUrl }" class="dnnSocialLink">
                                <span><%= LocalizeString("ViewFullPage") %></span>
                            </a>
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
                <span>More Articles</span>
            </a>
            <!-- /ko -->
        </div>
        <% if (CanCreate){ %>
          <a class="dnnMobileCreateNewButton" data-bind="click: addDialogMobileView"><%= Localization.GetString("SearchCreate","~/DesktopModules/DNNCorp/Wiki/App_LocalResources/Search.ascx.resx") %></a>
        <%} %>
    </div>
    </div>
    <!-- /ko -->
    <%-- END MOBILE VIEW --%>
    <div class="wiki-primary-article-common" runat="server">
        <wiki:ArticleContent runat="server" ID="CtlContent" ShowEditor="True" />
    </div>
</asp:Panel>

<input type="hidden" name="evoq_social_tab_id" value="<%= ModuleContext.TabId %>"/>
<input type="hidden" name="evoq_social_module_id" value="<%= ModuleContext.ModuleId %>"/>
<script type="text/javascript">
    dnn.social.loading('<%= ScopeWrapper.ClientID %>');
    function wiki_listContainerInit(settings) {
        settings.moduleScope = $(settings.moduleScope)[0];
        if (typeof settings.moduleScope === 'undefined') return;
        try {
            window.dnn.social.applyBindings(new window.dnn.wiki.ListView(settings), settings.moduleScope);
        } catch (ex) {
            window.dnn.social.topLevelExceptionHandler(settings, ex);
        }
    }
</script>
