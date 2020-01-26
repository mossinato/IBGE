# IBGE
Analysis on Census and PNAD data

## Creating and actvating a Virtual Env
`conda create -n IBGE_env python=3.5.4`

`conda activate IBGE_env`

## Getting IBGE data
[Download census sectors (Setores Censitários)](https://ftp.ibge.gov.br/organizacao_do_territorio/malhas_territoriais/malhas_de_setores_censitarios__divisoes_intramunicipais/censo_2010/)

rename kmz files to .zip

`mv 35-SP_Capital.kmz 35-SP_Capital.zip`

unzip kml file

`unzip 35-SP_Capital.zip`

rename kml

`mv doc.kml 35-SP_Capital.kml`

convert to geojson
`k2g 35-SP_Capital.kml PATH_TO_GEOJSON/`


[Download grouped data by census sectors](https://www.ibge.gov.br/estatisticas/downloads-estatisticas.html)
`Censos/Censo_Demografico_2010/Resultados_do_Universo/Agregados_por_Setores_Censitários/`

