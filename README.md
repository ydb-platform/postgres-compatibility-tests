The repository contains scripts for test YDB compatibility with postgres.

# Test structure

The repository contains many test suites for test different libraries. Every test suite contains script for build test environment and run tests. By default all tests work with
trunk version of YDB, started in docker container.

Test suit build docker container with test environment, download YDB container and start tests between the containers.

All test suites has same befaviour
1. Script run-test.bash - for build test environment and start test
2. During test it will create project-sources folder within test suite folder. It contains sources of tests, it need for comfort research test code.
3. Test result will store in tmp/test-result/<project-name> folder as in junittest xml files.

# Manual run tests

For manual run tests you have to install docker, docker-composer and run script run-test.bash from test suite folder.

> YDB_PG_HOST `localhost` will internally change to `host.docker.internal`. It allow connect to host, but service must listen `[::]` or `0.0.0.0` IP address, instead of localhost.

run-test.bash scripts accept arguments with env variables:

| Var name        | Default                     | Description                                                                                                                                |
| --------------- | --------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------ |
| YDB_PG_HOST     | connect to ydb in container | set postgres host, which will used by test suite. If set - ydb container will not be start and test container will start with host network |
| YDB_PG_PORT     | 5432                        | set postgres port                                                                                                                          |
| YDB_PG_DATABASE | /local                      | postgres database                                                                                                                          |
| YDB_PG_USER     | postgres                    | postgres user, which will use in test for pg auth                                                                                          |
| YDB_PG_PASSWORD | password                    | postgres password, which will use in test for pg auth                                                                                      |
| YDB_PG_TESTNAME | Run all tests         | If set - test suite will run only this test |

