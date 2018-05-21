var Revindex = Revindex || {};
Revindex.Web = Revindex.Web || {};
Revindex.Xml = Revindex.Xml || {};

//
// The following object uses the RadAjaxLoadingPanel
// to show the update progress during Ajax postback.
//
// Example:
// Revindex.Web.AjaxProgressLoading.Initialize(radAjaxLoadingPanelID);
//
Revindex.Web.AjaxProgressLoading = new function () {
    this.DnnAjaxLoadingPanelID = "";

    this.Initialize = function (dnnAjaxLoadingPanelID) {
        this.DnnAjaxLoadingPanelID = dnnAjaxLoadingPanelID;

        jQuery(document).ready(function () {
            var pageRequestManager = Sys.WebForms.PageRequestManager.getInstance();
            pageRequestManager.add_initializeRequest(Revindex.Web.AjaxProgressLoading.InitializeRequest);
            pageRequestManager.add_endRequest(Revindex.Web.AjaxProgressLoading.EndRequest);
        });
    }

    this.InitializeRequest = function (sender, eventArgs) {
        loadingPanel = $find(Revindex.Web.AjaxProgressLoading.DnnAjaxLoadingPanelID);
        postBackElement = eventArgs.get_postBackElement().id;
        loadingPanel.show(postBackElement);
    }

    this.EndRequest = function (sender, eventArgs) {
        loadingPanel = $find(Revindex.Web.AjaxProgressLoading.DnnAjaxLoadingPanelID);
        loadingPanel.hide(postBackElement);
    }
}

// This function parses a URL querystring and
// explodes it into a hash array
// e.g. var params = Revindex.Web.GetUrlQueryParameters(location.href.search);
Revindex.Web.GetUrlQueryParameters = function()
{
    return Revindex.Web.ParseQueryString(window.location.search.substring(1));
}

Revindex.Web.HtmlDecode = function(s)
{
   	if (s == undefined || s == null || s == "")
   		return s;

   	return s.split('&amp;').join('&').split('&lt;').join('<').split('&gt;').join('>').split('&quot;').join('"');
}

Revindex.Web.HtmlEncode = function(s)
{
	if (s == undefined || s == null || s == "")
		return s;
	
	return s.split('&').join('&amp;').split('<').join('&lt;').split('>').join('&gt;').split('"').join('&quot;');
}

//
// Maintain control focus after full postback or AJAX partial postback.
//
Revindex.Web.MaintainFocus = new function()
{
	this.lastFocusedControlID = "";

	this.Initialize = function(partialPostback)
	{
		jQuery(document).ready(function()
		{
			if (partialPostback)
			{
				if (Sys != null)
					Sys.Application.add_init(Revindex.Web.MaintainFocus.ApplicationInit);
			}
			else
			{
				jQuery('input,select,textarea').not('[type="hidden"]').each(function()
				{
					jQuery(this).attr("onfocus", "try{ document.getElementById('__LASTFOCUS').value = this.id } catch(e) {}");
				});
			}
		});
	}

	this.ApplicationInit = function()
	{
		if (typeof (window.addEventListener) !== "undefined")
		{
			window.addEventListener("focus", Revindex.Web.MaintainFocus.FocusHandler, true);
		}

		Sys.WebForms.PageRequestManager.getInstance().add_pageLoading(Revindex.Web.MaintainFocus.PageLoadingHandler);
		Sys.WebForms.PageRequestManager.getInstance().add_pageLoaded(Revindex.Web.MaintainFocus.PageLoadedHandler);
	}

	this.FocusHandler = function(e)
	{
		document.activeElement = e.originalTarget;
	}

	this.PageLoadingHandler = function(sender, args)
	{
		Revindex.Web.MaintainFocus.lastFocusedControlId = typeof (document.activeElement) === "undefined" ? "" : document.activeElement.id;
	}

	this.PageLoadedHandler = function(sender, args)
	{
		if (typeof (Revindex.Web.MaintainFocus.lastFocusedControlId) !== "undefined" && Revindex.Web.MaintainFocus.lastFocusedControlId != "")
		{
			var newFocused = $get(Revindex.Web.MaintainFocus.lastFocusedControlId);
			if (newFocused)
			{
				Revindex.Web.MaintainFocus.FocusControl(newFocused);
			}
		}
	}

	this.FocusControl = function(targetControl)
	{
		if (Sys.Browser.agent === Sys.Browser.InternetExplorer)
		{
			var focusTarget = targetControl;
			if (focusTarget && (typeof (focusTarget.contentEditable) !== "undefined"))
			{
				oldContentEditableSetting = focusTarget.contentEditable;
				focusTarget.contentEditable = false;
			}
			else
			{
				focusTarget = null;
			}
			targetControl.focus();
			if (focusTarget)
			{
				focusTarget.contentEditable = oldContentEditableSetting;
			}
		}
		else
		{
			targetControl.focus();
		}
	}
}




