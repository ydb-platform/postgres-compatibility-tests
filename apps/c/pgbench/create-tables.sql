DROP TABLE IF EXISTS pgbench_history;
DROP TABLE IF EXISTS pgbench_tellers;
DROP TABLE IF EXISTS pgbench_accounts;
DROP TABLE IF EXISTS pgbench_branches;

CREATE TABLE pgbench_history(tid int, bid int, aid int, delta int, mtime timestamptz, filler char(22), primary key (mtime));
CREATE TABLE pgbench_tellers(tid int not null,bid int,tbalance int,filler char(84), primary key (tid));
CREATE TABLE pgbench_accounts(aid    int not null,bid int,abalance int,filler char(84), primary key (aid));
CREATE TABLE pgbench_branches(bid int not null,bbalance int,filler char(88), primary key(bid));
