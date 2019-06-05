FROM mcr.microsoft.com/dotnet/core/aspnet:2.2-stretch-slim AS base
ENV ASPNETCORE_ENVIRONMENT="Production"
WORKDIR /app
EXPOSE 80
EXPOSE 443

FROM mcr.microsoft.com/dotnet/core/sdk:2.2-stretch AS build
WORKDIR /src

RUN ["mkdir", "-p", "/src/rio-test-webapi"]

COPY * /src/rio-test-webapi/
WORKDIR /src/rio-test-webapi

RUN dotnet restore "rio-test-webapi.csproj"
RUN dotnet build "rio-test-webapi.csproj" -c Release -o /app

FROM build AS publish
RUN dotnet publish "rio-test-webapi.csproj" -c Release -o /app

FROM base AS final
WORKDIR /app
COPY --from=publish /app .
ENTRYPOINT ["dotnet", "rio-test-webapi.dll --server.urls http://0.0.0.0:80"]
