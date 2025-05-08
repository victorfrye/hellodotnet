FROM mcr.microsoft.com/dotnet/aspnet:10.0-preview-alpine AS base
WORKDIR /app

FROM mcr.microsoft.com/dotnet/sdk:10.0-preview-alpine AS build
WORKDIR /source
COPY ["src/WebApi/WebApi.csproj", "src/WebApi/"]
COPY ["test/Tests/Tests.csproj", "test/Tests/"]
COPY ["VictorFrye.HelloDotnet.slnx", "./"]
RUN dotnet restore

COPY . .
WORKDIR /source/.
RUN dotnet build ./src/WebApi/WebApi.csproj -c Release --no-restore 

FROM build AS test
WORKDIR /source/.
RUN dotnet build ./test/Tests/Tests.csproj -c Release --no-restore
RUN dotnet test -c Release --no-build

FROM build AS publish
RUN dotnet publish ./src/WebApi/WebApi.csproj -c Release --no-build -o /out

FROM base AS final
WORKDIR /app
COPY --from=publish /out .
USER $APP_UID
ENTRYPOINT ["dotnet", "VictorFrye.HelloDotnet.WebApi.dll"]
