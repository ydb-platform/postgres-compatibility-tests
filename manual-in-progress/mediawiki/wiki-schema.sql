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
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: us_media_type_enum; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.us_media_type_enum AS ENUM (
    'UNKNOWN',
    'BITMAP',
    'DRAWING',
    'AUDIO',
    'VIDEO',
    'MULTIMEDIA',
    'OFFICE',
    'TEXT',
    'EXECUTABLE',
    'ARCHIVE',
    '3D'
);


--
-- Name: ts2_page_text(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.ts2_page_text() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
 BEGIN
 IF TG_OP = 'INSERT' THEN
 NEW.textvector = to_tsvector(NEW.old_text);
 ELSIF NEW.old_text != OLD.old_text THEN
 NEW.textvector := to_tsvector(NEW.old_text);
 END IF;
 RETURN NEW;
 END;
 $$;


--
-- Name: ts2_page_title(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.ts2_page_title() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
 BEGIN
 IF TG_OP = 'INSERT' THEN
 NEW.titlevector = to_tsvector(REPLACE(NEW.page_title,'/',' '));
 ELSIF NEW.page_title != OLD.page_title THEN
 NEW.titlevector := to_tsvector(REPLACE(NEW.page_title,'/',' '));
 END IF;
 RETURN NEW;
 END;
 $$;


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: actor; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.actor (
    actor_id bigint NOT NULL,
    actor_user integer,
    actor_name text NOT NULL
);


--
-- Name: actor_actor_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.actor_actor_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: actor_actor_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.actor_actor_id_seq OWNED BY public.actor.actor_id;


--
-- Name: archive; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.archive (
    ar_id integer NOT NULL,
    ar_namespace integer DEFAULT 0 NOT NULL,
    ar_title text DEFAULT ''::text NOT NULL,
    ar_comment_id bigint NOT NULL,
    ar_actor bigint NOT NULL,
    ar_timestamp timestamp with time zone NOT NULL,
    ar_minor_edit smallint DEFAULT 0 NOT NULL,
    ar_rev_id integer NOT NULL,
    ar_deleted smallint DEFAULT 0 NOT NULL,
    ar_len integer,
    ar_page_id integer,
    ar_parent_id integer,
    ar_sha1 text DEFAULT ''::text NOT NULL
);


--
-- Name: archive_ar_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.archive_ar_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: archive_ar_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.archive_ar_id_seq OWNED BY public.archive.ar_id;


--
-- Name: bot_passwords; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.bot_passwords (
    bp_user integer NOT NULL,
    bp_app_id text NOT NULL,
    bp_password text NOT NULL,
    bp_token text DEFAULT ''::text NOT NULL,
    bp_restrictions text NOT NULL,
    bp_grants text NOT NULL
);


--
-- Name: category; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.category (
    cat_id integer NOT NULL,
    cat_title text NOT NULL,
    cat_pages integer DEFAULT 0 NOT NULL,
    cat_subcats integer DEFAULT 0 NOT NULL,
    cat_files integer DEFAULT 0 NOT NULL
);


--
-- Name: category_cat_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.category_cat_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: category_cat_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.category_cat_id_seq OWNED BY public.category.cat_id;


--
-- Name: categorylinks; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.categorylinks (
    cl_from integer DEFAULT 0 NOT NULL,
    cl_to text DEFAULT ''::text NOT NULL,
    cl_sortkey text DEFAULT ''::text NOT NULL,
    cl_sortkey_prefix text DEFAULT ''::text NOT NULL,
    cl_timestamp timestamp with time zone NOT NULL,
    cl_collation text DEFAULT ''::text NOT NULL,
    cl_type text DEFAULT 'page'::text NOT NULL
);


--
-- Name: change_tag; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.change_tag (
    ct_id integer NOT NULL,
    ct_rc_id integer,
    ct_log_id integer,
    ct_rev_id integer,
    ct_params text,
    ct_tag_id integer NOT NULL
);


--
-- Name: change_tag_ct_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.change_tag_ct_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: change_tag_ct_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.change_tag_ct_id_seq OWNED BY public.change_tag.ct_id;


--
-- Name: change_tag_def; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.change_tag_def (
    ctd_id integer NOT NULL,
    ctd_name text NOT NULL,
    ctd_user_defined smallint NOT NULL,
    ctd_count bigint DEFAULT 0 NOT NULL
);


--
-- Name: change_tag_def_ctd_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.change_tag_def_ctd_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: change_tag_def_ctd_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.change_tag_def_ctd_id_seq OWNED BY public.change_tag_def.ctd_id;


--
-- Name: comment; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.comment (
    comment_id bigint NOT NULL,
    comment_hash integer NOT NULL,
    comment_text text NOT NULL,
    comment_data text
);


--
-- Name: comment_comment_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.comment_comment_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: comment_comment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.comment_comment_id_seq OWNED BY public.comment.comment_id;


--
-- Name: content; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.content (
    content_id bigint NOT NULL,
    content_size integer NOT NULL,
    content_sha1 text NOT NULL,
    content_model smallint NOT NULL,
    content_address text NOT NULL
);


--
-- Name: content_content_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.content_content_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: content_content_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.content_content_id_seq OWNED BY public.content.content_id;


--
-- Name: content_models; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.content_models (
    model_id integer NOT NULL,
    model_name text NOT NULL
);


--
-- Name: content_models_model_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.content_models_model_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: content_models_model_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.content_models_model_id_seq OWNED BY public.content_models.model_id;


--
-- Name: externallinks; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.externallinks (
    el_id integer NOT NULL,
    el_from integer DEFAULT 0 NOT NULL,
    el_to_domain_index text DEFAULT ''::text NOT NULL,
    el_to_path text
);


--
-- Name: externallinks_el_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.externallinks_el_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: externallinks_el_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.externallinks_el_id_seq OWNED BY public.externallinks.el_id;


--
-- Name: filearchive; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.filearchive (
    fa_id integer NOT NULL,
    fa_name text DEFAULT ''::text NOT NULL,
    fa_archive_name text DEFAULT ''::text,
    fa_storage_group text,
    fa_storage_key text DEFAULT ''::text,
    fa_deleted_user integer,
    fa_deleted_timestamp timestamp with time zone,
    fa_deleted_reason_id bigint NOT NULL,
    fa_size bigint DEFAULT 0,
    fa_width integer DEFAULT 0,
    fa_height integer DEFAULT 0,
    fa_metadata text,
    fa_bits integer DEFAULT 0,
    fa_media_type text,
    fa_major_mime text DEFAULT 'unknown'::text,
    fa_minor_mime text DEFAULT 'unknown'::text,
    fa_description_id bigint NOT NULL,
    fa_actor bigint NOT NULL,
    fa_timestamp timestamp with time zone,
    fa_deleted smallint DEFAULT 0 NOT NULL,
    fa_sha1 text DEFAULT ''::text NOT NULL
);


--
-- Name: filearchive_fa_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.filearchive_fa_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: filearchive_fa_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.filearchive_fa_id_seq OWNED BY public.filearchive.fa_id;


--
-- Name: image; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.image (
    img_name text DEFAULT ''::text NOT NULL,
    img_size bigint DEFAULT 0 NOT NULL,
    img_width integer DEFAULT 0 NOT NULL,
    img_height integer DEFAULT 0 NOT NULL,
    img_metadata text NOT NULL,
    img_bits integer DEFAULT 0 NOT NULL,
    img_media_type text,
    img_major_mime text DEFAULT 'unknown'::text NOT NULL,
    img_minor_mime text DEFAULT 'unknown'::text NOT NULL,
    img_description_id bigint NOT NULL,
    img_actor bigint NOT NULL,
    img_timestamp timestamp with time zone NOT NULL,
    img_sha1 text DEFAULT ''::text NOT NULL
);


--
-- Name: imagelinks; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.imagelinks (
    il_from integer DEFAULT 0 NOT NULL,
    il_to text DEFAULT ''::text NOT NULL,
    il_from_namespace integer DEFAULT 0 NOT NULL
);


--
-- Name: interwiki; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.interwiki (
    iw_prefix character varying(32) NOT NULL,
    iw_url text NOT NULL,
    iw_api text NOT NULL,
    iw_wikiid character varying(64) NOT NULL,
    iw_local smallint NOT NULL,
    iw_trans smallint DEFAULT 0 NOT NULL
);


--
-- Name: ip_changes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ip_changes (
    ipc_rev_id integer DEFAULT 0 NOT NULL,
    ipc_rev_timestamp timestamp with time zone NOT NULL,
    ipc_hex text DEFAULT ''::text NOT NULL
);


--
-- Name: ipblocks; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ipblocks (
    ipb_id integer NOT NULL,
    ipb_address text NOT NULL,
    ipb_user integer DEFAULT 0 NOT NULL,
    ipb_by_actor bigint NOT NULL,
    ipb_reason_id bigint NOT NULL,
    ipb_timestamp timestamp with time zone NOT NULL,
    ipb_auto smallint DEFAULT 0 NOT NULL,
    ipb_anon_only smallint DEFAULT 0 NOT NULL,
    ipb_create_account smallint DEFAULT 1 NOT NULL,
    ipb_enable_autoblock smallint DEFAULT 1 NOT NULL,
    ipb_expiry timestamp with time zone NOT NULL,
    ipb_range_start text NOT NULL,
    ipb_range_end text NOT NULL,
    ipb_deleted smallint DEFAULT 0 NOT NULL,
    ipb_block_email smallint DEFAULT 0 NOT NULL,
    ipb_allow_usertalk smallint DEFAULT 0 NOT NULL,
    ipb_parent_block_id integer,
    ipb_sitewide smallint DEFAULT 1 NOT NULL
);


--
-- Name: ipblocks_ipb_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.ipblocks_ipb_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: ipblocks_ipb_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.ipblocks_ipb_id_seq OWNED BY public.ipblocks.ipb_id;


--
-- Name: ipblocks_restrictions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ipblocks_restrictions (
    ir_ipb_id integer NOT NULL,
    ir_type smallint NOT NULL,
    ir_value integer NOT NULL
);


--
-- Name: iwlinks; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.iwlinks (
    iwl_from integer DEFAULT 0 NOT NULL,
    iwl_prefix text DEFAULT ''::text NOT NULL,
    iwl_title text DEFAULT ''::text NOT NULL
);


--
-- Name: job; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.job (
    job_id integer NOT NULL,
    job_cmd text DEFAULT ''::text NOT NULL,
    job_namespace integer NOT NULL,
    job_title text NOT NULL,
    job_timestamp timestamp with time zone,
    job_params text NOT NULL,
    job_random integer DEFAULT 0 NOT NULL,
    job_attempts integer DEFAULT 0 NOT NULL,
    job_token text DEFAULT ''::text NOT NULL,
    job_token_timestamp timestamp with time zone,
    job_sha1 text DEFAULT ''::text NOT NULL
);


--
-- Name: job_job_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.job_job_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: job_job_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.job_job_id_seq OWNED BY public.job.job_id;


--
-- Name: l10n_cache; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.l10n_cache (
    lc_lang text NOT NULL,
    lc_key character varying(255) NOT NULL,
    lc_value text NOT NULL
);


--
-- Name: langlinks; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.langlinks (
    ll_from integer DEFAULT 0 NOT NULL,
    ll_lang text DEFAULT ''::text NOT NULL,
    ll_title text DEFAULT ''::text NOT NULL
);


--
-- Name: linktarget; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.linktarget (
    lt_id bigint NOT NULL,
    lt_namespace integer NOT NULL,
    lt_title text NOT NULL
);


--
-- Name: linktarget_lt_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.linktarget_lt_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: linktarget_lt_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.linktarget_lt_id_seq OWNED BY public.linktarget.lt_id;


--
-- Name: log_search; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.log_search (
    ls_field text NOT NULL,
    ls_value character varying(255) NOT NULL,
    ls_log_id integer DEFAULT 0 NOT NULL
);


--
-- Name: logging; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.logging (
    log_id integer NOT NULL,
    log_type text DEFAULT ''::text NOT NULL,
    log_action text DEFAULT ''::text NOT NULL,
    log_timestamp timestamp with time zone DEFAULT '1970-01-01 00:00:00+00'::timestamp with time zone NOT NULL,
    log_actor bigint NOT NULL,
    log_namespace integer DEFAULT 0 NOT NULL,
    log_title text DEFAULT ''::text NOT NULL,
    log_page integer,
    log_comment_id bigint NOT NULL,
    log_params text NOT NULL,
    log_deleted smallint DEFAULT 0 NOT NULL
);


--
-- Name: logging_log_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.logging_log_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: logging_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.logging_log_id_seq OWNED BY public.logging.log_id;


--
-- Name: module_deps; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.module_deps (
    md_module text NOT NULL,
    md_skin text NOT NULL,
    md_deps text NOT NULL
);


--
-- Name: objectcache; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.objectcache (
    keyname text DEFAULT ''::text NOT NULL,
    value text,
    exptime timestamp with time zone NOT NULL,
    modtoken character varying(17) DEFAULT '00000000000000000'::character varying NOT NULL,
    flags integer
);


--
-- Name: oldimage; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.oldimage (
    oi_name text DEFAULT ''::text NOT NULL,
    oi_archive_name text DEFAULT ''::text NOT NULL,
    oi_size bigint DEFAULT 0 NOT NULL,
    oi_width integer DEFAULT 0 NOT NULL,
    oi_height integer DEFAULT 0 NOT NULL,
    oi_bits integer DEFAULT 0 NOT NULL,
    oi_description_id bigint NOT NULL,
    oi_actor bigint NOT NULL,
    oi_timestamp timestamp with time zone NOT NULL,
    oi_metadata text NOT NULL,
    oi_media_type text,
    oi_major_mime text DEFAULT 'unknown'::text NOT NULL,
    oi_minor_mime text DEFAULT 'unknown'::text NOT NULL,
    oi_deleted smallint DEFAULT 0 NOT NULL,
    oi_sha1 text DEFAULT ''::text NOT NULL
);


--
-- Name: page; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.page (
    page_id integer NOT NULL,
    page_namespace integer NOT NULL,
    page_title text NOT NULL,
    page_is_redirect smallint DEFAULT 0 NOT NULL,
    page_is_new smallint DEFAULT 0 NOT NULL,
    page_random double precision NOT NULL,
    page_touched timestamp with time zone NOT NULL,
    page_links_updated timestamp with time zone,
    page_latest integer NOT NULL,
    page_len integer NOT NULL,
    page_content_model text,
    page_lang text,
    titlevector tsvector
);


--
-- Name: page_page_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.page_page_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: page_page_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.page_page_id_seq OWNED BY public.page.page_id;


--
-- Name: page_props; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.page_props (
    pp_page integer NOT NULL,
    pp_propname text NOT NULL,
    pp_value text NOT NULL,
    pp_sortkey double precision
);


--
-- Name: page_restrictions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.page_restrictions (
    pr_id integer NOT NULL,
    pr_page integer NOT NULL,
    pr_type text NOT NULL,
    pr_level text NOT NULL,
    pr_cascade smallint NOT NULL,
    pr_expiry timestamp with time zone
);


--
-- Name: page_restrictions_pr_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.page_restrictions_pr_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: page_restrictions_pr_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.page_restrictions_pr_id_seq OWNED BY public.page_restrictions.pr_id;


--
-- Name: pagelinks; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.pagelinks (
    pl_from integer DEFAULT 0 NOT NULL,
    pl_namespace integer DEFAULT 0 NOT NULL,
    pl_title text DEFAULT ''::text NOT NULL,
    pl_from_namespace integer DEFAULT 0 NOT NULL,
    pl_target_id bigint
);


--
-- Name: pgbench_accounts; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.pgbench_accounts (
    aid integer NOT NULL,
    bid integer,
    abalance integer,
    filler character(84)
);


--
-- Name: pgbench_branches; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.pgbench_branches (
    bid integer NOT NULL,
    bbalance integer,
    filler character(88)
);


--
-- Name: pgbench_history; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.pgbench_history (
    tid integer,
    bid integer,
    aid integer,
    delta integer,
    mtime timestamp with time zone NOT NULL,
    filler character(22)
);


--
-- Name: pgbench_tellers; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.pgbench_tellers (
    tid integer NOT NULL,
    bid integer,
    tbalance integer,
    filler character(84)
);


--
-- Name: protected_titles; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.protected_titles (
    pt_namespace integer NOT NULL,
    pt_title text NOT NULL,
    pt_user integer NOT NULL,
    pt_reason_id bigint NOT NULL,
    pt_timestamp timestamp with time zone NOT NULL,
    pt_expiry timestamp with time zone NOT NULL,
    pt_create_perm text NOT NULL
);


--
-- Name: querycache; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.querycache (
    qc_type text NOT NULL,
    qc_value integer DEFAULT 0 NOT NULL,
    qc_namespace integer DEFAULT 0 NOT NULL,
    qc_title text DEFAULT ''::text NOT NULL
);


--
-- Name: querycache_info; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.querycache_info (
    qci_type text DEFAULT ''::text NOT NULL,
    qci_timestamp timestamp with time zone DEFAULT '1970-01-01 00:00:00+00'::timestamp with time zone NOT NULL
);


--
-- Name: querycachetwo; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.querycachetwo (
    qcc_type text NOT NULL,
    qcc_value integer DEFAULT 0 NOT NULL,
    qcc_namespace integer DEFAULT 0 NOT NULL,
    qcc_title text DEFAULT ''::text NOT NULL,
    qcc_namespacetwo integer DEFAULT 0 NOT NULL,
    qcc_titletwo text DEFAULT ''::text NOT NULL
);


--
-- Name: recentchanges; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.recentchanges (
    rc_id integer NOT NULL,
    rc_timestamp timestamp with time zone NOT NULL,
    rc_actor bigint NOT NULL,
    rc_namespace integer DEFAULT 0 NOT NULL,
    rc_title text DEFAULT ''::text NOT NULL,
    rc_comment_id bigint NOT NULL,
    rc_minor smallint DEFAULT 0 NOT NULL,
    rc_bot smallint DEFAULT 0 NOT NULL,
    rc_new smallint DEFAULT 0 NOT NULL,
    rc_cur_id integer DEFAULT 0 NOT NULL,
    rc_this_oldid integer DEFAULT 0 NOT NULL,
    rc_last_oldid integer DEFAULT 0 NOT NULL,
    rc_type smallint DEFAULT 0 NOT NULL,
    rc_source text DEFAULT ''::text NOT NULL,
    rc_patrolled smallint DEFAULT 0 NOT NULL,
    rc_ip text DEFAULT ''::text NOT NULL,
    rc_old_len integer,
    rc_new_len integer,
    rc_deleted smallint DEFAULT 0 NOT NULL,
    rc_logid integer DEFAULT 0 NOT NULL,
    rc_log_type text,
    rc_log_action text,
    rc_params text
);


--
-- Name: recentchanges_rc_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.recentchanges_rc_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: recentchanges_rc_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.recentchanges_rc_id_seq OWNED BY public.recentchanges.rc_id;


--
-- Name: redirect; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.redirect (
    rd_from integer DEFAULT 0 NOT NULL,
    rd_namespace integer DEFAULT 0 NOT NULL,
    rd_title text DEFAULT ''::text NOT NULL,
    rd_interwiki character varying(32) DEFAULT NULL::character varying,
    rd_fragment text
);


--
-- Name: revision; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.revision (
    rev_id integer NOT NULL,
    rev_page integer NOT NULL,
    rev_comment_id bigint DEFAULT 0 NOT NULL,
    rev_actor bigint DEFAULT 0 NOT NULL,
    rev_timestamp timestamp with time zone NOT NULL,
    rev_minor_edit smallint DEFAULT 0 NOT NULL,
    rev_deleted smallint DEFAULT 0 NOT NULL,
    rev_len integer,
    rev_parent_id integer,
    rev_sha1 text DEFAULT ''::text NOT NULL
);


--
-- Name: revision_rev_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.revision_rev_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: revision_rev_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.revision_rev_id_seq OWNED BY public.revision.rev_id;


--
-- Name: searchindex; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.searchindex (
    si_page integer NOT NULL,
    si_title character varying(255) DEFAULT ''::character varying NOT NULL,
    si_text text NOT NULL
);


--
-- Name: site_identifiers; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.site_identifiers (
    si_type text NOT NULL,
    si_key text NOT NULL,
    si_site integer NOT NULL
);


--
-- Name: site_stats; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.site_stats (
    ss_row_id integer NOT NULL,
    ss_total_edits bigint,
    ss_good_articles bigint,
    ss_total_pages bigint,
    ss_users bigint,
    ss_active_users bigint,
    ss_images bigint
);


--
-- Name: sites; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.sites (
    site_id integer NOT NULL,
    site_global_key text NOT NULL,
    site_type text NOT NULL,
    site_group text NOT NULL,
    site_source text NOT NULL,
    site_language text NOT NULL,
    site_protocol text NOT NULL,
    site_domain character varying(255) NOT NULL,
    site_data text NOT NULL,
    site_forward smallint NOT NULL,
    site_config text NOT NULL
);


--
-- Name: sites_site_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.sites_site_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: sites_site_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.sites_site_id_seq OWNED BY public.sites.site_id;


--
-- Name: slot_roles; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.slot_roles (
    role_id integer NOT NULL,
    role_name text NOT NULL
);


--
-- Name: slot_roles_role_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.slot_roles_role_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: slot_roles_role_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.slot_roles_role_id_seq OWNED BY public.slot_roles.role_id;


--
-- Name: slots; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.slots (
    slot_revision_id bigint NOT NULL,
    slot_role_id smallint NOT NULL,
    slot_content_id bigint NOT NULL,
    slot_origin bigint NOT NULL
);


--
-- Name: templatelinks; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.templatelinks (
    tl_from integer DEFAULT 0 NOT NULL,
    tl_target_id bigint NOT NULL,
    tl_from_namespace integer DEFAULT 0 NOT NULL
);


--
-- Name: text; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.text (
    old_id integer NOT NULL,
    old_text text NOT NULL,
    old_flags text NOT NULL,
    textvector tsvector
);


--
-- Name: text_old_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.text_old_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: text_old_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.text_old_id_seq OWNED BY public.text.old_id;


--
-- Name: updatelog; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.updatelog (
    ul_key character varying(255) NOT NULL,
    ul_value text
);


--
-- Name: uploadstash; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.uploadstash (
    us_id integer NOT NULL,
    us_user integer NOT NULL,
    us_key character varying(255) NOT NULL,
    us_orig_path character varying(255) NOT NULL,
    us_path character varying(255) NOT NULL,
    us_source_type character varying(50) DEFAULT NULL::character varying,
    us_timestamp timestamp with time zone NOT NULL,
    us_status character varying(50) NOT NULL,
    us_chunk_inx integer,
    us_props text,
    us_size bigint NOT NULL,
    us_sha1 character varying(31) NOT NULL,
    us_mime character varying(255) DEFAULT NULL::character varying,
    us_media_type public.us_media_type_enum,
    us_image_width integer,
    us_image_height integer,
    us_image_bits smallint
);


--
-- Name: uploadstash_us_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.uploadstash_us_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: uploadstash_us_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.uploadstash_us_id_seq OWNED BY public.uploadstash.us_id;


--
-- Name: user; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."user" (
    user_id integer NOT NULL,
    user_name text DEFAULT ''::text NOT NULL,
    user_real_name text DEFAULT ''::text NOT NULL,
    user_password text NOT NULL,
    user_newpassword text NOT NULL,
    user_newpass_time timestamp with time zone,
    user_email text NOT NULL,
    user_touched timestamp with time zone NOT NULL,
    user_token text DEFAULT ''::text NOT NULL,
    user_email_authenticated timestamp with time zone,
    user_email_token text,
    user_email_token_expires timestamp with time zone,
    user_registration timestamp with time zone,
    user_editcount integer,
    user_password_expires timestamp with time zone,
    user_is_temp smallint DEFAULT 0 NOT NULL
);


--
-- Name: user_autocreate_serial; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_autocreate_serial (
    uas_shard integer NOT NULL,
    uas_value integer NOT NULL
);


--
-- Name: user_former_groups; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_former_groups (
    ufg_user integer DEFAULT 0 NOT NULL,
    ufg_group text DEFAULT ''::text NOT NULL
);


--
-- Name: user_groups; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_groups (
    ug_user integer DEFAULT 0 NOT NULL,
    ug_group text DEFAULT ''::text NOT NULL,
    ug_expiry timestamp with time zone
);


--
-- Name: user_newtalk; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_newtalk (
    user_id integer DEFAULT 0 NOT NULL,
    user_ip text DEFAULT ''::text NOT NULL,
    user_last_timestamp timestamp with time zone
);


--
-- Name: user_properties; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_properties (
    up_user integer NOT NULL,
    up_property text NOT NULL,
    up_value text
);


--
-- Name: user_user_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.user_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: user_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.user_user_id_seq OWNED BY public."user".user_id;


--
-- Name: watchlist; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.watchlist (
    wl_id integer NOT NULL,
    wl_user integer NOT NULL,
    wl_namespace integer DEFAULT 0 NOT NULL,
    wl_title text DEFAULT ''::text NOT NULL,
    wl_notificationtimestamp timestamp with time zone
);


--
-- Name: watchlist_expiry; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.watchlist_expiry (
    we_item integer NOT NULL,
    we_expiry timestamp with time zone NOT NULL
);


--
-- Name: watchlist_wl_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.watchlist_wl_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: watchlist_wl_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.watchlist_wl_id_seq OWNED BY public.watchlist.wl_id;


--
-- Name: actor actor_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.actor ALTER COLUMN actor_id SET DEFAULT nextval('public.actor_actor_id_seq'::regclass);


--
-- Name: archive ar_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.archive ALTER COLUMN ar_id SET DEFAULT nextval('public.archive_ar_id_seq'::regclass);


--
-- Name: category cat_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.category ALTER COLUMN cat_id SET DEFAULT nextval('public.category_cat_id_seq'::regclass);


--
-- Name: change_tag ct_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.change_tag ALTER COLUMN ct_id SET DEFAULT nextval('public.change_tag_ct_id_seq'::regclass);


--
-- Name: change_tag_def ctd_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.change_tag_def ALTER COLUMN ctd_id SET DEFAULT nextval('public.change_tag_def_ctd_id_seq'::regclass);


--
-- Name: comment comment_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.comment ALTER COLUMN comment_id SET DEFAULT nextval('public.comment_comment_id_seq'::regclass);


--
-- Name: content content_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.content ALTER COLUMN content_id SET DEFAULT nextval('public.content_content_id_seq'::regclass);


--
-- Name: content_models model_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.content_models ALTER COLUMN model_id SET DEFAULT nextval('public.content_models_model_id_seq'::regclass);


--
-- Name: externallinks el_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.externallinks ALTER COLUMN el_id SET DEFAULT nextval('public.externallinks_el_id_seq'::regclass);


--
-- Name: filearchive fa_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.filearchive ALTER COLUMN fa_id SET DEFAULT nextval('public.filearchive_fa_id_seq'::regclass);


--
-- Name: ipblocks ipb_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ipblocks ALTER COLUMN ipb_id SET DEFAULT nextval('public.ipblocks_ipb_id_seq'::regclass);


--
-- Name: job job_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.job ALTER COLUMN job_id SET DEFAULT nextval('public.job_job_id_seq'::regclass);


--
-- Name: linktarget lt_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.linktarget ALTER COLUMN lt_id SET DEFAULT nextval('public.linktarget_lt_id_seq'::regclass);


--
-- Name: logging log_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.logging ALTER COLUMN log_id SET DEFAULT nextval('public.logging_log_id_seq'::regclass);


--
-- Name: page page_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.page ALTER COLUMN page_id SET DEFAULT nextval('public.page_page_id_seq'::regclass);


--
-- Name: page_restrictions pr_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.page_restrictions ALTER COLUMN pr_id SET DEFAULT nextval('public.page_restrictions_pr_id_seq'::regclass);


--
-- Name: recentchanges rc_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.recentchanges ALTER COLUMN rc_id SET DEFAULT nextval('public.recentchanges_rc_id_seq'::regclass);


--
-- Name: revision rev_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.revision ALTER COLUMN rev_id SET DEFAULT nextval('public.revision_rev_id_seq'::regclass);


--
-- Name: sites site_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sites ALTER COLUMN site_id SET DEFAULT nextval('public.sites_site_id_seq'::regclass);


--
-- Name: slot_roles role_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.slot_roles ALTER COLUMN role_id SET DEFAULT nextval('public.slot_roles_role_id_seq'::regclass);


--
-- Name: text old_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.text ALTER COLUMN old_id SET DEFAULT nextval('public.text_old_id_seq'::regclass);


--
-- Name: uploadstash us_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.uploadstash ALTER COLUMN us_id SET DEFAULT nextval('public.uploadstash_us_id_seq'::regclass);


--
-- Name: user user_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user" ALTER COLUMN user_id SET DEFAULT nextval('public.user_user_id_seq'::regclass);


--
-- Name: watchlist wl_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.watchlist ALTER COLUMN wl_id SET DEFAULT nextval('public.watchlist_wl_id_seq'::regclass);


--
-- Name: actor actor_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.actor
    ADD CONSTRAINT actor_pkey PRIMARY KEY (actor_id);


--
-- Name: archive archive_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.archive
    ADD CONSTRAINT archive_pkey PRIMARY KEY (ar_id);


--
-- Name: bot_passwords bot_passwords_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.bot_passwords
    ADD CONSTRAINT bot_passwords_pkey PRIMARY KEY (bp_user, bp_app_id);


--
-- Name: category category_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.category
    ADD CONSTRAINT category_pkey PRIMARY KEY (cat_id);


--
-- Name: categorylinks categorylinks_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.categorylinks
    ADD CONSTRAINT categorylinks_pkey PRIMARY KEY (cl_from, cl_to);


--
-- Name: change_tag_def change_tag_def_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.change_tag_def
    ADD CONSTRAINT change_tag_def_pkey PRIMARY KEY (ctd_id);


--
-- Name: change_tag change_tag_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.change_tag
    ADD CONSTRAINT change_tag_pkey PRIMARY KEY (ct_id);


--
-- Name: comment comment_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.comment
    ADD CONSTRAINT comment_pkey PRIMARY KEY (comment_id);


--
-- Name: content_models content_models_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.content_models
    ADD CONSTRAINT content_models_pkey PRIMARY KEY (model_id);


--
-- Name: content content_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.content
    ADD CONSTRAINT content_pkey PRIMARY KEY (content_id);


--
-- Name: externallinks externallinks_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.externallinks
    ADD CONSTRAINT externallinks_pkey PRIMARY KEY (el_id);


--
-- Name: filearchive filearchive_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.filearchive
    ADD CONSTRAINT filearchive_pkey PRIMARY KEY (fa_id);


--
-- Name: image image_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.image
    ADD CONSTRAINT image_pkey PRIMARY KEY (img_name);


--
-- Name: imagelinks imagelinks_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.imagelinks
    ADD CONSTRAINT imagelinks_pkey PRIMARY KEY (il_from, il_to);


--
-- Name: interwiki interwiki_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.interwiki
    ADD CONSTRAINT interwiki_pkey PRIMARY KEY (iw_prefix);


--
-- Name: ip_changes ip_changes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ip_changes
    ADD CONSTRAINT ip_changes_pkey PRIMARY KEY (ipc_rev_id);


--
-- Name: ipblocks ipblocks_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ipblocks
    ADD CONSTRAINT ipblocks_pkey PRIMARY KEY (ipb_id);


--
-- Name: ipblocks_restrictions ipblocks_restrictions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ipblocks_restrictions
    ADD CONSTRAINT ipblocks_restrictions_pkey PRIMARY KEY (ir_ipb_id, ir_type, ir_value);


--
-- Name: iwlinks iwlinks_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.iwlinks
    ADD CONSTRAINT iwlinks_pkey PRIMARY KEY (iwl_from, iwl_prefix, iwl_title);


--
-- Name: job job_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.job
    ADD CONSTRAINT job_pkey PRIMARY KEY (job_id);


--
-- Name: l10n_cache l10n_cache_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.l10n_cache
    ADD CONSTRAINT l10n_cache_pkey PRIMARY KEY (lc_lang, lc_key);


--
-- Name: langlinks langlinks_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.langlinks
    ADD CONSTRAINT langlinks_pkey PRIMARY KEY (ll_from, ll_lang);


--
-- Name: linktarget linktarget_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.linktarget
    ADD CONSTRAINT linktarget_pkey PRIMARY KEY (lt_id);


--
-- Name: log_search log_search_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.log_search
    ADD CONSTRAINT log_search_pkey PRIMARY KEY (ls_field, ls_value, ls_log_id);


--
-- Name: logging logging_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.logging
    ADD CONSTRAINT logging_pkey PRIMARY KEY (log_id);


--
-- Name: module_deps module_deps_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.module_deps
    ADD CONSTRAINT module_deps_pkey PRIMARY KEY (md_module, md_skin);


--
-- Name: objectcache objectcache_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.objectcache
    ADD CONSTRAINT objectcache_pkey PRIMARY KEY (keyname);


--
-- Name: page page_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.page
    ADD CONSTRAINT page_pkey PRIMARY KEY (page_id);


--
-- Name: page_props page_props_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.page_props
    ADD CONSTRAINT page_props_pkey PRIMARY KEY (pp_page, pp_propname);


--
-- Name: page_restrictions page_restrictions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.page_restrictions
    ADD CONSTRAINT page_restrictions_pkey PRIMARY KEY (pr_id);


--
-- Name: pagelinks pagelinks_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pagelinks
    ADD CONSTRAINT pagelinks_pkey PRIMARY KEY (pl_from, pl_namespace, pl_title);


--
-- Name: pgbench_accounts pgbench_accounts_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pgbench_accounts
    ADD CONSTRAINT pgbench_accounts_pkey PRIMARY KEY (aid);


--
-- Name: pgbench_branches pgbench_branches_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pgbench_branches
    ADD CONSTRAINT pgbench_branches_pkey PRIMARY KEY (bid);


--
-- Name: pgbench_history pgbench_history_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pgbench_history
    ADD CONSTRAINT pgbench_history_pkey PRIMARY KEY (mtime);


--
-- Name: pgbench_tellers pgbench_tellers_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pgbench_tellers
    ADD CONSTRAINT pgbench_tellers_pkey PRIMARY KEY (tid);


--
-- Name: protected_titles protected_titles_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.protected_titles
    ADD CONSTRAINT protected_titles_pkey PRIMARY KEY (pt_namespace, pt_title);


--
-- Name: querycache_info querycache_info_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.querycache_info
    ADD CONSTRAINT querycache_info_pkey PRIMARY KEY (qci_type);


--
-- Name: recentchanges recentchanges_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.recentchanges
    ADD CONSTRAINT recentchanges_pkey PRIMARY KEY (rc_id);


--
-- Name: redirect redirect_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.redirect
    ADD CONSTRAINT redirect_pkey PRIMARY KEY (rd_from);


--
-- Name: revision revision_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.revision
    ADD CONSTRAINT revision_pkey PRIMARY KEY (rev_id);


--
-- Name: site_identifiers site_identifiers_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.site_identifiers
    ADD CONSTRAINT site_identifiers_pkey PRIMARY KEY (si_type, si_key);


--
-- Name: site_stats site_stats_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.site_stats
    ADD CONSTRAINT site_stats_pkey PRIMARY KEY (ss_row_id);


--
-- Name: sites sites_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sites
    ADD CONSTRAINT sites_pkey PRIMARY KEY (site_id);


--
-- Name: slot_roles slot_roles_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.slot_roles
    ADD CONSTRAINT slot_roles_pkey PRIMARY KEY (role_id);


--
-- Name: slots slots_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.slots
    ADD CONSTRAINT slots_pkey PRIMARY KEY (slot_revision_id, slot_role_id);


--
-- Name: templatelinks templatelinks_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.templatelinks
    ADD CONSTRAINT templatelinks_pkey PRIMARY KEY (tl_from, tl_target_id);


--
-- Name: text text_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.text
    ADD CONSTRAINT text_pkey PRIMARY KEY (old_id);


--
-- Name: updatelog updatelog_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.updatelog
    ADD CONSTRAINT updatelog_pkey PRIMARY KEY (ul_key);


--
-- Name: uploadstash uploadstash_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.uploadstash
    ADD CONSTRAINT uploadstash_pkey PRIMARY KEY (us_id);


--
-- Name: user_autocreate_serial user_autocreate_serial_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_autocreate_serial
    ADD CONSTRAINT user_autocreate_serial_pkey PRIMARY KEY (uas_shard);


--
-- Name: user_former_groups user_former_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_former_groups
    ADD CONSTRAINT user_former_groups_pkey PRIMARY KEY (ufg_user, ufg_group);


--
-- Name: user_groups user_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_groups
    ADD CONSTRAINT user_groups_pkey PRIMARY KEY (ug_user, ug_group);


--
-- Name: user user_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_pkey PRIMARY KEY (user_id);


--
-- Name: user_properties user_properties_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_properties
    ADD CONSTRAINT user_properties_pkey PRIMARY KEY (up_user, up_property);


--
-- Name: watchlist_expiry watchlist_expiry_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.watchlist_expiry
    ADD CONSTRAINT watchlist_expiry_pkey PRIMARY KEY (we_item);


--
-- Name: watchlist watchlist_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.watchlist
    ADD CONSTRAINT watchlist_pkey PRIMARY KEY (wl_id);


--
-- Name: actor_name; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX actor_name ON public.actor USING btree (actor_name);


--
-- Name: actor_user; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX actor_user ON public.actor USING btree (actor_user);


--
-- Name: ar_actor_timestamp; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ar_actor_timestamp ON public.archive USING btree (ar_actor, ar_timestamp);


--
-- Name: ar_name_title_timestamp; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ar_name_title_timestamp ON public.archive USING btree (ar_namespace, ar_title, ar_timestamp);


--
-- Name: ar_revid_uniq; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX ar_revid_uniq ON public.archive USING btree (ar_rev_id);


--
-- Name: cat_pages; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX cat_pages ON public.category USING btree (cat_pages);


--
-- Name: cat_title; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX cat_title ON public.category USING btree (cat_title);


--
-- Name: cl_collation_ext; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX cl_collation_ext ON public.categorylinks USING btree (cl_collation, cl_to, cl_type, cl_from);


--
-- Name: cl_sortkey; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX cl_sortkey ON public.categorylinks USING btree (cl_to, cl_type, cl_sortkey, cl_from);


--
-- Name: cl_timestamp; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX cl_timestamp ON public.categorylinks USING btree (cl_to, cl_timestamp);


--
-- Name: comment_hash; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX comment_hash ON public.comment USING btree (comment_hash);


--
-- Name: ct_log_tag_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX ct_log_tag_id ON public.change_tag USING btree (ct_log_id, ct_tag_id);


--
-- Name: ct_rc_tag_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX ct_rc_tag_id ON public.change_tag USING btree (ct_rc_id, ct_tag_id);


--
-- Name: ct_rev_tag_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX ct_rev_tag_id ON public.change_tag USING btree (ct_rev_id, ct_tag_id);


--
-- Name: ct_tag_id_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ct_tag_id_id ON public.change_tag USING btree (ct_tag_id, ct_rc_id, ct_rev_id, ct_log_id);


--
-- Name: ctd_count; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ctd_count ON public.change_tag_def USING btree (ctd_count);


--
-- Name: ctd_name; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX ctd_name ON public.change_tag_def USING btree (ctd_name);


--
-- Name: ctd_user_defined; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ctd_user_defined ON public.change_tag_def USING btree (ctd_user_defined);


--
-- Name: el_from; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX el_from ON public.externallinks USING btree (el_from);


--
-- Name: el_to_domain_index_to_path; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX el_to_domain_index_to_path ON public.externallinks USING btree (el_to_domain_index, el_to_path);


--
-- Name: exptime; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX exptime ON public.objectcache USING btree (exptime);


--
-- Name: fa_actor_timestamp; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX fa_actor_timestamp ON public.filearchive USING btree (fa_actor, fa_timestamp);


--
-- Name: fa_deleted_timestamp; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX fa_deleted_timestamp ON public.filearchive USING btree (fa_deleted_timestamp);


--
-- Name: fa_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX fa_name ON public.filearchive USING btree (fa_name, fa_timestamp);


--
-- Name: fa_sha1; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX fa_sha1 ON public.filearchive USING btree (fa_sha1);


--
-- Name: fa_storage_group; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX fa_storage_group ON public.filearchive USING btree (fa_storage_group, fa_storage_key);


--
-- Name: il_backlinks_namespace; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX il_backlinks_namespace ON public.imagelinks USING btree (il_from_namespace, il_to, il_from);


--
-- Name: il_to; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX il_to ON public.imagelinks USING btree (il_to, il_from);


--
-- Name: img_actor_timestamp; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX img_actor_timestamp ON public.image USING btree (img_actor, img_timestamp);


--
-- Name: img_media_mime; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX img_media_mime ON public.image USING btree (img_media_type, img_major_mime, img_minor_mime);


--
-- Name: img_sha1; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX img_sha1 ON public.image USING btree (img_sha1);


--
-- Name: img_size; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX img_size ON public.image USING btree (img_size);


--
-- Name: img_timestamp; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX img_timestamp ON public.image USING btree (img_timestamp);


--
-- Name: ipb_address_unique; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX ipb_address_unique ON public.ipblocks USING btree (ipb_address, ipb_user, ipb_auto);


--
-- Name: ipb_expiry; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ipb_expiry ON public.ipblocks USING btree (ipb_expiry);


--
-- Name: ipb_parent_block_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ipb_parent_block_id ON public.ipblocks USING btree (ipb_parent_block_id);


--
-- Name: ipb_range; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ipb_range ON public.ipblocks USING btree (ipb_range_start, ipb_range_end);


--
-- Name: ipb_timestamp; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ipb_timestamp ON public.ipblocks USING btree (ipb_timestamp);


--
-- Name: ipb_user; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ipb_user ON public.ipblocks USING btree (ipb_user);


--
-- Name: ipc_hex_time; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ipc_hex_time ON public.ip_changes USING btree (ipc_hex, ipc_rev_timestamp);


--
-- Name: ipc_rev_timestamp; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ipc_rev_timestamp ON public.ip_changes USING btree (ipc_rev_timestamp);


--
-- Name: ir_type_value; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ir_type_value ON public.ipblocks_restrictions USING btree (ir_type, ir_value);


--
-- Name: iwl_prefix_from_title; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX iwl_prefix_from_title ON public.iwlinks USING btree (iwl_prefix, iwl_from, iwl_title);


--
-- Name: iwl_prefix_title_from; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX iwl_prefix_title_from ON public.iwlinks USING btree (iwl_prefix, iwl_title, iwl_from);


--
-- Name: job_cmd; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX job_cmd ON public.job USING btree (job_cmd, job_namespace, job_title, job_params);


--
-- Name: job_cmd_token; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX job_cmd_token ON public.job USING btree (job_cmd, job_token, job_random);


--
-- Name: job_cmd_token_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX job_cmd_token_id ON public.job USING btree (job_cmd, job_token, job_id);


--
-- Name: job_sha1; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX job_sha1 ON public.job USING btree (job_sha1);


--
-- Name: job_timestamp; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX job_timestamp ON public.job USING btree (job_timestamp);


--
-- Name: ll_lang; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ll_lang ON public.langlinks USING btree (ll_lang, ll_title);


--
-- Name: log_actor_time; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX log_actor_time ON public.logging USING btree (log_actor, log_timestamp);


--
-- Name: log_actor_type_time; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX log_actor_type_time ON public.logging USING btree (log_actor, log_type, log_timestamp);


--
-- Name: log_page_id_time; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX log_page_id_time ON public.logging USING btree (log_page, log_timestamp);


--
-- Name: log_page_time; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX log_page_time ON public.logging USING btree (log_namespace, log_title, log_timestamp);


--
-- Name: log_times; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX log_times ON public.logging USING btree (log_timestamp);


--
-- Name: log_type_action; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX log_type_action ON public.logging USING btree (log_type, log_action, log_timestamp);


--
-- Name: log_type_time; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX log_type_time ON public.logging USING btree (log_type, log_timestamp);


--
-- Name: ls_log_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ls_log_id ON public.log_search USING btree (ls_log_id);


--
-- Name: lt_namespace_title; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX lt_namespace_title ON public.linktarget USING btree (lt_namespace, lt_title);


--
-- Name: model_name; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX model_name ON public.content_models USING btree (model_name);


--
-- Name: oi_actor_timestamp; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX oi_actor_timestamp ON public.oldimage USING btree (oi_actor, oi_timestamp);


--
-- Name: oi_name_archive_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX oi_name_archive_name ON public.oldimage USING btree (oi_name, oi_archive_name);


--
-- Name: oi_name_timestamp; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX oi_name_timestamp ON public.oldimage USING btree (oi_name, oi_timestamp);


--
-- Name: oi_sha1; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX oi_sha1 ON public.oldimage USING btree (oi_sha1);


--
-- Name: oi_timestamp; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX oi_timestamp ON public.oldimage USING btree (oi_timestamp);


--
-- Name: page_len; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX page_len ON public.page USING btree (page_len);


--
-- Name: page_name_title; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX page_name_title ON public.page USING btree (page_namespace, page_title);


--
-- Name: page_random; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX page_random ON public.page USING btree (page_random);


--
-- Name: page_redirect_namespace_len; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX page_redirect_namespace_len ON public.page USING btree (page_is_redirect, page_namespace, page_len);


--
-- Name: pl_backlinks_namespace; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX pl_backlinks_namespace ON public.pagelinks USING btree (pl_from_namespace, pl_namespace, pl_title, pl_from);


--
-- Name: pl_backlinks_namespace_target_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX pl_backlinks_namespace_target_id ON public.pagelinks USING btree (pl_from_namespace, pl_target_id, pl_from);


--
-- Name: pl_namespace; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX pl_namespace ON public.pagelinks USING btree (pl_namespace, pl_title, pl_from);


--
-- Name: pl_target_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX pl_target_id ON public.pagelinks USING btree (pl_target_id, pl_from);


--
-- Name: pp_propname_page; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX pp_propname_page ON public.page_props USING btree (pp_propname, pp_page);


--
-- Name: pp_propname_sortkey_page; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX pp_propname_sortkey_page ON public.page_props USING btree (pp_propname, pp_sortkey, pp_page) WHERE (pp_sortkey IS NOT NULL);


--
-- Name: pr_cascade; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX pr_cascade ON public.page_restrictions USING btree (pr_cascade);


--
-- Name: pr_level; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX pr_level ON public.page_restrictions USING btree (pr_level);


--
-- Name: pr_pagetype; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX pr_pagetype ON public.page_restrictions USING btree (pr_page, pr_type);


--
-- Name: pr_typelevel; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX pr_typelevel ON public.page_restrictions USING btree (pr_type, pr_level);


--
-- Name: pt_timestamp; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX pt_timestamp ON public.protected_titles USING btree (pt_timestamp);


--
-- Name: qc_type; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX qc_type ON public.querycache USING btree (qc_type, qc_value);


--
-- Name: qcc_title; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX qcc_title ON public.querycachetwo USING btree (qcc_type, qcc_namespace, qcc_title);


--
-- Name: qcc_titletwo; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX qcc_titletwo ON public.querycachetwo USING btree (qcc_type, qcc_namespacetwo, qcc_titletwo);


--
-- Name: qcc_type; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX qcc_type ON public.querycachetwo USING btree (qcc_type, qcc_value);


--
-- Name: rc_actor; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX rc_actor ON public.recentchanges USING btree (rc_actor, rc_timestamp);


--
-- Name: rc_cur_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX rc_cur_id ON public.recentchanges USING btree (rc_cur_id);


--
-- Name: rc_ip; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX rc_ip ON public.recentchanges USING btree (rc_ip);


--
-- Name: rc_name_type_patrolled_timestamp; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX rc_name_type_patrolled_timestamp ON public.recentchanges USING btree (rc_namespace, rc_type, rc_patrolled, rc_timestamp);


--
-- Name: rc_namespace_title_timestamp; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX rc_namespace_title_timestamp ON public.recentchanges USING btree (rc_namespace, rc_title, rc_timestamp);


--
-- Name: rc_new_name_timestamp; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX rc_new_name_timestamp ON public.recentchanges USING btree (rc_new, rc_namespace, rc_timestamp);


--
-- Name: rc_ns_actor; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX rc_ns_actor ON public.recentchanges USING btree (rc_namespace, rc_actor);


--
-- Name: rc_this_oldid; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX rc_this_oldid ON public.recentchanges USING btree (rc_this_oldid);


--
-- Name: rc_timestamp; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX rc_timestamp ON public.recentchanges USING btree (rc_timestamp);


--
-- Name: rd_ns_title; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX rd_ns_title ON public.redirect USING btree (rd_namespace, rd_title, rd_from);


--
-- Name: rev_actor_timestamp; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX rev_actor_timestamp ON public.revision USING btree (rev_actor, rev_timestamp, rev_id);


--
-- Name: rev_page_actor_timestamp; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX rev_page_actor_timestamp ON public.revision USING btree (rev_page, rev_actor, rev_timestamp);


--
-- Name: rev_page_timestamp; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX rev_page_timestamp ON public.revision USING btree (rev_page, rev_timestamp);


--
-- Name: rev_timestamp; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX rev_timestamp ON public.revision USING btree (rev_timestamp);


--
-- Name: role_name; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX role_name ON public.slot_roles USING btree (role_name);


--
-- Name: si_key; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX si_key ON public.site_identifiers USING btree (si_key);


--
-- Name: si_page; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX si_page ON public.searchindex USING btree (si_page);


--
-- Name: si_site; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX si_site ON public.site_identifiers USING btree (si_site);


--
-- Name: si_text; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX si_text ON public.searchindex USING btree (si_text);


--
-- Name: si_title; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX si_title ON public.searchindex USING btree (si_title);


--
-- Name: site_domain; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX site_domain ON public.sites USING btree (site_domain);


--
-- Name: site_forward; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX site_forward ON public.sites USING btree (site_forward);


--
-- Name: site_global_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX site_global_key ON public.sites USING btree (site_global_key);


--
-- Name: site_group; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX site_group ON public.sites USING btree (site_group);


--
-- Name: site_language; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX site_language ON public.sites USING btree (site_language);


--
-- Name: site_protocol; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX site_protocol ON public.sites USING btree (site_protocol);


--
-- Name: site_source; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX site_source ON public.sites USING btree (site_source);


--
-- Name: site_type; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX site_type ON public.sites USING btree (site_type);


--
-- Name: slot_revision_origin_role; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX slot_revision_origin_role ON public.slots USING btree (slot_revision_id, slot_origin, slot_role_id);


--
-- Name: tl_backlinks_namespace_target_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX tl_backlinks_namespace_target_id ON public.templatelinks USING btree (tl_from_namespace, tl_target_id, tl_from);


--
-- Name: tl_target_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX tl_target_id ON public.templatelinks USING btree (tl_target_id, tl_from);


--
-- Name: ts2_page_text; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ts2_page_text ON public.text USING gin (textvector);


--
-- Name: ts2_page_title; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ts2_page_title ON public.page USING gin (titlevector);


--
-- Name: ug_expiry; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ug_expiry ON public.user_groups USING btree (ug_expiry);


--
-- Name: ug_group; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ug_group ON public.user_groups USING btree (ug_group);


--
-- Name: un_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX un_user_id ON public.user_newtalk USING btree (user_id);


--
-- Name: un_user_ip; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX un_user_ip ON public.user_newtalk USING btree (user_ip);


--
-- Name: up_property; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX up_property ON public.user_properties USING btree (up_property);


--
-- Name: us_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX us_key ON public.uploadstash USING btree (us_key);


--
-- Name: us_timestamp; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX us_timestamp ON public.uploadstash USING btree (us_timestamp);


--
-- Name: us_user; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX us_user ON public.uploadstash USING btree (us_user);


--
-- Name: user_email; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX user_email ON public."user" USING btree (user_email);


--
-- Name: user_email_token; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX user_email_token ON public."user" USING btree (user_email_token);


--
-- Name: user_name; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX user_name ON public."user" USING btree (user_name);


--
-- Name: we_expiry; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX we_expiry ON public.watchlist_expiry USING btree (we_expiry);


--
-- Name: wl_namespace_title; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX wl_namespace_title ON public.watchlist USING btree (wl_namespace, wl_title);


--
-- Name: wl_user; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX wl_user ON public.watchlist USING btree (wl_user, wl_namespace, wl_title);


--
-- Name: wl_user_notificationtimestamp; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX wl_user_notificationtimestamp ON public.watchlist USING btree (wl_user, wl_notificationtimestamp);


--
-- Name: text ts2_page_text; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER ts2_page_text BEFORE INSERT OR UPDATE ON public.text FOR EACH ROW EXECUTE FUNCTION public.ts2_page_text();


--
-- Name: page ts2_page_title; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER ts2_page_title BEFORE INSERT OR UPDATE ON public.page FOR EACH ROW EXECUTE FUNCTION public.ts2_page_title();


--
-- PostgreSQL database dump complete
--

