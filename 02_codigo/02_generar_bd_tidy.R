### Cargar paquetes, definir setup y tema de gráficas ----
source("02_codigo/00_paquetes_setup_tema.R") 

### Importar datos ----

# En esta base de datos hay un renglón por conferencia vespertina, por lo que la columna "texto" incluye toda la transcripción del respectivo día. 
load("04_datos_output/transcripciones.RData")


### Transformaciones diversas ----

# En esta sección realizo diversas transformaciones a la base de datos recién importada para construir un tibble que tenga un diálogo por renglón, así como para separar en tres columnas i) el nombre de quién lo dijo, ii) su cargo (si es que lo tiene) y iii) el diálogo como tal


## Agregar el caracter "~" al principio del nombre de cada persona que habló en una vespertina para posteriormente poder separar cada diálogo en un renglón ----
bd_vespertinas <- 
  transcripciones %>% 
  # Eliminar espacios en blanco al comienzo/final de cadenas de texto, así como espacios dobles entre palabras
  mutate(texto = str_trim(texto, side = "both"),
         texto = str_squish(texto)) %>% 
  # Agregar "~" antes del nombre de cada persona que habló en alguna de las vespertinas. Construí esta lista a partir de inspeccionar visualmente las transcripciones, en un proceso iterativo. Es probable que se me hayan escapado algunas personas. Si es así y las detectas, te agradeceré que me avises para mejorar el código :).
  mutate(texto = str_replace_all(texto, "MARCELO EBRARD", "~MARCELO EBRARD"),
         texto = str_replace_all(texto, "ESTEBAN MOCTEZUMA", "~ESTEBAN MOCTEZUMA"),
         texto = str_replace_all(texto, "LUIS CRESENCIO", "~LUIS CRESENCIO"),
         texto = str_replace_all(texto, "JOSÉ RAFAEL OJEDA", "~JOSÉ RAFAEL OJEDA"),
         texto = str_replace_all(texto, "GRACIELA MÁRQUEZ", "~GRACIELA MÁRQUEZ"),
         texto = str_replace_all(texto, "MARÍA LUISA ALBORES", "~MARÍA LUISA ALBORES"),
         texto = str_replace_all(texto, "MIGUEL TORRUCO", "~MIGUEL TORRUCO"),
         texto = str_replace_all(texto, "JORGE ALCOCER", "~JORGE ALCOCER"),
         texto = str_replace_all(texto, "JORGE CARLOS ALCOCER", "~JORGE CARLOS ALCOCER"),
         texto = str_replace_all(texto, "HUGO LÓPEZ-GATELL", "~HUGO LÓPEZ-GATELL"),
         texto = str_replace_all(texto, "PRESIDENTE ANDRÉS MANUEL LÓPEZ OBRADOR", "~HUGO LÓPEZ-GATELL RAMÍREZ"),
         texto = str_replace_all(texto, "JOSÉ LUIS ALOMÍA", "~JOSÉ LUIS ALOMÍA"),
         texto = str_replace_all(texto, "JOSÉ LUIS ALOMIA", "~JOSÉ LUIS ALOMÍA"),
         texto = str_replace_all(texto, "OSÉ LUIS ALOMÍA ZEGARRA, DIRECTOR GENERAL DE EPIDEMIOLOGÍA: Buenas noches,", "~JOSÉ LUIS ALOMÍA ZEGARRA, DIRECTOR GENERAL DE EPIDEMIOLOGÍA: Buenas noches,"),
         texto = str_replace_all(texto, "RICARDO CORTÉS", "~RICARDO CORTÉS"),
         texto = str_replace_all(texto, "RUY LÓPEZ", "~RUY LÓPEZ"),
         texto = str_replace_all(texto, "RUY LOPEZ", "~RUY LÓPEZ"),
         texto = str_replace_all(texto, "VÍCTOR HUGO BORJA", "~VÍCTOR HUGO BORJA"),
         texto = str_replace_all(texto, ". HUGO BORJA", ". ~HUGO BORJA"),
         texto = str_replace_all(texto, "GUSTAVO REYES TERÁN", "~GUSTAVO REYES TERÁN"),
         texto = str_replace_all(texto, "GUSTAVO REYÉS TERÁN", "~GUSTAVO REYES TERÁN"),
         texto = str_replace_all(texto, "ZOÉ ROBLEDO ABURTO", "~ZOÉ ROBLEDO ABURTO"),
         texto = str_replace_all(texto, "CLAUDIA SHEINBAUM", "~CLAUDIA SHEINBAUM"),
         texto = str_replace_all(texto, "CLAUDIA SHEIUNBAUM", "~CLAUDIA SHEINBAUM"),
         texto = str_replace_all(texto, "MIGUEL BARBOSA", "~MIGUEL BARBOSA"),
         texto = str_replace_all(texto, "JUAN MANUEL CARRERAS", "~JUAN MANUEL CARRERAS"), 
         texto = str_replace_all(texto, "CARLOS MENDONZA DAVIS", "~CARLOS MENDOZA DAVIS"),
         texto = str_replace_all(texto, "CARLOS MENDOZA DAVIS", "~CARLOS MENDOZA DAVIS"),
         texto = str_replace_all(texto, "RUTILIO ESCANDÓN", "~RUTILIO ESCANDÓN"),
         texto = str_replace_all(texto, "ADÁN AUGUSTO LÓPEZ", "~ADÁN AUGUSTO LÓPEZ"),
         texto = str_replace_all(texto, "JUAN ANTONIO FERRER", "~JUAN ANTONIO FERRER"),
         texto = str_replace_all(texto, "GUILLERMO RAFAEL SANTIAGO", "~GUILLERMO RAFAEL SANTIAGO"),
         texto = str_replace_all(texto, "GUILLERMO SANTIAGO", "~GUILLERMO RAFAEL SANTIAGO"),
         texto = str_replace_all(texto, "DAVID RAZÚ", "~DAVID RAZÚ"),
         texto = str_replace_all(texto, "SILVIA ROLDÁN", "~SILVIA ROLDÁN"),
         texto = str_replace_all(texto, "OLIVA LÓPEZ", "~OLIVA LÓPEZ"),
         texto = str_replace_all(texto, "DIANA TEJADILLA", "~DIANA TEJADILLA"),
         texto = str_replace_all(texto, "VÍCTOR SUÁREZ", "~VÍCTOR SUÁREZ "),
         texto = str_replace_all(texto, "LORENA RODRÍGUEZ-BORES", "~LORENA RODRÍGUEZ-BORES"),
         texto = str_replace_all(texto, "LORENA RODRÍGUEZ BORES", "~LORENA RODRÍGUEZ-BORES"),
         texto = str_replace_all(texto, "KARLA BERDICHEVSKY", "~KARLA BERDICHEVSKY"),
         texto = str_replace_all(texto, "GABRIELA RODRÍGUEZ", "~GABRIELA RODRÍGUEZ"),
         texto = str_replace_all(texto, "ALEJANDRA FRAUSTO", "~ALEJANDRA FRAUSTO"),
         texto = str_replace_all(texto, "NADINE GASMAN", "~NADINE GASMAN"),
         texto = str_replace_all(texto, "JUAN FRANCISCO GALÁN", "~JUAN FRANCISCO GALÁN"),
         texto = str_replace_all(texto, "MARÍA ELENA ÁLVAREZ", "~MARÍA ELENA ÁLVAREZ"),
         texto = str_replace_all(texto, "PAOLA VILLARREAL", "~PAOLA VILLARREAL"),
         texto = str_replace_all(texto, "ALEJANDRO SVARCH", "~ALEJANDRO SVARCH"),
         texto = str_replace_all(texto, "EVALINDA BARRÓN", "~EVALINDA BARRÓN"),
         texto = str_replace_all(texto, "ANA LUCÍA DE LA GARZA", "~ANA LUCÍA DE LA GARZA"),
         texto = str_replace_all(texto, "SIMÓN KAWA", "~SIMÓN KAWA"),
         texto = str_replace_all(texto, "LEYLA ACOSTA", "~LEYLA ACOSTA"),
         texto = str_replace_all(texto, "GADY ZABICKY", "~GADY ZABICKY"),
         texto = str_replace_all(texto, "LUZ MYRIAM REYNALES", "~LUZ MYRIAM REYNALES"),
         texto = str_replace_all(texto, "CRISTIAN ROBERTO MORALES FUHRIMANN RE", "~CRISTIAN ROBERTO MORALES FUHRIMANN, RE"),
         texto = str_replace_all(texto, "CRISTIAN ROBERTO MORALES", "~CRISTIAN ROBERTO MORALES"),
         texto = str_replace_all(texto, "CRISTIAN MORALES", "~CRISTIAN ROBERTO MORALES"),
         texto = str_replace_all(texto, "RICARDO BUCIO", "~RICARDO BUCIO"),
         texto = str_replace_all(texto, "MÓNICA MACCISE", "~MÓNICA MACCISE"),
         texto = str_replace_all(texto, "JORGE TREJO GÓMORA", "~JORGE TREJO GÓMORA"),
         texto = str_replace_all(texto, "DANIEL DÍAZ", "~DANIEL DÍAZ"),
         texto = str_replace_all(texto, "JUAN MANUEL QUIJADA", "~JUAN MANUEL QUIJADA"),
         texto = str_replace_all(texto, "JEAN MARC GABASTOU", "~JEAN MARC GABASTOU"),
         texto = str_replace_all(texto, "JEAN-MARC GABASTOU", "~JEAN-MARC GABASTOU"),
         texto = str_replace_all(texto, "MAURICIO HERNÁNDEZ", "~MAURICIO HERNÁNDEZ"),
         texto = str_replace_all(texto, "ALETHSE DE LA TORRE", "~ALETHSE DE LA TORRE"),
         texto = str_replace_all(texto, "CHRISTIAN ARTURO ZARAGOZA ", "~CHRISTIAN ARTURO ZARAGOZA "),
         texto = str_replace_all(texto, "GABRIEL GARCÍA RODRÍGUEZ", "~GABRIEL GARCÍA RODRÍGUEZ"),
         texto = str_replace_all(texto, "GUADALUPE MERCEDES LUCÍA GUERRERO", "~GUADALUPE MERCEDES LUCÍA GUERRERO"),
         texto = str_replace_all(texto, "MINERVA LARA FUENTES", "~MINERVA LARA FUENTES"),
         texto = str_replace_all(texto, "JUAN RIVERA DOMMARCO", "~JUAN ÁNGEL RIVERA DOMMARCO"),
         texto = str_replace_all(texto, "JUAN ÁNGEL RIVERA DOMMARCO", "~JUAN ÁNGEL RIVERA DOMMARCO"),
         texto = str_replace_all(texto, "\\(\\(INICIA VIDEO", "~\\(\\(INICIA VIDEO"),
         texto = str_replace_all(texto, "\\(INICIA VIDEO", "~\\(INICIA VIDEO"),
         texto = str_replace_all(texto, "\\(PROYECCIÓN DE VIDEO", "~\\(PROYECCIÓN DE VIDEO"),
         texto = str_replace_all(texto, "\\(\\(FINALIZA VIDEO", "~\\(\\(FINALIZA VIDEO"),
         texto = str_replace_all(texto, "\\(FINALIZA VIDEO", "~\\(\\(FINALIZA VIDEO"),
         texto = str_replace_all(texto, "\\(FIN DE VIDEO", "~\\(FIN DE VIDEO"),
         texto = str_replace_all(texto, "\\(FIN DEL VIDEO", "~\\(FIN DEL VIDEO"),
         texto = str_replace_all(texto, "\\(TERMINA VIDEO", "~\\(\\(FINALIZA VIDEO"),
         texto = str_replace_all(texto, "JENARO VILLAMIL", "~JENARO VILLAMIL"),
         texto = str_replace_all(texto, "JOSÉ ANTONIO MARTÍNEZ", "~JOSÉ ANTONIO MARTÍNEZ"),
         texto = str_replace_all(texto, "GISELA LARA", "~GISELA LARA"),
         texto = str_replace_all(texto, "ITALY MIGUEL", "~ITALY MIGUEL"),
         texto = str_replace_all(texto, "RODOLFO LEHMANN", "~RODOLFO LEHMANN"),
         texto = str_replace_all(texto, "MANUEL CERVANTES", "~MANUEL CERVANTES"),
         texto = str_replace_all(texto, "FABIANA ZEPEDA", "~FABIANA ZEPEDA"),
         texto = str_replace_all(texto, "FELIPE CRUZ", "~FELIPE CRUZ"),
         texto = str_replace_all(texto, "LUCIANO CONCHEIRO", "~LUCIANO CONCHEIRO"),
         texto = str_replace_all(texto, "MIRALDA AGUILAR", "~MIRALDA AGUILAR"),
         texto = str_replace_all(texto, "ANABELLE BONVECCHIO ARENAS", "~ANABELLE BONVECCHIO ARENAS"),
         texto = str_replace_all(texto, "LUIS ANTONIO RAMÍREZ", "~LUIS ANTONIO RAMÍREZ"),
         texto = str_replace_all(texto, "ANA DE LA GARZA", "~ANA DE LA GARZA"),
         texto = str_replace_all(texto, "DIANA IRIS TEJADILLA", "~DIANA IRIS TEJADILLA"),
         texto = str_replace_all(texto, "DIANA TEJADILLA", "~DIANA IRIS TEJADILLA"),
         texto = str_replace_all(texto, "DONATO AUGUSTO CASAS", "~DONATO AUGUSTO CASAS"),
         texto = str_replace_all(texto, "ERNESTO ACEVEDO", "~ERNESTO ACEVEDO"),
         texto = str_replace_all(texto, "ERNESTO RAMÍIREZ", "~ERNESTO RAMÍREZ"),
         texto = str_replace_all(texto, "ERNESTINA GODOY", "~ERNESTINA GODOY"),
         texto = str_replace_all(texto, "GABRIEL YORIO", "~GABRIEL YORIO"),
         texto = str_replace_all(texto, "LUIS HERNÁNDEZ PALACIOS", "~LUIS HERNÁNDEZ PALACIOS"),
         texto = str_replace_all(texto, "CATALINA GÓMEZ", "~CATALINA GÓMEZ"),
         texto = str_replace_all(texto, "ALEJANDRO PEREA", "~ALEJANDRO PEREA"),
         texto = str_replace_all(texto, "JOAQUÍN ZEBADÚA", "~JOAQUÍN ZEBADÚA"),
         texto = str_replace_all(texto, "MARÍA ISABEL LÓPEZ LÓPEZ", "~MARÍA ISABEL LÓPEZ LÓPEZ"),
         texto = str_replace_all(texto, "SIMÓN BARQUERA", "~SIMÓN BARQUERA"),
         texto = str_replace_all(texto, "TERESA SHAMAH", "~TERESA SHAMAH"),
         texto = str_replace_all(texto, "SANDRA MOYA", "~SANDRA MOYA"),
         texto = str_replace_all(texto, "JORGE GONZÁLEZ OLVERA", "~JORGE JULIO GONZÁLEZ OLVERA"),
         texto = str_replace_all(texto, "JORGE JULIO GONZÁLEZ OLVERA", "~JORGE JULIO GONZÁLEZ OLVERA"),
         texto = str_replace_all(texto, "JOSÉ IGNACIO SANTOS", "~JOSÉ IGNACIO SANTOS"),
         texto = str_replace_all(texto, "MARCELINA BAUTISTA", "~MARCELINA BAUTISTA"),
         texto = str_replace_all(texto, "DIANA:", "~DIANA:"),
         texto = str_replace_all(texto, "MATTHIAS SACHSE", "~MATTHIAS SACHSE"),
         texto = str_replace_all(texto, "GIANCARLO SUMMA", "~GIANCARLO SUMMA:"),
         texto = str_replace_all(texto, "MIRIAM", "~MIRIAM"),
         texto = str_replace_all(texto, "CHRISTIAN SKOOG", "~CHRISTIAN SKOOG"),
         texto = str_replace_all(texto, "EDUARDO ROBLES", "~EDUARDO ROBLES"),
         texto = str_replace_all(texto, "IVONNE NÚÑEZ", "~IVONNE NÚÑEZ"),
         texto = str_replace_all(texto, "NORMA PATRICIA TORRES", "~NORMA PATRICIA TORRES"),
         texto = str_replace_all(texto, "JUAN ARTURO SABINES", "~JUAN ARTURO SABINES"),
         texto = str_replace_all(texto, "NADIA ROBLES", "~NADIA ROBLES"),
         texto = str_replace_all(texto, "EMMANUEL SARMIENTO", "~EMMANUEL SARMIENTO"),
         texto = str_replace_all(texto, "MIGUEL MALO", "~MIGUEL MALO"),
         texto = str_replace_all(texto, "LUIS MIGUEL GUTIÉRREZ", "~LUIS MIGUEL GUTIÉRREZ"),
         texto = str_replace_all(texto, "MARLÉN VICENTE MARTÍNEZ", "~MARLÉN VICENTE MARTÍNEZ"),
         texto = str_replace_all(texto, "ALEJANDRO CALDERÓN", "~ALEJANDRO CALDERÓN"),
         texto = str_replace_all(texto, "LUISA GIL", "~LUISA GIL"),
         texto = str_replace_all(texto, "NORMA ANGÉLICA GÓMEZ", "~NORMA ANGÉLICA GÓMEZ"),
         texto = str_replace_all(texto, "SANTA ELIZABETH CEBALLOS", "~SANTA ELIZABETH CEBALLOS"),
         texto = str_replace_all(texto, "ARTURO GALINDO", "~ARTURO GALINDO"),
         texto = str_replace_all(texto, "GUILLERMO PEÑALOZA", "~GUILLERMO PEÑALOZA"),
         
         texto = str_replace_all(texto, "JOSÉ SALVADOR ABURTO MORALES", "~JOSÉ SALVADOR ABURTO MORALES"),
         
         
         texto = str_replace_all(texto, "MODERADOR:", "~MODERADOR:"),
         texto = str_replace_all(texto, "PREGUNTA:", "~PREGUNTA:"),
         texto = str_replace_all(texto, "INTERLOCUTORA:", "~INTERLOCUTORA:"),
         texto = str_replace_all(texto, "INTERLOCUTOR:", "~INTERLOCUTOR:"),
         texto = str_replace_all(texto, "INTERVENCIÓN:", "~INTERVENCIÓN:")) %>% 
  # Corregir error de puntuación en transcripción del 17/07/2020; en otras transcripciones en donde no incluyeron ":" al comienzo del diálogo de quien habla; y en otras más quien transcribió el diálogo no identificó a quien lo dijo. Para todas estas correcciones hice una inspección visual directa de la transcripción
  mutate(texto = str_replace(texto, "\\.Son ", " Son "),
         texto = str_replace(texto, " BARROSO En ", " BARROSO: En "),
         texto = str_replace(texto, "SALUD Muchas gracias", "SALUD: Muchas gracias"),
         texto = str_replace(texto, "ESPECIALIDAD Gracias", "ESPECIALIDAD: Gracias"),
         texto = str_replace(texto, "INICIA VIDEO\\) VOZ MUJER", "INICIA VIDEO\\): VOZ MUJER"),
         texto = str_replace(texto, "INICIA VIDEO\\) VOZ HOMBRE", "INICIA VIDEO\\): VOZ HOMBRE"),
         texto = str_replace(texto, "INICIA VIDEO LOS QUEHACERES COMO TAREA COMPARTIDA\\) INTERVENCIÓN HOMBRE", "INICIA VIDEO LOS QUEHACERES COMO TAREA COMPARTIDA\\): INTERVENCIÓN HOMBRE"),
         texto = str_replace(texto, "INICIA VIDEO\\)\\)", "INICIA VIDEO\\)\\):"),
         texto = str_replace(texto, "INICIA VIDEO\\)", "INICIA VIDEO\\):"),
         texto = str_replace(texto, "HUGO LÓPEZ-GATELL RAMÍREZ \\(7 de marzo 2020\\)", "INICIA VIDEO\\)\\): HUGO LÓPEZ-GATELL RAMÍREZ \\(7 de marzo 2020\\)"),
         texto = str_replace(texto, "HUGO LÓPEZ-GATELL RAMÍREZ \\(11 de abril de 2020\\)", "INICIA VIDEO\\)\\): HUGO LÓPEZ-GATELL RAMÍREZ \\(11 de abril de 2020\\)"),
         texto = str_replace(texto, "\\(\\(FINALIZA VIDEO\\) Epidemia larga", "HUGO LÓPEZ-GATELL RAMÍREZ: Epidemia larga"),
         texto = str_replace(texto, "\\(\\(FINALIZA VIDEO\\) Usa tu cubrebocas, se llama este video", "HUGO LÓPEZ-GATELL RAMÍREZ: Usa tu cubrebocas, se llama este video"),
         texto = str_replace_all(texto, "PREGUNA:", "~PREGUNTA:")) 

