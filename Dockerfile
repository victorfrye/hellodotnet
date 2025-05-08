FROM mcr.microsoft.com/dotnet/aspnet:10.0-preview-alpine AS base
LABEL com.github.owner="victorfrye"
LABEL com.github.repo="hellodotnet"
USER $APP_UID

FROM mcr.microsoft.com/dotnet/sdk:10.0-preview-alpine AS build
WORKDIR /source

COPY src/WebApi/WebApi.csproj src/WebApi/
COPY test/Tests/Tests.csproj test/Tests/
COPY VictorFrye.HelloDotnet.slnx ./
RUN dotnet restore

COPY . .
RUN dotnet build -c Release --no-restore 

FROM build AS test
RUN dotnet test -c Release --no-build

FROM test AS publish
RUN dotnet publish ./src/WebApi/WebApi.csproj -c Release --no-build -o /out

FROM base AS final
WORKDIR /app
COPY --from=publish /out .
ENTRYPOINT ["dotnet", "VictorFrye.HelloDotnet.WebApi.dll"]
