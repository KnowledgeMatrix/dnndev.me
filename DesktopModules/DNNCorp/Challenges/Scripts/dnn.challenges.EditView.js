// DotNetNuke® - http://www.dnnsoftware.com
// Copyright (c) 2002-2016, DNN Corp.
// by DNN Corporation
// All Rights Reserved

if (typeof dnn === 'undefined' || !dnn) dnn = {};
if (typeof dnn.challenges === 'undefined') dnn.challenges = {};

(function (dnn) {
    'use strict';
    
    // override token input in platform to cancel cache -- SOCIAL-3489
    $(function() {
        $.TokenList.Cache = function(options) {
            this.add = function(query, results) {
            };
            this.get = function(query) {
                return null;
            };
        };
    });
    // end SOCIAL-3489

    dnn.challenges.EditView = function EditView($, ko, settings, model) {
        var that = this;

        $.extend(this, settings);
        this.social = new dnn.social.Module(settings);
        this.service = this.social.getService('Edit');
        this.postImageService = this.social.getService('Social');
        this.isMobileView = ko.computed(function () {
            var root = ko.contextFor($(settings.parentId)[0]);
            if (root && root.$root && root.$root.isMobileView) {
                return root.$root.isMobileView();
            }
            return false;
        });

        this.localizer = function () {
            return this.social.getLocalizationController();
        };

        this.getString = function (key) {
            var localizer = that.localizer();
            if (localizer != null) {
                return localizer.getString(key);
            }
            return key;
        };

        this.toggleEditPermission = function (event, target) {
            $(target.target).toggleClass("unlocked");
            that.model().isEditable(!that.model().isEditable());
        }

        this.model = ko.observable(dnn.social.komodel(model));
        this.defaultUrlTitle = this.getString('DefaultUrlTitle');
        this.defaultUrlDescription = this.getString('DefaultUrlDescription');
        this.urlTitle = ko.observable(this.defaultUrlTitle);
        this.urlDescription = ko.observable(this.defaultUrlDescription);
        this.urlImage = ko.observable(null);
        this.updatingUrl = ko.observable(false);
        this.enableChallengeType = ko.computed(function () { return that.model().contentItemId() < 1; });
        this.validUrl = false;
        this.urlErrorMessage = 'A valid url is required';

        this.loadUrlPreview = function(preview) {
            that.urlImage(preview.Images && preview.Images.length > 0 ? preview.Images[0].Url : null);
            that.urlTitle(preview.Title || that.defaultUrlTitle);
            that.urlDescription(preview.Description || that.defaultUrlDescription);
        };
        
        this.resetUrlPreview = function() {
            that.urlImage(null);
            that.urlTitle(that.defaultUrlTitle);
            that.urlDescription(that.defaultUrlDescription);
        };

        this.checkUrlValidity = function () {
            var url = that.model().url();

            if (url === '') {
                that.resetUrlPreview();
                return;
            }

            if (!url.indexOf('http://') == 0 && !url.indexOf('https://') == 0) {
                that.model().url('http://' + url);
                return;
            }

            that.service.get('CheckUrlValidity',
                { url: that.model().url(), challengeTypeId: that.model().challengeTypeId() },
                function(data) {
                    if (data.urlOk) {
                        that.validUrl = true;
                        that.model().targetItemId(data.targetItemId);
                        that.urlErrorMessage = '';
                    } else {
                        that.validUrl = false;
                        that.urlErrorMessage = data.errorMessage;
                    }
                    that.loadUrlPreview(data.preview);
                },
                function () {
                    that.validUrl = false;
                    that.urlErrorMessage = 'A valid url is required';
                    that.resetUrlPreview();
                },
                that.updatingUrl);
        };
        
        this.loading = ko.observable(false);

        this.terms = ko.observableArray([]);

        this.subscribeToActivity = ko.observable();

        this.enableSubmit = ko.observable(true);

        this.enableSubmit.subscribe(function (newValue) {
            var submitBtn = $('.dnnActions .dnnPrimaryAction', settings.moduleScope);
            if (newValue) {
                submitBtn.removeAttr('disabled');
            }
            else {
                submitBtn.attr('disabled', 'disabled');
            }
        });
        
        if (typeof $.datepicker !== 'undefined') {
            $.datepicker._defaults.firstDay = 1;
            $.datepicker._defaults.dayNames = settings.days1L;
            $.datepicker._defaults.monthNames = settings.months;
            $.datepicker._defaults.dateFormat = settings.dateFormatForJquery;
        }
        
        this.showAMPMOptions = ko.observable(settings.timeFormatShowPeriod);
        this.AMPMOptions = ko.observable(settings.timeFormatAMPMText);
        this.hourOptions = ko.computed(function () {
            if (settings.timeFormatShowPeriod) {
                return [
                    '01', '02', '03', '04', '05', '06', '07', '08', '09', '10', '11', '12'
                ];
            }

            return [
                '00', '01', '02', '03', '04', '05', '06', '07', '08', '09', '10', '11',
                '12', '13', '14', '15', '16', '17', '18', '19', '20', '21', '22', '23'
            ];
        });
        this.timeSeparator = ko.observable(settings.timeFormatSeparator);

        this.challengeTypes = [
            { value: 1, challengeType: this.getString('SocialNetworkShare') },
            { value: 2, challengeType: this.getString('VoteOnQorA') },
            { value: 3, challengeType: this.getString('VoteOnIdea') },
            { value: 4, challengeType: this.getString('ProvideAnswer') },
            { value: 5, challengeType: this.getString('Comment') },
            { value: 6, challengeType: this.getString('ContentCreation') },
            { value: 7, challengeType: this.getString('ProfileCompletion') }
        ];

        var nets = [];
        for (var i = 0; i < this.availableNetworks.length; i++) {
            nets.push({
                name: this.availableNetworks[i],
                selected: ko.observable(true),
                count: ko.observable(0)
            });
        }
        
        this.networks = ko.observableArray(nets);

        this.getMessageCount = function () {
            var nnn = that.networks();
            var count = that.model() && that.model().messageToShare() ?
                that.model().messageToShare().length : 0;
            for (var j = 0; j < nnn.length; j++) {
                var name = nnn[j].name;
                switch (name) {
                    case 'Twitter':
                        nnn[j].count(117 - count); // 140 - 23 for link space
                        break;
                    case 'LinkedIn':
                        nnn[j].count(256 - count);
                        break;
                    case 'Facebook':
                        nnn[j].count(2000 - count);
                        break;
                    default:
                        nnn[j].count(0);
                }
            }
        };

        this.toggleNetwork = function (network) {
            network.selected(!network.selected());
        };

        this.getSocialNetworks = function() {
            var socialNetworks = [];
            ko.utils.arrayForEach(that.networks(), function(n) {
                if (n.selected()) {
                    socialNetworks.push(n.name);
                }
            });
            return socialNetworks;
        };

        this.socialNetworksVisible = ko.computed(function() {
            return that.model().challengeTypeId() == that.challengeTypes[0].value;
        });
      
        this.bindControls = function (sequence, content) {
            dnn.social.EventQueue.push(
                function () {
                    if (String.isEmpty(settings.suggestedTitle) == false) {
                        that.model().contentTitle(settings.suggestedTitle);
                        dnn.social.EventQueue.push(
                            function () {
                                $('#webUrl', settings.moduleScope).focus();
                            });
                    } else {
                        $('#webUrl', settings.moduleScope).focus();
                    }
                });
            
            if (typeof that.controlsBound !== 'undefined') {
                that.model(dnn.social.komodel(model));
                that.initModel();
            } else {
                that.controlsBound = true;
            }

            $('#txtExpirationDate', settings.moduleScope).datepicker({
                dateFormat: settings.dateFormatForJquery,
                showOn: "button",
                buttonImage: settings.datepickerImageUrl,
                buttonImageOnly: true,
                showOtherMonths: true,
                selectOtherMonths: true
            });

            $('#tags', settings.moduleScope).val(that.serializeTags(that.model().tags()));
            $('#tags', settings.moduleScope).dnnTagsInput({
                onAddTag:
                    function (t) {
                        that.model().tags.push(t);
                    },
                onRemoveTag:
                    function (t) {
                        $.each(that.model().tags(),
                            function (index, term) {
                                if (term === t || (typeof term.name == 'function' && term.name() === t)) {
                                    that.model().tags.splice(index, 1);
                                    return false;
                                }

                                return true;
                            });
                    },
                width: '57%',
                minInputWidth: '200px',
                defaultText: this.getString('AddTag')
            });

            $('#invites', settings.moduleScope).tokenInput(that.service.getRoot() + 'Search', {
                theme: "facebook",
                resultsFormatter: function (item) {
                    var defaultItem = "<li>" + item[this.propertyToSearch] + "</li>";
                    if (item.id.startsWith("user-")) {
                        return "<li class='user'><span class='avatar-25'><em><img src='" + item.iconfile + "' title='" + item.name + "' /></em></span><span>" + item.name + "</span></li>";
                    } else if (item.id.startsWith("role-")) {
                        return "<li class='role'><span class='avatar-25'><em><img src='" + item.iconfile + "' title='" + item.name + "' /></em></span><span>" + item.name + "</span></li>";
                    }
                    return defaultItem;
                },
                onResult: function (results) {
                    var filtered = [];
                    if (results && results.length) {
                        for (var i = 0; i < results.length; i++) {
                            var item = results[i];
                            var id = item.id.substring(5);
                            if (item.id.startsWith("user-")) {
                                var userInvites = that.model().userInvites();
                                if ($.inArray(id, userInvites) < 0)
                                    filtered.push(item);
                            } else if (item.id.startsWith("role-")) {
                                var roleInvites = that.model().roleInvites();
                                if ($.inArray(id, roleInvites) < 0)
                                    filtered.push(item);
                            }
                        }
                    }
                    return filtered;
                },
                minChars: 2,
                preventDuplicates: true,
                hintText: '',
                noResultsText: "No Results",
                supportModules: that.service.services.setModuleHeaders,
                searchingText: "Searching...",
                onAdd: function (item) {
                    var isUser = item.id.startsWith("user-"),
                        array = isUser ? that.model().userInvites() : that.model().roleInvites(),
                        id = parseInt(item.id.substring(5), 10),
                        index = $.inArray(id, array);
                    if (index < 0) {
                        array.push(id);
                        if (isUser)
                            that.model().userInvites(array);
                        else
                            that.model().roleInvites(array);
                    }
                },
                onDelete: function (item) {
                    var isUser = item.id.startsWith("user-"),
                        array = isUser ? that.model().userInvites() : that.model().roleInvites(),
						id = parseInt(item.id.substring(5), 10),
						index = $.inArray(id, array);
                    if (index > -1) {
                        array.splice(index, 1);
                        if (isUser)
                            that.model().userInvites(array);
                        else
                            that.model().roleInvites(array);
                    }
                },
                onError: function (xhr, status) {
                }
            });
            
            if (this.model().contentItemId() > 0) {
                var users = this.model().userInvites();
                var roles = this.model().roleInvites();
                this.service.post('GetNames',
                    { users: users.join(','), roles: roles.join(',') },
                    function (d) {
                        if (d && d.length) {
                            for (var ii = 0; ii < d.length; ii++) {
                                $('#invites').tokenInput('add', d[ii]);
                            }
                        }
                    });
            }
            
            this.checkUrlValidity();
            this.getMessageCount();
            
            if (sequence !== undefined) {
                that.model().revisionSequence(sequence);
            }
            if (content !== undefined) {
                that.model().content(dnn.social.htmlDecode(content));
            }
            if (model.messageToShare !== undefined) {
                that.model().messageToShare(dnn.social.htmlDecode(model.messageToShare));
            }
        };

        this.serializeTags = function (tags) {
            var list = [];
            $.each(tags,
                function (index, tag) {
                    if (typeof tag.name === 'function' && tag.name()) {
                        list.push(tag.name());
                    } else {
                        list.push(tag);
                    }
                });

            return list;
        };

        this.completionEvent = function (m) {
            if ((settings.parentId || '').length > 0) {
                var root = ko.contextFor($(settings.parentId)[0]);
                if (root && root.$root) {
                    var collectionItem = {
                        id: m.challengeId,
                        title: m.contentTitle,
                        targetUrl: m.detailsUrl,
                        contentItemId: m.contentItemId,
                        contentTypeId: m.contentTypeId,
                        createdOnDate: m.createdOnDate,
                        lastModifiedOnDate: m.lastModifiedOnDate
                    };

                    if (that.model().contentItemId() < 1) {
                        dnn.social.ipc.post(settings, 'DNNCorp/MyStatus',
                            { event: 'CreateContentItem', model: collectionItem });
                        
                        dnn.social.ipc.post(settings, 'DNNCorp/RelatedContent',
                            { event: 'Refresh' });
                        
                    } else {
                        dnn.social.ipc.post(settings, 'DNNCorp/MyStatus',
                            { event: 'EditContentItem', model: collectionItem });
                    }

                    that.cancel();
                    that.enableSubmit(true);
                    if (typeof root.$root.refresh === 'function') {
                        root.$root.refresh();
                    }
                }
                if (typeof dnn.social.refreshUser === 'function') {
                    dnn.social.refreshUser();
                }
                return true;
            }
            return false;
        };

        this.next = function () {
            if (that.updatingUrl()) return;
            if (that.validate($('#postFields #stepOne', settings.moduleScope), [
                {
                    name: 'validateUrl',
                    errorMsg: that.urlErrorMessage,
                    validate: function() {
                        return that.validUrl;
                    }
                }
            ])) {
                $("#stepTwo", settings.moduleScope).show();
                $("#stepOne", settings.moduleScope).hide();
                $("#hlCancel", settings.moduleScope).hide();
                $("#hlNext", settings.moduleScope).hide();
                $("#hlPrevious", settings.moduleScope).show();
                $("#hlFinish", settings.moduleScope).show();

				$('#stepTwo').find('div.dnnTagsInput input[id$="_tag"]').each(function() {
	            		var $input = $('#' + $(this).attr('id').replace('_tag', ''));
						if ($input.data('dnnTagInput')) {
							$(this).dnnResetAutosize($input.data('dnnTagInput'));
						}
					});
            }
        };

        this.previous = function() {
            $("#stepTwo", settings.moduleScope).hide();
            $("#stepOne", settings.moduleScope).show();
            $("#hlCancel", settings.moduleScope).show();
            $("#hlNext", settings.moduleScope).show();
            $("#hlPrevious", settings.moduleScope).hide();
            $("#hlFinish", settings.moduleScope).hide();
        };

        this.save = function () {
            if (!that.enableSubmit())
                return false;

            that.enableSubmit(false);

            if (!that.validate($('#postFields #stepTwo', settings.moduleScope), [
                {
                    name: 'inviteesRequired',
                    validate: function() {
                        return that.model().userInvites().length > 0 || that.model().roleInvites().length > 0;
                    },
                    errorMsg: "Invite at least one user or one group"
                },
                {
                    name: 'socialnetworksRequired',
                    validate: function () {
                        return that.socialNetworksVisible() ? that.getSocialNetworks().length > 0 : true;
                    },
                    errorMsg: "At least one social network"
                },
                {
                    name: 'sharedMessageRequired',
                    validate: function () {
                        return that.socialNetworksVisible() ?
                            !String.isEmpty(that.model().messageToShare()) : true;
                },
                    errorMsg: "Text is required"
                },
                {
                    name: 'validateExpirationLaterThanCurrentTime',
                    validate: function() {
                        if (that.model().contentItemId() < 1) {
                                var d = new Date();
                                var nowUTC = d.getTime() + d.getTimezoneOffset() * 60 * 1000;
                                var nowForUser = nowUTC + that.model().timeOffset() * 60 * 60 * 1000;
                                var fd = $.datepicker.parseDate(settings.dateFormatForJquery, $('#txtExpirationDate', settings.moduleScope).val());
                                var ft = {
                                    hours: parseInt($('#selectExpirationHours', settings.moduleScope).val(), 10),
                                    minutes: parseInt($('#selectExpirationMinutes', settings.moduleScope).val(), 10),
                                    period: $('#selectExpirationAMPM', settings.moduleScope).val()
                                };

                                ft.hours = that.normalizeHours(ft.hours, ft.period);
                                fd.setHours(ft.hours);
                                fd.setMinutes(ft.minutes);
                                
                                if (fd < nowForUser) {
                                    return false;
                                }
                        }
                        return true;
                    },
                    errorMsg: 'Expiration is earlier than now'
                }
            ])) {
                that.enableSubmit(true);
                return false;
            }

            if (!that.submit()) {
                return false;
            }
            return true;
        };

        this.getJumpUrl = function (m) {
            if (typeof m.detailsUrl === 'string' && m.detailsUrl.length > 0) {
                return m.detailsUrl;
            }

            return settings.returnUrl;
        };

        this.getLastSequence = function (continueWith) {
            var failure = function (xhr, status) {
                $.dnnContentNotFoundAlert(localizer, status);
            };

            var success = function (revision) {
                if (that.model().revisionSequence() != revision.sequence) {
                    that.enableSubmit(true);
                } else {
                    continueWith();
                }
            };

            var params = {
                contentItemId: that.model().contentItemId(),
                sequence: that.model().revisionSequence()
            };

            return that.service.get('GetLastSequence', params, success, failure);
        };
        
        this.normalizeHours = function (hours, period) {
            if (settings.timeFormatShowPeriod) {
                var i1 = settings.timeFormatAMPMText.indexOf(period);
                if (i1 == 0) { //am
                    hours = hours == 12 ? 0 : hours;
                } else if (i1 == 1) { //pm
                    hours = hours == 12 ? hours : hours + 12;
                }
            }
            return hours;
        };

        this.getUtcDate = function() {
            var date = $.datepicker.parseDate(settings.dateFormatForJquery, $('#txtExpirationDate', settings.moduleScope).val());
            var utcDate = new Date(Date.UTC(
                date.getFullYear(),
                date.getMonth(),
                date.getDate(),
                that.normalizeHours(parseInt($('#selectExpirationHours', settings.moduleScope).val(), 10),
                    $('#selectExpirationAMPM', settings.moduleScope).val()),
                    parseInt($('#selectExpirationMinutes', settings.moduleScope).val(), 10)
            ));
            utcDate.setHours(utcDate.getHours() - that.model().timeOffset());
            return utcDate;
        };

        this.submit = function () {
            var failure = function (xhr, status) {
                $.dnnAlert({
                    title: that.getString('SaveFailedTitle'),
                    text: status || that.getString('SaveFailed')
                });
                that.enableSubmit(true);
            };

            var success = function (m) {
                dnn.social.EventQueue.push(
                    function () {
                        that.completionEvent(m);
                    });
            };

            var tags = [];

            $.each(that.model().tags(),
                function (index, t) {
                    if (typeof(t) === 'string') {
                        tags.push(t);
                    } else {
                        tags.push(t.name());
                    }
                });

            var params = {
                contentItemId: that.model().contentItemId(),
                challengeId: that.model().challengeId(),
                groupId: settings.groupId,
                contentTitle: that.model().contentTitle(),
                content: that.model().content(),
                inviteeRoles: that.model().roleInvites(),
                inviteeUsers: that.model().userInvites(),
                messageToShare: that.model().messageToShare(),
                expirationDate: that.getUtcDate(),
                repPoints: that.model().repPoints(),
                challengeTypeId: that.model().challengeTypeId(),
                url: that.model().url(),
                targetItemId: that.model().targetItemId(),
                lockedMessage: that.model().lockedMessage(),
                socialNetworks: that.getSocialNetworks(),
                subscribeToActivity: that.subscribeToActivity(),
                tags: tags,
                isEditable: that.model().isEditable()
            };

            if (that.model().contentItemId() < 1) {
                that.service.post('Add', params, success, failure);
            } else {
                that.getLastSequence(function() {
                    that.service.post('Update', params, success, failure);
                });
            }
        };

        this.remove = function () {
            var failure = function (xhr, status) {
                $.dnnAlert({
                    title: that.getString('DeleteErrorTitle'),
                    text: that.getString('DeleteError').format(status || that.getString('UnknownError'))
                });
            };

            var success = function () {
                that.cancel();
                window.location = settings.returnUrl;
            };

            var params = {
                Id: that.model().contentItemId()
            };

            that.service.post('Delete', params, success, failure, that.loading);
        };

        this.cancel = function () {
            $('.editor-dialog').dialog('close');
            $("#stepOne", settings.moduleScope).show();
            $("#stepTwo", settings.moduleScope).hide();
        };

        this.reset = function() {
            $("#hlCancel", settings.moduleScope).show();
            $("#hlNext", settings.moduleScope).show();
            $("#hlPrevious", settings.moduleScope).hide();
            $("#hlFinish", settings.moduleScope).hide();
            this.model().url.subscribe(this.checkUrlValidity);
            this.model().challengeTypeId.subscribe(this.checkUrlValidity);
            this.model().messageToShare.subscribe(this.getMessageCount);
        };

        this.setSuggestedTitle = function (title) {
            settings.suggestedTitle = title;
        };

        this.loading.subscribe(
            function () {
                if (that.loading()) {
                    $(settings.moduleScope).addClass('loading');
                }
                else {
                    $(settings.moduleScope).removeClass('loading');
                }
            });

        this.initModel = function () {
            if (this.model != null) {
                this.subscribeToActivity(true);
                this.reset();
                if (that.model().contentItemId() < 1) {
                    this.model().repPoints(10);
                    ko.utils.arrayForEach(that.networks(), function(n) {
                        n.selected(true);
                    });
                } else {
                    var nn = this.model().socialNetworks();
                    ko.utils.arrayForEach(that.networks(), function (n) {
                        if (nn.indexOf(n.name) > -1) n.selected(true);
                        else n.selected(false);
                    });
                }
            }
        };

        this.binded = function() {
            this.initModel();
        };
    };
    
})(window.dnn);