## Separar texto para tener cada diálogo en un renglón ----
bd_vespertinas <- 
  bd_vespertinas %>%
  separate_rows(texto,
                sep = "~")  

## Separar texto para tener en una columna el nombre de la persona que habló  y en la otra lo que dijo ----
bd_vespertinas <- 
  bd_vespertinas %>%
  separate(texto, c("nombre", "dialogo"), sep = ": ", extra = "merge")  

# Nota: el mensaje de advertencia aparece porque no en todos los renglones encontró ":" y un diálogo; en estos casos agregó NAs. En el siguiente paso elimino los renglones con valor NA en diálogo


## Eliminar renglones ----

# En donde i) la columna nombre está vacía. En todos los casos la columna diálogo tiene valor de NA; ii) en donde la columna dialogo tiene valor NA, y la columna nombre no está vacía, pero tiene como valor "(FINALIZA VIDEO)" o algo equivalente; y, iii) donde la columna dialogo tiene valor "", y la columna nombre no está vacía, pero tiene como valor "(INICIA VIDEO)" o algo equivalente
bd_vespertinas <- 
  bd_vespertinas %>% 
  filter(nombre != "",
         !is.na(dialogo),
         dialogo != "") 

## Eliminar posibles espacios vacíos al comienzo/final de las cadenas de texto en las variables nombre y dialogo, así como posibles espacios dobles entre palabras en las mismas variables ----
bd_vespertinas <- 
  bd_vespertinas %>% 
  mutate(nombre = str_trim(nombre, side = "both"),
         nombre = str_squish(nombre),
         dialogo = str_trim(dialogo, side = "both"),
         dialogo = str_squish(dialogo))


