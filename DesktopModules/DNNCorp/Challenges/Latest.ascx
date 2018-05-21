<%@ Control Language="C#" Inherits="DotNetNuke.Professional.Challenges.Latest" AutoEventWireup="false" CodeBehind="Latest.ascx.cs" %>
<asp:Panel runat="server" ID="ScopeWrapper">
    <div class="dnnClear latest-challenge-container">
        <h6><%= LocalizeString("LatestChallenges") %></h6>
        <% if (LatestChallenges != null && LatestChallenges.Any())
           { %>
        <table class="sidelist-tbl">
            <% foreach (var challenge in LatestChallenges)
               { %>
            <tr>
                <td class="challenge-list-accept">
                    <div class="accept-button">
                        <span class="points"><%= challenge.RepPoints.ToString("D") %></span>
                    </div>
                </td>
                <td>
                    <a href="<%= challenge.JournalUrl %>"><%= challenge.ContentTitle %></a>
                </td>
            </tr>
            <% } %>
        </table>
        <% }
           else
           { %>
        <p>
            <%= LocalizeString("NoChallenges") %>
        </p>
        <% } %>
        <% if (!string.IsNullOrEmpty(CreateChallengeLink))
           { %>
        <a class="create-challenge-button dnnSecondaryAction" href="<%= CreateChallengeLink %>#create"><%= LocalizeString("CreateChallenge") %></a>
        <% } %>
    </div>
</asp:Panel>
