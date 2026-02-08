import { useQuery } from '@tanstack/react-query';
import { Link } from 'react-router-dom';
import { AlertCircle, Loader2, TrendingUp, Zap, Cpu } from 'lucide-react';
import gpuService from '@/services/gpu.service';
import Card, { CardContent, CardFooter } from '@/components/ui/Card';
import Button from '@/components/ui/Button';
import type { GPU } from '@/types/gpu';

const HomePage = () => {
  // Fetch GPUs con React Query
  const {
    data: gpus,
    isLoading,
    isError,
    error,
  } = useQuery({
    queryKey: ['gpus'],
    queryFn: () => gpuService.getGpus(),
    staleTime: 5 * 60 * 1000,
  });

  // Loading state
  if (isLoading) {
    return (
      <div className="flex min-h-[60vh] items-center justify-center">
        <div className="text-center">
          <Loader2 className="mx-auto h-12 w-12 animate-spin text-primary" />
          <p className="mt-4 text-lg text-text-secondary">Cargando GPUs...</p>
        </div>
      </div>
    );
  }

  // Error state
  if (isError) {
    return (
      <div className="flex min-h-[60vh] items-center justify-center">
        <div className="max-w-md text-center">
          <AlertCircle className="mx-auto h-12 w-12 text-red-500" />
          <h2 className="mt-4 text-2xl font-bold text-text-primary">Error al cargar GPUs</h2>
          <p className="mt-2 text-text-secondary">
            {error instanceof Error ? error.message : 'Ocurrió un error inesperado'}
          </p>
          <Button
            variant="primary"
            className="mt-6"
            onClick={() => window.location.reload()}
          >
            Reintentar
          </Button>
        </div>
      </div>
    );
  }

  // Empty state
  if (!gpus || gpus.length === 0) {
    return (
      <div className="flex min-h-[60vh] items-center justify-center">
        <div className="text-center">
          <Zap className="mx-auto h-12 w-12 text-text-muted" />
          <h2 className="mt-4 text-2xl font-bold text-text-primary">No hay GPUs disponibles</h2>
          <p className="mt-2 text-text-secondary">Vuelve más tarde para ver nuestro catálogo.</p>
        </div>
      </div>
    );
  }

  return (
    <div className="space-y-8 animate-fade-in">
      {/* Hero Section con gradiente morado */}
      <div className="relative overflow-hidden rounded-2xl bg-gradient-to-r from-slate-900 via-purple-900 to-slate-900 px-8 py-16 md:py-20">
        {/* Glow effect background */}
        <div className="absolute inset-0 bg-[radial-gradient(circle_at_50%_50%,rgba(123,44,191,0.1),transparent_50%)]" />
        
        <div className="relative z-10">
          <h1 className="text-4xl font-bold text-text-primary md:text-5xl lg:text-6xl">
            Las Mejores GPUs
            <br />
            <span className="text-gradient">del Mercado</span>
          </h1>
          <p className="mt-6 max-w-2xl text-lg text-text-secondary md:text-xl">
            Encuentra la GPU perfecta para gaming, renderizado y AI. 
            <span className="text-primary font-semibold"> Stock actualizado</span> en tiempo real.
          </p>
          
          <div className="mt-8 flex flex-wrap gap-4">
            <Button variant="primary" size="lg" className="shadow-neon">
              Explorar Catálogo
            </Button>
            <Button variant="outline" size="lg" className="border-primary/50 text-primary hover:bg-primary/10">
              Ver Ofertas
            </Button>
          </div>
        </div>

        {/* Decorative lines */}
        <div className="absolute right-0 top-0 h-full w-1/3 opacity-20">
          <div className="absolute right-0 top-1/4 h-px w-full bg-gradient-to-l from-primary to-transparent" />
          <div className="absolute right-0 top-1/2 h-px w-full bg-gradient-to-l from-secondary to-transparent" />
          <div className="absolute right-0 top-3/4 h-px w-full bg-gradient-to-l from-primary to-transparent" />
        </div>
      </div>

      {/* Stats Cards */}
      <div className="grid grid-cols-1 gap-6 sm:grid-cols-3">
        <Card className="p-6 hover:border-primary/50 transition-all">
          <div className="flex items-center space-x-4">
            <div className="rounded-full bg-primary/20 p-3 ring-2 ring-primary/50">
              <TrendingUp className="h-6 w-6 text-primary" />
            </div>
            <div>
              <p className="text-3xl font-bold text-text-primary">{gpus.length}</p>
              <p className="text-sm text-text-secondary">GPUs Disponibles</p>
            </div>
          </div>
        </Card>

        <Card className="p-6 hover:border-accent-green/50 transition-all">
          <div className="flex items-center space-x-4">
            <div className="rounded-full bg-accent-green/20 p-3 ring-2 ring-accent-green/50">
              <Zap className="h-6 w-6 text-accent-green" />
            </div>
            <div>
              <p className="text-3xl font-bold text-text-primary">
                {gpus.filter((gpu) => gpu.stock > 0).length}
              </p>
              <p className="text-sm text-text-secondary">En Stock</p>
            </div>
          </div>
        </Card>

        <Card className="p-6 hover:border-accent-cyan/50 transition-all">
          <div className="flex items-center space-x-4">
            <div className="rounded-full bg-accent-cyan/20 p-3 ring-2 ring-accent-cyan/50">
              <Cpu className="h-6 w-6 text-accent-cyan" />
            </div>
            <div>
              <p className="text-3xl font-bold text-text-primary">
                {new Set(gpus.map((gpu) => gpu.brand)).size}
              </p>
              <p className="text-sm text-text-secondary">Marcas</p>
            </div>
          </div>
        </Card>
      </div>

      {/* GPU Grid */}
      <div>
        <div className="mb-6 flex items-center justify-between">
          <h2 className="text-3xl font-bold text-text-primary">
            Catálogo de <span className="text-gradient">GPUs</span>
          </h2>
          <div className="flex gap-2">
            <Button variant="ghost" size="sm" className="text-text-secondary hover:text-primary">
              Filtros
            </Button>
          </div>
        </div>
        
        <div className="grid grid-cols-1 gap-6 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4">
          {gpus.map((gpu, index) => (
            <GPUCard key={gpu.id} gpu={gpu} index={index} />
          ))}
        </div>
      </div>
    </div>
  );
};