### Buscar palabras en mayúscula precedidas por ":" para verificar si no se me escapó algún diálogo ----

# Nota: todos los diálogos que ocurrieron en un video los dejé dentro del diálogo correspondiente al video 
bd_vespertinas %>%
  mutate(errores = str_extract_all(dialogo, "([A-ZÍÓÁÚÉ]{2,}.:)")) %>% 
  select(errores) %>% 
  unnest(errores) %>% 
  count(errores, sort = T) %>% 
  print(n = 100) 



## Homogeneizar nombres de quienes han emitido al menos un diálogo en una conferencia vespertina ----
bd_vespertinas <- 
  bd_vespertinas %>% 
  mutate(nombre = str_replace(nombre, "ZEGARRA D", "ZEGARRA, D"),
         nombre = str_replace(nombre, "GIANCARLO SUMMA:", "GIANCARLO SUMMA"),
         nombre = str_to_title(nombre),
         nombre = str_replace(nombre, " De ", " de "),
         nombre = str_replace(nombre, " La ", " la "),
         nombre = case_when(str_detect(nombre, "Inicia Video") ~ "Inicia video",
                            str_detect(nombre, "Proyección de Video") ~ "Inicia video",
                            str_detect(nombre, "Adán Augusto López") ~ "Adán Augusto López Hernández",
                            str_detect(nombre, "Alethse de la Torre") ~ "Alethse de la Torre Rosas",
                            str_detect(nombre, "Ana de la Garza Barroso") ~ "Ana Lucía de la Garza Barroso",
                            str_detect(nombre, "Evalinda Barrón") ~ "Evalinda Barrón Velázquez",
                            str_detect(nombre, "Hugo López-Gatell") ~ "Hugo López-Gatell Ramírez",
                            str_detect(nombre, "Jean Marc Gabastou") ~ "Jean-Marc Gabastou",
                            str_detect(nombre, "Joaquín Zebadúa") ~ "Joaquín Zebadúa Alba",
                            str_detect(nombre, "Jorge Alcocer Varela") ~ "Jorge Carlos Alcocer Varela",
                            str_detect(nombre, "José Luis Alomía") ~ "José Luis Alomía Zegarra",
                            str_detect(nombre, "Juan Manuel Quijada") ~ "Juan Manuel Quijada Gaytán",
                            str_detect(nombre, "Lorena Rodríguez-Bores") ~ "Lorena Rodríguez-Bores Ramírez",
                            str_detect(nombre, "Marcelina Bautista") ~ "Marcelina Bautista Bautista ",
                            str_detect(nombre, "María Elena Álvarez Buylla") ~ "María Elena Álvarez-Buylla",
                            str_detect(nombre, "Mauricio Hernández") ~ "Mauricio Hernández Ávila",
                            str_detect(nombre, "Miguel Torruco") ~ "Miguel Torruco Marqués",
                            str_detect(nombre, "Nadine Gasman Zylberman") ~ "Nadine Gasman Zylbermann",
                            str_detect(nombre, "Miriam Veras Godoy") ~ "Miriam Esther Veras Godoy",
                            str_detect(nombre, "Ricardo Cortés") ~ "Ricardo Cortés Alcalá",
                            str_detect(nombre, "Hugo Borja") ~ "Víctor Hugo Borja Aburto",
                            str_detect(nombre, "Interloc") ~ "Reportera/o",
                            str_detect(nombre, "Pregun") ~ "Reportera/o",
                            str_detect(nombre, "Interven") ~ "Reportera/o",
                            TRUE ~ nombre),
         nombre = str_trim(nombre),
         nombre = str_squish(nombre)) 


