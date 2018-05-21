<%@ Control Language="C#" AutoEventWireup="false" CodeBehind="EditView.ascx.cs" Inherits="DotNetNuke.Professional.Discussions.Controls.EditView" %>
<%@ Import Namespace="SocialConstants=DotNetNuke.SocialLibrary.Components.Common.Constants" %>
<%@ Register TagPrefix="dnn" TagName="FilePickerUploader" Src="~/controls/filepickeruploader.ascx" %>

<asp:Panel ID="ScopeWrapper" runat="server">
    
    <div class="dnnForm discussions" id="postFields" data-bind="with: model, visible: !$root.showModeration()">
		<div class="dnnFormItem">
			<div class="dnnLabel"><label for="contentTitle"><span class="dnnFormRequired"><%= GetString("lblTitle") %></span></label></div>
			<input type="text" data-bind="value: contentTitle" maxlength="<%= SocialConstants.TitleMaxLength %>" id="contentTitle" class="required answer-add-title" />
		</div>
		<div class="dnnFormItem">
			<div class="dnnLabel"><label for="content"><span class="dnnFormRequired"><%= GetString("lblContent") %></span></label></div>
			<textarea class="required answer-add-content" rows="7" cols="30" id="content"></textarea>
		</div>
		<% if (CanModerate)
		{ %>
		<div class="dnnFormItem">
			<!-- ko ifnot: $root.isMobileView -->
			<div class="dnnLabel"><label for="approved"><span class="dnnFormRequired"><%= GetString("lblApproved") %></span></label></div>
			<input type="checkbox" data-bind="checked: approved" id="approved" class="normalCheckBox"/>
            <!-- /ko -->
            <!-- ko if: $root.isMobileView -->
                <div class="dnnLabel">
				<label for="approvedMobileView"><%= GetString("lblApproved") %></label>
				<input type="checkbox" data-bind="checked: approved" id="approvedMobileView" class="normalCheckBox"/>
            </div>
            <!-- /ko -->
		</div>
		<%} %>
		<% if (HasLockTopic)
		{ %>
            <!-- ko if: topicId() > 0 -->
			<div class="dnnFormItem">
			    <!-- ko ifnot: $root.isMobileView -->
				<div class="dnnLabel"><label for="closed"><span><%= GetString("lblClosed") %></span></label></div>
				<input type="checkbox" data-bind="checked: closed" id="closed" class="normalCheckBox"/> 
                <!-- /ko -->
                <!-- ko if: $root.isMobileView -->
                <div class="dnnLabel">
				    <label for="closedMobileView"><%= GetString("lblClosed") %></label>
				    <input type="checkbox" data-bind="checked: closed" id="closedMobileView" class="normalCheckBox"/>
                </div>
                <!-- /ko -->
			</div>
            <!-- /ko -->
		<%} %>
		<div class="dnnFormItem">
			<div class="dnnLabel"><label for="tags"><span class="dnnFormRequired"><%= GetString("lblTags") %></span></label></div>
			<input type="text" id="tags" class="required" />
		</div>
        <!-- ko ifnot: topicId() > 0 -->
        <div class="dnnFormItem">
            <!-- ko ifnot: $root.isMobileView -->
            <div class="dnnLabel"><label for="subscribe"><%= GetString("lblSubscribe") %></label></div>
            <input type="checkbox" data-bind="checked: $root.subscribeToActivity" id="subscribe" class="normalCheckBox"/>
            <!-- /ko -->
            <!-- ko if: $root.isMobileView -->
            <div class="dnnLabel">
				<label for="subscribeMobileView"><%= GetString("lblSubscribe") %></label>
				<input type="checkbox" data-bind="checked: $root.subscribeToActivity" id="subscribeMobileView" class="normalCheckBox"/>
            </div>
            <!-- /ko -->
        </div>
        <!-- /ko -->
        
        <% if (CanAddAttachments)
           { %>
        <div class="dnnFormItem social-attachment-uploader">
            <dnn:FilePickerUploader ID="ctlAttachment" runat="server" />
            <div class="dnnClear"></div>
            <div class="social-attachment-txt"><span data-bind="html: $root.attachmentsHtml"></span></div>
            <div class="dnnClear"></div>
        </div>
        <% } %>
    </div>
	
	<div class="dnnClear dialog-footer" data-bind="visible: !$root.showModeration()">
	    <ul class="dnnActions dnnRight">
	        <li><a data-bind="click: $root.cancel" class="dnnSecondaryAction"><%= GetString("hlCancel") %></a></li>
            <li><a data-bind="click: $root.save" class="dnnPrimaryAction"><%= GetString("hlSave") %></a></li>
	    </ul>	
	</div>
    
    <div class="dnnClear dnnFormMessage dnnFormSuccess" data-bind="visible: $root.showModeration()">
			<%= GetString("WaitForModeration") %>  
	</div>

	<div class="dnnClear dialog-footer" data-bind="visible: $root.showModeration()">
	    <ul class="dnnActions dnnRight">
	        <li><a data-bind="click: $root.cancel" class="dnnSecondaryAction"><%= GetString("Close") %></a></li>
	    </ul>		
	</div>

</asp:Panel>
<script type="text/javascript">
	function editInit(settings) {
	    settings.moduleScope = $(settings.moduleScope)[0];
	    if (!settings.moduleScope) {
	        return;
	    }

		var validator = new window.dnn.social.Validator($, window.ko, settings);
		settings.validate = validator.validate;
		settings.fileUploadControl = '<%= ctlAttachment.ClientID %>' + '_dnnFileUploadScope';
		var model = <%= SerializedTopicInfo() %>;
		var viewModel = new window.dnn.discussions.EditView($, window.ko, settings, model);
	    try {
	        window.dnn.social.applyBindings(viewModel, settings.moduleScope);
	    } catch(ex) {
	        window.dnn.social.topLevelExceptionHandler(settings, ex);
	    }
	}
</script>