from typing import NamedTuple
from google.cloud import bigquery
import pandas as pd
from kfp.v2.dsl import component

class Outputs(NamedTuple):
    output_dataframe: pd.DataFrame

@component(
    packages_to_install=["google-cloud-bigquery", "pandas"],
)
def bq_to_df(
    project_id: str,
    dataset_id: str,
    table_id: str,
) -> Outputs:
    """
    Lê tabela do BigQuery e retorna um DataFrame do Pandas.
    """
    client = bigquery.Client(project=project_id)
    table_ref = f"{project_id}.{dataset_id}.{table_id}"
    df = client.query(f"SELECT * FROM `{table_ref}`").to_dataframe()
    return Outputs(df)