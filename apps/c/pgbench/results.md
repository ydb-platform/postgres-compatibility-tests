Results from test stand.

command for benchmark:
```bash
BENCHMARK=select-only PROTOCOL=simple pgbench postgres://root:1234@localhost:5432/local  -t 100 -b $BENCHMARK --protocol=$PROTOCOL
```

| server | protocol | benchmark | tps |
|--------|----------|-----------|-----|
| postgres |   simple | select-only |  5580 |
|      ydb |   simple | select-only |    68 |
| postgres | prepared | select-only |  7390 |
|      ydb | prepared | select-only |    73 |
| postgres |   simple | simple-update | 552 |
|      ydb |   simple | simple-update |  11 |
| postgres | prepared | simple-update | 887 |
|      ydb | prepared | simple-update |  13 |
| postgres |   simple | tpcb-like |     607 |
|      ydb |   simple | tpcb-like |       6 |
| postgres | prepared | tpcb-like |     588 |
|      ydb | prepared | tpcb-like |      10 |

