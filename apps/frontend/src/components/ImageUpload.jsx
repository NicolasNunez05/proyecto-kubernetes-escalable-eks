import React, { useState } from 'react';
import axios from 'axios';

function ImageUpload() {
  const [file, setFile] = useState(null);
  const [uploading, setUploading] = useState(false);

  const handleUpload = async () => {
    if (!file) return;

    setUploading(true);

    try {
      // 1. Obtener pre-signed URL del backend
      const { data } = await axios.post('/api/images/upload', {
        filename: file.name
      });

      // 2. Subir directamente a S3
      await axios.put(data.upload_url, file, {
        headers: { 'Content-Type': file.type }
      });

      alert('✅ Imagen subida! Lambda está procesándola...');
      setFile(null);
    } catch (error) {
      console.error('Error:', error);
      alert('❌ Error al subir imagen');
    } finally {
      setUploading(false);
    }
  };

  return (
    <div>
      <input 
        type="file" 
        accept="image/*"
        onChange={(e) => setFile(e.target.files[0])}
      />
      <button onClick={handleUpload} disabled={!file || uploading}>
        {uploading ? 'Subiendo...' : 'Subir Imagen'}
      </button>
    </div>
  );
}

export default ImageUpload;
