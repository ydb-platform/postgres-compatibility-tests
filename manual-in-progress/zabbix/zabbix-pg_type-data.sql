--
-- PostgreSQL database dump
--

-- Dumped from database version 14.7 (Debian 14.7-1.pgdg110+1)
-- Dumped by pg_dump version 14.10 (Ubuntu 14.10-0ubuntu0.22.04.1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
-- SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

-- SET default_tablespace = '';

-- SET default_table_access_method = heap;

--
-- Name: pg_type; Type: TABLE; Schema: public; Owner: root
--

DROP TABLE IF EXISTS pg_type;
CREATE TABLE pg_type (
    oid int PRIMARY KEY,
    typinput text,
    typname text,
    typnamespace int,
    typtype "char"
);


-- ALTER TABLE pg_type OWNER TO root;

--
-- Data for Name: pg_type; Type: TABLE DATA; Schema: public; Owner: root
--

INSERT INTO pg_type (oid, typinput, typname, typnamespace, typtype) VALUES
	(16, 'boolin', 'bool', 11, 'b'),
	(17, 'byteain', 'bytea', 11, 'b'),
	(18, 'charin', 'char', 11, 'b'),
	(19, 'namein', 'name', 11, 'b'),
	(20, 'int8in', 'int8', 11, 'b'),
	(21, 'int2in', 'int2', 11, 'b'),
	(22, 'int2vectorin', 'int2vector', 11, 'b'),
	(23, 'int4in', 'int4', 11, 'b'),
	(24, 'regprocin', 'regproc', 11, 'b'),
	(25, 'textin', 'text', 11, 'b'),
	(26, 'oidin', 'oid', 11, 'b'),
	(27, 'tidin', 'tid', 11, 'b'),
	(28, 'xidin', 'xid', 11, 'b'),
	(29, 'cidin', 'cid', 11, 'b'),
	(30, 'oidvectorin', 'oidvector', 11, 'b'),
	(71, 'record_in', 'pg_type', 11, 'c'),
	(75, 'record_in', 'pg_attribute', 11, 'c'),
	(81, 'record_in', 'pg_proc', 11, 'c'),
	(83, 'record_in', 'pg_class', 11, 'c'),
	(114, 'json_in', 'json', 11, 'b'),
	(142, 'xml_in', 'xml', 11, 'b'),
	(194, 'pg_node_tree_in', 'pg_node_tree', 11, 'b'),
	(3361, 'pg_ndistinct_in', 'pg_ndistinct', 11, 'b'),
	(3402, 'pg_dependencies_in', 'pg_dependencies', 11, 'b'),
	(5017, 'pg_mcv_list_in', 'pg_mcv_list', 11, 'b'),
	(32, 'pg_ddl_command_in', 'pg_ddl_command', 11, 'p'),
	(5069, 'xid8in', 'xid8', 11, 'b'),
	(600, 'point_in', 'point', 11, 'b'),
	(601, 'lseg_in', 'lseg', 11, 'b'),
	(602, 'path_in', 'path', 11, 'b'),
	(603, 'box_in', 'box', 11, 'b'),
	(604, 'poly_in', 'polygon', 11, 'b'),
	(628, 'line_in', 'line', 11, 'b'),
	(700, 'float4in', 'float4', 11, 'b'),
	(701, 'float8in', 'float8', 11, 'b'),
	(705, 'unknownin', 'unknown', 11, 'p'),
	(718, 'circle_in', 'circle', 11, 'b'),
	(790, 'cash_in', 'money', 11, 'b'),
	(829, 'macaddr_in', 'macaddr', 11, 'b'),
	(869, 'inet_in', 'inet', 11, 'b'),
	(650, 'cidr_in', 'cidr', 11, 'b'),
	(774, 'macaddr8_in', 'macaddr8', 11, 'b'),
	(1033, 'aclitemin', 'aclitem', 11, 'b'),
	(1042, 'bpcharin', 'bpchar', 11, 'b'),
	(1043, 'varcharin', 'varchar', 11, 'b'),
	(1082, 'date_in', 'date', 11, 'b'),
	(1083, 'time_in', 'time', 11, 'b'),
	(1114, 'timestamp_in', 'timestamp', 11, 'b'),
	(1184, 'timestamptz_in', 'timestamptz', 11, 'b'),
	(1186, 'interval_in', 'interval', 11, 'b'),
	(1266, 'timetz_in', 'timetz', 11, 'b'),
	(1560, 'bit_in', 'bit', 11, 'b'),
	(1562, 'varbit_in', 'varbit', 11, 'b'),
	(1700, 'numeric_in', 'numeric', 11, 'b'),
	(1790, 'textin', 'refcursor', 11, 'b'),
	(2202, 'regprocedurein', 'regprocedure', 11, 'b'),
	(2203, 'regoperin', 'regoper', 11, 'b'),
	(2204, 'regoperatorin', 'regoperator', 11, 'b'),
	(2205, 'regclassin', 'regclass', 11, 'b'),
	(4191, 'regcollationin', 'regcollation', 11, 'b'),
	(2206, 'regtypein', 'regtype', 11, 'b'),
	(4096, 'regrolein', 'regrole', 11, 'b'),
	(4089, 'regnamespacein', 'regnamespace', 11, 'b'),
	(2950, 'uuid_in', 'uuid', 11, 'b'),
	(3220, 'pg_lsn_in', 'pg_lsn', 11, 'b'),
	(3614, 'tsvectorin', 'tsvector', 11, 'b'),
	(3642, 'gtsvectorin', 'gtsvector', 11, 'b'),
	(3615, 'tsqueryin', 'tsquery', 11, 'b'),
	(3734, 'regconfigin', 'regconfig', 11, 'b'),
	(3769, 'regdictionaryin', 'regdictionary', 11, 'b'),
	(3802, 'jsonb_in', 'jsonb', 11, 'b'),
	(4072, 'jsonpath_in', 'jsonpath', 11, 'b'),
	(2970, 'txid_snapshot_in', 'txid_snapshot', 11, 'b'),
	(5038, 'pg_snapshot_in', 'pg_snapshot', 11, 'b'),
	(3904, 'range_in', 'int4range', 11, 'r'),
	(3906, 'range_in', 'numrange', 11, 'r'),
	(3908, 'range_in', 'tsrange', 11, 'r'),
	(3910, 'range_in', 'tstzrange', 11, 'r'),
	(3912, 'range_in', 'daterange', 11, 'r'),
	(3926, 'range_in', 'int8range', 11, 'r'),
	(4451, 'multirange_in', 'int4multirange', 11, 'm'),
	(4532, 'multirange_in', 'nummultirange', 11, 'm'),
	(4533, 'multirange_in', 'tsmultirange', 11, 'm'),
	(4534, 'multirange_in', 'tstzmultirange', 11, 'm'),
	(4535, 'multirange_in', 'datemultirange', 11, 'm'),
	(4536, 'multirange_in', 'int8multirange', 11, 'm'),
	(2249, 'record_in', 'record', 11, 'p'),
	(2287, 'array_in', '_record', 11, 'p'),
	(2275, 'cstring_in', 'cstring', 11, 'p'),
	(2276, 'any_in', 'any', 11, 'p'),
	(2277, 'anyarray_in', 'anyarray', 11, 'p'),
	(2278, 'void_in', 'void', 11, 'p'),
	(2279, 'trigger_in', 'trigger', 11, 'p'),
	(3838, 'event_trigger_in', 'event_trigger', 11, 'p'),
	(2280, 'language_handler_in', 'language_handler', 11, 'p'),
	(2281, 'internal_in', 'internal', 11, 'p'),
	(2283, 'anyelement_in', 'anyelement', 11, 'p'),
	(2776, 'anynonarray_in', 'anynonarray', 11, 'p'),
	(3500, 'anyenum_in', 'anyenum', 11, 'p'),
	(3115, 'fdw_handler_in', 'fdw_handler', 11, 'p'),
	(325, 'index_am_handler_in', 'index_am_handler', 11, 'p'),
	(3310, 'tsm_handler_in', 'tsm_handler', 11, 'p'),
	(269, 'table_am_handler_in', 'table_am_handler', 11, 'p'),
	(3831, 'anyrange_in', 'anyrange', 11, 'p'),
	(5077, 'anycompatible_in', 'anycompatible', 11, 'p'),
	(5078, 'anycompatiblearray_in', 'anycompatiblearray', 11, 'p'),
	(5079, 'anycompatiblenonarray_in', 'anycompatiblenonarray', 11, 'p'),
	(5080, 'anycompatiblerange_in', 'anycompatiblerange', 11, 'p'),
	(4537, 'anymultirange_in', 'anymultirange', 11, 'p'),
	(4538, 'anycompatiblemultirange_in', 'anycompatiblemultirange', 11, 'p'),
	(4600, 'brin_bloom_summary_in', 'pg_brin_bloom_summary', 11, 'b'),
	(4601, 'brin_minmax_multi_summary_in', 'pg_brin_minmax_multi_summary', 11, 'b'),
	(1000, 'array_in', '_bool', 11, 'b'),
	(1001, 'array_in', '_bytea', 11, 'b'),
	(1002, 'array_in', '_char', 11, 'b'),
	(1003, 'array_in', '_name', 11, 'b'),
	(1016, 'array_in', '_int8', 11, 'b'),
	(1005, 'array_in', '_int2', 11, 'b'),
	(1006, 'array_in', '_int2vector', 11, 'b'),
	(1007, 'array_in', '_int4', 11, 'b'),
	(1008, 'array_in', '_regproc', 11, 'b'),
	(1009, 'array_in', '_text', 11, 'b'),
	(1028, 'array_in', '_oid', 11, 'b'),
	(1010, 'array_in', '_tid', 11, 'b'),
	(1011, 'array_in', '_xid', 11, 'b'),
	(1012, 'array_in', '_cid', 11, 'b'),
	(1013, 'array_in', '_oidvector', 11, 'b'),
	(210, 'array_in', '_pg_type', 11, 'b'),
	(270, 'array_in', '_pg_attribute', 11, 'b'),
	(272, 'array_in', '_pg_proc', 11, 'b'),
	(273, 'array_in', '_pg_class', 11, 'b'),
	(199, 'array_in', '_json', 11, 'b'),
	(143, 'array_in', '_xml', 11, 'b'),
	(271, 'array_in', '_xid8', 11, 'b'),
	(1017, 'array_in', '_point', 11, 'b'),
	(1018, 'array_in', '_lseg', 11, 'b'),
	(1019, 'array_in', '_path', 11, 'b'),
	(1020, 'array_in', '_box', 11, 'b'),
	(1027, 'array_in', '_polygon', 11, 'b'),
	(629, 'array_in', '_line', 11, 'b'),
	(1021, 'array_in', '_float4', 11, 'b'),
	(1022, 'array_in', '_float8', 11, 'b'),
	(719, 'array_in', '_circle', 11, 'b'),
	(791, 'array_in', '_money', 11, 'b'),
	(1040, 'array_in', '_macaddr', 11, 'b'),
	(1041, 'array_in', '_inet', 11, 'b'),
	(651, 'array_in', '_cidr', 11, 'b'),
	(775, 'array_in', '_macaddr8', 11, 'b'),
	(1034, 'array_in', '_aclitem', 11, 'b'),
	(1014, 'array_in', '_bpchar', 11, 'b'),
	(1015, 'array_in', '_varchar', 11, 'b'),
	(1182, 'array_in', '_date', 11, 'b'),
	(1183, 'array_in', '_time', 11, 'b'),
	(1115, 'array_in', '_timestamp', 11, 'b'),
	(1185, 'array_in', '_timestamptz', 11, 'b'),
	(1187, 'array_in', '_interval', 11, 'b'),
	(1270, 'array_in', '_timetz', 11, 'b'),
	(1561, 'array_in', '_bit', 11, 'b'),
	(1563, 'array_in', '_varbit', 11, 'b'),
	(1231, 'array_in', '_numeric', 11, 'b'),
	(2201, 'array_in', '_refcursor', 11, 'b'),
	(2207, 'array_in', '_regprocedure', 11, 'b'),
	(2208, 'array_in', '_regoper', 11, 'b'),
	(2209, 'array_in', '_regoperator', 11, 'b'),
	(2210, 'array_in', '_regclass', 11, 'b'),
	(4192, 'array_in', '_regcollation', 11, 'b'),
	(2211, 'array_in', '_regtype', 11, 'b'),
	(4097, 'array_in', '_regrole', 11, 'b'),
	(4090, 'array_in', '_regnamespace', 11, 'b'),
	(2951, 'array_in', '_uuid', 11, 'b'),
	(3221, 'array_in', '_pg_lsn', 11, 'b'),
	(3643, 'array_in', '_tsvector', 11, 'b'),
	(3644, 'array_in', '_gtsvector', 11, 'b'),
	(3645, 'array_in', '_tsquery', 11, 'b'),
	(3735, 'array_in', '_regconfig', 11, 'b'),
	(3770, 'array_in', '_regdictionary', 11, 'b'),
	(3807, 'array_in', '_jsonb', 11, 'b'),
	(4073, 'array_in', '_jsonpath', 11, 'b'),
	(2949, 'array_in', '_txid_snapshot', 11, 'b'),
	(5039, 'array_in', '_pg_snapshot', 11, 'b'),
	(3905, 'array_in', '_int4range', 11, 'b'),
	(3907, 'array_in', '_numrange', 11, 'b'),
	(3909, 'array_in', '_tsrange', 11, 'b'),
	(3911, 'array_in', '_tstzrange', 11, 'b'),
	(3913, 'array_in', '_daterange', 11, 'b'),
	(3927, 'array_in', '_int8range', 11, 'b'),
	(6150, 'array_in', '_int4multirange', 11, 'b'),
	(6151, 'array_in', '_nummultirange', 11, 'b'),
	(6152, 'array_in', '_tsmultirange', 11, 'b'),
	(6153, 'array_in', '_tstzmultirange', 11, 'b'),
	(6155, 'array_in', '_datemultirange', 11, 'b'),
	(6157, 'array_in', '_int8multirange', 11, 'b'),
	(1263, 'array_in', '_cstring', 11, 'b'),
	(12001, 'record_in', 'pg_attrdef', 11, 'c'),
	(12000, 'array_in', '_pg_attrdef', 11, 'b'),
	(12003, 'record_in', 'pg_constraint', 11, 'c'),
	(12002, 'array_in', '_pg_constraint', 11, 'b'),
	(12005, 'record_in', 'pg_inherits', 11, 'c'),
	(12004, 'array_in', '_pg_inherits', 11, 'b'),
	(12007, 'record_in', 'pg_index', 11, 'c'),
	(12006, 'array_in', '_pg_index', 11, 'b'),
	(12009, 'record_in', 'pg_operator', 11, 'c'),
	(12008, 'array_in', '_pg_operator', 11, 'b'),
	(12011, 'record_in', 'pg_opfamily', 11, 'c'),
	(12010, 'array_in', '_pg_opfamily', 11, 'b'),
	(12013, 'record_in', 'pg_opclass', 11, 'c'),
	(12012, 'array_in', '_pg_opclass', 11, 'b'),
	(12015, 'record_in', 'pg_am', 11, 'c'),
	(12014, 'array_in', '_pg_am', 11, 'b'),
	(12017, 'record_in', 'pg_amop', 11, 'c'),
	(12016, 'array_in', '_pg_amop', 11, 'b'),
	(12019, 'record_in', 'pg_amproc', 11, 'c'),
	(12018, 'array_in', '_pg_amproc', 11, 'b'),
	(12021, 'record_in', 'pg_language', 11, 'c'),
	(12020, 'array_in', '_pg_language', 11, 'b'),
	(12023, 'record_in', 'pg_largeobject_metadata', 11, 'c'),
	(12022, 'array_in', '_pg_largeobject_metadata', 11, 'b'),
	(12025, 'record_in', 'pg_largeobject', 11, 'c'),
	(12024, 'array_in', '_pg_largeobject', 11, 'b'),
	(12027, 'record_in', 'pg_aggregate', 11, 'c'),
	(12026, 'array_in', '_pg_aggregate', 11, 'b'),
	(12029, 'record_in', 'pg_statistic', 11, 'c'),
	(12028, 'array_in', '_pg_statistic', 11, 'b'),
	(12031, 'record_in', 'pg_statistic_ext', 11, 'c'),
	(12030, 'array_in', '_pg_statistic_ext', 11, 'b'),
	(12033, 'record_in', 'pg_statistic_ext_data', 11, 'c'),
	(12032, 'array_in', '_pg_statistic_ext_data', 11, 'b'),
	(12035, 'record_in', 'pg_rewrite', 11, 'c'),
	(12034, 'array_in', '_pg_rewrite', 11, 'b'),
	(12037, 'record_in', 'pg_trigger', 11, 'c'),
	(12036, 'array_in', '_pg_trigger', 11, 'b'),
	(12039, 'record_in', 'pg_event_trigger', 11, 'c'),
	(12038, 'array_in', '_pg_event_trigger', 11, 'b'),
	(12041, 'record_in', 'pg_description', 11, 'c'),
	(12040, 'array_in', '_pg_description', 11, 'b'),
	(12043, 'record_in', 'pg_cast', 11, 'c'),
	(12042, 'array_in', '_pg_cast', 11, 'b'),
	(12045, 'record_in', 'pg_enum', 11, 'c'),
	(12044, 'array_in', '_pg_enum', 11, 'b'),
	(12047, 'record_in', 'pg_namespace', 11, 'c'),
	(12046, 'array_in', '_pg_namespace', 11, 'b'),
	(12049, 'record_in', 'pg_conversion', 11, 'c'),
	(12048, 'array_in', '_pg_conversion', 11, 'b'),
	(12051, 'record_in', 'pg_depend', 11, 'c'),
	(12050, 'array_in', '_pg_depend', 11, 'b'),
	(1248, 'record_in', 'pg_database', 11, 'c'),
	(12052, 'array_in', '_pg_database', 11, 'b'),
	(12054, 'record_in', 'pg_db_role_setting', 11, 'c'),
	(12053, 'array_in', '_pg_db_role_setting', 11, 'b'),
	(12056, 'record_in', 'pg_tablespace', 11, 'c'),
	(12055, 'array_in', '_pg_tablespace', 11, 'b'),
	(2842, 'record_in', 'pg_authid', 11, 'c'),
	(12057, 'array_in', '_pg_authid', 11, 'b'),
	(2843, 'record_in', 'pg_auth_members', 11, 'c'),
	(12058, 'array_in', '_pg_auth_members', 11, 'b'),
	(12060, 'record_in', 'pg_shdepend', 11, 'c'),
	(12059, 'array_in', '_pg_shdepend', 11, 'b'),
	(12062, 'record_in', 'pg_shdescription', 11, 'c'),
	(12061, 'array_in', '_pg_shdescription', 11, 'b'),
	(12064, 'record_in', 'pg_ts_config', 11, 'c'),
	(12063, 'array_in', '_pg_ts_config', 11, 'b'),
	(12066, 'record_in', 'pg_ts_config_map', 11, 'c'),
	(12065, 'array_in', '_pg_ts_config_map', 11, 'b'),
	(12068, 'record_in', 'pg_ts_dict', 11, 'c'),
	(12067, 'array_in', '_pg_ts_dict', 11, 'b'),
	(12070, 'record_in', 'pg_ts_parser', 11, 'c'),
	(12069, 'array_in', '_pg_ts_parser', 11, 'b'),
	(12072, 'record_in', 'pg_ts_template', 11, 'c'),
	(12071, 'array_in', '_pg_ts_template', 11, 'b'),
	(12074, 'record_in', 'pg_extension', 11, 'c'),
	(12073, 'array_in', '_pg_extension', 11, 'b'),
	(12076, 'record_in', 'pg_foreign_data_wrapper', 11, 'c'),
	(12075, 'array_in', '_pg_foreign_data_wrapper', 11, 'b'),
	(12078, 'record_in', 'pg_foreign_server', 11, 'c'),
	(12077, 'array_in', '_pg_foreign_server', 11, 'b'),
	(12080, 'record_in', 'pg_user_mapping', 11, 'c'),
	(12079, 'array_in', '_pg_user_mapping', 11, 'b'),
	(12082, 'record_in', 'pg_foreign_table', 11, 'c'),
	(12081, 'array_in', '_pg_foreign_table', 11, 'b'),
	(12084, 'record_in', 'pg_policy', 11, 'c'),
	(12083, 'array_in', '_pg_policy', 11, 'b'),
	(12086, 'record_in', 'pg_replication_origin', 11, 'c'),
	(12085, 'array_in', '_pg_replication_origin', 11, 'b'),
	(12088, 'record_in', 'pg_default_acl', 11, 'c'),
	(12087, 'array_in', '_pg_default_acl', 11, 'b'),
	(12090, 'record_in', 'pg_init_privs', 11, 'c'),
	(12089, 'array_in', '_pg_init_privs', 11, 'b'),
	(12092, 'record_in', 'pg_seclabel', 11, 'c'),
	(12091, 'array_in', '_pg_seclabel', 11, 'b'),
	(4066, 'record_in', 'pg_shseclabel', 11, 'c'),
	(12093, 'array_in', '_pg_shseclabel', 11, 'b'),
	(12095, 'record_in', 'pg_collation', 11, 'c'),
	(12094, 'array_in', '_pg_collation', 11, 'b'),
	(12097, 'record_in', 'pg_partitioned_table', 11, 'c'),
	(12096, 'array_in', '_pg_partitioned_table', 11, 'b'),
	(12099, 'record_in', 'pg_range', 11, 'c'),
	(12098, 'array_in', '_pg_range', 11, 'b'),
	(12101, 'record_in', 'pg_transform', 11, 'c'),
	(12100, 'array_in', '_pg_transform', 11, 'b'),
	(12103, 'record_in', 'pg_sequence', 11, 'c'),
	(12102, 'array_in', '_pg_sequence', 11, 'b'),
	(12105, 'record_in', 'pg_publication', 11, 'c'),
	(12104, 'array_in', '_pg_publication', 11, 'b'),
	(12107, 'record_in', 'pg_publication_rel', 11, 'c'),
	(12106, 'array_in', '_pg_publication_rel', 11, 'b'),
	(6101, 'record_in', 'pg_subscription', 11, 'c'),
	(12108, 'array_in', '_pg_subscription', 11, 'b'),
	(12110, 'record_in', 'pg_subscription_rel', 11, 'c'),
	(12109, 'array_in', '_pg_subscription_rel', 11, 'b'),
	(12219, 'record_in', 'pg_roles', 11, 'c'),
	(12218, 'array_in', '_pg_roles', 11, 'b'),
	(12224, 'record_in', 'pg_shadow', 11, 'c'),
	(12223, 'array_in', '_pg_shadow', 11, 'b'),
	(12229, 'record_in', 'pg_group', 11, 'c'),
	(12228, 'array_in', '_pg_group', 11, 'b'),
	(12233, 'record_in', 'pg_user', 11, 'c'),
	(12232, 'array_in', '_pg_user', 11, 'b'),
	(12237, 'record_in', 'pg_policies', 11, 'c'),
	(12236, 'array_in', '_pg_policies', 11, 'b'),
	(12242, 'record_in', 'pg_rules', 11, 'c'),
	(12241, 'array_in', '_pg_rules', 11, 'b'),
	(12247, 'record_in', 'pg_views', 11, 'c'),
	(12246, 'array_in', '_pg_views', 11, 'b'),
	(12252, 'record_in', 'pg_tables', 11, 'c'),
	(12251, 'array_in', '_pg_tables', 11, 'b'),
	(12257, 'record_in', 'pg_matviews', 11, 'c'),
	(12256, 'array_in', '_pg_matviews', 11, 'b'),
	(12262, 'record_in', 'pg_indexes', 11, 'c'),
	(12261, 'array_in', '_pg_indexes', 11, 'b'),
	(12267, 'record_in', 'pg_sequences', 11, 'c'),
	(12266, 'array_in', '_pg_sequences', 11, 'b'),
	(12272, 'record_in', 'pg_stats', 11, 'c'),
	(12271, 'array_in', '_pg_stats', 11, 'b'),
	(12277, 'record_in', 'pg_stats_ext', 11, 'c'),
	(12276, 'array_in', '_pg_stats_ext', 11, 'b'),
	(12282, 'record_in', 'pg_stats_ext_exprs', 11, 'c'),
	(12281, 'array_in', '_pg_stats_ext_exprs', 11, 'b'),
	(12287, 'record_in', 'pg_publication_tables', 11, 'c'),
	(12286, 'array_in', '_pg_publication_tables', 11, 'b'),
	(12292, 'record_in', 'pg_locks', 11, 'c'),
	(12291, 'array_in', '_pg_locks', 11, 'b'),
	(12296, 'record_in', 'pg_cursors', 11, 'c'),
	(12295, 'array_in', '_pg_cursors', 11, 'b'),
	(12300, 'record_in', 'pg_available_extensions', 11, 'c'),
	(12299, 'array_in', '_pg_available_extensions', 11, 'b'),
	(12304, 'record_in', 'pg_available_extension_versions', 11, 'c'),
	(12303, 'array_in', '_pg_available_extension_versions', 11, 'b'),
	(12309, 'record_in', 'pg_prepared_xacts', 11, 'c'),
	(12308, 'array_in', '_pg_prepared_xacts', 11, 'b'),
	(12314, 'record_in', 'pg_prepared_statements', 11, 'c'),
	(12313, 'array_in', '_pg_prepared_statements', 11, 'b'),
	(12318, 'record_in', 'pg_seclabels', 11, 'c'),
	(12317, 'array_in', '_pg_seclabels', 11, 'b'),
	(12323, 'record_in', 'pg_settings', 11, 'c'),
	(12322, 'array_in', '_pg_settings', 11, 'b'),
	(12329, 'record_in', 'pg_file_settings', 11, 'c'),
	(12328, 'array_in', '_pg_file_settings', 11, 'b'),
	(12333, 'record_in', 'pg_hba_file_rules', 11, 'c'),
	(12332, 'array_in', '_pg_hba_file_rules', 11, 'b'),
	(12337, 'record_in', 'pg_timezone_abbrevs', 11, 'c'),
	(12336, 'array_in', '_pg_timezone_abbrevs', 11, 'b'),
	(12341, 'record_in', 'pg_timezone_names', 11, 'c'),
	(12340, 'array_in', '_pg_timezone_names', 11, 'b'),
	(12345, 'record_in', 'pg_config', 11, 'c'),
	(12344, 'array_in', '_pg_config', 11, 'b'),
	(12349, 'record_in', 'pg_shmem_allocations', 11, 'c'),
	(12348, 'array_in', '_pg_shmem_allocations', 11, 'b'),
	(12353, 'record_in', 'pg_backend_memory_contexts', 11, 'c'),
	(12352, 'array_in', '_pg_backend_memory_contexts', 11, 'b'),
	(12357, 'record_in', 'pg_stat_all_tables', 11, 'c'),
	(12356, 'array_in', '_pg_stat_all_tables', 11, 'b'),
	(12362, 'record_in', 'pg_stat_xact_all_tables', 11, 'c'),
	(12361, 'array_in', '_pg_stat_xact_all_tables', 11, 'b'),
	(12367, 'record_in', 'pg_stat_sys_tables', 11, 'c'),
	(12366, 'array_in', '_pg_stat_sys_tables', 11, 'b'),
	(12372, 'record_in', 'pg_stat_xact_sys_tables', 11, 'c'),
	(12371, 'array_in', '_pg_stat_xact_sys_tables', 11, 'b'),
	(12376, 'record_in', 'pg_stat_user_tables', 11, 'c'),
	(12375, 'array_in', '_pg_stat_user_tables', 11, 'b'),
	(12381, 'record_in', 'pg_stat_xact_user_tables', 11, 'c'),
	(12380, 'array_in', '_pg_stat_xact_user_tables', 11, 'b'),
	(12385, 'record_in', 'pg_statio_all_tables', 11, 'c'),
	(12384, 'array_in', '_pg_statio_all_tables', 11, 'b'),
	(12390, 'record_in', 'pg_statio_sys_tables', 11, 'c'),
	(12389, 'array_in', '_pg_statio_sys_tables', 11, 'b'),
	(12394, 'record_in', 'pg_statio_user_tables', 11, 'c'),
	(12393, 'array_in', '_pg_statio_user_tables', 11, 'b'),
	(12398, 'record_in', 'pg_stat_all_indexes', 11, 'c'),
	(12397, 'array_in', '_pg_stat_all_indexes', 11, 'b'),
	(12403, 'record_in', 'pg_stat_sys_indexes', 11, 'c'),
	(12402, 'array_in', '_pg_stat_sys_indexes', 11, 'b'),
	(12407, 'record_in', 'pg_stat_user_indexes', 11, 'c'),
	(12406, 'array_in', '_pg_stat_user_indexes', 11, 'b'),
	(12411, 'record_in', 'pg_statio_all_indexes', 11, 'c'),
	(12410, 'array_in', '_pg_statio_all_indexes', 11, 'b'),
	(12416, 'record_in', 'pg_statio_sys_indexes', 11, 'c'),
	(12415, 'array_in', '_pg_statio_sys_indexes', 11, 'b'),
	(12420, 'record_in', 'pg_statio_user_indexes', 11, 'c'),
	(12419, 'array_in', '_pg_statio_user_indexes', 11, 'b'),
	(12424, 'record_in', 'pg_statio_all_sequences', 11, 'c'),
	(12423, 'array_in', '_pg_statio_all_sequences', 11, 'b'),
	(12429, 'record_in', 'pg_statio_sys_sequences', 11, 'c'),
	(12428, 'array_in', '_pg_statio_sys_sequences', 11, 'b'),
	(12433, 'record_in', 'pg_statio_user_sequences', 11, 'c'),
	(12432, 'array_in', '_pg_statio_user_sequences', 11, 'b'),
	(12437, 'record_in', 'pg_stat_activity', 11, 'c'),
	(12436, 'array_in', '_pg_stat_activity', 11, 'b'),
	(12442, 'record_in', 'pg_stat_replication', 11, 'c'),
	(12441, 'array_in', '_pg_stat_replication', 11, 'b'),
	(12447, 'record_in', 'pg_stat_slru', 11, 'c'),
	(12446, 'array_in', '_pg_stat_slru', 11, 'b'),
	(12451, 'record_in', 'pg_stat_wal_receiver', 11, 'c'),
	(12450, 'array_in', '_pg_stat_wal_receiver', 11, 'b'),
	(12455, 'record_in', 'pg_stat_subscription', 11, 'c'),
	(12454, 'array_in', '_pg_stat_subscription', 11, 'b'),
	(12460, 'record_in', 'pg_stat_ssl', 11, 'c'),
	(12459, 'array_in', '_pg_stat_ssl', 11, 'b'),
	(12464, 'record_in', 'pg_stat_gssapi', 11, 'c'),
	(12463, 'array_in', '_pg_stat_gssapi', 11, 'b'),
	(12468, 'record_in', 'pg_replication_slots', 11, 'c'),
	(12467, 'array_in', '_pg_replication_slots', 11, 'b'),
	(12473, 'record_in', 'pg_stat_replication_slots', 11, 'c'),
	(12472, 'array_in', '_pg_stat_replication_slots', 11, 'b'),
	(12477, 'record_in', 'pg_stat_database', 11, 'c'),
	(12476, 'array_in', '_pg_stat_database', 11, 'b'),
	(12482, 'record_in', 'pg_stat_database_conflicts', 11, 'c'),
	(12481, 'array_in', '_pg_stat_database_conflicts', 11, 'b'),
	(12486, 'record_in', 'pg_stat_user_functions', 11, 'c'),
	(12485, 'array_in', '_pg_stat_user_functions', 11, 'b'),
	(12491, 'record_in', 'pg_stat_xact_user_functions', 11, 'c'),
	(12490, 'array_in', '_pg_stat_xact_user_functions', 11, 'b'),
	(12496, 'record_in', 'pg_stat_archiver', 11, 'c'),
	(12495, 'array_in', '_pg_stat_archiver', 11, 'b'),
	(12500, 'record_in', 'pg_stat_bgwriter', 11, 'c'),
	(12499, 'array_in', '_pg_stat_bgwriter', 11, 'b'),
	(12504, 'record_in', 'pg_stat_wal', 11, 'c'),
	(12503, 'array_in', '_pg_stat_wal', 11, 'b'),
	(12508, 'record_in', 'pg_stat_progress_analyze', 11, 'c'),
	(12507, 'array_in', '_pg_stat_progress_analyze', 11, 'b'),
	(12513, 'record_in', 'pg_stat_progress_vacuum', 11, 'c'),
	(12512, 'array_in', '_pg_stat_progress_vacuum', 11, 'b'),
	(12518, 'record_in', 'pg_stat_progress_cluster', 11, 'c'),
	(12517, 'array_in', '_pg_stat_progress_cluster', 11, 'b'),
	(12523, 'record_in', 'pg_stat_progress_create_index', 11, 'c'),
	(12522, 'array_in', '_pg_stat_progress_create_index', 11, 'b'),
	(12528, 'record_in', 'pg_stat_progress_basebackup', 11, 'c'),
	(12527, 'array_in', '_pg_stat_progress_basebackup', 11, 'b'),
	(12533, 'record_in', 'pg_stat_progress_copy', 11, 'c'),
	(12532, 'array_in', '_pg_stat_progress_copy', 11, 'b'),
	(12538, 'record_in', 'pg_user_mappings', 11, 'c'),
	(12537, 'array_in', '_pg_user_mappings', 11, 'b'),
	(12543, 'record_in', 'pg_replication_origin_status', 11, 'c'),
	(12542, 'array_in', '_pg_replication_origin_status', 11, 'b'),
	(13405, 'domain_in', 'cardinal_number', 13391, 'd'),
	(13404, 'array_in', '_cardinal_number', 13391, 'b'),
	(13408, 'domain_in', 'character_data', 13391, 'd'),
	(13407, 'array_in', '_character_data', 13391, 'b'),
	(13410, 'domain_in', 'sql_identifier', 13391, 'd'),
	(13409, 'array_in', '_sql_identifier', 13391, 'b'),
	(13413, 'record_in', 'information_schema_catalog_name', 13391, 'c'),
	(13412, 'array_in', '_information_schema_catalog_name', 13391, 'b'),
	(13416, 'domain_in', 'time_stamp', 13391, 'd'),
	(13415, 'array_in', '_time_stamp', 13391, 'b'),
	(13418, 'domain_in', 'yes_or_no', 13391, 'd'),
	(13417, 'array_in', '_yes_or_no', 13391, 'b'),
	(13422, 'record_in', 'applicable_roles', 13391, 'c'),
	(13421, 'array_in', '_applicable_roles', 13391, 'b'),
	(13427, 'record_in', 'administrable_role_authorizations', 13391, 'c'),
	(13426, 'array_in', '_administrable_role_authorizations', 13391, 'b'),
	(13431, 'record_in', 'attributes', 13391, 'c'),
	(13430, 'array_in', '_attributes', 13391, 'b'),
	(13436, 'record_in', 'character_sets', 13391, 'c'),
	(13435, 'array_in', '_character_sets', 13391, 'b'),
	(13441, 'record_in', 'check_constraint_routine_usage', 13391, 'c'),
	(13440, 'array_in', '_check_constraint_routine_usage', 13391, 'b'),
	(13446, 'record_in', 'check_constraints', 13391, 'c'),
	(13445, 'array_in', '_check_constraints', 13391, 'b'),
	(13451, 'record_in', 'collations', 13391, 'c'),
	(13450, 'array_in', '_collations', 13391, 'b'),
	(13456, 'record_in', 'collation_character_set_applicability', 13391, 'c'),
	(13455, 'array_in', '_collation_character_set_applicability', 13391, 'b'),
	(13461, 'record_in', 'column_column_usage', 13391, 'c'),
	(13460, 'array_in', '_column_column_usage', 13391, 'b'),
	(13466, 'record_in', 'column_domain_usage', 13391, 'c'),
	(13465, 'array_in', '_column_domain_usage', 13391, 'b'),
	(13471, 'record_in', 'column_privileges', 13391, 'c'),
	(13470, 'array_in', '_column_privileges', 13391, 'b'),
	(13476, 'record_in', 'column_udt_usage', 13391, 'c'),
	(13475, 'array_in', '_column_udt_usage', 13391, 'b'),
	(13481, 'record_in', 'columns', 13391, 'c'),
	(13480, 'array_in', '_columns', 13391, 'b'),
	(13486, 'record_in', 'constraint_column_usage', 13391, 'c'),
	(13485, 'array_in', '_constraint_column_usage', 13391, 'b'),
	(13491, 'record_in', 'constraint_table_usage', 13391, 'c'),
	(13490, 'array_in', '_constraint_table_usage', 13391, 'b'),
	(13496, 'record_in', 'domain_constraints', 13391, 'c'),
	(13495, 'array_in', '_domain_constraints', 13391, 'b'),
	(13501, 'record_in', 'domain_udt_usage', 13391, 'c'),
	(13500, 'array_in', '_domain_udt_usage', 13391, 'b'),
	(13506, 'record_in', 'domains', 13391, 'c'),
	(13505, 'array_in', '_domains', 13391, 'b'),
	(13511, 'record_in', 'enabled_roles', 13391, 'c'),
	(13510, 'array_in', '_enabled_roles', 13391, 'b'),
	(13515, 'record_in', 'key_column_usage', 13391, 'c'),
	(13514, 'array_in', '_key_column_usage', 13391, 'b'),
	(13520, 'record_in', 'parameters', 13391, 'c'),
	(13519, 'array_in', '_parameters', 13391, 'b'),
	(13525, 'record_in', 'referential_constraints', 13391, 'c'),
	(13524, 'array_in', '_referential_constraints', 13391, 'b'),
	(13530, 'record_in', 'role_column_grants', 13391, 'c'),
	(13529, 'array_in', '_role_column_grants', 13391, 'b'),
	(13534, 'record_in', 'routine_column_usage', 13391, 'c'),
	(13533, 'array_in', '_routine_column_usage', 13391, 'b'),
	(13539, 'record_in', 'routine_privileges', 13391, 'c'),
	(13538, 'array_in', '_routine_privileges', 13391, 'b'),
	(13544, 'record_in', 'role_routine_grants', 13391, 'c'),
	(13543, 'array_in', '_role_routine_grants', 13391, 'b'),
	(13548, 'record_in', 'routine_routine_usage', 13391, 'c'),
	(13547, 'array_in', '_routine_routine_usage', 13391, 'b'),
	(13553, 'record_in', 'routine_sequence_usage', 13391, 'c'),
	(13552, 'array_in', '_routine_sequence_usage', 13391, 'b'),
	(13558, 'record_in', 'routine_table_usage', 13391, 'c'),
	(13557, 'array_in', '_routine_table_usage', 13391, 'b'),
	(13563, 'record_in', 'routines', 13391, 'c'),
	(13562, 'array_in', '_routines', 13391, 'b'),
	(13568, 'record_in', 'schemata', 13391, 'c'),
	(13567, 'array_in', '_schemata', 13391, 'b'),
	(13572, 'record_in', 'sequences', 13391, 'c'),
	(13571, 'array_in', '_sequences', 13391, 'b'),
	(13577, 'record_in', 'sql_features', 13391, 'c'),
	(13576, 'array_in', '_sql_features', 13391, 'b'),
	(13582, 'record_in', 'sql_implementation_info', 13391, 'c'),
	(13581, 'array_in', '_sql_implementation_info', 13391, 'b'),
	(13587, 'record_in', 'sql_parts', 13391, 'c'),
	(13586, 'array_in', '_sql_parts', 13391, 'b'),
	(13592, 'record_in', 'sql_sizing', 13391, 'c'),
	(13591, 'array_in', '_sql_sizing', 13391, 'b'),
	(13597, 'record_in', 'table_constraints', 13391, 'c'),
	(13596, 'array_in', '_table_constraints', 13391, 'b'),
	(13602, 'record_in', 'table_privileges', 13391, 'c'),
	(13601, 'array_in', '_table_privileges', 13391, 'b'),
	(13607, 'record_in', 'role_table_grants', 13391, 'c'),
	(13606, 'array_in', '_role_table_grants', 13391, 'b'),
	(13611, 'record_in', 'tables', 13391, 'c'),
	(13610, 'array_in', '_tables', 13391, 'b'),
	(13616, 'record_in', 'transforms', 13391, 'c'),
	(13615, 'array_in', '_transforms', 13391, 'b'),
	(13621, 'record_in', 'triggered_update_columns', 13391, 'c'),
	(13620, 'array_in', '_triggered_update_columns', 13391, 'b'),
	(13626, 'record_in', 'triggers', 13391, 'c'),
	(13625, 'array_in', '_triggers', 13391, 'b'),
	(13631, 'record_in', 'udt_privileges', 13391, 'c'),
	(13630, 'array_in', '_udt_privileges', 13391, 'b'),
	(13636, 'record_in', 'role_udt_grants', 13391, 'c'),
	(13635, 'array_in', '_role_udt_grants', 13391, 'b'),
	(13640, 'record_in', 'usage_privileges', 13391, 'c'),
	(13639, 'array_in', '_usage_privileges', 13391, 'b'),
	(13645, 'record_in', 'role_usage_grants', 13391, 'c'),
	(13644, 'array_in', '_role_usage_grants', 13391, 'b'),
	(13649, 'record_in', 'user_defined_types', 13391, 'c'),
	(13648, 'array_in', '_user_defined_types', 13391, 'b'),
	(13654, 'record_in', 'view_column_usage', 13391, 'c'),
	(13653, 'array_in', '_view_column_usage', 13391, 'b'),
	(13659, 'record_in', 'view_routine_usage', 13391, 'c'),
	(13658, 'array_in', '_view_routine_usage', 13391, 'b'),
	(13664, 'record_in', 'view_table_usage', 13391, 'c'),
	(13663, 'array_in', '_view_table_usage', 13391, 'b'),
	(13669, 'record_in', 'views', 13391, 'c'),
	(13668, 'array_in', '_views', 13391, 'b'),
	(13674, 'record_in', 'data_type_privileges', 13391, 'c'),
	(13673, 'array_in', '_data_type_privileges', 13391, 'b'),
	(13679, 'record_in', 'element_types', 13391, 'c'),
	(13678, 'array_in', '_element_types', 13391, 'b'),
	(13684, 'record_in', '_pg_foreign_table_columns', 13391, 'c'),
	(13683, 'array_in', '__pg_foreign_table_columns', 13391, 'b'),
	(13689, 'record_in', 'column_options', 13391, 'c'),
	(13688, 'array_in', '_column_options', 13391, 'b'),
	(13693, 'record_in', '_pg_foreign_data_wrappers', 13391, 'c'),
	(13692, 'array_in', '__pg_foreign_data_wrappers', 13391, 'b'),
	(13697, 'record_in', 'foreign_data_wrapper_options', 13391, 'c'),
	(13696, 'array_in', '_foreign_data_wrapper_options', 13391, 'b'),
	(13701, 'record_in', 'foreign_data_wrappers', 13391, 'c'),
	(13700, 'array_in', '_foreign_data_wrappers', 13391, 'b'),
	(13705, 'record_in', '_pg_foreign_servers', 13391, 'c'),
	(13704, 'array_in', '__pg_foreign_servers', 13391, 'b'),
	(13710, 'record_in', 'foreign_server_options', 13391, 'c'),
	(13709, 'array_in', '_foreign_server_options', 13391, 'b'),
	(13714, 'record_in', 'foreign_servers', 13391, 'c'),
	(13713, 'array_in', '_foreign_servers', 13391, 'b'),
	(13718, 'record_in', '_pg_foreign_tables', 13391, 'c'),
	(13717, 'array_in', '__pg_foreign_tables', 13391, 'b'),
	(13723, 'record_in', 'foreign_table_options', 13391, 'c'),
	(13722, 'array_in', '_foreign_table_options', 13391, 'b'),
	(13727, 'record_in', 'foreign_tables', 13391, 'c'),
	(13726, 'array_in', '_foreign_tables', 13391, 'b'),
	(13731, 'record_in', '_pg_user_mappings', 13391, 'c'),
	(13730, 'array_in', '__pg_user_mappings', 13391, 'b'),
	(13736, 'record_in', 'user_mapping_options', 13391, 'c'),
	(13735, 'array_in', '_user_mapping_options', 13391, 'b'),
	(13741, 'record_in', 'user_mappings', 13391, 'c'),
	(13740, 'array_in', '_user_mappings', 13391, 'b');


--
-- PostgreSQL database dump complete
--