// 
// The following object creates a modal popup
// 
Revindex.Web.Modal = new function ()
{
    this.Show = function (url, width, height, onCloseCallback)
    {
        // Use dnnModal if exist, otherwise use jQuery UI modal.
        // Both modal are hardcoded to the "iPopUp" id/name.
        // See DNN source js\Debug\dnn.modalpopup.js for reference.
        // We cannot use dnnModal for IE because dnnModal doesn't create the iframe with a name attribute
        // and we can't set it dynamically in IE.
        // http://mudge.name/2012/01/29/naming-dynamically-created-iframes.html
        // http://stackoverflow.com/questions/2181385/ie-issue-submitting-form-to-an-iframe-using-javascript
        if (typeof dnnModal != 'undefined' && navigator.appName != "Microsoft Internet Explorer")
        {
            dnnModal.show(url, false, height, width, false);

            // The iframe created by dnnModal is missing the name attribute
            // and will not post correctly in Firefox and IE. We need to explicitly
            // set the name attribute to the iframe object.
            jQuery('#iPopUp').attr('name', 'iPopUp');
        }
        else
        {
            if (jQuery('#iPopUp').length == 0)
                jQuery("<div id='iPopUp' style='overflow:hidden'><iframe name='iPopUp' style='width:100%;height:100%' /></div>").appendTo('body');

            jQuery('#iPopUp').dialog({ closeOnEscape: true, dialogClass: 'dnnFormPopup', height: height, maxWidth: 1920, modal: true, position: 'center', resizable: true, width: width });
        }

        // Attach on close function callback
        jQuery('#iPopUp').on('dialogclose', onCloseCallback);
    }

    this.Close = function ()
    {
        jQuery('#iPopUp').dialog('close');
    }
}

//
// Parse query string into hash array.
//
Revindex.Web.ParseQueryString = function(str)
{
	var params = {},
            e,
            a = /\+/g,  // Regex for replacing addition symbol with a space
            r = /([^&=]+)=?([^&]*)/g,
            d = function(s) { return decodeURIComponent(s.replace(a, " ")); };

	while (e = r.exec(str))
		params[d(e[1])] = d(e[2]);

	return params;
}

//
// Print container
//
Revindex.Web.Print = function (jElement)
{
    var printContent = $(jElement).clone();
    $('body').empty().html(printContent);
    window.print();
    location.reload();
}

Revindex.Web.ResolveUrl = function(url)
{
	if (url.indexOf("~/") == 0)
		url = Revindex.Web.BaseUrl + url.substring(2);

	return url;
}

// Lock object from page scroll
Revindex.Web.ScrollLock = function (jObj, jContainer)
{
    var objTop = jObj.offset().top;

    SetObjectPosition();
    jQuery(window).scroll(function ()
    {
        SetObjectPosition();
    });

    function SetObjectPosition()
    {
        var objRelativeTop = objTop - jQuery(window).scrollTop();
        if (objRelativeTop < 0)
        {
            var move = -1 * objRelativeTop;
            if (move + jObj.height() < jContainer.height())
            {
                jObj.css("top", move);
                jObj.css("margin-bottom", -1 * move);
            }
        }
        else
        {
            jObj.css("top", 0);
            jObj.css("margin-bottom", 0);
        }
    }
}

Revindex.Web.FormTracker = new function ()
{
    var formDataChanged = false;

    this.ConfirmUnsavedChanges = function (containerSelector, msg, excludeSaveSelector)
    {
        // Track input changes
        $(containerSelector).on('change', 'select', function ()
        {
            formDataChanged = true;
        });

        $(containerSelector).on('change keypress keyup', 'input', function ()
        {
            formDataChanged = true;
        });

        $(containerSelector).on('change keypress keyup', 'textarea', function ()
        {
            formDataChanged = true;
        });

        // Monitor page navigation
        window.onbeforeunload = function ()
        {
            // We need to ignore ASP.NET postback
            // since a postback is usually indication of a save or a 
            // control performing a server-side event. We can determine a
            // postback if the __EVENTTARGET element changes right before the form is
            // submitted.
            var isAspNetPostBack = false;
            if ($("#__EVENTTARGET").val() != "")
                isAspNetPostBack = true;

            if (formDataChanged && !isAspNetPostBack)
                return msg;
        }

        // Exclude save button navigation from triggering confirmation
        $(containerSelector).on('click', excludeSaveSelector, function ()
        {
            formDataChanged = false;
        });

        // Exclude form post
        $("form").submit(function ()
        {
            formDataChanged = false;
        });
    }
}

// This function is a suitable replacement for jQuery.parseXML()
// and returns a more verbose exception.
Revindex.Xml.ParseXml = function (data) {
    var xml, tmp;
    if (!data || typeof data !== "string")
        return null;

    // IE
    if (typeof window.ActiveXObject != "undefined" && new window.ActiveXObject("Microsoft.XMLDOM")) {
        xml = new ActiveXObject("Microsoft.XMLDOM");
        xml.async = "false";
        xml.loadXML(data);

        if (xml.parseError.errorCode != 0) {
            throw new Error(xml.parseError.reason + " near line " + xml.parseError.line);
            xml = undefined;
        }
    }
        // Chrome, Mozilla, Firefox, Opera, etc.
    else if (window.DOMParser) {
        tmp = new DOMParser();
        xml = tmp.parseFromString(data, "text/xml");

        if (xml.getElementsByTagName("parsererror").length > 0) {
            throw new Error(xml.documentElement.childNodes[0].nodeValue);
            xml = undefined;
        }
    }

    if (!xml || !xml.documentElement || xml.getElementsByTagName("parsererror").length) {
        throw new Error("Invalid XML: " + data);
    }

    return xml;
}
