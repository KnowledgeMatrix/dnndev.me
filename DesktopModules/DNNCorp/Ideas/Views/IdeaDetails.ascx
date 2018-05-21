<%@ Control Language="C#" AutoEventWireup="false" CodeBehind="IdeaDetails.ascx.cs" Inherits="DotNetNuke.Professional.Ideas.Views.IdeaDetails" %>
<%@ Import Namespace="DotNetNuke.Professional.Ideas.Components.Common" %>
<%@ Import Namespace="DotNetNuke.Services.Localization" %>
<%@ Import Namespace="DotNetNuke.SocialLibrary.Components.Common" %>

<%@ Register TagPrefix="social" TagName="Comments" Src="~/DesktopModules/DNNCorp/SocialLibrary/Controls/CommentsControl.ascx" %>
<%@ Register TagPrefix="social" TagName="Report" Src="~/DesktopModules/DNNCorp/SocialLibrary/Controls/ReportContent.ascx" %>
<%@ Register TagPrefix="ideas" TagName="EditorControl" Src="~/DesktopModules/DNNCorp/Ideas/Controls/EditorControl.ascx" %>
<%@ Register TagPrefix="ideas" TagName="CompanyResponse" Src="~/DesktopModules/DNNCorp/Ideas/Controls/CompanyResponse.ascx" %>
<%@ Register TagPrefix="social" TagName="LikeControl" Src="~/DesktopModules/DNNCorp/SocialLibrary/Controls/LikeControl.ascx" %>
<%@ Register TagPrefix="social" TagName="ContentExchange" Src="~/DesktopModules/DNNCorp/SocialLibrary/Controls/ContentExchange.ascx" %>


