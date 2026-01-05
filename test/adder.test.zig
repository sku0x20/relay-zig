const std = @import("std");
const adder = @import("adder.zig");

test "add" {
    try std.testing.expect(adder.add(10, 20) == 30);
}
