FROM busybox:latest

EXPOSE 8000

CMD mkdir /www && \
    echo "<HTML><HEAD></HEAD><BODY><H1>`uname -a`</H1><br><br>Instructions are available at <a href=\"https://hub.docker.com/r/rattydave/httptest\">https://hub.docker.com/r/rattydave/httptest</a></BODY></HTMl>" > /www/index.html && \
    httpd -p 8000 -h /www -f & wait
