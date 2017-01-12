--
-- Thingworx Platform Version 7.1 PostgreSQL database model schema
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
create schema if not exists :"searchPath";
SET search_path TO :"searchPath";
--
-- Name: upsert_aspect_model(character varying, integer, character varying, text); Type: FUNCTION; Owner: postgres
--

CREATE FUNCTION upsert_aspect_model(inserting_name character varying, inserting_type integer, inserting_key character varying, inserting_value text) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
    FOR i IN 1..3 LOOP
        UPDATE aspect_model SET entity_name = inserting_name, entity_type = inserting_type, key = inserting_key, value = inserting_value WHERE entity_name = inserting_name AND entity_type = inserting_type AND key = inserting_key;
        IF FOUND THEN
            RETURN;
        END IF;

        BEGIN
            INSERT INTO aspect_model (entity_name, entity_type, key, value) VALUES (inserting_name, inserting_type, inserting_key, inserting_value);
            RETURN;
            EXCEPTION WHEN unique_violation THEN
        		SELECT pg_sleep(0.1); -- sleep 0.1 seconds and loop to try the UPDATE again.
        END;
    END LOOP;
END;
$$;


ALTER FUNCTION upsert_aspect_model(inserting_name character varying, inserting_type integer, inserting_key character varying, inserting_value text) OWNER TO :"user_name";

--
-- Name: upsert_user_properties(character varying, character varying, text); Type: FUNCTION; Owner: postgres
--

CREATE FUNCTION upsert_user_properties(inserting_name character varying, inserting_key character varying, inserting_value text) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
    FOR i IN 1..3 LOOP
        UPDATE user_model_properties SET entity_name = inserting_name, key = inserting_key, value = inserting_value WHERE entity_name = inserting_name AND key = inserting_key;
        IF FOUND THEN
            RETURN;
        END IF;

        BEGIN
            INSERT INTO user_model_properties (entity_name, key, value) VALUES (inserting_name, inserting_key, inserting_value);
            RETURN;
            EXCEPTION WHEN unique_violation THEN
        		SELECT pg_sleep(0.1); -- sleep 0.1 seconds and loop to try the UPDATE again.
        END;
    END LOOP;
END;
$$;


ALTER FUNCTION upsert_user_properties(inserting_name character varying, inserting_key character varying, inserting_value text) OWNER TO :"user_name";

--
-- Name: upsert_extension(varchar, bytea, text); Type: FUNCTION; Owner: postgres
--
CREATE FUNCTION upsert_extension(extension_name varchar, extension_resource bytea, extension_checksum text) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
    FOR i IN 1..3 LOOP
        UPDATE extensions SET checksum = extension_checksum, resource = extension_resource WHERE name = extension_name;
        IF FOUND THEN
            RETURN;
        END IF;

        BEGIN
            INSERT INTO extensions (name, resource, checksum) VALUES (extension_name, extension_resource, extension_checksum);
            RETURN;
            EXCEPTION WHEN unique_violation THEN
        		SELECT pg_sleep(0.1); -- sleep 0.1 seconds and loop to try the UPDATE again.
        END;
    END LOOP;
END;
$$;

ALTER FUNCTION upsert_extension(extension_name varchar, extension_resource bytea, extension_checksum text) OWNER TO :"user_name";


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: applicationkey_model; Type: TABLE; Owner: :"user_name"; Tablespace: 
--

CREATE TABLE applicationkey_model (
    avatar bytea,
    "className" character varying,
    "clientName" character varying,
    "configurationChanges" character varying,
    "configurationTables" text,
    description character varying,
    "designTimePermissions" text,
    "documentationContent" character varying,
	"expirationDate" timestamp without time zone,
	"homeMashup" character varying,
    "ipWhitelist" character varying,
    "keyId" character varying,
    "lastModifiedDate" timestamp without time zone,
    name character varying NOT NULL,
    owner text,
    "projectName" character varying,
    "runTimePermissions" text,
    tags character varying,
    "tenantId" character varying,
    type integer,
    "userNameReference" character varying,
    "visibilityPermissions" text
);


ALTER TABLE applicationkey_model OWNER TO :"user_name";

--
-- Name: aspect_model; Type: TABLE; Owner: :"user_name"; Tablespace: 
--

CREATE TABLE aspect_model (
    entity_name character varying NOT NULL,
    entity_type integer NOT NULL,
    key character varying NOT NULL,
    value text
);


ALTER TABLE aspect_model OWNER TO :"user_name";

--
-- Name: authenticator_model; Type: TABLE; Owner: :"user_name"; Tablespace: 
--

CREATE TABLE authenticator_model (
    avatar bytea,
    "className" character varying,
    "configurationChanges" character varying,
    "configurationTables" text,
    description character varying,
    "designTimePermissions" text,
    "documentationContent" character varying,
    enabled boolean,
    "homeMashup" character varying,
    "lastModifiedDate" timestamp without time zone,
    name character varying NOT NULL,
    owner text,
    "projectName" character varying,
    priority integer,
    "runTimePermissions" text,
    tags character varying,
    "tenantId" character varying,
    type integer,
    "visibilityPermissions" text
);


ALTER TABLE authenticator_model OWNER TO :"user_name";

--
-- Name: dashboard_model; Type: TABLE; Owner: :"user_name"; Tablespace: 
--

CREATE TABLE dashboard_model (
    avatar bytea,
    "className" character varying,
    "configurationChanges" character varying,
    "configurationTables" text,
    dashboard text,
    description character varying,
    "designTimePermissions" text,
    "documentationContent" character varying,
    "homeMashup" character varying,
    "lastModifiedDate" timestamp without time zone,
    name character varying NOT NULL,
    owner text,
    "projectName" character varying,
    "runTimePermissions" text,
    tags character varying,
    "tenantId" character varying,
    type integer,
    "visibilityPermissions" text
);


ALTER TABLE dashboard_model OWNER TO :"user_name";

--
-- Name: dataanalysisdefinition_model; Type: TABLE; Owner: :"user_name"; Tablespace: 
--

CREATE TABLE dataanalysisdefinition_model (
    avatar bytea,
    "baseDataShape" character varying,
    "className" character varying,
    "configurationChanges" character varying,
    "configurationTables" text,
    description character varying,
    "designTimePermissions" text,
    "documentationContent" character varying,
    "dataAnalysisDefinition" text,
    "homeMashup" character varying,
    "lastModifiedDate" timestamp without time zone,
    name character varying NOT NULL,
    owner text,
    "projectName" character varying,
    "runTimePermissions" text,
    tags character varying,
    "tenantId" character varying,
    type integer,
    "visibilityPermissions" text
);


