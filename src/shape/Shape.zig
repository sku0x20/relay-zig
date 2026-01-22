const Shape = @This();

const Shape_Virtual_Table = struct {
    draw: *const fn (ptr: *anyopaque) void,
};

ptr: *anyopaque,
virtual_table: Shape_Virtual_Table,

pub fn From(ptr: anytype) Shape {
    const T = @TypeOf(ptr);
    const ptr_info = @typeInfo(T);
    const vt_impl = struct {
        pub fn draw(impl: *anyopaque) void {
            const impl_casted: T = @ptrCast(@alignCast(impl));
            return ptr_info.@"pointer".child.draw(impl_casted);
        }
    };
    return .{
        .ptr = @constCast(ptr),
        .virtual_table = .{
            .draw = vt_impl.draw,
        },
    };
}

pub fn draw(shape: *const Shape) void {
    _ = shape;
}
