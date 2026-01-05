const Adder = @import("adder.zig");

pub fn inc(n: u32) u32{
    return Adder.add(n, 1);
}