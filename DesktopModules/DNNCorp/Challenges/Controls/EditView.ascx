<%@ Control Language="C#" AutoEventWireup="false" CodeBehind="EditView.ascx.cs" Inherits="DotNetNuke.Professional.Challenges.Controls.EditView" %>
<asp:Panel ID="ScopeWrapper" CssClass="dnnSocial-Challenges" runat="server">
    <div class="dnnForm" id="postFields" data-bind="with: model">
        <div id="stepOne">
            <div class="loading" data-bind="visible: $root.updatingUrl"></div>
            <div class="dnnFormItem">
                <div class="dnnLabel"><label for="challengeType"><span class="dnnFormRequired"><%= GetString("lblChallengeType") %></span></label></div>
                <select data-bind="options: $root.challengeTypes, optionsValue: 'value', optionsText: 'challengeType', value: challengeTypeId, enable: $root.enableChallengeType" id="challengeType"></select>
            </div>
            <div class="dnnFormItem">
                <div class="dnnLabel"><label for="webUrl"><span class="dnnFormRequired"><%= GetString("lblWebAddress") %></span></label></div>
                <input type="text" data-bind="value: url" maxlength="150" id="webUrl" class="required customValidate validateUrl answer-add-title" placeholder="http://" />
            </div>
            <div id="image-area">
                <div id="imagePreviewer">
                    <span data-bind="visible: $root.urlImage() !== null">
                        <em>
                            <img data-bind="attr: { src: $root.urlImage() }" alt=""/>
                        </em>
                    </span>
                </div>
                <div id="linkInfo">
                    <b data-bind="html: $root.urlTitle"></b>
                    <p data-bind="html: $root.urlDescription" style="margin: 0"></p>
                </div>
                <div class="dnnClear"></div>
            </div>
		    <div class="dnnFormItem">
			    <div class="dnnLabel"><label for="contentTitle"><span class="dnnFormRequired"><%= GetString("lblTitle") %></span></label></div>
			    <input type="text" data-bind="value: contentTitle" maxlength="150" id="contentTitle" class="required" />
		    </div>
		    <div class="dnnFormItem">
			    <div class="dnnLabel"><label for="content"><span class="dnnFormRequired"><%= GetString("lblContent") %></span></label></div>
			    <textarea contenteditable="true" id="content" data-bind="value: content" class="required answer-add-content" rows="12" cols="30" maxlength="2000"></textarea>
		    </div>
            <div class="dnnFormItem">
                <div class="dnnLabel"><label for="points"><span class="dnnFormRequired"><%= GetString("lblPoints") %></span></label></div>
                <input type="text" data-bind="value: repPoints" max="9999" id="points" class="required number positivenumber"  />
            </div>
        </div>

        <div id="stepTwo" style="display:none;">
            <div class="dnnFormItem" data-bind="visible: $root.socialNetworksVisible">
                <div class="dnnLabel"><label for="messageToShare"><span class="dnnFormRequired"><%= GetString("lblSocialNetworks") %></span></label></div>
                <ul class="networkCheckboxes" data-bind="foreach: $root.networks, visible: $root.networks().length > 0">
                    <li class="networkCheckbox" data-bind="attr: { id: name }, css: { selected: selected }, click: $root.toggleNetwork">
                        <span data-bind="visible: selected() && name !== 'google', html: count, css: { red: count() < 0 }"></span>
                    </li>
                </ul>
                <span data-bind="visible: $root.networks().length == 0"><%= GetString("lblNoSocialNetworks") %></span>
                <input type="text" style="display: none" class="customValidate socialnetworksRequired"/>
            </div>
            <div class="dnnFormItem" data-bind="visible: $root.socialNetworksVisible">
			    <div class="dnnLabel"><label for="messageToShare"><span class="dnnFormRequired"><%= GetString("lblMessageToShare") %></span></label></div>
			    <textarea id="messageToShare" data-bind="value: messageToShare, valueUpdate: 'input'" class="customValidate sharedMessageRequired" rows="12" cols="30"></textarea>
                <i class="edit-message-btn" data-bind="click: $root.toggleEditPermission"></i>
            </div>
            <div class="dnnFormItem">
                <% if (GroupId < 0) { %>
                    <div class="dnnLabel"><label for="invites"><span class="dnnFormRequired"><%= GetString("lblAvailableTo") %></span></label></div>
                    <input type="text" id="invites" class="customValidate inviteesRequired" maxlength="500" />
                <% } else { %>
                    <div class="dnnLabel"><span class="dnnFormRequired"><%= GetString("lblAvailableTo") %></span></div>
                    <input type="text" class="inviteesRequired" maxlength="500" value="<%= DisplayGroupName %>" disabled />
                <% } %>
            </div>
            <div class="dnnFormItem timeInput">
                <div class="dnnLabel"><label for="messageToShare"><span class="dnnFormRequired"><%= GetString("lblExpirationDate") %></span></label></div>
                 <div class="timeZone">
                            <label>Time Zone:</label><span data-bind="html: timeOffsetName"></span>
                        </div> 
                <input id="txtExpirationDate" type="text" style="width:100px;" class="dateInput required customValidate validateExpirationLaterThanCurrentTime" data-bind="value: expirationDate" />
                <div class="timeInput">
                    <select id="selectExpirationHours" style="width:60px;" data-bind="value: expirationHours, options: $root.hourOptions"></select>
                    <span class="timeSeparator" data-bind="html: $root.timeSeparator"></span>
                    <select id="selectExpirationMinutes" style="width:60px;" data-bind="value:expirationMinutes">
                        <option value="00">00</option>
                        <option value="15">15</option>
                        <option value="30">30</option>
                        <option value="45">45</option>
                    </select>
                    <select id="selectExpirationAMPM" style="width:60px;"  data-bind="visible: $root.showAMPMOptions, value: expirationAMPM, options: $root.AMPMOptions"></select>
                </div>
            </div>
            <div class="dnnFormItem">
			    <div class="dnnLabel"><label for="tags"><span class="dnnFormRequired"><%= GetString("lblTags") %></span></label></div>
			    <input type="text" id="tags" class="required" />
		    </div>
            <!-- ko ifnot: challengeId() > 0 -->
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
        </div>
    </div>
	<div class="dnnClear dialog-footer">
	    <ul class="dnnActions dnnRight">
            <li><a data-bind="click: $root.cancel" id="hlCancel" class="dnnSecondaryAction"><%= GetString("hlCancel") %></a></li>
            <li><a data-bind="click: $root.next, css: { 'disabled': updatingUrl }" id="hlNext" class="dnnPrimaryAction"><%= GetString("hlNext") %></a></li>
            <li><a data-bind="click: $root.previous" style="display:none;" id="hlPrevious" class="dnnSecondaryAction"><%= GetString("hlPrevious") %></a></li>
            <li><a data-bind="click: $root.save" style="display:none;" id="hlFinish" class="dnnPrimaryAction"><%= GetString("hlFinish") %></a></li>
	    </ul>
	</div>
</asp:Panel>
<script type="text/javascript">
	function editChallengeInit(settings) {
	    settings.moduleScope = $(settings.moduleScope)[0];
	    if (!settings.moduleScope) {
	        return;
	    }
		var validator = new window.dnn.social.Validator($, window.ko, settings);
		settings.validate = validator.validate;
		var model = <%= SerializedChallenge() %>;
	    try {
		    window.dnn.social.applyBindings(new window.dnn.challenges.EditView($, window.ko, settings, model), settings.moduleScope);
	    } catch(ex) {
	        window.dnn.social.topLevelExceptionHandler(settings, ex);
	    }
	}
</script>