<%@ Control Language="C#" AutoEventWireup="false" CodeBehind="AskQuestion.ascx.cs" Inherits="DotNetNuke.Professional.Answers.Controls.AskQuestion" %>
<%@ Import Namespace="SocialConstants=DotNetNuke.SocialLibrary.Components.Common.Constants" %>

<asp:Panel ID="ScopeWrapper" runat="server">
	
    <div class="dnnForm" id="postFields" data-bind="with: model, visible: !$root.showModeration()">
        <!-- ko if: parentId() < 1 -->
        <div class="dnnFormItem">
            <div class="dnnLabel">
                <label for="contentTitle">
                    <span class="dnnFormRequired" data-bind="text: $root.titleLabel"></span>
                </label>
            </div>
            <input type="text" data-bind="value: contentTitle" maxlength="<%= SocialConstants.TitleMaxLength %>" id="contentTitle" class="required answer-add-title" />
        </div>
        <!-- /ko -->
        <div class="dnnFormItem">
            <div class="dnnLabel">
                <label for="content">
                    <span class="dnnFormRequired" data-bind="text: $root.descriptionLabel"></span>
                </label>
            </div>
            <textarea class="required answer-add-content" rows="7" cols="30" id="content"></textarea>
        </div>
        <!-- ko if: parentId() < 1 -->
        <% if (CanModerate)
		{ %>
            <div class="dnnFormItem">
            <!-- ko ifnot: $root.isMobileView -->
				<div class="dnnLabel"><label for="approved"><%= GetString("askApproved") %></label></div>
				<input type="checkbox" data-bind="checked: approved" id="approved" class="normalCheckBox"/>
            <!-- /ko -->
            <!-- ko if: $root.isMobileView -->
                <div class="dnnLabel">
				    <label for="approvedMobileView"><%= GetString("askApproved") %></label>
				    <input type="checkbox" data-bind="checked: approved" id="approvedMobileView" class="normalCheckBox"/>
                </div>
            <!-- /ko -->
		    </div>
		<%} %>
        <% if (HasCloseQuestion)
		{ %>
            <!-- ko if: contentItemId() > 0 -->
			<div class="dnnFormItem">
			<!-- ko ifnot: $root.isMobileView -->
				<div class="dnnLabel"><label for="closed"><span><%= GetString("askClosed") %></span></label></div>
				<input type="checkbox" data-bind="checked: closed" id="closed" class="normalCheckBox"/> 
            <!-- /ko -->
            <!-- ko if: $root.isMobileView -->
                <div class="dnnLabel">
				    <label for="closedMobileView"><%= GetString("askClosed") %></label>
				    <input type="checkbox" data-bind="checked: closed" id="closedMobileView" class="normalCheckBox"/>
                </div>
            <!-- /ko -->
			</div>
            <!-- /ko -->
		<%} %>
        <div class="dnnFormItem">
            <div class="dnnLabel">
                <label for="tags">
                    <span class="dnnFormRequired">
                        <%= GetString("askTags") %>
                    </span>
                </label>
            </div>
            <input type="text" id="tags" class="required" />
        </div>
        <!-- ko if: contentItemId() < 1 -->
        <div class="dnnFormItem">
        <!-- ko ifnot: $root.isMobileView -->
            <div class="dnnLabel"><label for="subscribe"><%= GetString("askSubscribe") %></label></div>
            <input type="checkbox" data-bind="checked: $root.subscribeToActivity" id="subscribe" class="normalCheckBox"/>
        <!-- /ko -->
        <!-- ko if: $root.isMobileView -->
            <div class="dnnLabel">
				<label for="subscribeMobileView"><%= GetString("askSubscribe") %></label>
				<input type="checkbox" data-bind="checked: $root.subscribeToActivity" id="subscribeMobileView" class="normalCheckBox"/>
            </div>
        <!-- /ko -->
        </div>
        <!-- /ko -->
        <!-- /ko -->
    </div>
    
    <div class="dnnClear dialog-footer" data-bind="visible: !$root.showModeration()">
        <ul class="dnnActions dnnRight">
	        <li><a data-bind="click: $root.cancel" class="dnnSecondaryAction"><%= GetString("Cancel") %></a></li>   
            <li><a id="savePost" data-bind="click: $root.save, text: $root.saveLabel" class="dnnPrimaryAction"></a></li>       
        </ul>
    </div>
    
    <div class="dnnClear dnnFormMessage dnnFormSuccess" data-bind="visible: $root.showModeration()">
			<%= GetString("WaitForModeration") %>  
	</div>

    <div class="dnnClear dialog-footer" data-bind="visible: $root.showModeration()">
        <ul class="dnnActions dnnRight">
            <li><a data-bind="click: cancel" class="dnnSecondaryAction"><%= GetString("Close") %></a></li>
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
	    var model = <%= SerializedQuestionInfo() %>;
        try {
            var viewModel = new window.dnn.answers.EditView($, window.ko, settings, model);
            window.dnn.social.applyBindings(viewModel, settings.moduleScope);
        } catch(ex) {
            window.dnn.social.topLevelExceptionHandler(settings, ex);
        }
    }
</script>