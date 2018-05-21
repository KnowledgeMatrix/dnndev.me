// DotNetNuke® - http://www.dnnsoftware.com
// Copyright (c) 2002-2016, DNN Corp.
// by DNN Corporation
// All Rights Reserved

if (typeof dnn === 'undefined' || !dnn) dnn = {};
if (typeof dnn.challenges === 'undefined') dnn.challenges = {};

(function (dnn, $, ko) {
    
    dnn.challenges.ListView = function ListView() {
        dnn.social.ListView.apply(this, Array.prototype.slice.call(arguments));
        this.register(this, 'PrimaryView');
        this.register(new dnn.challenges.ListController($, ko, this.settings, this.social));
        this.register(new dnn.social.FocusController($, ko, this.settings, this.social, window.document, []));
        var pagingControl = this.social.getPagingControl('ListController');
        if (pagingControl) {
            pagingControl.page(this.settings.pageIndex || 0);
            this.register(pagingControl);
        }
        this.init();
    };

    try{
        dnn.challenges.ListView.prototype = Object.create(dnn.social.ListView.prototype);
    } catch (ex) {
        location.reload();//avoid script load error when module injected from ajax panel call.
    }

    dnn.challenges.ListView.prototype.init = function () {
        this.challengeTypes = [
            { value: 1, challengeType: this.getString('SocialNetworkShare') },
            { value: 2, challengeType: this.getString('VoteOnQorA') },
            { value: 3, challengeType: this.getString('VoteOnIdea') },
            { value: 4, challengeType: this.getString('ProvideAnswer') },
            { value: 5, challengeType: this.getString('Comment') },
            { value: 6, challengeType: this.getString('ContentCreation') },
            { value: 7, challengeType: this.getString('ProfileCompletion') }
        ];

        this.sortOptions = [
            { value: 'lastactive', text: this.getString('SortByRecentActivity') },
            { value: 'title', text: this.getString('SortByTitle') }
        ];

        dnn.social.ListView.prototype.init.apply(this);
    };

    dnn.challenges.ListView.prototype.validateCategory = function (c) {
        if (c === 'mychallenges' || c === 'mycomments')
            return !dnn.social.authorizationRequired(this.settings);
        return true;
    };

    dnn.challenges.ListView.prototype.bindControls = function () {
        dnn.social.ListView.prototype.bindControls.apply(this);
        if (window.location.hash) {
            var hash = window.location.hash.substring(1);
            if (hash == 'create' && this.settings.canModerate) {
                var moduleRoot = this.settings.moduleRoot;
                setTimeout(function() {
                    dnn.social.ipc.post({}, moduleRoot, { event: 'addDialog', message: '' });
                }, 200);
            }
        }
        
    };

})(window.dnn, window.jQuery, window.ko);
