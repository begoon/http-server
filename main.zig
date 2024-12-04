const std = @import("std");

const httpz = @import("httpz");

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();

    var server = try httpz.Server(void).init(allocator, .{ .port = 8000 }, {});
    defer {
        server.stop();
        server.deinit();
    }

    var router = server.router(.{});

    router.get("/version", versionHandler, .{});

    std.debug.print("listening on port 8000\n", .{});
    try server.listen();
}

fn versionHandler(req: *httpz.Request, res: *httpz.Response) !void {
    std.log.info("{any} {s}", .{ req.method, req.url.path });
    res.status = 200;
    try res.json(.{ .version = "0.0.1" }, .{});
}
