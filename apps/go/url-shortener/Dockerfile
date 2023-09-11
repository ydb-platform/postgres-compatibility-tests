# For docker context at root git directory

FROM golang:1.21

WORKDIR /project/sources/

COPY apps/go/url-shortener/docker-init.bash /docker-init.bash

COPY apps/go/url-shortener/src/ /original-sources/

RUN /docker-init.bash

COPY scripts/go-run-separate-tests.bash /go-run-separate-tests.bash

COPY apps/go/url-shortener/docker-start.bash /docker-start.bash

CMD [ "/docker-start.bash" ]
