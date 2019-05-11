package by.chemerisuk.cordova.firebase;

import java.util.Collections;

import android.content.Context;
import android.util.Log;

import by.chemerisuk.cordova.support.CordovaMethod;
import by.chemerisuk.cordova.support.ReflectiveCordovaPlugin;

import com.google.android.gms.tasks.OnCompleteListener;
import com.google.android.gms.tasks.Task;
import com.google.firebase.remoteconfig.FirebaseRemoteConfig;
import com.google.firebase.remoteconfig.FirebaseRemoteConfigValue;

import org.apache.cordova.CallbackContext;
import org.apache.cordova.PluginResult;


public class FirebaseConfigPlugin extends ReflectiveCordovaPlugin {
    private static final String TAG = "FirebaseConfigPlugin";

    private FirebaseRemoteConfig firebaseRemoteConfig;

    @Override
    protected void pluginInitialize() {
        Log.d(TAG, "Starting Firebase Remote Config plugin");

        this.firebaseRemoteConfig = FirebaseRemoteConfig.getInstance();

        String filename = preferences.getString("FirebaseRemoteConfigDefaults", "");
        if (filename.isEmpty()) {
            // always call setDefaults in order to avoid exception
            // https://github.com/firebase/quickstart-android/issues/291
            this.firebaseRemoteConfig.setDefaults(Collections.<String, Object>emptyMap());
        } else {
            Context ctx = cordova.getActivity().getApplicationContext();
            int resourceId = ctx.getResources().getIdentifier(filename, "xml", ctx.getPackageName());
            this.firebaseRemoteConfig.setDefaults(resourceId);
        }
    }

    @CordovaMethod
    protected void fetch(long expirationDuration, final CallbackContext callbackContext) {
        this.firebaseRemoteConfig.fetch(expirationDuration)
                .addOnCompleteListener(cordova.getActivity(), new OnCompleteListener<Void>() {
                    @Override
                    public void onComplete(Task<Void> task) {
                        if (task.isSuccessful()) {
                            callbackContext.success();
                        } else {
                            callbackContext.error(task.getException().getMessage());
                        }
                    }
                });
    }

    @CordovaMethod
    protected void activate(final CallbackContext callbackContext) {
        this.firebaseRemoteConfig.activate()
                .addOnCompleteListener(cordova.getActivity(), new OnCompleteListener<Boolean>() {
                    @Override
                    public void onComplete(Task<Boolean> task) {
                        if (task.isSuccessful()) {
                            callbackContext.sendPluginResult(
                                    new PluginResult(PluginResult.Status.OK, task.getResult()));
                        } else {
                            callbackContext.error(task.getException().getMessage());
                        }
                    }
                });
    }

    @CordovaMethod
    protected void fetchAndActivate(final CallbackContext callbackContext) {
        this.firebaseRemoteConfig.fetchAndActivate()
                .addOnCompleteListener(cordova.getActivity(), new OnCompleteListener<Boolean>() {
                    @Override
                    public void onComplete(Task<Boolean> task) {
                        if (task.isSuccessful()) {
                            callbackContext.sendPluginResult(
                                    new PluginResult(PluginResult.Status.OK, task.getResult()));
                        } else {
                            callbackContext.error(task.getException().getMessage());
                        }
                    }
                });
    }

    @CordovaMethod
    protected void getBoolean(String key, CallbackContext callbackContext) {
        callbackContext.sendPluginResult(
                new PluginResult(PluginResult.Status.OK, getValue(key).asBoolean()));
    }

    @CordovaMethod
    protected void getBytes(String key, CallbackContext callbackContext) {
        callbackContext.success(getValue(key).asByteArray());
    }

    @CordovaMethod
    protected void getNumber(String key, CallbackContext callbackContext) {
        callbackContext.sendPluginResult(
                new PluginResult(PluginResult.Status.OK, (float)getValue(key).asDouble()));
    }

    @CordovaMethod
    protected void getString(String key, CallbackContext callbackContext) {
        callbackContext.success(getValue(key).asString());
    }

    private FirebaseRemoteConfigValue getValue(String key) {
        return this.firebaseRemoteConfig.getValue(key);
    }
}