## Separar nombre del cargo y guardarlo en columnas diferentes ----
bd_vespertinas <- 
  bd_vespertinas %>% 
  separate(nombre, c("nombre", "cargo"), sep = ", ", extra = "merge")

# Nota: el mensaje de advertencia aparece porque no en todos los renglones encontró una "," y un cargo; en estos casos agregó NAs

# Verificar que nombres sean homogéneos
bd_vespertinas %>% 
  count(nombre) %>% 
  print(n = Inf)


## Homogeneizar cadenas de textos de los cargos de quienes han emitido al menos un diálogo en una conferencia vespertina ----
bd_vespertinas <- 
  bd_vespertinas %>% 
  mutate(cargo = str_replace_all(cargo, " De ", " de "),
         cargo = str_replace_all(cargo, " Del ", " del "),
         cargo = str_replace_all(cargo, " La ", " la "),
         cargo = str_replace_all(cargo, " Y ", " y "),
         cargo = str_replace_all(cargo, " En ", " en "),
         cargo = str_replace_all(cargo, " El ", " el "),
         cargo = str_replace_all(cargo, " Un ", " un "),
         cargo = str_replace_all(cargo, "Ops/Oms", "OMS/OPS"),
         cargo = str_replace_all(cargo, "Oms/Ops", "OMS/OPS"),
         cargo = case_when(nombre == "Adán Augusto López Hernández" ~ "Gobernador de Tabasco",
                           nombre == "Alejandra Frausto Guerrero" ~ "Secretaria de Cultura",
                           nombre == "Alejandro Svarch Pérez" ~ "Titular de la Coordinación Nacional Médica del INSABI",
                           nombre == "Ana Lucía de la Garza Barroso" ~ "Directora de Investigación Operativa Epidemiológica y Coordinadora de la Unidad de Inteligencia Epidemiológica y Sanitaria",
                           nombre == "Alethse de la Torre Rosas" ~ "Directora General del Centro Nacional para la Prevención y el Control del VIH y el sida",
                           nombre == "Anabelle Bonvecchio Arenas" ~ "Directora de Políticas y Programas de Nutrición del INSP",
                           nombre == "Carlos Mendoza Davis" ~ "Gobernador de Baja California Sur",
                           nombre == "Christian Arturo Zaragoza Jiménez" ~ "Director de Información Epidemiológica, Secretaría de Salud",
                           nombre == "Claudia Sheinbaum Pardo" ~ "Jefa de Gobierno de la Ciudad de México",
                           nombre == "Cristian Morales Fuhrimann" ~ "Representante de la OPS/OMS en México",
                           nombre == "Diana Iris Tejadilla Orozco" ~ "Directora de Normatividad y Coordinación Institucional, Secretariado Técnico del Consejo Nacional de Salud Mental",
                           nombre == "Esteban Moctezuma Barragán" ~ "Secretario de Educación Pública",
                           nombre == "Evalinda Barrón Velázquez" ~ "Coordinadora Técnica de la Estrategia Nacional de Prevención de Adicciones",
                           nombre == "Fabiana Zepeda Arias" ~ "Jefa de la División de Programas de Enfermería en el IMSS",
                           nombre == "Felipe Cruz Vega" ~ "Jefe de la División de Proyectos Especiales en Salud del IMSS",
                           nombre == "Gabriel García Rodríguez" ~ "Director del Centro Operativo para la Atención de Contingencias",
                           nombre == "Gabriel Yorio González" ~ "Subsecretario de Hacienda y Crédito Público, Secretaría de Hacienda y Crédito Público",
                           nombre == "Gabriela Rodríguez" ~ "Secretaria General de CONAPO",
                           nombre == "Gady Zabicky Sirot" ~ "Comisionado Nacional Contra las Adicciones",
                           nombre == "Giancarlo Summa" ~ "Director del Centro de Información de Naciones Unidas (CINU) para México, Cuba y República Dominicana",
                           nombre == "Gisela Lara Saldaña" ~ "Titular de la Unidad del Programa IMSS-Bienestar",
                           nombre == "Graciela Márquez Colín" ~ "Secretaria de Economía",
                           nombre == "Guadalupe Mercedes Lucía Guerrero Avendaño" ~ "Directora del Hospital General de México 'Dr. Eduardo Liceaga'",
                           nombre == "Guillermo Rafael Santiago Rodríguez" ~ "Director General del IMJUVE",
                           nombre == "Gustavo Reyes Terán" ~ "Titular de la Comisión Coordinadora de Institutos Nacionales de Salud y de Hosìtales de Alta Especialidad",
                           nombre == "Hugo López-Gatell Ramírez" ~ "Subsecretario de Prevención y Promoción de la Salud, Secretaría de Salud",
                           nombre == "Jean-Marc Gabastou" ~ "Asesor Internacional de Emergencias de Salud, OPS/OMS",
                           nombre == "Jenaro Villamil Rodríguez" ~ "Presidente del Sistema Público de Radiodifusión del Estado Mexicano",
                           nombre == "Joaquín Zebadúa Alba" ~ "Presidente municipal de Berriozábal",
                           nombre == "Jorge Carlos Alcocer Varela" ~ "Secretario de Salud",
                           nombre == "Jorge Julio González Olvera" ~ "Director General de CONADIC",
                           nombre == "Jorge Trejo Gómora" ~ "Director General del Centro Nacional de Transfusión Sanguínea",
                           nombre == "José Ignacio Santos Preciado" ~ "Secretario del Consejo de Salubridad General",
                           nombre == "José Luis Alomía Zegarra" ~ "Director General de Epidemiología, Secretaría de Salud",
                           nombre == "Juan Ángel Rivera Dommarco" ~ "Director General del INSP",
                           nombre == "Juan Antonio Ferrer Aguilar" ~ "Director del INSABI",
                           nombre == "Juan Manuel Quijada Gaytán" ~ "Director General de los Servicios de Atención Psiquiátrica, Secretaría de Salud",
                           nombre == "Karla Berdichevsky Feldman" ~ "Directora General del Centro Nacional de Equidad de Género y Salud Reproductiva",
                           nombre == "Leyla Acosta Miranda" ~ "Técnica en Atención y Orientación al Derechohabiente del IMSS",
                           nombre == "Lorena Rodríguez-Bores Ramírez" ~ "Secretaria Técnica del CONASAME",
                           nombre == "Luciano Concheiro Bórquez" ~ "Subsecretario de Educación Superior, Subsecretaría de Educación Pública",
                           nombre == "Luis Antonio Ramírez Pineda" ~ "Director General del ISSSTE",
                           nombre == "Luz Myriam Reynales Shigematsu" ~ "Jefa del Departamento de Investigación Sobre Tabaco del INSP",
                           nombre == "Manuel Cervantes Ocampo" ~ "Titular de la Coordinación de Atención Integral a la Salud en el Primer Nivel, IMSS",
                           nombre == "Marcelina Bautista Bautista" ~ "Fundadora y Coordinadora del Centro de Apoyo y Capacitación para Empleadas del Hogar",
                           nombre == "Marcelo Ebrard Casaubon" ~ "Secretario de Relaciones Exteriores",
                           nombre == "María Elena Álvarez-Buylla" ~ "Directora General del CONACYT",
                           nombre == "María Isabel López López" ~ "Jefa de Enfermería del Tercer Nivel de Atención en Unidades Médicas de Alta Especialidad del IMSS",
                           nombre == "María Luisa Albores González" ~ "Secretaria de Bienestar",
                           nombre == "Matthias Sachse Aguilera" ~ "Oficial Nacional de Salud y Nutrición de la UNICEF México",
                           nombre == "Mauricio Hernández Ávila" ~ "Director de Prestaciones Económicas y Sociales del IMSS",
                           nombre == "Miguel Torruco Marqués" ~ "Secretario de Turismo",
                           nombre == "Miralda Aguilar Patraca" ~ "Titular del Órgano de Operación Administrativa Desconcentrada en la Zona México Poniente del IMSS",
                           nombre == "Mónica Maccise Duayhe" ~ "Presidente del CONAPRED",
                           nombre == "Nadine Gasman Zylbermann" ~ "Presidenta de INMUJERES",
                           nombre == "Oliva López Arellano" ~ "Secretaria de Salud de la Ciudad De México",
                           nombre == "Paola Villarreal Rodríguez" ~ "Coordinadora de Repositorios, Investigación y Prospectiva de CONACYT",
                           nombre == "Ricardo Bucio Mújica" ~ "Secretario Ejecutivo del Sistema Nacional de Protección Integral de Niñas, Niños (SIPINA)",
                           nombre == "Ricardo Cortés Alcalá" ~ "Director General de Promoción de la Salud, Secretaría de Salud",
                           nombre == "Rodolfo Lehmann Mendoza" ~ "Subdirector de Servicios de Salud de Pemex",
                           nombre == "Rutilio Escandón Cadenas" ~ "Gobernador de Chiapas",
                           nombre == "Ruy López Ridaura" ~ "Directo General del CENAPRECE",
                           nombre == "Sandra Moya Sánchez" ~ "Jefa de Enfermería en el Segundo Nivel de Atención en Unidades Médicas de Alta Especialidad del IMSS",
                           nombre == "Silvia Roldán Fernández" ~ "Secretaria de Salud de Tabasco",
                           nombre == "Simón Barquera Cervera" ~ "Director del Centro de Investigación en Nutrición y Salud del INSP",
                           nombre == "Simón Kawa Karasik" ~ "Director General de la Comisión Coordinadora de Institutos Nacionales de Salud",
                           nombre == "Teresa Shamah Levy" ~ "Directora General del Centro de Investigación en Evaluación y Encuestas del INSP",
                           nombre == "Víctor Hugo Borja Aburto" ~ "Director de Prestaciones Médicas del IMSS",
                           nombre == "Víctor Suárez Carrera" ~ "Subsecretario de Autosuficiencia Alimentaria, Secretaría de Agricultura y Desarrollo Rural",
                           nombre == "Zoé Robledo Aburto" ~ "Director General del IMSS",
                           nombre == "Cristian Roberto Morales Fuhrimann" ~ "Representante de la OMS/OPS en México",
                           nombre == "Catalina Gómez Mena" ~ "Jefa de Política Social de la UNICEF",
                           nombre == "Christian Skoog" ~ "Representante de la UNICEF en México",
                           nombre == "Emmanuel Sarmiento Hernández" ~ "Director del Hospital Psiquiátrico Infantil Dr. Juan N. Navarro",
                           nombre == "Luis Miguel Gutiérrez Robledo" ~ "Director General del Instituto Nacional de Geriatría",
                           nombre == "José Salvador Aburto Morales" ~ "Director General del Centro Nacional de Trasplantes",
                           nombre == "" ~ "",
                           nombre == "Miriam Esther Veras Godoy" | nombre ==  "Miriam Veras Godoy" ~ "Directora General del CeNSIA",
                           TRUE ~ cargo),
         cargo = str_replace(cargo, "Instituto Mexicano del Seguro Social", "IMSS"),
         cargo = str_replace(cargo, "Imss", "IMSS"),
         cargo = str_replace(cargo, "\\(IMSS\\)", ""),
         cargo = str_replace(cargo, "\\, IMSS", "del IMSS"),
         cargo = str_replace(cargo, "del Instituto Nacional de Geriatría (Inger) ", "INGER"),
         cargo = str_trim(cargo),
         cargo = str_squish(cargo)) 
  

