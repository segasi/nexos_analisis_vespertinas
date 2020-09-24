### Cargar paquetes, definir setup y tema de gráficas ----
source("02_codigo/00_paquetes_setup_tema.R") 

### Importar transcripciones de conferencias vespertinas ----

# Definir URLs que contienen los discursos ----

url_transcripciones <-
  tibble(url = c("https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-secretaria-de-salud-informe-diario-sobre-coronavirus-covid-19-en-mexico?idiom=es", 
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-covid-19-en-mexico-secretaria-de-salud?idiom=es", 
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-covid-19-en-mexico-secretaria-de-salud-236389?idiom=es", 
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-secretaria-de-salud?idiom=es",
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-secretaria-de-salud-236648?idiom=es",
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-secretaria-de-salud-236726?idiom=es",
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-informe-diario-sobre-coronavirus-covid-19-en-mexico-secretaria-de-salud?idiom=es", 
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-informe-diario-sobre-coronavirus-covid-19-en-mexico-secretaria-de-salud-236979?idiom=es", 
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-informe-diario-sobre-coronavirus-covid-19-en-mexico-secretaria-de-salud-236995?idiom=es", 
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-informe-diario-sobre-coronavirus-covid-19-en-mexico-secretaria-de-salud-237135?idiom=es", 
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico?idiom=es"
                 , "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-237500?idiom=es",
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-237799?idiom=es",
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-237932?idiom=es",
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-237955?idiom=es",
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-237970?idiom=es", 
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-237991?idiom=es", 
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-238145?idiom=es", 
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-238381?idiom=es", 
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-238467?idiom=es",
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-238640?idiom=es", 
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-238671?idiom=es", 
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-238712?idiom=es", 
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-238806?idiom=es", 
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-238857?idiom=es", 
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-238974?idiom=es", 
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-239067?idiom=es", 
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-239144?idiom=es", 
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-239159?idiom=es", 
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-239175?idiom=es",
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-239280?idiom=es",
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-239407?idiom=es",
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-239541?idiom=es",
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-239626?idiom=es",
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-239712?idiom=es", 
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-239735?idiom=es",
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-239743?idiom=es", 
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-239818?idiom=es", 
                 "https://www.gob.mx/presidencia/es/articulos/conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico?idiom=es",
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-239987?idiom=es",
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-240054?idiom=es", 
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-240119?idiom=es", 
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-240164?idiom=es", 
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-240181?idiom=es",
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-240239?idiom=es", 
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-240295?idiom=es", 
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-240384?idiom=es", 
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-240448?idiom=es",
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-240538?idiom=es", 
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-240551?idiom=es",
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-240565?idiom=es",
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-240664?idiom=es", 
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-240728?idiom=es",
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-240808?idiom=es", 
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-240911?idiom=es", 
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-240978?idiom=es", 
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-241021?idiom=es", 
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-241040?idiom=es", 
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-241196?idiom=es", 
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-241284?idiom=es", 
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-241338?idiom=es", 
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-241395?idiom=es", 
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-241430?idiom=es",
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-241477?idiom=es", 
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-241493?idiom=es", 
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-241579?idiom=es", 
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-241652?idiom=es",
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-241782?idiom=es",
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-241956?idiom=es", 
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-242051?idiom=es",
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-242068?idiom=es", 
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-242089?idiom=es",
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-242221?idiom=es",
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-242425?idiom=es", 
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-242612?idiom=es",
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-242689?idiom=es", 
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-242822?idiom=es",
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-242854?idiom=es", 
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-242899?idiom=es", 
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-243257?idiom=es", 
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-243353?idiom=es", 
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-243433?idiom=es", 
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-243570?idiom=es",
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-243643?idiom=es",
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-243681?idiom=es", 
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-243705?idiom=es", 
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-243764?idiom=es", 
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-243827?idiom=es",
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-243889?idiom=es", 
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-243972?idiom=es", 
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-244060?idiom=es", 
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-244085?idiom=es",
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-244103?idiom=es",
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-244201?idiom=es", 
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-244291?idiom=es", 
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-244358?idiom=es",
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-244457?idiom=es", 
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-244586?idiom=es", 
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-244616?idiom=es", 
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-244662?idiom=es", 
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-244777?idiom=es",
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-244845?idiom=es", 
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-244949?idiom=es", 
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-245171?idiom=es", 
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-245317?idiom=es",
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-245333?idiom=es", 
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-245367?idiom=es", 
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-245481?idiom=es", 
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-245590?idiom=es",
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-245743?idiom=es", 
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-245811?idiom=es", 
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-245888?idiom=es", 
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-245909?idiom=es", 
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-245945?idiom=es",
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-246052?idiom=es",
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-246131?idiom=es", 
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-246217?idiom=es", 
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-246314?idiom=es", 
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-246405?idiom=es", 
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-246439?idiom=es", 
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-246467?idiom=es", 
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-246636?idiom=es", 
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-247023?idiom=es", 
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-247129?idiom=es", 
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-247228?idiom=es", 
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-247341?idiom=es", 
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-247373?idiom=es", 
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-247390?idiom=es", 
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-247486?idiom=es", 
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-247599?idiom=es",
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-247669?idiom=es", 
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-247759?idiom=es", 
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-247862?idiom=es", 
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-247976?idiom=es", 
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-248005?idiom=es", 
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-248101?idiom=es", 
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-248165?idiom=es", 
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-248274?idiom=es", 
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-248360?idiom=es", 
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-248428?idiom=es", 
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-248453?idiom=es",
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-248467?idiom=es",
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-248589?idiom=es", 
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-248660?idiom=es", 
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-248749?idiom=es",
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-248815?idiom=es", 
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-248879?idiom=es", 
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-248898?idiom=es",
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-248927?idiom=es", 
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-249024?idiom=es",
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-249095?idiom=es", 
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-249169?idiom=es",
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-249222?idiom=es", 
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-249304?idiom=es", 
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-249343?idiom=es", 
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-249359?idiom=es",
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-249441?idiom=es", 
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-249516?idiom=es", 
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-249605?idiom=es", 
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-249683?idiom=es", 
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-249809?idiom=es", 
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-249831?idiom=es",
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-249853?idiom=es", 
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-250012?idiom=es", 
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-250074?idiom=es", 
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-250133?idiom=es", 
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-250194?idiom=es", 
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-250326?idiom=es", 
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-250342?idiom=es", 
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-250365?idiom=es", 
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-250435?idiom=es", 
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-250508?idiom=es", 
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-250595?idiom=es", 
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-250674?idiom=es", 
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-250769?idiom=es",
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-250803?idiom=es", 
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-250838?idiom=es", 
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-250945?idiom=es", 
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-251047?idiom=es", 
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-251140?idiom=es", 
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-251229?idiom=es",
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-251374?idiom=es", 
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-251391?idiom=es", 
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-251414?idiom=es",
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-251503?idiom=es", 
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-251567?idiom=es", 
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-251625?idiom=es",
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-251703?idiom=es", 
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-251902?idiom=es",
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-251937?idiom=es",
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-251971?idiom=es",
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-252065?idiom=es",
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-252216?idiom=es",
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-252305?idiom=es",
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-252361?idiom=es",
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-252450?idiom=es",
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-252480?idiom=es",
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-252497?idiom=es",
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-252568?idiom=es",
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-252824?idiom=es",
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-252916?idiom=es",
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-252948?idiom=es",
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-252981?idiom=es",
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-253050?idiom=es",
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-253118?idiom=es",
                 "https://www.gob.mx/presidencia/es/articulos/version-estenografica-conferencia-de-prensa-informe-diario-sobre-coronavirus-covid-19-en-mexico-253183?idiom=es")) 


