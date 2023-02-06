// swift-tools-version:5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "N64DeltaCore",
    platforms: [
        .iOS(.v12)
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "N64DeltaCore",
            targets: ["N64DeltaCore"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(url: "https://github.com/rileytestut/DeltaCore.git", .branch("main"))
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "N64DeltaCore",
            dependencies: ["DeltaCore", "GenesisPlusGX", "N64Swift", "N64Bridge"],
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
            publicHeadersPath: "",
            cSettings: [
                .headerSearchPath("../GenesisPlusGX/Genesis-Plus-GX/core"),
                .headerSearchPath("../GenesisPlusGX/Genesis-Plus-GX/core/m68k"),
                .headerSearchPath("../GenesisPlusGX/Genesis-Plus-GX/core/z80"),
                .headerSearchPath("../GenesisPlusGX/Genesis-Plus-GX/core/sound"),
                .headerSearchPath("../GenesisPlusGX/Genesis-Plus-GX/core/cart_hw"),
                .headerSearchPath("../GenesisPlusGX/Genesis-Plus-GX/core/cart_hw/svp"),
                .headerSearchPath("../GenesisPlusGX/Genesis-Plus-GX/core/cd_hw"),
                .headerSearchPath("../GenesisPlusGX/Genesis-Plus-GX/core/input_hw"),
                .headerSearchPath("../GenesisPlusGX/Genesis-Plus-GX/core/ntsc"),
                
                .headerSearchPath("../GenesisPlusGX/Genesis-Plus-GX/psp2"),
                
                .define("USE_32BPP_RENDERING"),
                .define("FLAC__HAS_OGG", to: "0"),
                .define("HAVE_SYS_PARAM_H"),
                .define("HAVE_LROUND"),
                .define("PACKAGE_VERSION", to: "\"1.3.2\""),
                .define("_7ZIP_ST"),
                .define("LSB_FIRST")
            ]
        ),
        .target(
            name: "Video",
            path: 
        ),
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
                .headerSearchPath("Genesis-Plus-GX/core"),
                .headerSearchPath("Genesis-Plus-GX/core/m68k"),
                .headerSearchPath("Genesis-Plus-GX/core/z80"),
                .headerSearchPath("Genesis-Plus-GX/core/sound"),
                .headerSearchPath("Genesis-Plus-GX/core/cart_hw"),
                .headerSearchPath("Genesis-Plus-GX/core/cart_hw/svp"),
                .headerSearchPath("Genesis-Plus-GX/core/cd_hw"),
                .headerSearchPath("Genesis-Plus-GX/core/cd_hw/libchdr/deps/lzma"),
                .headerSearchPath("Genesis-Plus-GX/core/cd_hw/libchdr/deps/libFLAC/include"),
                .headerSearchPath("Genesis-Plus-GX/core/input_hw"),
                .headerSearchPath("Genesis-Plus-GX/core/ntsc"),
                
                .headerSearchPath("Genesis-Plus-GX/psp2"),
                
                .define("USE_32BPP_RENDERING"),
                .define("FLAC__HAS_OGG", to: "0"),
                .define("HAVE_SYS_PARAM_H"),
                .define("HAVE_LROUND"),
                .define("PACKAGE_VERSION", to: "\"1.3.2\""),
                .define("_7ZIP_ST"),
                .define("LSB_FIRST")
            ]
        )
    ]
)
