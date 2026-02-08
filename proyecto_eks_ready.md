This file is a merged representation of a subset of the codebase, containing files not matching ignore patterns, combined into a single document by Repomix.

# File Summary

## Purpose
This file contains a packed representation of a subset of the repository's contents that is considered the most important context.
It is designed to be easily consumable by AI systems for analysis, code review,
or other automated processes.

## File Format
The content is organized as follows:
1. This summary section
2. Repository information
3. Directory structure
4. Repository files (if enabled)
5. Multiple file entries, each consisting of:
  a. A header with the file path (## File: path/to/file)
  b. The full contents of the file in a code block

## Usage Guidelines
- This file should be treated as read-only. Any changes should be made to the
  original repository files, not this packed version.
- When processing this file, use the file path to distinguish
  between different files in the repository.
- Be aware that this file may contain sensitive information. Handle it with
  the same level of security as you would the original repository.

## Notes
- Some files may have been excluded based on .gitignore rules and Repomix's configuration
- Binary files are not included in this packed representation. Please refer to the Repository Structure section for a complete list of file paths, including binary files
- Files matching these patterns are excluded: **/terraform/.terraform/**, **/node_modules/**, *.md, *.txt, *.docx
- Files matching patterns in .gitignore are excluded
- Files matching default ignore patterns are excluded
- Files are sorted by Git change count (files with more changes are at the bottom)

# Directory Structure
```
.env.example
.github/workflows/backend-ci.yml
.github/workflows/frontend-ci.yml
.github/workflows/terraform-plan.yml
.gitignore
apps/backend/.dockerignore
apps/backend/.env.example
apps/backend/app/__init__.py
apps/backend/app/api/__init__.py
apps/backend/app/api/deps.py
apps/backend/app/api/routes/__init__.py
apps/backend/app/api/routes/admin.py
apps/backend/app/api/routes/auth.py
apps/backend/app/api/routes/cart.py
apps/backend/app/api/routes/favorites.py
apps/backend/app/api/routes/gpus.py
apps/backend/app/config.py
apps/backend/app/core/__init__.py
apps/backend/app/core/config.py
apps/backend/app/core/security.py
apps/backend/app/db/__init__.py
apps/backend/app/db/base.py
apps/backend/app/db/database.py
apps/backend/app/db/gpu.py
apps/backend/app/db/gpus.py
apps/backend/app/db/session.py
apps/backend/app/main.py
apps/backend/app/models/cart.py
apps/backend/app/models/gpu.py
apps/backend/app/models/user.py
apps/backend/app/schemas/__init__.py
apps/backend/app/schemas/cart.py
apps/backend/app/schemas/gpu.py
apps/backend/app/schemas/user.py
apps/backend/app/scripts/__init__.py
apps/backend/app/scripts/seed_gpus.py
apps/backend/app/seed_data.py
apps/backend/app/services/s3_service.py
apps/backend/docker-compose.yml
apps/backend/Dockerfile
apps/backend/requirements.txt
apps/backend/wait_for_db.py
apps/frontend/.env.example
apps/frontend/.gitignore
apps/frontend/Dockerfile
apps/frontend/eslint.config.js
apps/frontend/index.html
apps/frontend/package.json
apps/frontend/postcss.config.js
apps/frontend/public/vite.svg
apps/frontend/README.md
apps/frontend/src/api/client.ts
apps/frontend/src/App.css
apps/frontend/src/App.tsx
apps/frontend/src/assets/react.svg
apps/frontend/src/components/GPUCard.tsx
apps/frontend/src/components/layout/Layout.tsx
apps/frontend/src/components/layout/Navbar.tsx
apps/frontend/src/components/ui/Button.tsx
apps/frontend/src/components/ui/Card.tsx
apps/frontend/src/context/CartContext.tsx
apps/frontend/src/hooks/useCart.ts
apps/frontend/src/index.css
apps/frontend/src/lib/axios.ts
apps/frontend/src/lib/utils.ts
apps/frontend/src/main.tsx
apps/frontend/src/pages/CartPage.tsx
apps/frontend/src/pages/GPUDetail.jsx
apps/frontend/src/pages/HomePage.tsx
apps/frontend/src/pages/LoginPage.tsx
apps/frontend/src/pages/RegisterPage.tsx
apps/frontend/src/services/cart.service.ts
apps/frontend/src/services/gpu.service.ts
apps/frontend/src/types/api.ts
apps/frontend/src/types/gpu.ts
apps/frontend/src/types/types.ts
apps/frontend/tailwind.config.js
apps/frontend/tsconfig.app.json
apps/frontend/tsconfig.json
apps/frontend/tsconfig.node.json
apps/frontend/vite.config.ts
docker-compose.yml
docs/decisions/adr-002-lambda-convention.md
helm/backend/Chart.yaml
helm/backend/templates/_helpers.tpl
helm/backend/templates/deployment.yaml
helm/backend/templates/external-secret.yaml
helm/backend/templates/hpa.yaml
helm/backend/templates/ingress.yaml
helm/backend/templates/service.yaml
helm/backend/values.yaml
helm/frontend/Chart.yaml
helm/frontend/nginx.conf
helm/frontend/templates/_helpers.tpl
helm/frontend/templates/configmap.yaml
helm/frontend/templates/deployment.yaml
helm/frontend/templates/ingress.yaml
helm/frontend/templates/service.yaml
helm/frontend/values.yaml
kubernetes/external-secrets/external-secret.yaml
kubernetes/external-secrets/namespace.yaml
kubernetes/external-secrets/secret-store.yaml
kubernetes/providers.tf
kubernetes/redis/deployment.yaml
kubernetes/redis/redis.yaml
lambda/image-resizer/Dockerfile
lambda/image-resizer/lambda_function.py
lambda/image-resizer/requirements.txt
Makefile
scripts/auto_destroy.ps1
scripts/docker/build_and_push.sh
terraform/.terraform.lock.hcl
terraform/backend.tf
terraform/main.tf
terraform/modules/ecr/main.tf
terraform/modules/ecr/outputs.tf
terraform/modules/ecr/variables.tf
terraform/modules/eks/main.tf
terraform/modules/eks/outputs.tf
terraform/modules/eks/variables.tf
terraform/modules/irsa/main.tf
terraform/modules/irsa/outputs.tf
terraform/modules/irsa/variables.tf
terraform/modules/lambda/lambda_function.zip
terraform/modules/lambda/main.tf
terraform/modules/lambda/outputs.tf
terraform/modules/lambda/variables.tf
terraform/modules/monitoring/main.tf
terraform/modules/monitoring/outputs.tf
terraform/modules/monitoring/variables.tf
terraform/modules/monitoring/versions.tf
terraform/modules/rds/main.tf
terraform/modules/rds/outputs.tf
terraform/modules/rds/variables.tf
terraform/modules/s3/main.tf
terraform/modules/s3/outputs.tf
terraform/modules/s3/variables.tf
terraform/modules/secrets/main.tf
terraform/modules/secrets/outputs.tf
terraform/modules/secrets/variables.tf
terraform/modules/vpc/main.tf
terraform/modules/vpc/outputs.tf
terraform/modules/vpc/variables.tf
terraform/outputs.tf
terraform/variables.tf
```

# Files

## File: .env.example
````
# =============================================================================
# GPUCHILE - Example Environment Variables
# =============================================================================

# PostgreSQL
POSTGRES_USER=postgres
POSTGRES_PASSWORD=change-me-please
POSTGRES_DB=gpuchile

# Redis
REDIS_PASSWORD=change-me-please

# Backend
SECRET_KEY=generate-with-python-secrets-module-min-32-chars

# Frontend
VITE_API_URL=http://localhost:8000/api
````

## File: .github/workflows/backend-ci.yml
````yaml
name: Backend CI/CD

on:
  push:
    branches: [main]
    paths:
      - 'apps/backend/**'
      - '.github/workflows/backend-ci.yml'

env:
  AWS_REGION: us-east-1
  ECR_REPOSITORY: gpuchile-backend
  EKS_CLUSTER_NAME: gpuchile-cluster

jobs:
  build-and-deploy:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout code
        uses: actions/checkout@v4

      # 👇 CORRECCIÓN: Usamos Access Keys en lugar de Role OIDC
      - name: Configure AWS credentials
        uses: aws-actions/configure-aws-credentials@v4
        with:
          aws-access-key-id: ${{ secrets.AWS_ACCESS_KEY_ID }}
          aws-secret-access-key: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
          aws-region: ${{ env.AWS_REGION }}

      - name: Login to Amazon ECR
        id: login-ecr
        uses: aws-actions/amazon-ecr-login@v2

      - name: Build, tag, and push image to ECR
        id: build-image
        env:
          ECR_REGISTRY: ${{ steps.login-ecr.outputs.registry }}
          IMAGE_TAG: ${{ github.sha }}
        run: |
          cd apps/backend
          docker build -t $ECR_REGISTRY/$ECR_REPOSITORY:$IMAGE_TAG .
          docker push $ECR_REGISTRY/$ECR_REPOSITORY:$IMAGE_TAG
          echo "image=$ECR_REGISTRY/$ECR_REPOSITORY:$IMAGE_TAG" >> $GITHUB_OUTPUT

      - name: Install kubectl
        uses: azure/setup-kubectl@v3

      - name: Update kubeconfig
        run: |
          aws eks update-kubeconfig --name ${{ env.EKS_CLUSTER_NAME }} --region ${{ env.AWS_REGION }}

      - name: Install Helm
        uses: azure/setup-helm@v3
        with:
          version: '3.13.0'

      - name: Deploy to EKS with Helm
        env:
          IMAGE_TAG: ${{ github.sha }}
        run: |
          # 👇 CORRECCIÓN: Sintaxis simplificada y comillas arregladas
          helm upgrade --install gpuchile-backend ./helm/backend \
            --namespace default \
            --set image.tag=$IMAGE_TAG \
            --wait --timeout 5m
````

## File: .github/workflows/frontend-ci.yml
````yaml
name: Frontend CI/CD

on:
  push:
    branches: [main, develop]
    paths:
      - 'apps/frontend/**'
      - '.github/workflows/frontend-ci.yml'
  pull_request:
    branches: [main]
    paths:
      - 'apps/frontend/**'

env:
  AWS_REGION: us-east-1
  ECR_REPOSITORY: gpuchile-frontend
  EKS_CLUSTER_NAME: gpuchile-cluster

jobs:
  build-and-deploy:
    runs-on: ubuntu-latest
    permissions:
      id-token: write
      contents: read

    steps:
      - name: Checkout code
        uses: actions/checkout@v4

      - name: Configure AWS credentials
        uses: aws-actions/configure-aws-credentials@v4
        with:
          role-to-assume: ${{ secrets.AWS_ROLE_ARN }}
          aws-region: ${{ env.AWS_REGION }}

      - name: Configure AWS credentials
        uses: aws-actions/configure-aws-credentials@v4
        with:
          aws-access-key-id: ${{ secrets.AWS_ACCESS_KEY_ID }}
          aws-secret-access-key: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
          aws-region: ${{ env.AWS_REGION }}

      - name: Login to Amazon ECR
        id: login-ecr
        uses: aws-actions/amazon-ecr-login@v2

      - name: Build, tag, and push image
        id: build-image
        env:
          ECR_REGISTRY: ${{ steps.login-ecr.outputs.registry }}
          IMAGE_TAG: ${{ github.sha }}
        run: |
          cd apps/frontend
          docker build -t $ECR_REGISTRY/$ECR_REPOSITORY:$IMAGE_TAG .
          docker tag $ECR_REGISTRY/$ECR_REPOSITORY:$IMAGE_TAG $ECR_REGISTRY/$ECR_REPOSITORY:latest
          docker push $ECR_REGISTRY/$ECR_REPOSITORY:$IMAGE_TAG
          docker push $ECR_REGISTRY/$ECR_REPOSITORY:latest

      - name: Update kubeconfig
        run: |
          aws eks update-kubeconfig --name ${{ env.EKS_CLUSTER_NAME }} --region ${{ env.AWS_REGION }}

      - name: Install Helm
        uses: azure/setup-helm@v3

      - name: Deploy to EKS with Helm
        env:
          IMAGE_TAG: ${{ github.sha }}
        run: |
          helm upgrade --install gpuchile-frontend ./helm/frontend \
            --namespace default \
            --set image.tag=$IMAGE_TAG \
            --wait --timeout 5m

      - name: Verify deployment
        run: |
          kubectl rollout status deployment/gpuchile-frontend -n default
          kubectl get service gpuchile-frontend -n default
````

## File: .github/workflows/terraform-plan.yml
````yaml
name: Terraform Plan

on:
  pull_request:
    branches: [main]
    paths:
      - 'terraform/**'

jobs:
  terraform-plan:
    runs-on: ubuntu-latest
    permissions:
      id-token: write
      contents: read
      pull-requests: write

    steps:
      - name: Checkout
        uses: actions/checkout@v4

      - name: Configure AWS credentials
        uses: aws-actions/configure-aws-credentials@v4
        with:
          role-to-assume: ${{ secrets.AWS_ROLE_ARN }}
          aws-region: us-east-1

      - name: Setup Terraform
        uses: hashicorp/setup-terraform@v3
        with:
          terraform_version: 1.6.0

      - name: Terraform Init
        working-directory: terraform
        run: terraform init

      - name: Terraform Plan
        working-directory: terraform
        run: terraform plan -no-color
        continue-on-error: true

      - name: Comment PR
        uses: actions/github-script@v7
        with:
          script: |
            github.rest.issues.createComment({
              issue_number: context.issue.number,
              owner: context.repo.owner,
              repo: context.repo.repo,
              body: '✅ Terraform Plan ejecutado. Revisa los logs de la Action.'
            })
````

## File: apps/backend/.dockerignore
````
__pycache__/
*.py[cod]
*$py.class
*.so
.Python
venv/
.env
.env.local
*.db
*.sqlite3
.pytest_cache/
.coverage
htmlcov/
.mypy_cache/
.DS_Store
````

## File: apps/backend/app/__init__.py
````python

````

## File: apps/backend/app/api/__init__.py
````python

````

## File: apps/backend/app/api/deps.py
````python
from typing import Generator, Optional
from fastapi import Depends, HTTPException, status
from fastapi.security import OAuth2PasswordBearer
from jose import jwt, JWTError
from pydantic import ValidationError
from sqlalchemy.orm import Session

from app.db.database import SessionLocal
from app.core.config import settings
# ✅ ARREGLADO: Importamos User del nuevo archivo
from app.models.user import User
from app.schemas.token import TokenPayload

oauth2_scheme = OAuth2PasswordBearer(tokenUrl=f"{settings.API_V1_STR}/auth/login")

def get_db() -> Generator:
    try:
        db = SessionLocal()
        yield db
    finally:
        db.close()

def get_current_user(
    db: Session = Depends(get_db), token: str = Depends(oauth2_scheme)
) -> User:
    try:
        payload = jwt.decode(
            token, settings.SECRET_KEY, algorithms=[settings.ALGORITHM]
        )
        token_data = TokenPayload(**payload)
    except (JWTError, ValidationError):
        raise HTTPException(
            status_code=status.HTTP_403_FORBIDDEN,
            detail="Could not validate credentials",
        )
    user = db.query(User).filter(User.id == token_data.sub).first()
    if not user:
        raise HTTPException(status_code=404, detail="User not found")
    return user

def get_current_admin(
    current_user: User = Depends(get_current_user),
) -> User:
    if not current_user.is_superuser:
        raise HTTPException(
            status_code=400, detail="The user doesn't have enough privileges"
        )
    return current_user
````

## File: apps/backend/app/api/routes/__init__.py
````python

````

## File: apps/backend/app/api/routes/admin.py
````python
from fastapi import APIRouter, Depends, HTTPException, UploadFile, File, Form, status
from sqlalchemy.orm import Session
from app.db.session import get_db
from app.db.models import GPU as GPUModel
from app.models.gpu import GPUCreate, GPU as GPUSchema
from app.services.s3_service import upload_image # ¡Vamos a crear esto!
import json
from typing import Optional

router = APIRouter()

# ⚠️ NOTA: En un caso real, aquí iría: dependencies=[Depends(get_current_admin_user)]
# Para el portfolio inicial, lo dejamos abierto o simulado para facilitar pruebas.

@router.post("/gpus", response_model=GPUSchema, status_code=status.HTTP_201_CREATED)
async def create_gpu(
    # Recibimos datos como Form porque viene una imagen adjunta (multipart/form-data)
    model: str = Form(...),
    brand: str = Form(...),
    price: float = Form(...),
    vram: int = Form(...),
    stock: int = Form(0),
    file: UploadFile = File(...), # La imagen es obligatoria al crear
    specs: str = Form("{}"), # JSON stringificado
    db: Session = Depends(get_db)
):
    """
    Crea una GPU y sube su imagen a S3 (carpeta /original)
    """
    # 1. Subir imagen a S3 y obtener el KEY único (ej: "uuid-123.jpg")
    # No guardamos la URL, solo el key.
    try:
        file_content = await file.read()
        image_key = upload_image(file_content, file.filename)
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Error subiendo imagen: {str(e)}")

    # 2. Parsear specs (vienen como string JSON desde frontend/postman)
    try:
        specs_dict = json.loads(specs)
    except json.JSONDecodeError:
        specs_dict = {}

    # 3. Crear registro en DB
    new_gpu = GPUModel(
        model=model,
        brand=brand,
        price=price,
        vram=vram,
        stock=stock,
        specs=specs_dict,
        image_key=image_key # 👈 Aquí está la magia de la convención
    )
    
    db.add(new_gpu)
    db.commit()
    db.refresh(new_gpu)
    
    return new_gpu
````

## File: apps/backend/app/api/routes/auth.py
````python
from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.orm import Session
from datetime import timedelta

from app.db.database import get_db
from app.models.user import User
from app.schemas.user import UserCreate, UserLogin, Token, User as UserSchema
from app.core.security import verify_password, get_password_hash, create_access_token
from app.core.config import settings

router = APIRouter()


@router.post("/register", response_model=UserSchema, status_code=status.HTTP_201_CREATED)
def register(user_in: UserCreate, db: Session = Depends(get_db)):
    """Registrar nuevo usuario"""
    
    # Verificar si email ya existe
    existing_user = db.query(User).filter(User.email == user_in.email).first()
    if existing_user:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="Email already registered"
        )
    
    # Verificar si username ya existe
    existing_username = db.query(User).filter(User.username == user_in.username).first()
    if existing_username:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="Username already taken"
        )
    
    # Crear usuario
    hashed_password = get_password_hash(user_in.password)
    user = User(
        email=user_in.email,
        username=user_in.username,
        hashed_password=hashed_password,
        role="customer"  # Por defecto es customer
    )
    
    db.add(user)
    db.commit()
    db.refresh(user)
    
    return user


@router.post("/login", response_model=Token)
def login(user_credentials: UserLogin, db: Session = Depends(get_db)):
    """Login y obtener JWT token"""
    
    # Buscar usuario
    user = db.query(User).filter(User.username == user_credentials.username).first()
    
    if not user:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Incorrect username or password"
        )
    
    # Verificar password
    if not verify_password(user_credentials.password, user.hashed_password):
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Incorrect username or password"
        )
    
    # Crear token
    access_token_expires = timedelta(minutes=settings.ACCESS_TOKEN_EXPIRE_MINUTES)
    access_token = create_access_token(
        data={"sub": str(user.id)},
        expires_delta=access_token_expires
    )
    
    return Token(
        access_token=access_token,
        token_type="bearer",
        user=user
    )
````

## File: apps/backend/app/api/routes/cart.py
````python
from fastapi import APIRouter, Depends, HTTPException, status, Header
from sqlalchemy.orm import Session
from typing import Optional
import redis
import json

from app.db.database import get_db
from app.models.cart import Cart
from app.models.gpu import GPU
from app.models.user import User
from app.schemas.cart import CartItemCreate, CartResponse, CartItem, CartMigrateRequest
from app.core.config import settings

router = APIRouter()

# Cliente Redis
try:
    redis_client = redis.from_url(settings.REDIS_URL, decode_responses=True)
except Exception:
    redis_client = None

def get_redis_cart_key(session_id: str) -> str:
    return f"cart:{session_id}"

def get_optional_current_user(
    authorization: Optional[str] = Header(None),
    db: Session = Depends(get_db)
) -> Optional[User]:
    if not authorization or not authorization.startswith("Bearer "):
        return None
    try:
        from app.core.security import decode_access_token
        token = authorization.replace("Bearer ", "")
        payload = decode_access_token(token)
        if payload is None: return None
        user_id: int = payload.get("sub")
        if user_id is None: return None
        return db.query(User).filter(User.id == int(user_id)).first()
    except Exception:
        return None

@router.post("/", status_code=status.HTTP_201_CREATED)
def add_to_cart(
    item: CartItemCreate,
    session_id: Optional[str] = Header(None),
    current_user: Optional[User] = Depends(get_optional_current_user),
    db: Session = Depends(get_db)
):
    gpu = db.query(GPU).filter(GPU.id == item.gpu_id).first()
    if not gpu:
        raise HTTPException(status_code=404, detail="GPU not found")
    
    if gpu.stock < item.quantity:
        raise HTTPException(status_code=400, detail=f"Stock insuficiente. Disponible: {gpu.stock}")
    
    # Usuario Autenticado (Postgres)
    if current_user:
        existing_item = db.query(Cart).filter(
            Cart.user_id == current_user.id,
            Cart.gpu_id == item.gpu_id
        ).first()
        
        if existing_item:
            existing_item.quantity += item.quantity
        else:
            cart_item = Cart(user_id=current_user.id, gpu_id=item.gpu_id, quantity=item.quantity)
            db.add(cart_item)
        db.commit()
        return {"message": "Agregado al carrito (DB)"}
    
    # Usuario Anónimo (Redis)
    else:
        if not session_id or not redis_client:
            raise HTTPException(status_code=503, detail="Sistema de sesión no disponible")
        
        cart_key = get_redis_cart_key(session_id)
        cart_data = redis_client.get(cart_key)
        cart = json.loads(cart_data) if cart_data else {}
        
        gpu_id_str = str(item.gpu_id)
        if gpu_id_str in cart:
            cart[gpu_id_str] += item.quantity
        else:
            cart[gpu_id_str] = item.quantity
        
        redis_client.setex(cart_key, 604800, json.dumps(cart))
        return {"message": "Agregado al carrito (Redis)"}

@router.get("/", response_model=CartResponse)
def get_cart(
    session_id: Optional[str] = Header(None),
    current_user: Optional[User] = Depends(get_optional_current_user),
    db: Session = Depends(get_db)
):
    # Autenticado
    if current_user:
        cart_items = db.query(Cart).filter(Cart.user_id == current_user.id).all()
        items = []
        total = 0.0
        for ci in cart_items:
            if ci.gpu:
                items.append(CartItem(
                    id=ci.id,
                    gpu_id=ci.gpu_id,
                    quantity=ci.quantity,
                    gpu=ci.gpu
                ))
                total += ci.gpu.price * ci.quantity
        return CartResponse(items=items, total=total)
    
    # Anónimo (Redis)
    else:
        if not session_id or not redis_client:
            return CartResponse(items=[], total=0.0)
        
        cart_key = get_redis_cart_key(session_id)
        cart_data = redis_client.get(cart_key)
        
        if not cart_data:
            return CartResponse(items=[], total=0.0)
        
        cart = json.loads(cart_data)
        items = []
        total = 0.0
        
        for gpu_id_str, quantity in cart.items():
            gpu = db.query(GPU).filter(GPU.id == int(gpu_id_str)).first()
            if gpu:
                items.append(CartItem(
                    # TRUCO: Usamos el gpu_id como id del item para poder borrarlo luego
                    id=gpu.id, 
                    gpu_id=gpu.id,
                    quantity=quantity,
                    gpu=gpu
                ))
                total += gpu.price * quantity
        
        return CartResponse(items=items, total=total)

# ✅ AQUÍ ESTABA EL PROBLEMA, AGREGADA LÓGICA REDIS
@router.delete("/{item_id}", status_code=status.HTTP_204_NO_CONTENT)
def remove_from_cart(
    item_id: int,
    session_id: Optional[str] = Header(None),
    current_user: Optional[User] = Depends(get_optional_current_user),
    db: Session = Depends(get_db)
):
    # Autenticado (Borrar de Postgres por ID de la fila)
    if current_user:
        db.query(Cart).filter(Cart.id == item_id, Cart.user_id == current_user.id).delete()
        db.commit()
        return None

    # Anónimo (Borrar de Redis usando el GPU ID como key)
    if session_id and redis_client:
        cart_key = get_redis_cart_key(session_id)
        cart_data = redis_client.get(cart_key)
        if cart_data:
            cart = json.loads(cart_data)
            # Convertimos a string porque JSON keys son strings
            item_id_str = str(item_id)
            if item_id_str in cart:
                del cart[item_id_str]
                redis_client.setex(cart_key, 604800, json.dumps(cart))
    
    return None

@router.delete("/", status_code=status.HTTP_204_NO_CONTENT)
def clear_cart(
    session_id: Optional[str] = Header(None),
    current_user: Optional[User] = Depends(get_optional_current_user),
    db: Session = Depends(get_db)
):
    if current_user:
        db.query(Cart).filter(Cart.user_id == current_user.id).delete()
        db.commit()
    elif session_id and redis_client:
        cart_key = get_redis_cart_key(session_id)
        redis_client.delete(cart_key)
    return None
````

## File: apps/backend/app/api/routes/favorites.py
````python
from fastapi import APIRouter

router = APIRouter()

@router.get("/")
def get_favorites():
    return {"msg": "Favoritos endpoint pendiente"}
````

## File: apps/backend/app/api/routes/gpus.py
````python
from typing import List
from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.orm import Session

from app.db.database import get_db
# Importamos el MODELO de base de datos (SQLAlchemy)
from app.models.gpu import GPU as GPUModel
# Importamos los ESQUEMAS de validación (Pydantic)
from app.schemas.gpu import GPU as GPUSchema, GPUCreate, GPUUpdate

router = APIRouter()

# -----------------------------------------------------------------------------
# RUTAS PÚBLICAS (GET)
# -----------------------------------------------------------------------------

@router.get("/", response_model=List[GPUSchema])
def list_gpus(
    skip: int = 0,
    limit: int = 100,
    db: Session = Depends(get_db)
):
    """
    Listar GPUs disponibles en la tienda.
    """
    # Consulta simple a la base de datos
    gpus = db.query(GPUModel).offset(skip).limit(limit).all()
    return gpus


@router.get("/{gpu_id}", response_model=GPUSchema)
def get_gpu(gpu_id: int, db: Session = Depends(get_db)):
    """
    Obtener el detalle de una GPU específica.
    """
    gpu = db.query(GPUModel).filter(GPUModel.id == gpu_id).first()
    if not gpu:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="GPU no encontrada"
        )
    return gpu


# -----------------------------------------------------------------------------
# RUTAS ADMINISTRATIVAS (POST, PUT, DELETE)
# Nota: Para este MVP, quitamos la dependencia de 'get_current_admin' 
# para que puedas probarlas desde Swagger sin loguearte.
# -----------------------------------------------------------------------------

@router.post("/", response_model=GPUSchema, status_code=status.HTTP_201_CREATED)
def create_gpu(gpu_in: GPUCreate, db: Session = Depends(get_db)):
    """
    Crear una nueva GPU.
    """
    # Convertimos el esquema Pydantic a Modelo SQLAlchemy
    # model_dump() convierte el objeto a un diccionario
    db_gpu = GPUModel(**gpu_in.model_dump())
    
    db.add(db_gpu)
    db.commit()
    db.refresh(db_gpu)
    return db_gpu


@router.put("/{gpu_id}", response_model=GPUSchema)
def update_gpu(gpu_id: int, gpu_in: GPUUpdate, db: Session = Depends(get_db)):
    """
    Actualizar una GPU existente.
    """
    db_gpu = db.query(GPUModel).filter(GPUModel.id == gpu_id).first()
    if not db_gpu:
        raise HTTPException(status_code=404, detail="GPU no encontrada")
    
    # Actualizamos solo los campos que vienen con valor (exclude_unset=True)
    update_data = gpu_in.model_dump(exclude_unset=True)
    
    for field, value in update_data.items():
        setattr(db_gpu, field, value)
    
    db.commit()
    db.refresh(db_gpu)
    return db_gpu


@router.delete("/{gpu_id}", status_code=status.HTTP_204_NO_CONTENT)
def delete_gpu(gpu_id: int, db: Session = Depends(get_db)):
    """
    Eliminar una GPU.
    """
    db_gpu = db.query(GPUModel).filter(GPUModel.id == gpu_id).first()
    if not db_gpu:
        raise HTTPException(status_code=404, detail="GPU no encontrada")
    
    db.delete(db_gpu)
    db.commit()
    return None
````

## File: apps/backend/app/core/__init__.py
````python

````

## File: apps/backend/app/core/config.py
````python
from pydantic_settings import BaseSettings
from typing import Optional

class Settings(BaseSettings):
    # Database
    DATABASE_URL: str
    
    # Redis
    REDIS_URL: str
    
    # JWT
    SECRET_KEY: str
    ALGORITHM: str = "HS256"
    ACCESS_TOKEN_EXPIRE_MINUTES: int = 30
    
    # AWS S3
    AWS_REGION: str = "us-east-1"
    S3_BUCKET_NAME: str
    AWS_ACCESS_KEY_ID: Optional[str] = None
    AWS_SECRET_ACCESS_KEY: Optional[str] = None
    
    # App
    ENVIRONMENT: str = "development"
    DEBUG: bool = True
    
    class Config:
        env_file = ".env"
        case_sensitive = True

settings = Settings()
````

## File: apps/backend/app/core/security.py
````python
from datetime import datetime, timedelta
from typing import Optional
from jose import JWTError, jwt
from passlib.context import CryptContext
from app.core.config import settings

pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")

def verify_password(plain_password: str, hashed_password: str) -> bool:
    return pwd_context.verify(plain_password, hashed_password)

def get_password_hash(password: str) -> str:
    return pwd_context.hash(password)

def create_access_token(data: dict, expires_delta: Optional[timedelta] = None) -> str:
    to_encode = data.copy()
    if expires_delta:
        expire = datetime.utcnow() + expires_delta
    else:
        expire = datetime.utcnow() + timedelta(minutes=settings.ACCESS_TOKEN_EXPIRE_MINUTES)
    
    to_encode.update({"exp": expire})
    encoded_jwt = jwt.encode(to_encode, settings.SECRET_KEY, algorithm=settings.ALGORITHM)
    return encoded_jwt

def decode_access_token(token: str) -> Optional[dict]:
    try:
        payload = jwt.decode(token, settings.SECRET_KEY, algorithms=[settings.ALGORITHM])
        return payload
    except JWTError:
        return None
````

## File: apps/backend/app/db/__init__.py
````python

````

## File: apps/backend/app/db/base.py
````python
# apps/backend/app/db/base.py
from sqlalchemy.orm import declarative_base # ✅ Forma moderna (SQLAlchemy 1.4/2.0)

Base = declarative_base()
````

## File: apps/backend/app/db/database.py
````python
from sqlalchemy import create_engine
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker
from app.core.config import settings

engine = create_engine(settings.DATABASE_URL, pool_pre_ping=True)
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)

Base = declarative_base()

def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()
````

## File: apps/backend/app/db/gpu.py
````python
from pydantic import BaseModel, Field, computed_field # ✅ Importar computed_field
from typing import Optional, Dict, Any
from datetime import datetime
from app.config import settings

# Base común
class GPUBase(BaseModel):
    model: str
    brand: str
    series: Optional[str] = None
    vram: int = Field(..., gt=0, description="VRAM in GB")
    memory_type: Optional[str] = None
    price: float = Field(..., gt=0)
    stock: int = Field(default=0, ge=0)
    specs: Dict[str, Any] = Field(default_factory=dict)
    is_featured: bool = False

class GPUCreate(GPUBase):
    image_key: Optional[str] = None # Admin envía esto al crear

class GPU(GPUBase):
    id: int
    image_key: Optional[str] = None
    created_at: datetime
    
    class Config:
        from_attributes = True

    # ✅ SENIOR WAY: Computed Fields
    # Esto agrega 'image_url' y 'thumbnail_url' al JSON de respuesta automáticamente
    
    @computed_field
    @property
    def image_url(self) -> Optional[str]:
        if not self.image_key:
            return None
        return f"https://{settings.S3_BUCKET}.s3.{settings.S3_REGION}.amazonaws.com/original/{self.image_key}"

    @computed_field
    @property
    def thumbnail_url(self) -> Optional[str]:
        if not self.image_key:
            return None
        return f"https://{settings.S3_BUCKET}.s3.{settings.S3_REGION}.amazonaws.com/thumbnails/{self.image_key}"
````

## File: apps/backend/app/db/gpus.py
````python
# apps/backend/app/api/routes/gpus.py
from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from typing import List
from app.db.session import get_db
from app.db.models import GPU as GPUModel
from app.models.gpu import GPU as GPUSchema

router = APIRouter()

@router.get("/", response_model=List[GPUSchema])
def read_gpus(skip: int = 0, limit: int = 100, db: Session = Depends(get_db)):
    """
    Obtiene lista de GPUs con paginación
    """
    gpus = db.query(GPUModel).offset(skip).limit(limit).all()
    # Pydantic y nuestra lógica en __init__ se encargan de las URLs
    return gpus
````

## File: apps/backend/app/db/session.py
````python
# apps/backend/app/db/session.py
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker
from app.config import settings

# Crear el motor de la base de datos
# pool_pre_ping=True: Verifica si la conexión sigue viva antes de usarla (Vital para AWS RDS)
engine = create_engine(
    settings.DATABASE_URL, 
    pool_pre_ping=True,
    pool_size=10,
    max_overflow=20
)

SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)

# Dependency Injection para FastAPI
def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()
````

## File: apps/backend/app/models/cart.py
````python
from sqlalchemy import Column, Integer, ForeignKey
from app.db.database import Base

class Cart(Base):
    __tablename__ = "carts"

    id = Column(Integer, primary_key=True, index=True)
    # Por ahora lo hacemos simple para que no falle por claves foráneas
    user_id = Column(Integer, nullable=True) 
    gpu_id = Column(Integer, nullable=False)
    quantity = Column(Integer, default=1)
````

## File: apps/backend/app/models/user.py
````python
from sqlalchemy import Column, Integer, String, Boolean
from app.db.database import Base

class User(Base):
    __tablename__ = "users"

    id = Column(Integer, primary_key=True, index=True)
    email = Column(String, unique=True, index=True)
    hashed_password = Column(String)
    full_name = Column(String, nullable=True)
    is_active = Column(Boolean, default=True)
    is_superuser = Column(Boolean, default=False)
````

## File: apps/backend/app/schemas/__init__.py
````python

````

## File: apps/backend/app/schemas/cart.py
````python
from pydantic import BaseModel
from typing import List, Optional
from app.schemas.gpu import GPU # Importamos el esquema de GPU para anidar la respuesta

class CartItemCreate(BaseModel):
    gpu_id: int
    quantity: int = 1

class CartItem(BaseModel):
    id: int
    gpu_id: int
    quantity: int
    gpu: GPU # Esto permite ver los detalles de la tarjeta en el carrito

    class Config:
        from_attributes = True

class CartResponse(BaseModel):
    items: List[CartItem]
    total: float

class CartMigrateRequest(BaseModel):
    session_id: str
````

## File: apps/backend/app/schemas/gpu.py
````python
from pydantic import BaseModel, Field, computed_field
from typing import Optional, Dict, Any
from datetime import datetime
from app.core.config import settings

# Base común
class GPUBase(BaseModel):
    name: str 
    model: str
    brand: str
    vram: int = Field(..., gt=0, description="VRAM in GB")
    price: float = Field(..., gt=0)
    stock: int = Field(default=0, ge=0)
    cuda_cores: Optional[int] = None
    image_url: Optional[str] = None 
    description: Optional[str] = None
    is_featured: bool = False

# Lo que recibimos al crear (POST)
class GPUCreate(GPUBase):
    pass

# --- LO QUE FALTABA ---
# Lo que recibimos al actualizar (PUT/PATCH) - Todos los campos opcionales
class GPUUpdate(BaseModel):
    name: Optional[str] = None
    model: Optional[str] = None
    brand: Optional[str] = None
    vram: Optional[int] = None
    price: Optional[float] = None
    stock: Optional[int] = None
    cuda_cores: Optional[int] = None
    image_url: Optional[str] = None
    description: Optional[str] = None
    is_featured: Optional[bool] = None

# Respuesta para URLs presignadas de S3
class PresignedURLResponse(BaseModel):
    upload_url: str
    file_key: str
# ----------------------

# Lo que devolvemos al cliente (GET)
class GPU(GPUBase): 
    id: int
    
    class Config:
        from_attributes = True
````

## File: apps/backend/app/schemas/user.py
````python
from pydantic import BaseModel, EmailStr
from datetime import datetime
from typing import Optional

class UserBase(BaseModel):
    email: EmailStr
    username: str

class UserCreate(UserBase):
    password: str

class UserLogin(BaseModel):
    username: str
    password: str

class User(UserBase):
    id: int
    role: str
    created_at: datetime
    
    class Config:
        from_attributes = True

class Token(BaseModel):
    access_token: str
    token_type: str
    user: User
````

## File: apps/backend/app/scripts/__init__.py
````python

````

## File: apps/backend/app/scripts/seed_gpus.py
````python
"""
Seed script para poblar la base de datos con 15 GPUs reales del mercado.
Uso: python -m app.scripts.seed_gpus
"""
import sys
import os
from sqlalchemy.orm import Session

# Add parent directory to path para importar app
sys.path.insert(0, os.path.abspath(os.path.join(os.path.dirname(__file__), '../../..')))

from app.db.database import SessionLocal, engine
from app.db.models import Base, GPU
from datetime import datetime


def create_tables():
    """Crea todas las tablas si no existen"""
    Base.metadata.create_all(bind=engine)
    print("✅ Tablas creadas/verificadas")


def seed_gpus(db: Session):
    """Inserta 15 GPUs reales en la base de datos"""
    
    # Verificar si ya existen GPUs
    try:
        existing_count = db.query(GPU).count()
        if existing_count >= 15:
            print(f"⚠️  Ya existen {existing_count} GPUs en la DB. Saltando seed.")
            return
    except Exception as e:
        print(f"ℹ️  Parece que las tablas no existen o están vacías. Continuando... ({str(e)})")

    gpus_data = [
        # NVIDIA RTX 40 Series (High-End)
        {
            "name": "NVIDIA GeForce RTX 4090",
            "brand": "NVIDIA",
            "model": "RTX 4090",
            "price": 1899.99,
            "stock": 12,
            "vram": 24,
            "cuda_cores": 16384,  # CORREGIDO
            "image_url": None,    # CORREGIDO
            "description": "Flagship GPU with Ada Lovelace architecture. Beast for 4K gaming and AI workloads."
        },
        {
            "name": "NVIDIA GeForce RTX 4080 SUPER",
            "brand": "NVIDIA",
            "model": "RTX 4080 SUPER",
            "price": 1099.99,
            "stock": 18,
            "vram": 16,
            "cuda_cores": 10240,  # CORREGIDO
            "image_url": None,    # CORREGIDO
            "description": "High-performance gaming at 4K with ray tracing and DLSS 3.5."
        },
        {
            "name": "NVIDIA GeForce RTX 4070 Ti SUPER",
            "brand": "NVIDIA",
            "model": "RTX 4070 Ti SUPER",
            "price": 849.99,
            "stock": 25,
            "vram": 16,
            "cuda_cores": 8448,   # CORREGIDO
            "image_url": None,    # CORREGIDO
            "description": "Excellent 1440p performance with 16GB VRAM for content creation."
        },
        {
            "name": "NVIDIA GeForce RTX 4060 Ti",
            "brand": "NVIDIA",
            "model": "RTX 4060 Ti",
            "price": 449.99,
            "stock": 30,
            "vram": 8,
            "cuda_cores": 4352,   # CORREGIDO
            "image_url": None,    # CORREGIDO
            "description": "Solid 1080p gaming with RTX features at accessible price point."
        },
        
        # AMD Radeon RX 7000 Series (Enthusiast)
        {
            "name": "AMD Radeon RX 7900 XTX",
            "brand": "AMD",
            "model": "RX 7900 XTX",
            "price": 999.99,
            "stock": 15,
            "vram": 24,
            "cuda_cores": 6144,   # CORREGIDO
            "image_url": None,    # CORREGIDO
            "description": "AMD's flagship RDNA 3 GPU with 24GB for high-end gaming and workstation tasks."
        },
        {
            "name": "AMD Radeon RX 7900 XT",
            "brand": "AMD",
            "model": "RX 7900 XT",
            "price": 849.99,
            "stock": 20,
            "vram": 20,
            "cuda_cores": 5376,   # CORREGIDO
            "image_url": None,    # CORREGIDO
            "description": "Strong 4K gaming performance with generous 20GB VRAM."
        },
        {
            "name": "AMD Radeon RX 7800 XT",
            "brand": "AMD",
            "model": "RX 7800 XT",
            "price": 549.99,
            "stock": 28,
            "vram": 16,
            "cuda_cores": 3840,   # CORREGIDO
            "image_url": None,    # CORREGIDO
            "description": "Best value for 1440p gaming with 16GB VRAM."
        },
        {
            "name": "AMD Radeon RX 7600",
            "brand": "AMD",
            "model": "RX 7600",
            "price": 299.99,
            "stock": 35,
            "vram": 8,
            "cuda_cores": 2048,   # CORREGIDO
            "image_url": None,    # CORREGIDO
            "description": "Budget-friendly 1080p gaming with RDNA 3 efficiency."
        },
        
        # NVIDIA RTX 30 Series (Previous Gen - Still Relevant)
        {
            "name": "NVIDIA GeForce RTX 3090",
            "brand": "NVIDIA",
            "model": "RTX 3090",
            "price": 1199.99,
            "stock": 8,
            "vram": 24,
            "cuda_cores": 10496,  # CORREGIDO
            "image_url": None,    # CORREGIDO
            "description": "Previous-gen flagship with massive 24GB VRAM for creators."
        },
        {
            "name": "NVIDIA GeForce RTX 3080",
            "brand": "NVIDIA",
            "model": "RTX 3080",
            "price": 799.99,
            "stock": 10,
            "vram": 10,
            "cuda_cores": 8704,   # CORREGIDO
            "image_url": None,    # CORREGIDO
            "description": "Legendary GPU from Ampere era. Still crushes 1440p gaming."
        },
        {
            "name": "NVIDIA GeForce RTX 3070",
            "brand": "NVIDIA",
            "model": "RTX 3070",
            "price": 549.99,
            "stock": 14,
            "vram": 8,
            "cuda_cores": 5888,   # CORREGIDO
            "image_url": None,    # CORREGIDO
            "description": "Sweet spot for 1440p gaming at great value."
        },
        
        # Intel Arc (Emerging Player)
        {
            "name": "Intel Arc A770",
            "brand": "Intel",
            "model": "Arc A770",
            "price": 349.99,
            "stock": 22,
            "vram": 16,
            "cuda_cores": 4096,   # CORREGIDO
            "image_url": None,    # CORREGIDO
            "description": "Intel's high-end discrete GPU with 16GB VRAM and AV1 encoding."
        },
        {
            "name": "Intel Arc A750",
            "brand": "Intel",
            "model": "Arc A750",
            "price": 289.99,
            "stock": 25,
            "vram": 8,
            "cuda_cores": 3584,   # CORREGIDO
            "image_url": None,    # CORREGIDO
            "description": "Competitive 1080p gaming with excellent media encoding."
        },
        
        # AMD Radeon RX 6000 Series (Value Picks)
        {
            "name": "AMD Radeon RX 6800 XT",
            "brand": "AMD",
            "model": "RX 6800 XT",
            "price": 649.99,
            "stock": 12,
            "vram": 16,
            "cuda_cores": 4608,   # CORREGIDO
            "image_url": None,    # CORREGIDO
            "description": "Previous-gen high-end with 16GB VRAM and great rasterization."
        },
        {
            "name": "AMD Radeon RX 6700 XT",
            "brand": "AMD",
            "model": "RX 6700 XT",
            "price": 449.99,
            "stock": 18,
            "vram": 12,
            "cuda_cores": 2560,   # CORREGIDO
            "image_url": None,    # CORREGIDO
            "description": "Solid 1440p gaming with 12GB VRAM at good price."
        },
    ]
    
    # Insertar GPUs
    inserted_count = 0
    for gpu_data in gpus_data:
        # Verificar si ya existe (por model)
        existing = db.query(GPU).filter(GPU.model == gpu_data["model"]).first()
        if not existing:
            gpu = GPU(**gpu_data)
            db.add(gpu)
            inserted_count += 1
    
    db.commit()
    print(f"✅ Seed completado: {inserted_count} GPUs insertadas")


def main():
    print("🚀 Iniciando seed de base de datos...")
    
    # Crear tablas
    create_tables()
    
    # Crear sesión
    db = SessionLocal()
    
    try:
        # Seed GPUs
        seed_gpus(db)
        print("\n🎉 Seed exitoso! Base de datos lista para producción.")
    except Exception as e:
        print(f"❌ Error durante seed: {e}")
        db.rollback()
        raise
    finally:
        db.close()


if __name__ == "__main__":
    main()
````

## File: apps/backend/app/seed_data.py
````python
import logging
# IMPORTANTE: Agregamos engine y Base para poder crear las tablas
from app.db.database import SessionLocal, engine, Base 
from app.models.gpu import GPU

# Configurar logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

def seed_data():
    """
    Crea las tablas y puebla la base de datos.
    """
    # --- CORRECCIÓN CRUCIAL ---
    # Esto obliga a crear las tablas (CREATE TABLE IF NOT EXISTS) antes de insertar datos
    logger.info("🔧 Creando tablas en la base de datos...")
    Base.metadata.create_all(bind=engine)
    # --------------------------

    db = SessionLocal()
    try:
        # Verificar si ya existen datos
        exists = db.query(GPU).first()
        if exists:
            logger.info("⚠️ La base de datos ya tiene datos. Saltando seed.")
            return

        logger.info("🌱 Iniciando seed de datos...")

        # Lista de GPUs (Datos de prueba)
        gpus = [
            GPU(
                name="NVIDIA GeForce RTX 4090",
                brand="ASUS",
                model="ROG Strix",
                price=1599990.0, # Float explícito
                vram=24,
                cuda_cores=16384,
                image_url="https://dlcdnwebimgs.asus.com/gain/4B683935-4309-4087-9759-6F0949709E1E",
                stock=5,
                description="La GPU más potente del mercado.",
                is_featured=True
            ),
            GPU(
                name="NVIDIA GeForce RTX 4070",
                brand="Zotac",
                model="Twin Edge",
                price=599990.0,
                vram=12,
                cuda_cores=5888,
                image_url="https://www.zotac.com/download/files/styles/w1024/public/product_main_image/graphics_cards/zt-d40700e-10m-image01.jpg",
                stock=10,
                description="Excelente relación precio/rendimiento.",
                is_featured=False
            ),
            GPU(
                name="AMD Radeon RX 7900 XTX",
                brand="Sapphire",
                model="Nitro+",
                price=1099990.0,
                vram=24,
                cuda_cores=6144,
                image_url="https://cdn.shopify.com/s/files/1/0024/9803/5810/products/11322-01-20G_01_1024x1024.png",
                stock=3,
                description="Potencia bruta de AMD.",
                is_featured=True
            ),
            GPU(
                name="NVIDIA GeForce RTX 3060",
                brand="EVGA",
                model="XC3",
                price=329990.0,
                vram=12,
                cuda_cores=3584,
                image_url="https://images.evga.com/products/gallery/png/12G-P5-3657-KR_LG_1.png",
                stock=20,
                description="La favorita de los gamers.",
                is_featured=False
            ),
        ]

        db.add_all(gpus)
        db.commit()
        logger.info(f"✅ Seed exitoso: {len(gpus)} GPUs insertadas")

    except Exception as e:
        logger.error(f"❌ Error durante el seed: {e}")
        db.rollback()
    finally:
        db.close()

if __name__ == "__main__":
    seed_data()
````

## File: apps/backend/docker-compose.yml
````yaml
version: '3.8'

services:
  # 🧠 TU API
  backend:
    build: 
      context: .
      dockerfile: Dockerfile
    ports:
      - "8000:8000"
    env_file:
      - .env
    environment:
      # Override para que Docker vea a los otros servicios por nombre
      - DATABASE_URL=postgresql://gpuchile:password@db:5432/gpuchile_dev
      - REDIS_URL=redis://redis:6379/0
      - AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID} # Pasamos credenciales AWS locales
      - AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY}
      - AWS_REGION=us-east-1
    volumes:
      - ./app:/app/app # Hot-reload: cambios en local se reflejan dentro
    depends_on:
      db:
        condition: service_healthy
    command: uvicorn app.main:app --host 0.0.0.0 --port 8000 --reload

  # 🐘 BASE DE DATOS
  db:
    image: postgres:15-alpine
    restart: always
    environment:
      - POSTGRES_USER=gpuchile
      - POSTGRES_PASSWORD=password
      - POSTGRES_DB=gpuchile_dev
    ports:
      - "5432:5432"
    volumes:
      - postgres_data:/var/lib/postgresql/data
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U gpuchile -d gpuchile_dev"]
      interval: 5s
      timeout: 5s
      retries: 5

  # ⚡ CACHE & RATE LIMITING
  redis:
    image: redis:7-alpine
    restart: always
    ports:
      - "6379:6379"
    volumes:
      - redis_data:/data

  # 🛠️ DB VIEWER (Opcional, para ver tus tablas fácil)
  adminer:
    image: adminer
    restart: always
    ports:
      - "8080:8080"

volumes:
  postgres_data:
  redis_data:
````

## File: apps/backend/Dockerfile
````
# Base stage con Python 3.11
FROM python:3.11-slim AS base

# Variables de entorno para Python
ENV PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1 \
    PIP_NO_CACHE_DIR=1 \
    PIP_DISABLE_PIP_VERSION_CHECK=1

WORKDIR /app

# Instalar dependencias del sistema
RUN apt-get update && apt-get install -y \
    gcc \
    postgresql-client \
    && rm -rf /var/lib/apt/lists/*

# Copiar requirements
COPY requirements.txt .

# Instalar dependencias Python
RUN pip install --no-cache-dir -r requirements.txt

# Copiar código fuente
COPY . .

# Exponer puerto
EXPOSE 8000

# Script de inicio (espera DB + corre migraciones + inicia server)
CMD ["sh", "-c", "python wait_for_db.py && python -m app.seed_data && uvicorn app.main:app --host 0.0.0.0 --port 8000 --reload"]
````

## File: apps/backend/wait_for_db.py
````python
"""
Script para esperar a que PostgreSQL esté listo antes de iniciar el backend.
Evita errores de conexión al inicio del docker-compose.
"""
import time
import sys
from sqlalchemy import create_engine
from sqlalchemy.exc import OperationalError
from app.core.config import settings

def wait_for_db(max_retries: int = 30, retry_interval: int = 2):
    """
    Intenta conectarse a la base de datos con reintentos.
    
    Args:
        max_retries: Número máximo de intentos
        retry_interval: Segundos entre intentos
    """
    engine = create_engine(settings.DATABASE_URL)
    
    for attempt in range(1, max_retries + 1):
        try:
            print(f"🔄 Intento {attempt}/{max_retries}: Conectando a PostgreSQL...")
            connection = engine.connect()
            connection.close()
            print("✅ PostgreSQL está listo!")
            return True
        except OperationalError as e:
            if attempt == max_retries:
                print(f"❌ Error: No se pudo conectar a PostgreSQL después de {max_retries} intentos")
                print(f"   Detalles: {e}")
                sys.exit(1)
            print(f"⏳ PostgreSQL no está listo. Reintentando en {retry_interval}s...")
            time.sleep(retry_interval)
    
    return False

if __name__ == "__main__":
    print("🚀 Esperando a que PostgreSQL esté disponible...")
    wait_for_db()
````

## File: apps/frontend/.env.example
````
# Backend API URL
VITE_API_URL=http://localhost:8000/api

# Otros configs opcionales
# VITE_APP_NAME=GpuChile
# VITE_ENABLE_DEVTOOLS=true
````

## File: apps/frontend/.gitignore
````
# Logs
logs
*.log
npm-debug.log*
yarn-debug.log*
yarn-error.log*
pnpm-debug.log*
lerna-debug.log*

node_modules
dist
dist-ssr
*.local

# Editor directories and files
.vscode/*
!.vscode/extensions.json
.idea
.DS_Store
*.suo
*.ntvs*
*.njsproj
*.sln
*.sw?

# Env files
.env
.env.local
.env.production
````

## File: apps/frontend/Dockerfile
````
# CAMBIO: Usamos 'slim' (Debian) en lugar de 'alpine' para evitar errores de binarios (musl vs glibc)
FROM node:20-slim AS base

# No necesitamos apk add libc6-compat porque Debian ya usa glibc
WORKDIR /app

# Copiar package files
COPY package*.json ./

# Instalar dependencias ignorando conflictos de versiones
RUN npm install --legacy-peer-deps

# Copiar código fuente
COPY . .

# Exponer puerto de desarrollo
EXPOSE 5173

# Comando para desarrollo con hot reload
CMD ["npm", "run", "dev", "--", "--host", "0.0.0.0"]
````

## File: apps/frontend/eslint.config.js
````javascript
import js from '@eslint/js'
import globals from 'globals'
import reactHooks from 'eslint-plugin-react-hooks'
import reactRefresh from 'eslint-plugin-react-refresh'
import tseslint from 'typescript-eslint'
import { defineConfig, globalIgnores } from 'eslint/config'

export default defineConfig([
  globalIgnores(['dist']),
  {
    files: ['**/*.{ts,tsx}'],
    extends: [
      js.configs.recommended,
      tseslint.configs.recommended,
      reactHooks.configs.flat.recommended,
      reactRefresh.configs.vite,
    ],
    languageOptions: {
      ecmaVersion: 2020,
      globals: globals.browser,
    },
  },
])
````

