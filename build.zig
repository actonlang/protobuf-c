const std = @import("std");
const print = @import("std").debug.print;

pub fn build(b: *std.Build) void {
    const optimize = b.standardOptimizeOption(.{});
    const target = b.standardTargetOptions(.{});

    const lib = b.addStaticLibrary(.{
        .name = "protobuf-c",
        .target = target,
        .optimize = optimize,
    });

    lib.addCSourceFiles(.{
        .files = &.{
            "protobuf-c/protobuf-c.c",
        },
        .flags = &[_][]const u8{
            "-fno-sanitize=undefined",
        }
    });
    lib.linkLibC();
    lib.installHeader(b.path("protobuf-c/protobuf-c.h"), "protobuf-c/protobuf-c.h");
    b.installArtifact(lib);
}