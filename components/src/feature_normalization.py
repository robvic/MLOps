from typing import NamedTuple
import pandas as pd
from sklearn.preprocessing import StandardScaler
from kfp.v2.dsl import component, Dataset

class Outputs(NamedTuple):
    normalized_dataframe: pd.DataFrame

@component(
    packages_to_install=["pandas", "scikit-learn"],
)
def feature_normalization(
    input_dataframe: Dataset,
) -> Outputs:
    """
    Normaliza as características de um DataFrame usando StandardScaler.
    
    Args:
        input_dataframe (Dataset): DataFrame de entrada.
    
    Returns:
        Outputs: DataFrame normalizado.
    """
    df = pd.read_csv(input_dataframe.path)
    
    scaler = StandardScaler()
    normalized_data = scaler.fit_transform(df)
    
    normalized_df = pd.DataFrame(normalized_data, columns=df.columns)
    
    return Outputs(normalized_dataframe=normalized_df)