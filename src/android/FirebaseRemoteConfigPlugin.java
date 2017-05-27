package by.chemerisuk.cordova.firebase;

import com.google.android.gms.tasks.OnCompleteListener;
import com.google.android.gms.tasks.Task;
import com.google.firebase.remoteconfig.FirebaseRemoteConfig;

import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.CallbackContext;

import org.json.JSONArray;
import org.json.JSONException;


public class FirebaseRemoteConfigPlugin extends CordovaPlugin {
    private static final String TAG = "FirebaseRemoteConfigPlugin";

    private FirebaseRemoteConfig firebaseRemoteConfig;

    @Override
    protected void pluginInitialize() {
        Log.d(TAG, "Starting Firebase Remote Config plugin");

        Context context = this.cordova.getActivity().getApplicationContext();

        this.firebaseRemoteConfig = FirebaseRemoteConfig.getInstance(context);
    }

    @Override
    public boolean execute(String action, JSONArray args, CallbackContext callbackContext) throws JSONException {
        if ("fetch".equals(action)) {
            fetch(args.getLong(0), callbackContext);
        } else if ("getBoolean".equals(action)) {
            getBoolean(args.getString(0), args.getString(1));
        } else if ("getByteArray".equals(action)) {
            getByteArray(args.getString(0), args.getString(1));
        } else if ("getDouble".equals(action)) {
            getDouble(args.getString(0), args.getString(1));
        } else if ("getLong".equals(action)) {
            getLong(args.getString(0), args.getString(1));
        } else if ("getString".equals(action)) {
            getString(args.getString(0), args.getString(1));
        } else {
            return false;
        }

        return true;
    }

    private void fetch(long cacheExpiration, final CallbackContext callbackContext) throws JSONException {
        Activity activity = this.cordova.getActivity();

        firebaseRemoteConfig.fetch(cacheExpiration);
            .addOnCompleteListener(activity, new OnCompleteListener<Void>() {
                @Override
                public void onComplete(@NonNull Task<Void> task) {
                    if (task.isSuccessful()) {
                        firebaseRemoteConfig.activateFetched();

                        callbackContext.success();
                    } else {
                        callbackContext.error(task.getException());
                    }
                }
            });
    }

    private void getBoolean(String key, String namespace, CallbackContext callbackContext) {
        if (namespace.isEmpty()) {
            callbackContext.success(firebaseRemoteConfig.getBoolean(key))
        } else {
            callbackContext.success(firebaseRemoteConfig.getBoolean(key, namespace));
        }
    }

    private void getByteArray(String key, String namespace, CallbackContext callbackContext) {
        if (namespace.isEmpty()) {
            callbackContext.success(firebaseRemoteConfig.getByteArray(key))
        } else {
            callbackContext.success(firebaseRemoteConfig.getByteArray(key, namespace));
        }
    }

    private void getDouble(String key, String namespace, CallbackContext callbackContext) {
        if (namespace.isEmpty()) {
            callbackContext.success(firebaseRemoteConfig.getDouble(key))
        } else {
            callbackContext.success(firebaseRemoteConfig.getDouble(key, namespace));
        }
    }

    private void getLong(String key, String namespace, CallbackContext callbackContext) {
        if (namespace.isEmpty()) {
            callbackContext.success(firebaseRemoteConfig.getLong(key))
        } else {
            callbackContext.success(firebaseRemoteConfig.getLong(key, namespace));
        }
    }

    private void getString(String key, String namespace, CallbackContext callbackContext) {
        if (namespace.isEmpty()) {
            callbackContext.success(firebaseRemoteConfig.getString(key))
        } else {
            callbackContext.success(firebaseRemoteConfig.getString(key, namespace));
        }
    }
}
