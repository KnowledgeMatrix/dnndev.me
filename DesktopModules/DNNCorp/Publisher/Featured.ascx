<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Featured.ascx.cs" Inherits="DotNetNuke.Enterprise.Publisher.Featured" %>
<%@ Import Namespace="DotNetNuke.Common.Utilities" %>

<asp:Panel ID="ScopeWrapper" CssClass="publisher publisher-featured" runat="server" style="display: none">
    
    <% if (PostList.Any())
       { %>
    <div class="publisher-top-bar DnnModule-Publisher-AccentColor-Background"><%= LocalizeString("Featured") %></div>
    <% } %>

    <div class="card-container">
        <% var i = 1;
           foreach (var post in PostList)
           { %>
        
        <%-- Desktop View --%>    
        <div class="publishcard desktop-card DnnModule-Publisher-AccentColor-Border" style="<%= GetBackgroundImageCss(post, i++) %>" onclick="window.location.href = '<%= post.DetailsUrl %>';">
	        <div class="publishmeta">
	            <%= LocalizeString("PostedOn") %> <%= post.PublishedOnDate %> <%= LocalizeString("By") %> <span class="author"><%= post.AuthorDisplayName %></span>
                <% if (ShowNumberOfComments && post.AllowedComments)
                   { %>
                <div class="comments">
                    <span class="disqus-comment-count" data-disqus-identifier="<%= post.ContentItemId %>"></span>
                </div>
                <% } %>
	        </div>
            <div class="publishbottom">
	            <h2><a href="<%= post.DetailsUrl %>" title="<%= post.Title %>"><%= post.Title %></a></h2>
	            <div class="publishdesc">
		            <%= post.Summary %>
	            </div>                
            </div>
        </div>
        
        <%-- Mobile View --%>    
        <div class="publishcard mobile-card small-card DnnModule-Publisher-AccentColor-Border" 
            data-details-url="<%= post.DetailsUrl %>"
            style="<%= GetBackgroundImageCss(post) %>">                 
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
        <% } %>
    </div>
    
    <script type="text/javascript">
        jQuery(function () {
            var config = {
                scopeWrapperId: '#<%= ScopeWrapper.ClientID %>',
                isFiltered: <%= Json.Serialize(Filtered) %>
            };
            dnn.modules.publisher.FeaturedCardManager.init(config);
        });
    </script>
</asp:Panel>