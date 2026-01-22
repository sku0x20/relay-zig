const std = @import("std");
const Inc = @import("src/inc.zig");

test "add" {
    try std.testing.expect(Inc.inc(10) == 11);
}
