-- 01_setup_schema.sql
-- Database and schema setup for AI-Assisted Home & Building Inspection

CREATE DATABASE IF NOT EXISTS SAFE_NEST_AI;
CREATE SCHEMA IF NOT EXISTS SAFE_NEST_AI.INSPECTION;

USE DATABASE SAFE_NEST_AI;
USE SCHEMA INSPECTION;

CREATE OR REPLACE TABLE INSPECTIONS (
  inspection_id STRING,
  room_id STRING,
  inspection_note STRING,
  image_label STRING,
  inspection_date DATE
);

CREATE OR REPLACE TABLE PROPERTIES (
  property_id STRING,
  location STRING,
  build_status STRING
);

CREATE OR REPLACE TABLE ROOMS (
  room_id STRING,
  property_id STRING,
  room_type STRING
);
