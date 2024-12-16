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
	zig build run

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
	dotnet run -c Release

perl:
	cpan Mojolicious
	perl main.pl

d:
	dub

v:
	v run main.v

crystal:
	crystal run main.cr

arm64:
	as -o main.o main.s
	ld -o main main.o \
	-lSystem  \
	-L /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/lib \
	-syslibroot /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk \
	-arch arm64 \
	-platform_version macos 15.0 15.0 \
	-e _main \
	-dynamic
	./main

nim:
	nimble c -r main.nim

julia:
	julia pkg.jl
	julia main.jl

q:
	curl -q http://localhost:8000/version

clean:
	-rm -rf .build .venv .bundle exe _build .nuget main.exe main.drarf main.o main http-server target .zig-cache
	-find . -type d -name "__pycache__" -exec rm -r {} +
	cargo clean
