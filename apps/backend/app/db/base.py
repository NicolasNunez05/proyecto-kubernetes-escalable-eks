# apps/backend/app/db/base.py
from sqlalchemy.orm import declarative_base  # ✅ Forma moderna (SQLAlchemy 1.4/2.0)

Base = declarative_base()
