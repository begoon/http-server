const std = @import("std");
const net = std.net;
const http = std.http;
const json = std.json;

pub fn main() !void {
    const addr = net.Address.parseIp4("127.0.0.1", 8000) catch | err | {
        std.debug.print("error resolving the IP address: {}\n", .{err});
        return; 
    };
    var server = try addr.listen(.{});
    start_server(&server);
}

fn start_server(server: *net.Server) void {
    while (true){
        var connection = server.accept() catch |err| {
            std.debug.print("error accepting connection: {}\n", .{err});
            continue;
        };
        defer connection.stream.close();

        var read_buffer : [1024]u8 = undefined;
        var http_server = http.Server.init(connection, &read_buffer);

        var request = http_server.receiveHead() catch |err| {
            std.debug.print("error reading head head: {}\n", .{err});
            continue;
        };
        handle_request(&request) catch |err| {
            std.debug.print("error handling request: {}", .{err});
            continue;
        };
    }
}

fn handle_request(request: *http.Server.Request) !void {
    std.debug.print("REQUEST {any} {s}\n", .{request.head.method, request.head.target});
    var content_length: usize = 0;
    if (std.mem.startsWith(u8, request.head.target, "/version")) {
        const version = struct { version: []const u8 }{
            .version = "1.0.0",
        };
        var buffer: [1024]u8 = undefined;
        var stream = std.io.fixedBufferStream(&buffer);
        try json.stringify(version, .{}, stream.writer());
        const response = stream.getWritten();
        content_length = response.len;
        try request.respond(response, .{});
   } else {
        try request.respond("404 Not Found\n", .{.status = .not_found});
    }
    std.debug.print("RESPONSE {d}\n", .{content_length});
}
