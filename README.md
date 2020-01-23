# docker-httptest
TINY docker container that shows uname -a when you send it a http request. Usefull for testing clusters.


```
docker run -d --rm --name httptest -p 80:8000 rattydave/httptest
```

```
docker run -d --rm \
    --env "VIRTUAL_HOST=hostname.com" \
    --env "VIRTUAL_PORT=8000" \
    --env "LETSENCRYPT_HOST=hostname.com" \
    --env "LETSENCRYPT_EMAIL=name@hostname.com" \
    rattydave/httptest
```
