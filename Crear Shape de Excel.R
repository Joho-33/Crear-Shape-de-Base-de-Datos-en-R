# Junior Omar Hernández-Ortiz
# Centro Experimental y de Innovaciópn del Recurso Hídrico - CEIRH
# Laboratorio de Hidrología Isotópica
# Instituto Hondureño de Ciencias de la Tierra - IHCIT
# Facultad de Ciencias
# Universidad Nacional Autónoma de Honduras
# Correo Institucional: junior.hernandez@unah.edu.hn
# Correo Personal: omarhortiz33@gmail.com
# *******************************************************************************************************************************

library(readxl) # Librería para lectura del archivo Excel
library(sf) # Librería para manejar archivos y datos espaciales como vectores .shp


# Lee el archivo Excel con dirección de la ruta
datos <- read_excel("C:/Muestreos/Tablas de Excel/Guacerique_RLA7026_Muestreo_Abril.xlsx")

#El campo de la fecha se agrega en formato YY/MM/DD, si no se activa la fecha es dd/mm/yy
# datos$Fecha <- as.character.Date(datos$Fecha) 

#El campo Hora que se tenga en el Excel se agrega en formato de hora, minuto y segundo; y no la fecha.
datos$Hora <- format(datos$Hora, "%H:%M:%S") 

# Las  columnas de coordenadas UTM se llaman 'X' y 'Y'.R distingue entre mayusculas y minisculas. 
# Crear un objeto sf (simple features) a partir de las coordenadas
# Asegúrese de que 'X' y 'Y' son los nombres correctos de las columnas
# Cambia el CRS según tu sistema de coordenadas. Para Honduras es 32616
coordenadas <- st_as_sf(datos, coords = c("X", "Y"), crs = 32616, remove = FALSE)

# Exportar a un archivo shapefile .shp de ESRI
# Poner la ruta de la carpeta donde se desse guardar el shapefile y el nombre con que se desea guardar el archivo con terminación .shp
st_write(coordenadas, "C:/Reportes de Muestreo/Guacerique_Abril_2024.shp")
