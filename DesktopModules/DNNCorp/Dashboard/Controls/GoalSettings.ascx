<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="GoalSettings.ascx.cs" Inherits="DotNetNuke.Professional.Dashboard.Controls.GoalSettings" %>

<div class="dashboard-goals" data-bind="stopBindings: true">
    <asp:Panel runat="server" ID="ctlGoals">
        <table class="dashboard-goal-table">
            <thead>
                <tr>
                    <th><%= LocalizeString("Goal") %></th>
                    <th><%= LocalizeString("Weight") %></th>
                    <th><%= LocalizeString("Value") %></th>
                    <th><%= LocalizeString("MinValue") %></th>
                    <th><%= LocalizeString("MaxValue") %></th>
                    <th><%= LocalizeString("Actions") %></th>
                </tr>
            </thead>
            <tbody>
                <!-- ko foreach: rows -->
                <tr>
                    <td class="dashboard-goal-text">
                        <!-- ko if: edit -->
                        <select data-bind="options: $root.options, optionsText: 'text', optionsValue: 'value', value: goal"></select>
                        <!-- /ko -->
                        <!-- ko ifnot: edit -->
                        <span data-bind="text: $root.getOptionText(goal), click: edit"></span>
                        <!-- /ko -->
                    </td>
                    <td class="dashboard-goal-text">
                        <!-- ko if: edit -->
                        <input class="dashboard-goal-value" type="text" data-bind="value: weight" />
                        <!-- /ko -->
                        <!-- ko ifnot: edit -->
                        <span data-bind="text: weight, click: edit" class="dashboard-goal-value"></span>
                        <!-- /ko -->
                    </td>
                    <td class="dashboard-goal-text">
                        <!-- ko if: edit -->
                        <input class="dashboard-goal-value" type="text" data-bind="value: value" />
                        <!-- /ko -->
                        <!-- ko ifnot: edit -->
                        <span data-bind="text: value, click: edit" class="dashboard-goal-value"></span>
                        <!-- /ko -->
                    </td>
                    <td class="dashboard-goal-text">
                        <span data-bind="text: minValue" class="dashboard-goal-value"></span>
                    </td>
                    <td class="dashboard-goal-text">
                        <span data-bind="text: maxValue" class="dashboard-goal-value"></span>
                    </td>
                    <td>
                        <!-- ko if: edit -->
                        <a data-bind="click: accept" class="dashboard-goal-button">
                            <img src="<%= ResolveUrl("~/icons/sigma/approve_16X16_Gray.png") %>" title="<%= LocalizeString("AcceptChanges") %>"/>
                        </a>
                        <a data-bind="click: cancel" class="dashboard-goal-button">
                            <img src="<%= ResolveUrl("~/icons/sigma/reject_16X16_Gray.png") %>" title="<%= LocalizeString("Cancel") %>"/>
                        </a>
                        <!-- /ko -->
                        <!-- ko ifnot: edit -->
                        <a data-bind="click: change" class="dashboard-goal-button">
                            <img src="<%= ResolveUrl("~/icons/sigma/edit_16X16_Gray.png") %>" title="<%= LocalizeString("Edit") %>"/>
                        </a>
                        <a data-bind="click: remove" class="dashboard-goal-button">
                            <img src="<%= ResolveUrl("~/icons/sigma/delete_16X16_Gray.png") %>" title="<%= LocalizeString("Delete") %>"/>
                        </a>
                        <!-- /ko -->
                        
                    </td>
                </tr>
                <!-- /ko -->
            </tbody>
        </table>
        
        <div class="dashboard-goals-actions">
            <a data-bind="click: add" class="dashboard-goal-add dnnPrimaryAction">
                <img src="<%= ResolveUrl("../Images/add.gif") %>" />
                <%= LocalizeString("AddGoal") %>
            </a>
        </div>
    </asp:Panel>
</div>

<script type="text/javascript">
    function dashboard_goalsInit_<%= ctlGoals.ClientID %>(settings) {
        var control = $('#<%= ctlGoals.ClientID %>')[0];
        if (typeof control === 'undefined') {
            return;
        }
        try {
            dnn.social.applyBindings(new dnn.dashboard.GoalSettings(settings, control), control);
        } catch (ex) {
            dnn.social.topLevelExceptionHandler(settings, ex);
        }
    }
</script>