/*
 * IBGE census blocks data cleaning
 * 
 * Create table clean_ibge.census_blocks based on raw_ibge.census_blocks
 * SID: 4326
*/

-- Create new clean ibge district
create schema if not exists clean_ibge; 

-- Creating clean census block table
drop table if exists clean_ibge.census_blocks;
create table clean_ibge.census_blocks as (
	select
		nullif(cb.geocodigo_setor,'')::bigint as id_block,
		nullif(cb.geocodigo_municipio,'')::int as id_city,
		nullif(cb.municipio,'') as city_name,
		nullif(cb.distrito,'') as district_name,
		coalesce(nullif(cb.sub_distrito,''), cb.distrito) as sub_district_name,
		nullif(cb.bairro, '') as neighborhood_name,
		cb.wkb_geometry as geom
	from raw_ibge.census_blocks cb
	order by nullif(geocodigo_setor,'')::bigint
);

--Drop index
drop index if exists census_blocks_geom_idx;

--Create geometric index
create index if not exists census_blocks_geom_idx 
  on clean_ibge.census_blocks 
  using GIST(geom);
  
-- Vacuum and Analyze the table
vacuum analyze clean_ibge.census_blocks;