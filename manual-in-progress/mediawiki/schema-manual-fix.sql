--
-- PostgreSQL database dump
--

-- Dumped from database version 14.7 (Debian 14.7-1.pgdg110+1)
-- Dumped by pg_dump version 14.11 (Ubuntu 14.11-0ubuntu0.22.04.1)

-- SET statement_timeout = 0;
-- SET lock_timeout = 0;
-- SET idle_in_transaction_session_timeout = 0;
-- SET client_encoding = 'UTF8';
-- SET standard_conforming_strings = on;
-- -- SELECT pg_catalog.set_config('search_path', '', false);
-- SET check_function_bodies = false;
-- SET xmloption = content;
-- SET client_min_messages = warning;
-- SET row_security = off;

-- SET default_tablespace = '';

-- SET default_table_access_method = heap;

--
-- Name: actor; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE actor (
    actor_id BIGSERIAL NOT NULL,
    actor_user integer,
    actor_name text NOT NULL,
    PRIMARY KEY(actor_id)
);

--
-- Name: archive; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE archive (
    ar_id SERIAL NOT NULL,
    ar_namespace integer DEFAULT 0 NOT NULL,
    ar_title text DEFAULT '' NOT NULL,
    ar_comment_id integer NOT NULL,
    ar_actor integer NOT NULL,
    ar_timestamp timestamp with time zone NOT NULL,
    ar_minor_edit integer DEFAULT 0 NOT NULL,
    ar_rev_id integer NOT NULL,
    ar_deleted integer DEFAULT 0 NOT NULL,
    ar_len integer,
    ar_page_id integer,
    ar_parent_id integer,
    ar_sha1 text DEFAULT '' NOT NULL,
    PRIMARY KEY(ar_id)
);


--
-- Name: bot_passwords; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE bot_passwords (
    bp_user integer NOT NULL,
    bp_app_id text NOT NULL,
    bp_password text NOT NULL,
    bp_token text DEFAULT '' NOT NULL,
    bp_restrictions text NOT NULL,
    bp_grants text NOT NULL,
    __ydb_stub_id BIGSERIAL PRIMARY KEY
);


--
-- Name: category; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE category (
    cat_id SERIAL NOT NULL,
    cat_title text NOT NULL,
    cat_pages integer DEFAULT 0 NOT NULL,
    cat_subcats integer DEFAULT 0 NOT NULL,
    cat_files integer DEFAULT 0 NOT NULL,
    PRIMARY KEY(cat_id)
);

--
-- Name: categorylinks; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE categorylinks (
    cl_from integer DEFAULT 0 NOT NULL,
    cl_to text DEFAULT '' NOT NULL,
    cl_sortkey text DEFAULT '' NOT NULL,
    cl_sortkey_prefix text DEFAULT '' NOT NULL,
    cl_timestamp timestamp with time zone NOT NULL,
    cl_collation text DEFAULT '' NOT NULL,
    cl_type text DEFAULT 'page' NOT NULL,
    __ydb_stub_id BIGSERIAL PRIMARY KEY
);


--
-- Name: change_tag; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE change_tag (
    ct_id SERIAL NOT NULL,
    ct_rc_id integer,
    ct_log_id integer,
    ct_rev_id integer,
    ct_params text,
    ct_tag_id integer NOT NULL,
    PRIMARY KEY(ct_id)
);


--
-- Name: change_tag_def; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE change_tag_def (
    ctd_id SERIAL NOT NULL,
    ctd_name text NOT NULL,
    ctd_user_defined integer NOT NULL,
    ctd_count integer DEFAULT 0 NOT NULL,
    PRIMARY KEY(ctd_id)
);


--
-- Name: comment; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE comment (
    comment_id BIGSERIAL NOT NULL,
    comment_hash integer NOT NULL,
    comment_text text NOT NULL,
    comment_data text,
    PRIMARY KEY(comment_id)
);

--
-- Name: content; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE content (
    content_id BIGSERIAL NOT NULL,
    content_size integer NOT NULL,
    content_sha1 text NOT NULL,
    content_model integer NOT NULL,
    content_address text NOT NULL,
    PRIMARY KEY(content_id)
);


--
-- Name: content_models; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE content_models (
    model_id SERIAL NOT NULL,
    model_name text NOT NULL,
    PRIMARY KEY(model_id)
);

--
-- Name: externallinks; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE externallinks (
    el_id SERIAL NOT NULL,
    el_from integer DEFAULT 0 NOT NULL,
    el_to_domain_index text DEFAULT '' NOT NULL,
    el_to_path text,
    PRIMARY KEY(el_id)
);

--
-- Name: filearchive; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE filearchive (
    fa_id SERIAL NOT NULL,
    fa_name text DEFAULT '' NOT NULL,
    fa_archive_name text DEFAULT '',
    fa_storage_group text,
    fa_storage_key text DEFAULT '',
    fa_deleted_user integer,
    fa_deleted_timestamp timestamp with time zone,
    fa_deleted_reason_id integer NOT NULL,
    fa_size integer DEFAULT 0,
    fa_width integer DEFAULT 0,
    fa_height integer DEFAULT 0,
    fa_metadata text,
    fa_bits integer DEFAULT 0,
    fa_media_type text,
    fa_major_mime text DEFAULT 'unknown',
    fa_minor_mime text DEFAULT 'unknown',
    fa_description_id integer NOT NULL,
    fa_actor integer NOT NULL,
    fa_timestamp timestamp with time zone,
    fa_deleted integer DEFAULT 0 NOT NULL,
    fa_sha1 text DEFAULT '' NOT NULL,
    PRIMARY KEY(fa_id)
);


--
-- Name: image; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE image (
    img_name text DEFAULT '' NOT NULL,
    img_size integer DEFAULT 0 NOT NULL,
    img_width integer DEFAULT 0 NOT NULL,
    img_height integer DEFAULT 0 NOT NULL,
    img_metadata text NOT NULL,
    img_bits integer DEFAULT 0 NOT NULL,
    img_media_type text,
    img_major_mime text DEFAULT 'unknown'::text NOT NULL,
    img_minor_mime text DEFAULT 'unknown'::text NOT NULL,
    img_description_id integer NOT NULL,
    img_actor integer NOT NULL,
    img_timestamp timestamp with time zone NOT NULL,
    img_sha1 text DEFAULT '' NOT NULL,
    PRIMARY KEY(img_name)
);


