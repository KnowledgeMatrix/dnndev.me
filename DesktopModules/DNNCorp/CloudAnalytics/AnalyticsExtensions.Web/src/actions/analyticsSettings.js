import ActionTypes from "constants/actionTypes/analyticsSettings";
import Service from "services/analyticsSettingsService";
import resx from "resources";
import utils from "utils";

function _errorCallback(xhr) {
    let response = eval('(' + xhr.responseText + ')');
    let message = xhr.responseText;
    if (response && response.Message) {
        message = response.Message;
    }

    utils.notifyError(resx.get(message));
}
const analyticsSettingsActions = {
    getStatus(callback) {
        return (dispatch) => {
            Service.getEnabledStatus(data => {
                dispatch({
                    type: ActionTypes.RETRIEVED_ENABLED_STATUS,
                    payload: data.Enabled
                });
            }, _errorCallback);
        };
    },
    updateEnabled(enabled, callback) {
        return (dispatch) => {
            dispatch({
                type: ActionTypes.UPDATE_ENABLED_STATUS,
                payload: enabled
            });
        };
    },
    enable(onSavePayload, callback, errorCallback) {
        return (dispatch) => {
            if (onSavePayload.enabled && onSavePayload.formDirty) {
                Service.enable(data => {
                    dispatch({
                        type: ActionTypes.SAVED_ENABLED_STATUS
                    });
                    if (callback) {
                        callback(data);
                    }
                }, errorCallback);
            }
        };
    }
};

export default analyticsSettingsActions;
