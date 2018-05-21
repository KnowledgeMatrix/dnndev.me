<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="LikeControl.ascx.cs" Inherits="DotNetNuke.SocialLibrary.Controls.LikeControl" %>
<%@ Import Namespace="DotNetNuke.SocialLibrary" %>
<div data-bind="stopBindings: true">
    <div class="like-popup">
        <asp:Panel runat="server" ID="ScopeWrapper">
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
                                <!--  ko ifnot: isDeleted() -->
                                <a class="dnnSocialLink" data-bind="attr: { href:  profileUrl }, text: displayName" ></a>
                                <!-- /ko -->
                                <!--  ko if: isDeleted() -->
                                <a class="dnnSocialLink"><%= LocalizeString("Anonymous") %></a>
                                <!-- /ko -->
                            </td>
                            <!-- ko ifnot: $root.isMobileView -->
                            <td class="friend-td">
                                <!--  ko ifnot: isDeleted() -->
                                <!--  ko ifnot: you -->
                                    <!-- ko if: friendStatus() === 2 -->
                                    <a href="javascript:void(0)" class="dnnSecondaryAction" data-bind="click: unfriend"><%= LocalizeString("btnUnfriend") %></a>
                                    <!-- /ko -->
                                    <!-- ko if: friendStatus() === 1 -->
                                    <a href="javascript:void(0)" class="dnnSecondaryAction disabled"><%= LocalizeString("btnFriendRequested") %></a>
                                    <!-- /ko -->  
                                    <!-- ko if: friendStatus() === 0 -->
                                    <a href="javascript:void(0)" class="dnnSecondaryAction" data-bind="click: friend"><%= LocalizeString("btnFriend") %></a>
                                    <!-- /ko -->
                                <!-- /ko -->
                                <!-- /ko -->
                            </td>
                            <!-- /ko -->
                        </tr>
                        <!-- /ko -->
                    </tbody>
                </table>
                <a data-bind="visible: showMore, click: getMore" class="like-popup-loadmore"><%= LocalizeString("Like_LoadMore") %></a>
            </div>
            <a class="dnnPrimaryAction" data-bind="visible: isMobileView, click: closeDialog" style="width: 100%; margin: 0">Close</a>
        </asp:Panel>
    </div>
</div>

<script type="text/javascript">
    (function() {
		var control = null;
		dnn.social.initLikeControl = function(){
			if(!control){
				var settings = <%= SocialModule.GetSettingsAsJsonString(ModuleContext) %>;
				settings.moduleScope = $('#<%= ScopeWrapper.ClientID %>')[0];
				settings.parentScope = $('#<%= ParentScopeWrapper %>')[0];
				settings.popupTitle = '<%= LocalizeString("Like_PopupTitle") %>';
				control = new dnn.social.LikeControl($, ko, settings);
			}
			return control;
		};
    })();
</script>