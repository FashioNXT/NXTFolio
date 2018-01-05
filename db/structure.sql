--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.10
-- Dumped by pg_dump version 9.5.10

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: general_infos; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE general_infos (
    id integer NOT NULL,
    "userKey" character varying,
    first_name character varying,
    last_name character varying,
    month_ofbirth integer,
    day_ofbirth integer,
    year_ofbirth integer,
    gender character varying,
    country character varying,
    state character varying,
    city character varying,
    compensation character varying,
    facebook_link character varying,
    "linkedIn_link" character varying,
    instagram_link character varying,
    "personalWebsite_link" character varying,
    bio text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    specific_profile_id integer,
    profile_picture character varying,
    cover_picture character varying,
    gallery_pictures character varying[],
    template_id integer,
    specific_profile json,
    phone character varying
);


--
-- Name: general_infos_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE general_infos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: general_infos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE general_infos_id_seq OWNED BY general_infos.id;


--
-- Name: login_infos; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE login_infos (
    id integer NOT NULL,
    email character varying,
    password character varying,
    "userKey" character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    is_admin character varying
);


--
-- Name: login_infos_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE login_infos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: login_infos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE login_infos_id_seq OWNED BY login_infos.id;


--
-- Name: models; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE models (
    id integer NOT NULL,
    email character varying DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying,
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    sign_in_count integer DEFAULT 0 NOT NULL,
    current_sign_in_at timestamp without time zone,
    last_sign_in_at timestamp without time zone,
    current_sign_in_ip inet,
    last_sign_in_ip inet,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: models_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE models_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: models_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE models_id_seq OWNED BY models.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE schema_migrations (
    version character varying NOT NULL
);


--
-- Name: specific_designers; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE specific_designers (
    id integer NOT NULL,
    genre text,
    influencers text,
    specialties text,
    compensation character varying,
    experience character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    user_key character varying
);


--
-- Name: specific_designers_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE specific_designers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: specific_designers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE specific_designers_id_seq OWNED BY specific_designers.id;


--
-- Name: specific_models; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE specific_models (
    id integer NOT NULL,
    height_feet integer,
    height_inches integer,
    bust integer,
    waist integer,
    hips integer,
    cups character varying,
    shoe_size integer,
    dress_size integer,
    hair_color character varying,
    eye_color character varying,
    ethnicity character varying,
    skin_color character varying,
    shoot_nudes character varying,
    tattoos character varying,
    piercings character varying,
    experience character varying,
    genre text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    user_key character varying
);


--
-- Name: specific_models_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE specific_models_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: specific_models_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE specific_models_id_seq OWNED BY specific_models.id;


--
-- Name: specific_photographers; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE specific_photographers (
    id integer NOT NULL,
    compensation character varying,
    experience character varying,
    influencers text,
    specialties text,
    genre text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    user_key character varying
);


--
-- Name: specific_photographers_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE specific_photographers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: specific_photographers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE specific_photographers_id_seq OWNED BY specific_photographers.id;


--
-- Name: templates; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE templates (
    id integer NOT NULL,
    prof_name character varying,
    prof_attribute json,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: templates_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE templates_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: templates_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE templates_id_seq OWNED BY templates.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE users (
    id integer NOT NULL,
    email character varying DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying,
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    sign_in_count integer DEFAULT 0 NOT NULL,
    current_sign_in_at timestamp without time zone,
    last_sign_in_at timestamp without time zone,
    current_sign_in_ip inet,
    last_sign_in_ip inet,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    provider character varying,
    uid character varying,
    name character varying,
    image text,
    password character varying
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY general_infos ALTER COLUMN id SET DEFAULT nextval('general_infos_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY login_infos ALTER COLUMN id SET DEFAULT nextval('login_infos_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY models ALTER COLUMN id SET DEFAULT nextval('models_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY specific_designers ALTER COLUMN id SET DEFAULT nextval('specific_designers_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY specific_models ALTER COLUMN id SET DEFAULT nextval('specific_models_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY specific_photographers ALTER COLUMN id SET DEFAULT nextval('specific_photographers_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY templates ALTER COLUMN id SET DEFAULT nextval('templates_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Name: ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: general_infos_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY general_infos
    ADD CONSTRAINT general_infos_pkey PRIMARY KEY (id);


--
-- Name: login_infos_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY login_infos
    ADD CONSTRAINT login_infos_pkey PRIMARY KEY (id);


--
-- Name: models_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY models
    ADD CONSTRAINT models_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: specific_designers_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY specific_designers
    ADD CONSTRAINT specific_designers_pkey PRIMARY KEY (id);


--
-- Name: specific_models_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY specific_models
    ADD CONSTRAINT specific_models_pkey PRIMARY KEY (id);


--
-- Name: specific_photographers_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY specific_photographers
    ADD CONSTRAINT specific_photographers_pkey PRIMARY KEY (id);


--
-- Name: templates_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY templates
    ADD CONSTRAINT templates_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: index_models_on_email; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_models_on_email ON models USING btree (email);


--
-- Name: index_models_on_reset_password_token; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_models_on_reset_password_token ON models USING btree (reset_password_token);


--
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_email ON users USING btree (email);


--
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_reset_password_token ON users USING btree (reset_password_token);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user", public;

INSERT INTO "schema_migrations" (version) VALUES
('20170306204334'),
('20170306204352'),
('20170306204420'),
('20170306204428'),
('20170306204435'),
('20170307235111'),
('20170308000145'),
('20170308000208'),
('20170315232224'),
('20170424033810'),
('20170425004010'),
('20170425033957'),
('20171004233012'),
('20171005003723'),
('20171022194739'),
('20171105053437'),
('20171105234827'),
('20171116091856'),
('20171116092501'),
('20171116092640'),
('20171120014424'),
('20171125205853'),
('20180103070721');


