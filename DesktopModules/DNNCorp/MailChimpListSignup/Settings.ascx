<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Settings.ascx.cs" Inherits="Evoq.Modules.MailChimpListSignup.Settings" %>
<%@ Import Namespace="Newtonsoft.Json" %>
<%@ Register TagName="label" TagPrefix="dnn" Src="~/controls/labelcontrol.ascx" %>

<fieldset class="mcs-settings">
    <% if (MailchimpConnectorConfigured)
    { %>
    <input type="hidden" ID="hdListsToSubscribe" data-bind="value: listsToSubscribe" runat="server" />
    <div class="dnnFormItem">
        <input type="checkbox" ID="chkAllowListSelection" runat="server" data-bind="checked: allowListSelection" />
        <dnn:Label ID="lblAllowListSelection" runat="server" /> 
    </div>
    <div class="dnnFormItem">
        <dnn:Label ID="lblLists" runat="server" /> 

        <div class="panel mcs-list" data-bind="css: {'mc-loading': loading}" >
            <ul data-bind="foreach: lists">
                <li>
                    <div>
                        <input type="checkbox" data-bind="checkedValue: id, checked: $parent.listsToSubscribe" />
                        <div class="mcs-list-name" data-bind="text: name"></div>
                    </div>
                </li>
            </ul>
            <div class="mcs-list-footer">
                <div class="mcs-results" data-bind="html: '<%= LocalizeString("Showing")%>' + ' ' + from() + '-' + to() + ' ' + '<%= LocalizeString("of")%>' + ' ' + totalLists()">
                </div>

                <a href="javascript:void(0)" id="previousPage" type="button" class="mcs-page-button" data-bind="click: previousPage, css: {'mcs-disabled': from() <= 1 }"></a>
                <a href="javascript:void(0)" id="nextPage" type="button" class="mcs-page-button" data-bind="click: nextPage, css: {'mcs-disabled': to() == totalLists() }"></a>
            </div>
        </div>            
    </div>
    <div class="dnnFormItem">
        <dnn:Label ID="lblCollectFirstName" runat="server" /> 
        <asp:CheckBox ID="chkCollectFirstName" runat="server" />
    </div>
    <div class="dnnFormItem">
        <dnn:Label ID="lblCollectLastName" runat="server" /> 
        <asp:CheckBox ID="chkCollectLastName" runat="server" />
    </div>
    <div class="dnnFormItem">
        <dnn:Label ID="lblSubmissionMessage" runat="server" /> 
        <asp:TextBox ID="txtSubmissionMessage" TextMode="MultiLine" MaxLength="1500" runat="server" />
    </div>
    <% } else { %>
    <div class="dnnFormMessage dnnFormInfo">
        <span><%= LocalizeString("MailchimpConnectorNotConfigured")%></span>
	</div>
    <% } %>
</fieldset>

<% if (MailchimpConnectorConfigured)
    { %>
<script type="text/javascript">
    (function ($) {
        $(document).ready(function () {
            var model = new dnn.MailChimpListSignup.Settings(<%= ModuleId %>, JSON.parse('<%= JsonConvert.SerializeObject(GetModel())%>'), ko);
            ko.applyBindings(model, document.getElementById('<%= ClientID %>'));
        });
    }(jQuery));
</script>
<% } %>