// DotNetNuke® - http://www.dnnsoftware.com
//
// Copyright (c) 2002-2016, DNN Corp.
// All rights reserved.

define(['knockout'], function (ko) {

    'use strict';
    if (!ko.components.isRegistered('community-users')) {
        ko.components.register('community-users', {
            viewModel: function(params) {
                this.users = params.users;
                this.titleFirstColumn = params.titleFirstColumn;
                this.titleSecondColumn = params.titleSecondColumn;
                this.sideCss = params.sideCss || '';
            },
            template: ' \
		    <table class="cmxtbl" data-bind="css: sideCss"> \
			    <colgroup> \
				    <col class="col-avatar"/> \
				    <col class="col-name"/> \
				    <col class="col-info"/> \
			    </colgroup> \
			    <thead> \
				    <tr> \
					    <th colspan="2"><a data-bind="html: titleFirstColumn"></a></th> \
					    <th><a data-bind="html: titleSecondColumn"></a></th> \
				    </tr> \
			    </thead> \
		        <!-- ko if: users().length > 0 --> \
                <tbody data-bind="foreach: users"> \
                    <!-- ko if: !isEmpty --> \
		            <tr data-bind="click: navigate"> \
		                <td> \
		                    <div class="useravatar"> \
		                        <span><em><img data-bind="attr: { \'src\': avatarUrl }" /></em></span> \
		                    </div> \
		                </td> \
		                <td><span data-bind="html: displayName"></span></td> \
		                <td class="count"><span data-bind="html: value, attr: { title: $parent.titleSecondColumn + \' \' + valueTooltip }"></span></td> \
		            </tr> \
                    <!-- /ko --> \
                    <!-- ko if: isEmpty --> \
                    <tr> \
		                <td colspan="3" class="count"><span data-bind="html: displayName"></span></td> \
		            </tr> \
                    <!-- /ko --> \
		        </tbody> \
                <!-- /ko --> \
                <!-- ko if: users().length === 0 --> \
                <tbody> \
                    <tr class="last"> \
                        <td class="no-data-available" colspan="3" data-bind="text: $root.resx.topCommunity_NoDataAvailable"></td> \
                    </tr> \
                </tbody> \
                <!-- /ko --> \
		    </table> \
	    '
        });
    }
});