## File: apps/frontend/index.html
````html
<!doctype html>
<html lang="es">
  <head>
    <meta charset="UTF-8" />
    <link rel="icon" type="image/svg+xml" href="/vite.svg" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta name="description" content="E-commerce de GPUs high-performance" />
    <title>GpuChile - GPU Marketplace</title>
  </head>
  <body>
    <div id="root"></div>
    <script type="module" src="/src/main.tsx"></script>
  </body>
</html>
````

## File: apps/frontend/package.json
````json
{
  "name": "gpuchile-frontend",
  "private": true,
  "version": "1.0.0",
  "type": "module",
  "scripts": {
    "dev": "vite --host 0.0.0.0",
    "build": "tsc && vite build",
    "preview": "vite preview --host 0.0.0.0",
    "lint": "eslint . --ext ts,tsx --report-unused-disable-directives --max-warnings 0"
  },
  "dependencies": {
    "react": "^18.3.1",
    "react-dom": "^18.3.1",
    "react-router-dom": "^6.22.0",
    "@tanstack/react-query": "^5.17.19",
    "@tanstack/react-query-devtools": "^5.17.19",
    "axios": "^1.6.5",
    "lucide-react": "^0.309.0",
    "clsx": "^2.1.0",
    "tailwind-merge": "^2.2.0"
  },
  "devDependencies": {
    "@types/react": "^18.3.3",
    "@types/react-dom": "^18.3.0",
    "@vitejs/plugin-react": "^4.3.1",
    "typescript": "^5.5.3",
    "vite": "^5.4.1",
    "eslint": "^8.57.0",
    "@typescript-eslint/eslint-plugin": "^7.13.1",
    "@typescript-eslint/parser": "^7.13.1",
    "eslint-plugin-react-hooks": "^4.6.2",
    "eslint-plugin-react-refresh": "^0.4.7",
    "tailwindcss": "^3.4.1",
    "postcss": "^8.4.33",
    "autoprefixer": "^10.4.17"
  }
}
````

