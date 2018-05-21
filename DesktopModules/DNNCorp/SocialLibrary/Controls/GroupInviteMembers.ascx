<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="GroupInviteMembers.ascx.cs" Inherits="DotNetNuke.SocialLibrary.Controls.GroupInviteMembers" %>

<asp:Panel ID="ScopeWrapper" runat="server">  
    <div class="invite-page">
        <div class="dnnFormItem inviteSection">
            <div class="inviteLabel">
                <label>
                    <span><%= GetString("InviteConnections") %></span>
                </label>
            </div>
            <div id="inviteList" class="inviteList">
                <!-- ko if: friends().length < 1 -->
                <span id="noConnections"><%=GetString("NoConnectionsFound") %></span>
                <!-- /ko -->
                <!-- ko foreach: friends -->
                <div class="container">
                    <div class="primary">
                        <a data-bind="attr: { href: ProfileUrl(), target: '_blank'}" class="avatar40" >
                            <span>
                                <em>
                                    <img data-bind="attr: { src: Avatar(), alt: Username() }" alt=""/>
                                </em>
                            </span>
                        </a>
                    </div>
                    <div class="secondary">
                        <div class="user-name">
                            <a data-bind="attr: { href: ProfileUrl() , target: '_blank'}">
                                <span data-bind=" text: DisplayName()"></span>
                            </a>
                        </div>
                        <div class="inviteUser">
                            <!-- ko if: !IsMember() -->
                            <a data-bind="click: inviteFriend, attr: {id: 'inviteLink_User'+ UserId()}" class="dnnPrimaryAction inviteButton"><%=GetString("Invite") %></a>
                            <!-- /ko -->
                            <!-- ko if: IsMember() -->
                            <span class="memberText"><%=GetString("IsMember") %></span>
                            <!-- /ko -->
                        </div>
                    </div>
                </div>
                <!-- /ko -->
            </div>
        </div>
        <div class="dnnFormItem inviteSection inviteByEmailSection">
            <div class="inviteLabel">
                <label>
                    <span><%= GetString("InviteByEmail") %></span>
                </label>
            </div>
            <div class="inviteByEmail">
                <span class="wizardStepDescription"><%= GetString("InviteByEmailHelp") %></span>
                <textarea rows="7" cols="30" id="inviteEmails" class="inviteTextArea" data-bind="value: inviteEmails"></textarea><br />            
            </div>    
        </div>
        <div class="dnnClear"></div>
    </div>
    <div class="dialog-footer dnnClear" data-bind="visible: showBottomPanel">
          <ul class="dnnActions dnnRight">
              <li>
                  <a data-bind="click: invite" id="done" class="dnnPrimaryAction"><%= GetString("Done") %></a>
              </li>
          </ul>
    </div>
</asp:Panel>        


<script type="text/javascript">
    function createInviteMembers(settings) {        
        settings.moduleScope = $(settings.moduleScope)[0];
        if (!settings.moduleScope) {
            return;
        }

        var sf = $.ServicesFramework(settings.ModuleId);
        try {
            window.dnn.social.applyBindings(new window.dnn.social.GroupInviteMembers($, window.ko, settings, sf), settings.moduleScope);
        } catch (ex) {
            window.dnn.social.topLevelExceptionHandler(settings, ex);
        }
    }

</script>
