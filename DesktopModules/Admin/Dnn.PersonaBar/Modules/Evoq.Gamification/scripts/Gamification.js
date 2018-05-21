// DotNetNuke® - http://www.dnnsoftware.com
//
// Copyright (c) 2002-2016, DNN Corp.
// All rights reserved.

'use strict';
define(['jquery', 'knockout', 'main/validator', 'main/pager', 'main/tabpanel', 'jquery.qatooltip', 'jquery-ui.min', 'jquery.iframe-transport', 'jquery.fileupload'], function ($, ko, validator, pager, tabpanel) {
    var utility = null;
    var initializedPanels = [];
    var koBinded = false;

    // scoring
    var scoringViewModel = {
        moduleFilterId: ko.observable('-1:-1'),
        results: ko.observableArray([]),
        totalResults: ko.observable(0),
        sortColumn: ko.observable('ActionDisplayName'),
        sortAscending: ko.observable(true),
        searchText: ko.observable(''),
        modules: ko.observableArray([]),
        scoringActionEditing: {
            portalId: ko.observable(-1),
            scoringActionId: ko.observable(-1),
            scoringActionDefId: ko.observable(-1),
            experiencePoints: ko.observable(0),
            reputationPoints: ko.observable(0),
            maxCount: ko.observable(0),
            interval: ko.observable(-1),
            moduleName: ko.observable(''),
            actionDisplayName: ko.observable(''),
            actionDescription: ko.observable(''),
            limit: ko.observable('No Limit'),
            desktopModuleId: ko.observable(-1),
            packageId: ko.observable(-1),
            timeframe: ko.observable(-1),
            save: function (data, e) {
                var btn = $(e.target);
                saveScoringAction(data, btn);
            },
            cancel: function () {
                $('tr', scoringTbody).removeClass('in-edit-row');
                $('#scoring-editrow > td > div').slideUp(200, 'linear', function () {
                    $('#scoring-editrow').appendTo('#scoring-editbody');
                });
            }
        }
    };

    scoringViewModel.sort = function (vm, e) {
        var column = $(e.target).data('column');
        if (column === scoringViewModel.sortColumn()) {
            scoringViewModel.sortAscending(!scoringViewModel.sortAscending());
        }
        else {
            scoringViewModel.sortColumn(column);
            scoringViewModel.sortAscending(true);
        }
        searchScoringActions();
    };

    scoringViewModel.sortColumnClass = function (column) {
        if (column === scoringViewModel.sortColumn()) {
            return scoringViewModel.sortAscending() ? 'asc' : 'desc';
        }
        return '';
    };

    var scoringIntervalMap = {
        'l': -1,
        'd': 1,
        'w': 7,
        'm': 30,
        'y': 365
    };

    var scoringActionInEditing = null;
    var scoringTbody = null;
    var onSaveScoringAction = false;
    var saveScoringAction = function (scoringAction, btn) {
        if (!validator.validate($('#scoring-editrow'), [
			{
            name: 'nolargerthanexp',
            errorMsg: utility.resx.Gamification.err_NoLargerThanExp,
            validate: function () {
					var r = parseInt(scoringAction.reputationPoints());
					var e = parseInt(scoringAction.experiencePoints());
					return r <= e;
        }
        }
        ])) return;
        if (onSaveScoringAction) return;
        onSaveScoringAction = true;
        btn.html(utility.resx.Gamification.btn_Saving);
        utility.sf.moduleRoot = 'personabar';
        utility.sf.controller = 'scoring';
        var timeframe = scoringAction.timeframe();
        var params = {
            scoringActionId: scoringAction.scoringActionId(),
            scoringActionDefId: scoringAction.scoringActionDefId(),
            experiencePoints: scoringAction.experiencePoints(),
            reputationPoints: scoringAction.reputationPoints(),
            maxCount: scoringAction.maxCount(),
            interval: scoringIntervalMap[timeframe]
        };
        var scoringTimeframe = {
            'l': utility.resx.Gamification.opt_Lifetime,
            'd': utility.resx.Gamification.opt_Daily,
            'w': utility.resx.Gamification.opt_Weekly,
            'm': utility.resx.Gamification.opt_Monthly,
            'y': utility.resx.Gamification.opt_Yearly
        };

        utility.sf.post('SaveScoringAction', params, function () {
            scoringActionInEditing.experiencePoints(params.experiencePoints);
            scoringActionInEditing.reputationPoints(params.reputationPoints);
            scoringActionInEditing.maxCount(params.maxCount);
            scoringActionInEditing.interval(params.interval);
            $.each(scoringIntervalMap, function (index, value) {
                if (value == scoringActionInEditing.interval()) {
                    scoringActionInEditing.timeframe(index);
                    var limit = params.maxCount == 0 ? utility.resx.Gamification.opt_NoLimit : params.maxCount + ' x ' + scoringTimeframe[index];
                    scoringActionInEditing.limit(limit);
                    return false;
                }
            });
            scoringAction.cancel();
            utility.notify(utility.resx.Gamification.txt_Saved);
            onSaveScoringAction = false;
            btn.html(utility.resx.Gamification.btn_Save);
        }, function () {
            // fail...
            utility.notifyError('Failed...');
            onSaveScoringAction = false;
            btn.html(utility.resx.Gamification.btn_Save);
        });
    };

    var editScoringAction = function (scoringAction, target) {
        var row = $(target);
        if (row.is("tr") == false) {
            row = row.closest('tr');
        }

        if (row.hasClass('in-edit-row')) {
            row.removeClass('in-edit-row');
            $('#scoring-editrow > td > div').slideUp(200, 'linear', function () {
                $('#scoring-editrow').appendTo('#scoring-editbody');
            });
            return;
        }
        if (!scoringTbody) scoringTbody = row.parent();
        $('tr', scoringTbody).removeClass('in-edit-row');
        row.addClass('in-edit-row');

        $('#scoring-editrow > td > div').slideUp(200, 'linear', function () {
            $('#scoring-editrow').insertAfter(row);
            $('#scoring-editrow > td > div').slideDown(400, 'linear').find('span.dnnFormError').remove();
            scoringActionInEditing = scoringAction;
            scoringViewModel.scoringActionEditing.portalId(scoringAction.portalId());
            scoringViewModel.scoringActionEditing.scoringActionId(scoringAction.scoringActionId());
            scoringViewModel.scoringActionEditing.scoringActionDefId(scoringAction.scoringActionDefId());
            scoringViewModel.scoringActionEditing.experiencePoints(scoringAction.experiencePoints());
            scoringViewModel.scoringActionEditing.reputationPoints(scoringAction.reputationPoints());
            scoringViewModel.scoringActionEditing.maxCount(scoringAction.maxCount());
            scoringViewModel.scoringActionEditing.interval(scoringAction.interval());
            scoringViewModel.scoringActionEditing.moduleName(scoringAction.moduleName());
            scoringViewModel.scoringActionEditing.actionDisplayName(scoringAction.actionDisplayName());
            scoringViewModel.scoringActionEditing.actionDescription(scoringAction.actionDescription());
            scoringViewModel.scoringActionEditing.limit(scoringAction.limit());
            scoringViewModel.scoringActionEditing.desktopModuleId(scoringAction.desktopModuleId());
            scoringViewModel.scoringActionEditing.packageId(scoringAction.packageId());
            scoringViewModel.scoringActionEditing.timeframe(scoringAction.timeframe());
        });
    };

    var getScoringSearchParams = function () {
        var filter = scoringViewModel.moduleFilterId().split(':');
        return {
            desktopModuleId: filter[0] || -1,
            packageId: filter[1] || -1,
            pageIndex: scoringViewModel.pageIndex(),
            pageSize: scoringViewModel.pageSize,
            sortColumn: scoringViewModel.sortColumn(),
            sortAscending: scoringViewModel.sortAscending(),
            searchText: scoringViewModel.searchText()
        };
    };

    var searchScoringActions = function (cb) {
        $('#scoring-editrow > td > div').hide();
        $('#scoring-editrow').appendTo('#scoring-editbody');
        utility.sf.moduleRoot = 'personabar';
        utility.sf.controller = 'scoring';
        var searchParams = getScoringSearchParams();
        utility.sf.get('getscoringactivities', searchParams, function (d) {
            var results = [];
            if (d) {
                $.each(d.Results || [], function (i, v) {
                    var scoring = {
                        portalId: ko.observable(v.PortalId),
                        scoringActionId: ko.observable(v.ScoringActionId),
                        scoringActionDefId: ko.observable(v.ScoringActionDefId),
                        experiencePoints: ko.observable(v.ExperiencePoints),
                        reputationPoints: ko.observable(v.ReputationPoints),
                        maxCount: ko.observable(v.MaxCount),
                        interval: ko.observable(v.Interval),
                        moduleName: ko.observable(v.ModuleName),
                        actionDisplayName: ko.observable(v.ActionDisplayName),
                        actionDescription: ko.observable(v.ActionDescription),
                        limit: ko.observable(v.Limit || utility.resx.Gamification.opt_NoLimit),
                        desktopModuleId: ko.observable(v.DesktopModuleId),
                        packageId: ko.observable(v.PackageId),
                        timeframe: ko.observable()
                    };

                    $.each(scoringIntervalMap, function (index, value) {
                        if (value == scoring.interval()) {
                            scoring.timeframe(index);
                            return false;
                        }
                    });

                    scoring.edit = function (data, e) {
                        e.preventDefault();
                        editScoringAction(data, e.target);
                    };

                    results.push(scoring);
                });
            }

            scoringViewModel.results(results);
            scoringViewModel.totalResults(d.TotalResults || 0);

            if (koBinded) $('#scoringpanel .qaTooltip').qaTooltip();
            if (typeof cb === 'function') cb();

        }, function () {
            // fail....
            utility.notifyError('Failed...');
            scoringViewModel.results([]);
            scoringViewModel.totalResults(0);

            if (koBinded) $('#scoringpanel .qaTooltip').qaTooltip();
            if (typeof cb === 'function') cb();
        });
    };

    var searchScoringActionsStart = function (cb) {
        scoringViewModel.pageIndex(0);
        searchScoringActions(cb);
    };

    var getScoringDesktopModules = function (cb) {
        utility.sf.moduleRoot = 'personabar';
        utility.sf.controller = 'scoring';
        utility.sf.get('getdesktopmodules', null, function (d) {
            var modules = [];
            if (d) {
                $.each(d.Modules || [], function (i, v) {
                    var moduleName = v.DesktopModuleId < 0 ? utility.resx.Gamification.opt_FilterByModule : v.Name;
                    modules.push({
                        moduleName: ko.observable(moduleName),
                        desktopModuleId: ko.observable(v.DesktopModuleId + ':' + v.PackageId)
                    });
                });
            }

            scoringViewModel.modules(modules);
            if (typeof cb === 'function') cb();
        }, function () {
            // failed
            utility.notifyError('Failed...');
            scoringViewModel.modules([]);
            if (typeof cb === 'function') cb();
        });
    };

    var initScoringPanel = function (cb) {
        utility.asyncParallel([
			function (cb1) {
			    getScoringDesktopModules(cb1);
			},

			function (cb2) {
			    searchScoringActions(cb2);
			}
        ],

		function () {
		    var scoringSearchTextThrottle = null;
		    scoringViewModel.searchText.subscribe(function () {
		        if (scoringSearchTextThrottle)
		            clearTimeout(scoringSearchTextThrottle);
		        scoringSearchTextThrottle = setTimeout(searchScoringActionsStart, 500);
		    });

		    scoringViewModel.moduleFilterId.subscribe(searchScoringActionsStart);
		    if (typeof cb === 'function') cb();
		});
    };
    // end scoring

    // priviledges
    var privilegesViewModel = {
        moduleFilterId: ko.observable(-1),
        results: ko.observableArray([]),
        totalResults: ko.observable(0),
        sortColumn: ko.observable('PrivilegeName'),
        sortAscending: ko.observable(true),
        searchText: ko.observable(''),
        modules: ko.observableArray([]),
        privilegeEditing: {
            portalId: ko.observable(-1),
            privilegeId: ko.observable(-1),
            privilegeDefId: ko.observable(-1),
            privilegeName: ko.observable(''),
            privilegeDisplayName: ko.observable(''),
            description: ko.observable(''),
            reputationPoints: ko.observable(-1),
            moduleName: ko.observable(''),
            desktopModuleId: ko.observable(-1),
            save: function (data, e) {
                var btn = $(e.target);
                savePrivilege(data, btn);
            },
            cancel: function () {
                $('tr', privilegesTbody).removeClass('in-edit-row');
                $('#privilege-editrow > td > div').slideUp(200, 'linear', function () {
                    $('#privilege-editrow').appendTo('#privileges-editbody');
                });
            }
        }
    };

    privilegesViewModel.sort = function (vm, e) {
        var column = $(e.target).data('column');
        if (column === privilegesViewModel.sortColumn()) {
            privilegesViewModel.sortAscending(!privilegesViewModel.sortAscending());
        }
        else {
            privilegesViewModel.sortColumn(column);
            privilegesViewModel.sortAscending(true);
        }
        searchPrivileges();
    };

    privilegesViewModel.sortColumnClass = function (column) {
        if (column === privilegesViewModel.sortColumn()) {
            return privilegesViewModel.sortAscending() ? 'asc' : 'desc';
        }
        return '';
    };

    var privilegeInEditing = null;
    var privilegesTbody = null;
    var onSavePrivilege = false;
    var savePrivilege = function (privilege, btn) {
        if (!validator.validate($('#privilege-editrow'))) return;
        if (onSavePrivilege) return;
        onSavePrivilege = true;
        btn.html(utility.resx.Gamification.btn_Saving);
        utility.sf.moduleRoot = 'personabar';
        utility.sf.controller = 'privilege';
        var params = {
            privilegeId: privilege.privilegeId(),
            privilegeDefId: privilege.privilegeDefId(),
            reputationPoints: privilege.reputationPoints()
        };
        utility.sf.post('SavePrivilege', params, function (d) {
            privilegeInEditing.reputationPoints(params.reputationPoints);
            privilegeInEditing.privilegeId(d.PrivilegeId || 0);
            privilege.cancel();
            utility.notify(utility.resx.Gamification.txt_Saved);
            onSavePrivilege = false;
            btn.html(utility.resx.Gamification.btn_Save);
        }, function () {
            // fail...
            utility.notifyError('Failed...');
            onSavePrivilege = false;
            btn.html(utility.resx.Gamification.btn_Save);
        });
    };

    var editPrivilege = function (privilege, target) {
        var row = $(target);
        if (row.is("tr") == false) {
            row = row.closest('tr');
        }

        if (row.hasClass('in-edit-row')) {
            row.removeClass('in-edit-row');
            $('#privilege-editrow > td > div').slideUp(200, 'linear', function () {
                $('#privilege-editrow').appendTo('#privileges-editbody');
            });
            return;
        }
        if (!privilegesTbody) privilegesTbody = row.parent();
        $('tr', privilegesTbody).removeClass('in-edit-row');
        row.addClass('in-edit-row');
        $('#privilege-editrow > td > div').slideUp(200, 'linear', function () {
            $('#privilege-editrow').insertAfter(row)
            $(this).slideDown(400, 'linear').find('span.dnnFormError').remove();
            privilegeInEditing = privilege;
            privilegesViewModel.privilegeEditing.portalId(privilege.portalId());
            privilegesViewModel.privilegeEditing.privilegeId(privilege.privilegeId());
            privilegesViewModel.privilegeEditing.privilegeDefId(privilege.privilegeDefId());
            privilegesViewModel.privilegeEditing.privilegeName(privilege.privilegeName());
            privilegesViewModel.privilegeEditing.privilegeDisplayName(privilege.privilegeDisplayName());
            privilegesViewModel.privilegeEditing.description(privilege.description());
            privilegesViewModel.privilegeEditing.reputationPoints(privilege.reputationPoints());
            privilegesViewModel.privilegeEditing.moduleName(privilege.moduleName());
            privilegesViewModel.privilegeEditing.desktopModuleId(privilege.desktopModuleId());
        });
    };

    var getPrivilegesSearchParams = function () {
        return {
            desktopModuleId: privilegesViewModel.moduleFilterId() || -1,
            pageIndex: privilegesViewModel.pageIndex(),
            pageSize: privilegesViewModel.pageSize,
            sortColumn: privilegesViewModel.sortColumn(),
            sortAscending: privilegesViewModel.sortAscending(),
            searchText: privilegesViewModel.searchText()
        };
    };

    var searchPrivileges = function (cb) {
        $('#privilege-editrow > td > div').hide()
        $('#privilege-editrow').appendTo('#privileges-editbody');
        utility.sf.moduleRoot = 'personabar';
        utility.sf.controller = 'privilege';
        var searchParams = getPrivilegesSearchParams();
        utility.sf.get('getprivileges', searchParams, function (d) {
            var results = [];
            if (d) {
                $.each(d.Results || [], function (i, v) {
                    var privilege = {
                        portalId: ko.observable(v.PortalId),
                        privilegeId: ko.observable(v.PrivilegeId),
                        privilegeDefId: ko.observable(v.PrivilegeDefId),
                        privilegeName: ko.observable(v.PrivilegeName),
                        privilegeDisplayName: ko.observable(v.PrivilegeDisplayName),
                        description: ko.observable(v.PrivilegeDescription),
                        reputationPoints: ko.observable(v.ReputationPoints),
                        moduleName: ko.observable(v.ModuleName),
                        desktopModuleId: ko.observable(v.DesktopModuleId)
                    };

                    privilege.edit = function (data, e) {
                        editPrivilege(data, e.target);
                        e.preventDefault();
                    };

                    results.push(privilege);
                });
            }

            privilegesViewModel.results(results);
            privilegesViewModel.totalResults(d.TotalResults || 0);

            if (koBinded) $('#privilegespanel .qaTooltip').qaTooltip();
            if (typeof cb === 'function') cb();
        }, function () {
            // fail....
            utility.notifyError('Failed...');
            privilegesViewModel.results([]);
            privilegesViewModel.totalResults(0);
            if (koBinded) $('#privilegespanel .qaTooltip').qaTooltip();
            if (typeof cb === 'function') cb();
        });
    };

    var searchPrivilegesStart = function (cb) {
        privilegesViewModel.pageIndex(0);
        searchPrivileges(cb);
    };

    var getPrivilegesDesktopModules = function (cb) {
        utility.sf.moduleRoot = 'personabar';
        utility.sf.controller = 'privilege';
        utility.sf.get('getdesktopmodules', null, function (d) {
            var modules = [];
            if (d) {
                $.each(d.Modules || [], function (i, v) {
                    var moduleName = v.DesktopModuleId < 0 ? utility.resx.Gamification.opt_FilterByModule : v.Name;
                    modules.push({
                        moduleName: ko.observable(moduleName),
                        desktopModuleId: ko.observable(v.DesktopModuleId)
                    });
                });
            }
            privilegesViewModel.modules(modules);
            if (typeof cb === 'function') cb();
        }, function () {
            // failed
            utility.notifyError('Failed...');
            privilegesViewModel.modules([]);
            if (typeof cb === 'function') cb();
        });
    };

    var initPrivilegesPanel = function (cb) {
        utility.asyncParallel([
			function (cb1) {
			    getPrivilegesDesktopModules(cb1);
			},
			function (cb2) {
			    searchPrivileges(cb2);
			}
        ],

		function () {
		    var privilegesSearchTextThrottle = null;
		    privilegesViewModel.searchText.subscribe(function () {
		        if (privilegesSearchTextThrottle)
		            clearTimeout(privilegesSearchTextThrottle);
		        privilegesSearchTextThrottle = setTimeout(searchPrivilegesStart, 500);
		    });
		    privilegesViewModel.moduleFilterId.subscribe(searchPrivilegesStart);
		    if (typeof cb === 'function') cb();
		});
    };
    // end priviledges

    // badges
    var badgesViewModel = {
        results: ko.observableArray([]),
        totalResults: ko.observable(0),
        sortColumn: ko.observable('BadgeName'),
        sortAscending: ko.observable(true),
        searchText: ko.observable('')
    };

    badgesViewModel.badgeEditing = {
        badgeId: ko.observable(-1),
        badgeName: ko.observable(''),
        tier: ko.observable(1),
        description: ko.observable(''),
        imageUrl: ko.observable(''),
        imageFileId: ko.observable(-1),
        images: ko.observable([]),
        moduleFilterId: ko.observable('-1:-1'),
        modules: ko.observableArray([]),
        timeframe: ko.observable(30),
        toAdd: [],
        actions: {
            totalResults: ko.observable(0),
            results: ko.observableArray([])
        },
        selectedActions: {
            totalResults: ko.observable(0),
            results: ko.observableArray([]),
            totalSelected: ko.observableArray([])
        },
        init: function () {
            $('.wizard > ul > li').removeClass('active');
            $('.wizard > ul > li:first').addClass('active');
            $('.wizard > div.wizard-tab').hide();
            $('.wizard > div.wizard-navbar a.secondarybtn').html(utility.resx.Gamification.btn_Cancel);
            $('.wizard > div.wizard-navbar a.primarybtn').html(utility.resx.Gamification.btn_Next);
            $('#badge-creation').show();
        },
        prev: function (vm, e) {
            var active = $('.wizard > ul > li.active');
            var prevLi = active.prev();
            var prevBtn = $('.wizard > div.wizard-navbar a.secondarybtn');
            var nextBtn = $('.wizard > div.wizard-navbar a.primarybtn');
            if (prevLi.length) {
                var tab = prevLi.data('tab-id');
                $('.wizard > div.wizard-tab').hide();
                $('#' + tab).fadeIn(400, 'linear');
                active.removeClass('active');
                prevLi.addClass('active');
                prevBtn.html(prevLi.prev().length ? utility.resx.Gamification.btn_Prev : utility.resx.Gamification.btn_Cancel);
                nextBtn.html(utility.resx.Gamification.btn_Next);
            }
            else {
                $('tr', badgesTbody).removeClass('in-edit-row');
                $('#badge-editrow > td > div').slideUp(200, 'linear', function () {
                    $('#badge-editrow').appendTo('#badges-editbody');
                });
            }
        },
        next: function (vm, e) {
            var active = $('.wizard > ul > li.active');
            var nextLi = active.next();
            var prevBtn = $('.wizard > div.wizard-navbar a.secondarybtn');
            var nextBtn = $('.wizard > div.wizard-navbar a.primarybtn');
            var currentTab = active.data('tab-id');
            var valid = false;
            switch (currentTab) {
                case 'badge-creation':
                case 'badge-goal':
                    valid = validator.validate('#' + currentTab);
                    break;
                case 'badge-association':
                    var selectedActionsHeader = $('#selectedActionsHeader');
                    selectedActionsHeader.find('span.dnnFormError').remove();
                    valid = badgesViewModel.badgeEditing.selectedActions.totalResults() > 0;
                    if (!valid) {
                        selectedActionsHeader.append('<span class="dnnFormError">' + utility.resx.Gamification.err_OneActionNeeded + '</span>');
                    }
                    else {
                        valid = true;
                        var selected = badgesViewModel.badgeEditing.selectedActions.totalSelected();
                        var errorMessage = '';
                        $.each(selected, function (i, v) {
                            var s = v.count().toString();
                            if (!s) {
                                errorMessage = utility.resx.Gamification.err_Required;
                            }
                            else {

                                if (!/^\d+$/.test(s)) {
                                    if (/^-?\d+\.?\d+$/.test(s))
                                        errorMessage = utility.resx.Gamification.err_NonDecimalNumber;
                                    else if (/^-?\d+$/.test(s))
                                        errorMessage = utility.resx.Gamification.err_NonNegativeNumber;
                                    else
                                        errorMessage = utility.resx.Gamification.err_Number;

                                }
                                else {
                                    var ss = parseInt(s);
                                    if (ss < 1)
                                        errorMessage = utility.resx.Gamification.err_PositiveNumber;
                                }
                            }

                            if (errorMessage) {
                                valid = false;
                                return false;
                            }
                        });
                        if (!valid) {
                            selectedActionsHeader.append('<span class="dnnFormError">' + errorMessage + '</span>');
                        }
                    }

                    break;
            }

            if (!valid) return;

            if (nextLi.length) {
                var tab = nextLi.data('tab-id');
                $('.wizard > div.wizard-tab').hide();
                $('#' + tab).fadeIn(400, 'linear');
                active.removeClass('active');
                nextLi.addClass('active');
                nextBtn.html(nextLi.next().length ? utility.resx.Gamification.btn_Next : utility.resx.Gamification.btn_Save);
                prevBtn.html(utility.resx.Gamification.btn_Prev);
            }
            else {
                var btn = $(e.target);
                saveBadge(badgesViewModel.badgeEditing, btn);
            }
        }
    };

    badgesViewModel.badgeEditing.showTitle = ko.computed(function () { return badgesViewModel.badgeEditing.badgeId() > 0; });
    badgesViewModel.badgeEditing.selectedActions.getPagedResults = function () {
        var idx = badgesViewModel.badgeEditing.selectedActions.pageIndex();
        var size = badgesViewModel.badgeEditing.selectedActions.pageSize;
        var arr = badgesViewModel.badgeEditing.selectedActions.totalSelected();
        var r = [], m = Math.min(idx * size + size, arr.length);
        for (var i = idx * size; i < m; i++) {
            r.push(arr[i]);
        }
        $.each(r, function (i, v) {
            v.css(i % 2 == 0 ? 'actionContainer' : 'actionContainer altActionItem');
        });
        badgesViewModel.badgeEditing.selectedActions.results(r);
    };

    badgesViewModel.badgeEditing.add = function () {
        var arr = badgesViewModel.badgeEditing.selectedActions.totalSelected();
        $.each(badgesViewModel.badgeEditing.toAdd, function (i, v) {
            arr.push(v);
        });
        if (arr.length) $('.wizard > ul > li.active').find('span.dnnFormError').remove();
        badgesViewModel.badgeEditing.selectedActions.totalSelected(arr);
        badgesViewModel.badgeEditing.selectedActions.totalResults(arr.length);
        badgesViewModel.badgeEditing.selectedActions.getPagedResults();
        badgesViewModel.badgeEditing.toAdd = [];
        $.each(badgesViewModel.badgeEditing.actions.results(), function (i, v) {
            v.enable(isActionExists(v) < 0);
        });
    };

    var badgeScoringCheckedTrigger = true;
    badgesViewModel.badgeEditing.remove = function () {
        var arr = [], selected = badgesViewModel.badgeEditing.selectedActions.totalSelected();
        $.each(selected, function (i, v) {
            if (v.checked()) arr.push(v);
        });
        $.each(arr, function (i, v) {
            var index = -1;
            $.each(selected, function (ii, vv) {
                if (vv.scoringActionDefId() == v.scoringActionDefId()) {
                    index = ii;
                    return false;
                }
            });
            if (index > -1) selected.splice(index, 1);
        });

        badgesViewModel.badgeEditing.selectedActions.totalSelected(selected);
        badgesViewModel.badgeEditing.selectedActions.totalResults(selected.length);
        badgesViewModel.badgeEditing.selectedActions.pageIndex(0);
        badgesViewModel.badgeEditing.selectedActions.getPagedResults();
        badgeScoringCheckedTrigger = false;
        $.each(badgesViewModel.badgeEditing.actions.results(), function (i, v) {
            v.enable(isActionExists(v) < 0);
            v.checked(!v.enable() || isActionChecked(v) > -1);
        });
        badgeScoringCheckedTrigger = true;
    };

    badgesViewModel.sort = function (vm, e) {
        var column = $(e.target).data('column');
        if (column === badgesViewModel.sortColumn()) {
            badgesViewModel.sortAscending(!badgesViewModel.sortAscending());
        }
        else {
            badgesViewModel.sortColumn(column);
            badgesViewModel.sortAscending(true);
        }
        searchBadges();
    };

    badgesViewModel.sortColumnClass = function (column) {
        if (column === badgesViewModel.sortColumn()) {
            return badgesViewModel.sortAscending() ? 'asc' : 'desc';
        }
        return '';
    };

    badgesViewModel.create = function () {
        if ($('#createbadgestbl > tbody > tr').length) return;
        $('#badgestbl tr').removeClass('in-edit-row');
        $('#badge-editrow > td > div').slideUp(200, 'linear', function () {
            $('#badge-editrow').appendTo('#createbadgestbl > tbody')
            $(this).slideDown(400, 'linear').find('span.dnnFormError').remove();
            badgesViewModel.badgeEditing.badgeId(-1);
            badgesViewModel.badgeEditing.badgeName('');
            badgesViewModel.badgeEditing.description('');
            badgesViewModel.badgeEditing.tier(1);
            badgesViewModel.badgeEditing.timeframe(30);
            badgesViewModel.badgeEditing.toAdd = [];
            badgesViewModel.badgeEditing.selectedActions.totalSelected([]);
            badgesViewModel.badgeEditing.selectedActions.totalResults(0);
            badgesViewModel.badgeEditing.selectedActions.pageIndex(0);
            badgesViewModel.badgeEditing.selectedActions.getPagedResults();

            badgesViewModel.badgeEditing.moduleFilterId() === -1 ?
				subscribeBadgeEditingModuleFilterId() :
				badgesViewModel.badgeEditing.moduleFilterId(-1);

            badgesViewModel.badgeEditing.init();
            badgeInEdit = badgesViewModel.badgeEditing;
        });
    };

    var badgeInEdit = null;
    var badgesTbody = null;

    var isActionExists = function (scoring) {
        var selected = badgesViewModel.badgeEditing.selectedActions.totalSelected();
        var index = -1;
        $.each(selected, function (i, v) {
            if (v.scoringActionDefId() == scoring.scoringActionDefId()) {
                index = i;
                return false;
            }
        });
        return index;
    };

    var isActionChecked = function (scoring) {
        var toAdd = badgesViewModel.badgeEditing.toAdd;
        var index = -1;
        $.each(toAdd, function (i, v) {
            if (v.scoringActionDefId() == scoring.scoringActionDefId()) {
                index = i;
                return false;
            }
        });
        return index;
    };

    var toggleActionChecked = function (scoring) {
        var index = isActionChecked(scoring);
        if (index < 0)
            badgesViewModel.badgeEditing.toAdd.push({
                scoringActionDefId: ko.observable(scoring.scoringActionDefId()),
                moduleName: ko.observable(scoring.moduleName()),
                actionDisplayName: ko.observable(scoring.actionDisplayName()),
                desktopModuleId: ko.observable(scoring.desktopModuleId()),
                packageId: ko.observable(scoring.packageId()),
                count: ko.observable(1),
                css: ko.observable(''),
                checked: ko.observable(false)
            });
        else {
            badgesViewModel.badgeEditing.toAdd.splice(index, 1);
        }
    };

    var onSaveBadge = false;
    var saveBadge = function (badge, btn, cb) {
        if (onSaveBadge) return;
        onSaveBadge = true;
        btn.html(utility.resx.Gamification.btn_Saving);
        utility.sf.moduleRoot = 'personabar';
        utility.sf.controller = 'badge';
        var url = badge.badgeId() > 0 ? 'editbadge' : 'createbadge';
        var actions = badge.selectedActions.totalSelected();
        var actionStr = '';
        $.each(actions, function (i, v) {
            if (actionStr) actionStr += ',';
            actionStr += v.scoringActionDefId() + ' ' + v.count();
        });

        var params = badge.badgeId() > 0 ?
			{
			    badgeId: badge.badgeId(),
			    name: badge.badgeName(),
			    description: badge.description(),
			    imageFileId: badge.imageFileId(),
			    timeframe: badge.timeframe(),
			    tier: badge.tier(),
			    actions: actionStr
			} :
			{
			    name: badge.badgeName(),
			    description: badge.description(),
			    imageFileId: badge.imageFileId(),
			    timeframe: badge.timeframe(),
			    tier: badge.tier(),
			    actions: actionStr
			};

        utility.sf.post(url, params, function (d) {
            searchBadges();
            utility.notify(utility.resx.Gamification.txt_Saved);
            onSaveBadge = false;
            btn.html(utility.resx.Gamification.btn_Save);
            if (typeof cb === 'function') cb();
        }, function () {
            // failed. ...
            utility.notifyError('Failed...');
            onSaveBadge = false;
            btn.html(utility.resx.Gamification.btn_Save);
        });
    };

    var getBadgesDesktopModules = function (cb) {
        utility.sf.moduleRoot = 'personabar';
        utility.sf.controller = 'badge';
        utility.sf.get('getdesktopmodules', null, function (d) {
            var modules = [];
            if (d) {
                $.each(d.Modules || [], function (i, v) {
                    var moduleName = v.DesktopModuleId < 0 ? utility.resx.Gamification.opt_FilterByModule : v.Name;
                    modules.push({
                        moduleName: ko.observable(moduleName),
                        desktopModuleId: ko.observable(v.DesktopModuleId + ':' + v.PackageId)
                    });
                });
            }
            badgesViewModel.badgeEditing.modules(modules);
            if (typeof cb === 'function') cb();
        }, function () {
            // failed
            utility.notifyError('Failed...');
            badgesViewModel.badgeEditing.modules([]);
            if (typeof cb === 'function') cb();
        });
    };

    var getAvailableScoringActions = function (cb) {
        utility.sf.moduleRoot = 'personabar';
        utility.sf.controller = 'badge';
        var filter = badgesViewModel.badgeEditing.moduleFilterId().split(':');
        utility.sf.get('getscoringactivities', {
            searchText: '',
            pageIndex: badgesViewModel.badgeEditing.actions.pageIndex(),
            pageSize: badgesViewModel.badgeEditing.actions.pageSize,
            sortColumn: 'ActionDisplayName',
            sortAscending: true,
            desktopModuleId: filter[0] || -1,
            packageId: filter[1] || -1,
        }, function (d) {
            var results = [];
            if (d) {
                $.each(d.Results || [], function (i, v) {
                    var scoring = {
                        scoringActionDefId: ko.observable(v.ScoringActionDefId),
                        moduleName: ko.observable(v.ModuleName),
                        actionDisplayName: ko.observable(v.ActionDisplayName),
                        desktopModuleId: ko.observable(v.DesktopModuleId),
                        packageId: ko.observable(v.DesktopModuleId),
                        css: ko.observable(i % 2 == 0 ? 'actionContainer' : 'actionContainer altActionItem'),
                        checked: ko.observable(false),
                        enable: ko.observable(true)
                    };
                    scoring.enable(isActionExists(scoring) < 0);
                    scoring.checked(!scoring.enable() || isActionChecked(scoring) > -1);
                    scoring.checked.subscribe(function () {
                        if (badgeScoringCheckedTrigger)
                            toggleActionChecked(scoring);
                    });
                    results.push(scoring);
                });
            }
            badgesViewModel.badgeEditing.actions.totalResults(d.TotalResults || 0);
            badgesViewModel.badgeEditing.actions.results(results);
            if (typeof cb === 'function') cb();
        }, function () {
            // failed.
            utility.notifyError('Failed...');
            badgesViewModel.badgeEditing.actions.totalResults(0);
            badgesViewModel.badgeEditing.actions.results([]);
            if (typeof cb === 'function') cb();
        });
    };

    var getBadgesDetails = function (badge, cb) {
        utility.sf.moduleRoot = 'personabar';
        utility.sf.controller = 'badge';
        utility.sf.get('getbadgedetails', { badgeId: badge.badgeId() }, function (d) {
            var selectedActions = [];
            if (d) {
                $.each(d.Actions || [], function (i, v) {
                    $.each(v, function (ii, vv) {
                        var act = {
                            scoringActionDefId: ko.observable(vv.ScoringActionDefId),
                            moduleName: ko.observable(vv.ModuleName),
                            actionDisplayName: ko.observable(vv.ActionDisplayName),
                            desktopModuleId: ko.observable(vv.DesktopModuleId),
                            count: ko.observable(vv.Count || 1),
                            checked: ko.observable(false),
                            css: ko.observable('')
                        };
                        selectedActions.push(act);
                    });
                });
            }
            badge.selectedActions(selectedActions);
            if (typeof cb === 'function') cb();
        }, function () {
            // failed.
            utility.notifyError('Failed...');
            badge.selectedActions([]);
            if (typeof cb === 'function') cb();
        });
    };

    var editBadge = function (badge, target) {
        var row = $(target);
        if (row.is("tr") == false) {
            row = row.closest('tr');
        }

        if (row.hasClass('in-edit-row')) {
            row.removeClass('in-edit-row');
            $('#badge-editrow > td > div').slideUp(200, 'linear', function () {
                $('#badge-editrow').appendTo('#badges-editbody');
            });
            return;
        }
        if (!badgesTbody) badgesTbody = row.parent();
        $('tr', badgesTbody).removeClass('in-edit-row');
        row.addClass('in-edit-row');
        $('#badge-editrow > td > div').slideUp(200, 'linear', function () {
            $('#badge-editrow').insertAfter(row)
            $(this).slideDown(400, 'linear').find('span.dnnFormError').remove();
            badgeInEdit = badge;
            badgesViewModel.badgeEditing.badgeId(badge.badgeId());
            badgesViewModel.badgeEditing.badgeName(badge.badgeName());
            badgesViewModel.badgeEditing.tier(badge.tier());
            badgesViewModel.badgeEditing.description(badge.description());
            badgesViewModel.badgeEditing.imageFileId(badge.imageFileId());
            badgesViewModel.badgeEditing.timeframe(badge.timeframe());
            badgesViewModel.badgeEditing.toAdd = [];
            badgesViewModel.badgeEditing.init();
            var cbcb = function () {
                var selectedActions = badge.selectedActions();
                // need to copy array
                var arr = [];
                $.each(selectedActions, function (i, v) {
                    v.checked(false);
                    arr.push(v);
                });

                badgesViewModel.badgeEditing.selectedActions.totalSelected(arr);
                badgesViewModel.badgeEditing.selectedActions.totalResults(arr.length);
                badgesViewModel.badgeEditing.selectedActions.getPagedResults();

                badgeScoringCheckedTrigger = false;
                $.each(badgesViewModel.badgeEditing.actions.results(), function (i, v) {
                    v.enable(isActionExists(v) < 0);
                    v.checked(!v.enable() || isActionChecked(v) > -1);
                });
                badgeScoringCheckedTrigger = true;

                var desktopModuleId = arr.length ? arr[0].desktopModuleId() : -1;
                badgesViewModel.badgeEditing.moduleFilterId(desktopModuleId);
            };

            if (!badge.selectedActions().length) {
                getBadgesDetails(badge, cbcb);
            }
            else {
                cbcb();
            }
        });
    };

    var onDeleteBadge = false;
    var deleteBadge = function (badge, target) {
        var badgeId = badge.badgeId();
        if (badgeId < 1) return;
        if (onDeleteBadge) return;
        onDeleteBadge = true;
        utility.confirm(utility.resx.Gamification.txt_ConfirmDelete, utility.resx.Gamification.btn_Delete, utility.resx.Gamification.btn_Cancel, function () {
            utility.sf.moduleRoot = 'personabar';
            utility.sf.controller = 'badge';
            utility.sf.post('deletebadge', { badgeId: badgeId }, function (d) {
                onDeleteBadge = false;
                searchBadgesStart();
                setTimeout(function () {
                    utility.notify(utility.resx.Gamification.txt_Deleted);
                }, 500);
            }, function () {
                // failed
                utility.notifyError('Failed...');
                onDeleteBadge = false;
            });
        }, function () {
            onDeleteBadge = false;
        });
    };

    var getBadgeImages = function (cb) {
        utility.sf.moduleRoot = 'personabar';
        utility.sf.controller = 'badge';
        utility.sf.get('getbadgeimages', null, function (d) {
            var images = [];
            $.each(d || [], function (i, v) {
                images.push({
                    fileId: v.fileId,
                    name: v.name,
                    url: v.url
                });
            });
            badgesViewModel.badgeEditing.images(images);
            if (typeof cb === 'function') cb();
        }, function () {
            // failed.
            utility.notifyError('Failed...');
            badgesViewModel.badgeEditing.images([]);
            if (typeof cb === 'function') cb();
        });
    };

    var getBadgesSearchParams = function () {
        return {
            desktopModuleId: -1,
            pageIndex: badgesViewModel.pageIndex(),
            pageSize: badgesViewModel.pageSize,
            sortColumn: badgesViewModel.sortColumn(),
            sortAscending: badgesViewModel.sortAscending(),
            searchText: badgesViewModel.searchText()
        };
    };

    var searchBadges = function (cb) {
        $('#badge-editrow > td > div').hide()
        $('#badge-editrow').appendTo('#badges-editbody');
        utility.sf.moduleRoot = 'personabar';
        utility.sf.controller = 'badge';
        var searchParams = getBadgesSearchParams();
        var badgeTiers = {
            '3': utility.resx.Gamification.opt_Gold,
            '2': utility.resx.Gamification.opt_Silver,
            '1': utility.resx.Gamification.opt_Bronze
        };

        utility.sf.get('getbadges', searchParams, function (d) {
            var results = [];
            if (d) {
                $.each(d.Results || [], function (i, v) {
                    var v1 = v.Key;
                    var scoringList = v.Value;
                    var badge = {
                        portalId: ko.observable(v1.PortalId),
                        badgeId: ko.observable(v1.BadgeId),
                        badgeName: ko.observable(v1.BadgeName),
                        description: ko.observable(v1.Description),
                        timeframe: ko.observable(v1.TimeFrameInDays),
                        imageUrl: ko.observable(v1.ImageUrl),
                        imageFileId: ko.observable(v1.ImageFileId),
                        tier: ko.observable(v1.Tier),
                        tierName: ko.observable('')
                    };

                    $.each(badgeTiers, function (index, value) {
                        if (index == badge.tier()) {
                            badge.tierName(value);
                            return false;
                        }
                    });

                    var scoringDetails = '';
                    var scoringModule = '';
                    var count = 0;
                    $.each(scoringList, function (index, value) {
                        if (!scoringModule) scoringModule = index;
                        scoringDetails += '<p>' + index + '<span>' + value + '</span></p>';
                        count++;
                    });

                    badge.scoringModule = ko.observable(scoringModule);
                    badge.scoringDetails = ko.observable(scoringDetails);
                    badge.scoringCount = ko.observable(count);
                    badge.selectedActions = ko.observableArray([]);

                    badge.edit = function (data, e) {
                        e.preventDefault();
                        editBadge(data, e.target);
                    };

                    badge.remove = function (data, e) {
                        e.preventDefault();
                        e.stopPropagation();
                        deleteBadge(data, e.target);
                    };
                    results.push(badge);
                });
            }

            badgesViewModel.results(results);
            badgesViewModel.totalResults(d.TotalResults || 0);
            if (koBinded) $('#badgespanel .qaTooltip').qaTooltip();
            if (typeof cb === 'function') cb();
        }, function () {
            // fail....
            utility.notifyError('Failed...');
            badgesViewModel.results([]);
            badgesViewModel.totalResults(0);
            if (koBinded) $('#badgespanel .qaTooltip').qaTooltip();
            if (typeof cb === 'function') cb();
        });
    };

    var searchBadgesStart = function (cb) {
        badgesViewModel.pageIndex(0);
        searchBadges(cb);
    };

    // subscribe
    var subscribeBadgeEditingTier = function (updated) {
        if (typeof updated !== 'string') return;
        if (badgesViewModel.badgeEditing.badgeId() > 0) return;
        var defaultBadgeName = '';
        switch (updated) {
            case '1':
                defaultBadgeName = 'bronze-basic.png';
                break;
            case '2':
                defaultBadgeName = 'silver-basic.png';
                break;
            case '3':
                defaultBadgeName = 'gold-basic.png';
                break;
        }

        if (defaultBadgeName) {
            var images = badgesViewModel.badgeEditing.images();
            $.each(images, function (i, v) {
                if (v.name.toLowerCase() == defaultBadgeName) {
                    badgesViewModel.badgeEditing.imageFileId() === v.fileId ?
						subscribeBadgeEditingImageFileId(v.fileId) :
						badgesViewModel.badgeEditing.imageFileId(v.fileId);
                    return false;
                }
            });
        }
    };

    var subscribeBadgeEditingImageFileId = function (updated) {
        var url = '';
        if (updated > 0) {
            var images = badgesViewModel.badgeEditing.images();
            $.each(images, function (i, v) {
                if (v.fileId == updated) {
                    url = v.url;
                    return false;
                }
            });
        }
        badgesViewModel.badgeEditing.imageUrl(url);
    };

    var subscribeBadgeEditingModuleFilterId = function (updated) {
        badgesViewModel.badgeEditing.actions.pageIndex(0);
        getAvailableScoringActions();
    };

    var initBadgesPanel = function (cb) {
        utility.asyncParallel([
			function (cb1) {
			    getBadgesDesktopModules(cb1);
			},
			function (cb2) {
			    getBadgeImages(cb2);
			},
			function (cb3) {
			    searchBadges(cb3);
			}
        ],
		function () {
		    // file uploader init
		    utility.sf.moduleRoot = 'personabar';
		    utility.sf.controller = 'badge';
		    var uploadurl = utility.sf.getServiceRoot() + 'badge/uploadbadgeimage?__RequestVerificationToken=' + utility.sf.antiForgeryToken;
		    $('#badge-uploader').fileupload({
		        url: uploadurl,
		        beforeSend: utility.sf.setHeaders,
		        dropZone: $('#badge-dropzone'),
		        replaceFileInput: false,
		        submit: function (e, d) {
		            d.formData = {}; // till now i don't think any extra data needed, but leave it here for further...
		            return true;
		        },
		        progressall: function (e, d) {
		        },
		        done: function (e, d) {
		            if (!d) {
		                badgesViewModel.badgeEditing.images([]);
		                badgesViewModel.badgeEditing.imageFileId(0);
		                return;
		            }

		            var o;
		            if (d.dataType && typeof d.result == 'object' && d.result.length) {
		                d.result = d.result.text();
		            }

		            var testContent = $('<pre>' + d.result + '</pre>');
		            if (testContent.length)
		                o = testContent.text();
		            else
		                o = d.result;

		            var or = o.split(':');
		            if (or.length === 3) {
		                var item = {
		                    fileId: parseInt(or[0]),
		                    name: or[1],
		                    url: or[2]
		                };

		                var images = badgesViewModel.badgeEditing.images();
		                images.push(item);
		                badgesViewModel.badgeEditing.images(images);
		                badgesViewModel.badgeEditing.imageFileId(item.fileId);
		            }
		        },
		        error: function () {
		            // failed.
		            utility.notifyError('Failed...');
		            badgesViewModel.badgeEditing.images([]);
		            badgesViewModel.badgeEditing.imageFileId(0);
		        }
		    });

		    badgesViewModel.badgeEditing.tier.subscribe(subscribeBadgeEditingTier);

		    badgesViewModel.badgeEditing.imageFileId.subscribe(subscribeBadgeEditingImageFileId);

		    badgesViewModel.badgeEditing.moduleFilterId.subscribe(subscribeBadgeEditingModuleFilterId);

		    if (typeof cb === 'function') cb();
		});
    };

    var badgesSearchTextThrottle = null;
    badgesViewModel.searchText.subscribe(function () {
        if (badgesSearchTextThrottle) clearTimeout(badgesSearchTextThrottle);
        badgesSearchTextThrottle = setTimeout(searchBadgesStart, 500);
    });
    // end badges

    var viewModel = {
        scoringViewModel: scoringViewModel,
        privilegesViewModel: privilegesViewModel,
        badgesViewModel: badgesViewModel
    };

    var initPanel = function (panel, cb) {
        if (initializedPanels.indexOf(panel) < 0) {
            switch (panel) {
                case 'scoringpanel':
                    initScoringPanel(function () {
                        if (initializedPanels.indexOf(panel) < 0) initializedPanels.push(panel);
                        if (typeof cb === 'function') cb();
                    });
                    break;
                case 'privilegespanel':
                    initPrivilegesPanel(function () {
                        if (initializedPanels.indexOf(panel) < 0) initializedPanels.push(panel);
                        if (typeof cb === 'function') cb();
                    });
                    break;

                case 'badgespanel':
                    initBadgesPanel(function () {
                        if (initializedPanels.indexOf(panel) < 0) initializedPanels.push(panel);
                        if (typeof cb === 'function') cb();
                    });
                    break;
            }
        }
        else {
            if (typeof cb === 'function') cb();
        }
    };

    return {
        init: function (wrapper, util, params, callback) {
            utility = util;
            tabpanel.init(viewModel, initPanel);
            pager.init(scoringViewModel, 15, searchScoringActions, utility.resx.Gamification);
            pager.init(privilegesViewModel, 15, searchPrivileges, utility.resx.Gamification);
            pager.init(badgesViewModel, 15, searchBadges, utility.resx.Gamification);
            pager.init(badgesViewModel.badgeEditing.actions, 10, getAvailableScoringActions, utility.resx.Gamification);
            pager.init(badgesViewModel.badgeEditing.selectedActions, 10, badgesViewModel.badgeEditing.selectedActions.getPagedResults, utility.resx.Gamification);
            utility.localizeErrMessages(validator);

            var firstTab = wrapper.find('ul.tabControl > li:first-child');
            var firstPanel = firstTab.data('panel-id');
            initPanel(firstPanel, function () {
                var container = wrapper[0];
                viewModel.resx = utility.resx.Gamification;
                ko.applyBindings(viewModel, container);
                koBinded = true;
                $('.qaTooltip', wrapper).qaTooltip();
                firstTab.trigger('click');
                if (typeof callback === 'function') callback();
            });
        },

        load: function (params, callback) {
            if (typeof callback === 'function') callback();
        }
    };
});