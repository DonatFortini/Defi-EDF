--
-- PostgreSQL database dump
--

-- Dumped from database version 14.13
-- Dumped by pg_dump version 14.13

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
-- Name: defaut_releve; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.defaut_releve (
    id_releve integer NOT NULL,
    id_vehicule integer NOT NULL,
    id_defaut integer NOT NULL,
    date_releve timestamp without time zone NOT NULL,
    commentaire_libre text
);


ALTER TABLE public.defaut_releve OWNER TO postgres;

--
-- Name: defaut_releve_id_releve_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.defaut_releve_id_releve_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.defaut_releve_id_releve_seq OWNER TO postgres;

--
-- Name: defaut_releve_id_releve_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.defaut_releve_id_releve_seq OWNED BY public.defaut_releve.id_releve;


--
-- Name: destination; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.destination (
    id_destination integer NOT NULL,
    nom_destination character varying(100) NOT NULL,
    latitude numeric(16,14) NOT NULL,
    longitude numeric(16,14) NOT NULL
);


ALTER TABLE public.destination OWNER TO postgres;

--
-- Name: destination_id_destination_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.destination_id_destination_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.destination_id_destination_seq OWNER TO postgres;

--
-- Name: destination_id_destination_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.destination_id_destination_seq OWNED BY public.destination.id_destination;


--
-- Name: modele; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.modele (
    id_modele integer NOT NULL,
    nom_modele character varying(100) NOT NULL,
    id_propulsion integer NOT NULL,
    nb_places integer NOT NULL,
    autonomie_theorique integer,
    taille_batterie numeric(10,2),
    conso_kwh_100 numeric(5,2),
    conso_lt_100 numeric(5,2),
    CONSTRAINT modele_nb_places_check CHECK ((nb_places > 0))
);


ALTER TABLE public.modele OWNER TO postgres;

--
-- Name: modele_id_modele_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.modele_id_modele_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.modele_id_modele_seq OWNER TO postgres;

--
-- Name: modele_id_modele_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.modele_id_modele_seq OWNED BY public.modele.id_modele;


--
-- Name: propulsion; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.propulsion (
    id_propulsion integer NOT NULL,
    type_propulsion character varying(20) NOT NULL
);


ALTER TABLE public.propulsion OWNER TO postgres;

--
-- Name: propulsion_id_propulsion_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.propulsion_id_propulsion_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.propulsion_id_propulsion_seq OWNER TO postgres;

--
-- Name: propulsion_id_propulsion_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.propulsion_id_propulsion_seq OWNED BY public.propulsion.id_propulsion;


--
-- Name: releve_km; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.releve_km (
    id_releve integer NOT NULL,
    id_vehicule integer NOT NULL,
    releve_km numeric(10,2) NOT NULL,
    date_releve timestamp without time zone NOT NULL,
    source_releve character varying(50) NOT NULL,
    CONSTRAINT releve_km_releve_km_check CHECK ((releve_km >= (0)::numeric))
);


ALTER TABLE public.releve_km OWNER TO postgres;

--
-- Name: releve_km_id_releve_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.releve_km_id_releve_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.releve_km_id_releve_seq OWNER TO postgres;

--
-- Name: releve_km_id_releve_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.releve_km_id_releve_seq OWNED BY public.releve_km.id_releve;


--
-- Name: reservation; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.reservation (
    id_reservation integer NOT NULL,
    id_vehicule integer NOT NULL,
    id_utilisateur integer NOT NULL,
    date_debut timestamp without time zone NOT NULL,
    date_fin timestamp without time zone NOT NULL,
    nb_places_reservees integer NOT NULL,
    CONSTRAINT reservation_check CHECK ((date_fin > date_debut)),
    CONSTRAINT reservation_nb_places_reservees_check CHECK ((nb_places_reservees > 0))
);


ALTER TABLE public.reservation OWNER TO postgres;

--
-- Name: reservation_id_reservation_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.reservation_id_reservation_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.reservation_id_reservation_seq OWNER TO postgres;

--
-- Name: reservation_id_reservation_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.reservation_id_reservation_seq OWNED BY public.reservation.id_reservation;


