using HTTP
using JSON

function request_handler(req::HTTP.Request)
    if req.target == "/version"
        payload = JSON.json(Dict("version" => "1.0.0"))
        return HTTP.Response(200, Dict("Content-Type" => "application/json"), payload)
    else
        return HTTP.Response(404, "Not Found")
    end
end

println("listening on http://127.0.0.1:8000")
HTTP.serve(request_handler, "127.0.0.1", 8000)
