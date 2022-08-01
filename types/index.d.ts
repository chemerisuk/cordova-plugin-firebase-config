interface CordovaPlugins {
    firebase: FirebasePlugins;
}

interface FirebasePlugins {
    config: typeof import("./FirebaseConfig");
}
