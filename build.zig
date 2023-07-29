const std = @import("std");
const builtin = @import("builtin");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const lib = b.addStaticLibrary(.{
        .name = "opus",
        .target = target,
        .optimize = optimize,
    });
    lib.linkLibC();
    lib.defineCMacro("USE_ALLOCA", null);
    lib.defineCMacro("OPUS_BUILD", null);
    lib.addIncludePath("include");
    lib.addIncludePath("celt");
    lib.addIncludePath("silk");
    lib.addCSourceFiles(&sources, &.{});
    lib.installHeadersDirectory("include", "");
    b.installArtifact(lib);
}

const sources = [_][]const u8{
    "src/opus_decoder.c",
    "src/opus_encoder.c",
};
