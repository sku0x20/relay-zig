const std = @import("std");
const Inc = @import("inc.zig");

test "add" {
    try std.testing.expect(Inc.inc(10) == 11);
}
