FROM python:3.8
WORKDIR /project

COPY patch.diff /patch.diff
COPY docker-init.bash /docker-init.bash
RUN /docker-init.bash
COPY docker-start.bash /docker-start.bash
COPY docker-start-test.py /docker-start-test.py

CMD ["/docker-start.bash"]
