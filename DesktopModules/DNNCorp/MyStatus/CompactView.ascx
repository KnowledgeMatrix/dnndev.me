<%@ Control Language="C#" AutoEventWireup="false" CodeBehind="CompactView.ascx.cs" Inherits="DotNetNuke.Professional.MyStatus.CompactView" %>
<asp:Panel class="statusLogin" ID="pnlUnauth" runat="server">
    <asp:HyperLink ID="loginLink" runat="server" class="anonymousLogin dnnPrimaryAction"><%= LocalizeString("Login") %></asp:HyperLink>
    <div class="dnnClear" id="dnnMyStatusLogin">
        <asp:HyperLink ID="registerLink" runat="server"><%= LocalizeString("Register") %></asp:HyperLink><span><%= LocalizeString("BecomeMember") %></span>
    </div>
</asp:Panel>

<asp:Panel id="pnlAuth" runat="server" CssClass="status-compact-container moduleContainer">
    <div class="status-profile-container" data-bind="with: profile" id="dnnMyStatusCompact">
        <div data-bind="with: properties">
            <div class="avatar">
                <span>
                    <em>
                        <img src="<%= ProfilePhotoUrl %>" title="<%= DisplayName %>" alt="<%= DisplayName %>"/>
                    </em>
                </span>
            </div>
            <div class="name">
                <a class="dnnSocialLink" href="<%= ProfileUrl %>">
                    <h6><%= DisplayName %></h6>
                </a>
                <br />
                <a href="<%= EditProfileUrl %>">
                    <%= LocalizeString("EditMyProfile") %>
                </a>
            </div>
        </div>
    </div>
    <div class="points-completion-panel static-row">
        <div class="points-panel">
            <div class="points">
                <span>0</span>&nbsp;<%= LocalizeString("Points") %>
                <div class="dnnClear"></div>
                <a>
                    <%= LocalizeString("WhatArePoints") %>
                </a>
            </div>
        
            <div class="dnnClear"></div>
        </div>
        <div class="completion-panel">
        </div>
        <div class="dnnClear"></div>
    </div>
    <div class="points-completion-panel ko-container" data-bind="with: profile">
        <div class="points-panel">
           
            <!-- ko if: dynamic() != null -->
            <!-- ko if: dynamic().lastBadgeUrl() !== '' -->
            <div class="badge badgeTooltip">
                <a href="<%= UserBadgesUrl %>">
                    <img data-bind="attr: { src : dynamic().lastBadgeUrl() }" onerror="this.onerror = null; this.src = '<%= ResolveClientUrl(DotNetNuke.Mechanics.Components.Common.Constants.DefaultBadgeImage) %>'" />
                </a>
                <div class="tag-menu" style="display: none;">
                    <p data-bind="text: dynamic().lastBadgeDescription()" ></p>
                </div>
            </div>
            <!-- /ko -->

            <div class="points">
                <span data-bind="text: reputationPoints()"></span>&nbsp;
                <!-- ko if: reputationPoints() == 1 -->
                <%= LocalizeString("Point") %>
                <!-- /ko -->
                <!-- ko if: reputationPoints() != 1 -->
                <%= LocalizeString("Points") %>
                <!-- /ko -->
                <div class="dnnClear"></div>

                <a data-bind="click: help, visible: isPointsUrlValid">
                    <%= LocalizeString("WhatArePoints") %>
                </a>
            </div>

            <div class="dnnClear"></div>
            <!-- /ko -->
        </div>

        <div class="completion-panel qaTooltip" data-bind="if: dynamic() != null">
            <canvas class="chart tag"></canvas>
            <div class="tag-menu" style="display: none;">
                <p data-bind="text: '<%= LocalizeString("ProfileComplete") %>'.format(dynamic().completed())"></p>
            </div>
        </div>
        <div class="dnnClear"></div>
    </div>

    <div class="primary-collections static-row" style="height: 135px"></div>

    <div class="primary-collections ko-container">
        <ul class="collections">
            <li class="collection" data-bind="foreach: collections">
                <div data-bind="attr: { 'class': 'status-collection status-collection-' + collectionKey() }">
                    <div class="pager" data-bind="if: pager.totalPages() > 1 && expanded">
                        <a data-bind="click: next, attr: { 'class': 'status-pager-next ' + nextClass() }"></a>
                        <a data-bind="click: prev, attr: { 'class': 'status-pager-prev ' + prevClass() }"></a>
                    </div>

                    <a data-bind="click: expand">
                        <span data-bind="html: description"></span>

                        <span class="count">(<span data-bind="text: count"></span>)
                        </span>

                        <div data-bind="fadeVisible: loading" class="status-binding-loading loading"></div>
                    </a>

                    <!-- ko if: records().length > 0 -->
                    <ul class="item-list" data-bind="slideVisible: expanded, foreach: records">
                        <li class="item" data-bind="attr: { id: 'collection-item-' + id() }">
                            <a data-bind="attr: { href: targetUrl }">
                                <span data-bind="html: title"></span>
                            </a>
                        </li>
                    </ul>
                    <!-- /ko -->
                </div>
            </li>
        </ul>
    </div>
    
    <div class="secondary-collections static-row" style="height: 53px"></div>

    <div class="secondary-collections ko-container">
        <ul class="builtins">
            <li class="collection" data-bind="foreach: builtins">
                <div data-bind="attr: { 'class': 'status-collection-' + collectionKey() }">
                    <div class="pager" data-bind="if: pager.totalPages() > 1 && expanded">
                        <a data-bind="click: next, attr: { 'class': 'status-pager-next ' + nextClass() }"></a>
                        <a data-bind="click: prev, attr: { 'class': 'status-pager-prev ' + prevClass() }"></a>
                    </div>
                    <div class="icon"></div>
                    <a data-bind="click: expand" class="dnnSocialLink">
                        <span data-bind="html: description"></span>

                        <span class="count">(<span data-bind="text: count"></span>)
                        </span>

                        <div data-bind="visible: loading" class="status-binding-loading loading"></div>
                    </a>
                    <div class="dnnClear"></div>

                    <!-- ko if: records().length > 0 -->
                    <ul class="item-list" data-bind="slideVisible: expanded, foreach: records">
                        <li class="item" data-bind="attr: { id: 'collection-item-' + id() }">
                            <a data-bind="attr: { href: targetUrl }">
                                <span data-bind="html: title"></span>
                            </a>
                        </li>
                    </ul>
                    <!-- /ko -->
                </div>
            </li>
        </ul>
    </div>
    
     <div class="status-bottom-controls static-row">
        <div class="bottom-icons dnnLeft">
            <a class="notification-icon" href="<%= MessagesUrl %>">
            </a>
            <a class="info-icon" href="<%= NotificationsUrl %>">
            </a>
        </div>

        <div class="logout">
            <a href="<%= DotNetNuke.Common.Globals.NavigateURL(ModuleContext.TabId, "Logoff") %>">
                <%= LocalizeString("Logout") %>
            </a>
        </div>

        <div class="dnnClear"></div>
    </div>

    <div class="status-bottom-controls ko-container" data-bind="with: profile">
        <div class="bottom-icons dnnLeft">
            <a class="notification-icon" href="<%= MessagesUrl %>">
                <!-- ko if: dynamic() != null -->
                <div class="notification-count" data-bind="text: displayMessageCount(), visible: showMessageCount"></div>
                <!-- /ko -->
            </a>
            <a class="info-icon" href="<%= NotificationsUrl %>">
                <!-- ko if: dynamic() != null -->
                <div class="notification-count" data-bind="text: displayNotificationCount(), visible: showNotificationCount"></div>
                <!-- /ko -->
            </a>
        </div>

        <div class="logout">
            <a href="<%= DotNetNuke.Common.Globals.NavigateURL(ModuleContext.TabId, "Logoff") %>">
                <%= LocalizeString("Logout") %>
            </a>
        </div>

        <div class="dnnClear"></div>
    </div>

</asp:Panel>