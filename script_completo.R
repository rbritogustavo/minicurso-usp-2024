# ---------------------------------------------------------------------- #
# 00. Inicialização -----
# ---------------------------------------------------------------------- #

## Instalar pacotes -----
install.packages(c(
  "CoordinateCleaner", "geodata", "rnaturalearth",
  "spThin", "spocc", "sdm", "tidyverse"
))

## Carregar pacotes -----
library(sdm)
library(tidyverse)

## Instalar pacotes adicionais (sdm) -----
installAll()

# NOTA ----------------------------------------------------------------- #
#
# O código acima deverá ser rodado APENAS UMA VEZ, logo após instalar
# e carregar o pacote sdm. Nos demais usos do script, a linha 15 deve
# ser ignorada.
#
# ---------------------------------------------------------------------- #

## Definir opções de trabalho -----
options(scipen = 9999) # remover notação científica

cores_mapa = c() # paleta de cores

# ---------------------------------------------------------------------- #
# 01. Pré-modelagem -----
# ---------------------------------------------------------------------- #

## Dados de ocorrência -----

# NOTA ----------------------------------------------------------------- #
#
# Os passos descritos abaixo (opção 1 e opção 2) não devem ser feitos em
# sequência: você precisa ESCOLHER uma das opções e seguir com ela. Rodar
# ambos os códigos geraria redundância e/ou problemas.
#
# Única situação onde os códigos devem ser rodados em sequência envolve
# a combinação de dados tabelados por você (e.g. retirados da literatura)
# com dados disponíveis nas bases virtuais.
#
# ---------------------------------------------------------------------- #

### Carregar dados do Excel (opção 1) -----
occ <- readxl::read_excel("nome_da_pasta/nome_do_arquivo.xlsx") # formato XLSX
occ <- read.csv("nome_da_pasta/nome_do_arquivo.xlsx") # formato CSV

### Baixar dados pelo R (opção 2) -----
occ <- occ(
  query = "Nome da espécie",
  from = "nome da base", # é possível concatenar mais de uma base
  limit = 10000, # número de ocorrências retornadas pela função
  has_coords = TRUE # retorna apenas dados com coordenadas completas
)

## Processar ocorrências -----

### Filtragem com coordinateCleaner -----


### Espacializar com spThin -----


### Exportar dados "limpos" -----
writexl::write_xlsx(occ_limpo, "nome_da_pasta/nome_do_arquivo.xlsx")

write.csv(occ_limpo, "nome_da_pasta/nome_do_arquivo.csv", row.names = FALSE)

## Dados ambientais -----

# NOTA ----------------------------------------------------------------- #
#
# Os passos descritos abaixo (opção 1 e opção 2) não devem ser feitos em
# sequência: você precisa ESCOLHER uma das opções e seguir com ela. Rodar
# ambos os códigos geraria redundância e/ou problemas.
#
# Única situação onde os códigos devem ser rodados em sequência envolve
# a combinação de dados baixados/criados por você com dados disponíveis
# nas bases virtuais.
#
# ---------------------------------------------------------------------- #

### Carregar dados baixados (opção 1) -----
env <- rast(
  list.files(
    path = "nome_da_pasta/", # pasta que contém os arquivos
    pattern = ".tif", # formato dos arquivos
    full.names = TRUE # retorna o nome completo dos arquivos
  )
)

### Baixar dados pelo R (opção 2) -----
env <- geodata::escolher_função # ?geodata::nome_da_função para abrir a ajuda

## Processar dados ambientais -----

### Recortar e mascarar para a área de estudo -----

### Análise de multicolinearidade / correlação -----

### Exportar o conjunto final de variáveis -----

# ---------------------------------------------------------------------- #
# 02. Modelagem -----
# ---------------------------------------------------------------------- #

## Criar instruções para o modelo -----

## Treinar um modelo "single algorithm" -----

## Treinar um modelo "multi algorithm" -----

# ---------------------------------------------------------------------- #
# 03. Pós-modelagem -----
# ---------------------------------------------------------------------- #

## Avaliar a performance do modelo -----

## Avaliar a contribuição das variáveis -----

## Criar projeções -----

## Criar ensemble -----

# ---------------------------------------------------------------------- #
# 04. Plotar mapas -----
# ---------------------------------------------------------------------- #

## Mapa de adequabilidade ambiental -----

## Mapa binário -----




