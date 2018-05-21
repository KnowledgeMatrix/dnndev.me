<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="VoteSummary.ascx.cs" Inherits="DotNetNuke.Professional.Ideas.VoteSummary" %>

<asp:Panel ID="ScopeWrapper" runat="server">
<% if (UserId > 0)
   { %>
<div class="vote-summary-container status-compact-container status-container">
    <div class="vote-summary">
        <span data-bind="text: $root.votesRemainingDisplay" class="vote-votesRemaining-number">00</span>
        <span class="vote-label vote-summary-label"><%= LocalizeString("VotesRemaining") %></span>
    </div>
        
    <div id="my-votes">
            <a data-bind="click: function () { showMyVotes(); }">
                <%= LocalizeString("MyVotes") %>&nbsp;(<span data-bind="text: $root.votesUsed">0</span>)
            </a>
            <a data-bind="click: function() { help('WhatFor'); }">
                <%= LocalizeString("WhatFor") %>
            </a>
            <a data-bind="click: function() { help('GetMore'); }">
                <%= LocalizeString("GetMore") %>
            </a>
    </div>
    <div class="dnnClear"></div>
</div>
<div class="ideas-vote-help-dialog" style="display:none">
    <div class="ideas-vote-help-text"></div>
</div>
<% } %>
</asp:Panel>
<script type="text/javascript">
    function voteSummaryInit(settings) {
        settings.moduleScope = $(settings.moduleScope)[0];
        if (!settings.moduleScope) {
            return;
        }

        try {
            window.dnn.social.applyBindings(new window.dnn.ideas.VoteSummaryView($, window.ko, settings), settings.moduleScope);
            dnn.social.loaded(settings.moduleScope.id);
        } catch(ex) {
            window.dnn.social.topLevelExceptionHandler(settings, ex);
        }
    }
</script>