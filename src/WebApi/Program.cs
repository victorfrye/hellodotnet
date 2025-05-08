var app = WebApplication.CreateBuilder(args).Build();

app.UseHttpsRedirection();

app.MapGet("/hello", () => "Hello, .NET!");

await app.RunAsync();
