import Foundation

import Vapor

struct Version : Content {
    var version: String = "1.0.0"
}

struct Main {
    static func main() async {
        do {
            let app = try await Application.make()
            app.get("version", use: { _ in Version() })
            try await app.execute()
            try await app.asyncShutdown()
        } catch {
            print("got error: \(error)")
        }
    }
}

_ = await Task{ await Main.main() }.value
