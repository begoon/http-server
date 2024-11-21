import vibe.vibe;

struct VersionInfo { 
	@name("version")
    string version_;
}

void main()
{
    auto router = new URLRouter;

    router.get("/version", (req, res) {
        res.headers["Content-Type"] = "application/json";
        res.writeJsonBody(VersionInfo("1.0.0"));
    });

    router.any("/", (req, res) {
        res.statusCode = HTTPStatus.notFound;
        res.writeBody("404 Not Found");
    });

    listenHTTP("localhost:8000", router);
    runApplication();
}