--
-- Name: site_rattachement; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.site_rattachement (
    id_site integer NOT NULL,
    nom_site character varying(100) NOT NULL
);


ALTER TABLE public.site_rattachement OWNER TO postgres;

--
-- Name: site_rattachement_id_site_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.site_rattachement_id_site_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.site_rattachement_id_site_seq OWNER TO postgres;

--
-- Name: site_rattachement_id_site_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.site_rattachement_id_site_seq OWNED BY public.site_rattachement.id_site;


--
-- Name: type_defaut; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.type_defaut (
    id_defaut integer NOT NULL,
    categorie character varying(100) NOT NULL
);


ALTER TABLE public.type_defaut OWNER TO postgres;

--
-- Name: type_defaut_id_defaut_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.type_defaut_id_defaut_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.type_defaut_id_defaut_seq OWNER TO postgres;

--
-- Name: type_defaut_id_defaut_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.type_defaut_id_defaut_seq OWNED BY public.type_defaut.id_defaut;


--
-- Name: utilisateur; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.utilisateur (
    id_utilisateur integer NOT NULL,
    nom_utilisateur character varying(100) NOT NULL,
    password character varying(255),
    email varchar(100),
    token varchar(255),
    refresh_token varchar(255)
);


ALTER TABLE public.utilisateur OWNER TO postgres;

--
-- Name: utilisateur_id_utilisateur_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.utilisateur_id_utilisateur_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.utilisateur_id_utilisateur_seq OWNER TO postgres;

--
-- Name: utilisateur_id_utilisateur_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.utilisateur_id_utilisateur_seq OWNED BY public.utilisateur.id_utilisateur;


--
-- Name: vehicule; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.vehicule (
    id_vehicule integer NOT NULL,
    immatriculation character varying(20) NOT NULL,
    id_modele integer NOT NULL,
    id_site integer NOT NULL
);


ALTER TABLE public.vehicule OWNER TO postgres;

--
-- Name: vehicule_id_vehicule_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.vehicule_id_vehicule_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.vehicule_id_vehicule_seq OWNER TO postgres;

--
-- Name: vehicule_id_vehicule_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.vehicule_id_vehicule_seq OWNED BY public.vehicule.id_vehicule;


--
-- Name: defaut_releve id_releve; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.defaut_releve ALTER COLUMN id_releve SET DEFAULT nextval('public.defaut_releve_id_releve_seq'::regclass);


--
-- Name: destination id_destination; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.destination ALTER COLUMN id_destination SET DEFAULT nextval('public.destination_id_destination_seq'::regclass);


--
-- Name: modele id_modele; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.modele ALTER COLUMN id_modele SET DEFAULT nextval('public.modele_id_modele_seq'::regclass);


--
-- Name: propulsion id_propulsion; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.propulsion ALTER COLUMN id_propulsion SET DEFAULT nextval('public.propulsion_id_propulsion_seq'::regclass);


--
-- Name: releve_km id_releve; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.releve_km ALTER COLUMN id_releve SET DEFAULT nextval('public.releve_km_id_releve_seq'::regclass);


--
-- Name: reservation id_reservation; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reservation ALTER COLUMN id_reservation SET DEFAULT nextval('public.reservation_id_reservation_seq'::regclass);


--
-- Name: site_rattachement id_site; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.site_rattachement ALTER COLUMN id_site SET DEFAULT nextval('public.site_rattachement_id_site_seq'::regclass);


--
-- Name: type_defaut id_defaut; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.type_defaut ALTER COLUMN id_defaut SET DEFAULT nextval('public.type_defaut_id_defaut_seq'::regclass);


--
-- Name: utilisateur id_utilisateur; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.utilisateur ALTER COLUMN id_utilisateur SET DEFAULT nextval('public.utilisateur_id_utilisateur_seq'::regclass);


--
-- Name: vehicule id_vehicule; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vehicule ALTER COLUMN id_vehicule SET DEFAULT nextval('public.vehicule_id_vehicule_seq'::regclass);


--
-- Data for Name: defaut_releve; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.defaut_releve (id_releve, id_vehicule, id_defaut, date_releve, commentaire_libre) FROM stdin;
\.


