//
// Requires Revindex/Global.js
//

var Revindex = Revindex || {};
Revindex.Dnn = Revindex.Dnn || {};
Revindex.Dnn.RevindexStorefront = Revindex.Dnn.RevindexStorefront || {};

// This class is to used to manage the product filter selection on
// the client side and can serialize/deserialize for URL transport.
Revindex.Dnn.RevindexStorefront.ProductFilter = new function()
{
	this.List = {};
	this.ProductFilterQueryStringName = "";
	this.PageViewNumberQueryStringName = "";

	// Append unique value to list
	this.AddValue = function(key, val)
	{
		if (this.List[key] == undefined)
		{
			this.List[key] = {};
			this.List[key][val] = 1;
		}
		else
		{
			if (this.List[key][val] == undefined)
				this.List[key][val] = 1;
		}
	}

	// Remove value from list
	this.RemoveValue = function(key, val)
	{
		if (this.List[key] != undefined && this.List[key][val] != undefined)
		{
			delete this.List[key][val];

			// Remove list item together if no more values stored
			var length = 0;
			for (var k in this.List[key])
				length++;

			if (length == 0)
				delete this.List[key]
		}
	}

	// Clear key from list 
	this.ClearKey = function(key)
	{
		if (this.List[key] != undefined)
			delete this.List[key];
	}

	this.Empty = function()
	{
		this.List = {};
	}

	this.ParseString = function(str)
	{
		this.Empty();

		if (str == null && str == "")
			return;

		// String is formatted as
		// Key1=Encoded|Encoded&Key2=Encoded|Encoded
		var params = Revindex.Web.ParseQueryString(str);

		for (key in params)
		{
			if (params[key] != "")
			{
				var encodedVals = params[key].split("|");
				for (var i in encodedVals)
				{
					if (encodedVals[i] != "")
						this.AddValue(key, decodeURIComponent(encodedVals[i]));
				}
			}
		}
	}

	this.ToString = function()
	{
		// String is formatted as
		// Key1=Encoded|Encoded&Key2=Encoded|Encoded
		var str = "";
		for (var key in this.List)
		{
			if (this.List[key] != undefined)
			{
				str += "&" + key + "=";

				for (val in this.List[key])
				{
					str += encodeURIComponent(val) + "|";
				}
			}
		}
		
		return str;
	}

	this.ResetProductFilter = function()
	{
		var queryParams = Revindex.Web.GetUrlQueryParameters();

		// Strip off query
		var url = location.href;
		if (url.indexOf("?") >= 0)
			url = url.substring(0, url.indexOf("?"));

		if (queryParams[this.ProductFilterQueryStringName] != undefined)
			delete queryParams[this.ProductFilterQueryStringName];

		// Reset page view number to 1 by removing it from the path and in the querystring
		url = url.replace(new RegExp("/" + this.PageViewNumberQueryStringName + "/\\d+"), "");
		if (queryParams[this.PageViewNumberQueryStringName] != undefined)
			delete queryParams[this.PageViewNumberQueryStringName];

		for (var key in queryParams)
		{
			if (url.indexOf("?") < 0)
				url += "?" + key + "=" + encodeURIComponent(queryParams[key]);
			else
				url += "&" + key + "=" + encodeURIComponent(queryParams[key]);
		}

		// Redirect
		location.href = url;
	}

	this.OnControlChanged = function()
	{
		var queryParams = Revindex.Web.GetUrlQueryParameters();

		// Strip off query
		var url = location.href;
		if (url.indexOf("?") >= 0)
			url = url.substring(0, url.indexOf("?"));

		var filterQueryString = this.ToString();
		if (filterQueryString != "")
			queryParams[this.ProductFilterQueryStringName] = filterQueryString;
		else if (queryParams[this.ProductFilterQueryStringName] != undefined)
			delete queryParams[this.ProductFilterQueryStringName];

		// Reset page view number to 1 by removing it from the path and in the querystring
		url = url.replace(new RegExp("/" + this.PageViewNumberQueryStringName + "/\\d+"), "");
		if (queryParams[this.PageViewNumberQueryStringName] != undefined)
			delete queryParams[this.PageViewNumberQueryStringName];

		for (var key in queryParams)
		{
			if (url.indexOf("?") < 0)
				url += "?" + key + "=" + encodeURIComponent(queryParams[key]);
			else
				url += "&" + key + "=" + encodeURIComponent(queryParams[key]);
		}

		// Redirect
		location.href = url;
	}
}