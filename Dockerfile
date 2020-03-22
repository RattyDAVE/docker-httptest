FROM busybox:latest

EXPOSE 8000

WORKDIR /www

CMD echo "<HTML><HEAD></HEAD><BODY><H1>`uname -a`</H1><br><br>Instructions are available at <a href=\"https://hub.docker.com/r/rattydave/httptest\" target="_blank">https://hub.docker.com/r/rattydave/httptest</a></BODY></HTMl>" > /www/index.html && \
    httpd -p 8000 -h /www -f & wait
