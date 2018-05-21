
window.dnn.modules.zendesktickets.Helpdesk = function (moduleId, resx, scopeWrap) {
    var self = this;

    (function (window) {
        // Check Location
        if (document.location.protocol === 'file:') {
            alert('The HTML5 History API (and thus History.js) do not work on files, please upload it to a server.');
        }

        // Establish Variables
        var History = window.History; // Note: We are using a capital H instead of a lower h

        // Bind to State Change
        History.Adapter.bind(window, 'statechange', function () { // Note: We are using statechange instead of popstate
            var state = History.getState(); // Note: We are using History.getState() instead of event.state

            if (state.data != null) {
                var data = state.data;

                var view = data.view;
                var ticketId = data.ticketId;

                if (view === "getTicket") {
                    self._getTicket(ticketId);
                    self.creatingTicket(false);
                    self.detailViewActive(true);
                } else if (view === "getTickets") {
                    self._getTickets();
                    self.detailViewActive(false);
                } else if (view === "createTicket") {
                    self._openCreate();
                } else {
                    self._getTickets();
                    self.detailViewActive(false);
                }
            }
        });
    })(window);
    var requestService; //service framework

    self.resx = resx;

    self.creatingTicket = ko.observable(false);
    self.detailViewActive = ko.observable(false);
    self.successMessageVisible = ko.observable(false);

    self.fields = ko.observableArray([]);
    self.ticketList = ko.observableArray([]);

    self.ticketCount = ko.observable(0);
    self.ticketLabel = ko.observable(resx.ticketLabel.replace("{0}", "s"));

    self.formValid = ko.computed(function () {
        var invalidItemExists = false;
        $.each(self.fields(), function (index, value) {
            if (!value.dataValid()) {
                invalidItemExists = true;
            }
        });

        return !invalidItemExists;
    });
    self.formDirty = ko.observable(false);

    self.detailView = {
        id: ko.observable(-1),
        subject: ko.observable(""),
        description: ko.observable(""),
        createdDate: ko.observable(""),
        updatedDate: ko.observable(""),
        ticketComments: ko.observableArray([]),
        commentText: ko.observable(""),
        commentDivClass: ko.observable("dnnClear commentArea closed"),
        replyBtnVisible: ko.observable(true),
        openCommentBox: function () {
            var $this = this;
            $this.commentDivClass("dnnClear commentArea");
            $this.replyBtnVisible(false);
            $this.commentText("");
        },
        closeCommentBox: function () {
            var $this = this;
            $this.commentDivClass("dnnClear commentArea closed");
            setTimeout(function () {
                $this.replyBtnVisible(true);
                self.cleanTicketCommentCreationForm();
            }, 1500);
        },
        addComment: function () {
            self.addComment(this.id(), this.commentText());
        },
        refreshTicket: function () {
            self.refreshTicket(this.id());
        }
    };

    self.cleanTicketCommentCreationForm = function () {
        self.detailView.commentText("");
        $(scopeWrap).find(".comment-file").val("").trigger("change");
    };

    self.addComment = function (ticketId, body) {
        var postData = new FormData();

        var commentPayload = {
            TicketId: ticketId,
            Body: body
        }

        //check for a file upload control
        var fileControls = $(scopeWrap).find(".comment-file");
        var commentIsValid = true;
        var invalidFiles = [];

        if (fileControls.length > 0) {
            var files = fileControls.get(0).files;
            $.each(files, function (index, file) {
                if (file.size <= 0) {
                    commentIsValid = false;
                    invalidFiles.push(file.name);
                } else {
                    postData.append("UploadedFile" + index, file);
                }
            });

        }

        postData.append("Fields", JSON.stringify(commentPayload));

        function successCallback() {
            self.cleanTicketCommentCreationForm();
            self.loadComments(ticketId);
            self.detailView.closeCommentBox();
            $(scopeWrap).children('.comment-file').dnnFileInput();
        };

        if (commentIsValid) {
            requestService.fileRequest("ZendeskTickets", "ZendeskTickets", "CreateComment", "POST", postData, successCallback);
        } else {
            $.dnnAlert({
                text: resx.fileUploadFailed.replace("{0}", invalidFiles.join(", "))
            });
        }
    }

    self.closeCreate = function () {
        window.history.back();
    }

    self._openCreate = function() {
        self.creatingTicket(true);
        self.cleanTicketCreationForm();
    }

    self.openCreate = function () {
        History.pushState({ view: 'createTicket' }, "", "?view=createTicket&t=" + self.fetch_unix_timestamp());
    };

    self.backToTickets = function () {
        self.getTickets(function deactivateDetailView() {
            self.detailViewActive(false);
        });
    }

    self.refreshTicket = function (ticketId) {
        self.getTicket(ticketId);
    };

    self.getTicketFields = function () {
        requestService.request("ZendeskTickets", "ZendeskTickets", "GetTicketFields", "GET", {}, function successCallback(tickets) {
            var _tickets = [];
            $.each(tickets, function (index, value) {
                value.data = ko.observable("");
                value.dataValid = ko.observable(true);
                _tickets.push(value);
            });
            self.fields(_tickets);

            self.subscribeToFields();
        });
    };

    self.toggleDetailView = function () {
        self.detailViewActive(!self.detailViewActive());
    };

    self.fetch_unix_timestamp = function () { return (new Date().getTime().toString().substring(0, 10)); };

    self._getTicket = function(ticketId) {
        self.detailView.closeCommentBox();
        function successCallback(ticket) {
            self.detailView.id(ticket.id);
            self.detailView.subject(ticket.subject);
            self.detailView.description(ticket.description);
            self.detailView.createdDate(moment(ticket.createdDate).fromNow());
            self.detailView.updatedDate(moment(ticket.updatedDate).fromNow());
            self.loadComments(ticket.id);
        }
        requestService.request("ZendeskTickets", "ZendeskTickets", "GetTicket", "GET", { TicketId: ticketId }, successCallback);
    }

    self.getTicket = function (ticketId) {
        History.pushState({ view: 'getTicket', ticketId: ticketId }, "", "?view=getTicket&ticketId=" + ticketId + "&t=" + self.fetch_unix_timestamp());
    };

    function checkIfFileIsImage(value) {
        $.each(value.file, function (fileIndex, fileData) {
            var fileType = fileData.content_type;
            if (fileType === "image/png" || fileType === "image/jpg" || fileType === "image/jpeg"
                || fileType === "image/gif") {
                fileData.isImage = true;
            } else {
                fileData.isImage = false;
            }
        });
    }

    self.attachPhotoLightBoxes = function() {
        var images = [];
        var links = $(scopeWrap).find('.imageFile');
        links.each(function () {
            var href = $(this).attr('href');
            if (href) images.push(href);
        });

        $(scopeWrap).find('.imageFile').each(function (index) {
            var imageFile = $(this);
            imageFile.on('click', function () {
                window.dnn.social.attachPhotoLightbox(images, index);
                return false;
            });
        });
    }

    self.loadComments = function (ticketId) {
        var commentList = [];
        function successCallback(comments) {
            $.each(comments, function (index, value) {
                if (value.file) {
                    checkIfFileIsImage(value);
                }
                var comment = {
                    user: value.user,
                    dateCreated: moment(value.date).fromNow(),
                    body: value.body.replace(/(?:\r\n|\r|\n)/g, '<br/>'),
                    file: value.file
                }
                commentList.push(comment);
            });
            self.detailView.ticketComments(commentList);
            $(scopeWrap).find('.comment-file').dnnFileInput();
            self.detailViewActive(true);
            self.attachPhotoLightBoxes();
        }
        requestService.request("ZendeskTickets", "ZendeskTickets", "GetComments", "GET", { TicketId: ticketId }, successCallback);
    };

    self.updateTicketLabel = function () {
        (self.ticketCount() > 1 || self.ticketCount() == 0) ? self.ticketLabel(resx.ticketLabel.replace("{0}", "s")) : self.ticketLabel(resx.ticketLabel.replace("{0}", ""));
    }

    self._getTickets = function (callback) {
        function successCallback(tickets) {

            self.ticketCount(tickets.length);

            var _tickets = [];

            $.each(tickets, function (index, value) {
                var ticket = {
                    subject: value.subject,
                    dateCreated: value.date,
                    id: value.id,
                    openTicket: function (ticket, target) {
                        self.getTicket(ticket.id);
                    }
                }
                _tickets.push(ticket);
            });
            self.creatingTicket(false);
            self.cleanTicketCreationForm();
            self.updateTicketLabel();
            self.ticketList(_tickets);
        }
        requestService.request("ZendeskTickets", "ZendeskTickets", "GetTickets", "GET", {}, successCallback, null, callback);
    };

    self.getTickets = function () {
        History.pushState({ view: "getTickets" }, "", "?view=getTickets&t=" + self.fetch_unix_timestamp());
    }

    self.cleanTicketCreationForm = function () {
        self.fields([]);
        self.getTicketFields();
        self.formDirty(false);
        $(scopeWrap).find(".zd-field-file").val("").trigger("change");
    };

    self.checkFormFields = function() {
        $.each(self.fields(), function (i, v) {
            var field = self.fields()[i];
            field.data.valueHasMutated();
            field.dataValid.valueHasMutated();
        });
    }

    self.saveTicket = function() {
        self.checkFormFields();
        if (self.formValid()) {
            var postData = new FormData();
            var ticket = [];
            $.each(self.fields(), function(index, value) {
                var fieldData = {
                    Id: 'zd-field-' + value.id,
                    Name: value.title_in_portal,
                    Value: value.data()
                };
                ticket.push(fieldData);
            });

            //check for a file upload control
            var fileControls = $(scopeWrap).find(".zd-field-file");

            var ticketIsValid = true;
            var invalidFiles = [];

            if (fileControls.length > 0) {
                var files = fileControls.get(0).files;
                $.each(files, function (index, file) {
                    if (file.size <= 0) {
                        ticketIsValid = false;
                        invalidFiles.push(file.name);
                    } else {
                        postData.append("UploadedFile" + index, file);
                    }
                });
            }

            postData.append("Fields", JSON.stringify({ Fields: ticket }));

            function successCallback(data) {
                self.showSuccessGlimpse();
                self.getTicket(data.Result);
            }

            if (ticketIsValid) {
                requestService.fileRequest("ZendeskTickets", "ZendeskTickets", "CreateTicket", "POST", postData, successCallback, null, function(data) {
                    self.cleanTicketCreationForm();
                });
            } else {
                $.dnnAlert({
                    text: resx.fileUploadFailed.replace("{0}", invalidFiles.join(", "))
                });
            }
        }
    };

    self.showSuccessGlimpse = function () {
        self.successMessageVisible(true);
        setTimeout(function () {
            self.successMessageVisible(false);
        }, 1500);
    }

    self.subscribeToFields = function () {
        $.each(self.fields(), function (i, v) {
            var field = self.fields()[i];
            field.data.subscribe(function (data) {
                self.formDirty(true);
                var regex = field.regexp_for_validation || "(.*?)";
                    var reg = new RegExp(regex);
                    if (field.required) {
                        if (data !== "" && reg.test(data)) {
                            field.dataValid(true);                            
                        } else {
                            field.dataValid(false);
                        }
                        field.dataValid.valueHasMutated();
                    }
            });
        });
    };

    self.init = function () {
        requestService = dnn.modules.zendesktickets.RequestUtils;
        requestService.init(moduleId);
        self.getTicketFields();
        self._getTickets();
    };

    self.init();
};