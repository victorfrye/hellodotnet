var builder = WebApplication.CreateBuilder(args);

builder.Services.AddOpenApi();

var app = builder.Build();

app.MapOpenApi();
app.UseHttpsRedirection();

app.MapGet("/hello", () => "Hello, .NET!")
   .WithName("GetHello")
   .Produces<string>();

await app.RunAsync();
