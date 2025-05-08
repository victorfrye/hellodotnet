using Microsoft.AspNetCore.Mvc.Testing;

namespace VictorFrye.HelloDotnet.Tests;

public class HelloApiTests(WebApplicationFactory<Program> factory) : IClassFixture<WebApplicationFactory<Program>>
{
    [Fact]
    public async Task GetHelloReturnsHelloDotnet()
    {
        var client = factory.CreateClient();

        var response = await client.GetAsync("/hello");
        response.EnsureSuccessStatusCode();

        var content = await response.Content.ReadAsStringAsync();
        Assert.Equal("Hello, .NET!", content);
    }
}
