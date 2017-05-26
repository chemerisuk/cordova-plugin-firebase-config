package by.chemerisuk.cordova.firebase;

import com.google.firebase.crash.FirebaseRemoteConfig;

import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.CallbackContext;

import org.json.JSONArray;
import org.json.JSONException;


public class FirebaseRemoteConfigPlugin extends CordovaPlugin {

    @Override
    public boolean execute(String action, JSONArray args, CallbackContext callbackContext) throws JSONException {
        return false;
    }
}
