# Junior Omar Hernández-Ortiz
# Centro Experimental y de Innovaciópn del Recurso Hídrico - CEIRH
# Laboratorio de Hidrología Isotópica
# Facultad de Ciencias
# Universidad Nacional Autonoma de Honduras
# Correo Institucional: junior.hernandez@unah.edu.hn
# Correo Personal: omarhortiz33@gmail.com
# ****************************************************************************************************************************

library(readxl)  # Librería para lectura del archivo Excel
library(sf)      # Librería para manejar archivos y datos espaciales como vectores .shp
library(ggplot2) # Librería para crear gráficos

# Lee el archivo Excel con dirección de la ruta
datos <- read_excel("C:/Trabajos ArcGis/Tablas_de_Excel/Guacerique_RLA7026_Muestreo.xlsx")

# El campo Hora que se tenga en el Excel se agrega en formato de hora, minuto y segundo
datos$Hora <- format(datos$Hora, "%H:%M:%S")

# Las columnas de coordenadas UTM se llaman 'X' y 'Y'. Asegurarse de que los nombres estén bien escritos. R distingue entre mayusculas y minusculas
# Crea un objeto sf (simple features) a partir de las coordenadas. Cambie el CRS según su sistema de coordenadas. Para Honduras es 32616
coordenadas <- st_as_sf(datos, coords = c("X", "Y"), crs = 32616, remove = FALSE)

# Exporta a un archivo shapefile .shp de ESRI
st_write(coordenadas, "C:/TESIS/Guacerique.shp")

# Plotea el shape de los datos para la visualización de los puntos
ggplot(data = coordenadas) +
  geom_sf() +  # Plotea objetos espaciales
  theme_minimal() +  
  labs(title = "Puntos de Muestreo en Guacerique", 
       x = "Coordenadas X", 
       y = "Coordenadas Y")  # Etiquetas de los ejes y título del gráfico

# Muestra la tabla de atributos en formato de data frame
print(st_drop_geometry(coordenadas))  # Esto elimina la geometría para que solo se muestren los atributos

# Puede usar View() para ver los datos en una tabla en RStudio. Si así lo desea active quitando el #
#View(st_drop_geometry(coordenadas)) 
