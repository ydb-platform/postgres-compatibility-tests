--
-- PostgreSQL database dump
--

-- Dumped from database version 14.7 (Debian 14.7-1.pgdg110+1)
-- Dumped by pg_dump version 14.11 (Ubuntu 14.11-0ubuntu0.22.04.1)

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

--
-- Data for Name: alert; Type: TABLE DATA; Schema: public; Owner: root
--



--
-- Data for Name: alert_configuration; Type: TABLE DATA; Schema: public; Owner: root
--

INSERT INTO alert_configuration (id, alertmanager_configuration, configuration_version, created_at, "default", org_id, configuration_hash) VALUES
	(1, '{
	"alertmanager_config": {
		"route": {
			"receiver": "grafana-default-email",
			"group_by": ["grafana_folder", "alertname"]
		},
		"receivers": [{
			"name": "grafana-default-email",
			"grafana_managed_receiver_configs": [{
				"uid": "",
				"name": "email receiver",
				"type": "email",
				"isDefault": true,
				"settings": {
					"addresses": "<example@email.com>"
				}
			}]
		}]
	}
}
', 'v1', 1713186195, true, 1, 'e0528a75784033ae7b15c40851d89484');


--
-- Data for Name: alert_configuration_history; Type: TABLE DATA; Schema: public; Owner: root
--

INSERT INTO alert_configuration_history (id, org_id, alertmanager_configuration, configuration_hash, configuration_version, created_at, "default", last_applied) VALUES
	(1, 1, '{
	"alertmanager_config": {
		"route": {
			"receiver": "grafana-default-email",
			"group_by": ["grafana_folder", "alertname"]
		},
		"receivers": [{
			"name": "grafana-default-email",
			"grafana_managed_receiver_configs": [{
				"uid": "",
				"name": "email receiver",
				"type": "email",
				"isDefault": true,
				"settings": {
					"addresses": "<example@email.com>"
				}
			}]
		}]
	}
}
', 'e0528a75784033ae7b15c40851d89484', 'v1', 1713186195, true, 1713186195);


--
-- Data for Name: alert_image; Type: TABLE DATA; Schema: public; Owner: root
--



--
-- Data for Name: alert_instance; Type: TABLE DATA; Schema: public; Owner: root
--



--
-- Data for Name: alert_notification; Type: TABLE DATA; Schema: public; Owner: root
--



--
-- Data for Name: alert_notification_state; Type: TABLE DATA; Schema: public; Owner: root
--



--
-- Data for Name: alert_rule; Type: TABLE DATA; Schema: public; Owner: root
--



--
-- Data for Name: alert_rule_tag; Type: TABLE DATA; Schema: public; Owner: root
--



--
-- Data for Name: alert_rule_version; Type: TABLE DATA; Schema: public; Owner: root
--



--
-- Data for Name: annotation; Type: TABLE DATA; Schema: public; Owner: root
--



--
-- Data for Name: annotation_tag; Type: TABLE DATA; Schema: public; Owner: root
--



--
-- Data for Name: anon_device; Type: TABLE DATA; Schema: public; Owner: root
--



--
-- Data for Name: api_key; Type: TABLE DATA; Schema: public; Owner: root
--



--
-- Data for Name: builtin_role; Type: TABLE DATA; Schema: public; Owner: root
--



--
-- Data for Name: cache_data; Type: TABLE DATA; Schema: public; Owner: root
--



--
-- Data for Name: correlation; Type: TABLE DATA; Schema: public; Owner: root
--



--
-- Data for Name: dashboard; Type: TABLE DATA; Schema: public; Owner: root
--



--
-- Data for Name: dashboard_acl; Type: TABLE DATA; Schema: public; Owner: root
--

INSERT INTO dashboard_acl (id, org_id, dashboard_id, user_id, team_id, permission, role, created, updated) VALUES
	(1, -1, -1, NULL, NULL, 1, 'Viewer', '2017-06-20 00:00:00', '2017-06-20 00:00:00'),
	(2, -1, -1, NULL, NULL, 2, 'Editor', '2017-06-20 00:00:00', '2017-06-20 00:00:00');


--
-- Data for Name: dashboard_provisioning; Type: TABLE DATA; Schema: public; Owner: root
--



--
-- Data for Name: dashboard_public; Type: TABLE DATA; Schema: public; Owner: root
--



--
-- Data for Name: dashboard_snapshot; Type: TABLE DATA; Schema: public; Owner: root
--



--
-- Data for Name: dashboard_tag; Type: TABLE DATA; Schema: public; Owner: root
--



--
-- Data for Name: dashboard_version; Type: TABLE DATA; Schema: public; Owner: root
--



--
-- Data for Name: data_keys; Type: TABLE DATA; Schema: public; Owner: root
--



--
-- Data for Name: data_source; Type: TABLE DATA; Schema: public; Owner: root
--



--
-- Data for Name: entity_event; Type: TABLE DATA; Schema: public; Owner: root
--



--
-- Data for Name: file; Type: TABLE DATA; Schema: public; Owner: root
--



--
-- Data for Name: file_meta; Type: TABLE DATA; Schema: public; Owner: root
--



--
-- Data for Name: folder; Type: TABLE DATA; Schema: public; Owner: root
--



--
-- Data for Name: kv_store; Type: TABLE DATA; Schema: public; Owner: root
--

