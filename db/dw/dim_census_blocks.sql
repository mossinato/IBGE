/*
 * IBGE census blocks data cleaning
 * 
 * Create table clean_ibge.census_blocks based on raw_ibge.census_blocks
 * SID: 4326
*/

-- Create schema
create schema if not exists dw; 

-- Create table
drop table if exists dw.dim_census_blocks;
create table dw.dim_census_blocks as (
	select
		cb.id_block as id_block,
		cb.id_city as id_city,
		cb.neighborhood_name as neighborhood_name,
		initcap(cb.sub_district_name) as sub_district_name,
		initcap(cb.district_name) as district_name,
		c.city_name as city_name,
		c.state_uf as state_uf,
		cb.geom as geom
	from clean_ibge.cities c 
		left join clean_ibge.census_blocks cb
			on st_intersects(c.geom,cb.geom)
	order by 1
);


--Drop index
drop index if exists census_blocks_geom_idx;

--Create geometric index
create index if not exists census_blocks_geom_idx 
  on dw.dim_census_blocks 
  using GIST(geom);
  
-- Vacuum and Analyze the table
vacuum analyze dw.dim_census_blocks;