<asp:Panel runat="server" ID="ScopeWrapper" CssClass="dnnClear moduleContainer">
    <%-- NORMAL VIEW --%>
    <!-- ko ifnot: isMobileView -->
    <div class="moduleContainer-normalView ko-container">
        <div class="moduleTitleContainer detail-container dnnClear">
            <% if (VotingEnabled)
               { %>
            
             <div class="idea-votes-indicator activeIndicator dnnLeft static-row">
                <span class="idea-numberOfVotes"><%= Idea.Votes %></span>
                <span class="idea-votes-span">
                    <%= LocalizeString("Votes") %>
                </span>
            </div>
            
            <% } %>
            <!-- ko if: $root.voteDisplay -->
            <div class="idea-votes-indicator activeIndicator dnnLeft ko-container">
                <span class="idea-numberOfVotes" data-bind="text: model.votes"></span>
                <span class="idea-votes-span">
                    <%= LocalizeString("Votes") %>
                </span>
            </div>
            <!-- /ko -->

            <div class="title-container dnnLeft">
                <h3>
                    <span class="idea-title-status">(<%= LocalizeString(((IdeaStatus) Idea.Status).ToString()) %>)</span>
                    <%= Idea.ContentTitle %>
                </h3>
                <p class="title-returnPrev"><asp:HyperLink runat="server" ID="hlReturn" resourcekey="hlReturn" /></p>
            </div>

            <div class="dnnRight">
                <% if (Idea.Authorized)
                   { %>
                <ul class="detail-social-actions static-row">
                    <li><a href="javascript:void(0)" class="dnnSocialLike" title="<%= LocalizeString("LikeThis") %>"></a></li>
                    <li><a href="javascript:void(0)" class="dnnSocialBookmark" title="<%= LocalizeString("AddBookmark") %>"></a></li>
                    <li><a href="javascript:void(0)" class="dnnSocialSubscribe" title="<%= LocalizeString("Subscribe") %>"></a></li>
                </ul>
                <ul class="detail-social-actions ko-container" data-bind="with: model">
                    <!-- ko if: liked -->
                    <li><a href="javascript:void(0)" data-bind="click: unlike" class="dnnSocialLikeActive" title="<%= LocalizeString("UnlikeThis") %>"></a></li>
                    <!-- /ko -->
                    <!-- ko ifnot: liked -->
                    <li><a href="javascript:void(0)" data-bind="click: like" class="dnnSocialLike" title="<%= LocalizeString("LikeThis") %>"></a>
                    </li>
                    <!-- /ko -->
                    <!-- ko if: bookmarked -->
                    <li><a href="javascript:void(0)" data-bind="click: unbookmark" class="dnnSocialBookmarkActive" title="<%= LocalizeString("RemoveBookmark") %>"></a></li>
                    <!-- /ko -->
                    <!-- ko ifnot: bookmarked -->
                    <li><a href="javascript:void(0)" data-bind="click: bookmark" class="dnnSocialBookmark" title="<%= LocalizeString("AddBookmark") %>"></a></li>
                    <!-- /ko -->
                    <!-- ko if: subscribed -->
                    <li><a href="javascript:void(0)" data-bind="click: unsubscribe" class="dnnSocialSubscribeActive" title="<%= LocalizeString("Unsubscribe") %>"></a></li>
                    <!-- /ko -->
                    <!-- ko ifnot: subscribed -->
                    <li><a href="javascript:void(0)" data-bind="click: subscribe" class="dnnSocialSubscribe" title="<%= LocalizeString("Subscribe") %>"></a></li>
                    <!-- /ko -->
                </ul>
                <% } %>
            </div>
        </div>
        <div class="moduleThreadContainer moduleTopInsetShadowBox dnnClear">
            <div class="info-panel">
                <% if (VotingEnabled)
                   { %>
                <div class="dnnLeft idea-detail-vote-button-container static-row">
                    <% if (VotingEnabled && !Idea.IsClosed && !Idea.Protected)
                       { %>
                        <a class="idea-vote-button dnnPrimaryAction">
                            <%= string.Format("{0} Votes", Idea.UserVotes) %>
                        </a>
                    <% } %>
                </div>
                <% } %>

                <!-- ko if: $root.voteDisplay -->
                <div class="dnnLeft idea-detail-vote-button-container ko-container">
                    <!-- ko if: $root.votingEnabled -->
                    <a data-bind="click: vote, text: userVotesLabel, attr: { 'class': model.voteStyleForDetailView }"></a>
                    <!-- /ko -->
                    <!-- ko ifnot: $root.votingEnabled -->
                    <a data-bind="text: lockedLabel, attr: { 'class': model.lockedStyle }" href="javascript:void(0)" onclick="return false;"></a>
                    <!-- /ko -->
                    <!-- ko if: $root.votingEnabled -->
                    <div class="idea-vote-options loading-container loading dnnClear">
                        <div data-bind="with: voteButtons" style="display: inline-block;">
                            <div class="ie-shadow dnnLeft">
                                <!-- ko foreach: buttons() -->
                                <!-- ko if: disabled -->
                                <a href="javascript:void(0)" data-bind="attr: { 'class': 'button ' + type, 'title' : title }">
                                    <span data-bind="text: text"></span>
                                </a>
                                <!-- /ko -->
                                <!-- ko ifnot: disabled -->
                                <a href="javascript:void(0)" data-bind="click: exec, attr: { 'class': 'button ' + type, 'title' : title }">
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
                </div>
                <!-- /ko -->

                <ul class="dnnLeft">
                    <li>
                        <span><%= Idea.CreatedOnDate.ToShortDateString() %></span>
                    </li>
                    <li>
                        <span><%= Idea.ViewCount %></span>                        
                        <span><%= Localization.GetString(Idea.ViewCount == 1 ? "View" : "Views", LocalResourceFile) %></span>
                    </li>
                </ul>

                <ul class="dnnRight">
                    <li>                        
                        <span data-bind="html: commentCount"></span>
                        <span><%= Localization.GetString(Idea.CommentCount == 1 ? "Comment" : "Comments", LocalResourceFile) %></span>                        
                    </li>
                    <li>
                        <%= LocalizeString("LastActive") %> <span><%= Idea.RelativeActiveDate %></span>
                    </li>
                </ul>

                <div class="dnnClear">
                       <% if (Idea.Tags.Any())
                       { %>
                    <span class="list-row-label"><%= LocalizeString("Tags") %>:</span>
                    <ul class="list-row-tags">
                        <% foreach (var tag in Idea.Tags)
                           { %>
                        <li>
                            <a href="<%= tag.TagUrl %>">
                                <%: tag.Name %>
                        </a>
                        </li>
                        <% } %>
                    </ul>
                    <% } %>
                </div>
            </div>
            <div class="detail-main-container dnnClear">
                <h3>
                    <%= LocalizeString("Idea") %>
                </h3>
                <div>
                    <div class="detail-avatar-container">
                        <div class="avatar40">
                            <span>
                                <em>
                                    <img src="<%= ResolveUrl(Evoq.Common.Utilities.GetProfileAvatar(Idea.CreatedByUser)) %>" alt="<%= Idea.CreatedByDisplayName %>" title="<%= Idea.CreatedByDisplayName %>" />
                                </em>
                            </span>
                        </div>
                    </div>
                    <div class="idea-content highlight-content">
                          <% if (IsIdeaEditable || CanModerate)
                            { %>
                           <div class="comment-actions-menu" id="detail-content-moderator-menu">
                                <a href="javascript:void(0)" class="comment-actions"></a>
                                <ul class="comment-actions-dropdown">
                                    <% if (CanModerate) { %>
                                        <li><a data-bind="click: viewSupporters"><%= LocalizeString("Supporters") %></a></li>
                                        <li><a data-bind="click: moveContent"><%= LocalizeString("MoveIdea") %></a></li>
                                        <li><a data-bind="click: copyContent"><%= LocalizeString("CopyIdea") %></a></li>
                                        <li><a data-bind="click: moveContentToComment"><%= LocalizeString("MoveIdeaToComment") %></a></li>
                                    <% } %>

                                    <li><a data-bind="click: edit"><%= LocalizeString("Edit") %></a></li>

                                    <% if (CanModerate && !SlComments.ReadOnly) { %>
                                        <li><a data-bind="click: addResponse"><%= LocalizeString("AddResponse") %></a></li>
                                        <li><a id="btnDelete" href="javascript:void(0)"><%= LocalizeString("Remove") %></a></li>
                                    <% } %>
                               
                                </ul>
                            </div>
                        <% } %>
                        <span class="detail-comments-author">
                            <a href="<%= Idea.AuthorUrl %>" class="dnnSocialLink"><%= Idea.CreatedByDisplayName %></a>
                        </span>
                        <span class="detail-comments-date">
                            <%= DotNetNuke.SocialLibrary.Components.Common.Utilities.RelativeDate(Idea.CreatedOnDate) %>
                        </span>
                        <div class="answer-comments-content" id="detailview-content-normal"></div>

                        <% if (Idea.Authorized)
                           { %>
                        <ul class="detail-bottom-social-actions static-row">
                              <% if (!SlComments.ReadOnly)
                               { %>
                            <li>
                                <a data-bind="click: reply" class="idea-reply dnnSocialLink">
                                    <span><%= LocalizeString("Reply") %></span>
                                </a>
                            </li>
                            <% } %>
                             <li>
                                <a class="idea-like dnnSocialLink">
                                    <span><%= LocalizeString("Like") %></span>
                                </a>
                            </li>
                            <% if (!SlComments.ReadOnly)
                               { %>
                            <li>
                                <a class="idea-report dnnSocialLink">
                                    <span><%= LocalizeString("Report") %></span>
                                </a>
                            </li>
                            <% } %>
                        </ul>
                        <ul class="detail-bottom-social-actions ko-container">
                            <% if (!SlComments.ReadOnly)
                               { %>
                            <li>
                                <a data-bind="click: reply" class="idea-reply dnnSocialLink">
                                    <span><%= LocalizeString("Reply") %></span>
                                </a>
                            </li>
                            <% } %>
                            <!-- ko with: model -->
                            <li>
                                <!-- ko if: liked -->
                                <a data-bind="click: toggleLike" class="idea-like-liked dnnSocialLink">
                                    <span><%= LocalizeString("Unlike") %> </span>
                                </a>
                                <!-- /ko -->

                                <!-- ko ifnot: liked -->
                                <a data-bind="click: toggleLike" class="idea-like dnnSocialLink">
                                    <span><%= LocalizeString("Like") %></span>
                                </a>
                                <!-- /ko -->
                            </li>
                            <!-- /ko -->
                            <% if (!SlComments.ReadOnly)
                                { %>
                            <li>
                                <a data-bind="click: report" class="idea-report dnnSocialLink">
                                    <span><%= LocalizeString("Report") %></span>
                                </a>
                            </li>
                            <% } %>
                        </ul>
                        <div class="dnnClear likes" data-bind="html: model.likeString().Big, attr: { id: model.getLikeControlId() } "></div>
                        <% } %>

                        <div class="dnnClear"></div>
                    </div>
                    <div class="dnnClear"></div>
                </div>
            </div>
            <% if (OfficialResponse != null)
               { %>
            <div class="detail-main-container idea-response">
                <h3>
                    <%= LocalizeString("OfficialResponse") %>
                </h3>
                <div>
                    <div class="detail-avatar-container">
                        <div class="avatar40">
                            <span>
                                <em>
                                    <img src="<%= ResolveUrl(Evoq.Common.Utilities.GetProfileAvatar(OfficialResponse.CreatedByUserId, PortalId)) %>" alt="<%= OfficialResponse.ResponseBy %>" />
                                </em>
                            </span>
                        </div>
                    </div>
                    <div class="idea-content">
                           <% if (CanModerate)
                           { %>
                            <div class="detail-content-edit">
                                <a data-bind="click: getResponseHistory">
                                    <%= LocalizeString("ResponseHistory") %>
                                </a>
                            </div>
                        <% } %>
                        <span class="detail-comments-author">
                            <a href='<%= OfficialResponse.ResponderProfile %>' class="dnnSocialLink">
                                <%= OfficialResponse.ResponseBy %>
                            </a>
                        </span>
                        <span class="detail-comments-date"><%= OfficialResponse.ResponseDate %></span>
                        <p>
                            <%= OfficialResponse.EncodedResponse %>
                        </p>
                        <div class="dnnClear"></div>
                    </div>
                    <div class="dnnClear"></div>
                </div>

            </div>
            <% } %>

            <div class="dnnClear"></div>

            <a id="comments"></a>

            <div class="idea-comment-container moduleBotInsetShadowBox">
                <!-- ko if: showCommentsTitle -->
                <h3>
                    <%= LocalizeString("Comments") %>
                </h3>
                <!-- /ko -->
                <div class="comments-container-normalview"></div>
            </div>
        </div>
    </div>
    <!-- /ko -->
    <%-- END NORMAL VIEW --%>

    <%-- MOBILE VIEW --%>
    <!-- ko if: isMobileView -->
    <div class="dnnMobile-moduleThreadContainer dnnClear moduleContainer-mobileView ko-container">

        <div class="dnnLeft">
            <asp:HyperLink runat="server" ID="hlReturnMobileView" CssClass="dnnMobile-detailViewReturn" />
            <!-- ko if: $root.voteDisplay -->
            <!-- ko if: $root.votingEnabled -->
            <a class="dnnMobile-voteButton dnnPrimaryAction" data-bind="click:voteMobileView">
                <span>Vote</span>
            </a>
            <!-- /ko -->
            <!-- ko ifnot: $root.votingEnabled -->
            <a class="dnnMobile-voteButton dnnSecondaryAction" href="javascript:void(0)" onclick="return false;">
               <span>Locked</span> 
            </a>
            <!-- /ko -->
            <div class="dnnMobile-idea-vote-options">
                <div data-bind="with: voteButtons">
                    <!-- ko if: showRemoveButton() -->
                    <a data-bind="click: removeVotes" class="button">
                        <span>0</span>
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
            <!-- /ko -->
        </div>

        <div class="dnnRight">
            <% if (Idea.Authorized)
               { %>
            <ul class="loading-container loading dnnMobile-socialActions" data-bind="with: model">
                <!-- ko if: liked -->
                <li><a href="javascript:void(0)" data-bind="click: unlike" class="dnnSocialLikeActive" title="<%= LocalizeString("UnlikeThis") %>"></a></li>
                <!-- /ko -->
                <!-- ko ifnot: liked -->
                <li><a href="javascript:void(0)" data-bind="click: like" class="dnnSocialLike" title="<%= LocalizeString("LikeThis") %>"></a>
                </li>
                <!-- /ko -->
                <!-- ko if: bookmarked -->
                <li><a href="javascript:void(0)" data-bind="click: unbookmark" class="dnnSocialBookmarkActive" title="<%= LocalizeString("RemoveBookmark") %>"></a></li>
                <!-- /ko -->
                <!-- ko ifnot: bookmarked -->
                <li><a href="javascript:void(0)" data-bind="click: bookmark" class="dnnSocialBookmark" title="<%= LocalizeString("AddBookmark") %>"></a></li>
                <!-- /ko -->
                <!-- ko if: subscribed -->
                <li><a href="javascript:void(0)" data-bind="click: unsubscribe" class="dnnSocialSubscribeActive" title="<%= LocalizeString("Unsubscribe") %>"></a></li>
                <!-- /ko -->
                <!-- ko ifnot: subscribed -->
                <li><a href="javascript:void(0)" data-bind="click: subscribe" class="dnnSocialSubscribe" title="<%= LocalizeString("Subscribe") %>"></a></li>
                <!-- /ko -->
                <div class="dnnClear"></div>
            </ul>
            <% } %>
            <div class="dnnClear">
                <span class="idea-numberOfVotes" data-bind="text: model.votes"></span>
                <span class="idea-votes-span">
                    <%= LocalizeString("Votes") %>
                </span>
                <span class="idea-title-status">-&nbsp;&nbsp;<%= LocalizeString(((IdeaStatus) Idea.Status).ToString()) %></span>
            </div>
        </div>

        <div class="dnnClear">
            <h3>
                <%= Idea.ContentTitle %>
            </h3>
        </div>

        <div class="dnnClear">
            <div class="avatar40">
                <span>
                    <em>
                        <img src="<%= ResolveUrl(Evoq.Common.Utilities.GetProfileAvatar(Idea.CreatedByUser)) %>" alt="<%= Idea.CreatedByDisplayName %>" title="<%= Idea.CreatedByDisplayName %>" />
                    </em>
                </span>
            </div>
            <div class="comment-info">
                <span class="idea-comments-author"><a href="<%= Idea.AuthorUrl %>"><%= Idea.CreatedByDisplayName %></a></span>
                <span class="idea-comments-date"><%= DotNetNuke.SocialLibrary.Components.Common.Utilities.RelativeDate(Idea.CreatedOnDate) %></span>
            </div>
        </div>

        <div class="dnnMobile-contentBody" id="detailview-content-mobile" ></div>

        <% if (Idea.Authorized)
           { %>
        <ul class="dnnMobile-ideaActions loading-container loading">
            <% if (!SlComments.ReadOnly)
               { %>
            <li>
                <a data-bind="click: reply" class="idea-reply"></a>
            </li>
            <% } %>
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
            <% if (!SlComments.ReadOnly)
                { %>
            <li>
                <a data-bind="click: report" class="idea-report"></a>
            </li>
            <% } %>
        </ul>
        <% } %>
        
        <div class="dnnMobileLike likes" data-bind="html: model.likeString().Small, attr: { id: model.getLikeControlMobileId() }"></div>

        <% if (OfficialResponse != null)
           { %>

        <div class="dnnMobile-subHeader">
            <h3>
                <%= LocalizeString("OfficialResponse") %>
            </h3>
        </div>
        <div class="dnnClear">
            <div class="avatar40">
                <span>
                    <em>
                        <img src="<%= ResolveUrl(Evoq.Common.Utilities.GetProfileAvatar(OfficialResponse.CreatedByUserId, PortalId)) %>" alt="<%= OfficialResponse.ResponseBy %>" />
                    </em>
                </span>
            </div>
            <div class="comment-info">
                <span class="idea-comments-author">
                    <a href='<%= OfficialResponse.ResponderProfile %>'><%= OfficialResponse.ResponseBy %></a>
                </span>
                <span class="idea-comments-date"><%= OfficialResponse.ResponseDate %></span>
            </div>
        </div>
        <div class="dnnMobile-contentBody dnnClear">
            <p>
                <%= OfficialResponse.EncodedResponse %>
            </p>
        </div>

        <% } %>

        <a id="commentsMobileView"></a>
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

    <div class="editor-dialog" style="display: none">
        <ideas:EditorControl ID="CtlEditor" runat="server" />
    </div>

    <div class="idea-response-add-dialog" style="display: none">
        <ideas:CompanyResponse ID="CtlCompanyResponse" runat="server" />
    </div>

    <div class="idea-response-history" style="display: none;">
        <div class="response-container" data-bind="foreach: $root.responseHistories">
            <div class="detail-avatar-container">
                <div class="avatar40">
                    <span>
                        <em>
                            <img data-bind="attr: { src: responderAvatarUrl, alt: responseBy }" alt=""/>
                        </em>
                    </span>
                </div>
            </div>
            <div class="idea-content">
                <h3>
                    <span data-bind="text: statusDisplay"></span>
                </h3>
                <span class="detail-comments-author">
                    <a data-bind="attr: { href: responderProfile }, text: responseBy" class="dnnSocialLink"></a>
                </span>
                <span data-bind="text: relativeDate" class="detail-comments-date"></span>
                <p data-bind="html: response"></p>
                <div class="dnnClear"></div>
            </div>
            <div class="dnnClear"></div>
            <hr />
        </div>
    </div>

    <social:Report ID="SlReport" runat="server" />
    <social:ContentExchange ID="SlContentExchange" runat="server" />
    
    
    <social:LikeControl ID="CtlLike" runat="server" />

    <div class="comments-container-common">
        <% if (Idea.Authorized)
        { %>
        <social:Comments runat="server" ID="SlComments" />
        <% } %>
    </div>
    
    <div id="detailview-content-common" style="display: none">
        <%= Utilities.FixDoublEntityEncoding(Idea.Content) %>
    </div>
    
    <% if (CanModerate)
       { %>
    <div style="display: none" data-bind="with: supportersControl">
        <div class="like-popup" id="idea-supporters-dialog">
            <div class="like-popup-list">
                <table>
                    <tbody>
                        <!-- ko foreach: results -->
                        <tr>
                            <td class="avatar-td">
                                <div class="avatar40">
                                    <span>
                                        <em>
                                            <img data-bind="attr: { src: avatarUrl, title: displayName }"  />
                                        </em>
                                    </span>                                    
                                 </div>
                            </td>
                            <td class="name-td">
                                <a class="dnnSocialLink" data-bind="attr: { href:  profileUrl }, text: displayName" ></a>&nbsp;<b>(<span data-bind="html: votes"></span>)</b>
                            </td>
                        </tr>
                        <!-- /ko -->
                    </tbody>
                </table>
                <a data-bind="visible: showMore, click: getMore" class="like-popup-loadmore">Load More</a>
            </div>
        </div>
    </div>
    <% } %>
