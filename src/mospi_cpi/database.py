"""Database helpers for the MoSPI CPI pipeline."""

from __future__ import annotations

import os
from sqlalchemy import create_engine
from sqlalchemy.engine import Engine


def get_engine(database_url: str | None = None) -> Engine:
    """Create a SQLAlchemy engine from an explicit URL or DATABASE_URL."""
    url = database_url or os.getenv("DATABASE_URL")
    if not url:
        raise RuntimeError("DATABASE_URL is not set. Configure it before connecting.")
    return create_engine(url, pool_pre_ping=True)