ALTER TABLE dataanalysisdefinition_model OWNER TO :"user_name";

--
-- Name: datashape_model; Type: TABLE; Owner: :"user_name"; Tablespace: 
--

CREATE TABLE datashape_model (
    avatar bytea,
    "baseDataShape" character varying,
    "className" character varying,
    "configurationChanges" character varying,
    "configurationTables" text,
    description character varying,
    "designTimePermissions" text,
    "documentationContent" character varying,
    "fieldDefinitions" text,
    "homeMashup" character varying,
    "lastModifiedDate" timestamp without time zone,
    name character varying NOT NULL,
    owner text,
    "projectName" character varying,
    "runTimePermissions" text,
    tags character varying,
    "tenantId" character varying,
    type integer,
    "visibilityPermissions" text
);


ALTER TABLE datashape_model OWNER TO :"user_name";

--
-- Name: datatable_model; Type: TABLE; Owner: :"user_name"; Tablespace: 
--

CREATE TABLE datatable_model (
    "alertConfigurations" text,
    avatar bytea,
    "className" character varying,
    "configurationChanges" character varying,
    "configurationTables" text,
    description character varying,
    "designTimePermissions" text,
    "documentationContent" character varying,
    enabled boolean,
    "homeMashup" character varying,
    identifier character varying,
    "implementedShapes" character varying,
    "lastModifiedDate" timestamp without time zone,
    name character varying NOT NULL,
    owner text,
    "projectName" character varying,
    "propertyBindings" text,
    published boolean,
    "remoteEventBindings" text,
    "remotePropertyBindings" text,
    "remoteServiceBindings" text,
    "runTimePermissions" text,
    tags character varying,
    "tenantId" character varying,
    "thingShape" text,
    "thingTemplate" character varying,
    type integer,
    "valueStream" character varying,
    "visibilityPermissions" text
);


ALTER TABLE datatable_model OWNER TO :"user_name";

--
-- Name: datatagvocabulary_model; Type: TABLE; Owner: :"user_name"; Tablespace: 
--

CREATE TABLE datatagvocabulary_model (
    avatar bytea,
    "className" character varying,
    "configurationChanges" character varying,
    "configurationTables" text,
    description character varying,
    "designTimePermissions" text,
    "documentationContent" character varying,
    "homeMashup" character varying,
    "isDynamic" boolean,
    "lastModifiedDate" timestamp without time zone,
    name character varying NOT NULL,
    owner text,
    "projectName" character varying,
    "runTimePermissions" text,
    tags character varying,
    "tenantId" character varying,
    type integer,
    "visibilityPermissions" text
);


ALTER TABLE datatagvocabulary_model OWNER TO :"user_name";

--
-- Name: directoryservice_model; Type: TABLE; Owner: :"user_name"; Tablespace: 
--

CREATE TABLE directoryservice_model (
    avatar bytea,
    "className" character varying,
    "configurationChanges" character varying,
    "configurationTables" text,
    description character varying,
    "designTimePermissions" text,
    "documentationContent" character varying,
    enabled boolean,
    "homeMashup" character varying,
    "lastModifiedDate" timestamp without time zone,
    name character varying NOT NULL,
    owner text,
    priority integer,
    "projectName" character varying,
    "runTimePermissions" text,
    tags character varying,
    "tenantId" character varying,
    type integer,
    "visibilityPermissions" text
);


ALTER TABLE directoryservice_model OWNER TO :"user_name";

--
-- Name: extensionpackage_model; Type: TABLE; Owner: :"user_name"; Tablespace: 
--

CREATE TABLE extensionpackage_model (
    avatar bytea,
    "buildNumber" character varying,
    "className" character varying,
    "configurationChanges" character varying,
    "configurationTables" text,
    description character varying,
    "designTimePermissions" text,
    "documentationContent" character varying,
    "extensionPackageManifest" text,
    "homeMashup" character varying,
    "lastModifiedDate" timestamp without time zone,
    "minimumThingWorxVersion" character varying,
    name character varying NOT NULL,
    owner text,
    "packageVersion" character varying,
    "projectName" character varying,
    "runTimePermissions" text,
    tags character varying,
    "tenantId" character varying,
    type integer,
    vendor character varying,
    "visibilityPermissions" text,
    "migratorClass" character varying
);

ALTER TABLE ONLY extensionpackage_model
    ADD CONSTRAINT extensionpackage_model_pkey PRIMARY KEY (name);

ALTER TABLE extensionpackage_model OWNER TO :"user_name";

--
-- Name: group_model; Type: TABLE; Owner: :"user_name"; Tablespace: 
--

CREATE TABLE group_model (
    avatar bytea,
    "className" character varying,
    "configurationChanges" character varying,
    "configurationTables" text,
    description character varying,
    "designTimePermissions" text,
    "documentationContent" character varying,
    "homeMashup" character varying,
    "lastModifiedDate" timestamp without time zone,
    members character varying,
    name character varying NOT NULL,
    owner text,
    "projectName" character varying,
    "runTimePermissions" text,
    tags character varying,
    "tenantId" character varying,
    type integer,
    "visibilityPermissions" text
);


ALTER TABLE group_model OWNER TO :"user_name";

--
-- Name: localizationtable_model; Type: TABLE; Owner: :"user_name"; Tablespace: 
--

CREATE TABLE localizationtable_model (
    avatar bytea,
    "className" character varying,
    "configurationChanges" character varying,
    "configurationTables" text,
    description character varying,
    "designTimePermissions" text,
    "documentationContent" character varying,
    "homeMashup" character varying,
    "lastModifiedDate" timestamp without time zone,
    name character varying NOT NULL,
    owner text,
    "projectName" character varying,
    "runTimePermissions" text,
    tags character varying,
    "tenantId" character varying,
    type integer,
    "visibilityPermissions" text,
    "languageCommon" character varying,
    "languageNative" character varying
);


ALTER TABLE localizationtable_model OWNER TO :"user_name";

--
-- Name: log_model; Type: TABLE; Owner: :"user_name"; Tablespace: 
--

CREATE TABLE log_model (
    avatar bytea,
    "className" character varying,
    "configurationChanges" character varying,
    "configurationTables" text,
    description character varying,
    "designTimePermissions" text,
    "documentationContent" character varying,
    "homeMashup" character varying,
    "lastModifiedDate" timestamp without time zone,
    "logLevel" character varying,
    name character varying NOT NULL,
    owner text,
    "projectName" character varying,
    "runTimePermissions" text,
    tags character varying,
    "tenantId" character varying,
    type integer,
    "visibilityPermissions" text
);


