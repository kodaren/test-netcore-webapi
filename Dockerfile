FROM mcr.microsoft.com/dotnet/core/aspnet:2.2-stretch-slim AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

FROM mcr.microsoft.com/dotnet/core/sdk:2.2-stretch AS build
WORKDIR /src
COPY ["rio-test-webapi.csproj", "rio-test-webapi/"]
RUN dotnet restore "rio-test-webapi/rio-test-webapi.csproj"
COPY . .
#WORKDIR /src/rio-test-webapi
RUN dotnet build -c Release -o /app

FROM build AS publish
RUN dotnet publish -c Release -o /app

FROM base AS final
WORKDIR /app
COPY --from=publish /app .
ENTRYPOINT ["dotnet", "./rio-test-webapi.dll"]
