CREATE TABLE role (
	roleid                   bigint                                    NOT NULL,
	name                     varchar(255)    DEFAULT ''                NOT NULL,
	type                     integer         DEFAULT '0'               NOT NULL,
	readonly                 integer         DEFAULT '0'               NOT NULL,
	PRIMARY KEY (roleid)
);

CREATE TABLE users (
	userid                   bigint                                    NOT NULL,
	username                 varchar(100)    DEFAULT ''                NOT NULL,
	name                     varchar(100)    DEFAULT ''                NOT NULL,
	surname                  varchar(100)    DEFAULT ''                NOT NULL,
	passwd                   varchar(60)     DEFAULT ''                NOT NULL,
	url                      varchar(2048)   DEFAULT ''                NOT NULL,
	autologin                integer         DEFAULT '0'               NOT NULL,
	autologout               varchar(32)     DEFAULT '15m'             NOT NULL,
	lang                     varchar(7)      DEFAULT 'default'         NOT NULL,
	refresh                  varchar(32)     DEFAULT '30s'             NOT NULL,
	theme                    varchar(128)    DEFAULT 'default'         NOT NULL,
	attempt_failed           integer         DEFAULT 0                 NOT NULL,
	attempt_ip               varchar(39)     DEFAULT ''                NOT NULL,
	attempt_clock            integer         DEFAULT 0                 NOT NULL,
	rows_per_page            integer         DEFAULT 50                NOT NULL,
	timezone                 varchar(50)     DEFAULT 'default'         NOT NULL,
	roleid                   bigint          ,
	userdirectoryid          bigint          ,
	ts_provisioned           integer         DEFAULT '0'               NOT NULL,
	PRIMARY KEY (userid)
);

-- CREATE INDEX users_2 ON users (userdirectoryid);
-- CREATE INDEX users_3 ON users (roleid);
CREATE TABLE maintenances (
	maintenanceid            bigint                                    NOT NULL,
	name                     varchar(128)    DEFAULT ''                NOT NULL,
	maintenance_type         integer         DEFAULT '0'               NOT NULL,
	description              text            DEFAULT ''                NOT NULL,
	active_since             integer         DEFAULT '0'               NOT NULL,
	active_till              integer         DEFAULT '0'               NOT NULL,
	tags_evaltype            integer         DEFAULT '0'               NOT NULL,
	PRIMARY KEY (maintenanceid)
);
-- CREATE INDEX maintenances_1 ON maintenances (active_since,active_till);

CREATE TABLE hosts (
	hostid                   bigint                                    NOT NULL,
	proxy_hostid             bigint,
	host                     varchar(128)    DEFAULT ''                NOT NULL,
	status                   integer         DEFAULT '0'               NOT NULL,
	ipmi_authtype            integer         DEFAULT '-1'              NOT NULL,
	ipmi_privilege           integer         DEFAULT '2'               NOT NULL,
	ipmi_username            varchar(16)     DEFAULT ''                NOT NULL,
	ipmi_password            varchar(20)     DEFAULT ''                NOT NULL,
	maintenanceid            bigint,
	maintenance_status       integer         DEFAULT '0'               NOT NULL,
	maintenance_type         integer         DEFAULT '0'               NOT NULL,
	maintenance_from         integer         DEFAULT '0'               NOT NULL,
	name                     varchar(128)    DEFAULT ''                NOT NULL,
	flags                    integer         DEFAULT '0'               NOT NULL,
	templateid               bigint,
	description              text            DEFAULT ''                NOT NULL,
	tls_connect              integer         DEFAULT '1'               NOT NULL,
	tls_accept               integer         DEFAULT '1'               NOT NULL,
	tls_issuer               varchar(1024)   DEFAULT ''                NOT NULL,
	tls_subject              varchar(1024)   DEFAULT ''                NOT NULL,
	tls_psk_identity         varchar(128)    DEFAULT ''                NOT NULL,
	tls_psk                  varchar(512)    DEFAULT ''                NOT NULL,
	proxy_address            varchar(255)    DEFAULT ''                NOT NULL,
	auto_compress            integer         DEFAULT '1'               NOT NULL,
	discover                 integer         DEFAULT '0'               NOT NULL,
	custom_interfaces        integer         DEFAULT '0'               NOT NULL,
	uuid                     varchar(32)     DEFAULT ''                NOT NULL,
	name_upper               varchar(128)    DEFAULT ''                NOT NULL,
	vendor_name              varchar(64)     DEFAULT ''                NOT NULL,
	vendor_version           varchar(32)     DEFAULT ''                NOT NULL,
	PRIMARY KEY (hostid)
);
-- CREATE INDEX hosts_1 ON hosts (host);
-- CREATE INDEX hosts_2 ON hosts (status);
-- CREATE INDEX hosts_3 ON hosts (proxy_hostid);
-- CREATE INDEX hosts_4 ON hosts (name);
-- CREATE INDEX hosts_5 ON hosts (maintenanceid);
-- CREATE INDEX hosts_6 ON hosts (name_upper);
-- CREATE INDEX hosts_7 ON hosts (templateid);
CREATE TABLE hstgrp (
	groupid                  bigint                                    NOT NULL,
	name                     varchar(255)    DEFAULT ''                NOT NULL,
	flags                    integer         DEFAULT '0'               NOT NULL,
	uuid                     varchar(32)     DEFAULT ''                NOT NULL,
	type                     integer         DEFAULT '0'               NOT NULL,
	PRIMARY KEY (groupid)
);

CREATE TABLE group_prototype (
	group_prototypeid        bigint                                    NOT NULL,
	hostid                   bigint                                    NOT NULL,
	name                     varchar(255)    DEFAULT ''                NOT NULL,
	groupid                  bigint,
	templateid               bigint,
	PRIMARY KEY (group_prototypeid)
);
-- CREATE INDEX group_prototype_1 ON group_prototype (hostid);
-- CREATE INDEX group_prototype_2 ON group_prototype (groupid);
-- CREATE INDEX group_prototype_3 ON group_prototype (templateid);
CREATE TABLE group_discovery (
	groupid                  bigint                                    NOT NULL,
	parent_group_prototypeid bigint                                    NOT NULL,
	name                     varchar(255)    DEFAULT ''                NOT NULL,
	lastcheck                integer         DEFAULT '0'               NOT NULL,
	ts_delete                integer         DEFAULT '0'               NOT NULL,
	PRIMARY KEY (groupid)
);
-- CREATE INDEX group_discovery_1 ON group_discovery (parent_group_prototypeid);
CREATE TABLE drules (
	druleid                  bigint                                    NOT NULL,
	proxy_hostid             bigint,
	name                     varchar(255)    DEFAULT ''                NOT NULL,
	iprange                  varchar(2048)   DEFAULT ''                NOT NULL,
	delay                    varchar(255)    DEFAULT '1h'              NOT NULL,
	status                   integer         DEFAULT '0'               NOT NULL,
	PRIMARY KEY (druleid)
);
-- CREATE INDEX drules_1 ON drules (proxy_hostid);

CREATE TABLE dchecks (
	dcheckid                 bigint                                    NOT NULL,
	druleid                  bigint                                    NOT NULL,
	type                     integer         DEFAULT '0'               NOT NULL,
	key_                     varchar(2048)   DEFAULT ''                NOT NULL,
	snmp_community           varchar(255)    DEFAULT ''                NOT NULL,
	ports                    varchar(255)    DEFAULT '0'               NOT NULL,
	snmpv3_securityname      varchar(64)     DEFAULT ''                NOT NULL,
	snmpv3_securitylevel     integer         DEFAULT '0'               NOT NULL,
	snmpv3_authpassphrase    varchar(64)     DEFAULT ''                NOT NULL,
	snmpv3_privpassphrase    varchar(64)     DEFAULT ''                NOT NULL,
	uniq                     integer         DEFAULT '0'               NOT NULL,
	snmpv3_authprotocol      integer         DEFAULT '0'               NOT NULL,
	snmpv3_privprotocol      integer         DEFAULT '0'               NOT NULL,
	snmpv3_contextname       varchar(255)    DEFAULT ''                NOT NULL,
	host_source              integer         DEFAULT '1'               NOT NULL,
	name_source              integer         DEFAULT '0'               NOT NULL,
	PRIMARY KEY (dcheckid)
);
-- CREATE INDEX dchecks_1 ON dchecks (druleid,host_source,name_source);
CREATE TABLE httptest (
	httptestid               bigint                                    NOT NULL,
	name                     varchar(64)     DEFAULT ''                NOT NULL,
	delay                    varchar(255)    DEFAULT '1m'              NOT NULL,
	status                   integer         DEFAULT '0'               NOT NULL,
	agent                    varchar(255)    DEFAULT 'Zabbix'          NOT NULL,
	authentication           integer         DEFAULT '0'               NOT NULL,
	http_user                varchar(64)     DEFAULT ''                NOT NULL,
	http_password            varchar(64)     DEFAULT ''                NOT NULL,
	hostid                   bigint                                    NOT NULL,
	templateid               bigint,
	http_proxy               varchar(255)    DEFAULT ''                NOT NULL,
	retries                  integer         DEFAULT '1'               NOT NULL,
	ssl_cert_file            varchar(255)    DEFAULT ''                NOT NULL,
	ssl_key_file             varchar(255)    DEFAULT ''                NOT NULL,
	ssl_key_password         varchar(64)     DEFAULT ''                NOT NULL,
	verify_peer              integer         DEFAULT '0'               NOT NULL,
	verify_host              integer         DEFAULT '0'               NOT NULL,
	uuid                     varchar(32)     DEFAULT ''                NOT NULL,
	PRIMARY KEY (httptestid)
);

-- CREATE INDEX httptest_3 ON httptest (status);
-- CREATE INDEX httptest_4 ON httptest (templateid);
CREATE TABLE httpstep (
	httpstepid               bigint                                    NOT NULL,
	httptestid               bigint                                    NOT NULL,
	name                     varchar(64)     DEFAULT ''                NOT NULL,
	no                       integer         DEFAULT '0'               NOT NULL,
	url                      varchar(2048)   DEFAULT ''                NOT NULL,
	timeout                  varchar(255)    DEFAULT '15s'             NOT NULL,
	posts                    text            DEFAULT ''                NOT NULL,
	required                 varchar(255)    DEFAULT ''                NOT NULL,
	status_codes             varchar(255)    DEFAULT ''                NOT NULL,
	follow_redirects         integer         DEFAULT '1'               NOT NULL,
	retrieve_mode            integer         DEFAULT '0'               NOT NULL,
	post_type                integer         DEFAULT '0'               NOT NULL,
	PRIMARY KEY (httpstepid)
);
-- CREATE INDEX httpstep_1 ON httpstep (httptestid);
CREATE TABLE interface (
	interfaceid              bigint                                    NOT NULL,
	hostid                   bigint                                    NOT NULL,
	main                     integer         DEFAULT '0'               NOT NULL,
	type                     integer         DEFAULT '1'               NOT NULL,
	useip                    integer         DEFAULT '1'               NOT NULL,
	ip                       varchar(64)     DEFAULT '127.0.0.1'       NOT NULL,
	dns                      varchar(255)    DEFAULT ''                NOT NULL,
	port                     varchar(64)     DEFAULT '10050'           NOT NULL,
	available                integer         DEFAULT '0'               NOT NULL,
	error                    varchar(2048)   DEFAULT ''                NOT NULL,
	errors_from              integer         DEFAULT '0'               NOT NULL,
	disable_until            integer         DEFAULT '0'               NOT NULL,
	PRIMARY KEY (interfaceid)
);
-- CREATE INDEX interface_1 ON interface (hostid,type);
-- CREATE INDEX interface_2 ON interface (ip,dns);
-- CREATE INDEX interface_3 ON interface (available);
CREATE TABLE valuemap (
	valuemapid               bigint                                    NOT NULL,
	hostid                   bigint                                    NOT NULL,
	name                     varchar(64)     DEFAULT ''                NOT NULL,
	uuid                     varchar(32)     DEFAULT ''                NOT NULL,
	PRIMARY KEY (valuemapid)
);

CREATE TABLE items (
	itemid                   bigint                                    NOT NULL,
	type                     integer         DEFAULT '0'               NOT NULL,
	snmp_oid                 varchar(512)    DEFAULT ''                NOT NULL,
	hostid                   bigint                                    NOT NULL,
	name                     varchar(255)    DEFAULT ''                NOT NULL,
	key_                     varchar(2048)   DEFAULT ''                NOT NULL,
	delay                    varchar(1024)   DEFAULT '0'               NOT NULL,
	history                  varchar(255)    DEFAULT '90d'             NOT NULL,
	trends                   varchar(255)    DEFAULT '365d'            NOT NULL,
	status                   integer         DEFAULT '0'               NOT NULL,
	value_type               integer         DEFAULT '0'               NOT NULL,
	trapper_hosts            varchar(255)    DEFAULT ''                NOT NULL,
	units                    varchar(255)    DEFAULT ''                NOT NULL,
	formula                  varchar(255)    DEFAULT ''                NOT NULL,
	logtimefmt               varchar(64)     DEFAULT ''                NOT NULL,
	templateid               bigint,
	valuemapid               bigint,
	params                   text            DEFAULT ''                NOT NULL,
	ipmi_sensor              varchar(128)    DEFAULT ''                NOT NULL,
	authtype                 integer         DEFAULT '0'               NOT NULL,
	username                 varchar(64)     DEFAULT ''                NOT NULL,
	password                 varchar(64)     DEFAULT ''                NOT NULL,
	publickey                varchar(64)     DEFAULT ''                NOT NULL,
	privatekey               varchar(64)     DEFAULT ''                NOT NULL,
	flags                    integer         DEFAULT '0'               NOT NULL,
	interfaceid              bigint,
	description              text            DEFAULT ''                NOT NULL,
	inventory_link           integer         DEFAULT '0'               NOT NULL,
	lifetime                 varchar(255)    DEFAULT '30d'             NOT NULL,
	evaltype                 integer         DEFAULT '0'               NOT NULL,
	jmx_endpoint             varchar(255)    DEFAULT ''                NOT NULL,
	master_itemid            bigint,
	timeout                  varchar(255)    DEFAULT '3s'              NOT NULL,
	url                      varchar(2048)   DEFAULT ''                NOT NULL,
	query_fields             varchar(2048)   DEFAULT ''                NOT NULL,
	posts                    text            DEFAULT ''                NOT NULL,
	status_codes             varchar(255)    DEFAULT '200'             NOT NULL,
	follow_redirects         integer         DEFAULT '1'               NOT NULL,
	post_type                integer         DEFAULT '0'               NOT NULL,
	http_proxy               varchar(255)    DEFAULT ''                NOT NULL,
	headers                  text            DEFAULT ''                NOT NULL,
	retrieve_mode            integer         DEFAULT '0'               NOT NULL,
	request_method           integer         DEFAULT '0'               NOT NULL,
	output_format            integer         DEFAULT '0'               NOT NULL,
	ssl_cert_file            varchar(255)    DEFAULT ''                NOT NULL,
	ssl_key_file             varchar(255)    DEFAULT ''                NOT NULL,
	ssl_key_password         varchar(64)     DEFAULT ''                NOT NULL,
	verify_peer              integer         DEFAULT '0'               NOT NULL,
	verify_host              integer         DEFAULT '0'               NOT NULL,
	allow_traps              integer         DEFAULT '0'               NOT NULL,
	discover                 integer         DEFAULT '0'               NOT NULL,
	uuid                     varchar(32)     DEFAULT ''                NOT NULL,
	name_upper               varchar(255)    DEFAULT ''                NOT NULL,
	PRIMARY KEY (itemid)
);
-- CREATE INDEX items_1 ON items (hostid,key_);
-- CREATE INDEX items_3 ON items (status);
-- CREATE INDEX items_4 ON items (templateid);
-- CREATE INDEX items_5 ON items (valuemapid);
-- CREATE INDEX items_6 ON items (interfaceid);
-- CREATE INDEX items_7 ON items (master_itemid);
-- CREATE INDEX items_8 ON items (key_);
-- CREATE INDEX items_9 ON items (hostid,name_upper);
CREATE TABLE httpstepitem (
	httpstepitemid           bigint                                    NOT NULL,
	httpstepid               bigint                                    NOT NULL,
	itemid                   bigint                                    NOT NULL,
	type                     integer         DEFAULT '0'               NOT NULL,
	PRIMARY KEY (httpstepitemid)
);

