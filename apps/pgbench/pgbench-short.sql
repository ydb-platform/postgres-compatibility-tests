drop table IF EXISTS pgbench_history;
drop table IF EXISTS pgbench_tellers;
drop table IF EXISTS pgbench_accounts;
drop table IF EXISTS pgbench_branches;

-- create table pgbench_history(tid int, bid int, aid int, delta int, mtime timestamp, filler char(22), primary key (mtime));
create table pgbench_history(tid int, bid int, aid int, delta int, mtime timestamptz, filler char(22), primary key (mtime));
create table pgbench_tellers(tid int not null,bid int,tbalance int,filler char(84), primary key (tid));
create table pgbench_accounts(aid    int not null,bid int,abalance int,filler char(84), primary key (aid));
create table pgbench_branches(bid int not null,bbalance int,filler char(88), primary key(bid));

--
-- PostgreSQL database dump
--

-- Dumped from database version 14.8 (Debian 14.8-1.pgdg120+1)
-- Dumped by pg_dump version 14.8 (Debian 14.8-1.pgdg120+1)












--
-- Data for Name: pgbench_accounts; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO pgbench_accounts (aid, bid, abalance, filler) VALUES (1, 1, 0, '                                                                                    '::char);
INSERT INTO pgbench_accounts (aid, bid, abalance, filler) VALUES (2, 1, 0, '                                                                                    '::char);
INSERT INTO pgbench_accounts (aid, bid, abalance, filler) VALUES (3, 1, 0, '                                                                                    '::char);
INSERT INTO pgbench_accounts (aid, bid, abalance, filler) VALUES (4, 1, 0, '                                                                                    '::char);
INSERT INTO pgbench_accounts (aid, bid, abalance, filler) VALUES (5, 1, 0, '                                                                                    '::char);
INSERT INTO pgbench_accounts (aid, bid, abalance, filler) VALUES (6, 1, 0, '                                                                                    '::char);
INSERT INTO pgbench_accounts (aid, bid, abalance, filler) VALUES (7, 1, 0, '                                                                                    '::char);
INSERT INTO pgbench_accounts (aid, bid, abalance, filler) VALUES (8, 1, 0, '                                                                                    '::char);
INSERT INTO pgbench_accounts (aid, bid, abalance, filler) VALUES (9, 1, 0, '                                                                                    '::char);
INSERT INTO pgbench_accounts (aid, bid, abalance, filler) VALUES (10, 1, 0, '                                                                                    '::char);


--
-- Data for Name: pgbench_branches; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO pgbench_branches (bid, bbalance, filler) VALUES (1, 0, NULL::char);


--
-- Data for Name: pgbench_history; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: pgbench_tellers; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO pgbench_tellers (tid, bid, tbalance, filler) VALUES (1, 1, 0, NULL::char);
INSERT INTO pgbench_tellers (tid, bid, tbalance, filler) VALUES (2, 1, 0, NULL::char);
INSERT INTO pgbench_tellers (tid, bid, tbalance, filler) VALUES (3, 1, 0, NULL::char);
INSERT INTO pgbench_tellers (tid, bid, tbalance, filler) VALUES (4, 1, 0, NULL::char);
INSERT INTO pgbench_tellers (tid, bid, tbalance, filler) VALUES (5, 1, 0, NULL::char);
INSERT INTO pgbench_tellers (tid, bid, tbalance, filler) VALUES (6, 1, 0, NULL::char);
INSERT INTO pgbench_tellers (tid, bid, tbalance, filler) VALUES (7, 1, 0, NULL::char);
INSERT INTO pgbench_tellers (tid, bid, tbalance, filler) VALUES (8, 1, 0, NULL::char);
INSERT INTO pgbench_tellers (tid, bid, tbalance, filler) VALUES (9, 1, 0, NULL::char);
INSERT INTO pgbench_tellers (tid, bid, tbalance, filler) VALUES (10, 1, 0, NULL::char);


--
-- PostgreSQL database dump complete
--