--
-- Name: imagelinks; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE imagelinks (
    il_from integer DEFAULT 0 NOT NULL,
    il_to text DEFAULT '' NOT NULL,
    il_from_namespace integer DEFAULT 0 NOT NULL,
    __ydb_stub_id BIGSERIAL PRIMARY KEY
);


--
-- Name: interwiki; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE interwiki (
    iw_prefix text NOT NULL,
    iw_url text NOT NULL,
    iw_api text NOT NULL,
    iw_wikiid text NOT NULL,
    iw_local integer NOT NULL,
    iw_trans integer DEFAULT 0 NOT NULL,
    PRIMARY KEY(iw_prefix)
);


--
-- Name: ip_changes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE ip_changes (
    ipc_rev_id integer DEFAULT 0 NOT NULL,
    ipc_rev_timestamp timestamp with time zone NOT NULL,
    ipc_hex text DEFAULT '' NOT NULL,
    PRIMARY KEY(ipc_rev_id)
);


--
-- Name: ipblocks; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE ipblocks (
    ipb_id SERIAL NOT NULL,
    ipb_address text NOT NULL,
    ipb_user integer DEFAULT 0 NOT NULL,
    ipb_by_actor integer NOT NULL,
    ipb_reason_id integer NOT NULL,
    ipb_timestamp timestamp with time zone NOT NULL,
    ipb_auto integer DEFAULT 0 NOT NULL,
    ipb_anon_only integer DEFAULT 0 NOT NULL,
    ipb_create_account integer DEFAULT 1 NOT NULL,
    ipb_enable_autoblock integer DEFAULT 1 NOT NULL,
    ipb_expiry timestamp with time zone NOT NULL,
    ipb_range_start text NOT NULL,
    ipb_range_end text NOT NULL,
    ipb_deleted integer DEFAULT 0 NOT NULL,
    ipb_block_email integer DEFAULT 0 NOT NULL,
    ipb_allow_usertalk integer DEFAULT 0 NOT NULL,
    ipb_parent_block_id integer,
    ipb_sitewide integer DEFAULT 1 NOT NULL,
    PRIMARY KEY(ipb_id)
);


--
-- Name: ipblocks_restrictions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE ipblocks_restrictions (
    ir_ipb_id integer NOT NULL,
    ir_type integer NOT NULL,
    ir_value integer NOT NULL,
    __ydb_stub_id BIGSERIAL PRIMARY KEY
);


--
-- Name: iwlinks; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE iwlinks (
    iwl_from integer DEFAULT 0 NOT NULL,
    iwl_prefix text DEFAULT '' NOT NULL,
    iwl_title text DEFAULT '' NOT NULL,
    __ydb_stub_id BIGSERIAL PRIMARY KEY
);


--
-- Name: job; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE job (
    job_id SERIAL NOT NULL,
    job_cmd text DEFAULT '' NOT NULL,
    job_namespace integer NOT NULL,
    job_title text NOT NULL,
    job_timestamp timestamp with time zone,
    job_params text NOT NULL,
    job_random integer DEFAULT 0 NOT NULL,
    job_attempts integer DEFAULT 0 NOT NULL,
    job_token text DEFAULT '' NOT NULL,
    job_token_timestamp timestamp with time zone,
    job_sha1 text DEFAULT '' NOT NULL,
    PRIMARY KEY(job_id)
);


--
-- Name: l10n_cache; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE l10n_cache (
    lc_lang text NOT NULL,
    lc_key text NOT NULL,
    lc_value text NOT NULL,
    __ydb_stub_id BIGSERIAL PRIMARY KEY
);


--
-- Name: langlinks; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE langlinks (
    ll_from integer DEFAULT 0 NOT NULL,
    ll_lang text DEFAULT '' NOT NULL,
    ll_title text DEFAULT '' NOT NULL,
    __ydb_stub_id BIGSERIAL PRIMARY KEY
);


--
-- Name: linktarget; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE linktarget (
    lt_id BIGSERIAL NOT NULL,
    lt_namespace integer NOT NULL,
    lt_title text NOT NULL,
    PRIMARY KEY(lt_id)
);


--
-- Name: log_search; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE log_search (
    ls_field text NOT NULL,
    ls_value text NOT NULL,
    ls_log_id integer DEFAULT 0 NOT NULL,
    __ydb_stub_id BIGSERIAL PRIMARY KEY
);


--
-- Name: logging; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE logging (
    log_id SERIAL NOT NULL,
    log_type text DEFAULT '' NOT NULL,
    log_action text DEFAULT '' NOT NULL,
    log_timestamp timestamp with time zone DEFAULT '1970-01-01 00:00:00+00'::timestamp with time zone NOT NULL,
    log_actor integer NOT NULL,
    log_namespace integer DEFAULT 0 NOT NULL,
    log_title text DEFAULT '' NOT NULL,
    log_page integer,
    log_comment_id integer NOT NULL,
    log_params text NOT NULL,
    log_deleted integer DEFAULT 0 NOT NULL,
    PRIMARY KEY(log_id)
);


--
-- Name: module_deps; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE module_deps (
    md_module text NOT NULL,
    md_skin text NOT NULL,
    md_deps text NOT NULL,
    __ydb_stub_id BIGSERIAL PRIMARY KEY
);


--
-- Name: objectcache; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE objectcache (
    keyname text DEFAULT '' NOT NULL,
    value text,
    exptime timestamp with time zone NOT NULL,
    modtoken text DEFAULT '00000000000000000' NOT NULL,
    flags integer,
    PRIMARY KEY(keyname)
);


--
-- Name: oldimage; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE oldimage (
    oi_name text DEFAULT '' NOT NULL,
    oi_archive_name text DEFAULT '' NOT NULL,
    oi_size integer DEFAULT 0 NOT NULL,
    oi_width integer DEFAULT 0 NOT NULL,
    oi_height integer DEFAULT 0 NOT NULL,
    oi_bits integer DEFAULT 0 NOT NULL,
    oi_description_id integer NOT NULL,
    oi_actor integer NOT NULL,
    oi_timestamp timestamp with time zone NOT NULL,
    oi_metadata text NOT NULL,
    oi_media_type text,
    oi_major_mime text DEFAULT 'unknown'::text NOT NULL,
    oi_minor_mime text DEFAULT 'unknown'::text NOT NULL,
    oi_deleted integer DEFAULT 0 NOT NULL,
    oi_sha1 text DEFAULT '' NOT NULL,
    __ydb_stub_id BIGSERIAL PRIMARY KEY
);