--
-- Data for Name: destination; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.destination (id_destination, nom_destination, latitude, longitude) FROM stdin;
1	Ajaccio	41.92160655409350	8.73395383169606
2	Bastia	42.70180081546910	9.44494414581071
3	Calvi	42.55941969932390	8.79887238228141
4	Porto Vecchio	41.54282851713450	9.29248735730265
5	Corte	42.30562712661640	9.15755768008198
6	Propriano	41.67415932406030	8.90558766539714
7	Ghisonaccia	42.04072837099930	9.43363246560368
8	Castirla	42.30293332812360	9.15272216488427
9	Rizzanese	41.70390513537530	9.04751951323652
\.


--
-- Data for Name: modele; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.modele (id_modele, nom_modele, id_propulsion, nb_places, autonomie_theorique, taille_batterie, conso_kwh_100, conso_lt_100) FROM stdin;
1	Clio IV	1	2	640	\N	\N	7.00
2	Peugeuot E-208	2	2	340	51.00	18.00	\N
3	C5 hybride	3	5	750	\N	\N	4.50
4	Nissan Leaf	2	4	250	40.00	16.00	\N
\.


--
-- Data for Name: propulsion; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.propulsion (id_propulsion, type_propulsion) FROM stdin;
1	Thermique
2	Electrique
3	Hybride
\.


--
-- Data for Name: releve_km; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.releve_km (id_releve, id_vehicule, releve_km, date_releve, source_releve) FROM stdin;
1	3	1357.00	2024-10-04 00:00:00	manuelle
2	3	1520.00	2024-11-10 00:00:00	appli
\.


--
-- Data for Name: reservation; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.reservation (id_reservation, id_vehicule, id_utilisateur, date_debut, date_fin, nb_places_reservees) FROM stdin;
\.


--
-- Data for Name: site_rattachement; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.site_rattachement (id_site, nom_site) FROM stdin;
1	Ajaccio
2	Bastia
\.


--
-- Data for Name: type_defaut; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.type_defaut (id_defaut, categorie) FROM stdin;
1	essuie glaces
2	vitres
3	pneus
4	mécanique
5	éclairage
6	manque equipement
7	autonomie
8	autre
\.


--
-- Data for Name: utilisateur; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.utilisateur (id_utilisateur, nom_utilisateur, password) FROM stdin;
\.


--
-- Data for Name: vehicule; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.vehicule (id_vehicule, immatriculation, id_modele, id_site) FROM stdin;
1	FD161BV	1	1
3	GS817QP	2	1
4	HA505DA	2	2
5	GS061PW	2	2
6	GK357ZC	3	1
7	GK288ZC	3	2
8	FK636HC	4	1
\.


--
-- Name: defaut_releve_id_releve_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.defaut_releve_id_releve_seq', 1, false);


--
-- Name: destination_id_destination_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.destination_id_destination_seq', 1, false);


--
-- Name: modele_id_modele_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.modele_id_modele_seq', 4, true);


--
-- Name: propulsion_id_propulsion_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.propulsion_id_propulsion_seq', 3, true);


--
-- Name: releve_km_id_releve_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.releve_km_id_releve_seq', 2, true);


--
-- Name: reservation_id_reservation_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.reservation_id_reservation_seq', 1, false);


--
-- Name: site_rattachement_id_site_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.site_rattachement_id_site_seq', 2, true);


--
-- Name: type_defaut_id_defaut_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.type_defaut_id_defaut_seq', 1, false);


--
-- Name: utilisateur_id_utilisateur_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.utilisateur_id_utilisateur_seq', 1, false);


--
-- Name: vehicule_id_vehicule_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.vehicule_id_vehicule_seq', 1, false);


--
-- Name: defaut_releve defaut_releve_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.defaut_releve
    ADD CONSTRAINT defaut_releve_pkey PRIMARY KEY (id_releve);


--
-- Name: destination destination_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.destination
    ADD CONSTRAINT destination_pkey PRIMARY KEY (id_destination);


--
-- Name: modele modele_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.modele
    ADD CONSTRAINT modele_pkey PRIMARY KEY (id_modele);


--
-- Name: propulsion propulsion_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.propulsion
    ADD CONSTRAINT propulsion_pkey PRIMARY KEY (id_propulsion);


