# ---------------------------------------------------------------------- #
# 00. Inicialização -----
# ---------------------------------------------------------------------- #

## Instalar pacotes -----
install.packages(c(
  "spocc", "sdm", "rnaturalearth", "tidyverse"
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

### Carregar dados do Excel -----
occ <- readxl::read_excel("nome_da_pasta/nome_do_arquivo.xlsx") # formato XLSX
occ <- read.csv("nome_da_pasta/nome_do_arquivo.xlsx") # formato CSV

### Baixar dados pelo R -----


## Dados ambientais -----

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




