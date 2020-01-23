FROM busybox:latest

EXPOSE 8000

CMD mkdir /www && \
    echo "<HTML><HEAD></HEAD><BODY><H1>`uname -a`</H1></BODY></HTMl>" > /www/index.html && \
    httpd -p 8000 -h /www -f & wait
