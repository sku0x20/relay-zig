const Rect = @import("src/shape/Rectangle.zig");
const Shape = @import("src/shape/Shape.zig");

test "rectangleInit" {
    const rect = Rect{};
    rect.draw();
}

test "rectangleIsShape" {
    const rect = Rect{};
    _ = Shape.From(&rect);
}

test "rectangleIsShape2" {
    var rect = Rect{};
    rect = Rect{};
    _ = Shape.From(&rect);
}