## File: apps/frontend/postcss.config.js
````javascript
export default {
  plugins: {
    tailwindcss: {},
    autoprefixer: {},
  },
}
````

## File: apps/frontend/public/vite.svg
````xml
<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" aria-hidden="true" role="img" class="iconify iconify--logos" width="31.88" height="32" preserveAspectRatio="xMidYMid meet" viewBox="0 0 256 257"><defs><linearGradient id="IconifyId1813088fe1fbc01fb466" x1="-.828%" x2="57.636%" y1="7.652%" y2="78.411%"><stop offset="0%" stop-color="#41D1FF"></stop><stop offset="100%" stop-color="#BD34FE"></stop></linearGradient><linearGradient id="IconifyId1813088fe1fbc01fb467" x1="43.376%" x2="50.316%" y1="2.242%" y2="89.03%"><stop offset="0%" stop-color="#FFEA83"></stop><stop offset="8.333%" stop-color="#FFDD35"></stop><stop offset="100%" stop-color="#FFA800"></stop></linearGradient></defs><path fill="url(#IconifyId1813088fe1fbc01fb466)" d="M255.153 37.938L134.897 252.976c-2.483 4.44-8.862 4.466-11.382.048L.875 37.958c-2.746-4.814 1.371-10.646 6.827-9.67l120.385 21.517a6.537 6.537 0 0 0 2.322-.004l117.867-21.483c5.438-.991 9.574 4.796 6.877 9.62Z"></path><path fill="url(#IconifyId1813088fe1fbc01fb467)" d="M185.432.063L96.44 17.501a3.268 3.268 0 0 0-2.634 3.014l-5.474 92.456a3.268 3.268 0 0 0 3.997 3.378l24.777-5.718c2.318-.535 4.413 1.507 3.936 3.838l-7.361 36.047c-.495 2.426 1.782 4.5 4.151 3.78l15.304-4.649c2.372-.72 4.652 1.36 4.15 3.788l-11.698 56.621c-.732 3.542 3.979 5.473 5.943 2.437l1.313-2.028l72.516-144.72c1.215-2.423-.88-5.186-3.54-4.672l-25.505 4.922c-2.396.462-4.435-1.77-3.759-4.114l16.646-57.705c.677-2.35-1.37-4.583-3.769-4.113Z"></path></svg>
````

## File: apps/frontend/README.md
````markdown
# React + TypeScript + Vite

This template provides a minimal setup to get React working in Vite with HMR and some ESLint rules.

Currently, two official plugins are available:

