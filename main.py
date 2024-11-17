import fastapi

application = fastapi.FastAPI()

@application.get("/version", response_model=dict[str, str])
def version() -> dict[str, str]:
    return {"version": "1.0.0"}