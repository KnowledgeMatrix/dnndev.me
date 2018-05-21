<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Settings.ascx.cs" Inherits="DotNetNuke.Enterprise.MarketoForms.Settings" %>
<%@ Register TagName="label" TagPrefix="dnn" Src="~/controls/labelcontrol.ascx" %>
<%@ Register TagPrefix="dnn" TagName="UrlControl" Src="~/controls/UrlControl.ascx"%>

<h2 id="dnnSitePanel-BasicSettings" class="dnnFormSectionHead"><a href="" class="dnnSectionExpanded"><%=LocalizeString("BasicSettings")%></a></h2>
<fieldset>
    <div class="dnnFormItem">
        <dnn:Label ID="lblMarketoScript" runat="server" /> 
        <asp:TextBox ID="txtMarketoScript" runat="server" TextMode="MultiLine" Height="100px" Width="500px" />
    </div>
    <div class="dnnFormItem">
        <div class="dnnLabel">&nbsp;</div>
        <asp:Button ID="btnProcessScript" runat="server" resourcekey="cmdProcessScript" OnClick="ProcessMarketoScript"/>
    </div>
    <div class="dnnFormItem">
        <dnn:Label ID="lblMarketoURL" runat="server" /> 
        <asp:TextBox ID="txtMarketoURL" runat="server" Enabled="False" />
    </div>
    <div class="dnnFormItem">
        <dnn:Label ID="lblMarketoCode" runat="server" /> 
        <asp:TextBox ID="txtMarketoCode" runat="server" Enabled="False" />
    </div>
    <div class="dnnFormItem">
        <dnn:Label ID="lblMarketoId" runat="server" /> 
        <asp:TextBox ID="txtMarketoId" runat="server" Enabled="False" />
    </div>
    <div class="dnnFormItem">
        <dnn:Label ID="lblHeaderMarkup" runat="server" /> 
        <asp:TextBox ID="txtHeaderMarkup" runat="server" TextMode="MultiLine" Height="100px" Width="500px" />
    </div>
    <div class="dnnFormItem">
        <dnn:Label ID="lblFooterMarkup" runat="server" /> 
        <asp:TextBox ID="txtFooterMarkup" runat="server" TextMode="MultiLine" Height="100px" Width="500px" />
    </div>
    <div class="dnnFormItem">
        <dnn:Label ID="lblOverrideOnSuccess" runat="server" /> 
        <asp:DropDownList ID="ddlOverrideOnSuccess" runat="server" AutoPostBack="True" OnSelectedIndexChanged="OverrideOnSuccessChange">
            <asp:ListItem Text="Do Not Override" Value="default" resourcekey="ddlOverrideOnSuccess.default" Selected="True"></asp:ListItem>
            <asp:ListItem Text="Redirect to URL" Value="redirect" resourcekey="ddlOverrideOnSuccess.redirect" ></asp:ListItem>
            <asp:ListItem Text="Custom Message" Value="message" resourcekey="ddlOverrideOnSuccess.message" ></asp:ListItem>
        </asp:DropDownList>
    </div>
    <div class="dnnFormItem" id="redirectURLField" runat="server" Visible="False">
        <dnn:Label ID="lblRedirectURL" runat="server" />
        <div style="display: inline-block; margin-left: 337px; margin-top: -24px; width: 47%;">
            <dnn:UrlControl ID="ucRedirectURL" runat="server" ShowTrack="false" ShowLog="false" ShowFiles="false" />
        </div>
    </div>
    <div class="dnnFormItem" id="customMessageField" runat="server" Visible="False">
        <dnn:Label ID="lblCustomMessage" runat="server" /> 
        <asp:TextBox ID="txtCustomMessage" runat="server" TextMode="MultiLine" Height="100px" Width="500px" />
    </div>

</fieldset>
<script tpye="text/javascript">
	$(document).ready(function () {
		$(document.body).on('click', 'a[id$="ModuleSettings_cmdUpdate"]', function (e) {
			if ($(this).attr('disabled') === 'disabled') {
				e.preventDefault();
			}
		});

		var validateData = function () {
			var $urlField = $('#<%=txtMarketoURL.ClientID%>');
			var $codeField = $('#<%=txtMarketoCode.ClientID%>');
			var $idField = $('#<%=txtMarketoId.ClientID%>');

			var url = $urlField.val();
			var code = $codeField.val();
			var id = $idField.val();
			if (url === '' || code === '' || id === '') {
				return;
			}

			if (typeof MktoForms2 === "object") {
				MktoForms2 = undefined;
			}

			$('a[id$="ModuleSettings_cmdUpdate"]').attr('disabled', 'disabled');

			$('#scriptLoader').remove();
			var head= document.getElementsByTagName('head')[0];
			var script = document.createElement('script');
			script.id = 'scriptLoader';
			script.type = 'text/javascript';

			script.onreadystatechange= function () {
				if (this.readyState === 'complete') scriptLoaded(url, code, id);
			}
			script.onload = function() {
				scriptLoaded(url, code, id);
			}

			script.onerror = function() {
				scriptLoaded(url, code, id);
			}

			script.src = url + '/js/forms2/js/forms2.js';
			head.appendChild(script);

		};

		var scriptLoaded = function (url, code, id) {
			$('a[id$="ModuleSettings_cmdUpdate"]').removeAttr('disabled');

			if (typeof MktoForms2 === "undefined") {
				showError('<%=LocalizeSafeJsString("ProcessScriptError_InvalidUrl.Text")%>');
				return;
			}

			MktoForms2.loadForm(url, code, id, function(forms) {
				if (forms === null) {
					showError('<%=LocalizeSafeJsString("ProcessScriptError_InvalidCodeOrId.Text")%>');
				}
			});
		};

		var showError = function (message) {
			var $urlField = $('#<%=txtMarketoURL.ClientID%>');
			var $codeField = $('#<%=txtMarketoCode.ClientID%>');
			var $idField = $('#<%=txtMarketoId.ClientID%>');

			$urlField.val('');
			$codeField.val('');
			$idField.val('');

			$('#<%=txtMarketoScript.ClientID%>').after('<span class="dnnFormMessage dnnFormError" style="display: inline;">' + message + '</span>');
		};

		Sys.WebForms.PageRequestManager.getInstance().add_endRequest(function (manager, e) {
			if (manager._activeElement && manager._activeElement.id === '<%=btnProcessScript.ClientID%>') {
				validateData();
			}
		});
	});
</script>