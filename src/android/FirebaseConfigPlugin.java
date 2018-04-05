package by.chemerisuk.cordova.firebase;

import java.util.Collections;

import android.app.Activity;
import android.content.Context;
import android.util.Log;

import com.google.android.gms.tasks.OnCompleteListener;
import com.google.android.gms.tasks.Task;
import com.google.firebase.remoteconfig.FirebaseRemoteConfig;
import com.google.firebase.remoteconfig.FirebaseRemoteConfigSettings;

import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.CallbackContext;

import org.json.JSONArray;
import org.json.JSONException;


public class FirebaseConfigPlugin extends CordovaPlugin {
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

    @Override
    public boolean execute(String action, JSONArray args, CallbackContext callbackContext) throws JSONException {
        if ("update".equals(action)) {
            update(args.getLong(0), callbackContext);
        } else if ("getBoolean".equals(action)) {
            getBoolean(args.getString(0), args.getString(1), callbackContext);
        } else if ("getBytes".equals(action)) {
            getBytes(args.getString(0), args.getString(1), callbackContext);
        } else if ("getNumber".equals(action)) {
            getNumber(args.getString(0), args.getString(1), callbackContext);
        } else if ("getString".equals(action)) {
            getString(args.getString(0), args.getString(1), callbackContext);
        } else {
            return false;
        }

        return true;
    }

    private void update(final long ttlSeconds, final CallbackContext callbackContext) {
        if (ttlSeconds == 0) {
            // App should use developer mode to fetch values from the service
            firebaseRemoteConfig.setConfigSettings(
                new FirebaseRemoteConfigSettings.Builder()
                    .setDeveloperModeEnabled(true)
                    .build()
            );
        }

        firebaseRemoteConfig.fetch(ttlSeconds)
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

    private void getBoolean(final String key, final String namespace, final CallbackContext callbackContext) {
        cordova.getThreadPool().execute(new Runnable() {
            public void run() {
                if (namespace.isEmpty()) {
                    callbackContext.success(firebaseRemoteConfig.getBoolean(key) ? 1 : 0);
                } else {
                    callbackContext.success(firebaseRemoteConfig.getBoolean(key, namespace) ? 1 : 0);
                }
            }
        });
    }

    private void getBytes(final String key, final String namespace, final CallbackContext callbackContext) {
        cordova.getThreadPool().execute(new Runnable() {
            public void run() {
                if (namespace.isEmpty()) {
                    callbackContext.success(firebaseRemoteConfig.getByteArray(key));
                } else {
                    callbackContext.success(firebaseRemoteConfig.getByteArray(key, namespace));
                }
            }
        });
    }

    private void getNumber(final String key, final String namespace, final CallbackContext callbackContext) {
        cordova.getThreadPool().execute(new Runnable() {
            public void run() {
                double value;

                if (namespace.isEmpty()) {
                    value = firebaseRemoteConfig.getDouble(key);
                } else {
                    value = firebaseRemoteConfig.getDouble(key, namespace);
                }

                callbackContext.sendPluginResult(
                    new PluginResult(PluginResult.Status.OK, (float)value));
            }
        });
    }

    private void getString(final String key, final String namespace, final CallbackContext callbackContext) {
        cordova.getThreadPool().execute(new Runnable() {
            public void run() {
                if (namespace.isEmpty()) {
                    callbackContext.success(firebaseRemoteConfig.getString(key));
                } else {
                    callbackContext.success(firebaseRemoteConfig.getString(key, namespace));
                }
            }
        });
    }
}