</asp:Panel>

<% if (!Idea.Authorized || SlComments.ReadOnly)
   { %>
<div class="detail-main-container dnnClear">
    <div class="dnnFormMessage" style="margin: 0">
        <%= LocalizeString("CommentsDisabled") %>
    </div>
</div>
<% } %>

<input type="hidden" name="evoq_social_tab_id" value="<%= ModuleContext.TabId %>"/>
<input type="hidden" name="evoq_social_module_id" value="<%= ModuleContext.ModuleId %>"/>
<input type="hidden" name="evoq_social_contentitem_id" value="<%= Idea.ContentItemId %>"/>
<script type='text/javascript'>
    dnn.social.loading('<%= ScopeWrapper.ClientID %>', function() {
        var html = document.getElementById('detailview-content-common').innerHTML;
        document.getElementById('detailview-content-normal').innerHTML = html;
    });
    function detailsInit(settings) {    
        settings.moduleScope = $(settings.moduleScope)[0];
        if (!settings.moduleScope) {
            return;
        }

	    var model = <%= SerializedIdeaInfo() %>;
        try {
            window.dnn.social.applyBindings(new window.dnn.ideas.DetailView(settings, model), settings.moduleScope);
        } catch(ex) {
            window.dnn.social.topLevelExceptionHandler(settings, ex);
        }
    }
</script>