# Extraer discursos ----
transcripciones  <- 
  url_transcripciones %>% 
  mutate(cuerpo = map(.x = url,
                      .f = ~ read_html(.) %>% 
                        html_nodes(".article-body")))  

transcripciones  <- 
  transcripciones %>%
  mutate(texto = map_chr(cuerpo, ~ html_nodes(.x, "p") %>%
                           html_text() %>%
                           paste0(collapse = " ")))

# Extraer fechas de conferencia ----
fechas_conferencia <- 
  url_transcripciones  %>% 
  mutate(fecha = map(.x = url,
                     .f = ~ read_html(.) %>% 
                       html_nodes(".border-box")))

fechas_conferencia <- 
  fechas_conferencia %>% 
  mutate(fecha = map_chr(fecha, ~ html_nodes(.x, "dd") %>%
                           html_text() %>%
                           paste0(collapse = " ")),
         fecha = str_replace(fecha, "Presidencia de la República  ", "")) # Limpiar fechas eliminando la cadena de texto "Presidencia de la República  " de las mismas


# Extraer títulos de conferencias ----
titulo_conferencia <- 
  url_transcripciones  %>% 
  mutate(titulo = map(.x = url,
                      .f = ~ read_html(.) %>% 
                        html_nodes("title") %>% 
                        html_text()))

# Cambiar tipo y limpiar columna de titulo 
titulo_conferencia <- 
  titulo_conferencia %>% 
  mutate(titulo = unlist(titulo), 
         titulo = str_replace_all(titulo, "\\n", ""),
         titulo = str_trim(titulo))

# Unir datos en un solo data frame ----
transcripciones  <- 
  transcripciones  %>% 
  left_join(fechas_conferencia) %>% 
  left_join(titulo_conferencia) %>% 
  select(fecha, titulo, texto, url, -cuerpo)

# Generar columna con id numérico por conferencia ----
transcripciones  <- 
  transcripciones  %>% 
  mutate(vespertina_id = row_number()) %>% 
  select(vespertina_id, everything())

### Guardar transcripciones como archivo .RData ----
save(transcripciones, file = "04_datos_output/transcripciones.RData")
