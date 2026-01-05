const std = @import("std");
const Walker = @import("std").fs.Dir.Walker;

pub fn build(b: *std.Build) void {
    const exe = b.addExecutable(.{
        .name = "relay",
        .root_module = b.createModule(.{
            .root_source_file = b.path("src/main.zig"),
            .target = b.graph.host,
            .optimize = .Debug,
        }),
    });
    b.installArtifact(exe);

    unit_tests(b);
}

fn unit_tests(b: *std.Build) void {
    const test_step = b.step("test", "Run all unit tests");

    var dir = b.build_root.handle.openDir("test", .{}) catch |err| {
        std.debug.print("Failed to open 'test': {} \n", .{err});
        return;
    };
    defer dir.close();

    var walker = dir.walk(b.allocator) catch return;
    defer walker.deinit();

    while (walker.next() catch null) |entry| {
        create_individual_ut(b, test_step, entry);
    }
}

fn create_individual_ut(
    b: *std.Build,
    test_step: *std.Build.Step,
    entry: Walker.Entry,
) void {
    if (entry.kind != .file and !std.mem.endsWith(u8, entry.path, ".test.zig")) {
        return;
    }
    const path = b.pathJoin(&.{ "test", entry.path });
    const unit_test = b.addTest(.{
        .name = entry.basename,
        .root_module = b.createModule(.{
            .root_source_file = b.path(path),
            .target = b.graph.host,
            .optimize = .Debug,
        }),
    });

    const run_unit_test = b.addRunArtifact(unit_test);
    test_step.dependOn(&run_unit_test.step);

    // enable to add individual command also
    // const test_name = entry.path;
    // const test_run_step_name = std.fmt.allocPrint(b.allocator, "{s}{s}", .{ "test ", test_name }) catch "unknown";
    // const ut_run_step = b.step(test_run_step_name, "");
    // ut_run_step.dependOn(&run_unit_test.step);
}
