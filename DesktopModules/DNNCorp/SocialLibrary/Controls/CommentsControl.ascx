<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="CommentsControl.ascx.cs" Inherits="DotNetNuke.SocialLibrary.Controls.CommentsControl" %>
<%@ Import Namespace="DotNetNuke.Common.Utilities" %>
<%@ Import Namespace="DotNetNuke.SocialLibrary" %>
<%@ Register TagPrefix="social" TagName="CommentCard" Src="CommentCard.ascx" %>

<div data-bind="stopBindings: true">
    <asp:Panel runat="server" ID="ScopeWrapper" CssClass="commentsControl initial-loading">        
        <% if (!Standalone){ %>
        
            <% if (!ReadOnly){ %>
        
            <!-- ko if: isMobileView -->
            <div class="comment-post dnnMobile-comment-post" data-bind="with: poster, slideVisible: poster.authoring">
                <div class="dnnFormItem">
                    <div data-bind="<%=CommentValueBinding%>, attr: {contenteditable: authoring}" class="message"></div>
                </div>
                <ul class="dnnActions answer-post-actions">
                    <li><a data-bind="click: post" class="dnnPrimaryAction"><%= LocalizeString("Reply") %></a></li>
                    <li><a data-bind="click: cancel" class="dnnSecondaryAction"><%= LocalizeString("Cancel") %></a></li>
                </ul>
            </div>
            <!-- /ko -->

            <% } %>

        <!-- ko ifnot: isMobileView -->
        <!-- ko if: totalResults() > 1 -->
        <div class="comment-load-more">
            <!-- ko if: rolledup -->
            <a data-bind="visible: $root.moreAvailable, click: $root.more"><%= LocalizeString("ViewAllComments") %></a>
            <span>-</span>
            <span data-bind="html: $root.totalComments"></span>
            <!-- /ko -->

            <a class="dnnSocialLink sort" data-bind="click: function() { sortAllComments(true); }, css: { selected: mostRecentFirst }"><%=LocalizeString("Newest") %></a>
            <a class="dnnSocialLink sort" data-bind="click: function() { sortAllComments(false); }, css: { selected: !mostRecentFirst() }"><%=LocalizeString("Oldest") %></a>            

            <div class="dnnClear"></div>
        </div>
        <!-- /ko -->
        <!-- /ko -->

        <!-- ko foreach: comments -->
        <!-- ko ifnot: $root.isMobileView -->
        <div class="inline-comment comment dnnClear" data-bind="attr: { id: 'social-comment-' + commentId() }">
            <div class="comment-inline-container">
                <div class="avatar40">
                    <span>
                        <em>
                            <img data-bind="attr: { src: avatarUrl, alt: authorDisplayName, title: authorDisplayName }" />
                        </em>
                    </span>
                </div>
                <div class="comment-inline-detail">
                    <% if (!ReadOnly)
                       { %>
                    <!-- ko if: canEdit() || canDelete() || canModerate() -->
                    <div class="comment-actions-menu">
                        <a href="javascript:void(0)" class="comment-actions"></a>
                        <ul class="comment-actions-dropdown">
                            <!-- ko if: canEdit -->
                            <% if(AllowContentExchange && CanModerate) 
                               { %>
                                <li><a data-bind="click: moveComment"><%= LocalizeString("MoveComment") %></a></li>
                                <li><a data-bind="click: copyComment"><%= LocalizeString("CopyComment") %></a></li>   
                            <% } %>
                            <li><a data-bind="click: edit"><%= LocalizeString("Edit") %></a></li>
                            <!-- /ko -->
                            <!-- ko ifnot: approved -->
                            <!-- ko if: canModerate-->
                            <li><a data-bind="click: approve"><%= LocalizeString("Approve") %></a></li>
                            <!-- /ko -->
                            <!-- /ko -->
                            <!-- ko if: canDelete -->
                            <li><a data-bind="click: remove"><%= LocalizeString("Remove") %></a></li>
                            <!-- /ko -->
                        </ul>
                    </div>
                    <!-- /ko -->
                    <% } %>
                    <!-- ko ifnot: approved -->
                    <div class="comment-actions-menu">
                        <a href="javascript:void(0)" class="approve-comment-actions"></a>
                    </div>
                    <!-- /ko -->

                    <div class="comment-inline-author">
                        <a data-bind="click: navigateToAuthor" class="dnnSocialLink">
                            <span data-bind="text: authorDisplayName"></span>
                        </a>
                        <span class="comment-inline-date" data-bind="text: relativeDate"></span>
                    </div>

                    <div class="comment-inline-content" data-bind="html: decodedContent"></div>

                    <ul class="comment-inline-actions comment-actions dnnClear">
                        <% if (!ReadOnly)
                           { %>
                        <li>
                            <a data-bind="click: reply" class="dnnSocialLink comment-reply">
                                <span><%= LocalizeString("Reply") %></span>
                            </a>
                        </li>
                        <% } %>
                        <li>
                            <a data-bind="click: toggleLike, attr: { 'class': 'dnnSocialLink ' + likeClass() }">
                                <!-- ko if: liked -->
                                <span><%= LocalizeString("Unlike") %></span>
                                <!-- /ko -->
                                <!-- ko ifnot: liked -->
                                <span><%= LocalizeString("Like") %></span>
                                <!-- /ko -->
                            </a>
                        </li>
                        <% if (!ReadOnly)
                            { %>
                        <li>
                            <a data-bind="click: report" class="dnnSocialLink comment-report">
                                <span><%= LocalizeString("Report") %></span>
                            </a>
                        </li>
                        <% } %>
                    </ul>
                    <div class="dnnClear likes" data-bind="html: likeString().Big, attr: { id: getLikeControlId() }"></div>
                    <div class="dnnClear comment-inline-post" data-bind="with: poster, slideVisible: poster.authoring">
                        <div class="dnnFormItem">
                            <div data-bind="<%=CommentValueBinding%>, escapeKey: cancel, valueUpdate: 'afterkeydown', attr: {contenteditable: authoring}" class="message inline-message"></div>
                        </div>
                        <ul class="dnnActions dnnLeft">
                            <li><a data-bind="click: post" class="dnnPrimaryAction"><%= LocalizeString("Reply") %></a></li>
                            <li><a data-bind="click: cancel" class="dnnSecondaryAction"><%= LocalizeString("Cancel") %></a></li>
                        </ul>
                    </div>
                    <div class="dnnClear"></div>
                </div>
            </div>
        </div>
        <!-- /ko -->
        
        <!-- ko if: $root.isMobileView -->
        <div class="dnnMobile-comment">
            <a data-bind="click: navigateToAuthor, text: authorDisplayName"></a>
            <span class="dnnMobile-comment-inline-date" data-bind="text: relativeDate"></span>
            <div class="dnnMobile-comment-inline-content" data-bind="html: decodedContent"></div>
            <ul class="dnnMobile-comment-actions dnnMobile-comment-inline-actions">
                <li>
                    <a data-bind="click: toggleLike, attr: { 'class': 'dnnMobile-' + likeClass() }"></a>
                </li>
                <% if (!ReadOnly)
                   { %>
                <li>
                    <a data-bind="click: report" class="dnnMobile-comment-report"></a>
                </li>
                <!-- ko if: canDelete -->
                <li>
                    <a data-bind="click: remove" class="dnnMobile-comment-remove"></a>
                </li>
                <!-- /ko -->
                <% } %>
            </ul>
            <div class="dnnMobileLike likes" data-bind="html: likeString().Small, visible: !poster.authoring(), attr: { id: getLikeControlMobileId() }"></div>
        </div>
        <!-- /ko -->
        <!-- /ko -->
         
        <!-- ko if: rolledup -->
        <!-- ko if: isMobileView -->
        <div class="dnnMobile-comment-load-more" data-bind="visible: $root.moreAvailable">
            <a data-bind="click: $root.more, text: $root.moreText"></a>
        </div>
        <!-- /ko -->
        <!-- /ko -->

        <% } else { %>

        <!-- ko ifnot: isMobileView -->
        <div class="comment-sort comment-container" data-bind="visible: totalResults() > 1">
            <a href="javascript:void(0)" class="dnnSocialLink" data-bind="click: function() { sortComments(true); }, css: { selected: mostRecentFirst }"><%= LocalizeString("Newest") %></a>
            <span class="separator"></span>
            <a href="javascript:void(0)" class="dnnSocialLink" data-bind="click: function() { sortComments(false); }, css: { selected: !mostRecentFirst() }"><%= LocalizeString("Oldest") %></a>
        </div>
        <!-- ko foreach: comments -->
        <div class="comment dnnClear" data-bind="attr: { id: 'social-comment-' + commentId() }">
            <div class="comment-container">
                <div class="avatar40">
                    <span>
                        <em>
                            <img data-bind="attr: { src: avatarUrl, title: authorDisplayName, alt: authorDisplayName }" />
                        </em>
                    </span>
                </div>
                <div class="comment-detail">
                    <% if (!ReadOnly)
                       { %>
                    <!-- ko if: canEdit() || canDelete() || canModerate() -->
                    <div class="comment-actions-menu">
                        <a href="javascript:void(0)" class="comment-actions"></a>
                        <ul class="comment-actions-dropdown">
                            <!-- ko if: canEdit -->
                            <% if (AllowContentExchange && CanModerate) 
                               { %>
                                <li><a data-bind="click: moveComment"><%= LocalizeString("MoveComment") %></a></li>
                                <li><a data-bind="click: copyComment"><%= LocalizeString("CopyComment") %></a></li>   
                            <% } %>
                            <li><a data-bind="click: edit"><%= LocalizeString("Edit") %></a></li>
                            <!-- /ko -->
                            <!-- ko ifnot: approved -->
                            <!-- ko if: canModerate-->
                            <li><a data-bind="click: approve"><%= LocalizeString("Approve") %></a></li>
                            <!-- /ko -->
                            <!-- /ko -->
                            <!-- ko if: canDelete -->
                            <li><a data-bind="click: remove"><%= LocalizeString("Remove") %></a></li>
                            <!-- /ko -->
                        </ul>
                    </div>
                    <!-- /ko -->
                    <% } %>
                    <!-- ko ifnot: approved -->
                    <div class="comment-actions-menu">
                        <a href="javascript:void(0)" class="approve-comment-actions">
                            <div class="tag-menu" style="display: none"><%= LocalizeString("UnapprovedComment") %></div>
                        </a>
                    </div>
                    <!-- /ko -->

                    <span class="comment-author">
                        <a href="javascript:void(0)" data-bind="click: navigateToAuthor" class="dnnSocialLink">
                            <span data-bind="text: authorDisplayName"></span>
                        </a>
                    </span>
                    <span class="comment-date" data-bind="text: relativeDate"></span>
                    <div class="comment-content" data-bind="html: decodedContent">
                    </div>
                    
                    
                    <ul class="comment-actions">
                        <!-- ko if: approved -->
                        <% if (!ReadOnly)
                           { %>
                        <li>
                            <a data-bind="click: reply" class="dnnSocialLink comment-reply">
                                <span><%= LocalizeString("Reply") %></span>
                            </a>
                        </li>
                        <% } %>
                        <li>
                            <a data-bind="click: toggleLike, attr: { 'class': 'dnnSocialLink ' + likeClass() }">
                                <!-- ko if: liked -->
                                <span><%= LocalizeString("Unlike") %></span>
                                <!-- /ko -->
                                <!-- ko ifnot: liked -->
                                <span><%= LocalizeString("Like") %></span>
                                <!-- /ko -->
                            </a>
                        </li>
                        <% if (!ReadOnly)
                           { %>
                        <li>
                            <a data-bind="click: report" class="dnnSocialLink comment-report">
                                <span><%= LocalizeString("Report") %></span>
                            </a>
                        </li>
                        <% } %>
                         <!-- /ko -->
                    </ul>
                   
                    <div class="dnnClear likes" data-bind="html: likeString().Big, attr: { id: getLikeControlId() }"></div>
                    <div class="dnnClear comment-post" data-bind="with: poster, slideVisible: poster.authoring">
                        <div class="dnnFormItem">
                            <div data-bind="<%=CommentValueBinding%>, escapeKey: cancel, valueUpdate: 'afterkeydown', attr: {contenteditable: authoring}" class="message"></div>
                        </div>
                        <ul class="dnnActions dnnLeft">
                            <li><a data-bind="click: post" class="dnnPrimaryAction"><%= LocalizeString("Reply") %></a></li>
                            <li><a data-bind="click: cancel" class="dnnSecondaryAction"><%= LocalizeString("Cancel") %></a></li>
                        </ul>
                    </div>
                    <div class="dnnClear"></div>
                </div>
            </div>
        </div>
        <!-- /ko -->
        <!-- /ko -->

        <!-- ko if: isMobileView -->
        <!-- ko foreach: commentsMobileView -->
        <div class="dnnClear">
            <div class="avatar40">
                <span>
                    <em>
                        <img data-bind="attr: { src: avatarUrl, alt: authorDisplayName, title: authorDisplayName }" />
                    </em>
                </span>
            </div>
            <div class="comment-info">
                <span class="comment-author">
                    <a href="javascript:void(0)" data-bind="click: navigateToAuthor">
                        <span data-bind="text: authorDisplayName"></span>
                    </a>
                </span>
                <span class="comment-date" data-bind="text: relativeDate"></span>
            </div>
        </div>
        <div class="comment-content" data-bind="html: decodedContent"></div>
      
        <ul class="dnnMobile-comment-actions">
            <!-- ko if: approved -->
            <% if (!ReadOnly)
               { %>
            <li>
                <a data-bind="click: reply, attr: { 'class' : 'dnnMobile-comment-reply' + authoringClass() }" class="dnnMobile-comment-reply"></a>
            </li>
            <% } %>
            <li>
                <a data-bind="click: toggleLike, attr: { 'class': 'dnnMobile-' + likeClass() }"></a>
            </li>
            <% if (!ReadOnly)
               { %>
            <li>
                <a data-bind="click: report" class="dnnMobile-comment-report"></a>
            </li>
            <% } %>
            <!-- /ko -->
            <% if (!ReadOnly)
               { %>
            <!-- ko if: canDelete -->
            <li>
                <a data-bind="click: remove" class="dnnMobile-comment-remove"></a>
            </li>
            <!-- /ko -->
            <% } %>
        </ul>
       
        <div class="dnnMobileLike likes" data-bind="html: likeString().Small, visible: !poster.authoring(), attr: { id: getLikeControlMobileId() }"></div>
        <div class="comment-post dnnMobile-comment-post dnnMobile-comment-post-reply" data-bind="with: poster, slideVisible: poster.authoring">
            <div class="dnnFormItem">
                <div data-bind="<%=CommentValueBinding%>, escapeKey: cancel, valueUpdate: 'afterkeydown', attr: {contenteditable: authoring}" class="message"></div>
            </div>
            <ul class="dnnActions answer-post-actions">
                <li><a data-bind="click: post" class="dnnPrimaryAction"><%= LocalizeString("Reply") %></a></li>
                <li><a data-bind="click: cancel" class="dnnSecondaryAction"><%= LocalizeString("Cancel") %></a></li>
            </ul>
        </div>
        <!-- /ko -->
        <!-- /ko -->

        <% } %>

        <% if (Standalone){ %>

            <% if (!ReadOnly)
               { %>
        
        <% if (!InlineLogin){ %>

        <!-- ko if: isMobileView -->
        <div class="dnnClear">
            <a class="dnnPrimaryAction dnnMobile-comment-button" data-bind="click: poster.toggle, visible: showMobileCommentButton">comment</a>
            <a class="dnnSecondaryAction dnnMobile-comment-viewmore-button" data-bind="visible: showPagerMobileView, click: next">view more</a>
        </div>
        <div class="comment-post dnnMobile-comment-post" data-bind="with: poster, slideVisible: poster.authoring">
            <div class="dnnFormItem">
                <div data-bind="<%=CommentValueBinding%>, attr: {contenteditable: authoring}" class="message"></div>
            </div>
            <ul class="dnnActions answer-post-actions">
                <li><a data-bind="click: post" class="dnnPrimaryAction"><%= LocalizeString("Reply") %></a></li>
                <li><a data-bind="click: cancel" class="dnnSecondaryAction"><%= LocalizeString("Cancel") %></a></li>
            </ul>
        </div>
        <!-- /ko -->

        <!-- ko ifnot: isMobileView -->
        <div class="comment-panel moduleTopInsetShadowBox dnnClear">
            <div class="avatar">
                <span><em>
                    <asp:Image ID="imgCurrUsr" runat="server" />
                </em></span>
            </div>
            <div class="dnnLeft">

                <% if (UsePopUp && ModuleContext.PortalSettings.UserInfo.UserID < 1)
                   { %>
                <asp:HyperLink ID="loginLink" class="dnnPrimaryAction comment-button" runat="server"><% = LocalizeString("AddComment") %></asp:HyperLink>
                <% }
                   else
                   { %>
                <a class="dnnPrimaryAction comment-button" data-bind="click: poster.toggle, visible: !poster.authoring()"><%= LocalizeString("AddComment") %></a>
                <% } %>
            </div>

            <div class="comment-post" data-bind="with: poster, slideVisible: poster.authoring">
                <div class="dnnFormItem">
                    <div data-bind="<%=CommentValueBinding%>, attr: {contenteditable: authoring}" class="message"></div>
                </div>
                <ul class="dnnActions dnnLeft answer-post-actions">
                    <li><a data-bind="click: post" class="dnnPrimaryAction"><%= LocalizeString("Reply") %></a></li>
                    <li><a data-bind="click: cancel" class="dnnSecondaryAction"><%= LocalizeString("Cancel") %></a></li>
                </ul>
            </div>

            <div class="comment-pager-rightside" data-bind="visible: showPager">
                <div class="dnnLeft">
                    <ul class="pager-ul" data-bind="html: pagingControl"></ul>
                </div>
                <div class="dnnRight">
                    <div class="dnnPagingCount dnnLeft">
                        <span data-bind="html: formattedResults"></span>
                    </div>
                    <div class="dnnPagingButtons dnnRight">
                        <a data-bind="click: prev, attr: { 'class': 'pager-prev ' + prevClass() }"></a>
                        <a data-bind="click: next, attr: { 'class': 'pager-next ' + nextClass() }"></a>
                    </div>
                </div>
            </div>

            <div class="dnnClear"></div>
        </div>
        <!-- /ko -->
        
         <% } else { %>
        
        <!-- ko ifnot: isMobileView -->
        <div class="comment-panel moduleTopInsetShadowBox dnnClear">
            <div class="comment-pager-rightside" style="margin-bottom: 15px" data-bind="visible: showPager">
                <div class="dnnLeft">
                    <ul class="pager-ul" data-bind="html: pagingControl"></ul>
                </div>
                <div class="dnnRight">
                    <div class="dnnPagingCount dnnLeft">
                        <span data-bind="html: formattedResults"></span>
                    </div>
                    <div class="dnnPagingButtons dnnRight">
                        <a data-bind="click: prev, attr: { 'class': 'pager-prev ' + prevClass() }"></a>
                        <a data-bind="click: next, attr: { 'class': 'pager-next ' + nextClass() }"></a>
                    </div>
                </div>
            </div>
            
            <div class="dnnClear"></div>

            <div class="avatar">
                <span><em>
                    <img src='<%= AnonymouseUserAvatarUrl %>' alt="anonymous" title="anonymous" />
                </em></span>
            </div>

            <div class="comment-post">
                <div class="dnnFormItem" data-bind="with: poster">
                    <div contenteditable="true" data-bind="<%=CommentValueBinding%>" class="message" placeholder="Enter your comments"></div>
                </div>
                
                <% if (ModuleContext.PortalSettings.UserId < 1)
                   { %>

                <div class="comment-inline-login">
                    <div data-bind="visible: inlineLoginAction() === 'registration'">
                        <h4><%= LocalizeString("CommentRegistration") %></h4>
                        <div>
                            <input type="text" placeholder="<%= LocalizeString("CommentRegisterUserName") %>" data-bind="value: inlineRegistrationUserName"/>
                            <label><%= LocalizeString("CommentOptional") %></label>
                        </div>
                        <div>
                            <input type="text" placeholder="<%= LocalizeString("CommentEmail") %>" data-bind="value: inlineRegistrationEmail"/>
                            <label><%= LocalizeString("CommentRequired") %></label>
                        </div>
                    </div>
                    
                    <div data-bind="visible: inlineLoginAction() === 'login'">
                        <h4><%= LocalizeString("CommentSignIn") %></h4>
                        <div>
                            <input type="text"  placeholder="<%= LocalizeString("CommentUserName") %>" data-bind="value: inlineLoginUserName"/>
                        </div>
                        <div>
                            <input type="password"  placeholder="<%= LocalizeString("CommentPassword") %>"  data-bind="value: inlineLoginPassword"/>
                        </div>
                    </div>

                    <div>
                        <label><b><%= LocalizeString("CommentNewUser") %></b></label>
                        <input type="radio" name="rdoCommentInlineLoginAction" value="registration" data-bind="checked: inlineLoginAction" id="rdoCommentInlineLoginAction-registration"/>
                        <label for="rdoCommentInlineLoginAction-registration"><b><%= LocalizeString("Yes") %></b></label>
                        <input type="radio" name="rdoCommentInlineLoginAction" value="login" data-bind="checked: inlineLoginAction" id="rdoCommentInlineLoginAction-login"/>
                        <label for="rdoCommentInlineLoginAction-login"><b><%= LocalizeString("No") %></b></label>
                    </div>

                </div>

                <ul class="dnnActions dnnLeft answer-post-actions" data-bind="with: poster"> 
                    <li><a data-bind="click: inlineLoginPost" class="dnnPrimaryAction"><%= LocalizeString("Reply") %></a></li>
                </ul>
                
                <% }else{ %>
                
                <ul class="dnnActions dnnLeft answer-post-actions" data-bind="with: poster" style="padding: 0"> 
                    <li><a data-bind="click: post" class="dnnPrimaryAction"><%= LocalizeString("Reply") %></a></li>
                </ul>

                
                <% } %>
            </div>
        </div>
        <!-- /ko -->
        
        <!-- ko if: isMobileView -->
         <div class="comment-post dnnMobile-comment-post">
            <div class="dnnFormItem" data-bind="with: poster">
                <div contenteditable="true" data-bind="<%=CommentValueBinding%>" class="message"></div>
            </div>
             
            <% if (ModuleContext.PortalSettings.UserId < 1)
                { %>

            <div class="comment-inline-login">
                <div data-bind="visible: inlineLoginAction() === 'registration'">
                    <h4><%= LocalizeString("CommentRegistration") %></h4>
                    <div>
                        <input type="text" placeholder="<%= LocalizeString("CommentRegisterUserName") %>" data-bind="value: inlineRegistrationUserName"/>
                    </div>
                    <div>
                        <input type="text" placeholder="<%= LocalizeString("CommentEmail") %>" data-bind="value: inlineRegistrationEmail"/>
                    </div>
                </div>
                    
                <div data-bind="visible: inlineLoginAction() === 'login'">
                    <h4><%= LocalizeString("CommentSignIn") %></h4>
                    <div>
                        <input type="text"  placeholder="<%= LocalizeString("CommentUserName") %>" data-bind="value: inlineLoginUserName"/>
                    </div>
                    <div>
                        <input type="password"  placeholder="<%= LocalizeString("CommentPassword") %>"  data-bind="value: inlineLoginPassword"/>
                    </div>
                </div>

                <div>
                    <label><b><%= LocalizeString("CommentNewUser") %></b></label>&nbsp;
                    <a class="dnnMobile-comment-option selected" data-bind="click: function(){ $root.changeInlineLoginAction('registration', event) }" ><%= LocalizeString("Yes") %></a>
                    <a class="dnnMobile-comment-option" data-bind="click: function(){ $root.changeInlineLoginAction('login', event) }" ><%= LocalizeString("No") %></a>
                </div>

            </div>

            <ul class="dnnActions answer-post-actions" data-bind="with: poster">
                <li><a data-bind="click: inlineLoginPost" class="dnnPrimaryAction"><%= LocalizeString("Reply") %></a></li>
            </ul>
               
             <% }else{ %>
             
            <ul class="dnnActions answer-post-actions" data-bind="with: poster">
                <li><a data-bind="click: post" class="dnnPrimaryAction"><%= LocalizeString("Reply") %></a></li>
            </ul>

            <% } %>

        </div>
        <!-- /ko -->
        
        <% } %>

            <% } else { %>

        <!-- ko ifnot: isMobileView -->
        <div class="comment-panel moduleTopInsetShadowBox dnnClear">
            <div class="comment-pager-rightside" data-bind="visible: showPager">
                <div class="dnnLeft">
                    <ul class="pager-ul" data-bind="html: pagingControl"></ul>
                </div>
                <div class="dnnRight">
                    <div class="dnnPagingCount dnnLeft">
                        <span data-bind="html: formattedResults"></span>
                    </div>
                    <div class="dnnPagingButtons dnnRight">
                        <a data-bind="click: prev, attr: { 'class': 'pager-prev ' + prevClass() }"></a>
                        <a data-bind="click: next, attr: { 'class': 'pager-next ' + nextClass() }"></a>
                    </div>
                </div>
            </div>
        </div>
        <!-- /ko -->

            <% } %>

        <% } %>

        <% if (!ReadOnly && !Standalone){ %>
        
        <!-- ko ifnot: isMobileView -->
        <div class="dnnClear comment-inline-post-fake" data-bind="with: poster, visible: !poster.authoring() && comments().length > 0">
            <input type="text" class="inline-poster-fake" value="Add a comment..." data-bind="click: $root.reply" />
        </div>
        <div class="dnnClear comment-inline-post" data-bind="with: poster, slideVisible: poster.authoring">
            <div class="dnnFormItem">
                <div data-bind="<%=CommentValueBinding%>, attr: {contenteditable: authoring}" class="message inline-message inline-comment-message"></div>
                <div>
                    <a class="dnnPrimaryAction" data-bind="click: post"><%= LocalizeString("Reply") %></a>
                    <a class="dnnSecondaryAction" data-bind="click:cancel"><%= LocalizeString("Cancel") %></a>
                </div>
            </div>
        </div>
        <!-- /ko -->

        <% } %>
    
        <social:CommentCard runat="server" ID="ctlCommentCard" />
        <div class="comment-update-dialog" style="display: none;">
            <div class="dnnForm">
                <div class="dnnFormItem">
                    <div contenteditable="true" class="message"></div>
                </div>
            </div>
            <div class="dnnClear dialog-footer">
                <ul class="dnnActions dnnRight">
                    <li><a class="dnnPrimaryAction" data-bind="click: saveUpdate"><%= LocalizeString("Update") %></a></li>
                    <li><a class="dnnSecondaryAction" data-bind="click: cancelUpdate"><%= LocalizeString("Cancel") %></a></li>
                </ul>
            </div>
        </div>
    </asp:Panel>
</div>

<% if (Visible && Bootstrap){ %>
<script type='text/javascript'>
    $(function () {
	    var settings = <%= SocialModule.GetSettingsAsJsonString(ModuleContext) %>;
        settings.journalTypeId = <%= JournalTypeId %>;
        settings.contentItemId = <%= ContentItemId %>;
        settings.objectKey = null;
        settings.canModerate = <%= CanModerate.ToJson() %>;
        settings.moduleScope = $('#<%= ScopeWrapper.ClientID %>')[0];
        settings.pageIndex = <%= PageIndex %>;
        settings.pageSize = <%= PageSize %>;
        settings.parentControlScopeId = '<%= ParentControlScopeId %>';
        settings.actions = {
            'posted': '<%= CommentActions.Added %>',
            'delete': '<%= CommentActions.Deleted %>'
        };
        if (!settings.moduleScope) {
            return;
        }

        settings.hideMobileCommentBtn = <%= HideMobileCommentButton.ToString().ToLowerInvariant() %>;
        try {
            dnn.social.applyBindings(new dnn.social.CommentControl($, ko, settings), settings.moduleScope);
        } catch(ex) {
            dnn.social.topLevelExceptionHandler(settings, ex);
        }
    });
</script>
<% } %>