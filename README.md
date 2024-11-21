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

| language | version | source | run command |
| --- | --- | --- | --- |
| zig |  0.14.0 | [main.zig](./main.zig) | `make zig` |
| rustc |  1.82.0 | [main.rs](./main.rs) | `make rust` |
| swift |  6.0 | [main.swift](./main.swift) | `make swift` |
| go |  1.23 | [main.go](./main.go) | `make go` |
| d/ldc | 1.40 | [main.d](./main.d) | `make d` |
| ruby |  3.3.6 | [main.rb](./main.rb) | `make ruby` |
| dart |  3.5.4 | [main.dart](./main.dart) | `make dart` |
| deno |  2.0.6 | [main-deno.ts](./main-deno.ts) | `make deno` |
| bun |  1.1.34 | [main-bun.ts](./main-bun.ts) | `make bun` |
| node |  23.1.0 | [main.js](./main.js) | `make node` |
| php |  8.3.13 | [main.php](./main.php) | `make php` |
| python |  3.13 | [main.py](./main.py) | `make python` |
| pascal/fpc | 3.2.2 | [main.pas](./main.pas) | `make fpc` |
| lua |  5.4.7 | [main.lua](./main.lua) | `make lua` |
| csharp/dotnet | 9.0.0 | [main.cs](./main.cs) | `make cs` |
| perl | 5.34.1 | [main.pl](./main.pl) | `make perl` |

All implementations above are tested on macOS 15.1 Sequoia.

## Run client

`make q` or `curl -q http://localhost:8000/version`.
