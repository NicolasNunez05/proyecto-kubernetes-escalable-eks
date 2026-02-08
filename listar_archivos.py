import os

# Configuración
ARCHIVO_SALIDA = "respaldo_infraestructura.txt"
# Si un solo archivo pesa más de 200KB, se ignora (ajusta si tienes archivos de código muy largos)
LIMITE_ARCHIVO_KB = 200 
# Carpetas que NUNCA queremos procesar
IGNORAR_CARPETAS = {'.git', '.terraform', '.github', 'node_modules', 'venv'}

def volcado_total():
    count = 0
    with open(ARCHIVO_SALIDA, "w", encoding="utf-8") as f_out:
        for raiz, dirs, archivos in os.walk("."):
            # Filtrar carpetas prohibidas
            dirs[:] = [d for d in dirs if d not in IGNORAR_CARPETAS]
            
            for nombre in archivos:
                # No procesar el propio script ni el archivo de salida
                if nombre == ARCHIVO_SALIDA or nombre.endswith(".py"):
                    if nombre != "main.py": # Por si tienes un main.py de código real
                        continue
                
                ruta = os.path.join(raiz, nombre)
                
                try:
                    # VALIDACIÓN DE TAMAÑO
                    tamano = os.path.getsize(ruta) / 1024
                    if tamano > LIMITE_ARCHIVO_KB:
                        print(f"Saltado (muy grande - {tamano:.1f}KB): {ruta}")
                        continue
                    
                    # LEER Y ESCRIBIR
                    with open(ruta, "r", encoding="utf-8", errors="ignore") as f_in:
                        contenido = f_in.read()
                        f_out.write(f"\n\n{'#'*40}\n")
                        f_out.write(f"ARCHIVO: {ruta}\n")
                        f_out.write(f"{'#'*40}\n\n")
                        f_out.write(contenido)
                        count += 1
                except Exception as e:
                    print(f"No se pudo leer {ruta}: {e}")

    print(f"\n--- PROCESO TERMINADO ---")
    print(f"Archivos procesados: {count}")
    print(f"Resultado guardado en: {ARCHIVO_SALIDA}")

if __name__ == "__main__":
    volcado_total()