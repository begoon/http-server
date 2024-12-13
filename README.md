# HTTP server in different languages

## Problem statement

The server listens on `localhost:8000` and exposes `/version` endpoint.

The `/version` endpoint returns a RESTful JSON response with the "version"
fields. The payload should be serialized to JSON from a struct or class,
not printed as a simple string.

Other routes, root included, should return 404.

When the server runs, it should respond to `curl http://localhost:8000/version`
or in the [web browser](http://localhost:8000/version).

## Used compilers and interpreters

| language | version | framwork | source | run command |
| --- | --- | --- | --- | --- |
| zig | 0.14.0 | httpz | [main.zig](./main.zig) | `make zig` |
| rustc | 1.82.0 | warp | [main.rs](./main.rs) | `make rust` |
| swift | 6.0 | vapor | [main.swift](./main.swift) | `make swift` |
| go | 1.23 | - | [main.go](./main.go) | `make go` |
| v | 0.4.8 | - | [main.v](./main.v) | `make v` |
| assember | arm64 | macos/libc | [main.s](./main.s) | `make arm64` |
| d/ldc | 1.40 | vibe | [main.d](./main.d) | `make d` |
| ruby | 3.3.6 | sinatra | [main.rb](./main.rb) | `make ruby` |
| dart | 3.5.4 | - | [main.dart](./main.dart) | `make dart` |
| deno | 2.0.6 | - | [main-deno.ts](./main-deno.ts) | `make deno` |
| bun | 1.1.34 | - | [main-bun.ts](./main-bun.ts) | `make bun` |
| node | 23.1.0 | - | [main.js](./main.js) | `make node` |
| php | 8.3.13 | - | [main.php](./main.php) | `make php` |
| python | 3.13 | fastapi | [main.py](./main.py) | `make python` |
| pascal/fpc | 3.2.2 | - | [main.pas](./main.pas) | `make fpc` |
| lua | 5.4.7 | copas | [main.lua](./main.lua) | `make lua` |
| csharp/dotnet | 9.0.0 | - | [main.cs](./main.cs) | `make cs` |
| perl | 5.34.1 | mojolicious | [main.pl](./main.pl) | `make perl` |

All implementations above are tested on macOS 15.1 Sequoia.

## Run client

`make q` or `curl -q http://localhost:8000/version`.

## Contributions

[C# version](./main.cs) is rewritten by [@neon-sunset](https://www.github.com/neon-sunset)

[Swift version](./main.swift) is rewritten by [@Frizlab](https://www.github.com/Frizlab)

[arm64 assembly version](./main.s) is based on [@dmtrKovalenko](https://www.github.com/dmtrKovalenko)'s [macos-assembly-http-server](https://www.github.com/dmtrKovalenko/macos-assembly-http-server)
