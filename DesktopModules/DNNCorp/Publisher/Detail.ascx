<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Detail.ascx.cs" Inherits="DotNetNuke.Enterprise.Publisher.Detail" %>
<%@ Import Namespace="DotNetNuke.Common.Utilities" %>

<asp:Panel ID="ScopeWrapper" CssClass="publisher-detail-view DnnModule-Publisher-BackgroundColor DnnModule-Publisher-Color" runat="server">
    <% if (Post != null)
       { %>
    <div class="publisher-breadcrumbs publisher-top-bar DnnModule-Publisher-AccentColor-Background">
        <a href="<%= ListUrl %>" title="<%= PageName %>"><%= PageName %></a> 
        <span class="breadcrumbs-separator">></span> 
        <span class="title"><%= Post.Title %></span>
    </div>
    <% if (Post.HasMainImage)
       { %>
    <div class="post-main-image">
        <img src="<%= Post.MainImageUrl %>" alt="<%= Post.Title %>"/>
    </div>
    <% } %>
    <h1 class="post-title post-padding">
         <%= Post.Title %>
    </h1>
    <hr/>
    <div class="post-metadata post-padding">
        <div class="post-publish-date"><%= Post.PublishedOnDate %></div>
        <% if (Post.Tags.Any())
           { %>
        <div class="post-tags">
            <strong><%= LocalizeString("Tags") %></strong>: 
            <% foreach (var tag in Post.Tags)
               { %>
            <a href="<%= ListUrl + "?tags=" + HttpUtility.UrlEncode(tag) %>"><%= tag %></a>           
            <% }%>
        </div>
        <% } %>
    </div>
    <div class="post-body post-padding">
        <%= Post.Body %>
    </div>
    <hr/>
    <div class="post-author post-padding">
	    <div class="avatar-container">
		    <div class="avatar40">
                <span>
                    <em>
                        <img src="<%= Post.AuthorProfilePictureUrl %>" 
                             title="<%= Post.Author.DisplayName %>" 
                             alt="<%= Post.Author.DisplayName %>">
                    </em>
                </span>						
		    </div>
	    </div>
        <div class="biography-container">
            <div class="author-written-by">
                <% if (!String.IsNullOrEmpty(Post.Profile.Twitter))
                   { %>
                    <%= LocalizeString("WrittenBy") %><a href="http://<%= Post.Profile.Twitter %>" target="_blank" class="author-twitter"><%= Post.Author.DisplayName %></a>
                <% }
                   else
                   { %>
                    <%= LocalizeString("WrittenBy") + Post.Author.DisplayName %>
                <% } %>
                <br />
                <a href="<%= ListUrl + "?author=" + Post.Author.UserID %>">
                    <%= LocalizeString("MoreFromAuthor") %>
                </a>
            </div>
            <div>
                <% if (!String.IsNullOrEmpty(Post.Profile.City))
                   { %>
                <span class="author-city"><%= Post.Profile.City %></span>
                <% } %>
                <span class="author-website"><%= HtmlUtils.FormatWebsite(Post.Profile.Website ?? string.Empty) %></span>
            </div>
            <div class="author-biography"><%= HttpUtility.HtmlDecode(Post.Profile.Biography) %></div>
        </div>
	</div>
     <% if (ShowComments)
        { %>        
        <div id="comments" class="disqus-comments post-padding">
            <hr/>
            <div id='disqus_thread'></div>
            <script type='text/javascript'>
                function disqus_config() {
                    this.callbacks.onNewComment = [function (comment) {
                        var newCommentMessage = "New comment added: " + comment.id + " - " + comment.text;
                        console.log(newCommentMessage);
                        dnn.modules.publisher.RequestUtils.init(<%= ModuleId %>);
                        dnn.modules.publisher.DisqusManager.notifyAboutNewComment(<%= Post.ContentItemId %>);
                    }];
                }

                /* * * CONFIGURATION VARIABLES * * */
                var disqus_shortname = '<%= ShortName %>';
                var disqus_identifier = '<%= ContentItemId %>';
                var disqus_title = '<%= HttpUtility.HtmlEncode(Post.Title) %>';
                var disqus_url = document.URL;

                /* * * DON'T EDIT BELOW THIS LINE * * */
                (function () {
                    var dsq = document.createElement('script'); dsq.type = 'text/javascript'; dsq.async = true;
                    dsq.src = '//' + disqus_shortname + '.disqus.com/embed.js';
                    (document.getElementsByTagName('head')[0] || document.getElementsByTagName('body')[0]).appendChild(dsq);
                })();
            </script>
            <noscript>Please enable JavaScript to view the <a href='https://disqus.com/?ref_noscript' rel='nofollow'>comments powered by Disqus.</a></noscript>
        </div>
        <% } %>
    <% } %>
</asp:Panel>