-- CREATE INDEX httpstepitem_2 ON httpstepitem (itemid);
CREATE TABLE httptestitem (
	httptestitemid           bigint                                    NOT NULL,
	httptestid               bigint                                    NOT NULL,
	itemid                   bigint                                    NOT NULL,
	type                     integer         DEFAULT '0'               NOT NULL,
	PRIMARY KEY (httptestitemid)
);

-- CREATE INDEX httptestitem_2 ON httptestitem (itemid);
CREATE TABLE media_type (
	mediatypeid              bigint                                    NOT NULL,
	type                     integer         DEFAULT '0'               NOT NULL,
	name                     varchar(100)    DEFAULT ''                NOT NULL,
	smtp_server              varchar(255)    DEFAULT ''                NOT NULL,
	smtp_helo                varchar(255)    DEFAULT ''                NOT NULL,
	smtp_email               varchar(255)    DEFAULT ''                NOT NULL,
	exec_path                varchar(255)    DEFAULT ''                NOT NULL,
	gsm_modem                varchar(255)    DEFAULT ''                NOT NULL,
	username                 varchar(255)    DEFAULT ''                NOT NULL,
	passwd                   varchar(255)    DEFAULT ''                NOT NULL,
	status                   integer         DEFAULT '1'               NOT NULL,
	smtp_port                integer         DEFAULT '25'              NOT NULL,
	smtp_security            integer         DEFAULT '0'               NOT NULL,
	smtp_verify_peer         integer         DEFAULT '0'               NOT NULL,
	smtp_verify_host         integer         DEFAULT '0'               NOT NULL,
	smtp_authentication      integer         DEFAULT '0'               NOT NULL,
	maxsessions              integer         DEFAULT '1'               NOT NULL,
	maxattempts              integer         DEFAULT '3'               NOT NULL,
	attempt_interval         varchar(32)     DEFAULT '10s'             NOT NULL,
	content_type             integer         DEFAULT '1'               NOT NULL,
	script                   text            DEFAULT ''                NOT NULL,
	timeout                  varchar(32)     DEFAULT '30s'             NOT NULL,
	process_tags             integer         DEFAULT '0'               NOT NULL,
	show_event_menu          integer         DEFAULT '0'               NOT NULL,
	event_menu_url           varchar(2048)   DEFAULT ''                NOT NULL,
	event_menu_name          varchar(255)    DEFAULT ''                NOT NULL,
	description              text            DEFAULT ''                NOT NULL,
	provider                 integer         DEFAULT '0'               NOT NULL,
	PRIMARY KEY (mediatypeid)
);

CREATE TABLE media_type_param (
	mediatype_paramid        bigint                                    NOT NULL,
	mediatypeid              bigint                                    NOT NULL,
	name                     varchar(255)    DEFAULT ''                NOT NULL,
	value                    varchar(2048)   DEFAULT ''                NOT NULL,
	sortorder                integer         DEFAULT '0'               NOT NULL,
	PRIMARY KEY (mediatype_paramid)
);
-- CREATE INDEX media_type_param_1 ON media_type_param (mediatypeid);
CREATE TABLE media_type_message (
	mediatype_messageid      bigint                                    NOT NULL,
	mediatypeid              bigint                                    NOT NULL,
	eventsource              integer                                   NOT NULL,
	recovery                 integer                                   NOT NULL,
	subject                  varchar(255)    DEFAULT ''                NOT NULL,
	message                  text            DEFAULT ''                NOT NULL,
	PRIMARY KEY (mediatype_messageid)
);

CREATE TABLE usrgrp (
	usrgrpid                 bigint                                    NOT NULL,
	name                     varchar(64)     DEFAULT ''                NOT NULL,
	gui_access               integer         DEFAULT '0'               NOT NULL,
	users_status             integer         DEFAULT '0'               NOT NULL,
	debug_mode               integer         DEFAULT '0'               NOT NULL,
	userdirectoryid          bigint          ,
	PRIMARY KEY (usrgrpid)
);

-- CREATE INDEX usrgrp_2 ON usrgrp (userdirectoryid);
CREATE TABLE users_groups (
	id                       bigint                                    NOT NULL,
	usrgrpid                 bigint                                    NOT NULL,
	userid                   bigint                                    NOT NULL,
	PRIMARY KEY (id)
);

-- CREATE INDEX users_groups_2 ON users_groups (userid);
CREATE TABLE scripts (
	scriptid                 bigint                                    NOT NULL,
	name                     varchar(255)    DEFAULT ''                NOT NULL,
	command                  text            DEFAULT ''                NOT NULL,
	host_access              integer         DEFAULT '2'               NOT NULL,
	usrgrpid                 bigint,
	groupid                  bigint,
	description              text            DEFAULT ''                NOT NULL,
	confirmation             varchar(255)    DEFAULT ''                NOT NULL,
	type                     integer         DEFAULT '5'               NOT NULL,
	execute_on               integer         DEFAULT '2'               NOT NULL,
	timeout                  varchar(32)     DEFAULT '30s'             NOT NULL,
	scope                    integer         DEFAULT '1'               NOT NULL,
	port                     varchar(64)     DEFAULT ''                NOT NULL,
	authtype                 integer         DEFAULT '0'               NOT NULL,
	username                 varchar(64)     DEFAULT ''                NOT NULL,
	password                 varchar(64)     DEFAULT ''                NOT NULL,
	publickey                varchar(64)     DEFAULT ''                NOT NULL,
	privatekey               varchar(64)     DEFAULT ''                NOT NULL,
	menu_path                varchar(255)    DEFAULT ''                NOT NULL,
	url                      varchar(2048)   DEFAULT ''                NOT NULL,
	new_window               integer         DEFAULT '1'               NOT NULL,
	PRIMARY KEY (scriptid)
);
-- CREATE INDEX scripts_1 ON scripts (usrgrpid);
-- CREATE INDEX scripts_2 ON scripts (groupid);

CREATE TABLE script_param (
	script_paramid           bigint                                    NOT NULL,
	scriptid                 bigint                                    NOT NULL,
	name                     varchar(255)    DEFAULT ''                NOT NULL,
	value                    varchar(2048)   DEFAULT ''                NOT NULL,
	PRIMARY KEY (script_paramid)
);

CREATE TABLE actions (
	actionid                 bigint                                    NOT NULL,
	name                     varchar(255)    DEFAULT ''                NOT NULL,
	eventsource              integer         DEFAULT '0'               NOT NULL,
	evaltype                 integer         DEFAULT '0'               NOT NULL,
	status                   integer         DEFAULT '0'               NOT NULL,
	esc_period               varchar(255)    DEFAULT '1h'              NOT NULL,
	formula                  varchar(1024)   DEFAULT ''                NOT NULL,
	pause_suppressed         integer         DEFAULT '1'               NOT NULL,
	notify_if_canceled       integer         DEFAULT '1'               NOT NULL,
	pause_symptoms           integer         DEFAULT '1'               NOT NULL,
	PRIMARY KEY (actionid)
);
-- CREATE INDEX actions_1 ON actions (eventsource,status);

CREATE TABLE operations (
	operationid              bigint                                    NOT NULL,
	actionid                 bigint                                    NOT NULL,
	operationtype            integer         DEFAULT '0'               NOT NULL,
	esc_period               varchar(255)    DEFAULT '0'               NOT NULL,
	esc_step_from            integer         DEFAULT '1'               NOT NULL,
	esc_step_to              integer         DEFAULT '1'               NOT NULL,
	evaltype                 integer         DEFAULT '0'               NOT NULL,
	recovery                 integer         DEFAULT '0'               NOT NULL,
	PRIMARY KEY (operationid)
);
-- CREATE INDEX operations_1 ON operations (actionid);
CREATE TABLE opmessage (
	operationid              bigint                                    NOT NULL,
	default_msg              integer         DEFAULT '1'               NOT NULL,
	subject                  varchar(255)    DEFAULT ''                NOT NULL,
	message                  text            DEFAULT ''                NOT NULL,
	mediatypeid              bigint,
	PRIMARY KEY (operationid)
);
-- CREATE INDEX opmessage_1 ON opmessage (mediatypeid);
CREATE TABLE opmessage_grp (
	opmessage_grpid          bigint                                    NOT NULL,
	operationid              bigint                                    NOT NULL,
	usrgrpid                 bigint                                    NOT NULL,
	PRIMARY KEY (opmessage_grpid)
);

-- CREATE INDEX opmessage_grp_2 ON opmessage_grp (usrgrpid);
CREATE TABLE opmessage_usr (
	opmessage_usrid          bigint                                    NOT NULL,
	operationid              bigint                                    NOT NULL,
	userid                   bigint                                    NOT NULL,
	PRIMARY KEY (opmessage_usrid)
);

-- CREATE INDEX opmessage_usr_2 ON opmessage_usr (userid);
CREATE TABLE opcommand (
	operationid              bigint                                    NOT NULL,
	scriptid                 bigint                                    NOT NULL,
	PRIMARY KEY (operationid)
);
-- CREATE INDEX opcommand_1 ON opcommand (scriptid);
CREATE TABLE opcommand_hst (
	opcommand_hstid          bigint                                    NOT NULL,
	operationid              bigint                                    NOT NULL,
	hostid                   bigint,
	PRIMARY KEY (opcommand_hstid)
);
-- CREATE INDEX opcommand_hst_1 ON opcommand_hst (operationid);
-- CREATE INDEX opcommand_hst_2 ON opcommand_hst (hostid);
CREATE TABLE opcommand_grp (
	opcommand_grpid          bigint                                    NOT NULL,
	operationid              bigint                                    NOT NULL,
	groupid                  bigint                                    NOT NULL,
	PRIMARY KEY (opcommand_grpid)
);
-- CREATE INDEX opcommand_grp_1 ON opcommand_grp (operationid);
-- CREATE INDEX opcommand_grp_2 ON opcommand_grp (groupid);
CREATE TABLE opgroup (
	opgroupid                bigint                                    NOT NULL,
	operationid              bigint                                    NOT NULL,
	groupid                  bigint                                    NOT NULL,
	PRIMARY KEY (opgroupid)
);

-- CREATE INDEX opgroup_2 ON opgroup (groupid);
CREATE TABLE optemplate (
	optemplateid             bigint                                    NOT NULL,
	operationid              bigint                                    NOT NULL,
	templateid               bigint                                    NOT NULL,
	PRIMARY KEY (optemplateid)
);

