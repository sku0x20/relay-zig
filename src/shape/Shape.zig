const Shape = @This();

const Shape_Virtual_Table = struct {
    draw: *const fn (ptr: *anyopaque) void,
    shapeType: *const fn (ptr: *anyopaque) u32,
};

ptr: *anyopaque,
virtual_table: Shape_Virtual_Table,

// kinda like golang interfaces; duck typing
pub fn From(ptr: anytype) Shape {
    const T = @TypeOf(ptr);
    const ptr_info = @typeInfo(T);
    const vt_impl = struct {
        pub fn draw(impl: *anyopaque) void {
            const impl_casted: T = @ptrCast(@alignCast(impl));
            return ptr_info.pointer.child.draw(impl_casted);
        }
        pub fn shapeType(impl: *anyopaque) u32 {
            const impl_casted: T = @ptrCast(@alignCast(impl));
            return ptr_info.pointer.child.shapeType(impl_casted);
        }
    };
    return .{
        .ptr = @constCast(ptr),
        .virtual_table = .{
            .draw = vt_impl.draw,
            .shapeType = vt_impl.shapeType,
        },
    };
}

pub fn draw(shape: *const Shape) void {
    return shape.virtual_table.draw(shape.ptr);
}

pub fn shapeType(shape: *const Shape) u32 {
    return shape.virtual_table.shapeType(shape.ptr);
}
