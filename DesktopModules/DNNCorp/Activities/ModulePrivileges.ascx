<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ModulePrivileges.ascx.cs" Inherits="DotNetNuke.Professional.Activities.ModulePrivileges" %>
<asp:Panel runat="server" ID="ScopeWrapper">
    <div id="modulePrivileges">
        <table style="width: 100%;">
            <tbody>
                <tr>
                    <td style="width: 75%;">
                        <!-- ko if: privilege() != null -->
                        <h4><span data-bind="text: privilege().privilegeName"></span></h4>
                        <hr/>
                        <div>
                            <p data-bind="html: privilege().privilegeDescription"></p>
                        </div>
                        <!-- /ko -->
                    </td>
                    <td style="width: 25%;">
                        <!-- ko if: privilege() != null -->
                        <h4>Reputation Required</h4>
                        <hr/>
                        <div class="requiredReputation">
                            <span data-bind="text: privilege().reputationPoints"></span>
                        </div>
                        <br/>
                        <!-- /ko -->
                        <h5>Privileges</h5>
                        <hr/>
                        <ul class="privileges">
                            <!-- ko foreach: privileges -->
                            <li>
                                <a data-bind="click: $root.select" href="javascript:void(0)"><span data-bind="text: privilegeName"></span></a>
                            </li>
                            <!-- /ko -->
                        </ul>
                    </td>
                </tr>
            </tbody>
        </table>
    </div>
</asp:Panel>
<script type="text/javascript">
    function privilegesInit(settings) {
        settings.moduleScope = $(settings.moduleScope)[0];
        if (!settings.moduleScope) {
            return;
        }

        try {
            dnn.social.applyBindings(new dnn.activities.PrivilegeView($, window.ko, settings), settings.moduleScope);
        } catch(ex) {
            dnn.social.topLevelExceptionHandler(settings, ex);
        }
    }
</script>