-- CREATE INDEX optemplate_2 ON optemplate (templateid);
CREATE TABLE opconditions (
	opconditionid            bigint                                    NOT NULL,
	operationid              bigint                                    NOT NULL,
	conditiontype            integer         DEFAULT '0'               NOT NULL,
	operator                 integer         DEFAULT '0'               NOT NULL,
	value                    varchar(255)    DEFAULT ''                NOT NULL,
	PRIMARY KEY (opconditionid)
);
-- CREATE INDEX opconditions_1 ON opconditions (operationid);
CREATE TABLE conditions (
	conditionid              bigint                                    NOT NULL,
	actionid                 bigint                                    NOT NULL,
	conditiontype            integer         DEFAULT '0'               NOT NULL,
	operator                 integer         DEFAULT '0'               NOT NULL,
	value                    varchar(255)    DEFAULT ''                NOT NULL,
	value2                   varchar(255)    DEFAULT ''                NOT NULL,
	PRIMARY KEY (conditionid)
);
-- CREATE INDEX conditions_1 ON conditions (actionid);
CREATE TABLE config (
	configid                 bigint                                    NOT NULL,
	work_period              varchar(255)    DEFAULT '1-5,09:00-18:00' NOT NULL,
	alert_usrgrpid           bigint,
	default_theme            varchar(128)    DEFAULT 'blue-theme'      NOT NULL,
	authentication_type      integer         DEFAULT '0'               NOT NULL,
	discovery_groupid        bigint,
	max_in_table             integer         DEFAULT '50'              NOT NULL,
	search_limit             integer         DEFAULT '1000'            NOT NULL,
	severity_color_0         varchar(6)      DEFAULT '97AAB3'          NOT NULL,
	severity_color_1         varchar(6)      DEFAULT '7499FF'          NOT NULL,
	severity_color_2         varchar(6)      DEFAULT 'FFC859'          NOT NULL,
	severity_color_3         varchar(6)      DEFAULT 'FFA059'          NOT NULL,
	severity_color_4         varchar(6)      DEFAULT 'E97659'          NOT NULL,
	severity_color_5         varchar(6)      DEFAULT 'E45959'          NOT NULL,
	severity_name_0          varchar(32)     DEFAULT 'Not classified'  NOT NULL,
	severity_name_1          varchar(32)     DEFAULT 'Information'     NOT NULL,
	severity_name_2          varchar(32)     DEFAULT 'Warning'         NOT NULL,
	severity_name_3          varchar(32)     DEFAULT 'Average'         NOT NULL,
	severity_name_4          varchar(32)     DEFAULT 'High'            NOT NULL,
	severity_name_5          varchar(32)     DEFAULT 'Disaster'        NOT NULL,
	ok_period                varchar(32)     DEFAULT '5m'              NOT NULL,
	blink_period             varchar(32)     DEFAULT '2m'              NOT NULL,
	problem_unack_color      varchar(6)      DEFAULT 'CC0000'          NOT NULL,
	problem_ack_color        varchar(6)      DEFAULT 'CC0000'          NOT NULL,
	ok_unack_color           varchar(6)      DEFAULT '009900'          NOT NULL,
	ok_ack_color             varchar(6)      DEFAULT '009900'          NOT NULL,
	problem_unack_style      integer         DEFAULT '1'               NOT NULL,
	problem_ack_style        integer         DEFAULT '1'               NOT NULL,
	ok_unack_style           integer         DEFAULT '1'               NOT NULL,
	ok_ack_style             integer         DEFAULT '1'               NOT NULL,
	snmptrap_logging         integer         DEFAULT '1'               NOT NULL,
	server_check_interval    integer         DEFAULT '10'              NOT NULL,
	hk_events_mode           integer         DEFAULT '1'               NOT NULL,
	hk_events_trigger        varchar(32)     DEFAULT '365d'            NOT NULL,
	hk_events_internal       varchar(32)     DEFAULT '1d'              NOT NULL,
	hk_events_discovery      varchar(32)     DEFAULT '1d'              NOT NULL,
	hk_events_autoreg        varchar(32)     DEFAULT '1d'              NOT NULL,
	hk_services_mode         integer         DEFAULT '1'               NOT NULL,
	hk_services              varchar(32)     DEFAULT '365d'            NOT NULL,
	hk_audit_mode            integer         DEFAULT '1'               NOT NULL,
	hk_audit                 varchar(32)     DEFAULT '365d'            NOT NULL,
	hk_sessions_mode         integer         DEFAULT '1'               NOT NULL,
	hk_sessions              varchar(32)     DEFAULT '365d'            NOT NULL,
	hk_history_mode          integer         DEFAULT '1'               NOT NULL,
	hk_history_global        integer         DEFAULT '0'               NOT NULL,
	hk_history               varchar(32)     DEFAULT '90d'             NOT NULL,
	hk_trends_mode           integer         DEFAULT '1'               NOT NULL,
	hk_trends_global         integer         DEFAULT '0'               NOT NULL,
	hk_trends                varchar(32)     DEFAULT '365d'            NOT NULL,
	default_inventory_mode   integer         DEFAULT '-1'              NOT NULL,
	custom_color             integer         DEFAULT '0'               NOT NULL,
	http_auth_enabled        integer         DEFAULT '0'               NOT NULL,
	http_login_form          integer         DEFAULT '0'               NOT NULL,
	http_strip_domains       varchar(2048)   DEFAULT ''                NOT NULL,
	http_case_sensitive      integer         DEFAULT '1'               NOT NULL,
	ldap_auth_enabled        integer         DEFAULT '0'               NOT NULL,
	ldap_case_sensitive      integer         DEFAULT '1'               NOT NULL,
	db_extension             varchar(32)     DEFAULT ''                NOT NULL,
	autoreg_tls_accept       integer         DEFAULT '1'               NOT NULL,
	compression_status       integer         DEFAULT '0'               NOT NULL,
	compress_older           varchar(32)     DEFAULT '7d'              NOT NULL,
	instanceid               varchar(32)     DEFAULT ''                NOT NULL,
	saml_auth_enabled        integer         DEFAULT '0'               NOT NULL,
	saml_case_sensitive      integer         DEFAULT '0'               NOT NULL,
	default_lang             varchar(5)      DEFAULT 'en_US'           NOT NULL,
	default_timezone         varchar(50)     DEFAULT 'system'          NOT NULL,
	login_attempts           integer         DEFAULT '5'               NOT NULL,
	login_block              varchar(32)     DEFAULT '30s'             NOT NULL,
	show_technical_errors    integer         DEFAULT '0'               NOT NULL,
	validate_uri_schemes     integer         DEFAULT '1'               NOT NULL,
	uri_valid_schemes        varchar(255)    DEFAULT 'http,https,ftp,file,mailto,tel,ssh' NOT NULL,
	x_frame_options          varchar(255)    DEFAULT 'SAMEORIGIN'      NOT NULL,
	iframe_sandboxing_enabled integer         DEFAULT '1'               NOT NULL,
	iframe_sandboxing_exceptions varchar(255)    DEFAULT ''                NOT NULL,
	max_overview_table_size  integer         DEFAULT '50'              NOT NULL,
	history_period           varchar(32)     DEFAULT '24h'             NOT NULL,
	period_default           varchar(32)     DEFAULT '1h'              NOT NULL,
	max_period               varchar(32)     DEFAULT '2y'              NOT NULL,
	socket_timeout           varchar(32)     DEFAULT '3s'              NOT NULL,
	connect_timeout          varchar(32)     DEFAULT '3s'              NOT NULL,
	media_type_test_timeout  varchar(32)     DEFAULT '65s'             NOT NULL,
	script_timeout           varchar(32)     DEFAULT '60s'             NOT NULL,
	item_test_timeout        varchar(32)     DEFAULT '60s'             NOT NULL,
	session_key              varchar(32)     DEFAULT ''                NOT NULL,
	url                      varchar(255)    DEFAULT ''                NOT NULL,
	report_test_timeout      varchar(32)     DEFAULT '60s'             NOT NULL,
	dbversion_status         text            DEFAULT ''                NOT NULL,
	hk_events_service        varchar(32)     DEFAULT '1d'              NOT NULL,
	passwd_min_length        integer         DEFAULT '8'               NOT NULL,
	passwd_check_rules       integer         DEFAULT '8'               NOT NULL,
	auditlog_enabled         integer         DEFAULT '1'               NOT NULL,
	ha_failover_delay        varchar(32)     DEFAULT '1m'              NOT NULL,
	geomaps_tile_provider    varchar(255)    DEFAULT ''                NOT NULL,
	geomaps_tile_url         varchar(1024)   DEFAULT ''                NOT NULL,
	geomaps_max_zoom         integer         DEFAULT '0'               NOT NULL,
	geomaps_attribution      varchar(1024)   DEFAULT ''                NOT NULL,
	vault_provider           integer         DEFAULT '0'               NOT NULL,
	ldap_userdirectoryid     bigint          ,
	server_status            text            DEFAULT ''                NOT NULL,
	jit_provision_interval   varchar(32)     DEFAULT '1h'              NOT NULL,
	saml_jit_status          integer         DEFAULT '0'               NOT NULL,
	ldap_jit_status          integer         DEFAULT '0'               NOT NULL,
	disabled_usrgrpid        bigint          ,
	PRIMARY KEY (configid)
);
-- CREATE INDEX config_1 ON config (alert_usrgrpid);
-- CREATE INDEX config_2 ON config (discovery_groupid);
-- CREATE INDEX config_3 ON config (ldap_userdirectoryid);
-- CREATE INDEX config_4 ON config (disabled_usrgrpid);
CREATE TABLE triggers (
	triggerid                bigint                                    NOT NULL,
	expression               varchar(2048)   DEFAULT ''                NOT NULL,
	description              varchar(255)    DEFAULT ''                NOT NULL,
	url                      varchar(2048)   DEFAULT ''                NOT NULL,
	status                   integer         DEFAULT '0'               NOT NULL,
	value                    integer         DEFAULT '0'               NOT NULL,
	priority                 integer         DEFAULT '0'               NOT NULL,
	lastchange               integer         DEFAULT '0'               NOT NULL,
	comments                 text            DEFAULT ''                NOT NULL,
	error                    varchar(2048)   DEFAULT ''                NOT NULL,
	templateid               bigint,
	type                     integer         DEFAULT '0'               NOT NULL,
	state                    integer         DEFAULT '0'               NOT NULL,
	flags                    integer         DEFAULT '0'               NOT NULL,
	recovery_mode            integer         DEFAULT '0'               NOT NULL,
	recovery_expression      varchar(2048)   DEFAULT ''                NOT NULL,
	correlation_mode         integer         DEFAULT '0'               NOT NULL,
	correlation_tag          varchar(255)    DEFAULT ''                NOT NULL,
	manual_close             integer         DEFAULT '0'               NOT NULL,
	opdata                   varchar(255)    DEFAULT ''                NOT NULL,
	discover                 integer         DEFAULT '0'               NOT NULL,
	event_name               varchar(2048)   DEFAULT ''                NOT NULL,
	uuid                     varchar(32)     DEFAULT ''                NOT NULL,
	url_name                 varchar(64)     DEFAULT ''                NOT NULL,
	PRIMARY KEY (triggerid)
);
-- CREATE INDEX triggers_1 ON triggers (status);
-- CREATE INDEX triggers_2 ON triggers (value,lastchange);
-- CREATE INDEX triggers_3 ON triggers (templateid);
CREATE TABLE trigger_depends (
	triggerdepid             bigint                                    NOT NULL,
	triggerid_down           bigint                                    NOT NULL,
	triggerid_up             bigint                                    NOT NULL,
	PRIMARY KEY (triggerdepid)
);

-- CREATE INDEX trigger_depends_2 ON trigger_depends (triggerid_up);
CREATE TABLE functions (
	functionid               bigint                                    NOT NULL,
	itemid                   bigint                                    NOT NULL,
	triggerid                bigint                                    NOT NULL,
	name                     varchar(12)     DEFAULT ''                NOT NULL,
	parameter                varchar(255)    DEFAULT '0'               NOT NULL,
	PRIMARY KEY (functionid)
);
-- CREATE INDEX functions_1 ON functions (triggerid);
-- CREATE INDEX functions_2 ON functions (itemid,name,parameter);
CREATE TABLE graphs (
	graphid                  bigint                                    NOT NULL,
	name                     varchar(128)    DEFAULT ''                NOT NULL,
	width                    integer         DEFAULT '900'             NOT NULL,
	height                   integer         DEFAULT '200'             NOT NULL,
	yaxismin                 DOUBLE PRECISION DEFAULT '0'               NOT NULL,
	yaxismax                 DOUBLE PRECISION DEFAULT '100'             NOT NULL,
	templateid               bigint,
	show_work_period         integer         DEFAULT '1'               NOT NULL,
	show_triggers            integer         DEFAULT '1'               NOT NULL,
	graphtype                integer         DEFAULT '0'               NOT NULL,
	show_legend              integer         DEFAULT '1'               NOT NULL,
	show_3d                  integer         DEFAULT '0'               NOT NULL,
	percent_left             DOUBLE PRECISION DEFAULT '0'               NOT NULL,
	percent_right            DOUBLE PRECISION DEFAULT '0'               NOT NULL,
	ymin_type                integer         DEFAULT '0'               NOT NULL,
	ymax_type                integer         DEFAULT '0'               NOT NULL,
	ymin_itemid              bigint,
	ymax_itemid              bigint,
	flags                    integer         DEFAULT '0'               NOT NULL,
	discover                 integer         DEFAULT '0'               NOT NULL,
	uuid                     varchar(32)     DEFAULT ''                NOT NULL,
	PRIMARY KEY (graphid)
);
-- CREATE INDEX graphs_1 ON graphs (name);
-- CREATE INDEX graphs_2 ON graphs (templateid);
-- CREATE INDEX graphs_3 ON graphs (ymin_itemid);
-- CREATE INDEX graphs_4 ON graphs (ymax_itemid);
CREATE TABLE graphs_items (
	gitemid                  bigint                                    NOT NULL,
	graphid                  bigint                                    NOT NULL,
	itemid                   bigint                                    NOT NULL,
	drawtype                 integer         DEFAULT '0'               NOT NULL,
	sortorder                integer         DEFAULT '0'               NOT NULL,
	color                    varchar(6)      DEFAULT '009600'          NOT NULL,
	yaxisside                integer         DEFAULT '0'               NOT NULL,
	calc_fnc                 integer         DEFAULT '2'               NOT NULL,
	type                     integer         DEFAULT '0'               NOT NULL,
	PRIMARY KEY (gitemid)
);
-- CREATE INDEX graphs_items_1 ON graphs_items (itemid);
-- CREATE INDEX graphs_items_2 ON graphs_items (graphid);
CREATE TABLE graph_theme (
	graphthemeid             bigint                                    NOT NULL,
	theme                    varchar(64)     DEFAULT ''                NOT NULL,
	backgroundcolor          varchar(6)      DEFAULT ''                NOT NULL,
	graphcolor               varchar(6)      DEFAULT ''                NOT NULL,
	gridcolor                varchar(6)      DEFAULT ''                NOT NULL,
	maingridcolor            varchar(6)      DEFAULT ''                NOT NULL,
	gridbordercolor          varchar(6)      DEFAULT ''                NOT NULL,
	textcolor                varchar(6)      DEFAULT ''                NOT NULL,
	highlightcolor           varchar(6)      DEFAULT ''                NOT NULL,
	leftpercentilecolor      varchar(6)      DEFAULT ''                NOT NULL,
	rightpercentilecolor     varchar(6)      DEFAULT ''                NOT NULL,
	nonworktimecolor         varchar(6)      DEFAULT ''                NOT NULL,
	colorpalette             varchar(255)    DEFAULT ''                NOT NULL,
	PRIMARY KEY (graphthemeid)
);

CREATE TABLE globalmacro (
	globalmacroid            bigint                                    NOT NULL,
	macro                    varchar(255)    DEFAULT ''                NOT NULL,
	value                    varchar(2048)   DEFAULT ''                NOT NULL,
	description              text            DEFAULT ''                NOT NULL,
	type                     integer         DEFAULT '0'               NOT NULL,
	PRIMARY KEY (globalmacroid)
);

CREATE TABLE hostmacro (
	hostmacroid              bigint                                    NOT NULL,
	hostid                   bigint                                    NOT NULL,
	macro                    varchar(255)    DEFAULT ''                NOT NULL,
	value                    varchar(2048)   DEFAULT ''                NOT NULL,
	description              text            DEFAULT ''                NOT NULL,
	type                     integer         DEFAULT '0'               NOT NULL,
	automatic                integer         DEFAULT '0'               NOT NULL,
	PRIMARY KEY (hostmacroid)
);

CREATE TABLE hosts_groups (
	hostgroupid              bigint                                    NOT NULL,
	hostid                   bigint                                    NOT NULL,
	groupid                  bigint                                    NOT NULL,
	PRIMARY KEY (hostgroupid)
);

-- CREATE INDEX hosts_groups_2 ON hosts_groups (groupid);
CREATE TABLE hosts_templates (
	hosttemplateid           bigint                                    NOT NULL,
	hostid                   bigint                                    NOT NULL,
	templateid               bigint                                    NOT NULL,
	link_type                integer         DEFAULT '0'               NOT NULL,
	PRIMARY KEY (hosttemplateid)
);

-- CREATE INDEX hosts_templates_2 ON hosts_templates (templateid);
CREATE TABLE valuemap_mapping (
	valuemap_mappingid       bigint                                    NOT NULL,
	valuemapid               bigint                                    NOT NULL,
	value                    varchar(64)     DEFAULT ''                NOT NULL,
	newvalue                 varchar(64)     DEFAULT ''                NOT NULL,
	type                     integer         DEFAULT '0'               NOT NULL,
	sortorder                integer         DEFAULT '0'               NOT NULL,
	PRIMARY KEY (valuemap_mappingid)
);

CREATE TABLE media (
	mediaid                  bigint                                    NOT NULL,
	userid                   bigint                                    NOT NULL,
	mediatypeid              bigint                                    NOT NULL,
	sendto                   varchar(1024)   DEFAULT ''                NOT NULL,
	active                   integer         DEFAULT '0'               NOT NULL,
	severity                 integer         DEFAULT '63'              NOT NULL,
	period                   varchar(1024)   DEFAULT '1-7,00:00-24:00' NOT NULL,
	PRIMARY KEY (mediaid)
);
-- CREATE INDEX media_1 ON media (userid);
-- CREATE INDEX media_2 ON media (mediatypeid);
CREATE TABLE rights (
	rightid                  bigint                                    NOT NULL,
	groupid                  bigint                                    NOT NULL,
	permission               integer         DEFAULT '0'               NOT NULL,
	id                       bigint                                    NOT NULL,
	PRIMARY KEY (rightid)
);
-- CREATE INDEX rights_1 ON rights (groupid);
-- CREATE INDEX rights_2 ON rights (id);
CREATE TABLE services (
	serviceid                bigint                                    NOT NULL,
	name                     varchar(128)    DEFAULT ''                NOT NULL,
	status                   integer         DEFAULT '-1'              NOT NULL,
	algorithm                integer         DEFAULT '0'               NOT NULL,
	sortorder                integer         DEFAULT '0'               NOT NULL,
	weight                   integer         DEFAULT '0'               NOT NULL,
	propagation_rule         integer         DEFAULT '0'               NOT NULL,
	propagation_value        integer         DEFAULT '0'               NOT NULL,
	description              text            DEFAULT ''                NOT NULL,
	uuid                     varchar(32)     DEFAULT ''                NOT NULL,
	created_at               integer         DEFAULT '0'               NOT NULL,
	PRIMARY KEY (serviceid)
);
CREATE TABLE services_links (
	linkid                   bigint                                    NOT NULL,
	serviceupid              bigint                                    NOT NULL,
	servicedownid            bigint                                    NOT NULL,
	PRIMARY KEY (linkid)
);
-- CREATE INDEX services_links_1 ON services_links (servicedownid);

