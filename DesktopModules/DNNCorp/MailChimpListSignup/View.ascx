<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="View.ascx.cs" Inherits="Evoq.Modules.MailChimpListSignup.View" %>
<%@ Import Namespace="Newtonsoft.Json" %>

<asp:Panel ID="ScopeWrapper" runat="server" CssClass="dnnClear scopeWrapper">
    <% if (MailchimpConnectorConfigured)
        { %>
    <div class="mcs-form" data-bind="visible: !message(), css: { 'mcs-show-errors': showErrors(), 'mcs-loading': loading }">
        <div data-bind="visible: !userAuthenticated()">
            <input class="mcs-line" placeholder="<%= LocalizeString("EnterYourFirstName")%>" data-bind="visible: collectFirstName, textInput: firstName" type="text" />
            <input class="mcs-line" placeholder="<%= LocalizeString("EnterYourLastName")%>" data-bind="visible: collectLastName, textInput: lastName" type="text" />
            <input class="mcs-line" placeholder="<%= LocalizeString("EnterYourEmail")%>" data-bind="textInput: email, css: { 'mcs-input-error': !isValidEmail() }" type="text" />
        </div>

        <ul data-bind="foreach: listsToSubscribe, visible: allowListSelection()" class="mcs-lists-to-subscribe">
            <li>
                <input type="checkbox" data-bind="visible: !$parent.userAuthenticated(), checkedValue: id, checked: $parent.selectedListsIds" />
                <label class="mcs-list-name" data-bind="text: name"></label>

                <div class="mcs-button-group" data-bind="visible: $parent.userAuthenticated()">
                    <a href="javascript:void(0)" class="mcs-plainbtn" data-bind="visible: !$parent.isUserSubscribedInList(id), click: $parent.subscribeToList, text: '<%= LocalizeString("Subscribe")%>'"></a>
                    <a href="javascript:void(0)" class="mcs-plainbtn mcs-assigned" data-bind="visible: $parent.isUserSubscribedInList(id), click: $parent.unsubscribeToList, text: '<%= LocalizeString("Unsubscribe")%>'"></a>
                </div>
            </li>
        </ul>
        <div class="mcs-line dnnFormMessage dnnFormValidationSummary" data-bind="visible: showErrors() && errorMessageToShow(), text: errorMessageToShow()"></div>
        <a class="mcs-subscribe-button dnnPrimaryAction" href="javascript:void(0)" type="button" data-bind="visible: !allowListSelection() || !userAuthenticated(), click: subscribe, text: '<%= LocalizeString("Subscribe")%>    '"></a>
    </div>
    <div class="dnnFormMessage dnnFormInfo" data-bind="text: message, visible: message"></div>
    <% } else { %>
    <div id="divMailchimpConnectorNotConfigured" class="dnnFormMessage dnnFormInfo">
        <span><%= LocalizeString("MailchimpConnectorNotConfigured")%></span>
	</div>
    <% } %>
</asp:Panel>

<% if (MailchimpConnectorConfigured)
    { %>
<script type="text/javascript">
    (function ($) {
        $(document).ready(function () {
            var model = new dnn.MailChimpListSignup.View(<%= ModuleId%>, JSON.parse('<%= JsonConvert.SerializeObject(GetModel())%>'), ko);
            ko.applyBindings(model, document.getElementById('<%=ScopeWrapper.ClientID%>'));
        });
    }(jQuery));
</script>
<% } %>