--
-- Name: page; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE page (
    page_id SERIAL NOT NULL,
    page_namespace integer NOT NULL,
    page_title text NOT NULL,
    page_is_redirect integer DEFAULT 0 NOT NULL,
    page_is_new integer DEFAULT 0 NOT NULL,
    page_random double precision NOT NULL,
    page_touched timestamp with time zone NOT NULL,
    page_links_updated timestamp with time zone,
    page_latest integer NOT NULL,
    page_len integer NOT NULL,
    page_content_model text,
    page_lang text,
    titlevector tsvector,
    PRIMARY KEY(page_id)
);

--
-- Name: page_props; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE page_props (
    pp_page integer NOT NULL,
    pp_propname text NOT NULL,
    pp_value text NOT NULL,
    pp_sortkey double precision,
    __ydb_stub_id BIGSERIAL PRIMARY KEY
);


--
-- Name: page_restrictions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE page_restrictions (
    pr_id SERIAL NOT NULL,
    pr_page integer NOT NULL,
    pr_type text NOT NULL,
    pr_level text NOT NULL,
    pr_cascade integer NOT NULL,
    pr_expiry timestamp with time zone,
    PRIMARY KEY(pr_id)
);

--
-- Name: pagelinks; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE pagelinks (
    pl_from integer DEFAULT 0 NOT NULL,
    pl_namespace integer DEFAULT 0 NOT NULL,
    pl_title text DEFAULT '' NOT NULL,
    pl_from_namespace integer DEFAULT 0 NOT NULL,
    pl_target_id bigint,
    __ydb_stub_id BIGSERIAL PRIMARY KEY
);


--
-- Name: protected_titles; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE protected_titles (
    pt_namespace integer NOT NULL,
    pt_title text NOT NULL,
    pt_user integer NOT NULL,
    pt_reason_id integer NOT NULL,
    pt_timestamp timestamp with time zone NOT NULL,
    pt_expiry timestamp with time zone NOT NULL,
    pt_create_perm text NOT NULL,
    __ydb_stub_id BIGSERIAL PRIMARY KEY
);


--
-- Name: querycache; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE querycache (
    qc_type text NOT NULL,
    qc_value integer DEFAULT 0 NOT NULL,
    qc_namespace integer DEFAULT 0 NOT NULL,
    qc_title text DEFAULT '' NOT NULL,
    __ydb_stub_id BIGSERIAL PRIMARY KEY
);


--
-- Name: querycache_info; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE querycache_info (
    qci_type text DEFAULT '' NOT NULL,
    qci_timestamp timestamp with time zone DEFAULT '1970-01-01 00:00:00+00'::timestamp with time zone NOT NULL,
    PRIMARY KEY(qci_type)
);


--
-- Name: querycachetwo; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE querycachetwo (
    qcc_type text NOT NULL,
    qcc_value integer DEFAULT 0 NOT NULL,
    qcc_namespace integer DEFAULT 0 NOT NULL,
    qcc_title text DEFAULT '' NOT NULL,
    qcc_namespacetwo integer DEFAULT 0 NOT NULL,
    qcc_titletwo text DEFAULT '' NOT NULL,
    __ydb_stub_id BIGSERIAL PRIMARY KEY
);


--
-- Name: recentchanges; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE recentchanges (
    rc_id SERIAL NOT NULL,
    rc_timestamp timestamp with time zone NOT NULL,
    rc_actor integer NOT NULL,
    rc_namespace integer DEFAULT 0 NOT NULL,
    rc_title text DEFAULT '' NOT NULL,
    rc_comment_id integer NOT NULL,
    rc_minor integer DEFAULT 0 NOT NULL,
    rc_bot integer DEFAULT 0 NOT NULL,
    rc_new integer DEFAULT 0 NOT NULL,
    rc_cur_id integer DEFAULT 0 NOT NULL,
    rc_this_oldid integer DEFAULT 0 NOT NULL,
    rc_last_oldid integer DEFAULT 0 NOT NULL,
    rc_type integer DEFAULT 0 NOT NULL,
    rc_source text DEFAULT '' NOT NULL,
    rc_patrolled integer DEFAULT 0 NOT NULL,
    rc_ip text DEFAULT '' NOT NULL,
    rc_old_len integer,
    rc_new_len integer,
    rc_deleted integer DEFAULT 0 NOT NULL,
    rc_logid integer DEFAULT 0 NOT NULL,
    rc_log_type text,
    rc_log_action text,
    rc_params text,
    PRIMARY KEY(rc_id)
);


--
-- Name: redirect; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE redirect (
    rd_from integer DEFAULT 0 NOT NULL,
    rd_namespace integer DEFAULT 0 NOT NULL,
    rd_title text DEFAULT '' NOT NULL,
    rd_interwiki text DEFAULT '',
    rd_fragment text,
    PRIMARY KEY(rd_from)
);


--
-- Name: revision; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE revision (
    rev_id SERIAL NOT NULL,
    rev_page integer NOT NULL,
    rev_comment_id integer DEFAULT 0 NOT NULL,
    rev_actor integer DEFAULT 0 NOT NULL,
    rev_timestamp timestamp with time zone NOT NULL,
    rev_minor_edit integer DEFAULT 0 NOT NULL,
    rev_deleted integer DEFAULT 0 NOT NULL,
    rev_len integer,
    rev_parent_id integer,
    rev_sha1 text DEFAULT '' NOT NULL,
    PRIMARY KEY(rev_id)
);


--
-- Name: searchindex; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE searchindex (
    si_page integer NOT NULL,
    si_title text DEFAULT '' NOT NULL,
    si_text text NOT NULL,
    __ydb_stub_id BIGSERIAL PRIMARY KEY
);


--
-- Name: site_identifiers; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE site_identifiers (
    si_type text NOT NULL,
    si_key text NOT NULL,
    si_site integer NOT NULL,
    __ydb_stub_id BIGSERIAL PRIMARY KEY
);


--
-- Name: site_stats; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE site_stats (
    ss_row_id integer NOT NULL,
    ss_total_edits bigint,
    ss_good_articles bigint,
    ss_total_pages bigint,
    ss_users bigint,
    ss_active_users bigint,
    ss_images bigint,
    PRIMARY KEY(ss_row_id)
);


--
-- Name: sites; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE sites (
    site_id SERIAL NOT NULL,
    site_global_key text NOT NULL,
    site_type text NOT NULL,
    site_group text NOT NULL,
    site_source text NOT NULL,
    site_language text NOT NULL,
    site_protocol text NOT NULL,
    site_domain text NOT NULL,
    site_data text NOT NULL,
    site_forward integer NOT NULL,
    site_config text NOT NULL,
    PRIMARY KEY(site_id)
);


