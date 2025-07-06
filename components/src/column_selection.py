from typing import NamedTuple
import pandas as pd
from kfp.v2.dsl import component, Dataset

class Outputs(NamedTuple):
    sliced_dataframe: pd.DataFrame

@component(
    packages_to_install=["pandas"],
)
def column_selection(
    input_dataframe: Dataset,
    columns: list[str],
) -> Outputs:
    """
    Seleciona colunas específicas de um DataFrame.
    
    Args:
        input_dataframe (Dataset): DataFrame de entrada.
        columns (list[str]): Lista de nomes das colunas a serem selecionadas.
    
    Returns:
        Outputs: DataFrame contendo apenas as colunas selecionadas.
    """
    df = pd.read_csv(input_dataframe.path)
    sliced_df = df[columns]
    return Outputs(sliced_dataframe=sliced_df)