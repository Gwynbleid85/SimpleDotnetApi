# Use the official .NET 9 runtime as base image
FROM mcr.microsoft.com/dotnet/aspnet:9.0 AS base
WORKDIR /app
EXPOSE 8080
EXPOSE 8081

# Use the .NET 9 SDK for building the application
FROM mcr.microsoft.com/dotnet/sdk:9.0 AS build
WORKDIR /src
COPY ["SimpleDotnetApi.csproj", "."]
RUN dotnet restore "SimpleDotnetApi.csproj"
COPY . .
RUN dotnet build "SimpleDotnetApi.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "SimpleDotnetApi.csproj" -c Release -o /app/publish /p:UseAppHost=false

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "SimpleDotnetApi.dll"]