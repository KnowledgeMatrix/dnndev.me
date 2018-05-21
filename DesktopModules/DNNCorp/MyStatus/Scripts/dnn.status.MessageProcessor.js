// DotNetNuke® - http://www.dnnsoftware.com
// Copyright (c) 2002-2016, DNN Corp.
// by DNN Corporation
// All Rights Reserved

if (typeof dnn === 'undefined' || !dnn ) dnn = {};
if (typeof dnn.status === 'undefined') dnn.status = {};

(function(dnn) {
    'use strict';

    dnn.status.MessageProcessor = function (root, social, source, message) {
        var profile;

        if (typeof message.event === 'undefined') {
            console.log('Unable to process IPC message from source', source, message);
            return null;
        }

        switch (message.event) {
            case 'EditContentItem':
            case 'CreateContentItem':
                $.each(root.collections(),
                    function (index, c) {
                        if (c.contentTypeId() == message.model.contentTypeId) {
                            if (message.event == 'CreateContentItem') {
                                c.itemCreated(message.model);
                            }
                            else {
                                c.itemUpdated(message.model);
                            }
                        }
                    });

                break;
            case 'BookmarkCreated':
            case 'BookmarkRemoved':
                $.each(root.builtins(),
                    function (index, c) {
                        if (c.collectionKey() == 'Bookmarks') {
                            if (message.event == 'BookmarkCreated') {
                                c.itemCreated(message.model);
                            } else {
                                c.itemRemoved(message.model);
                            }
                        }
                    });
                break;

            case 'Refresh':
                profile = social.getComponentFactory().resolve('Profile');
                if (profile != null && profile.userIsMe()) {
                    var dynamic = profile.dynamic();
                    if (dynamic != null) {
                        dynamic.reputationPoints(message.points);
                        dynamic.notificationCount(message.notifications);
                        dynamic.messageCount(message.messages);
                    }
                }
                break;
            case 'Reload':
                profile = social.getComponentFactory().resolve('Profile');
                if (profile != null) {
                    profile.load();
                }
                break;
            default:
                return null;
        }
    };
})(window.dnn);