CREATE TABLE icon_map (
	iconmapid                bigint                                    NOT NULL,
	name                     varchar(64)     DEFAULT ''                NOT NULL,
	default_iconid           bigint                                    NOT NULL,
	PRIMARY KEY (iconmapid)
);

-- CREATE INDEX icon_map_2 ON icon_map (default_iconid);
CREATE TABLE icon_mapping (
	iconmappingid            bigint                                    NOT NULL,
	iconmapid                bigint                                    NOT NULL,
	iconid                   bigint                                    NOT NULL,
	inventory_link           integer         DEFAULT '0'               NOT NULL,
	expression               varchar(64)     DEFAULT ''                NOT NULL,
	sortorder                integer         DEFAULT '0'               NOT NULL,
	PRIMARY KEY (iconmappingid)
);
-- CREATE INDEX icon_mapping_1 ON icon_mapping (iconmapid);
-- CREATE INDEX icon_mapping_2 ON icon_mapping (iconid);
CREATE TABLE sysmaps (
	sysmapid                 bigint                                    NOT NULL,
	name                     varchar(128)    DEFAULT ''                NOT NULL,
	width                    integer         DEFAULT '600'             NOT NULL,
	height                   integer         DEFAULT '400'             NOT NULL,
	backgroundid             bigint,
	label_type               integer         DEFAULT '2'               NOT NULL,
	label_location           integer         DEFAULT '0'               NOT NULL,
	highlight                integer         DEFAULT '1'               NOT NULL,
	expandproblem            integer         DEFAULT '1'               NOT NULL,
	markelements             integer         DEFAULT '0'               NOT NULL,
	show_unack               integer         DEFAULT '0'               NOT NULL,
	grid_size                integer         DEFAULT '50'              NOT NULL,
	grid_show                integer         DEFAULT '1'               NOT NULL,
	grid_align               integer         DEFAULT '1'               NOT NULL,
	label_format             integer         DEFAULT '0'               NOT NULL,
	label_type_host          integer         DEFAULT '2'               NOT NULL,
	label_type_hostgroup     integer         DEFAULT '2'               NOT NULL,
	label_type_trigger       integer         DEFAULT '2'               NOT NULL,
	label_type_map           integer         DEFAULT '2'               NOT NULL,
	label_type_image         integer         DEFAULT '2'               NOT NULL,
	label_string_host        varchar(255)    DEFAULT ''                NOT NULL,
	label_string_hostgroup   varchar(255)    DEFAULT ''                NOT NULL,
	label_string_trigger     varchar(255)    DEFAULT ''                NOT NULL,
	label_string_map         varchar(255)    DEFAULT ''                NOT NULL,
	label_string_image       varchar(255)    DEFAULT ''                NOT NULL,
	iconmapid                bigint,
	expand_macros            integer         DEFAULT '0'               NOT NULL,
	severity_min             integer         DEFAULT '0'               NOT NULL,
	userid                   bigint                                    NOT NULL,
	private                  integer         DEFAULT '1'               NOT NULL,
	show_suppressed          integer         DEFAULT '0'               NOT NULL,
	PRIMARY KEY (sysmapid)
);

-- CREATE INDEX sysmaps_2 ON sysmaps (backgroundid);
-- CREATE INDEX sysmaps_3 ON sysmaps (iconmapid);
-- CREATE INDEX sysmaps_4 ON sysmaps (userid);
CREATE TABLE sysmaps_elements (
	selementid               bigint                                    NOT NULL,
	sysmapid                 bigint                                    NOT NULL,
	elementid                bigint          DEFAULT '0'               NOT NULL,
	elementtype              integer         DEFAULT '0'               NOT NULL,
	iconid_off               bigint,
	iconid_on                bigint,
	label                    varchar(2048)   DEFAULT ''                NOT NULL,
	label_location           integer         DEFAULT '-1'              NOT NULL,
	x                        integer         DEFAULT '0'               NOT NULL,
	y                        integer         DEFAULT '0'               NOT NULL,
	iconid_disabled          bigint,
	iconid_maintenance       bigint,
	elementsubtype           integer         DEFAULT '0'               NOT NULL,
	areatype                 integer         DEFAULT '0'               NOT NULL,
	width                    integer         DEFAULT '200'             NOT NULL,
	height                   integer         DEFAULT '200'             NOT NULL,
	viewtype                 integer         DEFAULT '0'               NOT NULL,
	use_iconmap              integer         DEFAULT '1'               NOT NULL,
	evaltype                 integer         DEFAULT '0'               NOT NULL,
	PRIMARY KEY (selementid)
);
-- CREATE INDEX sysmaps_elements_1 ON sysmaps_elements (sysmapid);
-- CREATE INDEX sysmaps_elements_2 ON sysmaps_elements (iconid_off);
-- CREATE INDEX sysmaps_elements_3 ON sysmaps_elements (iconid_on);
-- CREATE INDEX sysmaps_elements_4 ON sysmaps_elements (iconid_disabled);
-- CREATE INDEX sysmaps_elements_5 ON sysmaps_elements (iconid_maintenance);
CREATE TABLE sysmaps_links (
	linkid                   bigint                                    NOT NULL,
	sysmapid                 bigint                                    NOT NULL,
	selementid1              bigint                                    NOT NULL,
	selementid2              bigint                                    NOT NULL,
	drawtype                 integer         DEFAULT '0'               NOT NULL,
	color                    varchar(6)      DEFAULT '000000'          NOT NULL,
	label                    varchar(2048)   DEFAULT ''                NOT NULL,
	PRIMARY KEY (linkid)
);
-- CREATE INDEX sysmaps_links_1 ON sysmaps_links (sysmapid);
-- CREATE INDEX sysmaps_links_2 ON sysmaps_links (selementid1);
-- CREATE INDEX sysmaps_links_3 ON sysmaps_links (selementid2);
CREATE TABLE sysmaps_link_triggers (
	linktriggerid            bigint                                    NOT NULL,
	linkid                   bigint                                    NOT NULL,
	triggerid                bigint                                    NOT NULL,
	drawtype                 integer         DEFAULT '0'               NOT NULL,
	color                    varchar(6)      DEFAULT '000000'          NOT NULL,
	PRIMARY KEY (linktriggerid)
);

-- CREATE INDEX sysmaps_link_triggers_2 ON sysmaps_link_triggers (triggerid);
CREATE TABLE sysmap_element_url (
	sysmapelementurlid       bigint                                    NOT NULL,
	selementid               bigint                                    NOT NULL,
	name                     varchar(255)                              NOT NULL,
	url                      varchar(255)    DEFAULT ''                NOT NULL,
	PRIMARY KEY (sysmapelementurlid)
);

CREATE TABLE sysmap_url (
	sysmapurlid              bigint                                    NOT NULL,
	sysmapid                 bigint                                    NOT NULL,
	name                     varchar(255)                              NOT NULL,
	url                      varchar(255)    DEFAULT ''                NOT NULL,
	elementtype              integer         DEFAULT '0'               NOT NULL,
	PRIMARY KEY (sysmapurlid)
);

CREATE TABLE sysmap_user (
	sysmapuserid             bigint                                    NOT NULL,
	sysmapid                 bigint                                    NOT NULL,
	userid                   bigint                                    NOT NULL,
	permission               integer         DEFAULT '2'               NOT NULL,
	PRIMARY KEY (sysmapuserid)
);

-- CREATE INDEX sysmap_user_2 ON sysmap_user (userid);
CREATE TABLE sysmap_usrgrp (
	sysmapusrgrpid           bigint                                    NOT NULL,
	sysmapid                 bigint                                    NOT NULL,
	usrgrpid                 bigint                                    NOT NULL,
	permission               integer         DEFAULT '2'               NOT NULL,
	PRIMARY KEY (sysmapusrgrpid)
);

-- CREATE INDEX sysmap_usrgrp_2 ON sysmap_usrgrp (usrgrpid);
CREATE TABLE maintenances_hosts (
	maintenance_hostid       bigint                                    NOT NULL,
	maintenanceid            bigint                                    NOT NULL,
	hostid                   bigint                                    NOT NULL,
	PRIMARY KEY (maintenance_hostid)
);

-- CREATE INDEX maintenances_hosts_2 ON maintenances_hosts (hostid);
CREATE TABLE maintenances_groups (
	maintenance_groupid      bigint                                    NOT NULL,
	maintenanceid            bigint                                    NOT NULL,
	groupid                  bigint                                    NOT NULL,
	PRIMARY KEY (maintenance_groupid)
);

-- CREATE INDEX maintenances_groups_2 ON maintenances_groups (groupid);
CREATE TABLE timeperiods (
	timeperiodid             bigint                                    NOT NULL,
	timeperiod_type          integer         DEFAULT '0'               NOT NULL,
	every                    integer         DEFAULT '1'               NOT NULL,
	month                    integer         DEFAULT '0'               NOT NULL,
	dayofweek                integer         DEFAULT '0'               NOT NULL,
	day                      integer         DEFAULT '0'               NOT NULL,
	start_time               integer         DEFAULT '0'               NOT NULL,
	period                   integer         DEFAULT '0'               NOT NULL,
	start_date               integer         DEFAULT '0'               NOT NULL,
	PRIMARY KEY (timeperiodid)
);
CREATE TABLE maintenances_windows (
	maintenance_timeperiodid bigint                                    NOT NULL,
	maintenanceid            bigint                                    NOT NULL,
	timeperiodid             bigint                                    NOT NULL,
	PRIMARY KEY (maintenance_timeperiodid)
);

-- CREATE INDEX maintenances_windows_2 ON maintenances_windows (timeperiodid);
CREATE TABLE regexps (
	regexpid                 bigint                                    NOT NULL,
	name                     varchar(128)    DEFAULT ''                NOT NULL,
	test_string              text            DEFAULT ''                NOT NULL,
	PRIMARY KEY (regexpid)
);

