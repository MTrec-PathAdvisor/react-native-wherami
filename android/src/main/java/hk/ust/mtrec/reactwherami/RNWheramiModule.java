package hk.ust.mtrec.reactwherami;

import android.content.pm.PackageManager;
import android.os.Build;

import org.jetbrains.annotations.Nullable;

import android.util.Log;

import com.facebook.react.bridge.Arguments;

import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.WritableArray;
import com.facebook.react.bridge.WritableMap;
import com.facebook.react.modules.core.DeviceEventManagerModule;

import java.io.StreamCorruptedException;
import java.net.URISyntaxException;

import wherami.lbs.sdk.Client;
import wherami.lbs.sdk.core.MapEngine;
import wherami.lbs.sdk.core.MapEngineFactory;
import wherami.lbs.sdk.data.Location;

public class RNWheramiModule extends ReactContextBaseJavaModule implements MapEngine.LocationUpdateCallback {

    private final ReactContext reactContext;
    private static final String TAG = RNWheramiModule.class.getSimpleName();
    private static final String NAME = "Wherami";
    private MapEngine mapEngine;

    public RNWheramiModule(ReactApplicationContext reactContext) {
        super(reactContext);
        this.reactContext = reactContext;
    }

    @Override
    public String getName() {
        return NAME;
    }


    @ReactMethod
    private void checkSelfPermission() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            String[] permissions = null;
            try {
                permissions = reactContext.getPackageManager().getPackageInfo(reactContext.getPackageName(), PackageManager.GET_PERMISSIONS).requestedPermissions;
            } catch (PackageManager.NameNotFoundException e) {
                WritableMap params = Arguments.createMap();
                params.putString("message", e.getMessage());
                sendEvent(reactContext, "message", params);
            }

            Log.d(TAG, permissions.toString());

            WritableArray missingPermissions = Arguments.createArray();
            if (permissions != null) {
                for (String permission : permissions) {
                    if (reactContext.checkSelfPermission(permission) == PackageManager.PERMISSION_DENIED) {
                        missingPermissions.pushString(permission);
                    }
                }
                if (missingPermissions.size() != 0) {
                    WritableMap params = Arguments.createMap();
                    params.putArray("missingPermissions", missingPermissions);
                    sendEvent(reactContext, "requestPermission", params);
                } else {
                    WritableMap params = Arguments.createMap();
                    params.putString("message", "All permissions granted, starting Wherami initialization.");
                    sendEvent(reactContext, "message", params);
                    initializeSDK();
                }
            }

        } else {
            WritableMap params = Arguments.createMap();
            params.putString("message", "SDKversion < M, starting Wherami initialization.");
            sendEvent(reactContext, "message", params);
            initializeSDK();
        }
    }

    @ReactMethod
    private void initializeSDK() {
        try {
            Client.Configure("https://dy199-079.ust.hk",
                    "HKUST_v2", reactContext
            );
        } catch (URISyntaxException e) {
            WritableMap params = Arguments.createMap();
            params.putString("message", e.getMessage());
            sendEvent(reactContext, "message", params);
        } catch (StreamCorruptedException e) {
            WritableMap params = Arguments.createMap();
            params.putString("message", e.getMessage());
            sendEvent(reactContext, "message", params);
        }

        Client.UpdateData(new Client.DataUpdateCallback() {
            @Override
            public void onProgressUpdated(int i) {
                WritableMap params = Arguments.createMap();
                params.putString("message", "updating: " + i + "%");
                sendEvent(reactContext, "message", params);
            }

            @Override
            public void onCompleted() {
                sendEvent(reactContext, "onReady", null);
            }

            @Override
            public void onFailed(Exception e) {
                WritableMap params = Arguments.createMap();
                params.putString("message", e.getMessage());
                sendEvent(reactContext, "message", params);
            }
        }, reactContext);
    }

    @ReactMethod
    private void start() {
        if (mapEngine == null) {
            mapEngine = MapEngineFactory.Create(reactContext);
            try {
                mapEngine.initialize();
            } catch (StreamCorruptedException e) {
                e.printStackTrace();
            }
            mapEngine.attachEngineStatusCallback(new EngineStatusListener());
            mapEngine.attachLocationUpdateCallback(this);
        }
        mapEngine.start();
    }

    @ReactMethod
    private void stop() {
        if (mapEngine != null) {
            mapEngine.stop();
        }
    }

    class EngineStatusListener implements MapEngine.EngineStatusCallback {
        @Override
        public void onEngineStarted() {
            sendEvent(reactContext, "onEngineStarted", null);
        }

        @Override
        public void onEngineStopped() {
            sendEvent(reactContext, "onEngineStopped", null);
        }
    }

    private void sendEvent(ReactContext reactContext,
                           String eventName,
                           @Nullable WritableMap params) {
        reactContext.
                getJSModule(DeviceEventManagerModule.RCTDeviceEventEmitter.class)
                .emit(eventName, params);
    }

    @Override
    public void onLocationUpdated(Location location) {
        WritableMap params = Arguments.createMap();
        if (location != null) {
            WritableMap locationMap = null;
            locationMap = Arguments.createMap();
            locationMap.putDouble("x", location.x);
            locationMap.putDouble("y", location.y);
            locationMap.putString("areaId", location.areaId);
            locationMap.putDouble("radius", location.radius);
            params.putMap("location", locationMap);
            sendEvent(reactContext, "onLocationUpdate", params);

        } else {

            params.putMap("location", null);
            sendEvent(reactContext, "onLocationUpdate", params);
        }
    }
}