INSERT INTO kv_store (id, org_id, namespace, key, value, created, updated) VALUES
	(2, 1, 'ngalert.migration', 'stateKey', '{"orgId":1,"migratedDashboards":{},"migratedChannels":{},"createdFolders":null}', '2024-04-15 13:03:15', '2024-04-15 13:03:15'),
	(3, 1, 'ngalert.migration', 'migrated', 'true', '2024-04-15 13:03:15', '2024-04-15 13:03:15'),
	(1, 0, 'ngalert.migration', 'currentAlertingType', 'UnifiedAlerting', '2024-04-15 13:03:14', '2024-04-15 13:03:15.189871'),
	(4, 0, 'datasource', 'secretMigrationStatus', 'compatible', '2024-04-15 13:03:15', '2024-04-15 13:03:15'),
	(5, 0, 'plugin.publickeys', 'key-7e4d0c6a708866e7', '-----BEGIN PGP PUBLIC KEY BLOCK-----
Version: OpenPGP.js v4.10.1
Comment: https://openpgpjs.org

xpMEXpTXXxMFK4EEACMEIwQBiOUQhvGbDLvndE0fEXaR0908wXzPGFpf0P0Z
HJ06tsq+0higIYHp7WTNJVEZtcwoYLcPRGaa9OQqbUU63BEyZdgAkPTz3RFd
5+TkDWZizDcaVFhzbDd500yTwexrpIrdInwC/jrgs7Zy/15h8KA59XXUkdmT
YB6TR+OA9RKME+dCJozNGUdyYWZhbmEgPGVuZ0BncmFmYW5hLmNvbT7CvAQQ
EwoAIAUCXpTXXwYLCQcIAwIEFQgKAgQWAgEAAhkBAhsDAh4BAAoJEH5NDGpw
iGbnaWoCCQGQ3SQnCkRWrG6XrMkXOKfDTX2ow9fuoErN46BeKmLM4f1EkDZQ
Tpq3SE8+My8B5BIH3SOcBeKzi3S57JHGBdFA+wIJAYWMrJNIvw8GeXne+oUo
NzzACdvfqXAZEp/HFMQhCKfEoWGJE8d2YmwY2+3GufVRTI5lQnZOHLE8L/Vc
1S5MXESjzpcEXpTXXxIFK4EEACMEIwQBtHX/SD5Qm3v4V92qpaIZQgtTX0sT
cFPjYWAHqsQ1iENrYN/vg1wU3ADlYATvydOQYvkTyT/tbDvx2Fse8PL84MQA
YKKQ6AJ3gLVvmeouZdU03YoV4MYaT8KbnJUkZQZkqdz2riOlySNI9CG3oYmv
omjUAtzgAgnCcurfGLZkkMxlmY8DAQoJwqQEGBMKAAkFAl6U118CGwwACgkQ
fk0ManCIZuc0jAIJAVw2xdLr4ZQqPUhubrUyFcqlWoW8dQoQagwO8s8ubmby
KuLA9FWJkfuuRQr+O9gHkDVCez3aism7zmJBqIOi38aNAgjJ3bo6leSS2jR/
x5NqiKVi83tiXDPncDQYPymOnMhW0l7CVA7wj75HrFvvlRI/4MArlbsZ2tBn
N1c5v9v/4h6qeA==
=DNbR
-----END PGP PUBLIC KEY BLOCK-----
', '2024-04-15 13:03:15', '2024-04-15 13:03:15'),
	(6, 0, 'plugin.publickeys', 'last_updated', '2024-04-15T13:03:15Z', '2024-04-15 13:03:15', '2024-04-15 13:03:15'),
	(7, 1, 'alertmanager', 'notifications', '', '2024-04-15 13:03:42', '2024-04-15 13:03:42'),
	(8, 1, 'alertmanager', 'silences', '', '2024-04-15 13:03:42', '2024-04-15 13:03:42');


--
-- Data for Name: library_element; Type: TABLE DATA; Schema: public; Owner: root
--



--
-- Data for Name: library_element_connection; Type: TABLE DATA; Schema: public; Owner: root
--



--
-- Data for Name: login_attempt; Type: TABLE DATA; Schema: public; Owner: root
--



--
-- Data for Name: migration_log; Type: TABLE DATA; Schema: public; Owner: root
--

INSERT INTO migration_log (id, migration_id, sql, success, error, "timestamp") VALUES
	(1, 'create migration_log table', 'CREATE TABLE IF NOT EXISTS "migration_log" (
"id" SERIAL PRIMARY KEY  NOT NULL
, "migration_id" VARCHAR(255) NOT NULL
, "sql" TEXT NOT NULL
, "success" BOOL NOT NULL
, "error" TEXT NOT NULL
, "timestamp" TIMESTAMP NOT NULL
);', true, '', '2024-04-15 13:03:12'),
	(2, 'create user table', 'CREATE TABLE IF NOT EXISTS "user" (
"id" SERIAL PRIMARY KEY  NOT NULL
, "version" INTEGER NOT NULL
, "login" VARCHAR(190) NOT NULL
, "email" VARCHAR(190) NOT NULL
, "name" VARCHAR(255) NULL
, "password" VARCHAR(255) NULL
, "salt" VARCHAR(50) NULL
, "rands" VARCHAR(50) NULL
, "company" VARCHAR(255) NULL
, "account_id" BIGINT NOT NULL
, "is_admin" BOOL NOT NULL
, "created" TIMESTAMP NOT NULL
, "updated" TIMESTAMP NOT NULL
);', true, '', '2024-04-15 13:03:12'),
	(3, 'add unique index user.login', 'CREATE UNIQUE INDEX "UQE_user_login" ON "user" ("login");', true, '', '2024-04-15 13:03:12'),
	(4, 'add unique index user.email', 'CREATE UNIQUE INDEX "UQE_user_email" ON "user" ("email");', true, '', '2024-04-15 13:03:12'),
	(5, 'drop index UQE_user_login - v1', 'DROP INDEX "UQE_user_login" CASCADE', true, '', '2024-04-15 13:03:12'),
	(6, 'drop index UQE_user_email - v1', 'DROP INDEX "UQE_user_email" CASCADE', true, '', '2024-04-15 13:03:12'),
	(7, 'Rename table user to user_v1 - v1', 'ALTER TABLE "user" RENAME TO "user_v1"', true, '', '2024-04-15 13:03:12'),
	(8, 'create user table v2', 'CREATE TABLE IF NOT EXISTS "user" (
"id" SERIAL PRIMARY KEY  NOT NULL
, "version" INTEGER NOT NULL
, "login" VARCHAR(190) NOT NULL
, "email" VARCHAR(190) NOT NULL
, "name" VARCHAR(255) NULL
, "password" VARCHAR(255) NULL
, "salt" VARCHAR(50) NULL
, "rands" VARCHAR(50) NULL
, "company" VARCHAR(255) NULL
, "org_id" BIGINT NOT NULL
, "is_admin" BOOL NOT NULL
, "email_verified" BOOL NULL
, "theme" VARCHAR(255) NULL
, "created" TIMESTAMP NOT NULL
, "updated" TIMESTAMP NOT NULL
);', true, '', '2024-04-15 13:03:12'),
	(9, 'create index UQE_user_login - v2', 'CREATE UNIQUE INDEX "UQE_user_login" ON "user" ("login");', true, '', '2024-04-15 13:03:12'),
	(10, 'create index UQE_user_email - v2', 'CREATE UNIQUE INDEX "UQE_user_email" ON "user" ("email");', true, '', '2024-04-15 13:03:12'),
	(11, 'copy data_source v1 to v2', 'INSERT INTO "user" ("company"
, "created"
, "updated"
, "name"
, "password"
, "rands"
, "version"
, "email"
, "salt"
, "is_admin"
, "id"
, "login"
, "org_id") SELECT "company"
, "created"
, "updated"
, "name"
, "password"
, "rands"
, "version"
, "email"
, "salt"
, "is_admin"
, "id"
, "login"
, "account_id" FROM "user_v1"', true, '', '2024-04-15 13:03:12'),
	(12, 'Drop old table user_v1', 'DROP TABLE IF EXISTS "user_v1"', true, '', '2024-04-15 13:03:12'),
	(13, 'Add column help_flags1 to user table', 'alter table "user" ADD COLUMN "help_flags1" BIGINT NOT NULL DEFAULT 0 ', true, '', '2024-04-15 13:03:12'),
	(14, 'Update user table charset', 'ALTER TABLE "user" ALTER "login" TYPE VARCHAR(190), ALTER "email" TYPE VARCHAR(190), ALTER "name" TYPE VARCHAR(255), ALTER "password" TYPE VARCHAR(255), ALTER "salt" TYPE VARCHAR(50), ALTER "rands" TYPE VARCHAR(50), ALTER "company" TYPE VARCHAR(255), ALTER "theme" TYPE VARCHAR(255);', true, '', '2024-04-15 13:03:12'),
	(15, 'Add last_seen_at column to user', 'alter table "user" ADD COLUMN "last_seen_at" TIMESTAMP NULL ', true, '', '2024-04-15 13:03:12'),
	(16, 'Add missing user data', 'code migration', true, '', '2024-04-15 13:03:12'),
	(17, 'Add is_disabled column to user', 'alter table "user" ADD COLUMN "is_disabled" BOOL NOT NULL DEFAULT false ', true, '', '2024-04-15 13:03:12'),
	(18, 'Add index user.login/user.email', 'CREATE INDEX "IDX_user_login_email" ON "user" ("login","email");', true, '', '2024-04-15 13:03:12'),
	(19, 'Add is_service_account column to user', 'alter table "user" ADD COLUMN "is_service_account" BOOL NOT NULL DEFAULT false ', true, '', '2024-04-15 13:03:12'),
	(20, 'Update is_service_account column to nullable', 'ALTER TABLE `user` ALTER COLUMN is_service_account DROP NOT NULL;', true, '', '2024-04-15 13:03:12'),
	(21, 'Add uid column to user', 'alter table "user" ADD COLUMN "uid" VARCHAR(40) NULL ', true, '', '2024-04-15 13:03:12'),
	(22, 'Update uid column values for users', 'UPDATE `user` SET uid=''u'' || lpad('''' || id::text,9,''0'') WHERE uid IS NULL;', true, '', '2024-04-15 13:03:12'),
	(23, 'Add unique index user_uid', 'CREATE UNIQUE INDEX "UQE_user_uid" ON "user" ("uid");', true, '', '2024-04-15 13:03:12'),
	(24, 'update login field with orgid to allow for multiple service accounts with same name across orgs', 'code migration', true, '', '2024-04-15 13:03:12'),
	(25, 'create temp user table v1-7', 'CREATE TABLE IF NOT EXISTS "temp_user" (
"id" SERIAL PRIMARY KEY  NOT NULL
, "org_id" BIGINT NOT NULL
, "version" INTEGER NOT NULL
, "email" VARCHAR(190) NOT NULL
, "name" VARCHAR(255) NULL
, "role" VARCHAR(20) NULL
, "code" VARCHAR(190) NOT NULL
, "status" VARCHAR(20) NOT NULL
, "invited_by_user_id" BIGINT NULL
, "email_sent" BOOL NOT NULL
, "email_sent_on" TIMESTAMP NULL
, "remote_addr" VARCHAR(255) NULL
, "created" TIMESTAMP NOT NULL
, "updated" TIMESTAMP NOT NULL
);', true, '', '2024-04-15 13:03:12'),
	(26, 'create index IDX_temp_user_email - v1-7', 'CREATE INDEX "IDX_temp_user_email" ON "temp_user" ("email");', true, '', '2024-04-15 13:03:12'),
	(27, 'create index IDX_temp_user_org_id - v1-7', 'CREATE INDEX "IDX_temp_user_org_id" ON "temp_user" ("org_id");', true, '', '2024-04-15 13:03:12'),
	(28, 'create index IDX_temp_user_code - v1-7', 'CREATE INDEX "IDX_temp_user_code" ON "temp_user" ("code");', true, '', '2024-04-15 13:03:12'),
	(29, 'create index IDX_temp_user_status - v1-7', 'CREATE INDEX "IDX_temp_user_status" ON "temp_user" ("status");', true, '', '2024-04-15 13:03:12'),
	(30, 'Update temp_user table charset', 'ALTER TABLE "temp_user" ALTER "email" TYPE VARCHAR(190), ALTER "name" TYPE VARCHAR(255), ALTER "role" TYPE VARCHAR(20), ALTER "code" TYPE VARCHAR(190), ALTER "status" TYPE VARCHAR(20), ALTER "remote_addr" TYPE VARCHAR(255);', true, '', '2024-04-15 13:03:12'),
	(31, 'drop index IDX_temp_user_email - v1', 'DROP INDEX "IDX_temp_user_email" CASCADE', true, '', '2024-04-15 13:03:12'),
	(32, 'drop index IDX_temp_user_org_id - v1', 'DROP INDEX "IDX_temp_user_org_id" CASCADE', true, '', '2024-04-15 13:03:12'),
	(33, 'drop index IDX_temp_user_code - v1', 'DROP INDEX "IDX_temp_user_code" CASCADE', true, '', '2024-04-15 13:03:12'),
	(34, 'drop index IDX_temp_user_status - v1', 'DROP INDEX "IDX_temp_user_status" CASCADE', true, '', '2024-04-15 13:03:12'),
	(35, 'Rename table temp_user to temp_user_tmp_qwerty - v1', 'ALTER TABLE "temp_user" RENAME TO "temp_user_tmp_qwerty"', true, '', '2024-04-15 13:03:12'),
	(36, 'create temp_user v2', 'CREATE TABLE IF NOT EXISTS "temp_user" (
"id" SERIAL PRIMARY KEY  NOT NULL
, "org_id" BIGINT NOT NULL
, "version" INTEGER NOT NULL
, "email" VARCHAR(190) NOT NULL
, "name" VARCHAR(255) NULL
, "role" VARCHAR(20) NULL
, "code" VARCHAR(190) NOT NULL
, "status" VARCHAR(20) NOT NULL
, "invited_by_user_id" BIGINT NULL
, "email_sent" BOOL NOT NULL
, "email_sent_on" TIMESTAMP NULL
, "remote_addr" VARCHAR(255) NULL
, "created" INTEGER NOT NULL DEFAULT 0
, "updated" INTEGER NOT NULL DEFAULT 0
);', true, '', '2024-04-15 13:03:12'),
	(37, 'create index IDX_temp_user_email - v2', 'CREATE INDEX "IDX_temp_user_email" ON "temp_user" ("email");', true, '', '2024-04-15 13:03:12'),
	(38, 'create index IDX_temp_user_org_id - v2', 'CREATE INDEX "IDX_temp_user_org_id" ON "temp_user" ("org_id");', true, '', '2024-04-15 13:03:12'),
	(39, 'create index IDX_temp_user_code - v2', 'CREATE INDEX "IDX_temp_user_code" ON "temp_user" ("code");', true, '', '2024-04-15 13:03:12'),
	(40, 'create index IDX_temp_user_status - v2', 'CREATE INDEX "IDX_temp_user_status" ON "temp_user" ("status");', true, '', '2024-04-15 13:03:12'),
	(84, 'Update dashboard title length', 'ALTER TABLE "dashboard" ALTER "title" TYPE VARCHAR(189);', true, '', '2024-04-15 13:03:12'),
	(125, 'drop index UQE_api_key_key - v1', 'DROP INDEX "UQE_api_key_key" CASCADE', true, '', '2024-04-15 13:03:12'),
	(41, 'copy temp_user v1 to v2', 'INSERT INTO "temp_user" ("role"
, "invited_by_user_id"
, "email_sent"
, "email_sent_on"
, "remote_addr"
, "id"
, "version"
, "email"
, "status"
, "org_id"
, "name"
, "code") SELECT "role"
, "invited_by_user_id"
, "email_sent"
, "email_sent_on"
, "remote_addr"
, "id"
, "version"
, "email"
, "status"
, "org_id"
, "name"
, "code" FROM "temp_user_tmp_qwerty"', true, '', '2024-04-15 13:03:12'),
	(42, 'drop temp_user_tmp_qwerty', 'DROP TABLE IF EXISTS "temp_user_tmp_qwerty"', true, '', '2024-04-15 13:03:12'),
	(43, 'Set created for temp users that will otherwise prematurely expire', 'code migration', true, '', '2024-04-15 13:03:12'),
	(44, 'create star table', 'CREATE TABLE IF NOT EXISTS "star" (
"id" SERIAL PRIMARY KEY  NOT NULL
, "user_id" BIGINT NOT NULL
, "dashboard_id" BIGINT NOT NULL
);', true, '', '2024-04-15 13:03:12'),
	(45, 'add unique index star.user_id_dashboard_id', 'CREATE UNIQUE INDEX "UQE_star_user_id_dashboard_id" ON "star" ("user_id","dashboard_id");', true, '', '2024-04-15 13:03:12'),
	(46, 'create org table v1', 'CREATE TABLE IF NOT EXISTS "org" (
"id" SERIAL PRIMARY KEY  NOT NULL
, "version" INTEGER NOT NULL
, "name" VARCHAR(190) NOT NULL
, "address1" VARCHAR(255) NULL
, "address2" VARCHAR(255) NULL
, "city" VARCHAR(255) NULL
, "state" VARCHAR(255) NULL
, "zip_code" VARCHAR(50) NULL
, "country" VARCHAR(255) NULL
, "billing_email" VARCHAR(255) NULL
, "created" TIMESTAMP NOT NULL
, "updated" TIMESTAMP NOT NULL
);', true, '', '2024-04-15 13:03:12'),
	(47, 'create index UQE_org_name - v1', 'CREATE UNIQUE INDEX "UQE_org_name" ON "org" ("name");', true, '', '2024-04-15 13:03:12'),
	(48, 'create org_user table v1', 'CREATE TABLE IF NOT EXISTS "org_user" (
"id" SERIAL PRIMARY KEY  NOT NULL
, "org_id" BIGINT NOT NULL
, "user_id" BIGINT NOT NULL
, "role" VARCHAR(20) NOT NULL
, "created" TIMESTAMP NOT NULL
, "updated" TIMESTAMP NOT NULL
);', true, '', '2024-04-15 13:03:12'),
	(49, 'create index IDX_org_user_org_id - v1', 'CREATE INDEX "IDX_org_user_org_id" ON "org_user" ("org_id");', true, '', '2024-04-15 13:03:12'),
	(50, 'create index UQE_org_user_org_id_user_id - v1', 'CREATE UNIQUE INDEX "UQE_org_user_org_id_user_id" ON "org_user" ("org_id","user_id");', true, '', '2024-04-15 13:03:12'),
	(51, 'create index IDX_org_user_user_id - v1', 'CREATE INDEX "IDX_org_user_user_id" ON "org_user" ("user_id");', true, '', '2024-04-15 13:03:12'),
	(52, 'Update org table charset', 'ALTER TABLE "org" ALTER "name" TYPE VARCHAR(190), ALTER "address1" TYPE VARCHAR(255), ALTER "address2" TYPE VARCHAR(255), ALTER "city" TYPE VARCHAR(255), ALTER "state" TYPE VARCHAR(255), ALTER "zip_code" TYPE VARCHAR(50), ALTER "country" TYPE VARCHAR(255), ALTER "billing_email" TYPE VARCHAR(255);', true, '', '2024-04-15 13:03:12'),
	(53, 'Update org_user table charset', 'ALTER TABLE "org_user" ALTER "role" TYPE VARCHAR(20);', true, '', '2024-04-15 13:03:12'),
	(54, 'Migrate all Read Only Viewers to Viewers', 'UPDATE org_user SET role = ''Viewer'' WHERE role = ''Read Only Editor''', true, '', '2024-04-15 13:03:12'),
	(55, 'create dashboard table', 'CREATE TABLE IF NOT EXISTS "dashboard" (
"id" SERIAL PRIMARY KEY  NOT NULL
, "version" INTEGER NOT NULL
, "slug" VARCHAR(189) NOT NULL
, "title" VARCHAR(255) NOT NULL
, "data" TEXT NOT NULL
, "account_id" BIGINT NOT NULL
, "created" TIMESTAMP NOT NULL
, "updated" TIMESTAMP NOT NULL
);', true, '', '2024-04-15 13:03:12'),
	(56, 'add index dashboard.account_id', 'CREATE INDEX "IDX_dashboard_account_id" ON "dashboard" ("account_id");', true, '', '2024-04-15 13:03:12'),
	(57, 'add unique index dashboard_account_id_slug', 'CREATE UNIQUE INDEX "UQE_dashboard_account_id_slug" ON "dashboard" ("account_id","slug");', true, '', '2024-04-15 13:03:12'),
	(58, 'create dashboard_tag table', 'CREATE TABLE IF NOT EXISTS "dashboard_tag" (
"id" SERIAL PRIMARY KEY  NOT NULL
, "dashboard_id" BIGINT NOT NULL
, "term" VARCHAR(50) NOT NULL
);', true, '', '2024-04-15 13:03:12'),
	(59, 'add unique index dashboard_tag.dasboard_id_term', 'CREATE UNIQUE INDEX "UQE_dashboard_tag_dashboard_id_term" ON "dashboard_tag" ("dashboard_id","term");', true, '', '2024-04-15 13:03:12'),
	(60, 'drop index UQE_dashboard_tag_dashboard_id_term - v1', 'DROP INDEX "UQE_dashboard_tag_dashboard_id_term" CASCADE', true, '', '2024-04-15 13:03:12'),
	(61, 'Rename table dashboard to dashboard_v1 - v1', 'ALTER TABLE "dashboard" RENAME TO "dashboard_v1"', true, '', '2024-04-15 13:03:12'),
	(62, 'create dashboard v2', 'CREATE TABLE IF NOT EXISTS "dashboard" (
"id" SERIAL PRIMARY KEY  NOT NULL
, "version" INTEGER NOT NULL
, "slug" VARCHAR(189) NOT NULL
, "title" VARCHAR(255) NOT NULL
, "data" TEXT NOT NULL
, "org_id" BIGINT NOT NULL
, "created" TIMESTAMP NOT NULL
, "updated" TIMESTAMP NOT NULL
);', true, '', '2024-04-15 13:03:12'),
	(63, 'create index IDX_dashboard_org_id - v2', 'CREATE INDEX "IDX_dashboard_org_id" ON "dashboard" ("org_id");', true, '', '2024-04-15 13:03:12'),
	(64, 'create index UQE_dashboard_org_id_slug - v2', 'CREATE UNIQUE INDEX "UQE_dashboard_org_id_slug" ON "dashboard" ("org_id","slug");', true, '', '2024-04-15 13:03:12'),
	(65, 'copy dashboard v1 to v2', 'INSERT INTO "dashboard" ("slug"
, "title"
, "data"
, "org_id"
, "created"
, "updated"
, "id"
, "version") SELECT "slug"
, "title"
, "data"
, "account_id"
, "created"
, "updated"
, "id"
, "version" FROM "dashboard_v1"', true, '', '2024-04-15 13:03:12'),
	(66, 'drop table dashboard_v1', 'DROP TABLE IF EXISTS "dashboard_v1"', true, '', '2024-04-15 13:03:12'),
	(67, 'alter dashboard.data to mediumtext v1', 'SELECT 0;', true, '', '2024-04-15 13:03:12'),
	(68, 'Add column updated_by in dashboard - v2', 'alter table "dashboard" ADD COLUMN "updated_by" INTEGER NULL ', true, '', '2024-04-15 13:03:12'),
	(69, 'Add column created_by in dashboard - v2', 'alter table "dashboard" ADD COLUMN "created_by" INTEGER NULL ', true, '', '2024-04-15 13:03:12'),
	(70, 'Add column gnetId in dashboard', 'alter table "dashboard" ADD COLUMN "gnet_id" BIGINT NULL ', true, '', '2024-04-15 13:03:12'),
	(71, 'Add index for gnetId in dashboard', 'CREATE INDEX "IDX_dashboard_gnet_id" ON "dashboard" ("gnet_id");', true, '', '2024-04-15 13:03:12'),
	(72, 'Add column plugin_id in dashboard', 'alter table "dashboard" ADD COLUMN "plugin_id" VARCHAR(189) NULL ', true, '', '2024-04-15 13:03:12'),
	(73, 'Add index for plugin_id in dashboard', 'CREATE INDEX "IDX_dashboard_org_id_plugin_id" ON "dashboard" ("org_id","plugin_id");', true, '', '2024-04-15 13:03:12'),
	(74, 'Add index for dashboard_id in dashboard_tag', 'CREATE INDEX "IDX_dashboard_tag_dashboard_id" ON "dashboard_tag" ("dashboard_id");', true, '', '2024-04-15 13:03:12'),
	(75, 'Update dashboard table charset', 'ALTER TABLE "dashboard" ALTER "slug" TYPE VARCHAR(189), ALTER "title" TYPE VARCHAR(255), ALTER "plugin_id" TYPE VARCHAR(189), ALTER "data" TYPE TEXT;', true, '', '2024-04-15 13:03:12'),
	(76, 'Update dashboard_tag table charset', 'ALTER TABLE "dashboard_tag" ALTER "term" TYPE VARCHAR(50);', true, '', '2024-04-15 13:03:12'),
	(77, 'Add column folder_id in dashboard', 'alter table "dashboard" ADD COLUMN "folder_id" BIGINT NOT NULL DEFAULT 0 ', true, '', '2024-04-15 13:03:12'),
	(78, 'Add column isFolder in dashboard', 'alter table "dashboard" ADD COLUMN "is_folder" BOOL NOT NULL DEFAULT false ', true, '', '2024-04-15 13:03:12'),
	(79, 'Add column has_acl in dashboard', 'alter table "dashboard" ADD COLUMN "has_acl" BOOL NOT NULL DEFAULT false ', true, '', '2024-04-15 13:03:12'),
	(80, 'Add column uid in dashboard', 'alter table "dashboard" ADD COLUMN "uid" VARCHAR(40) NULL ', true, '', '2024-04-15 13:03:12'),
	(81, 'Update uid column values in dashboard', 'UPDATE dashboard SET uid=lpad('''' || id::text,9,''0'') WHERE uid IS NULL;', true, '', '2024-04-15 13:03:12'),
	(82, 'Add unique index dashboard_org_id_uid', 'CREATE UNIQUE INDEX "UQE_dashboard_org_id_uid" ON "dashboard" ("org_id","uid");', true, '', '2024-04-15 13:03:12'),
	(83, 'Remove unique index org_id_slug', 'DROP INDEX "UQE_dashboard_org_id_slug" CASCADE', true, '', '2024-04-15 13:03:12'),
	(85, 'Add unique index for dashboard_org_id_title_folder_id', 'CREATE UNIQUE INDEX "UQE_dashboard_org_id_folder_id_title" ON "dashboard" ("org_id","folder_id","title");', true, '', '2024-04-15 13:03:12'),
	(86, 'create dashboard_provisioning', 'CREATE TABLE IF NOT EXISTS "dashboard_provisioning" (
"id" SERIAL PRIMARY KEY  NOT NULL
, "dashboard_id" BIGINT NULL
, "name" VARCHAR(150) NOT NULL
, "external_id" TEXT NOT NULL
, "updated" TIMESTAMP NOT NULL
);', true, '', '2024-04-15 13:03:12'),
	(87, 'Rename table dashboard_provisioning to dashboard_provisioning_tmp_qwerty - v1', 'ALTER TABLE "dashboard_provisioning" RENAME TO "dashboard_provisioning_tmp_qwerty"', true, '', '2024-04-15 13:03:12'),
	(88, 'create dashboard_provisioning v2', 'CREATE TABLE IF NOT EXISTS "dashboard_provisioning" (
"id" SERIAL PRIMARY KEY  NOT NULL
, "dashboard_id" BIGINT NULL
, "name" VARCHAR(150) NOT NULL
, "external_id" TEXT NOT NULL
, "updated" INTEGER NOT NULL DEFAULT 0
);', true, '', '2024-04-15 13:03:12'),
	(89, 'create index IDX_dashboard_provisioning_dashboard_id - v2', 'CREATE INDEX "IDX_dashboard_provisioning_dashboard_id" ON "dashboard_provisioning" ("dashboard_id");', true, '', '2024-04-15 13:03:12'),
	(90, 'create index IDX_dashboard_provisioning_dashboard_id_name - v2', 'CREATE INDEX "IDX_dashboard_provisioning_dashboard_id_name" ON "dashboard_provisioning" ("dashboard_id","name");', true, '', '2024-04-15 13:03:12'),
	(91, 'copy dashboard_provisioning v1 to v2', 'INSERT INTO "dashboard_provisioning" ("id"
, "dashboard_id"
, "name"
, "external_id") SELECT "id"
, "dashboard_id"
, "name"
, "external_id" FROM "dashboard_provisioning_tmp_qwerty"', true, '', '2024-04-15 13:03:12'),
	(92, 'drop dashboard_provisioning_tmp_qwerty', 'DROP TABLE IF EXISTS "dashboard_provisioning_tmp_qwerty"', true, '', '2024-04-15 13:03:12'),
	(93, 'Add check_sum column', 'alter table "dashboard_provisioning" ADD COLUMN "check_sum" VARCHAR(32) NULL ', true, '', '2024-04-15 13:03:12'),
	(94, 'Add index for dashboard_title', 'CREATE INDEX "IDX_dashboard_title" ON "dashboard" ("title");', true, '', '2024-04-15 13:03:12'),
	(95, 'delete tags for deleted dashboards', 'DELETE FROM dashboard_tag WHERE dashboard_id NOT IN (SELECT id FROM dashboard)', true, '', '2024-04-15 13:03:12'),
	(96, 'delete stars for deleted dashboards', 'DELETE FROM star WHERE dashboard_id NOT IN (SELECT id FROM dashboard)', true, '', '2024-04-15 13:03:12'),
	(97, 'Add index for dashboard_is_folder', 'CREATE INDEX "IDX_dashboard_is_folder" ON "dashboard" ("is_folder");', true, '', '2024-04-15 13:03:12'),
	(98, 'Add isPublic for dashboard', 'alter table "dashboard" ADD COLUMN "is_public" BOOL NOT NULL DEFAULT false ', true, '', '2024-04-15 13:03:12'),
	(99, 'create data_source table', 'CREATE TABLE IF NOT EXISTS "data_source" (
"id" SERIAL PRIMARY KEY  NOT NULL
, "account_id" BIGINT NOT NULL
, "version" INTEGER NOT NULL
, "type" VARCHAR(255) NOT NULL
, "name" VARCHAR(190) NOT NULL
, "access" VARCHAR(255) NOT NULL
, "url" VARCHAR(255) NOT NULL
, "password" VARCHAR(255) NULL
, "user" VARCHAR(255) NULL
, "database" VARCHAR(255) NULL
, "basic_auth" BOOL NOT NULL
, "basic_auth_user" VARCHAR(255) NULL
, "basic_auth_password" VARCHAR(255) NULL
, "is_default" BOOL NOT NULL
, "created" TIMESTAMP NOT NULL
, "updated" TIMESTAMP NOT NULL
);', true, '', '2024-04-15 13:03:12'),
	(100, 'add index data_source.account_id', 'CREATE INDEX "IDX_data_source_account_id" ON "data_source" ("account_id");', true, '', '2024-04-15 13:03:12'),
	(101, 'add unique index data_source.account_id_name', 'CREATE UNIQUE INDEX "UQE_data_source_account_id_name" ON "data_source" ("account_id","name");', true, '', '2024-04-15 13:03:12'),
	(102, 'drop index IDX_data_source_account_id - v1', 'DROP INDEX "IDX_data_source_account_id" CASCADE', true, '', '2024-04-15 13:03:12'),
	(103, 'drop index UQE_data_source_account_id_name - v1', 'DROP INDEX "UQE_data_source_account_id_name" CASCADE', true, '', '2024-04-15 13:03:12'),
	(104, 'Rename table data_source to data_source_v1 - v1', 'ALTER TABLE "data_source" RENAME TO "data_source_v1"', true, '', '2024-04-15 13:03:12'),
	(105, 'create data_source table v2', 'CREATE TABLE IF NOT EXISTS "data_source" (
"id" SERIAL PRIMARY KEY  NOT NULL
, "org_id" BIGINT NOT NULL
, "version" INTEGER NOT NULL
, "type" VARCHAR(255) NOT NULL
, "name" VARCHAR(190) NOT NULL
, "access" VARCHAR(255) NOT NULL
, "url" VARCHAR(255) NOT NULL
, "password" VARCHAR(255) NULL
, "user" VARCHAR(255) NULL
, "database" VARCHAR(255) NULL
, "basic_auth" BOOL NOT NULL
, "basic_auth_user" VARCHAR(255) NULL
, "basic_auth_password" VARCHAR(255) NULL
, "is_default" BOOL NOT NULL
, "json_data" TEXT NULL
, "created" TIMESTAMP NOT NULL
, "updated" TIMESTAMP NOT NULL
);', true, '', '2024-04-15 13:03:12'),
	(106, 'create index IDX_data_source_org_id - v2', 'CREATE INDEX "IDX_data_source_org_id" ON "data_source" ("org_id");', true, '', '2024-04-15 13:03:12'),
	(107, 'create index UQE_data_source_org_id_name - v2', 'CREATE UNIQUE INDEX "UQE_data_source_org_id_name" ON "data_source" ("org_id","name");', true, '', '2024-04-15 13:03:12'),
	(108, 'Drop old table data_source_v1 #2', 'DROP TABLE IF EXISTS "data_source_v1"', true, '', '2024-04-15 13:03:12'),
	(109, 'Add column with_credentials', 'alter table "data_source" ADD COLUMN "with_credentials" BOOL NOT NULL DEFAULT false ', true, '', '2024-04-15 13:03:12'),
	(110, 'Add secure json data column', 'alter table "data_source" ADD COLUMN "secure_json_data" TEXT NULL ', true, '', '2024-04-15 13:03:12'),
	(111, 'Update data_source table charset', 'ALTER TABLE "data_source" ALTER "type" TYPE VARCHAR(255), ALTER "name" TYPE VARCHAR(190), ALTER "access" TYPE VARCHAR(255), ALTER "url" TYPE VARCHAR(255), ALTER "password" TYPE VARCHAR(255), ALTER "user" TYPE VARCHAR(255), ALTER "database" TYPE VARCHAR(255), ALTER "basic_auth_user" TYPE VARCHAR(255), ALTER "basic_auth_password" TYPE VARCHAR(255), ALTER "json_data" TYPE TEXT, ALTER "secure_json_data" TYPE TEXT;', true, '', '2024-04-15 13:03:12'),
	(112, 'Update initial version to 1', 'UPDATE data_source SET version = 1 WHERE version = 0', true, '', '2024-04-15 13:03:12'),
	(113, 'Add read_only data column', 'alter table "data_source" ADD COLUMN "read_only" BOOL NULL ', true, '', '2024-04-15 13:03:12'),
	(114, 'Migrate logging ds to loki ds', 'UPDATE data_source SET type = ''loki'' WHERE type = ''logging''', true, '', '2024-04-15 13:03:12'),
	(115, 'Update json_data with nulls', 'UPDATE data_source SET json_data = ''{}'' WHERE json_data is null', true, '', '2024-04-15 13:03:12'),
	(116, 'Add uid column', 'alter table "data_source" ADD COLUMN "uid" VARCHAR(40) NOT NULL DEFAULT 0 ', true, '', '2024-04-15 13:03:12'),
	(117, 'Update uid value', 'UPDATE data_source SET uid=lpad('''' || id::text,9,''0'');', true, '', '2024-04-15 13:03:12'),
	(118, 'Add unique index datasource_org_id_uid', 'CREATE UNIQUE INDEX "UQE_data_source_org_id_uid" ON "data_source" ("org_id","uid");', true, '', '2024-04-15 13:03:12'),
	(119, 'add unique index datasource_org_id_is_default', 'CREATE INDEX "IDX_data_source_org_id_is_default" ON "data_source" ("org_id","is_default");', true, '', '2024-04-15 13:03:12'),
	(120, 'create api_key table', 'CREATE TABLE IF NOT EXISTS "api_key" (
"id" SERIAL PRIMARY KEY  NOT NULL
, "account_id" BIGINT NOT NULL
, "name" VARCHAR(190) NOT NULL
, "key" VARCHAR(64) NOT NULL
, "role" VARCHAR(255) NOT NULL
, "created" TIMESTAMP NOT NULL
, "updated" TIMESTAMP NOT NULL
);', true, '', '2024-04-15 13:03:12'),
	(121, 'add index api_key.account_id', 'CREATE INDEX "IDX_api_key_account_id" ON "api_key" ("account_id");', true, '', '2024-04-15 13:03:12'),
	(122, 'add index api_key.key', 'CREATE UNIQUE INDEX "UQE_api_key_key" ON "api_key" ("key");', true, '', '2024-04-15 13:03:12'),
	(123, 'add index api_key.account_id_name', 'CREATE UNIQUE INDEX "UQE_api_key_account_id_name" ON "api_key" ("account_id","name");', true, '', '2024-04-15 13:03:12'),
	(124, 'drop index IDX_api_key_account_id - v1', 'DROP INDEX "IDX_api_key_account_id" CASCADE', true, '', '2024-04-15 13:03:12'),
	(126, 'drop index UQE_api_key_account_id_name - v1', 'DROP INDEX "UQE_api_key_account_id_name" CASCADE', true, '', '2024-04-15 13:03:12'),
	(127, 'Rename table api_key to api_key_v1 - v1', 'ALTER TABLE "api_key" RENAME TO "api_key_v1"', true, '', '2024-04-15 13:03:12'),
	(128, 'create api_key table v2', 'CREATE TABLE IF NOT EXISTS "api_key" (
"id" SERIAL PRIMARY KEY  NOT NULL
, "org_id" BIGINT NOT NULL
, "name" VARCHAR(190) NOT NULL
, "key" VARCHAR(190) NOT NULL
, "role" VARCHAR(255) NOT NULL
, "created" TIMESTAMP NOT NULL
, "updated" TIMESTAMP NOT NULL
);', true, '', '2024-04-15 13:03:12'),
	(129, 'create index IDX_api_key_org_id - v2', 'CREATE INDEX "IDX_api_key_org_id" ON "api_key" ("org_id");', true, '', '2024-04-15 13:03:12'),
	(130, 'create index UQE_api_key_key - v2', 'CREATE UNIQUE INDEX "UQE_api_key_key" ON "api_key" ("key");', true, '', '2024-04-15 13:03:12'),
	(131, 'create index UQE_api_key_org_id_name - v2', 'CREATE UNIQUE INDEX "UQE_api_key_org_id_name" ON "api_key" ("org_id","name");', true, '', '2024-04-15 13:03:12'),
	(132, 'copy api_key v1 to v2', 'INSERT INTO "api_key" ("role"
, "created"
, "updated"
, "id"
, "org_id"
, "name"
, "key") SELECT "role"
, "created"
, "updated"
, "id"
, "account_id"
, "name"
, "key" FROM "api_key_v1"', true, '', '2024-04-15 13:03:12'),
	(133, 'Drop old table api_key_v1', 'DROP TABLE IF EXISTS "api_key_v1"', true, '', '2024-04-15 13:03:12'),
	(134, 'Update api_key table charset', 'ALTER TABLE "api_key" ALTER "name" TYPE VARCHAR(190), ALTER "key" TYPE VARCHAR(190), ALTER "role" TYPE VARCHAR(255);', true, '', '2024-04-15 13:03:12'),
	(135, 'Add expires to api_key table', 'alter table "api_key" ADD COLUMN "expires" BIGINT NULL ', true, '', '2024-04-15 13:03:12'),
	(136, 'Add service account foreign key', 'alter table "api_key" ADD COLUMN "service_account_id" BIGINT NULL ', true, '', '2024-04-15 13:03:12'),
	(137, 'set service account foreign key to nil if 0', 'UPDATE api_key SET service_account_id = NULL WHERE service_account_id = 0;', true, '', '2024-04-15 13:03:12'),
	(138, 'Add last_used_at to api_key table', 'alter table "api_key" ADD COLUMN "last_used_at" TIMESTAMP NULL ', true, '', '2024-04-15 13:03:12'),
	(139, 'Add is_revoked column to api_key table', 'alter table "api_key" ADD COLUMN "is_revoked" BOOL NULL DEFAULT false ', true, '', '2024-04-15 13:03:12'),
	(140, 'create dashboard_snapshot table v4', 'CREATE TABLE IF NOT EXISTS "dashboard_snapshot" (
"id" SERIAL PRIMARY KEY  NOT NULL
, "name" VARCHAR(255) NOT NULL
, "key" VARCHAR(190) NOT NULL
, "dashboard" TEXT NOT NULL
, "expires" TIMESTAMP NOT NULL
, "created" TIMESTAMP NOT NULL
, "updated" TIMESTAMP NOT NULL
);', true, '', '2024-04-15 13:03:12'),
	(141, 'drop table dashboard_snapshot_v4 #1', 'DROP TABLE IF EXISTS "dashboard_snapshot"', true, '', '2024-04-15 13:03:12'),
	(142, 'create dashboard_snapshot table v5 #2', 'CREATE TABLE IF NOT EXISTS "dashboard_snapshot" (
"id" SERIAL PRIMARY KEY  NOT NULL
, "name" VARCHAR(255) NOT NULL
, "key" VARCHAR(190) NOT NULL
, "delete_key" VARCHAR(190) NOT NULL
, "org_id" BIGINT NOT NULL
, "user_id" BIGINT NOT NULL
, "external" BOOL NOT NULL
, "external_url" VARCHAR(255) NOT NULL
, "dashboard" TEXT NOT NULL
, "expires" TIMESTAMP NOT NULL
, "created" TIMESTAMP NOT NULL
, "updated" TIMESTAMP NOT NULL
);', true, '', '2024-04-15 13:03:12'),
	(143, 'create index UQE_dashboard_snapshot_key - v5', 'CREATE UNIQUE INDEX "UQE_dashboard_snapshot_key" ON "dashboard_snapshot" ("key");', true, '', '2024-04-15 13:03:12'),
	(144, 'create index UQE_dashboard_snapshot_delete_key - v5', 'CREATE UNIQUE INDEX "UQE_dashboard_snapshot_delete_key" ON "dashboard_snapshot" ("delete_key");', true, '', '2024-04-15 13:03:12'),
	(145, 'create index IDX_dashboard_snapshot_user_id - v5', 'CREATE INDEX "IDX_dashboard_snapshot_user_id" ON "dashboard_snapshot" ("user_id");', true, '', '2024-04-15 13:03:12'),
	(146, 'alter dashboard_snapshot to mediumtext v2', 'SELECT 0;', true, '', '2024-04-15 13:03:12'),
	(147, 'Update dashboard_snapshot table charset', 'ALTER TABLE "dashboard_snapshot" ALTER "name" TYPE VARCHAR(255), ALTER "key" TYPE VARCHAR(190), ALTER "delete_key" TYPE VARCHAR(190), ALTER "external_url" TYPE VARCHAR(255), ALTER "dashboard" TYPE TEXT;', true, '', '2024-04-15 13:03:12'),
	(148, 'Add column external_delete_url to dashboard_snapshots table', 'alter table "dashboard_snapshot" ADD COLUMN "external_delete_url" VARCHAR(255) NULL ', true, '', '2024-04-15 13:03:12'),
	(149, 'Add encrypted dashboard json column', 'alter table "dashboard_snapshot" ADD COLUMN "dashboard_encrypted" BYTEA NULL ', true, '', '2024-04-15 13:03:12'),
	(150, 'Change dashboard_encrypted column to MEDIUMBLOB', 'SELECT 0;', true, '', '2024-04-15 13:03:12'),
	(151, 'create quota table v1', 'CREATE TABLE IF NOT EXISTS "quota" (
"id" SERIAL PRIMARY KEY  NOT NULL
, "org_id" BIGINT NULL
, "user_id" BIGINT NULL
, "target" VARCHAR(190) NOT NULL
, "limit" BIGINT NOT NULL
, "created" TIMESTAMP NOT NULL
, "updated" TIMESTAMP NOT NULL
);', true, '', '2024-04-15 13:03:12'),
	(152, 'create index UQE_quota_org_id_user_id_target - v1', 'CREATE UNIQUE INDEX "UQE_quota_org_id_user_id_target" ON "quota" ("org_id","user_id","target");', true, '', '2024-04-15 13:03:12'),
	(153, 'Update quota table charset', 'ALTER TABLE "quota" ALTER "target" TYPE VARCHAR(190);', true, '', '2024-04-15 13:03:12'),
	(154, 'create plugin_setting table', 'CREATE TABLE IF NOT EXISTS "plugin_setting" (
"id" SERIAL PRIMARY KEY  NOT NULL
, "org_id" BIGINT NULL
, "plugin_id" VARCHAR(190) NOT NULL
, "enabled" BOOL NOT NULL
, "pinned" BOOL NOT NULL
, "json_data" TEXT NULL
, "secure_json_data" TEXT NULL
, "created" TIMESTAMP NOT NULL
, "updated" TIMESTAMP NOT NULL
);', true, '', '2024-04-15 13:03:12'),
	(155, 'create index UQE_plugin_setting_org_id_plugin_id - v1', 'CREATE UNIQUE INDEX "UQE_plugin_setting_org_id_plugin_id" ON "plugin_setting" ("org_id","plugin_id");', true, '', '2024-04-15 13:03:12'),
	(156, 'Add column plugin_version to plugin_settings', 'alter table "plugin_setting" ADD COLUMN "plugin_version" VARCHAR(50) NULL ', true, '', '2024-04-15 13:03:12'),
	(157, 'Update plugin_setting table charset', 'ALTER TABLE "plugin_setting" ALTER "plugin_id" TYPE VARCHAR(190), ALTER "json_data" TYPE TEXT, ALTER "secure_json_data" TYPE TEXT, ALTER "plugin_version" TYPE VARCHAR(50);', true, '', '2024-04-15 13:03:12'),
	(158, 'create session table', 'CREATE TABLE IF NOT EXISTS "session" (
"key" CHAR(16) PRIMARY KEY NOT NULL
, "data" BYTEA NOT NULL
, "expiry" INTEGER NOT NULL
);', true, '', '2024-04-15 13:03:12'),
	(159, 'Drop old table playlist table', 'DROP TABLE IF EXISTS "playlist"', true, '', '2024-04-15 13:03:12'),
	(160, 'Drop old table playlist_item table', 'DROP TABLE IF EXISTS "playlist_item"', true, '', '2024-04-15 13:03:12'),
	(161, 'create playlist table v2', 'CREATE TABLE IF NOT EXISTS "playlist" (
"id" SERIAL PRIMARY KEY  NOT NULL
, "name" VARCHAR(255) NOT NULL
, "interval" VARCHAR(255) NOT NULL
, "org_id" BIGINT NOT NULL
);', true, '', '2024-04-15 13:03:12'),
	(162, 'create playlist item table v2', 'CREATE TABLE IF NOT EXISTS "playlist_item" (
"id" SERIAL PRIMARY KEY  NOT NULL
, "playlist_id" BIGINT NOT NULL
, "type" VARCHAR(255) NOT NULL
, "value" TEXT NOT NULL
, "title" TEXT NOT NULL
, "order" INTEGER NOT NULL
);', true, '', '2024-04-15 13:03:12'),
	(163, 'Update playlist table charset', 'ALTER TABLE "playlist" ALTER "name" TYPE VARCHAR(255), ALTER "interval" TYPE VARCHAR(255);', true, '', '2024-04-15 13:03:12'),
	(164, 'Update playlist_item table charset', 'ALTER TABLE "playlist_item" ALTER "type" TYPE VARCHAR(255), ALTER "value" TYPE TEXT, ALTER "title" TYPE TEXT;', true, '', '2024-04-15 13:03:12'),
	(165, 'Add playlist column created_at', 'alter table "playlist" ADD COLUMN "created_at" BIGINT NOT NULL DEFAULT 0 ', true, '', '2024-04-15 13:03:12'),
	(166, 'Add playlist column updated_at', 'alter table "playlist" ADD COLUMN "updated_at" BIGINT NOT NULL DEFAULT 0 ', true, '', '2024-04-15 13:03:13'),
	(167, 'drop preferences table v2', 'DROP TABLE IF EXISTS "preferences"', true, '', '2024-04-15 13:03:13'),
	(168, 'drop preferences table v3', 'DROP TABLE IF EXISTS "preferences"', true, '', '2024-04-15 13:03:13'),
	(169, 'create preferences table v3', 'CREATE TABLE IF NOT EXISTS "preferences" (
"id" SERIAL PRIMARY KEY  NOT NULL
, "org_id" BIGINT NOT NULL
, "user_id" BIGINT NOT NULL
, "version" INTEGER NOT NULL
, "home_dashboard_id" BIGINT NOT NULL
, "timezone" VARCHAR(50) NOT NULL
, "theme" VARCHAR(20) NOT NULL
, "created" TIMESTAMP NOT NULL
, "updated" TIMESTAMP NOT NULL
);', true, '', '2024-04-15 13:03:13'),
	(170, 'Update preferences table charset', 'ALTER TABLE "preferences" ALTER "timezone" TYPE VARCHAR(50), ALTER "theme" TYPE VARCHAR(20);', true, '', '2024-04-15 13:03:13'),
	(171, 'Add column team_id in preferences', 'alter table "preferences" ADD COLUMN "team_id" BIGINT NULL ', true, '', '2024-04-15 13:03:13'),
	(172, 'Update team_id column values in preferences', 'UPDATE preferences SET team_id=0 WHERE team_id IS NULL;', true, '', '2024-04-15 13:03:13'),
	(173, 'Add column week_start in preferences', 'alter table "preferences" ADD COLUMN "week_start" VARCHAR(10) NULL ', true, '', '2024-04-15 13:03:13'),
	(174, 'Add column preferences.json_data', 'alter table "preferences" ADD COLUMN "json_data" TEXT NULL ', true, '', '2024-04-15 13:03:13'),
	(175, 'alter preferences.json_data to mediumtext v1', 'SELECT 0;', true, '', '2024-04-15 13:03:13'),
	(176, 'Add preferences index org_id', 'CREATE INDEX "IDX_preferences_org_id" ON "preferences" ("org_id");', true, '', '2024-04-15 13:03:13'),
	(177, 'Add preferences index user_id', 'CREATE INDEX "IDX_preferences_user_id" ON "preferences" ("user_id");', true, '', '2024-04-15 13:03:13'),
	(178, 'create alert table v1', 'CREATE TABLE IF NOT EXISTS "alert" (
"id" SERIAL PRIMARY KEY  NOT NULL
, "version" BIGINT NOT NULL
, "dashboard_id" BIGINT NOT NULL
, "panel_id" BIGINT NOT NULL
, "org_id" BIGINT NOT NULL
, "name" VARCHAR(255) NOT NULL
, "message" TEXT NOT NULL
, "state" VARCHAR(190) NOT NULL
, "settings" TEXT NOT NULL
, "frequency" BIGINT NOT NULL
, "handler" BIGINT NOT NULL
, "severity" TEXT NOT NULL
, "silenced" BOOL NOT NULL
, "execution_error" TEXT NOT NULL
, "eval_data" TEXT NULL
, "eval_date" TIMESTAMP NULL
, "new_state_date" TIMESTAMP NOT NULL
, "state_changes" INTEGER NOT NULL
, "created" TIMESTAMP NOT NULL
, "updated" TIMESTAMP NOT NULL
);', true, '', '2024-04-15 13:03:13'),
	(179, 'add index alert org_id & id ', 'CREATE INDEX "IDX_alert_org_id_id" ON "alert" ("org_id","id");', true, '', '2024-04-15 13:03:13'),
	(180, 'add index alert state', 'CREATE INDEX "IDX_alert_state" ON "alert" ("state");', true, '', '2024-04-15 13:03:13'),
	(181, 'add index alert dashboard_id', 'CREATE INDEX "IDX_alert_dashboard_id" ON "alert" ("dashboard_id");', true, '', '2024-04-15 13:03:13'),
	(182, 'Create alert_rule_tag table v1', 'CREATE TABLE IF NOT EXISTS "alert_rule_tag" (
"alert_id" BIGINT NOT NULL
, "tag_id" BIGINT NOT NULL
);', true, '', '2024-04-15 13:03:13'),
	(183, 'Add unique index alert_rule_tag.alert_id_tag_id', 'CREATE UNIQUE INDEX "UQE_alert_rule_tag_alert_id_tag_id" ON "alert_rule_tag" ("alert_id","tag_id");', true, '', '2024-04-15 13:03:13'),
	(184, 'drop index UQE_alert_rule_tag_alert_id_tag_id - v1', 'DROP INDEX "UQE_alert_rule_tag_alert_id_tag_id" CASCADE', true, '', '2024-04-15 13:03:13'),
	(185, 'Rename table alert_rule_tag to alert_rule_tag_v1 - v1', 'ALTER TABLE "alert_rule_tag" RENAME TO "alert_rule_tag_v1"', true, '', '2024-04-15 13:03:13'),
	(186, 'Create alert_rule_tag table v2', 'CREATE TABLE IF NOT EXISTS "alert_rule_tag" (
"id" SERIAL PRIMARY KEY  NOT NULL
, "alert_id" BIGINT NOT NULL
, "tag_id" BIGINT NOT NULL
);', true, '', '2024-04-15 13:03:13'),
	(187, 'create index UQE_alert_rule_tag_alert_id_tag_id - Add unique index alert_rule_tag.alert_id_tag_id V2', 'CREATE UNIQUE INDEX "UQE_alert_rule_tag_alert_id_tag_id" ON "alert_rule_tag" ("alert_id","tag_id");', true, '', '2024-04-15 13:03:13'),
	(188, 'copy alert_rule_tag v1 to v2', 'INSERT INTO "alert_rule_tag" ("tag_id"
, "alert_id") SELECT "tag_id"
, "alert_id" FROM "alert_rule_tag_v1"', true, '', '2024-04-15 13:03:13'),
	(189, 'drop table alert_rule_tag_v1', 'DROP TABLE IF EXISTS "alert_rule_tag_v1"', true, '', '2024-04-15 13:03:13'),
	(190, 'create alert_notification table v1', 'CREATE TABLE IF NOT EXISTS "alert_notification" (
"id" SERIAL PRIMARY KEY  NOT NULL
, "org_id" BIGINT NOT NULL
, "name" VARCHAR(190) NOT NULL
, "type" VARCHAR(255) NOT NULL
, "settings" TEXT NOT NULL
, "created" TIMESTAMP NOT NULL
, "updated" TIMESTAMP NOT NULL
);', true, '', '2024-04-15 13:03:13'),
	(191, 'Add column is_default', 'alter table "alert_notification" ADD COLUMN "is_default" BOOL NOT NULL DEFAULT false ', true, '', '2024-04-15 13:03:13'),
	(192, 'Add column frequency', 'alter table "alert_notification" ADD COLUMN "frequency" BIGINT NULL ', true, '', '2024-04-15 13:03:13'),
	(193, 'Add column send_reminder', 'alter table "alert_notification" ADD COLUMN "send_reminder" BOOL NULL DEFAULT false ', true, '', '2024-04-15 13:03:13'),
	(194, 'Add column disable_resolve_message', 'alter table "alert_notification" ADD COLUMN "disable_resolve_message" BOOL NOT NULL DEFAULT false ', true, '', '2024-04-15 13:03:13'),
	(195, 'add index alert_notification org_id & name', 'CREATE UNIQUE INDEX "UQE_alert_notification_org_id_name" ON "alert_notification" ("org_id","name");', true, '', '2024-04-15 13:03:13'),
	(196, 'Update alert table charset', 'ALTER TABLE "alert" ALTER "name" TYPE VARCHAR(255), ALTER "message" TYPE TEXT, ALTER "state" TYPE VARCHAR(190), ALTER "settings" TYPE TEXT, ALTER "severity" TYPE TEXT, ALTER "execution_error" TYPE TEXT, ALTER "eval_data" TYPE TEXT;', true, '', '2024-04-15 13:03:13'),
	(197, 'Update alert_notification table charset', 'ALTER TABLE "alert_notification" ALTER "name" TYPE VARCHAR(190), ALTER "type" TYPE VARCHAR(255), ALTER "settings" TYPE TEXT;', true, '', '2024-04-15 13:03:13'),
	(198, 'create notification_journal table v1', 'CREATE TABLE IF NOT EXISTS "alert_notification_journal" (
"id" SERIAL PRIMARY KEY  NOT NULL
, "org_id" BIGINT NOT NULL
, "alert_id" BIGINT NOT NULL
, "notifier_id" BIGINT NOT NULL
, "sent_at" BIGINT NOT NULL
, "success" BOOL NOT NULL
);', true, '', '2024-04-15 13:03:13'),
	(199, 'add index notification_journal org_id & alert_id & notifier_id', 'CREATE INDEX "IDX_alert_notification_journal_org_id_alert_id_notifier_id" ON "alert_notification_journal" ("org_id","alert_id","notifier_id");', true, '', '2024-04-15 13:03:13'),
	(200, 'drop alert_notification_journal', 'DROP TABLE IF EXISTS "alert_notification_journal"', true, '', '2024-04-15 13:03:13'),
	(201, 'create alert_notification_state table v1', 'CREATE TABLE IF NOT EXISTS "alert_notification_state" (
"id" SERIAL PRIMARY KEY  NOT NULL
, "org_id" BIGINT NOT NULL
, "alert_id" BIGINT NOT NULL
, "notifier_id" BIGINT NOT NULL
, "state" VARCHAR(50) NOT NULL
, "version" BIGINT NOT NULL
, "updated_at" BIGINT NOT NULL
, "alert_rule_state_updated_version" BIGINT NOT NULL
);', true, '', '2024-04-15 13:03:13'),
	(202, 'add index alert_notification_state org_id & alert_id & notifier_id', 'CREATE UNIQUE INDEX "UQE_alert_notification_state_org_id_alert_id_notifier_id" ON "alert_notification_state" ("org_id","alert_id","notifier_id");', true, '', '2024-04-15 13:03:13'),
	(203, 'Add for to alert table', 'alter table "alert" ADD COLUMN "for" BIGINT NULL ', true, '', '2024-04-15 13:03:13'),
	(204, 'Add column uid in alert_notification', 'alter table "alert_notification" ADD COLUMN "uid" VARCHAR(40) NULL ', true, '', '2024-04-15 13:03:13'),
	(205, 'Update uid column values in alert_notification', 'UPDATE alert_notification SET uid=lpad('''' || id::text,9,''0'') WHERE uid IS NULL;', true, '', '2024-04-15 13:03:13'),
	(206, 'Add unique index alert_notification_org_id_uid', 'CREATE UNIQUE INDEX "UQE_alert_notification_org_id_uid" ON "alert_notification" ("org_id","uid");', true, '', '2024-04-15 13:03:13'),
	(207, 'Remove unique index org_id_name', 'DROP INDEX "UQE_alert_notification_org_id_name" CASCADE', true, '', '2024-04-15 13:03:13'),
	(407, 'add column display_name', 'alter table "role" ADD COLUMN "display_name" VARCHAR(190) NULL ', true, '', '2024-04-15 13:03:14'),
	(208, 'Add column secure_settings in alert_notification', 'alter table "alert_notification" ADD COLUMN "secure_settings" TEXT NULL ', true, '', '2024-04-15 13:03:13'),
	(209, 'alter alert.settings to mediumtext', 'SELECT 0;', true, '', '2024-04-15 13:03:13'),
	(210, 'Add non-unique index alert_notification_state_alert_id', 'CREATE INDEX "IDX_alert_notification_state_alert_id" ON "alert_notification_state" ("alert_id");', true, '', '2024-04-15 13:03:13'),
	(211, 'Add non-unique index alert_rule_tag_alert_id', 'CREATE INDEX "IDX_alert_rule_tag_alert_id" ON "alert_rule_tag" ("alert_id");', true, '', '2024-04-15 13:03:13'),
	(212, 'Drop old annotation table v4', 'DROP TABLE IF EXISTS "annotation"', true, '', '2024-04-15 13:03:13'),
	(213, 'create annotation table v5', 'CREATE TABLE IF NOT EXISTS "annotation" (
"id" SERIAL PRIMARY KEY  NOT NULL
, "org_id" BIGINT NOT NULL
, "alert_id" BIGINT NULL
, "user_id" BIGINT NULL
, "dashboard_id" BIGINT NULL
, "panel_id" BIGINT NULL
, "category_id" BIGINT NULL
, "type" VARCHAR(25) NOT NULL
, "title" TEXT NOT NULL
, "text" TEXT NOT NULL
, "metric" VARCHAR(255) NULL
, "prev_state" VARCHAR(25) NOT NULL
, "new_state" VARCHAR(25) NOT NULL
, "data" TEXT NOT NULL
, "epoch" BIGINT NOT NULL
);', true, '', '2024-04-15 13:03:13'),
	(214, 'add index annotation 0 v3', 'CREATE INDEX "IDX_annotation_org_id_alert_id" ON "annotation" ("org_id","alert_id");', true, '', '2024-04-15 13:03:13'),
	(215, 'add index annotation 1 v3', 'CREATE INDEX "IDX_annotation_org_id_type" ON "annotation" ("org_id","type");', true, '', '2024-04-15 13:03:13'),
	(216, 'add index annotation 2 v3', 'CREATE INDEX "IDX_annotation_org_id_category_id" ON "annotation" ("org_id","category_id");', true, '', '2024-04-15 13:03:13'),
	(217, 'add index annotation 3 v3', 'CREATE INDEX "IDX_annotation_org_id_dashboard_id_panel_id_epoch" ON "annotation" ("org_id","dashboard_id","panel_id","epoch");', true, '', '2024-04-15 13:03:13'),
	(218, 'add index annotation 4 v3', 'CREATE INDEX "IDX_annotation_org_id_epoch" ON "annotation" ("org_id","epoch");', true, '', '2024-04-15 13:03:13'),
	(219, 'Update annotation table charset', 'ALTER TABLE "annotation" ALTER "type" TYPE VARCHAR(25), ALTER "title" TYPE TEXT, ALTER "text" TYPE TEXT, ALTER "metric" TYPE VARCHAR(255), ALTER "prev_state" TYPE VARCHAR(25), ALTER "new_state" TYPE VARCHAR(25), ALTER "data" TYPE TEXT;', true, '', '2024-04-15 13:03:13'),
	(220, 'Add column region_id to annotation table', 'alter table "annotation" ADD COLUMN "region_id" BIGINT NULL DEFAULT 0 ', true, '', '2024-04-15 13:03:13'),
	(221, 'Drop category_id index', 'DROP INDEX "IDX_annotation_org_id_category_id" CASCADE', true, '', '2024-04-15 13:03:13'),
	(222, 'Add column tags to annotation table', 'alter table "annotation" ADD COLUMN "tags" VARCHAR(500) NULL ', true, '', '2024-04-15 13:03:13'),
	(223, 'Create annotation_tag table v2', 'CREATE TABLE IF NOT EXISTS "annotation_tag" (
"annotation_id" BIGINT NOT NULL
, "tag_id" BIGINT NOT NULL
);', true, '', '2024-04-15 13:03:13'),
	(224, 'Add unique index annotation_tag.annotation_id_tag_id', 'CREATE UNIQUE INDEX "UQE_annotation_tag_annotation_id_tag_id" ON "annotation_tag" ("annotation_id","tag_id");', true, '', '2024-04-15 13:03:13'),
	(225, 'drop index UQE_annotation_tag_annotation_id_tag_id - v2', 'DROP INDEX "UQE_annotation_tag_annotation_id_tag_id" CASCADE', true, '', '2024-04-15 13:03:13'),
	(226, 'Rename table annotation_tag to annotation_tag_v2 - v2', 'ALTER TABLE "annotation_tag" RENAME TO "annotation_tag_v2"', true, '', '2024-04-15 13:03:13'),
	(227, 'Create annotation_tag table v3', 'CREATE TABLE IF NOT EXISTS "annotation_tag" (
"id" SERIAL PRIMARY KEY  NOT NULL
, "annotation_id" BIGINT NOT NULL
, "tag_id" BIGINT NOT NULL
);', true, '', '2024-04-15 13:03:13'),
	(228, 'create index UQE_annotation_tag_annotation_id_tag_id - Add unique index annotation_tag.annotation_id_tag_id V3', 'CREATE UNIQUE INDEX "UQE_annotation_tag_annotation_id_tag_id" ON "annotation_tag" ("annotation_id","tag_id");', true, '', '2024-04-15 13:03:13'),
	(229, 'copy annotation_tag v2 to v3', 'INSERT INTO "annotation_tag" ("annotation_id"
, "tag_id") SELECT "annotation_id"
, "tag_id" FROM "annotation_tag_v2"', true, '', '2024-04-15 13:03:13'),
	(230, 'drop table annotation_tag_v2', 'DROP TABLE IF EXISTS "annotation_tag_v2"', true, '', '2024-04-15 13:03:13'),
	(231, 'Update alert annotations and set TEXT to empty', 'UPDATE annotation SET TEXT = '''' WHERE alert_id > 0', true, '', '2024-04-15 13:03:13'),
	(232, 'Add created time to annotation table', 'alter table "annotation" ADD COLUMN "created" BIGINT NULL DEFAULT 0 ', true, '', '2024-04-15 13:03:13'),
	(233, 'Add updated time to annotation table', 'alter table "annotation" ADD COLUMN "updated" BIGINT NULL DEFAULT 0 ', true, '', '2024-04-15 13:03:13'),
	(234, 'Add index for created in annotation table', 'CREATE INDEX "IDX_annotation_org_id_created" ON "annotation" ("org_id","created");', true, '', '2024-04-15 13:03:13'),
	(235, 'Add index for updated in annotation table', 'CREATE INDEX "IDX_annotation_org_id_updated" ON "annotation" ("org_id","updated");', true, '', '2024-04-15 13:03:13'),
	(236, 'Convert existing annotations from seconds to milliseconds', 'UPDATE annotation SET epoch = (epoch*1000) where epoch < 9999999999', true, '', '2024-04-15 13:03:13'),
	(237, 'Add epoch_end column', 'alter table "annotation" ADD COLUMN "epoch_end" BIGINT NOT NULL DEFAULT 0 ', true, '', '2024-04-15 13:03:13'),
	(238, 'Add index for epoch_end', 'CREATE INDEX "IDX_annotation_org_id_epoch_epoch_end" ON "annotation" ("org_id","epoch","epoch_end");', true, '', '2024-04-15 13:03:13'),
	(239, 'Make epoch_end the same as epoch', 'UPDATE annotation SET epoch_end = epoch', true, '', '2024-04-15 13:03:13'),
	(240, 'Move region to single row', 'code migration', true, '', '2024-04-15 13:03:13'),
	(241, 'Remove index org_id_epoch from annotation table', 'DROP INDEX "IDX_annotation_org_id_epoch" CASCADE', true, '', '2024-04-15 13:03:13'),
	(242, 'Remove index org_id_dashboard_id_panel_id_epoch from annotation table', 'DROP INDEX "IDX_annotation_org_id_dashboard_id_panel_id_epoch" CASCADE', true, '', '2024-04-15 13:03:13'),
	(243, 'Add index for org_id_dashboard_id_epoch_end_epoch on annotation table', 'CREATE INDEX "IDX_annotation_org_id_dashboard_id_epoch_end_epoch" ON "annotation" ("org_id","dashboard_id","epoch_end","epoch");', true, '', '2024-04-15 13:03:13'),
	(244, 'Add index for org_id_epoch_end_epoch on annotation table', 'CREATE INDEX "IDX_annotation_org_id_epoch_end_epoch" ON "annotation" ("org_id","epoch_end","epoch");', true, '', '2024-04-15 13:03:13'),
	(245, 'Remove index org_id_epoch_epoch_end from annotation table', 'DROP INDEX "IDX_annotation_org_id_epoch_epoch_end" CASCADE', true, '', '2024-04-15 13:03:13'),
	(246, 'Add index for alert_id on annotation table', 'CREATE INDEX "IDX_annotation_alert_id" ON "annotation" ("alert_id");', true, '', '2024-04-15 13:03:13'),
	(247, 'Increase tags column to length 4096', 'ALTER TABLE annotation ALTER COLUMN tags TYPE VARCHAR(4096);', true, '', '2024-04-15 13:03:13'),
	(248, 'create test_data table', 'CREATE TABLE IF NOT EXISTS "test_data" (
"id" SERIAL PRIMARY KEY  NOT NULL
, "metric1" VARCHAR(20) NULL
, "metric2" VARCHAR(150) NULL
, "value_big_int" BIGINT NULL
, "value_double" DOUBLE PRECISION NULL
, "value_float" REAL NULL
, "value_int" INTEGER NULL
, "time_epoch" BIGINT NOT NULL
, "time_date_time" TIMESTAMP NOT NULL
, "time_time_stamp" TIMESTAMP NOT NULL
);', true, '', '2024-04-15 13:03:13'),
	(249, 'create dashboard_version table v1', 'CREATE TABLE IF NOT EXISTS "dashboard_version" (
"id" SERIAL PRIMARY KEY  NOT NULL
, "dashboard_id" BIGINT NOT NULL
, "parent_version" INTEGER NOT NULL
, "restored_from" INTEGER NOT NULL
, "version" INTEGER NOT NULL
, "created" TIMESTAMP NOT NULL
, "created_by" BIGINT NOT NULL
, "message" TEXT NOT NULL
, "data" TEXT NOT NULL
);', true, '', '2024-04-15 13:03:13'),
	(250, 'add index dashboard_version.dashboard_id', 'CREATE INDEX "IDX_dashboard_version_dashboard_id" ON "dashboard_version" ("dashboard_id");', true, '', '2024-04-15 13:03:13'),
	(251, 'add unique index dashboard_version.dashboard_id and dashboard_version.version', 'CREATE UNIQUE INDEX "UQE_dashboard_version_dashboard_id_version" ON "dashboard_version" ("dashboard_id","version");', true, '', '2024-04-15 13:03:13'),
	(252, 'Set dashboard version to 1 where 0', 'UPDATE dashboard SET version = 1 WHERE version = 0', true, '', '2024-04-15 13:03:13'),
	(253, 'save existing dashboard data in dashboard_version table v1', 'INSERT INTO dashboard_version
(
	dashboard_id,
	version,
	parent_version,
	restored_from,
	created,
	created_by,
	message,
	data
)
SELECT
	dashboard.id,
	dashboard.version,
	dashboard.version,
	dashboard.version,
	dashboard.updated,
	COALESCE(dashboard.updated_by, -1),
	'''',
	dashboard.data
FROM dashboard;', true, '', '2024-04-15 13:03:13'),
	(254, 'alter dashboard_version.data to mediumtext v1', 'SELECT 0;', true, '', '2024-04-15 13:03:13'),
	(255, 'create team table', 'CREATE TABLE IF NOT EXISTS "team" (
"id" SERIAL PRIMARY KEY  NOT NULL
, "name" VARCHAR(190) NOT NULL
, "org_id" BIGINT NOT NULL
, "created" TIMESTAMP NOT NULL
, "updated" TIMESTAMP NOT NULL
);', true, '', '2024-04-15 13:03:13'),
	(256, 'add index team.org_id', 'CREATE INDEX "IDX_team_org_id" ON "team" ("org_id");', true, '', '2024-04-15 13:03:13'),
	(257, 'add unique index team_org_id_name', 'CREATE UNIQUE INDEX "UQE_team_org_id_name" ON "team" ("org_id","name");', true, '', '2024-04-15 13:03:13'),
	(258, 'Add column uid in team', 'alter table "team" ADD COLUMN "uid" VARCHAR(40) NULL ', true, '', '2024-04-15 13:03:13'),
	(259, 'Update uid column values in team', 'UPDATE team SET uid=''t'' || lpad('''' || id::text,9,''0'') WHERE uid IS NULL;', true, '', '2024-04-15 13:03:13'),
	(260, 'Add unique index team_org_id_uid', 'CREATE UNIQUE INDEX "UQE_team_org_id_uid" ON "team" ("org_id","uid");', true, '', '2024-04-15 13:03:13'),
	(261, 'create team member table', 'CREATE TABLE IF NOT EXISTS "team_member" (
"id" SERIAL PRIMARY KEY  NOT NULL
, "org_id" BIGINT NOT NULL
, "team_id" BIGINT NOT NULL
, "user_id" BIGINT NOT NULL
, "created" TIMESTAMP NOT NULL
, "updated" TIMESTAMP NOT NULL
);', true, '', '2024-04-15 13:03:13'),
	(262, 'add index team_member.org_id', 'CREATE INDEX "IDX_team_member_org_id" ON "team_member" ("org_id");', true, '', '2024-04-15 13:03:13'),
	(263, 'add unique index team_member_org_id_team_id_user_id', 'CREATE UNIQUE INDEX "UQE_team_member_org_id_team_id_user_id" ON "team_member" ("org_id","team_id","user_id");', true, '', '2024-04-15 13:03:13'),
	(264, 'add index team_member.team_id', 'CREATE INDEX "IDX_team_member_team_id" ON "team_member" ("team_id");', true, '', '2024-04-15 13:03:13'),
	(265, 'Add column email to team table', 'alter table "team" ADD COLUMN "email" VARCHAR(190) NULL ', true, '', '2024-04-15 13:03:13'),
	(266, 'Add column external to team_member table', 'alter table "team_member" ADD COLUMN "external" BOOL NULL ', true, '', '2024-04-15 13:03:13'),
	(267, 'Add column permission to team_member table', 'alter table "team_member" ADD COLUMN "permission" SMALLINT NULL ', true, '', '2024-04-15 13:03:13'),
	(268, 'create dashboard acl table', 'CREATE TABLE IF NOT EXISTS "dashboard_acl" (
"id" SERIAL PRIMARY KEY  NOT NULL
, "org_id" BIGINT NOT NULL
, "dashboard_id" BIGINT NOT NULL
, "user_id" BIGINT NULL
, "team_id" BIGINT NULL
, "permission" SMALLINT NOT NULL DEFAULT 4
, "role" VARCHAR(20) NULL
, "created" TIMESTAMP NOT NULL
, "updated" TIMESTAMP NOT NULL
);', true, '', '2024-04-15 13:03:13'),
	(269, 'add index dashboard_acl_dashboard_id', 'CREATE INDEX "IDX_dashboard_acl_dashboard_id" ON "dashboard_acl" ("dashboard_id");', true, '', '2024-04-15 13:03:13'),
	(270, 'add unique index dashboard_acl_dashboard_id_user_id', 'CREATE UNIQUE INDEX "UQE_dashboard_acl_dashboard_id_user_id" ON "dashboard_acl" ("dashboard_id","user_id");', true, '', '2024-04-15 13:03:13'),
	(271, 'add unique index dashboard_acl_dashboard_id_team_id', 'CREATE UNIQUE INDEX "UQE_dashboard_acl_dashboard_id_team_id" ON "dashboard_acl" ("dashboard_id","team_id");', true, '', '2024-04-15 13:03:13'),
	(272, 'add index dashboard_acl_user_id', 'CREATE INDEX "IDX_dashboard_acl_user_id" ON "dashboard_acl" ("user_id");', true, '', '2024-04-15 13:03:13'),
	(273, 'add index dashboard_acl_team_id', 'CREATE INDEX "IDX_dashboard_acl_team_id" ON "dashboard_acl" ("team_id");', true, '', '2024-04-15 13:03:13'),
	(274, 'add index dashboard_acl_org_id_role', 'CREATE INDEX "IDX_dashboard_acl_org_id_role" ON "dashboard_acl" ("org_id","role");', true, '', '2024-04-15 13:03:13'),
	(275, 'add index dashboard_permission', 'CREATE INDEX "IDX_dashboard_acl_permission" ON "dashboard_acl" ("permission");', true, '', '2024-04-15 13:03:13'),
	(276, 'save default acl rules in dashboard_acl table', '
INSERT INTO dashboard_acl
	(
		org_id,
		dashboard_id,
		permission,
		role,
		created,
		updated
	)
	VALUES
		(-1,-1, 1,''Viewer'',''2017-06-20'',''2017-06-20''),
		(-1,-1, 2,''Editor'',''2017-06-20'',''2017-06-20'')
	', true, '', '2024-04-15 13:03:13'),
	(277, 'delete acl rules for deleted dashboards and folders', 'DELETE FROM dashboard_acl WHERE dashboard_id NOT IN (SELECT id FROM dashboard) AND dashboard_id != -1', true, '', '2024-04-15 13:03:13'),
	(278, 'create tag table', 'CREATE TABLE IF NOT EXISTS "tag" (
"id" SERIAL PRIMARY KEY  NOT NULL
, "key" VARCHAR(100) NOT NULL
, "value" VARCHAR(100) NOT NULL
);', true, '', '2024-04-15 13:03:13'),
	(279, 'add index tag.key_value', 'CREATE UNIQUE INDEX "UQE_tag_key_value" ON "tag" ("key","value");', true, '', '2024-04-15 13:03:13'),
	(280, 'create login attempt table', 'CREATE TABLE IF NOT EXISTS "login_attempt" (
"id" SERIAL PRIMARY KEY  NOT NULL
, "username" VARCHAR(190) NOT NULL
, "ip_address" VARCHAR(30) NOT NULL
, "created" TIMESTAMP NOT NULL
);', true, '', '2024-04-15 13:03:13'),
	(281, 'add index login_attempt.username', 'CREATE INDEX "IDX_login_attempt_username" ON "login_attempt" ("username");', true, '', '2024-04-15 13:03:13'),
	(282, 'drop index IDX_login_attempt_username - v1', 'DROP INDEX "IDX_login_attempt_username" CASCADE', true, '', '2024-04-15 13:03:13'),
	(283, 'Rename table login_attempt to login_attempt_tmp_qwerty - v1', 'ALTER TABLE "login_attempt" RENAME TO "login_attempt_tmp_qwerty"', true, '', '2024-04-15 13:03:13'),
	(284, 'create login_attempt v2', 'CREATE TABLE IF NOT EXISTS "login_attempt" (
"id" SERIAL PRIMARY KEY  NOT NULL
, "username" VARCHAR(190) NOT NULL
, "ip_address" VARCHAR(30) NOT NULL
, "created" INTEGER NOT NULL DEFAULT 0
);', true, '', '2024-04-15 13:03:13'),
	(285, 'create index IDX_login_attempt_username - v2', 'CREATE INDEX "IDX_login_attempt_username" ON "login_attempt" ("username");', true, '', '2024-04-15 13:03:13'),
	(286, 'copy login_attempt v1 to v2', 'INSERT INTO "login_attempt" ("id"
, "username"
, "ip_address") SELECT "id"
, "username"
, "ip_address" FROM "login_attempt_tmp_qwerty"', true, '', '2024-04-15 13:03:13'),
	(287, 'drop login_attempt_tmp_qwerty', 'DROP TABLE IF EXISTS "login_attempt_tmp_qwerty"', true, '', '2024-04-15 13:03:13'),
	(288, 'create user auth table', 'CREATE TABLE IF NOT EXISTS "user_auth" (
"id" SERIAL PRIMARY KEY  NOT NULL
, "user_id" BIGINT NOT NULL
, "auth_module" VARCHAR(190) NOT NULL
, "auth_id" VARCHAR(100) NOT NULL
, "created" TIMESTAMP NOT NULL
);', true, '', '2024-04-15 13:03:13'),
	(289, 'create index IDX_user_auth_auth_module_auth_id - v1', 'CREATE INDEX "IDX_user_auth_auth_module_auth_id" ON "user_auth" ("auth_module","auth_id");', true, '', '2024-04-15 13:03:13'),
	(290, 'alter user_auth.auth_id to length 190', 'ALTER TABLE user_auth ALTER COLUMN auth_id TYPE VARCHAR(190);', true, '', '2024-04-15 13:03:13'),
	(291, 'Add OAuth access token to user_auth', 'alter table "user_auth" ADD COLUMN "o_auth_access_token" TEXT NULL ', true, '', '2024-04-15 13:03:13'),
	(292, 'Add OAuth refresh token to user_auth', 'alter table "user_auth" ADD COLUMN "o_auth_refresh_token" TEXT NULL ', true, '', '2024-04-15 13:03:13'),
	(293, 'Add OAuth token type to user_auth', 'alter table "user_auth" ADD COLUMN "o_auth_token_type" TEXT NULL ', true, '', '2024-04-15 13:03:13'),
	(294, 'Add OAuth expiry to user_auth', 'alter table "user_auth" ADD COLUMN "o_auth_expiry" TIMESTAMP NULL ', true, '', '2024-04-15 13:03:13'),
	(295, 'Add index to user_id column in user_auth', 'CREATE INDEX "IDX_user_auth_user_id" ON "user_auth" ("user_id");', true, '', '2024-04-15 13:03:13'),
	(296, 'Add OAuth ID token to user_auth', 'alter table "user_auth" ADD COLUMN "o_auth_id_token" TEXT NULL ', true, '', '2024-04-15 13:03:13'),
	(297, 'create server_lock table', 'CREATE TABLE IF NOT EXISTS "server_lock" (
"id" SERIAL PRIMARY KEY  NOT NULL
, "operation_uid" VARCHAR(100) NOT NULL
, "version" BIGINT NOT NULL
, "last_execution" BIGINT NOT NULL
);', true, '', '2024-04-15 13:03:13'),
	(298, 'add index server_lock.operation_uid', 'CREATE UNIQUE INDEX "UQE_server_lock_operation_uid" ON "server_lock" ("operation_uid");', true, '', '2024-04-15 13:03:13'),
	(299, 'create user auth token table', 'CREATE TABLE IF NOT EXISTS "user_auth_token" (
"id" SERIAL PRIMARY KEY  NOT NULL
, "user_id" BIGINT NOT NULL
, "auth_token" VARCHAR(100) NOT NULL
, "prev_auth_token" VARCHAR(100) NOT NULL
, "user_agent" VARCHAR(255) NOT NULL
, "client_ip" VARCHAR(255) NOT NULL
, "auth_token_seen" BOOL NOT NULL
, "seen_at" INTEGER NULL
, "rotated_at" INTEGER NOT NULL
, "created_at" INTEGER NOT NULL
, "updated_at" INTEGER NOT NULL
);', true, '', '2024-04-15 13:03:13'),
	(300, 'add unique index user_auth_token.auth_token', 'CREATE UNIQUE INDEX "UQE_user_auth_token_auth_token" ON "user_auth_token" ("auth_token");', true, '', '2024-04-15 13:03:13'),
	(301, 'add unique index user_auth_token.prev_auth_token', 'CREATE UNIQUE INDEX "UQE_user_auth_token_prev_auth_token" ON "user_auth_token" ("prev_auth_token");', true, '', '2024-04-15 13:03:13'),
	(302, 'add index user_auth_token.user_id', 'CREATE INDEX "IDX_user_auth_token_user_id" ON "user_auth_token" ("user_id");', true, '', '2024-04-15 13:03:13'),
	(303, 'Add revoked_at to the user auth token', 'alter table "user_auth_token" ADD COLUMN "revoked_at" INTEGER NULL ', true, '', '2024-04-15 13:03:13'),
	(304, 'add index user_auth_token.revoked_at', 'CREATE INDEX "IDX_user_auth_token_revoked_at" ON "user_auth_token" ("revoked_at");', true, '', '2024-04-15 13:03:13'),
	(305, 'create cache_data table', 'CREATE TABLE IF NOT EXISTS "cache_data" (
"cache_key" VARCHAR(168) PRIMARY KEY NOT NULL
, "data" BYTEA NOT NULL
, "expires" INTEGER NOT NULL
, "created_at" INTEGER NOT NULL
);', true, '', '2024-04-15 13:03:13'),
	(306, 'add unique index cache_data.cache_key', 'CREATE UNIQUE INDEX "UQE_cache_data_cache_key" ON "cache_data" ("cache_key");', true, '', '2024-04-15 13:03:13'),
	(307, 'create short_url table v1', 'CREATE TABLE IF NOT EXISTS "short_url" (
"id" SERIAL PRIMARY KEY  NOT NULL
, "org_id" BIGINT NOT NULL
, "uid" VARCHAR(40) NOT NULL
, "path" TEXT NOT NULL
, "created_by" INTEGER NOT NULL
, "created_at" INTEGER NOT NULL
, "last_seen_at" INTEGER NULL
);', true, '', '2024-04-15 13:03:13'),
	(308, 'add index short_url.org_id-uid', 'CREATE UNIQUE INDEX "UQE_short_url_org_id_uid" ON "short_url" ("org_id","uid");', true, '', '2024-04-15 13:03:13'),
	(309, 'alter table short_url alter column created_by type to bigint', 'ALTER TABLE short_url ALTER COLUMN created_by TYPE BIGINT;', true, '', '2024-04-15 13:03:13'),
	(310, 'delete alert_definition table', 'DROP TABLE IF EXISTS "alert_definition"', true, '', '2024-04-15 13:03:13'),
	(311, 'recreate alert_definition table', 'CREATE TABLE IF NOT EXISTS "alert_definition" (
"id" SERIAL PRIMARY KEY  NOT NULL
, "org_id" BIGINT NOT NULL
, "title" VARCHAR(190) NOT NULL
, "condition" VARCHAR(190) NOT NULL
, "data" TEXT NOT NULL
, "updated" TIMESTAMP NOT NULL
, "interval_seconds" BIGINT NOT NULL DEFAULT 60
, "version" INTEGER NOT NULL DEFAULT 0
, "uid" VARCHAR(40) NOT NULL DEFAULT 0
);', true, '', '2024-04-15 13:03:13'),
	(312, 'add index in alert_definition on org_id and title columns', 'CREATE INDEX "IDX_alert_definition_org_id_title" ON "alert_definition" ("org_id","title");', true, '', '2024-04-15 13:03:13'),
	(313, 'add index in alert_definition on org_id and uid columns', 'CREATE INDEX "IDX_alert_definition_org_id_uid" ON "alert_definition" ("org_id","uid");', true, '', '2024-04-15 13:03:13'),
	(314, 'alter alert_definition table data column to mediumtext in mysql', 'SELECT 0;', true, '', '2024-04-15 13:03:13'),
	(315, 'drop index in alert_definition on org_id and title columns', 'DROP INDEX "IDX_alert_definition_org_id_title" CASCADE', true, '', '2024-04-15 13:03:13'),
	(316, 'drop index in alert_definition on org_id and uid columns', 'DROP INDEX "IDX_alert_definition_org_id_uid" CASCADE', true, '', '2024-04-15 13:03:13'),
	(317, 'add unique index in alert_definition on org_id and title columns', 'CREATE UNIQUE INDEX "UQE_alert_definition_org_id_title" ON "alert_definition" ("org_id","title");', true, '', '2024-04-15 13:03:13'),
	(318, 'add unique index in alert_definition on org_id and uid columns', 'CREATE UNIQUE INDEX "UQE_alert_definition_org_id_uid" ON "alert_definition" ("org_id","uid");', true, '', '2024-04-15 13:03:13'),
	(319, 'Add column paused in alert_definition', 'alter table "alert_definition" ADD COLUMN "paused" BOOL NOT NULL DEFAULT false ', true, '', '2024-04-15 13:03:13'),
	(320, 'drop alert_definition table', 'DROP TABLE IF EXISTS "alert_definition"', true, '', '2024-04-15 13:03:13'),
	(321, 'delete alert_definition_version table', 'DROP TABLE IF EXISTS "alert_definition_version"', true, '', '2024-04-15 13:03:13'),
	(322, 'recreate alert_definition_version table', 'CREATE TABLE IF NOT EXISTS "alert_definition_version" (
"id" SERIAL PRIMARY KEY  NOT NULL
, "alert_definition_id" BIGINT NOT NULL
, "alert_definition_uid" VARCHAR(40) NOT NULL DEFAULT 0
, "parent_version" INTEGER NOT NULL
, "restored_from" INTEGER NOT NULL
, "version" INTEGER NOT NULL
, "created" TIMESTAMP NOT NULL
, "title" VARCHAR(190) NOT NULL
, "condition" VARCHAR(190) NOT NULL
, "data" TEXT NOT NULL
, "interval_seconds" BIGINT NOT NULL
);', true, '', '2024-04-15 13:03:13'),
	(323, 'add index in alert_definition_version table on alert_definition_id and version columns', 'CREATE UNIQUE INDEX "UQE_alert_definition_version_alert_definition_id_version" ON "alert_definition_version" ("alert_definition_id","version");', true, '', '2024-04-15 13:03:13'),
	(324, 'add index in alert_definition_version table on alert_definition_uid and version columns', 'CREATE UNIQUE INDEX "UQE_alert_definition_version_alert_definition_uid_version" ON "alert_definition_version" ("alert_definition_uid","version");', true, '', '2024-04-15 13:03:13'),
	(325, 'alter alert_definition_version table data column to mediumtext in mysql', 'SELECT 0;', true, '', '2024-04-15 13:03:13'),
	(326, 'drop alert_definition_version table', 'DROP TABLE IF EXISTS "alert_definition_version"', true, '', '2024-04-15 13:03:13'),
	(327, 'create alert_instance table', 'CREATE TABLE IF NOT EXISTS "alert_instance" (
"def_org_id" BIGINT NOT NULL
, "def_uid" VARCHAR(40) NOT NULL DEFAULT 0
, "labels" TEXT NOT NULL
, "labels_hash" VARCHAR(190) NOT NULL
, "current_state" VARCHAR(190) NOT NULL
, "current_state_since" BIGINT NOT NULL
, "last_eval_time" BIGINT NOT NULL
, PRIMARY KEY ( "def_org_id","def_uid","labels_hash" ));', true, '', '2024-04-15 13:03:13'),
	(328, 'add index in alert_instance table on def_org_id, def_uid and current_state columns', 'CREATE INDEX "IDX_alert_instance_def_org_id_def_uid_current_state" ON "alert_instance" ("def_org_id","def_uid","current_state");', true, '', '2024-04-15 13:03:13'),
	(329, 'add index in alert_instance table on def_org_id, current_state columns', 'CREATE INDEX "IDX_alert_instance_def_org_id_current_state" ON "alert_instance" ("def_org_id","current_state");', true, '', '2024-04-15 13:03:13'),
	(330, 'add column current_state_end to alert_instance', 'alter table "alert_instance" ADD COLUMN "current_state_end" BIGINT NOT NULL DEFAULT 0 ', true, '', '2024-04-15 13:03:13'),
	(331, 'remove index def_org_id, def_uid, current_state on alert_instance', 'DROP INDEX "IDX_alert_instance_def_org_id_def_uid_current_state" CASCADE', true, '', '2024-04-15 13:03:13'),
	(332, 'remove index def_org_id, current_state on alert_instance', 'DROP INDEX "IDX_alert_instance_def_org_id_current_state" CASCADE', true, '', '2024-04-15 13:03:13'),
	(333, 'rename def_org_id to rule_org_id in alert_instance', 'ALTER TABLE alert_instance RENAME COLUMN def_org_id TO rule_org_id;', true, '', '2024-04-15 13:03:13'),
	(334, 'rename def_uid to rule_uid in alert_instance', 'ALTER TABLE alert_instance RENAME COLUMN def_uid TO rule_uid;', true, '', '2024-04-15 13:03:13'),
	(335, 'add index rule_org_id, rule_uid, current_state on alert_instance', 'CREATE INDEX "IDX_alert_instance_rule_org_id_rule_uid_current_state" ON "alert_instance" ("rule_org_id","rule_uid","current_state");', true, '', '2024-04-15 13:03:13'),
	(336, 'add index rule_org_id, current_state on alert_instance', 'CREATE INDEX "IDX_alert_instance_rule_org_id_current_state" ON "alert_instance" ("rule_org_id","current_state");', true, '', '2024-04-15 13:03:13'),
	(337, 'add current_reason column related to current_state', 'alter table "alert_instance" ADD COLUMN "current_reason" VARCHAR(190) NULL ', true, '', '2024-04-15 13:03:13'),
	(338, 'add result_fingerprint column to alert_instance', 'alter table "alert_instance" ADD COLUMN "result_fingerprint" VARCHAR(16) NULL ', true, '', '2024-04-15 13:03:13'),
	(339, 'create alert_rule table', 'CREATE TABLE IF NOT EXISTS "alert_rule" (
"id" SERIAL PRIMARY KEY  NOT NULL
, "org_id" BIGINT NOT NULL
, "title" VARCHAR(190) NOT NULL
, "condition" VARCHAR(190) NOT NULL
, "data" TEXT NOT NULL
, "updated" TIMESTAMP NOT NULL
, "interval_seconds" BIGINT NOT NULL DEFAULT 60
, "version" INTEGER NOT NULL DEFAULT 0
, "uid" VARCHAR(40) NOT NULL DEFAULT 0
, "namespace_uid" VARCHAR(40) NOT NULL
, "rule_group" VARCHAR(190) NOT NULL
, "no_data_state" VARCHAR(15) NOT NULL DEFAULT ''NoData''
, "exec_err_state" VARCHAR(15) NOT NULL DEFAULT ''Alerting''
);', true, '', '2024-04-15 13:03:13'),
	(340, 'add index in alert_rule on org_id and title columns', 'CREATE UNIQUE INDEX "UQE_alert_rule_org_id_title" ON "alert_rule" ("org_id","title");', true, '', '2024-04-15 13:03:13'),
	(341, 'add index in alert_rule on org_id and uid columns', 'CREATE UNIQUE INDEX "UQE_alert_rule_org_id_uid" ON "alert_rule" ("org_id","uid");', true, '', '2024-04-15 13:03:13'),
	(342, 'add index in alert_rule on org_id, namespace_uid, group_uid columns', 'CREATE INDEX "IDX_alert_rule_org_id_namespace_uid_rule_group" ON "alert_rule" ("org_id","namespace_uid","rule_group");', true, '', '2024-04-15 13:03:13'),
	(343, 'alter alert_rule table data column to mediumtext in mysql', 'SELECT 0;', true, '', '2024-04-15 13:03:13'),
	(344, 'add column for to alert_rule', 'alter table "alert_rule" ADD COLUMN "for" BIGINT NOT NULL DEFAULT 0 ', true, '', '2024-04-15 13:03:13'),
	(345, 'add column annotations to alert_rule', 'alter table "alert_rule" ADD COLUMN "annotations" TEXT NULL ', true, '', '2024-04-15 13:03:13'),
	(346, 'add column labels to alert_rule', 'alter table "alert_rule" ADD COLUMN "labels" TEXT NULL ', true, '', '2024-04-15 13:03:13'),
	(347, 'remove unique index from alert_rule on org_id, title columns', 'DROP INDEX "UQE_alert_rule_org_id_title" CASCADE', true, '', '2024-04-15 13:03:13'),
	(348, 'add index in alert_rule on org_id, namespase_uid and title columns', 'CREATE UNIQUE INDEX "UQE_alert_rule_org_id_namespace_uid_title" ON "alert_rule" ("org_id","namespace_uid","title");', true, '', '2024-04-15 13:03:13'),
	(349, 'add dashboard_uid column to alert_rule', 'alter table "alert_rule" ADD COLUMN "dashboard_uid" VARCHAR(40) NULL ', true, '', '2024-04-15 13:03:14'),
	(350, 'add panel_id column to alert_rule', 'alter table "alert_rule" ADD COLUMN "panel_id" BIGINT NULL ', true, '', '2024-04-15 13:03:14'),
	(351, 'add index in alert_rule on org_id, dashboard_uid and panel_id columns', 'CREATE INDEX "IDX_alert_rule_org_id_dashboard_uid_panel_id" ON "alert_rule" ("org_id","dashboard_uid","panel_id");', true, '', '2024-04-15 13:03:14'),
	(352, 'add rule_group_idx column to alert_rule', 'alter table "alert_rule" ADD COLUMN "rule_group_idx" INTEGER NOT NULL DEFAULT 1 ', true, '', '2024-04-15 13:03:14'),
	(353, 'add is_paused column to alert_rule table', 'alter table "alert_rule" ADD COLUMN "is_paused" BOOL NOT NULL DEFAULT false ', true, '', '2024-04-15 13:03:14'),
	(354, 'fix is_paused column for alert_rule table', 'ALTER TABLE alert_rule ALTER COLUMN is_paused SET DEFAULT false;
UPDATE alert_rule SET is_paused = false;', true, '', '2024-04-15 13:03:14'),
	(355, 'create alert_rule_version table', 'CREATE TABLE IF NOT EXISTS "alert_rule_version" (
"id" SERIAL PRIMARY KEY  NOT NULL
, "rule_org_id" BIGINT NOT NULL
, "rule_uid" VARCHAR(40) NOT NULL DEFAULT 0
, "rule_namespace_uid" VARCHAR(40) NOT NULL
, "rule_group" VARCHAR(190) NOT NULL
, "parent_version" INTEGER NOT NULL
, "restored_from" INTEGER NOT NULL
, "version" INTEGER NOT NULL
, "created" TIMESTAMP NOT NULL
, "title" VARCHAR(190) NOT NULL
, "condition" VARCHAR(190) NOT NULL
, "data" TEXT NOT NULL
, "interval_seconds" BIGINT NOT NULL
, "no_data_state" VARCHAR(15) NOT NULL DEFAULT ''NoData''
, "exec_err_state" VARCHAR(15) NOT NULL DEFAULT ''Alerting''
);', true, '', '2024-04-15 13:03:14'),
	(356, 'add index in alert_rule_version table on rule_org_id, rule_uid and version columns', 'CREATE UNIQUE INDEX "UQE_alert_rule_version_rule_org_id_rule_uid_version" ON "alert_rule_version" ("rule_org_id","rule_uid","version");', true, '', '2024-04-15 13:03:14'),
	(357, 'add index in alert_rule_version table on rule_org_id, rule_namespace_uid and rule_group columns', 'CREATE INDEX "IDX_alert_rule_version_rule_org_id_rule_namespace_uid_rule_group" ON "alert_rule_version" ("rule_org_id","rule_namespace_uid","rule_group");', true, '', '2024-04-15 13:03:14'),
	(358, 'alter alert_rule_version table data column to mediumtext in mysql', 'SELECT 0;', true, '', '2024-04-15 13:03:14'),
	(359, 'add column for to alert_rule_version', 'alter table "alert_rule_version" ADD COLUMN "for" BIGINT NOT NULL DEFAULT 0 ', true, '', '2024-04-15 13:03:14'),
	(360, 'add column annotations to alert_rule_version', 'alter table "alert_rule_version" ADD COLUMN "annotations" TEXT NULL ', true, '', '2024-04-15 13:03:14'),
	(361, 'add column labels to alert_rule_version', 'alter table "alert_rule_version" ADD COLUMN "labels" TEXT NULL ', true, '', '2024-04-15 13:03:14'),
	(362, 'add rule_group_idx column to alert_rule_version', 'alter table "alert_rule_version" ADD COLUMN "rule_group_idx" INTEGER NOT NULL DEFAULT 1 ', true, '', '2024-04-15 13:03:14'),
	(363, 'add is_paused column to alert_rule_versions table', 'alter table "alert_rule_version" ADD COLUMN "is_paused" BOOL NOT NULL DEFAULT false ', true, '', '2024-04-15 13:03:14'),
	(364, 'fix is_paused column for alert_rule_version table', 'ALTER TABLE alert_rule_version ALTER COLUMN is_paused SET DEFAULT false;
UPDATE alert_rule_version SET is_paused = false;', true, '', '2024-04-15 13:03:14'),
	(365, 'create_alert_configuration_table', 'CREATE TABLE IF NOT EXISTS "alert_configuration" (
"id" SERIAL PRIMARY KEY  NOT NULL
, "alertmanager_configuration" TEXT NOT NULL
, "configuration_version" VARCHAR(3) NOT NULL
, "created_at" INTEGER NOT NULL
);', true, '', '2024-04-15 13:03:14'),
	(366, 'Add column default in alert_configuration', 'alter table "alert_configuration" ADD COLUMN "default" BOOL NOT NULL DEFAULT false ', true, '', '2024-04-15 13:03:14'),
	(367, 'alert alert_configuration alertmanager_configuration column from TEXT to MEDIUMTEXT if mysql', 'SELECT 0;', true, '', '2024-04-15 13:03:14'),
	(368, 'add column org_id in alert_configuration', 'alter table "alert_configuration" ADD COLUMN "org_id" BIGINT NOT NULL DEFAULT 0 ', true, '', '2024-04-15 13:03:14'),
	(369, 'add index in alert_configuration table on org_id column', 'CREATE INDEX "IDX_alert_configuration_org_id" ON "alert_configuration" ("org_id");', true, '', '2024-04-15 13:03:14'),
	(370, 'add configuration_hash column to alert_configuration', 'alter table "alert_configuration" ADD COLUMN "configuration_hash" VARCHAR(32) NOT NULL DEFAULT ''not-yet-calculated'' ', true, '', '2024-04-15 13:03:14'),
	(371, 'create_ngalert_configuration_table', 'CREATE TABLE IF NOT EXISTS "ngalert_configuration" (
"id" SERIAL PRIMARY KEY  NOT NULL
, "org_id" BIGINT NOT NULL
, "alertmanagers" TEXT NULL
, "created_at" INTEGER NOT NULL
, "updated_at" INTEGER NOT NULL
);', true, '', '2024-04-15 13:03:14'),
	(372, 'add index in ngalert_configuration on org_id column', 'CREATE UNIQUE INDEX "UQE_ngalert_configuration_org_id" ON "ngalert_configuration" ("org_id");', true, '', '2024-04-15 13:03:14'),
	(373, 'add column send_alerts_to in ngalert_configuration', 'alter table "ngalert_configuration" ADD COLUMN "send_alerts_to" SMALLINT NOT NULL DEFAULT 0 ', true, '', '2024-04-15 13:03:14'),
	(374, 'create provenance_type table', 'CREATE TABLE IF NOT EXISTS "provenance_type" (
"id" SERIAL PRIMARY KEY  NOT NULL
, "org_id" BIGINT NOT NULL
, "record_key" VARCHAR(190) NOT NULL
, "record_type" VARCHAR(190) NOT NULL
, "provenance" VARCHAR(190) NOT NULL
);', true, '', '2024-04-15 13:03:14'),
	(375, 'add index to uniquify (record_key, record_type, org_id) columns', 'CREATE UNIQUE INDEX "UQE_provenance_type_record_type_record_key_org_id" ON "provenance_type" ("record_type","record_key","org_id");', true, '', '2024-04-15 13:03:14'),
	(376, 'create alert_image table', 'CREATE TABLE IF NOT EXISTS "alert_image" (
"id" SERIAL PRIMARY KEY  NOT NULL
, "token" VARCHAR(190) NOT NULL
, "path" VARCHAR(190) NOT NULL
, "url" VARCHAR(190) NOT NULL
, "created_at" TIMESTAMP NOT NULL
, "expires_at" TIMESTAMP NOT NULL
);', true, '', '2024-04-15 13:03:14'),
	(377, 'add unique index on token to alert_image table', 'CREATE UNIQUE INDEX "UQE_alert_image_token" ON "alert_image" ("token");', true, '', '2024-04-15 13:03:14'),
	(378, 'support longer URLs in alert_image table', 'ALTER TABLE alert_image ALTER COLUMN url TYPE VARCHAR(2048);', true, '', '2024-04-15 13:03:14'),
	(379, 'create_alert_configuration_history_table', 'CREATE TABLE IF NOT EXISTS "alert_configuration_history" (
"id" SERIAL PRIMARY KEY  NOT NULL
, "org_id" BIGINT NOT NULL DEFAULT 0
, "alertmanager_configuration" TEXT NOT NULL
, "configuration_hash" VARCHAR(32) NOT NULL DEFAULT ''not-yet-calculated''
, "configuration_version" VARCHAR(3) NOT NULL
, "created_at" INTEGER NOT NULL
, "default" BOOL NOT NULL DEFAULT false
);', true, '', '2024-04-15 13:03:14'),
	(380, 'drop non-unique orgID index on alert_configuration', 'DROP INDEX "IDX_alert_configuration_org_id" CASCADE', true, '', '2024-04-15 13:03:14'),
	(381, 'drop unique orgID index on alert_configuration if exists', 'DROP INDEX "UQE_alert_configuration_org_id" CASCADE', true, '', '2024-04-15 13:03:14'),
	(382, 'extract alertmanager configuration history to separate table', 'code migration', true, '', '2024-04-15 13:03:14'),
	(383, 'add unique index on orgID to alert_configuration', 'CREATE UNIQUE INDEX "UQE_alert_configuration_org_id" ON "alert_configuration" ("org_id");', true, '', '2024-04-15 13:03:14'),
	(384, 'add last_applied column to alert_configuration_history', 'alter table "alert_configuration_history" ADD COLUMN "last_applied" INTEGER NOT NULL DEFAULT 0 ', true, '', '2024-04-15 13:03:14'),
	(385, 'create library_element table v1', 'CREATE TABLE IF NOT EXISTS "library_element" (
"id" SERIAL PRIMARY KEY  NOT NULL
, "org_id" BIGINT NOT NULL
, "folder_id" BIGINT NOT NULL
, "uid" VARCHAR(40) NOT NULL
, "name" VARCHAR(150) NOT NULL
, "kind" BIGINT NOT NULL
, "type" VARCHAR(40) NOT NULL
, "description" VARCHAR(255) NOT NULL
, "model" TEXT NOT NULL
, "created" TIMESTAMP NOT NULL
, "created_by" BIGINT NOT NULL
, "updated" TIMESTAMP NOT NULL
, "updated_by" BIGINT NOT NULL
, "version" BIGINT NOT NULL
);', true, '', '2024-04-15 13:03:14'),
	(386, 'add index library_element org_id-folder_id-name-kind', 'CREATE UNIQUE INDEX "UQE_library_element_org_id_folder_id_name_kind" ON "library_element" ("org_id","folder_id","name","kind");', true, '', '2024-04-15 13:03:14'),
	(387, 'create library_element_connection table v1', 'CREATE TABLE IF NOT EXISTS "library_element_connection" (
"id" SERIAL PRIMARY KEY  NOT NULL
, "element_id" BIGINT NOT NULL
, "kind" BIGINT NOT NULL
, "connection_id" BIGINT NOT NULL
, "created" TIMESTAMP NOT NULL
, "created_by" BIGINT NOT NULL
);', true, '', '2024-04-15 13:03:14'),
	(388, 'add index library_element_connection element_id-kind-connection_id', 'CREATE UNIQUE INDEX "UQE_library_element_connection_element_id_kind_connection_id" ON "library_element_connection" ("element_id","kind","connection_id");', true, '', '2024-04-15 13:03:14'),
	(389, 'add unique index library_element org_id_uid', 'CREATE UNIQUE INDEX "UQE_library_element_org_id_uid" ON "library_element" ("org_id","uid");', true, '', '2024-04-15 13:03:14'),
	(390, 'increase max description length to 2048', 'ALTER TABLE "library_element" ALTER "description" TYPE VARCHAR(2048);', true, '', '2024-04-15 13:03:14'),
	(391, 'alter library_element model to mediumtext', 'SELECT 0;', true, '', '2024-04-15 13:03:14'),
	(392, 'clone move dashboard alerts to unified alerting', 'code migration', true, '', '2024-04-15 13:03:14'),
	(393, 'create data_keys table', 'CREATE TABLE IF NOT EXISTS "data_keys" (
"name" VARCHAR(100) PRIMARY KEY NOT NULL
, "active" BOOL NOT NULL
, "scope" VARCHAR(30) NOT NULL
, "provider" VARCHAR(50) NOT NULL
, "encrypted_data" BYTEA NOT NULL
, "created" TIMESTAMP NOT NULL
, "updated" TIMESTAMP NOT NULL
);', true, '', '2024-04-15 13:03:14'),
	(394, 'create secrets table', 'CREATE TABLE IF NOT EXISTS "secrets" (
"id" SERIAL PRIMARY KEY  NOT NULL
, "org_id" BIGINT NOT NULL
, "namespace" VARCHAR(255) NOT NULL
, "type" VARCHAR(255) NOT NULL
, "value" TEXT NULL
, "created" TIMESTAMP NOT NULL
, "updated" TIMESTAMP NOT NULL
);', true, '', '2024-04-15 13:03:14'),
	(395, 'rename data_keys name column to id', 'ALTER TABLE "data_keys" RENAME COLUMN "name" TO "id"', true, '', '2024-04-15 13:03:14'),
	(396, 'add name column into data_keys', 'alter table "data_keys" ADD COLUMN "name" VARCHAR(100) NOT NULL DEFAULT '''' ', true, '', '2024-04-15 13:03:14'),
	(397, 'copy data_keys id column values into name', 'UPDATE data_keys SET name = id', true, '', '2024-04-15 13:03:14'),
	(398, 'rename data_keys name column to label', 'ALTER TABLE "data_keys" RENAME COLUMN "name" TO "label"', true, '', '2024-04-15 13:03:14'),
	(399, 'rename data_keys id column back to name', 'ALTER TABLE "data_keys" RENAME COLUMN "id" TO "name"', true, '', '2024-04-15 13:03:14'),
	(400, 'create kv_store table v1', 'CREATE TABLE IF NOT EXISTS "kv_store" (
"id" SERIAL PRIMARY KEY  NOT NULL
, "org_id" BIGINT NOT NULL
, "namespace" VARCHAR(190) NOT NULL
, "key" VARCHAR(190) NOT NULL
, "value" TEXT NOT NULL
, "created" TIMESTAMP NOT NULL
, "updated" TIMESTAMP NOT NULL
);', true, '', '2024-04-15 13:03:14'),
	(401, 'add index kv_store.org_id-namespace-key', 'CREATE UNIQUE INDEX "UQE_kv_store_org_id_namespace_key" ON "kv_store" ("org_id","namespace","key");', true, '', '2024-04-15 13:03:14'),
	(402, 'update dashboard_uid and panel_id from existing annotations', 'set dashboard_uid and panel_id migration', true, '', '2024-04-15 13:03:14'),
	(403, 'create permission table', 'CREATE TABLE IF NOT EXISTS "permission" (
"id" SERIAL PRIMARY KEY  NOT NULL
, "role_id" BIGINT NOT NULL
, "action" VARCHAR(190) NOT NULL
, "scope" VARCHAR(190) NOT NULL
, "created" TIMESTAMP NOT NULL
, "updated" TIMESTAMP NOT NULL
);', true, '', '2024-04-15 13:03:14'),
	(404, 'add unique index permission.role_id', 'CREATE INDEX "IDX_permission_role_id" ON "permission" ("role_id");', true, '', '2024-04-15 13:03:14'),
	(405, 'add unique index role_id_action_scope', 'CREATE UNIQUE INDEX "UQE_permission_role_id_action_scope" ON "permission" ("role_id","action","scope");', true, '', '2024-04-15 13:03:14'),
	(406, 'create role table', 'CREATE TABLE IF NOT EXISTS "role" (
"id" SERIAL PRIMARY KEY  NOT NULL
, "name" VARCHAR(190) NOT NULL
, "description" TEXT NULL
, "version" BIGINT NOT NULL
, "org_id" BIGINT NOT NULL
, "uid" VARCHAR(40) NOT NULL
, "created" TIMESTAMP NOT NULL
, "updated" TIMESTAMP NOT NULL
);', true, '', '2024-04-15 13:03:14'),
	(408, 'add column group_name', 'alter table "role" ADD COLUMN "group_name" VARCHAR(190) NULL ', true, '', '2024-04-15 13:03:14'),
	(409, 'add index role.org_id', 'CREATE INDEX "IDX_role_org_id" ON "role" ("org_id");', true, '', '2024-04-15 13:03:14'),
	(410, 'add unique index role_org_id_name', 'CREATE UNIQUE INDEX "UQE_role_org_id_name" ON "role" ("org_id","name");', true, '', '2024-04-15 13:03:14'),
	(411, 'add index role_org_id_uid', 'CREATE UNIQUE INDEX "UQE_role_org_id_uid" ON "role" ("org_id","uid");', true, '', '2024-04-15 13:03:14'),
	(412, 'create team role table', 'CREATE TABLE IF NOT EXISTS "team_role" (
"id" SERIAL PRIMARY KEY  NOT NULL
, "org_id" BIGINT NOT NULL
, "team_id" BIGINT NOT NULL
, "role_id" BIGINT NOT NULL
, "created" TIMESTAMP NOT NULL
);', true, '', '2024-04-15 13:03:14'),
	(413, 'add index team_role.org_id', 'CREATE INDEX "IDX_team_role_org_id" ON "team_role" ("org_id");', true, '', '2024-04-15 13:03:14'),
	(414, 'add unique index team_role_org_id_team_id_role_id', 'CREATE UNIQUE INDEX "UQE_team_role_org_id_team_id_role_id" ON "team_role" ("org_id","team_id","role_id");', true, '', '2024-04-15 13:03:14'),
	(415, 'add index team_role.team_id', 'CREATE INDEX "IDX_team_role_team_id" ON "team_role" ("team_id");', true, '', '2024-04-15 13:03:14'),
	(416, 'create user role table', 'CREATE TABLE IF NOT EXISTS "user_role" (
"id" SERIAL PRIMARY KEY  NOT NULL
, "org_id" BIGINT NOT NULL
, "user_id" BIGINT NOT NULL
, "role_id" BIGINT NOT NULL
, "created" TIMESTAMP NOT NULL
);', true, '', '2024-04-15 13:03:14'),
	(417, 'add index user_role.org_id', 'CREATE INDEX "IDX_user_role_org_id" ON "user_role" ("org_id");', true, '', '2024-04-15 13:03:14'),
	(418, 'add unique index user_role_org_id_user_id_role_id', 'CREATE UNIQUE INDEX "UQE_user_role_org_id_user_id_role_id" ON "user_role" ("org_id","user_id","role_id");', true, '', '2024-04-15 13:03:14'),
	(419, 'add index user_role.user_id', 'CREATE INDEX "IDX_user_role_user_id" ON "user_role" ("user_id");', true, '', '2024-04-15 13:03:14'),
	(420, 'create builtin role table', 'CREATE TABLE IF NOT EXISTS "builtin_role" (
"id" SERIAL PRIMARY KEY  NOT NULL
, "role" VARCHAR(190) NOT NULL
, "role_id" BIGINT NOT NULL
, "created" TIMESTAMP NOT NULL
, "updated" TIMESTAMP NOT NULL
);', true, '', '2024-04-15 13:03:14'),
	(421, 'add index builtin_role.role_id', 'CREATE INDEX "IDX_builtin_role_role_id" ON "builtin_role" ("role_id");', true, '', '2024-04-15 13:03:14'),
	(422, 'add index builtin_role.name', 'CREATE INDEX "IDX_builtin_role_role" ON "builtin_role" ("role");', true, '', '2024-04-15 13:03:14'),
	(423, 'Add column org_id to builtin_role table', 'alter table "builtin_role" ADD COLUMN "org_id" BIGINT NOT NULL DEFAULT 0 ', true, '', '2024-04-15 13:03:14'),
	(424, 'add index builtin_role.org_id', 'CREATE INDEX "IDX_builtin_role_org_id" ON "builtin_role" ("org_id");', true, '', '2024-04-15 13:03:14'),
	(425, 'add unique index builtin_role_org_id_role_id_role', 'CREATE UNIQUE INDEX "UQE_builtin_role_org_id_role_id_role" ON "builtin_role" ("org_id","role_id","role");', true, '', '2024-04-15 13:03:14'),
	(426, 'Remove unique index role_org_id_uid', 'DROP INDEX "UQE_role_org_id_uid" CASCADE', true, '', '2024-04-15 13:03:14'),
	(427, 'add unique index role.uid', 'CREATE UNIQUE INDEX "UQE_role_uid" ON "role" ("uid");', true, '', '2024-04-15 13:03:14'),
	(428, 'create seed assignment table', 'CREATE TABLE IF NOT EXISTS "seed_assignment" (
"builtin_role" VARCHAR(190) NOT NULL
, "role_name" VARCHAR(190) NOT NULL
);', true, '', '2024-04-15 13:03:14'),
	(429, 'add unique index builtin_role_role_name', 'CREATE UNIQUE INDEX "UQE_seed_assignment_builtin_role_role_name" ON "seed_assignment" ("builtin_role","role_name");', true, '', '2024-04-15 13:03:14'),
	(430, 'add column hidden to role table', 'alter table "role" ADD COLUMN "hidden" BOOL NOT NULL DEFAULT false ', true, '', '2024-04-15 13:03:14'),
	(431, 'permission kind migration', 'alter table "permission" ADD COLUMN "kind" VARCHAR(40) NOT NULL DEFAULT '''' ', true, '', '2024-04-15 13:03:14'),
	(432, 'permission attribute migration', 'alter table "permission" ADD COLUMN "attribute" VARCHAR(40) NOT NULL DEFAULT '''' ', true, '', '2024-04-15 13:03:14'),
	(433, 'permission identifier migration', 'alter table "permission" ADD COLUMN "identifier" VARCHAR(40) NOT NULL DEFAULT '''' ', true, '', '2024-04-15 13:03:14'),
	(434, 'add permission identifier index', 'CREATE INDEX "IDX_permission_identifier" ON "permission" ("identifier");', true, '', '2024-04-15 13:03:14'),
	(435, 'add permission action scope role_id index', 'CREATE UNIQUE INDEX "UQE_permission_action_scope_role_id" ON "permission" ("action","scope","role_id");', true, '', '2024-04-15 13:03:14'),
	(436, 'remove permission role_id action scope index', 'DROP INDEX "UQE_permission_role_id_action_scope" CASCADE', true, '', '2024-04-15 13:03:14'),
	(437, 'create query_history table v1', 'CREATE TABLE IF NOT EXISTS "query_history" (
"id" SERIAL PRIMARY KEY  NOT NULL
, "uid" VARCHAR(40) NOT NULL
, "org_id" BIGINT NOT NULL
, "datasource_uid" VARCHAR(40) NOT NULL
, "created_by" INTEGER NOT NULL
, "created_at" INTEGER NOT NULL
, "comment" TEXT NOT NULL
, "queries" TEXT NOT NULL
);', true, '', '2024-04-15 13:03:14'),
	(438, 'add index query_history.org_id-created_by-datasource_uid', 'CREATE INDEX "IDX_query_history_org_id_created_by_datasource_uid" ON "query_history" ("org_id","created_by","datasource_uid");', true, '', '2024-04-15 13:03:14'),
	(439, 'alter table query_history alter column created_by type to bigint', 'ALTER TABLE query_history ALTER COLUMN created_by TYPE BIGINT;', true, '', '2024-04-15 13:03:14'),
	(440, 'rbac disabled migrator', 'code migration', true, '', '2024-04-15 13:03:14'),
	(441, 'teams permissions migration', 'code migration', true, '', '2024-04-15 13:03:14'),
	(442, 'dashboard permissions', 'code migration', true, '', '2024-04-15 13:03:14'),
	(443, 'dashboard permissions uid scopes', 'code migration', true, '', '2024-04-15 13:03:14'),
	(444, 'drop managed folder create actions', 'code migration', true, '', '2024-04-15 13:03:14'),
	(445, 'alerting notification permissions', 'code migration', true, '', '2024-04-15 13:03:14'),
	(446, 'create query_history_star table v1', 'CREATE TABLE IF NOT EXISTS "query_history_star" (
"id" SERIAL PRIMARY KEY  NOT NULL
, "query_uid" VARCHAR(40) NOT NULL
, "user_id" INTEGER NOT NULL
);', true, '', '2024-04-15 13:03:14'),
	(447, 'add index query_history.user_id-query_uid', 'CREATE UNIQUE INDEX "UQE_query_history_star_user_id_query_uid" ON "query_history_star" ("user_id","query_uid");', true, '', '2024-04-15 13:03:14'),
	(448, 'add column org_id in query_history_star', 'alter table "query_history_star" ADD COLUMN "org_id" BIGINT NOT NULL DEFAULT 1 ', true, '', '2024-04-15 13:03:14'),
	(449, 'alter table query_history_star_mig column user_id type to bigint', 'ALTER TABLE query_history_star ALTER COLUMN user_id TYPE BIGINT;', true, '', '2024-04-15 13:03:14'),
	(450, 'create correlation table v1', 'CREATE TABLE IF NOT EXISTS "correlation" (
"uid" VARCHAR(40) NOT NULL
, "source_uid" VARCHAR(40) NOT NULL
, "target_uid" VARCHAR(40) NULL
, "label" TEXT NOT NULL
, "description" TEXT NOT NULL
, PRIMARY KEY ( "uid","source_uid" ));', true, '', '2024-04-15 13:03:14'),
	(451, 'add index correlations.uid', 'CREATE INDEX "IDX_correlation_uid" ON "correlation" ("uid");', true, '', '2024-04-15 13:03:14'),
	(452, 'add index correlations.source_uid', 'CREATE INDEX "IDX_correlation_source_uid" ON "correlation" ("source_uid");', true, '', '2024-04-15 13:03:14'),
	(453, 'add correlation config column', 'alter table "correlation" ADD COLUMN "config" TEXT NULL ', true, '', '2024-04-15 13:03:14'),
	(454, 'drop index IDX_correlation_uid - v1', 'DROP INDEX "IDX_correlation_uid" CASCADE', true, '', '2024-04-15 13:03:14'),
	(455, 'drop index IDX_correlation_source_uid - v1', 'DROP INDEX "IDX_correlation_source_uid" CASCADE', true, '', '2024-04-15 13:03:14'),
	(456, 'Rename table correlation to correlation_tmp_qwerty - v1', 'ALTER TABLE "correlation" RENAME TO "correlation_tmp_qwerty"', true, '', '2024-04-15 13:03:14'),
	(457, 'create correlation v2', 'CREATE TABLE IF NOT EXISTS "correlation" (
"uid" VARCHAR(40) NOT NULL
, "org_id" BIGINT NOT NULL DEFAULT 0
, "source_uid" VARCHAR(40) NOT NULL
, "target_uid" VARCHAR(40) NULL
, "label" TEXT NOT NULL
, "description" TEXT NOT NULL
, "config" TEXT NULL
, PRIMARY KEY ( "uid","org_id","source_uid" ));', true, '', '2024-04-15 13:03:14'),
	(458, 'create index IDX_correlation_uid - v2', 'CREATE INDEX "IDX_correlation_uid" ON "correlation" ("uid");', true, '', '2024-04-15 13:03:14'),
	(459, 'create index IDX_correlation_source_uid - v2', 'CREATE INDEX "IDX_correlation_source_uid" ON "correlation" ("source_uid");', true, '', '2024-04-15 13:03:14'),
	(460, 'create index IDX_correlation_org_id - v2', 'CREATE INDEX "IDX_correlation_org_id" ON "correlation" ("org_id");', true, '', '2024-04-15 13:03:14'),
	(461, 'copy correlation v1 to v2', 'INSERT INTO "correlation" ("config"
, "uid"
, "source_uid"
, "target_uid"
, "label"
, "description") SELECT "config"
, "uid"
, "source_uid"
, "target_uid"
, "label"
, "description" FROM "correlation_tmp_qwerty"', true, '', '2024-04-15 13:03:14'),
	(462, 'drop correlation_tmp_qwerty', 'DROP TABLE IF EXISTS "correlation_tmp_qwerty"', true, '', '2024-04-15 13:03:14'),
	(463, 'add provisioning column', 'alter table "correlation" ADD COLUMN "provisioned" BOOL NOT NULL DEFAULT false ', true, '', '2024-04-15 13:03:14'),
	(464, 'create entity_events table', 'CREATE TABLE IF NOT EXISTS "entity_event" (
"id" SERIAL PRIMARY KEY  NOT NULL
, "entity_id" VARCHAR(1024) NOT NULL
, "event_type" VARCHAR(8) NOT NULL
, "created" BIGINT NOT NULL
);', true, '', '2024-04-15 13:03:14'),
	(465, 'create dashboard public config v1', 'CREATE TABLE IF NOT EXISTS "dashboard_public_config" (
"uid" VARCHAR(40) PRIMARY KEY NOT NULL
, "dashboard_uid" VARCHAR(40) NOT NULL
, "org_id" BIGINT NOT NULL
, "time_settings" TEXT NOT NULL
, "refresh_rate" INTEGER NOT NULL DEFAULT 30
, "template_variables" TEXT NULL
);', true, '', '2024-04-15 13:03:14'),
	(466, 'drop index UQE_dashboard_public_config_uid - v1', 'DROP INDEX "UQE_dashboard_public_config_uid" CASCADE', true, '', '2024-04-15 13:03:14'),
	(467, 'drop index IDX_dashboard_public_config_org_id_dashboard_uid - v1', 'DROP INDEX "IDX_dashboard_public_config_org_id_dashboard_uid" CASCADE', true, '', '2024-04-15 13:03:14'),
	(468, 'Drop old dashboard public config table', 'DROP TABLE IF EXISTS "dashboard_public_config"', true, '', '2024-04-15 13:03:14'),
	(469, 'recreate dashboard public config v1', 'CREATE TABLE IF NOT EXISTS "dashboard_public_config" (
"uid" VARCHAR(40) PRIMARY KEY NOT NULL
, "dashboard_uid" VARCHAR(40) NOT NULL
, "org_id" BIGINT NOT NULL
, "time_settings" TEXT NOT NULL
, "refresh_rate" INTEGER NOT NULL DEFAULT 30
, "template_variables" TEXT NULL
);', true, '', '2024-04-15 13:03:14'),
	(470, 'create index UQE_dashboard_public_config_uid - v1', 'CREATE UNIQUE INDEX "UQE_dashboard_public_config_uid" ON "dashboard_public_config" ("uid");', true, '', '2024-04-15 13:03:14'),
	(471, 'create index IDX_dashboard_public_config_org_id_dashboard_uid - v1', 'CREATE INDEX "IDX_dashboard_public_config_org_id_dashboard_uid" ON "dashboard_public_config" ("org_id","dashboard_uid");', true, '', '2024-04-15 13:03:14'),
	(472, 'drop index UQE_dashboard_public_config_uid - v2', 'DROP INDEX "UQE_dashboard_public_config_uid" CASCADE', true, '', '2024-04-15 13:03:14'),
	(473, 'drop index IDX_dashboard_public_config_org_id_dashboard_uid - v2', 'DROP INDEX "IDX_dashboard_public_config_org_id_dashboard_uid" CASCADE', true, '', '2024-04-15 13:03:14'),
	(474, 'Drop public config table', 'DROP TABLE IF EXISTS "dashboard_public_config"', true, '', '2024-04-15 13:03:14'),
	(475, 'Recreate dashboard public config v2', 'CREATE TABLE IF NOT EXISTS "dashboard_public_config" (
"uid" VARCHAR(40) PRIMARY KEY NOT NULL
, "dashboard_uid" VARCHAR(40) NOT NULL
, "org_id" BIGINT NOT NULL
, "time_settings" TEXT NULL
, "template_variables" TEXT NULL
, "access_token" VARCHAR(32) NOT NULL
, "created_by" INTEGER NOT NULL
, "updated_by" INTEGER NULL
, "created_at" TIMESTAMP NOT NULL
, "updated_at" TIMESTAMP NULL
, "is_enabled" BOOL NOT NULL DEFAULT false
);', true, '', '2024-04-15 13:03:14'),
	(476, 'create index UQE_dashboard_public_config_uid - v2', 'CREATE UNIQUE INDEX "UQE_dashboard_public_config_uid" ON "dashboard_public_config" ("uid");', true, '', '2024-04-15 13:03:14'),
	(477, 'create index IDX_dashboard_public_config_org_id_dashboard_uid - v2', 'CREATE INDEX "IDX_dashboard_public_config_org_id_dashboard_uid" ON "dashboard_public_config" ("org_id","dashboard_uid");', true, '', '2024-04-15 13:03:14'),
	(478, 'create index UQE_dashboard_public_config_access_token - v2', 'CREATE UNIQUE INDEX "UQE_dashboard_public_config_access_token" ON "dashboard_public_config" ("access_token");', true, '', '2024-04-15 13:03:14'),
	(479, 'Rename table dashboard_public_config to dashboard_public - v2', 'ALTER TABLE "dashboard_public_config" RENAME TO "dashboard_public"', true, '', '2024-04-15 13:03:14'),
	(480, 'add annotations_enabled column', 'alter table "dashboard_public" ADD COLUMN "annotations_enabled" BOOL NOT NULL DEFAULT false ', true, '', '2024-04-15 13:03:14'),
	(481, 'add time_selection_enabled column', 'alter table "dashboard_public" ADD COLUMN "time_selection_enabled" BOOL NOT NULL DEFAULT false ', true, '', '2024-04-15 13:03:14'),
	(482, 'delete orphaned public dashboards', 'DELETE FROM dashboard_public WHERE dashboard_uid NOT IN (SELECT uid FROM dashboard)', true, '', '2024-04-15 13:03:14'),
	(483, 'add share column', 'alter table "dashboard_public" ADD COLUMN "share" VARCHAR(64) NOT NULL DEFAULT ''public'' ', true, '', '2024-04-15 13:03:14'),
	(484, 'backfill empty share column fields with default of public', 'UPDATE dashboard_public SET share=''public'' WHERE share=''''', true, '', '2024-04-15 13:03:14'),
	(485, 'create file table', 'CREATE TABLE IF NOT EXISTS "file" (
"path" VARCHAR(1024) NOT NULL
, "path_hash" VARCHAR(64) NOT NULL
, "parent_folder_path_hash" VARCHAR(64) NOT NULL
, "contents" BYTEA NOT NULL
, "etag" VARCHAR(32) NOT NULL
, "cache_control" VARCHAR(128) NOT NULL
, "content_disposition" VARCHAR(128) NOT NULL
, "updated" TIMESTAMP NOT NULL
, "created" TIMESTAMP NOT NULL
, "size" BIGINT NOT NULL
, "mime_type" VARCHAR(255) NOT NULL
);', true, '', '2024-04-15 13:03:14'),
	(486, 'file table idx: path natural pk', 'CREATE UNIQUE INDEX "UQE_file_path_hash" ON "file" ("path_hash");', true, '', '2024-04-15 13:03:14'),
	(487, 'file table idx: parent_folder_path_hash fast folder retrieval', 'CREATE INDEX "IDX_file_parent_folder_path_hash" ON "file" ("parent_folder_path_hash");', true, '', '2024-04-15 13:03:14'),
	(488, 'create file_meta table', 'CREATE TABLE IF NOT EXISTS "file_meta" (
"path_hash" VARCHAR(64) NOT NULL
, "key" VARCHAR(191) NOT NULL
, "value" VARCHAR(1024) NOT NULL
);', true, '', '2024-04-15 13:03:14'),
	(489, 'file table idx: path key', 'CREATE UNIQUE INDEX "UQE_file_meta_path_hash_key" ON "file_meta" ("path_hash","key");', true, '', '2024-04-15 13:03:14'),
	(490, 'set path collation in file table', 'ALTER TABLE file ALTER COLUMN path TYPE VARCHAR(1024) COLLATE "C";', true, '', '2024-04-15 13:03:14'),
	(491, 'migrate contents column to mediumblob for MySQL', 'SELECT 0;', true, '', '2024-04-15 13:03:14'),
	(492, 'managed permissions migration', 'code migration', true, '', '2024-04-15 13:03:14'),
	(493, 'managed folder permissions alert actions migration', 'code migration', true, '', '2024-04-15 13:03:14'),
	(494, 'RBAC action name migrator', 'code migration', true, '', '2024-04-15 13:03:14'),
	(495, 'Add UID column to playlist', 'alter table "playlist" ADD COLUMN "uid" VARCHAR(80) NOT NULL DEFAULT 0 ', true, '', '2024-04-15 13:03:14'),
	(496, 'Update uid column values in playlist', 'UPDATE playlist SET uid=id::text;', true, '', '2024-04-15 13:03:14'),
	(497, 'Add index for uid in playlist', 'CREATE UNIQUE INDEX "UQE_playlist_org_id_uid" ON "playlist" ("org_id","uid");', true, '', '2024-04-15 13:03:14'),
	(498, 'update group index for alert rules', 'code migration', true, '', '2024-04-15 13:03:14'),
	(499, 'managed folder permissions alert actions repeated migration', 'code migration', true, '', '2024-04-15 13:03:14'),
	(500, 'admin only folder/dashboard permission', 'code migration', true, '', '2024-04-15 13:03:14'),
	(501, 'add action column to seed_assignment', 'alter table "seed_assignment" ADD COLUMN "action" VARCHAR(190) NULL ', true, '', '2024-04-15 13:03:14'),
	(502, 'add scope column to seed_assignment', 'alter table "seed_assignment" ADD COLUMN "scope" VARCHAR(190) NULL ', true, '', '2024-04-15 13:03:14'),
	(503, 'remove unique index builtin_role_role_name before nullable update', 'DROP INDEX "UQE_seed_assignment_builtin_role_role_name" CASCADE', true, '', '2024-04-15 13:03:14'),
	(504, 'update seed_assignment role_name column to nullable', 'ALTER TABLE `seed_assignment` ALTER COLUMN role_name DROP NOT NULL;', true, '', '2024-04-15 13:03:14'),
	(505, 'add unique index builtin_role_name back', 'CREATE UNIQUE INDEX "UQE_seed_assignment_builtin_role_role_name" ON "seed_assignment" ("builtin_role","role_name");', true, '', '2024-04-15 13:03:14'),
	(506, 'add unique index builtin_role_action_scope', 'CREATE UNIQUE INDEX "UQE_seed_assignment_builtin_role_action_scope" ON "seed_assignment" ("builtin_role","action","scope");', true, '', '2024-04-15 13:03:14'),
	(507, 'add primary key to seed_assigment', 'code migration', true, '', '2024-04-15 13:03:14'),
	(508, 'add origin column to seed_assignment', 'alter table "seed_assignment" ADD COLUMN "origin" VARCHAR(190) NULL ', true, '', '2024-04-15 13:03:14'),
	(509, 'add origin to plugin seed_assignment', 'code migration', true, '', '2024-04-15 13:03:14'),
	(510, 'prevent seeding OnCall access', 'code migration', true, '', '2024-04-15 13:03:14'),
	(511, 'managed folder permissions alert actions repeated fixed migration', 'code migration', true, '', '2024-04-15 13:03:14'),
	(512, 'managed folder permissions library panel actions migration', 'code migration', true, '', '2024-04-15 13:03:14'),
	(513, 'migrate external alertmanagers to datsourcse', 'migrate external alertmanagers to datasource', true, '', '2024-04-15 13:03:14'),
	(514, 'create folder table', 'CREATE TABLE IF NOT EXISTS "folder" (
"id" SERIAL PRIMARY KEY  NOT NULL
, "uid" VARCHAR(40) NOT NULL
, "org_id" BIGINT NOT NULL
, "title" VARCHAR(255) NOT NULL
, "description" VARCHAR(255) NULL
, "parent_uid" VARCHAR(40) NULL
, "created" TIMESTAMP NOT NULL
, "updated" TIMESTAMP NOT NULL
);', true, '', '2024-04-15 13:03:14'),
	(515, 'Add index for parent_uid', 'CREATE INDEX "IDX_folder_parent_uid_org_id" ON "folder" ("parent_uid","org_id");', true, '', '2024-04-15 13:03:14'),
	(516, 'Add unique index for folder.uid and folder.org_id', 'CREATE UNIQUE INDEX "UQE_folder_uid_org_id" ON "folder" ("uid","org_id");', true, '', '2024-04-15 13:03:14'),
	(517, 'Update folder title length', 'ALTER TABLE "folder" ALTER "title" TYPE VARCHAR(189);', true, '', '2024-04-15 13:03:14'),
	(518, 'Add unique index for folder.title and folder.parent_uid', 'CREATE UNIQUE INDEX "UQE_folder_title_parent_uid" ON "folder" ("title","parent_uid");', true, '', '2024-04-15 13:03:14'),
	(519, 'Remove unique index for folder.title and folder.parent_uid', 'DROP INDEX "UQE_folder_title_parent_uid" CASCADE', true, '', '2024-04-15 13:03:14'),
	(520, 'Add unique index for title, parent_uid, and org_id', 'CREATE UNIQUE INDEX "UQE_folder_title_parent_uid_org_id" ON "folder" ("title","parent_uid","org_id");', true, '', '2024-04-15 13:03:14'),
	(521, 'Sync dashboard and folder table', '
			INSERT INTO folder (uid, org_id, title, created, updated)
			SELECT uid, org_id, title, created, updated FROM dashboard WHERE is_folder = true
			ON CONFLICT(uid, org_id) DO UPDATE SET title=excluded.title, updated=excluded.updated
		', true, '', '2024-04-15 13:03:14'),
	(522, 'Remove ghost folders from the folder table', '
			DELETE FROM folder WHERE NOT EXISTS
				(SELECT 1 FROM dashboard WHERE dashboard.uid = folder.uid AND dashboard.org_id = folder.org_id AND dashboard.is_folder = true)
	', true, '', '2024-04-15 13:03:14'),
	(523, 'Remove unique index UQE_folder_uid_org_id', 'DROP INDEX "UQE_folder_uid_org_id" CASCADE', true, '', '2024-04-15 13:03:14'),
	(524, 'Add unique index UQE_folder_org_id_uid', 'CREATE UNIQUE INDEX "UQE_folder_org_id_uid" ON "folder" ("org_id","uid");', true, '', '2024-04-15 13:03:14'),
	(525, 'Remove unique index UQE_folder_title_parent_uid_org_id', 'DROP INDEX "UQE_folder_title_parent_uid_org_id" CASCADE', true, '', '2024-04-15 13:03:14'),
	(526, 'Add unique index UQE_folder_org_id_parent_uid_title', 'CREATE UNIQUE INDEX "UQE_folder_org_id_parent_uid_title" ON "folder" ("org_id","parent_uid","title");', true, '', '2024-04-15 13:03:14'),
	(527, 'Remove index IDX_folder_parent_uid_org_id', 'DROP INDEX "IDX_folder_parent_uid_org_id" CASCADE', true, '', '2024-04-15 13:03:14'),
	(528, 'create anon_device table', 'CREATE TABLE IF NOT EXISTS "anon_device" (
"id" SERIAL PRIMARY KEY  NOT NULL
, "client_ip" VARCHAR(255) NOT NULL
, "created_at" TIMESTAMP NOT NULL
, "device_id" VARCHAR(127) NOT NULL
, "updated_at" TIMESTAMP NOT NULL
, "user_agent" VARCHAR(255) NOT NULL
);', true, '', '2024-04-15 13:03:14'),
	(529, 'add unique index anon_device.device_id', 'CREATE UNIQUE INDEX "UQE_anon_device_device_id" ON "anon_device" ("device_id");', true, '', '2024-04-15 13:03:14'),
	(530, 'add index anon_device.updated_at', 'CREATE INDEX "IDX_anon_device_updated_at" ON "anon_device" ("updated_at");', true, '', '2024-04-15 13:03:14'),
	(531, 'create signing_key table', 'CREATE TABLE IF NOT EXISTS "signing_key" (
"id" SERIAL PRIMARY KEY  NOT NULL
, "key_id" VARCHAR(255) NOT NULL
, "private_key" TEXT NOT NULL
, "added_at" TIMESTAMP NOT NULL
, "expires_at" TIMESTAMP NULL
, "alg" VARCHAR(255) NOT NULL
);', true, '', '2024-04-15 13:03:14'),
	(532, 'add unique index signing_key.key_id', 'CREATE UNIQUE INDEX "UQE_signing_key_key_id" ON "signing_key" ("key_id");', true, '', '2024-04-15 13:03:14'),
	(533, 'set legacy alert migration status in kvstore', 'code migration', true, '', '2024-04-15 13:03:14'),
	(534, 'migrate record of created folders during legacy migration to kvstore', 'code migration', true, '', '2024-04-15 13:03:14'),
	(535, 'Add folder_uid for dashboard', 'alter table "dashboard" ADD COLUMN "folder_uid" VARCHAR(40) NULL ', true, '', '2024-04-15 13:03:14'),
	(536, 'Populate dashboard folder_uid column', 'code migration', true, '', '2024-04-15 13:03:14'),
	(537, 'Add unique index for dashboard_org_id_folder_uid_title', 'CREATE UNIQUE INDEX "UQE_dashboard_org_id_folder_uid_title" ON "dashboard" ("org_id","folder_uid","title");', true, '', '2024-04-15 13:03:14'),
	(538, 'Delete unique index for dashboard_org_id_folder_id_title', 'DROP INDEX "UQE_dashboard_org_id_folder_id_title" CASCADE', true, '', '2024-04-15 13:03:14'),
	(539, 'Delete unique index for dashboard_org_id_folder_uid_title', 'DROP INDEX "UQE_dashboard_org_id_folder_uid_title" CASCADE', true, '', '2024-04-15 13:03:14'),
	(540, 'Add unique index for dashboard_org_id_folder_uid_title_is_folder', 'CREATE UNIQUE INDEX "UQE_dashboard_org_id_folder_uid_title_is_folder" ON "dashboard" ("org_id","folder_uid","title","is_folder");', true, '', '2024-04-15 13:03:14'),
	(541, 'Restore index for dashboard_org_id_folder_id_title', 'CREATE INDEX "IDX_dashboard_org_id_folder_id_title" ON "dashboard" ("org_id","folder_id","title");', true, '', '2024-04-15 13:03:15'),
	(542, 'create sso_setting table', 'CREATE TABLE IF NOT EXISTS "sso_setting" (
"id" VARCHAR(40) PRIMARY KEY NOT NULL
, "provider" VARCHAR(255) NOT NULL
, "settings" TEXT NOT NULL
, "created" TIMESTAMP NOT NULL
, "updated" TIMESTAMP NOT NULL
, "is_deleted" BOOL NOT NULL DEFAULT false
);', true, '', '2024-04-15 13:03:15'),
	(543, 'copy kvstore migration status to each org', 'code migration', true, '', '2024-04-15 13:03:15'),
	(544, 'add back entry for orgid=0 migrated status', 'code migration', true, '', '2024-04-15 13:03:15'),
	(545, 'alter kv_store.value to longtext', 'SELECT 0;', true, '', '2024-04-15 13:03:15'),
	(546, 'add notification_settings column to alert_rule table', 'alter table "alert_rule" ADD COLUMN "notification_settings" TEXT NULL ', true, '', '2024-04-15 13:03:15'),
	(547, 'add notification_settings column to alert_rule_version table', 'alter table "alert_rule_version" ADD COLUMN "notification_settings" TEXT NULL ', true, '', '2024-04-15 13:03:15'),
	(548, 'removing scope from alert.instances:read action migration', 'code migration', true, '', '2024-04-15 13:03:15');


--
-- Data for Name: ngalert_configuration; Type: TABLE DATA; Schema: public; Owner: root
--



--
-- Data for Name: org; Type: TABLE DATA; Schema: public; Owner: root
--

INSERT INTO org (id, version, name, address1, address2, city, state, zip_code, country, billing_email, created, updated) VALUES
	(1, 0, 'Main Org.', '', '', '', '', '', '', NULL, '2024-04-15 13:03:15', '2024-04-15 13:03:15');


--
-- Data for Name: org_user; Type: TABLE DATA; Schema: public; Owner: root
--

INSERT INTO org_user (id, org_id, user_id, role, created, updated) VALUES
	(1, 1, 1, 'Admin', '2024-04-15 13:03:15', '2024-04-15 13:03:15');


--
-- Data for Name: permission; Type: TABLE DATA; Schema: public; Owner: root
--



--
-- Data for Name: playlist; Type: TABLE DATA; Schema: public; Owner: root
--



--
-- Data for Name: playlist_item; Type: TABLE DATA; Schema: public; Owner: root
--



--
-- Data for Name: plugin_setting; Type: TABLE DATA; Schema: public; Owner: root
--



--
-- Data for Name: preferences; Type: TABLE DATA; Schema: public; Owner: root
--



--
-- Data for Name: provenance_type; Type: TABLE DATA; Schema: public; Owner: root
--



--
-- Data for Name: query_history; Type: TABLE DATA; Schema: public; Owner: root
--



--
-- Data for Name: query_history_star; Type: TABLE DATA; Schema: public; Owner: root
--



--
-- Data for Name: quota; Type: TABLE DATA; Schema: public; Owner: root
--



--
-- Data for Name: role; Type: TABLE DATA; Schema: public; Owner: root
--



--
-- Data for Name: secrets; Type: TABLE DATA; Schema: public; Owner: root
--



--
-- Data for Name: seed_assignment; Type: TABLE DATA; Schema: public; Owner: root
--



--
-- Data for Name: server_lock; Type: TABLE DATA; Schema: public; Owner: root
--

INSERT INTO server_lock (id, operation_uid, version, last_execution) VALUES
	(3, 'cleanup expired auth tokens', 1, 1713186195);


--
-- Data for Name: session; Type: TABLE DATA; Schema: public; Owner: root
--



--
-- Data for Name: short_url; Type: TABLE DATA; Schema: public; Owner: root
--



--
-- Data for Name: signing_key; Type: TABLE DATA; Schema: public; Owner: root
--



--
-- Data for Name: sso_setting; Type: TABLE DATA; Schema: public; Owner: root
--



--
-- Data for Name: star; Type: TABLE DATA; Schema: public; Owner: root
--



--
-- Data for Name: tag; Type: TABLE DATA; Schema: public; Owner: root
--



--
-- Data for Name: team; Type: TABLE DATA; Schema: public; Owner: root
--



--
-- Data for Name: team_member; Type: TABLE DATA; Schema: public; Owner: root
--



--
-- Data for Name: team_role; Type: TABLE DATA; Schema: public; Owner: root
--



--
-- Data for Name: temp_user; Type: TABLE DATA; Schema: public; Owner: root
--



--
-- Data for Name: test_data; Type: TABLE DATA; Schema: public; Owner: root
--



--
-- Data for Name: user; Type: TABLE DATA; Schema: public; Owner: root
--

INSERT INTO "user" (id, version, login, email, name, password, salt, rands, company, org_id, is_admin, email_verified, theme, created, updated, help_flags1, last_seen_at, is_disabled, is_service_account, uid) VALUES
	(1, 0, 'admin', 'admin@localhost', '', '4b2a18907482e3cd964f7859440c2cac6fcb2b7f8d8640278b31639327ccc70a5d399c1dffdd935c874d85f331109103d609', 'e3GieqmBeU', '4odu0VOps8', '', 1, true, false, '', '2024-04-15 13:03:15', '2024-04-15 13:03:15', 0, '2024-04-15 13:03:28', false, false, '');

