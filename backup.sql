--
-- PostgreSQL database dump
--

-- Dumped from database version 14.18 (Debian 14.18-1.pgdg120+1)
-- Dumped by pg_dump version 14.18 (Debian 14.18-1.pgdg120+1)

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: pushups; Type: TABLE; Schema: public; Owner: pushup_user
--

CREATE TABLE public.pushups (
    record_id integer NOT NULL,
    user_id bigint NOT NULL,
    date date NOT NULL,
    count integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.pushups OWNER TO pushup_user;

--
-- Name: pushups_record_id_seq; Type: SEQUENCE; Schema: public; Owner: pushup_user
--

CREATE SEQUENCE public.pushups_record_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.pushups_record_id_seq OWNER TO pushup_user;

--
-- Name: pushups_record_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pushup_user
--

ALTER SEQUENCE public.pushups_record_id_seq OWNED BY public.pushups.record_id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: pushup_user
--

CREATE TABLE public.users (
    user_id bigint NOT NULL,
    username character varying(100) DEFAULT ''::character varying NOT NULL,
    max_reps integer DEFAULT 40 NOT NULL,
    last_updated timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.users OWNER TO pushup_user;

--
-- Name: pushups record_id; Type: DEFAULT; Schema: public; Owner: pushup_user
--

ALTER TABLE ONLY public.pushups ALTER COLUMN record_id SET DEFAULT nextval('public.pushups_record_id_seq'::regclass);


--
-- Data for Name: pushups; Type: TABLE DATA; Schema: public; Owner: pushup_user
--

COPY public.pushups (record_id, user_id, date, count) FROM stdin;
1	123456	2025-07-27	30
2	654321	2025-07-27	45
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: pushup_user
--

COPY public.users (user_id, username, max_reps, last_updated) FROM stdin;
123456	test_user1	40	2025-07-27 05:31:54.940194
654321	test_user2	40	2025-07-27 05:31:54.940194
\.


--
-- Name: pushups_record_id_seq; Type: SEQUENCE SET; Schema: public; Owner: pushup_user
--

SELECT pg_catalog.setval('public.pushups_record_id_seq', 2, true);


--
-- Name: pushups pushups_pkey; Type: CONSTRAINT; Schema: public; Owner: pushup_user
--

ALTER TABLE ONLY public.pushups
    ADD CONSTRAINT pushups_pkey PRIMARY KEY (record_id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: pushup_user
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);


--
-- Name: idx_pushups_date; Type: INDEX; Schema: public; Owner: pushup_user
--

CREATE INDEX idx_pushups_date ON public.pushups USING btree (date);


--
-- Name: idx_pushups_user_date; Type: INDEX; Schema: public; Owner: pushup_user
--

CREATE INDEX idx_pushups_user_date ON public.pushups USING btree (user_id, date);


--
-- Name: pushups pushups_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pushup_user
--

ALTER TABLE ONLY public.pushups
    ADD CONSTRAINT pushups_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

