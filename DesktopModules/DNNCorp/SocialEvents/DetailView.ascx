<%@ Control Language="C#" AutoEventWireup="false" CodeBehind="DetailView.ascx.cs" Inherits="DotNetNuke.Professional.SocialEvents.DetailView" %>
<%@ Import Namespace="DotNetNuke.Professional.SocialEvents.Components.Common" %>
<%@ Import Namespace="DotNetNuke.Professional.SocialEvents.Providers.Sitemap" %>
<%@ Import Namespace="DotNetNuke.Services.Localization" %>
<%@ Import Namespace="DotNetNuke.SocialLibrary.Components.Common" %>
<%@ Register TagPrefix="social" TagName="Comments" Src="~/DesktopModules/DNNCorp/SocialLibrary/Controls/CommentsControl.ascx" %>
<%@ Register TagPrefix="social" TagName="Report" Src="~/DesktopModules/DNNCorp/SocialLibrary/Controls/ReportContent.ascx" %>
<%@ Register TagPrefix="events" TagName="Wizard" Src="~/DesktopModules/DNNCorp/SocialEvents/Controls/Wizard.ascx" %>
<%@ Register TagPrefix="social" TagName="LikeControl" Src="~/DesktopModules/DNNCorp/SocialLibrary/Controls/LikeControl.ascx" %>

