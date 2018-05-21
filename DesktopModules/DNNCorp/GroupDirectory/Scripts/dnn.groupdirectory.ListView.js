// DotNetNuke® - http://www.dnnsoftware.com
// Copyright (c) 2002-2016, DNN Corp.
// by DNN Corporation
// All Rights Reserved

if (typeof dnn === 'undefined' || !dnn) dnn = {};
if (typeof dnn.groupDirectory === 'undefined') dnn.groupDirectory = {};


(function (dnn, $, ko) {
    dnn.groupDirectory.ListView = function () {
        dnn.social.ListView.apply(this, Array.prototype.slice.call(arguments));
        this.register(this, 'PrimaryView');
        this.register(new dnn.groupDirectory.ListController($, ko, this.settings, this.social));
        this.register(new dnn.social.FocusController($, ko, this.settings, this.social, window.document, []));
        var pagingControl = this.social.getPagingControl('ListController');
        if (pagingControl) {
            pagingControl.page(this.settings.pageIndex || 0);
            this.register(pagingControl);
        }

        this.init();
    };

    try{
        dnn.groupDirectory.ListView.prototype = Object.create(dnn.social.ListView.prototype);
    } catch (ex) {
        location.reload();//avoid script load error when module injected from ajax panel call.
    }

    dnn.groupDirectory.ListView.prototype.init = function () {
        var self = this;
        this.social = new dnn.social.Module(this.settings);
        this.service = this.social.getService('List');

        this.sortOptions = [
            { value: 'groupName', text: this.getString('SortByGroupName') },
            { value: 'memberCount', text: this.getString('SortByNumberOfMembers') },
            { value: 'lastActivityDate', text: this.getString('SortByRecentActivity') },
            { value: 'createdOnDate', text: this.getString('SortByCreatedDate') }
        ];
        
        this.getSiteRoot = function () {
            return dnn.getVar("sf_siteRoot", "/");
        },

        this.canCreate = ko.observable(this.settings.canCreate);
        this.canModerate = ko.observable(this.settings.canModerate);

        var viewModeValueInCookie = dnn.social.getCookieValueByName(this.settings.viewModeCookieKey);
        if (viewModeValueInCookie) {
            this.viewMode = ko.observable(viewModeValueInCookie);
        } else {
            this.viewMode = ko.observable(this.settings.viewMode);
        }
        
        this.setViewMode = function (mode) {
            self.viewMode(mode);
            document.cookie = this.settings.viewModeCookieKey + "=" + mode + ";expires='';path=" + self.getSiteRoot();  // window.location.pathname;
        };
        this.viewModeSelectClass = function (mode) {
            self.listController().loadGroupToolTips();
            self.switchedView();
            return self.viewMode() == mode ? 'selected' : 'deselected';
        };
        
        dnn.social.ListView.prototype.init.apply(this);
    };

    dnn.groupDirectory.ListView.prototype.validateCategory = function (c) {
        if (c === 'mygroups')
            return !dnn.social.authorizationRequired(this.settings);
        return true;
    };
    
    dnn.groupDirectory.ListView.prototype.addDialog = function (query) {
        if (dnn.social.authorizationRequired(this.settings)) return false;
        var localizer = this.localizer();
        var options = {
            modal: true,
            autoOpen: true,
            dialogClass: 'dnnFormPopup',
            title: localizer.getString('CreateAGroup'),
            minWidth: 900,
            closeOnEscape: false,
            resizable: false,
            open: function () {
	            if ($.ui.dialog.prototype.options.open) {
		            $.ui.dialog.prototype.options.open.apply(this, arguments);
	            }

	            $('.create-dialog').find('div.dnnTagsInput input[id$="_tag"]').each(function() {
	            	var $input = $('#' + $(this).attr('id').replace('_tag', ''));
					if ($input.data('dnnTagInput')) {
						$(this).dnnResetAutosize($input.data('dnnTagInput'));
					}
	            });
            },
            close: $.ui.dialog.prototype.options.close,
        };
                
        var createModel = window.ko.contextFor($(this.settings.createId)[0]).$root;
        if(typeof query === 'string') createModel.groupName(query);
        createModel.tags([]);
        createModel.description('');
        createModel.switchTo(0);
        createModel.bindControls();
        $('.create-dialog').dialog(options);
        return true;
    };
    
    dnn.groupDirectory.ListView.prototype.addDialogMobileView = function (query) {
        if (dnn.social.authorizationRequired(this.settings)) return false;
        var localizer = this.localizer();
        var options = dnn.social.MobileView.dialogOptions({
            title: localizer.getString('CreateGroup')
        });

        $('.create-dialog').dialog(options);
        $('.dnnFormPopup.dnnFormPopupMobileView').css({ 'width': options.width, left: '20px' });
        var createModel = window.ko.contextFor($(this.settings.createId)[0]).$root;
        if (createModel != null) {
            if (typeof query === 'string') createModel.groupName(query);
            createModel.tags([]);
            createModel.description('');
            createModel.switchTo(0, true);
            createModel.bindControls();
        }
        return true;
    };

})(window.dnn, window.jQuery, window.ko);
