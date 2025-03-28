import pandas as pd
import os

# Caminho onde os arquivos CSV estão
csv_directory = "./csv/"

# Lista de arquivos CSV
csv_files = ["Price_changes.csv", "Built_used_area.csv", "Details.csv"]

for file_name in csv_files:
    file_path = os.path.join(csv_directory, file_name)

    try:
        # Detectar delimitador e corrigir problemas estruturais
        df = pd.read_csv(file_path, sep=",", engine="python", dtype=str)

        # Garantir que não há quebras de linha dentro dos campos
        df = df.applymap(lambda x: x.replace("\n", " ").replace("\r", " ") if isinstance(x, str) else x)

        # Garantir que os campos de texto estão dentro de aspas corretamente
        df.to_csv(file_path, index=False, sep=",", quoting=1)  # quoting=1 força uso de aspas onde necessário

        print(f"✅ Arquivo corrigido: {file_name}")
    except Exception as e:
        print(f"❌ Erro ao processar {file_name}: {e}")
