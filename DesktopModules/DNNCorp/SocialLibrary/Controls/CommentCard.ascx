<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="CommentCard.ascx.cs" Inherits="DotNetNuke.SocialLibrary.Controls.CommentCard" %>
<%@ Import Namespace="DotNetNuke.SocialLibrary" %>

<div data-bind="stopBindings: true">
    <asp:Panel runat="server" ID="ScopeWrapper">
        <div class="comment-context-card">
            <div class="loading" data-bind="fadeVisible: loading"></div>
            <!-- ko ifnot: loading -->
            <div class="close-button">
                <a href="javascript:void(0)" data-bind="click: hide">                   
                </a>
            </div>
            <!-- ko with: profile -->
            <div class="comment-context-card-top">
                <div class="avatar">
                    <span>
                        <em>
                            <img data-bind="attr: { src: avatarUrl, alt: displayName, title: displayName }" />
                        </em>
                    </span>                    
                </div>
                <div class="displayName">
                    <span data-bind="text: displayName"></span>
                    <!-- ko ifnot: $root.userIsDeleted -->
                    <div class="member-since">
                        <%= LocalizeString("MemberJoined") %> <span data-bind="text: relativeMemberSince"></span>
                    </div>
                    <!-- /ko -->
                </div>
                <div class="dnnClear"></div>
            </div>
            <!-- /ko -->
            <div data-bind="fadeVisible: comment() != null">
                <!-- ko if: comment() != null -->
                <div class="comment-date" data-bind="text: '<%= LocalizeString("OriginalComment") %>'.format(comment().relativeDate())"></div>
                <div class="content">
                    <span data-bind="html: commentSummary()"></span>
                </div>
                <a class="see-full-comment" data-bind="visible: commentSummarized, click:seeFullComment"><%= LocalizeString("SeeFullComment") %></a>
                <!-- /ko -->
            </div>
            <div class="comment-context-card-bottom">
            <!-- ko ifnot: userIsDeleted -->
                <!-- ko if: isFollowed -->
                <a href="javascript:void(0)" class="dnnPrimaryAction" data-bind="visible: notMe, click: follow"><%= LocalizeString("UnFollow") %></a>
                <!-- /ko -->
                <!-- ko ifnot: isFollowed -->
                <a href="javascript:void(0)" class="dnnPrimaryAction" data-bind="visible: notMe, click: follow"><%= LocalizeString("Follow") %></a>
                <!-- /ko -->
                <!-- ko with: profile -->
                <a class="see-full-profile" data-bind="attr: { href: profileUrl }"><%= LocalizeString("SeeFullProfile") %></a>
                <!-- /ko -->
            <!-- /ko -->
            </div>
            <!-- /ko -->
        </div>
    </asp:Panel>
</div>
<% if (!Inline)
   { %>
<script type="text/javascript">
    $(function() {
	    var settings = <%= SocialModule.GetSettingsAsJsonString(ModuleContext) %>;
        settings.moduleScope = $('#<%= ScopeWrapper.ClientID %>')[0];
        if (!settings.moduleScope) {
            return;
        }

        var bindedData = window.ko.dataFor(settings.moduleScope);
        if(!bindedData){
            try {
                var social = new dnn.social.Module(settings);
                var hovercard = new dnn.social.HoverCard($, window.ko, settings, social, $('.comment-context-card', settings.moduleScope));
            
                dnn.social.bindCommentContext = function(scope, root) {
                    hovercard.bindScope(scope, root);
                };

                dnn.social.hideCommentContext = function() {
                    hovercard.hide();
                };
           
                window.ko.applyBindings(hovercard, settings.moduleScope);
            } catch(ex) {
                dnn.social.topLevelExceptionHandler(settings, ex);
            }
        }
    });
</script>
<% } %>