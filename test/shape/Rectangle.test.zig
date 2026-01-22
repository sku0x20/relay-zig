const Rect = @import("src/shape/Rectangle.zig");

test "rectangleInit" {
    const rect = Rect{};
    rect.draw();
}
