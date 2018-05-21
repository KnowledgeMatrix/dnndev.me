define(function () {
    'use strict';
    var sf;

    return {
        init: function init(serviceFramework) {
            sf = serviceFramework;
        },
        getToken: function getToken(success, error, forceNewToken) {
            if (!sf) {
                throw new Error('Service Framework is not defined');
            }
            sf.moduleRoot = 'formbuilderlibrary';
            sf.controller = 'authorization';
            sf.post('GetAuthorizationToken', { forceNewToken: forceNewToken })
                .success(function onSuccess(data) {
                    var token = data.token;
                    success(token);
                })
                .error(function onError(err) {
                    error(err);
                });
        }
    }
});