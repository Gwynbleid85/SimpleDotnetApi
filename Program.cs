using System.Globalization;
using Microsoft.AspNetCore.Mvc;
using Serilog;

var builder = WebApplication.CreateBuilder(args);
Log.Logger = new LoggerConfiguration()
    .WriteTo.Console(
        outputTemplate: "[{Timestamp:yyyy-MM-dd HH:mm:ss} {Level:u3}] {Message:lj}{NewLine}{Exception}",
        formatProvider: CultureInfo.InvariantCulture)
    .CreateLogger();


var app = builder.Build();

app.UseHttpsRedirection();

app.MapGet("/test", (string data) =>
{
    Log.Information("Test endpoint hit with data: [{Data}]", data);
    return Results.Ok("Hello, World!");
});

app.Run();