// GPU Card Component con efecto neon
interface GPUCardProps {
  gpu: GPU;
  index: number;
}

const GPUCard = ({ gpu, index }: GPUCardProps) => {
  const isOutOfStock = gpu.stock === 0;

  return (
    <Card 
      hoverable 
      className="flex flex-col overflow-hidden group"
      style={{ animationDelay: `${index * 50}ms` }}
    >
      {/* Image Container con overlay gradient */}
      <div className="relative aspect-square w-full overflow-hidden bg-slate-800">
        {gpu.image_url ? (
          <img
            src={gpu.image_url}
            alt={gpu.name}
            className="h-full w-full object-cover transition-transform duration-500 group-hover:scale-110"
          />
        ) : (
          <div className="flex h-full items-center justify-center bg-gradient-to-br from-slate-800 to-slate-900">
            <Cpu className="h-20 w-20 text-primary/30" />
          </div>
        )}
        
        {/* Gradient overlay */}
        <div className="absolute inset-0 bg-gradient-to-t from-slate-900 via-transparent to-transparent opacity-60" />
        
        {isOutOfStock && (
          <div className="absolute inset-0 flex items-center justify-center bg-black/70 backdrop-blur-sm">
            <span className="rounded-full bg-red-600 px-4 py-2 text-sm font-bold text-white shadow-neon">
              Sin Stock
            </span>
          </div>
        )}

        {/* Brand badge */}
        <div className="absolute left-3 top-3">
          <span className="rounded-full bg-primary/80 px-3 py-1 text-xs font-semibold uppercase tracking-wide text-white backdrop-blur-sm">
            {gpu.brand}
          </span>
        </div>
      </div>

      {/* Content */}
      <CardContent className="flex-1 space-y-3 p-4">
        {/* Name */}
        <h3 className="line-clamp-2 text-lg font-semibold text-text-primary group-hover:text-primary transition-colors">
          {gpu.name}
        </h3>

        {/* Specs */}
        <div className="flex items-center gap-4 text-sm">
          <div className="flex items-center gap-1.5">
            <div className="h-2 w-2 rounded-full bg-primary animate-pulse" />
            <span className="font-bold text-primary">{gpu.vram}GB</span>
            <span className="text-text-muted">VRAM</span>
          </div>
          {gpu.cuda_cores && (
            <div className="flex items-center gap-1.5">
              <div className="h-2 w-2 rounded-full bg-accent-cyan" />
              <span className="font-bold text-accent-cyan">{gpu.cuda_cores.toLocaleString()}</span>
              <span className="text-text-muted">Cores</span>
            </div>
          )}
        </div>

        {/* Price */}
        <div className="pt-2 border-t border-slate-700/50">
          <span className="text-2xl font-bold text-gradient">
            ${gpu.price.toLocaleString('es-CL')}
          </span>
        </div>
      </CardContent>

      {/* Footer */}
      <CardFooter className="flex items-center justify-between border-t border-slate-700/50 p-4 pt-4 bg-slate-800/50">
        <span className="text-sm">
          {isOutOfStock ? (
            <span className="text-red-500 font-medium">Agotado</span>
          ) : (
            <span className="text-text-secondary">
              <span className="font-semibold text-accent-green">{gpu.stock}</span> disponibles
            </span>
          )}
        </span>
        <Link to={`/gpu/${gpu.id}`}>
          <Button 
            variant="primary" 
            size="sm" 
            disabled={isOutOfStock}
            className="shadow-neon-sm hover:shadow-neon transition-all"
          >
            Ver detalles
          </Button>
        </Link>
      </CardFooter>
    </Card>
  );
};

export default HomePage;
