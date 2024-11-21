var builder = WebApplication.CreateBuilder(args);
builder.Logging.ClearProviders();

var app = builder.Build();
app.MapGet("/version", () => new { version = "1.0.0" });
app.Run("http://localhost:8000");
