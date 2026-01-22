const std = @import("std");

const Rect = @import("src/shape/Rectangle.zig");
const Shape = @import("src/shape/Shape.zig");

test "rectangle" {
    const rect = Rect{};
    rect.draw();

    try std.testing.expectEqual(rect.shapeType(), 19);
}

test "rectangleIsShape" {
    const rect = Rect{};
    const shape = Shape.From(&rect);
    shape.draw();

    try std.testing.expectEqual(shape.shapeType(), 19);
}

test "rectangleIsShape2" {
    var rect = Rect{};
    rect = Rect{};
    const shape = Shape.From(&rect);
    shape.draw();

    try std.testing.expectEqual(shape.shapeType(), 19);
}
