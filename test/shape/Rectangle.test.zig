const std = @import("std");

const Rect = @import("src/shape/Rectangle.zig");
const Shape = @import("src/shape/Shape.zig");

test "rectangle" {
    const rect = Rect{ .data = 1 };
    rect.draw();

    try std.testing.expectEqual(rect.shapeType(), 19);
}

test "rectangleIsShape" {
    const rect = Rect{ .data = 2 };
    const shape = Shape.From(&rect);
    shape.draw();

    try std.testing.expectEqual(shape.shapeType(), 19);

    std.debug.print("1. {}\n", .{shape});
}

test "rectangleIsShape2" {
    var rect = Rect{ .data = 3 };
    rect = Rect{ .data = 4 };
    const shape = Shape.From(&rect);
    shape.draw();

    std.debug.print("2. {}\n", .{shape});
    std.debug.print("2. {}\n", .{Shape.From(&Rect{ .data = 5 })});
    std.debug.print("2. {}\n", .{Shape.From(&Rect{ .data = 6 })});

    try std.testing.expectEqual(shape.shapeType(), 19);
}
