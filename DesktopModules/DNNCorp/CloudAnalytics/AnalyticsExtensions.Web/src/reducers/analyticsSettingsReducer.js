import ActionTypes from "../constants/actionTypes/analyticsSettings";
export default function analyticsSettings(state = {
    onSavePayload: {
        enabled: false
    },
    disabled: false,
    formDirty: false
}, action) {
    switch (action.type) {
        case ActionTypes.RETRIEVED_ENABLED_STATUS:
            return { ...state,
                onSavePayload: {
                    enabled: action.payload
                },
                disabled: action.payload
            };
        case ActionTypes.UPDATE_ENABLED_STATUS:
            return { ...state,
                onSavePayload: {
                    enabled: action.payload
                },
                disabled: false,
                formDirty: true
            };
        case ActionTypes.SAVED_ENABLED_STATUS:
            return { ...state,
                onSavePayload: { enabled: true },
                disabled: true,
                formDirty: false
            };
        default:
            return state;
    }
}
