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
-- Data for Name: actor; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.actor (actor_id, actor_user, actor_name) VALUES
	(1, 1, 'Test'),
	(2, 2, 'MediaWiki default');


--
-- Data for Name: archive; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: bot_passwords; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: category; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: categorylinks; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: change_tag; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: change_tag_def; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: comment; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.comment (comment_id, comment_hash, comment_text, comment_data) VALUES
	(1, 0, '', NULL);


--
-- Data for Name: content; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.content (content_id, content_size, content_sha1, content_model, content_address) VALUES
	(1, 1030, 'mbpqtir3kv6nje91ox8qhit10ifhnuu', 1, 'tt:1');


--
-- Data for Name: content_models; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.content_models (model_id, model_name) VALUES
	(1, 'wikitext');


--
-- Data for Name: externallinks; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: filearchive; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: image; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: imagelinks; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: interwiki; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.interwiki (iw_prefix, iw_url, iw_api, iw_wikiid, iw_local, iw_trans) VALUES
	('acronym', 'https://www.acronymfinder.com/~/search/af.aspx?string=exact&Acronym=$1', '', '', 0, 0),
	('advogato', 'http://www.advogato.org/$1', '', '', 0, 0),
	('arxiv', 'https://www.arxiv.org/abs/$1', '', '', 0, 0),
	('c2find', 'http://c2.com/cgi/wiki?FindPage&value=$1', '', '', 0, 0),
	('cache', 'https://www.google.com/search?q=cache:$1', '', '', 0, 0),
	('commons', 'https://commons.wikimedia.org/wiki/$1', 'https://commons.wikimedia.org/w/api.php', '', 0, 0),
	('dictionary', 'http://www.dict.org/bin/Dict?Database=*&Form=Dict1&Strategy=*&Query=$1', '', '', 0, 0),
	('doi', 'https://dx.doi.org/$1', '', '', 0, 0),
	('drumcorpswiki', 'http://www.drumcorpswiki.com/$1', 'http://drumcorpswiki.com/api.php', '', 0, 0),
	('dwjwiki', 'http://www.suberic.net/cgi-bin/dwj/wiki.cgi?$1', '', '', 0, 0),
	('elibre', 'http://enciclopedia.us.es/index.php/$1', 'http://enciclopedia.us.es/api.php', '', 0, 0),
	('emacswiki', 'https://www.emacswiki.org/emacs/$1', '', '', 0, 0),
	('foldoc', 'https://foldoc.org/?$1', '', '', 0, 0),
	('foxwiki', 'https://fox.wikis.com/wc.dll?Wiki~$1', '', '', 0, 0),
	('freebsdman', 'https://www.FreeBSD.org/cgi/man.cgi?apropos=1&query=$1', '', '', 0, 0),
	('gentoo-wiki', 'http://gentoo-wiki.com/$1', '', '', 0, 0),
	('google', 'https://www.google.com/search?q=$1', '', '', 0, 0),
	('googlegroups', 'https://groups.google.com/groups?q=$1', '', '', 0, 0),
	('hammondwiki', 'http://www.dairiki.org/HammondWiki/$1', '', '', 0, 0),
	('hrwiki', 'http://www.hrwiki.org/wiki/$1', 'http://www.hrwiki.org/w/api.php', '', 0, 0),
	('imdb', 'http://www.imdb.com/find?q=$1&tt=on', '', '', 0, 0),
	('kmwiki', 'https://kmwiki.wikispaces.com/$1', '', '', 0, 0),
	('linuxwiki', 'http://linuxwiki.de/$1', '', '', 0, 0),
	('lojban', 'https://mw.lojban.org/papri/$1', '', '', 0, 0),
	('lqwiki', 'http://wiki.linuxquestions.org/wiki/$1', '', '', 0, 0),
	('meatball', 'http://meatballwiki.org/wiki/$1', '', '', 0, 0),
	('mediawikiwiki', 'https://www.mediawiki.org/wiki/$1', 'https://www.mediawiki.org/w/api.php', '', 0, 0),
	('memoryalpha', 'http://en.memory-alpha.org/wiki/$1', 'http://en.memory-alpha.org/api.php', '', 0, 0),
	('metawiki', 'http://sunir.org/apps/meta.pl?$1', '', '', 0, 0),
	('metawikimedia', 'https://meta.wikimedia.org/wiki/$1', 'https://meta.wikimedia.org/w/api.php', '', 0, 0),
	('mozillawiki', 'https://wiki.mozilla.org/$1', 'https://wiki.mozilla.org/api.php', '', 0, 0),
	('mw', 'https://www.mediawiki.org/wiki/$1', 'https://www.mediawiki.org/w/api.php', '', 0, 0),
	('oeis', 'https://oeis.org/$1', '', '', 0, 0),
	('openwiki', 'http://openwiki.com/ow.asp?$1', '', '', 0, 0),
	('pmid', 'https://www.ncbi.nlm.nih.gov/pubmed/$1?dopt=Abstract', '', '', 0, 0),
	('pythoninfo', 'https://wiki.python.org/moin/$1', '', '', 0, 0),
	('rfc', 'https://tools.ietf.org/html/rfc$1', '', '', 0, 0),
	('s23wiki', 'http://s23.org/wiki/$1', 'http://s23.org/w/api.php', '', 0, 0),
	('seattlewireless', 'http://seattlewireless.net/$1', '', '', 0, 0),
	('senseislibrary', 'https://senseis.xmp.net/?$1', '', '', 0, 0),
	('shoutwiki', 'http://www.shoutwiki.com/wiki/$1', 'http://www.shoutwiki.com/w/api.php', '', 0, 0),
	('squeak', 'http://wiki.squeak.org/squeak/$1', '', '', 0, 0),
	('tmbw', 'http://www.tmbw.net/wiki/$1', 'http://tmbw.net/wiki/api.php', '', 0, 0),
	('tmnet', 'http://www.technomanifestos.net/?$1', '', '', 0, 0),
	('theopedia', 'https://www.theopedia.com/$1', '', '', 0, 0),
	('twiki', 'http://twiki.org/cgi-bin/view/$1', '', '', 0, 0),
	('uncyclopedia', 'https://en.uncyclopedia.co/wiki/$1', 'https://en.uncyclopedia.co/w/api.php', '', 0, 0),
	('unreal', 'https://wiki.beyondunreal.com/$1', 'https://wiki.beyondunreal.com/w/api.php', '', 0, 0),
	('usemod', 'http://www.usemod.com/cgi-bin/wiki.pl?$1', '', '', 0, 0),
	('wiki', 'http://c2.com/cgi/wiki?$1', '', '', 0, 0),
	('wikia', 'http://www.wikia.com/wiki/$1', '', '', 0, 0),
	('wikibooks', 'https://en.wikibooks.org/wiki/$1', 'https://en.wikibooks.org/w/api.php', '', 0, 0),
	('wikidata', 'https://www.wikidata.org/wiki/$1', 'https://www.wikidata.org/w/api.php', '', 0, 0),
	('wikif1', 'http://www.wikif1.org/$1', '', '', 0, 0),
	('wikihow', 'https://www.wikihow.com/$1', 'https://www.wikihow.com/api.php', '', 0, 0),
	('wikinfo', 'http://wikinfo.co/English/index.php/$1', '', '', 0, 0),
	('wikimedia', 'https://foundation.wikimedia.org/wiki/$1', 'https://foundation.wikimedia.org/w/api.php', '', 0, 0),
	('wikinews', 'https://en.wikinews.org/wiki/$1', 'https://en.wikinews.org/w/api.php', '', 0, 0),
	('wikipedia', 'https://en.wikipedia.org/wiki/$1', 'https://en.wikipedia.org/w/api.php', '', 0, 0),
	('wikiquote', 'https://en.wikiquote.org/wiki/$1', 'https://en.wikiquote.org/w/api.php', '', 0, 0),
	('wikisource', 'https://wikisource.org/wiki/$1', 'https://wikisource.org/w/api.php', '', 0, 0),
	('wikispecies', 'https://species.wikimedia.org/wiki/$1', 'https://species.wikimedia.org/w/api.php', '', 0, 0),
	('wikiversity', 'https://en.wikiversity.org/wiki/$1', 'https://en.wikiversity.org/w/api.php', '', 0, 0),
	('wikivoyage', 'https://en.wikivoyage.org/wiki/$1', 'https://en.wikivoyage.org/w/api.php', '', 0, 0),
	('wikt', 'https://en.wiktionary.org/wiki/$1', 'https://en.wiktionary.org/w/api.php', '', 0, 0),
	('wiktionary', 'https://en.wiktionary.org/wiki/$1', 'https://en.wiktionary.org/w/api.php', '', 0, 0);


