define(function () {
    'use strict';
    var sf;

    var notify = function notify(payload) {
        if (!sf) {
            throw new Error('Service Framework is not defined');
        }
        sf.moduleRoot = 'formbuilderlibrary';
        sf.controller = 'FormBuilderTemplateFile';
        sf.postsilence('Notify', payload);
    };
    return {
        init: function init(serviceFramework) {
            sf = serviceFramework;
        },
        notifyFormTemplateChange: function (formTemplateId, action) {
            notify({ formTemplateId: formTemplateId, action: action });
        }
    }
});