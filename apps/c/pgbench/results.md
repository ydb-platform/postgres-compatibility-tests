Results from test stand.

For benchmark run from repository root command:
```
./apps/c/pgbench/run-pgbench.sh
```

YDB: compiled from main branch with `--build=RelWithDebInfo` and run with in-memory PDISKS (YDB_USE_IN_MEMORY_PDISKS=true for ydb local).
postgres: docker-image postgres:14

Test run on virtual computer at Yandex cloud. CPU: Intel Xeon Processor (Icelake), 32 cores, RAM: 64 GB, DISK: SSD

Date: 2024-03-06

| server | benchmark     | protocol | ydb tps | pg tsp |
| ------ | ------------- | -------- | ------: | -----: |
| ydb    | select-only   | simple   |    1864 |  10620 |
| ydb    | select-only   | prepared |      22 |  14296 |
| ydb    | simple-update | simple   |      95 |    670 |
| ydb    | simple-update | prepared |       4 |    877 |
| ydb    | tpcb-like     | simple   |      49 |    661 |
| ydb    | tpcb-like     | prepared |       3 |    681 |

