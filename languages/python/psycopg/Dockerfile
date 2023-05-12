FROM python:3.8
WORKDIR /project

RUN pip install "xmlrunner < 4" "psycopg2==2.9.6"
COPY test-in-docker.bash /test-in-docker.bash

CMD ["/test-in-docker.bash"]