ALTER TABLE log_model OWNER TO :"user_name";

--
-- Name: mashup_model; Type: TABLE; Owner: :"user_name"; Tablespace: 
--

CREATE TABLE mashup_model (
    avatar bytea,
    "className" character varying,
    columns numeric,
    "configurationChanges" character varying,
    "configurationTables" text,
    description character varying,
    "designTimePermissions" text,
    "documentationContent" character varying,
    "homeMashup" character varying,
    "lastModifiedDate" timestamp without time zone,
    "mashupContent" character varying,
    name character varying NOT NULL,
    owner text,
    "parameterDefinitions" text,
    "projectName" character varying,
    "relatedEntities" character varying,
    rows numeric,
    "runTimePermissions" text,
    tags character varying,
    "tenantId" character varying,
    type integer,
    "visibilityPermissions" text
);


ALTER TABLE mashup_model OWNER TO :"user_name";

--
-- Name: mediaentity_model; Type: TABLE; Owner: :"user_name"; Tablespace: 
--

CREATE TABLE mediaentity_model (
    avatar bytea,
    "className" character varying,
    "configurationChanges" character varying,
    "configurationTables" text,
    content bytea,
    description character varying,
    "designTimePermissions" text,
    "documentationContent" character varying,
    "homeMashup" character varying,
    "lastModifiedDate" timestamp without time zone,
    name character varying NOT NULL,
    owner text,
    "projectName" character varying,
    "runTimePermissions" text,
    tags character varying,
    "tenantId" character varying,
    type integer,
    "visibilityPermissions" text
);


ALTER TABLE mediaentity_model OWNER TO :"user_name";

--
-- Name: menu_model; Type: TABLE; Owner: :"user_name"; Tablespace: 
--

CREATE TABLE menu_model (
    avatar bytea,
    "className" character varying,
    "configurationChanges" character varying,
    "configurationTables" text,
    description character varying,
    "designTimePermissions" text,
    "documentationContent" character varying,
    "groupReferences" character varying,
    "homeMashup" character varying,
    "imageURL" character varying,
    "lastModifiedDate" timestamp without time zone,
    "menuItems" character varying,
    "menuLabel" character varying,
    name character varying NOT NULL,
    owner text,
    "projectName" character varying,
    "runTimePermissions" text,
    tags character varying,
    "tenantId" character varying,
    type integer,
    "visibilityPermissions" text
);


ALTER TABLE menu_model OWNER TO :"user_name";

--
-- Name: model_index; Type: TABLE; Owner: :"user_name"; Tablespace: 
--

CREATE TABLE model_index (
    entity_name character varying NOT NULL,
    entity_type integer NOT NULL,
    last_modified_time timestamp without time zone NOT NULL,
    description text,
    identifier character varying(1000),
    entity_id character varying NOT NULL,
    tags character varying,
    project_name character varying
);


ALTER TABLE model_index OWNER TO :"user_name";

--
-- Name: modeltagvocabulary_model; Type: TABLE; Owner: :"user_name"; Tablespace: 
--

CREATE TABLE modeltagvocabulary_model (
    avatar bytea,
    "className" character varying,
    "configurationChanges" character varying,
    "configurationTables" text,
    description character varying,
    "designTimePermissions" text,
    "documentationContent" character varying,
    "homeMashup" character varying,
    "isDynamic" boolean,
    "lastModifiedDate" timestamp without time zone,
    name character varying NOT NULL,
    owner text,
    "projectName" character varying,
    "runTimePermissions" text,
    tags character varying,
    "tenantId" character varying,
    type integer,
    "visibilityPermissions" text
);


ALTER TABLE modeltagvocabulary_model OWNER TO :"user_name";

--
-- Name: vocabulary_terms; Type: TABLE; Owner: :"user_name"; Tablespace: 
--

CREATE TABLE vocabulary_terms (
    pid integer NOT NULL,
    vocabulary_name character varying(255) NOT NULL,
    term_name character varying(255) NOT NULL,
    vocabulary_id character varying NOT NULL,
    vocabulary_type integer NOT NULL
);

ALTER TABLE vocabulary_terms OWNER TO :"user_name";

--
-- Name: vocabulary_terms_pid_seq; Type: SEQUENCE; Owner: postgres
--

CREATE SEQUENCE vocabulary_terms_pid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE vocabulary_terms_pid_seq OWNER TO :"user_name";

--
-- Name: vocabulary_terms_pid_seq; Type: SEQUENCE OWNED BY; Owner: postgres
--

ALTER SEQUENCE vocabulary_terms_pid_seq OWNED BY vocabulary_terms.pid;



--
-- Name: network_model; Type: TABLE; Owner: :"user_name"; Tablespace: 
--

CREATE TABLE network_model (
    avatar bytea,
    "className" character varying,
    "configurationChanges" character varying,
    "configurationTables" text,
    connections character varying,
    description character varying,
    "designTimePermissions" text,
    "documentationContent" character varying,
    "homeMashup" character varying,
    "lastModifiedDate" timestamp without time zone,
    name character varying NOT NULL,
    owner text,
    "projectName" character varying,
    "runTimePermissions" text,
    tags character varying,
    "tenantId" character varying,
    type integer,
    "visibilityPermissions" text
);


ALTER TABLE network_model OWNER TO :"user_name";

--
-- Name: organization_model; Type: TABLE; Owner: :"user_name"; Tablespace: 
--

CREATE TABLE organization_model (
    avatar bytea,
    "className" character varying,
    "configurationChanges" character varying,
    "configurationTables" text,
    connections character varying,
    description character varying,
    "designTimePermissions" text,
    "documentationContent" character varying,
    "homeMashup" character varying,
    "lastModifiedDate" timestamp without time zone,
    "loginButtonStyle" character varying,
    "loginImage" bytea,
    "loginPrompt" character varying,
    "loginStyle" character varying,
    "mobileMashup" character varying,
    name character varying NOT NULL,
    "organizationalUnits" text,
    owner text,
    "projectName" character varying,
    "runTimePermissions" text,
    tags character varying,
    "tenantId" character varying,
    type integer,
    "visibilityPermissions" text,
    "loginResetPassword" boolean,
    "resetMailServer" character varying,
    "resetMailSubject" character varying,
    "resetMailContent" character varying
);


ALTER TABLE organization_model OWNER TO :"user_name";

