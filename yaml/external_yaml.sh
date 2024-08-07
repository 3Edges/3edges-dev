#!/bin/bash

# Parâmetros
YAML_URL=$1

# Nome do arquivo temporário
TEMP_FILE="/tmp/$(basename $YAML_URL)"
TEMP_DIR="/tmp/yaml_split"

# Verifique se a URL pode ser acessada
echo "Baixando YAML de: $YAML_URL"

# Crie o diretório temporário para os documentos
mkdir -p "$TEMP_DIR"

# Baixe o arquivo YAML
curl -s -o "$TEMP_FILE" "$YAML_URL"

# Verifique se o YAML foi baixado corretamente
if [ ! -f "$TEMP_FILE" ]; then
  echo "Erro ao baixar o arquivo YAML"
  exit 1
fi

# Divida o YAML em documentos separados
csplit -sz "$TEMP_FILE" '/^---$/' '{*}'

# Aplique cada documento ao Kubernetes
for file in $(ls "$TEMP_FILE"*) ; do
  kubectl apply -f "$file"
done

# Limpeza
rm -f "$TEMP_FILE"
rm -rf "$TEMP_DIR"
