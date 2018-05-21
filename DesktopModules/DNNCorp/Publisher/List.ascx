<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="List.ascx.cs" Inherits="DotNetNuke.Enterprise.Publisher.List" %>
<%@ Import Namespace="Newtonsoft.Json" %>

<asp:Panel ID="ScopeWrapper" CssClass="publisher" runat="server">

    <div class="publisher-breadcrumbs publisher-top-bar publisher-list-top-bar DnnModule-Publisher-AccentColor-Background" data-bind="visible: isFiltered">
        <a href="<%= ListUrl %>" title="<%= PageName %>"><%= PageName %></a> 
        <span class="breadcrumbs-separator">></span> 
        <span class="title"><%= LocalizeString("SearchResults") %></span>
    </div>

    <div class="empty DnnModule-Publisher-List-Empty" data-bind="visible: emptyListPlaceholderVisible" style="display: none">
        <span class="empty-title" data-bind="visible: !isFiltered()"><%= LocalizeString("EmptyTitle") %></span>
        <span class="empty-title" data-bind="visible: isFiltered"><%= LocalizeString("NoSearchResult") %></span>
        <% if (ShowEditBar)
           { %>
        <span class="empty-subtitle" data-bind="visible: !isFiltered()"><%= LocalizeString("EmptySubtitle") %></span>        
        <% } %>
    </div>
    
    <div class="publisher-top-bar publisher-list-top-bar DnnModule-Publisher-AccentColor-Background" data-bind="visible: latestPostsTitleVisible">
        <%= LocalizeString("Latest") %>
    </div>
    
    <div class="card-container">
        <% 
            // First page is rendered server side for SEO porpuses
            foreach (var post in PostList)
            {
                %>
            <div class="publishcard small-card DnnModule-Publisher-AccentColor-Border" onclick="window.location.href = '<%= post.DetailsUrl %>'" 
                style="<%= GetBackgroundImageCss(post) %>" data-bind="event: { touchend: function(data, event) { $root.touchStart('<%= post.DetailsUrl %>', event) } }">                        
                <div>                    
                    <h2><a href="<%= post.DetailsUrl %>" title="<%= post.Title %>"><%= post.Title %></a></h2>
                    
                    <div class="story"><%= post.Summary %></div>
                    <div class="date"><%= LocalizeString("PostedOn") %> <span><%= post.PublishedOnDate %></span> <%= LocalizeString("By") %></div>
                    <div class="author"><%= post.AuthorDisplayName %></div>
                    <% if (ShowNumberOfComments && post.AllowedComments)
                        { %>
                    <div class="comments">
                        <span class="disqus-comment-count" data-disqus-identifier="<%= post.ContentItemId %>"></span> 
                    </div>
                    <% } %>
                </div>
            </div>
        <%
            } %>
        <!-- ko foreach: postList -->
        <div class="publishcard small-card DnnModule-Publisher-AccentColor-Border" data-bind="click: $root.openDetail, style: { backgroundImage: $root.backgroundImage($data) }, event: { touchstart: function(data, event) { $root.touchStart(detailsUrl, event) } }">                        
            <div>                    
                <h2><a href="javascript:void(0)" data-bind="text: title, attr: { href: detailsUrl, title: title }"></a></h2>
                    
                <div class="story" data-bind="text: summary"></div>
                <div class="date"><%= LocalizeString("PostedOn") %> <span data-bind="text: publishedOnDate"></span> <%= LocalizeString("By") %></div>
                <div class="author" data-bind="text: authorDisplayName"></div>
                <% if (ShowNumberOfComments)
                    { %>
                <div class="comments" data-bind="visible: allowedComments">
                    <span class="disqus-comment-count" data-bind="attr: {'data-disqus-identifier': contentItemId}"></span> 
                </div>
                <% } %>
            </div>
        </div>
        <!-- /ko -->
    </div>
        
    <% if (PostList.Count() >= PageSize)
        { %>

    <div class="load-more">
        <a href="javascript:void(0)" data-bind="click: loadMore, visible: loadMoreVisible"><%= LocalizeString("LoadMore") %></a>            
    </div>

    <% } %>
    
    <div class="loading-overlay" data-bind="visible: loading"></div>

    <script type="text/javascript">
        jQuery(function() {            
            var config = {
                moduleId: <%= ModuleId %>,
                bindingElementSelector: '#<%= ScopeWrapper.ClientID %>',
                pageSize: <%= PageSize %>,
                excludePostIds: <%= JsonConvert.SerializeObject(ExcludePostIds) %>,
                listUrl: <%= JsonConvert.SerializeObject(ListUrl) %>,
                selectedAuthorName: <%= JsonConvert.SerializeObject(SelectedAuthorName) %>,
                isFirstLoadEmpty: <%= JsonConvert.SerializeObject(IsEmpty) %>,      
                latestPostsTitleVisible: <%= JsonConvert.SerializeObject(PostList.Any() && !Filtered)%>
            };
            
            dnn.modules.publisher.RequestUtils.init(config.moduleId);
            dnn.modules.publisher.CardViewManager.init(config);
        });
    </script>

    <% if (ShowNumberOfComments)
        { %>
        <script type="text/javascript">        
            /* * * CONFIGURATION VARIABLES: EDIT BEFORE PASTING INTO YOUR WEBPAGE * * */
            var disqus_shortname = '<%= DisqusShortName %>';

            /* * * DON'T EDIT BELOW THIS LINE * * */
            (function () {
                var s = document.createElement('script'); s.async = true;
                s.type = 'text/javascript';
                s.src = '//' + disqus_shortname + '.disqus.com/count.js';
                (document.getElementsByTagName('HEAD')[0] || document.getElementsByTagName('BODY')[0]).appendChild(s);
            }());
        </script>
    <% } %>

</asp:Panel>
   