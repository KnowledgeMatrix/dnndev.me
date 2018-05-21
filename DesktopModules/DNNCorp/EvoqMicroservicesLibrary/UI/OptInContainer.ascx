<%@ Control language="C#" Inherits="Evoq.Microservices.Library.UI.OptInContainer" AutoEventWireup="false" Codebehind="OptInContainer.ascx.cs" %>
<%@ Import Namespace="Newtonsoft.Json" %>

<asp:Panel runat="server" ID="OptInPanel">    
    
    <div id="opt-in-container" data-init-callback="dnnInitOptIn"></div>
    
    <script type="text/javascript">
        (function optIn() {
            var sf = $.dnnSF();
            var serviceRoot = sf.getServiceRoot("<%= ServiceName %>");
            var isEnabled = false;

            function setAlreadyShown() {
                $.ajax({                        
                    url: serviceRoot + "<%= SetAlreadyShownApiUrl %>",
                    type: "POST",
                    beforeSend: sf.setModuleHeaders
                });
            }

            function closeModal() {
                setAlreadyShown();
                $("#<%=OptInPanel.ClientID%>").remove();
                if (isEnabled) {
                    location.reload();
                }
            }

            function enableFeature(callback) {
                $.ajax({                        
                    url: serviceRoot + "<%= EnableMicroservicesApiUrl %>",
                    type: "POST",
                    beforeSend: sf.setModuleHeaders,
                    success: function() {
                        isEnabled = true;
                        callback();
                    }
                });
            }

            function initOptIn() {
                var options = {
                    mode: "host",
                    publicPath: "<%=PublicPath%>",
                    enableFeature: enableFeature,
                    closeModal: closeModal,
                    features: <%=JsonConvert.SerializeObject(Features)%>
                };
                window.dnn.optIn.init(options);
            }
            window.dnnInitOptIn = initOptIn;
        })();
    </script>
    <script type="text/javascript" src="<%=BundleUrl%>"></script>

    <style>
        html {
            overflow: hidden;
        }
    </style>
</asp:Panel>
