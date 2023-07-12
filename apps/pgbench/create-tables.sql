create table pgbench_history(tid int, bid int, aid int, delta int, mtime timestamp, filler char(22), primary key (mtime));
create table pgbench_tellers(tid int not null,bid int,tbalance int,filler char(84), primary key (tid));
create table pgbench_accounts(aid    int not null,bid int,abalance int,filler char(84), primary key (aid));
create table pgbench_branches(bid int not null,bbalance int,filler char(88), primary key(bid));

