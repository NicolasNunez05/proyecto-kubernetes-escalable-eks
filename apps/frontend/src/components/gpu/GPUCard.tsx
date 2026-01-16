/**
 * 🎯 QUÉ HACE: Card individual de GPU
 * 📍 CUÁNDO SE USA: En /catalog, renderizado en grid
 */
import { GPU } from '../../types/gpu';
import { theme } from '../../styles/theme';

interface Props {
  gpu: GPU;
  onClick: () => void;
}

export const GPUCard: React.FC<Props> = ({ gpu, onClick }) => {
  return (
    <div 
      onClick={onClick}
      style={{
        background: theme.colors.primary,
        border: `1px solid ${theme.colors.secondary}`,
        borderRadius: '8px',
        padding: '16px',
        cursor: 'pointer'
      }}
    >
      {/* Usa thumbnail_url para performance */}
      <img src={gpu.thumbnail_url} alt={gpu.model} />
      
      <h3 style={{ color: theme.colors.accent }}>{gpu.model}</h3>
      <p>{gpu.vram}GB VRAM</p>
      <p style={{ color: theme.colors.secondary }}>${gpu.price}</p>
      
      {/* Stock indicator */}
      <span style={{
        color: gpu.stock > 10 
          ? theme.colors.success 
          : gpu.stock > 0 
            ? theme.colors.warning 
            : theme.colors.error
      }}>
        {gpu.stock > 0 ? `${gpu.stock} disponibles` : 'Sin stock'}
      </span>
    </div>
  );
};
