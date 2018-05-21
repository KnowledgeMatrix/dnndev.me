<%@ Control Language="C#" AutoEventWireup="false" CodeBehind="EditorControl.ascx.cs" Inherits="DotNetNuke.Professional.Ideas.Controls.EditorControl" %>
<%@ Import Namespace="SocialConstants=DotNetNuke.SocialLibrary.Components.Common.Constants" %>
<div data-bind="stopBindings: true">	
	<asp:Panel ID="ScopeWrapper" runat="server">
		<asp:Panel runat="server" id="ContentPanel">	
		    <div class="dnnClear dnnFormMessage dnnFormSuccess" data-bind="visible: $root.showModeration()">
				    <%= GetString("WaitForModeration") %>  
		    </div>
		    <div id="postFields" class="dnnForm idea-container" data-bind="with: model, visible: !$root.showModeration()">
			    <div class="dnnFormItem">
				    <div class="dnnLabel"><label for="contentTitle"><span class="dnnFormRequired"><%= GetString("lblTitle") %></span></label></div>
				    <input type="text" data-bind="value: contentTitle" maxlength="<%= SocialConstants.TitleMaxLength %>" id="contentTitle" class="required idea-add-title" />
			    </div>
			    <div class="dnnFormItem">
				    <div class="dnnLabel"><label for="txtArea"><span class="dnnFormRequired"><%= GetString("lblDescription") %></span></label></div>
				    <textarea class="required idea-add-content" rows="7" cols="30" id="txtArea"></textarea>
			    </div>
			
			       <% if (Idea == null)
			       {
				       if (VotingEnabled)
				       { %>
						    <div class="dnnFormItem" runat="server" style="margin-bottom: 18px;">
							    <div class="dnnLabel"><label for="tags"><span><%= GetString("lblInitialVotes") %></span></label></div>
                                
                                <!-- ko ifnot: $root.isMobileView -->
							    <div class="share-idea-vote-options">
								    <div data-bind="with: $root.model().voteButtons">                                       
									    <!-- ko foreach: buttons() -->
									        <!-- ko if: disabled -->
										    <a href="javascript:void(0)" data-bind="attr: { 'class': 'button ' + type, 'title' : title}">
											    <span data-bind="text: text"></span>
										    </a>
										    <!-- /ko -->

										    <!-- ko ifnot: disabled -->
										    <a href="javascript:void(0)" data-bind="click: $parent.changeInitialVotes, attr: { 'class': 'button ' + type, 'title' : title, 'data-vote' : value }">
											    <span data-bind="text: text"></span>
										    </a>
										    <!-- /ko -->

									    <!-- /ko -->
								    </div>
							    </div>
                                <!-- /ko -->  
                                
                                <!-- ko if: $root.isMobileView -->
                                <div class="dnnMobile-share-idea-vote-options">
                                    <div data-bind="with: $root.model().voteButtons">
                                        <!-- ko foreach: buttons() -->
                                            <!-- ko if: disabled -->
                                            <a href="javascript:void(0)" data-bind="attr: { 'class': 'button ' + type }">
                                                <span data-bind="text: textMobileView"></span>
                                            </a>
                                            <!-- /ko -->

                                            <!-- ko ifnot: disabled -->
                                            <a href="javascript:void(0)" data-bind="click: $parent.changeInitialVotes, attr: { 'class': 'button ' + type }">
                                                <span data-bind="text: textMobileView"></span>
                                            </a>
                                            <!-- /ko -->

                                        <!-- /ko -->
                                        <div class="dnnClear"></div>
                                    </div>
                                </div>
                                <!-- /ko -->
						    </div>
				     <% }
			       } %>			
				    <% if (VocabularyId > 1)
				    { %>
				    <div id="categories">
				        <div class="dnnFormItem">
					        <div class="dnnLabel"><label for="type"><span><%= GetString("lblType") %></span></label></div>
					        <select data-bind="options: $root.ideaTypes, optionsText: 'name', optionsValue: 'termId', value: typeId" id="type"></select>
				        </div>
				         <div class="dnnFormItem">
					        <div class="dnnLabel"><label for="category"><span class="dnnFormRequired"><%= GetString("lblCategory") %></span></label></div>
					        <select data-bind="options: $root.categories, optionsText: 'name', optionsValue: 'termId', value: categoryId" id="category"></select>
				        </div>
			        </div>		  
				    <% } %>    
			    <div class="dnnFormItem" data-bind="visible: $root.moderator">
			        <!-- ko ifnot: $root.isMobileView -->
				        <div class="dnnLabel"><label for="authorized"><span><%= GetString("lblAuthorized") %></span></label></div>
				        <input type="checkbox" data-bind="checked: authorized" id="authorized" class="normalCheckBox" style="display:inline-block; margin-top: 6px" />
                    <!-- /ko -->
                    <!-- ko if: $root.isMobileView -->
                        <div class="dnnLabel">
                            <label for="authorizedMobileView"><span><%= GetString("lblAuthorized") %></span></label>
                            <input type="checkbox" data-bind="checked: authorized" id="authorizedMobileView" class="normalCheckBox" />
                        </div>
                    <!-- /ko -->
			    </div>
                <div class="dnnFormItem" data-bind="visible: $root.moderator">
			        <!-- ko ifnot: $root.isMobileView -->
				        <div class="dnnLabel"><label for="closed"><span><%= GetString("lblClosed") %></span></label></div>
				        <input type="checkbox" data-bind="checked: protected" id="closed" class="normalCheckBox" style="display:inline-block; margin-top: 6px" />
                    <!-- /ko -->
                    <!-- ko if: $root.isMobileView -->
                        <div class="dnnLabel">
                            <label for="authorizedMobileView"><span><%= GetString("lblClosed") %></span></label>
                            <input type="checkbox" data-bind="checked: protected" id="closedMobileView" class="normalCheckBox" />
                        </div>
                    <!-- /ko -->
			    </div>

			    <div class="dnnFormItem" data-bind="visible: $root.moderator">
				    <div class="dnnLabel"><label for="status"><span><%= GetString("lblStatus") %></span></label></div>
				    <select data-bind="options: $root.statusList, optionsValue: 'value', optionsText: 'status', value: status" id="status"></select>
			    </div>
			    <div class="dnnFormItem">
				    <div class="dnnLabel"><label for="ideas-edit-tags"><span class="dnnFormRequired"><%= GetString("lblTags") %></span></label></div>
				    <input type="text" id="ideas-edit-tags" class="required" />
			    </div>
			    <!-- ko ifnot: ideaId() > 0 -->
			    <div class="dnnFormItem">
			        <!-- ko ifnot: $root.isMobileView -->
				        <div class="dnnLabel"> <label for="subscribe"><%= GetString("lblSubscribe") %></label></div>
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
		    <div class="dnnClear dialog-footer">
		        <ul class="dnnActions dnnRight">
			        <li><a id="btnCancel" href="#" data-bind="click: $root.cancel, visible: !$root.showModeration()" class="dnnSecondaryAction"><%= GetString("Cancel") %></a></li>
                    <li><a id="btnSaveIdea" href="#" data-bind="click: $root.save, visible: !$root.showModeration()" class="dnnPrimaryAction">
				        <% if (Idea != null)
				           { %>
					        <%= GetString("Update") %>
				        <% }
				           else
				           { %>
					        <%= GetString("Create") %>
				        <% } %>
			        </a></li>
			        <li><a href="#" data-bind="click: $root.cancel, visible: $root.showModeration()" class="dnnSecondaryAction"><%= GetString("Close") %></a></li>
                </ul>
		    </div>		
		</asp:Panel>
		<asp:Panel runat="server" ID="InfoPanel" Visible="False" CssClass="dnnFormMessage dnnFormInfo">
			<asp:Label runat="server" ID="lblMsg"></asp:Label>
		</asp:Panel>
	</asp:Panel>
</div>
<script type="text/javascript">

	function editInit(settings) {
	    settings.moduleScope = $(settings.moduleScope)[0];
	    if (!settings.moduleScope) {
	        return;
	    }

		var validator = new window.dnn.social.Validator($, window.ko, settings);
		settings.validate = validator.validate;
		settings.buttonsContainerClass = 'share-idea-vote-options';
		var model = <%= SerializedIdeaInfo() %>;
	    try {
	        window.dnn.social.applyBindings(new window.dnn.ideas.EditView($, window.ko, settings, model), settings.moduleScope);
		} catch(ex) {
			window.dnn.social.topLevelExceptionHandler(settings, ex);
		}
	}
</script>