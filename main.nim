import options, asyncdispatch
import std/json

import httpbeast

proc onRequest(req: Request): Future[void] =
  if req.httpMethod == some(HttpGet):
    case req.path.get()
    of "/version":
      req.send($(%* {"version": "1.0.0"}))
    else:
      req.send(Http404)

run(onRequest, initSettings(port=Port(8000)))
