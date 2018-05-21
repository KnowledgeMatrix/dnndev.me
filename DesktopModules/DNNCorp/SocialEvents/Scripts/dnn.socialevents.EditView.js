// DotNetNuke® - http://www.dnnsoftware.com
//
// Copyright (c) 2002-2016, DNN Corp.
// All rights reserved.

if (typeof dnn === 'undefined' || !dnn ) dnn = {};
if (typeof dnn.socialevents === 'undefined') dnn.socialevents = {};

(function(dnn) {
    'use strict';
    
    dnn.socialevents.EditView = function EditView($, ko, settings, model) {
        var that = this;

        $.extend(this, settings);

        this.social = new dnn.social.Module(settings);

        this.service = this.social.getService('Edit');
        
        this.showModeration = ko.observable(false);

        this.subscribeToActivity = ko.observable();
        
        this.postImageService = this.social.getService('Social');
        
        this.isMobileView = ko.computed(function () {
            var root = ko.contextFor($(settings.parentId)[0]);
            if (root && root.$root && root.$root.isMobileView) {
                return root.$root.isMobileView();
            }
            return false;
        });

        var localizer = this.social.getLocalizationController();

        this.moderator = settings.moderator || false;

        this.model = ko.observable(dnn.social.komodel(model));

        this.componentFactory = this.social.getComponentFactory();

        this.componentFactory.register(that, 'EditView');

        this.loading = ko.observable(false);

        this.pageStartTime = new Date();

        this.terms = ko.observableArray([]);

        this.countries = ko.observableArray([]);

        this.regions = ko.observableArray([]);

        this.noMaxAttendees = ko.observable(true);

        this.showRegionsSelect = ko.computed(
            function () {
                return that.regions().length > 1;
            });

        this.showRegionTextbox = ko.computed(
            function () {
                return that.regions().length < 2;
            });

        this.enableSubmit = ko.observable(true);

        this.enableSubmit.subscribe(function (newValue) {
            var submitBtn = $('#next');
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
        this.enableTimePicker = ko.observable(true);
        
        this.bindControls = function (sequence, content) {
	        dnn.social.EventQueue.push(
		        function () {
		            if (String.isEmpty(settings.suggestedTitle) == false) {
			        that.model().contentTitle(settings.suggestedTitle);

			        dnn.social.EventQueue.push(
			            function () {
			                $('.socialevent-add-content').dnnRedactor('focus.setStart');
			            });
		            } else {
			            $('.socialevent-add-title').focus();
		            }
		        });
            
	        that.showModeration(false);
            $('.wizardPage').css('opacity', 1);

            if (typeof that.controlsBound !== 'undefined') {
                that.model(dnn.social.komodel(model));
                that.initModel();
            } else {
                that.controlsBound = true;
            }

            if (that.model().eventId() < 1) {
                var d = new Date();
                d.setHours(d.getHours() + 1);
                var nowUTC = d.getTime() + d.getTimezoneOffset() * 60 * 1000;
                var nowForUser = nowUTC + (that.model().timeOffset()) * 60 * 60 * 1000;
                var hours = new Date(nowForUser).getHours();
                var startAMPMIndex = 0;
                var startAMPM = settings.timeFormatAMPMText[0];
                var startHours = hours;
                if (settings.timeFormatShowPeriod) {
                    if (hours >= 12) { // pm
                        startHours = hours > 12 ? hours - 12 : hours;
                        startAMPMIndex = 1;
                    } else { // am
                        if (hours == 0) {
                            startHours = 12;
                        }
                    }
                    startAMPM = settings.timeFormatAMPMText[startAMPMIndex];
                }
                var endTimeForUser = nowForUser + 60 * 60 * 1000;
                hours = new Date(endTimeForUser).getHours();
                var endAMPMIndex = 0;
                var endAMPM = settings.timeFormatAMPMText[0];
                var endHours = hours;
                if (settings.timeFormatShowPeriod) {
                    if (hours >= 12) { // pm
                        endHours = hours > 12 ? hours - 12 : hours;
                        endAMPMIndex = 1;
                    } else { // am
                        if (hours == 0) {
                            endHours = 12;
                        }
                    }
                    endAMPM = settings.timeFormatAMPMText[endAMPMIndex];
                }

                that.model().startDateString($.datepicker.formatDate(settings.dateFormatForJquery, new Date(nowForUser)));
                that.model().endDateString($.datepicker.formatDate(settings.dateFormatForJquery, new Date(nowForUser)));
                that.model().startTimeHours(startHours < 10 ? '0' + startHours : startHours.toString());
                that.model().startTimeMinutes('00');
                that.model().startTimeAMPM(startAMPM);
                that.model().endTimeHours(endHours < 10 ? '0' + endHours : endHours.toString());
                that.model().endTimeMinutes('00');
                that.model().endTimeAMPM(endAMPM);
                that.model().approved(settings.approved);
                that.enableTimePicker(true);
            } else {
                if (that.model().isFullDayEvent()) {
                    $('#chkAllDayEvent').attr('checked', 'checked');
                    that.enableTimePicker(false);
                }
            }

            $('#txtFromDate, #txtToDate').datepicker({
                dateFormat: settings.dateFormatForJquery,
                showOn: "button",
                buttonImage: settings.datepickerImageUrl,
                buttonImageOnly: true,
                showOtherMonths: true,
                selectOtherMonths: true,
                minDate: new Date()
            });

            $('#chkAllDayEvent').unbind('change').bind('change', function() {
                var checked = $(this).is(':checked');
                if (checked) {
                    if (settings.timeFormatShowPeriod) {
                        that.model().startTimeHours('12');
                        that.model().startTimeMinutes('00');
                        that.model().startTimeAMPM(settings.timeFormatAMPMText[0]);

                        that.model().endTimeHours('11');
                        that.model().endTimeMinutes('45');
                        that.model().endTimeAMPM(settings.timeFormatAMPMText[1]);
                    } else {
                        that.model().startTimeHours('00');
                        that.model().startTimeMinutes('00');

                        that.model().endTimeHours('23');
                        that.model().endTimeMinutes('45');
                    }
                    that.enableTimePicker(false);
                    if (!that.validateStartTimeEarlierThanNow()) {
                        var tomorrow = new Date(nowForUser);
                        tomorrow.setDate(tomorrow.getDate() + 1);
                        $('#txtFromDate').val($.datepicker.formatDate(settings.dateFormatForJquery, tomorrow));
                    }
                    $('#txtFromDate').trigger('change');                    
                } else {
                    that.enableTimePicker(true);
                }
            });

            $('#selectFromTimeHours').unbind('keypress').bind('keypress', function (e) {
                var c = String.fromCharCode(e.which);
                if (c && c.match(/[0-9]/)) {
                    that.model().startTimeHours('0' + c);
                    return false;
                }
                return true;
            });
            
            $('#selectToTimeHours').unbind('keypress').bind('keypress', function (e) {
                var c = String.fromCharCode(e.which);
                if (c && c.match(/[0-9]/)) {
                    that.model().endTimeHours('0' + c);
                    return false;
                }
                return true;
            });
            
            $('#selectFromTimeMinutes').unbind('keypress').bind('keypress', function (e) {
                var c = String.fromCharCode(e.which);
                if (c && c.match(/[0-9]/)) {
                    switch(c) {
                        case '0':
                            that.model().startTimeMinutes('00');
                            break;
                        case '1':
                            that.model().startTimeMinutes('15');
                            break;
                        case '3':
                            that.model().startTimeMinutes('30');
                            break;
                        case '4':
                            that.model().startTimeMinutes('45');
                            break;
                    }
                    return false;
                }
                return true;
            });

            $('#selectToTimeMinutes').unbind('keypress').bind('keypress', function (e) {
                var c = String.fromCharCode(e.which);
                if (c && c.match(/[0-9]/)) {
                    switch (c) {
                        case '0':
                            that.model().endTimeMinutes('00');
                            break;
                        case '1':
                            that.model().endTimeMinutes('15');
                            break;
                        case '3':
                            that.model().endTimeMinutes('30');
                            break;
                        case '4':
                            that.model().endTimeMinutes('45');
                            break;
                    }
                    return false;
                }
                return true;
            });
            
            $('#selectFromTimeHours, #selectFromTimeMinutes, #selectFromTimeAMPM').unbind('change').bind('change', function () {
                that.checkValidEndTime();
            });

            $('#txtFromDate').unbind('change').bind('change', function () {
                var fd = $.datepicker.parseDate(settings.dateFormatForJquery, $('#txtFromDate').val());
                $('#txtToDate').datepicker('option', 'minDate', fd);
                that.checkValidEndTime();
            });

            var tagsDiv = $('#tags');
            tagsDiv.val(that.serializeTags(that.model().tags()));
            tagsDiv.dnnTagsInput({
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
                defaultText: localizer.getString('AddTags')
            });

            if (that.countries().length == 0) {
                that.service.get('GetCountries', null, function (m) {
                    that.countries(m);
                    that.model().country(model.country);
                });
            }

            if (that.model().maxAttendees() > 0)
                that.noMaxAttendees(false);
            else
                that.noMaxAttendees(true);

            this.friendPageIdx = 0;
            this.friendLoaded = false;
            this.friendLoading = false;
            this.friendPrevSearchName = '';
            this.friendSearchQueue = [];
            this.newInviteeList = [];

            $('.searchFriendsFilter').val('').unbind('keyup').bind('keyup', function (e) {               
                var val = $(this).val();
                that.loadFriends(val);
            });

            $('#selectInvitationOptions').unbind('change').bind('change', this.submit =
                function () {
                    if ($(this).val() == 4 || $(this).val() == 5) {
                        $('#inviteFriendsFormItem').show();
                        $('.searchFriendsFilter').val('');
                        that.friendPageIdx = 0;
                        that.friendLoaded = false;
                        that.loadFriends('');
                    }
                    else {
                        $('#inviteFriendsFormItem').hide();
                    }
                });

            var editorSettings = {
                toolbar: settings.editorToolbar,
                allowIframe: settings.editorAllowIframe,
                allowScript: settings.editorAllowScript,
                allowEmbed: settings.editorAllowEmbed
            };
            var module = $('.socialevent-add-content').addClass('validateErrorAfterParent');

            if (content !== undefined) {
                that.model().content(content);
            }

            dnn.social.initRedactor(module, null, settings.editorMode, that.isMobileView(), that.postImageService.getRoot(), editorSettings,
                function(redactor) {
                    if (that.model().content()) {
                        $('.socialevent-add-content').dnnRedactor('code.set', that.model().content());
                    }
                    dnn.social.initUserMentions(module, settings.moduleId, settings.moduleName, false, redactor);
                });

            if (sequence !== undefined) {
                that.model().revisionSequence(sequence);
            }
            
            return null;
        };

        this.friendPageIdx = 0;
        this.friendLoaded = false;
        this.friendLoading = false;
        this.friendPrevSearchName = '';
        this.newInviteeList = [];
        this.friendSearchQueue = [];
        this.loadFriends = function (searchName) {

            if (that.friendLoading) {
                that.friendSearchQueue.push(searchName);
                return;
            }
            if (searchName == that.friendPrevSearchName && that.friendLoaded) return;

            that.friendLoading = true;
            if (searchName != that.friendPrevSearchName)
                that.friendPageIdx = 0;
            
            var success = function (m) {
                
                that.friendLoaded = m.length == 0;
                if (that.friendPageIdx == 0 && that.friendLoaded) {
                    $('.inviteFriendsTable-scrollDiv table tbody').empty().append(
                        '<tr><td>No friends were found</td></tr>');
                    that.setScrollbar(1);
                    that.friendPrevSearchName = searchName;
                    that.friendLoading = false;
                    return;
                }

                if (that.friendPageIdx == 0)
                    $('.inviteFriendsTable-scrollDiv table tbody').empty();

                for (var i = 0; i < m.length; i++) {
                    var altRow = i % 2 == 0 ? '' : ' class="inviteFriendsTable-altRow" ';
                    var invited = m[i].IsInvited ? ' checked="checked" disabled="disabled"' :
                        that.newInviteeList.indexOf(m[i].UserId) > -1 ? ' checked="checked"': '';

                    $('.inviteFriendsTable-scrollDiv table tbody').append(
                        '<tr' + altRow + '><td><input type="checkbox" class="normalCheckBox"' + invited + ' data-userId="' + m[i].UserId + '" /></td>' + 
                        '<td><div class="avatar40 inviteFriend-avator"><span><em><img src="' + m[i].AvatarPath + '" /></em></span></div>' +
                        '<a href="' + m[i].GuestProfileUrl + '" class="dnnSocialLink">' + m[i].DisplayName + '</a></td></tr>');
                }

                $('.inviteFriendsTable-scrollDiv input.normalCheckBox').unbind('change').bind('change', function () {

                    var checked = $(this).is(':checked');
                    var userId = parseInt($(this).attr('data-userId'));
                    var index;
                    if (checked) {
                        index = that.newInviteeList.indexOf(userId);
                        if(index < 0)
                            that.newInviteeList.push(userId);                            
                    }
                    else {
                        index = that.newInviteeList.indexOf(userId);
                        if (index > -1)
                            that.newInviteeList.splice(index, 1);                        
                    }
                });                

                that.setScrollbar(m.length);
                that.friendPageIdx++;
                that.friendPrevSearchName = searchName;
                that.friendLoading = false;

                if (that.friendSearchQueue.length > 0) {
                    that.loadFriends(that.friendSearchQueue.shift());
                }
            };

            var failure = function () {
                that.friendLoading = false;
            };

            var params = {
                searchDisplayName: searchName,
                groupId: that.model().groupId(),
                pageIndex: that.friendPageIdx,
                eventId: that.model().eventId(),
                createdByUserId: that.model().createdByUserId()
            };

            that.service.get('searchInvitees', params, success, failure);
        };
        this.setScrollbar = function (length) {
            if ($('.inviteFriendsTable-scrollDiv').length > 0) {
                var scrollApi = $('.inviteFriendsTable-scrollDiv').data('jsp');
                if (scrollApi) {
                    scrollApi.reinitialise();
                }
                else {
                    if (length > 5 && that.friendPageIdx == 0) {
                        $('.inviteFriendsTable-scrollDiv').jScrollPane();
                        $('.inviteFriendsTable-scrollDiv').bind('jsp-scroll-y', function (e, y, isAtTop, isAtBottom) {
                            if (isAtBottom) {                          
                                that.loadFriends(that.friendPrevSearchName);
                            }
                        });
                    }
                }
            }
        };

        this.serializeTags = function (tags) {
            var list = [];

            $.each(tags,
                function (index, tag) {
                    list.push(tag.name());
                });

            return list.join(',');
        };      

        this.noMaxAttendees.subscribe(function (v) {
            if (!v) {
                if (that.model().maxAttendees() == 0)
                    that.model().maxAttendees(50);
            }
            else {
                that.model().maxAttendees(0);
            }
        });

        this.setSuggestedTitle = function (title) {
            settings.suggestedTitle = title;
        };

        this.validateStartTimeEarlierThanNow = function () {
            if (that.model().eventId() < 1) {
                var d = new Date();
                var nowUTC = d.getTime() + d.getTimezoneOffset() * 60 * 1000;
                var nowForUser = nowUTC + that.model().timeOffset() * 60 * 60 * 1000;
                var fd = $.datepicker.parseDate(settings.dateFormatForJquery, $('#txtFromDate').val());
                var ft = {
                    hours: parseInt($('#selectFromTimeHours').val(), 10),
                    minutes: parseInt($('#selectFromTimeMinutes').val(), 10),
                    period: $('#selectFromTimeAMPM').val()
                };

                ft.hours = that.normalizeHours(ft.hours, ft.period);

                fd.setHours(ft.hours);
                fd.setMinutes(ft.minutes);

                if (fd < nowForUser) {
                    return false;
                }
            }

            return true;
        };

        this.normalizeHours = function(hours, period) {
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

        this.checkValidEndTime = function() {
            if (!that.validateEndTimeLaterThanStartTime()) {
                var period = $('#selectFromTimeAMPM').val();
                var hours = parseInt($('#selectFromTimeHours').val(), 10);
                hours = that.normalizeHours(hours, period) + 1;
                var ampm = settings.timeFormatAMPMText[0];
                if (settings.timeFormatShowPeriod) {
                    if (hours >= 12) { // pm
                        hours = hours > 12 ? hours - 12 : hours;
                        ampm = settings.timeFormatAMPMText[1];
                    } else { // am
                        if (hours == 0) {
                            hours = 12;
                        }
                    }
                }
                
                hours = hours < 10 ? '0' + hours : hours.toString();
                if (hours == '12' && ampm == settings.timeFormatAMPMText[1]) {
                    var nextDay = $.datepicker.parseDate(settings.dateFormatForJquery, $('#txtFromDate').val());
                    nextDay.setDate(nextDay.getDate() + 1);
                    $('#txtToDate').val($.datepicker.formatDate(settings.dateFormatForJquery, nextDay));

                    $('#selectToTimeHours').val(hours);
                    $('#selectToTimeMinutes').val($('#selectFromTimeMinutes').val());
                    $('#selectToTimeAMPM').val(settings.timeFormatAMPMText[0]);
                } else {
                    $('#selectToTimeHours').val(hours);
                    $('#selectToTimeMinutes').val($('#selectFromTimeMinutes').val());
                    $('#selectToTimeAMPM').val(ampm);
                }
            }
        };
        
        this.validateEndTimeLaterThanStartTime = function() {
            var fd = $.datepicker.parseDate(settings.dateFormatForJquery, $('#txtFromDate').val());
            var td = $.datepicker.parseDate(settings.dateFormatForJquery, $('#txtToDate').val());

            if (fd > td) {
                return false;
            }

            if (fd.toString() == td.toString()) {
                var ft = {
                    hours: parseInt($('#selectFromTimeHours').val(), 10),
                    minutes: parseInt($('#selectFromTimeMinutes').val(), 10),
                    period: $('#selectFromTimeAMPM').val()
                };

                ft.hours = that.normalizeHours(ft.hours, ft.period);

                var tt = {
                    hours: parseInt($('#selectToTimeHours').val(), 10),
                    minutes: parseInt($('#selectToTimeMinutes').val(), 10),
                    period: $('#selectToTimeAMPM').val()
                };

                tt.hours = that.normalizeHours(tt.hours, tt.period);

                if (ft.hours > tt.hours) {
                    return false;
                }

                if (ft.hours == tt.hours) {
                    return ft.minutes < tt.minutes;
                }
            }
            return true;
        };
        
        this.getUtcDate = function (x) {

            var date = $.datepicker.parseDate(settings.dateFormatForJquery, $('#txt' + x + 'Date').val());
            
            var utcDate = new Date(Date.UTC(
                date.getFullYear(),
                date.getMonth(),
                date.getDate(),
                that.normalizeHours(parseInt($('#select' + x + 'TimeHours').val(), 10), 
                    $('#select' + x + 'TimeAMPM').val()),
                parseInt($('#select' + x + 'TimeMinutes').val(), 10)
            ));
            utcDate.setHours(utcDate.getHours() - that.model().timeOffset());
            return utcDate;            
        };
            
        this.createWizard = function () {
            var options = {
                root: $('#wizard'),
                pages: ['basic', 'location', 'guest'],
                validate: that.validator.validate,
                moduleId: settings.moduleId,
                moduleScope: settings.moduleScope,
                countries: that.countries,
                customValidator: [{
                    name : 'validateEndTimeLaterThanStartTime',
                    validate: that.validateEndTimeLaterThanStartTime,
                    errorMsg: localizer.getString('InconsistentTimes')
                },
                {
                    name: 'validateStartTimeLaterThanCurrentTime',
                    validate: that.validateStartTimeEarlierThanNow,
                    errorMsg: localizer.getString('StartTimeEarlierThanNow')
                },
                {
                    name: 'validateMaxAttendees',
                    validate: function (val) {                        
                        if (!that.noMaxAttendees()) {
                            var newMaxAttendees = that.model().maxAttendees();
                            return newMaxAttendees >= model.attending + model.mayAttend;
                        }
                        return true;
                    },
                    errorMsg: localizer.getString('MaxAttendeesLessThanAttending')
                }],

                onCancel: function() {
                    $('.editor-dialog').dialog('close');
                },
                
                onSwitch: function (page) {
                    $('#prev').html(localizer.getString(page == 0? 'Cancel' : 'Previous'));
                    switch (page) {
                        case 0:
                            dnn.social.EventQueue.push(
                                function() {
                                    $('#txtTitle', settings.moduleScope).focus();
                                });
                            break;
                        case 2:
                            setTimeout(function () {
                                $('#selectInvitationOptions').val(that.model().inviteType()).change();
                            }, 600);
                            break;
                    }
                },
                
                onFinish: function () {
                        if (!that.enableSubmit())
                            return;

                        that.enableSubmit(false);

                        var success = function (m) {
                            dnn.social.EventQueue.push(
                                function () {
                                    that.completionEvent(m);
                                });
                            that.enableSubmit(true);
                        };

                        var failure = function (xhr, status) {
                            var r = JSON.parse(xhr.responseText);
                            $.dnnAlert({
                                text: status || localizer.getString('CreateFailure'),
                                title: r.Title || localizer.getString('CreateFailureTitle')
                            });
                            that.enableSubmit(true);
                        };
                    
                        var inviteType = parseInt($('#selectInvitationOptions').val());
                        var tags = [];
                        $.each(that.model().tags(),
                           function (index, t) {
                               if (typeof (t) === 'string') {
                                   tags.push(t);
                               } else {
                                   tags.push(t.name());
                               }
                           });

                        var maxAttendees = that.noMaxAttendees() ? 0 : (that.model().maxAttendees() > 0 ? that.model().maxAttendees() : 0);
                        
                        var html = $('.socialevent-add-content').dnnRedactor('code.get');

                        var params = {
                            eventId: that.model().eventId(),
                            contentItemId: that.model().contentItemId(),
                            approved: that.model().approved(),
                            contentTitle: that.model().contentTitle(),
                            content: html,
                            tags: tags,
                            startTime: that.getUtcDate('From'),
                            endTime: that.getUtcDate('To'),
                            street: that.model().street(),
                            city: that.model().city(),
                            region: that.showRegionsSelect()? $('#ddlRegion').val() : $('#txtRegion').val(),
                            postalCode: that.model().postalCode(),
                            country: that.model().country(),
                            maxAttendees: maxAttendees,
                            invitationOnly: that.model().invitationOnly(),
                            showGuests: that.model().showGuests(),
                            inviteType: inviteType,
                            newInviteeList: that.newInviteeList,
                            groupId: settings.groupId,
                            subscribeToActivity: that.subscribeToActivity()
                        };

                        if (that.model().eventId() < 1) {
                            that.service.postsync('Create', params, success, failure);
                        } else {
                            that.getLastSequence(function() {
                                that.service.postsync('Update', params, success, failure);
                            });
                        }
                    }
            };

            $.extend(this, new dnn.social.Wizard($, ko, that.social, options, that.isMobileView()));
        };
        
        this.getLastSequence = function (continueWith) {
            var failure = function (xhr, status) {
                $.dnnContentNotFoundAlert(localizer, status);
            };

            var success = function (revision) {
                if (that.model().revisionSequence() != revision.sequence) {
                    $.dnnRevisionChangePrompt(localizer, continueWith);
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

        this.completionEvent = function (m) {
            var topic = m;
            if (topic.approved)
                that.cancel();
            else
                that.showModeration(true);
            
            if ((settings.parentId || '').length > 0) {
                var root = ko.contextFor($(settings.parentId)[0]);

                if (typeof root !== 'undefined' && root != null &&
                    typeof root.$root !== 'undefined' && root.$root != null) {
                    if (typeof root.$root.refresh === 'function') {
                        root.$root.refresh();
                    }

                    var collectionItem = {
                        id: m.eventId,
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

                        if (typeof dnn !== 'undefined' &&
                            typeof dnn.socialevents !== 'undefined' &&
                            typeof dnn.socialevents.EventCalendar !== 'undefined') {
                            dnn.socialevents.EventCalendarUpdate();
                        }                        
                    } else {
                        dnn.social.ipc.post(settings, 'DNNCorp/MyStatus',
                            { event: 'EditContentItem', model: collectionItem });
                    }
                }

                if (typeof dnn.social.refreshUser === 'function') {
                    dnn.social.refreshUser();
                }

                return true;
            }
            return false;
        };
        
        this.cancel = function () {
            $('.editor-dialog').dialog('close');
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
            if (that.model() != null) {

                that.subscribeToActivity(true);

                if (that.model().eventId() < 1) {
                    if (settings.approved) {
                        that.model().approved(true);
                    }
                }
                
                that.model().country.subscribe(
                    function () {
                        var c = that.model().country();
                        if (c) {
                            var params = { country: c };
                            var success = function (m) {
                                that.regions(m);
                                if (m.length) {
                                    if (m.indexOf(model.Region) > -1) {
                                        $('#ddlRegion').val(model.Region);
                                    }
                                } else {
                                    $('#txtRegion').val(model.Region);
                                }
                            };
                            that.service.get('GetRegions', params, success);
                        }
                    });
            }
        };
        
        this.createWizard();

        this.binded = function () {
            this.initModel();
            var holderSupported = !!("placeholder" in document.createElement("input"));
            if (holderSupported == false) {
                var placeholder = $('#searchFriendFilter').attr('placeholder');
                $('#searchFriendFilter').addClass('placeHolder').val(placeholder);
                $(function() {
                    $('#searchFriendFilter').focus(
                        function() {
                            if ($(this).val() == placeholder) {
                                $(this).val('');
                                $(this).removeClass('placeHolder');
                            }
                        })
                        .blur(
                            function() {
                                if (!$(this).val()) {
                                    $(this).val(placeholder);
                                    $(this).addClass('placeHolder');
                                }
                            });
                });
            }
        };
    };
})(window.dnn);