- [@vitejs/plugin-react](https://github.com/vitejs/vite-plugin-react/blob/main/packages/plugin-react) uses [Babel](https://babeljs.io/) (or [oxc](https://oxc.rs) when used in [rolldown-vite](https://vite.dev/guide/rolldown)) for Fast Refresh
- [@vitejs/plugin-react-swc](https://github.com/vitejs/vite-plugin-react/blob/main/packages/plugin-react-swc) uses [SWC](https://swc.rs/) for Fast Refresh

## React Compiler

The React Compiler is not enabled on this template because of its impact on dev & build performances. To add it, see [this documentation](https://react.dev/learn/react-compiler/installation).

## Expanding the ESLint configuration

If you are developing a production application, we recommend updating the configuration to enable type-aware lint rules:

```js
export default defineConfig([
  globalIgnores(['dist']),
  {
    files: ['**/*.{ts,tsx}'],
    extends: [
      // Other configs...

      // Remove tseslint.configs.recommended and replace with this
      tseslint.configs.recommendedTypeChecked,
      // Alternatively, use this for stricter rules
      tseslint.configs.strictTypeChecked,
      // Optionally, add this for stylistic rules
      tseslint.configs.stylisticTypeChecked,

      // Other configs...
    ],
    languageOptions: {
      parserOptions: {
        project: ['./tsconfig.node.json', './tsconfig.app.json'],
        tsconfigRootDir: import.meta.dirname,
      },
      // other options...
    },
  },
])
```

You can also install [eslint-plugin-react-x](https://github.com/Rel1cx/eslint-react/tree/main/packages/plugins/eslint-plugin-react-x) and [eslint-plugin-react-dom](https://github.com/Rel1cx/eslint-react/tree/main/packages/plugins/eslint-plugin-react-dom) for React-specific lint rules:

```js
// eslint.config.js
import reactX from 'eslint-plugin-react-x'
import reactDom from 'eslint-plugin-react-dom'

export default defineConfig([
  globalIgnores(['dist']),
  {
    files: ['**/*.{ts,tsx}'],
    extends: [
      // Other configs...
      // Enable lint rules for React
      reactX.configs['recommended-typescript'],
      // Enable lint rules for React DOM
      reactDom.configs.recommended,
    ],
    languageOptions: {
      parserOptions: {
        project: ['./tsconfig.node.json', './tsconfig.app.json'],
        tsconfigRootDir: import.meta.dirname,
      },
      // other options...
    },
  },
])
```
````

## File: apps/frontend/src/api/client.ts
````typescript
import axios from 'axios';

const client = axios.create({
  // En producción (K8s), usa el proxy de Nginx (/api)
  // En local (docker-compose), usa variable de entorno
  baseURL: import.meta.env.VITE_API_URL || '/api',
  headers: {
    'Content-Type': 'application/json',
  },
});

export default client;
````

## File: apps/frontend/src/App.css
````css
#root {
  max-width: 1280px;
  margin: 0 auto;
  padding: 2rem;
  text-align: center;
}

.logo {
  height: 6em;
  padding: 1.5em;
  will-change: filter;
  transition: filter 300ms;
}
.logo:hover {
  filter: drop-shadow(0 0 2em #646cffaa);
}
.logo.react:hover {
  filter: drop-shadow(0 0 2em #61dafbaa);
}

@keyframes logo-spin {
  from {
    transform: rotate(0deg);
  }
  to {
    transform: rotate(360deg);
  }
}

@media (prefers-reduced-motion: no-preference) {
  a:nth-of-type(2) .logo {
    animation: logo-spin infinite 20s linear;
  }
}

.card {
  padding: 2em;
}

.read-the-docs {
  color: #888;
}
````

## File: apps/frontend/src/App.tsx
````typescript
import { Routes, Route } from 'react-router-dom';
// 👇 CORRECCIÓN: Apuntar a la carpeta layout
import Navbar from './components/layout/Navbar'; 
import HomePage from './pages/HomePage';
import GPUDetail from './pages/GPUDetail';
import CartPage from './pages/CartPage';
import LoginPage from './pages/LoginPage';
import RegisterPage from './pages/RegisterPage';

function App() {
  return (
    <div className="bg-gray-900 min-h-screen text-white font-sans">
      <Navbar />
      
      <Routes>
        <Route path="/" element={<HomePage />} />
        <Route path="/gpus/:id" element={<GPUDetail />} />
        <Route path="/cart" element={<CartPage />} />
        <Route path="/login" element={<LoginPage />} />
        <Route path="/register" element={<RegisterPage />} />
      </Routes>
    </div>
  );
}

export default App;
````

## File: apps/frontend/src/assets/react.svg
````xml
<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" aria-hidden="true" role="img" class="iconify iconify--logos" width="35.93" height="32" preserveAspectRatio="xMidYMid meet" viewBox="0 0 256 228"><path fill="#00D8FF" d="M210.483 73.824a171.49 171.49 0 0 0-8.24-2.597c.465-1.9.893-3.777 1.273-5.621c6.238-30.281 2.16-54.676-11.769-62.708c-13.355-7.7-35.196.329-57.254 19.526a171.23 171.23 0 0 0-6.375 5.848a155.866 155.866 0 0 0-4.241-3.917C100.759 3.829 77.587-4.822 63.673 3.233C50.33 10.957 46.379 33.89 51.995 62.588a170.974 170.974 0 0 0 1.892 8.48c-3.28.932-6.445 1.924-9.474 2.98C17.309 83.498 0 98.307 0 113.668c0 15.865 18.582 31.778 46.812 41.427a145.52 145.52 0 0 0 6.921 2.165a167.467 167.467 0 0 0-2.01 9.138c-5.354 28.2-1.173 50.591 12.134 58.266c13.744 7.926 36.812-.22 59.273-19.855a145.567 145.567 0 0 0 5.342-4.923a168.064 168.064 0 0 0 6.92 6.314c21.758 18.722 43.246 26.282 56.54 18.586c13.731-7.949 18.194-32.003 12.4-61.268a145.016 145.016 0 0 0-1.535-6.842c1.62-.48 3.21-.974 4.76-1.488c29.348-9.723 48.443-25.443 48.443-41.52c0-15.417-17.868-30.326-45.517-39.844Zm-6.365 70.984c-1.4.463-2.836.91-4.3 1.345c-3.24-10.257-7.612-21.163-12.963-32.432c5.106-11 9.31-21.767 12.459-31.957c2.619.758 5.16 1.557 7.61 2.4c23.69 8.156 38.14 20.213 38.14 29.504c0 9.896-15.606 22.743-40.946 31.14Zm-10.514 20.834c2.562 12.94 2.927 24.64 1.23 33.787c-1.524 8.219-4.59 13.698-8.382 15.893c-8.067 4.67-25.32-1.4-43.927-17.412a156.726 156.726 0 0 1-6.437-5.87c7.214-7.889 14.423-17.06 21.459-27.246c12.376-1.098 24.068-2.894 34.671-5.345a134.17 134.17 0 0 1 1.386 6.193ZM87.276 214.515c-7.882 2.783-14.16 2.863-17.955.675c-8.075-4.657-11.432-22.636-6.853-46.752a156.923 156.923 0 0 1 1.869-8.499c10.486 2.32 22.093 3.988 34.498 4.994c7.084 9.967 14.501 19.128 21.976 27.15a134.668 134.668 0 0 1-4.877 4.492c-9.933 8.682-19.886 14.842-28.658 17.94ZM50.35 144.747c-12.483-4.267-22.792-9.812-29.858-15.863c-6.35-5.437-9.555-10.836-9.555-15.216c0-9.322 13.897-21.212 37.076-29.293c2.813-.98 5.757-1.905 8.812-2.773c3.204 10.42 7.406 21.315 12.477 32.332c-5.137 11.18-9.399 22.249-12.634 32.792a134.718 134.718 0 0 1-6.318-1.979Zm12.378-84.26c-4.811-24.587-1.616-43.134 6.425-47.789c8.564-4.958 27.502 2.111 47.463 19.835a144.318 144.318 0 0 1 3.841 3.545c-7.438 7.987-14.787 17.08-21.808 26.988c-12.04 1.116-23.565 2.908-34.161 5.309a160.342 160.342 0 0 1-1.76-7.887Zm110.427 27.268a347.8 347.8 0 0 0-7.785-12.803c8.168 1.033 15.994 2.404 23.343 4.08c-2.206 7.072-4.956 14.465-8.193 22.045a381.151 381.151 0 0 0-7.365-13.322Zm-45.032-43.861c5.044 5.465 10.096 11.566 15.065 18.186a322.04 322.04 0 0 0-30.257-.006c4.974-6.559 10.069-12.652 15.192-18.18ZM82.802 87.83a323.167 323.167 0 0 0-7.227 13.238c-3.184-7.553-5.909-14.98-8.134-22.152c7.304-1.634 15.093-2.97 23.209-3.984a321.524 321.524 0 0 0-7.848 12.897Zm8.081 65.352c-8.385-.936-16.291-2.203-23.593-3.793c2.26-7.3 5.045-14.885 8.298-22.6a321.187 321.187 0 0 0 7.257 13.246c2.594 4.48 5.28 8.868 8.038 13.147Zm37.542 31.03c-5.184-5.592-10.354-11.779-15.403-18.433c4.902.192 9.899.29 14.978.29c5.218 0 10.376-.117 15.453-.343c-4.985 6.774-10.018 12.97-15.028 18.486Zm52.198-57.817c3.422 7.8 6.306 15.345 8.596 22.52c-7.422 1.694-15.436 3.058-23.88 4.071a382.417 382.417 0 0 0 7.859-13.026a347.403 347.403 0 0 0 7.425-13.565Zm-16.898 8.101a358.557 358.557 0 0 1-12.281 19.815a329.4 329.4 0 0 1-23.444.823c-7.967 0-15.716-.248-23.178-.732a310.202 310.202 0 0 1-12.513-19.846h.001a307.41 307.41 0 0 1-10.923-20.627a310.278 310.278 0 0 1 10.89-20.637l-.001.001a307.318 307.318 0 0 1 12.413-19.761c7.613-.576 15.42-.876 23.31-.876H128c7.926 0 15.743.303 23.354.883a329.357 329.357 0 0 1 12.335 19.695a358.489 358.489 0 0 1 11.036 20.54a329.472 329.472 0 0 1-11 20.722Zm22.56-122.124c8.572 4.944 11.906 24.881 6.52 51.026c-.344 1.668-.73 3.367-1.15 5.09c-10.622-2.452-22.155-4.275-34.23-5.408c-7.034-10.017-14.323-19.124-21.64-27.008a160.789 160.789 0 0 1 5.888-5.4c18.9-16.447 36.564-22.941 44.612-18.3ZM128 90.808c12.625 0 22.86 10.235 22.86 22.86s-10.235 22.86-22.86 22.86s-22.86-10.235-22.86-22.86s10.235-22.86 22.86-22.86Z"></path></svg>
````

## File: apps/frontend/src/components/GPUCard.tsx
````typescript
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
````

## File: apps/frontend/src/components/layout/Layout.tsx
````typescript
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
````

## File: apps/frontend/src/components/layout/Navbar.tsx
````typescript
import React from 'react';
import { Link } from 'react-router-dom';
// 👇 Usamos Iconos SVG directos para evitar errores si no tienes lucide-react instalado
// Si tienes lucide instalado, puedes descomentar la siguiente linea y borrar el objeto Icons:
// import { ShoppingCart, User, Cpu } from 'lucide-react';

// 👇 CONEXIÓN REAL: Importamos desde el contexto que sí existe
import { useCart } from '../../context/CartContext';

// Iconos SVG (Respaldos por si acaso)
const Icons = {
  Cpu: () => <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round" className="h-8 w-8 text-purple-500 transition-all group-hover:drop-shadow-[0_0_8px_rgba(123,44,191,0.8)]"><rect width="16" height="16" x="4" y="4" rx="2"/><rect width="6" height="6" x="9" y="9" rx="1"/><path d="M15 2v2"/><path d="M15 20v2"/><path d="M2 15h2"/><path d="M2 9h2"/><path d="M20 15h2"/><path d="M20 9h2"/><path d="M9 2v2"/><path d="M9 20v2"/></svg>,
  Cart: () => <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round" className="h-5 w-5 text-gray-300 group-hover:text-purple-400 transition-colors"><circle cx="8" cy="21" r="1"/><circle cx="19" cy="21" r="1"/><path d="M2.05 2.05h2l2.66 12.42a2 2 0 0 0 2 1.58h9.78a2 2 0 0 0 1.95-1.57l1.65-7.43H5.12"/></svg>,
  User: () => <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round" className="mr-2 h-4 w-4"><path d="M19 21v-2a4 4 0 0 0-4-4H9a4 4 0 0 0-4 4v2"/><circle cx="12" cy="7" r="4"/></svg>
};

const Navbar = () => {
  // 👇 Usamos 'cartCount' que es la variable que definimos en CartContext.tsx
  const { cartCount } = useCart(); 

  return (
    <nav className="sticky top-0 z-50 w-full bg-gray-900/80 backdrop-blur-md border-b border-white/10">
      <div className="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8">
        <div className="flex h-16 items-center justify-between">
          
          {/* Logo con efecto neon */}
          <Link to="/" className="flex items-center space-x-2 group">
            <Icons.Cpu />
            <span className="text-2xl font-bold">
              <span className="text-white">Gpu</span>
              <span className="text-transparent bg-clip-text bg-gradient-to-r from-purple-400 to-pink-600">Chile</span>
            </span>
          </Link>

          {/* Navigation Links */}
          <div className="hidden md:flex md:items-center md:space-x-8">
            {['GPUs', 'Nosotros', 'Contacto'].map((item) => (
              <Link
                key={item}
                to="/"
                className="text-base font-medium text-gray-300 hover:text-purple-400 transition-colors relative group"
              >
                {item}
                <span className="absolute -bottom-1 left-0 h-0.5 w-0 bg-purple-500 transition-all group-hover:w-full" />
              </Link>
            ))}
          </div>

          {/* Right Side Actions */}
          <div className="flex items-center space-x-4">
            
            {/* Cart Button con glow */}
            <Link to="/cart" className="relative group p-2 hover:bg-gray-800 rounded-full transition-colors">
              <Icons.Cart />
              {cartCount > 0 && (
                <span className="absolute -right-1 -top-1 flex h-5 w-5 items-center justify-center rounded-full bg-purple-600 text-xs font-bold text-white shadow-[0_0_10px_rgba(168,85,247,0.5)] animate-pulse">
                  {cartCount > 9 ? '9+' : cartCount}
                </span>
              )}
            </Link>

            {/* User Button */}
            <Link to="/login">
              <button 
                className="flex items-center border border-purple-500/50 text-purple-400 hover:bg-purple-500/10 hover:shadow-[0_0_15px_rgba(168,85,247,0.3)] transition-all px-4 py-2 rounded-lg font-medium text-sm"
              >
                <Icons.User />
                Ingresar
              </button>
            </Link>
          </div>
        </div>
      </div>
    </nav>
  );
};

export default Navbar;
````

## File: apps/frontend/src/components/ui/Button.tsx
````typescript
import React from 'react';
import { cn } from '@/lib/utils';
import { Loader2 } from 'lucide-react';

export interface ButtonProps extends React.ButtonHTMLAttributes<HTMLButtonElement> {
  variant?: 'primary' | 'secondary' | 'outline' | 'danger' | 'ghost';
  size?: 'sm' | 'md' | 'lg';
  isLoading?: boolean;
  children: React.ReactNode;
}

const Button = React.forwardRef<HTMLButtonElement, ButtonProps>(
  ({ className, variant = 'primary', size = 'md', isLoading, children, disabled, ...props }, ref) => {
    const baseStyles = 'inline-flex items-center justify-center rounded-lg font-medium transition-all focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-offset-2 focus-visible:ring-offset-background disabled:pointer-events-none disabled:opacity-50';
    
    const variants = {
      primary: 'bg-primary text-white hover:bg-primary/90 hover:shadow-neon-sm focus-visible:ring-primary',
      secondary: 'bg-surface text-text-primary hover:bg-surface-hover focus-visible:ring-slate-600',
      outline: 'border-2 border-primary/50 text-primary hover:bg-primary/10 hover:border-primary focus-visible:ring-primary',
      danger: 'bg-accent-red text-white hover:bg-accent-red/90 focus-visible:ring-accent-red',
      ghost: 'hover:bg-surface text-text-secondary hover:text-text-primary focus-visible:ring-slate-600',
    };
    
    const sizes = {
      sm: 'h-9 px-3 text-sm',
      md: 'h-10 px-4 text-base',
      lg: 'h-12 px-6 text-lg',
    };

    return (
      <button
        ref={ref}
        className={cn(baseStyles, variants[variant], sizes[size], className)}
        disabled={disabled || isLoading}
        {...props}
      >
        {isLoading && <Loader2 className="mr-2 h-4 w-4 animate-spin" />}
        {children}
      </button>
    );
  }
);

Button.displayName = 'Button';

export default Button;
````

## File: apps/frontend/src/components/ui/Card.tsx
````typescript
import React from 'react';
import { cn } from '@/lib/utils';

export interface CardProps extends React.HTMLAttributes<HTMLDivElement> {
  children: React.ReactNode;
  hoverable?: boolean;
}

const Card = React.forwardRef<HTMLDivElement, CardProps>(
  ({ className, children, hoverable = false, ...props }, ref) => {
    return (
      <div
        ref={ref}
        className={cn(
          'card-dark overflow-hidden',
          hoverable && 'transition-all duration-300 hover:border-primary/50 hover:shadow-[0_0_20px_rgba(123,44,191,0.5)] hover:-translate-y-1',
          className
        )}
        {...props}
      >
        {children}
      </div>
    );
  }
);

Card.displayName = 'Card';

export const CardHeader = React.forwardRef<HTMLDivElement, React.HTMLAttributes<HTMLDivElement>>(
  ({ className, ...props }, ref) => (
    <div ref={ref} className={cn('flex flex-col space-y-1.5 p-6', className)} {...props} />
  )
);

CardHeader.displayName = 'CardHeader';

export const CardTitle = React.forwardRef<HTMLParagraphElement, React.HTMLAttributes<HTMLHeadingElement>>(
  ({ className, children, ...props }, ref) => (
    <h3 ref={ref} className={cn('text-2xl font-semibold leading-none tracking-tight text-text-primary', className)} {...props}>
      {children}
    </h3>
  )
);

CardTitle.displayName = 'CardTitle';

export const CardDescription = React.forwardRef<HTMLParagraphElement, React.HTMLAttributes<HTMLParagraphElement>>(
  ({ className, ...props }, ref) => (
    <p ref={ref} className={cn('text-sm text-text-secondary', className)} {...props} />
  )
);

CardDescription.displayName = 'CardDescription';

export const CardContent = React.forwardRef<HTMLDivElement, React.HTMLAttributes<HTMLDivElement>>(
  ({ className, ...props }, ref) => (
    <div ref={ref} className={cn('p-6 pt-0', className)} {...props} />
  )
);

CardContent.displayName = 'CardContent';

export const CardFooter = React.forwardRef<HTMLDivElement, React.HTMLAttributes<HTMLDivElement>>(
  ({ className, ...props }, ref) => (
    <div ref={ref} className={cn('flex items-center p-6 pt-0', className)} {...props} />
  )
);

CardFooter.displayName = 'CardFooter';

export default Card;
````

## File: apps/frontend/src/context/CartContext.tsx
````typescript
import { createContext, useContext, useState, useEffect, ReactNode } from 'react';

// --- DEFINICIÓN DE TIPOS (Interfaces) ---

export interface GPU {
  id: number;
  name: string;
  brand: string;
  model: string;
  price: number;
  vram: number;
  cuda_cores: number;
  stock: number;
  image_url: string;
  description?: string;
}

export interface CartItem {
  id: number;
  gpu_id: number;
  quantity: number;
  gpu: GPU; // La GPU anidada que viene del backend
}

interface CartResponse {
  items: CartItem[];
  total: number;
}

interface CartContextType {
  cartItems: CartItem[];
  cartCount: number;
  addToCart: (gpuId: number, quantity?: number) => Promise<boolean>;
  removeFromCart: (itemId: number) => Promise<void>;
  isLoading: boolean;
}

// --- CONTEXTO ---

const CartContext = createContext<CartContextType | undefined>(undefined);

export const useCart = () => {
  const context = useContext(CartContext);
  if (!context) throw new Error('useCart debe usarse dentro de CartProvider');
  return context;
};

// --- PROVIDER ---

interface CartProviderProps {
  children: ReactNode;
}

export const CartProvider = ({ children }: CartProviderProps) => {
  const [cartItems, setCartItems] = useState<CartItem[]>([]);
  const [cartCount, setCartCount] = useState<number>(0);
  const [sessionId, setSessionId] = useState<string>('');
  const [isLoading, setIsLoading] = useState<boolean>(false);
  
  // Usamos import.meta.env para Vite
  const API_URL = import.meta.env.VITE_API_URL || 'http://localhost:8000/api';

  // 1. Generar o Recuperar Session ID
  useEffect(() => {
    let storedSession = localStorage.getItem('gpu_chile_session_id');
    if (!storedSession) {
      storedSession = crypto.randomUUID();
      localStorage.setItem('gpu_chile_session_id', storedSession);
    }
    setSessionId(storedSession);
    fetchCart(storedSession);
  }, []);

  // 2. Obtener Carrito
  const fetchCart = async (sid: string) => {
    if (!sid) return;
    try {
      const response = await fetch(`${API_URL}/cart/`, {
        headers: { 'session-id': sid }
      });
      
      if (response.ok) {
        const data: any = await response.json(); // Usamos any temporalmente para flexibilidad si la respuesta varía
        // El backend devuelve una lista directa o un objeto { items: [] } dependiendo de tu implementación final.
        // Asumimos que el backend devuelve una lista de items o un objeto { items: ... }
        // Ajuste defensivo:
        const items = Array.isArray(data) ? data : (data.items || []);
        
        setCartItems(items);
        const count = items.reduce((acc: number, item: CartItem) => acc + item.quantity, 0);
        setCartCount(count);
      }
    } catch (error) {
      console.error("Error cargando carrito:", error);
    }
  };

  // 3. Agregar al Carrito
  const addToCart = async (gpuId: number, quantity: number = 1): Promise<boolean> => {
    setIsLoading(true);
    try {
      const response = await fetch(`${API_URL}/cart/`, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'session-id': sessionId
        },
        body: JSON.stringify({ gpu_id: gpuId, quantity })
      });

      if (response.ok) {
        await fetchCart(sessionId);
        return true;
      } else {
        const err = await response.json();
        alert(`Error: ${err.detail}`);
        return false;
      }
    } catch (error) {
      console.error("Error agregando al carrito:", error);
      return false;
    } finally {
      setIsLoading(false);
    }
  };

  // 4. Eliminar del Carrito
  const removeFromCart = async (itemId: number) => {
    try {
      await fetch(`${API_URL}/cart/${itemId}`, {
        method: 'DELETE',
        headers: { 'session-id': sessionId }
      });
      await fetchCart(sessionId);
    } catch (error) {
      console.error("Error eliminando item:", error);
    }
  };

  const value: CartContextType = {
    cartItems,
    cartCount,
    addToCart,
    removeFromCart,
    isLoading
  };

  return <CartContext.Provider value={value}>{children}</CartContext.Provider>;
};
````

## File: apps/frontend/src/hooks/useCart.ts
````typescript
/**
 * Hook simplificado para consumir el carrito
 * Re-exporta desde el contexto para mantener compatibilidad
 */
export { useCart } from '@/context/CartContext';
````

## File: apps/frontend/src/index.css
````css
@tailwind base;
@tailwind components;
@tailwind utilities;

/* Variables CSS para tema oscuro */
@layer base {
  * {
    @apply border-slate-700;
  }
  
  body {
    @apply bg-background text-text-primary antialiased;
    font-feature-settings: "rlig" 1, "calt" 1;
  }

  /* Scrollbar oscuro custom */
  ::-webkit-scrollbar {
    width: 10px;
  }

  ::-webkit-scrollbar-track {
    @apply bg-slate-900;
  }

  ::-webkit-scrollbar-thumb {
    @apply bg-slate-700 rounded-full;
  }

  ::-webkit-scrollbar-thumb:hover {
    @apply bg-primary;
  }
}

/* Utilidades custom */
@layer utilities {
  .text-gradient {
    @apply bg-clip-text text-transparent bg-gradient-to-r from-primary to-secondary;
  }

  .glass {
    @apply bg-slate-900/80 backdrop-blur-md border border-white/10;
  }

  .card-dark {
    @apply bg-surface border border-slate-700/50 rounded-lg;
  }

  .glow-border {
    @apply border-2 border-primary/50 shadow-neon-sm;
  }
}

/* Animaciones de entrada */
@keyframes fadeIn {
  from {
    opacity: 0;
    transform: translateY(10px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

.animate-fade-in {
  animation: fadeIn 0.5s ease-out;
}
````

## File: apps/frontend/src/lib/axios.ts
````typescript
import axios from 'axios';

// Base URL desde variable de entorno
const API_BASE_URL = import.meta.env.VITE_API_URL || 'http://localhost:8000/api';

// Instancia de axios configurada
export const api = axios.create({
  baseURL: API_BASE_URL,
  timeout: 10000, // 10 segundos
  headers: {
    'Content-Type': 'application/json',
  },
});

// Request interceptor (agregar token JWT cuando lo implementes)
api.interceptors.request.use(
  (config) => {
    // Obtener token de localStorage si existe
    const token = localStorage.getItem('accessToken');
    if (token) {
      config.headers.Authorization = `Bearer ${token}`;
    }
    return config;
  },
  (error) => {
    return Promise.reject(error);
  }
);

// Response interceptor (manejo de errores global)
api.interceptors.response.use(
  (response) => response,
  (error) => {
    // Manejo de errores comunes
    if (error.response?.status === 401) {
      // Unauthorized - limpiar token y redirigir a login
      localStorage.removeItem('accessToken');
      window.location.href = '/login';
    }
    
    if (error.response?.status === 403) {
      // Forbidden
      console.error('No tienes permisos para esta acción');
    }
    
    if (error.response?.status >= 500) {
      // Server error
      console.error('Error del servidor. Intenta más tarde.');
    }
    
    return Promise.reject(error);
  }
);

export default api;
````

## File: apps/frontend/src/lib/utils.ts
````typescript
import { type ClassValue, clsx } from 'clsx';
import { twMerge } from 'tailwind-merge';

/**
 * Utility para combinar clases de Tailwind condicionalmente
 * Ejemplo: cn('bg-red-500', condition && 'text-white', 'p-4')
 */
export function cn(...inputs: ClassValue[]) {
  return twMerge(clsx(inputs));
}
````

## File: apps/frontend/src/main.tsx
````typescript
import React from 'react';
import ReactDOM from 'react-dom/client';
import { BrowserRouter } from 'react-router-dom';
import { QueryClient, QueryClientProvider } from '@tanstack/react-query';
import { ReactQueryDevtools } from '@tanstack/react-query-devtools';
import { CartProvider } from '@/context/CartContext';
import App from './App';
import './index.css';

// Configuración de React Query
const queryClient = new QueryClient({
  defaultOptions: {
    queries: {
      refetchOnWindowFocus: false,
      retry: 1,
      staleTime: 5 * 60 * 1000, // 5 minutos
    },
  },
});

ReactDOM.createRoot(document.getElementById('root')!).render(
  <React.StrictMode>
    <QueryClientProvider client={queryClient}>
      <BrowserRouter>
        <CartProvider>
          <App />
        </CartProvider>
      </BrowserRouter>
      <ReactQueryDevtools initialIsOpen={false} />
    </QueryClientProvider>
  </React.StrictMode>
);
````

## File: apps/frontend/src/pages/CartPage.tsx
````typescript
import React from 'react';
import { Link } from 'react-router-dom';
import { useCart } from '../context/CartContext';

const Icons = {
  Trash: () => <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><path d="M3 6h18"/><path d="M19 6v14c0 1-1 2-2 2H7c-1 0-2-1-2-2V6"/><path d="M8 6V4c0-1 1-2 2-2h4c1 0 2 1 2 2v2"/></svg>,
  Plus: () => <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><path d="M5 12h14"/><path d="M12 5v14"/></svg>,
  Minus: () => <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><path d="M5 12h14"/></svg>,
  ArrowRight: () => <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><path d="M5 12h14"/><path d="m12 5 7 7-7 7"/></svg>
};

const CartPage = () => {
  const { cartItems, removeFromCart, addToCart, isLoading } = useCart();

  // Calcular total dinámicamente con Tipado seguro
  const total = cartItems.reduce((acc, item) => acc + (item.gpu.price * item.quantity), 0);

  if (cartItems.length === 0) {
    return (
      <div className="min-h-screen bg-gray-900 text-white flex flex-col items-center justify-center p-4">
        <div className="bg-gray-800 p-8 rounded-2xl border border-gray-700 text-center shadow-2xl max-w-md w-full">
          <div className="bg-gray-700/50 w-20 h-20 rounded-full flex items-center justify-center mx-auto mb-6">
            <svg className="w-10 h-10 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M3 3h2l.4 2M7 13h10l4-8H5.4M7 13L5.4 5M7 13l-2.293 2.293c-.63.63-.184 1.707.707 1.707H17m0 0a2 2 0 100 4 2 2 0 000-4zm-8 2a2 2 0 11-4 0 2 2 0 014 0z"></path></svg>
          </div>
          <h2 className="text-2xl font-bold mb-2">Tu carrito está vacío</h2>
          <p className="text-gray-400 mb-8">Parece que aún no has elegido tu próxima GPU.</p>
          <Link to="/" className="block w-full bg-purple-600 hover:bg-purple-500 text-white py-3 rounded-xl font-bold transition-colors text-center">
            Volver al Catálogo
          </Link>
        </div>
      </div>
    );
  }

  return (
    <div className="min-h-screen bg-gray-900 text-white p-4 md:p-8">
      <div className="max-w-7xl mx-auto">
        <h1 className="text-3xl font-bold mb-8 flex items-center gap-3">
          Tu Carrito <span className="text-purple-400">Gamer</span>
          <span className="text-sm bg-gray-800 text-gray-300 px-3 py-1 rounded-full font-normal">
            {cartItems.length} items
          </span>
        </h1>

        <div className="grid grid-cols-1 lg:grid-cols-3 gap-8">
          
          <div className="lg:col-span-2 space-y-4">
            {cartItems.map((item) => (
              <div key={item.id} className="bg-gray-800 border border-gray-700 rounded-xl p-4 flex flex-col sm:flex-row gap-4 items-center shadow-lg transition-all hover:border-purple-500/30">
                
                <div className="w-24 h-24 bg-gray-900 rounded-lg p-2 flex-shrink-0">
                  <img src={item.gpu.image_url} alt={item.gpu.name} className="w-full h-full object-contain" />
                </div>

                <div className="flex-1 text-center sm:text-left">
                  <h3 className="font-bold text-lg text-white">{item.gpu.name}</h3>
                  <p className="text-purple-400 text-sm">{item.gpu.brand}</p>
                  <p className="text-gray-400 text-xs mt-1">VRAM: {item.gpu.vram}GB</p>
                </div>

                <div className="flex items-center gap-3 bg-gray-900 rounded-lg p-1">
                  <button 
                    disabled={isLoading || item.quantity <= 1}
                    onClick={() => addToCart(item.gpu.id, -1)}
                    className="p-2 hover:bg-gray-700 rounded text-gray-300 disabled:opacity-30"
                  >
                    <Icons.Minus />
                  </button>
                  <span className="font-mono w-8 text-center">{item.quantity}</span>
                  <button 
                    disabled={isLoading}
                    onClick={() => addToCart(item.gpu.id, 1)}
                    className="p-2 hover:bg-gray-700 rounded text-white disabled:opacity-30"
                  >
                    <Icons.Plus />
                  </button>
                </div>

                <div className="text-right min-w-[100px]">
                  <div className="font-bold text-xl">${(item.gpu.price * item.quantity).toLocaleString()}</div>
                  {item.quantity > 1 && (
                    <div className="text-xs text-gray-500">${item.gpu.price.toLocaleString()} c/u</div>
                  )}
                </div>

                <button 
                  onClick={() => removeFromCart(item.id)}
                  className="p-2 text-red-400 hover:bg-red-400/10 rounded-full transition-colors"
                  title="Eliminar"
                >
                  <Icons.Trash />
                </button>
              </div>
            ))}
          </div>

          <div className="lg:col-span-1">
            <div className="bg-gray-800 border border-gray-700 rounded-2xl p-6 shadow-2xl sticky top-4">
              <h3 className="text-xl font-bold mb-6 text-white">Resumen del Pedido</h3>
              
              <div className="space-y-3 mb-6">
                <div className="flex justify-between text-gray-400">
                  <span>Subtotal</span>
                  <span>${total.toLocaleString()}</span>
                </div>
                <div className="flex justify-between text-gray-400">
                  <span>Envío</span>
                  <span className="text-green-400">Gratis</span>
                </div>
                <div className="h-px bg-gray-700 my-4" />
                <div className="flex justify-between items-end">
                  <span className="text-lg font-bold">Total</span>
                  <span className="text-3xl font-bold text-transparent bg-clip-text bg-gradient-to-r from-purple-400 to-pink-400">
                    ${total.toLocaleString()}
                  </span>
                </div>
              </div>

              <button className="w-full bg-gradient-to-r from-purple-600 to-pink-600 hover:from-purple-500 hover:to-pink-500 text-white font-bold py-4 rounded-xl shadow-lg transform transition active:scale-95 flex items-center justify-center gap-2">
                Proceder al Pago <Icons.ArrowRight />
              </button>
              
              <p className="text-xs text-center text-gray-500 mt-4">
                🔒 Transacción segura encriptada con tecnología EKS.
              </p>
            </div>
          </div>

        </div>
      </div>
    </div>
  );
};

export default CartPage;
````

## File: apps/frontend/src/pages/GPUDetail.jsx
````javascript
import { useEffect, useState } from 'react';
import { useParams, Link } from 'react-router-dom';
import { useCart } from '../context/CartContext';

const GPUDetail = () => {
  const { id } = useParams();
  const [gpu, setGpu] = useState(null);
  const [loading, setLoading] = useState(true);
  const { addToCart } = useCart();
  const API_URL = import.meta.env.VITE_API_URL || 'http://localhost:8000/api';

  useEffect(() => {
    // Buscar la GPU específica por ID
    fetch(`${API_URL}/gpus/${id}`)
      .then((res) => {
        if (!res.ok) throw new Error("GPU no encontrada");
        return res.json();
      })
      .then((data) => {
        setGpu(data);
        setLoading(false);
      })
      .catch((err) => {
        console.error(err);
        setLoading(false);
      });
  }, [id]);

  if (loading) return <div className="text-white text-center mt-20">Cargando detalles...</div>;
  if (!gpu) return <div className="text-white text-center mt-20">GPU no encontrada 😢</div>;

  return (
    <div className="container mx-auto p-6 mt-10">
      <div className="bg-gray-800 rounded-xl shadow-2xl overflow-hidden border border-gray-700 flex flex-col md:flex-row">
        
        {/* Imagen Gigante */}
        <div className="md:w-1/2 p-8 bg-gray-900 flex items-center justify-center">
          <img 
            src={gpu.image_url} 
            alt={gpu.name} 
            className="max-h-[400px] object-contain hover:scale-110 transition-transform duration-500" 
          />
        </div>

        {/* Información */}
        <div className="md:w-1/2 p-8 flex flex-col justify-center">
          <div className="uppercase tracking-wide text-sm text-purple-400 font-semibold">{gpu.brand} • {gpu.model}</div>
          <h1 className="mt-2 text-4xl font-bold text-white leading-tight">{gpu.name}</h1>
          <p className="mt-4 text-gray-300 text-lg">{gpu.description || "Sin descripción disponible."}</p>
          
          <div className="mt-6 grid grid-cols-2 gap-4">
            <div className="bg-gray-700 p-3 rounded text-center">
              <span className="block text-gray-400 text-xs">VRAM</span>
              <span className="text-white font-bold">{gpu.vram} GB</span>
            </div>
            <div className="bg-gray-700 p-3 rounded text-center">
              <span className="block text-gray-400 text-xs">CUDA Cores</span>
              <span className="text-white font-bold">{gpu.cuda_cores}</span>
            </div>
          </div>

          <div className="mt-8 flex items-center justify-between">
            <span className="text-4xl font-bold text-white">${gpu.price.toLocaleString()}</span>
            <button 
              onClick={() => addToCart(gpu.id)}
              className="bg-purple-600 hover:bg-purple-500 text-white font-bold py-3 px-8 rounded-full shadow-lg transform transition hover:-translate-y-1"
            >
              Agregar al Carrito 🛒
            </button>
          </div>
          
          <Link to="/" className="mt-6 text-gray-400 hover:text-white text-sm">
            ← Volver al catálogo
          </Link>
        </div>
      </div>
    </div>
  );
};

export default GPUDetail;
````

## File: apps/frontend/src/pages/HomePage.tsx
````typescript
import React, { useEffect, useState } from 'react';
import { Link } from 'react-router-dom';
import { useCart, GPU } from '../context/CartContext'; // Importamos la interfaz GPU también

// Iconos (Tipados como Functional Components)
const Icons = {
  Cpu: () => <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><rect width="16" height="16" x="4" y="4" rx="2"/><rect width="6" height="6" x="9" y="9" rx="1"/><path d="M15 2v2"/><path d="M15 20v2"/><path d="M2 15h2"/><path d="M2 9h2"/><path d="M20 15h2"/><path d="M20 9h2"/><path d="M9 2v2"/><path d="M9 20v2"/></svg>,
  Zap: () => <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><polygon points="13 2 3 14 12 14 11 22 21 10 12 10 13 2"/></svg>,
  Cart: () => <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><circle cx="8" cy="21" r="1"/><circle cx="19" cy="21" r="1"/><path d="M2.05 2.05h2l2.66 12.42a2 2 0 0 0 2 1.58h9.78a2 2 0 0 0 1.95-1.57l1.65-7.43H5.12"/></svg>,
  Trending: () => <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><polyline points="23 6 13.5 15.5 8.5 10.5 1 18"/><polyline points="17 6 23 6 23 12"/></svg>
};

const HomePage = () => {
  const [gpus, setGpus] = useState<GPU[]>([]);
  const [loading, setLoading] = useState<boolean>(true);
  const API_URL = import.meta.env.VITE_API_URL || 'http://localhost:8000/api';

  useEffect(() => {
    fetch(`${API_URL}/gpus/`)
      .then(res => res.json())
      .then((data: GPU[]) => {
        setGpus(data);
        setLoading(false);
      })
      .catch(err => {
        console.error(err);
        setLoading(false);
      });
  }, []);

  if (loading) return (
    <div className="flex h-screen items-center justify-center bg-gray-900">
      <div className="text-purple-500 animate-pulse text-xl font-bold">Cargando Sistema...</div>
    </div>
  );

  return (
    <div className="min-h-screen bg-gray-900 text-white p-4 md:p-8 space-y-12">
      
      {/* Hero Section */}
      <div className="relative overflow-hidden rounded-3xl bg-gradient-to-r from-indigo-900 via-purple-900 to-slate-900 px-8 py-16 shadow-2xl border border-purple-500/20">
        <div className="absolute inset-0 bg-[radial-gradient(circle_at_50%_50%,rgba(123,44,191,0.3),transparent_70%)]" />
        <div className="relative z-10 max-w-3xl">
          <h1 className="text-5xl md:text-7xl font-extrabold tracking-tight mb-6 drop-shadow-lg">
            Las Mejores GPUs <br />
            <span className="text-transparent bg-clip-text bg-gradient-to-r from-purple-400 to-pink-400">del Mercado</span>
          </h1>
          <p className="text-xl text-gray-300 mb-8 max-w-xl">
            Potencia tu setup con tecnología de punta. Renderizado, IA y Gaming al máximo nivel.
          </p>
          <button className="bg-purple-600 hover:bg-purple-500 text-white px-8 py-3 rounded-full font-bold shadow-[0_0_20px_rgba(168,85,247,0.5)] transition-all hover:scale-105">
            Explorar Catálogo
          </button>
        </div>
      </div>

      {/* Stats Cards */}
      <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
        {[
          { icon: Icons.Trending, val: gpus.length, label: "Modelos Disponibles", color: "text-blue-400", bg: "bg-blue-400/10" },
          { icon: Icons.Zap, val: gpus.filter(g => g.stock > 0).length, label: "En Stock Inmediato", color: "text-green-400", bg: "bg-green-400/10" },
          { icon: Icons.Cpu, val: new Set(gpus.map(g => g.brand)).size, label: "Marcas Premium", color: "text-pink-400", bg: "bg-pink-400/10" }
        ].map((stat, i) => (
          <div key={i} className="bg-gray-800/50 border border-gray-700 p-6 rounded-2xl flex items-center gap-4 hover:border-purple-500/30 transition-colors">
            <div className={`p-3 rounded-full ${stat.bg} ${stat.color}`}>
              <stat.icon />
            </div>
            <div>
              <div className="text-3xl font-bold">{stat.val}</div>
              <div className="text-gray-400 text-sm">{stat.label}</div>
            </div>
          </div>
        ))}
      </div>

      {/* Grid de Productos */}
      <div>
        <h2 className="text-3xl font-bold mb-8 flex items-center gap-2">
          Catálogo <span className="text-purple-400">Gamer</span>
        </h2>
        
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
          {gpus.map((gpu) => (
            <GPUCard key={gpu.id} gpu={gpu} />
          ))}
        </div>
      </div>
    </div>
  );
};

// Componente Tarjeta Individual
interface GPUCardProps {
  gpu: GPU;
}

const GPUCard = ({ gpu }: GPUCardProps) => {
  const { addToCart } = useCart();
  const [isAdding, setIsAdding] = useState(false);

  const handleAdd = async () => {
    setIsAdding(true);
    await addToCart(gpu.id);
    setTimeout(() => setIsAdding(false), 500);
  };

  return (
    <div className="group bg-gray-800 rounded-xl overflow-hidden border border-gray-700 hover:border-purple-500/50 transition-all duration-300 hover:shadow-[0_0_30px_rgba(168,85,247,0.15)] flex flex-col">
      <div className="relative h-64 bg-gray-900 p-6 flex items-center justify-center overflow-hidden">
        <img 
          src={gpu.image_url} 
          alt={gpu.name} 
          className="max-h-full object-contain transition-transform duration-500 group-hover:scale-110 group-hover:rotate-2"
        />
        <div className="absolute top-3 left-3 bg-gray-900/80 backdrop-blur px-3 py-1 rounded-full text-xs font-bold text-white border border-gray-600">
          {gpu.brand}
        </div>
        {gpu.stock === 0 && (
          <div className="absolute inset-0 bg-black/70 flex items-center justify-center font-bold text-red-500 text-xl backdrop-blur-sm">
            AGOTADO
          </div>
        )}
      </div>

      <div className="p-5 flex-1 flex flex-col">
        <Link to={`/gpus/${gpu.id}`}>
          <h3 className="text-lg font-bold text-white mb-2 line-clamp-2 hover:text-purple-400 transition-colors">
            {gpu.name}
          </h3>
        </Link>
        
        <div className="flex gap-2 mb-4 text-xs font-mono">
          <span className="bg-purple-500/20 text-purple-300 px-2 py-1 rounded">{gpu.vram}GB VRAM</span>
          <span className="bg-blue-500/20 text-blue-300 px-2 py-1 rounded">{gpu.cuda_cores} Cores</span>
        </div>

        <div className="mt-auto pt-4 border-t border-gray-700 flex items-center justify-between">
          <span className="text-2xl font-bold text-white">
            ${gpu.price.toLocaleString()}
          </span>
          
          <button
            onClick={handleAdd}
            disabled={gpu.stock === 0 || isAdding}
            className={`p-3 rounded-lg transition-all ${
              isAdding 
                ? 'bg-green-600 text-white' 
                : 'bg-white text-black hover:bg-purple-400 hover:text-white'
            } disabled:opacity-50 disabled:cursor-not-allowed`}
          >
            {isAdding ? (
              <span className="text-xs font-bold">AGREGADO</span>
            ) : (
              <Icons.Cart />
            )}
          </button>
        </div>
      </div>
    </div>
  );
};

export default HomePage;
````

## File: apps/frontend/src/pages/LoginPage.tsx
````typescript
import React, { useState } from 'react';
import { Link, useNavigate } from 'react-router-dom';

const LoginPage = () => {
  const navigate = useNavigate();
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [loading, setLoading] = useState(false);

  const handleLogin = (e: React.FormEvent) => {
    e.preventDefault();
    setLoading(true);
    
    // Simulación de Login por ahora (MVP)
    setTimeout(() => {
      setLoading(false);
      alert("Login simulado exitoso. (La lógica real de Auth se implementará en la fase Cloud)");
      navigate('/'); // Redirigir al Home
    }, 1500);
  };

  return (
    <div className="min-h-screen bg-gray-900 flex items-center justify-center p-4 relative overflow-hidden">
      {/* Background Decor */}
      <div className="absolute top-[-20%] left-[-10%] w-[500px] h-[500px] bg-purple-600/20 rounded-full blur-[100px]" />
      <div className="absolute bottom-[-20%] right-[-10%] w-[500px] h-[500px] bg-blue-600/20 rounded-full blur-[100px]" />

      <div className="bg-gray-800 border border-gray-700 p-8 rounded-2xl shadow-2xl w-full max-w-md relative z-10">
        <div className="text-center mb-8">
          <h1 className="text-3xl font-bold text-white mb-2">Bienvenido de vuelta</h1>
          <p className="text-gray-400">Ingresa a tu cuenta GpuChile</p>
        </div>

        <form onSubmit={handleLogin} className="space-y-6">
          <div>
            <label className="block text-sm font-medium text-gray-300 mb-2">Email</label>
            <input
              type="email"
              value={email}
              onChange={(e) => setEmail(e.target.value)}
              className="w-full bg-gray-900 border border-gray-600 rounded-lg px-4 py-3 text-white focus:ring-2 focus:ring-purple-500 focus:border-transparent outline-none transition-all"
              placeholder="ejemplo@gpuchile.com"
              required
            />
          </div>

          <div>
            <label className="block text-sm font-medium text-gray-300 mb-2">Contraseña</label>
            <input
              type="password"
              value={password}
              onChange={(e) => setPassword(e.target.value)}
              className="w-full bg-gray-900 border border-gray-600 rounded-lg px-4 py-3 text-white focus:ring-2 focus:ring-purple-500 focus:border-transparent outline-none transition-all"
              placeholder="••••••••"
              required
            />
          </div>

          <button
            type="submit"
            disabled={loading}
            className="w-full bg-gradient-to-r from-purple-600 to-blue-600 hover:from-purple-500 hover:to-blue-500 text-white font-bold py-3 rounded-lg shadow-lg transform transition active:scale-95 disabled:opacity-50 disabled:cursor-not-allowed"
          >
            {loading ? 'Ingresando...' : 'Iniciar Sesión'}
          </button>
        </form>

        <div className="mt-6 text-center text-sm text-gray-400">
          ¿No tienes cuenta?{' '}
          <Link to="/register" className="text-purple-400 hover:text-purple-300 font-semibold">
            Regístrate aquí
          </Link>
        </div>
      </div>
    </div>
  );
};

export default LoginPage;
````

## File: apps/frontend/src/pages/RegisterPage.tsx
````typescript
import React, { useState } from 'react';
import { Link, useNavigate } from 'react-router-dom';

const RegisterPage = () => {
  const navigate = useNavigate();
  const [loading, setLoading] = useState(false);

  const handleRegister = (e: React.FormEvent) => {
    e.preventDefault();
    setLoading(true);
    setTimeout(() => {
      setLoading(false);
      alert("Registro simulado. ¡Bienvenido!");
      navigate('/login');
    }, 1500);
  };

  return (
    <div className="min-h-screen bg-gray-900 flex items-center justify-center p-4 relative overflow-hidden">
      <div className="absolute top-[20%] right-[30%] w-[400px] h-[400px] bg-pink-600/10 rounded-full blur-[100px]" />

      <div className="bg-gray-800 border border-gray-700 p-8 rounded-2xl shadow-2xl w-full max-w-md relative z-10">
        <div className="text-center mb-8">
          <h1 className="text-3xl font-bold text-white mb-2">Crear Cuenta</h1>
          <p className="text-gray-400">Únete a la comunidad Gamer</p>
        </div>

        <form onSubmit={handleRegister} className="space-y-5">
          <div className="grid grid-cols-2 gap-4">
            <input type="text" placeholder="Nombre" className="bg-gray-900 border border-gray-600 rounded-lg px-4 py-3 text-white focus:ring-purple-500 outline-none" required />
            <input type="text" placeholder="Apellido" className="bg-gray-900 border border-gray-600 rounded-lg px-4 py-3 text-white focus:ring-purple-500 outline-none" required />
          </div>
          
          <input type="email" placeholder="Email" className="w-full bg-gray-900 border border-gray-600 rounded-lg px-4 py-3 text-white focus:ring-purple-500 outline-none" required />
          <input type="password" placeholder="Contraseña" className="w-full bg-gray-900 border border-gray-600 rounded-lg px-4 py-3 text-white focus:ring-purple-500 outline-none" required />
          <input type="password" placeholder="Confirmar Contraseña" className="w-full bg-gray-900 border border-gray-600 rounded-lg px-4 py-3 text-white focus:ring-purple-500 outline-none" required />

          <button
            type="submit"
            disabled={loading}
            className="w-full bg-gradient-to-r from-pink-600 to-purple-600 hover:from-pink-500 hover:to-purple-500 text-white font-bold py-3 rounded-lg shadow-lg transform transition active:scale-95 disabled:opacity-50"
          >
            {loading ? 'Creando cuenta...' : 'Registrarse'}
          </button>
        </form>

        <div className="mt-6 text-center text-sm text-gray-400">
          ¿Ya tienes cuenta?{' '}
          <Link to="/login" className="text-pink-400 hover:text-pink-300 font-semibold">
            Ingresa aquí
          </Link>
        </div>
      </div>
    </div>
  );
};

export default RegisterPage;
````

## File: apps/frontend/src/services/cart.service.ts
````typescript
import { api } from '@/lib/axios';
import type { AxiosResponse } from 'axios';

/**
 * Tipos para el carrito
 */
export interface CartItemResponse {
  id: number;
  gpu_id: number;
  quantity: number;
  gpu: {
    id: number;
    name: string;
    brand: string;
    model: string;
    price: number;
    image_url: string | null;
    stock: number;
  };
}

export interface CartResponse {
  items: CartItemResponse[];
  total: number;
}

export interface AddToCartRequest {
  gpu_id: number;
  quantity: number;
}

/**
 * Servicio para operaciones del carrito
 * IMPORTANTE: Todas las requests deben incluir el header session_id
 */
export const cartService = {
  /**
   * Obtener el carrito actual
   */
  async getCart(sessionId: string): Promise<CartResponse> {
    const response: AxiosResponse<CartResponse> = await api.get('/cart', {
      headers: { session_id: sessionId },
    });
    return response.data;
  },

  /**
   * Agregar item al carrito
   */
  async addToCart(sessionId: string, data: AddToCartRequest): Promise<CartItemResponse> {
    const response: AxiosResponse<CartItemResponse> = await api.post('/cart', data, {
      headers: { session_id: sessionId },
    });
    return response.data;
  },

  /**
   * Actualizar cantidad de un item
   */
  async updateCartItem(
    sessionId: string,
    itemId: number,
    quantity: number
  ): Promise<CartItemResponse> {
    const response: AxiosResponse<CartItemResponse> = await api.put(
      `/cart/${itemId}`,
      { quantity },
      { headers: { session_id: sessionId } }
    );
    return response.data;
  },

  /**
   * Eliminar item del carrito
   */
  async removeFromCart(sessionId: string, itemId: number): Promise<void> {
    await api.delete(`/cart/${itemId}`, {
      headers: { session_id: sessionId },
    });
  },

  /**
   * Limpiar carrito completo
   */
  async clearCart(sessionId: string): Promise<void> {
    await api.delete('/cart', {
      headers: { session_id: sessionId },
    });
  },
};

export default cartService;
````

## File: apps/frontend/src/services/gpu.service.ts
````typescript
import { api } from '@/lib/axios';
import type { GPU, GPUQueryParams } from '@/types/gpu';
import type { AxiosResponse } from 'axios';

/**
 * Servicio para operaciones CRUD de GPUs
 */
export const gpuService = {
  /**
   * Obtener lista de GPUs con filtros opcionales
   */
  async getGpus(params?: GPUQueryParams): Promise<GPU[]> {
    const response: AxiosResponse<GPU[]> = await api.get('/gpus', { params });
    return response.data;
  },

  /**
   * Obtener GPU por ID
   */
  async getGpuById(id: number): Promise<GPU> {
    const response: AxiosResponse<GPU> = await api.get(`/gpus/${id}`);
    return response.data;
  },

  /**
   * Buscar GPUs por brand
   */
  async getGpusByBrand(brand: string): Promise<GPU[]> {
    const response: AxiosResponse<GPU[]> = await api.get('/gpus', {
      params: { brand },
    });
    return response.data;
  },
};

export default gpuService;
````

## File: apps/frontend/src/types/api.ts
````typescript
/**
 * Respuestas genéricas de API
 */

export interface ApiResponse<T> {
  data: T;
  message?: string;
}

export interface ApiError {
  detail: string;
  status?: number;
}

export interface PaginatedResponse<T> {
  items: T[];
  total: number;
  skip: number;
  limit: number;
}

/**
 * Auth types
 */
export interface User {
  id: number;
  email: string;
  username: string;
  role: 'admin' | 'customer';
  created_at: string;
}

export interface LoginCredentials {
  username: string;
  password: string;
}

export interface AuthResponse {
  access_token: string;
  token_type: string;
  user: User;
}

/**
 * Cart types
 */
export interface CartItem {
  id: number;
  gpu_id: number;
  quantity: number;
  gpu: {
    id: number;
    name: string;
    brand: string;
    model: string;
    price: number;
    image_url: string | null;
  };
}

export interface CartResponse {
  items: CartItem[];
  total: number;
}
````

## File: apps/frontend/src/types/types.ts
````typescript
export interface GPU {
  id: number;
  model: string;
  brand: string;
  series?: string;
  vram: number;
  price: number;
  stock: number;
  image_url?: string;
  thumbnail_url?: string;
  is_featured: boolean;
}
````

## File: apps/frontend/tailwind.config.js
````javascript
/** @type {import('tailwindcss').Config} */
export default {
  content: [
    "./index.html",
    "./src/**/*.{js,ts,jsx,tsx}",
  ],
  theme: {
    extend: {
      colors: {
        // Dark Background Palette
        background: '#0f172a', // Slate 900 - Base oscuro
        surface: '#1e293b',    // Slate 800 - Cards
        'surface-hover': '#334155', // Slate 700 - Hover state
        
        // Purple Neon Palette (Primary)
        primary: {
          50: '#faf5ff',
          100: '#f3e8ff',
          200: '#e9d5ff',
          300: '#d8b4fe',
          400: '#c084fc',
          500: '#a855f7',
          600: '#9333ea',
          700: '#7e22ce',
          800: '#6b21a8',
          900: '#581c87',
          DEFAULT: '#7B2CBF', // Violeta principal
        },
        secondary: {
          DEFAULT: '#C77DFF', // Lila brillante
          light: '#E0AAFF',
        },
        
        // Text Colors
        'text-primary': '#f1f5f9',   // Slate 100 - Texto principal
        'text-secondary': '#94a3b8', // Slate 400 - Texto secundario
        'text-muted': '#64748b',     // Slate 500 - Texto terciario
        
        // Accent Colors
        accent: {
          purple: '#9D4EDD',
          cyan: '#06B6D4',
          green: '#10B981',
          red: '#EF4444',
        },
      },
      fontFamily: {
        sans: ['Inter', 'system-ui', 'sans-serif'],
      },
      boxShadow: {
        'neon': '0 0 20px rgba(123, 44, 191, 0.5)',
        'neon-sm': '0 0 10px rgba(123, 44, 191, 0.3)',
        'neon-lg': '0 0 30px rgba(123, 44, 191, 0.6)',
      },
      animation: {
        'pulse-slow': 'pulse 3s cubic-bezier(0.4, 0, 0.6, 1) infinite',
        'glow': 'glow 2s ease-in-out infinite alternate',
      },
      keyframes: {
        glow: {
          '0%': { boxShadow: '0 0 5px rgba(123, 44, 191, 0.2)' },
          '100%': { boxShadow: '0 0 20px rgba(123, 44, 191, 0.5)' },
        },
      },
    },
  },
  plugins: [],
}
````

## File: apps/frontend/tsconfig.app.json
````json
{
  "compilerOptions": {
    "tsBuildInfoFile": "./node_modules/.tmp/tsconfig.app.tsbuildinfo",
    "target": "ES2022",
    "useDefineForClassFields": true,
    "lib": ["ES2022", "DOM", "DOM.Iterable"],
    "module": "ESNext",
    "types": ["vite/client"],
    "skipLibCheck": true,

    /* Bundler mode */
    "moduleResolution": "bundler",
    "allowImportingTsExtensions": true,
    "verbatimModuleSyntax": true,
    "moduleDetection": "force",
    "noEmit": true,
    "jsx": "react-jsx",

    /* Linting */
    "strict": true,
    "noUnusedLocals": true,
    "noUnusedParameters": true,
    "erasableSyntaxOnly": true,
    "noFallthroughCasesInSwitch": true,
    "noUncheckedSideEffectImports": true
  },
  "include": ["src"]
}
````

## File: apps/frontend/tsconfig.json
````json
{
  "compilerOptions": {
    "target": "ES2020",
    "useDefineForClassFields": true,
    "lib": ["ES2020", "DOM", "DOM.Iterable"],
    "module": "ESNext",
    "skipLibCheck": true,

    /* Bundler mode */
    "moduleResolution": "bundler",
    "allowImportingTsExtensions": true,
    "resolveJsonModule": true,
    "isolatedModules": true,
    "noEmit": true,
    "jsx": "react-jsx",

    /* Linting */
    "strict": true,
    "noUnusedLocals": true,
    "noUnusedParameters": true,
    "noFallthroughCasesInSwitch": true,

    /* Path alias */
    "baseUrl": ".",
    "paths": {
      "@/*": ["./src/*"]
    }
  },
  "include": ["src"],
  "references": [{ "path": "./tsconfig.node.json" }]
}
````

## File: apps/frontend/tsconfig.node.json
````json
{
  "compilerOptions": {
    "composite": true,
    "skipLibCheck": true,
    "module": "ESNext",
    "moduleResolution": "bundler",
    "allowSyntheticDefaultImports": true,
    "strict": true
  },
  "include": ["vite.config.ts"]
}
````

## File: apps/frontend/vite.config.ts
````typescript
import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'
import path from 'path'

// https://vitejs.dev/config/
export default defineConfig({
  plugins: [react()],
  resolve: {
    alias: {
      '@': path.resolve(__dirname, './src'),
    },
  },
  server: {
    host: '0.0.0.0', // Crucial para Docker
    port: 5173,
    watch: {
      usePolling: true, // Necesario para hot reload en Docker
    },
  },
})
````

## File: docker-compose.yml
````yaml
version: '3.9'

services:
  # PostgreSQL Database
  db:
    image: postgres:15-alpine
    container_name: gpuchile_postgres
    restart: unless-stopped
    environment:
      POSTGRES_USER: ${POSTGRES_USER:-postgres}
      POSTGRES_PASSWORD: ${POSTGRES_PASSWORD:-postgres123}
      POSTGRES_DB: ${POSTGRES_DB:-gpuchile}
      PGDATA: /var/lib/postgresql/data/pgdata
    ports:
      - "5435:5432" # Mapeado al 5435 para evitar conflictos locales
    volumes:
      - postgres_data:/var/lib/postgresql/data
    networks:
      - gpuchile_network
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U ${POSTGRES_USER:-postgres}"]
      interval: 5s
      timeout: 5s
      retries: 5

  # Redis Cache
  redis:
    image: redis:7-alpine
    container_name: gpuchile_redis
    restart: unless-stopped
    command: redis-server --requirepass ${REDIS_PASSWORD:-redis123}
    ports:
      - "6380:6379" # Mapeado al 6380 para evitar conflictos locales
    volumes:
      - redis_data:/data
    networks:
      - gpuchile_network
    healthcheck:
      test: ["CMD", "redis-cli", "--raw", "incr", "ping"]
      interval: 5s
      timeout: 3s
      retries: 5

  # Backend API (FastAPI)
  backend:
    build:
      context: ./apps/backend
      dockerfile: Dockerfile
    container_name: gpuchile_backend
    restart: unless-stopped
    depends_on:
      db:
        condition: service_healthy
      redis:
        condition: service_healthy
    environment:
      # Database
      DATABASE_URL: postgresql://${POSTGRES_USER:-postgres}:${POSTGRES_PASSWORD:-postgres123}@db:5432/${POSTGRES_DB:-gpuchile}
      
      # Redis (CORRECCIÓN IMPORTANTE: Creamos la URL completa aquí)
      REDIS_URL: redis://:${REDIS_PASSWORD:-redis123}@redis:6379/0
      
      # Security
      SECRET_KEY: ${SECRET_KEY}
      ALGORITHM: HS256
      ACCESS_TOKEN_EXPIRE_MINUTES: 30
      
      # AWS S3 (CORRECCIÓN: Agregadas variables que faltaban)
      S3_BUCKET_NAME: ${S3_BUCKET_NAME}
      AWS_REGION: ${AWS_REGION}
      AWS_ACCESS_KEY_ID: ${AWS_ACCESS_KEY_ID}
      AWS_SECRET_ACCESS_KEY: ${AWS_SECRET_ACCESS_KEY}
      
      # CORS
      BACKEND_CORS_ORIGINS: '["http://localhost:5173","http://localhost:3000","http://frontend:5173"]'
      
      # Environment
      ENVIRONMENT: development
    ports:
      - "8000:8000"
    volumes:
      - ./apps/backend:/app
      - backend_cache:/app/.cache
    networks:
      - gpuchile_network
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost:8000/health"]
      interval: 10s
      timeout: 5s
      retries: 3
      start_period: 40s

  # Frontend (React + Vite)
  frontend:
    build:
      context: ./apps/frontend
      dockerfile: Dockerfile
    container_name: gpuchile_frontend
    restart: unless-stopped
    depends_on:
      - backend
    environment:
      VITE_API_URL: http://localhost:8000/api
    ports:
      - "5173:5173"
    volumes:
      - ./apps/frontend:/app
      - /app/node_modules # Prevent overwriting node_modules
    networks:
      - gpuchile_network
    stdin_open: true
    tty: true

# Networks
networks:
  gpuchile_network:
    driver: bridge
    name: gpuchile_network

# Volumes (Persistencia de datos)
volumes:
  postgres_data:
    driver: local
    name: gpuchile_postgres_data
  redis_data:
    driver: local
    name: gpuchile_redis_data
  backend_cache:
    driver: local
    name: gpuchile_backend_cache
````

## File: helm/backend/Chart.yaml
````yaml
apiVersion: v2
name: gpuchile-backend
description: FastAPI Backend for GpuChile E-commerce
type: application
version: 1.0.0
appVersion: "1.0.0"
maintainers:
  - name: Nicolas Nunez
    email: nicolasnunezalvarez@gmail.com
````

## File: helm/backend/templates/_helpers.tpl
````
{{/*
Expand the name of the chart.
*/}}
{{- define "gpuchile-backend.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "gpuchile-backend.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "gpuchile-backend.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}
````

## File: helm/backend/templates/external-secret.yaml
````yaml
{{- if .Values.externalSecrets.enabled }}
apiVersion: external-secrets.io/v1beta1
kind: ExternalSecret
metadata:
  name: {{ include "gpuchile-backend.fullname" . }}-external-secret
spec:
  refreshInterval: {{ .Values.externalSecrets.refreshInterval }}
  secretStoreRef:
    name: {{ .Values.externalSecrets.secretStoreName }}
    kind: SecretStore
  target:
    name: {{ .Values.externalSecrets.target.name }}
    creationPolicy: Owner
  data:
  {{- range .Values.externalSecrets.data }}
  - secretKey: {{ .secretKey }}
    remoteRef:
      key: {{ .remoteRef.key }}
      {{- if .remoteRef.property }}
      property: {{ .remoteRef.property }}
      {{- end }}
  {{- end }}
{{- end }}
````

## File: helm/backend/templates/hpa.yaml
````yaml
{{- if .Values.autoscaling.enabled }}
apiVersion: autoscaling/v2
kind: HorizontalPodAutoscaler
metadata:
  name: {{ include "gpuchile-backend.fullname" . }}
  labels:
    app: {{ include "gpuchile-backend.name" . }}
spec:
  scaleTargetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: {{ include "gpuchile-backend.fullname" . }}
  minReplicas: {{ .Values.autoscaling.minReplicas }}
  maxReplicas: {{ .Values.autoscaling.maxReplicas }}
  metrics:
  - type: Resource
    resource:
      name: cpu
      target:
        type: Utilization
        averageUtilization: {{ .Values.autoscaling.targetCPUUtilizationPercentage }}
{{- end }}
````

## File: helm/backend/templates/ingress.yaml
````yaml
{{- if .Values.ingress.enabled }}
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: {{ include "gpuchile-backend.fullname" . }}
  annotations:
    {{- toYaml .Values.ingress.annotations | nindent 4 }}
spec:
  ingressClassName: {{ .Values.ingress.className }}
  {{- if .Values.ingress.tls }}
  tls:
    {{- range .Values.ingress.tls }}
    - hosts:
        {{- range .hosts }}
        - {{ . | quote }}
        {{- end }}
      secretName: {{ .secretName }}
    {{- end }}
  {{- end }}
  rules:
    {{- range .Values.ingress.hosts }}
    - host: {{ .host | quote }}
      http:
        paths:
          {{- range .paths }}
          - path: {{ .path }}
            pathType: {{ .pathType }}
            backend:
              service:
                name: {{ include "gpuchile-backend.fullname" $ }}
                port:
                  number: {{ $.Values.service.port }}
          {{- end }}
    {{- end }}
{{- end }}
````

## File: helm/backend/templates/service.yaml
````yaml
apiVersion: v1
kind: Service
metadata:
  name: {{ include "gpuchile-backend.fullname" . }}
  labels:
    app: {{ include "gpuchile-backend.name" . }}
  {{- with .Values.service.annotations }}
  annotations:
    {{- toYaml . | nindent 4 }}
  {{- end }}
spec:
  type: {{ .Values.service.type }}
  ports:
    - port: {{ .Values.service.port }}
      targetPort: {{ .Values.service.targetPort }}
      protocol: TCP
      name: http
  selector:
    app: {{ include "gpuchile-backend.name" . }}
````

## File: helm/backend/values.yaml
````yaml
# ============================================
# CONFIGURACIÓN DEL BACKEND - GPUCHILE
# ============================================

replicaCount: 1  # HPA controlará esto

image:
  repository: 380002980493.dkr.ecr.us-east-1.amazonaws.com/gpuchile-backend
  pullPolicy: IfNotPresent
  tag: "latest"

# Recursos Minimal (Optimizado para costos)
resources:
  limits:
    cpu: 500m
    memory: 768Mi
  requests:
    cpu: 250m
    memory: 512Mi

# Autoscaling (1-3 réplicas según carga)
autoscaling:
  enabled: true
  minReplicas: 1
  maxReplicas: 3
  targetCPUUtilizationPercentage: 70

# Health Checks
livenessProbe:
  httpGet:
    path: /health
    port: 8000
  initialDelaySeconds: 30
  periodSeconds: 10
  timeoutSeconds: 5
  failureThreshold: 3

readinessProbe:
  httpGet:
    path: /health
    port: 8000
  initialDelaySeconds: 10
  periodSeconds: 5
  timeoutSeconds: 3
  failureThreshold: 2

# Service Account (para IRSA - Acceso a S3/Secrets Manager)
serviceAccount:
  create: true
  annotations:
    eks.amazonaws.com/role-arn: "PLACEHOLDER_ROLE_ARN"  # Se reemplaza después
  name: gpuchile-backend-sa

# Networking
service:
  type: LoadBalancer  # Opción simple, cambia a ClusterIP si usas Ingress
  port: 80
  targetPort: 8000
  annotations:
    service.beta.kubernetes.io/aws-load-balancer-type: "nlb"

# Ingress (Descomentado cuando tengas dominio + cert-manager)
ingress:
  enabled: false  # Cambia a true cuando uses dominio custom
  className: nginx
  annotations:
    cert-manager.io/cluster-issuer: "letsencrypt-prod"
  hosts:
    - host: api.gpuchile.com
      paths:
        - path: /
          pathType: Prefix
  tls:
    - secretName: api-gpuchile-tls
      hosts:
        - api.gpuchile.com

# External Secrets (Sincroniza credenciales de AWS Secrets Manager)
externalSecrets:
  enabled: true
  secretStoreName: aws-secrets-store
  refreshInterval: 1h
  target:
    name: backend-secrets
  data:
    - secretKey: DATABASE_URL
      remoteRef:
        key: gpuchile/dev/db
        property: url
    - secretKey: REDIS_URL
      remoteRef:
        key: gpuchile/dev/redis
        property: url
    - secretKey: JWT_SECRET
      remoteRef:
        key: gpuchile/dev/jwt
        property: secret

# Variables de Entorno (No sensibles)
env:
  - name: ENVIRONMENT
    value: "production"
  - name: AWS_REGION
    value: "us-east-1"
  - name: S3_BUCKET
    value: "gpuchile-images-dev-nicolas-2026"
  - name: LOG_LEVEL
    value: "INFO"
````

## File: helm/frontend/Chart.yaml
````yaml
apiVersion: v2
name: gpuchile-frontend
description: React Frontend for GpuChile E-commerce
type: application
version: 1.0.0
appVersion: "1.0.0"
maintainers:
  - name: Nicolas Nunez
    email: nicolasnunezalvarez05@gmail.com
````

## File: helm/frontend/nginx.conf
````ini
server {
    listen 80;
    server_name _;
    root /usr/share/nginx/html;
    index index.html;

    # Gzip compression (Performance boost)
    gzip on;
    gzip_vary on;
    gzip_min_length 1024;
    gzip_types text/css text/javascript application/javascript application/json image/svg+xml;

    # Security headers
    add_header X-Frame-Options "SAMEORIGIN" always;
    add_header X-Content-Type-Options "nosniff" always;
    add_header X-XSS-Protection "1; mode=block" always;

    # Cache static assets aggressively
    location ~* \.(js|css|png|jpg|jpeg|gif|ico|svg|woff|woff2|ttf|eot)$ {
        expires 1y;
        add_header Cache-Control "public, immutable";
    }

    # ✅ PROXY REVERSO AL BACKEND (La magia está aquí)
    # K8s DNS: http://<service-name>.<namespace>.svc.cluster.local:<port>
    location /api/ {
        # ⚠️ FIX: Quita el /api/ del final del proxy_pass
        # Si pones /api/, Nginx concatena y queda /api/api/gpus
        proxy_pass http://gpuchile-backend.default.svc.cluster.local:8000;
        
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
        
        # Timeouts (para requests lentos)
        proxy_connect_timeout 60s;
        proxy_send_timeout 60s;
        proxy_read_timeout 60s;
    }

    # React Router: Todas las rutas apuntan a index.html
    location / {
        try_files $uri $uri/ /index.html;
    }

    # Health check endpoint (para K8s probes)
    location /health {
        access_log off;
        return 200 "healthy\n";
        add_header Content-Type text/plain;
    }
}
````

## File: helm/frontend/templates/_helpers.tpl
````
{{/*
Expand the name of the chart.
*/}}
{{- define "gpuchile-frontend.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
*/}}
{{- define "gpuchile-frontend.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "gpuchile-frontend.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}
````

## File: helm/frontend/templates/configmap.yaml
````yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ include "gpuchile-frontend.fullname" . }}-nginx-config
  labels:
    app: {{ include "gpuchile-frontend.name" . }}
data:
  default.conf: |
{{ .Files.Get "nginx.conf" | indent 4 }}
````

## File: helm/frontend/templates/deployment.yaml
````yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: {{ include "gpuchile-frontend.fullname" . }}
  labels:
    app: {{ include "gpuchile-frontend.name" . }}
    version: {{ .Chart.AppVersion }}
spec:
  replicas: {{ .Values.replicaCount }}
  selector:
    matchLabels:
      app: {{ include "gpuchile-frontend.name" . }}
  template:
    metadata:
      labels:
        app: {{ include "gpuchile-frontend.name" . }}
        version: {{ .Chart.AppVersion }}
    spec:
      containers:
      - name: frontend
        image: "{{ .Values.image.repository }}:{{ .Values.image.tag }}"
        imagePullPolicy: {{ .Values.image.pullPolicy }}
        ports:
        - name: http
          containerPort: 80
          protocol: TCP
        
        # Mount custom nginx.conf
        volumeMounts:
        - name: nginx-config
          mountPath: /etc/nginx/conf.d
          readOnly: true
        
        # Health Checks
        livenessProbe:
          {{- toYaml .Values.livenessProbe | nindent 10 }}
        readinessProbe:
          {{- toYaml .Values.readinessProbe | nindent 10 }}
        
        # Resources
        resources:
          {{- toYaml .Values.resources | nindent 10 }}
      
      volumes:
      - name: nginx-config
        configMap:
          name: {{ include "gpuchile-frontend.fullname" . }}-nginx-config
````

## File: helm/frontend/templates/ingress.yaml
````yaml
{{- if .Values.ingress.enabled }}
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: {{ include "gpuchile-frontend.fullname" . }}
  annotations:
    {{- toYaml .Values.ingress.annotations | nindent 4 }}
spec:
  ingressClassName: {{ .Values.ingress.className }}
  {{- if .Values.ingress.tls }}
  tls:
    {{- range .Values.ingress.tls }}
    - hosts:
        {{- range .hosts }}
        - {{ . | quote }}
        {{- end }}
      secretName: {{ .secretName }}
    {{- end }}
  {{- end }}
  rules:
    {{- range .Values.ingress.hosts }}
    - host: {{ .host | quote }}
      http:
        paths:
          {{- range .paths }}
          - path: {{ .path }}
            pathType: {{ .pathType }}
            backend:
              service:
                name: {{ include "gpuchile-frontend.fullname" $ }}
                port:
                  number: {{ $.Values.service.port }}
          {{- end }}
    {{- end }}
{{- end }}
````

## File: helm/frontend/templates/service.yaml
````yaml
apiVersion: v1
kind: Service
metadata:
  name: {{ include "gpuchile-frontend.fullname" . }}
  labels:
    app: {{ include "gpuchile-frontend.name" . }}
  {{- with .Values.service.annotations }}
  annotations:
    {{- toYaml . | nindent 4 }}
  {{- end }}
spec:
  type: {{ .Values.service.type }}
  ports:
    - port: {{ .Values.service.port }}
      targetPort: {{ .Values.service.targetPort }}
      protocol: TCP
      name: http
  selector:
    app: {{ include "gpuchile-frontend.name" . }}
````

## File: helm/frontend/values.yaml
````yaml
# ============================================
# CONFIGURACIÓN DEL FRONTEND - GPUCHILE
# ============================================

replicaCount: 2  # Dos réplicas para alta disponibilidad

image:
  repository: 380002980493.dkr.ecr.us-east-1.amazonaws.com/gpuchile-frontend
  pullPolicy: IfNotPresent
  tag: "latest"

# Recursos (Frontend estático en Nginx es super ligero)
resources:
  limits:
    cpu: 200m
    memory: 256Mi
  requests:
    cpu: 100m
    memory: 128Mi

# Health Checks (Nginx responde en /)
livenessProbe:
  httpGet:
    path: /healt
    port: 80
  initialDelaySeconds: 10
  periodSeconds: 10

readinessProbe:
  httpGet:
    path: /healt
    port: 80
  initialDelaySeconds: 5
  periodSeconds: 5

# Networking
service:
  type: LoadBalancer  # Cambia a ClusterIP si usas Ingress
  port: 80
  targetPort: 80
  annotations:
    service.beta.kubernetes.io/aws-load-balancer-type: "nlb"

# Ingress (Descomentado cuando tengas dominio)
ingress:
  enabled: false  # Cambia a true cuando uses dominio custom
  className: nginx
  annotations:
    cert-manager.io/cluster-issuer: "letsencrypt-prod"
  hosts:
    - host: gpuchile.com
      paths:
        - path: /
          pathType: Prefix
  tls:
    - secretName: gpuchile-tls
      hosts:
        - gpuchile.com

# Variables de entorno inyectadas en el build (para Vite)
#env:
  #VITE_API_URL: "http://BACKEND_LOAD_BALANCER_URL/api"  # ⚠️ Actualizar después del deploy del backend
````

## File: kubernetes/external-secrets/namespace.yaml
````yaml
apiVersion: v1
kind: Namespace
metadata:
  name: external-secrets
````

## File: kubernetes/redis/deployment.yaml
````yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: redis
  namespace: default
spec:
  replicas: 1
  selector:
    matchLabels:
      app: redis
  template:
    metadata:
      labels:
        app: redis
    spec:
      containers:
      - name: redis
        image: redis:7-alpine
        ports:
        - containerPort: 6379
        resources:
          limits:
            cpu: 200m
            memory: 256Mi
          requests:
            cpu: 100m
            memory: 128Mi
---
apiVersion: v1
kind: Service
metadata:
  name: redis-service
  namespace: default
spec:
  type: ClusterIP
  ports:
  - port: 6379
    targetPort: 6379
  selector:
    app: redis
````

## File: kubernetes/redis/redis.yaml
````yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: redis
  namespace: default
spec:
  replicas: 1
  selector:
    matchLabels:
      app: redis
  template:
    metadata:
      labels:
        app: redis
    spec:
      containers:
      - name: redis
        image: redis:7-alpine
        ports:
        - containerPort: 6379
        resources:
          limits:
            cpu: 200m
            memory: 256Mi
          requests:
            cpu: 100m
            memory: 128Mi
        livenessProbe:
          tcpSocket:
            port: 6379
          initialDelaySeconds: 10
          periodSeconds: 10
        readinessProbe:
          exec:
            command:
            - redis-cli
            - ping
          initialDelaySeconds: 5
          periodSeconds: 5
---
apiVersion: v1
kind: Service
metadata:
  name: redis-service
  namespace: default
spec:
  type: ClusterIP
  ports:
  - port: 6379
    targetPort: 6379
  selector:
    app: redis
````

## File: lambda/image-resizer/requirements.txt
````
Pillow>=10.0.0
boto3>=1.26.0
````

## File: scripts/auto_destroy.ps1
````powershell
<#
.SYNOPSIS
    Script de seguridad para destruir infraestructura en AWS tras X horas.
    Evita costos accidentales por dejar el laboratorio encendido.
#>

# ⚠️ CONFIGURACIÓN: Cambia esto según tus horas de estudio
$Horas = 4
$Segundos = $Horas * 3600

# Calcular tiempos
$FechaInicio = Get-Date
$FechaFin = $FechaInicio.AddHours($Horas)
$CostoEstimado = $Horas * 0.12 # Costo aprox por hora de EKS + Nodos Spot

Clear-Host
Write-Host "============================================" -ForegroundColor Cyan
Write-Host "   ⏰ AUTO-DESTROY DE INFRAESTRUCTURA   " -ForegroundColor Cyan
Write-Host "============================================"
Write-Host "📍 Inicio: $FechaInicio"
Write-Host "🔥 DESTRUCCIÓN PROGRAMADA: $FechaFin"
Write-Host "💰 Costo máx. estimado sesión: `$$CostoEstimado USD"
Write-Host ""
Write-Host "⚠️  IMPORTANTE:" -ForegroundColor Yellow
Write-Host "1. NO cierres esta terminal de VS Code."
Write-Host "2. Si tu PC se suspende, el contador se pausa."
Write-Host "3. Para cancelar, presiona Ctrl+C en esta ventana."
Write-Host "============================================"

# Esperar el tiempo definido
Start-Sleep -Seconds $Segundos

# --- COMIENZA LA DESTRUCCIÓN ---
Write-Host ""
Write-Host "⏰ Tiempo expirado. Iniciando destrucción..." -ForegroundColor Red

# Navegar a la carpeta terraform relativa a este script
$ScriptPath = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location "$ScriptPath\..\..\terraform"

# Ejecutar Terraform
terraform destroy -auto-approve

if ($LASTEXITCODE -eq 0) {
    Write-Host "✅ Infraestructura destruida exitosamente." -ForegroundColor Green
    Write-Host "💰 Ahorro asegurado." -ForegroundColor Green
} else {
    Write-Host "❌ Error al destruir. Revisa la consola." -ForegroundColor Red
}
````

## File: scripts/docker/build_and_push.sh
````bash
#!/bin/bash
set -e

# Colores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}🚀 Build and Push Script para ECR${NC}"

# Variables (ajustar según tu cuenta)
AWS_REGION="us-east-1"
AWS_ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)
BACKEND_REPO="gpuchile-backend"
FRONTEND_REPO="gpuchile-frontend"

# Login a ECR
echo -e "${YELLOW}📝 Login a ECR...${NC}"
aws ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com

# Build y push Backend
echo -e "${YELLOW}🔨 Building backend...${NC}"
cd ../../apps/backend
docker build -t $BACKEND_REPO:latest .
docker tag $BACKEND_REPO:latest $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$BACKEND_REPO:latest
echo -e "${YELLOW}📤 Pushing backend...${NC}"
docker push $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$BACKEND_REPO:latest

# Build y push Frontend
echo -e "${YELLOW}🔨 Building frontend...${NC}"
cd ../frontend
docker build -t $FRONTEND_REPO:latest .
docker tag $FRONTEND_REPO:latest $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$FRONTEND_REPO:latest
echo -e "${YELLOW}📤 Pushing frontend...${NC}"
docker push $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$FRONTEND_REPO:latest

echo -e "${GREEN}✅ Build and push completed successfully!${NC}"
echo -e "${GREEN}Backend: $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$BACKEND_REPO:latest${NC}"
echo -e "${GREEN}Frontend: $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$FRONTEND_REPO:latest${NC}"
````

## File: terraform/.terraform.lock.hcl
````hcl
# This file is maintained automatically by "terraform init".
# Manual edits may be lost in future updates.

provider "registry.terraform.io/hashicorp/archive" {
  version = "2.7.1"
  hashes = [
    "h1:RzToQiFwVaxcV0QmgbyaKgNOhqc6oLKiFyZTrQSGcog=",
    "zh:19881bb356a4a656a865f48aee70c0b8a03c35951b7799b6113883f67f196e8e",
    "zh:2fcfbf6318dd514863268b09bbe19bfc958339c636bcbcc3664b45f2b8bf5cc6",
    "zh:3323ab9a504ce0a115c28e64d0739369fe85151291a2ce480d51ccbb0c381ac5",
    "zh:362674746fb3da3ab9bd4e70c75a3cdd9801a6cf258991102e2c46669cf68e19",
    "zh:7140a46d748fdd12212161445c46bbbf30a3f4586c6ac97dd497f0c2565fe949",
    "zh:78d5eefdd9e494defcb3c68d282b8f96630502cac21d1ea161f53cfe9bb483b3",
    "zh:875e6ce78b10f73b1efc849bfcc7af3a28c83a52f878f503bb22776f71d79521",
    "zh:b872c6ed24e38428d817ebfb214da69ea7eefc2c38e5a774db2ccd58e54d3a22",
    "zh:cd6a44f731c1633ae5d37662af86e7b01ae4c96eb8b04144255824c3f350392d",
    "zh:e0600f5e8da12710b0c52d6df0ba147a5486427c1a2cc78f31eea37a47ee1b07",
    "zh:f21b2e2563bbb1e44e73557bcd6cdbc1ceb369d471049c40eb56cb84b6317a60",
    "zh:f752829eba1cc04a479cf7ae7271526b402e206d5bcf1fcce9f535de5ff9e4e6",
  ]
}

provider "registry.terraform.io/hashicorp/aws" {
  version     = "5.100.0"
  constraints = ">= 4.33.0, >= 4.57.0, >= 5.0.0, ~> 5.0"
  hashes = [
    "h1:H3mU/7URhP0uCRGK8jeQRKxx2XFzEqLiOq/L2Bbiaxs=",
    "zh:054b8dd49f0549c9a7cc27d159e45327b7b65cf404da5e5a20da154b90b8a644",
    "zh:0b97bf8d5e03d15d83cc40b0530a1f84b459354939ba6f135a0086c20ebbe6b2",
    "zh:1589a2266af699cbd5d80737a0fe02e54ec9cf2ca54e7e00ac51c7359056f274",
    "zh:6330766f1d85f01ae6ea90d1b214b8b74cc8c1badc4696b165b36ddd4cc15f7b",
    "zh:7c8c2e30d8e55291b86fcb64bdf6c25489d538688545eb48fd74ad622e5d3862",
    "zh:99b1003bd9bd32ee323544da897148f46a527f622dc3971af63ea3e251596342",
    "zh:9b12af85486a96aedd8d7984b0ff811a4b42e3d88dad1a3fb4c0b580d04fa425",
    "zh:9f8b909d3ec50ade83c8062290378b1ec553edef6a447c56dadc01a99f4eaa93",
    "zh:aaef921ff9aabaf8b1869a86d692ebd24fbd4e12c21205034bb679b9caf883a2",
    "zh:ac882313207aba00dd5a76dbd572a0ddc818bb9cbf5c9d61b28fe30efaec951e",
    "zh:bb64e8aff37becab373a1a0cc1080990785304141af42ed6aa3dd4913b000421",
    "zh:dfe495f6621df5540d9c92ad40b8067376350b005c637ea6efac5dc15028add4",
    "zh:f0ddf0eaf052766cfe09dea8200a946519f653c384ab4336e2a4a64fdd6310e9",
    "zh:f1b7e684f4c7ae1eed272b6de7d2049bb87a0275cb04dbb7cda6636f600699c9",
    "zh:ff461571e3f233699bf690db319dfe46aec75e58726636a0d97dd9ac6e32fb70",
  ]
}

provider "registry.terraform.io/hashicorp/cloudinit" {
  version     = "2.3.7"
  constraints = ">= 2.0.0"
  hashes = [
    "h1:h1Pr6uNwq+iDEGrnQJEHzOTz+yVTW0AJgZrGXuoO4Qs=",
    "zh:06f1c54e919425c3139f8aeb8fcf9bceca7e560d48c9f0c1e3bb0a8ad9d9da1e",
    "zh:0e1e4cf6fd98b019e764c28586a386dc136129fef50af8c7165a067e7e4a31d5",
    "zh:1871f4337c7c57287d4d67396f633d224b8938708b772abfc664d1f80bd67edd",
    "zh:2b9269d91b742a71b2248439d5e9824f0447e6d261bfb86a8a88528609b136d1",
    "zh:3d8ae039af21426072c66d6a59a467d51f2d9189b8198616888c1b7fc42addc7",
    "zh:3ef4e2db5bcf3e2d915921adced43929214e0946a6fb11793085d9a48995ae01",
    "zh:42ae54381147437c83cbb8790cc68935d71b6357728a154109d3220b1beb4dc9",
    "zh:4496b362605ae4cbc9ef7995d102351e2fe311897586ffc7a4a262ccca0c782a",
    "zh:652a2401257a12706d32842f66dac05a735693abcb3e6517d6b5e2573729ba13",
    "zh:7406c30806f5979eaed5f50c548eced2ea18ea121e01801d2f0d4d87a04f6a14",
    "zh:7848429fd5a5bcf35f6fee8487df0fb64b09ec071330f3ff240c0343fe2a5224",
    "zh:78d5eefdd9e494defcb3c68d282b8f96630502cac21d1ea161f53cfe9bb483b3",
  ]
}

provider "registry.terraform.io/hashicorp/helm" {
  version     = "3.1.1"
  constraints = ">= 2.11.0"
  hashes = [
    "h1:s68EnUScdj1dXoXrNBaH/AIk18R2ryKeHY5H0ETfUws=",
    "zh:1a6d5ce931708aec29d1f3d9e360c2a0c35ba5a54d03eeaff0ce3ca597cd0275",
    "zh:3411919ba2a5941801e677f0fea08bdd0ae22ba3c9ce3309f55554699e06524a",
    "zh:81b36138b8f2320dc7f877b50f9e38f4bc614affe68de885d322629dd0d16a29",
    "zh:95a2a0a497a6082ee06f95b38bd0f0d6924a65722892a856cfd914c0d117f104",
    "zh:9d3e78c2d1bb46508b972210ad706dd8c8b106f8b206ecf096cd211c54f46990",
    "zh:a79139abf687387a6efdbbb04289a0a8e7eaca2bd91cdc0ce68ea4f3286c2c34",
    "zh:aaa8784be125fbd50c48d84d6e171d3fb6ef84a221dbc5165c067ce05faab4c8",
    "zh:afecd301f469975c9d8f350cc482fe656e082b6ab0f677d1a816c3c615837cc1",
    "zh:c54c22b18d48ff9053d899d178d9ffef7d9d19785d9bf310a07d648b7aac075b",
    "zh:db2eefd55aea48e73384a555c72bac3f7d428e24147bedb64e1a039398e5b903",
    "zh:ee61666a233533fd2be971091cecc01650561f1585783c381b6f6e8a390198a4",
    "zh:f569b65999264a9416862bca5cd2a6177d94ccb0424f3a4ef424428912b9cb3c",
  ]
}

provider "registry.terraform.io/hashicorp/kubernetes" {
  version     = "3.0.1"
  constraints = ">= 2.10.0, >= 2.23.0"
  hashes = [
    "h1:wZsAFR6ICMxB29/a4nlwdLcyWxQChEubkut0ffk5BPc=",
    "zh:02d55b0b2238fd17ffa12d5464593864e80f402b90b31f6e1bd02249b9727281",
    "zh:20b93a51bfeed82682b3c12f09bac3031f5bdb4977c47c97a042e4df4fb2f9ba",
    "zh:6e14486ecfaee38c09ccf33d4fdaf791409f90795c1b66e026c226fad8bc03c7",
    "zh:8d0656ff422df94575668e32c310980193fccb1c28117e5c78dd2d4050a760a6",
    "zh:9795119b30ec0c1baa99a79abace56ac850b6e6fbce60e7f6067792f6eb4b5f4",
    "zh:b388c87acc40f6bd9620f4e23f01f3c7b41d9b88a68d5255dec0a72f0bdec249",
    "zh:b59abd0a980649c2f97f172392f080eaeb18e486b603f83bf95f5d93aeccc090",
    "zh:ba6e3060fddf4a022087d8f09e38aa0001c705f21170c2ded3d1c26c12f70d97",
    "zh:c12626d044b1d5501cf95ca78cbe507c13ad1dd9f12d4736df66eb8e5f336eb8",
    "zh:c55203240d50f4cdeb3df1e1760630d677679f5b1a6ffd9eba23662a4ad05119",
    "zh:ea206a5a32d6e0d6e32f1849ad703da9a28355d9c516282a8458b5cf1502b2a1",
    "zh:f569b65999264a9416862bca5cd2a6177d94ccb0424f3a4ef424428912b9cb3c",
  ]
}

provider "registry.terraform.io/hashicorp/random" {
  version     = "3.8.1"
  constraints = "~> 3.5"
  hashes = [
    "h1:osH3aBqEARwOz3VBJKdpFKJJCNIdgRC6k8vPojkLmlY=",
    "zh:08dd03b918c7b55713026037c5400c48af5b9f468f483463321bd18e17b907b4",
    "zh:0eee654a5542dc1d41920bbf2419032d6f0d5625b03bd81339e5b33394a3e0ae",
    "zh:229665ddf060aa0ed315597908483eee5b818a17d09b6417a0f52fd9405c4f57",
    "zh:2469d2e48f28076254a2a3fc327f184914566d9e40c5780b8d96ebf7205f8bc0",
    "zh:37d7eb334d9561f335e748280f5535a384a88675af9a9eac439d4cfd663bcb66",
    "zh:741101426a2f2c52dee37122f0f4a2f2d6af6d852cb1db634480a86398fa3511",
    "zh:78d5eefdd9e494defcb3c68d282b8f96630502cac21d1ea161f53cfe9bb483b3",
    "zh:a902473f08ef8df62cfe6116bd6c157070a93f66622384300de235a533e9d4a9",
    "zh:b85c511a23e57a2147355932b3b6dce2a11e856b941165793a0c3d7578d94d05",
    "zh:c5172226d18eaac95b1daac80172287b69d4ce32750c82ad77fa0768be4ea4b8",
    "zh:dab4434dba34aad569b0bc243c2d3f3ff86dd7740def373f2a49816bd2ff819b",
    "zh:f49fd62aa8c5525a5c17abd51e27ca5e213881d58882fd42fec4a545b53c9699",
  ]
}

provider "registry.terraform.io/hashicorp/time" {
  version     = "0.13.1"
  constraints = ">= 0.9.0"
  hashes = [
    "h1:5l8PAnxPdoUPqNPuv1dAr3efcCCtSCnY+Vj2nSGkQmw=",
    "zh:02cb9aab1002f0f2a94a4f85acec8893297dc75915f7404c165983f720a54b74",
    "zh:04429b2b31a492d19e5ecf999b116d396dac0b24bba0d0fb19ecaefe193fdb8f",
    "zh:26f8e51bb7c275c404ba6028c1b530312066009194db721a8427a7bc5cdbc83a",
    "zh:772ff8dbdbef968651ab3ae76d04afd355c32f8a868d03244db3f8496e462690",
    "zh:78d5eefdd9e494defcb3c68d282b8f96630502cac21d1ea161f53cfe9bb483b3",
    "zh:898db5d2b6bd6ca5457dccb52eedbc7c5b1a71e4a4658381bcbb38cedbbda328",
    "zh:8de913bf09a3fa7bedc29fec18c47c571d0c7a3d0644322c46f3aa648cf30cd8",
    "zh:9402102c86a87bdfe7e501ffbb9c685c32bbcefcfcf897fd7d53df414c36877b",
    "zh:b18b9bb1726bb8cfbefc0a29cf3657c82578001f514bcf4c079839b6776c47f0",
    "zh:b9d31fdc4faecb909d7c5ce41d2479dd0536862a963df434be4b16e8e4edc94d",
    "zh:c951e9f39cca3446c060bd63933ebb89cedde9523904813973fbc3d11863ba75",
    "zh:e5b773c0d07e962291be0e9b413c7a22c044b8c7b58c76e8aa91d1659990dfb5",
  ]
}

provider "registry.terraform.io/hashicorp/tls" {
  version     = "4.1.0"
  constraints = ">= 3.0.0"
  hashes = [
    "h1:y9cHrgcuaZt592In6xQzz1lx7k/B9EeWrAb8K7QqOgU=",
    "zh:14c35d89307988c835a7f8e26f1b83ce771e5f9b41e407f86a644c0152089ac2",
    "zh:2fb9fe7a8b5afdbd3e903acb6776ef1be3f2e587fb236a8c60f11a9fa165faa8",
    "zh:35808142ef850c0c60dd93dc06b95c747720ed2c40c89031781165f0c2baa2fc",
    "zh:35b5dc95bc75f0b3b9c5ce54d4d7600c1ebc96fbb8dfca174536e8bf103c8cdc",
    "zh:38aa27c6a6c98f1712aa5cc30011884dc4b128b4073a4a27883374bfa3ec9fac",
    "zh:51fb247e3a2e88f0047cb97bb9df7c228254a3b3021c5534e4563b4007e6f882",
    "zh:62b981ce491e38d892ba6364d1d0cdaadcee37cc218590e07b310b1dfa34be2d",
    "zh:bc8e47efc611924a79f947ce072a9ad698f311d4a60d0b4dfff6758c912b7298",
    "zh:c149508bd131765d1bc085c75a870abb314ff5a6d7f5ac1035a8892d686b6297",
    "zh:d38d40783503d278b63858978d40e07ac48123a2925e1a6b47e62179c046f87a",
    "zh:f569b65999264a9416862bca5cd2a6177d94ccb0424f3a4ef424428912b9cb3c",
    "zh:fb07f708e3316615f6d218cec198504984c0ce7000b9f1eebff7516e384f4b54",
  ]
}
````

## File: terraform/backend.tf
````hcl
# terraform/backend.tf
terraform {
  backend "s3" {
    # 👇 AQUÍ PONES EL NOMBRE EXACTO QUE ACABAS DE CREAR
    bucket         = "gpuchile-terraform-state-nicolas-2026"
    key            = "eks-cluster/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "gpuchile-terraform-locks"
  }
}
````

## File: terraform/main.tf
````hcl
# terraform/main.tf

terraform {
  required_version = ">= 1.3.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.5"
    }
    # 👇 ESTOS SON LOS QUE FALTABAN PARA ARREGLAR EL ERROR
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.23"
    }
    helm = {
      source  = "hashicorp/helm"
      version = ">= 2.11" # Esta versión sí soporta el bloque 'kubernetes {}'
    }
  }
}

provider "aws" {
  region = var.region
  default_tags {
    tags = {
      Project     = "GpuChile"
      Environment = var.environment
      ManagedBy   = "Terraform"
      Owner       = "NicolasNunez"
    }
  }
}

# ⚠️ IMPORTANTE: Estos providers se configuran DESPUÉS de crear el cluster
# Por eso aplicaremos en 2 fases

provider "kubernetes" {
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
  
  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    command     = "aws"
    args = [
      "eks",
      "get-token",
      "--cluster-name",
      module.eks.cluster_name
    ]
  }
}

provider "helm" {
  kubernetes = {
    host                   = module.eks.cluster_endpoint
    cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
    
    exec = {
      api_version = "client.authentication.k8s.io/v1beta1"
      command     = "aws"
      args = [
        "eks",
        "get-token",
        "--cluster-name",
        module.eks.cluster_name
      ]
    }
  }
}



# 1. VPC
module "vpc" {
  source = "./modules/vpc"

  vpc_cidr     = var.vpc_cidr
  environment  = var.environment
  cluster_name = var.cluster_name
}

# 2. EKS
module "eks" {
  source = "./modules/eks"

  cluster_name = var.cluster_name
  vpc_id       = module.vpc.vpc_id
  subnet_ids   = module.vpc.public_subnets
  environment  = var.environment
}

# 3. RDS
module "rds" {
  source = "./modules/rds"

  environment               = var.environment
  vpc_id                    = module.vpc.vpc_id
  subnet_ids                = module.vpc.public_subnets
  allowed_security_group_id = module.eks.cluster_security_group_id
}

# 4. S3
module "s3" {
  source = "./modules/s3"

  environment = var.environment
  bucket_name = "gpuchile-images-${var.environment}-2026" # Debe ser globalmente único
}

# 5. Lambda
module "lambda" {
  source = "./modules/lambda"

  environment     = var.environment
  s3_bucket_name  = module.s3.bucket_name
  s3_bucket_arn   = module.s3.bucket_arn
}

# 6. Secretos Adicionales (JWT, Redis)
module "secrets" {
  source = "./modules/secrets"

  environment = var.environment
}

# 7. IRSA Role para el Backend
module "backend_irsa" {
  source = "./modules/irsa"

  cluster_name         = var.cluster_name
  oidc_provider_arn    = module.eks.oidc_provider_arn
  namespace            = "default"
  service_account_name = "gpuchile-backend-sa"
  s3_bucket_arn        = module.s3.bucket_arn
  
  secrets_arns = [
    module.rds.db_secret_arn,
    module.secrets.jwt_secret_arn,
    module.secrets.redis_secret_arn
  ]
}

# 8. ECR Repositories
module "ecr" {
  source = "./modules/ecr"

  environment  = var.environment
  repositories = ["gpuchile-backend", "gpuchile-frontend"]
}

# 9. Monitoring Stack (Prometheus + Grafana)
module "monitoring" {
  source = "./modules/monitoring"

  cluster_name      = var.cluster_name
  oidc_provider_arn = module.eks.oidc_provider_arn
  namespace         = "monitoring"
}
````

## File: terraform/modules/ecr/main.tf
````hcl
resource "aws_ecr_repository" "repos" {
  for_each = toset(var.repositories)
  
  name                 = each.value
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true  # Escaneo de seguridad automático (Trivy)
  }

  encryption_configuration {
    encryption_type = "AES256"
  }

  tags = {
    Name        = each.value
    Environment = var.environment
  }
}

# Política de ciclo de vida (Retener solo últimas 10 imágenes)
resource "aws_ecr_lifecycle_policy" "cleanup" {
  for_each   = aws_ecr_repository.repos
  repository = each.value.name

  policy = jsonencode({
    rules = [
      {
        rulePriority = 1
        description  = "Keep last 10 images"
        selection = {
          tagStatus     = "any"
          countType     = "imageCountMoreThan"
          countNumber   = 10
        }
        action = {
          type = "expire"
        }
      }
    ]
  })
}
````

## File: terraform/modules/ecr/outputs.tf
````hcl
output "repository_urls" {
  description = "Map de nombres a URLs de los repositorios ECR"
  value = {
    for name, repo in aws_ecr_repository.repos :
    name => repo.repository_url
  }
}

output "repository_arns" {
  description = "Map de nombres a ARNs de los repositorios"
  value = {
    for name, repo in aws_ecr_repository.repos :
    name => repo.arn
  }
}
````

## File: terraform/modules/ecr/variables.tf
````hcl
variable "environment" {
  description = "Entorno de despliegue"
  type        = string
}

variable "repositories" {
  description = "Lista de nombres de repositorios ECR"
  type        = list(string)
  default     = ["gpuchile-backend", "gpuchile-frontend"]
}
````

## File: terraform/modules/eks/main.tf
````hcl
module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 19.0"

  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version

  # 🌐 RED: Cluster público (Accesso API Server)
  cluster_endpoint_public_access = true

  vpc_id                   = var.vpc_id
  subnet_ids               = var.subnet_ids
  control_plane_subnet_ids = var.subnet_ids

  # 🛡️ SEGURIDAD: OIDC Provider (Vital para IRSA - Roles de Service Accounts)
  enable_irsa = true

  # 💰 NODOS (WORKERS)
  eks_managed_node_groups = {
    spot_nodes = {
      min_size     = var.min_size
      max_size     = var.max_size
      desired_size = var.desired_size

      instance_types = var.node_instance_types
      capacity_type  = "SPOT" # 📉 AHORRO MASIVO

      # Importante: Nodos en subnets públicas necesitan IP pública si no hay NAT Gateway
      associate_public_ip_address = true

      # Labels útiles para selectores en K8s
      labels = {
        Environment = var.environment
        NodeType    = "spot"
      }
    }
  }

  tags = {
    Environment = var.environment
    Terraform   = "true"
    Project     = "GpuChile"
  }
}
````

