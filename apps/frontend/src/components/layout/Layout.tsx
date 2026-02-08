import { Outlet } from 'react-router-dom';
import Navbar from './Navbar';

interface LayoutProps {
  children?: React.ReactNode;
}

const Layout = ({ children }: LayoutProps) => {
  return (
    <div className="min-h-screen bg-background">
      <Navbar /> {/* ✅ Ahora obtiene itemCount desde el contexto */}
      
      <main className="mx-auto max-w-7xl px-4 py-8 sm:px-6 lg:px-8">
        {children || <Outlet />}
      </main>

      {/* Footer oscuro */}
      <footer className="mt-auto border-t border-slate-800 bg-slate-900/50 py-8">
        <div className="mx-auto max-w-7xl px-4 text-center">
          <p className="text-sm text-text-secondary">
            © {new Date().getFullYear()} <span className="text-gradient font-semibold">GpuChile</span>
            {' '}- Proyecto Portfolio EKS Production-Grade
          </p>
        </div>
      </footer>
    </div>
  );
};

export default Layout;
