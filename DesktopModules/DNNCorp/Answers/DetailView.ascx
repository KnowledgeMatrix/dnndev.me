<%@ Control Language="C#" AutoEventWireup="false" CodeBehind="DetailView.ascx.cs" Inherits="DotNetNuke.Professional.Answers.DetailView" %>
<%@ Register TagPrefix="answer" TagName="AskQuestion" Src="~/DesktopModules/DNNCorp/Answers/Controls/AskQuestion.ascx" %>
<%@ Register TagPrefix="social" TagName="Report" Src="~/DesktopModules/DNNCorp/SocialLibrary/Controls/ReportContent.ascx" %>
<%@ Register TagPrefix="social" TagName="CommentsControl" Src="~/DesktopModules/DNNCorp/SocialLibrary/Controls/CommentsControl.ascx" %>
<%@ Register TagPrefix="social" TagName="LikeControl" Src="~/DesktopModules/DNNCorp/SocialLibrary/Controls/LikeControl.ascx" %>
<%@ Import Namespace="DotNetNuke.Services.Localization" %>
<%@ Register TagPrefix="social" TagName="ContentExchange" Src="~/DesktopModules/DNNCorp/SocialLibrary/Controls/ContentExchange.ascx" %>

<asp:Panel runat="server" ID="ScopeWrapper" CssClass="moduleContainer dnnClear">
    <%-- NORMAL VIEW --%>
    <!-- ko ifnot: isMobileView -->
    <div class="moduleContainer-normalView ko-container">
        <div class="moduleTitleContainer detail-container dnnClear">
            <% if (Model.Question.AnswerId > 0)
               { %>
            <div class="status-indicator dnnLeft static-row">
                <img src="<%= ResolveUrl("~/DesktopModules/DNNCorp/Answers/images/checkmark.png") %>" title="<%= LocalizeString("Accepted") %>" alt="" />
            </div>
            <% } else { %>
            <div class="status-indicator dnnLeft static-row"></div>
            <% } %>
            <div class="status-indicator dnnLeft ko-container" data-bind="visible: answerAccepted">
                <img src="<%= ResolveUrl("~/DesktopModules/DNNCorp/Answers/images/checkmark.png") %>" title="<%= LocalizeString("Accepted") %>" alt="" />
            </div>
            <div class="title-container dnnLeft">
                <h3><%= Model.Question.ContentTitle %></h3>
                <p class="title-returnPrev"><asp:HyperLink runat="server" ID="hlReturn" resourcekey="hlReturn" /></p>
            </div>
            <div class="dnnRight">
                <% if (Model.Question.Approved)
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
                    <li><a href="javascript:void(0)" data-bind="click: like" class="dnnSocialLike" title="<%= LocalizeString("LikeThis") %>"></a></li>
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
                    <% if(ShowTicketButton) 
                       { %>
                        <!-- ko if: hasTicket -->
                        <li><span class="dnnSocialTicketCreated" title="<%= LocalizeString("TicketCreated") %>"></span></li>
                        <!-- /ko -->
                        <!-- ko ifnot: hasTicket -->
                        <li><a href="javascript:void(0)" data-bind="click: createTicket" class="dnnSocialTicketNotCreated" title="<%= LocalizeString("CreateNewTicket") %>"></a></li>
                        <!-- /ko -->
                    <% } %>
                </ul>
                <% } %>
            </div>
        </div>
        <div class="moduleThreadContainer moduleTopInsetShadowBox dnnClear">
            <div class="info-panel dnnClear">
                <ul class="dnnLeft">
                    <li>
                        <span><%= DateFromUtc(Model.Question.CreatedOnDate, ModuleContext.PortalSettings.UserInfo.Profile.PreferredTimeZone).ToShortDateString() %></span>
                    </li>
                    <li>
                        <span><%= Model.Question.ViewCount %></span>
                        <span><%= Localization.GetString(Model.Question.ViewCount ==  1? "View" : "Views", LocalResourceFile) %></span>
                    </li>
                </ul>
                <ul class="dnnRight">
                    <li>
                        <span><%= Model.Question.TotalAnswers %></span>
                        <span><%= Localization.GetString(Model.Question.TotalAnswers == 1? "Answer": "Answers", LocalResourceFile) %></span>
                    </li>
                    <li>
                        <span>
                            <%= Localization.GetString("LastActivity", LocalResourceFile) %>
                            <%= DotNetNuke.SocialLibrary.Components.Common.Utilities.RelativeDate(Model.Question.LastModifiedOnDate) %>, 
                        </span>
                        <a class="dnnSocialLink" href="<%= Model.Question.LastActiveAuthorUrl %>">
                            <%= Model.Question.LastActiveDisplayName%>
                        </a>
                    </li>
                </ul>
                <div class="dnnClear">
                    <% if (Model.Question.Tags.Any())
                       { %>
                    <span class="list-row-label"><%= LocalizeString("Tags") %>:</span>
                    <ul class="list-row-tags">
                        <% foreach (var tag in Model.Question.Tags)
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
                    <%= LocalizeString("Question") %>: 
                </h3>
                <div>
                    <div class="detail-avatar-container">
                        <div class="avatar40">
                            <span>
                                <em>
                                    <img src="<%= AuthorProfilePictureUrl %>" title="<%= Model.Question.AuthorDisplayName %>" alt="<%= Model.Question.AuthorDisplayName %>" />
                                </em>
                            </span>
                        </div>
                        <% if (Model.Question.Approved)
                           { %>
                        <div class="answer-vote static-row">
                            <a class="answer-vote-upbtn"></a>
                            <span class="answer-vote-numberOfVote"><%= Model.Question.Score %></span>
                            <a class="answer-vote-downbtn"></a>
                        </div>
                        <% } %>
                        <div class="answer-vote ko-container">
                            <!-- ko if: model.approved -->
                            <a data-bind="click: model.upvote, attr: { 'class': model.upVoteCss }">
                                <div class="tag-menu"><p data-bind="text: model.upVoteText"></p></div>
                            </a>
                            <span data-bind="text: model.score, click: function(){ $root.viewSupporters(model.postId()); return false; }" class="answer-vote-numberOfVote"></span>
                            <a data-bind="click: model.downvote, attr: { 'class': model.downVoteCss }">
                                <div class="tag-menu"><p data-bind="text: model.downVoteText"></p></div>
                            </a>
                            <!-- /ko -->
                        </div>
                    </div>
                    <div class="answer-content highlight-content">
                        <% if (ShowEditControls)
                           { %>
                        <div class="comment-actions-menu" id="detail-content-moderator-menu">
                            <a href="javascript:void(0)" class="comment-actions"></a>
                            <ul class="comment-actions-dropdown">
                                 <% if(CanModerate) 
                                    { %>
                                <li><a data-bind="click: moveContent"><%= LocalizeString("MoveQuestion") %></a></li>
                                <li><a data-bind="click: copyContent"><%= LocalizeString("CopyQuestion") %></a></li>
                                <li><a data-bind="click: moveContentToComment"><%= LocalizeString("MoveQuestionToComment") %></a></li>
                                 <%  } %>
                                <li><a data-bind="click: edit"><%= LocalizeString("Edit") %></a></li>
                                <% if (!Model.Question.Closed)
                                   { %>
                                <li><a data-bind="click: deletePost"><%= LocalizeString("Remove") %></a></li>
                                <% } %>
                            </ul>
                        </div>
                        <% } %>
                        <span class="detail-comments-author">
                            <a href="<%= Model.Question.AuthorUrl %>" class="dnnSocialLink">
                                <%= Model.Question.AuthorDisplayName %>
                        </a>
                        </span>
                        <span class="detail-comments-date">
                            <%= Model.Question.PostCreatedRelativeDate %>
                        </span>
                        <div class="answer-comments-content" id="detailview-content-normal">
                        </div>
                        <% if (Model.Question.Approved)
                           { %>
                        <ul class="detail-bottom-social-actions static-row">
                            <li>
                                <a class="idea-like dnnSocialLink">
                                    <span><%= LocalizeString("Like") %></span>
                                </a>
                            </li>
                            <% if (!Model.Question.Closed)
                               { %>
                            <li>
                                <a class="idea-report dnnSocialLink">
                                    <span><%= LocalizeString("Report") %></span>
                                </a>
                            </li>
                            <li>
                                <a class="idea-comment dnnSocialLink">
                                    <span><%= LocalizeString("Comment") %></span>
                                </a>
                            </li>
                            <% } %>
                        </ul>
                        <ul class="detail-bottom-social-actions ko-container">
                            <!-- ko with: model -->
                            <li>
                                <!-- ko if: liked -->
                                <a data-bind="click: toggleLike" class="idea-like-liked dnnSocialLink">
                                    <span><%= LocalizeString("Unlike") %></span>

                                </a>
                                <!-- /ko -->
                                <!-- ko ifnot: liked -->
                                <a data-bind="click: toggleLike" class="idea-like dnnSocialLink">
                                    <span><%= LocalizeString("Like") %></span>
                                </a>
                                <!-- /ko -->
                            </li>
                            <!-- /ko -->
                            <!-- ko ifnot: model.closed -->
                            <li>
                                <a data-bind="click: report" class="idea-report dnnSocialLink">
                                    <span><%= LocalizeString("Report") %></span>
                                </a>
                            </li>
                         
                            <li>
                                <a data-bind="click: model.replyComment" class="idea-comment dnnSocialLink">
                                    <span><%= LocalizeString("Comment") %></span>
                                </a>
                            </li>
                            <!-- /ko -->
                        </ul>
                        <div class="dnnClear likes" data-bind="html: model.likeString().Big, attr: { id: model.getLikeControlId() } "></div>
                        <!-- ko ifnot: model.closed -->
                        <div class="answer-comments-panel" data-bind="visible: !answerAuthoring()">
                            <div class="avatar40 dnnLeft">
                                <span>
                                    <em>
                                        <asp:Image ID="imgCurrUsr2" runat="server" />
                                    </em>
                                </span>
                            </div>
                            <a class="dnnPrimaryAction answer-comment-button-top" data-bind="click: reply">
                                <%= LocalizeString("AddAnswer") %>
                            </a>
                            <div class="dnnClear"></div>
                        </div>
                        <!-- /ko -->
                        <% } %>
                    </div>
                    <div class="answer-question-comment-container dnnClear">
                        <div data-bind="template: { name: 'comment-template' }"></div>
                    </div>
                </div>
            </div>
            <div class="ko-container">
                <!-- ko with: $root.social.getComponentFactory().resolve('DetailController') -->
                <!-- ko if: results().length > 0 -->
                <div class="detail-main-container answer-topanswer dnnClear">
                    <h3><%= Localization.GetString("TopAnswer", LocalResourceFile) %></h3>
                </div>
                <!-- ko foreach: results -->
                <div data-bind="attr: { 'class': answerContainerCss, id: 'answer-id-' + postId() }" class="loading-container loading">
                    <div>
                        <% if (!Model.Question.Closed)
                           { %>
                        <!-- ko if: showModerationMenu -->
                        <div class="comment-actions-menu answer-moderator-menu">
                            <a href="javascript:void(0)" class="comment-actions"></a>
                            <ul class="comment-actions-dropdown">
                                <!-- ko if: editable -->
                                 <% if (CanModerate)
                                    { %>
                                <li><a data-bind="click: moveAnswer"><%= LocalizeString("MoveAnswer") %></a></li>
                                <li><a data-bind="click: copyAnswer"><%= LocalizeString("CopyAnswer") %></a></li>
                                <li><a data-bind="click: moveAnswerToComment"><%= LocalizeString("MoveAnswerToComment") %></a></li>
                                <%  } %>
                                <li><a data-bind="click: edit"><%= LocalizeString("Edit") %></a></li>
                                <% if (!Model.Question.Closed)
                                   { %>
                                <li><a data-bind="click: deletePost"><%= LocalizeString("Remove") %></a></li>
                                <% } %>
                                <!-- /ko -->
                                <!-- ko if: acceptButtonVisible -->
                                <li><a data-bind="click: toggleAcceptedAnswer">
                                        <!-- ko ifnot: isAcceptedAnswer --><%= LocalizeString("Accept") %><!-- /ko -->
                                        <!-- ko if: isAcceptedAnswer --><%= LocalizeString("Unaccept") %><!-- /ko -->
                                    </a>
                                </li>
                                <!-- /ko -->
                            </ul>
                        </div>
                        <!-- /ko -->
                        <% } %>
                        <div class="detail-avatar-container">
                            <div class="avatar40">
                                <span>
                                    <em>
                                        <img data-bind="attr: { src: authorProfilePictureUrl, alt: authorDisplayName, title:authorDisplayName }" />
                                    </em>
                                </span>
                            </div>
                            <div class="answer-vote">
                                <!-- ko if: approved -->
                                <a data-bind="click: upvote, attr: { 'class': upVoteCss }">
                                    <div class="tag-menu"><p data-bind="text: upVoteText"></p></div>
                                </a>
                                <!-- ko if: answerId() == postId() -->
                                <span data-bind="text: score,  click: function(){ $root.viewSupporters(postId(), true); return false; }" class="answer-vote-numberOfVote activeIndicator"></span>
                                <!-- /ko -->
                                <!-- ko ifnot: answerId() == postId() -->
                                <span data-bind="text: score,  click: function(){ $root.viewSupporters(postId(), true); return false; }" class="answer-vote-numberOfVote"></span>
                                <!-- /ko -->
                                <a data-bind="click: downvote, attr: { 'class': downVoteCss }">
                                    <div class="tag-menu"><p data-bind="text: downVoteText"></p></div>
                                </a>
                                <!-- /ko -->
                            </div>
                        </div>
                        <div class="answer-content">
                            <span class="detail-comments-author">
                                <a data-bind="attr: { href: authorUrl }" class="dnnSocialLink">
                                    <span data-bind="text: authorDisplayName"></span>
                                </a>
                            </span>
                            <span class="detail-comments-date">
                                <span data-bind="text: postCreatedRelativeDate"></span>
                            </span>
                            <div class="answer-comments-content" data-bind="html:body">
                            </div>
                            <!-- ko if: approved -->
                            <ul class="detail-bottom-social-actions">
                                <li>
                                    <!-- ko if: liked -->
                                    <a data-bind="click: toggleLike" class="idea-like-liked dnnSocialLink">
                                        <span><%= LocalizeString("Unlike") %></span>
                                    </a>
                                    <!-- /ko -->
                                    <!-- ko ifnot: liked -->
                                    <a data-bind="click: toggleLike" class="idea-like dnnSocialLink">
                                        <span><%= LocalizeString("Like") %></span>
                                    </a>
                                    <!-- /ko -->
                                </li>
                                <% if (!Model.Question.Closed){ %>
                                <li>
                                    <a href="javascript:void(0)" data-bind="click: reportAnswer" class="idea-report dnnSocialLink">
                                        <span><%= LocalizeString("Report") %></span>
                                    </a>
                                </li>
                                <li>
                                    <a href="javascript:void(0)" data-bind="click: replyComment" class="idea-comment dnnSocialLink">
                                        <span><%= LocalizeString("Comment") %></span>
                                    </a>
                                </li>
                                <% } %>
                            </ul>
                            <div class="dnnClear likes" data-bind="html: likeString().Big, attr: { id: getLikeControlId() } "></div>
                            <!-- /ko -->
                            <div class="dnnClear"></div>
                        </div>
                    </div>
                    <div data-bind="template: { name: 'comment-template' }"></div>
                </div>
                <!-- /ko -->
                <!-- /ko -->
                <!-- /ko -->
            </div>
            <% if (Model.Question.Approved && !Model.Question.Protected && !Model.Question.Closed)
               { %>
            <div class="answer-comments-panel moduleTopInsetShadowBox dnnClear">
                <div class="avatar40 dnnLeft">
                    <span>
                        <em>
                            <asp:Image ID="imgCurrUsr" runat="server" />
                        </em>
                    </span>
                </div>
                <a class="dnnPrimaryAction answer-comment-button" data-bind="click: reply, visible: !answerAuthoring()">
                    <%= LocalizeString("AddAnswer") %>
                    </a>
                <div class="answer-detail-pager-bottom" data-bind="visible:!answerAuthoring()">
                    <div class="dnnLeft">
                        <ul class="pager-ul" data-bind="html: pagingControl"></ul>
                    </div>
                    <div class="dnnRight">
                        <div class="dnnPagingCount dnnLeft">
                            <span data-bind="html: totalResults"></span>
                        </div>
                        <!-- ko if: $root.pager().totalPages() > 1 -->
                        <div class="dnnPagingButtons dnnRight">
                            <a data-bind="click: prev, attr: { 'class': 'pager-prev ' + prevClass() }"></a>
                            <a data-bind="click: next, attr: { 'class': 'pager-next ' + nextClass() }"></a>
                        </div>
                        <!-- /ko -->
                    </div>
                </div>

                <div class="answer-add-panel answer-comments-panel" style="display: none;">
                    <div class="dnnFormItem">
                        <textarea class="redactor-answer-area"></textarea>
                    </div>
                    <ul class="dnnActions dnnClear answer-post-actions">
                        <li>
                            <a class="dnnPrimaryAction" data-bind="click: submitReply"><%= LocalizeString("cmdSave") %></a>
                        </li>
                        <li>
                            <a class="dnnSecondaryAction" data-bind="click: cancelReply">
                                <%= LocalizeString("cmdCancel") %>
                                </a>
                        </li>
                    </ul>
                </div>
            </div>
            <% }
               else
               { %>
            <div class="detail-main-container dnnClear">
                <div class="dnnFormMessage">
                    <span><%= LocalizeString("CommentsDisabled") %></span>
                </div>
            </div>
            <% } %>
        </div>
    </div>
    <!-- /ko -->
    <%-- END NORMAL VIEW --%>

    <%-- MOBILE VIEW --%>
    <!-- ko if: isMobileView -->
    <div class="dnnMobile-moduleThreadContainer dnnClear moduleContainer-mobileView ko-container">

        <div class="dnnLeft">
            <asp:HyperLink runat="server" ID="hlReturnMobileView" CssClass="dnnMobile-detailViewReturn" />
            <!-- ko if: model.answerId() > 0 -->
            <a class="dnnMobile-voteButton activeIndicator"></a>
            <!-- /ko -->
        </div>

        <div class="dnnRight">
            <% if (Model.Question.Approved)
               { %>
            <ul class="loading-container loading dnnMobile-socialActions" data-bind="with: model">
                <!-- ko if: liked -->
                <li><a href="javascript:void(0)" data-bind="click: unlike" class="dnnSocialLikeActive" title="<%= LocalizeString("UnlikeThis") %>"></a></li>
                <!-- /ko -->
                <!-- ko ifnot: liked -->
                <li><a href="javascript:void(0)" data-bind="click: like" class="dnnSocialLike" title="<%= LocalizeString("LikeThis") %>"></a></li>
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
                <% if(ShowTicketButton) 
                    { %>
                    <!-- ko if: hasTicket -->
                    <li><span class="dnnSocialTicketCreated" title="<%= LocalizeString("TicketCreated") %>"></span></li>
                    <!-- /ko -->
                    <!-- ko ifnot: hasTicket -->
                    <li><a href="javascript:void(0)" data-bind="click: createTicket" class="dnnSocialTicketNotCreated" title="<%= LocalizeString("CreateNewTicket") %>"></a></li>
                    <!-- /ko -->
                <% } %>
            </ul>
            <% } %>
            <div class="dnnClear dnnRight">
                <span class="idea-title-status" data-bind="text: model.totalAnswers"></span>
                <span class="idea-title-status" data-bind="text: model.totalAnswers() === 1 ? '<%= LocalizeString("Answer") %>    ' : '<%= LocalizeString("Answers") %>    '"></span>
            </div>
        </div>

        <div class="dnnClear">
            <h3>
                <%= Model.Question.ContentTitle %>
            </h3>
        </div>

        <div class="dnnClear">
            <div class="avatar40">
                <span>
                    <em>
                        <img src="<%= AuthorProfilePictureUrl %>" alt="<%= Model.Question.AuthorDisplayName %>" title="<%= Model.Question.AuthorDisplayName %>" />
                    </em>
                </span>
            </div>
            <div class="comment-info">
                <span class="idea-comments-author"><a href="<%= Model.Question.AuthorUrl %>"><%= Model.Question.AuthorDisplayName %></a></span>
                <span class="idea-comments-date"><%= Model.Question.PostCreatedRelativeDate %></span>
            </div>
        </div>

        <div class="dnnMobile-contentBody mobile-info-panel dnnClear">
            <div class="answer-vote dnnLeft">
                <!-- ko if: model.approved -->
                <!-- ko if: model.hasUpVote -->
                <a data-bind="click: model.upvote, attr: { 'title': model.upVoteText }" class="answer-vote-upbtn"></a>
                <!-- /ko -->
                <!-- ko ifnot: model.hasUpVote -->
                <a data-bind="attr: { 'title': model.upVoteText }" class="answer-vote-upbtn disabled"></a>
                <!-- /ko -->
                <span data-bind="text: model.score" class="answer-vote-numberOfVote"></span>
                <!-- ko if: model.hasDownVote -->
                <a data-bind="click: model.downvote, attr: { 'title': model.downVoteText }" class="answer-vote-downbtn"></a>
                <!-- /ko -->
                <!-- ko ifnot: model.hasDownVote -->
                <a data-bind="attr: { 'title': model.downVoteText }" class="answer-vote-downbtn disabled"></a>
                <!-- /ko -->
                <!-- /ko -->
            </div>
            <div class="answer-contentBody" id="detailview-content-mobile">
            </div>
            <div class="dnnClear"></div>
        </div>

        <% if (Model.Question.Approved)
           { %>
        <ul class="dnnMobile-ideaActions answer-comment-actions">
            <!-- ko ifnot: model.closed -->
            <li>
                <a data-bind="click: model.replyComment" class="idea-reply"></a>
            </li>
            <!-- /ko -->
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
            <!-- ko ifnot: model.closed -->
            <li>
                <a data-bind="click: report" class="idea-report"></a>
            </li>
            <!-- /ko -->
        </ul>
        <% } %>

        <div class="dnnMobileLike likes" data-bind="html: model.likeString().Small, attr: { id: model.getLikeControlMobileId() }"></div>

        <div data-bind="template: { name: 'comment-template' }" class="answer-contentBody comments-container-mobileview"></div>

        <% if (Model.Question.Approved && !Model.Question.Closed)
           { %>
        <a data-bind="click: reply" class="dnnMobile-addanswer-button dnnPrimaryAction"><%= LocalizeString("AddAnswer") %></a>
        <% } %>

        <!-- ko with: $root.social.getComponentFactory().resolve('DetailController') -->
        <!-- ko if: resultsMobile().length > 0 -->
        <div class="dnnMobile-subHeader">
            <h3><%= LocalizeString("Answers") %></h3>
        </div>
        <!-- ko foreach: resultsMobile -->
        <div class="dnnClear">
            <div class="avatar40">
                <span>
                    <em>
                        <img data-bind="attr: { src: authorProfilePictureUrl, alt: authorDisplayName, title: authorDisplayName }" />
                    </em>
                </span>
            </div>
            <div class="comment-info">
                <span class="idea-comments-author">
                    <a data-bind="attr: { href: authorUrl }, text: authorDisplayName"></a>
                </span>
                <span class="idea-comments-date" data-bind="text: postCreatedRelativeDate"></span>
            </div>
        </div>

        <div class="dnnMobile-contentBody answer-content dnnClear" data-bind="attr: { id: 'mobile-answer-id-' + postId() }">
            <div class="answer-vote dnnLeft">
                <!-- ko if: approved -->
                <!-- ko if: hasUpVote -->
                <a data-bind="click: upvote, attr: { 'title': upVoteText }" class="answer-vote-upbtn"></a>
                <!-- /ko -->
                <!-- ko ifnot: hasUpVote -->
                <a data-bind="attr: { 'title': upVoteText }" class="answer-vote-upbtn disabled"></a>
                <!-- /ko -->
                <!-- ko if: answerId() == postId() -->
                <span data-bind="text: score" class="answer-vote-numberOfVote activeIndicator"></span>
                <!-- /ko -->
                <!-- ko ifnot: answerId() == postId() -->
                <span data-bind="text: score" class="answer-vote-numberOfVote"></span>
                <!-- /ko -->
                <!-- ko if: hasDownVote -->
                <a data-bind="click: downvote, attr: { 'title': downVoteText }" class="answer-vote-downbtn"></a>
                <!-- /ko -->
                <!-- ko ifnot: hasDownVote -->
                <a data-bind="attr: { 'title': downVoteText }" class="answer-vote-downbtn disabled"></a>
                <!-- /ko -->
                <!-- /ko -->
            </div>
            <div class="answer-contentBody" data-bind="html:body">
            </div>

            <!-- ko if: approved -->
            <ul class="dnnMobile-comment-actions answer-comment-actions">
                <!-- ko ifnot: closed -->
                <li>
                    <a data-bind="click: replyComment" class="idea-comment"></a>
                </li>
                <!-- /ko -->
                <li>
                    <!-- ko if: liked -->
                    <a data-bind="click: toggleLike" class="idea-like-liked"></a>
                    <!-- /ko -->
                    <!-- ko ifnot: liked -->
                    <a data-bind="click: toggleLike" class="idea-like"></a>
                    <!-- /ko -->
                </li>
                <% if (!Model.Question.Closed){ %>
                <li>
                    <a data-bind="click: reportComment" class="idea-report"></a>
                </li>
               
                <li>
                    <a data-bind="click: deletePost" class="dnnMobile-comment-remove"></a>
                </li>
                <% } %>
            </ul>
            <!-- /ko -->

            <div class="dnnMobileLike likes" data-bind="html: likeString().Small, attr: { id: getLikeControlMobileId() }"></div>

            <div data-bind="template: { name: 'comment-template' }" class="answer-contentBody comments-container-mobileview"></div>

            <div class="dnnClear"></div>
        </div>

        <!-- /ko -->
        <!-- /ko -->
        <!-- /ko -->

        <% if (Model.Question.Approved && !Model.Question.Closed)
           { %>
        <div class="comments-container-mobileview answer-comments-panel dnnClear">
            <div data-bind="visible: !answerAuthoring()">
                <a class="dnnPrimaryAction dnnMobile-comment-button" data-bind="click: reply"><%= LocalizeString("Answer") %></a>
                <a class="dnnSecondaryAction dnnMobile-comment-viewmore-button" data-bind="visible: showPagerMobileView, click: loadMore"><%= LocalizeString("ViewMore") %></a>
            </div>
            <div class="answer-add-panel answer-comments-panel comment-post dnnMobile-comment-post" style="display: none">
                <div class="dnnFormItem">
                    <textarea class="dnnMobile-redactor-answer-area"></textarea>
                </div>
                <ul class="dnnActions answer-post-actions">
                    <li><a data-bind="click: submitReply" class="dnnPrimaryAction"><%= LocalizeString("cmdSave") %></a></li>
                    <li><a data-bind="click: cancelReply" class="dnnSecondaryAction"><%= LocalizeString("cmdCancel") %></a></li>
                </ul>
            </div>
        </div>
        <% } %>
    </div>
    <!-- /ko -->
    <%-- END MOBILE VIEW --%>

    <div class="editor-dialog" style="display: none;" data-bind="stopBindings: true">
        <answer:AskQuestion ID="CtlEditor" runat="server" />
    </div>
    <social:Report ID="SlReport" runat="server" />
    <social:LikeControl ID="CtlLike" runat="server" />
    <social:ContentExchange ID="SlContentExchange" runat="server" />
    <div id="detailview-content-common" style="display: none">
        <%= Model.Question.Body %>
    </div>
    
       <% if (CanModerate)
       { %>
    <div style="display: none" data-bind="with: supportersControl">
        <div class="like-popup" id="answer-voters-dialog">
            <div class="like-popup-list">
                <table>
                    <tbody>
                        <!-- ko foreach: results -->
                        <tr>
                            <td class="avatar-td">
                                <div class="avatar40">
                                    <span>
                                        <em>
                                            <img data-bind="attr: { src: avatarUrl, title: displayName, alt: displayName }"  />
                                        </em>
                                    </span>                                    
                                 </div>
                            </td>
                            <td class="name-td">
                                <a class="dnnSocialLink" data-bind="attr: { href:  profileUrl }, text: displayName" ></a><b><span data-bind="html: votes"></span></b>
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

<script type='text/html' id='comment-template'>
    <div class="comment-template-container">
        <social:CommentsControl runat="server" ID="CtlComments" Bootstrap="false" Inline="true" />
    </div>
</script>
 
<input type="hidden" name="evoq_social_tab_id" value="<%= ModuleContext.TabId %>"/>
<input type="hidden" name="evoq_social_module_id" value="<%= ModuleContext.ModuleId %>"/>
<input type="hidden" name="evoq_social_contentitem_id" value="<%= Model.Question.ContentItemId %>"/>
<script type='text/javascript'>
    dnn.social.loading('<%= ScopeWrapper.ClientID %>', function() {
        var html = document.getElementById('detailview-content-common').innerHTML;
        document.getElementById('detailview-content-normal').innerHTML = html;
    });
    function detailsInit(settings) {
        settings.moduleScope = $(settings.moduleScope)[0];
        settings.initializeRedactor = <%= IsUserLoggedIn ? "true" : "false" %>;
        if (!settings.moduleScope) {
            return;
        }

        settings.contentControl = $('#txtAnswer');
        var model = <%= SerializedQuestionInfo() %>;
        try {
            window.dnn.social.applyBindings(new window.dnn.answers.DetailView(settings, model), settings.moduleScope);
        } catch(ex) {
            window.dnn.social.topLevelExceptionHandler(settings, ex);
        }
    }
</script>
