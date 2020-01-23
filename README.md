# docker-httptest
TINY docker container that shows uname -a when you send it a http request. Usefull for testing clusters.


```
docker run -d --rm --name httptest -p 80:8000 rattydave/httptest
```
