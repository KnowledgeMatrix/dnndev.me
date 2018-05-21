<%@ Control Language="C#" AutoEventWireup="false" Inherits="DotNetNuke.Professional.Activities.BadgeSettings" Codebehind="BadgeSettings.ascx.cs" %>
<%@ Register TagPrefix="dnn" TagName="label" Src="~/controls/LabelControl.ascx" %>
<div class="dnnForm dnnClear">
	<div class="dnnFormItem">
		<dnn:label id="lblPageSize" runat="server" suffix=":" ControlName="ddlPageSize" />
		<asp:DropDownList runat="server" ID="ddlPageSize">
			<Items>
				<asp:ListItem Value="5">5</asp:ListItem>
				<asp:ListItem Value="10">10</asp:ListItem>
				<asp:ListItem Value="25">25</asp:ListItem>
				<asp:ListItem Value="50">50</asp:ListItem>
			</Items>
		</asp:DropDownList>
	</div>
</div>
<script language="javascript" type="text/javascript">
	(function ($, Sys) {
		function setupDiscussionSettings() {}

	    $(document).ready(
	        function() {
	            setupDiscussionSettings();

	            Sys.WebForms.PageRequestManager.getInstance().add_endRequest(
	                function() {
	                    setupDiscussionSettings();
	                });
	        });
	} (jQuery, window.Sys));
</script>   