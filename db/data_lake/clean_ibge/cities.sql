/*
 * IBGE cities data cleaning
 * 
 * Create table clean_ibge.cities table
*/

-- Create new clean ibge district
create schema if not exists clean_ibge; 

-- Creating clean census block table
drop table if exists clean_ibge.cities;
create table clean_ibge.cities as (
	select
		c.cd_mun::int as id_city,
		c.nm_mun as city_name,
		c.sigla_uf as state_uf,
		c.area_km2 as city_area_km2,
		st_transform(c.wkb_geometry,4326) as geom
	from raw_ibge.cities c
	order by 1
);

--Create geometric index
drop index if exists cities_geom_idx;
create index cities_geom_idx 
  on clean_ibge.cities 
  using GIST(geom);
 
-- Vacuum and Analyze the table
vacuum analyze clean_ibge.cities;