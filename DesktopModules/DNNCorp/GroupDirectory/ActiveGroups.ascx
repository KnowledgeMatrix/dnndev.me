<%@ Control Language="C#" AutoEventWireup="false" CodeBehind="ActiveGroups.ascx.cs" Inherits="DotNetNuke.Professional.GroupDirectory.ActiveGroups" %>

<asp:Panel ID="ScopeWrapper" runat="server" CssClass="dnnClear">
    <div class="active-groups-containter dnnClear" id="activeGroups">
        <h6><%= LocalizeString("MostRecent") %></h6>
        <table>
            <tbody class="static-row">
                <% foreach (var group in InitialSet)
                   { %>
                 <tr>
                        <td>
							<span>
								 <a href="javascript:void(0)" class="group-avatar">
									<em>
										<img alt="<%= group.GroupName%>" src="<%= group.ImageUrl %>" title="<%= group.GroupName%>" />
									</em>
								</a>
							</span>
                        </td>
                        <td class="group-name">
                            <a href="javascript:void(0)"><%= group.GroupName %></a>
                        </td>
                    </tr>
                <% } %>
            </tbody>
            <tbody class="ko-container">
                 <!-- ko foreach: results -->
                    <tr>
						<td class="group-avatar">
							<span>
								 <a href="javascript:void(0)" data-bind="click: navGroupHomeUrl" class="group-avatar">
									<em>
										<img data-bind="attr: { src: GroupImage, alt: GroupName, title: GroupName }" />
									</em>
								</a>
							</span>
                        </td>
                        <td class="group-name">
                            <a href="javascript:void(0)" data-bind="click: navGroupHomeUrl"><span data-bind="text: GroupName"></span></a>
                        </td>
                    </tr>
                 <!-- /ko -->
            </tbody>
        </table>
    </div>
</asp:Panel>

<script type='text/javascript'>
    function activeGroupsInit(settings) {
        settings.moduleScope = $(settings.moduleScope)[0];
        if (!settings.moduleScope) {
            return;
        }

        try {
            window.dnn.social.applyBindings(new dnn.groupDirectory.ActiveGroups($, ko, settings), settings.moduleScope);
        } catch (ex) {
            window.dnn.social.topLevelExceptionHandler(settings, ex);
        }
    }
</script>
