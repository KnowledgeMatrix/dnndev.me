<%@ Control Language="C#" AutoEventWireup="false" CodeBehind="DetailView.ascx.cs" Inherits="DotNetNuke.Professional.Challenges.DetailView" %>
<%@ Import Namespace="DotNetNuke.Services.Localization" %>
<%@ Register TagPrefix="challenges" TagName="EditView" Src="~/DesktopModules/DNNCorp/Challenges/Controls/EditView.ascx" %>
<asp:Panel runat="server" ID="ScopeWrapper" CssClass="dnnClear moduleContainer">
    <%-- NORMAL VIEW --%>
    <!-- ko ifnot: isMobileView -->
    <div class="moduleContainer-normalView ko-container">
        <div class="moduleTitleContainer detail-container dnnClear">
            <div class="title-container dnnLeft">
                <h3>
                    <span class="idea-title-status"></span>
                    <%= Challenge.ContentTitle %>
                </h3>
                <p class="title-returnPrev">
                    <asp:HyperLink runat="server" ID="hlReturn" resourcekey="hlReturn" /></p>
            </div>
            <div class="dnnRight">
                <% if (Challenge.Approved)
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
                <ul class="dnnLeft">
                    <li>
                        <span><%= Challenge.CreatedOnDate.ToShortDateString() %></span>
                    </li>
                </ul>

                <ul class="dnnRight">
                    <li>
                        <%= LocalizeString("LastActive") %> <span><%= Challenge.RelativeActiveDate %></span>
                    </li>
                </ul>

                <div class="dnnClear">
                    <% if (Challenge.Tags.Any())
                       { %>
                    <span class="list-row-label"><%= Localization.GetString("Tags", LocalResourceFile) %>:</span>
                    <ul class="list-row-tags">
                        <% foreach (var tag in Challenge.Tags)
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
                <% if (CanModerate || CanEdit)
                   { %>
                <div class="comment-actions-menu" id="detail-content-moderator-menu">
                    <a href="javascript:void(0)" class="comment-actions"></a>
                    <ul class="comment-actions-dropdown" style="z-index: 100">
                        <li><a data-bind="click: edit" title="Edit">Edit</a></li>
                        <li><a href="javascript:void(0)" id="deleteChallenge" title="Remove">Remove</a></li>
                    </ul>
                </div>
                <% } %>
                <div>
                    <h3><%= Localization.GetString("Participation", LocalResourceFile) %></h3>
                    <div id="challenge-detailview-participation" class="chart-container">
                        <ul id="challenge-detailview-participation-legend" class="graph-legend"></ul>
                        <div class="line-chart-tooltip" style="display: none;">
                            <span class="title"></span>
                            <span class="info line-1"></span>
                            <span class="info line-2"></span>
                            <div class="line-chart-tooltip-anchor"></div>
                        </div>
                        <div class="dnnClear">
                            <svg class="line-chart"></svg>
                        </div>
                    </div>
                    <div class="chart-summary dnnClear">
                        <div class="summary-element dnnLeft">
                            <span class="summary-title"><%= Localization.GetString("Invited", LocalResourceFile) %></span>
                            <span><%= ChallengeAnalysisData.Invited %></span>
                        </div>
                        <div class="summary-element dnnLeft">
                            <span class="summary-title"><%= Localization.GetString("Accepted", LocalResourceFile) %></span>
                            <span><%= ChallengeAnalysisData.Accepted %><sup>%</sup></span>
                        </div>
                        <div class="summary-element dnnLeft">
                            <span class="summary-title"><%= Localization.GetString("Completed", LocalResourceFile) %></span>
                            <span><%= ChallengeAnalysisData.Completed %><sup>%</sup></span>
                        </div>
                        <asp:PlaceHolder runat="server" ID="phInboundSharingDesktop">
                            <div class="summary-element dnnLeft">
                                <span class="summary-title"><%= Localization.GetString("NewAdopters", LocalResourceFile) %></span>
                                <span><%= ChallengeAnalysisData.NewAdopters %></span>
                            </div>
                            <div class="summary-element dnnLeft">
                                <span class="summary-title"><%= Localization.GetString("UniqueClicks", LocalResourceFile) %></span>
                                <span><%= ChallengeAnalysisData.UniqueClicks %></span>
                            </div>   
                        </asp:PlaceHolder>                     
                        <div class="summary-element dnnLeft">
                            <span class="summary-title"><%= Localization.GetString("NewParticipants", LocalResourceFile) %></span>
                            <span><%= ChallengeAnalysisData.NewParticipants %><sup>%</sup></span>
                        </div>
                        <div class="summary-element dnnLeft">
                            <span class="summary-title"><%= Localization.GetString("NewCompletionists", LocalResourceFile) %></span>
                            <span><%= ChallengeAnalysisData.NewCompletionists %><sup>%</sup></span>
                        </div>
                    </div>
                </div>
                <% if (false) //SOCIAL-3497 Removed to be added back in a later revision
                   { %>
                <div class="challenge-detailview-segment">
                    <h3><%= Localization.GetString("SocialBreakdown", LocalResourceFile) %></h3>
                    <div id="challenge-detailview-socialfollowers" class="chart-container donut-chart-container dnnLeft">
                        <div class="dnnClear" id="challenge-detailview-socialfollowers-svg" style="position: relative">
                            <div class="donut-chart-center" id="challenge-detailview-socialfollowers-ratio"></div>
                        </div>
                        <div class="line-chart-tooltip align-center" style="display: none;">
                            <span class="title"></span>
                            <span class="info line-1"></span>
                            <div class="line-chart-tooltip-anchor"></div>
                        </div>
                        <ul id="challenge-detailview-socialfollowers-legend" class="graph-legend"></ul>
                    </div>

                    <div id="challenge-detailview-socialnetworks" class="chart-container donut-chart-container dnnRight">
                        <div class="dnnClear" id="challenge-detailview-socialnetworks-svg" style="position: relative">
                            <div class="donut-chart-center" id="challenge-detailview-socialnetworks-ratio"></div>
                        </div>
                        <div class="line-chart-tooltip align-center" style="display: none;">
                            <span class="title"></span>
                            <span class="info line-1"></span>
                            <div class="line-chart-tooltip-anchor"></div>
                        </div>
                        
                        <ul id="challenge-detailview-socialnetworks-legend" class="graph-legend"></ul>
                    </div>
                    <div class="dnnClear"></div>
                </div>
                <% } %>
                <div class="challenge-detailview-segment" data-bind="with: participatingUsers">
                    <h3><%= Localization.GetString("Users", LocalResourceFile) %></h3>
                    <div class="two-columns">
                        <table class="leftside">
                            <colgroup>
                                <col class="col-avatar" />
                                <col class="col-name" />
                                <col class="col-info" />
                            </colgroup>
                            <thead>
                                <tr>
                                    <th colspan="2"><a>Accepted</a></th>
                                    <th><a>Pts</a></th>
                                </tr>
                            </thead>
                            <tbody data-bind="foreach: topAcceptedUsers">
                                <tr data-bind="click: navigate">
                                    <td>
                                        <div class="useravatar">
                                            <span><em>
                                                <img data-bind="attr: { 'src': avatarUrl, 'alt': displayName, 'title': displayName }" /></em></span>
                                        </div>
                                    </td>
                                    <td><span data-bind="html: displayName"></span></td>
                                    <td><span data-bind="html: value"></span></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>

                    <div class="two-columns">
                        <table class="rightside">
                            <colgroup>
                                <col class="col-avatar" />
                                <col class="col-name" />
                                <col class="col-info" />
                            </colgroup>
                            <thead>
                                <tr>
                                    <th colspan="2"><a>Completed</a></th>
                                    <th><a>Pts</a></th>
                                </tr>
                            </thead>
                            <tbody data-bind="foreach: topCompletedUsers">
                                <tr>
                                    <td>
                                        <div class="useravatar">
                                            <span><em>
                                                <img data-bind="attr: { 'src': avatarUrl, 'alt': displayName, 'title': displayName }" /></em></span>
                                        </div>
                                    </td>
                                    <td><span data-bind="html: displayName"></span></td>
                                    <td><span data-bind="html: value"></span></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>

                    <div class="dnnClear"></div>
                </div>
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
        </div>
        <div class="dnnRight">
            <% if (Challenge.Approved)
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
            <div class="dnnClear"></div>
        </div>
        <div class="dnnClear">
            <h3>
                <%= Challenge.ContentTitle %>
            </h3>
        </div>
        <div class="dnnMobile-contentBody" id="detailview-content-mobile">
            <div>
                <h3><%= Localization.GetString("Participation", LocalResourceFile) %></h3>
                <div id="challenge-detailview-participation-mobile" class="chart-container" style="margin-top: 20px;">
                    <ul id="challenge-detailview-participation-legend-mobile" class="graph-legend" style="float: left; margin-bottom: 20px;"></ul>
                    <div class="dnnClear">
                        <svg class="line-chart"></svg>
                    </div>
                </div>
                
                <div class="chart-summary dnnClear">
                    <div>
                        <span class="summary-title"><%= Localization.GetString("Invited", LocalResourceFile) %></span>
                        <span><%= ChallengeAnalysisData.Invited %></span>
                        <div class="dnnClear"></div>
                    </div>
                    <div>
                        <span class="summary-title"><%= Localization.GetString("Accepted", LocalResourceFile) %></span>
                        <span><%= ChallengeAnalysisData.Accepted %><sup>%</sup></span>
                        <div class="dnnClear"></div>
                    </div>
                    <div>
                        <span class="summary-title"><%= Localization.GetString("Completed", LocalResourceFile) %></span>
                        <span><%= ChallengeAnalysisData.Completed %><sup>%</sup></span>
                        <div class="dnnClear"></div>
                    </div>
                    <asp:PlaceHolder runat="server" ID="phInboundSharingMobile">
                        <div>
                            <span class="summary-title"><%= Localization.GetString("NewAdopters", LocalResourceFile) %></span>
                            <span><%= ChallengeAnalysisData.NewAdopters %></span>
                            <div class="dnnClear"></div>
                        </div>
                        <div>
                            <span class="summary-title"><%= Localization.GetString("UniqueClicks", LocalResourceFile) %></span>
                            <span><%= ChallengeAnalysisData.UniqueClicks %></span>
                            <div class="dnnClear"></div>
                        </div>
                    </asp:PlaceHolder>
                    <div>
                        <span class="summary-title"><%= Localization.GetString("NewParticipants", LocalResourceFile) %></span>
                        <span><%= ChallengeAnalysisData.NewParticipants %><sup>%</sup></span>
                        <div class="dnnClear"></div>
                    </div>
                    <div>
                        <span class="summary-title"><%= Localization.GetString("NewCompletionists", LocalResourceFile) %></span>
                        <span><%= ChallengeAnalysisData.NewCompletionists %><sup>%</sup></span>
                        <div class="dnnClear"></div>
                    </div>
                </div>
            </div>
            <% if (false) //SOCIAL-3497 Removed to be added back in a later revision
               { %>
            <div class="challenge-detailview-segment">
                <h3><%= Localization.GetString("SocialBreakdown", LocalResourceFile) %></h3>
                <div id="challenge-detailview-socialfollowers-mobile" class="chart-container donut-chart-container">
                    <div class="dnnClear" id="challenge-detailview-socialfollowers-svg-mobile" style="position: relative">
                        <div class="donut-chart-center" id="challenge-detailview-socialfollowers-ratio-mobile"></div>
                    </div>
                    <ul id="challenge-detailview-socialfollowers-legend-mobile" class="graph-legend"></ul>
                </div>

                <div id="challenge-detailview-socialnetworks-mobile" class="chart-container donut-chart-container">
                    <div class="dnnClear" id="challenge-detailview-socialnetworks-svg-mobile" style="position: relative">
                        <div class="donut-chart-center" id="challenge-detailview-socialnetworks-ratio-mobile"></div>
                    </div>
                    <ul id="challenge-detailview-socialnetworks-legend-mobile" class="graph-legend"></ul>
                </div>
                
                <div class="dnnClear"></div>
            </div>
            <% } %>

            <div class="challenge-detailview-segment" data-bind="with: participatingUsers">
                <h3><%= Localization.GetString("Users", LocalResourceFile) %></h3>
                <div class="two-columns" style="width: 100%">
                    <table>
                        <colgroup>
                            <col class="col-avatar" />
                            <col class="col-name" />
                            <col class="col-info" />
                        </colgroup>
                        <thead>
                            <tr>
                                <th colspan="2"><a>Accepted</a></th>
                                <th><a></a></th>
                            </tr>
                        </thead>
                        <tbody data-bind="foreach: topAcceptedUsers">
                            <tr data-bind="click: navigate">
                                <td>
                                    <div class="useravatar">
                                        <span><em>
                                            <img data-bind="attr: { 'src': avatarUrl, 'alt': displayName, 'title': displayName }" /></em></span>
                                    </div>
                                </td>
                                <td><span data-bind="html: displayName"></span></td>
                                <td><span data-bind="html: value"></span></td>
                            </tr>
                        </tbody>
                    </table>
                </div>

                <div class="two-columns" style="width: 100%">
                    <table>
                        <colgroup>
                            <col class="col-avatar" />
                            <col class="col-name" />
                            <col class="col-info" />
                        </colgroup>
                        <thead>
                            <tr>
                                <th colspan="2"><a>Completed</a></th>
                                <th><a></a></th>
                            </tr>
                        </thead>
                        <tbody data-bind="foreach: topCompletedUsers">
                            <tr>
                                <td>
                                    <div class="useravatar">
                                        <span><em>
                                            <img data-bind="attr: { 'src': avatarUrl, 'alt': displayName, 'title': displayName }" /></em></span>
                                    </div>
                                </td>
                                <td><span data-bind="html: displayName"></span></td>
                                <td><span data-bind="html: value"></span></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <div class="dnnClear"></div>
            </div>
        </div>
    </div>
    <!-- /ko -->
    <%-- END MOBILE VIEW --%>
    
    <div data-bind="stopBindings: true" class="editor-dialog" style="display: none;">
		<challenges:EditView id="CtlEditor" runat="server" />
	</div>
</asp:Panel>

<script type='text/javascript'>
    function challengeDetailInit(settings) {    
        settings.moduleScope = $(settings.moduleScope)[0];
        if (!settings.moduleScope) {
            return;
        }

        var model = <%= SerializedChallenge() %>;
        try {
            window.dnn.social.applyBindings(new window.dnn.challenges.DetailView(settings, model), settings.moduleScope);
        } catch(ex) {
            window.dnn.social.topLevelExceptionHandler(settings, ex);
        }
    }
</script>
