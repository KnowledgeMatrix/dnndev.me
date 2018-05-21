<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ProfileView.ascx.cs" Inherits="DotNetNuke.Professional.Dashboard.ProfileView" %>
<%@ Register TagPrefix="social" TagName="Report" Src="~/DesktopModules/DNNCorp/SocialLibrary/Controls/ReportUser.ascx" %>
<%@ Register TagPrefix="social" TagName="RemoveUser" Src="~/DesktopModules/DNNCorp/SocialLibrary/Controls/RemoveUser.ascx" %>

<asp:Panel runat="server" ID="ScopeWrapper" class="profileContainer status-expanded-container moduleContainer">
    <div id="profileView">

        <div data-bind="stopBindings: true" class="remove-user-dialog" style="display: none;">
            <social:RemoveUser ID="RemoveUserCtrl" runat="server" />
        </div>

        <%-- NORMAL VIEW --%>
        <!-- ko ifnot: isMobileView-->
        <div class="moduleContainer-normalView ko-container">
            <div class="profile-topContainer" data-bind="with: profile" id="dnnMyStatusExpanded">
                <!-- ko ifnot: $root.anonymous -->
                <div class="profile-completion-image">
                    <div class="qaTooltip" data-bind="if: $root.profile.dynamic() != null">
                        <a class="tag">
                            <canvas class="chart"></canvas>
                        </a>
                        <div class="tag-menu" style="display: none;">
                            <p data-bind="text: '<%= LocalizeString("ProfileComplete") %>'.format($root.profile.dynamic().completed())"></p>
                        </div>
                    </div>
                </div>
                <div class="dnnLeft">
                    <a class="dnnSocialLink profile-link" data-bind="attr: { href: profileUrl }">
                        <span data-bind="text: properties().displayName"></span>
                    </a>
                    <span class="userRemoved" data-bind="visible: isDeleted()" style="display: none;">
                        <a class="userRemovedMsg" data-bind="visible: isDeleted()"><%= LocalizeString("UserRemoved") %></a>
                    </span>
                </div>
                <div class="dnnRight">
                    <ul class="profile-statistics static-row">
                        <li>
                            <span><%= LocalizeString("Friends") %></span>
                            <span class="profile-item-data">0</span>
                        </li>
                        <li>
                            <span><%= LocalizeString("Following") %></span>
                            <span class="profile-item-data">0</span>
                        </li>
                        <li>
                            <span><%= LocalizeString("Followers") %></span>
                            <span class="profile-item-data">0</span>
                        </li>
                        <li>
                            <span><%= LocalizeString("ExpandedPoints") %></span>
                            <span class="profile-item-data">0</span>
                        </li>
                    </ul>
                    <!-- ko if: dynamic() != null -->
                    <ul class="profile-statistics ko-container" data-bind="with: dynamic">
                        <li>
                            <!-- ko if: friends === '1' -->
                            <span><%= LocalizeString("Friend") %></span>
                            <!-- /ko -->
                            <!-- ko if: friends !== '1' -->
                            <span><%= LocalizeString("Friends") %></span>
                            <!-- /ko -->
                            <span class="profile-item-data" data-bind="text: friends"></span>
                        </li>
                        <li>
                            <span><%= LocalizeString("Following") %></span>
                            <span class="profile-item-data" data-bind="text: followings"></span>
                        </li>
                        <li>
                            <!-- ko if: friends === '1' -->
                            <span><%= LocalizeString("Follower") %></span>
                            <!-- /ko -->
                            <!-- ko if: friends !== '1' -->
                            <span><%= LocalizeString("Followers") %></span>
                            <!-- /ko -->
                            <span class="profile-item-data" data-bind="text: followers"></span>
                        </li>
                        <li>
                            <!-- ko if: reputationPoints === '1' -->
                            <span><%= LocalizeString("ExpandedPoint") %></span>
                            <!-- /ko -->
                            <!-- ko if: reputationPoints !== '1' -->
                            <span><%= LocalizeString("ExpandedPoints") %></span>
                            <!-- /ko -->
                            <span class="profile-item-data" data-bind="text: reputationPoints"></span>
                        </li>
                        <li data-bind="visible: $root.showModerateMenu()" style="border-left: none">
                            <div class="comment-actions-menu" id="moderator-actions-menu">
                                <a href="javascript:void(0)" class="comment-actions">
                                    <img src="<%= ModeratorActionsImageUrl %>" title="<%= LocalizeString("ModeratorActions") %>" />
                                </a>
                                <ul class="comment-actions-dropdown  moderator-actions">
                                    <li><a data-bind="click: $root.removeUser"><%= LocalizeString("RemoveUser") %></a></li>
                                </ul>
                            </div>
                        </li>
                    </ul>
                    <!-- /ko -->
                </div>
                <!-- /ko -->
                <div class="dnnClear"></div>
            </div>
            <!-- ko ifnot: $root.anonymous -->
            <div class="profile-bottomContainer" data-bind="with: profile">
                <div class="dnnRight reportUser" id="reportUser" runat="server">
                    <a class="idea-report dnnSocialLink" href="javascript:void(0)" data-bind="click: $root.reportUser">
                        <span><%= LocalizeString("ReportUser") %></span>
                    </a>
                </div>
                <!-- ko if: showBio -->
                <div class="ko-container dnnRight biography-wide">
                    <p class="profile-description">
                        <%= LocalizeString("Description") %>
                    </p>
                    <div>
                        <span data-bind="html: biography"></span>
                        <!-- ko if: showMore -->
                        <a data-bind="click: toggleMore">
                            <!-- ko if: bioExpanded -->
                            <%= LocalizeString("HideMore") %>
                            <!-- /ko -->
                            <!-- ko ifnot: bioExpanded -->
                            <%= LocalizeString("ReadMore") %>
                            <!-- /ko -->
                        </a>
                        <!-- /ko -->
                    </div>
                </div>
                <!-- /ko -->
                <div class="dnnLeft">
                    <!-- ko if: location() != '' -->
                    <div class="profile-address" title="<%= LocalizeString("Location") %>">
                        <span data-bind="html: location"></span>
                    </div>
                    <!-- /ko -->
                    <div class="profile-social-links ko-container">
                        <!-- ko ifnot: $root.userIsMe -->
                        <ul class="dnnButtonGroup">
                            <li class="dnnButtonGroup-first"></li>
                            <li>
                                <!-- ko if: isFriendRequested -->
                                <a href="javascript:void(0)" class="disabled" disabled="disabled">
                                    <%= LocalizeString("FriendRequested") %>
                                </a>
                                <!-- /ko -->
                                <!-- ko ifnot: isFriendRequested -->
                                <a data-bind="click: $root.friend">
                                    <!-- ko if: isFriend -->
                                    <%= LocalizeString("Unfriend") %>
                                    <!-- /ko -->
                                    <!-- ko ifnot: isFriend -->
                                    <%= LocalizeString("Friend") %>
                                    <!-- /ko -->
                                </a>
                                <!-- /ko -->
                            </li>
                            <li>
                                <a data-bind="click: $root.follow">
                                    <!-- ko if: isFollowed -->
                                    <%= LocalizeString("Unfollow") %>
                                    <!-- /ko -->
                                    <!-- ko ifnot: isFollowed -->
                                    <%= LocalizeString("Follow") %>
                                    <!-- /ko -->
                                </a>
                            </li>
                        </ul>
                        <ul class="dnnButtonGroup">
                            <li class="dnnButtonGroup-first"></li>
							<% if (!PortalSettings.DisablePrivateMessage)
							   { %>
                            <li>
                                <a class="profile-message-btn ComposeMessage" href="javascript:void(0)" data-bind="click: $root.sendMessage"></a>
                            </li>
							<% } %>
                        </ul>
                        <!-- /ko -->
                        <!-- ko if: $root.userIsMe -->
                        <a href="<%= EditProfileUrl %>" class="dnnSecondaryAction">
                            <%= LocalizeString("EditProfile") %>
                        </a>
                        <!-- /ko -->
                        <ul class="user-external-sociallinks">
                            <!-- ko if: $root.showTwitter() -->
                            <li>
                                <a class="external-sociallink-twitter" data-bind="click: $root.twitter"></a>
                            </li>
                            <!-- /ko -->

                            <!-- ko if: $root.showFacebook() -->
                            <li>
                                <a class="external-sociallink-facebook" data-bind="click: $root.facebook"></a>
                            </li>
                            <!-- /ko -->

                            <!-- ko if: $root.showLinkedin() -->
                            <li>
                                <a class="external-sociallink-linkedin" data-bind="click: $root.linkedin"></a>
                            </li>
                            <!-- /ko -->

                            <!-- ko if: $root.showGooglePlus() -->
                            <li>
                                <a class="external-sociallink-googleplus" data-bind="click: $root.googlePlus"></a>
                            </li>
                            <!-- /ko -->
                        </ul>
                    </div>
                </div>
                <div class="dnnClear"></div>

            </div>
            <div class="profile-avatar" data-bind="with: profile">
                <span>
                    <em>
                        <img data-bind="attr: { src: expandViewPhotoUrl, title: displayName }" />
                    </em>
                </span>
            </div>
            <!-- /ko -->
        </div>
        <!-- /ko -->
        <%-- END NORMAL VIEW --%>

        <%-- MOBILE VIEW --%>
        <!-- ko if: isMobileView -->
        <div class="moduleContainer-mobileView ko-container">
            <!-- ko ifnot: $root.anonymous -->
            <div class="dnnMobile-profile-container" data-bind="with: profile">
                <div class="avatar40 dnnLeft">
                    <span>
                        <em>
                            <img data-bind="attr: { src: expandViewPhotoUrl, title: displayName }" />
                        </em>
                    </span>
                </div>
                <div class="dnnMobile-profile-detail">
                    <span>
                        <span data-bind="text: properties().displayName" class="dnnMobile-profile-fullname"></span>
                        <a class="userRemovedMsg" data-bind="visible: isDeleted()"><%= LocalizeString("UserRemoved") %></a>
                    </span>
                    <!-- ko if: location() != '' -->
                    <span data-bind="html: location" class="dnnMobile-profile-address"></span>
                    <!-- /ko -->       
                    <div class="reportUser" id="reportUserMobile" runat="server">
                        <a class="idea-report dnnSocialLink" href="javascript:void(0)" data-bind="click: $root.reportUser">
                            <span><%= LocalizeString("ReportUser") %></span>
                        </a>
                    </div>             
                </div>
                <div class="dnnRight">
                    <!-- ko ifnot: $root.userIsMe -->
                    <ul class="dnnButtonGroup">
                        <li class="dnnButtonGroup-first"></li>
                        <li>
                            <!-- ko if: isFriendRequested -->
                            <a href="javascript:void(0)" class="disabled" disabled="disabled">
                                <%= LocalizeString("FriendRequested") %>
                            </a>
                            <!-- /ko -->
                            <!-- ko ifnot: isFriendRequested -->
                            <a data-bind="click: $root.friend">
                                <!-- ko if: isFriend -->
                                <%= LocalizeString("Unfriend") %>
                                <!-- /ko -->
                                <!-- ko ifnot: isFriend -->
                                <%= LocalizeString("Friend") %>
                                <!-- /ko -->
                            </a>
                            <!-- /ko -->
                        </li>
                        <li>
                            <a data-bind="click: $root.follow">
                                <!-- ko if: isFollowed -->
                                <%= LocalizeString("Unfollow") %>
                                <!-- /ko -->
                                <!-- ko ifnot: isFollowed -->
                                <%= LocalizeString("Follow") %>
                                <!-- /ko -->
                            </a>
                        </li>
                    </ul>
                    <!-- /ko -->
                </div>               
                <div class="dnnClear"></div>
                <!-- ko if: showBio -->
                <div>
                    <p class="dnnMobile-profile-description">
                        <%= LocalizeString("Description") %>
                    </p>
                    <div class="dnnMobile-biography">
                        <span data-bind="html: biography"></span>
                    </div>
                </div>
                <!-- /ko -->
                <!-- ko if: dynamic() == null -->
                <div class="status-binding-loading loading"></div>
                <!-- /ko -->
                <!-- ko if: dynamic() != null -->
                <ul class="dnnMobile-profile-statistics" data-bind="with: dynamic">
                    <li>
                        <span class="dnnMobile-profile-item-data" data-bind="text: friends"></span>
                        <!-- ko if: friends === '1' -->
                        <span><%= LocalizeString("Friend") %></span>
                        <!-- /ko -->
                        <!-- ko if: friends !== '1' -->
                        <span><%= LocalizeString("Friends") %></span>
                        <!-- /ko -->
                    </li>
                    <li class="li-rightside">
                        <span class="dnnMobile-profile-item-data" data-bind="text: followings"></span>
                        <span><%= LocalizeString("Following") %></span>
                    </li>
                    <li>
                        <span class="dnnMobile-profile-item-data" data-bind="text: followers"></span>
                        <!-- ko if: friends === '1' -->
                        <span><%= LocalizeString("Follower") %></span>
                        <!-- /ko -->
                        <!-- ko if: friends !== '1' -->
                        <span><%= LocalizeString("Followers") %></span>
                        <!-- /ko -->
                    </li>
                    <li class="li-rightside">
                        <span class="dnnMobile-profile-item-data" data-bind="text: reputationPoints"></span>
                        <!-- ko if: reputationPoints === '1' -->
                        <span><%= LocalizeString("ExpandedPoint") %></span>
                        <!-- /ko -->
                        <!-- ko if: reputationPoints !== '1' -->
                        <span><%= LocalizeString("ExpandedPoints") %></span>
                        <!-- /ko -->
                    </li>
                    <div class="dnnClear"></div>
                </ul>
                <!-- /ko -->
            </div>
            <!-- /ko -->
        </div>
        <!-- /ko -->
        <%-- END MOBILE VIEW --%>
    </div>
    
    <div class="dnnClear status-expanded-bottom"></div>
    <social:Report ID="ReportUserCtrl" runat="server" />

</asp:Panel>

<script type="text/javascript">
    dnn.social.loading('<%= ScopeWrapper.ClientID %>');
    function dashboard_profileinit(settings) {
        settings.moduleScope = $(settings.moduleScope)[0];
        if (!settings.moduleScope) {
            return;
        }

        try {
            if (typeof settings.profileUserId === 'undefined' || settings.profileUserId < 0) 
                $(settings.moduleScope).hide();
            else
                dnn.social.applyBindings(new dnn.dashboard.ProfileView(settings), settings.moduleScope);
        } catch (ex) {
            dnn.social.topLevelExceptionHandler(settings, ex);
        }
    }
</script>
