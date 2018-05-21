// DotNetNuke® - http://www.dnnsoftware.com
//
// Copyright (c) 2002-2016, DNN Corp.
// All rights reserved.

if (typeof dnn === 'undefined' || !dnn ) dnn = {};
if (typeof dnn.social === 'undefined') dnn.social = {};

(function(dnn) {
    'use strict';

    dnn.social.SocialController = function SocialController ($, ko, settings, social, model, contentItemId, objectKey) {
        var that = this;

        this.componentFactory = social.getComponentFactory();

        this.loading = ko.observable(false);

        if (typeof model === 'undefined' || typeof model.liked === 'undefined') {
            this.liked = ko.observable(false);
        }
        else {
            if (typeof (model.liked) === 'function') {
                this.liked = model.liked;
            }
            else {
                this.liked = ko.observable(this.liked || false);
            }
        }

        if (typeof model === 'undefined' || typeof model.likes === 'undefined') {
            this.likes = ko.observable(0);
        }
        else {
            if (typeof (model.likes) === 'function') {
                this.likes = model.likes;
            }
            else {
                this.likes = ko.observable(this.likes || 0);
            }
        }
        
        if (typeof model === 'undefined' || typeof model.likes === 'undefined') {
            this.likeString = ko.observable('');
        }
        else {
            if (typeof (model.likeString) === 'function') {
                this.likeString = model.likeString;
            }
            else {
                this.likeString = ko.observable(this.likeString || '');
            }
        }

        if (typeof model === 'undefined' || typeof model.subscribed === 'undefined') {
            this.subscribed = ko.observable(false);
        }
        else {
            if (typeof (model.subscribed) === 'function') {
                this.subscribed = model.subscribed;
            }
            else {
                this.subscribed = ko.observable(this.subscribed || false);
            }
        }

        if (typeof model === 'undefined' || typeof model.bookmarked === 'undefined') {
            this.bookmarked = ko.observable(false);
        }
        else {
            if (typeof (model.bookmarked) === 'function') {
                this.bookmarked = model.bookmarked;
            }
            else {
                this.bookmarked = ko.observable(this.bookmarked || false);
            }
        }

        this.likeable = ko.computed(
            function () {
                return that.liked() == false;
            });

        this.like = function (data, event) {
            if (dnn.social.authorizationRequired(settings)) {
                return true;
            }

            if (that.liked() == false) {
                that.likes(that.likes() + 1);
                that.liked(true);

                var failure = function () {
                    $(event.srcElement).show();
                    that.liked(false);
                    that.likes(that.likes() - 1);
                };

                var success = function(m) {
                    $(event.srcElement).show();
                    if (m && m.LikeList) {
                        that.likeString(m.LikeList);
                    } else {
                        that.likeString({ Big: '', Small : '' });
                    }
                    bindLikeControl();

                    dnn.social.EventQueue.push(
                        function () {
                            dnn.social.ipc.post({}, settings.moduleRoot, { event: 'Like' });
                        });
                };

                if(event.srcElement)
                    $(event.srcElement).hide();
                
                return that.call('Like', failure, success);
            }

            return false;
        };

        this.unlike = function (data, event) {
            if (dnn.social.authorizationRequired(settings)) {
                return true;
            }

            if (that.liked() == true) {
                that.likes(that.likes() - 1);
                that.liked(false);

                var failure = function () {
                    $(event.srcElement).show();
                    that.liked(true);
                    that.likes(that.likes() + 1);
                };
                
                var success = function (m) {
                    $(event.srcElement).show();
                    if (m && m.LikeList) {
                        that.likeString(m.LikeList);
                    } else {
                        that.likeString({ Big: '', Small: '' });
                    }
                    
                    bindLikeControl();
                };

                $(event.srcElement).hide();
                return that.call('Unlike', failure, success);
            }

            return false;
        };

        this.toggleLike = function(data, event) {
            return that.liked() ? 
                that.unlike(data, event) :
                that.like(data, event);
        };

        this.bookmark = function (data, event) {
            if (dnn.social.authorizationRequired(settings)) {
                return true;
            }

            if (!that.bookmarked()) {
                that.bookmarked(true);

                var failure = function () {
                    $(event.srcElement).show();
                    that.bookmarked(false);
                };

                var success = function () {
                    $(event.srcElement).show();
                    dnn.social.EventQueue.push(
                        function () {
                            dnn.social.ipc.post(settings, 'DNNCorp/MyStatus',
                                {
                                    event: 'BookmarkCreated',
                                    model: that.getCollectionItem()
                                });
                        });
                };

                $(event.srcElement).hide();
                return that.call('Bookmark', failure, success);
            }
            
            return false;
        };

        this.unbookmark = function (data, event) {
            if (dnn.social.authorizationRequired(settings)) {
                return true;
            }

            if (that.bookmarked()) {
                that.bookmarked(false);
                
                var failure = function () {
                    $(event.srcElement).show();
                    that.bookmarked(true);
                };

                var success = function () {
                    $(event.srcElement).show();
                    dnn.social.EventQueue.push(
                        function () {
                            dnn.social.ipc.post(settings, 'DNNCorp/MyStatus',
                                {
                                    event: 'BookmarkRemoved',
                                    model: that.getCollectionItem()
                                });
                        });
                };

                $(event.srcElement).hide();
                return that.call('Unbookmark', failure, success);
            }
            
            return false;
        };

        this.subscribe = function (data, event) {
            if (dnn.social.authorizationRequired(settings)) {
                return true;
            }

            if (!that.subscribed()) {
                that.subscribed(true);

                var failure = function () {
                    $(event.srcElement).show();
                    that.subscribed(false);
                };

                var success = function() {
                    $(event.srcElement).show();
                };

                $(event.srcElement).hide();
                return that.call('Subscribe', failure, success);
            }
            
            return false;
        };

        this.unsubscribe = function (data, event) {
            if (dnn.social.authorizationRequired(settings)) {
                return true;
            }

            if (that.subscribed()) {
                that.subscribed(false);

                var failure = function () {
                    $(event.srcElement).show();
                    that.subscribed(true);
                };

                var success = function () {
                    $(event.srcElement).show();
                };

                $(event.srcElement).hide();
                return that.call('Unsubscribe', failure);
            }

            return false;
        };

        dnn.social.ipc.register(settings,
          function (source, message) {
              if (!message || !message.event) return;
              switch (message.event) {
                  case 'PostComment':
                  case 'UpVotePost':
                  case 'PostAnswer':
                  case 'Like':
                  case 'LikeComment':
                  case 'AttendEvent':
                  case 'VoteIdea':
                      that.isSubscribed();
                      break;
              }
          });

        this.isSubscribed = function(data, event) {
            var success = function(response) {
                that.subscribed(response.isSubscribed);
            };

            var failure = function(xhr, status) {
            };

            that.call('IsSubscribed', failure, success);
        };

        this.call = function (method, failure, success) {
            var service = social.getService('Social');
            if (service == null) {
                return;
            }

            var params = {
                journalTypeId: settings.journalTypeId || -1,
                contentItemId: contentItemId,
                groupId: settings.groupId || -1,
                objectKey: objectKey || null
            };

            var failureCallback = function (xhr, status) {
                var localizer = social.getLocalizationController();
                if (localizer == null) {
                    return;
                }

                $.dnnAlert({
                    title: localizer.getString('{0}Failure'.format(method)),
                    text: status || localizer.getString('UnknownError')
                });

                if (typeof (failure) === 'function') {
                    failure();
                }
            };

            service.post(method, params, success, failureCallback, that.loading);
        };

        this.getCollectionItem = function () {
            return {
                id: -1,
                title: model.contentTitle(),
                targetUrl: model.detailsUrl(),
                contentItemId: model.contentItemId(),
                contentTypeId: model.contentTypeId(),
                createdOnDate: model.createdOnDate(),
                lastModifiedOnDate: model.lastModifiedOnDate()
            };
        };

        var bindLikeControl = function() {
            if (typeof dnn.social.initLikeControl === 'function') {
                var container = '';
                if (typeof model.getLikeControlId === 'function') container = '#' + model.getLikeControlId();
                if (typeof model.getLikeControlMobileId === 'function') container += ', #' + model.getLikeControlMobileId();

                if (container) {
                    dnn.social.initLikeControl().bindControls($(container));
                } else {
                    dnn.social.initLikeControl().bindControls();
                }
            }
        };
    };
})(window.dnn);