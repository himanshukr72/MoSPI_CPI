"""Reusable cleaning utilities for CPI data."""

from __future__ import annotations
import pandas as pd

STRING_COLUMNS = ["Month_i", "State_i", "Sector", "Group_i", "SubGroup"]


def clean_cpi_frame(df: pd.DataFrame) -> pd.DataFrame:
    """Return a cleaned CPI dataframe without mutating the input."""
    out = df.copy()
    for column in ["BYear", "Year_i", "Index_i", "Inflation"]:
        if column in out.columns:
            out[column] = pd.to_numeric(out[column], errors="coerce")
    for column in STRING_COLUMNS:
        if column in out.columns:
            out[column] = out[column].astype("string").str.strip()
    required = [c for c in ["Year_i", "Index_i", "Inflation"] if c in out.columns]
    if required:
        out = out.dropna(subset=required)
    return out.reset_index(drop=True)