--
-- Name: slot_roles; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE slot_roles (
    role_id SERIAL NOT NULL,
    role_name text NOT NULL,
    PRIMARY KEY(role_id)
);


--
-- Name: slots; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE slots (
    slot_revision_id integer NOT NULL,
    slot_role_id integer NOT NULL,
    slot_content_id integer NOT NULL,
    slot_origin integer NOT NULL,
    __ydb_stub_id BIGSERIAL PRIMARY KEY
);


--
-- Name: templatelinks; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE templatelinks (
    tl_from integer DEFAULT 0 NOT NULL,
    tl_target_id integer NOT NULL,
    tl_from_namespace integer DEFAULT 0 NOT NULL,
    __ydb_stub_id BIGSERIAL PRIMARY KEY
);


--
-- Name: text; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE text (
    old_id SERIAL NOT NULL,
    old_text text NOT NULL,
    old_flags text NOT NULL,
    textvector tsvector,
    PRIMARY KEY(old_id)
);


--
-- Name: updatelog; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE updatelog (
    ul_key text NOT NULL,
    ul_value text,
    PRIMARY KEY(ul_key)
);


--
-- Name: uploadstash; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE uploadstash (
    us_id SERIAL NOT NULL,
    us_user integer NOT NULL,
    us_key text NOT NULL,
    us_orig_path text NOT NULL,
    us_path text NOT NULL,
    us_source_type text DEFAULT '',
    us_timestamp timestamp with time zone NOT NULL,
    us_status text NOT NULL,
    us_chunk_inx integer,
    us_props text,
    us_size integer NOT NULL,
    us_sha1 text NOT NULL,
    us_mime text DEFAULT '',
    us_media_type text,
    us_image_width integer,
    us_image_height integer,
    us_image_bits smallint,
    PRIMARY KEY(us_id)
);

--
-- Name: user; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "user" (
    user_id SERIAL NOT NULL,
    user_name text DEFAULT '' NOT NULL,
    user_real_name text DEFAULT '' NOT NULL,
    user_password text NOT NULL,
    user_newpassword text NOT NULL,
    user_newpass_time timestamp with time zone,
    user_email text NOT NULL,
    user_touched timestamp with time zone NOT NULL,
    user_token text DEFAULT '' NOT NULL,
    user_email_authenticated timestamp with time zone,
    user_email_token text,
    user_email_token_expires timestamp with time zone,
    user_registration timestamp with time zone,
    user_editcount integer,
    user_password_expires timestamp with time zone,
    user_is_temp integer DEFAULT 0 NOT NULL,
    PRIMARY KEY(user_id)
);


--
-- Name: user_autocreate_serial; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE user_autocreate_serial (
    uas_shard integer NOT NULL,
    uas_value integer NOT NULL,
    PRIMARY KEY(uas_shard)
);


--
-- Name: user_former_groups; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE user_former_groups (
    ufg_user integer DEFAULT 0 NOT NULL,
    ufg_group text DEFAULT '' NOT NULL,
    __ydb_stub_id BIGSERIAL PRIMARY KEY
);


--
-- Name: user_groups; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE user_groups (
    ug_user integer DEFAULT 0 NOT NULL,
    ug_group text DEFAULT '' NOT NULL,
    ug_expiry timestamp with time zone,
    __ydb_stub_id BIGSERIAL PRIMARY KEY
);


--
-- Name: user_newtalk; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE user_newtalk (
    user_id integer DEFAULT 0 NOT NULL,
    user_ip text DEFAULT '' NOT NULL,
    user_last_timestamp timestamp with time zone,
    __ydb_stub_id BIGSERIAL PRIMARY KEY
);


--
-- Name: user_properties; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE user_properties (
    up_user integer NOT NULL,
    up_property text NOT NULL,
    up_value text,
    __ydb_stub_id BIGSERIAL PRIMARY KEY
);


--
-- Name: watchlist; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE watchlist (
    wl_id SERIAL NOT NULL,
    wl_user integer NOT NULL,
    wl_namespace integer DEFAULT 0 NOT NULL,
    wl_title text DEFAULT '' NOT NULL,
    wl_notificationtimestamp timestamp with time zone,
    PRIMARY KEY(wl_id)
);


--
-- Name: watchlist_expiry; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE watchlist_expiry (
    we_item integer NOT NULL,
    we_expiry timestamp with time zone NOT NULL,
    PRIMARY KEY(we_item)
);



-- --
-- -- Name: actor_name; Type: INDEX; Schema: public; Owner: -
-- --

-- CREATE UNIQUE INDEX actor_name ON public.actor USING btree (actor_name);


-- --
-- -- Name: actor_user; Type: INDEX; Schema: public; Owner: -
-- --

-- CREATE UNIQUE INDEX actor_user ON public.actor USING btree (actor_user);


-- --
-- -- Name: ar_actor_timestamp; Type: INDEX; Schema: public; Owner: -
-- --

-- CREATE INDEX ar_actor_timestamp ON public.archive USING btree (ar_actor, ar_timestamp);


-- --
-- -- Name: ar_name_title_timestamp; Type: INDEX; Schema: public; Owner: -
-- --

-- CREATE INDEX ar_name_title_timestamp ON public.archive USING btree (ar_namespace, ar_title, ar_timestamp);


-- --
-- -- Name: ar_revid_uniq; Type: INDEX; Schema: public; Owner: -
-- --

-- CREATE UNIQUE INDEX ar_revid_uniq ON public.archive USING btree (ar_rev_id);


-- --
-- -- Name: cat_pages; Type: INDEX; Schema: public; Owner: -
-- --

-- CREATE INDEX cat_pages ON public.category USING btree (cat_pages);


-- --
-- -- Name: cat_title; Type: INDEX; Schema: public; Owner: -
-- --

-- CREATE UNIQUE INDEX cat_title ON public.category USING btree (cat_title);


-- --
-- -- Name: cl_collation_ext; Type: INDEX; Schema: public; Owner: -
-- --

-- CREATE INDEX cl_collation_ext ON public.categorylinks USING btree (cl_collation, cl_to, cl_type, cl_from);


-- --
-- -- Name: cl_sortkey; Type: INDEX; Schema: public; Owner: -
-- --

-- CREATE INDEX cl_sortkey ON public.categorylinks USING btree (cl_to, cl_type, cl_sortkey, cl_from);


-- --
-- -- Name: cl_timestamp; Type: INDEX; Schema: public; Owner: -
-- --

