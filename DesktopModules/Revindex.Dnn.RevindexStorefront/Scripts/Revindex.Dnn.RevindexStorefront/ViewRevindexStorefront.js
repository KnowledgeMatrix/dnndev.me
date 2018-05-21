var Revindex = Revindex || {};
Revindex.Dnn = Revindex.Dnn || {};
Revindex.Dnn.RevindexStorefront = Revindex.Dnn.RevindexStorefront || {};

jQuery(document).ready(function($)
{
	// BUG: Allow AJAX to work correctly with Google Chrome and Apple Safari
	// http://forums.asp.net/t/1252014.aspx/3/10
	Sys.Browser.WebKit = {};
	if (navigator.userAgent.indexOf('WebKit/') > -1)
	{
		Sys.Browser.agent = Sys.Browser.WebKit;
		Sys.Browser.version = parseFloat(navigator.userAgent.match(/WebKit\/(\d+(\.\d+)?)/)[1]);
		Sys.Browser.name = 'WebKit';
	}

	Revindex.Web.FormTracker.ConfirmUnsavedChanges(".rvdsfContentContainer div.dnnForm:not(.rvdsfSearchContainer, .rvdsfListContainer)", "Your changes have not been saved.", ".rvdSaveAction");

    // Automatically scroll to content view if current page has 
    // acted on the Storefront module and there is no fragment targetted.
	if (window.location.href.toLowerCase().indexOf("rvdsfpt") >= 0 && window.location.href.indexOf("#") < 0)
	    document.getElementById("RvdsfContentAnchor").scrollIntoView();

    // BUG: RadTreeView bug error in Chrome when scroll position is not a round number
    // http://www.telerik.com/forums/system-formatexception-78e82e51af27
	Revindex.Dnn.RevindexStorefront.fixTelerik()
	Sys.WebForms.PageRequestManager.getInstance().add_endRequest(Revindex.Dnn.RevindexStorefront.fixTelerik);
});


Revindex.Dnn.RevindexStorefront.fixTelerik = function()
{
    // BUG: RadTreeView bug error in Chrome when scroll position is not a round number
    // http://www.telerik.com/forums/system-formatexception-78e82e51af27
    if (Telerik != undefined) {
        if (Telerik.Web.UI.RadListBox != undefined) {
            Telerik.Web.UI.RadListBox.prototype.saveClientState = function () {
                return "{" +
                            "\"isEnabled\":" + this._enabled +
                            ",\"logEntries\":" + this._logEntriesJson +
                           ",\"selectedIndices\":" + this._selectedIndicesJson +
                           ",\"checkedIndices\":" + this._checkedIndicesJson +
                           ",\"scrollPosition\":" + Math.round(this._scrollPosition) +
                       "}";
            }
        }

        if (Telerik.Web.UI.RadTreeView != undefined) {
            Telerik.Web.UI.RadTreeView.prototype.saveClientState = function () {
                return "{\"expandedNodes\":" + this._expandedNodesJson +
                        ",\"collapsedNodes\":" + this._collapsedNodesJson +
                        ",\"logEntries\":" + this._logEntriesJson +
                        ",\"selectedNodes\":" + this._selectedNodesJson +
                        ",\"checkedNodes\":" + this._checkedNodesJson +
                        ",\"scrollPosition\":" + Math.round(this._scrollPosition) + "}";
            }
        }
    }
}