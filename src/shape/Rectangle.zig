const Rect = @This();

pub fn draw(rect: *const Rect) void {
    _ = rect;
}

pub fn shapeType(_: *const Rect) u32 {
    return 19;
}
