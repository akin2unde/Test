
# Use the official .NET Core SDK image as the base image
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app

# Copy the .csproj and restore as distinct layers
COPY *.csproj ./
RUN dotnet restore

# Copy the remaining source code and build the application
COPY . ./

RUN dotnet publish *.csproj -c Release -o /app/publish --self-contained
RUN chmod -R 755 /app

# upgrade musl to remove po#tential vulnerability
#RUN apk upgrade musl  
#RUN apt-get update && apt-get install -y libgdiplus    
#RUN apk add icu-libs

# Build the runtime image
FROM mcr.microsoft.com/dotnet/runtime:8.0
WORKDIR /app
COPY --from=build /app/publish .

# Entry point when the container starts
ENTRYPOINT ["dotnet", "Test.dll"]