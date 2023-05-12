FROM golang:1.20

WORKDIR /project
COPY docker-init.bash /docker-init.bash
RUN /docker-init.bash

COPY docker-start.bash /docker-start.bash

CMD ["/docker-start.bash"]
