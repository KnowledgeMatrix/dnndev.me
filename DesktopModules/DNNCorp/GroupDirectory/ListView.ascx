<%@ Control Language="C#" AutoEventWireup="false" CodeBehind="ListView.ascx.cs" Inherits="DotNetNuke.Professional.GroupDirectory.ListView" %>
<%@ Import Namespace="DotNetNuke.Services.Localization" %>
<%@ Register TagPrefix="dnn" TagName="CreateWizard" Src="~/DesktopModules/DNNCorp/GroupDirectory/Controls/CreateWizard.ascx" %>
<%@ Register TagPrefix="dnn" TagName="EditWizard" Src="~/DesktopModules/DNNCorp/SocialLibrary/Controls/GroupEditWizard.ascx" %>
<asp:Panel ID="ScopeWrapper" runat="server" CssClass="dnnClear moduleContainer">
    <%-- NORMAL VIEW --%>
    <!-- ko ifnot: isMobileView -->
    <div class="moduleContainer-normalView ko-container">
        <div class="list-container dnnClear">
            <div class="status-container dnnClear">
                <div class="status-scroll dnnSocialTabs dnnLeft">
                    <a data-bind="click: function () { return $root.category('allgroups'); }, attr: { 'class': selectedClass('allgroups') }">
                        <span><%= LocalizeString("AllGroups") %></span>
                    </a>
                    <a data-bind="click: function () { return $root.category('mygroups'); }, attr: { 'class': selectedClass('mygroups') }">
                        <span><%= LocalizeString("MyGroups") %></span>
                    </a>
                </div>
            </div>
            <div class="sort-filter-container moduleTopInsetShadowBox dnnClear static-row">
                <div class="dnnLeft">
                    <input type="text" placeholder="Filter by tag" class="dnnTagsInput" style="width: 190px" />
                </div>
                <div class="dnnLeft">
                    <select style="width: 198px">
                        <option><%= LocalizeString("SortByGroupName") %></option>
                    </select>
                </div>
                <div class="dnnLeft">
                    <a href="javascript:void(0)" class="view-mode-thumbnail"></a>
                    <a href="javascript:void(0)" class="view-mode-list"></a>
                </div>
            </div>
            <div class="sort-filter-container moduleTopInsetShadowBox dnnClear ko-container">
                <div class="dnnLeft">
                    <input type="text" class="sort-tags-input" />
                </div>
                <div class="dnnLeft" data-bind="with: componentFactory.resolve('ListController')">
                    <select data-bind="options: $root.sortOptions, optionsValue: 'value', optionsText: 'text', value: $root.sort"></select>
                </div>
                <div class="dnnLeft">
                    <a href="javascript:void(0)" data-bind="click: function () { $root.setViewMode('Thumbnail'); }, attr: { 'class': 'view-mode-thumbnail ' + viewModeSelectClass('Thumbnail') }"></a>
                    <a href="javascript:void(0)" data-bind="click: function () { $root.setViewMode('List'); }, attr: { 'class': 'view-mode-list ' + viewModeSelectClass('List') }"></a>
                </div>
                <div class="dnnRight">
                    <div class="dnnPagingCount dnnLeft">
                        <span data-bind="html: totalResults()"></span>
                    </div>
                    <!-- ko if: $root.pager().totalPages() > 1 -->
                    <div class="dnnPagingButtons dnnRight">
                        <a href="javascript:void(0)" data-bind="click: prev, attr: { 'class': 'pager-prev ' + prevClass() }"></a>
                        <a href="javascript:void(0)" data-bind="click: next, attr: { 'class': 'pager-next ' + nextClass() }"></a>
                    </div>
                    <!-- /ko -->
                </div>
            </div>
        
            <% if (viewMode == "List")
               { %>
            <% foreach (var group in InitialSet)
               { %>
            <div class="group-listing static-row">
                <% if (CanModerate)
                   { %>
			    <div class="group-edit">
			        <a><%= LocalizeString("Edit") %></a>
			    </div>
                <% } %>
                <div class="group-info-primary">
                    <a href="javascript:void(0)" class="group-list-image">
                        <span class="image-span">
                            <em>
                                <img src="<%= group.ImageUrl %>" alt="<%= group.GroupName %>" title="<%= group.GroupName %>" />
                            </em>
                        </span>
                    </a>
                </div>
                <div class="group-info-secondary">
                    <div class="group-info-name">
                        <a href="javascript:void(0)"><span><%= group.GroupName %></span></a>
                    </div>
                    <div class="group-info-description">
                        <%= group.Description %>
                    </div>
                    <div class="group-info-stats">
					    <% if (!group.IsPendingToBeApproved)
					       { %>
                        <a class="<%= group.IsMember? "joinButton pending groupStatusLabel" : group.IsPendingToBeApproved? "joinButton pending groupStatusLabel" : "joinButton dnnPrimaryAction" %>">
                                <%= group.IsMember? LocalizeString("YouAreMember") : group.IsPendingToBeApproved? LocalizeString("Pending"):  LocalizeString("Join") %>
                        </a>

                        <div class="created">
                            <span class="label"><%= LocalizeString("Members_Caps") %>:</span>
                            <span class="stat"><%= group.MemberCount %></span>
                            <span class="divider"></span>
                            <span class="label"><%= LocalizeString("Established") %>:</span>
                            <span class="stat"><%= group.CreatedOnDate %></span>
                        </div>
                        <% }
					       else
					       { %>
                         <div class="group-info-actions">                           
                            <span class="pending groupStatusLabel">
                                <%= LocalizeString("GroupPending") %>
                            </span>
                        </div>
                        <% } %>
                </div>
                </div>
              
                <div class="dnnClear"></div>
            </div>
            <% } %>
            <% } %>
        
            <% if (viewMode == "Thumbnail")
               { %>
            <% foreach (var group in InitialSet)
               { %>
            <div class="group-tiles static-row">
                 <div class="groupTooltip">
                    <a href="javascript:void(0)" class="group-image">
                        <span class="image-span">
                            <em>
                                <img src="<%= group.ImageUrl %>" alt="<%= group.GroupName %>" title="<%= group.GroupName %>" />
                            </em>
                        </span>
                    </a>
                </div>
                <div class="group-info">
                    <div class="group-info-primary">
                        <a class="group-info-name" href="javascript:void(0)"><%= group.GroupName %></a>
                    </div>
                    <div class="group-info-secondary">
                       <% if (!group.IsPendingToBeApproved){ %>  
                        <div class="group-info-membership">
                            <div class="group-info-memberCount">
                                <span class="memberCount"><%= group.MemberCount %></span>
                            </div>
                            <div class="group-info-memberLabel">
                                <span class="group-info-memberLabel"><%= LocalizeString("Members_Caps") %></span>
                            </div>
                        </div>
                        <div class="group-info-actions">
                            <a class="<%= group.IsMember? "joinButton pending groupStatusLabel" : group.IsPendingToBeApproved? "joinButton pending groupStatusLabel" : "joinButton dnnPrimaryAction" %>">
                                <%= group.IsMember? LocalizeString("YouAreMember") : group.IsPendingToBeApproved? LocalizeString("Pending"):  LocalizeString("Join") %>
                            </a>
                        </div>
                        <% } else {%>  
                         <div class="group-info-actions">                           
                            <span class="pending groupStatusLabel">
                                <%= LocalizeString("GroupPending") %>
                            </span>
                        </div>
				        <% } %>
                    </div>
                    <% if (CanModerate)
                       { %>
                    <div class="group-edit">
                        <a><%= LocalizeString("Edit") %></a>
                    </div>
                    <% } %>
                </div>
            </div>
            <% } %>
            <% } %>
        

            <div class="dnnClear list-tbl-container ko-container" data-bind="css: { thumbview: $root.viewMode() == 'Thumbnail' }">
                <!-- ko with: $root.componentFactory.resolve('ListController') -->
                <!-- ko foreach: results -->
                    <!-- ko if: $root.viewMode() == 'List' -->
                    <div class="group-listing ko-container">
                        <div class="group-edit"><a data-bind="attr: { id: 'EditGroup-' + GroupId }, visible: $root.canModerate, click: editGroup "><%= LocalizeString("Edit") %></a></div>
                        <div class="group-info-primary">
                            <a href="javascript:void(0)" data-bind="click: navGroupHomeUrl" class="group-list-image">
                                <span class="image-span">
                                    <em>
                                        <img data-bind="attr: { src: GroupImage, alt: GroupName, title: GroupName }" />
                                    </em>
                                </span>
                            </a>
                        </div>
                        <div class="group-info-secondary">
                            <div class="group-info-name">
                                <a href="javascript:void(0)" data-bind="click: navGroupHomeUrl"><span data-bind=" html: GroupName"></span></a>
                            </div>
                            <div class="group-info-description" data-bind="html: Description">
                            </div>
                            <div class="group-info-stats">
					            <!-- ko ifnot: IsPendingToBeApproved -->  
                                <a data-bind="attr: { id: 'JoinGroup-' + GroupId, 'class': MembershipStatus }, click: joinGroup, html: MembershipStatusText"></a>

                                <div class="created">
                                    <span class="label"><%= LocalizeString("Members_Caps") %>:</span>
                                    <span class="stat" data-bind="text: MemberCount"></span>
                                    <span class="divider"></span>
                                    <span class="label"><%= LocalizeString("Established") %>:</span>
                                    <span class="stat" data-bind="text: CreatedOnDate"></span>
                                </div>
                                <!-- /ko -->
                                <!-- ko if: IsPendingToBeApproved -->   
                                <div class="group-info-actions">                           
                                    <span class="pending groupStatusLabel">
                                        <%= LocalizeString("GroupPending") %>
                                    </span>
                                </div>
				                <!-- /ko -->
                        </div>
                        </div>
                        <div class="dnnClear"></div>
                    </div>
                    <!-- /ko -->
            
                    <!-- ko if: $root.viewMode() == 'Thumbnail' -->
                    <div class="group-tiles">
                        <div class="groupTooltip" data-bind="event: { mouseenter: populateToolTip }">
                            <a href="javascript:void(0)" data-bind="click: navGroupHomeUrl" class="group-image">
                                <span class="image-span">
                                    <em>
                                        <img data-bind="attr: { src: GroupImage, alt: GroupName, title: GroupName }" />
                                    </em>
                                </span>
                            </a>
                            <div class="groupToolTip" style="display: none;" data-bind="attr: { id: 'groupToolTip_' + GroupId }">
                                <div class="groupToolTipContent" data-bind="attr: { id: 'groupToolTipContent_' + GroupId }">
                                    <div>
                                        <span class="groupToolTip-description" data-bind="html: Description"></span>
                                        <a href="javascript:void(0)" class="groupToolTip-close" title="<%= LocalizeString("Close")%>" data-bind="click: $parent.closeToolTip"></a>
                                    </div>
                                    <div class="groupToolTip-stat">
                                        <span class="groupToolTip-stat-bold"><%= LocalizeString("LastActivity") %>: </span>
                                    </div>
                                    <div class="groupToolTip-stat">
                                        <span class="groupToolTip-stat-med" data-bind="html: LastActiveDate"></span>
                                    </div>
                                    <br />
                                    <span class="groupToolTip-stat-bold"><%= LocalizeString("Tags") %>: </span>
                                    <span class="groupToolTip-stat-tags" data-bind="html: TagsString"></span>
                                    <hr />
                                    <div class="groupToolTip-recentParticpants">
                                        <div class="groupToolTip-stat-div groupToolTip-stat-light"><%= LocalizeString("RecentlyParticipated") %>: </div>
                                        <div class="groupToolTip-avatar-list">
                                            <!-- ko foreach: RecentParticipants -->
                                            <span class="groupToolTip-avatar">
                                                <em>
                                                    <a data-bind="attr: { href: ProfileUrl }">
                                                        <img data-bind="attr: { src: Avatar, alt: DisplayName, title: DisplayName }" />
                                                    </a>
                                                </em>
                                            </span>
                                            <!-- /ko -->
                                        </div>
                                    </div>
                                    <div class="groupToolTip-recentActivity-list">
                                        <!-- ko foreach: RecentActivity -->
                                        <div class="groupToolTip-recentActivity">
                                            <span class="groupToolTip-avatar">
                                                <em>
                                                    <a data-bind="attr: { href: ProfileUrl }">
                                                        <img data-bind="attr: { src: Avatar, alt: DisplayName, title: DisplayName }" />
                                                    </a>
                                                </em>
                                            </span>
                                            <span class="groupToolTip-activity" data-bind="html: RecentActivitySummary"></span>
                                        </div>
                                        <!-- /ko -->
                                    </div>
                                    <div class="groupToolTip-link">
                                        <a href="javascript:void(0)" data-bind="click: navGroupHomeUrl"><%= LocalizeString("ViewMore") %></a>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="group-info">
                            <div class="group-info-primary">
                                <a class="group-info-name" href="javascript:void(0)" data-bind="click: navGroupHomeUrl"><span data-bind="    html: GroupName"></span></a>
                            </div>
                            <div class="group-info-secondary">
                                <!-- ko ifnot: IsPendingToBeApproved -->    
                                <div class="group-info-membership">
                                    <div class="group-info-memberCount">
                                        <span class="memberCount" data-bind="html: MemberCount"></span>
                                    </div>
                                    <div class="group-info-memberLabel">
                                        <span class="group-info-memberLabel"><%= LocalizeString("Members_Caps") %></span>
                                    </div>
                                </div>
                                <div class="group-info-actions">
                                    <a data-bind="attr: { id: 'JoinGroup-' + GroupId, 'class': MembershipStatus }, click: joinGroup, html: MembershipStatusText"></a>
                                </div>
                                <!-- /ko -->
                                <!-- ko if: IsPendingToBeApproved -->   
                                    <div class="group-info-actions">                           
                                    <span class="pending groupStatusLabel">
                                        <%= LocalizeString("GroupPending") %>
                                    </span>
                                </div>
				                <!-- /ko -->
                            </div>
                            <div class="group-edit" data-bind="visible: $root.canModerate">
                                <a data-bind="attr: { id: 'EditGroup-' + GroupId }, click: editGroup "><%= LocalizeString("Edit") %></a>
                            </div>
                        </div>
                    </div>
                    <!-- /ko -->
                <!-- /ko -->
                <div class="list-noresult ko-container" data-bind="visible: results().length === 0">
                    <%= LocalizeString("NoRecords") %>
                </div>
                <!-- /ko -->
            </div>

            <div class="pager-bottom moduleTopInsetShadowBox dnnClear">
                <% if (CanCreateGroup)
                    { %>
                <div class="bottom-create-btn dnnLeft">
                    <a class="dnnPrimaryAction" data-bind="click: addDialog"><%= Localization.GetString("SearchCreate","~/DesktopModules/DNNCorp/GroupDirectory/App_LocalResources/Search.ascx.resx") %></a>
                </div>
                <% } %>
                <div class="dnnLeft">
                    <ul class="pager-ul" data-bind="html: pagingControl"></ul>
                </div>
                <div class="dnnRight">
                    <div class="dnnPagingCount dnnLeft">
                        <span data-bind="html: totalResults()"></span>
                    </div>
                    <!-- ko if: $root.pager().totalPages() > 1 -->
                    <div class="dnnPagingButtons dnnRight">
                        <a href="javascript:void(0)" data-bind="click: prev, attr: { 'class': 'pager-prev ' + prevClass() }"></a>
                        <a href="javascript:void(0)" data-bind="click: next, attr: { 'class': 'pager-next ' + nextClass() }"></a>
                    </div>
                    <!-- /ko -->
                </div>
            </div>

        </div>
    </div>
    <!-- /ko -->
    <%-- END NORMAL VIEW --%>

    <%-- MOBILE VIEW --%>
    <!-- ko if: isMobileView -->
    <div class="moduleContainer-mobileView ko-container">
        <div class="dnnMobileListContainer dnnClear">
        <div class="dnnMobileStatusContainer dnnClear">
            <select data-bind="value: selectedMobileViewCategory">
                <option value="allgroups"><%= LocalizeString("AllGroups") %></option>
                <option value="mygroups"><%= LocalizeString("MyGroups") %></option>
            </select>
        </div>
        <div class='dnnMobileListTblContainer'>
            <!-- ko with: $root.componentFactory.resolve('ListController') -->
            <table class='dnnMobileListTbl dnnMobileGroupDirectoryTbl loading-container'>
                <tbody>
                    <!-- ko foreach: resultsMobile -->
                    <tr>
                        <td class="dnnMobileIdeaVote">
                            <!-- ko ifnot: IsPendingToBeApproved -->  
                            <div class="group-member-info">
                                <span class="member-count" data-bind="html: MemberCount"></span>
                                <span class="member-label"><%= LocalizeString("Members_Caps") %></span>
                            </div>
                            <a data-bind="attr: { id: 'JoinGroup-' + GroupId, 'class': MembershipStatus }, click: joinGroup, html: MembershipStatusText"></a>
                            <!-- /ko -->
                            <!-- ko if: IsPendingToBeApproved -->                         
                                <span class="pending groupStatusLabel">
                                    <%= LocalizeString("GroupPending") %>
                                </span>
				            <!-- /ko -->
                        </td>
                        <td class="dnnMobileIdeaTitle">
                            <a href="javascript:void(0)" data-bind="click: navGroupHomeUrl" class="dnnSocialLink">
                                <span data-bind="html: GroupName" class="list-row-title"></span>
                            </a>
                            <p class="list-row-label" data-bind="html: Description">
                            </p>
                        </td>
                    </tr>
                    <!-- /ko -->
                </tbody>
            </table>
            <!-- ko if: resultsMobile().length === 0 -->
            <div class="list-noresult">
                <%= LocalizeString("NoRecords") %>
            </div>
            <!-- /ko -->
            <!-- /ko -->
            <!-- ko if: $root.pager().totalPages() - 1 > $root.pager().page() -->
            <a data-bind="click: loadMore" class="dnnMobileLoadMoreLink">
                <span><%= LocalizeString("MoreGroups") %></span>
            </a>
            <!-- /ko -->
        </div>
        <% if (CanCreateGroup)
           { %>
        <a class="dnnMobileCreateNewButton" data-bind="click: addDialogMobileView"><%= Localization.GetString("SearchCreate", "~/DesktopModules/DNNCorp/GroupDirectory/App_LocalResources/Search.ascx.resx") %></a>
        <% } %>
    </div>
    </div>
    <!-- /ko -->
    <%-- END MOBILE VIEW --%>
    <div data-bind="stopBindings: true" class="create-dialog" style="display: none;" runat="server" ID="CreateWrapper">
        <dnn:CreateWizard ID="Create" runat="server" />
    </div>
    <div data-bind="stopBindings: true" class="group-edit-dialog" style="display: none;" runat="server">
        <dnn:EditWizard ID="EditWizard" runat="server" />
    </div>
</asp:Panel>

<script type='text/javascript'>
    dnn.social.loading('<%= ScopeWrapper.ClientID %>');
    function groupDirectoryInit(settings) {
        settings.moduleScope = $(settings.moduleScope)[0];
        if (!settings.moduleScope) {
            return;
        }

        try {
           window.dnn.social.applyBindings(new window.dnn.groupDirectory.ListView(settings), settings.moduleScope);
        } catch (ex) {
            window.dnn.social.topLevelExceptionHandler(settings, ex);
        }
    }
</script>
