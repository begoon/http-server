# HTTP server in different languages

## Problem statement

The server listens on localhost:8000 and exposes "/version" endpoint.

The "/version" endpoint returns a RESTful JSON response with the "version" fields. The payload should be serialized to JSON from a struct or class, not printed as a simple string.

Other routes, root included, should return 404.

When the server runs, it should respond to `curl http://localhost:8000/version`
or in the [web browser](http://localhost:8000/version).

## Used compilers and interpreters

Tested on macOS 15.1 Sequoia.

- zig 0.14.0 - [main.zig](./main.zig)
- rustc 1.82.0 - [main.rs](./main.rs)
- swift 6.0 - [main.swift](./main.swift)
- go 1.23 - [main.go](./main.go)
- ruby 3.3.6 - [main.rb](./main.rb)
- dart 3.5.4 - [main.dart](./main.dart)
- deno 2.0.6 - [main-deno.ts](./main-deno.ts)
- bun 1.1.34 - [main-bun.ts](./main-bun.ts)
- node 23.1.0 - [main.js](./main.js)
- php 8.3.13 - [main.php](./main.php)
- python 3.13 - [main.py](./main.py)
- freepascal/fpc 3.2.2 - [main.pas](./main.pas)
- lua 5.4.7 - [main.lua](./main.lua)
- csharp/mono 6.12.0 - [main.cs](./main.cs)

## Run servers for each language

`make zig`

`make rust`

`make swift`

`make go`

`make ruby`

`make dart`

`make deno`

`make bun`

`make node`

`make php`

`make python`

`make fpc`

`make lua`

`make cs`

## Run client

`make q` or `curl -q http://localhost:8000/version`.