## File: terraform/modules/eks/outputs.tf
````hcl
output "cluster_endpoint" {
  description = "Endpoint for EKS control plane"
  value       = module.eks.cluster_endpoint
}

output "cluster_security_group_id" {
  description = "Security group ids attached to the cluster control plane"
  value       = module.eks.cluster_security_group_id
}

output "cluster_name" {
  description = "Kubernetes Cluster Name"
  value       = module.eks.cluster_name
}

output "oidc_provider_arn" {
  description = "The ARN of the OIDC Provider if enable_irsa = true"
  value       = module.eks.oidc_provider_arn
}

output "cluster_certificate_authority_data" {
  description = "Nested attribute containing certificate-authority-data for your cluster"
  value       = module.eks.cluster_certificate_authority_data
}
````

## File: terraform/modules/eks/variables.tf
````hcl
variable "cluster_name" {
  description = "Nombre del cluster EKS"
  type        = string
}

variable "vpc_id" {
  description = "ID de la VPC donde se desplegará el cluster"
  type        = string
}

variable "subnet_ids" {
  description = "Lista de IDs de subnets para los nodos y el control plane"
  type        = list(string)
}

variable "environment" {
  description = "Entorno (dev, prod, etc.)"
  type        = string
  default     = "dev"
}

variable "cluster_version" {
  description = "Versión de Kubernetes"
  type        = string
  default     = "1.28"
}

