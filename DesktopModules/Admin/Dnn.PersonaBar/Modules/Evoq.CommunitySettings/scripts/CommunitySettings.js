// DotNetNuke® - http://www.dnnsoftware.com
//
// Copyright (c) 2002-2016, DNN Corp.
// All rights reserved.

'use strict';
define(['jquery', 'knockout', 'main/pager', 'main/validator'], function ($, ko, pager, validator) {
    var utility = null;
    var triggerInfluenceSubscribe = true;
    var viewModel = {};
    var influenceViewModel = {
        totalResults: ko.observable(0),
        results: ko.observableArray([]),
        searchText: ko.observable(''),
        sortColumn: ko.observable('GoalType'),
        sortAscending: ko.observable(true),
        influenceEditing: {
            goals: ko.observableArray([]),
            id: ko.observable(-1),
            goal: ko.observable(''),
            title: ko.observable(''),
            weight: ko.observable(0),
            value: ko.observable(0),
            minValue: ko.observable(0),
            maxValue: ko.observable(0),
            save: function (item, e) {
                var btn = $(e.target);
                saveInfluence(item, btn);
            },
            cancel: function() {
                $('#influencetbl tr').removeClass('in-edit-row');
                $('#influence-editrow > td > div').slideUp(200, 'linear', function () {
                    $('#influence-editrow').appendTo('#influence-editbody');
                });
            }
        }
    };

    influenceViewModel.influenceEditing.showTitle = ko.computed(function() {
        return influenceViewModel.influenceEditing.id() > 0;
    });

    influenceViewModel.sort = function(vm, e) {
        var column = $(e.target).data('column');
        if (column === influenceViewModel.sortColumn()) {
            influenceViewModel.sortAscending(!influenceViewModel.sortAscending());
        }
        else {
            influenceViewModel.sortColumn(column);
            influenceViewModel.sortAscending(true);
        }
        searchInfluence();
    };

    influenceViewModel.sortColumnClass = function(column) {
        if (column === influenceViewModel.sortColumn()) {
            return influenceViewModel.sortAscending() ? 'asc' : 'desc';
        }
        return '';
    };

    influenceViewModel.create = function () {
        if ($('#createinfluencetbl > tbody > tr').length) return;
        $('#influencetbl tr').removeClass('in-edit-row');
        $('#influence-editrow > td > div').slideUp(200, 'linear', function () {
            $('#influence-editrow').appendTo('#createinfluencetbl > tbody');
            $(this).slideDown(400, 'linear').find('span.dnnFormError').remove();

            influenceInEditing = influenceViewModel.influenceEditing;
            var defaultGoal = influenceViewModel.influenceEditing.goals()[0];
            influenceViewModel.influenceEditing.id(-1);
            influenceViewModel.influenceEditing.goal(defaultGoal.Name);
            influenceViewModel.influenceEditing.title(defaultGoal.Title);
            influenceViewModel.influenceEditing.weight('');
            influenceViewModel.influenceEditing.value('');
            influenceViewModel.influenceEditing.minValue('');
            influenceViewModel.influenceEditing.maxValue('');
        });
    };

    var onSaveInfluence = false;
    var saveInfluence = function(item, btn) {
        if (!validator.validate($('#influence-editrow'), [
            {
                name: 'minlessthanmax',
                errorMsg: utility.resx.CommunitySettings.err_MinLessThanMax,
                validate: function () {
					var min = parseInt(item.minValue());
					var max = parseInt(item.maxValue());
                    return min <= max;
                }
            },
            {
                name: 'betweenminmax',
                errorMsg: utility.resx.CommunitySettings.err_BetweenMinMax,
                validate: function () {
					var min = parseInt(item.minValue());
					var max = parseInt(item.maxValue());
                    if (max < min) return true; // dont validate this rule while max < min
                    var v = parseInt(item.value());
                    return min <= v && max >= v;
                }
            }
        ])) return;
        if (onSaveInfluence) return;
        onSaveInfluence = true;
        btn.html(utility.resx.CommunitySettings.btn_Saving);
		utility.sf.moduleRoot = 'personabar';
		utility.sf.controller = 'CommunitySettings';
        var params = {
            scoringGoalId: item.id(),
            goalType: item.goal(),
            weight: item.weight(),
            value: item.value(),
            minValue: item.minValue(),
            maxValue: item.maxValue()
        };
        utility.sf.post('SaveInfluenceGoal', params, function (d) {

            if (typeof d === 'string') {
                // failed
                var $input = $('#influence-goals-select');
                $('<span></span>').addClass('dnnFormError').html(d).css({ 'right': '-100%'}).insertAfter($input).click(function () {
                    $(this).hide();
                    return false;
                });
                $input.bind('focus', function () {
                    $input.parent().find('span.dnnFormError').hide();
                });
                utility.notifyError('Failed...');
                onSaveInfluence = false;
                btn.html(utility.resx.CommunitySettings.btn_Save);

            } else {
                influenceViewModel.influenceEditing.cancel();
                utility.notify(utility.resx.CommunitySettings.txt_Saved);

                if (params.scoringGoalId < 0) {
                    // create
                    influenceViewModel.influenceEditing.cancel();
                    utility.notify(utility.resx.CommunitySettings.txt_Saved);
                    triggerInfluenceSubscribe = false;
                    influenceViewModel.searchText('');
                    influenceViewModel.sortColumn('GoalType');
                    influenceViewModel.sortAscending(true);
                    influenceViewModel.pageIndex(0);
                    triggerInfluenceSubscribe = true;
                    searchInfluence();

                } else {
                    // update
                    var title = null;
                    var goals = influenceViewModel.influenceEditing.goals();
                    $.each(goals, function (i, v) {
                        if (v.Name === params.goalType) {
                            title = v.Title;
                            return false;
                        }
                    });

                    influenceInEditing.goal(params.goalType);
                    influenceInEditing.title(title);
                    influenceInEditing.weight(params.weight);
                    influenceInEditing.value(params.value);
                    influenceInEditing.minValue(params.minValue);
                    influenceInEditing.maxValue(params.maxValue);
                }

                onSaveInfluence = false;
                btn.html(utility.resx.CommunitySettings.btn_Save);
            }

        }, function() {
            // failed
            utility.notifyError('Failed...');
            onSaveInfluence = false;
            btn.html(utility.resx.CommunitySettings.btn_Save);
        });

    };

    var influenceInEditing = null;
    var editInfluence = function(item, target) {
        var row = $(target).closest('tr');
        if (row.hasClass('in-edit-row')) {
            row.removeClass('in-edit-row');
            $('#influence-editrow > td > div').slideUp(200, 'linear', function () {
                $('#influence-editrow').appendTo('#influence-editbody');
            });
            return;
        }
        var tbody = row.parent();
        $('tr', tbody).removeClass('in-edit-row');
        row.addClass('in-edit-row');
        $('#influence-editrow > td > div').slideUp(200, 'linear', function () {
            $('#influence-editrow').insertAfter(row);
            $('#influence-editrow > td > div').slideDown(400, 'linear').find('span.dnnFormError').remove();
            influenceInEditing = item;
            influenceViewModel.influenceEditing.id(item.id());
            influenceViewModel.influenceEditing.goal(item.goal());
            influenceViewModel.influenceEditing.title(item.title());
            influenceViewModel.influenceEditing.weight(item.weight());
            influenceViewModel.influenceEditing.value(item.value());
            influenceViewModel.influenceEditing.minValue(item.minValue());
            influenceViewModel.influenceEditing.maxValue(item.maxValue());
        });
    };

    var onDeleteInfluence = false;
    var deleteInfluence = function(item, target) {
        if (onDeleteInfluence) return;
        onDeleteInfluence = true;
        utility.confirm(utility.resx.CommunitySettings.txt_ConfirmDelete, utility.resx.CommunitySettings.btn_Delete, utility.resx.CommunitySettings.btn_Cancel, function () {
            utility.sf.moduleRoot = 'personabar';
            utility.sf.controller = "CommunitySettings";
            utility.sf.post('deleteInfluenceGoal', { scoringGoalId: item.id() }, function() {
                onDeleteInfluence = false;
                searchInfluenceStart();
                setTimeout(function() {
                    utility.notify(utility.resx.CommunitySettings.txt_Deleted);
                }, 500);
            }, function () {
                // failed
                utility.notifyError('Failed...');
                onDeleteInfluence = false;
            });

        }, function () {
            onDeleteInfluence = false;
        });
    };

    var searchInfluence = function (cb) {
        $('#influence-editrow > td > div').hide();
        $('#influence-editrow').appendTo('#influence-editbody');
        var params = {
            searchText: influenceViewModel.searchText(),
            pageIndex: influenceViewModel.pageIndex(),
            pageSize: influenceViewModel.pageSize,
            sortColumn: influenceViewModel.sortColumn(),
            sortAscending: influenceViewModel.sortAscending()
        };
        utility.sf.moduleRoot = 'personabar';
        utility.sf.controller = 'CommunitySettings';
        utility.sf.get('GetInfluenceGoals', params, function (data) {
            var results = [], totalResults = 0;
            if (data && data.Success) {
                $.each(data.Results || [], function(i, v) {
                    var item = {
                        id: ko.observable(v.ScoringGoalId),
                        goal: ko.observable(v.GoalType),
                        title: ko.observable(v.Title),
                        weight: ko.observable(v.Weight),
                        value: ko.observable(v.Value),
                        minValue: ko.observable(v.MinValue),
                        maxValue: ko.observable(v.MaxValue)
                    };

                    item.edit = function(d, e) {
                        e.preventDefault();
                        editInfluence(d, e.target);
                    };

                    item.remove = function(d, e) {
                        e.preventDefault();
                        e.stopPropagation();
                        deleteInfluence(d, e.target);
                    };
                    results.push(item);
                });

                totalResults = data.TotalResults || 0;
            }

            influenceViewModel.results(results);
            influenceViewModel.totalResults(totalResults);
            if (typeof cb === 'function') cb();

        }, function () {
            // failed...
            utility.notifyError('Failed...');
            influenceViewModel.results([]);
            influenceViewModel.totalResults(0);
            if (typeof cb === 'function') cb();
        });
    };

    var searchInfluenceStart = function(cb) {
        influenceViewModel.pageIndex(0);
        searchInfluence(cb);
    };

    var getInfluenceGoalTypes = function (cb) {
        utility.sf.moduleRoot = 'personabar';
        utility.sf.controller = 'CommunitySettings';
        utility.sf.get('GetInfluenceGoalTypes', null, function (data) {
            var goals = [];
            if (data && data.Success) {
                goals = data.Goals || [];
            }
            influenceViewModel.influenceEditing.goals(goals);
            if (typeof cb === 'function') cb();
        }, function() {
            // failed...
            utility.notifyError('Failed...');
            influenceViewModel.influenceEditing.goals([]);
            if (typeof cb === 'function') cb();
        });
    };

    var settingsViewModel = {
        contentModeration: ko.observableArray([]),
        commentModeration: ko.observableArray([]),
        editorChoice: ko.observableArray([]),
        pageSize: ko.observable(0),
        commentsPageSize: ko.observable(0),
        profanityFilter: ko.observable(0),
        groupPages: ko.observableArray([]),
        groupHomePage: ko.observable(0)
    };

    settingsViewModel.labelPageSize = function(count) {
        return utility.resx.CommunitySettings.txt_Items.replace('{0}', count);
    };

    settingsViewModel.save = function(item, e) {
        e.preventDefault();
        saveSettings(item, $(e.target));
    };

    var getSettings = function(cb) {
        utility.sf.moduleRoot = 'personabar';
        utility.sf.controller = 'CommunitySettings';
        utility.sf.get('GetSettings', null, function (data) {
            var contentModeration = [];
            var commentModeration = [];
            var editorChoice = [];
            var groupPages = [];
            var pageSize = 0;
            var commentsPageSize = 0;
            var profanityFilter = 0;
            var groupHomePage = 0;
            if (data && data.Success && data.Setting) {
                $.each(data.Setting.ContentModeration || [], function (i, v) {
                    contentModeration.push({
                        label: i,
                        checked: ko.observable(v),
                        id: 'contentModeration-label-' + i
                    });
                });
                $.each(data.Setting.CommentModeration || [], function (i, v) {
                    commentModeration.push({
                        label: i,
                        checked: ko.observable(v),
                        id: 'commentModeration-label-' + i
                    });
                });
                $.each(data.Setting.EditorChoice || [], function (i, v) {
                    editorChoice.push({
                        label: i,
                        checked: ko.observable(v),
                        id: 'editorChoice-label-' + i
                    });
                });
                $.each(data.Setting.GroupPages || [], function (key, value) {
                    groupPages.push({
                        key: key,
                        value: value
                    });
                });

                pageSize = data.Setting.PageSize || 0;
                commentsPageSize = data.Setting.CommentsPageSize || 0;
                profanityFilter = data.Setting.ProfanityFilter || 0;
                groupHomePage = data.Setting.GroupHomePage || 0;
            }

            settingsViewModel.contentModeration(contentModeration);
            settingsViewModel.commentModeration(commentModeration);
            settingsViewModel.editorChoice(editorChoice);
            settingsViewModel.groupPages(groupPages);
            settingsViewModel.pageSize(pageSize);
            settingsViewModel.commentsPageSize(commentsPageSize);
            settingsViewModel.profanityFilter(profanityFilter);
            settingsViewModel.groupHomePage(groupHomePage);
            if (typeof cb === 'function') cb();
        }, function () {
            // failed...
            utility.notifyError('Failed...');
            settingsViewModel.contentModeration([]);
            settingsViewModel.commentModeration([]);
            settingsViewModel.editorChoice([]);
            settingsViewModel.groupPages([]);
            settingsViewModel.pageSize(0);
            settingsViewModel.commentsPageSize(0);
            settingsViewModel.profanityFilter(0);
            settingsViewModel.groupHomePage(0);
            if (typeof cb === 'function') cb();
        });
    };

    var buildSettingsParams = function(items, toInt) {
        var params = {};
        $.each(items, function (i, v) {
            if (!toInt) {
                params[v.label] = v.checked();
            } else {
                params[v.label] = v.checked() ? '1' : '0';
            }
        });
        return params;
    };

    var buildDictionaryParams = function (items) {
        var params = {};
        $.each(items, function (i, item) {
            params[item.key] = item.value;
        });
        return params;
    };

    var onSaveSettings = false;
    var saveSettings = function(item, btn) {
        if (onSaveSettings) return;
        onSaveSettings = true;
        btn.html(utility.resx.CommunitySettings.btn_Saving);
        utility.sf.moduleRoot = 'personabar';
        utility.sf.controller = 'CommunitySettings';
        var params = {
            ContentModeration: buildSettingsParams(settingsViewModel.contentModeration()),
            CommentModeration: buildSettingsParams(settingsViewModel.commentModeration()),
            EditorChoice: buildSettingsParams(settingsViewModel.editorChoice(), true),
            PageSize: settingsViewModel.pageSize(),
            CommentsPageSize: settingsViewModel.commentsPageSize(),
            ProfanityFilter: settingsViewModel.profanityFilter(),
            GroupHomePage: settingsViewModel.groupHomePage(),
            GroupPages: buildDictionaryParams(settingsViewModel.groupPages())
        };

        utility.sf.post('SaveSettings', params, function (d) {
            if (d && d.Success) {
                utility.notify(utility.resx.CommunitySettings.txt_Saved);
            } else {
                utility.notifyError('Failed...');
            }
            onSaveSettings = false;
            btn.html(utility.resx.CommunitySettings.btn_Save);
        }, function () {
            // failed
            utility.notifyError('Failed...');
            onSaveSettings = false;
            btn.html(utility.resx.CommunitySettings.btn_Save);
        });
    };

    return {
        init: function (wrapper, util, params, callback) {
            utility = util;
            pager.init(influenceViewModel, 10, searchInfluence, utility.resx.CommunitySettings);
            utility.localizeErrMessages(validator);
            utility.asyncParallel([
                    function(cb1) {
                        searchInfluence(cb1);
                    },
                    function(cb2) {
                        getInfluenceGoalTypes(cb2);
                    },
                    function (cb3) {
                        getSettings(cb3);
                    }
                ],
                function() {
                    var searchTextThrottle = null;
                    influenceViewModel.searchText.subscribe(function() {
                        if (!triggerInfluenceSubscribe) return;
                        if (searchTextThrottle) clearTimeout(searchTextThrottle);
                        searchTextThrottle = setTimeout(searchInfluenceStart, 500);
                    });
                    var container = wrapper[0];
                    viewModel.resx = utility.resx.CommunitySettings;
                    viewModel.influence = influenceViewModel;
                    viewModel.settings = settingsViewModel;
                    ko.applyBindings(viewModel, container);
                    if (typeof callback === 'function') callback();
            });
        },

        load: function (params, callback) {
            if (typeof callback === 'function') callback();
        }
	};
});