CREATE TABLE expressions (
	expressionid             bigint                                    NOT NULL,
	regexpid                 bigint                                    NOT NULL,
	expression               varchar(255)    DEFAULT ''                NOT NULL,
	expression_type          integer         DEFAULT '0'               NOT NULL,
	exp_delimiter            varchar(1)      DEFAULT ''                NOT NULL,
	case_sensitive           integer         DEFAULT '0'               NOT NULL,
	PRIMARY KEY (expressionid)
);
-- CREATE INDEX expressions_1 ON expressions (regexpid);
CREATE TABLE ids (
	table_name               varchar(64)     DEFAULT ''                NOT NULL,
	field_name               varchar(64)     DEFAULT ''                NOT NULL,
	nextid                   bigint                                    NOT NULL,
	PRIMARY KEY (table_name,field_name)
);
CREATE TABLE alerts (
	alertid                  bigint                                    NOT NULL,
	actionid                 bigint                                    NOT NULL,
	eventid                  bigint                                    NOT NULL,
	userid                   bigint,
	clock                    integer         DEFAULT '0'               NOT NULL,
	mediatypeid              bigint,
	sendto                   varchar(1024)   DEFAULT ''                NOT NULL,
	subject                  varchar(255)    DEFAULT ''                NOT NULL,
	message                  text            DEFAULT ''                NOT NULL,
	status                   integer         DEFAULT '0'               NOT NULL,
	retries                  integer         DEFAULT '0'               NOT NULL,
	error                    varchar(2048)   DEFAULT ''                NOT NULL,
	esc_step                 integer         DEFAULT '0'               NOT NULL,
	alerttype                integer         DEFAULT '0'               NOT NULL,
	p_eventid                bigint,
	acknowledgeid            bigint,
	parameters               text            DEFAULT '{}'              NOT NULL,
	PRIMARY KEY (alertid)
);
-- CREATE INDEX alerts_1 ON alerts (actionid);
-- CREATE INDEX alerts_2 ON alerts (clock);
-- CREATE INDEX alerts_3 ON alerts (eventid);
-- CREATE INDEX alerts_4 ON alerts (status);
-- CREATE INDEX alerts_5 ON alerts (mediatypeid);
-- CREATE INDEX alerts_6 ON alerts (userid);
-- CREATE INDEX alerts_7 ON alerts (p_eventid);
-- CREATE INDEX alerts_8 ON alerts (acknowledgeid);
CREATE TABLE history (
	itemid                   bigint                                    NOT NULL,
	clock                    integer         DEFAULT '0'               NOT NULL,
	value                    DOUBLE PRECISION DEFAULT '0.0000'          NOT NULL,
	ns                       integer         DEFAULT '0'               NOT NULL,
	PRIMARY KEY (itemid,clock,ns)
);
CREATE TABLE history_uint (
	itemid                   bigint                                    NOT NULL,
	clock                    integer         DEFAULT '0'               NOT NULL,
	value                    numeric(20)     DEFAULT '0'               NOT NULL,
	ns                       integer         DEFAULT '0'               NOT NULL,
	PRIMARY KEY (itemid,clock,ns)
);
CREATE TABLE history_str (
	itemid                   bigint                                    NOT NULL,
	clock                    integer         DEFAULT '0'               NOT NULL,
	value                    varchar(255)    DEFAULT ''                NOT NULL,
	ns                       integer         DEFAULT '0'               NOT NULL,
	PRIMARY KEY (itemid,clock,ns)
);
CREATE TABLE history_log (
	itemid                   bigint                                    NOT NULL,
	clock                    integer         DEFAULT '0'               NOT NULL,
	timestamp                integer         DEFAULT '0'               NOT NULL,
	source                   varchar(64)     DEFAULT ''                NOT NULL,
	severity                 integer         DEFAULT '0'               NOT NULL,
	value                    text            DEFAULT ''                NOT NULL,
	logeventid               integer         DEFAULT '0'               NOT NULL,
	ns                       integer         DEFAULT '0'               NOT NULL,
	PRIMARY KEY (itemid,clock,ns)
);
CREATE TABLE history_text (
	itemid                   bigint                                    NOT NULL,
	clock                    integer         DEFAULT '0'               NOT NULL,
	value                    text            DEFAULT ''                NOT NULL,
	ns                       integer         DEFAULT '0'               NOT NULL,
	PRIMARY KEY (itemid,clock,ns)
);
CREATE TABLE proxy_history (
	id                       bigserial                                 NOT NULL,
	itemid                   bigint                                    NOT NULL,
	clock                    integer         DEFAULT '0'               NOT NULL,
	timestamp                integer         DEFAULT '0'               NOT NULL,
	source                   varchar(64)     DEFAULT ''                NOT NULL,
	severity                 integer         DEFAULT '0'               NOT NULL,
	value                    text            DEFAULT ''                NOT NULL,
	logeventid               integer         DEFAULT '0'               NOT NULL,
	ns                       integer         DEFAULT '0'               NOT NULL,
	state                    integer         DEFAULT '0'               NOT NULL,
	lastlogsize              numeric(20)     DEFAULT '0'               NOT NULL,
	mtime                    integer         DEFAULT '0'               NOT NULL,
	flags                    integer         DEFAULT '0'               NOT NULL,
	write_clock              integer         DEFAULT '0'               NOT NULL,
	PRIMARY KEY (id)
);
-- CREATE INDEX proxy_history_1 ON proxy_history (clock);
CREATE TABLE proxy_dhistory (
	id                       bigserial                                 NOT NULL,
	clock                    integer         DEFAULT '0'               NOT NULL,
	druleid                  bigint                                    NOT NULL,
	ip                       varchar(39)     DEFAULT ''                NOT NULL,
	port                     integer         DEFAULT '0'               NOT NULL,
	value                    varchar(255)    DEFAULT ''                NOT NULL,
	status                   integer         DEFAULT '0'               NOT NULL,
	dcheckid                 bigint,
	dns                      varchar(255)    DEFAULT ''                NOT NULL,
	PRIMARY KEY (id)
);
-- CREATE INDEX proxy_dhistory_1 ON proxy_dhistory (clock);
-- CREATE INDEX proxy_dhistory_2 ON proxy_dhistory (druleid);
CREATE TABLE events (
	eventid                  bigint                                    NOT NULL,
	source                   integer         DEFAULT '0'               NOT NULL,
	object                   integer         DEFAULT '0'               NOT NULL,
	objectid                 bigint          DEFAULT '0'               NOT NULL,
	clock                    integer         DEFAULT '0'               NOT NULL,
	value                    integer         DEFAULT '0'               NOT NULL,
	acknowledged             integer         DEFAULT '0'               NOT NULL,
	ns                       integer         DEFAULT '0'               NOT NULL,
	name                     varchar(2048)   DEFAULT ''                NOT NULL,
	severity                 integer         DEFAULT '0'               NOT NULL,
	PRIMARY KEY (eventid)
);
-- CREATE INDEX events_1 ON events (source,object,objectid,clock);
-- CREATE INDEX events_2 ON events (source,object,clock);
CREATE TABLE event_symptom (
	eventid                  bigint                                    NOT NULL,
	cause_eventid            bigint                                    NOT NULL,
	PRIMARY KEY (eventid)
);
-- CREATE INDEX event_symptom_1 ON event_symptom (cause_eventid);
CREATE TABLE trends (
	itemid                   bigint                                    NOT NULL,
	clock                    integer         DEFAULT '0'               NOT NULL,
	num                      integer         DEFAULT '0'               NOT NULL,
	value_min                DOUBLE PRECISION DEFAULT '0.0000'          NOT NULL,
	value_avg                DOUBLE PRECISION DEFAULT '0.0000'          NOT NULL,
	value_max                DOUBLE PRECISION DEFAULT '0.0000'          NOT NULL,
	PRIMARY KEY (itemid,clock)
);
CREATE TABLE trends_uint (
	itemid                   bigint                                    NOT NULL,
	clock                    integer         DEFAULT '0'               NOT NULL,
	num                      integer         DEFAULT '0'               NOT NULL,
	value_min                numeric(20)     DEFAULT '0'               NOT NULL,
	value_avg                numeric(20)     DEFAULT '0'               NOT NULL,
	value_max                numeric(20)     DEFAULT '0'               NOT NULL,
	PRIMARY KEY (itemid,clock)
);
CREATE TABLE acknowledges (
	acknowledgeid            bigint                                    NOT NULL,
	userid                   bigint                                    NOT NULL,
	eventid                  bigint                                    NOT NULL,
	clock                    integer         DEFAULT '0'               NOT NULL,
	message                  varchar(2048)   DEFAULT ''                NOT NULL,
	action                   integer         DEFAULT '0'               NOT NULL,
	old_severity             integer         DEFAULT '0'               NOT NULL,
	new_severity             integer         DEFAULT '0'               NOT NULL,
	suppress_until           integer         DEFAULT '0'               NOT NULL,
	taskid                   bigint,
	PRIMARY KEY (acknowledgeid)
);
-- CREATE INDEX acknowledges_1 ON acknowledges (userid);
-- CREATE INDEX acknowledges_2 ON acknowledges (eventid);
-- CREATE INDEX acknowledges_3 ON acknowledges (clock);
CREATE TABLE auditlog (
	auditid                  varchar(25)                               NOT NULL,
	userid                   bigint,
	username                 varchar(100)    DEFAULT ''                NOT NULL,
	clock                    integer         DEFAULT '0'               NOT NULL,
	ip                       varchar(39)     DEFAULT ''                NOT NULL,
	action                   integer         DEFAULT '0'               NOT NULL,
	resourcetype             integer         DEFAULT '0'               NOT NULL,
	resourceid               bigint,
	resource_cuid            varchar(25)                       ,
	resourcename             varchar(255)    DEFAULT ''                NOT NULL,
	recordsetid              varchar(25)                               NOT NULL,
	details                  text            DEFAULT ''                NOT NULL,
	PRIMARY KEY (auditid)
);
-- CREATE INDEX auditlog_1 ON auditlog (userid,clock);
-- CREATE INDEX auditlog_2 ON auditlog (clock);
-- CREATE INDEX auditlog_3 ON auditlog (resourcetype,resourceid);
CREATE TABLE service_alarms (
	servicealarmid           bigint                                    NOT NULL,
	serviceid                bigint                                    NOT NULL,
	clock                    integer         DEFAULT '0'               NOT NULL,
	value                    integer         DEFAULT '-1'              NOT NULL,
	PRIMARY KEY (servicealarmid)
);
-- CREATE INDEX service_alarms_1 ON service_alarms (serviceid,clock);
-- CREATE INDEX service_alarms_2 ON service_alarms (clock);
CREATE TABLE autoreg_host (
	autoreg_hostid           bigint                                    NOT NULL,
	proxy_hostid             bigint,
	host                     varchar(128)    DEFAULT ''                NOT NULL,
	listen_ip                varchar(39)     DEFAULT ''                NOT NULL,
	listen_port              integer         DEFAULT '0'               NOT NULL,
	listen_dns               varchar(255)    DEFAULT ''                NOT NULL,
	host_metadata            text            DEFAULT ''                NOT NULL,
	flags                    integer         DEFAULT '0'               NOT NULL,
	tls_accepted             integer         DEFAULT '1'               NOT NULL,
	PRIMARY KEY (autoreg_hostid)
);
-- CREATE INDEX autoreg_host_1 ON autoreg_host (host);
-- CREATE INDEX autoreg_host_2 ON autoreg_host (proxy_hostid);
CREATE TABLE proxy_autoreg_host (
	id                       bigserial                                 NOT NULL,
	clock                    integer         DEFAULT '0'               NOT NULL,
	host                     varchar(128)    DEFAULT ''                NOT NULL,
	listen_ip                varchar(39)     DEFAULT ''                NOT NULL,
	listen_port              integer         DEFAULT '0'               NOT NULL,
	listen_dns               varchar(255)    DEFAULT ''                NOT NULL,
	host_metadata            text            DEFAULT ''                NOT NULL,
	flags                    integer         DEFAULT '0'               NOT NULL,
	tls_accepted             integer         DEFAULT '1'               NOT NULL,
	PRIMARY KEY (id)
);
-- CREATE INDEX proxy_autoreg_host_1 ON proxy_autoreg_host (clock);
CREATE TABLE dhosts (
	dhostid                  bigint                                    NOT NULL,
	druleid                  bigint                                    NOT NULL,
	status                   integer         DEFAULT '0'               NOT NULL,
	lastup                   integer         DEFAULT '0'               NOT NULL,
	lastdown                 integer         DEFAULT '0'               NOT NULL,
	PRIMARY KEY (dhostid)
);
-- CREATE INDEX dhosts_1 ON dhosts (druleid);
CREATE TABLE dservices (
	dserviceid               bigint                                    NOT NULL,
	dhostid                  bigint                                    NOT NULL,
	value                    varchar(255)    DEFAULT ''                NOT NULL,
	port                     integer         DEFAULT '0'               NOT NULL,
	status                   integer         DEFAULT '0'               NOT NULL,
	lastup                   integer         DEFAULT '0'               NOT NULL,
	lastdown                 integer         DEFAULT '0'               NOT NULL,
	dcheckid                 bigint                                    NOT NULL,
	ip                       varchar(39)     DEFAULT ''                NOT NULL,
	dns                      varchar(255)    DEFAULT ''                NOT NULL,
	PRIMARY KEY (dserviceid)
);

-- CREATE INDEX dservices_2 ON dservices (dhostid);
CREATE TABLE escalations (
	escalationid             bigint                                    NOT NULL,
	actionid                 bigint                                    NOT NULL,
	triggerid                bigint,
	eventid                  bigint,
	r_eventid                bigint,
	nextcheck                integer         DEFAULT '0'               NOT NULL,
	esc_step                 integer         DEFAULT '0'               NOT NULL,
	status                   integer         DEFAULT '0'               NOT NULL,
	itemid                   bigint,
	acknowledgeid            bigint,
	servicealarmid           bigint,
	serviceid                bigint,
	PRIMARY KEY (escalationid)
);

-- CREATE INDEX escalations_2 ON escalations (eventid);
-- CREATE INDEX escalations_3 ON escalations (nextcheck);
CREATE TABLE globalvars (
	globalvarid              bigint                                    NOT NULL,
	snmp_lastsize            numeric(20)     DEFAULT '0'               NOT NULL,
	PRIMARY KEY (globalvarid)
);
CREATE TABLE graph_discovery (
	graphid                  bigint                                    NOT NULL,
	parent_graphid           bigint                                    NOT NULL,
	lastcheck                integer         DEFAULT '0'               NOT NULL,
	ts_delete                integer         DEFAULT '0'               NOT NULL,
	PRIMARY KEY (graphid)
);
-- CREATE INDEX graph_discovery_1 ON graph_discovery (parent_graphid);
CREATE TABLE host_inventory (
	hostid                   bigint                                    NOT NULL,
	inventory_mode           integer         DEFAULT '0'               NOT NULL,
	type                     varchar(64)     DEFAULT ''                NOT NULL,
	type_full                varchar(64)     DEFAULT ''                NOT NULL,
	name                     varchar(128)    DEFAULT ''                NOT NULL,
	alias                    varchar(128)    DEFAULT ''                NOT NULL,
	os                       varchar(128)    DEFAULT ''                NOT NULL,
	os_full                  varchar(255)    DEFAULT ''                NOT NULL,
	os_short                 varchar(128)    DEFAULT ''                NOT NULL,
	serialno_a               varchar(64)     DEFAULT ''                NOT NULL,
	serialno_b               varchar(64)     DEFAULT ''                NOT NULL,
	tag                      varchar(64)     DEFAULT ''                NOT NULL,
	asset_tag                varchar(64)     DEFAULT ''                NOT NULL,
	macaddress_a             varchar(64)     DEFAULT ''                NOT NULL,
	macaddress_b             varchar(64)     DEFAULT ''                NOT NULL,
	hardware                 varchar(255)    DEFAULT ''                NOT NULL,
	hardware_full            text            DEFAULT ''                NOT NULL,
	software                 varchar(255)    DEFAULT ''                NOT NULL,
	software_full            text            DEFAULT ''                NOT NULL,
	software_app_a           varchar(64)     DEFAULT ''                NOT NULL,
	software_app_b           varchar(64)     DEFAULT ''                NOT NULL,
	software_app_c           varchar(64)     DEFAULT ''                NOT NULL,
	software_app_d           varchar(64)     DEFAULT ''                NOT NULL,
	software_app_e           varchar(64)     DEFAULT ''                NOT NULL,
	contact                  text            DEFAULT ''                NOT NULL,
	location                 text            DEFAULT ''                NOT NULL,
	location_lat             varchar(16)     DEFAULT ''                NOT NULL,
	location_lon             varchar(16)     DEFAULT ''                NOT NULL,
	notes                    text            DEFAULT ''                NOT NULL,
	chassis                  varchar(64)     DEFAULT ''                NOT NULL,
	model                    varchar(64)     DEFAULT ''                NOT NULL,
	hw_arch                  varchar(32)     DEFAULT ''                NOT NULL,
	vendor                   varchar(64)     DEFAULT ''                NOT NULL,
	contract_number          varchar(64)     DEFAULT ''                NOT NULL,
	installer_name           varchar(64)     DEFAULT ''                NOT NULL,
	deployment_status        varchar(64)     DEFAULT ''                NOT NULL,
	url_a                    varchar(255)    DEFAULT ''                NOT NULL,
	url_b                    varchar(255)    DEFAULT ''                NOT NULL,
	url_c                    varchar(255)    DEFAULT ''                NOT NULL,
	host_networks            text            DEFAULT ''                NOT NULL,
	host_netmask             varchar(39)     DEFAULT ''                NOT NULL,
	host_router              varchar(39)     DEFAULT ''                NOT NULL,
	oob_ip                   varchar(39)     DEFAULT ''                NOT NULL,
	oob_netmask              varchar(39)     DEFAULT ''                NOT NULL,
	oob_router               varchar(39)     DEFAULT ''                NOT NULL,
	date_hw_purchase         varchar(64)     DEFAULT ''                NOT NULL,
	date_hw_install          varchar(64)     DEFAULT ''                NOT NULL,
	date_hw_expiry           varchar(64)     DEFAULT ''                NOT NULL,
	date_hw_decomm           varchar(64)     DEFAULT ''                NOT NULL,
	site_address_a           varchar(128)    DEFAULT ''                NOT NULL,
	site_address_b           varchar(128)    DEFAULT ''                NOT NULL,
	site_address_c           varchar(128)    DEFAULT ''                NOT NULL,
	site_city                varchar(128)    DEFAULT ''                NOT NULL,
	site_state               varchar(64)     DEFAULT ''                NOT NULL,
	site_country             varchar(64)     DEFAULT ''                NOT NULL,
	site_zip                 varchar(64)     DEFAULT ''                NOT NULL,
	site_rack                varchar(128)    DEFAULT ''                NOT NULL,
	site_notes               text            DEFAULT ''                NOT NULL,
	poc_1_name               varchar(128)    DEFAULT ''                NOT NULL,
	poc_1_email              varchar(128)    DEFAULT ''                NOT NULL,
	poc_1_phone_a            varchar(64)     DEFAULT ''                NOT NULL,
	poc_1_phone_b            varchar(64)     DEFAULT ''                NOT NULL,
	poc_1_cell               varchar(64)     DEFAULT ''                NOT NULL,
	poc_1_screen             varchar(64)     DEFAULT ''                NOT NULL,
	poc_1_notes              text            DEFAULT ''                NOT NULL,
	poc_2_name               varchar(128)    DEFAULT ''                NOT NULL,
	poc_2_email              varchar(128)    DEFAULT ''                NOT NULL,
	poc_2_phone_a            varchar(64)     DEFAULT ''                NOT NULL,
	poc_2_phone_b            varchar(64)     DEFAULT ''                NOT NULL,
	poc_2_cell               varchar(64)     DEFAULT ''                NOT NULL,
	poc_2_screen             varchar(64)     DEFAULT ''                NOT NULL,
	poc_2_notes              text            DEFAULT ''                NOT NULL,
	PRIMARY KEY (hostid)
);
CREATE TABLE housekeeper (
	housekeeperid            bigint                                    NOT NULL,
	tablename                varchar(64)     DEFAULT ''                NOT NULL,
	field                    varchar(64)     DEFAULT ''                NOT NULL,
	value                    bigint                                    NOT NULL,
	PRIMARY KEY (housekeeperid)
);
CREATE TABLE images (
	imageid                  bigint                                    NOT NULL,
	imagetype                integer         DEFAULT '0'               NOT NULL,
	name                     varchar(64)     DEFAULT '0'               NOT NULL,
	image                    bytea           DEFAULT ''                NOT NULL,
	PRIMARY KEY (imageid)
);

CREATE TABLE item_discovery (
	itemdiscoveryid          bigint                                    NOT NULL,
	itemid                   bigint                                    NOT NULL,
	parent_itemid            bigint                                    NOT NULL,
	key_                     varchar(2048)   DEFAULT ''                NOT NULL,
	lastcheck                integer         DEFAULT '0'               NOT NULL,
	ts_delete                integer         DEFAULT '0'               NOT NULL,
	PRIMARY KEY (itemdiscoveryid)
);