-- CREATE INDEX cl_timestamp ON public.categorylinks USING btree (cl_to, cl_timestamp);


-- --
-- -- Name: comment_hash; Type: INDEX; Schema: public; Owner: -
-- --

-- CREATE INDEX comment_hash ON public.comment USING btree (comment_hash);


-- --
-- -- Name: ct_log_tag_id; Type: INDEX; Schema: public; Owner: -
-- --

-- CREATE UNIQUE INDEX ct_log_tag_id ON public.change_tag USING btree (ct_log_id, ct_tag_id);


-- --
-- -- Name: ct_rc_tag_id; Type: INDEX; Schema: public; Owner: -
-- --

-- CREATE UNIQUE INDEX ct_rc_tag_id ON public.change_tag USING btree (ct_rc_id, ct_tag_id);


-- --
-- -- Name: ct_rev_tag_id; Type: INDEX; Schema: public; Owner: -
-- --

-- CREATE UNIQUE INDEX ct_rev_tag_id ON public.change_tag USING btree (ct_rev_id, ct_tag_id);


-- --
-- -- Name: ct_tag_id_id; Type: INDEX; Schema: public; Owner: -
-- --

-- CREATE INDEX ct_tag_id_id ON public.change_tag USING btree (ct_tag_id, ct_rc_id, ct_rev_id, ct_log_id);


-- --
-- -- Name: ctd_count; Type: INDEX; Schema: public; Owner: -
-- --

-- CREATE INDEX ctd_count ON public.change_tag_def USING btree (ctd_count);


-- --
-- -- Name: ctd_name; Type: INDEX; Schema: public; Owner: -
-- --

-- CREATE UNIQUE INDEX ctd_name ON public.change_tag_def USING btree (ctd_name);


-- --
-- -- Name: ctd_user_defined; Type: INDEX; Schema: public; Owner: -
-- --

-- CREATE INDEX ctd_user_defined ON public.change_tag_def USING btree (ctd_user_defined);


-- --
-- -- Name: el_from; Type: INDEX; Schema: public; Owner: -
-- --

-- CREATE INDEX el_from ON public.externallinks USING btree (el_from);


-- --
-- -- Name: el_to_domain_index_to_path; Type: INDEX; Schema: public; Owner: -
-- --

-- CREATE INDEX el_to_domain_index_to_path ON public.externallinks USING btree (el_to_domain_index, el_to_path);


-- --
-- -- Name: exptime; Type: INDEX; Schema: public; Owner: -
-- --

-- CREATE INDEX exptime ON public.objectcache USING btree (exptime);


-- --
-- -- Name: fa_actor_timestamp; Type: INDEX; Schema: public; Owner: -
-- --

-- CREATE INDEX fa_actor_timestamp ON public.filearchive USING btree (fa_actor, fa_timestamp);


-- --
-- -- Name: fa_deleted_timestamp; Type: INDEX; Schema: public; Owner: -
-- --

-- CREATE INDEX fa_deleted_timestamp ON public.filearchive USING btree (fa_deleted_timestamp);


-- --
-- -- Name: fa_name; Type: INDEX; Schema: public; Owner: -
-- --

-- CREATE INDEX fa_name ON public.filearchive USING btree (fa_name, fa_timestamp);


-- --
-- -- Name: fa_sha1; Type: INDEX; Schema: public; Owner: -
-- --

-- CREATE INDEX fa_sha1 ON public.filearchive USING btree (fa_sha1);


-- --
-- -- Name: fa_storage_group; Type: INDEX; Schema: public; Owner: -
-- --

-- CREATE INDEX fa_storage_group ON public.filearchive USING btree (fa_storage_group, fa_storage_key);


-- --
-- -- Name: il_backlinks_namespace; Type: INDEX; Schema: public; Owner: -
-- --

-- CREATE INDEX il_backlinks_namespace ON public.imagelinks USING btree (il_from_namespace, il_to, il_from);


-- --
-- -- Name: il_to; Type: INDEX; Schema: public; Owner: -
-- --

-- CREATE INDEX il_to ON public.imagelinks USING btree (il_to, il_from);


-- --
-- -- Name: img_actor_timestamp; Type: INDEX; Schema: public; Owner: -
-- --

-- CREATE INDEX img_actor_timestamp ON public.image USING btree (img_actor, img_timestamp);


-- --
-- -- Name: img_media_mime; Type: INDEX; Schema: public; Owner: -
-- --

-- CREATE INDEX img_media_mime ON public.image USING btree (img_media_type, img_major_mime, img_minor_mime);


-- --
-- -- Name: img_sha1; Type: INDEX; Schema: public; Owner: -
-- --

-- CREATE INDEX img_sha1 ON public.image USING btree (img_sha1);


-- --
-- -- Name: img_size; Type: INDEX; Schema: public; Owner: -
-- --

-- CREATE INDEX img_size ON public.image USING btree (img_size);


-- --
-- -- Name: img_timestamp; Type: INDEX; Schema: public; Owner: -
-- --

-- CREATE INDEX img_timestamp ON public.image USING btree (img_timestamp);


-- --
-- -- Name: ipb_address_unique; Type: INDEX; Schema: public; Owner: -
-- --

-- CREATE UNIQUE INDEX ipb_address_unique ON public.ipblocks USING btree (ipb_address, ipb_user, ipb_auto);


-- --
-- -- Name: ipb_expiry; Type: INDEX; Schema: public; Owner: -
-- --

-- CREATE INDEX ipb_expiry ON public.ipblocks USING btree (ipb_expiry);


-- --
-- -- Name: ipb_parent_block_id; Type: INDEX; Schema: public; Owner: -
-- --

-- CREATE INDEX ipb_parent_block_id ON public.ipblocks USING btree (ipb_parent_block_id);


-- --
-- -- Name: ipb_range; Type: INDEX; Schema: public; Owner: -
-- --

-- CREATE INDEX ipb_range ON public.ipblocks USING btree (ipb_range_start, ipb_range_end);


-- --
-- -- Name: ipb_timestamp; Type: INDEX; Schema: public; Owner: -
-- --

-- CREATE INDEX ipb_timestamp ON public.ipblocks USING btree (ipb_timestamp);


-- --
-- -- Name: ipb_user; Type: INDEX; Schema: public; Owner: -
-- --

-- CREATE INDEX ipb_user ON public.ipblocks USING btree (ipb_user);


-- --
-- -- Name: ipc_hex_time; Type: INDEX; Schema: public; Owner: -
-- --

