Results from test stand.

For benchmark run from repository root command:
```
./apps/c/pgbench/run-pgbench.sh
```

YDB: compiled from main branch with `--build=RelWithDebInfo` and run with in-memory PDISKS (YDB_USE_IN_MEMORY_PDISKS=true for ydb local).
postgres: docker-image postgres:14

Test run on virtual computer at Yandex cloud. CPU: Intel Xeon Processor (Icelake), 32 cores, RAM: 64 GB, DISK: SSD

Date: 2024-03-06

| server   | benchmark     | protocol |   tps |
| -------- | ------------- | -------- | ----: |
| ydb      | select-only   | simple   |  1864 |
| ydb      | select-only   | prepared |    22 |
| ydb      | simple-update | simple   |    95 |
| ydb      | simple-update | prepared |     4 |
| ydb      | tpcb-like     | simple   |    49 |
| ydb      | tpcb-like     | prepared |     3 |
| postgres | select-only   | simple   | 10620 |
| postgres | select-only   | prepared | 14296 |
| postgres | simple-update | simple   |   670 |
| postgres | simple-update | prepared |   877 |
| postgres | tpcb-like     | simple   |   661 |
| postgres | tpcb-like     | prepared |   681 |
