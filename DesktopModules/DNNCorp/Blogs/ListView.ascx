<%@ Control Language="C#" AutoEventWireup="false" CodeBehind="ListView.ascx.cs" Inherits="DotNetNuke.Professional.Blogs.ListView" %>
<%@ Import Namespace="DotNetNuke.Professional.Blogs.Components.Common" %>
<%@ Import Namespace="DotNetNuke.Services.Localization" %>
<%@ Register TagPrefix="blogs" TagName="BlogEditor" Src="~/DesktopModules/DNNCorp/Blogs/Controls/BlogEditor.ascx" %>

<asp:Panel runat="server" ID="ScopeWrapper" CssClass="moduleContainer dnnClear">
    <%-- NORMAL VIEW --%>
    <!-- ko ifnot: isMobileView -->
    <div class="moduleContainer-normalView ko-container">
    <% if (!string.IsNullOrEmpty(AddEntryUrl))
        { %>
    <a class="dnnPrimaryAction dnnLeft" href="<%= AddEntryUrl %>" style="margin: 15px 0 15px 20px">
        <%= Localization.GetString("NewEntry", SharedResource)%>
    </a>
    <% } %>
    <% if (CanCreateBlog)
       { %>
    <a id="createBlog" data-bind="click: addNewBlog" title="<%= LocalizeString("CreateBlog") %>" class="dnnSecondaryAction dnnRight" style="margin: 15px 0 15px 0">
        <%= LocalizeString("CreateBlog") %>
    </a>
    <% } %>
    <div class="list-container dnnClear">
        <div class="status-container dnnClear">
            <% if (CurrentBlog == null && CurrentAuthor == null)
               { %>
            <div class="status-scroll dnnSocialTabs dnnLeft">
                <a data-bind="click: function () { return $root.category('daterange'); }, attr: { 'class': selectedClass('daterange') }">
                    <span><%= LocalizeString("AllEnties") %></span>
                </a>
                <% if (!string.IsNullOrEmpty(AddEntryUrl))
                   { %>
                <a data-bind="click: function () { return $root.category('myentries'); }, attr: { 'class': selectedClass('myentries') }">
                    <span><%= LocalizeString("MyBlog") %></span>
                </a>
                <% } %>
                <a data-bind="click: function () { return $root.category('mycomments'); }, attr: { 'class': selectedClass('mycomments') }">
                    <span><%= LocalizeString("MyComments") %></span>
                </a>
            </div>

            <% } %>
            <% if(CurrentBlog != null)
               { %>
            <div class="dnnClear">
                <div>
                    <h4><%= CurrentBlog.Title %></h4>
                    <% if (CurrentBlog.Syndicated)
                       { %>
                    <a href="<%= Links.RssByBlog(ModuleContext, CurrentBlog.BlogId) %>" class="blog-social-rss"></a>
                    <% } %>
                </div>
                <ul>
                    <li>
                        <a href="<%= HomeUrl %>"><%= Localization.GetString("ViewBlog", SharedResource) %></a>
                    </li>
                    <% if (CanEditCurrentBlog)
                       { %>
                    <li>
                        <a data-bind="click: blogEdit"><%= Localization.GetString("EditBlog", SharedResource) %></a>
                    </li>
                    <% } %>
                </ul>
            </div>
            <% } %>
            
             <% if(CurrentAuthor != null)
               { %>
            <div class="dnnClear">
                <div>
                    <h4>All blogs from author: <%= CurrentAuthor.DisplayName %></h4>
                </div>
                <ul>
                    <li>
                        <a href="<%= HomeUrl %>"><%= Localization.GetString("ViewBlog", SharedResource) %></a>
                    </li>
                </ul>
            </div>
            <% } %>
        </div>
        <div class="sort-filter-container moduleTopInsetShadowBox dnnClear static-row">
            <div class="dnnLeft">
                <input type="text" placeholder="Filter by tag" class="dnnTagsInput" style="width: 190px" />
            </div>
        </div>
        <div class="sort-filter-container moduleTopInsetShadowBox dnnClear ko-container">
            <div class="dnnLeft">
                <input type="text" class="sort-tags-input" placeholder="<%= LocalizeString("FilterPlaceholder") %>" />
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
        <div class="dnnClear list-tbl-container">
            <table class="list-tbl loading-container">
                <tbody class="static-row">
                    <asp:Repeater runat="server" ID="repeatItems" OnItemDataBound="repeatItems_ItemDataBound" EnableViewState="False">
                        <ItemTemplate>
                            <tr class="list-row">
                                <td>
                                    <asp:Literal runat="server" ID="litItemTemplate" />
                                </td>
                            </tr>
                        </ItemTemplate>
                    </asp:Repeater>
                </tbody>
                <tbody class="ko-container">
                    <!-- ko with: $root.componentFactory.resolve('ListController') -->
                    <!-- ko foreach: results -->
                    <tr class="list-row">
                        <td>
                            <asp:Literal runat="server" ID="litClientTemplate"></asp:Literal>
                        </td>
                    </tr>
                    <!-- /ko -->
                    <!-- /ko -->
                </tbody>
            </table>
            <div class="list-noresult ko-container" data-bind="visible: $root.componentFactory.resolve('ListController').results().length == 0">
                <span data-bind="html: $root.noRecordsMsg"></span>
            </div>
        </div>
        <div class="pager-bottom moduleTopInsetShadowBox dnnClear">
            <% if (!string.IsNullOrEmpty(AddEntryUrl))
               { %>
            <div class="bottom-create-btn dnnLeft">
                <a id="addEntry" class="dnnPrimaryAction" href="<%= AddEntryUrl %>"><%= Localization.GetString("NewEntry", SharedResource)%></a>
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
        <% if (CanCreateBlog)
           { %>
            <a data-bind="click: addNewBlogMobileView" class="dnnMobileCreateNewButton"><%= LocalizeString("CreateBlog") %></a>
        <% } %>
        <% if (CurrentBlog != null)
           { %>
            <div class="dnnMobile-blog-title">
                <h4><%= CurrentBlog.Title %></h4>
                <% if (CurrentBlog.Syndicated)
                   { %>
                <a href="<%= Links.RssByBlog(ModuleContext, CurrentBlog.BlogId) %>" class="blog-social-rss"></a>
                <% } %>
            </div>
        <% } %>
        <% if (CurrentAuthor != null)
           { %>
            <div class="dnnMobile-blog-title">
                <h4>All blogs from author: <%= CurrentAuthor.DisplayName %></h4>
            </div>
        <% } %>
        <div class="dnnMobileListContainer dnnClear">
            <% if (CurrentBlog == null && CurrentAuthor == null)
               { %>
            <div class="dnnMobileStatusContainer dnnClear">
                <select data-bind="value: selectedMobileViewCategory">
                    <option value="daterange"><%= LocalizeString("AllEnties") %></option>
                    <option value="myentries"><%= LocalizeString("MyBlog") %></option>
                    <option value="mycomments"><%= LocalizeString("MyComments") %></option>
                </select>
            </div>
            <% } %>
            <div class='dnnMobileListTblContainer'>
                <!-- ko with: $root.componentFactory.resolve('ListController') -->
                <table class='dnnMobileListTbl loading-container'>
                    <tbody>
                        <!-- ko foreach: resultsMobile -->
                        <tr>
                            <td class="dnnMobileIdeaTitle">
                                <a data-bind="attr: { href: detailsUrl }" class="dnnSocialLink">
                                    <span data-bind="html: title" class="list-row-title"></span>
                                </a>
                                <div>
                                    <a data-bind="html: authorDisplayName, attr: { href: authorUrl }"></a>
                                    <span data-bind="html: ' - ' + publishOnDateDisplay()"></span>
                                    <span data-bind="html: ' - ' + commentCount() + ' comments'"></span>
                                </div>
                                <div class="list-row-summary-image" data-bind="css: { hide: entryImageExists() != true }, html: entryImage"></div>
                                <p class="list-row-content" data-bind="html: decodedSummary">
                                </p>
                            </td>
                        </tr>
                        <!-- /ko -->
                    </tbody>
                </table>
                <!-- ko if: resultsMobile().length === 0 -->
                <div class="list-noresult">
                    <span data-bind="html: $root.noRecordsMsg"></span>
                </div>
                <!-- /ko -->
                <!-- /ko -->
                <!-- ko if: $root.pager().totalPages() - 1 > $root.pager().page() -->
                <a data-bind="click: loadMore" class="dnnMobileLoadMoreLink">
                    <span><%= LocalizeString("MoreEntries") %></span>
                </a>
                <!-- /ko -->
            </div>
            <div class="dnnMobileTwoButtonsGroup" style="margin-top: 10px;">
                <% if (!string.IsNullOrEmpty(AddEntryUrl))
                   { %>
                <a class="dnnPrimaryAction" href="<%= AddEntryUrl %>"><%= Localization.GetString("NewEntry", SharedResource)%></a>
                <% } %>
                <% if (CurrentBlog != null || CurrentAuthor != null)
                   { %>
                <a class="dnnSecondaryAction" href="<%= HomeUrl %>"><%= Localization.GetString("ViewBlog", SharedResource)%></a>
                <% } %>
                <div class="dnnClear"></div>
            </div>
        </div>
    </div>
    <!-- /ko -->
    <%-- END MOBILE VIEW --%>
    <div class="editor-dialog" style="display: none;">
        <blogs:BlogEditor ID="CtlBlogEditor" runat="server" />
    </div>
</asp:Panel>

<input type="hidden" name="evoq_social_tab_id" value="<%= ModuleContext.TabId %>"/>
<input type="hidden" name="evoq_social_module_id" value="<%= ModuleContext.ModuleId %>"/>
<script type='text/javascript'>
    dnn.social.loading('<%= ScopeWrapper.ClientID %>');
    function viewBlogInit(settings) {
        settings.moduleScope = $(settings.controlScope)[0];
        if (!settings.moduleScope) {
            return;
        }

        settings.editorModuleScope = $('#' + '<%= CtlBlogEditor.FindControl("ScopeWrapper").ClientID %>')[0];

        try {
            window.dnn.social.applyBindings(new window.dnn.blogs.ListView(settings), settings.moduleScope);
        } catch (ex) {
            window.dnn.social.topLevelExceptionHandler(settings, ex);
        }
    }
</script>
