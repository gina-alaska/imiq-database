--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: tables; Type: SCHEMA; Schema: -; Owner: imiq
--

CREATE SCHEMA tables;


ALTER SCHEMA tables OWNER TO imiq;

--
-- Name: views; Type: SCHEMA; Schema: -; Owner: imiq
--

CREATE SCHEMA views;


ALTER SCHEMA views OWNER TO imiq;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: adminpack; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS adminpack WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION adminpack; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION adminpack IS 'administrative functions for PostgreSQL';


--
-- Name: autoinc; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS autoinc WITH SCHEMA public;


--
-- Name: EXTENSION autoinc; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION autoinc IS 'functions for autoincrementing fields';


--
-- Name: btree_gin; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS btree_gin WITH SCHEMA public;


--
-- Name: EXTENSION btree_gin; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION btree_gin IS 'support for indexing common datatypes in GIN';


--
-- Name: btree_gist; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS btree_gist WITH SCHEMA public;


--
-- Name: EXTENSION btree_gist; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION btree_gist IS 'support for indexing common datatypes in GiST';


--
-- Name: chkpass; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS chkpass WITH SCHEMA public;


--
-- Name: EXTENSION chkpass; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION chkpass IS 'data type for auto-encrypted passwords';


--
-- Name: citext; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS citext WITH SCHEMA public;


--
-- Name: EXTENSION citext; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION citext IS 'data type for case-insensitive character strings';


--
-- Name: cube; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS cube WITH SCHEMA public;


--
-- Name: EXTENSION cube; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION cube IS 'data type for multidimensional cubes';


--
-- Name: dict_int; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS dict_int WITH SCHEMA public;


--
-- Name: EXTENSION dict_int; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION dict_int IS 'text search dictionary template for integers';


--
-- Name: dict_xsyn; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS dict_xsyn WITH SCHEMA public;


--
-- Name: EXTENSION dict_xsyn; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION dict_xsyn IS 'text search dictionary template for extended synonym processing';


--
-- Name: earthdistance; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS earthdistance WITH SCHEMA public;


--
-- Name: EXTENSION earthdistance; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION earthdistance IS 'calculate great-circle distances on the surface of the Earth';


--
-- Name: file_fdw; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS file_fdw WITH SCHEMA public;


--
-- Name: EXTENSION file_fdw; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION file_fdw IS 'foreign-data wrapper for flat file access';


--
-- Name: fuzzystrmatch; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS fuzzystrmatch WITH SCHEMA public;


--
-- Name: EXTENSION fuzzystrmatch; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION fuzzystrmatch IS 'determine similarities and distance between strings';


--
-- Name: hstore; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS hstore WITH SCHEMA public;


--
-- Name: EXTENSION hstore; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION hstore IS 'data type for storing sets of (key, value) pairs';


--
-- Name: insert_username; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS insert_username WITH SCHEMA public;


--
-- Name: EXTENSION insert_username; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION insert_username IS 'functions for tracking who changed a table';


--
-- Name: intagg; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS intagg WITH SCHEMA public;


--
-- Name: EXTENSION intagg; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION intagg IS 'integer aggregator and enumerator (obsolete)';


--
-- Name: intarray; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS intarray WITH SCHEMA public;


--
-- Name: EXTENSION intarray; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION intarray IS 'functions, operators, and index support for 1-D arrays of integers';


--
-- Name: lo; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS lo WITH SCHEMA public;


--
-- Name: EXTENSION lo; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION lo IS 'Large Object maintenance';


--
-- Name: ltree; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS ltree WITH SCHEMA public;


--
-- Name: EXTENSION ltree; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION ltree IS 'data type for hierarchical tree-like structures';


--
-- Name: moddatetime; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS moddatetime WITH SCHEMA public;


--
-- Name: EXTENSION moddatetime; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION moddatetime IS 'functions for tracking last modification time';


--
-- Name: pageinspect; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS pageinspect WITH SCHEMA public;


--
-- Name: EXTENSION pageinspect; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pageinspect IS 'inspect the contents of database pages at a low level';


--
-- Name: pg_buffercache; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS pg_buffercache WITH SCHEMA public;


--
-- Name: EXTENSION pg_buffercache; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pg_buffercache IS 'examine the shared buffer cache';


--
-- Name: pg_freespacemap; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS pg_freespacemap WITH SCHEMA public;


--
-- Name: EXTENSION pg_freespacemap; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pg_freespacemap IS 'examine the free space map (FSM)';


--
-- Name: pg_stat_statements; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS pg_stat_statements WITH SCHEMA public;


--
-- Name: EXTENSION pg_stat_statements; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pg_stat_statements IS 'track execution statistics of all SQL statements executed';


--
-- Name: pg_trgm; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS pg_trgm WITH SCHEMA public;


--
-- Name: EXTENSION pg_trgm; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pg_trgm IS 'text similarity measurement and index searching based on trigrams';


--
-- Name: pgcrypto; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA public;


--
-- Name: EXTENSION pgcrypto; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';


--
-- Name: pgrowlocks; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS pgrowlocks WITH SCHEMA public;


--
-- Name: EXTENSION pgrowlocks; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pgrowlocks IS 'show row-level locking information';


--
-- Name: pgstattuple; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS pgstattuple WITH SCHEMA public;


--
-- Name: EXTENSION pgstattuple; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pgstattuple IS 'show tuple-level statistics';


--
-- Name: refint; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS refint WITH SCHEMA public;


--
-- Name: EXTENSION refint; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION refint IS 'functions for implementing referential integrity (obsolete)';


--
-- Name: seg; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS seg WITH SCHEMA public;


--
-- Name: EXTENSION seg; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION seg IS 'data type for representing line segments or floating-point intervals';


--
-- Name: tablefunc; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS tablefunc WITH SCHEMA public;


--
-- Name: EXTENSION tablefunc; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION tablefunc IS 'functions that manipulate whole tables, including crosstab';


--
-- Name: timetravel; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS timetravel WITH SCHEMA public;


--
-- Name: EXTENSION timetravel; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION timetravel IS 'functions for implementing time travel';


--
-- Name: tsearch2; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS tsearch2 WITH SCHEMA public;


--
-- Name: EXTENSION tsearch2; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION tsearch2 IS 'compatibility package for pre-8.3 text search functions';


--
-- Name: unaccent; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS unaccent WITH SCHEMA public;


--
-- Name: EXTENSION unaccent; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION unaccent IS 'text search dictionary that removes accents';


--
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA public;


--
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


--
-- Name: xml2; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS xml2 WITH SCHEMA public;


--
-- Name: EXTENSION xml2; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION xml2 IS 'XPath querying and XSLT';


SET search_path = public, pg_catalog;

--
-- Name: box2d; Type: SHELL TYPE; Schema: public; Owner: postgres
--

CREATE TYPE box2d;


--
-- Name: box2d_in(cstring); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION box2d_in(cstring) RETURNS box2d
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'BOX2DFLOAT4_in';


ALTER FUNCTION public.box2d_in(cstring) OWNER TO postgres;

--
-- Name: box2d_out(box2d); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION box2d_out(box2d) RETURNS cstring
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'BOX2DFLOAT4_out';


ALTER FUNCTION public.box2d_out(box2d) OWNER TO postgres;

--
-- Name: box2d; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE box2d (
    INTERNALLENGTH = 16,
    INPUT = box2d_in,
    OUTPUT = box2d_out,
    ALIGNMENT = int4,
    STORAGE = plain
);


ALTER TYPE public.box2d OWNER TO postgres;

--
-- Name: box3d; Type: SHELL TYPE; Schema: public; Owner: postgres
--

CREATE TYPE box3d;


--
-- Name: box3d_in(cstring); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION box3d_in(cstring) RETURNS box3d
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'BOX3D_in';


ALTER FUNCTION public.box3d_in(cstring) OWNER TO postgres;

--
-- Name: box3d_out(box3d); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION box3d_out(box3d) RETURNS cstring
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'BOX3D_out';


ALTER FUNCTION public.box3d_out(box3d) OWNER TO postgres;

--
-- Name: box3d; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE box3d (
    INTERNALLENGTH = 48,
    INPUT = box3d_in,
    OUTPUT = box3d_out,
    ALIGNMENT = double,
    STORAGE = plain
);


ALTER TYPE public.box3d OWNER TO postgres;

--
-- Name: box3d_extent; Type: SHELL TYPE; Schema: public; Owner: postgres
--

CREATE TYPE box3d_extent;


--
-- Name: box3d_extent_in(cstring); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION box3d_extent_in(cstring) RETURNS box3d_extent
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'BOX3D_in';


ALTER FUNCTION public.box3d_extent_in(cstring) OWNER TO postgres;

--
-- Name: box3d_extent_out(box3d_extent); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION box3d_extent_out(box3d_extent) RETURNS cstring
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'BOX3D_extent_out';


ALTER FUNCTION public.box3d_extent_out(box3d_extent) OWNER TO postgres;

--
-- Name: box3d_extent; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE box3d_extent (
    INTERNALLENGTH = 48,
    INPUT = box3d_extent_in,
    OUTPUT = box3d_extent_out,
    ALIGNMENT = double,
    STORAGE = plain
);


ALTER TYPE public.box3d_extent OWNER TO postgres;

--
-- Name: chip; Type: SHELL TYPE; Schema: public; Owner: postgres
--

CREATE TYPE chip;


--
-- Name: chip_in(cstring); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION chip_in(cstring) RETURNS chip
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'CHIP_in';


ALTER FUNCTION public.chip_in(cstring) OWNER TO postgres;

--
-- Name: chip_out(chip); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION chip_out(chip) RETURNS cstring
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'CHIP_out';


ALTER FUNCTION public.chip_out(chip) OWNER TO postgres;

--
-- Name: chip; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE chip (
    INTERNALLENGTH = variable,
    INPUT = chip_in,
    OUTPUT = chip_out,
    ALIGNMENT = double,
    STORAGE = extended
);


ALTER TYPE public.chip OWNER TO postgres;

--
-- Name: geography; Type: SHELL TYPE; Schema: public; Owner: postgres
--

CREATE TYPE geography;


--
-- Name: geography_analyze(internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION geography_analyze(internal) RETURNS boolean
    LANGUAGE c STRICT
    AS '$libdir/postgis-1.5', 'geography_analyze';


ALTER FUNCTION public.geography_analyze(internal) OWNER TO postgres;

--
-- Name: geography_in(cstring, oid, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION geography_in(cstring, oid, integer) RETURNS geography
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'geography_in';


ALTER FUNCTION public.geography_in(cstring, oid, integer) OWNER TO postgres;

--
-- Name: geography_out(geography); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION geography_out(geography) RETURNS cstring
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'geography_out';


ALTER FUNCTION public.geography_out(geography) OWNER TO postgres;

--
-- Name: geography_typmod_in(cstring[]); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION geography_typmod_in(cstring[]) RETURNS integer
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'geography_typmod_in';


ALTER FUNCTION public.geography_typmod_in(cstring[]) OWNER TO postgres;

--
-- Name: geography_typmod_out(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION geography_typmod_out(integer) RETURNS cstring
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'geography_typmod_out';


ALTER FUNCTION public.geography_typmod_out(integer) OWNER TO postgres;

--
-- Name: geography; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE geography (
    INTERNALLENGTH = variable,
    INPUT = geography_in,
    OUTPUT = geography_out,
    TYPMOD_IN = geography_typmod_in,
    TYPMOD_OUT = geography_typmod_out,
    ANALYZE = geography_analyze,
    ALIGNMENT = double,
    STORAGE = main
);


ALTER TYPE public.geography OWNER TO postgres;

--
-- Name: geometry; Type: SHELL TYPE; Schema: public; Owner: postgres
--

CREATE TYPE geometry;


--
-- Name: geometry_analyze(internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION geometry_analyze(internal) RETURNS boolean
    LANGUAGE c STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_analyze';


ALTER FUNCTION public.geometry_analyze(internal) OWNER TO postgres;

--
-- Name: geometry_in(cstring); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION geometry_in(cstring) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_in';


ALTER FUNCTION public.geometry_in(cstring) OWNER TO postgres;

--
-- Name: geometry_out(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION geometry_out(geometry) RETURNS cstring
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_out';


ALTER FUNCTION public.geometry_out(geometry) OWNER TO postgres;

--
-- Name: geometry_recv(internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION geometry_recv(internal) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_recv';


ALTER FUNCTION public.geometry_recv(internal) OWNER TO postgres;

--
-- Name: geometry_send(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION geometry_send(geometry) RETURNS bytea
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_send';


ALTER FUNCTION public.geometry_send(geometry) OWNER TO postgres;

--
-- Name: geometry; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE geometry (
    INTERNALLENGTH = variable,
    INPUT = geometry_in,
    OUTPUT = geometry_out,
    RECEIVE = geometry_recv,
    SEND = geometry_send,
    ANALYZE = geometry_analyze,
    DELIMITER = ':',
    ALIGNMENT = int4,
    STORAGE = main
);


ALTER TYPE public.geometry OWNER TO postgres;

--
-- Name: geometry_dump; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE geometry_dump AS (
	path integer[],
	geom geometry
);


ALTER TYPE public.geometry_dump OWNER TO postgres;

--
-- Name: gidx; Type: SHELL TYPE; Schema: public; Owner: postgres
--

CREATE TYPE gidx;


--
-- Name: gidx_in(cstring); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gidx_in(cstring) RETURNS gidx
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'gidx_in';


ALTER FUNCTION public.gidx_in(cstring) OWNER TO postgres;

--
-- Name: gidx_out(gidx); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gidx_out(gidx) RETURNS cstring
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'gidx_out';


ALTER FUNCTION public.gidx_out(gidx) OWNER TO postgres;

--
-- Name: gidx; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE gidx (
    INTERNALLENGTH = variable,
    INPUT = gidx_in,
    OUTPUT = gidx_out,
    ALIGNMENT = double,
    STORAGE = plain
);


ALTER TYPE public.gidx OWNER TO postgres;

--
-- Name: pgis_abs; Type: SHELL TYPE; Schema: public; Owner: postgres
--

CREATE TYPE pgis_abs;


--
-- Name: pgis_abs_in(cstring); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION pgis_abs_in(cstring) RETURNS pgis_abs
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'pgis_abs_in';


ALTER FUNCTION public.pgis_abs_in(cstring) OWNER TO postgres;

--
-- Name: pgis_abs_out(pgis_abs); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION pgis_abs_out(pgis_abs) RETURNS cstring
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'pgis_abs_out';


ALTER FUNCTION public.pgis_abs_out(pgis_abs) OWNER TO postgres;

--
-- Name: pgis_abs; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE pgis_abs (
    INTERNALLENGTH = 8,
    INPUT = pgis_abs_in,
    OUTPUT = pgis_abs_out,
    ALIGNMENT = double,
    STORAGE = plain
);


ALTER TYPE public.pgis_abs OWNER TO postgres;

--
-- Name: spheroid; Type: SHELL TYPE; Schema: public; Owner: postgres
--

CREATE TYPE spheroid;


--
-- Name: spheroid_in(cstring); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION spheroid_in(cstring) RETURNS spheroid
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'ellipsoid_in';


ALTER FUNCTION public.spheroid_in(cstring) OWNER TO postgres;

--
-- Name: spheroid_out(spheroid); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION spheroid_out(spheroid) RETURNS cstring
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'ellipsoid_out';


ALTER FUNCTION public.spheroid_out(spheroid) OWNER TO postgres;

--
-- Name: spheroid; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE spheroid (
    INTERNALLENGTH = 65,
    INPUT = spheroid_in,
    OUTPUT = spheroid_out,
    ALIGNMENT = double,
    STORAGE = plain
);


ALTER TYPE public.spheroid OWNER TO postgres;

--
-- Name: _st_asgeojson(integer, geometry, integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION _st_asgeojson(integer, geometry, integer, integer) RETURNS text
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_asGeoJson';


ALTER FUNCTION public._st_asgeojson(integer, geometry, integer, integer) OWNER TO postgres;

--
-- Name: _st_asgeojson(integer, geography, integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION _st_asgeojson(integer, geography, integer, integer) RETURNS text
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'geography_as_geojson';


ALTER FUNCTION public._st_asgeojson(integer, geography, integer, integer) OWNER TO postgres;

--
-- Name: _st_asgml(integer, geometry, integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION _st_asgml(integer, geometry, integer, integer) RETURNS text
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_asGML';


ALTER FUNCTION public._st_asgml(integer, geometry, integer, integer) OWNER TO postgres;

--
-- Name: _st_asgml(integer, geography, integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION _st_asgml(integer, geography, integer, integer) RETURNS text
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'geography_as_gml';


ALTER FUNCTION public._st_asgml(integer, geography, integer, integer) OWNER TO postgres;

--
-- Name: _st_askml(integer, geometry, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION _st_askml(integer, geometry, integer) RETURNS text
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_asKML';


ALTER FUNCTION public._st_askml(integer, geometry, integer) OWNER TO postgres;

--
-- Name: _st_askml(integer, geography, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION _st_askml(integer, geography, integer) RETURNS text
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'geography_as_kml';


ALTER FUNCTION public._st_askml(integer, geography, integer) OWNER TO postgres;

--
-- Name: _st_bestsrid(geography); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION _st_bestsrid(geography) RETURNS integer
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT _ST_BestSRID($1,$1)$_$;


ALTER FUNCTION public._st_bestsrid(geography) OWNER TO postgres;

--
-- Name: _st_bestsrid(geography, geography); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION _st_bestsrid(geography, geography) RETURNS integer
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'geography_bestsrid';


ALTER FUNCTION public._st_bestsrid(geography, geography) OWNER TO postgres;

--
-- Name: _st_buffer(geometry, double precision, cstring); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION _st_buffer(geometry, double precision, cstring) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT COST 100
    AS '$libdir/postgis-1.5', 'buffer';


ALTER FUNCTION public._st_buffer(geometry, double precision, cstring) OWNER TO postgres;

--
-- Name: _st_contains(geometry, geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION _st_contains(geometry, geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT COST 100
    AS '$libdir/postgis-1.5', 'contains';


ALTER FUNCTION public._st_contains(geometry, geometry) OWNER TO postgres;

--
-- Name: _st_containsproperly(geometry, geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION _st_containsproperly(geometry, geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT COST 100
    AS '$libdir/postgis-1.5', 'containsproperly';


ALTER FUNCTION public._st_containsproperly(geometry, geometry) OWNER TO postgres;

--
-- Name: _st_coveredby(geometry, geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION _st_coveredby(geometry, geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT COST 100
    AS '$libdir/postgis-1.5', 'coveredby';


ALTER FUNCTION public._st_coveredby(geometry, geometry) OWNER TO postgres;

--
-- Name: _st_covers(geometry, geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION _st_covers(geometry, geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT COST 100
    AS '$libdir/postgis-1.5', 'covers';


ALTER FUNCTION public._st_covers(geometry, geometry) OWNER TO postgres;

--
-- Name: _st_covers(geography, geography); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION _st_covers(geography, geography) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT COST 100
    AS '$libdir/postgis-1.5', 'geography_covers';


ALTER FUNCTION public._st_covers(geography, geography) OWNER TO postgres;

--
-- Name: _st_crosses(geometry, geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION _st_crosses(geometry, geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT COST 100
    AS '$libdir/postgis-1.5', 'crosses';


ALTER FUNCTION public._st_crosses(geometry, geometry) OWNER TO postgres;

--
-- Name: _st_dfullywithin(geometry, geometry, double precision); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION _st_dfullywithin(geometry, geometry, double precision) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_dfullywithin';


ALTER FUNCTION public._st_dfullywithin(geometry, geometry, double precision) OWNER TO postgres;

--
-- Name: _st_distance(geography, geography, double precision, boolean); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION _st_distance(geography, geography, double precision, boolean) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT COST 100
    AS '$libdir/postgis-1.5', 'geography_distance';


ALTER FUNCTION public._st_distance(geography, geography, double precision, boolean) OWNER TO postgres;

--
-- Name: _st_dumppoints(geometry, integer[]); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION _st_dumppoints(the_geom geometry, cur_path integer[]) RETURNS SETOF geometry_dump
    LANGUAGE plpgsql
    AS $$
DECLARE
  tmp geometry_dump;
  tmp2 geometry_dump;
  nb_points integer;
  nb_geom integer;
  i integer;
  j integer;
  g geometry;
  
BEGIN
  
  RAISE DEBUG '%,%', cur_path, ST_GeometryType(the_geom);

  -- Special case (MULTI* OR GEOMETRYCOLLECTION) : iterate and return the DumpPoints of the geometries
  SELECT ST_NumGeometries(the_geom) INTO nb_geom;

  IF (nb_geom IS NOT NULL) THEN
    
    i = 1;
    FOR tmp2 IN SELECT (ST_Dump(the_geom)).* LOOP

      FOR tmp IN SELECT * FROM _ST_DumpPoints(tmp2.geom, cur_path || tmp2.path) LOOP
	    RETURN NEXT tmp;
      END LOOP;
      i = i + 1;
      
    END LOOP;

    RETURN;
  END IF;
  

  -- Special case (POLYGON) : return the points of the rings of a polygon
  IF (ST_GeometryType(the_geom) = 'ST_Polygon') THEN

    FOR tmp IN SELECT * FROM _ST_DumpPoints(ST_ExteriorRing(the_geom), cur_path || ARRAY[1]) LOOP
      RETURN NEXT tmp;
    END LOOP;
    
    j := ST_NumInteriorRings(the_geom);
    FOR i IN 1..j LOOP
        FOR tmp IN SELECT * FROM _ST_DumpPoints(ST_InteriorRingN(the_geom, i), cur_path || ARRAY[i+1]) LOOP
          RETURN NEXT tmp;
        END LOOP;
    END LOOP;
    
    RETURN;
  END IF;

    
  -- Special case (POINT) : return the point
  IF (ST_GeometryType(the_geom) = 'ST_Point') THEN

    tmp.path = cur_path || ARRAY[1];
    tmp.geom = the_geom;

    RETURN NEXT tmp;
    RETURN;

  END IF;


  -- Use ST_NumPoints rather than ST_NPoints to have a NULL value if the_geom isn't
  -- a LINESTRING or CIRCULARSTRING.
  SELECT ST_NumPoints(the_geom) INTO nb_points;

  -- This should never happen
  IF (nb_points IS NULL) THEN
    RAISE EXCEPTION 'Unexpected error while dumping geometry %', ST_AsText(the_geom);
  END IF;

  FOR i IN 1..nb_points LOOP
    tmp.path = cur_path || ARRAY[i];
    tmp.geom := ST_PointN(the_geom, i);
    RETURN NEXT tmp;
  END LOOP;
   
END
$$;


ALTER FUNCTION public._st_dumppoints(the_geom geometry, cur_path integer[]) OWNER TO postgres;

--
-- Name: _st_dwithin(geometry, geometry, double precision); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION _st_dwithin(geometry, geometry, double precision) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT COST 100
    AS '$libdir/postgis-1.5', 'LWGEOM_dwithin';


ALTER FUNCTION public._st_dwithin(geometry, geometry, double precision) OWNER TO postgres;

--
-- Name: _st_dwithin(geography, geography, double precision, boolean); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION _st_dwithin(geography, geography, double precision, boolean) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT COST 100
    AS '$libdir/postgis-1.5', 'geography_dwithin';


ALTER FUNCTION public._st_dwithin(geography, geography, double precision, boolean) OWNER TO postgres;

--
-- Name: _st_equals(geometry, geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION _st_equals(geometry, geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT COST 100
    AS '$libdir/postgis-1.5', 'geomequals';


ALTER FUNCTION public._st_equals(geometry, geometry) OWNER TO postgres;

--
-- Name: _st_expand(geography, double precision); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION _st_expand(geography, double precision) RETURNS geography
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'geography_expand';


ALTER FUNCTION public._st_expand(geography, double precision) OWNER TO postgres;

--
-- Name: _st_intersects(geometry, geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION _st_intersects(geometry, geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT COST 100
    AS '$libdir/postgis-1.5', 'intersects';


ALTER FUNCTION public._st_intersects(geometry, geometry) OWNER TO postgres;

--
-- Name: _st_linecrossingdirection(geometry, geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION _st_linecrossingdirection(geometry, geometry) RETURNS integer
    LANGUAGE c IMMUTABLE STRICT COST 100
    AS '$libdir/postgis-1.5', 'ST_LineCrossingDirection';


ALTER FUNCTION public._st_linecrossingdirection(geometry, geometry) OWNER TO postgres;

--
-- Name: _st_longestline(geometry, geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION _st_longestline(geometry, geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_longestline2d';


ALTER FUNCTION public._st_longestline(geometry, geometry) OWNER TO postgres;

--
-- Name: _st_maxdistance(geometry, geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION _st_maxdistance(geometry, geometry) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_maxdistance2d_linestring';


ALTER FUNCTION public._st_maxdistance(geometry, geometry) OWNER TO postgres;

--
-- Name: _st_orderingequals(geometry, geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION _st_orderingequals(geometry, geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT COST 100
    AS '$libdir/postgis-1.5', 'LWGEOM_same';


ALTER FUNCTION public._st_orderingequals(geometry, geometry) OWNER TO postgres;

--
-- Name: _st_overlaps(geometry, geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION _st_overlaps(geometry, geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT COST 100
    AS '$libdir/postgis-1.5', 'overlaps';


ALTER FUNCTION public._st_overlaps(geometry, geometry) OWNER TO postgres;

--
-- Name: _st_pointoutside(geography); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION _st_pointoutside(geography) RETURNS geography
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'geography_point_outside';


ALTER FUNCTION public._st_pointoutside(geography) OWNER TO postgres;

--
-- Name: _st_touches(geometry, geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION _st_touches(geometry, geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT COST 100
    AS '$libdir/postgis-1.5', 'touches';


ALTER FUNCTION public._st_touches(geometry, geometry) OWNER TO postgres;

--
-- Name: _st_within(geometry, geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION _st_within(geometry, geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT COST 100
    AS '$libdir/postgis-1.5', 'within';


ALTER FUNCTION public._st_within(geometry, geometry) OWNER TO postgres;

--
-- Name: addauth(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION addauth(text) RETURNS boolean
    LANGUAGE plpgsql
    AS $_$ 
DECLARE
	lockid alias for $1;
	okay boolean;
	myrec record;
BEGIN
	-- check to see if table exists
	--  if not, CREATE TEMP TABLE mylock (transid xid, lockcode text)
	okay := 'f';
	FOR myrec IN SELECT * FROM pg_class WHERE relname = 'temp_lock_have_table' LOOP
		okay := 't';
	END LOOP; 
	IF (okay <> 't') THEN 
		CREATE TEMP TABLE temp_lock_have_table (transid xid, lockcode text);
			-- this will only work from pgsql7.4 up
			-- ON COMMIT DELETE ROWS;
	END IF;

	--  INSERT INTO mylock VALUES ( $1)
--	EXECUTE 'INSERT INTO temp_lock_have_table VALUES ( '||
--		quote_literal(getTransactionID()) || ',' ||
--		quote_literal(lockid) ||')';

	INSERT INTO temp_lock_have_table VALUES (getTransactionID(), lockid);

	RETURN true::boolean;
END;
$_$;


ALTER FUNCTION public.addauth(text) OWNER TO postgres;

--
-- Name: addbbox(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION addbbox(geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_addBBOX';


ALTER FUNCTION public.addbbox(geometry) OWNER TO postgres;

--
-- Name: addgeometrycolumn(character varying, character varying, integer, character varying, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION addgeometrycolumn(character varying, character varying, integer, character varying, integer) RETURNS text
    LANGUAGE plpgsql STRICT
    AS $_$
DECLARE
	ret  text;
BEGIN
	SELECT AddGeometryColumn('','',$1,$2,$3,$4,$5) into ret;
	RETURN ret;
END;
$_$;


ALTER FUNCTION public.addgeometrycolumn(character varying, character varying, integer, character varying, integer) OWNER TO postgres;

--
-- Name: addgeometrycolumn(character varying, character varying, character varying, integer, character varying, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION addgeometrycolumn(character varying, character varying, character varying, integer, character varying, integer) RETURNS text
    LANGUAGE plpgsql STABLE STRICT
    AS $_$
DECLARE
	ret  text;
BEGIN
	SELECT AddGeometryColumn('',$1,$2,$3,$4,$5,$6) into ret;
	RETURN ret;
END;
$_$;


ALTER FUNCTION public.addgeometrycolumn(character varying, character varying, character varying, integer, character varying, integer) OWNER TO postgres;

--
-- Name: addgeometrycolumn(character varying, character varying, character varying, character varying, integer, character varying, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION addgeometrycolumn(character varying, character varying, character varying, character varying, integer, character varying, integer) RETURNS text
    LANGUAGE plpgsql STRICT
    AS $_$
DECLARE
	catalog_name alias for $1;
	schema_name alias for $2;
	table_name alias for $3;
	column_name alias for $4;
	new_srid alias for $5;
	new_type alias for $6;
	new_dim alias for $7;
	rec RECORD;
	sr varchar;
	real_schema name;
	sql text;

BEGIN

	-- Verify geometry type
	IF ( NOT ( (new_type = 'GEOMETRY') OR
			   (new_type = 'GEOMETRYCOLLECTION') OR
			   (new_type = 'POINT') OR
			   (new_type = 'MULTIPOINT') OR
			   (new_type = 'POLYGON') OR
			   (new_type = 'MULTIPOLYGON') OR
			   (new_type = 'LINESTRING') OR
			   (new_type = 'MULTILINESTRING') OR
			   (new_type = 'GEOMETRYCOLLECTIONM') OR
			   (new_type = 'POINTM') OR
			   (new_type = 'MULTIPOINTM') OR
			   (new_type = 'POLYGONM') OR
			   (new_type = 'MULTIPOLYGONM') OR
			   (new_type = 'LINESTRINGM') OR
			   (new_type = 'MULTILINESTRINGM') OR
			   (new_type = 'CIRCULARSTRING') OR
			   (new_type = 'CIRCULARSTRINGM') OR
			   (new_type = 'COMPOUNDCURVE') OR
			   (new_type = 'COMPOUNDCURVEM') OR
			   (new_type = 'CURVEPOLYGON') OR
			   (new_type = 'CURVEPOLYGONM') OR
			   (new_type = 'MULTICURVE') OR
			   (new_type = 'MULTICURVEM') OR
			   (new_type = 'MULTISURFACE') OR
			   (new_type = 'MULTISURFACEM')) )
	THEN
		RAISE EXCEPTION 'Invalid type name - valid ones are:
	POINT, MULTIPOINT,
	LINESTRING, MULTILINESTRING,
	POLYGON, MULTIPOLYGON,
	CIRCULARSTRING, COMPOUNDCURVE, MULTICURVE,
	CURVEPOLYGON, MULTISURFACE,
	GEOMETRY, GEOMETRYCOLLECTION,
	POINTM, MULTIPOINTM,
	LINESTRINGM, MULTILINESTRINGM,
	POLYGONM, MULTIPOLYGONM,
	CIRCULARSTRINGM, COMPOUNDCURVEM, MULTICURVEM
	CURVEPOLYGONM, MULTISURFACEM,
	or GEOMETRYCOLLECTIONM';
		RETURN 'fail';
	END IF;


	-- Verify dimension
	IF ( (new_dim >4) OR (new_dim <2) ) THEN
		RAISE EXCEPTION 'invalid dimension';
		RETURN 'fail';
	END IF;

	IF ( (new_type LIKE '%M') AND (new_dim!=3) ) THEN
		RAISE EXCEPTION 'TypeM needs 3 dimensions';
		RETURN 'fail';
	END IF;


	-- Verify SRID
	IF ( new_srid != -1 ) THEN
		SELECT SRID INTO sr FROM spatial_ref_sys WHERE SRID = new_srid;
		IF NOT FOUND THEN
			RAISE EXCEPTION 'AddGeometryColumns() - invalid SRID';
			RETURN 'fail';
		END IF;
	END IF;


	-- Verify schema
	IF ( schema_name IS NOT NULL AND schema_name != '' ) THEN
		sql := 'SELECT nspname FROM pg_namespace ' ||
			'WHERE text(nspname) = ' || quote_literal(schema_name) ||
			'LIMIT 1';
		RAISE DEBUG '%', sql;
		EXECUTE sql INTO real_schema;

		IF ( real_schema IS NULL ) THEN
			RAISE EXCEPTION 'Schema % is not a valid schemaname', quote_literal(schema_name);
			RETURN 'fail';
		END IF;
	END IF;

	IF ( real_schema IS NULL ) THEN
		RAISE DEBUG 'Detecting schema';
		sql := 'SELECT n.nspname AS schemaname ' ||
			'FROM pg_catalog.pg_class c ' ||
			  'JOIN pg_catalog.pg_namespace n ON n.oid = c.relnamespace ' ||
			'WHERE c.relkind = ' || quote_literal('r') ||
			' AND n.nspname NOT IN (' || quote_literal('pg_catalog') || ', ' || quote_literal('pg_toast') || ')' ||
			' AND pg_catalog.pg_table_is_visible(c.oid)' ||
			' AND c.relname = ' || quote_literal(table_name);
		RAISE DEBUG '%', sql;
		EXECUTE sql INTO real_schema;

		IF ( real_schema IS NULL ) THEN
			RAISE EXCEPTION 'Table % does not occur in the search_path', quote_literal(table_name);
			RETURN 'fail';
		END IF;
	END IF;


	-- Add geometry column to table
	sql := 'ALTER TABLE ' ||
		quote_ident(real_schema) || '.' || quote_ident(table_name)
		|| ' ADD COLUMN ' || quote_ident(column_name) ||
		' geometry ';
	RAISE DEBUG '%', sql;
	EXECUTE sql;


	-- Delete stale record in geometry_columns (if any)
	sql := 'DELETE FROM geometry_columns WHERE
		f_table_catalog = ' || quote_literal('') ||
		' AND f_table_schema = ' ||
		quote_literal(real_schema) ||
		' AND f_table_name = ' || quote_literal(table_name) ||
		' AND f_geometry_column = ' || quote_literal(column_name);
	RAISE DEBUG '%', sql;
	EXECUTE sql;


	-- Add record in geometry_columns
	sql := 'INSERT INTO geometry_columns (f_table_catalog,f_table_schema,f_table_name,' ||
										  'f_geometry_column,coord_dimension,srid,type)' ||
		' VALUES (' ||
		quote_literal('') || ',' ||
		quote_literal(real_schema) || ',' ||
		quote_literal(table_name) || ',' ||
		quote_literal(column_name) || ',' ||
		new_dim::text || ',' ||
		new_srid::text || ',' ||
		quote_literal(new_type) || ')';
	RAISE DEBUG '%', sql;
	EXECUTE sql;


	-- Add table CHECKs
	sql := 'ALTER TABLE ' ||
		quote_ident(real_schema) || '.' || quote_ident(table_name)
		|| ' ADD CONSTRAINT '
		|| quote_ident('enforce_srid_' || column_name)
		|| ' CHECK (ST_SRID(' || quote_ident(column_name) ||
		') = ' || new_srid::text || ')' ;
	RAISE DEBUG '%', sql;
	EXECUTE sql;

	sql := 'ALTER TABLE ' ||
		quote_ident(real_schema) || '.' || quote_ident(table_name)
		|| ' ADD CONSTRAINT '
		|| quote_ident('enforce_dims_' || column_name)
		|| ' CHECK (ST_NDims(' || quote_ident(column_name) ||
		') = ' || new_dim::text || ')' ;
	RAISE DEBUG '%', sql;
	EXECUTE sql;

	IF ( NOT (new_type = 'GEOMETRY')) THEN
		sql := 'ALTER TABLE ' ||
			quote_ident(real_schema) || '.' || quote_ident(table_name) || ' ADD CONSTRAINT ' ||
			quote_ident('enforce_geotype_' || column_name) ||
			' CHECK (GeometryType(' ||
			quote_ident(column_name) || ')=' ||
			quote_literal(new_type) || ' OR (' ||
			quote_ident(column_name) || ') is null)';
		RAISE DEBUG '%', sql;
		EXECUTE sql;
	END IF;

	RETURN
		real_schema || '.' ||
		table_name || '.' || column_name ||
		' SRID:' || new_srid::text ||
		' TYPE:' || new_type ||
		' DIMS:' || new_dim::text || ' ';
END;
$_$;


ALTER FUNCTION public.addgeometrycolumn(character varying, character varying, character varying, character varying, integer, character varying, integer) OWNER TO postgres;

--
-- Name: addpoint(geometry, geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION addpoint(geometry, geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_addpoint';


ALTER FUNCTION public.addpoint(geometry, geometry) OWNER TO postgres;

--
-- Name: addpoint(geometry, geometry, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION addpoint(geometry, geometry, integer) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_addpoint';


ALTER FUNCTION public.addpoint(geometry, geometry, integer) OWNER TO postgres;

--
-- Name: affine(geometry, double precision, double precision, double precision, double precision, double precision, double precision); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION affine(geometry, double precision, double precision, double precision, double precision, double precision, double precision) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT affine($1,  $2, $3, 0,  $4, $5, 0,  0, 0, 1,  $6, $7, 0)$_$;


ALTER FUNCTION public.affine(geometry, double precision, double precision, double precision, double precision, double precision, double precision) OWNER TO postgres;

--
-- Name: affine(geometry, double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION affine(geometry, double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_affine';


ALTER FUNCTION public.affine(geometry, double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision) OWNER TO postgres;

--
-- Name: area(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION area(geometry) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_area_polygon';


ALTER FUNCTION public.area(geometry) OWNER TO postgres;

--
-- Name: area2d(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION area2d(geometry) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_area_polygon';


ALTER FUNCTION public.area2d(geometry) OWNER TO postgres;

--
-- Name: asbinary(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION asbinary(geometry) RETURNS bytea
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_asBinary';


ALTER FUNCTION public.asbinary(geometry) OWNER TO postgres;

--
-- Name: asbinary(geometry, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION asbinary(geometry, text) RETURNS bytea
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_asBinary';


ALTER FUNCTION public.asbinary(geometry, text) OWNER TO postgres;

--
-- Name: asewkb(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION asewkb(geometry) RETURNS bytea
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'WKBFromLWGEOM';


ALTER FUNCTION public.asewkb(geometry) OWNER TO postgres;

--
-- Name: asewkb(geometry, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION asewkb(geometry, text) RETURNS bytea
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'WKBFromLWGEOM';


ALTER FUNCTION public.asewkb(geometry, text) OWNER TO postgres;

--
-- Name: asewkt(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION asewkt(geometry) RETURNS text
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_asEWKT';


ALTER FUNCTION public.asewkt(geometry) OWNER TO postgres;

--
-- Name: asgml(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION asgml(geometry) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT _ST_AsGML(2, $1, 15, 0)$_$;


ALTER FUNCTION public.asgml(geometry) OWNER TO postgres;

--
-- Name: asgml(geometry, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION asgml(geometry, integer) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT _ST_AsGML(2, $1, $2, 0)$_$;


ALTER FUNCTION public.asgml(geometry, integer) OWNER TO postgres;

--
-- Name: ashexewkb(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION ashexewkb(geometry) RETURNS text
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_asHEXEWKB';


ALTER FUNCTION public.ashexewkb(geometry) OWNER TO postgres;

--
-- Name: ashexewkb(geometry, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION ashexewkb(geometry, text) RETURNS text
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_asHEXEWKB';


ALTER FUNCTION public.ashexewkb(geometry, text) OWNER TO postgres;

--
-- Name: askml(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION askml(geometry) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT _ST_AsKML(2, transform($1,4326), 15)$_$;


ALTER FUNCTION public.askml(geometry) OWNER TO postgres;

--
-- Name: askml(geometry, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION askml(geometry, integer) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT _ST_AsKML(2, transform($1,4326), $2)$_$;


ALTER FUNCTION public.askml(geometry, integer) OWNER TO postgres;

--
-- Name: askml(integer, geometry, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION askml(integer, geometry, integer) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT _ST_AsKML($1, transform($2,4326), $3)$_$;


ALTER FUNCTION public.askml(integer, geometry, integer) OWNER TO postgres;

--
-- Name: assvg(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION assvg(geometry) RETURNS text
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'assvg_geometry';


ALTER FUNCTION public.assvg(geometry) OWNER TO postgres;

--
-- Name: assvg(geometry, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION assvg(geometry, integer) RETURNS text
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'assvg_geometry';


ALTER FUNCTION public.assvg(geometry, integer) OWNER TO postgres;

--
-- Name: assvg(geometry, integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION assvg(geometry, integer, integer) RETURNS text
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'assvg_geometry';


ALTER FUNCTION public.assvg(geometry, integer, integer) OWNER TO postgres;

--
-- Name: astext(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION astext(geometry) RETURNS text
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_asText';


ALTER FUNCTION public.astext(geometry) OWNER TO postgres;

--
-- Name: azimuth(geometry, geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION azimuth(geometry, geometry) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_azimuth';


ALTER FUNCTION public.azimuth(geometry, geometry) OWNER TO postgres;

--
-- Name: bdmpolyfromtext(text, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION bdmpolyfromtext(text, integer) RETURNS geometry
    LANGUAGE plpgsql IMMUTABLE STRICT
    AS $_$
DECLARE
	geomtext alias for $1;
	srid alias for $2;
	mline geometry;
	geom geometry;
BEGIN
	mline := MultiLineStringFromText(geomtext, srid);

	IF mline IS NULL
	THEN
		RAISE EXCEPTION 'Input is not a MultiLinestring';
	END IF;

	geom := multi(BuildArea(mline));

	RETURN geom;
END;
$_$;


ALTER FUNCTION public.bdmpolyfromtext(text, integer) OWNER TO postgres;

--
-- Name: bdpolyfromtext(text, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION bdpolyfromtext(text, integer) RETURNS geometry
    LANGUAGE plpgsql IMMUTABLE STRICT
    AS $_$
DECLARE
	geomtext alias for $1;
	srid alias for $2;
	mline geometry;
	geom geometry;
BEGIN
	mline := MultiLineStringFromText(geomtext, srid);

	IF mline IS NULL
	THEN
		RAISE EXCEPTION 'Input is not a MultiLinestring';
	END IF;

	geom := BuildArea(mline);

	IF GeometryType(geom) != 'POLYGON'
	THEN
		RAISE EXCEPTION 'Input returns more then a single polygon, try using BdMPolyFromText instead';
	END IF;

	RETURN geom;
END;
$_$;


ALTER FUNCTION public.bdpolyfromtext(text, integer) OWNER TO postgres;

--
-- Name: boundary(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION boundary(geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'boundary';


ALTER FUNCTION public.boundary(geometry) OWNER TO postgres;

--
-- Name: box(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION box(geometry) RETURNS box
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_to_BOX';


ALTER FUNCTION public.box(geometry) OWNER TO postgres;

--
-- Name: box(box3d); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION box(box3d) RETURNS box
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'BOX3D_to_BOX';


ALTER FUNCTION public.box(box3d) OWNER TO postgres;

--
-- Name: box2d(box3d_extent); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION box2d(box3d_extent) RETURNS box2d
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'BOX3D_to_BOX2DFLOAT4';


ALTER FUNCTION public.box2d(box3d_extent) OWNER TO postgres;

--
-- Name: box2d(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION box2d(geometry) RETURNS box2d
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_to_BOX2DFLOAT4';


ALTER FUNCTION public.box2d(geometry) OWNER TO postgres;

--
-- Name: box2d(box3d); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION box2d(box3d) RETURNS box2d
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'BOX3D_to_BOX2DFLOAT4';


ALTER FUNCTION public.box2d(box3d) OWNER TO postgres;

--
-- Name: box3d(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION box3d(geometry) RETURNS box3d
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_to_BOX3D';


ALTER FUNCTION public.box3d(geometry) OWNER TO postgres;

--
-- Name: box3d(box2d); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION box3d(box2d) RETURNS box3d
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'BOX2DFLOAT4_to_BOX3D';


ALTER FUNCTION public.box3d(box2d) OWNER TO postgres;

--
-- Name: box3d_extent(box3d_extent); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION box3d_extent(box3d_extent) RETURNS box3d
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'BOX3D_extent_to_BOX3D';


ALTER FUNCTION public.box3d_extent(box3d_extent) OWNER TO postgres;

--
-- Name: box3dtobox(box3d); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION box3dtobox(box3d) RETURNS box
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT box($1)$_$;


ALTER FUNCTION public.box3dtobox(box3d) OWNER TO postgres;

--
-- Name: buffer(geometry, double precision); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION buffer(geometry, double precision) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT COST 100
    AS '$libdir/postgis-1.5', 'buffer';


ALTER FUNCTION public.buffer(geometry, double precision) OWNER TO postgres;

--
-- Name: buffer(geometry, double precision, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION buffer(geometry, double precision, integer) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT ST_Buffer($1, $2, $3)$_$;


ALTER FUNCTION public.buffer(geometry, double precision, integer) OWNER TO postgres;

--
-- Name: buildarea(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION buildarea(geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT COST 100
    AS '$libdir/postgis-1.5', 'LWGEOM_buildarea';


ALTER FUNCTION public.buildarea(geometry) OWNER TO postgres;

--
-- Name: bytea(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION bytea(geometry) RETURNS bytea
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_to_bytea';


ALTER FUNCTION public.bytea(geometry) OWNER TO postgres;

--
-- Name: centroid(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION centroid(geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'centroid';


ALTER FUNCTION public.centroid(geometry) OWNER TO postgres;

--
-- Name: checkauth(text, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION checkauth(text, text) RETURNS integer
    LANGUAGE sql
    AS $_$ SELECT CheckAuth('', $1, $2) $_$;


ALTER FUNCTION public.checkauth(text, text) OWNER TO postgres;

--
-- Name: checkauth(text, text, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION checkauth(text, text, text) RETURNS integer
    LANGUAGE plpgsql
    AS $_$ 
DECLARE
	schema text;
BEGIN
	IF NOT LongTransactionsEnabled() THEN
		RAISE EXCEPTION 'Long transaction support disabled, use EnableLongTransaction() to enable.';
	END IF;

	if ( $1 != '' ) THEN
		schema = $1;
	ELSE
		SELECT current_schema() into schema;
	END IF;

	-- TODO: check for an already existing trigger ?

	EXECUTE 'CREATE TRIGGER check_auth BEFORE UPDATE OR DELETE ON ' 
		|| quote_ident(schema) || '.' || quote_ident($2)
		||' FOR EACH ROW EXECUTE PROCEDURE CheckAuthTrigger('
		|| quote_literal($3) || ')';

	RETURN 0;
END;
$_$;


ALTER FUNCTION public.checkauth(text, text, text) OWNER TO postgres;

--
-- Name: checkauthtrigger(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION checkauthtrigger() RETURNS trigger
    LANGUAGE c
    AS '$libdir/postgis-1.5', 'check_authorization';


ALTER FUNCTION public.checkauthtrigger() OWNER TO postgres;

--
-- Name: collect(geometry, geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION collect(geometry, geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE
    AS '$libdir/postgis-1.5', 'LWGEOM_collect';


ALTER FUNCTION public.collect(geometry, geometry) OWNER TO postgres;

--
-- Name: combine_bbox(box2d, geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION combine_bbox(box2d, geometry) RETURNS box2d
    LANGUAGE c IMMUTABLE
    AS '$libdir/postgis-1.5', 'BOX2DFLOAT4_combine';


ALTER FUNCTION public.combine_bbox(box2d, geometry) OWNER TO postgres;

--
-- Name: combine_bbox(box3d_extent, geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION combine_bbox(box3d_extent, geometry) RETURNS box3d_extent
    LANGUAGE c IMMUTABLE
    AS '$libdir/postgis-1.5', 'BOX3D_combine';


ALTER FUNCTION public.combine_bbox(box3d_extent, geometry) OWNER TO postgres;

--
-- Name: combine_bbox(box3d, geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION combine_bbox(box3d, geometry) RETURNS box3d
    LANGUAGE c IMMUTABLE
    AS '$libdir/postgis-1.5', 'BOX3D_combine';


ALTER FUNCTION public.combine_bbox(box3d, geometry) OWNER TO postgres;

--
-- Name: compression(chip); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION compression(chip) RETURNS integer
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'CHIP_getCompression';


ALTER FUNCTION public.compression(chip) OWNER TO postgres;

--
-- Name: contains(geometry, geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION contains(geometry, geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'contains';


ALTER FUNCTION public.contains(geometry, geometry) OWNER TO postgres;

--
-- Name: convexhull(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION convexhull(geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT COST 100
    AS '$libdir/postgis-1.5', 'convexhull';


ALTER FUNCTION public.convexhull(geometry) OWNER TO postgres;

--
-- Name: crosses(geometry, geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION crosses(geometry, geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'crosses';


ALTER FUNCTION public.crosses(geometry, geometry) OWNER TO postgres;

--
-- Name: datatype(chip); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION datatype(chip) RETURNS integer
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'CHIP_getDatatype';


ALTER FUNCTION public.datatype(chip) OWNER TO postgres;

--
-- Name: difference(geometry, geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION difference(geometry, geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'difference';


ALTER FUNCTION public.difference(geometry, geometry) OWNER TO postgres;

--
-- Name: dimension(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION dimension(geometry) RETURNS integer
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_dimension';


ALTER FUNCTION public.dimension(geometry) OWNER TO postgres;

--
-- Name: disablelongtransactions(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION disablelongtransactions() RETURNS text
    LANGUAGE plpgsql
    AS $$ 
DECLARE
	rec RECORD;

BEGIN

	--
	-- Drop all triggers applied by CheckAuth()
	--
	FOR rec IN
		SELECT c.relname, t.tgname, t.tgargs FROM pg_trigger t, pg_class c, pg_proc p
		WHERE p.proname = 'checkauthtrigger' and t.tgfoid = p.oid and t.tgrelid = c.oid
	LOOP
		EXECUTE 'DROP TRIGGER ' || quote_ident(rec.tgname) ||
			' ON ' || quote_ident(rec.relname);
	END LOOP;

	--
	-- Drop the authorization_table table
	--
	FOR rec IN SELECT * FROM pg_class WHERE relname = 'authorization_table' LOOP
		DROP TABLE authorization_table;
	END LOOP;

	--
	-- Drop the authorized_tables view
	--
	FOR rec IN SELECT * FROM pg_class WHERE relname = 'authorized_tables' LOOP
		DROP VIEW authorized_tables;
	END LOOP;

	RETURN 'Long transactions support disabled';
END;
$$;


ALTER FUNCTION public.disablelongtransactions() OWNER TO postgres;

--
-- Name: disjoint(geometry, geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION disjoint(geometry, geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'disjoint';


ALTER FUNCTION public.disjoint(geometry, geometry) OWNER TO postgres;

--
-- Name: distance(geometry, geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION distance(geometry, geometry) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT COST 100
    AS '$libdir/postgis-1.5', 'LWGEOM_mindistance2d';


ALTER FUNCTION public.distance(geometry, geometry) OWNER TO postgres;

--
-- Name: distance_sphere(geometry, geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION distance_sphere(geometry, geometry) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT COST 100
    AS '$libdir/postgis-1.5', 'LWGEOM_distance_sphere';


ALTER FUNCTION public.distance_sphere(geometry, geometry) OWNER TO postgres;

--
-- Name: distance_spheroid(geometry, geometry, spheroid); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION distance_spheroid(geometry, geometry, spheroid) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT COST 100
    AS '$libdir/postgis-1.5', 'LWGEOM_distance_ellipsoid';


ALTER FUNCTION public.distance_spheroid(geometry, geometry, spheroid) OWNER TO postgres;

--
-- Name: dropbbox(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION dropbbox(geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_dropBBOX';


ALTER FUNCTION public.dropbbox(geometry) OWNER TO postgres;

--
-- Name: dropgeometrycolumn(character varying, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION dropgeometrycolumn(character varying, character varying) RETURNS text
    LANGUAGE plpgsql STRICT
    AS $_$
DECLARE
	ret text;
BEGIN
	SELECT DropGeometryColumn('','',$1,$2) into ret;
	RETURN ret;
END;
$_$;


ALTER FUNCTION public.dropgeometrycolumn(character varying, character varying) OWNER TO postgres;

--
-- Name: dropgeometrycolumn(character varying, character varying, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION dropgeometrycolumn(character varying, character varying, character varying) RETURNS text
    LANGUAGE plpgsql STRICT
    AS $_$
DECLARE
	ret text;
BEGIN
	SELECT DropGeometryColumn('',$1,$2,$3) into ret;
	RETURN ret;
END;
$_$;


ALTER FUNCTION public.dropgeometrycolumn(character varying, character varying, character varying) OWNER TO postgres;

--
-- Name: dropgeometrycolumn(character varying, character varying, character varying, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION dropgeometrycolumn(character varying, character varying, character varying, character varying) RETURNS text
    LANGUAGE plpgsql STRICT
    AS $_$
DECLARE
	catalog_name alias for $1;
	schema_name alias for $2;
	table_name alias for $3;
	column_name alias for $4;
	myrec RECORD;
	okay boolean;
	real_schema name;

BEGIN


	-- Find, check or fix schema_name
	IF ( schema_name != '' ) THEN
		okay = 'f';

		FOR myrec IN SELECT nspname FROM pg_namespace WHERE text(nspname) = schema_name LOOP
			okay := 't';
		END LOOP;

		IF ( okay <> 't' ) THEN
			RAISE NOTICE 'Invalid schema name - using current_schema()';
			SELECT current_schema() into real_schema;
		ELSE
			real_schema = schema_name;
		END IF;
	ELSE
		SELECT current_schema() into real_schema;
	END IF;

	-- Find out if the column is in the geometry_columns table
	okay = 'f';
	FOR myrec IN SELECT * from geometry_columns where f_table_schema = text(real_schema) and f_table_name = table_name and f_geometry_column = column_name LOOP
		okay := 't';
	END LOOP;
	IF (okay <> 't') THEN
		RAISE EXCEPTION 'column not found in geometry_columns table';
		RETURN 'f';
	END IF;

	-- Remove ref from geometry_columns table
	EXECUTE 'delete from geometry_columns where f_table_schema = ' ||
		quote_literal(real_schema) || ' and f_table_name = ' ||
		quote_literal(table_name)  || ' and f_geometry_column = ' ||
		quote_literal(column_name);

	-- Remove table column
	EXECUTE 'ALTER TABLE ' || quote_ident(real_schema) || '.' ||
		quote_ident(table_name) || ' DROP COLUMN ' ||
		quote_ident(column_name);

	RETURN real_schema || '.' || table_name || '.' || column_name ||' effectively removed.';

END;
$_$;


ALTER FUNCTION public.dropgeometrycolumn(character varying, character varying, character varying, character varying) OWNER TO postgres;

--
-- Name: dropgeometrytable(character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION dropgeometrytable(character varying) RETURNS text
    LANGUAGE sql STRICT
    AS $_$ SELECT DropGeometryTable('','',$1) $_$;


ALTER FUNCTION public.dropgeometrytable(character varying) OWNER TO postgres;

--
-- Name: dropgeometrytable(character varying, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION dropgeometrytable(character varying, character varying) RETURNS text
    LANGUAGE sql STRICT
    AS $_$ SELECT DropGeometryTable('',$1,$2) $_$;


ALTER FUNCTION public.dropgeometrytable(character varying, character varying) OWNER TO postgres;

--
-- Name: dropgeometrytable(character varying, character varying, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION dropgeometrytable(character varying, character varying, character varying) RETURNS text
    LANGUAGE plpgsql STRICT
    AS $_$
DECLARE
	catalog_name alias for $1;
	schema_name alias for $2;
	table_name alias for $3;
	real_schema name;

BEGIN

	IF ( schema_name = '' ) THEN
		SELECT current_schema() into real_schema;
	ELSE
		real_schema = schema_name;
	END IF;

	-- Remove refs from geometry_columns table
	EXECUTE 'DELETE FROM geometry_columns WHERE ' ||
		'f_table_schema = ' || quote_literal(real_schema) ||
		' AND ' ||
		' f_table_name = ' || quote_literal(table_name);

	-- Remove table
	EXECUTE 'DROP TABLE IF EXISTS '
		|| quote_ident(real_schema) || '.' ||
		quote_ident(table_name);

	RETURN
		real_schema || '.' ||
		table_name ||' dropped.';

END;
$_$;


ALTER FUNCTION public.dropgeometrytable(character varying, character varying, character varying) OWNER TO postgres;

--
-- Name: dump(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION dump(geometry) RETURNS SETOF geometry_dump
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_dump';


ALTER FUNCTION public.dump(geometry) OWNER TO postgres;

--
-- Name: dumprings(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION dumprings(geometry) RETURNS SETOF geometry_dump
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_dump_rings';


ALTER FUNCTION public.dumprings(geometry) OWNER TO postgres;

--
-- Name: enablelongtransactions(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION enablelongtransactions() RETURNS text
    LANGUAGE plpgsql
    AS $$ 
DECLARE
	"query" text;
	exists bool;
	rec RECORD;

BEGIN

	exists = 'f';
	FOR rec IN SELECT * FROM pg_class WHERE relname = 'authorization_table'
	LOOP
		exists = 't';
	END LOOP;

	IF NOT exists
	THEN
		"query" = 'CREATE TABLE authorization_table (
			toid oid, -- table oid
			rid text, -- row id
			expires timestamp,
			authid text
		)';
		EXECUTE "query";
	END IF;

	exists = 'f';
	FOR rec IN SELECT * FROM pg_class WHERE relname = 'authorized_tables'
	LOOP
		exists = 't';
	END LOOP;

	IF NOT exists THEN
		"query" = 'CREATE VIEW authorized_tables AS ' ||
			'SELECT ' ||
			'n.nspname as schema, ' ||
			'c.relname as table, trim(' ||
			quote_literal(chr(92) || '000') ||
			' from t.tgargs) as id_column ' ||
			'FROM pg_trigger t, pg_class c, pg_proc p ' ||
			', pg_namespace n ' ||
			'WHERE p.proname = ' || quote_literal('checkauthtrigger') ||
			' AND c.relnamespace = n.oid' ||
			' AND t.tgfoid = p.oid and t.tgrelid = c.oid';
		EXECUTE "query";
	END IF;

	RETURN 'Long transactions support enabled';
END;
$$;


ALTER FUNCTION public.enablelongtransactions() OWNER TO postgres;

--
-- Name: endpoint(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION endpoint(geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_endpoint_linestring';


ALTER FUNCTION public.endpoint(geometry) OWNER TO postgres;

--
-- Name: envelope(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION envelope(geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_envelope';


ALTER FUNCTION public.envelope(geometry) OWNER TO postgres;

--
-- Name: equals(geometry, geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION equals(geometry, geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'geomequals';


ALTER FUNCTION public.equals(geometry, geometry) OWNER TO postgres;

--
-- Name: estimated_extent(text, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION estimated_extent(text, text) RETURNS box2d
    LANGUAGE c IMMUTABLE STRICT SECURITY DEFINER
    AS '$libdir/postgis-1.5', 'LWGEOM_estimated_extent';


ALTER FUNCTION public.estimated_extent(text, text) OWNER TO postgres;

--
-- Name: estimated_extent(text, text, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION estimated_extent(text, text, text) RETURNS box2d
    LANGUAGE c IMMUTABLE STRICT SECURITY DEFINER
    AS '$libdir/postgis-1.5', 'LWGEOM_estimated_extent';


ALTER FUNCTION public.estimated_extent(text, text, text) OWNER TO postgres;

--
-- Name: expand(box3d, double precision); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION expand(box3d, double precision) RETURNS box3d
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'BOX3D_expand';


ALTER FUNCTION public.expand(box3d, double precision) OWNER TO postgres;

--
-- Name: expand(box2d, double precision); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION expand(box2d, double precision) RETURNS box2d
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'BOX2DFLOAT4_expand';


ALTER FUNCTION public.expand(box2d, double precision) OWNER TO postgres;

--
-- Name: expand(geometry, double precision); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION expand(geometry, double precision) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_expand';


ALTER FUNCTION public.expand(geometry, double precision) OWNER TO postgres;

--
-- Name: exteriorring(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION exteriorring(geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_exteriorring_polygon';


ALTER FUNCTION public.exteriorring(geometry) OWNER TO postgres;

--
-- Name: factor(chip); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION factor(chip) RETURNS real
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'CHIP_getFactor';


ALTER FUNCTION public.factor(chip) OWNER TO postgres;

--
-- Name: find_extent(text, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION find_extent(text, text) RETURNS box2d
    LANGUAGE plpgsql IMMUTABLE STRICT
    AS $_$
DECLARE
	tablename alias for $1;
	columnname alias for $2;
	myrec RECORD;

BEGIN
	FOR myrec IN EXECUTE 'SELECT extent("' || columnname || '") FROM "' || tablename || '"' LOOP
		return myrec.extent;
	END LOOP;
END;
$_$;


ALTER FUNCTION public.find_extent(text, text) OWNER TO postgres;

--
-- Name: find_extent(text, text, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION find_extent(text, text, text) RETURNS box2d
    LANGUAGE plpgsql IMMUTABLE STRICT
    AS $_$
DECLARE
	schemaname alias for $1;
	tablename alias for $2;
	columnname alias for $3;
	myrec RECORD;

BEGIN
	FOR myrec IN EXECUTE 'SELECT extent("' || columnname || '") FROM "' || schemaname || '"."' || tablename || '"' LOOP
		return myrec.extent;
	END LOOP;
END;
$_$;


ALTER FUNCTION public.find_extent(text, text, text) OWNER TO postgres;

--
-- Name: find_srid(character varying, character varying, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION find_srid(character varying, character varying, character varying) RETURNS integer
    LANGUAGE plpgsql IMMUTABLE STRICT
    AS $_$
DECLARE
	schem text;
	tabl text;
	sr int4;
BEGIN
	IF $1 IS NULL THEN
	  RAISE EXCEPTION 'find_srid() - schema is NULL!';
	END IF;
	IF $2 IS NULL THEN
	  RAISE EXCEPTION 'find_srid() - table name is NULL!';
	END IF;
	IF $3 IS NULL THEN
	  RAISE EXCEPTION 'find_srid() - column name is NULL!';
	END IF;
	schem = $1;
	tabl = $2;
-- if the table contains a . and the schema is empty
-- split the table into a schema and a table
-- otherwise drop through to default behavior
	IF ( schem = '' and tabl LIKE '%.%' ) THEN
	 schem = substr(tabl,1,strpos(tabl,'.')-1);
	 tabl = substr(tabl,length(schem)+2);
	ELSE
	 schem = schem || '%';
	END IF;

	select SRID into sr from geometry_columns where f_table_schema like schem and f_table_name = tabl and f_geometry_column = $3;
	IF NOT FOUND THEN
	   RAISE EXCEPTION 'find_srid() - couldnt find the corresponding SRID - is the geometry registered in the GEOMETRY_COLUMNS table?  Is there an uppercase/lowercase missmatch?';
	END IF;
	return sr;
END;
$_$;


ALTER FUNCTION public.find_srid(character varying, character varying, character varying) OWNER TO postgres;

--
-- Name: fix_geometry_columns(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION fix_geometry_columns() RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE
	mislinked record;
	result text;
	linked integer;
	deleted integer;
	foundschema integer;
BEGIN

	-- Since 7.3 schema support has been added.
	-- Previous postgis versions used to put the database name in
	-- the schema column. This needs to be fixed, so we try to
	-- set the correct schema for each geometry_colums record
	-- looking at table, column, type and srid.
	UPDATE geometry_columns SET f_table_schema = n.nspname
		FROM pg_namespace n, pg_class c, pg_attribute a,
			pg_constraint sridcheck, pg_constraint typecheck
			WHERE ( f_table_schema is NULL
		OR f_table_schema = ''
			OR f_table_schema NOT IN (
					SELECT nspname::varchar
					FROM pg_namespace nn, pg_class cc, pg_attribute aa
					WHERE cc.relnamespace = nn.oid
					AND cc.relname = f_table_name::name
					AND aa.attrelid = cc.oid
					AND aa.attname = f_geometry_column::name))
			AND f_table_name::name = c.relname
			AND c.oid = a.attrelid
			AND c.relnamespace = n.oid
			AND f_geometry_column::name = a.attname

			AND sridcheck.conrelid = c.oid
		AND sridcheck.consrc LIKE '(srid(% = %)'
			AND sridcheck.consrc ~ textcat(' = ', srid::text)

			AND typecheck.conrelid = c.oid
		AND typecheck.consrc LIKE
		'((geometrytype(%) = ''%''::text) OR (% IS NULL))'
			AND typecheck.consrc ~ textcat(' = ''', type::text)

			AND NOT EXISTS (
					SELECT oid FROM geometry_columns gc
					WHERE c.relname::varchar = gc.f_table_name
					AND n.nspname::varchar = gc.f_table_schema
					AND a.attname::varchar = gc.f_geometry_column
			);

	GET DIAGNOSTICS foundschema = ROW_COUNT;

	-- no linkage to system table needed
	return 'fixed:'||foundschema::text;

END;
$$;


ALTER FUNCTION public.fix_geometry_columns() OWNER TO postgres;

--
-- Name: force_2d(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION force_2d(geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_force_2d';


ALTER FUNCTION public.force_2d(geometry) OWNER TO postgres;

--
-- Name: force_3d(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION force_3d(geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_force_3dz';


ALTER FUNCTION public.force_3d(geometry) OWNER TO postgres;

--
-- Name: force_3dm(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION force_3dm(geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_force_3dm';


ALTER FUNCTION public.force_3dm(geometry) OWNER TO postgres;

--
-- Name: force_3dz(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION force_3dz(geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_force_3dz';


ALTER FUNCTION public.force_3dz(geometry) OWNER TO postgres;

--
-- Name: force_4d(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION force_4d(geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_force_4d';


ALTER FUNCTION public.force_4d(geometry) OWNER TO postgres;

--
-- Name: force_collection(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION force_collection(geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_force_collection';


ALTER FUNCTION public.force_collection(geometry) OWNER TO postgres;

--
-- Name: forcerhr(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION forcerhr(geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_forceRHR_poly';


ALTER FUNCTION public.forcerhr(geometry) OWNER TO postgres;

--
-- Name: geography(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION geography(geometry) RETURNS geography
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'geography_from_geometry';


ALTER FUNCTION public.geography(geometry) OWNER TO postgres;

--
-- Name: geography(geography, integer, boolean); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION geography(geography, integer, boolean) RETURNS geography
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'geography_enforce_typmod';


ALTER FUNCTION public.geography(geography, integer, boolean) OWNER TO postgres;

--
-- Name: geography_cmp(geography, geography); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION geography_cmp(geography, geography) RETURNS integer
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'geography_cmp';


ALTER FUNCTION public.geography_cmp(geography, geography) OWNER TO postgres;

--
-- Name: geography_eq(geography, geography); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION geography_eq(geography, geography) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'geography_eq';


ALTER FUNCTION public.geography_eq(geography, geography) OWNER TO postgres;

--
-- Name: geography_ge(geography, geography); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION geography_ge(geography, geography) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'geography_ge';


ALTER FUNCTION public.geography_ge(geography, geography) OWNER TO postgres;

--
-- Name: geography_gist_compress(internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION geography_gist_compress(internal) RETURNS internal
    LANGUAGE c
    AS '$libdir/postgis-1.5', 'geography_gist_compress';


ALTER FUNCTION public.geography_gist_compress(internal) OWNER TO postgres;

--
-- Name: geography_gist_consistent(internal, geometry, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION geography_gist_consistent(internal, geometry, integer) RETURNS boolean
    LANGUAGE c
    AS '$libdir/postgis-1.5', 'geography_gist_consistent';


ALTER FUNCTION public.geography_gist_consistent(internal, geometry, integer) OWNER TO postgres;

--
-- Name: geography_gist_decompress(internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION geography_gist_decompress(internal) RETURNS internal
    LANGUAGE c
    AS '$libdir/postgis-1.5', 'geography_gist_decompress';


ALTER FUNCTION public.geography_gist_decompress(internal) OWNER TO postgres;

--
-- Name: geography_gist_join_selectivity(internal, oid, internal, smallint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION geography_gist_join_selectivity(internal, oid, internal, smallint) RETURNS double precision
    LANGUAGE c
    AS '$libdir/postgis-1.5', 'geography_gist_join_selectivity';


ALTER FUNCTION public.geography_gist_join_selectivity(internal, oid, internal, smallint) OWNER TO postgres;

--
-- Name: geography_gist_penalty(internal, internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION geography_gist_penalty(internal, internal, internal) RETURNS internal
    LANGUAGE c
    AS '$libdir/postgis-1.5', 'geography_gist_penalty';


ALTER FUNCTION public.geography_gist_penalty(internal, internal, internal) OWNER TO postgres;

--
-- Name: geography_gist_picksplit(internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION geography_gist_picksplit(internal, internal) RETURNS internal
    LANGUAGE c
    AS '$libdir/postgis-1.5', 'geography_gist_picksplit';


ALTER FUNCTION public.geography_gist_picksplit(internal, internal) OWNER TO postgres;

--
-- Name: geography_gist_same(box2d, box2d, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION geography_gist_same(box2d, box2d, internal) RETURNS internal
    LANGUAGE c
    AS '$libdir/postgis-1.5', 'geography_gist_same';


ALTER FUNCTION public.geography_gist_same(box2d, box2d, internal) OWNER TO postgres;

--
-- Name: geography_gist_selectivity(internal, oid, internal, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION geography_gist_selectivity(internal, oid, internal, integer) RETURNS double precision
    LANGUAGE c
    AS '$libdir/postgis-1.5', 'geography_gist_selectivity';


ALTER FUNCTION public.geography_gist_selectivity(internal, oid, internal, integer) OWNER TO postgres;

--
-- Name: geography_gist_union(bytea, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION geography_gist_union(bytea, internal) RETURNS internal
    LANGUAGE c
    AS '$libdir/postgis-1.5', 'geography_gist_union';


ALTER FUNCTION public.geography_gist_union(bytea, internal) OWNER TO postgres;

--
-- Name: geography_gt(geography, geography); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION geography_gt(geography, geography) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'geography_gt';


ALTER FUNCTION public.geography_gt(geography, geography) OWNER TO postgres;

--
-- Name: geography_le(geography, geography); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION geography_le(geography, geography) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'geography_le';


ALTER FUNCTION public.geography_le(geography, geography) OWNER TO postgres;

--
-- Name: geography_lt(geography, geography); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION geography_lt(geography, geography) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'geography_lt';


ALTER FUNCTION public.geography_lt(geography, geography) OWNER TO postgres;

--
-- Name: geography_overlaps(geography, geography); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION geography_overlaps(geography, geography) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'geography_overlaps';


ALTER FUNCTION public.geography_overlaps(geography, geography) OWNER TO postgres;

--
-- Name: geography_typmod_dims(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION geography_typmod_dims(integer) RETURNS integer
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'geography_typmod_dims';


ALTER FUNCTION public.geography_typmod_dims(integer) OWNER TO postgres;

--
-- Name: geography_typmod_srid(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION geography_typmod_srid(integer) RETURNS integer
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'geography_typmod_srid';


ALTER FUNCTION public.geography_typmod_srid(integer) OWNER TO postgres;

--
-- Name: geography_typmod_type(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION geography_typmod_type(integer) RETURNS text
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'geography_typmod_type';


ALTER FUNCTION public.geography_typmod_type(integer) OWNER TO postgres;

--
-- Name: geomcollfromtext(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION geomcollfromtext(text) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE
	WHEN geometrytype(GeomFromText($1)) = 'GEOMETRYCOLLECTION'
	THEN GeomFromText($1)
	ELSE NULL END
	$_$;


ALTER FUNCTION public.geomcollfromtext(text) OWNER TO postgres;

--
-- Name: geomcollfromtext(text, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION geomcollfromtext(text, integer) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE
	WHEN geometrytype(GeomFromText($1, $2)) = 'GEOMETRYCOLLECTION'
	THEN GeomFromText($1,$2)
	ELSE NULL END
	$_$;


ALTER FUNCTION public.geomcollfromtext(text, integer) OWNER TO postgres;

--
-- Name: geomcollfromwkb(bytea); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION geomcollfromwkb(bytea) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE
	WHEN geometrytype(GeomFromWKB($1)) = 'GEOMETRYCOLLECTION'
	THEN GeomFromWKB($1)
	ELSE NULL END
	$_$;


ALTER FUNCTION public.geomcollfromwkb(bytea) OWNER TO postgres;

--
-- Name: geomcollfromwkb(bytea, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION geomcollfromwkb(bytea, integer) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE
	WHEN geometrytype(GeomFromWKB($1, $2)) = 'GEOMETRYCOLLECTION'
	THEN GeomFromWKB($1, $2)
	ELSE NULL END
	$_$;


ALTER FUNCTION public.geomcollfromwkb(bytea, integer) OWNER TO postgres;

--
-- Name: geometry(box3d_extent); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION geometry(box3d_extent) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'BOX3D_to_LWGEOM';


ALTER FUNCTION public.geometry(box3d_extent) OWNER TO postgres;

--
-- Name: geometry(box2d); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION geometry(box2d) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'BOX2DFLOAT4_to_LWGEOM';


ALTER FUNCTION public.geometry(box2d) OWNER TO postgres;

--
-- Name: geometry(box3d); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION geometry(box3d) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'BOX3D_to_LWGEOM';


ALTER FUNCTION public.geometry(box3d) OWNER TO postgres;

--
-- Name: geometry(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION geometry(text) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'parse_WKT_lwgeom';


ALTER FUNCTION public.geometry(text) OWNER TO postgres;

--
-- Name: geometry(chip); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION geometry(chip) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'CHIP_to_LWGEOM';


ALTER FUNCTION public.geometry(chip) OWNER TO postgres;

--
-- Name: geometry(bytea); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION geometry(bytea) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_from_bytea';


ALTER FUNCTION public.geometry(bytea) OWNER TO postgres;

--
-- Name: geometry(geography); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION geometry(geography) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'geometry_from_geography';


ALTER FUNCTION public.geometry(geography) OWNER TO postgres;

--
-- Name: geometry_above(geometry, geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION geometry_above(geometry, geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_above';


ALTER FUNCTION public.geometry_above(geometry, geometry) OWNER TO postgres;

--
-- Name: geometry_below(geometry, geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION geometry_below(geometry, geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_below';


ALTER FUNCTION public.geometry_below(geometry, geometry) OWNER TO postgres;

--
-- Name: geometry_cmp(geometry, geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION geometry_cmp(geometry, geometry) RETURNS integer
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'lwgeom_cmp';


ALTER FUNCTION public.geometry_cmp(geometry, geometry) OWNER TO postgres;

--
-- Name: geometry_contain(geometry, geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION geometry_contain(geometry, geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_contain';


ALTER FUNCTION public.geometry_contain(geometry, geometry) OWNER TO postgres;

--
-- Name: geometry_contained(geometry, geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION geometry_contained(geometry, geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_contained';


ALTER FUNCTION public.geometry_contained(geometry, geometry) OWNER TO postgres;

--
-- Name: geometry_eq(geometry, geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION geometry_eq(geometry, geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'lwgeom_eq';


ALTER FUNCTION public.geometry_eq(geometry, geometry) OWNER TO postgres;

--
-- Name: geometry_ge(geometry, geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION geometry_ge(geometry, geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'lwgeom_ge';


ALTER FUNCTION public.geometry_ge(geometry, geometry) OWNER TO postgres;

--
-- Name: geometry_gist_joinsel(internal, oid, internal, smallint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION geometry_gist_joinsel(internal, oid, internal, smallint) RETURNS double precision
    LANGUAGE c
    AS '$libdir/postgis-1.5', 'LWGEOM_gist_joinsel';


ALTER FUNCTION public.geometry_gist_joinsel(internal, oid, internal, smallint) OWNER TO postgres;

--
-- Name: geometry_gist_sel(internal, oid, internal, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION geometry_gist_sel(internal, oid, internal, integer) RETURNS double precision
    LANGUAGE c
    AS '$libdir/postgis-1.5', 'LWGEOM_gist_sel';


ALTER FUNCTION public.geometry_gist_sel(internal, oid, internal, integer) OWNER TO postgres;

--
-- Name: geometry_gt(geometry, geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION geometry_gt(geometry, geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'lwgeom_gt';


ALTER FUNCTION public.geometry_gt(geometry, geometry) OWNER TO postgres;

--
-- Name: geometry_le(geometry, geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION geometry_le(geometry, geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'lwgeom_le';


ALTER FUNCTION public.geometry_le(geometry, geometry) OWNER TO postgres;

--
-- Name: geometry_left(geometry, geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION geometry_left(geometry, geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_left';


ALTER FUNCTION public.geometry_left(geometry, geometry) OWNER TO postgres;

--
-- Name: geometry_lt(geometry, geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION geometry_lt(geometry, geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'lwgeom_lt';


ALTER FUNCTION public.geometry_lt(geometry, geometry) OWNER TO postgres;

--
-- Name: geometry_overabove(geometry, geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION geometry_overabove(geometry, geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_overabove';


ALTER FUNCTION public.geometry_overabove(geometry, geometry) OWNER TO postgres;

--
-- Name: geometry_overbelow(geometry, geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION geometry_overbelow(geometry, geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_overbelow';


ALTER FUNCTION public.geometry_overbelow(geometry, geometry) OWNER TO postgres;

--
-- Name: geometry_overlap(geometry, geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION geometry_overlap(geometry, geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_overlap';


ALTER FUNCTION public.geometry_overlap(geometry, geometry) OWNER TO postgres;

--
-- Name: geometry_overleft(geometry, geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION geometry_overleft(geometry, geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_overleft';


ALTER FUNCTION public.geometry_overleft(geometry, geometry) OWNER TO postgres;

--
-- Name: geometry_overright(geometry, geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION geometry_overright(geometry, geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_overright';


ALTER FUNCTION public.geometry_overright(geometry, geometry) OWNER TO postgres;

--
-- Name: geometry_right(geometry, geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION geometry_right(geometry, geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_right';


ALTER FUNCTION public.geometry_right(geometry, geometry) OWNER TO postgres;

--
-- Name: geometry_same(geometry, geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION geometry_same(geometry, geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_samebox';


ALTER FUNCTION public.geometry_same(geometry, geometry) OWNER TO postgres;

--
-- Name: geometry_samebox(geometry, geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION geometry_samebox(geometry, geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_samebox';


ALTER FUNCTION public.geometry_samebox(geometry, geometry) OWNER TO postgres;

--
-- Name: geometryfromtext(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION geometryfromtext(text) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_from_text';


ALTER FUNCTION public.geometryfromtext(text) OWNER TO postgres;

--
-- Name: geometryfromtext(text, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION geometryfromtext(text, integer) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_from_text';


ALTER FUNCTION public.geometryfromtext(text, integer) OWNER TO postgres;

--
-- Name: geometryn(geometry, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION geometryn(geometry, integer) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_geometryn_collection';


ALTER FUNCTION public.geometryn(geometry, integer) OWNER TO postgres;

--
-- Name: geometrytype(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION geometrytype(geometry) RETURNS text
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_getTYPE';


ALTER FUNCTION public.geometrytype(geometry) OWNER TO postgres;

--
-- Name: geomfromewkb(bytea); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION geomfromewkb(bytea) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOMFromWKB';


ALTER FUNCTION public.geomfromewkb(bytea) OWNER TO postgres;

--
-- Name: geomfromewkt(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION geomfromewkt(text) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'parse_WKT_lwgeom';


ALTER FUNCTION public.geomfromewkt(text) OWNER TO postgres;

--
-- Name: geomfromtext(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION geomfromtext(text) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT geometryfromtext($1)$_$;


ALTER FUNCTION public.geomfromtext(text) OWNER TO postgres;

--
-- Name: geomfromtext(text, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION geomfromtext(text, integer) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT geometryfromtext($1, $2)$_$;


ALTER FUNCTION public.geomfromtext(text, integer) OWNER TO postgres;

--
-- Name: geomfromwkb(bytea); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION geomfromwkb(bytea) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_from_WKB';


ALTER FUNCTION public.geomfromwkb(bytea) OWNER TO postgres;

--
-- Name: geomfromwkb(bytea, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION geomfromwkb(bytea, integer) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT ST_SetSRID(GeomFromWKB($1), $2)$_$;


ALTER FUNCTION public.geomfromwkb(bytea, integer) OWNER TO postgres;

--
-- Name: geomunion(geometry, geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION geomunion(geometry, geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'geomunion';


ALTER FUNCTION public.geomunion(geometry, geometry) OWNER TO postgres;

--
-- Name: get_proj4_from_srid(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION get_proj4_from_srid(integer) RETURNS text
    LANGUAGE plpgsql IMMUTABLE STRICT
    AS $_$
BEGIN
	RETURN proj4text::text FROM spatial_ref_sys WHERE srid= $1;
END;
$_$;


ALTER FUNCTION public.get_proj4_from_srid(integer) OWNER TO postgres;

--
-- Name: getbbox(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION getbbox(geometry) RETURNS box2d
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_to_BOX2DFLOAT4';


ALTER FUNCTION public.getbbox(geometry) OWNER TO postgres;

--
-- Name: getsrid(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION getsrid(geometry) RETURNS integer
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_getSRID';


ALTER FUNCTION public.getsrid(geometry) OWNER TO postgres;

--
-- Name: gettransactionid(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gettransactionid() RETURNS xid
    LANGUAGE c
    AS '$libdir/postgis-1.5', 'getTransactionID';


ALTER FUNCTION public.gettransactionid() OWNER TO postgres;

--
-- Name: hasbbox(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION hasbbox(geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_hasBBOX';


ALTER FUNCTION public.hasbbox(geometry) OWNER TO postgres;

--
-- Name: height(chip); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION height(chip) RETURNS integer
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'CHIP_getHeight';


ALTER FUNCTION public.height(chip) OWNER TO postgres;

--
-- Name: interiorringn(geometry, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION interiorringn(geometry, integer) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_interiorringn_polygon';


ALTER FUNCTION public.interiorringn(geometry, integer) OWNER TO postgres;

--
-- Name: intersection(geometry, geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION intersection(geometry, geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'intersection';


ALTER FUNCTION public.intersection(geometry, geometry) OWNER TO postgres;

--
-- Name: intersects(geometry, geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION intersects(geometry, geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'intersects';


ALTER FUNCTION public.intersects(geometry, geometry) OWNER TO postgres;

--
-- Name: isclosed(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isclosed(geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_isclosed_linestring';


ALTER FUNCTION public.isclosed(geometry) OWNER TO postgres;

--
-- Name: isempty(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isempty(geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_isempty';


ALTER FUNCTION public.isempty(geometry) OWNER TO postgres;

--
-- Name: isring(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isring(geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'isring';


ALTER FUNCTION public.isring(geometry) OWNER TO postgres;

--
-- Name: issimple(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION issimple(geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'issimple';


ALTER FUNCTION public.issimple(geometry) OWNER TO postgres;

--
-- Name: isvalid(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isvalid(geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT COST 100
    AS '$libdir/postgis-1.5', 'isvalid';


ALTER FUNCTION public.isvalid(geometry) OWNER TO postgres;

--
-- Name: length(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION length(geometry) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_length_linestring';


ALTER FUNCTION public.length(geometry) OWNER TO postgres;

--
-- Name: length2d(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION length2d(geometry) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_length2d_linestring';


ALTER FUNCTION public.length2d(geometry) OWNER TO postgres;

--
-- Name: length2d_spheroid(geometry, spheroid); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION length2d_spheroid(geometry, spheroid) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT COST 100
    AS '$libdir/postgis-1.5', 'LWGEOM_length2d_ellipsoid';


ALTER FUNCTION public.length2d_spheroid(geometry, spheroid) OWNER TO postgres;

--
-- Name: length3d(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION length3d(geometry) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_length_linestring';


ALTER FUNCTION public.length3d(geometry) OWNER TO postgres;

--
-- Name: length3d_spheroid(geometry, spheroid); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION length3d_spheroid(geometry, spheroid) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_length_ellipsoid_linestring';


ALTER FUNCTION public.length3d_spheroid(geometry, spheroid) OWNER TO postgres;

--
-- Name: length_spheroid(geometry, spheroid); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION length_spheroid(geometry, spheroid) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT COST 100
    AS '$libdir/postgis-1.5', 'LWGEOM_length_ellipsoid_linestring';


ALTER FUNCTION public.length_spheroid(geometry, spheroid) OWNER TO postgres;

--
-- Name: line_interpolate_point(geometry, double precision); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION line_interpolate_point(geometry, double precision) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_line_interpolate_point';


ALTER FUNCTION public.line_interpolate_point(geometry, double precision) OWNER TO postgres;

--
-- Name: line_locate_point(geometry, geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION line_locate_point(geometry, geometry) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_line_locate_point';


ALTER FUNCTION public.line_locate_point(geometry, geometry) OWNER TO postgres;

--
-- Name: line_substring(geometry, double precision, double precision); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION line_substring(geometry, double precision, double precision) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_line_substring';


ALTER FUNCTION public.line_substring(geometry, double precision, double precision) OWNER TO postgres;

--
-- Name: linefrommultipoint(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION linefrommultipoint(geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_line_from_mpoint';


ALTER FUNCTION public.linefrommultipoint(geometry) OWNER TO postgres;

--
-- Name: linefromtext(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION linefromtext(text) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(GeomFromText($1)) = 'LINESTRING'
	THEN GeomFromText($1)
	ELSE NULL END
	$_$;


ALTER FUNCTION public.linefromtext(text) OWNER TO postgres;

--
-- Name: linefromtext(text, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION linefromtext(text, integer) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(GeomFromText($1, $2)) = 'LINESTRING'
	THEN GeomFromText($1,$2)
	ELSE NULL END
	$_$;


ALTER FUNCTION public.linefromtext(text, integer) OWNER TO postgres;

--
-- Name: linefromwkb(bytea); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION linefromwkb(bytea) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(GeomFromWKB($1)) = 'LINESTRING'
	THEN GeomFromWKB($1)
	ELSE NULL END
	$_$;


ALTER FUNCTION public.linefromwkb(bytea) OWNER TO postgres;

--
-- Name: linefromwkb(bytea, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION linefromwkb(bytea, integer) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(GeomFromWKB($1, $2)) = 'LINESTRING'
	THEN GeomFromWKB($1, $2)
	ELSE NULL END
	$_$;


ALTER FUNCTION public.linefromwkb(bytea, integer) OWNER TO postgres;

--
-- Name: linemerge(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION linemerge(geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT COST 100
    AS '$libdir/postgis-1.5', 'linemerge';


ALTER FUNCTION public.linemerge(geometry) OWNER TO postgres;

--
-- Name: linestringfromtext(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION linestringfromtext(text) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT LineFromText($1)$_$;


ALTER FUNCTION public.linestringfromtext(text) OWNER TO postgres;

--
-- Name: linestringfromtext(text, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION linestringfromtext(text, integer) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT LineFromText($1, $2)$_$;


ALTER FUNCTION public.linestringfromtext(text, integer) OWNER TO postgres;

--
-- Name: linestringfromwkb(bytea); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION linestringfromwkb(bytea) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(GeomFromWKB($1)) = 'LINESTRING'
	THEN GeomFromWKB($1)
	ELSE NULL END
	$_$;


ALTER FUNCTION public.linestringfromwkb(bytea) OWNER TO postgres;

--
-- Name: linestringfromwkb(bytea, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION linestringfromwkb(bytea, integer) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(GeomFromWKB($1, $2)) = 'LINESTRING'
	THEN GeomFromWKB($1, $2)
	ELSE NULL END
	$_$;


ALTER FUNCTION public.linestringfromwkb(bytea, integer) OWNER TO postgres;

--
-- Name: locate_along_measure(geometry, double precision); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION locate_along_measure(geometry, double precision) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$ SELECT locate_between_measures($1, $2, $2) $_$;


ALTER FUNCTION public.locate_along_measure(geometry, double precision) OWNER TO postgres;

--
-- Name: locate_between_measures(geometry, double precision, double precision); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION locate_between_measures(geometry, double precision, double precision) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_locate_between_m';


ALTER FUNCTION public.locate_between_measures(geometry, double precision, double precision) OWNER TO postgres;

--
-- Name: lockrow(text, text, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION lockrow(text, text, text) RETURNS integer
    LANGUAGE sql STRICT
    AS $_$ SELECT LockRow(current_schema(), $1, $2, $3, now()::timestamp+'1:00'); $_$;


ALTER FUNCTION public.lockrow(text, text, text) OWNER TO postgres;

--
-- Name: lockrow(text, text, text, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION lockrow(text, text, text, text) RETURNS integer
    LANGUAGE sql STRICT
    AS $_$ SELECT LockRow($1, $2, $3, $4, now()::timestamp+'1:00'); $_$;


ALTER FUNCTION public.lockrow(text, text, text, text) OWNER TO postgres;

--
-- Name: lockrow(text, text, text, timestamp without time zone); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION lockrow(text, text, text, timestamp without time zone) RETURNS integer
    LANGUAGE sql STRICT
    AS $_$ SELECT LockRow(current_schema(), $1, $2, $3, $4); $_$;


ALTER FUNCTION public.lockrow(text, text, text, timestamp without time zone) OWNER TO postgres;

--
-- Name: lockrow(text, text, text, text, timestamp without time zone); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION lockrow(text, text, text, text, timestamp without time zone) RETURNS integer
    LANGUAGE plpgsql STRICT
    AS $_$ 
DECLARE
	myschema alias for $1;
	mytable alias for $2;
	myrid   alias for $3;
	authid alias for $4;
	expires alias for $5;
	ret int;
	mytoid oid;
	myrec RECORD;
	
BEGIN

	IF NOT LongTransactionsEnabled() THEN
		RAISE EXCEPTION 'Long transaction support disabled, use EnableLongTransaction() to enable.';
	END IF;

	EXECUTE 'DELETE FROM authorization_table WHERE expires < now()'; 

	SELECT c.oid INTO mytoid FROM pg_class c, pg_namespace n
		WHERE c.relname = mytable
		AND c.relnamespace = n.oid
		AND n.nspname = myschema;

	-- RAISE NOTICE 'toid: %', mytoid;

	FOR myrec IN SELECT * FROM authorization_table WHERE 
		toid = mytoid AND rid = myrid
	LOOP
		IF myrec.authid != authid THEN
			RETURN 0;
		ELSE
			RETURN 1;
		END IF;
	END LOOP;

	EXECUTE 'INSERT INTO authorization_table VALUES ('||
		quote_literal(mytoid::text)||','||quote_literal(myrid)||
		','||quote_literal(expires::text)||
		','||quote_literal(authid) ||')';

	GET DIAGNOSTICS ret = ROW_COUNT;

	RETURN ret;
END;
$_$;


ALTER FUNCTION public.lockrow(text, text, text, text, timestamp without time zone) OWNER TO postgres;

--
-- Name: longtransactionsenabled(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION longtransactionsenabled() RETURNS boolean
    LANGUAGE plpgsql
    AS $$ 
DECLARE
	rec RECORD;
BEGIN
	FOR rec IN SELECT oid FROM pg_class WHERE relname = 'authorized_tables'
	LOOP
		return 't';
	END LOOP;
	return 'f';
END;
$$;


ALTER FUNCTION public.longtransactionsenabled() OWNER TO postgres;

--
-- Name: lwgeom_gist_compress(internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION lwgeom_gist_compress(internal) RETURNS internal
    LANGUAGE c
    AS '$libdir/postgis-1.5', 'LWGEOM_gist_compress';


ALTER FUNCTION public.lwgeom_gist_compress(internal) OWNER TO postgres;

--
-- Name: lwgeom_gist_consistent(internal, geometry, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION lwgeom_gist_consistent(internal, geometry, integer) RETURNS boolean
    LANGUAGE c
    AS '$libdir/postgis-1.5', 'LWGEOM_gist_consistent';


ALTER FUNCTION public.lwgeom_gist_consistent(internal, geometry, integer) OWNER TO postgres;

--
-- Name: lwgeom_gist_decompress(internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION lwgeom_gist_decompress(internal) RETURNS internal
    LANGUAGE c
    AS '$libdir/postgis-1.5', 'LWGEOM_gist_decompress';


ALTER FUNCTION public.lwgeom_gist_decompress(internal) OWNER TO postgres;

--
-- Name: lwgeom_gist_penalty(internal, internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION lwgeom_gist_penalty(internal, internal, internal) RETURNS internal
    LANGUAGE c
    AS '$libdir/postgis-1.5', 'LWGEOM_gist_penalty';


ALTER FUNCTION public.lwgeom_gist_penalty(internal, internal, internal) OWNER TO postgres;

--
-- Name: lwgeom_gist_picksplit(internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION lwgeom_gist_picksplit(internal, internal) RETURNS internal
    LANGUAGE c
    AS '$libdir/postgis-1.5', 'LWGEOM_gist_picksplit';


ALTER FUNCTION public.lwgeom_gist_picksplit(internal, internal) OWNER TO postgres;

--
-- Name: lwgeom_gist_same(box2d, box2d, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION lwgeom_gist_same(box2d, box2d, internal) RETURNS internal
    LANGUAGE c
    AS '$libdir/postgis-1.5', 'LWGEOM_gist_same';


ALTER FUNCTION public.lwgeom_gist_same(box2d, box2d, internal) OWNER TO postgres;

--
-- Name: lwgeom_gist_union(bytea, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION lwgeom_gist_union(bytea, internal) RETURNS internal
    LANGUAGE c
    AS '$libdir/postgis-1.5', 'LWGEOM_gist_union';


ALTER FUNCTION public.lwgeom_gist_union(bytea, internal) OWNER TO postgres;

--
-- Name: m(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION m(geometry) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_m_point';


ALTER FUNCTION public.m(geometry) OWNER TO postgres;

--
-- Name: makebox2d(geometry, geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION makebox2d(geometry, geometry) RETURNS box2d
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'BOX2DFLOAT4_construct';


ALTER FUNCTION public.makebox2d(geometry, geometry) OWNER TO postgres;

--
-- Name: makebox3d(geometry, geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION makebox3d(geometry, geometry) RETURNS box3d
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'BOX3D_construct';


ALTER FUNCTION public.makebox3d(geometry, geometry) OWNER TO postgres;

--
-- Name: makeline(geometry, geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION makeline(geometry, geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_makeline';


ALTER FUNCTION public.makeline(geometry, geometry) OWNER TO postgres;

--
-- Name: makeline_garray(geometry[]); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION makeline_garray(geometry[]) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_makeline_garray';


ALTER FUNCTION public.makeline_garray(geometry[]) OWNER TO postgres;

--
-- Name: makepoint(double precision, double precision); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION makepoint(double precision, double precision) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_makepoint';


ALTER FUNCTION public.makepoint(double precision, double precision) OWNER TO postgres;

--
-- Name: makepoint(double precision, double precision, double precision); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION makepoint(double precision, double precision, double precision) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_makepoint';


ALTER FUNCTION public.makepoint(double precision, double precision, double precision) OWNER TO postgres;

--
-- Name: makepoint(double precision, double precision, double precision, double precision); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION makepoint(double precision, double precision, double precision, double precision) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_makepoint';


ALTER FUNCTION public.makepoint(double precision, double precision, double precision, double precision) OWNER TO postgres;

--
-- Name: makepointm(double precision, double precision, double precision); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION makepointm(double precision, double precision, double precision) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_makepoint3dm';


ALTER FUNCTION public.makepointm(double precision, double precision, double precision) OWNER TO postgres;

--
-- Name: makepolygon(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION makepolygon(geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_makepoly';


ALTER FUNCTION public.makepolygon(geometry) OWNER TO postgres;

--
-- Name: makepolygon(geometry, geometry[]); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION makepolygon(geometry, geometry[]) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_makepoly';


ALTER FUNCTION public.makepolygon(geometry, geometry[]) OWNER TO postgres;

--
-- Name: max_distance(geometry, geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION max_distance(geometry, geometry) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_maxdistance2d_linestring';


ALTER FUNCTION public.max_distance(geometry, geometry) OWNER TO postgres;

--
-- Name: mem_size(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION mem_size(geometry) RETURNS integer
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_mem_size';


ALTER FUNCTION public.mem_size(geometry) OWNER TO postgres;

--
-- Name: mlinefromtext(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION mlinefromtext(text) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(GeomFromText($1)) = 'MULTILINESTRING'
	THEN GeomFromText($1)
	ELSE NULL END
	$_$;


ALTER FUNCTION public.mlinefromtext(text) OWNER TO postgres;

--
-- Name: mlinefromtext(text, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION mlinefromtext(text, integer) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE
	WHEN geometrytype(GeomFromText($1, $2)) = 'MULTILINESTRING'
	THEN GeomFromText($1,$2)
	ELSE NULL END
	$_$;


ALTER FUNCTION public.mlinefromtext(text, integer) OWNER TO postgres;

--
-- Name: mlinefromwkb(bytea); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION mlinefromwkb(bytea) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(GeomFromWKB($1)) = 'MULTILINESTRING'
	THEN GeomFromWKB($1)
	ELSE NULL END
	$_$;


ALTER FUNCTION public.mlinefromwkb(bytea) OWNER TO postgres;

--
-- Name: mlinefromwkb(bytea, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION mlinefromwkb(bytea, integer) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(GeomFromWKB($1, $2)) = 'MULTILINESTRING'
	THEN GeomFromWKB($1, $2)
	ELSE NULL END
	$_$;


ALTER FUNCTION public.mlinefromwkb(bytea, integer) OWNER TO postgres;

--
-- Name: mpointfromtext(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION mpointfromtext(text) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(GeomFromText($1)) = 'MULTIPOINT'
	THEN GeomFromText($1)
	ELSE NULL END
	$_$;


ALTER FUNCTION public.mpointfromtext(text) OWNER TO postgres;

--
-- Name: mpointfromtext(text, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION mpointfromtext(text, integer) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(GeomFromText($1,$2)) = 'MULTIPOINT'
	THEN GeomFromText($1,$2)
	ELSE NULL END
	$_$;


ALTER FUNCTION public.mpointfromtext(text, integer) OWNER TO postgres;

--
-- Name: mpointfromwkb(bytea); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION mpointfromwkb(bytea) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(GeomFromWKB($1)) = 'MULTIPOINT'
	THEN GeomFromWKB($1)
	ELSE NULL END
	$_$;


ALTER FUNCTION public.mpointfromwkb(bytea) OWNER TO postgres;

--
-- Name: mpointfromwkb(bytea, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION mpointfromwkb(bytea, integer) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(GeomFromWKB($1,$2)) = 'MULTIPOINT'
	THEN GeomFromWKB($1, $2)
	ELSE NULL END
	$_$;


ALTER FUNCTION public.mpointfromwkb(bytea, integer) OWNER TO postgres;

--
-- Name: mpolyfromtext(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION mpolyfromtext(text) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(GeomFromText($1)) = 'MULTIPOLYGON'
	THEN GeomFromText($1)
	ELSE NULL END
	$_$;


ALTER FUNCTION public.mpolyfromtext(text) OWNER TO postgres;

--
-- Name: mpolyfromtext(text, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION mpolyfromtext(text, integer) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(GeomFromText($1, $2)) = 'MULTIPOLYGON'
	THEN GeomFromText($1,$2)
	ELSE NULL END
	$_$;


ALTER FUNCTION public.mpolyfromtext(text, integer) OWNER TO postgres;

--
-- Name: mpolyfromwkb(bytea); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION mpolyfromwkb(bytea) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(GeomFromWKB($1)) = 'MULTIPOLYGON'
	THEN GeomFromWKB($1)
	ELSE NULL END
	$_$;


ALTER FUNCTION public.mpolyfromwkb(bytea) OWNER TO postgres;

--
-- Name: mpolyfromwkb(bytea, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION mpolyfromwkb(bytea, integer) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(GeomFromWKB($1, $2)) = 'MULTIPOLYGON'
	THEN GeomFromWKB($1, $2)
	ELSE NULL END
	$_$;


ALTER FUNCTION public.mpolyfromwkb(bytea, integer) OWNER TO postgres;

--
-- Name: multi(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION multi(geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_force_multi';


ALTER FUNCTION public.multi(geometry) OWNER TO postgres;

--
-- Name: multilinefromwkb(bytea); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION multilinefromwkb(bytea) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(GeomFromWKB($1)) = 'MULTILINESTRING'
	THEN GeomFromWKB($1)
	ELSE NULL END
	$_$;


ALTER FUNCTION public.multilinefromwkb(bytea) OWNER TO postgres;

--
-- Name: multilinefromwkb(bytea, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION multilinefromwkb(bytea, integer) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(GeomFromWKB($1, $2)) = 'MULTILINESTRING'
	THEN GeomFromWKB($1, $2)
	ELSE NULL END
	$_$;


ALTER FUNCTION public.multilinefromwkb(bytea, integer) OWNER TO postgres;

--
-- Name: multilinestringfromtext(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION multilinestringfromtext(text) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT ST_MLineFromText($1)$_$;


ALTER FUNCTION public.multilinestringfromtext(text) OWNER TO postgres;

--
-- Name: multilinestringfromtext(text, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION multilinestringfromtext(text, integer) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT MLineFromText($1, $2)$_$;


ALTER FUNCTION public.multilinestringfromtext(text, integer) OWNER TO postgres;

--
-- Name: multipointfromtext(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION multipointfromtext(text) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT MPointFromText($1)$_$;


ALTER FUNCTION public.multipointfromtext(text) OWNER TO postgres;

--
-- Name: multipointfromtext(text, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION multipointfromtext(text, integer) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT MPointFromText($1, $2)$_$;


ALTER FUNCTION public.multipointfromtext(text, integer) OWNER TO postgres;

--
-- Name: multipointfromwkb(bytea); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION multipointfromwkb(bytea) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(GeomFromWKB($1)) = 'MULTIPOINT'
	THEN GeomFromWKB($1)
	ELSE NULL END
	$_$;


ALTER FUNCTION public.multipointfromwkb(bytea) OWNER TO postgres;

--
-- Name: multipointfromwkb(bytea, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION multipointfromwkb(bytea, integer) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(GeomFromWKB($1,$2)) = 'MULTIPOINT'
	THEN GeomFromWKB($1, $2)
	ELSE NULL END
	$_$;


ALTER FUNCTION public.multipointfromwkb(bytea, integer) OWNER TO postgres;

--
-- Name: multipolyfromwkb(bytea); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION multipolyfromwkb(bytea) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(GeomFromWKB($1)) = 'MULTIPOLYGON'
	THEN GeomFromWKB($1)
	ELSE NULL END
	$_$;


ALTER FUNCTION public.multipolyfromwkb(bytea) OWNER TO postgres;

--
-- Name: multipolyfromwkb(bytea, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION multipolyfromwkb(bytea, integer) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(GeomFromWKB($1, $2)) = 'MULTIPOLYGON'
	THEN GeomFromWKB($1, $2)
	ELSE NULL END
	$_$;


ALTER FUNCTION public.multipolyfromwkb(bytea, integer) OWNER TO postgres;

--
-- Name: multipolygonfromtext(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION multipolygonfromtext(text) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT MPolyFromText($1)$_$;


ALTER FUNCTION public.multipolygonfromtext(text) OWNER TO postgres;

--
-- Name: multipolygonfromtext(text, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION multipolygonfromtext(text, integer) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT MPolyFromText($1, $2)$_$;


ALTER FUNCTION public.multipolygonfromtext(text, integer) OWNER TO postgres;

--
-- Name: ndims(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION ndims(geometry) RETURNS smallint
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_ndims';


ALTER FUNCTION public.ndims(geometry) OWNER TO postgres;

--
-- Name: noop(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION noop(geometry) RETURNS geometry
    LANGUAGE c STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_noop';


ALTER FUNCTION public.noop(geometry) OWNER TO postgres;

--
-- Name: npoints(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION npoints(geometry) RETURNS integer
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_npoints';


ALTER FUNCTION public.npoints(geometry) OWNER TO postgres;

--
-- Name: nrings(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION nrings(geometry) RETURNS integer
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_nrings';


ALTER FUNCTION public.nrings(geometry) OWNER TO postgres;

--
-- Name: numgeometries(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION numgeometries(geometry) RETURNS integer
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_numgeometries_collection';


ALTER FUNCTION public.numgeometries(geometry) OWNER TO postgres;

--
-- Name: numinteriorring(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION numinteriorring(geometry) RETURNS integer
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_numinteriorrings_polygon';


ALTER FUNCTION public.numinteriorring(geometry) OWNER TO postgres;

--
-- Name: numinteriorrings(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION numinteriorrings(geometry) RETURNS integer
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_numinteriorrings_polygon';


ALTER FUNCTION public.numinteriorrings(geometry) OWNER TO postgres;

--
-- Name: numpoints(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION numpoints(geometry) RETURNS integer
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_numpoints_linestring';


ALTER FUNCTION public.numpoints(geometry) OWNER TO postgres;

--
-- Name: overlaps(geometry, geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION "overlaps"(geometry, geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'overlaps';


ALTER FUNCTION public."overlaps"(geometry, geometry) OWNER TO postgres;

--
-- Name: perimeter(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION perimeter(geometry) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_perimeter_poly';


ALTER FUNCTION public.perimeter(geometry) OWNER TO postgres;

--
-- Name: perimeter2d(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION perimeter2d(geometry) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_perimeter2d_poly';


ALTER FUNCTION public.perimeter2d(geometry) OWNER TO postgres;

--
-- Name: perimeter3d(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION perimeter3d(geometry) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_perimeter_poly';


ALTER FUNCTION public.perimeter3d(geometry) OWNER TO postgres;

--
-- Name: pgis_geometry_accum_finalfn(pgis_abs); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION pgis_geometry_accum_finalfn(pgis_abs) RETURNS geometry[]
    LANGUAGE c
    AS '$libdir/postgis-1.5', 'pgis_geometry_accum_finalfn';


ALTER FUNCTION public.pgis_geometry_accum_finalfn(pgis_abs) OWNER TO postgres;

--
-- Name: pgis_geometry_accum_transfn(pgis_abs, geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION pgis_geometry_accum_transfn(pgis_abs, geometry) RETURNS pgis_abs
    LANGUAGE c
    AS '$libdir/postgis-1.5', 'pgis_geometry_accum_transfn';


ALTER FUNCTION public.pgis_geometry_accum_transfn(pgis_abs, geometry) OWNER TO postgres;

--
-- Name: pgis_geometry_collect_finalfn(pgis_abs); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION pgis_geometry_collect_finalfn(pgis_abs) RETURNS geometry
    LANGUAGE c
    AS '$libdir/postgis-1.5', 'pgis_geometry_collect_finalfn';


ALTER FUNCTION public.pgis_geometry_collect_finalfn(pgis_abs) OWNER TO postgres;

--
-- Name: pgis_geometry_makeline_finalfn(pgis_abs); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION pgis_geometry_makeline_finalfn(pgis_abs) RETURNS geometry
    LANGUAGE c
    AS '$libdir/postgis-1.5', 'pgis_geometry_makeline_finalfn';


ALTER FUNCTION public.pgis_geometry_makeline_finalfn(pgis_abs) OWNER TO postgres;

--
-- Name: pgis_geometry_polygonize_finalfn(pgis_abs); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION pgis_geometry_polygonize_finalfn(pgis_abs) RETURNS geometry
    LANGUAGE c
    AS '$libdir/postgis-1.5', 'pgis_geometry_polygonize_finalfn';


ALTER FUNCTION public.pgis_geometry_polygonize_finalfn(pgis_abs) OWNER TO postgres;

--
-- Name: pgis_geometry_union_finalfn(pgis_abs); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION pgis_geometry_union_finalfn(pgis_abs) RETURNS geometry
    LANGUAGE c
    AS '$libdir/postgis-1.5', 'pgis_geometry_union_finalfn';


ALTER FUNCTION public.pgis_geometry_union_finalfn(pgis_abs) OWNER TO postgres;

--
-- Name: point_inside_circle(geometry, double precision, double precision, double precision); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION point_inside_circle(geometry, double precision, double precision, double precision) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_inside_circle_point';


ALTER FUNCTION public.point_inside_circle(geometry, double precision, double precision, double precision) OWNER TO postgres;

--
-- Name: pointfromtext(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION pointfromtext(text) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(GeomFromText($1)) = 'POINT'
	THEN GeomFromText($1)
	ELSE NULL END
	$_$;


ALTER FUNCTION public.pointfromtext(text) OWNER TO postgres;

--
-- Name: pointfromtext(text, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION pointfromtext(text, integer) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(GeomFromText($1, $2)) = 'POINT'
	THEN GeomFromText($1,$2)
	ELSE NULL END
	$_$;


ALTER FUNCTION public.pointfromtext(text, integer) OWNER TO postgres;

--
-- Name: pointfromwkb(bytea); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION pointfromwkb(bytea) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(GeomFromWKB($1)) = 'POINT'
	THEN GeomFromWKB($1)
	ELSE NULL END
	$_$;


ALTER FUNCTION public.pointfromwkb(bytea) OWNER TO postgres;

--
-- Name: pointfromwkb(bytea, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION pointfromwkb(bytea, integer) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(GeomFromWKB($1, $2)) = 'POINT'
	THEN GeomFromWKB($1, $2)
	ELSE NULL END
	$_$;


ALTER FUNCTION public.pointfromwkb(bytea, integer) OWNER TO postgres;

--
-- Name: pointn(geometry, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION pointn(geometry, integer) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_pointn_linestring';


ALTER FUNCTION public.pointn(geometry, integer) OWNER TO postgres;

--
-- Name: pointonsurface(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION pointonsurface(geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'pointonsurface';


ALTER FUNCTION public.pointonsurface(geometry) OWNER TO postgres;

--
-- Name: polyfromtext(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION polyfromtext(text) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(GeomFromText($1)) = 'POLYGON'
	THEN GeomFromText($1)
	ELSE NULL END
	$_$;


ALTER FUNCTION public.polyfromtext(text) OWNER TO postgres;

--
-- Name: polyfromtext(text, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION polyfromtext(text, integer) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(GeomFromText($1, $2)) = 'POLYGON'
	THEN GeomFromText($1,$2)
	ELSE NULL END
	$_$;


ALTER FUNCTION public.polyfromtext(text, integer) OWNER TO postgres;

--
-- Name: polyfromwkb(bytea); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION polyfromwkb(bytea) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(GeomFromWKB($1)) = 'POLYGON'
	THEN GeomFromWKB($1)
	ELSE NULL END
	$_$;


ALTER FUNCTION public.polyfromwkb(bytea) OWNER TO postgres;

--
-- Name: polyfromwkb(bytea, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION polyfromwkb(bytea, integer) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(GeomFromWKB($1, $2)) = 'POLYGON'
	THEN GeomFromWKB($1, $2)
	ELSE NULL END
	$_$;


ALTER FUNCTION public.polyfromwkb(bytea, integer) OWNER TO postgres;

--
-- Name: polygonfromtext(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION polygonfromtext(text) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT PolyFromText($1)$_$;


ALTER FUNCTION public.polygonfromtext(text) OWNER TO postgres;

--
-- Name: polygonfromtext(text, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION polygonfromtext(text, integer) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT PolyFromText($1, $2)$_$;


ALTER FUNCTION public.polygonfromtext(text, integer) OWNER TO postgres;

--
-- Name: polygonfromwkb(bytea); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION polygonfromwkb(bytea) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(GeomFromWKB($1)) = 'POLYGON'
	THEN GeomFromWKB($1)
	ELSE NULL END
	$_$;


ALTER FUNCTION public.polygonfromwkb(bytea) OWNER TO postgres;

--
-- Name: polygonfromwkb(bytea, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION polygonfromwkb(bytea, integer) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(GeomFromWKB($1,$2)) = 'POLYGON'
	THEN GeomFromWKB($1, $2)
	ELSE NULL END
	$_$;


ALTER FUNCTION public.polygonfromwkb(bytea, integer) OWNER TO postgres;

--
-- Name: polygonize_garray(geometry[]); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION polygonize_garray(geometry[]) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT COST 100
    AS '$libdir/postgis-1.5', 'polygonize_garray';


ALTER FUNCTION public.polygonize_garray(geometry[]) OWNER TO postgres;

--
-- Name: populate_geometry_columns(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION populate_geometry_columns() RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE
	inserted    integer;
	oldcount    integer;
	probed      integer;
	stale       integer;
	gcs         RECORD;
	gc          RECORD;
	gsrid       integer;
	gndims      integer;
	gtype       text;
	query       text;
	gc_is_valid boolean;

BEGIN
	SELECT count(*) INTO oldcount FROM geometry_columns;
	inserted := 0;

	EXECUTE 'TRUNCATE geometry_columns';

	-- Count the number of geometry columns in all tables and views
	SELECT count(DISTINCT c.oid) INTO probed
	FROM pg_class c,
		 pg_attribute a,
		 pg_type t,
		 pg_namespace n
	WHERE (c.relkind = 'r' OR c.relkind = 'v')
	AND t.typname = 'geometry'
	AND a.attisdropped = false
	AND a.atttypid = t.oid
	AND a.attrelid = c.oid
	AND c.relnamespace = n.oid
	AND n.nspname NOT ILIKE 'pg_temp%';

	-- Iterate through all non-dropped geometry columns
	RAISE DEBUG 'Processing Tables.....';

	FOR gcs IN
	SELECT DISTINCT ON (c.oid) c.oid, n.nspname, c.relname
		FROM pg_class c,
			 pg_attribute a,
			 pg_type t,
			 pg_namespace n
		WHERE c.relkind = 'r'
		AND t.typname = 'geometry'
		AND a.attisdropped = false
		AND a.atttypid = t.oid
		AND a.attrelid = c.oid
		AND c.relnamespace = n.oid
		AND n.nspname NOT ILIKE 'pg_temp%'
	LOOP

	inserted := inserted + populate_geometry_columns(gcs.oid);
	END LOOP;

	-- Add views to geometry columns table
	RAISE DEBUG 'Processing Views.....';
	FOR gcs IN
	SELECT DISTINCT ON (c.oid) c.oid, n.nspname, c.relname
		FROM pg_class c,
			 pg_attribute a,
			 pg_type t,
			 pg_namespace n
		WHERE c.relkind = 'v'
		AND t.typname = 'geometry'
		AND a.attisdropped = false
		AND a.atttypid = t.oid
		AND a.attrelid = c.oid
		AND c.relnamespace = n.oid
	LOOP

	inserted := inserted + populate_geometry_columns(gcs.oid);
	END LOOP;

	IF oldcount > inserted THEN
	stale = oldcount-inserted;
	ELSE
	stale = 0;
	END IF;

	RETURN 'probed:' ||probed|| ' inserted:'||inserted|| ' conflicts:'||probed-inserted|| ' deleted:'||stale;
END

$$;


ALTER FUNCTION public.populate_geometry_columns() OWNER TO postgres;

--
-- Name: populate_geometry_columns(oid); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION populate_geometry_columns(tbl_oid oid) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
	gcs         RECORD;
	gc          RECORD;
	gsrid       integer;
	gndims      integer;
	gtype       text;
	query       text;
	gc_is_valid boolean;
	inserted    integer;

BEGIN
	inserted := 0;

	-- Iterate through all geometry columns in this table
	FOR gcs IN
	SELECT n.nspname, c.relname, a.attname
		FROM pg_class c,
			 pg_attribute a,
			 pg_type t,
			 pg_namespace n
		WHERE c.relkind = 'r'
		AND t.typname = 'geometry'
		AND a.attisdropped = false
		AND a.atttypid = t.oid
		AND a.attrelid = c.oid
		AND c.relnamespace = n.oid
		AND n.nspname NOT ILIKE 'pg_temp%'
		AND c.oid = tbl_oid
	LOOP

	RAISE DEBUG 'Processing table %.%.%', gcs.nspname, gcs.relname, gcs.attname;

	DELETE FROM geometry_columns
	  WHERE f_table_schema = gcs.nspname
	  AND f_table_name = gcs.relname
	  AND f_geometry_column = gcs.attname;

	gc_is_valid := true;

	-- Try to find srid check from system tables (pg_constraint)
	gsrid :=
		(SELECT replace(replace(split_part(s.consrc, ' = ', 2), ')', ''), '(', '')
		 FROM pg_class c, pg_namespace n, pg_attribute a, pg_constraint s
		 WHERE n.nspname = gcs.nspname
		 AND c.relname = gcs.relname
		 AND a.attname = gcs.attname
		 AND a.attrelid = c.oid
		 AND s.connamespace = n.oid
		 AND s.conrelid = c.oid
		 AND a.attnum = ANY (s.conkey)
		 AND s.consrc LIKE '%srid(% = %');
	IF (gsrid IS NULL) THEN
		-- Try to find srid from the geometry itself
		EXECUTE 'SELECT srid(' || quote_ident(gcs.attname) || ')
				 FROM ONLY ' || quote_ident(gcs.nspname) || '.' || quote_ident(gcs.relname) || '
				 WHERE ' || quote_ident(gcs.attname) || ' IS NOT NULL LIMIT 1'
			INTO gc;
		gsrid := gc.srid;

		-- Try to apply srid check to column
		IF (gsrid IS NOT NULL) THEN
			BEGIN
				EXECUTE 'ALTER TABLE ONLY ' || quote_ident(gcs.nspname) || '.' || quote_ident(gcs.relname) || '
						 ADD CONSTRAINT ' || quote_ident('enforce_srid_' || gcs.attname) || '
						 CHECK (srid(' || quote_ident(gcs.attname) || ') = ' || gsrid || ')';
			EXCEPTION
				WHEN check_violation THEN
					RAISE WARNING 'Not inserting ''%'' in ''%.%'' into geometry_columns: could not apply constraint CHECK (srid(%) = %)', quote_ident(gcs.attname), quote_ident(gcs.nspname), quote_ident(gcs.relname), quote_ident(gcs.attname), gsrid;
					gc_is_valid := false;
			END;
		END IF;
	END IF;

	-- Try to find ndims check from system tables (pg_constraint)
	gndims :=
		(SELECT replace(split_part(s.consrc, ' = ', 2), ')', '')
		 FROM pg_class c, pg_namespace n, pg_attribute a, pg_constraint s
		 WHERE n.nspname = gcs.nspname
		 AND c.relname = gcs.relname
		 AND a.attname = gcs.attname
		 AND a.attrelid = c.oid
		 AND s.connamespace = n.oid
		 AND s.conrelid = c.oid
		 AND a.attnum = ANY (s.conkey)
		 AND s.consrc LIKE '%ndims(% = %');
	IF (gndims IS NULL) THEN
		-- Try to find ndims from the geometry itself
		EXECUTE 'SELECT st_ndims(' || quote_ident(gcs.attname) || ') As ndims
				 FROM ONLY ' || quote_ident(gcs.nspname) || '.' || quote_ident(gcs.relname) || '
				 WHERE ' || quote_ident(gcs.attname) || ' IS NOT NULL LIMIT 1'
			INTO gc;
		gndims := gc.ndims;

		-- Try to apply ndims check to column
		IF (gndims IS NOT NULL) THEN
			BEGIN
				EXECUTE 'ALTER TABLE ONLY ' || quote_ident(gcs.nspname) || '.' || quote_ident(gcs.relname) || '
						 ADD CONSTRAINT ' || quote_ident('enforce_dims_' || gcs.attname) || '
						 CHECK (st_ndims(' || quote_ident(gcs.attname) || ') = '||gndims||')';
			EXCEPTION
				WHEN check_violation THEN
					RAISE WARNING 'Not inserting ''%'' in ''%.%'' into geometry_columns: could not apply constraint CHECK (st_ndims(%) = %)', quote_ident(gcs.attname), quote_ident(gcs.nspname), quote_ident(gcs.relname), quote_ident(gcs.attname), gndims;
					gc_is_valid := false;
			END;
		END IF;
	END IF;

	-- Try to find geotype check from system tables (pg_constraint)
	gtype :=
		(SELECT replace(split_part(s.consrc, '''', 2), ')', '')
		 FROM pg_class c, pg_namespace n, pg_attribute a, pg_constraint s
		 WHERE n.nspname = gcs.nspname
		 AND c.relname = gcs.relname
		 AND a.attname = gcs.attname
		 AND a.attrelid = c.oid
		 AND s.connamespace = n.oid
		 AND s.conrelid = c.oid
		 AND a.attnum = ANY (s.conkey)
		 AND s.consrc LIKE '%geometrytype(% = %');
	IF (gtype IS NULL) THEN
		-- Try to find geotype from the geometry itself
		EXECUTE 'SELECT geometrytype(' || quote_ident(gcs.attname) || ') As geometrytype
				 FROM ONLY ' || quote_ident(gcs.nspname) || '.' || quote_ident(gcs.relname) || '
				 WHERE ' || quote_ident(gcs.attname) || ' IS NOT NULL LIMIT 1'
			INTO gc;
		gtype := gc.geometrytype;
		--IF (gtype IS NULL) THEN
		--    gtype := 'GEOMETRY';
		--END IF;

		-- Try to apply geometrytype check to column
		IF (gtype IS NOT NULL) THEN
			BEGIN
				EXECUTE 'ALTER TABLE ONLY ' || quote_ident(gcs.nspname) || '.' || quote_ident(gcs.relname) || '
				ADD CONSTRAINT ' || quote_ident('enforce_geotype_' || gcs.attname) || '
				CHECK ((geometrytype(' || quote_ident(gcs.attname) || ') = ' || quote_literal(gtype) || ') OR (' || quote_ident(gcs.attname) || ' IS NULL))';
			EXCEPTION
				WHEN check_violation THEN
					-- No geometry check can be applied. This column contains a number of geometry types.
					RAISE WARNING 'Could not add geometry type check (%) to table column: %.%.%', gtype, quote_ident(gcs.nspname),quote_ident(gcs.relname),quote_ident(gcs.attname);
			END;
		END IF;
	END IF;

	IF (gsrid IS NULL) THEN
		RAISE WARNING 'Not inserting ''%'' in ''%.%'' into geometry_columns: could not determine the srid', quote_ident(gcs.attname), quote_ident(gcs.nspname), quote_ident(gcs.relname);
	ELSIF (gndims IS NULL) THEN
		RAISE WARNING 'Not inserting ''%'' in ''%.%'' into geometry_columns: could not determine the number of dimensions', quote_ident(gcs.attname), quote_ident(gcs.nspname), quote_ident(gcs.relname);
	ELSIF (gtype IS NULL) THEN
		RAISE WARNING 'Not inserting ''%'' in ''%.%'' into geometry_columns: could not determine the geometry type', quote_ident(gcs.attname), quote_ident(gcs.nspname), quote_ident(gcs.relname);
	ELSE
		-- Only insert into geometry_columns if table constraints could be applied.
		IF (gc_is_valid) THEN
			INSERT INTO geometry_columns (f_table_catalog,f_table_schema, f_table_name, f_geometry_column, coord_dimension, srid, type)
			VALUES ('', gcs.nspname, gcs.relname, gcs.attname, gndims, gsrid, gtype);
			inserted := inserted + 1;
		END IF;
	END IF;
	END LOOP;

	-- Add views to geometry columns table
	FOR gcs IN
	SELECT n.nspname, c.relname, a.attname
		FROM pg_class c,
			 pg_attribute a,
			 pg_type t,
			 pg_namespace n
		WHERE c.relkind = 'v'
		AND t.typname = 'geometry'
		AND a.attisdropped = false
		AND a.atttypid = t.oid
		AND a.attrelid = c.oid
		AND c.relnamespace = n.oid
		AND n.nspname NOT ILIKE 'pg_temp%'
		AND c.oid = tbl_oid
	LOOP
		RAISE DEBUG 'Processing view %.%.%', gcs.nspname, gcs.relname, gcs.attname;

	DELETE FROM geometry_columns
	  WHERE f_table_schema = gcs.nspname
	  AND f_table_name = gcs.relname
	  AND f_geometry_column = gcs.attname;
	  
		EXECUTE 'SELECT st_ndims(' || quote_ident(gcs.attname) || ') As ndims
				 FROM ' || quote_ident(gcs.nspname) || '.' || quote_ident(gcs.relname) || '
				 WHERE ' || quote_ident(gcs.attname) || ' IS NOT NULL LIMIT 1'
			INTO gc;
		gndims := gc.ndims;

		EXECUTE 'SELECT st_srid(' || quote_ident(gcs.attname) || ') As srid
				 FROM ' || quote_ident(gcs.nspname) || '.' || quote_ident(gcs.relname) || '
				 WHERE ' || quote_ident(gcs.attname) || ' IS NOT NULL LIMIT 1'
			INTO gc;
		gsrid := gc.srid;

		EXECUTE 'SELECT geometrytype(' || quote_ident(gcs.attname) || ') As geometrytype
				 FROM ' || quote_ident(gcs.nspname) || '.' || quote_ident(gcs.relname) || '
				 WHERE ' || quote_ident(gcs.attname) || ' IS NOT NULL LIMIT 1'
			INTO gc;
		gtype := gc.geometrytype;

		IF (gndims IS NULL) THEN
			RAISE WARNING 'Not inserting ''%'' in ''%.%'' into geometry_columns: could not determine ndims', quote_ident(gcs.attname), quote_ident(gcs.nspname), quote_ident(gcs.relname);
		ELSIF (gsrid IS NULL) THEN
			RAISE WARNING 'Not inserting ''%'' in ''%.%'' into geometry_columns: could not determine srid', quote_ident(gcs.attname), quote_ident(gcs.nspname), quote_ident(gcs.relname);
		ELSIF (gtype IS NULL) THEN
			RAISE WARNING 'Not inserting ''%'' in ''%.%'' into geometry_columns: could not determine gtype', quote_ident(gcs.attname), quote_ident(gcs.nspname), quote_ident(gcs.relname);
		ELSE
			query := 'INSERT INTO geometry_columns (f_table_catalog,f_table_schema, f_table_name, f_geometry_column, coord_dimension, srid, type) ' ||
					 'VALUES ('''', ' || quote_literal(gcs.nspname) || ',' || quote_literal(gcs.relname) || ',' || quote_literal(gcs.attname) || ',' || gndims || ',' || gsrid || ',' || quote_literal(gtype) || ')';
			EXECUTE query;
			inserted := inserted + 1;
		END IF;
	END LOOP;

	RETURN inserted;
END

$$;


ALTER FUNCTION public.populate_geometry_columns(tbl_oid oid) OWNER TO postgres;

--
-- Name: postgis_addbbox(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION postgis_addbbox(geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_addBBOX';


ALTER FUNCTION public.postgis_addbbox(geometry) OWNER TO postgres;

--
-- Name: postgis_cache_bbox(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION postgis_cache_bbox() RETURNS trigger
    LANGUAGE c
    AS '$libdir/postgis-1.5', 'cache_bbox';


ALTER FUNCTION public.postgis_cache_bbox() OWNER TO postgres;

--
-- Name: postgis_dropbbox(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION postgis_dropbbox(geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_dropBBOX';


ALTER FUNCTION public.postgis_dropbbox(geometry) OWNER TO postgres;

--
-- Name: postgis_full_version(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION postgis_full_version() RETURNS text
    LANGUAGE plpgsql IMMUTABLE
    AS $$
DECLARE
	libver text;
	projver text;
	geosver text;
	libxmlver text;
	usestats bool;
	dbproc text;
	relproc text;
	fullver text;
BEGIN
	SELECT postgis_lib_version() INTO libver;
	SELECT postgis_proj_version() INTO projver;
	SELECT postgis_geos_version() INTO geosver;
	SELECT postgis_libxml_version() INTO libxmlver;
	SELECT postgis_uses_stats() INTO usestats;
	SELECT postgis_scripts_installed() INTO dbproc;
	SELECT postgis_scripts_released() INTO relproc;

	fullver = 'POSTGIS="' || libver || '"';

	IF  geosver IS NOT NULL THEN
		fullver = fullver || ' GEOS="' || geosver || '"';
	END IF;

	IF  projver IS NOT NULL THEN
		fullver = fullver || ' PROJ="' || projver || '"';
	END IF;

	IF  libxmlver IS NOT NULL THEN
		fullver = fullver || ' LIBXML="' || libxmlver || '"';
	END IF;

	IF usestats THEN
		fullver = fullver || ' USE_STATS';
	END IF;

	-- fullver = fullver || ' DBPROC="' || dbproc || '"';
	-- fullver = fullver || ' RELPROC="' || relproc || '"';

	IF dbproc != relproc THEN
		fullver = fullver || ' (procs from ' || dbproc || ' need upgrade)';
	END IF;

	RETURN fullver;
END
$$;


ALTER FUNCTION public.postgis_full_version() OWNER TO postgres;

--
-- Name: postgis_geos_version(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION postgis_geos_version() RETURNS text
    LANGUAGE c IMMUTABLE
    AS '$libdir/postgis-1.5', 'postgis_geos_version';


ALTER FUNCTION public.postgis_geos_version() OWNER TO postgres;

--
-- Name: postgis_getbbox(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION postgis_getbbox(geometry) RETURNS box2d
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_to_BOX2DFLOAT4';


ALTER FUNCTION public.postgis_getbbox(geometry) OWNER TO postgres;

--
-- Name: postgis_gist_joinsel(internal, oid, internal, smallint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION postgis_gist_joinsel(internal, oid, internal, smallint) RETURNS double precision
    LANGUAGE c
    AS '$libdir/postgis-1.5', 'LWGEOM_gist_joinsel';


ALTER FUNCTION public.postgis_gist_joinsel(internal, oid, internal, smallint) OWNER TO postgres;

--
-- Name: postgis_gist_sel(internal, oid, internal, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION postgis_gist_sel(internal, oid, internal, integer) RETURNS double precision
    LANGUAGE c
    AS '$libdir/postgis-1.5', 'LWGEOM_gist_sel';


ALTER FUNCTION public.postgis_gist_sel(internal, oid, internal, integer) OWNER TO postgres;

--
-- Name: postgis_hasbbox(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION postgis_hasbbox(geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_hasBBOX';


ALTER FUNCTION public.postgis_hasbbox(geometry) OWNER TO postgres;

--
-- Name: postgis_lib_build_date(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION postgis_lib_build_date() RETURNS text
    LANGUAGE c IMMUTABLE
    AS '$libdir/postgis-1.5', 'postgis_lib_build_date';


ALTER FUNCTION public.postgis_lib_build_date() OWNER TO postgres;

--
-- Name: postgis_lib_version(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION postgis_lib_version() RETURNS text
    LANGUAGE c IMMUTABLE
    AS '$libdir/postgis-1.5', 'postgis_lib_version';


ALTER FUNCTION public.postgis_lib_version() OWNER TO postgres;

--
-- Name: postgis_libxml_version(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION postgis_libxml_version() RETURNS text
    LANGUAGE c IMMUTABLE
    AS '$libdir/postgis-1.5', 'postgis_libxml_version';


ALTER FUNCTION public.postgis_libxml_version() OWNER TO postgres;

--
-- Name: postgis_noop(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION postgis_noop(geometry) RETURNS geometry
    LANGUAGE c STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_noop';


ALTER FUNCTION public.postgis_noop(geometry) OWNER TO postgres;

--
-- Name: postgis_proj_version(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION postgis_proj_version() RETURNS text
    LANGUAGE c IMMUTABLE
    AS '$libdir/postgis-1.5', 'postgis_proj_version';


ALTER FUNCTION public.postgis_proj_version() OWNER TO postgres;

--
-- Name: postgis_scripts_build_date(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION postgis_scripts_build_date() RETURNS text
    LANGUAGE sql IMMUTABLE
    AS $$SELECT '2012-11-16 11:47:18'::text AS version$$;


ALTER FUNCTION public.postgis_scripts_build_date() OWNER TO postgres;

--
-- Name: postgis_scripts_installed(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION postgis_scripts_installed() RETURNS text
    LANGUAGE sql IMMUTABLE
    AS $$SELECT '1.5 r10612'::text AS version$$;


ALTER FUNCTION public.postgis_scripts_installed() OWNER TO postgres;

--
-- Name: postgis_scripts_released(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION postgis_scripts_released() RETURNS text
    LANGUAGE c IMMUTABLE
    AS '$libdir/postgis-1.5', 'postgis_scripts_released';


ALTER FUNCTION public.postgis_scripts_released() OWNER TO postgres;

--
-- Name: postgis_transform_geometry(geometry, text, text, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION postgis_transform_geometry(geometry, text, text, integer) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'transform_geom';


ALTER FUNCTION public.postgis_transform_geometry(geometry, text, text, integer) OWNER TO postgres;

--
-- Name: postgis_uses_stats(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION postgis_uses_stats() RETURNS boolean
    LANGUAGE c IMMUTABLE
    AS '$libdir/postgis-1.5', 'postgis_uses_stats';


ALTER FUNCTION public.postgis_uses_stats() OWNER TO postgres;

--
-- Name: postgis_version(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION postgis_version() RETURNS text
    LANGUAGE c IMMUTABLE
    AS '$libdir/postgis-1.5', 'postgis_version';


ALTER FUNCTION public.postgis_version() OWNER TO postgres;

--
-- Name: probe_geometry_columns(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION probe_geometry_columns() RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE
	inserted integer;
	oldcount integer;
	probed integer;
	stale integer;
BEGIN

	SELECT count(*) INTO oldcount FROM geometry_columns;

	SELECT count(*) INTO probed
		FROM pg_class c, pg_attribute a, pg_type t,
			pg_namespace n,
			pg_constraint sridcheck, pg_constraint typecheck

		WHERE t.typname = 'geometry'
		AND a.atttypid = t.oid
		AND a.attrelid = c.oid
		AND c.relnamespace = n.oid
		AND sridcheck.connamespace = n.oid
		AND typecheck.connamespace = n.oid
		AND sridcheck.conrelid = c.oid
		AND sridcheck.consrc LIKE '(%srid('||a.attname||') = %)'
		AND typecheck.conrelid = c.oid
		AND typecheck.consrc LIKE
		'((geometrytype('||a.attname||') = ''%''::text) OR (% IS NULL))'
		;

	INSERT INTO geometry_columns SELECT
		''::varchar as f_table_catalogue,
		n.nspname::varchar as f_table_schema,
		c.relname::varchar as f_table_name,
		a.attname::varchar as f_geometry_column,
		2 as coord_dimension,
		trim(both  ' =)' from
			replace(replace(split_part(
				sridcheck.consrc, ' = ', 2), ')', ''), '(', ''))::integer AS srid,
		trim(both ' =)''' from substr(typecheck.consrc,
			strpos(typecheck.consrc, '='),
			strpos(typecheck.consrc, '::')-
			strpos(typecheck.consrc, '=')
			))::varchar as type
		FROM pg_class c, pg_attribute a, pg_type t,
			pg_namespace n,
			pg_constraint sridcheck, pg_constraint typecheck
		WHERE t.typname = 'geometry'
		AND a.atttypid = t.oid
		AND a.attrelid = c.oid
		AND c.relnamespace = n.oid
		AND sridcheck.connamespace = n.oid
		AND typecheck.connamespace = n.oid
		AND sridcheck.conrelid = c.oid
		AND sridcheck.consrc LIKE '(st_srid('||a.attname||') = %)'
		AND typecheck.conrelid = c.oid
		AND typecheck.consrc LIKE
		'((geometrytype('||a.attname||') = ''%''::text) OR (% IS NULL))'

			AND NOT EXISTS (
					SELECT oid FROM geometry_columns gc
					WHERE c.relname::varchar = gc.f_table_name
					AND n.nspname::varchar = gc.f_table_schema
					AND a.attname::varchar = gc.f_geometry_column
			);

	GET DIAGNOSTICS inserted = ROW_COUNT;

	IF oldcount > probed THEN
		stale = oldcount-probed;
	ELSE
		stale = 0;
	END IF;

	RETURN 'probed:'||probed::text||
		' inserted:'||inserted::text||
		' conflicts:'||(probed-inserted)::text||
		' stale:'||stale::text;
END

$$;


ALTER FUNCTION public.probe_geometry_columns() OWNER TO postgres;

--
-- Name: relate(geometry, geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION relate(geometry, geometry) RETURNS text
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'relate_full';


ALTER FUNCTION public.relate(geometry, geometry) OWNER TO postgres;

--
-- Name: relate(geometry, geometry, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION relate(geometry, geometry, text) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'relate_pattern';


ALTER FUNCTION public.relate(geometry, geometry, text) OWNER TO postgres;

--
-- Name: removepoint(geometry, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION removepoint(geometry, integer) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_removepoint';


ALTER FUNCTION public.removepoint(geometry, integer) OWNER TO postgres;

--
-- Name: rename_geometry_table_constraints(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION rename_geometry_table_constraints() RETURNS text
    LANGUAGE sql IMMUTABLE
    AS $$
SELECT 'rename_geometry_table_constraint() is obsoleted'::text
$$;


ALTER FUNCTION public.rename_geometry_table_constraints() OWNER TO postgres;

--
-- Name: reverse(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION reverse(geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_reverse';


ALTER FUNCTION public.reverse(geometry) OWNER TO postgres;

--
-- Name: rotate(geometry, double precision); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION rotate(geometry, double precision) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT rotateZ($1, $2)$_$;


ALTER FUNCTION public.rotate(geometry, double precision) OWNER TO postgres;

--
-- Name: rotatex(geometry, double precision); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION rotatex(geometry, double precision) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT affine($1, 1, 0, 0, 0, cos($2), -sin($2), 0, sin($2), cos($2), 0, 0, 0)$_$;


ALTER FUNCTION public.rotatex(geometry, double precision) OWNER TO postgres;

--
-- Name: rotatey(geometry, double precision); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION rotatey(geometry, double precision) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT affine($1,  cos($2), 0, sin($2),  0, 1, 0,  -sin($2), 0, cos($2), 0,  0, 0)$_$;


ALTER FUNCTION public.rotatey(geometry, double precision) OWNER TO postgres;

--
-- Name: rotatez(geometry, double precision); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION rotatez(geometry, double precision) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT affine($1,  cos($2), -sin($2), 0,  sin($2), cos($2), 0,  0, 0, 1,  0, 0, 0)$_$;


ALTER FUNCTION public.rotatez(geometry, double precision) OWNER TO postgres;

--
-- Name: scale(geometry, double precision, double precision); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION scale(geometry, double precision, double precision) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT scale($1, $2, $3, 1)$_$;


ALTER FUNCTION public.scale(geometry, double precision, double precision) OWNER TO postgres;

--
-- Name: scale(geometry, double precision, double precision, double precision); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION scale(geometry, double precision, double precision, double precision) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT affine($1,  $2, 0, 0,  0, $3, 0,  0, 0, $4,  0, 0, 0)$_$;


ALTER FUNCTION public.scale(geometry, double precision, double precision, double precision) OWNER TO postgres;

--
-- Name: se_envelopesintersect(geometry, geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION se_envelopesintersect(geometry, geometry) RETURNS boolean
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$ 
	SELECT $1 && $2
	$_$;


ALTER FUNCTION public.se_envelopesintersect(geometry, geometry) OWNER TO postgres;

--
-- Name: se_is3d(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION se_is3d(geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_hasz';


ALTER FUNCTION public.se_is3d(geometry) OWNER TO postgres;

--
-- Name: se_ismeasured(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION se_ismeasured(geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_hasm';


ALTER FUNCTION public.se_ismeasured(geometry) OWNER TO postgres;

--
-- Name: se_locatealong(geometry, double precision); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION se_locatealong(geometry, double precision) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$ SELECT locate_between_measures($1, $2, $2) $_$;


ALTER FUNCTION public.se_locatealong(geometry, double precision) OWNER TO postgres;

--
-- Name: se_locatebetween(geometry, double precision, double precision); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION se_locatebetween(geometry, double precision, double precision) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_locate_between_m';


ALTER FUNCTION public.se_locatebetween(geometry, double precision, double precision) OWNER TO postgres;

--
-- Name: se_m(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION se_m(geometry) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_m_point';


ALTER FUNCTION public.se_m(geometry) OWNER TO postgres;

--
-- Name: se_z(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION se_z(geometry) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_z_point';


ALTER FUNCTION public.se_z(geometry) OWNER TO postgres;

--
-- Name: segmentize(geometry, double precision); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION segmentize(geometry, double precision) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_segmentize2d';


ALTER FUNCTION public.segmentize(geometry, double precision) OWNER TO postgres;

--
-- Name: setfactor(chip, real); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION setfactor(chip, real) RETURNS chip
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'CHIP_setFactor';


ALTER FUNCTION public.setfactor(chip, real) OWNER TO postgres;

--
-- Name: setpoint(geometry, integer, geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION setpoint(geometry, integer, geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_setpoint_linestring';


ALTER FUNCTION public.setpoint(geometry, integer, geometry) OWNER TO postgres;

--
-- Name: setsrid(chip, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION setsrid(chip, integer) RETURNS chip
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'CHIP_setSRID';


ALTER FUNCTION public.setsrid(chip, integer) OWNER TO postgres;

--
-- Name: setsrid(geometry, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION setsrid(geometry, integer) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_setSRID';


ALTER FUNCTION public.setsrid(geometry, integer) OWNER TO postgres;

--
-- Name: shift_longitude(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION shift_longitude(geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_longitude_shift';


ALTER FUNCTION public.shift_longitude(geometry) OWNER TO postgres;

--
-- Name: simplify(geometry, double precision); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION simplify(geometry, double precision) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_simplify2d';


ALTER FUNCTION public.simplify(geometry, double precision) OWNER TO postgres;

--
-- Name: snaptogrid(geometry, double precision); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION snaptogrid(geometry, double precision) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT SnapToGrid($1, 0, 0, $2, $2)$_$;


ALTER FUNCTION public.snaptogrid(geometry, double precision) OWNER TO postgres;

--
-- Name: snaptogrid(geometry, double precision, double precision); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION snaptogrid(geometry, double precision, double precision) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT SnapToGrid($1, 0, 0, $2, $3)$_$;


ALTER FUNCTION public.snaptogrid(geometry, double precision, double precision) OWNER TO postgres;

--
-- Name: snaptogrid(geometry, double precision, double precision, double precision, double precision); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION snaptogrid(geometry, double precision, double precision, double precision, double precision) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_snaptogrid';


ALTER FUNCTION public.snaptogrid(geometry, double precision, double precision, double precision, double precision) OWNER TO postgres;

--
-- Name: snaptogrid(geometry, geometry, double precision, double precision, double precision, double precision); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION snaptogrid(geometry, geometry, double precision, double precision, double precision, double precision) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_snaptogrid_pointoff';


ALTER FUNCTION public.snaptogrid(geometry, geometry, double precision, double precision, double precision, double precision) OWNER TO postgres;

--
-- Name: srid(chip); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION srid(chip) RETURNS integer
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'CHIP_getSRID';


ALTER FUNCTION public.srid(chip) OWNER TO postgres;

--
-- Name: srid(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION srid(geometry) RETURNS integer
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_getSRID';


ALTER FUNCTION public.srid(geometry) OWNER TO postgres;

--
-- Name: st_addmeasure(geometry, double precision, double precision); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_addmeasure(geometry, double precision, double precision) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'ST_AddMeasure';


ALTER FUNCTION public.st_addmeasure(geometry, double precision, double precision) OWNER TO postgres;

--
-- Name: st_addpoint(geometry, geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_addpoint(geometry, geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_addpoint';


ALTER FUNCTION public.st_addpoint(geometry, geometry) OWNER TO postgres;

--
-- Name: st_addpoint(geometry, geometry, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_addpoint(geometry, geometry, integer) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_addpoint';


ALTER FUNCTION public.st_addpoint(geometry, geometry, integer) OWNER TO postgres;

--
-- Name: st_affine(geometry, double precision, double precision, double precision, double precision, double precision, double precision); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_affine(geometry, double precision, double precision, double precision, double precision, double precision, double precision) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT affine($1,  $2, $3, 0,  $4, $5, 0,  0, 0, 1,  $6, $7, 0)$_$;


ALTER FUNCTION public.st_affine(geometry, double precision, double precision, double precision, double precision, double precision, double precision) OWNER TO postgres;

--
-- Name: st_affine(geometry, double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_affine(geometry, double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_affine';


ALTER FUNCTION public.st_affine(geometry, double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision) OWNER TO postgres;

--
-- Name: st_area(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_area(geometry) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_area_polygon';


ALTER FUNCTION public.st_area(geometry) OWNER TO postgres;

--
-- Name: st_area(geography); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_area(geography) RETURNS double precision
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT ST_Area($1, true)$_$;


ALTER FUNCTION public.st_area(geography) OWNER TO postgres;

--
-- Name: st_area(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_area(text) RETURNS double precision
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$ SELECT ST_Area($1::geometry);  $_$;


ALTER FUNCTION public.st_area(text) OWNER TO postgres;

--
-- Name: st_area(geography, boolean); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_area(geography, boolean) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT COST 100
    AS '$libdir/postgis-1.5', 'geography_area';


ALTER FUNCTION public.st_area(geography, boolean) OWNER TO postgres;

--
-- Name: st_area2d(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_area2d(geometry) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_area_polygon';


ALTER FUNCTION public.st_area2d(geometry) OWNER TO postgres;

--
-- Name: st_asbinary(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_asbinary(geometry) RETURNS bytea
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_asBinary';


ALTER FUNCTION public.st_asbinary(geometry) OWNER TO postgres;

--
-- Name: st_asbinary(geography); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_asbinary(geography) RETURNS bytea
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'geography_as_binary';


ALTER FUNCTION public.st_asbinary(geography) OWNER TO postgres;

--
-- Name: st_asbinary(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_asbinary(text) RETURNS bytea
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$ SELECT ST_AsBinary($1::geometry);  $_$;


ALTER FUNCTION public.st_asbinary(text) OWNER TO postgres;

--
-- Name: st_asbinary(geometry, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_asbinary(geometry, text) RETURNS bytea
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_asBinary';


ALTER FUNCTION public.st_asbinary(geometry, text) OWNER TO postgres;

--
-- Name: st_asewkb(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_asewkb(geometry) RETURNS bytea
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'WKBFromLWGEOM';


ALTER FUNCTION public.st_asewkb(geometry) OWNER TO postgres;

--
-- Name: st_asewkb(geometry, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_asewkb(geometry, text) RETURNS bytea
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'WKBFromLWGEOM';


ALTER FUNCTION public.st_asewkb(geometry, text) OWNER TO postgres;

--
-- Name: st_asewkt(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_asewkt(geometry) RETURNS text
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_asEWKT';


ALTER FUNCTION public.st_asewkt(geometry) OWNER TO postgres;

--
-- Name: st_asgeojson(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_asgeojson(geometry) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT _ST_AsGeoJson(1, $1, 15, 0)$_$;


ALTER FUNCTION public.st_asgeojson(geometry) OWNER TO postgres;

--
-- Name: st_asgeojson(geography); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_asgeojson(geography) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT _ST_AsGeoJson(1, $1, 15, 0)$_$;


ALTER FUNCTION public.st_asgeojson(geography) OWNER TO postgres;

--
-- Name: st_asgeojson(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_asgeojson(text) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$ SELECT ST_AsGeoJson($1::geometry);  $_$;


ALTER FUNCTION public.st_asgeojson(text) OWNER TO postgres;

--
-- Name: st_asgeojson(geometry, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_asgeojson(geometry, integer) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT _ST_AsGeoJson(1, $1, $2, 0)$_$;


ALTER FUNCTION public.st_asgeojson(geometry, integer) OWNER TO postgres;

--
-- Name: st_asgeojson(integer, geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_asgeojson(integer, geometry) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT _ST_AsGeoJson($1, $2, 15, 0)$_$;


ALTER FUNCTION public.st_asgeojson(integer, geometry) OWNER TO postgres;

--
-- Name: st_asgeojson(geography, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_asgeojson(geography, integer) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT _ST_AsGeoJson(1, $1, $2, 0)$_$;


ALTER FUNCTION public.st_asgeojson(geography, integer) OWNER TO postgres;

--
-- Name: st_asgeojson(integer, geography); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_asgeojson(integer, geography) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT _ST_AsGeoJson($1, $2, 15, 0)$_$;


ALTER FUNCTION public.st_asgeojson(integer, geography) OWNER TO postgres;

--
-- Name: st_asgeojson(integer, geometry, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_asgeojson(integer, geometry, integer) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT _ST_AsGeoJson($1, $2, $3, 0)$_$;


ALTER FUNCTION public.st_asgeojson(integer, geometry, integer) OWNER TO postgres;

--
-- Name: st_asgeojson(geometry, integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_asgeojson(geometry, integer, integer) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT _ST_AsGeoJson(1, $1, $2, $3)$_$;


ALTER FUNCTION public.st_asgeojson(geometry, integer, integer) OWNER TO postgres;

--
-- Name: st_asgeojson(integer, geography, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_asgeojson(integer, geography, integer) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT _ST_AsGeoJson($1, $2, $3, 0)$_$;


ALTER FUNCTION public.st_asgeojson(integer, geography, integer) OWNER TO postgres;

--
-- Name: st_asgeojson(geography, integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_asgeojson(geography, integer, integer) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT _ST_AsGeoJson(1, $1, $2, $3)$_$;


ALTER FUNCTION public.st_asgeojson(geography, integer, integer) OWNER TO postgres;

--
-- Name: st_asgeojson(integer, geometry, integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_asgeojson(integer, geometry, integer, integer) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT _ST_AsGeoJson($1, $2, $3, $4)$_$;


ALTER FUNCTION public.st_asgeojson(integer, geometry, integer, integer) OWNER TO postgres;

--
-- Name: st_asgeojson(integer, geography, integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_asgeojson(integer, geography, integer, integer) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT _ST_AsGeoJson($1, $2, $3, $4)$_$;


ALTER FUNCTION public.st_asgeojson(integer, geography, integer, integer) OWNER TO postgres;

--
-- Name: st_asgml(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_asgml(geometry) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT _ST_AsGML(2, $1, 15, 0)$_$;


ALTER FUNCTION public.st_asgml(geometry) OWNER TO postgres;

--
-- Name: st_asgml(geography); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_asgml(geography) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT _ST_AsGML(2, $1, 15, 0)$_$;


ALTER FUNCTION public.st_asgml(geography) OWNER TO postgres;

--
-- Name: st_asgml(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_asgml(text) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$ SELECT ST_AsGML($1::geometry);  $_$;


ALTER FUNCTION public.st_asgml(text) OWNER TO postgres;

--
-- Name: st_asgml(geometry, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_asgml(geometry, integer) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT _ST_AsGML(2, $1, $2, 0)$_$;


ALTER FUNCTION public.st_asgml(geometry, integer) OWNER TO postgres;

--
-- Name: st_asgml(integer, geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_asgml(integer, geometry) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT _ST_AsGML($1, $2, 15, 0)$_$;


ALTER FUNCTION public.st_asgml(integer, geometry) OWNER TO postgres;

--
-- Name: st_asgml(geography, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_asgml(geography, integer) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT _ST_AsGML(2, $1, $2, 0)$_$;


ALTER FUNCTION public.st_asgml(geography, integer) OWNER TO postgres;

--
-- Name: st_asgml(integer, geography); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_asgml(integer, geography) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT _ST_AsGML($1, $2, 15, 0)$_$;


ALTER FUNCTION public.st_asgml(integer, geography) OWNER TO postgres;

--
-- Name: st_asgml(integer, geometry, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_asgml(integer, geometry, integer) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT _ST_AsGML($1, $2, $3, 0)$_$;


ALTER FUNCTION public.st_asgml(integer, geometry, integer) OWNER TO postgres;

--
-- Name: st_asgml(geometry, integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_asgml(geometry, integer, integer) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT _ST_AsGML(2, $1, $2, $3)$_$;


ALTER FUNCTION public.st_asgml(geometry, integer, integer) OWNER TO postgres;

--
-- Name: st_asgml(integer, geography, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_asgml(integer, geography, integer) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT _ST_AsGML($1, $2, $3, 0)$_$;


ALTER FUNCTION public.st_asgml(integer, geography, integer) OWNER TO postgres;

--
-- Name: st_asgml(geography, integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_asgml(geography, integer, integer) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT _ST_AsGML(2, $1, $2, $3)$_$;


ALTER FUNCTION public.st_asgml(geography, integer, integer) OWNER TO postgres;

--
-- Name: st_asgml(integer, geometry, integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_asgml(integer, geometry, integer, integer) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT _ST_AsGML($1, $2, $3, $4)$_$;


ALTER FUNCTION public.st_asgml(integer, geometry, integer, integer) OWNER TO postgres;

--
-- Name: st_asgml(integer, geography, integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_asgml(integer, geography, integer, integer) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT _ST_AsGML($1, $2, $3, $4)$_$;


ALTER FUNCTION public.st_asgml(integer, geography, integer, integer) OWNER TO postgres;

--
-- Name: st_ashexewkb(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_ashexewkb(geometry) RETURNS text
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_asHEXEWKB';


ALTER FUNCTION public.st_ashexewkb(geometry) OWNER TO postgres;

--
-- Name: st_ashexewkb(geometry, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_ashexewkb(geometry, text) RETURNS text
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_asHEXEWKB';


ALTER FUNCTION public.st_ashexewkb(geometry, text) OWNER TO postgres;

--
-- Name: st_askml(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_askml(geometry) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT _ST_AsKML(2, ST_Transform($1,4326), 15)$_$;


ALTER FUNCTION public.st_askml(geometry) OWNER TO postgres;

--
-- Name: st_askml(geography); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_askml(geography) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT _ST_AsKML(2, $1, 15)$_$;


ALTER FUNCTION public.st_askml(geography) OWNER TO postgres;

--
-- Name: st_askml(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_askml(text) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$ SELECT ST_AsKML($1::geometry);  $_$;


ALTER FUNCTION public.st_askml(text) OWNER TO postgres;

--
-- Name: st_askml(geometry, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_askml(geometry, integer) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT _ST_AsKML(2, ST_Transform($1,4326), $2)$_$;


ALTER FUNCTION public.st_askml(geometry, integer) OWNER TO postgres;

--
-- Name: st_askml(integer, geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_askml(integer, geometry) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT _ST_AsKML($1, ST_Transform($2,4326), 15)$_$;


ALTER FUNCTION public.st_askml(integer, geometry) OWNER TO postgres;

--
-- Name: st_askml(geography, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_askml(geography, integer) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT _ST_AsKML(2, $1, $2)$_$;


ALTER FUNCTION public.st_askml(geography, integer) OWNER TO postgres;

--
-- Name: st_askml(integer, geography); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_askml(integer, geography) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT _ST_AsKML($1, $2, 15)$_$;


ALTER FUNCTION public.st_askml(integer, geography) OWNER TO postgres;

--
-- Name: st_askml(integer, geometry, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_askml(integer, geometry, integer) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT _ST_AsKML($1, ST_Transform($2,4326), $3)$_$;


ALTER FUNCTION public.st_askml(integer, geometry, integer) OWNER TO postgres;

--
-- Name: st_askml(integer, geography, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_askml(integer, geography, integer) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT _ST_AsKML($1, $2, $3)$_$;


ALTER FUNCTION public.st_askml(integer, geography, integer) OWNER TO postgres;

--
-- Name: st_assvg(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_assvg(geometry) RETURNS text
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'assvg_geometry';


ALTER FUNCTION public.st_assvg(geometry) OWNER TO postgres;

--
-- Name: st_assvg(geography); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_assvg(geography) RETURNS text
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'geography_as_svg';


ALTER FUNCTION public.st_assvg(geography) OWNER TO postgres;

--
-- Name: st_assvg(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_assvg(text) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$ SELECT ST_AsSVG($1::geometry);  $_$;


ALTER FUNCTION public.st_assvg(text) OWNER TO postgres;

--
-- Name: st_assvg(geometry, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_assvg(geometry, integer) RETURNS text
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'assvg_geometry';


ALTER FUNCTION public.st_assvg(geometry, integer) OWNER TO postgres;

--
-- Name: st_assvg(geography, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_assvg(geography, integer) RETURNS text
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'geography_as_svg';


ALTER FUNCTION public.st_assvg(geography, integer) OWNER TO postgres;

--
-- Name: st_assvg(geometry, integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_assvg(geometry, integer, integer) RETURNS text
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'assvg_geometry';


ALTER FUNCTION public.st_assvg(geometry, integer, integer) OWNER TO postgres;

--
-- Name: st_assvg(geography, integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_assvg(geography, integer, integer) RETURNS text
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'geography_as_svg';


ALTER FUNCTION public.st_assvg(geography, integer, integer) OWNER TO postgres;

--
-- Name: st_astext(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_astext(geometry) RETURNS text
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_asText';


ALTER FUNCTION public.st_astext(geometry) OWNER TO postgres;

--
-- Name: st_astext(geography); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_astext(geography) RETURNS text
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'geography_as_text';


ALTER FUNCTION public.st_astext(geography) OWNER TO postgres;

--
-- Name: st_astext(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_astext(text) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$ SELECT ST_AsText($1::geometry);  $_$;


ALTER FUNCTION public.st_astext(text) OWNER TO postgres;

--
-- Name: st_azimuth(geometry, geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_azimuth(geometry, geometry) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_azimuth';


ALTER FUNCTION public.st_azimuth(geometry, geometry) OWNER TO postgres;

--
-- Name: st_bdmpolyfromtext(text, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_bdmpolyfromtext(text, integer) RETURNS geometry
    LANGUAGE plpgsql IMMUTABLE STRICT
    AS $_$
DECLARE
	geomtext alias for $1;
	srid alias for $2;
	mline geometry;
	geom geometry;
BEGIN
	mline := ST_MultiLineStringFromText(geomtext, srid);

	IF mline IS NULL
	THEN
		RAISE EXCEPTION 'Input is not a MultiLinestring';
	END IF;

	geom := multi(ST_BuildArea(mline));

	RETURN geom;
END;
$_$;


ALTER FUNCTION public.st_bdmpolyfromtext(text, integer) OWNER TO postgres;

--
-- Name: st_bdpolyfromtext(text, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_bdpolyfromtext(text, integer) RETURNS geometry
    LANGUAGE plpgsql IMMUTABLE STRICT
    AS $_$
DECLARE
	geomtext alias for $1;
	srid alias for $2;
	mline geometry;
	geom geometry;
BEGIN
	mline := ST_MultiLineStringFromText(geomtext, srid);

	IF mline IS NULL
	THEN
		RAISE EXCEPTION 'Input is not a MultiLinestring';
	END IF;

	geom := ST_BuildArea(mline);

	IF GeometryType(geom) != 'POLYGON'
	THEN
		RAISE EXCEPTION 'Input returns more then a single polygon, try using BdMPolyFromText instead';
	END IF;

	RETURN geom;
END;
$_$;


ALTER FUNCTION public.st_bdpolyfromtext(text, integer) OWNER TO postgres;

--
-- Name: st_boundary(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_boundary(geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'boundary';


ALTER FUNCTION public.st_boundary(geometry) OWNER TO postgres;

--
-- Name: st_box(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_box(geometry) RETURNS box
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_to_BOX';


ALTER FUNCTION public.st_box(geometry) OWNER TO postgres;

--
-- Name: st_box(box3d); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_box(box3d) RETURNS box
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'BOX3D_to_BOX';


ALTER FUNCTION public.st_box(box3d) OWNER TO postgres;

--
-- Name: st_box2d(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_box2d(geometry) RETURNS box2d
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_to_BOX2DFLOAT4';


ALTER FUNCTION public.st_box2d(geometry) OWNER TO postgres;

--
-- Name: st_box2d(box3d); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_box2d(box3d) RETURNS box2d
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'BOX3D_to_BOX2DFLOAT4';


ALTER FUNCTION public.st_box2d(box3d) OWNER TO postgres;

--
-- Name: st_box2d(box3d_extent); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_box2d(box3d_extent) RETURNS box2d
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'BOX3D_to_BOX2DFLOAT4';


ALTER FUNCTION public.st_box2d(box3d_extent) OWNER TO postgres;

--
-- Name: st_box2d_in(cstring); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_box2d_in(cstring) RETURNS box2d
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'BOX2DFLOAT4_in';


ALTER FUNCTION public.st_box2d_in(cstring) OWNER TO postgres;

--
-- Name: st_box2d_out(box2d); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_box2d_out(box2d) RETURNS cstring
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'BOX2DFLOAT4_out';


ALTER FUNCTION public.st_box2d_out(box2d) OWNER TO postgres;

--
-- Name: st_box3d(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_box3d(geometry) RETURNS box3d
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_to_BOX3D';


ALTER FUNCTION public.st_box3d(geometry) OWNER TO postgres;

--
-- Name: st_box3d(box2d); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_box3d(box2d) RETURNS box3d
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'BOX2DFLOAT4_to_BOX3D';


ALTER FUNCTION public.st_box3d(box2d) OWNER TO postgres;

--
-- Name: st_box3d_extent(box3d_extent); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_box3d_extent(box3d_extent) RETURNS box3d
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'BOX3D_extent_to_BOX3D';


ALTER FUNCTION public.st_box3d_extent(box3d_extent) OWNER TO postgres;

--
-- Name: st_box3d_in(cstring); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_box3d_in(cstring) RETURNS box3d
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'BOX3D_in';


ALTER FUNCTION public.st_box3d_in(cstring) OWNER TO postgres;

--
-- Name: st_box3d_out(box3d); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_box3d_out(box3d) RETURNS cstring
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'BOX3D_out';


ALTER FUNCTION public.st_box3d_out(box3d) OWNER TO postgres;

--
-- Name: st_buffer(geometry, double precision); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_buffer(geometry, double precision) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT COST 100
    AS '$libdir/postgis-1.5', 'buffer';


ALTER FUNCTION public.st_buffer(geometry, double precision) OWNER TO postgres;

--
-- Name: st_buffer(geography, double precision); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_buffer(geography, double precision) RETURNS geography
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT geography(ST_Transform(ST_Buffer(ST_Transform(geometry($1), _ST_BestSRID($1)), $2), 4326))$_$;


ALTER FUNCTION public.st_buffer(geography, double precision) OWNER TO postgres;

--
-- Name: st_buffer(text, double precision); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_buffer(text, double precision) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$ SELECT ST_Buffer($1::geometry, $2);  $_$;


ALTER FUNCTION public.st_buffer(text, double precision) OWNER TO postgres;

--
-- Name: st_buffer(geometry, double precision, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_buffer(geometry, double precision, integer) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$ SELECT _ST_Buffer($1, $2,
		CAST('quad_segs='||CAST($3 AS text) as cstring))
	   $_$;


ALTER FUNCTION public.st_buffer(geometry, double precision, integer) OWNER TO postgres;

--
-- Name: st_buffer(geometry, double precision, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_buffer(geometry, double precision, text) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$ SELECT _ST_Buffer($1, $2,
		CAST( regexp_replace($3, '^[0123456789]+$',
			'quad_segs='||$3) AS cstring)
		)
	   $_$;


ALTER FUNCTION public.st_buffer(geometry, double precision, text) OWNER TO postgres;

--
-- Name: st_buildarea(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_buildarea(geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT COST 100
    AS '$libdir/postgis-1.5', 'LWGEOM_buildarea';


ALTER FUNCTION public.st_buildarea(geometry) OWNER TO postgres;

--
-- Name: st_bytea(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_bytea(geometry) RETURNS bytea
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_to_bytea';


ALTER FUNCTION public.st_bytea(geometry) OWNER TO postgres;

--
-- Name: st_centroid(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_centroid(geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'centroid';


ALTER FUNCTION public.st_centroid(geometry) OWNER TO postgres;

--
-- Name: st_chip_in(cstring); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_chip_in(cstring) RETURNS chip
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'CHIP_in';


ALTER FUNCTION public.st_chip_in(cstring) OWNER TO postgres;

--
-- Name: st_chip_out(chip); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_chip_out(chip) RETURNS cstring
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'CHIP_out';


ALTER FUNCTION public.st_chip_out(chip) OWNER TO postgres;

--
-- Name: st_closestpoint(geometry, geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_closestpoint(geometry, geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_closestpoint';


ALTER FUNCTION public.st_closestpoint(geometry, geometry) OWNER TO postgres;

--
-- Name: st_collect(geometry[]); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_collect(geometry[]) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_collect_garray';


ALTER FUNCTION public.st_collect(geometry[]) OWNER TO postgres;

--
-- Name: st_collect(geometry, geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_collect(geometry, geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE
    AS '$libdir/postgis-1.5', 'LWGEOM_collect';


ALTER FUNCTION public.st_collect(geometry, geometry) OWNER TO postgres;

--
-- Name: st_collectionextract(geometry, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_collectionextract(geometry, integer) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'ST_CollectionExtract';


ALTER FUNCTION public.st_collectionextract(geometry, integer) OWNER TO postgres;

--
-- Name: st_combine_bbox(box2d, geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_combine_bbox(box2d, geometry) RETURNS box2d
    LANGUAGE c IMMUTABLE
    AS '$libdir/postgis-1.5', 'BOX2DFLOAT4_combine';


ALTER FUNCTION public.st_combine_bbox(box2d, geometry) OWNER TO postgres;

--
-- Name: st_combine_bbox(box3d_extent, geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_combine_bbox(box3d_extent, geometry) RETURNS box3d_extent
    LANGUAGE c IMMUTABLE
    AS '$libdir/postgis-1.5', 'BOX3D_combine';


ALTER FUNCTION public.st_combine_bbox(box3d_extent, geometry) OWNER TO postgres;

--
-- Name: st_combine_bbox(box3d, geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_combine_bbox(box3d, geometry) RETURNS box3d
    LANGUAGE c IMMUTABLE
    AS '$libdir/postgis-1.5', 'BOX3D_combine';


ALTER FUNCTION public.st_combine_bbox(box3d, geometry) OWNER TO postgres;

--
-- Name: st_compression(chip); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_compression(chip) RETURNS integer
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'CHIP_getCompression';


ALTER FUNCTION public.st_compression(chip) OWNER TO postgres;

--
-- Name: st_contains(geometry, geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_contains(geometry, geometry) RETURNS boolean
    LANGUAGE sql IMMUTABLE
    AS $_$SELECT $1 && $2 AND _ST_Contains($1,$2)$_$;


ALTER FUNCTION public.st_contains(geometry, geometry) OWNER TO postgres;

--
-- Name: st_containsproperly(geometry, geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_containsproperly(geometry, geometry) RETURNS boolean
    LANGUAGE sql IMMUTABLE
    AS $_$SELECT $1 && $2 AND _ST_ContainsProperly($1,$2)$_$;


ALTER FUNCTION public.st_containsproperly(geometry, geometry) OWNER TO postgres;

--
-- Name: st_convexhull(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_convexhull(geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT COST 100
    AS '$libdir/postgis-1.5', 'convexhull';


ALTER FUNCTION public.st_convexhull(geometry) OWNER TO postgres;

--
-- Name: st_coorddim(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_coorddim(geometry) RETURNS smallint
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_ndims';


ALTER FUNCTION public.st_coorddim(geometry) OWNER TO postgres;

--
-- Name: st_coveredby(geometry, geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_coveredby(geometry, geometry) RETURNS boolean
    LANGUAGE sql IMMUTABLE
    AS $_$SELECT $1 && $2 AND _ST_CoveredBy($1,$2)$_$;


ALTER FUNCTION public.st_coveredby(geometry, geometry) OWNER TO postgres;

--
-- Name: st_coveredby(geography, geography); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_coveredby(geography, geography) RETURNS boolean
    LANGUAGE sql IMMUTABLE
    AS $_$SELECT $1 && $2 AND _ST_Covers($2, $1)$_$;


ALTER FUNCTION public.st_coveredby(geography, geography) OWNER TO postgres;

--
-- Name: st_coveredby(text, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_coveredby(text, text) RETURNS boolean
    LANGUAGE sql IMMUTABLE
    AS $_$ SELECT ST_CoveredBy($1::geometry, $2::geometry);  $_$;


ALTER FUNCTION public.st_coveredby(text, text) OWNER TO postgres;

--
-- Name: st_covers(geometry, geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_covers(geometry, geometry) RETURNS boolean
    LANGUAGE sql IMMUTABLE
    AS $_$SELECT $1 && $2 AND _ST_Covers($1,$2)$_$;


ALTER FUNCTION public.st_covers(geometry, geometry) OWNER TO postgres;

--
-- Name: st_covers(geography, geography); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_covers(geography, geography) RETURNS boolean
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT $1 && $2 AND _ST_Covers($1, $2)$_$;


ALTER FUNCTION public.st_covers(geography, geography) OWNER TO postgres;

--
-- Name: st_covers(text, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_covers(text, text) RETURNS boolean
    LANGUAGE sql IMMUTABLE
    AS $_$ SELECT ST_Covers($1::geometry, $2::geometry);  $_$;


ALTER FUNCTION public.st_covers(text, text) OWNER TO postgres;

--
-- Name: st_crosses(geometry, geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_crosses(geometry, geometry) RETURNS boolean
    LANGUAGE sql IMMUTABLE
    AS $_$SELECT $1 && $2 AND _ST_Crosses($1,$2)$_$;


ALTER FUNCTION public.st_crosses(geometry, geometry) OWNER TO postgres;

--
-- Name: st_curvetoline(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_curvetoline(geometry) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT ST_CurveToLine($1, 32)$_$;


ALTER FUNCTION public.st_curvetoline(geometry) OWNER TO postgres;

--
-- Name: st_curvetoline(geometry, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_curvetoline(geometry, integer) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_curve_segmentize';


ALTER FUNCTION public.st_curvetoline(geometry, integer) OWNER TO postgres;

--
-- Name: st_datatype(chip); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_datatype(chip) RETURNS integer
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'CHIP_getDatatype';


ALTER FUNCTION public.st_datatype(chip) OWNER TO postgres;

--
-- Name: st_dfullywithin(geometry, geometry, double precision); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_dfullywithin(geometry, geometry, double precision) RETURNS boolean
    LANGUAGE sql IMMUTABLE
    AS $_$SELECT $1 && ST_Expand($2,$3) AND $2 && ST_Expand($1,$3) AND _ST_DFullyWithin(ST_ConvexHull($1), ST_ConvexHull($2), $3)$_$;


ALTER FUNCTION public.st_dfullywithin(geometry, geometry, double precision) OWNER TO postgres;

--
-- Name: st_difference(geometry, geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_difference(geometry, geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'difference';


ALTER FUNCTION public.st_difference(geometry, geometry) OWNER TO postgres;

--
-- Name: st_dimension(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_dimension(geometry) RETURNS integer
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_dimension';


ALTER FUNCTION public.st_dimension(geometry) OWNER TO postgres;

--
-- Name: st_disjoint(geometry, geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_disjoint(geometry, geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'disjoint';


ALTER FUNCTION public.st_disjoint(geometry, geometry) OWNER TO postgres;

--
-- Name: st_distance(geometry, geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_distance(geometry, geometry) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT COST 100
    AS '$libdir/postgis-1.5', 'LWGEOM_mindistance2d';


ALTER FUNCTION public.st_distance(geometry, geometry) OWNER TO postgres;

--
-- Name: st_distance(geography, geography); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_distance(geography, geography) RETURNS double precision
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT _ST_Distance($1, $2, 0.0, true)$_$;


ALTER FUNCTION public.st_distance(geography, geography) OWNER TO postgres;

--
-- Name: st_distance(text, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_distance(text, text) RETURNS double precision
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$ SELECT ST_Distance($1::geometry, $2::geometry);  $_$;


ALTER FUNCTION public.st_distance(text, text) OWNER TO postgres;

--
-- Name: st_distance(geography, geography, boolean); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_distance(geography, geography, boolean) RETURNS double precision
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT _ST_Distance($1, $2, 0.0, $3)$_$;


ALTER FUNCTION public.st_distance(geography, geography, boolean) OWNER TO postgres;

--
-- Name: st_distance_sphere(geometry, geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_distance_sphere(geometry, geometry) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT COST 100
    AS '$libdir/postgis-1.5', 'LWGEOM_distance_sphere';


ALTER FUNCTION public.st_distance_sphere(geometry, geometry) OWNER TO postgres;

--
-- Name: st_distance_spheroid(geometry, geometry, spheroid); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_distance_spheroid(geometry, geometry, spheroid) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT COST 100
    AS '$libdir/postgis-1.5', 'LWGEOM_distance_ellipsoid';


ALTER FUNCTION public.st_distance_spheroid(geometry, geometry, spheroid) OWNER TO postgres;

--
-- Name: st_dump(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_dump(geometry) RETURNS SETOF geometry_dump
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_dump';


ALTER FUNCTION public.st_dump(geometry) OWNER TO postgres;

--
-- Name: st_dumppoints(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_dumppoints(geometry) RETURNS SETOF geometry_dump
    LANGUAGE sql STRICT
    AS $_$
  SELECT * FROM _ST_DumpPoints($1, NULL);
$_$;


ALTER FUNCTION public.st_dumppoints(geometry) OWNER TO postgres;

--
-- Name: st_dumprings(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_dumprings(geometry) RETURNS SETOF geometry_dump
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_dump_rings';


ALTER FUNCTION public.st_dumprings(geometry) OWNER TO postgres;

--
-- Name: st_dwithin(geometry, geometry, double precision); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_dwithin(geometry, geometry, double precision) RETURNS boolean
    LANGUAGE sql IMMUTABLE
    AS $_$SELECT $1 && ST_Expand($2,$3) AND $2 && ST_Expand($1,$3) AND _ST_DWithin($1, $2, $3)$_$;


ALTER FUNCTION public.st_dwithin(geometry, geometry, double precision) OWNER TO postgres;

--
-- Name: st_dwithin(geography, geography, double precision); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_dwithin(geography, geography, double precision) RETURNS boolean
    LANGUAGE sql IMMUTABLE
    AS $_$SELECT $1 && _ST_Expand($2,$3) AND $2 && _ST_Expand($1,$3) AND _ST_DWithin($1, $2, $3, true)$_$;


ALTER FUNCTION public.st_dwithin(geography, geography, double precision) OWNER TO postgres;

--
-- Name: st_dwithin(text, text, double precision); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_dwithin(text, text, double precision) RETURNS boolean
    LANGUAGE sql IMMUTABLE
    AS $_$ SELECT ST_DWithin($1::geometry, $2::geometry, $3);  $_$;


ALTER FUNCTION public.st_dwithin(text, text, double precision) OWNER TO postgres;

--
-- Name: st_dwithin(geography, geography, double precision, boolean); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_dwithin(geography, geography, double precision, boolean) RETURNS boolean
    LANGUAGE sql IMMUTABLE
    AS $_$SELECT $1 && _ST_Expand($2,$3) AND $2 && _ST_Expand($1,$3) AND _ST_DWithin($1, $2, $3, $4)$_$;


ALTER FUNCTION public.st_dwithin(geography, geography, double precision, boolean) OWNER TO postgres;

--
-- Name: st_endpoint(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_endpoint(geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_endpoint_linestring';


ALTER FUNCTION public.st_endpoint(geometry) OWNER TO postgres;

--
-- Name: st_envelope(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_envelope(geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_envelope';


ALTER FUNCTION public.st_envelope(geometry) OWNER TO postgres;

--
-- Name: st_equals(geometry, geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_equals(geometry, geometry) RETURNS boolean
    LANGUAGE sql IMMUTABLE
    AS $_$SELECT $1 && $2 AND _ST_Equals($1,$2)$_$;


ALTER FUNCTION public.st_equals(geometry, geometry) OWNER TO postgres;

--
-- Name: st_estimated_extent(text, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_estimated_extent(text, text) RETURNS box2d
    LANGUAGE c IMMUTABLE STRICT SECURITY DEFINER
    AS '$libdir/postgis-1.5', 'LWGEOM_estimated_extent';


ALTER FUNCTION public.st_estimated_extent(text, text) OWNER TO postgres;

--
-- Name: st_estimated_extent(text, text, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_estimated_extent(text, text, text) RETURNS box2d
    LANGUAGE c IMMUTABLE STRICT SECURITY DEFINER
    AS '$libdir/postgis-1.5', 'LWGEOM_estimated_extent';


ALTER FUNCTION public.st_estimated_extent(text, text, text) OWNER TO postgres;

--
-- Name: st_expand(box3d, double precision); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_expand(box3d, double precision) RETURNS box3d
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'BOX3D_expand';


ALTER FUNCTION public.st_expand(box3d, double precision) OWNER TO postgres;

--
-- Name: st_expand(box2d, double precision); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_expand(box2d, double precision) RETURNS box2d
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'BOX2DFLOAT4_expand';


ALTER FUNCTION public.st_expand(box2d, double precision) OWNER TO postgres;

--
-- Name: st_expand(geometry, double precision); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_expand(geometry, double precision) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_expand';


ALTER FUNCTION public.st_expand(geometry, double precision) OWNER TO postgres;

--
-- Name: st_exteriorring(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_exteriorring(geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_exteriorring_polygon';


ALTER FUNCTION public.st_exteriorring(geometry) OWNER TO postgres;

--
-- Name: st_factor(chip); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_factor(chip) RETURNS real
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'CHIP_getFactor';


ALTER FUNCTION public.st_factor(chip) OWNER TO postgres;

--
-- Name: st_find_extent(text, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_find_extent(text, text) RETURNS box2d
    LANGUAGE plpgsql IMMUTABLE STRICT
    AS $_$
DECLARE
	tablename alias for $1;
	columnname alias for $2;
	myrec RECORD;

BEGIN
	FOR myrec IN EXECUTE 'SELECT extent("' || columnname || '") FROM "' || tablename || '"' LOOP
		return myrec.extent;
	END LOOP;
END;
$_$;


ALTER FUNCTION public.st_find_extent(text, text) OWNER TO postgres;

--
-- Name: st_find_extent(text, text, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_find_extent(text, text, text) RETURNS box2d
    LANGUAGE plpgsql IMMUTABLE STRICT
    AS $_$
DECLARE
	schemaname alias for $1;
	tablename alias for $2;
	columnname alias for $3;
	myrec RECORD;

BEGIN
	FOR myrec IN EXECUTE 'SELECT extent("' || columnname || '") FROM "' || schemaname || '"."' || tablename || '"' LOOP
		return myrec.extent;
	END LOOP;
END;
$_$;


ALTER FUNCTION public.st_find_extent(text, text, text) OWNER TO postgres;

--
-- Name: st_force_2d(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_force_2d(geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_force_2d';


ALTER FUNCTION public.st_force_2d(geometry) OWNER TO postgres;

--
-- Name: st_force_3d(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_force_3d(geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_force_3dz';


ALTER FUNCTION public.st_force_3d(geometry) OWNER TO postgres;

--
-- Name: st_force_3dm(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_force_3dm(geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_force_3dm';


ALTER FUNCTION public.st_force_3dm(geometry) OWNER TO postgres;

--
-- Name: st_force_3dz(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_force_3dz(geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_force_3dz';


ALTER FUNCTION public.st_force_3dz(geometry) OWNER TO postgres;

--
-- Name: st_force_4d(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_force_4d(geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_force_4d';


ALTER FUNCTION public.st_force_4d(geometry) OWNER TO postgres;

--
-- Name: st_force_collection(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_force_collection(geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_force_collection';


ALTER FUNCTION public.st_force_collection(geometry) OWNER TO postgres;

--
-- Name: st_forcerhr(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_forcerhr(geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_forceRHR_poly';


ALTER FUNCTION public.st_forcerhr(geometry) OWNER TO postgres;

--
-- Name: st_geogfromtext(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_geogfromtext(text) RETURNS geography
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'geography_from_text';


ALTER FUNCTION public.st_geogfromtext(text) OWNER TO postgres;

--
-- Name: st_geogfromwkb(bytea); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_geogfromwkb(bytea) RETURNS geography
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'geography_from_binary';


ALTER FUNCTION public.st_geogfromwkb(bytea) OWNER TO postgres;

--
-- Name: st_geographyfromtext(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_geographyfromtext(text) RETURNS geography
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'geography_from_text';


ALTER FUNCTION public.st_geographyfromtext(text) OWNER TO postgres;

--
-- Name: st_geohash(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_geohash(geometry) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT ST_GeoHash($1, 0)$_$;


ALTER FUNCTION public.st_geohash(geometry) OWNER TO postgres;

--
-- Name: st_geohash(geometry, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_geohash(geometry, integer) RETURNS text
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'ST_GeoHash';


ALTER FUNCTION public.st_geohash(geometry, integer) OWNER TO postgres;

--
-- Name: st_geomcollfromtext(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_geomcollfromtext(text) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE
	WHEN geometrytype(ST_GeomFromText($1)) = 'GEOMETRYCOLLECTION'
	THEN ST_GeomFromText($1)
	ELSE NULL END
	$_$;


ALTER FUNCTION public.st_geomcollfromtext(text) OWNER TO postgres;

--
-- Name: st_geomcollfromtext(text, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_geomcollfromtext(text, integer) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE
	WHEN geometrytype(ST_GeomFromText($1, $2)) = 'GEOMETRYCOLLECTION'
	THEN ST_GeomFromText($1,$2)
	ELSE NULL END
	$_$;


ALTER FUNCTION public.st_geomcollfromtext(text, integer) OWNER TO postgres;

--
-- Name: st_geomcollfromwkb(bytea); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_geomcollfromwkb(bytea) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE
	WHEN geometrytype(ST_GeomFromWKB($1)) = 'GEOMETRYCOLLECTION'
	THEN ST_GeomFromWKB($1)
	ELSE NULL END
	$_$;


ALTER FUNCTION public.st_geomcollfromwkb(bytea) OWNER TO postgres;

--
-- Name: st_geomcollfromwkb(bytea, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_geomcollfromwkb(bytea, integer) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE
	WHEN geometrytype(GeomFromWKB($1, $2)) = 'GEOMETRYCOLLECTION'
	THEN GeomFromWKB($1, $2)
	ELSE NULL END
	$_$;


ALTER FUNCTION public.st_geomcollfromwkb(bytea, integer) OWNER TO postgres;

--
-- Name: st_geometry(box2d); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_geometry(box2d) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'BOX2DFLOAT4_to_LWGEOM';


ALTER FUNCTION public.st_geometry(box2d) OWNER TO postgres;

--
-- Name: st_geometry(box3d); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_geometry(box3d) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'BOX3D_to_LWGEOM';


ALTER FUNCTION public.st_geometry(box3d) OWNER TO postgres;

--
-- Name: st_geometry(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_geometry(text) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'parse_WKT_lwgeom';


ALTER FUNCTION public.st_geometry(text) OWNER TO postgres;

--
-- Name: st_geometry(chip); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_geometry(chip) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'CHIP_to_LWGEOM';


ALTER FUNCTION public.st_geometry(chip) OWNER TO postgres;

--
-- Name: st_geometry(bytea); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_geometry(bytea) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_from_bytea';


ALTER FUNCTION public.st_geometry(bytea) OWNER TO postgres;

--
-- Name: st_geometry(box3d_extent); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_geometry(box3d_extent) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'BOX3D_to_LWGEOM';


ALTER FUNCTION public.st_geometry(box3d_extent) OWNER TO postgres;

--
-- Name: st_geometry_above(geometry, geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_geometry_above(geometry, geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_above';


ALTER FUNCTION public.st_geometry_above(geometry, geometry) OWNER TO postgres;

--
-- Name: st_geometry_analyze(internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_geometry_analyze(internal) RETURNS boolean
    LANGUAGE c STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_analyze';


ALTER FUNCTION public.st_geometry_analyze(internal) OWNER TO postgres;

--
-- Name: st_geometry_below(geometry, geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_geometry_below(geometry, geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_below';


ALTER FUNCTION public.st_geometry_below(geometry, geometry) OWNER TO postgres;

--
-- Name: st_geometry_cmp(geometry, geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_geometry_cmp(geometry, geometry) RETURNS integer
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'lwgeom_cmp';


ALTER FUNCTION public.st_geometry_cmp(geometry, geometry) OWNER TO postgres;

--
-- Name: st_geometry_contain(geometry, geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_geometry_contain(geometry, geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_contain';


ALTER FUNCTION public.st_geometry_contain(geometry, geometry) OWNER TO postgres;

--
-- Name: st_geometry_contained(geometry, geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_geometry_contained(geometry, geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_contained';


ALTER FUNCTION public.st_geometry_contained(geometry, geometry) OWNER TO postgres;

--
-- Name: st_geometry_eq(geometry, geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_geometry_eq(geometry, geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'lwgeom_eq';


ALTER FUNCTION public.st_geometry_eq(geometry, geometry) OWNER TO postgres;

--
-- Name: st_geometry_ge(geometry, geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_geometry_ge(geometry, geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'lwgeom_ge';


ALTER FUNCTION public.st_geometry_ge(geometry, geometry) OWNER TO postgres;

--
-- Name: st_geometry_gt(geometry, geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_geometry_gt(geometry, geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'lwgeom_gt';


ALTER FUNCTION public.st_geometry_gt(geometry, geometry) OWNER TO postgres;

--
-- Name: st_geometry_in(cstring); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_geometry_in(cstring) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_in';


ALTER FUNCTION public.st_geometry_in(cstring) OWNER TO postgres;

--
-- Name: st_geometry_le(geometry, geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_geometry_le(geometry, geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'lwgeom_le';


ALTER FUNCTION public.st_geometry_le(geometry, geometry) OWNER TO postgres;

--
-- Name: st_geometry_left(geometry, geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_geometry_left(geometry, geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_left';


ALTER FUNCTION public.st_geometry_left(geometry, geometry) OWNER TO postgres;

--
-- Name: st_geometry_lt(geometry, geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_geometry_lt(geometry, geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'lwgeom_lt';


ALTER FUNCTION public.st_geometry_lt(geometry, geometry) OWNER TO postgres;

--
-- Name: st_geometry_out(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_geometry_out(geometry) RETURNS cstring
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_out';


ALTER FUNCTION public.st_geometry_out(geometry) OWNER TO postgres;

--
-- Name: st_geometry_overabove(geometry, geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_geometry_overabove(geometry, geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_overabove';


ALTER FUNCTION public.st_geometry_overabove(geometry, geometry) OWNER TO postgres;

--
-- Name: st_geometry_overbelow(geometry, geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_geometry_overbelow(geometry, geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_overbelow';


ALTER FUNCTION public.st_geometry_overbelow(geometry, geometry) OWNER TO postgres;

--
-- Name: st_geometry_overlap(geometry, geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_geometry_overlap(geometry, geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_overlap';


ALTER FUNCTION public.st_geometry_overlap(geometry, geometry) OWNER TO postgres;

--
-- Name: st_geometry_overleft(geometry, geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_geometry_overleft(geometry, geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_overleft';


ALTER FUNCTION public.st_geometry_overleft(geometry, geometry) OWNER TO postgres;

--
-- Name: st_geometry_overright(geometry, geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_geometry_overright(geometry, geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_overright';


ALTER FUNCTION public.st_geometry_overright(geometry, geometry) OWNER TO postgres;

--
-- Name: st_geometry_recv(internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_geometry_recv(internal) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_recv';


ALTER FUNCTION public.st_geometry_recv(internal) OWNER TO postgres;

--
-- Name: st_geometry_right(geometry, geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_geometry_right(geometry, geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_right';


ALTER FUNCTION public.st_geometry_right(geometry, geometry) OWNER TO postgres;

--
-- Name: st_geometry_same(geometry, geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_geometry_same(geometry, geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_samebox';


ALTER FUNCTION public.st_geometry_same(geometry, geometry) OWNER TO postgres;

--
-- Name: st_geometry_send(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_geometry_send(geometry) RETURNS bytea
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_send';


ALTER FUNCTION public.st_geometry_send(geometry) OWNER TO postgres;

--
-- Name: st_geometryfromtext(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_geometryfromtext(text) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_from_text';


ALTER FUNCTION public.st_geometryfromtext(text) OWNER TO postgres;

--
-- Name: st_geometryfromtext(text, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_geometryfromtext(text, integer) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_from_text';


ALTER FUNCTION public.st_geometryfromtext(text, integer) OWNER TO postgres;

--
-- Name: st_geometryn(geometry, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_geometryn(geometry, integer) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_geometryn_collection';


ALTER FUNCTION public.st_geometryn(geometry, integer) OWNER TO postgres;

--
-- Name: st_geometrytype(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_geometrytype(geometry) RETURNS text
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'geometry_geometrytype';


ALTER FUNCTION public.st_geometrytype(geometry) OWNER TO postgres;

--
-- Name: st_geomfromewkb(bytea); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_geomfromewkb(bytea) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOMFromWKB';


ALTER FUNCTION public.st_geomfromewkb(bytea) OWNER TO postgres;

--
-- Name: st_geomfromewkt(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_geomfromewkt(text) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'parse_WKT_lwgeom';


ALTER FUNCTION public.st_geomfromewkt(text) OWNER TO postgres;

--
-- Name: st_geomfromgml(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_geomfromgml(text) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'geom_from_gml';


ALTER FUNCTION public.st_geomfromgml(text) OWNER TO postgres;

--
-- Name: st_geomfromkml(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_geomfromkml(text) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'geom_from_kml';


ALTER FUNCTION public.st_geomfromkml(text) OWNER TO postgres;

--
-- Name: st_geomfromtext(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_geomfromtext(text) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_from_text';


ALTER FUNCTION public.st_geomfromtext(text) OWNER TO postgres;

--
-- Name: st_geomfromtext(text, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_geomfromtext(text, integer) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_from_text';


ALTER FUNCTION public.st_geomfromtext(text, integer) OWNER TO postgres;

--
-- Name: st_geomfromwkb(bytea); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_geomfromwkb(bytea) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_from_WKB';


ALTER FUNCTION public.st_geomfromwkb(bytea) OWNER TO postgres;

--
-- Name: st_geomfromwkb(bytea, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_geomfromwkb(bytea, integer) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT ST_SetSRID(ST_GeomFromWKB($1), $2)$_$;


ALTER FUNCTION public.st_geomfromwkb(bytea, integer) OWNER TO postgres;

--
-- Name: st_gmltosql(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_gmltosql(text) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'geom_from_gml';


ALTER FUNCTION public.st_gmltosql(text) OWNER TO postgres;

--
-- Name: st_hasarc(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_hasarc(geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_has_arc';


ALTER FUNCTION public.st_hasarc(geometry) OWNER TO postgres;

--
-- Name: st_hausdorffdistance(geometry, geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_hausdorffdistance(geometry, geometry) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT COST 100
    AS '$libdir/postgis-1.5', 'hausdorffdistance';


ALTER FUNCTION public.st_hausdorffdistance(geometry, geometry) OWNER TO postgres;

--
-- Name: st_hausdorffdistance(geometry, geometry, double precision); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_hausdorffdistance(geometry, geometry, double precision) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT COST 100
    AS '$libdir/postgis-1.5', 'hausdorffdistancedensify';


ALTER FUNCTION public.st_hausdorffdistance(geometry, geometry, double precision) OWNER TO postgres;

--
-- Name: st_height(chip); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_height(chip) RETURNS integer
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'CHIP_getHeight';


ALTER FUNCTION public.st_height(chip) OWNER TO postgres;

--
-- Name: st_interiorringn(geometry, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_interiorringn(geometry, integer) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_interiorringn_polygon';


ALTER FUNCTION public.st_interiorringn(geometry, integer) OWNER TO postgres;

--
-- Name: st_intersection(geometry, geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_intersection(geometry, geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT COST 100
    AS '$libdir/postgis-1.5', 'intersection';


ALTER FUNCTION public.st_intersection(geometry, geometry) OWNER TO postgres;

--
-- Name: st_intersection(geography, geography); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_intersection(geography, geography) RETURNS geography
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT geography(ST_Transform(ST_Intersection(ST_Transform(geometry($1), _ST_BestSRID($1, $2)), ST_Transform(geometry($2), _ST_BestSRID($1, $2))), 4326))$_$;


ALTER FUNCTION public.st_intersection(geography, geography) OWNER TO postgres;

--
-- Name: st_intersection(text, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_intersection(text, text) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$ SELECT ST_Intersection($1::geometry, $2::geometry);  $_$;


ALTER FUNCTION public.st_intersection(text, text) OWNER TO postgres;

--
-- Name: st_intersects(geometry, geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_intersects(geometry, geometry) RETURNS boolean
    LANGUAGE sql IMMUTABLE
    AS $_$SELECT $1 && $2 AND _ST_Intersects($1,$2)$_$;


ALTER FUNCTION public.st_intersects(geometry, geometry) OWNER TO postgres;

--
-- Name: st_intersects(geography, geography); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_intersects(geography, geography) RETURNS boolean
    LANGUAGE sql IMMUTABLE
    AS $_$SELECT $1 && $2 AND _ST_Distance($1, $2, 0.0, false) < 0.00001$_$;


ALTER FUNCTION public.st_intersects(geography, geography) OWNER TO postgres;

--
-- Name: st_intersects(text, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_intersects(text, text) RETURNS boolean
    LANGUAGE sql IMMUTABLE
    AS $_$ SELECT ST_Intersects($1::geometry, $2::geometry);  $_$;


ALTER FUNCTION public.st_intersects(text, text) OWNER TO postgres;

--
-- Name: st_isclosed(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_isclosed(geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_isclosed_linestring';


ALTER FUNCTION public.st_isclosed(geometry) OWNER TO postgres;

--
-- Name: st_isempty(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_isempty(geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_isempty';


ALTER FUNCTION public.st_isempty(geometry) OWNER TO postgres;

--
-- Name: st_isring(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_isring(geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'isring';


ALTER FUNCTION public.st_isring(geometry) OWNER TO postgres;

--
-- Name: st_issimple(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_issimple(geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'issimple';


ALTER FUNCTION public.st_issimple(geometry) OWNER TO postgres;

--
-- Name: st_isvalid(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_isvalid(geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT COST 100
    AS '$libdir/postgis-1.5', 'isvalid';


ALTER FUNCTION public.st_isvalid(geometry) OWNER TO postgres;

--
-- Name: st_isvalidreason(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_isvalidreason(geometry) RETURNS text
    LANGUAGE c IMMUTABLE STRICT COST 100
    AS '$libdir/postgis-1.5', 'isvalidreason';


ALTER FUNCTION public.st_isvalidreason(geometry) OWNER TO postgres;

--
-- Name: st_length(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_length(geometry) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_length2d_linestring';


ALTER FUNCTION public.st_length(geometry) OWNER TO postgres;

--
-- Name: st_length(geography); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_length(geography) RETURNS double precision
    LANGUAGE sql IMMUTABLE
    AS $_$SELECT ST_Length($1, true)$_$;


ALTER FUNCTION public.st_length(geography) OWNER TO postgres;

--
-- Name: st_length(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_length(text) RETURNS double precision
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$ SELECT ST_Length($1::geometry);  $_$;


ALTER FUNCTION public.st_length(text) OWNER TO postgres;

--
-- Name: st_length(geography, boolean); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_length(geography, boolean) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT COST 100
    AS '$libdir/postgis-1.5', 'geography_length';


ALTER FUNCTION public.st_length(geography, boolean) OWNER TO postgres;

--
-- Name: st_length2d(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_length2d(geometry) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_length2d_linestring';


ALTER FUNCTION public.st_length2d(geometry) OWNER TO postgres;

--
-- Name: st_length2d_spheroid(geometry, spheroid); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_length2d_spheroid(geometry, spheroid) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT COST 100
    AS '$libdir/postgis-1.5', 'LWGEOM_length2d_ellipsoid';


ALTER FUNCTION public.st_length2d_spheroid(geometry, spheroid) OWNER TO postgres;

--
-- Name: st_length3d(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_length3d(geometry) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_length_linestring';


ALTER FUNCTION public.st_length3d(geometry) OWNER TO postgres;

--
-- Name: st_length3d_spheroid(geometry, spheroid); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_length3d_spheroid(geometry, spheroid) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT COST 100
    AS '$libdir/postgis-1.5', 'LWGEOM_length_ellipsoid_linestring';


ALTER FUNCTION public.st_length3d_spheroid(geometry, spheroid) OWNER TO postgres;

--
-- Name: st_length_spheroid(geometry, spheroid); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_length_spheroid(geometry, spheroid) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT COST 100
    AS '$libdir/postgis-1.5', 'LWGEOM_length_ellipsoid_linestring';


ALTER FUNCTION public.st_length_spheroid(geometry, spheroid) OWNER TO postgres;

--
-- Name: st_line_interpolate_point(geometry, double precision); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_line_interpolate_point(geometry, double precision) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_line_interpolate_point';


ALTER FUNCTION public.st_line_interpolate_point(geometry, double precision) OWNER TO postgres;

--
-- Name: st_line_locate_point(geometry, geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_line_locate_point(geometry, geometry) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_line_locate_point';


ALTER FUNCTION public.st_line_locate_point(geometry, geometry) OWNER TO postgres;

--
-- Name: st_line_substring(geometry, double precision, double precision); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_line_substring(geometry, double precision, double precision) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_line_substring';


ALTER FUNCTION public.st_line_substring(geometry, double precision, double precision) OWNER TO postgres;

--
-- Name: st_linecrossingdirection(geometry, geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_linecrossingdirection(geometry, geometry) RETURNS integer
    LANGUAGE sql IMMUTABLE
    AS $_$ SELECT CASE WHEN NOT $1 && $2 THEN 0 ELSE _ST_LineCrossingDirection($1,$2) END $_$;


ALTER FUNCTION public.st_linecrossingdirection(geometry, geometry) OWNER TO postgres;

--
-- Name: st_linefrommultipoint(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_linefrommultipoint(geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_line_from_mpoint';


ALTER FUNCTION public.st_linefrommultipoint(geometry) OWNER TO postgres;

--
-- Name: st_linefromtext(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_linefromtext(text) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(ST_GeomFromText($1)) = 'LINESTRING'
	THEN ST_GeomFromText($1)
	ELSE NULL END
	$_$;


ALTER FUNCTION public.st_linefromtext(text) OWNER TO postgres;

--
-- Name: st_linefromtext(text, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_linefromtext(text, integer) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(GeomFromText($1, $2)) = 'LINESTRING'
	THEN GeomFromText($1,$2)
	ELSE NULL END
	$_$;


ALTER FUNCTION public.st_linefromtext(text, integer) OWNER TO postgres;

--
-- Name: st_linefromwkb(bytea); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_linefromwkb(bytea) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(ST_GeomFromWKB($1)) = 'LINESTRING'
	THEN ST_GeomFromWKB($1)
	ELSE NULL END
	$_$;


ALTER FUNCTION public.st_linefromwkb(bytea) OWNER TO postgres;

--
-- Name: st_linefromwkb(bytea, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_linefromwkb(bytea, integer) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(ST_GeomFromWKB($1, $2)) = 'LINESTRING'
	THEN ST_GeomFromWKB($1, $2)
	ELSE NULL END
	$_$;


ALTER FUNCTION public.st_linefromwkb(bytea, integer) OWNER TO postgres;

--
-- Name: st_linemerge(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_linemerge(geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT COST 100
    AS '$libdir/postgis-1.5', 'linemerge';


ALTER FUNCTION public.st_linemerge(geometry) OWNER TO postgres;

--
-- Name: st_linestringfromwkb(bytea); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_linestringfromwkb(bytea) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(GeomFromWKB($1)) = 'LINESTRING'
	THEN GeomFromWKB($1)
	ELSE NULL END
	$_$;


ALTER FUNCTION public.st_linestringfromwkb(bytea) OWNER TO postgres;

--
-- Name: st_linestringfromwkb(bytea, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_linestringfromwkb(bytea, integer) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(ST_GeomFromWKB($1, $2)) = 'LINESTRING'
	THEN ST_GeomFromWKB($1, $2)
	ELSE NULL END
	$_$;


ALTER FUNCTION public.st_linestringfromwkb(bytea, integer) OWNER TO postgres;

--
-- Name: st_linetocurve(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_linetocurve(geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_line_desegmentize';


ALTER FUNCTION public.st_linetocurve(geometry) OWNER TO postgres;

--
-- Name: st_locate_along_measure(geometry, double precision); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_locate_along_measure(geometry, double precision) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$ SELECT locate_between_measures($1, $2, $2) $_$;


ALTER FUNCTION public.st_locate_along_measure(geometry, double precision) OWNER TO postgres;

--
-- Name: st_locate_between_measures(geometry, double precision, double precision); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_locate_between_measures(geometry, double precision, double precision) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_locate_between_m';


ALTER FUNCTION public.st_locate_between_measures(geometry, double precision, double precision) OWNER TO postgres;

--
-- Name: st_locatebetweenelevations(geometry, double precision, double precision); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_locatebetweenelevations(geometry, double precision, double precision) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'ST_LocateBetweenElevations';


ALTER FUNCTION public.st_locatebetweenelevations(geometry, double precision, double precision) OWNER TO postgres;

--
-- Name: st_longestline(geometry, geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_longestline(geometry, geometry) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT _ST_LongestLine(ST_ConvexHull($1), ST_ConvexHull($2))$_$;


ALTER FUNCTION public.st_longestline(geometry, geometry) OWNER TO postgres;

--
-- Name: st_m(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_m(geometry) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_m_point';


ALTER FUNCTION public.st_m(geometry) OWNER TO postgres;

--
-- Name: st_makebox2d(geometry, geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_makebox2d(geometry, geometry) RETURNS box2d
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'BOX2DFLOAT4_construct';


ALTER FUNCTION public.st_makebox2d(geometry, geometry) OWNER TO postgres;

--
-- Name: st_makebox3d(geometry, geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_makebox3d(geometry, geometry) RETURNS box3d
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'BOX3D_construct';


ALTER FUNCTION public.st_makebox3d(geometry, geometry) OWNER TO postgres;

--
-- Name: st_makeenvelope(double precision, double precision, double precision, double precision, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_makeenvelope(double precision, double precision, double precision, double precision, integer) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'ST_MakeEnvelope';


ALTER FUNCTION public.st_makeenvelope(double precision, double precision, double precision, double precision, integer) OWNER TO postgres;

--
-- Name: st_makeline(geometry[]); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_makeline(geometry[]) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_makeline_garray';


ALTER FUNCTION public.st_makeline(geometry[]) OWNER TO postgres;

--
-- Name: st_makeline(geometry, geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_makeline(geometry, geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_makeline';


ALTER FUNCTION public.st_makeline(geometry, geometry) OWNER TO postgres;

--
-- Name: st_makeline_garray(geometry[]); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_makeline_garray(geometry[]) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_makeline_garray';


ALTER FUNCTION public.st_makeline_garray(geometry[]) OWNER TO postgres;

--
-- Name: st_makepoint(double precision, double precision); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_makepoint(double precision, double precision) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_makepoint';


ALTER FUNCTION public.st_makepoint(double precision, double precision) OWNER TO postgres;

--
-- Name: st_makepoint(double precision, double precision, double precision); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_makepoint(double precision, double precision, double precision) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_makepoint';


ALTER FUNCTION public.st_makepoint(double precision, double precision, double precision) OWNER TO postgres;

--
-- Name: st_makepoint(double precision, double precision, double precision, double precision); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_makepoint(double precision, double precision, double precision, double precision) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_makepoint';


ALTER FUNCTION public.st_makepoint(double precision, double precision, double precision, double precision) OWNER TO postgres;

--
-- Name: st_makepointm(double precision, double precision, double precision); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_makepointm(double precision, double precision, double precision) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_makepoint3dm';


ALTER FUNCTION public.st_makepointm(double precision, double precision, double precision) OWNER TO postgres;

--
-- Name: st_makepolygon(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_makepolygon(geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_makepoly';


ALTER FUNCTION public.st_makepolygon(geometry) OWNER TO postgres;

--
-- Name: st_makepolygon(geometry, geometry[]); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_makepolygon(geometry, geometry[]) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_makepoly';


ALTER FUNCTION public.st_makepolygon(geometry, geometry[]) OWNER TO postgres;

--
-- Name: st_maxdistance(geometry, geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_maxdistance(geometry, geometry) RETURNS double precision
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT _ST_MaxDistance(ST_ConvexHull($1), ST_ConvexHull($2))$_$;


ALTER FUNCTION public.st_maxdistance(geometry, geometry) OWNER TO postgres;

--
-- Name: st_mem_size(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_mem_size(geometry) RETURNS integer
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_mem_size';


ALTER FUNCTION public.st_mem_size(geometry) OWNER TO postgres;

--
-- Name: st_minimumboundingcircle(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_minimumboundingcircle(geometry) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT ST_MinimumBoundingCircle($1, 48)$_$;


ALTER FUNCTION public.st_minimumboundingcircle(geometry) OWNER TO postgres;

--
-- Name: st_minimumboundingcircle(geometry, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_minimumboundingcircle(inputgeom geometry, segs_per_quarter integer) RETURNS geometry
    LANGUAGE plpgsql IMMUTABLE STRICT
    AS $$
	DECLARE
	hull GEOMETRY;
	ring GEOMETRY;
	center GEOMETRY;
	radius DOUBLE PRECISION;
	dist DOUBLE PRECISION;
	d DOUBLE PRECISION;
	idx1 integer;
	idx2 integer;
	l1 GEOMETRY;
	l2 GEOMETRY;
	p1 GEOMETRY;
	p2 GEOMETRY;
	a1 DOUBLE PRECISION;
	a2 DOUBLE PRECISION;


	BEGIN

	-- First compute the ConvexHull of the geometry
	hull = ST_ConvexHull(inputgeom);
	--A point really has no MBC
	IF ST_GeometryType(hull) = 'ST_Point' THEN
		RETURN hull;
	END IF;
	-- convert the hull perimeter to a linestring so we can manipulate individual points
	--If its already a linestring force it to a closed linestring
	ring = CASE WHEN ST_GeometryType(hull) = 'ST_LineString' THEN ST_AddPoint(hull, ST_StartPoint(hull)) ELSE ST_ExteriorRing(hull) END;

	dist = 0;
	-- Brute Force - check every pair
	FOR i in 1 .. (ST_NumPoints(ring)-2)
		LOOP
			FOR j in i .. (ST_NumPoints(ring)-1)
				LOOP
				d = ST_Distance(ST_PointN(ring,i),ST_PointN(ring,j));
				-- Check the distance and update if larger
				IF (d > dist) THEN
					dist = d;
					idx1 = i;
					idx2 = j;
				END IF;
			END LOOP;
		END LOOP;

	-- We now have the diameter of the convex hull.  The following line returns it if desired.
	-- RETURN MakeLine(PointN(ring,idx1),PointN(ring,idx2));

	-- Now for the Minimum Bounding Circle.  Since we know the two points furthest from each
	-- other, the MBC must go through those two points. Start with those points as a diameter of a circle.

	-- The radius is half the distance between them and the center is midway between them
	radius = ST_Distance(ST_PointN(ring,idx1),ST_PointN(ring,idx2)) / 2.0;
	center = ST_Line_interpolate_point(ST_MakeLine(ST_PointN(ring,idx1),ST_PointN(ring,idx2)),0.5);

	-- Loop through each vertex and check if the distance from the center to the point
	-- is greater than the current radius.
	FOR k in 1 .. (ST_NumPoints(ring)-1)
		LOOP
		IF(k <> idx1 and k <> idx2) THEN
			dist = ST_Distance(center,ST_PointN(ring,k));
			IF (dist > radius) THEN
				-- We have to expand the circle.  The new circle must pass trhough
				-- three points - the two original diameters and this point.

				-- Draw a line from the first diameter to this point
				l1 = ST_Makeline(ST_PointN(ring,idx1),ST_PointN(ring,k));
				-- Compute the midpoint
				p1 = ST_line_interpolate_point(l1,0.5);
				-- Rotate the line 90 degrees around the midpoint (perpendicular bisector)
				l1 = ST_Translate(ST_Rotate(ST_Translate(l1,-X(p1),-Y(p1)),pi()/2),X(p1),Y(p1));
				--  Compute the azimuth of the bisector
				a1 = ST_Azimuth(ST_PointN(l1,1),ST_PointN(l1,2));
				--  Extend the line in each direction the new computed distance to insure they will intersect
				l1 = ST_AddPoint(l1,ST_Makepoint(X(ST_PointN(l1,2))+sin(a1)*dist,Y(ST_PointN(l1,2))+cos(a1)*dist),-1);
				l1 = ST_AddPoint(l1,ST_Makepoint(X(ST_PointN(l1,1))-sin(a1)*dist,Y(ST_PointN(l1,1))-cos(a1)*dist),0);

				-- Repeat for the line from the point to the other diameter point
				l2 = ST_Makeline(ST_PointN(ring,idx2),ST_PointN(ring,k));
				p2 = ST_Line_interpolate_point(l2,0.5);
				l2 = ST_Translate(ST_Rotate(ST_Translate(l2,-X(p2),-Y(p2)),pi()/2),X(p2),Y(p2));
				a2 = ST_Azimuth(ST_PointN(l2,1),ST_PointN(l2,2));
				l2 = ST_AddPoint(l2,ST_Makepoint(X(ST_PointN(l2,2))+sin(a2)*dist,Y(ST_PointN(l2,2))+cos(a2)*dist),-1);
				l2 = ST_AddPoint(l2,ST_Makepoint(X(ST_PointN(l2,1))-sin(a2)*dist,Y(ST_PointN(l2,1))-cos(a2)*dist),0);

				-- The new center is the intersection of the two bisectors
				center = ST_Intersection(l1,l2);
				-- The new radius is the distance to any of the three points
				radius = ST_Distance(center,ST_PointN(ring,idx1));
			END IF;
		END IF;
		END LOOP;
	--DONE!!  Return the MBC via the buffer command
	RETURN ST_Buffer(center,radius,segs_per_quarter);

	END;
$$;


ALTER FUNCTION public.st_minimumboundingcircle(inputgeom geometry, segs_per_quarter integer) OWNER TO postgres;

--
-- Name: st_mlinefromtext(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_mlinefromtext(text) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(ST_GeomFromText($1)) = 'MULTILINESTRING'
	THEN ST_GeomFromText($1)
	ELSE NULL END
	$_$;


ALTER FUNCTION public.st_mlinefromtext(text) OWNER TO postgres;

--
-- Name: st_mlinefromtext(text, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_mlinefromtext(text, integer) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE
	WHEN geometrytype(GeomFromText($1, $2)) = 'MULTILINESTRING'
	THEN GeomFromText($1,$2)
	ELSE NULL END
	$_$;


ALTER FUNCTION public.st_mlinefromtext(text, integer) OWNER TO postgres;

--
-- Name: st_mlinefromwkb(bytea); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_mlinefromwkb(bytea) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(ST_GeomFromWKB($1)) = 'MULTILINESTRING'
	THEN ST_GeomFromWKB($1)
	ELSE NULL END
	$_$;


ALTER FUNCTION public.st_mlinefromwkb(bytea) OWNER TO postgres;

--
-- Name: st_mlinefromwkb(bytea, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_mlinefromwkb(bytea, integer) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(ST_GeomFromWKB($1, $2)) = 'MULTILINESTRING'
	THEN ST_GeomFromWKB($1, $2)
	ELSE NULL END
	$_$;


ALTER FUNCTION public.st_mlinefromwkb(bytea, integer) OWNER TO postgres;

--
-- Name: st_mpointfromtext(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_mpointfromtext(text) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(ST_GeomFromText($1)) = 'MULTIPOINT'
	THEN ST_GeomFromText($1)
	ELSE NULL END
	$_$;


ALTER FUNCTION public.st_mpointfromtext(text) OWNER TO postgres;

--
-- Name: st_mpointfromtext(text, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_mpointfromtext(text, integer) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(GeomFromText($1, $2)) = 'MULTIPOINT'
	THEN GeomFromText($1, $2)
	ELSE NULL END
	$_$;


ALTER FUNCTION public.st_mpointfromtext(text, integer) OWNER TO postgres;

--
-- Name: st_mpointfromwkb(bytea); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_mpointfromwkb(bytea) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(ST_GeomFromWKB($1)) = 'MULTIPOINT'
	THEN ST_GeomFromWKB($1)
	ELSE NULL END
	$_$;


ALTER FUNCTION public.st_mpointfromwkb(bytea) OWNER TO postgres;

--
-- Name: st_mpointfromwkb(bytea, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_mpointfromwkb(bytea, integer) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(GeomFromWKB($1, $2)) = 'MULTIPOINT'
	THEN GeomFromWKB($1, $2)
	ELSE NULL END
	$_$;


ALTER FUNCTION public.st_mpointfromwkb(bytea, integer) OWNER TO postgres;

--
-- Name: st_mpolyfromtext(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_mpolyfromtext(text) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(ST_GeomFromText($1)) = 'MULTIPOLYGON'
	THEN ST_GeomFromText($1)
	ELSE NULL END
	$_$;


ALTER FUNCTION public.st_mpolyfromtext(text) OWNER TO postgres;

--
-- Name: st_mpolyfromtext(text, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_mpolyfromtext(text, integer) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(ST_GeomFromText($1, $2)) = 'MULTIPOLYGON'
	THEN ST_GeomFromText($1,$2)
	ELSE NULL END
	$_$;


ALTER FUNCTION public.st_mpolyfromtext(text, integer) OWNER TO postgres;

--
-- Name: st_mpolyfromwkb(bytea); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_mpolyfromwkb(bytea) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(ST_GeomFromWKB($1)) = 'MULTIPOLYGON'
	THEN ST_GeomFromWKB($1)
	ELSE NULL END
	$_$;


ALTER FUNCTION public.st_mpolyfromwkb(bytea) OWNER TO postgres;

--
-- Name: st_mpolyfromwkb(bytea, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_mpolyfromwkb(bytea, integer) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(ST_GeomFromWKB($1, $2)) = 'MULTIPOLYGON'
	THEN ST_GeomFromWKB($1, $2)
	ELSE NULL END
	$_$;


ALTER FUNCTION public.st_mpolyfromwkb(bytea, integer) OWNER TO postgres;

--
-- Name: st_multi(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_multi(geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_force_multi';


ALTER FUNCTION public.st_multi(geometry) OWNER TO postgres;

--
-- Name: st_multilinefromwkb(bytea); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_multilinefromwkb(bytea) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(ST_GeomFromWKB($1)) = 'MULTILINESTRING'
	THEN ST_GeomFromWKB($1)
	ELSE NULL END
	$_$;


ALTER FUNCTION public.st_multilinefromwkb(bytea) OWNER TO postgres;

--
-- Name: st_multilinestringfromtext(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_multilinestringfromtext(text) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT ST_MLineFromText($1)$_$;


ALTER FUNCTION public.st_multilinestringfromtext(text) OWNER TO postgres;

--
-- Name: st_multilinestringfromtext(text, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_multilinestringfromtext(text, integer) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT MLineFromText($1, $2)$_$;


ALTER FUNCTION public.st_multilinestringfromtext(text, integer) OWNER TO postgres;

--
-- Name: st_multipointfromtext(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_multipointfromtext(text) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT MPointFromText($1)$_$;


ALTER FUNCTION public.st_multipointfromtext(text) OWNER TO postgres;

--
-- Name: st_multipointfromwkb(bytea); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_multipointfromwkb(bytea) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(ST_GeomFromWKB($1)) = 'MULTIPOINT'
	THEN ST_GeomFromWKB($1)
	ELSE NULL END
	$_$;


ALTER FUNCTION public.st_multipointfromwkb(bytea) OWNER TO postgres;

--
-- Name: st_multipointfromwkb(bytea, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_multipointfromwkb(bytea, integer) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(ST_GeomFromWKB($1,$2)) = 'MULTIPOINT'
	THEN ST_GeomFromWKB($1, $2)
	ELSE NULL END
	$_$;


ALTER FUNCTION public.st_multipointfromwkb(bytea, integer) OWNER TO postgres;

--
-- Name: st_multipolyfromwkb(bytea); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_multipolyfromwkb(bytea) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(ST_GeomFromWKB($1)) = 'MULTIPOLYGON'
	THEN ST_GeomFromWKB($1)
	ELSE NULL END
	$_$;


ALTER FUNCTION public.st_multipolyfromwkb(bytea) OWNER TO postgres;

--
-- Name: st_multipolyfromwkb(bytea, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_multipolyfromwkb(bytea, integer) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(ST_GeomFromWKB($1, $2)) = 'MULTIPOLYGON'
	THEN ST_GeomFromWKB($1, $2)
	ELSE NULL END
	$_$;


ALTER FUNCTION public.st_multipolyfromwkb(bytea, integer) OWNER TO postgres;

--
-- Name: st_multipolygonfromtext(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_multipolygonfromtext(text) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT MPolyFromText($1)$_$;


ALTER FUNCTION public.st_multipolygonfromtext(text) OWNER TO postgres;

--
-- Name: st_multipolygonfromtext(text, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_multipolygonfromtext(text, integer) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT MPolyFromText($1, $2)$_$;


ALTER FUNCTION public.st_multipolygonfromtext(text, integer) OWNER TO postgres;

--
-- Name: st_ndims(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_ndims(geometry) RETURNS smallint
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_ndims';


ALTER FUNCTION public.st_ndims(geometry) OWNER TO postgres;

--
-- Name: st_npoints(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_npoints(geometry) RETURNS integer
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_npoints';


ALTER FUNCTION public.st_npoints(geometry) OWNER TO postgres;

--
-- Name: st_nrings(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_nrings(geometry) RETURNS integer
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_nrings';


ALTER FUNCTION public.st_nrings(geometry) OWNER TO postgres;

--
-- Name: st_numgeometries(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_numgeometries(geometry) RETURNS integer
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_numgeometries_collection';


ALTER FUNCTION public.st_numgeometries(geometry) OWNER TO postgres;

--
-- Name: st_numinteriorring(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_numinteriorring(geometry) RETURNS integer
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_numinteriorrings_polygon';


ALTER FUNCTION public.st_numinteriorring(geometry) OWNER TO postgres;

--
-- Name: st_numinteriorrings(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_numinteriorrings(geometry) RETURNS integer
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_numinteriorrings_polygon';


ALTER FUNCTION public.st_numinteriorrings(geometry) OWNER TO postgres;

--
-- Name: st_numpoints(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_numpoints(geometry) RETURNS integer
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_numpoints_linestring';


ALTER FUNCTION public.st_numpoints(geometry) OWNER TO postgres;

--
-- Name: st_orderingequals(geometry, geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_orderingequals(geometry, geometry) RETURNS boolean
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$ 
	SELECT $1 ~= $2 AND _ST_OrderingEquals($1, $2)
	$_$;


ALTER FUNCTION public.st_orderingequals(geometry, geometry) OWNER TO postgres;

--
-- Name: st_overlaps(geometry, geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_overlaps(geometry, geometry) RETURNS boolean
    LANGUAGE sql IMMUTABLE
    AS $_$SELECT $1 && $2 AND _ST_Overlaps($1,$2)$_$;


ALTER FUNCTION public.st_overlaps(geometry, geometry) OWNER TO postgres;

--
-- Name: st_perimeter(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_perimeter(geometry) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_perimeter2d_poly';


ALTER FUNCTION public.st_perimeter(geometry) OWNER TO postgres;

--
-- Name: st_perimeter2d(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_perimeter2d(geometry) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_perimeter2d_poly';


ALTER FUNCTION public.st_perimeter2d(geometry) OWNER TO postgres;

--
-- Name: st_perimeter3d(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_perimeter3d(geometry) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_perimeter_poly';


ALTER FUNCTION public.st_perimeter3d(geometry) OWNER TO postgres;

--
-- Name: st_point(double precision, double precision); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_point(double precision, double precision) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_makepoint';


ALTER FUNCTION public.st_point(double precision, double precision) OWNER TO postgres;

--
-- Name: st_point_inside_circle(geometry, double precision, double precision, double precision); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_point_inside_circle(geometry, double precision, double precision, double precision) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_inside_circle_point';


ALTER FUNCTION public.st_point_inside_circle(geometry, double precision, double precision, double precision) OWNER TO postgres;

--
-- Name: st_pointfromtext(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_pointfromtext(text) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(ST_GeomFromText($1)) = 'POINT'
	THEN ST_GeomFromText($1)
	ELSE NULL END
	$_$;


ALTER FUNCTION public.st_pointfromtext(text) OWNER TO postgres;

--
-- Name: st_pointfromtext(text, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_pointfromtext(text, integer) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(ST_GeomFromText($1, $2)) = 'POINT'
	THEN ST_GeomFromText($1, $2)
	ELSE NULL END
	$_$;


ALTER FUNCTION public.st_pointfromtext(text, integer) OWNER TO postgres;

--
-- Name: st_pointfromwkb(bytea); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_pointfromwkb(bytea) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(ST_GeomFromWKB($1)) = 'POINT'
	THEN ST_GeomFromWKB($1)
	ELSE NULL END
	$_$;


ALTER FUNCTION public.st_pointfromwkb(bytea) OWNER TO postgres;

--
-- Name: st_pointfromwkb(bytea, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_pointfromwkb(bytea, integer) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(ST_GeomFromWKB($1, $2)) = 'POINT'
	THEN ST_GeomFromWKB($1, $2)
	ELSE NULL END
	$_$;


ALTER FUNCTION public.st_pointfromwkb(bytea, integer) OWNER TO postgres;

--
-- Name: st_pointn(geometry, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_pointn(geometry, integer) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_pointn_linestring';


ALTER FUNCTION public.st_pointn(geometry, integer) OWNER TO postgres;

--
-- Name: st_pointonsurface(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_pointonsurface(geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT COST 100
    AS '$libdir/postgis-1.5', 'pointonsurface';


ALTER FUNCTION public.st_pointonsurface(geometry) OWNER TO postgres;

--
-- Name: st_polyfromtext(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_polyfromtext(text) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(ST_GeomFromText($1)) = 'POLYGON'
	THEN ST_GeomFromText($1)
	ELSE NULL END
	$_$;


ALTER FUNCTION public.st_polyfromtext(text) OWNER TO postgres;

--
-- Name: st_polyfromtext(text, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_polyfromtext(text, integer) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(ST_GeomFromText($1, $2)) = 'POLYGON'
	THEN ST_GeomFromText($1, $2)
	ELSE NULL END
	$_$;


ALTER FUNCTION public.st_polyfromtext(text, integer) OWNER TO postgres;

--
-- Name: st_polyfromwkb(bytea); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_polyfromwkb(bytea) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(ST_GeomFromWKB($1)) = 'POLYGON'
	THEN ST_GeomFromWKB($1)
	ELSE NULL END
	$_$;


ALTER FUNCTION public.st_polyfromwkb(bytea) OWNER TO postgres;

--
-- Name: st_polyfromwkb(bytea, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_polyfromwkb(bytea, integer) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(ST_GeomFromWKB($1, $2)) = 'POLYGON'
	THEN ST_GeomFromWKB($1, $2)
	ELSE NULL END
	$_$;


ALTER FUNCTION public.st_polyfromwkb(bytea, integer) OWNER TO postgres;

--
-- Name: st_polygon(geometry, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_polygon(geometry, integer) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$ 
	SELECT setSRID(makepolygon($1), $2)
	$_$;


ALTER FUNCTION public.st_polygon(geometry, integer) OWNER TO postgres;

--
-- Name: st_polygonfromtext(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_polygonfromtext(text) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT ST_PolyFromText($1)$_$;


ALTER FUNCTION public.st_polygonfromtext(text) OWNER TO postgres;

--
-- Name: st_polygonfromtext(text, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_polygonfromtext(text, integer) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT PolyFromText($1, $2)$_$;


ALTER FUNCTION public.st_polygonfromtext(text, integer) OWNER TO postgres;

--
-- Name: st_polygonfromwkb(bytea); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_polygonfromwkb(bytea) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(GeomFromWKB($1)) = 'POLYGON'
	THEN GeomFromWKB($1)
	ELSE NULL END
	$_$;


ALTER FUNCTION public.st_polygonfromwkb(bytea) OWNER TO postgres;

--
-- Name: st_polygonfromwkb(bytea, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_polygonfromwkb(bytea, integer) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(ST_GeomFromWKB($1,$2)) = 'POLYGON'
	THEN ST_GeomFromWKB($1, $2)
	ELSE NULL END
	$_$;


ALTER FUNCTION public.st_polygonfromwkb(bytea, integer) OWNER TO postgres;

--
-- Name: st_polygonize(geometry[]); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_polygonize(geometry[]) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT COST 100
    AS '$libdir/postgis-1.5', 'polygonize_garray';


ALTER FUNCTION public.st_polygonize(geometry[]) OWNER TO postgres;

--
-- Name: st_polygonize_garray(geometry[]); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_polygonize_garray(geometry[]) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT COST 100
    AS '$libdir/postgis-1.5', 'polygonize_garray';


ALTER FUNCTION public.st_polygonize_garray(geometry[]) OWNER TO postgres;

--
-- Name: st_postgis_gist_joinsel(internal, oid, internal, smallint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_postgis_gist_joinsel(internal, oid, internal, smallint) RETURNS double precision
    LANGUAGE c
    AS '$libdir/postgis-1.5', 'LWGEOM_gist_joinsel';


ALTER FUNCTION public.st_postgis_gist_joinsel(internal, oid, internal, smallint) OWNER TO postgres;

--
-- Name: st_postgis_gist_sel(internal, oid, internal, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_postgis_gist_sel(internal, oid, internal, integer) RETURNS double precision
    LANGUAGE c
    AS '$libdir/postgis-1.5', 'LWGEOM_gist_sel';


ALTER FUNCTION public.st_postgis_gist_sel(internal, oid, internal, integer) OWNER TO postgres;

--
-- Name: st_relate(geometry, geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_relate(geometry, geometry) RETURNS text
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'relate_full';


ALTER FUNCTION public.st_relate(geometry, geometry) OWNER TO postgres;

--
-- Name: st_relate(geometry, geometry, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_relate(geometry, geometry, text) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'relate_pattern';


ALTER FUNCTION public.st_relate(geometry, geometry, text) OWNER TO postgres;

--
-- Name: st_removepoint(geometry, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_removepoint(geometry, integer) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_removepoint';


ALTER FUNCTION public.st_removepoint(geometry, integer) OWNER TO postgres;

--
-- Name: st_reverse(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_reverse(geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_reverse';


ALTER FUNCTION public.st_reverse(geometry) OWNER TO postgres;

--
-- Name: st_rotate(geometry, double precision); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_rotate(geometry, double precision) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT rotateZ($1, $2)$_$;


ALTER FUNCTION public.st_rotate(geometry, double precision) OWNER TO postgres;

--
-- Name: st_rotatex(geometry, double precision); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_rotatex(geometry, double precision) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT affine($1, 1, 0, 0, 0, cos($2), -sin($2), 0, sin($2), cos($2), 0, 0, 0)$_$;


ALTER FUNCTION public.st_rotatex(geometry, double precision) OWNER TO postgres;

--
-- Name: st_rotatey(geometry, double precision); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_rotatey(geometry, double precision) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT affine($1,  cos($2), 0, sin($2),  0, 1, 0,  -sin($2), 0, cos($2), 0,  0, 0)$_$;


ALTER FUNCTION public.st_rotatey(geometry, double precision) OWNER TO postgres;

--
-- Name: st_rotatez(geometry, double precision); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_rotatez(geometry, double precision) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT affine($1,  cos($2), -sin($2), 0,  sin($2), cos($2), 0,  0, 0, 1,  0, 0, 0)$_$;


ALTER FUNCTION public.st_rotatez(geometry, double precision) OWNER TO postgres;

--
-- Name: st_scale(geometry, double precision, double precision); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_scale(geometry, double precision, double precision) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT scale($1, $2, $3, 1)$_$;


ALTER FUNCTION public.st_scale(geometry, double precision, double precision) OWNER TO postgres;

--
-- Name: st_scale(geometry, double precision, double precision, double precision); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_scale(geometry, double precision, double precision, double precision) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT affine($1,  $2, 0, 0,  0, $3, 0,  0, 0, $4,  0, 0, 0)$_$;


ALTER FUNCTION public.st_scale(geometry, double precision, double precision, double precision) OWNER TO postgres;

--
-- Name: st_segmentize(geometry, double precision); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_segmentize(geometry, double precision) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_segmentize2d';


ALTER FUNCTION public.st_segmentize(geometry, double precision) OWNER TO postgres;

--
-- Name: st_setfactor(chip, real); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_setfactor(chip, real) RETURNS chip
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'CHIP_setFactor';


ALTER FUNCTION public.st_setfactor(chip, real) OWNER TO postgres;

--
-- Name: st_setpoint(geometry, integer, geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_setpoint(geometry, integer, geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_setpoint_linestring';


ALTER FUNCTION public.st_setpoint(geometry, integer, geometry) OWNER TO postgres;

--
-- Name: st_setsrid(geometry, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_setsrid(geometry, integer) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_setSRID';


ALTER FUNCTION public.st_setsrid(geometry, integer) OWNER TO postgres;

--
-- Name: st_shift_longitude(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_shift_longitude(geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_longitude_shift';


ALTER FUNCTION public.st_shift_longitude(geometry) OWNER TO postgres;

--
-- Name: st_shortestline(geometry, geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_shortestline(geometry, geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_shortestline2d';


ALTER FUNCTION public.st_shortestline(geometry, geometry) OWNER TO postgres;

--
-- Name: st_simplify(geometry, double precision); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_simplify(geometry, double precision) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_simplify2d';


ALTER FUNCTION public.st_simplify(geometry, double precision) OWNER TO postgres;

--
-- Name: st_simplifypreservetopology(geometry, double precision); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_simplifypreservetopology(geometry, double precision) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT COST 100
    AS '$libdir/postgis-1.5', 'topologypreservesimplify';


ALTER FUNCTION public.st_simplifypreservetopology(geometry, double precision) OWNER TO postgres;

--
-- Name: st_snaptogrid(geometry, double precision); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_snaptogrid(geometry, double precision) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT ST_SnapToGrid($1, 0, 0, $2, $2)$_$;


ALTER FUNCTION public.st_snaptogrid(geometry, double precision) OWNER TO postgres;

--
-- Name: st_snaptogrid(geometry, double precision, double precision); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_snaptogrid(geometry, double precision, double precision) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT ST_SnapToGrid($1, 0, 0, $2, $3)$_$;


ALTER FUNCTION public.st_snaptogrid(geometry, double precision, double precision) OWNER TO postgres;

--
-- Name: st_snaptogrid(geometry, double precision, double precision, double precision, double precision); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_snaptogrid(geometry, double precision, double precision, double precision, double precision) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_snaptogrid';


ALTER FUNCTION public.st_snaptogrid(geometry, double precision, double precision, double precision, double precision) OWNER TO postgres;

--
-- Name: st_snaptogrid(geometry, geometry, double precision, double precision, double precision, double precision); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_snaptogrid(geometry, geometry, double precision, double precision, double precision, double precision) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_snaptogrid_pointoff';


ALTER FUNCTION public.st_snaptogrid(geometry, geometry, double precision, double precision, double precision, double precision) OWNER TO postgres;

--
-- Name: st_spheroid_in(cstring); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_spheroid_in(cstring) RETURNS spheroid
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'ellipsoid_in';


ALTER FUNCTION public.st_spheroid_in(cstring) OWNER TO postgres;

--
-- Name: st_spheroid_out(spheroid); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_spheroid_out(spheroid) RETURNS cstring
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'ellipsoid_out';


ALTER FUNCTION public.st_spheroid_out(spheroid) OWNER TO postgres;

--
-- Name: st_srid(chip); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_srid(chip) RETURNS integer
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'CHIP_getSRID';


ALTER FUNCTION public.st_srid(chip) OWNER TO postgres;

--
-- Name: st_srid(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_srid(geometry) RETURNS integer
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_getSRID';


ALTER FUNCTION public.st_srid(geometry) OWNER TO postgres;

--
-- Name: st_startpoint(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_startpoint(geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_startpoint_linestring';


ALTER FUNCTION public.st_startpoint(geometry) OWNER TO postgres;

--
-- Name: st_summary(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_summary(geometry) RETURNS text
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_summary';


ALTER FUNCTION public.st_summary(geometry) OWNER TO postgres;

--
-- Name: st_symdifference(geometry, geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_symdifference(geometry, geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'symdifference';


ALTER FUNCTION public.st_symdifference(geometry, geometry) OWNER TO postgres;

--
-- Name: st_symmetricdifference(geometry, geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_symmetricdifference(geometry, geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'symdifference';


ALTER FUNCTION public.st_symmetricdifference(geometry, geometry) OWNER TO postgres;

--
-- Name: st_text(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_text(geometry) RETURNS text
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_to_text';


ALTER FUNCTION public.st_text(geometry) OWNER TO postgres;

--
-- Name: st_touches(geometry, geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_touches(geometry, geometry) RETURNS boolean
    LANGUAGE sql IMMUTABLE
    AS $_$SELECT $1 && $2 AND _ST_Touches($1,$2)$_$;


ALTER FUNCTION public.st_touches(geometry, geometry) OWNER TO postgres;

--
-- Name: st_transform(geometry, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_transform(geometry, integer) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'transform';


ALTER FUNCTION public.st_transform(geometry, integer) OWNER TO postgres;

--
-- Name: st_translate(geometry, double precision, double precision); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_translate(geometry, double precision, double precision) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT translate($1, $2, $3, 0)$_$;


ALTER FUNCTION public.st_translate(geometry, double precision, double precision) OWNER TO postgres;

--
-- Name: st_translate(geometry, double precision, double precision, double precision); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_translate(geometry, double precision, double precision, double precision) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT affine($1, 1, 0, 0, 0, 1, 0, 0, 0, 1, $2, $3, $4)$_$;


ALTER FUNCTION public.st_translate(geometry, double precision, double precision, double precision) OWNER TO postgres;

--
-- Name: st_transscale(geometry, double precision, double precision, double precision, double precision); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_transscale(geometry, double precision, double precision, double precision, double precision) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT affine($1,  $4, 0, 0,  0, $5, 0,
		0, 0, 1,  $2 * $4, $3 * $5, 0)$_$;


ALTER FUNCTION public.st_transscale(geometry, double precision, double precision, double precision, double precision) OWNER TO postgres;

--
-- Name: st_union(geometry[]); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_union(geometry[]) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'pgis_union_geometry_array';


ALTER FUNCTION public.st_union(geometry[]) OWNER TO postgres;

--
-- Name: st_union(geometry, geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_union(geometry, geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'geomunion';


ALTER FUNCTION public.st_union(geometry, geometry) OWNER TO postgres;

--
-- Name: st_unite_garray(geometry[]); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_unite_garray(geometry[]) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'pgis_union_geometry_array';


ALTER FUNCTION public.st_unite_garray(geometry[]) OWNER TO postgres;

--
-- Name: st_width(chip); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_width(chip) RETURNS integer
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'CHIP_getWidth';


ALTER FUNCTION public.st_width(chip) OWNER TO postgres;

--
-- Name: st_within(geometry, geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_within(geometry, geometry) RETURNS boolean
    LANGUAGE sql IMMUTABLE
    AS $_$SELECT $1 && $2 AND _ST_Within($1,$2)$_$;


ALTER FUNCTION public.st_within(geometry, geometry) OWNER TO postgres;

--
-- Name: st_wkbtosql(bytea); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_wkbtosql(bytea) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_from_WKB';


ALTER FUNCTION public.st_wkbtosql(bytea) OWNER TO postgres;

--
-- Name: st_wkttosql(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_wkttosql(text) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_from_text';


ALTER FUNCTION public.st_wkttosql(text) OWNER TO postgres;

--
-- Name: st_x(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_x(geometry) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_x_point';


ALTER FUNCTION public.st_x(geometry) OWNER TO postgres;

--
-- Name: st_xmax(box3d); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_xmax(box3d) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'BOX3D_xmax';


ALTER FUNCTION public.st_xmax(box3d) OWNER TO postgres;

--
-- Name: st_xmin(box3d); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_xmin(box3d) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'BOX3D_xmin';


ALTER FUNCTION public.st_xmin(box3d) OWNER TO postgres;

--
-- Name: st_y(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_y(geometry) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_y_point';


ALTER FUNCTION public.st_y(geometry) OWNER TO postgres;

--
-- Name: st_ymax(box3d); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_ymax(box3d) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'BOX3D_ymax';


ALTER FUNCTION public.st_ymax(box3d) OWNER TO postgres;

--
-- Name: st_ymin(box3d); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_ymin(box3d) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'BOX3D_ymin';


ALTER FUNCTION public.st_ymin(box3d) OWNER TO postgres;

--
-- Name: st_z(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_z(geometry) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_z_point';


ALTER FUNCTION public.st_z(geometry) OWNER TO postgres;

--
-- Name: st_zmax(box3d); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_zmax(box3d) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'BOX3D_zmax';


ALTER FUNCTION public.st_zmax(box3d) OWNER TO postgres;

--
-- Name: st_zmflag(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_zmflag(geometry) RETURNS smallint
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_zmflag';


ALTER FUNCTION public.st_zmflag(geometry) OWNER TO postgres;

--
-- Name: st_zmin(box3d); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_zmin(box3d) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'BOX3D_zmin';


ALTER FUNCTION public.st_zmin(box3d) OWNER TO postgres;

--
-- Name: startpoint(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION startpoint(geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_startpoint_linestring';


ALTER FUNCTION public.startpoint(geometry) OWNER TO postgres;

--
-- Name: summary(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION summary(geometry) RETURNS text
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_summary';


ALTER FUNCTION public.summary(geometry) OWNER TO postgres;

--
-- Name: symdifference(geometry, geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION symdifference(geometry, geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'symdifference';


ALTER FUNCTION public.symdifference(geometry, geometry) OWNER TO postgres;

--
-- Name: symmetricdifference(geometry, geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION symmetricdifference(geometry, geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'symdifference';


ALTER FUNCTION public.symmetricdifference(geometry, geometry) OWNER TO postgres;

--
-- Name: text(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION text(geometry) RETURNS text
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_to_text';


ALTER FUNCTION public.text(geometry) OWNER TO postgres;

--
-- Name: touches(geometry, geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION touches(geometry, geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'touches';


ALTER FUNCTION public.touches(geometry, geometry) OWNER TO postgres;

--
-- Name: transform(geometry, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION transform(geometry, integer) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'transform';


ALTER FUNCTION public.transform(geometry, integer) OWNER TO postgres;

--
-- Name: translate(geometry, double precision, double precision); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION translate(geometry, double precision, double precision) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT translate($1, $2, $3, 0)$_$;


ALTER FUNCTION public.translate(geometry, double precision, double precision) OWNER TO postgres;

--
-- Name: translate(geometry, double precision, double precision, double precision); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION translate(geometry, double precision, double precision, double precision) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT affine($1, 1, 0, 0, 0, 1, 0, 0, 0, 1, $2, $3, $4)$_$;


ALTER FUNCTION public.translate(geometry, double precision, double precision, double precision) OWNER TO postgres;

--
-- Name: transscale(geometry, double precision, double precision, double precision, double precision); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION transscale(geometry, double precision, double precision, double precision, double precision) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT affine($1,  $4, 0, 0,  0, $5, 0,
		0, 0, 1,  $2 * $4, $3 * $5, 0)$_$;


ALTER FUNCTION public.transscale(geometry, double precision, double precision, double precision, double precision) OWNER TO postgres;

--
-- Name: unite_garray(geometry[]); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION unite_garray(geometry[]) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'pgis_union_geometry_array';


ALTER FUNCTION public.unite_garray(geometry[]) OWNER TO postgres;

--
-- Name: unlockrows(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION unlockrows(text) RETURNS integer
    LANGUAGE plpgsql STRICT
    AS $_$ 
DECLARE
	ret int;
BEGIN

	IF NOT LongTransactionsEnabled() THEN
		RAISE EXCEPTION 'Long transaction support disabled, use EnableLongTransaction() to enable.';
	END IF;

	EXECUTE 'DELETE FROM authorization_table where authid = ' ||
		quote_literal($1);

	GET DIAGNOSTICS ret = ROW_COUNT;

	RETURN ret;
END;
$_$;


ALTER FUNCTION public.unlockrows(text) OWNER TO postgres;

--
-- Name: updategeometrysrid(character varying, character varying, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION updategeometrysrid(character varying, character varying, integer) RETURNS text
    LANGUAGE plpgsql STRICT
    AS $_$
DECLARE
	ret  text;
BEGIN
	SELECT UpdateGeometrySRID('','',$1,$2,$3) into ret;
	RETURN ret;
END;
$_$;


ALTER FUNCTION public.updategeometrysrid(character varying, character varying, integer) OWNER TO postgres;

--
-- Name: updategeometrysrid(character varying, character varying, character varying, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION updategeometrysrid(character varying, character varying, character varying, integer) RETURNS text
    LANGUAGE plpgsql STRICT
    AS $_$
DECLARE
	ret  text;
BEGIN
	SELECT UpdateGeometrySRID('',$1,$2,$3,$4) into ret;
	RETURN ret;
END;
$_$;


ALTER FUNCTION public.updategeometrysrid(character varying, character varying, character varying, integer) OWNER TO postgres;

--
-- Name: updategeometrysrid(character varying, character varying, character varying, character varying, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION updategeometrysrid(character varying, character varying, character varying, character varying, integer) RETURNS text
    LANGUAGE plpgsql STRICT
    AS $_$
DECLARE
	catalog_name alias for $1;
	schema_name alias for $2;
	table_name alias for $3;
	column_name alias for $4;
	new_srid alias for $5;
	myrec RECORD;
	okay boolean;
	cname varchar;
	real_schema name;

BEGIN


	-- Find, check or fix schema_name
	IF ( schema_name != '' ) THEN
		okay = 'f';

		FOR myrec IN SELECT nspname FROM pg_namespace WHERE text(nspname) = schema_name LOOP
			okay := 't';
		END LOOP;

		IF ( okay <> 't' ) THEN
			RAISE EXCEPTION 'Invalid schema name';
		ELSE
			real_schema = schema_name;
		END IF;
	ELSE
		SELECT INTO real_schema current_schema()::text;
	END IF;

	-- Ensure that column_name is in geometry_columns
	okay = 'f';
	FOR myrec IN SELECT * from geometry_columns where f_table_schema = text(real_schema) and f_table_name = table_name and f_geometry_column = column_name LOOP
		okay := 't';
	END LOOP;
	IF (okay <> 't') THEN
		RAISE EXCEPTION 'column not found in geometry_columns table';
		RETURN 'f';
	END IF;

	-- Ensure that new_srid is valid
	IF ( new_srid != -1 ) THEN
		IF ( SELECT count(*) = 0 from spatial_ref_sys where srid = new_srid ) THEN
			RAISE EXCEPTION 'invalid SRID: % not found in spatial_ref_sys', new_srid;
			RETURN false;
		END IF;
	END IF;

	-- Update ref from geometry_columns table
	EXECUTE 'UPDATE geometry_columns SET SRID = ' || new_srid::text ||
		' where f_table_schema = ' ||
		quote_literal(real_schema) || ' and f_table_name = ' ||
		quote_literal(table_name)  || ' and f_geometry_column = ' ||
		quote_literal(column_name);

	-- Make up constraint name
	cname = 'enforce_srid_'  || column_name;

	-- Drop enforce_srid constraint
	EXECUTE 'ALTER TABLE ' || quote_ident(real_schema) ||
		'.' || quote_ident(table_name) ||
		' DROP constraint ' || quote_ident(cname);

	-- Update geometries SRID
	EXECUTE 'UPDATE ' || quote_ident(real_schema) ||
		'.' || quote_ident(table_name) ||
		' SET ' || quote_ident(column_name) ||
		' = ST_SetSRID(' || quote_ident(column_name) ||
		', ' || new_srid::text || ')';

	-- Reset enforce_srid constraint
	EXECUTE 'ALTER TABLE ' || quote_ident(real_schema) ||
		'.' || quote_ident(table_name) ||
		' ADD constraint ' || quote_ident(cname) ||
		' CHECK (st_srid(' || quote_ident(column_name) ||
		') = ' || new_srid::text || ')';

	RETURN real_schema || '.' || table_name || '.' || column_name ||' SRID changed to ' || new_srid::text;

END;
$_$;


ALTER FUNCTION public.updategeometrysrid(character varying, character varying, character varying, character varying, integer) OWNER TO postgres;

--
-- Name: width(chip); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION width(chip) RETURNS integer
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'CHIP_getWidth';


ALTER FUNCTION public.width(chip) OWNER TO postgres;

--
-- Name: within(geometry, geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION within(geometry, geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'within';


ALTER FUNCTION public.within(geometry, geometry) OWNER TO postgres;

--
-- Name: x(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION x(geometry) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_x_point';


ALTER FUNCTION public.x(geometry) OWNER TO postgres;

--
-- Name: xmax(box3d); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION xmax(box3d) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'BOX3D_xmax';


ALTER FUNCTION public.xmax(box3d) OWNER TO postgres;

--
-- Name: xmin(box3d); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION xmin(box3d) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'BOX3D_xmin';


ALTER FUNCTION public.xmin(box3d) OWNER TO postgres;

--
-- Name: y(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION y(geometry) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_y_point';


ALTER FUNCTION public.y(geometry) OWNER TO postgres;

--
-- Name: ymax(box3d); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION ymax(box3d) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'BOX3D_ymax';


ALTER FUNCTION public.ymax(box3d) OWNER TO postgres;

--
-- Name: ymin(box3d); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION ymin(box3d) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'BOX3D_ymin';


ALTER FUNCTION public.ymin(box3d) OWNER TO postgres;

--
-- Name: z(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION z(geometry) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_z_point';


ALTER FUNCTION public.z(geometry) OWNER TO postgres;

--
-- Name: zmax(box3d); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION zmax(box3d) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'BOX3D_zmax';


ALTER FUNCTION public.zmax(box3d) OWNER TO postgres;

--
-- Name: zmflag(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION zmflag(geometry) RETURNS smallint
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'LWGEOM_zmflag';


ALTER FUNCTION public.zmflag(geometry) OWNER TO postgres;

--
-- Name: zmin(box3d); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION zmin(box3d) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-1.5', 'BOX3D_zmin';


ALTER FUNCTION public.zmin(box3d) OWNER TO postgres;

--
-- Name: accum(geometry); Type: AGGREGATE; Schema: public; Owner: postgres
--

CREATE AGGREGATE accum(geometry) (
    SFUNC = pgis_geometry_accum_transfn,
    STYPE = pgis_abs,
    FINALFUNC = pgis_geometry_accum_finalfn
);


ALTER AGGREGATE public.accum(geometry) OWNER TO postgres;

--
-- Name: collect(geometry); Type: AGGREGATE; Schema: public; Owner: postgres
--

CREATE AGGREGATE collect(geometry) (
    SFUNC = pgis_geometry_accum_transfn,
    STYPE = pgis_abs,
    FINALFUNC = pgis_geometry_collect_finalfn
);


ALTER AGGREGATE public.collect(geometry) OWNER TO postgres;

--
-- Name: extent(geometry); Type: AGGREGATE; Schema: public; Owner: postgres
--

CREATE AGGREGATE extent(geometry) (
    SFUNC = public.st_combine_bbox,
    STYPE = box3d_extent
);


ALTER AGGREGATE public.extent(geometry) OWNER TO postgres;

--
-- Name: extent3d(geometry); Type: AGGREGATE; Schema: public; Owner: postgres
--

CREATE AGGREGATE extent3d(geometry) (
    SFUNC = public.combine_bbox,
    STYPE = box3d
);


ALTER AGGREGATE public.extent3d(geometry) OWNER TO postgres;

--
-- Name: makeline(geometry); Type: AGGREGATE; Schema: public; Owner: postgres
--

CREATE AGGREGATE makeline(geometry) (
    SFUNC = pgis_geometry_accum_transfn,
    STYPE = pgis_abs,
    FINALFUNC = pgis_geometry_makeline_finalfn
);


ALTER AGGREGATE public.makeline(geometry) OWNER TO postgres;

--
-- Name: memcollect(geometry); Type: AGGREGATE; Schema: public; Owner: postgres
--

CREATE AGGREGATE memcollect(geometry) (
    SFUNC = public.st_collect,
    STYPE = geometry
);


ALTER AGGREGATE public.memcollect(geometry) OWNER TO postgres;

--
-- Name: memgeomunion(geometry); Type: AGGREGATE; Schema: public; Owner: postgres
--

CREATE AGGREGATE memgeomunion(geometry) (
    SFUNC = geomunion,
    STYPE = geometry
);


ALTER AGGREGATE public.memgeomunion(geometry) OWNER TO postgres;

--
-- Name: polygonize(geometry); Type: AGGREGATE; Schema: public; Owner: postgres
--

CREATE AGGREGATE polygonize(geometry) (
    SFUNC = pgis_geometry_accum_transfn,
    STYPE = pgis_abs,
    FINALFUNC = pgis_geometry_polygonize_finalfn
);


ALTER AGGREGATE public.polygonize(geometry) OWNER TO postgres;

--
-- Name: st_accum(geometry); Type: AGGREGATE; Schema: public; Owner: postgres
--

CREATE AGGREGATE st_accum(geometry) (
    SFUNC = pgis_geometry_accum_transfn,
    STYPE = pgis_abs,
    FINALFUNC = pgis_geometry_accum_finalfn
);


ALTER AGGREGATE public.st_accum(geometry) OWNER TO postgres;

--
-- Name: st_collect(geometry); Type: AGGREGATE; Schema: public; Owner: postgres
--

CREATE AGGREGATE st_collect(geometry) (
    SFUNC = pgis_geometry_accum_transfn,
    STYPE = pgis_abs,
    FINALFUNC = pgis_geometry_collect_finalfn
);


ALTER AGGREGATE public.st_collect(geometry) OWNER TO postgres;

--
-- Name: st_extent(geometry); Type: AGGREGATE; Schema: public; Owner: postgres
--

CREATE AGGREGATE st_extent(geometry) (
    SFUNC = public.st_combine_bbox,
    STYPE = box3d_extent
);


ALTER AGGREGATE public.st_extent(geometry) OWNER TO postgres;

--
-- Name: st_extent3d(geometry); Type: AGGREGATE; Schema: public; Owner: postgres
--

CREATE AGGREGATE st_extent3d(geometry) (
    SFUNC = public.st_combine_bbox,
    STYPE = box3d
);


ALTER AGGREGATE public.st_extent3d(geometry) OWNER TO postgres;

--
-- Name: st_makeline(geometry); Type: AGGREGATE; Schema: public; Owner: postgres
--

CREATE AGGREGATE st_makeline(geometry) (
    SFUNC = pgis_geometry_accum_transfn,
    STYPE = pgis_abs,
    FINALFUNC = pgis_geometry_makeline_finalfn
);


ALTER AGGREGATE public.st_makeline(geometry) OWNER TO postgres;

--
-- Name: st_memcollect(geometry); Type: AGGREGATE; Schema: public; Owner: postgres
--

CREATE AGGREGATE st_memcollect(geometry) (
    SFUNC = public.st_collect,
    STYPE = geometry
);


ALTER AGGREGATE public.st_memcollect(geometry) OWNER TO postgres;

--
-- Name: st_memunion(geometry); Type: AGGREGATE; Schema: public; Owner: postgres
--

CREATE AGGREGATE st_memunion(geometry) (
    SFUNC = public.st_union,
    STYPE = geometry
);


ALTER AGGREGATE public.st_memunion(geometry) OWNER TO postgres;

--
-- Name: st_polygonize(geometry); Type: AGGREGATE; Schema: public; Owner: postgres
--

CREATE AGGREGATE st_polygonize(geometry) (
    SFUNC = pgis_geometry_accum_transfn,
    STYPE = pgis_abs,
    FINALFUNC = pgis_geometry_polygonize_finalfn
);


ALTER AGGREGATE public.st_polygonize(geometry) OWNER TO postgres;

--
-- Name: st_union(geometry); Type: AGGREGATE; Schema: public; Owner: postgres
--

CREATE AGGREGATE st_union(geometry) (
    SFUNC = pgis_geometry_accum_transfn,
    STYPE = pgis_abs,
    FINALFUNC = pgis_geometry_union_finalfn
);


ALTER AGGREGATE public.st_union(geometry) OWNER TO postgres;

--
-- Name: &&; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR && (
    PROCEDURE = geometry_overlap,
    LEFTARG = geometry,
    RIGHTARG = geometry,
    COMMUTATOR = &&,
    RESTRICT = geometry_gist_sel,
    JOIN = geometry_gist_joinsel
);


ALTER OPERATOR public.&& (geometry, geometry) OWNER TO postgres;

--
-- Name: &&; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR && (
    PROCEDURE = geography_overlaps,
    LEFTARG = geography,
    RIGHTARG = geography,
    COMMUTATOR = &&,
    RESTRICT = geography_gist_selectivity,
    JOIN = geography_gist_join_selectivity
);


ALTER OPERATOR public.&& (geography, geography) OWNER TO postgres;

--
-- Name: &<; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR &< (
    PROCEDURE = geometry_overleft,
    LEFTARG = geometry,
    RIGHTARG = geometry,
    COMMUTATOR = &>,
    RESTRICT = positionsel,
    JOIN = positionjoinsel
);


ALTER OPERATOR public.&< (geometry, geometry) OWNER TO postgres;

--
-- Name: &<|; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR &<| (
    PROCEDURE = geometry_overbelow,
    LEFTARG = geometry,
    RIGHTARG = geometry,
    COMMUTATOR = |&>,
    RESTRICT = positionsel,
    JOIN = positionjoinsel
);


ALTER OPERATOR public.&<| (geometry, geometry) OWNER TO postgres;

--
-- Name: &>; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR &> (
    PROCEDURE = geometry_overright,
    LEFTARG = geometry,
    RIGHTARG = geometry,
    COMMUTATOR = &<,
    RESTRICT = positionsel,
    JOIN = positionjoinsel
);


ALTER OPERATOR public.&> (geometry, geometry) OWNER TO postgres;

--
-- Name: <; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR < (
    PROCEDURE = geometry_lt,
    LEFTARG = geometry,
    RIGHTARG = geometry,
    COMMUTATOR = >,
    NEGATOR = >=,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.< (geometry, geometry) OWNER TO postgres;

--
-- Name: <; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR < (
    PROCEDURE = geography_lt,
    LEFTARG = geography,
    RIGHTARG = geography,
    COMMUTATOR = >,
    NEGATOR = >=,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.< (geography, geography) OWNER TO postgres;

--
-- Name: <<; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR << (
    PROCEDURE = geometry_left,
    LEFTARG = geometry,
    RIGHTARG = geometry,
    COMMUTATOR = >>,
    RESTRICT = positionsel,
    JOIN = positionjoinsel
);


ALTER OPERATOR public.<< (geometry, geometry) OWNER TO postgres;

--
-- Name: <<|; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR <<| (
    PROCEDURE = geometry_below,
    LEFTARG = geometry,
    RIGHTARG = geometry,
    COMMUTATOR = |>>,
    RESTRICT = positionsel,
    JOIN = positionjoinsel
);


ALTER OPERATOR public.<<| (geometry, geometry) OWNER TO postgres;

--
-- Name: <=; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR <= (
    PROCEDURE = geometry_le,
    LEFTARG = geometry,
    RIGHTARG = geometry,
    COMMUTATOR = >=,
    NEGATOR = >,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.<= (geometry, geometry) OWNER TO postgres;

--
-- Name: <=; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR <= (
    PROCEDURE = geography_le,
    LEFTARG = geography,
    RIGHTARG = geography,
    COMMUTATOR = >=,
    NEGATOR = >,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.<= (geography, geography) OWNER TO postgres;

--
-- Name: =; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR = (
    PROCEDURE = geometry_eq,
    LEFTARG = geometry,
    RIGHTARG = geometry,
    COMMUTATOR = =,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.= (geometry, geometry) OWNER TO postgres;

--
-- Name: =; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR = (
    PROCEDURE = geography_eq,
    LEFTARG = geography,
    RIGHTARG = geography,
    COMMUTATOR = =,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.= (geography, geography) OWNER TO postgres;

--
-- Name: >; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR > (
    PROCEDURE = geometry_gt,
    LEFTARG = geometry,
    RIGHTARG = geometry,
    COMMUTATOR = <,
    NEGATOR = <=,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.> (geometry, geometry) OWNER TO postgres;

--
-- Name: >; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR > (
    PROCEDURE = geography_gt,
    LEFTARG = geography,
    RIGHTARG = geography,
    COMMUTATOR = <,
    NEGATOR = <=,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.> (geography, geography) OWNER TO postgres;

--
-- Name: >=; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR >= (
    PROCEDURE = geometry_ge,
    LEFTARG = geometry,
    RIGHTARG = geometry,
    COMMUTATOR = <=,
    NEGATOR = <,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.>= (geometry, geometry) OWNER TO postgres;

--
-- Name: >=; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR >= (
    PROCEDURE = geography_ge,
    LEFTARG = geography,
    RIGHTARG = geography,
    COMMUTATOR = <=,
    NEGATOR = <,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.>= (geography, geography) OWNER TO postgres;

--
-- Name: >>; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR >> (
    PROCEDURE = geometry_right,
    LEFTARG = geometry,
    RIGHTARG = geometry,
    COMMUTATOR = <<,
    RESTRICT = positionsel,
    JOIN = positionjoinsel
);


ALTER OPERATOR public.>> (geometry, geometry) OWNER TO postgres;

--
-- Name: @; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR @ (
    PROCEDURE = geometry_contained,
    LEFTARG = geometry,
    RIGHTARG = geometry,
    COMMUTATOR = ~,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.@ (geometry, geometry) OWNER TO postgres;

--
-- Name: |&>; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR |&> (
    PROCEDURE = geometry_overabove,
    LEFTARG = geometry,
    RIGHTARG = geometry,
    COMMUTATOR = &<|,
    RESTRICT = positionsel,
    JOIN = positionjoinsel
);


ALTER OPERATOR public.|&> (geometry, geometry) OWNER TO postgres;

--
-- Name: |>>; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR |>> (
    PROCEDURE = geometry_above,
    LEFTARG = geometry,
    RIGHTARG = geometry,
    COMMUTATOR = <<|,
    RESTRICT = positionsel,
    JOIN = positionjoinsel
);


ALTER OPERATOR public.|>> (geometry, geometry) OWNER TO postgres;

--
-- Name: ~; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR ~ (
    PROCEDURE = geometry_contain,
    LEFTARG = geometry,
    RIGHTARG = geometry,
    COMMUTATOR = @,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.~ (geometry, geometry) OWNER TO postgres;

--
-- Name: ~=; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR ~= (
    PROCEDURE = geometry_samebox,
    LEFTARG = geometry,
    RIGHTARG = geometry,
    COMMUTATOR = ~=,
    RESTRICT = eqsel,
    JOIN = eqjoinsel
);


ALTER OPERATOR public.~= (geometry, geometry) OWNER TO postgres;

--
-- Name: btree_geography_ops; Type: OPERATOR CLASS; Schema: public; Owner: postgres
--

CREATE OPERATOR CLASS btree_geography_ops
    DEFAULT FOR TYPE geography USING btree AS
    OPERATOR 1 <(geography,geography) ,
    OPERATOR 2 <=(geography,geography) ,
    OPERATOR 3 =(geography,geography) ,
    OPERATOR 4 >=(geography,geography) ,
    OPERATOR 5 >(geography,geography) ,
    FUNCTION 1 geography_cmp(geography,geography);


ALTER OPERATOR CLASS public.btree_geography_ops USING btree OWNER TO postgres;

--
-- Name: btree_geometry_ops; Type: OPERATOR CLASS; Schema: public; Owner: postgres
--

CREATE OPERATOR CLASS btree_geometry_ops
    DEFAULT FOR TYPE geometry USING btree AS
    OPERATOR 1 <(geometry,geometry) ,
    OPERATOR 2 <=(geometry,geometry) ,
    OPERATOR 3 =(geometry,geometry) ,
    OPERATOR 4 >=(geometry,geometry) ,
    OPERATOR 5 >(geometry,geometry) ,
    FUNCTION 1 geometry_cmp(geometry,geometry);


ALTER OPERATOR CLASS public.btree_geometry_ops USING btree OWNER TO postgres;

--
-- Name: gist_geography_ops; Type: OPERATOR CLASS; Schema: public; Owner: postgres
--

CREATE OPERATOR CLASS gist_geography_ops
    DEFAULT FOR TYPE geography USING gist AS
    STORAGE gidx ,
    OPERATOR 3 &&(geography,geography) ,
    FUNCTION 1 geography_gist_consistent(internal,geometry,integer) ,
    FUNCTION 2 geography_gist_union(bytea,internal) ,
    FUNCTION 3 geography_gist_compress(internal) ,
    FUNCTION 4 geography_gist_decompress(internal) ,
    FUNCTION 5 geography_gist_penalty(internal,internal,internal) ,
    FUNCTION 6 geography_gist_picksplit(internal,internal) ,
    FUNCTION 7 geography_gist_same(box2d,box2d,internal);


ALTER OPERATOR CLASS public.gist_geography_ops USING gist OWNER TO postgres;

--
-- Name: gist_geometry_ops; Type: OPERATOR CLASS; Schema: public; Owner: postgres
--

CREATE OPERATOR CLASS gist_geometry_ops
    DEFAULT FOR TYPE geometry USING gist AS
    STORAGE box2d ,
    OPERATOR 1 <<(geometry,geometry) ,
    OPERATOR 2 &<(geometry,geometry) ,
    OPERATOR 3 &&(geometry,geometry) ,
    OPERATOR 4 &>(geometry,geometry) ,
    OPERATOR 5 >>(geometry,geometry) ,
    OPERATOR 6 ~=(geometry,geometry) ,
    OPERATOR 7 ~(geometry,geometry) ,
    OPERATOR 8 @(geometry,geometry) ,
    OPERATOR 9 &<|(geometry,geometry) ,
    OPERATOR 10 <<|(geometry,geometry) ,
    OPERATOR 11 |>>(geometry,geometry) ,
    OPERATOR 12 |&>(geometry,geometry) ,
    FUNCTION 1 lwgeom_gist_consistent(internal,geometry,integer) ,
    FUNCTION 2 lwgeom_gist_union(bytea,internal) ,
    FUNCTION 3 lwgeom_gist_compress(internal) ,
    FUNCTION 4 lwgeom_gist_decompress(internal) ,
    FUNCTION 5 lwgeom_gist_penalty(internal,internal,internal) ,
    FUNCTION 6 lwgeom_gist_picksplit(internal,internal) ,
    FUNCTION 7 lwgeom_gist_same(box2d,box2d,internal);


ALTER OPERATOR CLASS public.gist_geometry_ops USING gist OWNER TO postgres;

SET search_path = pg_catalog;

--
-- Name: CAST (public.box2d AS public.box3d); Type: CAST; Schema: pg_catalog; Owner: 
--

CREATE CAST (public.box2d AS public.box3d) WITH FUNCTION public.box3d(public.box2d) AS IMPLICIT;


--
-- Name: CAST (public.box2d AS public.geometry); Type: CAST; Schema: pg_catalog; Owner: 
--

CREATE CAST (public.box2d AS public.geometry) WITH FUNCTION public.geometry(public.box2d) AS IMPLICIT;


--
-- Name: CAST (public.box3d AS box); Type: CAST; Schema: pg_catalog; Owner: 
--

CREATE CAST (public.box3d AS box) WITH FUNCTION public.box(public.box3d) AS IMPLICIT;


--
-- Name: CAST (public.box3d AS public.box2d); Type: CAST; Schema: pg_catalog; Owner: 
--

CREATE CAST (public.box3d AS public.box2d) WITH FUNCTION public.box2d(public.box3d) AS IMPLICIT;


--
-- Name: CAST (public.box3d AS public.geometry); Type: CAST; Schema: pg_catalog; Owner: 
--

CREATE CAST (public.box3d AS public.geometry) WITH FUNCTION public.geometry(public.box3d) AS IMPLICIT;


--
-- Name: CAST (public.box3d_extent AS public.box2d); Type: CAST; Schema: pg_catalog; Owner: 
--

CREATE CAST (public.box3d_extent AS public.box2d) WITH FUNCTION public.box2d(public.box3d_extent) AS IMPLICIT;


--
-- Name: CAST (public.box3d_extent AS public.box3d); Type: CAST; Schema: pg_catalog; Owner: 
--

CREATE CAST (public.box3d_extent AS public.box3d) WITH FUNCTION public.box3d_extent(public.box3d_extent) AS IMPLICIT;


--
-- Name: CAST (public.box3d_extent AS public.geometry); Type: CAST; Schema: pg_catalog; Owner: 
--

CREATE CAST (public.box3d_extent AS public.geometry) WITH FUNCTION public.geometry(public.box3d_extent) AS IMPLICIT;


--
-- Name: CAST (bytea AS public.geometry); Type: CAST; Schema: pg_catalog; Owner: 
--

CREATE CAST (bytea AS public.geometry) WITH FUNCTION public.geometry(bytea) AS IMPLICIT;


--
-- Name: CAST (public.chip AS public.geometry); Type: CAST; Schema: pg_catalog; Owner: 
--

CREATE CAST (public.chip AS public.geometry) WITH FUNCTION public.geometry(public.chip) AS IMPLICIT;


--
-- Name: CAST (public.geography AS public.geography); Type: CAST; Schema: pg_catalog; Owner: 
--

CREATE CAST (public.geography AS public.geography) WITH FUNCTION public.geography(public.geography, integer, boolean) AS IMPLICIT;


--
-- Name: CAST (public.geography AS public.geometry); Type: CAST; Schema: pg_catalog; Owner: 
--

CREATE CAST (public.geography AS public.geometry) WITH FUNCTION public.geometry(public.geography);


--
-- Name: CAST (public.geometry AS box); Type: CAST; Schema: pg_catalog; Owner: 
--

CREATE CAST (public.geometry AS box) WITH FUNCTION public.box(public.geometry) AS IMPLICIT;


--
-- Name: CAST (public.geometry AS public.box2d); Type: CAST; Schema: pg_catalog; Owner: 
--

CREATE CAST (public.geometry AS public.box2d) WITH FUNCTION public.box2d(public.geometry) AS IMPLICIT;


--
-- Name: CAST (public.geometry AS public.box3d); Type: CAST; Schema: pg_catalog; Owner: 
--

CREATE CAST (public.geometry AS public.box3d) WITH FUNCTION public.box3d(public.geometry) AS IMPLICIT;


--
-- Name: CAST (public.geometry AS bytea); Type: CAST; Schema: pg_catalog; Owner: 
--

CREATE CAST (public.geometry AS bytea) WITH FUNCTION public.bytea(public.geometry) AS IMPLICIT;


--
-- Name: CAST (public.geometry AS public.geography); Type: CAST; Schema: pg_catalog; Owner: 
--

CREATE CAST (public.geometry AS public.geography) WITH FUNCTION public.geography(public.geometry) AS IMPLICIT;


--
-- Name: CAST (public.geometry AS text); Type: CAST; Schema: pg_catalog; Owner: 
--

CREATE CAST (public.geometry AS text) WITH FUNCTION public.text(public.geometry) AS IMPLICIT;


--
-- Name: CAST (text AS public.geometry); Type: CAST; Schema: pg_catalog; Owner: 
--

CREATE CAST (text AS public.geometry) WITH FUNCTION public.geometry(text) AS IMPLICIT;


SET search_path = public, pg_catalog;

--
-- Name: geography_columns; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW geography_columns AS
    SELECT current_database() AS f_table_catalog, n.nspname AS f_table_schema, c.relname AS f_table_name, a.attname AS f_geography_column, geography_typmod_dims(a.atttypmod) AS coord_dimension, geography_typmod_srid(a.atttypmod) AS srid, geography_typmod_type(a.atttypmod) AS type FROM pg_class c, pg_attribute a, pg_type t, pg_namespace n WHERE ((((((t.typname = 'geography'::name) AND (a.attisdropped = false)) AND (a.atttypid = t.oid)) AND (a.attrelid = c.oid)) AND (c.relnamespace = n.oid)) AND (NOT pg_is_other_temp_schema(c.relnamespace)));


ALTER TABLE public.geography_columns OWNER TO postgres;

SET default_tablespace = '';

SET default_with_oids = true;

--
-- Name: geometry_columns; Type: TABLE; Schema: public; Owner: imiq; Tablespace: 
--

CREATE TABLE geometry_columns (
    f_table_catalog character varying(256) NOT NULL,
    f_table_schema character varying(256) NOT NULL,
    f_table_name character varying(256) NOT NULL,
    f_geometry_column character varying(256) NOT NULL,
    coord_dimension integer NOT NULL,
    srid integer NOT NULL,
    type character varying(30) NOT NULL
);


ALTER TABLE public.geometry_columns OWNER TO imiq;

SET default_with_oids = false;

--
-- Name: spatial_ref_sys; Type: TABLE; Schema: public; Owner: imiq; Tablespace: 
--

CREATE TABLE spatial_ref_sys (
    srid integer NOT NULL,
    auth_name character varying(256),
    auth_srid integer,
    srtext character varying(2048),
    proj4text character varying(2048)
);


ALTER TABLE public.spatial_ref_sys OWNER TO imiq;

SET search_path = tables, pg_catalog;

--
-- Name: _sites_summary; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE TABLE _sites_summary (
    siteid integer NOT NULL,
    geolocation text NOT NULL,
    begindate character varying(10) NOT NULL,
    enddate character varying(10) NOT NULL
);


ALTER TABLE tables._sites_summary OWNER TO imiq;

--
-- Name: _siteswithelevations; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE TABLE _siteswithelevations (
    siteid integer,
    geolocation text,
    sourcedatum text
);


ALTER TABLE tables._siteswithelevations OWNER TO imiq;

--
-- Name: annual_avgrh_all; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE TABLE annual_avgrh_all (
    siteid integer NOT NULL,
    year integer,
    rh double precision,
    at double precision
);


ALTER TABLE tables.annual_avgrh_all OWNER TO imiq;

--
-- Name: annual_avgwinterairtemp_all; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE TABLE annual_avgwinterairtemp_all (
    siteid integer NOT NULL,
    year integer,
    seasonalavg double precision
);


ALTER TABLE tables.annual_avgwinterairtemp_all OWNER TO imiq;

--
-- Name: annual_avgwinterprecip_all; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE TABLE annual_avgwinterprecip_all (
    siteid integer NOT NULL,
    year integer,
    seasonalavg double precision
);


ALTER TABLE tables.annual_avgwinterprecip_all OWNER TO imiq;

--
-- Name: annual_avgwinterrh_all; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE TABLE annual_avgwinterrh_all (
    siteid integer NOT NULL,
    year integer,
    seasonalavgrh double precision,
    seasonalavgat double precision
);


ALTER TABLE tables.annual_avgwinterrh_all OWNER TO imiq;

--
-- Name: annual_peakdischarge_all; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE TABLE annual_peakdischarge_all (
    siteid integer NOT NULL,
    year integer,
    datavalue double precision
);


ALTER TABLE tables.annual_peakdischarge_all OWNER TO imiq;

--
-- Name: annual_peaksnowdepth_all; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE TABLE annual_peaksnowdepth_all (
    siteid integer NOT NULL,
    year integer,
    datavalue double precision
);


ALTER TABLE tables.annual_peaksnowdepth_all OWNER TO imiq;

--
-- Name: annual_peakswe_all; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE TABLE annual_peakswe_all (
    siteid integer NOT NULL,
    year integer,
    datavalue double precision
);


ALTER TABLE tables.annual_peakswe_all OWNER TO imiq;

--
-- Name: annual_totalprecip_all; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE TABLE annual_totalprecip_all (
    siteid integer NOT NULL,
    year integer,
    datavalue double precision
);


ALTER TABLE tables.annual_totalprecip_all OWNER TO imiq;

--
-- Name: attributes; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE TABLE attributes (
    attributeid integer NOT NULL,
    attributename character varying(255) NOT NULL
);


ALTER TABLE tables.attributes OWNER TO imiq;

--
-- Name: TABLE attributes; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON TABLE attributes IS 'Describes non-numeric data values for a Site.';


--
-- Name: COLUMN attributes.attributeid; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN attributes.attributeid IS 'Unique integer ID for each attribute.';


--
-- Name: COLUMN attributes.attributename; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN attributes.attributename IS 'The name of the attribute.';


--
-- Name: attributes_attributeid_seq; Type: SEQUENCE; Schema: tables; Owner: imiq
--

CREATE SEQUENCE attributes_attributeid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tables.attributes_attributeid_seq OWNER TO imiq;

--
-- Name: attributes_attributeid_seq; Type: SEQUENCE OWNED BY; Schema: tables; Owner: imiq
--

ALTER SEQUENCE attributes_attributeid_seq OWNED BY attributes.attributeid;


--
-- Name: categories; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE TABLE categories (
    categoryid integer NOT NULL,
    variableid integer NOT NULL,
    categoryname character varying(255) NOT NULL,
    categorydescription text
);


ALTER TABLE tables.categories OWNER TO imiq;

--
-- Name: COLUMN categories.categoryid; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN categories.categoryid IS 'Primary key for Categories.';


--
-- Name: COLUMN categories.variableid; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN categories.variableid IS 'Integer identifier that references the record in the Variables table.';


--
-- Name: COLUMN categories.categoryname; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN categories.categoryname IS 'Category name that is used to describe the category.';


--
-- Name: COLUMN categories.categorydescription; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN categories.categorydescription IS 'Category definition.';


--
-- Name: categories_categoryid_seq; Type: SEQUENCE; Schema: tables; Owner: imiq
--

CREATE SEQUENCE categories_categoryid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tables.categories_categoryid_seq OWNER TO imiq;

--
-- Name: categories_categoryid_seq; Type: SEQUENCE OWNED BY; Schema: tables; Owner: imiq
--

ALTER SEQUENCE categories_categoryid_seq OWNED BY categories.categoryid;


--
-- Name: censorcodecv; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE TABLE censorcodecv (
    term character varying(50) NOT NULL,
    definition text
);


ALTER TABLE tables.censorcodecv OWNER TO imiq;

--
-- Name: TABLE censorcodecv; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON TABLE censorcodecv IS 'The CensorCodeCV table contains the controlled vocabulary for censor codes. Only values from the Term field in this table can be used to populate the CensorCode field of the DataValues table.';


--
-- Name: COLUMN censorcodecv.term; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN censorcodecv.term IS 'Controlled vocabulary for CensorCode.';


--
-- Name: COLUMN censorcodecv.definition; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN censorcodecv.definition IS 'Definition of CensorCode controlled vocabulary term. The definition is optional if the term is self explanatory.';


--
-- Name: daily_airtempdatavalues; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE TABLE daily_airtempdatavalues (
    valueid integer NOT NULL,
    datavalue double precision,
    utcdatetime timestamp without time zone NOT NULL,
    siteid integer NOT NULL,
    originalvariableid integer NOT NULL,
    insertdate timestamp without time zone
);


ALTER TABLE tables.daily_airtempdatavalues OWNER TO imiq;

--
-- Name: daily_airtempdatavalues_valueid_seq; Type: SEQUENCE; Schema: tables; Owner: imiq
--

CREATE SEQUENCE daily_airtempdatavalues_valueid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tables.daily_airtempdatavalues_valueid_seq OWNER TO imiq;

--
-- Name: daily_airtempdatavalues_valueid_seq; Type: SEQUENCE OWNED BY; Schema: tables; Owner: imiq
--

ALTER SEQUENCE daily_airtempdatavalues_valueid_seq OWNED BY daily_airtempdatavalues.valueid;


--
-- Name: daily_airtempmaxdatavalues; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE TABLE daily_airtempmaxdatavalues (
    valueid integer NOT NULL,
    datavalue double precision,
    utcdatetime timestamp without time zone NOT NULL,
    siteid integer NOT NULL,
    originalvariableid integer NOT NULL,
    insertdate timestamp without time zone
);


ALTER TABLE tables.daily_airtempmaxdatavalues OWNER TO imiq;

--
-- Name: daily_airtempmaxdatavalues_valueid_seq; Type: SEQUENCE; Schema: tables; Owner: imiq
--

CREATE SEQUENCE daily_airtempmaxdatavalues_valueid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tables.daily_airtempmaxdatavalues_valueid_seq OWNER TO imiq;

--
-- Name: daily_airtempmaxdatavalues_valueid_seq; Type: SEQUENCE OWNED BY; Schema: tables; Owner: imiq
--

ALTER SEQUENCE daily_airtempmaxdatavalues_valueid_seq OWNED BY daily_airtempmaxdatavalues.valueid;


--
-- Name: daily_airtempmindatavalues; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE TABLE daily_airtempmindatavalues (
    valueid integer NOT NULL,
    datavalue double precision,
    utcdatetime timestamp without time zone NOT NULL,
    siteid integer NOT NULL,
    originalvariableid integer NOT NULL,
    insertdate timestamp without time zone
);


ALTER TABLE tables.daily_airtempmindatavalues OWNER TO imiq;

--
-- Name: daily_airtempmindatavalues_valueid_seq; Type: SEQUENCE; Schema: tables; Owner: imiq
--

CREATE SEQUENCE daily_airtempmindatavalues_valueid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tables.daily_airtempmindatavalues_valueid_seq OWNER TO imiq;

--
-- Name: daily_airtempmindatavalues_valueid_seq; Type: SEQUENCE OWNED BY; Schema: tables; Owner: imiq
--

ALTER SEQUENCE daily_airtempmindatavalues_valueid_seq OWNED BY daily_airtempmindatavalues.valueid;


--
-- Name: daily_dischargedatavalues; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE TABLE daily_dischargedatavalues (
    valueid integer NOT NULL,
    datavalue double precision,
    utcdatetime timestamp without time zone NOT NULL,
    siteid integer NOT NULL,
    originalvariableid integer NOT NULL
);


ALTER TABLE tables.daily_dischargedatavalues OWNER TO imiq;

--
-- Name: daily_dischargedatavalues_valueid_seq; Type: SEQUENCE; Schema: tables; Owner: imiq
--

CREATE SEQUENCE daily_dischargedatavalues_valueid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tables.daily_dischargedatavalues_valueid_seq OWNER TO imiq;

--
-- Name: daily_dischargedatavalues_valueid_seq; Type: SEQUENCE OWNED BY; Schema: tables; Owner: imiq
--

ALTER SEQUENCE daily_dischargedatavalues_valueid_seq OWNED BY daily_dischargedatavalues.valueid;


--
-- Name: daily_precip; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE TABLE daily_precip (
    valueid integer NOT NULL,
    datavalue double precision,
    utcdatetime timestamp without time zone NOT NULL,
    siteid integer NOT NULL,
    originalvariableid integer NOT NULL,
    variableid integer NOT NULL
);


ALTER TABLE tables.daily_precip OWNER TO imiq;

--
-- Name: daily_precip_thresholds; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE TABLE daily_precip_thresholds (
    siteid integer NOT NULL,
    minthreshold integer NOT NULL,
    maxthreshold integer NOT NULL
);


ALTER TABLE tables.daily_precip_thresholds OWNER TO imiq;

--
-- Name: daily_precipdatavalues; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE TABLE daily_precipdatavalues (
    valueid integer NOT NULL,
    datavalue double precision,
    utcdatetime timestamp without time zone NOT NULL,
    siteid integer NOT NULL,
    originalvariableid integer NOT NULL,
    insertdate timestamp without time zone
);


ALTER TABLE tables.daily_precipdatavalues OWNER TO imiq;

--
-- Name: daily_precipdatavalues_valueid_seq; Type: SEQUENCE; Schema: tables; Owner: imiq
--

CREATE SEQUENCE daily_precipdatavalues_valueid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tables.daily_precipdatavalues_valueid_seq OWNER TO imiq;

--
-- Name: daily_precipdatavalues_valueid_seq; Type: SEQUENCE OWNED BY; Schema: tables; Owner: imiq
--

ALTER SEQUENCE daily_precipdatavalues_valueid_seq OWNED BY daily_precipdatavalues.valueid;


--
-- Name: daily_rhdatavalues; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE TABLE daily_rhdatavalues (
    valueid integer NOT NULL,
    datavalue double precision,
    utcdatetime timestamp without time zone NOT NULL,
    siteid integer NOT NULL,
    originalvariableid integer NOT NULL,
    insertdate timestamp without time zone
);


ALTER TABLE tables.daily_rhdatavalues OWNER TO imiq;

--
-- Name: daily_rhdatavalues_valueid_seq; Type: SEQUENCE; Schema: tables; Owner: imiq
--

CREATE SEQUENCE daily_rhdatavalues_valueid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tables.daily_rhdatavalues_valueid_seq OWNER TO imiq;

--
-- Name: daily_rhdatavalues_valueid_seq; Type: SEQUENCE OWNED BY; Schema: tables; Owner: imiq
--

ALTER SEQUENCE daily_rhdatavalues_valueid_seq OWNED BY daily_rhdatavalues.valueid;


--
-- Name: daily_snowdepth; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE TABLE daily_snowdepth (
    valueid integer NOT NULL,
    datavalue double precision,
    utcdatetime timestamp without time zone NOT NULL,
    siteid integer NOT NULL,
    originalvariableid integer NOT NULL,
    variableid integer NOT NULL
);


ALTER TABLE tables.daily_snowdepth OWNER TO imiq;

--
-- Name: daily_snowdepthdatavalues; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE TABLE daily_snowdepthdatavalues (
    valueid integer NOT NULL,
    datavalue double precision,
    utcdatetime timestamp without time zone NOT NULL,
    siteid integer NOT NULL,
    originalvariableid integer NOT NULL,
    insertdate timestamp without time zone
);


ALTER TABLE tables.daily_snowdepthdatavalues OWNER TO imiq;

--
-- Name: daily_snowdepthdatavalues_valueid_seq; Type: SEQUENCE; Schema: tables; Owner: imiq
--

CREATE SEQUENCE daily_snowdepthdatavalues_valueid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tables.daily_snowdepthdatavalues_valueid_seq OWNER TO imiq;

--
-- Name: daily_snowdepthdatavalues_valueid_seq; Type: SEQUENCE OWNED BY; Schema: tables; Owner: imiq
--

ALTER SEQUENCE daily_snowdepthdatavalues_valueid_seq OWNED BY daily_snowdepthdatavalues.valueid;


--
-- Name: daily_swe; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE TABLE daily_swe (
    valueid integer NOT NULL,
    datavalue double precision,
    utcdatetime timestamp without time zone NOT NULL,
    siteid integer NOT NULL,
    originalvariableid integer NOT NULL,
    variableid integer NOT NULL
);


ALTER TABLE tables.daily_swe OWNER TO imiq;

--
-- Name: daily_swedatavalues; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE TABLE daily_swedatavalues (
    valueid integer NOT NULL,
    datavalue double precision,
    utcdatetime timestamp without time zone NOT NULL,
    siteid integer NOT NULL,
    originalvariableid integer NOT NULL,
    insertdate timestamp without time zone
);


ALTER TABLE tables.daily_swedatavalues OWNER TO imiq;

--
-- Name: daily_swedatavalues_valueid_seq; Type: SEQUENCE; Schema: tables; Owner: imiq
--

CREATE SEQUENCE daily_swedatavalues_valueid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tables.daily_swedatavalues_valueid_seq OWNER TO imiq;

--
-- Name: daily_swedatavalues_valueid_seq; Type: SEQUENCE OWNED BY; Schema: tables; Owner: imiq
--

ALTER SEQUENCE daily_swedatavalues_valueid_seq OWNED BY daily_swedatavalues.valueid;


--
-- Name: daily_watertempdatavalues; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE TABLE daily_watertempdatavalues (
    valueid integer NOT NULL,
    datavalue double precision,
    utcdatetime timestamp without time zone NOT NULL,
    siteid integer NOT NULL,
    originalvariableid integer NOT NULL,
    insertdate timestamp without time zone
);


ALTER TABLE tables.daily_watertempdatavalues OWNER TO imiq;

--
-- Name: daily_watertempdatavalues_valueid_seq; Type: SEQUENCE; Schema: tables; Owner: imiq
--

CREATE SEQUENCE daily_watertempdatavalues_valueid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tables.daily_watertempdatavalues_valueid_seq OWNER TO imiq;

--
-- Name: daily_watertempdatavalues_valueid_seq; Type: SEQUENCE OWNED BY; Schema: tables; Owner: imiq
--

ALTER SEQUENCE daily_watertempdatavalues_valueid_seq OWNED BY daily_watertempdatavalues.valueid;


--
-- Name: daily_winddirectiondatavalues; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE TABLE daily_winddirectiondatavalues (
    valueid integer NOT NULL,
    datavalue double precision,
    utcdatetime timestamp without time zone NOT NULL,
    siteid integer NOT NULL,
    originalvariableid integer NOT NULL,
    offsetvalue integer,
    offsettypeid integer,
    insertdate timestamp without time zone
);


ALTER TABLE tables.daily_winddirectiondatavalues OWNER TO imiq;

--
-- Name: daily_winddirectiondatavalues_valueid_seq; Type: SEQUENCE; Schema: tables; Owner: imiq
--

CREATE SEQUENCE daily_winddirectiondatavalues_valueid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tables.daily_winddirectiondatavalues_valueid_seq OWNER TO imiq;

--
-- Name: daily_winddirectiondatavalues_valueid_seq; Type: SEQUENCE OWNED BY; Schema: tables; Owner: imiq
--

ALTER SEQUENCE daily_winddirectiondatavalues_valueid_seq OWNED BY daily_winddirectiondatavalues.valueid;


--
-- Name: daily_windspeeddatavalues; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE TABLE daily_windspeeddatavalues (
    valueid integer NOT NULL,
    datavalue double precision,
    utcdatetime timestamp without time zone NOT NULL,
    siteid integer NOT NULL,
    originalvariableid integer NOT NULL,
    offsetvalue integer,
    offsettypeid integer,
    insertdate timestamp without time zone
);


ALTER TABLE tables.daily_windspeeddatavalues OWNER TO imiq;

--
-- Name: daily_windspeeddatavalues_valueid_seq; Type: SEQUENCE; Schema: tables; Owner: imiq
--

CREATE SEQUENCE daily_windspeeddatavalues_valueid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tables.daily_windspeeddatavalues_valueid_seq OWNER TO imiq;

--
-- Name: daily_windspeeddatavalues_valueid_seq; Type: SEQUENCE OWNED BY; Schema: tables; Owner: imiq
--

ALTER SEQUENCE daily_windspeeddatavalues_valueid_seq OWNED BY daily_windspeeddatavalues.valueid;


--
-- Name: datastreams; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE TABLE datastreams (
    datastreamid integer NOT NULL,
    datastreamname character varying(255) NOT NULL,
    siteid integer NOT NULL,
    variableid integer NOT NULL,
    fieldname character varying(50),
    deviceid integer NOT NULL,
    methodid integer NOT NULL,
    comments text,
    qualitycontrollevelid integer,
    rangemin numeric(8,2),
    rangemax numeric(8,2),
    annualtiming character varying(255),
    downloaddate date,
    bdate character varying(10),
    edate character varying(10)
);


ALTER TABLE tables.datastreams OWNER TO imiq;

--
-- Name: TABLE datastreams; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON TABLE datastreams IS 'The datasteam assigns a variable to a station.  It also includes additional information that can be used for QA/QC on the data values for this station.';


--
-- Name: COLUMN datastreams.datastreamid; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN datastreams.datastreamid IS 'Primary key for Datastreams.';


--
-- Name: COLUMN datastreams.datastreamname; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN datastreams.datastreamname IS 'Name of the datastream.  Example: SiteName_VariableName';


--
-- Name: COLUMN datastreams.siteid; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN datastreams.siteid IS 'Integer identifier that references the record in the Sites table.';


--
-- Name: COLUMN datastreams.variableid; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN datastreams.variableid IS 'Integer identifier that references the record in the Variables table.';


--
-- Name: COLUMN datastreams.fieldname; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN datastreams.fieldname IS 'Name of the fieldname that is used in the data file.';


--
-- Name: COLUMN datastreams.deviceid; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN datastreams.deviceid IS 'Integer identifier that references the record in the Devices table.';


--
-- Name: COLUMN datastreams.methodid; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN datastreams.methodid IS 'Integer identifier that references the record in the Methods table.';


--
-- Name: COLUMN datastreams.comments; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN datastreams.comments IS 'Notes concerning datastream, such as flag or notes from data logger files.';


--
-- Name: COLUMN datastreams.qualitycontrollevelid; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN datastreams.qualitycontrollevelid IS 'Integer identifier that references the record in the QualityControlLevels table.';


--
-- Name: COLUMN datastreams.rangemin; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN datastreams.rangemin IS 'The acceptable range minimum for the sensor. ';


--
-- Name: COLUMN datastreams.rangemax; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN datastreams.rangemax IS 'The acceptable range maximum for the sensor';


--
-- Name: COLUMN datastreams.annualtiming; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN datastreams.annualtiming IS 'Known range';


--
-- Name: COLUMN datastreams.downloaddate; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN datastreams.downloaddate IS 'Date the dataset was downloaded or acquired';


--
-- Name: datastreams_datastreamid_seq; Type: SEQUENCE; Schema: tables; Owner: imiq
--

CREATE SEQUENCE datastreams_datastreamid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tables.datastreams_datastreamid_seq OWNER TO imiq;

--
-- Name: datastreams_datastreamid_seq; Type: SEQUENCE OWNED BY; Schema: tables; Owner: imiq
--

ALTER SEQUENCE datastreams_datastreamid_seq OWNED BY datastreams.datastreamid;


--
-- Name: datatypecv; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE TABLE datatypecv (
    term character varying(255) NOT NULL,
    definition text
);


ALTER TABLE tables.datatypecv OWNER TO imiq;

--
-- Name: TABLE datatypecv; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON TABLE datatypecv IS 'The DataTypeCV table contains the controlled vocabulary for data types. Only values from the Term field in this table can be used to populate the DataType field in the Variables table.';


--
-- Name: COLUMN datatypecv.term; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN datatypecv.term IS 'Controlled vocabulary for DataType.';


--
-- Name: COLUMN datatypecv.definition; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN datatypecv.definition IS 'Definition of DataType controlled vocabulary term. The definition is optional if the term is self explanatory.';


--
-- Name: datavalues; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE TABLE datavalues (
    valueid integer NOT NULL,
    datavalue double precision,
    valueaccuracy double precision,
    localdatetime timestamp without time zone NOT NULL,
    utcoffset double precision NOT NULL,
    qualifierid integer,
    derivedfromid integer,
    datastreamid integer NOT NULL,
    censorcode character varying(50),
    offsettypeid integer,
    offsetvalue double precision,
    categoryid integer
);


ALTER TABLE tables.datavalues OWNER TO imiq;

--
-- Name: TABLE datavalues; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON TABLE datavalues IS 'The DataValues table contains the actual data values.';


--
-- Name: COLUMN datavalues.valueid; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN datavalues.valueid IS 'Unique integer identifier for each data value.';


--
-- Name: COLUMN datavalues.datavalue; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN datavalues.datavalue IS 'The numeric value of the observation. For Categorical variables, a number is stored here. The Variables table has DataType as Categorical and the Categories table maps from the DataValue onto Category Description.';


--
-- Name: COLUMN datavalues.valueaccuracy; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN datavalues.valueaccuracy IS 'Numeric value that describes the measurement accuracy of the data value. If not given, it is interpreted as unknown.';


--
-- Name: COLUMN datavalues.localdatetime; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN datavalues.localdatetime IS 'Local date and time at which the data value was observed. Represented in an implementation specific format.';


--
-- Name: COLUMN datavalues.utcoffset; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN datavalues.utcoffset IS 'Offset in hours from UTC time of the corresponding LocalDateTime value.';


--
-- Name: COLUMN datavalues.qualifierid; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN datavalues.qualifierid IS 'Integer identifier that references the quality of the data in the Qualifiers table.';


--
-- Name: COLUMN datavalues.derivedfromid; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN datavalues.derivedfromid IS 'Integer identifier that references the derived data in the DerivedFrom table.';


--
-- Name: COLUMN datavalues.datastreamid; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN datavalues.datastreamid IS 'Integer identifier that references the datastream in the Datastreams table.';


--
-- Name: COLUMN datavalues.censorcode; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN datavalues.censorcode IS 'Text indication of whether the data value is censored from the CensorCodeCV controlled vocabulary.';


--
-- Name: COLUMN datavalues.offsettypeid; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN datavalues.offsettypeid IS 'Foreign key OffsetTypes.  The reference point from which the offset to the measurement location was measured (e.g. water surface, stream bank, snow surface)';


--
-- Name: COLUMN datavalues.offsetvalue; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN datavalues.offsetvalue IS 'Distance from a reference point to the location at which the observation was made (e.g. 5 meters below water surface)';


--
-- Name: COLUMN datavalues.categoryid; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN datavalues.categoryid IS 'FK to the Category table.  This field will contain a value if there is categorical data.';


--
-- Name: datavalues_valueid_seq; Type: SEQUENCE; Schema: tables; Owner: imiq
--

CREATE SEQUENCE datavalues_valueid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tables.datavalues_valueid_seq OWNER TO imiq;

--
-- Name: datavalues_valueid_seq; Type: SEQUENCE OWNED BY; Schema: tables; Owner: imiq
--

ALTER SEQUENCE datavalues_valueid_seq OWNED BY datavalues.valueid;


--
-- Name: datavaluesraw; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE TABLE datavaluesraw (
    valueid integer NOT NULL,
    datavalue double precision,
    valueaccuracy double precision,
    localdatetime timestamp without time zone NOT NULL,
    utcoffset double precision NOT NULL,
    qualifierid integer,
    datastreamid integer NOT NULL
);


ALTER TABLE tables.datavaluesraw OWNER TO imiq;

--
-- Name: datavaluesraw_valueid_seq; Type: SEQUENCE; Schema: tables; Owner: imiq
--

CREATE SEQUENCE datavaluesraw_valueid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tables.datavaluesraw_valueid_seq OWNER TO imiq;

--
-- Name: datavaluesraw_valueid_seq; Type: SEQUENCE OWNED BY; Schema: tables; Owner: imiq
--

ALTER SEQUENCE datavaluesraw_valueid_seq OWNED BY datavaluesraw.valueid;


--
-- Name: derivedfrom; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE TABLE derivedfrom (
    derivedfromid integer NOT NULL,
    valueid integer NOT NULL
);


ALTER TABLE tables.derivedfrom OWNER TO imiq;

--
-- Name: TABLE derivedfrom; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON TABLE derivedfrom IS 'The DerivedFrom table contains the linkage between derived data values and the data values that they were derived from.';


--
-- Name: COLUMN derivedfrom.derivedfromid; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN derivedfrom.derivedfromid IS 'Integer identifying the group of data values from which a quantity is derived.';


--
-- Name: COLUMN derivedfrom.valueid; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN derivedfrom.valueid IS 'Integer identifier referencing data values that comprise a group from which a quantity is derived. This corresponds to ValueID in the DataValues table.';


--
-- Name: devices; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE TABLE devices (
    deviceid integer NOT NULL,
    devicename character varying(255) NOT NULL,
    serialnumber character varying(50),
    dateactivated date,
    datedeactivated date,
    comments text
);


ALTER TABLE tables.devices OWNER TO imiq;

--
-- Name: devices_deviceid_seq; Type: SEQUENCE; Schema: tables; Owner: imiq
--

CREATE SEQUENCE devices_deviceid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tables.devices_deviceid_seq OWNER TO imiq;

--
-- Name: devices_deviceid_seq; Type: SEQUENCE OWNED BY; Schema: tables; Owner: imiq
--

ALTER SEQUENCE devices_deviceid_seq OWNED BY devices.deviceid;


--
-- Name: ext_arc_arc; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE TABLE ext_arc_arc (
    id integer NOT NULL,
    stream_cod character varying(255),
    name character varying(255),
    source character varying(255),
    shape_leng real,
    geom public.geometry
);


ALTER TABLE tables.ext_arc_arc OWNER TO imiq;

--
-- Name: ext_arc_arc_id_seq; Type: SEQUENCE; Schema: tables; Owner: imiq
--

CREATE SEQUENCE ext_arc_arc_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tables.ext_arc_arc_id_seq OWNER TO imiq;

--
-- Name: ext_arc_arc_id_seq; Type: SEQUENCE OWNED BY; Schema: tables; Owner: imiq
--

ALTER SEQUENCE ext_arc_arc_id_seq OWNED BY ext_arc_arc.id;


--
-- Name: ext_arc_point; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE TABLE ext_arc_point (
    id integer NOT NULL,
    x_coord real,
    y_coord real,
    lat real,
    long_ real,
    mtrs character varying(255),
    type character varying(255),
    plotsym integer,
    quad character varying(255),
    stream_cod character varying(255),
    name character varying(255),
    specstr character varying(255),
    midangle integer,
    geom public.geometry
);


ALTER TABLE tables.ext_arc_point OWNER TO imiq;

--
-- Name: ext_arc_point_id_seq; Type: SEQUENCE; Schema: tables; Owner: imiq
--

CREATE SEQUENCE ext_arc_point_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tables.ext_arc_point_id_seq OWNER TO imiq;

--
-- Name: ext_arc_point_id_seq; Type: SEQUENCE OWNED BY; Schema: tables; Owner: imiq
--

ALTER SEQUENCE ext_arc_point_id_seq OWNED BY ext_arc_point.id;


--
-- Name: ext_fws_fishsample; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE TABLE ext_fws_fishsample (
    fishsampleid integer NOT NULL,
    siteid integer NOT NULL,
    fishname character varying(255),
    fry character varying(50),
    juvenile character varying(50),
    adult character varying(50),
    anadromous character varying(50),
    resident character varying(50),
    occasional character varying(50),
    rearing character varying(50),
    feeding character varying(50),
    spawning character varying(50),
    overwinter character varying(50)
);


ALTER TABLE tables.ext_fws_fishsample OWNER TO imiq;

--
-- Name: ext_fws_fishsample_fishsampleid_seq; Type: SEQUENCE; Schema: tables; Owner: imiq
--

CREATE SEQUENCE ext_fws_fishsample_fishsampleid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tables.ext_fws_fishsample_fishsampleid_seq OWNER TO imiq;

--
-- Name: ext_fws_fishsample_fishsampleid_seq; Type: SEQUENCE OWNED BY; Schema: tables; Owner: imiq
--

ALTER SEQUENCE ext_fws_fishsample_fishsampleid_seq OWNED BY ext_fws_fishsample.fishsampleid;


--
-- Name: ext_reference; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE TABLE ext_reference (
    referenceid integer NOT NULL,
    referencename character varying(500),
    authors character varying(500),
    year character varying(50),
    title character varying(500),
    publication character varying(500),
    fishdatatype character varying(500),
    waterdatatype character varying(500),
    lakesreferenced integer,
    riversreferenced integer,
    springsreferenced integer,
    pdf character varying(500),
    comments character varying(500),
    ref_id character varying(50),
    geographicarea character varying(500)
);


ALTER TABLE tables.ext_reference OWNER TO imiq;

--
-- Name: ext_reference_referenceid_seq; Type: SEQUENCE; Schema: tables; Owner: imiq
--

CREATE SEQUENCE ext_reference_referenceid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tables.ext_reference_referenceid_seq OWNER TO imiq;

--
-- Name: ext_reference_referenceid_seq; Type: SEQUENCE OWNED BY; Schema: tables; Owner: imiq
--

ALTER SEQUENCE ext_reference_referenceid_seq OWNED BY ext_reference.referenceid;


--
-- Name: ext_referencetowaterbody; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE TABLE ext_referencetowaterbody (
    id integer NOT NULL,
    namereference character varying(255),
    waterbodyid character varying(50)
);


ALTER TABLE tables.ext_referencetowaterbody OWNER TO imiq;

--
-- Name: ext_referencetowaterbody_id_seq; Type: SEQUENCE; Schema: tables; Owner: imiq
--

CREATE SEQUENCE ext_referencetowaterbody_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tables.ext_referencetowaterbody_id_seq OWNER TO imiq;

--
-- Name: ext_referencetowaterbody_id_seq; Type: SEQUENCE OWNED BY; Schema: tables; Owner: imiq
--

ALTER SEQUENCE ext_referencetowaterbody_id_seq OWNED BY ext_referencetowaterbody.id;


--
-- Name: ext_waterbody; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE TABLE ext_waterbody (
    id integer NOT NULL,
    waterbodid bigint,
    watername character varying(255),
    watertype character varying(255),
    citation character varying(255),
    shape_leng real,
    shape_area real,
    geoposition bytea
);


ALTER TABLE tables.ext_waterbody OWNER TO imiq;

--
-- Name: ext_waterbody_id_seq; Type: SEQUENCE; Schema: tables; Owner: imiq
--

CREATE SEQUENCE ext_waterbody_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tables.ext_waterbody_id_seq OWNER TO imiq;

--
-- Name: ext_waterbody_id_seq; Type: SEQUENCE OWNED BY; Schema: tables; Owner: imiq
--

ALTER SEQUENCE ext_waterbody_id_seq OWNED BY ext_waterbody.id;


--
-- Name: generalcategorycv; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE TABLE generalcategorycv (
    term character varying(255) NOT NULL,
    definition text
);


ALTER TABLE tables.generalcategorycv OWNER TO imiq;

--
-- Name: groupdescriptions; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE TABLE groupdescriptions (
    groupid integer NOT NULL,
    groupdescription text
);


ALTER TABLE tables.groupdescriptions OWNER TO imiq;

--
-- Name: TABLE groupdescriptions; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON TABLE groupdescriptions IS 'The GroupDescriptions table lists the descriptions for each of the groups of data values that have been formed.';


--
-- Name: COLUMN groupdescriptions.groupid; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN groupdescriptions.groupid IS 'Unique integer identifier for each group of data values that has been formed. This also references to GroupID in the Groups table.';


--
-- Name: COLUMN groupdescriptions.groupdescription; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN groupdescriptions.groupdescription IS 'Text description of the group.';


--
-- Name: groupdescriptions_groupid_seq; Type: SEQUENCE; Schema: tables; Owner: imiq
--

CREATE SEQUENCE groupdescriptions_groupid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tables.groupdescriptions_groupid_seq OWNER TO imiq;

--
-- Name: groupdescriptions_groupid_seq; Type: SEQUENCE OWNED BY; Schema: tables; Owner: imiq
--

ALTER SEQUENCE groupdescriptions_groupid_seq OWNED BY groupdescriptions.groupid;


--
-- Name: groups; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE TABLE groups (
    groupid integer NOT NULL,
    valueid integer NOT NULL
);


ALTER TABLE tables.groups OWNER TO imiq;

--
-- Name: TABLE groups; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON TABLE groups IS 'The Groups table lists the groups of data values that have been created and the data values that are within each group.';


--
-- Name: COLUMN groups.groupid; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN groups.groupid IS 'Integer ID for each group of data values that has been formed.';


--
-- Name: COLUMN groups.valueid; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN groups.valueid IS 'Integer identifier for each data value that belongs to a group. This corresponds to ValueID in the DataValues table';


--
-- Name: hourly_airtempdatavalues; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE TABLE hourly_airtempdatavalues (
    valueid integer NOT NULL,
    datavalue double precision,
    utcdatetime timestamp without time zone NOT NULL,
    siteid integer NOT NULL,
    originalvariableid integer NOT NULL,
    insertdate timestamp without time zone
);


ALTER TABLE tables.hourly_airtempdatavalues OWNER TO imiq;

--
-- Name: hourly_airtempdatavalues_valueid_seq; Type: SEQUENCE; Schema: tables; Owner: imiq
--

CREATE SEQUENCE hourly_airtempdatavalues_valueid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tables.hourly_airtempdatavalues_valueid_seq OWNER TO imiq;

--
-- Name: hourly_airtempdatavalues_valueid_seq; Type: SEQUENCE OWNED BY; Schema: tables; Owner: imiq
--

ALTER SEQUENCE hourly_airtempdatavalues_valueid_seq OWNED BY hourly_airtempdatavalues.valueid;


--
-- Name: hourly_precip; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE TABLE hourly_precip (
    valueid integer NOT NULL,
    datavalue double precision,
    utcdatetime timestamp without time zone NOT NULL,
    siteid integer NOT NULL,
    originalvariableid integer NOT NULL,
    variableid integer NOT NULL
);


ALTER TABLE tables.hourly_precip OWNER TO imiq;

--
-- Name: hourly_precipdatavalues; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE TABLE hourly_precipdatavalues (
    valueid integer NOT NULL,
    datavalue double precision,
    utcdatetime timestamp without time zone NOT NULL,
    siteid integer NOT NULL,
    originalvariableid integer NOT NULL,
    insertdate timestamp without time zone
);


ALTER TABLE tables.hourly_precipdatavalues OWNER TO imiq;

--
-- Name: hourly_precipdatavalues_valueid_seq; Type: SEQUENCE; Schema: tables; Owner: imiq
--

CREATE SEQUENCE hourly_precipdatavalues_valueid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tables.hourly_precipdatavalues_valueid_seq OWNER TO imiq;

--
-- Name: hourly_precipdatavalues_valueid_seq; Type: SEQUENCE OWNED BY; Schema: tables; Owner: imiq
--

ALTER SEQUENCE hourly_precipdatavalues_valueid_seq OWNED BY hourly_precipdatavalues.valueid;


--
-- Name: hourly_rhdatavalues; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE TABLE hourly_rhdatavalues (
    valueid integer NOT NULL,
    datavalue double precision,
    utcdatetime timestamp without time zone NOT NULL,
    siteid integer NOT NULL,
    originalvariableid integer NOT NULL,
    insertdate timestamp without time zone
);


ALTER TABLE tables.hourly_rhdatavalues OWNER TO imiq;

--
-- Name: hourly_rhdatavalues_valueid_seq; Type: SEQUENCE; Schema: tables; Owner: imiq
--

CREATE SEQUENCE hourly_rhdatavalues_valueid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tables.hourly_rhdatavalues_valueid_seq OWNER TO imiq;

--
-- Name: hourly_rhdatavalues_valueid_seq; Type: SEQUENCE OWNED BY; Schema: tables; Owner: imiq
--

ALTER SEQUENCE hourly_rhdatavalues_valueid_seq OWNED BY hourly_rhdatavalues.valueid;


--
-- Name: hourly_snowdepth; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE TABLE hourly_snowdepth (
    valueid integer NOT NULL,
    datavalue double precision,
    utcdatetime timestamp without time zone NOT NULL,
    siteid integer NOT NULL,
    originalvariableid integer NOT NULL,
    variableid integer NOT NULL
);


ALTER TABLE tables.hourly_snowdepth OWNER TO imiq;

--
-- Name: hourly_snowdepthdatavalues; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE TABLE hourly_snowdepthdatavalues (
    valueid integer NOT NULL,
    datavalue double precision,
    utcdatetime timestamp without time zone NOT NULL,
    siteid integer NOT NULL,
    originalvariableid integer NOT NULL,
    insertdate timestamp without time zone
);


ALTER TABLE tables.hourly_snowdepthdatavalues OWNER TO imiq;

--
-- Name: hourly_snowdepthdatavalues_valueid_seq; Type: SEQUENCE; Schema: tables; Owner: imiq
--

CREATE SEQUENCE hourly_snowdepthdatavalues_valueid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tables.hourly_snowdepthdatavalues_valueid_seq OWNER TO imiq;

--
-- Name: hourly_snowdepthdatavalues_valueid_seq; Type: SEQUENCE OWNED BY; Schema: tables; Owner: imiq
--

ALTER SEQUENCE hourly_snowdepthdatavalues_valueid_seq OWNED BY hourly_snowdepthdatavalues.valueid;


--
-- Name: hourly_swe; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE TABLE hourly_swe (
    valueid integer NOT NULL,
    datavalue double precision,
    utcdatetime timestamp without time zone NOT NULL,
    siteid integer NOT NULL,
    originalvariableid integer NOT NULL,
    variableid integer NOT NULL
);


ALTER TABLE tables.hourly_swe OWNER TO imiq;

--
-- Name: hourly_swedatavalues; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE TABLE hourly_swedatavalues (
    valueid integer NOT NULL,
    datavalue double precision,
    utcdatetime timestamp without time zone NOT NULL,
    siteid integer NOT NULL,
    originalvariableid integer NOT NULL,
    insertdate timestamp without time zone
);


ALTER TABLE tables.hourly_swedatavalues OWNER TO imiq;

--
-- Name: hourly_swedatavalues_valueid_seq; Type: SEQUENCE; Schema: tables; Owner: imiq
--

CREATE SEQUENCE hourly_swedatavalues_valueid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tables.hourly_swedatavalues_valueid_seq OWNER TO imiq;

--
-- Name: hourly_swedatavalues_valueid_seq; Type: SEQUENCE OWNED BY; Schema: tables; Owner: imiq
--

ALTER SEQUENCE hourly_swedatavalues_valueid_seq OWNED BY hourly_swedatavalues.valueid;


--
-- Name: hourly_winddirectiondatavalues; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE TABLE hourly_winddirectiondatavalues (
    valueid integer NOT NULL,
    datavalue double precision,
    utcdatetime timestamp without time zone NOT NULL,
    siteid integer NOT NULL,
    originalvariableid integer NOT NULL,
    offsetvalue integer,
    offsettypeid integer,
    insertdate timestamp without time zone
);


ALTER TABLE tables.hourly_winddirectiondatavalues OWNER TO imiq;

--
-- Name: hourly_winddirectiondatavalues_valueid_seq; Type: SEQUENCE; Schema: tables; Owner: imiq
--

CREATE SEQUENCE hourly_winddirectiondatavalues_valueid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tables.hourly_winddirectiondatavalues_valueid_seq OWNER TO imiq;

--
-- Name: hourly_winddirectiondatavalues_valueid_seq; Type: SEQUENCE OWNED BY; Schema: tables; Owner: imiq
--

ALTER SEQUENCE hourly_winddirectiondatavalues_valueid_seq OWNED BY hourly_winddirectiondatavalues.valueid;


--
-- Name: hourly_windspeeddatavalues; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE TABLE hourly_windspeeddatavalues (
    valueid integer NOT NULL,
    datavalue double precision,
    utcdatetime timestamp without time zone NOT NULL,
    siteid integer NOT NULL,
    originalvariableid integer NOT NULL,
    offsetvalue integer,
    offsettypeid integer,
    insertdate timestamp without time zone
);


ALTER TABLE tables.hourly_windspeeddatavalues OWNER TO imiq;

--
-- Name: hourly_windspeeddatavalues_valueid_seq; Type: SEQUENCE; Schema: tables; Owner: imiq
--

CREATE SEQUENCE hourly_windspeeddatavalues_valueid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tables.hourly_windspeeddatavalues_valueid_seq OWNER TO imiq;

--
-- Name: hourly_windspeeddatavalues_valueid_seq; Type: SEQUENCE OWNED BY; Schema: tables; Owner: imiq
--

ALTER SEQUENCE hourly_windspeeddatavalues_valueid_seq OWNED BY hourly_windspeeddatavalues.valueid;


--
-- Name: imiqversion; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE TABLE imiqversion (
    versionnumber character varying(50) NOT NULL,
    creationdate timestamp without time zone,
    versiondescription text
);


ALTER TABLE tables.imiqversion OWNER TO imiq;

--
-- Name: incidents; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE TABLE incidents (
    incidentid integer NOT NULL,
    siteid integer,
    datastreamid integer,
    starttime timestamp without time zone,
    startprecision character varying(255),
    endtime timestamp without time zone,
    endprecision character varying(255),
    type character varying(255) NOT NULL,
    description text,
    reportedby character varying(96),
    comments text
);


ALTER TABLE tables.incidents OWNER TO imiq;

--
-- Name: TABLE incidents; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON TABLE incidents IS 'Lists natural or anthropogenic incidents, that may have affected a site, data values or an instruments ability to collect data.';


--
-- Name: COLUMN incidents.incidentid; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN incidents.incidentid IS 'Unique integer ID for each incident.';


--
-- Name: COLUMN incidents.siteid; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN incidents.siteid IS 'Integer identifier that references the record in the Sites table.  Enter a SiteID only when incident is relevant to the site.';


--
-- Name: COLUMN incidents.datastreamid; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN incidents.datastreamid IS 'Integer identifier that references the record in the Datastreams table.  Enter a DatastreamID only when the incident is relevant to a particular sensor.';


--
-- Name: COLUMN incidents.starttime; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN incidents.starttime IS 'When incident started -- note this does not refer to the measurement start time. ';


--
-- Name: COLUMN incidents.startprecision; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN incidents.startprecision IS 'Notes on how precise recorded incident start time is.';


--
-- Name: COLUMN incidents.endtime; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN incidents.endtime IS 'When incident ended -- note this does not necessarily refer to the measurement end time. ';


--
-- Name: COLUMN incidents.endprecision; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN incidents.endprecision IS 'Notes on how precise recorded incident start time is.';


--
-- Name: COLUMN incidents.type; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN incidents.type IS 'Type of incident that affected data collection or values. ';


--
-- Name: COLUMN incidents.description; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN incidents.description IS 'Detailed description of what happened (or what state equipment was found in" and what measurements may have been affected';


--
-- Name: COLUMN incidents.reportedby; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN incidents.reportedby IS 'Person who reported incident.';


--
-- Name: COLUMN incidents.comments; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN incidents.comments IS 'Comments on incident that are not covered elsewhere in the table. ';


--
-- Name: incidents_incidentid_seq; Type: SEQUENCE; Schema: tables; Owner: imiq
--

CREATE SEQUENCE incidents_incidentid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tables.incidents_incidentid_seq OWNER TO imiq;

--
-- Name: incidents_incidentid_seq; Type: SEQUENCE OWNED BY; Schema: tables; Owner: imiq
--

ALTER SEQUENCE incidents_incidentid_seq OWNED BY incidents.incidentid;


--
-- Name: isometadata; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE TABLE isometadata (
    metadataid integer NOT NULL,
    topiccategory character varying(255) DEFAULT ''::character varying NOT NULL,
    title character varying(255) DEFAULT ''::character varying NOT NULL,
    abstract text NOT NULL,
    profileversion character varying(255) DEFAULT ''::character varying NOT NULL,
    metadatalink character varying(500)
);


ALTER TABLE tables.isometadata OWNER TO imiq;

--
-- Name: TABLE isometadata; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON TABLE isometadata IS 'The ISOMetadata table contains dataset and project level metadata required by the CUAHSI HIS metadata system (http://www.cuahsi.org/his/documentation.html) for compliance with standards such as the draft ISO 19115 or ISO 8601. The mandatory fields in this table must be populated to provide a complete set of ISO compliant metadata in the database.';


--
-- Name: COLUMN isometadata.metadataid; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN isometadata.metadataid IS 'Unique integer ID for each metadata record.';


--
-- Name: COLUMN isometadata.topiccategory; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN isometadata.topiccategory IS 'Topic category keyword that gives the broad ISO19115 metadata topic category for data from this source. The controlled vocabulary of topic category keywords is given in the TopicCategoryCV table.';


--
-- Name: COLUMN isometadata.title; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN isometadata.title IS 'Title of data from a specific data source.';


--
-- Name: COLUMN isometadata.abstract; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN isometadata.abstract IS 'Abstract of data from a specific data source.';


--
-- Name: COLUMN isometadata.profileversion; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN isometadata.profileversion IS 'Name of metadata profile used by the data source';


--
-- Name: COLUMN isometadata.metadatalink; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN isometadata.metadatalink IS 'Link to additional metadata reference material.';


--
-- Name: isometadata_metadataid_seq; Type: SEQUENCE; Schema: tables; Owner: imiq
--

CREATE SEQUENCE isometadata_metadataid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tables.isometadata_metadataid_seq OWNER TO imiq;

--
-- Name: isometadata_metadataid_seq; Type: SEQUENCE OWNED BY; Schema: tables; Owner: imiq
--

ALTER SEQUENCE isometadata_metadataid_seq OWNED BY isometadata.metadataid;


--
-- Name: methods; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE TABLE methods (
    methodid integer NOT NULL,
    methodname character varying(255) NOT NULL,
    methoddescription text NOT NULL,
    methodlink character varying(500)
);


ALTER TABLE tables.methods OWNER TO imiq;

--
-- Name: TABLE methods; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON TABLE methods IS 'The Methods table lists the methods used to collect the data and any additional information about the method.';


--
-- Name: COLUMN methods.methodid; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN methods.methodid IS 'Unique integer ID for each method.';


--
-- Name: COLUMN methods.methodname; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN methods.methodname IS 'Name of method used.';


--
-- Name: COLUMN methods.methoddescription; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN methods.methoddescription IS 'Description of each method.';


--
-- Name: COLUMN methods.methodlink; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN methods.methodlink IS 'Link to additional reference material on method.';


--
-- Name: methods_methodid_seq; Type: SEQUENCE; Schema: tables; Owner: imiq
--

CREATE SEQUENCE methods_methodid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tables.methods_methodid_seq OWNER TO imiq;

--
-- Name: methods_methodid_seq; Type: SEQUENCE OWNED BY; Schema: tables; Owner: imiq
--

ALTER SEQUENCE methods_methodid_seq OWNED BY methods.methodid;


--
-- Name: monthly_rh_all; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE TABLE monthly_rh_all (
    siteid integer NOT NULL,
    year integer,
    month integer,
    rh double precision,
    at double precision,
    total integer
);


ALTER TABLE tables.monthly_rh_all OWNER TO imiq;

--
-- Name: multiyear_annual_all_avgairtemp; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE TABLE multiyear_annual_all_avgairtemp (
    siteid integer NOT NULL,
    avgannual double precision,
    totalyears integer
);


ALTER TABLE tables.multiyear_annual_all_avgairtemp OWNER TO imiq;

--
-- Name: multiyear_annual_all_avgdischarge; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE TABLE multiyear_annual_all_avgdischarge (
    siteid integer NOT NULL,
    avgannual double precision,
    totalyears integer
);


ALTER TABLE tables.multiyear_annual_all_avgdischarge OWNER TO imiq;

--
-- Name: multiyear_annual_all_avgfallairtemp; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE TABLE multiyear_annual_all_avgfallairtemp (
    siteid integer NOT NULL,
    avgannual double precision,
    totalyears integer
);


ALTER TABLE tables.multiyear_annual_all_avgfallairtemp OWNER TO imiq;

--
-- Name: multiyear_annual_all_avgfallprecip; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE TABLE multiyear_annual_all_avgfallprecip (
    siteid integer NOT NULL,
    avgannual double precision,
    totalyears integer
);


ALTER TABLE tables.multiyear_annual_all_avgfallprecip OWNER TO imiq;

--
-- Name: multiyear_annual_all_avgpeakdischarge; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE TABLE multiyear_annual_all_avgpeakdischarge (
    siteid integer NOT NULL,
    avgannual double precision,
    totalyears integer
);


ALTER TABLE tables.multiyear_annual_all_avgpeakdischarge OWNER TO imiq;

--
-- Name: multiyear_annual_all_avgpeaksnowdepth; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE TABLE multiyear_annual_all_avgpeaksnowdepth (
    siteid integer NOT NULL,
    avgannual double precision,
    totalyears integer
);


ALTER TABLE tables.multiyear_annual_all_avgpeaksnowdepth OWNER TO imiq;

--
-- Name: multiyear_annual_all_avgpeakswe; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE TABLE multiyear_annual_all_avgpeakswe (
    siteid integer NOT NULL,
    avgannual double precision,
    totalyears integer
);


ALTER TABLE tables.multiyear_annual_all_avgpeakswe OWNER TO imiq;

--
-- Name: multiyear_annual_all_avgprecip; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE TABLE multiyear_annual_all_avgprecip (
    siteid integer NOT NULL,
    avgannualtotal double precision,
    totalyears integer
);


ALTER TABLE tables.multiyear_annual_all_avgprecip OWNER TO imiq;

--
-- Name: multiyear_annual_all_avgrh; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE TABLE multiyear_annual_all_avgrh (
    siteid integer NOT NULL,
    rh double precision,
    at double precision,
    totalyears integer
);


ALTER TABLE tables.multiyear_annual_all_avgrh OWNER TO imiq;

--
-- Name: multiyear_annual_all_avgspringairtemp; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE TABLE multiyear_annual_all_avgspringairtemp (
    siteid integer NOT NULL,
    avgannual double precision,
    totalyears integer
);


ALTER TABLE tables.multiyear_annual_all_avgspringairtemp OWNER TO imiq;

--
-- Name: multiyear_annual_all_avgspringprecip; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE TABLE multiyear_annual_all_avgspringprecip (
    siteid integer NOT NULL,
    avgannual double precision,
    totalyears integer
);


ALTER TABLE tables.multiyear_annual_all_avgspringprecip OWNER TO imiq;

--
-- Name: multiyear_annual_all_avgsummerairtemp; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE TABLE multiyear_annual_all_avgsummerairtemp (
    siteid integer NOT NULL,
    avgannual double precision,
    totalyears integer
);


ALTER TABLE tables.multiyear_annual_all_avgsummerairtemp OWNER TO imiq;

--
-- Name: multiyear_annual_all_avgsummerdischarge; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE TABLE multiyear_annual_all_avgsummerdischarge (
    siteid integer NOT NULL,
    avgannual double precision,
    totalyears integer
);


ALTER TABLE tables.multiyear_annual_all_avgsummerdischarge OWNER TO imiq;

--
-- Name: multiyear_annual_all_avgsummerprecip; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE TABLE multiyear_annual_all_avgsummerprecip (
    siteid integer NOT NULL,
    avgannual double precision,
    totalyears integer
);


ALTER TABLE tables.multiyear_annual_all_avgsummerprecip OWNER TO imiq;

--
-- Name: multiyear_annual_all_avgsummerrh; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE TABLE multiyear_annual_all_avgsummerrh (
    siteid integer NOT NULL,
    avgannual double precision,
    totalyears integer
);


ALTER TABLE tables.multiyear_annual_all_avgsummerrh OWNER TO imiq;

--
-- Name: multiyear_annual_all_avgwinterairtemp; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE TABLE multiyear_annual_all_avgwinterairtemp (
    siteid integer NOT NULL,
    avgannual double precision,
    totalyears integer
);


ALTER TABLE tables.multiyear_annual_all_avgwinterairtemp OWNER TO imiq;

--
-- Name: multiyear_annual_all_avgwinterprecip; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE TABLE multiyear_annual_all_avgwinterprecip (
    siteid integer NOT NULL,
    avgannual double precision,
    totalyears integer
);


ALTER TABLE tables.multiyear_annual_all_avgwinterprecip OWNER TO imiq;

--
-- Name: multiyear_annual_all_avgwinterrh; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE TABLE multiyear_annual_all_avgwinterrh (
    siteid integer NOT NULL,
    avgannual double precision,
    totalyears integer
);


ALTER TABLE tables.multiyear_annual_all_avgwinterrh OWNER TO imiq;

--
-- Name: networkdescriptions; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE TABLE networkdescriptions (
    networkid integer NOT NULL,
    networkcode character varying(50) NOT NULL,
    networkdescription text NOT NULL
);


ALTER TABLE tables.networkdescriptions OWNER TO imiq;

--
-- Name: COLUMN networkdescriptions.networkid; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN networkdescriptions.networkid IS 'Unique integer identifier that identifies a network.';


--
-- Name: COLUMN networkdescriptions.networkcode; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN networkdescriptions.networkcode IS 'Network code used by organization that collects the data.';


--
-- Name: COLUMN networkdescriptions.networkdescription; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN networkdescriptions.networkdescription IS 'Full text description of the network.';


--
-- Name: nhd_huc8; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE TABLE nhd_huc8 (
    id integer NOT NULL,
    gaz_id bigint,
    area_acres real,
    area_sqkm real,
    states character varying(255),
    loaddate date,
    huc_8 character varying(255),
    hu_8_name character varying(255),
    shape_leng real,
    shape_area real,
    geoposition bytea
);


ALTER TABLE tables.nhd_huc8 OWNER TO imiq;

--
-- Name: nhd_huc8_id_seq; Type: SEQUENCE; Schema: tables; Owner: imiq
--

CREATE SEQUENCE nhd_huc8_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tables.nhd_huc8_id_seq OWNER TO imiq;

--
-- Name: nhd_huc8_id_seq; Type: SEQUENCE OWNED BY; Schema: tables; Owner: imiq
--

ALTER SEQUENCE nhd_huc8_id_seq OWNED BY nhd_huc8.id;


--
-- Name: offsettypes; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE TABLE offsettypes (
    offsettypeid integer NOT NULL,
    offsetunitsid integer NOT NULL,
    offsetdescription text NOT NULL
);


ALTER TABLE tables.offsettypes OWNER TO imiq;

--
-- Name: TABLE offsettypes; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON TABLE offsettypes IS 'The OffsetTypes table lists full descriptive information for each of the measurement offsets.';


--
-- Name: COLUMN offsettypes.offsettypeid; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN offsettypes.offsettypeid IS 'Unique integer identifier that identifies the type of measurement offset.';


--
-- Name: COLUMN offsettypes.offsetunitsid; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN offsettypes.offsetunitsid IS 'Integer identifier that references the record in the Units table giving the Units of the OffsetValue.';


--
-- Name: COLUMN offsettypes.offsetdescription; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN offsettypes.offsetdescription IS 'Full text description of the offset type.';


--
-- Name: offsettypes_offsettypeid_seq; Type: SEQUENCE; Schema: tables; Owner: imiq
--

CREATE SEQUENCE offsettypes_offsettypeid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tables.offsettypes_offsettypeid_seq OWNER TO imiq;

--
-- Name: offsettypes_offsettypeid_seq; Type: SEQUENCE OWNED BY; Schema: tables; Owner: imiq
--

ALTER SEQUENCE offsettypes_offsettypeid_seq OWNED BY offsettypes.offsettypeid;


--
-- Name: organizationdescriptions; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE TABLE organizationdescriptions (
    organizationid integer NOT NULL,
    organizationcode character varying(50) NOT NULL,
    organizationdescription text NOT NULL
);


ALTER TABLE tables.organizationdescriptions OWNER TO imiq;

--
-- Name: TABLE organizationdescriptions; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON TABLE organizationdescriptions IS 'Organizations, which are associated with Sources.';


--
-- Name: COLUMN organizationdescriptions.organizationid; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN organizationdescriptions.organizationid IS 'Unique integer identifier that identifies an organization.';


--
-- Name: COLUMN organizationdescriptions.organizationcode; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN organizationdescriptions.organizationcode IS 'Organization code used by organization that collects the data.';


--
-- Name: COLUMN organizationdescriptions.organizationdescription; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN organizationdescriptions.organizationdescription IS 'Full text description of the organization.';


--
-- Name: organizations; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE TABLE organizations (
    organizationid integer NOT NULL,
    sourceid integer NOT NULL,
    networkid integer
);


ALTER TABLE tables.organizations OWNER TO imiq;

--
-- Name: TABLE organizations; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON TABLE organizations IS 'Shows associations of a data source with multiple organizations. ';


--
-- Name: COLUMN organizations.organizationid; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN organizations.organizationid IS 'Integer identifier that references the record in the OrganizationDescriptions table.';


--
-- Name: COLUMN organizations.sourceid; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN organizations.sourceid IS 'Integer identifier that references the record in the Sources table.';


--
-- Name: processing; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE TABLE processing (
    processingid integer NOT NULL,
    sourceid integer,
    siteid integer,
    metadataid integer,
    datarestrictions character varying(255),
    datapriority integer,
    processingneeds text,
    qaqcperson character varying(255),
    qaqccomments text,
    qaqcdate date
);


ALTER TABLE tables.processing OWNER TO imiq;

--
-- Name: TABLE processing; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON TABLE processing IS 'The Processing table lists Qa/Qc that was done to the Sources, ISOMetadata and Sites tables.  It also lists any known data restrictions, priority of data entry and processing needs that need to be done.';


--
-- Name: COLUMN processing.processingid; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN processing.processingid IS 'Unique integer ID for each processing event.';


--
-- Name: COLUMN processing.sourceid; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN processing.sourceid IS 'Integer identifier that references the record in the Sources table.';


--
-- Name: COLUMN processing.siteid; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN processing.siteid IS 'Integer identifier that references the record in the Sites table.';


--
-- Name: COLUMN processing.metadataid; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN processing.metadataid IS 'Integer identifier that references the record in the ISOMetadata table.';


--
-- Name: COLUMN processing.datarestrictions; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN processing.datarestrictions IS 'Any known restrictions on data ';


--
-- Name: COLUMN processing.datapriority; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN processing.datapriority IS 'Priority level for data entry.';


--
-- Name: COLUMN processing.processingneeds; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN processing.processingneeds IS 'What needs to be done to get the data entered';


--
-- Name: COLUMN processing.qaqcperson; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN processing.qaqcperson IS 'Name of database team member who has performed the QaQc on a Sources, ISOMetadata or Sites record.';


--
-- Name: COLUMN processing.qaqccomments; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN processing.qaqccomments IS 'Processing comments for QaQc data.  ';


--
-- Name: COLUMN processing.qaqcdate; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN processing.qaqcdate IS 'Date that QaQc was performed.';


--
-- Name: processing_processingid_seq; Type: SEQUENCE; Schema: tables; Owner: imiq
--

CREATE SEQUENCE processing_processingid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tables.processing_processingid_seq OWNER TO imiq;

--
-- Name: processing_processingid_seq; Type: SEQUENCE OWNED BY; Schema: tables; Owner: imiq
--

ALTER SEQUENCE processing_processingid_seq OWNED BY processing.processingid;


--
-- Name: qualifiers; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE TABLE qualifiers (
    qualifierid integer NOT NULL,
    qualifiercode character varying(50),
    qualifierdescription text NOT NULL
);


ALTER TABLE tables.qualifiers OWNER TO imiq;

--
-- Name: TABLE qualifiers; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON TABLE qualifiers IS 'The Qualifiers table contains data qualifying comments that accompany the data.';


--
-- Name: COLUMN qualifiers.qualifierid; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN qualifiers.qualifierid IS 'Unique integer identifying the data qualifier.';


--
-- Name: COLUMN qualifiers.qualifiercode; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN qualifiers.qualifiercode IS 'Text code used by organization that collects the data.';


--
-- Name: COLUMN qualifiers.qualifierdescription; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN qualifiers.qualifierdescription IS 'Text of the data qualifying comment.';


--
-- Name: qualifiers_qualifierid_seq; Type: SEQUENCE; Schema: tables; Owner: imiq
--

CREATE SEQUENCE qualifiers_qualifierid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tables.qualifiers_qualifierid_seq OWNER TO imiq;

--
-- Name: qualifiers_qualifierid_seq; Type: SEQUENCE OWNED BY; Schema: tables; Owner: imiq
--

ALTER SEQUENCE qualifiers_qualifierid_seq OWNED BY qualifiers.qualifierid;


--
-- Name: qualitycontrollevels; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE TABLE qualitycontrollevels (
    qualitycontrollevelid integer NOT NULL,
    qualitycontrollevelcode character varying(50) NOT NULL,
    definition character varying(255) NOT NULL,
    explanation text NOT NULL
);


ALTER TABLE tables.qualitycontrollevels OWNER TO imiq;

--
-- Name: TABLE qualitycontrollevels; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON TABLE qualitycontrollevels IS 'The QualityControlLevels table contains the quality control levels that are used for versioning data within the database.';


--
-- Name: COLUMN qualitycontrollevels.qualitycontrollevelid; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN qualitycontrollevels.qualitycontrollevelid IS 'Unique integer identifying the quality control level.';


--
-- Name: COLUMN qualitycontrollevels.qualitycontrollevelcode; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN qualitycontrollevels.qualitycontrollevelcode IS 'Code used to identify the level of quality control to which data values have been subjected.';


--
-- Name: COLUMN qualitycontrollevels.definition; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN qualitycontrollevels.definition IS 'Definition of Quality Control Level.';


--
-- Name: COLUMN qualitycontrollevels.explanation; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN qualitycontrollevels.explanation IS 'Explanation of Quality Control Level';


--
-- Name: qualitycontrollevels_qualitycontrollevelid_seq; Type: SEQUENCE; Schema: tables; Owner: imiq
--

CREATE SEQUENCE qualitycontrollevels_qualitycontrollevelid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tables.qualitycontrollevels_qualitycontrollevelid_seq OWNER TO imiq;

--
-- Name: qualitycontrollevels_qualitycontrollevelid_seq; Type: SEQUENCE OWNED BY; Schema: tables; Owner: imiq
--

ALTER SEQUENCE qualitycontrollevels_qualitycontrollevelid_seq OWNED BY qualitycontrollevels.qualitycontrollevelid;


--
-- Name: rasterdatavalues; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE TABLE rasterdatavalues (
    valueid integer NOT NULL,
    datavalue text,
    valueaccuracy double precision,
    localdatetime timestamp without time zone NOT NULL,
    utcoffset double precision NOT NULL,
    qualifierid integer,
    derivedfromid integer,
    datastreamid integer NOT NULL,
    censorcode character varying(50)
);


ALTER TABLE tables.rasterdatavalues OWNER TO imiq;

--
-- Name: rasterdatavalues_valueid_seq; Type: SEQUENCE; Schema: tables; Owner: imiq
--

CREATE SEQUENCE rasterdatavalues_valueid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tables.rasterdatavalues_valueid_seq OWNER TO imiq;

--
-- Name: rasterdatavalues_valueid_seq; Type: SEQUENCE OWNED BY; Schema: tables; Owner: imiq
--

ALTER SEQUENCE rasterdatavalues_valueid_seq OWNED BY rasterdatavalues.valueid;


--
-- Name: samplemediumcv; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE TABLE samplemediumcv (
    term character varying(255) NOT NULL,
    definition text
);


ALTER TABLE tables.samplemediumcv OWNER TO imiq;

--
-- Name: seriescatalog; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE TABLE seriescatalog (
    datastreamid integer NOT NULL,
    datastreamname character varying(255) NOT NULL,
    siteid integer NOT NULL,
    sitecode character varying(50) NOT NULL,
    sitename character varying(255),
    offsetvalue double precision,
    unitsabbreviation character varying(255),
    offsettypeid integer,
    variableid integer NOT NULL,
    variablecode character varying(50) NOT NULL,
    variablename character varying(255) NOT NULL,
    speciation character varying(255) NOT NULL,
    variableunitsid integer NOT NULL,
    samplemedium character varying(255) NOT NULL,
    valuetype character varying(255) NOT NULL,
    timesupport double precision NOT NULL,
    timeunitsid integer NOT NULL,
    datatype character varying(255) NOT NULL,
    generalcategory character varying(255) NOT NULL,
    methodid integer NOT NULL,
    methoddescription text NOT NULL,
    sourceid integer NOT NULL,
    organization character varying(255) NOT NULL,
    sourcedescription text NOT NULL,
    citation text NOT NULL,
    qualitycontrollevelid integer,
    qualitycontrollevelcode character varying(50) NOT NULL,
    begindatetime character varying(100),
    enddatetime character varying(100),
    begindatetimeutc character varying(100),
    enddatetimeutc character varying(100),
    lat double precision,
    long double precision,
    elev double precision,
    geolocationtext text,
    spatialcharacteristics character varying(50) NOT NULL,
    totalvalues integer,
    startdecade integer,
    enddecade integer,
    totalyears integer
);


ALTER TABLE tables.seriescatalog OWNER TO imiq;

--
-- Name: siteattributes; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE TABLE siteattributes (
    siteid integer NOT NULL,
    attributeid integer NOT NULL,
    attributevalue character varying(255) NOT NULL,
    attributecomment text
);


ALTER TABLE tables.siteattributes OWNER TO imiq;

--
-- Name: TABLE siteattributes; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON TABLE siteattributes IS 'Lists site data values that are non-numeric.';


--
-- Name: COLUMN siteattributes.siteid; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN siteattributes.siteid IS 'Integer identifier that references the record in the Sites table.';


--
-- Name: COLUMN siteattributes.attributeid; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN siteattributes.attributeid IS 'Integer identifier that references the record in the Attributes table.';


--
-- Name: COLUMN siteattributes.attributevalue; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN siteattributes.attributevalue IS 'The non-numeric data value';


--
-- Name: COLUMN siteattributes.attributecomment; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN siteattributes.attributecomment IS 'Attribute comment.';


--
-- Name: sites; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE TABLE sites (
    siteid integer NOT NULL,
    sitecode character varying(50) NOT NULL,
    sitename character varying(255),
    spatialcharacteristics character varying(50) NOT NULL,
    sourceid integer NOT NULL,
    verticaldatum character varying(255),
    localprojectionid integer,
    posaccuracy_m double precision,
    state character varying(255),
    county character varying(255),
    comments text,
    latlongdatumid integer NOT NULL,
    geolocation text,
    locationdescription text,
    updated_at timestamp without time zone
);


ALTER TABLE tables.sites OWNER TO imiq;

--
-- Name: TABLE sites; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON TABLE sites IS 'The Sites table provides information giving the spatial location at which data values have been collected.';


--
-- Name: COLUMN sites.siteid; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN sites.siteid IS 'Unique identifier for each sampling location.';


--
-- Name: COLUMN sites.sitecode; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN sites.sitecode IS 'Code used by organization that collects the data to identify the site';


--
-- Name: COLUMN sites.sitename; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN sites.sitename IS 'Full name of the sampling site.';


--
-- Name: COLUMN sites.spatialcharacteristics; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN sites.spatialcharacteristics IS 'Indicates whether site is a point, polygon, linestring.';


--
-- Name: COLUMN sites.sourceid; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN sites.sourceid IS 'Integer identifier that references the record in the Sources table giving the source of the data value.';


--
-- Name: COLUMN sites.verticaldatum; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN sites.verticaldatum IS 'Vertical datum of the elevation. Controlled Vocabulary from V erticalDatumCV .';


--
-- Name: COLUMN sites.localprojectionid; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN sites.localprojectionid IS 'Identifier that references the Spatial Reference System of the local coordinates in the SpatialReferences table. This field is required if local coordinates are given.';


--
-- Name: COLUMN sites.posaccuracy_m; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN sites.posaccuracy_m IS 'Value giving the accuracy with which the positional information is specified in meters.';


--
-- Name: COLUMN sites.state; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN sites.state IS 'Name of state in which the monitoring site is located.';


--
-- Name: COLUMN sites.county; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN sites.county IS 'Name of county in which the monitoring site is located.';


--
-- Name: COLUMN sites.comments; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN sites.comments IS 'Comments related to the site.';


--
-- Name: COLUMN sites.latlongdatumid; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN sites.latlongdatumid IS 'Identifier that references the Spatial Reference System of the latitude and longitude coordinates in the SpatialReferences table.';


--
-- Name: COLUMN sites.geolocation; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN sites.geolocation IS 'Coordinates and elevation given in a specific format for points and polygons.  Latitude and Longitude should be in decimal degrees. Elevation is in meters. If elevation is not provided it can be obtained programmatically from a DEM based on location information. Point locations are stored as "Point (long lat elevation)".  The following is an example for a polygon: 
POLYGON (-146.34425083697045 69.688296227508985, -146.34308827446938 69.688355477509049,...) 
';


--
-- Name: COLUMN sites.locationdescription; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN sites.locationdescription IS 'Description of site location';


--
-- Name: COLUMN sites.updated_at; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN sites.updated_at IS 'The timestamp that the record was last updated.';


--
-- Name: sites_siteid_seq; Type: SEQUENCE; Schema: tables; Owner: imiq
--

CREATE SEQUENCE sites_siteid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tables.sites_siteid_seq OWNER TO imiq;

--
-- Name: sites_siteid_seq; Type: SEQUENCE OWNED BY; Schema: tables; Owner: imiq
--

ALTER SEQUENCE sites_siteid_seq OWNED BY sites.siteid;


--
-- Name: sites_sourceid_164; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE TABLE sites_sourceid_164 (
    siteid integer,
    sitecode character varying(50),
    sitename character varying(255),
    spatialcharacteristics character varying(50),
    sourceid integer,
    verticaldatum character varying(255),
    localprojectionid integer,
    posaccuracy_m double precision,
    state character varying(255),
    county character varying(255),
    comments text,
    latlongdatumid integer,
    geolocation text,
    locationdescription text,
    updated_at timestamp without time zone
);


ALTER TABLE tables.sites_sourceid_164 OWNER TO imiq;

--
-- Name: sources; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE TABLE sources (
    sourceid integer NOT NULL,
    organization character varying(255) NOT NULL,
    sourcedescription text NOT NULL,
    sourcerole character varying(50) NOT NULL,
    sourcelink character varying(500),
    contactname character varying(255) DEFAULT ''::character varying NOT NULL,
    phone character varying(255) DEFAULT ''::character varying NOT NULL,
    email character varying(255) DEFAULT ''::character varying NOT NULL,
    address character varying(255) DEFAULT ''::character varying NOT NULL,
    city character varying(255) DEFAULT ''::character varying NOT NULL,
    state character varying(255) DEFAULT ''::character varying NOT NULL,
    zipcode character varying(255) DEFAULT ''::character varying NOT NULL,
    citation text NOT NULL,
    metadataid integer NOT NULL,
    updated_at timestamp without time zone
);


ALTER TABLE tables.sources OWNER TO imiq;

--
-- Name: TABLE sources; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON TABLE sources IS 'The Sources table lists the original sources of the data, providing information sufficient to retrieve and reconstruct the data value from the original data files if necessary.';


--
-- Name: COLUMN sources.sourceid; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN sources.sourceid IS 'Unique integer identifier that identifies each data source.';


--
-- Name: COLUMN sources.organization; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN sources.organization IS 'Name of the organization that collected the data. This should be the agency or organization that collected the data, even if it came out of a database consolidated from many sources such as STORET.';


--
-- Name: COLUMN sources.sourcedescription; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN sources.sourcedescription IS 'Full text description of the source of the data.';


--
-- Name: COLUMN sources.sourcerole; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN sources.sourcerole IS 'If the source is an originator or publisher of data';


--
-- Name: COLUMN sources.sourcelink; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN sources.sourcelink IS 'Link that can be pointed at the original data file and/or associated metadata stored in the digital library or URL of data source.';


--
-- Name: COLUMN sources.contactname; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN sources.contactname IS 'Name of the contact person for the data source.';


--
-- Name: COLUMN sources.phone; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN sources.phone IS 'Phone number for the contact person.';


--
-- Name: COLUMN sources.email; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN sources.email IS 'Email address for the contact person.';


--
-- Name: COLUMN sources.address; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN sources.address IS 'Street address for the contact person.';


--
-- Name: COLUMN sources.city; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN sources.city IS 'City in which the contact person is located.';


--
-- Name: COLUMN sources.state; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN sources.state IS 'State in which the contact person is located. Use two letter abbreviations for US. For other countries give the full country name.';


--
-- Name: COLUMN sources.zipcode; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN sources.zipcode IS 'US Zip Code or country postal code.';


--
-- Name: COLUMN sources.citation; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN sources.citation IS 'Text string that give the citation to be used when the data from each source are referenced.';


--
-- Name: COLUMN sources.metadataid; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN sources.metadataid IS 'Integer identifier referencing the record in the ISOMetadata table for this source.';


--
-- Name: COLUMN sources.updated_at; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN sources.updated_at IS 'The timestamp the source was last updated';


--
-- Name: sources_sourceid_seq; Type: SEQUENCE; Schema: tables; Owner: imiq
--

CREATE SEQUENCE sources_sourceid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tables.sources_sourceid_seq OWNER TO imiq;

--
-- Name: sources_sourceid_seq; Type: SEQUENCE OWNED BY; Schema: tables; Owner: imiq
--

ALTER SEQUENCE sources_sourceid_seq OWNED BY sources.sourceid;


--
-- Name: spatialreferences; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE TABLE spatialreferences (
    spatialreferenceid integer NOT NULL,
    srsid integer,
    srsname character varying(255) NOT NULL,
    isgeographic boolean,
    notes text
);


ALTER TABLE tables.spatialreferences OWNER TO imiq;

--
-- Name: spatialreferences_spatialreferenceid_seq; Type: SEQUENCE; Schema: tables; Owner: imiq
--

CREATE SEQUENCE spatialreferences_spatialreferenceid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tables.spatialreferences_spatialreferenceid_seq OWNER TO imiq;

--
-- Name: spatialreferences_spatialreferenceid_seq; Type: SEQUENCE OWNED BY; Schema: tables; Owner: imiq
--

ALTER SEQUENCE spatialreferences_spatialreferenceid_seq OWNED BY spatialreferences.spatialreferenceid;


--
-- Name: speciationcv; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE TABLE speciationcv (
    term character varying(255) NOT NULL,
    definition text
);


ALTER TABLE tables.speciationcv OWNER TO imiq;

--
-- Name: sysdiagrams; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE TABLE sysdiagrams (
    name character varying(128) NOT NULL,
    principal_id integer NOT NULL,
    diagram_id integer NOT NULL,
    version integer,
    definition bytea
);


ALTER TABLE tables.sysdiagrams OWNER TO imiq;

--
-- Name: sysdiagrams_diagram_id_seq; Type: SEQUENCE; Schema: tables; Owner: imiq
--

CREATE SEQUENCE sysdiagrams_diagram_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tables.sysdiagrams_diagram_id_seq OWNER TO imiq;

--
-- Name: sysdiagrams_diagram_id_seq; Type: SEQUENCE OWNED BY; Schema: tables; Owner: imiq
--

ALTER SEQUENCE sysdiagrams_diagram_id_seq OWNED BY sysdiagrams.diagram_id;


--
-- Name: topiccategorycv; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE TABLE topiccategorycv (
    term character varying(255) NOT NULL,
    definition text
);


ALTER TABLE tables.topiccategorycv OWNER TO imiq;

--
-- Name: units; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE TABLE units (
    unitsid integer NOT NULL,
    unitsname character varying(255) NOT NULL,
    unitstype character varying(255) NOT NULL,
    unitsabbreviation character varying(255) NOT NULL
);


ALTER TABLE tables.units OWNER TO imiq;

--
-- Name: units_unitsid_seq; Type: SEQUENCE; Schema: tables; Owner: imiq
--

CREATE SEQUENCE units_unitsid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tables.units_unitsid_seq OWNER TO imiq;

--
-- Name: units_unitsid_seq; Type: SEQUENCE OWNED BY; Schema: tables; Owner: imiq
--

ALTER SEQUENCE units_unitsid_seq OWNED BY units.unitsid;


--
-- Name: valuetypecv; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE TABLE valuetypecv (
    term character varying(255) NOT NULL,
    definition text
);


ALTER TABLE tables.valuetypecv OWNER TO imiq;

--
-- Name: variablenamecv; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE TABLE variablenamecv (
    term character varying(255) NOT NULL,
    definition text
);


ALTER TABLE tables.variablenamecv OWNER TO imiq;

--
-- Name: variables; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE TABLE variables (
    variableid integer NOT NULL,
    variablecode character varying(50) NOT NULL,
    variablename character varying(255) NOT NULL,
    variabledescription text,
    speciation character varying(255) DEFAULT ''::character varying NOT NULL,
    variableunitsid integer NOT NULL,
    samplemedium character varying(255) DEFAULT ''::character varying NOT NULL,
    valuetype character varying(255) DEFAULT ''::character varying NOT NULL,
    isregular boolean NOT NULL,
    timesupport double precision NOT NULL,
    timeunitsid integer NOT NULL,
    datatype character varying(255) DEFAULT ''::character varying NOT NULL,
    generalcategory character varying(255) DEFAULT ''::character varying NOT NULL,
    nodatavalue double precision NOT NULL
);


ALTER TABLE tables.variables OWNER TO imiq;

--
-- Name: TABLE variables; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON TABLE variables IS 'The Variables table lists the full descriptive information about what variables have been measured.';


--
-- Name: COLUMN variables.variableid; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN variables.variableid IS 'Unique integer identifier for each variable.';


--
-- Name: COLUMN variables.variablecode; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN variables.variablecode IS 'Text code used by the organization that collects the data to identify the variable.';


--
-- Name: COLUMN variables.variablename; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN variables.variablename IS 'Full text name of the variable that was measured, observed, modeled, etc. This should be from the VariableNameCV controlled vocabulary table.';


--
-- Name: COLUMN variables.variabledescription; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN variables.variabledescription IS 'A description of the variable';


--
-- Name: COLUMN variables.speciation; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN variables.speciation IS 'Text code used to identify how the data value is expressed (i.e., total phosphorus concentration expressed as P). This should be from the SpeciationCV controlled vocabulary table.';


--
-- Name: COLUMN variables.variableunitsid; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN variables.variableunitsid IS 'Integer identifier that references the record in the Units table giving the units of the data values associated with the variable.';


--
-- Name: COLUMN variables.samplemedium; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN variables.samplemedium IS 'The medium in which the sample or observation was taken or made. This should be from the SampleMediumCV controlled vocabulary table.';


--
-- Name: COLUMN variables.valuetype; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN variables.valuetype IS 'Text value indicating what type of data value is being recorded. This should be from the ValueTypeCV controlled vocabulary table.';


--
-- Name: COLUMN variables.isregular; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN variables.isregular IS 'Value that indicates whether the data values are from a regularly sampled time series.';


--
-- Name: COLUMN variables.timesupport; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN variables.timesupport IS 'Numerical value that indicates the time support (or temporal footprint) of the data values. 0 is used to indicate data values that are instantaneous. Other values indicate the time over which the data values are implicitly or explicitly averaged or aggregated.';


--
-- Name: COLUMN variables.timeunitsid; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN variables.timeunitsid IS 'Integer identifier that references the record in the Units table giving the Units of the time support. If TimeSupport is 0, indicating an instantaneous observation, a unit needs to still be given for completeness, although it is somewhat arbitrary.';


--
-- Name: COLUMN variables.datatype; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN variables.datatype IS 'Text value that identifies the data values as one of several types from the DataTypeCV controlled vocabulary table.';


--
-- Name: COLUMN variables.generalcategory; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN variables.generalcategory IS 'General category of the data values from the GeneralCategoryCV controlled vocabulary table.';


--
-- Name: COLUMN variables.nodatavalue; Type: COMMENT; Schema: tables; Owner: imiq
--

COMMENT ON COLUMN variables.nodatavalue IS 'Numeric value used to encode no data values for this variable.';


--
-- Name: variables_variableid_seq; Type: SEQUENCE; Schema: tables; Owner: imiq
--

CREATE SEQUENCE variables_variableid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tables.variables_variableid_seq OWNER TO imiq;

--
-- Name: variables_variableid_seq; Type: SEQUENCE OWNED BY; Schema: tables; Owner: imiq
--

ALTER SEQUENCE variables_variableid_seq OWNED BY variables.variableid;


--
-- Name: verticaldatumcv; Type: TABLE; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE TABLE verticaldatumcv (
    term character varying(255) NOT NULL,
    definition text
);


ALTER TABLE tables.verticaldatumcv OWNER TO imiq;

SET search_path = views, pg_catalog;

--
-- Name: annual_avgairtemp; Type: TABLE; Schema: views; Owner: imiq; Tablespace: 
--

CREATE TABLE annual_avgairtemp (
    valueid bigint NOT NULL,
    datavalue double precision,
    siteid integer NOT NULL,
    utcdatetime timestamp without time zone,
    originalvariableid integer NOT NULL,
    variableid integer NOT NULL
);


ALTER TABLE views.annual_avgairtemp OWNER TO imiq;

--
-- Name: annual_avgdischarge; Type: TABLE; Schema: views; Owner: imiq; Tablespace: 
--

CREATE TABLE annual_avgdischarge (
    valueid bigint NOT NULL,
    datavalue double precision,
    siteid integer NOT NULL,
    utcdatetime timestamp without time zone,
    originalvariableid integer NOT NULL,
    variableid integer NOT NULL
);


ALTER TABLE views.annual_avgdischarge OWNER TO imiq;

--
-- Name: annual_avgfallairtemp; Type: TABLE; Schema: views; Owner: imiq; Tablespace: 
--

CREATE TABLE annual_avgfallairtemp (
    valueid bigint NOT NULL,
    datavalue double precision,
    siteid integer NOT NULL,
    utcdatetime timestamp without time zone,
    originalvariableid integer NOT NULL,
    variableid integer NOT NULL
);


ALTER TABLE views.annual_avgfallairtemp OWNER TO imiq;

--
-- Name: annual_avgfallairtemp_all; Type: TABLE; Schema: views; Owner: imiq; Tablespace: 
--

CREATE TABLE annual_avgfallairtemp_all (
    siteid integer NOT NULL,
    year integer,
    seasonalavg double precision
);


ALTER TABLE views.annual_avgfallairtemp_all OWNER TO imiq;

--
-- Name: annual_avgfallprecip; Type: TABLE; Schema: views; Owner: imiq; Tablespace: 
--

CREATE TABLE annual_avgfallprecip (
    valueid bigint NOT NULL,
    datavalue double precision,
    siteid integer NOT NULL,
    utcdatetime timestamp without time zone,
    originalvariableid integer NOT NULL,
    variableid integer NOT NULL
);


ALTER TABLE views.annual_avgfallprecip OWNER TO imiq;

--
-- Name: annual_avgfallprecip_all; Type: TABLE; Schema: views; Owner: imiq; Tablespace: 
--

CREATE TABLE annual_avgfallprecip_all (
    siteid integer NOT NULL,
    year integer,
    seasonalavg double precision
);


ALTER TABLE views.annual_avgfallprecip_all OWNER TO imiq;

--
-- Name: annual_avgrh; Type: TABLE; Schema: views; Owner: imiq; Tablespace: 
--

CREATE TABLE annual_avgrh (
    valueid bigint NOT NULL,
    datavalue double precision,
    siteid integer NOT NULL,
    utcdatetime timestamp without time zone,
    originalvariableid integer NOT NULL,
    variableid integer NOT NULL
);


ALTER TABLE views.annual_avgrh OWNER TO imiq;

--
-- Name: annual_avgspringairtemp; Type: TABLE; Schema: views; Owner: imiq; Tablespace: 
--

CREATE TABLE annual_avgspringairtemp (
    valueid bigint NOT NULL,
    datavalue double precision,
    siteid integer NOT NULL,
    utcdatetime timestamp without time zone,
    originalvariableid integer NOT NULL,
    variableid integer NOT NULL
);


ALTER TABLE views.annual_avgspringairtemp OWNER TO imiq;

--
-- Name: annual_avgspringairtemp_all; Type: TABLE; Schema: views; Owner: imiq; Tablespace: 
--

CREATE TABLE annual_avgspringairtemp_all (
    siteid integer NOT NULL,
    year integer,
    seasonalavg double precision
);


ALTER TABLE views.annual_avgspringairtemp_all OWNER TO imiq;

--
-- Name: annual_avgspringprecip; Type: TABLE; Schema: views; Owner: imiq; Tablespace: 
--

CREATE TABLE annual_avgspringprecip (
    valueid bigint NOT NULL,
    datavalue double precision,
    siteid integer NOT NULL,
    utcdatetime timestamp without time zone,
    originalvariableid integer NOT NULL,
    variableid integer NOT NULL
);


ALTER TABLE views.annual_avgspringprecip OWNER TO imiq;

--
-- Name: annual_avgspringprecip_all; Type: TABLE; Schema: views; Owner: imiq; Tablespace: 
--

CREATE TABLE annual_avgspringprecip_all (
    siteid integer NOT NULL,
    year integer,
    seasonalavg double precision
);


ALTER TABLE views.annual_avgspringprecip_all OWNER TO imiq;

--
-- Name: annual_avgsummerairtemp; Type: TABLE; Schema: views; Owner: imiq; Tablespace: 
--

CREATE TABLE annual_avgsummerairtemp (
    valueid bigint NOT NULL,
    datavalue double precision,
    siteid integer NOT NULL,
    utcdatetime timestamp without time zone,
    originalvariableid integer NOT NULL,
    variableid integer NOT NULL
);


ALTER TABLE views.annual_avgsummerairtemp OWNER TO imiq;

--
-- Name: annual_avgsummerairtemp_all; Type: TABLE; Schema: views; Owner: imiq; Tablespace: 
--

CREATE TABLE annual_avgsummerairtemp_all (
    siteid integer NOT NULL,
    year integer,
    seasonalavg double precision
);


ALTER TABLE views.annual_avgsummerairtemp_all OWNER TO imiq;

--
-- Name: annual_avgsummerdischarge; Type: TABLE; Schema: views; Owner: imiq; Tablespace: 
--

CREATE TABLE annual_avgsummerdischarge (
    valueid bigint NOT NULL,
    datavalue double precision,
    siteid integer NOT NULL,
    utcdatetime timestamp without time zone,
    originalvariableid integer NOT NULL,
    variableid integer NOT NULL
);


ALTER TABLE views.annual_avgsummerdischarge OWNER TO imiq;

--
-- Name: annual_avgsummerdischarge_all; Type: TABLE; Schema: views; Owner: imiq; Tablespace: 
--

CREATE TABLE annual_avgsummerdischarge_all (
    siteid integer NOT NULL,
    year integer,
    seasonalavg double precision
);


ALTER TABLE views.annual_avgsummerdischarge_all OWNER TO imiq;

--
-- Name: annual_avgsummerprecip; Type: TABLE; Schema: views; Owner: imiq; Tablespace: 
--

CREATE TABLE annual_avgsummerprecip (
    valueid bigint NOT NULL,
    datavalue double precision,
    siteid integer NOT NULL,
    utcdatetime timestamp without time zone,
    originalvariableid integer NOT NULL,
    variableid integer NOT NULL
);


ALTER TABLE views.annual_avgsummerprecip OWNER TO imiq;

--
-- Name: annual_avgsummerprecip_all; Type: TABLE; Schema: views; Owner: imiq; Tablespace: 
--

CREATE TABLE annual_avgsummerprecip_all (
    siteid integer NOT NULL,
    year integer,
    seasonalavg double precision
);


ALTER TABLE views.annual_avgsummerprecip_all OWNER TO imiq;

--
-- Name: annual_avgsummerrh; Type: TABLE; Schema: views; Owner: imiq; Tablespace: 
--

CREATE TABLE annual_avgsummerrh (
    valueid bigint NOT NULL,
    datavalue double precision,
    siteid integer NOT NULL,
    utcdatetime timestamp without time zone,
    originalvariableid integer NOT NULL,
    variableid integer NOT NULL
);


ALTER TABLE views.annual_avgsummerrh OWNER TO imiq;

--
-- Name: annual_avgsummerrh_all; Type: TABLE; Schema: views; Owner: imiq; Tablespace: 
--

CREATE TABLE annual_avgsummerrh_all (
    siteid integer NOT NULL,
    year integer,
    seasonalavgrh double precision,
    seasonalavgat double precision
);


ALTER TABLE views.annual_avgsummerrh_all OWNER TO imiq;

--
-- Name: annual_avgwinterairtemp; Type: TABLE; Schema: views; Owner: imiq; Tablespace: 
--

CREATE TABLE annual_avgwinterairtemp (
    valueid bigint NOT NULL,
    datavalue double precision,
    siteid integer NOT NULL,
    utcdatetime timestamp without time zone,
    originalvariableid integer NOT NULL,
    variableid integer NOT NULL
);


ALTER TABLE views.annual_avgwinterairtemp OWNER TO imiq;

--
-- Name: annual_avgwinterprecip; Type: TABLE; Schema: views; Owner: imiq; Tablespace: 
--

CREATE TABLE annual_avgwinterprecip (
    valueid bigint NOT NULL,
    datavalue double precision,
    siteid integer NOT NULL,
    utcdatetime timestamp without time zone,
    originalvariableid integer NOT NULL,
    variableid integer NOT NULL
);


ALTER TABLE views.annual_avgwinterprecip OWNER TO imiq;

--
-- Name: annual_avgwinterrh; Type: TABLE; Schema: views; Owner: imiq; Tablespace: 
--

CREATE TABLE annual_avgwinterrh (
    valueid bigint NOT NULL,
    datavalue double precision,
    siteid integer NOT NULL,
    utcdatetime timestamp without time zone,
    originalvariableid integer NOT NULL,
    variableid integer NOT NULL
);


ALTER TABLE views.annual_avgwinterrh OWNER TO imiq;

--
-- Name: annual_peakdischarge; Type: TABLE; Schema: views; Owner: imiq; Tablespace: 
--

CREATE TABLE annual_peakdischarge (
    valueid bigint NOT NULL,
    datavalue double precision,
    siteid integer NOT NULL,
    utcdatetime timestamp without time zone,
    originalvariableid integer NOT NULL,
    variableid integer NOT NULL
);


ALTER TABLE views.annual_peakdischarge OWNER TO imiq;

--
-- Name: annual_peaksnowdepth; Type: TABLE; Schema: views; Owner: imiq; Tablespace: 
--

CREATE TABLE annual_peaksnowdepth (
    valueid bigint NOT NULL,
    datavalue double precision,
    siteid integer NOT NULL,
    utcdatetime timestamp without time zone,
    originalvariableid integer NOT NULL,
    variableid integer NOT NULL
);


ALTER TABLE views.annual_peaksnowdepth OWNER TO imiq;

--
-- Name: annual_peakswe; Type: TABLE; Schema: views; Owner: imiq; Tablespace: 
--

CREATE TABLE annual_peakswe (
    valueid bigint NOT NULL,
    datavalue double precision,
    siteid integer NOT NULL,
    utcdatetime timestamp without time zone,
    originalvariableid integer NOT NULL,
    variableid integer NOT NULL
);


ALTER TABLE views.annual_peakswe OWNER TO imiq;

--
-- Name: annual_totalprecip; Type: TABLE; Schema: views; Owner: imiq; Tablespace: 
--

CREATE TABLE annual_totalprecip (
    valueid bigint NOT NULL,
    datavalue double precision,
    siteid integer NOT NULL,
    utcdatetime timestamp without time zone,
    originalvariableid integer NOT NULL,
    variableid integer NOT NULL
);


ALTER TABLE views.annual_totalprecip OWNER TO imiq;

--
-- Name: boundarycatalog; Type: TABLE; Schema: views; Owner: imiq; Tablespace: 
--

CREATE TABLE boundarycatalog (
    datastreamid integer NOT NULL,
    datastreamname character varying(255) NOT NULL,
    siteid integer NOT NULL,
    sitecode character varying(50) NOT NULL,
    sitename character varying(255),
    offsetvalue double precision,
    offsettypeid integer,
    variableid integer NOT NULL,
    variablecode character varying(50) NOT NULL,
    variablename character varying(255) NOT NULL,
    speciation character varying(255) NOT NULL,
    variableunitsid integer NOT NULL,
    samplemedium character varying(255) NOT NULL,
    valuetype character varying(255) NOT NULL,
    timesupport double precision NOT NULL,
    timeunitsid integer NOT NULL,
    datatype character varying(255) NOT NULL,
    generalcategory character varying(255) NOT NULL,
    methodid integer NOT NULL,
    deviceid integer NOT NULL,
    methoddescription text NOT NULL,
    sourceid integer NOT NULL,
    organization character varying(255) NOT NULL,
    sourcedescription text NOT NULL,
    citation text NOT NULL,
    qualitycontrollevelid integer,
    qualitycontrollevelcode character varying(50) NOT NULL,
    begindatetime character varying(100),
    enddatetime character varying(100),
    begindatetimeutc character varying(100),
    enddatetimeutc character varying(100),
    lat double precision,
    long double precision,
    elev double precision,
    geolocationtext text,
    spatialcharacteristics character varying(50) NOT NULL,
    totalvalues integer
);


ALTER TABLE views.boundarycatalog OWNER TO imiq;

--
-- Name: daily_airtemp; Type: TABLE; Schema: views; Owner: imiq; Tablespace: 
--

CREATE TABLE daily_airtemp (
    valueid integer NOT NULL,
    datavalue double precision,
    utcdatetime timestamp without time zone NOT NULL,
    siteid integer NOT NULL,
    originalvariableid integer NOT NULL,
    variableid integer NOT NULL
);


ALTER TABLE views.daily_airtemp OWNER TO imiq;

--
-- Name: daily_airtempmax; Type: TABLE; Schema: views; Owner: imiq; Tablespace: 
--

CREATE TABLE daily_airtempmax (
    valueid integer NOT NULL,
    datavalue double precision,
    utcdatetime timestamp without time zone NOT NULL,
    siteid integer NOT NULL,
    originalvariableid integer NOT NULL,
    variableid integer NOT NULL
);


ALTER TABLE views.daily_airtempmax OWNER TO imiq;

--
-- Name: daily_airtempmin; Type: TABLE; Schema: views; Owner: imiq; Tablespace: 
--

CREATE TABLE daily_airtempmin (
    valueid integer NOT NULL,
    datavalue double precision,
    utcdatetime timestamp without time zone NOT NULL,
    siteid integer NOT NULL,
    originalvariableid integer NOT NULL,
    variableid integer NOT NULL
);


ALTER TABLE views.daily_airtempmin OWNER TO imiq;

--
-- Name: daily_discharge; Type: TABLE; Schema: views; Owner: imiq; Tablespace: 
--

CREATE TABLE daily_discharge (
    valueid integer NOT NULL,
    datavalue double precision,
    utcdatetime timestamp without time zone NOT NULL,
    siteid integer NOT NULL,
    originalvariableid integer NOT NULL,
    variableid integer NOT NULL
);


ALTER TABLE views.daily_discharge OWNER TO imiq;

--
-- Name: daily_rh; Type: TABLE; Schema: views; Owner: imiq; Tablespace: 
--

CREATE TABLE daily_rh (
    valueid integer NOT NULL,
    datavalue double precision,
    utcdatetime timestamp without time zone NOT NULL,
    siteid integer NOT NULL,
    originalvariableid integer NOT NULL,
    variableid integer NOT NULL
);


ALTER TABLE views.daily_rh OWNER TO imiq;

--
-- Name: daily_utcdatetime; Type: TABLE; Schema: views; Owner: imiq; Tablespace: 
--

CREATE TABLE daily_utcdatetime (
    siteid integer NOT NULL,
    utcdatetime timestamp without time zone NOT NULL
);


ALTER TABLE views.daily_utcdatetime OWNER TO imiq;

--
-- Name: daily_watertemp; Type: TABLE; Schema: views; Owner: imiq; Tablespace: 
--

CREATE TABLE daily_watertemp (
    valueid integer NOT NULL,
    datavalue double precision,
    utcdatetime timestamp without time zone NOT NULL,
    siteid integer NOT NULL,
    originalvariableid integer NOT NULL,
    variableid integer NOT NULL
);


ALTER TABLE views.daily_watertemp OWNER TO imiq;

--
-- Name: daily_winddirection; Type: TABLE; Schema: views; Owner: imiq; Tablespace: 
--

CREATE TABLE daily_winddirection (
    valueid integer NOT NULL,
    datavalue double precision,
    utcdatetime timestamp without time zone NOT NULL,
    siteid integer NOT NULL,
    originalvariableid integer NOT NULL,
    variableid integer NOT NULL
);


ALTER TABLE views.daily_winddirection OWNER TO imiq;

--
-- Name: daily_windspeed; Type: TABLE; Schema: views; Owner: imiq; Tablespace: 
--

CREATE TABLE daily_windspeed (
    valueid integer NOT NULL,
    datavalue double precision,
    utcdatetime timestamp without time zone NOT NULL,
    siteid integer NOT NULL,
    originalvariableid integer NOT NULL,
    variableid integer NOT NULL
);


ALTER TABLE views.daily_windspeed OWNER TO imiq;

--
-- Name: datastreamvariables; Type: TABLE; Schema: views; Owner: imiq; Tablespace: 
--

CREATE TABLE datastreamvariables (
    datastreamname character varying(255) NOT NULL,
    siteid integer NOT NULL,
    bdate character varying(10),
    edate character varying(10),
    fieldname character varying(50),
    variablename character varying(255) NOT NULL,
    variabledescription text
);


ALTER TABLE views.datastreamvariables OWNER TO imiq;

--
-- Name: datavaluesaggregate; Type: TABLE; Schema: views; Owner: imiq; Tablespace: 
--

CREATE TABLE datavaluesaggregate (
    datastreamid integer NOT NULL,
    offsetvalue double precision,
    offsettypeid integer,
    begindatetime character varying(100),
    enddatetime character varying(100),
    begindatetimeutc character varying(100),
    enddatetimeutc character varying(100),
    totalvalues integer
);


ALTER TABLE views.datavaluesaggregate OWNER TO imiq;

--
-- Name: hourly_airtemp; Type: TABLE; Schema: views; Owner: imiq; Tablespace: 
--

CREATE TABLE hourly_airtemp (
    valueid integer NOT NULL,
    datavalue double precision,
    utcdatetime timestamp without time zone NOT NULL,
    siteid integer NOT NULL,
    originalvariableid integer NOT NULL,
    variableid integer NOT NULL
);


ALTER TABLE views.hourly_airtemp OWNER TO imiq;

--
-- Name: hourly_rh; Type: TABLE; Schema: views; Owner: imiq; Tablespace: 
--

CREATE TABLE hourly_rh (
    valueid integer NOT NULL,
    datavalue double precision,
    utcdatetime timestamp without time zone NOT NULL,
    siteid integer NOT NULL,
    originalvariableid integer NOT NULL,
    variableid integer NOT NULL
);


ALTER TABLE views.hourly_rh OWNER TO imiq;

--
-- Name: hourly_utcdatetime; Type: TABLE; Schema: views; Owner: imiq; Tablespace: 
--

CREATE TABLE hourly_utcdatetime (
    siteid integer NOT NULL,
    utcdatetime timestamp without time zone NOT NULL
);


ALTER TABLE views.hourly_utcdatetime OWNER TO imiq;

--
-- Name: hourly_winddirection; Type: TABLE; Schema: views; Owner: imiq; Tablespace: 
--

CREATE TABLE hourly_winddirection (
    valueid integer NOT NULL,
    datavalue double precision,
    utcdatetime timestamp without time zone NOT NULL,
    siteid integer NOT NULL,
    originalvariableid integer NOT NULL,
    variableid integer NOT NULL
);


ALTER TABLE views.hourly_winddirection OWNER TO imiq;

--
-- Name: hourly_windspeed; Type: TABLE; Schema: views; Owner: imiq; Tablespace: 
--

CREATE TABLE hourly_windspeed (
    valueid integer NOT NULL,
    datavalue double precision,
    utcdatetime timestamp without time zone NOT NULL,
    siteid integer NOT NULL,
    originalvariableid integer NOT NULL,
    variableid integer NOT NULL
);


ALTER TABLE views.hourly_windspeed OWNER TO imiq;

--
-- Name: monthly_airtemp; Type: TABLE; Schema: views; Owner: imiq; Tablespace: 
--

CREATE TABLE monthly_airtemp (
    valueid bigint NOT NULL,
    datavalue double precision,
    siteid integer NOT NULL,
    utcdatetime timestamp without time zone,
    originalvariableid integer NOT NULL,
    variableid integer NOT NULL
);


ALTER TABLE views.monthly_airtemp OWNER TO imiq;

--
-- Name: monthly_airtemp_all; Type: TABLE; Schema: views; Owner: imiq; Tablespace: 
--

CREATE TABLE monthly_airtemp_all (
    siteid integer NOT NULL,
    year integer,
    month integer,
    monthlyavg double precision,
    total integer
);


ALTER TABLE views.monthly_airtemp_all OWNER TO imiq;

--
-- Name: monthly_discharge; Type: TABLE; Schema: views; Owner: imiq; Tablespace: 
--

CREATE TABLE monthly_discharge (
    valueid bigint NOT NULL,
    datavalue double precision,
    siteid integer NOT NULL,
    utcdatetime timestamp without time zone,
    originalvariableid integer NOT NULL,
    variableid integer NOT NULL
);


ALTER TABLE views.monthly_discharge OWNER TO imiq;

--
-- Name: monthly_discharge_all; Type: TABLE; Schema: views; Owner: imiq; Tablespace: 
--

CREATE TABLE monthly_discharge_all (
    siteid integer NOT NULL,
    year integer,
    month integer,
    monthlyavg double precision,
    total integer
);


ALTER TABLE views.monthly_discharge_all OWNER TO imiq;

--
-- Name: monthly_precip; Type: TABLE; Schema: views; Owner: imiq; Tablespace: 
--

CREATE TABLE monthly_precip (
    valueid bigint NOT NULL,
    datavalue double precision,
    siteid integer NOT NULL,
    utcdatetime timestamp without time zone,
    originalvariableid integer NOT NULL,
    variableid integer NOT NULL
);


ALTER TABLE views.monthly_precip OWNER TO imiq;

--
-- Name: monthly_precip_all; Type: TABLE; Schema: views; Owner: imiq; Tablespace: 
--

CREATE TABLE monthly_precip_all (
    siteid integer NOT NULL,
    year integer,
    month integer,
    monthlytotal double precision,
    total integer
);


ALTER TABLE views.monthly_precip_all OWNER TO imiq;

--
-- Name: monthly_rh; Type: TABLE; Schema: views; Owner: imiq; Tablespace: 
--

CREATE TABLE monthly_rh (
    valueid bigint NOT NULL,
    datavalue double precision,
    siteid integer NOT NULL,
    utcdatetime timestamp without time zone,
    originalvariableid integer NOT NULL,
    variableid integer NOT NULL
);


ALTER TABLE views.monthly_rh OWNER TO imiq;

--
-- Name: monthly_snowdepthavg; Type: TABLE; Schema: views; Owner: imiq; Tablespace: 
--

CREATE TABLE monthly_snowdepthavg (
    valueid bigint NOT NULL,
    datavalue double precision,
    siteid integer NOT NULL,
    utcdatetime timestamp without time zone,
    originalvariableid integer NOT NULL,
    variableid integer NOT NULL
);


ALTER TABLE views.monthly_snowdepthavg OWNER TO imiq;

--
-- Name: monthly_snowdepthavg_all; Type: TABLE; Schema: views; Owner: imiq; Tablespace: 
--

CREATE TABLE monthly_snowdepthavg_all (
    siteid integer NOT NULL,
    year integer,
    month integer,
    monthlyavg double precision,
    total integer
);


ALTER TABLE views.monthly_snowdepthavg_all OWNER TO imiq;

--
-- Name: monthly_sweavg; Type: TABLE; Schema: views; Owner: imiq; Tablespace: 
--

CREATE TABLE monthly_sweavg (
    valueid bigint NOT NULL,
    datavalue double precision,
    siteid integer NOT NULL,
    utcdatetime timestamp without time zone,
    originalvariableid integer NOT NULL,
    variableid integer NOT NULL
);


ALTER TABLE views.monthly_sweavg OWNER TO imiq;

--
-- Name: monthly_sweavg_all; Type: TABLE; Schema: views; Owner: imiq; Tablespace: 
--

CREATE TABLE monthly_sweavg_all (
    siteid integer NOT NULL,
    year integer,
    month integer,
    monthlyavg double precision,
    total integer
);


ALTER TABLE views.monthly_sweavg_all OWNER TO imiq;

--
-- Name: multiyear_annual_avgairtemp; Type: TABLE; Schema: views; Owner: imiq; Tablespace: 
--

CREATE TABLE multiyear_annual_avgairtemp (
    valueid bigint NOT NULL,
    datavalue double precision,
    siteid integer NOT NULL,
    utcdatetime timestamp without time zone,
    originalvariableid integer NOT NULL,
    variableid integer NOT NULL
);


ALTER TABLE views.multiyear_annual_avgairtemp OWNER TO imiq;

--
-- Name: multiyear_annual_avgdischarge; Type: TABLE; Schema: views; Owner: imiq; Tablespace: 
--

CREATE TABLE multiyear_annual_avgdischarge (
    valueid bigint NOT NULL,
    datavalue double precision,
    siteid integer NOT NULL,
    utcdatetime timestamp without time zone,
    originalvariableid integer NOT NULL,
    variableid integer NOT NULL
);


ALTER TABLE views.multiyear_annual_avgdischarge OWNER TO imiq;

--
-- Name: multiyear_annual_avgfallairtemp; Type: TABLE; Schema: views; Owner: imiq; Tablespace: 
--

CREATE TABLE multiyear_annual_avgfallairtemp (
    valueid bigint NOT NULL,
    datavalue double precision,
    siteid integer NOT NULL,
    utcdatetime timestamp without time zone,
    originalvariableid integer NOT NULL,
    variableid integer NOT NULL
);


ALTER TABLE views.multiyear_annual_avgfallairtemp OWNER TO imiq;

--
-- Name: multiyear_annual_avgfallprecip; Type: TABLE; Schema: views; Owner: imiq; Tablespace: 
--

CREATE TABLE multiyear_annual_avgfallprecip (
    valueid bigint NOT NULL,
    datavalue double precision,
    siteid integer NOT NULL,
    utcdatetime timestamp without time zone,
    originalvariableid integer NOT NULL,
    variableid integer NOT NULL
);


ALTER TABLE views.multiyear_annual_avgfallprecip OWNER TO imiq;

--
-- Name: multiyear_annual_avgpeakdischarge; Type: TABLE; Schema: views; Owner: imiq; Tablespace: 
--

CREATE TABLE multiyear_annual_avgpeakdischarge (
    valueid bigint NOT NULL,
    datavalue double precision,
    siteid integer NOT NULL,
    utcdatetime timestamp without time zone,
    originalvariableid integer NOT NULL,
    variableid integer NOT NULL
);


ALTER TABLE views.multiyear_annual_avgpeakdischarge OWNER TO imiq;

--
-- Name: multiyear_annual_avgpeaksnowdepth; Type: TABLE; Schema: views; Owner: imiq; Tablespace: 
--

CREATE TABLE multiyear_annual_avgpeaksnowdepth (
    valueid bigint NOT NULL,
    datavalue double precision,
    siteid integer NOT NULL,
    utcdatetime timestamp without time zone,
    originalvariableid integer NOT NULL,
    variableid integer NOT NULL
);


ALTER TABLE views.multiyear_annual_avgpeaksnowdepth OWNER TO imiq;

--
-- Name: multiyear_annual_avgpeakswe; Type: TABLE; Schema: views; Owner: imiq; Tablespace: 
--

CREATE TABLE multiyear_annual_avgpeakswe (
    valueid bigint NOT NULL,
    datavalue double precision,
    siteid integer NOT NULL,
    utcdatetime timestamp without time zone,
    originalvariableid integer NOT NULL,
    variableid integer NOT NULL
);


ALTER TABLE views.multiyear_annual_avgpeakswe OWNER TO imiq;

--
-- Name: multiyear_annual_avgprecip; Type: TABLE; Schema: views; Owner: imiq; Tablespace: 
--

CREATE TABLE multiyear_annual_avgprecip (
    valueid bigint NOT NULL,
    datavalue double precision,
    siteid integer NOT NULL,
    utcdatetime timestamp without time zone,
    originalvariableid integer NOT NULL,
    variableid integer NOT NULL
);


ALTER TABLE views.multiyear_annual_avgprecip OWNER TO imiq;

--
-- Name: multiyear_annual_avgrh; Type: TABLE; Schema: views; Owner: imiq; Tablespace: 
--

CREATE TABLE multiyear_annual_avgrh (
    valueid bigint NOT NULL,
    datavalue double precision,
    siteid integer NOT NULL,
    utcdatetime timestamp without time zone,
    originalvariableid integer NOT NULL,
    variableid integer NOT NULL
);


ALTER TABLE views.multiyear_annual_avgrh OWNER TO imiq;

--
-- Name: multiyear_annual_avgspringairtemp; Type: TABLE; Schema: views; Owner: imiq; Tablespace: 
--

CREATE TABLE multiyear_annual_avgspringairtemp (
    valueid bigint NOT NULL,
    datavalue double precision,
    siteid integer NOT NULL,
    utcdatetime timestamp without time zone,
    originalvariableid integer NOT NULL,
    variableid integer NOT NULL
);


ALTER TABLE views.multiyear_annual_avgspringairtemp OWNER TO imiq;

--
-- Name: multiyear_annual_avgspringprecip; Type: TABLE; Schema: views; Owner: imiq; Tablespace: 
--

CREATE TABLE multiyear_annual_avgspringprecip (
    valueid bigint NOT NULL,
    datavalue double precision,
    siteid integer NOT NULL,
    utcdatetime timestamp without time zone,
    originalvariableid integer NOT NULL,
    variableid integer NOT NULL
);


ALTER TABLE views.multiyear_annual_avgspringprecip OWNER TO imiq;

--
-- Name: multiyear_annual_avgsummerairtemp; Type: TABLE; Schema: views; Owner: imiq; Tablespace: 
--

CREATE TABLE multiyear_annual_avgsummerairtemp (
    valueid bigint NOT NULL,
    datavalue double precision,
    siteid integer NOT NULL,
    utcdatetime timestamp without time zone,
    originalvariableid integer NOT NULL,
    variableid integer NOT NULL
);


ALTER TABLE views.multiyear_annual_avgsummerairtemp OWNER TO imiq;

--
-- Name: multiyear_annual_avgsummerdischarge; Type: TABLE; Schema: views; Owner: imiq; Tablespace: 
--

CREATE TABLE multiyear_annual_avgsummerdischarge (
    valueid bigint NOT NULL,
    datavalue double precision,
    siteid integer NOT NULL,
    utcdatetime timestamp without time zone,
    originalvariableid integer NOT NULL,
    variableid integer NOT NULL
);


ALTER TABLE views.multiyear_annual_avgsummerdischarge OWNER TO imiq;

--
-- Name: multiyear_annual_avgsummerprecip; Type: TABLE; Schema: views; Owner: imiq; Tablespace: 
--

CREATE TABLE multiyear_annual_avgsummerprecip (
    valueid bigint NOT NULL,
    datavalue double precision,
    siteid integer NOT NULL,
    utcdatetime timestamp without time zone,
    originalvariableid integer NOT NULL,
    variableid integer NOT NULL
);


ALTER TABLE views.multiyear_annual_avgsummerprecip OWNER TO imiq;

--
-- Name: multiyear_annual_avgsummerrh; Type: TABLE; Schema: views; Owner: imiq; Tablespace: 
--

CREATE TABLE multiyear_annual_avgsummerrh (
    valueid bigint NOT NULL,
    datavalue double precision,
    siteid integer NOT NULL,
    utcdatetime timestamp without time zone,
    originalvariableid integer NOT NULL,
    variableid integer NOT NULL
);


ALTER TABLE views.multiyear_annual_avgsummerrh OWNER TO imiq;

--
-- Name: multiyear_annual_avgwinterairtemp; Type: TABLE; Schema: views; Owner: imiq; Tablespace: 
--

CREATE TABLE multiyear_annual_avgwinterairtemp (
    valueid bigint NOT NULL,
    datavalue double precision,
    siteid integer NOT NULL,
    utcdatetime timestamp without time zone,
    originalvariableid integer NOT NULL,
    variableid integer NOT NULL
);


ALTER TABLE views.multiyear_annual_avgwinterairtemp OWNER TO imiq;

--
-- Name: multiyear_annual_avgwinterprecip; Type: TABLE; Schema: views; Owner: imiq; Tablespace: 
--

CREATE TABLE multiyear_annual_avgwinterprecip (
    valueid bigint NOT NULL,
    datavalue double precision,
    siteid integer NOT NULL,
    utcdatetime timestamp without time zone,
    originalvariableid integer NOT NULL,
    variableid integer NOT NULL
);


ALTER TABLE views.multiyear_annual_avgwinterprecip OWNER TO imiq;

--
-- Name: multiyear_annual_avgwinterrh; Type: TABLE; Schema: views; Owner: imiq; Tablespace: 
--

CREATE TABLE multiyear_annual_avgwinterrh (
    valueid bigint NOT NULL,
    datavalue double precision,
    siteid integer NOT NULL,
    utcdatetime timestamp without time zone,
    originalvariableid integer NOT NULL,
    variableid integer NOT NULL
);


ALTER TABLE views.multiyear_annual_avgwinterrh OWNER TO imiq;

--
-- Name: odmdatavalues; Type: TABLE; Schema: views; Owner: imiq; Tablespace: 
--

CREATE TABLE odmdatavalues (
    valueid integer NOT NULL,
    datavalue double precision,
    valueaccuracy double precision,
    localdatetime timestamp without time zone NOT NULL,
    utcoffset double precision NOT NULL,
    datetimeutc timestamp without time zone,
    siteid integer NOT NULL,
    variableid integer NOT NULL,
    offsetvalue double precision,
    offsettypeid integer,
    censorcode character varying(50),
    qualifierid integer,
    methodid integer NOT NULL,
    sourceid integer NOT NULL,
    derivedfromid integer,
    qualitycontrollevelid integer,
    geographylocation public.geography,
    spatialcharacteristics character varying(50) NOT NULL
);


ALTER TABLE views.odmdatavalues OWNER TO imiq;

--
-- Name: odmdatavalues_metric; Type: TABLE; Schema: views; Owner: imiq; Tablespace: 
--

CREATE TABLE odmdatavalues_metric (
    valueid integer NOT NULL,
    datavalue double precision,
    valueaccuracy double precision,
    localdatetime timestamp without time zone,
    utcoffset double precision,
    datetimeutc timestamp without time zone,
    siteid integer,
    originalvariableid integer,
    variablename character varying(255),
    samplemedium character varying(255),
    variableunitsid integer,
    variabletimeunits integer,
    offsetvalue double precision,
    offsettypeid integer,
    censorcode character varying(50),
    qualifierid integer,
    methodid integer,
    sourceid integer,
    derivedfromid integer,
    qualitycontrollevelid integer,
    geographylocation public.geography,
    geolocation text,
    spatialcharacteristics character varying(50)
);


ALTER TABLE views.odmdatavalues_metric OWNER TO imiq;

--
-- Name: queryme; Type: TABLE; Schema: views; Owner: imiq; Tablespace: 
--

CREATE TABLE queryme (
    siteid integer NOT NULL,
    sitename character varying(255),
    variablename character varying(255) NOT NULL,
    variabledescription text,
    samplemedium character varying(255) NOT NULL,
    organization character varying(255) NOT NULL,
    organizationdescription text NOT NULL,
    organizationcode character varying(50) NOT NULL,
    startdate character varying(100),
    enddate character varying(100),
    citation text NOT NULL
);


ALTER TABLE views.queryme OWNER TO imiq;

--
-- Name: siteattributesource; Type: TABLE; Schema: views; Owner: imiq; Tablespace: 
--

CREATE TABLE siteattributesource (
    sourceid integer NOT NULL,
    siteid integer NOT NULL,
    sitename character varying(255),
    organization character varying(255) NOT NULL,
    sourcedescription text NOT NULL,
    sourcelink character varying(500),
    geographylocation bytea,
    attributevalue character varying(255) NOT NULL,
    sitecomments text,
    locationdescription text,
    sitecode character varying(50) NOT NULL
);


ALTER TABLE views.siteattributesource OWNER TO imiq;

--
-- Name: sitegeography; Type: TABLE; Schema: views; Owner: imiq; Tablespace: 
--

CREATE TABLE sitegeography (
    siteid integer NOT NULL,
    sitecode character varying(50) NOT NULL,
    sitename character varying(255),
    spatialcharacteristics character varying(50) NOT NULL,
    sourceid integer NOT NULL,
    verticaldatum character varying(255),
    localprojectionid integer,
    posaccuracy_m double precision,
    state character varying(255),
    county character varying(255),
    comments text,
    latlongdatumid integer NOT NULL,
    geographylocation bytea,
    locationdescription text
);


ALTER TABLE views.sitegeography OWNER TO imiq;

--
-- Name: sitegeography_siteid_seq; Type: SEQUENCE; Schema: views; Owner: imiq
--

CREATE SEQUENCE sitegeography_siteid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE views.sitegeography_siteid_seq OWNER TO imiq;

--
-- Name: sitegeography_siteid_seq; Type: SEQUENCE OWNED BY; Schema: views; Owner: imiq
--

ALTER SEQUENCE sitegeography_siteid_seq OWNED BY sitegeography.siteid;


--
-- Name: sitesource; Type: TABLE; Schema: views; Owner: imiq; Tablespace: 
--

CREATE TABLE sitesource (
    sourceid integer NOT NULL,
    siteid integer NOT NULL,
    sitename character varying(255),
    sitecomments text,
    organization character varying(255) NOT NULL,
    sourcedescription text NOT NULL,
    sourcelink character varying(500),
    spatialcharacteristics character varying(50) NOT NULL,
    geographylocation bytea,
    locationdescription text,
    sitecode character varying(50) NOT NULL
);


ALTER TABLE views.sitesource OWNER TO imiq;

--
-- Name: sitesourcedescription; Type: TABLE; Schema: views; Owner: imiq; Tablespace: 
--

CREATE TABLE sitesourcedescription (
    organizationcode character varying(50) NOT NULL,
    organizationdescription text NOT NULL,
    contactname character varying(255) NOT NULL,
    sourcedescription text NOT NULL,
    sourceorg character varying(255) NOT NULL,
    sourcelink character varying(500),
    sitename character varying(255),
    geographylocation bytea,
    spatialcharacteristics character varying(50) NOT NULL,
    sitecomments text,
    siteid integer NOT NULL,
    sourceid integer NOT NULL,
    organizationid integer NOT NULL
);


ALTER TABLE views.sitesourcedescription OWNER TO imiq;

SET search_path = tables, pg_catalog;

--
-- Name: attributeid; Type: DEFAULT; Schema: tables; Owner: imiq
--

ALTER TABLE ONLY attributes ALTER COLUMN attributeid SET DEFAULT nextval('attributes_attributeid_seq'::regclass);


--
-- Name: categoryid; Type: DEFAULT; Schema: tables; Owner: imiq
--

ALTER TABLE ONLY categories ALTER COLUMN categoryid SET DEFAULT nextval('categories_categoryid_seq'::regclass);


--
-- Name: valueid; Type: DEFAULT; Schema: tables; Owner: imiq
--

ALTER TABLE ONLY daily_airtempdatavalues ALTER COLUMN valueid SET DEFAULT nextval('daily_airtempdatavalues_valueid_seq'::regclass);


--
-- Name: valueid; Type: DEFAULT; Schema: tables; Owner: imiq
--

ALTER TABLE ONLY daily_airtempmaxdatavalues ALTER COLUMN valueid SET DEFAULT nextval('daily_airtempmaxdatavalues_valueid_seq'::regclass);


--
-- Name: valueid; Type: DEFAULT; Schema: tables; Owner: imiq
--

ALTER TABLE ONLY daily_airtempmindatavalues ALTER COLUMN valueid SET DEFAULT nextval('daily_airtempmindatavalues_valueid_seq'::regclass);


--
-- Name: valueid; Type: DEFAULT; Schema: tables; Owner: imiq
--

ALTER TABLE ONLY daily_dischargedatavalues ALTER COLUMN valueid SET DEFAULT nextval('daily_dischargedatavalues_valueid_seq'::regclass);


--
-- Name: valueid; Type: DEFAULT; Schema: tables; Owner: imiq
--

ALTER TABLE ONLY daily_precipdatavalues ALTER COLUMN valueid SET DEFAULT nextval('daily_precipdatavalues_valueid_seq'::regclass);


--
-- Name: valueid; Type: DEFAULT; Schema: tables; Owner: imiq
--

ALTER TABLE ONLY daily_rhdatavalues ALTER COLUMN valueid SET DEFAULT nextval('daily_rhdatavalues_valueid_seq'::regclass);


--
-- Name: valueid; Type: DEFAULT; Schema: tables; Owner: imiq
--

ALTER TABLE ONLY daily_snowdepthdatavalues ALTER COLUMN valueid SET DEFAULT nextval('daily_snowdepthdatavalues_valueid_seq'::regclass);


--
-- Name: valueid; Type: DEFAULT; Schema: tables; Owner: imiq
--

ALTER TABLE ONLY daily_swedatavalues ALTER COLUMN valueid SET DEFAULT nextval('daily_swedatavalues_valueid_seq'::regclass);


--
-- Name: valueid; Type: DEFAULT; Schema: tables; Owner: imiq
--

ALTER TABLE ONLY daily_watertempdatavalues ALTER COLUMN valueid SET DEFAULT nextval('daily_watertempdatavalues_valueid_seq'::regclass);


--
-- Name: valueid; Type: DEFAULT; Schema: tables; Owner: imiq
--

ALTER TABLE ONLY daily_winddirectiondatavalues ALTER COLUMN valueid SET DEFAULT nextval('daily_winddirectiondatavalues_valueid_seq'::regclass);


--
-- Name: valueid; Type: DEFAULT; Schema: tables; Owner: imiq
--

ALTER TABLE ONLY daily_windspeeddatavalues ALTER COLUMN valueid SET DEFAULT nextval('daily_windspeeddatavalues_valueid_seq'::regclass);


--
-- Name: datastreamid; Type: DEFAULT; Schema: tables; Owner: imiq
--

ALTER TABLE ONLY datastreams ALTER COLUMN datastreamid SET DEFAULT nextval('datastreams_datastreamid_seq'::regclass);


--
-- Name: valueid; Type: DEFAULT; Schema: tables; Owner: imiq
--

ALTER TABLE ONLY datavalues ALTER COLUMN valueid SET DEFAULT nextval('datavalues_valueid_seq'::regclass);


--
-- Name: valueid; Type: DEFAULT; Schema: tables; Owner: imiq
--

ALTER TABLE ONLY datavaluesraw ALTER COLUMN valueid SET DEFAULT nextval('datavaluesraw_valueid_seq'::regclass);


--
-- Name: deviceid; Type: DEFAULT; Schema: tables; Owner: imiq
--

ALTER TABLE ONLY devices ALTER COLUMN deviceid SET DEFAULT nextval('devices_deviceid_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: tables; Owner: imiq
--

ALTER TABLE ONLY ext_arc_arc ALTER COLUMN id SET DEFAULT nextval('ext_arc_arc_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: tables; Owner: imiq
--

ALTER TABLE ONLY ext_arc_point ALTER COLUMN id SET DEFAULT nextval('ext_arc_point_id_seq'::regclass);


--
-- Name: fishsampleid; Type: DEFAULT; Schema: tables; Owner: imiq
--

ALTER TABLE ONLY ext_fws_fishsample ALTER COLUMN fishsampleid SET DEFAULT nextval('ext_fws_fishsample_fishsampleid_seq'::regclass);


--
-- Name: referenceid; Type: DEFAULT; Schema: tables; Owner: imiq
--

ALTER TABLE ONLY ext_reference ALTER COLUMN referenceid SET DEFAULT nextval('ext_reference_referenceid_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: tables; Owner: imiq
--

ALTER TABLE ONLY ext_referencetowaterbody ALTER COLUMN id SET DEFAULT nextval('ext_referencetowaterbody_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: tables; Owner: imiq
--

ALTER TABLE ONLY ext_waterbody ALTER COLUMN id SET DEFAULT nextval('ext_waterbody_id_seq'::regclass);


--
-- Name: groupid; Type: DEFAULT; Schema: tables; Owner: imiq
--

ALTER TABLE ONLY groupdescriptions ALTER COLUMN groupid SET DEFAULT nextval('groupdescriptions_groupid_seq'::regclass);


--
-- Name: valueid; Type: DEFAULT; Schema: tables; Owner: imiq
--

ALTER TABLE ONLY hourly_airtempdatavalues ALTER COLUMN valueid SET DEFAULT nextval('hourly_airtempdatavalues_valueid_seq'::regclass);


--
-- Name: valueid; Type: DEFAULT; Schema: tables; Owner: imiq
--

ALTER TABLE ONLY hourly_precipdatavalues ALTER COLUMN valueid SET DEFAULT nextval('hourly_precipdatavalues_valueid_seq'::regclass);


--
-- Name: valueid; Type: DEFAULT; Schema: tables; Owner: imiq
--

ALTER TABLE ONLY hourly_rhdatavalues ALTER COLUMN valueid SET DEFAULT nextval('hourly_rhdatavalues_valueid_seq'::regclass);


--
-- Name: valueid; Type: DEFAULT; Schema: tables; Owner: imiq
--

ALTER TABLE ONLY hourly_snowdepthdatavalues ALTER COLUMN valueid SET DEFAULT nextval('hourly_snowdepthdatavalues_valueid_seq'::regclass);


--
-- Name: valueid; Type: DEFAULT; Schema: tables; Owner: imiq
--

ALTER TABLE ONLY hourly_swedatavalues ALTER COLUMN valueid SET DEFAULT nextval('hourly_swedatavalues_valueid_seq'::regclass);


--
-- Name: valueid; Type: DEFAULT; Schema: tables; Owner: imiq
--

ALTER TABLE ONLY hourly_winddirectiondatavalues ALTER COLUMN valueid SET DEFAULT nextval('hourly_winddirectiondatavalues_valueid_seq'::regclass);


--
-- Name: valueid; Type: DEFAULT; Schema: tables; Owner: imiq
--

ALTER TABLE ONLY hourly_windspeeddatavalues ALTER COLUMN valueid SET DEFAULT nextval('hourly_windspeeddatavalues_valueid_seq'::regclass);


--
-- Name: incidentid; Type: DEFAULT; Schema: tables; Owner: imiq
--

ALTER TABLE ONLY incidents ALTER COLUMN incidentid SET DEFAULT nextval('incidents_incidentid_seq'::regclass);


--
-- Name: metadataid; Type: DEFAULT; Schema: tables; Owner: imiq
--

ALTER TABLE ONLY isometadata ALTER COLUMN metadataid SET DEFAULT nextval('isometadata_metadataid_seq'::regclass);


--
-- Name: methodid; Type: DEFAULT; Schema: tables; Owner: imiq
--

ALTER TABLE ONLY methods ALTER COLUMN methodid SET DEFAULT nextval('methods_methodid_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: tables; Owner: imiq
--

ALTER TABLE ONLY nhd_huc8 ALTER COLUMN id SET DEFAULT nextval('nhd_huc8_id_seq'::regclass);


--
-- Name: offsettypeid; Type: DEFAULT; Schema: tables; Owner: imiq
--

ALTER TABLE ONLY offsettypes ALTER COLUMN offsettypeid SET DEFAULT nextval('offsettypes_offsettypeid_seq'::regclass);


--
-- Name: processingid; Type: DEFAULT; Schema: tables; Owner: imiq
--

ALTER TABLE ONLY processing ALTER COLUMN processingid SET DEFAULT nextval('processing_processingid_seq'::regclass);


--
-- Name: qualifierid; Type: DEFAULT; Schema: tables; Owner: imiq
--

ALTER TABLE ONLY qualifiers ALTER COLUMN qualifierid SET DEFAULT nextval('qualifiers_qualifierid_seq'::regclass);


--
-- Name: qualitycontrollevelid; Type: DEFAULT; Schema: tables; Owner: imiq
--

ALTER TABLE ONLY qualitycontrollevels ALTER COLUMN qualitycontrollevelid SET DEFAULT nextval('qualitycontrollevels_qualitycontrollevelid_seq'::regclass);


--
-- Name: valueid; Type: DEFAULT; Schema: tables; Owner: imiq
--

ALTER TABLE ONLY rasterdatavalues ALTER COLUMN valueid SET DEFAULT nextval('rasterdatavalues_valueid_seq'::regclass);


--
-- Name: siteid; Type: DEFAULT; Schema: tables; Owner: imiq
--

ALTER TABLE ONLY sites ALTER COLUMN siteid SET DEFAULT nextval('sites_siteid_seq'::regclass);


--
-- Name: sourceid; Type: DEFAULT; Schema: tables; Owner: imiq
--

ALTER TABLE ONLY sources ALTER COLUMN sourceid SET DEFAULT nextval('sources_sourceid_seq'::regclass);


--
-- Name: spatialreferenceid; Type: DEFAULT; Schema: tables; Owner: imiq
--

ALTER TABLE ONLY spatialreferences ALTER COLUMN spatialreferenceid SET DEFAULT nextval('spatialreferences_spatialreferenceid_seq'::regclass);


--
-- Name: diagram_id; Type: DEFAULT; Schema: tables; Owner: imiq
--

ALTER TABLE ONLY sysdiagrams ALTER COLUMN diagram_id SET DEFAULT nextval('sysdiagrams_diagram_id_seq'::regclass);


--
-- Name: unitsid; Type: DEFAULT; Schema: tables; Owner: imiq
--

ALTER TABLE ONLY units ALTER COLUMN unitsid SET DEFAULT nextval('units_unitsid_seq'::regclass);


--
-- Name: variableid; Type: DEFAULT; Schema: tables; Owner: imiq
--

ALTER TABLE ONLY variables ALTER COLUMN variableid SET DEFAULT nextval('variables_variableid_seq'::regclass);


SET search_path = views, pg_catalog;

--
-- Name: siteid; Type: DEFAULT; Schema: views; Owner: imiq
--

ALTER TABLE ONLY sitegeography ALTER COLUMN siteid SET DEFAULT nextval('sitegeography_siteid_seq'::regclass);


SET search_path = public, pg_catalog;

--
-- Name: geometry_columns_pk; Type: CONSTRAINT; Schema: public; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY geometry_columns
    ADD CONSTRAINT geometry_columns_pk PRIMARY KEY (f_table_catalog, f_table_schema, f_table_name, f_geometry_column);


--
-- Name: spatial_ref_sys_pkey; Type: CONSTRAINT; Schema: public; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY spatial_ref_sys
    ADD CONSTRAINT spatial_ref_sys_pkey PRIMARY KEY (srid);


SET search_path = tables, pg_catalog;

--
-- Name: attributes_attributeid; Type: CONSTRAINT; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY attributes
    ADD CONSTRAINT attributes_attributeid PRIMARY KEY (attributeid);


--
-- Name: categories_categoryid; Type: CONSTRAINT; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY categories
    ADD CONSTRAINT categories_categoryid PRIMARY KEY (categoryid);


--
-- Name: censorcodecv_term; Type: CONSTRAINT; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY censorcodecv
    ADD CONSTRAINT censorcodecv_term PRIMARY KEY (term);


--
-- Name: daily_airtempdatavalues_valueid; Type: CONSTRAINT; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY daily_airtempdatavalues
    ADD CONSTRAINT daily_airtempdatavalues_valueid PRIMARY KEY (valueid);


--
-- Name: daily_airtempmaxdatavalues_valueid; Type: CONSTRAINT; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY daily_airtempmaxdatavalues
    ADD CONSTRAINT daily_airtempmaxdatavalues_valueid PRIMARY KEY (valueid);


--
-- Name: daily_airtempmindatavalues_valueid; Type: CONSTRAINT; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY daily_airtempmindatavalues
    ADD CONSTRAINT daily_airtempmindatavalues_valueid PRIMARY KEY (valueid);


--
-- Name: daily_dischargedatavalues_valueid; Type: CONSTRAINT; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY daily_dischargedatavalues
    ADD CONSTRAINT daily_dischargedatavalues_valueid PRIMARY KEY (valueid);


--
-- Name: daily_precipdatavalues_valueid; Type: CONSTRAINT; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY daily_precipdatavalues
    ADD CONSTRAINT daily_precipdatavalues_valueid PRIMARY KEY (valueid);


--
-- Name: daily_rhdatavalues_valueid; Type: CONSTRAINT; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY daily_rhdatavalues
    ADD CONSTRAINT daily_rhdatavalues_valueid PRIMARY KEY (valueid);


--
-- Name: daily_snowdepthdatavalues_valueid; Type: CONSTRAINT; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY daily_snowdepthdatavalues
    ADD CONSTRAINT daily_snowdepthdatavalues_valueid PRIMARY KEY (valueid);


--
-- Name: daily_swedatavalues_valueid; Type: CONSTRAINT; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY daily_swedatavalues
    ADD CONSTRAINT daily_swedatavalues_valueid PRIMARY KEY (valueid);


--
-- Name: daily_watertempdatavalues_valueid; Type: CONSTRAINT; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY daily_watertempdatavalues
    ADD CONSTRAINT daily_watertempdatavalues_valueid PRIMARY KEY (valueid);


--
-- Name: daily_winddirectiondatavalues_valueid; Type: CONSTRAINT; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY daily_winddirectiondatavalues
    ADD CONSTRAINT daily_winddirectiondatavalues_valueid PRIMARY KEY (valueid);


--
-- Name: daily_windspeeddatavalues_valueid; Type: CONSTRAINT; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY daily_windspeeddatavalues
    ADD CONSTRAINT daily_windspeeddatavalues_valueid PRIMARY KEY (valueid);


--
-- Name: datastreams_datastreamid; Type: CONSTRAINT; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY datastreams
    ADD CONSTRAINT datastreams_datastreamid PRIMARY KEY (datastreamid);


--
-- Name: datatypecv_term; Type: CONSTRAINT; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY datatypecv
    ADD CONSTRAINT datatypecv_term PRIMARY KEY (term);


--
-- Name: datavalues_valueid; Type: CONSTRAINT; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY datavalues
    ADD CONSTRAINT datavalues_valueid PRIMARY KEY (valueid);


--
-- Name: datavaluesraw_valueid; Type: CONSTRAINT; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY datavaluesraw
    ADD CONSTRAINT datavaluesraw_valueid PRIMARY KEY (valueid);


--
-- Name: derivedfrom_derivedfromid; Type: CONSTRAINT; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY derivedfrom
    ADD CONSTRAINT derivedfrom_derivedfromid PRIMARY KEY (derivedfromid);


--
-- Name: devices_deviceid; Type: CONSTRAINT; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY devices
    ADD CONSTRAINT devices_deviceid PRIMARY KEY (deviceid);


--
-- Name: ext_arc_arc_id; Type: CONSTRAINT; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY ext_arc_arc
    ADD CONSTRAINT ext_arc_arc_id PRIMARY KEY (id);


--
-- Name: ext_arc_point_id; Type: CONSTRAINT; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY ext_arc_point
    ADD CONSTRAINT ext_arc_point_id PRIMARY KEY (id);


--
-- Name: ext_fws_fishsample_fishsampleid; Type: CONSTRAINT; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY ext_fws_fishsample
    ADD CONSTRAINT ext_fws_fishsample_fishsampleid PRIMARY KEY (fishsampleid);


--
-- Name: ext_reference_referenceid; Type: CONSTRAINT; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY ext_reference
    ADD CONSTRAINT ext_reference_referenceid PRIMARY KEY (referenceid);


--
-- Name: ext_referencetowaterbody_id; Type: CONSTRAINT; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY ext_referencetowaterbody
    ADD CONSTRAINT ext_referencetowaterbody_id PRIMARY KEY (id);


--
-- Name: ext_waterbody_id; Type: CONSTRAINT; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY ext_waterbody
    ADD CONSTRAINT ext_waterbody_id PRIMARY KEY (id);


--
-- Name: generalcategorycv_term; Type: CONSTRAINT; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY generalcategorycv
    ADD CONSTRAINT generalcategorycv_term PRIMARY KEY (term);


--
-- Name: groupdescriptions_groupid; Type: CONSTRAINT; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY groupdescriptions
    ADD CONSTRAINT groupdescriptions_groupid PRIMARY KEY (groupid);


--
-- Name: hourly_airtempdatavalues_valueid; Type: CONSTRAINT; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY hourly_airtempdatavalues
    ADD CONSTRAINT hourly_airtempdatavalues_valueid PRIMARY KEY (valueid);


--
-- Name: hourly_precipdatavalues_valueid; Type: CONSTRAINT; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY hourly_precipdatavalues
    ADD CONSTRAINT hourly_precipdatavalues_valueid PRIMARY KEY (valueid);


--
-- Name: hourly_rhdatavalues_valueid; Type: CONSTRAINT; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY hourly_rhdatavalues
    ADD CONSTRAINT hourly_rhdatavalues_valueid PRIMARY KEY (valueid);


--
-- Name: hourly_snowdepthdatavalues_valueid; Type: CONSTRAINT; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY hourly_snowdepthdatavalues
    ADD CONSTRAINT hourly_snowdepthdatavalues_valueid PRIMARY KEY (valueid);


--
-- Name: hourly_swedatavalues_valueid; Type: CONSTRAINT; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY hourly_swedatavalues
    ADD CONSTRAINT hourly_swedatavalues_valueid PRIMARY KEY (valueid);


--
-- Name: hourly_winddirectiondatavalues_valueid; Type: CONSTRAINT; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY hourly_winddirectiondatavalues
    ADD CONSTRAINT hourly_winddirectiondatavalues_valueid PRIMARY KEY (valueid);


--
-- Name: hourly_windspeeddatavalues_valueid; Type: CONSTRAINT; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY hourly_windspeeddatavalues
    ADD CONSTRAINT hourly_windspeeddatavalues_valueid PRIMARY KEY (valueid);


--
-- Name: incidents_incidentid; Type: CONSTRAINT; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY incidents
    ADD CONSTRAINT incidents_incidentid PRIMARY KEY (incidentid);


--
-- Name: isometadata_metadataid; Type: CONSTRAINT; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY isometadata
    ADD CONSTRAINT isometadata_metadataid PRIMARY KEY (metadataid);


--
-- Name: methods_methodid; Type: CONSTRAINT; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY methods
    ADD CONSTRAINT methods_methodid PRIMARY KEY (methodid);


--
-- Name: networkdescriptions_networkid; Type: CONSTRAINT; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY networkdescriptions
    ADD CONSTRAINT networkdescriptions_networkid PRIMARY KEY (networkid);


--
-- Name: nhd_huc8_id; Type: CONSTRAINT; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY nhd_huc8
    ADD CONSTRAINT nhd_huc8_id PRIMARY KEY (id);


--
-- Name: offsettypes_offsettypeid; Type: CONSTRAINT; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY offsettypes
    ADD CONSTRAINT offsettypes_offsettypeid PRIMARY KEY (offsettypeid);


--
-- Name: organizationdescriptions_organizationid; Type: CONSTRAINT; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY organizationdescriptions
    ADD CONSTRAINT organizationdescriptions_organizationid PRIMARY KEY (organizationid);


--
-- Name: processing_processingid; Type: CONSTRAINT; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY processing
    ADD CONSTRAINT processing_processingid PRIMARY KEY (processingid);


--
-- Name: qualifiers_qualifierid; Type: CONSTRAINT; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY qualifiers
    ADD CONSTRAINT qualifiers_qualifierid PRIMARY KEY (qualifierid);


--
-- Name: qualitycontrollevels_qualitycontrollevelid; Type: CONSTRAINT; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY qualitycontrollevels
    ADD CONSTRAINT qualitycontrollevels_qualitycontrollevelid PRIMARY KEY (qualitycontrollevelid);


--
-- Name: rasterdatavalues_valueid; Type: CONSTRAINT; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY rasterdatavalues
    ADD CONSTRAINT rasterdatavalues_valueid PRIMARY KEY (valueid);


--
-- Name: samplemediumcv_term; Type: CONSTRAINT; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY samplemediumcv
    ADD CONSTRAINT samplemediumcv_term PRIMARY KEY (term);


--
-- Name: sites_siteid; Type: CONSTRAINT; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY sites
    ADD CONSTRAINT sites_siteid PRIMARY KEY (siteid);


--
-- Name: sources_sourceid; Type: CONSTRAINT; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY sources
    ADD CONSTRAINT sources_sourceid PRIMARY KEY (sourceid);


--
-- Name: spatialreferences_spatialreferenceid; Type: CONSTRAINT; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY spatialreferences
    ADD CONSTRAINT spatialreferences_spatialreferenceid PRIMARY KEY (spatialreferenceid);


--
-- Name: speciationcv_term; Type: CONSTRAINT; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY speciationcv
    ADD CONSTRAINT speciationcv_term PRIMARY KEY (term);


--
-- Name: sysdiagrams_diagram_id; Type: CONSTRAINT; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY sysdiagrams
    ADD CONSTRAINT sysdiagrams_diagram_id PRIMARY KEY (diagram_id);


--
-- Name: topiccategorycv_term; Type: CONSTRAINT; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY topiccategorycv
    ADD CONSTRAINT topiccategorycv_term PRIMARY KEY (term);


--
-- Name: units_unitsid; Type: CONSTRAINT; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY units
    ADD CONSTRAINT units_unitsid PRIMARY KEY (unitsid);


--
-- Name: valuetypecv_term; Type: CONSTRAINT; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY valuetypecv
    ADD CONSTRAINT valuetypecv_term PRIMARY KEY (term);


--
-- Name: variablenamecv_term; Type: CONSTRAINT; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY variablenamecv
    ADD CONSTRAINT variablenamecv_term PRIMARY KEY (term);


--
-- Name: variables_variableid; Type: CONSTRAINT; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY variables
    ADD CONSTRAINT variables_variableid PRIMARY KEY (variableid);


--
-- Name: verticaldatumcv_term; Type: CONSTRAINT; Schema: tables; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY verticaldatumcv
    ADD CONSTRAINT verticaldatumcv_term PRIMARY KEY (term);


SET search_path = views, pg_catalog;

--
-- Name: annual_avgairtemp_pkey; Type: CONSTRAINT; Schema: views; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY annual_avgairtemp
    ADD CONSTRAINT annual_avgairtemp_pkey PRIMARY KEY (valueid);


--
-- Name: annual_avgdischarge_pkey; Type: CONSTRAINT; Schema: views; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY annual_avgdischarge
    ADD CONSTRAINT annual_avgdischarge_pkey PRIMARY KEY (valueid);


--
-- Name: annual_avgfallairtemp_pkey; Type: CONSTRAINT; Schema: views; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY annual_avgfallairtemp
    ADD CONSTRAINT annual_avgfallairtemp_pkey PRIMARY KEY (valueid);


--
-- Name: annual_avgfallprecip_pkey; Type: CONSTRAINT; Schema: views; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY annual_avgfallprecip
    ADD CONSTRAINT annual_avgfallprecip_pkey PRIMARY KEY (valueid);


--
-- Name: annual_avgrh_pkey; Type: CONSTRAINT; Schema: views; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY annual_avgrh
    ADD CONSTRAINT annual_avgrh_pkey PRIMARY KEY (valueid);


--
-- Name: annual_avgspringairtemp_pkey; Type: CONSTRAINT; Schema: views; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY annual_avgspringairtemp
    ADD CONSTRAINT annual_avgspringairtemp_pkey PRIMARY KEY (valueid);


--
-- Name: annual_avgspringprecip_pkey; Type: CONSTRAINT; Schema: views; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY annual_avgspringprecip
    ADD CONSTRAINT annual_avgspringprecip_pkey PRIMARY KEY (valueid);


--
-- Name: annual_avgsummerairtemp_pkey; Type: CONSTRAINT; Schema: views; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY annual_avgsummerairtemp
    ADD CONSTRAINT annual_avgsummerairtemp_pkey PRIMARY KEY (valueid);


--
-- Name: annual_avgsummerdischarge_pkey; Type: CONSTRAINT; Schema: views; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY annual_avgsummerdischarge
    ADD CONSTRAINT annual_avgsummerdischarge_pkey PRIMARY KEY (valueid);


--
-- Name: annual_avgsummerprecip_pkey; Type: CONSTRAINT; Schema: views; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY annual_avgsummerprecip
    ADD CONSTRAINT annual_avgsummerprecip_pkey PRIMARY KEY (valueid);


--
-- Name: annual_avgsummerrh_pkey; Type: CONSTRAINT; Schema: views; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY annual_avgsummerrh
    ADD CONSTRAINT annual_avgsummerrh_pkey PRIMARY KEY (valueid);


--
-- Name: annual_avgwinterairtemp_pkey; Type: CONSTRAINT; Schema: views; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY annual_avgwinterairtemp
    ADD CONSTRAINT annual_avgwinterairtemp_pkey PRIMARY KEY (valueid);


--
-- Name: annual_avgwinterprecip_pkey; Type: CONSTRAINT; Schema: views; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY annual_avgwinterprecip
    ADD CONSTRAINT annual_avgwinterprecip_pkey PRIMARY KEY (valueid);


--
-- Name: annual_avgwinterrh_pkey; Type: CONSTRAINT; Schema: views; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY annual_avgwinterrh
    ADD CONSTRAINT annual_avgwinterrh_pkey PRIMARY KEY (valueid);


--
-- Name: annual_peakdischarge_pkey; Type: CONSTRAINT; Schema: views; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY annual_peakdischarge
    ADD CONSTRAINT annual_peakdischarge_pkey PRIMARY KEY (valueid);


--
-- Name: annual_peaksnowdepth_pkey; Type: CONSTRAINT; Schema: views; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY annual_peaksnowdepth
    ADD CONSTRAINT annual_peaksnowdepth_pkey PRIMARY KEY (valueid);


--
-- Name: annual_peakswe_pkey; Type: CONSTRAINT; Schema: views; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY annual_peakswe
    ADD CONSTRAINT annual_peakswe_pkey PRIMARY KEY (valueid);


--
-- Name: annual_totalprecip_pkey; Type: CONSTRAINT; Schema: views; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY annual_totalprecip
    ADD CONSTRAINT annual_totalprecip_pkey PRIMARY KEY (valueid);


--
-- Name: daily_airtemp_pkey; Type: CONSTRAINT; Schema: views; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY daily_airtemp
    ADD CONSTRAINT daily_airtemp_pkey PRIMARY KEY (valueid);


--
-- Name: daily_airtempmax_pkey; Type: CONSTRAINT; Schema: views; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY daily_airtempmax
    ADD CONSTRAINT daily_airtempmax_pkey PRIMARY KEY (valueid);


--
-- Name: daily_airtempmin_pkey; Type: CONSTRAINT; Schema: views; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY daily_airtempmin
    ADD CONSTRAINT daily_airtempmin_pkey PRIMARY KEY (valueid);


--
-- Name: daily_discharge_pkey; Type: CONSTRAINT; Schema: views; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY daily_discharge
    ADD CONSTRAINT daily_discharge_pkey PRIMARY KEY (valueid);


--
-- Name: daily_rh_pkey; Type: CONSTRAINT; Schema: views; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY daily_rh
    ADD CONSTRAINT daily_rh_pkey PRIMARY KEY (valueid);


--
-- Name: daily_watertemp_pkey; Type: CONSTRAINT; Schema: views; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY daily_watertemp
    ADD CONSTRAINT daily_watertemp_pkey PRIMARY KEY (valueid);


--
-- Name: daily_winddirection_pkey; Type: CONSTRAINT; Schema: views; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY daily_winddirection
    ADD CONSTRAINT daily_winddirection_pkey PRIMARY KEY (valueid);


--
-- Name: daily_windspeed_pkey; Type: CONSTRAINT; Schema: views; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY daily_windspeed
    ADD CONSTRAINT daily_windspeed_pkey PRIMARY KEY (valueid);


--
-- Name: hourly_airtemp_pkey; Type: CONSTRAINT; Schema: views; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY hourly_airtemp
    ADD CONSTRAINT hourly_airtemp_pkey PRIMARY KEY (valueid);


--
-- Name: hourly_rh_pkey; Type: CONSTRAINT; Schema: views; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY hourly_rh
    ADD CONSTRAINT hourly_rh_pkey PRIMARY KEY (valueid);


--
-- Name: hourly_winddirection_pkey; Type: CONSTRAINT; Schema: views; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY hourly_winddirection
    ADD CONSTRAINT hourly_winddirection_pkey PRIMARY KEY (valueid);


--
-- Name: hourly_windspeed_pkey; Type: CONSTRAINT; Schema: views; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY hourly_windspeed
    ADD CONSTRAINT hourly_windspeed_pkey PRIMARY KEY (valueid);


--
-- Name: monthly_airtemp_pkey; Type: CONSTRAINT; Schema: views; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY monthly_airtemp
    ADD CONSTRAINT monthly_airtemp_pkey PRIMARY KEY (valueid);


--
-- Name: monthly_discharge_pkey; Type: CONSTRAINT; Schema: views; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY monthly_discharge
    ADD CONSTRAINT monthly_discharge_pkey PRIMARY KEY (valueid);


--
-- Name: monthly_precip_pkey; Type: CONSTRAINT; Schema: views; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY monthly_precip
    ADD CONSTRAINT monthly_precip_pkey PRIMARY KEY (valueid);


--
-- Name: monthly_rh_pkey; Type: CONSTRAINT; Schema: views; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY monthly_rh
    ADD CONSTRAINT monthly_rh_pkey PRIMARY KEY (valueid);


--
-- Name: monthly_snowdepthavg_pkey; Type: CONSTRAINT; Schema: views; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY monthly_snowdepthavg
    ADD CONSTRAINT monthly_snowdepthavg_pkey PRIMARY KEY (valueid);


--
-- Name: monthly_sweavg_pkey; Type: CONSTRAINT; Schema: views; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY monthly_sweavg
    ADD CONSTRAINT monthly_sweavg_pkey PRIMARY KEY (valueid);


--
-- Name: multiyear_annual_avgairtemp_pkey; Type: CONSTRAINT; Schema: views; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY multiyear_annual_avgairtemp
    ADD CONSTRAINT multiyear_annual_avgairtemp_pkey PRIMARY KEY (valueid);


--
-- Name: multiyear_annual_avgdischarge_pkey; Type: CONSTRAINT; Schema: views; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY multiyear_annual_avgdischarge
    ADD CONSTRAINT multiyear_annual_avgdischarge_pkey PRIMARY KEY (valueid);


--
-- Name: multiyear_annual_avgfallairtemp_pkey; Type: CONSTRAINT; Schema: views; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY multiyear_annual_avgfallairtemp
    ADD CONSTRAINT multiyear_annual_avgfallairtemp_pkey PRIMARY KEY (valueid);


--
-- Name: multiyear_annual_avgfallprecip_pkey; Type: CONSTRAINT; Schema: views; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY multiyear_annual_avgfallprecip
    ADD CONSTRAINT multiyear_annual_avgfallprecip_pkey PRIMARY KEY (valueid);


--
-- Name: multiyear_annual_avgpeakdischarge_pkey; Type: CONSTRAINT; Schema: views; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY multiyear_annual_avgpeakdischarge
    ADD CONSTRAINT multiyear_annual_avgpeakdischarge_pkey PRIMARY KEY (valueid);


--
-- Name: multiyear_annual_avgpeaksnowdepth_pkey; Type: CONSTRAINT; Schema: views; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY multiyear_annual_avgpeaksnowdepth
    ADD CONSTRAINT multiyear_annual_avgpeaksnowdepth_pkey PRIMARY KEY (valueid);


--
-- Name: multiyear_annual_avgpeakswe_pkey; Type: CONSTRAINT; Schema: views; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY multiyear_annual_avgpeakswe
    ADD CONSTRAINT multiyear_annual_avgpeakswe_pkey PRIMARY KEY (valueid);


--
-- Name: multiyear_annual_avgprecip_pkey; Type: CONSTRAINT; Schema: views; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY multiyear_annual_avgprecip
    ADD CONSTRAINT multiyear_annual_avgprecip_pkey PRIMARY KEY (valueid);


--
-- Name: multiyear_annual_avgrh_pkey; Type: CONSTRAINT; Schema: views; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY multiyear_annual_avgrh
    ADD CONSTRAINT multiyear_annual_avgrh_pkey PRIMARY KEY (valueid);


--
-- Name: multiyear_annual_avgspringairtemp_pkey; Type: CONSTRAINT; Schema: views; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY multiyear_annual_avgspringairtemp
    ADD CONSTRAINT multiyear_annual_avgspringairtemp_pkey PRIMARY KEY (valueid);


--
-- Name: multiyear_annual_avgspringprecip_pkey; Type: CONSTRAINT; Schema: views; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY multiyear_annual_avgspringprecip
    ADD CONSTRAINT multiyear_annual_avgspringprecip_pkey PRIMARY KEY (valueid);


--
-- Name: multiyear_annual_avgsummerairtemp_pkey; Type: CONSTRAINT; Schema: views; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY multiyear_annual_avgsummerairtemp
    ADD CONSTRAINT multiyear_annual_avgsummerairtemp_pkey PRIMARY KEY (valueid);


--
-- Name: multiyear_annual_avgsummerdischarge_pkey; Type: CONSTRAINT; Schema: views; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY multiyear_annual_avgsummerdischarge
    ADD CONSTRAINT multiyear_annual_avgsummerdischarge_pkey PRIMARY KEY (valueid);


--
-- Name: multiyear_annual_avgsummerprecip_pkey; Type: CONSTRAINT; Schema: views; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY multiyear_annual_avgsummerprecip
    ADD CONSTRAINT multiyear_annual_avgsummerprecip_pkey PRIMARY KEY (valueid);


--
-- Name: multiyear_annual_avgsummerrh_pkey; Type: CONSTRAINT; Schema: views; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY multiyear_annual_avgsummerrh
    ADD CONSTRAINT multiyear_annual_avgsummerrh_pkey PRIMARY KEY (valueid);


--
-- Name: multiyear_annual_avgwinterairtemp_pkey; Type: CONSTRAINT; Schema: views; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY multiyear_annual_avgwinterairtemp
    ADD CONSTRAINT multiyear_annual_avgwinterairtemp_pkey PRIMARY KEY (valueid);


--
-- Name: multiyear_annual_avgwinterprecip_pkey; Type: CONSTRAINT; Schema: views; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY multiyear_annual_avgwinterprecip
    ADD CONSTRAINT multiyear_annual_avgwinterprecip_pkey PRIMARY KEY (valueid);


--
-- Name: multiyear_annual_avgwinterrh_pkey; Type: CONSTRAINT; Schema: views; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY multiyear_annual_avgwinterrh
    ADD CONSTRAINT multiyear_annual_avgwinterrh_pkey PRIMARY KEY (valueid);


--
-- Name: odmdatavalues_metric_pkey; Type: CONSTRAINT; Schema: views; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY odmdatavalues_metric
    ADD CONSTRAINT odmdatavalues_metric_pkey PRIMARY KEY (valueid);


--
-- Name: odmdatavalues_pkey; Type: CONSTRAINT; Schema: views; Owner: imiq; Tablespace: 
--

ALTER TABLE ONLY odmdatavalues
    ADD CONSTRAINT odmdatavalues_pkey PRIMARY KEY (valueid);


SET search_path = tables, pg_catalog;

--
-- Name: annual_avgrh_all_siteid_idx; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE INDEX annual_avgrh_all_siteid_idx ON annual_avgrh_all USING btree (siteid);


--
-- Name: annual_avgwinterairtemp_all_siteid_idx; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE INDEX annual_avgwinterairtemp_all_siteid_idx ON annual_avgwinterairtemp_all USING btree (siteid);


--
-- Name: annual_avgwinterprecip_all_siteid_idx; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE INDEX annual_avgwinterprecip_all_siteid_idx ON annual_avgwinterprecip_all USING btree (siteid);


--
-- Name: annual_avgwinterrh_all_siteid_idx; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE INDEX annual_avgwinterrh_all_siteid_idx ON annual_avgwinterrh_all USING btree (siteid);


--
-- Name: annual_peakdischarge_all_siteid_idx; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE INDEX annual_peakdischarge_all_siteid_idx ON annual_peakdischarge_all USING btree (siteid);


--
-- Name: annual_peaksnowdepth_all_siteid_idx; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE INDEX annual_peaksnowdepth_all_siteid_idx ON annual_peaksnowdepth_all USING btree (siteid);


--
-- Name: annual_peakswe_all_siteid_idx; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE INDEX annual_peakswe_all_siteid_idx ON annual_peakswe_all USING btree (siteid);


--
-- Name: annual_totalprecip_all_siteid_idx; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE INDEX annual_totalprecip_all_siteid_idx ON annual_totalprecip_all USING btree (siteid);


--
-- Name: daily_airtempdatavalues_siteid_idx; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE INDEX daily_airtempdatavalues_siteid_idx ON daily_airtempdatavalues USING btree (siteid);


--
-- Name: daily_airtempmaxdatavalues_siteid_idx; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE INDEX daily_airtempmaxdatavalues_siteid_idx ON daily_airtempmaxdatavalues USING btree (siteid);


--
-- Name: daily_airtempmindatavalues_siteid_idx; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE INDEX daily_airtempmindatavalues_siteid_idx ON daily_airtempmindatavalues USING btree (siteid);


--
-- Name: daily_dischargedatavalues_siteid_idx; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE INDEX daily_dischargedatavalues_siteid_idx ON daily_dischargedatavalues USING btree (siteid);


--
-- Name: daily_precip_siteid_idx; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE INDEX daily_precip_siteid_idx ON daily_precip USING btree (siteid);


--
-- Name: daily_precip_thresholds_siteid_idx; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE INDEX daily_precip_thresholds_siteid_idx ON daily_precip_thresholds USING btree (siteid);


--
-- Name: daily_precipdatavalues_siteid_idx; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE INDEX daily_precipdatavalues_siteid_idx ON daily_precipdatavalues USING btree (siteid);


--
-- Name: daily_rhdatavalues_siteid_idx; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE INDEX daily_rhdatavalues_siteid_idx ON daily_rhdatavalues USING btree (siteid);


--
-- Name: daily_snowdepth_siteid_idx; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE INDEX daily_snowdepth_siteid_idx ON daily_snowdepth USING btree (siteid);


--
-- Name: daily_snowdepthdatavalues_siteid_idx; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE INDEX daily_snowdepthdatavalues_siteid_idx ON daily_snowdepthdatavalues USING btree (siteid);


--
-- Name: daily_swe_siteid_idx; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE INDEX daily_swe_siteid_idx ON daily_swe USING btree (siteid);


--
-- Name: daily_swedatavalues_siteid_idx; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE INDEX daily_swedatavalues_siteid_idx ON daily_swedatavalues USING btree (siteid);


--
-- Name: daily_watertempdatavalues_siteid_idx; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE INDEX daily_watertempdatavalues_siteid_idx ON daily_watertempdatavalues USING btree (siteid);


--
-- Name: daily_winddirectiondatavalues_siteid_idx; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE INDEX daily_winddirectiondatavalues_siteid_idx ON daily_winddirectiondatavalues USING btree (siteid);


--
-- Name: daily_windspeeddatavalues_siteid_idx; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE INDEX daily_windspeeddatavalues_siteid_idx ON daily_windspeeddatavalues USING btree (siteid);


--
-- Name: datastreams_siteid_idx; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE INDEX datastreams_siteid_idx ON datastreams USING btree (siteid);


--
-- Name: datavaluesraw_datastreamid; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE UNIQUE INDEX datavaluesraw_datastreamid ON datavaluesraw USING btree (datastreamid);


--
-- Name: datavaluesraw_localdatetime; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE UNIQUE INDEX datavaluesraw_localdatetime ON datavaluesraw USING btree (localdatetime);


--
-- Name: hourly_airtempdatavalues_siteid_idx; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE INDEX hourly_airtempdatavalues_siteid_idx ON hourly_airtempdatavalues USING btree (siteid);


--
-- Name: hourly_precip_siteid_idx; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE INDEX hourly_precip_siteid_idx ON hourly_precip USING btree (siteid);


--
-- Name: hourly_precipdatavalues_siteid_idx; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE INDEX hourly_precipdatavalues_siteid_idx ON hourly_precipdatavalues USING btree (siteid);


--
-- Name: hourly_rhdatavalues_siteid_idx; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE INDEX hourly_rhdatavalues_siteid_idx ON hourly_rhdatavalues USING btree (siteid);


--
-- Name: hourly_snowdepth_siteid_idx; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE INDEX hourly_snowdepth_siteid_idx ON hourly_snowdepth USING btree (siteid);


--
-- Name: hourly_snowdepthdatavalues_siteid_idx; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE INDEX hourly_snowdepthdatavalues_siteid_idx ON hourly_snowdepthdatavalues USING btree (siteid);


--
-- Name: hourly_swe_siteid_idx; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE INDEX hourly_swe_siteid_idx ON hourly_swe USING btree (siteid);


--
-- Name: hourly_swedatavalues_siteid_idx; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE INDEX hourly_swedatavalues_siteid_idx ON hourly_swedatavalues USING btree (siteid);


--
-- Name: hourly_winddirectiondatavalues_siteid_idx; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE INDEX hourly_winddirectiondatavalues_siteid_idx ON hourly_winddirectiondatavalues USING btree (siteid);


--
-- Name: hourly_windspeeddatavalues_siteid_idx; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE INDEX hourly_windspeeddatavalues_siteid_idx ON hourly_windspeeddatavalues USING btree (siteid);


--
-- Name: methods_methodname; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE UNIQUE INDEX methods_methodname ON methods USING btree (methodname);


--
-- Name: monthly_rh_all_siteid_idx; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE INDEX monthly_rh_all_siteid_idx ON monthly_rh_all USING btree (siteid);


--
-- Name: multiyear_annual_all_avgairtemp_siteid_idx; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE INDEX multiyear_annual_all_avgairtemp_siteid_idx ON multiyear_annual_all_avgairtemp USING btree (siteid);


--
-- Name: multiyear_annual_all_avgdischarge_siteid_idx; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE INDEX multiyear_annual_all_avgdischarge_siteid_idx ON multiyear_annual_all_avgdischarge USING btree (siteid);


--
-- Name: multiyear_annual_all_avgfallairtemp_siteid_idx; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE INDEX multiyear_annual_all_avgfallairtemp_siteid_idx ON multiyear_annual_all_avgfallairtemp USING btree (siteid);


--
-- Name: multiyear_annual_all_avgfallprecip_siteid_idx; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE INDEX multiyear_annual_all_avgfallprecip_siteid_idx ON multiyear_annual_all_avgfallprecip USING btree (siteid);


--
-- Name: multiyear_annual_all_avgpeakdischarge_siteid_idx; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE INDEX multiyear_annual_all_avgpeakdischarge_siteid_idx ON multiyear_annual_all_avgpeakdischarge USING btree (siteid);


--
-- Name: multiyear_annual_all_avgpeaksnowdepth_siteid_idx; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE INDEX multiyear_annual_all_avgpeaksnowdepth_siteid_idx ON multiyear_annual_all_avgpeaksnowdepth USING btree (siteid);


--
-- Name: multiyear_annual_all_avgpeakswe_siteid_idx; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE INDEX multiyear_annual_all_avgpeakswe_siteid_idx ON multiyear_annual_all_avgpeakswe USING btree (siteid);


--
-- Name: multiyear_annual_all_avgprecip_siteid_idx; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE INDEX multiyear_annual_all_avgprecip_siteid_idx ON multiyear_annual_all_avgprecip USING btree (siteid);


--
-- Name: multiyear_annual_all_avgrh_siteid_idx; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE INDEX multiyear_annual_all_avgrh_siteid_idx ON multiyear_annual_all_avgrh USING btree (siteid);


--
-- Name: multiyear_annual_all_avgspringairtemp_siteid_idx; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE INDEX multiyear_annual_all_avgspringairtemp_siteid_idx ON multiyear_annual_all_avgspringairtemp USING btree (siteid);


--
-- Name: multiyear_annual_all_avgspringprecip_siteid_idx; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE INDEX multiyear_annual_all_avgspringprecip_siteid_idx ON multiyear_annual_all_avgspringprecip USING btree (siteid);


--
-- Name: multiyear_annual_all_avgsummerairtemp_siteid_idx; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE INDEX multiyear_annual_all_avgsummerairtemp_siteid_idx ON multiyear_annual_all_avgsummerairtemp USING btree (siteid);


--
-- Name: multiyear_annual_all_avgsummerdischarge_siteid_idx; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE INDEX multiyear_annual_all_avgsummerdischarge_siteid_idx ON multiyear_annual_all_avgsummerdischarge USING btree (siteid);


--
-- Name: multiyear_annual_all_avgsummerprecip_siteid_idx; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE INDEX multiyear_annual_all_avgsummerprecip_siteid_idx ON multiyear_annual_all_avgsummerprecip USING btree (siteid);


--
-- Name: multiyear_annual_all_avgsummerrh_siteid_idx; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE INDEX multiyear_annual_all_avgsummerrh_siteid_idx ON multiyear_annual_all_avgsummerrh USING btree (siteid);


--
-- Name: multiyear_annual_all_avgwinterairtemp_siteid_idx; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE INDEX multiyear_annual_all_avgwinterairtemp_siteid_idx ON multiyear_annual_all_avgwinterairtemp USING btree (siteid);


--
-- Name: multiyear_annual_all_avgwinterprecip_siteid_idx; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE INDEX multiyear_annual_all_avgwinterprecip_siteid_idx ON multiyear_annual_all_avgwinterprecip USING btree (siteid);


--
-- Name: multiyear_annual_all_avgwinterrh_siteid_idx; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE INDEX multiyear_annual_all_avgwinterrh_siteid_idx ON multiyear_annual_all_avgwinterrh USING btree (siteid);


--
-- Name: sysdiagrams_name; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE UNIQUE INDEX sysdiagrams_name ON sysdiagrams USING btree (name);


--
-- Name: sysdiagrams_principal_id; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE UNIQUE INDEX sysdiagrams_principal_id ON sysdiagrams USING btree (principal_id);


--
-- Name: variables_variablecode; Type: INDEX; Schema: tables; Owner: imiq; Tablespace: 
--

CREATE UNIQUE INDEX variables_variablecode ON variables USING btree (variablecode);


SET search_path = views, pg_catalog;

--
-- Name: annual_avgairtemp_siteid_idx; Type: INDEX; Schema: views; Owner: imiq; Tablespace: 
--

CREATE INDEX annual_avgairtemp_siteid_idx ON annual_avgairtemp USING btree (siteid);


--
-- Name: annual_avgdischarge_siteid_idx; Type: INDEX; Schema: views; Owner: imiq; Tablespace: 
--

CREATE INDEX annual_avgdischarge_siteid_idx ON annual_avgdischarge USING btree (siteid);


--
-- Name: annual_avgfallairtemp_all_siteid_idx; Type: INDEX; Schema: views; Owner: imiq; Tablespace: 
--

CREATE INDEX annual_avgfallairtemp_all_siteid_idx ON annual_avgfallairtemp_all USING btree (siteid);


--
-- Name: annual_avgfallairtemp_siteid_idx; Type: INDEX; Schema: views; Owner: imiq; Tablespace: 
--

CREATE INDEX annual_avgfallairtemp_siteid_idx ON annual_avgfallairtemp USING btree (siteid);


--
-- Name: annual_avgfallprecip_all_siteid_idx; Type: INDEX; Schema: views; Owner: imiq; Tablespace: 
--

CREATE INDEX annual_avgfallprecip_all_siteid_idx ON annual_avgfallprecip_all USING btree (siteid);


--
-- Name: annual_avgfallprecip_siteid_idx; Type: INDEX; Schema: views; Owner: imiq; Tablespace: 
--

CREATE INDEX annual_avgfallprecip_siteid_idx ON annual_avgfallprecip USING btree (siteid);


--
-- Name: annual_avgrh_siteid_idx; Type: INDEX; Schema: views; Owner: imiq; Tablespace: 
--

CREATE INDEX annual_avgrh_siteid_idx ON annual_avgrh USING btree (siteid);


--
-- Name: annual_avgspringairtemp_all_siteid_idx; Type: INDEX; Schema: views; Owner: imiq; Tablespace: 
--

CREATE INDEX annual_avgspringairtemp_all_siteid_idx ON annual_avgspringairtemp_all USING btree (siteid);


--
-- Name: annual_avgspringairtemp_siteid_idx; Type: INDEX; Schema: views; Owner: imiq; Tablespace: 
--

CREATE INDEX annual_avgspringairtemp_siteid_idx ON annual_avgspringairtemp USING btree (siteid);


--
-- Name: annual_avgspringprecip_all_siteid_idx; Type: INDEX; Schema: views; Owner: imiq; Tablespace: 
--

CREATE INDEX annual_avgspringprecip_all_siteid_idx ON annual_avgspringprecip_all USING btree (siteid);


--
-- Name: annual_avgspringprecip_siteid_idx; Type: INDEX; Schema: views; Owner: imiq; Tablespace: 
--

CREATE INDEX annual_avgspringprecip_siteid_idx ON annual_avgspringprecip USING btree (siteid);


--
-- Name: annual_avgsummerairtemp_all_siteid_idx; Type: INDEX; Schema: views; Owner: imiq; Tablespace: 
--

CREATE INDEX annual_avgsummerairtemp_all_siteid_idx ON annual_avgsummerairtemp_all USING btree (siteid);


--
-- Name: annual_avgsummerairtemp_siteid_idx; Type: INDEX; Schema: views; Owner: imiq; Tablespace: 
--

CREATE INDEX annual_avgsummerairtemp_siteid_idx ON annual_avgsummerairtemp USING btree (siteid);


--
-- Name: annual_avgsummerdischarge_all_siteid_idx; Type: INDEX; Schema: views; Owner: imiq; Tablespace: 
--

CREATE INDEX annual_avgsummerdischarge_all_siteid_idx ON annual_avgsummerdischarge_all USING btree (siteid);


--
-- Name: annual_avgsummerdischarge_siteid_idx; Type: INDEX; Schema: views; Owner: imiq; Tablespace: 
--

CREATE INDEX annual_avgsummerdischarge_siteid_idx ON annual_avgsummerdischarge USING btree (siteid);


--
-- Name: annual_avgsummerprecip_all_siteid_idx; Type: INDEX; Schema: views; Owner: imiq; Tablespace: 
--

CREATE INDEX annual_avgsummerprecip_all_siteid_idx ON annual_avgsummerprecip_all USING btree (siteid);


--
-- Name: annual_avgsummerprecip_siteid_idx; Type: INDEX; Schema: views; Owner: imiq; Tablespace: 
--

CREATE INDEX annual_avgsummerprecip_siteid_idx ON annual_avgsummerprecip USING btree (siteid);


--
-- Name: annual_avgsummerrh_all_siteid_idx; Type: INDEX; Schema: views; Owner: imiq; Tablespace: 
--

CREATE INDEX annual_avgsummerrh_all_siteid_idx ON annual_avgsummerrh_all USING btree (siteid);


--
-- Name: annual_avgsummerrh_siteid_idx; Type: INDEX; Schema: views; Owner: imiq; Tablespace: 
--

CREATE INDEX annual_avgsummerrh_siteid_idx ON annual_avgsummerrh USING btree (siteid);


--
-- Name: annual_avgwinterairtemp_siteid_idx; Type: INDEX; Schema: views; Owner: imiq; Tablespace: 
--

CREATE INDEX annual_avgwinterairtemp_siteid_idx ON annual_avgwinterairtemp USING btree (siteid);


--
-- Name: annual_avgwinterprecip_siteid_idx; Type: INDEX; Schema: views; Owner: imiq; Tablespace: 
--

CREATE INDEX annual_avgwinterprecip_siteid_idx ON annual_avgwinterprecip USING btree (siteid);


--
-- Name: annual_avgwinterrh_siteid_idx; Type: INDEX; Schema: views; Owner: imiq; Tablespace: 
--

CREATE INDEX annual_avgwinterrh_siteid_idx ON annual_avgwinterrh USING btree (siteid);


--
-- Name: annual_peakdischarge_siteid_idx; Type: INDEX; Schema: views; Owner: imiq; Tablespace: 
--

CREATE INDEX annual_peakdischarge_siteid_idx ON annual_peakdischarge USING btree (siteid);


--
-- Name: annual_peaksnowdepth_siteid_idx; Type: INDEX; Schema: views; Owner: imiq; Tablespace: 
--

CREATE INDEX annual_peaksnowdepth_siteid_idx ON annual_peaksnowdepth USING btree (siteid);


--
-- Name: annual_peakswe_siteid_idx; Type: INDEX; Schema: views; Owner: imiq; Tablespace: 
--

CREATE INDEX annual_peakswe_siteid_idx ON annual_peakswe USING btree (siteid);


--
-- Name: annual_totalprecip_siteid_idx; Type: INDEX; Schema: views; Owner: imiq; Tablespace: 
--

CREATE INDEX annual_totalprecip_siteid_idx ON annual_totalprecip USING btree (siteid);


--
-- Name: daily_airtemp_siteid_idx; Type: INDEX; Schema: views; Owner: imiq; Tablespace: 
--

CREATE INDEX daily_airtemp_siteid_idx ON daily_airtemp USING btree (siteid);


--
-- Name: daily_airtempmax_siteid_idx; Type: INDEX; Schema: views; Owner: imiq; Tablespace: 
--

CREATE INDEX daily_airtempmax_siteid_idx ON daily_airtempmax USING btree (siteid);


--
-- Name: daily_airtempmin_siteid_idx; Type: INDEX; Schema: views; Owner: imiq; Tablespace: 
--

CREATE INDEX daily_airtempmin_siteid_idx ON daily_airtempmin USING btree (siteid);


--
-- Name: daily_discharge_siteid_idx; Type: INDEX; Schema: views; Owner: imiq; Tablespace: 
--

CREATE INDEX daily_discharge_siteid_idx ON daily_discharge USING btree (siteid);


--
-- Name: daily_rh_siteid_idx; Type: INDEX; Schema: views; Owner: imiq; Tablespace: 
--

CREATE INDEX daily_rh_siteid_idx ON daily_rh USING btree (siteid);


--
-- Name: daily_utcdatetime_siteid_idx; Type: INDEX; Schema: views; Owner: imiq; Tablespace: 
--

CREATE INDEX daily_utcdatetime_siteid_idx ON daily_utcdatetime USING btree (siteid);


--
-- Name: daily_watertemp_siteid_idx; Type: INDEX; Schema: views; Owner: imiq; Tablespace: 
--

CREATE INDEX daily_watertemp_siteid_idx ON daily_watertemp USING btree (siteid);


--
-- Name: daily_winddirection_siteid_idx; Type: INDEX; Schema: views; Owner: imiq; Tablespace: 
--

CREATE INDEX daily_winddirection_siteid_idx ON daily_winddirection USING btree (siteid);


--
-- Name: daily_windspeed_siteid_idx; Type: INDEX; Schema: views; Owner: imiq; Tablespace: 
--

CREATE INDEX daily_windspeed_siteid_idx ON daily_windspeed USING btree (siteid);


--
-- Name: hourly_airtemp_siteid_idx; Type: INDEX; Schema: views; Owner: imiq; Tablespace: 
--

CREATE INDEX hourly_airtemp_siteid_idx ON hourly_airtemp USING btree (siteid);


--
-- Name: hourly_rh_siteid_idx; Type: INDEX; Schema: views; Owner: imiq; Tablespace: 
--

CREATE INDEX hourly_rh_siteid_idx ON hourly_rh USING btree (siteid);


--
-- Name: hourly_utcdatetime_siteid_idx; Type: INDEX; Schema: views; Owner: imiq; Tablespace: 
--

CREATE INDEX hourly_utcdatetime_siteid_idx ON hourly_utcdatetime USING btree (siteid);


--
-- Name: hourly_winddirection_siteid_idx; Type: INDEX; Schema: views; Owner: imiq; Tablespace: 
--

CREATE INDEX hourly_winddirection_siteid_idx ON hourly_winddirection USING btree (siteid);


--
-- Name: hourly_windspeed_siteid_idx; Type: INDEX; Schema: views; Owner: imiq; Tablespace: 
--

CREATE INDEX hourly_windspeed_siteid_idx ON hourly_windspeed USING btree (siteid);


--
-- Name: monthly_airtemp_all_siteid_idx; Type: INDEX; Schema: views; Owner: imiq; Tablespace: 
--

CREATE INDEX monthly_airtemp_all_siteid_idx ON monthly_airtemp_all USING btree (siteid);


--
-- Name: monthly_airtemp_siteid_idx; Type: INDEX; Schema: views; Owner: imiq; Tablespace: 
--

CREATE INDEX monthly_airtemp_siteid_idx ON monthly_airtemp USING btree (siteid);


--
-- Name: monthly_discharge_all_siteid_idx; Type: INDEX; Schema: views; Owner: imiq; Tablespace: 
--

CREATE INDEX monthly_discharge_all_siteid_idx ON monthly_discharge_all USING btree (siteid);


--
-- Name: monthly_discharge_siteid_idx; Type: INDEX; Schema: views; Owner: imiq; Tablespace: 
--

CREATE INDEX monthly_discharge_siteid_idx ON monthly_discharge USING btree (siteid);


--
-- Name: monthly_precip_all_siteid_idx; Type: INDEX; Schema: views; Owner: imiq; Tablespace: 
--

CREATE INDEX monthly_precip_all_siteid_idx ON monthly_precip_all USING btree (siteid);


--
-- Name: monthly_precip_siteid_idx; Type: INDEX; Schema: views; Owner: imiq; Tablespace: 
--

CREATE INDEX monthly_precip_siteid_idx ON monthly_precip USING btree (siteid);


--
-- Name: monthly_rh_siteid_idx; Type: INDEX; Schema: views; Owner: imiq; Tablespace: 
--

CREATE INDEX monthly_rh_siteid_idx ON monthly_rh USING btree (siteid);


--
-- Name: monthly_snowdepthavg_all_siteid_idx; Type: INDEX; Schema: views; Owner: imiq; Tablespace: 
--

CREATE INDEX monthly_snowdepthavg_all_siteid_idx ON monthly_snowdepthavg_all USING btree (siteid);


--
-- Name: monthly_snowdepthavg_siteid_idx; Type: INDEX; Schema: views; Owner: imiq; Tablespace: 
--

CREATE INDEX monthly_snowdepthavg_siteid_idx ON monthly_snowdepthavg USING btree (siteid);


--
-- Name: monthly_sweavg_all_siteid_idx; Type: INDEX; Schema: views; Owner: imiq; Tablespace: 
--

CREATE INDEX monthly_sweavg_all_siteid_idx ON monthly_sweavg_all USING btree (siteid);


--
-- Name: monthly_sweavg_siteid_idx; Type: INDEX; Schema: views; Owner: imiq; Tablespace: 
--

CREATE INDEX monthly_sweavg_siteid_idx ON monthly_sweavg USING btree (siteid);


--
-- Name: multiyear_annual_avgairtemp_siteid_idx; Type: INDEX; Schema: views; Owner: imiq; Tablespace: 
--

CREATE INDEX multiyear_annual_avgairtemp_siteid_idx ON multiyear_annual_avgairtemp USING btree (siteid);


--
-- Name: multiyear_annual_avgdischarge_siteid_idx; Type: INDEX; Schema: views; Owner: imiq; Tablespace: 
--

CREATE INDEX multiyear_annual_avgdischarge_siteid_idx ON multiyear_annual_avgdischarge USING btree (siteid);


--
-- Name: multiyear_annual_avgfallairtemp_siteid_idx; Type: INDEX; Schema: views; Owner: imiq; Tablespace: 
--

CREATE INDEX multiyear_annual_avgfallairtemp_siteid_idx ON multiyear_annual_avgfallairtemp USING btree (siteid);


--
-- Name: multiyear_annual_avgfallprecip_siteid_idx; Type: INDEX; Schema: views; Owner: imiq; Tablespace: 
--

CREATE INDEX multiyear_annual_avgfallprecip_siteid_idx ON multiyear_annual_avgfallprecip USING btree (siteid);


--
-- Name: multiyear_annual_avgpeakdischarge_siteid_idx; Type: INDEX; Schema: views; Owner: imiq; Tablespace: 
--

CREATE INDEX multiyear_annual_avgpeakdischarge_siteid_idx ON multiyear_annual_avgpeakdischarge USING btree (siteid);


--
-- Name: multiyear_annual_avgpeaksnowdepth_siteid_idx; Type: INDEX; Schema: views; Owner: imiq; Tablespace: 
--

CREATE INDEX multiyear_annual_avgpeaksnowdepth_siteid_idx ON multiyear_annual_avgpeaksnowdepth USING btree (siteid);


--
-- Name: multiyear_annual_avgpeakswe_siteid_idx; Type: INDEX; Schema: views; Owner: imiq; Tablespace: 
--

CREATE INDEX multiyear_annual_avgpeakswe_siteid_idx ON multiyear_annual_avgpeakswe USING btree (siteid);


--
-- Name: multiyear_annual_avgprecip_siteid_idx; Type: INDEX; Schema: views; Owner: imiq; Tablespace: 
--

CREATE INDEX multiyear_annual_avgprecip_siteid_idx ON multiyear_annual_avgprecip USING btree (siteid);


--
-- Name: multiyear_annual_avgrh_siteid_idx; Type: INDEX; Schema: views; Owner: imiq; Tablespace: 
--

CREATE INDEX multiyear_annual_avgrh_siteid_idx ON multiyear_annual_avgrh USING btree (siteid);


--
-- Name: multiyear_annual_avgspringairtemp_siteid_idx; Type: INDEX; Schema: views; Owner: imiq; Tablespace: 
--

CREATE INDEX multiyear_annual_avgspringairtemp_siteid_idx ON multiyear_annual_avgspringairtemp USING btree (siteid);


--
-- Name: multiyear_annual_avgspringprecip_siteid_idx; Type: INDEX; Schema: views; Owner: imiq; Tablespace: 
--

CREATE INDEX multiyear_annual_avgspringprecip_siteid_idx ON multiyear_annual_avgspringprecip USING btree (siteid);


--
-- Name: multiyear_annual_avgsummerairtemp_siteid_idx; Type: INDEX; Schema: views; Owner: imiq; Tablespace: 
--

CREATE INDEX multiyear_annual_avgsummerairtemp_siteid_idx ON multiyear_annual_avgsummerairtemp USING btree (siteid);


--
-- Name: multiyear_annual_avgsummerdischarge_siteid_idx; Type: INDEX; Schema: views; Owner: imiq; Tablespace: 
--

CREATE INDEX multiyear_annual_avgsummerdischarge_siteid_idx ON multiyear_annual_avgsummerdischarge USING btree (siteid);


--
-- Name: multiyear_annual_avgsummerprecip_siteid_idx; Type: INDEX; Schema: views; Owner: imiq; Tablespace: 
--

CREATE INDEX multiyear_annual_avgsummerprecip_siteid_idx ON multiyear_annual_avgsummerprecip USING btree (siteid);


--
-- Name: multiyear_annual_avgsummerrh_siteid_idx; Type: INDEX; Schema: views; Owner: imiq; Tablespace: 
--

CREATE INDEX multiyear_annual_avgsummerrh_siteid_idx ON multiyear_annual_avgsummerrh USING btree (siteid);


--
-- Name: multiyear_annual_avgwinterairtemp_siteid_idx; Type: INDEX; Schema: views; Owner: imiq; Tablespace: 
--

CREATE INDEX multiyear_annual_avgwinterairtemp_siteid_idx ON multiyear_annual_avgwinterairtemp USING btree (siteid);


--
-- Name: multiyear_annual_avgwinterprecip_siteid_idx; Type: INDEX; Schema: views; Owner: imiq; Tablespace: 
--

CREATE INDEX multiyear_annual_avgwinterprecip_siteid_idx ON multiyear_annual_avgwinterprecip USING btree (siteid);


--
-- Name: multiyear_annual_avgwinterrh_siteid_idx; Type: INDEX; Schema: views; Owner: imiq; Tablespace: 
--

CREATE INDEX multiyear_annual_avgwinterrh_siteid_idx ON multiyear_annual_avgwinterrh USING btree (siteid);


--
-- Name: odmdatavalues_metric_siteid_idx; Type: INDEX; Schema: views; Owner: imiq; Tablespace: 
--

CREATE INDEX odmdatavalues_metric_siteid_idx ON odmdatavalues_metric USING btree (siteid);


--
-- Name: odmdatavalues_siteid_idx; Type: INDEX; Schema: views; Owner: imiq; Tablespace: 
--

CREATE INDEX odmdatavalues_siteid_idx ON odmdatavalues USING btree (siteid);


SET search_path = tables, pg_catalog;

--
-- Name: fk_datavalues_categoryid; Type: FK CONSTRAINT; Schema: tables; Owner: imiq
--

ALTER TABLE ONLY datavalues
    ADD CONSTRAINT fk_datavalues_categoryid FOREIGN KEY (categoryid) REFERENCES categories(categoryid);


--
-- Name: fk_datavalues_censorcodecv; Type: FK CONSTRAINT; Schema: tables; Owner: imiq
--

ALTER TABLE ONLY datavalues
    ADD CONSTRAINT fk_datavalues_censorcodecv FOREIGN KEY (censorcode) REFERENCES censorcodecv(term);


--
-- Name: fk_datavalues_datastreamid; Type: FK CONSTRAINT; Schema: tables; Owner: imiq
--

ALTER TABLE ONLY datavalues
    ADD CONSTRAINT fk_datavalues_datastreamid FOREIGN KEY (datastreamid) REFERENCES datastreams(datastreamid);


--
-- Name: fk_derivedfrom_datavaluesraw; Type: FK CONSTRAINT; Schema: tables; Owner: imiq
--

ALTER TABLE ONLY derivedfrom
    ADD CONSTRAINT fk_derivedfrom_datavaluesraw FOREIGN KEY (valueid) REFERENCES datavaluesraw(valueid);


--
-- Name: fk_groups_groupdescriptions; Type: FK CONSTRAINT; Schema: tables; Owner: imiq
--

ALTER TABLE ONLY groups
    ADD CONSTRAINT fk_groups_groupdescriptions FOREIGN KEY (groupid) REFERENCES groupdescriptions(groupid);


--
-- Name: fk_incidents_datastreams; Type: FK CONSTRAINT; Schema: tables; Owner: imiq
--

ALTER TABLE ONLY incidents
    ADD CONSTRAINT fk_incidents_datastreams FOREIGN KEY (datastreamid) REFERENCES datastreams(datastreamid);


--
-- Name: fk_organizations_organizationid; Type: FK CONSTRAINT; Schema: tables; Owner: imiq
--

ALTER TABLE ONLY organizations
    ADD CONSTRAINT fk_organizations_organizationid FOREIGN KEY (organizationid) REFERENCES organizationdescriptions(organizationid);


--
-- Name: fk_rasterdatavalues_qualifierid; Type: FK CONSTRAINT; Schema: tables; Owner: imiq
--

ALTER TABLE ONLY rasterdatavalues
    ADD CONSTRAINT fk_rasterdatavalues_qualifierid FOREIGN KEY (qualifierid) REFERENCES qualifiers(qualifierid);


--
-- Name: fk_siteattributes_attributeid; Type: FK CONSTRAINT; Schema: tables; Owner: imiq
--

ALTER TABLE ONLY siteattributes
    ADD CONSTRAINT fk_siteattributes_attributeid FOREIGN KEY (attributeid) REFERENCES attributes(attributeid);


--
-- Name: fk_sites_latlongdatumid; Type: FK CONSTRAINT; Schema: tables; Owner: imiq
--

ALTER TABLE ONLY sites
    ADD CONSTRAINT fk_sites_latlongdatumid FOREIGN KEY (latlongdatumid) REFERENCES spatialreferences(spatialreferenceid);


--
-- Name: fk_sites_localprojectionid; Type: FK CONSTRAINT; Schema: tables; Owner: imiq
--

ALTER TABLE ONLY sites
    ADD CONSTRAINT fk_sites_localprojectionid FOREIGN KEY (localprojectionid) REFERENCES spatialreferences(spatialreferenceid);


--
-- Name: fk_sites_sourceid; Type: FK CONSTRAINT; Schema: tables; Owner: imiq
--

ALTER TABLE ONLY sites
    ADD CONSTRAINT fk_sites_sourceid FOREIGN KEY (sourceid) REFERENCES sources(sourceid);


--
-- Name: fk_sites_verticaldatumcv; Type: FK CONSTRAINT; Schema: tables; Owner: imiq
--

ALTER TABLE ONLY sites
    ADD CONSTRAINT fk_sites_verticaldatumcv FOREIGN KEY (verticaldatum) REFERENCES verticaldatumcv(term);


--
-- Name: fk_variables_datatypecv; Type: FK CONSTRAINT; Schema: tables; Owner: imiq
--

ALTER TABLE ONLY variables
    ADD CONSTRAINT fk_variables_datatypecv FOREIGN KEY (datatype) REFERENCES datatypecv(term);


--
-- Name: fk_variables_samplemediumcv; Type: FK CONSTRAINT; Schema: tables; Owner: imiq
--

ALTER TABLE ONLY variables
    ADD CONSTRAINT fk_variables_samplemediumcv FOREIGN KEY (samplemedium) REFERENCES samplemediumcv(term);


--
-- Name: fk_variables_speciationcv; Type: FK CONSTRAINT; Schema: tables; Owner: imiq
--

ALTER TABLE ONLY variables
    ADD CONSTRAINT fk_variables_speciationcv FOREIGN KEY (speciation) REFERENCES speciationcv(term);


--
-- Name: fk_variables_timeunitsid; Type: FK CONSTRAINT; Schema: tables; Owner: imiq
--

ALTER TABLE ONLY variables
    ADD CONSTRAINT fk_variables_timeunitsid FOREIGN KEY (timeunitsid) REFERENCES units(unitsid);


--
-- Name: fk_variables_valuetypecv; Type: FK CONSTRAINT; Schema: tables; Owner: imiq
--

ALTER TABLE ONLY variables
    ADD CONSTRAINT fk_variables_valuetypecv FOREIGN KEY (valuetype) REFERENCES valuetypecv(term);


--
-- Name: fk_variables_variablenamecv; Type: FK CONSTRAINT; Schema: tables; Owner: imiq
--

ALTER TABLE ONLY variables
    ADD CONSTRAINT fk_variables_variablenamecv FOREIGN KEY (variablename) REFERENCES variablenamecv(term);


--
-- Name: fk_variables_variableunitsid; Type: FK CONSTRAINT; Schema: tables; Owner: imiq
--

ALTER TABLE ONLY variables
    ADD CONSTRAINT fk_variables_variableunitsid FOREIGN KEY (variableunitsid) REFERENCES units(unitsid);


--
-- Name: public; Type: ACL; Schema: -; Owner: imiq
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM imiq;
GRANT ALL ON SCHEMA public TO imiq;
GRANT ALL ON SCHEMA public TO PUBLIC;
GRANT USAGE ON SCHEMA public TO asjacobs;
GRANT ALL ON SCHEMA public TO chaase;
GRANT USAGE ON SCHEMA public TO imiq_reader;
GRANT ALL ON SCHEMA public TO rwspicer;


--
-- Name: tables; Type: ACL; Schema: -; Owner: imiq
--

REVOKE ALL ON SCHEMA tables FROM PUBLIC;
REVOKE ALL ON SCHEMA tables FROM imiq;
GRANT ALL ON SCHEMA tables TO imiq;
GRANT ALL ON SCHEMA tables TO asjacobs;
GRANT ALL ON SCHEMA tables TO chaase;
GRANT USAGE ON SCHEMA tables TO rwspicer;
GRANT USAGE ON SCHEMA tables TO imiq_reader;


--
-- Name: views; Type: ACL; Schema: -; Owner: imiq
--

REVOKE ALL ON SCHEMA views FROM PUBLIC;
REVOKE ALL ON SCHEMA views FROM imiq;
GRANT ALL ON SCHEMA views TO imiq;
GRANT USAGE ON SCHEMA views TO asjacobs;
GRANT ALL ON SCHEMA views TO chaase;
GRANT USAGE ON SCHEMA views TO rwspicer;
GRANT USAGE ON SCHEMA views TO imiq_reader;


SET search_path = public, pg_catalog;

--
-- Name: geometry_columns; Type: ACL; Schema: public; Owner: imiq
--

REVOKE ALL ON TABLE geometry_columns FROM PUBLIC;
REVOKE ALL ON TABLE geometry_columns FROM imiq;
GRANT ALL ON TABLE geometry_columns TO imiq;
GRANT ALL ON TABLE geometry_columns TO asjacobs;
GRANT ALL ON TABLE geometry_columns TO chaase;
GRANT ALL ON TABLE geometry_columns TO rwspicer;
GRANT SELECT ON TABLE geometry_columns TO imiq_reader;


--
-- Name: spatial_ref_sys; Type: ACL; Schema: public; Owner: imiq
--

REVOKE ALL ON TABLE spatial_ref_sys FROM PUBLIC;
REVOKE ALL ON TABLE spatial_ref_sys FROM imiq;
GRANT ALL ON TABLE spatial_ref_sys TO imiq;
GRANT ALL ON TABLE spatial_ref_sys TO asjacobs;
GRANT ALL ON TABLE spatial_ref_sys TO chaase;
GRANT ALL ON TABLE spatial_ref_sys TO rwspicer;
GRANT SELECT ON TABLE spatial_ref_sys TO imiq_reader;


SET search_path = tables, pg_catalog;

--
-- Name: _sites_summary; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE _sites_summary FROM PUBLIC;
REVOKE ALL ON TABLE _sites_summary FROM imiq;
GRANT ALL ON TABLE _sites_summary TO imiq;
GRANT ALL ON TABLE _sites_summary TO asjacobs;
GRANT ALL ON TABLE _sites_summary TO chaase;
GRANT ALL ON TABLE _sites_summary TO rwspicer;
GRANT SELECT ON TABLE _sites_summary TO imiq_reader;


--
-- Name: _siteswithelevations; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE _siteswithelevations FROM PUBLIC;
REVOKE ALL ON TABLE _siteswithelevations FROM imiq;
GRANT ALL ON TABLE _siteswithelevations TO imiq;
GRANT ALL ON TABLE _siteswithelevations TO asjacobs;
GRANT ALL ON TABLE _siteswithelevations TO chaase;
GRANT ALL ON TABLE _siteswithelevations TO rwspicer;
GRANT SELECT ON TABLE _siteswithelevations TO imiq_reader;


--
-- Name: annual_avgrh_all; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE annual_avgrh_all FROM PUBLIC;
REVOKE ALL ON TABLE annual_avgrh_all FROM imiq;
GRANT ALL ON TABLE annual_avgrh_all TO imiq;
GRANT ALL ON TABLE annual_avgrh_all TO asjacobs;
GRANT ALL ON TABLE annual_avgrh_all TO chaase;
GRANT ALL ON TABLE annual_avgrh_all TO rwspicer;
GRANT SELECT ON TABLE annual_avgrh_all TO imiq_reader;


--
-- Name: annual_avgwinterairtemp_all; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE annual_avgwinterairtemp_all FROM PUBLIC;
REVOKE ALL ON TABLE annual_avgwinterairtemp_all FROM imiq;
GRANT ALL ON TABLE annual_avgwinterairtemp_all TO imiq;
GRANT ALL ON TABLE annual_avgwinterairtemp_all TO asjacobs;
GRANT ALL ON TABLE annual_avgwinterairtemp_all TO chaase;
GRANT ALL ON TABLE annual_avgwinterairtemp_all TO rwspicer;
GRANT SELECT ON TABLE annual_avgwinterairtemp_all TO imiq_reader;


--
-- Name: annual_avgwinterprecip_all; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE annual_avgwinterprecip_all FROM PUBLIC;
REVOKE ALL ON TABLE annual_avgwinterprecip_all FROM imiq;
GRANT ALL ON TABLE annual_avgwinterprecip_all TO imiq;
GRANT ALL ON TABLE annual_avgwinterprecip_all TO asjacobs;
GRANT ALL ON TABLE annual_avgwinterprecip_all TO chaase;
GRANT ALL ON TABLE annual_avgwinterprecip_all TO rwspicer;
GRANT SELECT ON TABLE annual_avgwinterprecip_all TO imiq_reader;


--
-- Name: annual_avgwinterrh_all; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE annual_avgwinterrh_all FROM PUBLIC;
REVOKE ALL ON TABLE annual_avgwinterrh_all FROM imiq;
GRANT ALL ON TABLE annual_avgwinterrh_all TO imiq;
GRANT ALL ON TABLE annual_avgwinterrh_all TO asjacobs;
GRANT ALL ON TABLE annual_avgwinterrh_all TO chaase;
GRANT ALL ON TABLE annual_avgwinterrh_all TO rwspicer;
GRANT SELECT ON TABLE annual_avgwinterrh_all TO imiq_reader;


--
-- Name: annual_peakdischarge_all; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE annual_peakdischarge_all FROM PUBLIC;
REVOKE ALL ON TABLE annual_peakdischarge_all FROM imiq;
GRANT ALL ON TABLE annual_peakdischarge_all TO imiq;
GRANT ALL ON TABLE annual_peakdischarge_all TO asjacobs;
GRANT ALL ON TABLE annual_peakdischarge_all TO chaase;
GRANT ALL ON TABLE annual_peakdischarge_all TO rwspicer;
GRANT SELECT ON TABLE annual_peakdischarge_all TO imiq_reader;


--
-- Name: annual_peaksnowdepth_all; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE annual_peaksnowdepth_all FROM PUBLIC;
REVOKE ALL ON TABLE annual_peaksnowdepth_all FROM imiq;
GRANT ALL ON TABLE annual_peaksnowdepth_all TO imiq;
GRANT ALL ON TABLE annual_peaksnowdepth_all TO asjacobs;
GRANT ALL ON TABLE annual_peaksnowdepth_all TO chaase;
GRANT ALL ON TABLE annual_peaksnowdepth_all TO rwspicer;
GRANT SELECT ON TABLE annual_peaksnowdepth_all TO imiq_reader;


--
-- Name: annual_peakswe_all; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE annual_peakswe_all FROM PUBLIC;
REVOKE ALL ON TABLE annual_peakswe_all FROM imiq;
GRANT ALL ON TABLE annual_peakswe_all TO imiq;
GRANT ALL ON TABLE annual_peakswe_all TO asjacobs;
GRANT ALL ON TABLE annual_peakswe_all TO chaase;
GRANT ALL ON TABLE annual_peakswe_all TO rwspicer;
GRANT SELECT ON TABLE annual_peakswe_all TO imiq_reader;


--
-- Name: annual_totalprecip_all; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE annual_totalprecip_all FROM PUBLIC;
REVOKE ALL ON TABLE annual_totalprecip_all FROM imiq;
GRANT ALL ON TABLE annual_totalprecip_all TO imiq;
GRANT ALL ON TABLE annual_totalprecip_all TO asjacobs;
GRANT ALL ON TABLE annual_totalprecip_all TO chaase;
GRANT ALL ON TABLE annual_totalprecip_all TO rwspicer;
GRANT SELECT ON TABLE annual_totalprecip_all TO imiq_reader;


--
-- Name: attributes; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE attributes FROM PUBLIC;
REVOKE ALL ON TABLE attributes FROM imiq;
GRANT ALL ON TABLE attributes TO imiq;
GRANT ALL ON TABLE attributes TO asjacobs;
GRANT ALL ON TABLE attributes TO chaase;
GRANT ALL ON TABLE attributes TO rwspicer;
GRANT SELECT ON TABLE attributes TO imiq_reader;


--
-- Name: categories; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE categories FROM PUBLIC;
REVOKE ALL ON TABLE categories FROM imiq;
GRANT ALL ON TABLE categories TO imiq;
GRANT ALL ON TABLE categories TO asjacobs;
GRANT ALL ON TABLE categories TO chaase;
GRANT ALL ON TABLE categories TO rwspicer;
GRANT SELECT ON TABLE categories TO imiq_reader;


--
-- Name: censorcodecv; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE censorcodecv FROM PUBLIC;
REVOKE ALL ON TABLE censorcodecv FROM imiq;
GRANT ALL ON TABLE censorcodecv TO imiq;
GRANT ALL ON TABLE censorcodecv TO asjacobs;
GRANT ALL ON TABLE censorcodecv TO chaase;
GRANT ALL ON TABLE censorcodecv TO rwspicer;
GRANT SELECT ON TABLE censorcodecv TO imiq_reader;


--
-- Name: daily_airtempdatavalues; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE daily_airtempdatavalues FROM PUBLIC;
REVOKE ALL ON TABLE daily_airtempdatavalues FROM imiq;
GRANT ALL ON TABLE daily_airtempdatavalues TO imiq;
GRANT ALL ON TABLE daily_airtempdatavalues TO asjacobs;
GRANT ALL ON TABLE daily_airtempdatavalues TO chaase;
GRANT ALL ON TABLE daily_airtempdatavalues TO rwspicer;
GRANT SELECT ON TABLE daily_airtempdatavalues TO imiq_reader;


--
-- Name: daily_airtempmaxdatavalues; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE daily_airtempmaxdatavalues FROM PUBLIC;
REVOKE ALL ON TABLE daily_airtempmaxdatavalues FROM imiq;
GRANT ALL ON TABLE daily_airtempmaxdatavalues TO imiq;
GRANT ALL ON TABLE daily_airtempmaxdatavalues TO asjacobs;
GRANT ALL ON TABLE daily_airtempmaxdatavalues TO chaase;
GRANT ALL ON TABLE daily_airtempmaxdatavalues TO rwspicer;
GRANT SELECT ON TABLE daily_airtempmaxdatavalues TO imiq_reader;


--
-- Name: daily_airtempmindatavalues; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE daily_airtempmindatavalues FROM PUBLIC;
REVOKE ALL ON TABLE daily_airtempmindatavalues FROM imiq;
GRANT ALL ON TABLE daily_airtempmindatavalues TO imiq;
GRANT ALL ON TABLE daily_airtempmindatavalues TO asjacobs;
GRANT ALL ON TABLE daily_airtempmindatavalues TO chaase;
GRANT ALL ON TABLE daily_airtempmindatavalues TO rwspicer;
GRANT SELECT ON TABLE daily_airtempmindatavalues TO imiq_reader;


--
-- Name: daily_dischargedatavalues; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE daily_dischargedatavalues FROM PUBLIC;
REVOKE ALL ON TABLE daily_dischargedatavalues FROM imiq;
GRANT ALL ON TABLE daily_dischargedatavalues TO imiq;
GRANT ALL ON TABLE daily_dischargedatavalues TO asjacobs;
GRANT ALL ON TABLE daily_dischargedatavalues TO chaase;
GRANT ALL ON TABLE daily_dischargedatavalues TO rwspicer;
GRANT SELECT ON TABLE daily_dischargedatavalues TO imiq_reader;


--
-- Name: daily_precip; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE daily_precip FROM PUBLIC;
REVOKE ALL ON TABLE daily_precip FROM imiq;
GRANT ALL ON TABLE daily_precip TO imiq;
GRANT ALL ON TABLE daily_precip TO asjacobs;
GRANT ALL ON TABLE daily_precip TO chaase;
GRANT ALL ON TABLE daily_precip TO rwspicer;
GRANT SELECT ON TABLE daily_precip TO imiq_reader;


--
-- Name: daily_precip_thresholds; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE daily_precip_thresholds FROM PUBLIC;
REVOKE ALL ON TABLE daily_precip_thresholds FROM imiq;
GRANT ALL ON TABLE daily_precip_thresholds TO imiq;
GRANT ALL ON TABLE daily_precip_thresholds TO asjacobs;
GRANT ALL ON TABLE daily_precip_thresholds TO chaase;
GRANT ALL ON TABLE daily_precip_thresholds TO rwspicer;
GRANT SELECT ON TABLE daily_precip_thresholds TO imiq_reader;


--
-- Name: daily_precipdatavalues; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE daily_precipdatavalues FROM PUBLIC;
REVOKE ALL ON TABLE daily_precipdatavalues FROM imiq;
GRANT ALL ON TABLE daily_precipdatavalues TO imiq;
GRANT ALL ON TABLE daily_precipdatavalues TO asjacobs;
GRANT ALL ON TABLE daily_precipdatavalues TO chaase;
GRANT ALL ON TABLE daily_precipdatavalues TO rwspicer;
GRANT SELECT ON TABLE daily_precipdatavalues TO imiq_reader;


--
-- Name: daily_rhdatavalues; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE daily_rhdatavalues FROM PUBLIC;
REVOKE ALL ON TABLE daily_rhdatavalues FROM imiq;
GRANT ALL ON TABLE daily_rhdatavalues TO imiq;
GRANT ALL ON TABLE daily_rhdatavalues TO asjacobs;
GRANT ALL ON TABLE daily_rhdatavalues TO chaase;
GRANT ALL ON TABLE daily_rhdatavalues TO rwspicer;
GRANT SELECT ON TABLE daily_rhdatavalues TO imiq_reader;


--
-- Name: daily_snowdepth; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE daily_snowdepth FROM PUBLIC;
REVOKE ALL ON TABLE daily_snowdepth FROM imiq;
GRANT ALL ON TABLE daily_snowdepth TO imiq;
GRANT ALL ON TABLE daily_snowdepth TO asjacobs;
GRANT ALL ON TABLE daily_snowdepth TO chaase;
GRANT ALL ON TABLE daily_snowdepth TO rwspicer;
GRANT SELECT ON TABLE daily_snowdepth TO imiq_reader;


--
-- Name: daily_snowdepthdatavalues; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE daily_snowdepthdatavalues FROM PUBLIC;
REVOKE ALL ON TABLE daily_snowdepthdatavalues FROM imiq;
GRANT ALL ON TABLE daily_snowdepthdatavalues TO imiq;
GRANT ALL ON TABLE daily_snowdepthdatavalues TO asjacobs;
GRANT ALL ON TABLE daily_snowdepthdatavalues TO chaase;
GRANT ALL ON TABLE daily_snowdepthdatavalues TO rwspicer;
GRANT SELECT ON TABLE daily_snowdepthdatavalues TO imiq_reader;


--
-- Name: daily_swe; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE daily_swe FROM PUBLIC;
REVOKE ALL ON TABLE daily_swe FROM imiq;
GRANT ALL ON TABLE daily_swe TO imiq;
GRANT ALL ON TABLE daily_swe TO asjacobs;
GRANT ALL ON TABLE daily_swe TO chaase;
GRANT ALL ON TABLE daily_swe TO rwspicer;
GRANT SELECT ON TABLE daily_swe TO imiq_reader;


--
-- Name: daily_swedatavalues; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE daily_swedatavalues FROM PUBLIC;
REVOKE ALL ON TABLE daily_swedatavalues FROM imiq;
GRANT ALL ON TABLE daily_swedatavalues TO imiq;
GRANT ALL ON TABLE daily_swedatavalues TO asjacobs;
GRANT ALL ON TABLE daily_swedatavalues TO chaase;
GRANT ALL ON TABLE daily_swedatavalues TO rwspicer;
GRANT SELECT ON TABLE daily_swedatavalues TO imiq_reader;


--
-- Name: daily_watertempdatavalues; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE daily_watertempdatavalues FROM PUBLIC;
REVOKE ALL ON TABLE daily_watertempdatavalues FROM imiq;
GRANT ALL ON TABLE daily_watertempdatavalues TO imiq;
GRANT ALL ON TABLE daily_watertempdatavalues TO asjacobs;
GRANT ALL ON TABLE daily_watertempdatavalues TO chaase;
GRANT ALL ON TABLE daily_watertempdatavalues TO rwspicer;
GRANT SELECT ON TABLE daily_watertempdatavalues TO imiq_reader;


--
-- Name: daily_winddirectiondatavalues; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE daily_winddirectiondatavalues FROM PUBLIC;
REVOKE ALL ON TABLE daily_winddirectiondatavalues FROM imiq;
GRANT ALL ON TABLE daily_winddirectiondatavalues TO imiq;
GRANT ALL ON TABLE daily_winddirectiondatavalues TO asjacobs;
GRANT ALL ON TABLE daily_winddirectiondatavalues TO chaase;
GRANT ALL ON TABLE daily_winddirectiondatavalues TO rwspicer;
GRANT SELECT ON TABLE daily_winddirectiondatavalues TO imiq_reader;


--
-- Name: daily_windspeeddatavalues; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE daily_windspeeddatavalues FROM PUBLIC;
REVOKE ALL ON TABLE daily_windspeeddatavalues FROM imiq;
GRANT ALL ON TABLE daily_windspeeddatavalues TO imiq;
GRANT ALL ON TABLE daily_windspeeddatavalues TO asjacobs;
GRANT ALL ON TABLE daily_windspeeddatavalues TO chaase;
GRANT ALL ON TABLE daily_windspeeddatavalues TO rwspicer;
GRANT SELECT ON TABLE daily_windspeeddatavalues TO imiq_reader;


--
-- Name: datastreams; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE datastreams FROM PUBLIC;
REVOKE ALL ON TABLE datastreams FROM imiq;
GRANT ALL ON TABLE datastreams TO imiq;
GRANT ALL ON TABLE datastreams TO asjacobs;
GRANT ALL ON TABLE datastreams TO chaase;
GRANT ALL ON TABLE datastreams TO rwspicer;
GRANT SELECT ON TABLE datastreams TO imiq_reader;


--
-- Name: datatypecv; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE datatypecv FROM PUBLIC;
REVOKE ALL ON TABLE datatypecv FROM imiq;
GRANT ALL ON TABLE datatypecv TO imiq;
GRANT ALL ON TABLE datatypecv TO asjacobs;
GRANT ALL ON TABLE datatypecv TO chaase;
GRANT ALL ON TABLE datatypecv TO rwspicer;
GRANT SELECT ON TABLE datatypecv TO imiq_reader;


--
-- Name: datavalues; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE datavalues FROM PUBLIC;
REVOKE ALL ON TABLE datavalues FROM imiq;
GRANT ALL ON TABLE datavalues TO imiq;
GRANT ALL ON TABLE datavalues TO asjacobs;
GRANT ALL ON TABLE datavalues TO chaase;
GRANT ALL ON TABLE datavalues TO rwspicer;
GRANT SELECT ON TABLE datavalues TO imiq_reader;


--
-- Name: datavaluesraw; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE datavaluesraw FROM PUBLIC;
REVOKE ALL ON TABLE datavaluesraw FROM imiq;
GRANT ALL ON TABLE datavaluesraw TO imiq;
GRANT ALL ON TABLE datavaluesraw TO asjacobs;
GRANT ALL ON TABLE datavaluesraw TO chaase;
GRANT ALL ON TABLE datavaluesraw TO rwspicer;
GRANT SELECT ON TABLE datavaluesraw TO imiq_reader;


--
-- Name: derivedfrom; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE derivedfrom FROM PUBLIC;
REVOKE ALL ON TABLE derivedfrom FROM imiq;
GRANT ALL ON TABLE derivedfrom TO imiq;
GRANT ALL ON TABLE derivedfrom TO asjacobs;
GRANT ALL ON TABLE derivedfrom TO chaase;
GRANT ALL ON TABLE derivedfrom TO rwspicer;
GRANT SELECT ON TABLE derivedfrom TO imiq_reader;


--
-- Name: devices; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE devices FROM PUBLIC;
REVOKE ALL ON TABLE devices FROM imiq;
GRANT ALL ON TABLE devices TO imiq;
GRANT ALL ON TABLE devices TO asjacobs;
GRANT ALL ON TABLE devices TO chaase;
GRANT ALL ON TABLE devices TO rwspicer;
GRANT SELECT ON TABLE devices TO imiq_reader;


--
-- Name: ext_arc_arc; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE ext_arc_arc FROM PUBLIC;
REVOKE ALL ON TABLE ext_arc_arc FROM imiq;
GRANT ALL ON TABLE ext_arc_arc TO imiq;
GRANT ALL ON TABLE ext_arc_arc TO asjacobs;
GRANT ALL ON TABLE ext_arc_arc TO chaase;
GRANT ALL ON TABLE ext_arc_arc TO rwspicer;
GRANT SELECT ON TABLE ext_arc_arc TO imiq_reader;


--
-- Name: ext_arc_point; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE ext_arc_point FROM PUBLIC;
REVOKE ALL ON TABLE ext_arc_point FROM imiq;
GRANT ALL ON TABLE ext_arc_point TO imiq;
GRANT ALL ON TABLE ext_arc_point TO asjacobs;
GRANT ALL ON TABLE ext_arc_point TO chaase;
GRANT ALL ON TABLE ext_arc_point TO rwspicer;
GRANT SELECT ON TABLE ext_arc_point TO imiq_reader;


--
-- Name: ext_fws_fishsample; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE ext_fws_fishsample FROM PUBLIC;
REVOKE ALL ON TABLE ext_fws_fishsample FROM imiq;
GRANT ALL ON TABLE ext_fws_fishsample TO imiq;
GRANT ALL ON TABLE ext_fws_fishsample TO asjacobs;
GRANT ALL ON TABLE ext_fws_fishsample TO chaase;
GRANT ALL ON TABLE ext_fws_fishsample TO rwspicer;
GRANT SELECT ON TABLE ext_fws_fishsample TO imiq_reader;


--
-- Name: ext_reference; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE ext_reference FROM PUBLIC;
REVOKE ALL ON TABLE ext_reference FROM imiq;
GRANT ALL ON TABLE ext_reference TO imiq;
GRANT ALL ON TABLE ext_reference TO asjacobs;
GRANT ALL ON TABLE ext_reference TO chaase;
GRANT ALL ON TABLE ext_reference TO rwspicer;
GRANT SELECT ON TABLE ext_reference TO imiq_reader;


--
-- Name: ext_referencetowaterbody; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE ext_referencetowaterbody FROM PUBLIC;
REVOKE ALL ON TABLE ext_referencetowaterbody FROM imiq;
GRANT ALL ON TABLE ext_referencetowaterbody TO imiq;
GRANT ALL ON TABLE ext_referencetowaterbody TO asjacobs;
GRANT ALL ON TABLE ext_referencetowaterbody TO chaase;
GRANT ALL ON TABLE ext_referencetowaterbody TO rwspicer;
GRANT SELECT ON TABLE ext_referencetowaterbody TO imiq_reader;


--
-- Name: ext_waterbody; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE ext_waterbody FROM PUBLIC;
REVOKE ALL ON TABLE ext_waterbody FROM imiq;
GRANT ALL ON TABLE ext_waterbody TO imiq;
GRANT ALL ON TABLE ext_waterbody TO asjacobs;
GRANT ALL ON TABLE ext_waterbody TO chaase;
GRANT ALL ON TABLE ext_waterbody TO rwspicer;
GRANT SELECT ON TABLE ext_waterbody TO imiq_reader;


--
-- Name: generalcategorycv; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE generalcategorycv FROM PUBLIC;
REVOKE ALL ON TABLE generalcategorycv FROM imiq;
GRANT ALL ON TABLE generalcategorycv TO imiq;
GRANT ALL ON TABLE generalcategorycv TO asjacobs;
GRANT ALL ON TABLE generalcategorycv TO chaase;
GRANT ALL ON TABLE generalcategorycv TO rwspicer;
GRANT SELECT ON TABLE generalcategorycv TO imiq_reader;


--
-- Name: groupdescriptions; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE groupdescriptions FROM PUBLIC;
REVOKE ALL ON TABLE groupdescriptions FROM imiq;
GRANT ALL ON TABLE groupdescriptions TO imiq;
GRANT ALL ON TABLE groupdescriptions TO asjacobs;
GRANT ALL ON TABLE groupdescriptions TO chaase;
GRANT ALL ON TABLE groupdescriptions TO rwspicer;
GRANT SELECT ON TABLE groupdescriptions TO imiq_reader;


--
-- Name: groups; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE groups FROM PUBLIC;
REVOKE ALL ON TABLE groups FROM imiq;
GRANT ALL ON TABLE groups TO imiq;
GRANT ALL ON TABLE groups TO asjacobs;
GRANT ALL ON TABLE groups TO chaase;
GRANT ALL ON TABLE groups TO rwspicer;
GRANT SELECT ON TABLE groups TO imiq_reader;


--
-- Name: hourly_airtempdatavalues; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE hourly_airtempdatavalues FROM PUBLIC;
REVOKE ALL ON TABLE hourly_airtempdatavalues FROM imiq;
GRANT ALL ON TABLE hourly_airtempdatavalues TO imiq;
GRANT ALL ON TABLE hourly_airtempdatavalues TO asjacobs;
GRANT ALL ON TABLE hourly_airtempdatavalues TO chaase;
GRANT ALL ON TABLE hourly_airtempdatavalues TO rwspicer;
GRANT SELECT ON TABLE hourly_airtempdatavalues TO imiq_reader;


--
-- Name: hourly_precip; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE hourly_precip FROM PUBLIC;
REVOKE ALL ON TABLE hourly_precip FROM imiq;
GRANT ALL ON TABLE hourly_precip TO imiq;
GRANT ALL ON TABLE hourly_precip TO asjacobs;
GRANT ALL ON TABLE hourly_precip TO chaase;
GRANT ALL ON TABLE hourly_precip TO rwspicer;
GRANT SELECT ON TABLE hourly_precip TO imiq_reader;


--
-- Name: hourly_precipdatavalues; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE hourly_precipdatavalues FROM PUBLIC;
REVOKE ALL ON TABLE hourly_precipdatavalues FROM imiq;
GRANT ALL ON TABLE hourly_precipdatavalues TO imiq;
GRANT ALL ON TABLE hourly_precipdatavalues TO asjacobs;
GRANT ALL ON TABLE hourly_precipdatavalues TO chaase;
GRANT ALL ON TABLE hourly_precipdatavalues TO rwspicer;
GRANT SELECT ON TABLE hourly_precipdatavalues TO imiq_reader;


--
-- Name: hourly_rhdatavalues; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE hourly_rhdatavalues FROM PUBLIC;
REVOKE ALL ON TABLE hourly_rhdatavalues FROM imiq;
GRANT ALL ON TABLE hourly_rhdatavalues TO imiq;
GRANT ALL ON TABLE hourly_rhdatavalues TO asjacobs;
GRANT ALL ON TABLE hourly_rhdatavalues TO chaase;
GRANT ALL ON TABLE hourly_rhdatavalues TO rwspicer;
GRANT SELECT ON TABLE hourly_rhdatavalues TO imiq_reader;


--
-- Name: hourly_snowdepth; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE hourly_snowdepth FROM PUBLIC;
REVOKE ALL ON TABLE hourly_snowdepth FROM imiq;
GRANT ALL ON TABLE hourly_snowdepth TO imiq;
GRANT ALL ON TABLE hourly_snowdepth TO asjacobs;
GRANT ALL ON TABLE hourly_snowdepth TO chaase;
GRANT ALL ON TABLE hourly_snowdepth TO rwspicer;
GRANT SELECT ON TABLE hourly_snowdepth TO imiq_reader;


--
-- Name: hourly_snowdepthdatavalues; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE hourly_snowdepthdatavalues FROM PUBLIC;
REVOKE ALL ON TABLE hourly_snowdepthdatavalues FROM imiq;
GRANT ALL ON TABLE hourly_snowdepthdatavalues TO imiq;
GRANT ALL ON TABLE hourly_snowdepthdatavalues TO asjacobs;
GRANT ALL ON TABLE hourly_snowdepthdatavalues TO chaase;
GRANT ALL ON TABLE hourly_snowdepthdatavalues TO rwspicer;
GRANT SELECT ON TABLE hourly_snowdepthdatavalues TO imiq_reader;


--
-- Name: hourly_swe; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE hourly_swe FROM PUBLIC;
REVOKE ALL ON TABLE hourly_swe FROM imiq;
GRANT ALL ON TABLE hourly_swe TO imiq;
GRANT ALL ON TABLE hourly_swe TO asjacobs;
GRANT ALL ON TABLE hourly_swe TO chaase;
GRANT ALL ON TABLE hourly_swe TO rwspicer;
GRANT SELECT ON TABLE hourly_swe TO imiq_reader;


--
-- Name: hourly_swedatavalues; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE hourly_swedatavalues FROM PUBLIC;
REVOKE ALL ON TABLE hourly_swedatavalues FROM imiq;
GRANT ALL ON TABLE hourly_swedatavalues TO imiq;
GRANT ALL ON TABLE hourly_swedatavalues TO asjacobs;
GRANT ALL ON TABLE hourly_swedatavalues TO chaase;
GRANT ALL ON TABLE hourly_swedatavalues TO rwspicer;
GRANT SELECT ON TABLE hourly_swedatavalues TO imiq_reader;


--
-- Name: hourly_winddirectiondatavalues; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE hourly_winddirectiondatavalues FROM PUBLIC;
REVOKE ALL ON TABLE hourly_winddirectiondatavalues FROM imiq;
GRANT ALL ON TABLE hourly_winddirectiondatavalues TO imiq;
GRANT ALL ON TABLE hourly_winddirectiondatavalues TO asjacobs;
GRANT ALL ON TABLE hourly_winddirectiondatavalues TO chaase;
GRANT ALL ON TABLE hourly_winddirectiondatavalues TO rwspicer;
GRANT SELECT ON TABLE hourly_winddirectiondatavalues TO imiq_reader;


--
-- Name: hourly_windspeeddatavalues; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE hourly_windspeeddatavalues FROM PUBLIC;
REVOKE ALL ON TABLE hourly_windspeeddatavalues FROM imiq;
GRANT ALL ON TABLE hourly_windspeeddatavalues TO imiq;
GRANT ALL ON TABLE hourly_windspeeddatavalues TO asjacobs;
GRANT ALL ON TABLE hourly_windspeeddatavalues TO chaase;
GRANT ALL ON TABLE hourly_windspeeddatavalues TO rwspicer;
GRANT SELECT ON TABLE hourly_windspeeddatavalues TO imiq_reader;


--
-- Name: imiqversion; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE imiqversion FROM PUBLIC;
REVOKE ALL ON TABLE imiqversion FROM imiq;
GRANT ALL ON TABLE imiqversion TO imiq;
GRANT ALL ON TABLE imiqversion TO asjacobs;
GRANT ALL ON TABLE imiqversion TO chaase;
GRANT ALL ON TABLE imiqversion TO rwspicer;
GRANT SELECT ON TABLE imiqversion TO imiq_reader;


--
-- Name: incidents; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE incidents FROM PUBLIC;
REVOKE ALL ON TABLE incidents FROM imiq;
GRANT ALL ON TABLE incidents TO imiq;
GRANT ALL ON TABLE incidents TO asjacobs;
GRANT ALL ON TABLE incidents TO chaase;
GRANT ALL ON TABLE incidents TO rwspicer;
GRANT SELECT ON TABLE incidents TO imiq_reader;


--
-- Name: isometadata; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE isometadata FROM PUBLIC;
REVOKE ALL ON TABLE isometadata FROM imiq;
GRANT ALL ON TABLE isometadata TO imiq;
GRANT ALL ON TABLE isometadata TO asjacobs;
GRANT ALL ON TABLE isometadata TO chaase;
GRANT ALL ON TABLE isometadata TO rwspicer;
GRANT SELECT ON TABLE isometadata TO imiq_reader;


--
-- Name: methods; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE methods FROM PUBLIC;
REVOKE ALL ON TABLE methods FROM imiq;
GRANT ALL ON TABLE methods TO imiq;
GRANT ALL ON TABLE methods TO asjacobs;
GRANT ALL ON TABLE methods TO chaase;
GRANT ALL ON TABLE methods TO rwspicer;
GRANT SELECT ON TABLE methods TO imiq_reader;


--
-- Name: monthly_rh_all; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE monthly_rh_all FROM PUBLIC;
REVOKE ALL ON TABLE monthly_rh_all FROM imiq;
GRANT ALL ON TABLE monthly_rh_all TO imiq;
GRANT ALL ON TABLE monthly_rh_all TO asjacobs;
GRANT ALL ON TABLE monthly_rh_all TO chaase;
GRANT ALL ON TABLE monthly_rh_all TO rwspicer;
GRANT SELECT ON TABLE monthly_rh_all TO imiq_reader;


--
-- Name: multiyear_annual_all_avgairtemp; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE multiyear_annual_all_avgairtemp FROM PUBLIC;
REVOKE ALL ON TABLE multiyear_annual_all_avgairtemp FROM imiq;
GRANT ALL ON TABLE multiyear_annual_all_avgairtemp TO imiq;
GRANT ALL ON TABLE multiyear_annual_all_avgairtemp TO asjacobs;
GRANT ALL ON TABLE multiyear_annual_all_avgairtemp TO chaase;
GRANT ALL ON TABLE multiyear_annual_all_avgairtemp TO rwspicer;
GRANT SELECT ON TABLE multiyear_annual_all_avgairtemp TO imiq_reader;


--
-- Name: multiyear_annual_all_avgdischarge; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE multiyear_annual_all_avgdischarge FROM PUBLIC;
REVOKE ALL ON TABLE multiyear_annual_all_avgdischarge FROM imiq;
GRANT ALL ON TABLE multiyear_annual_all_avgdischarge TO imiq;
GRANT ALL ON TABLE multiyear_annual_all_avgdischarge TO asjacobs;
GRANT ALL ON TABLE multiyear_annual_all_avgdischarge TO chaase;
GRANT ALL ON TABLE multiyear_annual_all_avgdischarge TO rwspicer;
GRANT SELECT ON TABLE multiyear_annual_all_avgdischarge TO imiq_reader;


--
-- Name: multiyear_annual_all_avgfallairtemp; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE multiyear_annual_all_avgfallairtemp FROM PUBLIC;
REVOKE ALL ON TABLE multiyear_annual_all_avgfallairtemp FROM imiq;
GRANT ALL ON TABLE multiyear_annual_all_avgfallairtemp TO imiq;
GRANT ALL ON TABLE multiyear_annual_all_avgfallairtemp TO asjacobs;
GRANT ALL ON TABLE multiyear_annual_all_avgfallairtemp TO chaase;
GRANT ALL ON TABLE multiyear_annual_all_avgfallairtemp TO rwspicer;
GRANT SELECT ON TABLE multiyear_annual_all_avgfallairtemp TO imiq_reader;


--
-- Name: multiyear_annual_all_avgfallprecip; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE multiyear_annual_all_avgfallprecip FROM PUBLIC;
REVOKE ALL ON TABLE multiyear_annual_all_avgfallprecip FROM imiq;
GRANT ALL ON TABLE multiyear_annual_all_avgfallprecip TO imiq;
GRANT ALL ON TABLE multiyear_annual_all_avgfallprecip TO asjacobs;
GRANT ALL ON TABLE multiyear_annual_all_avgfallprecip TO chaase;
GRANT ALL ON TABLE multiyear_annual_all_avgfallprecip TO rwspicer;
GRANT SELECT ON TABLE multiyear_annual_all_avgfallprecip TO imiq_reader;


--
-- Name: multiyear_annual_all_avgpeakdischarge; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE multiyear_annual_all_avgpeakdischarge FROM PUBLIC;
REVOKE ALL ON TABLE multiyear_annual_all_avgpeakdischarge FROM imiq;
GRANT ALL ON TABLE multiyear_annual_all_avgpeakdischarge TO imiq;
GRANT ALL ON TABLE multiyear_annual_all_avgpeakdischarge TO asjacobs;
GRANT ALL ON TABLE multiyear_annual_all_avgpeakdischarge TO chaase;
GRANT ALL ON TABLE multiyear_annual_all_avgpeakdischarge TO rwspicer;
GRANT SELECT ON TABLE multiyear_annual_all_avgpeakdischarge TO imiq_reader;


--
-- Name: multiyear_annual_all_avgpeaksnowdepth; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE multiyear_annual_all_avgpeaksnowdepth FROM PUBLIC;
REVOKE ALL ON TABLE multiyear_annual_all_avgpeaksnowdepth FROM imiq;
GRANT ALL ON TABLE multiyear_annual_all_avgpeaksnowdepth TO imiq;
GRANT ALL ON TABLE multiyear_annual_all_avgpeaksnowdepth TO asjacobs;
GRANT ALL ON TABLE multiyear_annual_all_avgpeaksnowdepth TO chaase;
GRANT ALL ON TABLE multiyear_annual_all_avgpeaksnowdepth TO rwspicer;
GRANT SELECT ON TABLE multiyear_annual_all_avgpeaksnowdepth TO imiq_reader;


--
-- Name: multiyear_annual_all_avgpeakswe; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE multiyear_annual_all_avgpeakswe FROM PUBLIC;
REVOKE ALL ON TABLE multiyear_annual_all_avgpeakswe FROM imiq;
GRANT ALL ON TABLE multiyear_annual_all_avgpeakswe TO imiq;
GRANT ALL ON TABLE multiyear_annual_all_avgpeakswe TO asjacobs;
GRANT ALL ON TABLE multiyear_annual_all_avgpeakswe TO chaase;
GRANT ALL ON TABLE multiyear_annual_all_avgpeakswe TO rwspicer;
GRANT SELECT ON TABLE multiyear_annual_all_avgpeakswe TO imiq_reader;


--
-- Name: multiyear_annual_all_avgprecip; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE multiyear_annual_all_avgprecip FROM PUBLIC;
REVOKE ALL ON TABLE multiyear_annual_all_avgprecip FROM imiq;
GRANT ALL ON TABLE multiyear_annual_all_avgprecip TO imiq;
GRANT ALL ON TABLE multiyear_annual_all_avgprecip TO asjacobs;
GRANT ALL ON TABLE multiyear_annual_all_avgprecip TO chaase;
GRANT ALL ON TABLE multiyear_annual_all_avgprecip TO rwspicer;
GRANT SELECT ON TABLE multiyear_annual_all_avgprecip TO imiq_reader;


--
-- Name: multiyear_annual_all_avgrh; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE multiyear_annual_all_avgrh FROM PUBLIC;
REVOKE ALL ON TABLE multiyear_annual_all_avgrh FROM imiq;
GRANT ALL ON TABLE multiyear_annual_all_avgrh TO imiq;
GRANT ALL ON TABLE multiyear_annual_all_avgrh TO asjacobs;
GRANT ALL ON TABLE multiyear_annual_all_avgrh TO chaase;
GRANT ALL ON TABLE multiyear_annual_all_avgrh TO rwspicer;
GRANT SELECT ON TABLE multiyear_annual_all_avgrh TO imiq_reader;


--
-- Name: multiyear_annual_all_avgspringairtemp; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE multiyear_annual_all_avgspringairtemp FROM PUBLIC;
REVOKE ALL ON TABLE multiyear_annual_all_avgspringairtemp FROM imiq;
GRANT ALL ON TABLE multiyear_annual_all_avgspringairtemp TO imiq;
GRANT ALL ON TABLE multiyear_annual_all_avgspringairtemp TO asjacobs;
GRANT ALL ON TABLE multiyear_annual_all_avgspringairtemp TO chaase;
GRANT ALL ON TABLE multiyear_annual_all_avgspringairtemp TO rwspicer;
GRANT SELECT ON TABLE multiyear_annual_all_avgspringairtemp TO imiq_reader;


--
-- Name: multiyear_annual_all_avgspringprecip; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE multiyear_annual_all_avgspringprecip FROM PUBLIC;
REVOKE ALL ON TABLE multiyear_annual_all_avgspringprecip FROM imiq;
GRANT ALL ON TABLE multiyear_annual_all_avgspringprecip TO imiq;
GRANT ALL ON TABLE multiyear_annual_all_avgspringprecip TO asjacobs;
GRANT ALL ON TABLE multiyear_annual_all_avgspringprecip TO chaase;
GRANT ALL ON TABLE multiyear_annual_all_avgspringprecip TO rwspicer;
GRANT SELECT ON TABLE multiyear_annual_all_avgspringprecip TO imiq_reader;


--
-- Name: multiyear_annual_all_avgsummerairtemp; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE multiyear_annual_all_avgsummerairtemp FROM PUBLIC;
REVOKE ALL ON TABLE multiyear_annual_all_avgsummerairtemp FROM imiq;
GRANT ALL ON TABLE multiyear_annual_all_avgsummerairtemp TO imiq;
GRANT ALL ON TABLE multiyear_annual_all_avgsummerairtemp TO asjacobs;
GRANT ALL ON TABLE multiyear_annual_all_avgsummerairtemp TO chaase;
GRANT ALL ON TABLE multiyear_annual_all_avgsummerairtemp TO rwspicer;
GRANT SELECT ON TABLE multiyear_annual_all_avgsummerairtemp TO imiq_reader;


--
-- Name: multiyear_annual_all_avgsummerdischarge; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE multiyear_annual_all_avgsummerdischarge FROM PUBLIC;
REVOKE ALL ON TABLE multiyear_annual_all_avgsummerdischarge FROM imiq;
GRANT ALL ON TABLE multiyear_annual_all_avgsummerdischarge TO imiq;
GRANT ALL ON TABLE multiyear_annual_all_avgsummerdischarge TO asjacobs;
GRANT ALL ON TABLE multiyear_annual_all_avgsummerdischarge TO chaase;
GRANT ALL ON TABLE multiyear_annual_all_avgsummerdischarge TO rwspicer;
GRANT SELECT ON TABLE multiyear_annual_all_avgsummerdischarge TO imiq_reader;


--
-- Name: multiyear_annual_all_avgsummerprecip; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE multiyear_annual_all_avgsummerprecip FROM PUBLIC;
REVOKE ALL ON TABLE multiyear_annual_all_avgsummerprecip FROM imiq;
GRANT ALL ON TABLE multiyear_annual_all_avgsummerprecip TO imiq;
GRANT ALL ON TABLE multiyear_annual_all_avgsummerprecip TO asjacobs;
GRANT ALL ON TABLE multiyear_annual_all_avgsummerprecip TO chaase;
GRANT ALL ON TABLE multiyear_annual_all_avgsummerprecip TO rwspicer;
GRANT SELECT ON TABLE multiyear_annual_all_avgsummerprecip TO imiq_reader;


--
-- Name: multiyear_annual_all_avgsummerrh; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE multiyear_annual_all_avgsummerrh FROM PUBLIC;
REVOKE ALL ON TABLE multiyear_annual_all_avgsummerrh FROM imiq;
GRANT ALL ON TABLE multiyear_annual_all_avgsummerrh TO imiq;
GRANT ALL ON TABLE multiyear_annual_all_avgsummerrh TO asjacobs;
GRANT ALL ON TABLE multiyear_annual_all_avgsummerrh TO chaase;
GRANT ALL ON TABLE multiyear_annual_all_avgsummerrh TO rwspicer;
GRANT SELECT ON TABLE multiyear_annual_all_avgsummerrh TO imiq_reader;


--
-- Name: multiyear_annual_all_avgwinterairtemp; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE multiyear_annual_all_avgwinterairtemp FROM PUBLIC;
REVOKE ALL ON TABLE multiyear_annual_all_avgwinterairtemp FROM imiq;
GRANT ALL ON TABLE multiyear_annual_all_avgwinterairtemp TO imiq;
GRANT ALL ON TABLE multiyear_annual_all_avgwinterairtemp TO asjacobs;
GRANT ALL ON TABLE multiyear_annual_all_avgwinterairtemp TO chaase;
GRANT ALL ON TABLE multiyear_annual_all_avgwinterairtemp TO rwspicer;
GRANT SELECT ON TABLE multiyear_annual_all_avgwinterairtemp TO imiq_reader;


--
-- Name: multiyear_annual_all_avgwinterprecip; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE multiyear_annual_all_avgwinterprecip FROM PUBLIC;
REVOKE ALL ON TABLE multiyear_annual_all_avgwinterprecip FROM imiq;
GRANT ALL ON TABLE multiyear_annual_all_avgwinterprecip TO imiq;
GRANT ALL ON TABLE multiyear_annual_all_avgwinterprecip TO asjacobs;
GRANT ALL ON TABLE multiyear_annual_all_avgwinterprecip TO chaase;
GRANT ALL ON TABLE multiyear_annual_all_avgwinterprecip TO rwspicer;
GRANT SELECT ON TABLE multiyear_annual_all_avgwinterprecip TO imiq_reader;


--
-- Name: multiyear_annual_all_avgwinterrh; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE multiyear_annual_all_avgwinterrh FROM PUBLIC;
REVOKE ALL ON TABLE multiyear_annual_all_avgwinterrh FROM imiq;
GRANT ALL ON TABLE multiyear_annual_all_avgwinterrh TO imiq;
GRANT ALL ON TABLE multiyear_annual_all_avgwinterrh TO asjacobs;
GRANT ALL ON TABLE multiyear_annual_all_avgwinterrh TO chaase;
GRANT ALL ON TABLE multiyear_annual_all_avgwinterrh TO rwspicer;
GRANT SELECT ON TABLE multiyear_annual_all_avgwinterrh TO imiq_reader;


--
-- Name: networkdescriptions; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE networkdescriptions FROM PUBLIC;
REVOKE ALL ON TABLE networkdescriptions FROM imiq;
GRANT ALL ON TABLE networkdescriptions TO imiq;
GRANT ALL ON TABLE networkdescriptions TO asjacobs;
GRANT ALL ON TABLE networkdescriptions TO chaase;
GRANT ALL ON TABLE networkdescriptions TO rwspicer;
GRANT SELECT ON TABLE networkdescriptions TO imiq_reader;


--
-- Name: nhd_huc8; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE nhd_huc8 FROM PUBLIC;
REVOKE ALL ON TABLE nhd_huc8 FROM imiq;
GRANT ALL ON TABLE nhd_huc8 TO imiq;
GRANT ALL ON TABLE nhd_huc8 TO asjacobs;
GRANT ALL ON TABLE nhd_huc8 TO chaase;
GRANT ALL ON TABLE nhd_huc8 TO rwspicer;
GRANT SELECT ON TABLE nhd_huc8 TO imiq_reader;


--
-- Name: offsettypes; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE offsettypes FROM PUBLIC;
REVOKE ALL ON TABLE offsettypes FROM imiq;
GRANT ALL ON TABLE offsettypes TO imiq;
GRANT ALL ON TABLE offsettypes TO asjacobs;
GRANT ALL ON TABLE offsettypes TO chaase;
GRANT ALL ON TABLE offsettypes TO rwspicer;
GRANT SELECT ON TABLE offsettypes TO imiq_reader;


--
-- Name: organizationdescriptions; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE organizationdescriptions FROM PUBLIC;
REVOKE ALL ON TABLE organizationdescriptions FROM imiq;
GRANT ALL ON TABLE organizationdescriptions TO imiq;
GRANT ALL ON TABLE organizationdescriptions TO asjacobs;
GRANT ALL ON TABLE organizationdescriptions TO chaase;
GRANT ALL ON TABLE organizationdescriptions TO rwspicer;
GRANT SELECT ON TABLE organizationdescriptions TO imiq_reader;


--
-- Name: organizations; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE organizations FROM PUBLIC;
REVOKE ALL ON TABLE organizations FROM imiq;
GRANT ALL ON TABLE organizations TO imiq;
GRANT ALL ON TABLE organizations TO asjacobs;
GRANT ALL ON TABLE organizations TO chaase;
GRANT ALL ON TABLE organizations TO rwspicer;
GRANT SELECT ON TABLE organizations TO imiq_reader;


--
-- Name: processing; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE processing FROM PUBLIC;
REVOKE ALL ON TABLE processing FROM imiq;
GRANT ALL ON TABLE processing TO imiq;
GRANT ALL ON TABLE processing TO asjacobs;
GRANT ALL ON TABLE processing TO chaase;
GRANT ALL ON TABLE processing TO rwspicer;
GRANT SELECT ON TABLE processing TO imiq_reader;


--
-- Name: qualifiers; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE qualifiers FROM PUBLIC;
REVOKE ALL ON TABLE qualifiers FROM imiq;
GRANT ALL ON TABLE qualifiers TO imiq;
GRANT ALL ON TABLE qualifiers TO asjacobs;
GRANT ALL ON TABLE qualifiers TO chaase;
GRANT ALL ON TABLE qualifiers TO rwspicer;
GRANT SELECT ON TABLE qualifiers TO imiq_reader;


--
-- Name: qualitycontrollevels; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE qualitycontrollevels FROM PUBLIC;
REVOKE ALL ON TABLE qualitycontrollevels FROM imiq;
GRANT ALL ON TABLE qualitycontrollevels TO imiq;
GRANT ALL ON TABLE qualitycontrollevels TO asjacobs;
GRANT ALL ON TABLE qualitycontrollevels TO chaase;
GRANT ALL ON TABLE qualitycontrollevels TO rwspicer;
GRANT SELECT ON TABLE qualitycontrollevels TO imiq_reader;


--
-- Name: rasterdatavalues; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE rasterdatavalues FROM PUBLIC;
REVOKE ALL ON TABLE rasterdatavalues FROM imiq;
GRANT ALL ON TABLE rasterdatavalues TO imiq;
GRANT ALL ON TABLE rasterdatavalues TO asjacobs;
GRANT ALL ON TABLE rasterdatavalues TO chaase;
GRANT ALL ON TABLE rasterdatavalues TO rwspicer;
GRANT SELECT ON TABLE rasterdatavalues TO imiq_reader;


--
-- Name: samplemediumcv; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE samplemediumcv FROM PUBLIC;
REVOKE ALL ON TABLE samplemediumcv FROM imiq;
GRANT ALL ON TABLE samplemediumcv TO imiq;
GRANT ALL ON TABLE samplemediumcv TO asjacobs;
GRANT ALL ON TABLE samplemediumcv TO chaase;
GRANT ALL ON TABLE samplemediumcv TO rwspicer;
GRANT SELECT ON TABLE samplemediumcv TO imiq_reader;


--
-- Name: seriescatalog; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE seriescatalog FROM PUBLIC;
REVOKE ALL ON TABLE seriescatalog FROM imiq;
GRANT ALL ON TABLE seriescatalog TO imiq;
GRANT ALL ON TABLE seriescatalog TO asjacobs;
GRANT ALL ON TABLE seriescatalog TO chaase;
GRANT ALL ON TABLE seriescatalog TO rwspicer;
GRANT SELECT ON TABLE seriescatalog TO imiq_reader;


--
-- Name: siteattributes; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE siteattributes FROM PUBLIC;
REVOKE ALL ON TABLE siteattributes FROM imiq;
GRANT ALL ON TABLE siteattributes TO imiq;
GRANT ALL ON TABLE siteattributes TO asjacobs;
GRANT ALL ON TABLE siteattributes TO chaase;
GRANT ALL ON TABLE siteattributes TO rwspicer;
GRANT SELECT ON TABLE siteattributes TO imiq_reader;


--
-- Name: sites; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE sites FROM PUBLIC;
REVOKE ALL ON TABLE sites FROM imiq;
GRANT ALL ON TABLE sites TO imiq;
GRANT ALL ON TABLE sites TO asjacobs;
GRANT ALL ON TABLE sites TO chaase;
GRANT ALL ON TABLE sites TO rwspicer;
GRANT SELECT ON TABLE sites TO imiq_reader;


--
-- Name: sites_siteid_seq; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON SEQUENCE sites_siteid_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE sites_siteid_seq FROM imiq;
GRANT ALL ON SEQUENCE sites_siteid_seq TO imiq;
GRANT USAGE ON SEQUENCE sites_siteid_seq TO chaase;


--
-- Name: sites_sourceid_164; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE sites_sourceid_164 FROM PUBLIC;
REVOKE ALL ON TABLE sites_sourceid_164 FROM imiq;
GRANT ALL ON TABLE sites_sourceid_164 TO imiq;
GRANT ALL ON TABLE sites_sourceid_164 TO asjacobs;
GRANT ALL ON TABLE sites_sourceid_164 TO chaase;
GRANT ALL ON TABLE sites_sourceid_164 TO rwspicer;
GRANT SELECT ON TABLE sites_sourceid_164 TO imiq_reader;


--
-- Name: sources; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE sources FROM PUBLIC;
REVOKE ALL ON TABLE sources FROM imiq;
GRANT ALL ON TABLE sources TO imiq;
GRANT ALL ON TABLE sources TO asjacobs;
GRANT ALL ON TABLE sources TO chaase;
GRANT ALL ON TABLE sources TO rwspicer;
GRANT SELECT ON TABLE sources TO imiq_reader;


--
-- Name: spatialreferences; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE spatialreferences FROM PUBLIC;
REVOKE ALL ON TABLE spatialreferences FROM imiq;
GRANT ALL ON TABLE spatialreferences TO imiq;
GRANT ALL ON TABLE spatialreferences TO asjacobs;
GRANT ALL ON TABLE spatialreferences TO chaase;
GRANT ALL ON TABLE spatialreferences TO rwspicer;
GRANT SELECT ON TABLE spatialreferences TO imiq_reader;


--
-- Name: speciationcv; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE speciationcv FROM PUBLIC;
REVOKE ALL ON TABLE speciationcv FROM imiq;
GRANT ALL ON TABLE speciationcv TO imiq;
GRANT ALL ON TABLE speciationcv TO asjacobs;
GRANT ALL ON TABLE speciationcv TO chaase;
GRANT ALL ON TABLE speciationcv TO rwspicer;
GRANT SELECT ON TABLE speciationcv TO imiq_reader;


--
-- Name: sysdiagrams; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE sysdiagrams FROM PUBLIC;
REVOKE ALL ON TABLE sysdiagrams FROM imiq;
GRANT ALL ON TABLE sysdiagrams TO imiq;
GRANT ALL ON TABLE sysdiagrams TO asjacobs;
GRANT ALL ON TABLE sysdiagrams TO chaase;
GRANT ALL ON TABLE sysdiagrams TO rwspicer;
GRANT SELECT ON TABLE sysdiagrams TO imiq_reader;


--
-- Name: topiccategorycv; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE topiccategorycv FROM PUBLIC;
REVOKE ALL ON TABLE topiccategorycv FROM imiq;
GRANT ALL ON TABLE topiccategorycv TO imiq;
GRANT ALL ON TABLE topiccategorycv TO asjacobs;
GRANT ALL ON TABLE topiccategorycv TO chaase;
GRANT ALL ON TABLE topiccategorycv TO rwspicer;
GRANT SELECT ON TABLE topiccategorycv TO imiq_reader;


--
-- Name: units; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE units FROM PUBLIC;
REVOKE ALL ON TABLE units FROM imiq;
GRANT ALL ON TABLE units TO imiq;
GRANT ALL ON TABLE units TO asjacobs;
GRANT ALL ON TABLE units TO chaase;
GRANT ALL ON TABLE units TO rwspicer;
GRANT SELECT ON TABLE units TO imiq_reader;


--
-- Name: valuetypecv; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE valuetypecv FROM PUBLIC;
REVOKE ALL ON TABLE valuetypecv FROM imiq;
GRANT ALL ON TABLE valuetypecv TO imiq;
GRANT ALL ON TABLE valuetypecv TO asjacobs;
GRANT ALL ON TABLE valuetypecv TO chaase;
GRANT ALL ON TABLE valuetypecv TO rwspicer;
GRANT SELECT ON TABLE valuetypecv TO imiq_reader;


--
-- Name: variablenamecv; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE variablenamecv FROM PUBLIC;
REVOKE ALL ON TABLE variablenamecv FROM imiq;
GRANT ALL ON TABLE variablenamecv TO imiq;
GRANT ALL ON TABLE variablenamecv TO asjacobs;
GRANT ALL ON TABLE variablenamecv TO chaase;
GRANT ALL ON TABLE variablenamecv TO rwspicer;
GRANT SELECT ON TABLE variablenamecv TO imiq_reader;


--
-- Name: variables; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE variables FROM PUBLIC;
REVOKE ALL ON TABLE variables FROM imiq;
GRANT ALL ON TABLE variables TO imiq;
GRANT ALL ON TABLE variables TO asjacobs;
GRANT ALL ON TABLE variables TO chaase;
GRANT ALL ON TABLE variables TO rwspicer;
GRANT SELECT ON TABLE variables TO imiq_reader;


--
-- Name: verticaldatumcv; Type: ACL; Schema: tables; Owner: imiq
--

REVOKE ALL ON TABLE verticaldatumcv FROM PUBLIC;
REVOKE ALL ON TABLE verticaldatumcv FROM imiq;
GRANT ALL ON TABLE verticaldatumcv TO imiq;
GRANT ALL ON TABLE verticaldatumcv TO asjacobs;
GRANT ALL ON TABLE verticaldatumcv TO chaase;
GRANT ALL ON TABLE verticaldatumcv TO rwspicer;
GRANT SELECT ON TABLE verticaldatumcv TO imiq_reader;


SET search_path = views, pg_catalog;

--
-- Name: annual_avgairtemp; Type: ACL; Schema: views; Owner: imiq
--

REVOKE ALL ON TABLE annual_avgairtemp FROM PUBLIC;
REVOKE ALL ON TABLE annual_avgairtemp FROM imiq;
GRANT ALL ON TABLE annual_avgairtemp TO imiq;
GRANT ALL ON TABLE annual_avgairtemp TO asjacobs;
GRANT ALL ON TABLE annual_avgairtemp TO chaase;
GRANT ALL ON TABLE annual_avgairtemp TO rwspicer;
GRANT SELECT ON TABLE annual_avgairtemp TO imiq_reader;


--
-- Name: annual_avgdischarge; Type: ACL; Schema: views; Owner: imiq
--

REVOKE ALL ON TABLE annual_avgdischarge FROM PUBLIC;
REVOKE ALL ON TABLE annual_avgdischarge FROM imiq;
GRANT ALL ON TABLE annual_avgdischarge TO imiq;
GRANT ALL ON TABLE annual_avgdischarge TO asjacobs;
GRANT ALL ON TABLE annual_avgdischarge TO chaase;
GRANT ALL ON TABLE annual_avgdischarge TO rwspicer;
GRANT SELECT ON TABLE annual_avgdischarge TO imiq_reader;


--
-- Name: annual_avgfallairtemp; Type: ACL; Schema: views; Owner: imiq
--

REVOKE ALL ON TABLE annual_avgfallairtemp FROM PUBLIC;
REVOKE ALL ON TABLE annual_avgfallairtemp FROM imiq;
GRANT ALL ON TABLE annual_avgfallairtemp TO imiq;
GRANT ALL ON TABLE annual_avgfallairtemp TO asjacobs;
GRANT ALL ON TABLE annual_avgfallairtemp TO chaase;
GRANT ALL ON TABLE annual_avgfallairtemp TO rwspicer;
GRANT SELECT ON TABLE annual_avgfallairtemp TO imiq_reader;


--
-- Name: annual_avgfallairtemp_all; Type: ACL; Schema: views; Owner: imiq
--

REVOKE ALL ON TABLE annual_avgfallairtemp_all FROM PUBLIC;
REVOKE ALL ON TABLE annual_avgfallairtemp_all FROM imiq;
GRANT ALL ON TABLE annual_avgfallairtemp_all TO imiq;
GRANT ALL ON TABLE annual_avgfallairtemp_all TO asjacobs;
GRANT ALL ON TABLE annual_avgfallairtemp_all TO chaase;
GRANT ALL ON TABLE annual_avgfallairtemp_all TO rwspicer;
GRANT SELECT ON TABLE annual_avgfallairtemp_all TO imiq_reader;


--
-- Name: annual_avgfallprecip; Type: ACL; Schema: views; Owner: imiq
--

REVOKE ALL ON TABLE annual_avgfallprecip FROM PUBLIC;
REVOKE ALL ON TABLE annual_avgfallprecip FROM imiq;
GRANT ALL ON TABLE annual_avgfallprecip TO imiq;
GRANT ALL ON TABLE annual_avgfallprecip TO asjacobs;
GRANT ALL ON TABLE annual_avgfallprecip TO chaase;
GRANT ALL ON TABLE annual_avgfallprecip TO rwspicer;
GRANT SELECT ON TABLE annual_avgfallprecip TO imiq_reader;


--
-- Name: annual_avgfallprecip_all; Type: ACL; Schema: views; Owner: imiq
--

REVOKE ALL ON TABLE annual_avgfallprecip_all FROM PUBLIC;
REVOKE ALL ON TABLE annual_avgfallprecip_all FROM imiq;
GRANT ALL ON TABLE annual_avgfallprecip_all TO imiq;
GRANT ALL ON TABLE annual_avgfallprecip_all TO asjacobs;
GRANT ALL ON TABLE annual_avgfallprecip_all TO chaase;
GRANT ALL ON TABLE annual_avgfallprecip_all TO rwspicer;
GRANT SELECT ON TABLE annual_avgfallprecip_all TO imiq_reader;


--
-- Name: annual_avgrh; Type: ACL; Schema: views; Owner: imiq
--

REVOKE ALL ON TABLE annual_avgrh FROM PUBLIC;
REVOKE ALL ON TABLE annual_avgrh FROM imiq;
GRANT ALL ON TABLE annual_avgrh TO imiq;
GRANT ALL ON TABLE annual_avgrh TO asjacobs;
GRANT ALL ON TABLE annual_avgrh TO chaase;
GRANT ALL ON TABLE annual_avgrh TO rwspicer;
GRANT SELECT ON TABLE annual_avgrh TO imiq_reader;


--
-- Name: annual_avgspringairtemp; Type: ACL; Schema: views; Owner: imiq
--

REVOKE ALL ON TABLE annual_avgspringairtemp FROM PUBLIC;
REVOKE ALL ON TABLE annual_avgspringairtemp FROM imiq;
GRANT ALL ON TABLE annual_avgspringairtemp TO imiq;
GRANT ALL ON TABLE annual_avgspringairtemp TO asjacobs;
GRANT ALL ON TABLE annual_avgspringairtemp TO chaase;
GRANT ALL ON TABLE annual_avgspringairtemp TO rwspicer;
GRANT SELECT ON TABLE annual_avgspringairtemp TO imiq_reader;


--
-- Name: annual_avgspringairtemp_all; Type: ACL; Schema: views; Owner: imiq
--

REVOKE ALL ON TABLE annual_avgspringairtemp_all FROM PUBLIC;
REVOKE ALL ON TABLE annual_avgspringairtemp_all FROM imiq;
GRANT ALL ON TABLE annual_avgspringairtemp_all TO imiq;
GRANT ALL ON TABLE annual_avgspringairtemp_all TO asjacobs;
GRANT ALL ON TABLE annual_avgspringairtemp_all TO chaase;
GRANT ALL ON TABLE annual_avgspringairtemp_all TO rwspicer;
GRANT SELECT ON TABLE annual_avgspringairtemp_all TO imiq_reader;


--
-- Name: annual_avgspringprecip; Type: ACL; Schema: views; Owner: imiq
--

REVOKE ALL ON TABLE annual_avgspringprecip FROM PUBLIC;
REVOKE ALL ON TABLE annual_avgspringprecip FROM imiq;
GRANT ALL ON TABLE annual_avgspringprecip TO imiq;
GRANT ALL ON TABLE annual_avgspringprecip TO asjacobs;
GRANT ALL ON TABLE annual_avgspringprecip TO chaase;
GRANT ALL ON TABLE annual_avgspringprecip TO rwspicer;
GRANT SELECT ON TABLE annual_avgspringprecip TO imiq_reader;


--
-- Name: annual_avgspringprecip_all; Type: ACL; Schema: views; Owner: imiq
--

REVOKE ALL ON TABLE annual_avgspringprecip_all FROM PUBLIC;
REVOKE ALL ON TABLE annual_avgspringprecip_all FROM imiq;
GRANT ALL ON TABLE annual_avgspringprecip_all TO imiq;
GRANT ALL ON TABLE annual_avgspringprecip_all TO asjacobs;
GRANT ALL ON TABLE annual_avgspringprecip_all TO chaase;
GRANT ALL ON TABLE annual_avgspringprecip_all TO rwspicer;
GRANT SELECT ON TABLE annual_avgspringprecip_all TO imiq_reader;


--
-- Name: annual_avgsummerairtemp; Type: ACL; Schema: views; Owner: imiq
--

REVOKE ALL ON TABLE annual_avgsummerairtemp FROM PUBLIC;
REVOKE ALL ON TABLE annual_avgsummerairtemp FROM imiq;
GRANT ALL ON TABLE annual_avgsummerairtemp TO imiq;
GRANT ALL ON TABLE annual_avgsummerairtemp TO asjacobs;
GRANT ALL ON TABLE annual_avgsummerairtemp TO chaase;
GRANT ALL ON TABLE annual_avgsummerairtemp TO rwspicer;
GRANT SELECT ON TABLE annual_avgsummerairtemp TO imiq_reader;


--
-- Name: annual_avgsummerairtemp_all; Type: ACL; Schema: views; Owner: imiq
--

REVOKE ALL ON TABLE annual_avgsummerairtemp_all FROM PUBLIC;
REVOKE ALL ON TABLE annual_avgsummerairtemp_all FROM imiq;
GRANT ALL ON TABLE annual_avgsummerairtemp_all TO imiq;
GRANT ALL ON TABLE annual_avgsummerairtemp_all TO asjacobs;
GRANT ALL ON TABLE annual_avgsummerairtemp_all TO chaase;
GRANT ALL ON TABLE annual_avgsummerairtemp_all TO rwspicer;
GRANT SELECT ON TABLE annual_avgsummerairtemp_all TO imiq_reader;


--
-- Name: annual_avgsummerdischarge; Type: ACL; Schema: views; Owner: imiq
--

REVOKE ALL ON TABLE annual_avgsummerdischarge FROM PUBLIC;
REVOKE ALL ON TABLE annual_avgsummerdischarge FROM imiq;
GRANT ALL ON TABLE annual_avgsummerdischarge TO imiq;
GRANT ALL ON TABLE annual_avgsummerdischarge TO asjacobs;
GRANT ALL ON TABLE annual_avgsummerdischarge TO chaase;
GRANT ALL ON TABLE annual_avgsummerdischarge TO rwspicer;
GRANT SELECT ON TABLE annual_avgsummerdischarge TO imiq_reader;


--
-- Name: annual_avgsummerdischarge_all; Type: ACL; Schema: views; Owner: imiq
--

REVOKE ALL ON TABLE annual_avgsummerdischarge_all FROM PUBLIC;
REVOKE ALL ON TABLE annual_avgsummerdischarge_all FROM imiq;
GRANT ALL ON TABLE annual_avgsummerdischarge_all TO imiq;
GRANT ALL ON TABLE annual_avgsummerdischarge_all TO asjacobs;
GRANT ALL ON TABLE annual_avgsummerdischarge_all TO chaase;
GRANT ALL ON TABLE annual_avgsummerdischarge_all TO rwspicer;
GRANT SELECT ON TABLE annual_avgsummerdischarge_all TO imiq_reader;


--
-- Name: annual_avgsummerprecip; Type: ACL; Schema: views; Owner: imiq
--

REVOKE ALL ON TABLE annual_avgsummerprecip FROM PUBLIC;
REVOKE ALL ON TABLE annual_avgsummerprecip FROM imiq;
GRANT ALL ON TABLE annual_avgsummerprecip TO imiq;
GRANT ALL ON TABLE annual_avgsummerprecip TO asjacobs;
GRANT ALL ON TABLE annual_avgsummerprecip TO chaase;
GRANT ALL ON TABLE annual_avgsummerprecip TO rwspicer;
GRANT SELECT ON TABLE annual_avgsummerprecip TO imiq_reader;


--
-- Name: annual_avgsummerprecip_all; Type: ACL; Schema: views; Owner: imiq
--

REVOKE ALL ON TABLE annual_avgsummerprecip_all FROM PUBLIC;
REVOKE ALL ON TABLE annual_avgsummerprecip_all FROM imiq;
GRANT ALL ON TABLE annual_avgsummerprecip_all TO imiq;
GRANT ALL ON TABLE annual_avgsummerprecip_all TO asjacobs;
GRANT ALL ON TABLE annual_avgsummerprecip_all TO chaase;
GRANT ALL ON TABLE annual_avgsummerprecip_all TO rwspicer;
GRANT SELECT ON TABLE annual_avgsummerprecip_all TO imiq_reader;


--
-- Name: annual_avgsummerrh; Type: ACL; Schema: views; Owner: imiq
--

REVOKE ALL ON TABLE annual_avgsummerrh FROM PUBLIC;
REVOKE ALL ON TABLE annual_avgsummerrh FROM imiq;
GRANT ALL ON TABLE annual_avgsummerrh TO imiq;
GRANT ALL ON TABLE annual_avgsummerrh TO asjacobs;
GRANT ALL ON TABLE annual_avgsummerrh TO chaase;
GRANT ALL ON TABLE annual_avgsummerrh TO rwspicer;
GRANT SELECT ON TABLE annual_avgsummerrh TO imiq_reader;


--
-- Name: annual_avgsummerrh_all; Type: ACL; Schema: views; Owner: imiq
--

REVOKE ALL ON TABLE annual_avgsummerrh_all FROM PUBLIC;
REVOKE ALL ON TABLE annual_avgsummerrh_all FROM imiq;
GRANT ALL ON TABLE annual_avgsummerrh_all TO imiq;
GRANT ALL ON TABLE annual_avgsummerrh_all TO asjacobs;
GRANT ALL ON TABLE annual_avgsummerrh_all TO chaase;
GRANT ALL ON TABLE annual_avgsummerrh_all TO rwspicer;
GRANT SELECT ON TABLE annual_avgsummerrh_all TO imiq_reader;


--
-- Name: annual_avgwinterairtemp; Type: ACL; Schema: views; Owner: imiq
--

REVOKE ALL ON TABLE annual_avgwinterairtemp FROM PUBLIC;
REVOKE ALL ON TABLE annual_avgwinterairtemp FROM imiq;
GRANT ALL ON TABLE annual_avgwinterairtemp TO imiq;
GRANT ALL ON TABLE annual_avgwinterairtemp TO asjacobs;
GRANT ALL ON TABLE annual_avgwinterairtemp TO chaase;
GRANT ALL ON TABLE annual_avgwinterairtemp TO rwspicer;
GRANT SELECT ON TABLE annual_avgwinterairtemp TO imiq_reader;


--
-- Name: annual_avgwinterprecip; Type: ACL; Schema: views; Owner: imiq
--

REVOKE ALL ON TABLE annual_avgwinterprecip FROM PUBLIC;
REVOKE ALL ON TABLE annual_avgwinterprecip FROM imiq;
GRANT ALL ON TABLE annual_avgwinterprecip TO imiq;
GRANT ALL ON TABLE annual_avgwinterprecip TO asjacobs;
GRANT ALL ON TABLE annual_avgwinterprecip TO chaase;
GRANT ALL ON TABLE annual_avgwinterprecip TO rwspicer;
GRANT SELECT ON TABLE annual_avgwinterprecip TO imiq_reader;


--
-- Name: annual_avgwinterrh; Type: ACL; Schema: views; Owner: imiq
--

REVOKE ALL ON TABLE annual_avgwinterrh FROM PUBLIC;
REVOKE ALL ON TABLE annual_avgwinterrh FROM imiq;
GRANT ALL ON TABLE annual_avgwinterrh TO imiq;
GRANT ALL ON TABLE annual_avgwinterrh TO asjacobs;
GRANT ALL ON TABLE annual_avgwinterrh TO chaase;
GRANT ALL ON TABLE annual_avgwinterrh TO rwspicer;
GRANT SELECT ON TABLE annual_avgwinterrh TO imiq_reader;


--
-- Name: annual_peakdischarge; Type: ACL; Schema: views; Owner: imiq
--

REVOKE ALL ON TABLE annual_peakdischarge FROM PUBLIC;
REVOKE ALL ON TABLE annual_peakdischarge FROM imiq;
GRANT ALL ON TABLE annual_peakdischarge TO imiq;
GRANT ALL ON TABLE annual_peakdischarge TO asjacobs;
GRANT ALL ON TABLE annual_peakdischarge TO chaase;
GRANT ALL ON TABLE annual_peakdischarge TO rwspicer;
GRANT SELECT ON TABLE annual_peakdischarge TO imiq_reader;


--
-- Name: annual_peaksnowdepth; Type: ACL; Schema: views; Owner: imiq
--

REVOKE ALL ON TABLE annual_peaksnowdepth FROM PUBLIC;
REVOKE ALL ON TABLE annual_peaksnowdepth FROM imiq;
GRANT ALL ON TABLE annual_peaksnowdepth TO imiq;
GRANT ALL ON TABLE annual_peaksnowdepth TO asjacobs;
GRANT ALL ON TABLE annual_peaksnowdepth TO chaase;
GRANT ALL ON TABLE annual_peaksnowdepth TO rwspicer;
GRANT SELECT ON TABLE annual_peaksnowdepth TO imiq_reader;


--
-- Name: annual_peakswe; Type: ACL; Schema: views; Owner: imiq
--

REVOKE ALL ON TABLE annual_peakswe FROM PUBLIC;
REVOKE ALL ON TABLE annual_peakswe FROM imiq;
GRANT ALL ON TABLE annual_peakswe TO imiq;
GRANT ALL ON TABLE annual_peakswe TO asjacobs;
GRANT ALL ON TABLE annual_peakswe TO chaase;
GRANT ALL ON TABLE annual_peakswe TO rwspicer;
GRANT SELECT ON TABLE annual_peakswe TO imiq_reader;


--
-- Name: annual_totalprecip; Type: ACL; Schema: views; Owner: imiq
--

REVOKE ALL ON TABLE annual_totalprecip FROM PUBLIC;
REVOKE ALL ON TABLE annual_totalprecip FROM imiq;
GRANT ALL ON TABLE annual_totalprecip TO imiq;
GRANT ALL ON TABLE annual_totalprecip TO asjacobs;
GRANT ALL ON TABLE annual_totalprecip TO chaase;
GRANT ALL ON TABLE annual_totalprecip TO rwspicer;
GRANT SELECT ON TABLE annual_totalprecip TO imiq_reader;


--
-- Name: boundarycatalog; Type: ACL; Schema: views; Owner: imiq
--

REVOKE ALL ON TABLE boundarycatalog FROM PUBLIC;
REVOKE ALL ON TABLE boundarycatalog FROM imiq;
GRANT ALL ON TABLE boundarycatalog TO imiq;
GRANT ALL ON TABLE boundarycatalog TO asjacobs;
GRANT ALL ON TABLE boundarycatalog TO chaase;
GRANT ALL ON TABLE boundarycatalog TO rwspicer;
GRANT SELECT ON TABLE boundarycatalog TO imiq_reader;


--
-- Name: daily_airtemp; Type: ACL; Schema: views; Owner: imiq
--

REVOKE ALL ON TABLE daily_airtemp FROM PUBLIC;
REVOKE ALL ON TABLE daily_airtemp FROM imiq;
GRANT ALL ON TABLE daily_airtemp TO imiq;
GRANT ALL ON TABLE daily_airtemp TO asjacobs;
GRANT ALL ON TABLE daily_airtemp TO chaase;
GRANT ALL ON TABLE daily_airtemp TO rwspicer;
GRANT SELECT ON TABLE daily_airtemp TO imiq_reader;


--
-- Name: daily_airtempmax; Type: ACL; Schema: views; Owner: imiq
--

REVOKE ALL ON TABLE daily_airtempmax FROM PUBLIC;
REVOKE ALL ON TABLE daily_airtempmax FROM imiq;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRUNCATE,UPDATE ON TABLE daily_airtempmax TO imiq;
GRANT TRIGGER ON TABLE daily_airtempmax TO imiq WITH GRANT OPTION;
GRANT ALL ON TABLE daily_airtempmax TO asjacobs;
GRANT ALL ON TABLE daily_airtempmax TO chaase;
GRANT ALL ON TABLE daily_airtempmax TO rwspicer;
GRANT SELECT ON TABLE daily_airtempmax TO imiq_reader;


--
-- Name: daily_airtempmin; Type: ACL; Schema: views; Owner: imiq
--

REVOKE ALL ON TABLE daily_airtempmin FROM PUBLIC;
REVOKE ALL ON TABLE daily_airtempmin FROM imiq;
GRANT ALL ON TABLE daily_airtempmin TO imiq;
GRANT ALL ON TABLE daily_airtempmin TO asjacobs;
GRANT ALL ON TABLE daily_airtempmin TO chaase;
GRANT ALL ON TABLE daily_airtempmin TO rwspicer;
GRANT SELECT ON TABLE daily_airtempmin TO imiq_reader;


--
-- Name: daily_discharge; Type: ACL; Schema: views; Owner: imiq
--

REVOKE ALL ON TABLE daily_discharge FROM PUBLIC;
REVOKE ALL ON TABLE daily_discharge FROM imiq;
GRANT ALL ON TABLE daily_discharge TO imiq;
GRANT ALL ON TABLE daily_discharge TO asjacobs;
GRANT ALL ON TABLE daily_discharge TO chaase;
GRANT ALL ON TABLE daily_discharge TO rwspicer;
GRANT SELECT ON TABLE daily_discharge TO imiq_reader;


--
-- Name: daily_rh; Type: ACL; Schema: views; Owner: imiq
--

REVOKE ALL ON TABLE daily_rh FROM PUBLIC;
REVOKE ALL ON TABLE daily_rh FROM imiq;
GRANT ALL ON TABLE daily_rh TO imiq;
GRANT ALL ON TABLE daily_rh TO asjacobs;
GRANT ALL ON TABLE daily_rh TO chaase;
GRANT ALL ON TABLE daily_rh TO rwspicer;
GRANT SELECT ON TABLE daily_rh TO imiq_reader;


--
-- Name: daily_utcdatetime; Type: ACL; Schema: views; Owner: imiq
--

REVOKE ALL ON TABLE daily_utcdatetime FROM PUBLIC;
REVOKE ALL ON TABLE daily_utcdatetime FROM imiq;
GRANT ALL ON TABLE daily_utcdatetime TO imiq;
GRANT ALL ON TABLE daily_utcdatetime TO asjacobs;
GRANT ALL ON TABLE daily_utcdatetime TO chaase;
GRANT ALL ON TABLE daily_utcdatetime TO rwspicer;
GRANT SELECT ON TABLE daily_utcdatetime TO imiq_reader;


--
-- Name: daily_watertemp; Type: ACL; Schema: views; Owner: imiq
--

REVOKE ALL ON TABLE daily_watertemp FROM PUBLIC;
REVOKE ALL ON TABLE daily_watertemp FROM imiq;
GRANT ALL ON TABLE daily_watertemp TO imiq;
GRANT ALL ON TABLE daily_watertemp TO asjacobs;
GRANT ALL ON TABLE daily_watertemp TO chaase;
GRANT ALL ON TABLE daily_watertemp TO rwspicer;
GRANT SELECT ON TABLE daily_watertemp TO imiq_reader;


--
-- Name: daily_winddirection; Type: ACL; Schema: views; Owner: imiq
--

REVOKE ALL ON TABLE daily_winddirection FROM PUBLIC;
REVOKE ALL ON TABLE daily_winddirection FROM imiq;
GRANT ALL ON TABLE daily_winddirection TO imiq;
GRANT ALL ON TABLE daily_winddirection TO asjacobs;
GRANT ALL ON TABLE daily_winddirection TO chaase;
GRANT ALL ON TABLE daily_winddirection TO rwspicer;
GRANT SELECT ON TABLE daily_winddirection TO imiq_reader;


--
-- Name: daily_windspeed; Type: ACL; Schema: views; Owner: imiq
--

REVOKE ALL ON TABLE daily_windspeed FROM PUBLIC;
REVOKE ALL ON TABLE daily_windspeed FROM imiq;
GRANT ALL ON TABLE daily_windspeed TO imiq;
GRANT ALL ON TABLE daily_windspeed TO asjacobs;
GRANT ALL ON TABLE daily_windspeed TO chaase;
GRANT ALL ON TABLE daily_windspeed TO rwspicer;
GRANT SELECT ON TABLE daily_windspeed TO imiq_reader;


--
-- Name: datastreamvariables; Type: ACL; Schema: views; Owner: imiq
--

REVOKE ALL ON TABLE datastreamvariables FROM PUBLIC;
REVOKE ALL ON TABLE datastreamvariables FROM imiq;
GRANT ALL ON TABLE datastreamvariables TO imiq;
GRANT ALL ON TABLE datastreamvariables TO asjacobs;
GRANT ALL ON TABLE datastreamvariables TO chaase;
GRANT ALL ON TABLE datastreamvariables TO rwspicer;
GRANT SELECT ON TABLE datastreamvariables TO imiq_reader;


--
-- Name: datavaluesaggregate; Type: ACL; Schema: views; Owner: imiq
--

REVOKE ALL ON TABLE datavaluesaggregate FROM PUBLIC;
REVOKE ALL ON TABLE datavaluesaggregate FROM imiq;
GRANT ALL ON TABLE datavaluesaggregate TO imiq;
GRANT ALL ON TABLE datavaluesaggregate TO asjacobs;
GRANT ALL ON TABLE datavaluesaggregate TO chaase;
GRANT ALL ON TABLE datavaluesaggregate TO rwspicer;
GRANT SELECT ON TABLE datavaluesaggregate TO imiq_reader;


--
-- Name: hourly_airtemp; Type: ACL; Schema: views; Owner: imiq
--

REVOKE ALL ON TABLE hourly_airtemp FROM PUBLIC;
REVOKE ALL ON TABLE hourly_airtemp FROM imiq;
GRANT ALL ON TABLE hourly_airtemp TO imiq;
GRANT ALL ON TABLE hourly_airtemp TO asjacobs;
GRANT ALL ON TABLE hourly_airtemp TO chaase;
GRANT ALL ON TABLE hourly_airtemp TO rwspicer;
GRANT SELECT ON TABLE hourly_airtemp TO imiq_reader;


--
-- Name: hourly_rh; Type: ACL; Schema: views; Owner: imiq
--

REVOKE ALL ON TABLE hourly_rh FROM PUBLIC;
REVOKE ALL ON TABLE hourly_rh FROM imiq;
GRANT ALL ON TABLE hourly_rh TO imiq;
GRANT ALL ON TABLE hourly_rh TO asjacobs;
GRANT ALL ON TABLE hourly_rh TO chaase;
GRANT ALL ON TABLE hourly_rh TO rwspicer;
GRANT SELECT ON TABLE hourly_rh TO imiq_reader;


--
-- Name: hourly_utcdatetime; Type: ACL; Schema: views; Owner: imiq
--

REVOKE ALL ON TABLE hourly_utcdatetime FROM PUBLIC;
REVOKE ALL ON TABLE hourly_utcdatetime FROM imiq;
GRANT ALL ON TABLE hourly_utcdatetime TO imiq;
GRANT ALL ON TABLE hourly_utcdatetime TO asjacobs;
GRANT ALL ON TABLE hourly_utcdatetime TO chaase;
GRANT ALL ON TABLE hourly_utcdatetime TO rwspicer;
GRANT SELECT ON TABLE hourly_utcdatetime TO imiq_reader;


--
-- Name: hourly_winddirection; Type: ACL; Schema: views; Owner: imiq
--

REVOKE ALL ON TABLE hourly_winddirection FROM PUBLIC;
REVOKE ALL ON TABLE hourly_winddirection FROM imiq;
GRANT ALL ON TABLE hourly_winddirection TO imiq;
GRANT ALL ON TABLE hourly_winddirection TO asjacobs;
GRANT ALL ON TABLE hourly_winddirection TO chaase;
GRANT ALL ON TABLE hourly_winddirection TO rwspicer;
GRANT SELECT ON TABLE hourly_winddirection TO imiq_reader;


--
-- Name: hourly_windspeed; Type: ACL; Schema: views; Owner: imiq
--

REVOKE ALL ON TABLE hourly_windspeed FROM PUBLIC;
REVOKE ALL ON TABLE hourly_windspeed FROM imiq;
GRANT ALL ON TABLE hourly_windspeed TO imiq;
GRANT ALL ON TABLE hourly_windspeed TO asjacobs;
GRANT ALL ON TABLE hourly_windspeed TO chaase;
GRANT ALL ON TABLE hourly_windspeed TO rwspicer;
GRANT SELECT ON TABLE hourly_windspeed TO imiq_reader;


--
-- Name: monthly_airtemp; Type: ACL; Schema: views; Owner: imiq
--

REVOKE ALL ON TABLE monthly_airtemp FROM PUBLIC;
REVOKE ALL ON TABLE monthly_airtemp FROM imiq;
GRANT ALL ON TABLE monthly_airtemp TO imiq;
GRANT ALL ON TABLE monthly_airtemp TO asjacobs;
GRANT ALL ON TABLE monthly_airtemp TO chaase;
GRANT ALL ON TABLE monthly_airtemp TO rwspicer;
GRANT SELECT ON TABLE monthly_airtemp TO imiq_reader;


--
-- Name: monthly_airtemp_all; Type: ACL; Schema: views; Owner: imiq
--

REVOKE ALL ON TABLE monthly_airtemp_all FROM PUBLIC;
REVOKE ALL ON TABLE monthly_airtemp_all FROM imiq;
GRANT ALL ON TABLE monthly_airtemp_all TO imiq;
GRANT ALL ON TABLE monthly_airtemp_all TO asjacobs;
GRANT ALL ON TABLE monthly_airtemp_all TO chaase;
GRANT ALL ON TABLE monthly_airtemp_all TO rwspicer;
GRANT SELECT ON TABLE monthly_airtemp_all TO imiq_reader;


--
-- Name: monthly_discharge; Type: ACL; Schema: views; Owner: imiq
--

REVOKE ALL ON TABLE monthly_discharge FROM PUBLIC;
REVOKE ALL ON TABLE monthly_discharge FROM imiq;
GRANT ALL ON TABLE monthly_discharge TO imiq;
GRANT ALL ON TABLE monthly_discharge TO asjacobs;
GRANT ALL ON TABLE monthly_discharge TO chaase;
GRANT ALL ON TABLE monthly_discharge TO rwspicer;
GRANT SELECT ON TABLE monthly_discharge TO imiq_reader;


--
-- Name: monthly_discharge_all; Type: ACL; Schema: views; Owner: imiq
--

REVOKE ALL ON TABLE monthly_discharge_all FROM PUBLIC;
REVOKE ALL ON TABLE monthly_discharge_all FROM imiq;
GRANT ALL ON TABLE monthly_discharge_all TO imiq;
GRANT ALL ON TABLE monthly_discharge_all TO asjacobs;
GRANT ALL ON TABLE monthly_discharge_all TO chaase;
GRANT ALL ON TABLE monthly_discharge_all TO rwspicer;
GRANT SELECT ON TABLE monthly_discharge_all TO imiq_reader;


--
-- Name: monthly_precip; Type: ACL; Schema: views; Owner: imiq
--

REVOKE ALL ON TABLE monthly_precip FROM PUBLIC;
REVOKE ALL ON TABLE monthly_precip FROM imiq;
GRANT ALL ON TABLE monthly_precip TO imiq;
GRANT ALL ON TABLE monthly_precip TO asjacobs;
GRANT ALL ON TABLE monthly_precip TO chaase;
GRANT ALL ON TABLE monthly_precip TO rwspicer;
GRANT SELECT ON TABLE monthly_precip TO imiq_reader;


--
-- Name: monthly_precip_all; Type: ACL; Schema: views; Owner: imiq
--

REVOKE ALL ON TABLE monthly_precip_all FROM PUBLIC;
REVOKE ALL ON TABLE monthly_precip_all FROM imiq;
GRANT ALL ON TABLE monthly_precip_all TO imiq;
GRANT ALL ON TABLE monthly_precip_all TO asjacobs;
GRANT ALL ON TABLE monthly_precip_all TO chaase;
GRANT ALL ON TABLE monthly_precip_all TO rwspicer;
GRANT SELECT ON TABLE monthly_precip_all TO imiq_reader;


--
-- Name: monthly_rh; Type: ACL; Schema: views; Owner: imiq
--

REVOKE ALL ON TABLE monthly_rh FROM PUBLIC;
REVOKE ALL ON TABLE monthly_rh FROM imiq;
GRANT ALL ON TABLE monthly_rh TO imiq;
GRANT ALL ON TABLE monthly_rh TO asjacobs;
GRANT ALL ON TABLE monthly_rh TO chaase;
GRANT ALL ON TABLE monthly_rh TO rwspicer;
GRANT SELECT ON TABLE monthly_rh TO imiq_reader;


--
-- Name: monthly_snowdepthavg; Type: ACL; Schema: views; Owner: imiq
--

REVOKE ALL ON TABLE monthly_snowdepthavg FROM PUBLIC;
REVOKE ALL ON TABLE monthly_snowdepthavg FROM imiq;
GRANT ALL ON TABLE monthly_snowdepthavg TO imiq;
GRANT ALL ON TABLE monthly_snowdepthavg TO asjacobs;
GRANT ALL ON TABLE monthly_snowdepthavg TO chaase;
GRANT ALL ON TABLE monthly_snowdepthavg TO rwspicer;
GRANT SELECT ON TABLE monthly_snowdepthavg TO imiq_reader;


--
-- Name: monthly_snowdepthavg_all; Type: ACL; Schema: views; Owner: imiq
--

REVOKE ALL ON TABLE monthly_snowdepthavg_all FROM PUBLIC;
REVOKE ALL ON TABLE monthly_snowdepthavg_all FROM imiq;
GRANT ALL ON TABLE monthly_snowdepthavg_all TO imiq;
GRANT ALL ON TABLE monthly_snowdepthavg_all TO asjacobs;
GRANT ALL ON TABLE monthly_snowdepthavg_all TO chaase;
GRANT ALL ON TABLE monthly_snowdepthavg_all TO rwspicer;
GRANT SELECT ON TABLE monthly_snowdepthavg_all TO imiq_reader;


--
-- Name: monthly_sweavg; Type: ACL; Schema: views; Owner: imiq
--

REVOKE ALL ON TABLE monthly_sweavg FROM PUBLIC;
REVOKE ALL ON TABLE monthly_sweavg FROM imiq;
GRANT ALL ON TABLE monthly_sweavg TO imiq;
GRANT ALL ON TABLE monthly_sweavg TO asjacobs;
GRANT ALL ON TABLE monthly_sweavg TO chaase;
GRANT ALL ON TABLE monthly_sweavg TO rwspicer;
GRANT SELECT ON TABLE monthly_sweavg TO imiq_reader;


--
-- Name: monthly_sweavg_all; Type: ACL; Schema: views; Owner: imiq
--

REVOKE ALL ON TABLE monthly_sweavg_all FROM PUBLIC;
REVOKE ALL ON TABLE monthly_sweavg_all FROM imiq;
GRANT ALL ON TABLE monthly_sweavg_all TO imiq;
GRANT ALL ON TABLE monthly_sweavg_all TO asjacobs;
GRANT ALL ON TABLE monthly_sweavg_all TO chaase;
GRANT ALL ON TABLE monthly_sweavg_all TO rwspicer;
GRANT SELECT ON TABLE monthly_sweavg_all TO imiq_reader;


--
-- Name: multiyear_annual_avgairtemp; Type: ACL; Schema: views; Owner: imiq
--

REVOKE ALL ON TABLE multiyear_annual_avgairtemp FROM PUBLIC;
REVOKE ALL ON TABLE multiyear_annual_avgairtemp FROM imiq;
GRANT ALL ON TABLE multiyear_annual_avgairtemp TO imiq;
GRANT ALL ON TABLE multiyear_annual_avgairtemp TO asjacobs;
GRANT ALL ON TABLE multiyear_annual_avgairtemp TO chaase;
GRANT ALL ON TABLE multiyear_annual_avgairtemp TO rwspicer;
GRANT SELECT ON TABLE multiyear_annual_avgairtemp TO imiq_reader;


--
-- Name: multiyear_annual_avgdischarge; Type: ACL; Schema: views; Owner: imiq
--

REVOKE ALL ON TABLE multiyear_annual_avgdischarge FROM PUBLIC;
REVOKE ALL ON TABLE multiyear_annual_avgdischarge FROM imiq;
GRANT ALL ON TABLE multiyear_annual_avgdischarge TO imiq;
GRANT ALL ON TABLE multiyear_annual_avgdischarge TO asjacobs;
GRANT ALL ON TABLE multiyear_annual_avgdischarge TO chaase;
GRANT ALL ON TABLE multiyear_annual_avgdischarge TO rwspicer;
GRANT SELECT ON TABLE multiyear_annual_avgdischarge TO imiq_reader;


--
-- Name: multiyear_annual_avgfallairtemp; Type: ACL; Schema: views; Owner: imiq
--

REVOKE ALL ON TABLE multiyear_annual_avgfallairtemp FROM PUBLIC;
REVOKE ALL ON TABLE multiyear_annual_avgfallairtemp FROM imiq;
GRANT ALL ON TABLE multiyear_annual_avgfallairtemp TO imiq;
GRANT ALL ON TABLE multiyear_annual_avgfallairtemp TO asjacobs;
GRANT ALL ON TABLE multiyear_annual_avgfallairtemp TO chaase;
GRANT ALL ON TABLE multiyear_annual_avgfallairtemp TO rwspicer;
GRANT SELECT ON TABLE multiyear_annual_avgfallairtemp TO imiq_reader;


--
-- Name: multiyear_annual_avgfallprecip; Type: ACL; Schema: views; Owner: imiq
--

REVOKE ALL ON TABLE multiyear_annual_avgfallprecip FROM PUBLIC;
REVOKE ALL ON TABLE multiyear_annual_avgfallprecip FROM imiq;
GRANT ALL ON TABLE multiyear_annual_avgfallprecip TO imiq;
GRANT ALL ON TABLE multiyear_annual_avgfallprecip TO asjacobs;
GRANT ALL ON TABLE multiyear_annual_avgfallprecip TO chaase;
GRANT ALL ON TABLE multiyear_annual_avgfallprecip TO rwspicer;
GRANT SELECT ON TABLE multiyear_annual_avgfallprecip TO imiq_reader;


--
-- Name: multiyear_annual_avgpeakdischarge; Type: ACL; Schema: views; Owner: imiq
--

REVOKE ALL ON TABLE multiyear_annual_avgpeakdischarge FROM PUBLIC;
REVOKE ALL ON TABLE multiyear_annual_avgpeakdischarge FROM imiq;
GRANT ALL ON TABLE multiyear_annual_avgpeakdischarge TO imiq;
GRANT ALL ON TABLE multiyear_annual_avgpeakdischarge TO asjacobs;
GRANT ALL ON TABLE multiyear_annual_avgpeakdischarge TO chaase;
GRANT ALL ON TABLE multiyear_annual_avgpeakdischarge TO rwspicer;
GRANT SELECT ON TABLE multiyear_annual_avgpeakdischarge TO imiq_reader;


--
-- Name: multiyear_annual_avgpeaksnowdepth; Type: ACL; Schema: views; Owner: imiq
--

REVOKE ALL ON TABLE multiyear_annual_avgpeaksnowdepth FROM PUBLIC;
REVOKE ALL ON TABLE multiyear_annual_avgpeaksnowdepth FROM imiq;
GRANT ALL ON TABLE multiyear_annual_avgpeaksnowdepth TO imiq;
GRANT ALL ON TABLE multiyear_annual_avgpeaksnowdepth TO asjacobs;
GRANT ALL ON TABLE multiyear_annual_avgpeaksnowdepth TO chaase;
GRANT ALL ON TABLE multiyear_annual_avgpeaksnowdepth TO rwspicer;
GRANT SELECT ON TABLE multiyear_annual_avgpeaksnowdepth TO imiq_reader;


--
-- Name: multiyear_annual_avgpeakswe; Type: ACL; Schema: views; Owner: imiq
--

REVOKE ALL ON TABLE multiyear_annual_avgpeakswe FROM PUBLIC;
REVOKE ALL ON TABLE multiyear_annual_avgpeakswe FROM imiq;
GRANT ALL ON TABLE multiyear_annual_avgpeakswe TO imiq;
GRANT ALL ON TABLE multiyear_annual_avgpeakswe TO asjacobs;
GRANT ALL ON TABLE multiyear_annual_avgpeakswe TO chaase;
GRANT ALL ON TABLE multiyear_annual_avgpeakswe TO rwspicer;
GRANT SELECT ON TABLE multiyear_annual_avgpeakswe TO imiq_reader;


--
-- Name: multiyear_annual_avgprecip; Type: ACL; Schema: views; Owner: imiq
--

REVOKE ALL ON TABLE multiyear_annual_avgprecip FROM PUBLIC;
REVOKE ALL ON TABLE multiyear_annual_avgprecip FROM imiq;
GRANT ALL ON TABLE multiyear_annual_avgprecip TO imiq;
GRANT ALL ON TABLE multiyear_annual_avgprecip TO asjacobs;
GRANT ALL ON TABLE multiyear_annual_avgprecip TO chaase;
GRANT ALL ON TABLE multiyear_annual_avgprecip TO rwspicer;
GRANT SELECT ON TABLE multiyear_annual_avgprecip TO imiq_reader;


--
-- Name: multiyear_annual_avgrh; Type: ACL; Schema: views; Owner: imiq
--

REVOKE ALL ON TABLE multiyear_annual_avgrh FROM PUBLIC;
REVOKE ALL ON TABLE multiyear_annual_avgrh FROM imiq;
GRANT ALL ON TABLE multiyear_annual_avgrh TO imiq;
GRANT ALL ON TABLE multiyear_annual_avgrh TO asjacobs;
GRANT ALL ON TABLE multiyear_annual_avgrh TO chaase;
GRANT ALL ON TABLE multiyear_annual_avgrh TO rwspicer;
GRANT SELECT ON TABLE multiyear_annual_avgrh TO imiq_reader;


--
-- Name: multiyear_annual_avgspringairtemp; Type: ACL; Schema: views; Owner: imiq
--

REVOKE ALL ON TABLE multiyear_annual_avgspringairtemp FROM PUBLIC;
REVOKE ALL ON TABLE multiyear_annual_avgspringairtemp FROM imiq;
GRANT ALL ON TABLE multiyear_annual_avgspringairtemp TO imiq;
GRANT ALL ON TABLE multiyear_annual_avgspringairtemp TO asjacobs;
GRANT ALL ON TABLE multiyear_annual_avgspringairtemp TO chaase;
GRANT ALL ON TABLE multiyear_annual_avgspringairtemp TO rwspicer;
GRANT SELECT ON TABLE multiyear_annual_avgspringairtemp TO imiq_reader;


--
-- Name: multiyear_annual_avgspringprecip; Type: ACL; Schema: views; Owner: imiq
--

REVOKE ALL ON TABLE multiyear_annual_avgspringprecip FROM PUBLIC;
REVOKE ALL ON TABLE multiyear_annual_avgspringprecip FROM imiq;
GRANT ALL ON TABLE multiyear_annual_avgspringprecip TO imiq;
GRANT ALL ON TABLE multiyear_annual_avgspringprecip TO asjacobs;
GRANT ALL ON TABLE multiyear_annual_avgspringprecip TO chaase;
GRANT ALL ON TABLE multiyear_annual_avgspringprecip TO rwspicer;
GRANT SELECT ON TABLE multiyear_annual_avgspringprecip TO imiq_reader;


--
-- Name: multiyear_annual_avgsummerairtemp; Type: ACL; Schema: views; Owner: imiq
--

REVOKE ALL ON TABLE multiyear_annual_avgsummerairtemp FROM PUBLIC;
REVOKE ALL ON TABLE multiyear_annual_avgsummerairtemp FROM imiq;
GRANT ALL ON TABLE multiyear_annual_avgsummerairtemp TO imiq;
GRANT ALL ON TABLE multiyear_annual_avgsummerairtemp TO asjacobs;
GRANT ALL ON TABLE multiyear_annual_avgsummerairtemp TO chaase;
GRANT ALL ON TABLE multiyear_annual_avgsummerairtemp TO rwspicer;
GRANT SELECT ON TABLE multiyear_annual_avgsummerairtemp TO imiq_reader;


--
-- Name: multiyear_annual_avgsummerdischarge; Type: ACL; Schema: views; Owner: imiq
--

REVOKE ALL ON TABLE multiyear_annual_avgsummerdischarge FROM PUBLIC;
REVOKE ALL ON TABLE multiyear_annual_avgsummerdischarge FROM imiq;
GRANT ALL ON TABLE multiyear_annual_avgsummerdischarge TO imiq;
GRANT ALL ON TABLE multiyear_annual_avgsummerdischarge TO asjacobs;
GRANT ALL ON TABLE multiyear_annual_avgsummerdischarge TO chaase;
GRANT ALL ON TABLE multiyear_annual_avgsummerdischarge TO rwspicer;
GRANT SELECT ON TABLE multiyear_annual_avgsummerdischarge TO imiq_reader;


--
-- Name: multiyear_annual_avgsummerprecip; Type: ACL; Schema: views; Owner: imiq
--

REVOKE ALL ON TABLE multiyear_annual_avgsummerprecip FROM PUBLIC;
REVOKE ALL ON TABLE multiyear_annual_avgsummerprecip FROM imiq;
GRANT ALL ON TABLE multiyear_annual_avgsummerprecip TO imiq;
GRANT ALL ON TABLE multiyear_annual_avgsummerprecip TO asjacobs;
GRANT ALL ON TABLE multiyear_annual_avgsummerprecip TO chaase;
GRANT ALL ON TABLE multiyear_annual_avgsummerprecip TO rwspicer;
GRANT SELECT ON TABLE multiyear_annual_avgsummerprecip TO imiq_reader;


--
-- Name: multiyear_annual_avgsummerrh; Type: ACL; Schema: views; Owner: imiq
--

REVOKE ALL ON TABLE multiyear_annual_avgsummerrh FROM PUBLIC;
REVOKE ALL ON TABLE multiyear_annual_avgsummerrh FROM imiq;
GRANT ALL ON TABLE multiyear_annual_avgsummerrh TO imiq;
GRANT ALL ON TABLE multiyear_annual_avgsummerrh TO asjacobs;
GRANT ALL ON TABLE multiyear_annual_avgsummerrh TO chaase;
GRANT ALL ON TABLE multiyear_annual_avgsummerrh TO rwspicer;
GRANT SELECT ON TABLE multiyear_annual_avgsummerrh TO imiq_reader;


--
-- Name: multiyear_annual_avgwinterairtemp; Type: ACL; Schema: views; Owner: imiq
--

REVOKE ALL ON TABLE multiyear_annual_avgwinterairtemp FROM PUBLIC;
REVOKE ALL ON TABLE multiyear_annual_avgwinterairtemp FROM imiq;
GRANT ALL ON TABLE multiyear_annual_avgwinterairtemp TO imiq;
GRANT ALL ON TABLE multiyear_annual_avgwinterairtemp TO asjacobs;
GRANT ALL ON TABLE multiyear_annual_avgwinterairtemp TO chaase;
GRANT ALL ON TABLE multiyear_annual_avgwinterairtemp TO rwspicer;
GRANT SELECT ON TABLE multiyear_annual_avgwinterairtemp TO imiq_reader;


--
-- Name: multiyear_annual_avgwinterprecip; Type: ACL; Schema: views; Owner: imiq
--

REVOKE ALL ON TABLE multiyear_annual_avgwinterprecip FROM PUBLIC;
REVOKE ALL ON TABLE multiyear_annual_avgwinterprecip FROM imiq;
GRANT ALL ON TABLE multiyear_annual_avgwinterprecip TO imiq;
GRANT ALL ON TABLE multiyear_annual_avgwinterprecip TO asjacobs;
GRANT ALL ON TABLE multiyear_annual_avgwinterprecip TO chaase;
GRANT ALL ON TABLE multiyear_annual_avgwinterprecip TO rwspicer;
GRANT SELECT ON TABLE multiyear_annual_avgwinterprecip TO imiq_reader;


--
-- Name: multiyear_annual_avgwinterrh; Type: ACL; Schema: views; Owner: imiq
--

REVOKE ALL ON TABLE multiyear_annual_avgwinterrh FROM PUBLIC;
REVOKE ALL ON TABLE multiyear_annual_avgwinterrh FROM imiq;
GRANT ALL ON TABLE multiyear_annual_avgwinterrh TO imiq;
GRANT ALL ON TABLE multiyear_annual_avgwinterrh TO asjacobs;
GRANT ALL ON TABLE multiyear_annual_avgwinterrh TO chaase;
GRANT ALL ON TABLE multiyear_annual_avgwinterrh TO rwspicer;
GRANT SELECT ON TABLE multiyear_annual_avgwinterrh TO imiq_reader;


--
-- Name: odmdatavalues; Type: ACL; Schema: views; Owner: imiq
--

REVOKE ALL ON TABLE odmdatavalues FROM PUBLIC;
REVOKE ALL ON TABLE odmdatavalues FROM imiq;
GRANT ALL ON TABLE odmdatavalues TO imiq;
GRANT ALL ON TABLE odmdatavalues TO asjacobs;
GRANT ALL ON TABLE odmdatavalues TO chaase;
GRANT ALL ON TABLE odmdatavalues TO rwspicer;
GRANT SELECT ON TABLE odmdatavalues TO imiq_reader;


--
-- Name: odmdatavalues_metric; Type: ACL; Schema: views; Owner: imiq
--

REVOKE ALL ON TABLE odmdatavalues_metric FROM PUBLIC;
REVOKE ALL ON TABLE odmdatavalues_metric FROM imiq;
GRANT ALL ON TABLE odmdatavalues_metric TO imiq;
GRANT ALL ON TABLE odmdatavalues_metric TO asjacobs;
GRANT ALL ON TABLE odmdatavalues_metric TO chaase;
GRANT ALL ON TABLE odmdatavalues_metric TO rwspicer;
GRANT SELECT ON TABLE odmdatavalues_metric TO imiq_reader;


--
-- Name: queryme; Type: ACL; Schema: views; Owner: imiq
--

REVOKE ALL ON TABLE queryme FROM PUBLIC;
REVOKE ALL ON TABLE queryme FROM imiq;
GRANT ALL ON TABLE queryme TO imiq;
GRANT ALL ON TABLE queryme TO asjacobs;
GRANT ALL ON TABLE queryme TO chaase;
GRANT ALL ON TABLE queryme TO rwspicer;
GRANT SELECT ON TABLE queryme TO imiq_reader;


--
-- Name: siteattributesource; Type: ACL; Schema: views; Owner: imiq
--

REVOKE ALL ON TABLE siteattributesource FROM PUBLIC;
REVOKE ALL ON TABLE siteattributesource FROM imiq;
GRANT ALL ON TABLE siteattributesource TO imiq;
GRANT ALL ON TABLE siteattributesource TO asjacobs;
GRANT ALL ON TABLE siteattributesource TO chaase;
GRANT ALL ON TABLE siteattributesource TO rwspicer;
GRANT SELECT ON TABLE siteattributesource TO imiq_reader;


--
-- Name: sitegeography; Type: ACL; Schema: views; Owner: imiq
--

REVOKE ALL ON TABLE sitegeography FROM PUBLIC;
REVOKE ALL ON TABLE sitegeography FROM imiq;
GRANT ALL ON TABLE sitegeography TO imiq;
GRANT ALL ON TABLE sitegeography TO asjacobs;
GRANT ALL ON TABLE sitegeography TO chaase;
GRANT ALL ON TABLE sitegeography TO rwspicer;
GRANT SELECT ON TABLE sitegeography TO imiq_reader;


--
-- Name: sitesource; Type: ACL; Schema: views; Owner: imiq
--

REVOKE ALL ON TABLE sitesource FROM PUBLIC;
REVOKE ALL ON TABLE sitesource FROM imiq;
GRANT ALL ON TABLE sitesource TO imiq;
GRANT ALL ON TABLE sitesource TO asjacobs;
GRANT ALL ON TABLE sitesource TO chaase;
GRANT ALL ON TABLE sitesource TO rwspicer;
GRANT SELECT ON TABLE sitesource TO imiq_reader;


--
-- Name: sitesourcedescription; Type: ACL; Schema: views; Owner: imiq
--

REVOKE ALL ON TABLE sitesourcedescription FROM PUBLIC;
REVOKE ALL ON TABLE sitesourcedescription FROM imiq;
GRANT ALL ON TABLE sitesourcedescription TO imiq;
GRANT ALL ON TABLE sitesourcedescription TO asjacobs;
GRANT ALL ON TABLE sitesourcedescription TO chaase;
GRANT ALL ON TABLE sitesourcedescription TO rwspicer;
GRANT SELECT ON TABLE sitesourcedescription TO imiq_reader;


--
-- PostgreSQL database dump complete
--