variable "node_instance_types" {
  description = "Tipos de instancia para los nodos trabajadores"
  type        = list(string)
  default     = ["t3.medium"]
}

variable "min_size" {
  description = "Número mínimo de nodos"
  type        = number
  default     = 1
}

variable "max_size" {
  description = "Número máximo de nodos"
  type        = number
  default     = 2
}

variable "desired_size" {
  description = "Número deseado de nodos iniciales"
  type        = number
  default     = 1
}
````

## File: terraform/modules/irsa/main.tf
````hcl
# Extraer el OIDC Provider ID del ARN
locals {
  oidc_provider_id = replace(var.oidc_provider_arn, "/^(.*provider/)/", "")
}

# IAM Role para el Service Account
resource "aws_iam_role" "service_account" {
  name = "${var.cluster_name}-${var.service_account_name}-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Federated = var.oidc_provider_arn
        }
        Action = "sts:AssumeRoleWithWebIdentity"
        Condition = {
          StringEquals = {
            "${local.oidc_provider_id}:sub" = "system:serviceaccount:${var.namespace}:${var.service_account_name}"
            "${local.oidc_provider_id}:aud" = "sts.amazonaws.com"
          }
        }
      }
    ]
  })

  tags = {
    Name = "${var.cluster_name}-${var.service_account_name}"
  }
}

