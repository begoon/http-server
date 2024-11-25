use serde::Serialize;
use warp::Filter;

#[derive(Serialize)]
struct VersionInfo {
    version: String,
}

#[tokio::main]
async fn main() {
    let version = warp::path("version").and(warp::get()).map(|| {
        warp::reply::json(&VersionInfo {
            version: "1.0.0".to_string(),
        })
    });
    warp::serve(version).run(([127, 0, 0, 1], 8000)).await;
}
