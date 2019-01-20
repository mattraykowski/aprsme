--
-- PostgreSQL database dump
--

-- Dumped from database version 11.0
-- Dumped by pg_dump version 11.1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: postgis; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS postgis WITH SCHEMA public;


--
-- Name: EXTENSION postgis; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION postgis IS 'PostGIS geometry, geography, and raster spatial types and functions';


--
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA public;


--
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: packets; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.packets (
    id bigint NOT NULL,
    alive integer,
    altitude double precision,
    body bytea,
    dstcallsign character varying(9),
    symbolcode character varying(1),
    symboltable character varying(1),
    speed double precision,
    latitude double precision,
    longitude double precision,
    origpacket bytea,
    mbits character varying(3),
    comment bytea,
    format character varying(12),
    posambiguity integer,
    posresolution double precision,
    type character varying(255),
    header character varying(255),
    phg integer,
    messaging integer,
    srccallsign character varying(9),
    telemetry text,
    capabilities character varying(255),
    course integer,
    status bytea,
    "timestamp" timestamp(0) without time zone,
    radiorange double precision,
    destination character varying(9),
    objectname character varying(9),
    daodatumbyte character varying(255),
    message character varying(255),
    checksumok integer,
    gpsfixstatus integer,
    messageid character varying(5),
    itemname character varying(9),
    messageack character varying(5),
    messagerej character varying(255),
    dxfreq character varying(255),
    dxinfo character varying(255),
    resultcode character varying(255),
    dxcall character varying(255),
    dxsource character varying(255),
    dxtime character varying(255),
    resultmsg character varying(255),
    digipeaters text,
    wx text,
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL,
    point public.geometry(Point,4326)
);


--
-- Name: packets_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.packets_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: packets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.packets_id_seq OWNED BY public.packets.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.schema_migrations (
    version bigint NOT NULL,
    inserted_at timestamp(0) without time zone
);


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    email character varying(255) NOT NULL,
    name character varying(255),
    password_hash character varying(255),
    is_admin boolean DEFAULT false NOT NULL,
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: packets id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.packets ALTER COLUMN id SET DEFAULT nextval('public.packets_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: packets packets_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.packets
    ADD CONSTRAINT packets_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: packets_inserted_at_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX packets_inserted_at_index ON public.packets USING btree (inserted_at);


--
-- Name: packets_latitude_longitude_inserted_at_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX packets_latitude_longitude_inserted_at_index ON public.packets USING btree (latitude, longitude, inserted_at);


--
-- Name: packets_point_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX packets_point_index ON public.packets USING gist (point);


--
-- Name: packets_srccallsign_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX packets_srccallsign_index ON public.packets USING btree (srccallsign);


--
-- Name: packets_srccallsign_inserted_at_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX packets_srccallsign_inserted_at_index ON public.packets USING btree (srccallsign, inserted_at);


--
-- Name: users_email_index; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX users_email_index ON public.users USING btree (email);


--
-- PostgreSQL database dump complete
--

INSERT INTO public."schema_migrations" (version) VALUES (20170220212550), (20170226182313), (20170304012153), (20170304022807), (20170308052112), (20170312134957), (20170312135934), (20170312142609), (20170312143118), (20170312143738), (20170312144203), (20170312144736), (20170312145106), (20170312151559), (20170312161758), (20170321000834), (20170326162233), (20171221021619);

