<%@ Control Language="C#" AutoEventWireup="false" CodeBehind="HelpDesk.ascx.cs" Inherits="DotNetNuke.Professional.ZendeskTickets.HelpDesk" %>
<%@ Import Namespace="DotNetNuke.Services.Localization" %>
<asp:Panel runat="server" ID="ScopeWrapper" CssClass="moduleZendesk">
    <div class="dnnClear dnn-AdminWrapper hd-view-list">
        <div class="hd-list" data-bind="visible: !creatingTicket() && ticketCount() > 0 && !detailViewActive()">
            <table class="dnnTableDisplay">
                <colgroup>
                    <col class="ticket-id-col"></col>
                    <col class="subject-col"></col>
                    <col class="date-created-col"></col>
                </colgroup>
                <caption></caption>
                <thead>
                    <tr>
                        <th><a href="javascript:void(0)" data-bind="text: resx.ticketNumber"></a></th>
                        <th><a href="javascript:void(0)" data-bind="text: resx.subject"></a></th>
                        <th><a href="javascript:void(0)" data-bind="text: resx.dateCreated"></a></th>
                    </tr>
                </thead>
                <tfoot>
                    <tr>
                        <td colspan="2"></td>
                    </tr>               
                </tfoot>
                <tbody class="ticket-table" data-bind="foreach: ticketList">
                    <tr data-bind="click: openTicket">
                        <td data-bind="text: id || '&nbsp;'"></td>
                        <td data-bind="text: subject || '&nbsp;'"></td>
                        <td data-bind="text: dateCreated || '&nbsp;'"></td>
                    </tr>
                </tbody>
            </table>
        </div>
        <div class="dnnFormMessage dnnFormWarning" data-bind="visible: !creatingTicket() && ticketCount() == 0, text: resx.noActivity"></div>
        <div class="create-toolbar" data-bind="visible: !creatingTicket() && !detailViewActive()">
            <a href="javascript:void(0)" class="dnnPrimaryAction dnnLeft" data-bind="click: openCreate, text: resx.createTicket"></a>    
            <p data-bind="text: ticketCount() + ' ' + ticketLabel()"></p>
        </div>
    </div>
    <div class="dnnClear hd-desk hd-view-create" data-bind="visible: creatingTicket()">
        <h3 data-bind="text: resx.createTicketHeader"></h3>
        <div class="dnnForm">
            <div data-bind="foreach: fields">
                <div data-bind="template: { name: $data.SimpleType + '-template', data: $data}">

                </div>
            </div>

            <div class="dnnClear">
                <ul class="dnnActions">
                    <li><a href="javascript:void(0)" class="dnnPrimaryAction" data-bind="click: saveTicket, text: resx.submitTicket"></a></li>
                    <li><a href="javascript:void(0)" class="dnnSecondaryAction" data-bind="click: closeCreate, text: resx.cmdCancel"></a></li>
                </ul> 
            </div>
        </div>
    </div>
    <div class="dnnClear hd-desk moduleContainer-normalView hd-view-details" data-bind="visible: detailViewActive() && !creatingTicket(), with: detailView">
        <div class="moduleTitleContainer detail-container dnnClear">  
            <div class="title-container dnnLeft">
                <h3 data-bind="text: subject"></h3>
                <p data-bind="text: $parent.resx.ticketNumber + id()"></p>
                <p class="title-returnPrev">
                    <a href="javascript:void(0)" data-bind="text: $parent.resx.backToTickets, click: $parent.backToTickets"></a>&nbsp;
                    <a href="javascript:void(0)" data-bind="text: $parent.resx.refreshTicket, click: refreshTicket"></a>
                </p>            
            </div>
            <div class="info-panel dnnClear">
                <h6 class="created-on"><span data-bind="text: $parent.resx.created"></span> <span data-bind="text: createdDate"></span></h6>
                <h6 class="last-activity"><span data-bind="text: $parent.resx.lastActivity"></span> <span data-bind="text: updatedDate"></span></h6>
            </div>
            <p data-bind="text: description"></p>
            <ul class="ticket-comments" data-bind="foreach: ticketComments">
                <li class="dnnClear">
                    <h6>
                        <span class="user" data-bind="text: user"></span>
                    </h6>
                    <h6>
                        <span class="date" data-bind="text: dateCreated"></span>
                    </h6>
                    <span class="body" data-bind="html: body"></span>
                    <br />
                    <!-- ko if: file && file.length > 0 -->
                    <hr/>
                    <span class="fileLinkTitle" data-bind="text: $root.resx.filesAttached"></span>
                    <div data-bind="foreach: file">
                        <!-- ko if: !isImage -->
                        <div class="fileLinkContainer">
                            <a class="fileLink" data-bind="attr: {'href': content_url}" target="_blank">
                                <span data-bind="text: file_name"></span>
                            </a>
                        </div>
                        <!-- /ko -->
                        <!-- ko if: isImage -->
                        <a class="imageFile" data-bind="attr: {'href': content_url}" target="_blank">             
                            <img data-bind="attr: { 'src': content_url }" class="fileThumb" />
                        </a>
                        <!-- /ko -->
                    </div>
                    <!-- /ko -->
                </li>
            </ul>
            <div class="btn-reply-container">
                <a href="javascript:void(0)" class="dnnPrimaryAction reply-btn" data-bind="text: $parent.resx.comment, click: openCommentBox, visible: replyBtnVisible()"></a>
            </div>
            <div data-bind="attr: {class: commentDivClass() }">
                <textarea data-bind="value: commentText, valueUpdate: 'afterkeydown'"></textarea>
                <div class="file-area">
                <label for="Attachment">Attach File:</label>
                <input type="file" name="Attachment" class="comment-file" multiple>
                </div>
                <a href="javascript:void(0)" class="dnnPrimaryAction" data-bind="text: $parent.resx.comment, click: addComment"></a>
                <a href="javascript:void(0)" class="dnnSecondaryAction" data-bind="text: $parent.resx.cmdCancel, click: closeCommentBox"></a>
            </div>
        </div>
    </div>
    <div class="zd-modal"></div>
    <div class="successmessage" data-bind="visible: successMessageVisible">
	    <span data-bind="text: resx.ticketCreateSuccess"></span>
    </div>

        
    <!-- Knockout Text Input Template -->
    <script type="text/html" id="text-template">
        <div class="dnnClear dnnFormItem">
            <div class="zd-field">
                <label data-bind="attr: {for: 'zd-field-' + id,  title: description}">
                    <span data-bind="text: title_in_portal, attr: { class: (required ? 'dnnFormRequired' : '')}"></span>
                </label>
                <input type="text" class="form-control" data-bind="value: data, valueUpdate: 'afterkeydown', attr: {id: 'zd-field-' + id, name: title_in_portal}">
                <span data-bind="visible: required && !dataValid() && $root.formDirty(), html: (description != '' ? description || $root.resx.requiredField : $root.resx.requiredField)" class="dnnFormError dnnFormMessage"></span>
            </div>
        </div>
    </script>
    
    <!--Knockout RegExp Template-->
    <script type="text/html" id="regexp-template">
        <div class="dnnClear dnnFormItem">
            <div class="zd-field">
                <label data-bind="attr: {for: 'zd-field-' + id,  title: description}">
                    <span data-bind="text: title_in_portal, attr: { class: (required ? 'dnnFormRequired' : '')}"></span>
                </label>
                <input type="text" data-bind="value: data, valueUpdate: 'afterkeydown', attr: {id: 'zd-field-' + id, name: title_in_portal}">
                <span data-bind="visible: required && !dataValid() && $root.formDirty(), html: (description != '' ? description || $root.resx.requiredField : $root.resx.requiredField)" class="dnnFormError dnnFormMessage"></span>
            </div>
        </div>
    </script>

    <!-- Knockout TextArea Template -->
    <script type="text/html" id="textarea-template">
        <div class="dnnClear dnnFormItem">
            <div class="zd-field">
                <label data-bind="attr: {for: 'zd-field-' + id,  title: description}">
                    <span data-bind="text: title_in_portal, attr: { class: (required ? 'dnnFormRequired' : '')}"></span>
                </label>
                <textarea data-bind="value: data, valueUpdate: 'afterkeydown', attr: {id: 'zd-field-' + id, name: title_in_portal}"></textarea>
                <span data-bind="visible: required && !dataValid() && $root.formDirty(), html: (description != '' ? description || $root.resx.requiredField : $root.resx.requiredField)" class="dnnFormError dnnFormMessage"></span>
            </div>
        </div>
    </script>
    
    <!-- Knockout Select Dropdown Template -->
    <script type="text/html" id="tagger-template">
        <div class="dnnClear dnnFormItem">
            <div class="zd-field">
                <div class="zd-select-field">
                    <label data-bind="attr: {for: 'zd-field-' + id,  title: description}">
                        <span data-bind="text: title_in_portal, attr: { class: (required ? 'dnnFormRequired' : '')}"></span>
                    </label>
                    <select class="zd-select-field" data-bind="attr: { id: 'zd-field-' + id, name: title_in_portal, required: required}, value: $data.data, foreach: custom_field_options">
                        <option data-bind="value: value, text: name"></option>
                    </select>
                    <span data-bind="visible: required && !dataValid() && $root.formDirty(), html: (description != '' ? description || $root.resx.requiredField : $root.resx.requiredField)" class="dnnFormError dnnFormMessage"></span>
                </div>
            </div>
        </div>
    </script>
    
    <!-- Knockout File Template -->
    <script type="text/html" id="file-template">
        <div class="dnnClear dnnFormItem">
            <div class="zd-field">
                <div class="zd-select-field">
                    <label data-bind="attr: {for: 'zd-field-' + id,  title: description}">
                        <span data-bind="text: title_in_portal, attr: { class: (required ? 'dnnFormRequired' : '')}"></span>
                    </label>
                    <input type="file" data-bind="attr: { name: title_in_portal}, value: $data.data" class="zd-field-file" multiple/>
                    <span data-bind="visible: required && !dataValid() && $root.formDirty(), html: (description != '' ? description || $root.resx.requiredField : $root.resx.requiredField)" class="dnnFormError dnnFormMessage"></span>
                </div>
            </div>
        </div>
    </script>
    
    <script type="text/javascript">
        $(document).ready(function () {
            var localResx = {
                createTicket: "<%= LocalizeString("CreateTicket") %>",
                subject: "<%= LocalizeString("Subject") %>",
                dateCreated: "<%= LocalizeString("DateCreated") %>",
                createdTicketHeader: "<%= LocalizeString("CreateTicketHeader") %>",
                submitTicket: "<%= LocalizeString("SubmitTicket") %>",
                cmdCancel: "<%= LocalizeString("cmdCancel") %>",
                backToTickets: "<%= LocalizeString("BacktoTickets") %>",
                refreshTicket: "<%= LocalizeString("RefreshTicket") %>",
                comment: "<%= LocalizeString("Comment") %>",
                ticketCreateSuccess: "<%= LocalizeString("TicketCreateSuccess") %>",
                noActivity: "<%= LocalizeString("NoActivity") %>",
                requiredField: "<%= LocalizeString("RequiredField") %>",
                fileUploadFailed: "<%= LocalizeString("FileUploadFailed") %>",
                ticketNumber: "<%= LocalizeString("TicketNumber") %>",
                lastActivity: "<%= LocalizeString("LastActivity") %>",
                created: "<%= LocalizeString("Created") %>",
                ticketLabel: "<%= LocalizeString("TicketLabel") %>",
                filesAttached: "<%= LocalizeString("FilesAttached") %>"
            };

            var helpDesk = new dnn.modules.zendesktickets.Helpdesk(<%= ModuleId %>, localResx, <%= ScopeWrapper.ClientID %>);

            ko.applyBindings(helpDesk, $(<%= ScopeWrapper.ClientID %>).get(0));
        });

    </script>
</asp:Panel>