--
-- Data for Name: ip_changes; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: ipblocks; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: ipblocks_restrictions; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: iwlinks; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: job; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: l10n_cache; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: langlinks; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: linktarget; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: log_search; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.log_search (ls_field, ls_value, ls_log_id) VALUES
	('associated_rev_id', '1', 1);


--
-- Data for Name: logging; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.logging (log_id, log_type, log_action, log_timestamp, log_actor, log_namespace, log_title, log_page, log_comment_id, log_params, log_deleted) VALUES
	(1, 'create', 'create', '2024-03-18 13:19:29+00', 2, 0, 'Заглавная_страница', 1, 1, 'a:1:{s:17:"associated_rev_id";i:1;}', 0);


--
-- Data for Name: module_deps; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: objectcache; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: oldimage; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: page; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_links_updated, page_latest, page_len, page_content_model, page_lang, titlevector) VALUES
	(1, 0, 'Заглавная_страница', 0, 1, 0.704289653973, '2024-03-18 13:19:29+00', NULL, 1, 1030, 'wikitext', NULL, '''заглавная'':1 ''страница'':2');


--
-- Data for Name: page_props; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: page_restrictions; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: pagelinks; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: protected_titles; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: querycache; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: querycache_info; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: querycachetwo; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: recentchanges; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: redirect; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: revision; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1) VALUES
	(1, 1, 1, 2, '2024-03-18 13:19:29+00', 0, 0, 1030, 0, 'mbpqtir3kv6nje91ox8qhit10ifhnuu');


--
-- Data for Name: searchindex; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: site_identifiers; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: site_stats; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.site_stats (ss_row_id, ss_total_edits, ss_good_articles, ss_total_pages, ss_users, ss_active_users, ss_images) VALUES
	(1, 0, 0, 0, 1, 0, 0);


--
-- Data for Name: sites; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: slot_roles; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.slot_roles (role_id, role_name) VALUES
	(1, 'main');


--
-- Data for Name: slots; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin) VALUES
	(1, 1, 1, 1);


--
-- Data for Name: templatelinks; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: text; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.text (old_id, old_text, old_flags, textvector) VALUES
	(1, '<strong>MediaWiki успешно установлена.</strong>

Информацию по работе с этой вики можно найти в [https://www.mediawiki.org/wiki/Special:MyLanguage/Help:Contents справочном руководстве].

== Начало работы ==
* [https://www.mediawiki.org/wiki/Special:MyLanguage/Manual:Configuration_settings Список возможных настроек];
* [https://www.mediawiki.org/wiki/Manual:FAQ/ru Часто задаваемые вопросы и ответы по MediaWiki];
* [https://lists.wikimedia.org/postorius/lists/mediawiki-announce.lists.wikimedia.org/ Рассылка уведомлений о выходе новых версий MediaWiki].
* [https://www.mediawiki.org/wiki/Special:MyLanguage/Localisation#Translation_resources Перевод MediaWiki на свой язык]
* [https://www.mediawiki.org/wiki/Special:MyLanguage/Manual:Combating_spam Узнайте, как бороться со спамом в вашей вики]', 'utf-8', '''/postorius/lists/mediawiki-announce.lists.wikimedia.org/'':38 ''/wiki/manual:faq/ru'':28 ''/wiki/special:mylanguage/help:contents'':15 ''/wiki/special:mylanguage/localisation#translation_resources'':48 ''/wiki/special:mylanguage/manual:combating_spam'':56 ''/wiki/special:mylanguage/manual:configuration_settings'':22 ''lists.wikimedia.org'':37 ''lists.wikimedia.org/postorius/lists/mediawiki-announce.lists.wikimedia.org/'':36 ''mediawiki'':1,35,45,50 ''www.mediawiki.org'':14,21,27,47,55 ''www.mediawiki.org/wiki/manual:faq/ru'':26 ''www.mediawiki.org/wiki/special:mylanguage/help:contents'':13 ''www.mediawiki.org/wiki/special:mylanguage/localisation#translation_resources'':46 ''www.mediawiki.org/wiki/special:mylanguage/manual:combating_spam'':54 ''www.mediawiki.org/wiki/special:mylanguage/manual:configuration_settings'':20 ''бороться'':59 ''в'':12,62 ''вашей'':63 ''версий'':44 ''вики'':9,64 ''возможных'':24 ''вопросы'':31 ''выходе'':42 ''задаваемые'':30 ''и'':32 ''информацию'':4 ''как'':58 ''можно'':10 ''на'':51 ''найти'':11 ''настроек'':25 ''начало'':18 ''новых'':43 ''о'':41 ''ответы'':33 ''перевод'':49 ''по'':5,34 ''работе'':6 ''работы'':19 ''рассылка'':39 ''руководстве'':17 ''с'':7 ''свой'':52 ''со'':60 ''спамом'':61 ''список'':23 ''справочном'':16 ''уведомлений'':40 ''узнайте'':57 ''успешно'':2 ''установлена'':3 ''часто'':29 ''этой'':8 ''язык'':53');


--
-- Data for Name: updatelog; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.updatelog (ul_key, ul_value) VALUES
	('filearchive-fa_major_mime-patch-fa_major_mime-chemical.sql', NULL),
	('image-img_major_mime-patch-img_major_mime-chemical.sql', NULL),
	('oldimage-oi_major_mime-patch-oi_major_mime-chemical.sql', NULL),
	('user_groups-ug_group-patch-ug_group-length-increase-255.sql', NULL),
	('user_former_groups-ufg_group-patch-ufg_group-length-increase-255.sql', NULL),
	('user_properties-up_property-patch-up_property.sql', NULL),
	('patch-textsearch_bug66650.sql', NULL);


--
-- Data for Name: uploadstash; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: user; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public."user" (user_id, user_name, user_real_name, user_password, user_newpassword, user_newpass_time, user_email, user_touched, user_token, user_email_authenticated, user_email_token, user_email_token_expires, user_registration, user_editcount, user_password_expires, user_is_temp) VALUES
	(1, 'Test', '', ':pbkdf2:sha512:30000:64:zDYS1ck4V0wEw3UVeHiO7Q==:ISiEINwGxn0kw4L6G5nImqY35vROOUcEvh0v7tSk9tdnHbpzNylAes+3DK+6NYQuvMkbqKuvdRFRp5nFGXrgqg==', '', NULL, 'test@mail.com', '2024-03-18 13:19:30+00', 'fade2e9adf268f6c9876de2f6ab9b465', NULL, NULL, NULL, '2024-03-18 13:19:29+00', 0, NULL, 0),
	(2, 'MediaWiki default', '', '', '', NULL, '', '2024-03-18 13:19:29+00', '*** INVALID ***', NULL, NULL, NULL, '2024-03-18 13:19:29+00', 0, NULL, 0);


--
-- Data for Name: user_autocreate_serial; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: user_former_groups; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: user_groups; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.user_groups (ug_user, ug_group, ug_expiry) VALUES
	(1, 'sysop', NULL),
	(1, 'bureaucrat', NULL),
	(1, 'interface-admin', NULL);


--
-- Data for Name: user_newtalk; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: user_properties; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: watchlist; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: watchlist_expiry; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Name: actor_actor_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.actor_actor_id_seq', 2, true);


--
-- Name: archive_ar_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.archive_ar_id_seq', 1, false);


--
-- Name: category_cat_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.category_cat_id_seq', 1, false);


--
-- Name: change_tag_ct_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.change_tag_ct_id_seq', 1, false);


--
-- Name: change_tag_def_ctd_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.change_tag_def_ctd_id_seq', 1, false);


--
-- Name: comment_comment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.comment_comment_id_seq', 1, true);


--
-- Name: content_content_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.content_content_id_seq', 1, true);


--
-- Name: content_models_model_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.content_models_model_id_seq', 1, true);


--
-- Name: externallinks_el_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.externallinks_el_id_seq', 1, false);


--
-- Name: filearchive_fa_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.filearchive_fa_id_seq', 1, false);


--
-- Name: ipblocks_ipb_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.ipblocks_ipb_id_seq', 1, false);


--
-- Name: job_job_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.job_job_id_seq', 1, false);


--
-- Name: linktarget_lt_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.linktarget_lt_id_seq', 1, false);


--
-- Name: logging_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.logging_log_id_seq', 1, true);


--
-- Name: page_page_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.page_page_id_seq', 1, true);


--
-- Name: page_restrictions_pr_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.page_restrictions_pr_id_seq', 1, false);


--
-- Name: recentchanges_rc_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.recentchanges_rc_id_seq', 1, false);


--
-- Name: revision_rev_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.revision_rev_id_seq', 1, true);


--
-- Name: sites_site_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.sites_site_id_seq', 1, false);


--
-- Name: slot_roles_role_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.slot_roles_role_id_seq', 1, true);


--
-- Name: text_old_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.text_old_id_seq', 1, true);


--
-- Name: uploadstash_us_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.uploadstash_us_id_seq', 1, false);


--
-- Name: user_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.user_user_id_seq', 2, true);


--
-- Name: watchlist_wl_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.watchlist_wl_id_seq', 1, false);


--
-- PostgreSQL database dump complete
--

