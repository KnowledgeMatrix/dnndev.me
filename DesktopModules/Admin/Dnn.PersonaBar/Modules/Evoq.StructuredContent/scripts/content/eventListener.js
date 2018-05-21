define(function () {
    'use strict';
    var sf;

    var isValidAction = function isValidAction(action) {
        return (action === "update" || action === "delete");
    };

    var notify = function notify(payload) {
        if (!sf) {
            throw new Error('Service Framework is not defined');
        }
        sf.moduleRoot = 'structuredcontentlibrary';
        sf.controller = 'StructuredContentCache';
        sf.postsilence('Notify', payload);
    };

    return {
        init: function init(serviceFramework) {
            sf = serviceFramework;
        },
        notifyContentTypeChange: function (contentTypeId, action) {
            if (isValidAction(action)) {
                notify({ contentTypeId: contentTypeId, action: action });
            }
        },
        notifyContentItemChange: function (contentItemId, action, contentTypeId, parameters) {
            notify({ contentItemId: contentItemId, contentTypeId: contentTypeId, action: action, parameters: parameters });
        },
        notifyVisualizerChange: function (visualizerId, action) {
            if (isValidAction(action)) {
                notify({ visualizerId: visualizerId, action: action });
            }
        }
    }
});
