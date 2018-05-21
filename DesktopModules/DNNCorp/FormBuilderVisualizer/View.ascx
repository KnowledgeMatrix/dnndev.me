<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="View.ascx.cs" Inherits="Evoq.FormBuilder.Visualizer.View" EnableViewState="false" %>

<div id='<%= "FormBuilder-Canvas-" + ModuleId %>' data-formtemplateid='<%= FormTemplateId %>' class="form-builder-canvas <%= FormStyle %>"></div>

<script>


    $(document).ready(function() {

        var serviceName = "FormBuilderVisualizer";
        var $pane = $("#FormBuilder-Canvas-" + <%= ModuleId %>);

        function reApplySettings() {
            var sf = $.dnnSF(<%= ModuleId %>);

            var serviceRoot = sf.getServiceRoot(serviceName);
            var serviceUrl = serviceRoot + "Settings/SetNoFile";

            $.ajax({
                    url: serviceUrl,
                    type: "POST",
                    beforeSend: sf.setModuleHeaders,
                }).success(function onSuccess(data) {
                    window.location.reload();
                })
                .error(function onError(err) {
                });
        }

        function postFormResponse(_data, sendEmail, callback, failedCallback) {
            var sf = $.dnnSF(<%= ModuleId %>);

            var serviceRoot = sf.getServiceRoot(serviceName);
            var serviceUrl = serviceRoot + "Canvas/SubmitFormResponse?sendEmail=" + (sendEmail || false);

            $.ajax({
                    url: serviceUrl,
                    type: "POST",
                    contentType: "application/json",
                    dataType: "json",
                    beforeSend: function(xhr, settings) {
                        sf.setModuleHeaders(xhr, settings);
                        xhr.setRequestHeader("formReferral", document.referrer);
                    },
                    data: JSON.stringify(_data)
                })
                .success(function(response) {
                    if (typeof callback === "function")
                        callback(response);
                })
                .error(function onError(err) {
                    if (typeof failedCallback === "function") {
                        failedCallback(err);
                    }
                });
        }

        function init() {
            window.dnn.formVisualizerCanvas.init({
                reApplySettings: reApplySettings,
                postFormResponse: postFormResponse,
                apiUrl: '<%= ApiUrl %>',
                styleConfiguration: {
                    formItemClass: "dnnFormItem",
                    labelClass: "dnnLabel",
                    inputClass: "dnnFormInput",
                    textAreaClass: "dnnFormTextArea",
                    selectClass: "dnnSelect",
                    tooltipBackgroundClass: "dnnFormHelpContent",
                    tooltipLabelClass: "dnnHelpText",
                    descriptionClass: "dnnDescription",
                    inputAddOnClass: "dnnInputGroupAddOn",
                    typeAheadClass: "dnnInputTypeAhead",
                    errorClass: "dnnFormError",
                    primaryButtonClass: "dnnPrimaryAction",
                    secondaryButtonClass: "dnnSecondaryAction",
                    formStyle: '<%= FormStyle %>'
                }
            });
        }

        init();

        if (window.dnn && window.dnn.renderFormBuilderCanvas) {
            window.dnn.renderFormBuilderCanvas($pane.get(0));
        }

    });
</script>
