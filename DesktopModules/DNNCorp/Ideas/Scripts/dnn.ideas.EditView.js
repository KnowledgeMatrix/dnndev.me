// DotNetNuke® - http://www.dnnsoftware.com
//
// Copyright (c) 2002-2016, DNN Corp.
// All rights reserved.

if (typeof dnn === 'undefined' || !dnn) dnn = {};
if (typeof dnn.ideas === 'undefined') dnn.ideas = {};

(function (dnn) {
    'use strict';

    dnn.ideas.EditView = function EditView($, ko, settings, model) {
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

        var localizer = this.social.getLocalizationController();

        this.statusList = [
            { value: 0, status: localizer.getString('Status.Submitted') },
            { value: 5, status: localizer.getString('Status.UnderReview') },
            { value: 33, status: localizer.getString('Status.Reviewed') },
            { value: 15, status: localizer.getString('Status.Accepted') },
            { value: 20, status: localizer.getString('Status.Scheduled') },
            { value: 25, status: localizer.getString('Status.Delivered') },
            { value: 30, status: localizer.getString('Status.Duplicate') }
        ];

        this.votesRemaining = ko.computed(
            function () {
                var root = ko.contextFor($(settings.parentId)[0]);

                if (typeof root !== 'undefined' && root != null && typeof root.$root !== 'undefined') {
                    return root.$root.votesRemaining();
                }

                return -1;
            });

        this.moderator = settings.moderator || false;

        this.model = ko.observable(new dnn.ideas.IdeaModel($, ko, settings, that.social, model));

        this.loading = ko.observable(false);

        this.categories = ko.observableArray([]);

        this.ideaTypes = ko.observableArray([]);

        this.subscribeToActivity = ko.observable();

        this.showModeration = ko.observable(false);

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

        this.bindControls = function (sequence, content) {
            dnn.social.EventQueue.push(
                function () {
                    if (String.isEmpty(settings.suggestedTitle) == false) {
                        that.model().contentTitle(settings.suggestedTitle);
                        dnn.social.EventQueue.push(
                            function () {
                                $('.idea-add-content', settings.moduleScope).focus();
                            });
                    } else {
                        $('.idea-add-title', settings.moduleScope).focus();
                    }
                });

            that.showModeration(false);

            if (typeof that.controlsBound !== 'undefined') {
                that.model(new dnn.ideas.IdeaModel($, ko, settings, that.social, model));
                that.initModel();

            } else {
                that.controlsBound = true;
            }

            $('#ideas-edit-tags', settings.moduleScope).val(that.serializeTags(that.model().tags()));
            $('#ideas-edit-tags', settings.moduleScope).dnnTagsInput({
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
                defaultText: localizer.getString('AddTag')
            });

            var editorSettings = {
                toolbar: settings.editorToolbar,
                allowIframe: settings.editorAllowIframe,
                allowScript: settings.editorAllowScript,
                allowEmbed: settings.editorAllowEmbed
            };
            
            var module = $('.idea-add-content', settings.moduleScope).addClass('validateErrorAfterParent');

            if (content !== undefined) {
                that.model().content(content);
            }

            dnn.social.initRedactor(module, null, settings.editorMode, that.isMobileView(), that.postImageService.getRoot(), editorSettings,
               function (redactor) {
                   if (that.model().content()) {
                       $('.idea-add-content', settings.moduleScope).dnnRedactor('code.set', that.model().content());
                   }
                   dnn.social.initUserMentions(module, settings.moduleId, settings.moduleName, true, redactor);
               });

            if (sequence !== undefined) {
                that.model().revisionSequence(sequence);
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

        this.refreshTerms = function (parentId) {
            var failure = function (xhr, status) {
                var message = status || localizer.getString('UnknownError');

                $.dnnAlert({
                    title: localizer.getString('UnableToGetTermsTitle'),
                    text: localizer.getString('UnableToGetTerms').format(message)
                });
            };

            var success = function (result) {
                var terms = [];

                $.each(result.Terms,
                    function (index, term) {
                        terms.push(dnn.social.komodel(term));
                    });

                if (result.ParentId != -1)
                    that.categories(terms);
                else
                    that.ideaTypes(terms);

                if (that.ideaTypes().length > 0) {
                    $('#categories', settings.moduleScope).show();
                }
                else {
                    $('#categories', settings.moduleScope).hide();
                }
            };

            var params = {
                parentId: parentId || -1
            };

            that.service.get('GetTerms', params, success, failure);
        };

        this.completionEvent = function (m) {
            if ((settings.parentId || '').length > 0) {
                var root = ko.contextFor($(settings.parentId)[0]);

                if (root && root.$root) {
                    if (typeof root.$root.refresh === 'function') {
                        root.$root.refresh();
                        root.$root.votesRemaining(m.VotesRemaining < 0 ? 0 : m.VotesRemaining);
                    }

                    var idea = m.Idea;

                    var collectionItem = {
                        id: idea.contentItemId,
                        title: idea.contentTitle,
                        targetUrl: idea.detailsUrl,
                        contentItemId: idea.contentItemId,
                        contentTypeId: idea.contentTypeId,
                        createdOnDate: idea.createdOnDate,
                        lastModifiedOnDate: idea.lastModifiedOnDate
                    };

                    if (that.model().ideaId() < 1) {
                        dnn.social.ipc.post(settings, 'DNNCorp/MyStatus', { event: 'CreateContentItem', model: collectionItem });

                        dnn.social.ipc.post(settings, 'DNNCorp/RelatedContent',
                           { event: 'Refresh' });

                        var voteMsg = {
                            event: 'SetVotesRemaining',
                            votesRemaining: m.VotesRemaining,
                            votesUsed: m.VotesUsed
                        };

                        dnn.social.ipc.post(settings, 'DNNCorp/Ideas', voteMsg);
                    }
                    else {
                        dnn.social.ipc.post(settings, 'DNNCorp/MyStatus',
                            { event: 'EditContentItem', model: collectionItem });
                    }

                    if (idea.authorized) {
                        that.cancel();
                    } else {
                        that.showModeration(true);
                    }
                    that.enableSubmit(true);
                }

                if (typeof dnn.social.refreshUser === 'function') {
                    dnn.social.refreshUser();
                }

                return true;
            }

            return false;
        };

        this.save = function () {
            if (!that.enableSubmit())
                return false;

            that.enableSubmit(false);

            if (!that.validate($('#postFields', settings.moduleScope))) {
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
                    $.dnnRevisionChangePrompt(localizer, continueWith);
                    that.enableSubmit(true);
                } else {
                    continueWith();
                }
            };

            var params = {
                ideaId: that.model().ideaId(),
                sequence: that.model().revisionSequence()
            };

            return that.service.get('GetLastSequence', params, success, failure);
        };

        this.submit = function () {
            var failure = function (xhr, status) {
                var r = JSON.parse(xhr.responseText);
                $.dnnAlert({
                    title: r.Title || localizer.getString('SaveFailedTitle'),
                    text: status || localizer.getString('SaveFailed')
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
                    if (typeof (t) === 'string') {
                        tags.push(t);
                    } else {
                        tags.push(t.name());
                    }
                });

            var html = $('.idea-add-content', settings.moduleScope).dnnRedactor('code.get');

            var params = {
                ideaId: that.model().ideaId(),
                groupId: settings.groupId,
                portalId: that.model().portalId(),
                authorized: that.model().authorized(),
                'protected': that.model().protected(),
                status: that.model().status(),
                content: html,
                contentTitle: that.model().contentTitle(),
                initialVotes: that.model().voteButtons.initialVotes(),
                selectedTypeId: that.model().typeId() || -1,
                selectedCategoryId: that.model().categoryId() || -1,
                subscribeToActivity: that.subscribeToActivity(),
                tags: tags
            };

            if (that.model().ideaId() < 0) {
                that.service.post('Create', params, success, failure, that.loading);
            } else {
                that.getLastSequence(function () {
                    that.service.post('Update', params, success, failure, that.loading);
                });
            }
        };

        this.cancel = function () {
            $('.editor-dialog').dialog('close');
            that.showModeration(false);
        };

        this.setSuggestedTitle = function (title) {
            settings.suggestedTitle = title;
        };

        this.initModel = function () {
            if (that.model != null) {
                that.subscribeToActivity(true);
                that.model().voteButtons.initialVotes(that.initialVotes);
                if (that.model().ideaId() < 1) {
                    if (settings.approved) {
                        that.model().authorized(true);
                    }
                }
            }
        };

        this.loading.subscribe(function () {
            if (that.loading()) {
                $(settings.moduleScope).addClass('loading');
            }
            else {
                $(settings.moduleScope).removeClass('loading');
            }
        });

        if (this.model() && this.model().typeId) {
            this.model().typeId.subscribe(function () {
                that.refreshTerms(that.model().typeId());
            });
        }

        this.binded = function () {
            this.initModel();
            this.refreshTerms();
        };
    };

})(window.dnn);