--
-- Name: propulsion propulsion_type_propulsion_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.propulsion
    ADD CONSTRAINT propulsion_type_propulsion_key UNIQUE (type_propulsion);


--
-- Name: releve_km releve_km_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.releve_km
    ADD CONSTRAINT releve_km_pkey PRIMARY KEY (id_releve);


--
-- Name: reservation reservation_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reservation
    ADD CONSTRAINT reservation_pkey PRIMARY KEY (id_reservation);


--
-- Name: site_rattachement site_rattachement_nom_site_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.site_rattachement
    ADD CONSTRAINT site_rattachement_nom_site_key UNIQUE (nom_site);


--
-- Name: site_rattachement site_rattachement_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.site_rattachement
    ADD CONSTRAINT site_rattachement_pkey PRIMARY KEY (id_site);


--
-- Name: type_defaut type_defaut_categorie_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.type_defaut
    ADD CONSTRAINT type_defaut_categorie_key UNIQUE (categorie);


--
-- Name: type_defaut type_defaut_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.type_defaut
    ADD CONSTRAINT type_defaut_pkey PRIMARY KEY (id_defaut);


--
-- Name: utilisateur utilisateur_nom_utilisateur_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_nom_utilisateur_key UNIQUE (nom_utilisateur);


--
-- Name: utilisateur utilisateur_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_pkey PRIMARY KEY (id_utilisateur);


--
-- Name: vehicule vehicule_immatriculation_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vehicule
    ADD CONSTRAINT vehicule_immatriculation_key UNIQUE (immatriculation);


--
-- Name: vehicule vehicule_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vehicule
    ADD CONSTRAINT vehicule_pkey PRIMARY KEY (id_vehicule);


--
-- Name: idx_defaut_vehicule; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_defaut_vehicule ON public.defaut_releve USING btree (id_vehicule);


--
-- Name: idx_releve_km_vehicule; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_releve_km_vehicule ON public.releve_km USING btree (id_vehicule);


--
-- Name: idx_reservation_dates; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_reservation_dates ON public.reservation USING btree (date_debut, date_fin);


--
-- Name: idx_reservation_vehicule; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_reservation_vehicule ON public.reservation USING btree (id_vehicule);


--
-- Name: idx_vehicule_immat; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_vehicule_immat ON public.vehicule USING btree (immatriculation);


--
-- Name: defaut_releve defaut_releve_id_defaut_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.defaut_releve
    ADD CONSTRAINT defaut_releve_id_defaut_fkey FOREIGN KEY (id_defaut) REFERENCES public.type_defaut(id_defaut);


--
-- Name: defaut_releve defaut_releve_id_vehicule_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.defaut_releve
    ADD CONSTRAINT defaut_releve_id_vehicule_fkey FOREIGN KEY (id_vehicule) REFERENCES public.vehicule(id_vehicule);


--
-- Name: modele modele_id_propulsion_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.modele
    ADD CONSTRAINT modele_id_propulsion_fkey FOREIGN KEY (id_propulsion) REFERENCES public.propulsion(id_propulsion);


--
-- Name: releve_km releve_km_id_vehicule_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.releve_km
    ADD CONSTRAINT releve_km_id_vehicule_fkey FOREIGN KEY (id_vehicule) REFERENCES public.vehicule(id_vehicule);


--
-- Name: reservation reservation_id_utilisateur_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reservation
    ADD CONSTRAINT reservation_id_utilisateur_fkey FOREIGN KEY (id_utilisateur) REFERENCES public.utilisateur(id_utilisateur);


--
-- Name: reservation reservation_id_vehicule_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reservation
    ADD CONSTRAINT reservation_id_vehicule_fkey FOREIGN KEY (id_vehicule) REFERENCES public.vehicule(id_vehicule);


--
-- Name: vehicule vehicule_id_modele_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vehicule
    ADD CONSTRAINT vehicule_id_modele_fkey FOREIGN KEY (id_modele) REFERENCES public.modele(id_modele);


--
-- Name: vehicule vehicule_id_site_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vehicule
    ADD CONSTRAINT vehicule_id_site_fkey FOREIGN KEY (id_site) REFERENCES public.site_rattachement(id_site);


--
-- PostgreSQL database dump complete
--