-- CREATE INDEX ipc_hex_time ON public.ip_changes USING btree (ipc_hex, ipc_rev_timestamp);


-- --
-- -- Name: ipc_rev_timestamp; Type: INDEX; Schema: public; Owner: -
-- --

-- CREATE INDEX ipc_rev_timestamp ON public.ip_changes USING btree (ipc_rev_timestamp);


-- --
-- -- Name: ir_type_value; Type: INDEX; Schema: public; Owner: -
-- --

-- CREATE INDEX ir_type_value ON public.ipblocks_restrictions USING btree (ir_type, ir_value);


-- --
-- -- Name: iwl_prefix_from_title; Type: INDEX; Schema: public; Owner: -
-- --

-- CREATE INDEX iwl_prefix_from_title ON public.iwlinks USING btree (iwl_prefix, iwl_from, iwl_title);


-- --
-- -- Name: iwl_prefix_title_from; Type: INDEX; Schema: public; Owner: -
-- --

-- CREATE INDEX iwl_prefix_title_from ON public.iwlinks USING btree (iwl_prefix, iwl_title, iwl_from);


-- --
-- -- Name: job_cmd; Type: INDEX; Schema: public; Owner: -
-- --

-- CREATE INDEX job_cmd ON public.job USING btree (job_cmd, job_namespace, job_title, job_params);


-- --
-- -- Name: job_cmd_token; Type: INDEX; Schema: public; Owner: -
-- --

-- CREATE INDEX job_cmd_token ON public.job USING btree (job_cmd, job_token, job_random);


-- --
-- -- Name: job_cmd_token_id; Type: INDEX; Schema: public; Owner: -
-- --

-- CREATE INDEX job_cmd_token_id ON public.job USING btree (job_cmd, job_token, job_id);


-- --
-- -- Name: job_sha1; Type: INDEX; Schema: public; Owner: -
-- --

-- CREATE INDEX job_sha1 ON public.job USING btree (job_sha1);


-- --
-- -- Name: job_timestamp; Type: INDEX; Schema: public; Owner: -
-- --

-- CREATE INDEX job_timestamp ON public.job USING btree (job_timestamp);


-- --
-- -- Name: ll_lang; Type: INDEX; Schema: public; Owner: -
-- --

-- CREATE INDEX ll_lang ON public.langlinks USING btree (ll_lang, ll_title);


-- --
-- -- Name: log_actor_time; Type: INDEX; Schema: public; Owner: -
-- --

-- CREATE INDEX log_actor_time ON public.logging USING btree (log_actor, log_timestamp);


-- --
-- -- Name: log_actor_type_time; Type: INDEX; Schema: public; Owner: -
-- --

-- CREATE INDEX log_actor_type_time ON public.logging USING btree (log_actor, log_type, log_timestamp);


-- --
-- -- Name: log_page_id_time; Type: INDEX; Schema: public; Owner: -
-- --

-- CREATE INDEX log_page_id_time ON public.logging USING btree (log_page, log_timestamp);


-- --
-- -- Name: log_page_time; Type: INDEX; Schema: public; Owner: -
-- --

-- CREATE INDEX log_page_time ON public.logging USING btree (log_namespace, log_title, log_timestamp);


-- --
-- -- Name: log_times; Type: INDEX; Schema: public; Owner: -
-- --

-- CREATE INDEX log_times ON public.logging USING btree (log_timestamp);


-- --
-- -- Name: log_type_action; Type: INDEX; Schema: public; Owner: -
-- --

-- CREATE INDEX log_type_action ON public.logging USING btree (log_type, log_action, log_timestamp);


-- --
-- -- Name: log_type_time; Type: INDEX; Schema: public; Owner: -
-- --

-- CREATE INDEX log_type_time ON public.logging USING btree (log_type, log_timestamp);


-- --
-- -- Name: ls_log_id; Type: INDEX; Schema: public; Owner: -
-- --

-- CREATE INDEX ls_log_id ON public.log_search USING btree (ls_log_id);


-- --
-- -- Name: lt_namespace_title; Type: INDEX; Schema: public; Owner: -
-- --

-- CREATE UNIQUE INDEX lt_namespace_title ON public.linktarget USING btree (lt_namespace, lt_title);


-- --
-- -- Name: model_name; Type: INDEX; Schema: public; Owner: -
-- --

-- CREATE UNIQUE INDEX model_name ON public.content_models USING btree (model_name);


-- --
-- -- Name: oi_actor_timestamp; Type: INDEX; Schema: public; Owner: -
-- --

-- CREATE INDEX oi_actor_timestamp ON public.oldimage USING btree (oi_actor, oi_timestamp);


-- --
-- -- Name: oi_name_archive_name; Type: INDEX; Schema: public; Owner: -
-- --

-- CREATE INDEX oi_name_archive_name ON public.oldimage USING btree (oi_name, oi_archive_name);


-- --
-- -- Name: oi_name_timestamp; Type: INDEX; Schema: public; Owner: -
-- --

-- CREATE INDEX oi_name_timestamp ON public.oldimage USING btree (oi_name, oi_timestamp);


-- --
-- -- Name: oi_sha1; Type: INDEX; Schema: public; Owner: -
-- --

-- CREATE INDEX oi_sha1 ON public.oldimage USING btree (oi_sha1);


-- --
-- -- Name: oi_timestamp; Type: INDEX; Schema: public; Owner: -
-- --

-- CREATE INDEX oi_timestamp ON public.oldimage USING btree (oi_timestamp);


-- --
-- -- Name: page_len; Type: INDEX; Schema: public; Owner: -
-- --

-- CREATE INDEX page_len ON public.page USING btree (page_len);


-- --
-- -- Name: page_name_title; Type: INDEX; Schema: public; Owner: -
-- --

-- CREATE UNIQUE INDEX page_name_title ON public.page USING btree (page_namespace, page_title);


-- --
-- -- Name: page_random; Type: INDEX; Schema: public; Owner: -
-- --

-- CREATE INDEX page_random ON public.page USING btree (page_random);


-- --
-- -- Name: page_redirect_namespace_len; Type: INDEX; Schema: public; Owner: -
-- --

-- CREATE INDEX page_redirect_namespace_len ON public.page USING btree (page_is_redirect, page_namespace, page_len);


-- --
-- -- Name: pl_backlinks_namespace; Type: INDEX; Schema: public; Owner: -
-- --

-- CREATE INDEX pl_backlinks_namespace ON public.pagelinks USING btree (pl_from_namespace, pl_namespace, pl_title, pl_from);


