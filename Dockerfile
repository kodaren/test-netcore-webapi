FROM mcr.microsoft.com/dotnet/core/aspnet:2.2-stretch-slim AS base
WORKDIR /app
EXPOSE 5000

FROM mcr.microsoft.com/dotnet/core/sdk:2.2-stretch AS build
WORKDIR /src
COPY ["rio-test-webapi.csproj", "rio-test-webapi/"]
RUN dotnet restore "rio-test-webapi/rio-test-webapi.csproj"
COPY . .
WORKDIR /src/rio-test-webapi
RUN dotnet build "rio-test-webapi.csproj" -c Release -o /app

FROM build AS publish
RUN dotnet publish "rio-test-webapi.csproj" -c Release -o /app

FROM base AS final
WORKDIR /app
COPY --from=publish /app .
ENTRYPOINT ["dotnet", "rio-test-webapi.dll --server.urls http://0.0.0.0:5000"]