# Policy: Acceso a S3 (Subir/Leer imágenes)
resource "aws_iam_role_policy" "s3_access" {
  name = "s3-access"
  role = aws_iam_role.service_account.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:DeleteObject",
          "s3:ListBucket"
        ]
        Resource = [
          var.s3_bucket_arn,
          "${var.s3_bucket_arn}/*"
        ]
      }
    ]
  })
}

# Policy: Acceso a Secrets Manager (Leer credenciales)
resource "aws_iam_role_policy" "secrets_access" {
  name = "secrets-access"
  role = aws_iam_role.service_account.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "secretsmanager:GetSecretValue",
          "secretsmanager:DescribeSecret"
        ]
        Resource = var.secrets_arns
      }
    ]
  })
}
````

## File: terraform/modules/irsa/outputs.tf
````hcl
output "role_arn" {
  description = "ARN del IAM Role para el Service Account"
  value       = aws_iam_role.service_account.arn
}

output "role_name" {
  description = "Nombre del IAM Role"
  value       = aws_iam_role.service_account.name
}
````

## File: terraform/modules/irsa/variables.tf
````hcl
variable "cluster_name" {
  description = "Nombre del cluster EKS"
  type        = string
}

variable "oidc_provider_arn" {
  description = "ARN del OIDC provider del cluster EKS"
  type        = string
}

variable "namespace" {
  description = "Namespace de Kubernetes donde correrá la app"
  type        = string
  default     = "default"
}

variable "service_account_name" {
  description = "Nombre del Service Account en K8s"
  type        = string
}

variable "s3_bucket_arn" {
  description = "ARN del bucket S3 para permisos"
  type        = string
}

variable "secrets_arns" {
  description = "Lista de ARNs de secretos en Secrets Manager"
  type        = list(string)
}
````

## File: terraform/modules/lambda/main.tf
````hcl
# IAM Role para Lambda
resource "aws_iam_role" "lambda" {
  name = "${var.function_name}-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }]
  })
}

# Policy para logs CloudWatch
resource "aws_iam_role_policy_attachment" "lambda_logs" {
  role       = aws_iam_role.lambda.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

# Policy para acceso a S3
resource "aws_iam_role_policy" "lambda_s3" {
  name = "lambda-s3-access"
  role = aws_iam_role.lambda.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:GetObject",
          "s3:PutObject"
        ]
        Resource = "${var.s3_bucket_arn}/*"
      }
    ]
  })
}

# Archivar el código de Lambda (tu lambda_function.py)
data "archive_file" "lambda_zip" {
  type        = "zip"
  # ⚠️ Asegúrate que esta ruta coincida con tu carpeta real
  source_dir  = "${path.root}/../lambda/image-resizer"
  output_path = "${path.module}/lambda_function.zip"
}

# Función Lambda
resource "aws_lambda_function" "resizer" {
  filename      = data.archive_file.lambda_zip.output_path
  function_name = var.function_name
  role          = aws_iam_role.lambda.arn
  handler       = "lambda_function.lambda_handler"

  source_code_hash = data.archive_file.lambda_zip.output_base64sha256

  runtime     = "python3.11"
  timeout     = 30
  memory_size = 512

  # 👇 LA MAGIA: Layer pública que contiene Pillow (PIL) para Python 3.11 en us-east-1
  layers = ["arn:aws:lambda:us-east-1:770693421928:layer:Klayers-p311-Pillow:3"]

  environment {
    variables = {
      ENVIRONMENT = var.environment
    }
  }

  tags = {
    Environment = var.environment
  }
}

# Permiso para que S3 invoque la Lambda
resource "aws_lambda_permission" "allow_s3" {
  statement_id  = "AllowS3Invoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.resizer.function_name
  principal     = "s3.amazonaws.com"
  source_arn    = var.s3_bucket_arn
}

# Trigger S3 -> Lambda (cuando se sube a /original/)
resource "aws_s3_bucket_notification" "lambda_trigger" {
  bucket = var.s3_bucket_name

  lambda_function {
    lambda_function_arn = aws_lambda_function.resizer.arn
    events              = ["s3:ObjectCreated:*"]
    filter_prefix       = "original/"
  }

  depends_on = [aws_lambda_permission.allow_s3]
}
````

## File: terraform/modules/lambda/outputs.tf
````hcl
output "lambda_function_arn" {
  description = "ARN de la función Lambda"
  value       = aws_lambda_function.resizer.arn
}

output "lambda_function_name" {
  description = "Nombre de la función Lambda"
  value       = aws_lambda_function.resizer.function_name
}
````

## File: terraform/modules/lambda/variables.tf
````hcl
variable "environment" {
  description = "Entorno de despliegue"
  type        = string
}

variable "s3_bucket_name" {
  description = "Nombre del bucket S3 que disparará la Lambda"
  type        = string
}

variable "s3_bucket_arn" {
  description = "ARN del bucket S3"
  type        = string
}

variable "function_name" {
  description = "Nombre de la función Lambda"
  type        = string
  default     = "gpuchile-image-resizer"
}
````

## File: terraform/modules/monitoring/main.tf
````hcl
# 1. Extraer OIDC Provider ID
locals {
  oidc_provider_id = replace(var.oidc_provider_arn, "/^(.*provider/)/", "")
}

# 2. IAM Role para Prometheus
resource "aws_iam_role" "prometheus" {
  name = "${var.cluster_name}-prometheus-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = { Federated = var.oidc_provider_arn }
        Action = "sts:AssumeRoleWithWebIdentity"
        Condition = {
          StringEquals = {
            "${local.oidc_provider_id}:sub" = "system:serviceaccount:${var.namespace}:prometheus-stack-kube-prom-prometheus"
            "${local.oidc_provider_id}:aud" = "sts.amazonaws.com"
          }
        }
      }
    ]
  })
}

# 3. Policy CloudWatch
resource "aws_iam_role_policy" "prometheus_cloudwatch" {
  name = "cloudwatch-access"
  role = aws_iam_role.prometheus.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = ["cloudwatch:GetMetricStatistics", "cloudwatch:ListMetrics"]
        Resource = "*"
      }
    ]
  })
}

# 4. Instalación de Prometheus con Helm (ESTILO YAML)
resource "helm_release" "kube_prometheus_stack" {
  name             = "prometheus-stack"
  repository       = "https://prometheus-community.github.io/helm-charts"
  chart            = "kube-prometheus-stack"
  namespace        = var.namespace
  create_namespace = true

  # ⚠️ AQUÍ ESTÁ EL CAMBIO MÁGICO
  # En lugar de usar 'set {}', usamos 'values' con YAML.
  # Esto evita el error de "Unsupported block type".
  values = [
    yamlencode({
      grafana = {
        adminPassword = "admin123"
      }
      prometheus = {
        prometheusSpec = {
          resources = {
            requests = { memory = "256Mi" }
            limits   = { memory = "512Mi" }
          }
          serviceAccount = {
            annotations = {
              "eks.amazonaws.com/role-arn" = aws_iam_role.prometheus.arn
            }
          }
        }
      }
    })
  ]
}
````

## File: terraform/modules/monitoring/outputs.tf
````hcl
output "prometheus_role_arn" {
  description = "ARN del IAM Role para Prometheus"
  value       = aws_iam_role.prometheus.arn
}

output "namespace" {
  value = var.namespace
}
````

## File: terraform/modules/monitoring/variables.tf
````hcl
variable "cluster_name" {
  description = "Nombre del cluster EKS"
  type        = string
}

variable "oidc_provider_arn" {
  description = "ARN del OIDC provider"
  type        = string
}

variable "namespace" {
  description = "Namespace para Prometheus"
  type        = string
  default     = "monitoring"
}
````

## File: terraform/modules/monitoring/versions.tf
````hcl
terraform {
  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = ">= 2.11"
    }
  }
}
````

## File: terraform/modules/rds/main.tf
````hcl
# Generar password aleatorio (se guarda en Terraform State)
resource "random_password" "db_password" {
  length  = 24
  special = true
}

# Security Group para RDS
resource "aws_security_group" "rds" {
  name        = "gpuchile-rds-${var.environment}"
  description = "Security group for RDS PostgreSQL"
  vpc_id      = var.vpc_id

  ingress {
    description     = "PostgreSQL from EKS"
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [var.allowed_security_group_id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "gpuchile-rds-sg"
    Environment = var.environment
  }
}

# Subnet Group (RDS necesita al menos 2 AZs)
resource "aws_db_subnet_group" "main" {
  name       = "gpuchile-db-subnet-${var.environment}"
  subnet_ids = var.subnet_ids

  tags = {
    Name = "GpuChile DB Subnet Group"
  }
}

# RDS Instance
resource "aws_db_instance" "postgres" {
  identifier     = "gpuchile-db-${var.environment}"
  engine         = "postgres"
  engine_version = "15.4"
  instance_class = var.instance_class

  allocated_storage     = var.allocated_storage
  max_allocated_storage = 50 # Autoscaling hasta 50GB

  db_name  = var.db_name
  username = var.db_username
  password = random_password.db_password.result

  db_subnet_group_name   = aws_db_subnet_group.main.name
  vpc_security_group_ids = [aws_security_group.rds.id]

  # ⚠️ COST SAVING: Single-AZ (Multi-AZ duplica el costo)
  multi_az               = false
  publicly_accessible    = false
  skip_final_snapshot    = true # Para dev/portfolio (En prod: false)
  backup_retention_period = 7

  tags = {
    Name        = "gpuchile-postgres"
    Environment = var.environment
  }
}

# Guardar credenciales en AWS Secrets Manager (para External Secrets Operator)
resource "aws_secretsmanager_secret" "db_credentials" {
  name = "gpuchile/${var.environment}/db"
  
  tags = {
    Environment = var.environment
  }
}

resource "aws_secretsmanager_secret_version" "db_credentials" {
  secret_id = aws_secretsmanager_secret.db_credentials.id
  secret_string = jsonencode({
    username = aws_db_instance.postgres.username
    password = random_password.db_password.result
    host     = aws_db_instance.postgres.address
    port     = aws_db_instance.postgres.port
    dbname   = aws_db_instance.postgres.db_name
    url      = "postgresql://${aws_db_instance.postgres.username}:${random_password.db_password.result}@${aws_db_instance.postgres.address}:${aws_db_instance.postgres.port}/${aws_db_instance.postgres.db_name}"
  })
}
````

## File: terraform/modules/rds/outputs.tf
````hcl
output "db_instance_endpoint" {
  description = "El endpoint de conexión de la base de datos"
  value       = aws_db_instance.postgres.endpoint
}

output "db_instance_name" {
  description = "El nombre de la base de datos"
  value       = aws_db_instance.postgres.db_name
}

output "db_secret_arn" {
  description = "ARN del secreto en Secrets Manager"
  value       = aws_secretsmanager_secret.db_credentials.arn
}

output "db_security_group_id" {
  description = "ID del security group de RDS"
  value       = aws_security_group.rds.id
}
````

## File: terraform/modules/rds/variables.tf
````hcl
variable "environment" {
  description = "Entorno de despliegue"
  type        = string
}

variable "vpc_id" {
  description = "ID de la VPC"
  type        = string
}

variable "subnet_ids" {
  description = "Lista de subnet IDs para el subnet group"
  type        = list(string)
}

variable "allowed_security_group_id" {
  description = "Security Group ID del EKS cluster para permitir conexión"
  type        = string
}

variable "db_name" {
  description = "Nombre de la base de datos"
  type        = string
  default     = "gpuchile"
}

variable "db_username" {
  description = "Usuario maestro de la DB"
  type        = string
  default     = "gpuchile_admin"
}

variable "instance_class" {
  description = "Tipo de instancia RDS"
  type        = string
  default     = "db.t3.micro" # Free Tier eligible (750 horas/mes)
}

variable "allocated_storage" {
  description = "Almacenamiento en GB"
  type        = number
  default     = 20
}
````

## File: terraform/modules/s3/main.tf
````hcl
resource "aws_s3_bucket" "images" {
  bucket = var.bucket_name

  tags = {
    Name        = "GpuChile Images"
    Environment = var.environment
  }
}

# Bloquear acceso público a nivel de bucket (security)
resource "aws_s3_bucket_public_access_block" "images" {
  bucket = aws_s3_bucket.images.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

# Política para permitir lectura pública en /thumbnails/
resource "aws_s3_bucket_policy" "images" {
  bucket = aws_s3_bucket.images.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "PublicReadThumbnails"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "${aws_s3_bucket.images.arn}/thumbnails/*"
      },
      {
        Sid       = "PublicReadOriginals"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "${aws_s3_bucket.images.arn}/original/*"
      }
    ]
  })
}

