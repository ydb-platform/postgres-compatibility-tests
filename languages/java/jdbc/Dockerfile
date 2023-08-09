# For docker context at root git directory

FROM ubuntu:22.04

WORKDIR /project/sources/
ARG DEBIAN_FRONTEND=noninteractive

COPY patch.diff /patch.diff
COPY docker-init.bash /docker-init.bash
RUN /docker-init.bash

COPY docker-start.bash /docker-start.bash

CMD [ "/docker-start.bash" ]