# Verificar que cargos sean homogéneos
bd_vespertinas %>% 
  count(nombre, cargo) %>%
  print(n = Inf)


### Generar columna que registre la fecha en que se emitió cada diálogo---- 
bd_vespertinas <- 
  bd_vespertinas %>% 
  rename(fecha_texto = fecha) %>% 
  mutate(dia = as.numeric(str_sub(fecha_texto, 1, 2)),
         mes = case_when(str_detect(fecha_texto, "febrero") ~ 2,
                         str_detect(fecha_texto, "marzo") ~ 3,
                         str_detect(fecha_texto, "abril") ~ 4,
                         str_detect(fecha_texto, "mayo") ~ 5,
                         str_detect(fecha_texto, "junio") ~ 6,
                         str_detect(fecha_texto, "julio") ~ 7,
                         str_detect(fecha_texto, "agosto") ~ 8,
                         str_detect(fecha_texto, "septiembre") ~ 9),
         fecha = make_date(2020, mes, dia)) %>% 
  select(vespertina_id, fecha, fecha_texto, titulo:url)


### Guardar base de datos en formato .csv y .RData ----
bd_vespertinas %>%
  select(-titulo) %>%
  write_csv("04_datos_output/bd_dialogos.csv")

save(transcripciones, file = "04_datos_output/bd_dialogos.RData")
