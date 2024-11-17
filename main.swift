// swift-tools-version:5.2
import Foundation
import NIO
import NIOHTTP1

struct Version: Codable {
    let version: String
}

func JSON<T: Codable>(_ value: T) -> Data {
    return (try? JSONEncoder().encode(value)) ?? Data()
}

final class HTTPHandler: ChannelInboundHandler {
    typealias InboundIn = HTTPServerRequestPart
    typealias OutboundOut = HTTPServerResponsePart

    func channelRead(context: ChannelHandlerContext, data: NIOAny) {
        let req = self.unwrapInboundIn(data)

        switch req {
        case .head(let requestHead):
            if requestHead.uri == "/version" && requestHead.method == .GET {
                let version = Version(version: "1.0.0")
                let response = JSON(version)

                var headers = HTTPHeaders()
                headers.add(name: "Content-Type", value: "application/json")
                headers.add(name: "Content-Length", value: "\(response.count)")

                let responseHead = HTTPResponseHead(
                    version: requestHead.version,
                    status: .ok,
                    headers: headers)
                _ = context.write(self.wrapOutboundOut(.head(responseHead)))
                var buffer = context.channel.allocator.buffer(capacity: response.count)
                buffer.writeBytes(response)
                _ = context.write(self.wrapOutboundOut(.body(.byteBuffer(buffer))))
                _ = context.writeAndFlush(self.wrapOutboundOut(.end(nil)))
            } else {
                let responseHead = HTTPResponseHead(version: requestHead.version, status: .notFound)
                _ = context.write(self.wrapOutboundOut(.head(responseHead)))
                _ = context.writeAndFlush(self.wrapOutboundOut(.end(nil)))
            }

        case .body:
            break

        case .end:
            break
        }
    }
}

let group = MultiThreadedEventLoopGroup(numberOfThreads: System.coreCount)
let bootstrap = ServerBootstrap(group: group)
    .childChannelInitializer { channel in
        channel.pipeline.configureHTTPServerPipeline().flatMap {
            channel.pipeline.addHandler(HTTPHandler())
        }
    }

defer {
    try? group.syncShutdownGracefully()
}

let serverChannel = try bootstrap.bind(host: "127.0.0.1", port: 8000).wait()
print("listening on http://127.0.0.1:8000")
try serverChannel.closeFuture.wait()
