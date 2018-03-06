--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.2
-- Dumped by pg_dump version 9.6.2

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: auth_group; Type: TABLE; Schema: public; Owner: digimundo
--

CREATE TABLE auth_group (
    id integer NOT NULL,
    name character varying(80) NOT NULL
);


ALTER TABLE auth_group OWNER TO digimundo;

--
-- Name: auth_group_id_seq; Type: SEQUENCE; Schema: public; Owner: digimundo
--

CREATE SEQUENCE auth_group_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE auth_group_id_seq OWNER TO digimundo;

--
-- Name: auth_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: digimundo
--

ALTER SEQUENCE auth_group_id_seq OWNED BY auth_group.id;


--
-- Name: auth_group_permissions; Type: TABLE; Schema: public; Owner: digimundo
--

CREATE TABLE auth_group_permissions (
    id integer NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE auth_group_permissions OWNER TO digimundo;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: digimundo
--

CREATE SEQUENCE auth_group_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE auth_group_permissions_id_seq OWNER TO digimundo;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: digimundo
--

ALTER SEQUENCE auth_group_permissions_id_seq OWNED BY auth_group_permissions.id;


--
-- Name: auth_permission; Type: TABLE; Schema: public; Owner: digimundo
--

CREATE TABLE auth_permission (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    content_type_id integer NOT NULL,
    codename character varying(100) NOT NULL
);


ALTER TABLE auth_permission OWNER TO digimundo;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: digimundo
--

CREATE SEQUENCE auth_permission_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE auth_permission_id_seq OWNER TO digimundo;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: digimundo
--

ALTER SEQUENCE auth_permission_id_seq OWNED BY auth_permission.id;


--
-- Name: branchoffices_branchoffice; Type: TABLE; Schema: public; Owner: digimundo
--

CREATE TABLE branchoffices_branchoffice (
    id integer NOT NULL,
    name character varying(90) NOT NULL,
    address character varying(255) NOT NULL,
    is_activate boolean NOT NULL,
    manager_id integer NOT NULL
);


ALTER TABLE branchoffices_branchoffice OWNER TO digimundo;

--
-- Name: branchoffices_branchoffice_id_seq; Type: SEQUENCE; Schema: public; Owner: digimundo
--

CREATE SEQUENCE branchoffices_branchoffice_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE branchoffices_branchoffice_id_seq OWNER TO digimundo;

--
-- Name: branchoffices_branchoffice_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: digimundo
--

ALTER SEQUENCE branchoffices_branchoffice_id_seq OWNED BY branchoffices_branchoffice.id;


--
-- Name: branchoffices_supplier; Type: TABLE; Schema: public; Owner: digimundo
--

CREATE TABLE branchoffices_supplier (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    image character varying(100) NOT NULL
);


ALTER TABLE branchoffices_supplier OWNER TO digimundo;

--
-- Name: branchoffices_supplier_id_seq; Type: SEQUENCE; Schema: public; Owner: digimundo
--

CREATE SEQUENCE branchoffices_supplier_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE branchoffices_supplier_id_seq OWNER TO digimundo;

--
-- Name: branchoffices_supplier_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: digimundo
--

ALTER SEQUENCE branchoffices_supplier_id_seq OWNED BY branchoffices_supplier.id;


--
-- Name: diners_accesslog; Type: TABLE; Schema: public; Owner: digimundo
--

CREATE TABLE diners_accesslog (
    id integer NOT NULL,
    "RFID" character varying(24) NOT NULL,
    access_to_room timestamp with time zone NOT NULL,
    diner_id integer
);


ALTER TABLE diners_accesslog OWNER TO digimundo;

--
-- Name: diners_accesslog_id_seq; Type: SEQUENCE; Schema: public; Owner: digimundo
--

CREATE SEQUENCE diners_accesslog_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE diners_accesslog_id_seq OWNER TO digimundo;

--
-- Name: diners_accesslog_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: digimundo
--

ALTER SEQUENCE diners_accesslog_id_seq OWNED BY diners_accesslog.id;


--
-- Name: diners_diner; Type: TABLE; Schema: public; Owner: digimundo
--

CREATE TABLE diners_diner (
    id integer NOT NULL,
    created_at timestamp with time zone NOT NULL,
    name character varying(160) NOT NULL,
    employee_number character varying(32) NOT NULL,
    "RFID" character varying(24) NOT NULL
);


ALTER TABLE diners_diner OWNER TO digimundo;

--
-- Name: diners_diner_id_seq; Type: SEQUENCE; Schema: public; Owner: digimundo
--

CREATE SEQUENCE diners_diner_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE diners_diner_id_seq OWNER TO digimundo;

--
-- Name: diners_diner_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: digimundo
--

ALTER SEQUENCE diners_diner_id_seq OWNED BY diners_diner.id;


--
-- Name: diners_elementtoevaluate; Type: TABLE; Schema: public; Owner: digimundo
--

CREATE TABLE diners_elementtoevaluate (
    id integer NOT NULL,
    element character varying(48) NOT NULL,
    priority integer NOT NULL
);


ALTER TABLE diners_elementtoevaluate OWNER TO digimundo;

--
-- Name: diners_elementtoevaluate_id_seq; Type: SEQUENCE; Schema: public; Owner: digimundo
--

CREATE SEQUENCE diners_elementtoevaluate_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE diners_elementtoevaluate_id_seq OWNER TO digimundo;

--
-- Name: diners_elementtoevaluate_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: digimundo
--

ALTER SEQUENCE diners_elementtoevaluate_id_seq OWNED BY diners_elementtoevaluate.id;


--
-- Name: diners_satisfactionrating; Type: TABLE; Schema: public; Owner: digimundo
--

CREATE TABLE diners_satisfactionrating (
    id integer NOT NULL,
    satisfaction_rating integer NOT NULL,
    creation_date timestamp with time zone NOT NULL,
    suggestion text,
    CONSTRAINT diners_satisfactionrating_satisfaction_rating_check CHECK ((satisfaction_rating >= 0))
);


ALTER TABLE diners_satisfactionrating OWNER TO digimundo;

--
-- Name: diners_satisfactionrating_elements; Type: TABLE; Schema: public; Owner: digimundo
--

CREATE TABLE diners_satisfactionrating_elements (
    id integer NOT NULL,
    satisfactionrating_id integer NOT NULL,
    elementtoevaluate_id integer NOT NULL
);


ALTER TABLE diners_satisfactionrating_elements OWNER TO digimundo;

--
-- Name: diners_satisfactionrating_elements_id_seq; Type: SEQUENCE; Schema: public; Owner: digimundo
--

CREATE SEQUENCE diners_satisfactionrating_elements_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE diners_satisfactionrating_elements_id_seq OWNER TO digimundo;

--
-- Name: diners_satisfactionrating_elements_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: digimundo
--

ALTER SEQUENCE diners_satisfactionrating_elements_id_seq OWNED BY diners_satisfactionrating_elements.id;


--
-- Name: diners_satisfactionrating_id_seq; Type: SEQUENCE; Schema: public; Owner: digimundo
--

CREATE SEQUENCE diners_satisfactionrating_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE diners_satisfactionrating_id_seq OWNER TO digimundo;

--
-- Name: diners_satisfactionrating_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: digimundo
--

ALTER SEQUENCE diners_satisfactionrating_id_seq OWNED BY diners_satisfactionrating.id;


--
-- Name: django_admin_log; Type: TABLE; Schema: public; Owner: digimundo
--

CREATE TABLE django_admin_log (
    id integer NOT NULL,
    action_time timestamp with time zone NOT NULL,
    object_id text,
    object_repr character varying(200) NOT NULL,
    action_flag smallint NOT NULL,
    change_message text NOT NULL,
    content_type_id integer,
    user_id integer NOT NULL,
    CONSTRAINT django_admin_log_action_flag_check CHECK ((action_flag >= 0))
);


ALTER TABLE django_admin_log OWNER TO digimundo;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE; Schema: public; Owner: digimundo
--

CREATE SEQUENCE django_admin_log_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE django_admin_log_id_seq OWNER TO digimundo;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: digimundo
--

ALTER SEQUENCE django_admin_log_id_seq OWNED BY django_admin_log.id;


--
-- Name: django_content_type; Type: TABLE; Schema: public; Owner: digimundo
--

CREATE TABLE django_content_type (
    id integer NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);


ALTER TABLE django_content_type OWNER TO digimundo;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE; Schema: public; Owner: digimundo
--

CREATE SEQUENCE django_content_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE django_content_type_id_seq OWNER TO digimundo;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: digimundo
--

ALTER SEQUENCE django_content_type_id_seq OWNED BY django_content_type.id;


--
-- Name: django_migrations; Type: TABLE; Schema: public; Owner: digimundo
--

CREATE TABLE django_migrations (
    id integer NOT NULL,
    app character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL
);


ALTER TABLE django_migrations OWNER TO digimundo;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: digimundo
--

CREATE SEQUENCE django_migrations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE django_migrations_id_seq OWNER TO digimundo;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: digimundo
--

ALTER SEQUENCE django_migrations_id_seq OWNED BY django_migrations.id;


--
-- Name: django_session; Type: TABLE; Schema: public; Owner: digimundo
--

CREATE TABLE django_session (
    session_key character varying(40) NOT NULL,
    session_data text NOT NULL,
    expire_date timestamp with time zone NOT NULL
);


ALTER TABLE django_session OWNER TO digimundo;

--
-- Name: django_site; Type: TABLE; Schema: public; Owner: digimundo
--

CREATE TABLE django_site (
    id integer NOT NULL,
    domain character varying(100) NOT NULL,
    name character varying(50) NOT NULL
);


ALTER TABLE django_site OWNER TO digimundo;

--
-- Name: django_site_id_seq; Type: SEQUENCE; Schema: public; Owner: digimundo
--

CREATE SEQUENCE django_site_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE django_site_id_seq OWNER TO digimundo;

--
-- Name: django_site_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: digimundo
--

ALTER SEQUENCE django_site_id_seq OWNED BY django_site.id;


--
-- Name: fcm_device; Type: TABLE; Schema: public; Owner: digimundo
--

CREATE TABLE fcm_device (
    id integer NOT NULL,
    dev_id character varying(50) NOT NULL,
    reg_id character varying(255) NOT NULL,
    name character varying(255),
    is_active boolean NOT NULL
);


ALTER TABLE fcm_device OWNER TO digimundo;

--
-- Name: fcm_device_id_seq; Type: SEQUENCE; Schema: public; Owner: digimundo
--

CREATE SEQUENCE fcm_device_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE fcm_device_id_seq OWNER TO digimundo;

--
-- Name: fcm_device_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: digimundo
--

ALTER SEQUENCE fcm_device_id_seq OWNED BY fcm_device.id;


--
-- Name: jet_bookmark; Type: TABLE; Schema: public; Owner: digimundo
--

CREATE TABLE jet_bookmark (
    id integer NOT NULL,
    url character varying(200) NOT NULL,
    title character varying(255) NOT NULL,
    "user" integer NOT NULL,
    date_add timestamp with time zone NOT NULL,
    CONSTRAINT jet_bookmark_user_check CHECK (("user" >= 0))
);


ALTER TABLE jet_bookmark OWNER TO digimundo;

--
-- Name: jet_bookmark_id_seq; Type: SEQUENCE; Schema: public; Owner: digimundo
--

CREATE SEQUENCE jet_bookmark_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE jet_bookmark_id_seq OWNER TO digimundo;

--
-- Name: jet_bookmark_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: digimundo
--

ALTER SEQUENCE jet_bookmark_id_seq OWNED BY jet_bookmark.id;


--
-- Name: jet_pinnedapplication; Type: TABLE; Schema: public; Owner: digimundo
--

CREATE TABLE jet_pinnedapplication (
    id integer NOT NULL,
    app_label character varying(255) NOT NULL,
    "user" integer NOT NULL,
    date_add timestamp with time zone NOT NULL,
    CONSTRAINT jet_pinnedapplication_user_check CHECK (("user" >= 0))
);


ALTER TABLE jet_pinnedapplication OWNER TO digimundo;

--
-- Name: jet_pinnedapplication_id_seq; Type: SEQUENCE; Schema: public; Owner: digimundo
--

CREATE SEQUENCE jet_pinnedapplication_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE jet_pinnedapplication_id_seq OWNER TO digimundo;

--
-- Name: jet_pinnedapplication_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: digimundo
--

ALTER SEQUENCE jet_pinnedapplication_id_seq OWNED BY jet_pinnedapplication.id;


--
-- Name: kitchen_processedproduct; Type: TABLE; Schema: public; Owner: digimundo
--

CREATE TABLE kitchen_processedproduct (
    id integer NOT NULL,
    created_at timestamp with time zone NOT NULL,
    prepared_at timestamp with time zone,
    status character varying(10) NOT NULL,
    ticket_id integer NOT NULL
);


ALTER TABLE kitchen_processedproduct OWNER TO digimundo;

--
-- Name: kitchen_processedproduct_id_seq; Type: SEQUENCE; Schema: public; Owner: digimundo
--

CREATE SEQUENCE kitchen_processedproduct_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE kitchen_processedproduct_id_seq OWNER TO digimundo;

--
-- Name: kitchen_processedproduct_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: digimundo
--

ALTER SEQUENCE kitchen_processedproduct_id_seq OWNED BY kitchen_processedproduct.id;


--
-- Name: orders_customerorder; Type: TABLE; Schema: public; Owner: digimundo
--

CREATE TABLE orders_customerorder (
    delivery_date timestamp with time zone NOT NULL,
    id integer NOT NULL,
    created_at timestamp with time zone NOT NULL,
    status character varying(10) NOT NULL,
    latitude double precision NOT NULL,
    longitude double precision NOT NULL,
    price numeric(12,2) NOT NULL,
    score integer NOT NULL,
    pin character varying(254) NOT NULL,
    customer_user_id integer NOT NULL,
    CONSTRAINT orders_customerorder_score_check CHECK ((score >= 0))
);


ALTER TABLE orders_customerorder OWNER TO digimundo;

--
-- Name: orders_customerorder_id_seq; Type: SEQUENCE; Schema: public; Owner: digimundo
--

CREATE SEQUENCE orders_customerorder_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE orders_customerorder_id_seq OWNER TO digimundo;

--
-- Name: orders_customerorder_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: digimundo
--

ALTER SEQUENCE orders_customerorder_id_seq OWNED BY orders_customerorder.id;


--
-- Name: orders_customerorderdetail; Type: TABLE; Schema: public; Owner: digimundo
--

CREATE TABLE orders_customerorderdetail (
    id integer NOT NULL,
    quantity integer NOT NULL,
    cartridge_id integer,
    customer_order_id integer NOT NULL,
    package_cartridge_id integer
);


ALTER TABLE orders_customerorderdetail OWNER TO digimundo;

--
-- Name: orders_customerorderdetail_id_seq; Type: SEQUENCE; Schema: public; Owner: digimundo
--

CREATE SEQUENCE orders_customerorderdetail_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE orders_customerorderdetail_id_seq OWNER TO digimundo;

--
-- Name: orders_customerorderdetail_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: digimundo
--

ALTER SEQUENCE orders_customerorderdetail_id_seq OWNED BY orders_customerorderdetail.id;


--
-- Name: orders_supplierorder; Type: TABLE; Schema: public; Owner: digimundo
--

CREATE TABLE orders_supplierorder (
    id integer NOT NULL,
    created_at timestamp with time zone NOT NULL,
    status character varying(2) NOT NULL,
    assigned_dealer_id integer NOT NULL
);


ALTER TABLE orders_supplierorder OWNER TO digimundo;

--
-- Name: orders_supplierorder_id_seq; Type: SEQUENCE; Schema: public; Owner: digimundo
--

CREATE SEQUENCE orders_supplierorder_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE orders_supplierorder_id_seq OWNER TO digimundo;

--
-- Name: orders_supplierorder_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: digimundo
--

ALTER SEQUENCE orders_supplierorder_id_seq OWNED BY orders_supplierorder.id;


--
-- Name: orders_supplierorderdetail; Type: TABLE; Schema: public; Owner: digimundo
--

CREATE TABLE orders_supplierorderdetail (
    id integer NOT NULL,
    quantity integer NOT NULL,
    cost numeric(12,2) NOT NULL,
    order_id integer NOT NULL,
    supplier_id integer NOT NULL,
    supply_id integer NOT NULL,
    CONSTRAINT orders_supplierorderdetail_quantity_check CHECK ((quantity >= 0))
);


ALTER TABLE orders_supplierorderdetail OWNER TO digimundo;

--
-- Name: orders_supplierorderdetail_id_seq; Type: SEQUENCE; Schema: public; Owner: digimundo
--

CREATE SEQUENCE orders_supplierorderdetail_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE orders_supplierorderdetail_id_seq OWNER TO digimundo;

--
-- Name: orders_supplierorderdetail_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: digimundo
--

ALTER SEQUENCE orders_supplierorderdetail_id_seq OWNED BY orders_supplierorderdetail.id;


--
-- Name: products_brand; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE products_brand (
    id integer NOT NULL,
    name character varying(90) NOT NULL,
    created_at timestamp with time zone NOT NULL
);


ALTER TABLE products_brand OWNER TO postgres;

--
-- Name: products_brand_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE products_brand_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE products_brand_id_seq OWNER TO postgres;

--
-- Name: products_brand_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE products_brand_id_seq OWNED BY products_brand.id;


--
-- Name: products_cartridge; Type: TABLE; Schema: public; Owner: digimundo
--

CREATE TABLE products_cartridge (
    id integer NOT NULL,
    name character varying(128) NOT NULL,
    description character varying(255) NOT NULL,
    price numeric(12,2) NOT NULL,
    category character varying(2) NOT NULL,
    subcategory character varying(2) NOT NULL,
    created_at timestamp with time zone NOT NULL,
    image character varying(255) NOT NULL,
    is_active boolean NOT NULL,
    kitchen_assembly_id integer
);


ALTER TABLE products_cartridge OWNER TO digimundo;

--
-- Name: products_cartridge_id_seq; Type: SEQUENCE; Schema: public; Owner: digimundo
--

CREATE SEQUENCE products_cartridge_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE products_cartridge_id_seq OWNER TO digimundo;

--
-- Name: products_cartridge_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: digimundo
--

ALTER SEQUENCE products_cartridge_id_seq OWNED BY products_cartridge.id;


--
-- Name: products_cartridgerecipe; Type: TABLE; Schema: public; Owner: digimundo
--

CREATE TABLE products_cartridgerecipe (
    id integer NOT NULL,
    quantity integer NOT NULL,
    cartridge_id integer NOT NULL,
    supply_id integer NOT NULL
);


ALTER TABLE products_cartridgerecipe OWNER TO digimundo;

--
-- Name: products_cartridgerecipe_id_seq; Type: SEQUENCE; Schema: public; Owner: digimundo
--

CREATE SEQUENCE products_cartridgerecipe_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE products_cartridgerecipe_id_seq OWNER TO digimundo;

--
-- Name: products_cartridgerecipe_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: digimundo
--

ALTER SEQUENCE products_cartridgerecipe_id_seq OWNED BY products_cartridgerecipe.id;


--
-- Name: products_extraingredient; Type: TABLE; Schema: public; Owner: digimundo
--

CREATE TABLE products_extraingredient (
    id integer NOT NULL,
    cost numeric(12,2) NOT NULL,
    ingredient_id integer,
    quantity smallint NOT NULL,
    CONSTRAINT products_extraingredient_quantity_check CHECK ((quantity >= 0))
);


ALTER TABLE products_extraingredient OWNER TO digimundo;

--
-- Name: products_extraingredient_id_seq; Type: SEQUENCE; Schema: public; Owner: digimundo
--

CREATE SEQUENCE products_extraingredient_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE products_extraingredient_id_seq OWNER TO digimundo;

--
-- Name: products_extraingredient_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: digimundo
--

ALTER SEQUENCE products_extraingredient_id_seq OWNED BY products_extraingredient.id;


--
-- Name: products_kitchenassembly; Type: TABLE; Schema: public; Owner: digimundo
--

CREATE TABLE products_kitchenassembly (
    id integer NOT NULL,
    name character varying(2) NOT NULL
);


ALTER TABLE products_kitchenassembly OWNER TO digimundo;

--
-- Name: products_kitchenassembly_id_seq; Type: SEQUENCE; Schema: public; Owner: digimundo
--

CREATE SEQUENCE products_kitchenassembly_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE products_kitchenassembly_id_seq OWNER TO digimundo;

--
-- Name: products_kitchenassembly_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: digimundo
--

ALTER SEQUENCE products_kitchenassembly_id_seq OWNED BY products_kitchenassembly.id;


--
-- Name: products_packagecartridge; Type: TABLE; Schema: public; Owner: digimundo
--

CREATE TABLE products_packagecartridge (
    id integer NOT NULL,
    name character varying(90) NOT NULL,
    description character varying(255) NOT NULL,
    price numeric(12,2) NOT NULL,
    is_active boolean NOT NULL,
    created_at timestamp with time zone NOT NULL,
    image character varying(100) NOT NULL
);


ALTER TABLE products_packagecartridge OWNER TO digimundo;

--
-- Name: products_packagecartridge_id_seq; Type: SEQUENCE; Schema: public; Owner: digimundo
--

CREATE SEQUENCE products_packagecartridge_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE products_packagecartridge_id_seq OWNER TO digimundo;

--
-- Name: products_packagecartridge_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: digimundo
--

ALTER SEQUENCE products_packagecartridge_id_seq OWNED BY products_packagecartridge.id;


--
-- Name: products_packagecartridgerecipe; Type: TABLE; Schema: public; Owner: digimundo
--

CREATE TABLE products_packagecartridgerecipe (
    id integer NOT NULL,
    quantity integer NOT NULL,
    cartridge_id integer NOT NULL,
    package_cartridge_id integer NOT NULL
);


ALTER TABLE products_packagecartridgerecipe OWNER TO digimundo;

--
-- Name: products_packagecartridgerecipe_id_seq; Type: SEQUENCE; Schema: public; Owner: digimundo
--

CREATE SEQUENCE products_packagecartridgerecipe_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE products_packagecartridgerecipe_id_seq OWNER TO digimundo;

--
-- Name: products_packagecartridgerecipe_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: digimundo
--

ALTER SEQUENCE products_packagecartridgerecipe_id_seq OWNED BY products_packagecartridgerecipe.id;


--
-- Name: products_presentation; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE products_presentation (
    id integer NOT NULL,
    measurement_quantity double precision NOT NULL,
    measurement_unit character varying(10) NOT NULL,
    presentation_unit character varying(10) NOT NULL,
    presentation_cost double precision NOT NULL,
    supply_id integer NOT NULL,
    on_warehouse integer NOT NULL,
    on_assembly integer NOT NULL
);


ALTER TABLE products_presentation OWNER TO postgres;

--
-- Name: products_presentation_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE products_presentation_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE products_presentation_id_seq OWNER TO postgres;

--
-- Name: products_presentation_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE products_presentation_id_seq OWNED BY products_presentation.id;


--
-- Name: products_shoplist; Type: TABLE; Schema: public; Owner: digimundo
--

CREATE TABLE products_shoplist (
    id integer NOT NULL,
    created_at date NOT NULL,
    status character varying(15) NOT NULL
);


ALTER TABLE products_shoplist OWNER TO digimundo;

--
-- Name: products_shoplist_id_seq; Type: SEQUENCE; Schema: public; Owner: digimundo
--

CREATE SEQUENCE products_shoplist_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE products_shoplist_id_seq OWNER TO digimundo;

--
-- Name: products_shoplist_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: digimundo
--

ALTER SEQUENCE products_shoplist_id_seq OWNED BY products_shoplist.id;


--
-- Name: products_shoplistdetail; Type: TABLE; Schema: public; Owner: digimundo
--

CREATE TABLE products_shoplistdetail (
    id integer NOT NULL,
    status character varying(15) NOT NULL,
    quantity integer NOT NULL,
    deliver_day timestamp with time zone,
    presentation_id integer NOT NULL,
    shop_list_id integer NOT NULL
);


ALTER TABLE products_shoplistdetail OWNER TO digimundo;

--
-- Name: products_shoplistdetail_id_seq; Type: SEQUENCE; Schema: public; Owner: digimundo
--

CREATE SEQUENCE products_shoplistdetail_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE products_shoplistdetail_id_seq OWNER TO digimundo;

--
-- Name: products_shoplistdetail_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: digimundo
--

ALTER SEQUENCE products_shoplistdetail_id_seq OWNED BY products_shoplistdetail.id;


--
-- Name: products_suppliescategory; Type: TABLE; Schema: public; Owner: digimundo
--

CREATE TABLE products_suppliescategory (
    id integer NOT NULL,
    name character varying(125) NOT NULL,
    image character varying(100) NOT NULL
);


ALTER TABLE products_suppliescategory OWNER TO digimundo;

--
-- Name: products_suppliescategory_id_seq; Type: SEQUENCE; Schema: public; Owner: digimundo
--

CREATE SEQUENCE products_suppliescategory_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE products_suppliescategory_id_seq OWNER TO digimundo;

--
-- Name: products_suppliescategory_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: digimundo
--

ALTER SEQUENCE products_suppliescategory_id_seq OWNED BY products_suppliescategory.id;


--
-- Name: products_supply; Type: TABLE; Schema: public; Owner: digimundo
--

CREATE TABLE products_supply (
    id integer NOT NULL,
    name character varying(125) NOT NULL,
    barcode bigint,
    storage_required character varying(2) NOT NULL,
    optimal_duration integer NOT NULL,
    optimal_duration_unit character varying(2) NOT NULL,
    created_at timestamp with time zone NOT NULL,
    image character varying(100) NOT NULL,
    category_id integer NOT NULL,
    location_id integer NOT NULL,
    supplier_id integer NOT NULL
);


ALTER TABLE products_supply OWNER TO digimundo;

--
-- Name: products_supply_id_seq; Type: SEQUENCE; Schema: public; Owner: digimundo
--

CREATE SEQUENCE products_supply_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE products_supply_id_seq OWNER TO digimundo;

--
-- Name: products_supply_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: digimundo
--

ALTER SEQUENCE products_supply_id_seq OWNED BY products_supply.id;


--
-- Name: products_supplylocation; Type: TABLE; Schema: public; Owner: digimundo
--

CREATE TABLE products_supplylocation (
    id integer NOT NULL,
    location character varying(90) NOT NULL,
    branch_office_id integer NOT NULL
);


ALTER TABLE products_supplylocation OWNER TO digimundo;

--
-- Name: products_supplylocation_id_seq; Type: SEQUENCE; Schema: public; Owner: digimundo
--

CREATE SEQUENCE products_supplylocation_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE products_supplylocation_id_seq OWNER TO digimundo;

--
-- Name: products_supplylocation_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: digimundo
--

ALTER SEQUENCE products_supplylocation_id_seq OWNED BY products_supplylocation.id;


--
-- Name: sales_cartridgeticketdetail; Type: TABLE; Schema: public; Owner: digimundo
--

CREATE TABLE sales_cartridgeticketdetail (
    id integer NOT NULL,
    quantity integer NOT NULL,
    price numeric(12,2) NOT NULL,
    cartridge_id integer NOT NULL,
    ticket_base_id integer NOT NULL
);


ALTER TABLE sales_cartridgeticketdetail OWNER TO digimundo;

--
-- Name: sales_cartridgeticketdetail_id_seq; Type: SEQUENCE; Schema: public; Owner: digimundo
--

CREATE SEQUENCE sales_cartridgeticketdetail_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE sales_cartridgeticketdetail_id_seq OWNER TO digimundo;

--
-- Name: sales_cartridgeticketdetail_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: digimundo
--

ALTER SEQUENCE sales_cartridgeticketdetail_id_seq OWNED BY sales_cartridgeticketdetail.id;


--
-- Name: sales_packagecartridgeticketdetail; Type: TABLE; Schema: public; Owner: digimundo
--

CREATE TABLE sales_packagecartridgeticketdetail (
    id integer NOT NULL,
    quantity smallint NOT NULL,
    price numeric(12,2) NOT NULL,
    package_cartridge_id integer NOT NULL,
    ticket_base_id integer NOT NULL,
    CONSTRAINT sales_packagecartridgeticketdetail_quantity_check CHECK ((quantity >= 0))
);


ALTER TABLE sales_packagecartridgeticketdetail OWNER TO digimundo;

--
-- Name: sales_packagecartridgeticketdetail_id_seq; Type: SEQUENCE; Schema: public; Owner: digimundo
--

CREATE SEQUENCE sales_packagecartridgeticketdetail_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE sales_packagecartridgeticketdetail_id_seq OWNER TO digimundo;

--
-- Name: sales_packagecartridgeticketdetail_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: digimundo
--

ALTER SEQUENCE sales_packagecartridgeticketdetail_id_seq OWNED BY sales_packagecartridgeticketdetail.id;


--
-- Name: sales_ticketbase; Type: TABLE; Schema: public; Owner: digimundo
--

CREATE TABLE sales_ticketbase (
    id integer NOT NULL,
    created_at timestamp with time zone NOT NULL,
    payment_type character varying(2) NOT NULL,
    order_number integer NOT NULL,
    is_active boolean NOT NULL
);


ALTER TABLE sales_ticketbase OWNER TO digimundo;

--
-- Name: sales_ticketbase_id_seq; Type: SEQUENCE; Schema: public; Owner: digimundo
--

CREATE SEQUENCE sales_ticketbase_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE sales_ticketbase_id_seq OWNER TO digimundo;

--
-- Name: sales_ticketbase_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: digimundo
--

ALTER SEQUENCE sales_ticketbase_id_seq OWNED BY sales_ticketbase.id;


--
-- Name: sales_ticketextraingredient; Type: TABLE; Schema: public; Owner: digimundo
--

CREATE TABLE sales_ticketextraingredient (
    id integer NOT NULL,
    price numeric(12,2) NOT NULL,
    extra_ingredient_id integer NOT NULL,
    quantity smallint NOT NULL,
    cartridge_ticket_detail_id integer,
    CONSTRAINT sales_ticketextraingredient_quantity_check CHECK ((quantity >= 0))
);


ALTER TABLE sales_ticketextraingredient OWNER TO digimundo;

--
-- Name: sales_ticketextraingredient_id_seq; Type: SEQUENCE; Schema: public; Owner: digimundo
--

CREATE SEQUENCE sales_ticketextraingredient_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE sales_ticketextraingredient_id_seq OWNER TO digimundo;

--
-- Name: sales_ticketextraingredient_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: digimundo
--

ALTER SEQUENCE sales_ticketextraingredient_id_seq OWNED BY sales_ticketextraingredient.id;


--
-- Name: sales_ticketorder; Type: TABLE; Schema: public; Owner: digimundo
--

CREATE TABLE sales_ticketorder (
    ticket_id integer NOT NULL,
    customer_id integer NOT NULL
);


ALTER TABLE sales_ticketorder OWNER TO digimundo;

--
-- Name: sales_ticketpos; Type: TABLE; Schema: public; Owner: digimundo
--

CREATE TABLE sales_ticketpos (
    ticket_id integer NOT NULL,
    cashier_id integer NOT NULL
);


ALTER TABLE sales_ticketpos OWNER TO digimundo;

--
-- Name: users_customerprofile; Type: TABLE; Schema: public; Owner: digimundo
--

CREATE TABLE users_customerprofile (
    user_ptr_id integer NOT NULL,
    phone_number character varying(10) NOT NULL,
    address character varying(255) NOT NULL,
    longitude character varying(30) NOT NULL,
    latitude character varying(30) NOT NULL,
    first_dabba boolean NOT NULL,
    "references" character varying(255) NOT NULL,
    avatar character varying(100),
    birthdate date NOT NULL,
    gender character varying(2) NOT NULL
);


ALTER TABLE users_customerprofile OWNER TO digimundo;

--
-- Name: users_user; Type: TABLE; Schema: public; Owner: digimundo
--

CREATE TABLE users_user (
    id integer NOT NULL,
    password character varying(128) NOT NULL,
    last_login timestamp with time zone,
    is_superuser boolean NOT NULL,
    username character varying(150) NOT NULL,
    first_name character varying(30) NOT NULL,
    last_name character varying(150) NOT NULL,
    email character varying(254) NOT NULL,
    is_staff boolean NOT NULL,
    is_active boolean NOT NULL,
    date_joined timestamp with time zone NOT NULL,
    coins numeric(20,4) NOT NULL
);


ALTER TABLE users_user OWNER TO digimundo;

--
-- Name: users_user_groups; Type: TABLE; Schema: public; Owner: digimundo
--

CREATE TABLE users_user_groups (
    id integer NOT NULL,
    user_id integer NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE users_user_groups OWNER TO digimundo;

--
-- Name: users_user_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: digimundo
--

CREATE SEQUENCE users_user_groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE users_user_groups_id_seq OWNER TO digimundo;

--
-- Name: users_user_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: digimundo
--

ALTER SEQUENCE users_user_groups_id_seq OWNED BY users_user_groups.id;


--
-- Name: users_user_id_seq; Type: SEQUENCE; Schema: public; Owner: digimundo
--

CREATE SEQUENCE users_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE users_user_id_seq OWNER TO digimundo;

--
-- Name: users_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: digimundo
--

ALTER SEQUENCE users_user_id_seq OWNED BY users_user.id;


--
-- Name: users_user_user_permissions; Type: TABLE; Schema: public; Owner: digimundo
--

CREATE TABLE users_user_user_permissions (
    id integer NOT NULL,
    user_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE users_user_user_permissions OWNER TO digimundo;

--
-- Name: users_user_user_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: digimundo
--

CREATE SEQUENCE users_user_user_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE users_user_user_permissions_id_seq OWNER TO digimundo;

--
-- Name: users_user_user_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: digimundo
--

ALTER SEQUENCE users_user_user_permissions_id_seq OWNED BY users_user_user_permissions.id;


--
-- Name: users_usermovements; Type: TABLE; Schema: public; Owner: digimundo
--

CREATE TABLE users_usermovements (
    id integer NOT NULL,
    "user" character varying(20) NOT NULL,
    category character varying(20) NOT NULL,
    creation_date date NOT NULL
);


ALTER TABLE users_usermovements OWNER TO digimundo;

--
-- Name: users_usermovements_id_seq; Type: SEQUENCE; Schema: public; Owner: digimundo
--

CREATE SEQUENCE users_usermovements_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE users_usermovements_id_seq OWNER TO digimundo;

--
-- Name: users_usermovements_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: digimundo
--

ALTER SEQUENCE users_usermovements_id_seq OWNED BY users_usermovements.id;


--
-- Name: auth_group id; Type: DEFAULT; Schema: public; Owner: digimundo
--

ALTER TABLE ONLY auth_group ALTER COLUMN id SET DEFAULT nextval('auth_group_id_seq'::regclass);


--
-- Name: auth_group_permissions id; Type: DEFAULT; Schema: public; Owner: digimundo
--

ALTER TABLE ONLY auth_group_permissions ALTER COLUMN id SET DEFAULT nextval('auth_group_permissions_id_seq'::regclass);


--
-- Name: auth_permission id; Type: DEFAULT; Schema: public; Owner: digimundo
--

ALTER TABLE ONLY auth_permission ALTER COLUMN id SET DEFAULT nextval('auth_permission_id_seq'::regclass);


--
-- Name: branchoffices_branchoffice id; Type: DEFAULT; Schema: public; Owner: digimundo
--

ALTER TABLE ONLY branchoffices_branchoffice ALTER COLUMN id SET DEFAULT nextval('branchoffices_branchoffice_id_seq'::regclass);


--
-- Name: branchoffices_supplier id; Type: DEFAULT; Schema: public; Owner: digimundo
--

ALTER TABLE ONLY branchoffices_supplier ALTER COLUMN id SET DEFAULT nextval('branchoffices_supplier_id_seq'::regclass);


--
-- Name: diners_accesslog id; Type: DEFAULT; Schema: public; Owner: digimundo
--

ALTER TABLE ONLY diners_accesslog ALTER COLUMN id SET DEFAULT nextval('diners_accesslog_id_seq'::regclass);


--
-- Name: diners_diner id; Type: DEFAULT; Schema: public; Owner: digimundo
--

ALTER TABLE ONLY diners_diner ALTER COLUMN id SET DEFAULT nextval('diners_diner_id_seq'::regclass);


--
-- Name: diners_elementtoevaluate id; Type: DEFAULT; Schema: public; Owner: digimundo
--

ALTER TABLE ONLY diners_elementtoevaluate ALTER COLUMN id SET DEFAULT nextval('diners_elementtoevaluate_id_seq'::regclass);


--
-- Name: diners_satisfactionrating id; Type: DEFAULT; Schema: public; Owner: digimundo
--

ALTER TABLE ONLY diners_satisfactionrating ALTER COLUMN id SET DEFAULT nextval('diners_satisfactionrating_id_seq'::regclass);


--
-- Name: diners_satisfactionrating_elements id; Type: DEFAULT; Schema: public; Owner: digimundo
--

ALTER TABLE ONLY diners_satisfactionrating_elements ALTER COLUMN id SET DEFAULT nextval('diners_satisfactionrating_elements_id_seq'::regclass);


--
-- Name: django_admin_log id; Type: DEFAULT; Schema: public; Owner: digimundo
--

ALTER TABLE ONLY django_admin_log ALTER COLUMN id SET DEFAULT nextval('django_admin_log_id_seq'::regclass);


--
-- Name: django_content_type id; Type: DEFAULT; Schema: public; Owner: digimundo
--

ALTER TABLE ONLY django_content_type ALTER COLUMN id SET DEFAULT nextval('django_content_type_id_seq'::regclass);


--
-- Name: django_migrations id; Type: DEFAULT; Schema: public; Owner: digimundo
--

ALTER TABLE ONLY django_migrations ALTER COLUMN id SET DEFAULT nextval('django_migrations_id_seq'::regclass);


--
-- Name: django_site id; Type: DEFAULT; Schema: public; Owner: digimundo
--

ALTER TABLE ONLY django_site ALTER COLUMN id SET DEFAULT nextval('django_site_id_seq'::regclass);


--
-- Name: fcm_device id; Type: DEFAULT; Schema: public; Owner: digimundo
--

ALTER TABLE ONLY fcm_device ALTER COLUMN id SET DEFAULT nextval('fcm_device_id_seq'::regclass);


--
-- Name: jet_bookmark id; Type: DEFAULT; Schema: public; Owner: digimundo
--

ALTER TABLE ONLY jet_bookmark ALTER COLUMN id SET DEFAULT nextval('jet_bookmark_id_seq'::regclass);


--
-- Name: jet_pinnedapplication id; Type: DEFAULT; Schema: public; Owner: digimundo
--

ALTER TABLE ONLY jet_pinnedapplication ALTER COLUMN id SET DEFAULT nextval('jet_pinnedapplication_id_seq'::regclass);


--
-- Name: kitchen_processedproduct id; Type: DEFAULT; Schema: public; Owner: digimundo
--

ALTER TABLE ONLY kitchen_processedproduct ALTER COLUMN id SET DEFAULT nextval('kitchen_processedproduct_id_seq'::regclass);


--
-- Name: orders_customerorder id; Type: DEFAULT; Schema: public; Owner: digimundo
--

ALTER TABLE ONLY orders_customerorder ALTER COLUMN id SET DEFAULT nextval('orders_customerorder_id_seq'::regclass);


--
-- Name: orders_customerorderdetail id; Type: DEFAULT; Schema: public; Owner: digimundo
--

ALTER TABLE ONLY orders_customerorderdetail ALTER COLUMN id SET DEFAULT nextval('orders_customerorderdetail_id_seq'::regclass);


--
-- Name: orders_supplierorder id; Type: DEFAULT; Schema: public; Owner: digimundo
--

ALTER TABLE ONLY orders_supplierorder ALTER COLUMN id SET DEFAULT nextval('orders_supplierorder_id_seq'::regclass);


--
-- Name: orders_supplierorderdetail id; Type: DEFAULT; Schema: public; Owner: digimundo
--

ALTER TABLE ONLY orders_supplierorderdetail ALTER COLUMN id SET DEFAULT nextval('orders_supplierorderdetail_id_seq'::regclass);


--
-- Name: products_brand id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY products_brand ALTER COLUMN id SET DEFAULT nextval('products_brand_id_seq'::regclass);


--
-- Name: products_cartridge id; Type: DEFAULT; Schema: public; Owner: digimundo
--

ALTER TABLE ONLY products_cartridge ALTER COLUMN id SET DEFAULT nextval('products_cartridge_id_seq'::regclass);


--
-- Name: products_cartridgerecipe id; Type: DEFAULT; Schema: public; Owner: digimundo
--

ALTER TABLE ONLY products_cartridgerecipe ALTER COLUMN id SET DEFAULT nextval('products_cartridgerecipe_id_seq'::regclass);


--
-- Name: products_extraingredient id; Type: DEFAULT; Schema: public; Owner: digimundo
--

ALTER TABLE ONLY products_extraingredient ALTER COLUMN id SET DEFAULT nextval('products_extraingredient_id_seq'::regclass);


--
-- Name: products_kitchenassembly id; Type: DEFAULT; Schema: public; Owner: digimundo
--

ALTER TABLE ONLY products_kitchenassembly ALTER COLUMN id SET DEFAULT nextval('products_kitchenassembly_id_seq'::regclass);


--
-- Name: products_packagecartridge id; Type: DEFAULT; Schema: public; Owner: digimundo
--

ALTER TABLE ONLY products_packagecartridge ALTER COLUMN id SET DEFAULT nextval('products_packagecartridge_id_seq'::regclass);


--
-- Name: products_packagecartridgerecipe id; Type: DEFAULT; Schema: public; Owner: digimundo
--

ALTER TABLE ONLY products_packagecartridgerecipe ALTER COLUMN id SET DEFAULT nextval('products_packagecartridgerecipe_id_seq'::regclass);


--
-- Name: products_presentation id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY products_presentation ALTER COLUMN id SET DEFAULT nextval('products_presentation_id_seq'::regclass);


--
-- Name: products_shoplist id; Type: DEFAULT; Schema: public; Owner: digimundo
--

ALTER TABLE ONLY products_shoplist ALTER COLUMN id SET DEFAULT nextval('products_shoplist_id_seq'::regclass);


--
-- Name: products_shoplistdetail id; Type: DEFAULT; Schema: public; Owner: digimundo
--

ALTER TABLE ONLY products_shoplistdetail ALTER COLUMN id SET DEFAULT nextval('products_shoplistdetail_id_seq'::regclass);


--
-- Name: products_suppliescategory id; Type: DEFAULT; Schema: public; Owner: digimundo
--

ALTER TABLE ONLY products_suppliescategory ALTER COLUMN id SET DEFAULT nextval('products_suppliescategory_id_seq'::regclass);


--
-- Name: products_supply id; Type: DEFAULT; Schema: public; Owner: digimundo
--

ALTER TABLE ONLY products_supply ALTER COLUMN id SET DEFAULT nextval('products_supply_id_seq'::regclass);


--
-- Name: products_supplylocation id; Type: DEFAULT; Schema: public; Owner: digimundo
--

ALTER TABLE ONLY products_supplylocation ALTER COLUMN id SET DEFAULT nextval('products_supplylocation_id_seq'::regclass);


--
-- Name: sales_cartridgeticketdetail id; Type: DEFAULT; Schema: public; Owner: digimundo
--

ALTER TABLE ONLY sales_cartridgeticketdetail ALTER COLUMN id SET DEFAULT nextval('sales_cartridgeticketdetail_id_seq'::regclass);


--
-- Name: sales_packagecartridgeticketdetail id; Type: DEFAULT; Schema: public; Owner: digimundo
--

ALTER TABLE ONLY sales_packagecartridgeticketdetail ALTER COLUMN id SET DEFAULT nextval('sales_packagecartridgeticketdetail_id_seq'::regclass);


--
-- Name: sales_ticketbase id; Type: DEFAULT; Schema: public; Owner: digimundo
--

ALTER TABLE ONLY sales_ticketbase ALTER COLUMN id SET DEFAULT nextval('sales_ticketbase_id_seq'::regclass);


--
-- Name: sales_ticketextraingredient id; Type: DEFAULT; Schema: public; Owner: digimundo
--

ALTER TABLE ONLY sales_ticketextraingredient ALTER COLUMN id SET DEFAULT nextval('sales_ticketextraingredient_id_seq'::regclass);


--
-- Name: users_user id; Type: DEFAULT; Schema: public; Owner: digimundo
--

ALTER TABLE ONLY users_user ALTER COLUMN id SET DEFAULT nextval('users_user_id_seq'::regclass);


--
-- Name: users_user_groups id; Type: DEFAULT; Schema: public; Owner: digimundo
--

ALTER TABLE ONLY users_user_groups ALTER COLUMN id SET DEFAULT nextval('users_user_groups_id_seq'::regclass);


--
-- Name: users_user_user_permissions id; Type: DEFAULT; Schema: public; Owner: digimundo
--

ALTER TABLE ONLY users_user_user_permissions ALTER COLUMN id SET DEFAULT nextval('users_user_user_permissions_id_seq'::regclass);


--
-- Name: users_usermovements id; Type: DEFAULT; Schema: public; Owner: digimundo
--

ALTER TABLE ONLY users_usermovements ALTER COLUMN id SET DEFAULT nextval('users_usermovements_id_seq'::regclass);


--
-- Data for Name: auth_group; Type: TABLE DATA; Schema: public; Owner: digimundo
--

COPY auth_group (id, name) FROM stdin;
\.


--
-- Name: auth_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: digimundo
--

SELECT pg_catalog.setval('auth_group_id_seq', 1, false);


--
-- Data for Name: auth_group_permissions; Type: TABLE DATA; Schema: public; Owner: digimundo
--

COPY auth_group_permissions (id, group_id, permission_id) FROM stdin;
\.


--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: digimundo
--

SELECT pg_catalog.setval('auth_group_permissions_id_seq', 1, false);


--
-- Data for Name: auth_permission; Type: TABLE DATA; Schema: public; Owner: digimundo
--

COPY auth_permission (id, name, content_type_id, codename) FROM stdin;
1	Can add pinned application	1	add_pinnedapplication
2	Can change pinned application	1	change_pinnedapplication
3	Can delete pinned application	1	delete_pinnedapplication
4	Can add bookmark	2	add_bookmark
5	Can change bookmark	2	change_bookmark
6	Can delete bookmark	2	delete_bookmark
7	Can add log entry	3	add_logentry
8	Can change log entry	3	change_logentry
9	Can delete log entry	3	delete_logentry
10	Can add group	4	add_group
11	Can change group	4	change_group
12	Can delete group	4	delete_group
13	Can add permission	5	add_permission
14	Can change permission	5	change_permission
15	Can delete permission	5	delete_permission
16	Can add content type	6	add_contenttype
17	Can change content type	6	change_contenttype
18	Can delete content type	6	delete_contenttype
19	Can add session	7	add_session
20	Can change session	7	change_session
21	Can delete session	7	delete_session
22	Can add site	8	add_site
23	Can change site	8	change_site
24	Can delete site	8	delete_site
25	Can add device	9	add_device
26	Can change device	9	change_device
27	Can delete device	9	delete_device
28	Can add user	10	add_user
29	Can change user	10	change_user
30	Can delete user	10	delete_user
31	Puede Vender	10	can_sell
32	Puede Ver Ventas	10	can_see_sales
33	Puede Ver Comandas	10	can_see_commands
34	Puede Ensamblar	10	can_assemble
35	Puede Ver Insumos	10	can_see_suplies
36	Puede Ver Cartuchos	10	can_see_cartrdiges
37	Puede Ver Paquetes	10	can_see_packages
38	Puede Ver Estadísticas de Almacén	10	can_see_storage_analytics
39	Puede Ver Comentarios	10	can_see_suggestions
40	Puede Ver Estadísticas de Comentarios	10	can_see_suggestions_analytics
41	Can add Perfil de Usuario	11	add_customerprofile
42	Can change Perfil de Usuario	11	change_customerprofile
43	Can delete Perfil de Usuario	11	delete_customerprofile
44	Can add user movements	12	add_usermovements
45	Can change user movements	12	change_usermovements
46	Can delete user movements	12	delete_usermovements
47	Can add Sucursal	13	add_branchoffice
48	Can change Sucursal	13	change_branchoffice
49	Can delete Sucursal	13	delete_branchoffice
50	Can add Proveedor	14	add_supplier
51	Can change Proveedor	14	change_supplier
52	Can delete Proveedor	14	delete_supplier
53	Can add Punto de Venta	15	add_cashregister
54	Can change Punto de Venta	15	change_cashregister
55	Can delete Punto de Venta	15	delete_cashregister
56	Can add Categoría	16	add_suppliescategory
57	Can change Categoría	16	change_suppliescategory
58	Can delete Categoría	16	delete_suppliescategory
59	Can add Ubicación del Insumo	17	add_supplylocation
60	Can change Ubicación del Insumo	17	change_supplylocation
61	Can delete Ubicación del Insumo	17	delete_supplylocation
62	Can add Receta del Paquete	18	add_packagecartridgerecipe
63	Can change Receta del Paquete	18	change_packagecartridgerecipe
64	Can delete Receta del Paquete	18	delete_packagecartridgerecipe
65	Can add Paquete	19	add_packagecartridge
66	Can change Paquete	19	change_packagecartridge
67	Can delete Paquete	19	delete_packagecartridge
68	Can add Receta del Producto	20	add_cartridgerecipe
69	Can change Receta del Producto	20	change_cartridgerecipe
70	Can delete Receta del Producto	20	delete_cartridgerecipe
71	Can add Ingrediente Extra	21	add_extraingredient
72	Can change Ingrediente Extra	21	change_extraingredient
73	Can delete Ingrediente Extra	21	delete_extraingredient
74	Can add Producto	22	add_cartridge
75	Can change Producto	22	change_cartridge
76	Can delete Producto	22	delete_cartridge
77	Can add Insumo	23	add_supply
78	Can change Insumo	23	change_supply
79	Can delete Insumo	23	delete_supply
80	Can add Ticket Order 	24	add_ticketorder
81	Can change Ticket Order 	24	change_ticketorder
82	Can delete Ticket Order 	24	delete_ticketorder
83	Can add Ticket Details	25	add_ticketdetail
84	Can change Ticket Details	25	change_ticketdetail
85	Can delete Ticket Details	25	delete_ticketdetail
86	Can add Ticket Base	26	add_ticketbase
87	Can change Ticket Base	26	change_ticketbase
88	Can delete Ticket Base	26	delete_ticketbase
89	Can add ticket extra ingredient	27	add_ticketextraingredient
90	Can change ticket extra ingredient	27	change_ticketextraingredient
91	Can delete ticket extra ingredient	27	delete_ticketextraingredient
92	Can add Ticket POS 	28	add_ticketpos
93	Can change Ticket POS 	28	change_ticketpos
94	Can delete Ticket POS 	28	delete_ticketpos
95	Can add Detalles del Pedido a Proveedor	29	add_supplierorderdetail
96	Can change Detalles del Pedido a Proveedor	29	change_supplierorderdetail
97	Can delete Detalles del Pedido a Proveedor	29	delete_supplierorderdetail
98	Can add Pedido al Proveedor	30	add_supplierorder
99	Can change Pedido al Proveedor	30	change_supplierorder
100	Can delete Pedido al Proveedor	30	delete_supplierorder
101	Can add Pedido del Cliente	31	add_customerorder
102	Can change Pedido del Cliente	31	change_customerorder
103	Can delete Pedido del Cliente	31	delete_customerorder
104	Can add Detalles del Pedido del Cliente	32	add_customerorderdetail
105	Can change Detalles del Pedido del Cliente	32	change_customerorderdetail
106	Can delete Detalles del Pedido del Cliente	32	delete_customerorderdetail
107	Can add Productos	33	add_processedproduct
108	Can change Productos	33	change_processedproduct
109	Can delete Productos	33	delete_processedproduct
110	Can add Insumo en Almacén	34	add_warehouse
111	Can change Insumo en Almacén	34	change_warehouse
112	Can delete Insumo en Almacén	34	delete_warehouse
113	Can add Elemento a evaluar	35	add_elementtoevaluate
114	Can change Elemento a evaluar	35	change_elementtoevaluate
115	Can delete Elemento a evaluar	35	delete_elementtoevaluate
116	Can add Comensal	36	add_diner
117	Can change Comensal	36	change_diner
118	Can delete Comensal	36	delete_diner
119	Can add Índice de Satisfacción	37	add_satisfactionrating
120	Can change Índice de Satisfacción	37	change_satisfactionrating
121	Can delete Índice de Satisfacción	37	delete_satisfactionrating
122	Can add Control de Acceso	38	add_accesslog
123	Can change Control de Acceso	38	change_accesslog
124	Can delete Control de Acceso	38	delete_accesslog
125	Can add Cocina de Ensamble	39	add_kitchenassembly
126	Can change Cocina de Ensamble	39	change_kitchenassembly
127	Can delete Cocina de Ensamble	39	delete_kitchenassembly
128	Can add Detalle del Ticket para Cartuchos	40	add_cartridgeticketdetail
129	Can change Detalle del Ticket para Cartuchos	40	change_cartridgeticketdetail
130	Can delete Detalle del Ticket para Cartuchos	40	delete_cartridgeticketdetail
131	Can add Detalle del Ticket para Paquetes	41	add_packagecartridgeticketdetail
132	Can change Detalle del Ticket para Paquetes	41	change_packagecartridgeticketdetail
133	Can delete Detalle del Ticket para Paquetes	41	delete_packagecartridgeticketdetail
134	Can add Presentacion	42	add_presentation
135	Can change Presentacion	42	change_presentation
136	Can delete Presentacion	42	delete_presentation
137	Can add Lista de Compra	43	add_shoplist
138	Can change Lista de Compra	43	change_shoplist
139	Can delete Lista de Compra	43	delete_shoplist
140	Can add Lista de Compra-Detalles	44	add_shoplistdetail
141	Can change Lista de Compra-Detalles	44	change_shoplistdetail
142	Can delete Lista de Compra-Detalles	44	delete_shoplistdetail
143	Can add brand	45	add_brand
144	Can change brand	45	change_brand
145	Can delete brand	45	delete_brand
146	Can add Lista de Compra	46	add_shoplist
147	Can change Lista de Compra	46	change_shoplist
148	Can delete Lista de Compra	46	delete_shoplist
149	Can add Lista de Compra-Detalles	47	add_shoplistdetail
150	Can change Lista de Compra-Detalles	47	change_shoplistdetail
151	Can delete Lista de Compra-Detalles	47	delete_shoplistdetail
152	Can add Insumo en Almacén	48	add_warehouse
153	Can change Insumo en Almacén	48	change_warehouse
154	Can delete Insumo en Almacén	48	delete_warehouse
\.


--
-- Name: auth_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: digimundo
--

SELECT pg_catalog.setval('auth_permission_id_seq', 154, true);


--
-- Data for Name: branchoffices_branchoffice; Type: TABLE DATA; Schema: public; Owner: digimundo
--

COPY branchoffices_branchoffice (id, name, address, is_activate, manager_id) FROM stdin;
1	Satélite	Satélite	t	3
\.


--
-- Name: branchoffices_branchoffice_id_seq; Type: SEQUENCE SET; Schema: public; Owner: digimundo
--

SELECT pg_catalog.setval('branchoffices_branchoffice_id_seq', 1, true);


--
-- Data for Name: branchoffices_supplier; Type: TABLE DATA; Schema: public; Owner: digimundo
--

COPY branchoffices_supplier (id, name, image) FROM stdin;
1	Supplier 1	media/suppliers/no_img.png
2	Wallmart	media/suppliers/no_img_xKG7PEh.png
3	Verduleria Local	media/suppliers/no_img_c2MTNOK.png
4	A domicilio	media/suppliers/no_img_ygtyDdz.png
5	Costco	media/suppliers/no_img_yrIzQnN.png
6	Central de abasto	media/suppliers/no_img_nGcMG2a.png
7	Materias Primas	media/suppliers/no_img_K97YA6v.png
\.


--
-- Name: branchoffices_supplier_id_seq; Type: SEQUENCE SET; Schema: public; Owner: digimundo
--

SELECT pg_catalog.setval('branchoffices_supplier_id_seq', 7, true);


--
-- Data for Name: diners_accesslog; Type: TABLE DATA; Schema: public; Owner: digimundo
--

COPY diners_accesslog (id, "RFID", access_to_room, diner_id) FROM stdin;
\.


--
-- Name: diners_accesslog_id_seq; Type: SEQUENCE SET; Schema: public; Owner: digimundo
--

SELECT pg_catalog.setval('diners_accesslog_id_seq', 1, false);


--
-- Data for Name: diners_diner; Type: TABLE DATA; Schema: public; Owner: digimundo
--

COPY diners_diner (id, created_at, name, employee_number, "RFID") FROM stdin;
\.


--
-- Name: diners_diner_id_seq; Type: SEQUENCE SET; Schema: public; Owner: digimundo
--

SELECT pg_catalog.setval('diners_diner_id_seq', 1, false);


--
-- Data for Name: diners_elementtoevaluate; Type: TABLE DATA; Schema: public; Owner: digimundo
--

COPY diners_elementtoevaluate (id, element, priority) FROM stdin;
1	ROTI	10
7	PRECIOS	70
6	ENTREGA	60
5	SERVICIO	50
4	ENSALADA	40
3	LICUADO	30
2	AGUA	20
\.


--
-- Name: diners_elementtoevaluate_id_seq; Type: SEQUENCE SET; Schema: public; Owner: digimundo
--

SELECT pg_catalog.setval('diners_elementtoevaluate_id_seq', 7, true);


--
-- Data for Name: diners_satisfactionrating; Type: TABLE DATA; Schema: public; Owner: digimundo
--

COPY diners_satisfactionrating (id, satisfaction_rating, creation_date, suggestion) FROM stdin;
1	4	2017-09-26 16:48:14.316642-05	Me agradó demasiado el sabor del horchata y el Roti de Chilaquiles increíble!
2	3	2017-10-03 17:05:14.214276-05	Muy rico el de Chilaquiles
3	3	2017-10-04 05:46:15.079479-05	Excelentes productos, pero tardan demasiado para entregar!
4	4	2017-10-07 17:57:27.468853-05	Estuvo cool el roti de chilaquiles
\.


--
-- Data for Name: diners_satisfactionrating_elements; Type: TABLE DATA; Schema: public; Owner: digimundo
--

COPY diners_satisfactionrating_elements (id, satisfactionrating_id, elementtoevaluate_id) FROM stdin;
1	1	1
2	1	2
3	2	1
4	3	1
5	3	2
6	4	1
\.


--
-- Name: diners_satisfactionrating_elements_id_seq; Type: SEQUENCE SET; Schema: public; Owner: digimundo
--

SELECT pg_catalog.setval('diners_satisfactionrating_elements_id_seq', 6, true);


--
-- Name: diners_satisfactionrating_id_seq; Type: SEQUENCE SET; Schema: public; Owner: digimundo
--

SELECT pg_catalog.setval('diners_satisfactionrating_id_seq', 4, true);


--
-- Data for Name: django_admin_log; Type: TABLE DATA; Schema: public; Owner: digimundo
--

COPY django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) FROM stdin;
1	2017-08-04 18:16:45.31651-05	2	tester	1	[{"added": {}}]	10	1
2	2017-08-04 18:19:21.2485-05	3	tescaceo	1	[{"added": {}}]	10	1
3	2017-08-04 18:19:49.910786-05	4	lucy	1	[{"added": {}}]	10	1
4	2017-08-04 18:20:40.980268-05	1	Satélite	1	[{"added": {}}]	13	1
5	2017-08-04 18:48:59.694619-05	28	Agua de Fresa	2	[{"changed": {"fields": ["image"]}}]	22	1
6	2017-08-04 18:48:59.698839-05	29	Agua de Guayaba	2	[{"changed": {"fields": ["image"]}}]	22	1
7	2017-08-04 18:48:59.702683-05	32	Agua de Horchata	2	[{"changed": {"fields": ["image"]}}]	22	1
8	2017-08-04 18:48:59.70662-05	30	Agua de Limón	2	[{"changed": {"fields": ["image"]}}]	22	1
9	2017-08-04 18:48:59.710406-05	26	Agua de Melón	2	[{"changed": {"fields": ["image"]}}]	22	1
10	2017-08-04 18:48:59.714079-05	27	Agua de Papaya	2	[{"changed": {"fields": ["image"]}}]	22	1
11	2017-08-04 18:48:59.717715-05	25	Agua de Sandía	2	[{"changed": {"fields": ["image"]}}]	22	1
12	2017-08-04 18:55:23.106231-05	31	Avena con Manzana	2	[{"changed": {"fields": ["image"]}}]	22	1
13	2017-08-04 18:55:23.110092-05	7	Azteca	2	[{"changed": {"fields": ["image"]}}]	22	1
14	2017-08-04 18:55:23.113423-05	8	Calabazita	2	[{"changed": {"fields": ["image"]}}]	22	1
15	2017-08-04 18:55:23.116754-05	9	Carne con Salsa Agridulce	2	[{"changed": {"fields": ["image"]}}]	22	1
16	2017-08-04 18:55:23.120186-05	35	Champiñones con epazote	2	[{"changed": {"fields": ["image"]}}]	22	1
17	2017-08-04 18:55:23.123531-05	10	Champiñones con Salsa Agridulce	2	[{"changed": {"fields": ["image"]}}]	22	1
18	2017-08-04 18:55:23.136814-05	1	Chilaquiles	2	[{"changed": {"fields": ["image"]}}]	22	1
19	2017-08-04 18:55:23.14802-05	5	Choriqueso	2	[{"changed": {"fields": ["image"]}}]	22	1
20	2017-08-04 18:55:23.151574-05	12	Ensalada China	2	[{"changed": {"fields": ["image"]}}]	22	1
21	2017-08-04 18:55:23.154899-05	11	Ensalada de Fresa	2	[{"changed": {"fields": ["image"]}}]	22	1
22	2017-08-04 18:55:23.158189-05	13	Ensalada Suprema	2	[{"changed": {"fields": ["image"]}}]	22	1
23	2017-08-04 18:55:23.161488-05	4	Jamón	2	[{"changed": {"fields": ["image"]}}]	22	1
24	2017-08-04 18:55:59.353573-05	31	Avena con Manzana	2	[{"changed": {"fields": ["image"]}}]	22	1
25	2017-08-04 18:55:59.357891-05	7	Azteca	2	[{"changed": {"fields": ["image"]}}]	22	1
26	2017-08-04 18:55:59.361504-05	8	Calabazita	2	[{"changed": {"fields": ["image"]}}]	22	1
27	2017-08-04 18:55:59.365032-05	9	Carne con Salsa Agridulce	2	[{"changed": {"fields": ["image"]}}]	22	1
28	2017-08-04 18:55:59.368694-05	35	Champiñones con epazote	2	[{"changed": {"fields": ["image"]}}]	22	1
29	2017-08-04 18:55:59.372343-05	10	Champiñones con Salsa Agridulce	2	[{"changed": {"fields": ["image"]}}]	22	1
30	2017-08-04 18:56:49.219088-05	1	Chilaquiles	2	[{"changed": {"fields": ["image"]}}]	22	1
31	2017-08-04 18:56:49.223201-05	5	Choriqueso	2	[{"changed": {"fields": ["image"]}}]	22	1
32	2017-08-04 18:56:49.226485-05	12	Ensalada China	2	[{"changed": {"fields": ["image"]}}]	22	1
33	2017-08-04 18:56:49.230505-05	11	Ensalada de Fresa	2	[{"changed": {"fields": ["image"]}}]	22	1
34	2017-08-04 18:56:49.233969-05	13	Ensalada Suprema	2	[{"changed": {"fields": ["image"]}}]	22	1
35	2017-08-04 18:56:49.237497-05	4	Jamón	2	[{"changed": {"fields": ["image"]}}]	22	1
36	2017-08-04 18:58:13.858021-05	21	Jugo de Alfalfa con Pinguica	2	[{"changed": {"fields": ["image"]}}]	22	1
37	2017-08-04 18:58:13.861906-05	22	Jugo de Naranja	2	[{"changed": {"fields": ["image"]}}]	22	1
38	2017-08-04 18:58:13.86589-05	24	Jugo de Zanahoria	2	[{"changed": {"fields": ["image"]}}]	22	1
39	2017-08-04 18:58:13.869232-05	23	Jugo Verde	2	[{"changed": {"fields": ["image"]}}]	22	1
40	2017-08-04 18:58:13.872512-05	15	Licuado de Fresa	2	[{"changed": {"fields": ["image"]}}]	22	1
41	2017-08-04 18:58:13.875894-05	16	Licuado de Guayaba	2	[{"changed": {"fields": ["image"]}}]	22	1
42	2017-08-04 18:58:13.8792-05	33	Licuado de Mango con Leche	2	[{"changed": {"fields": ["image"]}}]	22	1
43	2017-08-04 18:58:13.883133-05	17	Licuado de Papaya	2	[{"changed": {"fields": ["image"]}}]	22	1
44	2017-08-04 18:58:13.88648-05	14	Licuado de Platano	2	[{"changed": {"fields": ["image"]}}]	22	1
45	2017-08-04 18:58:42.983357-05	15	Licuado de Fresa	2	[{"changed": {"fields": ["image"]}}]	22	1
46	2017-08-04 18:58:42.98747-05	16	Licuado de Guayaba	2	[{"changed": {"fields": ["image"]}}]	22	1
47	2017-08-04 18:58:42.991052-05	17	Licuado de Papaya	2	[{"changed": {"fields": ["image"]}}]	22	1
48	2017-08-04 18:58:42.994554-05	14	Licuado de Platano	2	[{"changed": {"fields": ["image"]}}]	22	1
49	2017-08-04 18:59:15.965074-05	19	Melón Picado	2	[{"changed": {"fields": ["image"]}}]	22	1
50	2017-08-04 18:59:15.969368-05	20	Papaya Picada	2	[{"changed": {"fields": ["image"]}}]	22	1
51	2017-08-04 18:59:15.973027-05	2	Pollo Mostaza	2	[{"changed": {"fields": ["image"]}}]	22	1
52	2017-08-04 18:59:15.97681-05	34	Rajas	2	[{"changed": {"fields": ["image"]}}]	22	1
53	2017-08-04 18:59:51.145391-05	18	Sandía Picada	2	[{"changed": {"fields": ["image"]}}]	22	1
54	2017-08-04 18:59:51.149771-05	3	Vegetariano	2	[{"changed": {"fields": ["image"]}}]	22	1
55	2017-08-05 11:14:00.839173-05	7	  	3		19	1
56	2017-08-05 11:20:36.118718-05	7	a	1	[{"added": {}}]	19	1
57	2017-08-05 11:20:44.28939-05	7	a	3		19	1
58	2017-08-05 11:21:45.969229-05	68	a	1	[{"added": {}}]	19	1
59	2017-08-05 11:21:50.494265-05	68	a	3		19	1
60	2017-08-06 14:11:47.333771-05	6	ozielfuego	2	[{"changed": {"fields": ["is_active"]}}]	10	1
61	2017-08-06 14:11:54.242589-05	6	ozielfuego	2	[{"changed": {"fields": ["is_superuser"]}}]	10	1
62	2017-08-21 14:01:38.219546-05	12	Ensalada China	2	[{"changed": {"fields": ["category"]}}]	22	1
63	2017-08-21 14:01:38.223151-05	11	Ensalada de Fresa	2	[{"changed": {"fields": ["category"]}}]	22	1
64	2017-08-21 14:01:38.226061-05	13	Ensalada Suprema	2	[{"changed": {"fields": ["category"]}}]	22	1
65	2017-08-21 18:17:52.579437-05	12	Ensalada China	2	[{"changed": {"fields": ["category"]}}]	22	1
66	2017-08-21 18:17:52.5834-05	11	Ensalada de Fresa	2	[{"changed": {"fields": ["category"]}}]	22	1
67	2017-08-21 18:17:52.586532-05	13	Ensalada Suprema	2	[{"changed": {"fields": ["category"]}}]	22	1
68	2017-08-21 18:51:53.010654-05	1	CO	1	[{"added": {}}]	39	1
69	2017-08-21 18:51:57.154255-05	2	CO	1	[{"added": {}}]	39	1
70	2017-08-21 18:51:59.588746-05	3	HO	1	[{"added": {}}]	39	1
71	2017-08-21 18:52:14.80856-05	2	CO	3		39	1
72	2017-08-21 18:58:26.515067-05	12	Ensalada China	2	[{"changed": {"fields": ["kitchen_assembly"]}}]	22	1
73	2017-08-21 18:58:39.379643-05	11	Ensalada de Fresa	2	[{"changed": {"fields": ["kitchen_assembly"]}}]	22	1
74	2017-08-21 18:58:44.638317-05	13	Ensalada Suprema	2	[{"changed": {"fields": ["kitchen_assembly"]}}]	22	1
75	2017-08-30 14:48:00.091531-05	8	airmaster	2	[{"changed": {"fields": ["is_active"]}}]	10	1
76	2017-08-31 11:36:07.131358-05	8	airmaster	2	[{"changed": {"fields": ["is_superuser", "is_staff"]}}]	10	1
77	2017-08-31 11:37:52.934742-05	8	airmaster	2	[{"changed": {"fields": ["is_staff"]}}]	10	1
78	2017-09-04 14:16:23.870139-05	9	damiancruz	2	[{"changed": {"fields": ["is_superuser", "is_active"]}}]	10	1
79	2017-09-11 11:43:50.395049-05	6	Tinga	1	[{"added": {}}]	22	1
80	2017-09-11 16:55:47.460524-05	71	Ensalada de Fresa Agua de Melón Melón Picado	2	[{"changed": {"fields": ["image"]}}, {"added": {"object": "1 Ensalada de Fresa", "name": "Receta del Paquete"}}, {"added": {"object": "1 Agua de Mel\\u00f3n", "name": "Receta del Paquete"}}, {"added": {"object": "1 Mel\\u00f3n Picado", "name": "Receta del Paquete"}}]	19	1
81	2017-09-11 16:56:31.377056-05	200	Azteca Papaya Picada Agua de Fresa	2	[{"changed": {"fields": ["image"]}}, {"added": {"object": "1 Azteca", "name": "Receta del Paquete"}}, {"added": {"object": "1 Papaya Picada", "name": "Receta del Paquete"}}, {"added": {"object": "1 Agua de Fresa", "name": "Receta del Paquete"}}]	19	1
82	2017-09-11 16:57:21.479312-05	70	Pollo Mostaza Sandía Picada Jugo de Alfalfa con Pinguica	2	[{"changed": {"fields": ["image"]}}, {"added": {"object": "1 Pollo Mostaza", "name": "Receta del Paquete"}}, {"added": {"object": "1 Sand\\u00eda Picada", "name": "Receta del Paquete"}}, {"added": {"object": "1 Jugo de Alfalfa con Pinguica", "name": "Receta del Paquete"}}]	19	1
83	2017-09-11 16:57:50.124717-05	69	Rajas Melón Picado Jugo de Alfalfa con Pinguica	2	[{"changed": {"fields": ["image"]}}, {"added": {"object": "1 Rajas", "name": "Receta del Paquete"}}, {"added": {"object": "1 Mel\\u00f3n Picado", "name": "Receta del Paquete"}}, {"added": {"object": "1 Jugo de Alfalfa con Pinguica", "name": "Receta del Paquete"}}]	19	1
84	2017-09-15 11:29:06.993825-05	37	Fruta Picada	1	[{"added": {}}]	22	1
85	2017-09-15 11:32:10.240315-05	37	Fruta Picada	2	[{"changed": {"fields": ["price"]}}]	22	1
86	2017-09-23 02:41:00.323096-05	28	Agua de Fresa	2	[{"changed": {"fields": ["image"]}}]	22	1
87	2017-09-23 02:41:13.821478-05	29	Agua de Guayaba	2	[{"changed": {"fields": ["image"]}}]	22	1
88	2017-09-23 02:41:52.67769-05	32	Agua de Horchata	2	[{"changed": {"fields": ["image"]}}]	22	1
89	2017-09-23 02:41:53.035473-05	30	Agua de Limón	2	[{"changed": {"fields": ["image"]}}]	22	1
90	2017-09-23 02:41:53.387285-05	26	Agua de Melón	2	[{"changed": {"fields": ["image"]}}]	22	1
91	2017-09-23 02:41:53.464397-05	27	Agua de Papaya	2	[{"changed": {"fields": ["image"]}}]	22	1
92	2017-09-23 02:41:53.506351-05	25	Agua de Sandía	2	[{"changed": {"fields": ["image"]}}]	22	1
93	2017-09-23 02:43:01.131141-05	31	Avena con Manzana	2	[{"changed": {"fields": ["image"]}}]	22	1
94	2017-09-23 02:44:23.633266-05	7	Azteca	2	[{"changed": {"fields": ["image"]}}]	22	1
95	2017-09-23 02:44:23.767723-05	8	Calabazita	2	[{"changed": {"fields": ["image"]}}]	22	1
96	2017-09-23 02:44:34.373408-05	8	Calabacita	2	[{"changed": {"fields": ["name"]}}]	22	1
97	2017-09-23 02:47:33.649451-05	9	Carne con Salsa Agridulce	2	[{"changed": {"fields": ["image"]}}]	22	1
98	2017-09-23 02:47:33.712935-05	35	Champiñones con epazote	2	[{"changed": {"fields": ["image"]}}]	22	1
99	2017-09-23 02:47:33.928593-05	10	Champiñones con Salsa Agridulce	2	[{"changed": {"fields": ["image"]}}]	22	1
100	2017-09-23 02:47:34.037042-05	1	Chilaquiles	2	[{"changed": {"fields": ["image"]}}]	22	1
101	2017-09-23 02:47:34.116899-05	5	Choriqueso	2	[{"changed": {"fields": ["image"]}}]	22	1
102	2017-09-23 02:47:34.177673-05	12	Ensalada China	2	[{"changed": {"fields": ["image"]}}]	22	1
103	2017-09-23 02:47:34.256231-05	11	Ensalada de Fresa	2	[{"changed": {"fields": ["image"]}}]	22	1
104	2017-09-23 02:47:34.312008-05	13	Ensalada Suprema	2	[{"changed": {"fields": ["image"]}}]	22	1
105	2017-09-23 02:49:48.536821-05	37	Fruta Picada	2	[{"changed": {"fields": ["image"]}}]	22	1
106	2017-09-23 02:49:48.849766-05	4	Jamón	2	[{"changed": {"fields": ["image"]}}]	22	1
107	2017-09-23 02:49:49.079021-05	21	Jugo de Alfalfa con Pinguica	2	[{"changed": {"fields": ["image"]}}]	22	1
108	2017-09-23 02:49:49.124062-05	22	Jugo de Naranja	2	[{"changed": {"fields": ["image"]}}]	22	1
109	2017-09-23 02:49:49.218518-05	24	Jugo de Zanahoria	2	[{"changed": {"fields": ["image"]}}]	22	1
110	2017-09-23 02:49:49.252408-05	23	Jugo Verde	2	[{"changed": {"fields": ["image"]}}]	22	1
111	2017-09-23 02:49:49.307471-05	15	Licuado de Fresa	2	[{"changed": {"fields": ["image"]}}]	22	1
112	2017-09-23 02:49:49.364862-05	16	Licuado de Guayaba	2	[{"changed": {"fields": ["image"]}}]	22	1
113	2017-09-23 02:49:49.48344-05	33	Licuado de Mango con Leche	2	[{"changed": {"fields": ["image"]}}]	22	1
114	2017-09-23 02:49:49.54067-05	17	Licuado de Papaya	2	[{"changed": {"fields": ["image"]}}]	22	1
115	2017-09-23 02:49:49.569307-05	14	Licuado de Platano	2	[{"changed": {"fields": ["image"]}}]	22	1
116	2017-09-23 02:51:12.220649-05	19	Melón Picado	2	[{"changed": {"fields": ["image"]}}]	22	1
117	2017-09-23 02:51:52.040413-05	19	Melón Picado	2	[{"changed": {"fields": ["image"]}}]	22	1
118	2017-09-23 02:52:30.999999-05	19	Melón Picado	2	[{"changed": {"fields": ["image"]}}]	22	1
119	2017-09-23 02:55:34.460389-05	19	Melón Picado	2	[{"changed": {"fields": ["image"]}}]	22	1
120	2017-09-23 02:55:34.558905-05	20	Papaya Picada	2	[{"changed": {"fields": ["image"]}}]	22	1
121	2017-09-23 02:55:34.665359-05	2	Pollo Mostaza	2	[{"changed": {"fields": ["image"]}}]	22	1
122	2017-09-23 02:55:34.732745-05	34	Rajas	2	[{"changed": {"fields": ["image"]}}]	22	1
123	2017-09-23 02:55:34.784664-05	18	Sandía Picada	2	[{"changed": {"fields": ["image"]}}]	22	1
124	2017-09-23 02:55:34.90133-05	36	Tinga	2	[{"changed": {"fields": ["image"]}}]	22	1
125	2017-09-23 02:55:35.01462-05	3	Vegetariano	2	[{"changed": {"fields": ["image"]}}]	22	1
126	2017-09-26 12:43:11.294453-05	1	ROTI	1	[{"added": {}}]	35	1
127	2017-09-26 12:43:15.90233-05	2	AGUA	1	[{"added": {}}]	35	1
128	2017-09-26 12:43:21.173978-05	3	LICUADO	1	[{"added": {}}]	35	1
129	2017-09-26 12:43:27.437279-05	4	ENSALADA	1	[{"added": {}}]	35	1
130	2017-09-26 12:43:33.413488-05	5	SERVICIO	1	[{"added": {}}]	35	1
131	2017-09-26 12:43:39.39551-05	6	ENTREGA	1	[{"added": {}}]	35	1
132	2017-09-26 12:43:46.429514-05	7	PRECIOS	1	[{"added": {}}]	35	1
133	2017-09-26 12:47:26.82692-05	7	PRECIOS	2	[{"changed": {"fields": ["priority"]}}]	35	1
134	2017-09-26 12:47:26.831628-05	6	ENTREGA	2	[{"changed": {"fields": ["priority"]}}]	35	1
135	2017-09-26 12:47:26.834224-05	5	SERVICIO	2	[{"changed": {"fields": ["priority"]}}]	35	1
136	2017-09-26 12:47:26.836886-05	4	ENSALADA	2	[{"changed": {"fields": ["priority"]}}]	35	1
137	2017-09-26 12:47:26.839531-05	3	LICUADO	2	[{"changed": {"fields": ["priority"]}}]	35	1
138	2017-09-26 12:47:26.842105-05	2	AGUA	2	[{"changed": {"fields": ["priority"]}}]	35	1
139	2017-09-29 12:14:43.121951-05	11	Alansatelite54	2	[{"changed": {"fields": ["is_active"]}}]	10	1
140	2017-09-29 12:14:43.131312-05	13	Jacquelinesatelite	2	[{"changed": {"fields": ["is_active"]}}]	10	1
141	2017-09-29 12:14:43.134255-05	12	Marthasatelite	2	[{"changed": {"fields": ["is_active"]}}]	10	1
142	2017-10-01 11:49:40.948934-05	10	Basilio	2	[{"changed": {"fields": ["is_staff", "is_active"]}}]	10	1
143	2017-10-04 11:41:37.398333-05	38	Roti de albóndigas	1	[{"added": {}}]	22	1
144	2017-10-04 11:43:06.39368-05	38	Albóndigas	2	[{"changed": {"fields": ["name"]}}]	22	1
145	2018-01-08 22:28:31.47969-06	1	Ingrediente	1	[{"added": {}}]	16	15
146	2018-01-08 22:28:47.605193-06	1	Almacen 1	1	[{"added": {}}]	17	15
147	2018-01-08 22:29:06.088683-06	1	Supplier 1	1	[{"added": {}}]	14	15
148	2018-01-09 01:14:00.805464-06	2	Refri Frio	1	[{"added": {}}]	17	15
149	2018-01-09 01:14:08.894963-06	3	Refri Caliente	1	[{"added": {}}]	17	15
150	2018-01-09 01:14:15.243961-06	4	Refri C Caliente	1	[{"added": {}}]	17	15
151	2018-01-09 01:14:27.210959-06	5	Almacen S Frio	1	[{"added": {}}]	17	15
152	2018-01-09 01:14:35.187457-06	6	Almacen S Caliente	1	[{"added": {}}]	17	15
153	2018-01-09 01:15:00.573453-06	7	Materias Primas	1	[{"added": {}}]	17	15
154	2018-01-09 01:17:31.064427-06	2	Wallmart	1	[{"added": {}}]	14	15
155	2018-01-09 01:17:41.779426-06	3	Verduleria Local	1	[{"added": {}}]	14	15
156	2018-01-09 01:17:51.362924-06	4	A domicilio	1	[{"added": {}}]	14	15
157	2018-01-09 01:18:00.762922-06	5	Costco	1	[{"added": {}}]	14	15
158	2018-01-09 01:18:09.76192-06	6	Central de abasto	1	[{"added": {}}]	14	15
159	2018-01-09 01:18:18.376919-06	7	Materias Primas	1	[{"added": {}}]	14	15
\.


--
-- Name: django_admin_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: digimundo
--

SELECT pg_catalog.setval('django_admin_log_id_seq', 159, true);


--
-- Data for Name: django_content_type; Type: TABLE DATA; Schema: public; Owner: digimundo
--

COPY django_content_type (id, app_label, model) FROM stdin;
1	jet	pinnedapplication
2	jet	bookmark
3	admin	logentry
4	auth	group
5	auth	permission
6	contenttypes	contenttype
7	sessions	session
8	sites	site
9	fcm	device
10	users	user
11	users	customerprofile
12	users	usermovements
13	branchoffices	branchoffice
14	branchoffices	supplier
15	branchoffices	cashregister
16	products	suppliescategory
17	products	supplylocation
18	products	packagecartridgerecipe
19	products	packagecartridge
20	products	cartridgerecipe
21	products	extraingredient
22	products	cartridge
23	products	supply
24	sales	ticketorder
25	sales	ticketdetail
26	sales	ticketbase
27	sales	ticketextraingredient
28	sales	ticketpos
29	orders	supplierorderdetail
30	orders	supplierorder
31	orders	customerorder
32	orders	customerorderdetail
33	kitchen	processedproduct
34	kitchen	warehouse
35	diners	elementtoevaluate
36	diners	diner
37	diners	satisfactionrating
38	diners	accesslog
39	products	kitchenassembly
40	sales	cartridgeticketdetail
41	sales	packagecartridgeticketdetail
42	products	presentation
43	kitchen	shoplist
44	kitchen	shoplistdetail
45	products	brand
46	products	shoplist
47	products	shoplistdetail
48	products	warehouse
\.


--
-- Name: django_content_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: digimundo
--

SELECT pg_catalog.setval('django_content_type_id_seq', 48, true);


--
-- Data for Name: django_migrations; Type: TABLE DATA; Schema: public; Owner: digimundo
--

COPY django_migrations (id, app, name, applied) FROM stdin;
1	contenttypes	0001_initial	2017-08-04 17:56:58.719435-05
2	contenttypes	0002_remove_content_type_name	2017-08-04 17:56:58.728695-05
3	auth	0001_initial	2017-08-04 17:56:58.786173-05
4	auth	0002_alter_permission_name_max_length	2017-08-04 17:56:58.799891-05
5	auth	0003_alter_user_email_max_length	2017-08-04 17:56:58.806973-05
6	auth	0004_alter_user_username_opts	2017-08-04 17:56:58.813967-05
7	auth	0005_alter_user_last_login_null	2017-08-04 17:56:58.821137-05
8	auth	0006_require_contenttypes_0002	2017-08-04 17:56:58.823037-05
9	auth	0007_alter_validators_add_error_messages	2017-08-04 17:56:58.831378-05
10	auth	0008_alter_user_username_max_length	2017-08-04 17:56:58.83842-05
11	users	0001_initial	2017-08-04 17:56:58.927046-05
12	admin	0001_initial	2017-08-04 17:56:58.952479-05
13	admin	0002_logentry_remove_auto_add	2017-08-04 17:56:58.966675-05
14	branchoffices	0001_initial	2017-08-04 17:56:59.005274-05
15	branchoffices	0002_branchoffice_manager	2017-08-04 17:56:59.022602-05
16	diners	0001_initial	2017-08-04 17:56:59.08923-05
17	fcm	0001_initial	2017-08-04 17:56:59.110646-05
18	fcm	0002_auto_20170804_1756	2017-08-04 17:56:59.120132-05
19	jet	0001_initial	2017-08-04 17:56:59.147958-05
20	jet	0002_delete_userdashboardmodule	2017-08-04 17:56:59.15367-05
21	products	0001_initial	2017-08-04 17:56:59.399208-05
22	sales	0001_initial	2017-08-04 17:56:59.518138-05
23	kitchen	0001_initial	2017-08-04 17:56:59.567109-05
24	kitchen	0002_processedproduct_ticket	2017-08-04 17:56:59.600945-05
25	orders	0001_initial	2017-08-04 17:56:59.674477-05
26	orders	0002_auto_20170804_1756	2017-08-04 17:56:59.873733-05
27	sales	0002_auto_20170804_1756	2017-08-04 17:57:00.000088-05
28	sessions	0001_initial	2017-08-04 17:57:00.018067-05
29	sites	0001_initial	2017-08-04 17:57:00.028399-05
30	sites	0002_alter_domain_unique	2017-08-04 17:57:00.040969-05
31	sales	0003_auto_20170804_1839	2017-08-04 18:39:25.467213-05
32	sales	0004_auto_20170804_1901	2017-08-04 19:01:23.99448-05
33	products	0002_auto_20170821_1814	2017-08-21 18:15:07.152557-05
34	users	0002_auto_20170821_1814	2017-08-21 18:15:07.222873-05
35	products	0003_auto_20170821_1850	2017-08-21 18:50:33.786477-05
36	products	0004_auto_20170922_0111	2017-09-22 01:12:22.790818-05
37	sales	0005_auto_20170922_0111	2017-09-22 01:12:23.017411-05
38	branchoffices	0003_auto_20170922_0111	2017-09-22 01:12:23.059401-05
39	fcm	0002_auto_20170922_0111	2017-09-22 01:12:23.066829-05
40	products	0005_auto_20170922_2341	2017-09-22 23:42:00.748517-05
41	sales	0006_auto_20170922_2341	2017-09-22 23:42:00.898519-05
42	products	0006_auto_20170923_0255	2017-09-23 02:55:11.829035-05
43	fcm	0002_auto_20171011_0208	2017-12-20 20:18:00.622519-06
44	orders	0002_auto_20171011_0208	2017-12-20 20:22:10.616475-06
45	sales	0002_auto_20171011_0208	2017-12-20 20:56:06.404122-06
46	products	0002_presentation	2017-12-22 12:49:34.182244-06
47	kitchen	0003_auto_20171222_1248	2017-12-22 12:49:34.401246-06
48	orders	0003_auto_20171222_1248	2017-12-22 12:52:03.236931-06
49	sales	0003_auto_20171222_1248	2017-12-22 12:53:28.573535-06
50	products	0003_auto_20180119_1902	2018-01-19 19:02:52.917425-06
51	products	0004_auto_20180131_0120	2018-01-31 01:20:51.848874-06
52	kitchen	0004_auto_20180131_0120	2018-01-31 01:25:32.345824-06
53	auth	0009_alter_user_last_name_max_length	2018-02-20 03:04:06.740109-06
54	fcm	0002_auto_20180220_0303	2018-02-20 03:04:06.803608-06
55	kitchen	0005_warehouse_presentation	2018-02-20 03:31:27.66043-06
56	kitchen	0006_auto_20180220_0330	2018-02-20 03:31:27.903929-06
57	products	0005_shoplist_shoplistdetail_warehouse	2018-02-20 03:31:28.07943-06
58	users	0002_auto_20180220_0303	2018-02-20 03:31:28.10243-06
59	products	0006_warehouse_on_warehouse	2018-02-23 02:28:02.548309-06
60	products	0007_auto_20180223_0238	2018-02-23 02:38:51.031962-06
61	products	0008_presentation_on_stock	2018-02-23 20:35:28.556653-06
62	products	0009_auto_20180227_0328	2018-02-27 03:28:28.533309-06
\.


--
-- Name: django_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: digimundo
--

SELECT pg_catalog.setval('django_migrations_id_seq', 62, true);


--
-- Data for Name: django_session; Type: TABLE DATA; Schema: public; Owner: digimundo
--

COPY django_session (session_key, session_data, expire_date) FROM stdin;
d9xkun9t730anh0elfzj9w45qy5xj57m	ZTY4ZmIzNjg1ZDBhMzZkYzdkZjBkM2M3MjI2NzliYzAyZTJlZGM0ZTp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiN2E4OWM1NzljNGQ0MjA2MTc1ODU3ZDhjYjg2NWVhMzFhZjE0MWY4MyIsIl9hdXRoX3VzZXJfaWQiOiI0In0=	2017-08-19 06:58:14.273004-05
zfwgxhai29uz3einezl52a865x0n1iz2	ZTY4ZmIzNjg1ZDBhMzZkYzdkZjBkM2M3MjI2NzliYzAyZTJlZGM0ZTp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiN2E4OWM1NzljNGQ0MjA2MTc1ODU3ZDhjYjg2NWVhMzFhZjE0MWY4MyIsIl9hdXRoX3VzZXJfaWQiOiI0In0=	2017-08-19 07:43:06.613895-05
23u2e5pkqil94jft8tumc6plyox914of	ZmJkMmRlZGE4MmQzNDhlMWYzZmRjYTNkZWFkNWM0ODZlMWI5ZDRlMDp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiNDEyMzY2MmRmMmEwMzhmY2E3Yjc1OWQ0NzQzYThlOTQ0NzdkNTBlYiIsIl9hdXRoX3VzZXJfaWQiOiIxIn0=	2017-08-19 10:57:04.828521-05
fqt7lakz6d2djm0raw63t6spmfefzzq6	ZmJkMmRlZGE4MmQzNDhlMWYzZmRjYTNkZWFkNWM0ODZlMWI5ZDRlMDp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiNDEyMzY2MmRmMmEwMzhmY2E3Yjc1OWQ0NzQzYThlOTQ0NzdkNTBlYiIsIl9hdXRoX3VzZXJfaWQiOiIxIn0=	2017-08-19 14:05:41.179848-05
0g79ufr5trq2vk88m2jepekqg37h3895	YWQwYWIwZThhZTU0ZmM0M2RlNTJlODcxZTk3MGI0NGE5MmRmZjQyMDp7fQ==	2017-08-28 08:38:42.9241-05
7z4upjyoagd5p0fw8f4vyq1tvih0c3ae	ZTY4ZmIzNjg1ZDBhMzZkYzdkZjBkM2M3MjI2NzliYzAyZTJlZGM0ZTp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiN2E4OWM1NzljNGQ0MjA2MTc1ODU3ZDhjYjg2NWVhMzFhZjE0MWY4MyIsIl9hdXRoX3VzZXJfaWQiOiI0In0=	2017-09-02 07:25:31.09223-05
1gfdc6vckzth4oo0s1k1cq7dfrdr0vgj	ZTY4ZmIzNjg1ZDBhMzZkYzdkZjBkM2M3MjI2NzliYzAyZTJlZGM0ZTp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiN2E4OWM1NzljNGQ0MjA2MTc1ODU3ZDhjYjg2NWVhMzFhZjE0MWY4MyIsIl9hdXRoX3VzZXJfaWQiOiI0In0=	2017-09-02 08:46:00.95873-05
xhs37ijato81twa1dvas75pccu4azb6q	ZmJkMmRlZGE4MmQzNDhlMWYzZmRjYTNkZWFkNWM0ODZlMWI5ZDRlMDp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiNDEyMzY2MmRmMmEwMzhmY2E3Yjc1OWQ0NzQzYThlOTQ0NzdkNTBlYiIsIl9hdXRoX3VzZXJfaWQiOiIxIn0=	2017-09-04 14:00:18.540649-05
c8165ftz2c9np6f4r7kg4eyjewkaqfum	MGNjNmJlYzBlNDI4M2ViNGE2ODg5MjdkMjRhOGY0ZWQzOTY2YjI2OTp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6IjEiLCJfYXV0aF91c2VyX2hhc2giOiI0MTIzNjYyZGYyYTAzOGZjYTdiNzU5ZDQ3NDNhOGU5NDQ3N2Q1MGViIn0=	2017-09-04 18:53:17.880992-05
bqdyuuhxhi9nqezf90elxl5fr4zh30aq	MGNjNmJlYzBlNDI4M2ViNGE2ODg5MjdkMjRhOGY0ZWQzOTY2YjI2OTp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6IjEiLCJfYXV0aF91c2VyX2hhc2giOiI0MTIzNjYyZGYyYTAzOGZjYTdiNzU5ZDQ3NDNhOGU5NDQ3N2Q1MGViIn0=	2017-09-05 13:08:48.631502-05
npc4h0324e6rs68pxi936e2hrwaap3s5	YjU4ODYzZTU5ZDA5ODhkNWU1MjgxYjQ5ZjQ0MGM0OTVhMzBhMzJkMjp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6IjgiLCJfYXV0aF91c2VyX2hhc2giOiJhYTJhNzRhZGQ2NTRkZmE1NTkxNGZjMDIwYWI2ZDRlODUyZTBhOTE1In0=	2017-09-13 14:49:06.833544-05
irvgc9zdjgugrn2mmuqsvxdefod55mgz	YjU4ODYzZTU5ZDA5ODhkNWU1MjgxYjQ5ZjQ0MGM0OTVhMzBhMzJkMjp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6IjgiLCJfYXV0aF91c2VyX2hhc2giOiJhYTJhNzRhZGQ2NTRkZmE1NTkxNGZjMDIwYWI2ZDRlODUyZTBhOTE1In0=	2017-09-13 15:48:56.529656-05
q6qz1l4hfevi1m5nipyrw886qr1i49o1	YjU4ODYzZTU5ZDA5ODhkNWU1MjgxYjQ5ZjQ0MGM0OTVhMzBhMzJkMjp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6IjgiLCJfYXV0aF91c2VyX2hhc2giOiJhYTJhNzRhZGQ2NTRkZmE1NTkxNGZjMDIwYWI2ZDRlODUyZTBhOTE1In0=	2017-09-14 11:35:41.577243-05
1s8hwfvkr5n7aizs61np1ualiuk4p1h9	YjQ3ZDIyNzRmZmMxYWFhNzZlOGIxNjViMmQyNjk3YWE4ZDRjODQyMzp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6IjQiLCJfYXV0aF91c2VyX2hhc2giOiI3YTg5YzU3OWM0ZDQyMDYxNzU4NTdkOGNiODY1ZWEzMWFmMTQxZjgzIn0=	2017-09-16 07:31:01.306252-05
u7g8ii3lnwggq3hms2d5954qlw5d4vgn	YjQ3ZDIyNzRmZmMxYWFhNzZlOGIxNjViMmQyNjk3YWE4ZDRjODQyMzp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6IjQiLCJfYXV0aF91c2VyX2hhc2giOiI3YTg5YzU3OWM0ZDQyMDYxNzU4NTdkOGNiODY1ZWEzMWFmMTQxZjgzIn0=	2017-09-16 18:40:07.712845-05
rs5vptwpwjedfo9b2nntlawu6ss62n50	YjQ3ZDIyNzRmZmMxYWFhNzZlOGIxNjViMmQyNjk3YWE4ZDRjODQyMzp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6IjQiLCJfYXV0aF91c2VyX2hhc2giOiI3YTg5YzU3OWM0ZDQyMDYxNzU4NTdkOGNiODY1ZWEzMWFmMTQxZjgzIn0=	2017-09-18 08:15:22.28318-05
cjw0a808kjb4o5dnpv7dh7flta0ei6fe	MGNjNmJlYzBlNDI4M2ViNGE2ODg5MjdkMjRhOGY0ZWQzOTY2YjI2OTp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6IjEiLCJfYXV0aF91c2VyX2hhc2giOiI0MTIzNjYyZGYyYTAzOGZjYTdiNzU5ZDQ3NDNhOGU5NDQ3N2Q1MGViIn0=	2017-09-18 14:15:49.04857-05
mi0igzhy4cowuveo8y7lkqwdrhta9zc7	MGNjNmJlYzBlNDI4M2ViNGE2ODg5MjdkMjRhOGY0ZWQzOTY2YjI2OTp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6IjEiLCJfYXV0aF91c2VyX2hhc2giOiI0MTIzNjYyZGYyYTAzOGZjYTdiNzU5ZDQ3NDNhOGU5NDQ3N2Q1MGViIn0=	2017-09-19 14:24:04.064314-05
c6vkhx48dvxwne91a3eiqr8v7o09azfy	MzllOTVlM2RhZjczMTNhNTU4ZTM1N2RiNzFlZmE0MGIyNTI4OTU5ZDp7Il9hdXRoX3VzZXJfaWQiOiI4IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJhYTJhNzRhZGQ2NTRkZmE1NTkxNGZjMDIwYWI2ZDRlODUyZTBhOTE1In0=	2017-09-25 14:33:21.327668-05
qhkll8s8tq96mc9k1f5kgsy5xjxatxu8	MzllOTVlM2RhZjczMTNhNTU4ZTM1N2RiNzFlZmE0MGIyNTI4OTU5ZDp7Il9hdXRoX3VzZXJfaWQiOiI4IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJhYTJhNzRhZGQ2NTRkZmE1NTkxNGZjMDIwYWI2ZDRlODUyZTBhOTE1In0=	2017-09-25 14:59:27.508314-05
4hkyddkdn85k8hsi0zm2hpjlj2f3hgns	ZjFkMjZiYTA5MjBmMzQ5YWMzNmIwN2QxN2Q5ZDcxOWNlN2U0YWE3NTp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0MTIzNjYyZGYyYTAzOGZjYTdiNzU5ZDQ3NDNhOGU5NDQ3N2Q1MGViIn0=	2017-09-25 16:53:29.768195-05
ttvawmc12htjl2g34mwvkyvoak8jbtl7	ZWYzY2JmMGNhMDY5NDY3MjhmZDI4OGU1MTQzMDY5YzIwNzg5NjE4Yjp7Il9hdXRoX3VzZXJfaWQiOiI0IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI3YTg5YzU3OWM0ZDQyMDYxNzU4NTdkOGNiODY1ZWEzMWFmMTQxZjgzIn0=	2017-10-02 07:05:27.195315-05
417iiwevr7dll8sob3u5ezxq5n0j5y5j	ZWYzY2JmMGNhMDY5NDY3MjhmZDI4OGU1MTQzMDY5YzIwNzg5NjE4Yjp7Il9hdXRoX3VzZXJfaWQiOiI0IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI3YTg5YzU3OWM0ZDQyMDYxNzU4NTdkOGNiODY1ZWEzMWFmMTQxZjgzIn0=	2017-10-02 11:07:30.337882-05
9pzcg35iujy9tr3qvzw2qryvy9yiy7qy	MzllOTVlM2RhZjczMTNhNTU4ZTM1N2RiNzFlZmE0MGIyNTI4OTU5ZDp7Il9hdXRoX3VzZXJfaWQiOiI4IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJhYTJhNzRhZGQ2NTRkZmE1NTkxNGZjMDIwYWI2ZDRlODUyZTBhOTE1In0=	2017-10-02 13:58:43.956884-05
k6h6il3vzms4wihias6mxxncyh4rjvlo	MTJhNzA2MjE3NTI4NmVjNTNjZjhiMzA2ZTZiNDU4NjQ3ZTdhMGMxYzp7Il9hdXRoX3VzZXJfaGFzaCI6IjdhODljNTc5YzRkNDIwNjE3NTg1N2Q4Y2I4NjVlYTMxYWYxNDFmODMiLCJfYXV0aF91c2VyX2lkIjoiNCIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIn0=	2017-10-10 07:37:55.947011-05
rji01tcsg5255ytdq2g1brs097bn1rgq	MTJhNzA2MjE3NTI4NmVjNTNjZjhiMzA2ZTZiNDU4NjQ3ZTdhMGMxYzp7Il9hdXRoX3VzZXJfaGFzaCI6IjdhODljNTc5YzRkNDIwNjE3NTg1N2Q4Y2I4NjVlYTMxYWYxNDFmODMiLCJfYXV0aF91c2VyX2lkIjoiNCIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIn0=	2017-10-10 14:14:07.025539-05
p32y0jzkl4lvrqn34i79b5zz34v74b4d	NGFmMmI2NTA2YjVkYjAzZTE3MzQwNzQ0ZDY4YjhjOGI1NTIxY2ZmYTp7Il9hdXRoX3VzZXJfaGFzaCI6IjQxMjM2NjJkZjJhMDM4ZmNhN2I3NTlkNDc0M2E4ZTk0NDc3ZDUwZWIiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIn0=	2017-10-07 01:37:52.860016-05
kk0es7dsc4kg67axrdeagkbmllynhhmf	NGIwYjRiMDNiNmJlZGRjMWZlNzFlMDIzZWNjZjdiMDNlMWRiNzU3NTp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9oYXNoIjoiNDEyMzY2MmRmMmEwMzhmY2E3Yjc1OWQ0NzQzYThlOTQ0NzdkNTBlYiIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIn0=	2017-10-07 01:49:33.010287-05
afln5he16dvts6j0hqkjjqcksrq6yahx	NGIwYjRiMDNiNmJlZGRjMWZlNzFlMDIzZWNjZjdiMDNlMWRiNzU3NTp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9oYXNoIjoiNDEyMzY2MmRmMmEwMzhmY2E3Yjc1OWQ0NzQzYThlOTQ0NzdkNTBlYiIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIn0=	2017-10-07 01:51:04.468009-05
ayj492rhbjb7cwqtwzlj8fdm84bjmwkg	MGNjNmJlYzBlNDI4M2ViNGE2ODg5MjdkMjRhOGY0ZWQzOTY2YjI2OTp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6IjEiLCJfYXV0aF91c2VyX2hhc2giOiI0MTIzNjYyZGYyYTAzOGZjYTdiNzU5ZDQ3NDNhOGU5NDQ3N2Q1MGViIn0=	2017-10-07 09:44:01.723737-05
wntms93wmqucmu3aefftb7e0b6tuy09c	MGNjNmJlYzBlNDI4M2ViNGE2ODg5MjdkMjRhOGY0ZWQzOTY2YjI2OTp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6IjEiLCJfYXV0aF91c2VyX2hhc2giOiI0MTIzNjYyZGYyYTAzOGZjYTdiNzU5ZDQ3NDNhOGU5NDQ3N2Q1MGViIn0=	2017-10-07 13:48:58.618039-05
3xt52f6oalyp4eg8blh7jjigru6mln79	NGFmMmI2NTA2YjVkYjAzZTE3MzQwNzQ0ZDY4YjhjOGI1NTIxY2ZmYTp7Il9hdXRoX3VzZXJfaGFzaCI6IjQxMjM2NjJkZjJhMDM4ZmNhN2I3NTlkNDc0M2E4ZTk0NDc3ZDUwZWIiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIn0=	2017-10-13 12:13:07.406057-05
4fxnm05xdzq0eksamgpu7o8ps7f3dtwi	NGFmMmI2NTA2YjVkYjAzZTE3MzQwNzQ0ZDY4YjhjOGI1NTIxY2ZmYTp7Il9hdXRoX3VzZXJfaGFzaCI6IjQxMjM2NjJkZjJhMDM4ZmNhN2I3NTlkNDc0M2E4ZTk0NDc3ZDUwZWIiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIn0=	2017-10-15 11:49:10.550002-05
2fiuku3x1owl3nyfc3k2pmnni0u6yb17	MTJhNzA2MjE3NTI4NmVjNTNjZjhiMzA2ZTZiNDU4NjQ3ZTdhMGMxYzp7Il9hdXRoX3VzZXJfaGFzaCI6IjdhODljNTc5YzRkNDIwNjE3NTg1N2Q4Y2I4NjVlYTMxYWYxNDFmODMiLCJfYXV0aF91c2VyX2lkIjoiNCIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIn0=	2017-10-16 07:07:03.087564-05
jfzu0u9oktcdokzqn2vo2nu4932eoq2o	OTBmY2U2Y2ViNTY2MGQ3MGNlMmI4MTFmNmJjNzg2MTRlZTNlMTQwZDp7Il9hdXRoX3VzZXJfaGFzaCI6ImIzNjJiMDQ0ZWVjN2IxNWI5NDJiZGI5OTc0YjE4YTYyNGQ2MmUyYzUiLCJfYXV0aF91c2VyX2lkIjoiMTAiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCJ9	2017-10-16 20:39:40.182274-05
iex48wm9xogmdddlzoj3z56tieacob8s	OTBmY2U2Y2ViNTY2MGQ3MGNlMmI4MTFmNmJjNzg2MTRlZTNlMTQwZDp7Il9hdXRoX3VzZXJfaGFzaCI6ImIzNjJiMDQ0ZWVjN2IxNWI5NDJiZGI5OTc0YjE4YTYyNGQ2MmUyYzUiLCJfYXV0aF91c2VyX2lkIjoiMTAiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCJ9	2017-10-16 20:43:21.426484-05
jg1l28xdzyfx3g9v4a4h3vuamb8kkvlm	MTJhNzA2MjE3NTI4NmVjNTNjZjhiMzA2ZTZiNDU4NjQ3ZTdhMGMxYzp7Il9hdXRoX3VzZXJfaGFzaCI6IjdhODljNTc5YzRkNDIwNjE3NTg1N2Q4Y2I4NjVlYTMxYWYxNDFmODMiLCJfYXV0aF91c2VyX2lkIjoiNCIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIn0=	2017-10-17 07:20:16.552183-05
1gv3f3tmjsljhzrujqm4r8fcrksc9w1w	ZjI2NzdiY2M5ODg3MzgzMzVlNDUwNDFjNGU0M2UwYjA5YWVkNTBkYTp7Il9hdXRoX3VzZXJfaGFzaCI6ImFhMmE3NGFkZDY1NGRmYTU1OTE0ZmMwMjBhYjZkNGU4NTJlMGE5MTUiLCJfYXV0aF91c2VyX2lkIjoiOCIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIn0=	2017-10-17 10:43:15.904598-05
85bqf20f8rmtxt83a69jk9ri4gq4fzd9	OTBmY2U2Y2ViNTY2MGQ3MGNlMmI4MTFmNmJjNzg2MTRlZTNlMTQwZDp7Il9hdXRoX3VzZXJfaGFzaCI6ImIzNjJiMDQ0ZWVjN2IxNWI5NDJiZGI5OTc0YjE4YTYyNGQ2MmUyYzUiLCJfYXV0aF91c2VyX2lkIjoiMTAiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCJ9	2017-10-17 17:09:41.657437-05
q554fojm0ejnn2y6r2eu5cfduo07kh0z	OTBmY2U2Y2ViNTY2MGQ3MGNlMmI4MTFmNmJjNzg2MTRlZTNlMTQwZDp7Il9hdXRoX3VzZXJfaGFzaCI6ImIzNjJiMDQ0ZWVjN2IxNWI5NDJiZGI5OTc0YjE4YTYyNGQ2MmUyYzUiLCJfYXV0aF91c2VyX2lkIjoiMTAiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCJ9	2017-10-17 17:13:30.284079-05
pj75yb272o2z93tljfive924mewdh83b	ZjI2NzdiY2M5ODg3MzgzMzVlNDUwNDFjNGU0M2UwYjA5YWVkNTBkYTp7Il9hdXRoX3VzZXJfaGFzaCI6ImFhMmE3NGFkZDY1NGRmYTU1OTE0ZmMwMjBhYjZkNGU4NTJlMGE5MTUiLCJfYXV0aF91c2VyX2lkIjoiOCIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIn0=	2017-10-18 11:07:59.843188-05
zyqnp7aqeg2jknuq4p36zyb4o2or2ul1	ZjI2NzdiY2M5ODg3MzgzMzVlNDUwNDFjNGU0M2UwYjA5YWVkNTBkYTp7Il9hdXRoX3VzZXJfaGFzaCI6ImFhMmE3NGFkZDY1NGRmYTU1OTE0ZmMwMjBhYjZkNGU4NTJlMGE5MTUiLCJfYXV0aF91c2VyX2lkIjoiOCIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIn0=	2017-10-18 22:41:19.575561-05
lnzbpo1hau0yx2zrml8q0j4cgt22qkxk	NGFmMmI2NTA2YjVkYjAzZTE3MzQwNzQ0ZDY4YjhjOGI1NTIxY2ZmYTp7Il9hdXRoX3VzZXJfaGFzaCI6IjQxMjM2NjJkZjJhMDM4ZmNhN2I3NTlkNDc0M2E4ZTk0NDc3ZDUwZWIiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIn0=	2017-10-21 13:58:49.211797-05
xt3d078aptrlf2kw6tum6jtq0zmsnz9u	MmM0ZGI3OGZkZjk4NTk4MDQ4ZmJmMzMyNjkwOWJhODA5OTBhMjE1OTp7Il9hdXRoX3VzZXJfaWQiOiIxNSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiYzk5YjBlZDMxM2NmNGVlNWU4ODkwNGMxYTYyZGE1MTEzNzMwNTk2OSJ9	2018-01-05 12:10:43.292356-06
wf7xrgdmijaiw22ffsc7q8dgwq4k29eo	MmM0ZGI3OGZkZjk4NTk4MDQ4ZmJmMzMyNjkwOWJhODA5OTBhMjE1OTp7Il9hdXRoX3VzZXJfaWQiOiIxNSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiYzk5YjBlZDMxM2NmNGVlNWU4ODkwNGMxYTYyZGE1MTEzNzMwNTk2OSJ9	2018-01-05 12:13:31.768564-06
ypt25h03m1lsy51wrvqts7dc4u508tgi	MmM0ZGI3OGZkZjk4NTk4MDQ4ZmJmMzMyNjkwOWJhODA5OTBhMjE1OTp7Il9hdXRoX3VzZXJfaWQiOiIxNSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiYzk5YjBlZDMxM2NmNGVlNWU4ODkwNGMxYTYyZGE1MTEzNzMwNTk2OSJ9	2018-01-22 16:57:25.141642-06
j4r9863cbi6tadzqu78do9gg6q8zkzu1	MmM0ZGI3OGZkZjk4NTk4MDQ4ZmJmMzMyNjkwOWJhODA5OTBhMjE1OTp7Il9hdXRoX3VzZXJfaWQiOiIxNSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiYzk5YjBlZDMxM2NmNGVlNWU4ODkwNGMxYTYyZGE1MTEzNzMwNTk2OSJ9	2018-01-23 01:32:10.303777-06
dxmhw6n7rtavulj72zoc63bo7r0qmloq	MmM0ZGI3OGZkZjk4NTk4MDQ4ZmJmMzMyNjkwOWJhODA5OTBhMjE1OTp7Il9hdXRoX3VzZXJfaWQiOiIxNSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiYzk5YjBlZDMxM2NmNGVlNWU4ODkwNGMxYTYyZGE1MTEzNzMwNTk2OSJ9	2018-01-23 23:42:07.858924-06
z9un5j3zrysmvdb6n3ia9wdmfx6xmuik	MmM0ZGI3OGZkZjk4NTk4MDQ4ZmJmMzMyNjkwOWJhODA5OTBhMjE1OTp7Il9hdXRoX3VzZXJfaWQiOiIxNSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiYzk5YjBlZDMxM2NmNGVlNWU4ODkwNGMxYTYyZGE1MTEzNzMwNTk2OSJ9	2018-01-24 15:31:23.163991-06
y33vxq2iaur10jehgxdt6dknpij5h30z	MmM0ZGI3OGZkZjk4NTk4MDQ4ZmJmMzMyNjkwOWJhODA5OTBhMjE1OTp7Il9hdXRoX3VzZXJfaWQiOiIxNSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiYzk5YjBlZDMxM2NmNGVlNWU4ODkwNGMxYTYyZGE1MTEzNzMwNTk2OSJ9	2018-01-24 16:13:40.212831-06
uk0i3xbjstofnzfppw0nezcenopr2y3q	MmM0ZGI3OGZkZjk4NTk4MDQ4ZmJmMzMyNjkwOWJhODA5OTBhMjE1OTp7Il9hdXRoX3VzZXJfaWQiOiIxNSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiYzk5YjBlZDMxM2NmNGVlNWU4ODkwNGMxYTYyZGE1MTEzNzMwNTk2OSJ9	2018-02-02 18:44:39.384877-06
oehdndxu72cptrndn48p20n5cj2rum7z	MmM0ZGI3OGZkZjk4NTk4MDQ4ZmJmMzMyNjkwOWJhODA5OTBhMjE1OTp7Il9hdXRoX3VzZXJfaWQiOiIxNSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiYzk5YjBlZDMxM2NmNGVlNWU4ODkwNGMxYTYyZGE1MTEzNzMwNTk2OSJ9	2018-02-13 03:17:10.827262-06
rshc6ymd8ky12na72khvxk1oktfgepw8	MmM0ZGI3OGZkZjk4NTk4MDQ4ZmJmMzMyNjkwOWJhODA5OTBhMjE1OTp7Il9hdXRoX3VzZXJfaWQiOiIxNSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiYzk5YjBlZDMxM2NmNGVlNWU4ODkwNGMxYTYyZGE1MTEzNzMwNTk2OSJ9	2018-02-22 01:10:29.977457-06
h9b5env48uk3aon6t0rj1u97e0xkvzvd	MmM0ZGI3OGZkZjk4NTk4MDQ4ZmJmMzMyNjkwOWJhODA5OTBhMjE1OTp7Il9hdXRoX3VzZXJfaWQiOiIxNSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiYzk5YjBlZDMxM2NmNGVlNWU4ODkwNGMxYTYyZGE1MTEzNzMwNTk2OSJ9	2018-03-02 20:17:27.094132-06
jyalltvfkmjyhp30liez4yveqqspbb02	N2QzYjhmNmQ4ZmNkZTQ2ZDZmODNhZmRjNTZjMTk3MDQ4NjhkYTI3Njp7Il9hdXRoX3VzZXJfaWQiOiIxNSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiMDg5YzQ3MjJlNDY3NzdhYjgwNjI5ZWUwOWEyYzYzYjc1ZjIyYWIzZiJ9	2018-03-19 17:39:36.743843-06
\.


--
-- Data for Name: django_site; Type: TABLE DATA; Schema: public; Owner: digimundo
--

COPY django_site (id, domain, name) FROM stdin;
1	example.com	example.com
\.


--
-- Name: django_site_id_seq; Type: SEQUENCE SET; Schema: public; Owner: digimundo
--

SELECT pg_catalog.setval('django_site_id_seq', 1, true);


--
-- Data for Name: fcm_device; Type: TABLE DATA; Schema: public; Owner: digimundo
--

COPY fcm_device (id, dev_id, reg_id, name, is_active) FROM stdin;
\.


--
-- Name: fcm_device_id_seq; Type: SEQUENCE SET; Schema: public; Owner: digimundo
--

SELECT pg_catalog.setval('fcm_device_id_seq', 1, false);


--
-- Data for Name: jet_bookmark; Type: TABLE DATA; Schema: public; Owner: digimundo
--

COPY jet_bookmark (id, url, title, "user", date_add) FROM stdin;
\.


--
-- Name: jet_bookmark_id_seq; Type: SEQUENCE SET; Schema: public; Owner: digimundo
--

SELECT pg_catalog.setval('jet_bookmark_id_seq', 1, false);


--
-- Data for Name: jet_pinnedapplication; Type: TABLE DATA; Schema: public; Owner: digimundo
--

COPY jet_pinnedapplication (id, app_label, "user", date_add) FROM stdin;
\.


--
-- Name: jet_pinnedapplication_id_seq; Type: SEQUENCE SET; Schema: public; Owner: digimundo
--

SELECT pg_catalog.setval('jet_pinnedapplication_id_seq', 1, false);


--
-- Data for Name: kitchen_processedproduct; Type: TABLE DATA; Schema: public; Owner: digimundo
--

COPY kitchen_processedproduct (id, created_at, prepared_at, status, ticket_id) FROM stdin;
54	2017-08-12 09:19:26.852746-05	\N	AS	293
55	2017-08-12 10:31:44.030487-05	\N	AS	294
56	2017-08-12 10:33:24.478281-05	\N	AS	295
113	2017-08-19 08:48:55.778261-05	\N	AS	352
25	2017-08-08 07:48:17.441376-05	\N	AS	264
27	2017-08-08 10:30:41.735956-05	\N	AS	266
26	2017-08-08 09:12:34.256281-05	\N	AS	265
28	2017-08-08 11:18:57.467466-05	\N	AS	267
29	2017-08-08 11:19:42.434993-05	\N	AS	268
30	2017-08-08 11:20:26.519265-05	\N	AS	269
31	2017-08-08 11:20:57.425517-05	\N	AS	270
32	2017-08-08 11:55:03.040697-05	\N	AS	271
33	2017-08-08 12:39:32.639411-05	\N	AS	272
34	2017-08-08 13:24:50.567413-05	\N	AS	273
35	2017-08-08 14:00:56.287852-05	\N	AS	274
57	2017-08-12 13:11:55.17253-05	\N	AS	296
58	2017-08-12 13:13:11.134392-05	\N	AS	297
3	2017-08-05 08:58:21.000969-05	\N	AS	3
5	2017-08-05 10:49:01.492184-05	\N	AS	7
36	2017-08-09 07:36:09.855884-05	\N	AS	275
38	2017-08-09 08:46:07.96986-05	\N	AS	277
37	2017-08-09 08:43:21.385196-05	\N	AS	276
39	2017-08-10 08:01:23.034916-05	\N	AS	278
18	2017-08-07 10:30:28.847701-05	\N	AS	257
19	2017-08-07 11:01:45.790422-05	\N	AS	258
20	2017-08-07 11:18:36.332343-05	\N	AS	259
21	2017-08-07 11:30:09.075427-05	\N	AS	260
23	2017-08-07 11:37:28.563903-05	\N	AS	262
24	2017-08-07 13:20:45.808551-05	\N	AS	263
40	2017-08-10 11:31:34.426838-05	\N	AS	279
41	2017-08-10 11:46:14.348878-05	\N	AS	280
81	2017-08-17 09:12:50.302997-05	\N	AS	320
59	2017-08-12 13:22:31.731911-05	\N	AS	298
60	2017-08-14 07:58:04.923641-05	\N	AS	299
62	2017-08-14 08:03:05.809118-05	\N	AS	301
42	2017-08-11 08:12:55.728236-05	\N	AS	281
43	2017-08-11 08:31:13.947549-05	\N	AS	282
44	2017-08-11 08:35:57.592986-05	\N	AS	283
45	2017-08-11 09:33:10.089299-05	\N	AS	284
46	2017-08-11 09:33:47.053537-05	\N	AS	285
48	2017-08-11 09:47:20.912056-05	\N	AS	287
82	2017-08-17 09:15:03.104354-05	\N	AS	321
83	2017-08-17 09:16:07.733985-05	\N	AS	322
84	2017-08-17 09:17:01.912215-05	\N	AS	323
85	2017-08-17 09:23:28.176421-05	\N	AS	324
86	2017-08-17 09:24:50.675694-05	\N	AS	325
49	2017-08-11 10:44:05.359891-05	\N	AS	288
51	2017-08-11 12:16:41.327653-05	\N	AS	290
50	2017-08-11 11:52:30.67571-05	\N	AS	289
52	2017-08-11 12:22:01.077234-05	\N	AS	291
53	2017-08-12 09:13:05.279793-05	\N	AS	292
87	2017-08-17 09:26:37.040033-05	\N	AS	326
88	2017-08-17 09:27:07.010378-05	\N	AS	327
65	2017-08-14 11:38:49.204787-05	\N	AS	304
64	2017-08-14 11:38:08.459877-05	\N	AS	303
63	2017-08-14 11:35:53.224544-05	\N	AS	302
90	2017-08-17 09:58:12.971715-05	\N	AS	329
91	2017-08-17 10:09:10.985827-05	\N	AS	330
92	2017-08-17 10:23:55.774853-05	\N	AS	331
67	2017-08-15 07:29:51.085497-05	\N	AS	306
68	2017-08-15 08:22:14.611793-05	\N	AS	307
69	2017-08-15 13:50:20.839938-05	\N	AS	308
70	2017-08-15 13:55:55.46713-05	\N	AS	309
71	2017-08-15 14:25:35.436596-05	\N	AS	310
108	2017-08-18 11:20:17.982347-05	\N	AS	347
109	2017-08-18 11:35:29.700783-05	\N	AS	348
110	2017-08-18 12:27:03.344732-05	\N	AS	349
72	2017-08-16 08:12:48.353581-05	\N	AS	311
74	2017-08-16 08:56:18.703318-05	\N	AS	313
73	2017-08-16 08:52:18.299442-05	\N	AS	312
75	2017-08-16 09:33:13.700128-05	\N	AS	314
76	2017-08-16 09:44:55.657513-05	\N	AS	315
77	2017-08-16 09:59:30.392356-05	\N	AS	316
78	2017-08-16 10:01:00.274282-05	\N	AS	317
111	2017-08-18 13:35:52.941349-05	\N	AS	350
93	2017-08-17 10:56:47.383322-05	\N	AS	332
79	2017-08-17 07:54:22.316233-05	\N	AS	318
80	2017-08-17 08:59:50.183249-05	\N	AS	319
125	2017-08-21 07:35:52.319116-05	\N	AS	364
135	2017-08-22 14:20:25.467819-05	\N	AS	374
94	2017-08-17 10:56:49.475703-05	\N	AS	333
95	2017-08-17 10:56:50.683435-05	\N	AS	334
96	2017-08-17 10:56:51.641492-05	\N	AS	335
97	2017-08-17 14:09:43.431083-05	\N	AS	336
107	2017-08-18 10:25:38.942038-05	\N	AS	346
106	2017-08-18 10:24:53.444613-05	\N	AS	345
105	2017-08-18 10:19:15.378937-05	\N	AS	344
104	2017-08-18 10:11:07.125809-05	\N	AS	343
103	2017-08-18 09:55:43.496864-05	\N	AS	342
102	2017-08-18 09:47:40.234897-05	\N	AS	341
101	2017-08-18 09:38:41.136049-05	\N	AS	340
100	2017-08-18 09:22:08.559465-05	\N	AS	339
99	2017-08-18 08:55:28.618969-05	\N	AS	338
98	2017-08-18 08:51:07.459689-05	\N	AS	337
136	2017-08-23 08:49:29.522822-05	\N	AS	375
126	2017-08-21 09:01:37.882383-05	\N	AS	365
127	2017-08-21 09:09:18.761357-05	\N	AS	366
128	2017-08-21 09:51:23.956496-05	\N	AS	367
129	2017-08-21 13:42:02.563026-05	\N	AS	368
122	2017-08-19 11:43:29.582693-05	\N	AS	361
123	2017-08-19 11:50:25.92541-05	\N	AS	362
124	2017-08-19 12:29:15.729428-05	\N	AS	363
121	2017-08-19 11:31:44.396293-05	\N	AS	360
120	2017-08-19 11:20:46.66804-05	\N	AS	359
119	2017-08-19 11:16:41.544649-05	\N	AS	358
118	2017-08-19 10:58:23.894396-05	\N	AS	357
117	2017-08-19 10:44:12.280064-05	\N	AS	356
116	2017-08-19 09:49:47.19159-05	\N	AS	355
115	2017-08-19 09:47:42.961289-05	\N	AS	354
114	2017-08-19 09:08:06.778799-05	\N	AS	353
149	2017-08-24 08:22:42.319468-05	\N	AS	388
130	2017-08-22 08:33:33.098949-05	\N	AS	369
131	2017-08-22 10:27:01.47022-05	\N	AS	370
133	2017-08-22 10:29:37.466507-05	\N	AS	372
134	2017-08-22 12:51:40.926885-05	\N	AS	373
150	2017-08-24 08:23:21.241608-05	\N	AS	389
151	2017-08-24 08:33:35.290905-05	\N	AS	390
143	2017-08-23 11:41:43.210967-05	\N	AS	382
142	2017-08-23 11:39:11.072437-05	\N	AS	381
141	2017-08-23 11:37:40.418528-05	\N	AS	380
140	2017-08-23 10:54:33.189597-05	\N	AS	379
145	2017-08-23 11:43:53.751898-05	\N	AS	384
144	2017-08-23 11:43:17.930885-05	\N	AS	383
147	2017-08-23 14:04:29.727798-05	\N	AS	386
146	2017-08-23 11:44:43.839247-05	\N	AS	385
139	2017-08-23 10:49:06.797969-05	\N	AS	378
138	2017-08-23 09:42:11.129037-05	\N	AS	377
137	2017-08-23 09:06:09.297601-05	\N	AS	376
152	2017-08-24 08:50:54.90985-05	\N	AS	391
153	2017-08-24 10:07:56.790415-05	\N	AS	392
148	2017-08-24 07:31:19.332772-05	\N	AS	387
154	2017-08-24 11:13:57.658115-05	\N	AS	393
155	2017-08-24 12:36:55.965613-05	\N	AS	394
156	2017-08-24 13:16:14.734175-05	\N	AS	395
157	2017-08-24 13:20:33.672819-05	\N	AS	396
159	2017-08-25 09:08:41.952941-05	\N	AS	398
160	2017-08-25 09:10:58.260403-05	\N	AS	399
163	2017-08-25 13:03:08.832732-05	\N	AS	402
165	2017-08-26 10:08:48.340379-05	\N	AS	404
164	2017-08-25 13:05:12.841934-05	\N	AS	403
161	2017-08-25 09:52:50.015794-05	\N	AS	400
209	2017-09-01 09:36:35.794952-05	\N	AS	448
162	2017-08-25 12:21:52.648773-05	\N	AS	401
158	2017-08-25 08:46:08.398286-05	\N	AS	397
264	2017-09-07 12:35:09.525452-05	\N	AS	503
170	2017-08-26 12:05:40.106988-05	\N	AS	409
169	2017-08-26 11:38:13.867446-05	\N	AS	408
168	2017-08-26 11:35:18.723894-05	\N	AS	407
167	2017-08-26 11:08:04.419411-05	\N	AS	406
166	2017-08-26 10:58:18.111984-05	\N	AS	405
263	2017-09-07 12:11:08.558864-05	\N	AS	502
203	2017-09-01 07:48:20.261108-05	\N	AS	442
207	2017-09-01 09:27:28.959156-05	\N	AS	446
208	2017-09-01 09:32:12.08281-05	\N	AS	447
210	2017-09-01 09:48:59.404846-05	\N	AS	449
211	2017-09-01 09:51:50.797966-05	\N	AS	450
212	2017-09-01 10:11:09.875321-05	\N	AS	451
179	2017-08-29 09:15:43.074228-05	\N	AS	418
178	2017-08-29 08:33:20.166092-05	\N	AS	417
177	2017-08-28 13:33:54.680863-05	\N	AS	416
176	2017-08-28 13:19:58.635946-05	\N	AS	415
175	2017-08-28 13:18:24.330617-05	\N	AS	414
174	2017-08-28 12:51:16.327694-05	\N	AS	413
173	2017-08-28 12:34:54.450736-05	\N	AS	412
172	2017-08-28 10:52:17.281149-05	\N	AS	411
171	2017-08-28 08:25:07.826202-05	\N	AS	410
213	2017-09-01 10:41:20.758165-05	\N	AS	452
180	2017-08-29 10:20:33.558164-05	\N	AS	419
181	2017-08-29 10:59:49.356411-05	\N	AS	420
182	2017-08-29 11:20:58.683207-05	\N	AS	421
262	2017-09-07 10:49:17.725814-05	\N	AS	501
261	2017-09-07 08:58:24.378219-05	\N	AS	500
183	2017-08-29 11:47:55.817707-05	\N	AS	422
184	2017-08-29 12:40:30.563563-05	\N	AS	423
186	2017-08-30 09:49:32.800791-05	\N	AS	425
185	2017-08-29 13:24:53.259183-05	\N	AS	424
187	2017-08-30 10:28:02.265338-05	\N	AS	426
189	2017-08-30 12:25:49.285799-05	\N	AS	428
188	2017-08-30 11:31:45.41792-05	\N	AS	427
190	2017-08-30 12:53:21.72677-05	\N	AS	429
295	2017-09-11 12:24:59.483961-05	\N	AS	534
192	2017-08-31 09:35:37.132581-05	\N	AS	431
194	2017-08-31 10:09:22.695148-05	\N	AS	433
193	2017-08-31 09:36:43.715623-05	\N	AS	432
195	2017-08-31 11:17:55.23273-05	\N	AS	434
196	2017-08-31 11:41:36.753729-05	\N	AS	435
197	2017-08-31 12:03:10.854315-05	\N	AS	436
198	2017-08-31 12:07:20.08855-05	\N	AS	437
199	2017-08-31 12:25:54.578144-05	\N	AS	438
200	2017-08-31 12:27:19.68792-05	\N	AS	439
201	2017-08-31 12:43:56.984795-05	\N	AS	440
202	2017-08-31 13:36:41.964679-05	\N	AS	441
214	2017-09-01 11:38:20.078251-05	\N	AS	453
215	2017-09-01 12:46:40.219991-05	\N	AS	454
216	2017-09-01 13:13:04.311442-05	\N	AS	455
217	2017-09-01 13:13:23.562577-05	\N	AS	456
218	2017-09-01 13:18:05.909675-05	\N	AS	457
219	2017-09-01 14:15:35.347629-05	\N	AS	458
220	2017-09-02 07:31:28.748501-05	\N	AS	459
221	2017-09-02 09:25:46.0687-05	\N	AS	460
222	2017-09-02 09:40:12.781015-05	\N	AS	461
223	2017-09-02 09:41:54.119863-05	\N	AS	462
224	2017-09-02 09:59:47.620109-05	\N	AS	463
225	2017-09-02 10:41:50.293029-05	\N	AS	464
226	2017-09-02 11:29:55.942845-05	\N	AS	465
227	2017-09-02 12:23:04.960512-05	\N	AS	466
229	2017-09-04 07:42:36.70682-05	\N	AS	468
242	2017-09-05 10:28:04.553979-05	\N	AS	481
243	2017-09-05 11:19:14.461554-05	\N	AS	482
244	2017-09-05 12:45:55.886103-05	\N	AS	483
245	2017-09-05 13:01:48.728456-05	\N	AS	484
246	2017-09-06 07:59:55.969679-05	\N	AS	485
247	2017-09-06 08:14:11.642243-05	\N	AS	486
248	2017-09-06 08:32:41.834613-05	\N	AS	487
249	2017-09-06 09:26:30.619012-05	\N	AS	488
250	2017-09-06 09:40:08.106213-05	\N	AS	489
251	2017-09-06 09:43:11.032829-05	\N	AS	490
230	2017-09-04 08:55:07.960551-05	\N	AS	469
231	2017-09-04 08:55:53.676884-05	\N	AS	470
232	2017-09-04 09:48:46.74094-05	\N	AS	471
233	2017-09-04 10:28:02.412086-05	\N	AS	472
234	2017-09-04 10:45:39.317546-05	\N	AS	473
235	2017-09-04 11:06:41.372611-05	\N	AS	474
236	2017-09-04 11:24:38.796835-05	\N	AS	475
237	2017-09-04 11:29:05.56003-05	\N	AS	476
238	2017-09-04 11:38:31.106198-05	\N	AS	477
239	2017-09-04 11:55:22.303545-05	\N	AS	478
240	2017-09-04 12:21:26.297165-05	\N	AS	479
252	2017-09-06 09:43:53.011182-05	\N	AS	491
241	2017-09-04 13:27:51.777843-05	\N	AS	480
294	2017-09-11 11:40:43.536854-05	\N	AS	533
271	2017-09-08 11:41:17.091811-05	\N	AS	510
270	2017-09-08 11:13:55.887359-05	\N	AS	509
269	2017-09-08 10:41:07.994723-05	\N	AS	508
268	2017-09-08 10:34:30.264145-05	\N	AS	507
259	2017-09-06 12:57:41.742126-05	\N	AS	498
258	2017-09-06 12:33:50.275599-05	\N	AS	497
257	2017-09-06 11:53:57.724368-05	\N	AS	496
256	2017-09-06 11:38:57.622008-05	\N	AS	495
255	2017-09-06 11:20:26.93982-05	\N	AS	494
267	2017-09-08 10:29:17.641749-05	\N	AS	506
272	2017-09-09 08:17:12.466544-05	\N	AS	511
274	2017-09-09 08:20:31.820415-05	\N	AS	513
266	2017-09-08 10:28:26.887755-05	\N	AS	505
265	2017-09-07 12:36:36.278539-05	\N	AS	504
296	2017-09-11 13:14:07.514115-05	\N	AS	535
276	2017-09-09 09:25:57.685893-05	\N	AS	515
277	2017-09-09 09:39:35.939329-05	\N	AS	516
306	2017-09-13 08:59:48.067868-05	\N	AS	545
278	2017-09-09 09:46:05.940183-05	\N	AS	517
281	2017-09-09 10:44:50.168886-05	\N	AS	520
279	2017-09-09 09:50:03.157506-05	\N	AS	518
283	2017-09-09 11:40:38.512238-05	\N	AS	522
282	2017-09-09 10:49:13.465242-05	\N	AS	521
284	2017-09-09 12:07:20.438044-05	\N	AS	523
285	2017-09-09 13:38:38.320703-05	\N	AS	524
286	2017-09-09 13:51:03.57452-05	\N	AS	525
301	2017-09-12 11:47:37.897899-05	\N	AS	540
302	2017-09-12 12:27:23.121537-05	\N	AS	541
287	2017-09-11 08:54:53.03902-05	\N	AS	526
288	2017-09-11 09:04:41.219372-05	\N	AS	527
289	2017-09-11 09:51:07.421738-05	\N	AS	528
290	2017-09-11 10:27:01.050128-05	\N	AS	529
291	2017-09-11 10:41:50.073558-05	\N	AS	530
292	2017-09-11 10:44:08.967624-05	\N	AS	531
293	2017-09-11 11:12:16.71932-05	\N	AS	532
303	2017-09-12 13:27:13.426889-05	\N	AS	542
307	2017-09-13 08:59:49.821008-05	\N	AS	546
297	2017-09-12 08:21:25.965193-05	\N	AS	536
298	2017-09-12 09:53:40.42365-05	\N	AS	537
299	2017-09-12 09:54:46.711249-05	\N	AS	538
300	2017-09-12 11:35:44.381428-05	\N	AS	539
305	2017-09-13 08:59:47.958424-05	\N	AS	544
308	2017-09-13 08:59:49.825299-05	\N	AS	547
309	2017-09-13 11:02:18.136082-05	\N	AS	548
310	2017-09-13 11:31:52.205541-05	\N	AS	549
312	2017-09-14 13:17:43.77941-05	\N	AS	551
314	2017-09-15 10:30:38.003815-05	\N	AS	553
311	2017-09-14 08:34:03.34557-05	\N	AS	550
316	2017-09-15 10:43:26.170434-05	\N	AS	555
313	2017-09-15 09:20:28.630061-05	\N	AS	552
317	2017-09-15 11:02:49.08896-05	\N	AS	556
315	2017-09-15 10:40:44.808495-05	\N	AS	554
318	2017-09-15 11:40:57.640944-05	\N	AS	557
319	2017-09-15 11:40:57.763744-05	\N	AS	558
368	2017-09-25 11:18:35.490477-05	\N	AS	607
369	2017-09-25 11:38:03.198244-05	\N	AS	608
370	2017-09-25 11:45:43.254918-05	\N	AS	609
371	2017-09-25 12:52:11.817097-05	\N	AS	610
397	2017-09-29 07:06:10.143929-05	\N	AS	636
304	2017-09-13 08:33:46.785043-05	\N	AS	543
398	2017-09-29 07:07:27.800738-05	\N	AS	637
399	2017-09-29 07:44:21.662497-05	\N	AS	638
320	2017-09-15 11:40:57.909284-05	\N	AS	559
321	2017-09-15 11:48:44.542889-05	\N	AS	560
322	2017-09-15 11:56:54.859518-05	\N	AS	561
323	2017-09-15 12:17:01.802542-05	\N	AS	562
324	2017-09-15 12:35:28.069878-05	\N	AS	563
326	2017-09-15 12:56:54.52625-05	\N	AS	565
327	2017-09-18 07:25:57.606863-05	\N	AS	566
328	2017-09-18 08:46:14.325096-05	\N	AS	567
329	2017-09-18 09:31:02.118054-05	\N	AS	568
330	2017-09-18 10:01:26.785753-05	\N	AS	569
331	2017-09-18 10:06:32.9096-05	\N	AS	570
400	2017-09-29 09:13:59.184737-05	\N	AS	639
401	2017-09-29 09:15:32.007772-05	\N	AS	640
332	2017-09-18 11:46:11.585486-05	\N	AS	571
333	2017-09-18 12:34:08.217926-05	\N	AS	572
334	2017-09-19 10:34:14.28471-05	\N	AS	573
335	2017-09-19 11:34:09.962596-05	\N	AS	574
402	2017-09-29 09:23:45.379912-05	\N	AS	641
404	2017-09-29 09:35:23.45638-05	\N	AS	643
336	2017-09-20 09:00:16.408544-05	\N	AS	575
437	2017-10-04 13:38:43.58645-05	\N	AS	676
405	2017-09-29 11:20:43.304865-05	\N	AS	644
338	2017-09-20 09:12:51.033673-05	\N	AS	577
339	2017-09-20 10:55:12.119365-05	\N	AS	578
340	2017-09-20 12:29:10.898545-05	\N	AS	579
341	2017-09-21 08:37:44.349467-05	\N	AS	580
342	2017-09-21 09:18:58.009514-05	\N	AS	581
344	2017-09-21 09:47:03.462158-05	\N	AS	583
343	2017-09-21 09:46:06.595888-05	\N	AS	582
345	2017-09-21 10:23:33.104632-05	\N	AS	584
346	2017-09-21 11:37:20.006847-05	\N	AS	585
347	2017-09-21 12:58:15.352138-05	\N	AS	586
382	2017-09-28 09:06:29.687654-05	\N	AS	621
438	2017-10-04 13:53:12.005486-05	\N	AS	677
374	2017-09-26 12:03:27.019579-05	\N	AS	613
379	2017-09-27 12:03:44.818601-05	\N	AS	618
372	2017-09-26 07:39:36.356263-05	\N	AS	611
351	2017-09-22 08:43:49.668495-05	\N	AS	590
352	2017-09-22 08:45:43.349352-05	\N	AS	591
353	2017-09-22 09:56:47.415902-05	\N	AS	592
373	2017-09-26 08:16:21.776827-05	\N	AS	612
375	2017-09-26 12:05:23.435426-05	\N	AS	614
377	2017-09-27 12:02:11.022486-05	\N	AS	616
378	2017-09-27 12:03:24.288218-05	\N	AS	617
380	2017-09-27 12:04:04.587401-05	\N	AS	619
381	2017-09-27 13:39:26.779877-05	\N	AS	620
384	2017-09-28 09:48:46.514422-05	\N	AS	623
406	2017-09-29 11:47:02.031222-05	\N	AS	645
407	2017-09-30 09:49:10.074013-05	\N	AS	646
355	2017-09-23 08:58:51.075628-05	\N	AS	594
356	2017-09-23 10:16:57.96471-05	\N	AS	595
357	2017-09-23 10:54:22.946324-05	\N	AS	596
362	2017-09-23 11:14:04.372692-05	\N	AS	601
363	2017-09-23 11:32:37.349546-05	\N	AS	602
364	2017-09-23 11:48:42.979997-05	\N	AS	603
365	2017-09-23 13:38:48.105382-05	\N	AS	604
408	2017-09-30 09:49:47.042865-05	\N	AS	647
366	2017-09-25 09:25:27.829599-05	\N	AS	605
409	2017-09-30 10:21:20.395594-05	\N	AS	648
410	2017-09-30 10:23:56.375028-05	\N	AS	649
411	2017-09-30 11:16:41.390442-05	\N	AS	650
421	2017-10-03 08:28:03.777626-05	\N	AS	660
422	2017-10-03 09:03:13.964455-05	\N	AS	661
424	2017-10-03 09:46:45.486245-05	\N	AS	663
423	2017-10-03 09:41:16.799287-05	\N	AS	662
425	2017-10-03 10:32:53.568282-05	\N	AS	664
412	2017-09-30 11:32:23.276337-05	\N	AS	651
426	2017-10-03 10:35:34.353729-05	\N	AS	665
427	2017-10-03 11:13:25.560065-05	\N	AS	666
385	2017-09-28 10:30:42.378288-05	\N	AS	624
386	2017-09-28 10:59:04.048461-05	\N	AS	625
387	2017-09-29 06:43:23.901276-05	\N	AS	626
388	2017-09-29 06:44:37.19014-05	\N	AS	627
389	2017-09-29 06:46:33.87985-05	\N	AS	628
390	2017-09-29 06:48:17.498264-05	\N	AS	629
391	2017-09-29 06:49:56.776082-05	\N	AS	630
392	2017-09-29 06:51:40.20732-05	\N	AS	631
393	2017-09-29 06:53:11.836073-05	\N	AS	632
394	2017-09-29 06:54:28.002797-05	\N	AS	633
395	2017-09-29 06:56:24.860098-05	\N	AS	634
396	2017-09-29 06:59:36.409563-05	\N	AS	635
413	2017-09-30 11:40:09.360248-05	\N	AS	652
429	2017-10-03 12:13:08.290168-05	\N	AS	668
414	2017-09-30 12:18:08.720456-05	\N	AS	653
428	2017-10-03 11:34:07.572341-05	\N	AS	667
415	2017-10-02 07:56:19.884608-05	\N	AS	654
430	2017-10-03 12:40:49.558145-05	\N	AS	669
416	2017-10-02 08:45:33.774765-05	\N	AS	655
460	2017-10-07 09:48:53.817679-05	\N	AS	699
418	2017-10-02 12:18:41.255174-05	\N	AS	657
419	2017-10-02 12:20:35.275053-05	\N	AS	658
420	2017-10-02 12:30:07.482164-05	\N	AS	659
431	2017-10-04 08:40:28.434644-05	\N	AS	670
461	2017-10-07 09:48:55.605448-05	\N	AS	700
432	2017-10-04 11:24:10.648498-05	\N	AS	671
433	2017-10-04 11:48:36.552331-05	\N	AS	672
434	2017-10-04 12:03:53.296985-05	\N	AS	673
462	2017-10-07 10:25:29.295095-05	\N	AS	701
439	2017-10-05 08:48:07.39019-05	\N	AS	678
441	2017-10-05 11:12:03.879018-05	\N	AS	680
440	2017-10-05 10:22:22.401598-05	\N	AS	679
442	2017-10-05 11:21:03.336081-05	\N	AS	681
443	2017-10-05 11:41:36.907687-05	\N	AS	682
444	2017-10-05 12:04:23.775334-05	\N	AS	683
445	2017-10-05 12:30:08.402268-05	\N	AS	684
446	2017-10-05 13:21:18.5151-05	\N	AS	685
447	2017-10-05 13:27:54.312473-05	\N	AS	686
463	2017-10-07 10:28:10.263478-05	\N	AS	702
464	2017-10-07 11:25:03.332931-05	\N	AS	703
449	2017-10-06 07:40:41.896996-05	\N	AS	688
451	2017-10-06 09:13:12.156233-05	\N	AS	690
452	2017-10-06 09:40:43.38618-05	\N	AS	691
454	2017-10-06 09:56:52.194504-05	\N	AS	693
455	2017-10-06 10:13:41.652173-05	\N	AS	694
456	2017-10-06 10:37:11.469522-05	\N	AS	695
457	2017-10-06 11:35:47.705341-05	\N	AS	696
458	2017-10-06 13:21:20.398606-05	\N	AS	697
465	2017-10-07 12:00:13.681104-05	\N	AS	704
466	2017-10-07 12:38:40.294928-05	\N	AS	705
467	2017-10-07 13:26:28.009812-05	\N	AS	706
468	2017-10-07 14:29:26.347971-05	\N	AS	707
469	2017-10-07 14:30:49.511455-05	\N	AS	708
470	2017-10-07 14:31:10.505735-05	\N	AS	709
471	2017-10-07 14:58:34.010319-05	\N	AS	710
472	2017-10-09 07:52:40.137241-05	\N	AS	711
473	2017-10-09 08:49:51.608299-05	\N	AS	712
474	2017-10-09 09:44:19.790948-05	\N	AS	713
459	2017-10-07 08:48:37.637802-05	\N	AS	698
475	2017-10-09 10:19:27.8501-05	\N	AS	714
476	2017-10-09 10:19:51.418563-05	\N	AS	715
477	2017-10-09 10:52:42.243084-05	\N	AS	716
479	2017-10-09 11:53:12.677345-05	\N	AS	718
478	2017-10-09 11:52:54.379347-05	\N	AS	717
480	2017-10-10 11:19:18.037713-05	\N	AS	719
481	2017-10-10 11:27:44.362845-05	\N	AS	720
482	2017-10-10 11:36:12.132417-05	\N	AS	721
483	2017-10-10 12:03:25.580213-05	\N	AS	722
484	2017-10-10 12:04:29.77503-05	\N	AS	723
485	2017-10-10 12:33:44.741773-05	\N	AS	724
486	2017-10-10 12:38:19.944906-05	\N	AS	725
487	2017-10-10 12:55:34.549611-05	\N	AS	726
488	2017-10-10 12:57:47.610632-05	\N	AS	727
489	2017-10-10 13:18:42.634139-05	\N	AS	728
490	2017-10-11 07:51:43.188471-05	\N	AS	729
491	2017-10-11 08:27:43.859378-05	\N	AS	730
492	2017-10-11 09:30:56.493853-05	\N	AS	731
493	2017-10-11 09:43:40.123645-05	\N	AS	732
494	2017-10-11 10:24:35.002001-05	\N	AS	733
495	2017-10-11 12:12:34.936202-05	\N	AS	734
496	2017-10-11 12:33:01.057796-05	\N	AS	735
498	2017-10-11 13:12:13.639767-05	\N	AS	737
499	2018-01-13 14:03:02.820547-06	\N	PE	738
500	2018-01-13 14:13:38.732657-06	\N	PE	739
501	2018-01-15 18:03:51.225573-06	\N	PE	740
502	2018-01-15 21:18:40.54878-06	\N	PE	741
503	2018-01-16 02:44:04.24-06	\N	PE	742
\.


--
-- Name: kitchen_processedproduct_id_seq; Type: SEQUENCE SET; Schema: public; Owner: digimundo
--

SELECT pg_catalog.setval('kitchen_processedproduct_id_seq', 503, true);


--
-- Data for Name: orders_customerorder; Type: TABLE DATA; Schema: public; Owner: digimundo
--

COPY orders_customerorder (delivery_date, id, created_at, status, latitude, longitude, price, score, pin, customer_user_id) FROM stdin;
\.


--
-- Name: orders_customerorder_id_seq; Type: SEQUENCE SET; Schema: public; Owner: digimundo
--

SELECT pg_catalog.setval('orders_customerorder_id_seq', 1, false);


--
-- Data for Name: orders_customerorderdetail; Type: TABLE DATA; Schema: public; Owner: digimundo
--

COPY orders_customerorderdetail (id, quantity, cartridge_id, customer_order_id, package_cartridge_id) FROM stdin;
\.


--
-- Name: orders_customerorderdetail_id_seq; Type: SEQUENCE SET; Schema: public; Owner: digimundo
--

SELECT pg_catalog.setval('orders_customerorderdetail_id_seq', 1, false);


--
-- Data for Name: orders_supplierorder; Type: TABLE DATA; Schema: public; Owner: digimundo
--

COPY orders_supplierorder (id, created_at, status, assigned_dealer_id) FROM stdin;
\.


--
-- Name: orders_supplierorder_id_seq; Type: SEQUENCE SET; Schema: public; Owner: digimundo
--

SELECT pg_catalog.setval('orders_supplierorder_id_seq', 1, false);


--
-- Data for Name: orders_supplierorderdetail; Type: TABLE DATA; Schema: public; Owner: digimundo
--

COPY orders_supplierorderdetail (id, quantity, cost, order_id, supplier_id, supply_id) FROM stdin;
\.


--
-- Name: orders_supplierorderdetail_id_seq; Type: SEQUENCE SET; Schema: public; Owner: digimundo
--

SELECT pg_catalog.setval('orders_supplierorderdetail_id_seq', 1, false);


--
-- Data for Name: products_brand; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY products_brand (id, name, created_at) FROM stdin;
\.


--
-- Name: products_brand_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('products_brand_id_seq', 1, false);


--
-- Data for Name: products_cartridge; Type: TABLE DATA; Schema: public; Owner: digimundo
--

COPY products_cartridge (id, name, description, price, category, subcategory, created_at, image, is_active, kitchen_assembly_id) FROM stdin;
16	Licuado de Guayaba	Cartridge description	24.00	CO	SM	2017-09-23 02:49:49.308933-05	cartridges/licuado-guayaba.jpg	t	1
3	Vegetariano	Cartridge description	35.00	FD	RO	2017-09-23 02:55:34.903176-05	cartridges/9585d9c2-e526-4a4b-9c6c-1b02438f88a1.jpg	t	3
33	Licuado de Mango con Leche	Cartridge description	24.00	CO	SM	2017-09-23 02:49:49.366281-05	cartridges/licuado-mango-leche.jpg	t	1
17	Licuado de Papaya	Cartridge description	24.00	CO	SM	2017-09-23 02:49:49.48487-05	cartridges/licuado-papaya.jpg	t	1
10	Champiñones con Salsa Agridulce	Cartridge description	35.00	FD	RO	2017-09-23 02:47:33.714514-05	cartridges/9585d9c2-e526-4a4b-9c6c-1b02438f88a1.jpg	t	3
1	Chilaquiles	Chilaquiles bañados en salsa con un toque de chile abanero, sasonado con ajo y epazote	35.00	FD	RO	2017-09-23 02:47:33.930306-05	cartridges/9585d9c2-e526-4a4b-9c6c-1b02438f88a1.jpg	t	3
5	Choriqueso	Cartridge description	35.00	FD	RO	2017-09-23 02:47:34.039453-05	cartridges/9585d9c2-e526-4a4b-9c6c-1b02438f88a1.jpg	t	3
14	Licuado de Platano	Cartridge description	24.00	CO	SM	2017-09-23 02:49:49.542231-05	cartridges/licuado-platano.jpg	t	1
28	Agua de Fresa	Cartridge description	19.00	CO	WA	2017-09-23 02:41:00.063584-05	cartridges/refresco-agua-frutas-hielo.jpg	t	1
29	Agua de Guayaba	Cartridge description	19.00	CO	WA	2017-09-23 02:41:13.684208-05	cartridges/refresco-agua-frutas-hielo.jpg	t	1
32	Agua de Horchata	Cartridge description	19.00	CO	WA	2017-09-23 02:41:51.77577-05	cartridges/refresco-agua-frutas-hielo.jpg	t	1
19	Melón Picado	Cartridge description	19.00	CO	FR	2017-09-23 02:55:34.210579-05	cartridges/20141012_123038.jpg	t	1
20	Papaya Picada	Cartridge description	19.00	CO	FR	2017-09-23 02:55:34.462665-05	cartridges/22291073-Delicioso-picado-madura-fruta-de-la-papaya-en-el-fondo-blanco-Foto-de-archivo.jpg	t	1
12	Ensalada China	Cartridge description	69.00	FD	SA	2017-09-23 02:47:34.122084-05	cartridges/ensalada-2.png	t	1
11	Ensalada de Fresa	Cartridge description	69.00	FD	SA	2017-09-23 02:47:34.179202-05	cartridges/ensalada-2.png	t	1
13	Ensalada Suprema	Cartridge description	69.00	FD	SA	2017-09-23 02:47:34.258451-05	cartridges/ensalada-2.png	t	1
4	Jamón	Cartridge description	35.00	FD	RO	2017-09-23 02:49:48.539031-05	cartridges/9585d9c2-e526-4a4b-9c6c-1b02438f88a1.jpg	t	3
21	Jugo de Alfalfa con Pinguica	Cartridge description	19.00	CO	JU	2017-09-23 02:49:48.851293-05	cartridges/alfalfa.jpg	t	1
22	Jugo de Naranja	Cartridge description	19.00	CO	JU	2017-09-23 02:49:49.080688-05	cartridges/jugo-naranja.jpg	t	1
24	Jugo de Zanahoria	Cartridge description	19.00	CO	JU	2017-09-23 02:49:49.125606-05	cartridges/Jugo_De_Zanahoria.jpg	t	1
23	Jugo Verde	Cartridge description	19.00	CO	JU	2017-09-23 02:49:49.220131-05	cartridges/jugo-verde.jpg	t	1
2	Pollo Mostaza	Pollo deshebrado	35.00	FD	RO	2017-09-23 02:55:34.560445-05	cartridges/9585d9c2-e526-4a4b-9c6c-1b02438f88a1.jpg	t	3
30	Agua de Limón	Cartridge description	19.00	CO	WA	2017-09-23 02:41:52.679823-05	cartridges/refresco-agua-frutas-hielo.jpg	t	1
26	Agua de Melón	Cartridge description	19.00	CO	WA	2017-09-23 02:41:53.036985-05	cartridges/refresco-agua-frutas-hielo.jpg	t	1
27	Agua de Papaya	Cartridge description	19.00	CO	WA	2017-09-23 02:41:53.388852-05	cartridges/refresco-agua-frutas-hielo.jpg	t	1
25	Agua de Sandía	Cartridge description	19.00	CO	WA	2017-09-23 02:41:53.466264-05	cartridges/refresco-agua-frutas-hielo.jpg	t	1
31	Avena con Manzana	Cartridge description	19.00	CO	WA	2017-09-23 02:43:01.067799-05	cartridges/avena.jpg	t	1
7	Azteca	Cartridge description	35.00	FD	RO	2017-09-23 02:44:23.515491-05	cartridges/9585d9c2-e526-4a4b-9c6c-1b02438f88a1.jpg	t	3
15	Licuado de Fresa	Cartridge description	24.00	CO	SM	2017-09-23 02:49:49.253984-05	cartridges/licuado-fresa.jpg	t	1
8	Calabacita	Cartridge description	35.00	FD	RO	2017-09-23 02:44:34.371-05	cartridges/9585d9c2-e526-4a4b-9c6c-1b02438f88a1.jpg	t	3
9	Carne con Salsa Agridulce	Cartridge description	35.00	FD	RO	2017-09-23 02:47:33.120481-05	cartridges/9585d9c2-e526-4a4b-9c6c-1b02438f88a1.jpg	t	3
35	Champiñones con epazote	Cartridge description	35.00	FD	RO	2017-09-23 02:47:33.651912-05	cartridges/9585d9c2-e526-4a4b-9c6c-1b02438f88a1.jpg	t	3
34	Rajas	Cartridge description	35.00	FD	RO	2017-09-23 02:55:34.666998-05	cartridges/9585d9c2-e526-4a4b-9c6c-1b02438f88a1.jpg	t	3
18	Sandía Picada	Cartridge description	19.00	CO	FR	2017-09-23 02:55:34.734296-05	cartridges/images11.jpg	t	1
36	Tinga	Roti de Tinga	35.00	FD	RO	2017-09-23 02:55:34.786689-05	cartridges/9585d9c2-e526-4a4b-9c6c-1b02438f88a1.jpg	t	3
39	test	Cartridge description	100.00	FD	FR	2018-01-09 01:57:35.73201-06	cartridges/no_img.png	t	\N
38	Albóndigas	Roti de albóndigas	35.00	FD	RO	2017-10-04 11:43:06.392323-05	cartridges/9585d9c2-e526-4a4b-9c6c-1b02438f88a1.jpg	t	3
37	Fruta Picada	Cartridge description	19.00	CO	FR	2017-09-23 02:49:48.454615-05	cartridges/fruta-mixta.png	t	1
\.


--
-- Name: products_cartridge_id_seq; Type: SEQUENCE SET; Schema: public; Owner: digimundo
--

SELECT pg_catalog.setval('products_cartridge_id_seq', 39, true);


--
-- Data for Name: products_cartridgerecipe; Type: TABLE DATA; Schema: public; Owner: digimundo
--

COPY products_cartridgerecipe (id, quantity, cartridge_id, supply_id) FROM stdin;
\.


--
-- Name: products_cartridgerecipe_id_seq; Type: SEQUENCE SET; Schema: public; Owner: digimundo
--

SELECT pg_catalog.setval('products_cartridgerecipe_id_seq', 1, false);


--
-- Data for Name: products_extraingredient; Type: TABLE DATA; Schema: public; Owner: digimundo
--

COPY products_extraingredient (id, cost, ingredient_id, quantity) FROM stdin;
\.


--
-- Name: products_extraingredient_id_seq; Type: SEQUENCE SET; Schema: public; Owner: digimundo
--

SELECT pg_catalog.setval('products_extraingredient_id_seq', 1, false);


--
-- Data for Name: products_kitchenassembly; Type: TABLE DATA; Schema: public; Owner: digimundo
--

COPY products_kitchenassembly (id, name) FROM stdin;
1	CO
3	HO
\.


--
-- Name: products_kitchenassembly_id_seq; Type: SEQUENCE SET; Schema: public; Owner: digimundo
--

SELECT pg_catalog.setval('products_kitchenassembly_id_seq', 3, true);


--
-- Data for Name: products_packagecartridge; Type: TABLE DATA; Schema: public; Owner: digimundo
--

COPY products_packagecartridge (id, name, description, price, is_active, created_at, image) FROM stdin;
1	Pollo Mostaza Papaya Picada Agua de Horchata	Package description	59.00	t	2017-07-10 10:31:08.020604-05	
2	Pollo Mostaza Sandía Picada Papaya Picada	Package description	59.00	t	2017-07-10 19:56:08.810522-05	
3	Chilaquiles Sandía Picada Sandía Picada	Package description	59.00	t	2017-07-10 19:59:08.538629-05	
4	Carne con Salsa Agridulce Sandía Picada Sandía Picada	Package description	59.00	t	2017-07-11 05:23:39.647862-05	
5	Champiñones con Salsa Agridulce Naranja Sandía Picada	Package description	59.00	t	2017-07-11 06:38:12.181849-05	
6	Chilaquiles Jugo de Naranja Jugo de Naranja	Package description	59.00	t	2017-07-12 07:32:29.993751-05	
8	Champiñones con Salsa Agridulce Papaya Picada Avena con Manzana	Package description	59.00	t	2017-07-13 02:33:25.717785-05	
9	Carne con Salsa Agridulce Papaya Picada Jugo de Naranja	Package description	59.00	t	2017-07-13 04:26:53.662491-05	
10	Azteca Melón Picado Melón Picado	Package description	0.00	t	2017-07-14 02:32:43.063647-05	
11	Chilaquiles Melón Picado Jugo de Naranja	Package description	59.00	t	2017-07-15 03:41:13.755411-05	
12	Azteca Jugo Verde Papaya Picada	Package description	59.00	t	2017-07-15 05:05:48.7821-05	
13	Pollo Mostaza Jugo de Naranja Avena con Manzana	Package description	59.00	t	2017-07-15 06:01:22.905714-05	
14	Champiñones con Salsa Agridulce Jugo de Alfalfa con Pinguica Papaya Picada	Package description	59.00	t	2017-07-15 06:32:55.422522-05	
15	Choriqueso Sandía Picada Jugo de Zanahoria	Package description	59.00	t	2017-07-17 03:37:24.176693-05	
16	Chilaquiles Papaya Picada Jugo Verde	Package description	59.00	t	2017-07-17 04:26:59.035428-05	
17	Choriqueso Sandía Picada Agua de Melón	Package description	59.00	t	2017-07-17 07:05:28.431431-05	
18	Carne con Salsa Agridulce Agua de Sandía Jugo de Zanahoria	Package description	59.00	t	2017-07-17 07:21:43.206281-05	
19	Pollo Mostaza Jugo de Zanahoria Papaya Picada	Package description	59.00	t	2017-07-18 04:07:03.607801-05	
20	Rajas Jugo de Alfalfa con Pinguica Sandía Picada	Package description	59.00	t	2017-07-19 02:51:16.476449-05	
21	Champiñones con Salsa Agridulce Melón Picado Jugo Verde	Package description	59.00	t	2017-07-19 04:55:16.926862-05	
22	Carne con Salsa Agridulce Jugo Verde Jugo Verde	Package description	59.00	t	2017-07-20 05:02:56.226776-05	
23	Jamón Jugo Verde Sandía Picada	Package description	59.00	t	2017-07-20 05:33:47.496214-05	
24	Carne con Salsa Agridulce Agua de Fresa Jugo Verde	Package description	59.00	t	2017-07-20 05:36:26.006087-05	
25	Vegetariano Sandía Picada Jugo de Naranja	Package description	59.00	t	2017-07-21 02:41:09.266469-05	
26	Carne con Salsa Agridulce Jugo de Naranja Melón Picado	Package description	59.00	t	2017-07-21 03:39:16.844393-05	
27	Vegetariano Jugo de Naranja Melón Picado	Package description	59.00	t	2017-07-21 06:24:01.552792-05	
28	Carne con Salsa Agridulce Jugo de Naranja Agua de Fresa	Package description	59.00	t	2017-07-21 06:37:17.983344-05	
29	Vegetariano Sandía Picada Papaya Picada	Package description	59.00	t	2017-07-22 02:55:43.432499-05	
30	Azteca Jugo Verde Agua de Papaya	Package description	59.00	t	2017-07-22 04:13:40.348588-05	
31	Rajas Agua de Horchata Sandía Picada	Package description	59.00	t	2017-07-22 04:19:36.88668-05	
32	Chilaquiles Jugo Verde Jugo de Zanahoria	Package description	59.00	t	2017-07-22 04:19:36.957974-05	
33	Chilaquiles Papaya Picada Jugo de Naranja	Package description	59.00	t	2017-07-22 05:11:49.437958-05	
34	Carne con Salsa Agridulce Sandía Picada Agua de Horchata	Package description	59.00	t	2017-07-22 07:21:29.201634-05	
35	Pollo Mostaza Jugo de Naranja Melón Picado	Package description	59.00	t	2017-07-24 04:14:39.552518-05	
36	Carne con Salsa Agridulce Agua de Sandía Papaya Picada	Package description	59.00	t	2017-07-27 06:33:11.832822-05	
37	Azteca Agua de Limón Sandía Picada	Package description	59.00	t	2017-07-27 07:40:27.702021-05	
38	Jamón Jugo de Naranja Agua de Fresa	Package description	59.00	t	2017-07-28 05:43:24.618615-05	
39	Choriqueso Jugo de Zanahoria Melón Picado	Package description	59.00	t	2017-07-28 05:56:06.549718-05	
40	Choriqueso Sandía Picada Agua de Horchata	Package description	59.00	t	2017-07-28 08:14:48.669221-05	
41	Chilaquiles Melón Picado Agua de Horchata	Package description	59.00	t	2017-07-29 06:22:45.992449-05	
42	Jamón Avena con Manzana Sandía Picada	Package description	59.00	t	2017-07-29 06:23:39.544978-05	
43	Choriqueso Agua de Horchata Melón Picado	Package description	59.00	t	2017-07-29 07:21:29.026353-05	
44	Calabazita Jugo Verde Sandía Picada	Package description	59.00	t	2017-07-29 07:59:59.099892-05	
45	Calabazita Jugo de Naranja Sandía Picada	Package description	59.00	t	2017-07-29 07:59:59.18269-05	
46	Carne con Salsa Agridulce Jugo Verde Sandía Picada	Package description	59.00	t	2017-07-29 08:01:25.048875-05	
47	Pollo Mostaza Sandía Picada Avena con Manzana	Package description	59.00	t	2017-07-29 08:14:40.372258-05	
48	Carne con Salsa Agridulce Avena con Manzana Papaya Picada	Package description	59.00	t	2017-07-31 06:53:38.463753-05	
49	Carne con Salsa Agridulce Agua de Melón Sandía Picada	Package description	59.00	t	2017-07-31 09:08:17.319067-05	
50	Rajas Papaya Picada Jugo Verde	Package description	59.00	t	2017-08-01 03:49:49.623743-05	
51	Choriqueso Jugo de Naranja Agua de Fresa	Package description	59.00	t	2017-08-01 07:31:30.713195-05	
52	Jamón Sandía Picada Agua de Horchata	Package description	59.00	t	2017-08-01 07:56:20.372392-05	
53	Calabazita Papaya Picada Agua de Horchata	Package description	59.00	t	2017-08-02 05:20:15.051821-05	
54	Jamón Melón Picado Agua de Horchata	Package description	59.00	t	2017-08-02 06:45:52.707067-05	
55	Pollo Mostaza Melón Picado Agua de Horchata	Package description	59.00	t	2017-08-02 07:15:46.163028-05	
56	Choriqueso Papaya Picada Agua de Horchata	Package description	59.00	t	2017-08-02 07:18:39.410156-05	
57	Choriqueso Papaya Picada Avena con Manzana	Package description	59.00	t	2017-08-02 07:25:29.328357-05	
58	Carne con Salsa Agridulce Melón Picado Agua de Sandía	Package description	59.00	t	2017-08-02 07:47:46.001626-05	
59	Pollo Mostaza Agua de Limón Sandía Picada	Package description	59.00	t	2017-08-02 08:11:09.662047-05	
60	Rajas Sandía Picada Agua de Limón	Package description	59.00	t	2017-08-02 09:06:06.318334-05	
61	Chilaquiles Papaya Picada Agua de Horchata	Package description	59.00	t	2017-08-02 10:08:06.60769-05	
62	Azteca Sandía Picada Agua de Sandía	Package description	59.00	t	2017-08-03 07:23:08.169475-05	
63	Carne con Salsa Agridulce Melón Picado Agua de Horchata	Package description	59.00	t	2017-08-03 09:14:01.046709-05	
64	Chilaquiles Melón Picado Jugo Verde	Package description	59.00	t	2017-08-04 04:11:01.935294-05	
65	Rajas Jugo de Naranja Papaya Picada	Package description	59.00	t	2017-08-04 04:24:34.319589-05	
66	Choriqueso Sandía Picada Jugo de Naranja	Package description	59.00	t	2017-08-04 04:49:36.31973-05	
67	Champiñones con epazote Papaya Picada Agua de Horchata	Package description	59.00	t	2017-08-04 05:53:47.401051-05	
201	Calabazita Jugo Verde Jugo de Naranja	Package description	59.00	t	2017-08-05 14:15:07.822404-05	
202	Champiñones con epazote Sandía Picada Jugo de Naranja	Package description	59.00	t	2017-08-08 11:18:57.590936-05	
203	Carne con Salsa Agridulce Jugo de Naranja Agua de Horchata	Package description	59.00	t	2017-08-08 11:55:03.164471-05	
204	Jamón Melón Picado Jugo de Zanahoria	Package description	59.00	t	2017-08-10 08:01:23.160088-05	
205	Carne con Salsa Agridulce Papaya Picada Jugo de Alfalfa con Pinguica	Package description	59.00	t	2017-08-10 11:46:14.475691-05	
206	Calabazita Melón Picado Jugo de Alfalfa con Pinguica	Package description	59.00	t	2017-08-11 11:52:30.80394-05	
207	Pollo Mostaza Agua de Horchata Agua de Melón	Package description	59.00	t	2017-08-11 12:22:01.206519-05	
208	Chilaquiles Avena con Manzana Melón Picado	Package description	59.00	t	2017-08-12 09:19:26.984771-05	
209	Carne con Salsa Agridulce Avena con Manzana Sandía Picada	Package description	59.00	t	2017-08-12 13:13:11.266593-05	
210	Vegetariano Jugo de Naranja Papaya Picada	Package description	59.00	t	2017-08-14 11:38:08.593611-05	
211	Azteca Melón Picado Papaya Picada	Package description	59.00	t	2017-08-14 11:49:48.225293-05	
212	Jamón Melón Picado Agua de Guayaba	Package description	59.00	t	2017-08-16 08:12:48.491276-05	
213	Jamón Melón Picado Jugo de Naranja	Package description	59.00	t	2017-08-16 08:12:48.632644-05	
214	Champiñones con epazote Sandía Picada Jugo de Alfalfa con Pinguica	Package description	59.00	t	2017-08-16 08:52:18.438657-05	
215	Jamón Jugo de Alfalfa con Pinguica Papaya Picada	Package description	59.00	t	2017-08-16 09:59:30.538515-05	
216	Choriqueso Papaya Picada Jugo de Naranja	Package description	59.00	t	2017-08-16 10:01:00.433067-05	
217	Carne con Salsa Agridulce Melón Picado Agua de Limón	Package description	59.00	t	2017-08-17 09:15:03.262444-05	
218	Carne con Salsa Agridulce Melón Picado Jugo de Zanahoria	Package description	59.00	t	2017-08-17 09:16:07.879393-05	
219	Jamón Melón Picado Jugo de Alfalfa con Pinguica	Package description	59.00	t	2017-08-17 09:23:28.327511-05	
220	Choriqueso Melón Picado Jugo Verde	Package description	59.00	t	2017-08-17 10:09:11.14668-05	
221	Carne con Salsa Agridulce Papaya Picada Jugo Verde	Package description	59.00	t	2017-08-17 10:09:11.300089-05	
222	Choriqueso Papaya Picada Jugo de Alfalfa con Pinguica	Package description	59.00	t	2017-08-17 10:23:55.937863-05	
223	Choriqueso Papaya Picada Jugo Verde	Package description	59.00	t	2017-08-18 08:55:28.775089-05	
224	Pollo Mostaza Papaya Picada Jugo Verde	Package description	59.00	t	2017-08-18 09:22:08.716188-05	
225	Azteca Sandía Picada Jugo de Alfalfa con Pinguica	Package description	59.00	t	2017-08-18 09:47:40.393334-05	
226	Choriqueso Melón Picado Jugo de Alfalfa con Pinguica	Package description	59.00	t	2017-08-19 08:47:51.108213-05	
227	Pollo Mostaza Papaya Picada Jugo de Alfalfa con Pinguica	Package description	59.00	t	2017-08-19 08:47:51.273102-05	
228	Chilaquiles Papaya Picada Jugo de Alfalfa con Pinguica	Package description	59.00	t	2017-08-19 09:47:43.138113-05	
229	Jamón Jugo de Naranja Agua de Horchata	Package description	59.00	t	2017-08-19 11:16:41.710312-05	
230	Choriqueso Sandía Picada Agua de Guayaba	Package description	59.00	t	2017-08-19 12:29:15.897048-05	
231	Champiñones con epazote Avena con Manzana Papaya Picada	Package description	59.00	t	2017-08-22 12:51:41.097879-05	
232	Carne con Salsa Agridulce Avena con Manzana Melón Picado	Package description	59.00	t	2017-08-22 12:51:41.271715-05	
233	Choriqueso Sandía Picada Agua de Papaya	Package description	59.00	t	2017-08-23 11:37:40.593986-05	
234	Choriqueso Sandía Picada Agua de Sandía	Package description	59.00	t	2017-08-23 11:41:43.383801-05	
235	Choriqueso Melón Picado Avena con Manzana	Package description	59.00	t	2017-08-23 11:43:53.92999-05	
236	Chilaquiles Sandía Picada Jugo de Alfalfa con Pinguica	Package description	59.00	t	2017-08-24 08:22:42.498967-05	
237	Pollo Mostaza Sandía Picada Jugo de Alfalfa con Pinguica	Package description	59.00	t	2017-08-24 08:23:21.419001-05	
238	Chilaquiles Agua de Guayaba Avena con Manzana	Package description	59.00	t	2017-08-24 11:13:57.844519-05	
239	Chilaquiles Jugo de Alfalfa con Pinguica Agua de Horchata	Package description	59.00	t	2017-08-25 09:08:42.137121-05	
240	Chilaquiles Papaya Picada Avena con Manzana	Package description	59.00	t	2017-08-25 12:21:52.83375-05	
241	Chilaquiles Melón Picado Sandía Picada	Package description	59.00	t	2017-08-26 12:05:40.292339-05	
242	Carne con Salsa Agridulce Melón Picado Jugo de Alfalfa con Pinguica	Package description	59.00	t	2017-08-29 10:59:49.562673-05	
243	Carne con Salsa Agridulce Papaya Picada Jugo de Zanahoria	Package description	59.00	t	2017-08-29 11:47:56.013081-05	
244	Carne con Salsa Agridulce Sandía Picada Jugo de Alfalfa con Pinguica	Package description	59.00	t	2017-08-31 11:41:36.953571-05	
245	Azteca Melón Picado Jugo de Zanahoria	Package description	59.00	t	2017-08-31 12:43:57.181059-05	
246	Carne con Salsa Agridulce Sandía Picada Jugo de Naranja	Package description	59.00	t	2017-08-31 13:36:42.347496-05	
247	Pollo Mostaza Melón Picado Jugo de Alfalfa con Pinguica	Package description	59.00	t	2017-09-01 09:18:36.268342-05	
248	Vegetariano Melón Picado Jugo de Alfalfa con Pinguica	Package description	59.00	t	2017-09-01 10:11:10.07904-05	
249	Jamón Papaya Picada Jugo de Zanahoria	Package description	59.00	t	2017-09-02 09:41:54.327326-05	
250	Chilaquiles Melón Picado Agua de Limón	Package description	59.00	t	2017-09-04 09:48:46.949104-05	
251	Pollo Mostaza Papaya Picada Avena con Manzana	Package description	59.00	t	2017-09-04 10:28:02.609823-05	
252	Pollo Mostaza Papaya Picada Papaya Picada	Package description	59.00	t	2017-09-04 10:28:02.808015-05	
253	Chilaquiles Melón Picado Jugo de Alfalfa con Pinguica	Package description	59.00	t	2017-09-04 11:06:41.56991-05	
254	Chilaquiles Jugo de Naranja Sandía Picada	Package description	59.00	t	2017-09-05 10:28:04.963138-05	
255	Choriqueso Sandía Picada Avena con Manzana	Package description	59.00	t	2017-09-06 07:59:56.173511-05	
256	Jamón Papaya Picada Jugo Verde	Package description	59.00	t	2017-09-06 09:26:30.820482-05	
257	Azteca Melón Picado Jugo de Alfalfa con Pinguica	Package description	59.00	t	2017-09-06 09:56:39.086294-05	
258	Choriqueso Sandía Picada Jugo de Alfalfa con Pinguica	Package description	59.00	t	2017-09-08 10:28:27.107075-05	
259	Rajas Sandía Picada Jugo de Naranja	Package description	59.00	t	2017-09-08 10:34:30.88934-05	
260	Rajas Melón Picado Jugo de Naranja	Package description	59.00	t	2017-09-08 11:13:56.104314-05	
200	Azteca Papaya Picada Agua de Fresa	Package description	59.00	t	2017-09-11 16:56:31.373373-05	cartridges/9585d9c2-e526-4a4b-9c6c-1b02438f88a1_2li4cPV.jpg
69	Rajas Melón Picado Jugo de Alfalfa con Pinguica	Package description	59.00	t	2017-09-11 16:57:50.120442-05	cartridges/9585d9c2-e526-4a4b-9c6c-1b02438f88a1_ZWvYpbv.jpg
261	Pollo Mostaza Agua de Horchata Avena con Manzana	Package description	59.00	t	2017-09-08 11:41:17.306476-05	
262	Choriqueso Melón Picado Jugo de Naranja	Package description	59.00	t	2017-09-09 08:17:12.893196-05	
263	Champiñones con epazote Melón Picado Jugo de Zanahoria	Package description	59.00	t	2017-09-09 08:17:13.110594-05	
264	Jamón Jugo Verde Jugo de Zanahoria	Package description	59.00	t	2017-09-09 08:17:13.329808-05	
265	Rajas Jugo de Alfalfa con Pinguica Melón Picado	Package description	59.00	t	2017-09-09 09:25:58.344486-05	
266	Pollo Mostaza Jugo Verde Melón Picado	Package description	59.00	t	2017-09-09 09:50:03.381046-05	
267	Choriqueso Agua de Papaya Jugo Verde	Package description	59.00	t	2017-09-09 13:38:38.546152-05	
268	Jamón Sandía Picada Agua de Guayaba	Package description	59.00	t	2017-09-11 09:04:41.453333-05	
269	Jamón Papaya Picada Agua de Papaya	Package description	59.00	t	2017-09-11 09:51:07.651847-05	
270	Tinga Jugo de Zanahoria Melón Picado	Package description	59.00	t	2017-09-11 13:14:07.747587-05	
71	Ensalada de Fresa Agua de Melón Melón Picado	Package description	59.00	t	2017-09-11 16:55:47.456212-05	cartridges/9585d9c2-e526-4a4b-9c6c-1b02438f88a1_yrcfvfO.jpg
70	Pollo Mostaza Sandía Picada Jugo de Alfalfa con Pinguica	Package description	59.00	t	2017-09-11 16:57:21.475026-05	cartridges/9585d9c2-e526-4a4b-9c6c-1b02438f88a1_rmaqbdL.jpg
271	Pollo Mostaza Melón Picado Avena con Manzana	Package description	59.00	t	2017-09-12 09:53:40.657244-05	
272	Tinga Jugo Verde Jugo de Alfalfa con Pinguica	Package description	59.00	t	2017-09-15 11:40:58.332129-05	
273	Tinga Jugo Verde Jugo de Alfalfa con Pinguica	Package description	59.00	t	2017-09-15 11:40:58.47236-05	
274	Tinga Jugo Verde Jugo de Alfalfa con Pinguica	Package description	59.00	t	2017-09-15 11:40:58.618646-05	
275	Tinga Jugo de Alfalfa con Pinguica Jugo de Alfalfa con Pinguica	Package description	59.00	t	2017-09-15 11:48:44.785893-05	
276	Chilaquiles Fruta Picada Jugo Verde	Package description	59.00	t	2017-09-18 10:01:27.031198-05	
277	Calabazita Agua de Horchata Melón Picado	Package description	59.00	t	2017-09-18 11:46:11.833383-05	
278	Pollo Mostaza Fruta Picada Jugo de Alfalfa con Pinguica	Package description	59.00	t	2017-09-20 10:55:12.372194-05	
279	Rajas Melón Picado Sandía Picada	Package description	59.00	t	2017-09-20 12:29:11.905733-05	
280	Pollo Mostaza Melón Picado Sandía Picada	Package description	59.00	t	2017-09-20 12:29:12.655601-05	
281	Jamón Fruta Picada Jugo de Naranja	Package description	59.00	t	2017-09-21 08:37:44.610425-05	
282	Azteca Fruta Picada Agua de Guayaba	Package description	59.00	t	2017-09-22 01:18:16.54693-05	
283	Chilaquiles Papaya Picada Jugo de Zanahoria	Package description	59.00	t	2017-09-23 08:58:51.3456-05	
284	Pollo Mostaza Jugo de Naranja Fruta Picada	Package description	59.00	t	2017-09-23 10:54:24.603056-05	
285	Calabacita Fruta Picada Jugo de Naranja	Package description	59.00	t	2017-09-23 11:32:37.830405-05	
286	Jamón Fruta Picada Jugo Verde	Package description	59.00	t	2017-09-25 09:25:28.08648-05	
287	Champiñones con epazote Melón Picado Jugo de Naranja	Package description	59.00	t	2017-09-25 10:32:10.417018-05	
288	Champiñones con epazote Papaya Picada Jugo de Alfalfa con Pinguica	Package description	59.00	t	2017-09-25 11:18:35.758592-05	
289	Azteca Papaya Picada Sandía Picada	Package description	59.00	t	2017-09-25 11:18:36.027154-05	
290	Tinga Fruta Picada Agua de Horchata	Package description	59.00	t	2017-09-26 12:05:23.695299-05	
291	Rajas Papaya Picada Avena con Manzana	Package description	59.00	t	2017-09-28 10:59:04.315572-05	
292	Pollo Mostaza Papaya Picada Jugo de Naranja	Package description	59.00	t	2017-09-29 06:44:37.459242-05	
293	Chilaquiles Fruta Picada Avena con Manzana	Package description	59.00	t	2017-09-29 11:47:02.296803-05	
294	Rajas Papaya Picada Jugo de Alfalfa con Pinguica	Package description	59.00	t	2017-09-30 09:49:47.310841-05	
295	Jamón Fruta Picada Avena con Manzana	Package description	59.00	t	2017-09-30 10:23:56.643815-05	
296	Jamón Fruta Picada Agua de Horchata	Package description	59.00	t	2017-09-30 10:23:57.185635-05	
297	Chilaquiles Fruta Picada Jugo de Alfalfa con Pinguica	Package description	59.00	t	2017-09-30 11:16:41.959572-05	
298	Pollo Mostaza Agua de Horchata Sandía Picada	Package description	59.00	t	2017-09-30 11:40:09.90356-05	
299	Azteca Melón Picado Agua de Horchata	Package description	59.00	t	2017-10-02 08:45:34.054756-05	
300	Chilaquiles Fruta Picada Jugo de Naranja	Package description	59.00	t	2017-10-02 08:49:37.696359-05	
301	Choriqueso Fruta Picada Jugo de Alfalfa con Pinguica	Package description	59.00	t	2017-10-03 09:03:14.242659-05	
302	Choriqueso Jugo Verde Jugo de Zanahoria	Package description	59.00	t	2017-10-03 11:34:07.856661-05	
303	Albóndigas Papaya Picada Avena con Manzana	Package description	59.00	t	2017-10-04 11:48:36.837283-05	
304	Azteca Papaya Picada Avena con Manzana	Package description	59.00	t	2017-10-04 13:32:47.245054-05	
305	Albóndigas Papaya Picada Jugo de Naranja	Package description	59.00	t	2017-10-04 13:33:17.417889-05	
306	Azteca Melón Picado Jugo de Naranja	Package description	59.00	t	2017-10-05 10:22:22.700206-05	
307	Albóndigas Melón Picado Jugo de Zanahoria	Package description	59.00	t	2017-10-05 11:12:04.171248-05	
308	Chilaquiles Sandía Picada Avena con Manzana	Package description	59.00	t	2017-10-05 11:41:37.502013-05	
309	Champiñones con epazote Fruta Picada Melón Picado	Package description	59.00	t	2017-10-06 07:40:42.188957-05	
310	Champiñones con Salsa Agridulce Fruta Picada Jugo Verde	Package description	59.00	t	2017-10-06 07:41:15.063197-05	
311	Pollo Mostaza Papaya Picada Melón Picado	Package description	59.00	t	2017-10-07 09:48:54.11644-05	
312	Pollo Mostaza Fruta Picada Melón Picado	Package description	59.00	t	2017-10-07 09:48:54.425902-05	
313	Pollo Mostaza Papaya Picada Fruta Picada	Package description	59.00	t	2017-10-07 09:48:55.429972-05	
314	Champiñones con Salsa Agridulce Fruta Picada Agua de Limón	Package description	59.00	t	2017-10-07 12:38:40.59559-05	
315	Chilaquiles Melón Picado Agua de Fresa	Package description	59.00	t	2017-10-07 14:29:26.654439-05	
316	Albóndigas Fruta Picada Agua de Horchata	Package description	59.00	t	2017-10-07 14:58:34.316917-05	
317	Carne con Salsa Agridulce Fruta Picada Jugo de Naranja	Package description	59.00	t	2017-10-10 11:27:44.67687-05	
318	Pollo Mostaza Agua de Limón Papaya Picada	Package description	59.00	t	2017-10-10 11:36:12.442814-05	
319	  	Package description	59.00	t	2017-10-10 12:03:25.891614-05	
320	Jamón Papaya Picada Agua de Guayaba	Package description	59.00	t	2017-10-10 12:04:30.083729-05	
321	Vegetariano Fruta Picada Agua de Horchata	Package description	59.00	t	2017-10-10 12:57:47.923528-05	
322	Albóndigas Fruta Picada Melón Picado	Package description	69.00	t	2018-01-15 18:03:51.818073-06	
\.


--
-- Name: products_packagecartridge_id_seq; Type: SEQUENCE SET; Schema: public; Owner: digimundo
--

SELECT pg_catalog.setval('products_packagecartridge_id_seq', 322, true);


--
-- Data for Name: products_packagecartridgerecipe; Type: TABLE DATA; Schema: public; Owner: digimundo
--

COPY products_packagecartridgerecipe (id, quantity, cartridge_id, package_cartridge_id) FROM stdin;
1	1	2	1
2	1	20	1
3	1	32	1
4	1	2	2
5	1	18	2
6	1	20	2
7	1	1	3
8	1	18	3
9	1	18	3
10	1	9	4
11	1	18	4
12	1	18	4
13	1	10	5
14	1	22	5
15	1	18	5
16	1	1	6
17	1	22	6
18	1	22	6
19	1	10	8
20	1	20	8
21	1	31	8
22	1	9	9
23	1	20	9
24	1	22	9
25	1	7	10
26	1	19	10
27	1	19	10
28	1	1	11
29	1	19	11
30	1	22	11
31	1	7	12
32	1	23	12
33	1	20	12
34	1	2	13
35	1	22	13
36	1	31	13
37	1	10	14
38	1	21	14
39	1	20	14
40	1	5	15
41	1	18	15
42	1	24	15
43	1	1	16
44	1	20	16
45	1	23	16
46	1	5	17
47	1	18	17
48	1	26	17
49	1	9	18
50	1	25	18
51	1	24	18
52	1	2	19
53	1	24	19
54	1	20	19
55	1	34	20
56	1	21	20
57	1	18	20
58	1	10	21
59	1	19	21
60	1	23	21
61	1	9	22
62	1	23	22
63	1	23	22
64	1	4	23
65	1	23	23
66	1	18	23
67	1	9	24
68	1	28	24
69	1	23	24
70	1	3	25
71	1	18	25
72	1	22	25
73	1	9	26
74	1	22	26
75	1	19	26
76	1	3	27
77	1	22	27
78	1	19	27
79	1	9	28
80	1	22	28
81	1	28	28
82	1	3	29
83	1	18	29
84	1	20	29
85	1	7	30
86	1	23	30
87	1	27	30
88	1	34	31
89	1	32	31
90	1	18	31
91	1	1	32
92	1	23	32
93	1	24	32
94	1	1	33
95	1	20	33
96	1	22	33
97	1	9	34
98	1	18	34
99	1	32	34
100	1	2	35
101	1	22	35
102	1	19	35
103	1	9	36
104	1	25	36
105	1	20	36
106	1	7	37
107	1	30	37
108	1	18	37
109	1	4	38
110	1	22	38
111	1	28	38
112	1	5	39
113	1	24	39
114	1	19	39
115	1	5	40
116	1	18	40
117	1	32	40
118	1	1	41
119	1	19	41
120	1	32	41
121	1	4	42
122	1	31	42
123	1	18	42
124	1	5	43
125	1	32	43
126	1	19	43
127	1	8	44
128	1	23	44
129	1	18	44
130	1	8	45
131	1	22	45
132	1	18	45
133	1	9	46
134	1	23	46
135	1	18	46
136	1	2	47
137	1	18	47
138	1	31	47
139	1	9	48
140	1	31	48
141	1	20	48
142	1	9	49
143	1	26	49
144	1	18	49
145	1	34	50
146	1	20	50
147	1	23	50
148	1	5	51
149	1	22	51
150	1	28	51
151	1	4	52
152	1	18	52
153	1	32	52
154	1	8	53
155	1	20	53
156	1	32	53
157	1	4	54
158	1	19	54
159	1	32	54
160	1	2	55
161	1	19	55
162	1	32	55
163	1	5	56
164	1	20	56
165	1	32	56
166	1	5	57
167	1	20	57
168	1	31	57
169	1	9	58
170	1	19	58
171	1	25	58
172	1	2	59
173	1	30	59
174	1	18	59
175	1	34	60
176	1	18	60
177	1	30	60
178	1	1	61
179	1	20	61
180	1	32	61
181	1	7	62
182	1	18	62
183	1	25	62
184	1	9	63
185	1	19	63
186	1	32	63
187	1	1	64
188	1	19	64
189	1	23	64
190	1	34	65
191	1	22	65
192	1	20	65
193	1	5	66
194	1	18	66
195	1	22	66
196	1	35	67
197	1	20	67
198	1	32	67
199	1	8	201
200	1	23	201
201	1	22	201
202	1	35	202
203	1	18	202
204	1	22	202
205	1	9	203
206	1	22	203
207	1	32	203
208	1	4	204
209	1	19	204
210	1	24	204
211	1	9	205
212	1	20	205
213	1	21	205
214	1	8	206
215	1	19	206
216	1	21	206
217	1	2	207
218	1	32	207
219	1	26	207
220	1	1	208
221	1	31	208
222	1	19	208
223	1	9	209
224	1	31	209
225	1	18	209
226	1	3	210
227	1	22	210
228	1	20	210
229	1	7	211
230	1	19	211
231	1	20	211
232	1	4	212
233	1	19	212
234	1	29	212
235	1	4	213
236	1	19	213
237	1	22	213
238	1	35	214
239	1	18	214
240	1	21	214
241	1	4	215
242	1	21	215
243	1	20	215
244	1	5	216
245	1	20	216
246	1	22	216
247	1	9	217
248	1	19	217
249	1	30	217
250	1	9	218
251	1	19	218
252	1	24	218
253	1	4	219
254	1	19	219
255	1	21	219
256	1	5	220
257	1	19	220
258	1	23	220
259	1	9	221
260	1	20	221
261	1	23	221
262	1	5	222
263	1	20	222
264	1	21	222
265	1	5	223
266	1	20	223
267	1	23	223
268	1	2	224
269	1	20	224
270	1	23	224
271	1	7	225
272	1	18	225
273	1	21	225
274	1	5	226
275	1	19	226
276	1	21	226
277	1	2	227
278	1	20	227
279	1	21	227
280	1	1	228
281	1	20	228
282	1	21	228
283	1	4	229
284	1	22	229
285	1	32	229
286	1	5	230
287	1	18	230
288	1	29	230
289	1	35	231
290	1	31	231
291	1	20	231
292	1	9	232
293	1	31	232
294	1	19	232
295	1	5	233
296	1	18	233
297	1	27	233
298	1	5	234
299	1	18	234
300	1	25	234
301	1	5	235
302	1	19	235
303	1	31	235
304	1	1	236
305	1	18	236
306	1	21	236
307	1	2	237
308	1	18	237
309	1	21	237
310	1	1	238
311	1	29	238
312	1	31	238
313	1	1	239
314	1	21	239
315	1	32	239
316	1	1	240
317	1	20	240
318	1	31	240
319	1	1	241
320	1	19	241
321	1	18	241
322	1	9	242
323	1	19	242
324	1	21	242
325	1	9	243
326	1	20	243
327	1	24	243
328	1	9	244
329	1	18	244
330	1	21	244
331	1	7	245
332	1	19	245
333	1	24	245
334	1	9	246
335	1	18	246
336	1	22	246
337	1	2	247
338	1	19	247
339	1	21	247
340	1	3	248
341	1	19	248
342	1	21	248
343	1	4	249
344	1	20	249
345	1	24	249
346	1	1	250
347	1	19	250
348	1	30	250
349	1	2	251
350	1	20	251
351	1	31	251
352	1	2	252
353	1	20	252
354	1	20	252
355	1	1	253
356	1	19	253
357	1	21	253
358	1	1	254
359	1	22	254
360	1	18	254
361	1	5	255
362	1	18	255
363	1	31	255
364	1	4	256
365	1	20	256
366	1	23	256
367	1	7	257
368	1	19	257
369	1	21	257
370	1	5	258
371	1	18	258
372	1	21	258
373	1	34	259
374	1	18	259
375	1	22	259
376	1	34	260
377	1	19	260
378	1	22	260
379	1	2	261
380	1	32	261
381	1	31	261
382	1	5	262
383	1	19	262
384	1	22	262
385	1	35	263
386	1	19	263
387	1	24	263
388	1	4	264
389	1	23	264
390	1	24	264
391	1	34	265
392	1	21	265
393	1	19	265
394	1	2	266
395	1	23	266
396	1	19	266
397	1	5	267
398	1	27	267
399	1	23	267
400	1	4	268
401	1	18	268
402	1	29	268
403	1	4	269
404	1	20	269
405	1	27	269
406	1	36	270
407	1	24	270
408	1	19	270
409	1	11	71
410	1	26	71
411	1	19	71
412	1	7	200
413	1	20	200
414	1	28	200
415	1	2	70
416	1	18	70
417	1	21	70
418	1	34	69
419	1	19	69
420	1	21	69
421	1	2	271
422	1	19	271
423	1	31	271
424	1	36	272
425	1	23	272
426	1	21	272
427	1	36	273
428	1	23	273
429	1	21	273
430	1	36	274
431	1	23	274
432	1	21	274
433	1	36	275
434	1	21	275
435	1	21	275
436	1	1	276
437	1	37	276
438	1	23	276
439	1	8	277
440	1	32	277
441	1	19	277
442	1	2	278
443	1	37	278
444	1	21	278
445	1	34	279
446	1	19	279
447	1	18	279
448	1	2	280
449	1	19	280
450	1	18	280
451	1	4	281
452	1	37	281
453	1	22	281
454	1	7	282
455	1	37	282
456	1	29	282
457	1	1	283
458	1	20	283
459	1	24	283
460	1	2	284
461	1	22	284
462	1	37	284
463	1	8	285
464	1	37	285
465	1	22	285
466	1	4	286
467	1	37	286
468	1	23	286
469	1	35	287
470	1	19	287
471	1	22	287
472	1	35	288
473	1	20	288
474	1	21	288
475	1	7	289
476	1	20	289
477	1	18	289
478	1	36	290
479	1	37	290
480	1	32	290
481	1	34	291
482	1	20	291
483	1	31	291
484	1	2	292
485	1	20	292
486	1	22	292
487	1	1	293
488	1	37	293
489	1	31	293
490	1	34	294
491	1	20	294
492	1	21	294
493	1	4	295
494	1	37	295
495	1	31	295
496	1	4	296
497	1	37	296
498	1	32	296
499	1	1	297
500	1	37	297
501	1	21	297
502	1	2	298
503	1	32	298
504	1	18	298
505	1	7	299
506	1	19	299
507	1	32	299
508	1	1	300
509	1	37	300
510	1	22	300
511	1	5	301
512	1	37	301
513	1	21	301
514	1	5	302
515	1	23	302
516	1	24	302
517	1	38	303
518	1	20	303
519	1	31	303
520	1	7	304
521	1	20	304
522	1	31	304
523	1	38	305
524	1	20	305
525	1	22	305
526	1	7	306
527	1	19	306
528	1	22	306
529	1	38	307
530	1	19	307
531	1	24	307
532	1	1	308
533	1	18	308
534	1	31	308
535	1	35	309
536	1	37	309
537	1	19	309
538	1	10	310
539	1	37	310
540	1	23	310
541	1	2	311
542	1	20	311
543	1	19	311
544	1	2	312
545	1	37	312
546	1	19	312
547	1	2	313
548	1	20	313
549	1	37	313
550	1	10	314
551	1	37	314
552	1	30	314
553	1	1	315
554	1	19	315
555	1	28	315
556	1	38	316
557	1	37	316
558	1	32	316
559	1	9	317
560	1	37	317
561	1	22	317
562	1	2	318
563	1	30	318
564	1	20	318
565	1	4	320
566	1	20	320
567	1	29	320
568	1	3	321
569	1	37	321
570	1	32	321
571	1	38	322
572	1	37	322
573	1	19	322
\.


--
-- Name: products_packagecartridgerecipe_id_seq; Type: SEQUENCE SET; Schema: public; Owner: digimundo
--

SELECT pg_catalog.setval('products_packagecartridgerecipe_id_seq', 573, true);


--
-- Data for Name: products_presentation; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY products_presentation (id, measurement_quantity, measurement_unit, presentation_unit, presentation_cost, supply_id, on_warehouse, on_assembly) FROM stdin;
3	200	GR	PA	200	107	0	0
8	1000	MI	PZ	10	109	7	2
7	1000	MI	BO	50	106	1	8
6	600	MI	PZ	70	106	12	3
\.


--
-- Name: products_presentation_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('products_presentation_id_seq', 8, true);


--
-- Data for Name: products_shoplist; Type: TABLE DATA; Schema: public; Owner: digimundo
--

COPY products_shoplist (id, created_at, status) FROM stdin;
1	2018-02-23	MI
2	2018-02-23	MI
3	2018-02-23	MI
4	2018-02-27	MI
5	2018-02-27	MI
6	2018-03-01	MI
7	2018-03-01	MI
8	2018-03-01	MI
\.


--
-- Name: products_shoplist_id_seq; Type: SEQUENCE SET; Schema: public; Owner: digimundo
--

SELECT pg_catalog.setval('products_shoplist_id_seq', 8, true);


--
-- Data for Name: products_shoplistdetail; Type: TABLE DATA; Schema: public; Owner: digimundo
--

COPY products_shoplistdetail (id, status, quantity, deliver_day, presentation_id, shop_list_id) FROM stdin;
1	DE	3	2018-02-23 02:13:59.293411-06	6	2
3	DE	6	2018-02-27 01:51:41.737031-06	7	3
2	DE	3	2018-02-27 02:22:18.855751-06	6	3
4	DE	5	2018-02-27 02:34:38.414041-06	3	4
5	DE	3	2018-02-27 02:35:08.395053-06	8	4
6	DE	6	2018-02-27 03:32:52.373413-06	8	5
7	DE	4	2018-02-27 03:34:39.886955-06	6	5
8	DE	2	2018-02-27 03:35:33.779477-06	7	5
11	DE	3	2018-03-01 02:20:02.500136-06	6	7
12	DE	6	2018-03-01 02:20:14.048615-06	7	7
10	DE	1	2018-03-01 02:37:26.429181-06	7	6
9	DE	1	2018-03-01 02:39:09.264489-06	6	6
14	MI	2	\N	7	8
15	MI	1	\N	3	8
13	DE	3	2018-03-01 02:40:25.435847-06	6	8
\.


--
-- Name: products_shoplistdetail_id_seq; Type: SEQUENCE SET; Schema: public; Owner: digimundo
--

SELECT pg_catalog.setval('products_shoplistdetail_id_seq', 15, true);


--
-- Data for Name: products_suppliescategory; Type: TABLE DATA; Schema: public; Owner: digimundo
--

COPY products_suppliescategory (id, name, image) FROM stdin;
1	Ingrediente	supplies-categories/descarga.jpg
\.


--
-- Name: products_suppliescategory_id_seq; Type: SEQUENCE SET; Schema: public; Owner: digimundo
--

SELECT pg_catalog.setval('products_suppliescategory_id_seq', 1, true);


--
-- Data for Name: products_supply; Type: TABLE DATA; Schema: public; Owner: digimundo
--

COPY products_supply (id, name, barcode, storage_required, optimal_duration, optimal_duration_unit, created_at, image, category_id, location_id, supplier_id) FROM stdin;
121	Canela Molida	\N	DR	5	DA	2018-01-08 22:29:15.161683-06	supplies/no_img.png	1	1	1
122	Cebolla	\N	DR	5	DA	2018-01-08 22:29:15.166183-06	supplies/no_img.png	1	1	1
123	Cebollin	\N	DR	5	DA	2018-01-08 22:29:15.169683-06	supplies/no_img.png	1	1	1
124	Chile Ancho Seco	\N	DR	5	DA	2018-01-08 22:29:15.173182-06	supplies/no_img.png	1	1	1
125	Chile Serrano Verde	\N	DR	5	DA	2018-01-08 22:29:15.178183-06	supplies/no_img.png	1	1	1
126	Chile Guajillo	\N	DR	5	DA	2018-01-08 22:29:15.181681-06	supplies/no_img.png	1	1	1
127	Chile Habanero	\N	DR	5	DA	2018-01-08 22:29:15.185681-06	supplies/no_img.png	1	1	1
128	Chile Morita seco	\N	DR	5	DA	2018-01-08 22:29:15.189683-06	supplies/no_img.png	1	1	1
129	Chile Poblano	\N	DR	5	DA	2018-01-08 22:29:15.193182-06	supplies/no_img.png	1	1	1
130	Chile Jalape¤os Lata	\N	DR	5	DA	2018-01-08 22:29:15.198181-06	supplies/no_img.png	1	1	1
131	Chipotles	\N	DR	5	DA	2018-01-08 22:29:15.201682-06	supplies/no_img.png	1	1	1
132	Chocolate en polvo	\N	DR	5	DA	2018-01-08 22:29:15.205682-06	supplies/no_img.png	1	1	1
133	Chorizo	\N	DR	5	DA	2018-01-08 22:29:15.209182-06	supplies/no_img.png	1	1	1
134	Chorizo de Pollo	\N	DR	5	DA	2018-01-08 22:29:15.213183-06	supplies/no_img.png	1	1	1
135	Cilantro	\N	DR	5	DA	2018-01-08 22:29:15.219683-06	supplies/no_img.png	1	1	1
136	Col Blanca	\N	DR	5	DA	2018-01-08 22:29:15.223183-06	supplies/no_img.png	1	1	1
137	Crema	\N	DR	5	DA	2018-01-08 22:29:15.227183-06	supplies/no_img.png	1	1	1
138	Elotes en Lata	\N	DR	5	DA	2018-01-08 22:29:15.231682-06	supplies/no_img.png	1	1	1
139	Epazote	\N	DR	5	DA	2018-01-08 22:29:15.236182-06	supplies/no_img.png	1	1	1
140	Espinacas	\N	DR	5	DA	2018-01-08 22:29:15.240182-06	supplies/no_img.png	1	1	1
141	Fresa Congelada	\N	DR	5	DA	2018-01-08 22:29:15.245183-06	supplies/no_img.png	1	1	1
142	Fresa	\N	DR	5	DA	2018-01-08 22:29:15.248683-06	supplies/no_img.png	1	1	1
143	Frijol	\N	DR	5	DA	2018-01-08 22:29:15.252683-06	supplies/no_img.png	1	1	1
144	Germen de Alfalfa	\N	DR	5	DA	2018-01-08 22:29:15.257183-06	supplies/no_img.png	1	1	1
145	Granola	\N	DR	5	DA	2018-01-08 22:29:15.260682-06	supplies/no_img.png	1	1	1
146	Granola con Frutas y Miel	\N	DR	5	DA	2018-01-08 22:29:15.265182-06	supplies/no_img.png	1	1	1
147	Guayaba	\N	DR	5	DA	2018-01-08 22:29:15.268682-06	supplies/no_img.png	1	1	1
148	Hierbas de Olor	\N	DR	5	DA	2018-01-08 22:29:15.272182-06	supplies/no_img.png	1	1	1
149	Huevo	\N	DR	5	DA	2018-01-08 22:29:15.277681-06	supplies/no_img.png	1	1	1
150	Jamon	\N	DR	5	DA	2018-01-08 22:29:15.281181-06	supplies/no_img.png	1	1	1
151	Jitomate Cherry	\N	DR	5	DA	2018-01-08 22:29:15.286182-06	supplies/no_img.png	1	1	1
152	Jitomate Uva	\N	DR	5	DA	2018-01-08 22:29:15.289682-06	supplies/no_img.png	1	1	1
153	Jitomate Saladet	\N	DR	5	DA	2018-01-08 22:29:15.295181-06	supplies/no_img.png	1	1	1
154	Kiwi	\N	DR	5	DA	2018-01-08 22:29:15.299181-06	supplies/no_img.png	1	1	1
155	Knor Suiza en polvo	\N	DR	5	DA	2018-01-08 22:29:15.304182-06	supplies/no_img.png	1	1	1
156	Leche deslactosada ligera	\N	DR	5	DA	2018-01-08 22:29:15.308182-06	supplies/no_img.png	1	1	1
157	Leche evaporada	\N	DR	5	DA	2018-01-08 22:29:15.313682-06	supplies/no_img.png	1	1	1
158	Leche condensada	\N	DR	5	DA	2018-01-08 22:29:15.317182-06	supplies/no_img.png	1	1	1
159	Lechuga Italiana	\N	DR	5	DA	2018-01-08 22:29:15.321182-06	supplies/no_img.png	1	1	1
160	Limones	\N	DR	5	DA	2018-01-08 22:29:15.325682-06	supplies/no_img.png	1	1	1
161	Mamey	\N	DR	5	DA	2018-01-08 22:29:15.330182-06	supplies/no_img.png	1	1	1
162	Mango manila	\N	DR	5	DA	2018-01-08 22:29:15.334682-06	supplies/no_img.png	1	1	1
163	Mantequilla	\N	DR	5	DA	2018-01-08 22:29:15.338181-06	supplies/no_img.png	1	1	1
164	Manzana red delicius	\N	DR	5	DA	2018-01-08 22:29:15.343682-06	supplies/no_img.png	1	1	1
165	Manzana amarilla	\N	DR	5	DA	2018-01-08 22:29:15.347181-06	supplies/no_img.png	1	1	1
166	Melon	\N	DR	5	DA	2018-01-08 22:29:15.351181-06	supplies/no_img.png	1	1	1
167	Mezcla de Sal y Pimienta	\N	DR	5	DA	2018-01-08 22:29:15.356682-06	supplies/no_img.png	1	1	1
168	Miel	\N	DR	5	DA	2018-01-08 22:29:15.360682-06	supplies/no_img.png	1	1	1
169	Mole	\N	DR	5	DA	2018-01-08 22:29:15.365181-06	supplies/no_img.png	1	1	1
170	Molido de cerdo	\N	DR	5	DA	2018-01-08 22:29:15.368182-06	supplies/no_img.png	1	1	1
171	Molido de red	\N	DR	5	DA	2018-01-08 22:29:15.373182-06	supplies/no_img.png	1	1	1
172	Mostaza	\N	DR	5	DA	2018-01-08 22:29:15.379181-06	supplies/no_img.png	1	1	1
173	Naranja	\N	DR	5	DA	2018-01-08 22:29:15.383682-06	supplies/no_img.png	1	1	1
174	Nopales	\N	DR	5	DA	2018-01-08 22:29:15.387681-06	supplies/no_img.png	1	1	1
175	Nuez de Castilla	\N	DR	5	DA	2018-01-08 22:29:15.392682-06	supplies/no_img.png	1	1	1
176	Oregana	\N	DR	5	DA	2018-01-08 22:29:15.398182-06	supplies/no_img.png	1	1	1
177	Papas	\N	DR	5	DA	2018-01-08 22:29:15.402682-06	supplies/no_img.png	1	1	1
203	Tortillas Paninas	\N	DR	5	DA	2018-01-08 22:29:15.516182-06	supplies/no_img.png	1	1	1
204	Totopos	\N	DR	5	DA	2018-01-08 22:29:15.520681-06	supplies/no_img.png	1	1	1
205	Uvas rojas sin Semilla	\N	DR	5	DA	2018-01-08 22:29:15.524182-06	supplies/no_img.png	1	1	1
106	Aceite de Olivo	\N	DR	5	DA	2018-01-08 22:29:15.098183-06	supplies/no_img.png	1	1	1
107	Aceite Vegetal	\N	DR	5	DA	2018-01-08 22:29:15.109183-06	supplies/no_img.png	1	1	1
108	Acitron	\N	DR	5	DA	2018-01-08 22:29:15.112682-06	supplies/no_img.png	1	1	1
109	Agua	\N	DR	5	DA	2018-01-08 22:29:15.115188-06	supplies/no_img.png	1	1	1
110	Ajo	\N	DR	5	DA	2018-01-08 22:29:15.118182-06	supplies/no_img.png	1	1	1
111	Ajonjoli acaramelado	\N	DR	5	DA	2018-01-08 22:29:15.122182-06	supplies/no_img.png	1	1	1
112	Alfalfa	\N	DR	5	DA	2018-01-08 22:29:15.126682-06	supplies/no_img.png	1	1	1
113	Amaranto	\N	DR	5	DA	2018-01-08 22:29:15.131181-06	supplies/no_img.png	1	1	1
114	Apio	\N	DR	5	DA	2018-01-08 22:29:15.134183-06	supplies/no_img.png	1	1	1
115	Arandanos	\N	DR	5	DA	2018-01-08 22:29:15.138682-06	supplies/no_img.png	1	1	1
116	Arroz	\N	DR	5	DA	2018-01-08 22:29:15.142182-06	supplies/no_img.png	1	1	1
117	Avena	\N	DR	5	DA	2018-01-08 22:29:15.146683-06	supplies/no_img.png	1	1	1
118	Azucar	\N	DR	5	DA	2018-01-08 22:29:15.150182-06	supplies/no_img.png	1	1	1
119	Cacahuate	\N	DR	5	DA	2018-01-08 22:29:15.153689-06	supplies/no_img.png	1	1	1
120	Calabacita	\N	DR	5	DA	2018-01-08 22:29:15.158183-06	supplies/no_img.png	1	1	1
206	Vainilla	\N	DR	5	DA	2018-01-08 22:29:15.533182-06	supplies/no_img.png	1	1	1
207	Vinagre Balsamico	\N	DR	5	DA	2018-01-08 22:29:15.537682-06	supplies/no_img.png	1	1	1
208	Vinagre de Manzana	\N	DR	5	DA	2018-01-08 22:29:15.542182-06	supplies/no_img.png	1	1	1
209	Yogurt Natural	\N	DR	5	DA	2018-01-08 22:29:15.546681-06	supplies/no_img.png	1	1	1
210	Zanahoria	\N	DR	5	DA	2018-01-08 22:29:15.551682-06	supplies/no_img.png	1	1	1
178	Papaya	\N	DR	5	DA	2018-01-08 22:29:15.406182-06	supplies/no_img.png	1	1	1
179	Pasitas de california	\N	DR	5	DA	2018-01-08 22:29:15.410181-06	supplies/no_img.png	1	1	1
180	Pasta Fusilli	\N	DR	5	DA	2018-01-08 22:29:15.414681-06	supplies/no_img.png	1	1	1
181	Pechuga de Pollo	\N	DR	5	DA	2018-01-08 22:29:15.418682-06	supplies/no_img.png	1	1	1
182	Pepino	\N	DR	5	DA	2018-01-08 22:29:15.423682-06	supplies/no_img.png	1	1	1
183	Pera mantequilla	\N	DR	5	DA	2018-01-08 22:29:15.427682-06	supplies/no_img.png	1	1	1
184	Pimiento Morron Rojo	\N	DR	5	DA	2018-01-08 22:29:15.432682-06	supplies/no_img.png	1	1	1
185	Pimiento Morron Verde	\N	DR	5	DA	2018-01-08 22:29:15.436182-06	supplies/no_img.png	1	1	1
186	Pinguica	\N	DR	5	DA	2018-01-08 22:29:15.440182-06	supplies/no_img.png	1	1	1
187	Pi¤a	\N	DR	5	DA	2018-01-08 22:29:15.445182-06	supplies/no_img.png	1	1	1
188	Platano	\N	DR	5	DA	2018-01-08 22:29:15.448682-06	supplies/no_img.png	1	1	1
189	Pimienta	\N	DR	5	DA	2018-01-08 22:29:15.453682-06	supplies/no_img.png	1	1	1
190	Popote	\N	DR	5	DA	2018-01-08 22:29:15.456682-06	supplies/no_img.png	1	1	1
191	Queso Crema	\N	DR	5	DA	2018-01-08 22:29:15.462182-06	supplies/no_img.png	1	1	1
192	Queso Crema (Tipo philadelphia)	\N	DR	5	DA	2018-01-08 22:29:15.465682-06	supplies/no_img.png	1	1	1
193	Queso doble crema	\N	DR	5	DA	2018-01-08 22:29:15.469681-06	supplies/no_img.png	1	1	1
194	Queso Manchego	\N	DR	5	DA	2018-01-08 22:29:15.474681-06	supplies/no_img.png	1	1	1
195	Queso Mozzarela	\N	DR	5	DA	2018-01-08 22:29:15.479682-06	supplies/no_img.png	1	1	1
196	Queso Oaxaca	\N	DR	5	DA	2018-01-08 22:29:15.484181-06	supplies/no_img.png	1	1	1
197	Queso Panela	\N	DR	5	DA	2018-01-08 22:29:15.488182-06	supplies/no_img.png	1	1	1
198	Sal de grano	\N	DR	5	DA	2018-01-08 22:29:15.492681-06	supplies/no_img.png	1	1	1
199	Salsa del dia	\N	DR	5	DA	2018-01-08 22:29:15.498182-06	supplies/no_img.png	1	1	1
200	Sasonador Jugo Maggi	\N	DR	5	DA	2018-01-08 22:29:15.503181-06	supplies/no_img.png	1	1	1
201	Sandia	\N	DR	5	DA	2018-01-08 22:29:15.506681-06	supplies/no_img.png	1	1	1
202	Tomate Verde	\N	DR	5	DA	2018-01-08 22:29:15.512181-06	supplies/no_img.png	1	1	1
\.


--
-- Name: products_supply_id_seq; Type: SEQUENCE SET; Schema: public; Owner: digimundo
--

SELECT pg_catalog.setval('products_supply_id_seq', 212, true);


--
-- Data for Name: products_supplylocation; Type: TABLE DATA; Schema: public; Owner: digimundo
--

COPY products_supplylocation (id, location, branch_office_id) FROM stdin;
1	Almacen 1	1
2	Refri Frio	1
3	Refri Caliente	1
4	Refri C Caliente	1
5	Almacen S Frio	1
6	Almacen S Caliente	1
7	Materias Primas	1
\.


--
-- Name: products_supplylocation_id_seq; Type: SEQUENCE SET; Schema: public; Owner: digimundo
--

SELECT pg_catalog.setval('products_supplylocation_id_seq', 7, true);


--
-- Data for Name: sales_cartridgeticketdetail; Type: TABLE DATA; Schema: public; Owner: digimundo
--

COPY sales_cartridgeticketdetail (id, quantity, price, cartridge_id, ticket_base_id) FROM stdin;
1	1	19.00	24	3
2	1	19.00	22	7
3	1	35.00	5	4
4	1	35.00	9	5
5	1	35.00	2	14
6	1	19.00	21	15
7	1	24.00	14	15
8	1	35.00	9	16
9	1	35.00	2	18
10	1	35.00	9	21
11	1	19.00	22	21
12	2	70.00	5	22
13	1	35.00	9	23
14	1	24.00	16	25
15	1	19.00	22	25
16	1	69.00	13	26
17	1	19.00	19	27
18	1	19.00	19	28
19	1	35.00	8	28
20	1	19.00	22	29
21	2	38.00	22	30
22	1	35.00	10	31
23	1	19.00	22	33
24	1	19.00	22	34
25	1	19.00	22	35
26	1	19.00	22	36
27	1	35.00	10	37
28	1	35.00	10	38
29	1	35.00	2	39
30	1	19.00	22	39
31	1	19.00	22	40
32	1	19.00	19	40
33	1	35.00	1	42
34	1	19.00	22	44
35	3	57.00	23	44
36	1	19.00	23	45
37	1	35.00	10	46
38	1	35.00	9	47
39	1	19.00	31	48
40	1	35.00	9	49
41	2	38.00	32	50
42	1	19.00	22	51
43	1	35.00	1	52
44	2	38.00	32	53
45	1	19.00	32	54
46	1	35.00	5	54
47	1	19.00	20	55
48	1	35.00	3	55
49	1	35.00	5	56
50	1	35.00	1	59
51	1	24.00	14	59
52	1	19.00	22	59
53	1	24.00	15	60
54	1	35.00	1	61
55	1	35.00	1	62
56	1	35.00	9	63
57	1	24.00	33	63
58	1	19.00	22	64
59	1	24.00	14	65
60	1	35.00	4	67
61	1	19.00	22	67
62	1	35.00	9	67
63	1	24.00	15	67
64	1	35.00	1	68
65	1	35.00	1	69
66	1	19.00	22	69
67	1	35.00	34	70
68	2	70.00	4	70
69	3	105.00	3	71
70	1	35.00	2	72
71	2	70.00	5	72
72	1	19.00	19	73
73	1	19.00	18	74
74	1	35.00	10	75
75	1	24.00	15	76
76	1	19.00	31	76
77	1	69.00	12	76
78	1	35.00	9	76
79	1	35.00	7	77
80	2	38.00	22	78
81	1	35.00	1	78
82	4	140.00	4	78
83	1	24.00	15	78
84	1	19.00	23	79
85	1	35.00	7	81
86	1	19.00	23	81
87	1	19.00	29	81
88	1	19.00	19	82
89	2	70.00	2	83
90	4	140.00	5	83
91	1	35.00	7	84
92	1	24.00	16	84
93	1	19.00	22	84
94	1	19.00	21	85
95	4	76.00	22	85
96	1	35.00	5	85
97	1	19.00	22	86
98	1	35.00	3	86
99	1	35.00	7	87
100	1	24.00	16	88
101	1	19.00	22	89
102	1	24.00	16	90
103	1	35.00	1	94
104	2	70.00	2	94
105	1	35.00	3	94
106	1	19.00	32	95
107	1	19.00	28	95
108	1	35.00	2	95
109	1	35.00	2	96
110	1	35.00	1	96
111	1	35.00	1	97
112	1	19.00	23	97
113	1	35.00	1	98
114	1	69.00	13	100
115	1	69.00	11	101
116	1	69.00	12	102
117	1	35.00	5	107
118	1	35.00	1	108
119	1	19.00	22	109
120	1	35.00	1	110
121	1	35.00	1	112
122	1	69.00	12	113
123	1	69.00	12	114
124	1	19.00	20	118
125	1	35.00	2	120
126	1	19.00	32	121
127	1	35.00	10	122
128	3	57.00	23	123
129	1	35.00	10	123
130	1	35.00	2	124
131	1	19.00	27	124
132	1	24.00	15	124
133	1	35.00	1	127
134	1	35.00	4	132
135	1	35.00	34	132
136	1	19.00	22	133
137	1	69.00	11	134
138	1	24.00	15	134
139	2	70.00	9	134
140	1	24.00	16	135
141	1	19.00	26	136
142	1	35.00	7	137
143	1	24.00	33	138
144	1	35.00	3	139
145	1	35.00	2	140
146	2	70.00	1	142
147	1	35.00	5	143
148	1	24.00	15	144
149	1	24.00	15	145
150	1	35.00	5	146
151	1	35.00	3	147
152	1	24.00	14	147
153	1	19.00	19	147
154	1	35.00	4	148
155	1	35.00	1	148
156	1	35.00	5	149
157	1	35.00	4	150
158	1	35.00	5	150
159	1	19.00	31	151
160	1	19.00	32	152
161	1	19.00	23	153
162	1	35.00	1	154
163	1	19.00	23	154
164	1	69.00	11	154
165	1	35.00	5	155
166	1	35.00	9	155
167	3	105.00	10	155
168	1	35.00	34	155
169	1	35.00	5	156
170	1	19.00	19	157
171	1	35.00	1	161
172	1	35.00	1	162
173	1	35.00	1	164
174	1	35.00	2	165
175	1	35.00	10	167
176	1	35.00	1	168
177	1	19.00	22	170
178	1	19.00	24	170
179	1	19.00	23	170
180	2	70.00	9	170
181	1	35.00	3	170
182	1	35.00	1	173
183	2	70.00	5	173
184	1	35.00	5	174
185	1	35.00	5	176
186	1	35.00	1	183
187	3	105.00	2	185
188	2	70.00	7	186
189	1	35.00	34	186
190	1	35.00	1	186
191	1	35.00	34	188
192	1	35.00	1	188
193	1	19.00	19	191
194	1	69.00	12	192
195	1	35.00	10	193
196	1	69.00	12	196
197	1	19.00	19	197
198	1	19.00	22	197
199	2	70.00	9	199
200	2	70.00	1	200
201	1	35.00	8	201
202	1	35.00	34	201
203	1	24.00	15	203
204	1	19.00	25	204
205	1	19.00	21	204
206	1	19.00	29	205
207	1	19.00	22	206
208	1	35.00	10	207
209	1	19.00	19	208
210	1	35.00	2	209
211	1	19.00	22	221
212	2	70.00	4	223
213	1	24.00	15	223
214	1	24.00	15	224
215	3	105.00	9	227
216	1	35.00	4	227
217	2	48.00	15	227
218	1	24.00	14	227
219	1	19.00	22	227
220	2	70.00	9	228
221	2	48.00	15	228
222	1	35.00	4	229
223	1	19.00	22	229
224	1	24.00	15	229
225	1	19.00	32	231
226	1	35.00	5	233
227	1	35.00	8	234
228	1	35.00	1	236
229	1	35.00	5	239
230	2	48.00	15	239
231	1	24.00	16	239
232	1	19.00	20	240
233	1	19.00	22	242
234	1	24.00	15	247
235	1	19.00	29	247
236	1	19.00	18	247
237	1	69.00	11	247
238	1	24.00	15	257
239	1	19.00	18	258
240	1	19.00	23	258
241	1	19.00	25	258
242	1	19.00	23	259
243	2	70.00	1	263
244	1	35.00	10	263
245	1	19.00	22	264
246	1	19.00	22	265
247	1	35.00	2	266
248	1	69.00	13	270
249	1	19.00	30	272
250	1	35.00	5	272
251	1	35.00	35	273
252	1	35.00	9	274
253	3	105.00	3	275
254	1	19.00	22	276
255	1	19.00	21	277
256	1	19.00	31	279
257	1	69.00	13	279
258	1	19.00	22	281
259	1	19.00	22	283
260	1	24.00	15	283
261	1	19.00	22	287
262	1	19.00	32	287
263	1	24.00	15	287
264	1	35.00	4	287
265	1	35.00	2	287
266	1	19.00	19	288
267	1	35.00	2	290
268	1	19.00	24	292
269	1	35.00	35	292
270	1	69.00	13	295
271	1	69.00	12	296
272	1	19.00	31	296
273	1	35.00	4	299
274	1	35.00	1	301
275	1	35.00	9	301
276	1	35.00	7	302
277	1	19.00	27	302
278	1	35.00	4	304
279	1	24.00	15	304
280	1	24.00	15	306
281	1	19.00	22	307
282	1	35.00	10	308
283	1	19.00	31	310
284	1	24.00	15	314
285	1	35.00	5	314
286	1	24.00	17	314
287	1	19.00	22	315
288	1	24.00	15	323
289	1	35.00	3	326
290	1	35.00	5	327
291	2	38.00	30	329
292	1	24.00	15	332
293	1	24.00	15	333
294	1	24.00	15	334
295	1	24.00	15	335
296	1	69.00	12	336
297	1	35.00	3	337
298	1	35.00	1	340
299	1	19.00	22	342
300	1	35.00	4	343
301	1	35.00	5	346
302	1	35.00	1	347
303	1	35.00	3	348
304	1	19.00	22	349
305	2	38.00	19	350
306	1	19.00	32	350
307	1	24.00	14	354
308	1	19.00	22	355
309	1	35.00	35	360
310	1	35.00	1	360
311	1	69.00	12	361
312	1	19.00	22	364
313	1	35.00	1	365
314	1	19.00	23	366
315	1	19.00	23	367
316	2	70.00	9	368
317	1	19.00	18	368
318	1	35.00	5	368
319	1	69.00	12	368
320	1	69.00	11	368
321	1	19.00	23	368
322	2	38.00	29	368
323	1	19.00	20	368
324	1	19.00	22	369
325	1	35.00	1	374
326	1	35.00	4	375
327	1	35.00	4	376
328	2	38.00	21	378
329	1	35.00	1	386
330	1	19.00	22	390
331	1	35.00	9	391
332	1	35.00	1	391
333	1	24.00	16	391
334	1	19.00	23	391
335	1	35.00	1	392
336	1	35.00	1	393
337	1	69.00	12	395
338	1	19.00	32	396
339	1	35.00	1	397
340	1	19.00	24	399
341	1	35.00	2	400
342	1	19.00	32	402
343	1	19.00	19	402
344	1	69.00	13	403
345	1	24.00	15	404
346	1	19.00	18	404
347	2	38.00	23	405
348	1	19.00	23	406
349	1	19.00	32	408
350	1	19.00	22	410
351	1	19.00	22	411
352	1	19.00	19	412
353	1	35.00	1	414
354	1	35.00	1	415
355	1	35.00	3	416
356	1	19.00	21	416
357	1	19.00	22	417
358	1	35.00	4	418
359	1	19.00	30	419
360	1	69.00	12	420
361	1	19.00	32	421
362	1	24.00	16	422
363	1	35.00	10	422
364	1	35.00	4	423
365	1	69.00	12	424
366	1	35.00	35	425
367	1	19.00	22	426
368	1	19.00	19	426
369	1	24.00	15	428
370	1	35.00	9	429
371	1	35.00	2	429
372	1	19.00	23	429
373	1	35.00	1	431
374	1	35.00	1	432
375	1	35.00	5	433
376	1	19.00	19	434
377	1	35.00	9	436
378	1	35.00	9	438
379	4	76.00	31	439
380	2	38.00	23	439
381	1	24.00	14	440
382	1	19.00	21	442
383	2	70.00	9	446
384	1	19.00	19	446
385	1	19.00	22	447
386	1	35.00	1	448
387	1	19.00	21	449
388	1	35.00	2	450
389	1	24.00	16	450
390	1	35.00	2	451
391	1	35.00	1	452
392	1	35.00	4	452
393	2	48.00	15	453
394	1	19.00	32	454
395	1	24.00	15	455
396	1	24.00	16	456
397	1	19.00	22	457
398	3	105.00	9	458
399	1	35.00	1	459
400	1	24.00	15	459
401	1	19.00	22	463
402	2	70.00	1	464
403	1	35.00	9	464
404	1	19.00	21	464
405	2	38.00	31	464
406	1	24.00	16	465
407	1	19.00	31	466
408	1	19.00	22	468
409	1	19.00	22	473
410	1	35.00	1	475
411	1	24.00	15	476
412	1	19.00	22	478
413	1	19.00	20	478
414	1	19.00	19	478
415	1	35.00	1	479
416	1	35.00	4	479
417	1	24.00	15	479
418	1	69.00	13	480
419	1	19.00	31	480
420	1	35.00	10	481
421	2	38.00	23	482
422	1	35.00	1	483
423	1	24.00	15	487
424	2	70.00	1	491
425	1	19.00	24	494
426	1	19.00	22	495
427	1	19.00	23	496
428	1	24.00	15	497
429	1	19.00	31	498
430	3	57.00	22	502
431	1	35.00	2	504
432	1	35.00	5	506
433	1	35.00	5	511
434	1	35.00	4	513
435	1	19.00	22	516
436	1	35.00	1	517
437	1	35.00	1	520
438	2	38.00	24	521
439	2	70.00	1	521
440	1	35.00	3	521
441	1	35.00	5	521
442	2	38.00	23	522
443	1	35.00	1	523
444	1	35.00	5	525
445	1	19.00	29	526
446	2	38.00	23	530
447	1	35.00	1	531
448	1	35.00	5	534
449	1	35.00	2	536
450	1	19.00	22	538
451	1	19.00	23	540
452	2	70.00	1	542
453	1	35.00	35	543
454	1	35.00	1	543
455	1	19.00	23	543
456	1	19.00	23	548
457	2	38.00	23	549
458	1	19.00	22	550
459	1	35.00	7	551
460	1	19.00	24	552
461	1	19.00	22	553
462	1	19.00	19	554
463	1	35.00	10	555
464	2	70.00	9	555
465	1	35.00	7	562
466	2	70.00	1	563
467	2	38.00	21	563
468	5	95.00	31	565
469	1	19.00	23	566
470	1	35.00	4	567
471	1	19.00	20	568
472	1	35.00	4	570
473	1	35.00	1	572
474	1	19.00	21	573
475	1	19.00	24	573
476	2	38.00	23	573
477	1	35.00	9	574
478	1	69.00	13	575
479	1	35.00	1	575
480	1	35.00	1	581
481	1	24.00	14	581
482	1	35.00	35	582
483	1	35.00	1	583
484	1	35.00	35	585
489	1	35.00	5	592
491	1	35.00	2	594
492	1	19.00	22	595
493	1	69.00	11	604
494	1	24.00	15	604
499	1	24.00	14	607
500	1	35.00	1	610
501	1	35.00	9	610
502	1	35.00	2	610
503	1	69.00	12	610
504	1	24.00	15	611
505	1	24.00	14	611
506	1	19.00	22	612
507	1	35.00	35	613
510	1	35.00	9	616
511	1	35.00	1	617
512	1	35.00	1	618
513	1	19.00	23	619
514	1	35.00	9	620
515	1	35.00	7	621
516	1	35.00	2	621
517	1	35.00	9	621
518	1	69.00	11	621
519	1	19.00	22	623
520	1	35.00	35	638
521	1	19.00	23	638
522	2	70.00	4	644
523	1	35.00	1	644
524	1	24.00	14	644
525	1	19.00	23	648
526	1	19.00	22	650
527	1	35.00	34	653
528	1	35.00	10	654
529	1	19.00	23	654
530	1	35.00	1	657
531	1	35.00	5	658
532	1	24.00	15	658
533	1	24.00	15	659
534	1	19.00	19	660
535	1	19.00	21	662
536	1	35.00	7	663
537	1	35.00	1	663
538	1	35.00	1	664
539	1	35.00	5	665
540	1	35.00	1	666
541	1	69.00	13	670
542	1	19.00	22	671
543	1	35.00	1	673
544	1	19.00	23	678
545	1	35.00	4	679
546	1	19.00	25	682
547	1	24.00	15	683
548	2	38.00	22	684
549	1	19.00	32	684
550	1	19.00	19	684
551	1	19.00	22	685
552	2	70.00	38	686
555	1	35.00	4	690
556	1	35.00	4	691
558	1	35.00	7	693
559	1	35.00	1	694
560	1	19.00	23	696
561	1	35.00	35	702
562	1	35.00	4	703
563	2	38.00	20	704
564	2	38.00	22	704
565	1	35.00	5	706
566	1	35.00	1	708
567	1	35.00	2	709
568	1	35.00	7	711
569	1	19.00	23	711
570	1	19.00	21	713
571	1	35.00	9	714
572	1	19.00	22	715
573	1	35.00	35	716
574	2	38.00	22	717
575	1	19.00	20	717
576	2	38.00	19	717
577	1	35.00	9	718
578	1	35.00	1	725
579	1	35.00	1	726
580	1	69.00	12	728
581	1	35.00	8	729
582	1	19.00	22	729
583	1	35.00	4	731
584	1	19.00	22	732
585	2	38.00	22	734
586	3	57.00	18	734
587	1	19.00	20	734
588	1	19.00	23	735
590	1	19.00	24	737
591	2	70.00	38	738
592	2	70.00	7	738
593	2	38.00	20	738
594	4	140.00	38	739
595	1	35.00	10	742
596	2	70.00	1	742
\.


--
-- Name: sales_cartridgeticketdetail_id_seq; Type: SEQUENCE SET; Schema: public; Owner: digimundo
--

SELECT pg_catalog.setval('sales_cartridgeticketdetail_id_seq', 596, true);


--
-- Data for Name: sales_packagecartridgeticketdetail; Type: TABLE DATA; Schema: public; Owner: digimundo
--

COPY sales_packagecartridgeticketdetail (id, quantity, price, package_cartridge_id, ticket_base_id) FROM stdin;
1	1	59.00	5	13
2	1	59.00	5	13
3	1	59.00	6	17
4	1	59.00	8	20
5	1	59.00	9	24
6	1	0.00	10	32
7	1	59.00	11	41
8	1	59.00	12	43
9	1	59.00	13	47
10	1	59.00	14	48
11	1	59.00	15	57
12	1	59.00	16	58
13	1	59.00	17	61
14	1	59.00	18	62
15	1	59.00	12	65
16	1	59.00	19	66
17	1	59.00	20	76
18	1	59.00	21	80
19	1	59.00	22	91
20	1	59.00	25	104
21	1	59.00	26	106
22	1	59.00	27	111
23	1	59.00	28	112
24	1	59.00	31	117
25	1	59.00	32	117
26	1	59.00	33	118
27	1	59.00	11	119
28	1	59.00	27	125
29	1	59.00	33	126
30	1	59.00	34	128
31	1	59.00	35	131
32	1	59.00	31	141
33	1	59.00	36	156
34	1	59.00	16	158
35	1	59.00	12	159
36	1	59.00	37	160
37	1	59.00	38	164
38	1	59.00	39	166
39	1	59.00	40	169
40	1	59.00	41	171
41	1	59.00	42	172
42	1	59.00	43	175
43	1	59.00	46	178
44	1	59.00	45	178
45	1	59.00	47	179
46	1	59.00	48	189
47	1	59.00	48	190
48	1	59.00	49	194
49	1	59.00	18	195
50	1	59.00	50	198
51	1	59.00	51	202
52	1	59.00	52	205
53	1	59.00	53	210
54	1	59.00	54	211
55	1	59.00	55	212
56	1	59.00	56	213
57	1	59.00	56	214
58	1	59.00	57	215
59	1	59.00	58	216
60	1	59.00	59	217
61	1	59.00	41	218
62	1	59.00	60	219
63	1	59.00	61	220
64	1	59.00	62	224
65	1	59.00	63	225
66	1	59.00	34	226
67	1	59.00	64	232
68	1	59.00	65	234
69	1	59.00	65	235
70	1	59.00	11	237
71	1	59.00	66	238
72	1	59.00	67	241
73	1	59.00	40	243
74	1	59.00	26	244
75	1	59.00	66	260
76	1	59.00	33	262
77	1	59.00	202	267
78	1	59.00	202	268
79	1	59.00	66	269
80	1	59.00	203	271
81	1	59.00	204	278
82	1	59.00	205	280
83	1	59.00	35	282
84	1	59.00	11	284
85	1	59.00	69	285
86	1	59.00	206	289
87	1	59.00	207	291
88	1	59.00	208	293
89	1	59.00	33	294
90	1	59.00	209	297
91	1	59.00	41	298
92	1	59.00	210	303
93	1	59.00	61	309
94	1	59.00	212	311
95	1	59.00	213	311
96	1	59.00	214	312
97	1	59.00	16	313
98	1	59.00	215	316
99	1	59.00	216	317
100	1	59.00	26	318
101	1	59.00	213	319
102	1	59.00	19	320
103	1	59.00	217	321
104	1	59.00	218	322
105	1	59.00	219	324
106	1	59.00	219	325
107	1	59.00	220	330
108	1	59.00	221	330
109	1	59.00	222	331
110	1	59.00	223	338
111	1	59.00	224	339
112	1	59.00	225	341
113	1	59.00	216	343
114	1	59.00	225	344
115	1	59.00	222	345
116	1	59.00	226	352
117	1	59.00	227	352
118	1	59.00	213	353
119	1	59.00	213	353
120	1	59.00	228	354
121	1	59.00	39	356
122	1	59.00	66	357
123	1	59.00	61	357
124	1	59.00	41	357
125	1	59.00	40	357
126	1	59.00	229	358
127	1	59.00	27	359
128	1	59.00	47	361
129	1	59.00	48	362
130	1	59.00	230	363
131	1	59.00	16	370
132	1	59.00	215	372
133	1	59.00	231	373
134	1	59.00	232	373
135	1	59.00	58	377
136	1	59.00	215	379
137	1	59.00	233	380
138	1	59.00	54	381
139	1	59.00	234	382
140	1	59.00	66	383
141	1	59.00	235	384
142	1	59.00	65	385
143	1	59.00	213	387
144	1	59.00	236	388
145	1	59.00	237	389
146	1	59.00	238	393
147	1	59.00	48	394
148	1	59.00	239	398
149	1	59.00	240	401
150	1	59.00	213	407
151	1	59.00	241	409
152	1	59.00	209	409
153	1	59.00	33	413
154	1	59.00	9	413
155	1	59.00	242	420
156	1	59.00	237	420
157	1	59.00	243	422
158	1	59.00	242	422
159	1	59.00	204	427
160	1	59.00	27	428
161	1	59.00	244	435
162	1	59.00	244	437
163	1	59.00	245	440
164	1	59.00	11	441
165	1	59.00	246	441
166	1	59.00	247	446
167	1	59.00	248	451
168	1	59.00	63	458
169	1	59.00	220	460
170	1	59.00	220	460
171	1	59.00	242	461
172	1	59.00	249	462
173	1	59.00	232	466
174	1	59.00	228	469
175	1	59.00	41	470
176	1	59.00	250	471
177	1	59.00	251	472
178	1	59.00	252	472
179	1	59.00	253	474
180	1	59.00	228	475
181	1	59.00	246	477
182	1	59.00	221	481
183	1	59.00	254	481
184	1	59.00	56	484
185	1	59.00	255	485
186	1	59.00	237	486
187	1	59.00	14	486
188	1	59.00	256	488
189	1	59.00	240	489
190	1	59.00	223	490
191	1	59.00	35	497
192	1	59.00	222	500
193	1	59.00	247	501
194	1	59.00	1	503
195	1	59.00	258	505
196	1	59.00	222	507
197	1	59.00	227	507
198	1	59.00	259	507
199	1	59.00	215	508
200	1	59.00	260	509
201	1	59.00	261	510
202	1	59.00	11	511
203	1	59.00	262	511
204	1	59.00	263	511
205	1	59.00	264	511
206	1	59.00	218	515
207	1	59.00	26	515
208	1	59.00	265	515
209	1	59.00	65	516
210	1	59.00	266	518
211	1	59.00	267	524
212	1	59.00	47	526
213	1	59.00	268	527
214	1	59.00	269	528
215	1	59.00	240	529
216	1	59.00	217	532
217	1	59.00	57	533
218	1	59.00	270	535
219	1	59.00	19	536
220	1	59.00	271	537
221	1	59.00	271	537
222	1	59.00	12	539
223	1	59.00	220	541
224	1	59.00	271	544
225	1	59.00	271	545
226	1	59.00	47	544
227	1	59.00	47	545
228	1	59.00	271	546
229	1	59.00	271	547
230	1	59.00	47	546
231	1	59.00	47	547
232	1	59.00	16	552
233	1	59.00	48	553
234	1	59.00	255	556
235	1	59.00	272	557
236	1	59.00	273	558
237	1	59.00	274	559
238	1	59.00	272	557
239	1	59.00	272	558
240	1	59.00	273	559
241	1	59.00	275	560
242	1	59.00	274	560
243	1	59.00	262	561
244	1	59.00	276	569
245	1	59.00	277	571
246	1	59.00	16	577
247	1	59.00	278	578
248	1	59.00	241	579
249	1	59.00	241	579
250	1	59.00	241	579
251	1	59.00	279	579
252	1	59.00	279	579
253	1	59.00	279	579
254	1	59.00	280	579
255	1	59.00	280	579
256	1	59.00	281	580
257	1	59.00	276	584
258	1	59.00	240	586
260	1	59.00	6	590
261	1	59.00	6	590
262	1	59.00	6	591
263	1	59.00	6	591
264	1	59.00	283	594
265	1	59.00	281	596
266	1	59.00	281	596
267	1	59.00	281	596
268	1	59.00	281	596
270	1	59.00	284	596
272	1	59.00	284	596
295	1	59.00	254	601
296	1	59.00	285	602
297	1	59.00	271	603
298	1	59.00	281	604
299	1	59.00	286	605
301	1	59.00	288	607
302	1	59.00	289	607
303	1	59.00	40	608
304	1	59.00	41	609
305	1	59.00	202	610
306	1	59.00	290	614
307	1	59.00	33	617
309	1	59.00	224	624
310	1	59.00	291	625
311	1	59.00	33	626
312	1	59.00	292	627
313	1	59.00	292	628
314	1	59.00	9	629
315	1	59.00	9	630
316	1	59.00	224	631
317	1	59.00	19	632
318	1	59.00	292	633
319	1	59.00	292	634
320	1	59.00	224	635
321	1	59.00	224	636
322	1	59.00	9	637
323	1	59.00	222	639
324	1	59.00	222	640
325	1	59.00	286	641
327	1	59.00	222	643
328	1	59.00	293	645
329	1	59.00	210	646
330	1	59.00	294	647
331	1	59.00	295	649
332	1	59.00	295	649
333	1	59.00	296	649
334	1	59.00	296	649
335	1	59.00	296	649
336	1	59.00	227	650
337	1	59.00	297	650
338	1	59.00	224	651
339	1	59.00	55	652
340	1	59.00	298	652
341	1	59.00	6	653
342	1	59.00	299	655
344	1	59.00	301	661
345	1	59.00	302	667
346	1	59.00	240	668
347	1	59.00	300	669
348	1	59.00	303	672
351	1	59.00	305	676
352	1	59.00	304	677
353	1	59.00	306	679
354	1	59.00	307	680
355	1	59.00	303	681
356	1	59.00	251	682
357	1	59.00	308	682
358	1	59.00	309	688
360	1	59.00	262	695
361	1	59.00	227	697
362	1	59.00	267	698
363	1	59.00	311	699
364	1	59.00	312	699
365	1	59.00	312	699
366	1	59.00	312	699
367	1	59.00	313	699
368	1	59.00	313	699
369	1	59.00	311	700
370	1	59.00	312	700
371	1	59.00	312	700
372	1	59.00	312	700
373	1	59.00	313	700
374	1	59.00	313	700
375	1	59.00	295	701
376	1	59.00	314	705
377	1	59.00	315	707
378	1	59.00	316	710
379	1	59.00	300	712
380	1	59.00	48	719
381	1	59.00	317	720
382	1	59.00	318	721
383	1	59.00	319	722
384	1	59.00	320	723
385	1	59.00	254	724
386	1	59.00	321	727
387	1	59.00	19	730
388	1	59.00	223	733
389	1	69.00	322	740
390	1	69.00	311	741
\.


--
-- Name: sales_packagecartridgeticketdetail_id_seq; Type: SEQUENCE SET; Schema: public; Owner: digimundo
--

SELECT pg_catalog.setval('sales_packagecartridgeticketdetail_id_seq', 390, true);


--
-- Data for Name: sales_ticketbase; Type: TABLE DATA; Schema: public; Owner: digimundo
--

COPY sales_ticketbase (id, created_at, payment_type, order_number, is_active) FROM stdin;
4	2017-07-10 10:37:22.700809-05	CA	1	t
5	2017-07-10 10:37:59.816633-05	CA	2	t
13	2017-07-11 06:38:12.167856-05	CA	7	t
14	2017-07-12 04:41:10.730647-05	CA	8	t
15	2017-07-12 04:46:42.518373-05	CA	9	t
16	2017-07-12 04:51:32.521601-05	CA	10	t
17	2017-07-12 07:32:29.977933-05	CA	11	t
18	2017-07-12 07:33:00.709385-05	CA	12	t
19	2017-07-13 02:25:39.345709-05	CA	13	t
20	2017-07-13 02:33:25.69864-05	CA	14	t
21	2017-07-13 02:52:25.677898-05	CA	15	t
22	2017-07-13 03:34:25.182047-05	CA	16	t
23	2017-07-13 04:00:11.45188-05	CA	17	t
24	2017-07-13 04:26:53.642323-05	CA	18	t
25	2017-07-13 04:37:28.301313-05	CA	19	t
26	2017-07-13 04:39:39.156829-05	CA	20	t
27	2017-07-13 05:11:36.151505-05	CA	21	t
28	2017-07-13 05:17:31.381362-05	CA	22	t
29	2017-07-13 05:22:00.438845-05	CA	23	t
30	2017-07-13 05:29:18.929617-05	CA	24	t
31	2017-07-13 09:06:30.766804-05	CA	25	t
32	2017-07-14 02:32:43.023404-05	CA	26	t
33	2017-07-14 02:58:58.079371-05	CA	27	t
34	2017-07-14 02:59:20.995326-05	CA	28	t
35	2017-07-14 02:59:38.556611-05	CA	29	t
36	2017-07-14 03:00:01.301937-05	CA	30	t
37	2017-07-14 04:22:49.170189-05	CA	31	t
38	2017-07-14 04:23:17.216048-05	CA	32	t
39	2017-07-14 08:07:55.321006-05	CA	33	t
40	2017-07-14 08:43:21.952608-05	CA	34	t
41	2017-07-15 03:41:13.708176-05	CA	35	t
42	2017-07-15 04:44:04.105612-05	CA	36	t
43	2017-07-15 05:05:48.75673-05	CA	37	t
44	2017-07-15 05:09:57.945678-05	CA	38	t
45	2017-07-15 05:11:00.761797-05	CA	39	t
46	2017-07-15 05:18:51.584438-05	CA	40	t
47	2017-07-15 06:01:22.876499-05	CA	41	t
48	2017-07-15 06:32:55.391889-05	CA	42	t
49	2017-07-15 06:57:22.327066-05	CA	43	t
50	2017-07-15 07:01:56.66102-05	CA	44	t
51	2017-07-15 07:27:27.128056-05	CA	45	t
52	2017-07-15 07:44:10.926624-05	CA	46	t
53	2017-07-15 07:48:20.616918-05	CA	47	t
54	2017-07-15 08:43:08.410759-05	CA	48	t
55	2017-07-15 08:57:12.84543-05	CA	49	t
56	2017-07-17 03:12:02.858664-05	CA	50	t
57	2017-07-17 03:37:24.14631-05	CA	51	t
58	2017-07-17 04:26:58.99846-05	CA	52	t
59	2017-07-17 04:49:39.203609-05	CA	53	t
60	2017-07-17 04:52:35.250937-05	CA	54	t
61	2017-07-17 07:05:28.395942-05	CA	55	t
62	2017-07-17 07:21:43.169024-05	CA	56	t
63	2017-07-17 07:55:14.880441-05	CA	57	t
64	2017-07-18 02:56:23.674069-05	CA	58	t
65	2017-07-18 03:09:05.970693-05	CA	59	t
66	2017-07-18 04:07:03.570848-05	CA	60	t
67	2017-07-18 04:32:35.005816-05	CA	61	t
68	2017-07-18 04:48:18.169832-05	CA	62	t
69	2017-07-18 04:53:24.424211-05	CA	63	t
70	2017-07-18 05:07:29.106793-05	CA	64	t
71	2017-07-18 05:22:54.389745-05	CA	65	t
72	2017-07-18 05:58:20.485592-05	CA	66	t
73	2017-07-18 07:01:00.124418-05	CA	67	t
74	2017-07-18 08:24:55.310692-05	CA	68	t
75	2017-07-19 02:47:10.295544-05	CA	69	t
76	2017-07-19 02:51:16.428995-05	CA	70	t
77	2017-07-19 04:05:32.862472-05	CA	71	t
78	2017-07-19 04:26:02.402054-05	CA	72	t
79	2017-07-19 04:45:23.548945-05	CA	73	t
80	2017-07-19 04:55:16.886472-05	CA	74	t
81	2017-07-19 05:03:20.561598-05	CA	75	t
82	2017-07-19 05:41:28.385109-05	CA	76	t
83	2017-07-19 06:10:12.786251-05	CA	77	t
84	2017-07-19 06:40:04.303687-05	CA	78	t
85	2017-07-20 02:27:35.882661-05	CA	79	t
86	2017-07-20 02:58:46.131395-05	CA	80	t
87	2017-07-20 03:12:18.894634-05	CA	81	t
88	2017-07-20 04:03:42.273647-05	CA	82	t
89	2017-07-20 04:05:59.540777-05	CA	83	t
90	2017-07-20 04:07:34.358775-05	CA	84	t
91	2017-07-20 05:02:56.175451-05	CA	85	t
94	2017-07-20 06:08:41.002206-05	CA	88	t
95	2017-07-20 06:22:17.157728-05	CA	89	t
96	2017-07-20 06:23:19.892777-05	CA	90	t
97	2017-07-20 06:49:47.83049-05	CA	91	t
98	2017-07-20 06:52:28.615427-05	CA	92	t
100	2017-07-20 08:16:19.738131-05	CA	93	t
101	2017-07-20 08:45:58.344461-05	CA	94	t
102	2017-07-20 08:51:47.440164-05	CA	95	t
104	2017-07-21 02:41:09.213005-05	CA	96	t
106	2017-07-21 03:39:59.498269-05	CA	98	t
107	2017-07-21 03:41:34.380629-05	CA	99	t
108	2017-07-21 04:50:35.521952-05	CA	100	t
109	2017-07-21 05:11:06.923116-05	CA	101	t
110	2017-07-21 05:26:10.722768-05	CA	102	t
111	2017-07-21 06:24:01.503399-05	CA	103	t
112	2017-07-21 06:37:17.929015-05	CA	104	t
113	2017-07-21 07:16:29.025846-05	CA	105	t
114	2017-07-21 07:18:04.209304-05	CA	106	t
117	2017-07-22 04:19:36.829793-05	CA	107	t
118	2017-07-22 05:11:49.371731-05	CA	108	t
119	2017-07-22 05:42:22.111858-05	CA	109	t
120	2017-07-22 06:03:31.831673-05	CA	110	t
121	2017-07-22 06:03:56.812495-05	CA	111	t
122	2017-07-22 06:04:22.294553-05	CA	112	t
123	2017-07-22 06:06:46.595265-05	CA	113	t
124	2017-07-22 06:11:39.432149-05	CA	114	t
125	2017-07-22 06:26:38.866214-05	CA	115	t
126	2017-07-22 06:39:57.512827-05	CA	116	t
127	2017-07-22 06:51:22.967822-05	CA	117	t
128	2017-07-22 07:21:29.140296-05	CA	118	t
131	2017-07-24 04:14:39.489016-05	CA	119	t
132	2017-07-24 05:19:36.374026-05	CR	120	t
133	2017-07-24 05:53:49.022316-05	CA	121	t
134	2017-07-24 06:08:37.850838-05	CA	122	t
135	2017-07-24 06:34:06.786372-05	CA	123	t
136	2017-07-24 06:36:17.97696-05	CA	124	t
137	2017-07-24 08:01:07.825601-05	CA	125	t
138	2017-07-24 08:01:39.336504-05	CA	126	t
139	2017-07-25 04:04:30.208781-05	CA	127	t
140	2017-07-25 04:51:28.223496-05	CA	128	t
141	2017-07-25 05:38:49.95101-05	CA	129	t
142	2017-07-25 06:09:49.624785-05	CA	130	t
143	2017-07-25 06:41:15.642017-05	CA	131	t
144	2017-07-26 03:18:35.103942-05	CA	132	t
145	2017-07-26 04:34:38.301723-05	CA	133	t
146	2017-07-26 04:37:20.847221-05	CA	134	t
147	2017-07-26 05:16:27.104131-05	CA	135	t
148	2017-07-26 05:18:09.817169-05	CA	136	t
149	2017-07-26 05:35:37.644697-05	CA	137	t
150	2017-07-26 06:34:23.989829-05	CA	138	t
151	2017-07-26 07:40:28.988203-05	CA	139	t
152	2017-07-26 08:02:06.473447-05	CA	140	t
153	2017-07-27 03:37:30.982757-05	CA	141	t
154	2017-07-27 05:31:06.428393-05	CA	142	t
155	2017-07-27 06:14:59.031442-05	CA	143	t
156	2017-07-27 06:33:11.766102-05	CA	144	t
157	2017-07-27 06:54:07.897905-05	CA	145	t
158	2017-07-27 06:55:54.744936-05	CA	146	t
159	2017-07-27 06:57:05.413758-05	CA	147	t
160	2017-07-27 07:40:27.634493-05	CA	148	t
161	2017-07-27 08:06:56.280144-05	CA	149	t
162	2017-07-28 04:36:06.022524-05	CA	150	t
163	2017-07-28 04:51:43.401483-05	CR	151	t
164	2017-07-28 05:43:24.548995-05	CA	152	t
165	2017-07-28 05:45:56.960163-05	CA	153	t
166	2017-07-28 05:56:06.481261-05	CA	154	t
167	2017-07-28 06:35:49.095435-05	CA	155	t
168	2017-07-28 07:39:08.100664-05	CA	156	t
169	2017-07-28 08:14:48.59915-05	CA	157	t
170	2017-07-29 05:46:17.085763-05	CA	158	t
171	2017-07-29 06:22:45.915859-05	CA	159	t
172	2017-07-29 06:23:39.470925-05	CA	160	t
173	2017-07-29 06:24:14.155136-05	CA	161	t
174	2017-07-29 06:45:32.993596-05	CA	162	t
175	2017-07-29 07:21:28.947545-05	CA	163	t
176	2017-07-29 07:52:00.80192-05	CA	164	t
178	2017-07-29 08:01:24.968794-05	CA	166	t
179	2017-07-29 08:14:40.289032-05	CA	167	t
183	2017-07-31 05:46:48.464746-05	CA	168	t
185	2017-07-31 05:48:02.84722-05	CR	170	t
186	2017-07-31 05:55:02.031638-05	CR	171	t
188	2017-07-31 06:31:58.182631-05	CA	172	t
189	2017-07-31 06:53:38.381416-05	CA	173	t
190	2017-07-31 06:55:14.49281-05	CA	174	t
191	2017-07-31 08:02:23.643286-05	CA	175	t
192	2017-07-31 08:25:47.273273-05	CA	176	t
193	2017-07-31 08:46:00.196393-05	CA	177	t
194	2017-07-31 09:08:17.234534-05	CA	178	t
195	2017-07-31 09:14:05.93922-05	CA	179	t
196	2017-07-31 09:15:28.661493-05	CA	180	t
197	2017-08-01 03:18:47.080573-05	CA	181	t
198	2017-08-01 03:49:49.539013-05	CA	182	t
199	2017-08-01 05:02:48.795527-05	CA	183	t
200	2017-08-01 05:06:10.318149-05	CA	184	t
201	2017-08-01 06:14:28.066473-05	CA	185	t
202	2017-08-01 07:31:30.625126-05	CA	186	t
203	2017-08-01 07:32:00.634071-05	CA	187	t
204	2017-08-01 07:54:22.750155-05	CA	188	t
205	2017-08-01 07:56:20.278563-05	CA	189	t
206	2017-08-02 02:41:30.905497-05	CA	190	t
207	2017-08-02 04:03:45.067921-05	CA	191	t
208	2017-08-02 04:40:55.812933-05	CA	192	t
209	2017-08-02 04:54:03.826311-05	CA	193	t
210	2017-08-02 05:20:14.960258-05	CA	194	t
211	2017-08-02 06:45:52.616593-05	CA	195	t
212	2017-08-02 07:15:46.070007-05	CA	196	t
213	2017-08-02 07:18:39.315794-05	CA	197	t
214	2017-08-02 07:21:49.380573-05	CA	198	t
215	2017-08-02 07:25:29.224623-05	CA	199	t
216	2017-08-02 07:47:45.902179-05	CA	200	t
217	2017-08-02 08:11:09.562096-05	CA	201	t
218	2017-08-02 08:35:13.832779-05	CA	202	t
219	2017-08-02 09:06:06.215339-05	CA	203	t
220	2017-08-02 10:08:06.505112-05	CA	204	t
221	2017-08-03 04:42:55.879571-05	CA	205	t
223	2017-08-03 05:53:20.757714-05	CR	207	t
224	2017-08-03 07:23:08.052719-05	CA	208	t
225	2017-08-03 09:14:00.941522-05	CA	209	t
226	2017-08-03 09:15:15.584223-05	CA	210	t
227	2017-08-04 02:53:36.266722-05	CA	211	t
228	2017-08-04 02:54:44.860052-05	CA	212	t
229	2017-08-04 02:55:47.226736-05	CA	213	t
231	2017-08-04 02:59:11.180235-05	CA	215	t
232	2017-08-04 04:11:01.825313-05	CA	216	t
233	2017-08-04 04:15:19.436635-05	CA	217	t
234	2017-08-04 04:24:34.205096-05	CA	218	t
235	2017-08-04 04:26:34.756938-05	CA	219	t
236	2017-08-04 04:27:17.769921-05	CA	220	t
237	2017-08-04 04:47:27.327807-05	CA	221	t
238	2017-08-04 04:49:36.203015-05	CA	222	t
239	2017-08-04 05:34:49.146115-05	CA	223	t
240	2017-08-04 05:51:11.266581-05	CA	224	t
241	2017-08-04 05:53:47.287887-05	CA	225	t
242	2017-08-04 06:31:04.01857-05	CA	226	t
243	2017-08-04 07:18:44.135089-05	CA	227	t
244	2017-08-04 07:37:51.592903-05	CA	228	t
247	2017-08-04 08:07:53.047157-05	CA	231	t
3	2017-08-05 08:58:20.997701-05	CA	232	t
7	2017-08-05 10:49:01.488952-05	CA	233	t
257	2017-08-07 10:30:28.844259-05	CA	234	t
258	2017-08-07 11:01:45.783231-05	CA	235	t
259	2017-08-07 11:18:36.328947-05	CA	236	t
260	2017-08-07 11:30:09.072165-05	CA	237	t
262	2017-08-07 11:37:28.558298-05	CA	238	t
263	2017-08-07 13:20:45.79815-05	CA	239	t
264	2017-08-08 07:48:17.438012-05	CA	240	t
265	2017-08-08 09:12:34.252554-05	CA	241	t
266	2017-08-08 10:30:41.725117-05	CA	242	t
267	2017-08-08 11:18:57.464119-05	CA	243	t
268	2017-08-08 11:19:42.431756-05	CA	244	t
269	2017-08-08 11:20:26.515974-05	CA	245	t
270	2017-08-08 11:20:57.422401-05	CA	246	t
271	2017-08-08 11:55:03.037065-05	CA	247	t
272	2017-08-08 12:39:32.635985-05	CA	248	t
273	2017-08-08 13:24:50.56261-05	CA	249	t
274	2017-08-08 14:00:56.284528-05	CA	250	t
275	2017-08-09 07:36:09.852475-05	CR	251	t
276	2017-08-09 08:43:21.381821-05	CA	252	t
277	2017-08-09 08:46:07.966783-05	CA	253	t
278	2017-08-10 08:01:23.031463-05	CA	254	t
279	2017-08-10 11:31:34.423471-05	CA	255	t
280	2017-08-10 11:46:14.345506-05	CA	256	t
281	2017-08-11 08:12:55.725173-05	CA	257	t
282	2017-08-11 08:31:13.943897-05	CR	258	t
283	2017-08-11 08:35:57.589713-05	CA	259	t
284	2017-08-11 09:33:10.086102-05	CA	260	t
285	2017-08-11 09:33:47.050224-05	CA	261	t
287	2017-08-11 09:47:20.908725-05	CA	263	t
288	2017-08-11 10:44:05.356552-05	CA	264	t
289	2017-08-11 11:52:30.663124-05	CA	265	t
290	2017-08-11 12:16:41.324311-05	CA	266	t
291	2017-08-11 12:22:01.073955-05	CA	267	t
292	2017-08-12 09:13:05.27646-05	CA	268	t
293	2017-08-12 09:19:26.849453-05	CA	269	t
294	2017-08-12 10:31:44.027175-05	CA	270	t
295	2017-08-12 10:33:24.474835-05	CA	271	t
296	2017-08-12 13:11:55.169122-05	CA	272	t
297	2017-08-12 13:13:11.130409-05	CA	273	t
298	2017-08-12 13:22:31.721282-05	CA	274	t
299	2017-08-14 07:58:04.916947-05	CA	275	t
301	2017-08-14 08:03:05.805984-05	CA	277	t
302	2017-08-14 11:35:53.221254-05	CA	278	t
303	2017-08-14 11:38:08.455102-05	CA	279	t
304	2017-08-14 11:38:49.200224-05	CA	280	t
306	2017-08-15 07:29:51.082132-05	CA	281	t
307	2017-08-15 08:22:14.608486-05	CA	282	t
308	2017-08-15 13:50:20.836693-05	CA	283	t
309	2017-08-15 13:55:55.463693-05	CA	284	t
310	2017-08-15 14:25:35.433322-05	CA	285	t
311	2017-08-16 08:12:48.349784-05	CA	286	t
312	2017-08-16 08:52:18.291302-05	CA	287	t
313	2017-08-16 08:56:18.700119-05	CA	288	t
314	2017-08-16 09:33:13.696826-05	CA	289	t
315	2017-08-16 09:44:55.65425-05	CA	290	t
316	2017-08-16 09:59:30.388984-05	CA	291	t
317	2017-08-16 10:01:00.270953-05	CA	292	t
318	2017-08-17 07:54:22.312921-05	CR	293	t
319	2017-08-17 08:59:50.18006-05	CA	294	t
320	2017-08-17 09:12:50.297073-05	CA	295	t
321	2017-08-17 09:15:03.101301-05	CA	296	t
322	2017-08-17 09:16:07.730906-05	CA	297	t
323	2017-08-17 09:17:01.909107-05	CA	298	t
324	2017-08-17 09:23:28.173213-05	CA	299	t
325	2017-08-17 09:24:50.672484-05	CA	300	t
326	2017-08-17 09:26:37.036713-05	CA	301	t
327	2017-08-17 09:27:07.007195-05	CA	302	t
329	2017-08-17 09:58:12.96848-05	CA	303	t
330	2017-08-17 10:09:10.982225-05	CA	304	t
331	2017-08-17 10:23:55.771265-05	CA	305	t
332	2017-08-17 10:56:47.380152-05	CA	306	t
333	2017-08-17 10:56:49.472553-05	CA	307	t
334	2017-08-17 10:56:50.680232-05	CA	308	t
335	2017-08-17 10:56:51.638376-05	CA	309	t
336	2017-08-17 14:09:43.427891-05	CA	310	t
337	2017-08-18 08:51:07.456241-05	CA	311	t
338	2017-08-18 08:55:28.615837-05	CA	312	t
339	2017-08-18 09:22:08.55629-05	CA	313	t
340	2017-08-18 09:38:41.132802-05	CA	314	t
341	2017-08-18 09:47:40.231728-05	CA	315	t
342	2017-08-18 09:55:43.493538-05	CA	316	t
343	2017-08-18 10:11:07.122508-05	CA	317	t
344	2017-08-18 10:19:15.375683-05	CA	318	t
345	2017-08-18 10:24:53.44132-05	CA	319	t
346	2017-08-18 10:25:38.938766-05	CA	320	t
347	2017-08-18 11:20:17.979095-05	CA	321	t
348	2017-08-18 11:35:29.692702-05	CA	322	t
349	2017-08-18 12:27:03.341317-05	CA	323	t
350	2017-08-18 13:35:52.938083-05	CA	324	t
352	2017-08-19 08:48:55.77492-05	CA	326	t
353	2017-08-19 09:08:06.775491-05	CA	327	t
354	2017-08-19 09:47:42.957839-05	CA	328	t
355	2017-08-19 09:49:47.185945-05	CA	329	t
356	2017-08-19 10:44:12.276543-05	CA	330	t
357	2017-08-19 10:58:23.891099-05	CA	331	t
358	2017-08-19 11:16:41.541232-05	CA	332	t
359	2017-08-19 11:20:46.658309-05	CA	333	t
360	2017-08-19 11:31:44.392938-05	CA	334	t
361	2017-08-19 11:43:29.57934-05	CA	335	t
362	2017-08-19 11:50:25.922011-05	CA	336	t
363	2017-08-19 12:29:15.726181-05	CA	337	t
364	2017-08-21 07:35:52.315236-05	CA	338	t
365	2017-08-21 09:01:37.87633-05	CA	339	t
366	2017-08-21 09:09:18.757794-05	CA	340	t
367	2017-08-21 09:51:23.949975-05	CA	341	t
368	2017-08-21 13:42:02.557379-05	CA	342	t
369	2017-08-22 08:33:33.095409-05	CA	343	t
370	2017-08-22 10:27:01.466659-05	CA	344	t
372	2017-08-22 10:29:37.463259-05	CA	346	t
373	2017-08-22 12:51:40.923716-05	CA	347	t
374	2017-08-22 14:20:25.464625-05	CA	348	t
375	2017-08-23 08:49:29.519494-05	CA	349	t
376	2017-08-23 09:06:09.288102-05	CA	350	t
377	2017-08-23 09:42:11.123093-05	CA	351	t
378	2017-08-23 10:49:06.794482-05	CA	352	t
379	2017-08-23 10:54:33.181778-05	CA	353	t
380	2017-08-23 11:37:40.415164-05	CA	354	t
381	2017-08-23 11:39:11.06807-05	CA	355	t
382	2017-08-23 11:41:43.206292-05	CA	356	t
383	2017-08-23 11:43:17.927779-05	CA	357	t
384	2017-08-23 11:43:53.748705-05	CA	358	t
385	2017-08-23 11:44:43.835656-05	CA	359	t
386	2017-08-23 14:04:29.724502-05	CA	360	t
387	2017-08-24 07:31:19.329547-05	CA	361	t
388	2017-08-24 08:22:42.30954-05	CA	362	t
389	2017-08-24 08:23:21.238607-05	CA	363	t
390	2017-08-24 08:33:35.287203-05	CA	364	t
391	2017-08-24 08:50:54.906235-05	CA	365	t
392	2017-08-24 10:07:56.786979-05	CA	366	t
393	2017-08-24 11:13:57.654357-05	CA	367	t
394	2017-08-24 12:36:55.962265-05	CA	368	t
395	2017-08-24 13:16:14.730668-05	CA	369	t
396	2017-08-24 13:20:33.669645-05	CA	370	t
397	2017-08-25 08:46:08.394921-05	CA	371	t
398	2017-08-25 09:08:41.94395-05	CA	372	t
399	2017-08-25 09:10:58.256767-05	CA	373	t
400	2017-08-25 09:52:50.01228-05	CA	374	t
401	2017-08-25 12:21:52.645369-05	CA	375	t
402	2017-08-25 13:03:08.82157-05	CA	376	t
403	2017-08-25 13:05:12.838403-05	CA	377	t
404	2017-08-26 10:08:48.336999-05	CA	378	t
405	2017-08-26 10:58:18.106261-05	CA	379	t
406	2017-08-26 11:08:04.41602-05	CA	380	t
407	2017-08-26 11:35:18.720595-05	CA	381	t
408	2017-08-26 11:38:13.863874-05	CA	382	t
409	2017-08-26 12:05:40.103721-05	CA	383	t
410	2017-08-28 08:25:07.822458-05	CA	384	t
411	2017-08-28 10:52:17.277909-05	CA	385	t
412	2017-08-28 12:34:54.447224-05	CA	386	t
413	2017-08-28 12:51:16.324329-05	CA	387	t
414	2017-08-28 13:18:24.32713-05	CA	388	t
415	2017-08-28 13:19:58.632837-05	CA	389	t
416	2017-08-28 13:33:54.677414-05	CA	390	t
417	2017-08-29 08:33:20.16045-05	CA	391	t
418	2017-08-29 09:15:43.062617-05	CA	392	t
419	2017-08-29 10:20:33.551153-05	CA	393	t
420	2017-08-29 10:59:49.351215-05	CA	394	t
421	2017-08-29 11:20:58.680029-05	CA	395	t
422	2017-08-29 11:47:55.814512-05	CA	396	t
423	2017-08-29 12:40:30.555083-05	CA	397	t
424	2017-08-29 13:24:53.255979-05	CA	398	t
425	2017-08-30 09:49:32.797729-05	CA	399	t
426	2017-08-30 10:28:02.254867-05	CA	400	t
427	2017-08-30 11:31:45.40893-05	CA	401	t
428	2017-08-30 12:25:49.282616-05	CA	402	t
429	2017-08-30 12:53:21.723635-05	CA	403	t
431	2017-08-31 09:35:37.129013-05	CA	405	t
432	2017-08-31 09:36:43.712551-05	CR	406	t
433	2017-08-31 10:09:22.691991-05	CA	407	t
434	2017-08-31 11:17:55.229575-05	CA	408	t
435	2017-08-31 11:41:36.750418-05	CA	409	t
436	2017-08-31 12:03:10.851253-05	CA	410	t
437	2017-08-31 12:07:20.085307-05	CA	411	t
438	2017-08-31 12:25:54.574393-05	CA	412	t
439	2017-08-31 12:27:19.684499-05	CA	413	t
440	2017-08-31 12:43:56.981643-05	CA	414	t
441	2017-08-31 13:36:41.956445-05	CA	415	t
442	2017-09-01 07:48:20.257885-05	CA	416	t
446	2017-09-01 09:27:28.95607-05	CA	420	t
447	2017-09-01 09:32:12.079746-05	CA	421	t
448	2017-09-01 09:36:35.791785-05	CA	422	t
449	2017-09-01 09:48:59.401783-05	CA	423	t
450	2017-09-01 09:51:50.794716-05	CA	424	t
451	2017-09-01 10:11:09.872163-05	CA	425	t
452	2017-09-01 10:41:20.744253-05	CA	426	t
453	2017-09-01 11:38:20.075077-05	CA	427	t
454	2017-09-01 12:46:40.216619-05	CA	428	t
455	2017-09-01 13:13:04.308432-05	CA	429	t
456	2017-09-01 13:13:23.559518-05	CA	430	t
457	2017-09-01 13:18:05.90663-05	CA	431	t
458	2017-09-01 14:15:35.344077-05	CA	432	t
459	2017-09-02 07:31:28.7453-05	CA	433	t
460	2017-09-02 09:25:46.065544-05	CA	434	t
461	2017-09-02 09:40:12.777686-05	CA	435	t
462	2017-09-02 09:41:54.116519-05	CA	436	t
463	2017-09-02 09:59:47.617061-05	CA	437	t
464	2017-09-02 10:41:50.289756-05	CR	438	t
465	2017-09-02 11:29:55.939789-05	CA	439	t
466	2017-09-02 12:23:04.957424-05	CA	440	t
468	2017-09-04 07:42:36.69762-05	CA	442	t
469	2017-09-04 08:55:07.957314-05	CA	443	t
470	2017-09-04 08:55:53.67376-05	CA	444	t
471	2017-09-04 09:48:46.737755-05	CA	445	t
472	2017-09-04 10:28:02.407911-05	CA	446	t
473	2017-09-04 10:45:39.314244-05	CA	447	t
474	2017-09-04 11:06:41.369289-05	CA	448	t
475	2017-09-04 11:24:38.793598-05	CA	449	t
476	2017-09-04 11:29:05.556817-05	CA	450	t
477	2017-09-04 11:38:31.103288-05	CA	451	t
478	2017-09-04 11:55:22.29657-05	CA	452	t
479	2017-09-04 12:21:26.293952-05	CA	453	t
480	2017-09-04 13:27:51.774777-05	CA	454	t
481	2017-09-05 10:28:04.550581-05	CA	455	t
482	2017-09-05 11:19:14.451823-05	CA	456	t
483	2017-09-05 12:45:55.882759-05	CA	457	t
484	2017-09-05 13:01:48.724847-05	CA	458	t
485	2017-09-06 07:59:55.966491-05	CA	459	t
486	2017-09-06 08:14:11.638876-05	CA	460	t
487	2017-09-06 08:32:41.831512-05	CA	461	t
488	2017-09-06 09:26:30.61575-05	CA	462	t
489	2017-09-06 09:40:08.10307-05	CA	463	t
490	2017-09-06 09:43:11.029854-05	CA	464	t
491	2017-09-06 09:43:53.008135-05	CA	465	t
494	2017-09-06 11:20:26.936604-05	CA	468	t
495	2017-09-06 11:38:57.619033-05	CA	469	t
496	2017-09-06 11:53:57.721214-05	CA	470	t
497	2017-09-06 12:33:50.267517-05	CA	471	t
498	2017-09-06 12:57:41.738475-05	CA	472	t
500	2017-09-07 08:58:24.375149-05	CA	474	t
501	2017-09-07 10:49:17.722538-05	CA	475	t
502	2017-09-07 12:11:08.555672-05	CA	476	t
503	2017-09-07 12:35:09.522176-05	CA	477	t
504	2017-09-07 12:36:36.271542-05	CA	478	t
505	2017-09-08 10:28:26.884256-05	CA	479	t
506	2017-09-08 10:29:17.638524-05	CA	480	t
507	2017-09-08 10:34:30.260972-05	CA	481	t
508	2017-09-08 10:41:07.991413-05	CA	482	t
509	2017-09-08 11:13:55.88417-05	CA	483	t
510	2017-09-08 11:41:17.088456-05	CA	484	t
511	2017-09-09 08:17:12.462802-05	CR	485	t
513	2017-09-09 08:20:31.817223-05	CR	487	t
515	2017-09-09 09:25:57.682647-05	CA	488	t
516	2017-09-09 09:39:35.936144-05	CA	489	t
517	2017-09-09 09:46:05.93701-05	CA	490	t
518	2017-09-09 09:50:03.154392-05	CA	491	t
520	2017-09-09 10:44:50.16556-05	CA	493	t
521	2017-09-09 10:49:13.461804-05	CR	494	t
522	2017-09-09 11:40:38.508975-05	CA	495	t
523	2017-09-09 12:07:20.43457-05	CA	496	t
524	2017-09-09 13:38:38.317471-05	CA	497	t
525	2017-09-09 13:51:03.571214-05	CA	498	t
526	2017-09-11 08:54:53.029099-05	CA	499	t
527	2017-09-11 09:04:41.216118-05	CA	500	t
528	2017-09-11 09:51:07.418334-05	CA	501	t
529	2017-09-11 10:27:01.046896-05	CA	502	t
530	2017-09-11 10:41:50.070259-05	CA	503	t
531	2017-09-11 10:44:08.964582-05	CA	504	t
532	2017-09-11 11:12:16.716093-05	CA	505	t
533	2017-09-11 11:40:43.533256-05	CA	506	t
534	2017-09-11 12:24:59.480356-05	CA	507	t
535	2017-09-11 13:14:07.510564-05	CA	508	t
536	2017-09-12 08:21:25.96198-05	CA	509	t
537	2017-09-12 09:53:40.420232-05	CA	510	t
538	2017-09-12 09:54:46.708135-05	CA	511	t
539	2017-09-12 11:35:44.378069-05	CA	512	t
540	2017-09-12 11:47:37.894598-05	CA	513	t
541	2017-09-12 12:27:23.118097-05	CA	514	t
542	2017-09-12 13:27:13.423154-05	CA	515	t
543	2017-09-13 08:33:46.78174-05	CR	516	t
544	2017-09-13 08:59:47.954987-05	CA	517	t
545	2017-09-13 08:59:48.058774-05	CA	518	t
546	2017-09-13 08:59:49.817594-05	CA	519	t
547	2017-09-13 08:59:49.815987-05	CA	519	t
548	2017-09-13 11:02:18.132816-05	CA	520	t
549	2017-09-13 11:31:52.202364-05	CA	521	t
550	2017-09-14 08:34:03.341184-05	CA	522	t
551	2017-09-14 13:17:43.776197-05	CA	523	t
552	2017-09-15 09:20:28.625805-05	CA	524	t
553	2017-09-15 10:30:37.995457-05	CA	525	t
554	2017-09-15 10:40:44.804947-05	CA	526	t
555	2017-09-15 10:43:26.167027-05	CA	527	t
556	2017-09-15 11:02:49.085418-05	CA	528	t
557	2017-09-15 11:40:57.629003-05	CA	529	t
558	2017-09-15 11:40:57.759798-05	CA	529	t
559	2017-09-15 11:40:57.896791-05	CA	530	t
560	2017-09-15 11:48:44.539435-05	CA	531	t
561	2017-09-15 11:56:54.856336-05	CA	532	t
562	2017-09-15 12:17:01.799266-05	CA	533	t
563	2017-09-15 12:35:28.066391-05	CR	534	t
565	2017-09-15 12:56:54.523097-05	CA	536	t
566	2017-09-18 07:25:57.603346-05	CA	537	t
567	2017-09-18 08:46:14.321721-05	CA	538	t
568	2017-09-18 09:31:02.114655-05	CA	539	t
569	2017-09-18 10:01:26.782574-05	CA	540	t
570	2017-09-18 10:06:32.902822-05	CA	541	t
571	2017-09-18 11:46:11.582131-05	CA	542	t
572	2017-09-18 12:34:08.214635-05	CA	543	t
573	2017-09-19 10:34:14.281338-05	CA	544	t
574	2017-09-19 11:34:09.958984-05	CA	545	t
575	2017-09-20 09:00:16.397257-05	CR	546	t
577	2017-09-20 09:12:51.030574-05	CA	548	t
578	2017-09-20 10:55:12.116169-05	CA	549	t
579	2017-09-20 12:29:10.895265-05	CA	550	t
580	2017-09-21 08:37:44.345903-05	CA	551	t
581	2017-09-21 09:18:58.006274-05	CA	552	t
582	2017-09-21 09:46:06.592614-05	CA	553	t
583	2017-09-21 09:47:03.458741-05	CA	554	t
584	2017-09-21 10:23:33.101419-05	CA	555	t
585	2017-09-21 11:37:20.003566-05	CA	556	t
586	2017-09-21 12:58:15.348963-05	CA	557	t
590	2017-09-22 08:43:49.665382-05	CA	560	t
591	2017-09-22 08:45:43.34578-05	CR	561	t
592	2017-09-22 09:56:47.412559-05	CA	562	t
594	2017-09-23 08:58:51.071777-05	CA	563	t
595	2017-09-23 10:16:57.959576-05	CA	564	t
596	2017-09-23 10:54:22.942972-05	CA	565	t
601	2017-09-23 11:14:04.369392-05	CA	570	t
602	2017-09-23 11:32:37.346203-05	CA	571	t
603	2017-09-23 11:48:42.976749-05	CA	572	t
604	2017-09-23 13:38:48.096041-05	CA	573	t
605	2017-09-25 09:25:27.82641-05	CA	574	t
607	2017-09-25 11:18:35.487076-05	CR	576	t
608	2017-09-25 11:38:03.192864-05	CA	577	t
609	2017-09-25 11:45:43.25134-05	CA	578	t
610	2017-09-25 12:52:11.813792-05	CR	579	t
611	2017-09-26 07:39:36.35272-05	CA	580	t
612	2017-09-26 08:16:21.77352-05	CA	581	t
613	2017-09-26 12:03:27.016293-05	CA	582	t
614	2017-09-26 12:05:23.432191-05	CR	583	t
616	2017-09-27 12:02:11.019245-05	CA	584	t
617	2017-09-27 12:03:24.284555-05	CR	585	t
618	2017-09-27 12:03:44.815401-05	CA	586	t
619	2017-09-27 12:04:04.58426-05	CA	587	t
620	2017-09-27 13:39:26.776739-05	CA	588	t
621	2017-09-28 09:06:29.684118-05	CR	589	t
623	2017-09-28 09:48:46.511086-05	CA	591	t
624	2017-09-28 10:30:42.375059-05	CA	592	t
625	2017-09-28 10:59:04.045176-05	CA	593	t
626	2017-09-29 06:43:23.898108-05	CA	594	t
627	2017-09-29 06:44:37.186599-05	CA	595	t
628	2017-09-29 06:46:33.876732-05	CA	596	t
629	2017-09-29 06:48:17.494963-05	CA	597	t
630	2017-09-29 06:49:56.772904-05	CA	598	t
631	2017-09-29 06:51:40.203859-05	CA	599	t
632	2017-09-29 06:53:11.832797-05	CA	600	t
633	2017-09-29 06:54:27.99945-05	CA	601	t
634	2017-09-29 06:56:24.856822-05	CR	602	t
635	2017-09-29 06:59:36.406224-05	CA	603	t
636	2017-09-29 07:06:10.140376-05	CA	604	t
637	2017-09-29 07:07:27.797095-05	CA	605	t
638	2017-09-29 07:44:21.65685-05	CA	606	t
639	2017-09-29 09:13:59.18141-05	CA	607	t
640	2017-09-29 09:15:32.004505-05	CR	608	t
641	2017-09-29 09:23:45.37039-05	CA	609	t
643	2017-09-29 09:35:23.453045-05	CR	611	t
644	2017-09-29 11:20:43.301219-05	CA	612	t
645	2017-09-29 11:47:02.028086-05	CA	613	t
646	2017-09-30 09:49:10.070828-05	CA	614	t
647	2017-09-30 09:49:47.039697-05	CA	615	t
648	2017-09-30 10:21:20.392347-05	CA	616	t
649	2017-09-30 10:23:56.371874-05	CA	617	t
650	2017-09-30 11:16:41.387259-05	CA	618	t
651	2017-09-30 11:32:23.272858-05	CA	619	t
652	2017-09-30 11:40:09.35555-05	CA	620	t
653	2017-09-30 12:18:08.71329-05	CA	621	t
654	2017-10-02 07:56:19.878902-05	CA	622	t
655	2017-10-02 08:45:33.771539-05	CA	623	t
657	2017-10-02 12:18:41.250656-05	CA	625	t
658	2017-10-02 12:20:35.263853-05	CR	626	t
659	2017-10-02 12:30:07.478849-05	CA	627	t
660	2017-10-03 08:28:03.774007-05	CA	628	t
661	2017-10-03 09:03:13.961213-05	CA	629	t
662	2017-10-03 09:41:16.796027-05	CA	630	t
663	2017-10-03 09:46:45.482744-05	CA	631	t
664	2017-10-03 10:32:53.564716-05	CA	632	t
665	2017-10-03 10:35:34.337276-05	CA	633	t
666	2017-10-03 11:13:25.556588-05	CA	634	t
667	2017-10-03 11:34:07.568857-05	CA	635	t
668	2017-10-03 12:13:08.286734-05	CR	636	t
669	2017-10-03 12:40:49.554572-05	CA	637	t
670	2017-10-04 08:40:28.431042-05	CA	638	t
671	2017-10-04 11:24:10.645078-05	CA	639	t
672	2017-10-04 11:48:36.546065-05	CA	640	t
673	2017-10-04 12:03:53.293758-05	CA	641	t
676	2017-10-04 13:38:43.582965-05	CR	643	t
677	2017-10-04 13:53:11.970605-05	CR	644	t
678	2017-10-05 08:48:07.386626-05	CA	645	t
679	2017-10-05 10:22:22.398156-05	CA	646	t
680	2017-10-05 11:12:03.875402-05	CA	647	t
681	2017-10-05 11:21:03.328695-05	CA	648	t
682	2017-10-05 11:41:36.903492-05	CA	649	t
683	2017-10-05 12:04:23.772092-05	CA	650	t
684	2017-10-05 12:30:08.396501-05	CA	651	t
685	2017-10-05 13:21:18.511502-05	CA	652	t
686	2017-10-05 13:27:54.309205-05	CA	653	t
688	2017-10-06 07:40:41.893685-05	CA	655	t
690	2017-10-06 09:13:12.153089-05	CA	656	t
691	2017-10-06 09:40:43.380253-05	CA	657	t
693	2017-10-06 09:56:52.191056-05	CA	659	t
694	2017-10-06 10:13:41.648633-05	CA	660	t
695	2017-10-06 10:37:11.466222-05	CA	661	t
696	2017-10-06 11:35:47.701973-05	CA	662	t
697	2017-10-06 13:21:20.395292-05	CA	663	t
698	2017-10-07 08:48:37.634174-05	CA	664	t
699	2017-10-07 09:48:53.814066-05	CA	665	t
700	2017-10-07 09:48:55.594423-05	CA	666	t
701	2017-10-07 10:25:29.291861-05	CA	667	t
702	2017-10-07 10:28:10.260212-05	CA	668	t
703	2017-10-07 11:25:03.329549-05	CA	669	t
704	2017-10-07 12:00:13.677567-05	CA	670	t
705	2017-10-07 12:38:40.291718-05	CA	671	t
706	2017-10-07 13:26:28.006551-05	CA	672	t
707	2017-10-07 14:29:26.344101-05	CA	673	t
708	2017-10-07 14:30:49.507825-05	CA	674	t
709	2017-10-07 14:31:10.494966-05	CA	675	t
710	2017-10-07 14:58:34.006867-05	CA	676	t
711	2017-10-09 07:52:40.129601-05	CA	677	t
712	2017-10-09 08:49:51.604722-05	CA	678	t
713	2017-10-09 09:44:19.786993-05	CA	679	t
714	2017-10-09 10:19:27.846673-05	CA	680	t
715	2017-10-09 10:19:51.4155-05	CA	681	t
716	2017-10-09 10:52:42.239443-05	CA	682	t
717	2017-10-09 11:52:54.371546-05	CA	683	t
718	2017-10-09 11:53:12.674135-05	CA	684	t
719	2017-10-10 11:19:18.033947-05	CA	685	t
720	2017-10-10 11:27:44.359572-05	CA	686	t
721	2017-10-10 11:36:12.129004-05	CR	687	t
722	2017-10-10 12:03:25.576982-05	CA	688	t
723	2017-10-10 12:04:29.771843-05	CA	689	t
724	2017-10-10 12:33:44.738562-05	CA	690	t
725	2017-10-10 12:38:19.933618-05	CA	691	t
726	2017-10-10 12:55:34.54632-05	CA	692	t
727	2017-10-10 12:57:47.607116-05	CA	693	t
728	2017-10-10 13:18:42.63088-05	CA	694	t
729	2017-10-11 07:51:43.184579-05	CA	695	t
730	2017-10-11 08:27:43.856055-05	CA	696	t
731	2017-10-11 09:30:56.490566-05	CA	697	t
732	2017-10-11 09:43:40.110153-05	CA	698	t
733	2017-10-11 10:24:34.997959-05	CA	699	t
734	2017-10-11 12:12:34.933066-05	CA	700	t
735	2017-10-11 12:33:01.05462-05	CA	701	t
737	2017-10-11 13:12:13.636645-05	CR	703	t
738	2018-01-13 14:03:02.746546-06	CA	704	t
739	2018-01-13 14:13:38.718656-06	CA	705	t
740	2018-01-15 18:03:51.163573-06	CA	706	t
741	2018-01-15 21:18:40.52378-06	CA	707	t
742	2018-01-16 02:44:04.187999-06	CA	708	t
\.


--
-- Name: sales_ticketbase_id_seq; Type: SEQUENCE SET; Schema: public; Owner: digimundo
--

SELECT pg_catalog.setval('sales_ticketbase_id_seq', 742, true);


--
-- Data for Name: sales_ticketextraingredient; Type: TABLE DATA; Schema: public; Owner: digimundo
--

COPY sales_ticketextraingredient (id, price, extra_ingredient_id, quantity, cartridge_ticket_detail_id) FROM stdin;
\.


--
-- Name: sales_ticketextraingredient_id_seq; Type: SEQUENCE SET; Schema: public; Owner: digimundo
--

SELECT pg_catalog.setval('sales_ticketextraingredient_id_seq', 1, false);


--
-- Data for Name: sales_ticketorder; Type: TABLE DATA; Schema: public; Owner: digimundo
--

COPY sales_ticketorder (ticket_id, customer_id) FROM stdin;
\.


--
-- Data for Name: sales_ticketpos; Type: TABLE DATA; Schema: public; Owner: digimundo
--

COPY sales_ticketpos (ticket_id, cashier_id) FROM stdin;
247	4
244	4
243	4
242	4
241	4
240	4
239	4
238	4
237	4
236	4
235	4
234	4
233	4
232	4
231	4
229	4
228	4
227	4
226	4
225	4
224	4
223	4
221	4
220	4
219	4
218	4
217	4
216	4
215	4
214	4
213	4
212	4
211	4
210	4
209	4
208	4
207	4
206	4
205	4
204	4
203	4
202	4
201	4
200	4
199	4
198	4
197	4
196	4
195	4
194	4
193	4
192	4
191	4
190	4
189	4
188	4
186	4
185	4
183	4
179	4
178	4
176	4
175	4
174	4
173	4
172	4
171	4
170	4
169	4
168	4
167	4
166	4
165	4
164	4
163	4
162	4
161	4
160	4
159	4
158	4
157	4
156	4
155	4
154	4
153	4
152	4
151	4
150	4
149	4
148	4
147	4
146	4
145	4
144	4
143	4
142	4
141	4
140	4
139	4
138	4
137	4
136	4
135	4
134	4
133	4
132	4
131	4
128	4
127	4
126	4
125	4
124	4
123	4
122	4
121	4
120	4
119	4
118	4
117	4
114	4
113	4
112	4
111	4
110	4
109	4
108	4
107	4
106	4
104	4
102	4
101	4
100	4
98	4
97	4
96	4
95	4
94	4
91	4
90	4
89	4
88	4
87	4
86	4
85	4
84	4
83	4
82	4
81	4
80	4
79	4
78	4
77	4
76	4
75	4
74	4
73	4
72	4
71	4
70	4
69	4
68	4
67	4
66	4
65	4
64	4
63	4
62	4
61	4
60	4
59	4
58	4
57	4
56	4
55	4
54	4
53	4
52	4
51	4
50	4
49	4
48	4
47	4
46	4
45	4
44	4
43	4
42	4
41	4
40	4
39	4
38	4
37	4
36	4
35	4
34	4
33	4
32	4
31	4
30	4
29	4
28	4
27	4
26	4
25	4
24	4
23	4
22	4
21	4
20	4
19	4
18	4
17	4
16	4
15	4
14	4
13	4
5	4
4	4
3	4
7	4
257	4
258	4
259	4
260	4
262	4
263	4
264	4
265	4
266	4
267	4
268	4
269	4
270	4
271	4
272	4
273	4
274	4
275	4
276	4
277	4
278	4
279	4
280	4
281	4
282	4
283	4
284	4
285	4
287	4
288	4
289	4
290	4
291	4
292	4
293	4
294	4
295	4
296	4
297	4
298	4
299	4
301	4
302	4
303	4
304	4
306	4
307	4
308	4
309	4
310	4
311	4
312	4
313	4
314	4
315	4
316	4
317	4
318	4
319	4
320	4
321	4
322	4
323	4
324	4
325	4
326	4
327	4
329	4
330	4
331	4
332	4
333	4
334	4
335	4
336	4
337	4
338	4
339	4
340	4
341	4
342	4
343	4
344	4
345	4
346	4
347	4
348	4
349	4
350	4
352	4
353	4
354	4
355	4
356	4
357	4
358	4
359	4
360	4
361	4
362	4
363	4
364	4
365	4
366	4
367	4
368	4
369	4
370	4
372	4
373	4
374	4
375	4
376	4
377	4
378	4
379	4
380	4
381	4
382	4
383	4
384	4
385	4
386	4
387	4
388	4
389	4
390	4
391	4
392	4
393	4
394	4
395	4
396	4
397	4
398	4
399	4
400	4
401	4
402	4
403	4
404	4
405	4
406	4
407	4
408	4
409	4
410	4
411	4
412	4
413	4
414	4
415	4
416	4
417	4
418	4
419	4
420	4
421	4
422	4
423	4
424	4
425	4
426	4
427	4
428	4
429	4
431	4
432	4
433	4
434	4
435	4
436	4
437	4
438	4
439	4
440	4
441	4
442	4
446	4
447	4
448	4
449	4
450	4
451	4
452	4
453	4
454	4
455	4
456	4
457	4
458	4
459	4
460	4
461	4
462	4
463	4
464	4
465	4
466	4
468	4
469	4
470	4
471	4
472	4
473	4
474	4
475	4
476	4
477	4
478	4
479	4
480	4
481	4
482	4
483	4
484	4
485	4
486	4
487	4
488	4
489	4
490	4
491	4
494	4
495	4
496	4
497	4
498	4
500	4
501	4
502	4
503	4
504	4
505	4
506	4
507	4
508	4
509	4
510	4
511	4
513	4
515	4
516	4
517	4
518	4
520	4
521	4
522	4
523	4
524	4
525	4
526	4
527	4
528	4
529	4
530	4
531	4
532	4
533	4
534	4
535	4
536	4
537	4
538	4
539	4
540	4
541	4
542	4
543	4
544	4
545	4
546	4
547	4
548	4
549	4
550	4
551	4
552	4
553	4
554	4
555	4
556	4
557	4
558	4
559	4
560	4
561	4
562	4
563	4
565	4
566	4
567	4
568	4
569	4
570	4
571	4
572	4
573	4
574	4
575	4
577	4
578	4
579	4
580	4
581	4
582	4
583	4
584	4
585	4
586	4
590	4
591	4
592	4
594	4
595	4
596	4
601	4
602	4
603	4
604	4
605	4
607	4
608	4
609	4
610	4
611	4
612	4
613	4
614	4
616	4
617	4
618	4
619	4
620	4
621	4
623	4
624	4
625	4
626	4
627	4
628	4
629	4
630	4
631	4
632	4
633	4
634	4
635	4
636	4
637	4
638	4
639	4
640	4
641	4
643	4
644	4
645	4
646	4
647	4
648	4
649	4
650	4
651	4
652	4
653	4
654	4
655	4
657	4
658	4
659	4
660	4
661	4
662	4
663	4
664	4
665	4
666	4
667	4
668	4
669	4
670	4
671	4
672	4
673	4
676	4
677	4
678	4
679	4
680	4
681	4
682	4
683	4
684	4
685	4
686	4
688	4
690	4
691	4
693	4
694	4
695	4
696	4
697	4
698	4
699	4
700	4
701	4
702	4
703	4
704	4
705	4
706	4
707	4
708	4
709	4
710	4
711	4
712	4
713	4
714	4
715	4
716	4
717	4
718	4
719	4
720	4
721	4
722	4
723	4
724	4
725	4
726	4
727	4
728	4
729	4
730	4
731	4
732	4
733	4
734	4
735	4
737	4
738	15
739	15
740	15
741	15
742	15
\.


--
-- Data for Name: users_customerprofile; Type: TABLE DATA; Schema: public; Owner: digimundo
--

COPY users_customerprofile (user_ptr_id, phone_number, address, longitude, latitude, first_dabba, "references", avatar, birthdate, gender) FROM stdin;
14	1239812938	esq A, Calle Lucas Córdoba & Julio Argentino Roca, Jesus María, Argentina	-64.09628279999998	-30.981193	t	va va va		2000-01-01	MA
\.


--
-- Data for Name: users_user; Type: TABLE DATA; Schema: public; Owner: digimundo
--

COPY users_user (id, password, last_login, is_superuser, username, first_name, last_name, email, is_staff, is_active, date_joined, coins) FROM stdin;
2	pbkdf2_sha256$36000$hM5ipu7FkOjF$WxtdFRI5EDwgdlbP1lXNdPXkrTc5ztUoJWS7HL35eTM=	2017-08-04 18:17:25.730501-05	t	tester				t	t	2017-08-04 18:15:36-05	0.0000
4	pbkdf2_sha256$36000$TvJ5VBqJiPCe$QL1GtVGyZpdeTv0s6n+Bee2rMGVW/1S6HzXg6IDK2Kk=	2017-10-03 07:20:16.547318-05	t	lucy			gerenciasat@dabbawala.com.mx	f	t	2017-08-04 18:19:21-05	0.0000
5	pbkdf2_sha256$36000$JZHzknSDCWXz$yu6o0OI/JUNDH/MidK2aZ2uAveYjyxdOF27LVqNKCCo=	\N	f	prueba			prueba@prueba.com	f	f	2017-08-04 22:08:02.584479-05	0.0000
3	pbkdf2_sha256$36000$JZHzknSDCWXz$yu6o0OI/JUNDH/MidK2aZ2uAveYjyxdOF27LVqNKCCo=	2017-08-04 22:12:25.632749-05	t	tescaceo			ceo@tescacorporation.com	f	t	2017-08-04 18:17:54-05	0.0000
10	pbkdf2_sha256$36000$6y65OFsV6J3J$qg6sXIR47+diwKnFtrCkwtysBePdcVjuSU3MlkKqbNQ=	2017-10-03 17:13:30.279213-05	f	Basilio			jonathanbasilio24@outlook.com	t	t	2017-09-28 00:31:07-05	0.0000
6	pbkdf2_sha256$36000$TovNLUZYYF09$cL7kVmFW57cwUpje2DTllT0P3BsGi2TyJHaEA+dRiAY=	2017-10-04 14:37:41.782091-05	t	ozielfuego			accounting@tescacorporation.com	f	t	2017-08-05 21:55:35-05	0.0000
8	pbkdf2_sha256$36000$UAXwGkgY5van$C8izEBDjrYr+ERrMDIk6Th0/buE15yzPHrBMzNb5YDI=	2017-10-04 22:41:19.570547-05	t	airmaster			air@tescacorporation.com	f	t	2017-08-30 11:13:58-05	0.0000
7	pbkdf2_sha256$36000$W3lGhfvj5E0h$KGj8Tx1MqxGDzW+4YTLcexzeOSwJ6yDWJFFfnxVTTT4=	\N	t	konfidence				t	t	2017-08-12 18:35:02.030706-05	0.0000
14	pbkdf2_sha256$36000$sOtUGkPhEbDp$FuSZmYDB9bzef8tCjTsfJdt9wxTlIIeh7jW2Pe8RF9M=	2017-10-07 11:06:56.783277-05	f	xdxdxd			asd@asd.com	f	t	2017-10-07 11:06:47.579028-05	0.0000
1	pbkdf2_sha256$36000$uXsG55GzalSl$BylPjdtbDC8XhMbXfkjVCJHf9gqEk+mbct2X+F4oGaM=	2017-10-08 15:43:12.682102-05	t	ramses			softwaremanager@digimundo.com.mx	t	t	2017-08-04 17:59:50.46126-05	0.0000
9	pbkdf2_sha256$36000$QOBbeqUJSpN2$bbJAApMDKyVMPY7wLt7LaO23m2Iijqige1rneqYg2LY=	\N	t	damiancruz			damiantesca@outlook.es	f	t	2017-09-04 14:12:03-05	0.0000
11	pbkdf2_sha256$36000$vI68wOpUhSYB$Ege3Fn5fc4E20KZFAE/Ca4NmKr2we5cr1Bw+TUICx/w=	\N	f	Alansatelite54			nestarosas54@gmail.com	f	t	2017-09-29 11:39:21.971151-05	0.0000
13	pbkdf2_sha256$36000$3F8rSytxUY3o$n3Eo0/hQ0UV6Ug3TRVE1PnlKyemhR0p6c7VN5T1zDRw=	\N	f	Jacquelinesatelite			jacquelineinocen9090@gmail.com	f	t	2017-09-29 11:47:47.9174-05	0.0000
12	pbkdf2_sha256$36000$RvNHEUjtqsvw$hl9HuGdRPhPgR7rbGX3ahbnJKfC2SvIpscZOw4BtBLQ=	\N	f	Marthasatelite			marthaimss2@yahoo.com.mx	f	t	2017-09-29 11:41:54.442765-05	0.0000
15	pbkdf2_sha256$100000$rNwRu9AfXXQ3$w0WUJ1dFgIGVMnYOS/f2xS0gM7LN0S5KIjH80Tv/WQE=	2018-03-05 17:39:36.651343-06	t	Rich			drdr_2@hotmail.com	t	t	2017-12-20 20:57:44.787605-06	0.0000
\.


--
-- Data for Name: users_user_groups; Type: TABLE DATA; Schema: public; Owner: digimundo
--

COPY users_user_groups (id, user_id, group_id) FROM stdin;
\.


--
-- Name: users_user_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: digimundo
--

SELECT pg_catalog.setval('users_user_groups_id_seq', 1, false);


--
-- Name: users_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: digimundo
--

SELECT pg_catalog.setval('users_user_id_seq', 15, true);


--
-- Data for Name: users_user_user_permissions; Type: TABLE DATA; Schema: public; Owner: digimundo
--

COPY users_user_user_permissions (id, user_id, permission_id) FROM stdin;
\.


--
-- Name: users_user_user_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: digimundo
--

SELECT pg_catalog.setval('users_user_user_permissions_id_seq', 1, false);


--
-- Data for Name: users_usermovements; Type: TABLE DATA; Schema: public; Owner: digimundo
--

COPY users_usermovements (id, "user", category, creation_date) FROM stdin;
1	ramses	LogIn	2017-08-04
2	lucy	LogIn	2017-08-04
3	tescaceo	LogIn	2017-08-04
4	lucy	LogIn	2017-08-05
5	lucy	LogIn	2017-08-05
6	ramses	LogIn	2017-08-05
7	ramses	LogIn	2017-08-05
8	lucy	LogIn	2017-08-19
9	lucy	LogIn	2017-08-19
10	ramses	LogIn	2017-08-21
11	ramses	LogIn	2017-08-22
12	ramses	LogIn	2017-08-29
13	lucy	LogIn	2017-08-30
14	airmaster	LogIn	2017-08-30
15	airmaster	LogIn	2017-08-30
16	airmaster	LogIn	2017-08-31
17	lucy	LogIn	2017-09-02
18	lucy	LogIn	2017-09-02
19	lucy	LogIn	2017-09-04
20	ramses	LogIn	2017-09-04
21	lucy	LogIn	2017-09-04
22	ramses	LogIn	2017-09-05
23	ozielfuego	LogIn	2017-09-09
24	airmaster	LogIn	2017-09-11
25	airmaster	LogIn	2017-09-11
26	ramses	LogIn	2017-09-11
27	ozielfuego	LogIn	2017-09-13
28	lucy	LogIn	2017-09-18
29	lucy	LogIn	2017-09-18
30	airmaster	LogIn	2017-09-18
31	ramses	LogIn	2017-09-21
32	ramses	LogIn	2017-09-23
33	ramses	LogIn	2017-09-23
34	ramses	LogIn	2017-09-23
35	ramses	LogIn	2017-09-23
36	ramses	LogIn	2017-09-23
37	ramses	LogIn	2017-09-23
38	ramses	LogIn	2017-09-25
39	lucy	LogIn	2017-09-26
40	lucy	LogIn	2017-09-26
41	ramses	LogIn	2017-09-26
42	airmaster	LogIn	2017-09-28
43	ramses	LogIn	2017-10-01
44	lucy	LogIn	2017-10-02
45	Basilio	LogIn	2017-10-02
46	Basilio	LogIn	2017-10-02
47	lucy	LogIn	2017-10-03
48	airmaster	LogIn	2017-10-03
49	Basilio	LogIn	2017-10-03
50	Basilio	LogIn	2017-10-03
51	airmaster	LogIn	2017-10-04
52	ozielfuego	LogIn	2017-10-04
53	airmaster	LogIn	2017-10-04
54	ramses	LogIn	2017-10-08
55	Rich	LogIn	2017-12-22
56	Rich	LogIn	2017-12-22
57	Rich	LogIn	2018-01-08
58	Rich	LogIn	2018-01-09
59	Rich	LogIn	2018-01-09
60	Rich	LogIn	2018-01-10
61	Rich	LogIn	2018-01-10
62	Rich	LogIn	2018-01-19
63	Rich	LogIn	2018-01-30
64	Rich	LogIn	2018-02-08
65	Rich	LogIn	2018-02-16
66	Rich	LogIn	2018-03-05
\.


--
-- Name: users_usermovements_id_seq; Type: SEQUENCE SET; Schema: public; Owner: digimundo
--

SELECT pg_catalog.setval('users_usermovements_id_seq', 66, true);


--
-- Name: auth_group auth_group_name_key; Type: CONSTRAINT; Schema: public; Owner: digimundo
--

ALTER TABLE ONLY auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);


--
-- Name: auth_group_permissions auth_group_permissions_group_id_permission_id_0cd325b0_uniq; Type: CONSTRAINT; Schema: public; Owner: digimundo
--

ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_permission_id_0cd325b0_uniq UNIQUE (group_id, permission_id);


--
-- Name: auth_group_permissions auth_group_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: digimundo
--

ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_group auth_group_pkey; Type: CONSTRAINT; Schema: public; Owner: digimundo
--

ALTER TABLE ONLY auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);


--
-- Name: auth_permission auth_permission_content_type_id_codename_01ab375a_uniq; Type: CONSTRAINT; Schema: public; Owner: digimundo
--

ALTER TABLE ONLY auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_codename_01ab375a_uniq UNIQUE (content_type_id, codename);


--
-- Name: auth_permission auth_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: digimundo
--

ALTER TABLE ONLY auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);


--
-- Name: branchoffices_branchoffice branchoffices_branchoffice_pkey; Type: CONSTRAINT; Schema: public; Owner: digimundo
--

ALTER TABLE ONLY branchoffices_branchoffice
    ADD CONSTRAINT branchoffices_branchoffice_pkey PRIMARY KEY (id);


--
-- Name: branchoffices_supplier branchoffices_supplier_name_key; Type: CONSTRAINT; Schema: public; Owner: digimundo
--

ALTER TABLE ONLY branchoffices_supplier
    ADD CONSTRAINT branchoffices_supplier_name_key UNIQUE (name);


--
-- Name: branchoffices_supplier branchoffices_supplier_pkey; Type: CONSTRAINT; Schema: public; Owner: digimundo
--

ALTER TABLE ONLY branchoffices_supplier
    ADD CONSTRAINT branchoffices_supplier_pkey PRIMARY KEY (id);


--
-- Name: diners_accesslog diners_accesslog_pkey; Type: CONSTRAINT; Schema: public; Owner: digimundo
--

ALTER TABLE ONLY diners_accesslog
    ADD CONSTRAINT diners_accesslog_pkey PRIMARY KEY (id);


--
-- Name: diners_diner diners_diner_pkey; Type: CONSTRAINT; Schema: public; Owner: digimundo
--

ALTER TABLE ONLY diners_diner
    ADD CONSTRAINT diners_diner_pkey PRIMARY KEY (id);


--
-- Name: diners_elementtoevaluate diners_elementtoevaluate_element_key; Type: CONSTRAINT; Schema: public; Owner: digimundo
--

ALTER TABLE ONLY diners_elementtoevaluate
    ADD CONSTRAINT diners_elementtoevaluate_element_key UNIQUE (element);


--
-- Name: diners_elementtoevaluate diners_elementtoevaluate_pkey; Type: CONSTRAINT; Schema: public; Owner: digimundo
--

ALTER TABLE ONLY diners_elementtoevaluate
    ADD CONSTRAINT diners_elementtoevaluate_pkey PRIMARY KEY (id);


--
-- Name: diners_satisfactionrating_elements diners_satisfactionratin_satisfactionrating_id_el_5cf55334_uniq; Type: CONSTRAINT; Schema: public; Owner: digimundo
--

ALTER TABLE ONLY diners_satisfactionrating_elements
    ADD CONSTRAINT diners_satisfactionratin_satisfactionrating_id_el_5cf55334_uniq UNIQUE (satisfactionrating_id, elementtoevaluate_id);


--
-- Name: diners_satisfactionrating_elements diners_satisfactionrating_elements_pkey; Type: CONSTRAINT; Schema: public; Owner: digimundo
--

ALTER TABLE ONLY diners_satisfactionrating_elements
    ADD CONSTRAINT diners_satisfactionrating_elements_pkey PRIMARY KEY (id);


--
-- Name: diners_satisfactionrating diners_satisfactionrating_pkey; Type: CONSTRAINT; Schema: public; Owner: digimundo
--

ALTER TABLE ONLY diners_satisfactionrating
    ADD CONSTRAINT diners_satisfactionrating_pkey PRIMARY KEY (id);


--
-- Name: django_admin_log django_admin_log_pkey; Type: CONSTRAINT; Schema: public; Owner: digimundo
--

ALTER TABLE ONLY django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);


--
-- Name: django_content_type django_content_type_app_label_model_76bd3d3b_uniq; Type: CONSTRAINT; Schema: public; Owner: digimundo
--

ALTER TABLE ONLY django_content_type
    ADD CONSTRAINT django_content_type_app_label_model_76bd3d3b_uniq UNIQUE (app_label, model);


--
-- Name: django_content_type django_content_type_pkey; Type: CONSTRAINT; Schema: public; Owner: digimundo
--

ALTER TABLE ONLY django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);


--
-- Name: django_migrations django_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: digimundo
--

ALTER TABLE ONLY django_migrations
    ADD CONSTRAINT django_migrations_pkey PRIMARY KEY (id);


--
-- Name: django_session django_session_pkey; Type: CONSTRAINT; Schema: public; Owner: digimundo
--

ALTER TABLE ONLY django_session
    ADD CONSTRAINT django_session_pkey PRIMARY KEY (session_key);


--
-- Name: django_site django_site_domain_a2e37b91_uniq; Type: CONSTRAINT; Schema: public; Owner: digimundo
--

ALTER TABLE ONLY django_site
    ADD CONSTRAINT django_site_domain_a2e37b91_uniq UNIQUE (domain);


--
-- Name: django_site django_site_pkey; Type: CONSTRAINT; Schema: public; Owner: digimundo
--

ALTER TABLE ONLY django_site
    ADD CONSTRAINT django_site_pkey PRIMARY KEY (id);


--
-- Name: fcm_device fcm_device_dev_id_key; Type: CONSTRAINT; Schema: public; Owner: digimundo
--

ALTER TABLE ONLY fcm_device
    ADD CONSTRAINT fcm_device_dev_id_key UNIQUE (dev_id);


--
-- Name: fcm_device fcm_device_pkey; Type: CONSTRAINT; Schema: public; Owner: digimundo
--

ALTER TABLE ONLY fcm_device
    ADD CONSTRAINT fcm_device_pkey PRIMARY KEY (id);


--
-- Name: fcm_device fcm_device_reg_id_key; Type: CONSTRAINT; Schema: public; Owner: digimundo
--

ALTER TABLE ONLY fcm_device
    ADD CONSTRAINT fcm_device_reg_id_key UNIQUE (reg_id);


--
-- Name: jet_bookmark jet_bookmark_pkey; Type: CONSTRAINT; Schema: public; Owner: digimundo
--

ALTER TABLE ONLY jet_bookmark
    ADD CONSTRAINT jet_bookmark_pkey PRIMARY KEY (id);


--
-- Name: jet_pinnedapplication jet_pinnedapplication_pkey; Type: CONSTRAINT; Schema: public; Owner: digimundo
--

ALTER TABLE ONLY jet_pinnedapplication
    ADD CONSTRAINT jet_pinnedapplication_pkey PRIMARY KEY (id);


--
-- Name: kitchen_processedproduct kitchen_processedproduct_pkey; Type: CONSTRAINT; Schema: public; Owner: digimundo
--

ALTER TABLE ONLY kitchen_processedproduct
    ADD CONSTRAINT kitchen_processedproduct_pkey PRIMARY KEY (id);


--
-- Name: kitchen_processedproduct kitchen_processedproduct_ticket_id_key; Type: CONSTRAINT; Schema: public; Owner: digimundo
--

ALTER TABLE ONLY kitchen_processedproduct
    ADD CONSTRAINT kitchen_processedproduct_ticket_id_key UNIQUE (ticket_id);


--
-- Name: orders_customerorder orders_customerorder_pkey; Type: CONSTRAINT; Schema: public; Owner: digimundo
--

ALTER TABLE ONLY orders_customerorder
    ADD CONSTRAINT orders_customerorder_pkey PRIMARY KEY (id);


--
-- Name: orders_customerorderdetail orders_customerorderdetail_pkey; Type: CONSTRAINT; Schema: public; Owner: digimundo
--

ALTER TABLE ONLY orders_customerorderdetail
    ADD CONSTRAINT orders_customerorderdetail_pkey PRIMARY KEY (id);


--
-- Name: orders_supplierorder orders_supplierorder_pkey; Type: CONSTRAINT; Schema: public; Owner: digimundo
--

ALTER TABLE ONLY orders_supplierorder
    ADD CONSTRAINT orders_supplierorder_pkey PRIMARY KEY (id);


--
-- Name: orders_supplierorderdetail orders_supplierorderdetail_pkey; Type: CONSTRAINT; Schema: public; Owner: digimundo
--

ALTER TABLE ONLY orders_supplierorderdetail
    ADD CONSTRAINT orders_supplierorderdetail_pkey PRIMARY KEY (id);


--
-- Name: products_brand products_brand_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY products_brand
    ADD CONSTRAINT products_brand_pkey PRIMARY KEY (id);


--
-- Name: products_cartridge products_cartridge_pkey; Type: CONSTRAINT; Schema: public; Owner: digimundo
--

ALTER TABLE ONLY products_cartridge
    ADD CONSTRAINT products_cartridge_pkey PRIMARY KEY (id);


--
-- Name: products_cartridgerecipe products_cartridgerecipe_pkey; Type: CONSTRAINT; Schema: public; Owner: digimundo
--

ALTER TABLE ONLY products_cartridgerecipe
    ADD CONSTRAINT products_cartridgerecipe_pkey PRIMARY KEY (id);


--
-- Name: products_extraingredient products_extraingredient_pkey; Type: CONSTRAINT; Schema: public; Owner: digimundo
--

ALTER TABLE ONLY products_extraingredient
    ADD CONSTRAINT products_extraingredient_pkey PRIMARY KEY (id);


--
-- Name: products_kitchenassembly products_kitchenassembly_pkey; Type: CONSTRAINT; Schema: public; Owner: digimundo
--

ALTER TABLE ONLY products_kitchenassembly
    ADD CONSTRAINT products_kitchenassembly_pkey PRIMARY KEY (id);


--
-- Name: products_packagecartridge products_packagecartridge_pkey; Type: CONSTRAINT; Schema: public; Owner: digimundo
--

ALTER TABLE ONLY products_packagecartridge
    ADD CONSTRAINT products_packagecartridge_pkey PRIMARY KEY (id);


--
-- Name: products_packagecartridgerecipe products_packagecartridgerecipe_pkey; Type: CONSTRAINT; Schema: public; Owner: digimundo
--

ALTER TABLE ONLY products_packagecartridgerecipe
    ADD CONSTRAINT products_packagecartridgerecipe_pkey PRIMARY KEY (id);


--
-- Name: products_presentation products_presentation_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY products_presentation
    ADD CONSTRAINT products_presentation_pkey PRIMARY KEY (id);


--
-- Name: products_shoplist products_shoplist_pkey; Type: CONSTRAINT; Schema: public; Owner: digimundo
--

ALTER TABLE ONLY products_shoplist
    ADD CONSTRAINT products_shoplist_pkey PRIMARY KEY (id);


--
-- Name: products_shoplistdetail products_shoplistdetail_pkey; Type: CONSTRAINT; Schema: public; Owner: digimundo
--

ALTER TABLE ONLY products_shoplistdetail
    ADD CONSTRAINT products_shoplistdetail_pkey PRIMARY KEY (id);


--
-- Name: products_suppliescategory products_suppliescategory_name_key; Type: CONSTRAINT; Schema: public; Owner: digimundo
--

ALTER TABLE ONLY products_suppliescategory
    ADD CONSTRAINT products_suppliescategory_name_key UNIQUE (name);


--
-- Name: products_suppliescategory products_suppliescategory_pkey; Type: CONSTRAINT; Schema: public; Owner: digimundo
--

ALTER TABLE ONLY products_suppliescategory
    ADD CONSTRAINT products_suppliescategory_pkey PRIMARY KEY (id);


--
-- Name: products_supply products_supply_name_key; Type: CONSTRAINT; Schema: public; Owner: digimundo
--

ALTER TABLE ONLY products_supply
    ADD CONSTRAINT products_supply_name_key UNIQUE (name);


--
-- Name: products_supply products_supply_pkey; Type: CONSTRAINT; Schema: public; Owner: digimundo
--

ALTER TABLE ONLY products_supply
    ADD CONSTRAINT products_supply_pkey PRIMARY KEY (id);


--
-- Name: products_supplylocation products_supplylocation_pkey; Type: CONSTRAINT; Schema: public; Owner: digimundo
--

ALTER TABLE ONLY products_supplylocation
    ADD CONSTRAINT products_supplylocation_pkey PRIMARY KEY (id);


--
-- Name: sales_cartridgeticketdetail sales_cartridgeticketdetail_pkey; Type: CONSTRAINT; Schema: public; Owner: digimundo
--

ALTER TABLE ONLY sales_cartridgeticketdetail
    ADD CONSTRAINT sales_cartridgeticketdetail_pkey PRIMARY KEY (id);


--
-- Name: sales_packagecartridgeticketdetail sales_packagecartridgeticketdetail_pkey; Type: CONSTRAINT; Schema: public; Owner: digimundo
--

ALTER TABLE ONLY sales_packagecartridgeticketdetail
    ADD CONSTRAINT sales_packagecartridgeticketdetail_pkey PRIMARY KEY (id);


--
-- Name: sales_ticketbase sales_ticketbase_pkey; Type: CONSTRAINT; Schema: public; Owner: digimundo
--

ALTER TABLE ONLY sales_ticketbase
    ADD CONSTRAINT sales_ticketbase_pkey PRIMARY KEY (id);


--
-- Name: sales_ticketextraingredient sales_ticketextraingredient_pkey; Type: CONSTRAINT; Schema: public; Owner: digimundo
--

ALTER TABLE ONLY sales_ticketextraingredient
    ADD CONSTRAINT sales_ticketextraingredient_pkey PRIMARY KEY (id);


--
-- Name: sales_ticketorder sales_ticketorder_customer_id_key; Type: CONSTRAINT; Schema: public; Owner: digimundo
--

ALTER TABLE ONLY sales_ticketorder
    ADD CONSTRAINT sales_ticketorder_customer_id_key UNIQUE (customer_id);


--
-- Name: sales_ticketorder sales_ticketorder_pkey; Type: CONSTRAINT; Schema: public; Owner: digimundo
--

ALTER TABLE ONLY sales_ticketorder
    ADD CONSTRAINT sales_ticketorder_pkey PRIMARY KEY (ticket_id);


--
-- Name: sales_ticketpos sales_ticketpos_pkey; Type: CONSTRAINT; Schema: public; Owner: digimundo
--

ALTER TABLE ONLY sales_ticketpos
    ADD CONSTRAINT sales_ticketpos_pkey PRIMARY KEY (ticket_id);


--
-- Name: users_customerprofile users_customerprofile_pkey; Type: CONSTRAINT; Schema: public; Owner: digimundo
--

ALTER TABLE ONLY users_customerprofile
    ADD CONSTRAINT users_customerprofile_pkey PRIMARY KEY (user_ptr_id);


--
-- Name: users_user_groups users_user_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: digimundo
--

ALTER TABLE ONLY users_user_groups
    ADD CONSTRAINT users_user_groups_pkey PRIMARY KEY (id);


--
-- Name: users_user_groups users_user_groups_user_id_group_id_b88eab82_uniq; Type: CONSTRAINT; Schema: public; Owner: digimundo
--

ALTER TABLE ONLY users_user_groups
    ADD CONSTRAINT users_user_groups_user_id_group_id_b88eab82_uniq UNIQUE (user_id, group_id);


--
-- Name: users_user users_user_pkey; Type: CONSTRAINT; Schema: public; Owner: digimundo
--

ALTER TABLE ONLY users_user
    ADD CONSTRAINT users_user_pkey PRIMARY KEY (id);


--
-- Name: users_user_user_permissions users_user_user_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: digimundo
--

ALTER TABLE ONLY users_user_user_permissions
    ADD CONSTRAINT users_user_user_permissions_pkey PRIMARY KEY (id);


--
-- Name: users_user_user_permissions users_user_user_permissions_user_id_permission_id_43338c45_uniq; Type: CONSTRAINT; Schema: public; Owner: digimundo
--

ALTER TABLE ONLY users_user_user_permissions
    ADD CONSTRAINT users_user_user_permissions_user_id_permission_id_43338c45_uniq UNIQUE (user_id, permission_id);


--
-- Name: users_user users_user_username_key; Type: CONSTRAINT; Schema: public; Owner: digimundo
--

ALTER TABLE ONLY users_user
    ADD CONSTRAINT users_user_username_key UNIQUE (username);


--
-- Name: users_usermovements users_usermovements_pkey; Type: CONSTRAINT; Schema: public; Owner: digimundo
--

ALTER TABLE ONLY users_usermovements
    ADD CONSTRAINT users_usermovements_pkey PRIMARY KEY (id);


--
-- Name: auth_group_name_a6ea08ec_like; Type: INDEX; Schema: public; Owner: digimundo
--

CREATE INDEX auth_group_name_a6ea08ec_like ON auth_group USING btree (name varchar_pattern_ops);


--
-- Name: auth_group_permissions_group_id_b120cbf9; Type: INDEX; Schema: public; Owner: digimundo
--

CREATE INDEX auth_group_permissions_group_id_b120cbf9 ON auth_group_permissions USING btree (group_id);


--
-- Name: auth_group_permissions_permission_id_84c5c92e; Type: INDEX; Schema: public; Owner: digimundo
--

CREATE INDEX auth_group_permissions_permission_id_84c5c92e ON auth_group_permissions USING btree (permission_id);


--
-- Name: auth_permission_content_type_id_2f476e4b; Type: INDEX; Schema: public; Owner: digimundo
--

CREATE INDEX auth_permission_content_type_id_2f476e4b ON auth_permission USING btree (content_type_id);


--
-- Name: branchoffices_branchoffice_manager_id_13fccd53; Type: INDEX; Schema: public; Owner: digimundo
--

CREATE INDEX branchoffices_branchoffice_manager_id_13fccd53 ON branchoffices_branchoffice USING btree (manager_id);


--
-- Name: branchoffices_supplier_name_d926e0d9_like; Type: INDEX; Schema: public; Owner: digimundo
--

CREATE INDEX branchoffices_supplier_name_d926e0d9_like ON branchoffices_supplier USING btree (name varchar_pattern_ops);


--
-- Name: diners_accesslog_diner_id_311e8987; Type: INDEX; Schema: public; Owner: digimundo
--

CREATE INDEX diners_accesslog_diner_id_311e8987 ON diners_accesslog USING btree (diner_id);


--
-- Name: diners_elementtoevaluate_element_2e58286b_like; Type: INDEX; Schema: public; Owner: digimundo
--

CREATE INDEX diners_elementtoevaluate_element_2e58286b_like ON diners_elementtoevaluate USING btree (element varchar_pattern_ops);


--
-- Name: diners_satisfactionrating__elementtoevaluate_id_d77845c0; Type: INDEX; Schema: public; Owner: digimundo
--

CREATE INDEX diners_satisfactionrating__elementtoevaluate_id_d77845c0 ON diners_satisfactionrating_elements USING btree (elementtoevaluate_id);


--
-- Name: diners_satisfactionrating__satisfactionrating_id_203ae167; Type: INDEX; Schema: public; Owner: digimundo
--

CREATE INDEX diners_satisfactionrating__satisfactionrating_id_203ae167 ON diners_satisfactionrating_elements USING btree (satisfactionrating_id);


--
-- Name: django_admin_log_content_type_id_c4bce8eb; Type: INDEX; Schema: public; Owner: digimundo
--

CREATE INDEX django_admin_log_content_type_id_c4bce8eb ON django_admin_log USING btree (content_type_id);


--
-- Name: django_admin_log_user_id_c564eba6; Type: INDEX; Schema: public; Owner: digimundo
--

CREATE INDEX django_admin_log_user_id_c564eba6 ON django_admin_log USING btree (user_id);


--
-- Name: django_session_expire_date_a5c62663; Type: INDEX; Schema: public; Owner: digimundo
--

CREATE INDEX django_session_expire_date_a5c62663 ON django_session USING btree (expire_date);


--
-- Name: django_session_session_key_c0390e0f_like; Type: INDEX; Schema: public; Owner: digimundo
--

CREATE INDEX django_session_session_key_c0390e0f_like ON django_session USING btree (session_key varchar_pattern_ops);


--
-- Name: django_site_domain_a2e37b91_like; Type: INDEX; Schema: public; Owner: digimundo
--

CREATE INDEX django_site_domain_a2e37b91_like ON django_site USING btree (domain varchar_pattern_ops);


--
-- Name: fcm_device_dev_id_5238dfc7_like; Type: INDEX; Schema: public; Owner: digimundo
--

CREATE INDEX fcm_device_dev_id_5238dfc7_like ON fcm_device USING btree (dev_id varchar_pattern_ops);


--
-- Name: fcm_device_reg_id_5d43d2cc_like; Type: INDEX; Schema: public; Owner: digimundo
--

CREATE INDEX fcm_device_reg_id_5d43d2cc_like ON fcm_device USING btree (reg_id varchar_pattern_ops);


--
-- Name: orders_customerorder_customer_user_id_91b0073d; Type: INDEX; Schema: public; Owner: digimundo
--

CREATE INDEX orders_customerorder_customer_user_id_91b0073d ON orders_customerorder USING btree (customer_user_id);


--
-- Name: orders_customerorderdetail_cartridge_id_da7fb1db; Type: INDEX; Schema: public; Owner: digimundo
--

CREATE INDEX orders_customerorderdetail_cartridge_id_da7fb1db ON orders_customerorderdetail USING btree (cartridge_id);


--
-- Name: orders_customerorderdetail_customer_order_id_604ce78c; Type: INDEX; Schema: public; Owner: digimundo
--

CREATE INDEX orders_customerorderdetail_customer_order_id_604ce78c ON orders_customerorderdetail USING btree (customer_order_id);


--
-- Name: orders_customerorderdetail_package_cartridge_id_83ff6b12; Type: INDEX; Schema: public; Owner: digimundo
--

CREATE INDEX orders_customerorderdetail_package_cartridge_id_83ff6b12 ON orders_customerorderdetail USING btree (package_cartridge_id);


--
-- Name: orders_supplierorder_assigned_dealer_id_7143af1c; Type: INDEX; Schema: public; Owner: digimundo
--

CREATE INDEX orders_supplierorder_assigned_dealer_id_7143af1c ON orders_supplierorder USING btree (assigned_dealer_id);


--
-- Name: orders_supplierorderdetail_order_id_91e5151b; Type: INDEX; Schema: public; Owner: digimundo
--

CREATE INDEX orders_supplierorderdetail_order_id_91e5151b ON orders_supplierorderdetail USING btree (order_id);


--
-- Name: orders_supplierorderdetail_supplier_id_1b4d1606; Type: INDEX; Schema: public; Owner: digimundo
--

CREATE INDEX orders_supplierorderdetail_supplier_id_1b4d1606 ON orders_supplierorderdetail USING btree (supplier_id);


--
-- Name: orders_supplierorderdetail_supply_id_318d14f7; Type: INDEX; Schema: public; Owner: digimundo
--

CREATE INDEX orders_supplierorderdetail_supply_id_318d14f7 ON orders_supplierorderdetail USING btree (supply_id);


--
-- Name: products_cartridge_kitchen_assembly_id_526f07be; Type: INDEX; Schema: public; Owner: digimundo
--

CREATE INDEX products_cartridge_kitchen_assembly_id_526f07be ON products_cartridge USING btree (kitchen_assembly_id);


--
-- Name: products_cartridgerecipe_cartridge_id_6f88cdb5; Type: INDEX; Schema: public; Owner: digimundo
--

CREATE INDEX products_cartridgerecipe_cartridge_id_6f88cdb5 ON products_cartridgerecipe USING btree (cartridge_id);


--
-- Name: products_cartridgerecipe_supply_id_b129b13d; Type: INDEX; Schema: public; Owner: digimundo
--

CREATE INDEX products_cartridgerecipe_supply_id_b129b13d ON products_cartridgerecipe USING btree (supply_id);


--
-- Name: products_extraingredient_ingredient_id_b6dc4839; Type: INDEX; Schema: public; Owner: digimundo
--

CREATE INDEX products_extraingredient_ingredient_id_b6dc4839 ON products_extraingredient USING btree (ingredient_id);


--
-- Name: products_packagecartridgerecipe_cartridge_id_86cf7c31; Type: INDEX; Schema: public; Owner: digimundo
--

CREATE INDEX products_packagecartridgerecipe_cartridge_id_86cf7c31 ON products_packagecartridgerecipe USING btree (cartridge_id);


--
-- Name: products_packagecartridgerecipe_package_cartridge_id_3267b9b6; Type: INDEX; Schema: public; Owner: digimundo
--

CREATE INDEX products_packagecartridgerecipe_package_cartridge_id_3267b9b6 ON products_packagecartridgerecipe USING btree (package_cartridge_id);


--
-- Name: products_presentation_supply_id_6aa845eb; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX products_presentation_supply_id_6aa845eb ON products_presentation USING btree (supply_id);


--
-- Name: products_shoplistdetail_presentation_id_d82372ee; Type: INDEX; Schema: public; Owner: digimundo
--

CREATE INDEX products_shoplistdetail_presentation_id_d82372ee ON products_shoplistdetail USING btree (presentation_id);


--
-- Name: products_shoplistdetail_shop_list_id_a5f46e1b; Type: INDEX; Schema: public; Owner: digimundo
--

CREATE INDEX products_shoplistdetail_shop_list_id_a5f46e1b ON products_shoplistdetail USING btree (shop_list_id);


--
-- Name: products_suppliescategory_name_24c8c3db_like; Type: INDEX; Schema: public; Owner: digimundo
--

CREATE INDEX products_suppliescategory_name_24c8c3db_like ON products_suppliescategory USING btree (name varchar_pattern_ops);


--
-- Name: products_supply_category_id_dcaee927; Type: INDEX; Schema: public; Owner: digimundo
--

CREATE INDEX products_supply_category_id_dcaee927 ON products_supply USING btree (category_id);


--
-- Name: products_supply_location_id_4661cab0; Type: INDEX; Schema: public; Owner: digimundo
--

CREATE INDEX products_supply_location_id_4661cab0 ON products_supply USING btree (location_id);


--
-- Name: products_supply_name_ca0d26a6_like; Type: INDEX; Schema: public; Owner: digimundo
--

CREATE INDEX products_supply_name_ca0d26a6_like ON products_supply USING btree (name varchar_pattern_ops);


--
-- Name: products_supply_supplier_id_4cda4618; Type: INDEX; Schema: public; Owner: digimundo
--

CREATE INDEX products_supply_supplier_id_4cda4618 ON products_supply USING btree (supplier_id);


--
-- Name: products_supplylocation_branch_office_id_d4db03ed; Type: INDEX; Schema: public; Owner: digimundo
--

CREATE INDEX products_supplylocation_branch_office_id_d4db03ed ON products_supplylocation USING btree (branch_office_id);


--
-- Name: sales_cartridgeticketdetail_cartridge_id_f1af2ee6; Type: INDEX; Schema: public; Owner: digimundo
--

CREATE INDEX sales_cartridgeticketdetail_cartridge_id_f1af2ee6 ON sales_cartridgeticketdetail USING btree (cartridge_id);


--
-- Name: sales_cartridgeticketdetail_ticket_base_id_4b404df2; Type: INDEX; Schema: public; Owner: digimundo
--

CREATE INDEX sales_cartridgeticketdetail_ticket_base_id_4b404df2 ON sales_cartridgeticketdetail USING btree (ticket_base_id);


--
-- Name: sales_packagecartridgetick_package_cartridge_id_f7a34a2c; Type: INDEX; Schema: public; Owner: digimundo
--

CREATE INDEX sales_packagecartridgetick_package_cartridge_id_f7a34a2c ON sales_packagecartridgeticketdetail USING btree (package_cartridge_id);


--
-- Name: sales_packagecartridgeticketdetail_ticket_base_id_78714a0f; Type: INDEX; Schema: public; Owner: digimundo
--

CREATE INDEX sales_packagecartridgeticketdetail_ticket_base_id_78714a0f ON sales_packagecartridgeticketdetail USING btree (ticket_base_id);


--
-- Name: sales_ticketextraingredient_cartridge_ticket_detail_id_702795e0; Type: INDEX; Schema: public; Owner: digimundo
--

CREATE INDEX sales_ticketextraingredient_cartridge_ticket_detail_id_702795e0 ON sales_ticketextraingredient USING btree (cartridge_ticket_detail_id);


--
-- Name: sales_ticketextraingredient_extra_ingredient_id_00f115e6; Type: INDEX; Schema: public; Owner: digimundo
--

CREATE INDEX sales_ticketextraingredient_extra_ingredient_id_00f115e6 ON sales_ticketextraingredient USING btree (extra_ingredient_id);


--
-- Name: sales_ticketpos_cashier_id_7ceac597; Type: INDEX; Schema: public; Owner: digimundo
--

CREATE INDEX sales_ticketpos_cashier_id_7ceac597 ON sales_ticketpos USING btree (cashier_id);


--
-- Name: users_user_groups_group_id_9afc8d0e; Type: INDEX; Schema: public; Owner: digimundo
--

CREATE INDEX users_user_groups_group_id_9afc8d0e ON users_user_groups USING btree (group_id);


--
-- Name: users_user_groups_user_id_5f6f5a90; Type: INDEX; Schema: public; Owner: digimundo
--

CREATE INDEX users_user_groups_user_id_5f6f5a90 ON users_user_groups USING btree (user_id);


--
-- Name: users_user_user_permissions_permission_id_0b93982e; Type: INDEX; Schema: public; Owner: digimundo
--

CREATE INDEX users_user_user_permissions_permission_id_0b93982e ON users_user_user_permissions USING btree (permission_id);


--
-- Name: users_user_user_permissions_user_id_20aca447; Type: INDEX; Schema: public; Owner: digimundo
--

CREATE INDEX users_user_user_permissions_user_id_20aca447 ON users_user_user_permissions USING btree (user_id);


--
-- Name: users_user_username_06e46fe6_like; Type: INDEX; Schema: public; Owner: digimundo
--

CREATE INDEX users_user_username_06e46fe6_like ON users_user USING btree (username varchar_pattern_ops);


--
-- Name: auth_group_permissions auth_group_permissio_permission_id_84c5c92e_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: digimundo
--

ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT auth_group_permissio_permission_id_84c5c92e_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions auth_group_permissions_group_id_b120cbf9_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: digimundo
--

ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_b120cbf9_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_permission auth_permission_content_type_id_2f476e4b_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: digimundo
--

ALTER TABLE ONLY auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_2f476e4b_fk_django_co FOREIGN KEY (content_type_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: branchoffices_branchoffice branchoffices_branchoffice_manager_id_13fccd53_fk_users_user_id; Type: FK CONSTRAINT; Schema: public; Owner: digimundo
--

ALTER TABLE ONLY branchoffices_branchoffice
    ADD CONSTRAINT branchoffices_branchoffice_manager_id_13fccd53_fk_users_user_id FOREIGN KEY (manager_id) REFERENCES users_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: diners_accesslog diners_accesslog_diner_id_311e8987_fk_diners_diner_id; Type: FK CONSTRAINT; Schema: public; Owner: digimundo
--

ALTER TABLE ONLY diners_accesslog
    ADD CONSTRAINT diners_accesslog_diner_id_311e8987_fk_diners_diner_id FOREIGN KEY (diner_id) REFERENCES diners_diner(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: diners_satisfactionrating_elements diners_satisfactionr_elementtoevaluate_id_d77845c0_fk_diners_el; Type: FK CONSTRAINT; Schema: public; Owner: digimundo
--

ALTER TABLE ONLY diners_satisfactionrating_elements
    ADD CONSTRAINT diners_satisfactionr_elementtoevaluate_id_d77845c0_fk_diners_el FOREIGN KEY (elementtoevaluate_id) REFERENCES diners_elementtoevaluate(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: diners_satisfactionrating_elements diners_satisfactionr_satisfactionrating_i_203ae167_fk_diners_sa; Type: FK CONSTRAINT; Schema: public; Owner: digimundo
--

ALTER TABLE ONLY diners_satisfactionrating_elements
    ADD CONSTRAINT diners_satisfactionr_satisfactionrating_i_203ae167_fk_diners_sa FOREIGN KEY (satisfactionrating_id) REFERENCES diners_satisfactionrating(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_content_type_id_c4bce8eb_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: digimundo
--

ALTER TABLE ONLY django_admin_log
    ADD CONSTRAINT django_admin_log_content_type_id_c4bce8eb_fk_django_co FOREIGN KEY (content_type_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_user_id_c564eba6_fk_users_user_id; Type: FK CONSTRAINT; Schema: public; Owner: digimundo
--

ALTER TABLE ONLY django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_c564eba6_fk_users_user_id FOREIGN KEY (user_id) REFERENCES users_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: kitchen_processedproduct kitchen_processedpro_ticket_id_cab45ee1_fk_sales_tic; Type: FK CONSTRAINT; Schema: public; Owner: digimundo
--

ALTER TABLE ONLY kitchen_processedproduct
    ADD CONSTRAINT kitchen_processedpro_ticket_id_cab45ee1_fk_sales_tic FOREIGN KEY (ticket_id) REFERENCES sales_ticketbase(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: orders_customerorderdetail orders_customerorder_cartridge_id_da7fb1db_fk_products_; Type: FK CONSTRAINT; Schema: public; Owner: digimundo
--

ALTER TABLE ONLY orders_customerorderdetail
    ADD CONSTRAINT orders_customerorder_cartridge_id_da7fb1db_fk_products_ FOREIGN KEY (cartridge_id) REFERENCES products_cartridge(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: orders_customerorderdetail orders_customerorder_customer_order_id_604ce78c_fk_orders_cu; Type: FK CONSTRAINT; Schema: public; Owner: digimundo
--

ALTER TABLE ONLY orders_customerorderdetail
    ADD CONSTRAINT orders_customerorder_customer_order_id_604ce78c_fk_orders_cu FOREIGN KEY (customer_order_id) REFERENCES orders_customerorder(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: orders_customerorder orders_customerorder_customer_user_id_91b0073d_fk_users_user_id; Type: FK CONSTRAINT; Schema: public; Owner: digimundo
--

ALTER TABLE ONLY orders_customerorder
    ADD CONSTRAINT orders_customerorder_customer_user_id_91b0073d_fk_users_user_id FOREIGN KEY (customer_user_id) REFERENCES users_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: orders_customerorderdetail orders_customerorder_package_cartridge_id_83ff6b12_fk_products_; Type: FK CONSTRAINT; Schema: public; Owner: digimundo
--

ALTER TABLE ONLY orders_customerorderdetail
    ADD CONSTRAINT orders_customerorder_package_cartridge_id_83ff6b12_fk_products_ FOREIGN KEY (package_cartridge_id) REFERENCES products_packagecartridge(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: orders_supplierorder orders_supplierorder_assigned_dealer_id_7143af1c_fk_users_use; Type: FK CONSTRAINT; Schema: public; Owner: digimundo
--

ALTER TABLE ONLY orders_supplierorder
    ADD CONSTRAINT orders_supplierorder_assigned_dealer_id_7143af1c_fk_users_use FOREIGN KEY (assigned_dealer_id) REFERENCES users_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: orders_supplierorderdetail orders_supplierorder_order_id_91e5151b_fk_orders_su; Type: FK CONSTRAINT; Schema: public; Owner: digimundo
--

ALTER TABLE ONLY orders_supplierorderdetail
    ADD CONSTRAINT orders_supplierorder_order_id_91e5151b_fk_orders_su FOREIGN KEY (order_id) REFERENCES orders_supplierorder(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: orders_supplierorderdetail orders_supplierorder_supplier_id_1b4d1606_fk_branchoff; Type: FK CONSTRAINT; Schema: public; Owner: digimundo
--

ALTER TABLE ONLY orders_supplierorderdetail
    ADD CONSTRAINT orders_supplierorder_supplier_id_1b4d1606_fk_branchoff FOREIGN KEY (supplier_id) REFERENCES branchoffices_supplier(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: orders_supplierorderdetail orders_supplierorder_supply_id_318d14f7_fk_products_; Type: FK CONSTRAINT; Schema: public; Owner: digimundo
--

ALTER TABLE ONLY orders_supplierorderdetail
    ADD CONSTRAINT orders_supplierorder_supply_id_318d14f7_fk_products_ FOREIGN KEY (supply_id) REFERENCES products_supply(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: products_cartridge products_cartridge_kitchen_assembly_id_526f07be_fk_products_; Type: FK CONSTRAINT; Schema: public; Owner: digimundo
--

ALTER TABLE ONLY products_cartridge
    ADD CONSTRAINT products_cartridge_kitchen_assembly_id_526f07be_fk_products_ FOREIGN KEY (kitchen_assembly_id) REFERENCES products_kitchenassembly(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: products_cartridgerecipe products_cartridgere_cartridge_id_6f88cdb5_fk_products_; Type: FK CONSTRAINT; Schema: public; Owner: digimundo
--

ALTER TABLE ONLY products_cartridgerecipe
    ADD CONSTRAINT products_cartridgere_cartridge_id_6f88cdb5_fk_products_ FOREIGN KEY (cartridge_id) REFERENCES products_cartridge(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: products_cartridgerecipe products_cartridgere_supply_id_b129b13d_fk_products_; Type: FK CONSTRAINT; Schema: public; Owner: digimundo
--

ALTER TABLE ONLY products_cartridgerecipe
    ADD CONSTRAINT products_cartridgere_supply_id_b129b13d_fk_products_ FOREIGN KEY (supply_id) REFERENCES products_supply(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: products_extraingredient products_extraingred_ingredient_id_b6dc4839_fk_products_; Type: FK CONSTRAINT; Schema: public; Owner: digimundo
--

ALTER TABLE ONLY products_extraingredient
    ADD CONSTRAINT products_extraingred_ingredient_id_b6dc4839_fk_products_ FOREIGN KEY (ingredient_id) REFERENCES products_cartridge(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: products_packagecartridgerecipe products_packagecart_cartridge_id_86cf7c31_fk_products_; Type: FK CONSTRAINT; Schema: public; Owner: digimundo
--

ALTER TABLE ONLY products_packagecartridgerecipe
    ADD CONSTRAINT products_packagecart_cartridge_id_86cf7c31_fk_products_ FOREIGN KEY (cartridge_id) REFERENCES products_cartridge(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: products_packagecartridgerecipe products_packagecart_package_cartridge_id_3267b9b6_fk_products_; Type: FK CONSTRAINT; Schema: public; Owner: digimundo
--

ALTER TABLE ONLY products_packagecartridgerecipe
    ADD CONSTRAINT products_packagecart_package_cartridge_id_3267b9b6_fk_products_ FOREIGN KEY (package_cartridge_id) REFERENCES products_packagecartridge(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: products_presentation products_presentation_supply_id_6aa845eb_fk_products_supply_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY products_presentation
    ADD CONSTRAINT products_presentation_supply_id_6aa845eb_fk_products_supply_id FOREIGN KEY (supply_id) REFERENCES products_supply(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: products_shoplistdetail products_shoplistdet_presentation_id_d82372ee_fk_products_; Type: FK CONSTRAINT; Schema: public; Owner: digimundo
--

ALTER TABLE ONLY products_shoplistdetail
    ADD CONSTRAINT products_shoplistdet_presentation_id_d82372ee_fk_products_ FOREIGN KEY (presentation_id) REFERENCES products_presentation(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: products_shoplistdetail products_shoplistdet_shop_list_id_a5f46e1b_fk_products_; Type: FK CONSTRAINT; Schema: public; Owner: digimundo
--

ALTER TABLE ONLY products_shoplistdetail
    ADD CONSTRAINT products_shoplistdet_shop_list_id_a5f46e1b_fk_products_ FOREIGN KEY (shop_list_id) REFERENCES products_shoplist(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: products_supply products_supply_category_id_dcaee927_fk_products_; Type: FK CONSTRAINT; Schema: public; Owner: digimundo
--

ALTER TABLE ONLY products_supply
    ADD CONSTRAINT products_supply_category_id_dcaee927_fk_products_ FOREIGN KEY (category_id) REFERENCES products_suppliescategory(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: products_supply products_supply_location_id_4661cab0_fk_products_; Type: FK CONSTRAINT; Schema: public; Owner: digimundo
--

ALTER TABLE ONLY products_supply
    ADD CONSTRAINT products_supply_location_id_4661cab0_fk_products_ FOREIGN KEY (location_id) REFERENCES products_supplylocation(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: products_supply products_supply_supplier_id_4cda4618_fk_branchoff; Type: FK CONSTRAINT; Schema: public; Owner: digimundo
--

ALTER TABLE ONLY products_supply
    ADD CONSTRAINT products_supply_supplier_id_4cda4618_fk_branchoff FOREIGN KEY (supplier_id) REFERENCES branchoffices_supplier(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: products_supplylocation products_supplylocat_branch_office_id_d4db03ed_fk_branchoff; Type: FK CONSTRAINT; Schema: public; Owner: digimundo
--

ALTER TABLE ONLY products_supplylocation
    ADD CONSTRAINT products_supplylocat_branch_office_id_d4db03ed_fk_branchoff FOREIGN KEY (branch_office_id) REFERENCES branchoffices_branchoffice(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: sales_cartridgeticketdetail sales_cartridgeticke_cartridge_id_f1af2ee6_fk_products_; Type: FK CONSTRAINT; Schema: public; Owner: digimundo
--

ALTER TABLE ONLY sales_cartridgeticketdetail
    ADD CONSTRAINT sales_cartridgeticke_cartridge_id_f1af2ee6_fk_products_ FOREIGN KEY (cartridge_id) REFERENCES products_cartridge(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: sales_cartridgeticketdetail sales_cartridgeticke_ticket_base_id_4b404df2_fk_sales_tic; Type: FK CONSTRAINT; Schema: public; Owner: digimundo
--

ALTER TABLE ONLY sales_cartridgeticketdetail
    ADD CONSTRAINT sales_cartridgeticke_ticket_base_id_4b404df2_fk_sales_tic FOREIGN KEY (ticket_base_id) REFERENCES sales_ticketbase(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: sales_packagecartridgeticketdetail sales_packagecartrid_package_cartridge_id_f7a34a2c_fk_products_; Type: FK CONSTRAINT; Schema: public; Owner: digimundo
--

ALTER TABLE ONLY sales_packagecartridgeticketdetail
    ADD CONSTRAINT sales_packagecartrid_package_cartridge_id_f7a34a2c_fk_products_ FOREIGN KEY (package_cartridge_id) REFERENCES products_packagecartridge(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: sales_packagecartridgeticketdetail sales_packagecartrid_ticket_base_id_78714a0f_fk_sales_tic; Type: FK CONSTRAINT; Schema: public; Owner: digimundo
--

ALTER TABLE ONLY sales_packagecartridgeticketdetail
    ADD CONSTRAINT sales_packagecartrid_ticket_base_id_78714a0f_fk_sales_tic FOREIGN KEY (ticket_base_id) REFERENCES sales_ticketbase(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: sales_ticketextraingredient sales_ticketextraing_cartridge_ticket_det_702795e0_fk_sales_car; Type: FK CONSTRAINT; Schema: public; Owner: digimundo
--

ALTER TABLE ONLY sales_ticketextraingredient
    ADD CONSTRAINT sales_ticketextraing_cartridge_ticket_det_702795e0_fk_sales_car FOREIGN KEY (cartridge_ticket_detail_id) REFERENCES sales_cartridgeticketdetail(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: sales_ticketextraingredient sales_ticketextraing_extra_ingredient_id_00f115e6_fk_products_; Type: FK CONSTRAINT; Schema: public; Owner: digimundo
--

ALTER TABLE ONLY sales_ticketextraingredient
    ADD CONSTRAINT sales_ticketextraing_extra_ingredient_id_00f115e6_fk_products_ FOREIGN KEY (extra_ingredient_id) REFERENCES products_extraingredient(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: sales_ticketorder sales_ticketorder_customer_id_46fddc49_fk_users_cus; Type: FK CONSTRAINT; Schema: public; Owner: digimundo
--

ALTER TABLE ONLY sales_ticketorder
    ADD CONSTRAINT sales_ticketorder_customer_id_46fddc49_fk_users_cus FOREIGN KEY (customer_id) REFERENCES users_customerprofile(user_ptr_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: sales_ticketorder sales_ticketorder_ticket_id_5ea1f77d_fk_sales_ticketbase_id; Type: FK CONSTRAINT; Schema: public; Owner: digimundo
--

ALTER TABLE ONLY sales_ticketorder
    ADD CONSTRAINT sales_ticketorder_ticket_id_5ea1f77d_fk_sales_ticketbase_id FOREIGN KEY (ticket_id) REFERENCES sales_ticketbase(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: sales_ticketpos sales_ticketpos_cashier_id_7ceac597_fk_users_user_id; Type: FK CONSTRAINT; Schema: public; Owner: digimundo
--

ALTER TABLE ONLY sales_ticketpos
    ADD CONSTRAINT sales_ticketpos_cashier_id_7ceac597_fk_users_user_id FOREIGN KEY (cashier_id) REFERENCES users_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: sales_ticketpos sales_ticketpos_ticket_id_b24734c3_fk_sales_ticketbase_id; Type: FK CONSTRAINT; Schema: public; Owner: digimundo
--

ALTER TABLE ONLY sales_ticketpos
    ADD CONSTRAINT sales_ticketpos_ticket_id_b24734c3_fk_sales_ticketbase_id FOREIGN KEY (ticket_id) REFERENCES sales_ticketbase(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: users_customerprofile users_customerprofile_user_ptr_id_51b1fac0_fk_users_user_id; Type: FK CONSTRAINT; Schema: public; Owner: digimundo
--

ALTER TABLE ONLY users_customerprofile
    ADD CONSTRAINT users_customerprofile_user_ptr_id_51b1fac0_fk_users_user_id FOREIGN KEY (user_ptr_id) REFERENCES users_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: users_user_groups users_user_groups_group_id_9afc8d0e_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: digimundo
--

ALTER TABLE ONLY users_user_groups
    ADD CONSTRAINT users_user_groups_group_id_9afc8d0e_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: users_user_groups users_user_groups_user_id_5f6f5a90_fk_users_user_id; Type: FK CONSTRAINT; Schema: public; Owner: digimundo
--

ALTER TABLE ONLY users_user_groups
    ADD CONSTRAINT users_user_groups_user_id_5f6f5a90_fk_users_user_id FOREIGN KEY (user_id) REFERENCES users_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: users_user_user_permissions users_user_user_perm_permission_id_0b93982e_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: digimundo
--

ALTER TABLE ONLY users_user_user_permissions
    ADD CONSTRAINT users_user_user_perm_permission_id_0b93982e_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: users_user_user_permissions users_user_user_permissions_user_id_20aca447_fk_users_user_id; Type: FK CONSTRAINT; Schema: public; Owner: digimundo
--

ALTER TABLE ONLY users_user_user_permissions
    ADD CONSTRAINT users_user_user_permissions_user_id_20aca447_fk_users_user_id FOREIGN KEY (user_id) REFERENCES users_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- PostgreSQL database dump complete
--

