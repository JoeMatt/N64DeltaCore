// swift-tools-version:5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "N64DeltaCore",
    platforms: [
        .iOS(.v12),
        .macOS(.v11),
        .tvOS(.v12)
    ],
    products: [
        .library(
            name: "N64DeltaCore",
            targets: ["N64DeltaCore"]),
    ],
    dependencies: [
        //        .package(url: "https://github.com/rileytestut/DeltaCore.git", .branch("main"))
        .package(path: "../DeltaCore")
    ],
    targets: [
        .target(
            name: "N64DeltaCore",
            dependencies: ["DeltaCore", "Mupen64Plus", "N64Swift", "N64Bridge"],
            exclude: [
                "Resources/Controller Skin/info.json",
                "Resources/Controller Skin/iphone_portrait.pdf",
                "Resources/Controller Skin/iphone_landscape.pdf",
                "Resources/Controller Skin/iphone_edgetoedge_portrait.pdf",
                "Resources/Controller Skin/iphone_edgetoedge_landscape.pdf"
            ],
            resources: [
                .copy("Resources/Controller Skin/Standard.deltaskin"),
                .copy("Resources/Standard.deltamapping"),
            ]
        ),
        .target(
            name: "N64Swift",
            dependencies: ["DeltaCore"]
        ),
        .target(
            name: "N64Bridge",
            dependencies: ["DeltaCore", "Mupen64Plus", "N64Swift"],
//            publicHeadersPath: "",
            cSettings: [
//                .headerSearchPath("../Mupen64Plus/Genesis-Plus-GX/core"),
//                .define("LSB_FIRST")
            ]
        ),
//        .target(
//            name: "Video",
//            path:
//        ),
        .target(
            name: "Mupen64Plus",
            path: "Mupen64Plus",
            sources: [
               "mupen64plus-core/src/backends/api/video_capture_backend.c",
                 "mupen64plus-core/src/device/dd/dd_controller.c", 
                "mupen64plus-core/src/device/controllers/paks/biopak.c",
                 "mupen64plus-core/src/backends/dummy_video_capture.c",
            ],
            cSettings: [
//                .headerSearchPath("Genesis-Plus-GX/core"),
//                .define("LSB_FIRST")
            ]
        )
    ]
)