--
-- Name: persistenceprovider_model; Type: TABLE; Owner: :"user_name"; Tablespace: 
--

CREATE TABLE persistenceprovider_model (
    avatar bytea,
    "className" character varying,
    "configurationChanges" character varying,
    "configurationTables" text,
    description character varying,
    "designTimePermissions" text,
    "documentationContent" character varying,
    enabled boolean,
    "homeMashup" character varying,
    "lastModifiedDate" timestamp without time zone,
    name character varying NOT NULL,
    owner text,
    "persistenceProviderPackage" character varying,
    "projectName" character varying,
    "runTimePermissions" text,
    tags character varying,
    "tenantId" character varying,
    type integer,
    "visibilityPermissions" text
);


ALTER TABLE persistenceprovider_model OWNER TO :"user_name";

--
-- Name: persistenceproviderpackage_model; Type: TABLE; Owner: :"user_name"; Tablespace: 
--

CREATE TABLE persistenceproviderpackage_model (
    avatar bytea,
    "className" character varying,
    "configurationChanges" character varying,
    "configurationTables" text,
    description character varying,
    "designTimePermissions" text,
    "documentationContent" character varying,
    "homeMashup" character varying,
    "lastModifiedDate" timestamp without time zone,
    name character varying NOT NULL,
    owner text,
    "projectName" character varying,
    "runTimePermissions" text,
    tags character varying,
    "tenantId" character varying,
    type integer,
    "visibilityPermissions" text
);


ALTER TABLE persistenceproviderpackage_model OWNER TO :"user_name";

--
-- Name: project_model; Type: TABLE; Owner: :"user_name"; Tablespace:
--

CREATE TABLE project_model (
    avatar bytea,
    "className" character varying,
    "configurationChanges" character varying,
    "configurationTables" text,
    description character varying,
    "designTimePermissions" text,
    "documentationContent" character varying,
    "homeMashup" character varying,
    "lastModifiedDate" timestamp without time zone,
    name character varying NOT NULL,
    owner text,
    "projectName" character varying,
    "runTimePermissions" text,
    tags character varying,
    "tenantId" character varying,
    type integer,
    "version" text,
    "visibilityPermissions" text
);


ALTER TABLE project_model OWNER TO :"user_name";

--
-- Name: resource_model; Type: TABLE; Owner: :"user_name"; Tablespace: 
--

CREATE TABLE resource_model (
    avatar bytea,
    "className" character varying,
    "configurationChanges" character varying,
    "configurationTables" text,
    description character varying,
    "designTimePermissions" text,
    "documentationContent" character varying,
    "homeMashup" character varying,
    "lastModifiedDate" timestamp without time zone,
    name character varying NOT NULL,
    owner text,
    "projectName" character varying,
    "runTimePermissions" text,
    tags character varying,
    "tenantId" character varying,
    type integer,
    "visibilityPermissions" text
);


ALTER TABLE resource_model OWNER TO :"user_name";

--
-- Name: root_entity_collection; Type: TABLE; Owner: :"user_name"; Tablespace: 
--

CREATE TABLE root_entity_collection (
    name character varying(255) NOT NULL,
    type integer,
    description text,
    owner text,
    last_modified_time timestamp without time zone,
    pid integer NOT NULL,
    "designTimePermissions" text,
    "runTimePermissions" text,
    "visibilityPermissions" text,
    "className" character varying
);


ALTER TABLE root_entity_collection OWNER TO :"user_name";

--
-- Name: root_entity_collection_pid_seq; Type: SEQUENCE; Owner: :"user_name"
--

CREATE SEQUENCE root_entity_collection_pid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE root_entity_collection_pid_seq OWNER TO :"user_name";

--
-- Name: root_entity_collection_pid_seq; Type: SEQUENCE OWNED BY; Owner: :"user_name"
--

ALTER SEQUENCE root_entity_collection_pid_seq OWNED BY root_entity_collection.pid;


--
-- Name: scriptfunctionlibrary_model; Type: TABLE; Owner: :"user_name"; Tablespace: 
--

CREATE TABLE scriptfunctionlibrary_model (
    avatar bytea,
    "className" character varying,
    "configurationChanges" character varying,
    "configurationTables" text,
    description character varying,
    "designTimePermissions" text,
    "documentationContent" character varying,
    "functionDefinitions" text,
    "homeMashup" character varying,
    "lastModifiedDate" timestamp without time zone,
    name character varying NOT NULL,
    owner text,
    "projectName" character varying,
    "runTimePermissions" text,
    tags character varying,
    "tenantId" character varying,
    type integer,
    "visibilityPermissions" text
);


ALTER TABLE scriptfunctionlibrary_model OWNER TO :"user_name";

--
-- Name: statedefinition_model; Type: TABLE; Owner: :"user_name"; Tablespace: 
--

CREATE TABLE statedefinition_model (
    avatar bytea,
    "className" character varying,
    "configurationChanges" character varying,
    "configurationTables" text,
    content text,
    description character varying,
    "designTimePermissions" text,
    "documentationContent" character varying,
    "homeMashup" character varying,
    "lastModifiedDate" timestamp without time zone,
    name character varying NOT NULL,
    owner text,
    "projectName" character varying,
    "runTimePermissions" text,
    tags character varying,
    "tenantId" character varying,
    type integer,
    "visibilityPermissions" text
);


ALTER TABLE statedefinition_model OWNER TO :"user_name";

--
-- Name: stream_model; Type: TABLE; Owner: :"user_name"; Tablespace: 
--

CREATE TABLE stream_model (
    "alertConfigurations" text,
    avatar bytea,
    "className" character varying,
    "configurationChanges" character varying,
    "configurationTables" text,
    description character varying,
    "designTimePermissions" text,
    "documentationContent" character varying,
    enabled boolean,
    "homeMashup" character varying,
    identifier character varying,
    "implementedShapes" character varying,
    "lastModifiedDate" timestamp without time zone,
    name character varying NOT NULL,
    owner text,
    "projectName" character varying,
    "propertyBindings" text,
    published boolean,
    "remoteEventBindings" text,
    "remotePropertyBindings" text,
    "remoteServiceBindings" text,
    "runTimePermissions" text,
    tags character varying,
    "tenantId" character varying,
    "thingShape" text,
    "thingTemplate" character varying,
    type integer,
    "valueStream" character varying,
    "visibilityPermissions" text
);


ALTER TABLE stream_model OWNER TO :"user_name";

--
-- Name: styledefinition_model; Type: TABLE; Owner: :"user_name"; Tablespace: 
--