-- --
-- -- Name: pl_backlinks_namespace_target_id; Type: INDEX; Schema: public; Owner: -
-- --

-- CREATE INDEX pl_backlinks_namespace_target_id ON public.pagelinks USING btree (pl_from_namespace, pl_target_id, pl_from);


-- --
-- -- Name: pl_namespace; Type: INDEX; Schema: public; Owner: -
-- --

-- CREATE INDEX pl_namespace ON public.pagelinks USING btree (pl_namespace, pl_title, pl_from);


-- --
-- -- Name: pl_target_id; Type: INDEX; Schema: public; Owner: -
-- --

-- CREATE INDEX pl_target_id ON public.pagelinks USING btree (pl_target_id, pl_from);


-- --
-- -- Name: pp_propname_page; Type: INDEX; Schema: public; Owner: -
-- --

-- CREATE UNIQUE INDEX pp_propname_page ON public.page_props USING btree (pp_propname, pp_page);


-- --
-- -- Name: pp_propname_sortkey_page; Type: INDEX; Schema: public; Owner: -
-- --

-- CREATE UNIQUE INDEX pp_propname_sortkey_page ON public.page_props USING btree (pp_propname, pp_sortkey, pp_page) WHERE (pp_sortkey IS NOT NULL);


-- --
-- -- Name: pr_cascade; Type: INDEX; Schema: public; Owner: -
-- --

-- CREATE INDEX pr_cascade ON public.page_restrictions USING btree (pr_cascade);


-- --
-- -- Name: pr_level; Type: INDEX; Schema: public; Owner: -
-- --

-- CREATE INDEX pr_level ON public.page_restrictions USING btree (pr_level);


-- --
-- -- Name: pr_pagetype; Type: INDEX; Schema: public; Owner: -
-- --

-- CREATE UNIQUE INDEX pr_pagetype ON public.page_restrictions USING btree (pr_page, pr_type);


-- --
-- -- Name: pr_typelevel; Type: INDEX; Schema: public; Owner: -
-- --

-- CREATE INDEX pr_typelevel ON public.page_restrictions USING btree (pr_type, pr_level);


-- --
-- -- Name: pt_timestamp; Type: INDEX; Schema: public; Owner: -
-- --

-- CREATE INDEX pt_timestamp ON public.protected_titles USING btree (pt_timestamp);


-- --
-- -- Name: qc_type; Type: INDEX; Schema: public; Owner: -
-- --

-- CREATE INDEX qc_type ON public.querycache USING btree (qc_type, qc_value);


-- --
-- -- Name: qcc_title; Type: INDEX; Schema: public; Owner: -
-- --

-- CREATE INDEX qcc_title ON public.querycachetwo USING btree (qcc_type, qcc_namespace, qcc_title);


-- --
-- -- Name: qcc_titletwo; Type: INDEX; Schema: public; Owner: -
-- --

-- CREATE INDEX qcc_titletwo ON public.querycachetwo USING btree (qcc_type, qcc_namespacetwo, qcc_titletwo);


-- --
-- -- Name: qcc_type; Type: INDEX; Schema: public; Owner: -
-- --

-- CREATE INDEX qcc_type ON public.querycachetwo USING btree (qcc_type, qcc_value);


-- --
-- -- Name: rc_actor; Type: INDEX; Schema: public; Owner: -
-- --

-- CREATE INDEX rc_actor ON public.recentchanges USING btree (rc_actor, rc_timestamp);


-- --
-- -- Name: rc_cur_id; Type: INDEX; Schema: public; Owner: -
-- --

-- CREATE INDEX rc_cur_id ON public.recentchanges USING btree (rc_cur_id);


-- --
-- -- Name: rc_ip; Type: INDEX; Schema: public; Owner: -
-- --

-- CREATE INDEX rc_ip ON public.recentchanges USING btree (rc_ip);


-- --
-- -- Name: rc_name_type_patrolled_timestamp; Type: INDEX; Schema: public; Owner: -
-- --

-- CREATE INDEX rc_name_type_patrolled_timestamp ON public.recentchanges USING btree (rc_namespace, rc_type, rc_patrolled, rc_timestamp);


-- --
-- -- Name: rc_namespace_title_timestamp; Type: INDEX; Schema: public; Owner: -
-- --

-- CREATE INDEX rc_namespace_title_timestamp ON public.recentchanges USING btree (rc_namespace, rc_title, rc_timestamp);


-- --
-- -- Name: rc_new_name_timestamp; Type: INDEX; Schema: public; Owner: -
-- --

-- CREATE INDEX rc_new_name_timestamp ON public.recentchanges USING btree (rc_new, rc_namespace, rc_timestamp);


-- --
-- -- Name: rc_ns_actor; Type: INDEX; Schema: public; Owner: -
-- --

-- CREATE INDEX rc_ns_actor ON public.recentchanges USING btree (rc_namespace, rc_actor);


-- --
-- -- Name: rc_this_oldid; Type: INDEX; Schema: public; Owner: -
-- --

-- CREATE INDEX rc_this_oldid ON public.recentchanges USING btree (rc_this_oldid);


-- --
-- -- Name: rc_timestamp; Type: INDEX; Schema: public; Owner: -
-- --

-- CREATE INDEX rc_timestamp ON public.recentchanges USING btree (rc_timestamp);


-- --
-- -- Name: rd_ns_title; Type: INDEX; Schema: public; Owner: -
-- --

-- CREATE INDEX rd_ns_title ON public.redirect USING btree (rd_namespace, rd_title, rd_from);


-- --
-- -- Name: rev_actor_timestamp; Type: INDEX; Schema: public; Owner: -
-- --

-- CREATE INDEX rev_actor_timestamp ON public.revision USING btree (rev_actor, rev_timestamp, rev_id);


-- --
-- -- Name: rev_page_actor_timestamp; Type: INDEX; Schema: public; Owner: -
-- --

-- CREATE INDEX rev_page_actor_timestamp ON public.revision USING btree (rev_page, rev_actor, rev_timestamp);


-- --
-- -- Name: rev_page_timestamp; Type: INDEX; Schema: public; Owner: -
-- --

-- CREATE INDEX rev_page_timestamp ON public.revision USING btree (rev_page, rev_timestamp);


-- --
-- -- Name: rev_timestamp; Type: INDEX; Schema: public; Owner: -
-- --

-- CREATE INDEX rev_timestamp ON public.revision USING btree (rev_timestamp);


-- --
-- -- Name: role_name; Type: INDEX; Schema: public; Owner: -
-- --

