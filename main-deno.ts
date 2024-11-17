Deno.serve({ port: 8000 }, async (request: Request) => {
    const pathname = new URL(request.url).pathname;
    if (request.method === "GET" && pathname === "/version") {
        return Response.json({ version: "1.0.0" });
    }
    return new Response(null, { status: 404 });
});
