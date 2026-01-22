const std = @import("std");
const Inc = @import("inc.zig");

pub fn main() !void {
    std.debug.print("incremented {}\n", .{
        Inc.inc(19),
    });
}
