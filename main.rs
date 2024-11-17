use hyper::service::{make_service_fn, service_fn};
use hyper::{Body, Request, Response, Server, StatusCode};
use serde::Serialize;
use std::convert::Infallible;

#[derive(Serialize)]
struct VersionInfo {
    version: String,
}

async fn handle_request(req: Request<Body>) -> Result<Response<Body>, Infallible> {
    match req.uri().path() {
        "/version" => {
            let version_info = VersionInfo {
                version: "1.0.0".to_string(),
            };
            let json = serde_json::to_string(&version_info).unwrap();
            Ok(Response::new(Body::from(json)))
        }
        _ => {
            let mut not_found = Response::new(Body::from("404 Not Found"));
            *not_found.status_mut() = StatusCode::NOT_FOUND;
            Ok(not_found)
        }
    }
}

#[tokio::main]
async fn main() {
    let make_svc =
        make_service_fn(|_conn| async { Ok::<_, Infallible>(service_fn(handle_request)) });

    let addr = ([127, 0, 0, 1], 8000).into();

    let server = Server::bind(&addr).serve(make_svc);

    println!("listening on http://{}", addr);

    if let Err(e) = server.await {
        eprintln!("server error: {}", e);
    }
}
