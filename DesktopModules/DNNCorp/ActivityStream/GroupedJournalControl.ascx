<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="GroupedJournalControl.ascx.cs" Inherits="DotNetNuke.Professional.ActivityStream.GroupedJournalControl" %>
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
                                            <img data-bind="attr: { src: avatarUrl, title: displayName }"  />
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
                        </tr>
                        <!-- /ko -->
                    </tbody>
                </table>
                <a data-bind="visible: showMore, click: getMore" class="like-popup-loadmore"><%= LocalizeString("GroupedJournal_LoadMore") %></a>
            </div>
            <a class="dnnPrimaryAction" data-bind="visible: isMobileView, click: closeDialog" style="width: 100%; margin: 0"><%= LocalizeString("GroupedJournal_Close") %></a>
        </asp:Panel>
    </div>
</div>

<script type="text/javascript">
    (function() {
        var control = null;
        dnn.activityStream.initGroupedJournalControl = function(){
            if(!control){
                var settings = <%= SocialModule.GetSettingsAsJsonString(ModuleContext) %>;
			    settings.moduleScope = $('#<%= ScopeWrapper.ClientID %>')[0];
			    settings.parentScope = $('#<%= ParentScopeWrapper %>')[0];
			    settings.popupTitle = '';
                control = new dnn.activityStream.GroupedJournalControl($, ko, settings);
			}
		    return control;
		};
    })();
</script>
