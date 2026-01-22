const std = @import("std");
const adder = @import("src/adder.zig");

test "add" {
    try std.testing.expect(adder.add(10, 20) == 30);
}
