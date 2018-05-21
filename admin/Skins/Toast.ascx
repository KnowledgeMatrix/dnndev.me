<%@ Control Language="C#" AutoEventWireup="false" Inherits="DotNetNuke.UI.Skins.Controls.Toast" CodeFile="Toast.ascx.cs" %>
<script type="text/javascript">
    $(document).ready(function () {

        if (typeof dnn == 'undefined') dnn = {};
        if (typeof dnn.social == 'undefined') dnn.social = {};
        var sf = $.ServicesFramework();

        dnn.social.refreshUser = function () {
            $.ajax({
                type: "GET",
                url: sf.getServiceRoot('Mechanics') + 'UserSocial/' + 'GetUserSocial',
                contentType: "application/json",
                dataType: "json",
                success: function (data) {
                    if (!data || !data.Success) {
                        if (typeof dnn.social.toastTimer !== 'undefined') {
                            // Cancel the periodic update.
                            clearTimeout(dnn.social.toastTimer);
                            delete dnn.social.toastTimer;
                        }
                        return;
                    }
					
					var event = {
						event: 'Refresh',
						notifications: data.UserSocialView.Notifications || 0,
						points: data.UserSocialView.ReputationPoints || 0,
						messages: data.UserSocialView.Messages || 0
					};
					
					updateProfileStats(event);
					
                    if (typeof dnn !== 'undefined' &&
                        typeof dnn.social !== 'undefined' &&
                        typeof dnn.social.ipc !== 'undefined') {

                        dnn.social.ipc.post({}, 'DNNCorp/MyStatus', event);
                    }

                    var toastMessages = [];

                    for (var i = 0; i < data.UserSocialView.Toasts.length; i++) {
                        var toast = {
                            subject: data.UserSocialView.Toasts[i].Subject,
                            body: data.UserSocialView.Toasts[i].Body
                        };

                        toastMessages.push(toast);
                    }

                    var message = {
                        messages: toastMessages,
                        seeMoreLink: '<%= GetNotificationLink() %>', seeMoreText: '<%= DotNetNuke.UI.Utilities.ClientAPI.GetSafeJSString(GetNotificationLabel()) %>'
                    };

                    $().dnnToastMessage('showAllToasts', message);

                    dnn.social.toastTimer = setTimeout(dnn.social.refreshUser, 30000);
                },
                error: function (xhr, status, error) {
                    if (typeof dnn.social.toastTimer !== 'undefined') {
                        // Cancel the periodic update.
                        clearTimeout(dnn.social.toastTimer);
                        delete dnn.social.toastTimer;
                    }
                }
            });
        };

        function checkLogin() {
            return '<%= IsOnline() %>' === 'True';
        };

        // initial setup for toast
        if (checkLogin()) {
            dnn.social.toastTimer = setTimeout(dnn.social.refreshUser, 1000);
        }
        
        function updateProfileStats(stats) {
			if ($('#dnn_userLogin_messageCount').length > 0) {
				if (stats.messages != '0') {
					$('#dnn_userLogin_messageCount')[0].innerText = stats.messages;
					$('#dnn_userLogin_messageCount').show();
				}
				else {
					$('#dnn_userLogin_messageCount').hide();
				}
			}
			if ($('#dnn_userLogin_notificationCount').length > 0) {
				if (stats.notifications != '0') {
					$('#dnn_userLogin_notificationCount')[0].innerText = stats.notifications;
					$('#dnn_userLogin_notificationCount').show();
				} 
				else {
					$('#dnn_userLogin_notificationCount').hide();
				}
			}
        }
    });

</script>