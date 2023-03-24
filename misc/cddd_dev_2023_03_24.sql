--
-- PostgreSQL database dump
--

-- Dumped from database version 14.6 (Homebrew)
-- Dumped by pg_dump version 14.6 (Homebrew)

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
-- Name: update_modified_column(); Type: FUNCTION; Schema: public; Owner: nicorinn
--

CREATE FUNCTION public.update_modified_column() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.updated_at = now();
    RETURN NEW;   
END;
$$;


ALTER FUNCTION public.update_modified_column() OWNER TO nicorinn;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: clinical_annotation; Type: TABLE; Schema: public; Owner: nicorinn
--

CREATE TABLE public.clinical_annotation (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    annotation character varying(150) NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.clinical_annotation OWNER TO nicorinn;

--
-- Name: company; Type: TABLE; Schema: public; Owner: nicorinn
--

CREATE TABLE public.company (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    name character varying(150) NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.company OWNER TO nicorinn;

--
-- Name: compound; Type: TABLE; Schema: public; Owner: nicorinn
--

CREATE TABLE public.compound (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    discontinuation_phase integer NOT NULL,
    discontinuation_reason character varying(300),
    discontinuation_year integer NOT NULL,
    discontinuation_company_id uuid NOT NULL,
    link character varying(1000) NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.compound OWNER TO nicorinn;

--
-- Name: compound_clinical_annotation; Type: TABLE; Schema: public; Owner: nicorinn
--

CREATE TABLE public.compound_clinical_annotation (
    compound_id uuid NOT NULL,
    clinical_annotation_id uuid NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.compound_clinical_annotation OWNER TO nicorinn;

--
-- Name: compound_disease; Type: TABLE; Schema: public; Owner: nicorinn
--

CREATE TABLE public.compound_disease (
    compound_id uuid NOT NULL,
    disease_id uuid NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.compound_disease OWNER TO nicorinn;

--
-- Name: compound_gene_target; Type: TABLE; Schema: public; Owner: nicorinn
--

CREATE TABLE public.compound_gene_target (
    compound_id uuid NOT NULL,
    gene_target_id uuid NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.compound_gene_target OWNER TO nicorinn;

--
-- Name: compound_indication; Type: TABLE; Schema: public; Owner: nicorinn
--

CREATE TABLE public.compound_indication (
    compound_id uuid NOT NULL,
    indication_id uuid NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.compound_indication OWNER TO nicorinn;

--
-- Name: compound_mechanism_of_action; Type: TABLE; Schema: public; Owner: nicorinn
--

CREATE TABLE public.compound_mechanism_of_action (
    compound_id uuid NOT NULL,
    mechanism_of_action_id uuid NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.compound_mechanism_of_action OWNER TO nicorinn;

--
-- Name: compound_name; Type: TABLE; Schema: public; Owner: nicorinn
--

CREATE TABLE public.compound_name (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    name character varying(150) NOT NULL,
    is_repurposed boolean DEFAULT false,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.compound_name OWNER TO nicorinn;

--
-- Name: compound_name_compound; Type: TABLE; Schema: public; Owner: nicorinn
--

CREATE TABLE public.compound_name_compound (
    compound_id uuid NOT NULL,
    compound_name_id uuid NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.compound_name_compound OWNER TO nicorinn;

--
-- Name: compound_pathway_annotation; Type: TABLE; Schema: public; Owner: nicorinn
--

CREATE TABLE public.compound_pathway_annotation (
    compound_id uuid NOT NULL,
    pathway_annotation_id uuid NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.compound_pathway_annotation OWNER TO nicorinn;

--
-- Name: compound_repurposing; Type: TABLE; Schema: public; Owner: nicorinn
--

CREATE TABLE public.compound_repurposing (
    compound_id uuid NOT NULL,
    repurposing_id uuid NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.compound_repurposing OWNER TO nicorinn;

--
-- Name: compound_target; Type: TABLE; Schema: public; Owner: nicorinn
--

CREATE TABLE public.compound_target (
    compound_id uuid NOT NULL,
    target_id uuid NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.compound_target OWNER TO nicorinn;

--
-- Name: disease; Type: TABLE; Schema: public; Owner: nicorinn
--

CREATE TABLE public.disease (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    name character varying(150) NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.disease OWNER TO nicorinn;

--
-- Name: gene_target; Type: TABLE; Schema: public; Owner: nicorinn
--

CREATE TABLE public.gene_target (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    gene character varying(150) NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.gene_target OWNER TO nicorinn;

--
-- Name: indication; Type: TABLE; Schema: public; Owner: nicorinn
--

CREATE TABLE public.indication (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    indication character varying(100) NOT NULL,
    indication_type_id uuid NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.indication OWNER TO nicorinn;

--
-- Name: indication_type; Type: TABLE; Schema: public; Owner: nicorinn
--

CREATE TABLE public.indication_type (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    type character varying(100) NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.indication_type OWNER TO nicorinn;

--
-- Name: mechanism_of_action; Type: TABLE; Schema: public; Owner: nicorinn
--

CREATE TABLE public.mechanism_of_action (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    mechanism character varying(150) NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.mechanism_of_action OWNER TO nicorinn;

--
-- Name: pathway_annotation; Type: TABLE; Schema: public; Owner: nicorinn
--

CREATE TABLE public.pathway_annotation (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    annotation character varying(150) NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.pathway_annotation OWNER TO nicorinn;

--
-- Name: repurposing; Type: TABLE; Schema: public; Owner: nicorinn
--

CREATE TABLE public.repurposing (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    compound_id uuid NOT NULL,
    compound_name_id uuid NOT NULL,
    company_id uuid NOT NULL,
    year integer NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.repurposing OWNER TO nicorinn;

--
-- Name: repurposing_effort; Type: TABLE; Schema: public; Owner: nicorinn
--

CREATE TABLE public.repurposing_effort (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    repurposing_id uuid NOT NULL,
    effort character varying(150),
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.repurposing_effort OWNER TO nicorinn;

--
-- Name: repurposing_indication; Type: TABLE; Schema: public; Owner: nicorinn
--

CREATE TABLE public.repurposing_indication (
    indication_id uuid NOT NULL,
    repurposing_id uuid NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.repurposing_indication OWNER TO nicorinn;

--
-- Name: target; Type: TABLE; Schema: public; Owner: nicorinn
--

CREATE TABLE public.target (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.target OWNER TO nicorinn;

--
-- Name: target_name; Type: TABLE; Schema: public; Owner: nicorinn
--

CREATE TABLE public.target_name (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    name character varying(150) NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.target_name OWNER TO nicorinn;

--
-- Name: target_name_target; Type: TABLE; Schema: public; Owner: nicorinn
--

CREATE TABLE public.target_name_target (
    target_id uuid NOT NULL,
    target_name_id uuid NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.target_name_target OWNER TO nicorinn;

--
-- Data for Name: clinical_annotation; Type: TABLE DATA; Schema: public; Owner: nicorinn
--

COPY public.clinical_annotation (id, annotation, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: company; Type: TABLE DATA; Schema: public; Owner: nicorinn
--

COPY public.company (id, name, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: compound; Type: TABLE DATA; Schema: public; Owner: nicorinn
--

COPY public.compound (id, discontinuation_phase, discontinuation_reason, discontinuation_year, discontinuation_company_id, link, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: compound_clinical_annotation; Type: TABLE DATA; Schema: public; Owner: nicorinn
--

COPY public.compound_clinical_annotation (compound_id, clinical_annotation_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: compound_disease; Type: TABLE DATA; Schema: public; Owner: nicorinn
--

COPY public.compound_disease (compound_id, disease_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: compound_gene_target; Type: TABLE DATA; Schema: public; Owner: nicorinn
--

COPY public.compound_gene_target (compound_id, gene_target_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: compound_indication; Type: TABLE DATA; Schema: public; Owner: nicorinn
--

COPY public.compound_indication (compound_id, indication_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: compound_mechanism_of_action; Type: TABLE DATA; Schema: public; Owner: nicorinn
--

COPY public.compound_mechanism_of_action (compound_id, mechanism_of_action_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: compound_name; Type: TABLE DATA; Schema: public; Owner: nicorinn
--

COPY public.compound_name (id, name, is_repurposed, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: compound_name_compound; Type: TABLE DATA; Schema: public; Owner: nicorinn
--

COPY public.compound_name_compound (compound_id, compound_name_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: compound_pathway_annotation; Type: TABLE DATA; Schema: public; Owner: nicorinn
--

COPY public.compound_pathway_annotation (compound_id, pathway_annotation_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: compound_repurposing; Type: TABLE DATA; Schema: public; Owner: nicorinn
--

COPY public.compound_repurposing (compound_id, repurposing_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: compound_target; Type: TABLE DATA; Schema: public; Owner: nicorinn
--

COPY public.compound_target (compound_id, target_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: disease; Type: TABLE DATA; Schema: public; Owner: nicorinn
--

COPY public.disease (id, name, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: gene_target; Type: TABLE DATA; Schema: public; Owner: nicorinn
--

COPY public.gene_target (id, gene, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: indication; Type: TABLE DATA; Schema: public; Owner: nicorinn
--

COPY public.indication (id, indication, indication_type_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: indication_type; Type: TABLE DATA; Schema: public; Owner: nicorinn
--

COPY public.indication_type (id, type, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: mechanism_of_action; Type: TABLE DATA; Schema: public; Owner: nicorinn
--

COPY public.mechanism_of_action (id, mechanism, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: pathway_annotation; Type: TABLE DATA; Schema: public; Owner: nicorinn
--

COPY public.pathway_annotation (id, annotation, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: repurposing; Type: TABLE DATA; Schema: public; Owner: nicorinn
--

COPY public.repurposing (id, compound_id, compound_name_id, company_id, year, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: repurposing_effort; Type: TABLE DATA; Schema: public; Owner: nicorinn
--

COPY public.repurposing_effort (id, repurposing_id, effort, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: repurposing_indication; Type: TABLE DATA; Schema: public; Owner: nicorinn
--

COPY public.repurposing_indication (indication_id, repurposing_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: target; Type: TABLE DATA; Schema: public; Owner: nicorinn
--

COPY public.target (id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: target_name; Type: TABLE DATA; Schema: public; Owner: nicorinn
--

COPY public.target_name (id, name, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: target_name_target; Type: TABLE DATA; Schema: public; Owner: nicorinn
--

COPY public.target_name_target (target_id, target_name_id, created_at, updated_at) FROM stdin;
\.


--
-- Name: clinical_annotation clinical_annotation_pkey; Type: CONSTRAINT; Schema: public; Owner: nicorinn
--

ALTER TABLE ONLY public.clinical_annotation
    ADD CONSTRAINT clinical_annotation_pkey PRIMARY KEY (id);


--
-- Name: company company_pkey; Type: CONSTRAINT; Schema: public; Owner: nicorinn
--

ALTER TABLE ONLY public.company
    ADD CONSTRAINT company_pkey PRIMARY KEY (id);


--
-- Name: compound_name compound_name_pkey; Type: CONSTRAINT; Schema: public; Owner: nicorinn
--

ALTER TABLE ONLY public.compound_name
    ADD CONSTRAINT compound_name_pkey PRIMARY KEY (id);


--
-- Name: compound compound_pkey; Type: CONSTRAINT; Schema: public; Owner: nicorinn
--

ALTER TABLE ONLY public.compound
    ADD CONSTRAINT compound_pkey PRIMARY KEY (id);


--
-- Name: disease disease_pkey; Type: CONSTRAINT; Schema: public; Owner: nicorinn
--

ALTER TABLE ONLY public.disease
    ADD CONSTRAINT disease_pkey PRIMARY KEY (id);


--
-- Name: gene_target gene_target_pkey; Type: CONSTRAINT; Schema: public; Owner: nicorinn
--

ALTER TABLE ONLY public.gene_target
    ADD CONSTRAINT gene_target_pkey PRIMARY KEY (id);


--
-- Name: indication indication_pkey; Type: CONSTRAINT; Schema: public; Owner: nicorinn
--

ALTER TABLE ONLY public.indication
    ADD CONSTRAINT indication_pkey PRIMARY KEY (id);


--
-- Name: indication_type indication_type_pkey; Type: CONSTRAINT; Schema: public; Owner: nicorinn
--

ALTER TABLE ONLY public.indication_type
    ADD CONSTRAINT indication_type_pkey PRIMARY KEY (id);


--
-- Name: mechanism_of_action mechanism_of_action_pkey; Type: CONSTRAINT; Schema: public; Owner: nicorinn
--

ALTER TABLE ONLY public.mechanism_of_action
    ADD CONSTRAINT mechanism_of_action_pkey PRIMARY KEY (id);


--
-- Name: pathway_annotation pathway_annotation_pkey; Type: CONSTRAINT; Schema: public; Owner: nicorinn
--

ALTER TABLE ONLY public.pathway_annotation
    ADD CONSTRAINT pathway_annotation_pkey PRIMARY KEY (id);


--
-- Name: repurposing_effort repurposing_effort_pkey; Type: CONSTRAINT; Schema: public; Owner: nicorinn
--

ALTER TABLE ONLY public.repurposing_effort
    ADD CONSTRAINT repurposing_effort_pkey PRIMARY KEY (id);


--
-- Name: repurposing repurposing_pkey; Type: CONSTRAINT; Schema: public; Owner: nicorinn
--

ALTER TABLE ONLY public.repurposing
    ADD CONSTRAINT repurposing_pkey PRIMARY KEY (id);


--
-- Name: target_name target_name_pkey; Type: CONSTRAINT; Schema: public; Owner: nicorinn
--

ALTER TABLE ONLY public.target_name
    ADD CONSTRAINT target_name_pkey PRIMARY KEY (id);


--
-- Name: target target_pkey; Type: CONSTRAINT; Schema: public; Owner: nicorinn
--

ALTER TABLE ONLY public.target
    ADD CONSTRAINT target_pkey PRIMARY KEY (id);


--
-- Name: clinical_annotation update_clinical_annotation_timestamp; Type: TRIGGER; Schema: public; Owner: nicorinn
--

CREATE TRIGGER update_clinical_annotation_timestamp BEFORE UPDATE ON public.clinical_annotation FOR EACH ROW EXECUTE FUNCTION public.update_modified_column();


--
-- Name: company update_comany_timestamp; Type: TRIGGER; Schema: public; Owner: nicorinn
--

CREATE TRIGGER update_comany_timestamp BEFORE UPDATE ON public.company FOR EACH ROW EXECUTE FUNCTION public.update_modified_column();


--
-- Name: compound_clinical_annotation update_compound_clinical_annotation_timestamp; Type: TRIGGER; Schema: public; Owner: nicorinn
--

CREATE TRIGGER update_compound_clinical_annotation_timestamp BEFORE UPDATE ON public.compound_clinical_annotation FOR EACH ROW EXECUTE FUNCTION public.update_modified_column();


--
-- Name: compound_disease update_compound_disease_timestamp; Type: TRIGGER; Schema: public; Owner: nicorinn
--

CREATE TRIGGER update_compound_disease_timestamp BEFORE UPDATE ON public.compound_disease FOR EACH ROW EXECUTE FUNCTION public.update_modified_column();


--
-- Name: compound_gene_target update_compound_gene_target_timestamp; Type: TRIGGER; Schema: public; Owner: nicorinn
--

CREATE TRIGGER update_compound_gene_target_timestamp BEFORE UPDATE ON public.compound_gene_target FOR EACH ROW EXECUTE FUNCTION public.update_modified_column();


--
-- Name: compound_indication update_compound_indication_timestamp; Type: TRIGGER; Schema: public; Owner: nicorinn
--

CREATE TRIGGER update_compound_indication_timestamp BEFORE UPDATE ON public.compound_indication FOR EACH ROW EXECUTE FUNCTION public.update_modified_column();


--
-- Name: compound_mechanism_of_action update_compound_mechanism_of_action_timestamp; Type: TRIGGER; Schema: public; Owner: nicorinn
--

CREATE TRIGGER update_compound_mechanism_of_action_timestamp BEFORE UPDATE ON public.compound_mechanism_of_action FOR EACH ROW EXECUTE FUNCTION public.update_modified_column();


--
-- Name: compound_name_compound update_compound_name_compound_timestamp; Type: TRIGGER; Schema: public; Owner: nicorinn
--

CREATE TRIGGER update_compound_name_compound_timestamp BEFORE UPDATE ON public.compound_name_compound FOR EACH ROW EXECUTE FUNCTION public.update_modified_column();


--
-- Name: compound_name update_compound_name_timestamp; Type: TRIGGER; Schema: public; Owner: nicorinn
--

CREATE TRIGGER update_compound_name_timestamp BEFORE UPDATE ON public.compound_name FOR EACH ROW EXECUTE FUNCTION public.update_modified_column();


--
-- Name: compound_pathway_annotation update_compound_pathway_annotation_timestamp; Type: TRIGGER; Schema: public; Owner: nicorinn
--

CREATE TRIGGER update_compound_pathway_annotation_timestamp BEFORE UPDATE ON public.compound_pathway_annotation FOR EACH ROW EXECUTE FUNCTION public.update_modified_column();


--
-- Name: compound_repurposing update_compound_repurposing_timestamp; Type: TRIGGER; Schema: public; Owner: nicorinn
--

CREATE TRIGGER update_compound_repurposing_timestamp BEFORE UPDATE ON public.compound_repurposing FOR EACH ROW EXECUTE FUNCTION public.update_modified_column();


--
-- Name: compound_target update_compound_target_timestamp; Type: TRIGGER; Schema: public; Owner: nicorinn
--

CREATE TRIGGER update_compound_target_timestamp BEFORE UPDATE ON public.compound_target FOR EACH ROW EXECUTE FUNCTION public.update_modified_column();


--
-- Name: compound update_compound_timestamp; Type: TRIGGER; Schema: public; Owner: nicorinn
--

CREATE TRIGGER update_compound_timestamp BEFORE UPDATE ON public.compound FOR EACH ROW EXECUTE FUNCTION public.update_modified_column();


--
-- Name: disease update_disease_timestamp; Type: TRIGGER; Schema: public; Owner: nicorinn
--

CREATE TRIGGER update_disease_timestamp BEFORE UPDATE ON public.disease FOR EACH ROW EXECUTE FUNCTION public.update_modified_column();


--
-- Name: gene_target update_gene_target_timestamp; Type: TRIGGER; Schema: public; Owner: nicorinn
--

CREATE TRIGGER update_gene_target_timestamp BEFORE UPDATE ON public.gene_target FOR EACH ROW EXECUTE FUNCTION public.update_modified_column();


--
-- Name: indication_type update_indication_type_timestamp; Type: TRIGGER; Schema: public; Owner: nicorinn
--

CREATE TRIGGER update_indication_type_timestamp BEFORE UPDATE ON public.indication_type FOR EACH ROW EXECUTE FUNCTION public.update_modified_column();


--
-- Name: mechanism_of_action update_moa_timestamp; Type: TRIGGER; Schema: public; Owner: nicorinn
--

CREATE TRIGGER update_moa_timestamp BEFORE UPDATE ON public.mechanism_of_action FOR EACH ROW EXECUTE FUNCTION public.update_modified_column();


--
-- Name: pathway_annotation update_pathway_annotation_timestamp; Type: TRIGGER; Schema: public; Owner: nicorinn
--

CREATE TRIGGER update_pathway_annotation_timestamp BEFORE UPDATE ON public.pathway_annotation FOR EACH ROW EXECUTE FUNCTION public.update_modified_column();


--
-- Name: repurposing_effort update_repurposing_effort_timestamp; Type: TRIGGER; Schema: public; Owner: nicorinn
--

CREATE TRIGGER update_repurposing_effort_timestamp BEFORE UPDATE ON public.repurposing_effort FOR EACH ROW EXECUTE FUNCTION public.update_modified_column();


--
-- Name: repurposing_indication update_repurposing_indication_timestamp; Type: TRIGGER; Schema: public; Owner: nicorinn
--

CREATE TRIGGER update_repurposing_indication_timestamp BEFORE UPDATE ON public.repurposing_indication FOR EACH ROW EXECUTE FUNCTION public.update_modified_column();


--
-- Name: repurposing update_repurposing_timestamp; Type: TRIGGER; Schema: public; Owner: nicorinn
--

CREATE TRIGGER update_repurposing_timestamp BEFORE UPDATE ON public.repurposing FOR EACH ROW EXECUTE FUNCTION public.update_modified_column();


--
-- Name: target_name_target update_target_name_targer_timestamp; Type: TRIGGER; Schema: public; Owner: nicorinn
--

CREATE TRIGGER update_target_name_targer_timestamp BEFORE UPDATE ON public.target_name_target FOR EACH ROW EXECUTE FUNCTION public.update_modified_column();


--
-- Name: target_name update_target_name_timestamp; Type: TRIGGER; Schema: public; Owner: nicorinn
--

CREATE TRIGGER update_target_name_timestamp BEFORE UPDATE ON public.target_name FOR EACH ROW EXECUTE FUNCTION public.update_modified_column();


--
-- Name: target update_target_timestamp; Type: TRIGGER; Schema: public; Owner: nicorinn
--

CREATE TRIGGER update_target_timestamp BEFORE UPDATE ON public.target FOR EACH ROW EXECUTE FUNCTION public.update_modified_column();


--
-- Name: compound_clinical_annotation fk_clinical_annotation; Type: FK CONSTRAINT; Schema: public; Owner: nicorinn
--

ALTER TABLE ONLY public.compound_clinical_annotation
    ADD CONSTRAINT fk_clinical_annotation FOREIGN KEY (clinical_annotation_id) REFERENCES public.clinical_annotation(id);


--
-- Name: repurposing fk_company; Type: FK CONSTRAINT; Schema: public; Owner: nicorinn
--

ALTER TABLE ONLY public.repurposing
    ADD CONSTRAINT fk_company FOREIGN KEY (company_id) REFERENCES public.company(id);


--
-- Name: compound fk_company; Type: FK CONSTRAINT; Schema: public; Owner: nicorinn
--

ALTER TABLE ONLY public.compound
    ADD CONSTRAINT fk_company FOREIGN KEY (discontinuation_company_id) REFERENCES public.company(id);


--
-- Name: compound_name_compound fk_compound; Type: FK CONSTRAINT; Schema: public; Owner: nicorinn
--

ALTER TABLE ONLY public.compound_name_compound
    ADD CONSTRAINT fk_compound FOREIGN KEY (compound_id) REFERENCES public.compound(id);


--
-- Name: compound_gene_target fk_compound; Type: FK CONSTRAINT; Schema: public; Owner: nicorinn
--

ALTER TABLE ONLY public.compound_gene_target
    ADD CONSTRAINT fk_compound FOREIGN KEY (compound_id) REFERENCES public.compound(id);


--
-- Name: compound_clinical_annotation fk_compound; Type: FK CONSTRAINT; Schema: public; Owner: nicorinn
--

ALTER TABLE ONLY public.compound_clinical_annotation
    ADD CONSTRAINT fk_compound FOREIGN KEY (compound_id) REFERENCES public.compound(id);


--
-- Name: compound_pathway_annotation fk_compound; Type: FK CONSTRAINT; Schema: public; Owner: nicorinn
--

ALTER TABLE ONLY public.compound_pathway_annotation
    ADD CONSTRAINT fk_compound FOREIGN KEY (compound_id) REFERENCES public.compound(id);


--
-- Name: compound_disease fk_compound; Type: FK CONSTRAINT; Schema: public; Owner: nicorinn
--

ALTER TABLE ONLY public.compound_disease
    ADD CONSTRAINT fk_compound FOREIGN KEY (compound_id) REFERENCES public.compound(id);


--
-- Name: compound_target fk_compound; Type: FK CONSTRAINT; Schema: public; Owner: nicorinn
--

ALTER TABLE ONLY public.compound_target
    ADD CONSTRAINT fk_compound FOREIGN KEY (compound_id) REFERENCES public.compound(id);


--
-- Name: compound_mechanism_of_action fk_compound; Type: FK CONSTRAINT; Schema: public; Owner: nicorinn
--

ALTER TABLE ONLY public.compound_mechanism_of_action
    ADD CONSTRAINT fk_compound FOREIGN KEY (compound_id) REFERENCES public.compound(id);


--
-- Name: compound_indication fk_compound; Type: FK CONSTRAINT; Schema: public; Owner: nicorinn
--

ALTER TABLE ONLY public.compound_indication
    ADD CONSTRAINT fk_compound FOREIGN KEY (compound_id) REFERENCES public.compound(id);


--
-- Name: compound_repurposing fk_compound; Type: FK CONSTRAINT; Schema: public; Owner: nicorinn
--

ALTER TABLE ONLY public.compound_repurposing
    ADD CONSTRAINT fk_compound FOREIGN KEY (compound_id) REFERENCES public.compound(id);


--
-- Name: repurposing fk_compound_name; Type: FK CONSTRAINT; Schema: public; Owner: nicorinn
--

ALTER TABLE ONLY public.repurposing
    ADD CONSTRAINT fk_compound_name FOREIGN KEY (compound_name_id) REFERENCES public.compound_name(id);


--
-- Name: compound_name_compound fk_compound_name; Type: FK CONSTRAINT; Schema: public; Owner: nicorinn
--

ALTER TABLE ONLY public.compound_name_compound
    ADD CONSTRAINT fk_compound_name FOREIGN KEY (compound_name_id) REFERENCES public.compound_name(id);


--
-- Name: compound_disease fk_disease; Type: FK CONSTRAINT; Schema: public; Owner: nicorinn
--

ALTER TABLE ONLY public.compound_disease
    ADD CONSTRAINT fk_disease FOREIGN KEY (disease_id) REFERENCES public.disease(id);


--
-- Name: compound_gene_target fk_gene_target; Type: FK CONSTRAINT; Schema: public; Owner: nicorinn
--

ALTER TABLE ONLY public.compound_gene_target
    ADD CONSTRAINT fk_gene_target FOREIGN KEY (gene_target_id) REFERENCES public.gene_target(id);


--
-- Name: indication fk_indication; Type: FK CONSTRAINT; Schema: public; Owner: nicorinn
--

ALTER TABLE ONLY public.indication
    ADD CONSTRAINT fk_indication FOREIGN KEY (indication_type_id) REFERENCES public.indication_type(id);


--
-- Name: repurposing_indication fk_indication; Type: FK CONSTRAINT; Schema: public; Owner: nicorinn
--

ALTER TABLE ONLY public.repurposing_indication
    ADD CONSTRAINT fk_indication FOREIGN KEY (indication_id) REFERENCES public.indication(id);


--
-- Name: compound_indication fk_indication; Type: FK CONSTRAINT; Schema: public; Owner: nicorinn
--

ALTER TABLE ONLY public.compound_indication
    ADD CONSTRAINT fk_indication FOREIGN KEY (indication_id) REFERENCES public.indication(id);


--
-- Name: compound_mechanism_of_action fk_mechanism_of_action; Type: FK CONSTRAINT; Schema: public; Owner: nicorinn
--

ALTER TABLE ONLY public.compound_mechanism_of_action
    ADD CONSTRAINT fk_mechanism_of_action FOREIGN KEY (mechanism_of_action_id) REFERENCES public.mechanism_of_action(id);


--
-- Name: compound_pathway_annotation fk_pathway_annotation; Type: FK CONSTRAINT; Schema: public; Owner: nicorinn
--

ALTER TABLE ONLY public.compound_pathway_annotation
    ADD CONSTRAINT fk_pathway_annotation FOREIGN KEY (pathway_annotation_id) REFERENCES public.pathway_annotation(id);


--
-- Name: repurposing_indication fk_repurposing; Type: FK CONSTRAINT; Schema: public; Owner: nicorinn
--

ALTER TABLE ONLY public.repurposing_indication
    ADD CONSTRAINT fk_repurposing FOREIGN KEY (repurposing_id) REFERENCES public.repurposing(id);


--
-- Name: repurposing_effort fk_repurposing; Type: FK CONSTRAINT; Schema: public; Owner: nicorinn
--

ALTER TABLE ONLY public.repurposing_effort
    ADD CONSTRAINT fk_repurposing FOREIGN KEY (repurposing_id) REFERENCES public.repurposing(id);


--
-- Name: compound_repurposing fk_repurposing; Type: FK CONSTRAINT; Schema: public; Owner: nicorinn
--

ALTER TABLE ONLY public.compound_repurposing
    ADD CONSTRAINT fk_repurposing FOREIGN KEY (repurposing_id) REFERENCES public.repurposing(id);


--
-- Name: target_name_target fk_target; Type: FK CONSTRAINT; Schema: public; Owner: nicorinn
--

ALTER TABLE ONLY public.target_name_target
    ADD CONSTRAINT fk_target FOREIGN KEY (target_id) REFERENCES public.target(id);


--
-- Name: compound_target fk_target; Type: FK CONSTRAINT; Schema: public; Owner: nicorinn
--

ALTER TABLE ONLY public.compound_target
    ADD CONSTRAINT fk_target FOREIGN KEY (target_id) REFERENCES public.target(id);


--
-- Name: target_name_target fk_target_name; Type: FK CONSTRAINT; Schema: public; Owner: nicorinn
--

ALTER TABLE ONLY public.target_name_target
    ADD CONSTRAINT fk_target_name FOREIGN KEY (target_name_id) REFERENCES public.target_name(id);


--
-- PostgreSQL database dump complete
--

