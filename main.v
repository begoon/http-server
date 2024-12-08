module main

import x.json2
import net.http { Request, Response, Server }

struct Version {
    version string
}

struct Handler {}

fn (h Handler) handle(req Request) Response {
	mut res := Response{
		header: http.new_header_from_map({ .content_type: 'application/json' }),
		status_code: 200,
	}
	res.body = match req.url {
		'/version' {
			json2.encode(Version{ version: '0.0.1' })
		} else {
			res.status_code = 404
			'Not found\n'
		}
	}
	return res
}

fn main() {
	mut server := Server{
		handler: Handler{}, 
		addr: ':8000',
		on_running: fn (mut s Server) {
			println('listening on port ${s.addr}')
		},
		show_startup_message: false
	}
	server.listen_and_serve()
}