CREATE TABLE styledefinition_model (
    avatar bytea,
    "className" character varying,
    "configurationChanges" character varying,
    "configurationTables" text,
    content text,
    description character varying,
    "designTimePermissions" text,
    "documentationContent" character varying,
    "homeMashup" character varying,
    "lastModifiedDate" timestamp without time zone,
    name character varying NOT NULL,
    owner text,
    "projectName" character varying,
    "runTimePermissions" text,
    tags character varying,
    "tenantId" character varying,
    type integer,
    "visibilityPermissions" text
);


ALTER TABLE styledefinition_model OWNER TO :"user_name";

--
-- Name: subsystem_model; Type: TABLE; Owner: :"user_name"; Tablespace: 
--

CREATE TABLE subsystem_model (
    "autoStart" boolean,
    avatar bytea,
    "className" character varying,
    "configurationChanges" character varying,
    "configurationTables" text,
    "dependsOn" character varying,
    description character varying,
    "designTimePermissions" text,
    "documentationContent" character varying,
    enabled boolean,
    "friendlyName" character varying,
    "homeMashup" character varying,
    "lastModifiedDate" timestamp without time zone,
    name character varying NOT NULL,
    owner text,
    "projectName" character varying,
    "runTimePermissions" text,
    tags character varying,
    "tenantId" character varying,
    type integer,
    "visibilityPermissions" text
);


ALTER TABLE subsystem_model OWNER TO :"user_name";

--
-- Name: system_version; Type: TABLE; Owner: postgres; Tablespace: 
--

CREATE TABLE IF NOT EXISTS system_version (
    pid serial primary key,
    server_name character varying(255) NOT NULL,
    server_code integer NOT NULL,
    is_data_provider_supported boolean NOT NULL,
    is_model_provider_supported boolean NOT NULL,
    is_property_provider_supported boolean NOT NULL,
    model_schema_version integer NOT NULL,
    data_schema_version integer NOT NULL,
    property_schema_version integer NOT NULL,
    major_version character varying(10) NOT NULL,
    minor_version character varying(10),
    revision character varying(45) NOT NULL,
    build character varying(45) NOT NULL,
    creationDate timestamp without time zone DEFAULT now()
);


ALTER TABLE system_version OWNER TO :"user_name";

--
-- Name: tag_index; Type: TABLE; Owner: postgres; Tablespace: 
--

CREATE TABLE tag_index (
    pid integer NOT NULL,
    entity_name character varying(255) NOT NULL,
    vocabulary_name character varying(255) NOT NULL,
    term_name character varying(255) NOT NULL,
    entity_identifier character varying NOT NULL,
    vocabulary_type integer NOT NULL,
    tenant_id character varying(255) NOT NULL
);


ALTER TABLE tag_index OWNER TO :"user_name";

--
-- Name: tag_index_pid_seq; Type: SEQUENCE; Owner: postgres
--

CREATE SEQUENCE tag_index_pid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tag_index_pid_seq OWNER TO :"user_name";

--
-- Name: tag_index_pid_seq; Type: SEQUENCE OWNED BY; Owner: postgres
--

ALTER SEQUENCE tag_index_pid_seq OWNED BY tag_index.pid;


--
-- Name: thing_model; Type: TABLE; Owner: :"user_name"; Tablespace: 
--

CREATE TABLE thing_model (
    "alertConfigurations" text,
    avatar bytea,
    "className" character varying,
    "configurationChanges" character varying,
    "configurationTables" text,
    description character varying,
    "designTimePermissions" text,
    "documentationContent" character varying,
    enabled boolean,
    "homeMashup" character varying,
    identifier character varying,
    "implementedShapes" character varying,
    "lastModifiedDate" timestamp without time zone,
    name character varying NOT NULL,
    owner text,
    "projectName" character varying,
    "propertyBindings" text,
    published boolean,
    "remoteEventBindings" text,
    "remotePropertyBindings" text,
    "remoteServiceBindings" text,
    "runTimePermissions" text,
    tags character varying,
    "tenantId" character varying,
    "thingShape" text,
    "thingTemplate" character varying,
    type integer,
    "valueStream" character varying,
    "visibilityPermissions" text
);


ALTER TABLE thing_model OWNER TO :"user_name";

--
-- Name: thingpackage_model; Type: TABLE; Owner: :"user_name"; Tablespace: 
--

CREATE TABLE thingpackage_model (
    avatar bytea,
    "className" character varying,
    "configurationChanges" character varying,
    "configurationTables" text,
    description character varying,
    "designTimePermissions" text,
    "documentationContent" character varying,
    "homeMashup" character varying,
    "lastModifiedDate" timestamp without time zone,
    name character varying NOT NULL,
    owner text,
    "projectName" character varying,
    "runTimePermissions" text,
    tags character varying,
    "tenantId" character varying,
    type integer,
    "visibilityPermissions" text
);


ALTER TABLE thingpackage_model OWNER TO :"user_name";

--
-- Name: thingshape_model; Type: TABLE; Owner: :"user_name"; Tablespace: 
--

CREATE TABLE thingshape_model (
    "alertConfigurations" text,
    avatar bytea,
    "className" character varying,
    "configurationChanges" character varying,
    "configurationTables" text,
    description character varying,
    "designTimePermissions" text,
    "documentationContent" character varying,
    "homeMashup" character varying,
    "instanceRunTimePermissions" text,
    "lastModifiedDate" timestamp without time zone,
    name character varying NOT NULL,
    owner text,
    "projectName" character varying,
    "propertyBindings" text,
    "remoteEventBindings" text,
    "remotePropertyBindings" text,
    "remoteServiceBindings" text,
    "runTimePermissions" text,
    tags character varying,
    "tenantId" character varying,
    "thingShape" text,
    type integer,
    "visibilityPermissions" text
);


ALTER TABLE thingshape_model OWNER TO :"user_name";

--
-- Name: thingtemplate_model; Type: TABLE; Owner: :"user_name"; Tablespace: 
--

CREATE TABLE thingtemplate_model (
    "alertConfigurations" text,
    avatar bytea,
    "baseThingTemplate" character varying,
    "className" character varying,
    "configurationChanges" character varying,
    "configurationTables" text,
    description character varying,
    "designTimePermissions" text,
    "documentationContent" character varying,
    "homeMashup" character varying,
    "implementedShapes" character varying,
    "instanceDesignTimePermissions" text,
    "instanceRunTimePermissions" text,
    "instanceVisibilityPermissions" text,
    "lastModifiedDate" timestamp without time zone,
    name character varying NOT NULL,
    owner text,
    "projectName" character varying,
    "propertyBindings" text,
    "remoteEventBindings" text,
    "remotePropertyBindings" text,
    "remoteServiceBindings" text,
    "runTimePermissions" text,
    "sharedConfigurationTables" text,
    tags character varying,
    "tenantId" character varying,
    "thingPackage" character varying,
    "thingShape" text,
    type integer,
    "valueStream" character varying,
    "visibilityPermissions" text
);


