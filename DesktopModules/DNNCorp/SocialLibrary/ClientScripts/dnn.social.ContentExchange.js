// DotNetNuke® - http://www.dnnsoftware.com
//
// Copyright (c) 2002-2016, DNN Corp.
// All rights reserved.

if (typeof dnn === 'undefined' || !dnn) dnn = {};
if (typeof dnn.social === 'undefined') dnn.social = {};

(function (dnn) {
    'use strict';

    dnn.social.ContentExchange = function ContentExchange($, ko, settings) {
        var that = this;

        this.social = new dnn.social.Module(settings);

        this.socialContentTypeId = ko.observable(1);
        this.socialContentTypeName = ko.observable('');
        this.tabId = ko.observable(-1);
        this.moduleId = ko.observable(-1);
        this.contentItemId = ko.observable(settings.contentItemId);
        this.sourceModuleId = settings.moduleId;
        this.groupId = ko.observable(-1);
        this.isGroupPage = ko.observable(false);
        this.destinationData = null;
        this.childId = ko.observable(-1);
        this.contentTitle = ko.observable('');
        this.commentId = ko.observable(-1);

        this.destinationsList = ko.observableArray([]);
        this.tabsList = ko.observableArray([]);
        this.modulesList = ko.observableArray([]);
        
        this.actionTitle = ko.observable('');
        this.actionTitle2 = ko.observable('');
        this.methodName = ko.observable('');
        this.sourceContentType = ko.observable(settings.sourceContentType);
        this.sourceContentTypeId = ko.observable(settings.sourceContentTypeId);
        this.title = ko.computed(function () { return that.actionTitle() + ' ' + that.sourceContentType() + ' ' + that.actionTitle2(); });
        this.summary = ko.observable('');
        this.includeSelfContentItem = ko.observable(false);
        this.initalTextSearch = ko.observable('');
        this.hasComments = ko.observable(true);
        
        this.groupsList = ko.observableArray([]);

        this.availableTypes = ko.observableArray([]);
        this.articleTypeId = ko.observable(-1);
        this.isWikiModule = ko.observable(false);
        this.isWikiModuleVisible = ko.computed(function () { return that.isWikiModule() && that.methodName() != 'MoveToComment' && that.methodName() != 'MoveChildToComment'; });

        this.isPageVisible = ko.computed(function () { return that.tabsList().length > 1; });
        this.isModuleVisible = ko.computed(function () { return that.modulesList().length > 1; });
        this.isGroupVisible = ko.computed(function () { return that.isGroupPage() && that.groupsList().length > 0; });

        this.copyComments = ko.observable(true);
        this.isCopyCommentsVisible = ko.computed(function () { return that.methodName() == 'Copy' && that.hasComments(); });
        this.isParentVisible = ko.computed(function () { return that.methodName() == 'MoveToComment' || that.methodName() == 'MoveChildToComment'; });
        this.isContentTitleVisible = ko.computed(function() {
            return (that.childId() > 0 && (that.methodName() == 'Move' || that.methodName() == 'Copy'))
                || that.methodName() == 'MoveComment' || that.methodName() == 'CopyComment';
        });

        this.componentFactory = this.social.getComponentFactory();
        this.contentExchangeSearch = new dnn.social.ContentExchangeSearch($, ko, settings, this.social,
        {
            tabId: function() {
                return that.tabId();
            },
            moduleId: function() {
                return that.moduleId();
            },
            groupId: function() {
                return that.groupId();
            },
            isGroupPage : function() {
                return that.isGroupPage();
            },
            includeSelfContentItem : function() {
                return that.includeSelfContentItem();
            }
        });
        this.componentFactory.register(this.contentExchangeSearch);

        var pager = this.social.getPagingControl('ContentExchangeSearch');
        if (pager != null) {
            pager.page.subscribe(this.contentExchangeSearch.load);
        }

        this.componentFactory.register(pager);

        this.pagingControl = ko.computed(
            function () {
                var pagingControl = that.componentFactory.resolve('PagingControl');
                if (pagingControl != null) {
                    return pagingControl.markup();
                }

                return new String();
            });

        this.load = function () {
            this.contentExchangeSearch.clear();
            this.contentExchangeSearch.loadStart();
        };

        this.getParentContentItemId = function() {
            for (var i = 0; i < that.contentExchangeSearch.results().length; i++) {
                var parent = that.contentExchangeSearch.results()[i];
                if (parent.isSelected()) {
                    return parent.item().contentItemId;
                }
            };
            return -1;
        };

        this.localizer = function () {
            return this.social.getLocalizationController();
        };

        var validator = new window.dnn.social.Validator($, window.ko, settings);
        this.validate = validator.validate;

        this.customValidators = [
            {
                name: 'validateArticleType',
                validate: function() {
                    return !that.isWikiModule() || that.articleTypeId() > 0;
                },
                errorMsg: that.localizer().getString('FieldIsRequired')
            },
            {
                name: 'validateGroup',
                validate: function() {
                    return !that.isGroupPage() || that.groupId() > 0;
                },
                errorMsg: that.localizer().getString('ThereAreNoGroups')
            },
            {
                name: 'validateParent',
                validate: function() {
                    return that.methodName() != 'MoveToComment' || that.methodName() != 'MoveChildToComment' || that.getParentContentItemId() > 0;
                },
                errorMsg: that.localizer().getString('MustSelectParent')
            },
            {
                name: 'validateContentTitle',
                validate: function () {
                    return !that.isContentTitleVisible() || that.contentTitle();
                },
                errorMsg: that.localizer().getString('MustEnterContentTitle')
            }
        ];

        this.getString = function (key) {
            var localizer = that.localizer();
            if (localizer != null) {
                return localizer.getString(key);
            }
            return key;
        };

        this.refreshAllowedDestinations = function() {
            var sourceContentTypeId = this.sourceContentTypeId();
            this.destinationsList.removeAll();
            for (var i = 0; i < this.destinationData.length; i++) {
                if (this.destinationData[i].socialContentTypeId == sourceContentTypeId) {
                    for (var j = 0; j < this.destinationData.length; j++) {
                        if (this.destinationData[i].destinationContentTypeIds.indexOf(this.destinationData[j].socialContentTypeId) > -1 &&
                            this.destinationData[j].tabsList.length > 0) {
                            this.destinationsList.push(this.destinationData[j]);
                        }
                    }
                    break;
                }
            }
            this.onChangeDestination();
        };

        this.onChangeDestination = function() {
            var socialContentTypeId = this.socialContentTypeId();
            this.tabsList.removeAll();
            for (var i = 0; i < this.destinationData.length; i++) {
                if (this.destinationData[i].socialContentTypeId == socialContentTypeId) {
                    this.socialContentTypeName(this.destinationData[i].socialContentTypeName);
                    for (var j = 0; j < this.destinationData[i].tabsList.length; j++) {
                        if (!this.destinationData[i].tabsList[j].isGroupPage || this.groupsList().length > 0){
                            this.tabsList.push(this.destinationData[i].tabsList[j]);
                        }
                    }
                    break;
                }
            }
            this.tabsList.sort(function (left, right) { return left.tabName == right.tabName ? 0 : (left.tabName < right.tabName ? -1 : 1); });

            if (this.tabsList().length > 0) {
                this.tabId(this.tabsList()[0].tabId);
            }

            this.onChangePage();
        };

        this.onChangePage = function () {
            var tabId = this.tabId();
            this.modulesList.removeAll();
            for (var i = 0; i < this.tabsList().length; i++) {
                if (this.tabsList()[i].tabId == tabId) {
                    this.isGroupPage(this.tabsList()[i].isGroupPage ? true : false);
                    for (var j = 0; j < this.tabsList()[i].modulesList.length; j++) {
                        this.modulesList.push(this.tabsList()[i].modulesList[j]);
                    }
                    break;
                }
            }
        };

        this.onChangeModule = function () {
            this.isWikiModule(false);
            var moduleId = this.moduleId();
            this.contentExchangeSearch.searchText(this.initalTextSearch());
            for (var i = 0; i < this.modulesList().length; i++) {
                if (moduleId == this.modulesList()[i].moduleId) {
                    this.isWikiModule(this.modulesList()[i].isWikiModule);
                    break;
                }
            }
        };

        this.cancel = function () {
            $('.social-content-exchange').dialog('close');
        };

        this.submit = function () {
            if (!that.validate($('.social-content-exchange-form'), that.customValidators)) {
                return;
            }
            that.contentExchange();
        };

        this.contentExchange = function () {
            var self = this;

            var params = {
                contentItemId: self.contentItemId(),
                tabId: self.tabId(),
                moduleId: self.moduleId(),
                groupId: self.isGroupPage() ? self.groupId() : 0,
                articleTypeId: self.articleTypeId(),
                copyComments: self.copyComments(),
                parentContentItemId: self.getParentContentItemId(),
                childId: self.childId(),
                contentTitle: self.contentTitle(),
                commentId: self.commentId()
            };

            var service = this.social.getService('ContentExchange');
            service.post(this.methodName(), params, function(data) {
                    document.location.href = data.url;
                }, function (data) {
                    var message = JSON.parse(data.responseText).Message;
                    self.displayMessage("#errorMessage", message, "dnnFormWarning");
                }
            );
        };

        this.displayMessage = function(placeholderSelector, message, cssclass) {
            var messageNode = $("<div/>")
                    .addClass('dnnFormMessage ' + cssclass)
                    .text(message);

            $(placeholderSelector).prepend(messageNode);

            messageNode.fadeOut(3500, 'easeInExpo', function () {
                messageNode.remove();
            });
        };


        this.raise = function (params) {

            this.methodName(params.methodName);
            this.actionTitle(params.actionTitle);
            if (params.actionTitle2) {
                this.actionTitle2(params.actionTitle2);
            } else {
                this.actionTitle2('');
            }

            if (params.childId) {
                this.childId(params.childId);
            } else {
                this.childId(-1);
            }

            if (params.summary) {
                this.summary(params.summary);
            }
            else {
                this.summary('');
            }

            if (params.sourceContentType) {
                this.sourceContentType(params.sourceContentType);
            } else {
                this.sourceContentType(settings.sourceContentType);
            }

            if (params.commentId) {
                this.commentId(params.commentId);
            } else {
                this.commentId(-1);
            }

            if (params.includeSelfContentItem) {
                this.includeSelfContentItem(params.includeSelfContentItem);
            } else {
                this.includeSelfContentItem(false);
            }

            if (params.initalTextSearch) {
                this.initalTextSearch(params.initalTextSearch);
            } else {
                this.initalTextSearch('');
            }

            var service = this.social.getService('ContentExchange');
            var paramsGetDestinationData = {
                sourceModuleId: this.sourceModuleId,
                methodName: this.methodName(),
                contentItemId: this.contentItemId(),
                childId: this.childId()
            };
            service.get('GetContenExchangeDestinationData', paramsGetDestinationData, function (data) {
                    that.destinationData = data.destinationData;
                    $.each(data.groupsList,
                        function (unused, t) {
                            that.groupsList.push(dnn.social.komodel(t));
                        });
                    $.each(data.availableTypes,
                        function(unused, t) {
                            that.availableTypes.push(dnn.social.komodel(t));
                        });
                    that.hasComments(data.hasComments);
                    that.showPopUpWindow();
                }, function(data) {
                    var message = JSON.parse(data.responseText).Message;
                    $.dnnAlert({
                        title: that.localizer().getString('Error'),
                        text: message
                    });
                }
            );
        };

        this.showPopUpWindow = function () {

            var title = that.localizer().getString('ContentExchangeTitle');
            this.refreshAllowedDestinations();
            this.contentTitle('');
            this.initalTextSearch('');

            var options;
            var isMobileView = false;
            if (settings.parentControlScopeId) {
                var root = ko.contextFor($('#' + settings.parentControlScopeId)[0]);
                if (root && root.$root && root.$root.isMobileView) {
                    isMobileView = root.$root.isMobileView();
                }
            }

            if (isMobileView) {
                options = dnn.social.MobileView.dialogOptions({
                    title: title,
                    buttons: [
                        {
                            priority: 'primary',
                            'class': 'dnnPrimaryAction',
                            text: 'Cancel',
                            click: that.cancel
                        },
                        {
                            priority: 'secondary',
                            'class': 'dnnSecondaryAction',
                            text: this.actionTitle(),
                            click: that.submit
                        }
                    ]
                });
            } else {
                options = {
                    modal: true,
                    autoOpen: true,
                    dialogClass: 'dnnFormPopup',
                    title: title,
                    minWidth: 425,
                    resizable: false,
                    buttons: [
                        {
                            priority: 'primary',
                            'class': 'dnnPrimaryAction',
                            text: 'Cancel',
                            click: that.cancel
                        },
                        {
                            priority: 'secondary',
                            'class': 'dnnSecondaryAction',
                            text: this.actionTitle(),
                            click: that.submit
                        }
                    ],
                    open: $.ui.dialog.prototype.options.open,
                    close: $.ui.dialog.prototype.options.close,
                };
            }

            $('.social-content-exchange').dialog(options);
        };
    };
})(window.dnn);