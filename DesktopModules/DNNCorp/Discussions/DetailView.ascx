<%@ Control Language="C#" AutoEventWireup="false" CodeBehind="DetailView.ascx.cs" Inherits="DotNetNuke.Professional.Discussions.DetailView" %>
<%@ Register TagPrefix="discussions" TagName="EditView" src="~/DesktopModules/DNNCorp/Discussions/Controls/EditView.ascx" %>
<%@ Register TagPrefix="social" TagName="Report" Src="~/DesktopModules/DNNCorp/SocialLibrary/Controls/ReportContent.ascx" %>
<%@ Register TagPrefix="social" TagName="Comments" Src="~/DesktopModules/DNNCorp/SocialLibrary/Controls/CommentsControl.ascx" %>
<%@ Register TagPrefix="social" TagName="LikeControl" Src="~/DesktopModules/DNNCorp/SocialLibrary/Controls/LikeControl.ascx" %>
<%@ Register TagPrefix="social" TagName="ContentExchange" Src="~/DesktopModules/DNNCorp/SocialLibrary/Controls/ContentExchange.ascx" %>

<%@ Import Namespace="DotNetNuke.Services.Localization" %>
<%@ Import Namespace="DotNetNuke.SocialLibrary.Components.Common" %>
<asp:Panel runat="server" ID="ScopeWrapper" CssClass="moduleContainer dnnClear">
    
    <%-- NORMAL VIEW --%>
    <!-- ko ifnot: isMobileView -->
    <div class="moduleContainer-normalView ko-container">
	    <div class="moduleTitleContainer detail-container dnnClear">
	        <% if (Model.Topic.Pinned)
	           { %>
            <div class="status-indicator activeIndicator dnnLeft static-row">           
			    <img src="<%= ResolveUrl("~/DesktopModules/DNNCorp/Discussions/images/pinned.png") %>" title="<%= LocalizeString("Pinned") %>" alt=""/> 
		    </div>
            <% }else{ %>
            <div class="status-indicator inactiveIndicator dnnLeft static-row"></div>
            <% } %>
            <!-- ko if: model.pinned -->
		    <div class="status-indicator activeIndicator dnnLeft ko-container">           
			    <img src="<%= ResolveUrl("~/DesktopModules/DNNCorp/Discussions/images/pinned.png") %>" title="<%= LocalizeString("Pinned") %>" alt=""/> 
		    </div>
		    <!-- /ko -->
		    <!-- ko ifnot: model.pinned -->
		    <div class="status-indicator inactiveIndicator dnnLeft ko-container"></div>
		    <!-- /ko -->
		    <div class="title-container dnnLeft">
			    <h3><%= Model.Topic.ContentTitle %></h3>
			    <p class="title-returnPrev"><asp:HyperLink runat="server" ID="hlReturn" resourcekey="hlReturn" /></p>
		    </div>
		    <div class="dnnRight">
		    <% if (Model.Topic.Approved)
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
                        <span><%= DateFromUtc(Model.Topic.CreatedOnDate, ModuleContext.PortalSettings.UserInfo.Profile.PreferredTimeZone).ToShortDateString() %></span>
                    </li>
                    <li>
                        <span><%= Model.Topic.ViewCount %> </span>                        
                        <span><%= Localization.GetString(Model.Topic.ViewCount == 1 ? "View" : "Views", LocalResourceFile) %></span>
                    </li>
			    </ul>
			    <ul class="dnnRight">
				    <li> 
                        <span data-bind="html: commentCount"></span>
                        <%= Localization.GetString("Comments", LocalResourceFile) %></li>
				    <li>
					    <%= Localization.GetString("LastActivity", LocalResourceFile) %>
					    <span><%= Model.Topic.LastActiveRelativeDate %></span>, 
					    <a class="dnnSocialLink" href="<%= Model.Topic.LastActiveProfileUrl %>">
						    <%= Model.Topic.LastActiveDisplayName %>
					    </a>
				    </li>
			    </ul>
			    <div class="dnnClear">
				    <% if (Model.Topic.Tags.Any())
                       { %>
                    <span class="list-row-label"><%= LocalizeString("Tags") %>:</span>
                    <ul class="list-row-tags">
                        <% foreach (var tag in Model.Topic.Tags)
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
			    <div class="detail-avatar-container">
				    <div class="avatar40">
                        <span>
                            <em>
                                <img src="<%= ResolveUrl(Evoq.Common.Utilities.GetProfileAvatar(Model.Topic.CreatedByUser, 40, 40)) %>" title="<%= Model.Topic.AuthorDisplayName %>" alt="<%= Model.Topic.AuthorDisplayName %>"/>
                            </em>
                        </span>						
				    </div>
			    </div>
			    <div class="answer-content highlight-content">
			        <% if (ShowEditControl) { %>
			        <div class="comment-actions-menu" id="detail-content-moderator-menu">
                        <a href="javascript:void(0)" class="comment-actions"></a>
                        <ul class="comment-actions-dropdown">
                            <% if (CanModerate) { %>
                                <li><a data-bind="click: moveContent"><%= LocalizeString("MoveTopic") %></a></li>
                                <li><a data-bind="click: copyContent"><%= LocalizeString("CopyTopic") %></a></li>
                                <li><a data-bind="click: moveContentToComment"><%= LocalizeString("MoveTopicToComment") %></a></li>
                            <% } %>
                            <% if (HasEditTopic) { %>
                            <li><a data-bind="click: edit" title="<%= LocalizeString("Edit") %>"><%= LocalizeString("Edit") %></a></li>
                            <% } %>
                        
                            <% if (HasPinTopic && !Model.Topic.Closed) { %>
                            <li>
                                <!-- ko if: model.pinned -->
					            <a data-bind="click: model.pin" title="<%= LocalizeString("UnPinHelp") %>"><%= LocalizeString("Unpin") %></a>
					            <!-- /ko -->
					            <!-- ko ifnot: model.pinned -->
					            <a data-bind="click: model.pin" title="<%= LocalizeString("PinHelp") %>"><%= LocalizeString("Pin") %></a>
					            <!-- /ko -->
                            </li>
                            <% } %>
                            
                            <% if (HasLockTopic) { %>
                            <li>
                                <!-- ko if: model.closed -->
					            <a data-bind="click: model.lock" title="<%= LocalizeString("UnLockHelp") %>"><%= LocalizeString("Unprotect") %></a>
					            <!-- /ko -->
					            <!-- ko ifnot: model.closed -->
					            <a data-bind="click: model.lock" title="<%= LocalizeString("LockHelp") %>"><%= LocalizeString("Protect") %></a>
					            <!-- /ko -->
                            </li>
                            <% } %>

                            <% if (HasEditTopic && !Model.Topic.Closed) { %>
                            <li><a href="javascript:void(0)" id="deleteTopic" title="<%= LocalizeString("Remove") %>"><%= LocalizeString("Remove") %></a></li>
                            <% } %>
                        </ul>
                    </div>
                    <% } %>
				    <span class="detail-comments-author">
					    <a href="<%= Model.Topic.AuthorUrl %>" class="dnnSocialLink">
						    <%= Model.Topic.AuthorDisplayName %>
					    </a>
				    </span>
				    <span class="detail-comments-date">
					    <%= Model.Topic.CreatedRelativeDate %>
				    </span>
				    <div class="answer-comments-content" id="detailview-content-normal">
				    </div>
                    <% if (Model.Topic.Attachments.Any())
                       { %>
                    <div class="detail-attachments-area" data-bind="visible: model.attachments().length > 0">
                        <div class="detail-attachments-collapsed" data-bind="visible: hideAttachments">
                            <span data-bind="html: attachmentsHtml"></span>
                        </div>
                        <ul class="detail-attachments-expanded" data-bind="foreach: model.attachments, slideVisible: !hideAttachments()">
                            <li>
                                <% if (HasEditTopic && CanAddAttachments)
                                   { %>
                                <a class="detail-attachments-delete" data-bind="click: $root.removeAttachment"></a>
                                <% } %>
                                <span>Attachment: </span><a data-bind="html: fileName, attr: { 'href': fileUrl, 'target': '_blank' }"></a>
                            </li>
                        </ul>
                        <a class="detail-attachments-arrow detail-attachments-toggle" data-bind="css: { 'up' : hideAttachments(), 'down': !hideAttachments() }, visible: showToggleAttachments"></a>
                    </div>
                    <% } %>
                    <% if (Model.Topic.Approved)
                        { %>
                        <ul class="detail-bottom-social-actions static-row">
                            <% if (!Model.Topic.Closed)
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
                            <% if (!Model.Topic.Closed)
                               { %>
                            <li>
                                <a class="idea-report dnnSocialLink">
                                    <span><%= LocalizeString("Report") %></span>
                                </a>
                            </li>
                            <% } %>
                        </ul>
					    <ul class="detail-bottom-social-actions ko-container">
					        <!-- ko ifnot: model.closed -->
						    <li>
							    <a data-bind="click: reply" class="idea-reply dnnSocialLink">
								    <span><%= LocalizeString("Reply") %></span>
							    </a>
						    </li>
						    <!-- /ko -->
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
                            <!-- ko ifnot: model.closed -->
						    <li>
							    <a href="javascript:void(0)" data-bind="click: report" class="idea-report dnnSocialLink">
								    <%= LocalizeString("Report") %>
							    </a>
						    </li>  
                            <!-- /ko -->                     
					    </ul>
                        <div class="dnnClear likes" data-bind="html: model.likeString().Big, attr: { id: model.getLikeControlId() } "></div>
                    <% } %>
				    <div class="dnnClear"></div>
			    </div>
			    <div class="dnnClear"></div>
		    </div>
		    <a id="comments"></a>		           
		    <div class="dnnClear">
                <div class="comments-container-normalview"></div>
		        <!-- ko if: model.closed -->
		        <div class="dnnClear ko-container">
			        <div class="dnnFormMessage" style="margin: 0">
                        <%= LocalizeString("ProtectedTopic") %>
			        </div>
		        </div>
		        <!-- /ko -->
		    </div>	    	
            <% if (!Model.Topic.Approved || Model.Topic.Protected)
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
            <%  if (Model.Topic.Approved)
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
            <div class="dnnClear">
                <span class="idea-numberOfVotes" data-bind="text: model.viewCount"></span>
                <!-- ko if: model.viewCount() === 1 -->
                <span><%= Localization.GetString("View", LocalResourceFile) %></span>
                <!-- /ko -->
                <!-- ko if: model.viewCount() !== 1 -->
                <span><%= Localization.GetString("Views", LocalResourceFile) %></span>
                <!-- /ko -->
                <span> - </span>
                <span data-bind="text: model.likes"></span>
                <!-- ko if: model.likes() === 1 -->
                <span><%= Localization.GetString("Like", LocalResourceFile) %></span>
                <!-- /ko -->
                <!-- ko if: model.likes() !== 1 -->
                <span><%= Localization.GetString("Likes", LocalResourceFile) %></span>
                <!-- /ko -->
            </div>
        </div>
        
        <div class="dnnClear">
            <h3>
                <%= Model.Topic.ContentTitle %>
            </h3>
        </div>
        
        <div class="dnnClear">
            <div class="avatar40">
                <span>
                    <em>
                        <img src="<%= ResolveUrl(Evoq.Common.Utilities.GetProfileAvatar(Model.Topic.CreatedByUser, 40, 40)) %>" alt="<%= Model.Topic.AuthorDisplayName %>" title="<%= Model.Topic.AuthorDisplayName %>" />
                    </em>
                </span>
            </div>
            <div class="comment-info">
                <span class="idea-comments-author"><a href="<%= Model.Topic.AuthorUrl %>"><%= Model.Topic.AuthorDisplayName %></a></span>
                <span class="idea-comments-date"><%= Model.Topic.CreatedRelativeDate %></span>
            </div>
        </div>
        
        <div class="dnnMobile-contentBody dnnClear" id="detailview-content-mobile">
        </div>

        <% if (Model.Topic.Attachments.Any())
            { %>
        <div class="dnnMobile-detail-attachments-area" data-bind="visible: model.attachments().length > 0">
            <div class="dnnMobile-detail-attachments-title">
                <span class="dnnMobile-attachments-pin"></span><span data-bind="html: attachmentsHtmlMobileView"></span>
            </div>
            <ul class="dnnMobile-detail-attachments-expanded" data-bind="foreach: model.attachments, slideVisible: !hideAttachmentsMobileView()">
                <li>
                    <a data-bind="html: fileName, attr: { 'href': fileUrl, 'target': '_blank' }"></a>
                </li>
            </ul>
        </div>
        <% } %>

        <% if (Model.Topic.Approved)
        { %>
        
        <ul class="dnnMobile-ideaActions loading-container loading">
            <!-- ko ifnot: model.closed -->
            <li>
                <a data-bind="click: reply" class="idea-reply"></a>
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

        <a id="commentsMobileView"></a>
        <!-- ko if: showCommentsTitle -->
        <div class="dnnMobile-subHeader">
            <h3>
                <%= Localization.GetString("Replies", LocalResourceFile) %>
            </h3>
        </div>
        <!-- /ko -->
        <div class="comments-container-mobileview"></div>
    </div>
    <!-- /ko -->
    <%-- END MOBILE VIEW --%>

	<div data-bind="stopBindings: true" class="editor-dialog" style="display: none;">
		<discussions:EditView ID="CtlEditor" runat="server" />
	</div>
	<social:Report ID="CtlReport" runat="server" />
    <social:ContentExchange ID="CtlContentExchange" runat="server" />
    <social:LikeControl ID="CtlLike" runat="server" />
    <div class="comments-container-common">
        <% if (Model.Topic.Approved && !Model.Topic.Protected)
            { %>
        <social:Comments runat="server" ID="CtlComments" />
          <% } %>
    </div>
    <div id="detailview-content-common" style="display: none">
        <%= Utilities.FixDoublEntityEncoding(Model.Topic.Content) %>
    </div>
</asp:Panel>

<input type="hidden" name="evoq_social_tab_id" value="<%= ModuleContext.TabId %>"/>
<input type="hidden" name="evoq_social_module_id" value="<%= ModuleContext.ModuleId %>"/>
<input type="hidden" name="evoq_social_contentitem_id" value="<%= Model.Topic.ContentItemId %>"/>
<script type='text/javascript'>
    dnn.social.loading('<%= ScopeWrapper.ClientID %>', function() {
        var html = document.getElementById('detailview-content-common').innerHTML;
        document.getElementById('detailview-content-normal').innerHTML = html;
    });
    function discussionsDetailInit(settings) {
        settings.moduleScope = $(settings.moduleScope)[0];	
        if (!settings.moduleScope) {
            return;
        }

		var model = <%= SerializedModelTopicInfo() %>;
        try {
            window.dnn.social.applyBindings(new window.dnn.discussions.DetailView(settings, model), settings.moduleScope);
        } catch(ex) {
            window.dnn.social.topLevelExceptionHandler(settings, ex);
        }  
	}
</script>  