ALTER TABLE thingtemplate_model OWNER TO :"user_name";

--
-- Name: user_model; Type: TABLE; Owner: :"user_name"; Tablespace: 
--

CREATE TABLE user_model (
    avatar bytea,
    "className" character varying,
    "configurationChanges" character varying,
    "configurationTables" text,
    description character varying,
    "designTimePermissions" text,
    "documentationContent" character varying,
    enabled boolean,
    "homeMashup" character varying,
    "lastModifiedDate" timestamp without time zone,
    "mobileMashup" character varying,
    name character varying NOT NULL,
    owner text,
    password character varying,
    "passwordHash" character varying,
    "passwordHashAlgorithm" character varying,
    "passwordHashIterationCount" integer,
    "passwordHashSaltSizeInBytes" integer,
    "passwordHashSizeInBytes" integer,
    "projectName" character varying,
    "runTimePermissions" text,
    tags character varying,
    "tenantId" character varying,
    type integer,
    "visibilityPermissions" text,
    "locked" boolean,
    "lockedTime" timestamp without time zone
);


ALTER TABLE user_model OWNER TO :"user_name";

--
-- Name: user_model_properties; Type: TABLE; Owner: :"user_name"; Tablespace: 
--

CREATE TABLE user_model_properties (
    entity_name character varying NOT NULL,
    key character varying NOT NULL,
    value text
);


ALTER TABLE user_model_properties OWNER TO :"user_name";

--
-- Name: valuestream_model; Type: TABLE; Owner: :"user_name"; Tablespace: 
--

CREATE TABLE valuestream_model (
    "alertConfigurations" text,
    avatar bytea,
    "className" character varying,
    "configurationChanges" character varying,
    "configurationTables" text,
    description character varying,
    "designTimePermissions" text,
    "documentationContent" character varying,
    enabled boolean,
    "homeMashup" character varying,
    identifier character varying,
    "implementedShapes" character varying,
    "lastModifiedDate" timestamp without time zone,
    name character varying NOT NULL,
    owner text,
    "projectName" character varying,
    "propertyBindings" text,
    published boolean,
    "remoteEventBindings" text,
    "remotePropertyBindings" text,
    "remoteServiceBindings" text,
    "runTimePermissions" text,
    tags character varying,
    "tenantId" character varying,
    "thingShape" text,
    "thingTemplate" character varying,
    type integer,
    "valueStream" character varying,
    "visibilityPermissions" text
);


ALTER TABLE valuestream_model OWNER TO :"user_name";

--
-- Name: widget_model; Type: TABLE; Owner: :"user_name"; Tablespace: 
--

CREATE TABLE widget_model (
    avatar bytea,
    "className" character varying,
    "configurationChanges" character varying,
    "configurationTables" text,
    description character varying,
    "designTimePermissions" text,
    "documentationContent" character varying,
    "homeMashup" character varying,
    "lastModifiedDate" timestamp without time zone,
    name character varying NOT NULL,
    owner text,
    "projectName" character varying,
    "runTimePermissions" text,
    tags character varying,
    "tenantId" character varying,
    type integer,
    "visibilityPermissions" text
);

CREATE TABLE extensions (
	"name" varchar PRIMARY KEY REFERENCES extensionpackage_model(name),
	"resource" bytea NOT NULL,
	"checksum" text NOT NULL
);

ALTER TABLE extensions OWNER TO :"user_name";


CREATE TABLE file_transfer_job (
	"id" text NOT NULL,
	"targetChecksum" text,
	"code" integer,
	"isAsync" boolean,
	"maxSize" bigint,
	"stagingDir" text,
	"sourceFile" text,
	"startPosition" numeric,
	"timeout" bigint,
	"isRestartEnabled" boolean,
	"duration" bigint,
	"targetFile" text,
	"startTime" bigint,
	"state" text,
	"sourcePath" text,
	"sourceRepository" text,
	"blockCount" bigint,
	"bytesTransferred" numeric,
	"targetPath" text,
	"sourceChecksum" text,
	"transferId" text,
	"message" text,
	"blockSize" bigint,
	"size" numeric,
	"endTime" bigint,
	"targetRepository" text,
	"user" text,
	"isComplete" boolean,
	"isQueueable" boolean,
	"enqueueTime" bigint,
	"enqueueCount" bigint
);

ALTER TABLE file_transfer_job OWNER TO :"user_name";

ALTER TABLE ONLY file_transfer_job
    ADD CONSTRAINT file_transfer_job_pkey PRIMARY KEY (id);

CREATE TABLE system_ownership (
  id serial primary key,
  platform text, -- Arbitrary text describing the owning platform instance.
  took_ownership timestamp default current_timestamp
);

ALTER TABLE system_ownership OWNER TO :"user_name";

--
-- TOC entry 2092 (class 2606 OID 76782)
-- Name: property_vtq_pkey; Type: CONSTRAINT; Schema: public; Owner: thingworx; Tablespace: 
--


ALTER TABLE widget_model OWNER TO :"user_name";

--
-- Name: pid; Type: DEFAULT; Owner: :"user_name"
--

ALTER TABLE ONLY root_entity_collection ALTER COLUMN pid SET DEFAULT nextval('root_entity_collection_pid_seq'::regclass);


--
-- Name: pid; Type: DEFAULT; Owner: postgres
--

ALTER TABLE ONLY tag_index ALTER COLUMN pid SET DEFAULT nextval('tag_index_pid_seq'::regclass);


--
-- Name: pid; Type: DEFAULT; Owner: postgres
--

ALTER TABLE ONLY vocabulary_terms ALTER COLUMN pid SET DEFAULT nextval('vocabulary_terms_pid_seq'::regclass);

--
-- Name: applicationkey_model_pkey; Type: CONSTRAINT; Owner: :"user_name"; Tablespace: 
--

ALTER TABLE ONLY applicationkey_model
    ADD CONSTRAINT applicationkey_model_pkey PRIMARY KEY (name);

--
-- Name: aspect_model_pkey; Type: CONSTRAINT; Owner: :"user_name"; Tablespace: 
--