-- CREATE INDEX item_discovery_2 ON item_discovery (parent_itemid);
CREATE TABLE host_discovery (
	hostid                   bigint                                    NOT NULL,
	parent_hostid            bigint,
	parent_itemid            bigint,
	host                     varchar(128)    DEFAULT ''                NOT NULL,
	lastcheck                integer         DEFAULT '0'               NOT NULL,
	ts_delete                integer         DEFAULT '0'               NOT NULL,
	PRIMARY KEY (hostid)
);
-- CREATE INDEX host_discovery_1 ON host_discovery (parent_hostid);
-- CREATE INDEX host_discovery_2 ON host_discovery (parent_itemid);
CREATE TABLE interface_discovery (
	interfaceid              bigint                                    NOT NULL,
	parent_interfaceid       bigint                                    NOT NULL,
	PRIMARY KEY (interfaceid)
);
-- CREATE INDEX interface_discovery_1 ON interface_discovery (parent_interfaceid);
CREATE TABLE profiles (
	profileid                bigint                                    NOT NULL,
	userid                   bigint                                    NOT NULL,
	idx                      varchar(96)     DEFAULT ''                NOT NULL,
	idx2                     bigint          DEFAULT '0'               NOT NULL,
	value_id                 bigint          DEFAULT '0'               NOT NULL,
	value_int                integer         DEFAULT '0'               NOT NULL,
	value_str                text            DEFAULT ''                NOT NULL,
	source                   varchar(96)     DEFAULT ''                NOT NULL,
	type                     integer         DEFAULT '0'               NOT NULL,
	PRIMARY KEY (profileid)
);
-- CREATE INDEX profiles_1 ON profiles (userid,idx,idx2);
-- CREATE INDEX profiles_2 ON profiles (userid,profileid);
CREATE TABLE sessions (
	sessionid                varchar(32)     DEFAULT ''                NOT NULL,
	userid                   bigint                                    NOT NULL,
	lastaccess               integer         DEFAULT '0'               NOT NULL,
	status                   integer         DEFAULT '0'               NOT NULL,
	secret                   varchar(32)     DEFAULT ''                NOT NULL,
	PRIMARY KEY (sessionid)
);
-- CREATE INDEX sessions_1 ON sessions (userid,status,lastaccess);
CREATE TABLE trigger_discovery (
	triggerid                bigint                                    NOT NULL,
	parent_triggerid         bigint                                    NOT NULL,
	lastcheck                integer         DEFAULT '0'               NOT NULL,
	ts_delete                integer         DEFAULT '0'               NOT NULL,
	PRIMARY KEY (triggerid)
);
-- CREATE INDEX trigger_discovery_1 ON trigger_discovery (parent_triggerid);
CREATE TABLE item_condition (
	item_conditionid         bigint                                    NOT NULL,
	itemid                   bigint                                    NOT NULL,
	operator                 integer         DEFAULT '8'               NOT NULL,
	macro                    varchar(64)     DEFAULT ''                NOT NULL,
	value                    varchar(255)    DEFAULT ''                NOT NULL,
	PRIMARY KEY (item_conditionid)
);
-- CREATE INDEX item_condition_1 ON item_condition (itemid);
CREATE TABLE item_rtdata (
	itemid                   bigint                                    NOT NULL,
	lastlogsize              numeric(20)     DEFAULT '0'               NOT NULL,
	state                    integer         DEFAULT '0'               NOT NULL,
	mtime                    integer         DEFAULT '0'               NOT NULL,
	error                    varchar(2048)   DEFAULT ''                NOT NULL,
	PRIMARY KEY (itemid)
);
CREATE TABLE opinventory (
	operationid              bigint                                    NOT NULL,
	inventory_mode           integer         DEFAULT '0'               NOT NULL,
	PRIMARY KEY (operationid)
);
CREATE TABLE trigger_tag (
	triggertagid             bigint                                    NOT NULL,
	triggerid                bigint                                    NOT NULL,
	tag                      varchar(255)    DEFAULT ''                NOT NULL,
	value                    varchar(255)    DEFAULT ''                NOT NULL,
	PRIMARY KEY (triggertagid)
);
-- CREATE INDEX trigger_tag_1 ON trigger_tag (triggerid);
CREATE TABLE event_tag (
	eventtagid               bigint                                    NOT NULL,
	eventid                  bigint                                    NOT NULL,
	tag                      varchar(255)    DEFAULT ''                NOT NULL,
	value                    varchar(255)    DEFAULT ''                NOT NULL,
	PRIMARY KEY (eventtagid)
);
-- CREATE INDEX event_tag_1 ON event_tag (eventid);
CREATE TABLE problem (
	eventid                  bigint                                    NOT NULL,
	source                   integer         DEFAULT '0'               NOT NULL,
	object                   integer         DEFAULT '0'               NOT NULL,
	objectid                 bigint          DEFAULT '0'               NOT NULL,
	clock                    integer         DEFAULT '0'               NOT NULL,
	ns                       integer         DEFAULT '0'               NOT NULL,
	r_eventid                bigint,
	r_clock                  integer         DEFAULT '0'               NOT NULL,
	r_ns                     integer         DEFAULT '0'               NOT NULL,
	correlationid            bigint,
	userid                   bigint,
	name                     varchar(2048)   DEFAULT ''                NOT NULL,
	acknowledged             integer         DEFAULT '0'               NOT NULL,
	severity                 integer         DEFAULT '0'               NOT NULL,
	cause_eventid            bigint,
	PRIMARY KEY (eventid)
);
-- CREATE INDEX problem_1 ON problem (source,object,objectid);
-- CREATE INDEX problem_2 ON problem (r_clock);
-- CREATE INDEX problem_3 ON problem (r_eventid);
-- CREATE INDEX problem_4 ON problem (cause_eventid);
CREATE TABLE problem_tag (
	problemtagid             bigint                                    NOT NULL,
	eventid                  bigint                                    NOT NULL,
	tag                      varchar(255)    DEFAULT ''                NOT NULL,
	value                    varchar(255)    DEFAULT ''                NOT NULL,
	PRIMARY KEY (problemtagid)
);
-- CREATE INDEX problem_tag_1 ON problem_tag (eventid,tag,value);
CREATE TABLE tag_filter (
	tag_filterid             bigint                                    NOT NULL,
	usrgrpid                 bigint                                    NOT NULL,
	groupid                  bigint                                    NOT NULL,
	tag                      varchar(255)    DEFAULT ''                NOT NULL,
	value                    varchar(255)    DEFAULT ''                NOT NULL,
	PRIMARY KEY (tag_filterid)
);
-- CREATE INDEX tag_filter_1 ON tag_filter (usrgrpid);
-- CREATE INDEX tag_filter_2 ON tag_filter (groupid);
CREATE TABLE event_recovery (
	eventid                  bigint                                    NOT NULL,
	r_eventid                bigint                                    NOT NULL,
	c_eventid                bigint,
	correlationid            bigint,
	userid                   bigint,
	PRIMARY KEY (eventid)
);
-- CREATE INDEX event_recovery_1 ON event_recovery (r_eventid);
-- CREATE INDEX event_recovery_2 ON event_recovery (c_eventid);
CREATE TABLE correlation (
	correlationid            bigint                                    NOT NULL,
	name                     varchar(255)    DEFAULT ''                NOT NULL,
	description              text            DEFAULT ''                NOT NULL,
	evaltype                 integer         DEFAULT '0'               NOT NULL,
	status                   integer         DEFAULT '0'               NOT NULL,
	formula                  varchar(255)    DEFAULT ''                NOT NULL,
	PRIMARY KEY (correlationid)
);
-- CREATE INDEX correlation_1 ON correlation (status);

CREATE TABLE corr_condition (
	corr_conditionid         bigint                                    NOT NULL,
	correlationid            bigint                                    NOT NULL,
	type                     integer         DEFAULT '0'               NOT NULL,
	PRIMARY KEY (corr_conditionid)
);
-- CREATE INDEX corr_condition_1 ON corr_condition (correlationid);
CREATE TABLE corr_condition_tag (
	corr_conditionid         bigint                                    NOT NULL,
	tag                      varchar(255)    DEFAULT ''                NOT NULL,
	PRIMARY KEY (corr_conditionid)
);
CREATE TABLE corr_condition_group (
	corr_conditionid         bigint                                    NOT NULL,
	operator                 integer         DEFAULT '0'               NOT NULL,
	groupid                  bigint                                    NOT NULL,
	PRIMARY KEY (corr_conditionid)
);
-- CREATE INDEX corr_condition_group_1 ON corr_condition_group (groupid);
CREATE TABLE corr_condition_tagpair (
	corr_conditionid         bigint                                    NOT NULL,
	oldtag                   varchar(255)    DEFAULT ''                NOT NULL,
	newtag                   varchar(255)    DEFAULT ''                NOT NULL,
	PRIMARY KEY (corr_conditionid)
);
CREATE TABLE corr_condition_tagvalue (
	corr_conditionid         bigint                                    NOT NULL,
	tag                      varchar(255)    DEFAULT ''                NOT NULL,
	operator                 integer         DEFAULT '0'               NOT NULL,
	value                    varchar(255)    DEFAULT ''                NOT NULL,
	PRIMARY KEY (corr_conditionid)
);
CREATE TABLE corr_operation (
	corr_operationid         bigint                                    NOT NULL,
	correlationid            bigint                                    NOT NULL,
	type                     integer         DEFAULT '0'               NOT NULL,
	PRIMARY KEY (corr_operationid)
);
-- CREATE INDEX corr_operation_1 ON corr_operation (correlationid);
CREATE TABLE task (
	taskid                   bigint                                    NOT NULL,
	type                     integer                                   NOT NULL,
	status                   integer         DEFAULT '0'               NOT NULL,
	clock                    integer         DEFAULT '0'               NOT NULL,
	ttl                      integer         DEFAULT '0'               NOT NULL,
	proxy_hostid             bigint,
	PRIMARY KEY (taskid)
);
-- CREATE INDEX task_1 ON task (status,proxy_hostid);
-- CREATE INDEX task_2 ON task (proxy_hostid);
CREATE TABLE task_close_problem (
	taskid                   bigint                                    NOT NULL,
	acknowledgeid            bigint                                    NOT NULL,
	PRIMARY KEY (taskid)
);
CREATE TABLE item_preproc (
	item_preprocid           bigint                                    NOT NULL,
	itemid                   bigint                                    NOT NULL,
	step                     integer         DEFAULT '0'               NOT NULL,
	type                     integer         DEFAULT '0'               NOT NULL,
	params                   text            DEFAULT ''                NOT NULL,
	error_handler            integer         DEFAULT '0'               NOT NULL,
	error_handler_params     varchar(255)    DEFAULT ''                NOT NULL,
	PRIMARY KEY (item_preprocid)
);
-- CREATE INDEX item_preproc_1 ON item_preproc (itemid,step);
CREATE TABLE task_remote_command (
	taskid                   bigint                                    NOT NULL,
	command_type             integer         DEFAULT '0'               NOT NULL,
	execute_on               integer         DEFAULT '0'               NOT NULL,
	port                     integer         DEFAULT '0'               NOT NULL,
	authtype                 integer         DEFAULT '0'               NOT NULL,
	username                 varchar(64)     DEFAULT ''                NOT NULL,
	password                 varchar(64)     DEFAULT ''                NOT NULL,
	publickey                varchar(64)     DEFAULT ''                NOT NULL,
	privatekey               varchar(64)     DEFAULT ''                NOT NULL,
	command                  text            DEFAULT ''                NOT NULL,
	alertid                  bigint,
	parent_taskid            bigint                                    NOT NULL,
	hostid                   bigint                                    NOT NULL,
	PRIMARY KEY (taskid)
);
CREATE TABLE task_remote_command_result (
	taskid                   bigint                                    NOT NULL,
	status                   integer         DEFAULT '0'               NOT NULL,
	parent_taskid            bigint                                    NOT NULL,
	info                     text            DEFAULT ''                NOT NULL,
	PRIMARY KEY (taskid)
);
CREATE TABLE task_data (
	taskid                   bigint                                    NOT NULL,
	type                     integer         DEFAULT '0'               NOT NULL,
	data                     text            DEFAULT ''                NOT NULL,
	parent_taskid            bigint,
	PRIMARY KEY (taskid)
);
CREATE TABLE task_result (
	taskid                   bigint                                    NOT NULL,
	status                   integer         DEFAULT '0'               NOT NULL,
	parent_taskid            bigint                                    NOT NULL,
	info                     text            DEFAULT ''                NOT NULL,
	PRIMARY KEY (taskid)
);
-- CREATE INDEX task_result_1 ON task_result (parent_taskid);
CREATE TABLE task_acknowledge (
	taskid                   bigint                                    NOT NULL,
	acknowledgeid            bigint                                    NOT NULL,
	PRIMARY KEY (taskid)
);
CREATE TABLE sysmap_shape (
	sysmap_shapeid           bigint                                    NOT NULL,
	sysmapid                 bigint                                    NOT NULL,
	type                     integer         DEFAULT '0'               NOT NULL,
	x                        integer         DEFAULT '0'               NOT NULL,
	y                        integer         DEFAULT '0'               NOT NULL,
	width                    integer         DEFAULT '200'             NOT NULL,
	height                   integer         DEFAULT '200'             NOT NULL,
	text                     text            DEFAULT ''                NOT NULL,
	font                     integer         DEFAULT '9'               NOT NULL,
	font_size                integer         DEFAULT '11'              NOT NULL,
	font_color               varchar(6)      DEFAULT '000000'          NOT NULL,
	text_halign              integer         DEFAULT '0'               NOT NULL,
	text_valign              integer         DEFAULT '0'               NOT NULL,
	border_type              integer         DEFAULT '0'               NOT NULL,
	border_width             integer         DEFAULT '1'               NOT NULL,
	border_color             varchar(6)      DEFAULT '000000'          NOT NULL,
	background_color         varchar(6)      DEFAULT ''                NOT NULL,
	zindex                   integer         DEFAULT '0'               NOT NULL,
	PRIMARY KEY (sysmap_shapeid)
);
-- CREATE INDEX sysmap_shape_1 ON sysmap_shape (sysmapid);
CREATE TABLE sysmap_element_trigger (
	selement_triggerid       bigint                                    NOT NULL,
	selementid               bigint                                    NOT NULL,
	triggerid                bigint                                    NOT NULL,
	PRIMARY KEY (selement_triggerid)
);

-- CREATE INDEX sysmap_element_trigger_2 ON sysmap_element_trigger (triggerid);
CREATE TABLE httptest_field (
	httptest_fieldid         bigint                                    NOT NULL,
	httptestid               bigint                                    NOT NULL,
	type                     integer         DEFAULT '0'               NOT NULL,
	name                     varchar(255)    DEFAULT ''                NOT NULL,
	value                    text            DEFAULT ''                NOT NULL,
	PRIMARY KEY (httptest_fieldid)
);
-- CREATE INDEX httptest_field_1 ON httptest_field (httptestid);
CREATE TABLE httpstep_field (
	httpstep_fieldid         bigint                                    NOT NULL,
	httpstepid               bigint                                    NOT NULL,
	type                     integer         DEFAULT '0'               NOT NULL,
	name                     varchar(255)    DEFAULT ''                NOT NULL,
	value                    text            DEFAULT ''                NOT NULL,
	PRIMARY KEY (httpstep_fieldid)
);
-- CREATE INDEX httpstep_field_1 ON httpstep_field (httpstepid);
CREATE TABLE dashboard (
	dashboardid              bigint                                    NOT NULL,
	name                     varchar(255)                              NOT NULL,
	userid                   bigint,
	private                  integer         DEFAULT '1'               NOT NULL,
	templateid               bigint,
	display_period           integer         DEFAULT '30'              NOT NULL,
	auto_start               integer         DEFAULT '1'               NOT NULL,
	uuid                     varchar(32)     DEFAULT ''                NOT NULL,
	PRIMARY KEY (dashboardid)
);
-- CREATE INDEX dashboard_1 ON dashboard (userid);
-- CREATE INDEX dashboard_2 ON dashboard (templateid);
CREATE TABLE dashboard_user (
	dashboard_userid         bigint                                    NOT NULL,
	dashboardid              bigint                                    NOT NULL,
	userid                   bigint                                    NOT NULL,
	permission               integer         DEFAULT '2'               NOT NULL,
	PRIMARY KEY (dashboard_userid)
);

