const http = require("http");

const versionInfo = { version: "1.0.0" };

const server = http.createServer((req, res) => {
    if (req.method === "GET" && req.url === "/version") {
        res.writeHead(200, { "Content-Type": "application/json" });
        res.end(JSON.stringify(versionInfo));
    } else {
        res.writeHead(404, { "Content-Type": "text/plain" });
        res.end("404 Not Found");
    }
});

const PORT = 8000;
server.listen(PORT, () => console.log(`listening on http://localhost:${PORT}`));
