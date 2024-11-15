# ---------------------------------------------------------------------- #
# 00. Inicialização -----
# ---------------------------------------------------------------------- #

## Instalar pacotes -----
install.packages(c(
  "sdm", "rnaturalearth", "tidyverse"
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




