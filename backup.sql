--
-- PostgreSQL database dump
--

-- Dumped from database version 17.4 (Debian 17.4-1.pgdg120+2)
-- Dumped by pg_dump version 17.4 (Debian 17.4-1.pgdg120+2)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: public; Type: SCHEMA; Schema: -; Owner: satyam
--

-- *not* creating schema, since initdb creates it


ALTER SCHEMA public OWNER TO satyam;

--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: satyam
--

COMMENT ON SCHEMA public IS '';


--
-- Name: OrderStatus; Type: TYPE; Schema: public; Owner: satyam
--

CREATE TYPE public."OrderStatus" AS ENUM (
    'PENDING',
    'PROCESSING',
    'SHIPPED',
    'DELIVERED',
    'CANCELLED'
);


ALTER TYPE public."OrderStatus" OWNER TO satyam;

--
-- Name: Role; Type: TYPE; Schema: public; Owner: satyam
--

CREATE TYPE public."Role" AS ENUM (
    'BUYER',
    'SELLER',
    'ADMIN'
);


ALTER TYPE public."Role" OWNER TO satyam;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: _prisma_migrations; Type: TABLE; Schema: public; Owner: satyam
--

CREATE TABLE public._prisma_migrations (
    id character varying(36) NOT NULL,
    checksum character varying(64) NOT NULL,
    finished_at timestamp with time zone,
    migration_name character varying(255) NOT NULL,
    logs text,
    rolled_back_at timestamp with time zone,
    started_at timestamp with time zone DEFAULT now() NOT NULL,
    applied_steps_count integer DEFAULT 0 NOT NULL
);


ALTER TABLE public._prisma_migrations OWNER TO satyam;

--
-- Name: categories; Type: TABLE; Schema: public; Owner: satyam
--

