# .Net Core Web API test on RIO

## Container management

Build the container

`docker build --label kodaren/test-netcore-webapi --tag kodaren/test-netcore-webapi:latest .`

---

Run the container

`docker run --publish=3000:80 --expose=80 --label=kodaren/test-netcore-webapi kodaren/test-netcore-webapi`