-- CREATE UNIQUE INDEX role_name ON public.slot_roles USING btree (role_name);


-- --
-- -- Name: si_key; Type: INDEX; Schema: public; Owner: -
-- --

-- CREATE INDEX si_key ON public.site_identifiers USING btree (si_key);


-- --
-- -- Name: si_page; Type: INDEX; Schema: public; Owner: -
-- --

-- CREATE UNIQUE INDEX si_page ON public.searchindex USING btree (si_page);


-- --
-- -- Name: si_site; Type: INDEX; Schema: public; Owner: -
-- --

-- CREATE INDEX si_site ON public.site_identifiers USING btree (si_site);


-- --
-- -- Name: si_text; Type: INDEX; Schema: public; Owner: -
-- --

-- CREATE INDEX si_text ON public.searchindex USING btree (si_text);


-- --
-- -- Name: si_title; Type: INDEX; Schema: public; Owner: -
-- --

-- CREATE INDEX si_title ON public.searchindex USING btree (si_title);


-- --
-- -- Name: site_domain; Type: INDEX; Schema: public; Owner: -
-- --

-- CREATE INDEX site_domain ON public.sites USING btree (site_domain);


-- --
-- -- Name: site_forward; Type: INDEX; Schema: public; Owner: -
-- --

-- CREATE INDEX site_forward ON public.sites USING btree (site_forward);


-- --
-- -- Name: site_global_key; Type: INDEX; Schema: public; Owner: -
-- --

-- CREATE UNIQUE INDEX site_global_key ON public.sites USING btree (site_global_key);


-- --
-- -- Name: site_group; Type: INDEX; Schema: public; Owner: -
-- --

-- CREATE INDEX site_group ON public.sites USING btree (site_group);


-- --
-- -- Name: site_language; Type: INDEX; Schema: public; Owner: -
-- --

-- CREATE INDEX site_language ON public.sites USING btree (site_language);


-- --
-- -- Name: site_protocol; Type: INDEX; Schema: public; Owner: -
-- --

-- CREATE INDEX site_protocol ON public.sites USING btree (site_protocol);


-- --
-- -- Name: site_source; Type: INDEX; Schema: public; Owner: -
-- --

-- CREATE INDEX site_source ON public.sites USING btree (site_source);


-- --
-- -- Name: site_type; Type: INDEX; Schema: public; Owner: -
-- --

-- CREATE INDEX site_type ON public.sites USING btree (site_type);


-- --
-- -- Name: slot_revision_origin_role; Type: INDEX; Schema: public; Owner: -
-- --

-- CREATE INDEX slot_revision_origin_role ON public.slots USING btree (slot_revision_id, slot_origin, slot_role_id);


-- --
-- -- Name: tl_backlinks_namespace_target_id; Type: INDEX; Schema: public; Owner: -
-- --

-- CREATE INDEX tl_backlinks_namespace_target_id ON public.templatelinks USING btree (tl_from_namespace, tl_target_id, tl_from);


-- --
-- -- Name: tl_target_id; Type: INDEX; Schema: public; Owner: -
-- --

-- CREATE INDEX tl_target_id ON public.templatelinks USING btree (tl_target_id, tl_from);


-- --
-- -- Name: ts2_page_text; Type: INDEX; Schema: public; Owner: -
-- --

-- CREATE INDEX ts2_page_text ON public.text USING gin (textvector);


-- --
-- -- Name: ts2_page_title; Type: INDEX; Schema: public; Owner: -
-- --

-- CREATE INDEX ts2_page_title ON public.page USING gin (titlevector);


-- --
-- -- Name: ug_expiry; Type: INDEX; Schema: public; Owner: -
-- --

-- CREATE INDEX ug_expiry ON public.user_groups USING btree (ug_expiry);


-- --
-- -- Name: ug_group; Type: INDEX; Schema: public; Owner: -
-- --

-- CREATE INDEX ug_group ON public.user_groups USING btree (ug_group);


-- --
-- -- Name: un_user_id; Type: INDEX; Schema: public; Owner: -
-- --

-- CREATE INDEX un_user_id ON public.user_newtalk USING btree (user_id);


-- --
-- -- Name: un_user_ip; Type: INDEX; Schema: public; Owner: -
-- --

-- CREATE INDEX un_user_ip ON public.user_newtalk USING btree (user_ip);


-- --
-- -- Name: up_property; Type: INDEX; Schema: public; Owner: -
-- --

-- CREATE INDEX up_property ON public.user_properties USING btree (up_property);


-- --
-- -- Name: us_key; Type: INDEX; Schema: public; Owner: -
-- --

-- CREATE UNIQUE INDEX us_key ON public.uploadstash USING btree (us_key);


-- --
-- -- Name: us_timestamp; Type: INDEX; Schema: public; Owner: -
-- --

-- CREATE INDEX us_timestamp ON public.uploadstash USING btree (us_timestamp);


-- --
-- -- Name: us_user; Type: INDEX; Schema: public; Owner: -
-- --

-- CREATE INDEX us_user ON public.uploadstash USING btree (us_user);


-- --
-- -- Name: user_email; Type: INDEX; Schema: public; Owner: -
-- --

-- CREATE INDEX user_email ON public."user" USING btree (user_email);


-- --
-- -- Name: user_email_token; Type: INDEX; Schema: public; Owner: -
-- --

-- CREATE INDEX user_email_token ON public."user" USING btree (user_email_token);


-- --
-- -- Name: user_name; Type: INDEX; Schema: public; Owner: -
-- --

-- CREATE UNIQUE INDEX user_name ON public."user" USING btree (user_name);


-- --
-- -- Name: we_expiry; Type: INDEX; Schema: public; Owner: -
-- --

-- CREATE INDEX we_expiry ON public.watchlist_expiry USING btree (we_expiry);


-- --
-- -- Name: wl_namespace_title; Type: INDEX; Schema: public; Owner: -
-- --

-- CREATE INDEX wl_namespace_title ON public.watchlist USING btree (wl_namespace, wl_title);


-- --
-- -- Name: wl_user; Type: INDEX; Schema: public; Owner: -
-- --

-- CREATE UNIQUE INDEX wl_user ON public.watchlist USING btree (wl_user, wl_namespace, wl_title);


-- --
-- -- Name: wl_user_notificationtimestamp; Type: INDEX; Schema: public; Owner: -
-- --

-- CREATE INDEX wl_user_notificationtimestamp ON public.watchlist USING btree (wl_user, wl_notificationtimestamp);


--
-- PostgreSQL database dump complete
--

