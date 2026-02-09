import os

# Configuración
ARCHIVO_SALIDA = "PROYECTO_COMPLETO.txt"
LIMITE_ARCHIVO_KB = 500  # Subido un poco por si tienes JSONs grandes

# Carpetas que NUNCA queremos procesar
# ⚠️ NOTA: Quité '.github' de aquí porque LA NECESITAS para el CI/CD
IGNORAR_CARPETAS = {
    '.git', '.terraform', 'node_modules', 'venv', '.venv', 
    '__pycache__', '.pytest_cache', 'htmlcov', 'dist'
}

# Extensiones que NO aportan valor al contexto (binarios, imágenes, etc.)
IGNORAR_EXTENSIONES = (
    '.png', '.jpg', '.jpeg', '.gif', '.ico', '.svg', 
    '.pyc', '.exe', '.dll', '.zip', '.tar.gz', 
    '.tfstate', '.tfstate.backup' # Ignoramos estado sensible de Terraform
)

def volcado_total():
    script_actual = os.path.basename(__file__)
    count = 0
    
    with open(ARCHIVO_SALIDA, "w", encoding="utf-8") as f_out:
        f_out.write("--- DUMP DEL PROYECTO PARA MIGRACIÓN A KIND/LOCALSTACK ---\n\n")

        for raiz, dirs, archivos in os.walk("."):
            # Filtrar carpetas prohibidas (modifica la lista in-place)
            dirs[:] = [d for d in dirs if d not in IGNORAR_CARPETAS]
            
            for nombre in archivos:
                # 1. Ignorar este script y el archivo de salida
                if nombre == ARCHIVO_SALIDA or nombre == script_actual:
                    continue
                
                # 2. Ignorar extensiones basura
                if nombre.endswith(IGNORAR_EXTENSIONES):
                    continue

                ruta = os.path.join(raiz, nombre)
                
                try:
                    # VALIDACIÓN DE TAMAÑO
                    tamano = os.path.getsize(ruta) / 1024
                    if tamano > LIMITE_ARCHIVO_KB:
                        print(f"⚠️ Saltado (muy grande - {tamano:.1f}KB): {ruta}")
                        continue
                    
                    # LEER Y ESCRIBIR
                    with open(ruta, "r", encoding="utf-8", errors="ignore") as f_in:
                        contenido = f_in.read()
                        
                        # Escribimos un encabezado claro para la IA
                        f_out.write(f"\n{'='*60}\n")
                        f_out.write(f"PATH: {ruta}\n")
                        f_out.write(f"{'='*60}\n")
                        
                        if not contenido.strip():
                            f_out.write("[ARCHIVO VACÍO]\n")
                        else:
                            f_out.write(contenido + "\n")
                        
                        count += 1
                        print(f"✅ Agregado: {ruta}")

                except Exception as e:
                    print(f"❌ Error leyendo {ruta}: {e}")

    print(f"\n--- PROCESO TERMINADO ---")
    print(f"Archivos procesados: {count}")
    print(f"Resultado guardado en: {ARCHIVO_SALIDA}")

if __name__ == "__main__":
    volcado_total()