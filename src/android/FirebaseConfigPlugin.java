package by.chemerisuk.cordova.firebase;

import java.util.Collections;

import android.app.Activity;
import android.content.Context;
import android.util.Log;

import by.chemerisuk.cordova.support.CordovaMethod;
import by.chemerisuk.cordova.support.ReflectiveCordovaPlugin;

import com.google.android.gms.tasks.OnCompleteListener;
import com.google.android.gms.tasks.Task;
import com.google.firebase.remoteconfig.FirebaseRemoteConfig;
import com.google.firebase.remoteconfig.FirebaseRemoteConfigSettings;
import com.google.firebase.remoteconfig.FirebaseRemoteConfigValue;

import org.apache.cordova.CallbackContext;
import org.apache.cordova.PluginResult;
import org.json.JSONArray;
import org.json.JSONException;


public class FirebaseConfigPlugin extends ReflectiveCordovaPlugin {
    private static final String TAG = "FirebaseRemoteConfigPlugin";

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
    protected void update(long ttlSeconds, final CallbackContext callbackContext) {
        if (ttlSeconds == 0) {
            // App should use developer mode to fetch values from the service
            this.firebaseRemoteConfig.setConfigSettings(
                new FirebaseRemoteConfigSettings.Builder()
                    .setDeveloperModeEnabled(true)
                    .build()
            );
        }

        this.firebaseRemoteConfig.fetch(ttlSeconds)
            .addOnCompleteListener(cordova.getActivity(), new OnCompleteListener<Void>() {
                @Override
                public void onComplete(Task<Void> task) {
                    if (task.isSuccessful()) {
                        firebaseRemoteConfig.activateFetched();

                        callbackContext.success();
                    } else {
                        callbackContext.error(task.getException().getMessage());
                    }
                }
            });
    }

    @CordovaMethod
    protected void getBoolean(String key, String namespace, CallbackContext callbackContext) {
        boolean value = getValue(key, namespace).asBoolean();

        callbackContext.sendPluginResult(
            new PluginResult(PluginResult.Status.OK, value));
    }

    @CordovaMethod
    protected void getBytes(String key, String namespace, CallbackContext callbackContext) {
        callbackContext.success(getValue(key, namespace).asByteArray());
    }

    @CordovaMethod
    protected void getNumber(String key, String namespace, CallbackContext callbackContext) {
        double value = getValue(key, namespace).asDouble();

        callbackContext.sendPluginResult(
            new PluginResult(PluginResult.Status.OK, (float)value));
    }

    @CordovaMethod
    protected void getString(String key, String namespace, CallbackContext callbackContext) {
        callbackContext.success(getValue(key, namespace).asString());
    }

    private FirebaseRemoteConfigValue getValue(String key, String namespace) {
        if (namespace.isEmpty()) {
            return this.firebaseRemoteConfig.getValue(key);
        } else {
            return this.firebaseRemoteConfig.getValue(key, namespace);
        }
    }
}
