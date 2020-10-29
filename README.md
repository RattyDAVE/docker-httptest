# docker-httptest


## Basic setup

TINY docker container that shows uname -a when you send it a http request. Usefull for testing clusters.

```
docker run -d --rm --name httptest -p 80:8000 rattydave/httptest
```


## Auto Update

To automatically update I recomend using watchtower.

```
docker run -d \
  --name watchtower \
  -v /var/run/docker.sock:/var/run/docker.sock \
  v2tec/watchtower 
```

## Reverse Proxy Setup

In this example we need a DNS name and nginx-proxy. This is one of best containers out there and easy to use.

First point you domain name to the ip address of the docker host server. (This can either be a 'A', 'AAAA' or 'CNAME' record)

```
docker run -d --name nginx-proxy \
    --publish 80:80 \
    --publish 443:443 \
    --volume /etc/nginx/certs \
    --volume /etc/nginx/vhost.d \
    --volume /usr/share/nginx/html \
    --volume /var/run/docker.sock:/tmp/docker.sock:ro \
    jwilder/nginx-proxy
```

This set up the reverse proxy. 

Then start the http test container. 

```
docker run -d \
    --env "VIRTUAL_HOST=hostname.com" \
    --env "VIRTUAL_PORT=8000" \
    rattydave/httptest
```

Now it is test time. Open a browser and access http://hostname.com. You should see the uname -a output. If you hit refesh a few times you will notice this information does not change.

## Cluster Setup

For cluster setup follow the Reverse Proxy Setup then add another http test container using EXACTLY the same command.

```
docker run -d \
    --env "VIRTUAL_HOST=hostname.com" \
    --env "VIRTUAL_PORT=8000" \
    rattydave/httptest
```

Refesh the browser (a few times) and you will now see it will alternate between the host names.

You can add more using the above process and it will switch between them all.

## To add SSL certs.

To add SSL certificates to the reverse proxy you can add the following container that works in conjunction with nginx-proxy.

```
docker run --detach \
    --name nginx-proxy-letsencrypt \
    --volumes-from nginx-proxy \
    --volume /var/run/docker.sock:/var/run/docker.sock:ro \
    --env "DEFAULT_EMAIL=your@email.com" \
    jrcs/letsencrypt-nginx-proxy-companion
```

Note: replace `your@email.com` with your email.

You need to make a small change to the httptest container.  

```
docker run -d \
    --env "VIRTUAL_HOST=hostname.com" \
    --env "VIRTUAL_PORT=8000" \
    --env "LETSENCRYPT_HOST=hostname.com" \
    rattydave/httptest
```

Open a browser and access https://hostname.com. (Note: httpS). You should now have a secure connection. 





