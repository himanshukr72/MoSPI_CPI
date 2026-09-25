import pandas as pd
import pytest

from mospi_cpi.cleaning import clean_cpi_frame


def test_clean_cpi_frame_converts_numeric_and_strips_strings():
    raw = pd.DataFrame(
        {
            "BYear": ["2012"],
            "Year_i": ["2024"],
            "Month_i": [" January "],
            "State_i": [" All India "],
            "Sector": ["Combined"],
            "Group_i": ["Food and Beverages"],
            "SubGroup": [" Vegetables "],
            "Index_i": ["258.3"],
            "Inflation": ["26.56"],
        }
    )

    cleaned = clean_cpi_frame(raw)

    assert cleaned.loc[0, "Year_i"] == 2024
    assert cleaned.loc[0, "Month_i"] == "January"
    assert cleaned.loc[0, "State_i"] == "All India"
    assert cleaned.loc[0, "Index_i"] == 258.3
    assert cleaned.loc[0, "Inflation"] == 26.56


def test_clean_cpi_frame_drops_missing_required_values():
    raw = pd.DataFrame(
        {
            "Year_i": [2024, None],
            "Index_i": [100, 101],
            "Inflation": [5.0, None],
        }
    )

    cleaned = clean_cpi_frame(raw)

    assert len(cleaned) == 1
