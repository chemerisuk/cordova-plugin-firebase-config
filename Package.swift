// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "cordova-plugin-firebase-config",
    platforms: [.iOS(.v15)],
    products: [
        .library(name: "cordova-plugin-firebase-config", targets: ["FirebaseConfigPlugin"])
    ],
    dependencies: [
        .package(url: "https://github.com/apache/cordova-ios.git", branch: "master"),
        .package(url: "https://github.com/firebase/firebase-ios-sdk.git", exact: "$IOS_FIREBASE_SDK_VERSION")
    ],
    targets: [
        .target(
            name: "FirebaseConfigPlugin",
            dependencies: [
                .product(name: "Cordova", package: "cordova-ios"),
                .product(name: "FirebaseRemoteConfig", package: "firebase-ios-sdk")
            ],
            path: "src/ios",
            resources: [],
            publicHeadersPath: "."
        )
    ]
)
