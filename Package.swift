// swift-tools-version:5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "N64DeltaCore",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v12),
        .macOS(.v11),
        .tvOS(.v12)
    ],
    products: [
        .library(
            name: "N64DeltaCore",
            targets: ["N64DeltaCore"]),
        .library(
            name: "N64DeltaCoreStatic",
            type: .static,
            targets: ["N64DeltaCore"]),
        .library(
            name: "N64DeltaCoreDynamic",
            type: .dynamic,
            targets: ["N64DeltaCore"]),
    ],
    dependencies: [
        //        .package(url: "https://github.com/rileytestut/DeltaCore.git", .branch("main"))
        .package(path: "../DeltaCore")
    ],
    targets: [
        .target(
            name: "N64DeltaCore",
            dependencies: ["DeltaCore", "Mupen64Plus", "N64Swift", "N64Bridge", ],
            exclude: [
                "Resources/Controller Skin/info.json",
                "Resources/Controller Skin/ipad_landscape.pdf",
                "Resources/Controller Skin/ipad_portrait.pdf",
                "Resources/Controller Skin/ipad_splitview_landscape.pdf",
                "Resources/Controller Skin/iphone_edgetoedge_landscape.pdf",
                "Resources/Controller Skin/iphone_edgetoedge_portrait.pdf",
                "Resources/Controller Skin/iphone_landscape.pdf",
                "Resources/Controller Skin/iphone_portrait.pdf",
                "Resources/Controller Skin/portrait_thumbstick.pdf",
                "Resources/Controller Skin/thumbstick_landscape.pdf",
            ],
            resources: [
                .copy("Resources/Controller Skin/Standard.deltaskin"),
                .copy("Resources/Standard.deltamapping"),
            ],
            cSettings: [
                .headerSearchPath("../libMupen64Plus/SDL/"),
                .define("M64P_PARALLEL", to: "1"),
                .define("IN_OPENEMU", to: "1"),
                .define("NO_ASM", to: "1"),
                .define("M64P_CORE_PROTOTYPES", to: "1"),
                .define("NDEBUG", to: "1"),
                .define("PIC", to: "1"),
                .define("USE_GLES", to: "1"),
                .unsafeFlags([
                    "-flto",
                    "-fomit-frame-pointer"
                ])
            ],
            cxxSettings: [
                .headerSearchPath("../libMupen64Plus/SDL/"),
                .define("M64P_PARALLEL", to: "1"),
                .define("IN_OPENEMU", to: "1"),
                .define("NO_ASM", to: "1"),
                .define("M64P_CORE_PROTOTYPES", to: "1"),
                .define("NDEBUG", to: "1"),
                .define("PIC", to: "1"),
                .define("USE_GLES", to: "1"),
                .unsafeFlags([
                    "-flto",
                    "-fomit-frame-pointer"
                ])
            ],
            swiftSettings: [
                .unsafeFlags([
                    "-enable-experimental-cxx-interop",
                    "-I", "../libMupen64Plus/SDL/",
                ])
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
            ]
        ),
        .target(
            name: "libMupen64Plus",
            publicHeadersPath: ""
        ),
        .target(
            name: "N64DeltaCore-RSP",
            sources: [
                "mupen64plus-rsp-hle/src/alist.c",
                "mupen64plus-rsp-hle/src/alist_audio.c",
                "mupen64plus-rsp-hle/src/alist_naudio.c",
                "mupen64plus-rsp-hle/src/alist_nead.c",
                "mupen64plus-rsp-hle/src/audio.c",
                "mupen64plus-rsp-hle/src/cicx105.c",
                "mupen64plus-rsp-hle/src/hle.c",
                "mupen64plus-rsp-hle/src/jpeg.c",
                "mupen64plus-rsp-hle/src/memory.c",
                "mupen64plus-rsp-hle/src/mp3.c",
                "mupen64plus-rsp-hle/src/musyx.c",
                "mupen64plus-rsp-hle/src/osal_dynamiclib_unix.c",
//                "mupen64plus-rsp-hle/src/osal_dynamiclib_win32.c",
                "mupen64plus-rsp-hle/src/plugin.c",
                "mupen64plus-rsp-hle/src/re2.c",
            ],
            cSettings: [
                .headerSearchPath("../mupen64plus-core/src/api/")
            ]
        ),
        .target(
            name: "N64DeltaCore-Video",
            exclude: [
                "GLideN64/src/GLideNUI/",
                "GLideN64/src/neon/",
                "GLideN64/src/osal/",
                "GLideN64/src/windows/",
                "GLideN64/src/Graphics/OpenGLContext/GraphicBuffer/",
                "GLideN64/src/Graphics/OpenGLContext/windows/",
            ],
            sources: [
                "GLideN64/src/3DMath.cpp",
                //                "GLideN64/src/CRC32.cpp",
                //                "GLideN64/src/CRC32_ARMV8.cpp",
                "GLideN64/src/CRC_OPT.cpp",
                "GLideN64/src/Combiner.cpp",
                "GLideN64/src/CombinerKey.cpp",
                "GLideN64/src/CommonPluginAPI.cpp",
                "GLideN64/src/Config.cpp",
                "GLideN64/src/DebugDump.cpp",
                "GLideN64/src/Debugger.cpp",
                "GLideN64/src/DepthBuffer.cpp",
                "GLideN64/src/DisplayLoadProgress.cpp",
                "GLideN64/src/DisplayWindow.cpp",
                "GLideN64/src/FrameBuffer.cpp",
                "GLideN64/src/FrameBufferInfo.cpp",
                "GLideN64/src/GBI.cpp",
                "GLideN64/src/GLideN64.cpp",
                "GLideN64/src/GraphicsDrawer.cpp",
                "GLideN64/src/Keys.cpp",
                //                "GLideN64/src/Log.cpp",
                //                "GLideN64/src/Log_android.cpp",
                "GLideN64/src/MupenPlusPluginAPI.cpp",
                "GLideN64/src/N64.cpp",
                "GLideN64/src/NoiseTexture.cpp",
                "GLideN64/src/PaletteTexture.cpp",
                "GLideN64/src/Performance.cpp",
                "GLideN64/src/PostProcessor.cpp",
                "GLideN64/src/RDP.cpp",
                "GLideN64/src/RSP.cpp",
                "GLideN64/src/RSP_LoadMatrix.cpp",
                //                "GLideN64/src/RSP_LoadMatrixX86.cpp",
                "GLideN64/src/SoftwareRender.cpp",
                "GLideN64/src/TexrectDrawer.cpp",
                //                "GLideN64/src/TextDrawer.cpp",
                "GLideN64/src/TextDrawerStub.cpp",
                "GLideN64/src/TextureFilterHandler.cpp",
                "GLideN64/src/Textures.cpp",
                //                "GLideN64/src/TxFilterStub.cpp",
                "GLideN64/src/VI.cpp",
                //                "GLideN64/src/ZilmarPluginAPI.cpp",
                "GLideN64/src/ZlutTexture.cpp",
                "GLideN64/src/convert.cpp",
                "GLideN64/src/gDP.cpp",
                "GLideN64/src/gSP.cpp",
                //                "GLideN64/src/iob.cpp",

                "GLideN64/src/BufferCopy/ColorBufferToRDRAM.cpp",
                "GLideN64/src/BufferCopy/DepthBufferToRDRAM.cpp",
                "GLideN64/src/BufferCopy/RDRAMtoColorBuffer.cpp",

                "GLideN64/src/common/CommonAPIImpl_common.cpp",

                "GLideN64/src/DepthBufferRender/ClipPolygon.cpp",
                "GLideN64/src/DepthBufferRender/DepthBufferRender.cpp",

//                "GLideN64/src/GLideNHQ/Ext_TxFilter.cpp",
                "GLideN64/src/GLideNHQ/TextureFilters.cpp",
                "GLideN64/src/GLideNHQ/TextureFilters_2xsai.cpp",
                "GLideN64/src/GLideNHQ/TextureFilters_hq2x.cpp",
                "GLideN64/src/GLideNHQ/TextureFilters_hq4x.cpp",
                "GLideN64/src/GLideNHQ/TextureFilters_xbrz.cpp",
                "GLideN64/src/GLideNHQ/TxCache.cpp",
//                "GLideN64/src/GLideNHQ/TxDbg.cpp",
                "GLideN64/src/GLideNHQ/TxFilter.cpp",
                "GLideN64/src/GLideNHQ/TxFilterExport.cpp",
                "GLideN64/src/GLideNHQ/TxHiResCache.cpp",
                "GLideN64/src/GLideNHQ/TxImage.cpp",
                "GLideN64/src/GLideNHQ/TxQuantize.cpp",
                "GLideN64/src/GLideNHQ/TxReSample.cpp",
                "GLideN64/src/GLideNHQ/TxTexCache.cpp",
                "GLideN64/src/GLideNHQ/TxUtil.cpp",
//                "GLideN64/src/GLideNHQ/bldno.cpp",
                "GLideN64/src/GLideNHQ/txWidestringWrapper.cpp",

                "GLideN64/src/Graphics/ColorBufferReader.cpp",
                "GLideN64/src/Graphics/CombinerProgram.cpp",
                "GLideN64/src/Graphics/Context.cpp",
                "GLideN64/src/Graphics/ObjectHandle.cpp",

                "GLideN64/src/Graphics/OpenGLContext/GLFunctions.cpp",
                "GLideN64/src/Graphics/OpenGLContext/opengl_Attributes.cpp",
                "GLideN64/src/Graphics/OpenGLContext/opengl_BufferManipulationObjectFactory.cpp",
                "GLideN64/src/Graphics/OpenGLContext/opengl_BufferedDrawer.cpp",
                "GLideN64/src/Graphics/OpenGLContext/opengl_CachedFunctions.cpp",
                "GLideN64/src/Graphics/OpenGLContext/opengl_ColorBufferReaderWithBufferStorage.cpp",
//                "GLideN64/src/Graphics/OpenGLContext/opengl_ColorBufferReaderWithEGLImage.cpp",
                "GLideN64/src/Graphics/OpenGLContext/opengl_ColorBufferReaderWithPixelBuffer.cpp",
                "GLideN64/src/Graphics/OpenGLContext/opengl_ColorBufferReaderWithReadPixels.cpp",
                "GLideN64/src/Graphics/OpenGLContext/opengl_ContextImpl.cpp",
                "GLideN64/src/Graphics/OpenGLContext/opengl_GLInfo.cpp",
                "GLideN64/src/Graphics/OpenGLContext/opengl_Parameters.cpp",
                "GLideN64/src/Graphics/OpenGLContext/opengl_TextureManipulationObjectFactory.cpp",
                "GLideN64/src/Graphics/OpenGLContext/opengl_UnbufferedDrawer.cpp",
                "GLideN64/src/Graphics/OpenGLContext/opengl_Utils.cpp",

                "GLideN64/src/Graphics/OpenGLContext/GLSL/glsl_CombinerInputs.cpp",
                "GLideN64/src/Graphics/OpenGLContext/GLSL/glsl_CombinerProgramBuilder.cpp",
                "GLideN64/src/Graphics/OpenGLContext/GLSL/glsl_CombinerProgramImpl.cpp",
                "GLideN64/src/Graphics/OpenGLContext/GLSL/glsl_CombinerProgramUniformFactory.cpp",
                "GLideN64/src/Graphics/OpenGLContext/GLSL/glsl_FXAA.cpp",
                "GLideN64/src/Graphics/OpenGLContext/GLSL/glsl_ShaderStorage.cpp",
                "GLideN64/src/Graphics/OpenGLContext/GLSL/glsl_SpecialShadersFactory.cpp",
                "GLideN64/src/Graphics/OpenGLContext/GLSL/glsl_Utils.cpp",

                "GLideN64/src/Graphics/OpenGLContext/mupen64plus/mupen64plus_DisplayWindow.cpp",

                "GLideN64/src/mupenplus/GLideN64_mupenplus.h",
                "GLideN64/src/mupenplus/CommonAPIImpl_mupenplus.cpp",
                "GLideN64/src/mupenplus/Config_mupenplus.cpp",
                "GLideN64/src/mupenplus/MemoryStatus_mupenplus.cpp",
                "GLideN64/src/mupenplus/MupenPlusAPIImpl.cpp",

                "GLideN64/src/uCodes/F3D.cpp",
                "GLideN64/src/uCodes/F3DAM.cpp",
                "GLideN64/src/uCodes/F3DBETA.cpp",
                "GLideN64/src/uCodes/F3DDKR.cpp",
                "GLideN64/src/uCodes/F3DEX.cpp",
                "GLideN64/src/uCodes/F3DEX2.cpp",
                "GLideN64/src/uCodes/F3DEX2ACCLAIM.cpp",
                "GLideN64/src/uCodes/F3DEX2CBFD.cpp",
                "GLideN64/src/uCodes/F3DFLX2.cpp",
                "GLideN64/src/uCodes/F3DGOLDEN.cpp",
                "GLideN64/src/uCodes/F3DPD.cpp",
                "GLideN64/src/uCodes/F3DSETA.cpp",
                "GLideN64/src/uCodes/F3DTEXA.cpp",
                "GLideN64/src/uCodes/F3DZEX2.cpp",
                "GLideN64/src/uCodes/F5Indi_Naboo.cpp",
                "GLideN64/src/uCodes/F5Rogue.cpp",
                "GLideN64/src/uCodes/L3D.cpp",
                "GLideN64/src/uCodes/L3DEX.cpp",
                "GLideN64/src/uCodes/L3DEX2.cpp",
                "GLideN64/src/uCodes/S2DEX.cpp",
                "GLideN64/src/uCodes/S2DEX2.cpp",
                "GLideN64/src/uCodes/T3DUX.cpp",
                "GLideN64/src/uCodes/Turbo3D.cpp",
                "GLideN64/src/uCodes/ZSort.cpp",
                "GLideN64/src/uCodes/ZSortBOSS.cpp",

                "GLideN64/src/xxHash/xxhash.c"
            ],
            cSettings: [
                .define("MUPENPLUSAPI"),
                .define("TXFILTER_LIB"),
                .define("OS_IOS"),
                .define("GLESX"),
                .define("GL_ERROR_DEBUG"),
                .define("GL_DEBUG"),
                .define("GLESX"),
                .define("PNG_ARM_NEON_OPT", to: "0"),
                .headerSearchPath("GLideN64/src/"),
                .headerSearchPath("GLideN64/src/inc"),
            ],
            cxxSettings: [
                .define("MUPENPLUSAPI"),
                .define("TXFILTER_LIB"),
                .define("OS_IOS"),
                .define("GLESX"),
                .define("GL_ERROR_DEBUG"),
                .define("GL_DEBUG"),
                .define("GLESX"),
                .define("PNG_ARM_NEON_OPT", to: "0"),
                .headerSearchPath("GLideN64/src/"),
                .headerSearchPath("GLideN64/src/inc"),
            ],
            linkerSettings: [
                .linkedFramework("OpenGLES"),
                .linkedLibrary("z")
            ]
        ),
        .target(
            name: "Mupen64Plus",
            path: "Sources/Mupen64Plus/mupen64plus-core",
            sources: [
                "src/backends/api/video_capture_backend.c",
                "src/device/dd/dd_controller.c",
                "src/device/controllers/paks/biopak.c",
                "src/backends/dummy_video_capture.c",
            ],
            publicHeadersPath: "src/",
            cSettings: [
                .headerSearchPath("../libMupen64Plus/"),
                .headerSearchPath("../libMupen64Plus/SDL/"),
                .define("M64P_PARALLEL", to: "1"),
                .define("IN_OPENEMU", to: "1"),
                .define("NO_ASM", to: "1"),
                .define("M64P_CORE_PROTOTYPES", to: "1"),
                .define("NDEBUG", to: "1"),
                .define("PIC", to: "1"),
                .define("USE_GLES", to: "1"),
                .unsafeFlags([
                    "-flto",
                    "-fomit-frame-pointer"
                ])
            ],
            cxxSettings: [
                .headerSearchPath("../libMupen64Plus/"),
                .headerSearchPath("../libMupen64Plus/SDL/"),
                .define("M64P_PARALLEL", to: "1"),
                .define("IN_OPENEMU", to: "1"),
                .define("NO_ASM", to: "1"),
                .define("M64P_CORE_PROTOTYPES", to: "1"),
                .define("NDEBUG", to: "1"),
                .define("PIC", to: "1"),
                .define("USE_GLES", to: "1"),
                .unsafeFlags([
                    "-flto",
                    "-fomit-frame-pointer"
                ])
            ]
        )
    ],
    cLanguageStandard: .c11,
    cxxLanguageStandard: .cxx11
)