-- CREATE INDEX dashboard_user_2 ON dashboard_user (userid);
CREATE TABLE dashboard_usrgrp (
	dashboard_usrgrpid       bigint                                    NOT NULL,
	dashboardid              bigint                                    NOT NULL,
	usrgrpid                 bigint                                    NOT NULL,
	permission               integer         DEFAULT '2'               NOT NULL,
	PRIMARY KEY (dashboard_usrgrpid)
);

-- CREATE INDEX dashboard_usrgrp_2 ON dashboard_usrgrp (usrgrpid);
CREATE TABLE dashboard_page (
	dashboard_pageid         bigint                                    NOT NULL,
	dashboardid              bigint                                    NOT NULL,
	name                     varchar(255)    DEFAULT ''                NOT NULL,
	display_period           integer         DEFAULT '0'               NOT NULL,
	sortorder                integer         DEFAULT '0'               NOT NULL,
	PRIMARY KEY (dashboard_pageid)
);
-- CREATE INDEX dashboard_page_1 ON dashboard_page (dashboardid);
CREATE TABLE widget (
	widgetid                 bigint                                    NOT NULL,
	type                     varchar(255)    DEFAULT ''                NOT NULL,
	name                     varchar(255)    DEFAULT ''                NOT NULL,
	x                        integer         DEFAULT '0'               NOT NULL,
	y                        integer         DEFAULT '0'               NOT NULL,
	width                    integer         DEFAULT '1'               NOT NULL,
	height                   integer         DEFAULT '2'               NOT NULL,
	view_mode                integer         DEFAULT '0'               NOT NULL,
	dashboard_pageid         bigint                                    NOT NULL,
	PRIMARY KEY (widgetid)
);
-- CREATE INDEX widget_1 ON widget (dashboard_pageid);
CREATE TABLE widget_field (
	widget_fieldid           bigint                                    NOT NULL,
	widgetid                 bigint                                    NOT NULL,
	type                     integer         DEFAULT '0'               NOT NULL,
	name                     varchar(255)    DEFAULT ''                NOT NULL,
	value_int                integer         DEFAULT '0'               NOT NULL,
	value_str                varchar(255)    DEFAULT ''                NOT NULL,
	value_groupid            bigint,
	value_hostid             bigint,
	value_itemid             bigint,
	value_graphid            bigint,
	value_sysmapid           bigint,
	value_serviceid          bigint,
	value_slaid              bigint,
	value_userid             bigint,
	value_actionid           bigint,
	value_mediatypeid        bigint,
	PRIMARY KEY (widget_fieldid)
);
-- CREATE INDEX widget_field_1 ON widget_field (widgetid);
-- CREATE INDEX widget_field_2 ON widget_field (value_groupid);
-- CREATE INDEX widget_field_3 ON widget_field (value_hostid);
-- CREATE INDEX widget_field_4 ON widget_field (value_itemid);
-- CREATE INDEX widget_field_5 ON widget_field (value_graphid);
-- CREATE INDEX widget_field_6 ON widget_field (value_sysmapid);
-- CREATE INDEX widget_field_7 ON widget_field (value_serviceid);
-- CREATE INDEX widget_field_8 ON widget_field (value_slaid);
-- CREATE INDEX widget_field_9 ON widget_field (value_userid);
-- CREATE INDEX widget_field_10 ON widget_field (value_actionid);
-- CREATE INDEX widget_field_11 ON widget_field (value_mediatypeid);
CREATE TABLE task_check_now (
	taskid                   bigint                                    NOT NULL,
	itemid                   bigint                                    NOT NULL,
	PRIMARY KEY (taskid)
);
CREATE TABLE event_suppress (
	event_suppressid         bigint                                    NOT NULL,
	eventid                  bigint                                    NOT NULL,
	maintenanceid            bigint,
	suppress_until           integer         DEFAULT '0'               NOT NULL,
	userid                   bigint,
	PRIMARY KEY (event_suppressid)
);

-- CREATE INDEX event_suppress_2 ON event_suppress (suppress_until);
-- CREATE INDEX event_suppress_3 ON event_suppress (maintenanceid);
-- CREATE INDEX event_suppress_4 ON event_suppress (userid);
CREATE TABLE maintenance_tag (
	maintenancetagid         bigint                                    NOT NULL,
	maintenanceid            bigint                                    NOT NULL,
	tag                      varchar(255)    DEFAULT ''                NOT NULL,
	operator                 integer         DEFAULT '2'               NOT NULL,
	value                    varchar(255)    DEFAULT ''                NOT NULL,
	PRIMARY KEY (maintenancetagid)
);
-- CREATE INDEX maintenance_tag_1 ON maintenance_tag (maintenanceid);
CREATE TABLE lld_macro_path (
	lld_macro_pathid         bigint                                    NOT NULL,
	itemid                   bigint                                    NOT NULL,
	lld_macro                varchar(255)    DEFAULT ''                NOT NULL,
	path                     varchar(255)    DEFAULT ''                NOT NULL,
	PRIMARY KEY (lld_macro_pathid)
);

CREATE TABLE host_tag (
	hosttagid                bigint                                    NOT NULL,
	hostid                   bigint                                    NOT NULL,
	tag                      varchar(255)    DEFAULT ''                NOT NULL,
	value                    varchar(255)    DEFAULT ''                NOT NULL,
	automatic                integer         DEFAULT '0'               NOT NULL,
	PRIMARY KEY (hosttagid)
);
-- CREATE INDEX host_tag_1 ON host_tag (hostid);
CREATE TABLE config_autoreg_tls (
	autoreg_tlsid            bigint                                    NOT NULL,
	tls_psk_identity         varchar(128)    DEFAULT ''                NOT NULL,
	tls_psk                  varchar(512)    DEFAULT ''                NOT NULL,
	PRIMARY KEY (autoreg_tlsid)
);

CREATE TABLE module (
	moduleid                 bigint                                    NOT NULL,
	id                       varchar(255)    DEFAULT ''                NOT NULL,
	relative_path            varchar(255)    DEFAULT ''                NOT NULL,
	status                   integer         DEFAULT '0'               NOT NULL,
	config                   text            DEFAULT ''                NOT NULL,
	PRIMARY KEY (moduleid)
);
CREATE TABLE interface_snmp (
	interfaceid              bigint                                    NOT NULL,
	version                  integer         DEFAULT '2'               NOT NULL,
	bulk                     integer         DEFAULT '1'               NOT NULL,
	community                varchar(64)     DEFAULT ''                NOT NULL,
	securityname             varchar(64)     DEFAULT ''                NOT NULL,
	securitylevel            integer         DEFAULT '0'               NOT NULL,
	authpassphrase           varchar(64)     DEFAULT ''                NOT NULL,
	privpassphrase           varchar(64)     DEFAULT ''                NOT NULL,
	authprotocol             integer         DEFAULT '0'               NOT NULL,
	privprotocol             integer         DEFAULT '0'               NOT NULL,
	contextname              varchar(255)    DEFAULT ''                NOT NULL,
	max_repetitions          integer         DEFAULT '10'              NOT NULL,
	PRIMARY KEY (interfaceid)
);
CREATE TABLE lld_override (
	lld_overrideid           bigint                                    NOT NULL,
	itemid                   bigint                                    NOT NULL,
	name                     varchar(255)    DEFAULT ''                NOT NULL,
	step                     integer         DEFAULT '0'               NOT NULL,
	evaltype                 integer         DEFAULT '0'               NOT NULL,
	formula                  varchar(255)    DEFAULT ''                NOT NULL,
	stop                     integer         DEFAULT '0'               NOT NULL,
	PRIMARY KEY (lld_overrideid)
);

CREATE TABLE lld_override_condition (
	lld_override_conditionid bigint                                    NOT NULL,
	lld_overrideid           bigint                                    NOT NULL,
	operator                 integer         DEFAULT '8'               NOT NULL,
	macro                    varchar(64)     DEFAULT ''                NOT NULL,
	value                    varchar(255)    DEFAULT ''                NOT NULL,
	PRIMARY KEY (lld_override_conditionid)
);
-- CREATE INDEX lld_override_condition_1 ON lld_override_condition (lld_overrideid);
CREATE TABLE lld_override_operation (
	lld_override_operationid bigint                                    NOT NULL,
	lld_overrideid           bigint                                    NOT NULL,
	operationobject          integer         DEFAULT '0'               NOT NULL,
	operator                 integer         DEFAULT '0'               NOT NULL,
	value                    varchar(255)    DEFAULT ''                NOT NULL,
	PRIMARY KEY (lld_override_operationid)
);
-- CREATE INDEX lld_override_operation_1 ON lld_override_operation (lld_overrideid);
CREATE TABLE lld_override_opstatus (
	lld_override_operationid bigint                                    NOT NULL,
	status                   integer         DEFAULT '0'               NOT NULL,
	PRIMARY KEY (lld_override_operationid)
);
CREATE TABLE lld_override_opdiscover (
	lld_override_operationid bigint                                    NOT NULL,
	discover                 integer         DEFAULT '0'               NOT NULL,
	PRIMARY KEY (lld_override_operationid)
);
CREATE TABLE lld_override_opperiod (
	lld_override_operationid bigint                                    NOT NULL,
	delay                    varchar(1024)   DEFAULT '0'               NOT NULL,
	PRIMARY KEY (lld_override_operationid)
);
CREATE TABLE lld_override_ophistory (
	lld_override_operationid bigint                                    NOT NULL,
	history                  varchar(255)    DEFAULT '90d'             NOT NULL,
	PRIMARY KEY (lld_override_operationid)
);
CREATE TABLE lld_override_optrends (
	lld_override_operationid bigint                                    NOT NULL,
	trends                   varchar(255)    DEFAULT '365d'            NOT NULL,
	PRIMARY KEY (lld_override_operationid)
);
CREATE TABLE lld_override_opseverity (
	lld_override_operationid bigint                                    NOT NULL,
	severity                 integer         DEFAULT '0'               NOT NULL,
	PRIMARY KEY (lld_override_operationid)
);
CREATE TABLE lld_override_optag (
	lld_override_optagid     bigint                                    NOT NULL,
	lld_override_operationid bigint                                    NOT NULL,
	tag                      varchar(255)    DEFAULT ''                NOT NULL,
	value                    varchar(255)    DEFAULT ''                NOT NULL,
	PRIMARY KEY (lld_override_optagid)
);
-- CREATE INDEX lld_override_optag_1 ON lld_override_optag (lld_override_operationid);
CREATE TABLE lld_override_optemplate (
	lld_override_optemplateid bigint                                    NOT NULL,
	lld_override_operationid bigint                                    NOT NULL,
	templateid               bigint                                    NOT NULL,
	PRIMARY KEY (lld_override_optemplateid)
);

-- CREATE INDEX lld_override_optemplate_2 ON lld_override_optemplate (templateid);
CREATE TABLE lld_override_opinventory (
	lld_override_operationid bigint                                    NOT NULL,
	inventory_mode           integer         DEFAULT '0'               NOT NULL,
	PRIMARY KEY (lld_override_operationid)
);
CREATE TABLE trigger_queue (
	trigger_queueid          bigint                                    NOT NULL,
	objectid                 bigint                                    NOT NULL,
	type                     integer         DEFAULT '0'               NOT NULL,
	clock                    integer         DEFAULT '0'               NOT NULL,
	ns                       integer         DEFAULT '0'               NOT NULL,
	PRIMARY KEY (trigger_queueid)
);
CREATE TABLE item_parameter (
	item_parameterid         bigint                                    NOT NULL,
	itemid                   bigint                                    NOT NULL,
	name                     varchar(255)    DEFAULT ''                NOT NULL,
	value                    varchar(2048)   DEFAULT ''                NOT NULL,
	PRIMARY KEY (item_parameterid)
);
-- CREATE INDEX item_parameter_1 ON item_parameter (itemid);
CREATE TABLE role_rule (
	role_ruleid              bigint                                    NOT NULL,
	roleid                   bigint                                    NOT NULL,
	type                     integer         DEFAULT '0'               NOT NULL,
	name                     varchar(255)    DEFAULT ''                NOT NULL,
	value_int                integer         DEFAULT '0'               NOT NULL,
	value_str                varchar(255)    DEFAULT ''                NOT NULL,
	value_moduleid           bigint,
	value_serviceid          bigint,
	PRIMARY KEY (role_ruleid)
);
-- CREATE INDEX role_rule_1 ON role_rule (roleid);
-- CREATE INDEX role_rule_2 ON role_rule (value_moduleid);
-- CREATE INDEX role_rule_3 ON role_rule (value_serviceid);
CREATE TABLE token (
	tokenid                  bigint                                    NOT NULL,
	name                     varchar(64)     DEFAULT ''                NOT NULL,
	description              text            DEFAULT ''                NOT NULL,
	userid                   bigint                                    NOT NULL,
	token                    varchar(128)                      ,
	lastaccess               integer         DEFAULT '0'               NOT NULL,
	status                   integer         DEFAULT '0'               NOT NULL,
	expires_at               integer         DEFAULT '0'               NOT NULL,
	created_at               integer         DEFAULT '0'               NOT NULL,
	creator_userid           bigint,
	PRIMARY KEY (tokenid)
);
-- CREATE INDEX token_1 ON token (name);


-- CREATE INDEX token_4 ON token (creator_userid);
CREATE TABLE item_tag (
	itemtagid                bigint                                    NOT NULL,
	itemid                   bigint                                    NOT NULL,
	tag                      varchar(255)    DEFAULT ''                NOT NULL,
	value                    varchar(255)    DEFAULT ''                NOT NULL,
	PRIMARY KEY (itemtagid)
);
-- CREATE INDEX item_tag_1 ON item_tag (itemid);
CREATE TABLE httptest_tag (
	httptesttagid            bigint                                    NOT NULL,
	httptestid               bigint                                    NOT NULL,
	tag                      varchar(255)    DEFAULT ''                NOT NULL,
	value                    varchar(255)    DEFAULT ''                NOT NULL,
	PRIMARY KEY (httptesttagid)
);
-- CREATE INDEX httptest_tag_1 ON httptest_tag (httptestid);
CREATE TABLE sysmaps_element_tag (
	selementtagid            bigint                                    NOT NULL,
	selementid               bigint                                    NOT NULL,
	tag                      varchar(255)    DEFAULT ''                NOT NULL,
	value                    varchar(255)    DEFAULT ''                NOT NULL,
	operator                 integer         DEFAULT '0'               NOT NULL,
	PRIMARY KEY (selementtagid)
);
-- CREATE INDEX sysmaps_element_tag_1 ON sysmaps_element_tag (selementid);
CREATE TABLE report (
	reportid                 bigint                                    NOT NULL,
	userid                   bigint                                    NOT NULL,
	name                     varchar(255)    DEFAULT ''                NOT NULL,
	description              varchar(2048)   DEFAULT ''                NOT NULL,
	status                   integer         DEFAULT '0'               NOT NULL,
	dashboardid              bigint                                    NOT NULL,
	period                   integer         DEFAULT '0'               NOT NULL,
	cycle                    integer         DEFAULT '0'               NOT NULL,
	weekdays                 integer         DEFAULT '0'               NOT NULL,
	start_time               integer         DEFAULT '0'               NOT NULL,
	active_since             integer         DEFAULT '0'               NOT NULL,
	active_till              integer         DEFAULT '0'               NOT NULL,
	state                    integer         DEFAULT '0'               NOT NULL,
	lastsent                 integer         DEFAULT '0'               NOT NULL,
	info                     varchar(2048)   DEFAULT ''                NOT NULL,
	PRIMARY KEY (reportid)
);