CREATE TABLE public.categories (
    id integer NOT NULL,
    name text NOT NULL,
    slug text NOT NULL,
    description text,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


ALTER TABLE public.categories OWNER TO satyam;

--
-- Name: categories_id_seq; Type: SEQUENCE; Schema: public; Owner: satyam
--

CREATE SEQUENCE public.categories_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.categories_id_seq OWNER TO satyam;

--
-- Name: categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: satyam
--

ALTER SEQUENCE public.categories_id_seq OWNED BY public.categories.id;


--
-- Name: product_variants; Type: TABLE; Schema: public; Owner: satyam
--

CREATE TABLE public.product_variants (
    id integer NOT NULL,
    sku text NOT NULL,
    "productId" integer NOT NULL,
    attributes jsonb NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.product_variants OWNER TO satyam;

--
-- Name: product_variants_id_seq; Type: SEQUENCE; Schema: public; Owner: satyam
--

CREATE SEQUENCE public.product_variants_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.product_variants_id_seq OWNER TO satyam;

--
-- Name: product_variants_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: satyam
--

ALTER SEQUENCE public.product_variants_id_seq OWNED BY public.product_variants.id;


--
-- Name: products; Type: TABLE; Schema: public; Owner: satyam
--

CREATE TABLE public.products (
    id integer NOT NULL,
    name text NOT NULL,
    description text NOT NULL,
    "subcategoryId" integer NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.products OWNER TO satyam;

--
-- Name: products_id_seq; Type: SEQUENCE; Schema: public; Owner: satyam
--

CREATE SEQUENCE public.products_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.products_id_seq OWNER TO satyam;

--
-- Name: products_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: satyam
--

ALTER SEQUENCE public.products_id_seq OWNED BY public.products.id;


--
-- Name: refresh_tokens; Type: TABLE; Schema: public; Owner: satyam
--

CREATE TABLE public.refresh_tokens (
    id integer NOT NULL,
    token text NOT NULL,
    "userId" integer NOT NULL,
    "userAgent" text,
    ip text,
    "expiresAt" timestamp(3) without time zone NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.refresh_tokens OWNER TO satyam;

--
-- Name: refresh_tokens_id_seq; Type: SEQUENCE; Schema: public; Owner: satyam
--

CREATE SEQUENCE public.refresh_tokens_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.refresh_tokens_id_seq OWNER TO satyam;

--
-- Name: refresh_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: satyam
--

ALTER SEQUENCE public.refresh_tokens_id_seq OWNED BY public.refresh_tokens.id;


--
-- Name: seller_variants; Type: TABLE; Schema: public; Owner: satyam
--

CREATE TABLE public.seller_variants (
    id integer NOT NULL,
    "sellerId" text NOT NULL,
    price double precision NOT NULL,
    stock integer NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "productVariantId" integer NOT NULL
);


ALTER TABLE public.seller_variants OWNER TO satyam;

--
-- Name: seller_variants_id_seq; Type: SEQUENCE; Schema: public; Owner: satyam
--

CREATE SEQUENCE public.seller_variants_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.seller_variants_id_seq OWNER TO satyam;

--
-- Name: seller_variants_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: satyam
--

ALTER SEQUENCE public.seller_variants_id_seq OWNED BY public.seller_variants.id;


--
-- Name: sellers; Type: TABLE; Schema: public; Owner: satyam
--

CREATE TABLE public.sellers (
    id text NOT NULL,
    "pickupAddress" text NOT NULL,
    "businessName" text NOT NULL,
    "gstNumber" text,
    "bankInfo" text,
    "userId" integer NOT NULL,
    "sellerRating" double precision DEFAULT 0 NOT NULL
);


ALTER TABLE public.sellers OWNER TO satyam;

--
-- Name: subcategories; Type: TABLE; Schema: public; Owner: satyam
--

CREATE TABLE public.subcategories (
    id integer NOT NULL,
    name text NOT NULL,
    slug text NOT NULL,
    description text,
    "categoryId" integer NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


ALTER TABLE public.subcategories OWNER TO satyam;

--
-- Name: subcategories_id_seq; Type: SEQUENCE; Schema: public; Owner: satyam
--

CREATE SEQUENCE public.subcategories_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.subcategories_id_seq OWNER TO satyam;

--
-- Name: subcategories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: satyam
--

ALTER SEQUENCE public.subcategories_id_seq OWNED BY public.subcategories.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: satyam
--

CREATE TABLE public.users (
    id integer NOT NULL,
    "fullName" text NOT NULL,
    email text NOT NULL,
    password text NOT NULL,
    phone text NOT NULL,
    address text NOT NULL,
    role public."Role" DEFAULT 'BUYER'::public."Role" NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


ALTER TABLE public.users OWNER TO satyam;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: satyam
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO satyam;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: satyam
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: categories id; Type: DEFAULT; Schema: public; Owner: satyam
--

ALTER TABLE ONLY public.categories ALTER COLUMN id SET DEFAULT nextval('public.categories_id_seq'::regclass);


--
-- Name: product_variants id; Type: DEFAULT; Schema: public; Owner: satyam
--

ALTER TABLE ONLY public.product_variants ALTER COLUMN id SET DEFAULT nextval('public.product_variants_id_seq'::regclass);


--
-- Name: products id; Type: DEFAULT; Schema: public; Owner: satyam
--

ALTER TABLE ONLY public.products ALTER COLUMN id SET DEFAULT nextval('public.products_id_seq'::regclass);


--
-- Name: refresh_tokens id; Type: DEFAULT; Schema: public; Owner: satyam
--

ALTER TABLE ONLY public.refresh_tokens ALTER COLUMN id SET DEFAULT nextval('public.refresh_tokens_id_seq'::regclass);


--
-- Name: seller_variants id; Type: DEFAULT; Schema: public; Owner: satyam
--

ALTER TABLE ONLY public.seller_variants ALTER COLUMN id SET DEFAULT nextval('public.seller_variants_id_seq'::regclass);


--
-- Name: subcategories id; Type: DEFAULT; Schema: public; Owner: satyam
--

ALTER TABLE ONLY public.subcategories ALTER COLUMN id SET DEFAULT nextval('public.subcategories_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: satyam
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: _prisma_migrations; Type: TABLE DATA; Schema: public; Owner: satyam
--

COPY public._prisma_migrations (id, checksum, finished_at, migration_name, logs, rolled_back_at, started_at, applied_steps_count) FROM stdin;
d9012f0b-4984-4699-9019-02425021f99f	87d3fbef34bac98543cbb9af8ba7d2eb7b265fe386f2ca28a0dbc838e114ad39	2025-09-16 05:13:33.700454+00	20250829163557_init	\N	\N	2025-09-16 05:13:33.638224+00	1
81ae864d-c559-47e9-b2b4-b39192ca1c75	66057b31d362fa3177284c7b7923b5f07fe0241fdc13e65c10730bc27352610c	2025-09-16 05:13:33.733873+00	20250830105605_update_model_name	\N	\N	2025-09-16 05:13:33.707156+00	1
b5b9f014-8f5f-4e6d-aa88-b022d2c18de8	cf0cf7f5f94b7b7c59d4645e056119ee2e37c12018e36e3d1b4c7a8de1568f8f	2025-09-16 05:13:33.778483+00	20250907092732_add_variant_seller_variant_models	\N	\N	2025-09-16 05:13:33.74075+00	1
b7a0a09b-bd2a-4f77-b230-aa12fe93aa90	d0af8d12d4ef29f853424daa1504e0de0af1cfc7a4f5644f22d9398b1ffcda6c	2025-09-16 05:14:57.936787+00	20250916051457_rename_variant_model_and_sellerid_field	\N	\N	2025-09-16 05:14:57.906148+00	1
558d6792-580d-4834-89a0-27b092d49804	2033110c807913907d256d25c34399659a298190a187bd0c86af415e3ed48312	2025-09-16 08:52:28.611568+00	20250916085228_add_unique_constraint_seller_variant	\N	\N	2025-09-16 08:52:28.59179+00	1
76e60ecb-4397-488b-b24e-1623279e6318	b10398894411c68cf3afb7521c29a4a4b34d2168e28fe8a48d5966ddb1f7b605	2025-09-21 14:11:27.666209+00	20250921141127_rename_field_variants_to_product_variants	\N	\N	2025-09-21 14:11:27.637549+00	1
\.


--
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: satyam
--

COPY public.categories (id, name, slug, description, "createdAt", "updatedAt") FROM stdin;
1	Electronics	electronics	\N	2025-09-16 05:13:34.768	2025-09-16 05:13:34.768
2	Fashion	fashion	\N	2025-09-16 05:13:34.768	2025-09-16 05:13:34.768
3	Home & Kitchen	home-and-kitchen	\N	2025-09-16 05:13:34.768	2025-09-16 05:13:34.768
\.


--
-- Data for Name: product_variants; Type: TABLE DATA; Schema: public; Owner: satyam
--

COPY public.product_variants (id, sku, "productId", attributes, "createdAt") FROM stdin;
1	IPH-8GB-256GB-BLU	1	{"ram": "8GB", "color": "Blue", "storage": "256GB"}	2025-09-16 08:22:33.74
2	IPH-8GB-128GB-RED	1	{"ram": "8GB", "color": "Red", "storage": "128GB"}	2025-09-16 08:23:06.501
3	NIKE-WHITE-XL	3	{"size": "XL", "color": "White"}	2025-09-16 08:24:19.905
4	NIKE-WHITE-SM	3	{"size": "Sm", "color": "White"}	2025-09-16 08:24:36.375
5	NIKE-Yellow-XXL	3	{"size": "XXL", "color": "White"}	2025-09-16 08:24:50.402
6	SMSNG-BLACK-8GB-128BG	2	{"ram": "8GB", "color": "Black", "storage": "128GB"}	2025-09-16 08:25:51.657
7	LWS-SHRT-XL-WHITE	5	{"size": "XL", "color": "White"}	2025-09-23 09:37:07.019
8	LWS-SHRT-XXL-RED	5	{"size": "XXL", "color": "Red"}	2025-09-23 09:37:29.788
\.


--
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: satyam
--

COPY public.products (id, name, description, "subcategoryId", "createdAt") FROM stdin;
1	iphone 17 pro	Everything just like the previous one, but with new colors and ads, obviously it's better than before because we are competing with ourselves but not the best in the market, buy me fool!!	1	2025-09-16 07:52:00.173
2	Samsung s20 ultra	Bullying Apple is my job and selling phones is my hobby, get your new knife like smartphone	1	2025-09-16 07:53:23.653
3	Nike T-shirt	Light, comfy, cotton, soft, can be used as sweater, raincoat or underwear	5	2025-09-16 07:56:08.297
5	Lewis Shirt	Pay for me because you can	5	2025-09-23 09:35:22.81
\.


--
-- Data for Name: refresh_tokens; Type: TABLE DATA; Schema: public; Owner: satyam
--

COPY public.refresh_tokens (id, token, "userId", "userAgent", ip, "expiresAt", "createdAt") FROM stdin;
1	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJwYXlsb2FkIjp7ImlkIjoxLCJlbWFpbCI6InN1bmlsQGV4YW1wbGUuY29tIiwicm9sZSI6IkJVWUVSIn0sImlhdCI6MTc1ODAwODgwNCwiZXhwIjoxNzU4NjEzNjA0fQ.j7nL_-9FuuWlHBvxbPaJhqwkEj-q66QSPWmuqKfm_no	1	PostmanRuntime/7.46.0	::1	2025-09-23 07:46:44.968	2025-09-16 07:46:44.969
2	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJwYXlsb2FkIjp7ImlkIjoxLCJlbWFpbCI6InN1bmlsQGV4YW1wbGUuY29tIiwicm9sZSI6IlNFTExFUiJ9LCJpYXQiOjE3NTgwMTA5MzAsImV4cCI6MTc1ODYxNTczMH0.XRfSg49lMbVNwmuam8HPrpc2MekyMfT9rHhvcZwy4Ak	1	PostmanRuntime/7.46.0	::1	2025-09-23 08:22:10.533	2025-09-16 08:22:10.536
3	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJwYXlsb2FkIjp7ImlkIjoxLCJlbWFpbCI6InN1bmlsQGV4YW1wbGUuY29tIiwicm9sZSI6IlNFTExFUiJ9LCJpYXQiOjE3NTgwMTE4NTYsImV4cCI6MTc1ODYxNjY1Nn0.Hhw8aRTOzLv_TgSqFSR2uYKi_iu4OsXMKySdL6_ly9c	1	PostmanRuntime/7.46.0	::1	2025-09-23 08:37:36.131	2025-09-16 08:37:36.132
4	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJwYXlsb2FkIjp7ImlkIjoxLCJlbWFpbCI6InN1bmlsQGV4YW1wbGUuY29tIiwicm9sZSI6IlNFTExFUiJ9LCJpYXQiOjE3NTgwMTI4MjUsImV4cCI6MTc1ODYxNzYyNX0.UsNoB5dyVBl2Z-N0VRE1JIyIrfShYQFVJI0lhhOXEzQ	1	PostmanRuntime/7.46.0	::1	2025-09-23 08:53:45.35	2025-09-16 08:53:45.354
5	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJwYXlsb2FkIjp7ImlkIjoyLCJlbWFpbCI6InNhdHlhbUBleGFtcGxlLmNvbSIsInJvbGUiOiJCVVlFUiJ9LCJpYXQiOjE3NTgyOTEzMzEsImV4cCI6MTc1ODg5NjEzMX0.y0YB2dfXMCNHE6OV9oHeFdXedBjoYbnQJAofcjilIjE	2	curl/8.13.0	::1	2025-09-26 14:15:31.412	2025-09-19 14:15:31.426
6	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJwYXlsb2FkIjp7ImlkIjoyLCJlbWFpbCI6InNhdHlhbUBleGFtcGxlLmNvbSIsInJvbGUiOiJCVVlFUiJ9LCJpYXQiOjE3NTgyOTE2OTIsImV4cCI6MTc1ODg5NjQ5Mn0.xEVvacy8HYXkyxIdts5pNveVuavIHVQxjNlAZMAzFsI	2	curl/8.13.0	::1	2025-09-26 14:21:32.067	2025-09-19 14:21:32.074
7	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJwYXlsb2FkIjp7ImlkIjoyLCJlbWFpbCI6InNhdHlhbUBleGFtcGxlLmNvbSIsInJvbGUiOiJTRUxMRVIifSwiaWF0IjoxNzU4MjkyNjgxLCJleHAiOjE3NTg4OTc0ODF9.ILCEDP1FQgQfNBu6u3m4pHxFEG01lGnYBdxlx14no24	2	curl/8.13.0	::1	2025-09-26 14:38:01.529	2025-09-19 14:38:01.539
8	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJwYXlsb2FkIjp7ImlkIjoxLCJlbWFpbCI6InN1bmlsQGV4YW1wbGUuY29tIiwicm9sZSI6IlNFTExFUiJ9LCJpYXQiOjE3NTgzNDQyNjEsImV4cCI6MTc1ODk0OTA2MX0.BWTwkIwC3E1878CDSYZG7zOXltl5yaA_30mvuQb4VBI	1	PostmanRuntime/7.46.1	::1	2025-09-27 04:57:41.539	2025-09-20 04:57:41.554
9	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJwYXlsb2FkIjp7ImlkIjoxLCJlbWFpbCI6InN1bmlsQGV4YW1wbGUuY29tIiwicm9sZSI6IlNFTExFUiJ9LCJpYXQiOjE3NTgzNDc2NTcsImV4cCI6MTc1ODk1MjQ1N30.MpcPwQ62dxTTJVZHqa51NaBuHfQZv91JGcZ5yUxjjvA	1	PostmanRuntime/7.46.1	::1	2025-09-27 05:54:17.473	2025-09-20 05:54:17.487
10	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJwYXlsb2FkIjp7ImlkIjoxLCJlbWFpbCI6InN1bmlsQGV4YW1wbGUuY29tIiwicm9sZSI6IlNFTExFUiJ9LCJpYXQiOjE3NTgzNTY5NTIsImV4cCI6MTc1ODk2MTc1Mn0.QooUJLDECPuNTu3ndxzjfvOUBGjnC6iInJzyOKM07DY	1	PostmanRuntime/7.46.1	::1	2025-09-27 08:29:12.399	2025-09-20 08:29:12.407
11	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJwYXlsb2FkIjp7ImlkIjoxLCJlbWFpbCI6InN1bmlsQGV4YW1wbGUuY29tIiwicm9sZSI6IlNFTExFUiJ9LCJpYXQiOjE3NTgzNTc4NzksImV4cCI6MTc1ODk2MjY3OX0.TBtInUWZMQI_FN4AcWb68xhsuWZwHvqXmZLtAgXLr-E	1	PostmanRuntime/7.46.1	::1	2025-09-27 08:44:39.908	2025-09-20 08:44:39.913
12	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJwYXlsb2FkIjp7ImlkIjoxLCJlbWFpbCI6InN1bmlsQGV4YW1wbGUuY29tIiwicm9sZSI6IlNFTExFUiJ9LCJpYXQiOjE3NTgzNTg4NTAsImV4cCI6MTc1ODk2MzY1MH0.6T24d7VJJW_08T3EofTXDm9ztK1eb36a5KUqpVvNwR4	1	PostmanRuntime/7.46.1	::1	2025-09-27 09:00:50.256	2025-09-20 09:00:50.266
13	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJwYXlsb2FkIjp7ImlkIjoxLCJlbWFpbCI6InN1bmlsQGV4YW1wbGUuY29tIiwicm9sZSI6IlNFTExFUiJ9LCJpYXQiOjE3NTgzNzIyMzcsImV4cCI6MTc1ODk3NzAzN30.YD0pRy94M-VUXP__LlqUCiT1qQNFY5oAn8KY7i_hm0k	1	PostmanRuntime/7.46.1	::1	2025-09-27 12:43:57.088	2025-09-20 12:43:57.09
14	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJwYXlsb2FkIjp7ImlkIjoxLCJlbWFpbCI6InN1bmlsQGV4YW1wbGUuY29tIiwicm9sZSI6IlNFTExFUiJ9LCJpYXQiOjE3NTgzNzMyODUsImV4cCI6MTc1ODk3ODA4NX0.oxSiUf7ZiZLkGV9oM3IUjTBxJW493_Z-gFBwdmOO5QM	1	PostmanRuntime/7.46.1	::1	2025-09-27 13:01:25.396	2025-09-20 13:01:25.407
15	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJwYXlsb2FkIjp7ImlkIjoxLCJlbWFpbCI6InN1bmlsQGV4YW1wbGUuY29tIiwicm9sZSI6IlNFTExFUiJ9LCJpYXQiOjE3NTgzODE3MDIsImV4cCI6MTc1ODk4NjUwMn0.ZcMvqEQbyPq1OnARV_9pC72PRBGSm58IBIOFVHqxrgI	1	PostmanRuntime/7.46.1	::1	2025-09-27 15:21:42.136	2025-09-20 15:21:42.143
16	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJwYXlsb2FkIjp7ImlkIjoxLCJlbWFpbCI6InN1bmlsQGV4YW1wbGUuY29tIiwicm9sZSI6IlNFTExFUiJ9LCJpYXQiOjE3NTgzODI4NDAsImV4cCI6MTc1ODk4NzY0MH0.j0mmQ0S9iZ23F7Oa7zSMe12hN1IYqBdv3cNd1kAv_Yw	1	PostmanRuntime/7.46.1	::1	2025-09-27 15:40:40.822	2025-09-20 15:40:40.832
17	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJwYXlsb2FkIjp7ImlkIjoxLCJlbWFpbCI6InN1bmlsQGV4YW1wbGUuY29tIiwicm9sZSI6IlNFTExFUiJ9LCJpYXQiOjE3NTg0NTgyNzUsImV4cCI6MTc1OTA2MzA3NX0.sc_uHAzM1tRqvMnPfzGWjdsMB_1nsGhJ4jFS-kKOkd0	1	PostmanRuntime/7.46.1	::1	2025-09-28 12:37:55.072	2025-09-21 12:37:55.098
18	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJwYXlsb2FkIjp7ImlkIjoxLCJlbWFpbCI6InN1bmlsQGV4YW1wbGUuY29tIiwicm9sZSI6IlNFTExFUiJ9LCJpYXQiOjE3NTg0Njg5MTMsImV4cCI6MTc1OTA3MzcxM30.2txLELeJzhLqJwh1YEkLyrfcLjnb816aeOYdqs5PXEo	1	PostmanRuntime/7.46.1	::1	2025-09-28 15:35:13.894	2025-09-21 15:35:13.911
19	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJwYXlsb2FkIjp7ImlkIjoxLCJlbWFpbCI6InN1bmlsQGV4YW1wbGUuY29tIiwicm9sZSI6IlNFTExFUiJ9LCJpYXQiOjE3NTg0NzEyMjEsImV4cCI6MTc1OTA3NjAyMX0.rbSTAVgWLYihWe9e2KqGA3b-aSw6Fz2-vSpAkXn8QYQ	1	PostmanRuntime/7.46.1	::1	2025-09-28 16:13:41.621	2025-09-21 16:13:41.636
20	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJwYXlsb2FkIjp7ImlkIjoxLCJlbWFpbCI6InN1bmlsQGV4YW1wbGUuY29tIiwicm9sZSI6IlNFTExFUiJ9LCJpYXQiOjE3NTg1MDk2NTMsImV4cCI6MTc1OTExNDQ1M30.3x4_L7JbXk8GM6dcA1RexFBcx1NG4Fg6wKYvSGCLD2Y	1	PostmanRuntime/7.46.1	::1	2025-09-29 02:54:13.155	2025-09-22 02:54:13.171
21	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJwYXlsb2FkIjp7ImlkIjoxLCJlbWFpbCI6InN1bmlsQGV4YW1wbGUuY29tIiwicm9sZSI6IlNFTExFUiJ9LCJpYXQiOjE3NTg1Mjg5NDksImV4cCI6MTc1OTEzMzc0OX0.YradpPwgH0BSP40r44Y774isihNxp80OAsX0vEUkCSc	1	PostmanRuntime/7.46.1	::1	2025-09-29 08:15:49.447	2025-09-22 08:15:49.449
22	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJwYXlsb2FkIjp7ImlkIjoxLCJlbWFpbCI6InN1bmlsQGV4YW1wbGUuY29tIiwicm9sZSI6IlNFTExFUiJ9LCJpYXQiOjE3NTg1MzE5MzgsImV4cCI6MTc1OTEzNjczOH0.D1HXB1aJPE15aDNIs3eeYqqKiE034VphP3OnkNTXDwE	1	PostmanRuntime/7.47.1	::1	2025-09-29 09:05:38.356	2025-09-22 09:05:38.38
23	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJwYXlsb2FkIjp7ImlkIjoxLCJlbWFpbCI6InN1bmlsQGV4YW1wbGUuY29tIiwicm9sZSI6IlNFTExFUiJ9LCJpYXQiOjE3NTg1MzMwMTEsImV4cCI6MTc1OTEzNzgxMX0.M2RSRm1yWZ3BQGm6tkQVvuBLF-sB5NKZyL8sUjHDpJM	1	PostmanRuntime/7.47.1	::1	2025-09-29 09:23:31.283	2025-09-22 09:23:31.29
24	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJwYXlsb2FkIjp7ImlkIjoxLCJlbWFpbCI6InN1bmlsQGV4YW1wbGUuY29tIiwicm9sZSI6IlNFTExFUiJ9LCJpYXQiOjE3NTg2MDM2NDQsImV4cCI6MTc1OTIwODQ0NH0.J0-aK6oZxiU0c3BjqHj2IkKFYxU-CJaprPxQcyveB6U	1	PostmanRuntime/7.47.1	::1	2025-09-30 05:00:44.068	2025-09-23 05:00:44.084
25	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJwYXlsb2FkIjp7ImlkIjoxLCJlbWFpbCI6InN1bmlsQGV4YW1wbGUuY29tIiwicm9sZSI6IlNFTExFUiJ9LCJpYXQiOjE3NTg2MDg3MzUsImV4cCI6MTc1OTIxMzUzNX0.0OTOTAQyY_xJT2yf1tCLuV-FJm_Vj-7hbCYIYi7YGJI	1	PostmanRuntime/7.47.1	::1	2025-09-30 06:25:35.374	2025-09-23 06:25:35.377
26	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJwYXlsb2FkIjp7ImlkIjozLCJlbWFpbCI6InJha2VzaEBleGFtcGxlLmNvbSIsInJvbGUiOiJCVVlFUiJ9LCJpYXQiOjE3NTg2MDk5ODcsImV4cCI6MTc1OTIxNDc4N30.dEF51rk_tgOMO_WPduqR_Fc1M2XijJKdmcj5DVQjnZk	3	PostmanRuntime/7.47.1	::1	2025-09-30 06:46:27.057	2025-09-23 06:46:27.06
27	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJwYXlsb2FkIjp7ImlkIjozLCJlbWFpbCI6InJha2VzaEBleGFtcGxlLmNvbSIsInJvbGUiOiJTRUxMRVIifSwiaWF0IjoxNzU4NjExNjA4LCJleHAiOjE3NTkyMTY0MDh9.h7nNLXgfspkX7cJZ6tBELXGREkNtGzjZldwheE5h2FU	3	PostmanRuntime/7.47.1	::1	2025-09-30 07:13:28.759	2025-09-23 07:13:28.766
28	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJwYXlsb2FkIjp7ImlkIjozLCJlbWFpbCI6InJha2VzaEBleGFtcGxlLmNvbSIsInJvbGUiOiJTRUxMRVIifSwiaWF0IjoxNzU4NjE5NzU1LCJleHAiOjE3NTkyMjQ1NTV9.TfC3Jp3iDExNNhaCIIOFnns1-in8SxRbphRo-1aiHcM	3	PostmanRuntime/7.47.1	::1	2025-09-30 09:29:15.844	2025-09-23 09:29:15.85
29	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJwYXlsb2FkIjp7ImlkIjozLCJlbWFpbCI6InJha2VzaEBleGFtcGxlLmNvbSIsInJvbGUiOiJTRUxMRVIifSwiaWF0IjoxNzU4NjIxNzYyLCJleHAiOjE3NTkyMjY1NjJ9.idCdqCK0HxrjWAtOEZyY915FY6ceDq2RC6YA4OprY9E	3	PostmanRuntime/7.47.1	::1	2025-09-30 10:02:42.152	2025-09-23 10:02:42.163
30	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJwYXlsb2FkIjp7ImlkIjozLCJlbWFpbCI6InJha2VzaEBleGFtcGxlLmNvbSIsInJvbGUiOiJTRUxMRVIifSwiaWF0IjoxNzU4Njg4ODQyLCJleHAiOjE3NTkyOTM2NDJ9.RHm0adoq73jrpmBvY7cu8X2Sfz9N4h-jUffR0B5qAAg	3	PostmanRuntime/7.47.1	::1	2025-10-01 04:40:42.59	2025-09-24 04:40:42.603
31	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJwYXlsb2FkIjp7ImlkIjozLCJlbWFpbCI6InJha2VzaEBleGFtcGxlLmNvbSIsInJvbGUiOiJTRUxMRVIifSwiaWF0IjoxNzU5Mzc5NTg3LCJleHAiOjE3NTk5ODQzODd9.2f1mz2wJEYXSfMbps-KZCmw21Gl_nyvdd4HINXqXpXM	3	PostmanRuntime/7.47.1	::1	2025-10-09 04:33:07.93	2025-10-02 04:33:07.932
32	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJwYXlsb2FkIjp7ImlkIjozLCJlbWFpbCI6InJha2VzaEBleGFtcGxlLmNvbSIsInJvbGUiOiJTRUxMRVIifSwiaWF0IjoxNzU5MzgwNTY4LCJleHAiOjE3NTk5ODUzNjh9.Kx5tAXnHJv84USgO_HcOzFRj2iHsYP8XVariGDvddHo	3	PostmanRuntime/7.47.1	::1	2025-10-09 04:49:28.256	2025-10-02 04:49:28.258
33	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJwYXlsb2FkIjp7ImlkIjozLCJlbWFpbCI6InJha2VzaEBleGFtcGxlLmNvbSIsInJvbGUiOiJTRUxMRVIifSwiaWF0IjoxNzU5MzgxODcxLCJleHAiOjE3NTk5ODY2NzF9.R1ZqZBFb0fz8hqggmZME5Qcj23JQaZ6WY_u_mDdR3oU	3	PostmanRuntime/7.47.1	::1	2025-10-09 05:11:11.033	2025-10-02 05:11:11.036
34	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJwYXlsb2FkIjp7ImlkIjozLCJlbWFpbCI6InJha2VzaEBleGFtcGxlLmNvbSIsInJvbGUiOiJTRUxMRVIifSwiaWF0IjoxNzU5MzgyNzgzLCJleHAiOjE3NTk5ODc1ODN9.i2Nw9yWDql5TLqu_kHHIXd8YDzUV81bMcvSK9pCUf9o	3	PostmanRuntime/7.47.1	::1	2025-10-09 05:26:23.806	2025-10-02 05:26:23.808
35	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJwYXlsb2FkIjp7ImlkIjozLCJlbWFpbCI6InJha2VzaEBleGFtcGxlLmNvbSIsInJvbGUiOiJTRUxMRVIifSwiaWF0IjoxNzU5MzgzNzA5LCJleHAiOjE3NTk5ODg1MDl9.AHu5vyRlEebfkjP6MT2KWG1aYkFskDgcFTjXuI6CnhE	3	PostmanRuntime/7.47.1	::1	2025-10-09 05:41:49.155	2025-10-02 05:41:49.156
36	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJwYXlsb2FkIjp7ImlkIjozLCJlbWFpbCI6InJha2VzaEBleGFtcGxlLmNvbSIsInJvbGUiOiJTRUxMRVIifSwiaWF0IjoxNzU5Mzg0ODA5LCJleHAiOjE3NTk5ODk2MDl9.HbEhU1faJlaXEublleYxnfjBvX3vrnPs8FNiFP1ZT2k	3	PostmanRuntime/7.47.1	::1	2025-10-09 06:00:09.156	2025-10-02 06:00:09.157
37	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJwYXlsb2FkIjp7ImlkIjozLCJlbWFpbCI6InJha2VzaEBleGFtcGxlLmNvbSIsInJvbGUiOiJTRUxMRVIifSwiaWF0IjoxNzU5NTc5OTc0LCJleHAiOjE3NjAxODQ3NzR9.EmKfb18rbpBkmccuTG8HqmDDrJZ6ksI6tT3ecELoekg	3	PostmanRuntime/7.48.0	::1	2025-10-11 12:12:54.178	2025-10-04 12:12:54.18
38	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJwYXlsb2FkIjp7ImlkIjozLCJlbWFpbCI6InJha2VzaEBleGFtcGxlLmNvbSIsInJvbGUiOiJTRUxMRVIifSwiaWF0IjoxNzU5NjUwNzM3LCJleHAiOjE3NjAyNTU1Mzd9.OS37PwP_s9DfiCF0v8hoGUot8BeyvSfK56-eezuhLRI	3	PostmanRuntime/7.48.0	::1	2025-10-12 07:52:17.77	2025-10-05 07:52:17.773
39	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJwYXlsb2FkIjp7ImlkIjozLCJlbWFpbCI6InJha2VzaEBleGFtcGxlLmNvbSIsInJvbGUiOiJTRUxMRVIifSwiaWF0IjoxNzU5NjUxMjk0LCJleHAiOjE3NjAyNTYwOTR9.3qCtOjl2PSf5yT_S-LDGg214vM4V0qUCxxiRygRdNGo	3	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36	::1	2025-10-12 08:01:34.367	2025-10-05 08:01:34.37
40	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJwYXlsb2FkIjp7ImlkIjozLCJlbWFpbCI6InJha2VzaEBleGFtcGxlLmNvbSIsInJvbGUiOiJTRUxMRVIifSwiaWF0IjoxNzU5NzIwMjA5LCJleHAiOjE3NjAzMjUwMDl9.Egt4S25DzT2_lJdZO1vPI86MH2gsql6NuWUM_pwSn20	3	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36	::1	2025-10-13 03:10:09.104	2025-10-06 03:10:09.107
41	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJwYXlsb2FkIjp7ImlkIjozLCJlbWFpbCI6InJha2VzaEBleGFtcGxlLmNvbSIsInJvbGUiOiJTRUxMRVIifSwiaWF0IjoxNzU5NzIwNDIzLCJleHAiOjE3NjAzMjUyMjN9.h74iB732Q6_gVoonTX2kOejHozILR0kSUNcec1EZO9w	3	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36	::1	2025-10-13 03:13:43.221	2025-10-06 03:13:43.222
42	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJwYXlsb2FkIjp7ImlkIjozLCJlbWFpbCI6InJha2VzaEBleGFtcGxlLmNvbSIsInJvbGUiOiJTRUxMRVIifSwiaWF0IjoxNzU5NzIwNzQ5LCJleHAiOjE3NjAzMjU1NDl9.yo2Krv_RUe1CHxIIrUIQI6YcJuptBf48UgizLwsI1cQ	3	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36	::1	2025-10-13 03:19:09.354	2025-10-06 03:19:09.363
43	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJwYXlsb2FkIjp7ImlkIjozLCJlbWFpbCI6InJha2VzaEBleGFtcGxlLmNvbSIsInJvbGUiOiJTRUxMRVIifSwiaWF0IjoxNzU5NzIwNzgwLCJleHAiOjE3NjAzMjU1ODB9.M4VvUvNRyKyxv_hv5KxYtr7KlBawqr2ff7jmH08GPQ8	3	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36	::1	2025-10-13 03:19:40.766	2025-10-06 03:19:40.774
44	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJwYXlsb2FkIjp7ImlkIjozLCJlbWFpbCI6InJha2VzaEBleGFtcGxlLmNvbSIsInJvbGUiOiJTRUxMRVIifSwiaWF0IjoxNzU5NzIwOTM4LCJleHAiOjE3NjAzMjU3Mzh9.9aeI3Fwhy9UGrS1B34R3Drz34CcncM5-yL6rEXuYWGM	3	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36	::1	2025-10-13 03:22:18.959	2025-10-06 03:22:18.966
45	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJwYXlsb2FkIjp7ImlkIjozLCJlbWFpbCI6InJha2VzaEBleGFtcGxlLmNvbSIsInJvbGUiOiJTRUxMRVIifSwiaWF0IjoxNzU5NzIxMjMxLCJleHAiOjE3NjAzMjYwMzF9.MUuKpvpFeRtBGU6aEtU_fvXaD7HE0x53M_v6lgaqnjw	3	PostmanRuntime/7.48.0	::1	2025-10-13 03:27:11.072	2025-10-06 03:27:11.077
46	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJwYXlsb2FkIjp7ImlkIjozLCJlbWFpbCI6InJha2VzaEBleGFtcGxlLmNvbSIsInJvbGUiOiJTRUxMRVIifSwiaWF0IjoxNzU5NzIxNDg3LCJleHAiOjE3NjAzMjYyODd9.j8HZIH_Qqm7ZEE9aT0jaojeaUrvWpE2ilcX0k5WbIXs	3	Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Mobile Safari/537.36	::1	2025-10-13 03:31:27.827	2025-10-06 03:31:27.831
47	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJwYXlsb2FkIjp7ImlkIjozLCJlbWFpbCI6InJha2VzaEBleGFtcGxlLmNvbSIsInJvbGUiOiJTRUxMRVIifSwiaWF0IjoxNzU5NzIzMDQ4LCJleHAiOjE3NjAzMjc4NDh9.eQ64viumxc9RIYGJFKwzBijW4w5DiLo_fOQDu0kr5p4	3	Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Mobile Safari/537.36	::1	2025-10-13 03:57:28.597	2025-10-06 03:57:28.604
48	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJwYXlsb2FkIjp7ImlkIjozLCJlbWFpbCI6InJha2VzaEBleGFtcGxlLmNvbSIsInJvbGUiOiJTRUxMRVIifSwiaWF0IjoxNzU5NzIzMTAxLCJleHAiOjE3NjAzMjc5MDF9.0twEarcktRw9K1ncphaACd7NAVHglnS2uccEaEJm7qc	3	Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Mobile Safari/537.36	::1	2025-10-13 03:58:21.628	2025-10-06 03:58:21.635
49	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJwYXlsb2FkIjp7ImlkIjozLCJlbWFpbCI6InJha2VzaEBleGFtcGxlLmNvbSIsInJvbGUiOiJTRUxMRVIifSwiaWF0IjoxNzU5NzQyOTY0LCJleHAiOjE3NjAzNDc3NjR9.7EpzAGrCFVg9m6ETJEAmaSZFRtuvScg3L8yNkYXEN1o	3	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36	::1	2025-10-13 09:29:24.568	2025-10-06 09:29:24.573
50	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJwYXlsb2FkIjp7ImlkIjozLCJlbWFpbCI6InJha2VzaEBleGFtcGxlLmNvbSIsInJvbGUiOiJTRUxMRVIifSwiaWF0IjoxNzU5NzQzMzc5LCJleHAiOjE3NjAzNDgxNzl9.AZuzAu745w68GJHDxaN5p-bglfSM5WxwhMH21K7ixVY	3	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36	::1	2025-10-13 09:36:19.347	2025-10-06 09:36:19.349
51	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJwYXlsb2FkIjp7ImlkIjozLCJlbWFpbCI6InJha2VzaEBleGFtcGxlLmNvbSIsInJvbGUiOiJTRUxMRVIifSwiaWF0IjoxNzYwMDY0MDcxLCJleHAiOjE3NjA2Njg4NzF9.TPFSVSo-fX-RaU2OyxVP00wVix6p9ugDOwAH62SxUqw	3	PostmanRuntime/7.48.0	::1	2025-10-17 02:41:11.077	2025-10-10 02:41:11.091
52	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJwYXlsb2FkIjp7ImlkIjozLCJlbWFpbCI6InJha2VzaEBleGFtcGxlLmNvbSIsInJvbGUiOiJTRUxMRVIifSwiaWF0IjoxNzYwMDc3MzQ1LCJleHAiOjE3NjA2ODIxNDV9.rPzy-O-GsyR-icoCQTbjzENqIbyjEjgYNcWsmoa5Gmo	3	PostmanRuntime/7.48.0	::1	2025-10-17 06:22:25.49	2025-10-10 06:22:25.494
\.


--
-- Data for Name: seller_variants; Type: TABLE DATA; Schema: public; Owner: satyam
--

COPY public.seller_variants (id, "sellerId", price, stock, "createdAt", "productVariantId") FROM stdin;
1	10b63b22-f131-441d-afa6-ce86d3610473	3299	20	2025-09-16 08:53:51.093	1
3	10b63b22-f131-441d-afa6-ce86d3610473	149	153	2025-09-20 15:21:44.664	3
4	10b63b22-f131-441d-afa6-ce86d3610473	2549.75	120	2025-09-20 15:23:59.013	2
5	10b63b22-f131-441d-afa6-ce86d3610473	1399	223	2025-09-20 15:24:57.826	6
6	10b63b22-f131-441d-afa6-ce86d3610473	99.2	330	2025-09-20 15:25:43.097	4
8	8fbdad1d-8e25-4861-9398-2e8c339f0ba2	549.45	103	2025-09-23 09:38:46.25	7
9	8fbdad1d-8e25-4861-9398-2e8c339f0ba2	599	117	2025-09-23 09:39:10.548	8
7	8fbdad1d-8e25-4861-9398-2e8c339f0ba2	129	102	2025-09-23 06:48:31.067	3
\.


--
-- Data for Name: sellers; Type: TABLE DATA; Schema: public; Owner: satyam
--

COPY public.sellers (id, "pickupAddress", "businessName", "gstNumber", "bankInfo", "userId", "sellerRating") FROM stdin;
10b63b22-f131-441d-afa6-ce86d3610473	Lucknow, Uttar Pradesh	Satyam Agency	29ABCDE1234F2Z5	FSSAI1234, ICICI- UP	1	0
8fbdad1d-8e25-4861-9398-2e8c339f0ba2	Lucknow, Uttar Pradesh	Rakesh Ent.	29ABCDE1234F2Z5	FSSAI1234, ICICI- UP	3	0
\.


--
-- Data for Name: subcategories; Type: TABLE DATA; Schema: public; Owner: satyam
--

COPY public.subcategories (id, name, slug, description, "categoryId", "createdAt", "updatedAt") FROM stdin;
1	Mobiles	mobiles	\N	1	2025-09-16 05:13:34.768	2025-09-16 05:13:34.768
2	Laptops	laptops	\N	1	2025-09-16 05:13:34.768	2025-09-16 05:13:34.768
3	Tablets	tablets	\N	1	2025-09-16 05:13:34.768	2025-09-16 05:13:34.768
4	Cameras	cameras	\N	1	2025-09-16 05:13:34.768	2025-09-16 05:13:34.768
5	Men	men	\N	2	2025-09-16 05:13:34.768	2025-09-16 05:13:34.768
6	Women	women	\N	2	2025-09-16 05:13:34.768	2025-09-16 05:13:34.768
7	Kids	kids	\N	2	2025-09-16 05:13:34.768	2025-09-16 05:13:34.768
8	Accessories	accessories	\N	2	2025-09-16 05:13:34.768	2025-09-16 05:13:34.768
9	Furniture	furniture	\N	3	2025-09-16 05:13:34.768	2025-09-16 05:13:34.768
10	Appliances	appliances	\N	3	2025-09-16 05:13:34.768	2025-09-16 05:13:34.768
11	Decor	decor	\N	3	2025-09-16 05:13:34.768	2025-09-16 05:13:34.768
12	Cookware	cookware	\N	3	2025-09-16 05:13:34.768	2025-09-16 05:13:34.768
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: satyam
--

COPY public.users (id, "fullName", email, password, phone, address, role, "createdAt", "updatedAt") FROM stdin;
1	sunil	sunil@example.com	$argon2id$v=19$m=65536,t=3,p=4$flYhybn8rIUPvl5D14jzCg$60ANcawALO0BR6/Y4BVo0lkD+crz9Az/vK5M4iOqKGs	9324266661	home no. 2020202	SELLER	2025-09-16 07:45:50.553	2025-09-16 07:49:13.144
2	Satyam Mishra	satyam@example.com	$argon2id$v=19$m=65536,t=3,p=4$ci9FP6uOsQGXdnxkj23rTg$BaPx0tmd8cwsyjgy6alTA1lX7fj0+Fr42H6xRv9SaoE	8108805694	Jiyapur, Sant Ravidas Nagar, 421302	SELLER	2025-09-19 14:13:54.917	2025-09-19 14:38:08.6
3	rakesh	rakesh@example.com	$argon2id$v=19$m=65536,t=3,p=4$cEMHK+d5xmn1nDjeof6/9Q$P9jmP5R0ZrI4T2hmxC2jpzhl8el1SqLg4Dtl7Ewqta8	7754866072	home no. 2020202	SELLER	2025-09-23 06:45:26.428	2025-09-23 06:46:43.179
\.


--
-- Name: categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: satyam
--

SELECT pg_catalog.setval('public.categories_id_seq', 4, true);


--
-- Name: product_variants_id_seq; Type: SEQUENCE SET; Schema: public; Owner: satyam
--

SELECT pg_catalog.setval('public.product_variants_id_seq', 8, true);


--
-- Name: products_id_seq; Type: SEQUENCE SET; Schema: public; Owner: satyam
--

SELECT pg_catalog.setval('public.products_id_seq', 5, true);


--
-- Name: refresh_tokens_id_seq; Type: SEQUENCE SET; Schema: public; Owner: satyam
--

SELECT pg_catalog.setval('public.refresh_tokens_id_seq', 52, true);


--
-- Name: seller_variants_id_seq; Type: SEQUENCE SET; Schema: public; Owner: satyam
--

SELECT pg_catalog.setval('public.seller_variants_id_seq', 9, true);


--
-- Name: subcategories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: satyam
--

SELECT pg_catalog.setval('public.subcategories_id_seq', 12, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: satyam
--

SELECT pg_catalog.setval('public.users_id_seq', 3, true);


--
-- Name: _prisma_migrations _prisma_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: satyam
--

ALTER TABLE ONLY public._prisma_migrations
    ADD CONSTRAINT _prisma_migrations_pkey PRIMARY KEY (id);


--
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: public; Owner: satyam
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);


--
-- Name: product_variants product_variants_pkey; Type: CONSTRAINT; Schema: public; Owner: satyam
--

ALTER TABLE ONLY public.product_variants
    ADD CONSTRAINT product_variants_pkey PRIMARY KEY (id);


--
-- Name: products products_pkey; Type: CONSTRAINT; Schema: public; Owner: satyam
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (id);


--
-- Name: refresh_tokens refresh_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: satyam
--

ALTER TABLE ONLY public.refresh_tokens
    ADD CONSTRAINT refresh_tokens_pkey PRIMARY KEY (id);


--
-- Name: seller_variants seller_variants_pkey; Type: CONSTRAINT; Schema: public; Owner: satyam
--

ALTER TABLE ONLY public.seller_variants
    ADD CONSTRAINT seller_variants_pkey PRIMARY KEY (id);


--
-- Name: sellers sellers_pkey; Type: CONSTRAINT; Schema: public; Owner: satyam
--

ALTER TABLE ONLY public.sellers
    ADD CONSTRAINT sellers_pkey PRIMARY KEY (id);


--
-- Name: subcategories subcategories_pkey; Type: CONSTRAINT; Schema: public; Owner: satyam
--

ALTER TABLE ONLY public.subcategories
    ADD CONSTRAINT subcategories_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: satyam
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: categories_name_key; Type: INDEX; Schema: public; Owner: satyam
--

CREATE UNIQUE INDEX categories_name_key ON public.categories USING btree (name);


--
-- Name: categories_slug_key; Type: INDEX; Schema: public; Owner: satyam
--

CREATE UNIQUE INDEX categories_slug_key ON public.categories USING btree (slug);


--
-- Name: product_variants_sku_key; Type: INDEX; Schema: public; Owner: satyam
--

CREATE UNIQUE INDEX product_variants_sku_key ON public.product_variants USING btree (sku);


--
-- Name: seller_variants_productVariantId_sellerId_key; Type: INDEX; Schema: public; Owner: satyam
--

CREATE UNIQUE INDEX "seller_variants_productVariantId_sellerId_key" ON public.seller_variants USING btree ("productVariantId", "sellerId");


--
-- Name: sellers_userId_key; Type: INDEX; Schema: public; Owner: satyam
--

CREATE UNIQUE INDEX "sellers_userId_key" ON public.sellers USING btree ("userId");


--
-- Name: subcategories_name_key; Type: INDEX; Schema: public; Owner: satyam
--

CREATE UNIQUE INDEX subcategories_name_key ON public.subcategories USING btree (name);


--
-- Name: subcategories_slug_key; Type: INDEX; Schema: public; Owner: satyam
--

CREATE UNIQUE INDEX subcategories_slug_key ON public.subcategories USING btree (slug);


--
-- Name: users_email_key; Type: INDEX; Schema: public; Owner: satyam
--

CREATE UNIQUE INDEX users_email_key ON public.users USING btree (email);


--
-- Name: users_phone_key; Type: INDEX; Schema: public; Owner: satyam
--

CREATE UNIQUE INDEX users_phone_key ON public.users USING btree (phone);


--
-- Name: product_variants product_variants_productId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: satyam
--

ALTER TABLE ONLY public.product_variants
    ADD CONSTRAINT "product_variants_productId_fkey" FOREIGN KEY ("productId") REFERENCES public.products(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: products products_subcategoryId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: satyam
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT "products_subcategoryId_fkey" FOREIGN KEY ("subcategoryId") REFERENCES public.subcategories(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: refresh_tokens refresh_tokens_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: satyam
--

ALTER TABLE ONLY public.refresh_tokens
    ADD CONSTRAINT "refresh_tokens_userId_fkey" FOREIGN KEY ("userId") REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: seller_variants seller_variants_productVariantId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: satyam
--

ALTER TABLE ONLY public.seller_variants
    ADD CONSTRAINT "seller_variants_productVariantId_fkey" FOREIGN KEY ("productVariantId") REFERENCES public.product_variants(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: seller_variants seller_variants_sellerId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: satyam
--

ALTER TABLE ONLY public.seller_variants
    ADD CONSTRAINT "seller_variants_sellerId_fkey" FOREIGN KEY ("sellerId") REFERENCES public.sellers(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: sellers sellers_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: satyam
--

ALTER TABLE ONLY public.sellers
    ADD CONSTRAINT "sellers_userId_fkey" FOREIGN KEY ("userId") REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: subcategories subcategories_categoryId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: satyam
--

ALTER TABLE ONLY public.subcategories
    ADD CONSTRAINT "subcategories_categoryId_fkey" FOREIGN KEY ("categoryId") REFERENCES public.categories(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: satyam
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;


--
-- PostgreSQL database dump complete
--

