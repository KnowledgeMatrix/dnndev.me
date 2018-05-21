<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="View.ascx.cs" Inherits="DotNetNuke.Enterprise.MarketoForms.View" %>
<% if (!string.IsNullOrEmpty(MarketoId)) { %>
<script src='<%= MarketoURL %>/js/forms2/js/forms2.js'></script>
<script>
    $(document).ready(function () {
    	MktoForms2.loadForm("<%= MarketoURL %>", "<%= MarketoCode %>", <%= MarketoId %>, function (form) {
			if (form === null) {
				return;
			}

            MktoForms2.$("#formPlaceholder_<%= MarketoId %>").append(form.getFormElem());

            var overrideOnSuccess = "<%= OverrideOnSuccess %>";
            
            switch(overrideOnSuccess) {
                case "redirect":
                    var redirectURL = "<%= RedirectURL %>";
                    
                    form.onSuccess(function(values, followUpUrl){
                        //Take the lead to a different page on successful submit, ignoring the form's configured followUpUrl.
                        location.href = redirectURL;
                        //return false to prevent the submission handler continuing with its own processing
                        return false;
                    });
                    
                    break;
                case "message":
                    var customMessage = "<%= CustomMessage %>";
                    
                    form.onSuccess(function(values, followUpUrl){
                        //get the form's jQuery element and clear it.
                        $("#formPlaceholder_<%= MarketoId %>").empty();
                        //set the custom message.
                        $("#formPlaceholder_<%= MarketoId %>").html(customMessage);
                        //return false to prevent the submission handler from taking the lead to the follow up url.
                        return false;
                    });
                    
                    break;
                default :
                    
            }
        });
    });
</script>
<%= HeaderMarkup %>
<div id="formPlaceholder_<%= MarketoId %>"></div>
<%= FooterMarkup %>
<% } %>