ALTER TABLE ONLY aspect_model
    ADD CONSTRAINT aspect_model_pkey PRIMARY KEY (entity_name, entity_type, key);


--
-- Name: authenticator_model_pkey; Type: CONSTRAINT; Owner: :"user_name"; Tablespace: 
--

ALTER TABLE ONLY authenticator_model
    ADD CONSTRAINT authenticator_model_pkey PRIMARY KEY (name);


--
-- Name: dashboard_model_pkey; Type: CONSTRAINT; Owner: :"user_name"; Tablespace: 
--

ALTER TABLE ONLY dashboard_model
    ADD CONSTRAINT dashboard_model_pkey PRIMARY KEY (name);


--
-- Name: datashape_model_pkey; Type: CONSTRAINT; Owner: :"user_name"; Tablespace: 
--

ALTER TABLE ONLY datashape_model
    ADD CONSTRAINT datashape_model_pkey PRIMARY KEY (name);


--
-- Name: datatable_model_pkey; Type: CONSTRAINT; Owner: :"user_name"; Tablespace: 
--

ALTER TABLE ONLY datatable_model
    ADD CONSTRAINT datatable_model_pkey PRIMARY KEY (name);


--
-- Name: datatagvocabulary_model_pkey; Type: CONSTRAINT; Owner: :"user_name"; Tablespace: 
--

ALTER TABLE ONLY datatagvocabulary_model
    ADD CONSTRAINT datatagvocabulary_model_pkey PRIMARY KEY (name);


--
-- Name: directoryservice_model_pkey; Type: CONSTRAINT; Owner: :"user_name"; Tablespace: 
--

ALTER TABLE ONLY directoryservice_model
    ADD CONSTRAINT directoryservice_model_pkey PRIMARY KEY (name);


--
-- Name: group_model_pkey; Type: CONSTRAINT; Owner: :"user_name"; Tablespace: 
--

ALTER TABLE ONLY group_model
    ADD CONSTRAINT group_model_pkey PRIMARY KEY (name);


--
-- Name: localizationtable_model_pkey; Type: CONSTRAINT; Owner: :"user_name"; Tablespace: 
--

ALTER TABLE ONLY localizationtable_model
    ADD CONSTRAINT localizationtable_model_pkey PRIMARY KEY (name);


--
-- Name: log_model_pkey; Type: CONSTRAINT; Owner: :"user_name"; Tablespace: 
--

ALTER TABLE ONLY log_model
    ADD CONSTRAINT log_model_pkey PRIMARY KEY (name);


--
-- Name: mashup_model_pkey; Type: CONSTRAINT; Owner: :"user_name"; Tablespace: 
--

ALTER TABLE ONLY mashup_model
    ADD CONSTRAINT mashup_model_pkey PRIMARY KEY (name);


--
-- Name: mediaentity_model_pkey; Type: CONSTRAINT; Owner: :"user_name"; Tablespace: 
--

ALTER TABLE ONLY mediaentity_model
    ADD CONSTRAINT mediaentity_model_pkey PRIMARY KEY (name);


--
-- Name: menu_model_pkey; Type: CONSTRAINT; Owner: :"user_name"; Tablespace: 
--

ALTER TABLE ONLY menu_model
    ADD CONSTRAINT menu_model_pkey PRIMARY KEY (name);


--
-- Name: model_index_pkey; Type: CONSTRAINT; Owner: :"user_name"; Tablespace: 
--

ALTER TABLE ONLY model_index
    ADD CONSTRAINT model_index_pkey PRIMARY KEY (entity_name, entity_type);


--
-- Name: model_tag_index_pkey; Type: CONSTRAINT; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY tag_index
    ADD CONSTRAINT model_tag_index_pkey PRIMARY KEY (entity_name, vocabulary_name, term_name, tenant_id);


--
-- Name: modeltagvocabulary_model_pkey; Type: CONSTRAINT; Owner: :"user_name"; Tablespace: 
--

ALTER TABLE ONLY modeltagvocabulary_model
    ADD CONSTRAINT modeltagvocabulary_model_pkey PRIMARY KEY (name);


--
-- Name: vocabulary_terms; Type: CONSTRAINT; Owner: :"user_name"; Tablespace: 
--

ALTER TABLE ONLY vocabulary_terms
    ADD CONSTRAINT vocabulary_terms_pkey PRIMARY KEY (vocabulary_name, term_name, vocabulary_type);

    
--
-- Name: network_model_pkey; Type: CONSTRAINT; Owner: :"user_name"; Tablespace: 
--

ALTER TABLE ONLY network_model
    ADD CONSTRAINT network_model_pkey PRIMARY KEY (name);


--
-- Name: organization_model_pkey; Type: CONSTRAINT; Owner: :"user_name"; Tablespace: 
--

ALTER TABLE ONLY organization_model
    ADD CONSTRAINT organization_model_pkey PRIMARY KEY (name);


--
-- Name: persistenceprovider_model_pkey; Type: CONSTRAINT; Owner: :"user_name"; Tablespace: 
--

ALTER TABLE ONLY persistenceprovider_model
    ADD CONSTRAINT persistenceprovider_model_pkey PRIMARY KEY (name);


--
-- Name: persistenceproviderpackage_model_pkey; Type: CONSTRAINT; Owner: :"user_name"; Tablespace:
--

ALTER TABLE ONLY persistenceproviderpackage_model
    ADD CONSTRAINT persistenceproviderpackage_model_pkey PRIMARY KEY (name);


--
-- Name: project_model_pkey; Type: CONSTRAINT; Owner: :"user_name"; Tablespace:
--

ALTER TABLE ONLY project_model
    ADD CONSTRAINT project_model_pkey PRIMARY KEY (name);


--
-- Name: resource_model_pkey; Type: CONSTRAINT; Owner: :"user_name"; Tablespace: 
--

ALTER TABLE ONLY resource_model
    ADD CONSTRAINT resource_model_pkey PRIMARY KEY (name);


--
-- Name: root_entity_collection_pkey; Type: CONSTRAINT; Owner: :"user_name"; Tablespace: 
--

ALTER TABLE ONLY root_entity_collection
    ADD CONSTRAINT root_entity_collection_pkey PRIMARY KEY (name);


--
-- Name: scriptfunctionlibrary_model_pkey; Type: CONSTRAINT; Owner: :"user_name"; Tablespace: 
--

ALTER TABLE ONLY scriptfunctionlibrary_model
    ADD CONSTRAINT scriptfunctionlibrary_model_pkey PRIMARY KEY (name);