# CORS para que el frontend pueda cargar imágenes
resource "aws_s3_bucket_cors_configuration" "images" {
  bucket = aws_s3_bucket.images.id

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["GET", "HEAD"]
    allowed_origins = ["*"] # En prod: Especificar dominios exactos
    expose_headers  = ["ETag"]
    max_age_seconds = 3000
  }
}

# Versionado (Opcional, para recuperación)
resource "aws_s3_bucket_versioning" "images" {
  bucket = aws_s3_bucket.images.id

  versioning_configuration {
    status = "Disabled" # En prod: Enabled
  }
}
````

## File: terraform/modules/s3/outputs.tf
````hcl
output "bucket_name" {
  description = "Nombre del bucket S3"
  value       = aws_s3_bucket.images.id
}

output "bucket_arn" {
  description = "ARN del bucket S3"
  value       = aws_s3_bucket.images.arn
}

output "bucket_regional_domain_name" {
  description = "Domain name regional del bucket"
  value       = aws_s3_bucket.images.bucket_regional_domain_name
}
````

## File: terraform/modules/s3/variables.tf
````hcl
variable "environment" {
  description = "Entorno de despliegue"
  type        = string
}

variable "bucket_name" {
  description = "Nombre del bucket S3"
  type        = string
}
````

## File: terraform/modules/secrets/main.tf
````hcl
# Generar JWT Secret aleatorio
resource "random_password" "jwt_secret" {
  length  = 64
  special = true
}

# Secreto para JWT
resource "aws_secretsmanager_secret" "jwt" {
  name = "gpuchile/${var.environment}/jwt"
  
  tags = {
    Environment = var.environment
  }
}

resource "aws_secretsmanager_secret_version" "jwt" {
  secret_id = aws_secretsmanager_secret.jwt.id
  secret_string = jsonencode({
    secret = random_password.jwt_secret.result
  })
}

# Secreto para Redis (si lo usas en K8s como pod)
resource "aws_secretsmanager_secret" "redis" {
  name = "gpuchile/${var.environment}/redis"
  
  tags = {
    Environment = var.environment
  }
}

resource "aws_secretsmanager_secret_version" "redis" {
  secret_id = aws_secretsmanager_secret.redis.id
  secret_string = jsonencode({
    url = "redis://redis-service.default.svc.cluster.local:6379/0"
  })
}
````

## File: terraform/modules/secrets/outputs.tf
````hcl
output "jwt_secret_arn" {
  description = "ARN del secreto JWT"
  value       = aws_secretsmanager_secret.jwt.arn
}

output "redis_secret_arn" {
  description = "ARN del secreto Redis"
  value       = aws_secretsmanager_secret.redis.arn
}
````

## File: terraform/modules/secrets/variables.tf
````hcl
variable "environment" {
  description = "Entorno de despliegue"
  type        = string
}
````

## File: terraform/modules/vpc/main.tf
````hcl
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.1.2"

  name = "gpuchile-vpc-${var.environment}"
  cidr = var.vpc_cidr

  azs             = var.availability_zones
  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets

  # ⚠️ COST SAVING: NAT Gateway desactivado ($32/mes ahorro)
  enable_nat_gateway = false
  single_nat_gateway = false
  enable_vpn_gateway = false

  # Requisitos EKS
  enable_dns_hostnames = true
  enable_dns_support   = true

  # ⚠️ CRÍTICO: IP pública automática para nodos (ya que no hay NAT)
  map_public_ip_on_launch = true

  # Tags requeridos por AWS Load Balancer Controller
  public_subnet_tags = {
    "kubernetes.io/role/elb"                    = 1
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
  }

  private_subnet_tags = {
    "kubernetes.io/role/internal-elb"           = 1
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
  }

  tags = {
    Environment = var.environment
    Terraform   = "true"
    Project     = "GpuChile"
  }
}
````

## File: terraform/modules/vpc/outputs.tf
````hcl
output "vpc_id" {
  description = "El ID de la VPC creada"
  value       = module.vpc.vpc_id
}

output "private_subnets" {
  description = "Lista de IDs de las subnets privadas"
  value       = module.vpc.private_subnets
}

output "public_subnets" {
  description = "Lista de IDs de las subnets públicas"
  value       = module.vpc.public_subnets
}

output "vpc_cidr_block" {
  description = "El bloque CIDR de la VPC"
  value       = module.vpc.vpc_cidr_block
}
````

## File: terraform/modules/vpc/variables.tf
````hcl
variable "environment" {
  description = "Entorno de despliegue (dev, prod)"
  type        = string
}

variable "vpc_cidr" {
  description = "Bloque CIDR principal para la VPC"
  type        = string
}

variable "availability_zones" {
  description = "Lista de zonas de disponibilidad"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}

variable "private_subnets" {
  description = "Lista de CIDRs para subnets privadas"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "public_subnets" {
  description = "Lista de CIDRs para subnets públicas"
  type        = list(string)
  default     = ["10.0.101.0/24", "10.0.102.0/24"]
}

variable "cluster_name" {
  description = "Nombre del cluster (necesario para tags de EKS)"
  type        = string
}
````

## File: terraform/outputs.tf
````hcl
# terraform/outputs.tf

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "eks_cluster_endpoint" {
  value = module.eks.cluster_endpoint
}

output "eks_cluster_name" {
  value = module.eks.cluster_name
}

output "rds_endpoint" {
  value = module.rds.db_instance_endpoint
}

output "s3_bucket_name" {
  value = module.s3.bucket_name
}

output "lambda_function_name" {
  value = module.lambda.lambda_function_name
}

output "backend_service_account_role_arn" {
  description = "ARN del IAM Role para el backend Service Account"
  value       = module.backend_irsa.role_arn
}

output "jwt_secret_arn" {
  value = module.secrets.jwt_secret_arn
}

output "ecr_repositories" {
  description = "URLs de los repositorios ECR"
  value       = module.ecr.repository_urls
}

output "prometheus_role_arn" {
  value = module.monitoring.prometheus_role_arn
}
````

## File: terraform/variables.tf
````hcl
# terraform/variables.tf

variable "region" {
  description = "Región de AWS"
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "Entorno de despliegue"
  type        = string
  default     = "dev"
}

variable "vpc_cidr" {
  description = "CIDR block para la VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "cluster_name" {
  description = "Nombre del cluster EKS"
  type        = string
  default     = "gpuchile-cluster"
}
````

## File: apps/backend/app/config.py
````python
"""
🎯 QUÉ HACE: Centraliza todas las variables ENV
📍 CUÁNDO SE USA: Importado por main.py y services
"""
import os
from pydantic_settings import BaseSettings

class Settings(BaseSettings):
    # Database (de External Secrets en K8s)
    DATABASE_URL: str = os.getenv("DATABASE_URL", "postgresql://localhost/gpuchile_dev")
    
    # Redis (opcional para rate limiting)
    REDIS_URL: str = os.getenv("REDIS_URL", "redis://localhost:6379")
    
    # S3
    S3_BUCKET: str = os.getenv("S3_BUCKET", "gpuchile-images-prod")
    S3_REGION: str = os.getenv("AWS_REGION", "us-east-1")
    
    # JWT
    JWT_SECRET: str = os.getenv("JWT_SECRET", "dev-secret-change-in-prod")
    JWT_ALGORITHM: str = "HS256"
    JWT_EXPIRATION: int = 60 * 24 * 7  # 7 días
    
    # Rate Limiting
    RATE_LIMIT_ENABLED: bool = True
    
    class Config:
        env_file = ".env"

settings = Settings()
````

## File: apps/backend/app/main.py
````python
from fastapi import FastAPI, Request
from fastapi.middleware.cors import CORSMiddleware
from fastapi.responses import Response
from prometheus_client import Counter, Histogram, generate_latest
from sqlalchemy import text
from datetime import datetime
import time

from app.core.config import settings
from app.db.database import engine, Base, SessionLocal
from app.api.routes import gpus, auth, cart
# Importamos el cliente de redis que ya inicializaste en cart.py para chequear su salud
from app.api.routes.cart import redis_client 

# Crear tablas automáticamente al inicio (Para MVP/Portfolio)
Base.metadata.create_all(bind=engine)

# Inicializar FastAPI
app = FastAPI(
    title="GpuChile API",
    description="Production-grade GPU e-commerce API with EKS architecture",
    version="1.0.0",
    docs_url="/docs",
    redoc_url="/redoc"
)

# Configuración CORS (Crucial para que el Frontend hable con el Backend)
origins = [
    "http://localhost:5173",    # Frontend local (Vite)
    "http://127.0.0.1:5173",    # Frontend local alternativo
    "http://frontend:5173",     # Comunicación interna Docker
    "*"                         # Permitir todo (solo para dev/portfolio)
]

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# --- PROMETHEUS METRICS ---
request_count = Counter(
    'http_requests_total',
    'Total HTTP requests',
    ['method', 'endpoint', 'status']
)
request_duration = Histogram(
    'http_request_duration_seconds',
    'HTTP request duration',
    ['method', 'endpoint']
)

@app.middleware("http")
async def track_metrics(request: Request, call_next):
    start_time = time.time()
    response = await call_next(request)
    duration = time.time() - start_time
    
    # Ignorar métricas para healthchecks y metrics para no ensuciar grafana
    if request.url.path not in ["/health", "/metrics", "/healthz", "/readyz"]:
        request_count.labels(
            method=request.method,
            endpoint=request.url.path,
            status=response.status_code
        ).inc()
        
        request_duration.labels(
            method=request.method,
            endpoint=request.url.path
        ).observe(duration)
    
    return response

# --- RUTAS ---
app.include_router(gpus.router, prefix="/api/gpus", tags=["GPUs"])
app.include_router(auth.router, prefix="/api/auth", tags=["Authentication"])
app.include_router(cart.router, prefix="/api/cart", tags=["Cart"])

# --- SYSTEM ENDPOINTS ---

@app.get("/")
def root():
    return {
        "message": "Welcome to GpuChile API 🚀",
        "version": "1.0.0",
        "docs": "/docs",
        "environment": settings.ENVIRONMENT
    }

@app.get("/health", tags=["System"])
def health_check():
    """
    Health Check completo para Docker/Kubernetes.
    Verifica conectividad real con PostgreSQL y Redis.
    """
    # 1. Verificar PostgreSQL
    try:
        db = SessionLocal()
        db.execute(text("SELECT 1"))
        db.close()
        db_status = "healthy"
    except Exception as e:
        db_status = f"unhealthy: {str(e)}"
    
    # 2. Verificar Redis
    try:
        if redis_client:
            redis_client.ping()
            redis_status = "healthy"
        else:
            redis_status = "not configured"
    except Exception as e:
        redis_status = f"unhealthy: {str(e)}"
    
    status_code = 200 if db_status == "healthy" and redis_status == "healthy" else 503

    return {
        "status": "ok" if status_code == 200 else "error",
        "services": {
            "database": db_status,
            "redis": redis_status
        },
        "timestamp": datetime.utcnow().isoformat()
    }

@app.get("/metrics", tags=["System"])
def metrics():
    """Endpoint para que Prometheus haga scraping"""
    return Response(content=generate_latest(), media_type="text/plain")

@app.get("/healthz", tags=["System"])
def liveness():
    """K8s Liveness Probe (¿Estoy vivo?)"""
    return {"status": "alive"}

@app.get("/readyz", tags=["System"])
def readiness():
    """K8s Readiness Probe (¿Puedo recibir tráfico?)"""
    return {"status": "ready"}
````

## File: apps/backend/app/models/gpu.py
````python
from sqlalchemy import Column, Integer, String, Boolean, Float, Text, DateTime
from datetime import datetime
from app.db.database import Base

class GPU(Base):
    __tablename__ = "gpus"

    id = Column(Integer, primary_key=True, index=True)
    name = Column(String, index=True)
    brand = Column(String, index=True)
    model = Column(String, index=True)
    price = Column(Float)
    vram = Column(Integer)
    cuda_cores = Column(Integer, nullable=True)
    stock = Column(Integer, default=0)
    image_url = Column(String, nullable=True)
    description = Column(Text, nullable=True)
    is_featured = Column(Boolean, default=False)
    # ESTA ES LA LÍNEA QUE FALTABA Y CAUSABA EL ERROR SQL:
    created_at = Column(DateTime, default=datetime.utcnow)
````

## File: apps/backend/app/services/s3_service.py
````python
import boto3
import uuid
import os
from app.config import settings
from botocore.exceptions import NoCredentialsError


# Cliente S3 Singleton
s3_client = boto3.client(
    's3',
    aws_access_key_id=os.getenv("AWS_ACCESS_KEY_ID"),
    aws_secret_access_key=os.getenv("AWS_SECRET_ACCESS_KEY"),
    region_name=settings.S3_REGION
)

def upload_image(file_bytes: bytes, original_filename: str) -> str:
    """
    Sube bytes a S3 en la carpeta /original/ y retorna el Key único.
    """
    # 1. Generar nombre único: "rtx4090.jpg" -> "uuid-v4.jpg"
    ext = original_filename.split('.')[-1]
    unique_filename = f"{uuid.uuid4()}.{ext}"
    
    # 2. Definir ruta en S3 (Convention)
    s3_key = f"original/{unique_filename}"
    
    # 3. Subir
    try:
        s3_client.put_object(
            Bucket=settings.S3_BUCKET,
            Key=s3_key,
            Body=file_bytes,
            ContentType=f"image/{ext}"
        )
    except NoCredentialsError:
        # Fallback para desarrollo local si no hay AWS keys
        print("⚠️ [MOCK] No AWS Credentials. Simulando subida a S3.")
        return unique_filename
    except Exception as e:
        print(f"❌ Error S3: {e}")
        raise e

    # 4. Retornar SOLO el nombre del archivo (sin carpeta)
    # El modelo Pydantic construirá la URL completa
    return unique_filename
````

## File: apps/backend/requirements.txt
````
fastapi==0.109.0
uvicorn[standard]==0.27.0
sqlalchemy==2.0.25
psycopg2-binary==2.9.9
pydantic==2.5.3
pydantic-settings==2.1.0
python-jose[cryptography]==3.3.0
passlib[bcrypt]==1.7.4
python-multipart==0.0.6
redis==5.0.1
boto3==1.34.34
prometheus-client==0.19.0
python-dotenv==1.0.0
email-validator>=2.0.0
````

## File: apps/frontend/src/types/gpu.ts
````typescript
/**
 * Interfaz GPU basada en el modelo del backend
 * Debe coincidir con la respuesta de FastAPI
 */
export interface GPU {
  id: number;
  name: string;
  brand: string;
  model: string;
  price: number;
  stock: number;
  vram: number;
  cuda_cores: number | null;
  image_url: string | null;
  description: string | null;
  created_at: string; // ISO 8601 datetime
}

/**
 * Filtros para búsqueda de GPUs
 */
export interface GPUFilters {
  brand?: string;
  minPrice?: number;
  maxPrice?: number;
  minVram?: number;
}

/**
 * Query params para paginación
 */
export interface GPUQueryParams {
  skip?: number;
  limit?: number;
  brand?: string;
}
````

## File: docs/decisions/adr-002-lambda-convention.md
````markdown
# ADR-002: Convention Over Configuration para Imágenes

**Status**: ACCEPTED

**Context**:
Lambda necesita escribir URL de thumbnail en RDS. Esto requiere:
- Lambda en VPC (sin internet)
- NAT Gateway ($32 USD/mes)
- Total: Presupuesto reventado

**Decision**:
Lambda NO escribe en DB. Backend construye URLs por convención:
- Original: `s3://.../original/{image_key}`
- Thumbnail: `s3://.../thumbnails/{image_key}` (mismo nombre)

**Consequences**:
**Pros**:
- Costo $0 (Lambda sin VPC)
- Desacoplamiento (Lambda stateless)
- Idempotente (regenerar thumbnails sin DB)

**Contras**:
- Requiere convención documentada
- No puedes tener múltiples thumbnails con nombres diferentes

**References**:
- [12-Factor App: Build, Release, Run](https://12factor.net/build-release-run)
- AWS Lambda Best Practices
````

## File: helm/backend/templates/deployment.yaml
````yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: {{ include "gpuchile-backend.fullname" . }}
  labels:
    app: {{ include "gpuchile-backend.name" . }}
    version: {{ .Chart.AppVersion }}
spec:
  {{- if not .Values.autoscaling.enabled }}
  replicas: {{ .Values.replicaCount }}
  {{- end }}
  selector:
    matchLabels:
      app: {{ include "gpuchile-backend.name" . }}
  template:
    metadata:
      labels:
        app: {{ include "gpuchile-backend.name" . }}
        version: {{ .Chart.AppVersion }}
    spec:
      serviceAccountName: {{ .Values.serviceAccount.name }}
      containers:
      - name: backend
        image: "{{ .Values.image.repository }}:{{ .Values.image.tag }}"
        imagePullPolicy: {{ .Values.image.pullPolicy }}
        ports:
        - name: http
          containerPort: 8000
          protocol: TCP
        
        # Environment Variables (No sensibles)
        env:
        {{- range .Values.env }}
        - name: {{ .name }}
          value: {{ .value | quote }}
        {{- end }}
        
        # Secrets (Inyectados por External Secrets)
        envFrom:
        - secretRef:
            name: {{ .Values.externalSecrets.target.name }}
        
        # Health Checks
        livenessProbe:
          {{- toYaml .Values.livenessProbe | nindent 10 }}
        readinessProbe:
          {{- toYaml .Values.readinessProbe | nindent 10 }}
        
        # Resources
        resources:
          {{- toYaml .Values.resources | nindent 10 }}
````

## File: kubernetes/external-secrets/external-secret.yaml
````yaml
# 🎯 QUÉ HACE: Lee AWS Secrets Manager → Crea Secret de K8s
# 📍 CUÁNDO SE USA: Backend lo consume como ENV var
apiVersion: external-secrets.io/v1beta1
kind: ExternalSecret
metadata:
  name: gpuchile-db-credentials
  namespace: production
spec:
  refreshInterval: 1h  # Sincroniza cada hora
  secretStoreRef:
    name: aws-secrets-manager
    kind: SecretStore
  
  target:
    name: db-credentials  # ← Secret que usará el Pod
    creationPolicy: Owner
  
  data:
  - secretKey: DATABASE_URL  # Key en Secret de K8s
    remoteRef:
      key: gpuchile/prod/db  # Secret en AWS
      property: url  # Campo dentro del JSON
````

## File: kubernetes/external-secrets/secret-store.yaml
````yaml
apiVersion: external-secrets.io/v1beta1
kind: SecretStore
metadata:
  name: aws-secrets-store
  namespace: default
spec:
  provider:
    aws:
      service: SecretsManager
      region: us-east-1
      auth:
        jwt:
          serviceAccountRef:
            name: gpuchile-backend-sa
````

## File: kubernetes/providers.tf
````hcl
terraform {
  required_version = ">= 1.13.4"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}
````

## File: lambda/image-resizer/Dockerfile
````
# Usamos la imagen base de AWS para Python 3.11
FROM public.ecr.aws/lambda/python:3.11

# Copiamos requirements
COPY requirements.txt ${LAMBDA_TASK_ROOT}

# Instalamos dependencias en la carpeta del sistema
RUN pip install -r requirements.txt

# Copiamos el código de la función
COPY lambda_function.py ${LAMBDA_TASK_ROOT}

# El comando CMD se define en el Terraform o aquí
CMD [ "lambda_function.lambda_handler" ]
````

## File: lambda/image-resizer/lambda_function.py
````python
"""
🎯 QUÉ HACE: Redimensiona imágenes automáticamente
📍 CUÁNDO SE USA: Trigger cuando se sube a S3 /original/
🚫 NO TOCA LA BASE DE DATOS (Convention over Configuration)
"""
import boto3
import io
from PIL import Image
from urllib.parse import unquote_plus # 👈 IMPORTANTE: Para leer nombres con espacios

s3 = boto3.client('s3')

def lambda_handler(event, context):
    # Extraer info del evento S3 y decodificar el nombre (ej: "foto+1.jpg" -> "foto 1.jpg")
    bucket = event['Records'][0]['s3']['bucket']['name']
    key = unquote_plus(event['Records'][0]['s3']['object']['key'])
    
    # Solo procesar /original/
    if not key.startswith('original/'):
        print(f"Skipping: {key}")
        return {'statusCode': 200, 'body': 'Skipped'}
    
    try:
        # Descargar imagen original
        print(f"Downloading: {key}")
        obj = s3.get_object(Bucket=bucket, Key=key)
        img = Image.open(io.BytesIO(obj['Body'].read()))
        
        # ✅ Manejar PNGs transparentes (Evita fondo negro)
        if img.mode in ('RGBA', 'P', 'LA'):
            background = Image.new('RGB', img.size, (255, 255, 255))
            if img.mode == 'RGBA':
                background.paste(img, mask=img.split()[3])
            else:
                background.paste(img)
            img = background
        
        # Resize inteligente (Lanczos es el mejor filtro)
        img.thumbnail((400, 400), Image.Resampling.LANCZOS)
        
        # Guardar en buffer (Memoria RAM)
        buffer = io.BytesIO()
        img.save(buffer, format='JPEG', quality=85, optimize=True)
        buffer.seek(0)
        
        # ✅ Guardar en /thumbnails/ con MISMO NOMBRE
        thumb_key = key.replace('original/', 'thumbnails/')
        
        print(f"Uploading to: {thumb_key}")
        s3.put_object(
            Bucket=bucket,
            Key=thumb_key,
            Body=buffer.getvalue(),
            ContentType='image/jpeg',
            CacheControl='max-age=31536000'  # 1 año
        )
        
        return {'statusCode': 200, 'body': f'Created {thumb_key}'}
        
    except Exception as e:
        print(f"Error processing {key}: {str(e)}")
        raise e
````

## File: Makefile
````makefile
.PHONY: help build up down logs clean seed test

# Variables
COMPOSE=docker-compose
BACKEND_CONTAINER=gpuchile_backend
FRONTEND_CONTAINER=gpuchile_frontend
DB_CONTAINER=gpuchile_postgres

help: ## Muestra esta ayuda
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

build: ## Construye las imágenes
	$(COMPOSE) build

up: ## Levanta todos los servicios
	$(COMPOSE) up -d

down: ## Detiene todos los servicios
	$(COMPOSE) down

logs: ## Muestra logs de todos los servicios
	$(COMPOSE) logs -f

logs-backend: ## Logs del backend
	$(COMPOSE) logs -f backend

logs-frontend: ## Logs del frontend
	$(COMPOSE) logs -f frontend

restart: down up ## Reinicia todos los servicios

clean: ## Limpia containers, volumes y cache
	$(COMPOSE) down -v
	docker system prune -f

seed: ## Ejecuta el seed de datos (solo si backend está corriendo)
	$(COMPOSE) exec backend python -m app.seed_data

shell-backend: ## Shell interactivo en el backend
	$(COMPOSE) exec backend /bin/bash

shell-db: ## Accede a psql
	$(COMPOSE) exec db psql -U postgres -d gpuchile

shell-redis: ## Accede a redis-cli
	$(COMPOSE) exec redis redis-cli -a redis123

test-backend: ## Ejecuta tests del backend
	$(COMPOSE) exec backend pytest

ps: ## Muestra estado de los servicios
	$(COMPOSE) ps

health: ## Verifica salud de los servicios
	@echo "🔍 Verificando servicios..."
	@curl -s http://localhost:8000/health | jq || echo "❌ Backend no responde"
	@curl -s http://localhost:5173 > /dev/null && echo "✅ Frontend OK" || echo "❌ Frontend no responde"

rebuild: clean build up ## Reconstruye todo desde cero
````

## File: .gitignore
````
# Environment variables
.env
.env.local
.env.*.local

# Docker
docker-compose.override.yml

# Python
__pycache__/
*.py[cod]
*$py.class
*.so
.Python
venv/
env/
ENV/

# Node
node_modules/
dist/
.cache/

# IDE
.vscode/
.idea/
*.swp
*.swo

# OS
.DS_Store
Thumbs.db

# Logs
*.log
logs/

# Database
*.db
*.sqlite3
````
