create table pgbench_history(tid int,bid int,aid    int,delta int,mtime timestamp,filler char(22));
create table pgbench_tellers(tid int not null,bid int,tbalance int,filler char(84)) with (fillfactor=100);
create table pgbench_accounts(aid    int not null,bid int,abalance int,filler char(84)) with (fillfactor=100);
create table pgbench_branches(bid int not null,bbalance int,filler char(88)) with (fillfactor=100);

alter table pgbench_branches add primary key (bid);
alter table pgbench_tellers add primary key (tid);
alter table pgbench_accounts add primary key (aid);