--
-- Name: statedefinition_model_pkey; Type: CONSTRAINT; Owner: :"user_name"; Tablespace: 
--

ALTER TABLE ONLY statedefinition_model
    ADD CONSTRAINT statedefinition_model_pkey PRIMARY KEY (name);


--
-- Name: stream_model_pkey; Type: CONSTRAINT; Owner: :"user_name"; Tablespace: 
--

ALTER TABLE ONLY stream_model
    ADD CONSTRAINT stream_model_pkey PRIMARY KEY (name);


--
-- Name: styledefinition_model_pkey; Type: CONSTRAINT; Owner: :"user_name"; Tablespace: 
--

ALTER TABLE ONLY styledefinition_model
    ADD CONSTRAINT styledefinition_model_pkey PRIMARY KEY (name);


--
-- Name: subsystem_model_pkey; Type: CONSTRAINT; Owner: :"user_name"; Tablespace: 
--

ALTER TABLE ONLY subsystem_model
    ADD CONSTRAINT subsystem_model_pkey PRIMARY KEY (name);


--
-- Name: thing_model_pkey; Type: CONSTRAINT; Owner: :"user_name"; Tablespace: 
--

ALTER TABLE ONLY thing_model
    ADD CONSTRAINT thing_model_pkey PRIMARY KEY (name);


--
-- Name: thingpackage_model_pkey; Type: CONSTRAINT; Owner: :"user_name"; Tablespace: 
--

ALTER TABLE ONLY thingpackage_model
    ADD CONSTRAINT thingpackage_model_pkey PRIMARY KEY (name);


--
-- Name: thingshape_model_pkey; Type: CONSTRAINT; Owner: :"user_name"; Tablespace: 
--

ALTER TABLE ONLY thingshape_model
    ADD CONSTRAINT thingshape_model_pkey PRIMARY KEY (name);


--
-- Name: thingtemplate_model_pkey; Type: CONSTRAINT; Owner: :"user_name"; Tablespace: 
--

ALTER TABLE ONLY thingtemplate_model
    ADD CONSTRAINT thingtemplate_model_pkey PRIMARY KEY (name);


--
-- Name: user_model_pkey; Type: CONSTRAINT; Owner: :"user_name"; Tablespace: 
--

ALTER TABLE ONLY user_model
    ADD CONSTRAINT user_model_pkey PRIMARY KEY (name);


--
-- Name: user_model_properties_pkey; Type: CONSTRAINT; Owner: :"user_name"; Tablespace: 
--

ALTER TABLE ONLY user_model_properties
    ADD CONSTRAINT user_model_properties_pkey PRIMARY KEY (entity_name, key);


--
-- Name: valuestream_model_pkey; Type: CONSTRAINT; Owner: :"user_name"; Tablespace: 
--

ALTER TABLE ONLY valuestream_model
    ADD CONSTRAINT valuestream_model_pkey PRIMARY KEY (name);


--
-- Name: widget_model_pkey; Type: CONSTRAINT; Owner: :"user_name"; Tablespace: 
--

ALTER TABLE ONLY widget_model
    ADD CONSTRAINT widget_model_pkey PRIMARY KEY (name);


--
-- Name: modeltagindex_entity_name_index; Type: INDEX; Owner: postgres; Tablespace: 
--

CREATE INDEX modeltagindex_entity_name_index ON tag_index USING btree (entity_name);


--
-- Name: modeltagindex_tag_index; Type: INDEX; Owner: postgres; Tablespace: 
--

CREATE INDEX modeltagindex_tag_index ON tag_index USING btree (vocabulary_name, term_name);


--
-- Name: modeltagindex_term_index; Type: INDEX; Owner: postgres; Tablespace: 
--

CREATE INDEX modeltagindex_term_index ON tag_index USING btree (lower((term_name)::text));


--
-- Name: modeltagindex_vocabulary_index; Type: INDEX; Owner: postgres; Tablespace: 
--

CREATE INDEX modeltagindex_vocabulary_index ON tag_index USING btree (vocabulary_name);


--
-- Name: systemversion_servername_index; Type: INDEX; Owner: postgres; Tablespace: 
--

CREATE INDEX systemversion_servername_index ON system_version USING btree (server_name);

--
-- Name: vocabularyterms_index; Type: INDEX; Owner: postgres; Tablespace: 
--

CREATE INDEX vocabularyterms_index ON vocabulary_terms USING btree (vocabulary_name, term_name, vocabulary_type);

--
-- Name: vocabularyterms_vocabulary_index; Type: INDEX; Owner: postgres; Tablespace: 
--

CREATE INDEX vocabularyterms_vocabulary_index ON vocabulary_terms USING btree (vocabulary_name, vocabulary_type);

--
-- Name: vocabularyterms_terms_index; Type: INDEX; Owner: postgres; Tablespace: 
--

CREATE INDEX vocabularyterms_terms_index ON vocabulary_terms USING btree (term_name, vocabulary_type);

--
-- Name: modelindex_project_name_index; Type: INDEX; Owner: postgres; Tablespace:
--

CREATE INDEX modelindex_project_name_index ON model_index USING btree (project_name);


-- Raises an exception if the specified Id does not match the most recent Id
-- within the 'system_ownership' table. The raised exception will have a code of
-- '28SOA', where the '28' categorizes this exception as an
-- 'invalid_authorization_specification' exception (i.e. error code '28000'),
-- and the custom value of 'SOA' stands for 'System Ownership Authorization'.
-- See the standard XOPEN and/or SQL:2003 error codes for more information.
CREATE FUNCTION fail_if_not_system_owner(system_ownership_id system_ownership.id%TYPE)
    RETURNS VOID
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF NOT EXISTS (
            SELECT id 
            FROM system_ownership 
            WHERE id IN (SELECT id FROM system_ownership ORDER BY took_ownership DESC LIMIT 1)
            AND id = system_ownership_id )
    THEN
        -- '28SOA' is a combination of the '28000' error code mask (i.e. 
        -- 'invalid_authorization_specification'), plus 'SOA' for (S)ystem 
        -- (O)wnership (A)uthorization.
        RAISE EXCEPTION SQLSTATE '28SOA' USING MESSAGE = 'Database access prohibited because System Ownership has been lost.';
    END IF;    
END;
$$;
  
ALTER FUNCTION fail_if_not_system_owner(system_ownership.id%TYPE) OWNER TO :"user_name";



--
-- Thingworx Platform Version 7.1 PostgreSQL database model schema complete
--
