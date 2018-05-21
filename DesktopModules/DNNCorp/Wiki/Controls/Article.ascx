<%@ Control Language="C#" AutoEventWireup="false" CodeBehind="Article.ascx.cs" Inherits="DotNetNuke.Professional.Wiki.Controls.Article" %>
<%@ Register TagPrefix="wiki" tagName="ArticleContent" src="ArticleContent.ascx" %>
<%@ Register tagPrefix="wiki" tagName="Revisions" src="Revisions.ascx" %>
<%@ Register TagPrefix="wiki" TagName="ContentEditor" Src="ContentEditor.ascx" %>
<%@ Register TagPrefix="social" TagName="Comments" Src="~/DesktopModules/DNNCorp/SocialLibrary/Controls/CommentsControl.ascx" %>
<%@ Register TagPrefix="social" TagName="Report" Src="~/DesktopModules/DNNCorp/SocialLibrary/Controls/ReportContent.ascx" %>
<%@ Register TagPrefix="social" TagName="LikeControl" Src="~/DesktopModules/DNNCorp/SocialLibrary/Controls/LikeControl.ascx" %>
<%@ Import Namespace="DotNetNuke.Services.Localization" %>

<asp:Panel runat="server" ID="ScopeWrapper" CssClass="dnnClear moduleContainer">
    
    <%-- NORMAL VIEW --%>
    <!-- ko ifnot: isMobileView -->
    <div class="moduleContainer-normalView ko-container">
        <div class="moduleTitleContainer detail-container dnnClear">
            <div class="title-container dnnLeft">
                <h3>
                    <%= ContentTitle %>
                </h3>
                <p class="title-returnPrev">
                    <asp:HyperLink runat="server" ID="hlReturn" resourcekey="hlReturn" />
                </p>
            </div>
            <% if (ArticleApproved)
               { %>
            <div class="dnnRight">
                <ul class="detail-social-actions static-row">
                    <li><a href="javascript:void(0)" class="dnnSocialLike" title="<%= LocalizeString("LikeThis") %>"></a></li>
                    <li><a href="javascript:void(0)" class="dnnSocialBookmark" title="<%= LocalizeString("AddBookmark") %>"></a></li>
                    <li><a href="javascript:void(0)" class="dnnSocialSubscribe" title="<%= LocalizeString("Subscribe") %>"></a></li>
                </ul>
                <ul class="detail-social-actions ko-container">
                    <!-- ko if: model.liked -->
                    <li><a href="javascript:void(0)" data-bind="click: unlike" class="dnnSocialLikeActive" title="<%= LocalizeString("UnlikeThis") %>"></a></li>
                    <!-- /ko -->
                    <!-- ko ifnot: model.liked -->
                    <li><a href="javascript:void(0)" data-bind="click: like" class="dnnSocialLike" title="<%= LocalizeString("LikeThis") %>"></a></li>
                    <!-- /ko -->
                    <!-- ko if: model.bookmarked -->
                    <li><a href="javascript:void(0)" data-bind="click: unbookmark" class="dnnSocialBookmarkActive" title="<%= LocalizeString("RemoveBookmark") %>"></a></li>
                    <!-- /ko -->
                    <!-- ko ifnot: model.bookmarked -->
                    <li><a href="javascript:void(0)" data-bind="click: bookmark" class="dnnSocialBookmark" title="<%= LocalizeString("AddBookmark") %>"></a></li>
                    <!-- /ko -->
                    <!-- ko if: model.subscribed -->
                    <li><a href="javascript:void(0)" data-bind="click: unsubscribe" class="dnnSocialSubscribeActive" title="<%= LocalizeString("Unsubscribe") %>"></a></li>
                    <!-- /ko -->
                    <!-- ko ifnot: model.subscribed -->
                    <li><a href="javascript:void(0)" data-bind="click: subscribe" class="dnnSocialSubscribe" title="<%= LocalizeString("Subscribe") %>"></a></li>
                    <!-- /ko -->
                </ul>
            </div>
            <% } %>
        </div>   
        <div class="moduleThreadContainer moduleTopInsetShadowBox dnnClear">
            <div class="info-panel">
                <% if (!Locked)
                   { %>
                <div class="dnnLeft">
                    <a class="dnnPrimaryAction wiki-edit-button" data-bind="click: edit">
                        <%= LocalizeString("Edit") %>
                    </a>
                </div>
                <% } %>
            
                <ul class="dnnLeft">
                    <li>
                        <span><%= ArticleInfo.CreatedOnDate.ToShortDateString() %></span>
                    </li>
                    <li>
                        <%= ArticleInfo.ViewCount %>
                        <span><%= Localization.GetString(ArticleInfo.ViewCount == 1? "View" : "Views", LocalResourceFile) %></span>                  
                    </li>
                </ul>
            
                <% if (CanModerate)
                   { %>
                <ul class="dnnRight">
                    <li>
                        <a data-bind="click: history">
                            <%= LocalizeString("History") %>
                        </a>
                    </li>
                    <li>
                        <a id="deleteWiki" href="javascript:void(0)">
                            <%= LocalizeString("Delete") %>
                        </a>
                    </li>
                </ul>
                <% } %>

                <div class="dnnClear">
                    <% if (ArticleInfo.Tags.Any())
                       { %>
                    <span class="list-row-label"><%= LocalizeString("Tags") %>:</span>
                    <ul class="list-row-tags">
                        <% foreach (var tag in ArticleInfo.Tags)
                           { %>
                        <li>
                            <a href="<%= tag.TagUrl %>">
                                <%: tag.Name %>
                        </a>
                        </li>
                        <% } %>
                    </ul>
                    <% } %>
                    
                    <div class="dnnRight" style="margin-right: 8px">
                        <a href="javascript:void(0)" data-bind="click: report"><%= LocalizeString("Report") %></a>   
                    </div>
                </div>

            </div>
            <div class="detail-main-container dnnClear" id="detailview-content-normal"></div>
            <div class="likes" data-bind="html: model.likeString().Big, attr: { id: model.getLikeControlId() } "></div>
            <a id="comments"></a>		           
            <div class="wiki-comment-container">
                <h3 data-bind="visible: showCommentsTitle" style="display: none;">
                    <%= LocalizeString("Comments") %>
                </h3>
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
        </div>
        
        <div class="dnnRight">
            <% if (ArticleApproved)
                { %>
             <ul class="loading-container loading dnnMobile-socialActions">
                <!-- ko if: model.liked -->
                <li><a href="javascript:void(0)" data-bind="click: unlike" class="dnnSocialLikeActive" title="<%= LocalizeString("UnlikeThis") %>"></a></li>
                <!-- /ko -->
                <!-- ko ifnot: model.liked -->
                <li><a href="javascript:void(0)" data-bind="click: like" class="dnnSocialLike" title="<%= LocalizeString("LikeThis") %>"></a></li>
                <!-- /ko -->
                <!-- ko if: model.bookmarked -->
                <li><a href="javascript:void(0)" data-bind="click: unbookmark" class="dnnSocialBookmarkActive" title="<%= LocalizeString("RemoveBookmark") %>"></a></li>
                <!-- /ko -->
                <!-- ko ifnot: model.bookmarked -->
                <li><a href="javascript:void(0)" data-bind="click: bookmark" class="dnnSocialBookmark" title="<%= LocalizeString("AddBookmark") %>"></a></li>
                <!-- /ko -->
                <!-- ko if: model.subscribed -->
                <li><a href="javascript:void(0)" data-bind="click: unsubscribe" class="dnnSocialSubscribeActive" title="<%= LocalizeString("Unsubscribe") %>"></a></li>
                <!-- /ko -->
                <!-- ko ifnot: model.subscribed -->
                <li><a href="javascript:void(0)" data-bind="click: subscribe" class="dnnSocialSubscribe" title="<%= LocalizeString("Subscribe") %>"></a></li>
                <!-- /ko -->
            </ul>
             <% } %>
             <div class="dnnClear dnnRight">
                  <span class="idea-title-status"><%= ArticleInfo.ViewCount %></span>
                  <span><%= Localization.GetString(ArticleInfo.ViewCount == 1? "View" : "Views", LocalResourceFile) %></span>   
            </div>
        </div>
        
        <div class="dnnClear">
            <h3>
                <%= ContentTitle %>
            </h3>
        </div>
        
        <div class="dnnClear">
            <span>Last updated <%=  ArticleInfo.LastActiveRelativeDate %></span>
        </div>
        
        <div class="dnnMobile-dashboard-profile-separator"></div>

        <div class="dnnMobile-contentBody dnnClear" id="detailview-content-mobile"></div>

        <div class="dnnMobileLike likes" data-bind="html: model.likeString().Small, attr: { id: model.getLikeControlMobileId() }"></div>
        
        <a id="commentsMobileView"></a>       
        <div class="dnnMobile-subHeader">
            <h3 data-bind="visible: showCommentsTitle" style="display: none;">
                <%= LocalizeString("Comments") %>
            </h3>
        </div>
        <div class="comments-container-mobileview"></div>
    </div>
    <!-- /ko -->
    <%-- END MOBILE VIEW --%>

    <wiki:ContentEditor runat="server" ID="ctlEdit" />
    <social:Report ID="slReport" runat="server" />
    <wiki:Revisions runat="server" ID="ctlHistory" />
    <social:LikeControl ID="ctlLike" runat="server" />
    <div class="wiki-content-common">
        <wiki:ArticleContent runat="server" ID="ctlContent" ShowEditor="False" />
    </div>

    <div class="comments-container-common">
        <social:Comments runat="server" ID="CtlComments" />
    </div>

    <% if (EnableComments &&!ArticleApproved) 
       { %>
    <div class="detail-main-container dnnClear">
        <div class="dnnFormMessage" style="margin: 0">
            <%= LocalizeString("CommentsDisabled") %>
        </div>
    </div>
    <% } %>
</asp:Panel>

<input type="hidden" name="evoq_social_tab_id" value="<%= ModuleContext.TabId %>"/>
<input type="hidden" name="evoq_social_module_id" value="<%= ModuleContext.ModuleId %>"/>
<input type="hidden" name="evoq_social_contentitem_id" value="<%= ArticleInfo.ContentItemId %>"/>
<script type="text/javascript">
    dnn.social.loading('<%= ScopeWrapper.ClientID %>', function () {
        var html = document.getElementById('<%= ScopeWrapper.ClientID %>').getElementsByClassName('wiki-content-common')[0].innerHTML;
        document.getElementById('<%= ScopeWrapper.ClientID %>').getElementsByClassName('detail-main-container')[0].innerHTML = html;
    });
    function wiki_articleInit(settings) {
        settings.moduleScope = $(settings.moduleScope)[0];
        if (!settings.moduleScope) {
            return;
        }

        try {
            window.dnn.social.applyBindings(new window.dnn.wiki.Article(settings, settings.model), settings.moduleScope);
        } catch (ex) {
            window.dnn.social.topLevelExceptionHandler(settings, ex);
        }
    }
</script>