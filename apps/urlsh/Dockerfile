# For docker context at root git directory

FROM golang:1.20

WORKDIR /project/sources/

COPY apps/urlsh/patch.diff /patch.diff
COPY apps/urlsh/docker-init.bash /docker-init.bash

RUN /docker-init.bash

COPY scripts/go-run-separate-tests.bash /go-run-separate-tests.bash

COPY apps/urlsh/docker-start.bash /docker-start.bash

CMD [ "/docker-start.bash" ]

