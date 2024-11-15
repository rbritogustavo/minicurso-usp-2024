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

cores_mapa <- c("#173F5F", "#20639B", "#3CAEA3", "#F6D55C", "#ED553B") # paleta

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
area_estudo <- sf::st_read(nome_da_pasta / nome_do_arquivo.shp) # shapefile

env <- crop(env, area_estudo)
env <- mask(env, area_estudo)

plot(env[[1]]) # conferir o resultado do processo

### Análise de multicolinearidade / correlação -----

# NOTA ----------------------------------------------------------------- #
#
# Há diferentes possibilidades para a mesma finalidade: diminuir o viés
# das variáveis no modelo. Aqui apresentamos duas possibilidades: o VIF
# e a PCA.
#
# NÃO É NECESSÁRIO utilizar ambos os processos, escolha o que melhor se
# adequa à sua realidade.
#
# ---------------------------------------------------------------------- #

#### Opção 1: Fator de Inflação da Variância (VIF) -----
valores_env <- extract(occ, env) # extrair info. ambientais das ocorrências

vif_cor <- usdm::vifcor(
  valores_env, # objeto com os valores ambientais "ponto a ponto"
  th = 0.8 # limite de corte (threshold) para o teste
)

vif_step <- usdm::vifstep(
  valores_env,
  th = 10
)

# NOTA ----------------------------------------------------------------- #
#
# Há um motivo para utilizar dois tipos de cálculo para o VIF: a ideia é
# verificar se ambos os testes selecionam variáveis em comum de modo a
# facilitar a decisão de quais variáveis irão compor o processo de
# treinamento do modelo. Mas lembre-se: a Biologia tem precedência!
#
# ---------------------------------------------------------------------- #

vif_cor # sumário do processo
vif_step

env_cor <- usdm::exclude(env, vif_cor)
env_step <- usdm::exclude(env, vif_step)

#### Opção 2: Análise de Componentes Principais (PCA) -----


### Exportar o conjunto final de variáveis -----

# NOTA ----------------------------------------------------------------- #
#
# O código a seguir só deve ser rodado após você selecionar um dos métodos
# de análise das variáveis. Lembre-se: NUNCA rode ambos os códigos. Escolha
# uma opção e siga com ela até o fim do processo.
#
# ---------------------------------------------------------------------- #

writeRaster(
  env_selecionado,
  filename = paste0("nome_da_pasta/", names(env_selecionado), ".tif")
)

# ---------------------------------------------------------------------- #
# 02. Modelagem -----
# ---------------------------------------------------------------------- #

## Criar instruções para o modelo -----

### Gerar dados de background ou de pseudo ausência -----
dados_bg <- background(
  env_selecionado, # objeto com os rasters ambientais
  n = 10000, # número de pontos
  method = "gRandom" # método para gerar os pontos
)

### Criar a coluna de presença da espécie -----
occ_limpo <- occ_limpo %>% mutate(nome_da_especie = 1) # 1 = presença

instrucoes_modelo <- sdmData(
  formula = nome_da_especie ~ . + coords(longitude + latitude), # fórmula
  train = occ_limpo, # objeto com as ocorrências
  predictors = env_selecionado, # objeto com os rasters ambientais
  bg = dados_bg # objeto com os dados de background ou de pseudo ausência
)

instrucoes_modelo # sumário do objeto

# NOTA ----------------------------------------------------------------- #
#
# Os códigos abaixo dizem respeito ao treino propriamente dito do modelo.
# No entanto, utilizar um ou mais algoritmos para o processo vai dos seus
# objetivos de pesquisa, portanto NÃO É NECESSÁRIO rodar ambos os códigos.
#
# Escolha a opção que melhor se encaixa com sua pesquisa (e com sua máquina).
#
# ---------------------------------------------------------------------- #

## Treinar um modelo "single algorithm" -----
modelo_unico <- sdm(
  formula = nome_da_especie ~ . + coords(longitude + latitude), # fórmula
  methods = "Maxent", # nome do algoritmo
  replication = "sub", # método de "sorteio" dos dados para treino
  n = 100, # número de repetições
  test.percent = 25, # percentagem de dados separados para o teste do modelo
  parallelSetting = list( # processo paralelizado (multinúcleo)
    ncore = 2, # número de núcleos do processador para paralelizar
    method = "parallel"
  )
)

## Treinar um modelo "multi algorithm" -----
modelo_multi <- sdm(
  formula = nome_da_especie ~ . + coords(longitude + latitude), # fórmula
  methods = c("GLM", "Maxent", "RF"), # nome dos algoritmos
  replication = "sub", # método de "sorteio" dos dados para treino
  n = 100, # número de repetições
  test.percent = 25, # percentagem de dados separados para o teste do modelo
  parallelSetting = list( # processo paralelizado (multinúcleo)
    ncore = 2, # número de núcleos do processador para paralelizar
    method = "parallel"
  )
)

### Salvar o modelo no disco -----
write.sdm(
  modelo_unico, # objeto com o modelo
  filename = "nome_da_pasta/nome_do_arquivo", # local e nome do arquivo
  overwrite = TRUE # parâmetro para sobrescrever caso o arquivo já exista
)

write.sdm(
  modelo_multi,
  filename = "nome_da_pasta/nome_do_arquivo",
  overwrite = TRUE
)

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
