<%@ Control Language="C#" AutoEventWireup="false" CodeBehind="DetailView.ascx.cs" Inherits="DotNetNuke.Professional.Blogs.DetailView" %>
<%@ Register TagPrefix="social" TagName="Comments" Src="~/DesktopModules/DNNCorp/SocialLibrary/Controls/CommentsControl.ascx" %>
<%@ Register TagPrefix="social" TagName="Report" Src="~/DesktopModules/DNNCorp/SocialLibrary/Controls/ReportContent.ascx" %>
<%@ Register TagPrefix="social" TagName="LikeControl" Src="~/DesktopModules/DNNCorp/SocialLibrary/Controls/LikeControl.ascx" %>
<%@ Import Namespace="DotNetNuke.Professional.Blogs.Components.Business" %>
<%@ Import Namespace="DotNetNuke.Services.Localization" %>

<asp:Panel runat="server" ID="ScopeWrapper" CssClass="moduleContainer dnnClear">
    <%-- NORMAL VIEW --%>
    <!-- ko ifnot: isMobileView -->
    <div class="moduleContainer-normalView ko-container">
        <div class="moduleTitleContainer detail-container dnnClear">
            <!-- ko with:model -->
            <div class="title-container dnnLeft">
                <h3><%= Entry.Title %></h3>
                <p class="title-returnPrev"><asp:HyperLink runat="server" ID="hlReturn" resourcekey="hlReturn" /></p>
            </div>
            <div class="dnnRight">
                <% if (Entry.Approved)
                   { %>
                <ul class="detail-social-actions static-row">
                    <li><a href="javascript:void(0)" class="dnnSocialLike" title="<%= Localization.GetString("LikeThis", SharedResource) %>"></a></li>
                    <li><a href="javascript:void(0)" class="dnnSocialBookmark" title="<%= Localization.GetString("AddBookmark", SharedResource) %>"></a></li>
                    <li><a href="javascript:void(0)" class="dnnSocialSubscribe" title="<%= Localization.GetString("Subscribe", SharedResource) %>"></a></li>
                </ul>
                <ul class="detail-social-actions ko-container">
                    <!-- ko if: liked -->
                    <li><a href="javascript:void(0)" data-bind="click: unlike" class="dnnSocialLikeActive" title="<%= Localization.GetString("UnlikeThis", SharedResource) %>"></a></li>
                    <!-- /ko -->
                    <!-- ko ifnot: liked -->
                    <li><a href="javascript:void(0)" data-bind="click: like" class="dnnSocialLike" title="<%= Localization.GetString("LikeThis", SharedResource) %>"></a></li>
                    <!-- /ko -->
                    <!-- ko if: bookmarked -->
                    <li><a href="javascript:void(0)" data-bind="click: unbookmark" class="dnnSocialBookmarkActive" title="<%= Localization.GetString("RemoveBookmark", SharedResource) %>"></a></li>
                    <!-- /ko -->
                    <!-- ko ifnot: bookmarked -->
                    <li><a href="javascript:void(0)" data-bind="click: bookmark" class="dnnSocialBookmark" title="<%= Localization.GetString("AddBookmark", SharedResource) %>"></a></li>
                    <!-- /ko -->
                    <!-- ko if: subscribed -->
                    <li><a href="javascript:void(0)" data-bind="click: unsubscribe" class="dnnSocialSubscribeActive" title="<%= Localization.GetString("Unsubscribe", SharedResource) %>"></a></li>
                    <!-- /ko -->
                    <!-- ko ifnot: subscribed -->
                    <li><a href="javascript:void(0)" data-bind="click: subscribe" class="dnnSocialSubscribe" title="<%= Localization.GetString("Subscribe", SharedResource) %>"></a></li>
                    <!-- /ko -->
                </ul>
                <% } %>
            </div>
            <!-- /ko -->
        </div>
        <div class="moduleThreadContainer">
            <div class="info-panel">
                <ul class="dnnLeft">
                    <li>
                        <span><%= Utility.DateFromUtc(Entry.PublishOnDate, UserInfo.Profile.PreferredTimeZone).ToShortDateString() %></span>
                    </li>
                    <li>
                        <span><%= Entry.Views %> </span>
                        <span><%= Localization.GetString(Entry.Views == 1 ? "View" : "Views", LocalResourceFile) %></span>
                    </li>
                </ul>
                <ul class="dnnRight">
                    <% if (Blog.AllowComments)
                       { %>
                    <li>
                        <span data-bind="html: commentCount"><%= Entry.CommentCount %></span>
                        <span><%= LocalizeString("Replies") %></span>
                    </li>
                    <% } %>
                    <li>
                        <span><%= LocalizeString("Author") %></span>
                        <a href="<%= Entry.AuthorUrl %>" class='dnnSocialLink'><%= Entry.AuthorDisplayName %></a>
                    </li>
                </ul>
                <div class="dnnClear"></div>
                <% if (Entry.Tags.Any())
                   { %>
                <div>
                    <span class="list-row-label"><%= LocalizeString("Tags") %>:</span>
                    <ul class="list-row-tags">
                      <% foreach (var tag in Entry.Tags)
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
                <div class="dnnClear"></div>
            </div>
            <div class="detail-content-edit">
                <% if (CanEditEntry()){ %>
                    <div class="comment-actions-menu" id="detail-content-moderator-menu">
                        <a href="javascript:void(0)" class="comment-actions"></a>
                        <ul class="comment-actions-dropdown">
                            <li><a data-bind="click: editEntry" ID="EditEntryLink" runat="server" ><%= LocalizeString("EditEntry") %></a></li>
                            <% if (CanApproveEntry()){ %>
                            <li><a data-bind="click: deleteEntry" ID="DeleteEntryLink" runat="server" ><%= LocalizeString("Delete") %></a></li>
                            <% } %>
                        </ul>
                    </div>
                <% } %>
            </div>
            <asp:Literal runat="server" ID="litDetailViewTemplate"></asp:Literal>
            <asp:Panel ID="panelComments" runat="server" CssClass="blog-comment-container moduleBotInsetShadowBox" Visible="False">
                <!-- ko with: model -->
                <!-- ko if: commentCount() > 0 -->
                <h3>
                    <%= LocalizeString("Comments") %>
                </h3>
                <!-- /ko -->
                <!-- ko if: commentsEnabled -->
                <div class="comments-container-normalview"></div>
                <!-- /ko -->
                <!-- ko ifnot: commentsEnabled -->
                <div class="detail-main-container dnnClear">
                <div class="dnnFormMessage comments-disabled-message">
                    <%= LocalizeString("CommentsDisabled") %>
                </div>
                </div>
                <!-- /ko -->
                <!-- /ko -->
            </asp:Panel>
        </div>
    </div>
    <!-- /ko -->
    <%-- END NORMAL VIEW --%>
    
    <%-- MOBILE VIEW --%>
    <!-- ko if: isMobileView -->
    <div class="dnnMobile-moduleThreadContainer dnnClear moduleContainer-mobileView ko-container">
        <div class="dnnLeft">
            <asp:HyperLink runat="server" ID="hlReturnMobileView" CssClass="dnnMobile-detailViewReturn" />
        </div>
        <div class="dnnRight">
            <% if (Entry.Approved){ %>
            <ul class="loading-container loading dnnMobile-socialActions" data-bind="with: model">
                <!-- ko if: liked -->
                <li><a href="javascript:void(0)" data-bind="click: unlike" class="dnnSocialLikeActive" title="<%= Localization.GetString("UnlikeThis", SharedResource) %>"></a></li>
                <!-- /ko -->
                <!-- ko ifnot: liked -->
                <li><a href="javascript:void(0)" data-bind="click: like" class="dnnSocialLike" title="<%= Localization.GetString("LikeThis", SharedResource) %>"></a>
                </li>
                <!-- /ko -->
                <!-- ko if: bookmarked -->
                <li><a href="javascript:void(0)" data-bind="click: unbookmark" class="dnnSocialBookmarkActive" title="<%= Localization.GetString("RemoveBookmark", SharedResource) %>"></a></li>
                <!-- /ko -->
                <!-- ko ifnot: bookmarked -->
                <li><a href="javascript:void(0)" data-bind="click: bookmark" class="dnnSocialBookmark" title="<%= Localization.GetString("AddBookmark", SharedResource) %>"></a></li>
                <!-- /ko -->
                <!-- ko if: subscribed -->
                <li><a href="javascript:void(0)" data-bind="click: unsubscribe" class="dnnSocialSubscribeActive" title="<%= Localization.GetString("Unsubscribe", SharedResource) %>"></a></li>
                <!-- /ko -->
                <!-- ko ifnot: subscribed -->
                <li><a href="javascript:void(0)" data-bind="click: subscribe" class="dnnSocialSubscribe" title="<%= Localization.GetString("Subscribe", SharedResource) %>"></a></li>
                <!-- /ko -->
                <div class="dnnClear"></div>
            </ul>
            <div class="dnnClear dnnRight">
                <span data-bind="text: commentCount"></span>
                 <!-- ko if: commentCount() === 1 -->
                <span><%= Localization.GetString("Comment", SharedResource) %></span>
                <!-- /ko -->
                <!-- ko if: commentCount() !== 1 -->
                <span><%= Localization.GetString("Comments", SharedResource) %></span>
                <!-- /ko -->
            </div>
            <% } %>
        </div>
        <div class="dnnClear">
            <h3>
                <%= Entry.Title %>
            </h3>
        </div>
        <div class="dnnClear">
            <div class="avatar40">
                <span>
                    <em>
                        <img src="<%= ResolveUrl(Evoq.Common.Utilities.GetProfileAvatar(Entry.Author)) %>" alt="<%= Entry.AuthorDisplayName %>" />
                    </em>
                </span>
            </div>
            <div class="comment-info">
                <span class="idea-comments-author"><a href="<%= Entry.AuthorUrl %>"><%= Entry.AuthorDisplayName %></a></span>
                <span class="idea-comments-date"><%= Utility.DateFromUtc(Entry.PublishOnDate, UserInfo.Profile.PreferredTimeZone).ToShortDateString() %></span>
            </div>
        </div>
        <div class="dnnMobile-contentBody dnnClear"><%= Entry.EntryImage %></div>
        <div class="dnnMobile-contentBody dnnClear" id="detailview-content-mobile"></div>
        
        <% if (Entry.Approved){ %>
        <ul class="dnnMobile-ideaActions loading-container loading">
            <li>
                <a data-bind="click: reply" class="idea-reply"></a>
            </li>
            <!-- ko with: model -->
            <li>
                <!-- ko if: liked -->
                <a data-bind="click: toggleLike" class="idea-like-liked"></a>
                <!-- /ko -->

                <!-- ko ifnot: liked -->
                <a data-bind="click: toggleLike" class="idea-like"></a>
                <!-- /ko -->
            </li>
            <!-- /ko -->
        </ul>
        <div class="dnnMobileLike likes" data-bind="html: model.likeString().Small, attr: { id: model.getLikeControlMobileId() }"></div>
         <% } %>
        <!-- ko if: showCommentsTitle -->
        <div class="dnnMobile-subHeader">
            <h3>
                <%= LocalizeString("Comments") %>
            </h3>
        </div>
        <!-- /ko -->
        <div class="comments-container-mobileview"></div>
    </div>
    <!-- /ko -->
    <%-- END MOBILE VIEW --%>
    <social:Report ID="CtlReport" runat="server"></social:Report>
    <social:LikeControl ID="CtlLike" runat="server" />
    <div class="comments-container-common">
        <social:Comments runat="server" ID="CtlComments" />
    </div>
    <div id="detailview-content-common" style="display: none">
        <%= Entry.Content %>
    </div>
    <% if(ShowUnderModerationPopup){ %>
    <div class="editor-dialog moderation-dialog" style="display: none;">
        <div id="questionUnderModeration" class="dnnClear dnnFormMessage dnnFormSuccess">
			    <%= Localization.GetString("WaitForModeration", LocalResourceFile) %>
	    </div>
         <div>
            <a data-bind="click: hideModerationPopup" class="dnnSecondaryAction"><%= Localization.GetString("Close", LocalResourceFile) %></a>
        </div>
    </div>
    <% } %>
</asp:Panel>

<input type="hidden" name="evoq_social_tab_id" value="<%= ModuleContext.TabId %>"/>
<input type="hidden" name="evoq_social_module_id" value="<%= ModuleContext.ModuleId %>"/>
<input type="hidden" name="evoq_social_contentitem_id" value="<%= Entry.ContentItemId %>"/>
<script type='text/javascript'>
    dnn.social.loading('<%= ScopeWrapper.ClientID %>', function() {
        var html = document.getElementById('detailview-content-common').innerHTML;
        document.getElementById('detailview-content-normal').innerHTML = html;
    });
    function viewEntryInit(settings) {
        settings.moduleScope = $(settings.moduleScope)[0];
        if (!settings.moduleScope) {
            return;
        }

        var model = <%= SerializedEntryInfo() %>;
        try {
            window.dnn.social.applyBindings(new window.dnn.blogs.EntryView(settings, model), settings.moduleScope);
        } catch(ex) {
            window.dnn.social.topLevelExceptionHandler(settings, ex);
        }
    }
</script>
