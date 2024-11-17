all:
	@echo "Usage: make [swift|rust|go|deno|bun|node|zig|cs|ruby|dart|php|python|fpc|lua|q|clean]"

swift:
	swift build && swift run http-server

rust:
	cargo run -p http-server

go:
	go run main.go

deno:
	deno run -A --watch main-deno.ts

bun:
	bun run main-bun.ts

node:
	node main.js

zig:
	zig run main.zig

ruby:
	bundle install
	ruby main.rb

dart:
	dart main.dart

php:
	php -S localhost:8000 main.php

python:
	uv venv
	source ./.venv/bin/activate \
	&& uv pip install -r requirements.txt \
	&& fastapi dev main.py

fpc:
	fpc -oexe main.pas && ./exe

lua:
	for package in luasocket dkjson copas; do luarocks install $$package; done
	lua main.lua

cs:
	nuget install -OutputDirectory .nuget Newtonsoft.Json
	mcs -r:System.Net.Http.dll \
	-r:.nuget/Newtonsoft.Json.13.0.3/lib/net45/Newtonsoft.Json.dll main.cs
	MONO_PATH=.nuget/Newtonsoft.Json.13.0.3/lib/net45 mono main.exe

q:
	curl -q http://localhost:8000/version

clean:
	-rm -rf .build .venv .bundle exe _build .nuget main.exe main.o
	-find . -type d -name "__pycache__" -exec rm -r {} +
	cargo clean