-- CREATE INDEX report_2 ON report (userid);
-- CREATE INDEX report_3 ON report (dashboardid);
CREATE TABLE report_param (
	reportparamid            bigint                                    NOT NULL,
	reportid                 bigint                                    NOT NULL,
	name                     varchar(255)    DEFAULT ''                NOT NULL,
	value                    text            DEFAULT ''                NOT NULL,
	PRIMARY KEY (reportparamid)
);
-- CREATE INDEX report_param_1 ON report_param (reportid);
CREATE TABLE report_user (
	reportuserid             bigint                                    NOT NULL,
	reportid                 bigint                                    NOT NULL,
	userid                   bigint                                    NOT NULL,
	exclude                  integer         DEFAULT '0'               NOT NULL,
	access_userid            bigint,
	PRIMARY KEY (reportuserid)
);
-- CREATE INDEX report_user_1 ON report_user (reportid);
-- CREATE INDEX report_user_2 ON report_user (userid);
-- CREATE INDEX report_user_3 ON report_user (access_userid);
CREATE TABLE report_usrgrp (
	reportusrgrpid           bigint                                    NOT NULL,
	reportid                 bigint                                    NOT NULL,
	usrgrpid                 bigint                                    NOT NULL,
	access_userid            bigint,
	PRIMARY KEY (reportusrgrpid)
);
-- CREATE INDEX report_usrgrp_1 ON report_usrgrp (reportid);
-- CREATE INDEX report_usrgrp_2 ON report_usrgrp (usrgrpid);
-- CREATE INDEX report_usrgrp_3 ON report_usrgrp (access_userid);
CREATE TABLE service_problem_tag (
	service_problem_tagid    bigint                                    NOT NULL,
	serviceid                bigint                                    NOT NULL,
	tag                      varchar(255)    DEFAULT ''                NOT NULL,
	operator                 integer         DEFAULT '0'               NOT NULL,
	value                    varchar(255)    DEFAULT ''                NOT NULL,
	PRIMARY KEY (service_problem_tagid)
);
-- CREATE INDEX service_problem_tag_1 ON service_problem_tag (serviceid);
CREATE TABLE service_problem (
	service_problemid        bigint                                    NOT NULL,
	eventid                  bigint                                    NOT NULL,
	serviceid                bigint                                    NOT NULL,
	severity                 integer         DEFAULT '0'               NOT NULL,
	PRIMARY KEY (service_problemid)
);
-- CREATE INDEX service_problem_1 ON service_problem (eventid);
-- CREATE INDEX service_problem_2 ON service_problem (serviceid);
CREATE TABLE service_tag (
	servicetagid             bigint                                    NOT NULL,
	serviceid                bigint                                    NOT NULL,
	tag                      varchar(255)    DEFAULT ''                NOT NULL,
	value                    varchar(255)    DEFAULT ''                NOT NULL,
	PRIMARY KEY (servicetagid)
);
-- CREATE INDEX service_tag_1 ON service_tag (serviceid);
CREATE TABLE service_status_rule (
	service_status_ruleid    bigint                                    NOT NULL,
	serviceid                bigint                                    NOT NULL,
	type                     integer         DEFAULT '0'               NOT NULL,
	limit_value              integer         DEFAULT '0'               NOT NULL,
	limit_status             integer         DEFAULT '0'               NOT NULL,
	new_status               integer         DEFAULT '0'               NOT NULL,
	PRIMARY KEY (service_status_ruleid)
);
-- CREATE INDEX service_status_rule_1 ON service_status_rule (serviceid);
CREATE TABLE ha_node (
	ha_nodeid                varchar(25)                               NOT NULL,
	name                     varchar(255)    DEFAULT ''                NOT NULL,
	address                  varchar(255)    DEFAULT ''                NOT NULL,
	port                     integer         DEFAULT '10051'           NOT NULL,
	lastaccess               integer         DEFAULT '0'               NOT NULL,
	status                   integer         DEFAULT '0'               NOT NULL,
	ha_sessionid             varchar(25)     DEFAULT ''                NOT NULL,
	PRIMARY KEY (ha_nodeid)
);

-- CREATE INDEX ha_node_2 ON ha_node (status,lastaccess);
CREATE TABLE sla (
	slaid                    bigint                                    NOT NULL,
	name                     varchar(255)    DEFAULT ''                NOT NULL,
	period                   integer         DEFAULT '0'               NOT NULL,
	slo                      DOUBLE PRECISION DEFAULT '99.9'            NOT NULL,
	effective_date           integer         DEFAULT '0'               NOT NULL,
	timezone                 varchar(50)     DEFAULT 'UTC'             NOT NULL,
	status                   integer         DEFAULT '1'               NOT NULL,
	description              text            DEFAULT ''                NOT NULL,
	PRIMARY KEY (slaid)
);

CREATE TABLE sla_schedule (
	sla_scheduleid           bigint                                    NOT NULL,
	slaid                    bigint                                    NOT NULL,
	period_from              integer         DEFAULT '0'               NOT NULL,
	period_to                integer         DEFAULT '0'               NOT NULL,
	PRIMARY KEY (sla_scheduleid)
);
-- CREATE INDEX sla_schedule_1 ON sla_schedule (slaid);
CREATE TABLE sla_excluded_downtime (
	sla_excluded_downtimeid  bigint                                    NOT NULL,
	slaid                    bigint                                    NOT NULL,
	name                     varchar(255)    DEFAULT ''                NOT NULL,
	period_from              integer         DEFAULT '0'               NOT NULL,
	period_to                integer         DEFAULT '0'               NOT NULL,
	PRIMARY KEY (sla_excluded_downtimeid)
);
-- CREATE INDEX sla_excluded_downtime_1 ON sla_excluded_downtime (slaid);
CREATE TABLE sla_service_tag (
	sla_service_tagid        bigint                                    NOT NULL,
	slaid                    bigint                                    NOT NULL,
	tag                      varchar(255)    DEFAULT ''                NOT NULL,
	operator                 integer         DEFAULT '0'               NOT NULL,
	value                    varchar(255)    DEFAULT ''                NOT NULL,
	PRIMARY KEY (sla_service_tagid)
);
-- CREATE INDEX sla_service_tag_1 ON sla_service_tag (slaid);
CREATE TABLE host_rtdata (
	hostid                   bigint                                    NOT NULL,
	active_available         integer         DEFAULT '0'               NOT NULL,
	lastaccess               integer         DEFAULT '0'               NOT NULL,
	version                  integer         DEFAULT '0'               NOT NULL,
	compatibility            integer         DEFAULT '0'               NOT NULL,
	PRIMARY KEY (hostid)
);
CREATE TABLE userdirectory (
	userdirectoryid          bigint                                    NOT NULL,
	name                     varchar(128)    DEFAULT ''                NOT NULL,
	description              text            DEFAULT ''                NOT NULL,
	idp_type                 integer         DEFAULT '1'               NOT NULL,
	provision_status         integer         DEFAULT '0'               NOT NULL,
	PRIMARY KEY (userdirectoryid)
);
-- CREATE INDEX userdirectory_1 ON userdirectory (idp_type);
CREATE TABLE userdirectory_ldap (
	userdirectoryid          bigint                                    NOT NULL,
	host                     varchar(255)    DEFAULT ''                NOT NULL,
	port                     integer         DEFAULT '389'             NOT NULL,
	base_dn                  varchar(255)    DEFAULT ''                NOT NULL,
	search_attribute         varchar(128)    DEFAULT ''                NOT NULL,
	bind_dn                  varchar(255)    DEFAULT ''                NOT NULL,
	bind_password            varchar(128)    DEFAULT ''                NOT NULL,
	start_tls                integer         DEFAULT '0'               NOT NULL,
	search_filter            varchar(255)    DEFAULT ''                NOT NULL,
	group_basedn             varchar(255)    DEFAULT ''                NOT NULL,
	group_name               varchar(255)    DEFAULT ''                NOT NULL,
	group_member             varchar(255)    DEFAULT ''                NOT NULL,
	user_ref_attr            varchar(255)    DEFAULT ''                NOT NULL,
	group_filter             varchar(255)    DEFAULT ''                NOT NULL,
	group_membership         varchar(255)    DEFAULT ''                NOT NULL,
	user_username            varchar(255)    DEFAULT ''                NOT NULL,
	user_lastname            varchar(255)    DEFAULT ''                NOT NULL,
	PRIMARY KEY (userdirectoryid)
);
CREATE TABLE userdirectory_saml (
	userdirectoryid          bigint                                    NOT NULL,
	idp_entityid             varchar(1024)   DEFAULT ''                NOT NULL,
	sso_url                  varchar(2048)   DEFAULT ''                NOT NULL,
	slo_url                  varchar(2048)   DEFAULT ''                NOT NULL,
	username_attribute       varchar(128)    DEFAULT ''                NOT NULL,
	sp_entityid              varchar(1024)   DEFAULT ''                NOT NULL,
	nameid_format            varchar(2048)   DEFAULT ''                NOT NULL,
	sign_messages            integer         DEFAULT '0'               NOT NULL,
	sign_assertions          integer         DEFAULT '0'               NOT NULL,
	sign_authn_requests      integer         DEFAULT '0'               NOT NULL,
	sign_logout_requests     integer         DEFAULT '0'               NOT NULL,
	sign_logout_responses    integer         DEFAULT '0'               NOT NULL,
	encrypt_nameid           integer         DEFAULT '0'               NOT NULL,
	encrypt_assertions       integer         DEFAULT '0'               NOT NULL,
	group_name               varchar(255)    DEFAULT ''                NOT NULL,
	user_username            varchar(255)    DEFAULT ''                NOT NULL,
	user_lastname            varchar(255)    DEFAULT ''                NOT NULL,
	scim_status              integer         DEFAULT '0'               NOT NULL,
	PRIMARY KEY (userdirectoryid)
);
CREATE TABLE userdirectory_media (
	userdirectory_mediaid    bigint                                    NOT NULL,
	userdirectoryid          bigint                                    NOT NULL,
	mediatypeid              bigint                                    NOT NULL,
	name                     varchar(64)     DEFAULT ''                NOT NULL,
	attribute                varchar(255)    DEFAULT ''                NOT NULL,
	PRIMARY KEY (userdirectory_mediaid)
);
-- CREATE INDEX userdirectory_media_1 ON userdirectory_media (userdirectoryid);
-- CREATE INDEX userdirectory_media_2 ON userdirectory_media (mediatypeid);
CREATE TABLE userdirectory_usrgrp (
	userdirectory_usrgrpid   bigint                                    NOT NULL,
	userdirectory_idpgroupid bigint                                    NOT NULL,
	usrgrpid                 bigint                                    NOT NULL,
	PRIMARY KEY (userdirectory_usrgrpid)
);

-- CREATE INDEX userdirectory_usrgrp_2 ON userdirectory_usrgrp (usrgrpid);
-- CREATE INDEX userdirectory_usrgrp_3 ON userdirectory_usrgrp (userdirectory_idpgroupid);
CREATE TABLE userdirectory_idpgroup (
	userdirectory_idpgroupid bigint                                    NOT NULL,
	userdirectoryid          bigint                                    NOT NULL,
	roleid                   bigint                                    NOT NULL,
	name                     varchar(255)    DEFAULT ''                NOT NULL,
	PRIMARY KEY (userdirectory_idpgroupid)
);
-- CREATE INDEX userdirectory_idpgroup_1 ON userdirectory_idpgroup (userdirectoryid);
-- CREATE INDEX userdirectory_idpgroup_2 ON userdirectory_idpgroup (roleid);
CREATE TABLE changelog (
	changelogid              bigserial                                 NOT NULL,
	object                   integer         DEFAULT '0'               NOT NULL,
	objectid                 bigint                                    NOT NULL,
	operation                integer         DEFAULT '0'               NOT NULL,
	clock                    integer         DEFAULT '0'               NOT NULL,
	PRIMARY KEY (changelogid)
);
-- CREATE INDEX changelog_1 ON changelog (clock);
CREATE TABLE scim_group (
	scim_groupid             bigint                                    NOT NULL,
	name                     varchar(64)     DEFAULT ''                NOT NULL,
	PRIMARY KEY (scim_groupid)
);

CREATE TABLE user_scim_group (
	user_scim_groupid        bigint                                    NOT NULL,
	userid                   bigint                                    NOT NULL,
	scim_groupid             bigint                                    NOT NULL,
	PRIMARY KEY (user_scim_groupid)
);
-- CREATE INDEX user_scim_group_1 ON user_scim_group (userid);
-- CREATE INDEX user_scim_group_2 ON user_scim_group (scim_groupid);
CREATE TABLE connector (
	connectorid              bigint                                    NOT NULL,
	name                     varchar(255)    DEFAULT ''                NOT NULL,
	protocol                 integer         DEFAULT '0'               NOT NULL,
	data_type                integer         DEFAULT '0'               NOT NULL,
	url                      varchar(2048)   DEFAULT ''                NOT NULL,
	max_records              integer         DEFAULT '0'               NOT NULL,
	max_senders              integer         DEFAULT '1'               NOT NULL,
	max_attempts             integer         DEFAULT '1'               NOT NULL,
	timeout                  varchar(255)    DEFAULT '5s'              NOT NULL,
	http_proxy               varchar(255)    DEFAULT ''                NOT NULL,
	authtype                 integer         DEFAULT '0'               NOT NULL,
	username                 varchar(64)     DEFAULT ''                NOT NULL,
	password                 varchar(64)     DEFAULT ''                NOT NULL,
	token                    varchar(128)    DEFAULT ''                NOT NULL,
	verify_peer              integer         DEFAULT '1'               NOT NULL,
	verify_host              integer         DEFAULT '1'               NOT NULL,
	ssl_cert_file            varchar(255)    DEFAULT ''                NOT NULL,
	ssl_key_file             varchar(255)    DEFAULT ''                NOT NULL,
	ssl_key_password         varchar(64)     DEFAULT ''                NOT NULL,
	description              text            DEFAULT ''                NOT NULL,
	status                   integer         DEFAULT '1'               NOT NULL,
	tags_evaltype            integer         DEFAULT '0'               NOT NULL,
	PRIMARY KEY (connectorid)
);

CREATE TABLE connector_tag (
	connector_tagid          bigint                                    NOT NULL,
	connectorid              bigint                                    NOT NULL,
	tag                      varchar(255)    DEFAULT ''                NOT NULL,
	operator                 integer         DEFAULT '0'               NOT NULL,
	value                    varchar(255)    DEFAULT ''                NOT NULL,
	PRIMARY KEY (connector_tagid)
);
-- CREATE INDEX connector_tag_1 ON connector_tag (connectorid);
CREATE TABLE dbversion (
	dbversionid              bigint                                    NOT NULL,
	mandatory                integer         DEFAULT '0'               NOT NULL,
	optional                 integer         DEFAULT '0'               NOT NULL,
	PRIMARY KEY (dbversionid)
);
