import requests
import json
import time

# TU URL DEL LOAD BALANCER (Backend)
API_URL = "http://ad519c89537e8443d8b899e35db9d1cd-361311791.us-east-1.elb.amazonaws.com:8000/api/gpus/"

print(f"🔌 Conectando a la API: {API_URL}")

# Lista FINAL de productos con las imágenes seleccionadas por el usuario
productos = [
    {
        "name": "NVIDIA GeForce RTX 4090",
        "brand": "NVIDIA",
        "model": "RTX 4090 Founders",
        "price": 1599.99,
        "vram": 24,
        "cuda_cores": 16384,
        # Tu imagen de Amazon
        "image_url": "https://m.media-amazon.com/images/I/514QPBuqGyL._AC_SL1002_.jpg",
        "stock": 5,
        "description": "El rey indiscutible del rendimiento. Arquitectura Ada Lovelace, 24GB G6X y DLSS 3.",
        "is_featured": True
    },
    {
        "name": "AMD Radeon RX 7900 XTX",
        "brand": "AMD",
        "model": "RX 7900 XTX",
        "price": 999.99,
        "vram": 24,
        "cuda_cores": 6144,
        # Tu imagen de ASUS
        "image_url": "https://dlcdnwebimgs.asus.com/gain/60c7541f-3a30-489b-b5a3-86e8dcdb3d06/",
        "stock": 12,
        "description": "La respuesta de AMD para 4K nativo. Chiplet design y excelente relación precio-calidad.",
        "is_featured": True
    },
    {
        "name": "NVIDIA GeForce RTX 3060",
        "brand": "NVIDIA",
        "model": "RTX 3060 12GB",
        "price": 329.99,
        "vram": 12,
        "cuda_cores": 3584,
        # Tu imagen de Solotodo
        "image_url": "https://media.solotodo.com/media/products/1366888_picture_1618383951.jpg",
        "stock": 50,
        "description": "La reina de la gama media. Perfecta para 1080p Ultra y 1440p con DLSS.",
        "is_featured": False
    },
    {
        "name": "Intel Arc A770",
        "brand": "Intel",
        "model": "Arc A770 Limited",
        "price": 349.00,
        "vram": 16,
        "cuda_cores": 4096,
        # Tu imagen de Solotodo
        "image_url": "https://media.solotodo.com/media/products/1719344_picture_1675848714.jpg",
        "stock": 8,
        "description": "Intel entra al juego. 16GB de VRAM y un rendimiento sorprendente en Ray Tracing.",
        "is_featured": False
    }
    # Se eliminó el "Gaming Setup Bundle"
]

# 1. LIMPIEZA (Borrar todo lo viejo)
try:
    print("🧹 Borrando inventario antiguo...")
    lista = requests.get(API_URL).json()
    if isinstance(lista, list):
        for item in lista:
            requests.delete(f"{API_URL}{item['id']}")
            print(f"   🗑️ Eliminado ID: {item['id']}")
except Exception as e:
    print(f"⚠️ Nota sobre limpieza: {e}")

time.sleep(1)

# 2. CARGA (Subir la nueva lista oficial)
print("\n🚀 Subiendo productos con TUS IMÁGENES SELECCIONADAS...")
for p in productos:
    try:
        r = requests.post(API_URL, json=p)
        if r.status_code in [200, 201]:
            print(f"   ✅ {p['name']} -> Subido OK")
        else:
            print(f"   ❌ Error en {p['name']}: {r.text}")
    except Exception as e:
        print(f"   💀 Error de red: {e}")

print("\n🏁 ¡Listo! Ve a tu página web y presiona F5.")