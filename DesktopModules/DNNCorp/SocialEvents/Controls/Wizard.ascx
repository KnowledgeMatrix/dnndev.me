<%@ Control Language="C#" AutoEventWireup="false" CodeBehind="Wizard.ascx.cs" Inherits="DotNetNuke.Professional.SocialEvents.Controls.Wizard" %>
<%@ Import Namespace="DotNetNuke.Services.Localization" %>
<%@ Import Namespace="SocialConstants=DotNetNuke.SocialLibrary.Components.Common.Constants" %>

<asp:Panel ID="ScopeWrapper" runat="server">
	<div id="wizard" class="social-wizard" style="z-index: -1" data-bind="visible: !$root.showModeration()">
	    
		<ul class="wizard-tabs">
			<li id="basic-step">
			    <!-- ko ifnot: isMobileView -->
				<a href="javascript:void(0)" data-bind="click: $root.switchTo0">
					<div class="wizardStep">
						<span class="wizardStepNumber">1</span>
                        <div class="dnnLeft">
                            <span class="wizardStepTitle"><%= Localization.GetString("BasicStepTitle", LocalResourceFile) %></span>
                            <span class="wizardStepDescription"><%= Localization.GetString("BasicStepDescription", LocalResourceFile) %></span>
                        </div>
						
						<span class="wizardStepArrow"></span>
					</div>
				</a>
                <!-- /ko -->
                <!-- ko if: isMobileView -->
                <div class="wizardStep">
					<span class="wizardStepNumber">1</span>
                    <div class="dnnLeft">
                        <span class="wizardStepTitle"><%= Localization.GetString("BasicStepTitle", LocalResourceFile) %></span>
                        <span class="wizardStepDescription"><%= Localization.GetString("BasicStepDescription", LocalResourceFile) %></span>
                    </div>
				</div>
                <!-- /ko -->
			</li>
			<li id="location-step">
			    <!-- ko ifnot: isMobileView -->
				<a href="javascript:void(0)" data-bind="click: $root.switchTo1">
					<div class="wizardStep">
						<span class="wizardStepNumber">2</span>
                        <div class="dnnLeft">
                            <span class="wizardStepTitle"><%= Localization.GetString("LocationStepTitle", LocalResourceFile) %></span>
                            <span class="wizardStepDescription"><%= Localization.GetString("LocationStepDescription", LocalResourceFile) %></span>
                        </div>						
						<span class="wizardStepArrow"></span>
					</div>
				</a>
                <!-- /ko -->
                <!-- ko if: isMobileView -->
                <div class="wizardStep">
					<span class="wizardStepNumber">2</span>
                    <div class="dnnLeft">
                        <span class="wizardStepTitle"><%= Localization.GetString("LocationStepTitle", LocalResourceFile) %></span>
                        <span class="wizardStepDescription"><%= Localization.GetString("LocationStepDescription", LocalResourceFile) %></span>
                    </div>	
				</div>
                <!-- /ko -->
			</li>
			<li id="guest-step">
			    <!-- ko ifnot: isMobileView -->
				<a href="javascript:void(0)" data-bind="click: $root.switchTo2">
					<div class="wizardStep">
						<span class="wizardStepNumber">3</span>
                        <div class="dnnLeft">
                            <span class="wizardStepTitle"><%= Localization.GetString("GuestStepTitle", LocalResourceFile) %></span>
                            <span class="wizardStepDescription"><%= Localization.GetString("GuestStepDescription", LocalResourceFile) %></span>
                        </div>												
					</div>
				</a>
                <!-- /ko -->
                <!-- ko if: isMobileView -->
                <div class="wizardStep">
					<span class="wizardStepNumber">3</span>
                    <div class="dnnLeft">
                        <span class="wizardStepTitle"><%= Localization.GetString("GuestStepTitle", LocalResourceFile) %></span>
                        <span class="wizardStepDescription"><%= Localization.GetString("GuestStepDescription", LocalResourceFile) %></span>
                    </div>												
				</div>
                <!-- /ko -->
			</li>
		</ul>
        
		<div id="basic-page" class="wizardPage">
			<div class="dnnForm idea-container" data-bind="with:model">
				<div class="dnnFormItem dnnFormRequired">
					<div class="dnnLabel"><label for="txtTitle"><span class="dnnFormRequired"><%= Localization.GetString("lblTitle", LocalResourceFile) %></span></label></div>
					<input id="txtTitle" type="text" maxlength="<%= SocialConstants.TitleMaxLength %>" data-bind="value: contentTitle" class="required socialevent-add-title" />
				</div>
				<div class="dnnFormItem">
					<div class="dnnLabel"><label for="txtDetails"><span class="dnnFormRequired"><%= Localization.GetString("lblContent", LocalResourceFile)%></span></label></div>
                    <div class="events">
					   <textarea id="txtDetails" class="required socialevent-add-content"></textarea>
                    </div>
				</div>
				<div class="dnnFormItem dnnFormRequired">
					<div class="dnnLabel"><label for="txtFromDate"><span class="dnnFormRequired"><%= Localization.GetString("lblStart", LocalResourceFile)%></span></label></div>								

                    <div class="dnnLeft dnnMultipleControls">
                        <div class="timeZone">
                            <label><%= Localization.GetString("lblTimeZone", LocalResourceFile) %></label><span data-bind="html: timeOffsetName"></span>
                        </div>                  
                        <input id="txtFromDate" type="text" class="dateInput required customValidate validateStartTimeLaterThanCurrentTime" data-bind="value:startDateString"  maxlength="20" />
                        <div class="timeInput">
                            <span class="timeIndicator"></span>
                            <select id="selectFromTimeHours" data-bind="value: startTimeHours, options: $root.hourOptions, enable: $root.enableTimePicker"></select>
                            <span class="timeSeparator" data-bind="html: $root.timeSeparator"></span>
                            <select id="selectFromTimeMinutes" data-bind="value:startTimeMinutes, enable: $root.enableTimePicker">
                                <option value="00">00</option>
                                <option value="15">15</option>
                                <option value="30">30</option>
                                <option value="45">45</option>
                            </select>
                            <select id="selectFromTimeAMPM" data-bind="visible: $root.showAMPMOptions, value: startTimeAMPM, options: $root.AMPMOptions, enable: $root.enableTimePicker"></select>
                        </div>
                        <div class="allDayEvent">
                            <input type="checkbox" id="chkAllDayEvent" class="normalCheckBox"/>
                            <label for="chkAllDayEvent"><%= Localization.GetString("AllDay", LocalResourceFile) %></label>
                        </div>
                    </div>
				</div>
				<div class="dnnFormItem">
					<div class="dnnLabel"><label for="txtFromDate"><span class="dnnFormRequired"><%= Localization.GetString("lblEnd", LocalResourceFile)%></span></label></div>	
					<div class="dnnLeft dnnMultipleControls">
                        <input id="txtToDate" type="text" class="dateInput required customValidate validateEndTimeLaterThanStartTime" maxlength="20"  data-bind="value:endDateString, enable: $root.enableTimePicker"/>	
                        <div class="timeInput">
                            <span class="timeIndicator"></span>
                            <select id="selectToTimeHours" data-bind="value: endTimeHours, options: $root.hourOptions, enable: $root.enableTimePicker"></select>
                            <span class="timeSeparator" data-bind="html: $root.timeSeparator"></span>
                            <select id="selectToTimeMinutes" data-bind="value:endTimeMinutes,enable: $root.enableTimePicker">
                                <option value="00">00</option>
                                <option value="15">15</option>
                                <option value="30">30</option>
                                <option value="45">45</option>
                            </select>
                            <select id="selectToTimeAMPM" data-bind="visible: $root.showAMPMOptions, value: endTimeAMPM, options: $root.AMPMOptions, enable: $root.enableTimePicker"></select>
                        </div>
                    </div>			
				</div>
                <% if (CanModerate)
	                { %>
                <div class="dnnFormItem">
			        <!-- ko ifnot: $root.isMobileView -->
			        <div class="dnnLabel"><label for="approved"><span class="dnnFormRequired"><%= Localization.GetString("lblApproved", LocalResourceFile) %></span></label></div>
			        <input type="checkbox" data-bind="checked: approved" id="approved" class="normalCheckBox"/>
                    <!-- /ko -->
                    <!-- ko if: $root.isMobileView -->
                        <div class="dnnLabel">
				        <label for="approvedMobileView"><%= Localization.GetString("lblApproved", LocalResourceFile) %></label>
				        <input type="checkbox" data-bind="checked: approved" id="approvedMobileView" class="normalCheckBox"/>
                    </div>
                    <!-- /ko -->
		        </div>
                <% } %>
                <div class="dnnFormItem">
					<div class="dnnLabel"><label for="tags"><span class="dnnFormRequired"><%= Localization.GetString("lblTags", LocalResourceFile) %></span></label></div>
					<input type="text" id="tags" class="required" />
				</div>
			</div>
		</div>
		<div id="location-page" class="wizardPage">
			<div class="dnnForm" data-bind="with:model">
                <div class="dnnFormItem">
					<div class="dnnLabel"><label for="ddlCountry"><span><%= Localization.GetString("lblCountry", LocalResourceFile)%></span></label></div>	
					<select ID="ddlCountry" data-bind="options: $root.countries, value: country"></select>
				</div>
                <div class="dnnFormItem">
					<div class="dnnLabel"><label for="txtRegion"><span><%= Localization.GetString("lblRegion", LocalResourceFile)%></span></label></div>	
					<input ID="txtRegion" type="text" maxlength="50" data-bind="visible: $root.showRegionTextbox" />
                    <select ID="ddlRegion" data-bind="options: $root.regions, visible: $root.showRegionsSelect"></select> 
				</div>
                <div class="dnnFormItem">
					<div class="dnnLabel"><label for="txtAddress"><span><%= Localization.GetString("lblCity", LocalResourceFile)%></span></label></div>	
					<input ID="txtCity" type="text" MaxLength="50" data-bind="value: city" />
				</div>
				<div class="dnnFormItem">
					<div class="dnnLabel"><label for="txtAddress"><span><%= Localization.GetString("lblAddress", LocalResourceFile)%></span></label></div>	
					<input ID="txtAddress" type="text" MaxLength="50" data-bind="value:street" />
				</div>			
				<div class="dnnFormItem">
					<div class="dnnLabel"><label for="txtZip"><span><%= Localization.GetString("lblZip", LocalResourceFile)%></span></label></div>	
					<input ID="txtZip" type="text" maxlength="10" data-bind="value: postalCode" />
				</div>
				
			</div>
		</div>
		<div id="guest-page" class="wizardPage">
			<div class="dnnForm" data-bind="with:model">
                <div class="dnnFormItem">
					<div class="dnnLabel"><label for="chkGuests"><span><%= Localization.GetString("lblSendInvitesTo", LocalResourceFile)%></span></label></div>	
					<select id="selectInvitationOptions">
                        <option value="0"><%= Localization.GetString("optionNone", LocalResourceFile) %></option>
                        <option value="1"><%= string.Format(Localization.GetString("optionAllFriends", LocalResourceFile), FriendsCount) %></option>

                        <% if(GroupId > 0){ %>
                            <option value="2"><%= string.Format(Localization.GetString("optionAllGroup", LocalResourceFile), MembersInGroup) %></option>
                            <option value="3"><%= Localization.GetString("optionAllFriendsAndGroup", LocalResourceFile) %></option>
                            <option value="4"><%= Localization.GetString("optionSelectFriendsAndGroups.Text", LocalResourceFile) %></option>
                        <%}else{ %>
                            <option value="5"><%= Localization.GetString("optionSelectFriends", LocalResourceFile) %></option>
                        <%} %>
                        
					</select>		
				</div>	
                <div class="dnnFormItem" id="inviteFriendsFormItem" style="display: none;">
                    <div class="inviteFriendsDiv">
                        <div class="inviteFriendsSearch">                            
                            <input type="text" class="searchFriendsFilter" placeholder="<%= Localization.GetString("lblFindGuests", LocalResourceFile) %>" />                            
                        </div>
                        <table class="inviteFriendsTable">
                            <thead>
                                <tr>
                                    <th>                                        
                                    </th>
                                    <th>
                                        <span><%= Localization.GetString("FriendName", LocalResourceFile) %></span>
                                    </th>
                                </tr>
                            </thead>
                        </table>
                        <div class="inviteFriendsTable-scrollDiv">
                           <table class="inviteFriendsTable">
                            <tbody>                               
                            </tbody>
                        </table>
                        </div>
                    </div>
                </div>
				<div class="dnnFormItem">
					<div class="dnnLabel"><label><span><%= Localization.GetString("lblOptions", LocalResourceFile)%></span></label></div>	
                    <div class="dnnLeft dnnMultipleControls">
                        <div style="margin-top: -10px">
					        <input id="chkRsvp" data-bind="checked: invitationOnly" type="checkbox" class="normalCheckBox" />
                            <label for="chkRsvp"><%= Localization.GetString("chkRsvp", LocalResourceFile)%></label>									
					    </div>

                        <div>
					        <input id="chkGuestList" data-bind="checked: showGuests" type="checkbox" class="normalCheckBox" />
                            <label for="chkGuestList"><%= Localization.GetString("chkGuestList", LocalResourceFile)%></label>
                        </div>
                    </div>
				</div>
                <div class="dnnFormItem">
                    <div class="dnnLabel"><label for="txtMaxSeats"><span><%= Localization.GetString("lblMaxSeats", LocalResourceFile)%></span></label></div>
                    
                    <div class="dnnLeft dnnMultipleControls">
                         <div>
                            <input id="chkNoAttendeeLimit" type="checkbox" class="normalCheckBox" data-bind="checked: $root.noMaxAttendees" />
                            <label for="chkNoAttendeeLimit"><%= Localization.GetString("lblNoMaxSeats", LocalResourceFile)%></label>
                        </div>
					    <div>
					        <input id="txtMaxSeats" type="text" maxlength="4" data-bind="value: maxAttendees, attr: {disabled: $root.noMaxAttendees }" class="number customValidate validateMaxAttendees" />
                        </div>
                    </div>
				</div>
                <!-- ko if: contentItemId() < 1 -->
                <div class="dnnFormItem">
                <!-- ko ifnot: $root.isMobileView -->
                    <div class="dnnLabel"><label for="subscribe"><%= Localization.GetString("Subscribe", LocalResourceFile) %></label></div>
                    <input type="checkbox" data-bind="checked: $root.subscribeToActivity" id="subscribe" class="normalCheckBox"/>
                <!-- /ko -->
                <!-- ko if: $root.isMobileView -->
                    <div class="dnnLabel">
				        <label for="subscribeMobileView"><%= Localization.GetString("Subscribe", LocalResourceFile) %></label>
				        <input type="checkbox" data-bind="checked: $root.subscribeToActivity" id="subscribeMobileView" class="normalCheckBox"/>
                    </div>
                <!-- /ko -->
                </div>
                <!-- /ko -->	
			</div>
		</div>
		<div class="dnnClear dialog-footer">
		    <ul class="dnnActions dnnRight">
		        <li><a data-bind="click: $root.prev" id="prev" class="dnnSecondaryAction"><%= Localization.GetString("Previous", LocalResourceFile)%></a></li>
                <li><a data-bind="click: $root.next" id="next" class="dnnPrimaryAction"><%= Localization.GetString("Next", LocalResourceFile)%></a></li>
		    </ul>
		</div>
	</div>
    
    <div class="dnnClear dnnFormMessage dnnFormSuccess" data-bind="visible: $root.showModeration()">
			<%= Localization.GetString("WaitForModeration", LocalResourceFile) %>
	</div>
    <div class="dnnClear dialog-footer" data-bind="visible: $root.showModeration">
         <ul class="dnnActions dnnRight">
		    <li><a data-bind="click: $root.cancel" class="dnnSecondaryAction"><%= Localization.GetString("Close", LocalResourceFile) %></a></li>
         </ul>
	</div>
   
</asp:Panel>
<script type="text/javascript">
    function wizardInit(settings) {
        settings.moduleScope = $(settings.moduleScope)[0];
        if (!settings.moduleScope) {
            return;
        }

        settings.validator = new window.dnn.social.Validator($, window.ko, settings);
	    var model = <%= SerializedEventInfo() %>;
        model.groupId = settings.groupId;
        var viewModel = new window.dnn.socialevents.EditView($, window.ko, settings, model);
        try {
            window.dnn.social.applyBindings(viewModel, settings.moduleScope);
        } catch(ex) {
            window.dnn.social.topLevelExceptionHandler(settings, ex);
        }
    }
</script>