import util from "../utils";
function serializeQueryStringParameters(obj) {
    let s = [];
    for (let p in obj) {
        if (obj.hasOwnProperty(p)) {
            s.push(encodeURIComponent(p) + "=" + encodeURIComponent(obj[p]));
        }
    }
    return s.join("&");
}
class ApplicationService {
    getServiceFramework(controller) {
        let sf = util.sf;

        sf.moduleRoot = "PersonaBar";
        sf.controller = controller;

        return sf;
    }

    getEnabledStatus(callback, errorCallback) {
        const sf = this.getServiceFramework("Analytics");
        sf.get("GetEnabledStatus", {}, callback, errorCallback);
    }

    enable(callback, errorCallback){
        const sf = this.getServiceFramework("Analytics");
        sf.post("Enable", {}, callback, errorCallback);
    }
}
const applicationService = new ApplicationService();
export default applicationService;