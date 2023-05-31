# For docker context at root git directory

FROM golang:1.20

WORKDIR /project/sources/

COPY languages/go/libpq/patch.diff /patch.diff
COPY languages/go/libpq/docker-init.bash /docker-init.bash
RUN /docker-init.bash

COPY scripts/go-run-separate-tests.bash /go-run-separate-tests.bash

COPY languages/go/libpq/docker-start.bash /docker-start.bash

CMD [ "/docker-start.bash" ]