<asp:Panel runat="server" ID="ScopeWrapper" CssClass="dnnClear moduleContainer">
    <%-- NORMAL VIEW --%>
    <!-- ko ifnot: isMobileView -->
    <div class="moduleContainer-normalView ko-container">
        <div class="moduleTitleContainer detail-container dnnClear">      
            <div class="title-container dnnLeft">
                <h3>
                    <%= SocialEvent.ContentTitle %>
                </h3>
                <p class="title-returnPrev">
                    <asp:HyperLink runat="server" ID="hlReturn" resourcekey="hlReturn" />
                </p>
            </div>
            <div class="dnnRight">
                <% if (SocialEvent.Approved)
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
                </ul>
                <% } %>
            </div>
        </div>
        <div class="moduleThreadContainer moduleTopInsetShadowBox dnnClear">
            <div class="info-panel">
                <ul class="dnnLeft">
                     <li>
                        <span><%= DateFromUtc(SocialEvent.CreatedOnDate, ModuleContext.PortalSettings.UserInfo.Profile.PreferredTimeZone).ToShortDateString() %></span>
                    </li>
                    <li>
                        <span data-bind="text: model.attending()"></span>
                        <span><%= LocalizeString("Attendees") %> </span>
                    </li>
                </ul>
                <ul class="dnnRight">
                    <li><span data-bind="html: commentCount"><%= SocialEvent.CommentCount %></span>&nbsp;<%= Localization.GetString(SocialEvent.CommentCount == 1 ? "Comment" : "Comments", LocalResourceFile) %></li>
                    <li>
                        <%= Localization.GetString("LastActivity", LocalResourceFile) %>
                        <span><%= SocialEvent.LastActiveRelativeDate %></span>, 
					    <a class="dnnSocialLink" href="<%= SocialEvent.LastActiveProfileUrl %>">
                            <%= SocialEvent.LastActiveDisplayName %>
                        </a>
                    </li>
                </ul>

                <div class="dnnClear">
                    <% if (SocialEvent.Tags.Any())
                       { %>
                    <span class="list-row-label"><%= LocalizeString("Tags") %>:</span>
                    <ul class="list-row-tags">
                        <% foreach (var tag in SocialEvent.Tags)
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
            <div class="detail-main-container">
                <div class="socialevents-detail-voteContainer static-row">
                     <div>
                        <a class="socialevent-attend-button dnnTertiaryAction">Attend</a>
                    </div>
                    <div class="dnnClear"></div>
                </div>
                <!-- ko with: model -->
                <div class="socialevents-detail-voteContainer ko-container">
                    <div>
                        <a data-bind="click: $root.rsvp, text: userRSVPStatusLabel, attr: { 'class' : 'socialevent-attend-button dnnTertiaryAction '+ userRSVPStyle() }"></a>
                    </div>
                    <div class="dnnClear"></div>

                    <div data-bind="attr: { id: 'rsvp-panel-' + eventId() }" class="idea-vote-options">
                        <div data-bind="with:voteButtons" style="display: inline-block">
                            <div class="ie-shadow">
                                <!-- ko foreach: buttons() -->
                                <a href="javascript:void(0)" data-bind="click: exec, attr: { 'class': 'button ' + type, 'title' : title }">
                                    <span data-bind="text: text"></span>
                                </a>
                                <!-- /ko -->
                            </div>
                        </div>

                        <!-- ko if: showGuestsToPublic() -->
                        <div class="remaining">
                            <%= LocalizeString("See") %> <a href="<%= SocialEventAttendeesUrl(AttendingStatus.Yes) %>"><%= LocalizeString("WhoElseAttending") %></a>
                        </div>
                        <!-- /ko -->
                    </div>
                </div>
                <!-- /ko -->

                <div>
                    <div class="detail-avatar-container">
                        <div class="avatar40">
                            <span>
                                <em>
                                    <img id="imgIdeaAuthor" src="<%= ResolveUrl(Evoq.Common.Utilities.GetProfileAvatar(SocialEvent.CreatedByUser)) %>" alt="<%= SocialEvent.AuthorDisplayName %>" title="<%= SocialEvent.AuthorDisplayName %>" />
                                </em>
                            </span>
                        </div>
                    </div> 
           
               
                    <div class="idea-content highlight-content">
                        <% if (CanModerate || CanEdit)
                           { %>
                         <div class="comment-actions-menu" id="detail-content-moderator-menu">
                            <a href="javascript:void(0)" class="comment-actions"></a>
                            <ul class="comment-actions-dropdown">
                                <li><a data-bind="click: edit"><%= LocalizeString("Edit") %></a></li>
                                <li><a id="deleteEvent" href="javascript:void(0)"><%= LocalizeString("Remove") %></a></li>
                            </ul>
                        </div>
                        <% } %>

                        <span class="detail-comments-author">
                            <a href="<%= SocialEvent.AuthorUrl %>" class="dnnSocialLink"><%= SocialEvent.AuthorDisplayName%></a>
                        </span>
                        <span class="detail-comments-date">
                            <%= Utilities.RelativeDate(SocialEvent.CreatedOnDate)%>
                        </span>
                        <div class="dnnClear socialevents-detail-dateaddress">
                            <span class="socialevents-add-to-cal"><%= LocalizeString("AddToCalendar") %>:</span>
                            <span class="socialevents-displaytime">
                                <a data-bind="text: model.listviewEventDisplayTime" href="<%= SocialEvent.EventIcsUrl %>" ></a>
                            </span>
                            <span data-bind="text: model.timeOffsetName" class="socialevents-displaytimezone"></span>
                            <span data-bind="text: model.completeAddress" class="socialevents-address"></span>
                            <span data-bind="text: model.seatsLabel" class="socialevents-seats"></span>
                        </div>
                        <div class="answer-comments-content dnnClear" id="detailview-content-normal"></div>

                        <% if (SocialEvent.Approved)
                           { %>
                         <ul class="detail-bottom-social-actions static-row">
                            <% if (SocialEvent.CanModerate || SocialEvent.RsvpStatus > 0 || SocialEvent.ShowGuests)
                               { %>
                            <li>
                                <a href="<%= SocialEventAttendeesUrl(AttendingStatus.Yes) %>" class="idea-reply dnnSocialLink">
                                    <span><%= LocalizeString("AttendeeList") %></span>
                                </a>
                            </li>
                            <%} %>
                            <li>
                                <a href="javascript:void(0)" class="idea-reply dnnSocialLink">
                                    <span><%= LocalizeString("Reply") %></span>
                                </a>
                            </li>
                            <li>
                                <a class="idea-like dnnSocialLink">
                                    <span><%= LocalizeString("Like") %></span>
                                </a>
                            </li>
                            <li>
                                <a class="idea-report dnnSocialLink">
                                    <span><%= LocalizeString("Report") %></span>
                                </a>
                            </li>
                        </ul>

                        <ul class="detail-bottom-social-actions ko-container">
                            <% if (SocialEvent.CanModerate || SocialEvent.RsvpStatus > 0 || SocialEvent.ShowGuests)
                               { %>
                            <li>
                                <a href="<%= SocialEventAttendeesUrl(AttendingStatus.Yes) %>" class="idea-reply dnnSocialLink">
                                    <span><%= LocalizeString("AttendeeList") %></span>
                                </a>
                            </li>
                            <%} %>
                            <li>
                                <a href="javascript:void(0)" data-bind="click: reply" class="idea-reply dnnSocialLink">
                                    <span><%= LocalizeString("Reply") %></span>
                                </a>
                            </li>
                            <!-- ko with: model -->
                            <li>
                                <!-- ko if: liked -->
                                <a href="javascript:void(0)" data-bind="click: toggleLike" class="idea-like-liked dnnSocialLink">
                                    <span><%= LocalizeString("Unlike") %></span>
                                </a>
                                <!-- /ko -->

                                <!-- ko ifnot: liked -->
                                <a href="javascript:void(0)" data-bind="click: toggleLike" class="idea-like dnnSocialLink">
                                    <span><%= LocalizeString("Like") %></span>
                                </a>
                                <!-- /ko -->
                            </li>
                            <!-- /ko -->
                            <li>
                                <a href="javascript:void(0)" data-bind="click: report" class="idea-report dnnSocialLink">
                                    <span><%= LocalizeString("Report") %></span>
                                </a>
                            </li>
                        </ul>
                        <div class="dnnClear likes" data-bind="html: model.likeString().Big, attr: { id: model.getLikeControlId() } "></div>
                        <% } %>

                        <div class="dnnClear"></div>
                    </div>

                    <!-- ko with: model -->
                    <div class="socialevents-detailinfo dnnClear ko-container">
                        <!-- ko if: guestLoaded() -->
                        <!-- ko if: attendingGuests.length > 0 || invitedGuests.length > 0  -->
                        <div class="socialevents-detail-guests">

                            <!-- ko if: attendingGuests.length > 0 -->
                            <div>
                                <span class="pinkLink"><%= LocalizeString("AttendingAndMaybe") %></span>
                                <div>
                                    <!-- ko foreach: attendingGuests -->
                                    <a data-bind="attr: {href: GuestProfileUrl}" class="avatar40 socialevents-guest-avatar">
                                        <span>
                                            <em>
                                                <img data-bind="attr: { src: AvatarPath, title: GuestDisplayName, alt: GuestDisplayName }" />
                                            </em>
                                        </span>
                                    </a>
                                    <!-- /ko -->

                                    <a href="<%= SocialEventAttendeesUrl(AttendingStatus.Yes) %>" data-bind="visible: showAttendingGuestsMore">View More</a>
                                </div>

                            </div>
                            <!-- /ko -->

                            <!-- ko if: invitedGuests.length > 0 -->
                            <div>
                                <span class="pinkLink"><%= LocalizeString("Invited") %></span>

                                <div>
                                    <!-- ko foreach: invitedGuests -->
                                    <a data-bind="attr: {href: GuestProfileUrl}" class="avatar40 socialevents-guest-avatar">
                                        <span>
                                            <em>
                                                <img data-bind="attr: { src: AvatarPath, title: GuestDisplayName, alt: GuestDisplayName }" />
                                            </em>
                                        </span>
                                    </a>
                                    <!-- /ko -->
                                    <a href="<%= SocialEventAttendeesUrl(AttendingStatus.Invited) %>" data-bind="visible: showInvitedGuestsMore">View More</a>
                                </div>

                            </div>
                            <!-- /ko -->
                        </div>
                        <!-- /ko -->
                        <!-- /ko -->

                        <!-- ko if: completeAddress() != '' -->
                        <div class="socialeevents-embedded-map">
                            <!-- ko if: $root.mapProvider == 'google' -->
                            <iframe width="350px" height="200px" frameborder="0" scrolling="no" marginheight="0" marginwidth="0"
                                data-bind="attr: {src: googleMapLink }"></iframe>
                            <!-- /ko -->
                            <!-- ko if: $root.mapProvider == 'bing' -->
                            <div id='mapDiv' class="socialevents-embeded-map" style="width: 350px; height: 200px; margin-bottom: 15px">
                            </div>
                            <!-- /ko -->
                        </div>
                        <!-- /ko -->

                    </div>
                    <!-- /ko -->

                </div>
            </div>
      
            <div class="dnnClear"></div>

            <a id="comments"></a>

            <div class="idea-comment-container">
                <div class="comments-container-normalview"></div>
            </div>
            
              <% if (!SocialEvent.Approved)
                { %>
                <div class="detail-main-container dnnClear">
                    <div class="dnnFormMessage" style="margin: 0">
                        <%= LocalizeString("CommentsDisabled") %>
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
        </div>
        
        <div class="dnnRight">
            <% if (SocialEvent.Approved)
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
            <div class="dnnClear dnnRight">
                <span data-bind="text: model.attending()"></span>
                <span><%= LocalizeString("Attendees") %></span>
            </div>
        </div>
        
        <div class="dnnClear">
            <h3>
                <%= SocialEvent.ContentTitle %>
            </h3>
        </div>
        
        <div class="dnnClear">
            <div class="avatar40">
                <span>
                    <em>
                        <img src="<%= ResolveUrl(Evoq.Common.Utilities.GetProfileAvatar(SocialEvent.CreatedByUser)) %>" alt="<%= SocialEvent.AuthorDisplayName %>" title="<%= SocialEvent.AuthorDisplayName %>" />
                    </em>
                </span>
            </div>
            <div class="comment-info">
                <span class="idea-comments-author"><a href="<%= SocialEvent.AuthorUrl %>"><%= SocialEvent.AuthorDisplayName %></a></span>
                <span class="idea-comments-date"><%= Utilities.RelativeDate(SocialEvent.CreatedOnDate) %></span>
            </div>
        </div>
        
        <div class="dnnClear socialevents-detail-dateaddress">
            <span class="socialevents-add-to-cal"><%= LocalizeString("AddToCalendar") %>:</span>
                <span class="socialevents-displaytime">
                    <a data-bind="text: model.listviewEventDisplayTime" href="<%= SocialEvent.EventIcsUrl %>"></a>
                </span>
            <span data-bind="text: model.timeOffsetName" class="socialevents-displaytimezone"></span>
            <span data-bind="text: model.completeAddress" class="socialevents-address"></span>
            <span data-bind="text: model.seatsLabel" class="socialevents-seats"></span>
        </div>

        <div class="dnnMobile-contentBody" id="detailview-content-mobile"></div>
        
        <!-- ko with: model -->
        <!-- ko if: completeAddress() != '' -->
        <div class="socialeevents-embedded-map">
            <!-- ko if: $root.mapProvider == 'google' -->
            <iframe width="100%" height="200px" frameborder="0" scrolling="no" marginheight="0" marginwidth="0"
                data-bind="attr: {src: googleMapLink }"></iframe>
            <!-- /ko -->
            <!-- ko if: $root.mapProvider == 'bing' -->
            <div id='mapDivMobileView' class="socialevents-embeded-map" style="width: 100%; height:200px">
            </div>
            <!-- /ko -->
        </div>
        <!-- /ko -->
        <!-- /ko -->
        
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
            <li>
                <a data-bind="click: report" class="idea-report"></a>
            </li>
        </ul>
        
        <div class="dnnMobileLike likes" data-bind="html: model.likeString().Small, attr: { id: model.getLikeControlMobileId() }"></div>

        <div class="socialevent-actions">
            <!-- ko with: model -->
            <a data-bind="click: $root.rsvpMobileView, attr: { 'class': 'idea-vote-button dnnTertiaryAction ' + userRSVPStyle() }, html: userRSVPStatusLabel">
            </a>
            <div class="dnnMobile-idea-vote-options dnnMobile-event-vote-options">
                <div data-bind="with: voteButtons">
                    <!-- ko foreach: buttons() -->
                    <a href="javascript:void(0)" data-bind="click: exec, attr: { 'class': 'button ' + type }">
                        <span data-bind="text: text"></span>
                    </a>
                    <!-- /ko -->
                    <div class="dnnClear"></div>
                </div>
                <!-- ko if: showGuestsToPublic() -->
                <div class="remaining dnnClear">
                    <%= LocalizeString("See") %> <a href="<%= SocialEventAttendeesUrl(AttendingStatus.Yes) %>"><%= LocalizeString("WhoElseAttending") %></a>
                </div>
                <!-- /ko -->
            </div>
            <!-- /ko -->
            <a class="dnnPrimaryAction" data-bind="click: reply"><%= LocalizeString("AddAComment") %></a>
        </div>
        
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

    <div class="editor-dialog" data-bind="stopBindings: true" style="display: none;">
        <events:Wizard ID="CtlEditor" runat="server" />
    </div>
    
    <social:Report ID="SlReport" runat="server" />
    
    <social:LikeControL ID="CtlLike" runat="server" />
    
    <div class="comments-container-common">
    <% if (SocialEvent.Approved)
    { %>
        <social:Comments runat="server" ID="SlComments" />
    <% } %>
    </div>
    
    <div id="detailview-content-common" style="display: none">
         <%= Utilities.FixDoublEntityEncoding(SocialEvent.Content) %>
    </div>
</asp:Panel>

<input type="hidden" name="evoq_social_tab_id" value="<%= ModuleContext.TabId %>"/>
<input type="hidden" name="evoq_social_module_id" value="<%= ModuleContext.ModuleId %>"/>
<input type="hidden" name="evoq_social_contentitem_id" value="<%= SocialEvent.ContentItemId %>"/>
<script type='text/javascript'>
    dnn.social.loading('<%= ScopeWrapper.ClientID %>', function() {
        var html = document.getElementById('detailview-content-common').innerHTML;
        document.getElementById('detailview-content-normal').innerHTML = html;
    });
    function eventDetailsInit(settings) {		
        settings.moduleScope = $(settings.moduleScope)[0];
        if (!settings.moduleScope) {
            return;
        }

	    var model = <%= SerializedEventInfo() %>;
        model.groupId = settings.groupId;
        try {
            window.dnn.social.applyBindings(new window.dnn.socialevents.DetailView(settings, model), settings.moduleScope);
        } catch(ex) {
            window.dnn.social.topLevelExceptionHandler(settings, ex);
        }
    }
</script>
